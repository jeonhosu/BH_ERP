CREATE OR REPLACE PACKAGE FI_VAT_AP_AR_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_AP_AR_G
Description  : ���Ը����� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0865(���Ը�����)
Program History : 
    ���Ը����� ���α׷��� �������� �־���. �̴� FI_VAT_MASTER[���ݰ�꼭��(����/������)] ���̺��� ������� �Ͽ���.
    �׷���, �̴� ��ǥ���̺��� TRIGGER�� ���� ������ �ڷḦ �������� �Ͽ��µ�, �� TRIGGER �κ��� �ҿ����Ͽ�
    ���ռ��� ������� �ʾ� ������ �����ϰ� �Ǿ���.
    
    ���� �����ϸ鼭 ���� FI_VAT_MASTER ���̺��� ������� �ʰ�, ��ǥ ���̺�(FI_SLIP_LINE)���� ���� �ڷḦ �����Ͽ���.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-06   Leem Dong Ern(�ӵ���)          
*****************************************************************************/




/*

--�ΰ�����ޱ�(1111700), �ΰ���������(2100700)
--�Ʒ��� ���� 2������ ���� �����׸��� ������ ���̴�.

��.�ΰ�����ޱ�(1111700)
1.�ŷ�ó(01)             --MANAGEMENT1
2.�����(10)             --MANAGEMENT2
3.��������(14)           --REFER1
4.�Ű��������(17)       --REFER2
5.��������(12)           --REFER3
6.����ī��(02)           --REFER4
7.���ް���(06)           --REFER5
8.���ڼ��ݰ�꼭����(25) --REFER6
9.���ݿ��������ι�ȣ(30) --REFER7
10.����(15)              --REFER8
11.�����Ű����п���(36)--REFER9
12.�����ڻ��ǥ(04)      --REFER10
12.�����ڻ꼼��(05)      --REFER11


��.�ΰ���������(2100700)
1.�ŷ�ó(01)                         --MANAGEMENT1
2.��������(33)                       --MANAGEMENT2
3.�Ű��������(17)                   --REFER1
4.���ް���(06)                       --REFER2
5.��ȭ(31)                           --REFER3
6.����Ű��ȣ(16)                   --REFER4
7.��ȭ�ݾ�(22)                       --REFER5
8.ȯ��(34)                           --REFER6
9.���ڼ��ݰ�꼭����(25)             --REFER7
10.����(15)                          --REFER8
11.�����Ű����п���(36)            --REFER9
12.�������ڼ��ݰ�꼭��������(37)    --REFER10
13.�����(10)                        --REFER11

*/



--����/������_��ȸ
--�ŷ�ó�ڵ�� ���������ڵ�� ���ſ��� ���̵�� �ߴ��ǵ�, ���������� �ڵ�� ��ü�ߴ�.
--�� �ڵ�� ��ü�Ȱ� ������ ����. �׷��� Ȥ�� �� �ڵ�� ���� ���� ���ϴ� ���� ��ȸ���� ���� ��
--���� PROCEDURE�� �����ض�. ���� PROCEDURE : FI_VAT_MASTER.LIST_VAT_MASTER
PROCEDURE LIST_VAT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_SLIP_LINE.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID          IN FI_SLIP_LINE.ORG_ID%TYPE     --����ξ��̵�
    , W_TAX_CODE        IN VARCHAR2                     --�����
    , W_ISSUE_DATE_FR   IN DATE                         --�Ű�Ⱓ_����
    , W_ISSUE_DATE_TO   IN DATE                         --�Ű�Ⱓ_����
    , W_SUPPLIER_CODE   IN VARCHAR2                     --�ŷ�ó�ڵ�
    , W_VAT_CLASS       IN VARCHAR2                     --�ŷ�����(1:����, 2:����)
    , W_VAT_TYPE        IN VARCHAR2                     --���������ڵ�  
);





