CREATE OR REPLACE PACKAGE FI_ASSET_DPR_HISOTRY_SET_G
AS
-- 감가상각 계산.
  PROCEDURE DEPRECIATION_SET
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- 감가상각 계산 취소.
  PROCEDURE DEPRECIATION_SET_CANCEL
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );
            
-- 내부회계 상각 계산.
  PROCEDURE INTERNAL_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- IFRS 상각 계산.
  PROCEDURE IFRS_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

---------------------------------------------------------------------------------------------------
-- 자산별 상각 계산.
  PROCEDURE DPR_SET
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

---------------------------------------------------------------------------------------------------
-- 자산별 자본적 지출 상각 계산.
  PROCEDURE DPR_CE_SET
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_CHARGE_DATE         IN DATE
            , P_CHARGE_CODE         IN VARCHAR2
            , P_CURR_AMOUNT         IN NUMBER
            , P_AMOUNT              IN NUMBER            
            , P_DPR_METHOD_TYPE     IN VARCHAR2
            , P_DPR_PROGRESS_YEAR   IN NUMBER
            , P_RESIDUAL_AMOUNT     IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );
            
-- 상각처리 INSERT.
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

-- 감가상각 계산.
  PROCEDURE DEPRECIATION_SET
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    -- 내부회계.
    FOR C1 IN ( SELECT ADH.PERIOD_NAME
                     , ADH.ASSET_ID
                     , ADH.DPR_AMOUNT
                     , ADH.DPR_SUM_AMOUNT
                     , ADH.DPR_SUM_CURR_AMOUNT
                     , ADH.UN_DPR_REMAIN_AMOUNT
                     , ADH.DPR_COUNT
                     , ADH.DPR_TYPE
                     , ADH.SOB_ID
                  FROM FI_ASSET_DPR_HISTORY ADH
                WHERE ADH.PERIOD_NAME             = P_PERIOD_NAME
                  AND ADH.SOB_ID                  = P_SOB_ID
                  AND ADH.ASSET_ID                = NVL(P_ASSET_ID, ADH.ASSET_ID)
                  AND ADH.DPR_TYPE                = '10'
                  AND ADH.ASSET_MASTER_YN         = 'N'
                  AND ADH.DPR_AMOUNT              <> 0
              )
    LOOP
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.ASSET_MASTER_YN   = 'Y'
          , ADH.LAST_UPDATE_DATE  = V_SYSDATE
          , ADH.LAST_UPDATED_BY   = P_USER_ID
      WHERE ADH.PERIOD_NAME       = C1.PERIOD_NAME
        AND ADH.ASSET_ID          = C1.ASSET_ID
        AND ADH.DPR_TYPE          = C1.DPR_TYPE
        AND ADH.SOB_ID            = C1.SOB_ID
      ;
      
      UPDATE FI_ASSET_MASTER AM
        SET AM.DPR_STATUS_CODE      = DECODE(C1.UN_DPR_REMAIN_AMOUNT, AM.RESIDUAL_AMOUNT, '90', '10')
          , AM.DPR_SUM_CURR_AMOUNT  = C1.DPR_SUM_CURR_AMOUNT
          , AM.DPR_SUM_AMOUNT       = C1.DPR_SUM_AMOUNT
          , AM.DPR_TOTAL_COUNT      = C1.DPR_COUNT
          , AM.DPR_LAST_PERIOD      = C1.PERIOD_NAME
      WHERE AM.ASSET_ID           = C1.ASSET_ID
        AND AM.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    
    -- IFRS 상각.
    FOR C1 IN ( SELECT ADH.PERIOD_NAME
                     , ADH.ASSET_ID
                     , ADH.DPR_AMOUNT
                     , ADH.DPR_SUM_AMOUNT
                     , ADH.DPR_SUM_CURR_AMOUNT
                     , ADH.UN_DPR_REMAIN_AMOUNT
                     , ADH.DPR_COUNT
                     , ADH.DPR_TYPE
                     , ADH.SOB_ID
                  FROM FI_ASSET_DPR_HISTORY ADH
                WHERE ADH.PERIOD_NAME             = P_PERIOD_NAME
                  AND ADH.SOB_ID                  = P_SOB_ID
                  AND ADH.ASSET_ID                = NVL(P_ASSET_ID, ADH.ASSET_ID)
                  AND ADH.DPR_TYPE                = '20'
                  AND ADH.ASSET_MASTER_YN         = 'N'
                  AND ADH.DPR_AMOUNT              <> 0
              )
    LOOP
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.ASSET_MASTER_YN   = 'Y'
          , ADH.LAST_UPDATE_DATE  = V_SYSDATE
          , ADH.LAST_UPDATED_BY   = P_USER_ID
      WHERE ADH.PERIOD_NAME       = C1.PERIOD_NAME
        AND ADH.ASSET_ID          = C1.ASSET_ID
        AND ADH.DPR_TYPE          = C1.DPR_TYPE
        AND ADH.SOB_ID            = C1.SOB_ID
      ;
      
      UPDATE FI_ASSET_MASTER AM
        SET AM.IFRS_DPR_STATUS_CODE      = DECODE(C1.UN_DPR_REMAIN_AMOUNT, AM.RESIDUAL_AMOUNT, '90', '10')
          , AM.IFRS_DPR_SUM_CURR_AMOUNT  = C1.DPR_SUM_CURR_AMOUNT
          , AM.IFRS_DPR_SUM_AMOUNT       = C1.DPR_SUM_AMOUNT
          , AM.IFRS_DPR_TOTAL_COUNT      = C1.DPR_COUNT
          , AM.IFRS_DPR_LAST_PERIOD      = C1.PERIOD_NAME          
      WHERE AM.ASSET_ID           = C1.ASSET_ID
        AND AM.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    
  END DEPRECIATION_SET;

