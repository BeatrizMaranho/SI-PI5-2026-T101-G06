import os
import zipfile
import cv2
import torch
from ultralytics import YOLO
from tkinter import filedialog, Tk

def iniciar_projeto():
    DATASET_ZIP = 'test.zip'  
    EXTRACT_PATH = './dataset' 
    CONFIG_YAML = os.path.join(EXTRACT_PATH, 'data.yaml') 

    if not os.path.exists(EXTRACT_PATH):
        if os.path.exists(DATASET_ZIP):
            print("Extraindo dataset... aguarde.")
            with zipfile.ZipFile(DATASET_ZIP, 'r') as zip_ref:
                zip_ref.extractall(EXTRACT_PATH)
            print(f"Dataset extraído em: {EXTRACT_PATH}")
        else:
            print(f"ERRO: O arquivo {DATASET_ZIP} não foi encontrado na pasta do script.")
            return

    model = YOLO('yolov8s-seg.pt') 

    print("\nIniciando treinamento de SEGMENTAÇÃO")
    model.train(
        data=CONFIG_YAML, 
        epochs=100, 
        imgsz=432, 
        device=0, 
        batch=4, 
        workers=2,
        amp=False, 
        name='treino_comida_seg',
        exist_ok=True  
    )

    weights_path = 'runs/segment/treino_comida_seg/weights/best.pt'

    if os.path.exists(weights_path):
        model = YOLO(weights_path)
        print("\nRodando validação final...")
        metrics = model.val()

        print("\n" + "="*60)
        print(f"RESUMO DAS MÉTRICAS DE SEGMENTAÇÃO:")
        print("="*60)
        if 'metrics/mAP50(M)' in metrics.results_dict:
            print(f"mAP50 (Mask): {metrics.results_dict['metrics/mAP50(M)']:.4f}")
        if 'metrics/mAP50-95(M)' in metrics.results_dict:
            print(f"mAP50-95 (Mask): {metrics.results_dict['metrics/mAP50-95(M)']:.4f}")
        print("="*60)

        print("\n" + "="*60)
        print("PRECISION E RECALL POR CLASSE (SEGMENTAÇÃO):")
        print("="*60)
        
        if hasattr(metrics, 'mask'):
            print(f"\nPrecision média: {metrics.mask.p.mean():.4f}")
            print(f"Recall média: {metrics.mask.r.mean():.4f}")
            print("\nDetalhes por classe:")
            for i, class_name in enumerate(metrics.names.values()):
                print(f"\n  {class_name}:")
                print(f"    Precision: {metrics.mask.p[i]:.4f}")
                print(f"    Recall: {metrics.mask.r[i]:.4f}")
        print("="*60)

        print("\nSelecione uma foto para testar a segmentação...")
        root = Tk(); root.withdraw(); root.attributes("-topmost", True)
        file_path = filedialog.askopenfilename(); root.destroy()

        if file_path:
            results = model.predict(source=file_path, conf=0.3)
            res_plotted = results[0].plot()
            cv2.imshow("Segmentacao YOLO - Pressione tecla para fechar", res_plotted)
            cv2.waitKey(0) 
            cv2.destroyAllWindows()
    else:
        print(f"Erro: O arquivo de pesos não foi gerado em {weights_path}")

if __name__ == '__main__':
    iniciar_projeto()