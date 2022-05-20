/*
-- 보험료 임시 테이블 INSERT //
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

SELECT *
  FROM HRP_INSURANCE_CHARGE X  
WHERE   X.SOB_ID            = 20
FOR UPDATE

;

DECLARE 
  V_SYSDATE                 DATE := GET_LOCAL_DATE(&W_SOB_ID);
  
BEGIN
  FOR C1 IN ( SELECT PM.PERSON_ID
                   , PM.PERSON_NUM
                   , PM.Corp_Id
              --     , 'P' INSUR_TYPE                 -- 국민연금.
                   , 'M' INSUR_TYPE                 -- 건강보험.
                   , 'Y' INSUR_YN
                   , TG.NUM_1 AS CORP_INSUR_AMOUNT
                   , TG.NUM_1 AS PERSON_INSUR_AMOUNT
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , SYSDATE CREATION_DATE
                   , -1 AS CREATED_BY
                   , SYSDATE LAST_UPDATE_DATE
                   , -1 AS LAST_UPDATED_BY
                FROM HRM_PERSON_MASTER PM
                  , HRM_TEMP_GT TG
              WHERE PM.REPRE_NUM          = TG.VARCHAR_1
                AND TG.TEMP_FLAG          = &W_TEMP_FLAG
                AND PM.SOB_ID             = &W_SOB_ID
                AND PM.ORG_ID             = &W_ORG_ID
                AND PM.CORP_ID            = &W_CORP_ID
             )
  LOOP
    UPDATE HRP_INSURANCE_CHARGE IC
      SET IC.CORP_INSUR_AMOUNT  = NVL(C1.CORP_INSUR_AMOUNT, 0)
        , IC.PERSON_INSUR_AMOUNT  = NVL(C1.PERSON_INSUR_AMOUNT, 0)
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
      , C1.INSUR_TYPE             , C1.INSUR_YN
      , C1.CORP_INSUR_AMOUNT      , C1.PERSON_INSUR_AMOUNT
      , C1.SOB_ID                 , C1.ORG_ID
      , C1.CREATION_DATE          , C1.CREATED_BY
      , C1.LAST_UPDATE_DATE       , C1.LAST_UPDATED_BY
      );
      
    END IF;
  END LOOP C1;


END;