-- 감가상각 계산 취소.
  PROCEDURE DEPRECIATION_SET_CANCEL
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    -- 내부회계.
    FOR C1 IN ( SELECT ADH.PERIOD_NAME
                     , ADH.ASSET_ID
                     , ADH.DPR_AMOUNT
                     , ADH.DPR_CURR_AMOUNT
                     , ADH.DPR_SUM_AMOUNT
                     , ADH.DPR_SUM_CURR_AMOUNT
                     , ADH.UN_DPR_REMAIN_AMOUNT
                     , ADH.DPR_COUNT
                     , ADH.DPR_TYPE
                     , ADH.SOB_ID
                  FROM FI_ASSET_DPR_HISTORY ADH
                WHERE ADH.PERIOD_NAME             = P_PERIOD_NAME
                  AND ADH.SOB_ID                  = P_SOB_ID
                  AND ADH.ASSET_ID                = NVL(P_ASSET_ID, ADH.ASSET_ID)
                  AND ADH.DPR_TYPE                = '10'
                  AND ADH.ASSET_MASTER_YN         = 'Y'
              )
    LOOP
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.ASSET_MASTER_YN   = 'N'
          , ADH.LAST_UPDATE_DATE  = V_SYSDATE
          , ADH.LAST_UPDATED_BY   = P_USER_ID
      WHERE ADH.PERIOD_NAME       = C1.PERIOD_NAME
        AND ADH.ASSET_ID          = C1.ASSET_ID
        AND ADH.DPR_TYPE          = C1.DPR_TYPE
        AND ADH.SOB_ID            = C1.SOB_ID
      ;
      
      UPDATE FI_ASSET_MASTER AM
        SET AM.DPR_STATUS_CODE      = DECODE(C1.UN_DPR_REMAIN_AMOUNT, AM.RESIDUAL_AMOUNT, '90', '10')
          , AM.DPR_SUM_CURR_AMOUNT  = NVL(C1.DPR_SUM_CURR_AMOUNT, 0) - NVL(C1.DPR_CURR_AMOUNT, 0)
          , AM.DPR_SUM_AMOUNT       = NVL(C1.DPR_SUM_AMOUNT, 0) - NVL(C1.DPR_AMOUNT, 0)
          , AM.DPR_TOTAL_COUNT      = NVL(C1.DPR_COUNT, 0) - 1
          , AM.DPR_LAST_PERIOD      = TO_CHAR(ADD_MONTHS(TO_DATE(C1.PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
      WHERE AM.ASSET_ID           = C1.ASSET_ID
        AND AM.SOB_ID             = C1.SOB_ID
      ;
    END LOOP C1;
    
    -- IFRS 상각.
    FOR C1 IN ( SELECT ADH.PERIOD_NAME
                     , ADH.ASSET_ID
                     , ADH.DPR_AMOUNT
                     , ADH.DPR_CURR_AMOUNT
                     , ADH.DPR_SUM_AMOUNT
                     , ADH.DPR_SUM_CURR_AMOUNT
                     , ADH.UN_DPR_REMAIN_AMOUNT
                     , ADH.DPR_COUNT
                     , ADH.DPR_TYPE
                     , ADH.SOB_ID
                  FROM FI_ASSET_DPR_HISTORY ADH
                WHERE ADH.PERIOD_NAME             = P_PERIOD_NAME
                  AND ADH.SOB_ID                  = P_SOB_ID
                  AND ADH.ASSET_ID                = NVL(P_ASSET_ID, ADH.ASSET_ID)
                  AND ADH.DPR_TYPE                = '20'
              )
    LOOP
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.ASSET_MASTER_YN   = 'N'
          , ADH.LAST_UPDATE_DATE  = V_SYSDATE
          , ADH.LAST_UPDATED_BY   = P_USER_ID
      WHERE ADH.PERIOD_NAME       = C1.PERIOD_NAME
        AND ADH.ASSET_ID          = C1.ASSET_ID
        AND ADH.DPR_TYPE          = C1.DPR_TYPE
        AND ADH.SOB_ID            = C1.SOB_ID
      ;
      
      UPDATE FI_ASSET_MASTER AM
        SET AM.IFRS_DPR_STATUS_CODE      = DECODE(C1.UN_DPR_REMAIN_AMOUNT, AM.RESIDUAL_AMOUNT, '90', '10')
          , AM.IFRS_DPR_SUM_CURR_AMOUNT  = NVL(C1.DPR_SUM_CURR_AMOUNT, 0) - NVL(C1.DPR_CURR_AMOUNT, 0)
          , AM.IFRS_DPR_SUM_AMOUNT       = NVL(C1.DPR_SUM_AMOUNT, 0) - NVL(C1.DPR_AMOUNT, 0)
          , AM.IFRS_DPR_TOTAL_COUNT      = NVL(C1.DPR_COUNT, 0) - 1
          , AM.IFRS_DPR_LAST_PERIOD      = TO_CHAR(ADD_MONTHS(TO_DATE(C1.PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM')
      WHERE AM.ASSET_ID           = C1.ASSET_ID
        AND AM.SOB_ID             = C1.SOB_ID
      ;      
    END LOOP C1;
  
  END DEPRECIATION_SET_CANCEL;
  
-- 내부회계 상각 계산.
  PROCEDURE INTERNAL_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- 상각년월.
    V_MONTH_COUNT                   NUMBER;         -- 월 순서.
    V_TOTAL_COUNT                   NUMBER;         -- 총횟수.
    V_YEAR                          VARCHAR2(4);    -- 년수.
    
    V_DPR_RATE                      NUMBER := 0;    -- 상각율.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- 상각 대상금액(외화).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- 상각 대상금액.
    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- 월 상각금액(외화).
    V_DPR_AMOUNT                    NUMBER := 0;    -- 월 상각금액.
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- 년 상각금액(외화).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- 년 상각금액.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- 월상각누계금액(외화).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- 월상각누계금액.    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- 상각누계금액(외화).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- 상각누계금액.
    
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
      V_MONTH_COUNT                   := 0;
      V_TOTAL_COUNT                   := 0;    -- 총월수.
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
      
      -- 감가상각 대상금액.
      V_SOURCE_CURR_AMOUNT := NVL(C1.CURR_AMOUNT, 0)  ;
      V_SOURCE_AMOUNT := NVL(C1.AMOUNT, 0);
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
      -- 상각율 계산 --
      IF C1.DPR_METHOD_TYPE = '1' THEN
      -- 정액. --          
        V_DPR_RATE := TRUNC(1 / NVL(C1.DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
      ELSE
      -- 정율. --
        -- 상각율 조회.
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
      -- 정액 : 상각금액 계산. --
        -- 년별 월 상각비 계산.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- 월상각누계금액(외화).
          V_MONTH_SUM_AMOUNT              := 0;    -- 월상각누계금액.

-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- 상각 첫 년도.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- 상각 마지막 년도.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
            END IF;
            V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- 그외 상각년도.
            V_MONTH_COUNT := 12;
             
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));            
          END IF;
          
-----------------------------------------------------------------------------------------------------------------------
          -- 월별 금액 산출.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);

          -- 해당월에 대한 LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
              
            -- 해당 년에 대한 월 상각액 누계.
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
              
            -- 총상각액 누계.
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
      -- 정율. --
        -- 년별 월 상각비 계산.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP          
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- 월상각누계금액(외화).
          V_MONTH_SUM_AMOUNT              := 0;    -- 월상각누계금액.
          
          V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_YEAR_CURR_AMOUNT, 0);
          V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_YEAR_AMOUNT, 0);
                    
-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- 상각 첫 년도.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
  
            -- 상각계산.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);            
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- 상각 마지막 년도.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            -- 상각계산.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));    
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_SOURCE_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));         
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- 그외 상각년도.
             V_MONTH_COUNT := 12;
             
             -- 상각계산.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
          END IF;
