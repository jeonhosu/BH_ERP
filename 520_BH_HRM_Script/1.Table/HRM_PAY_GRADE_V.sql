CREATE OR REPLACE VIEW HRM_PAY_GRADE_V AS
SELECT HC.COMMON_ID AS PAY_GRADE_ID
     , HC.GROUP_CODE
     , HC.CODE AS PAY_GRADE
     , HC.CODE_NAME AS PAY_GRADE_NAME
     , NVL(HC.VALUE1, 'N') AS OFFICER_YN
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
 WHERE HC.GROUP_CODE            = 'PAY_GRADE';
