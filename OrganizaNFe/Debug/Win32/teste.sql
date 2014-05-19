CREATE TABLE cliente (
 idcliente integer NOT NULL,
 nome varchar(100),
 endereco varchar(55)
);


CREATE SEQUENCE exemplo_idcliente_seq
 INCREMENT 1
 MINVALUE 1
 MAXVALUE 9223372036854775807
 START 1
 CACHE 1;
ALTER TABLE cliente ALTER COLUMN id SET DEFAULT NEXTVAL("exemplo_idcliente_seq"::regclass);


select * from pessoa  order by 1 asc offset 0 limit 10  