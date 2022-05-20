CREATE OR REPLACE PACKAGE FI_ASSET_DPR_HISOTRY_SET_G
AS

  PROCEDURE DEPRECIATION_SET
            ( P_DPR_TYPE            IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- ����ȸ�� �� ���.
  PROCEDURE INTERNAL_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- IFRS �� ���.
  PROCEDURE IFRS_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

---------------------------------------------------------------------------------------------------
-- �ڻ꺰 ����ȸ�� �� ���.
  PROCEDURE ASSET_INTERNAL_SET
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_ACQUIRE_DATE        IN DATE
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- �ڻ꺰 IFRS �� ���.
  PROCEDURE ASSET_IFRS_SET
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_ACQUIRE_DATE        IN DATE
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- ��ó�� INSERT.
  PROCEDURE DPR_INSERT
            ( P_PERIOD_NAME             IN VARCHAR2
            , P_SOB_ID                  IN NUMBER
            , P_ORG_ID                  IN NUMBER
            , P_DPR_TYPE                IN VARCHAR2
            , P_ASSET_ID                IN NUMBER
            , P_ASSET_CATEGORY_ID       IN NUMBER            
            , P_SOURCE_CURR_AMOUNT      IN NUMBER
            , P_SOURCE_AMOUNT           IN NUMBER
            , P_SOURCE_ADD_CURR_AMOUNT  IN NUMBER
            , P_SOURCE_ADD_AMOUNT       IN NUMBER
            , P_DPR_METHOD_TYPE         IN VARCHAR2
            , P_DPR_PROGRESS_YEAR       IN NUMBER
            , P_DPR_RATE                IN NUMBER
            , P_DPR_CURR_AMOUNT         IN NUMBER
            , P_DPR_AMOUNT              IN NUMBER
            , P_DPR_COUNT               IN NUMBER
            , P_DPR_YEAR_CURR_AMOUNT    IN NUMBER
            , P_DPR_YEAR_AMOUNT         IN NUMBER
            , P_DPR_SUM_CURR_AMOUNT     IN NUMBER
            , P_DPR_SUM_AMOUNT          IN NUMBER
            , P_UN_DPR_REMAIN_CURR_AMOUNT IN NUMBER
            , P_UN_DPR_REMAIN_AMOUNT    IN NUMBER
            , P_USER_ID                 IN NUMBER
            );
            
END FI_ASSET_DPR_HISOTRY_SET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_DPR_HISOTRY_SET_G
AS

  PROCEDURE DEPRECIATION_SET
            ( P_DPR_TYPE            IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
  BEGIN
    IF P_DPR_TYPE = '2' THEN
      IFRS_SET( P_ASSET_ID
              , P_DPR_TYPE
              , P_SOB_ID
              , P_USER_ID
              );
    ELSE
      INTERNAL_SET( P_ASSET_ID
                  , P_DPR_TYPE
                  , P_SOB_ID
                  , P_USER_ID
                  );
    END IF;
    COMMIT;
    
  END DEPRECIATION_SET;

-- ����ȸ�� �� ���.
  PROCEDURE INTERNAL_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.
    V_MONTH_COUNT                   NUMBER;         -- �⿡ ���� ����.
    V_TOTAL_COUNT                   NUMBER;         -- ��Ƚ��.
    V_YEAR                          VARCHAR2(4);    -- ���.
    
    V_DPR_RATE                      NUMBER := 0;    -- ����.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- �� ���ݾ�(��ȭ).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- �� ���ݾ�.    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    NUMBER := 0;    -- �󰢱ݾ�.
    
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- ���󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- ���󰢴���ݾ�.
    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- �󰢴���ݾ�.
    
  BEGIN
    FOR C1 IN ( SELECT AM.ASSET_ID
                     , AM.ASSET_CODE
                     , AM.ASSET_DESC
                     , AM.SOB_ID
                     , AM.ORG_ID
                     , AM.ASSET_CATEGORY_ID
                     , AM.ACQUIRE_DATE
                     , AM.CURRENCY_CODE
                     , AM.CURR_AMOUNT
                     , AM.AMOUNT                     
                     , AM.DPR_METHOD_TYPE
                     , AM.DPR_PROGRESS_YEAR
                     , AM.RESIDUAL_AMOUNT
                  FROM FI_ASSET_MASTER AM
                WHERE AM.DPR_YN                 = 'Y'
                  AND AM.ASSET_ID               = NVL(P_ASSET_ID, AM.ASSET_ID)
                  AND AM.SOB_ID                 = P_SOB_ID
                  AND AM.DPR_TOTAL_COUNT        = 0
                  AND AM.ASSET_STATUS_CODE      = '10'
                )
    LOOP
      V_PERIOD_NAME                   := TO_CHAR(C1.ACQUIRE_DATE, 'YYYY-MM');
      V_TOTAL_COUNT                   := 0;    -- �ѿ���.
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
      
      -- ������ ���ݾ�.
      V_SOURCE_CURR_AMOUNT := NVL(C1.CURR_AMOUNT, 0)  ;
      V_SOURCE_AMOUNT := NVL(C1.AMOUNT, 0);
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
      -- ���� ��� --
      IF C1.DPR_METHOD_TYPE = '1' THEN
      -- ����. --          
        V_DPR_RATE := TRUNC(1 / NVL(C1.DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
      ELSE
      -- ����. --
        -- ���� ��ȸ.
        BEGIN
          SELECT DR.DPR_RATE
            INTO V_DPR_RATE
            FROM FI_DPR_RATE DR
          WHERE DR.DPR_TYPE       = P_DPR_TYPE
            AND DR.SOB_ID         = C1.SOB_ID
            AND DR.PROGRESS_YEAR  = C1.DPR_PROGRESS_YEAR
            AND ROWNUM            <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          V_DPR_RATE := 0;
        END;
      END IF;
      
-----------------------------------------------------------------------------------------------------------------------
      IF C1.DPR_METHOD_TYPE = '1' THEN
      -- ���� : �󰢱ݾ� ���. --
        -- �⺰ �� �󰢺� ���.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
          V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.

-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- �� ù �⵵.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- �� ������ �⵵.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
            END IF;
            V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- �׿� �󰢳⵵.
            V_MONTH_COUNT := 12;
             
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));            
          END IF;
          
-----------------------------------------------------------------------------------------------------------------------
          -- ���� �ݾ� ����.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);

          -- �ش���� ���� LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
              
            -- �ش� �⿡ ���� �� �󰢾� ����.
            V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
              
            IF R2 = V_MONTH_COUNT - 1 THEN
              IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
                V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
              END IF;
              IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
                V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
              END IF;
            END IF;
              
            -- �ѻ󰢾� ����.
            V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
                            
            DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
                      , P_SOB_ID => C1.SOB_ID
                      , P_ORG_ID => C1.ORG_ID
                      , P_DPR_TYPE => P_DPR_TYPE
                      , P_ASSET_ID => C1.ASSET_ID
                      , P_ASSET_CATEGORY_ID => C1.ASSET_CATEGORY_ID
                      , P_SOURCE_CURR_AMOUNT => V_SOURCE_CURR_AMOUNT
                      , P_SOURCE_AMOUNT => V_SOURCE_AMOUNT
                      , P_SOURCE_ADD_CURR_AMOUNT => 0
                      , P_SOURCE_ADD_AMOUNT => 0
                      , P_DPR_METHOD_TYPE => C1.DPR_METHOD_TYPE
                      , P_DPR_PROGRESS_YEAR => C1.DPR_PROGRESS_YEAR
                      , P_DPR_RATE => V_DPR_RATE
                      , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
                      , P_DPR_AMOUNT => V_DPR_AMOUNT
                      , P_DPR_COUNT => V_TOTAL_COUNT
                      , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                      , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                      , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                      , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                      , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                      , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                      , P_USER_ID => P_USER_ID
                      );
            
          END LOOP R2;
            
        END LOOP R1;
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
      ELSE
      -- ����. --
        -- �⺰ �� �󰢺� ���.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP          
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
          V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.
          
          V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_YEAR_CURR_AMOUNT, 0);
          V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_YEAR_AMOUNT, 0);
                    
