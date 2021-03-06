CREATE OR REPLACE VIEW HRM_VISITOR_CARD_V
AS
SELECT HC.COMMON_ID AS VISITOR_ID
     , HC.CODE AS VISITOR_NUM
		 , HC.CODE_NAME AS VISITOR_NAME
		 , HC.VALUE1 AS CARD_NUM
		 , HC.VALUE2
		 , HC.VALUE3
		 , HC.VALUE4
		 , HC.VALUE5
		 , HC.VALUE6
		 , HC.VALUE7
		 , HC.DEFAULT_FLAG
		 , HC.SORT_NUM
		 , HC.DESCRIPTION
		 , HC.USABLE
		 , HC.START_DATE
		 , HC.END_DATE
		 , HC.SOB_ID
		 , HC.ORG_ID
  FROM HRM_COMMON HC
 WHERE HC.GROUP_CODE            = 'HM111'
; 
