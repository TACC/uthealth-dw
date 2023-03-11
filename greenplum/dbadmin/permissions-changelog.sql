
/* ******************************************************************************************************
 * This script contains several code blocks useful for controlling user access on the Greenplum Server
 * and contains definitions for user roles
 * ******************************************************************************************************
 *  Author 			|| Date      	|| Notes
 * ******************************************************************************************************
 * Xiaorui Zhang	|| 03/10/2023	|| Created, added users to apcd_uthealth_analyst
 * 
 * ****************************************************************************************************** */

--03/10/2023: Created apcd_uthealth_analyst role

/*******************************************************************
 * Role definitions: apcd_uthealth_analyst
 * 
 * Purpose: Gives read access to ONLY optum_zip and data_warehouse
 * 		Gives read/write access to dev
 *******************************************************************/
drop owned by apcd_uthealth_analyst cascade;
drop role apcd_uthealth_analyst;

create role apcd_uthealth_analyst;

grant connect on database uthealth to apcd_uthealth_analyst;  --allows connection to uthealth database
grant temporary on database uthealth to apcd_uthealth_analyst; --allows creation of temp tables

grant usage on schema optum_zip to apcd_uthealth_analyst; 
grant select on all tables in schema optum_zip to apcd_uthealth_analyst; 
grant select on all sequences in schema optum_zip to apcd_uthealth_analyst;
alter default privileges in schema optum_zip grant select on tables to apcd_uthealth_analyst;

grant usage on schema data_warehouse to apcd_uthealth_analyst; 
grant select on all tables in schema data_warehouse to apcd_uthealth_analyst; 
grant select on all sequences in schema data_warehouse to apcd_uthealth_analyst;
alter default privileges in schema data_warehouse grant select on tables to apcd_uthealth_analyst;

grant all on schema apcd_test to apcd_uthealth_analyst; 
grant all on all tables in schema apcd_test to apcd_uthealth_analyst; 
grant all privileges on all sequences in schema apcd_test to apcd_uthealth_analyst;
alter default privileges in schema apcd_test grant all on tables to apcd_uthealth_analyst;

grant all on schema dev to apcd_uthealth_analyst; 
grant all on all tables in schema dev to apcd_uthealth_analyst; 
grant all privileges on all sequences in schema dev to apcd_uthealth_analyst; 
alter default privileges in schema dev grant all on tables to apcd_uthealth_analyst; 

--granted apcd_uthealth_analyst role to APCD group
grant apcd_uthealth_analyst to nguyken;
grant apcd_uthealth_analyst to mjames11;
grant apcd_uthealth_analyst to stabot90; --this username does not exist
grant apcd_uthealth_analyst to sabot90; --this exists, not sure if typo
grant apcd_uthealth_analyst to alonab13;
grant apcd_uthealth_analyst to bjack10;
grant apcd_uthealth_analyst to aryan;

--checked permissions
--Lists usernames/rolenames, assigned roles, and superuser status
--just for APCD people
SELECT r.rolname, 
  ARRAY(SELECT b.rolname
        FROM pg_catalog.pg_auth_members m
        JOIN pg_catalog.pg_roles b ON (m.roleid = b.oid)
        WHERE m.member = r.oid) as memberof
, r.rolsuper
FROM pg_catalog.pg_roles r
WHERE r.rolname !~ '^pg_'
and r.rolname in ('nguyken', 'mjames11', 'sabot90', 'alonab13', 'bjack10', 'aryan')
ORDER BY 1;

--Caroline requested access to one of Femi's tables in dev for both her and Gina
--Xiaorui was still learning how these permissions work so I kind of used the shotgun approach
set role cms2;
alter default privileges for user cms2 in schema dev grant all on tables to uthealth_analyst;
set role rhansen1;
alter default privileges for user rhansen1 in schema dev grant all on tables to uthealth_analyst;
set role oaborisa;
alter default privileges for user oaborisa in schema dev grant all on tables to uthealth_analyst;


















