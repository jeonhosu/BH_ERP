CREATE OR REPLACE VIEW HRM_ALLOWANCE_ETC_V AS
SELECT HC.COMMON_ID AS ALLOWANCE_ETC_ID
     , HC.CODE AS ALLOWANCE_ETC
     , HC.CODE_NAME AS ALLOWANCE_ETC_NAME
     , HC.VALUE1 AS ALLOWANCE_CODE
     , HC.VALUE2 AS ALLOWANCE_CLASS     
     , HC.VALUE3 AS FORMULA1
     , HC.VALUE4 AS FORMULA2
     , HC.VALUE5 AS FORMULA3
     , HC.VALUE6 AS FORMULA4
     , HC.VALUE7 AS FORMULA5
     , HC.VALUE8 AS FORMULA6
     , HC.VALUE9 AS FORMULA7
     , HC.VALUE10 AS FORMULA8
     , HC.DEFAULT_FLAG
     , HC.SORT_NUM
     , HC.DESCRIPTION
     , HC.ENABLED_FLAG
     , HC.EFFECTIVE_DATE_FR
     , HC.EFFECTIVE_DATE_TO
     , HC.SOB_ID
     , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE              = 'ALLOWANCE_ETC';
