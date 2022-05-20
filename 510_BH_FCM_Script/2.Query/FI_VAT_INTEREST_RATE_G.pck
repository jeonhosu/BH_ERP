CREATE OR REPLACE PACKAGE FI_VAT_INTEREST_RATE_G
AS

-- VAT 부동산임대공급 이자율 조회.
  PROCEDURE SELECT_INTEREST_RATE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , W_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            );

-- VAT 부동산임대공급가 이자율 INSERT.
  PROCEDURE INSERT_INTEREST_RATE
            ( P_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_VAT_INTEREST_RATE.ORG_ID%TYPE
            , P_INTEREST_RATE     IN FI_VAT_INTEREST_RATE.INTEREST_RATE%TYPE
            , P_USER_ID           IN FI_VAT_INTEREST_RATE.CREATED_BY%TYPE 
            );

-- VAT 부동산임대공급가 이자율 UPDATE.
  PROCEDURE UPDATE_INTEREST_RATE
            ( W_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_VAT_INTEREST_RATE.ORG_ID%TYPE
            , P_INTEREST_RATE     IN FI_VAT_INTEREST_RATE.INTEREST_RATE%TYPE
            , P_USER_ID           IN FI_VAT_INTEREST_RATE.CREATED_BY%TYPE 
            );

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 이자율.
  FUNCTION INTEREST_RATE_F
            ( W_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            ) RETURN NUMBER;

END FI_VAT_INTEREST_RATE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_INTEREST_RATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_INTEREST_RATE_G
/* Description  : 부가세 조회-부동산임대공급 이자율 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 부동산임대공급 이자율 조회.
  PROCEDURE SELECT_INTEREST_RATE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , W_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT VIR.INTEREST_RATE
        FROM (SELECT NVL(IR.INTEREST_RATE, 0) AS INTEREST_RATE
                FROM FI_VAT_INTEREST_RATE IR
              WHERE IR.EFFECTIVE_DATE_FR <= W_STD_DATE
                AND IR.EFFECTIVE_DATE_TO >= W_STD_DATE        
                AND IR.SOB_ID             = W_SOB_ID
              UNION ALL
              SELECT 0 AS INTEREST_RATE
                FROM DUAL
             ) VIR
      ;
  END SELECT_INTEREST_RATE;

-- VAT 부동산임대공급가 이자율 INSERT.
  PROCEDURE INSERT_INTEREST_RATE
            ( P_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_VAT_INTEREST_RATE.ORG_ID%TYPE
            , P_INTEREST_RATE     IN FI_VAT_INTEREST_RATE.INTEREST_RATE%TYPE
            , P_USER_ID           IN FI_VAT_INTEREST_RATE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_EFFECTIVE_DATE_FR   FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE;
    V_EFFECTIVE_DATE_TO   FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_TO%TYPE;
    V_LAST_FLAG           FI_VAT_INTEREST_RATE.LAST_FLAG%TYPE;
  BEGIN
    V_EFFECTIVE_DATE_FR := P_STD_DATE;
    V_EFFECTIVE_DATE_TO := TO_DATE('3000-12-31', 'YYYY-MM-DD');
    V_LAST_FLAG         := 'Y';
    
    INSERT INTO FI_VAT_INTEREST_RATE
    ( EFFECTIVE_DATE_FR
    , EFFECTIVE_DATE_TO 
    , SOB_ID 
    , ORG_ID 
    , INTEREST_RATE 
    , LAST_FLAG 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( V_EFFECTIVE_DATE_FR
    , V_EFFECTIVE_DATE_TO
    , P_SOB_ID
    , P_ORG_ID
    , NVL(P_INTEREST_RATE, 0)
    , V_LAST_FLAG
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
     
  END INSERT_INTEREST_RATE;

-- VAT 부동산임대공급가 이자율 UPDATE.
  PROCEDURE UPDATE_INTEREST_RATE
            ( W_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            , P_ORG_ID            IN FI_VAT_INTEREST_RATE.ORG_ID%TYPE
            , P_INTEREST_RATE     IN FI_VAT_INTEREST_RATE.INTEREST_RATE%TYPE
            , P_USER_ID           IN FI_VAT_INTEREST_RATE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_LAST_FLAG         FI_VAT_INTEREST_RATE.LAST_FLAG%TYPE := 'N';
  BEGIN
  
    UPDATE FI_VAT_INTEREST_RATE
      SET INTEREST_RATE     = NVL(P_INTEREST_RATE, 0)
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE EFFECTIVE_DATE_FR <= W_STD_DATE
      AND EFFECTIVE_DATE_TO >= W_STD_DATE
      AND SOB_ID            = P_SOB_ID
    ;
    IF SQL%ROWCOUNT = 0 THEN
      INSERT_INTEREST_RATE
        ( P_STD_DATE          => W_STD_DATE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_INTEREST_RATE     => P_INTEREST_RATE
        , P_USER_ID           => P_USER_ID 
        );
    END IF;
  END UPDATE_INTEREST_RATE;

---------------------------------------------------------------------------------------------------
-- VAT 부동산임대공급가 이자율.
  FUNCTION INTEREST_RATE_F
            ( W_STD_DATE          IN FI_VAT_INTEREST_RATE.EFFECTIVE_DATE_FR%TYPE
            , P_SOB_ID            IN FI_VAT_INTEREST_RATE.SOB_ID%TYPE
            ) RETURN NUMBER
  AS
    V_INTEREST_RATE     FI_VAT_INTEREST_RATE.INTEREST_RATE%TYPE := 0;
  BEGIN
    BEGIN
      SELECT IR.INTEREST_RATE
        INTO V_INTEREST_RATE
        FROM FI_VAT_INTEREST_RATE IR
      WHERE IR.EFFECTIVE_DATE_FR <= W_STD_DATE
        AND IR.EFFECTIVE_DATE_TO >= W_STD_DATE
        AND IR.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_INTEREST_RATE := 0;
    END;
    RETURN V_INTEREST_RATE;
  END INTEREST_RATE_F;

END FI_VAT_INTEREST_RATE_G;
/
