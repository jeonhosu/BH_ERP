CREATE OR REPLACE PACKAGE FI_UNLIQUIDATE_G
AS

---------------------------------------------------------------------------------------------------
-- 반제대상 조회.
  PROCEDURE SELECT_UNLIQUIDATE_HEADER
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , W_ACCOUNT_CONTROL_ID  IN FI_UNLIQUIDATE_HEADER.ACCOUNT_CONTROL_ID%TYPE
            , W_MANAGEMENT1         IN FI_UNLIQUIDATE_HEADER.MANAGEMENT1%TYPE
            , W_CURRENCY_CODE       IN FI_UNLIQUIDATE_HEADER.CURRENCY_CODE%TYPE
            , W_ACCOUNT_DR_CR       IN FI_UNLIQUIDATE_HEADER.ACCOUNT_DR_CR%TYPE
            , W_SOB_ID              IN FI_UNLIQUIDATE_HEADER.SOB_ID%TYPE
            , W_ORG_ID              IN FI_UNLIQUIDATE_HEADER.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 반제대상 조회.
  PROCEDURE SELECT_UNLIQUIDATE_LIST
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , W_ACCOUNT_CONTROL_ID  IN FI_UNLIQUIDATE_HEADER.ACCOUNT_CONTROL_ID%TYPE
            , W_CUSTOMER_ID         IN FI_UNLIQUIDATE_HEADER.CUSTOMER_ID%TYPE
            , W_CURRENCY_CODE       IN FI_UNLIQUIDATE_HEADER.CURRENCY_CODE%TYPE
            , W_ACCOUNT_DR_CR       IN FI_UNLIQUIDATE_HEADER.ACCOUNT_DR_CR%TYPE
            , W_SOB_ID              IN FI_UNLIQUIDATE_HEADER.SOB_ID%TYPE
            , W_ORG_ID              IN FI_UNLIQUIDATE_HEADER.ORG_ID%TYPE
            );
    
END FI_UNLIQUIDATE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_UNLIQUIDATE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_UNLIQUIDATE_G
/* Description  : 미반제대상(HEADER) 반제처리 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 반제대상 조회.
  PROCEDURE SELECT_UNLIQUIDATE_HEADER
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , W_ACCOUNT_CONTROL_ID  IN FI_UNLIQUIDATE_HEADER.ACCOUNT_CONTROL_ID%TYPE
            , W_MANAGEMENT1         IN FI_UNLIQUIDATE_HEADER.MANAGEMENT1%TYPE
            , W_CURRENCY_CODE       IN FI_UNLIQUIDATE_HEADER.CURRENCY_CODE%TYPE
            , W_ACCOUNT_DR_CR       IN FI_UNLIQUIDATE_HEADER.ACCOUNT_DR_CR%TYPE
            , W_SOB_ID              IN FI_UNLIQUIDATE_HEADER.SOB_ID%TYPE
            , W_ORG_ID              IN FI_UNLIQUIDATE_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT 'N' AS CHECK_YN
           , UH.GL_DATE
           , UH.GL_NUM
           , UH.CURRENCY_CODE
           , UH.EXCHANGE_RATE
           , UH.GL_CURRENCY_AMOUNT
           , UH.GL_AMOUNT     
           , UH.GL_REMAIN_AMOUNT
           , UH.GL_REMAIN_CURRENCY_AMOUNT
           , UH.SLIP_LINE_ID
           , NULL AS NEW_EXCHANGE_RATE
           , 0 AS NEW_CURRENCY_AMOUNT
           , 0 AS NEW_GL_AMOUNT           
        FROM FI_UNLIQUIDATE_HEADER UH
          , FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL_ITEM ACI
       WHERE UH.SLIP_LINE_ID            = SL.SLIP_LINE_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                  = ACI.SOB_ID(+)
         AND UH.SOB_ID                  = W_SOB_ID
         AND UH.ACCOUNT_BOOK_ID         = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID)
         AND UH.ACCOUNT_CONTROL_ID      = W_ACCOUNT_CONTROL_ID
         AND UH.MANAGEMENT1             = W_MANAGEMENT1
         AND UH.CURRENCY_CODE           = W_CURRENCY_CODE
         AND UH.ACCOUNT_DR_CR           <> W_ACCOUNT_DR_CR
         AND UH.SLIP_STATUS             IN ('N', 'P')
      ;

  END SELECT_UNLIQUIDATE_HEADER;
  
-- 반제대상 조회.
  PROCEDURE SELECT_UNLIQUIDATE_LIST
            ( P_CURSOR1             OUT TYPES.TCURSOR1
            , W_ACCOUNT_CONTROL_ID  IN FI_UNLIQUIDATE_HEADER.ACCOUNT_CONTROL_ID%TYPE
            , W_CUSTOMER_ID         IN FI_UNLIQUIDATE_HEADER.CUSTOMER_ID%TYPE
            , W_CURRENCY_CODE       IN FI_UNLIQUIDATE_HEADER.CURRENCY_CODE%TYPE
            , W_ACCOUNT_DR_CR       IN FI_UNLIQUIDATE_HEADER.ACCOUNT_DR_CR%TYPE
            , W_SOB_ID              IN FI_UNLIQUIDATE_HEADER.SOB_ID%TYPE
            , W_ORG_ID              IN FI_UNLIQUIDATE_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT 'N' AS CHECK_YN
           , UH.GL_DATE
           , UH.GL_NUM
           , UH.CURRENCY_CODE
           , UH.EXCHANGE_RATE
           , UH.GL_CURRENCY_AMOUNT
           , UH.GL_AMOUNT     
           , UH.GL_REMAIN_AMOUNT
           , UH.GL_REMAIN_CURRENCY_AMOUNT
           , UH.SLIP_LINE_ID
           , NULL AS NEW_EXCHANGE_RATE
           , 0 AS NEW_CURRENCY_AMOUNT
           , 0 AS NEW_GL_AMOUNT
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
        FROM FI_UNLIQUIDATE_HEADER UH
          , FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL_ITEM ACI
       WHERE UH.SLIP_LINE_ID            = SL.SLIP_LINE_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                  = ACI.SOB_ID(+)
         AND UH.SOB_ID                  = W_SOB_ID
         AND UH.ACCOUNT_BOOK_ID         = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(W_SOB_ID)
         AND UH.ACCOUNT_CONTROL_ID      = W_ACCOUNT_CONTROL_ID
         AND UH.CUSTOMER_ID             = W_CUSTOMER_ID
         AND UH.CURRENCY_CODE           = W_CURRENCY_CODE
         AND UH.ACCOUNT_DR_CR           <> W_ACCOUNT_DR_CR
         AND UH.SLIP_STATUS             IN ('N', 'P')
      ;

  END SELECT_UNLIQUIDATE_LIST;
  
END FI_UNLIQUIDATE_G;
/
