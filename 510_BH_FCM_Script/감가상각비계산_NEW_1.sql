DECLARE
    V_PERIOD_NAME                   VARCHAR2(7);    -- 상각년월.
    V_YEAR                          NUMBER;
    V_DATE_FR                       DATE;
    V_DATE_TO                       DATE;
    V_DPR_SEQ                       NUMBER;         -- 월 순서.
    V_MONTH_COUNT                   NUMBER;         -- 월횟수.
    V_TOTAL_COUNT                   NUMBER;         -- 총횟수.
    
    V_DPR_RATE                      NUMBER := 0;    -- 상각율.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- 상각 대상금액(외화).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- 상각 대상금액.
    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- 월 상각금액(외화).
    V_DPR_AMOUNT                    NUMBER := 0;    -- 월 상각금액.
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- 년 상각금액(외화).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- 년 상각금액.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- 월 상각누계금액(외화).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- 월 상각누계금액.    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- 총 상각누계금액(외화).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- 총 상각누계금액.
        
  BEGIN  
    V_DPR_SEQ                       := 0;
    V_DPR_AMOUNT                    := 0;
    V_DPR_RATE                      := 0;      
    V_DPR_CURR_AMOUNT               := 0;    -- 상각금액(외화).
    V_DPR_AMOUNT                    := 0;    -- 상각금액.
    V_DPR_YEAR_CURR_AMOUNT          := 0;    -- 년 상각금액(외화).
    V_DPR_YEAR_AMOUNT               := 0;    -- 년 상각금액.
    V_MONTH_SUM_CURR_AMOUNT         := 0;    -- 월상각누계금액(외화).
    V_MONTH_SUM_AMOUNT              := 0;    -- 월상각누계금액.
    V_DPR_SUM_CURR_AMOUNT           := 0;    -- 상각누계금액(외화).
    V_DPR_SUM_AMOUNT                := 0;    -- 상각누계금액.
           
    V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), - 1), 'YYYY-MM');
    V_YEAR := TO_NUMBER(TO_CHAR(&P_ACQUIRE_DATE, 'YYYY'));
    V_TOTAL_COUNT := &P_DPR_PROGRESS_YEAR;
    IF TO_DATE(TO_CHAR(V_YEAR) || '-01-31', 'YYYY-MM-DD') < &P_ACQUIRE_DATE THEN 
      V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
    END IF;
    
    -- 감가상각 대상금액.
    V_SOURCE_CURR_AMOUNT := NVL(&P_CURR_AMOUNT, 0)  ;
    V_SOURCE_AMOUNT := NVL(&P_AMOUNT, 0);
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- 상각율 계산 --
    IF &P_DPR_METHOD_TYPE = '1' THEN
    -- 정액. --          
      V_DPR_RATE := TRUNC(1 / NVL(&P_DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- 정율. --
      -- 상각율 조회.
      BEGIN
        SELECT DR.DPR_RATE
          INTO V_DPR_RATE
          FROM FI_DPR_RATE DR
        WHERE DR.DPR_TYPE       = &P_DPR_TYPE
          AND DR.SOB_ID         = &P_SOB_ID
          AND DR.PROGRESS_YEAR  = &P_DPR_PROGRESS_YEAR
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DPR_RATE := 0;
      END;
    END IF;
-----------------------------------------------------------------------------------------------------------------------
-- 정율 계산 : 
-- 정액 계산 : 
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
---------------------------------------------------------------------------------------------------
      -- 년상각액 계산.
      IF &P_DPR_METHOD_TYPE = '2' THEN
      -- 정율법 --
        -- 상각계산.
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
        END IF;
        V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
      ELSE 
      -- 정액법 --
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
        END IF;
        V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(&P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));        
      END IF;
---------------------------------------------------------------------------------------------------
      -- 해당 년도에 대한 월수.
      V_DATE_FR := TO_DATE(TO_CHAR(V_YEAR) || '-01-01', 'YYYY-MM-DD');
      IF V_DATE_FR < TRUNC(&P_ACQUIRE_DATE, 'MONTH') THEN
        V_DATE_FR := TRUNC(&P_ACQUIRE_DATE, 'MONTH');
      END IF;      
      V_DATE_TO := TO_DATE(TO_CHAR(V_YEAR) || '-12-31', 'YYYY-MM-DD');
      IF ADD_MONTHS(TRUNC(&P_ACQUIRE_DATE, 'MONTH') - 1, &P_DPR_PROGRESS_YEAR * 12) < V_DATE_TO THEN
        V_DATE_TO := ADD_MONTHS(TRUNC(&P_ACQUIRE_DATE, 'MONTH') - 1, &P_DPR_PROGRESS_YEAR * 12);
      END IF;
      BEGIN
        SELECT TRUNC(MONTHS_BETWEEN(V_DATE_TO, V_DATE_FR)) + 1
          INTO V_MONTH_COUNT
          FROM DUAL; 
      EXCEPTION WHEN OTHERS THEN
        V_MONTH_COUNT := 12;
      END;
      -- 년상각비 월할 계산.
      V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
      V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);   
      IF C1 = V_TOTAL_COUNT THEN
        V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(&P_RESIDUAL_AMOUNT, 0);
        V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(&P_RESIDUAL_AMOUNT, 0);
      END IF;
