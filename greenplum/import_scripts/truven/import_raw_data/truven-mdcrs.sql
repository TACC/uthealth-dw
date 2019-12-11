/*
 This stupid file has 3 different versions of the headers
 
v1 Fields:

SEQNUM,VERSION,DX1,DX2,PROC1,PROCTYP,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,CASEID,COB,COINS,COPAY,DEDUCT,DISDATE,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,WGTKEY,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,PLANKEY,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY

v2 Fields: (CASEID and DISDATE change position)

SEQNUM,VERSION,DX1,DX2,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,WGTKEY,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,PLANKEY,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY

v3 Fields: (Drop PLANKEY and WGTKEY, Add DXVER, UNITS and NPI)

SEQNUM,VERSION,DX1,DX2,DXVER,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NPI,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,UNITS,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY

v4 Fields: (CASEID & DISDATE moved) 2017

SEQNUM,VERSION,DX1,DX2,DXVER,PROC1,PROCTYP,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,CASEID,COB,COINS,COPAY,DEDUCT,DISDATE,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NPI,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,UNITS,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY

*/

drop table truven.mdcrs;
CREATE TABLE truven.mdcrs (
	seqnum numeric NULL,
	version int2 NULL,
	dx1 bpchar(10) NULL,
	dx2 bpchar(10) NULL,
	dxver bpchar(10) NULL,
	proc1 bpchar(10) NULL,
	proctyp bpchar(10) null,
	caseid numeric null,
	disdate date null,
	dobyr numeric NULL,
	year numeric NULL,
	admdate date null,
	age numeric NULL,
	
	cap_svc bpchar(1) NULL,
	cob numeric NULL,
	coins numeric NULL,
	copay numeric NULL,
	deduct numeric null,
	drg numeric null,
	dx3 bpchar(10) null,
	dx4 bpchar(10) null,
	fachdid numeric null,
	facprof bpchar(1) null,
	mhsacovg int2 NULL,
	msclmid numeric null,
	
	netpay numeric NULL,
	npi bpchar(10) null,
	ntwkprov bpchar(1) NULL,
	paidntwk bpchar(1) NULL,
	pay numeric NULL,
	pddate date NULL,
	pdx bpchar(10) null,
	pproc bpchar(10) NULL,
	procmod bpchar(2) NULL,
	provid numeric NULL,
	qty numeric null,
	revcode int2 NULL,
	
	svcdate date null,
	svcscat int4 null,
	tsvcdat date null,
	units numeric null,
	admtyp numeric null,
	mdc int2 null,
	dstatus numeric null,
	stdplac numeric null,
	stdprov numeric null,
	wgtkey numeric null,
	
	efamid numeric NULL,
	enrolid numeric NULL,
	empzip numeric null,
	plantyp numeric null,
	region int2 null,
	datatyp numeric null,
	plankey numeric null,	
	agegrp int2 null,
	
	eeclass int2 null,
	eestatu int2 null,
	egeoloc int2 null,
	eidflag int2 null,
	emprel int2 null,
	enrflag int2 null,
	phyflag int2 null,
	rx int2 null,
	sex int2 null,
	hlthplan int2 null,
	indstry bpchar(5) null
)
DISTRIBUTED RANDOMLY;

