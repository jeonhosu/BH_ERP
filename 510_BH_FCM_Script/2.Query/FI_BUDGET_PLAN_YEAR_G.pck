CREATE OR REPLACE PACKAGE FI_BUDGET_PLAN_G
AS

-- (년)예산책정 조회.
  PROCEDURE SELECT_BUDGET_PLAN_YEAR
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );

-- (년)예산책정 삽입.
  PROCEDURE INSERT_BUDGET_PLAN_YEAR
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            );

-- (년)예산책정 수정.
  PROCEDURE UPDATE_BUDGET_PLAN_YEAR
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            );

-----------------------------------------------------------------------------------------
-- (년)예산책정 --> 헤더 조회(월별 스프레드).
  PROCEDURE SELECT_MONTH_HEADER
            ( P_CURSOR2              OUT TYPES.TCURSOR2
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );
            
-- (년)예산책정 --> 월별 예산 금액 조회.
  PROCEDURE SELECT_BUDGET_PLAN_MONTH
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            );
-- (년) 예산 편성 --> (월) 예산 수정.
  PROCEDURE UPDATE_BUDGET_PLAN_MONTH
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_USER_ID            IN NUMBER
            );

-----------------------------------------------------------------------------------------                        
-- (년)예산책정 -> 월별 예산수립 처리.
  PROCEDURE EXE_BUDGET_PERIOD
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- (년)예산책정 확정 처리.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CONFIRM
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );
            
-- (년)예산책정 마감 처리.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CLOSE
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            );

-- (년) 예산책정에서 일괄 예산수립 생성.
  PROCEDURE SAVE_BUDGET
            ( P_BUDGET_PERIOD      IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_MONTH.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_MONTH.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_MONTH.ORG_ID%TYPE
            , P_BUDGET_PERIOD_FR   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BUDGET_PERIOD_TO   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BASE_AMOUNT        IN FI_BUDGET_PLAN_MONTH.BASE_AMOUNT%TYPE
            , P_BASE_MONTH_YN      IN FI_BUDGET_PLAN_MONTH.BASE_MONTH_YN%TYPE
            , P_ENABLED_YN         IN FI_BUDGET_PLAN_MONTH.ENABLED_YN%TYPE            
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_MONTH.DESCRIPTION%TYPE
            , P_MONTH_SEQ          IN FI_BUDGET_PLAN_MONTH.MONTH_SEQ%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_MONTH.CREATED_BY%TYPE 
            );

-- (년)예산 책정 확정 여부 체크.
  FUNCTION BUDGET_CONFIRM_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2;
                        
-- (년)예산 책정 미마감 여부 체크.
  FUNCTION BUDGET_CLOSED_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_BUDGET_PLAN_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BUDGET_PLAN_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUDGET_PLAN_G
