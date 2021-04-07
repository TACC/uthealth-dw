---hpv
drop table if exists WRK.dbo.wc_ers_hpv_clms;

select distinct ID, FSCYR, FirstDateofService 
into WRK.dbo.wc_ers_hpv_clms
from 
(
	select id, MED_FSCYR as fscyr, a.FirstDateofService 
	from trsers.dbo.ers_uhcmedclm a 
	where a.MED_FSCYR between 2016 and 2017 
	  and a.HCPCSCPTCode in ('90649','90650','90651')
union 
	select id, FSCYR , a.FirstDateofService
	from TRSERS.dbo.ERS_BCBSMedCLM a
	where a.FSCYR between 2018 and 2019 
 and a.HCPCSCPTCode in ('90649','90650','90651')
) inr 
;





---get counts for spreadsheet--------------------------------------------------------------------------
---confirmed 1 record per mem per yr
select count(*), count(distinct id), fscyr 
from TRSERS.dbo.ERS_AGG_YR
group by fscyr
order by  fscyr;

select id 
into wrk.dbo.wc_ers_hpv_vacc
from (
select count(FirstDateofService) as cnt, id  
from WRK.dbo.wc_ers_hpv_clms
group by id
) inr 
where cnt > 1
;


select * 
from TRSERS.dbo.ERS_AGG_YR
where id = '0000039600002'
order by fscyr 
;


---active vs cobra vs ret
select replace( (str(a.FSCYR) +  stat), ' ','' ) as nv, count(distinct a.id) as denom, count(c.id) as numer 
from TRSERS.dbo.ERS_AGG_YR a 
  left outer join WRK.dbo.wc_ers_hpv_vacc c 
      on a.id = c.id 
where a.FSCYR between 2016 and 2019 
  and a.age = 13
  and a.enrlmnth = 12
group by a.FSCYR , stat 
order by a.FSCYR , stat 
;


---confirmed 1 record per mem per yr



---ee vs dep / active vs retiree
select replace( (str(a.FSCYR) +  stat + case when typ = 'SELF' then 'E' when typ = 'DEP' then 'D' else 'X' end ), ' ','' ) as nv, 
       count(distinct a.id) as denom, count(c.id) as numer
from TRSERS.dbo.ERS_AGG_YR a 
  left outer join WRK.dbo.wc_ers_hpv_vacc c 
      on a.id = c.id 
where a.FSCYR between 2016 and 2019 
  and a.age = 13
  and a.enrlmnth = 12 
group by a.FSCYR , typ, stat 
order by a.FSCYR, stat, typ desc--, stat 
;



---age group active vs retiree vs cobra 
select replace( str(a.FSCYR) + stat + 
       case when age between 0 and 19 then '1'
            when age between 20 and 34 then '2' 
       		when age between 35 and 44 then '3'
       		when age between 45 and 54 then '4'
       		when age between 55 and 64 then '5'
       		when age between 65 and 74 then '6'
       		when age >= 75 then '7' end, ' ','' ) as age_group,
       count(distinct a.id) as denom, count(c.id) as numer
from TRSERS.dbo.ERS_AGG_YR a 
  left outer join WRK.dbo.wc_ers_hpv_vacc c 
      on a.id = c.id 
where  a.FSCYR between 2016 and 2019 
  and a.AGE = 13
  and enrlmnth = 12 
group by  a.fscyr ,  stat,   case when age between 0 and 19 then '1'
            when age between 20 and 34 then '2' 
       		when age between 35 and 44 then '3'
       		when age between 45 and 54 then '4'
       		when age between 55 and 64 then '5'
       		when age between 65 and 74 then '6'
       		when age >= 75 then '7' end
order by  a.fscyr,  stat,    case when age between 0 and 19 then '1'
            when age between 20 and 34 then '2' 
       		when age between 35 and 44 then '3'
       		when age between 45 and 54 then '4'
       		when age between 55 and 64 then '5'
       		when age between 65 and 74 then '6'
       		when age >= 75 then '7' end
 ;



---age group active vs retiree vs cobra / male vs female 
select replace( str(a.FSCYR) + gen + stat + 
       case when age between 0 and 19 then '1'
            when age between 20 and 34 then '2' 
       		when age between 35 and 44 then '3'
       		when age between 45 and 54 then '4'
       		when age between 55 and 64 then '5'
       		when age between 65 and 74 then '6'
       		when age >= 75 then '7' end, ' ','' ) as age_group,
       count(distinct a.id) as denom, count(c.id) as numer
from TRSERS.dbo.ERS_AGG_YR a 
  left outer join WRK.dbo.wc_ers_hpv_vacc c 
      on a.id = c.id 
where  a.FSCYR between 2016 and 2019 
  and a.AGE = 13
  and enrlmnth = 12 
group by  a.fscyr , gen, stat,   case when age between 0 and 19 then '1'
            when age between 20 and 34 then '2' 
       		when age between 35 and 44 then '3'
       		when age between 45 and 54 then '4'
       		when age between 55 and 64 then '5'
       		when age between 65 and 74 then '6'
       		when age >= 75 then '7' end
order by  a.fscyr, a.gen, stat,    case when age between 0 and 19 then '1'
            when age between 20 and 34 then '2' 
       		when age between 35 and 44 then '3'
       		when age between 45 and 54 then '4'
       		when age between 55 and 64 then '5'
       		when age between 65 and 74 then '6'
       		when age >= 75 then '7' end
 ;

---- /end 
