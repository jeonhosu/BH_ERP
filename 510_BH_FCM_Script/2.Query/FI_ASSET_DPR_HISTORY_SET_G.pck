CREATE OR REPLACE PACKAGE FI_ASSET_DPR_HISTORY_SET_G
AS

-- ������ ���.
  PROCEDURE DEPRECIATION_SET
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );

-- ������ ��� ���.
  PROCEDURE DEPRECIATION_SET_CANCEL
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            );
            
---------------------------------------------------------------------------------------------------
-- �ڻ꺰 �� ���.
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
            , P_NEW_SOURCE_AMOUNT   IN NUMBER DEFAULT 0
            );

---------------------------------------------------------------------------------------------------
-- �ڻ꺰 �ں��� ���� �� ���.
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

---------------------------------------------------------------------------------------------------
-- �ڻ꺰 �Ű�/��� �� ���.
  PROCEDURE DPR_SELL_OUT_SET
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
            , P_DPR_DC_AMOUNT       IN NUMBER
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
            
END FI_ASSET_DPR_HISTORY_SET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_DPR_HISTORY_SET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ASSET_DPR_HISTORY_SET_G
/* Description  : �����󰢺� ��� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- ������ �ݿ� ���.
  PROCEDURE DEPRECIATION_SET
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    -- ����ȸ��.
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
    
    -- IFRS ��.
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

-- ������ �ݿ� ��� ���.
  PROCEDURE DEPRECIATION_SET_CANCEL
            ( P_PERIOD_NAME         IN VARCHAR2
            , P_ASSET_ID            IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    -- ����ȸ��.
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
    
    -- IFRS ��.
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
  
---------------------------------------------------------------------------------------------------
-- �ڻ꺰 �� ���.
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
            , P_NEW_SOURCE_AMOUNT   IN NUMBER DEFAULT 0
            )
  AS
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.
    V_DPR_SEQ                       NUMBER;         -- �� ����.
    
    V_YEAR                          NUMBER;
    V_DATE_FR                       DATE;
    V_DATE_TO                       DATE;
    
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
  BEGIN
    V_DPR_SEQ                       := 0;
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
           
    V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, - 1), 'YYYY-MM');
    V_YEAR := TO_NUMBER(TO_CHAR(P_ACQUIRE_DATE, 'YYYY'));
    V_TOTAL_COUNT := P_DPR_PROGRESS_YEAR;
    IF TO_DATE(TO_CHAR(V_YEAR) || '-01-31', 'YYYY-MM-DD') < P_ACQUIRE_DATE THEN 
      V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
    END IF;
    
    -- ������ ���ݾ�.
    V_SOURCE_CURR_AMOUNT := NVL(P_CURR_AMOUNT, 0)  ;
    V_SOURCE_AMOUNT := NVL(P_AMOUNT, 0);
    
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- ���� ���� ��� --
    IF P_DPR_METHOD_TYPE = '1' THEN
    -- ����. --          
      V_DPR_RATE := TRUNC(1 / NVL(P_DPR_PROGRESS_YEAR, 0), 4);
    ELSE
    -- ����. --
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
    IF V_DPR_RATE = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10328', NULL));
      RETURN;
    END IF;
-----------------------------------------------------------------------------------------------------------------------
-- ���� ��� : 
-- ���� ��� : 
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
---------------------------------------------------------------------------------------------------
      -- ��󰢾� ���.
      IF P_DPR_METHOD_TYPE = '2' THEN
      -- ������ --
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := ROUND(V_SOURCE_CURR_AMOUNT * (V_DPR_RATE), 0);        
        END IF;
        V_DPR_YEAR_AMOUNT := ROUND((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * V_DPR_RATE, 0);
      ELSE 
      -- ���׹� --
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) > 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := ROUND(V_SOURCE_CURR_AMOUNT * V_DPR_RATE, 0);
        END IF;
        V_DPR_YEAR_AMOUNT := ROUND((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * V_DPR_RATE, 0);        
      END IF;
---------------------------------------------------------------------------------------------------
      -- �ش� �⵵�� ���� ����.
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
---------------------------------------------------------------------------------------------------
      -- ��󰢺� => ���� ���.
      V_DPR_YEAR_CURR_AMOUNT := ROUND((NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT), 0);
      V_DPR_YEAR_AMOUNT := ROUND((NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT), 0);   
      IF C1 = V_TOTAL_COUNT THEN
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        END IF;
        IF NVL(V_SOURCE_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        END IF;
        
        IF P_DPR_METHOD_TYPE = '1' THEN
        -- �ܿ��ݾ׸� ����.
          IF NVL(P_CURR_AMOUNT, 0) <> 0 THEN
            V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0);
          END IF;
          V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0);
        END IF;        
      END IF;
---------------------------------------------------------------------------------------------------
      -- �� �󰢺� ���.
      V_DPR_CURR_AMOUNT := ROUND(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / V_MONTH_COUNT, 0);
      V_DPR_AMOUNT := ROUND(NVL(V_DPR_YEAR_AMOUNT, 0) / V_MONTH_COUNT, 0);
      
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
        
       /*-- ���� ���ε��. ���� ���ε� �� ���� ���.
        IF P_DPR_METHOD_TYPE = '2' AND V_PERIOD_NAME = '2010-12' AND P_NEW_SOURCE_AMOUNT > 1000 THEN
          V_MONTH_SUM_AMOUNT := 0;
          V_MONTH_SUM_AMOUNT := (NVL(P_AMOUNT, 0) - (NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0))) - NVL(P_NEW_SOURCE_AMOUNT, 0);
          V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + NVL(V_MONTH_SUM_AMOUNT, 0);
        END IF;*/
