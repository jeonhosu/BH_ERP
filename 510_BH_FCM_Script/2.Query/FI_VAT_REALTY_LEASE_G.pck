CREATE OR REPLACE PACKAGE FI_VAT_REALTY_LEASE_G
AS

-- VAT 부동산임대공급가액명세서 조회.
  PROCEDURE SELECT_REALTY_LEASE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_REALTY_LEASE.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_REALTY_LEASE.SOB_ID%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            );

-- VAT 부동산임대공급가액명세서 INSERT.
  PROCEDURE INSERT_REALTY_LEASE
            ( P_REALTY_LEASE_ID     OUT FI_VAT_REALTY_LEASE.REALTY_LEASE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_REALTY_LEASE.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_REALTY_LEASE.SOB_ID%TYPE
            , P_ORG_ID              IN FI_VAT_REALTY_LEASE.ORG_ID%TYPE
            , P_HOUSE_NUM           IN FI_VAT_REALTY_LEASE.HOUSE_NUM%TYPE
            , P_FLOOR_TYPE          IN FI_VAT_REALTY_LEASE.FLOOR_TYPE%TYPE
            , P_FLOOR_COUNT         IN FI_VAT_REALTY_LEASE.FLOOR_COUNT%TYPE
            , P_ROOM_NO             IN FI_VAT_REALTY_LEASE.ROOM_NO%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            , P_RESIDENT_NUM        IN FI_VAT_REALTY_LEASE.RESIDENT_NUM%TYPE
            , P_AREA_M2             IN FI_VAT_REALTY_LEASE.AREA_M2%TYPE
            , P_USE_DESC            IN FI_VAT_REALTY_LEASE.USE_DESC%TYPE
            , P_USE_DATE_FR         IN FI_VAT_REALTY_LEASE.USE_DATE_FR%TYPE
            , P_USE_DATE_TO         IN FI_VAT_REALTY_LEASE.USE_DATE_TO%TYPE
            , P_DEPOSIT_AMOUNT      IN FI_VAT_REALTY_LEASE.DEPOSIT_AMOUNT%TYPE
            , P_MONTHLY_RENT_AMOUNT IN FI_VAT_REALTY_LEASE.MONTHLY_RENT_AMOUNT%TYPE
            , P_MAINTENANCE_FEE     IN FI_VAT_REALTY_LEASE.MAINTENANCE_FEE%TYPE
            , P_USER_ID             IN FI_VAT_REALTY_LEASE.CREATED_BY%TYPE 
            );

