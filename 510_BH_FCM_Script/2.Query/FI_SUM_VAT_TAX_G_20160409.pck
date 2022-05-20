CREATE OR REPLACE PACKAGE FI_SUM_VAT_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_VAT_TAX_G
Description  : ���ݰ�꼭�հ�ǥ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (���ݰ�꼭�հ�ǥ)
Program History :
����ó�����ݰ�꼭�հ�ǥ, ����ó�����ݰ�꼭�հ�ǥ
    -.�������ڷ� : ����(1), ����(2)
    -.���Դ���ڷ� : ��������(1), ��������(2), ���Լ��׺Ұ���(3), ����(5), �������Ը����ڹ��༼�ݰ�꼭(9)
    -.�ֹε�Ϲ�ȣ �߱޺��� �������μ��� ������Ѵ�.
      Ȥ, �� ��찡 �߻��Ǹ� �ŷ�ó������ �ֹι�ȣ �ŷ�ó�� ���а��� �߰��� �� �׸� �������� �ڷḦ �����ϸ� �ȴ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-22   Leem Dong Ern(�ӵ���)
*****************************************************************************/







--��� �հ�κ� ��ȸ
--�Ʒ��� PROCEDURE�� �̿��ؼ� �ŷ����а��� �޾� �����ϰ� ������ C#���� ó���� �� �Ǿ� 
--�ϱ��� 2�� PROCEDURE(UP_AP_SUM_VAT_TAX, UP_AR_SUM_VAT_TAX)�� �߰��ߴ�.

PROCEDURE UP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2      --�������̵�(��> 110)
    , W_AP_AR_GB            IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);



--����

PROCEDURE UP_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);







--����

PROCEDURE UP_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);







--�󼼳��� �ڷ�
--�Ʒ��� PROCEDURE�� �̿��ؼ� �ŷ����а��� �޾� �����ϰ� ������ C#���� ó���� �� �Ǿ� 
--�ϱ��� 2�� PROCEDURE(LIST_AP_SUM_VAT_TAX, LIST_AR_SUM_VAT_TAX)�� �߰��ߴ�.

PROCEDURE LIST_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2      --�������̵�(��> 110)
    , AP_AR_GB              IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
    
    -- Y : ���ڼ��ݰ�꼭��(15���̳� ���ۺ�), N : ���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
    , ELEC_TAX_YN           IN  VARCHAR2    --���ڼ��ݰ�꼭����  
);





--����

PROCEDURE LIST_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
    
    -- Y : ���ڼ��ݰ�꼭��(15���̳� ���ۺ�), N : ���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
    , ELEC_TAX_YN           IN  VARCHAR2    --���ڼ��ݰ�꼭����  
);




--����

PROCEDURE LIST_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
    
    -- Y : ���ڼ��ݰ�꼭��(15���̳� ���ۺ�), N : ���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
    , ELEC_TAX_YN           IN  VARCHAR2    --���ڼ��ݰ�꼭����  
);




--���ݰ�꼭�հ�ǥ ��� ��¿�
PROCEDURE PRINT_SUM_VAT_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��>110)       
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����
    , W_CREATE_DATE         IN  DATE    --�ۼ����� 
);






END FI_SUM_VAT_TAX_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SUM_VAT_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_VAT_TAX_G
Description  : ���ݰ�꼭�հ�ǥ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (���ݰ�꼭�հ�ǥ)
Program History :
����ó�����ݰ�꼭�հ�ǥ, ����ó�����ݰ�꼭�հ�ǥ
    -.�������ڷ� : ����(1), ����(2)
    -.���Դ���ڷ� : ��������(1), ��������(2), ���Լ��׺Ұ���(3), ����(5), �������Ը����ڹ��༼�ݰ�꼭(9)
    -.�ֹε�Ϲ�ȣ �߱޺��� �������μ��� ������Ѵ�.
      Ȥ, �� ��찡 �߻��Ǹ� �ŷ�ó������ �ֹι�ȣ �ŷ�ó�� ���а��� �߰��� �� �׸� �������� �ڷḦ �����ϸ� �ȴ�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-22   Leem Dong Ern(�ӵ���)
*****************************************************************************/







