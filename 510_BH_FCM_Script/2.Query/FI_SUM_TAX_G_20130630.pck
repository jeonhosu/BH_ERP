CREATE OR REPLACE PACKAGE FI_SUM_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_TAX_G
Description  : ��꼭�հ�ǥ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (��꼭�հ�ǥ)
Program History :
    -.�������� : ����ó����꼭�հ�ǥ, ����ó����꼭�հ�ǥ
    -.�������ڷ� :�鼼����ڰ� �ƴϹǷ� ����ó����꼭�հ�ǥ�� ������ ���� ����.
    -.���Դ���ڷ� : �鼼����(4)
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-23   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--��� �հ�κ� ��ȸ
--�Ʒ��� PROCEDURE�� �̿��ؼ� �ŷ����а��� �޾� �����ϰ� ������ C#���� ó���� �� �Ǿ� 
--�ϱ��� 2�� PROCEDURE(UP_AP_SUM_TAX, UP_AR_SUM_TAX)�� �߰��ߴ�.

PROCEDURE UP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , AP_AR_GB              IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);


--����
PROCEDURE UP_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);



--����
PROCEDURE UP_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);





--�󼼳��� �ڷ�
--�Ʒ��� PROCEDURE�� �̿��ؼ� �ŷ����а��� �޾� �����ϰ� ������ C#���� ó���� �� �Ǿ� 
--�ϱ��� 2�� PROCEDURE(LIST_AP_SUM_TAX, LIST_AR_SUM_TAX)�� �߰��ߴ�.

PROCEDURE LIST_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , AP_AR_GB              IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);



--����
PROCEDURE LIST_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);

--���� �μ�(�����̿� �ڷ�) 
PROCEDURE PRINT_AP_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);



--����
PROCEDURE LIST_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);

--���� �μ�(�����̿� �ڷ�) 
PROCEDURE PRINT_AR_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
);







--���ݰ�꼭�հ�ǥ ��� ��¿�
PROCEDURE PRINT_SUM_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)       
    , W_DEAL_DATE_FR        IN  DATE    --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�ŷ��Ⱓ_����
    , W_CREATE_DATE         IN  DATE    --�ۼ�����    
);






END FI_SUM_TAX_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SUM_TAX_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_SUM_TAX_G
Description  : ��꼭�հ�ǥ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (��꼭�հ�ǥ)
Program History :
    -.�������� : ����ó����꼭�հ�ǥ, ����ó����꼭�հ�ǥ
    -.�������ڷ� :�鼼����ڰ� �ƴϹǷ� ����ó����꼭�հ�ǥ�� ������ ���� ����.
    -.���Դ���ڷ� : �鼼����(4)
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-23   Leem Dong Ern(�ӵ���)
*****************************************************************************/



--�ŷ����� : ����


--��� �հ�κ� ��ȸ

PROCEDURE UP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , AP_AR_GB              IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
)

AS

BEGIN    

    IF AP_AR_GB = '1' THEN  --����
        
        OPEN P_CURSOR FOR
    
        WITH T AS(
            SELECT
                  '��  ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --�ŷ�ó ��
                , SUM(CNT) AS TOTAL_RECORD --�ż�
                , SUM(GL_AMOUNT) AS GL_AMOUNT --���ް���
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --��½� ����� ������, ���ް����� ����       
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                        AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.REFER1 = '4'  --�������� 
                    GROUP BY  A.MANAGEMENT1 
                ) AA      
        )
        SELECT
              '��  ��' AS TITLE
            , COMPANY_CNT --�ŷ�ó ��
            , TOTAL_RECORD --�ż�
            , GL_AMOUNT --���ް���
                
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
        FROM T  ;
        
    ELSIF AP_AR_GB = '2' THEN   --����
        
        OPEN P_CURSOR FOR
    
        WITH T AS(
            SELECT
                  '��  ��' AS TITLE
                , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --�ŷ�ó ��
                , SUM(CNT) AS TOTAL_RECORD --�ż�
                , SUM(GL_AMOUNT) AS GL_AMOUNT --���ް���
                , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --��½� ����� ������, ���ް����� ����       
            FROM
                (
                    SELECT             
                          A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                        , COUNT(*) AS CNT --�ż�
                        , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                    FROM FI_SLIP_LINE A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID 
                        AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����)
                        AND A.REFER11 = W_TAX_CODE  --�����
                        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                        AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                        AND A.MANAGEMENT2 = '4'  --�������� 
                    GROUP BY  A.MANAGEMENT1 
                ) AA      
        )
        SELECT
              '��  ��' AS TITLE
            , COMPANY_CNT --�ŷ�ó ��
            , TOTAL_RECORD --�ż�
            , GL_AMOUNT --���ް���
                
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
        FROM T  ;
                
    END IF;


