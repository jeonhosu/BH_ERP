CREATE OR REPLACE PACKAGE FI_BALANCE_IS_G
AS
-- 손익계산서 조회 : 전월대비.
  PROCEDURE SELECT_BALANCE_IS_MONTH
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 손익계산서 조회 : 전년동기대비 증감율.
  PROCEDURE SELECT_BALANCE_IS_YEAR
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 손익계산서 생성(전월대비).
  PROCEDURE CREATE_BALANCE_IS_MONTH
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 손익계산서 생성(전년동기대비 증감율).
  PROCEDURE CREATE_BALANCE_IS_YEAR
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 상품 기초금액 리턴.
  FUNCTION GOODS_BEGIN_AMOUNT_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_FORM_ITEM_TYPE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER                         
            ) RETURN NUMBER;
            
-- 상품 기말금액 리턴.
  FUNCTION GOODS_ENDING_AMOUNT_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_FORM_ITEM_TYPE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER                         
            ) RETURN NUMBER;

-- 기수 및 기간 설정.
  PROCEDURE PROMPT_PERIOD_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            );

-- 기수 및 기간 설정.
  PROCEDURE PROMPT_PERIOD_YEAR_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            );

-- 그리드 프롬프트 설정(월).
  PROCEDURE PROMPT_MONTH_P
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

-- 당기순이익 리턴(월).
  PROCEDURE BALANCE_IS_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            );

-- 당기순이익 리턴(년).
  PROCEDURE BALANCE_IS_YEAR_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            );
            
