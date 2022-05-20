CREATE OR REPLACE PACKAGE GL_FISCAL_PERIOD_G
AS

-- 회계 기간 조회.
  PROCEDURE SELECT_FISCAL_PERIOD
            ( P_CURSOR                 OUT TYPES.TCURSOR
            , W_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            );

-- 회계기간 삽입.
  PROCEDURE INSERT_FISCAL_PERIOD
            ( P_PERIOD_NAME            IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE
            , P_FISCAL_CALENDAR_ID     IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
            , P_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , P_PERIOD_STATUS          IN GL_FISCAL_PERIOD.PERIOD_STATUS%TYPE
            , P_START_DATE             IN GL_FISCAL_PERIOD.START_DATE%TYPE
            , P_END_DATE               IN GL_FISCAL_PERIOD.END_DATE%TYPE
            , P_QUARTER_NUM            IN GL_FISCAL_PERIOD.QUARTER_NUM%TYPE
            , P_HALF_NUM               IN GL_FISCAL_PERIOD.HALF_NUM%TYPE
            , P_PERIOD_TYPE            IN GL_FISCAL_PERIOD.PERIOD_TYPE%TYPE
            , P_ADJUSTMENT_PERIOD_FLAG IN GL_FISCAL_PERIOD.ADJUSTMENT_PERIOD_FLAG%TYPE
            , P_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            );

-- 회계기간 수정.
  PROCEDURE UPDATE_FISCAL_PERIOD
            ( W_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , W_PERIOD_NAME            IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE
            , P_PERIOD_STATUS          IN GL_FISCAL_PERIOD.PERIOD_STATUS%TYPE
            , P_START_DATE             IN GL_FISCAL_PERIOD.START_DATE%TYPE
            , P_END_DATE               IN GL_FISCAL_PERIOD.END_DATE%TYPE
            , P_QUARTER_NUM            IN GL_FISCAL_PERIOD.QUARTER_NUM%TYPE
            , P_HALF_NUM               IN GL_FISCAL_PERIOD.HALF_NUM%TYPE
            , P_PERIOD_TYPE            IN GL_FISCAL_PERIOD.PERIOD_TYPE%TYPE
            , P_ADJUSTMENT_PERIOD_FLAG IN GL_FISCAL_PERIOD.ADJUSTMENT_PERIOD_FLAG%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            );

-- 회계기간 마감.
  PROCEDURE CLOSE_FISCAL_PERIOD
            ( W_PERIOD_NAME            IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            );
                        
-- 회계 기간 일괄생성.
  PROCEDURE CREATE_FISCAL_PERIOD
            ( P_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , P_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            , O_MESSAGE                OUT VARCHAR2
            );

-- 회계 기간 기존 자료수.
  PROCEDURE FISCAL_PERIOD_COUNT_P
            ( W_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , O_RETURN_VALUE           OUT NUMBER
            );
                        
-- 회계 상태 Default value.
  PROCEDURE DV_PERIOD_STATUS
            ( W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , O_PERIOD_STATUS          OUT FI_PERIOD_STATUS_V.PERIOD_STATUS%TYPE
            , O_PERIOD_STATUS_NAME     OUT FI_PERIOD_STATUS_V.PERIOD_STATUS_NAME%TYPE
            );

-- 회계 상태 Lookup.
  PROCEDURE LU_PERIOD_STATUS
            ( P_CURSOR3                OUT TYPES.TCURSOR3
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            );

-- 회계 타입 Lookup.
  PROCEDURE LU_PERIOD_TYPE
            ( P_CURSOR3                OUT TYPES.TCURSOR3
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            );
            
-- 년월 조회 LOOK UP.
  PROCEDURE LU_PERIOD_NAME
            ( P_CURSOR2                OUT TYPES.TCURSOR2
            , W_PERIOD_NAME_FR         IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE DEFAULT NULL
            , W_PERIOD_NAME_TO         IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE DEFAULT NULL
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            );
            
-- 회계기간 상태 FUNCTION.
  FUNCTION PERIOD_STATUS_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN VARCHAR2;

-- 회계년월 FUNCTION.
  FUNCTION PERIOD_NAME_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN VARCHAR2;
           
