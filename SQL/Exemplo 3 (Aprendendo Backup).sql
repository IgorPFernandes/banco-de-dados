-- Vamos começar com um full backup

-- Você vai colocar isso no terminal
-- pg_dump -U igor -d aprendendo -F c -b -v -f "C:/Users/igorp/OneDrive/Desktop/Meus Estudos/Aprendizagem Individual/Banco de Dados/SQL/Backup/primeirobackup.dump"

-- Se você não sabe o nome do usuario

SELECT current_user;

--lembrando que esse backup é feito no terminal, não precisa entrar no banco pelo psql.


--Vamos aprender a Importar e Exportar Tabelas

-- 1ª Forma é via query

-- Exportação:

COPY cliente TO 'C:/Users/igorp/OneDrive/Desktop/Meus Estudos/Aprendizagem Individual/Banco de Dados/SQL/TablesBackups/clientes_export.csv' DELIMITER ',' CSV HEADER;

-- Se vocês se recordam eu tenho uma tabela chamada cliente, ela tem 4 colunas, id,cpf,nome,email.
-- Defini um caminho para uma pasta, delimitei que o que está separando os dados é uma virgula
-- e o formato é CSV, mas poderia ser também JSON,SQL ou Excel.



