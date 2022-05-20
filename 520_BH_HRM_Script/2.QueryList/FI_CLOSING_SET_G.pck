CREATE OR REPLACE PACKAGE FI_CLOSING_SET_G
AS

-- 결산 처리 MAIN.
  PROCEDURE CLOSING_MAIN_SET
            ( W_PERIOD_NAME       IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );
            
-- 결산금액 계산.
  PROCEDURE CLOSING_AMOUNT_SET
            ( W_PERIOD_NAME       IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            );

-- 결산금액 INSERT 계산.
  PROCEDURE INSERT_CLOSING_AMOUNT
            ( P_PERIOD_NAME         IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , P_CLOSING_GROUP       IN FI_CLOSING_AMOUNT.CLOSING_GROUP%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_CLOSING_AMOUNT.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_CLOSING_AMOUNT.ACCOUNT_CODE%TYPE
            , P_AMOUNT              IN FI_CLOSING_AMOUNT.AMOUNT%TYPE
            , P_SOB_ID              IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID             IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            );

-- 결산분개 적용.
  PROCEDURE CLOSING_AUTO_JOURNAL_SET
            ( W_PERIOD_NAME       IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            );

-- 결산분개 INSERT.
  PROCEDURE INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , P_SLIP_DATE         IN FI_CLOSING_SLIP.SLIP_DATE%TYPE
            , P_SLIP_NUM          IN FI_CLOSING_SLIP.SLIP_NUM%TYPE
            , P_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , P_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_DEPT_ID           IN FI_CLOSING_SLIP.DEPT_ID%TYPE
            , P_PERSON_ID         IN FI_CLOSING_SLIP.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID    IN FI_CLOSING_SLIP.BUDGET_DEPT_ID%TYPE
            , P_ACCOUNT_BOOK_ID   IN FI_CLOSING_SLIP.ACCOUNT_BOOK_ID%TYPE
            , P_SLIP_TYPE         IN FI_CLOSING_SLIP.SLIP_TYPE%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_CLOSING_SLIP.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE      IN FI_CLOSING_SLIP.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR     IN FI_CLOSING_SLIP.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT         IN FI_CLOSING_SLIP.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE     IN FI_CLOSING_SLIP.CURRENCY_CODE%TYPE
            , P_REMARK            IN FI_CLOSING_SLIP.REMARK%TYPE
            , P_SYSDATE           IN FI_CLOSING_SLIP.CREATION_DATE%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            );