-- 회계기간의 분기 FUNCTION.
  FUNCTION PERIOD_QUARTER_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN NUMBER;
           
-- 회계기간의 반기 FUNCTION.
  FUNCTION PERIOD_HALF_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN NUMBER;
           
-- 회계기간의 년도 FUNCTION.
  FUNCTION PERIOD_YEAR_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN VARCHAR2;
           
END GL_FISCAL_PERIOD_G;


 
/
CREATE OR REPLACE PACKAGE BODY GL_FISCAL_PERIOD_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : GL_FISCAL_PERIOD_G
/* Description  : 회계 기간 관리.
/*
/* Reference by : 
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 회계 기간 조회.
  PROCEDURE SELECT_FISCAL_PERIOD
            ( P_CURSOR                 OUT TYPES.TCURSOR
            , W_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            )
  AS
	BEGIN
    OPEN P_CURSOR FOR
      SELECT FP.FISCAL_YEAR_ID
           , FP.PERIOD_NAME
           , FP.PERIOD_STATUS
           , PS.PERIOD_STATUS_NAME
           , FP.START_DATE
           , FP.END_DATE
           , FP.QUARTER_NUM
           , FP.HALF_NUM
           , FP.PERIOD_TYPE
           , PT.PERIOD_TYPE_NAME
           , FP.ADJUSTMENT_PERIOD_FLAG
           , FP.FISCAL_CALENDAR_ID
        FROM GL_FISCAL_PERIOD FP
          , FI_PERIOD_TYPE_V PT
          , FI_PERIOD_STATUS_V PS
       WHERE FP.PERIOD_TYPE             = PT.PERIOD_TYPE
         AND FP.SOB_ID                  = PT.SOB_ID
         AND FP.PERIOD_STATUS           = PS.PERIOD_STATUS
         AND FP.SOB_ID                  = PS.SOB_ID
         AND FP.FISCAL_YEAR_ID          = W_FISCAL_YEAR_ID
         AND FP.SOB_ID                  = W_SOB_ID
         /*AND FP.ORG_ID                  = W_ORG_ID*/
      ORDER BY FP.PERIOD_NAME
      ;

	END SELECT_FISCAL_PERIOD;

