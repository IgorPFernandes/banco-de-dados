-- A consulta mais básica já venho utilizando desde o inicio do tutorial o famoso select.

select * from cliente;

-- Agora vamos pegar algumas tabelas para treinar as diversas formas de consultas

CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(50)
);

-- Inserções com nomes duplicados

INSERT INTO clientes (nome, email, cidade) VALUES
('João Silva', 'joao.silva@email.com', 'São Paulo'),
('Maria Oliveira', 'maria.oliveira@email.com', 'Rio de Janeiro'),
('João Silva', 'joao.silva2@email.com', 'São Paulo'),
('Carlos Pereira', 'carlos.pereira@email.com', 'Salvador'),
('Maria Oliveira', 'maria.oliveira2@email.com', 'Rio de Janeiro'),
('Ana Costa', 'ana.costa@email.com', 'São Paulo'),
('Pedro Souza', 'pedro.souza@email.com', 'Belo Horizonte'),
('Carlos Pereira', 'carlos.pereira2@email.com', 'Salvador');

-- Esse insert aconteceu depois porque achei poucos clientes

INSERT INTO clientes (nome, email, cidade) VALUES
('Lucas Almeida', 'lucas.almeida@email.com', 'Curitiba'),
('Fernanda Silva', 'fernanda.silva@email.com', 'Porto Alegre'),
('Rafael Santos', 'rafael.santos@email.com', 'Recife'),
('Juliana Costa', 'juliana.costa@email.com', 'Fortaleza'),
('Eduardo Lima', 'eduardo.lima@email.com', 'Salvador'),
('Tatiane Rocha', 'tatiane.rocha@email.com', 'Goiânia'),
('Carlos Souza', 'carlos.souza@email.com', 'Brasília'),
('Beatriz Martins', 'beatriz.martins@email.com', 'São Paulo'),
('Gustavo Oliveira', 'gustavo.oliveira@email.com', 'Rio de Janeiro'),
('Patrícia Pereira', 'patricia.pereira@email.com', 'Belo Horizonte');

insert into clientes (nome,email,cidade) values
('João Costa', 'joao.costa@email.com', 'Brasília');

insert into clientes (nome,email,cidade) values
('Patrícia Lima', null, 'Natal');

select * from clientes;

CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INT,
    data_pedido DATE,
    valor_total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

INSERT INTO pedidos (cliente_id, data_pedido, valor_total) VALUES
(1, '2025-01-01', 150.50),
(2, '2025-01-02', 200.75),
(3, '2025-01-03', 120.30),
(1, '2025-01-04', 220.10),
(4, '2025-01-02', 100.00),
(5, '2025-01-01', 180.40),
(2, '2025-01-03', 210.00);

select * from pedidos;

CREATE TABLE produtos (
    produto_id SERIAL PRIMARY KEY,
    nome_produto VARCHAR(100),
    preco DECIMAL(10, 2)
);

INSERT INTO produtos (nome_produto, preco) VALUES
('Produto A', 50.00),
('Produto B', 75.00),
('Produto C', 40.00),
('Produto D', 120.00),
('Produto E', 60.00);

select * from produtos;

CREATE TABLE itens_pedido (
    item_id SERIAL PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(3, 4, 1),
(4, 1, 1),
(5, 5, 2),
(6, 3, 1),
(7, 2, 4);

select * from itens_pedido;

-- Aqui vão haver algumas repetições mas eu achei uma boa oportunidade para treinar
-- Vamos começar

select nome,cidade from clientes where cidade = 'São Paulo'; -- Procurando especificamente por uma cidade

select nome,email from clientes where nome = 'Ana Costa'; -- Procurando especificamente por um nome

select nome,email from clientes where nome like 'João%'; -- A % indica que queremos um João, mas não importa o que vem depois

select nome,cidade from clientes order by cliente_id limit 10; -- O número após o limit vai repassar justamente o numero que você quer

select nome, cidade from clientes order by cliente_id limit 10 offset 5; -- O offset é o ponto de partida que você quer

select cidade, count(*) from clientes group by cidade; -- Todas as cidades

select cidade, count(*) from clientes where cidade = 'Salvador' group by cidade; -- Achei bem otimizado dessa forma

SELECT 'Salvador' AS cidade, COUNT(*) FROM clientes WHERE cidade = 'Salvador'; -- Essa foi sugerida pelo chat gpt

update clientes set email = 'aninhagameplays@gmail.com' where nome = 'Ana Costa';

select nome,email from clientes where nome = 'Ana Costa'; -- Use para conferir

delete from clientes where cidade = 'Curitiba'; -- Deletar clientes de uma cidade que não opera mais

select cidade, count(*) from clientes where cidade = 'Curitiba' group by cidade; -- Conferindo

-- Criando uma coluna temporaria que repassa uma informação desejada
select nome, case when cidade = 'São Paulo' then 'Mora' else 'Não Mora' end as reside from clientes;

-- Agora digamos que você quer recuperar alguns dados de uma tabela que lhe foi entrege e está faltando muita coisa!
select nome,coalesce (email, 'Não informado') from clientes; -- Perceba a última cliente que eu inseri o email era nulo

-- Pedi para o chat GPT gerar uns desafios para mim:

-- Primeiro: Mostre a quantidade total de pedidos para cada cliente e ordene o resultado por quantidade de pedidos em ordem decrescente.


select distinct c.nome, count(*) as qnt_pedidos
from pedidos p
join clientes c on p.cliente_id = c.cliente_id
group by c.nome, c.cliente_id
order by qnt_pedidos desc, c.nome asc;

-- Segundo: Atualize o email dos clientes de Salvador para salvador@novoemail.com, mas somente para os clientes que não possuem email.

-- Terceiro: Exclua todos os clientes que não realizaram pedidos.

-- Quarto: Mostre os clientes que realizaram pedidos de produtos mais caros que 100 reais.

-- Quinto: Mostre o nome do produto e a quantidade total vendida de cada produto (considerando os itens de pedidos), ordenando pelo produto com maior quantidade vendida.

-- Sexto: Encontre os clientes que realizaram mais de 2 pedidos.

-- Sétimo: Mostre os 10 clientes mais recentes (com base no ID de cliente) e suas cidades, usando ORDER BY e LIMIT.