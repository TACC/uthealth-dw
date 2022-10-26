-- medicaid.clm_detail definition

-- Drop table

-- DROP TABLE medicaid.clm_detail;


drop table if exists dw_staging.claim_detail;

create table dw_staging.claim_detail
(like data_warehouse.claim_detail including defaults) 
with (
		appendonly=true, 
		orientation=row, 
		compresstype=zlib, 
		compresslevel=5 
	 )
distributed by (uth_member_id)
partition by list(data_source)
 (partition optz values ('optz'),
  partition optd values ('optd'),
  partition truv values ('truv'),
  partition mdcd values ('mdcd'),
  partition mcrt values ('mcrt'),
  partition mcrn values ('mcrn')
 )
;

grant select on dw_staging.claim_detail to uthealth_analyst;

/* ETL TABLES FOR CLEANING */


drop table if exists dw_staging.clm_detail_etl;

CREATE TABLE dw_staging.clm_detail_etl (
	icn varchar NULL,
	clm_dtl_nbr varchar NULL,
	from_dos date NULL,
	to_dos date NULL,
	proc_cd varchar NULL,
	sub_proc_cd varchar NULL,
	dtl_bill_amt numeric NULL,
	dtl_alwd_amt numeric NULL,
	dtl_pd_amt numeric NULL,
	proc_mod_1 varchar NULL,
	proc_mod_2 varchar NULL,
	pos varchar NULL,
	rev_cd varchar null,
	ref_prov_npi varchar NULL,
	perf_prov_npi varchar NULL,
	txm_cd varchar NULL,
	perf_prov_id varchar NULL,
	sub_perf_prov_sfx varchar NULL
)
WITH (
	appendonly=true,
	orientation=row,
	compresstype=zlib
)
DISTRIBUTED BY (icn);

insert into dw_staging.clm_detail_etl
select 
trim(icn),
trim(clm_dtl_nbr),
from_dos,
to_dos,
trim(proc_cd),
trim(sub_proc_cd),
dtl_bill_amt,
dtl_alwd_amt,
dtl_pd_amt,
trim(proc_mod_1),
trim(proc_mod_2),
trim(pos),
trim(rev_cd),
trim(ref_prov_npi),
trim(perf_prov_npi),
trim(txm_cd),
trim(perf_prov_id),
trim(sub_perf_prov_sfx)
from medicaid.clm_detail 
;

analyze dw_staging.clm_detail_etl;

update dw_staging.clm_detail_etl
   set clm_dtl_nbr = case when clm_dtl_nbr = '' then null else clm_dtl_nbr end,
   proc_cd = case when proc_cd = '' then null else proc_cd end,
   sub_proc_cd = case when sub_proc_cd = '' then null else sub_proc_cd end,
   proc_mod_1 = case when proc_mod_1 = '' then null else proc_mod_1 end,
   proc_mod_2 = case when proc_mod_2 = '' then null else proc_mod_2 end,
   pos = case when pos = '' then null else pos end,
   rev_cd = case when rev_cd = '' then null else rev_cd end,
   ref_prov_npi = case when ref_prov_npi = '' then null else ref_prov_npi end,
   perf_prov_npi = case when perf_prov_npi = '' then null else perf_prov_npi end,
   txm_cd = case when txm_cd = '' then null else txm_cd end,
   perf_prov_id = case when perf_prov_id = '' then null else perf_prov_id end,
   sub_perf_prov_sfx = case when sub_perf_prov_sfx = '' then null else sub_perf_prov_sfx end;

update dw_staging.clm_detail_etl
   set proc_cd = case when length(proc_cd) < 5 then null else proc_cd end,
       sub_proc_cd  = case when length(sub_proc_cd) < 5 then null else sub_proc_cd end,
       rev_cd = lpad(rev_cd,4,'0');

update dw_staging.clm_detail_etl
   set proc_cd = sub_proc_cd where proc_cd is null and sub_proc_cd is not null;
       
vacuum analyze dw_staging.clm_detail_etl;


-----------------------HEADER------------------------------

drop table if exists dw_staging.clm_header_etl;

CREATE TABLE dw_staging.clm_header_etl (
	icn varchar NULL,
	adm_dt varchar NULL,
	dis_dt varchar NULL,
	pat_stat_cd varchar NULL
)
WITH (
	appendonly=true,
	orientation=row,
	compresstype=zlib
)
DISTRIBUTED BY (icn);

insert into dw_staging.clm_header_etl 
select 
trim(icn),
trim(adm_dt),
trim(dis_dt),
trim(pat_stat_cd)
from medicaid.clm_header ;

analyze dw_staging.clm_header_etl ;

update dw_staging.clm_header_etl
   set adm_dt = case when adm_dt = '' then null else adm_dt end,
       dis_dt = case when dis_dt = '' then null else dis_dt end,
       pat_stat_cd = case when pat_stat_cd = '' then null else pat_stat_cd end;
  
vacuum analyze dw_staging.clm_header_etl ;

