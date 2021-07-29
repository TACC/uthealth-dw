drop external table ext_snf_base_claims_k;

CREATE EXTERNAL TABLE ext_snf_base_claims_k (
year text,
BENE_ID varchar, CLM_ID varchar, NCH_NEAR_LINE_REC_IDENT_CD varchar, NCH_CLM_TYPE_CD varchar, CLM_FROM_DT varchar, CLM_THRU_DT varchar, 
NCH_WKLY_PROC_DT varchar, FI_CLM_PROC_DT varchar, CLAIM_QUERY_CODE varchar, PRVDR_NUM varchar, CLM_FAC_TYPE_CD varchar, 
CLM_SRVC_CLSFCTN_TYPE_CD varchar, CLM_FREQ_CD varchar, FI_NUM varchar, CLM_MDCR_NON_PMT_RSN_CD varchar, CLM_PMT_AMT varchar, 
NCH_PRMRY_PYR_CLM_PD_AMT varchar, NCH_PRMRY_PYR_CD varchar, FI_CLM_ACTN_CD varchar, PRVDR_STATE_CD varchar, ORG_NPI_NUM varchar, 
AT_PHYSN_UPIN varchar, AT_PHYSN_NPI varchar, AT_PHYSN_SPCLTY_CD varchar, OP_PHYSN_UPIN varchar, OP_PHYSN_NPI varchar, 
OP_PHYSN_SPCLTY_CD varchar, OT_PHYSN_UPIN varchar, OT_PHYSN_NPI varchar, OT_PHYSN_SPCLTY_CD varchar, RNDRNG_PHYSN_NPI varchar, 
RNDRNG_PHYSN_SPCLTY_CD varchar, CLM_MCO_PD_SW varchar, PTNT_DSCHRG_STUS_CD varchar, CLM_PPS_IND_CD varchar, CLM_TOT_CHRG_AMT varchar, 
CLM_ADMSN_DT varchar, CLM_IP_ADMSN_TYPE_CD varchar, CLM_SRC_IP_ADMSN_CD varchar, NCH_PTNT_STATUS_IND_CD varchar, 
NCH_BENE_IP_DDCTBL_AMT varchar, NCH_BENE_PTA_COINSRNC_LBLTY_AM varchar, NCH_BENE_BLOOD_DDCTBL_LBLTY_AM varchar, 
NCH_IP_NCVRD_CHRG_AMT varchar, NCH_IP_TOT_DDCTN_AMT varchar, CLM_PPS_CPTL_FSP_AMT varchar, CLM_PPS_CPTL_OUTLIER_AMT varchar, 
CLM_PPS_CPTL_DSPRPRTNT_SHR_AMT varchar, CLM_PPS_CPTL_IME_AMT varchar, CLM_PPS_CPTL_EXCPTN_AMT varchar, CLM_PPS_OLD_CPTL_HLD_HRMLS_AMT varchar, 
CLM_UTLZTN_DAY_CNT varchar, BENE_TOT_COINSRNC_DAYS_CNT varchar, CLM_NON_UTLZTN_DAYS_CNT varchar, NCH_BLOOD_PNTS_FRNSHD_QTY varchar, 
NCH_QLFYD_STAY_FROM_DT varchar, NCH_QLFYD_STAY_THRU_DT varchar, NCH_VRFD_NCVRD_STAY_FROM_DT varchar, NCH_VRFD_NCVRD_STAY_THRU_DT varchar, 
NCH_ACTV_OR_CVRD_LVL_CARE_THRU varchar, NCH_BENE_MDCR_BNFTS_EXHTD_DT_I varchar, NCH_BENE_DSCHRG_DT varchar, CLM_DRG_CD varchar, 
ADMTG_DGNS_CD varchar, PRNCPAL_DGNS_CD varchar, ICD_DGNS_CD1 varchar, ICD_DGNS_CD2 varchar, ICD_DGNS_CD3 varchar, ICD_DGNS_CD4 varchar, 
ICD_DGNS_CD5 varchar, ICD_DGNS_CD6 varchar, ICD_DGNS_CD7 varchar, ICD_DGNS_CD8 varchar, ICD_DGNS_CD9 varchar, ICD_DGNS_CD10 varchar, 
ICD_DGNS_CD11 varchar, ICD_DGNS_CD12 varchar, ICD_DGNS_CD13 varchar, ICD_DGNS_CD14 varchar, ICD_DGNS_CD15 varchar, ICD_DGNS_CD16 varchar, 
ICD_DGNS_CD17 varchar, ICD_DGNS_CD18 varchar, ICD_DGNS_CD19 varchar, ICD_DGNS_CD20 varchar, ICD_DGNS_CD21 varchar, ICD_DGNS_CD22 varchar, 
ICD_DGNS_CD23 varchar, ICD_DGNS_CD24 varchar, ICD_DGNS_CD25 varchar, FST_DGNS_E_CD varchar, ICD_DGNS_E_CD1 varchar, ICD_DGNS_E_CD2 varchar, 
ICD_DGNS_E_CD3 varchar, ICD_DGNS_E_CD4 varchar, ICD_DGNS_E_CD5 varchar, ICD_DGNS_E_CD6 varchar, ICD_DGNS_E_CD7 varchar, ICD_DGNS_E_CD8 varchar, 
ICD_DGNS_E_CD9 varchar, ICD_DGNS_E_CD10 varchar, ICD_DGNS_E_CD11 varchar, ICD_DGNS_E_CD12 varchar, ICD_PRCDR_CD1 varchar, PRCDR_DT1 varchar, 
ICD_PRCDR_CD2 varchar, PRCDR_DT2 varchar, ICD_PRCDR_CD3 varchar, PRCDR_DT3 varchar, ICD_PRCDR_CD4 varchar, PRCDR_DT4 varchar, 
ICD_PRCDR_CD5 varchar, PRCDR_DT5 varchar, ICD_PRCDR_CD6 varchar, PRCDR_DT6 varchar, ICD_PRCDR_CD7 varchar, PRCDR_DT7 varchar, 
ICD_PRCDR_CD8 varchar, PRCDR_DT8 varchar, ICD_PRCDR_CD9 varchar, PRCDR_DT9 varchar, ICD_PRCDR_CD10 varchar, PRCDR_DT10 varchar, 
ICD_PRCDR_CD11 varchar, PRCDR_DT11 varchar, ICD_PRCDR_CD12 varchar, PRCDR_DT12 varchar, ICD_PRCDR_CD13 varchar, PRCDR_DT13 varchar, 
ICD_PRCDR_CD14 varchar, PRCDR_DT14 varchar, ICD_PRCDR_CD15 varchar, PRCDR_DT15 varchar, ICD_PRCDR_CD16 varchar, PRCDR_DT16 varchar, 
ICD_PRCDR_CD17 varchar, PRCDR_DT17 varchar, ICD_PRCDR_CD18 varchar, PRCDR_DT18 varchar, ICD_PRCDR_CD19 varchar, PRCDR_DT19 varchar, 
ICD_PRCDR_CD20 varchar, PRCDR_DT20 varchar, ICD_PRCDR_CD21 varchar, PRCDR_DT21 varchar, ICD_PRCDR_CD22 varchar, PRCDR_DT22 varchar, 
ICD_PRCDR_CD23 varchar, PRCDR_DT23 varchar, ICD_PRCDR_CD24 varchar, PRCDR_DT24 varchar, ICD_PRCDR_CD25 varchar, PRCDR_DT25 varchar, 
DOB_DT varchar, GNDR_CD varchar, BENE_RACE_CD varchar, BENE_CNTY_CD varchar, BENE_STATE_CD varchar, BENE_MLG_CNTCT_dod_CD varchar, 
CLM_MDCL_REC varchar, CLM_TRTMT_AUTHRZTN_NUM varchar, CLM_PRCR_RTRN_CD varchar, CLM_SRVC_FAC_dod_CD varchar, 
NCH_PROFNL_CMPNT_CHRG_AMT varchar, CLM_NEXT_GNRTN_ACO_IND_CD1 varchar, CLM_NEXT_GNRTN_ACO_IND_CD2 varchar, CLM_NEXT_GNRTN_ACO_IND_CD3 varchar, 
CLM_NEXT_GNRTN_ACO_IND_CD4 varchar, CLM_NEXT_GNRTN_ACO_IND_CD5 varchar, ACO_ID_NUM varchar, CLM_BENE_ID_TYPE_CD varchar
) 
LOCATION ( 
'gpfdist://192.168.58.179:8081/medicare_texas/*/*snf_base_claims_k.csv.gz#transform=add_parentname_filename_comma'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_snf_base_claims_k
limit 1000;

create table medicare_texas.snf_base_claims_k
WITH (appendonly=true, orientation=column, compresstype=zlib)
as
--insert into medicare_texas.snf_base_claims_k 
select * 
from ext_snf_base_claims_k
distributed randomly;

-- 2018+
-- New Cols: CLM_RSDL_PYMT_IND_CD,PRVDR_VLDTN_TYPE_CD,RR_BRD_EXCLSN_IND_SW,CLM_MODEL_REIMBRSMT_AMT

alter table medicare_texas.snf_base_claims_k add column CLM_RSDL_PYMT_IND_CD varchar;
alter table medicare_texas.snf_base_claims_k add column PRVDR_VLDTN_TYPE_CD varchar;
alter table medicare_texas.snf_base_claims_k add column RR_BRD_EXCLSN_IND_SW varchar;
alter table medicare_texas.snf_base_claims_k add column CLM_MODEL_REIMBRSMT_AMT varchar;

drop external table ext_snf_base_claims_k;

CREATE EXTERNAL TABLE ext_snf_base_claims_k (
year text, filename text,
BENE_ID varchar, CLM_ID varchar, NCH_NEAR_LINE_REC_IDENT_CD varchar, NCH_CLM_TYPE_CD varchar, CLM_FROM_DT varchar, CLM_THRU_DT varchar, 
NCH_WKLY_PROC_DT varchar, FI_CLM_PROC_DT varchar, CLAIM_QUERY_CODE varchar, PRVDR_NUM varchar, CLM_FAC_TYPE_CD varchar, 
CLM_SRVC_CLSFCTN_TYPE_CD varchar, CLM_FREQ_CD varchar, FI_NUM varchar, CLM_MDCR_NON_PMT_RSN_CD varchar, CLM_PMT_AMT varchar, 
NCH_PRMRY_PYR_CLM_PD_AMT varchar, NCH_PRMRY_PYR_CD varchar, FI_CLM_ACTN_CD varchar, PRVDR_STATE_CD varchar, ORG_NPI_NUM varchar, 
AT_PHYSN_UPIN varchar, AT_PHYSN_NPI varchar, AT_PHYSN_SPCLTY_CD varchar, OP_PHYSN_UPIN varchar, OP_PHYSN_NPI varchar, 
OP_PHYSN_SPCLTY_CD varchar, OT_PHYSN_UPIN varchar, OT_PHYSN_NPI varchar, OT_PHYSN_SPCLTY_CD varchar, RNDRNG_PHYSN_NPI varchar, 
RNDRNG_PHYSN_SPCLTY_CD varchar, CLM_MCO_PD_SW varchar, PTNT_DSCHRG_STUS_CD varchar, CLM_PPS_IND_CD varchar, CLM_TOT_CHRG_AMT varchar, 
CLM_ADMSN_DT varchar, CLM_IP_ADMSN_TYPE_CD varchar, CLM_SRC_IP_ADMSN_CD varchar, NCH_PTNT_STATUS_IND_CD varchar, 
NCH_BENE_IP_DDCTBL_AMT varchar, NCH_BENE_PTA_COINSRNC_LBLTY_AM varchar, NCH_BENE_BLOOD_DDCTBL_LBLTY_AM varchar, 
NCH_IP_NCVRD_CHRG_AMT varchar, NCH_IP_TOT_DDCTN_AMT varchar, CLM_PPS_CPTL_FSP_AMT varchar, CLM_PPS_CPTL_OUTLIER_AMT varchar, 
CLM_PPS_CPTL_DSPRPRTNT_SHR_AMT varchar, CLM_PPS_CPTL_IME_AMT varchar, CLM_PPS_CPTL_EXCPTN_AMT varchar, CLM_PPS_OLD_CPTL_HLD_HRMLS_AMT varchar, 
CLM_UTLZTN_DAY_CNT varchar, BENE_TOT_COINSRNC_DAYS_CNT varchar, CLM_NON_UTLZTN_DAYS_CNT varchar, NCH_BLOOD_PNTS_FRNSHD_QTY varchar, 
NCH_QLFYD_STAY_FROM_DT varchar, NCH_QLFYD_STAY_THRU_DT varchar, NCH_VRFD_NCVRD_STAY_FROM_DT varchar, NCH_VRFD_NCVRD_STAY_THRU_DT varchar, 
NCH_ACTV_OR_CVRD_LVL_CARE_THRU varchar, NCH_BENE_MDCR_BNFTS_EXHTD_DT_I varchar, NCH_BENE_DSCHRG_DT varchar, CLM_DRG_CD varchar, 
ADMTG_DGNS_CD varchar, PRNCPAL_DGNS_CD varchar, ICD_DGNS_CD1 varchar, ICD_DGNS_CD2 varchar, ICD_DGNS_CD3 varchar, ICD_DGNS_CD4 varchar, 
ICD_DGNS_CD5 varchar, ICD_DGNS_CD6 varchar, ICD_DGNS_CD7 varchar, ICD_DGNS_CD8 varchar, ICD_DGNS_CD9 varchar, ICD_DGNS_CD10 varchar, 
ICD_DGNS_CD11 varchar, ICD_DGNS_CD12 varchar, ICD_DGNS_CD13 varchar, ICD_DGNS_CD14 varchar, ICD_DGNS_CD15 varchar, ICD_DGNS_CD16 varchar, 
ICD_DGNS_CD17 varchar, ICD_DGNS_CD18 varchar, ICD_DGNS_CD19 varchar, ICD_DGNS_CD20 varchar, ICD_DGNS_CD21 varchar, ICD_DGNS_CD22 varchar, 
ICD_DGNS_CD23 varchar, ICD_DGNS_CD24 varchar, ICD_DGNS_CD25 varchar, FST_DGNS_E_CD varchar, ICD_DGNS_E_CD1 varchar, ICD_DGNS_E_CD2 varchar, 
ICD_DGNS_E_CD3 varchar, ICD_DGNS_E_CD4 varchar, ICD_DGNS_E_CD5 varchar, ICD_DGNS_E_CD6 varchar, ICD_DGNS_E_CD7 varchar, ICD_DGNS_E_CD8 varchar, 
ICD_DGNS_E_CD9 varchar, ICD_DGNS_E_CD10 varchar, ICD_DGNS_E_CD11 varchar, ICD_DGNS_E_CD12 varchar, ICD_PRCDR_CD1 varchar, PRCDR_DT1 varchar, 
ICD_PRCDR_CD2 varchar, PRCDR_DT2 varchar, ICD_PRCDR_CD3 varchar, PRCDR_DT3 varchar, ICD_PRCDR_CD4 varchar, PRCDR_DT4 varchar, 
ICD_PRCDR_CD5 varchar, PRCDR_DT5 varchar, ICD_PRCDR_CD6 varchar, PRCDR_DT6 varchar, ICD_PRCDR_CD7 varchar, PRCDR_DT7 varchar, 
ICD_PRCDR_CD8 varchar, PRCDR_DT8 varchar, ICD_PRCDR_CD9 varchar, PRCDR_DT9 varchar, ICD_PRCDR_CD10 varchar, PRCDR_DT10 varchar, 
ICD_PRCDR_CD11 varchar, PRCDR_DT11 varchar, ICD_PRCDR_CD12 varchar, PRCDR_DT12 varchar, ICD_PRCDR_CD13 varchar, PRCDR_DT13 varchar, 
ICD_PRCDR_CD14 varchar, PRCDR_DT14 varchar, ICD_PRCDR_CD15 varchar, PRCDR_DT15 varchar, ICD_PRCDR_CD16 varchar, PRCDR_DT16 varchar, 
ICD_PRCDR_CD17 varchar, PRCDR_DT17 varchar, ICD_PRCDR_CD18 varchar, PRCDR_DT18 varchar, ICD_PRCDR_CD19 varchar, PRCDR_DT19 varchar, 
ICD_PRCDR_CD20 varchar, PRCDR_DT20 varchar, ICD_PRCDR_CD21 varchar, PRCDR_DT21 varchar, ICD_PRCDR_CD22 varchar, PRCDR_DT22 varchar, 
ICD_PRCDR_CD23 varchar, PRCDR_DT23 varchar, ICD_PRCDR_CD24 varchar, PRCDR_DT24 varchar, ICD_PRCDR_CD25 varchar, PRCDR_DT25 varchar, 
DOB_DT varchar, GNDR_CD varchar, BENE_RACE_CD varchar, BENE_CNTY_CD varchar, BENE_STATE_CD varchar, BENE_MLG_CNTCT_dod_CD varchar, 
CLM_MDCL_REC varchar, CLM_TRTMT_AUTHRZTN_NUM varchar, CLM_PRCR_RTRN_CD varchar, CLM_SRVC_FAC_dod_CD varchar, 
NCH_PROFNL_CMPNT_CHRG_AMT varchar, CLM_NEXT_GNRTN_ACO_IND_CD1 varchar, CLM_NEXT_GNRTN_ACO_IND_CD2 varchar, CLM_NEXT_GNRTN_ACO_IND_CD3 varchar, 
CLM_NEXT_GNRTN_ACO_IND_CD4 varchar, CLM_NEXT_GNRTN_ACO_IND_CD5 varchar, ACO_ID_NUM varchar, CLM_BENE_ID_TYPE_CD varchar,
CLM_RSDL_PYMT_IND_CD varchar, PRVDR_VLDTN_TYPE_CD varchar, RR_BRD_EXCLSN_IND_SW varchar, CLM_MODEL_REIMBRSMT_AMT varchar
) 
LOCATION ( 
'gpfdist://192.168.58.179:8081/medicare_texas/*/*snf_base_claims_k.csv.gz#transform=add_parentname_filename_comma'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );

select *
from ext_snf_base_claims_k
limit 1000;

insert into medicare_texas.snf_base_claims_k (year,
BENE_ID, CLM_ID, NCH_NEAR_LINE_REC_IDENT_CD, NCH_CLM_TYPE_CD, CLM_FROM_DT, CLM_THRU_DT, 
NCH_WKLY_PROC_DT, FI_CLM_PROC_DT, CLAIM_QUERY_CODE, PRVDR_NUM, CLM_FAC_TYPE_CD, 
CLM_SRVC_CLSFCTN_TYPE_CD, CLM_FREQ_CD, FI_NUM, CLM_MDCR_NON_PMT_RSN_CD, CLM_PMT_AMT, 
NCH_PRMRY_PYR_CLM_PD_AMT, NCH_PRMRY_PYR_CD, FI_CLM_ACTN_CD, PRVDR_STATE_CD, ORG_NPI_NUM, 
AT_PHYSN_UPIN, AT_PHYSN_NPI, AT_PHYSN_SPCLTY_CD, OP_PHYSN_UPIN, OP_PHYSN_NPI, 
OP_PHYSN_SPCLTY_CD, OT_PHYSN_UPIN, OT_PHYSN_NPI, OT_PHYSN_SPCLTY_CD, RNDRNG_PHYSN_NPI, 
RNDRNG_PHYSN_SPCLTY_CD, CLM_MCO_PD_SW, PTNT_DSCHRG_STUS_CD, CLM_PPS_IND_CD, CLM_TOT_CHRG_AMT, 
CLM_ADMSN_DT, CLM_IP_ADMSN_TYPE_CD, CLM_SRC_IP_ADMSN_CD, NCH_PTNT_STATUS_IND_CD, 
NCH_BENE_IP_DDCTBL_AMT, NCH_BENE_PTA_COINSRNC_LBLTY_AM, NCH_BENE_BLOOD_DDCTBL_LBLTY_AM, 
NCH_IP_NCVRD_CHRG_AMT, NCH_IP_TOT_DDCTN_AMT, CLM_PPS_CPTL_FSP_AMT, CLM_PPS_CPTL_OUTLIER_AMT, 
CLM_PPS_CPTL_DSPRPRTNT_SHR_AMT, CLM_PPS_CPTL_IME_AMT, CLM_PPS_CPTL_EXCPTN_AMT, CLM_PPS_OLD_CPTL_HLD_HRMLS_AMT, 
CLM_UTLZTN_DAY_CNT, BENE_TOT_COINSRNC_DAYS_CNT, CLM_NON_UTLZTN_DAYS_CNT, NCH_BLOOD_PNTS_FRNSHD_QTY, 
NCH_QLFYD_STAY_FROM_DT, NCH_QLFYD_STAY_THRU_DT, NCH_VRFD_NCVRD_STAY_FROM_DT, NCH_VRFD_NCVRD_STAY_THRU_DT, 
NCH_ACTV_OR_CVRD_LVL_CARE_THRU, NCH_BENE_MDCR_BNFTS_EXHTD_DT_I, NCH_BENE_DSCHRG_DT, CLM_DRG_CD, 
ADMTG_DGNS_CD, PRNCPAL_DGNS_CD, ICD_DGNS_CD1, ICD_DGNS_CD2, ICD_DGNS_CD3, ICD_DGNS_CD4, 
ICD_DGNS_CD5, ICD_DGNS_CD6, ICD_DGNS_CD7, ICD_DGNS_CD8, ICD_DGNS_CD9, ICD_DGNS_CD10, 
ICD_DGNS_CD11, ICD_DGNS_CD12, ICD_DGNS_CD13, ICD_DGNS_CD14, ICD_DGNS_CD15, ICD_DGNS_CD16, 
ICD_DGNS_CD17, ICD_DGNS_CD18, ICD_DGNS_CD19, ICD_DGNS_CD20, ICD_DGNS_CD21, ICD_DGNS_CD22, 
ICD_DGNS_CD23, ICD_DGNS_CD24, ICD_DGNS_CD25, FST_DGNS_E_CD, ICD_DGNS_E_CD1, ICD_DGNS_E_CD2, 
ICD_DGNS_E_CD3, ICD_DGNS_E_CD4, ICD_DGNS_E_CD5, ICD_DGNS_E_CD6, ICD_DGNS_E_CD7, ICD_DGNS_E_CD8, 
ICD_DGNS_E_CD9, ICD_DGNS_E_CD10, ICD_DGNS_E_CD11, ICD_DGNS_E_CD12, ICD_PRCDR_CD1, PRCDR_DT1, 
ICD_PRCDR_CD2, PRCDR_DT2, ICD_PRCDR_CD3, PRCDR_DT3, ICD_PRCDR_CD4, PRCDR_DT4, 
ICD_PRCDR_CD5, PRCDR_DT5, ICD_PRCDR_CD6, PRCDR_DT6, ICD_PRCDR_CD7, PRCDR_DT7, 
ICD_PRCDR_CD8, PRCDR_DT8, ICD_PRCDR_CD9, PRCDR_DT9, ICD_PRCDR_CD10, PRCDR_DT10, 
ICD_PRCDR_CD11, PRCDR_DT11, ICD_PRCDR_CD12, PRCDR_DT12, ICD_PRCDR_CD13, PRCDR_DT13, 
ICD_PRCDR_CD14, PRCDR_DT14, ICD_PRCDR_CD15, PRCDR_DT15, ICD_PRCDR_CD16, PRCDR_DT16, 
ICD_PRCDR_CD17, PRCDR_DT17, ICD_PRCDR_CD18, PRCDR_DT18, ICD_PRCDR_CD19, PRCDR_DT19, 
ICD_PRCDR_CD20, PRCDR_DT20, ICD_PRCDR_CD21, PRCDR_DT21, ICD_PRCDR_CD22, PRCDR_DT22, 
ICD_PRCDR_CD23, PRCDR_DT23, ICD_PRCDR_CD24, PRCDR_DT24, ICD_PRCDR_CD25, PRCDR_DT25, 
DOB_DT, GNDR_CD, BENE_RACE_CD, BENE_CNTY_CD, BENE_STATE_CD, BENE_MLG_CNTCT_dod_CD, 
CLM_MDCL_REC, CLM_TRTMT_AUTHRZTN_NUM, CLM_PRCR_RTRN_CD, CLM_SRVC_FAC_dod_CD, 
NCH_PROFNL_CMPNT_CHRG_AMT, CLM_NEXT_GNRTN_ACO_IND_CD1, CLM_NEXT_GNRTN_ACO_IND_CD2, CLM_NEXT_GNRTN_ACO_IND_CD3, 
CLM_NEXT_GNRTN_ACO_IND_CD4, CLM_NEXT_GNRTN_ACO_IND_CD5, ACO_ID_NUM, CLM_BENE_ID_TYPE_CD,
CLM_RSDL_PYMT_IND_CD, PRVDR_VLDTN_TYPE_CD, RR_BRD_EXCLSN_IND_SW, CLM_MODEL_REIMBRSMT_AMT
)
select year,
BENE_ID, CLM_ID, NCH_NEAR_LINE_REC_IDENT_CD, NCH_CLM_TYPE_CD, CLM_FROM_DT, CLM_THRU_DT, 
NCH_WKLY_PROC_DT, FI_CLM_PROC_DT, CLAIM_QUERY_CODE, PRVDR_NUM, CLM_FAC_TYPE_CD, 
CLM_SRVC_CLSFCTN_TYPE_CD, CLM_FREQ_CD, FI_NUM, CLM_MDCR_NON_PMT_RSN_CD, CLM_PMT_AMT, 
NCH_PRMRY_PYR_CLM_PD_AMT, NCH_PRMRY_PYR_CD, FI_CLM_ACTN_CD, PRVDR_STATE_CD, ORG_NPI_NUM, 
AT_PHYSN_UPIN, AT_PHYSN_NPI, AT_PHYSN_SPCLTY_CD, OP_PHYSN_UPIN, OP_PHYSN_NPI, 
OP_PHYSN_SPCLTY_CD, OT_PHYSN_UPIN, OT_PHYSN_NPI, OT_PHYSN_SPCLTY_CD, RNDRNG_PHYSN_NPI, 
RNDRNG_PHYSN_SPCLTY_CD, CLM_MCO_PD_SW, PTNT_DSCHRG_STUS_CD, CLM_PPS_IND_CD, CLM_TOT_CHRG_AMT, 
CLM_ADMSN_DT, CLM_IP_ADMSN_TYPE_CD, CLM_SRC_IP_ADMSN_CD, NCH_PTNT_STATUS_IND_CD, 
NCH_BENE_IP_DDCTBL_AMT, NCH_BENE_PTA_COINSRNC_LBLTY_AM, NCH_BENE_BLOOD_DDCTBL_LBLTY_AM, 
NCH_IP_NCVRD_CHRG_AMT, NCH_IP_TOT_DDCTN_AMT, CLM_PPS_CPTL_FSP_AMT, CLM_PPS_CPTL_OUTLIER_AMT, 
CLM_PPS_CPTL_DSPRPRTNT_SHR_AMT, CLM_PPS_CPTL_IME_AMT, CLM_PPS_CPTL_EXCPTN_AMT, CLM_PPS_OLD_CPTL_HLD_HRMLS_AMT, 
CLM_UTLZTN_DAY_CNT, BENE_TOT_COINSRNC_DAYS_CNT, CLM_NON_UTLZTN_DAYS_CNT, NCH_BLOOD_PNTS_FRNSHD_QTY, 
NCH_QLFYD_STAY_FROM_DT, NCH_QLFYD_STAY_THRU_DT, NCH_VRFD_NCVRD_STAY_FROM_DT, NCH_VRFD_NCVRD_STAY_THRU_DT, 
NCH_ACTV_OR_CVRD_LVL_CARE_THRU, NCH_BENE_MDCR_BNFTS_EXHTD_DT_I, NCH_BENE_DSCHRG_DT, CLM_DRG_CD, 
ADMTG_DGNS_CD, PRNCPAL_DGNS_CD, ICD_DGNS_CD1, ICD_DGNS_CD2, ICD_DGNS_CD3, ICD_DGNS_CD4, 
ICD_DGNS_CD5, ICD_DGNS_CD6, ICD_DGNS_CD7, ICD_DGNS_CD8, ICD_DGNS_CD9, ICD_DGNS_CD10, 
ICD_DGNS_CD11, ICD_DGNS_CD12, ICD_DGNS_CD13, ICD_DGNS_CD14, ICD_DGNS_CD15, ICD_DGNS_CD16, 
ICD_DGNS_CD17, ICD_DGNS_CD18, ICD_DGNS_CD19, ICD_DGNS_CD20, ICD_DGNS_CD21, ICD_DGNS_CD22, 
ICD_DGNS_CD23, ICD_DGNS_CD24, ICD_DGNS_CD25, FST_DGNS_E_CD, ICD_DGNS_E_CD1, ICD_DGNS_E_CD2, 
ICD_DGNS_E_CD3, ICD_DGNS_E_CD4, ICD_DGNS_E_CD5, ICD_DGNS_E_CD6, ICD_DGNS_E_CD7, ICD_DGNS_E_CD8, 
ICD_DGNS_E_CD9, ICD_DGNS_E_CD10, ICD_DGNS_E_CD11, ICD_DGNS_E_CD12, ICD_PRCDR_CD1, PRCDR_DT1, 
ICD_PRCDR_CD2, PRCDR_DT2, ICD_PRCDR_CD3, PRCDR_DT3, ICD_PRCDR_CD4, PRCDR_DT4, 
ICD_PRCDR_CD5, PRCDR_DT5, ICD_PRCDR_CD6, PRCDR_DT6, ICD_PRCDR_CD7, PRCDR_DT7, 
ICD_PRCDR_CD8, PRCDR_DT8, ICD_PRCDR_CD9, PRCDR_DT9, ICD_PRCDR_CD10, PRCDR_DT10, 
ICD_PRCDR_CD11, PRCDR_DT11, ICD_PRCDR_CD12, PRCDR_DT12, ICD_PRCDR_CD13, PRCDR_DT13, 
ICD_PRCDR_CD14, PRCDR_DT14, ICD_PRCDR_CD15, PRCDR_DT15, ICD_PRCDR_CD16, PRCDR_DT16, 
ICD_PRCDR_CD17, PRCDR_DT17, ICD_PRCDR_CD18, PRCDR_DT18, ICD_PRCDR_CD19, PRCDR_DT19, 
ICD_PRCDR_CD20, PRCDR_DT20, ICD_PRCDR_CD21, PRCDR_DT21, ICD_PRCDR_CD22, PRCDR_DT22, 
ICD_PRCDR_CD23, PRCDR_DT23, ICD_PRCDR_CD24, PRCDR_DT24, ICD_PRCDR_CD25, PRCDR_DT25, 
DOB_DT, GNDR_CD, BENE_RACE_CD, BENE_CNTY_CD, BENE_STATE_CD, BENE_MLG_CNTCT_dod_CD, 
CLM_MDCL_REC, CLM_TRTMT_AUTHRZTN_NUM, CLM_PRCR_RTRN_CD, CLM_SRVC_FAC_dod_CD, 
NCH_PROFNL_CMPNT_CHRG_AMT, CLM_NEXT_GNRTN_ACO_IND_CD1, CLM_NEXT_GNRTN_ACO_IND_CD2, CLM_NEXT_GNRTN_ACO_IND_CD3, 
CLM_NEXT_GNRTN_ACO_IND_CD4, CLM_NEXT_GNRTN_ACO_IND_CD5, ACO_ID_NUM, CLM_BENE_ID_TYPE_CD,
CLM_RSDL_PYMT_IND_CD, PRVDR_VLDTN_TYPE_CD, RR_BRD_EXCLSN_IND_SW, CLM_MODEL_REIMBRSMT_AMT
from ext_snf_base_claims_k;

-- Scratch
select year, count(*)
from medicare_texas.snf_base_claims_k
group by 1
order by 1;