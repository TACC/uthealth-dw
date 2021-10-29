drop table if exists tableau.dashboard_1720;

create table tableau.dashboard_1720
with (appendoptimized=true, orientation=column, compresstype=zlib)
as 
select a.data_source, a."year" , a.uth_member_id ,total_enrolled_months, gender_cd, age_derived , state, plan_type, bus_cd,
       uth_claim_id , claim_type, total_charge_amount , total_allowed_amount, total_paid_amount
from data_warehouse.member_enrollment_yearly a 
    left outer join data_warehouse.claim_header b 
     on a.uth_member_id = b.uth_member_id 
    and a."year" = b."year" 
where a.year between 2017 and 2020
  and a.data_source in ('optz', 'truv','mcrt')
distributed by (uth_member_id)
;


vacuum analyze tableau.dashboard_1720;


select data_source, year, count(*) 
from tableau.dashboard_1720
group by data_source, year
order by data_source, year;