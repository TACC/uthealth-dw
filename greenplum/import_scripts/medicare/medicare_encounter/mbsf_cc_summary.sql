drop table if exists medicare_national.mbsf_cc_summary;

create table medicare_national.mbsf_cc_summary
(
	year text,
	BENE_ID varchar,
	BENE_ENROLLMT_REF_YR varchar,
	ENRL_SRC varchar,
	AMI varchar,
	AMI_MID varchar,
	AMI_EVER varchar,
	ALZH varchar,
	ALZH_MID varchar,
	ALZH_EVER varchar,
	ALZH_DEMEN varchar,
	ALZH_DEMEN_MID varchar,
	ALZH_DEMEN_EVER varchar,
	ATRIAL_FIB varchar,
	ATRIAL_FIB_MID varchar,
	ATRIAL_FIB_EVER varchar,
	CATARACT varchar,
	CATARACT_MID varchar,
	CATARACT_EVER varchar,
	CHRONICKIDNEY varchar,
	CHRONICKIDNEY_MID varchar,
	CHRONICKIDNEY_EVER varchar,
	COPD varchar,
	COPD_MID varchar,
	COPD_EVER varchar,
	CHF varchar,
	CHF_MID varchar,
	CHF_EVER varchar,
	DIABETES varchar,
	DIABETES_MID varchar,
	DIABETES_EVER varchar,
	GLAUCOMA varchar,
	GLAUCOMA_MID varchar,
	GLAUCOMA_EVER varchar,
	HIP_FRACTURE varchar,
	HIP_FRACTURE_MID varchar,
	HIP_FRACTURE_EVER varchar,
	ISCHEMICHEART varchar,
	ISCHEMICHEART_MID varchar,
	ISCHEMICHEART_EVER varchar,
	DEPRESSION varchar,
	DEPRESSION_MID varchar,
	DEPRESSION_EVER varchar,
	OSTEOPOROSIS varchar,
	OSTEOPOROSIS_MID varchar,
	OSTEOPOROSIS_EVER varchar,
	RA_OA varchar,
	RA_OA_MID varchar,
	RA_OA_EVER varchar,
	STROKE_TIA varchar,
	STROKE_TIA_MID varchar,
	STROKE_TIA_EVER varchar,
	CANCER_BREAST varchar,
	CANCER_BREAST_MID varchar,
	CANCER_BREAST_EVER varchar,
	CANCER_COLORECTAL varchar,
	CANCER_COLORECTAL_MID varchar,
	CANCER_COLORECTAL_EVER varchar,
	CANCER_PROSTATE varchar,
	CANCER_PROSTATE_MID varchar,
	CANCER_PROSTATE_EVER varchar,
	CANCER_LUNG varchar,
	CANCER_LUNG_MID varchar,
	CANCER_LUNG_EVER varchar,
	CANCER_ENDOMETRIAL varchar,
	CANCER_ENDOMETRIAL_MID varchar,
	CANCER_ENDOMETRIAL_EVER varchar,
	ANEMIA varchar,
	ANEMIA_MID varchar,
	ANEMIA_EVER varchar,
	ASTHMA varchar,
	ASTHMA_MID varchar,
	ASTHMA_EVER varchar,
	HYPERL varchar,
	HYPERL_MID varchar,
	HYPERL_EVER varchar,
	HYPERP varchar,
	HYPERP_MID varchar,
	HYPERP_EVER varchar,
	HYPERT varchar,
	HYPERT_MID varchar,
	HYPERT_EVER varchar,
	HYPOTH varchar,
	HYPOTH_MID varchar,
	HYPOTH_EVER varchar
)
with(
    appendonly = true,
    orientation = column,
    compresstype = zlib
)
distributed by (BENE_ID);