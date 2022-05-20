CREATE OR REPLACE VIEW FI_CUSTOMER_LEDGER_V
(account_code, account_dr_cr, gl_amount, gl_date, remarks, slip_header_id, gl_num, slip_line_id, slip_type, customer_cd)
AS
SELECT "ACCOUNT_CODE","ACCOUNT_DR_CR","GL_AMOUNT","GL_DATE","REMARK","SLIP_HEADER_ID","GL_NUM","SLIP_LINE_ID","SLIP_TYPE","CUSTOMER_CD"
FROM
    (
        SELECT
              A.ACCOUNT_CODE    --�����ڵ�
            , A.ACCOUNT_DR_CR --���뱸��(0-��, 1-��)
            , A.GL_AMOUNT --��ǥ �ݾ�
            , A.GL_DATE --ȸ������
            , A.REMARK    --����
            , A.SLIP_HEADER_ID    --��ǥ ��� ID
            , A.GL_NUM    --��ǥ��ȣ
            , A.SLIP_LINE_ID    --��ǥ����ID
            , SLIP_TYPE         --��ǥ����
            , CASE
                WHEN B.REFER1_ID = 81 THEN A.MANAGEMENT1
                WHEN B.REFER2_ID = 81 THEN A.MANAGEMENT2
              END CUSTOMER_CD   --�ŷ�ó�ڵ�
        FROM FI_SLIP_LINE A
            , (
                SELECT
                      ACCOUNT_CODE  --�����ڵ�
                    , REFER1_ID --�����׸���̵�1
                    , REFER2_ID --�����׸���̵�2
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = 10
                    AND ORG_ID = 101
                    AND ( REFER1_ID = 81 OR REFER2_ID = 81 )
            ) B
        WHERE SOB_ID = 10
            AND ORG_ID = 101
            AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    ) T;
comment on table FI_CUSTOMER_LEDGER_V is '�ŷ�ó��������ȸ';
