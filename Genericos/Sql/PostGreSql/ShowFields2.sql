Select CAST(rel.nspname as TEXT), CAST(rel.relname AS TEXT) , CAST(attrs.attname AS TEXT), CAST("Type" AS TEXT), CAST("Default" AS TEXT), attrs.attnotnull
        FROM
               (SELECT c.oid, n.nspname, c.relname
               FROM pg_catalog.pg_class c
               LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
               WHERE pg_catalog.pg_table_is_visible(c.oid) ) rel
        JOIN 
               (SELECT a.attname, a.attrelid,
               pg_catalog.format_type(a.atttypid, a.atttypmod) as "Type",
                      (SELECT substring(d.adsrc for 128) FROM pg_catalog.pg_attrdef d
                      WHERE d.adrelid = a.attrelid AND d.adnum = a.attnum AND a.atthasdef)
               as "Default", a.attnotnull, a.attnum
               FROM pg_catalog.pg_attribute a
               WHERE a.attnum > 0 AND NOT a.attisdropped ) attrs
        ON (attrs.attrelid = rel.oid )
        WHERE relname = 'saidas'
        ORDER BY attrs.attnum;