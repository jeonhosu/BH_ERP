CREATE OR REPLACE PACKAGE FI_BUDGET_YEAR_PLAN_G
AS

-- (년)예산책정 조회.
  PROCEDURE SELECT_BUDGET_YEAR_PLAN
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE            
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            );

-- (년)예산책정 삽입.
  PROCEDURE INSERT_BUDGET_YEAR_PLAN
            ( P_BUDGET_YEAR        IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_YEAR_PLAN.ORG_ID%TYPE
            , P_AMOUNT             IN FI_BUDGET_YEAR_PLAN.AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_YEAR_PLAN.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE 
            );

-- (년)예산책정 수정.
  PROCEDURE UPDATE_BUDGET_YEAR_PLAN
            ( W_BUDGET_YEAR        IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_YEAR_PLAN.ORG_ID%TYPE
            , P_AMOUNT             IN FI_BUDGET_YEAR_PLAN.AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_YEAR_PLAN.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE 
            );

-- (년)예산책정 -> 월별 예산수립 처리.
  PROCEDURE EXE_BUDGET_PERIOD
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- (년)예산책정 확정 처리.
  PROCEDURE EXE_BUDGET_YEAR_PLAN_CONFIRM
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_YEAR_PLAN.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );
            
-- (년)예산책정 마감 처리.
  PROCEDURE EXE_BUDGET_YEAR_PLAN_CLOSE
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_YEAR_PLAN.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- (년) 예산책정에서 일괄 예산수립 생성.
  PROCEDURE SAVE_BUDGET
            ( P_BUDGET_PERIOD      IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , P_DEPT_ID            IN FI_BUDGET.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET.ORG_ID%TYPE
            , P_AMOUNT             IN FI_BUDGET.BASE_AMOUNT%TYPE
            , P_MOVE_YN            IN FI_BUDGET.MOVE_YN%TYPE
            , P_NEXT_YN            IN FI_BUDGET.NEXT_YN%TYPE            
            , P_DESCRIPTION        IN FI_BUDGET.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET.CREATED_BY%TYPE 
            );

-- (년)예산 책정 확정 여부 체크.
  FUNCTION BUDGET_CONFIRM_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            ) RETURN VARCHAR2;
                        
-- (년)예산 책정 미마감 여부 체크.
  FUNCTION BUDGET_CLOSED_NO_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            ) RETURN VARCHAR2;
            
