CREATE OR REPLACE PACKAGE FI_EXPORT_RESULT_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_RESULT_G
Description  : ����������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����������)
Program History :
    -.�ڷ� ���� ���� : �ΰ��������� ���� �ڷ� �� ���������� [����]�� �ڷ��̴�.
      �̴� [���Ը�����]���α׷����� �ŷ������� ����� ���������� ����� ��ȸ�� �ڷ�� ��ġ�Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-20   Leem Dong Ern(�ӵ���)
*****************************************************************************/




--��� �հ� �κ� ��ȸ
PROCEDURE UP_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);





--�� ���� �ڷ�
PROCEDURE LIST_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
);








--����������� ��� ��¿�
PROCEDURE PRINT_EXPORT_RESULT_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��>42)       
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����
    , W_CREATE_DATE         IN  DATE    --�ۼ����� 
);






END FI_EXPORT_RESULT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_EXPORT_RESULT_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_EXPORT_RESULT_G
Description  : ����������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0873(�����������)
Program History :
    -.�ڷ� ���� ���� : �ΰ��������� ���� �ڷ� �� ���������� [����]�� �ڷ��̴�.
      �̴� [���Ը�����]���α׷����� �ŷ������� ����� ���������� ����� ��ȸ�� �ڷ�� ��ġ�Ѵ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-20   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--��� �հ� �κ� ��ȸ
PROCEDURE UP_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          '9' SEQ
        , '��             ��' AS GUBUN    --����
        , COUNT(*) AS DATA_CNT            --�Ǽ�
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --��ȭ�ݾ�
        , '' REMARKS    --���
    FROM FI_SLIP_LINE A
    WHERE   A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
        AND MANAGEMENT2 = '3'           --�������� : ����        
        AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --�Ű��������

    UNION ALL

    SELECT
         '10' SEQ
        , '��  ��   ��  ȭ' AS GUBUN    --����
        , COUNT(*) AS DATA_CNT          --�Ǽ�
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --��ȭ�ݾ�
        , '' REMARKS    --���
    FROM FI_SLIP_LINE A
    WHERE   A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
        AND MANAGEMENT2 = '3'           --�������� : ���� 
        AND A.REFER4 IS NOT NULL
        AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --�Ű��������

    UNION ALL

    SELECT
         '11' SEQ
        , '��Ÿ����������' AS GUBUN    --����
        , COUNT(*) AS DATA_CNT         --�Ǽ�
        , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT --��ȭ�ݾ�
        , '' REMARKS    --���
    FROM FI_SLIP_LINE A
    WHERE   A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
        AND MANAGEMENT2 = '3'           --�������� : ����    
        AND A.REFER4 IS NULL
        AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
        
        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --�Ű��������
    ;


END UP_EXPORT_RESULT;








--�� ���� �ڷ�
PROCEDURE LIST_EXPORT_RESULT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              A.REFER4 AS EXPORT_NO         --����Ű��ȣ 
            , A.REFER1 AS VAT_ISSUE_DATE    --��(��)������ ; �Ű��������        
            , A.REFER3 AS CURRENCY_CODE     --��ȭ�ڵ�
            , TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')) AS EXCHANGE_RATE     --ȯ��
            , TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', '')) AS CURRENCY_AMOUNT   --��ȭ�ݾ�
            , TO_CHAR(REPLACE(TRIM(A.REFER6), ',', ''), '9999999999.00') AS PRINT_EXCHANGE_RATE         --ȯ��_��¿�
            , TO_CHAR(REPLACE(TRIM(A.REFER5), ',', ''), '9999999999999.00') AS PRINT_CURRENCY_AMOUNT    --��ȭ�ݾ�_��¿�
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '')) AS GL_AMOUNT     --��ȭ; ���ް���
            
            --, ROUND(TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')) * TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', '')))  AS B
            , DECODE(ROUND(TO_NUMBER(REPLACE(TRIM(A.REFER6), ',', '')) * TO_NUMBER(REPLACE(TRIM(A.REFER5), ',', ''))) 
                        - TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0))
                    , ',', '')), 0, 'N', 'Y') AS AMT_CHECK  --�ݾ�Ȯ�� ; (ȯ�� * ��ȭ�ݾ�)�� ��ȭ�� ���Ѵ�.
        FROM FI_SLIP_LINE A
        WHERE   A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
            AND MANAGEMENT2 = '3'           --�������� : ����
            AND A.REFER4 IS NOT NULL
            AND A.REFER11 = W_TAX_CODE      --�����(����/������� ������� �ƴ� ȸ�� �ڷῡ �Ϲ������� ���Ǵ� �������)
            
            --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
            AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO --�Ű��������        
        ORDER BY VAT_ISSUE_DATE
    )
    SELECT 
          ROWNUM SEQ
        , T.*
    FROM T;    


END LIST_EXPORT_RESULT;







--����������� ��� ��¿�
PROCEDURE PRINT_EXPORT_RESULT_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��>42)       
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����
    , W_CREATE_DATE         IN  DATE    --�ۼ����� 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER                          --����ڵ�Ϲ�ȣ
        , A.CORP_NAME                           --��ȣ(���θ�)
        , A.PRESIDENT_NAME                      --����(��ǥ��)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --����������
        , A.TEL_NUMBER                          --��ȭ��ȣ
        , B.BUSINESS_ITEM   --����
        , B.BUSINESS_TYPE   --����(����)
        , B.BUSINESS_ITEM || '(' || B.BUSINESS_TYPE || ')' AS BUSINESS    --����(����)        
        
        , TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || ' �� '
          || TO_NUMBER(TO_CHAR(W_DEAL_DATE_FR, 'MM')) || ' �� ' || TO_NUMBER(TO_CHAR(W_DEAL_DATE_FR, 'DD'))  || ' �� ~ '
          || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) || ' �� ' || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'DD')) || ' ��'
          AS DEAL_TERM   --�ŷ��Ⱓ        
        
        , TO_CHAR(W_CREATE_DATE, 'YYYY.MM.DD') AS CREATE_DATE   --�ۼ�����
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  ��   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '1  ��   )'
            ELSE '2  ��   )'
          END FISCAL_YEAR   --�ΰ���ġ���Ű���
    FROM HRM_CORP_MASTER A
       , HRM_OPERATING_UNIT B
       , ( SELECT FC.CODE AS TAX_CODE
                , FC.CODE_NAME AS TAX_DESC
                , REPLACE(FC.VALUE1, '-', '') AS VAT_NUMBER
             FROM FI_COMMON FC
            WHERE FC.GROUP_CODE     = 'TAX_CODE'
              AND FC.SOB_ID         = W_SOB_ID
              AND FC.ORG_ID         = W_ORG_ID
              AND FC.CODE           = W_TAX_CODE
          ) SX1
    WHERE A.CORP_ID = B.CORP_ID
        AND REPLACE(B.VAT_NUMBER, '-', '')    = SX1.VAT_NUMBER
        AND A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ENABLED_FLAG          = 'Y'
        AND B.USABLE                = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1);


END PRINT_EXPORT_RESULT_TITLE;






END FI_EXPORT_RESULT_G;
/
