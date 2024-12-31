# Tutorial Parte I - Entendendo as Nomenclaturas Iniciais

Neste tutorial, vamos entender as nomenclaturas e conceitos básicos relacionados a banco de dados, postgreSQL e operações comuns em um banco relacional.

### O que é uma **query**?

Uma **query** é uma requisição feita ao banco de dados, geralmente utilizando a linguagem SQL (Structured Query Language). Ela serve para interagir com o banco de dados, seja para buscar dados, modificar informações, inserir ou deletar registros.

#### Tipos de Queries Comuns:
- **SELECT**: Utilizado para consultar ou buscar dados de uma tabela.
- **INSERT**: Usado para adicionar novos registros em uma tabela.
- **UPDATE**: Para modificar dados já existentes em uma tabela.
- **DELETE**: Para remover dados de uma tabela.

### O que é uma **tabela**?

Uma **tabela** é uma estrutura de dados que organiza informações em linhas (também chamadas de registros ou "tuplas") e colunas (chamadas de campos ou atributos). Cada coluna tem um nome e um tipo de dado específico, e cada linha contém um conjunto de dados relacionados.

### O que é uma **coluna**?

Uma **coluna** é um campo de uma tabela, onde os dados são armazenados. Cada coluna tem um nome e um tipo de dado (como `VARCHAR`, `INT`, `DATE`, entre outros) que define o tipo de informações que ela pode armazenar. Por exemplo, uma tabela de usuários pode ter colunas como `id`, `nome`, `email`.

### O que é um **registro**?

Um **registro** (ou **linha**) é um conjunto de dados correspondentes aos campos de uma tabela. Cada linha contém valores para cada coluna. Por exemplo, em uma tabela de usuários, um registro pode conter o nome, e-mail e ID de um usuário específico.

### O que é uma **chave primária (PRIMARY KEY)**?

A **chave primária** é uma coluna (ou conjunto de colunas) que identifica de forma única cada registro em uma tabela. Nenhum valor na chave primária pode ser nulo e deve ser único em cada linha da tabela.

### O que é uma **chave estrangeira (FOREIGN KEY)**?

Uma **chave estrangeira** é uma coluna em uma tabela que faz referência à chave primária de outra tabela. Ela é usada para estabelecer relacionamentos entre duas tabelas, permitindo que as informações sejam associadas de maneira eficiente.

Exemplo:
- Em uma tabela de **usuários**, a chave estrangeira pode ser `condominio_id`, que faz referência à tabela `condominio` e liga um usuário a um condomínio específico. (Presente no exemplo 1 dos scripts)

# Tutorial Parte II - Tipos de Dados

## Tipos de Dados em SQL

Ao criar tabelas em SQL, cada coluna precisa ter um tipo de dado definido. O tipo de dado determina o tipo de valores que aquela coluna pode armazenar, como texto, números ou datas.

## Principais Tipos de Dados

### 1. **Tipos Numéricos**
Usados para armazenar números inteiros ou decimais.

- **`INT`**: Armazena números inteiros. Exemplo: 1, 42, -100.  
  - **`SMALLINT`**: Para números inteiros menores (economiza espaço). Exemplo: 1, 255.
  - **`BIGINT`**: Para números inteiros grandes. Exemplo: 9.223.372.036.854.775.807.
- **`DECIMAL(p, s)` ou `NUMERIC(p, s)`**: Armazena números decimais com precisão definida.  
  - `p`: Total de dígitos.  
  - `s`: Quantidade de dígitos após o ponto decimal.  
  - Exemplo: `DECIMAL(10, 2)` armazena até 10 dígitos, sendo 2 após o ponto decimal (como `12345678.90`).
- **`FLOAT`** ou **`REAL`**: Para números com ponto flutuante (menos precisos que `DECIMAL`).

### 2. **Tipos de Texto**
Usados para armazenar strings (textos).

- **`CHAR(n)`**: Armazena strings de tamanho fixo. Exemplo: `CHAR(5)` sempre reserva 5 caracteres, mesmo que o valor seja menor.
- **`VARCHAR(n)`**: Armazena strings de tamanho variável até o limite especificado. Exemplo: `VARCHAR(100)` permite strings de até 100 caracteres.
- **`TEXT`**: Para armazenar textos longos sem limite especificado. Exemplo: Artigos ou descrições detalhadas.

