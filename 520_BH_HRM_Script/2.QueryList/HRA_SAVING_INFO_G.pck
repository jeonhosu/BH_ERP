CREATE OR REPLACE PACKAGE HRA_SAVING_INFO_G
AS

---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? SELECT.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_SAVING_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
            , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? INSERT.
---------------------------------------------------------------------------------------------------
  PROCEDURE INSERT_SAVING_INFO
           ( P_SAVING_INFO_ID    OUT HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           , P_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
           , P_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
           , P_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
           , P_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
           , P_SAVING_TYPE       IN HRA_SAVING_INFO.SAVING_TYPE%TYPE
           , P_BANK_CODE         IN HRA_SAVING_INFO.BANK_CODE%TYPE
           , P_ACCOUNT_NUM       IN HRA_SAVING_INFO.ACCOUNT_NUM%TYPE
           , P_SAVING_COUNT      IN HRA_SAVING_INFO.SAVING_COUNT%TYPE
           , P_SAVING_AMOUNT     IN HRA_SAVING_INFO.SAVING_AMOUNT%TYPE          
           , P_USER_ID           IN HRA_SAVING_INFO.CREATED_BY%TYPE
           );

---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? UPDATE.
---------------------------------------------------------------------------------------------------
  PROCEDURE UPDATE_SAVING_INFO
           ( W_SAVING_INFO_ID    IN HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           , W_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
           , W_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
           , W_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
           , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
           , P_SAVING_TYPE       IN HRA_SAVING_INFO.SAVING_TYPE%TYPE
           , P_BANK_CODE         IN HRA_SAVING_INFO.BANK_CODE%TYPE
           , P_ACCOUNT_NUM       IN HRA_SAVING_INFO.ACCOUNT_NUM%TYPE
           , P_SAVING_COUNT      IN HRA_SAVING_INFO.SAVING_COUNT%TYPE
           , P_SAVING_AMOUNT     IN HRA_SAVING_INFO.SAVING_AMOUNT%TYPE         
           , P_USER_ID           IN HRA_SAVING_INFO.CREATED_BY%TYPE 
           );

---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? DELETE.
---------------------------------------------------------------------------------------------------
  PROCEDURE DELETE_SAVING_INFO
           ( W_SAVING_INFO_ID IN HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           , W_YEAR_YYYY       HRA_SAVING_INFO.YEAR_YYYY%TYPE
           , W_SOB_ID          HRA_SAVING_INFO.SOB_ID%TYPE
           , W_ORG_ID          HRA_SAVING_INFO.ORG_ID%TYPE
           , W_PERSON_ID       HRA_SAVING_INFO.PERSON_ID%TYPE 
           );

---------------------------------------------------------------------------------------------------
-- ???????? ???????? ???? ?ݿ?.
---------------------------------------------------------------------------------------------------
  PROCEDURE UPDATE_FOUNDATION
            ( W_GB                IN VARCHAR2
            , P_YEAR_YYYY         IN HRA_FOUNDATION.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_FOUNDATION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_FOUNDATION.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_FOUNDATION.ORG_ID%TYPE
            , P_SAVING_TYPE       IN HRA_SAVING_INFO.SAVING_TYPE%TYPE
            , P_SAVING_COUNT      IN HRA_SAVING_INFO.SAVING_COUNT%TYPE
            , P_SAVING_AMOUNT     IN HRA_SAVING_INFO.SAVING_AMOUNT%TYPE
            , P_USER_ID           IN HRA_SAVING_INFO.LAST_UPDATED_BY%TYPE
            );
            

