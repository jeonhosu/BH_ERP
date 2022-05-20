CREATE OR REPLACE PROCEDURE FI_CUSTOMER_BALANCE_P
(
    P_GB                					 IN VARCHAR2                 ,

    P_SOB_ID                       IN FI_SLIP_LINE.SOB_ID%TYPE              ,
    P_ORG_ID                       IN FI_SLIP_LINE.ORG_ID%TYPE              ,

		P_PERIOD_NAME                  IN FI_SLIP_LINE.PERIOD_NAME%TYPE                ,
    P_ACCOUNT_BOOK_ID              IN FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE            ,
    P_ACCOUNT_CONTROL_ID           IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE         ,
    P_ACCOUNT_CODE                 IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE               ,
    P_ACCOUNT_DR_CR                IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE              ,
    P_CUSTOMER_ID                  IN FI_SLIP_LINE.CUSTOMER_ID%TYPE                ,
    P_GL_AMOUNT                    IN FI_SLIP_LINE.GL_AMOUNT%TYPE                  ,
    P_CURRENCY_CODE                IN FI_SLIP_LINE.CURRENCY_CODE%TYPE              ,
    P_GL_CURRENCY_AMOUNT           IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE         ,
    P_MANAGEMENT1                  IN FI_SLIP_LINE.MANAGEMENT1%TYPE                ,
    P_MANAGEMENT2                  IN FI_SLIP_LINE.MANAGEMENT2%TYPE                ,

    P_CREATION_DATE                IN FI_SLIP_LINE.CREATION_DATE%TYPE       ,
    P_CREATED_BY                   IN FI_SLIP_LINE.CREATED_BY%TYPE          ,
    P_LAST_UPDATE_DATE             IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE    ,
    P_LAST_UPDATED_BY              IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE

) AS
/*
    �����ݰ���   ����(ACCOUNT_ENABLED_FLAG   = 'Y')
    ��ȭ�������� ����(CURRENCY_ENABLED_FLAG  = 'Y')
    �� ���Ϲ߻� �ݾ��� ����, �ܾ��� �����Ѵ�.
*/

    V_DR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- �����ݾ�
    V_CR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- �뺯�ݾ�
    V_DR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- �����ݾ�(��ȭ)
    V_CR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- �뺯�ݾ�(��ȭ)

    V_DR_REM_AMT        FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- �����ݾ�
    V_CR_REM_AMT        FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- �뺯�ݾ�
    V_DR_REM_CURR_AMT   FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- �����ݾ�(��ȭ)
    V_CR_REM_CURR_AMT   FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- �뺯�ݾ�(��ȭ)

BEGIN


		V_DR_AMOUNT       := 0;
    V_CR_AMOUNT       := 0;
    V_DR_CURR_AMOUNT  := 0;
    V_CR_CURR_AMOUNT  := 0;

    V_DR_REM_AMT      := 0;
    V_CR_REM_AMT      := 0;
    V_DR_REM_CURR_AMT := 0;
    V_CR_REM_CURR_AMT := 0;

    -- ���뱸�п� ���� �ݾ� -- ����:�߻�,  �뺯:����
    IF P_ACCOUNT_DR_CR = '1' THEN
        V_DR_AMOUNT       := P_GL_AMOUNT;
        V_DR_CURR_AMOUNT  := P_GL_CURRENCY_AMOUNT;
        V_DR_REM_AMT      := P_GL_AMOUNT;
        V_DR_REM_CURR_AMT := P_GL_CURRENCY_AMOUNT;

    ELSE
        V_CR_AMOUNT       := P_GL_AMOUNT;
        V_CR_CURR_AMOUNT  := P_GL_CURRENCY_AMOUNT;
        V_CR_REM_AMT      := P_GL_AMOUNT * (-1) ;
        V_CR_REM_CURR_AMT := P_GL_CURRENCY_AMOUNT * (-1);
    END IF;

    --DBMS_OUTPUT.PUT_LINE ( 'START ' ||PERIOD_NAME ||' ' ||P_PERIOD_NAME ||' ' || ACCOUNT_CODE || ' ' || P_ACCOUNT_CODE );
    -- ��ǥ �Է�
    IF P_GB = 'I' THEN

	    BEGIN
         -- ���� DATA INSERT
				 UPDATE FI_CUSTOMER_BALANCE
	          SET THIS_DR_AMOUNT         = THIS_DR_AMOUNT        + V_DR_AMOUNT,
	              THIS_CR_AMOUNT         = THIS_CR_AMOUNT        + V_CR_AMOUNT,
	              THIS_DR_CURR_AMOUNT    = THIS_DR_CURR_AMOUNT   + V_DR_CURR_AMOUNT,
	              THIS_CR_CURR_AMOUNT    = THIS_CR_CURR_AMOUNT   + V_CR_CURR_AMOUNT