-- 회계기간 삽입.
  PROCEDURE INSERT_FISCAL_PERIOD
            ( P_PERIOD_NAME            IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE
            , P_FISCAL_CALENDAR_ID     IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
            , P_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , P_PERIOD_STATUS          IN GL_FISCAL_PERIOD.PERIOD_STATUS%TYPE
            , P_START_DATE             IN GL_FISCAL_PERIOD.START_DATE%TYPE
            , P_END_DATE               IN GL_FISCAL_PERIOD.END_DATE%TYPE
            , P_QUARTER_NUM            IN GL_FISCAL_PERIOD.QUARTER_NUM%TYPE
            , P_HALF_NUM               IN GL_FISCAL_PERIOD.HALF_NUM%TYPE
            , P_PERIOD_TYPE            IN GL_FISCAL_PERIOD.PERIOD_TYPE%TYPE
            , P_ADJUSTMENT_PERIOD_FLAG IN GL_FISCAL_PERIOD.ADJUSTMENT_PERIOD_FLAG%TYPE
            , P_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            )
  AS
	  V_SYSDATE                          GL_FISCAL_PERIOD.CREATION_DATE%TYPE;
    V_PERIOD_YEAR                      GL_FISCAL_PERIOD.PERIOD_YEAR%TYPE;
    V_PERIOD_NUM                       GL_FISCAL_PERIOD.PERIOD_NUM%TYPE;
    
	BEGIN
	  V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_PERIOD_YEAR := SUBSTR(P_PERIOD_NAME, 1, 4);
    V_PERIOD_NUM := TO_NUMBER(SUBSTR(P_PERIOD_NAME, 6, 2));
    INSERT INTO GL_FISCAL_PERIOD
    ( PERIOD_NAME
    , FISCAL_CALENDAR_ID
    , FISCAL_YEAR_ID
    , PERIOD_STATUS 
    , START_DATE 
    , END_DATE 
    , QUARTER_NUM 
    , HALF_NUM 
    , PERIOD_TYPE 
    , PERIOD_YEAR 
    , PERIOD_NUM 
    , ADJUSTMENT_PERIOD_FLAG 
    , SOB_ID 
    , ORG_ID
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_PERIOD_NAME
    , P_FISCAL_CALENDAR_ID
    , P_FISCAL_YEAR_ID
    , P_PERIOD_STATUS
    , P_START_DATE
    , P_END_DATE
    , P_QUARTER_NUM
    , P_HALF_NUM
    , P_PERIOD_TYPE
    , V_PERIOD_YEAR
    , V_PERIOD_NUM
    , P_ADJUSTMENT_PERIOD_FLAG
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

	END INSERT_FISCAL_PERIOD;

-- 회계기간 수정.
  PROCEDURE UPDATE_FISCAL_PERIOD
            ( W_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , W_PERIOD_NAME            IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE
            , P_PERIOD_STATUS          IN GL_FISCAL_PERIOD.PERIOD_STATUS%TYPE
            , P_START_DATE             IN GL_FISCAL_PERIOD.START_DATE%TYPE
            , P_END_DATE               IN GL_FISCAL_PERIOD.END_DATE%TYPE
            , P_QUARTER_NUM            IN GL_FISCAL_PERIOD.QUARTER_NUM%TYPE
            , P_HALF_NUM               IN GL_FISCAL_PERIOD.HALF_NUM%TYPE
            , P_PERIOD_TYPE            IN GL_FISCAL_PERIOD.PERIOD_TYPE%TYPE
            , P_ADJUSTMENT_PERIOD_FLAG IN GL_FISCAL_PERIOD.ADJUSTMENT_PERIOD_FLAG%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            )
  AS
    V_PERIOD_YEAR                      GL_FISCAL_PERIOD.PERIOD_YEAR%TYPE;
    V_PERIOD_NUM                       GL_FISCAL_PERIOD.PERIOD_NUM%TYPE;
  BEGIN
    V_PERIOD_YEAR := SUBSTR(W_PERIOD_NAME, 1, 4);
    V_PERIOD_NUM := TO_NUMBER(SUBSTR(W_PERIOD_NAME, 6, 2));
    
    UPDATE GL_FISCAL_PERIOD
      SET PERIOD_STATUS          = P_PERIOD_STATUS
        , START_DATE             = P_START_DATE
        , END_DATE               = P_END_DATE
        , QUARTER_NUM            = P_QUARTER_NUM
        , HALF_NUM               = P_HALF_NUM
        , PERIOD_TYPE            = P_PERIOD_TYPE
        , PERIOD_YEAR            = V_PERIOD_YEAR
        , PERIOD_NUM             = V_PERIOD_NUM
        , ADJUSTMENT_PERIOD_FLAG = P_ADJUSTMENT_PERIOD_FLAG
        , LAST_UPDATE_DATE       = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY        = P_USER_ID
    WHERE FISCAL_YEAR_ID         = W_FISCAL_YEAR_ID
      AND PERIOD_NAME            = W_PERIOD_NAME
      AND SOB_ID                 = W_SOB_ID
/*      AND ORG_ID                 = W_ORG_ID*/;

  END UPDATE_FISCAL_PERIOD;

-- 회계기간 마감.
  PROCEDURE CLOSE_FISCAL_PERIOD
            ( W_PERIOD_NAME            IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            )
  AS
  BEGIN 
    UPDATE GL_FISCAL_PERIOD FP
      SET FP.PERIOD_STATUS       = 'C'
        , FP.LAST_UPDATE_DATE    = GET_LOCAL_DATE(SOB_ID)
        , FP.LAST_UPDATED_BY     = P_USER_ID
    WHERE FP.FISCAL_CALENDAR_ID  = FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID)
      AND FP.PERIOD_NAME         = W_PERIOD_NAME
      AND FP.SOB_ID              = W_SOB_ID
/*      AND ORG_ID                 = W_ORG_ID*/
    ;

  END CLOSE_FISCAL_PERIOD;
  