---------------------------------------------------------------------------------------------------
        -- �󰢴����.
        V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
        V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
        
        -- ó������ ����.
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
      
/*      -- �ӽ� ��� --
      IF P_DPR_METHOD_TYPE = '2' AND V_PERIOD_NAME = '2010-12' AND P_NEW_SOURCE_AMOUNT > 1000 THEN
        V_SOURCE_AMOUNT := NVL(P_NEW_SOURCE_AMOUNT, 0);
--        RAISE_APPLICATION_ERROR(-20001, 'SOURCE AMOUNT : ' || P_NEW_SOURCE_AMOUNT);
      ELS*/IF P_DPR_METHOD_TYPE = '2' THEN
      -- �� �ݾ� ����.
        IF NVL(P_CURR_AMOUNT, 0) <> 0 THEN
          V_SOURCE_CURR_AMOUNT := NVL(P_CURR_AMOUNT, 0) - V_DPR_SUM_CURR_AMOUNT;
        END IF;
        V_SOURCE_AMOUNT := NVL(P_AMOUNT, 0) - V_DPR_SUM_AMOUNT;
      END IF;
      V_YEAR := V_YEAR + 1;
    END LOOP C1;
  END DPR_SET;

---------------------------------------------------------------------------------------------------
-- �ڻ꺰 �ں��� ���� / �ڻ� �Ű� : �� ���.
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
    V_PERIOD_NAME                   VARCHAR2(7);    -- �󰢳��.
    V_DPR_SEQ                       NUMBER;         -- �� ����.
    
    V_YEAR                          NUMBER;
    V_DATE_FR                       DATE;
    V_DATE_TO                       DATE;
    V_ACQUIRE_DATE                  DATE;           -- �������.
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
    
    V_ADD_CURR_AMOUNT               NUMBER := 0;    -- �ں�������ݾ�.
    V_ADD_AMOUNT                    NUMBER := 0;    -- �ں�������ݾ�.
    V_TOTAL_CURR_AMOUNT             NUMBER := 0;    -- �ѻ󰢴��ݾ�.
    V_TOTAL_AMOUNT                  NUMBER := 0;    -- �ѻ󰢴��ݾ�.
    
  BEGIN
    V_DPR_SEQ                       := 0;
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
    
    V_ADD_CURR_AMOUNT               := 0;    -- �ں�������ݾ�.
    V_ADD_AMOUNT                    := 0;    -- �ں�������ݾ�.
    V_TOTAL_CURR_AMOUNT             := 0;    -- �ѻ󰢴��ݾ�.
    V_TOTAL_AMOUNT                  := 0;    -- �ѻ󰢴��ݾ�.
    
    V_PERIOD_NAME := TO_CHAR(ADD_MONTHS(P_CHARGE_DATE, - 1), 'YYYY-MM');
    V_YEAR := TO_NUMBER(TO_CHAR(P_CHARGE_DATE, 'YYYY'));
    
    -- ������� ��ȸ.
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
      
    -- ��ó���� ��� ����.
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
    ELSIF TO_DATE(TO_CHAR(V_YEAR) || '-01-31', 'YYYY-MM-DD') < P_CHARGE_DATE THEN 
      V_TOTAL_COUNT := V_TOTAL_COUNT + 1;
    END IF;    
    /*DBMS_OUTPUT.PUT_LINE('TOTAL COUNT : ' || V_TOTAL_COUNT);*/
    
    -- ���⵵�� �̻��ܾ� �Ǵ� ��氡��, ���� ����� ����.
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
    -- ���س⵵ �ں��� ������ ���� ��� ������.
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
    
    -- ���س⵵ �ڻ�Ű��� ���� ��� ������.
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
    
    -- �̹� ó���� �����󰢺� ����.
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
    
    -- �����󰢳��.
    BEGIN
      V_LAST_DATE := ADD_MONTHS(TRUNC(V_ACQUIRE_DATE, 'MONTH') - 1, NVL(P_DPR_PROGRESS_YEAR, 0) * 12);      
      /*SELECT TO_DATE(MAX(ADH.PERIOD_NAME), 'YYYY-MM') AS PERIOD_NAME
        INTO V_LAST_DATE
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
      ;*/
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('LAST PERIOD ERROR : ' || SUBSTR(SQLERRM, 1, 150));
      V_LAST_DATE := ADD_MONTHS(TRUNC(P_CHARGE_DATE, 'MONTH') - 1, (NVL(P_DPR_PROGRESS_YEAR, 0) - NVL(V_P_TOTAL_COUNT, 0)) * 12);
    END;
    
    -- ��氡�� ��ȸ.
    V_TOTAL_CURR_AMOUNT := NVL(V_TOTAL_CURR_AMOUNT, 0) + NVL(V_ADD_CURR_AMOUNT, 0) + NVL(P_CURR_AMOUNT, 0);
    V_TOTAL_AMOUNT      := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0) + NVL(P_AMOUNT, 0);
        
    -- ������ ���ݾ�(�ں��� ���� �ݾ� ����).
    V_SOURCE_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) + NVL(V_ADD_CURR_AMOUNT, 0) + NVL(P_CURR_AMOUNT, 0);
    V_SOURCE_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0) + NVL(P_AMOUNT, 0);
    
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
-- ���� ��� : 
-- ���� ��� : 
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN 1 .. V_TOTAL_COUNT
    LOOP
