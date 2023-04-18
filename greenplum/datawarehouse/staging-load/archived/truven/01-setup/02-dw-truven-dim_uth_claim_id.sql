create table dw_staging.dim_uth_claim_id
( like data_warehouse.dim_uth_claim_id)
create table dw_staging.mcd_member_enrollment_yearly 
(like data_warehouse.member_enrollment_yearly including defaults) 
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
  partition mcrn values ('mcrn'),
  partition mhtw values ('mhtw'),
  partition mcpp values ('mcpp')
 )
;


--check to see if claim_id_derv is unique

select claim_id_derv, "year"
from truven.ccaeo














insert into data_warehouse.dim_uth_claim_id (data_source, claim_id_src, member_id_src, uth_member_id, data_year) 
with all_clms as 
(
		select  a.msclmid::text as v_claim_id_src, a.enrolid::text as v_member_id_src, min(trunc(a.year,0)) as v_data_year                                      
		from truven.ccaeo a
		group by 1, 2
   union all                                      
		select a.msclmid::text, a.enrolid::text, min(trunc(a.year,0))
		from truven.ccaes a  
		group by 1, 2
   union all                               
		select a.msclmid::text, a.enrolid::text,  min(trunc(a.year,0))
		from truven.mdcro a
		group by 1, 2
	union all
		select a.msclmid::text, a.enrolid::text, min(trunc(a.year,0))
		from truven.mdcrs a  
		group by 1,2
),
cte_distinct_truven_claim as 
(
select distinct a.v_claim_id_src, a.v_member_id_src, b.uth_member_id as v_uth_member_id, v_data_year
  from all_clms a 
  join data_warehouse.dim_uth_member_id b 
    on b.data_source = 'truv'
   and a.v_member_id_src = b.member_id_src
)
select 'truv', v_claim_id_src, v_member_id_src, v_uth_member_id, v_data_year 
from cte_distinct_truven_claim 
  left outer join data_warehouse.dim_uth_claim_id c
    on c.data_source = 'truv'
   and c.claim_id_src = v_claim_id_src
   and c.member_id_src = v_member_id_src
   and c.data_year = v_data_year 
 where c.uth_claim_id is null
;

