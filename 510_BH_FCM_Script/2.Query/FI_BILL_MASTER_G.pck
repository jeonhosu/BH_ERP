CREATE OR REPLACE PACKAGE FI_BILL_MASTER_G
AS

-- 받을어음 원장 조회.
  PROCEDURE BILL_MASTER_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_BILL_NUM           IN FI_BILL_MASTER.BILL_NUM%TYPE
            , W_BILL_STATUS        IN FI_BILL_MASTER.BILL_STATUS%TYPE
            , W_SOB_ID             IN FI_BILL_MASTER.SOB_ID%TYPE
            , W_ISSUE_NAME         IN FI_BILL_MASTER.ISSUE_NAME%TYPE
            );

-- 받을어음 원장 간략하게 조회.
  PROCEDURE BILL_MASTER_SELECT_S
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_SLIP_LINE_ID       IN FI_BILL_MASTER.SLIP_LINE_ID%TYPE
            , W_SOB_ID             IN FI_BILL_MASTER.SOB_ID%TYPE
            );

-- 받을어음 원장 INSERT.
  PROCEDURE BILL_MASTER_INSERT
            ( P_BILL_MASTER_ID       OUT FI_BILL_MASTER.BILL_MASTER_ID%TYPE
            , P_BILL_NUM             IN FI_BILL_MASTER.BILL_NUM%TYPE
            , P_SOB_ID               IN FI_BILL_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN FI_BILL_MASTER.ORG_ID%TYPE
            , P_BILL_TYPE            IN FI_BILL_MASTER.BILL_TYPE%TYPE
            , P_CUSTOMER_ID          IN FI_BILL_MASTER.CUSTOMER_ID%TYPE
            , P_ISSUE_DATE           IN FI_BILL_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE             IN FI_BILL_MASTER.DUE_DATE%TYPE
            , P_BILL_STATUS          IN FI_BILL_MASTER.BILL_STATUS%TYPE
            , P_BILL_AMOUNT          IN FI_BILL_MASTER.BILL_AMOUNT%TYPE
            , P_BANK_ID              IN FI_BILL_MASTER.BANK_ID%TYPE
            , P_ISSUE_NAME           IN FI_BILL_MASTER.ISSUE_NAME%TYPE
            , P_RECEIPT_DEPT_ID      IN FI_BILL_MASTER.RECEIPT_DEPT_ID%TYPE
            , P_KEEP_DEPT_ID         IN FI_BILL_MASTER.KEEP_DEPT_ID%TYPE
            , P_RECEIPT_DATE         IN FI_BILL_MASTER.RECEIPT_DATE%TYPE
            , P_SLIP_LINE_ID         IN FI_BILL_MASTER.SLIP_LINE_ID%TYPE
            , P_USER_ID              IN FI_BILL_MASTER.CREATED_BY%TYPE
            );

-- 받을어음 원장 수정.
  PROCEDURE BILL_MASTER_UPDATE
            ( W_BILL_NUM           IN FI_BILL_MASTER.BILL_NUM%TYPE
            , W_SOB_ID             IN FI_BILL_MASTER.SOB_ID%TYPE
            , P_BILL_STATUS        IN FI_BILL_MASTER.BILL_STATUS%TYPE
            , P_ENDORSE_NAME       IN FI_BILL_MASTER.ENDORSE_NAME%TYPE
            , P_ENDORSE_ADDRESS    IN FI_BILL_MASTER.ENDORSE_ADDRESS%TYPE
            , P_USER_ID            IN FI_BILL_MASTER.LAST_UPDATED_BY%TYPE
            );

-- 받을어음 이동내역 조회.
  PROCEDURE BILL_MOVE_SELECT
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_BILL_NUM           IN FI_BILL_MOVE.BILL_NUM%TYPE
            , W_SOB_ID             IN FI_BILL_MOVE.SOB_ID%TYPE
            );

END FI_BILL_MASTER_G; 
 
