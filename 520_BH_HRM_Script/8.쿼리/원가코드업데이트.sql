SELECT TG.TEMP_FLAG
    , TG.NUM_1 AS PERSON_ID
    , TG.VARCHAR_1 AS PERSON_NUM
    , TG.VARCHAR_2 AS NAMES
    , PM.NAME
    , TG.NUM_2 AS CC_ID
    , PM.COST_CENTER_ID
    , TG.VARCHAR_3 AS CC_CODE
    , TG.VARCHAR_4 AS CC_DESC
  FROM HRM_PERSON_MASTER PM
    , HRM_TEMP_GT TG
    , CST_COST_CENTER CC
WHERE PM.PERSON_ID    = TG.NUM_1
  AND TG.VARCHAR_3    = CC.COST_CENTER_CODE
--FOR UPDATE  
;

SELECT *
  FROM HRM_TEMP_GT TG
  ;  
  
UPDATE HRM_PERSON_MASTER PM
  SET PM.COST_CENTER_ID = ( SELECT CC.COST_CENTER_ID
                              FROM HRM_TEMP_GT TG
                                , CST_COST_CENTER CC
                            WHERE TG.VARCHAR_3    = CC.COST_CENTER_CODE
                              AND TG.NUM_1        = PM.PERSON_ID
                           )
/*
SELECT *
  FROM   HRM_PERSON_MASTER PM*/
WHERE EXISTS
        ( SELECT 'X'
            FROM HRM_TEMP_GT TG
          WHERE TG.NUM_1     = PM.PERSON_ID        
        )  
