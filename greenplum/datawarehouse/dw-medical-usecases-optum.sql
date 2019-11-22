/*
* Examine various claim 'stories' at the raw data level.
*/

--Case 1: A dementia patient with mobility therapy sessions.

@set clmid = '4111219171'

--Case 2: Dorsalgia (upper back pain) radiology imaging

@set clmid = '4084387213'

--Case 3: Confinement

@set clmid = '4127563691'

--Case 4: Has confinement, but no admit info

@set clmid = '187810755'
@set patid = '33104078443'
/*
 * Queries
 */
select distinct m.clmid, m.clmseq, m.fst_dt,
d.clmid as has_diag, p.clmid as has_proc, fd.clmid as has_fd, 
m.prov_par in_network,
m.proc_cd, h.code as hcpcs_code, h.short_desc as hcpcs_short_desc, c.code as cms_proc_code, c.desc as cms_proc_desc,
d.diag, i.icd_10, i.description as primary_diag,
rat.value as admit_type_val,
rac.value_derived as admit_channel_val,
'MEDICAL:',
m.*,
'CONFINEMENT:',
con.*,
'DIAGNOSTIC:',
d.*
from dev2016.optum_dod_medical m
left join optum_dod.ref_admit_type rat on m.admit_type::varchar=rat.key::varchar
left join optum_dod.ref_admit_channel rac on m.admit_chan::varchar=rac.key::varchar and case when m.admit_chan='4' then rac.type_id=4 else rac.type_id is null end
left join optum_dod_diagnostic d on m.clmid=d.clmid and m.fst_dt=d.fst_dt and d.diag_position=1
left join optum_dod_confinement con on m.conf_id=con.conf_id
left join optum_dod_procedure p on m.clmid=p.clmid and m.fst_dt = p.fst_dt
left join optum_dod_facility_detail fd on m.clmid=fd.clmid
left join reference_tables.hcpcs h on m.proc_cd=h.code
left join reference_tables.cms_proc_codes c on m.proc_cd=c.code
left join reference_tables.icd_10 i on d.diag=i.icd_10
where m.clmid=:clmid -- and m.patid=:patid
order by m.clmseq;

--Admit type and channels
select rat.value as type, rac.value_derived as channel, count(*)
from optum_dod_medical m
left join optum_dod.ref_admit_type rat on m.admit_type::varchar=rat.key::varchar
left join optum_dod.ref_admit_channel rac on m.admit_chan::varchar=rac.key::varchar and case when m.admit_chan='4' then rac.type_id=4 else rac.type_id is null end
group by 1, 2
order by 3 desc;

-- Individual tables
select * from optum_dod_medical
where clmid=:clmid
order by clmseq, fst_dt;

select * from optum_dod_diagnostic
where clmid=:clmid
order by fst_dt, diag_position;

select * from optum_dod_procedure
where clmid=:clmid;

select * from optum_dod_facility_detail
where clmid=:clmid;

select * from optum_dod_confinement
where clmid=:clmid;

--Scratch

select *
from optum_dod.diagnostic
where clmid=:clmid

select clmid, conf_id 
from optum_dod_medical
where conf_id is not null;

select clmid from optum_dod_confinement

select * from reference_tables.hcpcs where code like '%97116%';