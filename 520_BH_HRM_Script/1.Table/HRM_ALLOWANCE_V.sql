CREATE OR REPLACE VIEW HRM_ALLOWANCE_V AS
SELECT HC.COMMON_ID AS ALLOWANCE_ID
    , HC.CODE AS ALLOWANCE_CODE
    , HC.CODE_NAME AS ALLOWANCE_NAME
    , NVL(HC.VALUE1, 'N') AS ALLOWANCE_YN
    , HC.VALUE2 AS ALLOWANCE_TYPE
    , NVL(HC.VALUE3, 'N') AS DAY_YN
    , HC.VALUE4 AS TAX_FREE
    , NVL(HC.VALUE5, 'N') AS GENERAL_TIME_YN
    , NVL(HC.VALUE6, 'N') AS GENERAL_PAY_YN
    , NVL(HC.VALUE7, 'Y') AS UNEMPLOYEE_INSUR_YN
    , NVL(HC.VALUE8, 'N') AS PAY_MASTER_YN
    , NVL(HC.VALUE9, 'N') AS PAY_GRADE_YN
    , NVL(HC.VALUE10, 'Y') AS RETIRE_YN
    , HC.DEFAULT_FLAG
    , HC.SORT_NUM
    , HC.DESCRIPTION
    , HC.ENABLED_FLAG
    , HC.EFFECTIVE_DATE_FR
    , HC.EFFECTIVE_DATE_TO
    , HC.SOB_ID
    , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
WHERE HC.GROUP_CODE             = 'ALLOWANCE';