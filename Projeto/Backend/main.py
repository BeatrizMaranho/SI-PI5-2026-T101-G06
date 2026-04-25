from fastapi import FastAPI, File, UploadFile
from fastapi.middleware.cors import CORSMiddleware # Para permitir requisições do Flutter via Python
from ultralytics import YOLO
import io
from PIL import Image

app = FastAPI()

# Configura o CORS para permitir que o Flutter acesse a API sem problemas de segurança (são duas portas diferentes: Flutter na 8080 e FastAPI na 8000)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # Permite que qualquer origem (seu app Flutter) acesse
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Carrega o modelo uma única vez quando a API inicia (mais rápido)
weights_path = 'V3/runs/detect/treino_melhorado/weights/best.pt' #Caminho relativo para o modelo treinado em V3
model = YOLO(weights_path)

@app.get("/")
def home():
    return {"status": "API Appetit Online"}

@app.post("/analisar")
async def analisar_refeicao(file: UploadFile = File(...)):
    # 1. Ler a imagem enviada pelo Flutter
    contents = await file.read()
    image = Image.open(io.BytesIO(contents))

    # 2. Rodar o YOLO (o mesmo comando que você já usa)
    results = model.predict(source=image, conf=0.3)
    
    # 3. Extrair o que a IA encontrou
    deteccoes = []
    for r in results:
        for box in r.boxes:
            nome_classe = model.names[int(box.cls)]
            confianca = float(box.conf)
            deteccoes.append({
                "item": nome_classe,
                "precisao": round(confianca * 100, 2)
            })

    # 4. Retornar os dados para o App
    return {
        "crianca": "Sofia", # Depois pegamos isso do Flutter
        "analise": deteccoes,
        "mensagem": "Análise concluída com sucesso!"
    }