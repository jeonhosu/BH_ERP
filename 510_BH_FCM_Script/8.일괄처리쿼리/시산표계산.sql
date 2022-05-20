/*INSERT INTO FI_BALANCE_FS_GT 
      ( HEADER_ID
      , header_code 
      , ITEM_LEVEL
      , SOB_ID
      , ORG_ID
      , BEFORE_DR_AMOUNT
      , BEFORE_CR_AMOUNT
      , THIS_DR_AMOUNT
      , THIS_CR_AMOUNT
      , REMAIN_DR_AMOUNT
      , REMAIN_CR_AMOUNT
      )
      SELECT FH.FORM_HEADER_ID
           , FH.FORM_ITEM_CODE
           , FH.ITEM_LEVEL
           , FH.SOB_ID
           , FH.ORG_ID     
           , 0 AS BEFORE_DR_AMOUNT
           , 0 AS BEFORE_CR_AMOUNT
           , 0 AS THIS_DR_AMOUNT
           , 0 AS THIS_CR_AMOUNT
           , 0 AS REMAIN_DR_AMOUNT
           , 0 AS REMAIN_CR_AMOUNT
        FROM FI_FORM_HEADER FH
      WHERE FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
        AND FH.SOB_ID                   = &W_SOB_ID
        AND FH.ENABLED_FLAG             = 'Y'
        AND FH.EFFECTIVE_DATE_FR        <= &V_GL_DATE_TO
        AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= &V_GL_DATE_FR)
      ;
      */
-- 최종레벨 조회.
DECLARE
  V_GL_DATE_FR                    DATE := TO_DATE('2010-12-01', 'YYYY-MM-DD');
  V_GL_DATE_TO                    DATE := TO_DATE('2010-12-31', 'YYYY-MM-DD');
  
  V_BEFORE_DR_AMOUNT              NUMBER := 0;
  V_BEFORE_CR_AMOUNT              NUMBER := 0;
  V_THIS_DR_AMOUNT                NUMBER := 0;
  V_THIS_CR_AMOUNT                NUMBER := 0;
  V_REMAIN_DR_AMOUNT              NUMBER := 0;
  V_REMAIN_CR_AMOUNT              NUMBER := 0;
      
BEGIN
    -- 전표 금액 적용.
    FOR C1 IN ( SELECT &W_PERIOD_NAME AS PERIOD_NAME
                     , BF.SOB_ID
                     , BF.HEADER_ID AS FORM_HEADER_ID
                     , BF.ITEM_LEVEL
                     , FH.ACCOUNT_DR_CR
                  FROM FI_BALANCE_FS_GT BF
                     , FI_FORM_HEADER FH
                WHERE BF.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BF.SOB_ID             = &W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_GL_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)
                )
    LOOP
      DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      
      V_BEFORE_DR_AMOUNT              := 0;
      V_BEFORE_CR_AMOUNT              := 0;
      V_THIS_DR_AMOUNT                := 0;
      V_THIS_CR_AMOUNT                := 0;
      V_REMAIN_DR_AMOUNT              := 0;
      V_REMAIN_CR_AMOUNT              := 0;
      
      BEGIN
        SELECT SUM(DECODE(AC.ACCOUNT_DR_CR, '1', NVL(FA.TOTAL_DR_AMOUNT, 0) - NVL(FA.TOTAL_CR_AMOUNT, 0)) * NVL(FFL.ITEM_SIGN, 1)) AS BEFORE_DR_AMOUNT
             , SUM(DECODE(AC.ACCOUNT_DR_CR, '2', NVL(FA.TOTAL_CR_AMOUNT, 0) - NVL(FA.TOTAL_DR_AMOUNT, 0)) * NVL(FFL.ITEM_SIGN, 1)) AS BEFORE_CR_AMOUNT 
             , SUM(NVL(FA.PERIOD_DR_AMOUNT, 0) * NVL(FFL.ITEM_SIGN, 1)) AS THIS_DR_AMOUNT
             , SUM(NVL(FA.PERIOD_CR_AMOUNT, 0) * NVL(FFL.ITEM_SIGN, 1)) AS THIS_CR_AMOUNT
             , SUM(DECODE(AC.ACCOUNT_DR_CR, '1', (NVL(FA.TOTAL_DR_AMOUNT, 0) - NVL(FA.TOTAL_CR_AMOUNT, 0)) 
                                             + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)) AS REMAIN_DR_AMOUNT
             , SUM(DECODE(AC.ACCOUNT_DR_CR, '2', (NVL(FA.TOTAL_CR_AMOUNT, 0) - NVL(FA.TOTAL_DR_AMOUNT, 0))
                                             + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)) AS REMAIN_CR_AMOUNT 
          INTO V_BEFORE_DR_AMOUNT
             , V_BEFORE_CR_AMOUNT
             , V_THIS_DR_AMOUNT
             , V_THIS_CR_AMOUNT
             , V_REMAIN_DR_AMOUNT
             , V_REMAIN_CR_AMOUNT
          FROM FI_AGGREGATE FA
            , FI_ACCOUNT_CONTROL AC
            , ( SELECT FL.FORM_LINE_ID
                     , FL.SOB_ID
                     , FL.ITEM_SIGN
                     , FL.JOIN_ACCOUNT_CONTROL_ID AS ACCOUNT_CONTROL_ID
                  FROM FI_FORM_LINE FL
                WHERE FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                  AND FL.SOB_ID             = C1.SOB_ID
                  AND FL.ENABLED_FLAG       = 'Y'
                  AND FL.EFFECTIVE_DATE_FR  <= V_GL_DATE_TO
                  AND (FL.EFFECTIVE_DATE_TO IS NULL OR FL.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)
              ) FFL
         WHERE FA.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = AC.SOB_ID
           AND FA.ACCOUNT_CONTROL_ID    = FFL.ACCOUNT_CONTROL_ID
           AND FA.SOB_ID                = FFL.SOB_ID
           AND FA.PERIOD_NAME           = C1.PERIOD_NAME
           AND FA.SOB_ID                = C1.SOB_ID
           AND FA.CURRENCY_CODE         = FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(C1.SOB_ID)
        GROUP BY FA.ACCOUNT_CONTROL_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      BEGIN
        UPDATE FI_BALANCE_FS_GT BF
          SET BF.BEFORE_DR_AMOUNT = NVL(V_BEFORE_DR_AMOUNT, 0)
            , BF.BEFORE_CR_AMOUNT = NVL(V_BEFORE_CR_AMOUNT, 0) 
            , BF.THIS_DR_AMOUNT   = NVL(V_THIS_DR_AMOUNT, 0)
            , BF.THIS_CR_AMOUNT   = NVL(V_THIS_CR_AMOUNT, 0)
            , BF.REMAIN_DR_AMOUNT = NVL(V_REMAIN_DR_AMOUNT, 0)
            , BF.REMAIN_CR_AMOUNT = NVL(V_REMAIN_CR_AMOUNT, 0)
        WHERE BF.SOB_ID           = C1.SOB_ID
          AND BF.HEADER_ID        = C1.FORM_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Update Error : ' || SUBSTR(SQLERRM, 1, 150));
      END;
    END LOOP C1;

