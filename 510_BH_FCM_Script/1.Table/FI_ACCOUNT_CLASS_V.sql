CREATE OR REPLACE VIEW FI_ACCOUNT_CLASS_V AS
SELECT FC.COMMON_ID AS ACCOUNT_CLASS_ID
     , FC.GROUP_CODE
     , FC.CODE AS ACCOUNT_CLASS_CODE
     , FC.CODE_NAME AS ACCOUNT_CLASS_NAME
     , NVL(FC.VALUE1, 'N') AS DR_VALUE
     , NVL(FC.VALUE2, 'N') AS CR_VALUE
     , FC.VALUE3 AS ACCOUNT_CLASS_TYPE
     , NVL(FC.VALUE4, 'N') AS UNLIQUIDATE_YN
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
  FROM FI_COMMON_TLV FC
 WHERE FC.GROUP_CODE              = 'ACCOUNT_CLASS';
