CREATE OR REPLACE VIEW HRM_ALLOWANCE_TYPE_V AS
SELECT HC.COMMON_ID AS ALLOWANCE_TYPE_ID
     , HC.CODE AS ALLOWANCE_TYPE
     , HC.CODE_NAME AS ALLOWANCE_TYPE_NAME
     , HC.VALUE1 AS FULL_ALLOWANCE_TYPE
     , HC.DEFAULT_FLAG
     , HC.SORT_NUM
     , HC.DESCRIPTION
     , HC.ENABLED_FLAG
     , HC.EFFECTIVE_DATE_FR
     , HC.EFFECTIVE_DATE_TO
     , HC.SOB_ID
     , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE              = 'ALLOWANCE_TYPE';
