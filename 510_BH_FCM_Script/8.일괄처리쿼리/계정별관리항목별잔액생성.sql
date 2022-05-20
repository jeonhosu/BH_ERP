DECLARE
BEGIN

  FOR C1 IN ( SELECT SMI.SLIP_LINE_ID
                   , SL.GL_DATE
                   , SL.SOB_ID
                   , SL.ORG_ID
                   , SL.ACCOUNT_CONTROL_ID
                   , SL.ACCOUNT_CODE
                   , SL.ACCOUNT_DR_CR
                   , SL.GL_AMOUNT
                   , SL.CURRENCY_CODE
                   , SL.EXCHANGE_RATE
                   , SL.GL_CURRENCY_AMOUNT
                   , SMI.MANAGEMENT_SEQ
                   , SMI.MANAGEMENT_ID
                   , SMI.MANAGEMENT_CODE
                   , SMI.MANAGEMENT_VALUE
                   , SL.CREATED_BY
                FROM FI_SLIP_MANAGEMENT_ITEM SMI
                  , FI_SLIP_LINE SL
              WHERE SMI.SLIP_LINE_ID         = SL.SLIP_LINE_ID
                AND SL.CONFIRM_YN            = 'Y'
                AND SMI.SOB_ID               = &W_SOB_ID
              ORDER BY SMI.MANAGEMENT_SEQ    
            )
  LOOP
    BEGIN 
      FI_MANAGEMENT_BALANCE_G.MANAGEMENT_BALANCE_SAVE_P
          ( P_GUBUN             => 'I'
          , P_GL_DATE           => C1.GL_DATE
          , P_SOB_ID            => C1.SOB_ID
          , P_ORG_ID            => C1.ORG_ID
          , P_ACCOUNT_CONTROL_ID  => C1.ACCOUNT_CONTROL_ID
          , P_MANAGEMENT_ID     => C1.MANAGEMENT_ID
          , P_MANAGEMENT_VALUE  => C1.MANAGEMENT_VALUE
          , P_ACCOUNT_DR_CR     => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT         => C1.GL_AMOUNT
          , P_CURRENCY_CODE     => C1.CURRENCY_CODE
          , P_EXCHANGE_RATE     => C1.EXCHANGE_RATE
          , P_GL_CURRENCY_AMOUNT  => C1.GL_CURRENCY_AMOUNT
          , P_ACCOUNT_CODE      => C1.ACCOUNT_CODE
          , P_USER_ID           => C1.CREATED_BY
          );      
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  END LOOP C1;

END;        
/*
select *
  from fi_management_balance x  -- S20090181
; 

select *
  from fi_management_balance x  -- S20090181
for update
;    
  */
