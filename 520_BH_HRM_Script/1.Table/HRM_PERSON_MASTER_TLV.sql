CREATE OR REPLACE VIEW HRM_PERSON_MASTER_TLV AS
SELECT PM.PERSON_ID
     , PM.PERSON_NUM
		 , PM.NAME
		 , PM.CORP_ID
		 , PM.DEPT_ID
     , DM.DEPT_CODE
     , DM.DEPT_NAME AS DEPT_NAME
		 , PM.WORK_TYPE_ID
		 , PM.POST_ID
		 , PM.PAY_GRADE_ID
		 , PM.ORI_JOIN_DATE
		 , PM.JOIN_DATE
		 , PM.RETIRE_DATE
		 , PM.EMPLOYE_TYPE
		 , PM.JOB_CATEGORY_ID
		 , PM.FLOOR_ID
		 , PM.CORP_TYPE
		 , PM.SOB_ID
		 , PM.ORG_ID
		 , PM.DISPLAY_NAME
FROM HRM_PERSON_MASTER PM
  , HRM_DEPT_MASTER_TLV DM
WHERE PM.DEPT_ID                  = DM.DEPT_ID  ;