-----------------------------------------------------------------------------------------------------------------------          
          -- 월별 금액 산출.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);
            
          -- 해당월에 대한 LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
            
            -- 해당 년에 대한 월 상각액 누계.
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
              
            -- 총상각액 누계.
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

-- IFRS 상각 계산.
  PROCEDURE IFRS_SET
            ( P_ASSET_ID            IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- 상각년월.
    V_MONTH_COUNT                   NUMBER;         -- 년에 대한 월수.
    V_TOTAL_COUNT                   NUMBER;         -- 총횟수.
    V_YEAR                          VARCHAR2(4);    -- 년수.
    
    V_DPR_RATE                      NUMBER := 0;    -- 상각율.
    V_SOURCE_CURR_AMOUNT            NUMBER := 0;    -- 상각 대상금액(외화).
    V_SOURCE_AMOUNT                 NUMBER := 0;    -- 상각 대상금액.    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- 상각금액(외화).
    V_DPR_AMOUNT                    NUMBER := 0;    -- 상각금액.
    
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- 년 상각금액(외화).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- 년 상각금액.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- 월상각누계금액(외화).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- 월상각누계금액.
    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- 상각누계금액(외화).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- 상각누계금액.
    
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
      V_TOTAL_COUNT                   := 0;    -- 총월수.
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
      
      -- 감가상각 대상금액.
      V_SOURCE_CURR_AMOUNT := NVL(C1.CURR_AMOUNT, 0)  ;
      V_SOURCE_AMOUNT := NVL(C1.AMOUNT, 0);
      
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
      -- 상각율 계산 --
      IF C1.DPR_METHOD_TYPE = '1' THEN
      -- 정액. --          
        V_DPR_RATE := TRUNC(1 / NVL(C1.DPR_PROGRESS_YEAR, 0), 4);
      -----------------------------------------------------------------------
      ELSE
      -- 정율. --
        -- 상각율 조회.
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
      -- 정액 : 상각금액 계산. --
        -- 년별 월 상각비 계산.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- 월상각누계금액(외화).
          V_MONTH_SUM_AMOUNT              := 0;    -- 월상각누계금액.

-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- 상각 첫 년도.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);            
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- 상각 마지막 년도.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
            END IF;
            V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0);
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- 그외 상각년도.
             V_MONTH_COUNT := 12;
             
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));            
          END IF;          