-- 회계 기간 일괄생성.
  PROCEDURE CREATE_FISCAL_PERIOD
            ( P_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , P_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , P_USER_ID                IN GL_FISCAL_PERIOD.CREATED_BY%TYPE
            , O_MESSAGE                OUT VARCHAR2
            )
  AS
    V_SYSDATE                          DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_PERIOD_NAME                      GL_FISCAL_PERIOD.PERIOD_NAME%TYPE;
    V_PERIOD_YEAR                      GL_FISCAL_PERIOD.PERIOD_YEAR%TYPE;
    V_PERIOD_NUM                       GL_FISCAL_PERIOD.PERIOD_NUM%TYPE;
    V_QUARTER_NUM                      NUMBER := 0;
    V_HALF_NUM                         NUMBER := 0;
    V_R1                               NUMBER :=0;
    
  BEGIN
    -- 마감 자료 존재시 삭제 불가.
    BEGIN
      SELECT COUNT(FP.PERIOD_NAME) AS RECORD_COUNT
        INTO V_R1
        FROM GL_FISCAL_PERIOD FP
       WHERE FP.FISCAL_YEAR_ID          = P_FISCAL_YEAR_ID
         AND FP.SOB_ID                  = P_SOB_ID
         AND FP.PERIOD_STATUS           IN('C')
      ;
    EXCEPTION WHEN OTHERS THEN
      V_R1 := 0;
    END;
    IF V_R1 > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10169', NULL));
      RETURN;
    END IF;
        
    -- 기존 자료 삭제.
    BEGIN
      DELETE FROM GL_FISCAL_PERIOD FP
      WHERE FP.FISCAL_YEAR_ID      = P_FISCAL_YEAR_ID
        AND FP.SOB_ID              = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Delete Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    FOR C1 IN ( SELECT FY.FISCAL_YEAR_ID
                     , FY.FISCAL_CALENDAR_ID
                     , FY.START_DATE
                     , FY.END_DATE
                     , MONTHS_BETWEEN(FY.END_DATE + 1, FY.START_DATE) AS MONTH_COUNT
                  FROM GL_FISCAL_YEAR FY
                WHERE FY.FISCAL_YEAR_ID   = P_FISCAL_YEAR_ID
                  AND FY.SOB_ID           = P_SOB_ID
              )
    LOOP
      FOR R1 IN 1 .. C1.MONTH_COUNT
      LOOP
        V_R1 := R1 - 1;
        V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.START_DATE, V_R1), 'YYYY-MM');
        V_PERIOD_YEAR := SUBSTR(V_PERIOD_NAME, 1, 4);
        V_PERIOD_NUM := TO_NUMBER(SUBSTR(V_PERIOD_NAME, 6, 2));
        SELECT CASE 
                 WHEN V_PERIOD_NUM BETWEEN 1 AND 3 THEN 1
                 WHEN V_PERIOD_NUM BETWEEN 4 AND 6 THEN 2
                 WHEN V_PERIOD_NUM BETWEEN 7 AND 9 THEN 3
                 ELSE 4
               END AS QUARTER_NUM
             , CASE
                 WHEN V_PERIOD_NUM < 7 THEN 1
                 ELSE 2
               END AS HALF_NUM          
          INTO V_QUARTER_NUM, V_HALF_NUM
          FROM DUAL;
        
        INSERT INTO GL_FISCAL_PERIOD
        ( PERIOD_NAME
        , FISCAL_CALENDAR_ID
        , FISCAL_YEAR_ID
        , PERIOD_STATUS 
        , START_DATE 
        , END_DATE 
        , QUARTER_NUM 
        , HALF_NUM 
        , PERIOD_TYPE 
        , PERIOD_YEAR 
        , PERIOD_NUM 
        , ADJUSTMENT_PERIOD_FLAG 
        , SOB_ID 
        , ORG_ID
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY )
        VALUES
        ( V_PERIOD_NAME
        , C1.FISCAL_CALENDAR_ID
        , C1.FISCAL_YEAR_ID
        , 'N'
        , ADD_MONTHS(C1.START_DATE, V_R1)
        , ADD_MONTHS(C1.START_DATE, V_R1 + 1) - 1
        , V_QUARTER_NUM
        , V_HALF_NUM
        , 'MONTH'
        , V_PERIOD_YEAR
        , V_PERIOD_NUM
        , 'N'
        , P_SOB_ID
        , P_ORG_ID
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID );
      
      END LOOP R1;
    END LOOP C1;
    COMMIT;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    
  END CREATE_FISCAL_PERIOD;

