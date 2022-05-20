CREATE OR REPLACE PROCEDURE FI_DAILY_SUM_P
(
    P_GB                					 IN VARCHAR2                 ,
    P_SOB_ID                       IN FI_SLIP_LINE.SOB_ID%TYPE              ,
    P_ORG_ID                       IN FI_SLIP_LINE.ORG_ID%TYPE              ,
    P_GL_DATE                      IN FI_SLIP_LINE.GL_DATE%TYPE             ,
    P_PERIOD_NAME                  IN FI_SLIP_LINE.PERIOD_NAME%TYPE         ,
    P_ACCOUNT_CONTROL_ID           IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE  ,
    P_ACCOUNT_CODE                 IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE        ,
    P_ACCOUNT_DR_CR                IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE       ,
    P_GL_AMOUNT                    IN FI_SLIP_LINE.GL_AMOUNT%TYPE           ,
    P_CURRENCY_CODE                IN FI_SLIP_LINE.CURRENCY_CODE%TYPE       ,
    P_EXCHANGE_RATE                IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE       ,
    P_GL_CURRENCY_AMOUNT           IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE  ,
    P_BANK_ACCOUNT_ID              IN FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE     ,
    P_ACCOUNT_BOOK_ID              IN FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE     ,
    P_CREATION_DATE                IN FI_SLIP_LINE.CREATION_DATE%TYPE       ,
    P_CREATED_BY                   IN FI_SLIP_LINE.CREATED_BY%TYPE          ,
    P_LAST_UPDATE_DATE             IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE    ,
    P_LAST_UPDATED_BY              IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE

) AS
/*
    예적금관리   계정(ACCOUNT_ENABLED_FLAG   = 'Y')
    외화계정관리 계정(CURRENCY_ENABLED_FLAG  = 'Y')
    의 당일발생 금액을 집계, 잔액을 관리한다.
*/
    V_DR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- 차변금액
    V_CR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- 대변금액
    V_DR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 차변금액(외화)
    V_CR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- 대변금액(외화)
        
