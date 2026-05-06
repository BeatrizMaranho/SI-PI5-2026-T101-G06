from fastapi import FastAPI, File, UploadFile, Form
from fastapi.middleware.cors import CORSMiddleware
from ultralytics import YOLO
import io
import numpy as np
from PIL import Image
import cv2
import os
import httpx  # Importante: pip install httpx

# 🔥 Firebase Admin (Opcional se usar apenas Data Connect nesta rota)
import firebase_admin
from firebase_admin import credentials, firestore

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- 🚀 CONFIGURAÇÕES ---
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# URL do Firebase Data Connect (Ajuste para produção se necessário)
# Se estiver usando o emulador local, a porta padrão é 9399
DATA_CONNECT_URL = "http://127.0.0.1:9399/graphql/endpoints/pi-v-appetit-service" 

# Setup Firebase Admin
cred_path = os.path.join(BASE_DIR, "serviceAccountKey.json")
if os.path.exists(cred_path):
    cred = credentials.Certificate(cred_path)
    if not firebase_admin._apps:
        firebase_admin.initialize_app(cred)
    db = firestore.client()

# --- 🧠 MODELO YOLO ---
# Caminho ajustado para o seu peso de segmentação
weights_path = os.path.join(BASE_DIR, '..', '..', 'V7', 'runs', 'segment', 'treino_comida_seg', 'weights', 'best.pt')
model = YOLO(weights_path)

def obter_dados_segmentacao(pil_image):
    img = cv2.cvtColor(np.array(pil_image), cv2.COLOR_RGB2BGR)
    img_padronizada = cv2.resize(img, (640, 640))
    results = model.predict(source=img_padronizada, conf=0.30, verbose=False)

    relatorio_pixels = {}

    if results[0].masks is not None:
        masks = results[0].masks.data.cpu().numpy()
        classes = results[0].boxes.cls.cpu().numpy()

        for mask, cls_idx in zip(masks, classes):
            nome_classe = model.names[int(cls_idx)]
            contagem = np.count_nonzero(mask > 0.5)
            relatorio_pixels[nome_classe] = relatorio_pixels.get(nome_classe, 0) + contagem

    return relatorio_pixels

# --- ✅ ROTA: LISTAR PACIENTES (DATA CONNECT) ---
@app.get("/pacientes/{responsavel_id}")
async def listar_pacientes(responsavel_id: str):
    # Ajustado para usar o plural 'pacientes' e filtro 'eq' conforme o Data Connect
    query = """
    query ListPacientes($responsavelId: String!) {
      pacientes(where: { responsavelId: { eq: $responsavelId } }) {
        id
        nome
        responsavelId
        peso
        alergias
        nascimento
      }
    }
    """

    variables = {
        "responsavelId": responsavel_id
    }

    async with httpx.AsyncClient() as client:
        try:
            response = await client.post(
                DATA_CONNECT_URL,
                json={
                    "query": query,
                    "variables": variables
                },
                timeout=5.0
            )
            response.raise_for_status()
            data = response.json()
            print(f"DEBUG DATA CONNECT: {data}")
            if "data" in data and data["data"] and "pacientes" in data["data"]:
                return data["data"]["pacientes"]
            
        except Exception as e:
            print(f" Erro Data Connect: {e}")
            # IMPORTANTE: Retornar uma lista vazia [] em vez de um dicionário de erro
            # Isso evita o erro de tipagem no Flutter
            return []

# --- 📸 ROTA: ANÁLISE DE REFEIÇÃO ---
@app.post("/analisar")
async def analisar_refeicao(
    file_antes: UploadFile = File(...), 
    file_depois: UploadFile = File(...),
    nome_crianca: str = Form(...)
):
    img_antes = Image.open(io.BytesIO(await file_antes.read()))
    img_depois = Image.open(io.BytesIO(await file_depois.read()))

    pixels_antes = obter_dados_segmentacao(img_antes)
    pixels_depois = obter_dados_segmentacao(img_depois)

    todas_classes = set(list(pixels_antes.keys()) + list(pixels_depois.keys()))

    lista_analise = []

    for item in todas_classes:
        p_antes = pixels_antes.get(item, 0)
        p_depois = pixels_depois.get(item, 0)

        # Cálculo da porcentagem consumida baseado na área de pixels
        if p_antes > 0:
            porc = (max(0, p_antes - p_depois) / p_antes * 100)
        else:
            porc = 0.0

        lista_analise.append({
            "alimento": item,
            "porcentagem_consumida": round(porc, 2)
        })

    return {
        "paciente": nome_crianca,
        "analise": lista_analise,
        "status": "sucesso"
    }

if __name__ == "__main__":
    import uvicorn
    # Mude para 0.0.0.0 para garantir que o Windows não bloqueie a rota
    uvicorn.run(app, host="0.0.0.0", port=8000)