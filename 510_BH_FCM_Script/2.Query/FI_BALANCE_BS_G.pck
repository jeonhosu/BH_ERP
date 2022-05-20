CREATE OR REPLACE PACKAGE FI_BALANCE_BS_G
AS
-- 대차대조표(월) 조회 : 증감율.
  PROCEDURE SELECT_BALANCE_BS_MONTH
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 대차대조표(월) 조회 : 장부가액.
  PROCEDURE SELECT_BALANCE_BS_MONTH_1
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 대차대조표 (년)조회 : 증감율.
  PROCEDURE SELECT_BALANCE_BS_YEAR
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );
            
-- 대차대조표 (년말)조회 : 증감율.
  PROCEDURE SELECT_BALANCE_BS_12
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );
            
-- 대차대조표 (월) 생성(증감율).
  PROCEDURE CREATE_BALANCE_BS_MONTH
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 대차대조표 (월)생성(장부가액).
  PROCEDURE CREATE_BALANCE_BS_MONTH_1
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 대차대조표 (년)생성(증감율).
  PROCEDURE CREATE_BALANCE_BS_YEAR
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 대차대조표 (전년 12월말 대비)생성(증감율).
  PROCEDURE CREATE_BALANCE_BS_12
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );
            
-- 미처분이익잉여금(증감율).
  FUNCTION FREE_SURPLUS_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

-- 미처분이익잉여금(장부가액).
  FUNCTION FREE_SURPLUS_1_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_SOB_ID            IN NUMBER
            ) RETURN NUMBER;

-- 기수 및 기간 설정.
  PROCEDURE PROMPT_PERIOD_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            );

-- 그리드 프롬프트 설정(기수).
  PROCEDURE PROMPT_YEAR_COUNT_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            );
            
END FI_BALANCE_BS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BALANCE_BS_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_BS_G
/* Description  : 대차대조표 생성/조회.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 대차대조표 (월)조회 : 증감율.
  PROCEDURE SELECT_BALANCE_BS_MONTH
            ( P_CURSOR            OUT TYPES.TCURSOR 
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_11_SUM                 NUMBER := 0;
    V_PREV_11_SUM                 NUMBER := 0;
    V_THIS_14_SUM                 NUMBER := 0;
    V_PREV_14_SUM                 NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1002'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    -- 대차대조표 생성.
    CREATE_BALANCE_BS_MONTH
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );
    BEGIN
      SELECT SUM(DECODE(FH.FORM_ITEM_CLASS, '11', BB.THIS_L_AMOUNT, 0)) AS THIS_11_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '11', BB.PREV_L_AMOUNT, 0)) AS PREV_11_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '14', BB.THIS_L_AMOUNT, 0)) AS THIS_14_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '14', BB.PREV_L_AMOUNT, 0)) AS PREV_14_SUM
        INTO V_THIS_11_SUM, V_PREV_11_SUM, V_THIS_14_SUM, V_PREV_14_SUM
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_ITEM_CLASS          IN ('11', '14')
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    OPEN P_CURSOR FOR
      SELECT SX1.HEADER_CODE
           , CASE
               WHEN SX1.SEQ_NUM_YN = 'Y' THEN '    ' || ROW_NUMBER() OVER (PARTITION BY SX1.SEQ_GROUP ORDER BY SX1.SEQ_GROUP, SX1.SORT_SEQ) || '.' || LTRIM(SX1.HEADER_NAME)
               ELSE SX1.HEADER_NAME
             END AS HEADER_NAME
           , CASE
               WHEN SX1.THIS_L_AMOUNT < 0 THEN 
                 CASE
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.THIS_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
             END AS THIS_L_AMOUNT
           , CASE
               WHEN SX1.THIS_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.THIS_RATE, 'FM990.00') || '%' 
             END AS THIS_RATE
           , CASE
               WHEN SX1.PREV_L_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.PREV_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
             END AS PREV_L_AMOUNT
           , CASE
               WHEN SX1.PREV_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.PREV_RATE, 'FM990.00') || '%'
             END AS PREV_RATE
           , CASE
               WHEN NVL(SX1.CHANGE_AMOUNT, 0) < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.CHANGE_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999')
             END AS CHANGE_AMOUNT
           , CASE
               WHEN SX1.CHANGE_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.CHANGE_RATE, 'FM990.00') || '%'
             END AS CHANGE_RATE
           , NVL(SX1.SUM_YN, 'N') AS SUM_YN
        FROM (SELECT BB.HEADER_CODE
                   , BB.HEADER_NAME AS HEADER_NAME
                   , BB.SORT_SEQ
                   , BB.THIS_L_AMOUNT AS THIS_L_AMOUNT
                   , CASE
                       WHEN V_THIS_11_SUM = 0 THEN TO_NUMBER(NULL)
                       ELSE ROUND((BB.THIS_L_AMOUNT 
                                   / CASE 
                                       WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN V_THIS_11_SUM
                                       ELSE V_THIS_14_SUM
                                     END) * 100, 2)
                     END AS THIS_RATE
                   , BB.PREV_L_AMOUNT AS PREV_L_AMOUNT
                   , CASE
                       WHEN V_PREV_11_SUM = 0 THEN TO_NUMBER(NULL)
                       ELSE ROUND((BB.PREV_L_AMOUNT 
                                   / CASE 
                                       WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN V_PREV_11_SUM
                                       ELSE V_PREV_14_SUM
                                     END) * 100, 2) 
                     END AS PREV_RATE
                   , BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT AS CHANGE_AMOUNT
                   , CASE
                       WHEN BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT IS NULL THEN NULL
                       WHEN NVL(BB.PREV_L_AMOUNT, 0) = 0 THEN 0
                       ELSE ROUND((((NVL(BB.THIS_L_AMOUNT, 0) - NVL(BB.PREV_L_AMOUNT, 0))) / NVL(BB.PREV_L_AMOUNT, 0)) * 100, 2)  
                     END AS CHANGE_RATE
                   , FH.MINUS_SIGN_DISPLAY
                   , CASE
                       WHEN FH.FORM_ITEM_TYPE = '101' THEN 'N'
                       WHEN FH.LAST_LEVEL_YN = 'Y' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.FORM_ITEM_TYPE = '101' THEN '-'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND FH.FORM_ITEM_CODE IN ('1240510') THEN FH.FORM_ITEM_CODE
                       WHEN FH.LAST_LEVEL_YN = 'Y' THEN SUBSTR(FH.FORM_ITEM_CODE, 1, 3) 
                       ELSE '-'
                     END AS SEQ_GROUP
                   , CASE
                       WHEN FH.FORM_ITEM_CLASS IN('11', '12', '13', '14') THEN 'Y'
                       ELSE 'N'
                     END AS SUM_YN
                FROM FI_BALANCE_BS BB
                  , FI_FORM_HEADER FH
              WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BB.THIS_L_AMOUNT           <> 0
                 OR BB.PREV_L_AMOUNT            <> 0
                 OR BB.ITEM_LEVEL               IN(1, 2))
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
      
  END SELECT_BALANCE_BS_MONTH;

-- 대차대조표 (월)조회 : 장부가액.
  PROCEDURE SELECT_BALANCE_BS_MONTH_1
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1002'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    -- 대차대조표 생성.
    CREATE_BALANCE_BS_MONTH_1
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );
    
    OPEN P_CURSOR FOR
      SELECT SX1.HEADER_CODE
           , SX1.HEADER_NAME
           , CASE
               WHEN SX1.THIS_L_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.THIS_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
             END AS THIS_L_AMOUNT
           , CASE
               WHEN SX1.THIS_R_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.THIS_R_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.THIS_R_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.THIS_R_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.THIS_R_AMOUNT), 'FM999,999,999,999')
             END AS THIS_R_AMOUNT
           , CASE
               WHEN SX1.PREV_L_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.PREV_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
             END AS PREV_L_AMOUNT
           , CASE
               WHEN SX1.PREV_R_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.PREV_R_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.PREV_R_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.PREV_R_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.PREV_R_AMOUNT), 'FM999,999,999,999')
             END AS PREV_R_AMOUNT
           , NVL(SX1.SUM_YN, 'N') AS SUM_YN
        FROM (SELECT BB.HEADER_CODE
                   , /*CASE
                       WHEN BB.LAST_LEVEL_YN = 'Y' THEN TO_CHAR(ROW_NUMBER() OVER (PARTITION BY SUBSTR(BB.HEADER_CODE, 1, 3), BB.ITEM_LEVEL ORDER BY BB.SORT_SEQ)) || '.'
                       ELSE NULL
                     END ||*/ BB.HEADER_NAME AS HEADER_NAME
                   , BB.SORT_SEQ
                   , BB.THIS_L_AMOUNT AS THIS_L_AMOUNT
                   , BB.THIS_R_AMOUNT AS THIS_R_AMOUNT
                   , BB.PREV_L_AMOUNT AS PREV_L_AMOUNT
                   , BB.PREV_R_AMOUNT AS PREV_R_AMOUNT
                   , FH.MINUS_SIGN_DISPLAY
                   , CASE
                       WHEN FH.FORM_ITEM_CLASS IN('11', '12', '13', '14') THEN 'Y'
                       ELSE 'N'
                     END AS SUM_YN
                FROM FI_BALANCE_BS BB
                  , FI_FORM_HEADER FH
              WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BB.THIS_L_AMOUNT           <> 0
                 OR BB.PREV_L_AMOUNT            <> 0
                 OR BB.ITEM_LEVEL               IN(1, 2))
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
  END SELECT_BALANCE_BS_MONTH_1;

