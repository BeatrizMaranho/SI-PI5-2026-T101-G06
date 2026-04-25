from fastapi import FastAPI, File, UploadFile
from typing import List 
from fastapi.middleware.cors import CORSMiddleware
from ultralytics import YOLO
import io
from PIL import Image

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Carrega o modelo (Ajuste o caminho se necessário)
weights_path = r'C:\Users\anabe\FoodSegmentation\SI-PI5-2026-T101-G06\V3\runs\detect\treino_melhorado\weights\best.pt'
model = YOLO(weights_path)

@app.get("/")
def home():
    return {"status": "API Appetit Online"}

@app.post("/analisar")
async def analisar_refeicao(
    file_antes: UploadFile = File(...), 
    file_depois: UploadFile = File(...)
):
    # 1. Processar Imagem ANTES
    content_antes = await file_antes.read()
    img_antes = Image.open(io.BytesIO(content_antes))
    res_antes = model.predict(source=img_antes, conf=0.3)

    # 2. Processar Imagem DEPOIS
    content_depois = await file_depois.read()
    img_depois = Image.open(io.BytesIO(content_depois))
    res_depois = model.predict(source=img_depois, conf=0.3)

    # 3. Extrair listas (O restante da sua lógica está correta!)
    itens_antes = [model.names[int(box.cls)] for r in res_antes for box in r.boxes]
    itens_depois = [model.names[int(box.cls)] for r in res_depois for box in r.boxes]

    consumido = []
    temp_depois = itens_depois.copy()
    for item in itens_antes:
        if item in temp_depois:
            temp_depois.remove(item)
        else:
            consumido.append(item)

    return {
        "crianca": "Sofia",
        "detalhes": {
            "oferecido": itens_antes,
            "sobras": itens_depois,
            "consumido": consumido
        },
        "analise": [{"item": i, "precisao": 100.0} for i in consumido], # Para não quebrar o Dialog do Flutter
        "mensagem": "Análise comparativa concluída!"
    }