CREATE OR REPLACE PACKAGE GL_FISCAL_YEAR_G
AS

-- 회계년도 조회.
  PROCEDURE SELECT_FISCAL_YEAR
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_FISCAL_CALENDAR_ID    IN GL_FISCAL_YEAR.FISCAL_CALENDAR_ID%TYPE
            , W_FISCAL_YEAR           IN GL_FISCAL_YEAR.FISCAL_YEAR%TYPE
            , W_SOB_ID                IN GL_FISCAL_YEAR.SOB_ID%TYPE
            , W_ORG_ID                IN GL_FISCAL_YEAR.ORG_ID%TYPE
            );

-- 회계년도 삽입.
  PROCEDURE INSERT_FISCAL_YEAR
            ( P_FISCAL_YEAR_ID        OUT GL_FISCAL_YEAR.FISCAL_YEAR_ID%TYPE
            , P_FISCAL_CALENDAR_ID    IN GL_FISCAL_YEAR.FISCAL_CALENDAR_ID%TYPE
            , P_FISCAL_COUNT          IN GL_FISCAL_YEAR.FISCAL_COUNT%TYPE
            , P_FISCAL_YEAR           IN GL_FISCAL_YEAR.FISCAL_YEAR%TYPE
            , P_START_DATE            IN GL_FISCAL_YEAR.START_DATE%TYPE
            , P_END_DATE              IN GL_FISCAL_YEAR.END_DATE%TYPE
            , P_SOB_ID                IN GL_FISCAL_YEAR.SOB_ID%TYPE
            , P_ORG_ID                IN GL_FISCAL_YEAR.ORG_ID%TYPE
            , P_USER_ID               IN GL_FISCAL_YEAR.CREATED_BY%TYPE
            );

-- 회계년도 수정.
  PROCEDURE UPDATE_FISCAL_YEAR
            ( W_FISCAL_YEAR_ID        IN GL_FISCAL_YEAR.FISCAL_YEAR_ID%TYPE
            , P_FISCAL_COUNT          IN GL_FISCAL_YEAR.FISCAL_COUNT%TYPE
            , P_FISCAL_YEAR           IN GL_FISCAL_YEAR.FISCAL_YEAR%TYPE
            , P_START_DATE            IN GL_FISCAL_YEAR.START_DATE%TYPE
            , P_END_DATE              IN GL_FISCAL_YEAR.END_DATE%TYPE
            , P_USER_ID               IN GL_FISCAL_YEAR.CREATED_BY%TYPE
            );

-- 회계년도의 시작/종료일자 리턴.
  PROCEDURE FISCAL_YEAR_DATE_P
            ( P_PERIOD_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , O_START_DATE        OUT DATE
            , O_END_DATE          OUT DATE            
            );
            
-- 회계 기수 조회(함수).
  FUNCTION FISCAL_YEAR_COUNT_F
            ( W_PERIOD_YEAR       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            ) RETURN VARCHAR2;

-- 회계 기수 조회(프로시져).
  PROCEDURE FISCAL_YEAR_COUNT_P
            ( W_PERIOD_YEAR       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_YEAR_COUNT        OUT VARCHAR2
            );
            
