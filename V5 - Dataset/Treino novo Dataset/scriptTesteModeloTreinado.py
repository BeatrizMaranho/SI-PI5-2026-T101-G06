import cv2
from ultralytics import YOLO
import numpy as np
import os
from tkinter import filedialog, Tk

# 1. CONFIGURAÇÃO DO MODELO
# Certifique-se de apontar para o novo treino de segmentação (-seg)
weights_path = 'runs/segment/treino_comida_seg/weights/best.pt'

if not os.path.exists(weights_path):
    print(f"⚠️ Aviso: Pesos de segmentação não encontrados em {weights_path}")
    print("Verifique se o treino terminou ou se a pasta se chama 'treino_comida_seg'.")

model = YOLO(weights_path)

def selecionar_arquivo(mensagem):
    print(mensagem)
    root = Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    path = filedialog.askopenfilename(title=mensagem)
    root.destroy()
    return path

def limpar_fundo_para_ia(img_path):
    img = cv2.imread(img_path)
    if img is None: return None
    
    # Converte para escala de cinza e suaviza
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    blurred = cv2.GaussianBlur(gray, (7, 7), 0)
    
    # Cria uma máscara: tudo que é escuro (mesa/sombras) vira preto puro
    # O valor 100 pode ser ajustado: menor = mais fundo mantido, maior = mais preto
    _, mask = cv2.threshold(blurred, 100, 255, cv2.THRESH_BINARY)
    
    img_preparada = img.copy()
    img_preparada[mask == 0] = [0, 0, 0] # Pinta o fundo de preto
    
    return img_preparada

def obter_pixels_por_classe(img_path):
    # Remova a limpeza de fundo se ela estiver estragando a detecção
    results = model.predict(source=img_path, conf=0.25, verbose=False) 
    relatorio_pixels = {}

    if results[0].masks is not None:
        masks = results[0].masks.data.cpu().numpy() 
        classes = results[0].boxes.cls.cpu().numpy()
        scores = results[0].boxes.conf.cpu().numpy() # Pega a confiança
        orig_shape = results[0].orig_shape 

        for mask, cls_idx, conf in zip(masks, classes, scores):
            # FILTRO: Só aceita a detecção se a confiança for razoável
            # Isso evita que o modelo identifique "tomate" dentro do feijão
            if conf < 0.30: 
                continue
                
            nome_classe = model.names[int(cls_idx)]
            mask_resized = cv2.resize(mask, (orig_shape[1], orig_shape[0]))
            contagem = np.count_nonzero(mask_resized > 0.5)
            
            relatorio_pixels[nome_classe] = relatorio_pixels.get(nome_classe, 0) + contagem
            
    return relatorio_pixels, results[0].plot()

def executar_analise():
    # 2. SELEÇÃO DAS IMAGENS VIA UPLOAD (TKINTER)
    img_antes_path = selecionar_arquivo("Selecione a foto do PRATO CHEIO (Antes)")
    img_depois_path = selecionar_arquivo("Selecione a foto do PRATO COM SOBRAS (Depois)")

    if not img_antes_path or not img_depois_path:
        print("Operação cancelada: Seleção de imagem obrigatória.")
        return

    # 3. PROCESSAMENTO
    pixels_antes, plot_antes = obter_pixels_por_classe(img_antes_path)
    pixels_depois, plot_depois = obter_pixels_por_classe(img_depois_path)

    all_classes = set(list(pixels_antes.keys()) + list(pixels_depois.keys()))

    # 4. EXIBIÇÃO DO RELATÓRIO NO TERMINAL
    print("\n" + "="*60)
    print(f"{'CLASSE':<15} | {'ANTES (px)':<12} | {'DEPOIS (px)':<12} | {'CONSUMO %'}")
    print("-" * 60)

    for item in sorted(all_classes):
        px_antes = pixels_antes.get(item, 0)
        px_depois = pixels_depois.get(item, 0)
        
        if px_antes > 0:
            reducao = px_antes - px_depois
            percentual = max(0, (reducao / px_antes) * 100)
        else:
            percentual = 0.0

        print(f"{item:<15} | {px_antes:<12} | {px_depois:<12} | {percentual:>8.2f}%")

    print("="*60)

    # 5. EXIBIÇÃO VISUAL (LADO A LADO)
    # Redimensionando apenas para caber na tela
    cv2.imshow("1. Antes (Cheio)", cv2.resize(plot_antes, (640, 640)))
    cv2.imshow("2. Depois (Sobras)", cv2.resize(plot_depois, (640, 640)))
    
    print("\nPressione qualquer tecla nas janelas de imagem para fechar.")
    cv2.waitKey(0)
    cv2.destroyAllWindows()

if __name__ == '__main__':
    executar_analise()