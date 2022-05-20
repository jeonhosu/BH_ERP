CREATE OR REPLACE PROCEDURE FI_ACCT_MGMT_BALANCE_P
                          ( P_GB                           IN VARCHAR2
                          , P_SOB_ID                       IN FI_SLIP_LINE.SOB_ID%TYPE
                          , P_ORG_ID                       IN FI_SLIP_LINE.ORG_ID%TYPE
                          , P_SLIP_LINE_ID                 IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
                          , P_GL_DATE                      IN FI_SLIP_LINE.GL_DATE%TYPE
                          , P_ACCOUNT_BOOK_ID              IN FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE
                          , P_PERIOD_NAME                  IN FI_SLIP_LINE.PERIOD_NAME%TYPE
                          , P_ACCOUNT_CONTROL_ID           IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE 
                          , P_ACCOUNT_CODE                 IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE 
                          , P_ACCOUNT_DR_CR                IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
                          , P_GL_AMOUNT                    IN FI_SLIP_LINE.GL_AMOUNT%TYPE
                          , P_CURRENCY_CODE                IN FI_SLIP_LINE.CURRENCY_CODE%TYPE 
                          , P_GL_CURRENCY_AMOUNT           IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
                          , P_CREATION_DATE                IN FI_SLIP_LINE.CREATION_DATE%TYPE 
                          , P_CREATED_BY                   IN FI_SLIP_LINE.CREATED_BY%TYPE 
                          , P_LAST_UPDATE_DATE             IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE
                          , P_LAST_UPDATED_BY              IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE
                          )
AS
  V_DR_AMOUNT             FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;           -- 차변금액
  V_CR_AMOUNT             FI_SLIP_LINE.GL_AMOUNT%TYPE := 0;           -- 대변금액
  V_DR_CURR_AMOUNT        FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE := 0;  -- 차변금액(외화)
  V_CR_CURR_AMOUNT        FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE := 0;  -- 대변금액(외화)
  V_ACCT_MGMT_BALANCE_ID  FI_ACCT_MGMT_BALANCE.ACCT_MGMT_BALANCE_ID%TYPE;   -- 잔액 금액.
  V_ACCT_MGMT_SEQ         FI_ACCT_MGMT_BALANCE.ACCT_MGMT_SEQ%TYPE;          -- 일자,계정,통화 일련번호.
BEGIN
  IF P_ACCOUNT_DR_CR = '1' THEN
    V_DR_AMOUNT := NVL(P_GL_AMOUNT, 0);
    V_DR_CURR_AMOUNT := NVL(P_GL_CURRENCY_AMOUNT, 0);
  ELSIF P_ACCOUNT_DR_CR = '2' THEN
    V_CR_AMOUNT := NVL(P_GL_AMOUNT, 0);
    V_CR_CURR_AMOUNT := NVL(P_GL_CURRENCY_AMOUNT, 0);    
  END IF;
  
  IF P_GB = 'I' THEN
  -- 전표 입력.
    BEGIN
      -- 관리항목.
      SELECT DISTINCT MBI.ACCT_MGMT_BALANCE_ID
        INTO V_ACCT_MGMT_BALANCE_ID
        FROM FI_ACCT_MGMT_BALANCE_ITEM MBI
          , FI_ACCT_MGMT_BALANCE AMB
      WHERE MBI.ACCT_MGMT_BALANCE_ID = AMB.ACCT_MGMT_BALANCE_ID
        AND MBI.SOB_ID               = &W_SOB_ID
        AND EXISTS( SELECT 'X'
                      FROM FI_SLIP_MANAGEMENT_ITEM SMI
                        , FI_SLIP_LINE SL
                    WHERE SMI.SLIP_LINE_ID      = SL.SLIP_LINE_ID
                      AND SL.GL_DATE            = AMB.GL_DATE
                      AND SL.ACCOUNT_CONTROL_ID = AMB.ACCOUNT_CONTROL_ID
                      AND SL.CURRENCY_CODE      = AMB.CURRENCY_CODE
                      AND SMI.MANAGEMENT_ID     = MBI.MANAGEMENT_ID
                      AND SMI.SOB_ID            = MBI.SOB_ID
                      AND SMI.MANAGEMENT_VALUE  = MBI.MANAGEMENT_VALUE
                      AND SL.SLIP_LINE_ID       = P_SLIP_LINE_ID
                   )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACCT_MGMT_BALANCE_ID := -1;
      DBMS_OUTPUT.PUT_LINE('ACCT_MGMT_BALANCE_ID CHECK ERROR : ' || SQLERRM);
    END;
    IF V_ACCT_MGMT_BALANCE_ID = 0 THEN
    
    
    END IF;
    
    BEGIN
      V_ACCT_MGMT_SEQ
      
      INSERT INTO FI_ACCT_MGMT_BALANCE 
      ( ACCT_MGMT_BALANCE_ID
      , GL_DATE, GL_DATE_SEQ
      , SOB, ORG_ID
      , ACCOUNT_BOOK_ID, PERIOD_NAME
      , ACCOUNT_CONTROL_ID, ACCOUNT_CODE, CURRENCY_CODE
      , ACCT_MGMT_SEQ
      , DR_SUM, CR_SUM
      , DR_CURR_SUM, CR_CURR_SUM
      , CREATION_DATE, CREAED_BY
      , LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( V_ACCT_MGMT_BALANCE_ID
      , P_GL_DATE, 1
      , P_SOB_ID, P_ORG_ID
      , P_ACCOUNT_BOOK_ID, P_PERIOD_NAME
      , P_ACCOUNT_CONTROL_ID, P_ACCOUNT_CODE, P_CURRENCY_CODE
      , V_ACCT_MGMT_SEQ
      , V_DR_AMOUNT, V_CR_AMOUNT
      , V_DR_CURR_AMOUNT, V_CR_CURR_AMOUNT
      , P_CREATE_DATE, P_CREATED_BY
      , P_LAST_UPDATE_DATE, P_LAST_UPDATED_BY
      );
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, '', NULL));
    END;
    
  ELSE
  -- 전표 삭제.
  
  END IF;
  


END FI_ACCT_MGMT_BALANCE_P;
