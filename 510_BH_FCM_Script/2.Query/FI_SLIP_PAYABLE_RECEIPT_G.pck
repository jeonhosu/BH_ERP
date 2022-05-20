CREATE OR REPLACE PACKAGE FI_SLIP_PAYABLE_RECEIPT_G
AS

-- 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_DATE_FR         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_DATE_TO         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_DEPT_ID              IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , W_PERSON_ID            IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , W_SLIP_TYPE            IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            );

-- 선택한 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            );

-- 전표 헤더 삽입.
  PROCEDURE INSERT_SLIP_HEADER
            ( P_SLIP_HEADER_ID      OUT FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_HEADER.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER.BUDGET_DEPT_ID%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
            , P_GL_NUM              IN FI_SLIP_HEADER.GL_NUM%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_HEADER.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_HEADER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_HEADER.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_HEADER.GL_CURRENCY_AMOUNT%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            );

-- 전표 헤더 수정.
  PROCEDURE UPDATE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_HEADER.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_HEADER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_HEADER.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_HEADER.GL_CURRENCY_AMOUNT%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            );

-- 전표 헤더 삭제.
  PROCEDURE DELETE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID    IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , W_SOB_ID            IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID            IN FI_SLIP_LINE.ORG_ID%TYPE
            );

-- 전표 라인  삽입.
  PROCEDURE INSERT_SLIP_LINE
            ( P_SLIP_LINE_ID               OUT FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , P_SLIP_HEADER_ID             IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , P_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , P_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID             IN FI_SLIP_LINE.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID                IN FI_SLIP_LINE.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID             IN FI_SLIP_LINE.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID            IN FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_VOUCH_CODE                 IN FI_SLIP_LINE.VOUCH_CODE%TYPE
            , P_REFER_RATE                 IN FI_SLIP_LINE.REFER_RATE%TYPE
            , P_REFER_AMOUNT               IN FI_SLIP_LINE.REFER_AMOUNT%TYPE
            , P_REFER_DATE1                IN FI_SLIP_LINE.REFER_DATE1%TYPE
            , P_REFER_DATE2                IN FI_SLIP_LINE.REFER_DATE2%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_FUND_CODE                  IN FI_SLIP_LINE.FUND_CODE%TYPE
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            );

-- 전표라인 수정.
  PROCEDURE UPDATE_SLIP_LINE
            ( W_SLIP_LINE_ID               IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , W_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID             IN FI_SLIP_LINE.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID                IN FI_SLIP_LINE.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID             IN FI_SLIP_LINE.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID            IN FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_VOUCH_CODE                 IN FI_SLIP_LINE.VOUCH_CODE%TYPE
            , P_REFER_RATE                 IN FI_SLIP_LINE.REFER_RATE%TYPE
            , P_REFER_AMOUNT               IN FI_SLIP_LINE.REFER_AMOUNT%TYPE
            , P_REFER_DATE1                IN FI_SLIP_LINE.REFER_DATE1%TYPE
            , P_REFER_DATE2                IN FI_SLIP_LINE.REFER_DATE2%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_FUND_CODE                  IN FI_SLIP_LINE.FUND_CODE%TYPE            
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            );

-- 전표 라인 삭제.
  PROCEDURE DELETE_SLIP_LINE
            ( W_SLIP_LINE_ID      IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            );

