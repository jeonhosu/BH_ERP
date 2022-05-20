CREATE OR REPLACE VIEW HRM_PERSON_MASTER_V_ALL AS
SELECT PM.PERSON_ID
     , PM.PERSON_NUM
     , PM.NAME
     , PM.CORP_ID
     , PM.DEPT_ID
     , PM.WORK_TYPE_ID
     , PM.POST_ID
     , PM.PAY_GRADE_ID
     , PM.REPRE_NUM
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
     , 'PM' AS MASTER_FLAG
  FROM HRM_PERSON_MASTER PM
-----------------------------
  UNION ALL
-----------------------------
SELECT PD.PERSON_ID
     , PD.PERSON_NUM
     , PD.NAME
     , PD.CORP_ID
     , PD.DEPT_ID
     , PD.WORK_TYPE_ID
     , PD.POST_ID
     , PD.PAY_GRADE_ID
     , PD.REPRE_NUM
     , PD.ORI_JOIN_DATE
     , PD.JOIN_DATE
     , PD.RETIRE_DATE
     , PD.EMPLOYE_TYPE
     , PD.JOB_CATEGORY_ID
     , PD.FLOOR_ID
     , PD.CORP_TYPE
     , PD.SOB_ID
     , PD.ORG_ID
     , PD.DISPLAY_NAME
     , 'PD' AS MASTER_FLAG
  FROM HRM_PERSON_DISPATCH PD;