-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- �� ù �⵵.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
  
            -- �󰢰��.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);            
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- �� ������ �⵵.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            -- �󰢰��.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));    
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_SOURCE_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));         
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- �׿� �󰢳⵵.
             V_MONTH_COUNT := 12;
             
             -- �󰢰��.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
          END IF;
-----------------------------------------------------------------------------------------------------------------------          
          -- ���� �ݾ� ����.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);
            
          -- �ش���� ���� LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
            
            -- �ش� �⿡ ���� �� �󰢾� ����.
            V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
            IF R2 = V_MONTH_COUNT - 1 THEN
              IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
                V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
              END IF;
              IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
                V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
              END IF;
            END IF;
              
            -- �ѻ󰢾� ����.
            V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
            DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
                      , P_SOB_ID => C1.SOB_ID
                      , P_ORG_ID => C1.ORG_ID
                      , P_DPR_TYPE => P_DPR_TYPE
                      , P_ASSET_ID => C1.ASSET_ID
                      , P_ASSET_CATEGORY_ID => C1.ASSET_CATEGORY_ID
                      , P_SOURCE_CURR_AMOUNT => V_SOURCE_CURR_AMOUNT
                      , P_SOURCE_AMOUNT => V_SOURCE_AMOUNT
                      , P_SOURCE_ADD_CURR_AMOUNT => 0
                      , P_SOURCE_ADD_AMOUNT => 0
                      , P_DPR_METHOD_TYPE => C1.DPR_METHOD_TYPE
                      , P_DPR_PROGRESS_YEAR => C1.DPR_PROGRESS_YEAR
                      , P_DPR_RATE => V_DPR_RATE
                      , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
                      , P_DPR_AMOUNT => V_DPR_AMOUNT
                      , P_DPR_COUNT => V_TOTAL_COUNT
                      , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                      , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                      , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                      , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                      , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(C1.CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                      , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(C1.AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                      , P_USER_ID => P_USER_ID
                      );
            
          END LOOP R2;
            
        END LOOP R1;
      END IF;
      DBMS_OUTPUT.PUT_LINE('ASSET_DESC : ' || C1.ASSET_DESC || ', DPR RATE : ' || V_DPR_RATE || ', DPR AMOUNT : ' || V_DPR_YEAR_AMOUNT);      
    END LOOP C1;
    
  END INTERNAL_SET;

-- IFRS �� ���.
  PROCEDURE IFRS_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.
    V_MONTH_COUNT                   NUMBER;         -- �⿡ ���� ����.
    V_TOTAL_COUNT                   NUMBER;         -- ��Ƚ��.
    V_YEAR                          VARCHAR2(4);    -- ���.
    
    V_DPR_RATE                      NUMBER := 0;    -- ����.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- �� ���ݾ�(��ȭ).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- �� ���ݾ�.    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    NUMBER := 0;    -- �󰢱ݾ�.
    
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- ���󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- ���󰢴���ݾ�.
    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- �󰢴���ݾ�.
    
  BEGIN
    FOR C1 IN ( SELECT AM.ASSET_ID
                     , AM.ASSET_CODE
                     , AM.ASSET_DESC
                     , AM.SOB_ID
                     , AM.ORG_ID
                     , AM.ASSET_CATEGORY_ID
                     , AM.ACQUIRE_DATE
                     , AM.CURRENCY_CODE
                     , AM.CURR_AMOUNT
                     , AM.AMOUNT                     
                     , AM.DPR_METHOD_TYPE
                     , AM.DPR_PROGRESS_YEAR
                     , AM.RESIDUAL_AMOUNT
                  FROM FI_ASSET_MASTER AM
                WHERE AM.DPR_YN                 = 'Y'
                  AND AM.ASSET_ID               = NVL(P_ASSET_ID, AM.ASSET_ID)
                  AND AM.SOB_ID                 = P_SOB_ID
                  AND AM.DPR_TOTAL_COUNT        = 0
                  AND AM.ASSET_STATUS_CODE      = '10'
                )
    LOOP
      V_PERIOD_NAME                   := TO_CHAR(C1.ACQUIRE_DATE, 'YYYY-MM');
      V_TOTAL_COUNT                   := 0;    -- �ѿ���.
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
      
      -- ������ ���ݾ�.
      V_SOURCE_CURR_AMOUNT := NVL(C1.CURR_AMOUNT, 0)  ;
      V_SOURCE_AMOUNT := NVL(C1.AMOUNT, 0);
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
      -- ���� ��� --
      IF C1.DPR_METHOD_TYPE = '1' THEN
      -- ����. --          
        V_DPR_RATE := TRUNC(1 / NVL(C1.DPR_PROGRESS_YEAR, 0), 4);
      -----------------------------------------------------------------------
      ELSE
      -- ����. --
        -- ���� ��ȸ.
        BEGIN
          SELECT DR.DPR_RATE
            INTO V_DPR_RATE
            FROM FI_DPR_RATE DR
          WHERE DR.DPR_TYPE       = P_DPR_TYPE
            AND DR.SOB_ID         = C1.SOB_ID
            AND DR.PROGRESS_YEAR  = C1.DPR_PROGRESS_YEAR
            AND ROWNUM            <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          V_DPR_RATE := 0;
        END;
      END IF;
      
      -----------------------------------------------------------------------
      IF C1.DPR_METHOD_TYPE = '1' THEN
      -- ���� : �󰢱ݾ� ���. --
        -- �⺰ �� �󰢺� ���.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
          V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.

-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- �� ù �⵵.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);            
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- �� ������ �⵵.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
            END IF;
            V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- �׿� �󰢳⵵.
             V_MONTH_COUNT := 12;
             
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));            
          END IF;          