-- VAT 부동산임대공급가액명세서 UPDATE.
  PROCEDURE UPDATE_REALTY_LEASE
            ( W_REALTY_LEASE_ID     IN FI_VAT_REALTY_LEASE.REALTY_LEASE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_REALTY_LEASE.SOB_ID%TYPE
            , P_HOUSE_NUM           IN FI_VAT_REALTY_LEASE.HOUSE_NUM%TYPE
            , P_FLOOR_TYPE          IN FI_VAT_REALTY_LEASE.FLOOR_TYPE%TYPE
            , P_FLOOR_COUNT         IN FI_VAT_REALTY_LEASE.FLOOR_COUNT%TYPE
            , P_ROOM_NO             IN FI_VAT_REALTY_LEASE.ROOM_NO%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            , P_RESIDENT_NUM        IN FI_VAT_REALTY_LEASE.RESIDENT_NUM%TYPE
            , P_AREA_M2             IN FI_VAT_REALTY_LEASE.AREA_M2%TYPE
            , P_USE_DESC            IN FI_VAT_REALTY_LEASE.USE_DESC%TYPE
            , P_USE_DATE_FR         IN FI_VAT_REALTY_LEASE.USE_DATE_FR%TYPE
            , P_USE_DATE_TO         IN FI_VAT_REALTY_LEASE.USE_DATE_TO%TYPE
            , P_DEPOSIT_AMOUNT      IN FI_VAT_REALTY_LEASE.DEPOSIT_AMOUNT%TYPE
            , P_MONTHLY_RENT_AMOUNT IN FI_VAT_REALTY_LEASE.MONTHLY_RENT_AMOUNT%TYPE
            , P_MAINTENANCE_FEE     IN FI_VAT_REALTY_LEASE.MAINTENANCE_FEE%TYPE
            , P_USER_ID             IN FI_VAT_REALTY_LEASE.CREATED_BY%TYPE 
            );

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 명세서 조회.
  PROCEDURE SELECT_REALTY_LEASE_HISTORY
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_REALTY_LEASE_HISTORY.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_REALTY_LEASE_HISTORY.SOB_ID%TYPE
            , W_USE_DATE_FR       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR%TYPE
            , W_USE_DATE_TO       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 명세서 생성.
  PROCEDURE SET_REALTY_LEASE_HISTORY
            ( W_TAX_CODE          IN FI_VAT_REALTY_LEASE_HISTORY.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_REALTY_LEASE_HISTORY.SOB_ID%TYPE
            , W_USE_DATE_FR       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR%TYPE
            , W_USE_DATE_TO       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO%TYPE
            , P_USER_ID           IN FI_VAT_REALTY_LEASE_HISTORY.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 명세서 마감여부 체크.
  FUNCTION CLOSED_YN_F
            ( W_REALTY_LEASE_ID   IN FI_VAT_REALTY_LEASE_HISTORY.REALTY_LEASE_ID%TYPE
            , P_SOB_ID            IN FI_VAT_REALTY_LEASE_HISTORY.SOB_ID%TYPE
            , W_USE_DATE_FR       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR%TYPE
            , W_USE_DATE_TO       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO%TYPE
            ) RETURN VARCHAR2;

END FI_VAT_REALTY_LEASE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_REALTY_LEASE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_REALTY_LEASE_G
/* Description  : 부가세 조회-부동산임대공급 현황 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 부동산임대공급가액명세서 조회.
  PROCEDURE SELECT_REALTY_LEASE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_REALTY_LEASE.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_REALTY_LEASE.SOB_ID%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT VRL.REALTY_LEASE_ID
           , VRL.TAX_CODE
           , VRL.HOUSE_NUM
           , FI_COMMON_G.CODE_NAME_F('FLOOR_TYPE', VRL.FLOOR_TYPE, VRL.SOB_ID) AS FLOOR_TYPE_DESC
           , VRL.FLOOR_TYPE
           , VRL.FLOOR_COUNT
           , VRL.ROOM_NO
           , SC.SUPP_CUST_CODE AS CUSTOMER_CODE
           , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
           , VRL.CUSTOMER_ID
           , SC.TAX_REG_NO
           , VRL.RESIDENT_NUM
           , VRL.AREA_M2
           , VRL.USE_DESC
           , VRL.USE_DATE_FR
           , VRL.USE_DATE_TO
           , VRL.DEPOSIT_AMOUNT
           , VRL.MONTHLY_RENT_AMOUNT
           , VRL.MAINTENANCE_FEE
        FROM FI_VAT_REALTY_LEASE VRL
          , FI_SUPP_CUST_V SC
      WHERE VRL.CUSTOMER_ID       = SC.SUPP_CUST_ID
        AND VRL.SOB_ID            = SC.SOB_ID
        AND VRL.TAX_CODE          = W_TAX_CODE
        AND VRL.SOB_ID            = W_SOB_ID
        AND VRL.CUSTOMER_ID       = NVL(W_CUSTOMER_ID, VRL.CUSTOMER_ID)
      ;
  END SELECT_REALTY_LEASE;

-- VAT 부동산임대공급가액명세서 INSERT.
  PROCEDURE INSERT_REALTY_LEASE
            ( P_REALTY_LEASE_ID     OUT FI_VAT_REALTY_LEASE.REALTY_LEASE_ID%TYPE
            , P_TAX_CODE            IN FI_VAT_REALTY_LEASE.TAX_CODE%TYPE
            , P_SOB_ID              IN FI_VAT_REALTY_LEASE.SOB_ID%TYPE
            , P_ORG_ID              IN FI_VAT_REALTY_LEASE.ORG_ID%TYPE
            , P_HOUSE_NUM           IN FI_VAT_REALTY_LEASE.HOUSE_NUM%TYPE
            , P_FLOOR_TYPE          IN FI_VAT_REALTY_LEASE.FLOOR_TYPE%TYPE
            , P_FLOOR_COUNT         IN FI_VAT_REALTY_LEASE.FLOOR_COUNT%TYPE
            , P_ROOM_NO             IN FI_VAT_REALTY_LEASE.ROOM_NO%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            , P_RESIDENT_NUM        IN FI_VAT_REALTY_LEASE.RESIDENT_NUM%TYPE
            , P_AREA_M2             IN FI_VAT_REALTY_LEASE.AREA_M2%TYPE
            , P_USE_DESC            IN FI_VAT_REALTY_LEASE.USE_DESC%TYPE
            , P_USE_DATE_FR         IN FI_VAT_REALTY_LEASE.USE_DATE_FR%TYPE
            , P_USE_DATE_TO         IN FI_VAT_REALTY_LEASE.USE_DATE_TO%TYPE
            , P_DEPOSIT_AMOUNT      IN FI_VAT_REALTY_LEASE.DEPOSIT_AMOUNT%TYPE
            , P_MONTHLY_RENT_AMOUNT IN FI_VAT_REALTY_LEASE.MONTHLY_RENT_AMOUNT%TYPE
            , P_MAINTENANCE_FEE     IN FI_VAT_REALTY_LEASE.MAINTENANCE_FEE%TYPE
            , P_USER_ID             IN FI_VAT_REALTY_LEASE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    SELECT FI_VAT_REALTY_LEASE_S1.NEXTVAL
      INTO P_REALTY_LEASE_ID
      FROM DUAL;

    INSERT INTO FI_VAT_REALTY_LEASE
    ( REALTY_LEASE_ID
    , TAX_CODE 
    , SOB_ID 
    , ORG_ID 
    , HOUSE_NUM
    , FLOOR_TYPE 
    , FLOOR_COUNT 
    , ROOM_NO 
    , CUSTOMER_ID 
    , RESIDENT_NUM 
    , AREA_M2 
    , USE_DESC 
    , USE_DATE_FR 
    , USE_DATE_TO 
    , DEPOSIT_AMOUNT 
    , MONTHLY_RENT_AMOUNT 
    , MAINTENANCE_FEE 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_REALTY_LEASE_ID
    , P_TAX_CODE
    , P_SOB_ID
    , P_ORG_ID
    , P_HOUSE_NUM
    , P_FLOOR_TYPE
    , P_FLOOR_COUNT
    , P_ROOM_NO
    , P_CUSTOMER_ID
    , P_RESIDENT_NUM
    , P_AREA_M2
    , P_USE_DESC
    , P_USE_DATE_FR
    , P_USE_DATE_TO
    , NVL(P_DEPOSIT_AMOUNT, 0)
    , NVL(P_MONTHLY_RENT_AMOUNT, 0)
    , NVL(P_MAINTENANCE_FEE, 0)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_REALTY_LEASE;
  
-- VAT 부동산임대공급가액명세서 UPDATE.
  PROCEDURE UPDATE_REALTY_LEASE
            ( W_REALTY_LEASE_ID     IN FI_VAT_REALTY_LEASE.REALTY_LEASE_ID%TYPE
            , P_SOB_ID              IN FI_VAT_REALTY_LEASE.SOB_ID%TYPE
            , P_HOUSE_NUM           IN FI_VAT_REALTY_LEASE.HOUSE_NUM%TYPE
            , P_FLOOR_TYPE          IN FI_VAT_REALTY_LEASE.FLOOR_TYPE%TYPE
            , P_FLOOR_COUNT         IN FI_VAT_REALTY_LEASE.FLOOR_COUNT%TYPE
            , P_ROOM_NO             IN FI_VAT_REALTY_LEASE.ROOM_NO%TYPE
            , P_CUSTOMER_ID         IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            , P_RESIDENT_NUM        IN FI_VAT_REALTY_LEASE.RESIDENT_NUM%TYPE
            , P_AREA_M2             IN FI_VAT_REALTY_LEASE.AREA_M2%TYPE
            , P_USE_DESC            IN FI_VAT_REALTY_LEASE.USE_DESC%TYPE
            , P_USE_DATE_FR         IN FI_VAT_REALTY_LEASE.USE_DATE_FR%TYPE
            , P_USE_DATE_TO         IN FI_VAT_REALTY_LEASE.USE_DATE_TO%TYPE
            , P_DEPOSIT_AMOUNT      IN FI_VAT_REALTY_LEASE.DEPOSIT_AMOUNT%TYPE
            , P_MONTHLY_RENT_AMOUNT IN FI_VAT_REALTY_LEASE.MONTHLY_RENT_AMOUNT%TYPE
            , P_MAINTENANCE_FEE     IN FI_VAT_REALTY_LEASE.MAINTENANCE_FEE%TYPE
            , P_USER_ID             IN FI_VAT_REALTY_LEASE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE FI_VAT_REALTY_LEASE
      SET HOUSE_NUM           = P_HOUSE_NUM
        , FLOOR_TYPE          = P_FLOOR_TYPE
        , FLOOR_COUNT         = P_FLOOR_COUNT
        , ROOM_NO             = P_ROOM_NO
        , CUSTOMER_ID         = P_CUSTOMER_ID
        , RESIDENT_NUM        = P_RESIDENT_NUM
        , AREA_M2             = P_AREA_M2
        , USE_DESC            = P_USE_DESC
        , USE_DATE_FR         = P_USE_DATE_FR
        , USE_DATE_TO         = P_USE_DATE_TO
        , DEPOSIT_AMOUNT      = NVL(P_DEPOSIT_AMOUNT, 0)
        , MONTHLY_RENT_AMOUNT = NVL(P_MONTHLY_RENT_AMOUNT, 0)
        , MAINTENANCE_FEE     = NVL(P_MAINTENANCE_FEE, 0)
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE REALTY_LEASE_ID     = W_REALTY_LEASE_ID;
  END UPDATE_REALTY_LEASE;

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 명세서 조회.
  PROCEDURE SELECT_REALTY_LEASE_HISTORY
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_REALTY_LEASE_HISTORY.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_REALTY_LEASE_HISTORY.SOB_ID%TYPE
            , W_USE_DATE_FR       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR%TYPE
            , W_USE_DATE_TO       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_REALTY_LEASE.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT RL.HOUSE_NUM
           , FI_COMMON_G.CODE_NAME_F('FLOOR_TYPE', RL.FLOOR_TYPE, RL.SOB_ID) || RL.FLOOR_COUNT || ' ' || 
             EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10292', NULL) AS FLOOR_DESC
           , RL.ROOM_NO
           , RL.AREA_M2
           , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
           , SC.TAX_REG_NO
           , CASE
               WHEN RL.USE_DATE_FR BETWEEN W_USE_DATE_FR AND W_USE_DATE_TO THEN RL.USE_DATE_FR
               ELSE NULL
             END AS USE_DATE_FR
           , CASE
               WHEN RL.USE_DATE_TO BETWEEN W_USE_DATE_FR AND W_USE_DATE_TO THEN RL.USE_DATE_TO
               ELSE NULL
             END AS USE_DATE_TO
           , RL.DEPOSIT_AMOUNT
           , RL.MONTHLY_RENT_AMOUNT
           , NVL(RLH.DEPOSIT_INTEREST_AMT, 0) + NVL(RLH.MONTHLY_RENT_SUM_AMT, 0) AS LEASE_SUM_AMOUNT
           , RLH.DEPOSIT_INTEREST_AMT
           , RLH.MONTHLY_RENT_SUM_AMT
           , FI_COMMON_G.CODE_NAME_F('FLOOR_TYPE', RL.FLOOR_TYPE, RL.SOB_ID) AS FLOOR_TYPE_DESC
           , RL.FLOOR_COUNT
           , SC.PRESIDENT_NAME
        FROM FI_VAT_REALTY_LEASE_HISTORY RLH
          , FI_VAT_REALTY_LEASE RL
          , FI_SUPP_CUST_V SC
      WHERE RLH.REALTY_LEASE_ID         = RL.REALTY_LEASE_ID
        AND RLH.SOB_ID                  = RL.SOB_ID
        AND RL.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND RL.ORG_ID                   = SC.ORG_ID
        AND RL.TAX_CODE                 = W_TAX_CODE
        AND RL.SOB_ID                   = W_SOB_ID
        AND RL.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, RL.CUSTOMER_ID)
        AND RLH.USE_DATE_FR             = W_USE_DATE_FR
        AND RLH.USE_DATE_TO             = W_USE_DATE_TO
      ORDER BY RLH.TAX_CODE, SC.TAX_REG_NO
      ;
  END SELECT_REALTY_LEASE_HISTORY;

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 명세서 생성.
  PROCEDURE SET_REALTY_LEASE_HISTORY
            ( W_TAX_CODE          IN FI_VAT_REALTY_LEASE_HISTORY.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_REALTY_LEASE_HISTORY.SOB_ID%TYPE
            , W_USE_DATE_FR       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR%TYPE
            , W_USE_DATE_TO       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO%TYPE
            , P_USER_ID           IN FI_VAT_REALTY_LEASE_HISTORY.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_INTEREST_RATE           NUMBER := 0;
    
    V_YEAR_DAY                NUMBER := 365;
    V_PERIOD_DAY              NUMBER := 0;
    V_MONTH_COUNT             NUMBER := 0;
    V_USE_DATE_FR             DATE;
    V_USE_DATE_TO             DATE;
    
    V_DEPOSIT_INTEREST_AMT    NUMBER := 0;    -- 보증금이자.
    V_MONTHLY_RENT_SUM_AMT    NUMBER := 0;    -- 월세합계.
  BEGIN
    BEGIN
      V_YEAR_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F(TRUNC(W_USE_DATE_FR, 'YEAR'), LAST_DAY(TO_DATE(TO_CHAR(W_USE_DATE_FR, 'YYYY') || '-12-31', 'YYYY-MM-DD')), 1);
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_DAY                := 365;
    END;
    BEGIN
      SELECT NVL(VIR.INTEREST_RATE, 0) AS INTEREST_RATE
        INTO V_INTEREST_RATE
        FROM FI_VAT_INTEREST_RATE VIR
      WHERE VIR.EFFECTIVE_DATE_FR    <= W_USE_DATE_TO
        AND VIR.EFFECTIVE_DATE_TO    >= W_USE_DATE_TO
        AND VIR.SOB_ID               = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_INTEREST_RATE := 0;
    END;
    FOR C1 IN ( SELECT RL.REALTY_LEASE_ID
                     , RL.TAX_CODE
                     , RL.SOB_ID
                     , RL.ORG_ID
                     , RL.CUSTOMER_ID
                     , RL.USE_DATE_FR
                     , RL.USE_DATE_TO
                     , RL.DEPOSIT_AMOUNT
                     , RL.MONTHLY_RENT_AMOUNT
                     , RL.MAINTENANCE_FEE
                  FROM FI_VAT_REALTY_LEASE RL
                WHERE RL.TAX_CODE                 = W_TAX_CODE
                  AND RL.SOB_ID                   = W_SOB_ID
                  AND RL.USE_DATE_FR              <= W_USE_DATE_TO
                  AND RL.USE_DATE_TO              >= W_USE_DATE_FR
                ORDER BY RL.USE_DATE_FR
              )
    LOOP
      V_PERIOD_DAY              := 0;      
      V_DEPOSIT_INTEREST_AMT    := 0;    -- 보증금이자.
      V_MONTHLY_RENT_SUM_AMT    := 0;    -- 월세합계.
      
      -- 기간 재정의.
      SELECT CASE
               WHEN W_USE_DATE_FR <= C1.USE_DATE_FR THEN C1.USE_DATE_FR
               ELSE W_USE_DATE_FR
             END AS USE_DATE_FR
           , CASE
               WHEN W_USE_DATE_TO <= C1.USE_DATE_TO THEN W_USE_DATE_TO
               ELSE C1.USE_DATE_TO
             END AS USE_DATE_TO
        INTO V_USE_DATE_FR
           , V_USE_DATE_TO
        FROM DUAL;
      V_PERIOD_DAY := V_USE_DATE_TO - V_USE_DATE_FR + 1;  
      -- 월수.
      SELECT MONTHS_BETWEEN(V_USE_DATE_TO , V_USE_DATE_FR - 1)
        INTO V_MONTH_COUNT
        FROM DUAL;
        
      V_DEPOSIT_INTEREST_AMT := TRUNC((NVL(C1.DEPOSIT_AMOUNT, 0) / V_YEAR_DAY) * V_PERIOD_DAY * (V_INTEREST_RATE / 100));
      V_MONTHLY_RENT_SUM_AMT := NVL(C1.MONTHLY_RENT_AMOUNT, 0) * NVL(V_MONTH_COUNT, 0);
      
      UPDATE FI_VAT_REALTY_LEASE_HISTORY RLH
        SET RLH.DEPOSIT_INTEREST_AMT  = NVL(V_DEPOSIT_INTEREST_AMT, 0)
          , RLH.MONTHLY_RENT_SUM_AMT  = NVL(V_MONTHLY_RENT_SUM_AMT, 0)
          , RLH.TOTAL_DAY             = V_YEAR_DAY
          , RLH.PERIOD_DAY            = V_PERIOD_DAY
          , RLH.LAST_UPDATE_DATE      = V_SYSDATE
          , RLH.LAST_UPDATED_BY       = P_USER_ID
      WHERE RLH.REALTY_LEASE_ID       = C1.REALTY_LEASE_ID
        AND RLH.TAX_CODE              = C1.TAX_CODE
        AND RLH.USE_DATE_FR           = W_USE_DATE_FR
        AND RLH.USE_DATE_TO           = W_USE_DATE_TO
        AND RLH.SOB_ID                = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        INSERT INTO FI_VAT_REALTY_LEASE_HISTORY
        ( REALTY_LEASE_ID
        , TAX_CODE
        , USE_DATE_FR
        , USE_DATE_TO
        , SOB_ID
        , ORG_ID
        , DEPOSIT_INTEREST_AMT
        , MONTHLY_RENT_SUM_AMT
        , MAINTENANCE_FEE
        , TOTAL_DAY
        , PERIOD_DAY
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY )
        VALUES
        ( C1.REALTY_LEASE_ID
        , W_TAX_CODE
        , W_USE_DATE_FR
        , W_USE_DATE_TO
        , C1.SOB_ID
        , C1.ORG_ID
        , NVL(V_DEPOSIT_INTEREST_AMT, 0)
        , NVL(V_MONTHLY_RENT_SUM_AMT, 0)
        , NVL(C1.MAINTENANCE_FEE, 0)
        , NVL(V_YEAR_DAY, 0)
        , NVL(V_PERIOD_DAY, 0)
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID );
      END IF;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END SET_REALTY_LEASE_HISTORY;

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 명세서 마감여부 체크.
  FUNCTION CLOSED_YN_F
            ( W_REALTY_LEASE_ID   IN FI_VAT_REALTY_LEASE_HISTORY.REALTY_LEASE_ID%TYPE
            , P_SOB_ID            IN FI_VAT_REALTY_LEASE_HISTORY.SOB_ID%TYPE
            , W_USE_DATE_FR       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_FR%TYPE
            , W_USE_DATE_TO       IN FI_VAT_REALTY_LEASE_HISTORY.USE_DATE_TO%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT RLH.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_REALTY_LEASE_HISTORY RLH
      WHERE RLH.REALTY_LEASE_ID   = W_REALTY_LEASE_ID
        AND RLH.SOB_ID            = P_SOB_ID
        AND RLH.USE_DATE_FR       = W_USE_DATE_FR
        AND RLH.USE_DATE_TO       = W_USE_DATE_TO
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;
  END CLOSED_YN_F;

END FI_VAT_REALTY_LEASE_G;
/
