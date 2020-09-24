/****** Medicaid Annual Prev Exam 2015 ******/

drop table stage.dbo.wc_mdcd_ape_2015;


select client_nbr, min(zip3) as zip3, max(sex) as sex, min(age) as age , min(age_Group) as age_group
into stage.dbo.wc_mdcd_ape_2015
from 
(
SELECT [CLIENT_NBR]
      ,substring([ZIP],1,3) as zip3
      ,[SEX]
	  ,age 
      ,	   case  when cast(age as float) between 0  and 17.99 then 1 
	         when cast(age as float) between 18 and 29.99 then 2
	         when cast(age as float) between 30 and 39.99 then 3
	         when cast(age as float) between 40 and 49.99 then 4
	         when cast(age as float) between 50 and 59.99 then 5 
	         when cast(age as float) between 60 and 64.99 then 6 
	         else 7
	   end as age_group
	   ,elig_date 
  FROM [MEDICAID].[dbo].[ENRL_2015]
  where elig_date >= 201501
  and substring(zip,1,3) between '750' and '799'
 union 
  SELECT[CLIENT_NBR]
      ,substring([ZIP],1,3) as zip3
      ,[SEX]
	  ,age
      ,	   case  when cast(age as float) between 0  and 17.99 then 1 
	         when cast(age as float) between 18 and 29.99 then 2
	         when cast(age as float) between 30 and 39.99 then 3
	         when cast(age as float) between 40 and 49.99 then 4
	         when cast(age as float) between 50 and 59.99 then 5 
	         when cast(age as float) between 60 and 64.99 then 6 
	         else 7
	   end as age_group
	   ,elig_date 
  FROM [MEDICAID].[dbo].[ENRL_2016]
  where elig_date <= 201512
	and substring(zip,1,3) between '750' and '799'
  ) inr 
  group by client_nbr;



delete from stage.dbo.wc_mdcd_ape_2015 where age_group is null;

delete from stage.dbo.wc_mdcd_ape_2015 where zip3 = '771';


---------------------------------------------------------------------------------------------------------
----proc and hcpc
---------------------------------------------------------------------------------------------------------
drop table stage.dbo.wc_mdcd_ape_clm_2015 ;

select distinct derv_enc 
into stage.dbo.wc_mdcd_ape_clm_2015
from ( 
  select derv_enc
  from medicaid.dbo.ENC_DET_15
  where proc_cd in ('99381','99382','99383','99384','99385','99386','99387',
						 '99391','99392','99393','99394','99395','99396','99397',
						 'S0610','S0612','S0615')
  and FDOS_DT between '2015-01-01' and '2015-12-31'
union 
  select derv_enc
  from medicaid.dbo.ENC_DET_16 d
  where proc_cd in ('99381','99382','99383','99384','99385','99386','99387',
						 '99391','99392','99393','99394','99395','99396','99397',
						 'S0610','S0612','S0615')
  and FDOS_DT between '2015-01-01' and '2015-12-31'
union 
  select ICN 
  from MEDICAID.dbo.CLM_DETAIL_15
  where proc_cd in ('99381','99382','99383','99384','99385','99386','99387',
						 '99391','99392','99393','99394','99395','99396','99397',
						 'S0610','S0612','S0615')
  and  FROM_DOS between '2015-01-01' and '2015-12-31'
union 
  select ICN
  from medicaid.dbo.CLM_DETAIL_16 
  where proc_cd in ('99381','99382','99383','99384','99385','99386','99387',
						 '99391','99392','99393','99394','99395','99396','99397',
						 'S0610','S0612','S0615')
  and FROM_DOS between '2015-01-01' and '2015-12-31'  
) inr ;


---------------------------------------------------------------------------------------------------------
----Diagnosis Codes
---------------------------------------------------------------------------------------------------------
create table stage.dbo.wc_mdcd_ape_diag (dx_cd varchar(50));

insert into stage.dbo.wc_mdcd_ape_diag values
('Z0000'),('Z0001'),('Z00110'),('Z00111'),('Z00121'),('Z00129'),('Z003'),('Z01411'),('Z01419'),
				  ('V700'),('V700'),('V7231'),('V705'),('V703'),('V7284'),('V7285') ;

