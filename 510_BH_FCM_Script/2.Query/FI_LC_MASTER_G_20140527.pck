CREATE OR REPLACE PACKAGE FI_LC_MASTER_G
AS

  PROCEDURE SELECT_LC
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_LC_NUM            IN VARCHAR2
            , P_BANK_ID           IN NUMBER
            );
  -- INSERT.
  PROCEDURE INSERT_LC_MASTER
            ( P_LC_NUM              IN FI_LC_MASTER.LC_NUM%TYPE
            , P_SOB_ID              IN FI_LC_MASTER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_LC_MASTER.ORG_ID%TYPE
            , P_BANK_ID             IN FI_LC_MASTER.BANK_ID%TYPE
            , P_SUPPLIER_ID         IN FI_LC_MASTER.SUPPLIER_ID%TYPE
            , P_OPEN_DATE           IN FI_LC_MASTER.OPEN_DATE%TYPE
            , P_DUE_DATE            IN FI_LC_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE       IN FI_LC_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_LC_MASTER.EXCHANGE_RATE%TYPE
            , P_OPEN_CURR_AMOUNT    IN FI_LC_MASTER.OPEN_CURR_AMOUNT%TYPE
            , P_OPEN_AMOUNT         IN FI_LC_MASTER.OPEN_AMOUNT%TYPE
            , P_OPEN_EXPENSE_AMOUNT IN FI_LC_MASTER.OPEN_EXPENSE_AMOUNT%TYPE
            , P_TRANS_STATUS        IN FI_LC_MASTER.TRANS_STATUS%TYPE
            , P_DESCRIPTION         IN FI_LC_MASTER.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_LC_MASTER.CREATED_BY%TYPE 
            );

-- UPDATE.
  PROCEDURE UPDATE_LC_MASTER
            ( W_LC_NUM              IN FI_LC_MASTER.LC_NUM%TYPE
            , W_SOB_ID              IN FI_LC_MASTER.SOB_ID%TYPE
            , P_BANK_ID             IN FI_LC_MASTER.BANK_ID%TYPE
            , P_SUPPLIER_ID         IN FI_LC_MASTER.SUPPLIER_ID%TYPE
            , P_OPEN_DATE           IN FI_LC_MASTER.OPEN_DATE%TYPE
            , P_DUE_DATE            IN FI_LC_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE       IN FI_LC_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_LC_MASTER.EXCHANGE_RATE%TYPE
            , P_OPEN_CURR_AMOUNT    IN FI_LC_MASTER.OPEN_CURR_AMOUNT%TYPE
            , P_OPEN_AMOUNT         IN FI_LC_MASTER.OPEN_AMOUNT%TYPE
            , P_OPEN_EXPENSE_AMOUNT IN FI_LC_MASTER.OPEN_EXPENSE_AMOUNT%TYPE
            , P_TRANS_STATUS        IN FI_LC_MASTER.TRANS_STATUS%TYPE
            , P_DESCRIPTION         IN FI_LC_MASTER.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_LC_MASTER.CREATED_BY%TYPE 
            );

-- DELETE.
  PROCEDURE DELETE_LC_MASTER
            ( W_LC_NUM              IN FI_LC_MASTER.LC_NUM%TYPE
            , W_SOB_ID              IN FI_LC_MASTER.SOB_ID%TYPE
            );
            
  PROCEDURE LU_LC_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_SOB_ID            IN NUMBER            
            );
            
