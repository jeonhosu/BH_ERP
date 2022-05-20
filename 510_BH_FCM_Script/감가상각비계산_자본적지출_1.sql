DECLARE
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.    
    V_YEAR                          NUMBER;
    V_DATE_FR                       DATE;
    V_DATE_TO                       DATE;
    V_LAST_DATE                     DATE;           -- �� ��������.
    V_MONTH_COUNT                   NUMBER;         -- ��Ƚ��.
    V_TOTAL_COUNT                   NUMBER;         -- ��Ƚ��.
    
    V_DPR_RATE                      NUMBER := 0;    -- ����.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- �� ���ݾ�(��ȭ).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- �� ���ݾ�.
    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    NUMBER := 0;    -- �� �󰢱ݾ�.
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- �� �󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- �� �󰢴���ݾ�.    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- �� �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- �� �󰢴���ݾ�.
    
    V_P_TOTAL_COUNT                 NUMBER := 0;    -- �̹� ó���� ���.
    V_P_DPR_CURR_AMOUNT             NUMBER := 0;    -- �̹� ó���� ������(��ȭ).
    V_P_DPR_AMOUNT                  NUMBER := 0;    -- �̹� ó���� ������.
  BEGIN  
    V_DPR_AMOUNT                    := 0;
    V_DPR_RATE                      := 0;      
    V_DPR_CURR_AMOUNT               := 0;    -- �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    := 0;    -- �󰢱ݾ�.
    V_DPR_YEAR_CURR_AMOUNT          := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               := 0;    -- �� �󰢱ݾ�.
    V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.
    V_DPR_SUM_CURR_AMOUNT           := 0;    -- �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                := 0;    -- �󰢴���ݾ�.
    
    V_P_TOTAL_COUNT                 := 0;    -- �̹� ó���� ���.
    V_P_DPR_CURR_AMOUNT             := 0;    -- �̹� ó���� ������(��ȭ).
    V_P_DPR_AMOUNT                  := 0;    -- �̹� ó���� ������.
    
    V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(&P_ACQUIRE_DATE, - 1), 'YYYY-MM');
    V_YEAR := TO_NUMBER(TO_CHAR(&P_ACQUIRE_DATE, 'YYYY'));
    -- ��ó���� ��� ����.
    BEGIN
      SELECT COUNT(DISTINCT SUBSTR(ADH.PERIOD_NAME, 1, 4)) AS YEAR_COUNT 
        INTO V_P_TOTAL_COUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = &P_ASSET_ID
        AND ADH.DPR_TYPE                = &P_DPR_TYPE
        AND ADH.SOB_ID                  = &P_SOB_ID
        AND ADH.PERIOD_NAME             <= TO_CHAR(V_YEAR - 1) || '-12'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_P_TOTAL_COUNT := 0;
    END;
    V_TOTAL_COUNT := &P_DPR_PROGRESS_YEAR - NVL(V_P_TOTAL_COUNT, 0);
    IF TO_DATE(TO_CHAR(V_YEAR) || '-01-31', 'YYYY-MM-DD') < &P_ACQUIRE_DATE THEN 
      V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
    END IF;
    
    -- ���⵵�� �̻��ܾ� �Ǵ� ��氡��, ���� ����� ����.
    BEGIN
      SELECT SUM(ADH.UN_DPR_REMAIN_CURR_AMOUNT) AS UN_DPR_REMAIN_CURR_AMOUNT
          , SUM(ADH.UN_DPR_REMAIN_AMOUNT) AS UN_DPR_REMAIN_AMOUNT
        INTO V_SOURCE_CURR_AMOUNT
          , V_SOURCE_AMOUNT          
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = &P_ASSET_ID
        AND ADH.DPR_TYPE                = &P_DPR_TYPE
        AND ADH.SOB_ID                  = &P_SOB_ID
        AND ADH.PERIOD_NAME             = TO_CHAR(V_YEAR - 1) || '-12'
      ;
    EXCEPTION WHEN OTHERS THEN
      BEGIN
        SELECT NVL(AM.CURR_AMOUNT, 0)
             , NVL(AM.AMOUNT, 0)
          INTO V_SOURCE_CURR_AMOUNT
            , V_SOURCE_AMOUNT
          FROM FI_ASSET_MASTER AM
        WHERE AM.ASSET_ID                 = &P_ASSET_ID
          AND AM.SOB_ID                   = &P_SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_SOURCE_CURR_AMOUNT := 0;
        V_SOURCE_AMOUNT := 0;
      END;
    END;
    
    -- �̹� ó���� �����󰢺� ����.
    BEGIN
      SELECT SUM(ADH.DPR_CURR_AMOUNT) AS DPR_CURR_AMOUNT
          , SUM(ADH.DPR_AMOUNT) AS DPR_AMOUNT
          , MAX(ADH.DPR_SUM_CURR_AMOUNT) AS DPR_SUM_CURR_AMOUNT
          , MAX(ADH.DPR_SUM_AMOUNT) AS DPR_SUM_AMOUNT
        INTO V_P_DPR_CURR_AMOUNT
          , V_P_DPR_AMOUNT
          , V_DPR_SUM_CURR_AMOUNT
          , V_DPR_SUM_AMOUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = &P_ASSET_ID
        AND ADH.DPR_TYPE                = &P_DPR_TYPE
        AND ADH.SOB_ID                  = &P_SOB_ID
        AND ADH.PERIOD_NAME             BETWEEN TO_CHAR(V_YEAR) || '-01' AND V_PERIOD_NAME
      ;
    EXCEPTION WHEN OTHERS THEN
      V_P_DPR_CURR_AMOUNT := 0;
      V_P_DPR_AMOUNT := 0;
      V_DPR_SUM_CURR_AMOUNT := 0;
      V_DPR_SUM_AMOUNT := 0;
    END;
    
    -- �����󰢳��.
    BEGIN
      SELECT TO_DATE(MAX(ADH.PERIOD_NAME), 'YYYY-MM') AS PERIOD_NAME
        INTO V_LAST_DATE
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = &P_ASSET_ID
        AND ADH.DPR_TYPE                = &P_DPR_TYPE
        AND ADH.SOB_ID                  = &P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LAST_DATE := ADD_MONTHS(TRUNC(&P_ACQUIRE_DATE, 'MONTH') - 1, (NVL(&P_DPR_PROGRESS_YEAR, 0) - NVL(V_P_TOTAL_COUNT, 0)) * 12);
    END;
    
    -- �ں��� ���� �ݾ�.
    V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) + NVL(&P_CURR_AMOUNT, 0);
    V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) + NVL(&P_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- ���� ��� --
    IF &P_DPR_METHOD_TYPE = '1' THEN
    -- ����. --          
      V_DPR_RATE := TRUNC(1 / NVL(&P_DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- ����. --
      -- ���� ��ȸ.
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
-- ���� ��� : 
-- ���� ��� : 
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
---------------------------------------------------------------------------------------------------
      -- ��󰢾� ���.
      IF &P_DPR_METHOD_TYPE = '2' THEN
      -- ������ --
        -- �󰢰��.
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
        END IF;
        V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
      ELSE 
      -- ���׹� --
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
        END IF;
        V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(&P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));        
      END IF;
---------------------------------------------------------------------------------------------------
      -- �ش� �⵵�� ���� ����.
      V_DATE_FR := TO_DATE(TO_CHAR(V_YEAR) || '-01-01', 'YYYY-MM-DD');
      IF V_DATE_FR < TRUNC(&P_ACQUIRE_DATE, 'MONTH') THEN
        V_DATE_FR := TRUNC(&P_ACQUIRE_DATE, 'MONTH');
      END IF;      
      V_DATE_TO := TO_DATE(TO_CHAR(V_YEAR) || '-12-31', 'YYYY-MM-DD');
      IF V_LAST_DATE < V_DATE_TO THEN
        V_DATE_TO := V_LAST_DATE;
      END IF;
      BEGIN
        SELECT TRUNC(MONTHS_BETWEEN(V_DATE_TO, V_DATE_FR)) + 1
          INTO V_MONTH_COUNT
          FROM DUAL; 
      EXCEPTION WHEN OTHERS THEN
        V_MONTH_COUNT := 12;
      END;
      IF C1 = 1 THEN
      -- ��󰢺� ���� ���(�̹� ó���� �󰢺� ����).
        V_DPR_YEAR_CURR_AMOUNT := NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_P_DPR_CURR_AMOUNT, 0);
        V_DPR_YEAR_AMOUNT := NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_P_DPR_AMOUNT, 0);           
      ELSIF C1 = V_TOTAL_COUNT THEN
      -- ��󰢺� ���� ���.
        V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(&P_RESIDUAL_AMOUNT, 0);
        V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(&P_RESIDUAL_AMOUNT, 0);
      ELSE
        V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
        V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);     
      END IF;
