CREATE OR REPLACE VIEW HRM_HOLIDAY_TERM_V AS
SELECT HC.COMMON_ID AS HOLIDAY_TERM_ID
     , HC.CODE AS HOLIDAY_YEAR
		 , HC.CODE_NAME AS YEAR_NAME
		 , NVL(TO_DATE(HC.VALUE1, 'YYYY-MM-DD'), TO_DATE(HC.CODE || '-01-01', 'YYYY-MM-DD')) AS START_DATE
		 , NVL(TO_DATE(HC.VALUE2, 'YYYY-MM-DD'), TO_DATE(HC.CODE || '-12-31', 'YYYY-MM-DD')) AS END_DATE
		 , HC.VALUE3 AS YEAR_PAY_YN
		 , HC.VALUE4 AS YEAR_TRANS_NEXT_YN
		 , HC.VALUE5 AS SUMMER_TRANS_NEXT_YN
		 , HC.VALUE6 AS SPECIAL_TRANS_NEXT_YN
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
WHERE  HC.GROUP_CODE            = 'HOLIDAY_TERM';
