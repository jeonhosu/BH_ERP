CREATE OR REPLACE VIEW HRM_WORK_TERM_V AS
SELECT DT.DUTY_TERM_ID
    , DT.DUTY_TERM_GROUP
    , DT.DUTY_TERM AS DUTY_TERM
    , DT.DUTY_TERM_NAME AS DUTY_TERM_NAME
    , DT.DUTY_TERM_TYPE AS DUTY_TERM_TYPE
    , DT.START_DAY AS START_DAY
    , DT.START_ADD_MONTH AS START_ADD_MONTH
    , DT.START_ADD_DAY AS START_ADD_DAY
    , DT.END_DAY AS END_DAY
    , DT.END_ADD_MONTH AS END_ADD_MONTH
    , DT.END_ADD_DAY AS END_ADD_DAY
    , DT.JOB_CATEGORY_CODE AS JOB_CATEGORY_CODE
    , DT.VALUE9
    , DT.VALUE10
    , DT.DEFAULT_FLAG
    , DT.SORT_NUM
    , DT.DESCRIPTION
    , DT.ENABLED_FLAG
    , DT.EFFECTIVE_DATE_FR
    , DT.EFFECTIVE_DATE_TO
    , DT.SOB_ID
    , DT.ORG_ID   
  FROM HRM_DUTY_TERM_V DT