END;
/*
SELECT FH.LAST_LEVEL_YN
     , FH.ITEM_LEVEL
     , FH.FORM_ITEM_NAME
     , BF.*
  FROM FI_BALANCE_FS_GT BF
    , FI_FORM_HEADER FH
WHERE BF.HEADER_ID                = FH.FORM_HEADER_ID
  AND FH.LAST_LEVEL_YN            = 'Y'
;*/

DECLARE
  V_GL_DATE_FR                    DATE := TO_DATE('2010-12-01', 'YYYY-MM-DD');
  V_GL_DATE_TO                    DATE := TO_DATE('2010-12-31', 'YYYY-MM-DD');
  
BEGIN
  FOR C1 IN ( SELECT BF.SOB_ID
                     , BF.HEADER_ID AS FORM_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_FS_GT BF
                     , FI_FORM_HEADER FH
                WHERE BF.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BF.SOB_ID             = &W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_GL_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_GL_DATE_FR)      
                ORDER BY BF.HEADER_ID, FH.ITEM_LEVEL DESC
              )
    LOOP
      DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_BALANCE_FS_GT BF
        SET ( BF.BEFORE_DR_AMOUNT
          , BF.BEFORE_CR_AMOUNT
          , BF.THIS_DR_AMOUNT
          , BF.THIS_CR_AMOUNT
          , BF.REMAIN_DR_AMOUNT
          , BF.REMAIN_CR_AMOUNT
            ) =
            ( SELECT SUM(BF1.BEFORE_DR_AMOUNT * FL.ITEM_SIGN) AS BEFORE_DR_AMOUNT
                   , SUM(BF1.BEFORE_CR_AMOUNT * FL.ITEM_SIGN) AS BEFORE_CR_AMOUNT
                   , SUM(BF1.THIS_DR_AMOUNT * FL.ITEM_SIGN) AS THIS_DR_AMOUNT
                   , SUM(BF1.THIS_CR_AMOUNT * FL.ITEM_SIGN) AS THIS_CR_AMOUNT
                   , SUM(BF1.REMAIN_DR_AMOUNT * FL.ITEM_SIGN) AS REMAIN_DR_AMOUNT
                   , SUM(BF1.REMAIN_CR_AMOUNT * FL.ITEM_SIGN) AS REMAIN_CR_AMOUNT
                FROM FI_BALANCE_FS_GT BF1
                  , FI_FORM_LINE FL
              WHERE BF1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                AND FL.SOB_ID             = C1.SOB_ID
            )
      WHERE BF.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
