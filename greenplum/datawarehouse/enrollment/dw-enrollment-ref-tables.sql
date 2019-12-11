-------------------------------------------------------------------------------------------------------
---- Tables Loaded from csv or other source files
-------------------------------------------------------------------------------------------------------
				
create table data_warehouse.ref_truven_state_codes (truven_code int2, state varchar, abbr text);			

create table data_warehouse.ref_admit_type (admit_type_cd char(1), admit_type varchar, admit_type_desc varchar);

create table data_warehouse.ref_admit_source (admit_source_cd char(5), admit_source varchar, admit_source_desc varchar);

create table data_warehouse.ref_medicare_state_codes (medicare_state_cd char(2), state varchar, state_cd char(2));
-------------------------------------------------------------------------------------------------------
---- Tables loaded with a hardcoded SQL insert statement
-------------------------------------------------------------------------------------------------------


--- Data Source table
drop table data_warehouse.ref_data_source ; 

create table data_warehouse.ref_data_source
(
	data_source char(4),
	data_source_cd smallint,
	data_source_desc text,
	fiscal_year_flag bool,
	fiscal_year_begin_month int
)
;


select * 
from data_warehouse.member_enrollment_monthly where data_source = 'trvc';


insert into data_warehouse.ref_data_source (data_source, data_source_cd, data_source_desc, fiscal_year_flag, fiscal_year_begin_month)
       values ('optz',10,'Optum Zip',false,1),
   			  ('optd',20,'Optum Date of Death',false,1),
   			  ('trvc',30,'Truven Commercial',false,1),
   			  ('trvm',30,'Truven Medicare',false,1),  --- the 30 is intentional, truven commercial and medicare members should have the same ID
   			 -- ('bcbs',40,'BlueCross BlueShield'),
   			  ('mdcr',50,'Medicare',false,1);
   			 -- ('mdcd',60,'Medicaid'),
   			 -- ('cern',70,'Cerner')	       
       
   			 




--- gender decode table
create table data_warehouse.ref_gender 
(
	data_source char(4), 
	gender_cd_src char(5),
	gender_cd char(1)
)
;

delete from data_warehouse.ref_gender;

insert into data_warehouse.ref_gender (data_source, gender_cd_src, gender_cd)
       values ('trv','1','M'),
              ('trv','2','F'),
              ('opt','M','M'),
              ('opt','F','F'),
              ('opt','U','U'), 
              ('mdcr','0','U'),
              ('mdcr','1','M'),
              ('mdcr','2','F') ;

             
             
---plan type decode table   			 
create table data_warehouse.ref_plan_type (
				data_source char(4), 
				source_column_name text, 
				plan_type_src varchar, 
				plan_type char(4), 
				plan_desc text
				);
				
delete from data_warehouse.ref_plan_type;				
				
insert into data_warehouse.ref_plan_type (data_source, source_column_name, plan_type_src, plan_type, plan_desc)
		values ('trv','plantyp','1','BMM','basic major medical'),
			   ('trv','plantyp','2','CMP','comprehensive'),
			   ('trv','plantyp','3','EPO',''),
			   ('trv','plantyp','4','HMO',''),
			   ('trv','plantyp','5','POS',''),
			   ('trv','plantyp','6','PPO',''),
			   ('trv','plantyp','7','POS','pos with capitation'),
			   ('trv','plantyp','8','CDHP',''),
			   ('trv','plantyp','9','HDHP',''),
			   ('opt','product','ALL','ALL',''),
			   ('opt','product','EPO','EPO',''),
			   ('opt','product','GPO','GPO',''),
			   ('opt','product','HMO','HMO',''),
			   ('opt','product','IND','IND',''),
			   ('opt','product','IPP','IPP',''),
			   ('opt','product','NONE','NONE',''),
			   ('opt','product','OTH','OTH',''),
			   ('opt','product','POS','POS',''),
			   ('opt','product','PPO','PPO',''),
			   ('opt','product','SPN','SPN',''),
			   ('opt','product','UNK','UNK','')
			   ;
				

--- business code decode table

create table data_warehouse.ref_bus_cd ( data_source char(4), bus_cd_src varchar, bus_cd char(4), column_name_src varchar, bus_desc varchar );

insert into data_warehouse.ref_bus_cd (data_source, bus_cd_src, bus_cd, column_name_src, bus_desc)
	   values ('trvm',null,'MCR',null,'Medicare Advantage'),
	          ('trvc',null,'COM',null,'Commercial'),
	          ('opt','MCR','MCR','bus','Medicare Advantage'),
	          ('opt','COM','COM','bus','Commercial'),
	          ('mdcr',null,'MDCR',null,'Medicare')
	         ;
 