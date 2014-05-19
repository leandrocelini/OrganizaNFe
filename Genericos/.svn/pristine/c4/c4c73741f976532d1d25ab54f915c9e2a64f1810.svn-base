---------------------------------------------------------------
--Função Utilizada para retornar as tabelas do schema do banco
--Parametros:
--            cTabela - Nome da tabela
--            
--
--Retorno:
--         bool = True se encontrou 
--                False se não encontrou
--
--Autor:João Paulo Francisco Bellucci
----------------------------------------------------------------
CREATE OR REPLACE FUNCTION ShowTables() RETURNS SETOF text AS $$
----------------------------------------------------------------
DECLARE
   rTabelas RECORD; --Registro que contem as tabelas   
   Retorno bool;
   cSchema text;
BEGIN
   Retorno := True;
   
   cSchema := current_schema();
   
   --Pega os movimentos necessários para inclusão
   FOR rTabelas IN ( SELECT rel.nspname, rel.relname
			    FROM ( SELECT c.oid, n.nspname, c.relname   
					  FROM pg_catalog.pg_class c
					  LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
					  WHERE ( pg_catalog.pg_table_is_visible(c.oid) ) AND ( n.nspname = cSchema ) AND
						( c.relkind = 'r' ) ) rel ) LOOP

      RETURN NEXT rTabelas.relname;   
   END LOOP;
END

$$ LANGUAGE 'plpgsql';