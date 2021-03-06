/*
DECLARE

BEGIN
  BEGIN
    DELETE FI_BALANCE_FS_GT
    ;

    INSERT INTO FI_BALANCE_FS_GT 
    ( HEADER_ID
    , LINE_HEADER_ID
    , LINE_ID
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
    SELECT FL.FORM_HEADER_ID
         , FL.JOIN_LINE_CONTROL_ID
         , FL.FORM_LINE_ID
         , FL.ITEM_LEVEL
         , FL.SOB_ID
         , FL.ORG_ID     
         , 0 AS BEFORE_DR_AMOUNT
         , 0 AS BEFORE_CR_AMOUNT
         , 0 AS THIS_DR_AMOUNT
         , 0 AS THIS_CR_AMOUNT
         , 0 AS REMAIN_DR_AMOUNT
         , 0 AS REMAIN_CR_AMOUNT
      FROM FI_FORM_LINE FL
        , FI_FORM_HEADER FH
    WHERE FL.FORM_HEADER_ID           = FH.FORM_HEADER_ID
      AND FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
      AND FH.SOB_ID                   = &W_SOB_ID
      AND FH.LAST_LEVEL_YN            <> 'Y'  
    ;
      
    INSERT INTO FI_BALANCE_FS_GT 
    ( HEADER_ID
    , LINE_HEADER_ID
    , LINE_ID
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
    SELECT FL.FORM_HEADER_ID
         , FL.JOIN_LINE_CONTROL_ID
         , FL.FORM_LINE_ID
         , FL.ITEM_LEVEL
         , FL.SOB_ID
         , FL.ORG_ID     
         , NVL(SX1.BEFORE_DR_AMOUNT, 0) * NVL(FL.ITEM_SIGN, 1) AS BEFORE_DR_AMOUNT
         , NVL(SX1.BEFORE_CR_AMOUNT, 0) * NVL(FL.ITEM_SIGN, 1) AS BEFORE_CR_AMOUNT
         , NVL(SX1.THIS_DR_AMOUNT, 0) * NVL(FL.ITEM_SIGN, 1) AS THIS_DR_AMOUNT
         , NVL(SX1.THIS_CR_AMOUNT, 0) * NVL(FL.ITEM_SIGN, 1) AS THIS_CR_AMOUNT
         , NVL(SX1.REMAIN_DR_AMOUNT, 0) * NVL(FL.ITEM_SIGN, 1) AS REMAIN_DR_AMOUNT
         , NVL(SX1.REMAIN_CR_AMOUNT, 0) * NVL(FL.ITEM_SIGN, 1) AS REMAIN_CR_AMOUNT
      FROM FI_FORM_LINE FL
        , FI_FORM_HEADER FH
        , (-- ?? ????.
          SELECT DS.ACCOUNT_CONTROL_ID
               , DS.ACCOUNT_CODE
               , NVL(SUM(DS.DR_SUM), 0) AS BEFORE_DR_AMOUNT
               , NVL(SUM(DS.CR_SUM), 0) AS BEFORE_CR_AMOUNT
               , 0 AS THIS_DR_AMOUNT
               , 0 AS THIS_CR_AMOUNT
               , NVL(SUM(DECODE(AC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0))), 0) AS REMAIN_DR_AMOUNT                
               , NVL(SUM(DECODE(AC.ACCOUNT_DR_CR, '2', NVL(DS.CR_SUM, 0) - NVL(DS.DR_SUM, 0))), 0) AS REMAIN_CR_AMOUNT
            FROM FI_DAILY_SUM DS
              , FI_ACCOUNT_CONTROL AC
           WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
             AND DS.SOB_ID                = AC.SOB_ID          
             AND DS.GL_DATE               = TO_DATE(&W_PERIOD_NAME, 'YYYY-MM')
             AND DS.GL_DATE_SEQ           = 0
             AND DS.SOB_ID                = &W_SOB_ID
          GROUP BY DS.ACCOUNT_CONTROL_ID
               , DS.ACCOUNT_CODE   
          UNION ALL
          -- ?? ?߻?.
          SELECT DS.ACCOUNT_CONTROL_ID
               , DS.ACCOUNT_CODE
               , 0 AS BEFORE_DR_AMOUNT
               , 0 AS BEFORE_CR_AMOUNT     
               , NVL(SUM(DS.DR_SUM), 0) AS THIS_DR_AMOUNT
               , NVL(SUM(DS.CR_SUM), 0) AS THIS_CR_AMOUNT
               , NVL(SUM(DECODE(AC.ACCOUNT_DR_CR, '1', NVL(DS.DR_SUM, 0) - NVL(DS.CR_SUM, 0))), 0) AS REMAIN_DR_AMOUNT                
               , NVL(SUM(DECODE(AC.ACCOUNT_DR_CR, '2', NVL(DS.CR_SUM, 0) - NVL(DS.DR_SUM, 0))), 0) AS REMAIN_CR_AMOUNT
            FROM FI_DAILY_SUM DS
              , FI_ACCOUNT_CONTROL AC
           WHERE DS.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
             AND DS.SOB_ID                = AC.SOB_ID          
             AND DS.GL_DATE               BETWEEN TO_DATE(&W_PERIOD_NAME, 'YYYY-MM') AND LAST_DAY(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'))
             AND DS.GL_DATE_SEQ           = 1
             AND DS.SOB_ID                = &W_SOB_ID
          GROUP BY DS.ACCOUNT_CONTROL_ID
               , DS.ACCOUNT_CODE   
          ) SX1
    WHERE FL.FORM_HEADER_ID           = FH.FORM_HEADER_ID
      AND FL.LAST_LEVEL_YN            = 'Y'
      AND FL.JOIN_ACCOUNT_CONTROL_ID  = SX1.ACCOUNT_CONTROL_ID(+)
      AND FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
      AND FH.SOB_ID                   = &W_SOB_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, '?????ڷ? ???? ????' || SQLERRM);
  END;

  FOR C1 IN ( SELECT FH.FORM_HEADER_ID
                     , FH.ITEM_LEVEL
                     , FL.JOIN_LINE_CONTROL_ID
                FROM FI_FORM_HEADER FH
                  , FI_FORM_LINE FL
              WHERE FH.FORM_HEADER_ID     = FL.FORM_HEADER_ID
                AND FH.SOB_ID             = FL.SOB_ID
                AND FH.LAST_LEVEL_YN      <> 'Y'
                AND FH.SOB_ID             = &W_SOB_ID
                AND FH.FORM_TYPE_ID       = &W_FORM_TYPE_ID
                AND FH.ENABLED_FLAG       = 'Y'
                AND FH.EFFECTIVE_DATE_FR  <= LAST_DAY(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'))
                AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'))
              ORDER BY FH.ITEM_LEVEL DESC
            )
  LOOP
DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL || ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID);

    UPDATE FI_BALANCE_FS_GT BFG
      SET ( BFG.BEFORE_DR_AMOUNT
          , BFG.BEFORE_CR_AMOUNT
          , BFG.THIS_DR_AMOUNT
          , BFG.THIS_CR_AMOUNT
          , BFG.REMAIN_DR_AMOUNT
          , BFG.REMAIN_CR_AMOUNT
          ) =
          ( SELECT SUM(FBF.BEFORE_DR_AMOUNT) AS BEFORE_DR_AMOUNT
                , SUM(FBF.BEFORE_CR_AMOUNT) AS BEFORE_CR_AMOUNT
                , SUM(FBF.THIS_DR_AMOUNT) AS THIS_DR_AMOUNT
                , SUM(FBF.THIS_CR_AMOUNT) AS THIS_CR_AMOUNT
                , SUM(FBF.REMAIN_DR_AMOUNT) AS REMAIN_DR_AMOUNT
                , SUM(FBF.REMAIN_CR_AMOUNT) AS REMAIN_CR_AMOUNT
              FROM FI_BALANCE_FS_GT FBF
            WHERE FBF.HEADER_ID     = BFG.LINE_HEADER_ID
          )
    WHERE BFG.HEADER_ID             = C1.FORM_HEADER_ID 
    ;
  END LOOP C1;

  
END;
*/


