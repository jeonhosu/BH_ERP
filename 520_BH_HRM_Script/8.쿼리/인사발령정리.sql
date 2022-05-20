SELECT PM.PERSON_ID 
     , PM.PERSON_NUM
     , PM.NAME
     , PM.CORP_ID
/*     , PM.OPERATING_UNIT_ID AS PM_OPERATING_ID
     , T1.OPERATING_UNIT_ID AS HL_OPERATING_ID
     , PM.DEPT_ID AS PM_DEPT_ID
     , T1.DEPT_ID AS HL_DEPT_ID
     , PM.FLOOR_ID AS PM_FLOOR_ID
     , PM.FLOOR_ID AS HL_FLOOR_ID */
     
     , PM.POST_ID AS PM_POST_ID
     , T1.POST_ID AS HL_POST_ID
     , T1.HISTORY_NUM
     , T1.LAST_UPDATE_DATE 
  FROM HRM_PERSON_MASTER PM
     , (SELECT HL.PERSON_ID
             , HH.HISTORY_NUM
             , HL.OPERATING_UNIT_ID
             , HL.DEPT_ID
             , HL.POST_ID
             , HL.PAY_GRADE_ID
             , HL.FLOOR_ID
             , HL.JOB_CATEGORY_ID
             , HL.JOB_CLASS_ID
             , HL.OCPT_ID
             , HL.ABIL_ID
             , HH.LAST_UPDATE_DATE
          FROM HRM_HISTORY_HEADER HH
             , HRM_HISTORY_LINE   HL 
         WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
           AND HH.CHARGE_SEQ          IN 
                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                    FROM HRM_HISTORY_HEADER S_HH
                       , HRM_HISTORY_LINE   S_HL
                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                     AND S_HH.CHARGE_DATE       <= TO_DATE('2014-01-31', 'YYYY-MM-DD')
                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                   GROUP BY S_HL.PERSON_ID
                 ) 
         ) T1
 WHERE PM.PERSON_ID               = T1.PERSON_ID
   AND PM.ABIL_ID                != T1.ABIL_ID   
;

SELECT HL.HISTORY_NUM
     , HL.PERSON_ID
     /*, HL.OPERATING_UNIT_ID
     , HL.PRE_OPERATING_UNIT_ID*/
     , HL.DEPT_ID
     , HL.PRE_DEPT_ID
     , HL.FLOOR_ID
     , HL.PRE_FLOOR_ID
     , HL.POST_ID
     , HL.PRE_POST_ID 
     , HL.PAY_GRADE_ID
     , HL.PRE_PAY_GRADE_ID
     , HL.OCPT_ID
     , HL.PRE_OCPT_ID 
     , HL.JOB_CLASS_ID
     , HL.PRE_JOB_CLASS_ID
  FROM HRM_HISTORY_LINE HL
 WHERE /*HL.HISTORY_NUM   IN( '2012-00257', '2013-00336')
   AND */HL.PERSON_ID     IN(3532










)
ORDER BY HL.CHARGE_DATE, HL.HISTORY_NUM
FOR UPDATE   
 ;
