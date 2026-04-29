from fastapi import FastAPI, File, UploadFile, Form
from fastapi.middleware.cors import CORSMiddleware
from ultralytics import YOLO
import io
import numpy as np
from PIL import Image
import cv2

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Caminho para o NOVO peso da V7 (Segmentação)
weights_path = r'C:\Users\anabe\FoodSegmentation\SI-PI5-2026-T101-G06\V7\runs\segment\treino_comida_seg\weights\best.pt'
model = YOLO(weights_path)

def obter_dados_segmentacao(pil_image):
    # Converte PIL para formato OpenCV (numpy array)
    img = cv2.cvtColor(np.array(pil_image), cv2.COLOR_RGB2BGR)
    img_padronizada = cv2.resize(img, (640, 640))
    
    results = model.predict(source=img_padronizada, conf=0.30, verbose=False)
    relatorio_pixels = {}

    if results[0].masks is not None:
        masks = results[0].masks.data.cpu().numpy()
        classes = results[0].boxes.cls.cpu().numpy()
        
        for mask, cls_idx in zip(masks, classes):
            nome_classe = model.names[int(cls_idx)]
            # Redimensiona a máscara para o tamanho original se necessário, 
            # mas contar no 640x640 já dá a proporção correta
            contagem = np.count_nonzero(mask > 0.5)
            relatorio_pixels[nome_classe] = relatorio_pixels.get(nome_classe, 0) + contagem
            
    return relatorio_pixels

@app.post("/analisar")
async def analisar_refeicao(
    file_antes: UploadFile = File(...), 
    file_depois: UploadFile = File(...),
    nome_crianca: str = Form("Sofia") # Recebe o nome do Flutter
):
    # 1. Ler imagens enviadas pelo Flutter
    img_antes = Image.open(io.BytesIO(await file_antes.read()))
    img_depois = Image.open(io.BytesIO(await file_depois.read()))

    # 2. Obter contagem de pixels por classe (Lógica V7)
    pixels_antes = obter_dados_segmentacao(img_antes)
    pixels_depois = obter_dados_segmentacao(img_depois)

    # 3. Processar Comparação
    todas_classes = set(list(pixels_antes.keys()) + list(pixels_depois.keys()))
    lista_analise = []
    itens_consumidos_nomes = []

    for item in todas_classes:
        p_antes = pixels_antes.get(item, 0)
        p_depois = pixels_depois.get(item, 0)

        if p_antes > 0:
            consumido_px = max(0, p_antes - p_depois)
            porc_consumido = (consumido_px / p_antes) * 100
            if porc_consumido > 98: porc_consumido = 100.0
        else:
            porc_consumido = 0.0

        # Só adiciona na lista de "consumidos" se houve algum consumo real
        if porc_consumido > 5: 
            itens_consumidos_nomes.append(item)

        lista_analise.append({
            "item": item,
            "porcentagem_consumida": round(porc_consumido, 2),
            "status": "Totalmente consumido" if porc_consumido == 100 else f"{round(porc_consumido, 1)}% consumido"
        })

    return {
        "crianca": "Sofia", # Aqui você pode receber o nome do Flutter se desejar
        "detalhes": {
            "oferecido": list(pixels_antes.keys()),
            "sobras": list(pixels_depois.keys()),
            "consumido": itens_consumidos_nomes
        },
        "analise": lista_analise, 
        "mensagem": "Análise de segmentação concluída com sucesso!"
    }