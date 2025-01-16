-- Uma subquerie executa uma subconsulta dentro de uma querie comum que você está realizando por exemplo:

-- Perceba que são praticamente a mesma busca, a unica diferença é que uma estou fazendo um join no from para unir as tabelas
-- ter acesso a ambos os dados e que na segunda consulta eu estou fazendo uma especificação com where, mas se você apaga o where
-- o resultados das consultas são o mesmo.

select e.cliente_id, e.valor_compra,
       (select c.nome from cliente c where c.id = e.cliente_id) as nome_cliente
from extrato_banco e;

select e.cliente_id, e.valor_compra, c.nome
from extrato_banco e
join(
	select id,nome
	from cliente c
	where nome = 'Igor Pereira'
)c on e.cliente_id = c.id;

-- o ponto chave dessas subconsultas é te ajudar a conseguir uma consulta mais completa, porém como é especifico da ocasião da consulta
-- você não pode reutilizar aquela consulta.

-- Quando usar ? 
-- 1º Quando você precisa filtrar os dados de uma consulta principal baseado nos dados de outra tabela e evitar o uso de joins complexos

-- Por exemplo, se você quiser encontrar os clientes que realizaram compras com valor superior a própria média das compras:

select e.cliente_id, e.valor_compra, e.data_compra
from extrato_banco e
where e.cliente_id in (
	select c.id
	from cliente c
	where c.cpf = '72348676001'
)

-- Nesse caso acima eu queria os dados da tabela extrato_banco, baseado no cpf da tabela cliente.

-- 2º Se você quer verificar se existe algum registro que atende a condição

-- Quero encontrar todos os clientes que tem extrato registrado na tabela:

select nome
from cliente c
where exists (
	select 1
	from extrato_banco e
	where e.cliente_id = c.id
);

-- 3º Calcular antes de juntar

select c.nome, t.total_compras
from cliente c
join(
	select cliente_id, sum(valor_compra) as total_compras
	from extrato_banco
	group by cliente_id
)t on c.id = t.cliente_id; -- esse 't' logo após a subquery funciona como um renomear essa subquery para t, e essa subquery estou usando os valores
-- de extrato_banco, logo t contém extrato_banco. Estou dizendo que o select principal e a subquery devem ser unidas quando o id for igual.

-- 4º Fazer uma consulta especifica para cada linha da consulta principal

select e.cliente_id, e.valor_compra, (
	select sum(valor_compra)
	from extrato_banco
	where cliente_id = e.cliente_id -- Esse where parece redundante mas pelo que eu entendi ele serve para comparar o id da consulta principal com o da subquery
)as total_compra                    -- Lembra que se você não especificar a linha ele vai somar todas as linhas de toda tabela, é exatamente por isso.
from extrato_banco e;


-- 5º Eliminar duplicações

SELECT DISTINCT cliente_id, valor_compra
FROM extrato_banco
WHERE cliente_id IN (
    SELECT cliente_id
    FROM extrato_banco
    GROUP BY cliente_id
    HAVING SUM(valor_compra) > 50
); -- É porque eu não tenho um caso de duplicação nas tabelas que criei.

-- CTE (Common table expressions) são um recurso no SQL que permite criar subconsultas temporárias dentro de uma consulta maior. 
-- Elas podem ser usadas para tornar o código mais legível, modular e reutilizável, e são especialmente úteis em consultas complexas.

-- Sintaxe básica:

WITH nome_da_cte AS (
    -- Consulta SQL que define a CTE
    SELECT coluna1, coluna2 -- Aqui na consulta da CTE pode conter select,join,where,having, etc..
    FROM tabela
    WHERE condição
)
-- Consulta principal que usa a CTE
SELECT *
FROM nome_da_cte
WHERE outra_condição;

-- As CTEs podem ser reutilizadas várias vezes durante o código.

-- Exemplo, digamos que eu queira encontrar os clientes que já fizeram mais de 2 compras no cartão.

with clientes_do_extrato as (
	select cliente_id, count(*) as numero_compras
	from extrato_banco
	group by cliente_id
	having count(*) > 2
)
select c.id, c.nome
from cliente c
join clientes_do_extrato cde on c.id = cde.cliente_id;


-- Detalhe que enquanto construia essa consulta eu entendi, a CTE só armazena o que você fez na subconsulta
-- Não adianta dar um cde.valor_compras, esses valores não vão estar lá.

with clientes_do_extrato as (
	select cliente_id, count(*) as numero_compras
	from extrato_banco
	group by cliente_id
	having count(*) > 2
)
select c.id, c.nome, SUM(eb.valor_compra) as total_gasto
from cliente c
join clientes_do_extrato cde on c.id = cde.cliente_id
join extrato_banco eb on cde.cliente_id = eb.cliente_id
group by c.id, c.nome;

select e.cliente_id,c.nome, sum(e.valor_compra) as total_gasto
from extrato_banco e
join cliente c on c.id = e.cliente_id
where e.cliente_id = 1
group by cliente_id, c.nome;

-- Aprendendo a deletar duplicatas:

WITH cte AS ( -- Onde tem cte você pode dar qualquer nome para essa cte
    SELECT
        id, -- pelo que li você precisa selecionar id aqui para que possa aplicar na função row_number
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS rn -- aqui você vai contar linha abaixo de linha (over)
        -- separando em partições por id e ordenando-as por id, então se em uma partição vc conta 2 id quer dizer que está duplicado
    FROM cliente
)
DELETE FROM cliente
WHERE id IN (
    SELECT id
    FROM cte
    WHERE rn > 1 -- aqui é justamente onde a gente verifica se a contagem é maior que 1, se for pode deletar
);

select * from cliente;
