CREATE OR REPLACE PACKAGE FI_BUDGET_G
AS

-- ������� ��ȸ.
  PROCEDURE SELECT_BUDGET
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_BUDGET_YEAR         IN VARCHAR2
            , P_DEPT_CODE_FR        IN VARCHAR2
            , P_DEPT_CODE_TO        IN VARCHAR2
            , P_ACCOUNT_CONTROL_ID  IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_BUDGET_CONTROL_YN   IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_CHECK_CAPACITY      IN VARCHAR2
            , P_SOB_ID              IN FI_BUDGET.SOB_ID%TYPE
            );

-- ������� FLAG ����.
  PROCEDURE UPDATE_BUDGET
            ( W_BUDGET_PERIOD      IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID            IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET.SOB_ID%TYPE
            , W_ORG_ID             IN FI_BUDGET.ORG_ID%TYPE
            , P_MOVE_YN            IN FI_BUDGET.MOVE_YN%TYPE
            , P_NEXT_YN            IN FI_BUDGET.NEXT_YN%TYPE
            , P_ENABLED_YN         IN FI_BUDGET.ENABLED_YN%TYPE
            , P_DESCRIPTION        IN FI_BUDGET.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET.CREATED_BY%TYPE 
            );

-- ������� �̿������� ���� �ܾ� �̿� ó��.
  PROCEDURE EXE_BUDGET_NEXT_PERIOD
            ( W_PERIOD_NAME          IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID              IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- ������� �ش�� ���� ó��.
  PROCEDURE EXE_BUDGET_CLOSE
            ( W_PERIOD_NAME          IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID              IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-----------------------------------------------------------------------------------------
-- (��)������ ���ݾ� ����.
  FUNCTION MONTH_USE_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER;
            
-- ���� ���ݾ� ����.
  FUNCTION BUDGET_USE_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER;
            
-- ���� �ܾ� ���� - ���� ��� �̿��ݾ� ����.
  FUNCTION BUDGET_REMAIN_AMOUNT_NEXT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER;

-- (��)�� ���� �ܾ� ����.
  FUNCTION MONTH_REMAIN_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER;
                                    
-- (���Ⱓ)���� �ܾ� ����.
  FUNCTION BUDGET_REMAIN_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER;

-- ������� �ش�� �̸��� ���� üũ.
  FUNCTION BUDGET_CLOSED_NO_F
            ( W_PERIOD_NAME          IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID              IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN VARCHAR2;
            
--����[��û/����] Ȯ�� ���� --> ������� �ݿ�.
  PROCEDURE SAVE_BUDGET_CONFIRM
            ( W_GB                  IN VARCHAR2
            , W_BUDGET_TYPE         IN FI_BUDGET_ADD.BUDGET_TYPE%TYPE
            , W_BUDGET_PERIOD       IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID             IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID  IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET.SOB_ID%TYPE
            , P_CREATE_SEQ          IN NUMBER
            , P_BUDGET_PERIOD_FR    IN VARCHAR2
            , P_BUDGET_PERIOD_TO    IN VARCHAR2
            , P_START_DATE          IN DATE
            , P_END_DATE            IN DATE
            , P_AMOUNT              IN FI_BUDGET_ADD.AMOUNT%TYPE
            , P_USER_ID             IN FI_BUDGET.CREATED_BY%TYPE
            );
            
END FI_BUDGET_G; 
 
/
CREATE OR REPLACE PACKAGE BODY FI_BUDGET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUDGET_G
/* Description  : �����������.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- ������� ��ȸ.
  PROCEDURE SELECT_BUDGET
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_BUDGET_YEAR         IN VARCHAR2
            , P_DEPT_CODE_FR        IN VARCHAR2
            , P_DEPT_CODE_TO        IN VARCHAR2
            , P_ACCOUNT_CONTROL_ID  IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_BUDGET_CONTROL_YN   IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_CHECK_CAPACITY      IN VARCHAR2
            , P_SOB_ID              IN FI_BUDGET.SOB_ID%TYPE
            )
  AS
    V_CONNECT_PERSON_ID              NUMBER;
    V_STD_START_DATE                 DATE;                   -- ������ ������ ���� ���� ����.
    V_STD_END_DATE                   DATE;
  BEGIN
    -- ���� ����� ���� üũ.
    IF P_CHECK_CAPACITY = 'Y' AND FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := P_CONNECT_PERSON_ID;
    END IF;
                                        
    -- �ش� �⵵�� ���� �Ⱓ ��ȸ.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(P_BUDGET_YEAR, P_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN GROUPING(DM.DEPT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10064', NULL)
               WHEN GROUPING(FB.BUDGET_PERIOD) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)
               ELSE FB.BUDGET_PERIOD
             END AS BUDGET_PERIOD
           , DM.DEPT_NAME AS DEPT_NAME
           , DM.DEPT_CODE
           , TO_CHAR(FB.DEPT_ID) AS DEPT_ID
           , FB.ACCOUNT_CODE
           , TO_CHAR(FB.ACCOUNT_CONTROL_ID) AS ACCOUNT_CONTROL_ID
           , FB.BUDGET_PERIOD_FR
           , FB.BUDGET_PERIOD_TO
           , SUM(NVL(FB.PRE_NEXT_AMOUNT, 0)) AS PRE_NEXT_AMOUNT
           , SUM(NVL(FB.BASE_AMOUNT, 0)) AS BASE_AMOUNT
           , SUM(FB.ADD_AMOUNT) AS ADD_AMOUNT
           , SUM(FB.MOVE_AMOUNT) AS MOVE_AMOUNT
           , SUM(NVL(FB.PRE_NEXT_AMOUNT, 0) + NVL(FB.BASE_AMOUNT, 0) + NVL(FB.ADD_AMOUNT, 0) + NVL(FB.MOVE_AMOUNT, 0)) AS TOTAL_AMOUNT
           , SUM(NVL(FB.NEXT_AMOUNT, 0)) AS NEXT_AMOUNT
           , SUM(FI_BUDGET_G.MONTH_USE_AMOUNT_F(FB.BUDGET_PERIOD, FB.DEPT_ID, FB.ACCOUNT_CONTROL_ID, FB.SOB_ID)) AS USE_AMOUNT
           , SUM(FI_BUDGET_G.MONTH_REMAIN_AMOUNT_F(FB.BUDGET_PERIOD, FB.DEPT_ID, FB.ACCOUNT_CONTROL_ID, FB.SOB_ID)) AS REMAIN_AMOUNT
           , FB.BASE_MONTH_YN
           , FB.MOVE_YN
           , FB.NEXT_YN
           , FB.ENABLED_YN
           , FB.CLOSED_YN
           , FB.DESCRIPTION
        FROM FI_BUDGET FB
          , FI_BUDGET_ACCOUNT BA
          , FI_DEPT_MASTER DM
       WHERE FB.ACCOUNT_CONTROL_ID      = BA.ACCOUNT_CONTROL_ID
         AND FB.DEPT_ID                 = DM.DEPT_ID
         AND FB.SOB_ID                  = DM.SOB_ID
         AND FB.BUDGET_PERIOD           BETWEEN TO_CHAR(V_STD_START_DATE, 'YYYY-MM') AND TO_CHAR(V_STD_END_DATE, 'YYYY-MM')
         AND FB.ACCOUNT_CONTROL_ID      = P_ACCOUNT_CONTROL_ID
         AND FB.SOB_ID                  = P_SOB_ID
         AND BA.CONTROL_YN              = DECODE(P_BUDGET_CONTROL_YN, 'Y', 'Y', BA.CONTROL_YN)
         AND DM.DEPT_CODE               BETWEEN NVL(P_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(P_DEPT_CODE_TO, DM.DEPT_CODE)
         AND EXISTS 
               ( SELECT 'X'
                   FROM FI_BUDGET_CONTROL BC
                 WHERE BC.DEPT_ID         = DM.DEPT_ID
                   AND BC.PERSON_ID       = NVL(V_CONNECT_PERSON_ID, BC.PERSON_ID)
               )
       GROUP BY ROLLUP((DM.DEPT_CODE
                   , DM.DEPT_NAME 
                   , FB.DEPT_ID
                   , FB.BUDGET_PERIOD_FR
                   , FB.BUDGET_PERIOD_TO)
                   , (FB.BUDGET_PERIOD
                   , FB.ACCOUNT_CODE
                   , FB.ACCOUNT_CONTROL_ID
                   , FB.BASE_MONTH_YN
                   , FB.MOVE_YN
                   , FB.NEXT_YN
                   , FB.ENABLED_YN
                   , FB.CLOSED_YN
                   , FB.DESCRIPTION))
       ORDER BY DM.DEPT_CODE
       ;
  END SELECT_BUDGET;

-- ������� FLAG ����.
  PROCEDURE UPDATE_BUDGET
            ( W_BUDGET_PERIOD      IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID            IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET.SOB_ID%TYPE
            , W_ORG_ID             IN FI_BUDGET.ORG_ID%TYPE
            , P_MOVE_YN            IN FI_BUDGET.MOVE_YN%TYPE
            , P_NEXT_YN            IN FI_BUDGET.NEXT_YN%TYPE
            , P_ENABLED_YN         IN FI_BUDGET.ENABLED_YN%TYPE
            , P_DESCRIPTION        IN FI_BUDGET.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE FI_BUDGET
    SET MOVE_YN            = P_MOVE_YN
      , NEXT_YN            = P_NEXT_YN
      , ENABLED_YN         = P_ENABLED_YN
      , DESCRIPTION        = P_DESCRIPTION
      , LAST_UPDATE_DATE   = V_SYSDATE
      , LAST_UPDATED_BY    = P_USER_ID
    WHERE BUDGET_PERIOD         = W_BUDGET_PERIOD
      AND DEPT_ID               = W_DEPT_ID
      AND ACCOUNT_CONTROL_ID    = W_ACCOUNT_CONTROL_ID
      AND SOB_ID                = W_SOB_ID
    ;
  END UPDATE_BUDGET;

-- ������� �̿������� ���� �ܾ� �̿� ó��.
  PROCEDURE EXE_BUDGET_NEXT_PERIOD
            ( W_PERIOD_NAME          IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID              IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET.CREATED_BY%TYPE 
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_START_DATE              DATE;
    V_END_DATE                DATE;
    
    V_NEXT_PERIOD_NAME        VARCHAR2(7);    -- ���� ���.
    V_NEXT_START_DATE         DATE;
    V_NEXT_END_DATE           DATE;
    V_NEXT_AMOUNT             NUMBER := 0;    -- �̿� �ݾ�.
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    
    V_NEXT_PERIOD_NAME := TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 1), 'YYYY-MM');
    V_NEXT_START_DATE := TRUNC(TO_DATE(V_NEXT_PERIOD_NAME, 'YYYY-MM'), 'MONTH');
    V_NEXT_END_DATE := LAST_DAY(TO_DATE(V_NEXT_PERIOD_NAME, 'YYYY-MM'));
    
    FOR C1 IN ( SELECT FB.BUDGET_PERIOD
                     , FB.DEPT_ID
                     , FB.ACCOUNT_CONTROL_ID
                     , FB.ACCOUNT_CODE
                     , FB.SOB_ID
                     , FB.ORG_ID
                     , FB.NEXT_YN
                  FROM FI_BUDGET FB
                WHERE FB.BUDGET_PERIOD          = W_PERIOD_NAME
                  AND FB.DEPT_ID                = NVL(W_DEPT_ID, FB.DEPT_ID)
                  AND FB.ACCOUNT_CONTROL_ID     = NVL(W_ACCOUNT_CONTROL_ID, FB.ACCOUNT_CONTROL_ID)
                  AND FB.SOB_ID                 = W_SOB_ID
                  AND FB.ENABLED_YN             = 'Y'
                )
    LOOP
      -- �̿��ݾ� ����.
      V_NEXT_AMOUNT := 0;
      IF C1.NEXT_YN = 'Y' THEN
        V_NEXT_AMOUNT := FI_BUDGET_G.BUDGET_REMAIN_AMOUNT_NEXT_F
                           ( C1.BUDGET_PERIOD
                           , C1.DEPT_ID
                           , C1.ACCOUNT_CONTROL_ID
                           , C1.SOB_ID
                           );
      END IF;
      -- �����ܾױݾ� => �̿��ݾ� ����.
      UPDATE FI_BUDGET FB
        SET FB.NEXT_AMOUNT        = V_NEXT_AMOUNT
          , FB.LAST_UPDATE_DATE   = V_SYSDATE
          , FB.LAST_UPDATED_BY    = P_USER_ID
      WHERE FB.BUDGET_PERIOD      = C1.BUDGET_PERIOD
        AND FB.DEPT_ID            = C1.DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_BUDGET
        ( BUDGET_PERIOD
        , DEPT_ID
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE
        , SOB_ID			
        , ORG_ID			
        , START_DATE
        , END_DATE
        , NEXT_AMOUNT
        , CREATION_DATE			
        , CREATED_BY			
        , LAST_UPDATE_DATE			
        , LAST_UPDATED_BY		
        )
        SELECT V_NEXT_PERIOD_NAME
             , C1.DEPT_ID
             , C1.ACCOUNT_CONTROL_ID
             , AC.ACCOUNT_CODE
             , C1.SOB_ID
             , AC.ORG_ID
             , V_START_DATE AS START_DATE
             , V_END_DATE AS END_DATE
             , V_NEXT_AMOUNT
             , V_SYSDATE
             , P_USER_ID
             , V_SYSDATE
             , P_USER_ID
          FROM FI_ACCOUNT_CONTROL AC
        WHERE AC.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
          AND AC.SOB_ID             = C1.SOB_ID
        ;
      END IF;
-----------------------------------------------------------------------------------------        
      -- �����ܾ� ���� ��� �̿�.
      UPDATE FI_BUDGET FB
        SET FB.PRE_NEXT_AMOUNT    = V_NEXT_AMOUNT
          , FB.LAST_UPDATE_DATE   = V_SYSDATE
          , FB.LAST_UPDATED_BY    = P_USER_ID
      WHERE FB.BUDGET_PERIOD      = V_NEXT_PERIOD_NAME
        AND FB.DEPT_ID            = C1.DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_BUDGET
        ( BUDGET_PERIOD
        , DEPT_ID
        , ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE
        , SOB_ID			
        , ORG_ID			
        , START_DATE
        , END_DATE
        , PRE_NEXT_AMOUNT
        , CREATION_DATE			
        , CREATED_BY			
        , LAST_UPDATE_DATE			
        , LAST_UPDATED_BY		
        )
        SELECT V_NEXT_PERIOD_NAME
             , C1.DEPT_ID
             , C1.ACCOUNT_CONTROL_ID
             , AC.ACCOUNT_CODE
             , C1.SOB_ID
             , AC.ORG_ID
             , V_NEXT_START_DATE AS START_DATE
             , V_NEXT_END_DATE AS END_DATE
             , V_NEXT_AMOUNT
             , V_SYSDATE
             , P_USER_ID
             , V_SYSDATE
             , P_USER_ID
          FROM FI_ACCOUNT_CONTROL AC
        WHERE AC.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
          AND AC.SOB_ID             = C1.SOB_ID
        ;
      END IF;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_NEXT_PERIOD;

-- ������� �ش�� ���� ó��.
  PROCEDURE EXE_BUDGET_CLOSE
            ( W_PERIOD_NAME          IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID              IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_PERSON_ID               NUMBER;
  BEGIN
    IF BUDGET_CLOSED_NO_F
         ( W_PERIOD_NAME
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL));
      RETURN;
    END IF;
    
    -- ����ó��.
    UPDATE FI_BUDGET
    SET CLOSED_YN          = 'Y'
      , CLOSED_DATE        = SYSDATE
      , CLOSED_PERSON_ID   = P_CONNECT_PERSON_ID
    WHERE BUDGET_PERIOD         = W_PERIOD_NAME
      AND DEPT_ID               = NVL(W_DEPT_ID, DEPT_ID)
      AND ACCOUNT_CONTROL_ID    = NVL(W_ACCOUNT_CONTROL_ID, ACCOUNT_CONTROL_ID)
      AND SOB_ID                = W_SOB_ID
      AND CLOSED_YN             = 'N'
    ;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_CLOSE;
  
-----------------------------------------------------------------------------------------
-- (��)������ ���ݾ� ����.
  FUNCTION MONTH_USE_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_START_DATE     DATE;
    V_END_DATE       DATE;
    V_USE_AMOUNT     NUMBER := 0;
  BEGIN
    -- �Ⱓ ����.
    V_START_DATE := TRUNC(TO_DATE(W_BUDGET_PERIOD, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_BUDGET_PERIOD, 'YYYY-MM'));
    
    -- ���ݾ�.
    BEGIN
      /*SELECT SUM(DECODE(AC.ACCOUNT_DR_CR, SL.ACCOUNT_DR_CR, SL.GL_AMOUNT, 0)) AS USE_AMOUNT  -- ���� ����� ��ǥ ���밡 ���� �Ұ�츸 ����(�߻�)
        INTO V_USE_AMOUNT
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_SLIP_LINE_BUDGET SL
          , FI_ACCOUNT_CONTROL AC
      WHERE SH.HEADER_ID          = SL.HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND SH.GL_DATE            BETWEEN V_START_DATE AND V_END_DATE
        AND SL.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND SH.BUDGET_DEPT_ID     = W_DEPT_ID
        AND SH.SOB_ID             = W_SOB_ID
      ;*/
      SELECT SUM(DECODE(AC.ACCOUNT_DR_CR, SL.ACCOUNT_DR_CR, SL.GL_AMOUNT, 0)) AS USE_AMOUNT  -- ���� ����� ��ǥ ���밡 ���� �Ұ�츸 ����(�߻�)
        INTO V_USE_AMOUNT
        FROM FI_SLIP_HEADER_INTERFACE SH
          , FI_SLIP_LINE_INTERFACE SL
          , FI_ACCOUNT_CONTROL AC
      WHERE SH.HEADER_INTERFACE_ID  = SL.HEADER_INTERFACE_ID
        AND SL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND SH.GL_DATE            BETWEEN V_START_DATE AND V_END_DATE
        AND SL.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND SH.BUDGET_DEPT_ID     = W_DEPT_ID
        AND SH.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_USE_AMOUNT := 0;
    END;
    
    /*-- ���ݾ� : ��� ���� - ���Ǻμ��� ���� üũ(�����׸����� ����üũ ����).
    BEGIN
      SELECT SUM(DECODE(AC.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) +
             DECODE(AC.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)) AS USE_AMOUNT
        INTO V_USE_AMOUNT
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MANAGEMENT_ITEM SMI
          , FI_MANAGEMENT_CODE_V MC
          , FI_DEPT_MASTER DM
      WHERE SH.SLIP_HEADER_ID     = SL.SLIP_HEADER_ID
        AND SL.SLIP_LINE_ID       = SMI.SLIP_LINE_ID
        AND SL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND SMI.MANAGEMENT_ID     = MC.MANAGEMENT_ID
        AND SMI.MANAGEMENT_VALUE  = DM.DEPT_CODE
        AND SMI.SOB_ID            = DM.SOB_ID
        AND MC.LOOKUP_TYPE        = 'DEPT'                -- �μ�.
        AND SH.GL_DATE            BETWEEN V_START_DATE AND V_END_DATE
        AND SL.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND DM.DEPT_ID            = W_DEPT_ID
        AND SH.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_USE_AMOUNT := 0;
    END;*/
    RETURN V_USE_AMOUNT;
  END MONTH_USE_AMOUNT_F;
            
-- (���Ⱓ)���� ���ݾ� ����.
  FUNCTION BUDGET_USE_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_START_DATE     DATE;
    V_END_DATE       DATE;
    V_USE_AMOUNT     NUMBER := 0;
  BEGIN
    -- �Ⱓ ����.
    BEGIN
      SELECT FB.START_DATE
           , FB.END_DATE
        INTO V_START_DATE
           , V_END_DATE
        FROM FI_BUDGET FB
      WHERE FB.BUDGET_PERIOD      = W_BUDGET_PERIOD
        AND FB.DEPT_ID            = W_DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := TRUNC(TO_DATE(W_BUDGET_PERIOD, 'YYYY-MM'), 'MONTH');
      V_END_DATE := LAST_DAY(TO_DATE(W_BUDGET_PERIOD, 'YYYY-MM'));
    END;
    -- ���ݾ�.
    BEGIN
      /*SELECT SUM(DECODE(AC.ACCOUNT_DR_CR, SL.ACCOUNT_DR_CR, SL.GL_AMOUNT, 0)) AS USE_AMOUNT  -- ���� ����� ��ǥ ���밡 ���� �Ұ�츸 ����(�߻�)
        INTO V_USE_AMOUNT
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_SLIP_LINE_BUDGET SL
          , FI_ACCOUNT_CONTROL AC
      WHERE SH.HEADER_ID          = SL.HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND SH.GL_DATE            BETWEEN V_START_DATE AND V_END_DATE
        AND SL.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND SH.BUDGET_DEPT_ID     = W_DEPT_ID
        AND SH.SOB_ID             = W_SOB_ID
      ;*/
      SELECT SUM(DECODE(AC.ACCOUNT_DR_CR, SL.ACCOUNT_DR_CR, SL.GL_AMOUNT, 0)) AS USE_AMOUNT  -- ���� ����� ��ǥ ���밡 ���� �Ұ�츸 ����(�߻�)
        INTO V_USE_AMOUNT
        FROM FI_SLIP_HEADER_INTERFACE SH
          , FI_SLIP_LINE_INTERFACE SL
          , FI_ACCOUNT_CONTROL AC
      WHERE SH.HEADER_INTERFACE_ID  = SL.HEADER_INTERFACE_ID
        AND SL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND SH.GL_DATE            BETWEEN V_START_DATE AND V_END_DATE
        AND SL.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND SH.BUDGET_DEPT_ID     = W_DEPT_ID
        AND SH.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_USE_AMOUNT := 0;
    END;
    RETURN V_USE_AMOUNT;
  END BUDGET_USE_AMOUNT_F;
  
-- ���� �ܾ� ���� - ���� ��� �̿��ݾ� ����.
  FUNCTION BUDGET_REMAIN_AMOUNT_NEXT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_BUDGET_AMOUNT  NUMBER := 0;
    V_USE_AMOUNT     NUMBER := 0;
    V_REMAIN_AMOUNT  NUMBER := 0;
  BEGIN
    -- ���� �ݾ�.
    BEGIN
      SELECT SUM(NVL(FB.PRE_NEXT_AMOUNT, 0) + NVL(FB.BASE_AMOUNT, 0) + NVL(FB.ADD_AMOUNT, 0) + 
             NVL(FB.MOVE_AMOUNT, 0)) AS BUDGET_AMOUNT
        INTO V_BUDGET_AMOUNT
        FROM FI_BUDGET FB
      WHERE FB.BUDGET_PERIOD      = W_BUDGET_PERIOD
        AND FB.DEPT_ID            = W_DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BUDGET_AMOUNT := 0;
    END;
    -- ���ݾ�.
    V_USE_AMOUNT := BUDGET_USE_AMOUNT_F
                      ( W_BUDGET_PERIOD
                      , W_DEPT_ID
                      , W_ACCOUNT_CONTROL_ID
                      , W_SOB_ID                      
                      );
    V_REMAIN_AMOUNT := NVL(V_BUDGET_AMOUNT, 0) - NVL(V_USE_AMOUNT, 0);
    RETURN V_REMAIN_AMOUNT;
  END BUDGET_REMAIN_AMOUNT_NEXT_F;
    
-- (��)�� ���� �ܾ� ����.
  FUNCTION MONTH_REMAIN_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_BUDGET_AMOUNT  NUMBER := 0;
    V_USE_AMOUNT     NUMBER := 0;
    V_REMAIN_AMOUNT  NUMBER := 0;
  BEGIN
    -- ���� �ݾ�.
    BEGIN
      SELECT SUM(NVL(FB.PRE_NEXT_AMOUNT, 0) + NVL(FB.BASE_AMOUNT, 0) + NVL(FB.ADD_AMOUNT, 0) + 
             NVL(FB.MOVE_AMOUNT, 0) - NVL(FB.NEXT_AMOUNT, 0)) AS BUDGET_AMOUNT
        INTO V_BUDGET_AMOUNT
        FROM FI_BUDGET FB
      WHERE FB.BUDGET_PERIOD      = W_BUDGET_PERIOD
        AND FB.DEPT_ID            = W_DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BUDGET_AMOUNT := 0;
    END;
    -- ���ݾ�.
    V_USE_AMOUNT := MONTH_USE_AMOUNT_F
                      ( W_BUDGET_PERIOD
                      , W_DEPT_ID
                      , W_ACCOUNT_CONTROL_ID
                      , W_SOB_ID                      
                      );
    V_REMAIN_AMOUNT := NVL(V_BUDGET_AMOUNT, 0) - NVL(V_USE_AMOUNT, 0);
    RETURN V_REMAIN_AMOUNT; 
  END MONTH_REMAIN_AMOUNT_F;
                                    
-- (���Ⱓ)���� �ܾ� ����.
  FUNCTION BUDGET_REMAIN_AMOUNT_F
            ( W_BUDGET_PERIOD           IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID                 IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID      IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID                  IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_BUDGET_AMOUNT  NUMBER := 0;
    V_USE_AMOUNT     NUMBER := 0;
    V_REMAIN_AMOUNT  NUMBER := 0;
  BEGIN
    -- ���� �ݾ�.
    BEGIN
      SELECT SUM(NVL(FB.PRE_NEXT_AMOUNT, 0) + NVL(FB.BASE_AMOUNT, 0) + NVL(FB.ADD_AMOUNT, 0) + 
             NVL(FB.MOVE_AMOUNT, 0) - NVL(FB.NEXT_AMOUNT, 0)) AS BUDGET_AMOUNT
        INTO V_BUDGET_AMOUNT
        FROM FI_BUDGET FB
      WHERE FB.BUDGET_PERIOD_FR   <= W_BUDGET_PERIOD
        AND FB.BUDGET_PERIOD_TO   >= W_BUDGET_PERIOD
        AND FB.DEPT_ID            = W_DEPT_ID
        AND FB.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND FB.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BUDGET_AMOUNT := 0;
    END;
    -- ���ݾ�.
    V_USE_AMOUNT := BUDGET_USE_AMOUNT_F
                      ( W_BUDGET_PERIOD
                      , W_DEPT_ID
                      , W_ACCOUNT_CONTROL_ID
                      , W_SOB_ID                      
                      );
    V_REMAIN_AMOUNT := NVL(V_BUDGET_AMOUNT, 0) - NVL(V_USE_AMOUNT, 0);
    RETURN V_REMAIN_AMOUNT;
  END BUDGET_REMAIN_AMOUNT_F;

-- ������� �ش�� �̸��� ���� üũ.
  FUNCTION BUDGET_CLOSED_NO_F
            ( W_PERIOD_NAME          IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID              IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         VARCHAR2(2) := 'N';    -- �̸���.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(FB.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET FB
      WHERE FB.BUDGET_PERIOD      = W_PERIOD_NAME
        AND FB.DEPT_ID            = NVL(W_DEPT_ID, FB.DEPT_ID)
        AND FB.ACCOUNT_CONTROL_ID = NVL(W_ACCOUNT_CONTROL_ID, FB.ACCOUNT_CONTROL_ID)
        AND FB.SOB_ID             = W_SOB_ID
        AND FB.CLOSED_YN          = 'N'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      V_CLOSED_YN := 'Y';
    ELSE
      V_CLOSED_YN := 'N';
    END IF;
    RETURN V_CLOSED_YN;
  END BUDGET_CLOSED_NO_F;
  
--�����û Ȯ�� ���� --> ������� �ݿ�.
  PROCEDURE SAVE_BUDGET_CONFIRM
            ( W_GB                  IN VARCHAR2
            , W_BUDGET_TYPE         IN FI_BUDGET_ADD.BUDGET_TYPE%TYPE
            , W_BUDGET_PERIOD       IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , W_DEPT_ID             IN FI_BUDGET.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID  IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET.SOB_ID%TYPE
            , P_CREATE_SEQ          IN NUMBER
            , P_BUDGET_PERIOD_FR    IN VARCHAR2
            , P_BUDGET_PERIOD_TO    IN VARCHAR2
            , P_START_DATE          IN DATE
            , P_END_DATE            IN DATE
            , P_AMOUNT              IN FI_BUDGET_ADD.AMOUNT%TYPE
            , P_USER_ID             IN FI_BUDGET.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE  DATE := GET_LOCAL_DATE(W_SOB_ID);
    
    V_BASE_AMOUNT         NUMBER := 0;
    V_ADD_AMOUNT          NUMBER := 0;
    V_MOVE_AMOUNT         NUMBER := 0;
  BEGIN   
    -- �ݾ� ����.
    IF W_BUDGET_TYPE = '11' THEN
    -- ������.
      V_BASE_AMOUNT := NVL(P_AMOUNT, 0);
    ELSIF W_BUDGET_TYPE = '21' THEN
    -- ���� ����.
      V_ADD_AMOUNT := NVL(P_AMOUNT, 0);    
    ELSIF W_BUDGET_TYPE = '22' THEN
    -- ���� ����.
      V_ADD_AMOUNT := NVL(P_AMOUNT, 0) * -1;
    ELSIF W_BUDGET_TYPE = '31' THEN
    -- ���� ����.
      V_MOVE_AMOUNT := NVL(P_AMOUNT, 0);
    END IF;
    
    -- // W_GB = 'I' : ���ϱ� // W_GB = 'D' : ���� // --
    IF W_GB = 'I' THEN
    -- ����.
      NULL;
    ELSE
    -- ����.
      V_BASE_AMOUNT   := V_BASE_AMOUNT * -1;
      V_ADD_AMOUNT    := V_ADD_AMOUNT * -1;
      V_MOVE_AMOUNT   := V_MOVE_AMOUNT * -1;
    END IF;
    
    -- ���곻�� ���� : ������ INSERT.
    UPDATE FI_BUDGET FB
      SET FB.BASE_AMOUNT        = NVL(FB.BASE_AMOUNT, 0) + NVL(V_BASE_AMOUNT, 0)
        , FB.ADD_AMOUNT         = NVL(FB.ADD_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0)
        , FB.MOVE_AMOUNT        = NVL(FB.MOVE_AMOUNT, 0) + NVL(V_MOVE_AMOUNT, 0)
        , FB.LAST_UPDATE_DATE   = V_SYSDATE
        , FB.LAST_UPDATED_BY    = P_USER_ID
    WHERE FB.BUDGET_PERIOD      = W_BUDGET_PERIOD
      AND FB.DEPT_ID            = W_DEPT_ID
      AND FB.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
      AND FB.SOB_ID             = W_SOB_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN      
      INSERT INTO FI_BUDGET
      ( BUDGET_PERIOD
      , DEPT_ID
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , SOB_ID
      , ORG_ID
      , CREATE_SEQ
      , BUDGET_PERIOD_FR
      , BUDGET_PERIOD_TO
      , START_DATE
      , END_DATE
      , BASE_AMOUNT
      , ADD_AMOUNT
      , MOVE_AMOUNT
      , BASE_MONTH_YN
      , CREATION_DATE			
      , CREATED_BY			
      , LAST_UPDATE_DATE			
      , LAST_UPDATED_BY		
      )
      SELECT W_BUDGET_PERIOD
           , W_DEPT_ID
           , W_ACCOUNT_CONTROL_ID
           , AC.ACCOUNT_CODE
           , W_SOB_ID
           , AC.ORG_ID
           , P_CREATE_SEQ
           , P_BUDGET_PERIOD_FR
           , P_BUDGET_PERIOD_TO
           , P_START_DATE
           , P_END_DATE
           , V_BASE_AMOUNT
           , V_ADD_AMOUNT
           , V_MOVE_AMOUNT
           , DECODE(W_BUDGET_PERIOD, P_BUDGET_PERIOD_FR, 'Y', 'N') AS BASE_MONTH_YN
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM FI_ACCOUNT_CONTROL AC
      WHERE AC.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND AC.SOB_ID             = W_SOB_ID
      ;
    END IF;
  END SAVE_BUDGET_CONFIRM;
  
END FI_BUDGET_G; 
/
