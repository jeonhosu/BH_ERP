CREATE OR REPLACE PACKAGE FI_CUSTOMER_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_CUSTOMER_LEDGER_G
Description  : �ŷ�ó��������ȸ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�ŷ�ó��������ȸ)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-09   Leem Dong Ern(�ӵ���)
*****************************************************************************/




--��� �հ賻�� ��ȸ
PROCEDURE UP_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --�����ڵ�   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --�ŷ�ó�ڵ�
);






--�ϴ� �󼼳��� ��ȸ
PROCEDURE DET_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --�����ڵ�   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --�ŷ�ó�ڵ�
);





--��ȸ���ǿ��� ������ ��ȸ�� ������� �� �ڷᰡ �ִ� ������ �����ش�.
PROCEDURE LIST_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ACCOUNT_CONTROL.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_ACCOUNT_CONTROL.ORG_ID%TYPE
    , W_ACCOUNT_SET_ID  IN  FI_ACCOUNT_CONTROL.ACCOUNT_SET_ID%TYPE
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����      
    , W_ACCOUNT_FR      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_ACCOUNT_TO      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --�ŷ�ó�ڵ�
);





END FI_CUSTOMER_LEDGER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_CUSTOMER_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_CUSTOMER_LEDGER_G
Description  : �ŷ�ó��������ȸ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�ŷ�ó��������ȸ)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-09   Leem Dong Ern(�ӵ���)
*****************************************************************************/






--��� �հ賻�� ��ȸ
PROCEDURE UP_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --�����ڵ�   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --�ŷ�ó�ڵ�
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;  --���뱸��(1-����,2-�뺯)
t_ACCOUNT_DESC      FI_ACCOUNT_CONTROL.ACCOUNT_DESC%TYPE;   --������

