/* ******************************************************************************************************
 *  creates and loads table to track medicaid program enrollment month to month
 * ******************************************************************************************************
 *  Author || Date      || Notes
 * ******************************************************************************************************
 *  wc001  || 8/16/2021 || script created 
 * ******************************************************************************************************
 */

--chip
insert into data_warehouse.medicaid_program_enrollment (year_fy, uth_member_id, elig_date, mco_program_nm)
select a.year_fy, b.uth_member_id, a.elig_month, c.mco_program_nm 
from medicaid.chip_uth a
  join data_warehouse.dim_uth_member_id b 
     on b.member_id_src = a.client_nbr
  join reference_tables.medicaid_lu_contract c 
     on trim(a.plan_cd) = trim(c.plan_cd);


---validate 
vacuum analyze data_warehouse.medicaid_program_enrollment;
    
    
select distinct year_fy, mco_program_nm from data_warehouse.medicaid_program_enrollment group by year_fy order by year_fy;


/*

-- Original table create

create table data_warehouse.medicaid_program_enrollment 
WITH (appendonly=true, orientation=column)
as 
select a.year_fy, b.uth_member_id, a.elig_date, c.mco_program_nm, a.sig, a.smib, a.base_plan, a.mc_flag, 
a.mc_sc, a.me_cat, a.me_code, a.me_sd, a.provider_id, a.mco_id, riskgrp_id, cmp_rg_id, perm_excl, count_excl , pure_rate 
from medicaid.enrl a 
  join data_warehouse.dim_uth_member_id b 
     on b.member_id_src = a.client_nbr
  join reference_tables.medicaid_lu_contract c 
     on trim(a.contract_id) = trim(c.plan_cd)
 distributed by (uth_member_id);   
 
 */ 