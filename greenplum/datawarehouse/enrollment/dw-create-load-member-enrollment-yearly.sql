drop table if exists data_warehouse.member_enrollment_yearly cascade;


create table data_warehouse.member_enrollment_yearly (
	data_source char(4), 
	year int2,
	uth_member_id bigint,
	total_enrolled_months int2,
	enrolled_jan bool default false,
	enrolled_feb bool default false,
	enrolled_mar bool default false,
	enrolled_apr bool default false,
	enrolled_may bool default false,
	enrolled_jun bool default false,
	enrolled_jul bool default false,
	enrolled_aug bool default false,
	enrolled_sep bool default false,
	enrolled_oct bool default false,
	enrolled_nov bool default false,
	enrolled_dec bool default false,
	gender_cd char(1),
	state varchar,
	dod char(5),
	zip3 char(3),
	age_derived int,
	dob_derived date, 
	death_date date,
	plan_type char(4),
	bus_cd char(4),
	employee_status text, 
	claim_created_flag bool default false,
	row_identifier bigserial,
	rx_coverage int2
)
WITH (appendonly=true, orientation=column)
distributed by(uth_member_id);


alter sequence data_warehouse.member_enrollment_yearly_row_identifier_seq cache 200


------------------------------------------------------------
vacuum analyze data_warehouse.member_enrollment_yearly;

vacuum analyze data_warehouse.member_enrollment_monthly;




delete from data_warehouse.member_enrollment_yearly where data_source ='truv'

insert into data_warehouse.member_enrollment_yearly (data_source, year, uth_member_id, gender_cd, state, dod, zip3, age_derived, dob_derived, death_date
      ,plan_type, bus_cd, employee_status, claim_created_flag, rx_coverage )
select distinct on( data_source, year, uth_member_id ) 
       data_source, year, uth_member_id, gender_cd, state, dod, zip3, age_derived, dob_derived, death_date
      ,plan_type, bus_cd, employee_status, claim_created_flag, rx_coverage
from data_warehouse.member_enrollment_monthly
where data_source = 'truv'
order by data_source, year, uth_member_id, month_year_id 
;

drop table dev.temp_member_enrollment_month;

--Create temp join tables
create table dev.temp_member_enrollment_month
WITH (appendonly=true, orientation=column)
as
select distinct uth_member_id, year, month_year_id, month_year_id % year as month
from data_warehouse.member_enrollment_monthly
where data_source = 'truv'
distributed by(uth_member_id);

vacuum analyze dev.temp_member_enrollment_month;


select * from dev.temp_member_enrollment_month;


select count(*), count(distinct uth_member_id), year 
from data_warehouse.member_enrollment_yearly 
where data_source = 'truv'
group by year 
order by year;

--Add month flags
update data_warehouse.member_enrollment_yearly y
set enrolled_jan = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 1
;

update data_warehouse.member_enrollment_yearly y
set enrolled_feb = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 2
;

update data_warehouse.member_enrollment_yearly y
set enrolled_mar = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 3
;

update data_warehouse.member_enrollment_yearly y
set enrolled_apr = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 4
;

update data_warehouse.member_enrollment_yearly y
set enrolled_may = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 5
;

update data_warehouse.member_enrollment_yearly y
set enrolled_jun = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 6
;

update data_warehouse.member_enrollment_yearly y
set enrolled_jul = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 7
;

update data_warehouse.member_enrollment_yearly y
set enrolled_aug = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 8
;

update data_warehouse.member_enrollment_yearly y
set enrolled_sep = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 9
;

update data_warehouse.member_enrollment_yearly y
set enrolled_oct = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 10
;

update data_warehouse.member_enrollment_yearly y
set enrolled_nov = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 11
;

update data_warehouse.member_enrollment_yearly y
set enrolled_dec = true
from dev.temp_member_enrollment_month m 
where y.uth_member_id = m.uth_member_id 
  and y.year = m.year 
  and m.month = 12
;


-- Drop temp table
drop table dev.temp_member_enrollment_month;

--Calculate total_enrolled_months
update data_warehouse.member_enrollment_yearly
set total_enrolled_months=enrolled_jan::int+enrolled_feb::int+enrolled_mar::int+enrolled_apr::int+enrolled_may::int+enrolled_jun::int+enrolled_jul::int+enrolled_aug::int+enrolled_sep::int+enrolled_oct::int+enrolled_nov::int+enrolled_dec::int

--validate
select * from data_warehouse.member_enrollment_yearly where total_enrolled_months = 12 and data_source = 'truv';



---states are calculated base on most lived state in a given year 
select count(*), min(month_year_id) as my, uth_member_id, state, year 
 into dev.wc_state_yearly
