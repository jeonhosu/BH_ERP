CREATE OR REPLACE PACKAGE FI_GET_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_GET_CARD_G
Description  : �ſ�ī��������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�ſ�ī���������)
Program History :
    -.2���� ������ �����ȴ�. 1��° �� : �ſ�ī���������, 2��° �� : ���ݿ������������
      1.�ſ�ī��������� �ڷ� ���� ���� : �ŷ�����-����, ��������-ī�����
      2.���ݿ������������ �ڷ� ���� ���� : �ŷ�����-����, ��������-���ݿ���������
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(�ӵ���)
*****************************************************************************/



--��� �հ� �κ� ��ȸ
PROCEDURE SUM_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
);





--�ſ�ī��������� ȭ�� ��ȸ ����Ʈ
PROCEDURE LIST_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
);







--���ݿ������������ ��ȸ ����Ʈ
PROCEDURE LIST_GET_CASH(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
);





--�ſ�ī��������� ��� ����Ʈ
PROCEDURE LIST_GET_CARD_PRINT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
);






--�ſ�ī��������� ��� ��¿�
PROCEDURE PRINT_GET_CARD_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110)      
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_TAX_DATE_FR         IN  VARCHAR2    --�����Ⱓ_����
    , W_TAX_DATE_TO         IN  VARCHAR2    --�����Ⱓ_����
);






END FI_GET_CARD_G;
/
CREATE OR REPLACE PACKAGE BODY FI_GET_CARD_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_GET_CARD_G
Description  : �ſ�ī��������� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�ſ�ī���������)
Program History :
    -.2���� ������ �����ȴ�. 1��° �� : �ſ�ī���������, 2��° �� : ���ݿ������������
      1.�ſ�ī��������� �ڷ� ���� ���� : �ŷ�����-����, ��������-ī�����
      2.���ݿ������������ �ڷ� ���� ���� : �ŷ�����-����, ��������-���ݿ���������
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-27   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--��� �հ� �κ� ��ȸ
PROCEDURE SUM_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110) 
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          5 AS SEQ  --������ȣ
        , '��               ��' AS GUBUN  --����
        , COUNT(*) AS CNT                 --�ŷ��Ǽ�
        , SUM(GL_AMOUNT) AS GL_AMOUNT     --���ް���
        , SUM(VAT_AMOUNT) AS VAT_AMOUNT   --����
    FROM
    (
        SELECT
              REFER1    --��������  
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����          
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                )  --�ŷ�����(����/����)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --�����
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
            AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
            AND REFER1 IN ('6', '7')    --�������� : ī�����, ���ݿ���������    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    )

    UNION ALL

    SELECT    
          DECODE(REFER1, '6', 9, '7', 6) AS SEQ  --������ȣ
        , DECODE(REFER1, '6', '��Ÿ �ſ�ī�� ��', '7', '�� ��  �� �� ��') AS GUBUN  --����
        , COUNT(*) AS CNT
        , SUM(GL_AMOUNT)
        , SUM(VAT_AMOUNT)
    FROM
    (
        SELECT
              REFER1    --��������  
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����          
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                )  --�ŷ�����(����/����)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --�����
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
            AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
            AND REFER1 IN ('6', '7')    --�������� : ī�����, ���ݿ���������    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    )
    GROUP BY REFER1
    ORDER BY SEQ    ;

END SUM_GET_CARD;








--�ſ�ī��������� ȭ�� ��ȸ ����Ʈ
PROCEDURE LIST_GET_CARD(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110)   
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.REFER2 AS VAT_ISSUE_DATE    --�ŷ�����, �Ű��������   
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
        , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����
        , A.MANAGEMENT1 AS SUPPLIER_CODE                --�ŷ�ó�ڵ�
        , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --�ŷ�ó��
        , B.TAX_REG_NO AS TAX_REG_NO                    --����ڵ�Ϲ�ȣ      
        , A.REFER4 AS CREDITCARD_CODE                   --�ſ�ī���ڵ�   
        , FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --�ſ�ī���ȣ 
        , TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', '')) AS ASSET_BASE   --�����ڻ��ǥ
        , TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', '')) AS ASSET_TAX    --�����ڻ꼼��           
    FROM FI_SLIP_LINE A
        , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        
        --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
        AND A.ACCOUNT_CODE IN 
            (
                SELECT ACCOUNT_CODE
                FROM FI_ACCOUNT_CONTROL
                WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                    AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
            )  --�ŷ�����(����/����)     
        
        AND A.MANAGEMENT2 = W_TAX_CODE              --�����
        --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
        AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
        AND REFER1 = '6'    --��������    
        AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
    ORDER BY VAT_ISSUE_DATE, SUPPLIER_NAME    ;
    

END LIST_GET_CARD;