-----------------------------------------------------------------------------------------------------------------------
          -- ���� �ݾ� ����.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);

          -- �ش���� ���� LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
              
            -- �ش� �⿡ ���� �� �󰢾� ����.
            V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
              
            IF R2 = V_MONTH_COUNT - 1 THEN
              IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
                V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
              END IF;
              IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
                V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
              END IF;
            END IF;
              
            -- �ѻ󰢾� ����.
            V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
                            
            DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
                      , P_SOB_ID => C1.SOB_ID
                      , P_ORG_ID => C1.ORG_ID
                      , P_DPR_TYPE => P_DPR_TYPE
                      , P_ASSET_ID => C1.ASSET_ID
                      , P_ASSET_CATEGORY_ID => C1.ASSET_CATEGORY_ID
                      , P_SOURCE_CURR_AMOUNT => V_SOURCE_CURR_AMOUNT
                      , P_SOURCE_AMOUNT => V_SOURCE_AMOUNT
                      , P_SOURCE_ADD_CURR_AMOUNT => 0
                      , P_SOURCE_ADD_AMOUNT => 0
                      , P_DPR_METHOD_TYPE => C1.DPR_METHOD_TYPE
                      , P_DPR_PROGRESS_YEAR => C1.DPR_PROGRESS_YEAR
                      , P_DPR_RATE => V_DPR_RATE
                      , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
                      , P_DPR_AMOUNT => V_DPR_AMOUNT
                      , P_DPR_COUNT => V_TOTAL_COUNT
                      , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                      , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                      , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                      , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                      , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                      , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                      , P_USER_ID => P_USER_ID
                      );
            
          END LOOP R2;
            
        END LOOP R1;
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
      ELSE
      -- ����. --
        -- �⺰ �� �󰢺� ���.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP          
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
          V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.
          
          V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_YEAR_CURR_AMOUNT, 0);
          V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_YEAR_AMOUNT, 0);
                    