---------------------------------------------------------------------------------------------------
      -- ��󰢾� ���.
      IF P_DPR_METHOD_TYPE = '2' THEN
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
        V_DPR_YEAR_AMOUNT := TRUNC((V_SOURCE_AMOUNT - NVL(P_RESIDUAL_AMOUNT, 0)) * (V_DPR_RATE));        
      END IF;
---------------------------------------------------------------------------------------------------
      -- �ش� �⵵�� ���� ����.
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
      /*DBMS_OUTPUT.PUT_LINE(' C1 : ' || C1 || ', V_MONTH_COUNT : ' || V_MONTH_COUNT || ', V_YEAR : ' || V_YEAR || ', V_LAST_DATE : ' || V_LAST_DATE || ', V_DATE_FR : ' || V_DATE_FR || ' V_DATE_TO : ' || V_DATE_TO);*/
      IF NVL(V_MONTH_COUNT, 0) = 0 THEN
        V_MONTH_COUNT := 12;
      END IF;
      
      IF C1 = 1 THEN
      -- ��󰢺� ���� ���(�̹� ó���� �󰢺� ����).
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_P_DPR_CURR_AMOUNT, 0);
        END IF;
        V_DPR_YEAR_AMOUNT := NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_P_DPR_AMOUNT, 0);           
        /*
        IF P_CHARGE_CODE IN('90', '91') THEN
          V_DPR_YEAR_CURR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
          V_DPR_YEAR_AMOUNT := TRUNC(NVL(V_DPR_YEAR_AMOUNT, 0) / 12 * V_MONTH_COUNT);
        END IF;*/
      ELSIF C1 = V_TOTAL_COUNT THEN
      -- ��󰢺� ���� ���.
        IF NVL(V_SOURCE_CURR_AMOUNT, 0) <> 0 THEN
          V_DPR_YEAR_CURR_AMOUNT := NVL(V_SOURCE_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        END IF;
        V_DPR_YEAR_AMOUNT := NVL(V_SOURCE_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
        
        IF P_DPR_METHOD_TYPE = '1' THEN
        -- �ܿ��ݾ׸� ����.
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
        
        -- ó������ ����.
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
      -- �� �ݾ� ����.
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

---------------------------------------------------------------------------------------------------
-- �ڻ꺰 �Ű�/��� �� ���.
  PROCEDURE DPR_SELL_OUT_SET
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
            , P_DPR_DC_AMOUNT       IN NUMBER
            , P_SOB_ID              IN NUMBER
            , P_ORG_ID              IN NUMBER
            , P_USER_ID             IN NUMBER
            )
  AS
    V_ACQUIRE_DATE                  DATE;           -- �������.
    V_LAST_PERIOD                   VARCHAR2(7);    -- �� ������.
    V_MONTH_COUNT                   NUMBER;         -- �����⵵ ����.
    
    N_DECREASE_CURR_AMOUNT          NUMBER := 0;    -- ���ұݾ�(��ȭ).
    N_DECREASE_AMOUNT               NUMBER := 0;    -- ���ұݾ�.
    N_SELL_OUT_CURR_RATE            NUMBER := 0;    -- �Ű���(��ȭ).
    N_SELL_OUT_RATE                 NUMBER := 0;    -- �Ű���.
    
    V_DPR_CURR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_DPR_YEAR_CURR_AMOUNT          NUMBER := 0;    -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               NUMBER := 0;    -- �� �󰢱ݾ�.
    
    V_MONTH_SUM_CURR_AMOUNT         NUMBER := 0;    -- �� �󰢴���ݾ�(��ȭ).
    V_MONTH_SUM_AMOUNT              NUMBER := 0;    -- �� �󰢴���ݾ�.
    
    V_DPR_SUM_CURR_AMOUNT           NUMBER := 0;    -- �� �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                NUMBER := 0;    -- �� �󰢴���ݾ�.
    
    V_UN_DPR_REMAIN_AMOUNT          NUMBER := 0;    -- ��ΰ���.
    
    V_ADD_CURR_AMOUNT               NUMBER := 0;    -- �����ݾ�.
    V_ADD_AMOUNT                    NUMBER := 0;    -- �����ݾ�.
    
    V_TOTAL_CURR_AMOUNT             NUMBER := 0;    -- �����ݾ�.
    V_TOTAL_AMOUNT                  NUMBER := 0;    -- �����ݾ�.
    
  BEGIN
    V_LAST_PERIOD                   := NULL;        -- �� ������.
    
    N_DECREASE_AMOUNT               := 0;           -- ���ұݾ�.
    N_SELL_OUT_CURR_RATE            := 0;           -- �Ű���(��ȭ).
    N_SELL_OUT_RATE                 := 0;           -- �Ű���.
        
    V_DPR_CURR_AMOUNT               := 0;           -- �� �󰢱ݾ�(��ȭ).
    V_DPR_AMOUNT                    := 0;           -- �� �󰢱ݾ�.
    
    V_DPR_YEAR_CURR_AMOUNT          := 0;           -- �� �󰢱ݾ�(��ȭ).
    V_DPR_YEAR_AMOUNT               := 0;           -- �� �󰢱ݾ�.
    
    V_DPR_SUM_CURR_AMOUNT           := 0;           -- �� �󰢴���ݾ�(��ȭ).
    V_DPR_SUM_AMOUNT                := 0;           -- �� �󰢴���ݾ�.
    
    V_UN_DPR_REMAIN_AMOUNT          := 0;           -- ��ΰ���.
    
    V_ADD_CURR_AMOUNT               := 0;
    V_ADD_AMOUNT                    := 0;
    
    V_TOTAL_CURR_AMOUNT             := 0;           -- �����ݾ�.
    V_TOTAL_AMOUNT                  := 0;           -- �����ݾ�.
    
    -- ���ݾ� ��ȸ.
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
      DBMS_OUTPUT.PUT_LINE('ACQUIRE AMOUNT ERROR : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
    -- ���س⵵ �ں��� ������ ���� ��� ������.
    BEGIN
      SELECT NVL(SUM(AH.CURR_AMOUNT), 0) AS CURR_AMOUNT
           , NVL(SUM(AH.AMOUNT), 0) AS AMOUNT
        INTO V_ADD_CURR_AMOUNT
           , V_ADD_AMOUNT
        FROM FI_ASSET_HISTORY AH
      WHERE AH.ASSET_ID                 = P_ASSET_ID
        AND AH.SOB_ID                   = P_SOB_ID
        AND AH.CHARGE_DATE              < P_CHARGE_DATE
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                       AND FC.COMMON_ID   = AH.CHARGE_ID
                       AND FC.SOB_ID      = P_SOB_ID
                       AND FC.CODE        = '10'
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADD_CURR_AMOUNT := 0;
      V_ADD_AMOUNT := 0;
    END;
    V_TOTAL_CURR_AMOUNT := NVL(V_TOTAL_CURR_AMOUNT, 0) + NVL(V_ADD_CURR_AMOUNT, 0);
    V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0);
    
    -- ���س⵵ �ڻ�Ű��� ���� ��� ������.
    BEGIN
      SELECT NVL(SUM(AH.CURR_AMOUNT), 0) AS CURR_AMOUNT
           , NVL(SUM(AH.AMOUNT), 0) AS AMOUNT
        INTO V_ADD_CURR_AMOUNT
           , V_ADD_AMOUNT
        FROM FI_ASSET_HISTORY AH
      WHERE AH.ASSET_ID                 = P_ASSET_ID
        AND AH.SOB_ID                   = P_SOB_ID
        AND AH.CHARGE_DATE              < P_CHARGE_DATE
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                       AND FC.COMMON_ID   = AH.CHARGE_ID
                       AND FC.SOB_ID      = P_SOB_ID
                       AND FC.CODE        IN('90', '91')
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADD_CURR_AMOUNT := 0;
      V_ADD_AMOUNT := 0;
    END;
    V_TOTAL_CURR_AMOUNT := NVL(V_TOTAL_CURR_AMOUNT, 0) - NVL(V_ADD_CURR_AMOUNT, 0);
    V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) - NVL(V_ADD_AMOUNT, 0);
    /*RAISE_APPLICATION_ERROR(-20001, 'V_TOTAL_AMOUNT : ' || V_TOTAL_AMOUNT);    */
    
    -- �Ű���� �󰢴���� ��ȸ.
    BEGIN
      SELECT NVL(ADH.DPR_SUM_CURR_AMOUNT, 0) AS DPR_SUM_CURR_AMOUNT
           , NVL(ADH.DPR_SUM_AMOUNT, 0) AS DPR_SUM_AMOUNT
        INTO V_DPR_SUM_CURR_AMOUNT
           , V_DPR_SUM_AMOUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
        AND ADH.PERIOD_NAME             = TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DPR_SUM_CURR_AMOUNT := 0;
      V_DPR_SUM_AMOUNT := 0;
    END;
    IF NVL(V_DPR_SUM_AMOUNT, 0) > 0 THEN
      V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) - NVL(P_DPR_DC_AMOUNT, 0);
    END IF;
    IF NVL(V_DPR_SUM_AMOUNT, 0) < 0 THEN
      V_DPR_SUM_AMOUNT := 0;
    END IF;    