-- 회계 기간 기존 자료수.
  PROCEDURE FISCAL_PERIOD_COUNT_P
            ( W_FISCAL_YEAR_ID         IN GL_FISCAL_PERIOD.FISCAL_YEAR_ID%TYPE
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , O_RETURN_VALUE           OUT NUMBER
            )
  AS
  BEGIN
    BEGIN
      SELECT COUNT(FP.PERIOD_NAME) AS RECORD_COUNT
        INTO O_RETURN_VALUE
        FROM GL_FISCAL_PERIOD FP
       WHERE FP.FISCAL_YEAR_ID          = W_FISCAL_YEAR_ID
         AND FP.SOB_ID                  = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RETURN_VALUE := 0;
    END;
    
  END FISCAL_PERIOD_COUNT_P;
    
-- 회계 상태 Default value.
  PROCEDURE DV_PERIOD_STATUS
            ( W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            , O_PERIOD_STATUS          OUT FI_PERIOD_STATUS_V.PERIOD_STATUS%TYPE
            , O_PERIOD_STATUS_NAME     OUT FI_PERIOD_STATUS_V.PERIOD_STATUS_NAME%TYPE
            )
  AS
  BEGIN
    SELECT PS.PERIOD_STATUS_NAME
         , PS.PERIOD_STATUS
      INTO O_PERIOD_STATUS_NAME
         , O_PERIOD_STATUS
      FROM FI_PERIOD_STATUS_V PS
     WHERE PS.SOB_ID            = W_SOB_ID
       /*AND PS.ORG_ID            = W_ORG_ID*/
       AND PS.ENABLED_FLAG      = 'Y'
       AND PS.DEFAULT_FLAG      = 'Y'
       AND ROWNUM               <= 1
    ;
  END DV_PERIOD_STATUS;
  