--              REMAIN_DR_AMOUNT       = REMAIN_DR_AMOUNT      + V_DR_REM_AMT,
--              REMAIN_CR_AMOUNT       = REMAIN_CR_AMOUNT      + V_CR_REM_AMT,
--              REMAIN_DR_CURR_AMOUNT  = REMAIN_DR_CURR_AMOUNT + V_DR_REM_CURR_AMT,
--              REMAIN_CR_CURR_AMOUNT  = REMAIN_CR_CURR_AMOUNT + V_CR_REM_CURR_AMT

	        WHERE PERIOD_NAME        = P_PERIOD_NAME
	          AND SOB_ID             = P_SOB_ID
	          AND CUSTOMER_ID        = P_CUSTOMER_ID
	          AND ACCOUNT_BOOK_ID    = P_ACCOUNT_BOOK_ID
	          AND ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
	          AND CURRENCY_CODE      = P_CURRENCY_CODE;

	      IF SQL%ROWCOUNT = 0 THEN

				   INSERT INTO FI_CUSTOMER_BALANCE
							(			  PERIOD_NAME,  				SOB_ID,
										  ORG_ID,  							CUSTOMER_ID,
										  ACCOUNT_BOOK_ID,  		ACCOUNT_CONTROL_ID,
										  ACCOUNT_CODE,  				CURRENCY_CODE,
										  MANAGEMENT1,  				MANAGEMENT2,

										  THIS_DR_AMOUNT,  			THIS_CR_AMOUNT,
										  THIS_DR_CURR_AMOUNT,  THIS_CR_CURR_AMOUNT,

										  CREATION_DATE,  			CREATED_BY,
										  LAST_UPDATE_DATE,  		LAST_UPDATED_BY  )

				   VALUES
				      (				P_PERIOD_NAME, 					P_SOB_ID,
										  P_ORG_ID,  							P_CUSTOMER_ID,
										  P_ACCOUNT_BOOK_ID,  		P_ACCOUNT_CONTROL_ID,
										  P_ACCOUNT_CODE,  				P_CURRENCY_CODE,
										  P_MANAGEMENT1,  				P_MANAGEMENT2,

										  V_DR_AMOUNT,  					V_CR_AMOUNT,
										  V_DR_CURR_AMOUNT,  			V_CR_CURR_AMOUNT,

										  P_CREATION_DATE,  			P_CREATED_BY,
										  P_LAST_UPDATE_DATE,  		P_LAST_UPDATED_BY  );

	      END IF;

			END;

    -- ��ǥ ����.
   ELSE

        BEGIN
         UPDATE FI_CUSTOMER_BALANCE
	          SET THIS_DR_AMOUNT         = THIS_DR_AMOUNT        - V_DR_AMOUNT,
	              THIS_CR_AMOUNT         = THIS_CR_AMOUNT        - V_CR_AMOUNT,
	              THIS_DR_CURR_AMOUNT    = THIS_DR_CURR_AMOUNT   - V_DR_CURR_AMOUNT,
	              THIS_CR_CURR_AMOUNT    = THIS_CR_CURR_AMOUNT   - V_CR_CURR_AMOUNT

--              REMAIN_DR_AMOUNT       = REMAIN_DR_AMOUNT      - V_DR_REM_AMT,
--              REMAIN_CR_AMOUNT       = REMAIN_CR_AMOUNT      - V_CR_REM_AMT,
--              REMAIN_DR_CURR_AMOUNT  = REMAIN_DR_CURR_AMOUNT - V_DR_REM_CURR_AMT,
--              REMAIN_CR_CURR_AMOUNT  = REMAIN_CR_CURR_AMOUNT - V_CR_REM_CURR_AMT

	        WHERE PERIOD_NAME        = P_PERIOD_NAME
	          AND SOB_ID             = P_SOB_ID
	          AND CUSTOMER_ID        = P_CUSTOMER_ID
	          AND ACCOUNT_BOOK_ID    = P_ACCOUNT_BOOK_ID
	          AND ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
	          AND CURRENCY_CODE      = P_CURRENCY_CODE;

        EXCEPTION WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'FI_CUSTOMER_BALANCE : DATA ���� ����!! �ŷ�ó�ڵ带 Ȯ�� �Ͻʽÿ�!!('||SQLCODE||' : '||SQLERRM||')');
        END;

    END IF;

END FI_CUSTOMER_BALANCE_P; 
 
/