-- 대차대조표 (년)조회 : 증감율.
  PROCEDURE SELECT_BALANCE_BS_YEAR
            ( P_CURSOR            OUT TYPES.TCURSOR 
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_11_SUM                 NUMBER := 0;
    V_PREV_11_SUM                 NUMBER := 0;
    V_THIS_14_SUM                 NUMBER := 0;
    V_PREV_14_SUM                 NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1002'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    -- 대차대조표 생성.
    CREATE_BALANCE_BS_YEAR
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );
    BEGIN
      SELECT SUM(DECODE(FH.FORM_ITEM_CLASS, '11', BB.THIS_L_AMOUNT, 0)) AS THIS_11_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '11', BB.PREV_L_AMOUNT, 0)) AS PREV_11_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '14', BB.THIS_L_AMOUNT, 0)) AS THIS_14_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '14', BB.PREV_L_AMOUNT, 0)) AS PREV_14_SUM
        INTO V_THIS_11_SUM, V_PREV_11_SUM, V_THIS_14_SUM, V_PREV_14_SUM
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_ITEM_CLASS          IN ('11', '14')
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    OPEN P_CURSOR FOR
      SELECT SX1.HEADER_CODE
           , CASE
               WHEN SX1.SEQ_NUM_YN = 'Y' THEN '    ' || ROW_NUMBER() OVER (PARTITION BY SX1.SEQ_GROUP ORDER BY SX1.SEQ_GROUP, SX1.SORT_SEQ) || '.' || LTRIM(SX1.HEADER_NAME)
               ELSE SX1.HEADER_NAME
             END AS HEADER_NAME
           , CASE
               WHEN SX1.THIS_L_AMOUNT < 0 THEN 
                 CASE
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.THIS_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
             END AS THIS_L_AMOUNT
           , CASE
               WHEN SX1.THIS_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.THIS_RATE, 'FM990.00') || '%' 
             END AS THIS_RATE
           , CASE
               WHEN SX1.PREV_L_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.PREV_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
             END AS PREV_L_AMOUNT
           , CASE
               WHEN SX1.PREV_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.PREV_RATE, 'FM990.00') || '%'
             END AS PREV_RATE
           , CASE
               WHEN NVL(SX1.CHANGE_AMOUNT, 0) < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.CHANGE_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999')
             END AS CHANGE_AMOUNT
           , CASE
               WHEN SX1.CHANGE_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.CHANGE_RATE, 'FM990.00') || '%'
             END AS CHANGE_RATE
           , NVL(SX1.SUM_YN, 'N') AS SUM_YN
        FROM (SELECT BB.HEADER_CODE
                   , BB.HEADER_NAME AS HEADER_NAME
                   , BB.SORT_SEQ
                   , BB.THIS_L_AMOUNT AS THIS_L_AMOUNT
                   , CASE
                       WHEN V_THIS_11_SUM = 0 THEN TO_NUMBER(NULL)
                       ELSE ROUND((BB.THIS_L_AMOUNT 
                                   / CASE 
                                       WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN V_THIS_11_SUM
                                       ELSE V_THIS_14_SUM
                                     END) * 100, 2)
                     END AS THIS_RATE
                   , BB.PREV_L_AMOUNT AS PREV_L_AMOUNT
                   , CASE
                       WHEN V_PREV_11_SUM = 0 THEN TO_NUMBER(NULL)
                       ELSE ROUND((BB.PREV_L_AMOUNT 
                                   / CASE 
                                       WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN V_PREV_11_SUM
                                       ELSE V_PREV_14_SUM
                                     END) * 100, 2) 
                     END AS PREV_RATE
                   , BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT AS CHANGE_AMOUNT
                   , CASE
                       WHEN BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT IS NULL THEN NULL
                       WHEN NVL(BB.PREV_L_AMOUNT, 0) = 0 THEN 0
                       ELSE ROUND((((NVL(BB.THIS_L_AMOUNT, 0) - NVL(BB.PREV_L_AMOUNT, 0))) / NVL(BB.PREV_L_AMOUNT, 0)) * 100, 2)  
                     END AS CHANGE_RATE
                   , FH.MINUS_SIGN_DISPLAY
                   , CASE
                       WHEN FH.FORM_ITEM_TYPE = '101' THEN 'N'
                       WHEN FH.LAST_LEVEL_YN = 'Y' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.FORM_ITEM_TYPE = '101' THEN '-'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND FH.FORM_ITEM_CODE IN ('1240510') THEN FH.FORM_ITEM_CODE
                       WHEN FH.LAST_LEVEL_YN = 'Y' THEN SUBSTR(FH.FORM_ITEM_CODE, 1, 3) 
                       ELSE '-'
                     END AS SEQ_GROUP
                   , CASE
                       WHEN FH.FORM_ITEM_CLASS IN('11', '12', '13', '14') THEN 'Y'
                       ELSE 'N'
                     END AS SUM_YN
                FROM FI_BALANCE_BS BB
                  , FI_FORM_HEADER FH
              WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BB.THIS_L_AMOUNT           <> 0
                 OR BB.PREV_L_AMOUNT            <> 0
                 OR BB.ITEM_LEVEL               IN(1, 2))
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
      
  END SELECT_BALANCE_BS_YEAR;

