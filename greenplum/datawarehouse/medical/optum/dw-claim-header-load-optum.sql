
/* ******************************************************************************************************
 *  load claim header for optum zip and optum dod 
 * ******************************************************************************************************
 *  Author || Date      || Notes
 * ******************************************************************************************************
 * ******************************************************************************************************
 *  wcc001  || 9/09/2021 || add comment block. migrate to dw_staging load 
 * ****************************************************************************************************** 
 * */


--------------- BEGIN SCRIPT -------

---create a copy of production data warehouse table 
create table dw_staging.claim_header 
with (appendonly=true, orientation=column) as 
select data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, uth_admission_id, 
       total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year, cost_factor_year
from data_warehouse.claim_header ch 
where data_source not in ('optd','optz')
distributed by (uth_member_id) 
;

vacuum analyze dw_staging.claim_header; 

--------------------------------------------------------------------------------------------------
--- ** OPTD **
--------------------------------------------------------------------------------------------------


---create copy of dimension table distributed on member id src 
drop table if exists dw_staging.temp_dim_uth_claim_id_optd;

create table dw_staging.temp_dim_uth_claim_id_optd
with(appendonly=true,orientation=column,compresstype=zlib)
as select * from data_warehouse.dim_uth_claim_id where data_source = 'optd'
distributed by (member_id_src);

vacuum analyze dw_staging.temp_dim_uth_claim_id_optd;

<<<<<<< Updated upstream
--optd medical
drop table if exists dev.wc_optd_medical;
create table dev.wc_optd_medical 
with(appendonly=true,orientation=column,compresstype=zlib)
as select * from optum_zip.medical
distributed by (patid);

vacuum analyze dev.wc_optd_medical;

vacuum analyze dev.wc_optd_uth_claim;


--admit id for optd only
drop table dev.wc_uth_admission_id_optd; 

create table dev.wc_uth_admission_id_optd 
with(appendonly=true,orientation=column)
as select * from data_warehouse.dim_uth_admission_id where data_source = 'optd'
distributed by (member_id_src);
=======
>>>>>>> Stashed changes


--optd
--insert into data_warehouse.claim_header(
insert into dw_staging.claim_header 
(
	data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, uth_admission_id, 
	total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year, cost_factor_year
)	
select distinct on(b.uth_claim_id)
	'optd', 
	extract(year from (min(a.fst_dt) over(partition by b.uth_claim_id))),
	b.uth_member_id, 
	b.uth_claim_id,
	c.claim_type_code,	
	min(a.fst_dt) over(partition by b.uth_claim_id) as from_date_of_service,
	max(a.lst_dt) over(partition by b.uth_claim_id) as to_date_of_service,
	d.uth_admission_id,
	sum((a.charge * c.cost_factor)) over(partition by b.uth_claim_id) as total_charge_amount,
	sum((a.std_cost * c.cost_factor)) over(partition by b.uth_claim_id) as total_allowed_amount, 
	null as total_paid_amount,
	a.year as fiscal, 
<<<<<<< Updated upstream
	a.std_cost_yr::int as cost_year,
	max(a.lst_dt) over(partition by b.uth_claim_id) as to_date_of_service
from dev.wc_optd_medical a  --*optum_zip.medical a
    join dev.wc_optd_uth_claim b --data_warehouse.dim_uth_claim_id b 
		on a.patid::text = b.member_id_src 
=======
	a.std_cost_yr::int as cost_year
from optum_dod.medical a
    join dw_staging.temp_dim_uth_claim_id_optd b 
		on a.member_id_src = b.member_id_src 
>>>>>>> Stashed changes
		and a.clmid = b.claim_id_src
	join reference_tables.ref_optum_cost_factor c
		on c.service_type = left(a.tos_cd, (position('.' in a.tos_cd)-1)) 
		and c.standard_price_year = a.std_cost_yr::int
    left outer join data_warehouse.dim_uth_admission_id d 
       on d.member_id_src = a.patid::text 
      and d.admission_id_src = a.conf_id 
      and d."year" = a."year" 
;



--------------------------------------------------------------------------------------------------
--- ** OPTZ **
--------------------------------------------------------------------------------------------------

---create copy of dimension table distributed on member id src optz
drop table if exists dw_staging.temp_dim_uth_claim_id_optz;

create table dw_staging.temp_dim_uth_claim_id_optz
with(appendonly=true,orientation=column,compresstype=zlib)
as select * from data_warehouse.dim_uth_claim_id where data_source = 'optz'
distributed by (member_id_src);

vacuum analyze dw_staging.temp_dim_uth_claim_id_optz;

---optum zip insert 
insert into dw_staging.claim_header 
(
	data_source, year, uth_member_id, uth_claim_id, claim_type, from_date_of_service, to_date_of_service, uth_admission_id, 
	total_charge_amount, total_allowed_amount, total_paid_amount, fiscal_year, cost_factor_year
)	
select distinct on(b.uth_claim_id)
	'optz', 
	extract(year from (min(a.fst_dt) over(partition by b.uth_claim_id))),
	b.uth_member_id, 
	b.uth_claim_id,
	c.claim_type_code,	
	min(a.fst_dt) over(partition by b.uth_claim_id) as from_date_of_service,
	max(a.lst_dt) over(partition by b.uth_claim_id) as to_date_of_service,
	d.uth_admission_id,
	sum((a.charge * c.cost_factor)) over(partition by b.uth_claim_id) as total_charge_amount,
	sum((a.std_cost * c.cost_factor)) over(partition by b.uth_claim_id) as total_allowed_amount, 
	null as total_paid_amount,
	a.year as fiscal, 
	a.std_cost_yr::int as cost_year
from optum_zip.medical a
    join dw_staging.temp_dim_uth_claim_id_optz b   
		on a.patid::text = b.member_id_src 
		and a.clmid = b.claim_id_src
	join reference_tables.ref_optum_cost_factor c 
	    on c.service_type = left(a.tos_cd, (position('.' in a.tos_cd)-1)) 
	   and c.standard_price_year = a.std_cost_yr::int
    left outer join data_warehouse.dim_uth_admission_id d
       on d.member_id_src = a.patid::text 
      and d.admission_id_src = a.conf_id 
      and d."year" = a."year" 
     ;
    

