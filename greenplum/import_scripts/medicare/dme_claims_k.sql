drop external table ext_dme_claims_k;

CREATE EXTERNAL TABLE ext_dme_claims_k (
year text,
BENE_ID varchar, CLM_ID varchar, NCH_NEAR_LINE_REC_IDENT_CD varchar, NCH_CLM_TYPE_CD varchar, CLM_FROM_DT varchar, CLM_THRU_DT varchar, 
NCH_WKLY_PROC_DT varchar, CARR_CLM_ENTRY_CD varchar, CLM_DISP_CD varchar, CARR_NUM varchar, CARR_CLM_PMT_DNL_CD varchar, CLM_PMT_AMT varchar, 
CARR_CLM_PRMRY_PYR_PD_AMT varchar, CARR_CLM_PRVDR_ASGNMT_IND_SW varchar, NCH_CLM_PRVDR_PMT_AMT varchar, NCH_CLM_BENE_PMT_AMT varchar, 
NCH_CARR_CLM_SBMTD_CHRG_AMT varchar, NCH_CARR_CLM_ALOWD_AMT varchar, CARR_CLM_CASH_DDCTBL_APLD_AMT varchar, CARR_CLM_HCPCS_YR_CD varchar, 
PRNCPAL_DGNS_CD varchar, PRNCPAL_DGNS_VRSN_CD varchar, ICD_DGNS_CD1 varchar, ICD_DGNS_VRSN_CD1 varchar, ICD_DGNS_CD2 varchar, 
ICD_DGNS_VRSN_CD2 varchar, ICD_DGNS_CD3 varchar, ICD_DGNS_VRSN_CD3 varchar, ICD_DGNS_CD4 varchar, ICD_DGNS_VRSN_CD4 varchar, 
ICD_DGNS_CD5 varchar, ICD_DGNS_VRSN_CD5 varchar, ICD_DGNS_CD6 varchar, ICD_DGNS_VRSN_CD6 varchar, ICD_DGNS_CD7 varchar, 
ICD_DGNS_VRSN_CD7 varchar, ICD_DGNS_CD8 varchar, ICD_DGNS_VRSN_CD8 varchar, ICD_DGNS_CD9 varchar, ICD_DGNS_VRSN_CD9 varchar, 
ICD_DGNS_CD10 varchar, ICD_DGNS_VRSN_CD10 varchar, ICD_DGNS_CD11 varchar, ICD_DGNS_VRSN_CD11 varchar, ICD_DGNS_CD12 varchar, 
ICD_DGNS_VRSN_CD12 varchar, RFR_PHYSN_UPIN varchar, RFR_PHYSN_NPI varchar, CLM_CLNCL_TRIL_NUM varchar, DOB_DT varchar, GNDR_CD varchar, 
BENE_RACE_CD varchar, BENE_CNTY_CD varchar, BENE_STATE_CD varchar, BENE_MLG_CNTCT_ZIP_CD varchar, CLM_BENE_PD_AMT varchar, ACO_ID_NUM varchar, 
CLM_BENE_ID_TYPE_CD varchar
) 
LOCATION ( 
'gpfdist://greenplum01:8081/uthealth/medicare_national/*/DME_CLAIMS.CSV#transform=add_parentname_filename_comma'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_dme_claims_k
limit 1000;

create table uthealth/medicare_national.dme_claims_k
WITH (appendonly=true, orientation=column, compresstype=zlib)
as
--insert into uthealth/medicare_national.dme_claims_k 
select * 
from ext_dme_claims_k
distributed randomly;

-- 2018 & 2019
/*
BENE_ID,CLM_ID,NCH_NEAR_LINE_REC_IDENT_CD,NCH_CLM_TYPE_CD,CLM_FROM_DT,CLM_THRU_DT,
NCH_WKLY_PROC_DT,CARR_CLM_ENTRY_CD,CLM_DISP_CD,CARR_NUM,CARR_CLM_PMT_DNL_CD,CLM_PMT_AMT,
CARR_CLM_PRMRY_PYR_PD_AMT,CARR_CLM_PRVDR_ASGNMT_IND_SW,NCH_CLM_PRVDR_PMT_AMT,NCH_CLM_BENE_PMT_AMT,
NCH_CARR_CLM_SBMTD_CHRG_AMT,NCH_CARR_CLM_ALOWD_AMT,CARR_CLM_CASH_DDCTBL_APLD_AMT,CARR_CLM_HCPCS_YR_CD,
PRNCPAL_DGNS_CD,PRNCPAL_DGNS_VRSN_CD,ICD_DGNS_CD1,ICD_DGNS_VRSN_CD1,ICD_DGNS_CD2,
ICD_DGNS_VRSN_CD2,ICD_DGNS_CD3,ICD_DGNS_VRSN_CD3,ICD_DGNS_CD4,ICD_DGNS_VRSN_CD4,
ICD_DGNS_CD5,ICD_DGNS_VRSN_CD5,ICD_DGNS_CD6,ICD_DGNS_VRSN_CD6,ICD_DGNS_CD7,
ICD_DGNS_VRSN_CD7,ICD_DGNS_CD8,ICD_DGNS_VRSN_CD8,ICD_DGNS_CD9,ICD_DGNS_VRSN_CD9,
ICD_DGNS_CD10,ICD_DGNS_VRSN_CD10,ICD_DGNS_CD11,ICD_DGNS_VRSN_CD11,ICD_DGNS_CD12,
ICD_DGNS_VRSN_CD12,RFR_PHYSN_UPIN,RFR_PHYSN_NPI,CLM_CLNCL_TRIL_NUM,DOB_DT,GNDR_CD,
BENE_RACE_CD,BENE_CNTY_CD,BENE_STATE_CD,BENE_MLG_CNTCT_ZIP_CD,CLM_BENE_PD_AMT,ACO_ID_NUM,
CLM_BENE_ID_TYPE_CD,CLM_RSDL_PYMT_IND_CD
 */
alter table medicare_national.dme_claims_k add column CLM_RSDL_PYMT_IND_CD varchar;

drop external table ext_dme_claims_k;

CREATE EXTERNAL TABLE ext_dme_claims_k (
year text, filename text,
BENE_ID varchar, CLM_ID varchar, NCH_NEAR_LINE_REC_IDENT_CD varchar, NCH_CLM_TYPE_CD varchar, CLM_FROM_DT varchar, CLM_THRU_DT varchar, 
NCH_WKLY_PROC_DT varchar, CARR_CLM_ENTRY_CD varchar, CLM_DISP_CD varchar, CARR_NUM varchar, CARR_CLM_PMT_DNL_CD varchar, CLM_PMT_AMT varchar, 
CARR_CLM_PRMRY_PYR_PD_AMT varchar, CARR_CLM_PRVDR_ASGNMT_IND_SW varchar, NCH_CLM_PRVDR_PMT_AMT varchar, NCH_CLM_BENE_PMT_AMT varchar, 
NCH_CARR_CLM_SBMTD_CHRG_AMT varchar, NCH_CARR_CLM_ALOWD_AMT varchar, CARR_CLM_CASH_DDCTBL_APLD_AMT varchar, CARR_CLM_HCPCS_YR_CD varchar, 
PRNCPAL_DGNS_CD varchar, PRNCPAL_DGNS_VRSN_CD varchar, ICD_DGNS_CD1 varchar, ICD_DGNS_VRSN_CD1 varchar, ICD_DGNS_CD2 varchar, 
ICD_DGNS_VRSN_CD2 varchar, ICD_DGNS_CD3 varchar, ICD_DGNS_VRSN_CD3 varchar, ICD_DGNS_CD4 varchar, ICD_DGNS_VRSN_CD4 varchar, 
ICD_DGNS_CD5 varchar, ICD_DGNS_VRSN_CD5 varchar, ICD_DGNS_CD6 varchar, ICD_DGNS_VRSN_CD6 varchar, ICD_DGNS_CD7 varchar, 
ICD_DGNS_VRSN_CD7 varchar, ICD_DGNS_CD8 varchar, ICD_DGNS_VRSN_CD8 varchar, ICD_DGNS_CD9 varchar, ICD_DGNS_VRSN_CD9 varchar, 
ICD_DGNS_CD10 varchar, ICD_DGNS_VRSN_CD10 varchar, ICD_DGNS_CD11 varchar, ICD_DGNS_VRSN_CD11 varchar, ICD_DGNS_CD12 varchar, 
ICD_DGNS_VRSN_CD12 varchar, RFR_PHYSN_UPIN varchar, RFR_PHYSN_NPI varchar, CLM_CLNCL_TRIL_NUM varchar, DOB_DT varchar, GNDR_CD varchar, 
BENE_RACE_CD varchar, BENE_CNTY_CD varchar, BENE_STATE_CD varchar, BENE_MLG_CNTCT_ZIP_CD varchar, CLM_BENE_PD_AMT varchar, ACO_ID_NUM varchar, 
CLM_BENE_ID_TYPE_CD varchar, CLM_RSDL_PYMT_IND_CD varchar
) 
LOCATION ( 
'gpfdist://greenplum01:8081/uthealth/medicare_national/*/DME_CLAIMS.CSV#transform=add_parentname_filename_comma'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_dme_claims_k
limit 1000;

insert into medicare_national.dme_claims_k (year,
BENE_ID,CLM_ID,NCH_NEAR_LINE_REC_IDENT_CD,NCH_CLM_TYPE_CD,CLM_FROM_DT,CLM_THRU_DT,
NCH_WKLY_PROC_DT,CARR_CLM_ENTRY_CD,CLM_DISP_CD,CARR_NUM,CARR_CLM_PMT_DNL_CD,CLM_PMT_AMT,
CARR_CLM_PRMRY_PYR_PD_AMT,CARR_CLM_PRVDR_ASGNMT_IND_SW,NCH_CLM_PRVDR_PMT_AMT,NCH_CLM_BENE_PMT_AMT,
NCH_CARR_CLM_SBMTD_CHRG_AMT,NCH_CARR_CLM_ALOWD_AMT,CARR_CLM_CASH_DDCTBL_APLD_AMT,CARR_CLM_HCPCS_YR_CD,
PRNCPAL_DGNS_CD,PRNCPAL_DGNS_VRSN_CD,ICD_DGNS_CD1,ICD_DGNS_VRSN_CD1,ICD_DGNS_CD2,
ICD_DGNS_VRSN_CD2,ICD_DGNS_CD3,ICD_DGNS_VRSN_CD3,ICD_DGNS_CD4,ICD_DGNS_VRSN_CD4,
ICD_DGNS_CD5,ICD_DGNS_VRSN_CD5,ICD_DGNS_CD6,ICD_DGNS_VRSN_CD6,ICD_DGNS_CD7,
ICD_DGNS_VRSN_CD7,ICD_DGNS_CD8,ICD_DGNS_VRSN_CD8,ICD_DGNS_CD9,ICD_DGNS_VRSN_CD9,
ICD_DGNS_CD10,ICD_DGNS_VRSN_CD10,ICD_DGNS_CD11,ICD_DGNS_VRSN_CD11,ICD_DGNS_CD12,
ICD_DGNS_VRSN_CD12,RFR_PHYSN_UPIN,RFR_PHYSN_NPI,CLM_CLNCL_TRIL_NUM,DOB_DT,GNDR_CD,
BENE_RACE_CD,BENE_CNTY_CD,BENE_STATE_CD,BENE_MLG_CNTCT_ZIP_CD,CLM_BENE_PD_AMT,ACO_ID_NUM,
CLM_BENE_ID_TYPE_CD,CLM_RSDL_PYMT_IND_CD)
select year,
BENE_ID,CLM_ID,NCH_NEAR_LINE_REC_IDENT_CD,NCH_CLM_TYPE_CD,CLM_FROM_DT,CLM_THRU_DT,
NCH_WKLY_PROC_DT,CARR_CLM_ENTRY_CD,CLM_DISP_CD,CARR_NUM,CARR_CLM_PMT_DNL_CD,CLM_PMT_AMT,
CARR_CLM_PRMRY_PYR_PD_AMT,CARR_CLM_PRVDR_ASGNMT_IND_SW,NCH_CLM_PRVDR_PMT_AMT,NCH_CLM_BENE_PMT_AMT,
NCH_CARR_CLM_SBMTD_CHRG_AMT,NCH_CARR_CLM_ALOWD_AMT,CARR_CLM_CASH_DDCTBL_APLD_AMT,CARR_CLM_HCPCS_YR_CD,
PRNCPAL_DGNS_CD,PRNCPAL_DGNS_VRSN_CD,ICD_DGNS_CD1,ICD_DGNS_VRSN_CD1,ICD_DGNS_CD2,
ICD_DGNS_VRSN_CD2,ICD_DGNS_CD3,ICD_DGNS_VRSN_CD3,ICD_DGNS_CD4,ICD_DGNS_VRSN_CD4,
ICD_DGNS_CD5,ICD_DGNS_VRSN_CD5,ICD_DGNS_CD6,ICD_DGNS_VRSN_CD6,ICD_DGNS_CD7,
ICD_DGNS_VRSN_CD7,ICD_DGNS_CD8,ICD_DGNS_VRSN_CD8,ICD_DGNS_CD9,ICD_DGNS_VRSN_CD9,
ICD_DGNS_CD10,ICD_DGNS_VRSN_CD10,ICD_DGNS_CD11,ICD_DGNS_VRSN_CD11,ICD_DGNS_CD12,
ICD_DGNS_VRSN_CD12,RFR_PHYSN_UPIN,RFR_PHYSN_NPI,CLM_CLNCL_TRIL_NUM,DOB_DT,GNDR_CD,
BENE_RACE_CD,BENE_CNTY_CD,BENE_STATE_CD,BENE_MLG_CNTCT_ZIP_CD,CLM_BENE_PD_AMT,ACO_ID_NUM,
CLM_BENE_ID_TYPE_CD,CLM_RSDL_PYMT_IND_CD
from ext_dme_claims_k;

-- Scratch
select year, count(*)
from uthealth/medicare_national.dme_claims_k
group by 1
order by 1;