/*    RAISE_APPLICATION_ERROR(-20001, 'V_DPR_SUM_AMOUNT : ' || V_DPR_SUM_AMOUNT || ', P_DPR_DC_AMOUNT : ' || P_DPR_DC_AMOUNT);    */
    -- �����󰢳��.
    BEGIN
      SELECT MAX(ADH.PERIOD_NAME) AS PERIOD_NAME
        INTO V_LAST_PERIOD
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LAST_PERIOD := TO_CHAR(ADD_MONTHS(TRUNC(V_ACQUIRE_DATE, 'MONTH') - 1, NVL(P_DPR_PROGRESS_YEAR, 0) * 12), 'YYYY-MM');
    END;
    -- �������� ����������� ���� ��� ���� ��� ����.
    IF V_LAST_PERIOD < TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') THEN
      V_LAST_PERIOD := TO_CHAR(P_CHARGE_DATE, 'YYYY-MM');
    END IF;
    V_MONTH_COUNT := MONTHS_BETWEEN(TO_DATE(V_LAST_PERIOD, 'YYYY-MM'), TRUNC(TO_DATE(V_LAST_PERIOD, 'YYYY-MM'), 'YEAR')) + 1;
-----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------
    -- ���� ��� ( �Ű��ݾ� / ���ݾ�) --
    IF NVL(V_TOTAL_CURR_AMOUNT, 0) = 0 THEN
      N_SELL_OUT_CURR_RATE := 0;
    ELSE
      N_SELL_OUT_CURR_RATE := NVL(P_CURR_AMOUNT, 0) / V_TOTAL_CURR_AMOUNT;
    END IF;
    IF NVL(V_TOTAL_AMOUNT, 0) = 0 THEN
      N_SELL_OUT_RATE := 0;
    ELSE
      N_SELL_OUT_RATE := NVL(P_AMOUNT, 0) / V_TOTAL_AMOUNT;
    END IF;
    /*RAISE_APPLICATION_ERROR(-20001, 'N_SELL_OUT_RATE : ' || N_SELL_OUT_RATE); */       
