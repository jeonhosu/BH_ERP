CREATE OR REPLACE VIEW FI_CUSTOMER_LEDGER_V
(account_code, account_dr_cr, gl_amount, gl_date, remarks, slip_header_id, gl_num, slip_line_id, slip_type, customer_cd)
AS
SELECT "ACCOUNT_CODE","ACCOUNT_DR_CR","GL_AMOUNT","GL_DATE","REMARK","SLIP_HEADER_ID","GL_NUM","SLIP_LINE_ID","SLIP_TYPE","CUSTOMER_CD"
FROM
    (
        SELECT
              A.ACCOUNT_CODE    --계정코드
            , A.ACCOUNT_DR_CR --차대구분(0-차, 1-대)
            , A.GL_AMOUNT --전표 금액
            , A.GL_DATE --회계일자
            , A.REMARK    --적요
            , A.SLIP_HEADER_ID    --전표 헤더 ID
            , A.GL_NUM    --전표번호
            , A.SLIP_LINE_ID    --전표라인ID
            , SLIP_TYPE         --전표유형
            , CASE
                WHEN B.REFER1_ID = 81 THEN A.MANAGEMENT1
                WHEN B.REFER2_ID = 81 THEN A.MANAGEMENT2
              END CUSTOMER_CD   --거래처코드
        FROM FI_SLIP_LINE A
            , (
                SELECT
                      ACCOUNT_CODE  --계정코드
                    , REFER1_ID --관리항목아이디1
                    , REFER2_ID --관리항목아이디2
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = 10
                    AND ORG_ID = 101
                    AND ( REFER1_ID = 81 OR REFER2_ID = 81 )
            ) B
        WHERE SOB_ID = 10
            AND ORG_ID = 101
            AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
    ) T;
comment on table FI_CUSTOMER_LEDGER_V is '거래처별원장조회';