-- 회계 상태 Lookup.
  PROCEDURE LU_PERIOD_STATUS
            ( P_CURSOR3                OUT TYPES.TCURSOR3
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PS.PERIOD_STATUS_NAME
           , PS.PERIOD_STATUS
        FROM FI_PERIOD_STATUS_V PS
       WHERE PS.SOB_ID            = W_SOB_ID
         /*AND PS.ORG_ID            = W_ORG_ID*/
         AND PS.ENABLED_FLAG      = 'Y'
      ORDER BY PS.PERIOD_STATUS
      ;

	END LU_PERIOD_STATUS;

-- 회계 타입 Lookup.
  PROCEDURE LU_PERIOD_TYPE
            ( P_CURSOR3                OUT TYPES.TCURSOR3
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                 IN GL_FISCAL_PERIOD.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PT.PERIOD_TYPE_NAME
           , PT.PERIOD_TYPE
        FROM FI_PERIOD_TYPE_V PT
       WHERE PT.SOB_ID            = W_SOB_ID
         /*AND PT.ORG_ID            = W_ORG_ID*/
         AND PT.ENABLED_FLAG      = 'Y'
      ORDER BY PT.PERIOD_TYPE
      ;
  
  END LU_PERIOD_TYPE;
  
-- 년월 조회 LOOK UP.
  PROCEDURE LU_PERIOD_NAME
            ( P_CURSOR2                OUT TYPES.TCURSOR2
            , W_PERIOD_NAME_FR         IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE DEFAULT NULL
            , W_PERIOD_NAME_TO         IN GL_FISCAL_PERIOD.PERIOD_NAME%TYPE DEFAULT NULL
            , W_SOB_ID                 IN GL_FISCAL_PERIOD.SOB_ID%TYPE
            )
  AS
    V_PERIOD_NAME_TO                   GL_FISCAL_PERIOD.PERIOD_NAME%TYPE;
    
  BEGIN
    V_PERIOD_NAME_TO := TO_CHAR(ADD_MONTHS(GET_LOCAL_DATE(W_SOB_ID), 1), 'YYYY-MM');
    
    OPEN P_CURSOR2 FOR
      SELECT FP.PERIOD_NAME
           , FP.PERIOD_STATUS
           , PS.PERIOD_STATUS_NAME
           , FP.START_DATE
           , FP.END_DATE           
        FROM GL_FISCAL_PERIOD FP
          , FI_PERIOD_STATUS_V PS
      WHERE FP.PERIOD_STATUS           = PS.PERIOD_STATUS
        AND FP.SOB_ID                  = PS.SOB_ID
        AND FP.PERIOD_NAME             BETWEEN NVL(W_PERIOD_NAME_FR, FP.PERIOD_NAME) AND NVL(W_PERIOD_NAME_TO, V_PERIOD_NAME_TO)
        AND FP.SOB_ID                  = W_SOB_ID
        AND EXISTS ( SELECT 'X'
                      FROM GL_FISCAL_YEAR FY
                    WHERE FY.FISCAL_YEAR_ID       = FP.FISCAL_YEAR_ID
                      AND FY.FISCAL_CALENDAR_ID   = FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID)
                  )
         /*AND FP.ORG_ID                  = W_ORG_ID*/
      ORDER BY FP.PERIOD_NAME DESC
      ;
      
  END LU_PERIOD_NAME;   
  
-- 회계기간 상태 FUNCTION.
  FUNCTION PERIOD_STATUS_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_FISCAL_CALENDAR_ID               GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE;
    V_RESULT                           VARCHAR2(10) := NULL;
    
  BEGIN
    IF W_FISCAL_CALENDAR_ID IS NULL THEN
       V_FISCAL_CALENDAR_ID := FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID);
    ELSE
      V_FISCAL_CALENDAR_ID := W_FISCAL_CALENDAR_ID;
    END IF;
    
    BEGIN
      SELECT FP.PERIOD_STATUS
        INTO V_RESULT
        FROM GL_FISCAL_PERIOD FP
       WHERE FP.START_DATE              <= W_GL_DATE
         AND FP.END_DATE                >= W_GL_DATE
         AND FP.SOB_ID                  = W_SOB_ID
         AND EXISTS ( SELECT 'X'
                        FROM GL_FISCAL_YEAR FY
                      WHERE FY.FISCAL_YEAR_ID       = FP.FISCAL_YEAR_ID
                        AND FY.FISCAL_CALENDAR_ID   = V_FISCAL_CALENDAR_ID
                    )
        /* AND FP.ORG_ID                  = W_ORG_ID*/
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT := 'N';
    END;
    RETURN V_RESULT;
    
  END PERIOD_STATUS_F;
  
-- 회계년월 FUNCTION.
  FUNCTION PERIOD_NAME_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_FISCAL_CALENDAR_ID               GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE;
    V_RESULT                           VARCHAR2(10) := NULL;
    
  BEGIN
    IF W_FISCAL_CALENDAR_ID IS NULL THEN
       V_FISCAL_CALENDAR_ID := FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID);
    ELSE
      V_FISCAL_CALENDAR_ID := W_FISCAL_CALENDAR_ID;
    END IF;
    
    BEGIN
      SELECT FP.PERIOD_NAME
        INTO V_RESULT
        FROM GL_FISCAL_PERIOD FP
       WHERE FP.START_DATE              <= W_GL_DATE
         AND FP.END_DATE                >= W_GL_DATE
         AND FP.SOB_ID                  = W_SOB_ID
          AND EXISTS ( SELECT 'X'
                        FROM GL_FISCAL_YEAR FY
                      WHERE FY.FISCAL_YEAR_ID       = FP.FISCAL_YEAR_ID
                        AND FY.FISCAL_CALENDAR_ID   = V_FISCAL_CALENDAR_ID
                    )
/*         AND FP.ORG_ID                  = W_ORG_ID*/
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT := NULL;
    END;
    RETURN V_RESULT;
  
  END PERIOD_NAME_F;
           
