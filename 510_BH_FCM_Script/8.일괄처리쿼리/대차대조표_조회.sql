DECLARE
    V_SYSDATE                     DATE   := GET_LOCAL_DATE(&W_SOB_ID);
    V_BASE_CURRENCY_CODE          VARCHAR2(10) := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(&W_SOB_ID);
    V_THIS_DATE_FR                DATE;
    V_THIS_DATE_TO                DATE;
    V_PREV_DATE_FR                DATE;
    V_PREV_DATE_TO                DATE;
    V_THIS_L_AMOUNT               NUMBER := 0;
    V_THIS_R_AMOUNT               NUMBER := 0;
    V_PREV_L_AMOUNT               NUMBER := 0;
    V_PREV_R_AMOUNT               NUMBER := 0;
    
  BEGIN
    V_THIS_DATE_FR := TO_DATE(&W_PERIOD_FR, 'YYYY-MM');
    V_THIS_DATE_TO := LAST_DAY(TO_DATE(&W_PERIOD_TO, 'YYYY-MM'));
    
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
         , &P_USER_ID
      FROM FI_FORM_HEADER FH
    WHERE FH.FORM_TYPE_ID             = &W_FORM_TYPE_ID
      AND FH.SOB_ID                   = &W_SOB_ID
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
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = &W_SOB_ID  
                  AND FH.LAST_LEVEL_YN      = 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)
                )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('HEADER ID : ' || C1.FORM_HEADER_ID);
      V_THIS_L_AMOUNT               := 0;
      V_THIS_R_AMOUNT               := 0;
      
      BEGIN
        SELECT SUM( CASE 
                      WHEN C1.ACCOUNT_DR_CR = '1' THEN ((NVL(FA.YEAR_DR_AMOUNT, 0) - NVL(FA.YEAR_CR_AMOUNT, 0)) 
                                                       + (NVL(FA.PERIOD_DR_AMOUNT, 0) - NVL(FA.PERIOD_CR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                      WHEN C1.ACCOUNT_DR_CR = '2' THEN ((NVL(FA.YEAR_CR_AMOUNT, 0) - NVL(FA.YEAR_DR_AMOUNT, 0))
                                                       + (NVL(FA.PERIOD_CR_AMOUNT, 0) - NVL(FA.PERIOD_DR_AMOUNT, 0))) * NVL(FFL.ITEM_SIGN, 1)
                    END
                   ) AS V_THIS_L_AMOUNT 
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
           AND FA.PERIOD_NAME           BETWEEN TO_CHAR(V_THIS_DATE_FR, 'YYYY-MM') AND TO_CHAR(V_THIS_DATE_TO, 'YYYY-MM')
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
    
    -- LEVEL 단위 ROLLUP.
    FOR C1 IN ( SELECT BB.SOB_ID
                     , BB.HEADER_ID AS FORM_HEADER_ID
                     , FH.ACCOUNT_DR_CR
                     , FH.ITEM_LEVEL
                  FROM FI_BALANCE_BS BB
                     , FI_FORM_HEADER FH
                WHERE BB.HEADER_ID          = FH.FORM_HEADER_ID
                  AND BB.SOB_ID             = &W_SOB_ID  
                  AND BB.LAST_LEVEL_YN      <> 'Y'
                  AND FH.ENABLED_FLAG       = 'Y'
                  AND FH.EFFECTIVE_DATE_FR  <= V_THIS_DATE_TO
                  AND (FH.EFFECTIVE_DATE_TO IS NULL OR FH.EFFECTIVE_DATE_TO >= V_THIS_DATE_FR)      
                ORDER BY BB.ITEM_LEVEL DESC, BB.SORT_SEQ DESC
              )
    LOOP
      --DBMS_OUTPUT.PUT_LINE('FORM_HEADER_ID : ' || C1.FORM_HEADER_ID || ', ITEM_LEVEL : ' || C1.ITEM_LEVEL /*|| ', LINE_CONTROL_ID : ' || C1.JOIN_LINE_CONTROL_ID*/);
      UPDATE FI_BALANCE_BS BB
        SET ( BB.THIS_L_AMOUNT
            ) =
            ( SELECT SUM(BB1.THIS_L_AMOUNT * FL.ITEM_SIGN) AS THIS_L_AMOUNT
                FROM FI_BALANCE_BS BB1
                  , FI_FORM_LINE FL
              WHERE BB1.HEADER_ID         = FL.JOIN_FORM_HEADER_ID
                AND FL.FORM_HEADER_ID     = C1.FORM_HEADER_ID
                AND FL.SOB_ID             = C1.SOB_ID
            )
      WHERE BB.HEADER_ID                  = C1.FORM_HEADER_ID 
      ;
    END LOOP C1;
  
  END;
