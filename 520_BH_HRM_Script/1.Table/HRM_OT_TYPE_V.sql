CREATE OR REPLACE VIEW HRM_OT_TYPE_V AS
SELECT HC.COMMON_ID AS OT_TYPE_ID
     , HC.CODE AS OT_TYPE
     , HC.CODE_NAME AS OT_TYPE_NAME
     , HC.SYSTEM_FLAG
     , HC.CODE_LENGTH
     , HC.VALUE1 AS OT_COLUMN
     , HC.VALUE2 AS MONTH_TOTAL_ITEM
     , HC.VALUE3 AS ALLOWANCE_10_CODE
     , TO_NUMBER(NVL(HC.VALUE4, 0)) AS ALLOWANCE_RATE_10
     , HC.VALUE5 AS ALLOWANCE_20_CODE
     , TO_NUMBER(NVL(HC.VALUE6, 0)) AS ALLOWANCE_RATE_20
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
 WHERE HC.GROUP_CODE              = 'OT_TYPE';
