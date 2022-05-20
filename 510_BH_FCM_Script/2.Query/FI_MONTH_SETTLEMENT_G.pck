CREATE OR REPLACE PACKAGE FI_MONTH_SETTLEMENT_G
AS

-- 결산자료 조회.
  PROCEDURE MONTH_SETTLEMENT_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT.ORG_ID%TYPE
            );

-- 결산자료 수정.
  PROCEDURE MONTH_SETTLEMENT_UPDATE
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_FORM_HEADER_ID    IN FI_MONTH_SETTLEMENT.FORM_HEADER_ID%TYPE
            , P_GL_AMOUNT         IN FI_MONTH_SETTLEMENT.GL_AMOUNT%TYPE
            , P_USER_ID           IN FI_MONTH_SETTLEMENT.CREATED_BY%TYPE 
            );
                       
-- 결산자료 생성.
  PROCEDURE MONTH_SETTLEMENT_SET
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT.ORG_ID%TYPE
            , W_USER_ID           IN FI_MONTH_SETTLEMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

-- 결산자료 롤업 생성.
  PROCEDURE MONTH_SETTLEMENT_SET_ROLLUP
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT.ORG_ID%TYPE
            );
            
END FI_MONTH_SETTLEMENT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_MONTH_SETTLEMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_MONTH_SETTLEMENT_G
/* Description  : 결산자료 생성 패키지.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 결산자료 조회.
  PROCEDURE MONTH_SETTLEMENT_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT MS.PERIOD_NAME
           , MS.FORM_HEADER_ID
           , FH.FORM_ITEM_NAME           
           , DECODE(FH.LAST_LEVEL_YN, 'Y', MS.GL_AMOUNT, 0) AS GL_AMOUNT          -- 금액.
           , DECODE(FH.LAST_LEVEL_YN, 'Y', 0, MS.GL_AMOUNT) AS UPPER_AMOUNT          -- 금액.
           , MS.JOURNALIZE_AMOUNT  -- 분개 대상금액.
           , MS.FORM_ITEM_TYPE
           , MS.FORM_ITEM_CLASS
        FROM FI_MONTH_SETTLEMENT MS
          , FI_FORM_HEADER FH
      WHERE MS.FORM_HEADER_ID   = FH.FORM_HEADER_ID
        AND MS.SOB_ID           = FH.SOB_ID
        AND MS.PERIOD_NAME      = W_PERIOD_NAME
        AND MS.SOB_ID           = W_SOB_ID
        AND FH.DISPLAY_YN       = 'Y'
      ORDER BY FH.SORT_SEQ
      ;
  END MONTH_SETTLEMENT_SELECT;
  
-- 결산자료 수정.
  PROCEDURE MONTH_SETTLEMENT_UPDATE
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_FORM_HEADER_ID    IN FI_MONTH_SETTLEMENT.FORM_HEADER_ID%TYPE
            , P_GL_AMOUNT         IN FI_MONTH_SETTLEMENT.GL_AMOUNT%TYPE
            , P_USER_ID           IN FI_MONTH_SETTLEMENT.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    
  BEGIN
    UPDATE FI_MONTH_SETTLEMENT
      SET GL_AMOUNT         = P_GL_AMOUNT
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE PERIOD_NAME       = W_PERIOD_NAME
      AND SOB_ID            = W_SOB_ID
      AND FORM_HEADER_ID    = W_FORM_HEADER_ID
    ;
  END MONTH_SETTLEMENT_UPDATE;
            
-- 결산자료 생성.
  PROCEDURE MONTH_SETTLEMENT_SET
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT.ORG_ID%TYPE
            , W_USER_ID           IN FI_MONTH_SETTLEMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_GL_DATE_FR                  DATE;
    V_GL_DATE_TO                  DATE;
    V_AMOUNT                      NUMBER;
    
  BEGIN
    V_GL_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_GL_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_GL_DATE_FR, W_SOB_ID, W_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;
    END IF;
    
    -- 해당월 결산자료 삭제.
    BEGIN
      DELETE FROM FI_MONTH_SETTLEMENT MS
      WHERE MS.PERIOD_NAME        = W_PERIOD_NAME 
        AND MS.SOB_ID             = W_SOB_ID
      ;      
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Settlement Delete Error : ' || SUBSTR(SQLERRM, 1, 250));
    END;
    
    -- 항목생성.
    BEGIN
      INSERT INTO FI_MONTH_SETTLEMENT
      ( PERIOD_NAME
      , SOB_ID
      , ORG_ID
      , FORM_HEADER_ID
      , FORM_ITEM_LEVEL
      , FORM_ITEM_TYPE
      , FORM_ITEM_CLASS
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY      
      )
      SELECT W_PERIOD_NAME AS PERIOD_NAME
          , W_SOB_ID AS SOB_ID
          , W_ORG_ID AS ORG_ID
          , FH.FORM_HEADER_ID
          , FH.ITEM_LEVEL
          , FH.FORM_ITEM_TYPE
          , FH.FORM_ITEM_CLASS
          , V_SYSDATE
          , W_USER_ID
          , V_SYSDATE
          , W_USER_ID
        FROM FI_FORM_HEADER FH
      WHERE FH.SOB_ID                 = W_SOB_ID
        AND FH.ENABLED_FLAG           = 'Y'
        AND FH.EFFECTIVE_DATE_FR      <= V_GL_DATE_TO
        AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE    = 'FORM_TYPE'
                       AND FC.COMMON_ID     = FH.FORM_TYPE_ID
                       AND FC.SOB_ID        = FH.SOB_ID
                       AND FC.CODE          = '9001'
                    )  
      ORDER BY FH.SORT_SEQ
        ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Settlement Item Insert Error : ' || SUBSTR(SQLERRM, 1, 250));
    END;
    
    -- 전표 금액 적용.
    FOR C1 IN ( SELECT MS.PERIOD_NAME
                     , MS.SOB_ID
                     , MS.FORM_HEADER_ID
                     , MS.FORM_ITEM_LEVEL
                     , MS.FORM_ITEM_TYPE
                     , MS.FORM_ITEM_CLASS
                     , FH.ACCOUNT_DR_CR
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_MONTH_SETTLEMENT MS
                     , FI_FORM_HEADER FH
                     , FI_FORM_LINE FL
                WHERE MS.FORM_HEADER_ID     = FH.FORM_HEADER_ID
                  AND FH.FORM_HEADER_ID     = FL.FORM_HEADER_ID
                  AND MS.PERIOD_NAME        = W_PERIOD_NAME
                  AND MS.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_GL_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_GL_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)
                )
    LOOP
      V_AMOUNT := 0;
      IF C1.FORM_ITEM_CLASS = '10' THEN
      -- 기초 금액 산출.
        BEGIN  
          SELECT DECODE(AC.ACCOUNT_DR_CR, '1', FA.TOTAL_DR_AMOUNT - FA.TOTAL_CR_AMOUNT, FA.TOTAL_CR_AMOUNT - FA.TOTAL_DR_AMOUNT) AS BEGIN_AMOUNT
            INTO V_AMOUNT
            FROM FI_AGGREGATE FA
              , FI_ACCOUNT_CONTROL AC
          WHERE FA.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
            AND FA.SOB_ID             = AC.SOB_ID
            AND FA.PERIOD_NAME        = C1.PERIOD_NAME
            AND FA.SOB_ID             = C1.SOB_ID
            AND FA.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
            AND FA.CURRENCY_CODE      = FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(C1.SOB_ID)
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      ELSE
      -- 당기 입고.870
        BEGIN
          SELECT DECODE(AC.ACCOUNT_DR_CR, '1', FA.PERIOD_DR_AMOUNT - FA.PERIOD_CR_AMOUNT, FA.PERIOD_CR_AMOUNT - FA.PERIOD_DR_AMOUNT) AS PERIOD_AMOUNT
            INTO V_AMOUNT
            FROM FI_AGGREGATE FA
              , FI_ACCOUNT_CONTROL AC
          WHERE FA.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
            AND FA.SOB_ID             = AC.SOB_ID
            AND FA.PERIOD_NAME        = C1.PERIOD_NAME
            AND FA.SOB_ID             = C1.SOB_ID
            AND FA.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
            AND FA.CURRENCY_CODE      = FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(C1.SOB_ID)
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
      
      BEGIN
        UPDATE FI_MONTH_SETTLEMENT MS
          SET MS.GL_AMOUNT = V_AMOUNT
        WHERE MS.PERIOD_NAME      = C1.PERIOD_NAME
          AND MS.SOB_ID           = C1.SOB_ID
          AND MS.FORM_HEADER_ID   = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RAISE;
      END;
    END LOOP C1;
    
    -- 금액 ROLLUP.
    MONTH_SETTLEMENT_SET_ROLLUP
          ( W_PERIOD_NAME
          , W_SOB_ID
          , W_ORG_ID
          );
          
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      O_MESSAGE := ERRNUMS.Data_Not_opened_Code || '-' || ERRNUMS.Data_Not_Opened_Desc;
  END MONTH_SETTLEMENT_SET;

-- 결산자료 롤업 생성.
  PROCEDURE MONTH_SETTLEMENT_SET_ROLLUP
            ( W_PERIOD_NAME       IN FI_MONTH_SETTLEMENT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_MONTH_SETTLEMENT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_MONTH_SETTLEMENT.ORG_ID%TYPE
            )
  AS
    V_GL_DATE_FR                  DATE;
    V_GL_DATE_TO                  DATE;
    
  BEGIN
    V_GL_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_GL_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    
    FOR C1 IN ( SELECT MS.PERIOD_NAME
                     , MS.SOB_ID
                     , MS.FORM_HEADER_ID
                     , MS.FORM_ITEM_LEVEL
                     , MS.FORM_ITEM_TYPE
                     , MS.FORM_ITEM_CLASS
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_MONTH_SETTLEMENT MS
                     , FI_FORM_HEADER FH
                WHERE MS.FORM_HEADER_ID     = FH.FORM_HEADER_ID
                  AND MS.PERIOD_NAME        = W_PERIOD_NAME
                  AND MS.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_GL_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)      
                ORDER BY FH.ITEM_LEVEL DESC
              )
    LOOP
--      DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_MONTH_SETTLEMENT MS
        SET MS.GL_AMOUNT
            =
            ( SELECT SUM(MS1.GL_AMOUNT * FL.ITEM_SIGN) AS REMAIN_CR_AMOUNT
                FROM FI_MONTH_SETTLEMENT MS1
                  , FI_FORM_LINE FL
              WHERE MS1.FORM_HEADER_ID    = FL.JOIN_LINE_CONTROL_ID
                AND FL.FORM_HEADER_ID     = MS.FORM_HEADER_ID
            )
      WHERE MS.FORM_HEADER_ID             = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END MONTH_SETTLEMENT_SET_ROLLUP;
  
END FI_MONTH_SETTLEMENT_G;
/