from data_warehouse.member_enrollment_monthly
group by uth_member_id, state, year 


select * , row_number() over(partition by uth_member_id,year order by count desc, my asc) as my_grp
into dev.wc_state_yearly_final
from dev.wc_state_yearly
order by uth_member_id, year ;
  

update data_warehouse.member_enrollment_yearly a set state = b.state 
from dev.wc_state_yearly_final b 
where a.uth_member_id = b.uth_member_id
and a.year = b.year 
 and b.my_grp = 1;


drop table dev.wc_state_yearly;

drop table dev.wc_state_yearly_final;

---same logic for zip3
select count(*), min(month_year_id) as my, uth_member_id, zip3, year 
 into dev.wc_zip3_yearly
from data_warehouse.member_enrollment_monthly
group by uth_member_id, zip3, year 


select * , row_number() over(partition by uth_member_id,year order by count desc, my asc) as my_grp
into dev.wc_zip3_yearly_final
from dev.wc_zip3_yearly
order by uth_member_id, year ;
  

update data_warehouse.member_enrollment_yearly a set zip3 = b.zip3
from dev.wc_zip3_yearly_final b 
where a.uth_member_id = b.uth_member_id
and a.year = b.year 
 and b.my_grp = 1;


drop table dev.wc_zip3_yearly;

drop table dev.wc_zip3_yearly_final;

---same logic for dod
select count(*), min(month_year_id) as my, uth_member_id, dod, year 
 into dev.wc_dod_yearly
from data_warehouse.member_enrollment_monthly
group by uth_member_id, dod, year 


select * , row_number() over(partition by uth_member_id,year order by count desc, my asc) as my_grp
into dev.wc_dod_yearly_final
from dev.wc_dod_yearly
order by uth_member_id, year ;
  

update data_warehouse.member_enrollment_yearly a set dod = b.dod
from dev.wc_dod_yearly_final b 
where a.uth_member_id = b.uth_member_id
and a.year = b.year 
 and b.my_grp = 1;


drop table dev.wc_dod_yearly;

drop table dev.wc_dod_yearly_final;


---same logic for plan type
select count(*), min(month_year_id) as my, uth_member_id, plan_type, year 
 into dev.wc_plan_type_yearly
from data_warehouse.member_enrollment_monthly
group by uth_member_id, plan_type, year 


select * , row_number() over(partition by uth_member_id,year order by count desc, my asc) as my_grp
into dev.wc_plan_type_yearly_final
from dev.wc_plan_type_yearly
order by uth_member_id, year ;
  

update data_warehouse.member_enrollment_yearly a set plan_type = b.plan_type
from dev.wc_plan_type_yearly_final b 
where a.uth_member_id = b.uth_member_id
and a.year = b.year 
 and b.my_grp = 1;


drop table dev.wc_plan_type_yearly;

drop table dev.wc_plan_type_yearly_final;


---same logic for EE status
select count(*), min(month_year_id) as my, uth_member_id, employee_status, year 
 into dev.wc_employee_status_yearly
from data_warehouse.member_enrollment_monthly
group by uth_member_id, employee_status, year 


select * , row_number() over(partition by uth_member_id,year order by count desc, my asc) as my_grp
into dev.wc_employee_status_yearly_final
from dev.wc_employee_status_yearly
order by uth_member_id, year ;
  

update data_warehouse.member_enrollment_yearly a set employee_status = b.employee_status
from dev.wc_employee_status_yearly_final b 
where a.uth_member_id = b.uth_member_id
and a.year = b.year 
 and b.my_grp = 1;


drop table dev.wc_employee_status_yearly;

drop table dev.wc_employee_status_yearly_final;

---when bus cd changes in yearly create a new record for that member
---

----cleanup
select * from data_warehouse.member_enrollment_yearly

vacuum analyze data_warehouse.member_enrollment_yearly;



-----------------------------------------
--Scratch
select count(*), count(distinct uth_member_id ), year , data_source 
from  data_warehouse.member_enrollment_yearly
group by year, data_source 
order by data_source , year ;

select * from  data_warehouse.member_enrollment_yearly where enrolled_jul is false limit 10;

select month_year_id, month_year_id % year as month 
from  data_warehouse.member_enrollment_monthly 
order by uth_member_id limit 10;


--Pick a random uth_member_id and verify
select *
from data_warehouse.member_enrollment_monthly mem 
where uth_member_id = 100312028
order by month_year_id ;

select *
from data_warehouse.member_enrollment_yearly mem 
where uth_member_id = 100312028
order by year;

