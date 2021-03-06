CREATE OR REPLACE VIEW FI_VAT_NO_DED_V AS
SELECT FC.COMMON_ID AS NO_DED_ID
     , FC.GROUP_CODE
     , FC.CODE AS NO_DED_CODE
     , FC.CODE_NAME AS NO_DED_DESC
     , FC.VALUE1 AS NO_DED_TYPE
     , FC.VALUE2
     , FC.VALUE3
     , FC.VALUE4
     , FC.VALUE5
     , FC.VALUE6
     , FC.VALUE7
     , FC.VALUE8
     , FC.VALUE9
     , FC.VALUE10
     , FC.DEFAULT_FLAG
     , FC.SORT_NUM
     , FC.DESCRIPTION
     , FC.ENABLED_FLAG
     , FC.EFFECTIVE_DATE_FR
     , FC.EFFECTIVE_DATE_TO
     , FC.SOB_ID
     , FC.ORG_ID
  FROM FI_COMMON FC
WHERE FC.GROUP_CODE               = 'VAT_NO_DED';
