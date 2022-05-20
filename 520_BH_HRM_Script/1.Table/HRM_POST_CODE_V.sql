CREATE OR REPLACE VIEW HRM_POST_CODE_V AS
SELECT HC.COMMON_ID AS POST_ID
     , HC.GROUP_CODE
     , HC.CODE AS POST_CODE
     , HC.CODE_NAME AS POST_NAME
     , NVL(HC.VALUE1, 'N') AS OFFICER_YN
     , NVL(HC.VALUE2, 'Y') AS DUTY_CONTROL_YN
     , NVL(HC.VALUE3, 'Y') AS HOLIDAY_CONTROL_YN
     , NVL(HC.VALUE4, 'C') AS CARD_CHECK_FLAG
     , HC.VALUE5
     , HC.VALUE6
     , HC.VALUE7
     , HC.VALUE8
     , HC.VALUE9
     , HC.VALUE10 AS DEFAULT_VALUE_FLAG
     , HC.DEFAULT_FLAG
     , HC.SORT_NUM
     , HC.DESCRIPTION
     , HC.ENABLED_FLAG
     , HC.EFFECTIVE_DATE_FR
     , HC.EFFECTIVE_DATE_TO
     , HC.SOB_ID
     , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE            = 'POST';