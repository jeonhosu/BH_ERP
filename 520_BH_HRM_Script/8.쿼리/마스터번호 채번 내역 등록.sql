/*SELECT *
  FROM HRM_MASTER_NUM X
 FOR UPDATE
;
*/

/*
-- 사원번호 등록 -- 
DECLARE
  V_MASTER_NUM_ID       NUMBER;  
  V_SEQ_COUNT           NUMBER;
  
  V_SOB_ID              NUMBER := 20;
  V_ORG_ID              NUMBER := 201;
BEGIN
  BEGIN
    SELECT MN.MASTER_NUM_ID
         , MN.SEQ_COUNT
      INTO V_MASTER_NUM_ID 
         , V_SEQ_COUNT
      FROM HRM_MASTER_NUM MN
     WHERE MN.MASTER_TYPE         = 'PERSON_NUM_O'
       AND MN.SOB_ID              = V_SOB_ID
       AND MN.ORG_ID              = V_ORG_ID 
    ;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);  
  END;

  FOR C1 IN (SELECT DISTINCT        
                   SUBSTR(PM.PERSON_NUM, 1, 7) AS JOIN_NUM
                 , MAX(SUBSTR(PM.PERSON_NUM, (-1 * V_SEQ_COUNT))) AS JOIN_SEQ
                 , MAX(PM.PERSON_NUM) AS PERSON_NUM 
                 , PM.JOIN_DATE
              FROM HRM_PERSON_MASTER PM
             WHERE PM.CORP_ID        = 25
            GROUP BY SUBSTR(PM.PERSON_NUM, 1, 6)  
                   , PM.JOIN_DATE
            ORDER BY PM.JOIN_DATE
            )
  LOOP
    BEGIN
      INSERT INTO HRM_MASTER_NUM_HISTORY 
        ( MASTER_NUM_ID 
        , SOB_ID 
        , ORG_ID 
        , MASTER_VALUE 
        , STD_DATE 
        , YEAR_CHAR 
        , MONTH_CHAR 
        , DAY_CHAR 
        , LAST_SEQ 
        , MASTER_NUM 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY  
        )
        VALUES
        ( V_MASTER_NUM_ID 
        , V_SOB_ID 
        , V_ORG_ID 
        , C1.JOIN_NUM  -- MASTER_VALUE 
        , C1.JOIN_DATE -- STD_DATE 
        , TO_CHAR(C1.JOIN_DATE, 'YYYY')  --YEAR_CHAR 
        , TO_CHAR(C1.JOIN_DATE, 'MM')    -- MONTH_CHAR 
        , TO_CHAR(C1.JOIN_DATE, 'DD')    -- DAY_CHAR 
        , C1.JOIN_SEQ                    -- LAST_SEQ 
        , C1.PERSON_NUM                  -- MASTER_NUM 
        , SYSDATE                        -- CREATION_DATE 
        , -1                             -- CREATED_BY 
        , SYSDATE                        -- LAST_UPDATE_DATE 
        , -1                             -- LAST_UPDATED_BY   
        );
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.JOIN_DATE || ', ' || C1.JOIN_NUM || ' , ' || SQLERRM);  
    END;
  END LOOP C1;
END; 
*/
/*
-- 외주 사원번호 등록 -- 
DECLARE
  V_MASTER_NUM_ID       NUMBER;  
  V_SEQ_COUNT           NUMBER;
  
  V_SOB_ID              NUMBER := 20;
  V_ORG_ID              NUMBER := 201;
BEGIN
  BEGIN
    SELECT MN.MASTER_NUM_ID
         , MN.SEQ_COUNT
      INTO V_MASTER_NUM_ID 
         , V_SEQ_COUNT
      FROM HRM_MASTER_NUM MN
     WHERE MN.MASTER_TYPE         = 'PERSON_NUM_O'
       AND MN.SOB_ID              = V_SOB_ID
       AND MN.ORG_ID              = V_ORG_ID 
    ;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);  
  END;

  FOR C1 IN (SELECT DISTINCT        
                   SUBSTR(PM.PERSON_NUM, 1, 7) AS JOIN_NUM
                 , MAX(SUBSTR(PM.PERSON_NUM, -2 \*(-1 * V_SEQ_COUNT)*\)) AS JOIN_SEQ
                 , MAX(PM.PERSON_NUM) AS PERSON_NUM 
                 , PM.JOIN_DATE
              FROM HRM_PERSON_MASTER PM
             WHERE PM.CORP_ID        != 25
            GROUP BY SUBSTR(PM.PERSON_NUM, 1, 7)  
                   , PM.JOIN_DATE
            ORDER BY PM.JOIN_DATE
            )
  LOOP
    BEGIN
      INSERT INTO HRM_MASTER_NUM_HISTORY 
        ( MASTER_NUM_ID 
        , SOB_ID 
        , ORG_ID 
        , MASTER_VALUE 
        , STD_DATE 
        , YEAR_CHAR 
        , MONTH_CHAR 
        , DAY_CHAR 
        , LAST_SEQ 
        , MASTER_NUM 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY  
        )
        VALUES
        ( V_MASTER_NUM_ID 
        , V_SOB_ID 
        , V_ORG_ID 
        , C1.JOIN_NUM  -- MASTER_VALUE 
        , C1.JOIN_DATE -- STD_DATE 
        , TO_CHAR(C1.JOIN_DATE, 'YYYY')  --YEAR_CHAR 
        , TO_CHAR(C1.JOIN_DATE, 'MM')    -- MONTH_CHAR 
        , TO_CHAR(C1.JOIN_DATE, 'DD')    -- DAY_CHAR 
        , C1.JOIN_SEQ                    -- LAST_SEQ 
        , C1.PERSON_NUM                  -- MASTER_NUM 
        , SYSDATE                        -- CREATION_DATE 
        , -1                             -- CREATED_BY 
        , SYSDATE                        -- LAST_UPDATE_DATE 
        , -1                             -- LAST_UPDATED_BY   
        );
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.JOIN_DATE || ', ' || C1.JOIN_NUM || ' , ' || SQLERRM);  
    END;
  END LOOP C1;
END; 
*/

