drop external table ext_pde_file;

CREATE EXTERNAL TABLE ext_pde_file (
year text, filename text,
PDE_ID varchar, BENE_ID varchar, DOB_DT varchar, GNDR_CD varchar, SRVC_DT varchar, PD_DT varchar, SRVC_PRVDR_ID_QLFYR_CD varchar, 
SRVC_PRVDR_ID varchar, PRSCRBR_ID_QLFYR_CD varchar, PRSCRBR_ID varchar, RX_SRVC_RFRNC_NUM varchar, PROD_SRVC_ID varchar, 
PLAN_CNTRCT_REC_ID varchar, PLAN_PBP_REC_NUM varchar, CMPND_CD varchar, DAW_PROD_SLCTN_CD varchar, QTY_DSPNSD_NUM varchar, 
DAYS_SUPLY_NUM varchar, FILL_NUM varchar, DRUG_CVRG_STUS_CD varchar, ADJSTMT_DLTN_CD varchar, NSTD_FRMT_CD varchar, 
PRCNG_EXCPTN_CD varchar, CTSTRPHC_CVRG_CD varchar, GDC_BLW_OOPT_AMT varchar, GDC_ABV_OOPT_AMT varchar, PTNT_PAY_AMT varchar, 
OTHR_TROOP_AMT varchar, LICS_AMT varchar, PLRO_AMT varchar, CVRD_D_PLAN_PD_AMT varchar, NCVRD_PLAN_PD_AMT varchar, TOT_RX_CST_AMT varchar, 
BN varchar, GCDF varchar, GCDF_DESC varchar, STR varchar, GNN varchar, BENEFIT_PHASE varchar, FORMULARY_ID varchar, FRMLRY_RX_ID varchar, 
RX_ORGN_CD varchar, RPTD_GAP_DSCNT_NUM varchar, BRND_GNRC_CD varchar, PHRMCY_SRVC_TYPE_CD varchar, PTNT_RSDNC_CD varchar, 
SUBMSN_CLR_CD varchar
) 
LOCATION ( 
'gpfdist://greenplum01:8081/medicare_national/2017/*pde_file.csv.gz#transform=add_parentname_filename_comma'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_pde_file
limit 1000;

create table uthealth/medicare_national.pde_file
WITH (appendonly=true, orientation=column, compresstype=zlib)
as

insert into medicare_national.pde_file (year,
PDE_ID, BENE_ID, DOB_DT, GNDR_CD, SRVC_DT, PD_DT, SRVC_PRVDR_ID_QLFYR_CD, 
SRVC_PRVDR_ID, PRSCRBR_ID_QLFYR_CD, PRSCRBR_ID, RX_SRVC_RFRNC_NUM, PROD_SRVC_ID, 
PLAN_CNTRCT_REC_ID, PLAN_PBP_REC_NUM, CMPND_CD, DAW_PROD_SLCTN_CD, QTY_DSPNSD_NUM, 
DAYS_SUPLY_NUM, FILL_NUM, DRUG_CVRG_STUS_CD, ADJSTMT_DLTN_CD, NSTD_FRMT_CD, 
PRCNG_EXCPTN_CD, CTSTRPHC_CVRG_CD, GDC_BLW_OOPT_AMT, GDC_ABV_OOPT_AMT, PTNT_PAY_AMT, 
OTHR_TROOP_AMT, LICS_AMT, PLRO_AMT, CVRD_D_PLAN_PD_AMT, NCVRD_PLAN_PD_AMT, TOT_RX_CST_AMT, 
BN, GCDF, GCDF_DESC, STR, GNN, BENEFIT_PHASE, FORMULARY_ID, FRMLRY_RX_ID, 
RX_ORGN_CD, RPTD_GAP_DSCNT_NUM, BRND_GNRC_CD, PHRMCY_SRVC_TYPE_CD, PTNT_RSDNC_CD, 
SUBMSN_CLR_CD
)
select year,
PDE_ID, BENE_ID, DOB_DT, GNDR_CD, SRVC_DT, PD_DT, SRVC_PRVDR_ID_QLFYR_CD, 
SRVC_PRVDR_ID, PRSCRBR_ID_QLFYR_CD, PRSCRBR_ID, RX_SRVC_RFRNC_NUM, PROD_SRVC_ID, 
PLAN_CNTRCT_REC_ID, PLAN_PBP_REC_NUM, CMPND_CD, DAW_PROD_SLCTN_CD, QTY_DSPNSD_NUM, 
DAYS_SUPLY_NUM, FILL_NUM, DRUG_CVRG_STUS_CD, ADJSTMT_DLTN_CD, NSTD_FRMT_CD, 
PRCNG_EXCPTN_CD, CTSTRPHC_CVRG_CD, GDC_BLW_OOPT_AMT, GDC_ABV_OOPT_AMT, PTNT_PAY_AMT, 
OTHR_TROOP_AMT, LICS_AMT, PLRO_AMT, CVRD_D_PLAN_PD_AMT, NCVRD_PLAN_PD_AMT, TOT_RX_CST_AMT, 
BN, GCDF, GCDF_DESC, STR, GNN, BENEFIT_PHASE, FORMULARY_ID, FRMLRY_RX_ID, 
RX_ORGN_CD, RPTD_GAP_DSCNT_NUM, BRND_GNRC_CD, PHRMCY_SRVC_TYPE_CD, PTNT_RSDNC_CD, 
SUBMSN_CLR_CD 
from ext_pde_file;

distributed randomly;

-- Scratch
select year, count(*)
from medicare_national.pde_file
group by 1
order by 1;