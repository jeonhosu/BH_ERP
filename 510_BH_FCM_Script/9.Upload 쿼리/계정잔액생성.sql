/*SELECT *
  FROM FI_DAILY_SUM DS
WHERE DS.SOB_ID     = 20
  AND NOT EXISTS ( SELECT 'X'
                 FROM FI_ACCOUNT_CONTROL AC
               WHERE AC.ACCOUNT_CONTROL_ID      = DS.ACCOUNT_CONTROL_ID
                 AND AC.SOB_ID                  = DS.SOB_ID
                 AND AC.ACCOUNT_ENABLED_FLAG    = 'Y'
              )
FOR UPDATE              
;

*/

DECLARE
  V_DR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- 차변금액
  V_CR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- 대변금액
  V_DR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 차변금액(외화)
  V_CR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 대변금액(외화)
BEGIN
  FOR C1 IN (SELECT *
                FROM FI_SLIP_LINE SL
              WHERE SL.SOB_ID     = 20
                AND NOT EXISTS ( SELECT 'X'
                               FROM FI_ACCOUNT_CONTROL AC
                             WHERE AC.ACCOUNT_CONTROL_ID      = SL.ACCOUNT_CONTROL_ID
                               AND AC.SOB_ID                  = SL.SOB_ID
                               AND AC.ACCOUNT_ENABLED_FLAG    = 'Y'
                            )
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
         -- 일마감 DATA INSERT
         UPDATE FI_DAILY_SUM
            SET DR_SUM        = DR_SUM      + V_DR_AMOUNT,
                CR_SUM        = CR_SUM      + V_CR_AMOUNT,
                DR_SUM_CURR   = DR_SUM_CURR + V_DR_CURR_AMOUNT,
                CR_SUM_CURR   = CR_SUM_CURR + V_CR_CURR_AMOUNT,
                EXCHANGE_RATE = C1.EXCHANGE_RATE
          WHERE GL_DATE            = C1.GL_DATE 
            AND GL_DATE_SEQ        = 1
            AND SOB_ID             = C1.SOB_ID
            AND ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
            AND CURRENCY_CODE      = C1.CURRENCY_CODE;

        IF SQL%ROWCOUNT = 0 THEN
           INSERT INTO FI_DAILY_SUM
                  (   GL_DATE,             SOB_ID,
                      ORG_ID,              ACCOUNT_CONTROL_ID,
                      ACCOUNT_CODE,        CURRENCY_CODE,
                      OLD_EXCHANGE_RATE,   EXCHANGE_RATE,
                      DR_SUM,              CR_SUM,
                      DR_SUM_CURR,         CR_SUM_CURR,
                      CREATION_DATE,       CREATED_BY,
                      LAST_UPDATE_DATE,    LAST_UPDATED_BY )
           VALUES
                  (    C1.GL_DATE,            C1.SOB_ID,
                      C1.ORG_ID,              C1.ACCOUNT_CONTROL_ID,
										  C1.ACCOUNT_CODE,  			C1.CURRENCY_CODE,
                      C1.EXCHANGE_RATE,      C1.EXCHANGE_RATE,
										  V_DR_AMOUNT,  				V_CR_AMOUNT,
										  V_DR_CURR_AMOUNT, 		V_CR_CURR_AMOUNT,
										  TO_DATE('2011-01-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'),  		-1,
										  TO_DATE('2011-01-01 10:10:10', 'YYYY-MM-DD HH24:MI:SS'),  		-1);
        END IF;

      END;
  END LOOP C1;
END;      