-----------------------------------------------------------------------------------------------------------------------
          -- 월별 금액 산출.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);

          -- 해당월에 대한 LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
              
            -- 해당 년에 대한 월 상각액 누계.
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
              
            -- 총상각액 누계.
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
      -- 정율. --
        -- 년별 월 상각비 계산.
        FOR R1 IN 1 .. C1.DPR_PROGRESS_YEAR
        LOOP          
          V_YEAR := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, ((R1 - 1) * 12)), 'YYYY');
          V_MONTH_SUM_CURR_AMOUNT         := 0;    -- 월상각누계금액(외화).
          V_MONTH_SUM_AMOUNT              := 0;    -- 월상각누계금액.
          
          V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_YEAR_CURR_AMOUNT, 0);
          V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_YEAR_AMOUNT, 0);
                    
-----------------------------------------------------------------------------------------------------------------------
          IF R1 = 1 THEN
          -- 상각 첫 년도.            
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F(C1.ACQUIRE_DATE, TO_DATE(V_YEAR || '-12-31', 'YYYY-MM-DD'), 'CEIL');
  
            -- 상각계산.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(C1.RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
-----------------------------------------------------------------------------------------------------------------------
          ELSIF R1 = C1.DPR_PROGRESS_YEAR THEN
          -- 상각 마지막 년도.
            V_MONTH_COUNT := HRM_COMMON_DATE_G.PERIOD_MONTH_F( TRUNC(ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12)), 'YEAR')
                                                             , ADD_MONTHS(C1.ACQUIRE_DATE, (C1.DPR_PROGRESS_YEAR * 12))
                                                             , 'CEIL');
            
            -- 상각계산.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));    
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_SOURCE_AMOUNT, 0) - NVL(C1.RESIDUAL_AMOUNT, 0));         
-----------------------------------------------------------------------------------------------------------------------
          ELSE
          -- 그외 상각년도.
             V_MONTH_COUNT := 12;
             
             -- 상각계산.
            IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
              V_DPR_YEAR_CURR_AMOUNT := TRUNC(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE));        
            END IF;
            V_DPR_YEAR_AMOUNT := TRUNC(V_SOURCE_AMOUNT * (V_DPR_RATE));
          END IF;
