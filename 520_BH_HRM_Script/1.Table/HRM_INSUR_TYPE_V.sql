CREATE OR REPLACE VIEW HRM_INSUR_TYPE_V AS
SELECT HC.COMMON_ID AS INSUR_TYPE_ID
    , HC.CODE AS INSUR_TYPE
    , HC.CODE_NAME AS INSUR_TYPE_NAME
    , HC.VALUE1 AS DEDUCTION_CODE
    , HC.VALUE2
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
WHERE HC.GROUP_CODE             = 'INSUR_TYPE';