END FI_BUDGET_YEAR_PLAN_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BUDGET_YEAR_PLAN_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUDGET_YEAR_PLAN_G
/* Description  : 년 예산 책정 및 예산수립 생성.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 예산책정 조회.
  PROCEDURE SELECT_BUDGET_YEAR_PLAN
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE            
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT BYP.BUDGET_YEAR
           , DM.DEPT_NAME AS DEPT_NAME
           , DM.DEPT_CODE
           , BYP.DEPT_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(BYP.ACCOUNT_CONTROL_ID, BYP.SOB_ID) AS ACCOUNT_DESC
           , BYP.ACCOUNT_CODE
           , BYP.ACCOUNT_CONTROL_ID
           , BYP.AMOUNT
           , BYP.DESCRIPTION
           , BYP.CONFIRM_YN
           , BYP.CLOSED_YN
        FROM FI_BUDGET_YEAR_PLAN BYP
          , FI_DEPT_MASTER DM
       WHERE BYP.DEPT_ID            = DM.DEPT_ID
         AND BYP.SOB_ID             = DM.SOB_ID
         AND BYP.BUDGET_YEAR        = W_BUDGET_YEAR
         AND BYP.DEPT_ID            = NVL(W_DEPT_ID, BYP.DEPT_ID)
         AND BYP.ACCOUNT_CONTROL_ID = NVL(W_ACCOUNT_CONTROL_ID, BYP.ACCOUNT_CONTROL_ID)
         AND BYP.SOB_ID             = W_SOB_ID
       ORDER BY DM.DEPT_CODE, BYP.ACCOUNT_CODE
       ;
  END SELECT_BUDGET_YEAR_PLAN;

-- 예산책정 삽입.
  PROCEDURE INSERT_BUDGET_YEAR_PLAN
            ( P_BUDGET_YEAR        IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_YEAR_PLAN.ORG_ID%TYPE
            , P_AMOUNT             IN FI_BUDGET_YEAR_PLAN.AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_YEAR_PLAN.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT  NUMBER := 0;
  BEGIN
    -- 동일한 예산 책정내역 존재 체크.
    BEGIN
      SELECT COUNT(BYP.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_YEAR_PLAN BYP
       WHERE BYP.BUDGET_YEAR        = P_BUDGET_YEAR
         AND BYP.DEPT_ID            = P_DEPT_ID
         AND BYP.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
         AND BYP.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    END IF;

    INSERT INTO FI_BUDGET_YEAR_PLAN
    ( BUDGET_YEAR
    , DEPT_ID 
    , ACCOUNT_CONTROL_ID 
    , ACCOUNT_CODE 
    , SOB_ID 
    , ORG_ID 
    , AMOUNT 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_BUDGET_YEAR
    , P_DEPT_ID
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_SOB_ID
    , P_ORG_ID
    , P_AMOUNT
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_BUDGET_YEAR_PLAN;

-- 예산책정 수정.
  PROCEDURE UPDATE_BUDGET_YEAR_PLAN
            ( W_BUDGET_YEAR        IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_YEAR_PLAN.ORG_ID%TYPE
            , P_AMOUNT             IN FI_BUDGET_YEAR_PLAN.AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_YEAR_PLAN.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    IF BUDGET_CONFIRM_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
      RETURN;
    END IF;
    
    UPDATE FI_BUDGET_YEAR_PLAN BYP
      SET AMOUNT             = P_AMOUNT
        , DESCRIPTION        = P_DESCRIPTION
        , LAST_UPDATE_DATE   = V_SYSDATE
        , LAST_UPDATED_BY    = P_USER_ID
    WHERE BYP.BUDGET_YEAR        = W_BUDGET_YEAR
      AND BYP.DEPT_ID            = W_DEPT_ID
      AND BYP.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
      AND BYP.SOB_ID             = W_SOB_ID
    ;
  END UPDATE_BUDGET_YEAR_PLAN;

-- (년)예산책정 -> 월별 예산수립 처리.
  PROCEDURE EXE_BUDGET_PERIOD
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_STD_DATE                DATE;                   -- 연산년월 산출을 위한 일자 변수.
    V_BUDGET_PERIOD           VARCHAR2(7) := NULL;    -- 예산년월.
    V_NEXT_YN                 VARCHAR2(1) := 'N';     -- 이월 Y/N.
    V_NEXT_COUNT              NUMBER := 0;            -- 이월 여부 COUNT.
    V_AMOUNT                  NUMBER := 0;            -- 예산 금액.
  BEGIN
    FOR C1 IN ( SELECT BYP.BUDGET_YEAR
                     , BYP.DEPT_ID
                     , BYP.ACCOUNT_CONTROL_ID
                     , BYP.ACCOUNT_CODE
                     , BYP.SOB_ID
                     , BYP.ORG_ID
                     , BYP.AMOUNT
                     , BYP.DESCRIPTION
                     , NVL(BA.REPEAT_PERIOD_COUNT, 1) AS REPEAT_PERIOD_COUNT
                     , NVL(BA.CONTROL_YN, 'N') AS CONTROL_YN
                     , NVL(BA.ADD_YN, 'N') AS ADD_YN
                     , NVL(BA.MOVE_YN, 'N') AS MOVE_YN
                     , NVL(BA.NEXT_YN, 'N') AS NEXT_YN
                     , NVL(BA.PO_YN, 'N') AS PO_YN
                  FROM FI_BUDGET_YEAR_PLAN BYP
                    , FI_BUDGET_ACCOUNT BA
                WHERE BYP.ACCOUNT_CONTROL_ID  = BA.ACCOUNT_CONTROL_ID(+)
                  AND BYP.SOB_ID              = BA.SOB_ID(+)
                  AND BYP.BUDGET_YEAR         = W_BUDGET_YEAR
                  AND BYP.DEPT_ID             = NVL(W_DEPT_ID, BYP.DEPT_ID)
                  AND BYP.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BYP.ACCOUNT_CONTROL_ID)
                  AND BYP.SOB_ID              = W_SOB_ID
                  AND BYP.CONFIRM_YN          = 'Y'
                  AND BYP.AMOUNT              <> 0
              )
    LOOP 
      V_STD_DATE := TO_DATE(C1.BUDGET_YEAR || '-01-01', 'YYYY-MM-DD');
      V_NEXT_COUNT := 1;
      V_NEXT_YN    := 'N';
      V_AMOUNT     := 0;
      
      FOR R1 IN 1 .. 12
      LOOP
        V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_STD_DATE, (R1 - 1)), 'YYYY-MM');
        
        -- 예산금액 설정.
        IF V_NEXT_COUNT = 1 THEN
          V_AMOUNT     := NVL(C1.AMOUNT, 0);
        ELSE
          V_AMOUNT     := 0;
        END IF;
        
        -- 이월 FLAG 설정.
        IF V_NEXT_COUNT < C1.REPEAT_PERIOD_COUNT THEN
          V_NEXT_YN := 'Y';          
          V_NEXT_COUNT := V_NEXT_COUNT + 1;
        ELSE
          V_NEXT_YN := 'N';
          V_NEXT_COUNT := 1;
        END IF;       
        
        /*DBMS_OUTPUT.PUT_LINE(R1 - 1 || '/' || C1.DEPT_ID || '/' || C1.ACCOUNT_CODE || '/' || TO_CHAR(V_STD_DATE, 'YYYY-MM-DD') || '/' || 
                             V_BUDGET_PERIOD || '/' || V_NEXT_COUNT || '/' || V_NEXT_YN  || '//' || V_AMOUNT);*/
        FI_BUDGET_YEAR_PLAN_G.SAVE_BUDGET
          ( V_BUDGET_PERIOD
          , C1.DEPT_ID
          , C1.ACCOUNT_CONTROL_ID
          , C1.ACCOUNT_CODE
          , C1.SOB_ID
          , C1.ORG_ID
          , V_AMOUNT
          , C1.MOVE_YN
          , C1.NEXT_YN
          , C1.DESCRIPTION
          , P_USER_ID 
          );
      END LOOP R1;
    END LOOP C1;    
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_PERIOD;