-----------------------------------------------------------------------------------------------------------------------
    -- �Ű��ݾ� ���� �� �� �ݾ�.
    V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) - NVL(P_AMOUNT, 0);
    IF NVL(V_TOTAL_AMOUNT, 0) <= 0 THEN
    -- ���� �Ű�/���.
      -- ����̻� �ܾ� 0 UPDATE.
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.UN_DPR_REMAIN_CURR_AMOUNT = 0
          , ADH.UN_DPR_REMAIN_AMOUNT      = 0
      WHERE ADH.ASSET_ID            = P_ASSET_ID
        AND ADH.DPR_TYPE            = P_DPR_TYPE
        AND ADH.SOB_ID              = P_SOB_ID
        AND ADH.PERIOD_NAME IN ( SELECT MAX(DH.PERIOD_NAME) AS PERIOD_NAME
                                   FROM FI_ASSET_DPR_HISTORY DH
                                 WHERE DH.PERIOD_NAME         <= TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
                                   AND DH.ASSET_ID            = ADH.ASSET_ID
                                   AND DH.DPR_TYPE            = ADH.DPR_TYPE
                                   AND DH.SOB_ID              = ADH.SOB_ID
                                )
      ;
      -- �ڻ꺯�� ���� ������ ����.
      DELETE FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.PERIOD_NAME         > TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
        AND ADH.ASSET_ID            = P_ASSET_ID
        AND ADH.DPR_TYPE            = P_DPR_TYPE
        AND ADH.SOB_ID              = P_SOB_ID
      ;
      RETURN;
    END IF;
