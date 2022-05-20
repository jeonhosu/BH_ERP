CREATE OR REPLACE VIEW HRM_CLOSING_TYPE_V AS
SELECT HC.COMMON_ID AS CLOSING_TYPE_ID
     , HC.CODE AS CLOSING_TYPE
		 , HC.CODE_NAME AS CLOSING_TYPE_NAME
		 , HC.VALUE1 AS MODULE_TYPE
		 , HC.VALUE2 AS PERIOD_TYPE
		 , HC.VALUE3 AS MONTH_TOTAL_YN
		 , HC.VALUE4 AS HOLY_0_FLAG
		 , HC.VALUE5 AS LATE_DED_FLAG
		 , HC.VALUE6 AS LATE_STD_DAY
		 , HC.VALUE7
     , HC.VALUE8
     , HC.VALUE9
     , HC.VALUE10 AS PAYMENT_TYPE
		 , HC.DEFAULT_FLAG
		 , HC.SORT_NUM
		 , HC.DESCRIPTION
		 , HC.ENABLED_FLAG
		 , HC.EFFECTIVE_DATE_FR
		 , HC.EFFECTIVE_DATE_TO
		 , HC.SOB_ID
		 , HC.ORG_ID
FROM HRM_COMMON_TLV HC
WHERE HC.GROUP_CODE               = 'CLOSING_TYPE';
