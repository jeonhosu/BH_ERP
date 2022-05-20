CREATE OR REPLACE PACKAGE HRA_SAVING_INFO_G
AS

---------------------------------------------------------------------------------------------------
-- 연금저축 소득 SELECT.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_SAVING_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
            , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 연금저축 소득 INSERT.
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
-- 연금저축 소득 UPDATE.
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
-- 연금저축 소득 DELETE.
---------------------------------------------------------------------------------------------------
  PROCEDURE DELETE_SAVING_INFO
           ( W_SAVING_INFO_ID IN HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           );

---------------------------------------------------------------------------------------------------
-- 연말정산 기초정보 관리 반영.
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
            
---------------------------------------------------------------------------------------------------
-- 연금저축 소득 인쇄.
---------------------------------------------------------------------------------------------------
  PROCEDURE PRINT_SAVING_INFO
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
            , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
            , P_SAVING_GROUP      IN VARCHAR2
            );
            
END HRA_SAVING_INFO_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_SAVING_INFO_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRA_SAVING_INFO_G
/* DESCRIPTION  : 연말정산 저축공제 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
---------------------------------------------------------------------------------------------------
-- 연금저축 소득 SELECT.
---------------------------------------------------------------------------------------------------
  PROCEDURE SELECT_SAVING_INFO
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
            , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT   SI.YEAR_YYYY
             , SI.PERSON_ID
             , SI.SAVING_TYPE        -- 저축TYPE.
             , HRM_COMMON_G.CODE_NAME_F('SAVING_TYPE', SI.SAVING_TYPE, SI.SOB_ID, SI.ORG_ID) AS SAVING_TYPE_NAME -- 저축TYPE명.
             , SI.BANK_CODE          -- 금융기관 코드.
             , HRM_COMMON_G.CODE_NAME_F('YEAR_BANK', SI.BANK_CODE, SI.SOB_ID, SI.ORG_ID) AS BANK_NAME -- 금융기관명.
             , SI.ACCOUNT_NUM        -- 계좌번호.
             , SI.SAVING_COUNT       -- 횟수.
             , SI.SAVING_AMOUNT      -- 금액.
             , SI.SAVING_DED_AMOUNT  -- 공제금액.
             , SI.SAVING_INFO_ID
        FROM HRA_SAVING_INFO SI
      WHERE SI.YEAR_YYYY         = P_YEAR_YYYY
        AND SI.PERSON_ID         = W_PERSON_ID
        AND SI.SOB_ID            = P_SOB_ID
        AND SI.ORG_ID            = P_ORG_ID
      ORDER BY SI.SAVING_TYPE, SI.BANK_CODE;
      
  END SELECT_SAVING_INFO;     
            
---------------------------------------------------------------------------------------------------
-- 연금저축 소득 INSERT.
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
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HOUSEHOLD_TYPE      VARCHAR2(3);  -- 세대주 구분 --
    V_SAVING_GROUP        VARCHAR2(2);  -- 소득공제 구분 --
  BEGIN
    BEGIN
      SELECT PM.HOUSEHOLD_TYPE
        INTO V_HOUSEHOLD_TYPE
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID       = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSEHOLD_TYPE := NULL;
    END;
    IF V_HOUSEHOLD_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '세대주 구분 정보를 찾을수 없습니다. 세대주 구분을 입력하세요');
      RETURN;
    END IF;
    
    BEGIN
      SELECT ST.SAVING_GROUP
        INTO V_SAVING_GROUP
        FROM HRM_SAVING_TYPE_V ST
       WHERE ST.SAVING_TYPE     = P_SAVING_TYPE
         AND ST.SOB_ID          = P_SOB_ID
         AND ST.ORG_ID          = P_ORG_ID
         AND ROWNUM             <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SAVING_GROUP := SUBSTR(P_SAVING_TYPE, 1, 1);
    END;
      
    IF V_HOUSEHOLD_TYPE != '1' THEN
      IF V_SAVING_GROUP = '3' AND NVL(P_SAVING_AMOUNT, 0) > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, '세대주에 대해서만 주택관련 자료를 입력할 수 있습니다. 세대주 구분을 입력하세요');
        RETURN;
      END IF;
    END IF;

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
    ) VALUES
    ( P_SAVING_INFO_ID
    , P_YEAR_YYYY
    , P_SOB_ID
    , P_ORG_ID
    , P_PERSON_ID
    , P_SAVING_TYPE
    , P_BANK_CODE
    , P_ACCOUNT_NUM
    , NVL(P_SAVING_COUNT, 0)
    , NVL(P_SAVING_AMOUNT, 0)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_SAVING_INFO;

---------------------------------------------------------------------------------------------------
-- 연금저축 소득 UPDATE.
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
    V_SYSDATE             DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_HOUSEHOLD_TYPE      VARCHAR2(3);  -- 세대주 구분 --
    V_SAVING_GROUP        VARCHAR2(2);  -- 소득공제 구분 --
  BEGIN
    BEGIN
      SELECT PM.HOUSEHOLD_TYPE
        INTO V_HOUSEHOLD_TYPE
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID       = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSEHOLD_TYPE := NULL;
    END;
    IF V_HOUSEHOLD_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '세대주 구분 정보를 찾을수 없습니다. 세대주 구분을 입력하세요');
      RETURN;
    END IF;
    
    BEGIN
      SELECT ST.SAVING_GROUP
        INTO V_SAVING_GROUP
        FROM HRM_SAVING_TYPE_V ST
       WHERE ST.SAVING_TYPE     = P_SAVING_TYPE
         AND ST.SOB_ID          = W_SOB_ID
         AND ST.ORG_ID          = W_ORG_ID
         AND ROWNUM             <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SAVING_GROUP := SUBSTR(P_SAVING_TYPE, 1, 1);
    END;
      
    IF V_HOUSEHOLD_TYPE != '1' THEN
      IF V_SAVING_GROUP = '3' AND NVL(P_SAVING_AMOUNT, 0) > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, '세대주에 대해서만 주택관련 자료를 입력할 수 있습니다. 세대주 구분을 입력하세요');
        RETURN;
      END IF;
    END IF;
    
    UPDATE HRA_SAVING_INFO
      SET SAVING_TYPE       = P_SAVING_TYPE
        , BANK_CODE         = P_BANK_CODE
        , ACCOUNT_NUM       = P_ACCOUNT_NUM
        , SAVING_COUNT      = NVL(P_SAVING_COUNT, 0)
        , SAVING_AMOUNT     = NVL(P_SAVING_AMOUNT, 0)
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE SAVING_INFO_ID    = W_SAVING_INFO_ID;
END UPDATE_SAVING_INFO;

---------------------------------------------------------------------------------------------------
-- 연금저축 소득 DELETE.
---------------------------------------------------------------------------------------------------

  PROCEDURE DELETE_SAVING_INFO
           ( W_SAVING_INFO_ID IN HRA_SAVING_INFO.SAVING_INFO_ID%TYPE
           )
  IS
  BEGIN
    DELETE HRA_SAVING_INFO
    WHERE SAVING_INFO_ID = W_SAVING_INFO_ID;
  END DELETE_SAVING_INFO;
            
---------------------------------------------------------------------------------------------------
-- 연말정산 기초정보 관리 반영.
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
    -- SAVING TYPE에 따른 UPDATE --
    IF P_SAVING_TYPE IN('11', '12') THEN
      -- SAVING_TYPE : 11, 12 - 퇴직연금소득공제.
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
      -- SAVING_TYPE : 21 - 개인연금저축.
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
      -- SAVING_TYPE : 22 - 연금저축.
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
      -- SAVING_TYPE : 31, 32, 33, 34 - 주택마련저축소득공제.
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
      -- SAVING_TYPE : 41 - 장기주식형저축소득공제.
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

---------------------------------------------------------------------------------------------------
-- 연금저축 소득 인쇄.
---------------------------------------------------------------------------------------------------
  PROCEDURE PRINT_SAVING_INFO
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_YEAR_YYYY         IN HRA_SAVING_INFO.YEAR_YYYY%TYPE
            , W_PERSON_ID         IN HRA_SAVING_INFO.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_SAVING_INFO.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_SAVING_INFO.ORG_ID%TYPE
            , P_SAVING_GROUP      IN VARCHAR2
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT   SI.YEAR_YYYY
             , SI.PERSON_ID
             , SI.SAVING_TYPE        -- 저축TYPE.
             , ST.SAVING_TYPE_NAME -- 저축TYPE명.
             , SI.BANK_CODE          -- 금융기관 코드.
             , HRM_COMMON_G.CODE_NAME_F('YEAR_BANK', SI.BANK_CODE, SI.SOB_ID, SI.ORG_ID) AS BANK_NAME -- 금융기관명.
             , SI.ACCOUNT_NUM        -- 계좌번호.
             , SI.SAVING_COUNT       -- 횟수.
             , SI.SAVING_AMOUNT      -- 금액.
             , SI.SAVING_DED_AMOUNT  -- 공제금액.
        FROM HRA_SAVING_INFO SI
          , HRM_SAVING_TYPE_V ST
      WHERE SI.SAVING_TYPE       = ST.SAVING_TYPE
        AND SI.SOB_ID            = ST.SOB_ID
        AND SI.ORG_ID            = ST.ORG_ID
        AND SI.YEAR_YYYY         = P_YEAR_YYYY
        AND SI.PERSON_ID         = NVL(W_PERSON_ID, SI.PERSON_ID)
        AND SI.SOB_ID            = P_SOB_ID
        AND SI.ORG_ID            = P_ORG_ID
        AND ST.SAVING_GROUP      = P_SAVING_GROUP
        AND SI.SAVING_DED_AMOUNT > 0
      ORDER BY SI.SAVING_TYPE, SI.BANK_CODE;
  END PRINT_SAVING_INFO;
  
END HRA_SAVING_INFO_G;
/