END FI_LC_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_LC_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_LC_MASTER_G
/* Description  : L/C MASTER °ü¸®
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  PROCEDURE SELECT_LC
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_LC_NUM            IN VARCHAR2
            , P_BANK_ID           IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT LM.LC_NUM
           , LM.BANK_ID
           , FB.BANK_NAME
           , LM.SUPPLIER_ID
           , SC.SUPP_CUST_NAME AS SUPPLIER_NAME
           , LM.OPEN_DATE
           , LM.DUE_DATE
           , LM.CURRENCY_CODE
           , LM.EXCHANGE_RATE
           , LM.OPEN_CURR_AMOUNT
           , LM.OPEN_AMOUNT
           , LM.OPEN_EXPENSE_AMOUNT
           , LM.TRANS_STATUS
           , FI_COMMON_G.CODE_NAME_F('TRANS_STATUS', LM.TRANS_STATUS, LM.SOB_ID) AS TRANS_TRANS_NAME
           , LM.DESCRIPTION
        FROM FI_LC_MASTER LM
          , FI_BANK FB
          , FI_SUPP_CUST_V SC
      WHERE LM.BANK_ID                  = FB.BANK_ID(+)
        AND LM.SUPPLIER_ID              = SC.SUPP_CUST_ID(+)
        AND LM.LC_NUM                   = NVL(P_LC_NUM, LM.LC_NUM)
        AND LM.SOB_ID                   = P_SOB_ID  
        AND LM.BANK_ID                  = NVL(P_BANK_ID, LM.BANK_ID)
      ORDER BY LM.LC_NUM
      ;
  END SELECT_LC;

  -- INSERT.
  PROCEDURE INSERT_LC_MASTER
            ( P_LC_NUM              IN FI_LC_MASTER.LC_NUM%TYPE
            , P_SOB_ID              IN FI_LC_MASTER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_LC_MASTER.ORG_ID%TYPE
            , P_BANK_ID             IN FI_LC_MASTER.BANK_ID%TYPE
            , P_SUPPLIER_ID         IN FI_LC_MASTER.SUPPLIER_ID%TYPE
            , P_OPEN_DATE           IN FI_LC_MASTER.OPEN_DATE%TYPE
            , P_DUE_DATE            IN FI_LC_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE       IN FI_LC_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_LC_MASTER.EXCHANGE_RATE%TYPE
            , P_OPEN_CURR_AMOUNT    IN FI_LC_MASTER.OPEN_CURR_AMOUNT%TYPE
            , P_OPEN_AMOUNT         IN FI_LC_MASTER.OPEN_AMOUNT%TYPE
            , P_OPEN_EXPENSE_AMOUNT IN FI_LC_MASTER.OPEN_EXPENSE_AMOUNT%TYPE
            , P_TRANS_STATUS        IN FI_LC_MASTER.TRANS_STATUS%TYPE
            , P_DESCRIPTION         IN FI_LC_MASTER.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_LC_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT    NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(LM.LC_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_LC_MASTER LM
      WHERE LM.LC_NUM             = P_LC_NUM
        AND LM.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;
    
    INSERT INTO FI_LC_MASTER
    ( LC_NUM
    , SOB_ID 
    , ORG_ID 
    , BANK_ID 
    , SUPPLIER_ID 
    , OPEN_DATE 
    , DUE_DATE 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , OPEN_CURR_AMOUNT 
    , OPEN_AMOUNT 
    , OPEN_EXPENSE_AMOUNT 
    , TRANS_STATUS 
    , DESCRIPTION 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_LC_NUM
    , P_SOB_ID
    , P_ORG_ID
    , P_BANK_ID
    , P_SUPPLIER_ID
    , TRUNC(P_OPEN_DATE)
    , TRUNC(P_DUE_DATE) 
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_OPEN_CURR_AMOUNT
    , P_OPEN_AMOUNT
    , P_OPEN_EXPENSE_AMOUNT
    , P_TRANS_STATUS
    , P_DESCRIPTION
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_LC_MASTER;

-- UPDATE.
  PROCEDURE UPDATE_LC_MASTER
            ( W_LC_NUM              IN FI_LC_MASTER.LC_NUM%TYPE
            , W_SOB_ID              IN FI_LC_MASTER.SOB_ID%TYPE
            , P_BANK_ID             IN FI_LC_MASTER.BANK_ID%TYPE
            , P_SUPPLIER_ID         IN FI_LC_MASTER.SUPPLIER_ID%TYPE
            , P_OPEN_DATE           IN FI_LC_MASTER.OPEN_DATE%TYPE
            , P_DUE_DATE            IN FI_LC_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE       IN FI_LC_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_LC_MASTER.EXCHANGE_RATE%TYPE
            , P_OPEN_CURR_AMOUNT    IN FI_LC_MASTER.OPEN_CURR_AMOUNT%TYPE
            , P_OPEN_AMOUNT         IN FI_LC_MASTER.OPEN_AMOUNT%TYPE
            , P_OPEN_EXPENSE_AMOUNT IN FI_LC_MASTER.OPEN_EXPENSE_AMOUNT%TYPE
            , P_TRANS_STATUS        IN FI_LC_MASTER.TRANS_STATUS%TYPE
            , P_DESCRIPTION         IN FI_LC_MASTER.DESCRIPTION%TYPE
            , P_USER_ID             IN FI_LC_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE FI_LC_MASTER
      SET BANK_ID             = P_BANK_ID
        , SUPPLIER_ID         = P_SUPPLIER_ID
        , OPEN_DATE           = TRUNC(P_OPEN_DATE)
        , DUE_DATE            = TRUNC(P_DUE_DATE)
        , CURRENCY_CODE       = P_CURRENCY_CODE
        , EXCHANGE_RATE       = P_EXCHANGE_RATE
        , OPEN_CURR_AMOUNT    = P_OPEN_CURR_AMOUNT
        , OPEN_AMOUNT         = P_OPEN_AMOUNT
        , OPEN_EXPENSE_AMOUNT = P_OPEN_EXPENSE_AMOUNT
        , TRANS_STATUS        = P_TRANS_STATUS
        , DESCRIPTION         = P_DESCRIPTION
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE LC_NUM              = W_LC_NUM
      AND SOB_ID              = W_SOB_ID
    ;
  END UPDATE_LC_MASTER ;

-- DELETE.
  PROCEDURE DELETE_LC_MASTER
            ( W_LC_NUM              IN FI_LC_MASTER.LC_NUM%TYPE
            , W_SOB_ID              IN FI_LC_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    RETURN;
    /*
    DELETE FROM FI_LC_MASTER
    WHERE LC_NUM              = W_LC_NUM
      AND SOB_ID              = W_SOB_ID
    ;*/
  END DELETE_LC_MASTER;
  
  PROCEDURE LU_LC_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_SOB_ID            IN NUMBER            
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT LM.LC_NUM
           , FB.BANK_NAME
           , SC.SUPP_CUST_NAME AS SUPPLIER_NAME
           , TO_CHAR(LM.OPEN_DATE, 'YYYY-MM-DD') AS OPEN_DATE
           , TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD') AS DUE_DATE
           , LM.CURRENCY_CODE
           , TO_CHAR(LM.OPEN_AMOUNT, 'FM999,999,999,999,999,999') AS OPEN_AMOUNT
        FROM FI_LC_MASTER LM
          , FI_BANK FB
          , FI_SUPP_CUST_V SC
      WHERE LM.BANK_ID                  = FB.BANK_ID
        AND LM.SUPPLIER_ID              = SC.SUPP_CUST_ID(+)
        AND LM.SOB_ID                   = P_SOB_ID  
      ORDER BY LM.LC_NUM
      ;
  
  END LU_LC_NUM;
  
END FI_LC_MASTER_G;
/