-- 결산분개 전표 INSERT.
  PROCEDURE INSERT_CLOSING_SLIP
            ( W_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

-- 결산분개 전표 DELETE.
  PROCEDURE DELETE_CLOSING_SLIP
            ( W_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            );

-- 결산분개 전표 CANCEL.
  PROCEDURE CANCEL_CLOSING_SLIP
            ( W_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );
            
END FI_CLOSING_SET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_CLOSING_SET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_CLOSING_SET_G
/* Description  : 결산자료 생성 패키지.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 결산 처리 MAIN.
  PROCEDURE CLOSING_MAIN_SET
            ( W_PERIOD_NAME       IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
  BEGIN
    -- 결산금액 계산.
    CLOSING_AMOUNT_SET
          ( W_PERIOD_NAME
          , W_SOB_ID
          , W_ORG_ID
          , P_USER_ID
          );
    
    -- 결산분개.
    CLOSING_AUTO_JOURNAL_SET
          ( W_PERIOD_NAME
          , W_SOB_ID
          , W_ORG_ID
          , P_USER_ID
          );
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10250', NULL);
    
  END CLOSING_MAIN_SET;
  
-- 결산금액 계산.
  PROCEDURE CLOSING_AMOUNT_SET
            ( W_PERIOD_NAME       IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            )
  AS
    V_ACCOUNT_CONTROL_ID          NUMBER;
    V_ACCOUNT_CODE                VARCHAR2(20);
    
    V_AMOUNT                      NUMBER := 0;  -- 계산금액.
    V_BEGIN_AMOUNT                NUMBER := 0;  -- 기초.
    V_THIS_IN_AMOUNT              NUMBER := 0;  -- 당기 입고.
    V_THIS_OUT_AMOUNT             NUMBER := 0;  -- 당기 출고.
    V_ENDING_AMOUNT               NUMBER := 0;  -- 기말.
    
  BEGIN
    -- 0. 해당월 기존 자료 삭제.
    BEGIN
      DELETE FROM FI_CLOSING_AMOUNT CA
      WHERE CA.PERIOD_NAME        = W_PERIOD_NAME
        AND CA.SOB_ID             = W_SOB_ID
      ;
    END;
    
    -- 1. 원재료 금액 산출.
    V_BEGIN_AMOUNT := 0;
    V_THIS_IN_AMOUNT := 0;
    V_THIS_OUT_AMOUNT := 0;
    V_ENDING_AMOUNT := 0;
    BEGIN
      SELECT CA.ACCOUNT_CONTROL_ID
           , CA.ACCOUNT_CODE
        INTO V_ACCOUNT_CONTROL_ID
           , V_ACCOUNT_CODE
        FROM FI_CLOSING_ACCOUNT CA
      WHERE CA.CLOSING_GROUP        = '101'
        AND CA.CLOSING_ACCOUNT_TYPE = '20'
        AND ROWNUM                  <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('MAT : Account Code Find Error');
        V_ACCOUNT_CODE := '1120400';
        BEGIN
          SELECT AC.ACCOUNT_CONTROL_ID
            INTO V_ACCOUNT_CONTROL_ID
            FROM FI_ACCOUNT_CONTROL AC
          WHERE AC.ACCOUNT_CODE     = V_ACCOUNT_CODE
            AND AC.SOB_ID           = W_SOB_ID
          ;
        EXCEPTION 
          WHEN OTHERS THEN
            V_ACCOUNT_CONTROL_ID := -1;
        END;
    END;
    -- 1.1 원재료 기초금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_BEGIN_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '101'                       -- 원재료.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BEGIN_AMOUNT := 0;
    END;
    
    -- 1.2 원재료 입고금액.
    BEGIN
      SELECT SUM(CASE
                   WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                   WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                   ELSE 0
                 END) AS REMAIN_AMOUNT
        INTO V_THIS_IN_AMOUNT
        FROM FI_SLIP_LINE SL
          , FI_SLIP_HEADER SH
          , FI_ACCOUNT_CONTROL AC
      WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.PERIOD_NAME              = W_PERIOD_NAME
        AND SL.SOB_ID                   = W_SOB_ID
        AND SL.CONFIRM_YN               = 'Y'
        AND SH.SLIP_TYPE                <> 'CL'
        AND EXISTS (SELECT 'X'
                      FROM FI_CLOSING_ACCOUNT CA
                    WHERE CA.ACCOUNT_CONTROL_ID         = SL.ACCOUNT_CONTROL_ID
                      AND CA.SOB_ID                     = SL.SOB_ID
                      AND CA.CLOSING_GROUP              = '101'       -- 원재료.
                      AND CA.CLOSING_ACCOUNT_TYPE       = '20'        -- 당기입고.
                    )
      GROUP BY SL.PERIOD_NAME 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_IN_AMOUNT := 0;
    END;
    
    -- 1.3 원재료 타계정 출고 금액.
    BEGIN
      SELECT SUM(CASE
                   WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                   WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                   ELSE 0
                 END) AS REMAIN_AMOUNT
        INTO V_THIS_OUT_AMOUNT
        FROM FI_SLIP_LINE SL
          , FI_SLIP_HEADER SH
          , FI_ACCOUNT_CONTROL AC
      WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.PERIOD_NAME              = W_PERIOD_NAME
        AND SL.SOB_ID                   = W_SOB_ID
        AND SL.CONFIRM_YN               = 'Y'
        AND SH.SLIP_TYPE                <> 'CL'
        AND EXISTS (SELECT 'X'
                      FROM FI_CLOSING_ACCOUNT CA
                    WHERE CA.ACCOUNT_CONTROL_ID         = SL.ACCOUNT_CONTROL_ID
                      AND CA.SOB_ID                     = SL.SOB_ID
                      AND CA.CLOSING_GROUP              = '101'       -- 원재료.
                      AND CA.CLOSING_ACCOUNT_TYPE       = '30'        -- 당기출고.
                    )
      GROUP BY SL.PERIOD_NAME 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_OUT_AMOUNT := 0;
    END;
    
    -- 1.4 원재료 기말 금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_ENDING_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = W_PERIOD_NAME
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '101'                       -- 원재료.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ENDING_AMOUNT := 0;
    END;
    
    -- 당기 원재료 출고금액 산출.
    V_AMOUNT := NVL(V_BEGIN_AMOUNT, 0) + NVL(V_THIS_IN_AMOUNT, 0) - NVL(V_THIS_OUT_AMOUNT, 0) - NVL(V_ENDING_AMOUNT, 0);
    
    IF V_AMOUNT <> 0 THEN
      -- 1.9 원재료금액 INSERT.
      INSERT_CLOSING_AMOUNT( P_PERIOD_NAME => W_PERIOD_NAME
                           , P_CLOSING_GROUP => '101'
                           , P_ACCOUNT_CONTROL_ID => V_ACCOUNT_CONTROL_ID
                           , P_ACCOUNT_CODE => V_ACCOUNT_CODE
                           , P_AMOUNT => V_AMOUNT
                           , P_SOB_ID => W_SOB_ID
                           , P_ORG_ID => W_ORG_ID
                           , P_USER_ID => P_USER_ID
                           );
    END IF;
    
    -- 2. 부재료 금액 산출.
    V_BEGIN_AMOUNT := 0;
    V_THIS_IN_AMOUNT := 0;
    V_THIS_OUT_AMOUNT := 0;
    V_ENDING_AMOUNT := 0;
    BEGIN
      SELECT CA.ACCOUNT_CONTROL_ID
           , CA.ACCOUNT_CODE
        INTO V_ACCOUNT_CONTROL_ID
           , V_ACCOUNT_CODE
        FROM FI_CLOSING_ACCOUNT CA
      WHERE CA.CLOSING_GROUP        = '201'
        AND CA.CLOSING_ACCOUNT_TYPE = '20'
        AND ROWNUM                  <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('RAW : Account Code Find Error');
        V_ACCOUNT_CODE := '-';
        BEGIN
          SELECT AC.ACCOUNT_CONTROL_ID
            INTO V_ACCOUNT_CONTROL_ID
            FROM FI_ACCOUNT_CONTROL AC
          WHERE AC.ACCOUNT_CODE     = V_ACCOUNT_CODE
            AND AC.SOB_ID           = W_SOB_ID
          ;
        EXCEPTION 
          WHEN OTHERS THEN
            V_ACCOUNT_CONTROL_ID := -1;
        END;
    END;
    -- 2.1 부재료 기초금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_BEGIN_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '201'                       -- 부재료.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BEGIN_AMOUNT := 0;
    END;
    
    -- 2.2 부재료 입고금액.
    BEGIN
      SELECT SUM(CASE
                   WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                   WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                   ELSE 0
                 END) AS REMAIN_AMOUNT
        INTO V_THIS_IN_AMOUNT
        FROM FI_SLIP_LINE SL
          , FI_SLIP_HEADER SH
          , FI_ACCOUNT_CONTROL AC
      WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.PERIOD_NAME              = W_PERIOD_NAME
        AND SL.SOB_ID                   = W_SOB_ID
        AND SL.CONFIRM_YN               = 'Y'
        AND SH.SLIP_TYPE                <> 'CL'
        AND EXISTS (SELECT 'X'
                      FROM FI_CLOSING_ACCOUNT CA
                    WHERE CA.ACCOUNT_CONTROL_ID         = SL.ACCOUNT_CONTROL_ID
                      AND CA.SOB_ID                     = SL.SOB_ID
                      AND CA.CLOSING_GROUP              = '201'       -- 부재료.
                      AND CA.CLOSING_ACCOUNT_TYPE       = '20'        -- 당기입고.
                    )
      GROUP BY SL.PERIOD_NAME 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_IN_AMOUNT := 0;
    END;
    
    -- 2.3 부재료 타계정 출고 금액.
    BEGIN
      SELECT SUM(CASE
                   WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                   WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                   ELSE 0
                 END) AS REMAIN_AMOUNT
        INTO V_THIS_OUT_AMOUNT
        FROM FI_SLIP_LINE SL
          , FI_SLIP_HEADER SH
          , FI_ACCOUNT_CONTROL AC
      WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.PERIOD_NAME              = W_PERIOD_NAME
        AND SL.SOB_ID                   = W_SOB_ID
        AND SL.CONFIRM_YN               = 'Y'
        AND SH.SLIP_TYPE                <> 'CL'
        AND EXISTS (SELECT 'X'
                      FROM FI_CLOSING_ACCOUNT CA
                    WHERE CA.ACCOUNT_CONTROL_ID         = SL.ACCOUNT_CONTROL_ID
                      AND CA.SOB_ID                     = SL.SOB_ID
                      AND CA.CLOSING_GROUP              = '201'       -- 부재료.
                      AND CA.CLOSING_ACCOUNT_TYPE       = '30'        -- 당기출고.
                    )
      GROUP BY SL.PERIOD_NAME 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_OUT_AMOUNT := 0;
    END;
    
    -- 2.4 부재료 기말 금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_ENDING_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = W_PERIOD_NAME
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '201'                       -- 부재료.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ENDING_AMOUNT := 0;
    END;
    
    -- 당기 부재료 출고금액 산출.
    V_AMOUNT := NVL(V_BEGIN_AMOUNT, 0) + NVL(V_THIS_IN_AMOUNT, 0) - NVL(V_THIS_OUT_AMOUNT, 0) - NVL(V_ENDING_AMOUNT, 0);
    
    IF V_AMOUNT <> 0 THEN
      -- 2.9 부재료금액 INSERT.
      INSERT_CLOSING_AMOUNT( P_PERIOD_NAME => W_PERIOD_NAME
                           , P_CLOSING_GROUP => '201'
                           , P_ACCOUNT_CONTROL_ID => V_ACCOUNT_CONTROL_ID
                           , P_ACCOUNT_CODE => V_ACCOUNT_CODE
                           , P_AMOUNT => V_AMOUNT
                           , P_SOB_ID => W_SOB_ID
                           , P_ORG_ID => W_ORG_ID
                           , P_USER_ID => P_USER_ID
                           );
    END IF;
    
    -- 3. 당기 비용.
    FOR C1 IN (-- 당기 비용 ;
              SELECT CA.CLOSING_GROUP
                   , CA.ACCOUNT_CONTROL_ID
                   , CA.ACCOUNT_CODE
                FROM FI_CLOSING_ACCOUNT CA
              WHERE CA.SOB_ID                     = W_SOB_ID
                AND CA.CLOSING_ACCOUNT_TYPE       = '21'        -- 당기비용.
              )
    LOOP
      V_ACCOUNT_CONTROL_ID := C1.ACCOUNT_CONTROL_ID;
      V_ACCOUNT_CODE := C1.ACCOUNT_CODE;
      V_AMOUNT := 0;
      BEGIN
        SELECT SUM(CASE
                     WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                     WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                     ELSE 0
                   END) AS REMAIN_AMOUNT
          INTO V_AMOUNT
          FROM FI_SLIP_LINE SL
            , FI_SLIP_HEADER SH
            , FI_ACCOUNT_CONTROL AC    
        WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
          AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
          AND SL.PERIOD_NAME              = W_PERIOD_NAME
          AND SL.SOB_ID                   = W_SOB_ID
          AND SL.CONFIRM_YN               = 'Y'
          AND SH.SLIP_TYPE                <> 'CL'
          AND SL.ACCOUNT_CONTROL_ID       = V_ACCOUNT_CONTROL_ID
        GROUP BY SL.ACCOUNT_CONTROL_ID
              , SL.ACCOUNT_CODE
              , SL.PERIOD_NAME  
        ;
      EXCEPTION 
        WHEN OTHERS THEN
          V_AMOUNT := 0;
      END;
      -- 3.9 경비 INSERT.
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AMOUNT( P_PERIOD_NAME => W_PERIOD_NAME
                             , P_CLOSING_GROUP => C1.CLOSING_GROUP
                             , P_ACCOUNT_CONTROL_ID => V_ACCOUNT_CONTROL_ID
                             , P_ACCOUNT_CODE => V_ACCOUNT_CODE
                             , P_AMOUNT => V_AMOUNT
                             , P_SOB_ID => W_SOB_ID
                             , P_ORG_ID => W_ORG_ID
                             , P_USER_ID => P_USER_ID
                             );
      END IF;
    END LOOP C1;
    
    -- 5. 재공품 계정.
    V_BEGIN_AMOUNT := 0;
    V_THIS_IN_AMOUNT := 0;
    V_THIS_OUT_AMOUNT := 0;
    V_ENDING_AMOUNT := 0;
    BEGIN
      SELECT CA.ACCOUNT_CONTROL_ID
           , CA.ACCOUNT_CODE
        INTO V_ACCOUNT_CONTROL_ID
           , V_ACCOUNT_CODE
        FROM FI_CLOSING_ACCOUNT CA
      WHERE CA.CLOSING_GROUP        = '701'
        AND CA.CLOSING_ACCOUNT_TYPE = '20'
        AND ROWNUM                  <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN        
        DBMS_OUTPUT.PUT_LINE('INV ITEM : Account Code Find Error');
        V_ACCOUNT_CODE := '1120300';
        BEGIN
          SELECT AC.ACCOUNT_CONTROL_ID
            INTO V_ACCOUNT_CONTROL_ID
            FROM FI_ACCOUNT_CONTROL AC
          WHERE AC.ACCOUNT_CODE     = V_ACCOUNT_CODE
            AND AC.SOB_ID           = W_SOB_ID
          ;
        EXCEPTION 
          WHEN OTHERS THEN
            V_ACCOUNT_CONTROL_ID := -1;
        END;
    END;
    -- 5.1 재공품 기초금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_BEGIN_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '701'                       -- 재공품.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BEGIN_AMOUNT := 0;
    END;
    -- 5.2 원재료/부재료/노무비/경비 발생금액 합계 --> 재공품 입고금액.
    BEGIN
      SELECT SUM(CA.AMOUNT) AS AMOUNT
        INTO V_THIS_IN_AMOUNT
        FROM FI_CLOSING_AMOUNT CA
      WHERE CA.PERIOD_NAME              = W_PERIOD_NAME
        AND CA.SOB_ID                   = W_SOB_ID
        AND NOT EXISTS (SELECT 'X'
                          FROM FI_COMMON FC
                        WHERE FC.GROUP_CODE   = 'CLOSING_GROUP'
                          AND FC.SOB_ID       = CA.SOB_ID
                          AND FC.CODE         = CA.CLOSING_GROUP
                          AND FC.CODE         IN('701', '801')    -- 재고품(701), 제품(801)
                       )
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        V_THIS_IN_AMOUNT := 0;
    END;
    -- 5.3 재공품 타계정 출고 금액.
    BEGIN
      SELECT SUM(CASE
                   WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                   WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                   ELSE 0
                 END) AS REMAIN_AMOUNT
        INTO V_THIS_OUT_AMOUNT
        FROM FI_SLIP_LINE SL
          , FI_SLIP_HEADER SH
          , FI_ACCOUNT_CONTROL AC
      WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.PERIOD_NAME              = W_PERIOD_NAME
        AND SL.SOB_ID                   = W_SOB_ID
        AND SL.CONFIRM_YN               = 'Y'
        AND SH.SLIP_TYPE                <> 'CL'
        AND EXISTS (SELECT 'X'
                      FROM FI_CLOSING_ACCOUNT CA
                    WHERE CA.ACCOUNT_CONTROL_ID         = SL.ACCOUNT_CONTROL_ID
                      AND CA.SOB_ID                     = SL.SOB_ID
                      AND CA.CLOSING_GROUP              = '701'       -- 재공품.
                      AND CA.CLOSING_ACCOUNT_TYPE       = '30'        -- 당기출고.
                    )
      GROUP BY SL.PERIOD_NAME 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_OUT_AMOUNT := 0;
    END;
    
    -- 5.4 재공품 기말 금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_ENDING_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = W_PERIOD_NAME
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '701'                       -- 재공품.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ENDING_AMOUNT := 0;
    END;
    
    -- 당기 원재료 출고금액 산출.
    V_AMOUNT := NVL(V_BEGIN_AMOUNT, 0) + NVL(V_THIS_IN_AMOUNT, 0) - NVL(V_THIS_OUT_AMOUNT, 0) - NVL(V_ENDING_AMOUNT, 0);
    
    -- 5.9 재공품 입고금액 INSERT.
    IF V_AMOUNT <> 0 THEN
      INSERT_CLOSING_AMOUNT( P_PERIOD_NAME => W_PERIOD_NAME
                           , P_CLOSING_GROUP => '701'
                           , P_ACCOUNT_CONTROL_ID => V_ACCOUNT_CONTROL_ID
                           , P_ACCOUNT_CODE => V_ACCOUNT_CODE
                           , P_AMOUNT => V_AMOUNT
                           , P_SOB_ID => W_SOB_ID
                           , P_ORG_ID => W_ORG_ID
                           , P_USER_ID => P_USER_ID
                           );
    END IF;
    
    -- 6. 제품 계정.
    V_BEGIN_AMOUNT := 0;
    V_THIS_IN_AMOUNT := 0;
    V_THIS_OUT_AMOUNT := 0;
    V_ENDING_AMOUNT := 0;
    BEGIN
      SELECT CA.ACCOUNT_CONTROL_ID
           , CA.ACCOUNT_CODE
        INTO V_ACCOUNT_CONTROL_ID
           , V_ACCOUNT_CODE
        FROM FI_CLOSING_ACCOUNT CA
      WHERE CA.CLOSING_GROUP        = '801'
        AND CA.CLOSING_ACCOUNT_TYPE = '20'
        AND ROWNUM                  <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN        
        DBMS_OUTPUT.PUT_LINE('FG ITEM : Account Code Find Error');
        V_ACCOUNT_CODE := '1120100';
        BEGIN
          SELECT AC.ACCOUNT_CONTROL_ID
            INTO V_ACCOUNT_CONTROL_ID
            FROM FI_ACCOUNT_CONTROL AC
          WHERE AC.ACCOUNT_CODE     = V_ACCOUNT_CODE
            AND AC.SOB_ID           = W_SOB_ID
          ;
        EXCEPTION 
          WHEN OTHERS THEN
            V_ACCOUNT_CONTROL_ID := -1;
        END;
    END;
    -- 6.1 제품 기초금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_BEGIN_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '801'                       -- 제품.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BEGIN_AMOUNT := 0;
    END;
    -- 6.2 제품 입고금액.
    BEGIN
      SELECT SUM(CA.AMOUNT) AS AMOUNT
        INTO V_THIS_IN_AMOUNT
        FROM FI_CLOSING_AMOUNT CA
      WHERE CA.PERIOD_NAME              = W_PERIOD_NAME
        AND CA.SOB_ID                   = W_SOB_ID
        AND CA.CLOSING_GROUP            = '701'       -- 재고품(701), 제품(801)
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        V_THIS_IN_AMOUNT := 0;
    END;
    -- 6.3 제품 타계정 출고 금액.
    BEGIN
      SELECT SUM(CASE
                   WHEN AC.ACCOUNT_DR_CR = '1' THEN DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)
                   WHEN AC.ACCOUNT_DR_CR = '2' THEN DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) - DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)
                   ELSE 0
                 END) AS REMAIN_AMOUNT
        INTO V_THIS_OUT_AMOUNT
        FROM FI_SLIP_LINE SL
          , FI_SLIP_HEADER SH
          , FI_ACCOUNT_CONTROL AC
      WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.PERIOD_NAME              = W_PERIOD_NAME
        AND SL.SOB_ID                   = W_SOB_ID
        AND SL.CONFIRM_YN               = 'Y'
        AND SH.SLIP_TYPE                <> 'CL'
        AND EXISTS (SELECT 'X'
                      FROM FI_CLOSING_ACCOUNT CA
                    WHERE CA.ACCOUNT_CONTROL_ID         = SL.ACCOUNT_CONTROL_ID
                      AND CA.SOB_ID                     = SL.SOB_ID
                      AND CA.CLOSING_GROUP              = '801'       -- 제품.
                      AND CA.CLOSING_ACCOUNT_TYPE       = '30'        -- 당기출고.
                    )
      GROUP BY SL.PERIOD_NAME 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_OUT_AMOUNT := 0;
    END;
    
    -- 6.4 제품 기말 금액.
    BEGIN
      SELECT CEA.ENDING_AMOUNT
        INTO V_ENDING_AMOUNT
        FROM FI_CLOSING_ENDING_AMOUNT CEA
          , FI_CLOSING_ACCOUNT CA
      WHERE CEA.ACCOUNT_CONTROL_ID      = CA.ACCOUNT_CONTROL_ID
        AND CEA.SOB_ID                  = CA.SOB_ID
        AND CEA.PERIOD_NAME             = W_PERIOD_NAME
        AND CEA.SOB_ID                  = W_SOB_ID
        AND CA.CLOSING_GROUP            = '801'                       -- 제품품.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ENDING_AMOUNT := 0;
    END;
    
    -- 당기 제품 출고금액 산출.
    V_AMOUNT := NVL(V_BEGIN_AMOUNT, 0) + NVL(V_THIS_IN_AMOUNT, 0) - NVL(V_THIS_OUT_AMOUNT, 0) - NVL(V_ENDING_AMOUNT, 0);
    
    -- 6.9 재공품 입고금액 INSERT.
    IF V_AMOUNT <> 0 THEN
      INSERT_CLOSING_AMOUNT( P_PERIOD_NAME => W_PERIOD_NAME
                           , P_CLOSING_GROUP => '801'
                           , P_ACCOUNT_CONTROL_ID => V_ACCOUNT_CONTROL_ID
                           , P_ACCOUNT_CODE => V_ACCOUNT_CODE
                           , P_AMOUNT => V_AMOUNT
                           , P_SOB_ID => W_SOB_ID
                           , P_ORG_ID => W_ORG_ID
                           , P_USER_ID => P_USER_ID
                           );
    END IF;                         
  END CLOSING_AMOUNT_SET;

-- 결산금액 INSERT 계산.
  PROCEDURE INSERT_CLOSING_AMOUNT
            ( P_PERIOD_NAME         IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , P_CLOSING_GROUP       IN FI_CLOSING_AMOUNT.CLOSING_GROUP%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_CLOSING_AMOUNT.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_CLOSING_AMOUNT.ACCOUNT_CODE%TYPE
            , P_AMOUNT              IN FI_CLOSING_AMOUNT.AMOUNT%TYPE
            , P_SOB_ID              IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID             IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    INSERT INTO FI_CLOSING_AMOUNT
    ( PERIOD_NAME
    , CLOSING_GROUP
    , ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE
    , SOB_ID
    , ORG_ID
    , AMOUNT
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY
    ) VALUES
    ( P_PERIOD_NAME
    , P_CLOSING_GROUP
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_SOB_ID
    , P_ORG_ID
    , P_AMOUNT
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID
    );
  END INSERT_CLOSING_AMOUNT;

-- 결산분개 적용.
  PROCEDURE CLOSING_AUTO_JOURNAL_SET
            ( W_PERIOD_NAME       IN FI_CLOSING_AMOUNT.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_AMOUNT.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_AMOUNT.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_AMOUNT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_SLIP_DATE                   DATE;           -- 해당월 마지막일자 적용.
    V_SLIP_NUM                    VARCHAR2(30);   -- 전표번호.
    V_SLIP_TYPE                   VARCHAR2(20);
    V_ACCOUNT_BOOK_ID             NUMBER;
    V_CURRENCY_CODE               VARCHAR2(10);   -- 통화.
    
    V_DEPT_ID                     NUMBER;
    V_PERSON_ID                   NUMBER;
    
    V_TOTAL_AMOUNT                NUMBER;         -- 총누적금액.
    V_AMOUNT                      NUMBER;         -- 금액.
    
  BEGIN
    -- 해당월의 생성자료 삭제.
    BEGIN
      DELETE FROM FI_CLOSING_SLIP CS
      WHERE CS.PERIOD_NAME        = W_PERIOD_NAME  
        AND CS.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Closing Slip Delete Error : ' || SUBSTR(SQLERRM, 150));
    END;
    
    -- 기초정보 생성.
    V_SLIP_DATE := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('CL', W_SOB_ID, V_SLIP_DATE, P_USER_ID);
    V_SLIP_TYPE := 'CL';
    V_ACCOUNT_BOOK_ID := FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID);
    V_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    
    BEGIN
      SELECT EU.PERSON_ID
           , PM.DEPT_ID
        INTO V_PERSON_ID
          , V_DEPT_ID
        FROM EAPP_USER EU
          , HRM_PERSON_MASTER PM
      WHERE EU.PERSON_ID          = PM.PERSON_ID(+)
        AND EU.USER_ID            = P_USER_ID
        AND EU.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        V_PERSON_ID := -1;
        V_DEPT_ID := -1;  
    END;
    
    -- 1.1 원재료 분개.
    V_AMOUNT := 0;
    BEGIN
      SELECT CA.AMOUNT
        INTO V_AMOUNT
        FROM FI_CLOSING_AMOUNT CA
      WHERE CA.PERIOD_NAME        = W_PERIOD_NAME
        AND CA.SOB_ID             = W_SOB_ID
        AND CA.CLOSING_GROUP      = '101'
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_AMOUNT := 0;        
    END;
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '101'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 2.1 부재료 분개.
    V_AMOUNT := 0;
    BEGIN
      SELECT CA.AMOUNT
        INTO V_AMOUNT
        FROM FI_CLOSING_AMOUNT CA
      WHERE CA.PERIOD_NAME        = W_PERIOD_NAME
        AND CA.SOB_ID             = W_SOB_ID
        AND CA.CLOSING_GROUP      = '201'
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_AMOUNT := 0;        
    END;    
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '201'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 3.1 기타경비.
    V_TOTAL_AMOUNT := 0;
    V_AMOUNT := 0;
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '301'
                  AND AJ.CONTRA_ACCOUNT_FLAG  <> 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      V_AMOUNT := 0;
      BEGIN
        SELECT CA.AMOUNT
          INTO V_AMOUNT
          FROM FI_CLOSING_AMOUNT CA
        WHERE CA.PERIOD_NAME        = W_PERIOD_NAME
          AND CA.SOB_ID             = W_SOB_ID
          AND CA.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
          AND CA.CLOSING_GROUP      = '301'
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_AMOUNT := 0;        
      END;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_AMOUNT, 0);
      
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 3.2 기타경비 - 대체계정.
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '301'
                  AND AJ.CONTRA_ACCOUNT_FLAG  = 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      IF V_TOTAL_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_TOTAL_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 7.1 재공품.
    V_TOTAL_AMOUNT := 0;
    V_AMOUNT := 0;
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '701'
                  AND AJ.CONTRA_ACCOUNT_FLAG  <> 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      V_AMOUNT := 0;
      BEGIN
        SELECT SUM(DECODE(FCS.ACCOUNT_DR_CR, '1', FCS.GL_AMOUNT)) AS DR_AMOUNT
          INTO V_AMOUNT
          FROM FI_CLOSING_SLIP FCS
        WHERE FCS.PERIOD_NAME           = W_PERIOD_NAME
          AND FCS.SOB_ID                = W_SOB_ID
          AND FCS.ACCOUNT_CONTROL_ID    = C1.ACCOUNT_CONTROL_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_AMOUNT := 0;        
      END;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_AMOUNT, 0);
      
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 7.2 재공품 - 대체계정.
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '701'
                  AND AJ.CONTRA_ACCOUNT_FLAG  = 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      IF V_TOTAL_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_TOTAL_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 8.1 제품.
    V_TOTAL_AMOUNT := 0;
    V_AMOUNT := 0;
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '801'
                  AND AJ.CONTRA_ACCOUNT_FLAG  <> 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      V_AMOUNT := 0;
      BEGIN
        SELECT SUM(CA.AMOUNT) AS AMOUNT
          INTO V_AMOUNT
          FROM FI_CLOSING_AMOUNT CA
        WHERE CA.PERIOD_NAME            = W_PERIOD_NAME
          AND CA.SOB_ID                 = W_SOB_ID
          AND CA.ACCOUNT_CONTROL_ID     = C1.ACCOUNT_CONTROL_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_AMOUNT := 0;        
      END;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_AMOUNT, 0);
      
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 8.2 제품 - 대체계정.
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '801'
                  AND AJ.CONTRA_ACCOUNT_FLAG  = 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      IF V_TOTAL_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_TOTAL_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 9.1 제품 --> 제품매출원가.
    V_TOTAL_AMOUNT := 0;
    V_AMOUNT := 0;
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '901'
                  AND AJ.CONTRA_ACCOUNT_FLAG  <> 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      V_AMOUNT := 0;
      BEGIN
        SELECT SUM(CA.AMOUNT) AS AMOUNT
          INTO V_AMOUNT
          FROM FI_CLOSING_AMOUNT CA
        WHERE CA.PERIOD_NAME            = W_PERIOD_NAME
          AND CA.SOB_ID                 = W_SOB_ID
          AND CA.ACCOUNT_CONTROL_ID     = C1.ACCOUNT_CONTROL_ID
        ;
      EXCEPTION
        WHEN OTHERS THEN
          V_AMOUNT := 0;        
      END;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_AMOUNT, 0);
      
      IF V_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
    -- 98.2 제품매출원가 - 대체계정.
    FOR C1 IN ( SELECT AJ.SOB_ID  
                     , AJ.ACCOUNT_CONTROL_ID
                     , AJ.ACCOUNT_CODE
                     , AJ.ACCOUNT_DR_CR
                     , AJ.REMARK
                  FROM FI_CLOSING_AUTO_JOURNAL AJ
                WHERE AJ.SOB_ID         = W_SOB_ID
                  AND AJ.CLOSING_GROUP  = '901'
                  AND AJ.CONTRA_ACCOUNT_FLAG  = 'Y'
                ORDER BY AJ.JOURNAL_ID
               )
    LOOP
      IF V_TOTAL_AMOUNT <> 0 THEN
        INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME => W_PERIOD_NAME
            , P_SLIP_DATE => V_SLIP_DATE
            , P_SLIP_NUM => V_SLIP_NUM
            , P_SOB_ID => W_SOB_ID
            , P_ORG_ID => W_ORG_ID
            , P_DEPT_ID => V_DEPT_ID
            , P_PERSON_ID => V_PERSON_ID
            , P_BUDGET_DEPT_ID => NULL
            , P_ACCOUNT_BOOK_ID => V_ACCOUNT_BOOK_ID
            , P_SLIP_TYPE => V_SLIP_TYPE
            , P_ACCOUNT_CONTROL_ID => C1.ACCOUNT_CONTROL_ID
            , P_ACCOUNT_CODE => C1.ACCOUNT_CODE
            , P_ACCOUNT_DR_CR => C1.ACCOUNT_DR_CR
            , P_GL_AMOUNT => V_TOTAL_AMOUNT
            , P_CURRENCY_CODE => V_CURRENCY_CODE
            , P_REMARK => C1.REMARK
            , P_SYSDATE => V_SYSDATE
            , P_USER_ID => P_USER_ID          
            );
      END IF;
    END LOOP C1;
    
  END CLOSING_AUTO_JOURNAL_SET;
  
-- 결산분개 INSERT.
  PROCEDURE INSERT_CLOSING_AUTO_JOURNAL
            ( P_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , P_SLIP_DATE         IN FI_CLOSING_SLIP.SLIP_DATE%TYPE
            , P_SLIP_NUM          IN FI_CLOSING_SLIP.SLIP_NUM%TYPE
            , P_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , P_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_DEPT_ID           IN FI_CLOSING_SLIP.DEPT_ID%TYPE
            , P_PERSON_ID         IN FI_CLOSING_SLIP.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID    IN FI_CLOSING_SLIP.BUDGET_DEPT_ID%TYPE
            , P_ACCOUNT_BOOK_ID   IN FI_CLOSING_SLIP.ACCOUNT_BOOK_ID%TYPE
            , P_SLIP_TYPE         IN FI_CLOSING_SLIP.SLIP_TYPE%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_CLOSING_SLIP.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE      IN FI_CLOSING_SLIP.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR     IN FI_CLOSING_SLIP.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT         IN FI_CLOSING_SLIP.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE     IN FI_CLOSING_SLIP.CURRENCY_CODE%TYPE
            , P_REMARK            IN FI_CLOSING_SLIP.REMARK%TYPE
            , P_SYSDATE           IN FI_CLOSING_SLIP.CREATION_DATE%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            )
  AS
    V_SLIP_LINE_SEQ               NUMBER;
  BEGIN
    BEGIN
      SELECT NVL(MAX(CS.SLIP_LINE_SEQ), 0) + 1 AS SLIP_LINE_SEQ
        INTO V_SLIP_LINE_SEQ
        FROM FI_CLOSING_SLIP CS
      WHERE CS.PERIOD_NAME        = P_PERIOD_NAME 
        AND CS.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_SLIP_LINE_SEQ := 1;
    END;
    INSERT INTO FI_CLOSING_SLIP
    ( PERIOD_NAME
    , SLIP_DATE
    , SLIP_NUM
    , SLIP_LINE_SEQ
    , SOB_ID
    , ORG_ID
    , DEPT_ID
    , PERSON_ID
    , BUDGET_DEPT_ID
    , ACCOUNT_BOOK_ID
    , SLIP_TYPE
    , ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE
    , ACCOUNT_DR_CR
    , GL_AMOUNT
    , CURRENCY_CODE
    , REMARK
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY    
    ) VALUES
    ( P_PERIOD_NAME
    , P_SLIP_DATE
    , P_SLIP_NUM
    , V_SLIP_LINE_SEQ
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPT_ID
    , P_PERSON_ID
    , P_BUDGET_DEPT_ID
    , P_ACCOUNT_BOOK_ID
    , P_SLIP_TYPE
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_ACCOUNT_DR_CR
    , P_GL_AMOUNT
    , P_CURRENCY_CODE
    , P_REMARK
    , P_SYSDATE
    , P_USER_ID
    , P_SYSDATE
    , P_USER_ID
    );  
  END INSERT_CLOSING_AUTO_JOURNAL;

-- 결산분개 전표 INSERT.
  PROCEDURE INSERT_CLOSING_SLIP
            ( W_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SLIP_HEADER_ID              FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE;
    V_SLIP_LINE_ID                FI_SLIP_LINE.SLIP_LINE_ID%TYPE;
    
  BEGIN
    -- 기존 자료 삭제.
    DELETE_CLOSING_SLIP
          ( W_PERIOD_NAME
          , W_SOB_ID
          , W_ORG_ID
          , P_USER_ID
          );
          
    -- HEADER INSERT.
    FOR C1 IN ( SELECT DISTINCT CS.SLIP_DATE
                    , CS.SLIP_NUM
                    , CS.SOB_ID
                    , CS.ORG_ID
                    , CS.DEPT_ID
                    , CS.PERSON_ID
                    , CS.BUDGET_DEPT_ID
                    , CS.SLIP_TYPE
                    , CS.SLIP_DATE AS GL_DATE
                    , CS.SLIP_NUM AS GL_NUM
                    , 'I' AS CREATE_TYPE
                    , 'FI_CLOSING_SLIP' AS SOURCE_TABLE
                  FROM FI_CLOSING_SLIP CS
                WHERE CS.PERIOD_NAME          = W_PERIOD_NAME
                  AND CS.SOB_ID               = W_SOB_ID
                  AND ROWNUM                  <= 1
               )
    LOOP
      -- HEADER INSERT.
      FI_SLIP_G.INSERT_SLIP_HEADER
            ( V_SLIP_HEADER_ID
            , C1.SLIP_DATE
            , C1.SLIP_NUM
            , C1.SOB_ID
            , C1.ORG_ID
            , C1.DEPT_ID
            , C1.PERSON_ID
            , C1.BUDGET_DEPT_ID
            , C1.SLIP_TYPE
            , C1.SLIP_DATE          -- GL_DATE.
            , C1.SLIP_NUM           -- GL_NUM.
            , NULL
            , NULL
            , NULL
            , NULL
            , P_USER_ID
            , C1.CREATE_TYPE                   -- CREATE_TYPE
            , C1.SOURCE_TABLE
            , NULL
            );    
    END LOOP C1;
    -- HEADER ID UPDATE.
    BEGIN
      UPDATE FI_CLOSING_SLIP CS
        SET CS.ATTRIUTE_1       = V_SLIP_HEADER_ID
      WHERE CS.PERIOD_NAME      = W_PERIOD_NAME
        AND CS.SOB_ID           = W_SOB_ID
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Slip header update error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- LINE INSERT.
    FOR C1 IN ( SELECT CS.SLIP_LINE_SEQ
                    , CS.SLIP_DATE
                    , CS.SLIP_NUM
                    , CS.SOB_ID
                    , CS.ORG_ID
                    , CS.DEPT_ID
                    , CS.PERSON_ID
                    , CS.BUDGET_DEPT_ID
                    , CS.SLIP_TYPE
                    , CS.SLIP_DATE AS GL_DATE
                    , CS.SLIP_NUM AS GL_NUM
                    , CS.ACCOUNT_CONTROL_ID
                    , CS.ACCOUNT_CODE
                    , CS.ACCOUNT_DR_CR
                    , CS.GL_AMOUNT
                    , CS.CURRENCY_CODE
                    , CS.EXCHANGE_RATE
                    , CS.GL_CURRENCY_AMOUNT
                    , CS.MANAGEMENT1
                    , CS.MANAGEMENT2
                    , CS.REFER1
                    , CS.REFER2
                    , CS.REFER3
                    , CS.REFER4
                    , CS.REFER5
                    , CS.REFER6
                    , CS.REFER7
                    , CS.REFER8
                    , CS.REFER9
                    , CS.REMARK
                  FROM FI_CLOSING_SLIP CS
                WHERE CS.PERIOD_NAME          = W_PERIOD_NAME
                  AND CS.SOB_ID               = W_SOB_ID
               )
    LOOP
      -- LINE INSERT.
      FI_SLIP_G.INSERT_SLIP_LINE
            ( V_SLIP_LINE_ID
            , V_SLIP_HEADER_ID
            , W_SOB_ID
            , W_ORG_ID
            , C1.ACCOUNT_CONTROL_ID
            , C1.ACCOUNT_CODE
            , C1.ACCOUNT_DR_CR
            , C1.GL_AMOUNT 
            , C1.CURRENCY_CODE 
            , C1.EXCHANGE_RATE
            , C1.GL_CURRENCY_AMOUNT
            , C1.MANAGEMENT1
            , C1.MANAGEMENT2
            , C1.REFER1
            , C1.REFER2
            , C1.REFER3
            , C1.REFER4
            , C1.REFER5
            , C1.REFER6
            , C1.REFER7
            , C1.REFER8
            , C1.REFER9
            , C1.REMARK
            , NULL                         -- UNLIQUIDATE_SLIP_HEADER_ID
            , NULL                         -- UNLIQUIDATE_SLIP_LINE_ID
            , P_USER_ID
            , NULL                         -- LINE_TYPE
            , 'FI_CLOSING_SLIP'            -- SOURCE_TABLE
            , NULL                         -- SOURCE_HEADER_ID
            , NULL                         -- SOURCE_LINE_ID
            );
      -- LINE ID UPDATE.
      BEGIN
        UPDATE FI_CLOSING_SLIP CS
          SET CS.ATTRIUTE_2       = V_SLIP_LINE_ID
        WHERE CS.PERIOD_NAME      = W_PERIOD_NAME
          AND CS.SOB_ID           = W_SOB_ID
          AND CS.SLIP_LINE_SEQ    = C1.SLIP_LINE_SEQ
        ;
      EXCEPTION 
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Slip line update error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    O_MESSAGE := '생성 완료';
    
  END INSERT_CLOSING_SLIP;

-- 결산분개 전표 DELETE.
  PROCEDURE DELETE_CLOSING_SLIP
            ( W_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            )
  AS
  BEGIN
    -- heder delete.
    BEGIN
      DELETE FROM FI_SLIP_HEADER SH
      WHERE SH.PERIOD_NAME      = W_PERIOD_NAME
        AND SH.SOB_ID           = W_SOB_ID
        AND SH.SLIP_TYPE        = 'CL'
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Slip header delete error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- line delete.
      BEGIN
        DELETE FROM FI_SLIP_LINE SL
        WHERE SL.PERIOD_NAME      = W_PERIOD_NAME
          AND SL.SOB_ID           = W_SOB_ID
          AND SL.SLIP_TYPE        = 'CL'
        ;
      EXCEPTION 
        WHEN OTHERS THEN
          DBMS_OUTPUT.PUT_LINE('Slip line delete error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    
  END DELETE_CLOSING_SLIP;

-- 결산분개 전표 CANCEL.
  PROCEDURE CANCEL_CLOSING_SLIP
            ( W_PERIOD_NAME       IN FI_CLOSING_SLIP.PERIOD_NAME%TYPE
            , W_SOB_ID            IN FI_CLOSING_SLIP.SOB_ID%TYPE
            , W_ORG_ID            IN FI_CLOSING_SLIP.ORG_ID%TYPE
            , P_USER_ID           IN FI_CLOSING_SLIP.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
  BEGIN
    NULL;
    
  END CANCEL_CLOSING_SLIP;
              
END FI_CLOSING_SET_G;
/
