--Medical
drop table opt_20210128.ins;
create table opt_20210128.ins (
PTID varchar, ENCID varchar, INSURANCE_DATE date,INSURANCE_TIME time, INS_TYPE varchar,SOURCEID varchar
) 
WITH (appendonly=true, orientation=column, compresstype=zlib)
distributed by(ptid);

-- NOTE: Load each year 1 by one updating the gpfdist string and hard coded YEAR value in insert statement.

drop external table ext_covid_ins;
CREATE EXTERNAL TABLE ext_covid_ins (
PTID varchar, ENCID varchar, INSURANCE_DATE date,INSURANCE_TIME time, INS_TYPE varchar,SOURCEID varchar
) 
LOCATION ( 
'gpfdist://greenplum01:8081/covid/20210128/*ins*.txt.gz'
)
FORMAT 'text' ( HEADER DELIMITER '|' null as '' escape 'OFF');

-- Test
/*
select *
from ext_covid_ins
limit 1000;
*/
-- Insert: 14s, Updated Rows	68,071,486
insert into opt_20210128.ins
select * from ext_covid_ins;

--Scratch
select count(*)
from opt_20210128.ins
group by 1
order by 1;