-----------------------------------------------------------------------------------------------------------------------          
          -- 월별 금액 산출.
          IF V_DPR_YEAR_CURR_AMOUNT <> 0 THEN
            V_DPR_CURR_AMOUNT := TRUNC(V_DPR_YEAR_CURR_AMOUNT / V_MONTH_COUNT);
          END IF;
          V_DPR_AMOUNT := TRUNC(V_DPR_YEAR_AMOUNT / V_MONTH_COUNT);
            
          -- 해당월에 대한 LOOP.
          FOR R2 IN 0 .. V_MONTH_COUNT - 1
          LOOP
            V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
            V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(C1.ACQUIRE_DATE, V_TOTAL_COUNT - 1), 'YYYY-MM');
            
            -- 해당 년에 대한 월 상각액 누계.
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
              
            -- 총상각액 누계.
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
-- 자산별 상각 계산.
  PROCEDURE DPR_SET
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
    V_PERIOD_NAME                   VARCHAR2(7);    -- 상각년월.
    V_DPR_SEQ                       NUMBER;         -- 월 순서.
    
    V_YEAR                          NUMBER;
    V_DATE_FR                       DATE;
    V_DATE_TO                       DATE;
    
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
           
    V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, - 1), 'YYYY-MM');
    V_YEAR := TO_NUMBER(TO_CHAR(P_ACQUIRE_DATE, 'YYYY'));
    V_TOTAL_COUNT := P_DPR_PROGRESS_YEAR;
    IF TO_DATE(TO_CHAR(V_YEAR) || '-01-31', 'YYYY-MM-DD') < P_ACQUIRE_DATE THEN 
      V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
    END IF;
    
    -- 감가상각 대상금액.
    V_SOURCE_CURR_AMOUNT := NVL(P_CURR_AMOUNT, 0)  ;
    V_SOURCE_AMOUNT := NVL(P_AMOUNT, 0);
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- 상각율 계산 --
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- 정액. --          
      V_DPR_RATE := TRUNC(1 / NVL(P_DPR_PROGRESS_YEAR, 0), 4);
    ELSE
    -- 정율. --
      -- 상각율 조회.
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
-- 정율 계산 : 
-- 정액 계산 : 
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
---------------------------------------------------------------------------------------------------
      -- 년상각액 계산.
      IF P_DPR_METHOD_TYPE = '2' THEN
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
        V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));        
      END IF;
