import os
import pandas as pd
from sqlalchemy import create_engine

# Configuração do banco (ajuste com suas credenciais reais)
DB_USER = "postgres"
DB_PASS = "z6wVHsi0beqm6dblmaTW"
DB_HOST = "execution-south-zone.c7qyw82umzjd.sa-east-1.rds.amazonaws.com"
DB_PORT = "5432"
DB_NAME = "coolers_maps_tracking_db"

# cria conexão com PostgreSQL
engine = create_engine(
    f"postgresql+psycopg2://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# pasta com os arquivos xlsx
folder = r"C:\Users\igorp\OneDrive\Desktop\Script\tabelas"

# percorre todos os arquivos xlsx
for file in os.listdir(folder):
    if file.endswith(".xlsx"):
        file_path = os.path.join(folder, file)

        # nome da tabela = nome do arquivo sem extensão
        table_name = os.path.splitext(file)[0]

        print(f"Importando {file} → tabela {table_name}...")

        # lê o Excel (padrão: primeira aba)
        df = pd.read_excel(file_path)

        # insere no banco
        df.to_sql(table_name, engine, if_exists="append", index=False)

        print(f"✔ Dados inseridos em {table_name}")
