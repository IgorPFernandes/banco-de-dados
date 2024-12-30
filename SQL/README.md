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

-- deletando tabela 

drop table usuarios;

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


insert into condominio(nome,apartamento,bloco,aluguel)
values
('José', )

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
