CREATE OR REPLACE VIEW HRM_YEAR_EDU_LMT_V AS
SELECT HC.COMMON_ID
    , HC.CODE EDUCATION_TYPE
    , HC.CODE_NAME EDUCATION_NAME
    , HC.VALUE1 AS AMOUNT_LMT
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
FROM HRM_COMMON HC
WHERE HC.GROUP_CODE = 'EDU_LMT';