-----------------------------------------------------------------------------------------------------------------------    
    V_UN_DPR_REMAIN_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0);
    IF NVL(V_UN_DPR_REMAIN_AMOUNT, 0) < 0 THEN
      V_UN_DPR_REMAIN_AMOUNT := 0;
    END IF;
    BEGIN
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ADH.DPR_SUM_AMOUNT        = NVL(V_DPR_SUM_AMOUNT, 0)
          , ADH.UN_DPR_REMAIN_AMOUNT  = NVL(V_UN_DPR_REMAIN_AMOUNT, 0)
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
        AND ADH.PERIOD_NAME             = TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
      ;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Set Book Amount Error : ' || SUBSTR(SQLERRM, 1, 150));
    END;
    
-----------------------------------------------------------------------------------------------------------------------
    FOR C1 IN ( SELECT ADH.PERIOD_NAME
                     , ADH.SOB_ID
                     , ADH.ORG_ID
                     , ADH.DPR_TYPE
                     , ADH.ASSET_ID
                     , ADH.DPR_COUNT
                     , ADH.DPR_RATE
                     , ADH.SOURCE_CURR_AMOUNT
                     , ADH.SOURCE_AMOUNT
                     , ADH.DPR_CURR_AMOUNT
                     , ADH.DPR_AMOUNT
                     , ADH.DPR_YEAR_CURR_AMOUNT
                     , ADH.DPR_YEAR_AMOUNT
                     , ADH.DPR_SUM_CURR_AMOUNT
                     , ADH.DPR_SUM_AMOUNT
                     , ADH.UN_DPR_REMAIN_CURR_AMOUNT
                     , ADH.UN_DPR_REMAIN_AMOUNT
                  FROM FI_ASSET_DPR_HISTORY ADH
                WHERE ADH.PERIOD_NAME           > TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
                  AND ADH.ASSET_ID              = P_ASSET_ID
                  AND ADH.SOB_ID                = P_SOB_ID
                  AND ADH.DPR_TYPE              = P_DPR_TYPE
                ORDER BY ADH.PERIOD_NAME 
              )
    LOOP
---------------------------------------------------------------------------------------------------
      -- ���ұݾ�.
      IF N_SELL_OUT_RATE = 1 THEN
        V_DPR_YEAR_CURR_AMOUNT := 0;
        V_DPR_YEAR_AMOUNT := 0;
        
        V_DPR_CURR_AMOUNT := 0;
        V_DPR_AMOUNT := 0;
        
        -- �󰢴����.
        V_DPR_SUM_CURR_AMOUNT := NVL(V_TOTAL_CURR_AMOUNT, 0);
        V_DPR_SUM_AMOUNT := NVL(V_TOTAL_AMOUNT, 0);
      ELSE
        IF NVL(C1.DPR_CURR_AMOUNT, 0) = 0 THEN
          N_DECREASE_CURR_AMOUNT := 0;
        ELSE
          N_DECREASE_CURR_AMOUNT := ROUND(NVL(C1.DPR_CURR_AMOUNT, 0) * N_SELL_OUT_CURR_RATE, 0);
        END IF;
        IF NVL(C1.DPR_AMOUNT, 0) = 0 THEN
          N_DECREASE_AMOUNT := 0;
        ELSE
          N_DECREASE_AMOUNT := ROUND(NVL(C1.DPR_AMOUNT, 0) * N_SELL_OUT_RATE, 0);
        END IF;
        V_DPR_YEAR_CURR_AMOUNT := NVL(C1.DPR_YEAR_CURR_AMOUNT, 0) - NVL(N_DECREASE_CURR_AMOUNT, 0);
        V_DPR_YEAR_AMOUNT := NVL(C1.DPR_YEAR_AMOUNT, 0) - NVL(N_DECREASE_AMOUNT, 0);
        
        V_DPR_CURR_AMOUNT := NVL(C1.DPR_CURR_AMOUNT, 0) - NVL(N_DECREASE_CURR_AMOUNT, 0);
        V_DPR_AMOUNT := NVL(C1.DPR_AMOUNT, 0) - NVL(N_DECREASE_AMOUNT, 0);
        
        -- �󰢴����.
        V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
        V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
      END IF;   
