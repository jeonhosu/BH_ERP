/*
SELECT TG.TEMP_FLAG
     , TG.VARCHAR_1
     , TG.VARCHAR_2
     , TG.VARCHAR_3
     , TG.VARCHAR_4
     , TG.VARCHAR_5
     , TG.NUM_1
     , TG.NUM_2
     , TG.VARCHAR_6
  FROM HRM_TEMP_GT TG
WHERE TG.TEMP_FLAG                = 'ED'
FOR UPDATE
;
*/  

DECLARE
  V_EDUCATION_ID                  NUMBER;
  V_PERSON_ID                     NUMBER;
  V_SYSDATE                       DATE := GET_LOCAL_DATE(10);
BEGIN
  FOR C1 IN ( SELECT PM.PERSON_ID
                   , TG.VARCHAR_1 AS PERSON_NUM
                   , TG.VARCHAR_2 AS START_DATE
                   , TG.VARCHAR_3 AS END_DATE
                   , TG.VARCHAR_4 AS EDU_ORG
                   , TG.VARCHAR_5 AS EDU_CURRICULUM
                   , TG.NUM_1     AS EDU_AMOUNT
                   , TG.NUM_2     AS EDU_RETURN_AMOUNT
                   , TG.VARCHAR_6 AS REMARK
                FROM HRM_TEMP_GT TG
                  , HRM_PERSON_MASTER PM
              WHERE TG.VARCHAR_1                = PM.PERSON_NUM(+)
                AND TG.TEMP_FLAG                = 'ED'
              )
  LOOP
    IF C1.PERSON_ID IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('PERSON ID NOT FOUND..(' || C1.PERSON_NUM || ')');
    ELSE
      SELECT HRM_EDUCATION_S1.NEXTVAL
        INTO V_EDUCATION_ID
        FROM DUAL;
        
      INSERT INTO HRM_EDUCATION
      ( EDUCATION_ID 
      , PERSON_ID 
      , START_DATE 
      , END_DATE 
      , EDU_ORG 
      , EDU_CURRICULUM 
      , EDU_PAY_AMOUNT 
      , EDU_PAY_RETURN_AMOUNT 
      , DESCRIPTION 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( V_EDUCATION_ID
      , C1.PERSON_ID
      , C1.START_DATE
      , C1.END_DATE
      , C1.EDU_ORG
      , C1.EDU_CURRICULUM
      , C1.EDU_AMOUNT
      , C1.EDU_RETURN_AMOUNT
      , C1.REMARK
      , V_SYSDATE
      , -1
      , V_SYSDATE
      , -1      
      );
    END IF;
  END LOOP C1;
END;  
/*
SELECT *
  FROM HRM_EDUCATION
where END_DATE = '2013-10-31'

  */