-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- �� ù �⵵.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
  
            -- �󰢰��.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- �� ������ �⵵.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            -- �󰢰��.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));    
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_SOURCE_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));         
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- �׿� �󰢳⵵.
             V_MONTH_COUNT := 12;
             
             -- �󰢰��.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
          END IF;
-----------------------------------------------------------------------------------------------------------------------          
          -- ���� �ݾ� ����.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);
            
          -- �ش���� ���� LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
            
            -- �ش� �⿡ ���� �� �󰢾� ����.
            V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
            IF R2 = V_MONTH_COUNT - 1 THEN
              IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
                V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
              END IF;
              IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
                V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
              END IF;
            END IF;
              
            -- �ѻ󰢾� ����.
            V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
            V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
            DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
                      , P_SOB_ID => C1.SOB_ID
                      , P_ORG_ID => C1.ORG_ID
                      , P_DPR_TYPE => P_DPR_TYPE
                      , P_ASSET_ID => C1.ASSET_ID
                      , P_ASSET_CATEGORY_ID => C1.ASSET_CATEGORY_ID
                      , P_SOURCE_CURR_AMOUNT => V_SOURCE_CURR_AMOUNT
                      , P_SOURCE_AMOUNT => V_SOURCE_AMOUNT
                      , P_SOURCE_ADD_CURR_AMOUNT => 0
                      , P_SOURCE_ADD_AMOUNT => 0
                      , P_DPR_METHOD_TYPE => C1.DPR_METHOD_TYPE
                      , P_DPR_PROGRESS_YEAR => C1.DPR_PROGRESS_YEAR
                      , P_DPR_RATE => V_DPR_RATE
                      , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
                      , P_DPR_AMOUNT => V_DPR_AMOUNT
                      , P_DPR_COUNT => V_TOTAL_COUNT
                      , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                      , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                      , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                      , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                      , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(C1.CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                      , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(C1.AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                      , P_USER_ID => P_USER_ID
                      );
            
          END LOOP R2;
            
        END LOOP R1;
      END IF;
      DBMS_OUTPUT.PUT_LINE('ASSET_DESC : ' || C1.ASSET_DESC || ', DPR RATE : ' || V_DPR_RATE || ', DPR AMOUNT : ' || V_DPR_YEAR_AMOUNT);      
    END LOOP C1;
  
  END IFRS_SET;

---------------------------------------------------------------------------------------------------
-- �ڻ꺰 ����ȸ�� �� ���.
  PROCEDURE ASSET_INTERNAL_SET
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_ACQUIRE_DATE        IN DATE
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.
    V_MONTH_COUNT                   NUMBER;         -- �⿡ ���� ����.
    V_TOTAL_COUNT                   NUMBER;         -- ��Ƚ��.
    V_YEAR                          VARCHAR2(4);    -- ���.
    
    V_DPR_RATE                      NUMBER := 0;    -- ����.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- �� ���ݾ�(��ȭ).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- �� ���ݾ�.    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    NUMBER := 0;    -- �󰢱ݾ�.
    
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- ���󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- ���󰢴���ݾ�.
    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- �󰢴���ݾ�.
    
  BEGIN
    
    V_PERIOD_NAME                   := TO_CHAR(P_ACQUIRE_DATE, 'YYYY-MM');
    V_TOTAL_COUNT                   := 0;    -- �ѿ���.
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
      
    -- ������ ���ݾ�.
    V_SOURCE_CURR_AMOUNT := NVL(P_CURR_AMOUNT, 0)  ;
    V_SOURCE_AMOUNT := NVL(P_AMOUNT, 0);
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- ���� ��� --
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- ����. --          
      V_DPR_RATE := TRUNC(1 / NVL(P_DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- ����. --
      -- ���� ��ȸ.
      BEGIN
        SELECT DR.DPR_RATE
          INTO V_DPR_RATE
          FROM FI_DPR_RATE DR
        WHERE DR.DPR_TYPE       = P_DPR_TYPE
          AND DR.SOB_ID         = P_SOB_ID
          AND DR.PROGRESS_YEAR  = P_DPR_PROGRESS_YEAR
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DPR_RATE := 0;
      END;
    END IF;
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- ���� : �󰢱ݾ� ���. --
      -- �⺰ �� �󰢺� ���.
      FOR R1 IN 1 .. P_DPR_PROGRESS_YEAR
      LOOP
        V_YEAR := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
        V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
        V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.

-----------------------------------------------------------------------------------------------------------------------
        IF R1 = 1 THEN
        -- �� ù �⵵.            
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(P_ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
          
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
        ELSIF R1 = P_DPR_PROGRESS_YEAR THEN
        -- �� ������ �⵵.
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                           , ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12))
                                                           , 'CEIL');
            
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
          END IF;
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
        ELSE
        -- �׿� �󰢳⵵.
           V_MONTH_COUNT := 12;
             
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));            
        END IF;
          