BEGIN

		V_DR_AMOUNT       := 0;
    V_CR_AMOUNT       := 0;
    V_DR_CURR_AMOUNT  := 0;
    V_CR_CURR_AMOUNT  := 0;

    -- 차대구분에 따른 금액
    IF P_ACCOUNT_DR_CR = '1' THEN
        V_DR_AMOUNT      := P_GL_AMOUNT;
        V_DR_CURR_AMOUNT := P_GL_CURRENCY_AMOUNT;
    ELSE
        V_CR_AMOUNT      := P_GL_AMOUNT;
        V_CR_CURR_AMOUNT := P_GL_CURRENCY_AMOUNT;
    END IF;

    --DBMS_OUTPUT.PUT_LINE ( 'START ' ||P_ACTDATE ||' ' ||P_SACODE ||' ' || P_ACTCODE || ' ' || V_LEVEL1 );
    -- 전표 입력
    IF P_GB = 'I' THEN
	    BEGIN
         -- 일마감 DATA INSERT
				 UPDATE FI_DAILY_SUM
	          SET DR_SUM        = DR_SUM      + V_DR_AMOUNT,
	              CR_SUM        = CR_SUM      + V_CR_AMOUNT,
	              DR_SUM_CURR   = DR_SUM_CURR + V_DR_CURR_AMOUNT,
	              CR_SUM_CURR   = CR_SUM_CURR + V_CR_CURR_AMOUNT,
                EXCHANGE_RATE = P_EXCHANGE_RATE
	        WHERE GL_DATE            = P_GL_DATE 
            AND GL_DATE_SEQ        = 1
	          AND SOB_ID             = P_SOB_ID
	          AND ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
	          AND CURRENCY_CODE      = P_CURRENCY_CODE;

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
                  (	  P_GL_DATE,  					P_SOB_ID,
										  P_ORG_ID,  						P_ACCOUNT_CONTROL_ID,
										  P_ACCOUNT_CODE,  			P_CURRENCY_CODE,
                      P_EXCHANGE_RATE,      P_EXCHANGE_RATE,
										  V_DR_AMOUNT,  				V_CR_AMOUNT,
										  V_DR_CURR_AMOUNT, 		V_CR_CURR_AMOUNT,
										  P_CREATION_DATE,  		P_CREATED_BY,
										  P_LAST_UPDATE_DATE,  	P_LAST_UPDATED_BY );
        END IF;

      END;

      IF TRIM(P_BANK_ACCOUNT_ID) IS NOT NULL THEN
      -- 은행계좌별 일마감테이블
        BEGIN
         UPDATE FI_DAILY_BANK_ACCOUNT_SUM
            SET DR_AMOUNT       = DR_AMOUNT      + V_DR_AMOUNT,
                CR_AMOUNT       = CR_AMOUNT      + V_CR_AMOUNT,
                DR_CURR_AMOUNT  = DR_CURR_AMOUNT + V_DR_CURR_AMOUNT,
                CR_CURR_AMOUNT  = CR_CURR_AMOUNT + V_CR_CURR_AMOUNT,
                EXCHANGE_RATE   = P_EXCHANGE_RATE,
                LAST_UPDATE_DATE  = P_LAST_UPDATE_DATE,
                LAST_UPDATED_BY   = P_LAST_UPDATED_BY

          WHERE GL_DATE            = P_GL_DATE
            AND GL_DATE_SEQ        = 1
            AND SOB_ID             = P_SOB_ID
            AND ACCOUNT_BOOK_ID    = P_ACCOUNT_BOOK_ID
            AND ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
            AND BANK_ACCOUNT_ID    = P_BANK_ACCOUNT_ID ;

          IF SQL%ROWCOUNT = 0 THEN
             INSERT INTO FI_DAILY_BANK_ACCOUNT_SUM
             VALUES  (  P_GL_DATE,            1,
                        P_SOB_ID,             P_ORG_ID,
                        P_ACCOUNT_BOOK_ID,    P_ACCOUNT_CONTROL_ID,
                        P_ACCOUNT_CODE,       P_BANK_ACCOUNT_ID,
                        V_DR_AMOUNT,          V_CR_AMOUNT,
                        P_EXCHANGE_RATE,      P_EXCHANGE_RATE,
                        V_DR_CURR_AMOUNT,     V_CR_CURR_AMOUNT,
                        P_CREATION_DATE,      P_CREATED_BY,
                        P_LAST_UPDATE_DATE,   P_LAST_UPDATED_BY );

          END IF;
        END;                
      END IF;
    -- 전표 삭제.
   ELSE
        BEGIN
          UPDATE FI_DAILY_SUM
            SET DR_SUM       = DR_SUM      - V_DR_AMOUNT,
                CR_SUM       = CR_SUM      - V_CR_AMOUNT,
                DR_SUM_CURR  = DR_SUM_CURR - V_DR_CURR_AMOUNT,
                CR_SUM_CURR  = CR_SUM_CURR - V_CR_CURR_AMOUNT
          WHERE GL_DATE            = P_GL_DATE
            AND GL_DATE_SEQ        = 1
            AND SOB_ID             = P_SOB_ID
            AND ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
            AND CURRENCY_CODE      = P_CURRENCY_CODE;

        EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20001, 'FI_DAILY_SUM : 일마감 DATA 삭제 오류!! 계정코드를 확인하십시요!! ('||SQLCODE||' : '||SQLERRM||')');
        END;

        IF TRIM(P_BANK_ACCOUNT_ID) IS NOT NULL THEN
        -- 은행계좌별 일마감테이블
          BEGIN
           UPDATE FI_DAILY_BANK_ACCOUNT_SUM
              SET DR_AMOUNT       = DR_AMOUNT      - V_DR_AMOUNT,
                  CR_AMOUNT       = CR_AMOUNT      - V_CR_AMOUNT,
                  DR_CURR_AMOUNT  = DR_CURR_AMOUNT - V_DR_CURR_AMOUNT,
                  CR_CURR_AMOUNT  = CR_CURR_AMOUNT - V_CR_CURR_AMOUNT,
                  LAST_UPDATE_DATE  = P_LAST_UPDATE_DATE,
                  LAST_UPDATED_BY   = P_LAST_UPDATED_BY
            WHERE GL_DATE            = P_GL_DATE
              AND GL_DATE_SEQ        = 1
              AND SOB_ID             = P_SOB_ID
              AND ACCOUNT_BOOK_ID    = P_ACCOUNT_BOOK_ID
              AND ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
              AND BANK_ACCOUNT_ID    = P_BANK_ACCOUNT_ID ;

           EXCEPTION WHEN NO_DATA_FOUND THEN
              RAISE_APPLICATION_ERROR(-20001, 'FI_DAILY_BANK_ACCOUNT_SUM : 일마감 DATA 삭제 오류!! 계좌번호를 확인하십시요!! ('||SQLCODE||' : '||SQLERRM||')');
          END;
        END IF;
    END IF;

    IF TRIM(P_BANK_ACCOUNT_ID) IS NOT NULL THEN
      -- 계좌 관리.
      FI_BANK_ACCOUNT_P(  SUBSTR(P_GB, 1, 1),     P_SOB_ID,
                          P_ORG_ID,               P_PERIOD_NAME,
                          P_BANK_ACCOUNT_ID,      P_GL_DATE,
                          P_ACCOUNT_DR_CR,        P_GL_AMOUNT,
                          P_CURRENCY_CODE,        P_GL_CURRENCY_AMOUNT,
                          P_LAST_UPDATE_DATE,     P_LAST_UPDATED_BY     );
    END IF;

END FI_DAILY_SUM_P; 
 
/
