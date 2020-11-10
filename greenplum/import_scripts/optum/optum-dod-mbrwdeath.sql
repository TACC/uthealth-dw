--optum_zip mbrwdeath load
drop table optum_zip.mbrwdeath;
create table optum_zip.mbrwdeath (
PatID bigint, Death_ym Date, Extract_ym Date, VERSION numeric
) 
WITH (appendonly=true, orientation=column, compresstype=zlib)
distributed by (patid);

drop external table ext_mbrwdeath;
CREATE EXTERNAL TABLE ext_mbrwdeath (
PatID bigint, Death_ym int, Extract_ym int, VERSION numeric
) 
LOCATION ( 
'gpfdist://192.168.58.179:8081/optum_zip/zip5_mbrwdeath.txt.gz'
)
FORMAT 'CSV' ( HEADER DELIMITER '|' );

-- Test
select *
from ext_mbrwdeath
limit 1000;

-- Insert
insert into optum_zip.mbrwdeath
select ex.PatID
      ,(ex.Death_ym::varchar || '01')::date
      ,(ex.Extract_ym::varchar || '01')::date
      ,ex.Version
from ext_mbrwdeath ex;

-- Analyze
analyze optum_zip.mbrwdeath;

--Verify
select count(*) from optum_zip.mbrwdeath;