/* Description  : 년 예산 책정 및 월 예산수립 생성.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 예산책정 조회.
  PROCEDURE SELECT_BUDGET_PLAN_YEAR
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT BYP.BUDGET_YEAR
           , DM.DEPT_NAME AS DEPT_NAME
           , DM.DEPT_CODE
           , BYP.DEPT_ID
           , BYP.ACCOUNT_CONTROL_ID
           , BYP.ACCOUNT_CODE
           , BYP.YEAR_AMOUNT
           , BYP.DESCRIPTION
           , BYP.CONFIRM_YN
           , BYP.CLOSED_YN
        FROM FI_BUDGET_PLAN_YEAR BYP
          , FI_DEPT_MASTER DM
       WHERE BYP.DEPT_ID            = DM.DEPT_ID
         AND BYP.SOB_ID             = DM.SOB_ID
         AND BYP.BUDGET_YEAR        = W_BUDGET_YEAR
         --AND DM.DEPT_CODE           BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
         AND BYP.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
         AND BYP.SOB_ID             = W_SOB_ID
       ORDER BY DM.DEPT_CODE, BYP.ACCOUNT_CODE
       ;
  END SELECT_BUDGET_PLAN_YEAR;

-- 예산책정 삽입.
  PROCEDURE INSERT_BUDGET_PLAN_YEAR
            ( P_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT  NUMBER := 0;
  BEGIN
    -- 동일한 예산 책정내역 존재 체크.
    BEGIN
      SELECT COUNT(BYP.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BYP
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

    INSERT INTO FI_BUDGET_PLAN_YEAR
    ( BUDGET_YEAR
    , DEPT_ID 
    , ACCOUNT_CONTROL_ID 
    , ACCOUNT_CODE 
    , SOB_ID 
    , ORG_ID 
    , YEAR_AMOUNT 
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
    , P_YEAR_AMOUNT
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_BUDGET_PLAN_YEAR;

-- 예산책정 수정.
  PROCEDURE UPDATE_BUDGET_PLAN_YEAR
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_YEAR.ORG_ID%TYPE
            , P_YEAR_AMOUNT        IN FI_BUDGET_PLAN_YEAR.YEAR_AMOUNT%TYPE
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_YEAR.DESCRIPTION%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE 
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
    
    UPDATE FI_BUDGET_PLAN_YEAR BYP
      SET YEAR_AMOUNT        = P_YEAR_AMOUNT
        , DESCRIPTION        = P_DESCRIPTION
        , LAST_UPDATE_DATE   = V_SYSDATE
        , LAST_UPDATED_BY    = P_USER_ID
    WHERE BYP.BUDGET_YEAR        = W_BUDGET_YEAR
      AND BYP.DEPT_ID            = W_DEPT_ID
      AND BYP.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
      AND BYP.SOB_ID             = W_SOB_ID
    ;
  END UPDATE_BUDGET_PLAN_YEAR;

-----------------------------------------------------------------------------------------
-- (년)예산책정 --> 헤더 조회(월별 스프레드).
  PROCEDURE SELECT_MONTH_HEADER
            ( P_CURSOR2              OUT TYPES.TCURSOR2
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE            
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
  BEGIN
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);
    
    OPEN P_CURSOR2 FOR
      SELECT MAX(DECODE(ROWNUM, 1, CY.YYYYMM, NULL)) AS MONTH_1
           , MAX(DECODE(ROWNUM, 2, CY.YYYYMM, NULL)) AS MONTH_2
           , MAX(DECODE(ROWNUM, 3, CY.YYYYMM, NULL)) AS MONTH_3
           , MAX(DECODE(ROWNUM, 4, CY.YYYYMM, NULL)) AS MONTH_4
           , MAX(DECODE(ROWNUM, 5, CY.YYYYMM, NULL)) AS MONTH_5
           , MAX(DECODE(ROWNUM, 6, CY.YYYYMM, NULL)) AS MONTH_6
           , MAX(DECODE(ROWNUM, 7, CY.YYYYMM, NULL)) AS MONTH_7
           , MAX(DECODE(ROWNUM, 8, CY.YYYYMM, NULL)) AS MONTH_8
           , MAX(DECODE(ROWNUM, 9, CY.YYYYMM, NULL)) AS MONTH_9
           , MAX(DECODE(ROWNUM, 10, CY.YYYYMM, NULL)) AS MONTH_10
           , MAX(DECODE(ROWNUM, 11, CY.YYYYMM, NULL)) AS MONTH_11
           , MAX(DECODE(ROWNUM, 12, CY.YYYYMM, NULL)) AS MONTH_12
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) AS YEAR_TOTAL
        FROM EAPP_CALENDAR_YYYYMM_V CY
      WHERE CY.YYYYMM               BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
      ORDER BY CY.YYYYMM
      ;
  END SELECT_MONTH_HEADER;
  
-- (년)예산책정 --> 월별 예산 금액 조회.
  PROCEDURE SELECT_BUDGET_PLAN_MONTH
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            )
  AS
    V_PERIOD_FR                      DATE;
    V_PERIOD_TO                      DATE;
  BEGIN
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_PERIOD_FR, V_PERIOD_TO);

    OPEN P_CURSOR1 FOR
      SELECT DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , MAX(DECODE(BPM.MONTH_SEQ, 1, BPM.BASE_AMOUNT, 0)) AS MONTH_1
           , MAX(DECODE(BPM.MONTH_SEQ, 2, BPM.BASE_AMOUNT, 0)) AS MONTH_2
           , MAX(DECODE(BPM.MONTH_SEQ, 3, BPM.BASE_AMOUNT, 0)) AS MONTH_3
           , MAX(DECODE(BPM.MONTH_SEQ, 4, BPM.BASE_AMOUNT, 0)) AS MONTH_4
           , MAX(DECODE(BPM.MONTH_SEQ, 5, BPM.BASE_AMOUNT, 0)) AS MONTH_5
           , MAX(DECODE(BPM.MONTH_SEQ, 6, BPM.BASE_AMOUNT, 0)) AS MONTH_6
           , MAX(DECODE(BPM.MONTH_SEQ, 7, BPM.BASE_AMOUNT, 0)) AS MONTH_7
           , MAX(DECODE(BPM.MONTH_SEQ, 8, BPM.BASE_AMOUNT, 0)) AS MONTH_8
           , MAX(DECODE(BPM.MONTH_SEQ, 9, BPM.BASE_AMOUNT, 0)) AS MONTH_9
           , MAX(DECODE(BPM.MONTH_SEQ, 10, BPM.BASE_AMOUNT, 0)) AS MONTH_10
           , MAX(DECODE(BPM.MONTH_SEQ, 11, BPM.BASE_AMOUNT, 0)) AS MONTH_11
           , MAX(DECODE(BPM.MONTH_SEQ, 12, BPM.BASE_AMOUNT, 0)) AS MONTH_12
           , SUM(BPM.BASE_AMOUNT) AS YEAR_TOTAL
           , MAX(DECODE(BPM.MONTH_SEQ, 1, BPM.BASE_MONTH_YN, 'N')) AS MONTH_1_YN     
           , MAX(DECODE(BPM.MONTH_SEQ, 2, BPM.BASE_MONTH_YN, 'N')) AS MONTH_2_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 3, BPM.BASE_MONTH_YN, 'N')) AS MONTH_3_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 4, BPM.BASE_MONTH_YN, 'N')) AS MONTH_4_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 5, BPM.BASE_MONTH_YN, 'N')) AS MONTH_5_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 6, BPM.BASE_MONTH_YN, 'N')) AS MONTH_6_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 7, BPM.BASE_MONTH_YN, 'N')) AS MONTH_7_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 8, BPM.BASE_MONTH_YN, 'N')) AS MONTH_8_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 9, BPM.BASE_MONTH_YN, 'N')) AS MONTH_9_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 10, BPM.BASE_MONTH_YN, 'N')) AS MONTH_10_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 11, BPM.BASE_MONTH_YN, 'N')) AS MONTH_11_YN
           , MAX(DECODE(BPM.MONTH_SEQ, 12, BPM.BASE_MONTH_YN, 'N')) AS MONTH_12_YN
           , 'N' AS YEAR_TOTAL_YN
           , BPM.ACCOUNT_CONTROL_ID
        FROM FI_BUDGET_PLAN_MONTH BPM
          , FI_DEPT_MASTER DM
      WHERE BPM.DEPT_ID                 = DM.DEPT_ID
        AND BPM.BUDGET_PERIOD           BETWEEN TO_CHAR(V_PERIOD_FR, 'YYYY-MM') AND TO_CHAR(V_PERIOD_TO, 'YYYY-MM')
        AND BPM.ACCOUNT_CONTROL_ID      = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID                  = W_SOB_ID 
        AND DM.DEPT_CODE                BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
      GROUP BY DM.DEPT_NAME
           , DM.DEPT_CODE
           , DM.DEPT_ID
           , BPM.ACCOUNT_CONTROL_ID
      ORDER BY DM.DEPT_CODE
      ;
  END SELECT_BUDGET_PLAN_MONTH;
  
-- (년) 예산 편성 --> (월) 예산 수정.
  PROCEDURE UPDATE_BUDGET_PLAN_MONTH
            ( W_BUDGET_YEAR        IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID            IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID             IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_MONTH_1            IN NUMBER
            , P_MONTH_2            IN NUMBER
            , P_MONTH_3            IN NUMBER
            , P_MONTH_4            IN NUMBER
            , P_MONTH_5            IN NUMBER
            , P_MONTH_6            IN NUMBER
            , P_MONTH_7            IN NUMBER
            , P_MONTH_8            IN NUMBER
            , P_MONTH_9            IN NUMBER
            , P_MONTH_10           IN NUMBER
            , P_MONTH_11           IN NUMBER
            , P_MONTH_12           IN NUMBER
            , P_USER_ID            IN NUMBER
            )
  AS
    V_SYSDATE                      DATE := GET_LOCAL_DATE(W_SOB_ID);
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
    
    BEGIN
      -- 1월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_1, 0)
          , BPM.LAST_UPDATE_DATE    = V_SYSDATE
          , BPM.LAST_UPDATED_BY     = P_USER_ID
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 1
      ;
      -- 2월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_2, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 2
      ;
      -- 3월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_3, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 3
      ;
      -- 4월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_4, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 4
      ;
      -- 5월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_5, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 5
      ;
      -- 6월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_6, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 6
      ;
      -- 7월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_7, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 7
      ;
      -- 8월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_8, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 8
      ;
      -- 9월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_9, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 9
      ;
      -- 10월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_10, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 10
      ;
      -- 11월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_11, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 11
      ;
      -- 12월 수정.
      UPDATE FI_BUDGET_PLAN_MONTH BPM
        SET BPM.BASE_AMOUNT         = NVL(P_MONTH_12, 0)
      WHERE BPM.DEPT_ID             = W_DEPT_ID
        AND BPM.ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
        AND BPM.SOB_ID              = W_SOB_ID
        AND BPM.MONTH_SEQ           = 12
      ;
    EXCEPTION WHEN OTHERS THEN
      ROLLBACK;
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
  END UPDATE_BUDGET_PLAN_MONTH;

-----------------------------------------------------------------------------------------
-- (년)예산책정 -> 월별 예산수립 처리.
  PROCEDURE EXE_BUDGET_PERIOD
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_STD_START_DATE          DATE;                   -- 연산년월 산출을 위한 일자 변수.
    V_STD_END_DATE            DATE;
    V_BUDGET_PERIOD           VARCHAR2(7) := NULL;    -- 예산년월.
    V_BUDGET_PERIOD_FR        VARCHAR2(7) := NULL;    -- 예산 시작 적용 년월.
    V_BUDGET_PERIOD_TO        VARCHAR2(7) := NULL;    -- 예산 종료 적용 년월.
    V_START_DATE              DATE := NULL;           -- 예산 시작 적용 일자.
    V_END_DATE                DATE := NULL;           -- 예산 종료 적용 일자.
    V_MONTH_SEQ               NUMBER := 0;            -- (월별, 부서별, 계정별) 생성 순서.
    V_BASE_MONTH_YN           VARCHAR2(1) := 'N';     -- 편성 예산 년월 Y/N.
    V_NEXT_COUNT              NUMBER := 0;            -- 이월 COUNT.
    V_MONTH_AMOUNT            NUMBER := 0;            -- 월예산 금액.
    V_REMAIN_AMOUNT           NUMBER := 0;            -- 월예산 책정후 잔액.
    V_AMOUNT                  NUMBER := 0;            -- 반영 예산금액.
  BEGIN
    -- 기존 자료 삭제 -- 
    IF BUDGET_CLOSED_F
            ( W_BUDGET_YEAR
            , NULL
            , NULL
            , W_SOB_ID
            ) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10052', NULL));
      RETURN;
    END IF;
    
    -- 회계기간.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    
    FOR C1 IN ( SELECT BYP.BUDGET_YEAR
                     , BYP.DEPT_ID
                     , BYP.ACCOUNT_CONTROL_ID
                     , BYP.ACCOUNT_CODE
                     , BYP.SOB_ID
                     , BYP.ORG_ID
                     , BYP.YEAR_AMOUNT
                     , BYP.DESCRIPTION
                     , NVL(BA.REPEAT_PERIOD_COUNT, 1) AS REPEAT_PERIOD_COUNT
                     , NVL(BA.CONTROL_YN, 'N') AS CONTROL_YN
                     , NVL(BA.ADD_YN, 'N') AS ADD_YN
                     , NVL(BA.MOVE_YN, 'N') AS MOVE_YN
                     , NVL(BA.NEXT_YN, 'N') AS NEXT_YN
                     , NVL(BA.PO_YN, 'N') AS PO_YN
                  FROM FI_BUDGET_PLAN_YEAR BYP
                    , FI_DEPT_MASTER DM
                    , FI_BUDGET_ACCOUNT BA
                WHERE BYP.DEPT_ID             = DM.DEPT_ID
                  AND BYP.ACCOUNT_CONTROL_ID  = BA.ACCOUNT_CONTROL_ID(+)
                  AND BYP.SOB_ID              = BA.SOB_ID(+)
                  AND BYP.BUDGET_YEAR         = W_BUDGET_YEAR
                  AND DM.DEPT_CODE            BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
                  AND BYP.ACCOUNT_CODE        BETWEEN NVL(W_ACCOUNT_CODE_FR, BYP.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BYP.ACCOUNT_CODE)
                  AND BYP.SOB_ID              = W_SOB_ID
                  AND BYP.YEAR_AMOUNT         <> 0
              )
    LOOP 
      V_NEXT_COUNT := 1;
      V_BASE_MONTH_YN    := 'N';
      V_AMOUNT           := 0;
      V_MONTH_SEQ        := 0;
      V_MONTH_AMOUNT     := TRUNC(NVL(C1.YEAR_AMOUNT, 0) / 12);  -- 월예산.
      V_REMAIN_AMOUNT    := NVL(C1.YEAR_AMOUNT, 0) - (V_MONTH_AMOUNT * 12);
      V_MONTH_AMOUNT     := NVL(V_MONTH_AMOUNT, 0) * C1.REPEAT_PERIOD_COUNT;
      
      FOR R1 IN 1 .. 12
      LOOP
        V_MONTH_SEQ      := R1;
        V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_STD_START_DATE, (R1 - 1)), 'YYYY-MM');
        -- 예산금액 설정.
        IF V_NEXT_COUNT = 1 THEN
          V_AMOUNT     := NVL(V_MONTH_AMOUNT, 0);
          V_BUDGET_PERIOD_FR := V_BUDGET_PERIOD;
          IF NVL(C1.REPEAT_PERIOD_COUNT, 1) <= 1 THEN
            V_BUDGET_PERIOD_TO := V_BUDGET_PERIOD_FR;
          ELSE
            V_BUDGET_PERIOD_TO := TO_CHAR(ADD_MONTHS(TO_DATE(V_BUDGET_PERIOD_FR, 'YYYY-MM'), C1.REPEAT_PERIOD_COUNT - 1), 'YYYY-MM');
          END IF;
          
          IF NVL(V_REMAIN_AMOUNT, 0) <> 0 THEN
            V_AMOUNT   := NVL(V_AMOUNT, 0) - NVL(V_REMAIN_AMOUNT, 0);
            V_REMAIN_AMOUNT := 0;
          END IF;
        ELSE
          V_AMOUNT     := 0;
        END IF;
        
        -- 이월 FLAG 설정.
        IF V_NEXT_COUNT < C1.REPEAT_PERIOD_COUNT THEN
          V_BASE_MONTH_YN := 'Y';
          V_NEXT_COUNT := V_NEXT_COUNT + 1;
        ELSE
          IF C1.REPEAT_PERIOD_COUNT = 1 THEN
            V_BASE_MONTH_YN := 'Y';
          ELSE
            V_BASE_MONTH_YN := 'N';
          END IF;
          V_NEXT_COUNT := 1;
        END IF;
        
        /*DBMS_OUTPUT.PUT_LINE(R1 - 1 || '/' || C1.DEPT_ID || '/' || C1.ACCOUNT_CODE || '/' || TO_CHAR(V_STD_DATE, 'YYYY-MM-DD') || '/' || 
                             V_BUDGET_PERIOD || '/' || V_NEXT_COUNT || '/' || V_NEXT_YN  || '//' || V_AMOUNT);*/
        FI_BUDGET_PLAN_G.SAVE_BUDGET
          ( V_BUDGET_PERIOD
          , C1.DEPT_ID
          , C1.ACCOUNT_CONTROL_ID
          , C1.ACCOUNT_CODE
          , C1.SOB_ID
          , C1.ORG_ID
          , V_BUDGET_PERIOD_FR
          , V_BUDGET_PERIOD_TO
          , V_AMOUNT
          , V_BASE_MONTH_YN
          , 'Y'            
          , C1.DESCRIPTION
          , V_MONTH_SEQ
          , P_USER_ID 
          );
      END LOOP R1;
    END LOOP C1;    
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_PERIOD;