insert into stage.dbo.wc_mdcd_ape_clm_2015
select distinct ICN
from ( 
  select d.ICN 
  from medicaid.dbo.CLM_DX_15 d 
    join MEDICAID.dbo.CLM_HEADER_15 h 
      on h.ICN = d.ICN 
     and h.HDR_FRM_DOS between '2015-01-01' and '2015-12-31'
  where (   d.DX_CD_1 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_2 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_3 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_4 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_5 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_6 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_7 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_8 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_9 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        )
union 
  select d.ICN 
  from medicaid.dbo.CLM_DX_16 d
    join MEDICAID.dbo.CLM_HEADER_16 h 
      on h.ICN = d.ICN 
     and h.HDR_FRM_DOS between '2015-01-01' and '2015-12-31'
  where (   d.DX_CD_1 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_2 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_3 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_4 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_5 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_6 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_7 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_8 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_9 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        )
union 
  select d.DERV_ENC 
  from MEDICAID.dbo.enc_dx_15 d 
    join MEDICAID.dbo.ENC_HEADER_15 h 
      on h.DERV_ENC = d.DERV_ENC 
     and h.FRM_DOS between '2015-01-01' and '2015-12-31'
   where (   d.DX_CD_1 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_2 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_3 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_4 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_5 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_6 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_7 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_8 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_9 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        )
union 
  select d.DERV_ENC 
  from MEDICAID.dbo.enc_dx_16 d 
    join MEDICAID.dbo.ENC_HEADER_16 h 
      on h.DERV_ENC = d.DERV_ENC 
     and h.FRM_DOS between '2015-01-01' and '2015-12-31'
   where (   d.DX_CD_1 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_2 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_3 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_4 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_5 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_6 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_7 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_8 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        or d.DX_CD_9 in (select dx_cd from stage.dbo.wc_mdcd_ape_diag) 
        )
) inr ;


---------------------------------------------------------------------------------------------------------
----Members from claim ids
--------------------------------------------------------------------------------------------------------
drop table stage.dbo.wc_mdcd_ape_mem_2015;

select distinct mem_id 
into stage.dbo.wc_mdcd_ape_mem_2015
from (
		select distinct a.mem_id 
		from medicaid.dbo.enc_proc_15 a 
		where a.DERV_ENC in (select derv_enc from stage.dbo.wc_mdcd_ape_clm_2015) 
	union 
		select distinct a.mem_id 
		from medicaid.dbo.enc_proc_16 a 
		where a.DERV_ENC in (select derv_enc from stage.dbo.wc_mdcd_ape_clm_2015) 
	union 
		select a.PCN
		from MEDICAID.dbo.clm_proc_15 a 
		where a.ICN in (select derv_enc from stage.dbo.wc_mdcd_ape_clm_2015) 
    union 
		select a.PCN
		from MEDICAID.dbo.clm_proc_16 a 
		where a.ICN in (select derv_enc from stage.dbo.wc_mdcd_ape_clm_2015) 
	) inr ; 


select * 
from  stage.dbo.wc_mdcd_ape_mem_2015

-------------------------------------------------

alter table stage.dbo.wc_mdcd_ape_2015 add vacc_flag int default 0;


update stage.dbo.wc_mdcd_ape_2015 set vacc_flag = 1
  from stage.dbo.wc_mdcd_ape_mem_2015 b 
    where client_nbr = b.mem_id
 ;

--agg table to be sent to gp
select * 
into stage.dbo.wc_mdcd_ape_agg_2015 
from stage.dbo.wc_mdcd_ape_2015 a 
where a.age_group = 7;

delete from stage.dbo.wc_mdcd_ape_2015 where age_group = 7;

select count(*), count(distinct client_nbr), sum(vacc_flag) from stage.dbo.wc_mdcd_ape_2015;


----------------------------------------------------------------------------------------
---********************** Prevalance All **************************
----------------------------------------------------------------------------------------

--prevalance all - row 51  

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag)
from stage.dbo.wc_mdcd_ape_2015;

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag)
from stage.dbo.wc_mdcd_ape_2015
where sex = 'F';

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag)
from stage.dbo.wc_mdcd_ape_2015
where sex = 'M';

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag), age_group
from stage.dbo.wc_mdcd_ape_2015
group by age_group
order by age_group;


--- prevalance by zip 

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag), zip3 
from stage.dbo.wc_mdcd_ape_2015
group by zip3
order by zip3;

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag), zip3 
from stage.dbo.wc_mdcd_ape_2015
where sex = 'F'
group by zip3
order by zip3;

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag), zip3 
from stage.dbo.wc_mdcd_ape_2015
where sex = 'M'
group by zip3
order by zip3;

select ( cast(sum(vacc_flag) as float) / cast(count(client_nbr) as float ) )*100 as prev, count(client_nbr), sum(vacc_flag), zip3 
from stage.dbo.wc_mdcd_ape_2015
where age_group = 6
group by zip3
order by zip3;



