CREATE OR REPLACE VIEW HRM_REQ_TYPE_V AS
SELECT HC.COMMON_ID
     , HC.CODE AS REQ_TYPE
     , HC.CODE_NAME AS REQ_TYPE_NAME
		 , HC.VALUE1 AS REQ_STD_ADD_DAY
	 	 , HC.VALUE2
		 , HC.VALUE3
		 , HC.VALUE4
		 , HC.VALUE5
		 , HC.VALUE6
		 , HC.VALUE7
     , HC.VALUE8
		 , HC.VALUE9
		 , HC.VALUE10
		 , HC.ENABLED_FLAG
		 , HC.EFFECTIVE_DATE_FR
		 , HC.EFFECTIVE_DATE_TO
		 , HC.SOB_ID
		 , HC.ORG_ID
	FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE              = 'REQ_TYPE';
