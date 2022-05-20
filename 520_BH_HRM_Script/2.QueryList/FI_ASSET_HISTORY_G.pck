CREATE OR REPLACE PACKAGE FI_ASSET_HISTORY_G
AS
-- 자산변동 내역 전체.
  PROCEDURE ASSET_HISTORY_ALL_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_DATE_FR         IN DATE
            , W_DATE_TO         IN DATE
            , W_ASSET_CODE_FR   IN FI_ASSET_MASTER.ASSET_CODE%TYPE
            , W_ASSET_CODE_TO   IN FI_ASSET_MASTER.ASSET_CODE%TYPE            
            , W_SOB_ID          IN FI_ASSET_MASTER.SOB_ID%TYPE
            );
            
-- 자산변동 내역.            
  PROCEDURE ASSET_HISTORY_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_ASSET_ID        IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , W_SOB_ID          IN FI_ASSET_MASTER.SOB_ID%TYPE
            );

  PROCEDURE ASSET_HISTORY_INSERT
            ( P_HISTORY_NUM              OUT FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            , P_CHARGE_DATE              IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
            , P_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_HISTORY.ORG_ID%TYPE
            , P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_CHARGE_ID                IN FI_ASSET_HISTORY.CHARGE_ID%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_HISTORY.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_HISTORY.EXCHANGE_RATE%TYPE
            , P_AMOUNT                   IN FI_ASSET_HISTORY.AMOUNT%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_HISTORY.CURR_AMOUNT%TYPE
            , P_QTY                      IN FI_ASSET_HISTORY.QTY%TYPE
            , P_LOCATION_ID              IN FI_ASSET_HISTORY.LOCATION_ID%TYPE
            , P_USE_DEPT_ID              IN FI_ASSET_HISTORY.USE_DEPT_ID%TYPE
            , P_FIRST_USER               IN FI_ASSET_HISTORY.FIRST_USER%TYPE
            , P_SECOND_USER              IN FI_ASSET_HISTORY.SECOND_USER%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_HISTORY.COST_CENTER_ID%TYPE
            , P_DESCRIPTION              IN FI_ASSET_HISTORY.DESCRIPTION%TYPE
            , P_USER_ID                  IN FI_ASSET_HISTORY.CREATED_BY%TYPE 
            );

-- 고정자산 변동내역 수정.
  PROCEDURE ASSET_HISTORY_UPDATE
            ( W_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            , W_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_CHARGE_DATE              IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
            , P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_CHARGE_ID                IN FI_ASSET_HISTORY.CHARGE_ID%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_HISTORY.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_HISTORY.EXCHANGE_RATE%TYPE
            , P_AMOUNT                   IN FI_ASSET_HISTORY.AMOUNT%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_HISTORY.CURR_AMOUNT%TYPE
            , P_QTY                      IN FI_ASSET_HISTORY.QTY%TYPE
            , P_LOCATION_ID              IN FI_ASSET_HISTORY.LOCATION_ID%TYPE
            , P_USE_DEPT_ID              IN FI_ASSET_HISTORY.USE_DEPT_ID%TYPE
            , P_FIRST_USER               IN FI_ASSET_HISTORY.FIRST_USER%TYPE
            , P_SECOND_USER              IN FI_ASSET_HISTORY.SECOND_USER%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_HISTORY.COST_CENTER_ID%TYPE
            , P_BF_AMOUNT                IN FI_ASSET_HISTORY.BF_AMOUNT%TYPE
            , P_BF_CURR_AMOUNT           IN FI_ASSET_HISTORY.BF_CURR_AMOUNT%TYPE
            , P_BF_QTY                   IN FI_ASSET_HISTORY.BF_QTY%TYPE
            , P_BF_LOCATION_ID           IN FI_ASSET_HISTORY.BF_LOCATION_ID%TYPE
            , P_BF_USE_DEPT_ID           IN FI_ASSET_HISTORY.BF_USE_DEPT_ID%TYPE
            , P_BF_FIRST_USER            IN FI_ASSET_HISTORY.BF_FIRST_USER%TYPE
            , P_BF_SECOND_USER           IN FI_ASSET_HISTORY.BF_SECOND_USER%TYPE
            , P_BF_COST_CENTER_ID        IN FI_ASSET_HISTORY.BF_COST_CENTER_ID%TYPE
            , P_DESCRIPTION              IN FI_ASSET_HISTORY.DESCRIPTION%TYPE
            , P_USER_ID                  IN FI_ASSET_HISTORY.CREATED_BY%TYPE 
            );

-- 고정자산 변동내역 삭제.
  PROCEDURE ASSET_HISTORY_DELETE
            ( W_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            );

-- 고정자산 충당금 당기감소액 계산.
  FUNCTION DPR_DC_AMOUNT_F
           ( W_ASSET_ID                  IN FI_ASSET_MASTER.ASSET_ID%TYPE
           , W_DPR_TYPE                  IN VARCHAR2
           , P_CHARGE_DATE               IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
           , P_AMOUNT                    IN FI_ASSET_HISTORY.AMOUNT%TYPE
           , W_SOB_ID                    IN FI_ASSET_HISTORY.SOB_ID%TYPE
           ) RETURN NUMBER;
           
-- 트리거 이벤트 --
  PROCEDURE ASSET_MASTER_UPDATE
            ( P_GB                       IN VARCHAR2
            , P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_HISTORY.ORG_ID%TYPE
            , P_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            , P_CHARGE_DATE              IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
            , P_CHARGE_ID                IN FI_ASSET_HISTORY.CHARGE_ID%TYPE
            , P_CHARGE_CODE              IN VARCHAR2
            , P_CURR_AMOUNT              IN NUMBER
            , P_AMOUNT                   IN NUMBER
            , P_DPR_DC_AMOUNT            IN NUMBER
            , P_IFRS_DPR_DC_AMOUNT       IN NUMBER
            , P_LOCATION_ID              IN FI_ASSET_HISTORY.LOCATION_ID%TYPE
            , P_USE_DEPT_ID              IN FI_ASSET_HISTORY.USE_DEPT_ID%TYPE
            , P_FIRST_USER               IN FI_ASSET_HISTORY.FIRST_USER%TYPE
            , P_SECOND_USER              IN FI_ASSET_HISTORY.SECOND_USER%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_HISTORY.COST_CENTER_ID%TYPE
            , P_USER_ID                  IN FI_ASSET_HISTORY.CREATED_BY%TYPE 
            );

  PROCEDURE ASSET_HISTORY_CANCEL
            ( P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_DPR_TYPE                 IN FI_ASSET_DPR_HISTORY.DPR_TYPE%TYPE
            , P_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            );
            