END UP_SUM_TAX;







--����
PROCEDURE UP_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
)

AS

BEGIN    
    
    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              CASE
                WHEN GROUPING(AA.ELEC_FLAG) = 1 THEN 'SUM'
                ELSE AA.ELEC_FLAG
              END AS VAT_TYPE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --�ŷ�ó ��
            , SUM(CNT) AS TOTAL_RECORD --�ż�
            , SUM(GL_AMOUNT) AS GL_AMOUNT --���ް���
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --��½� ����� ������, ���ް����� ����     
            , CASE
                WHEN GROUPING(AA.ELEC_FLAG) = 1 THEN 0
                ELSE AA.ROW_NUM
              END AS ROW_NUM  
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , NVL(A.REFER6, 'N') AS ELEC_FLAG   -- ���ڿ���.
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''), '999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS GL_AMOUNT     --���ް���
                    , DECODE(NVL(A.REFER6, 'N'), 'Y', 1, 2) AS ROW_NUM
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.REFER1 = '4'  --��������                     
                GROUP BY  A.MANAGEMENT1 
                        , NVL(A.REFER6, 'N')
            ) AA   
  GROUP BY ROLLUP((AA.ELEC_FLAG
                  , AA.ROW_NUM))       
    )
    SELECT
          VAT_TYPE    -- ���԰�꼭 �հ� ���� .
        , CASE
            WHEN T.VAT_TYPE = 'Y' THEN '���ڰ�꼭'
            WHEN T.VAT_TYPE = 'SUM' THEN '��  ��'
            ELSE '���ڰ�꼭 ��'
          END AS VAT_TITLE  
        , COMPANY_CNT --�ŷ�ó ��
        , TOTAL_RECORD --�ż�
        , GL_AMOUNT --���ް���
            
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
    FROM T  
  ORDER BY T.ROW_NUM    ;

END UP_AP_SUM_TAX;










--����
PROCEDURE UP_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
)

AS

BEGIN    
        
    OPEN P_CURSOR FOR

    WITH T AS(
         SELECT
              CASE
                WHEN GROUPING(AA.TAX_ELECTRO_YN) = 1 THEN 'SUM'
                WHEN GROUPING(AA.BUSINESS_TYPE_S) = 1 THEN AA.TAX_ELECTRO_YN || 'S'
                ELSE AA.TAX_ELECTRO_YN || AA.BUSINESS_TYPE_S
              END AS LINE_TYPE
            , COUNT(AA.SUPPLIER_CODE) AS COMPANY_CNT --�ŷ�ó ��
            , SUM(AA.CNT) AS TOTAL_RECORD --�ż�
            , SUM(AA.GL_AMOUNT) AS GL_AMOUNT --���ް���
            , LENGTH(SUM(AA.GL_AMOUNT)) AS AMT_LEN   --��½� ����� ������, ���ް����� ����  
            , CASE
                WHEN GROUPING(AA.TAX_ELECTRO_YN) = 1 THEN 0
                WHEN GROUPING(AA.BUSINESS_TYPE_S) = 1 AND AA.TAX_ELECTRO_YN = 'Y' THEN 29
                WHEN GROUPING(AA.BUSINESS_TYPE_S) = 1 AND AA.TAX_ELECTRO_YN = 'N' THEN 49
                ELSE AA.ROW_NUM
              END AS ROW_NUM
        FROM 
            (
               SELECT             
                      NVL(A.REFER7, 'N') AS TAX_ELECTRO_YN
                    , DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') AS BUSINESS_TYPE_S
                    , A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''), '999999999999999999999', 'NLS_NUMERIC_CHARACTERS=,.')) AS GL_AMOUNT     --���ް���
                    , CASE
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'YC' THEN 10
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'YP' THEN 20
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'NC' THEN 30
                        WHEN NVL(A.REFER7, 'N') || DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C') = 'NP' THEN 40  
                      END AS ROW_NUM
                FROM FI_SLIP_LINE A
                   , FI_SUPP_CUST_V SC
                WHERE A.MANAGEMENT1  = SC.SUPP_CUST_CODE
                    AND A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)TAX_CODE  --�����
                    AND A.REFER11 = W_TAX_CODE  --�����
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 = '4'  --�������� 
                GROUP BY A.MANAGEMENT1
                       , NVL(A.REFER7, 'N')
                       , (DECODE(SC.BUSINESS_TYPE_S, 'P', 'P', 'C'))
            ) AA  
      GROUP BY ROLLUP((AA.TAX_ELECTRO_YN)
                     , (AA.BUSINESS_TYPE_S
                     ,  AA.ROW_NUM))        
      ORDER BY ROW_NUM 
        /*SELECT
              '��  ��' AS TITLE
            , COUNT(SUPPLIER_CODE) AS COMPANY_CNT --�ŷ�ó ��
            , SUM(CNT) AS TOTAL_RECORD --�ż�
            , SUM(GL_AMOUNT) AS GL_AMOUNT --���ް���
            , LENGTH(SUM(GL_AMOUNT)) AS AMT_LEN   --��½� ����� ������, ���ް����� ����       
        FROM
            (
                SELECT             
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS CNT --�ż�
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)TAX_CODE  --�����
                    AND A.REFER11 = W_TAX_CODE  --�����
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 = '4'  --�������� 
                GROUP BY  A.MANAGEMENT1 
            ) AA     */ 
    )
    SELECT T.LINE_TYPE AS VAT_TYPE 
        , CASE
            WHEN T.LINE_TYPE = 'YC' THEN '���ڰ�꼭 �߱޺�-����ڵ�Ϲ�ȣ'
            WHEN T.LINE_TYPE = 'YP' THEN '���ڰ�꼭 �߱޺�-�ֹε�Ϲ�ȣ'
            WHEN T.LINE_TYPE = 'YS' THEN '���ڰ�꼭 �߱޺�-�Ұ�'  
            WHEN T.LINE_TYPE = 'NC' THEN '���ڰ�꼭 ���� �߱޺�-����ڵ�Ϲ�ȣ'
            WHEN T.LINE_TYPE = 'NP' THEN '���ڰ�꼭 ���� �߱޺�-�ֹε�Ϲ�ȣ'
            WHEN T.LINE_TYPE = 'NS' THEN '���ڰ�꼭 ���� �߱޺�-�Ұ�'
            WHEN T.LINE_TYPE = 'SUM' THEN '��  ��'
          END AS VAT_TITLE
        , COMPANY_CNT --�ŷ�ó ��
        , TOTAL_RECORD --�ż�
        , GL_AMOUNT --���ް���
            
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
    FROM T  ;


