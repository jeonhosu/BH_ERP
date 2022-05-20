CREATE OR REPLACE VIEW HRM_PERSON_MASTER_V1 AS
SELECT PM.PERSON_ID
     , PM.PERSON_NUM
		 , PM.NAME
		 , PM.CORP_ID
		 , PM.DEPT_ID
		 , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
		 , PM.WORK_TYPE_ID
		 , PM.POST_ID
		 , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
		 , PM.PAY_GRADE_ID
		 , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
		 , PM.ORI_JOIN_DATE
		 , PM.JOIN_DATE
		 , PM.RETIRE_DATE
		 , PM.EMPLOYE_TYPE
		 , PM.JOB_CATEGORY_ID
		 , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
		 , PM.FLOOR_ID
		 , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_NAME
		 , PM.CORP_TYPE
		 , PM.SOB_ID
		 , PM.ORG_ID
		 , PM.DISPLAY_NAME
FROM HRM_PERSON_MASTER PM;