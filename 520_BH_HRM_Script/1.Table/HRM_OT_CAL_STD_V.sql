CREATE OR REPLACE VIEW HRM_OT_CAL_STD_V AS
SELECT HC.COMMON_ID
     , HC.GROUP_CODE
     , HC.CODE
     , HC.CODE_NAME
		 , HC.VALUE1 AS CAL_TYPE
		 , HC.VALUE2 AS JOB_CATEGORY_CODE
		 , HC.VALUE3 AS HOLY_TYPE
     , NVL(TO_NUMBER(HC.VALUE4), 0) AS START_ADD_DAY
		 , HC.VALUE5 AS START_TIME
		 , NVL(TO_NUMBER(HC.VALUE6), 0) AS START_DEFAULT_TIME
		 , NVL(TO_NUMBER(HC.VALUE7), 0) AS END_ADD_DAY
		 , HC.VALUE8 AS END_TIME
		 , NVL(TO_NUMBER(HC.VALUE9), 0) AS END_DEFAULT_TIME
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
WHERE HC.GROUP_CODE             = 'OT_CAL';