BEGIN

    BEGIN

        SELECT
              ACCOUNT_DR_CR --���뱸��(1-����,2-�뺯)
            , ACCOUNT_DESC  --������
        INTO t_ACCOUNT_DR_CR, t_ACCOUNT_DESC
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ACCOUNT_CODE = W_ACCOUNT_CODE    ;
            
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
            
           --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');                    
    END;


    --Ư���ŷ�ó�� �������� ���� ���
    IF NVL(W_CUSTOMER_CD, 'NONE') = 'NONE' THEN
    
        OPEN P_CURSOR FOR

        SELECT
              DECODE(GROUPING(CUSTOMER_CD), 1, '', W_ACCOUNT_CODE) AS ACCOUNT_CODE    --�����ڵ�
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', t_ACCOUNT_DESC) AS ACCOUNT_DESC    --������
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', DECODE(t_ACCOUNT_DR_CR, '1', '����', 2, '�뺯')) AS ACCOUNT_DR_CR   --���뱸��
            , CUSTOMER_CD       --�ŷ�ó�ڵ�
            , DECODE(GROUPING(CUSTOMER_CD), 1, '   [  ��   ��  ]', B.SUPP_CUST_NAME) AS SUPP_CUST_NAME   --�ŷ�ó��        
            
            , B.TAX_REG_NO      --����ڵ�Ϲ�ȣ
            , SUM(NVL(FORWARD_AMT, 0)) AS FORWARD_AMT    --�̿��ݾ�
            , SUM(NVL(INC_AMT, 0)) AS INC_AMT            --����
            , SUM(NVL(DEC_AMT, 0)) AS DEC_AMT            --����
            , SUM(NVL(FORWARD_AMT, 0) + NVL(INC_AMT, 0) - NVL(DEC_AMT, 0)) AS REMAIN_AMT --�ܾ�
        FROM
            (
                SELECT 
                      A.CUSTOMER_CD --�ŷ�ó�ڵ�
                    
                    --�̿��ݾ� : ��ȸ���۳� 1�� 1�� ~ ��ȸ������ ���� ������ �ݾ� �հ�
                    , (
                        SELECT
                            CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                                WHEN '1' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, -GL_AMOUNT))    --�����̸�
                                WHEN '2' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, -GL_AMOUNT, GL_AMOUNT))    --�뺯�̸�
                            END
                        
                        --�Ʒ� �������� ��ü�Ѵ�.
                        --FROM FI_CUSTOMER_LEDGER_V
                        --WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        --    AND CUSTOMER_CD = A.CUSTOMER_CD
                        
                        --��ü�� ����
                        FROM FI_SLIP_LINE
                        WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND (NVL(MANAGEMENT1, 'NONE') = A.CUSTOMER_CD OR MANAGEMENT2 = A.CUSTOMER_CD)


                            AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                        AND --�̿��ݾ� ��ȸ �������ڴ� 
                                            CASE 
                                                --��ȸ�Ⱓ�� �������� 1��1���̸� �ش���� 1�� 1��
                                                WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                                ELSE W_DEAL_DATE_FR - 1    --�ƴϸ� �������� ����
                                            END
                            AND SLIP_TYPE = --��ǥ������
                                    CASE 
                                        WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --��ȸ�Ⱓ�� �������� 1��1���̸� '�����ܾ�'��
                                        ELSE SLIP_TYPE   --��� ��ǥ����
                                    END
                    ) FORWARD_AMT --�̿��ݾ�

                    , CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                        WHEN '1' THEN C.GL_AMOUNT --�����̸�
                        WHEN '2' THEN D.GL_AMOUNT --�뺯�̸�
                    END INC_AMT --����
                    
                    , CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                        WHEN '1' THEN D.GL_AMOUNT --�����̸�
                        WHEN '2' THEN C.GL_AMOUNT --�뺯�̸�
                    END DEC_AMT --����                
                FROM
                    (   --��ȸ�Ⱓ(�������� ��ȸ�������� ���� 1��1�����̴�.)�� ��ȸ ������ ���յǴ� �ŷ�ó�� �����Ѵ�.
                        --��ȸ�������� 1�� 1�Ϸ� �ϴ� ������ ��ȸ�Ǵ� �ڷḦ �繫����ǥ�� ��ġ�ϱ� ���ؼ��̴�.
                        SELECT NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            
                            --�� ���常�� ELSE�� ���� ����� �ٸ���. ��, ��� �ŷ�ó�� ��ȸ�Ǵ� ����̹Ƿ� �ŷ�ó ������ ����.

                        GROUP BY CUSTOMER_CD
                    ) A
                    
                    --QUERY���������>C, D ���̺��� 1���� ���̺�� ���� ���� �ִµ� �������� �谡�ϰ�,
                    --�� �ӵ��鿡���� ���̰� ���� ����ó�� 2���� ���̺�� �ߴ�.                
                    , ( --�����ݾ�
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴ� �ڷḸ
                            AND ACCOUNT_DR_CR = 1   --����
                        GROUP BY CUSTOMER_CD
                        ) C
                    , ( --�뺯�ݾ�
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴ� �ڷḸ
                            AND ACCOUNT_DR_CR = 2   --�뺯
                        GROUP BY CUSTOMER_CD
                        ) D       
                WHERE A.CUSTOMER_CD = C.CUSTOMER_CD(+) 
                    AND A.CUSTOMER_CD = D.CUSTOMER_CD(+) 
            ) T
            , FI_SUPP_CUST_V B
        WHERE T.CUSTOMER_CD = B.SUPP_CUST_CODE(+)
        GROUP BY ROLLUP((CUSTOMER_CD,SUPP_CUST_NAME,TAX_REG_NO,FORWARD_AMT,INC_AMT,DEC_AMT))    
        ORDER BY ACCOUNT_CODE, CUSTOMER_CD    ;
        
    --Ư���ŷ�ó�� ������ ���
    ELSE

        OPEN P_CURSOR FOR

        SELECT
              DECODE(GROUPING(CUSTOMER_CD), 1, '', W_ACCOUNT_CODE) AS ACCOUNT_CODE    --�����ڵ�
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', t_ACCOUNT_DESC) AS ACCOUNT_DESC    --������
            , DECODE(GROUPING(CUSTOMER_CD), 1, '', DECODE(t_ACCOUNT_DR_CR, '1', '����', 2, '�뺯')) AS ACCOUNT_DR_CR   --���뱸��
            , CUSTOMER_CD       --�ŷ�ó�ڵ�
            , DECODE(GROUPING(CUSTOMER_CD), 1, '   [  ��   ��  ]', B.SUPP_CUST_NAME) AS SUPP_CUST_NAME   --�ŷ�ó��        
            
            , B.TAX_REG_NO      --����ڵ�Ϲ�ȣ
            , SUM(NVL(FORWARD_AMT, 0)) AS FORWARD_AMT    --�̿��ݾ�
            , SUM(NVL(INC_AMT, 0)) AS INC_AMT            --����
            , SUM(NVL(DEC_AMT, 0)) AS DEC_AMT            --����
            , SUM(NVL(FORWARD_AMT, 0) + NVL(INC_AMT, 0) - NVL(DEC_AMT, 0)) AS REMAIN_AMT --�ܾ�
        FROM
            (
                SELECT 
                      A.CUSTOMER_CD --�ŷ�ó�ڵ�
                    
                    --�̿��ݾ� : ��ȸ���۳� 1�� 1�� ~ ��ȸ������ ���� ������ �ݾ� �հ�
                    , (
                        SELECT
                            CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                                WHEN '1' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, -GL_AMOUNT))    --�����̸�
                                WHEN '2' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, -GL_AMOUNT, GL_AMOUNT))    --�뺯�̸�
                            END
                        
                        --�Ʒ� �������� ��ü�Ѵ�.
                        --FROM FI_CUSTOMER_LEDGER_V
                        --WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        --    AND CUSTOMER_CD = A.CUSTOMER_CD
                        
                        --��ü�� ����
                        FROM FI_SLIP_LINE
                        WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND (MANAGEMENT1 = A.CUSTOMER_CD OR MANAGEMENT2 = A.CUSTOMER_CD)                        


                            AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                        AND --�̿��ݾ� ��ȸ �������ڴ� 
                                            CASE 
                                                --��ȸ�Ⱓ�� �������� 1��1���̸� �ش���� 1�� 1��
                                                WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                                ELSE W_DEAL_DATE_FR - 1    --�ƴϸ� �������� ����
                                            END
                            AND SLIP_TYPE = --��ǥ������
                                    CASE 
                                        WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --��ȸ�Ⱓ�� �������� 1��1���̸� '�����ܾ�'��
                                        ELSE SLIP_TYPE   --��� ��ǥ����
                                    END
                    ) FORWARD_AMT --�̿��ݾ�

                    , CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                        WHEN '1' THEN C.GL_AMOUNT --�����̸�
                        WHEN '2' THEN D.GL_AMOUNT --�뺯�̸�
                    END INC_AMT --����
                    
                    , CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                        WHEN '1' THEN D.GL_AMOUNT --�����̸�
                        WHEN '2' THEN C.GL_AMOUNT --�뺯�̸�
                    END DEC_AMT --����                
                FROM
                    (   --��ȸ�Ⱓ(�������� ��ȸ�������� ���� 1��1�����̴�.)�� ��ȸ ������ ���յǴ� �ŷ�ó�� �����Ѵ�.
                        --��ȸ�������� 1�� 1�Ϸ� �ϴ� ������ ��ȸ�Ǵ� �ڷḦ �繫����ǥ�� ��ġ�ϱ� ���ؼ��̴�.
                        SELECT NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            
                            AND CUSTOMER_CD = W_CUSTOMER_CD --�� ���常�� IF�� ���� ����� �ٸ���.
                        GROUP BY CUSTOMER_CD
                    ) A
                    
                    --QUERY���������>C, D ���̺��� 1���� ���̺�� ���� ���� �ִµ� �������� �谡�ϰ�,
                    --�� �ӵ��鿡���� ���̰� ���� ����ó�� 2���� ���̺�� �ߴ�.                
                    , ( --�����ݾ�
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴ� �ڷḸ
                            AND ACCOUNT_DR_CR = 1   --����
                        GROUP BY CUSTOMER_CD
                        ) C
                    , ( --�뺯�ݾ�
                        SELECT
                              NVL(CUSTOMER_CD, 'NONE') AS CUSTOMER_CD
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_CUSTOMER_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴ� �ڷḸ
                            AND ACCOUNT_DR_CR = 2   --�뺯
                        GROUP BY CUSTOMER_CD
                        ) D       
                WHERE A.CUSTOMER_CD = C.CUSTOMER_CD(+) 
                    AND A.CUSTOMER_CD = D.CUSTOMER_CD(+) 
            ) T
            , FI_SUPP_CUST_V B
        WHERE T.CUSTOMER_CD = B.SUPP_CUST_CODE(+)
        GROUP BY ROLLUP((CUSTOMER_CD,SUPP_CUST_NAME,TAX_REG_NO,FORWARD_AMT,INC_AMT,DEC_AMT))    
        ORDER BY ACCOUNT_CODE, CUSTOMER_CD    ;

    END IF;


