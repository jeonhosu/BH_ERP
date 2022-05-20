DECLARE

BEGIN

  FOR C1 IN ( SELECT SL.SOB_ID
                   , SL.ORG_ID
                   , SL.PERIOD_NAME
                   , SL.GL_DATE
                   , SL.ACCOUNT_BOOK_ID
                   , SL.ACCOUNT_CONTROL_ID
                   , SL.ACCOUNT_CODE
                   , SL.ACCOUNT_DR_CR
                   , SC.SUPP_CUST_ID AS CUSTOMER_ID
                   , SL.GL_AMOUNT
                   , SL.CURRENCY_CODE
                   , SL.GL_CURRENCY_AMOUNT
                   , SL.MANAGEMENT1
                   , SL.MANAGEMENT2
                   , SL.CREATION_DATE
                   , SL.CREATED_BY
                   , SL.LAST_UPDATE_DATE
                   , SL.LAST_UPDATED_BY
                FROM FI_SLIP_LINE SL
                  , FI_SLIP_HEADER SH
                  , FI_SLIP_MANAGEMENT_ITEM MI
                  , FI_MANAGEMENT_CODE_V MC
                  , FI_SUPP_CUST_V SC
              WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                AND SL.SLIP_LINE_ID             = MI.SLIP_LINE_ID
                AND MI.MANAGEMENT_ID            = MC.MANAGEMENT_ID
                AND MC.LOOKUP_TYPE              = 'CUSTOMER'
                AND MI.MANAGEMENT_VALUE         = SC.SUPP_CUST_CODE
                AND MI.SOB_ID                   = SC.SOB_ID
                AND SH.GL_DATE                  >= &W_GL_DATE
                AND SL.SOB_ID                   = &W_SOB_ID
                AND SL.CONFIRM_YN               = 'Y'
              )
  LOOP
  
-- 월별 합계.
    FI_CUSTOMER_BALANCE_P(    'I',             C1.SOB_ID,
                              C1.ORG_ID,                       C1.PERIOD_NAME,
                              C1.ACCOUNT_BOOK_ID,              C1.ACCOUNT_CONTROL_ID,
                              C1.ACCOUNT_CODE,                 C1.ACCOUNT_DR_CR,
                              C1.CUSTOMER_ID,                  C1.GL_AMOUNT,
                              C1.CURRENCY_CODE,                C1.GL_CURRENCY_AMOUNT,
                              C1.MANAGEMENT1,                  C1.MANAGEMENT2,
                              C1.CREATION_DATE,                C1.CREATED_BY,
                              C1.LAST_UPDATE_DATE,             C1.LAST_UPDATED_BY  );

    -- 일별 합계.
    FI_CUSTOMER_BALANCE_DAILY_P ( 'I'
                                , C1.SOB_ID
                                , C1.ORG_ID
                                , C1.GL_DATE
                                , C1.ACCOUNT_BOOK_ID
                                , C1.ACCOUNT_CONTROL_ID
                                , C1.ACCOUNT_CODE
                                , C1.ACCOUNT_DR_CR
                                , C1.CUSTOMER_ID
                                , C1.GL_AMOUNT
                                , C1.CURRENCY_CODE
                                , C1.GL_CURRENCY_AMOUNT
                                , C1.CREATION_DATE
                                , C1.CREATED_BY
                                , C1.LAST_UPDATE_DATE
                                , C1.LAST_UPDATED_BY
                                );
  END LOOP C1;
                                
END;

/*
SELECT *
  FROM FI_CUSTOMER_BALANCE_DAILY
FOR UPDATE  
  ;
  
SELECT *
  FROM FI_CUSTOMER_BALANCE X
FOR UPDATE
;*/

/*
DELETE
  FROM FI_CUSTOMER_BALANCE_DAILY
  
  ;
  
DELETE
  FROM FI_CUSTOMER_BALANCE X

;*/

