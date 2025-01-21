-- Preferi fazer em um banco novo.

CREATE TABLE temp_orders (
    numero_do_pedido INTEGER,
    usuario VARCHAR(255),
    data_do_pedido DATE,
    produto VARCHAR(255),
    preco NUMERIC(10, 2),
	quantidade INTEGER,
	preco_produto NUMERIC(10, 2)
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at DATE NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products (product_id)
);
-- A importação pelo pgadmin não está funcionando então estou fazendo linha de código no psql

-- \COPY users (user_id, name, email, created_at) FROM 'C:/Users/igorp/Downloads/users_extended.csv' DELIMITER ',' CSV HEADER;

select * from users;

-- \COPY temp_orders (numero_do_pedido, usuario, data_do_pedido, preco, quantidade, produto, preco_produto) FROM 'C:/Users/igorp/OneDrive/Desktop/Meus Estudos/Aprendizagem Individual/Banco de Dados/PostgreSQL/Atividades_BI/Tarefa III/Backup/historico_geral_vendas_2.csv' DELIMITER ',' CSV HEADER;

select * from temp_orders;

-- Tudo de acordo, vamos prosseguir.

alter table temp_orders
add column stock_quantity INTEGER DEFAULT 0;

-- Precisei fazer isso por um motivo, o stock_quantity da tabela produtos é not null
-- A tabela temporaria não tem stock quantity, então adaptei.

insert into products (name,price,stock_quantity)
select distinct tor.produto,tor.preco_produto,tor.stock_quantity
from temp_orders tor
where produto not in (select p.name from products p);

select * from products;

-- Inserir dados na tabela orders
insert into orders (order_id, user_id, order_date, total_amount)
select distinct
    tor.numero_do_pedido,  -- order_id
    (select u.user_id from users u where u.name = tor.usuario),  -- Obtendo o user_id pela correspondência de nome
    tor.data_do_pedido,  -- order_date
    sum(tor.preco)  -- total_amount, soma dos preços de todos os itens do pedido
from temp_orders tor
group by tor.numero_do_pedido, tor.data_do_pedido, tor.usuario;

select * from orders;

insert into order_items (order_id, product_id, quantity, price)
select 
    o.order_id,  -- order_id da tabela orders
    p.product_id,  -- product_id da tabela products
    tor.quantidade,  -- quantidade do produto, assumindo que seja 1 para cada item
    tor.preco  -- preço do produto
from temp_orders tor
join orders o on o.order_id = tor.numero_do_pedido  -- Relacionando pedido com order_id
join products p on p.name = tor.produto  -- Relacionando produto com product_id
where tor.produto is not null;

select * from order_items;

