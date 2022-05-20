CREATE OR REPLACE PROCEDURE FI_PAYABLE_BILL_P
(
    P_GB                IN VARCHAR2                  ,
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
    P_MANAGEMENT1                       IN  FI_SLIP_LINE.MANAGEMENT1%TYPE,
    P_MANAGEMENT2                       IN  FI_SLIP_LINE.MANAGEMENT2%TYPE,
    P_REFER1                            IN  FI_SLIP_LINE.REFER1%TYPE,
    P_REFER2                            IN  FI_SLIP_LINE.REFER2%TYPE,
    P_REFER3                            IN  FI_SLIP_LINE.REFER3%TYPE,
    P_REFER_RATE                        IN  FI_SLIP_LINE.REFER_RATE%TYPE,
    P_REFER_AMOUNT                      IN  FI_SLIP_LINE.REFER_AMOUNT%TYPE,
    P_REFER_DATE1                       IN  FI_SLIP_LINE.REFER_DATE1%TYPE,
    P_REFER_DATE2                       IN  FI_SLIP_LINE.REFER_DATE2%TYPE,
    P_REMARK                            IN  FI_SLIP_LINE.REMARK%TYPE,
    P_CREATION_DATE                     IN FI_SLIP_LINE.CREATION_DATE%TYPE      ,
    P_CREATED_BY                        IN FI_SLIP_LINE.CREATED_BY%TYPE         ,
    P_LAST_UPDATE_DATE                  IN FI_SLIP_LINE.LAST_UPDATE_DATE%TYPE   ,
    P_LAST_UPDATED_BY                   IN FI_SLIP_LINE.LAST_UPDATED_BY%TYPE

) AS

    V_ERRTEXT           VARCHAR2(100);
    V_BANK_ID           NUMBER;

    E_UPDATE_ERR1       EXCEPTION;
    E_UPDATE_ERR2       EXCEPTION;
    E_UPDATE_ERR3       EXCEPTION;

/*
    1. 지급어음 지급인 경우
     **FI_SLIP_LINE에 대변계정 ='210501' 이고 확정인 경우
      - FI_BILL_MOVE 처리안함
      - FI_PAYABLE_BILL  UPDATE
      (지급거래처,지급금액, 발행일자, 만기일자, 지급어음상태('1' 지급), 계정코드

    2. 지급어음이 만기 되었을 경우
     **FI_SLIP_LINE에 차변계정 = '210501' 이고 확정인 경우
      - FI_BILL_MOVE INSERT  --> 지급어음만기결제(sak03e) 에서 처리됨
      (전표번호, 어음상태.. 등등)
      - FI_PAYABLE_BILL  UPDATE
      (실결제일 = 회계일자, 지급어음상태('2'만기결제)

    3. 지급어음 삭제
     ** FI_SLIP_LINE 삭제시
      - FI_BILL_MOVE DELETE --> 지급어음만기결제(sak03e) 에서 처리됨
      - FI_PAYABLE_BILL  UPDATE
      ( 지급어음상태('1'지급)
*/
BEGIN

    SELECT  BANK_ID
      INTO  V_BANK_ID
      FROM  FI_BANK
     WHERE  BANK_CODE = TRIM(P_MANAGEMENT2)
       AND  SOB_ID    = P_SOB_ID;

    -- 입력
    IF P_GB = 'I' THEN

        --1. 지급어음 지급인 경우(대변)
        IF P_ACCOUNT_DR_CR = '2' THEN
            -- 발생 전표(FI_PAYABLE_BILL) UPDATE
            BEGIN
                UPDATE FI_PAYABLE_BILL
                   SET ISSUE_DATE   = P_REFER_DATE1, -- 지급일자
                       DUE_DATE     = P_REFER_DATE2, -- 만기일자
                       CUSTOMER_ID  = P_CUSTOMER_ID, -- 거래선코드
                       BILL_STATUS  = '1',           -- 1 지급
                       BILL_AMOUNT  = P_GL_AMOUNT,   -- 지급금액
                       SLIP_LINE_ID = P_SLIP_LINE_ID,-- 전표라인번호
                       REMARK       = P_REMARK       -- 적요

                 WHERE BILL_NUM    = TRIM(P_MANAGEMENT1)   -- 어음번호
                   AND SOB_ID      = P_SOB_ID;
--                 AND BILL_CLASS  =  '1'             -- 1 지급어음, 2 수표
--                 AND BANK_ID     = V_BANK_ID;       -- 지급은행

            EXCEPTION WHEN OTHERS THEN
                V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                RAISE E_UPDATE_ERR1;
            END;

        --  2. 지급어음이 만기 되었을 경우(차변)
        ELSIF P_ACCOUNT_DR_CR = '1' THEN
            -- 발생 전표(FI_PAYABLE_BILL) UPDATE
            BEGIN
                UPDATE FI_PAYABLE_BILL
                   SET PAYMENT_DATE = P_REFER_DATE1, -- 실결제일
                       SLIP_LINE_ID = P_SLIP_LINE_ID,-- 전표라인번호
                       BILL_STATUS  = '2'            -- 2 만기결제

                 WHERE BILL_NUM    = TRIM(P_MANAGEMENT1)   -- 어음번호
                   AND SOB_ID      = P_SOB_ID;       
--                 AND BILL_CLASS  =  '1'            -- 1 지급어음, 2 수표
--                 AND BANK_ID     = V_BANK_ID;      -- 지급은행

            EXCEPTION WHEN OTHERS THEN
                V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                RAISE E_UPDATE_ERR2;
            END;

        END IF;

    -- 삭제
    ELSE

        -- FI_PAYABLE_BILL  UPDATE ( 지급어음상태('0'수령)
        BEGIN

            UPDATE  FI_PAYABLE_BILL
               SET  ISSUE_DATE    = NULL,
                    DUE_DATE      = NULL,
                    CUSTOMER_ID   = NULL,
                    REMARK        = NULL,
                    SLIP_LINE_ID  = NULL,
                    BILL_STATUS   = '0'           -- 0 수령

             WHERE  BILL_NUM    = TRIM(P_MANAGEMENT1)   -- 어음번호
               AND  SOB_ID      = P_SOB_ID;
--             AND  PBLE_CLASS  =  '1'            -- 1 지급어음, 2 수표
--             AND  BANK_ID     = V_BANK_ID;      -- 지급은행

        EXCEPTION WHEN OTHERS THEN
            V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
            RAISE E_UPDATE_ERR3;
        END;

    END IF;

EXCEPTION
    WHEN E_UPDATE_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : 지급어음(대변) 저장(UPDATE ERROR) 오류!! 어음번호를 확인하십시요!! ('||V_ERRTEXT||')');
    WHEN E_UPDATE_ERR2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : 지급어음(차변) 저장(UPDATE ERROR) 오류!! 어음번호를 확인하십시요!! ('||V_ERRTEXT||')');
    WHEN E_UPDATE_ERR3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : 지급어음 저장(UPDATE ERROR) 오류!! 어음번호를 확인하십시요!! ('||V_ERRTEXT||')');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : 기타오류 - '||SQLERRM );
END FI_PAYABLE_BILL_P;
/
