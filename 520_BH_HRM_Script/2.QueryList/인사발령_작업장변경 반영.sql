DECLARE
  V_COUNT               NUMBER := 0;
  V_EFFECTIVE_DATE_FR   DATE;
  V_EFFECTIVE_DATE_TO   DATE := TO_DATE('3000-12-31', 'YYYY-MM-DD');
  V_LAST_YN             VARCHAR2(2);
BEGIN
  FOR C1 IN (SELECT HH.CORP_ID
                  , HH.CHARGE_DATE
                  , HL.PERSON_ID
                  , PM.PERSON_NUM
                  , PM.NAME
                  , HH.SOB_ID
                  , HH.ORG_ID
                  , HL.DEPT_ID
                  , HL.FLOOR_ID
                  , HL.PRE_DEPT_ID
                  , HL.PRE_FLOOR_ID
                  , PM.WORK_TYPE_ID
                  , PM.WORK_TYPE_ID AS PRE_WORK_TYPE_ID
                  , SYSDATE AS V_SYSDATE
                  , -10 AS USER_ID
              FROM HRM_HISTORY_HEADER HH
                 , HRM_HISTORY_LINE   HL
                 , HRM_PERSON_MASTER  PM
             WHERE HH.HISTORY_HEADER_ID     = HL.HISTORY_HEADER_ID
               AND HL.PERSON_ID             = PM.PERSON_ID
               AND PM.PERSON_NUM            = 'B03014'                   
               AND HH.HISTORY_NUM           = '2012-00002'
             )
  LOOP
    V_COUNT := V_COUNT + 1;
    BEGIN
      SELECT PH.EFFECTIVE_DATE_FR
           , PH.LAST_YN
        INTO V_EFFECTIVE_DATE_FR
           , V_LAST_YN
        FROM HRD_PERSON_HISTORY PH
       WHERE PH.PERSON_ID         = C1.PERSON_ID
         AND PH.EFFECTIVE_DATE_FR <= C1.CHARGE_DATE
         AND PH.EFFECTIVE_DATE_TO >= C1.CHARGE_DATE
      ;         
    EXCEPTION WHEN OTHERS THEN
      V_LAST_YN := 'Y';
      V_EFFECTIVE_DATE_FR := NULL;
    END;
    IF V_LAST_YN = 'N' THEN
      DBMS_OUTPUT.PUT_LINE('NAME : ' || C1.NAME || '(' || C1.PERSON_NUM || ') Not last data');      
    END IF;
    --DBMS_OUTPUT.PUT_LINE('LAST_YN : ' || V_LAST_YN || '-' || V_EFFECTIVE_DATE_FR);      
    
    IF V_EFFECTIVE_DATE_FR IS NULL THEN
      -- ½Å±Ô INSERT --
      INSERT INTO HRD_PERSON_HISTORY
      ( CORP_ID 
      , PERSON_ID 
      , EFFECTIVE_DATE_FR 
      , EFFECTIVE_DATE_TO 
      , SOB_ID 
      , ORG_ID 
      , FLOOR_ID 
      , WORK_TYPE_ID 
      , PRE_FLOOR_ID 
      , PRE_WORK_TYPE_ID 
      , DESCRIPTION 
      , LAST_YN 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      , DEPT_ID 
      , PRE_DEPT_ID 
      ) VALUES
      ( C1.CORP_ID 
      , C1.PERSON_ID 
      , C1.CHARGE_DATE 
      , V_EFFECTIVE_DATE_TO 
      , C1.SOB_ID 
      , C1.ORG_ID 
      , C1.FLOOR_ID 
      , C1.WORK_TYPE_ID 
      , C1.PRE_FLOOR_ID 
      , C1.PRE_WORK_TYPE_ID 
      , NULL --DESCRIPTION 
      , 'Y'  -- LAST_YN 
      , C1.V_SYSDATE 
      , C1.USER_ID
      , C1.V_SYSDATE 
      , C1.USER_ID
      , C1.DEPT_ID 
      , C1.PRE_DEPT_ID 
      );
    ELSIF V_EFFECTIVE_DATE_FR = C1.CHARGE_DATE THEN
      -- UPDATE --
      UPDATE HRD_PERSON_HISTORY PH
         SET PH.FLOOR_ID          = C1.FLOOR_ID
           , PH.DEPT_ID           = C1.DEPT_ID
       WHERE PH.PERSON_ID         = C1.PERSON_ID
         AND PH.EFFECTIVE_DATE_FR = C1.CHARGE_DATE
         AND PH.SOB_ID            = C1.SOB_ID
         AND PH.ORG_ID            = C1.ORG_ID
      ;
    ELSIF V_EFFECTIVE_DATE_FR < C1.CHARGE_DATE THEN
      -- UPDATE / INSERT --
      UPDATE HRD_PERSON_HISTORY PH
         SET PH.LAST_YN           = 'N'
           , PH.EFFECTIVE_DATE_TO = C1.CHARGE_DATE - 1
       WHERE PH.PERSON_ID         = C1.PERSON_ID
         AND PH.SOB_ID            = C1.SOB_ID
         AND PH.ORG_ID            = C1.ORG_ID
         AND PH.LAST_YN           = 'Y'
      ;
      
      -- INSERT --
      INSERT INTO HRD_PERSON_HISTORY
      ( CORP_ID 
      , PERSON_ID 
      , EFFECTIVE_DATE_FR 
      , EFFECTIVE_DATE_TO 
      , SOB_ID 
      , ORG_ID 
      , FLOOR_ID 
      , WORK_TYPE_ID 
      , PRE_FLOOR_ID 
      , PRE_WORK_TYPE_ID 
      , DESCRIPTION 
      , LAST_YN 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      , DEPT_ID 
      , PRE_DEPT_ID 
      ) VALUES
      ( C1.CORP_ID 
      , C1.PERSON_ID 
      , C1.CHARGE_DATE 
      , V_EFFECTIVE_DATE_TO 
      , C1.SOB_ID 
      , C1.ORG_ID 
      , C1.FLOOR_ID 
      , C1.WORK_TYPE_ID 
      , C1.PRE_FLOOR_ID 
      , C1.PRE_WORK_TYPE_ID 
      , NULL --DESCRIPTION 
      , 'Y'  -- LAST_YN 
      , C1.V_SYSDATE 
      , C1.USER_ID
      , C1.V_SYSDATE 
      , C1.USER_ID
      , C1.DEPT_ID 
      , C1.PRE_DEPT_ID 
      );
    END IF;    
  END LOOP C1;
  DBMS_OUTPUT.PUT_LINE('COUNT : ' || V_COUNT);               
END;
/*
SELECT *
  FROM HRD_PERSON_HISTORY PH
 WHERE PH.PERSON_ID       = 238  
; */