/
CREATE OR REPLACE PACKAGE BODY FI_BILL_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_BILL_MASTER_G
/* Description  : 어음원장 관리.
/*
/* Reference by : 부서정보 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 받을어음 원장 조회.
  PROCEDURE BILL_MASTER_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_BILL_NUM           IN FI_BILL_MASTER.BILL_NUM%TYPE
            , W_BILL_STATUS        IN FI_BILL_MASTER.BILL_STATUS%TYPE
            , W_SOB_ID             IN FI_BILL_MASTER.SOB_ID%TYPE
            , W_ISSUE_NAME         IN FI_BILL_MASTER.ISSUE_NAME%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT BM.BILL_NUM
           , BM.SOB_ID
           , BM.BILL_TYPE
           , FI_COMMON_G.CODE_NAME_F('BILL_TYPE', BM.BILL_TYPE, BM.SOB_ID) AS BILL_TYPE_NAME
           , BM.CUSTOMER_ID
           , SCV.SUPP_CUST_NAME
           , SCV.TAX_REG_NO
           , BM.ISSUE_DATE
           , BM.DUE_DATE
           , BM.BILL_STATUS
           , FI_COMMON_G.CODE_NAME_F('BILL_STATUS', BM.BILL_STATUS, BM.SOB_ID) AS BILL_STATUS_NAME
           , BM.BILL_MODE
           , FI_COMMON_G.CODE_NAME_F('BILL_MODE', BM.BILL_MODE, BM.SOB_ID) AS BILL_MODE_NAME
           , BM.AREA_CODE
           , FI_COMMON_G.CODE_NAME_F('AREA_CODE', BM.AREA_CODE, BM.SOB_ID) AS AREA_NAME
           , BM.BILL_AMOUNT
           , BM.BANK_ID
           , FI_BANK_G.ID_NAME_F(BM.BANK_ID) AS BANK_NAME
           , BM.ISSUE_NAME
           , BM.ENDORSE_NAME
           , BM.ENDORSE_ADDRESS
           , BM.RECEIPT_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(BM.RECEIPT_DEPT_ID) AS RECEIPT_DEPT_NAME
           , BM.KEEP_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(BM.KEEP_DEPT_ID) AS KEEP_DEPT_NAME
           , BM.RECEIPT_DATE
           , BM.TRUST_DATE
           , BM.TRUST_BANK_ID
           , FI_BANK_G.ID_NAME_F(BM.TRUST_BANK_ID) AS TRUST_BANK_NAME
           , BM.BAD_DATE
           , BM.DC_DATE
           , BM.DC_BANK_ID
           , FI_BANK_G.ID_NAME_F(BM.DC_BANK_ID) AS DC_BANK_NAME
           , BM.DC_REMAIN_AMOUNT
           , BM.GIVE_DATE
           , BM.MOVE_START_DATE
           , BM.MOVE_CONFIRM_DATE
           , BM.PAYMENT_DATE
           , BM.CANCEL_MOVE_DATE
           , BM.CANCEL_MOVE_BAD_DATE
           , BM.CANCEL_BAD_DATE
           , BM.CANCEL_PAYMENT_DATE
           , BM.CANCEL_DC_DATE
           , BM.CANCEL_TRUST_DATE
           , BM.CREDIT_YN
           , BM.CREDIT_NO_REMARK
        FROM FI_BILL_MASTER BM
           , FI_SUPP_CUST_V SCV
       WHERE BM.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND BM.SOB_ID                  = SCV.SOB_ID(+)
         AND BM.BILL_NUM                = NVL(W_BILL_NUM, BM.BILL_NUM)
         AND BM.SOB_ID                  = W_SOB_ID
         AND BM.BILL_STATUS             = NVL(W_BILL_STATUS, BM.BILL_STATUS)
         AND BM.ISSUE_NAME              LIKE W_ISSUE_NAME || '%'
      ;
  END BILL_MASTER_SELECT;

-- 받을어음 원장 간략하게 조회.
  PROCEDURE BILL_MASTER_SELECT_S
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_SLIP_LINE_ID       IN FI_BILL_MASTER.SLIP_LINE_ID%TYPE
            , W_SOB_ID             IN FI_BILL_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT BM.BILL_MASTER_ID
           , BM.BILL_NUM
           , BM.BILL_TYPE
           , FI_COMMON_G.CODE_NAME_F('BILL_TYPE', BM.BILL_TYPE, BM.SOB_ID) AS BILL_TYPE_NAME
           , BM.CUSTOMER_ID
           , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
           , SCV.TAX_REG_NO
           , BM.ISSUE_DATE
           , BM.DUE_DATE
           , BM.BILL_STATUS
           , FI_COMMON_G.CODE_NAME_F('BILL_STATUS', BM.BILL_STATUS, BM.SOB_ID) AS BILL_STATUS_NAME
           , BM.BILL_AMOUNT
           , BM.BANK_ID
           , FI_BANK_G.ID_NAME_F(BM.BANK_ID) AS BANK_NAME
           , BM.ISSUE_NAME
           , BM.RECEIPT_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(BM.RECEIPT_DEPT_ID) AS RECEIPT_DEPT_NAME
           , BM.KEEP_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(BM.KEEP_DEPT_ID) AS KEEP_DEPT_NAME
           , BM.RECEIPT_DATE
           , BM.SLIP_LINE_ID
        FROM FI_BILL_MASTER BM
           , FI_SUPP_CUST_V SCV
       WHERE BM.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND BM.SOB_ID                  = SCV.SOB_ID(+)
         AND BM.SLIP_LINE_ID            = W_SLIP_LINE_ID
         AND BM.SOB_ID                  = W_SOB_ID
      ;
  END BILL_MASTER_SELECT_S;

-- 받을어음 원장 INSERT.
  PROCEDURE BILL_MASTER_INSERT
            ( P_BILL_MASTER_ID       OUT FI_BILL_MASTER.BILL_MASTER_ID%TYPE
            , P_BILL_NUM             IN FI_BILL_MASTER.BILL_NUM%TYPE
            , P_SOB_ID               IN FI_BILL_MASTER.SOB_ID%TYPE
            , P_ORG_ID               IN FI_BILL_MASTER.ORG_ID%TYPE
            , P_BILL_TYPE            IN FI_BILL_MASTER.BILL_TYPE%TYPE
            , P_CUSTOMER_ID          IN FI_BILL_MASTER.CUSTOMER_ID%TYPE
            , P_ISSUE_DATE           IN FI_BILL_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE             IN FI_BILL_MASTER.DUE_DATE%TYPE
            , P_BILL_STATUS          IN FI_BILL_MASTER.BILL_STATUS%TYPE
            , P_BILL_AMOUNT          IN FI_BILL_MASTER.BILL_AMOUNT%TYPE
            , P_BANK_ID              IN FI_BILL_MASTER.BANK_ID%TYPE
            , P_ISSUE_NAME           IN FI_BILL_MASTER.ISSUE_NAME%TYPE
            , P_RECEIPT_DEPT_ID      IN FI_BILL_MASTER.RECEIPT_DEPT_ID%TYPE
            , P_KEEP_DEPT_ID         IN FI_BILL_MASTER.KEEP_DEPT_ID%TYPE
            , P_RECEIPT_DATE         IN FI_BILL_MASTER.RECEIPT_DATE%TYPE
            , P_SLIP_LINE_ID         IN FI_BILL_MASTER.SLIP_LINE_ID%TYPE
            , P_USER_ID              IN FI_BILL_MASTER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                        DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      SELECT COUNT(BM.BILL_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_BILL_MASTER BM
       WHERE BM.BILL_NUM                = P_BILL_NUM
         AND BM.SOB_ID                  = P_SOB_ID
        ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    SELECT FI_BILL_MASTER_S1.NEXTVAL
      INTO P_BILL_MASTER_ID
      FROM DUAL;

    INSERT INTO FI_BILL_MASTER
    ( BILL_MASTER_ID
    , BILL_NUM
    , SOB_ID
    , ORG_ID
    , BILL_TYPE
    , CUSTOMER_ID
    , ISSUE_DATE
    , DUE_DATE
    , BILL_STATUS
    , BILL_AMOUNT
    , BANK_ID
    , ISSUE_NAME
    , RECEIPT_DEPT_ID
    , KEEP_DEPT_ID
    , RECEIPT_DATE
    , SLIP_LINE_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_BILL_MASTER_ID
    , P_BILL_NUM
    , P_SOB_ID
    , P_ORG_ID
    , P_BILL_TYPE
    , P_CUSTOMER_ID
    , P_ISSUE_DATE
    , P_DUE_DATE
    , P_BILL_STATUS
    , P_BILL_AMOUNT
    , P_BANK_ID
    , P_ISSUE_NAME
    , P_RECEIPT_DEPT_ID
    , P_KEEP_DEPT_ID
    , P_RECEIPT_DATE
    , P_SLIP_LINE_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );


  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END BILL_MASTER_INSERT;

-- 받을어음 원장 수정.
  PROCEDURE BILL_MASTER_UPDATE
            ( W_BILL_NUM           IN FI_BILL_MASTER.BILL_NUM%TYPE
            , W_SOB_ID             IN FI_BILL_MASTER.SOB_ID%TYPE
            , P_BILL_STATUS        IN FI_BILL_MASTER.BILL_STATUS%TYPE
            , P_ENDORSE_NAME       IN FI_BILL_MASTER.ENDORSE_NAME%TYPE
            , P_ENDORSE_ADDRESS    IN FI_BILL_MASTER.ENDORSE_ADDRESS%TYPE
            , P_USER_ID            IN FI_BILL_MASTER.LAST_UPDATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_BILL_MASTER BM
      SET BM.BILL_STATUS           = P_BILL_STATUS
        , BM.ENDORSE_NAME          = P_ENDORSE_NAME
        , BM.ENDORSE_ADDRESS       = P_ENDORSE_ADDRESS
        , BM.LAST_UPDATE_DATE      = GET_LOCAL_DATE(BM.SOB_ID)
        , BM.LAST_UPDATED_BY       = P_USER_ID
     WHERE BM.BILL_NUM                = W_BILL_NUM
       AND BM.SOB_ID                  = W_SOB_ID
    ;

  END BILL_MASTER_UPDATE;

-- 받을어음 이동내역 조회.
  PROCEDURE BILL_MOVE_SELECT
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_BILL_NUM           IN FI_BILL_MOVE.BILL_NUM%TYPE
            , W_SOB_ID             IN FI_BILL_MOVE.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT BM.BILL_NUM
           , BM.MOVE_SEQ
           , BM.MOVE_DATE
           , BM.BILL_STATUS
           , FI_COMMON_G.CODE_NAME_F('BILL_STATUS', BM.BILL_STATUS, BM.SOB_ID) AS BILL_STATUS_NAME
           , BM.BILL_TYPE
           , FI_COMMON_G.CODE_NAME_F('BILL_TYPE', BM.BILL_TYPE, BM.SOB_ID) AS BILL_TYPE_NAME
           , BM.DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(BM.DEPT_ID) AS DEPT_NAME
           , BM.PERSON_ID
           , EAPP_USER_G.USER_NAME_F(BM.PERSON_ID) AS USER_NAME
           , BM.CUSTOMER_ID
           , SCV.SUPP_CUST_NAME
           , SCV.TAX_REG_NO
           , BM.BILL_AMOUNT
           , BM.DC_INTEREST_RATE
           , BM.DC_TERM
           , BM.DC_INTEREST_AMOUNT
           , BM.PAYMENT_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYMENT_TYPE', BM.PAYMENT_TYPE, BM.SOB_ID, BM.SOB_ID) AS PAYMENT_TYPE_NAME
           , BM.BANK_ID
           , FI_BANK_G.ID_NAME_F(BM.BANK_ID) AS BANK_NAME
           , BM.BILL_GIVE_DEPT_ID
        FROM FI_BILL_MOVE BM
           , FI_SUPP_CUST_V SCV
       WHERE BM.CUSTOMER_ID             = SCV.SUPP_CUST_ID
         AND BM.BILL_NUM                = W_BILL_NUM
         AND BM.SOB_ID                  = W_SOB_ID
      ;

  END BILL_MOVE_SELECT;

END FI_BILL_MASTER_G; 
/
