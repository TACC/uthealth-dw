--Medical
drop table optum_dod.provider_bridge;
create table optum_dod.provider_bridge (
PROV_UNIQUE bigint, DEA char(9), NPI char(10), PROV bigint, EXTRACT_YM int, VERSION numeric
)
WITH (appendonly=true, orientation=column)
distributed randomly;

drop external table ext_provider_bridge;
CREATE EXTERNAL TABLE ext_provider_bridge (
PROV_UNIQUE bigint, DEA char(9), NPI char(10), PROV bigint, EXTRACT_YM int, VERSION numeric
) 
LOCATION ( 
'gpfdist://c252-140:8801/dod_provider_bridge.txt'
)
FORMAT 'CSV' ( HEADER DELIMITER '|' );

-- Test
select *
from ext_provider_bridge
limit 1000;

-- Insert
insert into optum_dod.provider_bridge
select * from ext_provider_bridge;

-- Analyze
analyze optum_dod.provider_bridge;

--Verify
select count(*) from optum_dod.provider_bridge;