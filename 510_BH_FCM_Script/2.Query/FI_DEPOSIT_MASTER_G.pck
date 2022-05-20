CREATE OR REPLACE PACKAGE FI_DEPOSIT_MASTER_G
AS
                               
  PROCEDURE MASTER_SELECT ( P_CURSOR            OUT TYPES.TCURSOR
                          , P_SOB_ID            IN  FI_DEPOSIT_MASTER.SOB_ID%TYPE
                          , P_BANK_ACCOUNT_ID   IN  FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE);
           
  PROCEDURE MASTER_INSERT
            ( P_BANK_ID                 IN FI_DEPOSIT_MASTER.BANK_ID%TYPE
            , P_BANK_ACCOUNT_ID          IN FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID                   IN FI_DEPOSIT_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_DEPOSIT_MASTER.ORG_ID%TYPE
            , P_DEPOSIT_GB               IN FI_DEPOSIT_MASTER.DEPOSIT_GB%TYPE
            , P_ACCOUNT_TYPE             IN FI_DEPOSIT_MASTER.ACCOUNT_TYPE%TYPE
            , P_ISSUE_DATE               IN FI_DEPOSIT_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                 IN FI_DEPOSIT_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE            IN FI_DEPOSIT_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_DEPOSIT_MASTER.EXCHANGE_RATE%TYPE
            , P_DEPOSIT_CURR_AMOUNT      IN FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT%TYPE
            , P_DEPOSIT_AMOUNT           IN FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT%TYPE
            , P_INTER_RATE               IN FI_DEPOSIT_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE              IN FI_DEPOSIT_MASTER.SPREAD_RATE%TYPE
            , P_INTER_KIND               IN FI_DEPOSIT_MASTER.INTER_KIND%TYPE
            , P_INTER_TYPE               IN FI_DEPOSIT_MASTER.INTER_TYPE%TYPE
            , P_PAYMENT_PERIOD           IN FI_DEPOSIT_MASTER.PAYMENT_PERIOD%TYPE            
            , P_MONTH_CURR_AMOUNT        IN FI_DEPOSIT_MASTER.MONTH_CURR_AMOUNT%TYPE
            , P_MONTH_AMOUNT             IN FI_DEPOSIT_MASTER.MONTH_AMOUNT%TYPE
            , P_CANCEL_DATE              IN FI_DEPOSIT_MASTER.CANCEL_DATE%TYPE
            , P_CANCEL_EXCHANGE_RATE     IN FI_DEPOSIT_MASTER.CANCEL_EXCHANGE_RATE%TYPE
            , P_CANCEL_PRIN_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_PRIN_AMOUNT%TYPE
            , P_CANCEL_PRIN_CURR_AMOUNT  IN FI_DEPOSIT_MASTER.CANCEL_PRIN_CURR_AMOUNT%TYPE
            , P_CANCEL_INTER_RATE        IN FI_DEPOSIT_MASTER.CANCEL_INTER_RATE%TYPE
            , P_CANCEL_INTER_AMOUNT      IN FI_DEPOSIT_MASTER.CANCEL_INTER_AMOUNT%TYPE
            , P_CANCEL_INTER_CURR_AMOUNT IN FI_DEPOSIT_MASTER.CANCEL_INTER_CURR_AMOUNT%TYPE
            , P_CANCEL_AMOUNT            IN FI_DEPOSIT_MASTER.CANCEL_AMOUNT%TYPE
            , P_CANCEL_CURR_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_CURR_AMOUNT%TYPE
            , P_MORTGAGE_YN              IN FI_DEPOSIT_MASTER.MORTGAGE_YN%TYPE
            , P_MORTGAGE_DATE            IN FI_DEPOSIT_MASTER.MORTGAGE_DATE%TYPE
            , P_TRANS_STATUS             IN FI_DEPOSIT_MASTER.TRANS_STATUS%TYPE
            , P_COST_CENTER_ID           IN FI_DEPOSIT_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                   IN FI_DEPOSIT_MASTER.REMARK%TYPE
            , P_ENABLED_FLAG             IN FI_DEPOSIT_MASTER.ENABLED_FLAG%TYPE
            , P_USER_ID                  IN FI_DEPOSIT_MASTER.CREATED_BY%TYPE 
            );

  PROCEDURE MASTER_UPDATE
            ( W_BANK_ID                  IN FI_DEPOSIT_MASTER.BANK_ID%TYPE
            , W_BANK_ACCOUNT_ID          IN FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE
            , W_SOB_ID                   IN FI_DEPOSIT_MASTER.SOB_ID%TYPE
            , W_ORG_ID                   IN FI_DEPOSIT_MASTER.ORG_ID%TYPE
            , P_DEPOSIT_GB               IN FI_DEPOSIT_MASTER.DEPOSIT_GB%TYPE
            , P_ACCOUNT_TYPE             IN FI_DEPOSIT_MASTER.ACCOUNT_TYPE%TYPE
            , P_ISSUE_DATE               IN FI_DEPOSIT_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                 IN FI_DEPOSIT_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE            IN FI_DEPOSIT_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_DEPOSIT_MASTER.EXCHANGE_RATE%TYPE
            , P_DEPOSIT_CURR_AMOUNT      IN FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT%TYPE
            , P_DEPOSIT_AMOUNT           IN FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT%TYPE
            , P_INTER_RATE               IN FI_DEPOSIT_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE              IN FI_DEPOSIT_MASTER.SPREAD_RATE%TYPE
            , P_INTER_KIND               IN FI_DEPOSIT_MASTER.INTER_KIND%TYPE
            , P_INTER_TYPE               IN FI_DEPOSIT_MASTER.INTER_TYPE%TYPE
            , P_PAYMENT_PERIOD           IN FI_DEPOSIT_MASTER.PAYMENT_PERIOD%TYPE
            , P_CANCEL_DATE              IN FI_DEPOSIT_MASTER.CANCEL_DATE%TYPE
            , P_CANCEL_EXCHANGE_RATE     IN FI_DEPOSIT_MASTER.CANCEL_EXCHANGE_RATE%TYPE
            , P_CANCEL_PRIN_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_PRIN_AMOUNT%TYPE
            , P_CANCEL_PRIN_CURR_AMOUNT  IN FI_DEPOSIT_MASTER.CANCEL_PRIN_CURR_AMOUNT%TYPE
            , P_CANCEL_INTER_RATE        IN FI_DEPOSIT_MASTER.CANCEL_INTER_RATE%TYPE
            , P_CANCEL_INTER_AMOUNT      IN FI_DEPOSIT_MASTER.CANCEL_INTER_AMOUNT%TYPE
            , P_CANCEL_INTER_CURR_AMOUNT IN FI_DEPOSIT_MASTER.CANCEL_INTER_CURR_AMOUNT%TYPE
            , P_CANCEL_AMOUNT            IN FI_DEPOSIT_MASTER.CANCEL_AMOUNT%TYPE
            , P_CANCEL_CURR_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_CURR_AMOUNT%TYPE
            , P_MORTGAGE_YN              IN FI_DEPOSIT_MASTER.MORTGAGE_YN%TYPE
            , P_MORTGAGE_DATE            IN FI_DEPOSIT_MASTER.MORTGAGE_DATE%TYPE
            , P_TRANS_STATUS             IN FI_DEPOSIT_MASTER.TRANS_STATUS%TYPE
            , P_COST_CENTER_ID           IN FI_DEPOSIT_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                   IN FI_DEPOSIT_MASTER.REMARK%TYPE
            , P_ENABLED_FLAG             IN FI_DEPOSIT_MASTER.ENABLED_FLAG%TYPE
            , P_USER_ID                  IN FI_DEPOSIT_MASTER.CREATED_BY%TYPE 
            );
                                                                      
