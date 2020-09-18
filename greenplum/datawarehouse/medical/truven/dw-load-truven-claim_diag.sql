--- claim diag load for truven

-------------------------------- truven commercial outpatient --------------------------------------
insert into data_warehouse.claim_diag (data_source, year, uth_member_id, uth_claim_id, claim_sequence_number
									  ,date, diag_cd, diag_position, icd_type)  								        						              
select  'truv', d.year, d.uth_member_id, d.uth_claim_id, d.claim_sequence_number
		,d.from_date_of_service 
	    ,unnest(array[a.dx1, a.dx2, a.dx3, a.dx4]) as dx_cd
		,unnest(array[1,2,3,4]) as dx_pos 
		,a.dxver 
from dev.truven_ccaeo a 
  join data_warehouse.claim_detail d 
    on d.claim_id_src = a.msclmid::text 
   and d.member_id_src = a.enrolid::text 
   and d.from_date_of_service = a.svcdate 
   and d.claim_sequence_number_src = a.seqnum::text
where a.year = 2019;
  
  
-------------------------------- truven medicare outpatient -------------------------------------- 
insert into data_warehouse.claim_diag (data_source, year, uth_member_id, uth_claim_id, claim_sequence_number
									  ,date, diag_cd, diag_position, icd_type)  								        						              
select  'truv', d.year, d.uth_member_id, d.uth_claim_id, d.claim_sequence_number
		,d.from_date_of_service 
	    ,unnest(array[a.dx1, a.dx2, a.dx3, a.dx4]) as dx_cd
		,unnest(array[1,2,3,4]) as dx_pos 
		,a.dxver 
from truven.mdcro a 
  join data_warehouse.claim_detail d 
    on d.claim_id_src = a.msclmid::text 
   and d.member_id_src = a.enrolid::text 
   and d.from_date_of_service = a.svcdate 
   and d.claim_sequence_number_src = a.seqnum::text
  where a.year = 2019;
  
  
  
 -------------------------------- truven commercial inpatient ------
insert into data_warehouse.claim_diag (data_source, year, uth_member_id, uth_claim_id, claim_sequence_number
									  ,date, diag_cd, diag_position, icd_type)  								        						              
select  'truv', d.year, d.uth_member_id, d.uth_claim_id, d.claim_sequence_number
		,d.from_date_of_service 
	    ,unnest(array[a.dx1, a.dx2, a.dx3, a.dx4]) as dx_cd
		,unnest(array[1,2,3,4]) as dx_pos 
		,a.dxver 
from truven.ccaes a 
  join data_warehouse.claim_detail d 
    on d.claim_id_src = a.msclmid::text 
   and d.member_id_src = a.enrolid::text 
   and d.from_date_of_service = a.svcdate 
   and d.claim_sequence_number_src = a.seqnum::text
where a.year = 2019;
 
  
-------------------------------- truven medicare inpatient ------
insert into data_warehouse.claim_diag (data_source, year, uth_member_id, uth_claim_id, claim_sequence_number
									  ,date, diag_cd, diag_position, icd_type)  								        						              
select  'truv', d.year, d.uth_member_id, d.uth_claim_id, d.claim_sequence_number
		,d.from_date_of_service 
	    ,unnest(array[a.dx1, a.dx2, a.dx3, a.dx4]) as dx_cd
		,unnest(array[1,2,3,4]) as dx_pos 
		,a.dxver 
from truven.mdcrs a 
  join data_warehouse.claim_detail d 
    on d.claim_id_src = a.msclmid::text 
   and d.member_id_src = a.enrolid::text 
   and d.from_date_of_service = a.svcdate 
   and d.claim_sequence_number_src = a.seqnum::text
where a.year = 2019;  


--clean up null rows

delete from data_warehouse.claim_diag cd where diag_cd is null;
    
-- SCRATCH

vacuum full data_warehouse.claim_diag;

analyze data_warehouse.claim_diag; 


select count(*), data_source, year 
from data_warehouse.pharmacy_claims pc
group by data_source, year 
order by data_source, year 
  
  