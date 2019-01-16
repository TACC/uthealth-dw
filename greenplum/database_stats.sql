
select
   n.nspname,
   relname,
   reloptions,
   relacl,
   reltuples AS "#entries", pg_size_pretty(relpages::bigint*8*1024) AS size
   FROM pg_class
   JOIN pg_catalog.pg_namespace n ON n.oid = pg_class.relnamespace
   WHERE relpages >= 8
   and n.nspname in ('truven', 'optum')
   ORDER BY n.nspname, relpages desc;
   
   
  select * 
  from pg_namespace;