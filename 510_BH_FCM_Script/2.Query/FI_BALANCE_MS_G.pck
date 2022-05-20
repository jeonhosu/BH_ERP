CREATE OR REPLACE PACKAGE FI_BALANCE_MS_G
AS
-- 제조원가명세서 조회 : 증감율.
  PROCEDURE SELECT_BALANCE_MS_MONTH
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 제조원가명세서 조회 : 전년동기대비 증감율.
  PROCEDURE SELECT_BALANCE_MS_YEAR
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );

-- 제조원가명세서 생성(증감율).
  PROCEDURE CREATE_BALANCE_MS_MONTH
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );
                        
-- 제조원가명세서 생성(전년동기대비 증감율).
  PROCEDURE CREATE_BALANCE_MS_YEAR
            ( W_FORM_TYPE_ID      IN NUMBER
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            );
            
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

-- 당기제품 제조원가 리턴(월).
  PROCEDURE BALANCE_MS_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            );

-- 당기제품 제조원가 리턴(년).
  PROCEDURE BALANCE_MS_YEAR_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            );
                        
END FI_BALANCE_MS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_BALANCE_MS_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_BALANCE_MS_G
/* Description  : 제조원가명세서 생성/조회.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 대차대조표 조회 : 증감율.
  PROCEDURE SELECT_BALANCE_MS_MONTH
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_SUM_AMOUNT             NUMBER := 0;
    V_PREV_SUM_AMOUNT             NUMBER := 0;
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1004'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    
    -- 제조원가명세서 생성.
    CREATE_BALANCE_MS_MONTH
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );
    
    -- 당기총제조비용 --
    V_THIS_SUM_AMOUNT             := 0;
    V_PREV_SUM_AMOUNT             := 0;
    BEGIN      
      SELECT SUM(BM.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BM.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_SUM_AMOUNT
           , V_PREV_SUM_AMOUNT
        FROM FI_BALANCE_MS BM
          , FI_FORM_HEADER FH
      WHERE BM.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '31'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_SUM_AMOUNT             := 0;
      V_PREV_SUM_AMOUNT             := 0;
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
               WHEN SX1.FORM_ITEM_CLASS IS NOT NULL THEN 'Y'
               ELSE 'N'
             END AS LINE_YN
        FROM (SELECT FH.FORM_ITEM_CODE
                   , FH.FORM_ITEM_NAME
                   , BM.THIS_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '6150000' THEN 
                         CASE
                           WHEN NVL(V_THIS_SUM_AMOUNT, 0) = 0 THEN TO_NUMBER(NULL)
                           ELSE ROUND(NVL(BM.THIS_L_AMOUNT, 0) / V_THIS_SUM_AMOUNT * 100, 2) 
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS THIS_RATE
                   , BM.PREV_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '6150000' THEN 
                         CASE
                           WHEN NVL(V_PREV_SUM_AMOUNT, 0) = 0 THEN TO_NUMBER(NULL)
                           ELSE ROUND(NVL(BM.PREV_L_AMOUNT, 0) / V_PREV_SUM_AMOUNT * 100, 2) 
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS PREV_RATE
                   , NVL(BM.THIS_L_AMOUNT, 0) - NVL(BM.PREV_L_AMOUNT, 0) AS CHANGE_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '6150000' THEN 
                         CASE
                           WHEN NVL(BM.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BM.THIS_L_AMOUNT, 0) - NVL(BM.PREV_L_AMOUNT, 0)) / NVL(BM.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS CHANGE_RATE
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '612' THEN 'Y'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '613' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '612' THEN '612'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '613' THEN '613'
                       ELSE '-'
                     END AS SEQ_GROUP
                   , FH.SORT_SEQ
                   , FH.FORM_ITEM_CLASS
                FROM FI_BALANCE_MS BM
                  , FI_FORM_HEADER FH
              WHERE BM.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
                AND FH.SOB_ID                   = W_SOB_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BM.THIS_L_AMOUNT           <> 0 
                 OR BM.PREV_L_AMOUNT            <> 0)
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
  END SELECT_BALANCE_MS_MONTH;
  
-- 제조원가명세서 조회 : 전년동기대비 증감율.
  PROCEDURE SELECT_BALANCE_MS_YEAR
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , P_USER_ID           IN NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
    V_THIS_SUM_AMOUNT             NUMBER := 0;
    V_PREV_SUM_AMOUNT             NUMBER := 0;
  BEGIN
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1004'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;
    
    -- 제조원가명세서 생성.
    CREATE_BALANCE_MS_YEAR
          ( W_FORM_TYPE_ID => V_FORM_TYPE_ID
          , W_PERIOD_NAME => W_PERIOD_NAME
          , W_SOB_ID => W_SOB_ID
          , P_USER_ID => P_USER_ID
          );
    
    -- 당기총제조비용 --
    V_THIS_SUM_AMOUNT             := 0;
    V_PREV_SUM_AMOUNT             := 0;
    BEGIN      
      SELECT SUM(BM.THIS_L_AMOUNT) AS THIS_L_AMOUNT
           , SUM(BM.PREV_L_AMOUNT) AS PREV_L_AMOUNT
        INTO V_THIS_SUM_AMOUNT
           , V_PREV_SUM_AMOUNT
        FROM FI_BALANCE_MS BM
          , FI_FORM_HEADER FH
      WHERE BM.HEADER_ID                = FH.FORM_HEADER_ID
        AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
        AND FH.SOB_ID                   = W_SOB_ID
        AND FH.FORM_ITEM_CLASS          = '31'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_THIS_SUM_AMOUNT             := 0;
      V_PREV_SUM_AMOUNT             := 0;
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
               WHEN SX1.FORM_ITEM_CLASS IS NOT NULL THEN 'Y'
               ELSE 'N'
             END AS LINE_YN
        FROM (SELECT FH.FORM_ITEM_CODE
                   , FH.FORM_ITEM_NAME
                   , BM.THIS_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '6150000' THEN 
                         CASE
                           WHEN NVL(V_THIS_SUM_AMOUNT, 0) = 0 THEN TO_NUMBER(NULL)
                           ELSE ROUND(NVL(BM.THIS_L_AMOUNT, 0) / V_THIS_SUM_AMOUNT * 100, 2) 
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS THIS_RATE
                   , BM.PREV_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '6150000' THEN 
                         CASE
                           WHEN NVL(V_PREV_SUM_AMOUNT, 0) = 0 THEN TO_NUMBER(NULL)
                           ELSE ROUND(NVL(BM.PREV_L_AMOUNT, 0) / V_PREV_SUM_AMOUNT * 100, 2) 
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS PREV_RATE
                   , NVL(BM.THIS_L_AMOUNT, 0) - NVL(BM.PREV_L_AMOUNT, 0) AS CHANGE_L_AMOUNT
                   , CASE
                       WHEN FH.FORM_ITEM_CODE < '6150000' THEN 
                         CASE
                           WHEN NVL(BM.PREV_L_AMOUNT, 0) = 0 THEN 0
                           ELSE ROUND((NVL(BM.THIS_L_AMOUNT, 0) - NVL(BM.PREV_L_AMOUNT, 0)) / NVL(BM.PREV_L_AMOUNT, 0) * 100, 2)
                         END
                       ELSE TO_NUMBER(NULL)
                     END AS CHANGE_RATE
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '612' THEN 'Y'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '613' THEN 'Y'
                       ELSE 'N'
                     END AS SEQ_NUM_YN
                   , CASE
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '612' THEN '612'
                       WHEN FH.LAST_LEVEL_YN = 'Y' AND SUBSTR(FH.FORM_ITEM_CODE, 1, 3) = '613' THEN '613'
                       ELSE '-'
                     END AS SEQ_GROUP
                   , FH.SORT_SEQ
                   , FH.FORM_ITEM_CLASS
                FROM FI_BALANCE_MS BM
                  , FI_FORM_HEADER FH
              WHERE BM.HEADER_ID                = FH.FORM_HEADER_ID
                AND FH.FORM_TYPE_ID             = V_FORM_TYPE_ID
                AND FH.SOB_ID                   = W_SOB_ID
                AND FH.DISPLAY_YN               = 'Y'
                AND (BM.THIS_L_AMOUNT           <> 0 
                 OR BM.PREV_L_AMOUNT            <> 0)
             ) SX1
      ORDER BY SX1.SORT_SEQ
      ;
  END SELECT_BALANCE_MS_YEAR;

-- 제조원가명세서 생성(증감율).
  PROCEDURE CREATE_BALANCE_MS_MONTH
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
      DELETE FI_BALANCE_MS
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_MS
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
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , BB.ITEM_TYPE
                     , BB.ITEM_CLASS
                  FROM FI_BALANCE_MS BB
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
        UPDATE FI_BALANCE_MS BB
          SET BB.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
            , BB.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 당월 원재료 기초 금액 INSERT.
    FOR C1 IN ( SELECT BM.HEADER_ID
                     , BM.HEADER_CODE
                     , BM.HEADER_NAME
                     , BM.ITEM_TYPE
                     , TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AS THIS_PERIOD_FR
                     , TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM') AS THIS_PERIOD_TO
                     , TO_CHAR(V_PREV_DATE_FR, 'YYYY-MM') AS PREV_PERIOD_FR
                     , TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM') AS PREV_PERIOD_TO
                     , BM.SOB_ID
                     , BM.ORG_ID
                  FROM FI_BALANCE_MS BM
                WHERE BM.SOB_ID     = W_SOB_ID
                  AND BM.ITEM_TYPE  IN('711', '712', '721', '722', '731', '732')
               )
    LOOP
      V_THIS_L_AMOUNT := 0;
      V_PREV_L_AMOUNT := 0;
      IF C1.ITEM_TYPE = '711' THEN
      -- 기초 원재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.MAT_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.MAT_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '712' THEN
      -- 기말 원재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.MAT_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.MAT_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '721' THEN
      -- 기초 부재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.PAT_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.PAT_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '722' THEN
      -- 기말 부재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.PAT_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.PAT_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '731' THEN
      -- 기초 재공품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.WIP_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.WIP_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '732' THEN
      -- 기말 재공품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.WIP_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.WIP_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSE
        V_THIS_L_AMOUNT := 0;
        V_PREV_L_AMOUNT := 0;
      END IF;
      
      -- 당월 INSERT.
      IF V_THIS_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_MS BM
            SET BM.THIS_L_AMOUNT = NVL(BM.THIS_L_AMOUNT, 0) + NVL(V_THIS_L_AMOUNT, 0)
          WHERE BM.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
      -- 전월 INSERT.
      IF V_PREV_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_MS BM
            SET BM.PREV_L_AMOUNT = NVL(BM.PREV_L_AMOUNT, 0) + NVL(V_PREV_L_AMOUNT, 0)
          WHERE BM.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
    END LOOP C1;
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.HEADER_CODE
                     , FH.FORM_ITEM_NAME
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_MS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND BB.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY BB.ITEM_LEVEL DESC, BB.SORT_SEQ
              )
    LOOP
/*
      DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL || 
                             ', FORM_ITEM_NAME : ' || C1.FORM_ITEM_NAME);
*/
      UPDATE FI_BALANCE_MS BB
        SET  BB.THIS_L_AMOUNT = NVL(BB.THIS_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BB1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                                        FROM FI_BALANCE_MS BB1
                                          , FI_FORM_LINE FL
                                      WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
          , BB.PREV_L_AMOUNT = NVL(BB.PREV_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BB1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                                        FROM FI_BALANCE_MS BB1
                                          , FI_FORM_LINE FL
                                      WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END CREATE_BALANCE_MS_MONTH;
  
-- 제조원가명세서 생성(증감율).
  PROCEDURE CREATE_BALANCE_MS_YEAR
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
      DELETE FI_BALANCE_MS
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Delete Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    INSERT INTO FI_BALANCE_MS
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
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                     , BB.ITEM_TYPE
                     , BB.ITEM_CLASS
                  FROM FI_BALANCE_MS BB
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
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      V_PREV_L_AMOUNT               := 0;
      V_PREV_R_AMOUNT               := 0;
      -- 당기.
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
      
      -- 전기.
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
        UPDATE FI_BALANCE_MS BB
          SET BB.THIS_L_AMOUNT    = NVL(V_THIS_L_AMOUNT, 0)
            , BB.PREV_L_AMOUNT    = NVL(V_PREV_L_AMOUNT, 0)
        WHERE BB.SOB_ID           = C1.SOB_ID
          AND BB.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;
    
    -- 당월 원재료 기초 금액 INSERT.
    FOR C1 IN ( SELECT BM.HEADER_ID
                     , BM.HEADER_CODE
                     , BM.HEADER_NAME
                     , BM.ITEM_TYPE
                     , TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AS THIS_PERIOD_FR
                     , TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM') AS THIS_PERIOD_TO
                     , TO_CHAR(V_PREV_DATE_FR, 'YYYY-MM') AS PREV_PERIOD_FR
                     , TO_CHAR(V_PREV_DATE_TO, 'YYYY-MM') AS PREV_PERIOD_TO
                     , BM.SOB_ID
                     , BM.ORG_ID
                  FROM FI_BALANCE_MS BM
                WHERE BM.SOB_ID     = W_SOB_ID
                  AND BM.ITEM_TYPE  IN('711', '712', '721', '722', '731', '732')
               )
    LOOP
      V_THIS_L_AMOUNT := 0;
      V_PREV_L_AMOUNT := 0;
      IF C1.ITEM_TYPE = '711' THEN
      -- 기초 원재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.MAT_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.MAT_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '712' THEN
      -- 기말 원재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.MAT_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.MAT_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '721' THEN
      -- 기초 부재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.PAT_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.PAT_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '722' THEN
      -- 기말 부재료.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.PAT_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.PAT_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '731' THEN
      -- 기초 재공품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.WIP_BEGIN_AMOUNT(C1.THIS_PERIOD_FR, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.WIP_BEGIN_AMOUNT(C1.PREV_PERIOD_FR, C1.SOB_ID);
      ELSIF C1.ITEM_TYPE = '732' THEN
      -- 기말 재공품.
        V_THIS_L_AMOUNT := FI_CLOSING_SET_G.WIP_ENDING_AMOUNT(C1.THIS_PERIOD_TO, C1.SOB_ID);
        V_PREV_L_AMOUNT := FI_CLOSING_SET_G.WIP_ENDING_AMOUNT(C1.PREV_PERIOD_TO, C1.SOB_ID);
      ELSE
        V_THIS_L_AMOUNT := 0;
        V_PREV_L_AMOUNT := 0;
      END IF;
      
      -- 당월 INSERT.
      IF V_THIS_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_MS BM
            SET BM.THIS_L_AMOUNT = NVL(BM.THIS_L_AMOUNT, 0) + NVL(V_THIS_L_AMOUNT, 0)
          WHERE BM.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
      -- 전월 INSERT.
      IF V_PREV_L_AMOUNT <> 0 THEN
        BEGIN
          UPDATE FI_BALANCE_MS BM
            SET BM.PREV_L_AMOUNT = NVL(BM.PREV_L_AMOUNT, 0) + NVL(V_PREV_L_AMOUNT, 0)
          WHERE BM.HEADER_ID     = C1.HEADER_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;
      END IF;
    END LOOP C1;
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , BB.HEADER_CODE
                     , FH.FORM_ITEM_NAME
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_MS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = W_SOB_ID  
                  AND BB.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY BB.ITEM_LEVEL DESC, BB.SORT_SEQ
              )
    LOOP
/*
      DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL || 
                             ', FORM_ITEM_NAME : ' || C1.FORM_ITEM_NAME);
*/
      UPDATE FI_BALANCE_MS BB
        SET  BB.THIS_L_AMOUNT = NVL(BB.THIS_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BB1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                                        FROM FI_BALANCE_MS BB1
                                          , FI_FORM_LINE FL
                                      WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
          , BB.PREV_L_AMOUNT = NVL(BB.PREV_L_AMOUNT, 0) + 
                                NVL((SELECT SUM(BB1.PREV_L_AMOUNT * FL.ITEM_SIGN) AS PREV_L_AMOUNT
                                        FROM FI_BALANCE_MS BB1
                                          , FI_FORM_LINE FL
                                      WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                                        AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                                        AND FL.SOB_ID             = C1.SOB_ID
                                    ), 0)
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  END CREATE_BALANCE_MS_YEAR;

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
    -- 회계 기수 --
    BEGIN
      V_YEAR_COUNT := GL_FISCAL_YEAR_G.FISCAL_YEAR_COUNT_F(V_YEAR, W_SOB_ID);
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_COUNT := 1;    
    END;
    V_YEAR := TO_CHAR(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'YYYY');
    V_MONTH := TO_CHAR(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MM');
    V_LAST_DAY := TO_CHAR(LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM')), 'DD');
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

-- 당기제품 제조원가 리턴.
  PROCEDURE BALANCE_MS_MONTH_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            )
  AS
    V_FORM_TYPE_ID                NUMBER;
  BEGIN
    -- 제조원가명세서 FORM ID.
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1004'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;    
    -- 제조원가명세서 생성.
    CREATE_BALANCE_MS_MONTH
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
        FROM FI_BALANCE_MS BM
      WHERE BM.ITEM_CLASS     = '32'
        AND BM.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_THIS_AMOUNT := 0;
      O_PREV_AMOUNT := 0;
    END;    
  END BALANCE_MS_MONTH_P;

-- 당기제품 제조원가 리턴(년).
  PROCEDURE BALANCE_MS_YEAR_P
            ( W_PERIOD_NAME       IN VARCHAR2
            , W_SOB_ID            IN NUMBER            
            , O_THIS_AMOUNT       OUT NUMBER
            , O_PREV_AMOUNT       OUT NUMBER
            )
  AS
  V_FORM_TYPE_ID                NUMBER;
  BEGIN
    -- 제조원가명세서 FORM ID.
    BEGIN
      SELECT FT.FORM_TYPE_ID
        INTO V_FORM_TYPE_ID
        FROM FI_FORM_TYPE_V FT
      WHERE FT.FORM_TYPE          = '1004'
        AND FT.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_FORM_TYPE_ID := 0;
    END;    
    -- 제조원가명세서 생성.
    CREATE_BALANCE_MS_YEAR
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
        FROM FI_BALANCE_MS BM
      WHERE BM.ITEM_CLASS     = '32'
        AND BM.SOB_ID         = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_THIS_AMOUNT := 0;
      O_PREV_AMOUNT := 0;
    END;
  END BALANCE_MS_YEAR_P;
    
END FI_BALANCE_MS_G;
/
