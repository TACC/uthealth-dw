
/* ******************************************************************************************************
 *  load claim header for medicare texas
 * ******************************************************************************************************
 *  Author || Date      || Notes
 * ******************************************************************************************************
 * ******************************************************************************************************
 *  wcc001  || 10/01/2021 || add comment block. migrate to dw_staging load 
 * ****************************************************************************************************** 
 * */


--------------- BEGIN SCRIPT -------

/*  !! you should run this table build in the medicare national script since both are usually loaded together, 
 *     but if you are only doing medicare texas then adjust accordingly
 *  !!
 * 
---create a copy of production data warehouse table 
drop table if exists dw_staging.claim_header;

create table dw_staging.claim_header 
with (appendonly=true, orientation=column, compresstype=zlib, compresslevel=5) as 
select *
from data_warehouse.claim_header 
where data_source not in ('mcrt','mcrt')
distributed by (uth_member_id) 
;

vacuum analyze dw_staging.claim_header; 
*/

--inpatient
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)							        						        
select 'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.clm_fac_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date, 
        null, a.clm_tot_chrg_amt::numeric, null, a.clm_pmt_amt::numeric, a."year"::int2
from medicare_texas.inpatient_base_claims_k a
  join data_warehouse.dim_uth_member_id b 
    on b.data_source = 'mcrt'
   and b.member_id_src = bene_id
  join data_warehouse.dim_uth_claim_id c 
    on c.data_source = b.data_source
   and c.claim_id_src = a.clm_id
   and c.member_id_src = a.bene_id 
;

--outpatient
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)	                              
select  'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.clm_fac_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date, 
        null, a.clm_tot_chrg_amt::numeric, null, a.clm_pmt_amt::numeric, a."year"::int2
from medicare_texas.outpatient_base_claims_k a
  join data_warehouse.dim_uth_member_id b 
    on b.data_source = 'mcrt'
   and b.member_id_src = bene_id
  join data_warehouse.dim_uth_claim_id c 
    on  c.member_id_src = a.bene_id  
   and c.claim_id_src = a.clm_id
   and c.data_source = b.data_source
;


--bcarrier 
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)	                               
select  'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.nch_clm_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date,
        null, a.nch_carr_clm_sbmtd_chrg_amt::numeric, a.nch_carr_clm_alowd_amt::numeric, a.clm_pmt_amt::numeric, a.year::int2
from medicare_texas.bcarrier_claims_k a
  join data_warehouse.dim_uth_member_id b 
    on b.member_id_src = bene_id
   and b.data_source = 'mcrt'
  join data_warehouse.dim_uth_claim_id c 
    on c.member_id_src = a.bene_id 
   and c.data_source = b.data_source
   and c.claim_id_src = a.clm_id
;


--dme
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)	                              
select  'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.nch_clm_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date,
        null, a.nch_carr_clm_sbmtd_chrg_amt::numeric, a.nch_carr_clm_alowd_amt::numeric, a.clm_pmt_amt::numeric, a.year::int2
from medicare_texas.dme_claims_k a
  join data_warehouse.dim_uth_member_id b 
   on b.member_id_src = bene_id
  and b.data_source = 'mcrt'
  join data_warehouse.dim_uth_claim_id c 
    on c.member_id_src = a.bene_id 
   and c.data_source = b.data_source
   and c.claim_id_src = a.clm_id
;

--hha
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)	                               
select  'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.clm_fac_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date, 
        null, a.clm_tot_chrg_amt::numeric, null, a.clm_pmt_amt::numeric, a."year"::int2
from medicare_texas.hha_base_claims_k a
  join data_warehouse.dim_uth_member_id b 
    on b.data_source = 'mcrt'
   and b.member_id_src = bene_id
  join data_warehouse.dim_uth_claim_id c 
    on c.data_source = b.data_source
   and c.claim_id_src = a.clm_id
   and c.member_id_src = a.bene_id 
;



--hospice
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)	
select  'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.clm_fac_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date, 
        null, a.clm_tot_chrg_amt::numeric, null, a.clm_pmt_amt::numeric, a."year"::int2
from medicare_texas.hospice_base_claims_k a
  join data_warehouse.dim_uth_member_id b 
    on b.data_source = 'mcrt'
   and b.member_id_src = bene_id
  join data_warehouse.dim_uth_claim_id c 
    on c.data_source = b.data_source
   and c.claim_id_src = a.clm_id
   and c.member_id_src = a.bene_id 
;


--snf
insert into dw_staging.claim_header (data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, 
                                uth_admission_id, total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year)	                        
select  'mcrt', extract(year from a.clm_thru_dt::date), c.uth_member_id, c.uth_claim_id, a.clm_fac_type_cd, a.clm_from_dt::date, a.clm_thru_dt::date, 
        null, a.clm_tot_chrg_amt::numeric, null, a.clm_pmt_amt::numeric, a."year"::int2
from medicare_texas.snf_base_claims_k a
  join data_warehouse.dim_uth_member_id b 
    on b.data_source = 'mcrt'
   and b.member_id_src = bene_id
  join data_warehouse.dim_uth_claim_id c 
    on c.data_source = b.data_source
   and c.claim_id_src = a.clm_id
   and c.member_id_src = a.bene_id 
;

---finalize
vacuum analyze dw_staging.claim_header;

--validate
select data_source, year,  count(*)
from dw_staging.claim_header 
where data_source = 'mcrt'
group by data_source, year
order by data_source, year;

------------- / END SCRIPT 