-- (년)예산책정 확정 처리.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CONFIRM
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_CODE_FR         IN VARCHAR2
            , W_DEPT_CODE_TO         IN VARCHAR2
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO      IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_STD_START_DATE          DATE;                   -- 연산년월 산출을 위한 일자 변수.
    V_STD_END_DATE            DATE;
  BEGIN
    -- 예산수립 INSERT --
    -- 회계기간.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(W_BUDGET_YEAR, W_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    /*RAISE_APPLICATION_ERROR(-20001, W_BUDGET_YEAR || '/' || W_DEPT_CODE_FR || '/' || W_DEPT_CODE_TO || '/' || 
                                    W_ACCOUNT_CODE_FR || '/' || W_ACCOUNT_CODE_TO || '/' || W_SOB_ID);*/
    -- 월별 예산 생성.
    FOR C1 IN ( SELECT BPM.BUDGET_PERIOD
                     , BPM.DEPT_ID
                     , BPM.ACCOUNT_CONTROL_ID
                     , BPM.ACCOUNT_CODE
                     , BPM.SOB_ID
                     , BPM.ORG_ID
                     , BPM.BUDGET_PERIOD_FR
                     , BPM.BUDGET_PERIOD_TO
                     , BPM.START_DATE
                     , BPM.END_DATE
                     , BPM.BASE_AMOUNT
                     , BPM.BASE_MONTH_YN
                     , BPM.ENABLED_YN
                     , BPM.DESCRIPTION
                     , BPM.MONTH_SEQ
                     , NVL(BA.CONTROL_YN, 'N') AS CONTROL_YN
                     , NVL(BA.ADD_YN, 'N') AS ADD_YN
                     , NVL(BA.MOVE_YN, 'N') AS MOVE_YN
                     , NVL(BA.NEXT_YN, 'N') AS NEXT_YN
                     , NVL(BA.PO_YN, 'N') AS PO_YN
                  FROM FI_BUDGET_PLAN_MONTH BPM
                    , FI_DEPT_MASTER DM
                    , FI_BUDGET_ACCOUNT BA
                WHERE BPM.DEPT_ID             = DM.DEPT_ID
                  AND BPM.ACCOUNT_CONTROL_ID  = BA.ACCOUNT_CONTROL_ID(+)
                  AND BPM.SOB_ID              = BA.SOB_ID(+)
                  AND BPM.BUDGET_PERIOD       BETWEEN TO_CHAR(V_STD_START_DATE, 'YYYY-MM') AND TO_CHAR(V_STD_END_DATE, 'YYYY-MM')
                  AND DM.DEPT_CODE            BETWEEN NVL(W_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(W_DEPT_CODE_TO, DM.DEPT_CODE)
                  AND BPM.ACCOUNT_CODE        BETWEEN NVL(W_ACCOUNT_CODE_FR, BPM.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, BPM.ACCOUNT_CODE)
                  AND BPM.SOB_ID              = W_SOB_ID
               ORDER BY DM.DEPT_CODE, BPM.ACCOUNT_CODE, BPM.BUDGET_PERIOD, BPM.MONTH_SEQ
              )
    LOOP
      UPDATE FI_BUDGET FB
      SET FB.BUDGET_PERIOD_FR     = C1.BUDGET_PERIOD_FR
        , FB.BUDGET_PERIOD_TO     = C1.BUDGET_PERIOD_TO
        , FB.START_DATE           = C1.START_DATE
        , FB.END_DATE             = C1.END_DATE
        , FB.BASE_AMOUNT          = NVL(C1.BASE_AMOUNT, 0)
        , FB.BASE_MONTH_YN        = NVL(C1.BASE_MONTH_YN, FB.BASE_MONTH_YN)
        , FB.MOVE_YN              = NVL(C1.MOVE_YN, FB.MOVE_YN)
        , FB.NEXT_YN              = NVL(C1.NEXT_YN, FB.NEXT_YN)
        , FB.ENABLED_YN           = NVL(C1.ENABLED_YN, 'N')
        , FB.DESCRIPTION          = C1.DESCRIPTION
        , FB.MONTH_SEQ            = C1.MONTH_SEQ
        , FB.LAST_UPDATE_DATE     = V_SYSDATE
        , FB.LAST_UPDATED_BY      = P_USER_ID
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
        , BUDGET_PERIOD_FR
        , BUDGET_PERIOD_TO
        , START_DATE
        , END_DATE
        , BASE_AMOUNT
        , BASE_MONTH_YN
        , MOVE_YN
        , NEXT_YN
        , ENABLED_YN
        , DESCRIPTION
        , MONTH_SEQ
        , CREATION_DATE			
        , CREATED_BY			
        , LAST_UPDATE_DATE			
        , LAST_UPDATED_BY		
        ) VALUES
        ( C1.BUDGET_PERIOD
        , C1.DEPT_ID
        , C1.ACCOUNT_CONTROL_ID
        , C1.ACCOUNT_CODE
        , C1.SOB_ID
        , C1.ORG_ID
        , C1.BUDGET_PERIOD_FR
        , C1.BUDGET_PERIOD_TO
        , C1.START_DATE
        , C1.END_DATE
        , NVL(C1.BASE_AMOUNT, 0)
        , NVL(C1.BASE_MONTH_YN, 'N')
        , NVL(C1.MOVE_YN, 'N')
        , NVL(C1.NEXT_YN, 'N')
        , NVL(C1.ENABLED_YN, 'N')
        , C1.DESCRIPTION
        , C1.MONTH_SEQ
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );
      END IF;
      
      -- 확정처리.
      UPDATE FI_BUDGET_PLAN_YEAR
        SET CONFIRM_YN          = 'Y'
          , CONFIRM_DATE        = V_SYSDATE
          , CONFIRM_PERSON_ID   = P_CONNECT_PERSON_ID
      WHERE BUDGET_YEAR         = W_BUDGET_YEAR
        AND DEPT_ID             = C1.DEPT_ID
        AND ACCOUNT_CONTROL_ID  = C1.ACCOUNT_CONTROL_ID
        AND SOB_ID              = C1.SOB_ID
        AND CONFIRM_YN          = 'N'
      ;
      
      -- 마감처리.
      EXE_BUDGET_PLAN_YEAR_CLOSE
              ( W_BUDGET_YEAR
              , C1.DEPT_ID
              , C1.ACCOUNT_CONTROL_ID
              , C1.SOB_ID
              , P_CONNECT_PERSON_ID
              , P_USER_ID
              , O_MESSAGE
              );
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END EXE_BUDGET_PLAN_YEAR_CONFIRM;
            
-- (년)예산책정 마감 처리.
  PROCEDURE EXE_BUDGET_PLAN_YEAR_CLOSE
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            , P_CONNECT_PERSON_ID    IN FI_BUDGET_PLAN_YEAR.CLOSED_PERSON_ID%TYPE
            , P_USER_ID              IN FI_BUDGET_PLAN_YEAR.CREATED_BY%TYPE
            , O_MESSAGE              OUT VARCHAR2
            )
  AS
  BEGIN
    -- 마감처리.
    UPDATE FI_BUDGET_PLAN_YEAR
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
  END EXE_BUDGET_PLAN_YEAR_CLOSE;