---------------------------------------------------------------------------------------------------
      -- �� �󰢺� ���.
      IF C1 = 1 THEN
        V_DPR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / V_MONTH_COUNT);
        V_DPR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / V_MONTH_COUNT);
      ELSE
        V_DPR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / V_MONTH_COUNT);
        V_DPR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / V_MONTH_COUNT);
      END IF;
      
      V_MONTH_SUM_CURR_AMOUNT := 0;
      V_MONTH_SUM_AMOUNT := 0;
      FOR R1 IN 1 .. V_MONTH_COUNT
      LOOP
        
        V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(TO_DATE(V_PERIOD_NAME, 'YYYY-MM'), 1), 'YYYY-MM');
        V_DPR_SEQ := V_DPR_SEQ + 1;
        
        V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
        V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
        
        -- �� ����� �� �󰢾� �� => ���� �߻��� ������ ���� �ݾ� ������.
        IF R1 = V_MONTH_COUNT AND V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
          V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
        END IF;
        IF R1 = V_MONTH_COUNT AND V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
          V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
        END IF;
        
---------------------------------------------------------------------------------------------------
        -- �󰢴����.
        V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
        V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
        
DBMS_OUTPUT.PUT_LINE('C1 : ' || C1 || ', R1 : ' || R1 || ', PERIOD_NAME : ' || V_PERIOD_NAME --|| ', V_DPR_SEQ : ' || TO_CHAR(V_DPR_SEQ)
                    || ', V_SOURCE_AMOUNT : ' || TO_CHAR(V_SOURCE_AMOUNT) || ', V_DPR_YEAR_AMOUNT : ' || TO_CHAR(V_DPR_YEAR_AMOUNT)
                    || ', V_DPR_AMOUNT : ' || V_DPR_AMOUNT || ', V_DPR_SUM_AMOUNT : ' || V_DPR_SUM_AMOUNT);        

      END LOOP R1;      

      IF &P_DPR_METHOD_TYPE = '2' THEN
      -- �� �ݾ� ����.
        IF NVL(&P_CURR_AMOUNT, 0) <> 0 THEN
          V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) + NVL(V_P_DPR_CURR_AMOUNT, 0));
        END IF;
        V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) -  (NVL(V_DPR_YEAR_AMOUNT, 0) + NVL(V_P_DPR_AMOUNT, 0));
        
        V_P_DPR_CURR_AMOUNT := 0;
        V_P_DPR_AMOUNT := 0;
      END IF;
      V_YEAR := V_YEAR + 1;
    END LOOP C1;
    
END;    