END FI_VAT_AP_AR_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_AP_AR_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_VAT_AP_AR_G
Description  : ���Ը����� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0865(���Ը�����)
Program History : 
    ���Ը����� ���α׷��� �������� �־���. �̴� FI_VAT_MASTER[���ݰ�꼭��(����/������)] ���̺��� ������� �Ͽ���.
    �׷���, �̴� ��ǥ���̺��� TRIGGER�� ���� ������ �ڷḦ �������� �Ͽ��µ�, �� TRIGGER �κ��� �ҿ����Ͽ�
    ���ռ��� ������� �ʾ� ������ �����ϰ� �Ǿ���.
    
    ���� �����ϸ鼭 ���� FI_VAT_MASTER ���̺��� ������� �ʰ�, ��ǥ ���̺�(FI_SLIP_LINE)���� ���� �ڷḦ �����Ͽ���.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-09-06   Leem Dong Ern(�ӵ���)          
*****************************************************************************/





--����/������_��ȸ
--�ŷ�ó�ڵ�� ���������ڵ�� ���ſ��� ���̵�� �ߴ��ǵ�, ���������� �ڵ�� ��ü�ߴ�.
--�� �ڵ�� ��ü�Ȱ� ������ ����. �׷��� Ȥ�� �� �ڵ�� ���� ���� ���ϴ� ���� ��ȸ���� ���� ��
--���� PROCEDURE�� �����ض�. ���� PROCEDURE : FI_VAT_MASTER.LIST_VAT_MASTER
PROCEDURE LIST_VAT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_SLIP_LINE.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID          IN FI_SLIP_LINE.ORG_ID%TYPE     --����ξ��̵�
    , W_TAX_CODE        IN VARCHAR2                     --�����
    , W_ISSUE_DATE_FR   IN DATE                         --�Ű�Ⱓ_����
    , W_ISSUE_DATE_TO   IN DATE                         --�Ű�Ⱓ_����
    , W_SUPPLIER_CODE   IN VARCHAR2                     --�ŷ�ó�ڵ�
    , W_VAT_CLASS       IN VARCHAR2                     --�ŷ�����(1:����, 2:����)
    , W_VAT_TYPE        IN VARCHAR2                     --���������ڵ�  
)

AS

