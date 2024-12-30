# Tutorial: Relacionamento de Tabelas no PostgreSQL

Neste tutorial, vou explicar os primeiros passos para criar e relacionar tabelas em um banco de dados PostgreSQL. Esse processo inclui a criação de tabelas, inserção de dados, renomeação de colunas, uso de chaves estrangeiras e diferentes tipos de `JOIN` para consultas.

## Passo 1: Criando e Deletando Tabelas

Primeiro, vamos criar a tabela `usuarios`, que contém as informações de nossos usuários.

```sql
-- Deletando a tabela de usuários caso já exista
DROP TABLE IF EXISTS usuarios;

-- Criando a tabela usuarios
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  email VARCHAR(100)
);
Inserindo Dados na Tabela usuarios
Agora, vamos inserir alguns dados na tabela usuarios:

sql
Copiar código
-- Inserindo valores na tabela usuarios
INSERT INTO usuarios (nome, email)
VALUES
  ('Igor Pereira', 'igor@gmail.com'),
  ('Mariana', 'mari@gmail.com');
Verificando os Dados
Você pode verificar se os dados foram inseridos corretamente com o seguinte comando:

sql
Copiar código
-- Verificando os dados na tabela usuarios
SELECT * FROM usuarios;
Passo 2: Criando a Tabela condominio
Em seguida, vamos criar a tabela condominio para armazenar informações dos condomínios.

sql
Copiar código
-- Criando a tabela condominio
CREATE TABLE condominio (
  id SERIAL PRIMARY KEY,
  nome VARCHAR(100),
  apartamento SMALLINT,
  bloco SMALLINT,
  aluguel DECIMAL(10,2)
);
Corrigindo um Erro na Coluna aluguel
Notei um erro de digitação na coluna aluguel, então vamos corrigir o nome da coluna:

sql
Copiar código
-- Renomeando a coluna 'alguel' para 'aluguel'
ALTER TABLE condominio
RENAME COLUMN alguel TO aluguel;
Inserindo Dados na Tabela condominio
Agora, vamos inserir alguns dados na tabela condominio:

sql
Copiar código
-- Inserindo dados na tabela condominio
INSERT INTO condominio (nome, apartamento, bloco, aluguel)
VALUES
  ('Igor Pereira', 12, 3, 1200.00),
  ('João Celestino', 15, 4, 1000.00);
Verificando os Dados
Verifique se os dados foram inseridos corretamente:

sql
Copiar código
-- Verificando os dados na tabela condominio
SELECT * FROM condominio;
Passo 3: Relacionando as Tabelas
Agora vamos adicionar uma coluna condominio_id na tabela usuarios para estabelecer o relacionamento com a tabela condominio.

sql
Copiar código
-- Adicionando a coluna condominio_id na tabela usuarios
ALTER TABLE usuarios
ADD COLUMN condominio_id INT;

-- Definindo a chave estrangeira para a coluna condominio_id
ALTER TABLE usuarios
ADD CONSTRAINT fk_condominio
FOREIGN KEY (condominio_id) REFERENCES condominio(id)
ON DELETE SET NULL;  -- Se o condominio for deletado, o campo será null
Atualizando a Tabela usuarios com o condominio_id
Agora, vamos associar os usuários aos condomínios com base no nome, para que o condominio_id seja atribuído corretamente.

sql
Copiar código
-- Atualizando os dados para associar o condominio_id aos usuarios
UPDATE usuarios u
SET condominio_id = c.id
FROM condominio c
WHERE u.condominio_id IS NULL
AND c.nome = u.nome;
Consultando as Tabelas com JOIN
Agora, vamos realizar uma consulta para visualizar o relacionamento entre as tabelas usuarios e condominio:

sql
Copiar código
-- Usando LEFT JOIN para combinar os dados de usuarios e condominio
SELECT u.id AS usuario_id, u.nome AS usuario_nome, u.email AS usuario_email, u.condominio_id, c.nome AS condominio_nome
FROM usuarios u
LEFT JOIN condominio c ON u.condominio_id = c.id;
Passo 4: Trabalhando com Diversos Tipos de JOIN
Agora, vamos explorar diferentes tipos de JOIN para entender como combinar dados de duas tabelas:

1. INNER JOIN
Exibe apenas os dados que possuem correspondência entre as duas tabelas.

sql
Copiar código
-- INNER JOIN
SELECT usuarios.nome, condominio.nome
FROM usuarios
INNER JOIN condominio ON usuarios.condominio_id = condominio.id;
2. LEFT JOIN
Exibe todos os dados da tabela usuarios, mas se não houver correspondência na tabela condominio, o valor será NULL.

sql
Copiar código
-- LEFT JOIN
SELECT usuarios.nome, condominio.nome
FROM usuarios
LEFT JOIN condominio ON usuarios.condominio_id = condominio.id;
3. RIGHT JOIN
Exibe todos os dados da tabela condominio, mas se não houver correspondência na tabela usuarios, o valor será NULL.

sql
Copiar código
-- RIGHT JOIN
SELECT usuarios.nome, condominio.nome
FROM usuarios
RIGHT JOIN condominio ON usuarios.condominio_id = condominio.id;
4. FULL JOIN
Exibe todos os dados das duas tabelas, independentemente de haver ou não correspondência.

sql
Copiar código
-- FULL JOIN
SELECT usuarios.nome, condominio.nome
FROM usuarios
FULL JOIN condominio ON usuarios.condominio_id = condominio.id;
5. CROSS JOIN
Retorna o produto cartesiano, ou seja, todas as combinações possíveis entre as duas tabelas.

sql
Copiar código
-- CROSS JOIN
SELECT usuarios.nome, condominio.nome
FROM usuarios
CROSS JOIN condominio;
Passo 5: Adicionando Novos Usuários e Condomínios
Vamos adicionar alguns novos usuários e condomínios para testar os JOINs:

sql
Copiar código
-- Inserindo novos usuários e condomínios
INSERT INTO condominio (nome, apartamento, bloco, aluguel)
VALUES ('Lucas', 27, 6, 800.00);

INSERT INTO usuarios (nome, email)
VALUES ('Natan', 'natanzinhogameplays@gmail.com');
Verificando os Dados
Verifique se os dados foram inseridos corretamente:

sql
Copiar código
-- Verificando os dados das tabelas
SELECT * FROM usuarios;
SELECT * FROM condominio;
Testando os JOINs novamente
Agora, repita os comandos de INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, e CROSS JOIN para entender como cada tipo de junção funciona.

Conclusão
Este tutorial cobriu a criação de tabelas, inserção de dados, relacionamento entre tabelas usando chaves estrangeiras e o uso de diferentes tipos de JOIN para consultar os dados de maneira eficiente. Ao utilizar esses conceitos, é possível organizar dados de maneira estruturada e otimizar suas consultas no PostgreSQL.