-----------------------------------------------------------------------------------------------------------------------
        -- ���� �ݾ� ����.
        IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
          V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
        END IF;
        V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);

        -- �ش���� ���� LOOP.
        FOR R2 IN 0 .. V_MONTH_COUNT - 1
        LOOP
          V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
          V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
              
          -- �ش� �⿡ ���� �� �󰢾� ����.
          V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
              
          IF R2 = V_MONTH_COUNT - 1 THEN
            IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
              V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
            END IF;
            IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
              V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
            END IF;
          END IF;
              
          -- �ѻ󰢾� ����.
          V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
                            
          DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
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
                    , P_DPR_COUNT => V_TOTAL_COUNT
                    , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                    , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                    , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                    , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                    , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                    , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                    , P_USER_ID => P_USER_ID
                    );
            
        END LOOP R2;
            
      END LOOP R1;
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- ����. --
      -- �⺰ �� �󰢺� ���.
      FOR R1 IN 1 .. P_DPR_PROGRESS_YEAR
      LOOP          
        V_YEAR := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
        V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
        V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.
          
        V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_YEAR_CURR_AMOUNT, 0);
        V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_YEAR_AMOUNT, 0);
                    
-----------------------------------------------------------------------------------------------------------------------
        IF R1 = 1 THEN
        -- �� ù �⵵.            
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(P_ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
  
          -- �󰢰��.
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
        ELSIF R1 = P_DPR_PROGRESS_YEAR THEN
        -- �� ������ �⵵.
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                           , ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12))
                                                           , 'CEIL');
            
          -- �󰢰��.
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0));    
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_SOURCE_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0));         
-----------------------------------------------------------------------------------------------------------------------
        ELSE
        -- �׿� �󰢳⵵.
           V_MONTH_COUNT := 12;
             
           -- �󰢰��.
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
        END IF;