END FI_BALANCE_IS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BALANCE_IS_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_IS_G
/* Description  : 손익계산서 생성/조회.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 손익계산서 조회 : 전월대비.
  PROCEDURE SELECT_BALANCE_IS_MONTH
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_22_AMOUNT              NUMBER := 0;
    V_PREV_22_AMOUNT              NUMBER := 0;
    V_THIS_23_AMOUNT              NUMBER := 0;
    V_PREV_23_AMOUNT              NUMBER := 0;
    V_THIS_24_AMOUNT              NUMBER := 0;
    V_PREV_24_AMOUNT              NUMBER := 0;
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1003'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;

    -- 손익계산서 생성.
    CREATE_BALANCE_IS_MONTH
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );

    -- 매출액 --
    V_THIS_22_AMOUNT := 0;
    V_PREV_22_AMOUNT := 0;
    BEGIN
      SELECT SUM(BI.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BI.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_22_AMOUNT
           , V_PREV_22_AMOUNT
        FROM FI_BALANCE_IS BI
          , FI_FORM_HEADER FH
      WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '22'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_22_AMOUNT := 0;
      V_PREV_22_AMOUNT := 0;
    END;

    -- 제품 매출액 --
    V_THIS_23_AMOUNT := 0;
    V_PREV_23_AMOUNT := 0;
    BEGIN
      SELECT SUM(BI.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BI.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_23_AMOUNT
           , V_PREV_23_AMOUNT
        FROM FI_BALANCE_IS BI
          , FI_FORM_HEADER FH
      WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '23'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_23_AMOUNT := 0;
      V_PREV_23_AMOUNT := 0;
    END;

    -- 상품 매출액 --
    V_THIS_24_AMOUNT := 0;
    V_PREV_24_AMOUNT := 0;
    BEGIN
      SELECT SUM(BI.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BI.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_24_AMOUNT
           , V_PREV_24_AMOUNT
        FROM FI_BALANCE_IS BI
          , FI_FORM_HEADER FH
      WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '24'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_24_AMOUNT := 0;
      V_PREV_24_AMOUNT := 0;
    END;

    OPEN P_CURSOR FOR
      SELECT SX1.FORM_ITEM_CODE
           , CASE
               WHEN SX1.SEQ_NUM_YN = 'Y' THEN '    ' || ROW_NUMBER() OVER (PARTITION BY SX1.SEQ_GROUP ORDER BY SX1.SEQ_GROUP, SX1.SORT_SEQ) || '.' || LTRIM(SX1.FORM_ITEM_NAME)
               ELSE SX1.FORM_ITEM_NAME
             END AS FORM_ITEM_NAME
           , SX1.THIS_L_AMOUNT
           , SX1.THIS_RATE
           , SX1.PREV_L_AMOUNT
           , SX1.PREV_RATE
           , SX1.CHANGE_L_AMOUNT
           , SX1.CHANGE_RATE
           , CASE 
               WHEN SX1.FORM_ITEM_CLASS IS NOT NULL THEN 'N'
               ELSE 'N'
             END AS LINE_YN
        FROM (SELECT FH.FORM_ITEM_CODE
                   , FH.FORM_ITEM_NAME
                   , BI.THIS_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '4200000' AND NVL(V_THIS_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '26' AND NVL(V_THIS_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '27' AND NVL(V_THIS_23_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_23_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '28' AND NVL(V_THIS_24_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_24_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CODE > '4000000' AND NVL(V_THIS_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_22_AMOUNT * 100, 2)
                       ELSE TO_NUMBER(NULL)
                     END AS THIS_RATE
                   , BI.PREV_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '4200000' AND NVL(V_PREV_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '26' AND NVL(V_PREV_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '27' AND NVL(V_PREV_23_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_23_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '28' AND NVL(V_PREV_24_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_24_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CODE > '4000000' AND NVL(V_PREV_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_22_AMOUNT * 100, 2)
                       ELSE TO_NUMBER(NULL)
                     END AS PREV_RATE
                   , NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0) AS CHANGE_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '4200000' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CLASS = '26' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CLASS = '27' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CLASS = '28' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CODE > '4000000' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS CHANGE_RATE
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('44101', '44102') THEN 'Y'  -- 금융수익.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('45101', '45104', '45105') THEN 'Y'  -- 금융비용.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '431' THEN 'Y'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '441' THEN 'Y'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '451' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('44101', '44102') THEN '4410'  -- 금융수익.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('45101', '45104', '45105') THEN '4510'  -- 금융비용.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '431' THEN '431'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '441' THEN '441'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '451' THEN '451'
                       ELSE '-'
                     END AS SEQ_GROUP
                   , FH.SORT_SEQ
                   , FH.FORM_ITEM_CLASS
                FROM FI_BALANCE_IS BI
                  , FI_FORM_HEADER FH
              WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
                AND FH.SOB_ID                   = W_SOB_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BI.THIS_L_AMOUNT            <> 0 
                 OR BI.PREV_L_AMOUNT            <> 0)
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;  
  END SELECT_BALANCE_IS_MONTH;

-- 손익계산서 조회 : 전년동기대비 증감율.
  PROCEDURE SELECT_BALANCE_IS_YEAR
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_22_AMOUNT              NUMBER := 0;
    V_PREV_22_AMOUNT              NUMBER := 0;
    V_THIS_23_AMOUNT              NUMBER := 0;
    V_PREV_23_AMOUNT              NUMBER := 0;
    V_THIS_24_AMOUNT              NUMBER := 0;
    V_PREV_24_AMOUNT              NUMBER := 0;
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1003'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;

    -- 제조원가명세서 생성.
    CREATE_BALANCE_IS_YEAR
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );

    -- 매출액 --
    V_THIS_22_AMOUNT := 0;
    V_PREV_22_AMOUNT := 0;
    BEGIN
      SELECT SUM(BI.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BI.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_22_AMOUNT
           , V_PREV_22_AMOUNT
        FROM FI_BALANCE_IS BI
          , FI_FORM_HEADER FH
      WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '22'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_22_AMOUNT := 0;
      V_PREV_22_AMOUNT := 0;
    END;

    -- 제품 매출액 --
    V_THIS_23_AMOUNT := 0;
    V_PREV_23_AMOUNT := 0;
    BEGIN
      SELECT SUM(BI.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BI.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_23_AMOUNT
           , V_PREV_23_AMOUNT
        FROM FI_BALANCE_IS BI
          , FI_FORM_HEADER FH
      WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '23'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_23_AMOUNT := 0;
      V_PREV_23_AMOUNT := 0;
    END;

    -- 상품 매출액 --
    V_THIS_24_AMOUNT := 0;
    V_PREV_24_AMOUNT := 0;
    BEGIN
      SELECT SUM(BI.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BI.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_24_AMOUNT
           , V_PREV_24_AMOUNT
        FROM FI_BALANCE_IS BI
          , FI_FORM_HEADER FH
      WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '24'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_24_AMOUNT := 0;
      V_PREV_24_AMOUNT := 0;
    END;


    OPEN P_CURSOR FOR
      SELECT SX1.FORM_ITEM_CODE
           , CASE
               WHEN SX1.SEQ_NUM_YN = 'Y' THEN '    ' || ROW_NUMBER() OVER (PARTITION BY SX1.SEQ_GROUP ORDER BY SX1.SEQ_GROUP, SX1.SORT_SEQ) || '.' || LTRIM(SX1.FORM_ITEM_NAME)
               ELSE SX1.FORM_ITEM_NAME
             END AS FORM_ITEM_NAME
           , SX1.THIS_L_AMOUNT
           , SX1.THIS_RATE
           , SX1.PREV_L_AMOUNT
           , SX1.PREV_RATE
           , SX1.CHANGE_L_AMOUNT
           , SX1.CHANGE_RATE
           , CASE 
               WHEN SX1.FORM_ITEM_CLASS IS NOT NULL THEN 'N'
               ELSE 'N'
             END AS LINE_YN
        FROM (SELECT FH.FORM_ITEM_CODE
                   , FH.FORM_ITEM_NAME
                   , BI.THIS_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '4200000' AND NVL(V_THIS_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '26' AND NVL(V_THIS_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '27' AND NVL(V_THIS_23_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_23_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '28' AND NVL(V_THIS_24_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_24_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CODE > '4000000' AND NVL(V_THIS_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.THIS_L_AMOUNT, 0) / V_THIS_22_AMOUNT * 100, 2)
                       ELSE TO_NUMBER(NULL)
                     END AS THIS_RATE
                   , BI.PREV_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '4200000' AND NVL(V_PREV_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '26' AND NVL(V_PREV_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_22_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '27' AND NVL(V_PREV_23_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_23_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CLASS = '28' AND NVL(V_PREV_24_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_24_AMOUNT * 100, 2)
                       WHEN FH.FORM_ITEM_CODE > '4000000' AND NVL(V_PREV_22_AMOUNT, 0) <> 0 THEN ROUND(NVL(BI.PREV_L_AMOUNT, 0) / V_PREV_22_AMOUNT * 100, 2)
                       ELSE TO_NUMBER(NULL)
                     END AS PREV_RATE
                   , NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0) AS CHANGE_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '4200000' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CLASS = '26' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CLASS = '27' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CLASS = '28' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       WHEN FH.FORM_ITEM_CODE > '4000000' THEN 
                         CASE
                           WHEN NVL(BI.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BI.THIS_L_AMOUNT, 0) - NVL(BI.PREV_L_AMOUNT, 0)) / NVL(BI.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS CHANGE_RATE
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('44101', '44102') THEN 'Y'  -- 금융수익.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('45101', '45104', '45105') THEN 'Y'  -- 금융비용.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '431' THEN 'Y'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '441' THEN 'Y'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '451' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('44101', '44102') THEN '4410'  -- 금융수익.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 5) IN('45101', '45104', '45105') THEN '4510'  -- 금융비용.
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '431' THEN '431'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '441' THEN '441'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '451' THEN '451'
                       ELSE '-'
                     END AS SEQ_GROUP
                   , FH.SORT_SEQ
                   , FH.FORM_ITEM_CLASS
                FROM FI_BALANCE_IS BI
                  , FI_FORM_HEADER FH
              WHERE BI.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
                AND FH.SOB_ID                   = W_SOB_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BI.THIS_L_AMOUNT            <> 0 
                 OR BI.PREV_L_AMOUNT            <> 0)
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
  END SELECT_BALANCE_IS_YEAR;

-- 손익계산서 생성(전월대비).
  PROCEDURE CREATE_BALANCE_IS_MONTH
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_PREV_DATE_FR                DATE;
    V_PREV_DATE_TO                DATE;
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;
    
    V_SYSDATE                     DATE   := GET_LOCAL_DATE(W_SOB_ID);
    V_MONTH_COUNT                 NUMBER := 0;
    V_MESSAGE                     VARCHAR2(200);
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    
    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
    V_THIS_AMOUNT                 NUMBER := 0;
    V_PREV_AMOUNT                 NUMBER := 0;
  BEGIN
    -- 당월.
    V_THIS_DATE_FR := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
    V_THIS_DATE_TO := LAST_DAY(V_THIS_DATE_FR);
    
    -- 전월.
    V_PREV_DATE_FR := TRUNC(ADD_MONTHS(V_THIS_DATE_FR, -1));
    V_PREV_DATE_TO := LAST_DAY(V_PREV_DATE_FR);
    
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
      DELETE FI_BALANCE_IS
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_IS
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
        
    -- 전표 금액 적용.
    FOR C1 IN ( SELECT BI.SOB_ID
                     , BI.HEADER_ID AS FORM_HEADER_ID
                     , BI.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , BI.ITEM_TYPE
                     , BI.ITEM_CLASS
                  FROM FI_BALANCE_IS BI
                     , FI_FORM_HEADER FH
                WHERE BI.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BI.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      -- 당월.
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0)) 
                                                     - (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))
                                                     - (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS THIS_L_AMOUNT 
          INTO V_THIS_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS CL_DR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)) AS CL_CR_AMOUNT
                  FROM FI_SLIP_HEADER SH
                    , FI_SLIP_LINE SL
                WHERE SH.SLIP_HEADER_ID                 = SL.SLIP_HEADER_ID
                  AND SL.GL_DATE                        BETWEEN V_THIS_DATE_FR AND V_THIS_DATE_TO
                  AND SL.SOB_ID                         = C1.SOB_ID                  
                  AND SH.CONFIRM_YN                     = 'Y'
                  AND SH.SLIP_TYPE                      = 'CL'
                  AND SH.SOURCE_TABLE                   = 'FI_CLOSING_SLIP'
                  AND SH.CREATED_TYPE                   = 'I'
                  AND EXISTS (SELECT 'X'
                                FROM FI_FORM_LINE FL
                              WHERE FL.JOIN_ACCOUNT_CONTROL_ID  = SL.ACCOUNT_CONTROL_ID
                                AND FL.SOB_ID                   = SL.SOB_ID
                                AND FL.FORM_HEADER_ID           = C1.FORM_HEADER_ID
                                AND FL.ENABLED_FLAG             = 'Y'
                                AND FL.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
                                AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                             )   
                GROUP BY SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
              ) CL_SL
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
         WHERE FA.PERIOD_NAME           = CL_SL.PERIOD_NAME(+)
           AND FA.SOB_ID                = CL_SL.SOB_ID(+)
           AND FA.ORG_ID                = CL_SL.ORG_ID(+)
           AND FA.ACCOUNT_CONTROL_ID    = CL_SL.ACCOUNT_CONTROL_ID(+)
           AND FA.CURRENCY_CODE         = CL_SL.CURRENCY_CODE(+)
           AND FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           BETWEEN TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AND TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      -- 전월.
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0)) 
                                                     - (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))
                                                     - (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS PREV_L_AMOUNT 
          INTO V_PREV_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS CL_DR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)) AS CL_CR_AMOUNT
                  FROM FI_SLIP_HEADER SH
                    , FI_SLIP_LINE SL
                WHERE SH.SLIP_HEADER_ID                 = SL.SLIP_HEADER_ID
                  AND SL.GL_DATE                        BETWEEN V_PREV_DATE_FR AND V_PREV_DATE_TO
                  AND SL.SOB_ID                         = C1.SOB_ID                  
                  AND SH.CONFIRM_YN                     = 'Y'
                  AND SH.SLIP_TYPE                      = 'CL'
                  AND SH.SOURCE_TABLE                   = 'FI_CLOSING_SLIP'
                  AND SH.CREATED_TYPE                   = 'I'
                  AND EXISTS (SELECT 'X'
                                FROM FI_FORM_LINE FL
                              WHERE FL.JOIN_ACCOUNT_CONTROL_ID  = SL.ACCOUNT_CONTROL_ID
                                AND FL.SOB_ID                   = SL.SOB_ID
                                AND FL.FORM_HEADER_ID           = C1.FORM_HEADER_ID
                                AND FL.ENABLED_FLAG             = 'Y'
                                AND FL.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
                                AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                             )   
                GROUP BY SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
              ) CL_SL
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
         WHERE FA.PERIOD_NAME           = CL_SL.PERIOD_NAME(+)
           AND FA.SOB_ID                = CL_SL.SOB_ID(+)
           AND FA.ORG_ID                = CL_SL.ORG_ID(+)
           AND FA.ACCOUNT_CONTROL_ID    = CL_SL.ACCOUNT_CONTROL_ID(+)
           AND FA.CURRENCY_CODE         = CL_SL.CURRENCY_CODE(+)
           AND FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           BETWEEN TO_CHAR(V_PREV_DATE_FR, 'YYYY-MM') AND TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_IS BI
          SET BI.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
            , BI.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BI.SOB_ID           = C1.SOB_ID
          AND BI.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 당기 제품 제조원가.
    V_THIS_AMOUNT := 0;
    V_PREV_AMOUNT := 0;    
    BEGIN
      FI_BALANCE_MS_G.BALANCE_MS_MONTH_P(W_PERIOD_NAME, W_SOB_ID, V_THIS_AMOUNT, V_PREV_AMOUNT);
      --DBMS_OUTPUT.PUT_LINE('AMOUNT : ' || V_THIS_AMOUNT || ' / ' || V_PREV_AMOUNT);
      
      UPDATE FI_BALANCE_IS BI
        SET BI.THIS_L_AMOUNT  = NVL(V_THIS_AMOUNT, 0)
          , BI.PREV_L_AMOUNT  = NVL(V_PREV_AMOUNT, 0)
      WHERE BI.ITEM_CLASS     = '32'
        AND BI.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('COST ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- 당월 (제품/상품) (기초/기말) 금액 INSERT.
    FOR C1 IN ( SELECT BI.HEADER_ID
                     , BI.HEADER_CODE
                     , BI.HEADER_NAME
                     , BI.ITEM_TYPE
                     , TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AS THIS_PERIOD_FR
                     , TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM') AS THIS_PERIOD_TO
                     , TO_CHAR(V_PREV_DATE_FR, 'YYYY-MM') AS PREV_PERIOD_FR
                     , TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM') AS PREV_PERIOD_TO
                     , BI.SOB_ID
                     , BI.ORG_ID
                  FROM FI_BALANCE_IS BI
                WHERE BI.SOB_ID     = W_SOB_ID
                  AND BI.ITEM_TYPE  IN('741', '742', '751', '752')
               )
    LOOP
      V_THIS_L_AMOUNT := 0;
      V_PREV_L_AMOUNT := 0;
      IF C1.ITEM_TYPE = '741' THEN
      -- 기초 제품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.FG_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.FG_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '742' THEN
      -- 기말 제품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.FG_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.FG_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '751' THEN
      -- 기초 상품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.SG_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.SG_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
        /*V_THIS_L_AMOUNT := FI_BALANCE_IS_G.GOODS_BEGIN_AMOUNT_F(W_FORM_TYPE_ID, C1.THIS_PERIOD_FR, C1.ITEM_TYPE, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_BALANCE_IS_G.GOODS_BEGIN_AMOUNT_F(W_FORM_TYPE_ID, C1.PREV_PERIOD_FR, C1.ITEM_TYPE, C1.SOB_ID);*/
      ELSIF C1.ITEM_TYPE = '752' THEN
      -- 기말 상품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.SG_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.SG_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
        /*V_THIS_L_AMOUNT := FI_BALANCE_IS_G.GOODS_ENDING_AMOUNT_F(W_FORM_TYPE_ID, C1.THIS_PERIOD_TO, C1.ITEM_TYPE, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_BALANCE_IS_G.GOODS_ENDING_AMOUNT_F(W_FORM_TYPE_ID, C1.PREV_PERIOD_TO, C1.ITEM_TYPE, C1.SOB_ID);*/
      ELSE
        V_THIS_L_AMOUNT := 0;
        V_PREV_L_AMOUNT := 0;
      END IF;
      
      -- 당월 INSERT.
      IF V_THIS_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_IS BI
            SET BI.THIS_L_AMOUNT = /*NVL(BI.THIS_L_AMOUNT, 0) +*/ NVL(V_THIS_L_AMOUNT, 0)
          WHERE BI.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
      -- 전월 INSERT.
      IF V_PREV_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_IS BI
            SET BI.PREV_L_AMOUNT = /*NVL(BI.PREV_L_AMOUNT, 0) +*/ NVL(V_PREV_L_AMOUNT, 0)
          WHERE BI.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
    END LOOP C1;
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BI.SOB_ID
                     , BI.HEADER_ID AS FORM_HEADER_ID
                     , BI.HEADER_CODE
                     , FH.FORM_ITEM_NAME
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_IS BI
                     , FI_FORM_HEADER FH
                WHERE BI.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BI.SOB_ID             = W_SOB_ID  
                  AND BI.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY BI.ITEM_LEVEL DESC, BI.SORT_SEQ
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL || ', FORM_ITEM_NAME : ' || C1.FORM_ITEM_NAME);
      UPDATE FI_BALANCE_IS BI
        SET  BI.THIS_L_AMOUNT = NVL(BI.THIS_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BI1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                                        FROM FI_BALANCE_IS BI1
                                          , FI_FORM_LINE FL
                                      WHERE BI1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
          , BI.PREV_L_AMOUNT = NVL(BI.PREV_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BI1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                                        FROM FI_BALANCE_IS BI1
                                          , FI_FORM_LINE FL
                                      WHERE BI1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
      WHERE BI.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END CREATE_BALANCE_IS_MONTH;

-- 손익계산서 생성(전년대비).
  PROCEDURE CREATE_BALANCE_IS_YEAR
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_PREV_DATE_FR                DATE;
    V_PREV_DATE_TO                DATE;
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;

    V_SYSDATE                     DATE   := GET_LOCAL_DATE(W_SOB_ID);
    V_MONTH_COUNT                 NUMBER := 0;
    V_MESSAGE                     VARCHAR2(200);
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);

    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
    V_THIS_AMOUNT                 NUMBER := 0;
    V_PREV_AMOUNT                 NUMBER := 0;
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
      DELETE FI_BALANCE_IS
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_IS
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
        
    -- 전표 금액 적용.
    FOR C1 IN ( SELECT BI.SOB_ID
                     , BI.HEADER_ID AS FORM_HEADER_ID
                     , BI.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , BI.ITEM_TYPE
                     , BI.ITEM_CLASS
                  FROM FI_BALANCE_IS BI
                     , FI_FORM_HEADER FH
                WHERE BI.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BI.SOB_ID             = W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      -- 당월.
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0)) 
                                                     - (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))
                                                     - (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS THIS_L_AMOUNT 
          INTO V_THIS_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS CL_DR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)) AS CL_CR_AMOUNT
                  FROM FI_SLIP_HEADER SH
                    , FI_SLIP_LINE SL
                WHERE SH.SLIP_HEADER_ID                 = SL.SLIP_HEADER_ID
                  AND SL.GL_DATE                        BETWEEN V_THIS_DATE_FR AND V_THIS_DATE_TO
                  AND SL.SOB_ID                         = C1.SOB_ID                  
                  AND SH.CONFIRM_YN                     = 'Y'
                  AND SH.SLIP_TYPE                      = 'CL'
                  AND SH.SOURCE_TABLE                   = 'FI_CLOSING_SLIP'
                  AND SH.CREATED_TYPE                   = 'I'
                  AND EXISTS (SELECT 'X'
                                FROM FI_FORM_LINE FL
                              WHERE FL.JOIN_ACCOUNT_CONTROL_ID  = SL.ACCOUNT_CONTROL_ID
                                AND FL.SOB_ID                   = SL.SOB_ID
                                AND FL.FORM_HEADER_ID           = C1.FORM_HEADER_ID
                                AND FL.ENABLED_FLAG             = 'Y'
                                AND FL.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
                                AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                             )   
                GROUP BY SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
              ) CL_SL
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
         WHERE FA.PERIOD_NAME           = CL_SL.PERIOD_NAME(+)
           AND FA.SOB_ID                = CL_SL.SOB_ID(+)
           AND FA.ORG_ID                = CL_SL.ORG_ID(+)
           AND FA.ACCOUNT_CONTROL_ID    = CL_SL.ACCOUNT_CONTROL_ID(+)
           AND FA.CURRENCY_CODE         = CL_SL.CURRENCY_CODE(+)
           AND FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           BETWEEN TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AND TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      -- 전월.
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0)) 
                                                     - (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(CL_SL.CL_CR_AMOUNT, 0))
                                                     - (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(CL_SL.CL_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS PREV_L_AMOUNT 
          INTO V_PREV_L_AMOUNT
          FROM FI_AGGREGATE FA
            , ( SELECT SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS CL_DR_AMOUNT
                     , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0)) AS CL_CR_AMOUNT
                  FROM FI_SLIP_HEADER SH
                    , FI_SLIP_LINE SL
                WHERE SH.SLIP_HEADER_ID                 = SL.SLIP_HEADER_ID
                  AND SL.GL_DATE                        BETWEEN V_PREV_DATE_FR AND V_PREV_DATE_TO
                  AND SL.SOB_ID                         = C1.SOB_ID                  
                  AND SH.CONFIRM_YN                     = 'Y'
                  AND SH.SLIP_TYPE                      = 'CL'
                  AND SH.SOURCE_TABLE                   = 'FI_CLOSING_SLIP'
                  AND SH.CREATED_TYPE                   = 'I'
                  AND EXISTS (SELECT 'X'
                                FROM FI_FORM_LINE FL
                              WHERE FL.JOIN_ACCOUNT_CONTROL_ID  = SL.ACCOUNT_CONTROL_ID
                                AND FL.SOB_ID                   = SL.SOB_ID
                                AND FL.FORM_HEADER_ID           = C1.FORM_HEADER_ID
                                AND FL.ENABLED_FLAG             = 'Y'
                                AND FL.EFFECTIVE_DATE_FR        <= V_THIS_DATE_TO
                                AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                             )   
                GROUP BY SL.PERIOD_NAME
                     , SL.SOB_ID
                     , SL.ORG_ID
                     , SL.ACCOUNT_BOOK_ID
                     , SL.ACCOUNT_CONTROL_ID
                     , SL.ACCOUNT_CODE
                     , SL.CURRENCY_CODE
              ) CL_SL
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
         WHERE FA.PERIOD_NAME           = CL_SL.PERIOD_NAME(+)
           AND FA.SOB_ID                = CL_SL.SOB_ID(+)
           AND FA.ORG_ID                = CL_SL.ORG_ID(+)
           AND FA.ACCOUNT_CONTROL_ID    = CL_SL.ACCOUNT_CONTROL_ID(+)
           AND FA.CURRENCY_CODE         = CL_SL.CURRENCY_CODE(+)
           AND FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           BETWEEN TO_CHAR(V_PREV_DATE_FR, 'YYYY-MM') AND TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM')
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      BEGIN
        UPDATE FI_BALANCE_IS BI
          SET BI.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
            , BI.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BI.SOB_ID           = C1.SOB_ID
          AND BI.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 당기 제품 제조원가.
    V_THIS_AMOUNT := 0;
    V_PREV_AMOUNT := 0;    
    BEGIN
      FI_BALANCE_MS_G.BALANCE_MS_YEAR_P(W_PERIOD_NAME, W_SOB_ID, V_THIS_AMOUNT, V_PREV_AMOUNT);
      --DBMS_OUTPUT.PUT_LINE('AMOUNT : ' || V_THIS_AMOUNT || ' / ' || V_PREV_AMOUNT);
      
      UPDATE FI_BALANCE_IS BI
        SET BI.THIS_L_AMOUNT  = NVL(V_THIS_AMOUNT, 0)
          , BI.PREV_L_AMOUNT  = NVL(V_PREV_AMOUNT, 0)
      WHERE BI.ITEM_CLASS     = '32'
        AND BI.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('COST ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- 당월 (제품/상품) (기초/기말) 금액 INSERT.
    FOR C1 IN ( SELECT BI.HEADER_ID
                     , BI.HEADER_CODE
                     , BI.HEADER_NAME
                     , BI.ITEM_TYPE
                     , TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AS THIS_PERIOD_FR
                     , TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM') AS THIS_PERIOD_TO
                     , TO_CHAR(V_PREV_DATE_FR, 'YYYY-MM') AS PREV_PERIOD_FR
                     , TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM') AS PREV_PERIOD_TO
                     , BI.SOB_ID
                     , BI.ORG_ID
                  FROM FI_BALANCE_IS BI
                WHERE BI.SOB_ID     = W_SOB_ID
                  AND BI.ITEM_TYPE  IN('741', '742', '751', '752')
               )
    LOOP
      V_THIS_L_AMOUNT := 0;
      V_PREV_L_AMOUNT := 0;
      IF C1.ITEM_TYPE = '741' THEN
      -- 기초 제품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.FG_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.FG_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '742' THEN
      -- 기말 제품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.FG_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.FG_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '751' THEN
      -- 기초 상품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.SG_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.SG_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);        
        /*V_THIS_L_AMOUNT := FI_BALANCE_IS_G.GOODS_BEGIN_AMOUNT_F(W_FORM_TYPE_ID, C1.THIS_PERIOD_FR, C1.ITEM_TYPE, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_BALANCE_IS_G.GOODS_BEGIN_AMOUNT_F(W_FORM_TYPE_ID, C1.PREV_PERIOD_FR, C1.ITEM_TYPE, C1.SOB_ID);*/
      ELSIF C1.ITEM_TYPE = '752' THEN
      -- 기말 상품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.SG_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.SG_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
        /*V_THIS_L_AMOUNT := FI_BALANCE_IS_G.GOODS_ENDING_AMOUNT_F(W_FORM_TYPE_ID, C1.THIS_PERIOD_TO, C1.ITEM_TYPE, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_BALANCE_IS_G.GOODS_ENDING_AMOUNT_F(W_FORM_TYPE_ID, C1.PREV_PERIOD_TO, C1.ITEM_TYPE, C1.SOB_ID);*/
      ELSE
        V_THIS_L_AMOUNT := 0;
        V_PREV_L_AMOUNT := 0;
      END IF;
      
      -- 당월 INSERT.
      IF V_THIS_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_IS BI
            SET BI.THIS_L_AMOUNT = /*NVL(BI.THIS_L_AMOUNT, 0) +*/ NVL(V_THIS_L_AMOUNT, 0)
          WHERE BI.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
      -- 전월 INSERT.
      IF V_PREV_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_IS BI
            SET BI.PREV_L_AMOUNT = /*NVL(BI.PREV_L_AMOUNT, 0) +*/ NVL(V_PREV_L_AMOUNT, 0)
          WHERE BI.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
    END LOOP C1;
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BI.SOB_ID
                     , BI.HEADER_ID AS FORM_HEADER_ID
                     , BI.HEADER_CODE
                     , FH.FORM_ITEM_NAME
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_IS BI
                     , FI_FORM_HEADER FH
                WHERE BI.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BI.SOB_ID             = W_SOB_ID  
                  AND BI.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY BI.ITEM_LEVEL DESC, BI.SORT_SEQ
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL || ', FORM_ITEM_NAME : ' || C1.FORM_ITEM_NAME);
      UPDATE FI_BALANCE_IS BI
        SET  BI.THIS_L_AMOUNT = NVL(BI.THIS_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BI1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                                        FROM FI_BALANCE_IS BI1
                                          , FI_FORM_LINE FL
                                      WHERE BI1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
          , BI.PREV_L_AMOUNT = NVL(BI.PREV_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BI1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                                        FROM FI_BALANCE_IS BI1
                                          , FI_FORM_LINE FL
                                      WHERE BI1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
      WHERE BI.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END CREATE_BALANCE_IS_YEAR;

-- 상품 기초금액 리턴.
  FUNCTION GOODS_BEGIN_AMOUNT_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_FORM_ITEM_TYPE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER                         
            ) RETURN NUMBER
  AS
    V_BEGIN_AMOUNT                NUMBER := 0;
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
  BEGIN
    BEGIN
      SELECT SUM( CASE 
                    WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0)
                    WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0)
                  END
                 ) AS THIS_L_AMOUNT 
        INTO V_BEGIN_AMOUNT
        FROM FI_AGGREGATE FA 
          , FI_ACCOUNT_CONTROL AC
      WHERE FA.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
        AND FA.PERIOD_NAME           <= TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
        AND FA.SOB_ID                = W_SOB_ID
        AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        AND EXISTS (SELECT 'X'
                      FROM FI_FORM_HEADER FH
                        , FI_FORM_LINE FL
                    WHERE FH.SOB_ID           = FA.SOB_ID
                      AND FL.JOIN_ACCOUNT_CONTROL_ID = FA.ACCOUNT_CONTROL_ID
                      AND FH.FORM_HEADER_ID   = FL.FORM_HEADER_ID
                      AND FH.FORM_ITEM_TYPE   = W_FORM_ITEM_TYPE
                      AND FL.LAST_LEVEL_YN    = 'Y'
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BEGIN_AMOUNT := 0;
    END;
    RETURN V_BEGIN_AMOUNT;
  END GOODS_BEGIN_AMOUNT_F;
  
-- 상품 기말금액 리턴.
  FUNCTION GOODS_ENDING_AMOUNT_F
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_FORM_ITEM_TYPE    IN VARCHAR2
            , W_SOB_ID            IN NUMBER                         
            ) RETURN NUMBER
  AS
    V_ENDING_AMOUNT               NUMBER := 0;
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
  BEGIN
    BEGIN
      SELECT SUM( CASE 
                    WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0)
                    WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0)
                  END
                 ) AS THIS_L_AMOUNT 
        INTO V_ENDING_AMOUNT
        FROM FI_AGGREGATE FA 
          , FI_ACCOUNT_CONTROL AC
      WHERE FA.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
        AND FA.PERIOD_NAME           <= W_PERIOD_NAME
        AND FA.SOB_ID                = W_SOB_ID
        AND FA.CURRENCY_CODE         = V_BASE_CURRENCY_CODE
        AND EXISTS (SELECT 'X'
                      FROM FI_FORM_HEADER FH
                        , FI_FORM_LINE FL
                    WHERE FH.SOB_ID           = FA.SOB_ID
                      AND FL.JOIN_ACCOUNT_CONTROL_ID = FA.ACCOUNT_CONTROL_ID
                      AND FH.FORM_HEADER_ID   = FL.FORM_HEADER_ID
                      AND FH.FORM_ITEM_TYPE   = W_FORM_ITEM_TYPE
                      AND FL.LAST_LEVEL_YN    = 'Y'
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ENDING_AMOUNT := 0;
    END;
    RETURN V_ENDING_AMOUNT;
  END GOODS_ENDING_AMOUNT_F;
  
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
    
    O_PROMPT := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10252'
                                                                        , '&&COUNT:=' || V_YEAR_COUNT ||
                                                                          '&&YEAR1:=' || V_YEAR ||
                                                                          '&&MONTH1:=' || V_MONTH ||
                                                                          '&&DAY1:=01' ||
                                                                          '&&YEAR2:=' || V_YEAR ||
                                                                          '&&MONTH2:=' || V_MONTH ||
                                                                          '&&DAY2:=' || V_LAST_DAY);
  END PROMPT_PERIOD_MONTH_P;