END HRA_SAVING_INFO_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_SAVING_INFO_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRA_SAVING_INFO_G
/* DESCRIPTION  : ???????? ???????? ????.
/* REFERENCE BY :
/* PROGRAM HISTORY : ?ű? ????
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/


---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? SELECT.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_SAVING_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
            , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
            )
  AS
    BEGIN
      OPEN P_CURSOR FOR
      SELECT   SI.YEAR_YYYY
             , SI.SAVING_INFO_ID
             , SI.PERSON_ID
             , SI.SAVING_TYPE        -- ????TYPE.
             , HRM_COMMON_G.CODE_NAME_F('SAVING_TYPE', SI.SAVING_TYPE, SI.SOB_ID, SI.ORG_ID) AS SAVING_TYPE_NAME -- ????TYPE??.
             , SI.BANK_CODE          -- ???????? ?ڵ?.
             --, HRM_COMMON_G.CODE_VALUE_F('YEAR_BANK', SI.BANK_CODE, 'VALUE1', SI.SOB_ID, SI.ORG_ID) AS BANK_NAME -- ??????????.
             , HRM_COMMON_G.CODE_NAME_F('YEAR_BANK', SI.BANK_CODE, SI.SOB_ID, SI.ORG_ID) AS BANK_NAME -- ??????????.
             , SI.ACCOUNT_NUM        -- ???¹?ȣ.
             , SI.SAVING_COUNT       -- Ƚ??.
             , SI.SAVING_AMOUNT      -- ?ݾ?.
             , SI.SAVING_DED_AMOUNT  -- ?????ݾ?.
        FROM HRA_SAVING_INFO SI
       WHERE SI.YEAR_YYYY         = W_YEAR_YYYY
         AND SI.PERSON_ID         = W_PERSON_ID
         AND SI.SOB_ID            = W_SOB_ID
         AND SI.ORG_ID            = W_ORG_ID
       ORDER BY SAVING_TYPE_NAME ASC;
      
  END SELECT_SAVING_INFO;     
            
---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? INSERT.
---------------------------------------------------------------------------------------------------
  PROCEDURE INSERT_SAVING_INFO
           ( P_SAVING_INFO_ID    OUT HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           , P_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
           , P_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
           , P_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
           , P_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
           , P_SAVING_TYPE       IN HRA_SAVING_INFO.SAVING_TYPE%TYPE
           , P_BANK_CODE         IN HRA_SAVING_INFO.BANK_CODE%TYPE
           , P_ACCOUNT_NUM       IN HRA_SAVING_INFO.ACCOUNT_NUM%TYPE
           , P_SAVING_COUNT      IN HRA_SAVING_INFO.SAVING_COUNT%TYPE
           , P_SAVING_AMOUNT     IN HRA_SAVING_INFO.SAVING_AMOUNT%TYPE          
           , P_USER_ID           IN HRA_SAVING_INFO.CREATED_BY%TYPE
           )
  IS
        V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

   SELECT HRA_SAVING_INFO_S1.NEXTVAL
     INTO P_SAVING_INFO_ID
     FROM DUAL;

   INSERT INTO HRA_SAVING_INFO
   ( SAVING_INFO_ID
   , YEAR_YYYY 
   , SOB_ID 
   , ORG_ID 
   , PERSON_ID 
   , SAVING_TYPE 
   , BANK_CODE 
   , ACCOUNT_NUM 
   , SAVING_COUNT 
   , SAVING_AMOUNT    
   , CREATION_DATE 
   , CREATED_BY 
   , LAST_UPDATE_DATE 
   , LAST_UPDATED_BY
   )
   VALUES
   ( P_SAVING_INFO_ID
   , P_YEAR_YYYY
   , P_SOB_ID
   , P_ORG_ID
   , P_PERSON_ID
   , P_SAVING_TYPE
   , P_BANK_CODE
   , P_ACCOUNT_NUM
   , P_SAVING_COUNT
   , P_SAVING_AMOUNT  
   , V_SYSDATE
   , P_USER_ID
   , V_SYSDATE
   , P_USER_ID );
   

  /*EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;*/

  END INSERT_SAVING_INFO;

