/*
 * Creating enrollment table which includes general enrollment information, yearly condition flags, CRG scores, and COVID severity scores
 * Unlike with the master_claims table, we can create this table without splitting up into multiple steps (by year, data_source)
 */

drop table if exists dev.master_enrollment_temp;

create table dev.master_enrollment_temp
(
data_source bpchar(4),
year int,
uth_member_id int,
gender_cd bpchar(1),
race_cd bpchar(1),
age_derived int,
state text,
msa int,
plan_type text,
bus_cd bpchar(4),
total_enrolled_months int,
aimm int,
ami int,
ca int,
cfib int,
chf int,
ckd int,
cliv int,
copd int,
cysf int,
dep int,
epi int,
fbm int,
hemo int,
hep int,
hiv int,
ihd int,
lbp int,
lymp int,
ms int,
nicu int,
pain int,
park int,
pneu int,
ra int,
scd int,
smi int,
str int,
tbi int,
trans int,
trau int,
asth int,
dem int,
diab int,
htn int,
opi int,
tob int,
crg text,
crg_abbreviated bpchar(2),
covid_severity int
)
with (appendoptimized=true, orientation=column, compresstype=zlib)
distributed by (uth_member_id)
partition by list(data_source)
(
    partition optz values ('optz'),
    partition truv values ('truv'),
    partition mcrt values ('mcrt'),
    partition mcrn values ('mcrn'),
    partition mdcd values ('mdcd'),
    partition mhtw values ('mhtw'),
    partition mcpp values ('mcpp')
)
;

with enrl as(
select data_source, year, uth_member_id, gender_cd, race_cd, age_derived, 
		state, msa, plan_type, bus_cd, total_enrolled_months
from data_warehouse.member_enrollment_yearly a 
where a.year >= 2014
  and a.data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
),
cond  as (
select data_source, "year" , uth_member_id,
      aimm, ami, ca, cfib, chf, ckd, cliv, copd, 
		cysf, dep, epi, fbm, hemo, hep, hiv, 
		ihd, lbp, lymp, ms, nicu, pain, park, 
		pneu, ra, scd, smi, str, tbi, trans, 
		trau, asth, dem, diab, htn, opi, tob
from data_warehouse.conditions_member_enrollment_yearly 
where year >= 2014
  and data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
),
crg as (
select
	cr.data_source,
	cr.uth_member_id,
	cr.crg_year,
	cr.crg,
	concat(left(crg, 1), right(crg, 1)) as crg_abbreviated
from data_warehouse.crg_risk cr
inner join data_warehouse.member_enrollment_yearly mey 
  on  mey.uth_member_id = cr.uth_member_id
	and mey."year" = cr.crg_year 
where mey.year >= 2014
  and mey.data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
),
covid as (
select *
  from data_warehouse.covid_severity
 where data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
)
insert into dev.master_enrollment_temp
select e.*, c.aimm, c.ami, c.ca, c.cfib, c.chf, c.ckd, c.cliv, c.copd, 
		c.cysf, c.dep, c.epi, c.fbm, c.hemo, c.hep, c.hiv, 
		c.ihd, c.lbp, c.lymp, c.ms, c.nicu, c.pain, c.park, 
		c.pneu, c.ra, c.scd, c.smi, c.str, c.tbi, c.trans, 
		c.trau, c.asth, c.dem, c.diab, c.htn, c.opi, c.tob, 
		cr.crg, cr.crg_abbreviated,
		cs.severity as covid_severity
 from enrl e
 left join cond c
   on e.uth_member_id = c.uth_member_id
  and e.year = c.year
 left join crg cr
   on e.uth_member_id = cr.uth_member_id
  and e.year = cr.crg_year
 left join covid cs
   on e.uth_member_id = cs.uth_member_id
  and e.year = cs.year
;



----- Counts for QA
select *
from (
select 'master_enrollment' as table, data_source, year, count(distinct uth_member_id)
  from dev.master_enrollment_temp
 group by 2,3
union
select 'enrollment_only' as table, data_source, year, count(distinct uth_member_id) 
  from data_warehouse.member_enrollment_yearly
 where data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
   and year >= 2014
 group by 2,3
) a
order by 3,2,1;

select *
from (
select 'master_enrollment' as table, data_source, year, count(distinct uth_member_id) 
  from dev.master_enrollment_temp 
 where covid_severity is not null 
 group by 2,3
union
select 'severity' as table, data_source, year, count(distinct uth_member_id) 
  from tableau.dw_severity_2020 
 where data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
 group by 2,3
) a
order by 3,2,1;

select *
from (
select 'master_enrollment' as table, data_source, year, count(distinct uth_member_id) 
 from dev.master_enrollment_temp 
group by 2,3
union
select 'conditions' as table, data_source, year, count(distinct uth_member_id) 
 from data_warehouse.conditions_member_enrollment_yearly
where data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
  and year >= 2014
group by 2,3
) a
order by 3,2,1;

select *
from (
select 'master_enrollment' as table, data_source, year, count(distinct uth_member_id) 
 from tableau.master_enrollment
where crg is not null
group by 2,3
union
select 'crg' as table, data_source, crg_year, count(distinct uth_member_id) 
 from data_warehouse.crg_risk 
where data_source in ('optz', 'truv','mcrt','mcrn', 'mdcd', 'mhtw', 'mcpp')
  and crg_year >= 2014
group by 2,3
) a
order by 3,2,1;

-- change permissions instead
alter table tableau.master_enrollment owner to uthealth_dev;

grant select on tableau.master_enrollment to uthealth_analyst;

analyze tableau.master_enrollment;

select * from tableau.master_enrollment;
