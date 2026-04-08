import os
import zipfile
import cv2
import torch
from ultralytics import YOLO
from tkinter import filedialog, Tk

def iniciar_projeto():
    # --- 1. CONFIGURAÇÕES DE CAMINHOS ---
    DATASET_ZIP = 'test.zip'  
    EXTRACT_PATH = './dataset' 
    CONFIG_YAML = 'comida.yaml' 

    # --- 2. PREPARAÇÃO DO DATASET ---
    if not os.path.exists(EXTRACT_PATH):
        if os.path.exists(DATASET_ZIP):
            print("Extraindo dataset... aguarde.")
            with zipfile.ZipFile(DATASET_ZIP, 'r') as zip_ref:
                zip_ref.extractall(EXTRACT_PATH)
            print(f"Dataset extraído em: {EXTRACT_PATH}")
        else:
            print("Aviso: test.zip não encontrado na pasta atual.")
    else:
        print("Dataset já extraído. Pulando etapa de descompactação.")

    # --- 3. TREINAMENTO (COM GPU ATIVA) ---
    # Carrega o modelo 'Small' (yolov8s.pt)
    model = YOLO('yolov8s.pt')

    print("\nIniciando treinamento na GPU...")
    model.train(
        data=CONFIG_YAML, 
        epochs=100, 
        imgsz=640, 
        device=0,      
        batch=4,        # Reduzido drasticamente (de 16 para 4)
        workers=2,      # Menos processos paralelos carregando imagens
        amp=False,      # Desativa precisão mista se a GPU for antiga/instável
        name='treino_melhorado',
        exist_ok=True  
    )

    # --- 4. VALIDAÇÃO ---
    weights_path = 'runs/detect/treino_melhorado/weights/best.pt'

    if os.path.exists(weights_path):
        model = YOLO(weights_path)
        print("\nRodando validação final...")
        metrics = model.val(device=0)

        print("\n" + "="*30)
        print(f"RESUMO DAS MÉTRICAS:")
        print(f"mAP50: {metrics.results_dict['metrics/mAP50(B)']:.4f}")
        print("="*30)

        # --- 5. TESTE PRÁTICO ---
        print("\nSelecione uma foto (Arroz, Carne ou Milho) para testar...")
        
        root = Tk()
        root.withdraw()
        root.attributes("-topmost", True) # Faz a janela aparecer na frente de tudo
        file_path = filedialog.askopenfilename()
        root.destroy()

        if file_path:
            # conf=0.3 conforme solicitado
            results = model.predict(source=file_path, conf=0.3, device=0)
            
            res_plotted = results[0].plot()
            cv2.imshow("Predicao YOLO - Pressione qualquer tecla para sair", res_plotted)
            cv2.waitKey(0) 
            cv2.destroyAllWindows()
    else:
        print(f"Erro: Pesos nao encontrados. O treino pode nao ter sido concluido.")

# Isso aqui é essencial para rodar no Windows sem erros!
if __name__ == '__main__':
    iniciar_projeto()