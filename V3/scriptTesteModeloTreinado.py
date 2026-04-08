import cv2
from ultralytics import YOLO
from tkinter import filedialog, Tk

def testar():
    # 1. Carrega apenas o resultado final do seu treino
    # Verifique se o caminho está correto conforme a pasta que o YOLO criou
    weights_path = 'runs/detect/treino_melhorado/weights/best.pt'
    
    try:
        model = YOLO(weights_path)
        print("Modelo carregado com sucesso!")
    except Exception as e:
        print(f"Erro ao carregar o modelo: {e}. Verifique se o treino terminou.")
        return

    # 2. Abre a janela para selecionar a foto
    print("Selecione a foto para reconhecimento...")
    root = Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    file_path = filedialog.askopenfilename()
    root.destroy()

    if file_path:
        # 3. Faz a predição (usando a GPU se quiser: device=0)
        results = model.predict(source=file_path, conf=0.3)
        
        # 4. Mostra o resultado na tela
        res_plotted = results[0].plot()
        cv2.imshow("Resultado - Pressione qualquer tecla para fechar", res_plotted)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

if __name__ == '__main__':
    testar()