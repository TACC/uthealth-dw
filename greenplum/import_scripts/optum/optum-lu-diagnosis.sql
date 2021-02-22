--Medical
drop table optum_zip.lu_diagnosis;
create table optum_zip.lu_diagnosis (
DIAG_CD varchar(100),DIAG_DESC varchar(100),DIAG_FST3_CD varchar(100),DIAG_FST3_DESC varchar(100),DIAG_FST4_CD varchar(100),
DIAG_FST4_DESC varchar(100),GDR_SPEC_CD varchar(100),MDC_CD_DESC varchar(100),MDC_CODE varchar(100),ICD_VER_CD varchar(100)
) 
WITH (appendonly=true, orientation=column)
distributed randomly;

drop external table ext_temp;
CREATE EXTERNAL TABLE ext_lu_diagnosis (
DIAG_CD varchar(100),DIAG_DESC varchar(100),DIAG_FST3_CD varchar(100),DIAG_FST3_DESC varchar(100),DIAG_FST4_CD varchar(100),
DIAG_FST4_DESC varchar(100),GDR_SPEC_CD varchar(100),MDC_CD_DESC varchar(100),MDC_CODE varchar(100),ICD_VER_CD varchar(100)
) 
LOCATION ( 
'gpfdist://c252-136:8081/optum_zip/lu_diagnosis.txt.gz'
)
FORMAT 'CSV' ( HEADER DELIMITER '|' );

-- Test
select *
from ext_lu_diagnosis
limit 1000;

-- Insert
insert into optum_zip.lu_diagnosis
select * from ext_lu_diagnosis;

-- Analyze
analyze optum_zip.lu_diagnosis;

--Verify
select count(*) from optum_zip.lu_diagnosis;