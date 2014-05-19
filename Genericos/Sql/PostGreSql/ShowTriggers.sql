-----------------------------------------------------------------
--Função Utilizada para retornar as triggers do schema corrente do banco
--
--Retorno:
--         Lista de triggers do sistema
--
--
--Autor: João Paulo Francisco Bellucci
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ShowTriggers() RETURNS SETOF text AS $$
------------------------------------------------------------------
DECLARE
   rTriggers RECORD; --Registro que contem as triggers do sistema
   cSchema text;
BEGIN   
   cSchema := current_schema();
   
   --Pega os movimentos necessários para inclusão
   FOR rTriggers IN ( SELECT c.relname as TableName,
                            n.nspname as SchemaName,
                            t.tgname as TriggerName
                            FROM pg_catalog.pg_class c, pg_trigger t, pg_namespace n
                            WHERE ( pg_catalog.pg_table_is_visible(c.oid) ) And
                                     ( c.oid = t.tgrelid ) And 
                                        ( n.oid = c.relnamespace ) And
                                           ( n.nspname = cSchema )
                            ORDER BY t.tgname ) LOOP
      RETURN NEXT rTriggers.TriggerName;
   END LOOP;
END
$$ LANGUAGE 'plpgsql';