-----------------------------------------------------------------------------------------------------------------------          
        -- ���� �ݾ� ����.
        IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
          V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
        END IF;
        V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);
            
        -- �ش���� ���� LOOP.
        FOR R2 IN 0 .. V_MONTH_COUNT - 1
        LOOP
          V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
          V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
            
          -- �ش� �⿡ ���� �� �󰢾� ����.
          V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
          IF R2 = V_MONTH_COUNT - 1 THEN
            IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
              V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
            END IF;
            IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
              V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
            END IF;
          END IF;
              
          -- �ѻ󰢾� ����.
          V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
          DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
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
                    , P_DPR_COUNT => V_TOTAL_COUNT
                    , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                    , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                    , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                    , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                    , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(P_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                    , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(P_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                    , P_USER_ID => P_USER_ID
                    );
            
        END LOOP R2;
            
      END LOOP R1;
    END IF;
  
  END ASSET_INTERNAL_SET;

-- �ڻ꺰 IFRS �� ���.
  PROCEDURE ASSET_IFRS_SET
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_ACQUIRE_DATE        IN DATE
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.
    V_MONTH_COUNT                   NUMBER;         -- �⿡ ���� ����.
    V_TOTAL_COUNT                   NUMBER;         -- ��Ƚ��.
    V_YEAR                          VARCHAR2(4);    -- ���.
    
    V_DPR_RATE                      NUMBER := 0;    -- ����.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- �� ���ݾ�(��ȭ).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- �� ���ݾ�.    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    NUMBER := 0;    -- �󰢱ݾ�.
    
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- ���󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- ���󰢴���ݾ�.
    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- �󰢴���ݾ�.
    
  BEGIN
    
    V_PERIOD_NAME                   := TO_CHAR(P_ACQUIRE_DATE, 'YYYY-MM');
    V_TOTAL_COUNT                   := 0;    -- �ѿ���.
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
      
    -- ������ ���ݾ�.
    V_SOURCE_CURR_AMOUNT := NVL(P_CURR_AMOUNT, 0)  ;
    V_SOURCE_AMOUNT := NVL(P_AMOUNT, 0);
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- ���� ��� --
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- ����. --          
      V_DPR_RATE := TRUNC(1 / NVL(P_DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- ����. --
      -- ���� ��ȸ.
      BEGIN
        SELECT DR.DPR_RATE
          INTO V_DPR_RATE
          FROM FI_DPR_RATE DR
        WHERE DR.DPR_TYPE       = P_DPR_TYPE
          AND DR.SOB_ID         = P_SOB_ID
          AND DR.PROGRESS_YEAR  = P_DPR_PROGRESS_YEAR
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DPR_RATE := 0;
      END;
    END IF;
      
-----------------------------------------------------------------------------------------------------------------------
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- ���� : �󰢱ݾ� ���. --
      -- �⺰ �� �󰢺� ���.
      FOR R1 IN 1 .. P_DPR_PROGRESS_YEAR
      LOOP
        V_YEAR := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
        V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
        V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.

-----------------------------------------------------------------------------------------------------------------------
        IF R1 = 1 THEN
        -- �� ù �⵵.            
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(P_ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
          
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
        ELSIF R1 = P_DPR_PROGRESS_YEAR THEN
        -- �� ������ �⵵.
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                           , ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12))
                                                           , 'CEIL');
            
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
          END IF;
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
        ELSE
        -- �׿� �󰢳⵵.
           V_MONTH_COUNT := 12;
             
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));            
        END IF;
          