END UP_CUSTOMER_LEDGER;







--�ϴ� �󼼳��� ��ȸ
PROCEDURE DET_CUSTOMER_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --�����ڵ�   
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --�ŷ�ó�ڵ�
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;      --���뱸��(1-����,2-�뺯)
t_ACCOUNT_DESC      FI_CUSTOMER_LEDGER.ACCOUNT_DESC%TYPE;       --������
t_CUSTOMER_NM       FI_CUSTOMER_LEDGER.CUSTOMER_NM%TYPE;        --�ŷ�ó��
t_REMAIN_AMT        FI_CUSTOMER_LEDGER.REMAIN_AMT%TYPE := 0;    --�ܾ�

BEGIN

    BEGIN
    
        --1.�����ڷḦ �����Ѵ�.
        DELETE FI_CUSTOMER_LEDGER;    

        SELECT
              ACCOUNT_DR_CR --���뱸��(1-����,2-�뺯)
            , ACCOUNT_DESC  --������
        INTO t_ACCOUNT_DR_CR, t_ACCOUNT_DESC
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ACCOUNT_CODE = W_ACCOUNT_CODE    ;              

        --�Ʒ� if���� ��ǻ� ����. ���� �ŷ�ó ���ϴ� �κи��� �ٸ���. [��> AND CUSTOMER_CD IS NULL]
        IF W_CUSTOMER_CD = 'NONE' THEN        
        
            t_CUSTOMER_NM := '';

            --2.�����ڷḦ �����Ѵ�.
            --2-1.�̿��ݾ� �����ڷ� ����
        
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --��ȸ�Ϸù�ȣ
                , GL_DATE           --ȸ������
                , REMARKS           --����
                , DR_AMT            --����(�ݾ�)
                , CR_AMT            --�뺯(�ݾ�)
                , REMAIN_AMT        --�ܾ�
                , ACCOUNT_CODE      --�����ڵ�
                , ACCOUNT_DESC      --������
                , CUSTOMER_CD       --�ŷ�ó�ڵ�
                , CUSTOMER_NM       --�ŷ�ó��
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ    
            )
            SELECT
                  1     --��ȸ�Ϸù�ȣ
                , NULL  --ȸ������
                , '[�̿��ݾ�]' AS REMARKS   --����
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --����
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --�뺯
                , 0                 --�ܾ�       
                , W_ACCOUNT_CODE    --�����ڵ�
                , t_ACCOUNT_DESC    --������
                , W_CUSTOMER_CD     --�ŷ�ó�ڵ�
                , t_CUSTOMER_NM     --�ŷ�ó��
                , NULL              --��ǥ������̵�
                , NULL              --��ǥ��ȣ         
            FROM
                (
                    SELECT ACCOUNT_DR_CR, SUM(GL_AMOUNT) AS GL_AMOUNT
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD IS NULL --else block���� ����� �����ϰ� �ٸ��κ�
                        AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                    AND --�̿��ݾ� ��ȸ �������ڴ� 
                                        CASE 
                                            --��ȸ�Ⱓ�� �������� 1��1���̸� �ش���� 1�� 1��
                                            WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                            ELSE W_DEAL_DATE_FR - 1    --�ƴϸ� �������� ����
                                        END
                        AND SLIP_TYPE = --��ǥ������
                                CASE 
                                    WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --��ȸ�Ⱓ�� �������� 1��1���̸� '�����ܾ�'��
                                    ELSE SLIP_TYPE   --��� ��ǥ����
                                END
                    GROUP BY CUSTOMER_CD, ACCOUNT_DR_CR
                )   ;  
                
            --2-2.��ȸ�Ⱓ �� �߻��� �ڷῡ ���� �����ڷ� ����
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --��ȸ�Ϸù�ȣ
                , GL_DATE           --ȸ������
                , REMARKS           --����
                , DR_AMT            --����(�ݾ�)
                , CR_AMT            --�뺯(�ݾ�)
                , REMAIN_AMT        --�ܾ�
                , ACCOUNT_CODE      --�����ڵ�
                , ACCOUNT_DESC      --������
                , CUSTOMER_CD       --�ŷ�ó�ڵ�
                , CUSTOMER_NM       --�ŷ�ó��
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ    
            )
            SELECT
                  ROWNUM + 1 AS ROW_NUM    --��ȸ�Ϸù�ȣ
                  
                --�� ȸ�����ڿ� 1�ʾ��� �����ش�.
                --���� : ���� ȸ�����ڿ� ���� GROUP BY ROOLUP�� ����Ǹ� ������ �޶����� ������ �ذ��ϱ� �����̴�.
                , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --ȸ������
                
                , REMARKS       --����
                , DR_AMT     --����
                , CR_AMT     --�뺯
                , 0 REMAIN_AMT      --�ܾ�
                , W_ACCOUNT_CODE    --�����ڵ�
                , t_ACCOUNT_DESC    --������
                , W_CUSTOMER_CD     --�ŷ�ó�ڵ�
                , t_CUSTOMER_NM     --�ŷ�ó��                                
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ              
            FROM(          
                    SELECT
                          GL_DATE       --ȸ������                          
                        , REMARKS       --����
                        , NVL(DECODE(ACCOUNT_DR_CR, '1', GL_AMOUNT, 0), 0) AS DR_AMT     --����
                        , NVL(DECODE(ACCOUNT_DR_CR, '2', GL_AMOUNT, 0), 0) AS CR_AMT     --�뺯
                        , SLIP_HEADER_ID    --��ǥ������̵�
                        , GL_NUM            --��ǥ��ȣ   
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD IS NULL --else block���� ����� �����ϰ� �ٸ��κ�
                        AND GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                        AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴѰ�
                    ORDER BY GL_DATE
                )  ;            

        ELSE
        
            SELECT SUPP_CUST_NAME
            INTO t_CUSTOMER_NM   --�ŷ�ó��
            FROM FI_SUPP_CUST_V
            WHERE SUPP_CUST_CODE = NVL(W_CUSTOMER_CD, SUPP_CUST_CODE)    ;

            --2.�����ڷḦ �����Ѵ�.
            --2-1.�̿��ݾ� �����ڷ� ����
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --��ȸ�Ϸù�ȣ
                , GL_DATE           --ȸ������
                , REMARKS           --����
                , DR_AMT            --����(�ݾ�)
                , CR_AMT            --�뺯(�ݾ�)
                , REMAIN_AMT        --�ܾ�
                , ACCOUNT_CODE      --�����ڵ�
                , ACCOUNT_DESC      --������
                , CUSTOMER_CD       --�ŷ�ó�ڵ�
                , CUSTOMER_NM       --�ŷ�ó��
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ    
            )
            SELECT
                  1     --��ȸ�Ϸù�ȣ
                , NULL  --ȸ������
                , '[�̿��ݾ�]' AS REMARKS   --����
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --����
                , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --�뺯
                , 0                 --�ܾ�       
                , W_ACCOUNT_CODE    --�����ڵ�
                , t_ACCOUNT_DESC    --������
                , W_CUSTOMER_CD     --�ŷ�ó�ڵ�
                , t_CUSTOMER_NM     --�ŷ�ó��
                , NULL              --��ǥ������̵�
                , NULL              --��ǥ��ȣ         
            FROM
                (
                    SELECT ACCOUNT_DR_CR, SUM(GL_AMOUNT) AS GL_AMOUNT
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD = W_CUSTOMER_CD --if block���� ����� �����ϰ� �ٸ��κ�
                        AND GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                    AND --�̿��ݾ� ��ȸ �������ڴ� 
                                        CASE 
                                            --��ȸ�Ⱓ�� �������� 1��1���̸� �ش���� 1�� 1��
                                            WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                            ELSE W_DEAL_DATE_FR - 1    --�ƴϸ� �������� ����
                                        END
                        AND SLIP_TYPE = --��ǥ������
                                CASE 
                                    WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --��ȸ�Ⱓ�� �������� 1��1���̸� '�����ܾ�'��
                                    ELSE SLIP_TYPE   --��� ��ǥ����
                                END
                    GROUP BY CUSTOMER_CD, ACCOUNT_DR_CR
                )   ;
                
               
            --2-2.��ȸ�Ⱓ �� �߻��� �ڷῡ ���� �����ڷ� ����
            INSERT INTO FI_CUSTOMER_LEDGER(
                  RET_SEQ           --��ȸ�Ϸù�ȣ
                , GL_DATE           --ȸ������
                , REMARKS           --����
                , DR_AMT            --����(�ݾ�)
                , CR_AMT            --�뺯(�ݾ�)
                , REMAIN_AMT        --�ܾ�
                , ACCOUNT_CODE      --�����ڵ�
                , ACCOUNT_DESC      --������
                , CUSTOMER_CD       --�ŷ�ó�ڵ�
                , CUSTOMER_NM       --�ŷ�ó��
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ    
            )
            SELECT
                  ROWNUM + 1 AS ROW_NUM    --��ȸ�Ϸù�ȣ
                  
                --�� ȸ�����ڿ� 1�ʾ��� �����ش�.
                --���� : ���� ȸ�����ڿ� ���� GROUP BY ROOLUP�� ����Ǹ� ������ �޶����� ������ �ذ��ϱ� �����̴�.
                , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --ȸ������
                
                , REMARKS       --����
                , DR_AMT     --����
                , CR_AMT     --�뺯
                , 0 REMAIN_AMT      --�ܾ�
                , W_ACCOUNT_CODE    --�����ڵ�
                , t_ACCOUNT_DESC    --������
                , W_CUSTOMER_CD     --�ŷ�ó�ڵ�
                , t_CUSTOMER_NM     --�ŷ�ó��                
                
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ            
            FROM(          
                    SELECT
                          GL_DATE       --ȸ������                          
                        , REMARKS       --����
                        , NVL(DECODE(ACCOUNT_DR_CR, '1', GL_AMOUNT, 0), 0) AS DR_AMT     --����
                        , NVL(DECODE(ACCOUNT_DR_CR, '2', GL_AMOUNT, 0), 0) AS CR_AMT     --�뺯
                        , SLIP_HEADER_ID    --��ǥ������̵�
                        , GL_NUM            --��ǥ��ȣ   
                    FROM FI_CUSTOMER_LEDGER_V
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND CUSTOMER_CD = W_CUSTOMER_CD --if block���� ����� �����ϰ� �ٸ��κ�
                        AND GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                        AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴѰ�
                    ORDER BY GL_DATE
                )   ;             
           
        END IF;    

        

        --3.�ܾ��� �����Ѵ�.
        FOR AMT_MODIFY IN (
            SELECT RET_SEQ, DR_AMT, CR_AMT, REMAIN_AMT
            FROM FI_CUSTOMER_LEDGER
            ORDER BY RET_SEQ        
        ) LOOP 
            
            UPDATE FI_CUSTOMER_LEDGER
            SET REMAIN_AMT = DECODE(t_ACCOUNT_DR_CR
                                    , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                                    , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            WHERE RET_SEQ = AMT_MODIFY.RET_SEQ    ;
            
            
            SELECT DECODE(t_ACCOUNT_DR_CR
                            , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                            , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            INTO t_REMAIN_AMT
            FROM DUAL;        
               
        END LOOP AMT_MODIFY; 



        --4. �����ڷ� ��ȸ
        
        OPEN P_CURSOR FOR
        
        SELECT
              '' BASE_MM        --ȸ����
            , GL_DATE           --ȸ������
            , REMARKS           --����
            , DR_AMT            --����(�ݾ�)
            , CR_AMT            --�뺯(�ݾ�)
            , REMAIN_AMT        --�ܾ�
            , ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , CUSTOMER_CD       --�ŷ�ó�ڵ�
            , CUSTOMER_NM       --�ŷ�ó��
            , SLIP_HEADER_ID    --��ǥ������̵�
            , GL_NUM            --��ǥ��ȣ
        FROM FI_CUSTOMER_LEDGER
        WHERE RET_SEQ = 1

        UNION ALL
        
        SELECT
              TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
            , GL_DATE
            , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ �� �� �� �� ]', DECODE(GROUPING(GL_DATE), 1, '[ ��    �� ]',  REMARKS)) AS REMARKS
            , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(DR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(DR_AMT),  DR_AMT)) AS DR_AMT
            , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(CR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(CR_AMT),  CR_AMT)) AS CR_AMT 
            , REMAIN_AMT
            , ACCOUNT_CODE
            , ACCOUNT_DESC
            , CUSTOMER_CD
            , CUSTOMER_NM
            , SLIP_HEADER_ID
            , GL_NUM        
        FROM FI_CUSTOMER_LEDGER
        WHERE RET_SEQ > 1    
        GROUP BY ROLLUP(TO_CHAR(GL_DATE, 'YYYY-MM'), (GL_DATE, REMARKS, DR_AMT, CR_AMT, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, CUSTOMER_CD, CUSTOMER_NM, SLIP_HEADER_ID, GL_NUM))
        ;         

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
           --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         

    END; 
    
