CREATE OR REPLACE VIEW HRM_ALLOWANCE_LIMIT_V AS
SELECT HC.COMMON_ID AS ALLOWANCE_ID
    , HC.CODE AS ALLOWANCE_CODE
    , HC.CODE_NAME AS ALLOWANCE_NAME
    , HC.VALUE1 AS ALLOWANCE_TYPE
    , TO_NUMBER(HC.VALUE2) AS ALLOWANCE_LIMIT_AMOUNT
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
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE              = 'ALLOWANCE_LIMIT'
 ;
