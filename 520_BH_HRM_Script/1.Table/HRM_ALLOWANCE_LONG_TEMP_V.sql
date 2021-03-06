CREATE OR REPLACE VIEW HRM_ALLOWANCE_LONG_TEMP_V AS
SELECT HC.COMMON_ID AS LONG_ALLOWANCE_ID
     , HC.CODE AS LONG_ALLOWANCE_CODE
     , HC.CODE_NAME AS LONG_ALLOWANCE_NAME
     , TO_NUMBER(HC.VALUE1) AS START_LONG_ALLOWANCE
     , TO_NUMBER(HC.VALUE2) AS END_LONG_ALLOWANCE
     , TO_NUMBER(HC.VALUE3) AS LONG_ALLOWANCE_AMOUNT
     , HC.VALUE4
     , HC.VALUE5
     , HC.VALUE6
     , HC.VALUE7
     , HC.VALUE8
     , HC.VALUE9
     , HC.VALUE10
     , HC.DEFAULT_FLAG
     , HC.SORT_NUM
     , HC.DESCRIPTION
     , HC.ENABLED_FLAG
     , HC.EFFECTIVE_DATE_FR
     , HC.EFFECTIVE_DATE_TO
     , HC.SOB_ID
     , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE              = 'ALLOWANCE_LONG_TEMP';