/*
-- 인사발령 등록 -- 
DECLARE
  V_MASTER_NUM_ID       NUMBER;  
  V_SEQ_COUNT           NUMBER;
  
  V_SOB_ID              NUMBER := 20;
  V_ORG_ID              NUMBER := 201;
BEGIN
  BEGIN
    SELECT MN.MASTER_NUM_ID
         , MN.SEQ_COUNT
      INTO V_MASTER_NUM_ID 
         , V_SEQ_COUNT
      FROM HRM_MASTER_NUM MN
     WHERE MN.MASTER_TYPE         = 'HISTORY_NUM'
       AND MN.SOB_ID              = V_SOB_ID
       AND MN.ORG_ID              = V_ORG_ID 
    ;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);  
  END;

  FOR C1 IN (SELECT DISTINCT                         
                   SUBSTR(HH.HISTORY_NUM, 1, 4) AS MASTER_VALUE
                 , MAX(SUBSTR(HH.HISTORY_NUM, (-1 * 5))) AS LAST_SEQ
                 , MAX(HH.HISTORY_NUM) AS MASTER_NUM 
                 , MAX(HH.CHARGE_DATE) AS STD_DATE 
                 , HH.CORP_ID 
              FROM HRM_HISTORY_HEADER HH
             --WHERE HH.CORP_ID        = 25
            GROUP BY SUBSTR(HH.HISTORY_NUM, 1, 4)
                   , HH.CORP_ID 
            ORDER BY STD_DATE
            )
  LOOP
    BEGIN
      INSERT INTO HRM_MASTER_NUM_HISTORY 
        ( MASTER_NUM_ID 
        , SOB_ID 
        , ORG_ID 
        , MASTER_VALUE 
        , STD_DATE 
        , YEAR_CHAR 
        , MONTH_CHAR 
        , DAY_CHAR 
        , LAST_SEQ 
        , MASTER_NUM 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY  
        )
        VALUES
        ( V_MASTER_NUM_ID 
        , V_SOB_ID 
        , V_ORG_ID 
        , C1.MASTER_VALUE  -- MASTER_VALUE 
        , C1.STD_DATE -- STD_DATE 
        , TO_CHAR(C1.STD_DATE, 'YYYY')  --YEAR_CHAR 
        , TO_CHAR(C1.STD_DATE, 'MM')    -- MONTH_CHAR 
        , TO_CHAR(C1.STD_DATE, 'DD')    -- DAY_CHAR 
        , C1.LAST_SEQ                    -- LAST_SEQ 
        , C1.MASTER_NUM                  -- MASTER_NUM 
        , SYSDATE                        -- CREATION_DATE 
        , -1                             -- CREATED_BY 
        , SYSDATE                        -- LAST_UPDATE_DATE 
        , -1                             -- LAST_UPDATED_BY   
        );
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.STD_DATE || ', ' || C1.MASTER_VALUE || ' , ' || C1.LAST_SEQ || ', ' || SQLERRM);  
    END;
  END LOOP C1;
END; */