-- (년)예산책정 확정 처리.
  PROCEDURE EXE_BUDGET_YEAR_PLAN_CONFIRM
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_YEAR_PLAN.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
  BEGIN
    IF BUDGET_CLOSED_NO_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL));
      RETURN;
    END IF;
    
    -- 마감처리.
    UPDATE FI_BUDGET_YEAR_PLAN
      SET CONFIRM_YN          = 'Y'
        , CONFIRM_DATE        = SYSDATE
        , CONFIRM_PERSON_ID   = P_CONNECT_PERSON_ID
    WHERE BUDGET_YEAR           = W_BUDGET_YEAR
      AND DEPT_ID               = NVL(W_DEPT_ID, DEPT_ID)
      AND ACCOUNT_CONTROL_ID    = NVL(W_ACCOUNT_CONTROL_ID, ACCOUNT_CONTROL_ID)
      AND SOB_ID                = W_SOB_ID
      AND CONFIRM_YN            = 'N'
    ;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_YEAR_PLAN_CONFIRM;
            
-- (년)예산책정 마감 처리.
  PROCEDURE EXE_BUDGET_YEAR_PLAN_CLOSE
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_YEAR_PLAN.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_YEAR_PLAN.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
  BEGIN
    IF BUDGET_CLOSED_NO_F
         ( W_BUDGET_YEAR
          , W_DEPT_ID
          , W_ACCOUNT_CONTROL_ID
          , W_SOB_ID
         ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL));
      RETURN;
    END IF;
    
    -- 마감처리.
    UPDATE FI_BUDGET_YEAR_PLAN
      SET CLOSED_YN          = 'Y'
        , CLOSED_DATE        = SYSDATE
        , CLOSED_PERSON_ID   = P_CONNECT_PERSON_ID
    WHERE BUDGET_YEAR           = W_BUDGET_YEAR
      AND DEPT_ID               = NVL(W_DEPT_ID, DEPT_ID)
      AND ACCOUNT_CONTROL_ID    = NVL(W_ACCOUNT_CONTROL_ID, ACCOUNT_CONTROL_ID)
      AND SOB_ID                = W_SOB_ID
      AND CLOSED_YN             = 'N'
    ;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_YEAR_PLAN_CLOSE;