---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? UPDATE.
---------------------------------------------------------------------------------------------------
  PROCEDURE UPDATE_SAVING_INFO
           ( W_SAVING_INFO_ID    IN HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           , W_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
           , W_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
           , W_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
           , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
           , P_SAVING_TYPE       IN HRA_SAVING_INFO.SAVING_TYPE%TYPE
           , P_BANK_CODE         IN HRA_SAVING_INFO.BANK_CODE%TYPE
           , P_ACCOUNT_NUM       IN HRA_SAVING_INFO.ACCOUNT_NUM%TYPE
           , P_SAVING_COUNT      IN HRA_SAVING_INFO.SAVING_COUNT%TYPE
           , P_SAVING_AMOUNT     IN HRA_SAVING_INFO.SAVING_AMOUNT%TYPE         
           , P_USER_ID           IN HRA_SAVING_INFO.CREATED_BY%TYPE 
           )
  IS
        V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

   UPDATE HRA_SAVING_INFO
      SET SAVING_TYPE       = P_SAVING_TYPE
        , BANK_CODE         = P_BANK_CODE
        , ACCOUNT_NUM       = P_ACCOUNT_NUM
        , SAVING_COUNT      = P_SAVING_COUNT
        , SAVING_AMOUNT     = P_SAVING_AMOUNT      
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE SAVING_INFO_ID    = W_SAVING_INFO_ID
      AND YEAR_YYYY         = W_YEAR_YYYY
      AND SOB_ID            = W_SOB_ID
      AND ORG_ID            = W_ORG_ID
      AND PERSON_ID         = W_PERSON_ID;   

/*  EXCEPTION WHEN OTHERS THEN
   BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
 END;
*/
END UPDATE_SAVING_INFO;

---------------------------------------------------------------------------------------------------
-- ???????? ?ҵ? DELETE.
---------------------------------------------------------------------------------------------------

  PROCEDURE DELETE_SAVING_INFO
           ( W_SAVING_INFO_ID IN HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           , W_YEAR_YYYY       HRA_SAVING_INFO.YEAR_YYYY%TYPE
           , W_SOB_ID          HRA_SAVING_INFO.SOB_ID%TYPE
           , W_ORG_ID          HRA_SAVING_INFO.ORG_ID%TYPE
           , W_PERSON_ID       HRA_SAVING_INFO.PERSON_ID%TYPE 
           )
  IS
  BEGIN
   DELETE HRA_SAVING_INFO
    WHERE SAVING_INFO_ID = W_SAVING_INFO_ID
      AND YEAR_YYYY      = W_YEAR_YYYY
      AND SOB_ID         = W_SOB_ID
      AND ORG_ID         = W_ORG_ID
      AND PERSON_ID      = W_PERSON_ID;   

/*  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');*/
  END DELETE_SAVING_INFO;
            