### 3. **Tipos de Data e Hora**
Usados para armazenar informações temporais.

- **`DATE`**: Apenas a data (ano, mês, dia). Exemplo: `2024-12-30`.
- **`TIME`**: Apenas a hora (hora, minutos, segundos). Exemplo: `14:30:00`.
- **`TIMESTAMP`**: Combina data e hora. Exemplo: `2024-12-30 14:30:00`.
- **`INTERVAL`**: Armazena períodos de tempo (como "2 dias" ou "3 horas").

### 4. **Tipos Booleanos**
Armazena valores lógicos.

- **`BOOLEAN`**: Representa `TRUE`, `FALSE` ou `NULL`.

### 5. **Tipos Especiais**
Usados para casos mais específicos.

- **`SERIAL`**: Usado para criar identificadores únicos automaticamente. Geralmente usado para chaves primárias. Exemplo: `id SERIAL`.
- **`JSON`** ou **`JSONB`**: Para armazenar dados no formato JSON (útil em bancos modernos).
- **`ARRAY`**: Permite armazenar múltiplos valores em uma única coluna.

## Escolhendo o Tipo Certo

Escolher o tipo de dado correto é essencial para garantir que:
1. **Os valores armazenados estejam no formato correto.**
2. **O espaço de armazenamento seja utilizado de forma eficiente.**

Por exemplo:
- Para **idade**, use `SMALLINT` em vez de `INT`, pois o valor máximo será pequeno.
- Para **nomes**, use `VARCHAR(100)` ou `TEXT` dependendo da necessidade.
- Para valores monetários, `DECIMAL(10, 2)` é uma escolha ideal.

---

Com esses tipos de dados, você pode modelar tabelas de forma eficiente, garantindo consistência e desempenho no banco de dados.

# Tutorial Parte III - Criação e Relacionamento de Tabelas

```sql

-- criando  tabela novamente para reforçar

create table usuarios (
	id serial primary key,
	nome VARCHAR(100),
	email VARCHAR(100)
);

-- inserindo valores

insert into usuarios (nome, email)
values
('Igor Pereira', 'igor@gmail.com'),
('Mariana', 'mari@gmail.com');

--checando se está tudo certo

select * from usuarios;

--criando a tabela condominio para que eu possa relacionar

create table condominio (
	id serial primary key,
	nome VARCHAR(100),
	apartamento smallint,
	bloco smallint,
	alguel decimal(10,2)
);

--percebi o erro na escrita, mas agora aprendi a renomear

alter table condominio
rename alguel to aluguel;

--inseri valores dentro da tabela condominio

insert into condominio(nome, apartamento, bloco, aluguel)
values
('Igor Pereira', 12, 3, 1200.00),
('João Celestino', 15, 4, 1000.00);

--checando os dados

select * from condominio;

--agora eu estou fazendo a relação entre as tabelas, para começo adicionei uma nova coluna na tabela usuarios

alter table usuarios
add column condominio_id INT;

--em seguida estou definindo que essa coluna é uma chave estrangeira

alter table usuarios
add constraint condominio_id -- Cria chave estrangeira para relacionar a tabela usuarios com a tabela condominio
foreign key (condominio_id) references condominio(id) -- E essa é a coluna que vai referenciar as duas tabelas
on delete set null; -- se condominio for deletado o campo será null

--Vamos atualizar agora essas tabelas!

update usuarios u
set condominio_id = c.id
from condominio c
where u.condominio_id IS NULL
and c.nome = u.nome;

--Mas perceba que na linha 2 Mariana, a associação não está funcionando porque la em cima eu adicionei outro nome

select u.id as usuario_id, u.nome as usuario_nome, u.email as usuario_email, u.condominio_id, c.nome as condominio_nome
from usuarios u
left join condominio c on u.condominio_id = c.id;

--Ajustes

update condominio
set nome = 'Mariana'
where id = 6; -- Como eu deletei algumas vezes, o id de condominio continuou subindo, logo quando voltei a essa correção tive que mudar o número do id
--mas caso você esteja fazendo isso pela primeira vez então: where id = 2;

--Novamente

update usuarios u
set condominio_id = c.id
from condominio c
where u.condominio_id is null
and c.nome = u.nome;

-- Nesse select fiz alguns nomes temporarios para melhorar o entendimento
select u.id as usuario_id, u.nome as usuario_nome, u.email as usuario_email, u.condominio_id, c.nome as condominio_nome
from usuarios u
left join condominio c on u.condominio_id = c.id;

-- Apenas o usuarios que possuem um condominio_id dentro da tabela de usuarios compatível com um condominio_id dentro da tabela condominio serão mostrados
select usuarios.nome, condominio.nome
from usuarios
inner join condominio on usuarios.condominio_id = condominio.id;

--Serão mostrados todos os nomes da tabela da esquerda, mas a da direita os que não estiverem de acordo com a condição será apresentado como NULL

select usuarios.nome, condominio.nome
from usuarios
left join condominio on usuarios.condominio_id = condominio.id;

--Serão mostradas condominio.nome da tabela da direita, mas o que não estiver associado na esquerda será demonstrado como NULL

select usuarios.nome, condominio.nome
from usuarios
right join condominio on usuarios.condominio_id = condominio.id;

--Todas as linhas serão mostradas independente da correspondencia

select usuarios.nome, condominio.nome
from usuarios
full join condominio on usuarios.condominio_id = condominio.id;

--Todos os usuarios serão combinados com todos os nomes de condominios formando a todas as combinações possíveis, resumindo: é um produto cartesiano.

select usuarios.nome, condominio.nome
from usuarios
cross join condominio;

--Vamos adicionar alguns usuarios desconexos com condominios e virce-versa para entender melhor o JOIN

insert into condominio (nome,apartamento,bloco,aluguel)
values
('Lucas', 27, 6, 800.00);

insert into usuarios (nome,email)
values
('Natan', 'natanzinhogameplays@gmail.com');

--Conferindo

select * from usuarios;

select * from condominio;

-- Agora repita todos os comandos anteriores de Inner, Left, Right, Full e Cross. Agora você vai entender a diferença!
```
# Tutorial Parte IV - Funções básicas de Agragação e Trigger

