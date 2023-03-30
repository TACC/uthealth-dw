/**********************************************************************
 * Truven claim_header
 * 
 * Code originally by Will/David, updated in 2022 by J. Wozny and
 * version control added March 2023 by Xiaorui
 * ********************************************************************
 * Author  || Date       || Notes
 * ********************************************************************
 * Xiaorui || 03/23/2023 || Changed mapping of pay to match what's on
 * 							the ERD column map (verified by Lopita)
 ***********************************************************************/


with cte as (
select enrolid, msclmid, 
       min(svcdate) as svcdate,
       min(year) as year,
       max(tsvcdat) as tsvcdat,
       max(facprof) as facprof,
       sum(netpay) as netpay, 
       sum(pay) as pay
  from staging_clean.ccaes_etl
  group by enrolid, msclmid 
)
   insert into dw_staging.claim_header
(
	data_source, 
	year, 
	uth_member_id,
	uth_claim_id, 
	claim_type, 
	from_date_of_service,
	to_date_of_service,
	total_charge_amount, 
	total_allowed_amount, 
	total_paid_amount, 
	fiscal_year, 
	cost_factor_year,
	table_id_src,
	member_id_src,
	claim_id_src,
	load_date
)
select  'truv' as data_source,
        year,
        b.uth_member_id,
        b.uth_claim_id,
        a.facprof as claim_type,
        a.svcdate as from_date_of_service,
        a.tsvcdat as to_date_of_service,
        a.netpay,
        a.pay,
        null as paid_amt,
        dev.fiscal_year_func(a.svcdate) as fiscal_year,
        null as cost_factor_year,
        'ccaes',
        a.enrolid,
        a.msclmid,
        current_date
  from cte a
   join staging_clean.truv_dim_id b 
     on a.enrolid = b.member_id_src 
    and a.msclmid = b.claim_id_src  
    ;
   
analyze dw_staging.claim_header_1_prt_truv;

/*
 *  Medicare Inpatient
 */
with cte as (
select enrolid, msclmid, 
       min(svcdate) as svcdate,
       min(year) as year,
       max(tsvcdat) as tsvcdat,
       max(facprof) as facprof,
       sum(netpay) as netpay, 
       sum(pay) as pay
  from staging_clean.mdcrs_etl
  group by enrolid, msclmid 
)
   insert into dw_staging.claim_header
(
	data_source, 
	year, 
	uth_member_id,
	uth_claim_id, 
	claim_type, 
	from_date_of_service,
	to_date_of_service,
	total_charge_amount, 
	total_allowed_amount, 
	total_paid_amount, 
	fiscal_year, 
	cost_factor_year,
	table_id_src,
	member_id_src,
	claim_id_src,
	load_date
)
select  'truv',
        year,
        b.uth_member_id,
        b.uth_claim_id,
        a.facprof,
        a.svcdate,
        a.tsvcdat,
        a.netpay,
        a.pay,
        null as paid_amt,
        dev.fiscal_year_func(a.svcdate) as fiscal_year,
        null as cost_factor_year,
        'mdcrs',
        a.enrolid,
        a.msclmid,
        current_date
  from cte a
   join staging_clean.truv_dim_id b 
     on a.enrolid = b.member_id_src 
    and a.msclmid = b.claim_id_src  
    ;
   
analyze dw_staging.claim_header_1_prt_truv;
  
  /*
 *  Commercial Outpatient
 */
with cte as (
select enrolid, msclmid, 
       min(svcdate) as svcdate,
       min(year) as year,
       max(tsvcdat) as tsvcdat,
       max(facprof) as facprof,
       sum(netpay) as netpay, 
       sum(pay) as pay
  from staging_clean.ccaeo_etl
  group by enrolid, msclmid 
)
   insert into dw_staging.claim_header
(
	data_source, 
	year, 
	uth_member_id,
	uth_claim_id, 
	claim_type, 
	from_date_of_service,
	to_date_of_service,
	total_charge_amount, 
	total_allowed_amount, 
	total_paid_amount, 
	fiscal_year, 
	cost_factor_year,
	table_id_src,
	member_id_src,
	claim_id_src,
	load_date
)
select  'truv',
        year,
        b.uth_member_id,
        b.uth_claim_id,
        a.facprof,
        a.svcdate,
        a.tsvcdat,
        a.netpay,
        a.pay,
        null as paid_amt,
        dev.fiscal_year_func(a.svcdate) as fiscal_year,
        null as cost_factor_year,
        'ccaeo',
        a.enrolid,
        a.msclmid,
        current_date
   from cte a
   join staging_clean.truv_dim_id b 
     on a.enrolid = b.member_id_src 
    and a.msclmid = b.claim_id_src  
    ;
    
analyze dw_staging.claim_header_1_prt_truv;
  
    /*
 *  Medicare Outpatient
 */

with cte as (
select enrolid, msclmid, 
       min(svcdate) as svcdate,
       min(year) as year,
       max(tsvcdat) as tsvcdat,
       max(facprof) as facprof,
       sum(netpay) as netpay, 
       sum(pay) as pay
  from staging_clean.mdcro_etl 
  group by enrolid, msclmid 
)
   insert into dw_staging.claim_header
(
	data_source, 
	year, 
	uth_member_id,
	uth_claim_id, 
	claim_type, 
	from_date_of_service,
	to_date_of_service,
	total_charge_amount, 
	total_allowed_amount, 
	total_paid_amount, 
	fiscal_year, 
	cost_factor_year,
	table_id_src,
	member_id_src,
	claim_id_src,
	load_date
)
select  'truv',
        year,
        b.uth_member_id,
        b.uth_claim_id,
        a.facprof,
        a.svcdate,
        a.tsvcdat,
        a.netpay,
        a.pay,
        null as paid_amt,
        dev.fiscal_year_func(a.svcdate) as fiscal_year,
        null as cost_factor_year,
        'mdcro',
        a.enrolid,
        a.msclmid,
        current_date 
   from cte a
   join staging_clean.truv_dim_id b 
     on a.enrolid = b.member_id_src 
    and a.msclmid = b.claim_id_src  
    ;

analyze dw_staging.claim_header_1_prt_truv;

--- add provider type 

update dw_staging.claim_header_1_prt_truv a 
   set provider_type = b.stdprov
  from staging_clean.truv_ccaef_etl b
 where a.member_id_src::bigint = b.enrolid 
   and a.claim_id_src::bigint = b.msclmid 
   and substring(table_id_src,1,2) = 'cc';
  
vacuum analyze dw_staging.claim_header_1_prt_truv;
   
update dw_staging.claim_header_1_prt_truv a 
   set provider_type = b.stdprov
  from staging_clean.truv_mdcrf_etl b
 where a.member_id_src::bigint = b.enrolid 
   and a.claim_id_src::bigint = b.msclmid 
   and substring(table_id_src,1,2) = 'md';
   
vacuum analyze dw_staging.claim_header_1_prt_truv;
  