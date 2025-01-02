-- Uma subquerie executa uma subconsulta dentro de uma querie comum que você está realizando por exemplo:

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