BEGIN

    IF    W_VAT_CLASS = '1' THEN    --����, �ΰ�����ޱ�(1111700)
    
        OPEN P_CURSOR FOR

        SELECT             
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '����') AS VAT_CLASS    --�ŷ�����; �ΰ�����ޱ�(1111700)
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.REFER1) AS VAT_TYPE   --���������ڵ�

            --EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL) 
            -- => �� ������Ʈ������ �̷� ����� �̿��Ͽ� message�� ó���ϰ� �ִ�. 
            , CASE
                WHEN GROUPING(A.REFER1) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)  --<< �� �հ� >>
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)  --< �� �� >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AP', A.REFER1, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----��������                           
            
            , A.REFER3 AS VAT_REASON_CODE                                                               --���������ڵ�
            , FI_COMMON_G.CODE_NAME_F('VAT_REASON', A.REFER3, A.SOB_ID, A.ORG_ID) AS VAT_REASON_NAME    --��������
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --�ŷ�ó�ڵ�
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --�ŷ�ó��
            , B.TAX_REG_NO AS TAX_REG_NO                    --����ڹ�ȣ
            , A.REFER2 AS VAT_ISSUE_DATE                    --�Ű��������
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --��ǥ����
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN A.REFER2 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                            ELSE 'Y'
                        END    
                   ) AS DATE_CHECK   --����Ȯ�ο���(�Ű�������� VS ��ǥ����)
              
            --�Ʒ����� TRIM, REPLACE�� �� ������ ���� ���α׷��� ���ռ� ������ �ȵǾ� �ڷᰡ �� �� �ԷµȰ� �־�̴�.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����    
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                            ELSE 'N'
                        END    
                   ) AS AMOUNT_CHECK  --��������(���ް��� * 0.1 VS ������ ���̰� 20�̻��� ���)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --�հ� = ���ް��� + ����
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))) AS ASSET_BASE   --�����ڻ��ǥ
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))) AS ASSET_TAX    --�����ڻ꼼��            
            , NULL AS MODIFY_REASON_CODE    --�������ڼ��ݰ�꼭���������ڵ�
            , NULL AS MODIFY_REASON         --�������ڼ��ݰ�꼭��������
            , A.REFER4 AS CREDITCARD_CODE                                               --�ſ�ī���ڵ�(X)    
            , FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --�ſ�ī���ȣ
            , FI_CREDIT_CARD_G.CARD_NAME_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NAME   --�ſ�ī���(X)
            , NULL AS EXPORT_NO                                                         --����Ű��ȣ    
            , A.REFER7 AS CASH_RECEIPT_NUM                                              --���ݿ��������ι�ȣ
            , NULL AS CURRENCY_CODE                                                     --��ȭ
            , TO_NUMBER(NULL) AS EXCHANGE_RATE                                          --ȯ��
            , TO_NUMBER(NULL) AS CURRENCY_AMOUNT                                        --��ȭ�ݾ�
            , A.REFER6 AS ELEC_TAX_YN                                                   --���ڼ��ݰ�꼭����        
            , A.REMARK                                                                  --��ǥ����
            , A.GL_NUM                                                                  --��ǥ��ȣ
            
            --�Ʒ� ������ ���ʿ��� �� �ѵ� ��ǥ��ȸ�� �� �� ������ �̷� ������� �ѵ��Ͽ� ������.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --��ǥ ���� ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --��ǥ������̵�(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
            /* ���� ����������� ���α׷������� ����Ÿ���� �̿��� �ΰ��� ������ Ȯ���� �߻��ϸ� �� ���� ��� ����ϸ� �ȴ�.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                )  --�ŷ�����(����/����)              
            */
            
            AND A.MANAGEMENT2 = W_TAX_CODE                                      --�����
            AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű��������
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --�ŷ�ó
            AND REFER1 = NVL(W_VAT_TYPE, REFER1)                                --��������
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)      
        GROUP BY ROLLUP( A.REFER1
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1, A.MANAGEMENT2 
                    , A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10, A.REFER11
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    )  ;
     
    ELSIF W_VAT_CLASS = '2' THEN    --����, �ΰ���������(2100700)

        OPEN P_CURSOR FOR

        SELECT
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '����') AS VAT_CLASS          --�ŷ�����; �ΰ���������(2100700)            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.MANAGEMENT2) AS VAT_TYPE    --���������ڵ�           
            , CASE
                WHEN GROUPING(A.MANAGEMENT2) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) --<< �� �հ� >>
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)      --< �� �� >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AR', A.MANAGEMENT2, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----��������              
            , NULL AS VAT_REASON_CODE                       --���������ڵ�
            , NULL AS VAT_REASON_NAME                       --��������
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --�ŷ�ó�ڵ�
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --�ŷ�ó��
            , B.TAX_REG_NO AS TAX_REG_NO                    --����ڹ�ȣ
            , A.REFER1 AS VAT_ISSUE_DATE                    --�Ű��������
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --��ǥ����            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN A.REFER1 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                    ELSE 'Y'
                END    
              ) AS DATE_CHECK   --����Ȯ�ο���(�Ű�������� VS ��ǥ����) 
             
            --�Ʒ����� TRIM, REPLACE�� �� ������ ���� ���α׷��� ���ռ� ������ �ȵǾ� �ڷᰡ �� �� �ԷµȰ� �־�̴�.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --���� 
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                    ELSE 'N'
                END    
              ) AS AMOUNT_CHECK  --��������(���ް��� * 0.1 VS ������ ���̰� 20�̻��� ���)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --�հ� = ���ް��� + ����              

            , TO_NUMBER(NULL) AS ASSET_BASE     --�����ڻ��ǥ
            , TO_NUMBER(NULL) AS ASSET_TAX      --�����ڻ꼼��
            , A.REFER10 AS MODIFY_REASON_CODE   --�������ڼ��ݰ�꼭���������ڵ�
            , FI_COMMON_G.CODE_NAME_F('MODIFY_TAX_REASON', A.REFER10, A.SOB_ID, A.ORG_ID) AS MODIFY_REASON    --�������ڼ��ݰ�꼭��������
            , NULL AS CREDITCARD_CODE   --�ſ�ī���ڵ�(X)    
            , NULL AS CARD_NUM          --�ſ�ī���ȣ
            , NULL AS CARD_NAME         --�ſ�ī���(X)
            , A.REFER4 AS EXPORT_NO     --����Ű��ȣ    
            , NULL AS CASH_RECEIPT_NUM  --���ݿ��������ι�ȣ
            , A.REFER3 AS CURRENCY_CODE --��ȭ
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER6), ',', ''))) AS EXCHANGE_RATE     --ȯ��
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --��ȭ�ݾ�             
            , A.REFER7 AS ELEC_TAX_YN                                                   --���ڼ��ݰ�꼭����        
            , A.REMARK                                                                  --��ǥ����
            , A.GL_NUM                                                                  --��ǥ��ȣ
            
            --�Ʒ� ������ ���ʿ��� �� �ѵ� ��ǥ��ȸ�� �� �� ������ �̷� ������� �ѵ��Ͽ� ������.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --��ǥ ���� ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --��ǥ������̵�(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)
            /* ���� ����������� ���α׷������� ����Ÿ���� �̿��� �ΰ��� ������ Ȯ���� �߻��ϸ� �� ���� ��� ����ϸ� �ȴ�.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
                )  --�ŷ�����(����/����)             
            */
            
            AND A.REFER11 = W_TAX_CODE                                          --�����
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű��������
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --�ŷ�ó
            AND MANAGEMENT2 = NVL(W_VAT_TYPE, MANAGEMENT2)                      --��������
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)

        GROUP BY ROLLUP( A.MANAGEMENT2
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1 
                    , A.REFER1, A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10 
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    ) ; 

    ELSE    --���԰� ������ UNION ALL�Ͽ� �����ش�.

        OPEN P_CURSOR FOR

        SELECT             
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '����') AS VAT_CLASS    --�ŷ�����; �ΰ�����ޱ�(1111700)
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.REFER1) AS VAT_TYPE   --���������ڵ�
           
            --EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL) 
            -- => �� ������Ʈ������ �̷� ����� �̿��Ͽ� message�� ó���ϰ� �ִ�.
            , CASE
                WHEN GROUPING(A.REFER1) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)  --<< �� �հ� >>
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)  --< �� �� >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AP', A.REFER1, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----��������              
            
            , A.REFER3 AS VAT_REASON_CODE                                                               --���������ڵ�
            , FI_COMMON_G.CODE_NAME_F('VAT_REASON', A.REFER3, A.SOB_ID, A.ORG_ID) AS VAT_REASON_NAME    --��������
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --�ŷ�ó�ڵ�
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --�ŷ�ó��
            , B.TAX_REG_NO AS TAX_REG_NO                    --����ڹ�ȣ
            , A.REFER2 AS VAT_ISSUE_DATE                    --�Ű��������
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --��ǥ����
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN A.REFER2 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                            ELSE 'Y'
                        END    
                   ) AS DATE_CHECK   --����Ȯ�ο���(�Ű�������� VS ��ǥ����)
              
            --�Ʒ����� TRIM, REPLACE�� �� ������ ���� ���α׷��� ���ռ� ������ �ȵǾ� �ڷᰡ �� �� �ԷµȰ� �־�̴�.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --����    
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                        CASE
                            WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                            ELSE 'N'
                        END    
                   ) AS AMOUNT_CHECK  --��������(���ް��� * 0.1 VS ������ ���̰� 20�̻��� ���)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER5, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --�հ� = ���ް��� + ����
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER10), ',', ''))) AS ASSET_BASE  --�����ڻ��ǥ
            , SUM(TO_NUMBER(REPLACE(TRIM(A.REFER11), ',', ''))) AS ASSET_TAX    --�����ڻ꼼�� 
            , NULL AS MODIFY_REASON_CODE    --�������ڼ��ݰ�꼭���������ڵ�
            , NULL AS MODIFY_REASON         --�������ڼ��ݰ�꼭��������
            , A.REFER4 AS CREDITCARD_CODE                                               --�ſ�ī���ڵ�(X)    
            , FI_CREDIT_CARD_G.CARD_NUM_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NUM     --�ſ�ī���ȣ
            , FI_CREDIT_CARD_G.CARD_NAME_F(A.SOB_ID, A.REFER4, A.ORG_ID) AS CARD_NAME   --�ſ�ī���(X)
            , NULL AS EXPORT_NO                                                         --����Ű��ȣ    
            , A.REFER7 AS CASH_RECEIPT_NUM                                              --���ݿ��������ι�ȣ
            , NULL AS CURRENCY_CODE                                                     --��ȭ
            , TO_NUMBER(NULL) AS EXCHANGE_RATE                                          --ȯ��
            , TO_NUMBER(NULL) AS CURRENCY_AMOUNT                                        --��ȭ�ݾ�
            , A.REFER6 AS ELEC_TAX_YN                                                   --���ڼ��ݰ�꼭����        
            , A.REMARK                                                                  --��ǥ����
            , A.GL_NUM                                                                  --��ǥ��ȣ
            
            --�Ʒ� ������ ���ʿ��� �� �ѵ� ��ǥ��ȸ�� �� �� ������ �̷� ������� �ѵ��Ͽ� ������.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --��ǥ ���� ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --��ǥ������̵�(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID 
            
            AND A.ACCOUNT_CODE = '1111700'  --�ŷ�����(����/����)
            /* ���� ����������� ���α׷������� ����Ÿ���� �̿��� �ΰ��� ������ Ȯ���� �߻��ϸ� �� ���� ��� ����ϸ� �ȴ�.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1832'   --����Ÿ�� : �ΰ�����ޱ�                        
                )  --�ŷ�����(����/����)              
            */            
            
            AND A.MANAGEMENT2 = W_TAX_CODE                                      --�����
            AND TO_DATE(A.REFER2) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű��������
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --�ŷ�ó
            AND REFER1 = NVL(W_VAT_TYPE, REFER1)                                --��������
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)      
        GROUP BY ROLLUP( A.REFER1
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1, A.MANAGEMENT2 
                    , A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10, A.REFER11
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    )


        UNION ALL


        SELECT
              DECODE(GROUPING(A.SOB_ID), 1, NULL, '����') AS VAT_CLASS          --�ŷ�����; �ΰ���������(2100700)            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, A.MANAGEMENT2) AS VAT_TYPE    --���������ڵ�            
            , CASE
                WHEN GROUPING(A.MANAGEMENT2) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) --< �� �հ� >
                WHEN GROUPING(A.SOB_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10046', NULL)      --< �� �� >
                ELSE FI_COMMON_G.CODE_NAME_F('VAT_TYPE_AR', A.MANAGEMENT2, A.SOB_ID, A.ORG_ID)
              END AS VAT_TYPE_NAME   ----��������                           
            , NULL AS VAT_REASON_CODE                       --���������ڵ�
            , NULL AS VAT_REASON_NAME                       --��������
            , A.MANAGEMENT1 AS SUPPLIER_CODE                --�ŷ�ó�ڵ�
            , B.SUPP_CUST_NAME AS SUPPLIER_NAME             --�ŷ�ó��
            , B.TAX_REG_NO AS TAX_REG_NO                    --����ڹ�ȣ
            , A.REFER1 AS VAT_ISSUE_DATE                    --�Ű��������
            , TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') AS GL_DATE   --��ǥ����            
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN A.REFER1 = TO_CHAR(A.GL_DATE, 'YYYY-MM-DD') THEN 'N'
                    ELSE 'Y'
                END    
              ) AS DATE_CHECK   --����Ȯ�ο���(�Ű�������� VS ��ǥ����) 
             
            --�Ʒ����� TRIM, REPLACE�� �� ������ ���� ���α׷��� ���ռ� ������ �ȵǾ� �ڷᰡ �� �� �ԷµȰ� �־�̴�.
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', ''))) AS GL_AMOUNT     --���ް���
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS VAT_AMOUNT    --���� 
            , DECODE(GROUPING(A.SOB_ID), 1, NULL, 
                CASE
                    WHEN ABS(ABS(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') * 0.1) - ABS(REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) > 20 THEN 'Y'
                    ELSE 'N'
                END    
              ) AS AMOUNT_CHECK  --��������(���ް��� * 0.1 VS ������ ���̰� 20�̻��� ���)
            , SUM(TO_NUMBER(REPLACE(TRIM(NVL(A.REFER2, 0)), ',', '') + REPLACE(TRIM(NVL(A.REFER8, 0)), ',', ''))) AS TOTAL_AMOUNT   --�հ� = ���ް��� + ����              

            , TO_NUMBER(NULL) AS ASSET_BASE     --�����ڻ��ǥ
            , TO_NUMBER(NULL) AS ASSET_TAX      --�����ڻ꼼��
            , A.REFER10 AS MODIFY_REASON_CODE   --�������ڼ��ݰ�꼭���������ڵ�
            , FI_COMMON_G.CODE_NAME_F('MODIFY_TAX_REASON', A.REFER10, A.SOB_ID, A.ORG_ID) AS MODIFY_REASON    --�������ڼ��ݰ�꼭��������
            , NULL AS CREDITCARD_CODE   --�ſ�ī���ڵ�(X)    
            , NULL AS CARD_NUM          --�ſ�ī���ȣ
            , NULL AS CARD_NAME         --�ſ�ī���(X)
            , A.REFER4 AS EXPORT_NO     --����Ű��ȣ    
            , NULL AS CASH_RECEIPT_NUM  --���ݿ��������ι�ȣ
            , A.REFER3 AS CURRENCY_CODE --��ȭ
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER6), ',', ''))) AS EXCHANGE_RATE     --ȯ��
            , TO_NUMBER(DECODE(GROUPING(A.SOB_ID), 1, NULL, REPLACE(TRIM(A.REFER5), ',', ''))) AS CURRENCY_AMOUNT   --��ȭ�ݾ�             
            , A.REFER7 AS ELEC_TAX_YN                                                   --���ڼ��ݰ�꼭����        
            , A.REMARK                                                                  --��ǥ����
            , A.GL_NUM                                                                  --��ǥ��ȣ
            
            --�Ʒ� ������ ���ʿ��� �� �ѵ� ��ǥ��ȸ�� �� �� ������ �̷� ������� �ѵ��Ͽ� ������.
            , TO_NUMBER(A.SLIP_LINE_ID) AS SLIP_LINE_ID                                 --��ǥ ���� ID(X) 
            , TO_CHAR(A.SLIP_HEADER_ID) AS SLIP_HEADER_ID                               --��ǥ������̵�(X)               
        FROM FI_SLIP_LINE A
            , (SELECT SUPP_CUST_CODE, SUPP_CUST_NAME, TAX_REG_NO FROM FI_SUPP_CUST_V) B  --�ŷ�ó
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID
            
            AND A.ACCOUNT_CODE = '2100700'  --�ŷ�����(����/����)
            /* ���� ����������� ���α׷������� ����Ÿ���� �̿��� �ΰ��� ������ Ȯ���� �߻��ϸ� �� ���� ��� ����ϸ� �ȴ�.
            AND A.ACCOUNT_CODE IN 
                (
                    SELECT ACCOUNT_CODE
                    FROM FI_ACCOUNT_CONTROL
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CLASS_ID = '1972'   --����Ÿ�� : �ΰ���������
                )  --�ŷ�����(����/����)             
            */            
                        
            AND A.REFER11 = W_TAX_CODE                                          --�����
            AND TO_DATE(A.REFER1) BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO   --�Ű��������
            AND MANAGEMENT1 = NVL(W_SUPPLIER_CODE, MANAGEMENT1)                 --�ŷ�ó
            AND MANAGEMENT2 = NVL(W_VAT_TYPE, MANAGEMENT2)                      --��������
            
            AND A.MANAGEMENT1 = B.SUPP_CUST_CODE(+)

        GROUP BY ROLLUP( A.MANAGEMENT2
                , (   A.SOB_ID, A.ORG_ID, B.SUPP_CUST_NAME, TAX_REG_NO, GL_DATE, A.MANAGEMENT1 
                    , A.REFER1, A.REFER2, A.REFER3, A.REFER4, A.REFER5, A.REFER6, A.REFER7, A.REFER8, A.REFER10 
                    , REMARK, GL_NUM, SLIP_LINE_ID, SLIP_HEADER_ID
                  )    ) 
        ; 

    END IF;



END LIST_VAT;




END FI_VAT_AP_AR_G;
/
