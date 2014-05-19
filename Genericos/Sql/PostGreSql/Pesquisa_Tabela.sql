----------------------------------------------------------------------------
--Função Utilizada para pesquisar se a tabela existe no banco
--Parametros:
--            cTabela - Nome da tabela
--            
--
--Retorno:
--         bool = True se encontrou 
--                False se não encontrou
--
--Autor:João Paulo Francisco Bellucci
----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Pesquisa_Tabela(cTabela text) RETURNS bool AS $$
----------------------------------------------------------------------------
DECLARE
   rTabela RECORD; --Registro que pega a tabela retornada   
   Retorno bool;
   cSchema text;
BEGIN
   Retorno := True;

   cSchema := current_schema();

   SELECT rel.nspname, rel.relname Into rTabela
          FROM ( SELECT c.oid, n.nspname, c.relname   
   		        FROM pg_catalog.pg_class c
		        LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
	  WHERE ( pg_catalog.pg_table_is_visible(c.oid) ) AND ( n.nspname = cSchema ) AND
                   ( c.relname = lower(cTabela) ) AND ( c.relkind = 'r' ) ) rel;
   
   IF NOT FOUND THEN
      Retorno := False;
   END IF;

   RETURN Retorno;
END

$$ LANGUAGE 'plpgsql';