```sql
-- Vamos criar um novo contexto com novas tabelas para aprender sobre funções básicas de agregação (count,sum,avg,max,min)

create table cliente (
	id serial primary key,
	nome VARCHAR(100) not null, --not null significa que essa coluna não pode conter valores nulos
	cpf VARCHAR(11) not null,
	email VARCHAR(255) not null
);

insert into cliente ( nome, cpf, email)
values
('Igor Pereira', '53004758075', 'shaolinmatadordeporco@hotwells.com'),
('Ivanilson', '72348676001', 'maxsteel@hotwells.com');

select * from cliente;

create table cartao_credito (
	id serial primary key,
	cliente_id int not null,
	numero_cartao VARCHAR(16) not null,
	limite decimal(10,2) not null,
	limite_disponivel decimal(10,2) not null,
	foreign key (cliente_id) references cliente(id) on delete cascade
);

alter table cartao_credito
add column data_validade DATE, --percebi que para ser realista faltou esses dois dados!!
add column cvv smallint;

insert into cartao_credito (cliente_id ,numero_cartao, limite, limite_disponivel, data_validade, cvv) -- Perceba que colocando o ID a gente é quem decide de quem é o cartão
values
(1,'5564959910010564', 1200.00, 1200.00, '2026-01-31', 381), --Perceba que eu coloquei YYYY/MM/DD quando pesquisei vi que esse era o formato de DATE
(2,'5138020755144971', 800.00, 800.00, '2026-07-01', 504);

select * from cartao_credito; -- Agora a gente tem um cliente e um cartão associado ao mesmo

-- Precisamos guardar os dados das compras na tabela extrato_banco 

create table extrato_banco (
	id serial primary key,
	cliente_id int not null, 
	cartao_id int not null,
	descricao_compra VARCHAR(255) not null,
	valor_compra decimal (10,2) not null,
	data_compra TIMESTAMP not null default current_timestamp,
	foreign key (cliente_id) references cliente(id) on delete cascade,
	foreign key (cartao_id) references cartao_credito(id) on delete cascade
);

select * from extrato_banco;

-- acabei de notar que se eu quiser deixar isso bem realista vou ter que fazer uma forma de debitar o limite quando o dado for inserido no extrato_banco

CREATE OR REPLACE FUNCTION debitar_limite()
RETURNS TRIGGER AS $$  -- Delimitador do corpo da função começa aqui
BEGIN
    -- Atualiza o limite disponível do cartão de crédito
    UPDATE cartao_credito
    SET limite_disponivel = limite_disponivel - NEW.valor_compra --Você também percebeu que temos colunas de tabelas distintas aqui, isso ocorre porque ainda vamos
    WHERE id = NEW.cartao_id;--                                    relacionar a tabela de ativação do trigger a tabela que possui a coluna limite_disponivel

    RETURN NEW; -- Retorna a linha modificada no trigger
END;
$$ LANGUAGE plpgsql;  -- Delimitador termina aqui, plpgsql é a linguagem embutida no postgresql para usar um (for,if...)


CREATE TRIGGER after_insert_extrato
AFTER INSERT ON extrato_banco -- depois que acontecer o query insert no extrato_banco, vai ser um gatilho para ativar a função de cima e atualizar cartao_credito
FOR EACH row -- indica que sempre vai ser ativado quando você inserir uma linha
EXECUTE FUNCTION debitar_limite(); --indica a função que vai ser executada pelo gatilho

insert into extrato_banco(cliente_id, cartao_id, descricao_compra, valor_compra, data_compra)
values
(1,2,'Placa de vídeo 4060 TI do Falsificada', 500.00, '2024-12-31 23:59:59'),
(2,3,'Compra de RP no LoL', 200.00, '2024-12-31 20:00:59');

select * from extrato_banco;

select * from cartao_credito;

-- Agora vamos as funções de Agregação Básicas:

-- Primeiro vou fazer mais alguns gastos nas contas acima para as funções fazerem sentido.

insert into extrato_banco(cliente_id, cartao_id, descricao_compra, valor_compra, data_compra)
values
(1,2,'Lanchezinho da meia noite', 50.00, '2024-12-25 23:59:59'),
(2,3,'Lanchezinho da meia noite', 40.00, '2024-12-26 00:00:00'),
(1,2,'Sorvete', 10.00, '2024-12-22 15:59:59'),
(2,3,'Cervejinha', 30.00, '2024-12-19 19:00:00');

select c.nome,e.cliente_id, sum(valor_compra) as total_gasto -- Agora a gente sabe o total que cada um gastou
from extrato_banco e
join cliente c on e.cliente_id = c.id -- join sem especificação sempre é inner join!!
group by c.nome,cliente_id;

select c.nome,e.cartao_id, avg(valor_compra) as media_compra -- Vemos aqui que ivanilson é bem mais economico e mantém suas compras em uma média bem mais regular
from extrato_banco e
join cliente c on e.cliente_id = c.id --lembrando que esse "on" é como se fosse um "quando", então quando e.cliente_id = c.id, mostre o resultado da seleção
group by c.nome,cartao_id;

-- Vamos contar quantas compras foram feitas

select c.nome,e.cliente_id, count(*) as numero_compra
from extrato_banco e
join cliente c on e.cliente_id = c.id
group by c.nome,cliente_id;

-- Digamos que queremos ver qual foi o maior e o menor gasto do mês

select c.nome ,e.cliente_id, max(valor_compra) as maior_compra, min(valor_compra) as menor_compra
from extrato_banco e
join cliente c on e.cliente_id = c.id
group by c.nome,cliente_id;

-- Lembrando que se você quiser ver só o ID sem o nome, retira o join, retira o c.nome do group by e retira os "alises" ,ou seja, as abreviações

-- Vamos fazer alguns filtros nessas buscas!!!

select c.nome, e.cliente_id, sum(valor_compra) as total_gasto
from extrato_banco e
join cliente c on e.cliente_id = c.id
where valor_compra >= 100 -- o where está limitando a soma apenas a valores iguais ou acima de 100 reais, talvez isso seja mais interessante no min e max
group by c.nome,e.cliente_id;

-- Vamos testar o min e max

select c.nome, e.cliente_id,max(valor_compra) as maior_compra
from extrato_banco e
join cliente c on e.cliente_id = c.id
where valor_compra >=150
group by c.nome, e.cliente_id;

select c.nome, e.cliente_id, min(valor_compra) as menor_compra -- A cerveja as vezes sai caro...
from extrato_banco e
join cliente c on e.cliente_id = c.id 
where valor_compra <= 100
group by c.nome, e.cliente_id;

-- o que acontece se a gente não usar o group by ?

select sum(valor_compra) as total_compra -- surgiu um valor de 830, pesquisei no GPT ele disse que é a soma de todas as linhas é interessante saber..
from extrato_banco;

```