-----------------------------------------------------------------------------------------------------------------------
        -- ���� �ݾ� ����.
        IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
          V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
        END IF;
        V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);

        -- �ش���� ���� LOOP.
        FOR R2 IN 0 .. V_MONTH_COUNT - 1
        LOOP
          V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
          V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
              
          -- �ش� �⿡ ���� �� �󰢾� ����.
          V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
              
          IF R2 = V_MONTH_COUNT - 1 THEN
            IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
              V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
            END IF;
            IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
              V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
            END IF;
          END IF;
              
          -- �ѻ󰢾� ����.
          V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
                            
          DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
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
                    , P_DPR_COUNT => V_TOTAL_COUNT
                    , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                    , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                    , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                    , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                    , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                    , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                    , P_USER_ID => P_USER_ID
                    );
            
        END LOOP R2;
            
      END LOOP R1;
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- ����. --
      -- �⺰ �� �󰢺� ���.
      FOR R1 IN 1 .. P_DPR_PROGRESS_YEAR
      LOOP          
        V_YEAR := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
        V_MONTH_SUM_CURR_AMOUNT         := 0;    -- ���󰢴���ݾ�(��ȭ).
        V_MONTH_SUM_AMOUNT              := 0;    -- ���󰢴���ݾ�.
          
        V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_YEAR_CURR_AMOUNT, 0);
        V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_YEAR_AMOUNT, 0);
                    
-----------------------------------------------------------------------------------------------------------------------
        IF R1 = 1 THEN
        -- �� ù �⵵.            
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(P_ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
  
          -- �󰢰��.
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);          
-----------------------------------------------------------------------------------------------------------------------
        ELSIF R1 = P_DPR_PROGRESS_YEAR THEN
        -- �� ������ �⵵.
          V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                           , ADD_MONTHS(P_ACQUIRE_DATE, (P_DPR_PROGRESS_YEAR * 12))
                                                           , 'CEIL');

          -- �󰢰��.
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0));    
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_SOURCE_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0));         
-----------------------------------------------------------------------------------------------------------------------
        ELSE
        -- �׿� �󰢳⵵.
           V_MONTH_COUNT := 12;
             
           -- �󰢰��.
          IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
          END IF;
          V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
        END IF;