-- (년) 예산책정에서 일괄 예산수립 생성.
  PROCEDURE SAVE_BUDGET
            ( P_BUDGET_PERIOD      IN FI_BUDGET.BUDGET_PERIOD%TYPE
            , P_DEPT_ID            IN FI_BUDGET.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET.ORG_ID%TYPE
            , P_AMOUNT             IN FI_BUDGET.BASE_AMOUNT%TYPE
            , P_MOVE_YN            IN FI_BUDGET.MOVE_YN%TYPE
            , P_NEXT_YN            IN FI_BUDGET.NEXT_YN%TYPE            
            , P_DESCRIPTION        IN FI_BUDGET.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE FI_BUDGET FB
    SET FB.BASE_AMOUNT            = P_AMOUNT
      , FB.MOVE_YN                = P_MOVE_YN
      , FB.NEXT_YN                = P_NEXT_YN
      , FB.DESCRIPTION            = P_DESCRIPTION
      , FB.LAST_UPDATE_DATE       = V_SYSDATE
      , FB.LAST_UPDATED_BY        = P_USER_ID
    WHERE FB.BUDGET_PERIOD        = P_BUDGET_PERIOD
      AND FB.DEPT_ID              = P_DEPT_ID
      AND FB.ACCOUNT_CONTROL_ID   = P_ACCOUNT_CONTROL_ID
      AND FB.SOB_ID               = P_SOB_ID
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
      , BASE_AMOUNT
      , MOVE_YN
      , NEXT_YN
      , CREATION_DATE			
      , CREATED_BY			
      , LAST_UPDATE_DATE			
      , LAST_UPDATED_BY		
      ) VALUES
      ( P_BUDGET_PERIOD
      , P_DEPT_ID
      , P_ACCOUNT_CONTROL_ID
      , P_ACCOUNT_CODE
      , P_SOB_ID
      , P_ORG_ID
      , TRUNC(TO_DATE(P_BUDGET_PERIOD, 'YYYY-MM'), 'MONTH')
      , LAST_DAY(TO_DATE(P_BUDGET_PERIOD, 'YYYY-MM'))
      , P_AMOUNT
      , P_MOVE_YN
      , P_NEXT_YN
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END SAVE_BUDGET;

-- (년)예산 책정 확정 여부 체크.
  FUNCTION BUDGET_CONFIRM_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CONFIRM_YN        VARCHAR2(2) := 'N';    -- 확정 FLAG.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(BYP.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_YEAR_PLAN BYP
      WHERE BYP.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BYP.DEPT_ID             = NVL(W_DEPT_ID, BYP.DEPT_ID)
        AND BYP.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BYP.ACCOUNT_CONTROL_ID)
        AND BYP.SOB_ID              = W_SOB_ID
        AND BYP.CONFIRM_YN          = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      V_CONFIRM_YN := 'N';
    ELSE
      V_CONFIRM_YN := 'Y';
    END IF;
    RETURN V_CONFIRM_YN;
  END BUDGET_CONFIRM_F;
  
-- (년)예산 책정 미마감 여부 체크.
  FUNCTION BUDGET_CLOSED_NO_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_YEAR_PLAN.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_YEAR_PLAN.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_YEAR_PLAN.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_YEAR_PLAN.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         VARCHAR2(2) := 'N';    -- 미마감.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(BYP.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_YEAR_PLAN BYP
      WHERE BYP.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BYP.DEPT_ID             = NVL(W_DEPT_ID, BYP.DEPT_ID)
        AND BYP.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BYP.ACCOUNT_CONTROL_ID)
        AND BYP.SOB_ID              = W_SOB_ID
        AND BYP.CLOSED_YN           = 'N'
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
  
END FI_BUDGET_YEAR_PLAN_G;
/
