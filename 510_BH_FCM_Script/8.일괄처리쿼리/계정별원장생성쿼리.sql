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
                   , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
                   , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
                   , SL.CURRENCY_CODE
                   , SL.EXCHANGE_RATE
                   , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0) AS DR_CURRENCY_AMOUNT
                   , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_CURRENCY_AMOUNT, 0) AS CR_CURRENCY_AMOUNT
                   , SL.MANAGEMENT1
                   , SL.MANAGEMENT2
                   , SL.CREATION_DATE
                   , SL.CREATED_BY
                   , SL.LAST_UPDATE_DATE
                   , SL.LAST_UPDATED_BY
                FROM FI_SLIP_LINE SL
                  , FI_SLIP_HEADER SH
                  , FI_ACCOUNT_CONTROL AC
              WHERE SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                AND SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                AND SL.SOB_ID                   = &W_SOB_ID
                AND SL.GL_DATE                  BETWEEN &W_GL_DATE_FR AND &W_GL_DATE_TO
                AND SL.ACCOUNT_CODE             = NVL(&W_ACCOUNT_CODE, SL.ACCOUNT_CODE)
                AND SL.CONFIRM_YN               = 'Y'
              )
  LOOP
--    RAISE_APPLICATION_ERROR(-20001, P_GB || ' GL_DATE : ' || P_GL_DATE || ', ACCOUNT : ' || P_ACCOUNT_CONTROL_ID || ', CURRENCY : ' || P_CURRENCY_CODE);
    BEGIN
       -- ¿œ∏∂∞® DATA INSERT
       UPDATE FI_DAILY_SUM
          SET DR_SUM        = NVL(DR_SUM, 0)      + NVL(C1.DR_AMOUNT, 0),
              CR_SUM        = NVL(CR_SUM, 0)      + NVL(C1.CR_AMOUNT, 0),
              DR_SUM_CURR   = NVL(DR_SUM_CURR, 0) + NVL(C1.DR_CURRENCY_AMOUNT, 0),
              CR_SUM_CURR   = NVL(CR_SUM_CURR, 0) + NVL(C1.CR_CURRENCY_AMOUNT, 0),
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
                (   C1.GL_DATE,          C1.SOB_ID,
                    C1.ORG_ID,           C1.ACCOUNT_CONTROL_ID,
                    C1.ACCOUNT_CODE,     C1.CURRENCY_CODE,
                    C1.EXCHANGE_RATE,    C1.EXCHANGE_RATE,
                    NVL(C1.DR_AMOUNT, 0),        NVL(C1.CR_AMOUNT, 0),
                    NVL(C1.DR_CURRENCY_AMOUNT, 0),   NVL(C1.CR_CURRENCY_AMOUNT, 0),
                    C1.CREATION_DATE,    C1.CREATED_BY,
                    C1.LAST_UPDATE_DATE, C1.LAST_UPDATED_BY );
      END IF;
    END;
  END LOOP C1;
END;

/*
SELECT *
  FROM FI_DAILY_SUM ds
where   ds.gl_date_seq   = 1
FOR UPDATE  
  ;
  
SELECT *
  FROM FI_DAILY_SUM X
FOR UPDATE
;*/

/*
DELETE
  FROM FI_DAILY_SUM
  
  ;
  
DELETE
  FROM FI_CUSTOMER_BALANCE X
;

select * from fi_daily_sum t
WHERE T.ACCOUNT_CODE       in('1121109')
  AND T.GL_DATE            between to_date('2011-03-01', 'yyyy-mm-dd') and to_date('2011-03-31', 'yyyy-mm-dd')
;
*/