--���ݿ������������ ��ȸ ����Ʈ
PROCEDURE LIST_GET_CASH(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110)   
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    WITH T AS(
        SELECT
              A.REFER2 AS VAT_ISSUE_DATE    --�ŷ�����, �Ű��������   
            , 1 AS CNT  --�ż�
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
            , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����
            , A.MANAGEMENT1 AS SUPPLIER_CODE        --�ŷ�ó�ڵ�
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME     --�ŷ�ó��
            , B.TAX_REG_NO AS TAX_REG_NO            --����ڵ�Ϲ�ȣ      
            , A.REFER7 AS CASH_RECEIPT_NUM          --(���ݿ�����)���ι�ȣ    
            , TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', '')) AS ASSET_BASE   --�����ڻ��ǥ
            , TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', '')) AS ASSET_TAX    --�����ڻ꼼��           
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                )  --�ŷ�����(����/����)     
            
            AND A.MANAGEMENT2 = W_TAX_CODE              --�����
            --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
            AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
            AND REFER1 = '7'    --�������� : ���ݿ���������    
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
        ORDER BY VAT_ISSUE_DATE, SUPPLIER_NAME
    )
    SELECT ROWNUM AS SEQ, T.*
    FROM T  ;     
    

END LIST_GET_CASH;







--�ſ�ī��������� ��� ����Ʈ
PROCEDURE LIST_GET_CARD_PRINT(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110)   
    , W_DEAL_DATE_FR        IN  DATE    --�Ű�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --�Ű�Ⱓ_���� 
)

AS

BEGIN

    OPEN P_CURSOR FOR

    WITH T AS(
        SELECT
              CARD_NUM
            , TAX_REG_NO
            , COUNT(*) AS CNT
            , SUM(GL_AMOUNT) AS GL_AMOUNT
            , SUM(VAT_AMOUNT) AS VAT_AMOUNT
        FROM
        (
            SELECT  
                  FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --�ſ�ī���ȣ
                , B.TAX_REG_NO AS TAX_REG_NO                    --����ڵ�Ϲ�ȣ   
                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '')) AS GL_AMOUNT     --���ް���
                , TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', '')) AS VAT_AMOUNT    --����
                
                --A.REFER4 AS CREDITCARD_CODE --�ſ�ī���ڵ�             
                --, A.MANAGEMENT1 AS SUPPLIER_CODE                --�ŷ�ó�ڵ�
                --, B.SUPP_CUST_NAME AS SUPPLIER_NAME             --�ŷ�ó��            
                --, A.REFER2 AS VAT_ISSUE_DATE                    --�Ű��������            
                --, TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', '')) AS ASSET_BASE   --�����ڻ��ǥ
                --, TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', '')) AS ASSET_TAX    --�����ڻ꼼��           
            FROM FI_SLIP_LINE A
                , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                
                --AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
                AND A.ACCOUNT_CODE IN 
                    (
                        SELECT ACCOUNT_CODE
                        FROM FI_ACCOUNT_CONTROL
                        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                            AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                    )  --�ŷ�����(����/����)     
                
                AND A.MANAGEMENT2 = W_TAX_CODE              --�����
                --AND TO_DATE(A.REFER2) BETWEEN TO_DATE('20110401', 'YYYYMMDD') AND TO_DATE('20110630', 'YYYYMMDD')   --�Ű��������
                AND TO_DATE(A.REFER2) BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO   --�Ű��������
                AND REFER1 = '6'    --��������    
                AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)
        )
        GROUP BY CARD_NUM, TAX_REG_NO
        ORDER BY CARD_NUM, TAX_REG_NO
    ) 
    SELECT 
          ROWNUM AS SEQ --�Ϸù�ȣ
        , CARD_NUM      --ī��ȸ����ȣ
        , TAX_REG_NO    --����ڵ�Ϲ�ȣ
        , CNT           --�ŷ��Ǽ�
        , GL_AMOUNT     --���ް���
        , VAT_AMOUNT    --����
    FROM T  ;
    

END LIST_GET_CARD_PRINT;






--�ſ�ī��������� ��� ��¿�
PROCEDURE PRINT_GET_CARD_TITLE(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ZERO_TAX_SPEC.SOB_ID%TYPE                --ȸ����̵�
    , W_ORG_ID              IN  FI_ZERO_TAX_SPEC.ORG_ID%TYPE                --����ξ��̵�
    , W_TAX_CODE            IN  VARCHAR2 --�������̵�(��> 110)      
    
    --�Ʒ� �׸��� ��½� �ʼ��׸��̴�.
    , W_TAX_DATE_FR         IN  VARCHAR2    --�����Ⱓ_����
    , W_TAX_DATE_TO         IN  VARCHAR2    --�����Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          B.VAT_NUMBER                          --����ڵ�Ϲ�ȣ
        , A.LEGAL_NUMBER                        --�ֹ�(����)��Ϲ�ȣ
        , A.CORP_NAME                           --��ȣ(���θ�)
        , A.PRESIDENT_NAME                      --����(��ǥ��)
        , B.ADDR1 || ' ' || B.ADDR2 AS LOCATION --����������
        , A.TEL_NUMBER                          --��ȭ��ȣ
        , B.BUSINESS_ITEM || '(' || BUSINESS_TYPE || ')' AS BUSINESS    --����(����)                
        , '(   ' || SUBSTR(W_TAX_DATE_TO, 1, 4) || '  ��   ' ||  
          CASE
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <= 6 THEN '1  ��   '
            ELSE '2  ��   '
          END
          ||
          CASE
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  3 THEN '����   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  6 THEN 'Ȯ��   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <=  9 THEN '����   )'
            WHEN LTRIM(SUBSTR(W_TAX_DATE_TO, 6, 2), '0') <= 12 THEN 'Ȯ��   )'            
          END          
          AS FISCAL_YEAR   --�ΰ���ġ���Ű���
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
        
END PRINT_GET_CARD_TITLE;





END FI_GET_CARD_G;
/
