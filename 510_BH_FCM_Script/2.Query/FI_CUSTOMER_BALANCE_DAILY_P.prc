CREATE OR REPLACE PROCEDURE FI_CUSTOMER_BALANCE_DAILY_P
(   P_GB                           IN VARCHAR2                 ,
    P_SOB_ID                       IN FI_SLIP_LINE.SOB_ID%TYPE              ,
    P_ORG_ID                       IN FI_SLIP_LINE.ORG_ID%TYPE              ,
    P_GL_DATE                      IN FI_SLIP_LINE.PERIOD_NAME%TYPE                ,
    P_ACCOUNT_BOOK_ID              IN FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE            ,
    P_ACCOUNT_CONTROL_ID           IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE         ,
    P_ACCOUNT_CODE                 IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE               ,
    P_ACCOUNT_DR_CR                IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE              ,
    P_CUSTOMER_ID                  IN FI_SLIP_LINE.CUSTOMER_ID%TYPE                ,
    P_GL_AMOUNT                    IN FI_SLIP_LINE.GL_AMOUNT%TYPE                  ,
    P_CURRENCY_CODE                IN FI_SLIP_LINE.CURRENCY_CODE%TYPE              ,
    P_GL_CURRENCY_AMOUNT           IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE         ,
    P_CREATION_DATE                IN FI_SLIP_LINE.CREATION_DATE%TYPE       ,
    P_CREATED_BY                   IN FI_SLIP_LINE.CREATED_BY%TYPE          ,
    P_LAST_UPDATE_DATE             IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE    ,
    P_LAST_UPDATED_BY              IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE
    )
AS
/*
    �����ݰ���   ����(ACCOUNT_ENABLED_FLAG   = 'Y')
    ��ȭ�������� ����(CURRENCY_ENABLED_FLAG  = 'Y')
    �� ���Ϲ߻� �ݾ��� ����, �ܾ��� �����Ѵ�.
*/
    V_PERIOD_NAME       FI_SLIP_LINE.PERIOD_NAME%TYPE;
    V_DR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- �����ݾ�
    V_CR_AMOUNT         FI_SLIP_LINE.GL_AMOUNT%TYPE;           -- �뺯�ݾ�
    V_DR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- �����ݾ�(��ȭ)
    V_CR_CURR_AMOUNT    FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE;  -- �뺯�ݾ�(��ȭ)

BEGIN
    V_PERIOD_NAME     := GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID), P_GL_DATE, P_SOB_ID, P_ORG_ID);
    V_DR_AMOUNT       := 0;
    V_CR_AMOUNT       := 0;
    V_DR_CURR_AMOUNT  := 0;
    V_CR_CURR_AMOUNT  := 0;

    -- ���뱸�п� ���� �ݾ� -- ����:�߻�,  �뺯:����
    IF P_ACCOUNT_DR_CR = '1' THEN
      V_DR_AMOUNT       := P_GL_AMOUNT;
      V_DR_CURR_AMOUNT  := P_GL_CURRENCY_AMOUNT;
    ELSE
      V_CR_AMOUNT       := P_GL_AMOUNT;
      V_CR_CURR_AMOUNT  := P_GL_CURRENCY_AMOUNT;
    END IF;
    