END FI_ASSET_HISTORY_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_HISTORY_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ASSET_HISTORY_G
/* Description  : 자산변동 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 자산변동 내역 전체.
  PROCEDURE ASSET_HISTORY_ALL_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_DATE_FR         IN DATE
            , W_DATE_TO         IN DATE
            , W_ASSET_CODE_FR   IN FI_ASSET_MASTER.ASSET_CODE%TYPE
            , W_ASSET_CODE_TO   IN FI_ASSET_MASTER.ASSET_CODE%TYPE            
            , W_SOB_ID          IN FI_ASSET_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AH.HISTORY_NUM
           , AH.CHARGE_DATE
           , AH.CHARGE_ID
           , FI_COMMON_G.ID_NAME_F(AH.CHARGE_ID) AS CHARGE_NAME
           , AH.CURRENCY_CODE
           , AH.EXCHANGE_RATE     
           , AH.CURR_AMOUNT
           , AH.AMOUNT
           , AH.QTY           
           , AH.LOCATION_ID
           , FI_COMMON_G.ID_NAME_F(AH.LOCATION_ID) AS LOCATION_NAME
           , AH.USE_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AH.USE_DEPT_ID) AS USE_DEPT_NAME
           , AH.FIRST_USER
           , PM1.PERSON_NUM AS FIRST_USER_NUM
           , PM1.NAME AS FIRST_USER_NAME
           , AH.SECOND_USER
           , PM2.PERSON_NUM AS SECOND_USER_NUM
           , PM2.NAME AS SECOND_USER_NAME
           , AH.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_DESC_F(AH.COST_CENTER_ID) AS COST_CENTER_NAME
           , AH.BF_CURR_AMOUNT
           , AH.BF_AMOUNT
           , AH.BF_QTY
           , AH.BF_USE_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AH.BF_USE_DEPT_ID) AS BF_USE_DEPT_NAME
           , AH.BF_LOCATION_ID
           , FI_COMMON_G.ID_NAME_F(AH.BF_LOCATION_ID) AS BF_LOCATION_NAME
           , AH.BF_FIRST_USER
           , BF_PM1.PERSON_NUM AS BF_FIRST_USER_NUM
           , BF_PM1.NAME AS BF_FIRST_USER_NAME
           , AH.BF_SECOND_USER
           , BF_PM2.PERSON_NUM AS BF_SECOND_USER_NUM
           , BF_PM2.NAME AS BF_SECOND_USER_NAME
           , AH.BF_COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_DESC_F(AH.BF_COST_CENTER_ID) AS BF_COST_CENTER_NAME
           , AH.DESCRIPTION
           , AH.ASSET_ID
        FROM FI_ASSET_HISTORY AH
          , FI_ASSET_MASTER AM
          , HRM_PERSON_MASTER PM1
          , HRM_PERSON_MASTER PM2
          , HRM_PERSON_MASTER BF_PM1
          , HRM_PERSON_MASTER BF_PM2
      WHERE AH.ASSET_ID               = AM.ASSET_ID
        AND AH.FIRST_USER             = PM1.PERSON_ID(+)
        AND AH.SECOND_USER            = PM2.PERSON_ID(+)
        AND AH.BF_FIRST_USER          = BF_PM1.PERSON_ID(+)
        AND AH.BF_SECOND_USER         = BF_PM2.PERSON_ID(+)
        AND AH.SOB_ID                 = W_SOB_ID
        AND AH.CHARGE_DATE            BETWEEN W_DATE_FR AND W_DATE_TO
        AND AM.ASSET_CODE             >= NVL(W_ASSET_CODE_FR, AM.ASSET_CODE)
        AND AM.ASSET_CODE             <= NVL(W_ASSET_CODE_TO, AM.ASSET_CODE)
      ORDER BY AH.HISTORY_NUM  
      ;
  END ASSET_HISTORY_ALL_SELECT;
  
  PROCEDURE ASSET_HISTORY_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_ASSET_ID        IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , W_SOB_ID          IN FI_ASSET_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AH.HISTORY_NUM
           , AH.CHARGE_DATE
           , AH.CHARGE_ID
           , FI_COMMON_G.ID_NAME_F(AH.CHARGE_ID) AS CHARGE_NAME
           , AH.CURRENCY_CODE
           , AH.EXCHANGE_RATE     
           , AH.CURR_AMOUNT
           , AH.AMOUNT
           , AH.QTY           
           , AH.LOCATION_ID
           , FI_COMMON_G.ID_NAME_F(AH.LOCATION_ID) AS LOCATION_NAME
           , AH.USE_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AH.USE_DEPT_ID) AS USE_DEPT_NAME
           , AH.FIRST_USER
           , PM1.PERSON_NUM AS FIRST_USER_NUM
           , PM1.NAME AS FIRST_USER_NAME
           , AH.SECOND_USER
           , PM2.PERSON_NUM AS SECOND_USER_NUM
           , PM2.NAME AS SECOND_USER_NAME
           , AH.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_DESC_F(AH.COST_CENTER_ID) AS COST_CENTER_NAME
           , AH.BF_CURR_AMOUNT
           , AH.BF_AMOUNT
           , AH.BF_QTY
           , AH.BF_LOCATION_ID
           , FI_COMMON_G.ID_NAME_F(AH.BF_LOCATION_ID) AS BF_LOCATION_NAME
           , AH.BF_USE_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AH.BF_USE_DEPT_ID) AS BF_USE_DEPT_NAME
           , AH.BF_FIRST_USER
           , BF_PM1.PERSON_NUM AS BF_FIRST_USER_NUM
           , BF_PM1.NAME AS BF_FIRST_USER_NAME
           , AH.BF_SECOND_USER
           , BF_PM2.PERSON_NUM AS BF_SECOND_USER_NUM
           , BF_PM2.NAME AS BF_SECOND_USER_NAME
           , AH.BF_COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_DESC_F(AH.BF_COST_CENTER_ID) AS BF_COST_CENTER_NAME
           , AH.DESCRIPTION
           , AH.ASSET_ID
        FROM FI_ASSET_HISTORY AH
          , HRM_PERSON_MASTER PM1
          , HRM_PERSON_MASTER PM2
          , HRM_PERSON_MASTER BF_PM1
          , HRM_PERSON_MASTER BF_PM2
      WHERE AH.FIRST_USER             = PM1.PERSON_ID(+)
        AND AH.SECOND_USER            = PM2.PERSON_ID(+)
        AND AH.BF_FIRST_USER          = BF_PM1.PERSON_ID(+)
        AND AH.BF_SECOND_USER         = BF_PM2.PERSON_ID(+)
        AND AH.SOB_ID                 = W_SOB_ID
        AND AH.ASSET_ID               = W_ASSET_ID
      ORDER BY AH.HISTORY_NUM  
      ;  

  END ASSET_HISTORY_SELECT;

  PROCEDURE ASSET_HISTORY_INSERT
            ( P_HISTORY_NUM              OUT FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            , P_CHARGE_DATE              IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
            , P_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_HISTORY.ORG_ID%TYPE
            , P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_CHARGE_ID                IN FI_ASSET_HISTORY.CHARGE_ID%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_HISTORY.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_HISTORY.EXCHANGE_RATE%TYPE
            , P_AMOUNT                   IN FI_ASSET_HISTORY.AMOUNT%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_HISTORY.CURR_AMOUNT%TYPE
            , P_QTY                      IN FI_ASSET_HISTORY.QTY%TYPE
            , P_LOCATION_ID              IN FI_ASSET_HISTORY.LOCATION_ID%TYPE
            , P_USE_DEPT_ID              IN FI_ASSET_HISTORY.USE_DEPT_ID%TYPE
            , P_FIRST_USER               IN FI_ASSET_HISTORY.FIRST_USER%TYPE
            , P_SECOND_USER              IN FI_ASSET_HISTORY.SECOND_USER%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_HISTORY.COST_CENTER_ID%TYPE
            , P_DESCRIPTION              IN FI_ASSET_HISTORY.DESCRIPTION%TYPE
            , P_USER_ID                  IN FI_ASSET_HISTORY.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_BF_AMOUNT           FI_ASSET_HISTORY.BF_AMOUNT%TYPE;
    V_BF_CURR_AMOUNT      FI_ASSET_HISTORY.BF_CURR_AMOUNT%TYPE;
    V_BF_QTY              FI_ASSET_HISTORY.BF_QTY%TYPE;    
    V_BF_LOCATION_ID      FI_ASSET_HISTORY.BF_LOCATION_ID%TYPE;
    V_BF_USE_DEPT_ID      FI_ASSET_HISTORY.BF_USE_DEPT_ID%TYPE;
    V_BF_FIRST_USER       FI_ASSET_HISTORY.BF_FIRST_USER%TYPE;
    V_BF_SECOND_USER      FI_ASSET_HISTORY.BF_SECOND_USER%TYPE;
    V_BF_COST_CENTER_ID   FI_ASSET_HISTORY.BF_COST_CENTER_ID%TYPE;
    V_CHARGE_CODE         FI_COMMON.CODE%TYPE;
    N_DPR_SUM_DC_AMOUNT   NUMBER := 0;
    N_IFRS_DPR_SUM_DC_AMOUNT  NUMBER := 0;
    
  BEGIN
    P_HISTORY_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('ASSET_HISTORY', P_SOB_ID, P_CHARGE_DATE, P_USER_ID);
    V_CHARGE_CODE := FI_COMMON_G.GET_CODE_F(P_CHARGE_ID, P_SOB_ID);
    
    -- 자산매각/폐기시 충당금감소액 계산.
    IF V_CHARGE_CODE IN('90', '91') THEN
      N_DPR_SUM_DC_AMOUNT := DPR_DC_AMOUNT_F
          ( P_ASSET_ID
          , '10'
          , P_CHARGE_DATE
          , P_AMOUNT
          , P_SOB_ID
          );
      N_IFRS_DPR_SUM_DC_AMOUNT := DPR_DC_AMOUNT_F
          ( P_ASSET_ID
          , '20'
          , P_CHARGE_DATE
          , P_AMOUNT
          , P_SOB_ID
          );  
    END IF;
    
    -- 이전 정보.
    BEGIN
      SELECT AM.AMOUNT
           , AM.CURR_AMOUNT
           , AM.QTY           
           , AM.LOCATION_ID
           , AM.USE_DEPT_ID
           , AM.FIRST_USER
           , AM.SECOND_USER
           , AM.COST_CENTER_ID
        INTO V_BF_AMOUNT
           , V_BF_CURR_AMOUNT
           , V_BF_QTY
           , V_BF_LOCATION_ID
           , V_BF_USE_DEPT_ID
           , V_BF_FIRST_USER
           , V_BF_SECOND_USER
           , V_BF_COST_CENTER_ID
        FROM FI_ASSET_MASTER AM
      WHERE AM.ASSET_ID           = P_ASSET_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BF_AMOUNT           := NULL;
      V_BF_CURR_AMOUNT      := NULL;
      V_BF_QTY              := NULL;
      V_BF_LOCATION_ID      := NULL;
      V_BF_USE_DEPT_ID      := NULL;
      V_BF_FIRST_USER       := NULL;
      V_BF_SECOND_USER      := NULL;
      V_BF_COST_CENTER_ID   := NULL;
    END;
    
    INSERT INTO FI_ASSET_HISTORY
    ( HISTORY_NUM
    , CHARGE_DATE 
    , SOB_ID 
    , ORG_ID 
    , ASSET_ID 
    , CHARGE_ID 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , AMOUNT 
    , CURR_AMOUNT 
    , QTY      
    , LOCATION_ID 
    , USE_DEPT_ID
    , FIRST_USER
    , SECOND_USER
    , COST_CENTER_ID 
    , BF_AMOUNT 
    , BF_CURR_AMOUNT 
    , BF_QTY     
    , BF_LOCATION_ID 
    , BF_USE_DEPT_ID 
    , BF_FIRST_USER
    , BF_SECOND_USER
    , BF_COST_CENTER_ID
    , DPR_SUM_DC_AMOUNT
    , IFRS_DPR_SUM_DC_AMOUNT
    , DESCRIPTION
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_HISTORY_NUM
    , P_CHARGE_DATE
    , P_SOB_ID
    , P_ORG_ID
    , P_ASSET_ID
    , P_CHARGE_ID
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_AMOUNT
    , P_CURR_AMOUNT
    , P_QTY    
    , P_LOCATION_ID
    , P_USE_DEPT_ID
    , P_FIRST_USER
    , P_SECOND_USER
    , P_COST_CENTER_ID
    , V_BF_AMOUNT
    , V_BF_CURR_AMOUNT
    , V_BF_QTY
    , V_BF_LOCATION_ID
    , V_BF_USE_DEPT_ID
    , V_BF_FIRST_USER
    , V_BF_SECOND_USER
    , V_BF_COST_CENTER_ID
    , N_DPR_SUM_DC_AMOUNT
    , N_IFRS_DPR_SUM_DC_AMOUNT
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
  END ASSET_HISTORY_INSERT;

-- 고정자산 변동내역 수정.
  PROCEDURE ASSET_HISTORY_UPDATE
            ( W_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            , W_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_CHARGE_DATE              IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
            , P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_CHARGE_ID                IN FI_ASSET_HISTORY.CHARGE_ID%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_HISTORY.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_HISTORY.EXCHANGE_RATE%TYPE
            , P_AMOUNT                   IN FI_ASSET_HISTORY.AMOUNT%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_HISTORY.CURR_AMOUNT%TYPE
            , P_QTY                      IN FI_ASSET_HISTORY.QTY%TYPE
            , P_LOCATION_ID              IN FI_ASSET_HISTORY.LOCATION_ID%TYPE
            , P_USE_DEPT_ID              IN FI_ASSET_HISTORY.USE_DEPT_ID%TYPE
            , P_FIRST_USER               IN FI_ASSET_HISTORY.FIRST_USER%TYPE
            , P_SECOND_USER              IN FI_ASSET_HISTORY.SECOND_USER%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_HISTORY.COST_CENTER_ID%TYPE
            , P_BF_AMOUNT                IN FI_ASSET_HISTORY.BF_AMOUNT%TYPE
            , P_BF_CURR_AMOUNT           IN FI_ASSET_HISTORY.BF_CURR_AMOUNT%TYPE
            , P_BF_QTY                   IN FI_ASSET_HISTORY.BF_QTY%TYPE
            , P_BF_LOCATION_ID           IN FI_ASSET_HISTORY.BF_LOCATION_ID%TYPE
            , P_BF_USE_DEPT_ID           IN FI_ASSET_HISTORY.BF_USE_DEPT_ID%TYPE
            , P_BF_FIRST_USER            IN FI_ASSET_HISTORY.BF_FIRST_USER%TYPE
            , P_BF_SECOND_USER           IN FI_ASSET_HISTORY.BF_SECOND_USER%TYPE
            , P_BF_COST_CENTER_ID        IN FI_ASSET_HISTORY.BF_COST_CENTER_ID%TYPE
            , P_DESCRIPTION              IN FI_ASSET_HISTORY.DESCRIPTION%TYPE
            , P_USER_ID                  IN FI_ASSET_HISTORY.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                            DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CHARGE_CODE                        FI_COMMON.CODE%TYPE;
    N_DPR_SUM_DC_AMOUNT                  NUMBER := 0;
    N_IFRS_DPR_SUM_DC_AMOUNT             NUMBER := 0;
  BEGIN
    V_CHARGE_CODE := FI_COMMON_G.GET_CODE_F(P_CHARGE_ID, W_SOB_ID);
    -- 자산매각/폐기시 충당금감소액 계산.
    IF V_CHARGE_CODE IN('90', '91') THEN
      N_DPR_SUM_DC_AMOUNT := DPR_DC_AMOUNT_F
          ( P_ASSET_ID
          , '10'
          , P_CHARGE_DATE
          , P_AMOUNT
          , W_SOB_ID
          );
      N_IFRS_DPR_SUM_DC_AMOUNT := DPR_DC_AMOUNT_F
          ( P_ASSET_ID
          , '20'
          , P_CHARGE_DATE
          , P_AMOUNT
          , W_SOB_ID
          );  
    END IF;
    
    UPDATE FI_ASSET_HISTORY AH
      SET AH.CHARGE_DATE              = P_CHARGE_DATE
        , AH.CHARGE_ID                = P_CHARGE_ID
        , AH.CURRENCY_CODE            = P_CURRENCY_CODE
        , AH.EXCHANGE_RATE            = P_EXCHANGE_RATE
        , AH.AMOUNT                   = P_AMOUNT
        , AH.CURR_AMOUNT              = P_CURR_AMOUNT
        , AH.QTY                      = P_QTY        
        , AH.LOCATION_ID              = P_LOCATION_ID
        , AH.USE_DEPT_ID              = P_USE_DEPT_ID
        , AH.FIRST_USER               = P_FIRST_USER
        , AH.SECOND_USER              = P_SECOND_USER
        , AH.COST_CENTER_ID           = P_COST_CENTER_ID
        , AH.BF_AMOUNT                = P_BF_AMOUNT
        , AH.BF_CURR_AMOUNT           = P_BF_CURR_AMOUNT
        , AH.BF_QTY                   = P_BF_QTY
        , AH.BF_LOCATION_ID           = P_BF_LOCATION_ID
        , AH.BF_USE_DEPT_ID           = P_BF_USE_DEPT_ID
        , AH.BF_FIRST_USER            = P_BF_FIRST_USER
        , AH.BF_SECOND_USER           = P_BF_SECOND_USER
        , AH.BF_COST_CENTER_ID        = P_BF_COST_CENTER_ID
        , AH.DPR_SUM_DC_AMOUNT        = N_DPR_SUM_DC_AMOUNT
        , AH.IFRS_DPR_SUM_DC_AMOUNT   = N_IFRS_DPR_SUM_DC_AMOUNT
        , AH.DESCRIPTION              = P_DESCRIPTION
        , AH.LAST_UPDATE_DATE         = V_SYSDATE
        , AH.LAST_UPDATED_BY          = P_USER_ID        
    WHERE AH.HISTORY_NUM            = W_HISTORY_NUM
      AND AH.SOB_ID                 = W_SOB_ID
    ;
  END ASSET_HISTORY_UPDATE;

-- 고정자산 변동내역 삭제.
  PROCEDURE ASSET_HISTORY_DELETE
            ( W_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            )
  AS
  BEGIN
    DELETE FI_ASSET_HISTORY AH      
    WHERE AH.HISTORY_NUM            = W_HISTORY_NUM
    ;
  END ASSET_HISTORY_DELETE;

-- 고정자산 충당금 당기감소액 계산.
  FUNCTION DPR_DC_AMOUNT_F
           ( W_ASSET_ID                  IN FI_ASSET_MASTER.ASSET_ID%TYPE
           , W_DPR_TYPE                  IN VARCHAR2
           , P_CHARGE_DATE               IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
           , P_AMOUNT                    IN FI_ASSET_HISTORY.AMOUNT%TYPE
           , W_SOB_ID                    IN FI_ASSET_HISTORY.SOB_ID%TYPE
           ) RETURN NUMBER
  AS
    V_DPR_DC_AMOUNT                      NUMBER := 0;
    
    V_ACQUIRE_DATE                       FI_ASSET_MASTER.ACQUIRE_DATE%TYPE;       -- 취득일자.
    V_ACQUIRE_AMOUNT                     FI_ASSET_MASTER.AMOUNT%TYPE := 0;        -- 취득금액.
    V_ADD_AMOUNT                         NUMBER := 0;                             -- 가감 금액.
    V_PROGRESS_YEAR                      FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE := 0;   -- 상각년수.
    V_DPR_METHOD_TYPE                    FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE;
    
    V_DPR_RATE                           NUMBER := 0;                             -- 상각율.
    V_BOOK_AMOUNT                        NUMBER := 0;                             -- 장부가액.
    V_PRE_DPR_SUM_AMOUNT                 NUMBER;                                  -- 전기충당금.
    V_MONTH_COUNT                        NUMBER := 0;                             -- 1월 ~매각 월 : 월수.
    V_TOTAL_MONTH_COUNT                  NUMBER := 0;                             -- 총 내용연수의 월수.
    
  BEGIN
    -- 자산 정보.
    BEGIN
      SELECT AM.ACQUIRE_DATE
           , AM.AMOUNT
           , CASE
               WHEN W_DPR_TYPE = '20' THEN AM.IFRS_DPR_METHOD_TYPE
               ELSE AM.DPR_METHOD_TYPE
             END AS DPR_METHOD_TYPE
           , CASE 
               WHEN W_DPR_TYPE = '20' THEN AM.IFRS_PROGRESS_YEAR
               ELSE AM.DPR_PROGRESS_YEAR
             END AS PROGRESS_YEAR
        INTO V_ACQUIRE_DATE
           , V_ACQUIRE_AMOUNT
           , V_DPR_METHOD_TYPE
           , V_PROGRESS_YEAR
        FROM FI_ASSET_MASTER AM
      WHERE AM.ASSET_ID         = W_ASSET_ID
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        V_DPR_DC_AMOUNT := 0;
        RETURN V_DPR_DC_AMOUNT;
    END;  
    -- 2.자본적 지출이 있을 경우 적용함.
    V_ADD_AMOUNT := 0;
    BEGIN
      SELECT NVL(SUM(AH.AMOUNT), 0) AS AMOUNT
        INTO V_ADD_AMOUNT
        FROM FI_ASSET_HISTORY AH
      WHERE AH.ASSET_ID                 = W_ASSET_ID
        AND AH.SOB_ID                   = W_SOB_ID
        AND AH.CHARGE_DATE              < P_CHARGE_DATE
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                       AND FC.COMMON_ID   = AH.CHARGE_ID
                       AND FC.SOB_ID      = AH.SOB_ID
                       AND FC.CODE        = '10'
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADD_AMOUNT := 0;
    END;
    V_ACQUIRE_AMOUNT := NVL(V_ACQUIRE_AMOUNT, 0) + NVL(V_ADD_AMOUNT, 0);
      
    -- 3.자산매각이 있을 경우 적용함.
    BEGIN
      SELECT NVL(SUM(AH.AMOUNT), 0) AS AMOUNT
        INTO V_ADD_AMOUNT
        FROM FI_ASSET_HISTORY AH
      WHERE AH.ASSET_ID                 = W_ASSET_ID
        AND AH.SOB_ID                   = W_SOB_ID
        AND AH.CHARGE_DATE              < P_CHARGE_DATE
        AND EXISTS ( SELECT 'X'
                       FROM FI_COMMON FC
                     WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                       AND FC.COMMON_ID   = AH.CHARGE_ID
                       AND FC.SOB_ID      = AH.SOB_ID
                       AND FC.CODE        IN('90', '91')
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADD_AMOUNT := 0;
    END;
    V_ACQUIRE_AMOUNT := NVL(V_ACQUIRE_AMOUNT, 0) - NVL(V_ADD_AMOUNT, 0);
      
    -- 전기충당금/전년말 장부가액 산출.
    BEGIN
      SELECT ADH.DPR_SUM_AMOUNT
           , ADH.UN_DPR_REMAIN_AMOUNT
        INTO V_PRE_DPR_SUM_AMOUNT
           , V_BOOK_AMOUNT
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.PERIOD_NAME       = TO_CHAR(TRUNC(P_CHARGE_DATE, 'YEAR') - 1, 'YYYY-MM')
        AND ADH.ASSET_ID          = W_ASSET_ID
        AND ADH.SOB_ID            = W_SOB_ID
        AND ADH.DPR_TYPE          = W_DPR_TYPE
        AND ROWNUM                <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_BOOK_AMOUNT := -1;
        V_PRE_DPR_SUM_AMOUNT := 0;
    END;
    -- 전년말 장부가액 없을 경우 취득원가 적용(매각 이전 발생한 자본적 지출/부분매각 금액 반영)
    IF V_BOOK_AMOUNT = -1 THEN
      -- 1.취득금액 적용.
      V_BOOK_AMOUNT := V_ACQUIRE_AMOUNT;
    END IF;
    
    -- 당기 감소액 계산 : 정율 --
    IF V_DPR_METHOD_TYPE = '2' THEN
      -- 취득 경과 월수(년도1월 ~ 매각 년월).
      BEGIN
        V_MONTH_COUNT := MONTHS_BETWEEN(TRUNC(P_CHARGE_DATE, 'MONTH'), TRUNC(P_CHARGE_DATE, 'YEAR')) + 1;
      EXCEPTION
        WHEN OTHERS THEN
          V_MONTH_COUNT := 0;
      END;
      
      -- 상각율.
      BEGIN
        SELECT DR.DPR_RATE
          INTO V_DPR_RATE
          FROM FI_DPR_RATE DR
        WHERE DR.DPR_TYPE       = W_DPR_TYPE
          AND DR.SOB_ID         = W_SOB_ID
          AND DR.PROGRESS_YEAR  = V_PROGRESS_YEAR
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DPR_RATE := 0;
      END;
      
      V_DPR_DC_AMOUNT := NVL(V_PRE_DPR_SUM_AMOUNT, 0) * NVL(P_AMOUNT, 0) / NVL(V_ACQUIRE_AMOUNT, 0)
                        + ((NVL(V_BOOK_AMOUNT, 0) * NVL(V_DPR_RATE, 0) * NVL(P_AMOUNT, 0) / NVL(V_ACQUIRE_AMOUNT, 0)) * NVL(V_MONTH_COUNT, 0) / 12);
      
    ELSE
    -- 당기 감소액 계산 : 정액 --
      V_TOTAL_MONTH_COUNT := V_PROGRESS_YEAR * 12;    -- 총 내용연수 월수.
      -- 취득 경과 월수.
      BEGIN
        V_MONTH_COUNT := MONTHS_BETWEEN(TRUNC(P_CHARGE_DATE, 'MONTH'), TRUNC(V_ACQUIRE_DATE, 'MONTH')) + 1;
      EXCEPTION
        WHEN OTHERS THEN
          V_MONTH_COUNT := 0;
      END;
      
      V_DPR_DC_AMOUNT := NVL(V_ACQUIRE_AMOUNT, 0) * (NVL(V_MONTH_COUNT, 0) / NVL(V_TOTAL_MONTH_COUNT, 1)) *
                         (NVL(P_AMOUNT, 0) / NVL(V_ACQUIRE_AMOUNT, 0));
    END IF;
    -- 취득가액과 매각 금액이 동일할 경우 현재까지 상각누계액을 충당금 감소액으로 적용.
    IF NVL(V_ACQUIRE_AMOUNT, 0) = NVL(P_AMOUNT, 0) THEN
      BEGIN
        SELECT ADH.DPR_SUM_AMOUNT
          INTO V_DPR_DC_AMOUNT
          FROM FI_ASSET_DPR_HISTORY ADH
        WHERE ADH.ASSET_ID          = W_ASSET_ID
          AND ADH.SOB_ID            = W_SOB_ID
          AND ADH.DPR_TYPE          = W_DPR_TYPE
          AND ADH.PERIOD_NAME IN ( SELECT MAX(DH.PERIOD_NAME) AS PERIOD_NAME
                                     FROM FI_ASSET_DPR_HISTORY DH
                                   WHERE DH.PERIOD_NAME         <= TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
                                     AND DH.ASSET_ID            = ADH.ASSET_ID
                                     AND DH.DPR_TYPE            = ADH.DPR_TYPE
                                     AND DH.SOB_ID              = ADH.SOB_ID
                                  )
        ;
      EXCEPTION
        WHEN OTHERS THEN
          NULL;
      END;
    END IF;
    RETURN ROUND(V_DPR_DC_AMOUNT, 0);
    
  END DPR_DC_AMOUNT_F;
  
-- 트리거 이벤트 --
  PROCEDURE ASSET_MASTER_UPDATE
            ( P_GB                       IN VARCHAR2
            , P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_HISTORY.ORG_ID%TYPE
            , P_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            , P_CHARGE_DATE              IN FI_ASSET_HISTORY.CHARGE_DATE%TYPE
            , P_CHARGE_ID                IN FI_ASSET_HISTORY.CHARGE_ID%TYPE
            , P_CHARGE_CODE              IN VARCHAR2
            , P_CURR_AMOUNT              IN NUMBER
            , P_AMOUNT                   IN NUMBER
            , P_DPR_DC_AMOUNT            IN NUMBER
            , P_IFRS_DPR_DC_AMOUNT       IN NUMBER
            , P_LOCATION_ID              IN FI_ASSET_HISTORY.LOCATION_ID%TYPE
            , P_USE_DEPT_ID              IN FI_ASSET_HISTORY.USE_DEPT_ID%TYPE
            , P_FIRST_USER               IN FI_ASSET_HISTORY.FIRST_USER%TYPE
            , P_SECOND_USER              IN FI_ASSET_HISTORY.SECOND_USER%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_HISTORY.COST_CENTER_ID%TYPE
            , P_USER_ID                  IN FI_ASSET_HISTORY.CREATED_BY%TYPE 
            )
  AS
    V_ASSET_CATEGORY_ID                  NUMBER;
    V_DPR_YN                             VARCHAR2(2);
    V_DPR_METHOD_TYPE                    VARCHAR2(10);
    V_DPR_PROGRESS_YEAR                  NUMBER;
    V_RESIDUAL_AMOUNT                    NUMBER;
    
    V_IFRS_DPR_YN                        VARCHAR2(2);
    V_IFRS_DPR_METHOD_TYPE               VARCHAR2(10);
    V_IFRS_DPR_PROGRESS_YEAR             NUMBER;
    V_IFRS_RESIDUAL_AMOUNT               NUMBER;
    
    V_HISTORY_NUM_SEQ                    NUMBER;
    
  BEGIN
    -- 자산정보.
    BEGIN
      SELECT AM.AST_CATEGORY_ID
           , AM.DPR_YN
           , AM.DPR_METHOD_TYPE
           , AM.DPR_PROGRESS_YEAR
           , AM.RESIDUAL_AMOUNT
           , AM.IFRS_DPR_YN
           , AM.IFRS_DPR_METHOD_TYPE
           , AM.IFRS_PROGRESS_YEAR
           , AM.IFRS_RESIDUAL_AMOUNT
        INTO V_ASSET_CATEGORY_ID
           , V_DPR_YN
           , V_DPR_METHOD_TYPE
           , V_DPR_PROGRESS_YEAR
           , V_RESIDUAL_AMOUNT
           , V_IFRS_DPR_YN
           , V_IFRS_DPR_METHOD_TYPE
           , V_IFRS_DPR_PROGRESS_YEAR
           , V_IFRS_RESIDUAL_AMOUNT
        FROM FI_ASSET_MASTER AM
      WHERE AM.ASSET_ID                 = P_ASSET_ID
        AND AM.SOB_ID                   = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DPR_YN := 'N';
      V_IFRS_DPR_YN := 'N';
    END;
    
    IF P_GB IN('I', 'U') THEN
    -- 신규--.
      -- 감가비 로그 삭제.
      DELETE FROM FI_ASSET_DPR_HISTORY_LOG ADH
      WHERE ADH.SOB_ID          = P_SOB_ID
        AND ADH.ASSET_ID        = P_ASSET_ID
        AND ADH.HISTORY_NUM     = P_HISTORY_NUM
      ;
        
      BEGIN
        SELECT NVL(COUNT(DISTINCT ADH.HISTORY_NUM), 0) + 1 AS HISTORY_NUM_SEQ
          INTO V_HISTORY_NUM_SEQ
          FROM FI_ASSET_DPR_HISTORY_LOG ADH
        WHERE ADH.SOB_ID          = P_SOB_ID
          AND ADH.ASSET_ID        = P_ASSET_ID
        ;        
      EXCEPTION WHEN OTHERS THEN
        V_HISTORY_NUM_SEQ := 1; 
      END;
      -- 감가상각비 삭제전 로그 INSERT.
      INSERT INTO FI_ASSET_DPR_HISTORY_LOG
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
      , HISTORY_NUM 
      , HISTORY_NUM_SEQ
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY    
      ) 
      SELECT  ADH.PERIOD_NAME
          , ADH.SOB_ID
          , ADH.ORG_ID
          , ADH.DPR_TYPE
          , ADH.ASSET_ID
          , ADH.ASSET_CATEGORY_ID
          , ADH.SOURCE_CURR_AMOUNT
          , ADH.SOURCE_AMOUNT
          , ADH.SOURCE_ADD_CURR_AMOUNT
          , ADH.SOURCE_ADD_AMOUNT
          , ADH.DPR_METHOD_TYPE
          , ADH.DPR_PROGRESS_YEAR
          , ADH.DPR_RATE     
          , ADH.DPR_CURR_AMOUNT
          , ADH.DPR_AMOUNT
          , ADH.DPR_COUNT
          , ADH.DPR_YEAR_CURR_AMOUNT
          , ADH.DPR_YEAR_AMOUNT
          , ADH.DPR_SUM_CURR_AMOUNT
          , ADH.DPR_SUM_AMOUNT
          , ADH.UN_DPR_REMAIN_CURR_AMOUNT
          , ADH.UN_DPR_REMAIN_AMOUNT
          , P_HISTORY_NUM
          , V_HISTORY_NUM_SEQ
          , ADH.CREATION_DATE
          , ADH.CREATED_BY
          , ADH.LAST_UPDATE_DATE
          , ADH.LAST_UPDATED_BY
        FROM FI_ASSET_DPR_HISTORY ADH
      WHERE ADH.PERIOD_NAME     > TO_CHAR(P_CHARGE_DATE, 'YYYY-MM')
        AND ADH.SOB_ID          = P_SOB_ID
        AND ADH.ASSET_ID        = P_ASSET_ID
      ;
        
      IF P_CHARGE_CODE IN ('90', '91') THEN
      -- 자산 폐기/매각.
        UPDATE FI_ASSET_MASTER AM
          SET AM.LOCATION_ID        = P_LOCATION_ID
            , AM.USE_DEPT_ID        = P_USE_DEPT_ID
            , AM.FIRST_USER         = P_FIRST_USER
            , AM.SECOND_USER        = P_SECOND_USER
            , AM.COST_CENTER_ID     = P_COST_CENTER_ID
            , AM.DISUSE_DATE        = P_CHARGE_DATE
            , AM.ASSET_STATUS_CODE  = DECODE(P_CHARGE_CODE, '90', '90', '80')               -- 자산상태.
            , AM.LAST_UPDATE_DATE   = GET_LOCAL_DATE(AM.SOB_ID)
            , AM.LAST_UPDATED_BY    = P_USER_ID
        WHERE AM.ASSET_ID           = P_ASSET_ID
        ;
        IF V_DPR_YN = 'Y' THEN
          -- 내부회계.
          FI_ASSET_DPR_HISTORY_SET_G.DPR_SELL_OUT_SET
            ( P_ASSET_ID 
            , V_ASSET_CATEGORY_ID
            , '10'
            , P_CHARGE_DATE
            , P_CHARGE_CODE
            , P_CURR_AMOUNT
            , P_AMOUNT            
            , V_DPR_METHOD_TYPE
            , V_DPR_PROGRESS_YEAR
            , V_RESIDUAL_AMOUNT
            , P_DPR_DC_AMOUNT
            , P_SOB_ID
            , P_ORG_ID
            , P_USER_ID
            );
            
          -- IFRS.
          FI_ASSET_DPR_HISTORY_SET_G.DPR_SELL_OUT_SET
            ( P_ASSET_ID 
            , V_ASSET_CATEGORY_ID
            , '20'
            , ADD_MONTHS(P_CHARGE_DATE, 1)
            , P_CHARGE_CODE
            , P_CURR_AMOUNT
            , P_AMOUNT            
            , V_DPR_METHOD_TYPE
            , V_DPR_PROGRESS_YEAR
            , V_RESIDUAL_AMOUNT
            , P_DPR_DC_AMOUNT
            , P_SOB_ID
            , P_ORG_ID
            , P_USER_ID
            );  
        END IF;
      ELSE
      -- 그외.
        IF P_CHARGE_CODE = '10' THEN
        -- 자산 자본적 지출 -> 감가 처리.
          IF V_DPR_YN = 'Y' THEN
            -- 내부회계.
            FI_ASSET_DPR_HISTORY_SET_G.DPR_CE_SET
              ( P_ASSET_ID 
              , V_ASSET_CATEGORY_ID
              , '10'
              , P_CHARGE_DATE
              , P_CHARGE_CODE
              , P_CURR_AMOUNT
              , P_AMOUNT            
              , V_DPR_METHOD_TYPE
              , V_DPR_PROGRESS_YEAR
              , V_RESIDUAL_AMOUNT
              , P_SOB_ID
              , P_ORG_ID
              , P_USER_ID
              );
            
            -- IFRS.
            FI_ASSET_DPR_HISTORY_SET_G.DPR_CE_SET
              ( P_ASSET_ID 
              , V_ASSET_CATEGORY_ID
              , '20'
              , P_CHARGE_DATE
              , P_CHARGE_CODE
              , P_CURR_AMOUNT
              , P_AMOUNT            
              , V_DPR_METHOD_TYPE
              , V_DPR_PROGRESS_YEAR
              , V_RESIDUAL_AMOUNT
              , P_SOB_ID
              , P_ORG_ID
              , P_USER_ID
              );  
          END IF;
        END IF;
        
        UPDATE FI_ASSET_MASTER AM
          SET AM.LOCATION_ID        = P_LOCATION_ID
            , AM.USE_DEPT_ID        = P_USE_DEPT_ID
            , AM.FIRST_USER         = P_FIRST_USER
            , AM.SECOND_USER        = P_SECOND_USER
            , AM.COST_CENTER_ID     = P_COST_CENTER_ID
            , AM.LAST_UPDATE_DATE   = GET_LOCAL_DATE(AM.SOB_ID)
            , AM.LAST_UPDATED_BY    = P_USER_ID
        WHERE AM.ASSET_ID         = P_ASSET_ID
        ;
      END IF;
---------------------------------------------------------------------------------------------------   
    ELSE
    -- 삭제(취소).
      IF P_CHARGE_CODE IN ('90', '91') THEN
      -- 자산 폐기/매각.
        UPDATE FI_ASSET_MASTER AM
          SET AM.DISUSE_DATE        = NULL
            , AM.ASSET_STATUS_CODE  = '10'               -- 자산상태.
        WHERE AM.ASSET_ID           = P_ASSET_ID
        ;                
      END IF;
      -- 내부회계.
      ASSET_HISTORY_CANCEL
      ( P_ASSET_ID
      , P_SOB_ID
      , '10'
      , P_HISTORY_NUM
      );
      -- IFRS.
      ASSET_HISTORY_CANCEL
      ( P_ASSET_ID
      , P_SOB_ID
      , '20'
      , P_HISTORY_NUM
      );
          
      UPDATE FI_ASSET_MASTER AM
        SET AM.LOCATION_ID        = P_LOCATION_ID
          , AM.USE_DEPT_ID        = P_USE_DEPT_ID
          , AM.FIRST_USER         = P_FIRST_USER
          , AM.SECOND_USER        = P_SECOND_USER
          , AM.COST_CENTER_ID     = P_COST_CENTER_ID
          , AM.LAST_UPDATE_DATE   = GET_LOCAL_DATE(AM.SOB_ID)
          , AM.LAST_UPDATED_BY    = P_USER_ID
      WHERE AM.ASSET_ID           = P_ASSET_ID
      ;
    END IF;
    
  END ASSET_MASTER_UPDATE;

  PROCEDURE ASSET_HISTORY_CANCEL
            ( P_ASSET_ID                 IN FI_ASSET_HISTORY.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_HISTORY.SOB_ID%TYPE
            , P_DPR_TYPE                 IN FI_ASSET_DPR_HISTORY.DPR_TYPE%TYPE
            , P_HISTORY_NUM              IN FI_ASSET_HISTORY.HISTORY_NUM%TYPE
            )
  AS
  BEGIN
    FOR C1 IN (SELECT ADHL.PERIOD_NAME
                   , ADHL.SOB_ID
                   , ADHL.ORG_ID
                   , ADHL.DPR_TYPE
                   , ADHL.ASSET_ID
                   , ADHL.ASSET_CATEGORY_ID
                   , ADHL.SOURCE_CURR_AMOUNT
                   , ADHL.SOURCE_AMOUNT
                   , ADHL.SOURCE_ADD_CURR_AMOUNT
                   , ADHL.SOURCE_ADD_AMOUNT
                   , ADHL.DPR_METHOD_TYPE
                   , ADHL.DPR_PROGRESS_YEAR
                   , ADHL.DPR_RATE
                   , ADHL.DPR_CURR_AMOUNT
                   , ADHL.DPR_AMOUNT
                   , ADHL.SP_DPR_CURR_AMOUNT
                   , ADHL.SP_DPR_AMOUNT
                   , ADHL.DPR_COUNT
                   , ADHL.DPR_YEAR_CURR_AMOUNT
                   , ADHL.DPR_YEAR_AMOUNT
                   , ADHL.DPR_SUM_CURR_AMOUNT
                   , ADHL.DPR_SUM_AMOUNT
                   , ADHL.UN_DPR_REMAIN_CURR_AMOUNT
                   , ADHL.UN_DPR_REMAIN_AMOUNT
                   , ADHL.ASSET_MASTER_YN
                   , ADHL.DISUSE_YN
                   , ADHL.SLIP_YN
                   , ADHL.SLIP_DATE
                   , ADHL.SLIP_LINE_ID
                   , ADHL.REMARK
                   , ADHL.CREATION_DATE
                   , ADHL.CREATED_BY
                   , ADHL.LAST_UPDATE_DATE
                   , ADHL.LAST_UPDATED_BY
                FROM FI_ASSET_DPR_HISTORY_LOG ADHL
              WHERE ADHL.ASSET_ID             = P_ASSET_ID
                AND ADHL.SOB_ID               = P_SOB_ID
                AND ADHL.DPR_TYPE             = P_DPR_TYPE
                AND ADHL.HISTORY_NUM          = P_HISTORY_NUM
              ORDER BY ADHL.DPR_COUNT
              )
    LOOP
      UPDATE FI_ASSET_DPR_HISTORY ADH
        SET ASSET_CATEGORY_ID           = C1.ASSET_CATEGORY_ID
          , SOURCE_CURR_AMOUNT          = C1.SOURCE_CURR_AMOUNT
          , SOURCE_AMOUNT               = C1.SOURCE_AMOUNT
          , SOURCE_ADD_CURR_AMOUNT      = C1.SOURCE_ADD_CURR_AMOUNT
          , SOURCE_ADD_AMOUNT           = C1.SOURCE_ADD_AMOUNT
          , DPR_METHOD_TYPE             = C1.DPR_METHOD_TYPE
          , DPR_PROGRESS_YEAR           = C1.DPR_PROGRESS_YEAR
          , DPR_RATE                    = C1.DPR_RATE
          , DPR_CURR_AMOUNT             = C1.DPR_CURR_AMOUNT
          , DPR_AMOUNT                  = C1.DPR_AMOUNT
          , SP_DPR_CURR_AMOUNT          = C1.SP_DPR_CURR_AMOUNT
          , SP_DPR_AMOUNT               = C1.SP_DPR_AMOUNT
          , DPR_COUNT                   = C1.DPR_COUNT
          , DPR_YEAR_CURR_AMOUNT        = C1.DPR_YEAR_CURR_AMOUNT 
          , DPR_YEAR_AMOUNT             = C1.DPR_YEAR_AMOUNT
          , DPR_SUM_CURR_AMOUNT         = C1.DPR_SUM_CURR_AMOUNT
          , DPR_SUM_AMOUNT              = C1.DPR_SUM_AMOUNT
          , UN_DPR_REMAIN_CURR_AMOUNT   = C1.UN_DPR_REMAIN_CURR_AMOUNT
          , UN_DPR_REMAIN_AMOUNT        = C1.UN_DPR_REMAIN_AMOUNT
          , ASSET_MASTER_YN             = C1.ASSET_MASTER_YN
          , DISUSE_YN                   = C1.DISUSE_YN
          , SLIP_YN                     = C1.SLIP_YN
          , SLIP_DATE                   = C1.SLIP_DATE
          , SLIP_LINE_ID                = C1.SLIP_LINE_ID
          , REMARK                      = C1.REMARK
          , CREATION_DATE               = C1.CREATION_DATE
          , CREATED_BY                  = C1.CREATED_BY
          , LAST_UPDATE_DATE            = C1.LAST_UPDATE_DATE
          , LAST_UPDATED_BY             = C1.LAST_UPDATED_BY
      WHERE ADH.PERIOD_NAME       = C1.PERIOD_NAME
        AND ADH.SOB_ID            = C1.SOB_ID
        AND ADH.ASSET_ID          = C1.ASSET_ID
        AND ADH.DPR_TYPE          = C1.DPR_TYPE
      ;
      IF SQL%ROWCOUNT = 0 THEN
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
        , SP_DPR_CURR_AMOUNT
        , SP_DPR_AMOUNT
        , DPR_COUNT
        , DPR_YEAR_CURR_AMOUNT
        , DPR_YEAR_AMOUNT
        , DPR_SUM_CURR_AMOUNT
        , DPR_SUM_AMOUNT
        , UN_DPR_REMAIN_CURR_AMOUNT
        , UN_DPR_REMAIN_AMOUNT
        , ASSET_MASTER_YN
        , DISUSE_YN
        , SLIP_YN
        , SLIP_DATE
        , SLIP_LINE_ID
        , REMARK
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY    
        ) VALUES
        ( C1.PERIOD_NAME
        , C1.SOB_ID
        , C1.ORG_ID
        , C1.DPR_TYPE
        , C1.ASSET_ID
        , C1.ASSET_CATEGORY_ID
        , C1.SOURCE_CURR_AMOUNT
        , C1.SOURCE_AMOUNT
        , C1.SOURCE_ADD_CURR_AMOUNT
        , C1.SOURCE_ADD_AMOUNT
        , C1.DPR_METHOD_TYPE
        , C1.DPR_PROGRESS_YEAR
        , C1.DPR_RATE     
        , C1.DPR_CURR_AMOUNT
        , C1.DPR_AMOUNT
        , C1.SP_DPR_CURR_AMOUNT
        , C1.SP_DPR_AMOUNT
        , C1.DPR_COUNT
        , C1.DPR_YEAR_CURR_AMOUNT
        , C1.DPR_YEAR_AMOUNT
        , C1.DPR_SUM_CURR_AMOUNT
        , C1.DPR_SUM_AMOUNT
        , C1.UN_DPR_REMAIN_CURR_AMOUNT
        , C1.UN_DPR_REMAIN_AMOUNT
        , C1.ASSET_MASTER_YN
        , C1.DISUSE_YN
        , C1.SLIP_YN
        , C1.SLIP_DATE
        , C1.SLIP_LINE_ID
        , C1.REMARK
        , C1.CREATION_DATE
        , C1.CREATED_BY
        , C1.LAST_UPDATE_DATE
        , C1.LAST_UPDATED_BY    
        );
      END IF;
    END LOOP C1;
    -- HISTORY LOG 삭제 --
    DELETE FROM FI_ASSET_DPR_HISTORY_LOG ADH
    WHERE ADH.HISTORY_NUM     = P_HISTORY_NUM
      AND ADH.SOB_ID          = P_SOB_ID
      AND ADH.ASSET_ID        = P_ASSET_ID
    ;
  END ASSET_HISTORY_CANCEL;
  
END FI_ASSET_HISTORY_G;
/