SELECT CASE
         WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FG.ITEM_LEVEL, 1, FG.REMAIN_DR_AMOUNT, 0))
         ELSE SUM(FG.REMAIN_DR_AMOUNT)
       END AS REMAIN_DR_AMOUNT
     , CASE
         WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FG.ITEM_LEVEL, 1, FG.THIS_DR_AMOUNT, 0))
         ELSE SUM(FG.THIS_DR_AMOUNT) 
       END AS THIS_DR_AMOUNT
     , CASE
         WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FG.ITEM_LEVEL, 1, FG.BEFORE_DR_AMOUNT, 0))
         ELSE SUM(FG.BEFORE_DR_AMOUNT) 
       END AS BEFORE_DR_AMOUNT           
     , FH.FORM_ITEM_CODE
     , DECODE(GROUPING(FH.FORM_ITEM_CODE), 1, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL), FH.FORM_ITEM_NAME) AS FORM_ITEM_NAME
     , FH.SORT_SEQ
     , CASE
         WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FG.ITEM_LEVEL, 1, FG.BEFORE_CR_AMOUNT, 0))
         ELSE SUM(FG.BEFORE_CR_AMOUNT) 
       END AS BEFORE_CR_AMOUNT
     , CASE
         WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FG.ITEM_LEVEL, 1, FG.THIS_CR_AMOUNT, 0))
         ELSE SUM(FG.THIS_CR_AMOUNT) 
       END AS THIS_CR_AMOUNT 
     , CASE
         WHEN GROUPING(FH.FORM_ITEM_CODE) = 1 THEN SUM(DECODE(FG.ITEM_LEVEL, 1, FG.REMAIN_CR_AMOUNT, 0))
         ELSE SUM(FG.REMAIN_CR_AMOUNT) 
       END AS REMAIN_CR_AMOUNT     
  FROM FI_FORM_HEADER FH
    , FI_BALANCE_FS_GT FG
WHERE FG.HEADER_ID                = FH.FORM_HEADER_ID
  AND FG.SOB_ID                   = FH.SOB_ID
  AND FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
  AND FH.SOB_ID                   = &W_SOB_ID
  AND FH.DISPLAY_YN               = 'Y'
GROUP BY ROLLUP((FH.FORM_ITEM_CODE
     , FH.FORM_ITEM_NAME
     , FH.SORT_SEQ))
ORDER BY FH.SORT_SEQ  
;