END DET_CUSTOMER_LEDGER;






--��ȸ���ǿ��� ������ ��ȸ�� ������� �� �ڷᰡ �ִ� ������ �����ش�.
PROCEDURE LIST_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ACCOUNT_CONTROL.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_ACCOUNT_CONTROL.ORG_ID%TYPE
    , W_ACCOUNT_SET_ID  IN  FI_ACCOUNT_CONTROL.ACCOUNT_SET_ID%TYPE
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����      
    , W_ACCOUNT_FR      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_ACCOUNT_TO      IN  FI_ACCOUNT_CONTROL.ACCOUNT_CODE%TYPE
    , W_CUSTOMER_CD     IN  FI_CUSTOMER_LEDGER_V.CUSTOMER_CD%TYPE   --�ŷ�ó�ڵ�
)

AS

BEGIN


    --Ư���ŷ�ó�� �������� ���� ���
    IF NVL(W_CUSTOMER_CD, 'NONE') = 'NONE' THEN
        
        OPEN P_CURSOR FOR
           
        SELECT
              A.ACCOUNT_CODE  --�����ڵ�
            , B.ACCOUNT_DESC  --������
            , A.CNT           --�ڷ�Ǽ�    
            , DECODE(B.ACCOUNT_DR_CR, '1', '����', '2', '�뺯') AS ACCOUNT_DR_CR --��������
        FROM
            (
                SELECT 
                      ACCOUNT_CODE
                    , COUNT(*) CNT
                FROM FI_CUSTOMER_LEDGER_V
                WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                    AND ACCOUNT_CODE BETWEEN W_ACCOUNT_FR AND W_ACCOUNT_TO
                    --AND CUSTOMER_CD = NVL(W_CUSTOMER_CD, CUSTOMER_CD) ; �� �κи��� ELSE���� �ٸ���.
                GROUP BY ACCOUNT_CODE  
            ) A    
            , (
                SELECT ACCOUNT_CODE, ACCOUNT_DESC, ACCOUNT_DR_CR
                FROM FI_ACCOUNT_CONTROL A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND ACCOUNT_SET_ID = NVL(W_ACCOUNT_SET_ID, 10)
                    --AND ENABLED_FLAG = 'Y'
            ) B 
        WHERE A.ACCOUNT_CODE = B.ACCOUNT_CODE
        ORDER BY ACCOUNT_CODE   ;    
    
    ELSE    --Ư���ŷ�ó�� ������ ���
        
        OPEN P_CURSOR FOR
           
        SELECT
              A.ACCOUNT_CODE  --�����ڵ�
            , B.ACCOUNT_DESC  --������
            , A.CNT           --�ڷ�Ǽ�    
            , DECODE(B.ACCOUNT_DR_CR, '1', '����', '2', '�뺯') AS ACCOUNT_DR_CR --��������
        FROM
            (
                SELECT 
                      ACCOUNT_CODE
                    , COUNT(*) CNT
                FROM FI_CUSTOMER_LEDGER_V
                WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                    AND ACCOUNT_CODE BETWEEN W_ACCOUNT_FR AND W_ACCOUNT_TO
                    AND CUSTOMER_CD = W_CUSTOMER_CD --�� �κи��� IF���� �ٸ���.
                GROUP BY ACCOUNT_CODE  
            ) A    
            , (
                SELECT ACCOUNT_CODE, ACCOUNT_DESC, ACCOUNT_DR_CR
                FROM FI_ACCOUNT_CONTROL A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND ACCOUNT_SET_ID = NVL(W_ACCOUNT_SET_ID, 10)
                    --AND ENABLED_FLAG = 'Y'
            ) B 
        WHERE A.ACCOUNT_CODE = B.ACCOUNT_CODE
        ORDER BY ACCOUNT_CODE   ;    
    
    END IF;



END LIST_ACCOUNT;





END FI_CUSTOMER_LEDGER_G;
/