-- 회계기간의 분기 FUNCTION.
  FUNCTION PERIOD_QUARTER_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN NUMBER
  AS
    V_FISCAL_CALENDAR_ID               GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE;
    V_RESULT                           NUMBER := NULL;
    
  BEGIN
    IF W_FISCAL_CALENDAR_ID IS NULL THEN
       V_FISCAL_CALENDAR_ID := FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID);
    ELSE
      V_FISCAL_CALENDAR_ID := W_FISCAL_CALENDAR_ID;
    END IF;
    
    BEGIN
      SELECT FP.QUARTER_NUM
        INTO V_RESULT
        FROM GL_FISCAL_PERIOD FP
      WHERE FP.START_DATE              <= W_GL_DATE
        AND FP.END_DATE                >= W_GL_DATE
        AND FP.SOB_ID                  = W_SOB_ID
        AND EXISTS ( SELECT 'X'
                      FROM GL_FISCAL_YEAR FY
                    WHERE FY.FISCAL_YEAR_ID       = FP.FISCAL_YEAR_ID
                      AND FY.FISCAL_CALENDAR_ID   = V_FISCAL_CALENDAR_ID
                  )
/*         AND FP.ORG_ID                  = W_ORG_ID*/
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT := NULL;
    END;
    RETURN V_RESULT;
  
  END PERIOD_QUARTER_F;
           
-- 회계기간의 반기 FUNCTION.
  FUNCTION PERIOD_HALF_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN NUMBER
  AS
    V_FISCAL_CALENDAR_ID               GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE;
    V_RESULT                           NUMBER := NULL;
    
  BEGIN
    IF W_FISCAL_CALENDAR_ID IS NULL THEN
       V_FISCAL_CALENDAR_ID := FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID);
    ELSE
      V_FISCAL_CALENDAR_ID := W_FISCAL_CALENDAR_ID;
    END IF;
    
    BEGIN
      SELECT FP.HALF_NUM
        INTO V_RESULT
        FROM GL_FISCAL_PERIOD FP
      WHERE FP.START_DATE              <= W_GL_DATE
        AND FP.END_DATE                >= W_GL_DATE
        AND FP.SOB_ID                  = W_SOB_ID
        AND EXISTS ( SELECT 'X'
                      FROM GL_FISCAL_YEAR FY
                    WHERE FY.FISCAL_YEAR_ID       = FP.FISCAL_YEAR_ID
                      AND FY.FISCAL_CALENDAR_ID   = V_FISCAL_CALENDAR_ID
                  )
/*         AND FP.ORG_ID                  = W_ORG_ID*/
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT := NULL;
    END;
    RETURN V_RESULT;
  
  END PERIOD_HALF_F;
           
-- 회계기간의 년도 FUNCTION.
  FUNCTION PERIOD_YEAR_F
           ( W_FISCAL_CALENDAR_ID      IN GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE
           , W_GL_DATE                 IN GL_FISCAL_PERIOD.START_DATE%TYPE
           , W_SOB_ID                  IN GL_FISCAL_PERIOD.SOB_ID%TYPE
           , W_ORG_ID                  IN GL_FISCAL_PERIOD.ORG_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_FISCAL_CALENDAR_ID               GL_FISCAL_PERIOD.FISCAL_CALENDAR_ID%TYPE;
    V_RESULT                           VARCHAR2(10) := NULL;
    
  BEGIN 
    IF W_FISCAL_CALENDAR_ID IS NULL THEN
       V_FISCAL_CALENDAR_ID := FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(W_SOB_ID);
    ELSE
      V_FISCAL_CALENDAR_ID := W_FISCAL_CALENDAR_ID;
    END IF;
    
    BEGIN
      SELECT FP.PERIOD_YEAR
        INTO V_RESULT
        FROM GL_FISCAL_PERIOD FP
      WHERE FP.START_DATE              <= W_GL_DATE
        AND FP.END_DATE                >= W_GL_DATE
        AND FP.SOB_ID                  = W_SOB_ID
        AND EXISTS ( SELECT 'X'
                      FROM GL_FISCAL_YEAR FY
                    WHERE FY.FISCAL_YEAR_ID       = FP.FISCAL_YEAR_ID
                      AND FY.FISCAL_CALENDAR_ID   = V_FISCAL_CALENDAR_ID
                  )
/*         AND FP.ORG_ID                  = W_ORG_ID*/
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RESULT := NULL;
    END;
    RETURN V_RESULT;
    
  END PERIOD_YEAR_F;
           
END GL_FISCAL_PERIOD_G;
/