---------------------------------------------------------------------------------------------------      
      -- ó������ ����.
      DPR_INSERT( P_PERIOD_NAME => C1.PERIOD_NAME
              , P_SOB_ID => P_SOB_ID
              , P_ORG_ID => P_ORG_ID
              , P_DPR_TYPE => C1.DPR_TYPE
              , P_ASSET_ID => C1.ASSET_ID
              , P_ASSET_CATEGORY_ID => P_ASSET_CATEGORY_ID
              , P_SOURCE_CURR_AMOUNT => C1.SOURCE_CURR_AMOUNT
              , P_SOURCE_AMOUNT => C1.SOURCE_AMOUNT
              , P_SOURCE_ADD_CURR_AMOUNT => 0
              , P_SOURCE_ADD_AMOUNT => 0
              , P_DPR_METHOD_TYPE => P_DPR_METHOD_TYPE
              , P_DPR_PROGRESS_YEAR => P_DPR_PROGRESS_YEAR
              , P_DPR_RATE => C1.DPR_RATE
              , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
              , P_DPR_AMOUNT => V_DPR_AMOUNT
              , P_DPR_COUNT => C1.DPR_COUNT
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
    END LOOP C1;
    /*RAISE_APPLICATION_ERROR(-20001, 'V_LAST_PERIOD : ' || V_LAST_PERIOD);*/   
    
    -- �����⵵�� ���� �󰢺� �ٽ� ��� : �������� ��ŭ�� ���ΰ� �ٽ� ���--.
    V_MONTH_SUM_CURR_AMOUNT := 0;
    V_MONTH_SUM_AMOUNT := 0;
    
    -- ������� ���� �� �����/��ΰ��� ��ȸ.
    BEGIN
      SELECT NVL(ADH.DPR_SUM_CURR_AMOUNT, 0) AS DPR_SUM_CURR_AMOUNT
           , NVL(ADH.DPR_SUM_AMOUNT, 0) AS DPR_SUM_AMOUNT
           , NVL(ADH.UN_DPR_REMAIN_CURR_AMOUNT, 0) AS UN_DPR_REMAIN_CURR_AMOUNT
           , NVL(ADH.UN_DPR_REMAIN_AMOUNT, 0) AS UN_DPR_REMAIN_AMOUNT
        INTO V_DPR_SUM_CURR_AMOUNT
           , V_DPR_SUM_AMOUNT
           , V_DPR_YEAR_CURR_AMOUNT
           , V_DPR_YEAR_AMOUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.ASSET_ID                = P_ASSET_ID
        AND ADH.DPR_TYPE                = P_DPR_TYPE
        AND ADH.SOB_ID                  = P_SOB_ID
        AND ADH.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TRUNC(TO_DATE(V_LAST_PERIOD, 'YYYY-MM'), 'YEAR'), - 1), 'YYYY-MM')
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DPR_YEAR_CURR_AMOUNT := 0;
      V_DPR_YEAR_AMOUNT := 0;
    END;
    
    -- �������� ����.
    IF NVL(V_DPR_YEAR_CURR_AMOUNT, 0) > 0 THEN
      V_DPR_YEAR_CURR_AMOUNT := NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
    END IF;
    IF NVL(V_DPR_YEAR_AMOUNT, 0) > 0 THEN
      V_DPR_YEAR_AMOUNT := NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(P_RESIDUAL_AMOUNT, 0);
    END IF;
    IF NVL(V_MONTH_COUNT, 0) = 0 THEN
      V_DPR_CURR_AMOUNT := 0;
      V_DPR_AMOUNT := 0;
    ELSE
      V_DPR_CURR_AMOUNT := ROUND(NVL(V_DPR_YEAR_CURR_AMOUNT, 0) / V_MONTH_COUNT, 0);
      V_DPR_AMOUNT := ROUND(NVL(V_DPR_YEAR_AMOUNT, 0) / V_MONTH_COUNT, 0);
    END IF;
    
    FOR C1 IN ( SELECT ADH.PERIOD_NAME
                     , ADH.SOB_ID
                     , ADH.ORG_ID
                     , ADH.DPR_TYPE
                     , ADH.ASSET_ID
                     , ADH.DPR_COUNT
                     , ADH.DPR_RATE
                     , ADH.SOURCE_CURR_AMOUNT
                     , ADH.SOURCE_AMOUNT
                     , ADH.DPR_CURR_AMOUNT
                     , ADH.DPR_AMOUNT
                     , ADH.DPR_YEAR_CURR_AMOUNT
                     , ADH.DPR_YEAR_AMOUNT
                     , ADH.DPR_SUM_CURR_AMOUNT
                     , ADH.DPR_SUM_AMOUNT
                     , ADH.UN_DPR_REMAIN_CURR_AMOUNT
                     , ADH.UN_DPR_REMAIN_AMOUNT
                  FROM FI_ASSET_DPR_HISTORY ADH
                WHERE ADH.PERIOD_NAME           > TO_CHAR(ADD_MONTHS(TRUNC(TO_DATE(V_LAST_PERIOD, 'YYYY-MM'), 'YEAR'), - 1), 'YYYY-MM')
                  AND ADH.ASSET_ID              = P_ASSET_ID
                  AND ADH.SOB_ID                = P_SOB_ID
                  AND ADH.DPR_TYPE              = P_DPR_TYPE
                ORDER BY ADH.PERIOD_NAME 
              )
    LOOP
      -- ���󰢴����.
      V_MONTH_SUM_CURR_AMOUNT := NVL(V_MONTH_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
      V_MONTH_SUM_AMOUNT := NVL(V_MONTH_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
      
      IF C1.PERIOD_NAME = V_LAST_PERIOD THEN
        IF NVL(V_MONTH_SUM_CURR_AMOUNT, 0) <> NVL(V_DPR_YEAR_CURR_AMOUNT, 0) THEN
          V_DPR_CURR_AMOUNT := NVL(V_DPR_CURR_AMOUNT, 0) + (NVL(V_DPR_YEAR_CURR_AMOUNT, 0) - NVL(V_MONTH_SUM_CURR_AMOUNT, 0));
        END IF;
        IF NVL(V_MONTH_SUM_AMOUNT, 0) <> NVL(V_DPR_YEAR_AMOUNT, 0) THEN
          V_DPR_AMOUNT := NVL(V_DPR_AMOUNT, 0) + (NVL(V_DPR_YEAR_AMOUNT, 0) - NVL(V_MONTH_SUM_AMOUNT, 0));
        END IF;
      END IF;
      
      -- �󰢴����.
      V_DPR_SUM_CURR_AMOUNT := NVL(V_DPR_SUM_CURR_AMOUNT, 0) + NVL(V_DPR_CURR_AMOUNT, 0);
      V_DPR_SUM_AMOUNT := NVL(V_DPR_SUM_AMOUNT, 0) + NVL(V_DPR_AMOUNT, 0);
        
      -- ó������ ����.
      DPR_INSERT( P_PERIOD_NAME => C1.PERIOD_NAME
              , P_SOB_ID => P_SOB_ID
              , P_ORG_ID => P_ORG_ID
              , P_DPR_TYPE => C1.DPR_TYPE
              , P_ASSET_ID => C1.ASSET_ID
              , P_ASSET_CATEGORY_ID => P_ASSET_CATEGORY_ID
              , P_SOURCE_CURR_AMOUNT => C1.SOURCE_CURR_AMOUNT
              , P_SOURCE_AMOUNT => C1.SOURCE_AMOUNT
              , P_SOURCE_ADD_CURR_AMOUNT => 0
              , P_SOURCE_ADD_AMOUNT => 0
              , P_DPR_METHOD_TYPE => P_DPR_METHOD_TYPE
              , P_DPR_PROGRESS_YEAR => P_DPR_PROGRESS_YEAR
              , P_DPR_RATE => C1.DPR_RATE
              , P_DPR_CURR_AMOUNT => V_DPR_CURR_AMOUNT
              , P_DPR_AMOUNT => V_DPR_AMOUNT
              , P_DPR_COUNT => C1.DPR_COUNT
              , P_DPR_YEAR_CURR_AMOUNT => V_DPR_YEAR_CURR_AMOUNT
              , P_DPR_YEAR_AMOUNT => V_DPR_YEAR_AMOUNT
              , P_DPR_SUM_CURR_AMOUNT => V_DPR_SUM_CURR_AMOUNT
              , P_DPR_SUM_AMOUNT => V_DPR_SUM_AMOUNT
              , P_UN_DPR_REMAIN_CURR_AMOUNT => (NVL(V_TOTAL_CURR_AMOUNT, 0) - NVL(V_DPR_SUM_CURR_AMOUNT, 0))
              , P_UN_DPR_REMAIN_AMOUNT =>  (NVL(V_TOTAL_AMOUNT, 0) - NVL(V_DPR_SUM_AMOUNT, 0))
              , P_USER_ID => P_USER_ID
              );
    
    END LOOP C1;
    
  END DPR_SELL_OUT_SET;
      
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
  
END FI_ASSET_DPR_HISTORY_SET_G;
/