--------------------------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------



CREATE TABLE dw_staging.clm_proc_etl (
	icn varchar NULL,
	pcn varchar NULL,
	drg varchar null,
	bill varchar null
)
WITH (
	appendonly=true,
	orientation=row,
	compresstype=zlib
)
DISTRIBUTED BY (icn);

insert into dw_staging.clm_proc_etl
select trim(icn),
       trim(pcn),
       trim(drg),
       trim(bill)
  from medicaid.clm_proc 
  ;
  
analyze dw_staging.clm_proc_etl;

update dw_staging.clm_proc_etl
   set drg = case when drg = '' then null else drg end,
       bill = case when bill = '' then null else bill end;
  
vacuum analyze dw_staging.clm_proc_etl;


------------master table -----------------

drop table if exists dw_staging.detail_etl;

CREATE TABLE dw_staging.detail_etl (
	icn varchar NULL,
	pcn varchar NULL,
	clm_dtl_nbr varchar NULL,
	from_dos date NULL,
	to_dos date NULL,
	proc_cd varchar NULL,
	dtl_bill_amt numeric NULL,
	dtl_alwd_amt numeric NULL,
	dtl_pd_amt numeric NULL,
	proc_mod_1 varchar NULL,
	proc_mod_2 varchar NULL,
	pos varchar NULL,
	rev_cd varchar null,
	ref_prov_npi varchar NULL,
	perf_prov_npi varchar NULL,
	txm_cd varchar NULL,
	perf_prov_id varchar NULL,
	sub_perf_prov_sfx varchar null,
	adm_dt date NULL,
	dis_dt date NULL,
	pat_stat_cd varchar null,
	drg varchar null,
	bill_i varchar null,
	bill_c varchar null,
	bill_f varchar null
)
WITH (
	appendonly=true,
	orientation=row,
	compresstype=zlib
)
DISTRIBUTED BY (icn);

insert into dw_staging.detail_etl 
select 
h.icn,
p.pcn,
clm_dtl_nbr,
from_dos,
to_dos,
proc_cd,
dtl_bill_amt,
dtl_alwd_amt,
dtl_pd_amt,
proc_mod_1,
proc_mod_2,
pos,
rev_cd,
ref_prov_npi,
perf_prov_npi,
txm_cd,
perf_prov_id,
sub_perf_prov_sfx,
adm_dt::date,
dis_dt::date,
pat_stat_cd,
drg,
substring(bill,1,1),
substring(bill,2,1),
substring(bill,3,1)
from dw_staging.clm_header_etl h 
join dw_staging.clm_proc_etl p 
on h.icn = p.icn 
join dw_staging.clm_detail_etl d 
on d.icn = h.icn 
;

analyze dw_staging.detail_etl ;

drop table dw_staging.clm_header_etl;
drop table dw_staging.clm_proc_etl;
drop table dw_staging.clm_detail_etl ;
	  
--vacuum analyze dw_staging.detail_etl ;

insert into dw_staging.claim_detail
select distinct 
    'mdcd' as data_source,
	extract(year from a.from_dos) as year,
	b.uth_member_id as uth_member_id,
	b.uth_claim_id as uth_claim_id,
	a.clm_dtl_nbr::int as claim_sequence_number,
	a.from_dos as from_date_of_service,
	a.to_dos as to_date_of_service,
	get_my_from_date(a.from_dos) as month_year_id,
	a.pos as place_of_service,
	true as network_ind,
	true as network_paid_ind,
	a.adm_dt as admit_date,
	a.dis_dt as discharge_date,
	a.pat_stat_cd as discharge_status,
	a.proc_cd as cpt_hcpcs_cd,
	null as procedure_type,
	a.proc_mod_1 as proc_mod_1,
	a.proc_mod_2 as proc_mod_2,
	a.drg as drg_cd,
	a.rev_cd as revenue_cd,
	a.dtl_bill_amt as charge_amount,
	a.dtl_alwd_amt as allowed_amount,
	a.dtl_pd_amt as paid_amount,
	null::int as copay,
	null::int as deductible,
	null::int as coins,
	null::int as cob,
	bill_i,
	bill_c,
	bill_f,
	null::int as units,
	dev.fiscal_year_func(a.from_dos) as fiscal_year,
	null::int as cost_factor_year,
	'clm_detail' as table_id_src,
	null as claim_sequence_number_src,
	null as bill_provider,
	a.ref_prov_npi as ref_provider,
	null as other_provider,
	a.perf_prov_npi as perf_rn_provider,
	null as perf_at_provider,
	null as perf_op_provider,
	a.icn as claim_id_src,
	a.pcn as member_id_src,
	current_date as load_date,
	a.txm_cd as provider_type
from dw_staging.detail_etl a 
join data_warehouse.dim_uth_claim_id b 
  on a.pcn = b.member_id_src 
 and a.icn = b.claim_id_src 
 and b.data_source = 'mdcd'
;

analyze dw_staging.claim_detail;