-- (년) 예산책정에서 일괄 예산수립 생성.
  PROCEDURE SAVE_BUDGET
            ( P_BUDGET_PERIOD      IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_DEPT_ID            IN FI_BUDGET_PLAN_MONTH.DEPT_ID%TYPE
            , P_ACCOUNT_CONTROL_ID IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE       IN FI_BUDGET_PLAN_MONTH.ACCOUNT_CODE%TYPE
            , P_SOB_ID             IN FI_BUDGET_PLAN_MONTH.SOB_ID%TYPE
            , P_ORG_ID             IN FI_BUDGET_PLAN_MONTH.ORG_ID%TYPE
            , P_BUDGET_PERIOD_FR   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BUDGET_PERIOD_TO   IN FI_BUDGET_PLAN_MONTH.BUDGET_PERIOD%TYPE
            , P_BASE_AMOUNT        IN FI_BUDGET_PLAN_MONTH.BASE_AMOUNT%TYPE
            , P_BASE_MONTH_YN      IN FI_BUDGET_PLAN_MONTH.BASE_MONTH_YN%TYPE
            , P_ENABLED_YN         IN FI_BUDGET_PLAN_MONTH.ENABLED_YN%TYPE            
            , P_DESCRIPTION        IN FI_BUDGET_PLAN_MONTH.DESCRIPTION%TYPE
            , P_MONTH_SEQ          IN FI_BUDGET_PLAN_MONTH.MONTH_SEQ%TYPE
            , P_USER_ID            IN FI_BUDGET_PLAN_MONTH.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE FI_BUDGET_PLAN_MONTH BPM
    SET BPM.BUDGET_PERIOD_FR      = P_BUDGET_PERIOD_FR
      , BPM.BUDGET_PERIOD_TO      = P_BUDGET_PERIOD_TO
      , BPM.START_DATE            = TRUNC(TO_DATE(P_BUDGET_PERIOD_FR, 'YYYY-MM'), 'MONTH')
      , BPM.END_DATE              = LAST_DAY(TO_DATE(P_BUDGET_PERIOD_TO, 'YYYY-MM'))
      , BPM.BASE_AMOUNT           = NVL(P_BASE_AMOUNT, 0)
      , BPM.BASE_MONTH_YN         = NVL(P_BASE_MONTH_YN, 'N')
      , BPM.ENABLED_YN            = NVL(P_ENABLED_YN, 'N')
      , BPM.DESCRIPTION           = P_DESCRIPTION
      , BPM.MONTH_SEQ             = P_MONTH_SEQ
      , BPM.LAST_UPDATE_DATE      = V_SYSDATE
      , BPM.LAST_UPDATED_BY       = P_USER_ID
    WHERE BPM.BUDGET_PERIOD       = P_BUDGET_PERIOD
      AND BPM.DEPT_ID             = P_DEPT_ID
      AND BPM.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
      AND BPM.SOB_ID              = P_SOB_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO FI_BUDGET_PLAN_MONTH
      ( BUDGET_PERIOD
      , DEPT_ID
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , SOB_ID			
      , ORG_ID
      , BUDGET_PERIOD_FR
      , BUDGET_PERIOD_TO
      , START_DATE
      , END_DATE
      , BASE_AMOUNT
      , BASE_MONTH_YN
      , ENABLED_YN
      , DESCRIPTION
      , MONTH_SEQ
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
      , P_BUDGET_PERIOD_FR
      , P_BUDGET_PERIOD_TO
      , TRUNC(TO_DATE(P_BUDGET_PERIOD_FR, 'YYYY-MM'), 'MONTH')
      , LAST_DAY(TO_DATE(P_BUDGET_PERIOD_TO, 'YYYY-MM'))
      , NVL(P_BASE_AMOUNT, 0)
      , NVL(P_BASE_MONTH_YN, 'N')
      , NVL(P_ENABLED_YN, 'N')
      , P_DESCRIPTION
      , P_MONTH_SEQ
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    END IF;
  END SAVE_BUDGET;

-- (년)예산 책정 확정 여부 체크.
  FUNCTION BUDGET_CONFIRM_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CONFIRM_YN        VARCHAR2(2) := 'N';    -- 확정 FLAG.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(BYP.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BYP
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
  
-- (년)예산 책정 마감 여부 체크.
  FUNCTION BUDGET_CLOSED_F
            ( W_BUDGET_YEAR          IN FI_BUDGET_PLAN_YEAR.BUDGET_YEAR%TYPE
            , W_DEPT_ID              IN FI_BUDGET_PLAN_YEAR.DEPT_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_BUDGET_PLAN_YEAR.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID               IN FI_BUDGET_PLAN_YEAR.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         VARCHAR2(2) := 'N';    -- 마감여부.
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(BYP.ACCOUNT_CONTROL_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BUDGET_PLAN_YEAR BYP
      WHERE BYP.BUDGET_YEAR         = W_BUDGET_YEAR
        AND BYP.DEPT_ID             = NVL(W_DEPT_ID, BYP.DEPT_ID)
        AND BYP.ACCOUNT_CONTROL_ID  = NVL(W_ACCOUNT_CONTROL_ID, BYP.ACCOUNT_CONTROL_ID)
        AND BYP.SOB_ID              = W_SOB_ID
        AND BYP.CLOSED_YN           = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      V_CLOSED_YN := 'N';
    ELSE
      V_CLOSED_YN := 'Y';
    END IF;
    RETURN V_CLOSED_YN;
  END BUDGET_CLOSED_F;
  
END FI_BUDGET_PLAN_G;
/
