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
    CONFIG_YAML = os.path.join(EXTRACT_PATH, 'data.yaml') 

    # --- 2. PREPARAÇÃO DO DATASET ---
    if not os.path.exists(EXTRACT_PATH):
        if os.path.exists(DATASET_ZIP):
            print("Extraindo dataset... aguarde.")
            with zipfile.ZipFile(DATASET_ZIP, 'r') as zip_ref:
                zip_ref.extractall(EXTRACT_PATH)
            print(f"Dataset extraído em: {EXTRACT_PATH}")
        else:
            print(f"Aviso: {DATASET_ZIP} não encontrado.")
    else:
        print("Dataset já extraído.")

    # --- 3. TREINAMENTO (MUDANÇA PARA SEGMENTAÇÃO) ---
    # AJUSTE 1: Usar o modelo de segmentação 'yolov8s-seg.pt'
    model = YOLO('yolov8s-seg.pt') 

    print("\nIniciando treinamento de SEGMENTAÇÃO...")
    model.train(
        data=CONFIG_YAML, 
        epochs=100, 
        imgsz=432, 
        device=0, 
        batch=4, 
        workers=2,
        amp=True, 
        name='treino_comida_seg', # Nome da pasta mudado para organizar
        exist_ok=True  
    )

    # --- 4. VALIDAÇÃO ---
    # AJUSTE 2: O caminho agora reflete a nova pasta de treino
    weights_path = 'runs/segment/treino_comida_seg/weights/best.pt'

    if os.path.exists(weights_path):
        model = YOLO(weights_path)
        print("\nRodando validação final...")
        metrics = model.val()

        print("\n" + "="*30)
        print(f"RESUMO DAS MÉTRICAS (SEGMENTAÇÃO):")
        # AJUSTE 3: Para segmentação, olhamos o mAP da Máscara (mask)
        print(f"mAP50 (Box): {metrics.results_dict['metrics/mAP50(B)']:.4f}")
        print(f"mAP50 (Mask): {metrics.results_dict['metrics/mAP50(M)']:.4f}")
        print("="*30)

        # --- 5. TESTE PRÁTICO ---
        print("\nSelecione uma foto para testar a segmentação...")
        root = Tk(); root.withdraw(); root.attributes("-topmost", True)
        file_path = filedialog.askopenfilename(); root.destroy()

        if file_path:
            results = model.predict(source=file_path, conf=0.3)
            
            # O plot() agora vai desenhar as máscaras coloridas sobre a comida
            res_plotted = results[0].plot()
            cv2.imshow("Segmentacao YOLO - Pressione tecla para fechar", res_plotted)
            cv2.waitKey(0) 
            cv2.destroyAllWindows()
    else:
        print(f"Erro: O arquivo de pesos não foi gerado.")

if __name__ == '__main__':
    iniciar_projeto()