CREATE OR REPLACE PACKAGE FI_BUDGET_ACCOUNT_G
AS

-- 예산계정 관리 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_ACCOUNT_CONTROL_ID  IN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID%TYPE
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            );

-- 예산계정 관리 수정.
  PROCEDURE UPDATE_BUDGET_ACCOUNT
            ( W_ACCOUNT_CONTROL_ID  IN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_REPEAT_PERIOD_COUNT IN FI_BUDGET_ACCOUNT.REPEAT_PERIOD_COUNT%TYPE
            , P_CONTROL_YN          IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE
            , P_ADD_YN              IN FI_BUDGET_ACCOUNT.ADD_YN%TYPE
            , P_MOVE_YN             IN FI_BUDGET_ACCOUNT.MOVE_YN%TYPE
            , P_NEXT_YN             IN FI_BUDGET_ACCOUNT.NEXT_YN%TYPE
            , P_PO_YN               IN FI_BUDGET_ACCOUNT.PO_YN%TYPE
            , P_DESCRIPTION         IN FI_BUDGET_ACCOUNT.DESCRIPTION%TYPE
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_BUDGET_ACCOUNT.CREATED_BY%TYPE 
            );
                       
-- 예산계정 관리 저장 : 계정통제에서 에산관리 Y 일 경우 적용.
  PROCEDURE SAVE_BUDGET_ACCOUNT
            ( P_ACCOUNT_CONTROL_ID  IN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            , P_CONTROL_YN          IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_BUDGET_ACCOUNT.CREATED_BY%TYPE 
            );

-----------------------------------------------------------------------------------------
-- 예산계정 전체 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT_ALL
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_ACCOUNT_CODE_FR     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_CODE_TO     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_DEPT_CODE_FR        IN VARCHAR2
            , P_DEPT_CODE_TO        IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_BUDGET_CONTROL_YN   IN VARCHAR2
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            );

-- 예산계정 - 가용예산 계정 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT_USE
          ( P_CURSOR              OUT TYPES.TCURSOR
          , P_BUDGET_YEAR         IN VARCHAR2
          , P_ACCOUNT_CODE_FR     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
          , P_ACCOUNT_CODE_TO     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
          , P_DEPT_CODE_FR        IN VARCHAR2
          , P_DEPT_CODE_TO        IN VARCHAR2
          , P_CONNECT_PERSON_ID   IN NUMBER
          , P_BUDGET_CONTROL_YN   IN VARCHAR2
          , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
          , P_CHECK_CAPACITY      IN VARCHAR2
          , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
          , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
          );

-- 예산계정 - (년)예산편성 계정 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT_PLAN
          ( P_CURSOR              OUT TYPES.TCURSOR
          , P_BUDGET_YEAR         IN VARCHAR2
          , P_ACCOUNT_CODE_FR     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
          , P_ACCOUNT_CODE_TO     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
          , P_DEPT_CODE_FR        IN VARCHAR2
          , P_DEPT_CODE_TO        IN VARCHAR2
          , P_CONNECT_PERSON_ID   IN NUMBER
          , P_BUDGET_CONTROL_YN   IN VARCHAR2
          , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
          , P_CHECK_CAPACITY      IN VARCHAR2
          , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
          , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
          );
          
-----------------------------------------------------------------------------------------                        
-- 예산 적용 시작/종료 년월.
  PROCEDURE BUDGET_PERIOD_FR_TO
            ( W_BUDGET_PERIOD        IN VARCHAR2
            , W_ACCOUNT_CONTROL_ID   IN NUMBER
            , W_SOB_ID               IN NUMBER
            , O_BUDGET_PERIOD_FR     OUT VARCHAR2
            , O_BUDGET_PERIOD_TO     OUT VARCHAR2
            , O_MONTH_SEQ            OUT NUMBER
            );
            
-----------------------------------------------------------------------------------------
-- 예산관리 계정 룩업.
  PROCEDURE LU_BUDGET_ACCOUNT_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , W_BUDGET_CONTROL_YN    IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE DEFAULT 'N'
            , W_ENABLED_YN           IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            );

-- 예산관리 계정 From ~ To.
  PROCEDURE LU_BUDGET_ACCOUNT_FROM_TO
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , W_BUDGET_CONTROL_YN    IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE DEFAULT 'N'
            , W_ENABLED_YN           IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            );
            
