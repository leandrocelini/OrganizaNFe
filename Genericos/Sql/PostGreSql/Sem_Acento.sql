--------------------------------------------------------------
--Funחדo utilizada para retirar acentos de uma string
--
--------------------------------------------------------------
CREATE OR REPLACE FUNCTION Sem_Acento(text) RETURNS text AS $$
--------------------------------------------------------------
   Select to_ascii(convert($1,getdatabaseencoding(),'LATIN1'), 'LATIN1');

   --SELECT translate($1,
   --                 'ביםףתאטלעשדץגךמפפהכןצüחֱֹֽ׃ÚְָּׂÙֳױֲÊ־װÛִֻֿײÜַ', 
   --                 'aeiouaeiouaoaeiooaeioucAEIOUAEIOUAOAEIOOAEIOUC')   
$$ LANGUAGE SQL IMMUTABLE  RETURNS NULL ON NULL INPUT;