-- ������ ���� ����(��ǥ --> ������ ����).
  PROCEDURE DEPOSIT_SAVE
            ( P_GB                    IN VARCHAR2
            , P_BANK_ACCOUNT_ID       IN FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE
            , P_ACCOUNT_CODE          IN VARCHAR2
            , P_SOB_ID                IN FI_DEPOSIT_MASTER.SOB_ID%TYPE
            , P_ORG_ID                IN FI_DEPOSIT_MASTER.ORG_ID%TYPE
            , P_ISSUE_DATE            IN FI_DEPOSIT_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE              IN FI_DEPOSIT_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE         IN FI_DEPOSIT_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE         IN FI_DEPOSIT_MASTER.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT           IN FI_DEPOSIT_MASTER.TOTAL_CURR_AMOUNT%TYPE       -- ���� �Ա�.
            , P_AMOUNT                IN FI_DEPOSIT_MASTER.TOTAL_AMOUNT%TYPE            -- ���� �Ա�.
            , P_DEPOSIT_CURR_AMOUNT   IN FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT%TYPE     -- �����ݾ�.
            , P_DEPOSIT_AMOUNT        IN FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT%TYPE          -- �����ݾ�.
            , P_MONTH_CURR_AMOUNT     IN FI_DEPOSIT_MASTER.MONTH_CURR_AMOUNT%TYPE       -- �����Ծ�.
            , P_MONTH_AMOUNT          IN FI_DEPOSIT_MASTER.MONTH_AMOUNT%TYPE            -- �����Ծ�.
            , P_INTER_RATE            IN FI_DEPOSIT_MASTER.INTER_RATE%TYPE
            , P_USER_ID               IN FI_DEPOSIT_MASTER.CREATED_BY%TYPE
            );

