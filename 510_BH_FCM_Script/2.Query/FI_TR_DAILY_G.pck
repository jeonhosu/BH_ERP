CREATE OR REPLACE PACKAGE FI_TR_DAILY_G
AS

  PROCEDURE TR_DAILY_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );

-- 자금 계획 조회.
  PROCEDURE TR_DAILY_PLAN_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
            
-- 일일 자금현황 생성.
  PROCEDURE TR_DAILY_CREATE
            ( W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            );
            
END FI_TR_DAILY_G;
/
CREATE OR REPLACE PACKAGE BODY FI_TR_DAILY_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_TR_DAILY_G
/* Description  : 일일자금일보 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
  PROCEDURE TR_DAILY_SELECT
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    --OPEN P_CURSOR FOR
      NULL;

  END TR_DAILY_SELECT;

-- 자금 계획 조회.
  PROCEDURE TR_DAILY_PLAN_SELECT
            ( P_CURSOR1         OUT TYPES.TCURSOR1
            , W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT TD.TR_DAILY_ID
           , TD.TR_TYPE
           , TD.SOB_ID
           , TD.GL_DATE
           , TD.ACCOUNT_CONTROL_ID
           , TD.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , AC.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AC.ACCOUNT_DR_CR, AC.SOB_ID) AS ACCOUNT_DR_CR_NAME
           , TD.CURRENCY_CODE
           , TD.EXCHANGE_RATE
           , TD.GL_CURRENCY_AMOUNT
           , TD.GL_AMOUNT
           , TD.CUSTOMER_CODE
           , FB.BANK_NAME
           , TD.BANK_ACCOUNT_CODE
           , BA.BANK_ID
           , TD.REMARK
           , TD.FUND_MOVE
           , FI_COMMON_G.CODE_NAME_F('FUND_MOVE', TD.FUND_MOVE, TD.SOB_ID) AS FUND_MOVE_NAME
           , TD.LOAN_USE
           , TD.LOAN_NUM
        FROM FI_TR_DAILY TD
          , FI_ACCOUNT_CONTROL AC
          , FI_BANK_ACCOUNT BA
          , FI_BANK FB
      WHERE TD.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
        AND TD.BANK_ACCOUNT_CODE      = BA.BANK_ACCOUNT_CODE(+)
        AND TD.SOB_ID                 = BA.SOB_ID(+)
        AND BA.BANK_ID                = FB.BANK_ID(+)
        AND TD.GL_DATE                = W_GL_DATE
        AND TD.SOB_ID                 = W_SOB_ID
        AND TD.TR_TYPE                = 'PLAN'
      ORDER BY TD.ACCOUNT_CODE
      ;
  
  END TR_DAILY_PLAN_SELECT;
  
-- 일일 자금현황 생성.
  PROCEDURE TR_DAILY_CREATE
            ( W_GL_DATE         IN DATE
            , W_SOB_ID          IN NUMBER
            )
  AS
  BEGIN
    BEGIN
      DELETE FROM FI_TR_DAILY TD
      WHERE TD.TR_TYPE          = 'SLIP'
        AND TD.GL_DATE          = W_GL_DATE
        AND TD.SOB_ID           = W_SOB_ID            
      ;
    END;
    FOR C1 IN (SELECT 'SLIP' AS TR_TYPE
                     , SL.GL_DATE
                     , SL.SOB_ID
                     , SL.ACCOUNT_CONTROL_ID                     
                     , SL.ACCOUNT_CODE
                     , SL.ACCOUNT_DR_CR                     
                     , SL.CURRENCY_CODE
                     , SL.EXCHANGE_RATE   
                     , SL.GL_CURRENCY_AMOUNT
                     , SL.GL_AMOUNT
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'CUSTOMER', SL.SOB_ID) AS CUSTOMER_CODE
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'BANK_ACCOUNT', SL.SOB_ID) AS BANK_ACCOUNT_CODE                                          
                     , SL.REMARK
                     , SL.SLIP_LINE_ID
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'FUND_MOVE', SL.SOB_ID) AS FUND_MOVE
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_USE', SL.SOB_ID) AS LOAN_USE
                     , FI_SLIP_G.SLIP_ITEM_VALUE_F(SL.SLIP_LINE_ID, 'LOAN_NUM', SL.SOB_ID) AS LOAN_NUM
                     , MA.TR_CATEGORY
                     , MA.TR_CLASS
                     , 'N' CLOSED_YN
                  FROM FI_SLIP_LINE SL
                    , ( SELECT FC.VALUE1 AS ACCOUNT_CODE
                            , FC.VALUE2 AS ACCOUNT_DESC
                            , FC.VALUE3 AS TR_CATEGORY
                            , FC.VALUE4 AS TR_CLASS
                            , FC.SOB_ID
                          FROM FI_COMMON FC
                        WHERE FC.GROUP_CODE   = 'TR_MANAGE_ACCOUNT'
                          AND FC.SOB_ID       = W_SOB_ID
                      ) MA
                WHERE SL.ACCOUNT_CODE             = MA.ACCOUNT_CODE
                  AND SL.SOB_ID                   = MA.SOB_ID  
                  AND SL.GL_DATE                  = W_GL_DATE
                  AND SL.SOB_ID                   = W_SOB_ID  
                ORDER BY SL.ACCOUNT_CODE
               )
    LOOP        
      -- 자금현황.
      INSERT INTO FI_TR_DAILY
      ( TR_DAILY_ID
      , TR_TYPE
      , SOB_ID
      , GL_DATE
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE           
      , ACCOUNT_DR_CR
      , CURRENCY_CODE
      , EXCHANGE_RATE
      , GL_CURRENCY_AMOUNT
      , GL_AMOUNT
      , CUSTOMER_CODE
      , BANK_ACCOUNT_CODE      
      , REMARK
      , SLIP_LINE_ID
      , FUND_MOVE
      , LOAN_USE
      , LOAN_NUM
      , TR_CATEGORY
      , TR_CLASS
      , CLOSED_YN
      ) VALUES
      ( FI_TR_DAILY_S1.NEXTVAL
      , C1.TR_TYPE
      , C1.SOB_ID
      , C1.GL_DATE
      , C1.ACCOUNT_CONTROL_ID
      , C1.ACCOUNT_CODE
      , C1.ACCOUNT_DR_CR
      , C1.CURRENCY_CODE
      , C1.EXCHANGE_RATE
      , C1.GL_CURRENCY_AMOUNT
      , C1.GL_AMOUNT
      , C1.CUSTOMER_CODE
      , C1.BANK_ACCOUNT_CODE      
      , C1.REMARK
      , C1.SLIP_LINE_ID
      , C1.FUND_MOVE
      , C1.LOAN_USE
      , C1.LOAN_NUM
      , C1.TR_CATEGORY
      , C1.TR_CLASS
      , C1.CLOSED_YN            
      );
    
    END LOOP C1;
    COMMIT;
    
  END TR_DAILY_CREATE;
  
END FI_TR_DAILY_G;
/