-- 대차대조표 (년말)조회 : 증감율.
  PROCEDURE SELECT_BALANCE_BS_12
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_11_SUM                 NUMBER := 0;
    V_PREV_11_SUM                 NUMBER := 0;
    V_THIS_14_SUM                 NUMBER := 0;
    V_PREV_14_SUM                 NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1002'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    -- 대차대조표 생성.
    CREATE_BALANCE_BS_12
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );
          
    BEGIN
      SELECT SUM(DECODE(FH.FORM_ITEM_CLASS, '11', BB.THIS_L_AMOUNT, 0)) AS THIS_11_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '11', BB.PREV_L_AMOUNT, 0)) AS PREV_11_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '14', BB.THIS_L_AMOUNT, 0)) AS THIS_14_SUM
           , SUM(DECODE(FH.FORM_ITEM_CLASS, '14', BB.PREV_L_AMOUNT, 0)) AS PREV_14_SUM
        INTO V_THIS_11_SUM, V_PREV_11_SUM, V_THIS_14_SUM, V_PREV_14_SUM
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_ITEM_CLASS          IN ('11', '14')
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    OPEN P_CURSOR FOR
      SELECT SX1.HEADER_CODE
           , CASE
               WHEN SX1.SEQ_NUM_YN = 'Y' THEN '    ' || ROW_NUMBER() OVER (PARTITION BY SX1.SEQ_GROUP ORDER BY SX1.SEQ_GROUP, SX1.SORT_SEQ) || '.' || LTRIM(SX1.HEADER_NAME)
               ELSE SX1.HEADER_NAME
             END AS HEADER_NAME
           , CASE
               WHEN SX1.THIS_L_AMOUNT < 0 THEN 
                 CASE
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.THIS_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
             END AS THIS_L_AMOUNT
           , CASE
               WHEN SX1.THIS_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.THIS_RATE, 'FM990.00') || '%' 
             END AS THIS_RATE
           , CASE
               WHEN SX1.PREV_L_AMOUNT < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.PREV_L_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
             END AS PREV_L_AMOUNT
           , CASE
               WHEN SX1.PREV_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.PREV_RATE, 'FM990.00') || '%'
             END AS PREV_RATE
           , CASE
               WHEN NVL(SX1.CHANGE_AMOUNT, 0) < 0 THEN 
                 CASE 
                   WHEN SX1.MINUS_SIGN_DISPLAY IS NULL THEN TO_CHAR(SX1.CHANGE_AMOUNT, 'FM999,999,999,999')
                   WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999') || ')' 
                   ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999')
                 END
               ELSE TO_CHAR(ABS(SX1.CHANGE_AMOUNT), 'FM999,999,999,999')
             END AS CHANGE_AMOUNT
           , CASE
               WHEN SX1.CHANGE_RATE IS NULL THEN NULL
               ELSE TO_CHAR(SX1.CHANGE_RATE, 'FM990.00') || '%'
             END AS CHANGE_RATE
           , NVL(SX1.SUM_YN, 'N') AS SUM_YN
        FROM (SELECT BB.HEADER_CODE
                   , BB.HEADER_NAME AS HEADER_NAME
                   , BB.SORT_SEQ
                   , BB.THIS_L_AMOUNT AS THIS_L_AMOUNT
                   , CASE
                       WHEN V_THIS_11_SUM = 0 THEN TO_NUMBER(NULL)
                       ELSE ROUND((BB.THIS_L_AMOUNT 
                                   / CASE 
                                       WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN V_THIS_11_SUM
                                       ELSE V_THIS_14_SUM
                                     END) * 100, 2)
                     END AS THIS_RATE
                   , BB.PREV_L_AMOUNT AS PREV_L_AMOUNT
                   , CASE
                       WHEN V_PREV_11_SUM = 0 THEN TO_NUMBER(NULL)
                       ELSE ROUND((BB.PREV_L_AMOUNT 
                                   / CASE 
                                       WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN V_PREV_11_SUM
                                       ELSE V_PREV_14_SUM
                                     END) * 100, 2) 
                     END AS PREV_RATE
                   , BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT AS CHANGE_AMOUNT
                   , CASE
                       WHEN BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT IS NULL THEN NULL
                       WHEN NVL(BB.PREV_L_AMOUNT, 0) = 0 THEN 0
                       ELSE ROUND((((NVL(BB.THIS_L_AMOUNT, 0) - NVL(BB.PREV_L_AMOUNT, 0))) / NVL(BB.PREV_L_AMOUNT, 0)) * 100, 2)  
                     END AS CHANGE_RATE
                   , FH.MINUS_SIGN_DISPLAY
                   , CASE
                       WHEN FH.FORM_ITEM_TYPE = '101' THEN 'N'
                       WHEN FH.LAST_LEVEL_YN = 'Y' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.FORM_ITEM_TYPE = '101' THEN '-'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND FH.FORM_ITEM_CODE IN ('1240510') THEN FH.FORM_ITEM_CODE
                       WHEN FH.LAST_LEVEL_YN = 'Y' THEN SUBSTR(FH.FORM_ITEM_CODE, 1, 3) 
                       ELSE '-'
                     END AS SEQ_GROUP
                   , CASE
                       WHEN FH.FORM_ITEM_CLASS IN('11', '12', '13', '14') THEN 'Y'
                       ELSE 'N'
                     END AS SUM_YN
                FROM FI_BALANCE_BS BB
                  , FI_FORM_HEADER FH
              WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BB.THIS_L_AMOUNT           <> 0
                 OR BB.PREV_L_AMOUNT            <> 0
                 OR BB.ITEM_LEVEL               IN(1, 2))
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
  END SELECT_BALANCE_BS_12;
  