--RAISE_APPLICATION_ERROR(-20001, P_CUSTOMER_ID || '/' || P_ACCOUNT_CONTROL_ID || '/' || P_ACCOUNT_BOOK_ID || '/' || V_DR_AMOUNT || '/' || V_CR_AMOUNT);
    --DBMS_OUTPUT.PUT_LINE ( 'START ' ||PERIOD_NAME ||' ' ||P_PERIOD_NAME ||' ' || ACCOUNT_CODE || ' ' || P_ACCOUNT_CODE );
    -- ��ǥ �Է�
    IF P_GB = 'I' THEN
      BEGIN
        -- ���� DATA INSERT
        UPDATE FI_CUSTOMER_BALANCE_DAILY CBD
          SET CBD.DR_AMOUNT       = NVL(CBD.DR_AMOUNT, 0) + NVL(V_DR_AMOUNT, 0)
            , CBD.CR_AMOUNT       = NVL(CBD.CR_AMOUNT, 0) + NVL(V_CR_AMOUNT, 0)
            , CBD.DR_CURR_AMOUNT  = NVL(CBD.DR_CURR_AMOUNT, 0) + NVL(V_DR_CURR_AMOUNT, 0)
            , CBD.CR_CURR_AMOUNT  = NVL(CBD.CR_CURR_AMOUNT, 0) + NVL(V_CR_CURR_AMOUNT, 0)
            , CBD.LAST_UPDATE_DATE  = P_LAST_UPDATE_DATE
            , CBD.LAST_UPDATED_BY   = P_LAST_UPDATED_BY
        WHERE CBD.GL_DATE         = P_GL_DATE
          AND CBD.SOB_ID              = P_SOB_ID
          AND CBD.CUSTOMER_ID         = P_CUSTOMER_ID
          AND CBD.ACCOUNT_BOOK_ID     = P_ACCOUNT_BOOK_ID
          AND CBD.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
          AND CBD.CURRENCY_CODE       = P_CURRENCY_CODE
          AND CBD.GL_DATE_SEQ         = 1
          ;
        IF SQL%ROWCOUNT = 0 THEN
          INSERT INTO FI_CUSTOMER_BALANCE_DAILY
          ( GL_DATE
          , SOB_ID
          , ORG_ID
          , CUSTOMER_ID
          , ACCOUNT_BOOK_ID
          , PERIOD_NAME
          , ACCOUNT_CONTROL_ID
          , ACCOUNT_CODE
          , CURRENCY_CODE
          , DR_AMOUNT
          , CR_AMOUNT
          , DR_CURR_AMOUNT
          , CR_CURR_AMOUNT
          , CREATION_DATE
          , CREATED_BY
          , LAST_UPDATE_DATE
          , LAST_UPDATED_BY
          ) VALUES
          ( P_GL_DATE
          , P_SOB_ID
          , P_ORG_ID
          , P_CUSTOMER_ID
          , P_ACCOUNT_BOOK_ID
          , V_PERIOD_NAME
          , P_ACCOUNT_CONTROL_ID
          , P_ACCOUNT_CODE
          , P_CURRENCY_CODE
          , V_DR_AMOUNT
          , V_CR_AMOUNT
          , V_DR_CURR_AMOUNT
          , V_CR_CURR_AMOUNT
          , P_CREATION_DATE
          , P_CREATED_BY
          , P_LAST_UPDATE_DATE
          , P_LAST_UPDATED_BY
          );
        END IF;
      EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20004, 'CUSTOMER_BALANCE_DAILY INSERT ERROR : ' || SQLERRM);
      END;
    ELSE
    -- ��ǥ ����.
      BEGIN
        UPDATE FI_CUSTOMER_BALANCE_DAILY CBD
          SET CBD.DR_AMOUNT         = NVL(CBD.DR_AMOUNT, 0) - NVL(V_DR_AMOUNT, 0)
            , CBD.CR_AMOUNT         = NVL(CBD.CR_AMOUNT, 0) - NVL(V_CR_AMOUNT, 0)
            , CBD.DR_CURR_AMOUNT    = NVL(CBD.DR_CURR_AMOUNT, 0) - NVL(V_DR_CURR_AMOUNT, 0)
            , CBD.CR_CURR_AMOUNT    = NVL(CBD.CR_CURR_AMOUNT, 0) - NVL(V_CR_CURR_AMOUNT, 0)
            , CBD.LAST_UPDATE_DATE  = P_LAST_UPDATE_DATE
            , CBD.LAST_UPDATED_BY   = P_LAST_UPDATED_BY
        WHERE CBD.GL_DATE             = P_GL_DATE
          AND CBD.SOB_ID              = P_SOB_ID
          AND CBD.CUSTOMER_ID         = P_CUSTOMER_ID
          AND CBD.ACCOUNT_BOOK_ID     = P_ACCOUNT_BOOK_ID
          AND CBD.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
          AND CBD.CURRENCY_CODE       = P_CURRENCY_CODE
          AND CBD.GL_DATE_SEQ         = 1
        ;
        -- ��� �ݾ��� 0 �ϰ�� ����.
        DELETE FROM FI_CUSTOMER_BALANCE_DAILY CBD
        WHERE CBD.GL_DATE             = P_GL_DATE
          AND CBD.SOB_ID              = P_SOB_ID
          AND CBD.CUSTOMER_ID         = P_CUSTOMER_ID
          AND CBD.ACCOUNT_BOOK_ID     = P_ACCOUNT_BOOK_ID
          AND CBD.ACCOUNT_CONTROL_ID  = P_ACCOUNT_CONTROL_ID
          AND CBD.CURRENCY_CODE       = P_CURRENCY_CODE
          AND CBD.GL_DATE_SEQ         = 1
          AND (CBD.DR_AMOUNT          = 0
          AND CBD.CR_AMOUNT           = 0
          AND CBD.DR_CURR_AMOUNT      = 0
          AND CBD.CR_CURR_AMOUNT      = 0)
        ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004, 'FI_CUSTOMER_BALANCE_DAILY DELETE ERROR : ' || SQLERRM);
      END;

    END IF;

END FI_CUSTOMER_BALANCE_DAILY_P;


 
/
