-- Tabela: Usuarios
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    created_at DATE NOT NULL
);

-- Tabela: Produtos
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL
);

-- Tabela: Pedidos
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users (user_id)
);

-- Tabela: itens por pedido
CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders (order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products (product_id)
);

-- Seguindo as orientações, users -> products -> orders -> order-items
-- Importei manualmente pelo PGadmin

SELECT pg_get_serial_sequence('users', 'user_id'); -- nome coluna geralmente vai ser id

SELECT setval('public.users_user_id_seq', (SELECT MAX(user_id) FROM users)); -- Usei o comando explicado por JV para identificar e atualizar o máximo user_id

-- Vamos verificar

INSERT INTO users(name,email,created_at)
VALUES
('Igor', 'igorp@hotmail.com', '2025-01-25');

SELECT * FROM users;

DELETE FROM users
WHERE user_id = 11;

-- Quando tirei o +1 no final do setval, ele adicionou como 11, se eu deixasse o +1 ele estava adicionando a partir do id 12.

SELECT * FROM products;

SELECT pg_get_serial_sequence('products', 'product_id');

SELECT setval('public.products_product_id_seq', (SELECT MAX(product_id) FROM products));

INSERT INTO products(name, price, stock_quantity)
VALUES
('Pão de Forma', '5.00', 3);

SELECT * FROM products;

DELETE FROM products
WHERE product_id = 26;

SELECT * FROM orders;

SELECT pg_get_serial_sequence('orders', 'order_id');

SELECT setval('public.orders_order_id_seq', (SELECT MAX(order_id) FROM orders));

INSERT INTO orders(user_id,order_date, total_amount)
VALUES
(3,'2025-1-24',10.00);

SELECT * FROM orders;

DELETE FROM orders
WHERE order_id = 51;

SELECT pg_get_serial_sequence('order_items', 'order_item_id');

SELECT setval('public.order_items_order_item_id_seq', (SELECT MAX(order_item_id) FROM order_items));

INSERT INTO order_items(order_id, product_id, quantity, price)
VALUES
(1,1,3,5.00);

SELECT * FROM order_items;

DELETE FROM order_items
WHERE order_item_id = 81;

SELECT 
    datname AS database_name,
    COUNT(*) AS connection_count
FROM 
    pg_stat_activity
GROUP BY 
    datname
ORDER BY 
    connection_count DESC;

SELECT 
    application_name,
    COUNT(*) AS connection_count
FROM 
    pg_stat_activity
GROUP BY 
    application_name
ORDER BY 
    connection_count DESC;


SELECT application_name, state, datname, query
FROM pg_stat_activity;

SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE state = 'idle'
  AND pid <> pg_backend_pid();

