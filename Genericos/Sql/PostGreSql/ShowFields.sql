----------------------------------------------------------------------------------------
--
--
----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ShowFields(cTabela text) RETURNS SETOF tabela_estrutura AS $$
----------------------------------------------------------------------------------------

SELECT attname as field,
      (CASE 
          WHEN t.typname = 'numeric' THEN
             'numeric(' || information_schema._pg_numeric_precision(information_schema._pg_truetypid(att.*, t.*), information_schema._pg_truetypmod(att.*, t.*)) || ',' 
                        || information_schema._pg_numeric_scale(information_schema._pg_truetypid(att.*, t.*), information_schema._pg_truetypmod(att.*, t.*)) || ')' 
          WHEN atttypmod > 0 THEN
             CASE
                WHEN t.typname = 'bpchar' THEN 
                   'char(' || (atttypmod-4) || ')'
                ELSE
                   t.typname || '(' || (atttypmod-4) || ')'
                END
             ELSE
                CASE
                   WHEN pg_get_serial_sequence('saidas',attname) <> '' THEN
                      'serial'
                   ELSE
                      t.typname
                END
       END ) AS type,
       attnotnull as notnull,
       (SELECT adsrc FROM pg_attrdef WHERE adrelid = c.oid AND adnum = att.attnum) AS default,
       t.typname,
       atttypmod,
       atthasdef,
       (SELECT COUNT(1) FROM pg_type t2 WHERE t2.typname=t.typname) > 1 AS isdup,
       attndims
       FROM pg_class c
       JOIN pg_attribute att ON att.attrelid=c.oid And att.attstattarget = - 1
       JOIN pg_type t ON t.oid=atttypid                   
       LEFT OUTER JOIN pg_type b ON t.typelem=b.oid 
       WHERE pg_catalog.pg_table_is_visible(c.oid) AND c.relname = 'saidas' AND c.relkind = 'r'
       ORDER by attnum;