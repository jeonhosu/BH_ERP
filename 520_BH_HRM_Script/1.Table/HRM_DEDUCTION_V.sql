CREATE OR REPLACE VIEW HRM_DEDUCTION_V AS
SELECT HC.COMMON_ID AS DEDUCTION_ID
    , HC.CODE AS DEDUCTION_CODE
    , HC.CODE_NAME AS DEDUCTION_NAME
    , NVL(HC.VALUE1, 'N') AS DEDUCTION_YN
    , HC.VALUE2 AS DEDUCTION_TYPE
    , HC.VALUE3
    , HC.VALUE4 AS TAX_FREE
    , HC.VALUE5
    , HC.VALUE6
    , HC.VALUE7
    , NVL(HC.VALUE8, 'N') AS PAY_MASTER_YN
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
WHERE HC.GROUP_CODE             = 'DEDUCTION';