--��� �հ�κ� ��ȸ
PROCEDURE UP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2      --�������̵�(��> 110)
    , W_AP_AR_GB            IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN


    IF W_AP_AR_GB = '1' THEN  --����
        
        OPEN P_CURSOR FOR
    
        WITH T AS(
            --�հ�
            SELECT
                  '��    ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , SUM(CNT) AS TOT_RECORD                --�ż�
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                  
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                    GROUP BY  A.MANAGEMENT1     
                )

            UNION ALL

            --���ڼ��ݰ�꼭��(15���̳� ���ۺ�)
            SELECT
                  '��    ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , SUM(CNT) AS TOT_RECORD                --�ż�
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                  
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1   
                )

            UNION ALL

            --���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
            SELECT
                '���� ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , SUM(CNT) AS TOT_RECORD                --�ż�
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                  
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                        AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1  
                )
        )
        SELECT
              TITLE   
            
            --����ڵ�Ϲ�ȣ �߱޹�����
            , COMPANY_CNT AS COM_CNT    --����ó��
            , TOT_RECORD AS COM_REC     --�ż�
            , TOT_GL_AMOUNT AS COM_GL   --���ް���
            , TOT_VAT_AMOUNT AS COM_VAT --����
                                    
            , SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS COM_GL_1      --���ް���_������
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(TOT_GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS COM_GL_2      --���ް���_�ʾ����
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS COM_GL_3      --���ް���_�鸸����
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS COM_GL_4      --���ް���_õ����
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(TOT_GL_AMOUNT)
                ELSE SUBSTR(TOT_GL_AMOUNT, -3, 3)
              END AS COM_GL_5      --���ް���_������
                
            , SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS COM_VAT_1      --����_������
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(TOT_VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS COM_VAT_2      --����_�ʾ����
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS COM_VAT_3      --����_�鸸����
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS COM_VAT_4      --����_õ����
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(TOT_VAT_AMOUNT)
                ELSE SUBSTR(TOT_VAT_AMOUNT, -3, 3)
              END AS COM_VAT_5      --����_������                        
            
            --�ֹε�Ϲ�ȣ �߱޹�����
            --�ֹε�Ϲ�ȣ �߱޺��� �������μ��� ������Ѵ�.
            --Ȥ, �� ��찡 �߻��Ǹ� �ŷ�ó������ �ֹι�ȣ �ŷ�ó�� ���а��� �߰��� �� �׸� �������� �ڷḦ �����ϸ� �ȴ�.
            , 0 AS SN_CNT   --����ó��
            , 0 AS SN_REC   --�ż�
            , 0 AS SN_GL    --���ް���
            , 0 AS SN_VAT   --����
            
            --���հ�
            , COMPANY_CNT AS TOTAL_CNT      --����ó��
            , TOT_RECORD AS TOTAL_REC       --�ż�
            , TOT_GL_AMOUNT AS TOTAL_GL     --���ް���
            , TOT_VAT_AMOUNT AS TOTAL_VAT   --����  
        FROM T  ;
        
    ELSIF W_AP_AR_GB = '2' THEN   --����
        
        OPEN P_CURSOR FOR
        
        WITH T AS(
            --�հ�
            SELECT
                  '��    ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , SUM(CNT) AS TOT_RECORD                --�ż�
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                 
            FROM
                (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                    AND A.REFER11 = W_TAX_CODE      --�����
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 IN ('1', '2')  --�������� 
                GROUP BY  A.MANAGEMENT1     
                )

            UNION ALL

            --���ڼ��ݰ�꼭��(15���̳� ���ۺ�)
            SELECT
                  '��    ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , SUM(CNT) AS TOT_RECORD                --�ż�
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                 
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                        AND A.REFER11 = W_TAX_CODE      --�����
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.MANAGEMENT2 IN ('1', '2')  --��������
                        AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1 
                )

            UNION ALL

            --���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
            SELECT
                '���� ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
                , SUM(CNT) AS TOT_RECORD                --�ż�
                , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
                , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
                
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
                , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                 
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                        AND A.REFER11 = W_TAX_CODE      --�����
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.MANAGEMENT2 IN ('1', '2')  --��������
                        AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1
                )
        )
        SELECT
              TITLE   
            
            --����ڵ�Ϲ�ȣ �߱޹�����
            , COMPANY_CNT AS COM_CNT    --����ó��
            , TOT_RECORD AS COM_REC     --�ż�
            , TOT_GL_AMOUNT AS COM_GL   --���ް���
            , TOT_VAT_AMOUNT AS COM_VAT --����
            
                        
            , SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS COM_GL_1      --���ް���_������
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(TOT_GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS COM_GL_2      --���ް���_�ʾ����
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS COM_GL_3      --���ް���_�鸸����
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS COM_GL_4      --���ް���_õ����
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(TOT_GL_AMOUNT)
                ELSE SUBSTR(TOT_GL_AMOUNT, -3, 3)
              END AS COM_GL_5      --���ް���_������
                
            , SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS COM_VAT_1      --����_������
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(TOT_VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS COM_VAT_2      --����_�ʾ����
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS COM_VAT_3      --����_�鸸����
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS COM_VAT_4      --����_õ����
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(TOT_VAT_AMOUNT)
                ELSE SUBSTR(TOT_VAT_AMOUNT, -3, 3)
              END AS COM_VAT_5      --����_������                        
            
            --�ֹε�Ϲ�ȣ �߱޹�����
            --�ֹε�Ϲ�ȣ �߱޺��� �������μ��� ������Ѵ�.
            --Ȥ, �� ��찡 �߻��Ǹ� �ŷ�ó������ �ֹι�ȣ �ŷ�ó�� ���а��� �߰��� �� �׸� �������� �ڷḦ �����ϸ� �ȴ�.
            , 0 AS SN_CNT   --����ó��
            , 0 AS SN_REC   --�ż�
            , 0 AS SN_GL    --���ް���
            , 0 AS SN_VAT   --����
            
            --���հ�
            , COMPANY_CNT AS TOTAL_CNT      --����ó��
            , TOT_RECORD AS TOTAL_REC       --�ż�
            , TOT_GL_AMOUNT AS TOTAL_GL     --���ް���
            , TOT_VAT_AMOUNT AS TOTAL_VAT   --����  
        FROM T  ;
        
    END IF;

END UP_SUM_VAT_TAX;









--����
PROCEDURE UP_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN
    
    OPEN P_CURSOR FOR

    WITH T AS(
        --�հ�
        SELECT
              '��    ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
            , SUM(CNT) AS TOT_RECORD                --�ż�
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                GROUP BY  A.MANAGEMENT1     
            ) TA

        UNION ALL

        --���ڼ��ݰ�꼭��(15���̳� ���ۺ�)
        SELECT
              '��    ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
            , SUM(CNT) AS TOT_RECORD                --�ż�
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                    AND TRIM(NVL(A.REFER6, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
                GROUP BY  A.MANAGEMENT1   
            ) TB

        UNION ALL

        --���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
        SELECT
            '���� ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT   --����ó��
            , SUM(CNT) AS TOT_RECORD                --�ż�
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --�������� 
                    AND TRIM(NVL(A.REFER6, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                GROUP BY  A.MANAGEMENT1  
            ) TC
    )              
    SELECT
          TITLE   
        
        --����ڵ�Ϲ�ȣ �߱޹�����
        , COMPANY_CNT AS COM_CNT    --����ó��
        , TOT_RECORD AS COM_REC     --�ż�
        , TOT_GL_AMOUNT AS COM_GL   --���ް���
        , TOT_VAT_AMOUNT AS COM_VAT --����
                                
        , SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS COM_GL_1      --���ް���_������
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(TOT_GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS COM_GL_2      --���ް���_�ʾ����
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(TOT_GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS COM_GL_3      --���ް���_�鸸����
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(TOT_GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(TOT_GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS COM_GL_4      --���ް���_õ����
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(TOT_GL_AMOUNT)
            ELSE SUBSTR(TOT_GL_AMOUNT, -3, 3)
          END AS COM_GL_5      --���ް���_������
            
        , SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS COM_VAT_1      --����_������
        , CASE
            WHEN VAT_LEN > 12 THEN SUBSTR(TOT_VAT_AMOUNT, -12, 3)
            WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
            ELSE ''
          END AS COM_VAT_2      --����_�ʾ����
        , CASE
            WHEN VAT_LEN > 9 THEN SUBSTR(TOT_VAT_AMOUNT, -9, 3)
            WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
            ELSE ''
          END AS COM_VAT_3      --����_�鸸����
        , CASE
            WHEN VAT_LEN > 6 THEN SUBSTR(TOT_VAT_AMOUNT, -6, 3)
            WHEN VAT_LEN > 3 THEN SUBSTR(TOT_VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
            ELSE ''
          END AS COM_VAT_4      --����_õ����
        , CASE
            WHEN VAT_LEN <= 3 THEN TO_CHAR(TOT_VAT_AMOUNT)
            ELSE SUBSTR(TOT_VAT_AMOUNT, -3, 3)
          END AS COM_VAT_5      --����_������                        
        
        --�ֹε�Ϲ�ȣ �߱޹�����
        --�ֹε�Ϲ�ȣ �߱޺��� �������μ��� ������Ѵ�.
        --Ȥ, �� ��찡 �߻��Ǹ� �ŷ�ó������ �ֹι�ȣ �ŷ�ó�� ���а��� �߰��� �� �׸� �������� �ڷḦ �����ϸ� �ȴ�.
        , 0 AS SN_CNT   --����ó��
        , 0 AS SN_REC   --�ż�
        , 0 AS SN_GL    --���ް���
        , 0 AS SN_VAT   --����
        
        --���հ�
        , COMPANY_CNT AS TOTAL_CNT      --����ó��
        , TOT_RECORD AS TOTAL_REC       --�ż�
        , TOT_GL_AMOUNT AS TOTAL_GL     --���ް���
        , TOT_VAT_AMOUNT AS TOTAL_VAT   --����
    FROM T  ;        


END UP_AP_SUM_VAT_TAX;









--����

PROCEDURE UP_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    
    --�Ű�Ⱓ�� ȭ�鿡�� �� ���δ�. �Ű�Ⱓ������ �����ϸ� ���������� ������ ���� �̿��� ���̴�.
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN
   
    OPEN P_CURSOR FOR
    
    WITH T AS(
        --�հ�
        SELECT
              '��    ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS TOT_CNT   --����ó��
            , SUM(CNT) AS TOT_RECORD                --�ż�
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����                 
            
            -- ����ڹ�ȣ 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', NULL, SUPPLIER_CODE)) AS C_CNT   --����ó��
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, CNT)) AS C_RECORD                --�ż�
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT)) AS C_GL_AMOUNT       --���ް���
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT)) AS C_VAT_AMOUNT     --����
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT))) AS C_AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT))) AS C_VAT_LEN    --��½� ����� ������, ������ ����                 
            
            -- �ֹι�ȣ -- 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', SUPPLIER_CODE, NULL)) AS P_CNT   --����ó��
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', CNT, 0)) AS P_RECORD                --�ż�
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0)) AS P_GL_AMOUNT       --���ް���
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0)) AS P_VAT_AMOUNT     --����
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0))) AS P_AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0))) AS P_VAT_LEN    --��½� ����� ������, ������ ����           
        FROM
            (
            SELECT             
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , NVL((SELECT SC.BUSINESS_TYPE_S
                         FROM FI_SUPP_CUST_V SC
                        WHERE SC.SUPP_CUST_CODE   = A.MANAGEMENT1
                          AND SC.SOB_ID           = A.SOB_ID
                      ), 'C') AS BUSINESS_TYPE_S
                , COUNT(*) AS CNT --�ż�
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                AND A.REFER11 = W_TAX_CODE      --�����
                --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.MANAGEMENT2 IN ('1', '2')  --�������� 
            GROUP BY  A.MANAGEMENT1     
                    , A.SOB_ID
            ) TA

        UNION ALL

        --���ڼ��ݰ�꼭��(15���̳� ���ۺ�)
        SELECT
              '��    ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS TOT_CNT   --����ó��
            , SUM(CNT) AS TOT_RECORD                --�ż�
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����    
            
            -- ����ڹ�ȣ 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', NULL, SUPPLIER_CODE)) AS C_CNT   --����ó��
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, CNT)) AS C_RECORD                --�ż�
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT)) AS C_GL_AMOUNT       --���ް���
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT)) AS C_VAT_AMOUNT     --����
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT))) AS C_AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT))) AS C_VAT_LEN    --��½� ����� ������, ������ ����                 
            
            -- �ֹι�ȣ -- 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', SUPPLIER_CODE, NULL)) AS P_CNT   --����ó��
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', CNT, 0)) AS P_RECORD                --�ż�
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0)) AS P_GL_AMOUNT       --���ް���
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0)) AS P_VAT_AMOUNT     --����
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0))) AS P_AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0))) AS P_VAT_LEN    --��½� ����� ������, ������ ����                            
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , NVL((SELECT SC.BUSINESS_TYPE_S
                         FROM FI_SUPP_CUST_V SC
                        WHERE SC.SUPP_CUST_CODE   = A.MANAGEMENT1
                          AND SC.SOB_ID           = A.SOB_ID
                      ), 'C') AS BUSINESS_TYPE_S
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                    AND A.REFER11 = W_TAX_CODE      --�����
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 IN ('1', '2')  --��������
                    AND TRIM(NVL(A.REFER7, 'N')) = 'Y'   --���ڼ��ݰ�꼭����
                GROUP BY  A.MANAGEMENT1     
                        , A.SOB_ID 
            ) TB

        UNION ALL

        --���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
        SELECT
            '���� ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS TOT_CNT   --����ó��
            , SUM(CNT) AS TOT_RECORD                --�ż�
            , SUM(GL_AMOUNT) AS TOT_GL_AMOUNT       --���ް���
            , SUM(VAT_AMOUNT) AS TOT_VAT_AMOUNT     --����
            
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(VAT_AMOUNT)) AS VAT_LEN    --��½� ����� ������, ������ ����      
            
            -- ����ڹ�ȣ 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', NULL, SUPPLIER_CODE)) AS C_CNT   --����ó��
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, CNT)) AS C_RECORD                --�ż�
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT)) AS C_GL_AMOUNT       --���ް���
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT)) AS C_VAT_AMOUNT     --����
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, GL_AMOUNT))) AS C_AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', 0, VAT_AMOUNT))) AS C_VAT_LEN    --��½� ����� ������, ������ ����                 
            
            -- �ֹι�ȣ -- 
            , COUNT(DECODE(BUSINESS_TYPE_S, 'P', SUPPLIER_CODE, NULL)) AS P_CNT   --����ó��
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', CNT, 0)) AS P_RECORD                --�ż�
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0)) AS P_GL_AMOUNT       --���ް���
            , SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0)) AS P_VAT_AMOUNT     --����
            
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', GL_AMOUNT, 0))) AS P_AMT_LEN     --��½� ����� ������, ���ް����� ����
            , LENGTH(SUM(DECODE(BUSINESS_TYPE_S, 'P', VAT_AMOUNT, 0))) AS P_VAT_LEN    --��½� ����� ������, ������ ����                           
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , NVL((SELECT SC.BUSINESS_TYPE_S
                         FROM FI_SUPP_CUST_V SC
                        WHERE SC.SUPP_CUST_CODE   = A.MANAGEMENT1
                          AND SC.SOB_ID           = A.SOB_ID
                      ), 'C') AS BUSINESS_TYPE_S
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                    AND A.REFER11 = W_TAX_CODE      --�����
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 IN ('1', '2')  --��������
                    AND TRIM(NVL(A.REFER7, 'N')) = 'N'   --���ڼ��ݰ�꼭����
                GROUP BY  A.MANAGEMENT1
                        , A.SOB_ID 
            ) TC
    )        
    SELECT
          TITLE   
        
        --����ڵ�Ϲ�ȣ �߱޹�����
        , C_CNT AS COM_CNT                 --����ó��
        , C_RECORD AS COM_REC              --�ż�
        , C_GL_AMOUNT AS COM_GL            --���ް���
        , C_VAT_AMOUNT AS COM_VAT          --����
        
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS COM_GL_1
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS COM_GL_2
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS COM_GL_3
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS COM_GL_4
        , REPLACE(SUBSTR(LPAD(C_GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS COM_GL_5
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS COM_VAT_1
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS COM_VAT_2
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS COM_VAT_3
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS COM_VAT_4
        , REPLACE(SUBSTR(LPAD(C_VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS COM_VAT_5
         
        --�ֹε�Ϲ�ȣ �߱޹�����
        --�ֹε�Ϲ�ȣ �߱޺��� �������μ��� ������Ѵ�.
        --Ȥ, �� ��찡 �߻��Ǹ� �ŷ�ó������ �ֹι�ȣ �ŷ�ó�� ���а��� �߰��� �� �׸� �������� �ڷḦ �����ϸ� �ȴ�.
        , P_CNT AS SN_CNT                 --����ó��
        , P_RECORD AS SN_REC              --�ż�
        , P_GL_AMOUNT AS SN_GL            --���ް���
        , P_VAT_AMOUNT AS SN_VAT          --���� 
        
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS SN_GL_1
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS SN_GL_2
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS SN_GL_3
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS SN_GL_4
        , REPLACE(SUBSTR(LPAD(P_GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS SN_GL_5
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS SN_VAT_1
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS SN_VAT_2
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS SN_VAT_3
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS SN_VAT_4
        , REPLACE(SUBSTR(LPAD(P_VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS SN_VAT_5  
          
        --���հ�
        , TOT_CNT AS TOTAL_CNT          --����ó��
        , TOT_RECORD AS TOTAL_REC       --�ż�
        , TOT_GL_AMOUNT AS TOTAL_GL     --���ް���
        , TOT_VAT_AMOUNT AS TOTAL_VAT   --����  
        
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS TOTAL_GL_1
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS TOTAL_GL_2
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS TOTAL_GL_3
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS TOTAL_GL_4
        , REPLACE(SUBSTR(LPAD(TOT_GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS TOTAL_GL_5
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS TOTAL_VAT_1
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS TOTAL_VAT_2
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS TOTAL_VAT_3
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS TOTAL_VAT_4
        , REPLACE(SUBSTR(LPAD(TOT_VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS TOTAL_VAT_5
    FROM T  ; 


END UP_AR_SUM_VAT_TAX;







--�󼼳��� �ڷ�
PROCEDURE LIST_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2      --�������̵�(��> 110)
    , AP_AR_GB              IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
    
    -- Y : ���ڼ��ݰ�꼭��(15���̳� ���ۺ�), N : ���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
    , ELEC_TAX_YN           IN  VARCHAR2    --���ڼ��ݰ�꼭����  
)

AS

BEGIN

    IF AP_AR_GB = '1' THEN --����

        OPEN P_CURSOR FOR

        WITH T AS(
            SELECT
                  AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
                , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
                , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
                , AA.COMPANY_CNT  --�ż�
                
                , AA.GL_AMOUNT     --���ް���
                , AA.VAT_AMOUNT    --���� 
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --��½� ����� ������, ������ ����        
                
                , B.PRESIDENT_NAME        --��ǥ�ڼ���
                , B.BUSINESS_CONDITION    --����
                , B.BUSINESS_ITEM         --����
            FROM
                (
                SELECT
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS COMPANY_CNT           --�ż�     
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����     
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.REFER1 IN ('1', '2', '3', '5', '9')  --��������
                    AND TRIM(NVL(A.REFER6, 'N')) = ELEC_TAX_YN   --���ڼ��ݰ�꼭����
                GROUP BY A.MANAGEMENT1
                ) AA
                , ( SELECT 
                          SUPP_CUST_CODE        --�ڵ�
                        , SUPP_CUST_NAME        --��ȣ
                        , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                        , PRESIDENT_NAME        --��ǥ�ڼ���
                        , BUSINESS_CONDITION    --����
                        , BUSINESS_ITEM         --����
                    FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
            WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
            ORDER BY TAX_REG_NO
        )
        SELECT 
              ROWNUM AS SEQ
            , SUPPLIER_CODE --�ŷ�ó�ڵ�
            , TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
            , SUPPLIER_NAME             --��ȣ(���θ�)      
            , COMPANY_CNT  --�ż�
            
            , GL_AMOUNT     --���ް���    
            , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --���ް���_������
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS GL_AMOUNT_2      --���ް���_�ʾ����
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS GL_AMOUNT_3      --���ް���_�鸸����
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS GL_AMOUNT_4      --���ް���_õ����
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
                ELSE SUBSTR(GL_AMOUNT, -3, 3)
              END AS GL_AMOUNT_5      --���ް���_������
                
            , VAT_AMOUNT    --����
            , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --����_������
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS VAT_AMOUNT_2      --����_�ʾ����
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS VAT_AMOUNT_3      --����_�鸸����
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS VAT_AMOUNT_4      --����_õ����
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
                ELSE SUBSTR(VAT_AMOUNT, -3, 3)
              END AS VAT_AMOUNT_5      --����_������

            , PRESIDENT_NAME        --��ǥ�ڼ���
            , BUSINESS_CONDITION    --����
            , BUSINESS_ITEM         --����    
        FROM T  ;

    ELSIF AP_AR_GB = '2' THEN --����
        
        OPEN P_CURSOR FOR
        
        WITH T AS(
            SELECT
                  AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
                , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
                , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
                , AA.COMPANY_CNT  --�ż�
                
                , AA.GL_AMOUNT     --���ް���
                , AA.VAT_AMOUNT    --���� 
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --��½� ����� ������, ������ ����        
                
                , B.PRESIDENT_NAME        --��ǥ�ڼ���
                , B.BUSINESS_CONDITION    --����
                , B.BUSINESS_ITEM         --����
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS COMPANY_CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                        AND A.REFER11 = W_TAX_CODE      --�����
                        --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.MANAGEMENT2 IN ('1', '2')  --��������
                        AND TRIM(NVL(A.REFER7, 'N')) = ELEC_TAX_YN   --���ڼ��ݰ�꼭����
                    GROUP BY  A.MANAGEMENT1 
                ) AA
                , ( SELECT 
                          SUPP_CUST_CODE        --�ڵ�
                        , SUPP_CUST_NAME        --��ȣ
                        , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                        , PRESIDENT_NAME        --��ǥ�ڼ���
                        , BUSINESS_CONDITION    --����
                        , BUSINESS_ITEM         --����
                    FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
            WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
            ORDER BY TAX_REG_NO
        )
        SELECT 
              ROWNUM AS SEQ
            , SUPPLIER_CODE --�ŷ�ó�ڵ�
            , TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
            , SUPPLIER_NAME             --��ȣ(���θ�)      
            , COMPANY_CNT  --�ż�
            
            , GL_AMOUNT     --���ް���    
            , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --���ް���_������
            , CASE
                WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
                ELSE ''
              END AS GL_AMOUNT_2      --���ް���_�ʾ����
            , CASE
                WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
                ELSE ''
              END AS GL_AMOUNT_3      --���ް���_�鸸����
            , CASE
                WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
                WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
                ELSE ''
              END AS GL_AMOUNT_4      --���ް���_õ����
            , CASE
                WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
                ELSE SUBSTR(GL_AMOUNT, -3, 3)
              END AS GL_AMOUNT_5      --���ް���_������
                
            , VAT_AMOUNT    --����
            , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --����_������
            , CASE
                WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
                ELSE ''
              END AS VAT_AMOUNT_2      --����_�ʾ����
            , CASE
                WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
                ELSE ''
              END AS VAT_AMOUNT_3      --����_�鸸����
            , CASE
                WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
                WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
                ELSE ''
              END AS VAT_AMOUNT_4      --����_õ����
            , CASE
                WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
                ELSE SUBSTR(VAT_AMOUNT, -3, 3)
              END AS VAT_AMOUNT_5      --����_������

            , PRESIDENT_NAME        --��ǥ�ڼ���
            , BUSINESS_CONDITION    --����
            , BUSINESS_ITEM         --����    
        FROM T  ;

    END IF;


END LIST_SUM_VAT_TAX;









--����

PROCEDURE LIST_AP_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
    
    -- Y : ���ڼ��ݰ�꼭��(15���̳� ���ۺ�), N : ���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
    , ELEC_TAX_YN           IN  VARCHAR2    --���ڼ��ݰ�꼭����  
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
            , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
            , AA.COMPANY_CNT  --�ż�
            
            , AA.GL_AMOUNT     --���ް���
            , AA.VAT_AMOUNT    --���� 
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
            , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --��½� ����� ������, ������ ����        
            
            , B.PRESIDENT_NAME        --��ǥ�ڼ���
            , B.BUSINESS_CONDITION    --����
            , B.BUSINESS_ITEM         --����
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , COUNT(*) AS COMPANY_CNT           --�ż�     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����     
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����, �ΰ�����ޱ�(1111700)
                AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.REFER1 IN ('1', '2', '3', '5', '9')  --��������
                AND TRIM(NVL(A.REFER6, 'N')) = ELEC_TAX_YN   --���ڼ��ݰ�꼭����
            GROUP BY A.MANAGEMENT1
            ) AA
            , ( SELECT 
                      SUPP_CUST_CODE        --�ڵ�
                    , SUPP_CUST_NAME        --��ȣ
                    , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                    , PRESIDENT_NAME        --��ǥ�ڼ���
                    , BUSINESS_CONDITION    --����
                    , BUSINESS_ITEM         --����
                FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
        WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
        ORDER BY TAX_REG_NO
    )
    SELECT 
          ROWNUM AS SEQ
        , SUPPLIER_CODE --�ŷ�ó�ڵ�
        , TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
        , SUPPLIER_NAME             --��ȣ(���θ�)      
        , COMPANY_CNT  --�ż�
        
        , GL_AMOUNT     --���ް���    
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --���ް���_������
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --���ް���_�ʾ����
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --���ް���_�鸸����
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --���ް���_õ����
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --���ް���_������
            
        , VAT_AMOUNT    --����
        , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --����_������
        , CASE
            WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
            ELSE ''
          END AS VAT_AMOUNT_2      --����_�ʾ����
        , CASE
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
            ELSE ''
          END AS VAT_AMOUNT_3      --����_�鸸����
        , CASE
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
            WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
            ELSE ''
          END AS VAT_AMOUNT_4      --����_õ����
        , CASE
            WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
            ELSE SUBSTR(VAT_AMOUNT, -3, 3)
          END AS VAT_AMOUNT_5      --����_������

        , PRESIDENT_NAME        --��ǥ�ڼ���
        , BUSINESS_CONDITION    --����
        , BUSINESS_ITEM         --����    
    FROM T  ;

END LIST_AP_SUM_VAT_TAX;










--����
PROCEDURE LIST_AR_SUM_VAT_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
    
    -- Y : ���ڼ��ݰ�꼭��(15���̳� ���ۺ�), N : ���ڼ��ݰ�꼭��(���� 15�ϰ�� ���ۺ�����)
    , ELEC_TAX_YN           IN  VARCHAR2    --���ڼ��ݰ�꼭����  
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
            , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
            , AA.COMPANY_CNT  --�ż�
            
            , AA.GL_AMOUNT     --���ް���
            , AA.VAT_AMOUNT    --���� 
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
            , LENGTH(AA.VAT_AMOUNT) AS VAT_LEN   --��½� ����� ������, ������ ����        
            
            , B.PRESIDENT_NAME        --��ǥ�ڼ���
            , B.BUSINESS_CONDITION    --����
            , B.BUSINESS_ITEM         --����
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS COMPANY_CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����, �ΰ���������(2100700)
                    AND A.REFER11 = W_TAX_CODE      --�����
                    --AND TO_DATE(A.REFER1) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 IN ('1', '2')  --��������
                    AND TRIM(NVL(A.REFER7, 'N')) = ELEC_TAX_YN   --���ڼ��ݰ�꼭����
                GROUP BY  A.MANAGEMENT1 
            ) AA
            , ( SELECT 
                      SUPP_CUST_CODE        --�ڵ�
                    , SUPP_CUST_NAME        --��ȣ
                    , TAX_REG_NO            --����ڵ�Ϲ�ȣ
                    , PRESIDENT_NAME        --��ǥ�ڼ���
                    , BUSINESS_CONDITION    --����
                    , BUSINESS_ITEM         --����
                FROM FI_SUPP_CUST_V) B  --�ŷ�ó    
        WHERE AA.SUPPLIER_CODE = B.SUPP_CUST_CODE(+)
        ORDER BY TAX_REG_NO
    )
    SELECT 
          ROWNUM AS SEQ
        , SUPPLIER_CODE --�ŷ�ó�ڵ�
        , TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
        , SUPPLIER_NAME             --��ȣ(���θ�)      
        , COMPANY_CNT  --�ż�
        
        , GL_AMOUNT     --���ް���    
        , SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 12) AS GL_AMOUNT_1      --���ް���_������
        , CASE
            WHEN AMT_LEN > 12 THEN SUBSTR(GL_AMOUNT, -12, 3)
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 9)
            ELSE ''
          END AS GL_AMOUNT_2      --���ް���_�ʾ����
        , CASE
            WHEN AMT_LEN > 9 THEN SUBSTR(GL_AMOUNT, -9, 3)
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 6)
            ELSE ''
          END AS GL_AMOUNT_3      --���ް���_�鸸����
        , CASE
            WHEN AMT_LEN > 6 THEN SUBSTR(GL_AMOUNT, -6, 3)
            WHEN AMT_LEN > 3 THEN SUBSTR(GL_AMOUNT, -AMT_LEN, AMT_LEN - 3)
            ELSE ''
          END AS GL_AMOUNT_4      --���ް���_õ����
        , CASE
            WHEN AMT_LEN <= 3 THEN TO_CHAR(GL_AMOUNT)
            ELSE SUBSTR(GL_AMOUNT, -3, 3)
          END AS GL_AMOUNT_5      --���ް���_������
            
        , VAT_AMOUNT    --����
        , SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 12) AS VAT_AMOUNT_1      --����_������
        , CASE
            WHEN VAT_LEN > 12 THEN SUBSTR(VAT_AMOUNT, -12, 3)
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 9)
            ELSE ''
          END AS VAT_AMOUNT_2      --����_�ʾ����
        , CASE
            WHEN VAT_LEN > 9 THEN SUBSTR(VAT_AMOUNT, -9, 3)
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 6)
            ELSE ''
          END AS VAT_AMOUNT_3      --����_�鸸����
        , CASE
            WHEN VAT_LEN > 6 THEN SUBSTR(VAT_AMOUNT, -6, 3)
            WHEN VAT_LEN > 3 THEN SUBSTR(VAT_AMOUNT, -VAT_LEN, VAT_LEN - 3)
            ELSE ''
          END AS VAT_AMOUNT_4      --����_õ����
        , CASE
            WHEN VAT_LEN <= 3 THEN TO_CHAR(VAT_AMOUNT)
            ELSE SUBSTR(VAT_AMOUNT, -3, 3)
          END AS VAT_AMOUNT_5      --����_������

        , PRESIDENT_NAME        --��ǥ�ڼ���
        , BUSINESS_CONDITION    --����
        , BUSINESS_ITEM         --����    
    FROM T  ;

END LIST_AR_SUM_VAT_TAX;








--���ݰ�꼭�հ�ǥ ��� ��¿�
PROCEDURE PRINT_SUM_VAT_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2  --�������̵�(��>110)       
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
          || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || ' �� '
          || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) || ' �� ' || TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'DD')) || ' ��'
          AS DEAL_TERM   --�ŷ��Ⱓ        
        
        , TO_CHAR(W_CREATE_DATE, 'YYYY') || '�� ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'MM')) || '�� ' 
          || TO_NUMBER(TO_CHAR(W_CREATE_DATE, 'DD')) || '�� '  AS CREATE_DATE   --�ۼ�����
          
        , '(   ' || TO_CHAR(W_DEAL_DATE_TO, 'YYYY') || '  ��   ' ||  
          CASE
            WHEN TO_NUMBER(TO_CHAR(W_DEAL_DATE_TO, 'MM')) <= 6 THEN '��  1  ��   )'
            ELSE '��  2  ��   )'
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
        AND B.ENABLED_FLAG          = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1);


END PRINT_SUM_VAT_TAX_TITLE;






END FI_SUM_VAT_TAX_G;
/