drop external table ext_mdcrs_v1;
CREATE EXTERNAL TABLE ext_mdcrs_v1 (
	seqnum numeric ,
	version int2 ,
	dx1 bpchar(10) ,
	dx2 bpchar(10) ,
	proc1 bpchar(10) ,
	proctyp bpchar(10) ,
	
	dobyr numeric ,
	year numeric ,
	admdate date ,
	age numeric ,
	
	cap_svc bpchar(1) ,
	caseid numeric ,
	cob numeric ,
	coins numeric ,
	copay numeric ,
	deduct numeric ,
	disdate date ,
	drg numeric ,
	dx3 bpchar(10) ,
	dx4 bpchar(10) ,
	fachdid numeric ,
	facprof bpchar(1) ,
	mhsacovg int2 ,
	msclmid numeric ,
	
	netpay numeric ,
	ntwkprov bpchar(1) ,
	paidntwk bpchar(1) ,
	pay numeric ,
	pddate date ,
	pdx bpchar(10) ,
	pproc bpchar(10) ,
	procmod bpchar(2) ,
	provid numeric ,
	qty numeric ,
	revcode int2 ,
	
	svcdate date ,
	svcscat int4 ,
	tsvcdat date ,
	admtyp numeric ,
	mdc int2 ,
	dstatus numeric ,
	stdplac numeric ,
	stdprov numeric ,
	wgtkey numeric ,

	efamid numeric ,
	enrolid numeric ,
	empzip numeric ,
	plantyp numeric ,
	region int2 ,
	datatyp numeric ,
	plankey numeric ,
	agegrp int2 ,
	
	eeclass int2 ,
	eestatu int2 ,
	egeoloc int2 ,
	eidflag int2 ,
	emprel int2 ,
	enrflag int2 ,
	phyflag int2 ,
	rx int2 ,
	sex int2 ,
	hlthplan int2 ,
	indstry bpchar(5) 
) 
LOCATION ( 
'gpfdist://c252-140:8801/*'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_mdcrs_v1
limit 1000;

truncate table truven.mdcrs;

insert into truven.mdcrs (SEQNUM,VERSION,DX1,DX2,PROC1,PROCTYP,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,CASEID,COB,COINS,COPAY,DEDUCT,DISDATE,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,WGTKEY,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,PLANKEY,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY)
select SEQNUM,VERSION,DX1,DX2,PROC1,PROCTYP,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,CASEID,COB,COINS,COPAY,DEDUCT,DISDATE,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,WGTKEY,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,PLANKEY,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY
from ext_mdcrs_v1;


drop external table ext_mdcrs_v2;
CREATE EXTERNAL TABLE ext_mdcrs_v2 (
	seqnum numeric ,
	version int2 ,
	dx1 bpchar(10) ,
	dx2 bpchar(10) ,
	proc1 bpchar(10) ,
	proctyp bpchar(10) ,
	caseid numeric ,
	disdate date ,
		
	dobyr numeric ,
	year numeric ,
	admdate date ,
	age numeric ,
	
	cap_svc bpchar(1) ,	
	cob numeric ,
	coins numeric ,
	copay numeric ,
	deduct numeric ,
	drg numeric ,
	dx3 bpchar(10) ,
	dx4 bpchar(10) ,
	fachdid numeric ,
	facprof bpchar(1) ,
	mhsacovg int2 ,
	msclmid numeric ,
	
	netpay numeric ,
	ntwkprov bpchar(1) ,
	paidntwk bpchar(1) ,
	pay numeric ,
	pddate date ,
	pdx bpchar(10) ,
	pproc bpchar(10) ,
	procmod bpchar(2) ,
	provid numeric ,
	qty numeric ,
	revcode int2 ,
	
	svcdate date ,
	svcscat int4 ,
	tsvcdat date ,
	admtyp numeric ,
	mdc int2 ,
	dstatus numeric ,
	stdplac numeric ,
	stdprov numeric ,
	wgtkey numeric ,

	efamid numeric ,
	enrolid numeric ,
	empzip numeric ,
	plantyp numeric ,
	region int2 ,
	datatyp numeric ,
	plankey numeric ,
	agegrp int2 ,
	
	eeclass int2 ,
	eestatu int2 ,
	egeoloc int2 ,
	eidflag int2 ,
	emprel int2 ,
	enrflag int2 ,
	phyflag int2 ,
	rx int2 ,
	sex int2 ,
	hlthplan int2 ,
	indstry bpchar(5) 
) 
LOCATION ( 
'gpfdist://c252-140:8801/*'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_mdcrs_v2
limit 1000;

truncate table truven.mdcrs;

insert into truven.mdcrs (SEQNUM,VERSION,DX1,DX2,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,WGTKEY,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,PLANKEY,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY)
select SEQNUM,VERSION,DX1,DX2,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,WGTKEY,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,PLANKEY,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY
from ext_mdcrs_v2;


drop external table ext_mdcrs_v3;
CREATE EXTERNAL TABLE ext_mdcrs_v3 (
	seqnum numeric ,
	version int2 ,
	dx1 bpchar(10) ,
	dx2 bpchar(10) ,
	dxver bpchar(10) ,
	proc1 bpchar(10) ,
	proctyp bpchar(10) ,
	caseid numeric ,
	disdate date ,
	dobyr numeric ,
	year numeric ,
	admdate date ,
	age numeric ,
	
	cap_svc bpchar(1) ,
	cob numeric ,
	coins numeric ,
	copay numeric ,
	deduct numeric ,
	drg numeric ,
	dx3 bpchar(10) ,
	dx4 bpchar(10) ,
	fachdid numeric ,
	facprof bpchar(1) ,
	mhsacovg int2 ,
	msclmid numeric ,
	
	netpay numeric ,
	npi bpchar(10) ,
	ntwkprov bpchar(1) ,
	paidntwk bpchar(1) ,
	pay numeric ,
	pddate date ,
	pdx bpchar(10) ,
	pproc bpchar(10) ,
	procmod bpchar(2) ,
	provid numeric ,
	qty numeric ,
	revcode int2 ,
	
	svcdate date ,
	svcscat int4 ,
	tsvcdat date ,
	units numeric ,
	admtyp numeric ,
	mdc int2 ,
	dstatus numeric ,
	stdplac numeric ,
	stdprov numeric ,

	efamid numeric ,
	enrolid numeric ,
	empzip numeric ,
	plantyp numeric ,
	region int2 ,
	datatyp numeric ,
	agegrp int2 ,
	
	eeclass int2 ,
	eestatu int2 ,
	egeoloc int2 ,
	eidflag int2 ,
	emprel int2 ,
	enrflag int2 ,
	phyflag int2 ,
	rx int2 ,
	sex int2 ,
	hlthplan int2 ,
	indstry bpchar(5)
) 
LOCATION ( 
'gpfdist://c252-140:8801/mdcrs162*'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_mdcrs_v3
limit 1000;

insert into truven.mdcrs (SEQNUM,VERSION,DX1,DX2,DXVER,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NPI,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,UNITS,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY)
select SEQNUM,VERSION,DX1,DX2,DXVER,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NPI,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,UNITS,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY
from ext_mdcrs_v3;

--V4

drop external table ext_mdcrs_v4;
CREATE EXTERNAL TABLE ext_mdcrs_v4 (
	seqnum numeric ,
	version int2 ,
	dx1 bpchar(10) ,
	dx2 bpchar(10) ,
	dxver bpchar(10) ,
	proc1 bpchar(10) ,
	proctyp bpchar(10) ,
	
	
	dobyr numeric ,
	year numeric ,
	admdate date ,
	age numeric ,
	
	cap_svc bpchar(1) ,
	
	caseid numeric ,
	
	cob numeric ,
	coins numeric ,
	copay numeric ,
	deduct numeric ,
	
	disdate date ,
	
	drg numeric ,
	dx3 bpchar(10) ,
	dx4 bpchar(10) ,
	fachdid numeric ,
	facprof bpchar(1) ,
	mhsacovg int2 ,
	msclmid numeric ,
	
	netpay numeric ,
	npi bpchar(10) ,
	ntwkprov bpchar(1) ,
	paidntwk bpchar(1) ,
	pay numeric ,
	pddate date ,
	pdx bpchar(10) ,
	pproc bpchar(10) ,
	procmod bpchar(2) ,
	provid numeric ,
	qty numeric ,
	revcode int2 ,
	
	svcdate date ,
	svcscat int4 ,
	tsvcdat date ,
	units numeric ,
	admtyp numeric ,
	mdc int2 ,
	dstatus numeric ,
	stdplac numeric ,
	stdprov numeric ,

	efamid numeric ,
	enrolid numeric ,
	empzip numeric ,
	plantyp numeric ,
	region int2 ,
	datatyp numeric ,
	agegrp int2 ,
	
	eeclass int2 ,
	eestatu int2 ,
	egeoloc int2 ,
	eidflag int2 ,
	emprel int2 ,
	enrflag int2 ,
	phyflag int2 ,
	rx int2 ,
	sex int2 ,
	hlthplan int2 ,
	indstry bpchar(5)
) 
LOCATION ( 
'gpfdist://c252-140:8801/mdcrs171*'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select disdate, *
from ext_mdcrs_v4
limit 1000;

insert into truven.mdcrs (SEQNUM,VERSION,DX1,DX2,DXVER,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NPI,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,UNITS,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY)
select SEQNUM,VERSION,DX1,DX2,DXVER,PROC1,PROCTYP,CASEID,DISDATE,DOBYR,YEAR,ADMDATE,AGE,
CAP_SVC,COB,COINS,COPAY,DEDUCT,DRG,DX3,DX4,FACHDID,FACPROF,MHSACOVG,MSCLMID,
NETPAY,NPI,NTWKPROV,PAIDNTWK,PAY,PDDATE,PDX,PPROC,PROCMOD,PROVID,QTY,REVCODE,
SVCDATE,SVCSCAT,TSVCDAT,UNITS,ADMTYP,MDC,DSTATUS,STDPLAC,STDPROV,
EFAMID,ENROLID,EMPZIP,PLANTYP,REGION,DATATYP,AGEGRP,
EECLASS,EESTATU,EGEOLOC,EIDFLAG,EMPREL,ENRFLAG,PHYFLAG,RX,SEX,HLTHPLAN,INDSTRY
from ext_mdcrs_v4;


-- Verify

select count(*), min(year), max(year) from truven.mdcrs;



-- Fix storage options
create table truven.mdcrs_new 
WITH (appendonly=true, orientation=column)
as (select * from truven.mdcrs)
distributed randomly;

drop table truven.mdcrs;
alter table truven.mdcrs_new rename to mdcrs;