END FI_SLIP_PAYABLE_RECEIPT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SLIP_PAYABLE_RECEIPT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_SLIP_PAYABLE_RECEIPT_G
/* Description  : (지급/수금) 전표 헤더/라인 정보.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_DATE_FR         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_DATE_TO         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_DEPT_ID              IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , W_PERSON_ID            IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , W_SLIP_TYPE            IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SH.SLIP_HEADER_ID
           , SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.SOB_ID
           , SH.ORG_ID
           , SH.DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.DEPT_ID) AS DEPT_NAME
           , SH.PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SH.SLIP_TYPE, SH.SOB_ID) AS SLIP_TYPE_NAME
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
           , SH.CHANGE_COUNT
           , SH.GL_DATE
           , SH.GL_NUM
           , SH.GL_AMOUNT
           , SH.CURRENCY_CODE
           , SH.CURRENCY_CODE AS CURRENCY_DESC
           , SH.EXCHANGE_RATE
           , SH.GL_CURRENCY_AMOUNT
           , SH.REQ_BANK_ACCOUNT_ID
           , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
           , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
           , SH.REQ_PAYABLE_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
           , SH.REQ_PAYABLE_DATE
           , SH.REMARK
           , SH.CLOSED_YN
           , ST.SLIP_TYPE_CLASS
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_TYPE_V ST
          , (SELECT BA.BANK_ACCOUNT_ID
                  , FB.BANK_NAME
                  , BA.BANK_ACCOUNT_NAME
                  , BA.BANK_ACCOUNT_NUM
               FROM FI_BANK_ACCOUNT BA
                  , FI_BANK FB
              WHERE BA.BANK_ID      = FB.BANK_ID
            ) S_BA
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
         AND SH.SLIP_DATE               BETWEEN W_SLIP_DATE_FR AND W_SLIP_DATE_TO
         AND SH.SLIP_HEADER_ID          = NVL(W_SLIP_HEADER_ID, SH.SLIP_HEADER_ID)
         AND (SH.SLIP_TYPE              = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND ST.SLIP_TYPE_CLASS         = 'DW')
         AND SH.DEPT_ID                 = NVL(W_DEPT_ID, SH.DEPT_ID)
         AND SH.PERSON_ID               = NVL(W_PERSON_ID, SH.PERSON_ID)
         AND SH.SOB_ID                  = W_SOB_ID
--         AND SH.SLIP_TYPE               IN ('APY', 'ARC')
      ORDER BY SH.SLIP_HEADER_ID DESC  --SH.SLIP_DATE, SH.GL_DATE DESC
      ;
      
  END SELECT_SLIP_HEADER_LIST;
  
-- 선택한 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SH.SLIP_HEADER_ID
           , SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.SOB_ID
           , SH.ORG_ID
           , SH.DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.DEPT_ID) AS DEPT_NAME
           , SH.PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , ST.SLIP_TYPE_NAME AS SLIP_TYPE_NAME
           , ST.SLIP_TYPE_CLASS
           , ST.DOCUMENT_TYPE
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
           , SH.CHANGE_COUNT
           , SH.GL_DATE
           , SH.GL_NUM
           , SH.GL_AMOUNT
           , SH.CURRENCY_CODE
           , SH.CURRENCY_CODE AS CURRENCY_DESC
           , SH.EXCHANGE_RATE
           , SH.GL_CURRENCY_AMOUNT
           , SH.REQ_BANK_ACCOUNT_ID
           , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
           , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
           , SH.REQ_PAYABLE_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
           , SH.REQ_PAYABLE_DATE
           , SH.REMARK
           , SH.CLOSED_YN
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_TYPE_V ST
          , (SELECT BA.BANK_ACCOUNT_ID
                  , FB.BANK_NAME
                  , BA.BANK_ACCOUNT_NAME
                  , BA.BANK_ACCOUNT_NUM
               FROM FI_BANK_ACCOUNT BA
                  , FI_BANK FB
              WHERE BA.BANK_ID      = FB.BANK_ID
            ) S_BA
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
         AND SH.SLIP_HEADER_ID          = W_SLIP_HEADER_ID
         AND SH.SOB_ID                  = W_SOB_ID
      ;
     
  END SELECT_SLIP_HEADER;

-- 전표 헤더 삽입.
  PROCEDURE INSERT_SLIP_HEADER
            ( P_SLIP_HEADER_ID      OUT FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_HEADER.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER.BUDGET_DEPT_ID%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
            , P_GL_NUM              IN FI_SLIP_HEADER.GL_NUM%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_HEADER.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_HEADER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_HEADER.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_HEADER.GL_CURRENCY_AMOUNT%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;      
    END IF;
    
    SELECT FI_SLIP_HEADER_S1.NEXTVAL
      INTO P_SLIP_HEADER_ID
      FROM DUAL;

    INSERT INTO FI_SLIP_HEADER
    ( SLIP_HEADER_ID
    , SLIP_DATE 
    , SLIP_NUM 
    , SOB_ID 
    , ORG_ID 
    , DEPT_ID 
    , PERSON_ID 
    , BUDGET_DEPT_ID 
    , ACCOUNT_BOOK_ID 
    , SLIP_TYPE 
    , PERIOD_NAME    
    , CONFIRM_YN
    , CONFIRM_DATE
    , CONFIRM_PERSON_ID
    , GL_DATE
    , GL_NUM
    , GL_AMOUNT 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , GL_CURRENCY_AMOUNT 
    , REQ_BANK_ACCOUNT_ID 
    , REQ_PAYABLE_TYPE 
    , REQ_PAYABLE_DATE 
    , REMARK 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_SLIP_HEADER_ID
    , P_SLIP_DATE
    , P_SLIP_NUM
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPT_ID
    , P_PERSON_ID
    , P_BUDGET_DEPT_ID
    , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(P_SOB_ID)
    , P_SLIP_TYPE
    , GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID), P_GL_DATE, P_SOB_ID, P_ORG_ID)
    , 'Y'
    , GET_LOCAL_DATE(P_SOB_ID)   -- 승인일시.
    , P_PERSON_ID   -- 승인자.
    , P_GL_DATE     -- 전표일자.
    , P_GL_NUM      -- 전표번호.
    , P_GL_AMOUNT 
    , P_CURRENCY_CODE 
    , P_EXCHANGE_RATE 
    , P_GL_CURRENCY_AMOUNT 
    , P_REQ_BANK_ACCOUNT_ID
    , P_REQ_PAYABLE_TYPE
    , P_REQ_PAYABLE_DATE
    , P_REMARK
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END INSERT_SLIP_HEADER;

-- 전표 헤더 수정.
  PROCEDURE UPDATE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_HEADER.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_HEADER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_HEADER.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_HEADER.GL_CURRENCY_AMOUNT%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;      
    END IF;
    
    IF FI_SLIP_G.SLIP_CLOSE_YN_F(W_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
        
    UPDATE FI_SLIP_HEADER
      SET SLIP_DATE           = P_SLIP_DATE
        , PERIOD_NAME         = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID), P_SLIP_DATE, P_SOB_ID, P_ORG_ID)
        , GL_AMOUNT           = P_GL_AMOUNT
        , CURRENCY_CODE       = P_CURRENCY_CODE
        , EXCHANGE_RATE       = P_EXCHANGE_RATE
        , GL_CURRENCY_AMOUNT  = P_GL_CURRENCY_AMOUNT
        , REQ_BANK_ACCOUNT_ID = P_REQ_BANK_ACCOUNT_ID
        , REQ_PAYABLE_TYPE    = P_REQ_PAYABLE_TYPE
        , REQ_PAYABLE_DATE    = P_REQ_PAYABLE_DATE
        , REMARK              = P_REMARK
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE SLIP_HEADER_ID      = W_SLIP_HEADER_ID
    ;
    
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END UPDATE_SLIP_HEADER;

-- 전표 헤더 삭제.
  PROCEDURE DELETE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            )
  AS
  BEGIN
    IF FI_SLIP_G.SLIP_CLOSE_YN_F(W_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    DELETE FI_SLIP_HEADER
    WHERE SLIP_HEADER_ID = W_SLIP_HEADER_ID;
    
  END DELETE_SLIP_HEADER;
  
---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID    IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , W_SOB_ID            IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID            IN FI_SLIP_LINE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SL.SLIP_LINE_ID
           , SL.SLIP_LINE_SEQ
           , SL.SLIP_HEADER_ID
           , SL.SOB_ID
           , SL.ACCOUNT_BOOK_ID
           , SL.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
           , SL.ACCOUNT_CONTROL_ID
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SL.CURRENCY_CODE
           , SL.CURRENCY_CODE AS CURRENCY_DESC
           , SL.EXCHANGE_RATE
           , SL.GL_CURRENCY_AMOUNT
           , SL.GL_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.CUSTOMER_ID
           , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
           , SCV.TAX_REG_NO
           , SL.BANK_ACCOUNT_ID
           , BAT.BANK_ACCOUNT_NAME
           , BAT.BANK_ACCOUNT_NUM           
           , SL.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SL.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC           
           , SL.MANAGEMENT1                           -- 계좌번호 OR CODE 값.
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT1_ID'
                                                          , SL.MANAGEMENT1
                                                          , SL.SOB_ID) AS MANAGEMENT1_DESC
           , SL.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT2_ID'
                                                          , SL.MANAGEMENT2
                                                          , SL.SOB_ID) AS MANAGEMENT2_DESC
           , SL.REFER1
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER1_ID'
                                                          , SL.REFER1
                                                          , SL.SOB_ID) AS REFER1_DESC
           , SL.REFER2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER2_ID'
                                                          , SL.REFER2
                                                          , SL.SOB_ID) AS REFER2_DESC
           , SL.REFER3
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER3_ID'
                                                          , SL.REFER3
                                                          , SL.SOB_ID) AS REFER3_DESC
           , SL.REFER4
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER4_ID'
                                                          , SL.REFER4
                                                          , SL.SOB_ID) AS REFER4_DESC
           , SL.REFER5
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER5_ID'
                                                          , SL.REFER5
                                                          , SL.SOB_ID) AS REFER5_DESC
           , SL.VOUCH_CODE
           , FI_COMMON_G.CODE_NAME_F('VOUCH_CODE', SL.VOUCH_CODE, SL.SOB_ID, SL.ORG_ID) AS VOUCH_NAME
           , SL.REFER_RATE
           , SL.REFER_AMOUNT
           , SL.REFER_DATE1
           , SL.REFER_DATE2
           , SL.REMARK
           , SL.CLOSED_YN
           , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT1_ID) AS MANAGEMENT1_NAME
           , DECODE(ACI.MANAGEMENT1_ID, NULL, 'F', NVL(ACI.MANAGEMENT1_YN, 'N')) AS MANAGEMENT1_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT1_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT1_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT2_ID) AS MANAGEMENT2_NAME
           , DECODE(ACI.MANAGEMENT2_ID, NULL, 'F', NVL(ACI.MANAGEMENT2_YN, 'N')) AS MANAGEMENT2_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT2_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT2_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER1_ID) AS REFER1_NAME
           , DECODE(ACI.REFER1_ID, NULL, 'F', NVL(ACI.REFER1_YN, 'N')) AS REFER1_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER1_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER1_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER2_ID) AS REFER2_NAME
           , DECODE(ACI.REFER2_ID, NULL, 'F', NVL(ACI.REFER2_YN, 'N')) AS REFER2_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER2_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER2_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER3_ID) AS REFER3_NAME
           , DECODE(ACI.REFER3_ID, NULL, 'F', NVL(ACI.REFER3_YN, 'N')) AS REFER3_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER3_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER3_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER4_ID) AS REFER4_NAME
           , DECODE(ACI.REFER4_ID, NULL, 'F', NVL(ACI.REFER4_YN, 'N')) AS REFER4_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER4_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER4_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER5_ID) AS REFER5_NAME
           , DECODE(ACI.REFER5_ID, NULL, 'F', NVL(ACI.REFER5_YN, 'N')) AS REFER5_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER5_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER5_LOOKUP_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER_RATE_ID) AS REFER_RATE_NAME
           , DECODE(ACI.REFER_RATE_ID, NULL, 'F', NVL(ACI.REFER_RATE_YN, 'N')) AS REFER_RATE_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER_AMOUNT_ID) AS REFER_AMOUNT_NAME
           , DECODE(ACI.REFER_AMOUNT_ID, NULL, 'F', NVL(ACI.REFER_AMOUNT_YN, 'N')) AS REFER_AMOUNT_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER_DATE1_ID) AS REFER_DATE1_NAME
           , DECODE(ACI.REFER_DATE1_ID, NULL, 'F', NVL(ACI.REFER_DATE1_YN, 'N')) AS REFER_DATE1_YN
           , FI_COMMON_G.ID_NAME_F(ACI.REFER_DATE2_ID) AS REFER_DATE2_NAME
           , DECODE(ACI.REFER_DATE2_ID, NULL, 'F', NVL(ACI.REFER_DATE2_YN, 'N')) AS REFER_DATE2_YN
           , NVL(ACI.VOUCH_YN, 'F') AS VOUCH_YN
           , NVL(AC.ACCOUNT_DR_CR, '1') AS CONTROL_ACCOUNT_DR_CR
           , NVL(AC.CUSTOMER_ENABLED_FLAG, 'N') AS CUSTOMER_ENABLED_FLAG
           , NVL(AC.BANK_ACCOUNT_FLAG, 'N') AS BANK_ACCOUNT_FLAG
           , NVL(AC.CURRENCY_ENABLED_FLAG, 'N') AS CURRENCY_ENABLED_FLAG
           , NVL(AC.VAT_ENABLED_FLAG, 'N') AS VAT_ENABLED_FLAG
           , NVL(AC.ACCOUNT_MICH_YN, 'N') AS ACCOUNT_MICH_YN
           , NVL(AC.BUDGET_ENABLED_FLAG, 'N') AS BUDGET_ENABLED_FLAG
           , NVL(AC.BUDGET_CONTROL_FLAG, 'N') AS BUDGET_CONTROL_FLAG
           , NVL(AC.BUDGET_BELONG_FLAG, 'N') AS BUDGET_BELONG_FLAG
           , NVL(AC.COST_CENTER_FLAG, 'N') AS COST_CENTER_FLAG
           , SL.UNLIQUIDATE_SLIP_HEADER_ID
           , SL.UNLIQUIDATE_SLIP_LINE_ID
        FROM FI_SLIP_LINE SL
          , FI_SUPP_CUST_V SCV
          , FI_ACCOUNT_CONTROL AC
          , FI_ACCOUNT_CONTROL_ITEM ACI
          , FI_BANK_ACCOUNT_TLV BAT          
       WHERE SL.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                  = ACI.SOB_ID(+)
         AND SL.BANK_ACCOUNT_ID         = BAT.BANK_ACCOUNT_ID(+)         
         AND SL.SLIP_HEADER_ID          = W_SLIP_HEADER_ID
         AND SL.SOB_ID                  = W_SOB_ID
      ORDER BY SL.SLIP_LINE_SEQ
      ;
      
  END SELECT_SLIP_LINE;

-- 전표 라인  삽입.
  PROCEDURE INSERT_SLIP_LINE
            ( P_SLIP_LINE_ID               OUT FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , P_SLIP_HEADER_ID             IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , P_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , P_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID             IN FI_SLIP_LINE.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID                IN FI_SLIP_LINE.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID             IN FI_SLIP_LINE.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID            IN FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_VOUCH_CODE                 IN FI_SLIP_LINE.VOUCH_CODE%TYPE
            , P_REFER_RATE                 IN FI_SLIP_LINE.REFER_RATE%TYPE
            , P_REFER_AMOUNT               IN FI_SLIP_LINE.REFER_AMOUNT%TYPE
            , P_REFER_DATE1                IN FI_SLIP_LINE.REFER_DATE1%TYPE
            , P_REFER_DATE2                IN FI_SLIP_LINE.REFER_DATE2%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_FUND_CODE                  IN FI_SLIP_LINE.FUND_CODE%TYPE
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SLIP_DATE           FI_SLIP_LINE.SLIP_DATE%TYPE;
    V_SLIP_NUM            FI_SLIP_LINE.SLIP_NUM%TYPE;
    V_DEPT_ID             FI_SLIP_LINE.DEPT_ID%TYPE;
    V_PERSON_ID           FI_SLIP_LINE.PERSON_ID%TYPE;
    V_ACCOUNT_BOOK_ID     FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE;
    V_SLIP_TYPE           FI_SLIP_LINE.SLIP_TYPE%TYPE;
    V_PERIOD_NAME         FI_SLIP_LINE.PERIOD_NAME%TYPE;
    V_CONFIRM_YN          FI_SLIP_LINE.CONFIRM_YN%TYPE;
    V_CONFIRM_DATE        FI_SLIP_LINE.CONFIRM_DATE%TYPE;
    V_CONFIRM_PERSON_ID   FI_SLIP_LINE.CONFIRM_PERSON_ID%TYPE;
    V_GL_DATE             FI_SLIP_LINE.GL_DATE%TYPE;
    V_GL_NUM              FI_SLIP_LINE.GL_NUM%TYPE;
    V_SLIP_LINE_SEQ       FI_SLIP_LINE.SLIP_LINE_SEQ%TYPE;
    
  BEGIN
    BEGIN
      SELECT SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.DEPT_ID
           , SH.PERSON_ID
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , SH.PERIOD_NAME
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , SH.CONFIRM_PERSON_ID
           , SH.GL_DATE
           , SH.GL_NUM           
        INTO V_SLIP_DATE
            , V_SLIP_NUM
            , V_DEPT_ID
            , V_PERSON_ID
            , V_ACCOUNT_BOOK_ID
            , V_SLIP_TYPE
            , V_PERIOD_NAME
            , V_CONFIRM_YN
            , V_CONFIRM_DATE
            , V_CONFIRM_PERSON_ID
            , V_GL_DATE
            , V_GL_NUM
        FROM FI_SLIP_HEADER SH
       WHERE SH.SLIP_HEADER_ID    = P_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

/*RAISE_APPLICATION_ERROR(-20001, 'SLIP_DATE : ' || TO_CHAR(V_SLIP_DATE, 'YYYY-MM-DD') || ', ' || GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, P_SOB_ID, P_ORG_ID) || ', SOB : ' || P_SOB_ID);
    */
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;      
    END IF;
    
    IF FI_SLIP_G.SLIP_CLOSE_YN_F(P_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    BEGIN
      SELECT NVL(MAX(SL.SLIP_LINE_SEQ), 0) + 1 AS SLIP_LINE_SEQ
        INTO V_SLIP_LINE_SEQ
        FROM FI_SLIP_LINE SL
       WHERE SL.SLIP_HEADER_ID    = P_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SLIP_LINE_SEQ := 1;
    END;
    
    SELECT FI_SLIP_LINE_S1.NEXTVAL
      INTO P_SLIP_LINE_ID
      FROM DUAL;

    INSERT INTO FI_SLIP_LINE
    ( SLIP_LINE_ID
    , SLIP_DATE 
    , SLIP_NUM 
    , SLIP_LINE_SEQ 
    , SLIP_HEADER_ID 
    , SOB_ID 
    , ORG_ID 
    , DEPT_ID 
    , PERSON_ID 
    , BUDGET_DEPT_ID 
    , ACCOUNT_BOOK_ID 
    , SLIP_TYPE 
    , PERIOD_NAME 
    , CONFIRM_YN
    , CONFIRM_DATE
    , CONFIRM_PERSON_ID    
    , GL_DATE 
    , GL_NUM 
    , CUSTOMER_ID 
    , ACCOUNT_CONTROL_ID 
    , ACCOUNT_CODE 
    , COST_CENTER_ID 
    , ACCOUNT_DR_CR 
    , GL_AMOUNT 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , GL_CURRENCY_AMOUNT 
    , BANK_ACCOUNT_ID 
    , MANAGEMENT1 
    , MANAGEMENT2 
    , REFER1 
    , REFER2 
    , REFER3 
    , REFER4 
    , REFER5 
    , VOUCH_CODE 
    , REFER_RATE 
    , REFER_AMOUNT 
    , REFER_DATE1 
    , REFER_DATE2 
    , REMARK 
    , UNLIQUIDATE_SLIP_HEADER_ID 
    , UNLIQUIDATE_SLIP_LINE_ID 
    , FUND_CODE 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_SLIP_LINE_ID
    , V_SLIP_DATE
    , V_SLIP_NUM
    , V_SLIP_LINE_SEQ
    , P_SLIP_HEADER_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_DEPT_ID
    , V_PERSON_ID
    , P_BUDGET_DEPT_ID
    , V_ACCOUNT_BOOK_ID
    , V_SLIP_TYPE
    , V_PERIOD_NAME
    , V_CONFIRM_YN
    , V_CONFIRM_DATE
    , V_CONFIRM_PERSON_ID
    , V_GL_DATE
    , V_GL_NUM
    , P_CUSTOMER_ID
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_COST_CENTER_ID
    , P_ACCOUNT_DR_CR
    , P_GL_AMOUNT
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_GL_CURRENCY_AMOUNT
    , P_BANK_ACCOUNT_ID
    , P_MANAGEMENT1
    , P_MANAGEMENT2
    , P_REFER1
    , P_REFER2
    , P_REFER3
    , P_REFER4
    , P_REFER5
    , P_VOUCH_CODE
    , P_REFER_RATE
    , P_REFER_AMOUNT
    , P_REFER_DATE1
    , P_REFER_DATE2
    , P_REMARK
    , P_UNLIQUIDATE_SLIP_HEADER_ID
    , P_UNLIQUIDATE_SLIP_LINE_ID
    , P_FUND_CODE
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END INSERT_SLIP_LINE;

-- 전표라인 수정.
  PROCEDURE UPDATE_SLIP_LINE
            ( W_SLIP_LINE_ID               IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , W_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID             IN FI_SLIP_LINE.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID                IN FI_SLIP_LINE.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID             IN FI_SLIP_LINE.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID            IN FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_VOUCH_CODE                 IN FI_SLIP_LINE.VOUCH_CODE%TYPE
            , P_REFER_RATE                 IN FI_SLIP_LINE.REFER_RATE%TYPE
            , P_REFER_AMOUNT               IN FI_SLIP_LINE.REFER_AMOUNT%TYPE
            , P_REFER_DATE1                IN FI_SLIP_LINE.REFER_DATE1%TYPE
            , P_REFER_DATE2                IN FI_SLIP_LINE.REFER_DATE2%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_FUND_CODE                  IN FI_SLIP_LINE.FUND_CODE%TYPE            
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            )
  AS
    V_SLIP_DATE           FI_SLIP_LINE.SLIP_DATE%TYPE;
    V_SLIP_HEADER_ID      FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT SH.SLIP_DATE
           , SH.SLIP_HEADER_ID
        INTO V_SLIP_DATE
           , V_SLIP_HEADER_ID
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_LINE SL
       WHERE SH.SLIP_HEADER_ID    = SL.SLIP_HEADER_ID
         AND SL.SLIP_LINE_ID      = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;
    
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, W_SOB_ID, W_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;      
    END IF;
    
    IF FI_SLIP_G.SLIP_CLOSE_YN_F(V_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    UPDATE FI_SLIP_LINE
      SET SLIP_DATE                  = V_SLIP_DATE
        , BUDGET_DEPT_ID             = P_BUDGET_DEPT_ID
        , CUSTOMER_ID                = P_CUSTOMER_ID
        , ACCOUNT_CONTROL_ID         = P_ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE               = P_ACCOUNT_CODE
        , COST_CENTER_ID             = P_COST_CENTER_ID
        , ACCOUNT_DR_CR              = P_ACCOUNT_DR_CR
        , GL_AMOUNT                  = P_GL_AMOUNT
        , CURRENCY_CODE              = P_CURRENCY_CODE
        , EXCHANGE_RATE              = P_EXCHANGE_RATE
        , GL_CURRENCY_AMOUNT         = P_GL_CURRENCY_AMOUNT
        , BANK_ACCOUNT_ID            = P_BANK_ACCOUNT_ID
        , MANAGEMENT1                = P_MANAGEMENT1
        , MANAGEMENT2                = P_MANAGEMENT2
        , REFER1                     = P_REFER1
        , REFER2                     = P_REFER2
        , REFER3                     = P_REFER3
        , REFER4                     = P_REFER4
        , REFER5                     = P_REFER5
        , VOUCH_CODE                 = P_VOUCH_CODE
        , REFER_RATE                 = P_REFER_RATE
        , REFER_AMOUNT               = P_REFER_AMOUNT
        , REFER_DATE1                = P_REFER_DATE1
        , REFER_DATE2                = P_REFER_DATE2
        , REMARK                     = P_REMARK
        , UNLIQUIDATE_SLIP_HEADER_ID = P_UNLIQUIDATE_SLIP_HEADER_ID
        , UNLIQUIDATE_SLIP_LINE_ID   = P_UNLIQUIDATE_SLIP_LINE_ID
        , FUND_CODE                  = P_FUND_CODE
        , LAST_UPDATE_DATE           = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY            = P_USER_ID
    WHERE SLIP_LINE_ID               = W_SLIP_LINE_ID;
  
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END UPDATE_SLIP_LINE;

-- 전표 라인 삭제.
  PROCEDURE DELETE_SLIP_LINE
            ( W_SLIP_LINE_ID      IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            )
  AS
    V_SLIP_HEADER_ID              FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT SL.SLIP_HEADER_ID
        INTO V_SLIP_HEADER_ID
        FROM FI_SLIP_LINE SL
       WHERE SL.SLIP_LINE_ID      = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;
    
    IF FI_SLIP_G.SLIP_CLOSE_YN_F(V_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    DELETE FI_SLIP_LINE
    WHERE SLIP_LINE_ID = W_SLIP_LINE_ID;
   
  END DELETE_SLIP_LINE;
    
END FI_SLIP_PAYABLE_RECEIPT_G;
/
