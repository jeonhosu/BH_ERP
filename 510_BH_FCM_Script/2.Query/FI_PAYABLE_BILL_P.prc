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
    1. ���޾��� ������ ���
     **FI_SLIP_LINE�� �뺯���� ='210501' �̰� Ȯ���� ���
      - FI_BILL_MOVE ó������
      - FI_PAYABLE_BILL  UPDATE
      (���ްŷ�ó,���ޱݾ�, ��������, ��������, ���޾�������('1' ����), �����ڵ�

    2. ���޾����� ���� �Ǿ��� ���
     **FI_SLIP_LINE�� �������� = '210501' �̰� Ȯ���� ���
      - FI_BILL_MOVE INSERT  --> ���޾����������(sak03e) ���� ó����
      (��ǥ��ȣ, ��������.. ���)
      - FI_PAYABLE_BILL  UPDATE
      (�ǰ����� = ȸ������, ���޾�������('2'�������)

    3. ���޾��� ����
     ** FI_SLIP_LINE ������
      - FI_BILL_MOVE DELETE --> ���޾����������(sak03e) ���� ó����
      - FI_PAYABLE_BILL  UPDATE
      ( ���޾�������('1'����)
*/
BEGIN

    SELECT  BANK_ID
      INTO  V_BANK_ID
      FROM  FI_BANK
     WHERE  BANK_CODE = TRIM(P_MANAGEMENT2)
       AND  SOB_ID    = P_SOB_ID;

    -- �Է�
    IF P_GB = 'I' THEN

        --1. ���޾��� ������ ���(�뺯)
        IF P_ACCOUNT_DR_CR = '2' THEN
            -- �߻� ��ǥ(FI_PAYABLE_BILL) UPDATE
            BEGIN
                UPDATE FI_PAYABLE_BILL
                   SET ISSUE_DATE   = P_REFER_DATE1, -- ��������
                       DUE_DATE     = P_REFER_DATE2, -- ��������
                       CUSTOMER_ID  = P_CUSTOMER_ID, -- �ŷ����ڵ�
                       BILL_STATUS  = '1',           -- 1 ����
                       BILL_AMOUNT  = P_GL_AMOUNT,   -- ���ޱݾ�
                       SLIP_LINE_ID = P_SLIP_LINE_ID,-- ��ǥ���ι�ȣ
                       REMARK       = P_REMARK       -- ����

                 WHERE BILL_NUM    = TRIM(P_MANAGEMENT1)   -- ������ȣ
                   AND SOB_ID      = P_SOB_ID;
--                 AND BILL_CLASS  =  '1'             -- 1 ���޾���, 2 ��ǥ
--                 AND BANK_ID     = V_BANK_ID;       -- ��������

            EXCEPTION WHEN OTHERS THEN
                V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                RAISE E_UPDATE_ERR1;
            END;

        --  2. ���޾����� ���� �Ǿ��� ���(����)
        ELSIF P_ACCOUNT_DR_CR = '1' THEN
            -- �߻� ��ǥ(FI_PAYABLE_BILL) UPDATE
            BEGIN
                UPDATE FI_PAYABLE_BILL
                   SET PAYMENT_DATE = P_REFER_DATE1, -- �ǰ�����
                       SLIP_LINE_ID = P_SLIP_LINE_ID,-- ��ǥ���ι�ȣ
                       BILL_STATUS  = '2'            -- 2 �������

                 WHERE BILL_NUM    = TRIM(P_MANAGEMENT1)   -- ������ȣ
                   AND SOB_ID      = P_SOB_ID;       
--                 AND BILL_CLASS  =  '1'            -- 1 ���޾���, 2 ��ǥ
--                 AND BANK_ID     = V_BANK_ID;      -- ��������

            EXCEPTION WHEN OTHERS THEN
                V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
                RAISE E_UPDATE_ERR2;
            END;

        END IF;

    -- ����
    ELSE

        -- FI_PAYABLE_BILL  UPDATE ( ���޾�������('0'����)
        BEGIN

            UPDATE  FI_PAYABLE_BILL
               SET  ISSUE_DATE    = NULL,
                    DUE_DATE      = NULL,
                    CUSTOMER_ID   = NULL,
                    REMARK        = NULL,
                    SLIP_LINE_ID  = NULL,
                    BILL_STATUS   = '0'           -- 0 ����

             WHERE  BILL_NUM    = TRIM(P_MANAGEMENT1)   -- ������ȣ
               AND  SOB_ID      = P_SOB_ID;
--             AND  PBLE_CLASS  =  '1'            -- 1 ���޾���, 2 ��ǥ
--             AND  BANK_ID     = V_BANK_ID;      -- ��������

        EXCEPTION WHEN OTHERS THEN
            V_ERRTEXT := SQLCODE || ' : ' || SQLERRM;
            RAISE E_UPDATE_ERR3;
        END;

    END IF;

EXCEPTION
    WHEN E_UPDATE_ERR1 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : ���޾���(�뺯) ����(UPDATE ERROR) ����!! ������ȣ�� Ȯ���Ͻʽÿ�!! ('||V_ERRTEXT||')');
    WHEN E_UPDATE_ERR2 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : ���޾���(����) ����(UPDATE ERROR) ����!! ������ȣ�� Ȯ���Ͻʽÿ�!! ('||V_ERRTEXT||')');
    WHEN E_UPDATE_ERR3 THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : ���޾��� ����(UPDATE ERROR) ����!! ������ȣ�� Ȯ���Ͻʽÿ�!! ('||V_ERRTEXT||')');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'FI_PAYABLE_BILL_P : ��Ÿ���� - '||SQLERRM );
END FI_PAYABLE_BILL_P;
/
