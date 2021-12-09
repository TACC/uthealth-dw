/* 
******************************************************************************************************
 *  This script loads optum_dod/zip.medical table
 *  refresh table is provided in most recent quarters 
 *  delete quarters provided in refresh, then load
 *
 * data should be staged in a parent folder with the year matching the filename year, a manual step
 * Examples: staging/optum_dod_refresh/2018/dod_proc2018q1.txt.gz, staging/optum_dod_refresh/2019/dod_proc2019q1.txt.gz
 * ******************************************************************************************************
 *  Author || Date      || Notes
 * ******************************************************************************************************
 *  wallingTACC  ||8/25/2021 || comments added
 * ******************************************************************************************************
 */

/* Original Create
drop table optum_dod.medical;
create table optum_dod.medical (
year smallint, file varchar,
PATID bigint,PAT_PLANID bigint,ADMIT_CHAN char(16),ADMIT_TYPE char(1),BILL_PROV numeric,CHARGE numeric,
CLMID char(19),CLMSEQ char(5),COB char(5),COINS numeric,CONF_ID char(21),COPAY numeric,DEDUCT numeric,
    DRG char(5),DSTATUS char(2),ENCTR char(2),FST_DT date,HCCC char(2),ICD_FLAG char(2),LOC_CD char(1),LST_DT date,NDC char(11),PAID_DT date,
PAID_STATUS char(2),POS char(5),PROC_CD char(7),
PROCMOD char(5),PROV numeric,PROV_PAR char(5),PROVCAT char(4),REFER_PROV numeric,RVNU_CD char(4),SERVICE_PROV numeric,STD_COST numeric,STD_COST_YR char(4),TOS_CD char(13),
UNITS numeric,EXTRACT_YM  char(6),VERSION  char(6),
ALT_UNITS text, BILL_TYPE text, NDC_UOM text, NDC_QTY text, OP_VISIT_ID text, PROCMOD2 text, PROCMOD3 text, PROCMOD4 text, TOS_EXT text
) 
WITH (appendonly=true, orientation=column, compresstype=zlib)
distributed by (patid);
*/

drop external table ext_medical;
CREATE EXTERNAL TABLE ext_medical (
year smallint, file varchar,
PATID bigint,PAT_PLANID bigint,ADMIT_CHAN char(16),ADMIT_TYPE char(1),BILL_PROV numeric,CHARGE numeric,
CLMID char(19),CLMSEQ char(5),COB char(5),COINS numeric,CONF_ID char(21),COPAY numeric,DEDUCT numeric,
    DRG char(5),DSTATUS char(2),ENCTR char(2),FST_DT date,HCCC char(2),ICD_FLAG char(2),LOC_CD char(1),LST_DT date,NDC char(11),PAID_DT date,
PAID_STATUS char(2),POS char(5),PROC_CD char(7),
PROCMOD char(5),PROV numeric,PROV_PAR char(5),PROVCAT char(4),REFER_PROV numeric,RVNU_CD char(4),SERVICE_PROV numeric,STD_COST numeric,STD_COST_YR char(4),TOS_CD char(13),
UNITS numeric,EXTRACT_YM  char(6),VERSION  char(6),
ALT_UNITS text, BILL_TYPE text, NDC_UOM text, NDC_QTY text, OP_VISIT_ID text, PROCMOD2 text, PROCMOD3 text, PROCMOD4 text, TOS_EXT text
) 
LOCATION ( 
'gpfdist://greenplum01.corral.tacc.utexas.edu:8081/uthealth/optum_dod/\*/dod_m2*.txt.gz#transform=add_parentname_filename_vertbar'
)
FORMAT 'CSV' ( HEADER DELIMITER '|' );

-- Test
select *
from ext_medical
where year=2019
limit 1000;


-- Insert
insert into optum_dod.medical (
PATID,PAT_PLANID,ADMIT_CHAN,ADMIT_TYPE,BILL_PROV,CHARGE,
CLMID,CLMSEQ,COB,COINS,CONF_ID,COPAY,DEDUCT,
DRG,DSTATUS,ENCTR,FST_DT,HCCC,ICD_FLAG,LOC_CD,LST_DT,NDC,PAID_DT,
PAID_STATUS,POS,PROC_CD,
PROCMOD,PROV,PROV_PAR,PROVCAT,REFER_PROV,RVNU_CD,SERVICE_PROV,STD_COST,STD_COST_YR,TOS_CD,
UNITS,EXTRACT_YM,VERSION,
ALT_UNITS, BILL_TYPE, NDC_UOM, NDC_QTY, OP_VISIT_ID, PROCMOD2, PROCMOD3, PROCMOD4, TOS_EXT, member_id_src)
select PATID,PAT_PLANID,ADMIT_CHAN,ADMIT_TYPE,BILL_PROV,CHARGE,
trim(CLMID),CLMSEQ,COB,COINS,CONF_ID,COPAY,DEDUCT,
DRG,DSTATUS,ENCTR,FST_DT,HCCC,ICD_FLAG,LOC_CD,LST_DT,NDC,PAID_DT,
PAID_STATUS,POS,PROC_CD,
PROCMOD,PROV,PROV_PAR,PROVCAT,REFER_PROV,RVNU_CD,SERVICE_PROV,STD_COST,STD_COST_YR,TOS_CD,
UNITS,EXTRACT_YM,VERSION,
ALT_UNITS, BILL_TYPE, NDC_UOM, NDC_QTY, OP_VISIT_ID, PROCMOD2, PROCMOD3, PROCMOD4, TOS_EXT, patid::text
from ext_medical;

insert into optum_dod.medical
select * from ext_medical;

-- Fix Distribution
create table optum_dod.medical_new
WITH (appendonly=true, orientation=column, compresstype=zlib)
as select PATID,PAT_PLANID,ADMIT_CHAN,ADMIT_TYPE,BILL_PROV,CHARGE,
trim(CLMID),CLMSEQ,COB,COINS,CONF_ID,COPAY,DEDUCT,
DRG,DSTATUS,ENCTR,FST_DT,HCCC,ICD_FLAG,LOC_CD,LST_DT,NDC,PAID_DT,
PAID_STATUS,POS,PROC_CD,
PROCMOD,PROV,PROV_PAR,PROVCAT,REFER_PROV,RVNU_CD,SERVICE_PROV,STD_COST,STD_COST_YR,TOS_CD,
UNITS,EXTRACT_YM,VERSION,
ALT_UNITS, BILL_TYPE, NDC_UOM, NDC_QTY, OP_VISIT_ID, PROCMOD2, PROCMOD3, PROCMOD4, TOS_EXT
from optum_dod.medical
distributed by (patid);


select count(*) from optum_dod.medical_new;
--delete from optum_dod.medical where year=0;

select count(*)
from optum_dod.medical
where year=0;

-- Analyze
vacuum analyze optum_dod.medical;

select count(*), min(year), max(year), count(distinct year) from optum_dod.medical;

select year, date_part('quarter', FST_DT) as quarter, count(*), min(FST_DT), max(FST_DT)
from optum_dod.medical
group by 1, 2
order by 1, 2;

--Refresh
delete
from optum_dod.medical 
where year is null;
where file >= 'dod_m2018q2%';

select file, count(*)
from optum_dod.medical 
where file >= 'dod_m2018q1%'
group by 1
order by 1;