---------------------------------------------------------------------------------------------------
      -- 해당 년도에 대한 월수.
      V_DATE_FR := TO_DATE(TO_CHAR(V_YEAR) || '-01-01', 'YYYY-MM-DD');
      IF V_DATE_FR < TRUNC(P_ACQUIRE_DATE, 'MONTH') THEN
        V_DATE_FR := TRUNC(P_ACQUIRE_DATE, 'MONTH');
      END IF;      
      V_DATE_TO := TO_DATE(TO_CHAR(V_YEAR) || '-12-31', 'YYYY-MM-DD');
      IF ADD_MONTHS(TRUNC(P_ACQUIRE_DATE, 'MONTH') - 1, P_DPR_PROGRESS_YEAR * 12) < V_DATE_TO THEN
        V_DATE_TO := ADD_MONTHS(TRUNC(P_ACQUIRE_DATE, 'MONTH') - 1, P_DPR_PROGRESS_YEAR * 12);
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
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        END IF;
        IF NVL(V_SOURCE_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        END IF;
        
        IF P_DPR_METHOD_TYPE = '1' THEN
        -- 잔여금액만 상각함.
          IF NVL(P_CURR_AMOUNT, 0) <> 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0);
          END IF;
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0);
        END IF;        
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
        
        -- 처리내역 저장.
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
                , P_DPR_COUNT => V_DPR_SEQ
                , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(P_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(P_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                , P_USER_ID => P_USER_ID
                );
                /*
DBMS_OUTPUT.PUT_LINE('C1 : ' || C1 || ', R1 : ' || R1 || ', PERIOD_NAME : ' || V_PERIOD_NAME || ', V_DPR_SEQ : ' || TO_CHAR(V_DPR_SEQ)
                    || ', V_SOURCE_AMOUNT : ' || TO_CHAR(V_SOURCE_AMOUNT) || ', V_DPR_YEAR_AMOUNT : ' || TO_CHAR(V_DPR_YEAR_AMOUNT)
                    || ', V_DPR_AMOUNT : ' || V_DPR_AMOUNT || ', V_DPR_SUM_AMOUNT : ' || V_DPR_SUM_AMOUNT);        
*/
      END LOOP R1;      

      IF P_DPR_METHOD_TYPE = '2' THEN
      -- 상각 금액 제외.
        IF NVL(P_CURR_AMOUNT, 0) <> 0 THEN
          V_SOURCE_CURR_AMOUNT := NVL(P_CURR_AMOUNT, 0) - V_DPR_SUM_CURR_AMOUNT;
        END IF;
        V_SOURCE_AMOUNT := NVL(P_AMOUNT, 0) - V_DPR_SUM_AMOUNT;
      END IF;
      V_YEAR := V_YEAR + 1;
    END LOOP C1;
  END DPR_SET;

---------------------------------------------------------------------------------------------------
-- 자산별 자본적 지출 / 자산 매각 : 상각 계산.
  PROCEDURE DPR_CE_SET
            ( P_ASSET_ID            IN NUMBER
            , P_ASSET_CATEGORY_ID   IN NUMBER
            , P_DPR_TYPE            IN VARCHAR2
            , P_CHARGE_DATE         IN DATE
            , P_CHARGE_CODE         IN VARCHAR2
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
    V_PERIOD_NAME                   VARCHAR2(7);    -- 상각년월.
    V_DPR_SEQ                       NUMBER;         -- 월 순서.
    
    V_YEAR                          NUMBER;
    V_DATE_FR                       DATE;
    V_DATE_TO                       DATE;
    V_ACQUIRE_DATE                  DATE;           -- 취득일자.
    V_LAST_DATE                     DATE;           -- 상각 종료일자.
        
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
    
    V_P_TOTAL_COUNT                 NUMBER := 0;    -- 이미 처리된 년수.
    V_P_DPR_CURR_AMOUNT             NUMBER := 0;    -- 이미 처리된 감가비(외화).
    V_P_DPR_AMOUNT                  NUMBER := 0;    -- 이미 처리된 감가비.
    
    V_ADD_CURR_AMOUNT               NUMBER := 0;    -- 자본적지출금액.
    V_ADD_AMOUNT                    NUMBER := 0;    -- 자본적지출금액.
    V_TOTAL_CURR_AMOUNT             NUMBER := 0;    -- 총상각대상금액.
    V_TOTAL_AMOUNT                  NUMBER := 0;    -- 총상각대상금액.
    
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
    
    V_P_TOTAL_COUNT                 := 0;    -- 이미 처리된 년수.
    V_P_DPR_CURR_AMOUNT             := 0;    -- 이미 처리된 감가비(외화).
    V_P_DPR_AMOUNT                  := 0;    -- 이미 처리된 감가비.
    
    V_ADD_CURR_AMOUNT               := 0;    -- 자본적지출금액.
    V_ADD_AMOUNT                    := 0;    -- 자본적지출금액.
    V_TOTAL_CURR_AMOUNT             := 0;    -- 총상각대상금액.
    V_TOTAL_AMOUNT                  := 0;    -- 총상각대상금액.
    
    V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_CHARGE_DATE, - 1), 'YYYY-MM');
    V_YEAR := TO_NUMBER(TO_CHAR(P_CHARGE_DATE, 'YYYY'));
    
    -- 취득일자 조회.
    BEGIN
      SELECT AM.ACQUIRE_DATE
           , AM.CURR_AMOUNT
           , AM.AMOUNT
        INTO V_ACQUIRE_DATE
          , V_TOTAL_CURR_AMOUNT
          , V_TOTAL_AMOUNT
        FROM FI_ASSET_MASTER AM
      WHERE AM.ASSET_ID                 = P_ASSET_ID
        AND AM.SOB_ID                   = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACQUIRE_DATE := P_CHARGE_DATE;
    END;
      
    -- 기처리된 년수 제외.
    BEGIN
      SELECT COUNT(DISTINCT SUBSTR(ADH.PERIOD_NAME, 1, 4)) AS YEAR_COUNT 
        INTO V_P_TOTAL_COUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
        AND ADH.PERIOD_NAME             <= TO_CHAR(V_YEAR - 1) || '-12'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_P_TOTAL_COUNT := 0;
    END;
    V_TOTAL_COUNT := P_DPR_PROGRESS_YEAR - NVL(V_P_TOTAL_COUNT, 0);
    IF TO_DATE(TO_CHAR(V_YEAR) || '-01-31', 'YYYY-MM-DD') < V_ACQUIRE_DATE THEN 
      V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
    END IF;
    
    -- 전년도말 미상각잔액 또는 취득가액, 감가 누계액 산출.
    BEGIN
      SELECT NVL(SUM(ADH.UN_DPR_REMAIN_CURR_AMOUNT), 0) AS UN_DPR_REMAIN_CURR_AMOUNT
          , NVL(SUM(ADH.UN_DPR_REMAIN_AMOUNT), -1) AS UN_DPR_REMAIN_AMOUNT
        INTO V_SOURCE_CURR_AMOUNT
          , V_SOURCE_AMOUNT          
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
        AND ADH.PERIOD_NAME             = TO_CHAR(V_YEAR - 1) || '-12'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SOURCE_CURR_AMOUNT := 0;
      V_SOURCE_AMOUNT := -1;
    END;    
    IF V_SOURCE_AMOUNT = -1 THEN
      BEGIN
        SELECT NVL(AM.CURR_AMOUNT, 0)
             , NVL(AM.AMOUNT, 0)
          INTO V_SOURCE_CURR_AMOUNT
            , V_SOURCE_AMOUNT
          FROM FI_ASSET_MASTER AM
        WHERE AM.ASSET_ID                 = P_ASSET_ID
          AND AM.SOB_ID                   = P_SOB_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_SOURCE_CURR_AMOUNT := 0;
        V_SOURCE_AMOUNT := 0;
      END;
    END IF;
    -- 당해년도 자본적 지출이 있을 경우 적용함.
    BEGIN
      SELECT NVL(SUM(CASE 
                       WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') >= TO_CHAR(P_CHARGE_DATE, 'YYYY') || '-01' 
                         AND TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') THEN AH.CURR_AMOUNT
                       ELSE 0
                     END), 0) AS CE_P_CURR_AMOUNT
           , NVL(SUM(CASE 
                       WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') >= TO_CHAR(P_CHARGE_DATE, 'YYYY') || '-01' 
                         AND TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') THEN AH.AMOUNT
                       ELSE 0
                     END), 0) AS CE_P_AMOUNT
        INTO V_ADD_CURR_AMOUNT
           , V_ADD_AMOUNT
        FROM FI_ASSET_HISTORY AH
      WHERE AH.ASSET_ID                 = P_ASSET_ID
        AND AH.SOB_ID                   = P_SOB_ID
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                       AND FC.COMMON_ID   = AH.CHARGE_ID
                       AND FC.SOB_ID      = P_SOB_ID
                       AND FC.CODE        = '10'
                   )
      GROUP BY AH.ASSET_ID
           , AH.SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- 당해년도 자산매각이 있을 경우 적용함.
    BEGIN
      SELECT V_ADD_CURR_AMOUNT - 
             NVL(SUM(CASE 
                       WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') >= TO_CHAR(P_CHARGE_DATE, 'YYYY') || '-01' 
                         AND TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') THEN AH.CURR_AMOUNT
                       ELSE 0
                     END), 0) AS CE_P_CURR_AMOUNT
           , V_ADD_AMOUNT - 
             NVL(SUM(CASE 
                       WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') >= TO_CHAR(P_CHARGE_DATE, 'YYYY') || '-01' 
                         AND TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') THEN AH.AMOUNT
                       ELSE 0
                     END), 0) AS CE_P_AMOUNT
        INTO V_ADD_CURR_AMOUNT
           , V_ADD_AMOUNT
        FROM FI_ASSET_HISTORY AH
      WHERE AH.ASSET_ID                 = P_ASSET_ID
        AND AH.SOB_ID                   = P_SOB_ID
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                       AND FC.COMMON_ID   = AH.CHARGE_ID
                       AND FC.SOB_ID      = P_SOB_ID
                       AND FC.CODE        IN('90', '91')
                   )
      GROUP BY AH.ASSET_ID
           , AH.SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- 이미 처리된 감가상각비 산출.
    BEGIN
      SELECT SUM(ADH.DPR_CURR_AMOUNT) AS DPR_CURR_AMOUNT
          , SUM(ADH.DPR_AMOUNT) AS DPR_AMOUNT
          , MAX(ADH.DPR_SUM_CURR_AMOUNT) AS DPR_SUM_CURR_AMOUNT
          , MAX(ADH.DPR_SUM_AMOUNT) AS DPR_SUM_AMOUNT
          , MAX(ADH.DPR_COUNT) AS DPR_SEQ
        INTO V_P_DPR_CURR_AMOUNT
          , V_P_DPR_AMOUNT
          , V_DPR_SUM_CURR_AMOUNT
          , V_DPR_SUM_AMOUNT
          , V_DPR_SEQ
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
        AND ADH.PERIOD_NAME             BETWEEN TO_CHAR(V_YEAR) || '-01' AND V_PERIOD_NAME
      ;
    EXCEPTION WHEN OTHERS THEN
      V_P_DPR_CURR_AMOUNT := 0;
      V_P_DPR_AMOUNT := 0;
      V_DPR_SUM_CURR_AMOUNT := 0;
      V_DPR_SUM_AMOUNT := 0;
      V_DPR_SEQ := 0;
    END;
    
    -- 최종상각년월.
    BEGIN
      SELECT TO_DATE(MAX(ADH.PERIOD_NAME), 'YYYY-MM') AS PERIOD_NAME
        INTO V_LAST_DATE
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LAST_DATE := ADD_MONTHS(TRUNC(P_CHARGE_DATE, 'MONTH') - 1, (NVL(P_DPR_PROGRESS_YEAR, 0) - NVL(V_P_TOTAL_COUNT, 0)) * 12);
    END;
        
    -- 취득가액 조회.
    V_TOTAL_CURR_AMOUNT := NVL(V_TOTAL_CURR_AMOUNT, 0) + NVL(V_ADD_CURR_AMOUNT, 0) + NVL(P_CURR_AMOUNT, 0);
    V_TOTAL_AMOUNT      := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0) + NVL(P_AMOUNT, 0);
    
    -- 매각일 경우 기처리된 내용은 적용하지 않음.
    IF P_CHARGE_CODE IN ('90', '91') THEN
      V_TOTAL_CURR_AMOUNT := NVL(V_TOTAL_CURR_AMOUNT, 0) + NVL(V_P_DPR_CURR_AMOUNT, 0);
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_P_DPR_AMOUNT, 0);
      
      V_P_DPR_CURR_AMOUNT := 0;
      V_P_DPR_AMOUNT := 0;
    END IF;
    
    -- 감가상각 대상금액(자본적 지출 금액 포함).
    V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) + NVL(V_ADD_CURR_AMOUNT, 0) + NVL(P_CURR_AMOUNT, 0);
    V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0) + NVL(P_AMOUNT, 0);
    
    -- 미상각잔액이 음수일 경우 감가 처리 안함 --
    IF V_SOURCE_AMOUNT < 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10185', NULL));
      RETURN;
    END IF;
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- 상각율 계산 --
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- 정액. --          
      V_DPR_RATE := TRUNC(1 / NVL(P_DPR_PROGRESS_YEAR, 0), 4);
