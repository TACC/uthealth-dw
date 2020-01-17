---------------------------------------------------------------------------------------------------
-------------------------------- truven commercial outpatient--------------------------------------
---------------------------------------------------------------------------------------------------		
-- 10min, 764,063,397
insert into dw_qa.claim_header (data_source, uth_claim_id, uth_member_id, from_date_of_service, claim_type, place_of_service, uth_admission_id, admission_id_src,
						        total_charge_amount, total_allowed_amount, total_paid_amount, claim_id_src, member_id_src, table_id_src)  						        
select 'trvc', b.uth_claim_id, b.uth_member_id, min(a.svcdate), max(a.facprof), max(trunc(stdplac,0)::text), null, null,
       null, sum(a.pay), sum(a.netpay), a.msclmid, a.enrolid, 'ccaeo'       
select distinct on (uth_claim_id) 
	   'trvc', b.uth_claim_id, b.uth_member_id, a.svcdate, a.facprof, trunc(stdplac,0)::text, null, null,
        null, sum(a.pay) over(partition by b.uth_claim_id), sum(a.netpay) over(partition by b.uth_claim_id), 
        a.msclmid, a.enrolid, 'ccaeo'
from truven.ccaeo a
  join data_warehouse.dim_uth_claim_id b 
    on b.data_source = 'trvc'
   and b.data_year = trunc(a.year,0)
   and b.claim_id_src = a.msclmid::text
   and b.member_id_src = a.enrolid::text
where trunc(year,0) between 2015 and 2017
;

						       
insert into dw_qa.claim_detail (  data_source, uth_claim_id, claim_sequence_number, uth_member_id, from_date_of_service, to_date_of_service,
								   month_year_id, perf_provider_id, bill_provider_id, ref_provider_id, place_of_service, network_ind, network_paid_ind,
								   admit_date, discharge_date, procedure_cd, procedure_type, proc_mod_1, proc_mod_2, revenue_cd,
								   charge_amount, allowed_amount, paid_amount, deductible, copay, coins, cob,
								   bill_type_inst, bill_type_class, bill_type_freq, units, drg_cd,
								   claim_id_src, member_id_src, table_id_src )										   								 								   
select 'trvc', b.uth_claim_id, a.seqnum, b.uth_member_id, a.svcdate, a.tsvcdat,
       c.month_year_id, a.provid, null, null, a.stdplac, a.ntwkprov::bool, a.paidntwk::bool, 
       null, null, a.proc1, a.proctyp, substring(a.procmod,1,1), substring(procmod,2,1), a.revcode, 
       null, a.pay, a.netpay, a.deduct, a.copay, a.coins, a.cob,
       null, null, null,  trunc(a.qty,0) as units, null,  
       a.msclmid, a.enrolid, 'ccaeo'
from truven.ccaeo a 
  join data_warehouse.dim_uth_claim_id b 
    on b.data_source = 'trvc'
   and b.data_year = trunc(a.year,0)
   and b.claim_id_src = a.msclmid::text
   and b.member_id_src = a.enrolid::text
  join reference_tables.ref_month_year c
    on c.month_int = extract(month from a.svcdate) 
   and c.year_int = a.year
where a.msclmid is not null
  and a.year between 2015 and 2017
  ;


update dw_qa.claim_detail a set claim_sequence_number = rownum 
        from ( select uth_claim_id,
                      claim_sequence_number,
                      row_number() over ( partition by uth_claim_id 
                                          order by claim_sequence_number
                                        ) rownum 
		       from dw_qa.claim_detail
		       order by uth_claim_id, claim_sequence_number ) b
		       where a.uth_claim_id = b.uth_claim_id
		         and a.claim_sequence_number = b.claim_sequence_number
		         and a.data_source = 'trvc'
		         and a.table_id_src = 'ccaeo';
		

		        
---------------------------------------------------------------------------------------------------
-------------------------------- truven medicare outpatient ---------------------------------------
---------------------------------------------------------------------------------------------------		        
		        
insert into dw_qa.claim_header (data_source, uth_claim_id, uth_member_id, from_date_of_service, claim_type, place_of_service, uth_admission_id, admission_id_src,
						        total_charge_amount, total_allowed_amount, total_paid_amount, claim_id_src, member_id_src, table_id_src)  						            
select distinct on (uth_claim_id) 
	   'trvm', b.uth_claim_id, b.uth_member_id, a.svcdate, a.facprof, trunc(stdplac,0)::text, null, null,
        null, sum(a.pay) over(partition by b.uth_claim_id), sum(a.netpay) over(partition by b.uth_claim_id), 
        a.msclmid, a.enrolid, 'mdcro'   
from truven.mdcro a
  join data_warehouse.dim_uth_claim_id b 
    on b.data_source in ('trvm','trvc')
   and b.data_year = trunc(a.year,0)
   and b.claim_id_src = a.msclmid::text
   and b.member_id_src = a.enrolid::text
where trunc(year,0) between 2015 and 2017
;


analyze dw_qa.claim_header;

analyze dw_qa.claim_detail;



insert into dw_qa.claim_detail (  data_source, uth_claim_id, claim_sequence_number, uth_member_id, from_date_of_service, to_date_of_service,
								   month_year_id, perf_provider_id, bill_provider_id, ref_provider_id, place_of_service, network_ind, network_paid_ind,
								   admit_date, discharge_date, procedure_cd, procedure_type, proc_mod_1, proc_mod_2, revenue_cd,
								   charge_amount, allowed_amount, paid_amount, deductible, copay, coins, cob,
								   bill_type_inst, bill_type_class, bill_type_freq, units, drg_cd,
								   claim_id_src, member_id_src, table_id_src )										   								 								   
select 'trvm', b.uth_claim_id, a.seqnum, b.uth_member_id, a.svcdate, a.tsvcdat,
       c.month_year_id, a.provid, null, null, a.stdplac, a.ntwkprov::bool, a.paidntwk::bool, 
       null, null, a.proc1, a.proctyp, substring(a.procmod,1,1), substring(procmod,2,1), a.revcode, 
       null, a.pay, a.netpay, a.deduct, a.copay, a.coins, a.cob, 
       null, null, null,  trunc(a.qty,0) as units, null,  
       a.msclmid, a.enrolid, 'mdcro'
from truven.mdcro a 
  join data_warehouse.dim_uth_claim_id b 
    on b.data_source in ('trvm','trvc')
   and b.data_year = trunc(a.year,0)
   and b.claim_id_src = a.msclmid::text
   and b.member_id_src = a.enrolid::text
  join reference_tables.ref_month_year c
    on c.month_int = extract(month from a.svcdate) 
   and c.year_int = a.year
where a.msclmid is not null
  and a.year between 2015 and 2017
  ;




update dw_qa.claim_detail a set claim_sequence_number = rownum 
        from ( select uth_claim_id,
                      claim_sequence_number,
                      row_number() over ( partition by uth_claim_id 
                                          order by claim_sequence_number
                                        ) rownum 
		       from dw_qa.claim_detail
		       where data_source = 'trvm'
		         and table_id_src = 'mdcro'
		       order by uth_claim_id, claim_sequence_number ) b
		       where a.uth_claim_id = b.uth_claim_id
		         and a.claim_sequence_number = b.claim_sequence_number
		         and a.data_source = 'trvm'
		         and a.table_id_src = 'mdcro';
		

		        
		        
select * from dw_qa.claim_detail where uth_claim_id = 2693961759


where data_source = 'trvm';
		       
		       
		       
		       
		       
		       
		       
		       
