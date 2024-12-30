# Tutorial Parte I - Entendendo as Nomenclaturas

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
- Em uma tabela de **usuários**, a chave estrangeira pode ser `condominio_id`, que faz referência à tabela `condominio` e liga um usuário a um condomínio específico.

# Tutorial Parte II - Criação e Relacionamento de Tabelas