-----------------------------------------------------------------------------------------------------------------------
    ELSE
    -- 정율. --
      -- 상각율 조회.
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
-- 정율 계산 : 
-- 정액 계산 : 
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
---------------------------------------------------------------------------------------------------
      -- 년상각액 계산.
      IF P_DPR_METHOD_TYPE = '2' THEN
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
        V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));        
      END IF;
---------------------------------------------------------------------------------------------------
      -- 해당 년도에 대한 월수.
      V_DATE_FR := TO_DATE(TO_CHAR(V_YEAR) || '-01-01', 'YYYY-MM-DD');
      IF V_DATE_FR < TRUNC(P_CHARGE_DATE, 'MONTH') THEN
        V_DATE_FR := TRUNC(P_CHARGE_DATE, 'MONTH');
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
      -- 년상각비 월할 계산(이미 처리된 상각비 제외).
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_P_DPR_CURR_AMOUNT, 0);
        END IF;
        V_DPR_YEAR_AMOUNT := NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_P_DPR_AMOUNT, 0);           
        
        IF P_CHARGE_CODE IN('90', '91') THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
        END IF;
      ELSIF C1 = V_TOTAL_COUNT THEN
      -- 년상각비 월할 계산.
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        END IF;
        V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        
        IF P_DPR_METHOD_TYPE = '1' THEN
        -- 잔여금액만 상각함.
          IF NVL(P_CURR_AMOUNT, 0) <> 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0);
          END IF;
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0);
        END IF;
        
      ELSE
        V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
        V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);     
      END IF;
