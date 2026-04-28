import cv2
import numpy as np

def transformar_preto_em_branco(img_path, output_path):
    # 1. Carrega a imagem
    img = cv2.imread(img_path)
    if img is None:
        print("Erro ao carregar a imagem.")
        return

    # 2. Define o limite do que é considerado "preto"
    # (0,0,0) é preto puro. Usamos (15,15,15) para pegar tons quase pretos
    limite_superior = np.array([15, 15, 15])
    limite_inferior = np.array([0, 0, 0])

    # 3. Cria uma máscara que identifica onde a imagem está preta
    mask = cv2.inRange(img, limite_inferior, limite_superior)

    # 4. Cria uma cópia da imagem e onde a máscara for verdadeira, pinta de branco
    img_corrigida = img.copy()
    img_corrigida[mask > 0] = [255, 255, 255] # [B, G, R] para branco

    # 5. Salva o resultado
    cv2.imwrite(output_path, img_corrigida)
    print(f"Sucesso! Fundo convertido para branco em: {output_path}")

# --- Teste com suas imagens ---
transformar_preto_em_branco('antes2.jpg', 'depois_fundo_branco2.png')