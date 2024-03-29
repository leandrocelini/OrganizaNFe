        ��  ��                  �  X   F U N C _ P O S T G R E S Q L   P E S Q U I S A _ T A B E L A       0         ----------------------------------------------------------------------------
--Fun��o Utilizada para pesquisar se a tabela existe no banco
--Parametros:
--            cTabela - Nome da tabela
--            
--
--Retorno:
--         bool = True se encontrou 
--                False se n�o encontrou
--
--Autor:Jo�o Paulo Francisco Bellucci
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

$$ LANGUAGE 'plpgsql';�  P   F U N C _ P O S T G R E S Q L   S H O W T A B L E S         0         ---------------------------------------------------------------
--Fun��o Utilizada para retornar as tabelas do schema do banco
--Parametros:
--            cTabela - Nome da tabela
--            
--
--Retorno:
--         bool = True se encontrou 
--                False se n�o encontrou
--
--Autor:Jo�o Paulo Francisco Bellucci
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
   
   --Pega os movimentos necess�rios para inclus�o
   FOR rTabelas IN ( SELECT rel.nspname, rel.relname
			    FROM ( SELECT c.oid, n.nspname, c.relname   
					  FROM pg_catalog.pg_class c
					  LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
					  WHERE ( pg_catalog.pg_table_is_visible(c.oid) ) AND ( n.nspname = cSchema ) AND
						( c.relkind = 'r' ) ) rel ) LOOP

      RETURN NEXT rTabelas.relname;   
   END LOOP;
END

$$ LANGUAGE 'plpgsql';  !  T   F U N C _ P O S T G R E S Q L   S H O W T R I G G E R S         0         -----------------------------------------------------------------
--Fun��o Utilizada para retornar as triggers do schema corrente do banco
--
--Retorno:
--         Lista de triggers do sistema
--
--
--Autor: Jo�o Paulo Francisco Bellucci
------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ShowTriggers() RETURNS SETOF text AS $$
------------------------------------------------------------------
DECLARE
   rTriggers RECORD; --Registro que contem as triggers do sistema
   cSchema text;
BEGIN   
   cSchema := current_schema();
   
   --Pega os movimentos necess�rios para inclus�o
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
$$ LANGUAGE 'plpgsql';   q  P   F U N C _ P O S T G R E S Q L   S E M _ A C E N T O         0         --------------------------------------------------------------
--Fun��o utilizada para retirar acentos de uma string
--
--------------------------------------------------------------
CREATE OR REPLACE FUNCTION Sem_Acento(text) RETURNS text AS $$
--------------------------------------------------------------
   Select to_ascii(convert($1,getdatabaseencoding(),'LATIN1'), 'LATIN1');

   --SELECT translate($1,
   --                 '����������������������������������������������', 
   --                 'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')   
$$ LANGUAGE SQL IMMUTABLE  RETURNS NULL ON NULL INPUT;
   