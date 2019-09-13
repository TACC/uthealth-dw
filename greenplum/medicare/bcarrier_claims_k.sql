/*
BENE_ID,CLM_ID,NCH_NEAR_LINE_REC_IDENT_CD,NCH_CLM_TYPE_CD,CLM_FROM_DT,CLM_THRU_DT,NCH_WKLY_PROC_DT,
CARR_CLM_ENTRY_CD,CLM_DISP_CD,CARR_NUM,CARR_CLM_PMT_DNL_CD,CLM_PMT_AMT,CARR_CLM_PRMRY_PYR_PD_AMT,
RFR_PHYSN_UPIN,RFR_PHYSN_NPI,CARR_CLM_PRVDR_ASGNMT_IND_SW,NCH_CLM_PRVDR_PMT_AMT,NCH_CLM_BENE_PMT_AMT,
NCH_CARR_CLM_SBMTD_CHRG_AMT,NCH_CARR_CLM_ALOWD_AMT,CARR_CLM_CASH_DDCTBL_APLD_AMT,
CARR_CLM_HCPCS_YR_CD,CARR_CLM_RFRNG_PIN_NUM,PRNCPAL_DGNS_CD,PRNCPAL_DGNS_VRSN_CD,
ICD_DGNS_CD1,ICD_DGNS_VRSN_CD1,
ICD_DGNS_CD2,ICD_DGNS_VRSN_CD2,
ICD_DGNS_CD3,ICD_DGNS_VRSN_CD3,
ICD_DGNS_CD4,ICD_DGNS_VRSN_CD4,
ICD_DGNS_CD5,ICD_DGNS_VRSN_CD5,
ICD_DGNS_CD6,ICD_DGNS_VRSN_CD6,
ICD_DGNS_CD7,ICD_DGNS_VRSN_CD7,
ICD_DGNS_CD8,ICD_DGNS_VRSN_CD8,
ICD_DGNS_CD9,ICD_DGNS_VRSN_CD9,
ICD_DGNS_CD10,ICD_DGNS_VRSN_CD10,
ICD_DGNS_CD11,ICD_DGNS_VRSN_CD11,
ICD_DGNS_CD12,ICD_DGNS_VRSN_CD12,
CLM_CLNCL_TRIL_NUM,DOB_DT,GNDR_CD,BENE_RACE_CD,BENE_CNTY_CD,BENE_STATE_CD,BENE_MLG_CNTCT_ZIP_CD,
CLM_BENE_PD_AMT,CPO_PRVDR_NUM,CPO_ORG_NPI_NUM,CARR_CLM_BLG_NPI_NUM,ACO_ID_NUM,CARR_CLM_SOS_NPI_NUM,CLM_BENE_ID_TYPE_CD

gggggggngjfnyfn,ggggBjjwwwgyuBu,O,71,2016-08-18,2016-08-18,2016-09-02,
1,01,04412,1,7.35,0.0,
,1972814648,A,7.35,0.0,
35.0,9.37,0.0,6,
424091YL0V,M25561,0,
M25561,0,
,,
,,
,,
,,
,,
,,
,,
,,
,,
,,
,,
00000000,1931-03-18,2,1,113,45,781020000,
0.0,,,1184669897,,,
*/
drop external table ext_ccaef_v1;
CREATE EXTERNAL TABLE ext_ccaef_v1 (
BENE_ID,
CLM_ID,
NCH_NEAR_LINE_REC_IDENT_CD,
NCH_CLM_TYPE_CD,
CLM_FROM_DT,
CLM_THRU_DT,
NCH_WKLY_PROC_DT,
CARR_CLM_ENTRY_CD,
CLM_DISP_CD,
CARR_NUM,
CARR_CLM_PMT_DNL_CD,
CLM_PMT_AMT,
CARR_CLM_PRMRY_PYR_PD_AMT,
RFR_PHYSN_UPIN,
RFR_PHYSN_NPI,
CARR_CLM_PRVDR_ASGNMT_IND_SW,
NCH_CLM_PRVDR_PMT_AMT,
NCH_CLM_BENE_PMT_AMT,
NCH_CARR_CLM_SBMTD_CHRG_AMT,
NCH_CARR_CLM_ALOWD_AMT,
CARR_CLM_CASH_DDCTBL_APLD_AMT,
CARR_CLM_HCPCS_YR_CD,
CARR_CLM_RFRNG_PIN_NUM,
PRNCPAL_DGNS_CD,
PRNCPAL_DGNS_VRSN_CD,
ICD_DGNS_CD1,ICD_DGNS_VRSN_CD1,
ICD_DGNS_CD2,ICD_DGNS_VRSN_CD2,
ICD_DGNS_CD3,ICD_DGNS_VRSN_CD3,
ICD_DGNS_CD4,ICD_DGNS_VRSN_CD4,
ICD_DGNS_CD5,ICD_DGNS_VRSN_CD5,
ICD_DGNS_CD6,ICD_DGNS_VRSN_CD6,
ICD_DGNS_CD7,ICD_DGNS_VRSN_CD7,
ICD_DGNS_CD8,ICD_DGNS_VRSN_CD8,
ICD_DGNS_CD9,ICD_DGNS_VRSN_CD9,
ICD_DGNS_CD10,ICD_DGNS_VRSN_CD10,
ICD_DGNS_CD11,ICD_DGNS_VRSN_CD11,
ICD_DGNS_CD12,ICD_DGNS_VRSN_CD12,
CLM_CLNCL_TRIL_NUM,
DOB_DT,
GNDR_CD,
BENE_RACE_CD,
BENE_CNTY_CD,
BENE_STATE_CD,
BENE_MLG_CNTCT_ZIP_CD,
CLM_BENE_PD_AMT,
CPO_PRVDR_NUM,
CPO_ORG_NPI_NUM,
CARR_CLM_BLG_NPI_NUM,
ACO_ID_NUM,
CARR_CLM_SOS_NPI_NUM,
CLM_BENE_ID_TYPE_CD
) 
LOCATION ( 
'gpfdist://c252-140:8801/*'
)
FORMAT 'CSV' ( HEADER DELIMITER ',' );