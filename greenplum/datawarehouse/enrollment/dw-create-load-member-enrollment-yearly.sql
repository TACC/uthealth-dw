/* ******************************************************************************************************
 * Deletes and recreates member_enrollment_yearly records based on member_enrollment_monthly for a given dataset.
 * This includes creating all derived columns.
 * ******************************************************************************************************
 *  Author || Date      || Notes
 * ******************************************************************************************************
 *  wc001  || 1/01/2021 || script created
 * ******************************************************************************************************
 *  wallingTACC || 8/23/2021 || updated comments.
 * ******************************************************************************************************
 * jw002  || 9/08/2021 || added function for individual month flags
 * ******************************************************************************************************
 * wc002  || 9/09/2021 || move to dw_staging
 * ******************************************************************************************************
 */

alter table dw_staging.member_enrollment_yearly add column family_id text, add column behavioral_coverage char(1);

select distinct data_source from dw_staging.member_enrollment_monthly ;




do $$
declare
    ---change this according to what data is being updated, use two single quotes around each data source i.e.  ''optz''
    --- my_data_source text := ' (''truv'',''mcrt'',''optz'') ';
	my_data_source text := ' (''truv'') ';
	yearly_records_check boolean := false;
	month_counter integer := 1;
	my_update_column text[]:= array['enrolled_jan','enrolled_feb','enrolled_mar',
	'enrolled_apr','enrolled_may','enrolled_jun','enrolled_jul','enrolled_aug',
	'enrolled_sep','enrolled_oct','enrolled_nov','enrolled_dec'];
begin
	raise notice 'Building enrollment yearly table for %', my_data_source;
    
	execute 'select exists (select 1 from dw_staging.member_enrollment_yearly where data_source in' || my_data_source || ');'
	into yearly_records_check;
	raise notice 'check %', yearly_records_check;
	if yearly_records_check = true then 
		raise notice 'Records exists for % , deleting...', my_data_source;
		execute 'delete from dw_staging.member_enrollment_yearly where data_source in ' || my_data_source || ';';
		raise notice '...done';
	end if;

--insert recs from monthly  14min
execute 'insert into dw_staging.member_enrollment_yearly (
         data_source, 
         year, 
         uth_member_id, 
		 gender_cd, 
		 age_derived, 
		 dob_derived, 
		 death_date,
		 bus_cd, 
		 claim_created_flag, 
		 rx_coverage, 
		 fiscal_year, 
		 race_cd,
         family_id,
		 behavioral_coverage )
select distinct on( data_source, year, uth_member_id )
       data_source, 
       year, 
       uth_member_id, 
       gender_cd, 
	   age_derived, 
	   dob_derived, 
	   death_date,
       bus_cd,
	   claim_created_flag, 
	   rx_coverage, 
	   fiscal_year, 
	   race_cd,
	   family_id,
	   behavioral_coverage
from dw_staging.member_enrollment_monthly 
where data_source in ' || my_data_source || ';'
;

raise notice 'Records inserted into enrollment yearly for %', my_data_source;


--Create temp join table to populate month flags 6min
drop table if exists dw_staging.temp_member_enrollment_month;

execute 'create table dw_staging.temp_member_enrollment_month
with (appendonly=true, orientation=column)
as
select distinct uth_member_id, year, month_year_id, month_year_id % year as month
from dw_staging.member_enrollment_monthly
where data_source in ' || my_data_source || '
distributed by(uth_member_id);'
;


--Add month flags
--jw002 use execute function to loop through each month
	for array_counter in 1..12
	loop
	execute
	'update dw_staging.member_enrollment_yearly y
			set ' || my_update_column[array_counter] || '= 1
			from dw_staging.temp_member_enrollment_month m
			where y.uth_member_id = m.uth_member_id
			  and y.year = m.year
			  and m.month = ' || month_counter || ';';
	raise notice 'Month of %', my_update_column[array_counter];
  month_counter = month_counter + 1;
	array_counter = month_counter + 1;
	end loop;



--Calculate total_enrolled_months
update dw_staging.member_enrollment_yearly
set total_enrolled_months=enrolled_jan::int+enrolled_feb::int+enrolled_mar::int+enrolled_apr::int+enrolled_may::int+enrolled_jun::int+
                          enrolled_jul::int+enrolled_aug::int+enrolled_sep::int+enrolled_oct::int+enrolled_nov::int+enrolled_dec::int;


-- Drop temp table
drop table if exists dw_staging.temp_member_enrollment_month;

raise notice 'total_enrolled_months updated';