-- 대차대조표 (월)생성(증감율).
  PROCEDURE CREATE_BALANCE_BS_MONTH
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_SYSDATE                     DATE   := GET_LOCAL_DATE(W_SOB_ID);
    V_MONTH_COUNT                 NUMBER := 0;
    
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;
    V_PREV_DATE_TO                DATE;
    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
    V_SURPLUS_AMOUNT              NUMBER := 0;
    V_MESSAGE                     VARCHAR2(200);
  BEGIN
    V_THIS_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YEAR');
    V_THIS_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_PREV_DATE_TO := LAST_DAY(ADD_MONTHS(V_THIS_DATE_FR, -1));

    -- 전표 실적 집계 --
    V_MONTH_COUNT := MONTHS_BETWEEN(V_THIS_DATE_TO, LAST_DAY(TRUNC(V_THIS_DATE_FR, 'YEAR'))) + 1;
    BEGIN
      FOR C1 IN 1 .. V_MONTH_COUNT
      LOOP
        FI_AGGREGATE_G.ACCOUNT_AGGREGATE_SET( P_STD_DATE => LAST_DAY(ADD_MONTHS(TRUNC(V_THIS_DATE_FR, 'YEAR'), C1 - 1))
                                            , P_SOB_ID => W_SOB_ID
                                            , P_ORG_ID => 201
                                            , P_USER_ID => -1
                                            , O_MESSAGE => V_MESSAGE
                                            );
      END LOOP C1;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Aggregate Error  : ' || V_MESSAGE);
    END;
    
    BEGIN
      DELETE FI_BALANCE_BS     
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_BS
    ( HEADER_ID
    , HEADER_CODE 
    , HEADER_NAME
    , ITEM_LEVEL
    , SORT_SEQ
    , LAST_LEVEL_YN
    , SOB_ID
    , ORG_ID
    , THIS_L_AMOUNT 
    , THIS_R_AMOUNT 
    , PREV_L_AMOUNT 
    , PREV_R_AMOUNT
    , ITEM_TYPE
    , ITEM_CLASS
    , CREATION_DATE 
    , CREATED_BY 
    )
    SELECT FH.FORM_HEADER_ID
         , FH.FORM_ITEM_CODE
         , FH.FORM_ITEM_NAME
         , FH.ITEM_LEVEL
         , FH.SORT_SEQ
         , FH.LAST_LEVEL_YN
         , FH.SOB_ID
         , FH.ORG_ID     
         , 0 AS THIS_L_AMOUNT
         , 0 AS THIS_R_AMOUNT
         , 0 AS PREV_L_AMOUNT
         , 0 AS PREV_R_AMOUNT
         , FH.FORM_ITEM_TYPE
         , FH.FORM_ITEM_CLASS
         , V_SYSDATE
         , P_USER_ID
      FROM FI_FORM_HEADER FH
    WHERE FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
      AND FH.SOB_ID                   = W_SOB_ID
      AND FH.ENABLED_FLAG             = 'Y'
      AND FH.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
      AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
    ORDER BY FH.SORT_SEQ
    ;

    -- 당월까지 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , FH.FORM_ITEM_CODE
                     , FH.FORM_ITEM_NAME
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM ITEM NAME : ' || C1.FORM_ITEM_NAME || ', HEADER ID : ' || C1.FORM_HEADER_ID);
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS THIS_AMOUNT 
          INTO V_THIS_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 전월까지 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS PREV_AMOUNT 
          INTO V_PREV_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 미처분 이익잉여금 적용 --  
    -- 손익계산서 당기순이익.
    V_THIS_L_AMOUNT := 0;
    V_PREV_L_AMOUNT := 0;    
    BEGIN
      FI_BALANCE_IS_G.BALANCE_IS_MONTH_P(W_PERIOD_NAME, W_SOB_ID, V_THIS_L_AMOUNT, V_PREV_L_AMOUNT);
      DBMS_OUTPUT.PUT_LINE('AMOUNT : ' || V_THIS_L_AMOUNT || ' / ' || V_PREV_L_AMOUNT);
      
      UPDATE FI_BALANCE_BS BB
        SET BB.THIS_L_AMOUNT  = NVL(BB.THIS_L_AMOUNT, 0) + NVL(V_THIS_L_AMOUNT, 0)
          , BB.PREV_L_AMOUNT  = NVL(BB.PREV_L_AMOUNT, 0) + NVL(V_PREV_L_AMOUNT, 0)
      WHERE BB.ITEM_TYPE      = '301'
        AND BB.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('I/S ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    /* -- 자산 총계 = 부채총계 + 자본총계 산식에 의한 계산.
    V_SURPLUS_AMOUNT := FREE_SURPLUS_F(W_FORM_TYPE_ID, W_SOB_ID);
    BEGIN
      UPDATE FI_BALANCE_BS BB
        SET BB.THIS_L_AMOUNT = NVL(BB.THIS_L_AMOUNT, 0) + NVL(V_SURPLUS_AMOUNT, 0)
      WHERE BB.SOB_ID        = W_SOB_ID
        AND EXISTS ( SELECT 'X'
                       FROM FI_FORM_HEADER FH
                     WHERE FH.FORM_HEADER_ID  = BB.HEADER_ID
                       AND FH.SOB_ID          = BB.SOB_ID
                       AND FH.FORM_TYPE_ID    = W_FORM_TYPE_ID
                       AND EXISTS ( SELECT 'X'
                                       FROM FI_COMMON FC
                                     WHERE FC.GROUP_CODE  = 'FORM_ITEM_TYPE'
                                       AND FC.SOB_ID      = FH.SOB_ID
                                       AND FC.CODE        = FH.FORM_ITEM_TYPE
                                       AND FC.CODE        = '301'
                                   ) 
                       --AND FH.FORM_ITEM_CODE  = '3510900'
                   )
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_BALANCE_BS 
        ( HEADER_ID, HEADER_CODE, HEADER_NAME
        , ITEM_LEVEL, SORT_SEQ, LAST_LEVEL_YN
        , SOB_ID, ORG_ID
        , THIS_L_AMOUNT
        , CREATION_DATE, CREATED_BY        
        ) 
        SELECT FH.FORM_HEADER_ID, FH.FORM_ITEM_CODE, FH.FORM_ITEM_NAME
            , FH.ITEM_LEVEL, FH.SORT_SEQ, FH.LAST_LEVEL_YN
            , FH.SOB_ID, FH.ORG_ID
            , NVL(V_SURPLUS_AMOUNT, 0)
            , V_SYSDATE, P_USER_ID
          FROM FI_FORM_HEADER FH
        WHERE FH.SOB_ID          = W_SOB_ID
          AND FH.FORM_TYPE_ID    = W_FORM_TYPE_ID
          AND EXISTS ( SELECT 'X'
                         FROM FI_COMMON FC
                       WHERE FC.GROUP_CODE  = 'FORM_ITEM_TYPE'
                         AND FC.SOB_ID      = FH.SOB_ID
                         AND FC.CODE        = FH.FORM_ITEM_TYPE
                         AND FC.CODE        = '301'
                     ) 
          AND ROWNUM             <= 1
        ;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('미처분이익잉여금 오류 : ' || SUBSTR(SQLERRM, 1, 150));
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
    */
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND FH.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY FH.ITEM_LEVEL DESC, FH.SORT_SEQ
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_BALANCE_BS BB
        SET ( BB.THIS_L_AMOUNT
            , BB.PREV_L_AMOUNT
            ) =
            ( SELECT SUM(BB1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                   , SUM(BB1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                FROM FI_BALANCE_BS BB1
                  , FI_FORM_LINE FL
              WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                AND FL.SOB_ID             = C1.SOB_ID
            )
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  
  END CREATE_BALANCE_BS_MONTH;

-- 대차대조표 (월)생성(장부가액).
  PROCEDURE CREATE_BALANCE_BS_MONTH_1
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_SYSDATE                     DATE   := GET_LOCAL_DATE(W_SOB_ID);
    V_MONTH_COUNT                 NUMBER := 0;
    
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;
    V_PREV_DATE_TO                DATE;
    V_AMOUNT                      NUMBER := 0;
    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
    V_SURPLUS_AMOUNT              NUMBER := 0;
    V_MESSAGE                     VARCHAR2(200);
  BEGIN
    V_THIS_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YEAR');
    V_THIS_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_PREV_DATE_TO := LAST_DAY(ADD_MONTHS(V_THIS_DATE_FR, -1));
    
    -- 전표 실적 집계 --
    V_MONTH_COUNT := MONTHS_BETWEEN(V_THIS_DATE_TO, LAST_DAY(TRUNC(V_THIS_DATE_FR, 'YEAR'))) + 1;
    BEGIN
      FOR C1 IN 1 .. V_MONTH_COUNT
      LOOP
        FI_AGGREGATE_G.ACCOUNT_AGGREGATE_SET( P_STD_DATE => LAST_DAY(ADD_MONTHS(TRUNC(V_THIS_DATE_FR, 'YEAR'), C1 - 1))
                                            , P_SOB_ID => W_SOB_ID
                                            , P_ORG_ID => 201
                                            , P_USER_ID => -1
                                            , O_MESSAGE => V_MESSAGE
                                            );
      END LOOP C1;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Aggregate Error  : ' || V_MESSAGE);
    END;
    
    BEGIN
      DELETE FI_BALANCE_BS     
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_BS
    ( HEADER_ID
    , HEADER_CODE 
    , HEADER_NAME
    , ITEM_LEVEL
    , SORT_SEQ
    , LAST_LEVEL_YN
    , SOB_ID
    , ORG_ID
    , THIS_L_AMOUNT 
    , THIS_R_AMOUNT 
    , PREV_L_AMOUNT 
    , PREV_R_AMOUNT 
    , CREATION_DATE 
    , CREATED_BY 
    )
    SELECT FH.FORM_HEADER_ID
         , FH.FORM_ITEM_CODE
         , FH.FORM_ITEM_NAME
         , FH.ITEM_LEVEL
         , FH.SORT_SEQ
         , FH.LAST_LEVEL_YN
         , FH.SOB_ID
         , FH.ORG_ID     
         , 0 AS THIS_L_AMOUNT
         , 0 AS THIS_R_AMOUNT
         , 0 AS PREV_L_AMOUNT
         , 0 AS PREV_R_AMOUNT
         , V_SYSDATE
         , P_USER_ID
      FROM FI_FORM_HEADER FH
    WHERE FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
      AND FH.SOB_ID                   = W_SOB_ID
      AND FH.ENABLED_FLAG             = 'Y'
      AND FH.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
      AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
    ORDER BY FH.SORT_SEQ
    ;

    -- 당월까지 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , FH.FORM_ITEM_CODE
                     , FH.FORM_ITEM_NAME
                     , FH.COLUMN_POSITION_NUM
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM ITEM NAME : ' || C1.FORM_ITEM_NAME || ', HEADER ID : ' || C1.FORM_HEADER_ID);
      V_AMOUNT                      := 0;
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS THIS_AMOUNT 
          INTO V_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      -- 저장 위치 지정.
      IF NVL(C1.COLUMN_POSITION_NUM, 2) = 1 THEN
        V_THIS_L_AMOUNT := V_AMOUNT;
      ELSE
        V_THIS_R_AMOUNT := V_AMOUNT;
      END IF;
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
            , BB.THIS_R_AMOUNT    = NVL(V_THIS_R_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 전월까지 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , FH.COLUMN_POSITION_NUM
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_AMOUNT                      := 0;
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS PREV_AMOUNT 
          INTO V_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      -- 저장 위치 지정.
      IF NVL(C1.COLUMN_POSITION_NUM, 2) = 1 THEN
        V_PREV_L_AMOUNT := V_AMOUNT;
      ELSE
        V_PREV_R_AMOUNT := V_AMOUNT;
      END IF;
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
            , BB.PREV_R_AMOUNT    = NVL(V_PREV_R_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 차감계정 장부잔액 계산.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , FH.RELATE_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                     , NVL(BB.THIS_L_AMOUNT, 0) AS THIS_L_AMOUNT
                     , NVL(BB.THIS_R_AMOUNT, 0) AS THIS_R_AMOUNT
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND BB.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.RELATE_HEADER_ID   IS NOT NULL
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY BB.SORT_SEQ DESC
              )
    LOOP
      V_AMOUNT := 0;
      BEGIN
        SELECT NVL(SUM(BB.THIS_L_AMOUNT), 0) AS THIS_L_AMOUNT
          INTO V_AMOUNT
          FROM FI_BALANCE_BS BB
             , FI_FORM_HEADER FH
        WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
          AND BB.HEADER_ID          = C1.RELATE_HEADER_ID
          AND BB.SOB_ID             = C1.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      -- UPDATE.
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.THIS_R_AMOUNT    = NVL(V_AMOUNT, 0) + NVL(BB.THIS_L_AMOUNT, 0)
        WHERE BB.HEADER_ID        = C1.FORM_HEADER_ID
          AND BB.SOB_ID           = C1.SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
    END LOOP C1;
    
    -- 미처분 이익잉여금 적용.  
    -- 손익계산서 당기순이익.
    V_THIS_L_AMOUNT := 0;
    V_PREV_L_AMOUNT := 0;    
    BEGIN
      FI_BALANCE_IS_G.BALANCE_IS_MONTH_P(W_PERIOD_NAME, W_SOB_ID, V_THIS_L_AMOUNT, V_PREV_L_AMOUNT);
      DBMS_OUTPUT.PUT_LINE('AMOUNT : ' || V_THIS_L_AMOUNT || ' / ' || V_PREV_L_AMOUNT);
      
      UPDATE FI_BALANCE_BS BB
        SET BB.THIS_L_AMOUNT  = NVL(BB.THIS_L_AMOUNT, 0) + NVL(V_THIS_L_AMOUNT, 0)
          , BB.PREV_L_AMOUNT  = NVL(BB.PREV_L_AMOUNT, 0) + NVL(V_PREV_L_AMOUNT, 0)
      WHERE BB.ITEM_TYPE      = '301'
        AND BB.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('I/S ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    /*
    V_SURPLUS_AMOUNT := FREE_SURPLUS_1_F(W_FORM_TYPE_ID, W_SOB_ID);
    BEGIN
      UPDATE FI_BALANCE_BS BB
        SET BB.THIS_R_AMOUNT = NVL(BB.THIS_R_AMOUNT, 0) + NVL(V_SURPLUS_AMOUNT, 0)
      WHERE BB.SOB_ID        = W_SOB_ID
        AND EXISTS ( SELECT 'X'
                       FROM FI_FORM_HEADER FH
                     WHERE FH.FORM_HEADER_ID  = BB.HEADER_ID
                       AND FH.SOB_ID          = BB.SOB_ID
                       AND FH.FORM_TYPE_ID    = W_FORM_TYPE_ID
                       AND EXISTS ( SELECT 'X'
                                       FROM FI_COMMON FC
                                     WHERE FC.GROUP_CODE  = 'FORM_ITEM_TYPE'
                                       AND FC.SOB_ID      = FH.SOB_ID
                                       AND FC.CODE        = FH.FORM_ITEM_TYPE
                                       AND FC.CODE        = '301'
                                   ) 
                       --AND FH.FORM_ITEM_CODE  = '3510900'
                   )                                                     
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_BALANCE_BS 
        ( HEADER_ID, HEADER_CODE, HEADER_NAME
        , ITEM_LEVEL, SORT_SEQ, LAST_LEVEL_YN
        , SOB_ID, ORG_ID
        , THIS_L_AMOUNT
        , CREATION_DATE, CREATED_BY        
        ) 
        SELECT FH.FORM_HEADER_ID, FH.FORM_ITEM_CODE, FH.FORM_ITEM_NAME
            , FH.ITEM_LEVEL, FH.SORT_SEQ, FH.LAST_LEVEL_YN
            , FH.SOB_ID, FH.ORG_ID
            , NVL(V_SURPLUS_AMOUNT, 0)
            , V_SYSDATE, P_USER_ID
          FROM FI_FORM_HEADER FH
        WHERE FH.SOB_ID          = W_SOB_ID
          AND FH.FORM_TYPE_ID    = W_FORM_TYPE_ID
          AND EXISTS ( SELECT 'X'
                         FROM FI_COMMON FC
                       WHERE FC.GROUP_CODE  = 'FORM_ITEM_TYPE'
                         AND FC.SOB_ID      = FH.SOB_ID
                         AND FC.CODE        = FH.FORM_ITEM_TYPE
                         AND FC.CODE        = '301'
                     ) 
          AND ROWNUM             <= 1
        ;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('미처분이익잉여금 오류 : ' || SUBSTR(SQLERRM, 1, 150));
      RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
    END;
        */
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND FH.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY FH.ITEM_LEVEL DESC, FH.SORT_SEQ
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_BALANCE_BS BB
        SET ( BB.THIS_R_AMOUNT
            , BB.PREV_R_AMOUNT
            ) =
            ( SELECT SUM(BB1.THIS_R_AMOUNT * FL.ITEM_SIGN) AS THIS_R_AMOUNT
                   , SUM(BB1.PREV_R_AMOUNT * FL.ITEM_SIGN) AS PREV_R_AMOUNT
                FROM FI_BALANCE_BS BB1
                  , FI_FORM_LINE FL
              WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                AND FL.SOB_ID             = C1.SOB_ID
            )
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END CREATE_BALANCE_BS_MONTH_1;

-- 대차대조표 (년)생성(증감율).
  PROCEDURE CREATE_BALANCE_BS_YEAR
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_SYSDATE                     DATE   := GET_LOCAL_DATE(W_SOB_ID);
    V_MONTH_COUNT                 NUMBER := 0;
    
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;
    V_PREV_DATE_FR                DATE;
    V_PREV_DATE_TO                DATE;
    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
    V_SURPLUS_AMOUNT              NUMBER := 0;
    V_MESSAGE                     VARCHAR2(200);
  BEGIN
    -- 당월.
    V_THIS_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YEAR');
    V_THIS_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    
    -- 전월.
    V_PREV_DATE_FR := TRUNC(ADD_MONTHS(V_THIS_DATE_FR, -1), 'YEAR');
    V_PREV_DATE_TO := LAST_DAY(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -12));
    
    -- 전표 실적 집계 --
    V_MONTH_COUNT := MONTHS_BETWEEN(V_THIS_DATE_TO, LAST_DAY(TRUNC(V_THIS_DATE_FR, 'YEAR'))) + 1;
    BEGIN
      FOR C1 IN 1 .. V_MONTH_COUNT
      LOOP
        FI_AGGREGATE_G.ACCOUNT_AGGREGATE_SET( P_STD_DATE => LAST_DAY(ADD_MONTHS(TRUNC(V_THIS_DATE_FR, 'YEAR'), C1 - 1))
                                            , P_SOB_ID => W_SOB_ID
                                            , P_ORG_ID => 201
                                            , P_USER_ID => -1
                                            , O_MESSAGE => V_MESSAGE
                                            );
      END LOOP C1;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Aggregate Error  : ' || V_MESSAGE);
    END;
    
    BEGIN
      DELETE FI_BALANCE_BS     
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_BS
    ( HEADER_ID
    , HEADER_CODE 
    , HEADER_NAME
    , ITEM_LEVEL
    , SORT_SEQ
    , LAST_LEVEL_YN
    , SOB_ID
    , ORG_ID
    , THIS_L_AMOUNT 
    , THIS_R_AMOUNT 
    , PREV_L_AMOUNT 
    , PREV_R_AMOUNT
    , ITEM_TYPE
    , ITEM_CLASS
    , CREATION_DATE 
    , CREATED_BY 
    )
    SELECT FH.FORM_HEADER_ID
         , FH.FORM_ITEM_CODE
         , FH.FORM_ITEM_NAME
         , FH.ITEM_LEVEL
         , FH.SORT_SEQ
         , FH.LAST_LEVEL_YN
         , FH.SOB_ID
         , FH.ORG_ID     
         , 0 AS THIS_L_AMOUNT
         , 0 AS THIS_R_AMOUNT
         , 0 AS PREV_L_AMOUNT
         , 0 AS PREV_R_AMOUNT
         , FH.FORM_ITEM_TYPE
         , FH.FORM_ITEM_CLASS
         , V_SYSDATE
         , P_USER_ID
      FROM FI_FORM_HEADER FH
    WHERE FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
      AND FH.SOB_ID                   = W_SOB_ID
      AND FH.ENABLED_FLAG             = 'Y'
      AND FH.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
      AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
    ORDER BY FH.SORT_SEQ
    ;

    -- 당기 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , FH.FORM_ITEM_CODE
                     , FH.FORM_ITEM_NAME
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM ITEM NAME : ' || C1.FORM_ITEM_NAME || ', HEADER ID : ' || C1.FORM_HEADER_ID);
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS THIS_AMOUNT 
          INTO V_THIS_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 전기 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS PREV_AMOUNT 
          INTO V_PREV_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 미처분 이익잉여금 적용 --  
    -- 손익계산서 당기순이익.
    V_THIS_L_AMOUNT := 0;
    V_PREV_L_AMOUNT := 0;    
    BEGIN
      FI_BALANCE_IS_G.BALANCE_IS_YEAR_P(W_PERIOD_NAME, W_SOB_ID, V_THIS_L_AMOUNT, V_PREV_L_AMOUNT);
      DBMS_OUTPUT.PUT_LINE('AMOUNT : ' || V_THIS_L_AMOUNT || ' / ' || V_PREV_L_AMOUNT);
      
      UPDATE FI_BALANCE_BS BB
        SET BB.THIS_L_AMOUNT  = NVL(BB.THIS_L_AMOUNT, 0) + NVL(V_THIS_L_AMOUNT, 0)
          , BB.PREV_L_AMOUNT  = NVL(BB.PREV_L_AMOUNT, 0) + NVL(V_PREV_L_AMOUNT, 0)
      WHERE BB.ITEM_TYPE      = '301'
        AND BB.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('I/S ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND FH.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY FH.ITEM_LEVEL DESC, FH.SORT_SEQ
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_BALANCE_BS BB
        SET ( BB.THIS_L_AMOUNT
            , BB.PREV_L_AMOUNT
            ) =
            ( SELECT SUM(BB1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                   , SUM(BB1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                FROM FI_BALANCE_BS BB1
                  , FI_FORM_LINE FL
              WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                AND FL.SOB_ID             = C1.SOB_ID
            )
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  
  END CREATE_BALANCE_BS_YEAR;

-- 대차대조표 (전년 12월말 대비)생성(증감율).
  PROCEDURE CREATE_BALANCE_BS_12
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS 
    V_SYSDATE                     DATE   := GET_LOCAL_DATE(W_SOB_ID);
    V_MONTH_COUNT                 NUMBER := 0;
    
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;
    V_PREV_DATE_FR                DATE;
    V_PREV_DATE_TO                DATE;
    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
    V_SURPLUS_AMOUNT              NUMBER := 0;
    V_MESSAGE                     VARCHAR2(200);
  BEGIN
    -- 당월.
    V_THIS_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YEAR');
    V_THIS_DATE_TO := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    
    -- 전월.
    V_PREV_DATE_FR := TRUNC(ADD_MONTHS(V_THIS_DATE_FR, -12), 'YEAR');
    V_PREV_DATE_TO := TO_DATE(TO_CHAR(V_PREV_DATE_FR, 'YYYY') || '-12-31', 'YYYY-MM-DD'); 
    
    -- 전표 실적 집계 --
    V_MONTH_COUNT := MONTHS_BETWEEN(V_THIS_DATE_TO, LAST_DAY(TRUNC(V_THIS_DATE_FR, 'YEAR'))) + 1;
    BEGIN
      FOR C1 IN 1 .. V_MONTH_COUNT
      LOOP
        FI_AGGREGATE_G.ACCOUNT_AGGREGATE_SET( P_STD_DATE => LAST_DAY(ADD_MONTHS(TRUNC(V_THIS_DATE_FR, 'YEAR'), C1 - 1))
                                            , P_SOB_ID => W_SOB_ID
                                            , P_ORG_ID => 201
                                            , P_USER_ID => -1
                                            , O_MESSAGE => V_MESSAGE
                                            );
      END LOOP C1;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Aggregate Error  : ' || V_MESSAGE);
    END;
    
    BEGIN
      DELETE FI_BALANCE_BS     
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_BS
    ( HEADER_ID
    , HEADER_CODE 
    , HEADER_NAME
    , ITEM_LEVEL
    , SORT_SEQ
    , LAST_LEVEL_YN
    , SOB_ID
    , ORG_ID
    , THIS_L_AMOUNT 
    , THIS_R_AMOUNT 
    , PREV_L_AMOUNT 
    , PREV_R_AMOUNT
    , ITEM_TYPE
    , ITEM_CLASS
    , CREATION_DATE 
    , CREATED_BY 
    )
    SELECT FH.FORM_HEADER_ID
         , FH.FORM_ITEM_CODE
         , FH.FORM_ITEM_NAME
         , FH.ITEM_LEVEL
         , FH.SORT_SEQ
         , FH.LAST_LEVEL_YN
         , FH.SOB_ID
         , FH.ORG_ID     
         , 0 AS THIS_L_AMOUNT
         , 0 AS THIS_R_AMOUNT
         , 0 AS PREV_L_AMOUNT
         , 0 AS PREV_R_AMOUNT
         , FH.FORM_ITEM_TYPE
         , FH.FORM_ITEM_CLASS
         , V_SYSDATE
         , P_USER_ID
      FROM FI_FORM_HEADER FH
    WHERE FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
      AND FH.SOB_ID                   = W_SOB_ID
      AND FH.ENABLED_FLAG             = 'Y'
      AND FH.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
      AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
    ORDER BY FH.SORT_SEQ
    ;

    -- 당기 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , FH.FORM_ITEM_CODE
                     , FH.FORM_ITEM_NAME
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM ITEM NAME : ' || C1.FORM_ITEM_NAME || ', HEADER ID : ' || C1.FORM_HEADER_ID);
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS THIS_AMOUNT 
          INTO V_THIS_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 전기 금액 적용.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS PREV_AMOUNT 
          INTO V_PREV_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_BS BB
          SET BB.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 미처분 이익잉여금 적용 --  
    -- 손익계산서 당기순이익.
    V_THIS_L_AMOUNT := 0;
    V_PREV_L_AMOUNT := 0;    
    BEGIN
      FI_BALANCE_IS_G.BALANCE_IS_YEAR_P(W_PERIOD_NAME, W_SOB_ID, V_THIS_L_AMOUNT, V_PREV_L_AMOUNT);
      DBMS_OUTPUT.PUT_LINE('AMOUNT : ' || V_THIS_L_AMOUNT || ' / ' || V_PREV_L_AMOUNT);
      
      UPDATE FI_BALANCE_BS BB
        SET BB.THIS_L_AMOUNT  = NVL(BB.THIS_L_AMOUNT, 0) + NVL(V_THIS_L_AMOUNT, 0)
          , BB.PREV_L_AMOUNT  = NVL(BB.PREV_L_AMOUNT, 0) + NVL(V_PREV_L_AMOUNT, 0)
      WHERE BB.ITEM_TYPE      = '301'
        AND BB.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('I/S ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND FH.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY FH.ITEM_LEVEL DESC, FH.SORT_SEQ
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_BALANCE_BS BB
        SET ( BB.THIS_L_AMOUNT
            , BB.PREV_L_AMOUNT
            ) =
            ( SELECT SUM(BB1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                   , SUM(BB1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                FROM FI_BALANCE_BS BB1
                  , FI_FORM_LINE FL
              WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                AND FL.SOB_ID             = C1.SOB_ID
            )
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END CREATE_BALANCE_BS_12;
  
-- 미처분이익잉여금(증감율).
  FUNCTION FREE_SURPLUS_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SURPLUS_AMOUNT              NUMBER := 0;
    V_AMOUNT1                     NUMBER := 0;
    V_AMOUNT2                     NUMBER := 0;
  BEGIN
    -- 자산합계.
    BEGIN
      SELECT SUM(BB.THIS_L_AMOUNT) AS THIS_L_AMOUNT           
        INTO V_AMOUNT1
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
        AND BB.SOB_ID                   = W_SOB_ID
        AND FH.LAST_LEVEL_YN            = 'Y'        
        AND SUBSTR(BB.HEADER_CODE, 1, 1)  = '1'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_AMOUNT1 := 0;
    END;
    
    -- 부채/자본 합계.
    BEGIN
      SELECT SUM(BB.THIS_L_AMOUNT) AS THIS_L_AMOUNT           
        INTO V_AMOUNT2
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
        AND BB.SOB_ID                   = W_SOB_ID
        AND FH.LAST_LEVEL_YN            = 'Y'
        AND SUBSTR(BB.HEADER_CODE, 1, 1)  <> '1'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_AMOUNT2 := 0;
    END;
    V_SURPLUS_AMOUNT := NVL(V_AMOUNT1, 0) - NVL(V_AMOUNT2, 0);
    RETURN V_SURPLUS_AMOUNT;
  END FREE_SURPLUS_F;

-- 미처분이익잉여금(장부가액).
  FUNCTION FREE_SURPLUS_1_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_SOB_ID            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SURPLUS_AMOUNT              NUMBER := 0;
    V_AMOUNT1                     NUMBER := 0;
    V_AMOUNT2                     NUMBER := 0;
  BEGIN
    -- 자산합계.
    BEGIN
      SELECT SUM(BB.THIS_R_AMOUNT) AS THIS_L_AMOUNT           
        INTO V_AMOUNT1
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
        AND BB.SOB_ID                   = W_SOB_ID
        AND FH.LAST_LEVEL_YN            = 'Y'        
        AND SUBSTR(BB.HEADER_CODE, 1, 1)  = '1'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_AMOUNT1 := 0;
    END;
    
    -- 부채/자본 합계.
    BEGIN
      SELECT SUM(BB.THIS_R_AMOUNT) AS THIS_L_AMOUNT           
        INTO V_AMOUNT2
        FROM FI_BALANCE_BS BB
          , FI_FORM_HEADER FH
      WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = W_FORM_TYPE_ID
        AND BB.SOB_ID                   = W_SOB_ID
        AND FH.LAST_LEVEL_YN            = 'Y'
        AND SUBSTR(BB.HEADER_CODE, 1, 1)  <> '1'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_AMOUNT2 := 0;
    END;
    V_SURPLUS_AMOUNT := NVL(V_AMOUNT1, 0) - NVL(V_AMOUNT2, 0);
    RETURN V_SURPLUS_AMOUNT;
  END FREE_SURPLUS_1_F;

-- 기수 및 기간 설정.
  PROCEDURE PROMPT_PERIOD_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            )
  AS
    V_YEAR_COUNT                  NUMBER;
    V_YEAR                        VARCHAR2(4);
    V_MONTH                       VARCHAR2(2);
    V_LAST_DAY                    VARCHAR2(2);    
  BEGIN
    V_YEAR := TO_CHAR(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YYYY');
    V_MONTH := TO_CHAR(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MM');
    V_LAST_DAY := TO_CHAR(LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM')), 'DD');
    -- 회계 기수 --
    BEGIN
      V_YEAR_COUNT := GL_FISCAL_YEAR_G.FISCAL_YEAR_COUNT_F(V_YEAR, W_SOB_ID);
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_COUNT := 1;    
    END;    
    O_PROMPT := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10248'
                                                                        , '&&VALUE:=' || V_YEAR_COUNT ||
                                                                          '&&YEAR:=' || V_YEAR ||
                                                                          '&&MONTH:=' || V_MONTH ||
                                                                          '&&DAY:=' || V_LAST_DAY);    
  END PROMPT_PERIOD_MONTH_P;

-- 그리드 프롬프트 설정(기수).
  PROCEDURE PROMPT_YEAR_COUNT_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            )
  AS
    V_YEAR_COUNT                  NUMBER;
    V_YEAR                        VARCHAR2(4);
  BEGIN
    V_YEAR := TO_CHAR(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YYYY');
    -- 회계 기수 --
    BEGIN
      V_YEAR_COUNT := GL_FISCAL_YEAR_G.FISCAL_YEAR_COUNT_F(V_YEAR, W_SOB_ID);
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_COUNT := 1;    
    END;
    O_PROMPT := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10246'
                                                                        , '&&VALUE:=' || V_YEAR_COUNT);      
  END PROMPT_YEAR_COUNT_P;
    
END FI_BALANCE_BS_G;
/
