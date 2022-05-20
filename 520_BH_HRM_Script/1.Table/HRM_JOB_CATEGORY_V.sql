CREATE OR REPLACE VIEW HRM_JOB_CATEGORY_V
AS
SELECT HC.COMMON_ID
			, HC.CODE
			, HC.CODE_NAME
			, HC.VALUE1
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
	WHERE EXISTS ( SELECT 'X'
									FROM HRM_COMMON S_HC
									WHERE S_HC.GROUP_CODE                   = 'HM001'
										AND S_HC.CODE                         = HC.GROUP_CODE
										AND S_HC.SOB_ID                       = HC.SOB_ID
										AND S_HC.ORG_ID                       = HC.ORG_ID
										AND S_HC.VALUE1                       = 'JOB_CATEGORY'
									)
;
