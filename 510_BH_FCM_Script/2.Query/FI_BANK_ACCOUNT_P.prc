CREATE OR REPLACE PROCEDURE FI_BANK_ACCOUNT_P
(
    P_GB                IN VARCHAR2                   ,
    P_SOB_ID                       IN FI_SLIP_LINE.SOB_ID%TYPE              ,
    P_ORG_ID                       IN FI_SLIP_LINE.ORG_ID%TYPE              ,
    P_PERIOD_NAME                  IN FI_SLIP_LINE.PERIOD_NAME%TYPE         ,
    P_BANK_ACCOUNT_ID              IN FI_SLIP_LINE.BANK_ACCOUNT_ID%TYPE     ,
    P_GL_DATE                      IN FI_SLIP_LINE.GL_DATE%TYPE             ,
    P_ACCOUNT_DR_CR                IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE       ,
    P_GL_AMOUNT                    IN FI_SLIP_LINE.GL_AMOUNT%TYPE           ,
    P_CURRENCY_CODE                IN FI_SLIP_LINE.CURRENCY_CODE%TYPE       ,
    P_GL_CURRENCY_AMOUNT           IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE  ,

    P_LAST_UPDATE_DATE             IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE    ,
    P_LAST_UPDATED_BY              IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE

) AS
/*
    예,적금 인경우 은행계좌 잔액을 UPDATE 한다
*/

    V_AMOUNT            FI_SLIP_LINE.GL_AMOUNT%TYPE;      -- 전표금액(원화 또는 외화)
    V_CURRENCY_CODE     FI_SLIP_LINE.CURRENCY_CODE%TYPE;  -- 화폐단위

    V_ERRTEXT           VARCHAR2(100);

    E_SELECT_ERR1       EXCEPTION;
    E_UPDATE_ERR1       EXCEPTION;

BEGIN


    BEGIN

      -- 통화단위에 따라 금액 구분
      -- P_CURRENCY_CODE = FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID)
      SELECT  DECODE(NVL(CURRENCY_CODE,FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID)), FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID), P_GL_AMOUNT, P_GL_CURRENCY_AMOUNT)
        INTO  V_AMOUNT
        FROM  FI_BANK_ACCOUNT
       WHERE  BANK_ACCOUNT_ID = P_BANK_ACCOUNT_ID
         AND  SOB_ID          = P_SOB_ID ;

    EXCEPTION WHEN NO_DATA_FOUND THEN
        RAISE E_SELECT_ERR1;
    END;

    -- 삭제
    IF P_GB = 'D' THEN
        V_AMOUNT := V_AMOUNT * -1;
    END IF;

    -- 차변발생은 +, 대변발생은 -
    BEGIN
        UPDATE  FI_BANK_ACCOUNT
           SET  REMAIN_AMOUNT     = NVL(REMAIN_AMOUNT, 0)
                                    + DECODE(P_ACCOUNT_DR_CR, '1', V_AMOUNT, V_AMOUNT * -1),
                LAST_UPDATE_DATE  = P_LAST_UPDATE_DATE,
                LAST_UPDATED_BY   = P_LAST_UPDATED_BY

         WHERE  BANK_ACCOUNT_ID = P_BANK_ACCOUNT_ID
           AND  SOB_ID          = P_SOB_ID ;

    EXCEPTION WHEN OTHERS THEN
        V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
        RAISE E_UPDATE_ERR1;
    END;

EXCEPTION
    WHEN E_SELECT_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_BANK_ACCOUNT_P : 입력된 계좌번호가 존재하지 않습니다.계좌번호를 확인하십시요!!('||V_ERRTEXT||')');
    WHEN E_UPDATE_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_BANK_ACCOUNT_P : 계좌 잔액금액 UPDATE ERROR!! 계좌번호를 확인하십시요!! ('||V_ERRTEXT||')');
END FI_BANK_ACCOUNT_P; 
 
/
