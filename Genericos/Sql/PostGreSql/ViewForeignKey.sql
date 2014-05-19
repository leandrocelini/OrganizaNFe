SELECT current_database()::information_schema.sql_identifier AS constraint_catalog, 
       ncon.nspname::information_schema.sql_identifier AS constraint_schema, 
       con.conname::information_schema.sql_identifier AS constraint_name, 
       c.relname as constraint_table,
       CASE
           WHEN npkc.nspname IS NULL THEN NULL::name
           ELSE current_database()
       END::information_schema.sql_identifier AS unique_constraint_catalog, 
       npkc.nspname::information_schema.sql_identifier AS unique_constraint_schema, 
       pkc.conname::information_schema.sql_identifier AS unique_constraint_name,
       pkclass.relname as unique_constraint_table,
       CASE con.confmatchtype
           WHEN 'f'::"char" THEN 'FULL'::text
           WHEN 'p'::"char" THEN 'PARTIAL'::text
           WHEN 'u'::"char" THEN 'NONE'::text
           ELSE NULL::text
       END::information_schema.character_data AS match_option, 
       CASE con.confupdtype
           WHEN 'c'::"char" THEN 'CASCADE'::text
           WHEN 'n'::"char" THEN 'SET NULL'::text
           WHEN 'd'::"char" THEN 'SET DEFAULT'::text
           WHEN 'r'::"char" THEN 'RESTRICT'::text
           WHEN 'a'::"char" THEN 'NO ACTION'::text
           ELSE NULL::text
       END::information_schema.character_data AS update_rule, 
       CASE con.confdeltype
           WHEN 'c'::"char" THEN 'CASCADE'::text
           WHEN 'n'::"char" THEN 'SET NULL'::text
           WHEN 'd'::"char" THEN 'SET DEFAULT'::text
           WHEN 'r'::"char" THEN 'RESTRICT'::text
           WHEN 'a'::"char" THEN 'NO ACTION'::text
           ELSE NULL::text
       END::information_schema.character_data AS delete_rule
       FROM pg_namespace ncon
       JOIN pg_constraint con ON ncon.oid = con.connamespace
       JOIN pg_class c ON con.conrelid = c.oid
       LEFT JOIN (pg_constraint pkc JOIN pg_namespace npkc ON pkc.connamespace = npkc.oid) ON con.confrelid = pkc.conrelid AND information_schema._pg_keysequal(con.confkey, pkc.conkey)
       LEFT JOIN pg_class pkclass ON pkc.conrelid = pkclass.oid
       WHERE c.relkind = 'r'::"char" AND 
             con.contype = 'f'::"char" AND 
             ((pkc.contype = ANY (ARRAY['p'::"char", 'u'::"char"])) OR pkc.contype IS NULL) AND 
             pg_has_role(c.relowner, 'USAGE'::text) AND
             pg_catalog.pg_table_is_visible(c.oid);