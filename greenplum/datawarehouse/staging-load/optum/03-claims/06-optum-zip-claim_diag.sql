
/* ******************************************************************************************************
 *  load claim diag for optum zip and optum dod 
 * ******************************************************************************************************
 *  Author || Date      || Notes
 * ******************************************************************************************************
 * ******************************************************************************************************
 *  wcc001  || 9/20/2021 || add comment block. migrate to dw_staging load 
 * ****************************************************************************************************** 
 *  gmunoz  || 10/25/2021 || adding dev.fiscal_year_func() logic
 * ******************************************************************************************************
 * iperez	|| 07/06/2023 || added source member id, claim id, and table id
 * ************************************************************************************* 
 * */

drop table if exists dw_staging.optz_claim_diag;

create table dw_staging.optz_claim_diag
(like data_warehouse.claim_diag including defaults) 
with (
		appendonly=true, 
		orientation=row, 
		compresstype=zlib, 
		compresslevel=5 
	 )
distributed by (uth_member_id)
;

insert into dw_staging.optz_claim_diag (
		data_source, uth_member_id, uth_claim_id, 
        from_date_of_service, diag_cd, diag_position, poa_src, icd_version,
        load_date, year, fiscal_year, claim_id_src, member_id_src
) 
select 'optz',  b.uth_member_id, b.uth_claim_id,
       a.fst_dt, a.diag, a.diag_position, 
       a.poa, 
       case when trim(icd_flag) = '10' then '0' else '9' end as icd_ver,
       current_date,
       a.year,
       dev.fiscal_year_func(a.fst_dt) as fiscal_year,
       a.clmid,
       a.patid::text
from optum_zip.diagnostic a 
join dw_staging.optz_uth_claim_id b  
  on a.member_id_src = b.member_id_src
 and a.clmid = b.claim_id_src 
;

vacuum analyze dw_staging.optz_claim_diag;