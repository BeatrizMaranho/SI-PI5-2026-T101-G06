import cv2
from ultralytics import YOLO
import numpy as np
import os
from tkinter import filedialog, Tk

weights_path = 'runs/segment/treino_comida_seg/weights/best.pt'
model = YOLO(weights_path)

def selecionar_arquivo(mensagem):
    root = Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    path = filedialog.askopenfilename(title=mensagem)
    root.destroy()
    return path

def obter_dados_segmentacao(img_path):
    img = cv2.imread(img_path)
    if img is None:
        return {}, None
        
    img_padronizada = cv2.resize(img, (640, 640))
    
    results = model.predict(source=img_padronizada, conf=0.30, verbose=False)
    relatorio_pixels = {}
    img_renderizada = results[0].plot()

    if results[0].masks is not None:
        masks = results[0].masks.data.cpu().numpy()
        classes = results[0].boxes.cls.cpu().numpy()
        
        for mask, cls_idx in zip(masks, classes):
            nome_classe = model.names[int(cls_idx)]
            contagem = np.count_nonzero(mask > 0.5)
            relatorio_pixels[nome_classe] = relatorio_pixels.get(nome_classe, 0) + contagem
            
    return relatorio_pixels, img_renderizada

def executar_analise():
    path_antes = selecionar_arquivo("Selecione a foto do PRATO ANTES de comer")
    path_depois = selecionar_arquivo("Selecione a foto do PRATO DEPOIS de comer")

    if not path_antes or not path_depois:
        print("Seleção cancelada.")
        return

    print("Analisando imagens... aguarde.")
    pixels_antes, plot_antes = obter_dados_segmentacao(path_antes)
    pixels_depois, plot_depois = obter_dados_segmentacao(path_depois)

    todas_classes = sorted(set(list(pixels_antes.keys()) + list(pixels_depois.keys())))

    print("\n" + "="*95)
    print(f"{'ALIMENTO':<18} | {'INICIAL (px)':<12} | {'SOBRA (px)':<12} | {'CONSUMIDO %':<12} | {'SOBRA %'}")
    print("-" * 95)

    for item in todas_classes:
        p_antes = pixels_antes.get(item, 0)
        p_depois = pixels_depois.get(item, 0)

        if p_antes > 0:
            consumido = max(0, p_antes - p_depois)
            porc_consumido = (consumido / p_antes) * 100
            
            if porc_consumido > 98: porc_consumido = 100.0
            
            porc_sobra = 100.0 - porc_consumido
        else:
            porc_consumido = 0.0
            porc_sobra = 0.0

        print(f"{item:<18} | {p_antes:<12} | {p_depois:<12} | {porc_consumido:>10.2f}% | {porc_sobra:>7.2f}%")

    print("="*95)
    print("Nota: 100% de consumo significa que o alimento foi totalmente ingerido.")

    h, w = 600, 600
    antes_res = cv2.resize(plot_antes, (w, h))
    depois_res = cv2.resize(plot_depois, (w, h))
    
    comparativo = np.hstack((antes_res, depois_res))
    
    cv2.putText(comparativo, "ANTES", (20, 40), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,255,0), 2)
    cv2.putText(comparativo, "DEPOIS", (w + 20, 40), cv2.FONT_HERSHEY_SIMPLEX, 1, (0,0,255), 2)

    cv2.imshow("Comparativo de Consumo", comparativo)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

if __name__ == '__main__':
    executar_analise()