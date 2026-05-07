import cv2
from ultralytics import YOLO
from tkinter import filedialog, Tk

def selecionar_arquivo(mensagem):
    print(mensagem)
    root = Tk()
    root.withdraw()
    root.attributes("-topmost", True)
    path = filedialog.askopenfilename(title=mensagem)
    root.destroy()
    return path

def testar_analise_comparativa():
    weights_path = 'runs/detect/treino_melhorado/weights/best.pt'
    
    try:
        model = YOLO(weights_path)
        print("Modelo YOLO carregado!")
    except Exception as e:
        print(f"Erro: {e}")
        return

    # 1. Seleciona as duas imagens
    img_antes = selecionar_arquivo("Selecione a foto do PRATO CHEIO (Antes)")
    img_depois = selecionar_arquivo("Selecione a foto do PRATO APÓS A REFEIÇÃO (Depois)")

    if img_antes and img_depois:
        # 2. Predição para ambas
        res_antes = model.predict(source=img_antes, conf=0.3)
        res_depois = model.predict(source=img_depois, conf=0.3)

        # 3. Lógica simples de comparação (Extração de classes detectadas)
        itens_antes = [model.names[int(c)] for c in res_antes[0].boxes.cls]
        itens_depois = [model.names[int(c)] for c in res_depois[0].boxes.cls]

        # 4. Cálculo do que foi consumido
        # (Se estava no antes e não está no depois, foi consumido)
        consumido = [item for item in itens_antes if item not in itens_depois]

        print("\n--- RESULTADO DA ANÁLISE ---")
        print(f"Itens identificados no início: {itens_antes}")
        print(f"Itens que sobraram no fim: {itens_depois}")
        print(f"Estimativa de consumo: {consumido}")

        # 5. Visualização Lado a Lado
        plot_antes = res_antes[0].plot()
        plot_depois = res_depois[0].plot()
        
        cv2.imshow("Antes (Cheio)", plot_antes)
        cv2.imshow("Depois (Sobra)", plot_depois)
        
        print("\nPressione qualquer tecla nas janelas de imagem para fechar.")
        cv2.waitKey(0)
        cv2.destroyAllWindows()

if __name__ == '__main__':
    testar_analise_comparativa()