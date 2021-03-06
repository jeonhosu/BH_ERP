CREATE OR REPLACE PROCEDURE FI_UNLIQUIDATE_HEADER_P
(
    P_GB               		 	 IN VARCHAR2                 ,
    P_MANAGE           		 	 IN VARCHAR2                 ,
    P_SLIP_LINE_ID                      IN  FI_SLIP_LINE.SLIP_LINE_ID%TYPE,
    P_SOB_ID                            IN  FI_SLIP_LINE.SOB_ID%TYPE,
    P_ORG_ID                            IN  FI_SLIP_LINE.ORG_ID%TYPE,
    P_PERIOD_NAME                       IN  FI_SLIP_LINE.PERIOD_NAME%TYPE,
    P_GL_DATE                           IN  FI_SLIP_LINE.GL_DATE%TYPE,
    P_GL_NUM                            IN  FI_SLIP_LINE.GL_NUM%TYPE,
    P_ACCOUNT_BOOK_ID                   IN  FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE,
    P_SLIP_TYPE                         IN  FI_SLIP_LINE.SLIP_TYPE%TYPE,
    P_ACCOUNT_CONTROL_ID                IN  FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE,
    P_ACCOUNT_CODE                      IN  FI_SLIP_LINE.ACCOUNT_CODE%TYPE,
    P_ACCOUNT_DR_CR                     IN  FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE,
    P_CUSTOMER_ID                       IN  FI_SLIP_LINE.CUSTOMER_ID%TYPE,
    P_GL_AMOUNT                         IN  FI_SLIP_LINE.GL_AMOUNT%TYPE,
    P_CURRENCY_CODE                     IN  FI_SLIP_LINE.CURRENCY_CODE%TYPE,
    P_EXCHANGE_RATE                     IN  FI_SLIP_LINE.EXCHANGE_RATE%TYPE,
    P_GL_CURRENCY_AMOUNT                IN  FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE,
    P_MANAGEMENT1                       IN  FI_SLIP_LINE.MANAGEMENT1%TYPE,
    P_MANAGEMENT2                       IN  FI_SLIP_LINE.MANAGEMENT2%TYPE,
    P_REFER1                            IN  FI_SLIP_LINE.REFER1%TYPE,
    P_REFER2                            IN  FI_SLIP_LINE.REFER2%TYPE,
    P_REFER3                            IN  FI_SLIP_LINE.REFER3%TYPE,
    P_REFER4                            IN  FI_SLIP_LINE.REFER4%TYPE,
    P_REFER5                            IN  FI_SLIP_LINE.REFER5%TYPE,
    P_REFER6                            IN  FI_SLIP_LINE.REFER6%TYPE,
    P_REFER7                            IN  FI_SLIP_LINE.REFER7%TYPE,
    P_REFER8                            IN  FI_SLIP_LINE.REFER8%TYPE,
    P_REFER9                            IN  FI_SLIP_LINE.REFER9%TYPE,
    P_REFER_DATE1                       IN  FI_SLIP_LINE.REFER_DATE1%TYPE,
    P_REFER_DATE2                       IN  FI_SLIP_LINE.REFER_DATE2%TYPE,
    P_REMARK                            IN  FI_SLIP_LINE.REMARK%TYPE,

    P_CREATION_DATE          IN FI_UNLIQUIDATE_HEADER.CREATION_DATE%TYPE      ,
    P_CREATED_BY             IN FI_UNLIQUIDATE_HEADER.CREATED_BY%TYPE         ,
    P_LAST_UPDATE_DATE       IN FI_UNLIQUIDATE_HEADER.LAST_UPDATE_DATE%TYPE   ,
    P_LAST_UPDATED_BY        IN FI_UNLIQUIDATE_HEADER.LAST_UPDATED_BY%TYPE

) AS

--  ??????(????????) ??????????  ?????? TABLE(FI_UNLIQUIDATE_HEADER)?? INSERT

    V_DR_AMOUINT        FI_CUSTOMER_BALANCE.THIS_DR_AMOUNT%TYPE;
    V_CR_AMOUINT        FI_CUSTOMER_BALANCE.THIS_CR_AMOUNT%TYPE;
    V_DR_CURR_AMOUINT   FI_CUSTOMER_BALANCE.THIS_DR_CURR_AMOUNT%TYPE;
    V_CR_CURR_AMOUINT   FI_CUSTOMER_BALANCE.THIS_CR_CURR_AMOUNT%TYPE;

    V_ERRTEXT           VARCHAR2(100);

    E_INSERT_ERR1       EXCEPTION;
    E_DELETE_ERR1       EXCEPTION;

