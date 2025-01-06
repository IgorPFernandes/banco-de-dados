-- Aqui algumas funções que o chat GPT me deu de exemplo para eu pudesse entender melhor:

CREATE FUNCTION somar(a INT, b INT) 
RETURNS INT AS $$
BEGIN
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

SELECT somar(5, 3);

select somar(9,12);


--Funções com tipos compostos: Você pode retornar registros (LINHA) ou tipos compostos.

CREATE FUNCTION obter_cliente_info(cliente_id INT) 
RETURNS TABLE (nome VARCHAR, email VARCHAR) AS $$ -- Está informando que vai retornar uma tabela
BEGIN
    RETURN QUERY -- aqui ele vai retornar a query seguinte (que nesse caso é um select)
    SELECT c.nome, c.email 
    FROM clientes c 
    WHERE c.cliente_id = $1;  -- Correção: c.cliente_id é a coluna da tabela
END;
$$ LANGUAGE plpgsql;

SELECT * FROM obter_cliente_info(2);

DROP FUNCTION obter_cliente_info; -- Caso você precise deletar uma função

-- Fazendo uma função sozinho utilizando funções de agregação

create function retorna_valor (id_param int)
returns table (nome varchar, soma_valores decimal(10,2)) as $$
begin
	return query
	select c.nome, sum(e.valor_compra)
	from extrato_banco e
	left join cliente c on e.cliente_id = c.id
	where e.cliente_id = id_param
	group by c.nome;
end;
$$ language plpgsql;

select * from retorna_valor(2); -- Criei uma função que retorna o valor gasto no extrato, exatamente do id que eu enviar
-- realmente faz sentido quando você utiliza várias e várias vezes.

DROP FUNCTION retorna_valor;



