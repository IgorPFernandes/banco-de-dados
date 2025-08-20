import os
import pandas as pd

folder = r"C:\Users\igorp\OneDrive\Desktop\Script\tabelas"

for file in os.listdir(folder):
    if file.endswith(".xlsx"):
        file_path = os.path.join(folder, file)
        print(f"Tratando arquivo {file}...")

        # lê o Excel
        df = pd.read_excel(file_path)

        # renomeia colunas do tipo YYYYMM para MM/YYYY
        new_cols = {}
        for col in df.columns:
            if str(col).isdigit() and len(str(col)) == 6:
                ano = str(col)[:4]
                mes = str(col)[4:]
                new_cols[col] = f"{mes}/{ano}"
        
        df.rename(columns=new_cols, inplace=True)

        # salva sobrescrevendo o arquivo
        df.to_excel(file_path, index=False)
        print(f"✔ Arquivo {file} atualizado com colunas no formato MM/YYYY")