BEGIN

    V_DR_AMOUINT       := 0;
    V_CR_AMOUINT       := 0;
    V_DR_CURR_AMOUINT  := 0;
    V_CR_CURR_AMOUINT  := 0;

    IF P_ACCOUNT_DR_CR = '1' THEN
        V_DR_AMOUINT      := P_GL_AMOUNT;
        V_DR_CURR_AMOUINT := P_GL_CURRENCY_AMOUNT;
    ELSE
        V_CR_AMOUINT      := P_GL_AMOUNT;
        V_CR_CURR_AMOUINT := P_GL_CURRENCY_AMOUNT;
    END IF;
--  EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10029', NULL);
/*    IF P_MANAGE = '1004'  THEN

    END IF;*/

    -- ????
    IF P_GB = 'I' THEN

        BEGIN
            INSERT INTO FI_UNLIQUIDATE_HEADER
                (     SLIP_LINE_ID,         SOB_ID,
                      ORG_ID,               PERIOD_NAME,
                      GL_DATE,              GL_NUM,
                      ACCOUNT_BOOK_ID,      SLIP_TYPE,
                      ACCOUNT_CONTROL_ID,   ACCOUNT_CODE,
                      ACCOUNT_DR_CR,        CUSTOMER_ID,
                      GL_AMOUNT,            CURRENCY_CODE,
                      EXCHANGE_RATE,        OLD_EXCHANGE_RATE,
                      GL_CURRENCY_AMOUNT,
                      MANAGEMENT1,          MANAGEMENT2,
                      REFER1,               REFER2,
                      REFER3,               REFER4,
                      REFER5,               REFER6,
                      REFER7,               REFER8,
                      REFER9,
                      REFER_DATE1,          REFER_DATE2,
                      GL_REMAIN_AMOUNT,     GL_REMAIN_CURRENCY_AMOUNT,
                      REMARK,               CREATION_DATE,
                      CREATED_BY,           LAST_UPDATE_DATE,
                      LAST_UPDATED_BY,      SLIP_STATUS )
            VALUES
                   (  P_SLIP_LINE_ID,                   P_SOB_ID,
                      P_ORG_ID,                         P_PERIOD_NAME,
                      P_GL_DATE,                        P_GL_NUM,
                      P_ACCOUNT_BOOK_ID,                P_SLIP_TYPE,
                      P_ACCOUNT_CONTROL_ID,             P_ACCOUNT_CODE,
                      P_ACCOUNT_DR_CR,                  P_CUSTOMER_ID,
                      P_GL_AMOUNT,                      P_CURRENCY_CODE,
                      NVL(P_EXCHANGE_RATE,0),           NVL(P_EXCHANGE_RATE,0),
                      NVL(P_GL_CURRENCY_AMOUNT,0),
                      P_MANAGEMENT1,                    P_MANAGEMENT2,
                      P_REFER1,                         P_REFER2,
                      P_REFER3,                         P_REFER4,
                      P_REFER5,                         P_REFER6,
                      P_REFER7,                         P_REFER8,
                      P_REFER9,
                      P_REFER_DATE1,                    P_REFER_DATE2,
                      P_GL_AMOUNT,                      NVL(P_GL_CURRENCY_AMOUNT,0),
                      P_REMARK,                         P_CREATION_DATE,
                      P_CREATED_BY,                     P_LAST_UPDATE_DATE,
                      P_LAST_UPDATED_BY,                'N'   );

        EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
            V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
            RAISE E_INSERT_ERR1;
        END;

    ELSE
        -- ????
        BEGIN
            DELETE FROM FI_UNLIQUIDATE_HEADER
             WHERE SLIP_LINE_ID = P_SLIP_LINE_ID
               AND SOB_ID       = P_SOB_ID ;

        EXCEPTION WHEN NO_DATA_FOUND THEN
            V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
            RAISE  E_DELETE_ERR1;
        END;

    END IF;



EXCEPTION
    WHEN E_INSERT_ERR1 THEN
         RAISE_APPLICATION_ERROR(-20001, 'FI_UNLIQUIDATE_HEADER_P : ?????? ???????? ERROR! ?????? ????????????.('||V_ERRTEXT||')');
--       EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10029', '&&VALUE:=?????? DATA');
    WHEN E_DELETE_ERR1 THEN
         RAISE_APPLICATION_ERROR(-20001, 'FI_UNLIQUIDATE_HEADER_P : ?????? ?????????? ?????? ????????!! ('||V_ERRTEXT||')');
    WHEN OTHERS THEN
         RAISE_APPLICATION_ERROR(-20001, 'FI_UNLIQUIDATE_HEADER_P : OTHER - '||SQLERRM );

END FI_UNLIQUIDATE_HEADER_P; 
/
