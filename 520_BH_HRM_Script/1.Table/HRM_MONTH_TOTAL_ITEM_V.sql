CREATE OR REPLACE VIEW HRM_MONTH_TOTAL_ITEM_V AS
SELECT HC.COMMON_ID AS MONTH_TOTAL_ITEM_ID
     , HC.CODE AS MONTH_TOTAL_ITEM
     , HC.CODE_NAME AS MONTH_TOTAL_ITEM_NAME
     , HC.SYSTEM_FLAG
     , HC.CODE_LENGTH
     , HC.VALUE1 AS TABLE_NAME
     , HC.VALUE2 AS COLUMN_CODE
     , HC.VALUE3
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
  FROM HRM_COMMON HC
 WHERE HC.GROUP_CODE              = 'MONTH_TOTAL_ITEM';
