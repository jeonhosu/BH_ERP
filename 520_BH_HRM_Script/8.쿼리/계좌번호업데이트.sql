SELECT *
  FROM HRP_PAY_MASTER_HEADER MH
WHERE MH.LAST_YN             = 'Y'  
;

SELECT *
  FROM HRM_TEMP_GT
FOR UPDATE  
;


SELECT PM.PERSON_ID
     , HT.TEMP_FLAG AS PERSON_NUM
     , HT.VARCHAR_1 AS NAME
     , HT.VARCHAR_2 AS BANK_NAME
     , HRM_COMMON_G.GET_ID_F('BANK', 'CODE = ''' || HT.VARCHAR_3 || '''', 10, 101) AS BANK_ID  --'CODE = ''16''', 10, 101) AS BANK_ID -- 
     , HT.VARCHAR_3 AS BANK_CODE
     , HT.VARCHAR_4 AS ACCOUNT_NUM
  FROM HRM_TEMP_GT HT
    , HRM_PERSON_MASTER PM
WHERE HT.TEMP_FLAG       = PM.PERSON_NUM
  AND NOT EXISTS
        (SELECT 'X'
           FROM HRP_PAY_MASTER_HEADER PMH
         WHERE PMH.PERSON_ID     = PM.PERSON_ID        
        )
;  

-- UPDATE.
UPDATE HRP_PAY_MASTER_HEADER MH
  SET (MH.BANK_ID, MH.BANK_ACCOUNTS)
   =  ( SELECT HRM_COMMON_G.GET_ID_F('BANK', 'CODE = ''' || HT.VARCHAR_3 || '''', 10, 101) AS BANK_ID  --'CODE = ''16''', 10, 101) AS BANK_ID -- 
             , HT.VARCHAR_4 AS ACCOUNT_NUM
          FROM HRM_TEMP_GT HT
            , HRM_PERSON_MASTER PM
        WHERE HT.TEMP_FLAG       = PM.PERSON_NUM
          AND PM.PERSON_ID       = MH.PERSON_ID
      )
WHERE MH.LAST_YN    = 'Y'
  AND EXISTS
        ( SELECT 'X'
          FROM HRM_TEMP_GT HT
            , HRM_PERSON_MASTER PM
        WHERE HT.TEMP_FLAG       = PM.PERSON_NUM
          AND PM.PERSON_ID       = MH.PERSON_ID
        );
   
--- MISMATCH.
SELECT PM.NAME
     , PM.ORI_JOIN_DATE
     , PM.RETIRE_DATE
     , MH.*
  FROM HRP_PAY_MASTER_HEADER MH
    , HRM_PERSON_MASTER PM
WHERE MH.PERSON_ID  = PM.PERSON_ID
  --AND MH.LAST_YN    = 'N'
  AND EXISTS
        ( SELECT 'X'
          FROM HRM_TEMP_GT HT
            , HRM_PERSON_MASTER PM
        WHERE HT.TEMP_FLAG       = PM.PERSON_NUM
          AND PM.PERSON_ID       = MH.PERSON_ID
        );
   
    