END UP_AR_SUM_TAX;







--�󼼳��� �ڷ�
PROCEDURE LIST_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , AP_AR_GB              IN  VARCHAR2    --����/���� ����(1 : ����, 2 : ����)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
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
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                        
                , B.PRESIDENT_NAME        --��ǥ�ڼ���
                , B.BUSINESS_CONDITION    --����
                , B.BUSINESS_ITEM         --����
            FROM
                (
                SELECT
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS COMPANY_CNT           --�ż�     
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���     
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����
                    AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.REFER1 = '4'  --��������
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
                , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                        
                , B.PRESIDENT_NAME        --��ǥ�ڼ���
                , B.BUSINESS_CONDITION    --����
                , B.BUSINESS_ITEM         --����
            FROM
                (
                SELECT
                      A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                    , COUNT(*) AS COMPANY_CNT           --�ż�     
                    , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���     
                FROM FI_SLIP_LINE A
                WHERE A.SOB_ID = W_SOB_ID
                    AND A.ORG_ID = W_ORG_ID 
                    AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
                    AND A.REFER11 = W_TAX_CODE  --�����
                    --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                    AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                    AND A.MANAGEMENT2 = '4'  --��������
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

            , PRESIDENT_NAME        --��ǥ�ڼ���
            , BUSINESS_CONDITION    --����
            , BUSINESS_ITEM         --����    
        FROM T  ;
        
    END IF;


END LIST_SUM_TAX;









--����
PROCEDURE LIST_AP_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
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
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                    
            , B.PRESIDENT_NAME        --��ǥ�ڼ���
            , B.BUSINESS_CONDITION    --����
            , B.BUSINESS_ITEM         --����
            , AA.ELEC_FLAG
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , COUNT(*) AS COMPANY_CNT           --�ż�     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���    
                , NVL(A.REFER6, 'N') AS ELEC_FLAG 
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����
                AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.REFER1 = '4'  --��������
            GROUP BY A.MANAGEMENT1
                   , NVL(A.REFER6, 'N')
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

        , PRESIDENT_NAME        --��ǥ�ڼ���
        , BUSINESS_CONDITION    --����
        , BUSINESS_ITEM         --����   
        , ELEC_FLAG 
    FROM T  ;

END LIST_AP_SUM_TAX;


--���� �μ�(�����̿� �ڷ�) 
PROCEDURE PRINT_AP_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR1 FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
            , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
            , AA.COMPANY_CNT  --�ż�     
            
            , AA.GL_AMOUNT     --���ް���
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                    
            , B.PRESIDENT_NAME        --��ǥ�ڼ���
            , B.BUSINESS_CONDITION    --����
            , B.BUSINESS_ITEM         --����
            , AA.ELEC_FLAG
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , COUNT(*) AS COMPANY_CNT           --�ż�     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���    
                , NVL(A.REFER6, 'N') AS ELEC_FLAG 
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '1111700'  --�ŷ����� : ����
                AND A.MANAGEMENT2 = W_TAX_CODE  --�����
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.REFER1 = '4'  --��������
            GROUP BY A.MANAGEMENT1
                   , NVL(A.REFER6, 'N')
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
          AND AA.ELEC_FLAG     != 'Y'
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

        , PRESIDENT_NAME        --��ǥ�ڼ���
        , BUSINESS_CONDITION    --����
        , BUSINESS_ITEM         --����   
        , ELEC_FLAG 
    FROM T  ;

END PRINT_AP_LIST_TAX;





--����
PROCEDURE LIST_AR_SUM_TAX(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
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
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                    
            , B.PRESIDENT_NAME        --��ǥ�ڼ���
            , B.BUSINESS_CONDITION    --����
            , B.BUSINESS_ITEM         --����
            , NVL(AA.TAX_ELECTRO_YN, 'N') AS TAX_ELECTRO_YN
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , COUNT(*) AS COMPANY_CNT           --�ż�     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���     
                , NVL(A.REFER7, 'N') AS TAX_ELECTRO_YN
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
                AND A.REFER11      = W_TAX_CODE  --�����
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.MANAGEMENT2 = '4'  --��������
            GROUP BY A.MANAGEMENT1
                   , NVL(A.REFER7, 'N') 
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

        , PRESIDENT_NAME        --��ǥ�ڼ���
        , BUSINESS_CONDITION    --����
        , BUSINESS_ITEM         --����  
        , TAX_ELECTRO_YN        -- ���ڿ���   
    FROM T  ;
    
END LIST_AR_SUM_TAX;

--���� �μ�(�����̿� �ڷ�) 
PROCEDURE PRINT_AR_LIST_TAX(
      P_CURSOR1             OUT TYPES.TCURSOR1
    , W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)
    , W_DEAL_DATE_FR        IN  DATE        --�ŷ��Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE        --�ŷ��Ⱓ_����
)

AS

BEGIN
    OPEN P_CURSOR1 FOR

    WITH T AS(
        SELECT
              AA.SUPPLIER_CODE --�ŷ�ó�ڵ�
            , B.TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --��ȣ(���θ�)      
            , AA.COMPANY_CNT  --�ż�     
            
            , AA.GL_AMOUNT     --���ް���
            , LENGTH(AA.GL_AMOUNT) AS AMT_LEN   --��½� ����� ������, ���ް����� ����
                    
            , B.PRESIDENT_NAME        --��ǥ�ڼ���
            , B.BUSINESS_CONDITION    --����
            , B.BUSINESS_ITEM         --����
        FROM
            (
            SELECT
                  A.MANAGEMENT1 AS SUPPLIER_CODE    --�ŷ�ó�ڵ�
                , COUNT(*) AS COMPANY_CNT           --�ż�     
                , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���     
            FROM FI_SLIP_LINE A
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.ACCOUNT_CODE = '2100700'  --�ŷ����� : ����
                AND A.REFER11      = W_TAX_CODE  --�����
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER1) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND A.MANAGEMENT2 = '4'  --��������
                AND NVL(A.REFER7, 'N') != 'Y'  -- ���ڰ�꼭 �� 
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

        , PRESIDENT_NAME        --��ǥ�ڼ���
        , BUSINESS_CONDITION    --����
        , BUSINESS_ITEM         --����    
    FROM T  ;
    
END PRINT_AR_LIST_TAX;






--���ݰ�꼭�հ�ǥ ��� ��¿�
PROCEDURE PRINT_SUM_TAX_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2    --�������̵�(��> 110)       
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
        AND B.USABLE                = 'Y'
        AND (B.DEFAULT_FLAG         = 'Y'
        OR   ROWNUM                 <= 1);

END PRINT_SUM_TAX_TITLE;






END FI_SUM_TAX_G;
/