END GL_FISCAL_YEAR_G;


 
/
CREATE OR REPLACE PACKAGE BODY GL_FISCAL_YEAR_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : GL_FISCAL_YEAR_G
/* Description  : 회계 달력에 대한 회계연도 관리.
/*
/* Reference by : 인사 시스템 모듈 담당자 관리 .
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 회계년도 조회.
  PROCEDURE SELECT_FISCAL_YEAR
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_FISCAL_CALENDAR_ID    IN GL_FISCAL_YEAR.FISCAL_CALENDAR_ID%TYPE
            , W_FISCAL_YEAR           IN GL_FISCAL_YEAR.FISCAL_YEAR%TYPE
            , W_SOB_ID                IN GL_FISCAL_YEAR.SOB_ID%TYPE
            , W_ORG_ID                IN GL_FISCAL_YEAR.ORG_ID%TYPE
            )
  AS
	BEGIN
    OPEN P_CURSOR FOR
      SELECT FY.FISCAL_YEAR_ID
           , FY.FISCAL_CALENDAR_ID
           , FY.FISCAL_COUNT
           , FY.FISCAL_YEAR
           , FY.START_DATE
           , FY.END_DATE
           , SOB.SOB_DESCRIPTION
        FROM GL_FISCAL_YEAR FY
          , EAPP_SET_OF_BOOKS_TLV SOB
       WHERE FY.SOB_ID                  = SOB.SOB_ID
         AND FY.FISCAL_CALENDAR_ID      = W_FISCAL_CALENDAR_ID
         AND FY.FISCAL_YEAR             = NVL(W_FISCAL_YEAR, FY.FISCAL_YEAR)
         AND FY.SOB_ID                  = W_SOB_ID
      ORDER BY FY.FISCAL_YEAR DESC
      ;

	END SELECT_FISCAL_YEAR;

-- 회계년도 삽입.
  PROCEDURE INSERT_FISCAL_YEAR
            ( P_FISCAL_YEAR_ID        OUT GL_FISCAL_YEAR.FISCAL_YEAR_ID%TYPE
            , P_FISCAL_CALENDAR_ID    IN GL_FISCAL_YEAR.FISCAL_CALENDAR_ID%TYPE
            , P_FISCAL_COUNT          IN GL_FISCAL_YEAR.FISCAL_COUNT%TYPE
            , P_FISCAL_YEAR           IN GL_FISCAL_YEAR.FISCAL_YEAR%TYPE
            , P_START_DATE            IN GL_FISCAL_YEAR.START_DATE%TYPE
            , P_END_DATE              IN GL_FISCAL_YEAR.END_DATE%TYPE
            , P_SOB_ID                IN GL_FISCAL_YEAR.SOB_ID%TYPE
            , P_ORG_ID                IN GL_FISCAL_YEAR.ORG_ID%TYPE
            , P_USER_ID               IN GL_FISCAL_YEAR.CREATED_BY%TYPE
            )
  AS
	  V_SYSDATE                  GL_FISCAL_YEAR.CREATION_DATE%TYPE;

	BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

    SELECT GL_FISCAL_YEAR_S1.NEXTVAL
      INTO P_FISCAL_YEAR_ID
      FROM DUAL;

    INSERT INTO GL_FISCAL_YEAR
    ( FISCAL_YEAR_ID
    , FISCAL_CALENDAR_ID
    , FISCAL_COUNT 
    , FISCAL_YEAR 
    , START_DATE 
    , END_DATE 
    , SOB_ID 
    , ORG_ID
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_FISCAL_YEAR_ID
    , P_FISCAL_CALENDAR_ID
    , P_FISCAL_COUNT
    , P_FISCAL_YEAR
    , P_START_DATE
    , P_END_DATE
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

	END INSERT_FISCAL_YEAR;

-- 회계년도 수정.
  PROCEDURE UPDATE_FISCAL_YEAR
            ( W_FISCAL_YEAR_ID        IN GL_FISCAL_YEAR.FISCAL_YEAR_ID%TYPE
            , P_FISCAL_COUNT          IN GL_FISCAL_YEAR.FISCAL_COUNT%TYPE
            , P_FISCAL_YEAR           IN GL_FISCAL_YEAR.FISCAL_YEAR%TYPE
            , P_START_DATE            IN GL_FISCAL_YEAR.START_DATE%TYPE
            , P_END_DATE              IN GL_FISCAL_YEAR.END_DATE%TYPE
            , P_USER_ID               IN GL_FISCAL_YEAR.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE GL_FISCAL_YEAR
      SET FISCAL_COUNT     = P_FISCAL_COUNT
        , FISCAL_YEAR      = P_FISCAL_YEAR
        , START_DATE       = P_START_DATE
        , END_DATE         = P_END_DATE
        , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE FISCAL_YEAR_ID   = W_FISCAL_YEAR_ID
    ;

  END UPDATE_FISCAL_YEAR;

-- 회계년도의 시작/종료일자 리턴.
  PROCEDURE FISCAL_YEAR_DATE_P
            ( P_PERIOD_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , O_START_DATE        OUT DATE
            , O_END_DATE          OUT DATE            
            )
  AS
    V_PERIOD_YEAR                 VARCHAR2(4);
  BEGIN
    IF P_PERIOD_YEAR IS NULL THEN
      V_PERIOD_YEAR := TO_CHAR(SYSDATE, 'YYYY');
    ELSE 
      V_PERIOD_YEAR := P_PERIOD_YEAR;
    END IF;
    BEGIN
      SELECT FY.START_DATE
           , FY.END_DATE
        INTO O_START_DATE
           , O_END_DATE
        FROM GL_FISCAL_YEAR FY
      WHERE FY.FISCAL_YEAR            = V_PERIOD_YEAR
        AND FY.FISCAL_CALENDAR_ID     = FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID)
        AND FY.SOB_ID                 = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_START_DATE := TO_DATE(V_PERIOD_YEAR || '-01-01', 'YYYY-MM-DD');
      O_END_DATE := TO_DATE(V_PERIOD_YEAR || '-12-31', 'YYYY-MM-DD');
    END;
  END FISCAL_YEAR_DATE_P;
  
-- 회계 기수 조회.
  FUNCTION FISCAL_YEAR_COUNT_F
            ( W_PERIOD_YEAR       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            ) RETURN VARCHAR2
  AS
    V_YEAR_COUNT                  NUMBER := 1;
  BEGIN
    BEGIN
      SELECT FY.FISCAL_COUNT
        INTO V_YEAR_COUNT
        FROM GL_FISCAL_YEAR FY
      WHERE FY.FISCAL_YEAR              = W_PERIOD_YEAR
        AND FY.FISCAL_CALENDAR_ID       = FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID)
        AND FY.SOB_ID                   = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_COUNT := 1;
    END;
    RETURN TO_CHAR(V_YEAR_COUNT);
  END FISCAL_YEAR_COUNT_F;

-- 회계 기수 조회(프로시져).
  PROCEDURE FISCAL_YEAR_COUNT_P
            ( W_PERIOD_YEAR       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_YEAR_COUNT        OUT VARCHAR2
            )
  AS
  BEGIN
    O_YEAR_COUNT := FISCAL_YEAR_COUNT_F(W_PERIOD_YEAR, W_SOB_ID);
  END FISCAL_YEAR_COUNT_P;
  
END GL_FISCAL_YEAR_G;
/