END FI_DEPOSIT_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DEPOSIT_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_DEPOSIT_MASTER_G
/* Description  : ������ ���� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/

  PROCEDURE MASTER_SELECT ( P_CURSOR            OUT TYPES.TCURSOR
                          , P_SOB_ID            IN  FI_DEPOSIT_MASTER.SOB_ID%TYPE
                          , P_BANK_ACCOUNT_ID   IN  FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE)
                          
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FDM.SOB_ID
           , FDM.ORG_ID
           , FDM.BANK_ID
           , FB.BANK_CODE
           , FB.BANK_NAME
           , FDM.BANK_ACCOUNT_ID
           , FBA.BANK_ACCOUNT_CODE
           , FBA.BANK_ACCOUNT_NAME
           , FBA.BANK_ACCOUNT_NUM
           , FBA.OWNER_NAME
           , FDM.DEPOSIT_GB
           , FI_COMMON_G.CODE_NAME_F('DEPOSIT_GB', FDM.DEPOSIT_GB, FDM.SOB_ID) AS DEPOSIT_GB_NAME
           , FDM.ACCOUNT_TYPE
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_TYPE', FDM.ACCOUNT_TYPE, FDM.SOB_ID) AS ACCOUNT_TYPE_NAME
           , FDM.ISSUE_DATE
           , FDM.DUE_DATE
           , FDM.CURRENCY_CODE
           , FDM.EXCHANGE_RATE
           , FDM.DEPOSIT_CURR_AMOUNT
           , FDM.DEPOSIT_AMOUNT
           , FDM.INTER_RATE
           , FDM.SPREAD_RATE
           , FDM.INTER_KIND
           , FDM.INTER_TYPE
           , FDM.PAYMENT_PERIOD
           , FDM.PAYMENT_COUNT
           , FDM.MONTH_CURR_AMOUNT
           , FDM.MONTH_AMOUNT
           , FDM.TOTAL_PAYMENT_COUNT
           , FDM.TOTAL_CURR_AMOUNT
           , FDM.TOTAL_AMOUNT
           , FDM.CANCEL_DATE
           , FDM.CANCEL_EXCHANGE_RATE
           , FDM.CANCEL_PRIN_AMOUNT
           , FDM.CANCEL_PRIN_CURR_AMOUNT
           , FDM.CANCEL_INTER_RATE
           , FDM.CANCEL_INTER_AMOUNT
           , FDM.CANCEL_INTER_CURR_AMOUNT
           , FDM.CANCEL_AMOUNT
           , FDM.CANCEL_CURR_AMOUNT
           , FDM.MORTGAGE_YN
           , FDM.MORTGAGE_DATE
           , FDM.FINAL_CURR_AMOUNT
           , FDM.FINAL_AMOUNT
           , FDM.TRANS_STATUS
           , FI_COMMON_G.CODE_NAME_F('TRANS_STATUS', FDM.TRANS_STATUS, FDM.SOB_ID) AS TRANS_STATUS_NAME
           , FDM.COST_CENTER_ID
           , FDM.REMARK
           , FDM.ENABLED_FLAG
        FROM FI_DEPOSIT_MASTER     FDM
           , FI_BANK_ACCOUNT       FBA
           , FI_BANK               FB
       WHERE FDM.BANK_ID         = FB.BANK_ID
         AND FDM.BANK_ACCOUNT_ID = FBA.BANK_ACCOUNT_ID
         AND FDM.SOB_ID          = P_SOB_ID
         AND FDM.BANK_ACCOUNT_ID = NVL(P_BANK_ACCOUNT_ID, FDM.BANK_ACCOUNT_ID);
        
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
    RETURN;        

  END MASTER_SELECT;

  PROCEDURE MASTER_INSERT
            ( P_BANK_ID                 IN FI_DEPOSIT_MASTER.BANK_ID%TYPE
            , P_BANK_ACCOUNT_ID          IN FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE
            , P_SOB_ID                   IN FI_DEPOSIT_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_DEPOSIT_MASTER.ORG_ID%TYPE
            , P_DEPOSIT_GB               IN FI_DEPOSIT_MASTER.DEPOSIT_GB%TYPE
            , P_ACCOUNT_TYPE             IN FI_DEPOSIT_MASTER.ACCOUNT_TYPE%TYPE
            , P_ISSUE_DATE               IN FI_DEPOSIT_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                 IN FI_DEPOSIT_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE            IN FI_DEPOSIT_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_DEPOSIT_MASTER.EXCHANGE_RATE%TYPE
            , P_DEPOSIT_CURR_AMOUNT      IN FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT%TYPE
            , P_DEPOSIT_AMOUNT           IN FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT%TYPE
            , P_INTER_RATE               IN FI_DEPOSIT_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE              IN FI_DEPOSIT_MASTER.SPREAD_RATE%TYPE
            , P_INTER_KIND               IN FI_DEPOSIT_MASTER.INTER_KIND%TYPE
            , P_INTER_TYPE               IN FI_DEPOSIT_MASTER.INTER_TYPE%TYPE
            , P_PAYMENT_PERIOD           IN FI_DEPOSIT_MASTER.PAYMENT_PERIOD%TYPE            
            , P_MONTH_CURR_AMOUNT        IN FI_DEPOSIT_MASTER.MONTH_CURR_AMOUNT%TYPE
            , P_MONTH_AMOUNT             IN FI_DEPOSIT_MASTER.MONTH_AMOUNT%TYPE
            , P_CANCEL_DATE              IN FI_DEPOSIT_MASTER.CANCEL_DATE%TYPE
            , P_CANCEL_EXCHANGE_RATE     IN FI_DEPOSIT_MASTER.CANCEL_EXCHANGE_RATE%TYPE
            , P_CANCEL_PRIN_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_PRIN_AMOUNT%TYPE
            , P_CANCEL_PRIN_CURR_AMOUNT  IN FI_DEPOSIT_MASTER.CANCEL_PRIN_CURR_AMOUNT%TYPE
            , P_CANCEL_INTER_RATE        IN FI_DEPOSIT_MASTER.CANCEL_INTER_RATE%TYPE
            , P_CANCEL_INTER_AMOUNT      IN FI_DEPOSIT_MASTER.CANCEL_INTER_AMOUNT%TYPE
            , P_CANCEL_INTER_CURR_AMOUNT IN FI_DEPOSIT_MASTER.CANCEL_INTER_CURR_AMOUNT%TYPE
            , P_CANCEL_AMOUNT            IN FI_DEPOSIT_MASTER.CANCEL_AMOUNT%TYPE
            , P_CANCEL_CURR_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_CURR_AMOUNT%TYPE
            , P_MORTGAGE_YN              IN FI_DEPOSIT_MASTER.MORTGAGE_YN%TYPE
            , P_MORTGAGE_DATE            IN FI_DEPOSIT_MASTER.MORTGAGE_DATE%TYPE
            , P_TRANS_STATUS             IN FI_DEPOSIT_MASTER.TRANS_STATUS%TYPE
            , P_COST_CENTER_ID           IN FI_DEPOSIT_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                   IN FI_DEPOSIT_MASTER.REMARK%TYPE
            , P_ENABLED_FLAG             IN FI_DEPOSIT_MASTER.ENABLED_FLAG%TYPE
            , P_USER_ID                  IN FI_DEPOSIT_MASTER.CREATED_BY%TYPE 
            )
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN

    INSERT INTO FI_DEPOSIT_MASTER
    ( BANK_ID
    , BANK_ACCOUNT_ID 
    , SOB_ID 
    , ORG_ID 
    , DEPOSIT_GB 
    , ACCOUNT_TYPE 
    , ISSUE_DATE 
    , DUE_DATE 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , DEPOSIT_CURR_AMOUNT 
    , DEPOSIT_AMOUNT 
    , INTER_RATE 
    , SPREAD_RATE 
    , INTER_KIND 
    , INTER_TYPE 
    , PAYMENT_PERIOD 
    , MONTH_CURR_AMOUNT
    , MONTH_AMOUNT
    , CANCEL_DATE 
    , CANCEL_EXCHANGE_RATE 
    , CANCEL_PRIN_AMOUNT 
    , CANCEL_PRIN_CURR_AMOUNT 
    , CANCEL_INTER_RATE 
    , CANCEL_INTER_AMOUNT 
    , CANCEL_INTER_CURR_AMOUNT 
    , CANCEL_AMOUNT 
    , CANCEL_CURR_AMOUNT 
    , MORTGAGE_YN 
    , MORTGAGE_DATE 
    , TRANS_STATUS 
    , COST_CENTER_ID 
    , REMARK 
    , ENABLED_FLAG 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_BANK_ID
    , P_BANK_ACCOUNT_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPOSIT_GB
    , P_ACCOUNT_TYPE
    , P_ISSUE_DATE
    , P_DUE_DATE
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_DEPOSIT_CURR_AMOUNT
    , P_DEPOSIT_AMOUNT
    , P_INTER_RATE
    , P_SPREAD_RATE
    , P_INTER_KIND
    , P_INTER_TYPE
    , P_PAYMENT_PERIOD
    , P_MONTH_CURR_AMOUNT
    , P_MONTH_AMOUNT
    , P_CANCEL_DATE
    , P_CANCEL_EXCHANGE_RATE
    , P_CANCEL_PRIN_AMOUNT
    , P_CANCEL_PRIN_CURR_AMOUNT
    , P_CANCEL_INTER_RATE
    , P_CANCEL_INTER_AMOUNT
    , P_CANCEL_INTER_CURR_AMOUNT
    , P_CANCEL_AMOUNT
    , P_CANCEL_CURR_AMOUNT
    , P_MORTGAGE_YN
    , P_MORTGAGE_DATE
    , P_TRANS_STATUS
    , P_COST_CENTER_ID
    , P_REMARK
    , P_ENABLED_FLAG
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  END MASTER_INSERT;

  PROCEDURE MASTER_UPDATE
            ( W_BANK_ID                  IN FI_DEPOSIT_MASTER.BANK_ID%TYPE
            , W_BANK_ACCOUNT_ID          IN FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE
            , W_SOB_ID                   IN FI_DEPOSIT_MASTER.SOB_ID%TYPE
            , W_ORG_ID                   IN FI_DEPOSIT_MASTER.ORG_ID%TYPE
            , P_DEPOSIT_GB               IN FI_DEPOSIT_MASTER.DEPOSIT_GB%TYPE
            , P_ACCOUNT_TYPE             IN FI_DEPOSIT_MASTER.ACCOUNT_TYPE%TYPE
            , P_ISSUE_DATE               IN FI_DEPOSIT_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                 IN FI_DEPOSIT_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE            IN FI_DEPOSIT_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_DEPOSIT_MASTER.EXCHANGE_RATE%TYPE
            , P_DEPOSIT_CURR_AMOUNT      IN FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT%TYPE
            , P_DEPOSIT_AMOUNT           IN FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT%TYPE
            , P_INTER_RATE               IN FI_DEPOSIT_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE              IN FI_DEPOSIT_MASTER.SPREAD_RATE%TYPE
            , P_INTER_KIND               IN FI_DEPOSIT_MASTER.INTER_KIND%TYPE
            , P_INTER_TYPE               IN FI_DEPOSIT_MASTER.INTER_TYPE%TYPE
            , P_PAYMENT_PERIOD           IN FI_DEPOSIT_MASTER.PAYMENT_PERIOD%TYPE
            , P_CANCEL_DATE              IN FI_DEPOSIT_MASTER.CANCEL_DATE%TYPE
            , P_CANCEL_EXCHANGE_RATE     IN FI_DEPOSIT_MASTER.CANCEL_EXCHANGE_RATE%TYPE
            , P_CANCEL_PRIN_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_PRIN_AMOUNT%TYPE
            , P_CANCEL_PRIN_CURR_AMOUNT  IN FI_DEPOSIT_MASTER.CANCEL_PRIN_CURR_AMOUNT%TYPE
            , P_CANCEL_INTER_RATE        IN FI_DEPOSIT_MASTER.CANCEL_INTER_RATE%TYPE
            , P_CANCEL_INTER_AMOUNT      IN FI_DEPOSIT_MASTER.CANCEL_INTER_AMOUNT%TYPE
            , P_CANCEL_INTER_CURR_AMOUNT IN FI_DEPOSIT_MASTER.CANCEL_INTER_CURR_AMOUNT%TYPE
            , P_CANCEL_AMOUNT            IN FI_DEPOSIT_MASTER.CANCEL_AMOUNT%TYPE
            , P_CANCEL_CURR_AMOUNT       IN FI_DEPOSIT_MASTER.CANCEL_CURR_AMOUNT%TYPE
            , P_MORTGAGE_YN              IN FI_DEPOSIT_MASTER.MORTGAGE_YN%TYPE
            , P_MORTGAGE_DATE            IN FI_DEPOSIT_MASTER.MORTGAGE_DATE%TYPE
            , P_TRANS_STATUS             IN FI_DEPOSIT_MASTER.TRANS_STATUS%TYPE
            , P_COST_CENTER_ID           IN FI_DEPOSIT_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                   IN FI_DEPOSIT_MASTER.REMARK%TYPE
            , P_ENABLED_FLAG             IN FI_DEPOSIT_MASTER.ENABLED_FLAG%TYPE
            , P_USER_ID                  IN FI_DEPOSIT_MASTER.CREATED_BY%TYPE 
            )
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN

    UPDATE FI_DEPOSIT_MASTER
      SET DEPOSIT_GB               = P_DEPOSIT_GB
        , ACCOUNT_TYPE             = P_ACCOUNT_TYPE
        , ISSUE_DATE               = P_ISSUE_DATE
        , DUE_DATE                 = P_DUE_DATE
        , CURRENCY_CODE            = P_CURRENCY_CODE
        , EXCHANGE_RATE            = P_EXCHANGE_RATE
        , DEPOSIT_CURR_AMOUNT      = P_DEPOSIT_CURR_AMOUNT
        , DEPOSIT_AMOUNT           = P_DEPOSIT_AMOUNT
        , INTER_RATE               = P_INTER_RATE
        , SPREAD_RATE              = P_SPREAD_RATE
        , INTER_KIND               = P_INTER_KIND
        , INTER_TYPE               = P_INTER_TYPE
        , PAYMENT_PERIOD           = P_PAYMENT_PERIOD
        , CANCEL_DATE              = P_CANCEL_DATE
        , CANCEL_EXCHANGE_RATE     = P_CANCEL_EXCHANGE_RATE
        , CANCEL_PRIN_AMOUNT       = P_CANCEL_PRIN_AMOUNT
        , CANCEL_PRIN_CURR_AMOUNT  = P_CANCEL_PRIN_CURR_AMOUNT
        , CANCEL_INTER_RATE        = P_CANCEL_INTER_RATE
        , CANCEL_INTER_AMOUNT      = P_CANCEL_INTER_AMOUNT
        , CANCEL_INTER_CURR_AMOUNT = P_CANCEL_INTER_CURR_AMOUNT
        , CANCEL_AMOUNT            = P_CANCEL_AMOUNT
        , CANCEL_CURR_AMOUNT       = P_CANCEL_CURR_AMOUNT
        , MORTGAGE_YN              = P_MORTGAGE_YN
        , MORTGAGE_DATE            = P_MORTGAGE_DATE
        , TRANS_STATUS             = P_TRANS_STATUS
        , COST_CENTER_ID           = P_COST_CENTER_ID
        , REMARK                   = P_REMARK
        , ENABLED_FLAG             = P_ENABLED_FLAG
        , LAST_UPDATE_DATE         = V_SYSDATE
        , LAST_UPDATED_BY          = P_USER_ID
    WHERE BANK_ID                  = W_BANK_ID 
      AND BANK_ACCOUNT_ID          = W_BANK_ACCOUNT_ID
      AND SOB_ID                   = W_SOB_ID
      ;

  EXCEPTION WHEN OTHERS THEN
  BEGIN
  RAISE_APPLICATION_ERROR(-20001, 'Error Message');
  END;

END MASTER_UPDATE;

-- ������ ���� ����(��ǥ --> ������ ����).
  PROCEDURE DEPOSIT_SAVE
            ( P_GB                    IN VARCHAR2
            , P_BANK_ACCOUNT_ID       IN FI_DEPOSIT_MASTER.BANK_ACCOUNT_ID%TYPE
            , P_ACCOUNT_CODE          IN VARCHAR2
            , P_SOB_ID                IN FI_DEPOSIT_MASTER.SOB_ID%TYPE
            , P_ORG_ID                IN FI_DEPOSIT_MASTER.ORG_ID%TYPE
            , P_ISSUE_DATE            IN FI_DEPOSIT_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE              IN FI_DEPOSIT_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE         IN FI_DEPOSIT_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE         IN FI_DEPOSIT_MASTER.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT           IN FI_DEPOSIT_MASTER.TOTAL_CURR_AMOUNT%TYPE       -- ���� �Ա�.
            , P_AMOUNT                IN FI_DEPOSIT_MASTER.TOTAL_AMOUNT%TYPE            -- ���� �Ա�.
            , P_DEPOSIT_CURR_AMOUNT   IN FI_DEPOSIT_MASTER.DEPOSIT_CURR_AMOUNT%TYPE     -- �����ݾ�.
            , P_DEPOSIT_AMOUNT        IN FI_DEPOSIT_MASTER.DEPOSIT_AMOUNT%TYPE          -- �����ݾ�.
            , P_MONTH_CURR_AMOUNT     IN FI_DEPOSIT_MASTER.MONTH_CURR_AMOUNT%TYPE       -- �����Ծ�.
            , P_MONTH_AMOUNT          IN FI_DEPOSIT_MASTER.MONTH_AMOUNT%TYPE            -- �����Ծ�.
            , P_INTER_RATE            IN FI_DEPOSIT_MASTER.INTER_RATE%TYPE
            , P_USER_ID               IN FI_DEPOSIT_MASTER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                         DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_BANK_ID                         NUMBER := NULL;
    V_DEPOSIT_GB                      VARCHAR2(10) := NULL;
    V_ACCOUNT_TYPE                    VARCHAR2(50) := NULL;
    
  BEGIN
    BEGIN      
      SELECT BA.BANK_ID, BA.ACCOUNT_TYPE
        INTO V_BANK_ID, V_ACCOUNT_TYPE
        FROM FI_BANK_ACCOUNT BA
      WHERE BA.BANK_ACCOUNT_ID          = P_BANK_ACCOUNT_ID
        AND BA.SOB_ID                   = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    BEGIN      
      SELECT DISTINCT DA.DEPOSIT_GB
        INTO V_DEPOSIT_GB
        FROM FI_DEPOSIT_ACCOUNT_V DA
      WHERE DA.ACCOUNT_CODE             = P_ACCOUNT_CODE
        AND DA.SOB_ID                   = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    IF V_BANK_ID IS NULL OR V_DEPOSIT_GB IS NULL OR V_ACCOUNT_TYPE IS NULL THEN
      RETURN;
    END IF;
    
    BEGIN
      IF P_GB = 'I' THEN
      -- �ű� �߰�.
        UPDATE FI_DEPOSIT_MASTER DM
          SET DM.TOTAL_PAYMENT_COUNT    = NVL(DM.TOTAL_PAYMENT_COUNT, 0) + 1          
            , DM.TOTAL_CURR_AMOUNT      = NVL(DM.TOTAL_CURR_AMOUNT, 0) + NVL(P_CURR_AMOUNT, 0)
            , DM.TOTAL_AMOUNT           = NVL(DM.TOTAL_AMOUNT, 0) + NVL(P_AMOUNT, 0)
            , DM.FINAL_CURR_AMOUNT      = NVL(P_CURR_AMOUNT, 0)
            , DM.FINAL_AMOUNT           = NVL(P_AMOUNT, 0)
            , LAST_UPDATE_DATE          = V_SYSDATE
            , LAST_UPDATED_BY           = P_USER_ID
        WHERE DM.BANK_ACCOUNT_ID        = P_BANK_ACCOUNT_ID
          AND DM.SOB_ID                 = P_SOB_ID
        ;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO FI_DEPOSIT_MASTER
          ( BANK_ID
          , BANK_ACCOUNT_ID
          , SOB_ID
          , ORG_ID
          , DEPOSIT_GB
          , ACCOUNT_TYPE
          , ISSUE_DATE
          , DUE_DATE
          , CURRENCY_CODE 
          , EXCHANGE_RATE 
          , DEPOSIT_CURR_AMOUNT 
          , DEPOSIT_AMOUNT 
          , INTER_RATE 
          , PAYMENT_COUNT
          , MONTH_CURR_AMOUNT
          , MONTH_AMOUNT
          , TOTAL_PAYMENT_COUNT
          , TOTAL_CURR_AMOUNT
          , TOTAL_AMOUNT
          , FINAL_CURR_AMOUNT
          , FINAL_AMOUNT
          , TRANS_STATUS
          , ENABLED_FLAG
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( V_BANK_ID
          , P_BANK_ACCOUNT_ID
          , P_SOB_ID
          , P_ORG_ID
          , V_DEPOSIT_GB
          , V_ACCOUNT_TYPE
          , P_ISSUE_DATE
          , P_DUE_DATE
          , P_CURRENCY_CODE 
          , P_EXCHANGE_RATE 
          , P_DEPOSIT_CURR_AMOUNT 
          , P_DEPOSIT_AMOUNT 
          , P_INTER_RATE 
          , 1  -- PAYMENT_COUNT
          , P_MONTH_CURR_AMOUNT
          , P_MONTH_AMOUNT
          , 1  -- TOTAL_PAYMENT_COUNT
          , P_CURR_AMOUNT   -- �Ѻ��Դ����.
          , P_AMOUNT
          , P_CURR_AMOUNT   -- ���� ���Ծ�.
          , P_AMOUNT
          , '10' -- TRANS_STATUS
          , 'Y'  -- ENABLED_FLAG
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID
          );        
        END IF;
      ELSE
      -- ����.
        UPDATE FI_DEPOSIT_MASTER DM
          SET DM.TOTAL_PAYMENT_COUNT    = NVL(DM.TOTAL_PAYMENT_COUNT, 0) - 1
            , DM.TOTAL_CURR_AMOUNT      = NVL(DM.TOTAL_CURR_AMOUNT, 0) - NVL(P_CURR_AMOUNT, 0)
            , DM.TOTAL_AMOUNT           = NVL(DM.TOTAL_AMOUNT, 0) - NVL(P_AMOUNT, 0)
            , LAST_UPDATE_DATE          = V_SYSDATE
            , LAST_UPDATED_BY           = P_USER_ID
        WHERE DM.BANK_ACCOUNT_ID        = P_BANK_ACCOUNT_ID
          AND DM.SOB_ID                 = P_SOB_ID
        ;
      END IF;
    END;
  
  END DEPOSIT_SAVE;
  
END FI_DEPOSIT_MASTER_G;
/