END;

/*
SELECT FH.LAST_LEVEL_YN
     , FH.ITEM_LEVEL
     , BF.*
  FROM FI_BALANCE_FS_GT BF
    , FI_FORM_HEADER FH
WHERE BF.HEADER_ID                = FH.FORM_HEADER_ID
ORDER BY FH.SORT_SEQ
;
*/
-- 시산표 조회.
SELECT CASE
               WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FH.LAST_LEVEL_YN, 'Y', FG.REMAIN_DR_AMOUNT, 0))
               ELSE SUM(FG.REMAIN_DR_AMOUNT)
             END AS REMAIN_DR_AMOUNT
           , CASE
               WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FH.LAST_LEVEL_YN, 'Y', FG.THIS_DR_AMOUNT, 0))
               ELSE SUM(FG.THIS_DR_AMOUNT) 
             END AS THIS_DR_AMOUNT
           , CASE
               WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FH.LAST_LEVEL_YN, 'Y', FG.BEFORE_DR_AMOUNT, 0))
               ELSE SUM(FG.BEFORE_DR_AMOUNT) 
             END AS BEFORE_DR_AMOUNT           
           , FH.FORM_ITEM_CODE
           , DECODE(GROUPING(FH.FORM_ITEM_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FH.FORM_ITEM_NAME) AS FORM_ITEM_NAME
           , FH.SORT_SEQ
           , CASE
               WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FH.LAST_LEVEL_YN, 'Y', FG.BEFORE_CR_AMOUNT, 0))
               ELSE SUM(FG.BEFORE_CR_AMOUNT) 
             END AS BEFORE_CR_AMOUNT
           , CASE
               WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FH.LAST_LEVEL_YN, 'Y', FG.THIS_CR_AMOUNT, 0))
               ELSE SUM(FG.THIS_CR_AMOUNT) 
             END AS THIS_CR_AMOUNT 
           , CASE
               WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FH.LAST_LEVEL_YN, 'Y', FG.REMAIN_CR_AMOUNT, 0))
               ELSE SUM(FG.REMAIN_CR_AMOUNT) 
             END AS REMAIN_CR_AMOUNT     
        FROM FI_FORM_HEADER FH
          , FI_BALANCE_FS_GT FG
      WHERE FG.HEADER_ID                = FH.FORM_HEADER_ID
        AND FG.SOB_ID                   = FH.SOB_ID
        AND FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
        AND FH.SOB_ID                   = &W_SOB_ID
        AND FH.DISPLAY_YN               = 'Y'
        AND (FG.REMAIN_DR_AMOUNT        <> 0
            OR FG.THIS_DR_AMOUNT        <> 0
            OR FG.BEFORE_DR_AMOUNT      <> 0
            OR FG.BEFORE_CR_AMOUNT      <> 0
            OR FG.THIS_CR_AMOUNT        <> 0
            OR FG.REMAIN_CR_AMOUNT      <> 0)
      GROUP BY ROLLUP((FH.FORM_ITEM_CODE
           , FH.FORM_ITEM_NAME
           , FH.SORT_SEQ))
      ORDER BY FH.SORT_SEQ
;      

-- 시산표 조회.
SELECT FG.REMAIN_DR_AMOUNT AS REMAIN_DR_AMOUNT
           , FG.THIS_DR_AMOUNT AS THIS_DR_AMOUNT
           , FG.BEFORE_DR_AMOUNT AS BEFORE_DR_AMOUNT           
           , FH.FORM_ITEM_CODE
           , FH.FORM_ITEM_NAME AS FORM_ITEM_NAME
           , FH.SORT_SEQ
           , FG.BEFORE_CR_AMOUNT AS BEFORE_CR_AMOUNT
           , FG.THIS_CR_AMOUNT AS THIS_CR_AMOUNT 
           , FG.REMAIN_CR_AMOUNT AS REMAIN_CR_AMOUNT     
        FROM FI_FORM_HEADER FH
          , FI_BALANCE_FS_GT FG
      WHERE FG.HEADER_ID                = FH.FORM_HEADER_ID
        AND FG.SOB_ID                   = FH.SOB_ID
        AND FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
        AND FH.SOB_ID                   = &W_SOB_ID
        AND FH.DISPLAY_YN               = 'Y'
        AND (FG.REMAIN_DR_AMOUNT        <> 0
            OR FG.THIS_DR_AMOUNT        <> 0
            OR FG.BEFORE_DR_AMOUNT      <> 0
            OR FG.BEFORE_CR_AMOUNT      <> 0
            OR FG.THIS_CR_AMOUNT        <> 0
            OR FG.REMAIN_CR_AMOUNT      <> 0)

      ORDER BY FH.SORT_SEQ
;      