END FI_BUDGET_ACCOUNT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BUDGET_ACCOUNT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FI
/* Program Name : FI_BUDGET_ADD_G
/* Description  : 예산 계정 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 예산계정 관리 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_ACCOUNT_CONTROL_ID  IN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID%TYPE
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    OPEN P_CURSOR FOR
      SELECT BA.ACCOUNT_CONTROL_ID
          , AC.ACCOUNT_CODE
          , AC.ACCOUNT_DESC
          , BA.REPEAT_PERIOD_COUNT
          , BA.CONTROL_YN
          , BA.ADD_YN
          , BA.MOVE_YN
          , BA.NEXT_YN
          , BA.PO_YN
          , BA.DESCRIPTION
          , BA.ENABLED_YN
          , BA.EFFECTIVE_DATE_FR
          , BA.EFFECTIVE_DATE_TO
        FROM FI_BUDGET_ACCOUNT BA
          , FI_ACCOUNT_CONTROL AC
      WHERE BA.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND BA.ACCOUNT_CONTROL_ID       = NVL(P_ACCOUNT_CONTROL_ID, BA.ACCOUNT_CONTROL_ID)
        AND BA.SOB_ID                   = P_SOB_ID
        AND BA.ENABLED_YN               = DECODE(P_ENABLED_YN, 'Y', 'Y', BA.ENABLED_YN)
      ;
  END SELECT_BUDGET_ACCOUNT;

-- 예산계정 관리 수정.
  PROCEDURE UPDATE_BUDGET_ACCOUNT
            ( W_ACCOUNT_CONTROL_ID  IN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID%TYPE
            , W_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_REPEAT_PERIOD_COUNT IN FI_BUDGET_ACCOUNT.REPEAT_PERIOD_COUNT%TYPE
            , P_CONTROL_YN          IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE
            , P_ADD_YN              IN FI_BUDGET_ACCOUNT.ADD_YN%TYPE
            , P_MOVE_YN             IN FI_BUDGET_ACCOUNT.MOVE_YN%TYPE
            , P_NEXT_YN             IN FI_BUDGET_ACCOUNT.NEXT_YN%TYPE
            , P_PO_YN               IN FI_BUDGET_ACCOUNT.PO_YN%TYPE
            , P_DESCRIPTION         IN FI_BUDGET_ACCOUNT.DESCRIPTION%TYPE
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_BUDGET_ACCOUNT.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE FI_BUDGET_ACCOUNT
      SET REPEAT_PERIOD_COUNT = P_REPEAT_PERIOD_COUNT
        , CONTROL_YN          = P_CONTROL_YN
        , ADD_YN              = P_ADD_YN
        , MOVE_YN             = P_MOVE_YN
        , NEXT_YN             = P_NEXT_YN
        , PO_YN               = P_PO_YN
        , DESCRIPTION         = P_DESCRIPTION
        , ENABLED_YN          = P_ENABLED_YN
        , EFFECTIVE_DATE_FR   = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO   = P_EFFECTIVE_DATE_TO
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE ACCOUNT_CONTROL_ID  = W_ACCOUNT_CONTROL_ID
    ;
  END UPDATE_BUDGET_ACCOUNT;
  
-- 예산계정 관리 저장 : 계정통제에서 에산관리 Y 일 경우 적용.
  PROCEDURE SAVE_BUDGET_ACCOUNT
            ( P_ACCOUNT_CONTROL_ID  IN FI_BUDGET_ACCOUNT.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            , P_CONTROL_YN          IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_EFFECTIVE_DATE_FR   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO   IN FI_BUDGET_ACCOUNT.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID             IN FI_BUDGET_ACCOUNT.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN    
    UPDATE FI_BUDGET_ACCOUNT BA
      SET BA.CONTROL_YN         = P_CONTROL_YN
        , BA.ENABLED_YN         = P_ENABLED_YN
        , BA.EFFECTIVE_DATE_FR  = P_EFFECTIVE_DATE_FR
        , BA.EFFECTIVE_DATE_TO  = P_EFFECTIVE_DATE_TO
    WHERE BA.ACCOUNT_CONTROL_ID   = P_ACCOUNT_CONTROL_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT INTO FI_BUDGET_ACCOUNT
      ( ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE 
      , SOB_ID 
      , ORG_ID 
      , CONTROL_YN
      , ENABLED_YN 
      , EFFECTIVE_DATE_FR 
      , EFFECTIVE_DATE_TO 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_ACCOUNT_CONTROL_ID
      , P_ACCOUNT_CODE
      , P_SOB_ID
      , P_ORG_ID
      , P_CONTROL_YN
      , P_ENABLED_YN
      , P_EFFECTIVE_DATE_FR
      , P_EFFECTIVE_DATE_TO
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID );
    END IF;
  END SAVE_BUDGET_ACCOUNT;

-----------------------------------------------------------------------------------------
-- 예산계정 관리 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT_ALL
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_ACCOUNT_CODE_FR     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_CODE_TO     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_DEPT_CODE_FR        IN VARCHAR2
            , P_DEPT_CODE_TO        IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_BUDGET_CONTROL_YN   IN VARCHAR2
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
    V_CONNECT_PERSON_ID              NUMBER;
  BEGIN
    IF P_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(P_SOB_ID);
    END IF;

    OPEN P_CURSOR FOR
      SELECT BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.ACCOUNT_CONTROL_ID
           , BA.CONTROL_YN
           , BA.ADD_YN
           , BA.MOVE_YN
           , BA.NEXT_YN
           , BA.PO_YN
        FROM FI_BUDGET_ACCOUNT BA
          , FI_ACCOUNT_CONTROL AC
       WHERE BA.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(P_SOB_ID)
         AND BA.ACCOUNT_CODE            BETWEEN NVL(P_ACCOUNT_CODE_FR, BA.ACCOUNT_CODE) AND NVL(P_ACCOUNT_CODE_TO, BA.ACCOUNT_CODE)
         AND BA.SOB_ID                  = P_SOB_ID
         AND BA.CONTROL_YN              = DECODE(P_BUDGET_CONTROL_YN, 'Y', 'Y', BA.CONTROL_YN)
         AND BA.ENABLED_YN              = DECODE(P_ENABLED_YN, 'Y', 'Y', BA.ENABLED_YN)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
      ORDER BY BA.ACCOUNT_CODE
      ;
  END SELECT_BUDGET_ACCOUNT_ALL;

-- 예산계정 - 가용예산 계정 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT_USE
            ( P_CURSOR              OUT TYPES.TCURSOR
            , P_BUDGET_YEAR         IN VARCHAR2
            , P_ACCOUNT_CODE_FR     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_CODE_TO     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , P_DEPT_CODE_FR        IN VARCHAR2
            , P_DEPT_CODE_TO        IN VARCHAR2
            , P_CONNECT_PERSON_ID   IN NUMBER
            , P_BUDGET_CONTROL_YN   IN VARCHAR2
            , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            , P_CHECK_CAPACITY      IN VARCHAR2
            , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
    V_CONNECT_PERSON_ID              NUMBER;
    V_STD_START_DATE                 DATE;                   -- 연산년월 산출을 위한 일자 변수.
    V_STD_END_DATE                   DATE;
  BEGIN
    IF P_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(P_SOB_ID);
    END IF;
    
    -- 예산 담당자 여부 체크.
    V_CONNECT_PERSON_ID := P_CONNECT_PERSON_ID;
    IF P_CHECK_CAPACITY = 'N' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      IF P_CHECK_CAPACITY = 'C' AND FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
        V_CONNECT_PERSON_ID := NULL;
      END IF;
    END IF;

    -- 해당 년도에 적용 기간 조회.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(P_BUDGET_YEAR, P_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);
    
    /*RAISE_APPLICATION_ERROR(-20001, P_BUDGET_YEAR || '/' || P_DEPT_CODE_FR || '/' || P_DEPT_CODE_TO || '/' || 
                                    P_ACCOUNT_CODE_FR || '/' || P_ACCOUNT_CODE_TO || '/' || P_SOB_ID || '/' || V_CONNECT_PERSON_ID || '/' ||
                                    V_STD_START_DATE || '/' || V_STD_END_DATE);*/
                                    
    OPEN P_CURSOR FOR
      SELECT BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.ACCOUNT_CONTROL_ID
           , BA.CONTROL_YN
           , BA.ADD_YN
           , BA.MOVE_YN
           , BA.NEXT_YN
           , BA.PO_YN
        FROM FI_BUDGET_ACCOUNT BA
          , FI_ACCOUNT_CONTROL AC
       WHERE BA.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(P_SOB_ID)
         AND BA.ACCOUNT_CODE            BETWEEN NVL(P_ACCOUNT_CODE_FR, BA.ACCOUNT_CODE) AND NVL(P_ACCOUNT_CODE_TO, BA.ACCOUNT_CODE)
         AND BA.SOB_ID                  = P_SOB_ID
         AND BA.CONTROL_YN              = DECODE(P_BUDGET_CONTROL_YN, 'Y', 'Y', BA.CONTROL_YN)
         AND BA.ENABLED_YN              = DECODE(P_ENABLED_YN, 'Y', 'Y', BA.ENABLED_YN)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_END_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_START_DATE, BA.EFFECTIVE_DATE_TO))
         AND EXISTS 
               ( SELECT 'X'
                   FROM FI_BUDGET FB
                     , FI_DEPT_MASTER DM
                     , FI_BUDGET_CONTROL BC
                 WHERE FB.DEPT_ID         = DM.DEPT_ID
                   AND DM.DEPT_ID         = BC.DEPT_ID
                   AND FB.ACCOUNT_CONTROL_ID  = BA.ACCOUNT_CONTROL_ID
                   AND FB.BUDGET_PERIOD   BETWEEN TO_CHAR(V_STD_START_DATE, 'YYYY-MM') AND TO_CHAR(V_STD_END_DATE, 'YYYY-MM')
                   AND DM.DEPT_CODE       BETWEEN NVL(P_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(P_DEPT_CODE_TO, DM.DEPT_CODE)
                   AND BC.PERSON_ID       = NVL(V_CONNECT_PERSON_ID, BC.PERSON_ID)
               )
      ORDER BY BA.ACCOUNT_CODE
      ;
  END SELECT_BUDGET_ACCOUNT_USE;

-- 예산계정 - (년)예산편성 계정 조회.
  PROCEDURE SELECT_BUDGET_ACCOUNT_PLAN
          ( P_CURSOR              OUT TYPES.TCURSOR
          , P_BUDGET_YEAR         IN VARCHAR2
          , P_ACCOUNT_CODE_FR     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
          , P_ACCOUNT_CODE_TO     IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
          , P_DEPT_CODE_FR        IN VARCHAR2
          , P_DEPT_CODE_TO        IN VARCHAR2
          , P_CONNECT_PERSON_ID   IN NUMBER
          , P_BUDGET_CONTROL_YN   IN VARCHAR2
          , P_ENABLED_YN          IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
          , P_CHECK_CAPACITY      IN VARCHAR2
          , P_SOB_ID              IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
          , P_ORG_ID              IN FI_BUDGET_ACCOUNT.ORG_ID%TYPE
          )
  AS
    V_STD_DATE                       DATE := NULL;
    V_CONNECT_PERSON_ID              NUMBER;
  BEGIN
    IF P_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(P_SOB_ID);
    END IF;
    
    -- 예산 담당자 여부 체크.
    V_CONNECT_PERSON_ID := P_CONNECT_PERSON_ID;
    IF P_CHECK_CAPACITY = 'N' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      IF P_CHECK_CAPACITY = 'C' AND FI_BUDGET_CONTROL_G.BUDGET_MANAGER_CAP_F(P_CONNECT_PERSON_ID, P_SOB_ID) = 'Y' THEN
        V_CONNECT_PERSON_ID := NULL;
      END IF;
    END IF;
                                   
    OPEN P_CURSOR FOR
      SELECT BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.ACCOUNT_CONTROL_ID
           , BA.CONTROL_YN
           , BA.ADD_YN
           , BA.MOVE_YN
           , BA.NEXT_YN
           , BA.PO_YN
        FROM FI_BUDGET_ACCOUNT BA
          , FI_ACCOUNT_CONTROL AC          
       WHERE BA.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(P_SOB_ID)
         AND BA.ACCOUNT_CODE            BETWEEN NVL(P_ACCOUNT_CODE_FR, BA.ACCOUNT_CODE) AND NVL(P_ACCOUNT_CODE_TO, BA.ACCOUNT_CODE)
         AND BA.SOB_ID                  = P_SOB_ID
         AND BA.CONTROL_YN              = DECODE(P_BUDGET_CONTROL_YN, 'Y', 'Y', BA.CONTROL_YN)
         AND BA.ENABLED_YN              = DECODE(P_ENABLED_YN, 'Y', 'Y', BA.ENABLED_YN)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(TRUNC(V_STD_DATE, 'YEAR'), BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(LAST_DAY(V_STD_DATE), BA.EFFECTIVE_DATE_TO))
         AND EXISTS 
               ( SELECT 'X'
                   FROM FI_BUDGET_PLAN_YEAR BPY
                     , FI_DEPT_MASTER DM
                     , FI_BUDGET_CONTROL BC
                 WHERE BPY.DEPT_ID            = DM.DEPT_ID
                   AND DM.DEPT_ID             = BC.DEPT_ID
                   AND BPY.ACCOUNT_CONTROL_ID = BA.ACCOUNT_CONTROL_ID
                   AND BPY.BUDGET_YEAR        = P_BUDGET_YEAR
                   AND DM.DEPT_CODE           BETWEEN NVL(P_DEPT_CODE_FR, DM.DEPT_CODE) AND NVL(P_DEPT_CODE_TO, DM.DEPT_CODE)
                   AND BC.PERSON_ID           = NVL(V_CONNECT_PERSON_ID, BC.PERSON_ID)
               )
      ORDER BY BA.ACCOUNT_CODE
      ;
  END SELECT_BUDGET_ACCOUNT_PLAN;
  
-----------------------------------------------------------------------------------------                        
-- 예산 적용 시작/종료 년월.
  PROCEDURE BUDGET_PERIOD_FR_TO
            ( W_BUDGET_PERIOD        IN VARCHAR2
            , W_ACCOUNT_CONTROL_ID   IN NUMBER
            , W_SOB_ID               IN NUMBER
            , O_BUDGET_PERIOD_FR     OUT VARCHAR2
            , O_BUDGET_PERIOD_TO     OUT VARCHAR2
            , O_MONTH_SEQ            OUT NUMBER
            )
  AS
    V_REPEAT_PERIOD_COUNT     NUMBER := 0;
    V_STD_START_DATE          DATE;                   -- 연산년월 산출을 위한 일자 변수.
    V_STD_END_DATE            DATE;
    V_BUDGET_YEAR             VARCHAR2(4) := NULL;    -- 예산년도.
    V_BUDGET_PERIOD           VARCHAR2(7) := NULL;    -- 예산년월.
    V_BUDGET_PERIOD_FR        VARCHAR2(7) := NULL;    -- 예산 시작 적용 년월.
    V_BUDGET_PERIOD_TO        VARCHAR2(7) := NULL;    -- 예산 종료 적용 년월.
    V_NEXT_COUNT              NUMBER := 1;            -- 이월 COUNT.
  BEGIN
    -- 임시 테이블 삭제.
    DELETE FROM FI_TEMP_GT;
    
    V_BUDGET_YEAR := SUBSTR(W_BUDGET_PERIOD, 1, 4);
    -- 회계기간.
    GL_FISCAL_YEAR_G.FISCAL_YEAR_DATE_P(V_BUDGET_YEAR, W_SOB_ID, V_STD_START_DATE, V_STD_END_DATE);

    BEGIN
      SELECT BA.REPEAT_PERIOD_COUNT
        INTO V_REPEAT_PERIOD_COUNT
        FROM FI_BUDGET_ACCOUNT BA
      WHERE BA.ACCOUNT_CONTROL_ID = W_ACCOUNT_CONTROL_ID
        AND BA.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_REPEAT_PERIOD_COUNT := 1;
    END;

    FOR R1 IN 1 .. 12
    LOOP
      V_BUDGET_PERIOD := TO_CHAR(ADD_MONTHS(V_STD_START_DATE, (R1 - 1)), 'YYYY-MM');
      -- 예산금액 설정.
      IF V_NEXT_COUNT = 1 THEN
        V_BUDGET_PERIOD_FR := V_BUDGET_PERIOD;
        IF NVL(V_REPEAT_PERIOD_COUNT, 1) <= 1 THEN
          V_BUDGET_PERIOD_TO := V_BUDGET_PERIOD_FR;
        ELSE
          V_BUDGET_PERIOD_TO := TO_CHAR(ADD_MONTHS(TO_DATE(V_BUDGET_PERIOD_FR, 'YYYY-MM'), NVL(V_REPEAT_PERIOD_COUNT, 1) - 1), 'YYYY-MM');
        END IF;
      END IF;
        
      -- 이월 FLAG 설정.
      IF V_NEXT_COUNT < NVL(V_REPEAT_PERIOD_COUNT, 1) THEN
        V_NEXT_COUNT := V_NEXT_COUNT + 1;
      ELSE
        V_NEXT_COUNT := 1;
      END IF;
      
      -- 임시 테이블 INSERT.
      INSERT INTO FI_TEMP_GT
      ( TEMP_FLAG
      , VARCHAR_1
      , VARCHAR_2
      , VARCHAR_3
      , NUM_1
      ) VALUES
      ( 'BUDGET_PERIOD'
      , V_BUDGET_PERIOD
      , V_BUDGET_PERIOD_FR
      , V_BUDGET_PERIOD_TO
      , R1
      );
    END LOOP R1;
    COMMIT;
    
    BEGIN
      SELECT TG.VARCHAR_2
           , TG.VARCHAR_3
           , TG.NUM_1
        INTO O_BUDGET_PERIOD_FR
           , O_BUDGET_PERIOD_TO
           , O_MONTH_SEQ
        FROM FI_TEMP_GT TG
      WHERE TG.TEMP_FLAG      = 'BUDGET_PERIOD'
        AND TG.VARCHAR_1      = W_BUDGET_PERIOD
      ;    
    EXCEPTION WHEN OTHERS THEN
      O_BUDGET_PERIOD_FR := W_BUDGET_PERIOD;
      O_BUDGET_PERIOD_TO := W_BUDGET_PERIOD;
      O_MONTH_SEQ := TO_NUMBER(TO_CHAR(TO_DATE(W_BUDGET_PERIOD, 'YYYY-MM'), 'MM'));
    END;
  END BUDGET_PERIOD_FR_TO;
  
-----------------------------------------------------------------------------------------
-- 예산관리 계정 룩업.
  PROCEDURE LU_BUDGET_ACCOUNT_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , W_BUDGET_CONTROL_YN    IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE DEFAULT 'N'
            , W_ENABLED_YN           IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;
    OPEN P_CURSOR3 FOR
      SELECT BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.ACCOUNT_CONTROL_ID
           , BA.CONTROL_YN
           , BA.ADD_YN
           , BA.MOVE_YN
           , BA.NEXT_YN
           , BA.PO_YN
        FROM FI_BUDGET_ACCOUNT BA
          , FI_ACCOUNT_CONTROL AC
       WHERE BA.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(W_SOB_ID)
         AND BA.SOB_ID                  = W_SOB_ID
         AND BA.CONTROL_YN              = DECODE(W_BUDGET_CONTROL_YN, 'Y', 'Y', BA.CONTROL_YN)
         AND BA.ENABLED_YN              = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_YN)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
      ORDER BY BA.ACCOUNT_CODE
      ;
  END LU_BUDGET_ACCOUNT_CODE;