-----------------------------------------------------------------------------------------------------------------------          
        -- ���� �ݾ� ����.
        IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
          V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
        END IF;
        V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);
            
        -- �ش���� ���� LOOP.
        FOR R2 IN 0 .. V_MONTH_COUNT - 1
        LOOP
          V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
          V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
            
          -- �ش� �⿡ ���� �� �󰢾� ����.
          V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
          IF R2 = V_MONTH_COUNT - 1 THEN
            IF V_MONTH_SUM_CURR_AMOUNT <> V_DPR_YEAR_CURR_AMOUNT THEN
              V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
            END IF;
            IF V_MONTH_SUM_AMOUNT <> V_DPR_YEAR_AMOUNT THEN
              V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
            END IF;
          END IF;
              
          -- �ѻ󰢾� ����.
          V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
          V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
            
          DPR_INSERT( P_PERIOD_NAME => V_PERIOD_NAME
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
                    , P_DPR_COUNT => V_TOTAL_COUNT
                    , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                    , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                    , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                    , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                    , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(P_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                    , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(P_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                    , P_USER_ID => P_USER_ID
                    );
            
        END LOOP R2;
            
      END LOOP R1;
    END IF;

  END ASSET_IFRS_SET;

-- ��ó�� INSERT.
  PROCEDURE DPR_INSERT
            ( P_PERIOD_NAME             IN VARCHAR2
            , P_SOB_ID                  IN NUMBER
            , P_ORG_ID                  IN NUMBER
            , P_DPR_TYPE                IN VARCHAR2
            , P_ASSET_ID                IN NUMBER
            , P_ASSET_CATEGORY_ID       IN NUMBER            
            , P_SOURCE_CURR_AMOUNT      IN NUMBER
            , P_SOURCE_AMOUNT           IN NUMBER
            , P_SOURCE_ADD_CURR_AMOUNT  IN NUMBER
            , P_SOURCE_ADD_AMOUNT       IN NUMBER
            , P_DPR_METHOD_TYPE         IN VARCHAR2
            , P_DPR_PROGRESS_YEAR       IN NUMBER
            , P_DPR_RATE                IN NUMBER
            , P_DPR_CURR_AMOUNT         IN NUMBER
            , P_DPR_AMOUNT              IN NUMBER
            , P_DPR_COUNT               IN NUMBER
            , P_DPR_YEAR_CURR_AMOUNT    IN NUMBER
            , P_DPR_YEAR_AMOUNT         IN NUMBER
            , P_DPR_SUM_CURR_AMOUNT     IN NUMBER
            , P_DPR_SUM_AMOUNT          IN NUMBER
            , P_UN_DPR_REMAIN_CURR_AMOUNT IN NUMBER
            , P_UN_DPR_REMAIN_AMOUNT    IN NUMBER
            , P_USER_ID                 IN NUMBER
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    -- �ش�� ������ ������ INSERT.
    DELETE FROM FI_ASSET_DPR_HISOTRY ADH
    WHERE ADH.PERIOD_NAME         = P_PERIOD_NAME
      AND ADH.ASSET_ID            = P_ASSET_ID
      AND ADH.DPR_TYPE            = P_DPR_TYPE
      AND ADH.SOB_ID              = P_SOB_ID
    ;
  
    INSERT INTO FI_ASSET_DPR_HISOTRY
    ( PERIOD_NAME
    , SOB_ID
    , ORG_ID
    , DPR_TYPE
    , ASSET_ID
    , ASSET_CATEGORY_ID
    , SOURCE_CURR_AMOUNT
    , SOURCE_AMOUNT
    , SOURCE_ADD_CURR_AMOUNT
    , SOURCE_ADD_AMOUNT
    , DPR_METHOD_TYPE
    , DPR_PROGRESS_YEAR
    , DPR_RATE     
    , DPR_CURR_AMOUNT
    , DPR_AMOUNT
    , DPR_COUNT
    , DPR_YEAR_CURR_AMOUNT
    , DPR_YEAR_AMOUNT
    , DPR_SUM_CURR_AMOUNT
    , DPR_SUM_AMOUNT
    , UN_DPR_REMAIN_CURR_AMOUNT
    , UN_DPR_REMAIN_AMOUNT
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY    
    ) VALUES
    ( P_PERIOD_NAME
    , P_SOB_ID
    , P_ORG_ID
    , P_DPR_TYPE
    , P_ASSET_ID
    , P_ASSET_CATEGORY_ID
    , P_SOURCE_CURR_AMOUNT
    , P_SOURCE_AMOUNT
    , P_SOURCE_ADD_CURR_AMOUNT
    , P_SOURCE_ADD_AMOUNT
    , P_DPR_METHOD_TYPE
    , P_DPR_PROGRESS_YEAR
    , P_DPR_RATE     
    , P_DPR_CURR_AMOUNT
    , P_DPR_AMOUNT
    , P_DPR_COUNT
    , P_DPR_YEAR_CURR_AMOUNT
    , P_DPR_YEAR_AMOUNT
    , P_DPR_SUM_CURR_AMOUNT
    , P_DPR_SUM_AMOUNT
    , P_UN_DPR_REMAIN_CURR_AMOUNT
    , P_UN_DPR_REMAIN_AMOUNT
    , V_SYSDATE
    , P_USER_ID 
    , V_SYSDATE
    , P_USER_ID
    );
  
  END DPR_INSERT;
  
END FI_ASSET_DPR_HISOTRY_SET_G;
/