-- 기수 및 기간 설정.
  PROCEDURE PROMPT_PERIOD_YEAR_P
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
    O_PROMPT := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10252'
                                                                        , '&&COUNT:=' || V_YEAR_COUNT ||
                                                                          '&&YEAR1:=' || V_YEAR ||
                                                                          '&&MONTH1:=01' ||
                                                                          '&&DAY1:=01' ||
                                                                          '&&YEAR2:=' || V_YEAR ||
                                                                          '&&MONTH2:=' || V_MONTH ||
                                                                          '&&DAY2:=' || V_LAST_DAY);
  END PROMPT_PERIOD_YEAR_P;

-- 그리드 프롬프트 설정(월).
  PROCEDURE PROMPT_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , O_PROMPT            OUT VARCHAR2
            )
  AS
    V_MONTH                       VARCHAR2(2);
  BEGIN
    V_MONTH := TO_CHAR(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MM');
    O_PROMPT := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10253'
                                                                        , '&&MONTH:=' || V_MONTH);
  END PROMPT_MONTH_P;

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

-- 당기순이익 리턴(월).
  PROCEDURE BALANCE_IS_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
  BEGIN
    -- 손익계산서 FORM ID.
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1003'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;    
    -- 손익계산서 생성.
    CREATE_BALANCE_IS_MONTH
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => -1
          );
          
    -- 금액 조회 --
    BEGIN
      SELECT BM.THIS_L_AMOUNT
           , BM.PREV_L_AMOUNT
        INTO O_THIS_AMOUNT
           , O_PREV_AMOUNT
        FROM FI_BALANCE_IS BM
      WHERE BM.ITEM_CLASS     = '21'
        AND BM.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_THIS_AMOUNT := 0;
      O_PREV_AMOUNT := 0;
    END;
  END BALANCE_IS_MONTH_P;

-- 당기순이익 리턴(년).
  PROCEDURE BALANCE_IS_YEAR_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
  BEGIN
    -- 손익계산서 FORM ID.
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1003'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;    
    -- 손익계산서 생성.
    CREATE_BALANCE_IS_YEAR
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => -1
          );
          
    -- 금액 조회 --
    BEGIN
      SELECT BM.THIS_L_AMOUNT
           , BM.PREV_L_AMOUNT
        INTO O_THIS_AMOUNT
           , O_PREV_AMOUNT
        FROM FI_BALANCE_IS BM
      WHERE BM.ITEM_CLASS     = '21'
        AND BM.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_THIS_AMOUNT := 0;
      O_PREV_AMOUNT := 0;
    END;
  END BALANCE_IS_YEAR_P;
  
END FI_BALANCE_IS_G;
/