end $$
;
-----------------------------------------------------------------------------------------------------------------------
-----************** logic for yearly rollup of various columns
-- all logic finds the most common occurence in a given year and assigns that value  28min
-----------------------------------------------------------------------------------------------------------------------

select count(*), data_source 
from dw_staging.member_enrollment_yearly mey 
group by data_source ;

select * 
from dw_staging.member_enrollment_yearly mey where data_source = 'truv' and total_enrolled_months between 1 and 11;

select * from dw_staging.temp_member_enrollment_month


---states
select count(*), min(month_year_id) as my, uth_member_id, state, year
 into dev.wc_state_yearly
from dw_staging.member_enrollment_monthly
group by uth_member_id, state, year
;

create table dev.wc_state_yearly_final
with (appendonly=true, orientation=column)
as
select * , row_number() over(partition by uth_member_id,year order by count desc, my desc) as my_grp
from dev.wc_state_yearly
distributed by(uth_member_id);


update dw_staging.member_enrollment_yearly a set state = b.state
from dev.wc_state_yearly_final b
where a.uth_member_id = b.uth_member_id
and a.year = b.year
 and b.my_grp = 1;



drop table dev.wc_state_yearly;

drop table dev.wc_state_yearly_final;

---zip3
select count(*), min(month_year_id) as my, uth_member_id, zip3, year
 into dev.wc_zip3_yearly
from dw_staging.member_enrollment_monthly
group by uth_member_id, zip3, year
;

create table dev.wc_zip3_yearly_final
with (appendonly=true, orientation=column)
as
select * , row_number() over(partition by uth_member_id,year order by count desc, my desc) as my_grp
from dev.wc_zip3_yearly
distributed by(uth_member_id);


update dw_staging.member_enrollment_yearly a set zip3 = b.zip3
from dev.wc_zip3_yearly_final b
where a.uth_member_id = b.uth_member_id
and a.year = b.year
 and b.my_grp = 1;




drop table dev.wc_zip3_yearly;

drop table dev.wc_zip3_yearly_final;


--- zip5
select count(*), min(month_year_id) as my, uth_member_id, zip5, year
into dev.wc_zip5_yearly
from dw_staging.member_enrollment_monthly
group by uth_member_id, zip5, year
;


create table dev.wc_ZIP5_yearly_final
with (appendonly=true, orientation=column)
as
select * , row_number() over(partition by uth_member_id,year order by count desc, my desc) as my_grp
from dev.wc_ZIP5_yearly
distributed by(uth_member_id);

update dw_staging.member_enrollment_yearly a set zip5 = b.zip5
from dev.wc_zip5_yearly_final b
where a.uth_member_id = b.uth_member_id
and a.year = b.year
 and b.my_grp = 1;


drop table dev.wc_ZIP5_yearly;

drop table dev.wc_ZIP5_yearly_final;


--- plan type
select count(*), min(month_year_id) as my, uth_member_id, plan_type, year
 into dev.wc_plan_type_yearly
from dw_staging.member_enrollment_monthly
group by uth_member_id, plan_type, year
;

create table dev.wc_plan_type_yearly_final
with (appendonly=true, orientation=column)
as
select * , row_number() over(partition by uth_member_id,year order by count desc, my desc) as my_grp
from dev.wc_plan_type_yearly
distributed by(uth_member_id);


update dw_staging.member_enrollment_yearly a set plan_type = b.plan_type
from dev.wc_plan_type_yearly_final b
where a.uth_member_id = b.uth_member_id
and a.year = b.year
 and b.my_grp = 1;


drop table dev.wc_plan_type_yearly;

drop table dev.wc_plan_type_yearly_final;


---EE status
select count(*), min(month_year_id) as my, uth_member_id, employee_status, year
 into dev.wc_employee_status_yearly
from dw_staging.member_enrollment_monthly
group by uth_member_id, employee_status, year
;

create table dev.wc_employee_status_yearly_final
with (appendonly=true, orientation=column)
as
select * , row_number() over(partition by uth_member_id,year order by count desc, my desc) as my_grp
from dev.wc_employee_status_yearly
distributed by(uth_member_id);


update dw_staging.member_enrollment_yearly a set employee_status = b.employee_status
from dev.wc_employee_status_yearly_final b
where a.uth_member_id = b.uth_member_id
and a.year = b.year
 and b.my_grp = 1;


drop table dev.wc_employee_status_yearly;

drop table dev.wc_employee_status_yearly_final;


vacuum analyze dw_staging.member_enrollment_yearly;

------------------------- END SCRIPT 