-- 예산관리 계정 From ~ To.
  PROCEDURE LU_BUDGET_ACCOUNT_FROM_TO
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ACCOUNT_CODE_FR      IN FI_BUDGET_ACCOUNT.ACCOUNT_CODE%TYPE
            , W_SOB_ID               IN FI_BUDGET_ACCOUNT.SOB_ID%TYPE
            , W_BUDGET_CONTROL_YN    IN FI_BUDGET_ACCOUNT.CONTROL_YN%TYPE DEFAULT 'N'
            , W_ENABLED_YN           IN FI_BUDGET_ACCOUNT.ENABLED_YN%TYPE
            )
  AS
    V_STD_DATE                       DATE := NULL;
  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT BA.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , BA.ACCOUNT_CONTROL_ID
           , BA.CONTROL_YN
           , BA.ADD_YN
           , BA.MOVE_YN
           , BA.NEXT_YN
           , BA.PO_YN
        FROM FI_BUDGET_ACCOUNT BA
          , FI_ACCOUNT_CONTROL AC
       WHERE BA.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND AC.ACCOUNT_SET_ID          = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(W_SOB_ID)
         AND BA.ACCOUNT_CODE            >= NVL(W_ACCOUNT_CODE_FR, BA.ACCOUNT_CODE)
         AND BA.SOB_ID                  = W_SOB_ID
         AND BA.CONTROL_YN              = DECODE(W_BUDGET_CONTROL_YN, 'Y', 'Y', BA.CONTROL_YN)
         AND BA.ENABLED_YN              = DECODE(W_ENABLED_YN, 'Y', 'Y', BA.ENABLED_YN)
         AND BA.EFFECTIVE_DATE_FR       <= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_FR)
         AND (BA.EFFECTIVE_DATE_TO IS NULL OR BA.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, BA.EFFECTIVE_DATE_TO))
      ORDER BY BA.ACCOUNT_CODE
      ;      
  END LU_BUDGET_ACCOUNT_FROM_TO;
  
END FI_BUDGET_ACCOUNT_G;
/