-- 인사발령 발령순서  등록 -- 
DECLARE
  V_CHARGE_SEQ          VARCHAR2(20);
  
  V_SOB_ID              NUMBER := 10;
  V_ORG_ID              NUMBER := 101;
BEGIN
  FOR C1 IN (SELECT HH.HISTORY_HEADER_ID     
                  , HH.CHARGE_DATE                  
              FROM HRM_HISTORY_HEADER HH
--             WHERE HH.CORP_ID        = 25
            GROUP BY HH.CHARGE_DATE
                   , HH.HISTORY_HEADER_ID 
            ORDER BY HH.CHARGE_DATE
                   , HISTORY_HEADER_ID 
            )
  LOOP
    BEGIN
      -- 발령순서 채번 --
      V_CHARGE_SEQ := HRM_MASTER_NUM_G.MASTER_NUM_F
                        ( W_MASTER_TYPE   => 'CHARGE_SEQ' 
                        , W_SOB_ID        => V_SOB_ID 
                        , W_ORG_ID        => V_ORG_ID  
                        , P_STD_DATE      => C1.CHARGE_DATE
                        , P_USER_ID       => -1 
                        );
      /*INSERT INTO HRM_MASTER_NUM_HISTORY 
        ( MASTER_NUM_ID 
        , SOB_ID 
        , ORG_ID 
        , MASTER_VALUE 
        , STD_DATE 
        , YEAR_CHAR 
        , MONTH_CHAR 
        , DAY_CHAR 
        , LAST_SEQ 
        , MASTER_NUM 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY  
        )
        VALUES
        ( V_MASTER_NUM_ID 
        , V_SOB_ID 
        , V_ORG_ID 
        , C1.MASTER_VALUE  -- MASTER_VALUE 
        , C1.STD_DATE -- STD_DATE 
        , TO_CHAR(C1.STD_DATE, 'YYYY')  --YEAR_CHAR 
        , TO_CHAR(C1.STD_DATE, 'MM')    -- MONTH_CHAR 
        , TO_CHAR(C1.STD_DATE, 'DD')    -- DAY_CHAR 
        , C1.LAST_SEQ                    -- LAST_SEQ 
        , C1.MASTER_NUM                  -- MASTER_NUM 
        , SYSDATE                        -- CREATION_DATE 
        , -1                             -- CREATED_BY 
        , SYSDATE                        -- LAST_UPDATE_DATE 
        , -1                             -- LAST_UPDATED_BY   
        );*/
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.HISTORY_HEADER_ID || ' , ' || C1.CHARGE_DATE || ', ' || SQLERRM);  
    END;
    
    BEGIN
      UPDATE HRM_HISTORY_HEADER HH
         SET HH.CHARGE_SEQ        = V_CHARGE_SEQ
       WHERE HH.HISTORY_HEADER_ID = C1.HISTORY_HEADER_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.HISTORY_HEADER_ID || ' , ' || C1.CHARGE_DATE || ', ' || SQLERRM);  
    END;
  END LOOP C1;
END; 

