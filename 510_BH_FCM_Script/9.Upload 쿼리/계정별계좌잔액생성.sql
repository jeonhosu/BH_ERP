/*
SELECT *
  FROM FI_DAILY_BANK_ACCOUNT_SUM DS
WHERE DS.SOB_ID     = 20
FOR UPDATE              
;

*/

DECLARE
  V_DR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- 차변금액
  V_CR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- 대변금액
  V_DR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 차변금액(외화)
  V_CR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 대변금액(외화)
  
  V_BANK_ACCOUNT_ID   NUMBER;
  
BEGIN
  FOR C1 IN (SELECT SL.*
                   , SMI.MANAGEMENT_VALUE
                FROM FI_SLIP_LINE SL
                   , FI_SLIP_MANAGEMENT_ITEM SMI
                   , FI_MANAGEMENT_CODE_V MC
              WHERE SL.SLIP_LINE_ID         = SMI.SLIP_LINE_ID
                AND SMI.MANAGEMENT_ID       = MC.MANAGEMENT_ID
                AND SL.SOB_ID     = 20
                AND MC.LOOKUP_TYPE          = 'BANK_ACCOUNT'
           )
  LOOP
    V_DR_AMOUNT       := 0;
    V_CR_AMOUNT       := 0;
    V_DR_CURR_AMOUNT  := 0;
    V_CR_CURR_AMOUNT  := 0;

    -- 차대구분에 따른 금액
    IF C1.ACCOUNT_DR_CR = '1' THEN
        V_DR_AMOUNT      := C1.GL_AMOUNT;
        V_DR_CURR_AMOUNT := C1.GL_CURRENCY_AMOUNT;
    ELSE
        V_CR_AMOUNT      := C1.GL_AMOUNT;
        V_CR_CURR_AMOUNT := C1.GL_CURRENCY_AMOUNT;
    END IF;
    
    BEGIN    
      SELECT BA.BANK_ACCOUNT_ID
        INTO V_BANK_ACCOUNT_ID
        FROM FI_BANK_ACCOUNT BA
      WHERE BA.BANK_ACCOUNT_CODE                  = C1.MANAGEMENT_VALUE
        AND BA.SOB_ID                             = C1.SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    BEGIN
         UPDATE FI_DAILY_BANK_ACCOUNT_SUM
            SET DR_AMOUNT       = DR_AMOUNT      + V_DR_AMOUNT,
                CR_AMOUNT       = CR_AMOUNT      + V_CR_AMOUNT,
                DR_CURR_AMOUNT  = DR_CURR_AMOUNT + V_DR_CURR_AMOUNT,
                CR_CURR_AMOUNT  = CR_CURR_AMOUNT + V_CR_CURR_AMOUNT,
                EXCHANGE_RATE   = C1.EXCHANGE_RATE,
                LAST_UPDATE_DATE  = TO_DATE('2011-01-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'),
                LAST_UPDATED_BY   = -1

          WHERE GL_DATE            = C1.GL_DATE
            AND GL_DATE_SEQ        = 1
            AND SOB_ID             = C1.SOB_ID
            AND ACCOUNT_BOOK_ID    = C1.ACCOUNT_BOOK_ID
            AND ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
            AND BANK_ACCOUNT_ID    = V_BANK_ACCOUNT_ID ;

          IF SQL%ROWCOUNT = 0 THEN
             INSERT INTO FI_DAILY_BANK_ACCOUNT_SUM
             VALUES  (  C1.GL_DATE,            1,
                        C1.SOB_ID,             C1.ORG_ID,
                        C1.ACCOUNT_BOOK_ID,    C1.ACCOUNT_CONTROL_ID,
                        C1.ACCOUNT_CODE,       V_BANK_ACCOUNT_ID,
                        V_DR_AMOUNT,          V_CR_AMOUNT,
                        C1.EXCHANGE_RATE,      C1.EXCHANGE_RATE,
                        V_DR_CURR_AMOUNT,     V_CR_CURR_AMOUNT,
                        TO_DATE('2011-01-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'),      -1,
                      TO_DATE('2011-01-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'),      -1);

          END IF;
      END;
  END LOOP C1;
END;      