---------------------------------------------------------------------------------------------------
      -- 월 상각비 계산.
      V_DPR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / V_MONTH_COUNT);
      V_DPR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / V_MONTH_COUNT);
      
      V_MONTH_SUM_CURR_AMOUNT := 0;
      V_MONTH_SUM_AMOUNT := 0;
      FOR R1 IN 1 .. V_MONTH_COUNT
      LOOP
        
        V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), 1), 'YYYY-MM');
        V_DPR_SEQ := V_DPR_SEQ + 1;
        
        V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
        V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
        
        -- 월 누계와 년 상각액 비교 => 차이 발생시 마지막 월에 금액 업해줌.
        IF R1 = V_MONTH_COUNT AND V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
          V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
        END IF;
        IF R1 = V_MONTH_COUNT AND V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
          V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
        END IF;
        
---------------------------------------------------------------------------------------------------
        -- 상각누계액.
        V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
        V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
        
DBMS_OUTPUT.PUT_LINE('C1 : ' || C1 || ', R1 : ' || R1 || ', PERIOD_NAME : ' || V_PERIOD_NAME || ', V_DPR_SEQ : ' || TO_CHAR(V_DPR_SEQ)
                    || ', V_SOURCE_AMOUNT : ' || TO_CHAR(V_SOURCE_AMOUNT) || ', V_DPR_YEAR_AMOUNT : ' || TO_CHAR(V_DPR_YEAR_AMOUNT)
                    || ', V_DPR_AMOUNT : ' || V_DPR_AMOUNT || ', V_DPR_SUM_AMOUNT : ' || V_DPR_SUM_AMOUNT);        

      END LOOP R1;      

      IF &P_DPR_METHOD_TYPE = '2' THEN
      -- 상각 금액 제외.
        IF NVL(&P_CURR_AMOUNT, 0) <> 0 THEN
          V_SOURCE_CURR_AMOUNT := NVL(&P_CURR_AMOUNT, 0) - V_DPR_SUM_CURR_AMOUNT;
        END IF;
        V_SOURCE_AMOUNT := NVL(&P_AMOUNT, 0) - V_DPR_SUM_AMOUNT;
      END IF;
      V_YEAR := V_YEAR + 1;
    END LOOP C1;
    
   /* 
    V_TOTAL_COUNT                   := &P_TOTAL_COUNT;
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
      V_MONTH_SEQ := V_MONTH_SEQ + 1;      
      V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(&P_ACQUIRE_DATE, C1 -1), 'YYYY-MM');
      
--/////////////////////////////////////////////////////////////////////////////////////////////////--
      -- 년상각액 계산.
      IF &P_DPR_METHOD_TYPE = '2' THEN
      -- 정율법 --
        -- 상각계산.
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
        END IF;
        V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
---------------------------------------------------------------------------------------------------
      ELSE 
      -- 정액법 --
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
        END IF;
        V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(&P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));        
      END IF;
--/////////////////////////////////////////////////////////////////////////////////////////////////--
      -- 월상각액 계산.
      IF NVL(V_DPR_YEAR_CURR_AMOUNT, 0) > 0 THEN
        V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / 12);
      END IF;
      V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / 12);
      
      V_MONTH_SUM_CURR_AMOUNT := V_MONTH_SUM_CURR_AMOUNT + V_DPR_CURR_AMOUNT;    -- 월상각누계금액(외화).
      V_MONTH_SUM_AMOUNT := V_MONTH_SUM_AMOUNT + V_DPR_AMOUNT;    -- 월상각누계금액.
      
      V_DPR_SUM_CURR_AMOUNT := V_DPR_SUM_CURR_AMOUNT + V_DPR_CURR_AMOUNT;
      V_DPR_SUM_AMOUNT := V_DPR_SUM_AMOUNT + V_DPR_AMOUNT;
      
--/////////////////////////////////////////////////////////////////////////////////////////////////--
      IF MOD(C1, 12) = 0 THEN
        IF V_DPR_YEAR_CURR_AMOUNT <> V_MONTH_SUM_CURR_AMOUNT THEN
        -- 년 상각액과 년 상각 누계액이 다를 경우 상각 금액, 상각 누계 가감.
          V_DPR_CURR_AMOUNT := V_DPR_CURR_AMOUNT + (V_DPR_YEAR_CURR_AMOUNT - V_MONTH_SUM_CURR_AMOUNT);
          V_DPR_SUM_CURR_AMOUNT := V_DPR_SUM_CURR_AMOUNT + (V_DPR_YEAR_CURR_AMOUNT - V_MONTH_SUM_CURR_AMOUNT);
        END IF;
        IF V_DPR_YEAR_AMOUNT <> V_MONTH_SUM_AMOUNT THEN
        -- 년 상각액과 년 상각 누계액이 다를 경우 상각 금액, 상각 누계 가감.
          V_DPR_AMOUNT := V_DPR_AMOUNT + (V_DPR_YEAR_AMOUNT - V_MONTH_SUM_AMOUNT);
          V_DPR_SUM_AMOUNT := V_DPR_SUM_AMOUNT + (V_DPR_YEAR_AMOUNT - V_MONTH_SUM_AMOUNT);
        END IF;
        V_MONTH_SUM_CURR_AMOUNT         := 0;    -- 월상각누계금액(외화).
        V_MONTH_SUM_AMOUNT              := 0;    -- 월상각누계금액.
      END IF;

      \*DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
                , P_SOB_ID => P_SOB_ID
                , P_ORG_ID => P_ORG_ID
                , P_DPR_TYPE => P_DPR_TYPE
                , P_ASSET_ID => P_ASSET_ID
                , P_ASSET_CATEGORY_ID => P_ASSET_CATEGORY_ID
                , P_SOURCE_CURR_AMOUNT => V_SOURCE_CURR_AMOUNT
                , P_SOURCE_AMOUNT => V_SOURCE_AMOUNT
                , P_SOURCE_ADD_CURR_AMOUNT => 0
                , P_SOURCE_ADD_AMOUNT => 0
                , P_DPR_METHOD_TYPE => P_DPR_METHOD_TYPE
                , P_DPR_PROGRESS_YEAR => P_DPR_PROGRESS_YEAR
                , P_DPR_RATE => V_DPR_RATE
                , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
                , P_DPR_AMOUNT => V_DPR_AMOUNT
                , P_DPR_COUNT => V_MONTH_SEQ
                , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(P_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(P_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                , P_USER_ID => P_USER_ID
                );*\

--/////////////////////////////////////////////////////////////////////////////////////////////////--
      IF MOD(C1, 12) = 0 THEN              
        IF &P_DPR_METHOD_TYPE = '2' THEN
        -- 상각 금액 제외.
          IF NVL(&P_CURR_AMOUNT, 0) <> 0 THEN
            V_SOURCE_CURR_AMOUNT := NVL(&P_CURR_AMOUNT, 0) - V_DPR_SUM_CURR_AMOUNT;
          END IF;
          V_SOURCE_AMOUNT := NVL(&P_AMOUNT, 0) - V_DPR_SUM_AMOUNT;
        END IF;        
      END IF;
      
    END LOOP C1;*/
    
    /*-- 미상각 잔액 존재시 최종년도에 일괄 배부 처리.
    IF NVL(P_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0) > NVL(V_DPR_SUM_AMOUNT, 0) THEN
      V_TOTAL_COUNT := MONTHS_BETWEEN(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), TRUNC(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), 'YEAR')) + 1;
      V_PERIOD_NAME := TO_CHAR(TRUNC(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), 'YEAR'), 'YYYY-MM');

      -- 년상각액.
      V_DPR_YEAR_AMOUNT := NVL(P_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0);
      -- 월상각액.
      V_DPR_AMOUNT := TRUNC((NVL(V_DPR_YEAR_AMOUNT, 0) / V_TOTAL_COUNT));

      V_MONTH_SUM_AMOUNT := 0;
      V_DPR_SUM_AMOUNT := 0;
      FOR C1 IN 1 .. V_TOTAL_COUNT
      LOOP
        V_MONTH_SUM_AMOUNT := V_MONTH_SUM_AMOUNT + V_DPR_AMOUNT;    -- 월상각누계금액.
        V_DPR_SUM_AMOUNT := V_DPR_SUM_AMOUNT + V_DPR_AMOUNT;        -- 상각누계금액.
      
        IF C1 = V_TOTAL_COUNT THEN       
          IF V_DPR_YEAR_AMOUNT <> V_MONTH_SUM_AMOUNT THEN          
          -- 년 상각액과 년 상각 누계액이 다를 경우 상각 금액, 상각 누계 가감.
            V_DPR_AMOUNT := V_DPR_AMOUNT + (V_DPR_YEAR_AMOUNT - V_MONTH_SUM_AMOUNT);
            V_DPR_SUM_AMOUNT := V_DPR_SUM_AMOUNT + (V_DPR_YEAR_AMOUNT - V_MONTH_SUM_AMOUNT);
          END IF;
        END IF;
        \*-- 상각액 UPDATE;
        UPDATE FI_ASSET_DPR_HISTORY ADH
          SET ADH.DPR_AMOUNT = NVL(ADH.DPR_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0)
            , ADH.DPR_YEAR_AMOUNT = NVL(ADH.DPR_YEAR_AMOUNT, 0) + NVL(V_DPR_YEAR_AMOUNT, 0)
            , ADH.DPR_SUM_AMOUNT  = NVL(ADH.DPR_SUM_AMOUNT, 0) + NVL(V_DPR_SUM_AMOUNT, 0)
            , ADH.UN_DPR_REMAIN_AMOUNT = NVL(ADH.UN_DPR_REMAIN_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0)
        WHERE ADH.ASSET_ID          = P_ASSET_ID
          AND ADH.SOB_ID            = P_SOB_ID
          AND ADH.PERIOD_NAME       = V_PERIOD_NAME
          AND ADH.DPR_TYPE          = P_DPR_TYPE
        ;*\
        
        V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), 1), 'YYYY-MM');
      END LOOP C1;
    END IF;*/
END;    
