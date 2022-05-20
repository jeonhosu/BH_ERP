/*
SELECT *
  FROM HRM_TEMP_GT TG
WHERE TG.TEMP_FLAG                = 'RP'
FOR UPDATE
;
*/  

DECLARE
  V_REWARD_PUNISHMENT_ID          NUMBER;
  V_RP_ID                         NUMBER;
  V_PERSON_ID                     NUMBER;
  V_SYSDATE                       DATE := GET_LOCAL_DATE(10);
BEGIN
  FOR C1 IN ( SELECT PM.PERSON_ID
                   , TG.VARCHAR_1 AS PERSON_NUM
                   , TG.VARCHAR_2 AS NAME
                   , TG.VARCHAR_3 AS RP_TYPE
                   , HRM_COMMON_G.GET_ID_F('RP', 'CODE = ''' || TG.VARCHAR_5 || '''', PM.SOB_ID, PM.ORG_ID) AS RP_ID
                   , TG.VARCHAR_5 AS RP_CODE
                   , TG.VARCHAR_7 AS RP_DATE
                   , TG.VARCHAR_8 AS RP_DESC
                   , TG.VARCHAR_9 AS RP_ORG
                   , TG.VARCHAR_10 AS DESCRIPTION
                FROM HRM_TEMP_GT TG
                  , HRM_PERSON_MASTER PM
              WHERE TG.VARCHAR_1                = PM.PERSON_NUM(+)
                AND TG.TEMP_FLAG                = 'R/P'
              )
  LOOP
    IF C1.PERSON_ID IS NULL THEN
      DBMS_OUTPUT.PUT_LINE('PERSON ID NOT FOUND..(' || C1.PERSON_NUM || ')');
    ELSE
      SELECT HRM_REWARD_PUNISHMENT_S1.NEXTVAL
        INTO V_REWARD_PUNISHMENT_ID
        FROM DUAL;
        
      INSERT INTO HRM_REWARD_PUNISHMENT
      ( REWARD_PUNISHMENT_ID 
      , PERSON_ID 
      , RP_TYPE 
      , RP_ID 
      , RP_DATE 
      , RP_DESCRIPTION 
      , RP_ORG 
      , DESCRIPTION  
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( V_REWARD_PUNISHMENT_ID
      , C1.PERSON_ID
      , C1.RP_TYPE
      , C1.RP_ID
      , C1.RP_DATE
      , C1.RP_DESC
      , C1.RP_ORG
      , C1.DESCRIPTION
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
  FROM HRM_REWARD_PUNISHMENT
where END_DATE = '2013-03-31'

  */
