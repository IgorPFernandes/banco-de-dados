create database selecao_bi;

create table candidatos(
	id SERIAL primary key,
	nome VARCHAR(100),
	email VARCHAR(100),
	data_aplicacao TIMESTAMP,
	modificado_por VARCHAR(100) null
);

create table habilidades(
	id_habilidade SERIAL primary key,
	candidato_id INTEGER,
	habilidade VARCHAR(100),
	foreign key (candidato_id) references candidatos (id)
);


insert into candidatos(nome, email, data_aplicacao)
values
('Ana','ana@hotmail.com','2025-03-01 14:00:00'),
('Igor', 'igor@gmail.com', '2025-05-01 21:23:00'),
('João', 'joao@outlook.com', '2025-12-30 15:24:00'),
('Ale', 'ale@gmail.com', '2025-08-17 08:12:00'),
('Jose', 'jose@gmail.com', '2025-12-06 05:10:59');

insert into habilidades(candidato_id, habilidade)
values
(1,'datilografia'),
(1,'programação python'),
(2,'inglês avançado'),
(3,'inglês intermediário'),
(3,'programação java'),
(3,'sql'),
(4,'postgres'),
(4,'manutenção de computadores'),
(4,'rede de computadores'),
(5,'inglês iniciante'),
(5,'Power BI');


create database selecao_bi_restore;

-- pg_dump -U igor -h localhost -F p -f "C:\Users\igorp\OneDrive\Desktop\Meus Estudos\Aprendizagem Individual\Banco de Dados\PostgreSQL\Teste_BI\Backup\selecao_bi_backup.sql" selecao_bi

-- pg_restore -U igor -h localhost -d selecao_bi_restore "C:\Users\igorp\OneDrive\Desktop\Meus Estudos\Aprendizagem Individual\Banco de Dados\PostgreSQL\Teste_BI\Backup\backup.dump"

select * from candidatos;

update candidatos
set modificado_por = 'igor'
where modificado_por is null;

select * from candidatos;

insert into habilidades(candidato_id,habilidade)
values
(3,'git hub');

delete from habilidades
where candidato_id = 1;

delete from candidatos
where id = 1;

select * from candidatos;

select * from habilidades;

select c.nome, h.habilidade
from candidatos c
join habilidades h on c.id  = h.candidato_id 
order by nome;

-- Condição de tratamento adicional para caso você esteja lidando com um banco bagunçado (dica do ale)
update habilidades
set habilidade = lower(habilidade);
-- Perceba que P de Power BI estava maiúsculo

select * from habilidades; -- Agora está minúsculo

select c.nome, h.habilidade
from candidatos c
join habilidades h on c.id  = h.candidato_id 
where h.habilidade = 'sql' or h.habilidade = 'python';

select c.nome, (select count(h.habilidade) from habilidades h where h.candidato_id=c.id)
from candidatos c;

with candidatos_java as(
	select c.id,c.nome
	from candidatos c
	join habilidades h on c.id = h.candidato_id
	where h.habilidade = 'programação java'
)
select * from candidatos_java;
