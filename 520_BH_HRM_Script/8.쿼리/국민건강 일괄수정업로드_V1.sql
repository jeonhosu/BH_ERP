/*-- 보험료 백업.
SELECT *
  FROM HRP_INSURANCE_CHARGE 
;

SELECT T.TEMP_FLAG
     , T.VARCHAR_1
     , T.VARCHAR_2
     , T.NUM_1
     , T.NUM_2
     , T.NUM_3
     , T.NUM_4
  FROM HRM_TEMP_GT T
WHERE T.TEMP_FLAG                = &V_TEMP_FLAG
FOR UPDATE  
;
*/

DECLARE 
  V_SYSDATE  DATE := GET_LOCAL_DATE(&P_SOB_ID);
BEGIN
  FOR C1 IN ( SELECT PM.PERSON_ID
                   , PM.CORP_ID
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , T.TEMP_FLAG AS INSUR_TYPE
                   , T.VARCHAR_1 AS NAME
                   , T.VARCHAR_2 AS PERSON_NUM
                   , T.NUM_1
                   , T.NUM_2 
                   , T.NUM_3 AS CORP_INSUR_AMOUNT
                   , T.NUM_4 AS PERSON_INSUR_AMOUNT
                FROM HRM_TEMP_GT T
                  , HRM_PERSON_MASTER PM
              WHERE T.VARCHAR_2                = PM.PERSON_NUM
                AND T.TEMP_FLAG                = &V_TEMP_FLAG 
            )
  LOOP
    BEGIN
      UPDATE HRP_INSURANCE_CHARGE IC
        SET IC.CORP_INSUR_AMOUNT  = NVL(C1.CORP_INSUR_AMOUNT, 0)
          , IC.PERSON_INSUR_AMOUNT  = NVL(C1.PERSON_INSUR_AMOUNT, 0)
          , IC.LAST_UPDATE_DATE     = V_SYSDATE
          , IC.LAST_UPDATED_BY      = -1
      WHERE IC.PERSON_ID          = C1.PERSON_ID
        AND IC.CORP_ID            = C1.CORP_ID
        AND IC.INSUR_TYPE         = C1.INSUR_TYPE
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRP_INSURANCE_CHARGE
        ( PERSON_ID                 , CORP_ID
        , INSUR_TYPE                , INSUR_YN
        , CORP_INSUR_AMOUNT         , PERSON_INSUR_AMOUNT
        , SOB_ID                    , ORG_ID
        , CREATION_DATE             , CREATED_BY
        , LAST_UPDATE_DATE          , LAST_UPDATED_BY      
        ) VALUES
        ( C1.PERSON_ID              , C1.CORP_ID
        , C1.INSUR_TYPE             , 'Y'
        , C1.CORP_INSUR_AMOUNT      , C1.PERSON_INSUR_AMOUNT
        , C1.SOB_ID                 , C1.ORG_ID
        , SYSDATE                   , -1
        , SYSDATE                   , -1
        );
            
      END IF;
    
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  
  END LOOP C1;

END;
/*
SELECT T.TEMP_FLAG
     , T.VARCHAR_1
     , T.VARCHAR_2
     , T.NUM_1
     , T.NUM_2
     , T.NUM_3
     , T.NUM_4
     , PM.NAME
     , IC.PERSON_INSUR_AMOUNT
  FROM HRM_TEMP_GT T
    , HRM_PERSON_MASTER PM
    , HRP_INSURANCE_CHARGE IC
WHERE T.VARCHAR_1                = PM.PERSON_NUM(+)
  AND PM.PERSON_ID               = IC.PERSON_ID
  AND IC.INSUR_TYPE              = &V_TEMP_FLAG
  AND T.TEMP_FLAG                = &V_TEMP_FLAG
;

SELECT PM.NAME
     , IC.*
  FROM HRP_INSURANCE_CHARGE IC
    , HRM_PERSON_MASTER PM
WHERE IC.PERSON_ID               = PM.PERSON_ID
  AND IC.INSUR_TYPE              = &W_INSUR_TYPE
  AND PM.SOB_ID                  = 20
  AND PM.ORG_ID                  = 201
  AND PM.NAME                    LIKE &W_NAME || '%'
;
  
*/
