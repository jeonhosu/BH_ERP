CREATE OR REPLACE VIEW HRM_DECIMAL_CAL_V AS
SELECT HC.COMMON_ID AS DECIMAL_CAL_ID
    , HC.CODE AS DECIMAL_CAL_CODE
    , HC.CODE_NAME AS DECIMAL_CAL_NAME
    , HC.VALUE1 AS CAL_TYPE
    , NVL(HC.VALUE2, 'N') AS CAL_FUNCTION
    , NVL(TO_NUMBER(HC.VALUE3), 0) AS DIGIT_VALUE
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
WHERE HC.GROUP_CODE             = 'DECIMAL_CAL';