---------------------------------------------------------------------------------------------------
      -- 월 상각비 계산.
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
        
        -- 처리내역 저장.
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
                , P_DPR_COUNT => V_DPR_SEQ
                , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
                , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
                , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
                , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
                , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(V_TOTAL_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
                , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(V_TOTAL_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
                , P_USER_ID => P_USER_ID
                );
                /*
DBMS_OUTPUT.PUT_LINE('C1 : ' || C1 || ', R1 : ' || R1 || ', PERIOD_NAME : ' || V_PERIOD_NAME || ', V_DPR_SEQ : ' || TO_CHAR(V_DPR_SEQ)
                    || ', V_SOURCE_AMOUNT : ' || TO_CHAR(V_SOURCE_AMOUNT) || ', V_DPR_YEAR_AMOUNT : ' || TO_CHAR(V_DPR_YEAR_AMOUNT)
                    || ', V_DPR_AMOUNT : ' || V_DPR_AMOUNT || ', V_DPR_SUM_AMOUNT : ' || V_DPR_SUM_AMOUNT);        
*/
      END LOOP R1;      

      IF P_DPR_METHOD_TYPE = '2' THEN
      -- 상각 금액 제외.
        IF NVL(P_CURR_AMOUNT, 0) <> 0 THEN
          V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) + NVL(V_P_DPR_CURR_AMOUNT, 0));
        END IF;
        V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - (NVL(V_DPR_YEAR_AMOUNT, 0) + NVL(V_P_DPR_AMOUNT, 0));
        
        V_P_DPR_CURR_AMOUNT := 0;
        V_P_DPR_AMOUNT := 0;
      END IF;
      V_YEAR := V_YEAR + 1;
    END LOOP C1;
  END DPR_CE_SET;
    
-- 상각처리 INSERT.
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
    -- 해당월 데이터 삭제후 INSERT.
    DELETE FROM FI_ASSET_DPR_HISTORY ADH
    WHERE ADH.PERIOD_NAME         >= P_PERIOD_NAME
      AND ADH.ASSET_ID            = P_ASSET_ID
      AND ADH.DPR_TYPE            = P_DPR_TYPE
      AND ADH.SOB_ID              = P_SOB_ID
    ;
  
    INSERT INTO FI_ASSET_DPR_HISTORY
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