---------------------------------------------------------------------------------------------------
-- ???????? ???????? ???? ?ݿ?.
---------------------------------------------------------------------------------------------------
  PROCEDURE UPDATE_FOUNDATION
            ( W_GB                IN VARCHAR2
            , P_YEAR_YYYY         IN HRA_FOUNDATION.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN HRA_FOUNDATION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_FOUNDATION.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_FOUNDATION.ORG_ID%TYPE
            , P_SAVING_TYPE       IN HRA_SAVING_INFO.SAVING_TYPE%TYPE
            , P_SAVING_COUNT      IN HRA_SAVING_INFO.SAVING_COUNT%TYPE
            , P_SAVING_AMOUNT     IN HRA_SAVING_INFO.SAVING_AMOUNT%TYPE
            , P_USER_ID           IN HRA_SAVING_INFO.LAST_UPDATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    -- SAVING TYPE?? ???? UPDATE --
    IF P_SAVING_TYPE IN('11', '12') THEN
      -- SAVING_TYPE : 11, 12 - ???????ݼҵ?????.
      UPDATE HRA_FOUNDATION HF
        SET HF.RETR_ANNU_AMT      = NVL(HF.RETR_ANNU_AMT, 0) + NVL(P_SAVING_AMOUNT, 0)
          , HF.LAST_UPDATE_DATE   = V_SYSDATE
          , HF.LAST_UPDATED_BY    = P_USER_ID
      WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
        AND HF.PERSON_ID          = P_PERSON_ID
        AND HF.SOB_ID             = P_SOB_ID
        AND HF.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRA_FOUNDATION
        ( YEAR_YYYY           , PERSON_ID
        , SOB_ID              , ORG_ID
        , RETR_ANNU_AMT
        , CREATION_DATE       , CREATED_BY
        , LAST_UPDATE_DATE    , LAST_UPDATED_BY
        ) VALUES
        ( P_YEAR_YYYY         , P_PERSON_ID
        , P_SOB_ID            , P_ORG_ID
        , NVL(P_SAVING_AMOUNT, 0)
        , V_SYSDATE           , P_USER_ID
        , V_SYSDATE           , P_USER_ID
        ); 
      END IF;    
    ELSIF P_SAVING_TYPE = '21' THEN
      -- SAVING_TYPE : 21 - ???ο???????.
      UPDATE HRA_FOUNDATION HF
        SET HF.PERSON_ANNU_AMT    = NVL(HF.PERSON_ANNU_AMT, 0) + NVL(P_SAVING_AMOUNT, 0)
          , HF.LAST_UPDATE_DATE   = V_SYSDATE
          , HF.LAST_UPDATED_BY    = P_USER_ID
      WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
        AND HF.PERSON_ID          = P_PERSON_ID
        AND HF.SOB_ID             = P_SOB_ID
        AND HF.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRA_FOUNDATION
        ( YEAR_YYYY           , PERSON_ID
        , SOB_ID              , ORG_ID
        , PERSON_ANNU_AMT
        , CREATION_DATE       , CREATED_BY
        , LAST_UPDATE_DATE    , LAST_UPDATED_BY
        ) VALUES
        ( P_YEAR_YYYY         , P_PERSON_ID
        , P_SOB_ID            , P_ORG_ID
        , NVL(P_SAVING_AMOUNT, 0)
        , V_SYSDATE           , P_USER_ID
        , V_SYSDATE           , P_USER_ID
        ); 
      END IF; 
    ELSIF P_SAVING_TYPE = '22' THEN
      -- SAVING_TYPE : 22 - ????????.
      UPDATE HRA_FOUNDATION HF
        SET HF.ANNU_BANK_AMT      = NVL(HF.ANNU_BANK_AMT, 0) + NVL(P_SAVING_AMOUNT, 0)
      WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
        AND HF.PERSON_ID          = P_PERSON_ID
        AND HF.SOB_ID             = P_SOB_ID
        AND HF.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRA_FOUNDATION
        ( YEAR_YYYY           , PERSON_ID
        , SOB_ID              , ORG_ID
        , ANNU_BANK_AMT
        , CREATION_DATE       , CREATED_BY
        , LAST_UPDATE_DATE    , LAST_UPDATED_BY
        ) VALUES
        ( P_YEAR_YYYY         , P_PERSON_ID
        , P_SOB_ID            , P_ORG_ID
        , NVL(P_SAVING_AMOUNT, 0)
        , V_SYSDATE           , P_USER_ID
        , V_SYSDATE           , P_USER_ID
        ); 
      END IF;   
    ELSIF P_SAVING_TYPE IN('31', '32', '33', '34') THEN
      -- SAVING_TYPE : 31, 32, 33, 34 - ???ø????????ҵ?????.
      UPDATE HRA_FOUNDATION HF
        SET HF.HOUSE_SAVE_AMT     = NVL(HF.HOUSE_SAVE_AMT, 0) + NVL(P_SAVING_AMOUNT, 0)
          , HF.LAST_UPDATE_DATE   = V_SYSDATE
          , HF.LAST_UPDATED_BY    = P_USER_ID
      WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
        AND HF.PERSON_ID          = P_PERSON_ID
        AND HF.SOB_ID             = P_SOB_ID
        AND HF.ORG_ID             = P_ORG_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO HRA_FOUNDATION
        ( YEAR_YYYY           , PERSON_ID
        , SOB_ID              , ORG_ID
        , HOUSE_SAVE_AMT
        , CREATION_DATE       , CREATED_BY
        , LAST_UPDATE_DATE    , LAST_UPDATED_BY
        ) VALUES
        ( P_YEAR_YYYY         , P_PERSON_ID
        , P_SOB_ID            , P_ORG_ID
        , NVL(P_SAVING_AMOUNT, 0)
        , V_SYSDATE           , P_USER_ID
        , V_SYSDATE           , P_USER_ID
        ); 
      END IF;   
    ELSIF P_SAVING_TYPE = '41' THEN
      -- SAVING_TYPE : 41 - ?????ֽ????????ҵ?????.
      IF P_SAVING_COUNT = 1 THEN
        UPDATE HRA_FOUNDATION HF
          SET HF.LONG_STOCK_SAVING_AMT_1  = NVL(HF.LONG_STOCK_SAVING_AMT_1, 0) + NVL(P_SAVING_AMOUNT, 0)
            , HF.LAST_UPDATE_DATE   = V_SYSDATE
            , HF.LAST_UPDATED_BY    = P_USER_ID
        WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
          AND HF.PERSON_ID          = P_PERSON_ID
          AND HF.SOB_ID             = P_SOB_ID
          AND HF.ORG_ID             = P_ORG_ID
        ;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO HRA_FOUNDATION
          ( YEAR_YYYY           , PERSON_ID
          , SOB_ID              , ORG_ID
          , LONG_STOCK_SAVING_AMT_1
          , CREATION_DATE       , CREATED_BY
          , LAST_UPDATE_DATE    , LAST_UPDATED_BY
          ) VALUES
          ( P_YEAR_YYYY         , P_PERSON_ID
          , P_SOB_ID            , P_ORG_ID
          , NVL(P_SAVING_AMOUNT, 0)
          , V_SYSDATE           , P_USER_ID
          , V_SYSDATE           , P_USER_ID
          ); 
        END IF;
      ELSIF P_SAVING_COUNT = 2 THEN
        UPDATE HRA_FOUNDATION HF
          SET HF.LONG_STOCK_SAVING_AMT_2  = NVL(HF.LONG_STOCK_SAVING_AMT_2, 0) + NVL(P_SAVING_AMOUNT, 0)
            , HF.LAST_UPDATE_DATE   = V_SYSDATE
            , HF.LAST_UPDATED_BY    = P_USER_ID
        WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
          AND HF.PERSON_ID          = P_PERSON_ID
          AND HF.SOB_ID             = P_SOB_ID
          AND HF.ORG_ID             = P_ORG_ID
        ;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO HRA_FOUNDATION
          ( YEAR_YYYY           , PERSON_ID
          , SOB_ID              , ORG_ID
          , LONG_STOCK_SAVING_AMT_2
          , CREATION_DATE       , CREATED_BY
          , LAST_UPDATE_DATE    , LAST_UPDATED_BY
          ) VALUES
          ( P_YEAR_YYYY         , P_PERSON_ID
          , P_SOB_ID            , P_ORG_ID
          , NVL(P_SAVING_AMOUNT, 0)
          , V_SYSDATE           , P_USER_ID
          , V_SYSDATE           , P_USER_ID
          ); 
        END IF;
      ELSIF P_SAVING_COUNT = 3 THEN
        UPDATE HRA_FOUNDATION HF
          SET HF.LONG_STOCK_SAVING_AMT_3  = NVL(HF.LONG_STOCK_SAVING_AMT_3, 0) + NVL(P_SAVING_AMOUNT, 0)
            , HF.LAST_UPDATE_DATE   = V_SYSDATE
            , HF.LAST_UPDATED_BY    = P_USER_ID
        WHERE HF.YEAR_YYYY          = P_YEAR_YYYY
          AND HF.PERSON_ID          = P_PERSON_ID
          AND HF.SOB_ID             = P_SOB_ID
          AND HF.ORG_ID             = P_ORG_ID
        ;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO HRA_FOUNDATION
          ( YEAR_YYYY           , PERSON_ID
          , SOB_ID              , ORG_ID
          , LONG_STOCK_SAVING_AMT_3
          , CREATION_DATE       , CREATED_BY
          , LAST_UPDATE_DATE    , LAST_UPDATED_BY
          ) VALUES
          ( P_YEAR_YYYY         , P_PERSON_ID
          , P_SOB_ID            , P_ORG_ID
          , NVL(P_SAVING_AMOUNT, 0)
          , V_SYSDATE           , P_USER_ID
          , V_SYSDATE           , P_USER_ID
          ); 
        END IF;
      END IF;
    END IF;
  END UPDATE_FOUNDATION;

END HRA_SAVING_INFO_G;
/
