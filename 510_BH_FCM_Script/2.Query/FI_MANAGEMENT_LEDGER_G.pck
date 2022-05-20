CREATE OR REPLACE PACKAGE FI_MANAGEMENT_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_MANAGEMENT_LEDGER_G
Description  : �����׸񺰿�����ȸ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����׸񺰿�����ȸ)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-14   Leem Dong Ern(�ӵ���)
*****************************************************************************/




--��� �հ賻�� ��ȸ
PROCEDURE UP_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR        IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE        IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --�����ڵ�
    
    --�Ʒ� 2 PARAMETER�� �����ڵ�(FI_COMMON)���� �����ϴ� ������ �ڷῡ ���� ���̴�.
    --�̷��� 2���� �� ������ �� PROCEDURE ������ �ڷ� ������ ���ϰ� �ϱ� ������ ���̴�.
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸���̵�
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2 --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.
    
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --������ �����׸� ���� Ư�� �ڵ尪
);





--�հ��ڷῡ ��ȸ�� �ڷ� �� �����׸� �ڵ忡 �ش��ϴ� �����׸�� ����
--����>ȭ�� �����׸� ���� POPUPâ���� ������ �׸� ���� ���� �ڷ� �����ϴ� LIST_MANAGEMENT_GUBUN PROCEDURE�� ������ �ƶ��̴�.
--�� PROCEDURE�� [�⸻�����̿��۾� : FI_FORWARD_AMT_G > UPD_MANAGEMENT_NM] ���α׷����� �� ���� �����ϰ� �̿��ϰ� �ִ�.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.
);






--�ϴ� �󼼳��� ��ȸ
PROCEDURE DET_MANAGEMENT_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --�����ڵ�   
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸���̵�
    , W_MANAGEMENT_CD   IN  FI_MANAGEMENT_LEDGER_SUM.MANAGEMENT_CD%TYPE   --�����׸�_�ڵ�
);



--�����׸� ���� ��ü���� ��ȸ
PROCEDURE ALL_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR        IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE_FR     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --�����ڵ�
    , W_ACCOUNT_CODE_TO     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --�����ڵ�
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸���̵�
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --������ �����׸� ���� Ư�� �ڵ尪
);



--�����׸� ����Ʈ
PROCEDURE LIST_MANAGEMENT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_COMMON.ORG_ID%TYPE
);





--ȭ�� �����׸� ���� POPUPâ���� ������ �׸� ���� ���� �ڷ� ����
--����>�հ��ڷῡ ��ȸ�� �ڷ� �� �����׸� �ڵ忡 �ش��ϴ� �����׸���� �����ϴ� UPD_MANAGEMENT_NM PROCEDURE�� ������ �ƶ��̴�.
PROCEDURE LIST_MANAGEMENT_GUBUN( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID              IN  FI_COMMON.ORG_ID%TYPE
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2
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
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸�_���̵�
    , W_MANAGEMENT_VAL  IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --������ �����׸� ���� Ư�� �ڵ尪
);





END FI_MANAGEMENT_LEDGER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_MANAGEMENT_LEDGER_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_MANAGEMENT_LEDGER_G
Description  : �����׸񺰿�����ȸ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����׸񺰿�����ȸ)
Program History :

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-14   Leem Dong Ern(�ӵ���)
*****************************************************************************/




--��� �հ賻�� ��ȸ
PROCEDURE UP_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR        IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE        IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --�����ڵ� 
    
    --�Ʒ� 2 PARAMETER�� �����ڵ�(FI_COMMON)���� �����ϴ� ������ �ڷῡ ���� ���̴�.
    --�̷��� 2���� �� ������ �� PROCEDURE ������ �ڷ� ������ ���ϰ� �ϱ� ������ ���̴�.
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸���̵�
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2 --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.
    
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --������ �����׸� ���� Ư�� �ڵ尪
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;  --���뱸��(1-����,2-�뺯)
t_ACCOUNT_DESC      FI_ACCOUNT_CONTROL.ACCOUNT_DESC%TYPE;   --������

t_FORWARD_AMT       FI_MANAGEMENT_LEDGER_SUM.FORWARD_AMT%TYPE;  --�̿��ݾ�
t_REMAIN_AMT        FI_MANAGEMENT_LEDGER_SUM.REMAIN_AMT%TYPE;   --�ܾ�

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
            


        --�����ڷḦ �����Ѵ�.
        DELETE FROM FI_MANAGEMENT_LEDGER_SUM;
        
        --�����ڷḦ �����Ѵ�.
        INSERT INTO FI_MANAGEMENT_LEDGER_SUM(
              ACCOUNT_CODE  --�����ڵ�
            , ACCOUNT_DESC  --������
            , ACCOUNT_DR_CR --(�ݾ�)���뱸��
            , MANAGEMENT_CD --�����׸�_�ڵ�
            , MANAGEMENT_NM --�����׸�_��
            , FORWARD_AMT   --�̿��ݾ�
            , INC_AMT       --�����ݾ�
            , DEC_AMT       --���ұݾ�
            , REMAIN_AMT    --�ܾ�   
        )    
        SELECT  
              W_ACCOUNT_CODE AS ACCOUNT_CODE    --�����ڵ�
            , t_ACCOUNT_DESC AS ACCOUNT_DESC    --������
            , t_ACCOUNT_DR_CR AS ACCOUNT_DR_CR  --���뱸��
            , MANAGEMENT_VAL AS MANAGEMENT_CD   --�����׸�_�ڵ�        
            , '' AS MANAGEMENT_NM               --�����׸�_��        
            , 0 AS FORWARD_AMT                  --�̿��ݾ�
            , NVL(INC_AMT, 0) AS INC_AMT        --����
            , NVL(DEC_AMT, 0) AS DEC_AMT        --����
            , 0 AS REMAIN_AMT --�ܾ�         
        FROM
            (
                SELECT 
                      A.MANAGEMENT_VAL --�����׸�_�ڵ�
                    
                    --�̿��ݾ� : ��ȸ���۳� 1�� 1�� ~ ��ȸ������ ���� ������ �ݾ� �հ�
                    , 0 FORWARD_AMT --�̿��ݾ�

                    , CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                        WHEN '1' THEN C.GL_AMOUNT --�����̸�
                        WHEN '2' THEN D.GL_AMOUNT --�뺯�̸�
                    END INC_AMT --����
                    
                    , CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                        WHEN '1' THEN D.GL_AMOUNT --�����̸�
                        WHEN '2' THEN C.GL_AMOUNT --�뺯�̸�
                    END DEC_AMT --����                
                FROM
                    (   --��ȸ�Ⱓ(�������� ��ȸ�������� ���� 1��1�����̴�.)�� ��ȸ ������ ���յǴ� �ڷḦ �����Ѵ�.
                        --��ȸ�������� 1�� 1�Ϸ� �ϴ� ������ ��ȸ�Ǵ� �ڷḦ �繫����ǥ�� ��ġ�ϱ� ���ؼ��̴�.
                        SELECT MANAGEMENT_VAL
                        FROM FI_MANAGEMENT_LEDGER_V
                        WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND MANAGEMENT_ID = W_MANAGEMENT_ID
                            AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
                        GROUP BY MANAGEMENT_VAL                    
                    ) A
                    
                    --QUERY���������>C, D ���̺��� 1���� ���̺�� ���� ���� �ִµ� �������� �谡�ϰ�,
                    --�� �ӵ��鿡���� ���̰� ���� ����ó�� 2���� ���̺�� �ߴ�.                
                    , ( --�����ݾ�
                        SELECT
                              MANAGEMENT_VAL
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_MANAGEMENT_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND MANAGEMENT_ID = W_MANAGEMENT_ID                 
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
                            AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴ� �ڷḸ
                            AND ACCOUNT_DR_CR = 1   --����
                        GROUP BY MANAGEMENT_VAL                                     
                        ) C
                    , ( --�뺯�ݾ�
                        SELECT
                              MANAGEMENT_VAL
                            , SUM(GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_MANAGEMENT_LEDGER_V
                        WHERE GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                            AND MANAGEMENT_ID = W_MANAGEMENT_ID
                            AND ACCOUNT_CODE = W_ACCOUNT_CODE
                            AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
                            AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴ� �ڷḸ
                            AND ACCOUNT_DR_CR = 2   --�뺯
                        GROUP BY MANAGEMENT_VAL
                        ) D       
                WHERE A.MANAGEMENT_VAL = C.MANAGEMENT_VAL(+) 
                    AND A.MANAGEMENT_VAL = D.MANAGEMENT_VAL(+) 
            ) T 
        ORDER BY MANAGEMENT_VAL ;

    EXCEPTION
        WHEN OTHERS THEN
            NULL;
            
           --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');                    
    END;




    --��ȸ�� �ڷῡ ���� [�����׸�_��]�� �����Ѵ�.

/*
    �Ʒ� 3���� ���а��� ȭ���� �����׸� ���ǿ��� POPUP�� ���� �� ���� ������ �� �ִ� �ڷ��̳�, ��ȣ �������� �� ���� �����ϴ� ó���� ���Ѵ�. 
    --, 'PAYABLE_BILL'    --���޾�����ȣ(35)            [TABLE : FI_PAYABLE_BILL]
    --, 'RECEIVABLE_BILL' --����������ȣ(21)            [TABLE : FI_BILL_MASTER, FI_BILL_STATUS_V]
    --, 'LC_NO'           --L/C��ȣ(32)                 [TABLE : FI_LC_MASTER, FI_BANK, FI_SUPP_CUST_V] 
*/

    IF W_MANAGEMENT_GUBUN IN (
              'BANK'            --�������(23)                [TABLE : FI_BANK]
            , 'CUSTOMER'        --�ŷ�ó(01)                  [TABLE : FI_SUPP_CUST_V]
            , 'BANK_ACCOUNT'    --���¹�ȣ(03)                [TABLE : FI_BANK_ACCOUNT]
            , 'CREDIT_CARD'     --����ī��, ī���ȣ(02, 26)  [TABLE : FI_CREDIT_CARD]
            , 'PERSON_NUM'      --���(11)                    [TABLE : HRM_PERSON_MASTER]
            , 'DEPT'            --�μ�(08)                    [TABLE : FI_DEPT_MASTER]
            , 'COSTCENTER'      --�����ڵ�(27)                [TABLE : CST_COST_CENTER]           
            
            , 'BILL_STATUS'             --����ó������(07)               [TABLE : FI_COMMON]
            , 'TAX_CODE'                --�����(10)                     [TABLE : FI_COMMON]
            , 'VAT_REASON'              --�ΰ�����ޱ�_��������(12)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AP'             --�ΰ�����ޱ�_��������(13)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AR'             --�ΰ���������_��������(33)      [TABLE : FI_COMMON]
            , 'SCHEDULE_REPORT_OMIT'    --�����Ű����п���(36)         [TABLE : FI_COMMON]
            , 'MODIFY_TAX_REASON'       --�������ڼ��ݰ�꼭��������(37) [TABLE : FI_COMMON]
            , 'OTHER_ACCOUNT_GB'        --Ÿ��������(38)                 [TABLE : FI_COMMON]
        ) THEN
        
        UPD_MANAGEMENT_NM(W_SOB_ID, W_ORG_ID, W_MANAGEMENT_GUBUN);
        
    ELSE
        NULL;
    END IF;



    --�̿��ݾװ� �ܾ��� ������ �� �����ڷḦ ��ȸ�Ѵ�. 
    OPEN P_CURSOR FOR

    SELECT  
          DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', T.ACCOUNT_CODE) AS ACCOUNT_CODE    --�����ڵ�
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', T.ACCOUNT_DESC) AS ACCOUNT_DESC    --������
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', DECODE(T.ACCOUNT_DR_CR, '1', '����', 2, '�뺯')) AS ACCOUNT_DR_CR   --���뱸��
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', T.MANAGEMENT_CD) AS MANAGEMENT_CD    --�����׸�_�ڵ�
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '', DECODE(T.MANAGEMENT_CD, 'NONE', '', T.MANAGEMENT_CD)) AS VIEW_MANAGEMENT_CD    --�����׸�_�ڵ�(ȭ�鿡 �������� ��)
        , DECODE(GROUPING(T.ACCOUNT_CODE), 1, '   [  ��   ��  ]', T.MANAGEMENT_NM) AS MANAGEMENT_NM  --�����׸�_��
        
        , SUM(NVL(B.FORWARD_AMT, 0)) AS FORWARD_AMT    --�̿��ݾ�
        , SUM(NVL(T.INC_AMT, 0)) AS INC_AMT            --����
        , SUM(NVL(T.DEC_AMT, 0)) AS DEC_AMT            --����
        , SUM(NVL(B.FORWARD_AMT, 0) + NVL(T.INC_AMT, 0) - NVL(T.DEC_AMT, 0)) AS REMAIN_AMT --�ܾ� 
    FROM FI_MANAGEMENT_LEDGER_SUM T
        , (  
            SELECT
                  A.ACCOUNT_CODE
                , A.MANAGEMENT_CD

                --�̿��ݾ� : ��ȸ���۳� 1�� 1�� ~ ��ȸ������ ���� ������ �ݾ� �հ�
                , C.FORWARD_AMT --�̿��ݾ�                
            FROM FI_MANAGEMENT_LEDGER_SUM A --��ȸ �ڷ��� ���� ���̺�
                , ( --���� �ڷ��� �ڵ忡 ���յǴ� �̿��ݾ� ���� ���̺�
                    SELECT
                        MANAGEMENT_VAL,
                        CASE t_ACCOUNT_DR_CR  --������ ������ ���뱸�� �Ӽ���
                            WHEN '1' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, -GL_AMOUNT))    --�����̸�
                            WHEN '2' THEN SUM(DECODE(ACCOUNT_DR_CR, 1, -GL_AMOUNT, GL_AMOUNT))    --�뺯�̸�
                        END FORWARD_AMT
                    FROM FI_MANAGEMENT_LEDGER_V 
                    WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                        AND MANAGEMENT_ID = W_MANAGEMENT_ID
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
                    GROUP BY MANAGEMENT_VAL    
                ) C
            WHERE A.MANAGEMENT_CD  = C.MANAGEMENT_VAL(+)            
        ) B
    WHERE T.MANAGEMENT_CD = B.MANAGEMENT_CD
    GROUP BY ROLLUP( ( T.ACCOUNT_CODE, T.ACCOUNT_DESC, T.ACCOUNT_DR_CR, T.MANAGEMENT_CD, T.MANAGEMENT_NM, B.FORWARD_AMT, T.INC_AMT, T.DEC_AMT) )
    ORDER BY MANAGEMENT_CD
    ;


END UP_MANAGEMENT_LEDGER;






--�հ��ڷῡ ��ȸ�� �ڷ� �� �����׸� �ڵ忡 �ش��ϴ� �����׸�� ����
--����>ȭ�� �����׸� ���� POPUPâ���� ������ �׸� ���� ���� �ڷ� �����ϴ� LIST_MANAGEMENT_GUBUN PROCEDURE�� ������ �ƶ��̴�.
--�� PROCEDURE�� [�⸻�����̿��۾� : FI_FORWARD_AMT_G > UPD_MANAGEMENT_NM] ���α׷����� �� ���� �����ϰ� �̿��ϰ� �ִ�.
PROCEDURE UPD_MANAGEMENT_NM(
      W_SOB_ID              IN  NUMBER      --ȸ����̵�
    , W_ORG_ID              IN  NUMBER      --����ξ��̵�
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2    --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.
)

AS

BEGIN
   

--���� ���ν��� : FI_ACCOUNT_CONTROL_G > LU_CONTROL_ITEM / LU_MANAGEMENT_ITEM
--�� 2 ���ν����� ������ �����ε�, �ĸ����͸� �ٸ����̴�.

    IF W_MANAGEMENT_GUBUN = 'BANK' THEN                 --�������(23)   [TABLE : FI_BANK]
    
        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT BANK_NAME
                                FROM FI_BANK
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND BANK_GROUP != '-' 
                                    AND BANK_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
        
    ELSIF W_MANAGEMENT_GUBUN = 'CUSTOMER' THEN          --�ŷ�ó(01)   [TABLE : FI_SUPP_CUST_V]

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT SUPP_CUST_NAME
                                FROM FI_SUPP_CUST_V
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND SUPP_CUST_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
    
    ELSIF W_MANAGEMENT_GUBUN = 'BANK_ACCOUNT' THEN      --���¹�ȣ(03)  [TABLE : FI_BANK_ACCOUNT]

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT BANK_ACCOUNT_NAME    --BANK_ACCOUNT_NUM || '[' || BANK_ACCOUNT_NAME || ']'
                                FROM FI_BANK_ACCOUNT
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND BANK_ACCOUNT_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
       
    ELSIF W_MANAGEMENT_GUBUN = 'PAYABLE_BILL' THEN      --���޾�����ȣ(35)    [TABLE : FI_PAYABLE_BILL]

        NULL;   --�ڷᵵ ����, ���� ����Ȯ�Ͽ� ó�����Ѵ�.
    
    ELSIF W_MANAGEMENT_GUBUN = 'RECEIVABLE_BILL' THEN   --����������ȣ(21)    [TABLE : FI_BILL_MASTER, FI_BILL_STATUS_V]
    
        NULL;   --POPUP���� ó���ϴ� �ɷ� �Ǿ������� �ǻ��� ��ǥ��� �� ���� KEY-IN�Ѵ�.
    
    ELSIF W_MANAGEMENT_GUBUN = 'CREDIT_CARD' THEN       --����ī��, ī���ȣ(02, 26)  [TABLE : FI_CREDIT_CARD]

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT CARD_NUM
                                FROM FI_CREDIT_CARD
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND CARD_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;

    ELSIF W_MANAGEMENT_GUBUN = 'PERSON_NUM' THEN        --���(11)    [TABLE : HRM_PERSON_MASTER]
    
        UPDATE FI_MANAGEMENT_LEDGER_SUM T
        SET MANAGEMENT_NM = (
                SELECT NAME
                FROM HRM_PERSON_MASTER A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND CORP_TYPE = '1'
                    AND PERSON_NUM = T.MANAGEMENT_CD
                    AND EXISTS (  SELECT 'X'
                                  FROM HRM_CORP_MASTER
                                  WHERE SOB_ID       = A.SOB_ID
                                    AND ORG_ID       = A.ORG_ID
                                    AND CORP_ID      = A.CORP_ID
                                    AND DEFAULT_FLAG = 'Y'
                             )
                )
        WHERE MANAGEMENT_CD != 'NONE'   ;
        
    ELSIF W_MANAGEMENT_GUBUN = 'DEPT' THEN              --�μ�(08)    [TABLE : FI_DEPT_MASTER]        

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT DEPT_NAME
                                FROM FI_DEPT_MASTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND DEPT_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;

    ELSIF W_MANAGEMENT_GUBUN = 'COSTCENTER' THEN        --�����ڵ�(27)  [TABLE : CST_COST_CENTER]        

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT COST_CENTER_DESC
                                FROM CST_COST_CENTER
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND COST_CENTER_CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;      

    ELSIF W_MANAGEMENT_GUBUN = 'LC_NO' THEN             --L/C��ȣ(32) [TABLE : FI_LC_MASTER]
    
        NULL;   --L/C��ȣ ��ü�� �ǹ��ִ� �ڷ��� �� �̻��� ������ �ʿ���� �Ǵ��ߴ�.
    
    ELSE
        /*
            , 'BILL_STATUS'             --����ó������(07)               [TABLE : FI_COMMON]
            , 'TAX_CODE'                --�����(10)                     [TABLE : FI_COMMON]
            , 'VAT_REASON'              --�ΰ�����ޱ�_��������(12)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AP'             --�ΰ�����ޱ�_��������(13)      [TABLE : FI_COMMON]
            , 'VAT_TYPE_AR'             --�ΰ���������_��������(33)      [TABLE : FI_COMMON]
            , 'SCHEDULE_REPORT_OMIT'    --�����Ű����п���(36)         [TABLE : FI_COMMON]
            , 'MODIFY_TAX_REASON'       --�������ڼ��ݰ�꼭��������(37) [TABLE : FI_COMMON]
            , 'OTHER_ACCOUNT_GB'        --Ÿ��������(38)                 [TABLE : FI_COMMON]
        */

        UPDATE FI_MANAGEMENT_LEDGER_SUM A
        SET MANAGEMENT_NM = (
                                SELECT CODE_NAME
                                FROM FI_COMMON
                                WHERE SOB_ID = W_SOB_ID
                                    AND ORG_ID = W_ORG_ID
                                    AND GROUP_CODE = W_MANAGEMENT_GUBUN
                                    AND CODE = A.MANAGEMENT_CD
                            )
        WHERE MANAGEMENT_CD != 'NONE'   ;
           
    END IF;
    
END UPD_MANAGEMENT_NM;









--�ϴ� �󼼳��� ��ȸ
PROCEDURE DET_MANAGEMENT_LEDGER(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  NUMBER  --ȸ����̵�
    , W_ORG_ID          IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR    IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO    IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE    IN  FI_CUSTOMER_LEDGER_V.ACCOUNT_CODE%TYPE  --�����ڵ�   
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸���̵�
    , W_MANAGEMENT_CD   IN  FI_MANAGEMENT_LEDGER_SUM.MANAGEMENT_CD%TYPE   --�����׸�_�ڵ�
)

AS

t_ACCOUNT_DR_CR     FI_ACCOUNT_CONTROL.ACCOUNT_DR_CR%TYPE;      --���뱸��(1-����,2-�뺯)
t_ACCOUNT_DESC      FI_CUSTOMER_LEDGER.ACCOUNT_DESC%TYPE;       --������
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
            , SLIP_LINE_ID      --��ǥ����ID
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
            , NULL  --�ŷ�ó�ڵ�
            , NULL  --�ŷ�ó��
            , NULL  --��ǥ������̵�
            , NULL  --��ǥ��ȣ 
            , NULL  --��ǥ����ID
        FROM
            (
                SELECT ACCOUNT_DR_CR, SUM(GL_AMOUNT) AS GL_AMOUNT
                FROM FI_MANAGEMENT_LEDGER_V
                WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                    AND MANAGEMENT_ID = W_MANAGEMENT_ID
                    AND MANAGEMENT_VAL = W_MANAGEMENT_CD
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
                GROUP BY MANAGEMENT_ID, ACCOUNT_DR_CR
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
            , SLIP_LINE_ID      --��ǥ����ID
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
            , NULL     --�ŷ�ó�ڵ�
            , NULL     --�ŷ�ó��
            , SLIP_HEADER_ID    --��ǥ������̵�            
            , GL_NUM            --��ǥ��ȣ
            , SLIP_LINE_ID      --��ǥ����ID                
        FROM
        (
            SELECT
                  GL_DATE       --ȸ������
                , REMARKS       --����
                , NVL(DECODE(ACCOUNT_DR_CR, '1', GL_AMOUNT, 0), 0) AS DR_AMT     --����
                , NVL(DECODE(ACCOUNT_DR_CR, '2', GL_AMOUNT, 0), 0) AS CR_AMT     --�뺯
                , SLIP_HEADER_ID    --��ǥ������̵�
                , GL_NUM            --��ǥ��ȣ
                , SLIP_LINE_ID      --��ǥ����ID
            FROM FI_MANAGEMENT_LEDGER_V
            WHERE ACCOUNT_CODE = W_ACCOUNT_CODE
                AND MANAGEMENT_ID = W_MANAGEMENT_ID
                AND MANAGEMENT_VAL = W_MANAGEMENT_CD
                AND GL_DATE BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
                AND SLIP_TYPE != 'BLS'  --��ǥ������ '�����ܾ�'�� �ƴѰ�
            ORDER BY GL_DATE    
        )   ;                   



    EXCEPTION
        WHEN OTHERS THEN
            NULL;
           --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         

    END; 




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



    --��� �ڷῡ �ŷ�ó�ڷᰡ �ִٸ� �ŷ�ó�ڵ带 �����Ѵ�.
    UPDATE FI_CUSTOMER_LEDGER T
    SET CUSTOMER_CD = 
        (
            SELECT A.CUSTOMER_CD
            FROM FI_CUSTOMER_LEDGER_V A
                , (
                    SELECT RET_SEQ, SLIP_LINE_ID, ACCOUNT_CODE
                    FROM FI_CUSTOMER_LEDGER
                    WHERE SLIP_LINE_ID IS NOT NULL
                ) B
            WHERE A.SLIP_LINE_ID = B.SLIP_LINE_ID
                AND A.ACCOUNT_CODE = B.ACCOUNT_CODE
                AND B.RET_SEQ = T.RET_SEQ    
        )
    WHERE GL_NUM IS NOT NULL    ;



    --5. �����ڷ� ��ȸ
    
    OPEN P_CURSOR FOR

    SELECT
          '' BASE_MM        --ȸ����
        , GL_DATE           --ȸ������
        , REMARKS           --����
        , CUSTOMER_CD       --�ŷ�ó�ڵ�
        , CUSTOMER_NM       --�ŷ�ó��            
        , DR_AMT            --����(�ݾ�)
        , CR_AMT            --�뺯(�ݾ�)
        , REMAIN_AMT        --�ܾ�
        , ACCOUNT_CODE      --�����ڵ�
        , ACCOUNT_DESC      --������
        , SLIP_HEADER_ID    --��ǥ������̵�
        , GL_NUM            --��ǥ��ȣ
        , SLIP_LINE_ID      --��ǥ���ξ��̵�
    FROM FI_CUSTOMER_LEDGER
    WHERE RET_SEQ = 1

    UNION ALL
    
    SELECT
          TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
        , GL_DATE
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ �� �� �� �� ]', DECODE(GROUPING(GL_DATE), 1, '[ ��    �� ]',  REMARKS)) AS REMARKS
        , CUSTOMER_CD
        , B.SUPP_CUST_NAME AS CUSTOMER_NM            
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(DR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(DR_AMT),  DR_AMT)) AS DR_AMT
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, SUM(CR_AMT), DECODE(GROUPING(GL_DATE), 1, SUM(CR_AMT),  CR_AMT)) AS CR_AMT 
        , REMAIN_AMT
        , ACCOUNT_CODE
        , ACCOUNT_DESC
        , SLIP_HEADER_ID
        , GL_NUM
        , SLIP_LINE_ID
    FROM FI_CUSTOMER_LEDGER A
        , FI_SUPP_CUST_V B  --��� �ڷῡ �ŷ�ó�ڷᰡ �ִٸ� �ŷ�ó���� ��ȸ�����ֱ� �����̴�.
    WHERE RET_SEQ > 1
        AND A.CUSTOMER_CD = B.SUPP_CUST_CODE(+)
    GROUP BY ROLLUP(TO_CHAR(GL_DATE, 'YYYY-MM'), (GL_DATE, REMARKS, DR_AMT, CR_AMT, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, CUSTOMER_CD, B.SUPP_CUST_NAME, SLIP_HEADER_ID, GL_NUM, SLIP_LINE_ID))
    ;

    
END DET_MANAGEMENT_LEDGER;


--�����׸� ���� ��ü���� ��ȸ
PROCEDURE ALL_MANAGEMENT_LEDGER(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  NUMBER  --ȸ����̵�
    , W_ORG_ID              IN  NUMBER  --����ξ��̵�
    , W_DEAL_DATE_FR        IN  DATE    --��ȸ�Ⱓ_����
    , W_DEAL_DATE_TO        IN  DATE    --��ȸ�Ⱓ_����    
    , W_ACCOUNT_CODE_FR     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --�����ڵ�
    , W_ACCOUNT_CODE_TO     IN  FI_MANAGEMENT_LEDGER_V.ACCOUNT_CODE%TYPE    --�����ڵ�
    , W_MANAGEMENT_ID       IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸���̵�
    , W_MANAGEMENT_VAL      IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --������ �����׸� ���� Ư�� �ڵ尪
)
AS
  t_REMAIN_AMT  NUMBER := 0;
  t_LOOKUP_TYPE VARCHAR2(50);
  v_USER_ID     NUMBER := GET_USER_ID_F;
BEGIN
  
    -- 2-0. �����ڷ� ����.
    DELETE FROM FI_MANAGEMENT_LEDGER_DETAIL 
    WHERE USER_ID    = v_USER_ID;
    
    -- LOOKUP TYPE.
    BEGIN
      SELECT MC.LOOKUP_TYPE
        INTO t_LOOKUP_TYPE
        FROM FI_MANAGEMENT_CODE_V MC
      WHERE MC.MANAGEMENT_ID      = W_MANAGEMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      t_LOOKUP_TYPE := NULL;
    END;
    
    FOR C1 IN ( SELECT ROWNUM * 10000 AS ROW_NUM
                     , AC.ACCOUNT_CONTROL_ID
                     , AC.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AC.ACCOUNT_DR_CR
                     , AC.SOB_ID
                  FROM FI_ACCOUNT_CONTROL AC
                WHERE AC.ACCOUNT_CODE     BETWEEN W_ACCOUNT_CODE_FR AND W_ACCOUNT_CODE_TO
                  AND AC.SOB_ID           = W_SOB_ID
                  AND AC.ENABLED_FLAG     = 'Y'
              )
    LOOP
        --2-1.�̿��ݾ� �����ڷ� ����
        MERGE INTO FI_MANAGEMENT_LEDGER_DETAIL MLD
        USING ( SELECT
                      1 AS RET_SEQ              --��ȸ�Ϸù�ȣ;
                    , W_DEAL_DATE_FR AS GL_DATE --ȸ������;
                    , '[�̿��ݾ�]' AS REMARKS   --����;
                    , NVL(SUM(DECODE(ACCOUNT_DR_CR, 1, GL_AMOUNT, 0)), 0) AS DR_AMT   --����;
                    , NVL(SUM(DECODE(ACCOUNT_DR_CR, 2, GL_AMOUNT, 0)), 0) AS CR_AMT   --�뺯;
                    , 0 AS REMAIN_AMT           --�ܾ�;
                    , v_USER_ID AS USER_ID      -- ������ ID;
                FROM
                    (
                        SELECT ML.ACCOUNT_DR_CR, SUM(ML.GL_AMOUNT) AS GL_AMOUNT
                        FROM FI_MANAGEMENT_LEDGER_V ML
                        WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
                            AND ML.MANAGEMENT_ID    = W_MANAGEMENT_ID
                            AND ((W_MANAGEMENT_VAL  IS NULL AND 1 = 1)
                            OR   (W_MANAGEMENT_VAL  IS NOT NULL AND ML.MANAGEMENT_VAL = W_MANAGEMENT_VAL))
                            AND ML.GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') 
                                           AND --�̿��ݾ� ��ȸ �������ڴ� 
                                              CASE 
                                                  --��ȸ�Ⱓ�� �������� 1��1���̸� �ش���� 1�� 1��
                                                  WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM')
                                                  ELSE W_DEAL_DATE_FR - 1    --�ƴϸ� �������� ����
                                              END
                            AND ML.SLIP_TYPE = --��ǥ������
                                              CASE 
                                                  WHEN TO_CHAR(W_DEAL_DATE_FR, 'MM-DD') = '01-01' THEN 'BLS' --��ȸ�Ⱓ�� �������� 1��1���̸� '�����ܾ�'��
                                                  ELSE SLIP_TYPE   --��� ��ǥ����
                                              END
                        GROUP BY MANAGEMENT_ID, ACCOUNT_DR_CR
                    )
              ) SX1
        ON    ( MLD.RET_SEQ        = SX1.RET_SEQ
           AND  MLD.GL_DATE        = SX1.GL_DATE
           AND  MLD.USER_ID        = SX1.USER_ID 
              )
        WHEN MATCHED THEN
          UPDATE 
            SET MLD.DR_AMT         = NVL(MLD.DR_AMT, 0) + NVL(SX1.DR_AMT, 0)
              , MLD.CR_AMT         = NVL(MLD.CR_AMT, 0) + NVL(SX1.CR_AMT, 0)
              , MLD.REMAIN_AMT     = NVL(MLD.REMAIN_AMT, 0) + NVL(SX1.REMAIN_AMT, 0)
        WHEN NOT MATCHED THEN
          INSERT
          ( RET_SEQ           --��ȸ�Ϸù�ȣ,
          , GL_DATE           --ȸ������,
          , REMARKS           --����,
          , DR_AMT            --����(�ݾ�),
          , CR_AMT            --�뺯(�ݾ�),
          , REMAIN_AMT        --�ܾ�,
          , ACCOUNT_CODE      --�����ڵ�,
          , ACCOUNT_DESC      --������,
          , MANAGEMENT_CD     --�����׸��ڵ�,
          , MANAGEMENT_NM     --�����׸��,
          , SLIP_HEADER_ID    --��ǥ������̵�,
          , GL_NUM            --��ǥ��ȣ,
          , SLIP_LINE_ID      --��ǥ����ID,
          , USER_ID
        ) VALUES
        ( SX1.RET_SEQ         -- ��ȸ�Ϸù�ȣ.
        , SX1.GL_DATE         -- ȸ������.
        , SX1.REMARKS         -- ����.
        , NVL(SX1.DR_AMT, 0)  -- �����ݾ�.
        , NVL(SX1.CR_AMT, 0)  -- �뺯�ݾ�.
        , NVL(SX1.REMAIN_AMT, 0) -- �ܾ�.
        , NULL                -- �����ڵ�.
        , NULL                -- ������.
        , NULL                -- �����׸��ڵ�.
        , NULL                -- �����׸��.
        , NULL                -- ��ǥ������̵�.
        , NULL                -- ��ǥ��ȣ.
        , NULL                -- ��ǥ����ID.
        , SX1.USER_ID         -- USER ID 
        )
        ;
                
        --2-2.��ȸ�Ⱓ �� �߻��� �ڷῡ ���� �����ڷ� ����
        INSERT /*+ NOLOGGING*/ INTO FI_MANAGEMENT_LEDGER_DETAIL(
              RET_SEQ           --��ȸ�Ϸù�ȣ
            , GL_DATE           --ȸ������
            , REMARKS           --����
            , DR_AMT            --����(�ݾ�)
            , CR_AMT            --�뺯(�ݾ�)
            , REMAIN_AMT        --�ܾ�
            , ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , MANAGEMENT_CD     --�ŷ�ó�ڵ�
            , MANAGEMENT_NM     --�ŷ�ó��
            , SLIP_HEADER_ID    --��ǥ������̵�
            , GL_NUM            --��ǥ��ȣ
            , SLIP_LINE_ID      --��ǥ����ID
            , USER_ID
        )
        SELECT
              C1.ROW_NUM + ROWNUM AS ROW_NUM    --��ȸ�Ϸù�ȣ.
            --�� ȸ�����ڿ� 1�ʾ��� �����ش�.
            --���� : ���� ȸ�����ڿ� ���� GROUP BY ROOLUP�� ����Ǹ� ������ �޶����� ������ �ذ��ϱ� �����̴�.
            , GL_DATE + (ROWNUM + 1) / 24 / 60 / 60 AS GL_DATE       --ȸ������ .
            , REMARKS           --����.
            , DR_AMT            --����.
            , CR_AMT            --�뺯.
            , 0 REMAIN_AMT      --�ܾ�.
            , ACCOUNT_CODE      --�����ڵ�.
            , ACCOUNT_DESC      --������.
            , MANAGEMENT_VAL    --�����׸��ڵ�.
            , NULL              --�ŷ�ó��.
            , SLIP_HEADER_ID    --��ǥ������̵�.
            , GL_NUM            --��ǥ��ȣ.
            , SLIP_LINE_ID      --��ǥ����ID.
            , v_USER_ID         -- USER ID. 
        FROM
        (
            SELECT
                  ML.GL_DATE       --ȸ������
                , ML.REMARKS       --����
                , NVL(DECODE(ML.ACCOUNT_DR_CR, '1', ML.GL_AMOUNT, 0), 0) AS DR_AMT     --����
                , NVL(DECODE(ML.ACCOUNT_DR_CR, '2', ML.GL_AMOUNT, 0), 0) AS CR_AMT     --�뺯
                , C1.ACCOUNT_CODE
                , C1.ACCOUNT_DESC
                , ML.MANAGEMENT_VAL
                , ML.SLIP_HEADER_ID    --��ǥ������̵�
                , ML.GL_NUM            --��ǥ��ȣ
                , ML.SLIP_LINE_ID      --��ǥ����ID
            FROM FI_MANAGEMENT_LEDGER_V ML
            WHERE ML.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
              AND ML.MANAGEMENT_ID      = W_MANAGEMENT_ID
              AND ((W_MANAGEMENT_VAL    IS NULL AND 1 = 1)
              OR   (W_MANAGEMENT_VAL    IS NOT NULL AND ML.MANAGEMENT_VAL = W_MANAGEMENT_VAL))
              AND ML.GL_DATE            BETWEEN W_DEAL_DATE_FR AND W_DEAL_DATE_TO
              AND ML.BLS_FLAG           = 'N' --��ǥ������ '�����ܾ�'�� �ƴѰ�
            ORDER BY ML.GL_DATE
        )   ;                   

        --3.�ܾ��� �����Ѵ�.
        t_REMAIN_AMT := 0;
        FOR AMT_MODIFY IN (
            SELECT MLD.RET_SEQ, C1.ACCOUNT_DR_CR, MLD.DR_AMT, MLD.CR_AMT, MLD.REMAIN_AMT
              FROM FI_MANAGEMENT_LEDGER_DETAIL MLD
            WHERE MLD.USER_ID           = v_USER_ID
            ORDER BY RET_SEQ
        ) LOOP 
            
            UPDATE FI_MANAGEMENT_LEDGER_DETAIL ML
            SET ML.REMAIN_AMT = DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                                    , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                                    , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            WHERE ML.RET_SEQ = AMT_MODIFY.RET_SEQ    
              AND ML.USER_ID = v_USER_ID;
            
            
            SELECT DECODE(AMT_MODIFY.ACCOUNT_DR_CR
                            , '1', t_REMAIN_AMT + AMT_MODIFY.DR_AMT - AMT_MODIFY.CR_AMT
                            , '2', t_REMAIN_AMT + AMT_MODIFY.CR_AMT - AMT_MODIFY.DR_AMT)
            INTO t_REMAIN_AMT
            FROM DUAL;        
               
        END LOOP AMT_MODIFY; 

        --��� �ڷῡ �ŷ�ó�ڷᰡ �ִٸ� �ŷ�ó�ڵ带 �����Ѵ�.
        UPDATE FI_MANAGEMENT_LEDGER_DETAIL T
        SET T.MANAGEMENT_NM = FI_ACCOUNT_CONTROL_G.ITEM_DESC_F(t_LOOKUP_TYPE, T.MANAGEMENT_CD, 10)
        WHERE GL_NUM          IS NOT NULL
          AND T.USER_ID       = v_USER_ID;
    END LOOP C1;
    
    OPEN P_CURSOR FOR
    SELECT
          TO_CHAR(GL_DATE, 'YYYY-MM') AS BASE_MM
        , CASE
            WHEN RET_SEQ = 1 THEN NULL
            ELSE GL_DATE
          END AS GL_DATE
        , DECODE(GROUPING(TO_CHAR(GL_DATE, 'YYYY-MM')), 1, '[ �� �� �� �� ]', DECODE(GROUPING(GL_DATE), 1, '[ ��    �� ]',  REMARKS)) AS REMARKS
        , MANAGEMENT_CD
        , MANAGEMENT_NM
        , SUM(DR_AMT) AS DR_AMT
        , SUM(CR_AMT) AS CR_AMT
        , REMAIN_AMT AS REMAIN_AMT
        , ACCOUNT_CODE
        , ACCOUNT_DESC
        , SLIP_HEADER_ID
        , GL_NUM
        , SLIP_LINE_ID
    FROM FI_MANAGEMENT_LEDGER_DETAIL ML
    WHERE ML.USER_ID          = v_USER_ID
    GROUP BY ROLLUP((TO_CHAR(GL_DATE, 'YYYY-MM')), 
          (GL_DATE, REMARKS, REMAIN_AMT, ACCOUNT_CODE, ACCOUNT_DESC, MANAGEMENT_CD, MANAGEMENT_NM, SLIP_HEADER_ID, GL_NUM, SLIP_LINE_ID, RET_SEQ))
    ;
END ALL_MANAGEMENT_LEDGER;



--�����׸� ����Ʈ
PROCEDURE LIST_MANAGEMENT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID          IN  FI_COMMON.ORG_ID%TYPE
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT 
          CODE_NAME --�����׸��
        , CODE      --�ڵ�
        , COMMON_ID --���̵�
        , VALUE3 AS MANAGEMENT_GUBUN    --�� �׸� �ִ� ���� �̿��Ͽ� [�����׸�_��]�� ���Ѵ�.        
    FROM FI_COMMON
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND GROUP_CODE = 'MANAGEMENT_CODE'
        AND ENABLED_FLAG = 'Y'
    ORDER BY CODE   ;

END LIST_MANAGEMENT;








--ȭ�� �����׸� ���� POPUPâ���� ������ �׸� ���� ���� �ڷ� ����
--����>�հ��ڷῡ ��ȸ�� �ڷ� �� �����׸� �ڵ忡 �ش��ϴ� �����׸���� �����ϴ� UPD_MANAGEMENT_NM PROCEDURE�� ������ �ƶ��̴�.
PROCEDURE LIST_MANAGEMENT_GUBUN( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_COMMON.SOB_ID%TYPE
    , W_ORG_ID              IN  FI_COMMON.ORG_ID%TYPE
    , W_MANAGEMENT_GUBUN    IN  VARCHAR2
)

AS

BEGIN    

    IF W_MANAGEMENT_GUBUN = 'BANK' THEN                 --�������(23)   [TABLE : FI_BANK]
    
        OPEN P_CURSOR FOR
        
        SELECT BANK_CODE AS CODE
            , BANK_NAME AS NAME
        FROM FI_BANK
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND BANK_GROUP != '-' 
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        
        
    ELSIF W_MANAGEMENT_GUBUN = 'CUSTOMER' THEN          --�ŷ�ó(01)   [TABLE : FI_SUPP_CUST_V]
    
        OPEN P_CURSOR FOR
        
        SELECT SUPP_CUST_CODE AS CODE
            , SUPP_CUST_NAME AS NAME
        FROM FI_SUPP_CUST_V
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        

    ELSIF W_MANAGEMENT_GUBUN = 'BANK_ACCOUNT' THEN      --���¹�ȣ(03)  [TABLE : FI_BANK_ACCOUNT]
    
        OPEN P_CURSOR FOR
        
        SELECT BANK_ACCOUNT_CODE AS CODE
            , BANK_ACCOUNT_NUM AS NAME
        FROM FI_BANK_ACCOUNT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        
       
    ELSIF W_MANAGEMENT_GUBUN = 'CREDIT_CARD' THEN       --����ī��, ī���ȣ(02, 26)  [TABLE : FI_CREDIT_CARD]
    
        OPEN P_CURSOR FOR

        SELECT CARD_CODE AS CODE
            , CARD_NUM AS NAME
        FROM FI_CREDIT_CARD
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        

    ELSIF W_MANAGEMENT_GUBUN = 'PERSON_NUM' THEN        --���(11)    [TABLE : HRM_PERSON_MASTER]
    
        OPEN P_CURSOR FOR

        SELECT PERSON_NUM AS CODE
            , NAME AS NAME
        FROM HRM_PERSON_MASTER A
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND CORP_TYPE = '1'
            AND EXISTS (  SELECT 'X'
                          FROM HRM_CORP_MASTER
                          WHERE SOB_ID       = A.SOB_ID
                            AND ORG_ID       = A.ORG_ID
                            AND CORP_ID      = A.CORP_ID
                            AND DEFAULT_FLAG = 'Y'
                        )
        ORDER BY CODE   ;                    
        
    ELSIF W_MANAGEMENT_GUBUN = 'DEPT' THEN              --�μ�(08)    [TABLE : FI_DEPT_MASTER]  
    
        OPEN P_CURSOR FOR

        SELECT DEPT_CODE AS CODE
            , DEPT_NAME AS NAME
        FROM FI_DEPT_MASTER
        WHERE SOB_ID = W_SOB_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;        

    ELSIF W_MANAGEMENT_GUBUN = 'COSTCENTER' THEN        --�����ڵ�(27)  [TABLE : CST_COST_CENTER] 
    
        OPEN P_CURSOR FOR

        SELECT COST_CENTER_CODE AS CODE
            , COST_CENTER_DESC AS NAME
        FROM CST_COST_CENTER
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;
        
    ELSIF W_MANAGEMENT_GUBUN = 'LC_NO' THEN             --L/C��ȣ(32) [TABLE : FI_LC_MASTER]
        
        OPEN P_CURSOR FOR
        
        SELECT LM.LC_NUM AS CODE
            , FB.BANK_NAME ||  DECODE(SC.SUPP_CUST_NAME, NULL, '', '(' || SC.SUPP_CUST_NAME || ')') AS NAME 
        FROM FI_LC_MASTER LM
            , FI_BANK FB
            , FI_SUPP_CUST_V SC
        WHERE LM.SOB_ID = W_SOB_ID
            AND LM.ORG_ID = W_ORG_ID
            AND LM.BANK_ID = FB.BANK_ID
            AND LM.SUPPLIER_ID = SC.SUPP_CUST_ID(+)
        ORDER BY CODE   ;        
            
    ELSIF W_MANAGEMENT_GUBUN IN (
                  'BILL_STATUS'             --����ó������(07)               [TABLE : FI_COMMON]
                , 'TAX_CODE'                --�����(10)                     [TABLE : FI_COMMON]
                , 'VAT_REASON'              --�ΰ�����ޱ�_��������(12)      [TABLE : FI_COMMON]
                , 'VAT_TYPE_AP'             --�ΰ�����ޱ�_��������(13)      [TABLE : FI_COMMON]
                , 'VAT_TYPE_AR'             --�ΰ���������_��������(33)      [TABLE : FI_COMMON]
                , 'SCHEDULE_REPORT_OMIT'    --�����Ű����п���(36)         [TABLE : FI_COMMON]
                , 'MODIFY_TAX_REASON'       --�������ڼ��ݰ�꼭��������(37) [TABLE : FI_COMMON]
                , 'OTHER_ACCOUNT_GB'        --Ÿ��������(38)                 [TABLE : FI_COMMON]
            )  THEN
    
        OPEN P_CURSOR FOR

        SELECT CODE AS CODE
            , CODE_NAME AS NAME
        FROM FI_COMMON
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND GROUP_CODE = W_MANAGEMENT_GUBUN
            AND ENABLED_FLAG = 'Y'
        ORDER BY CODE   ;
        
    ELSE
    
        OPEN P_CURSOR FOR

        SELECT '' AS CODE
            , '' AS NAME
        FROM DUAL    ;
           
    END IF;

END LIST_MANAGEMENT_GUBUN;









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
    , W_MANAGEMENT_ID   IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_ID%TYPE   --�����׸�_���̵�
    , W_MANAGEMENT_VAL  IN  FI_MANAGEMENT_LEDGER_V.MANAGEMENT_VAL%TYPE  --������ �����׸� ���� Ư�� �ڵ尪
)

AS

BEGIN

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
            FROM FI_MANAGEMENT_LEDGER_V
            WHERE GL_DATE BETWEEN TO_DATE(TO_CHAR(W_DEAL_DATE_FR, 'YYYY') || '01', 'YYYY-MM') AND W_DEAL_DATE_TO
                AND ACCOUNT_CODE BETWEEN W_ACCOUNT_FR AND W_ACCOUNT_TO
                AND MANAGEMENT_ID = W_MANAGEMENT_ID
                AND MANAGEMENT_VAL = NVL(W_MANAGEMENT_VAL, MANAGEMENT_VAL)
            GROUP BY ACCOUNT_CODE  
        ) A    
        , (
            SELECT ACCOUNT_CODE, ACCOUNT_DESC, ACCOUNT_DR_CR
            FROM FI_ACCOUNT_CONTROL A
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND ACCOUNT_SET_ID = NVL(W_ACCOUNT_SET_ID, 10)
                AND ENABLED_FLAG = 'Y'
        ) B 
    WHERE A.ACCOUNT_CODE = B.ACCOUNT_CODE
    ORDER BY ACCOUNT_CODE   ;

END LIST_ACCOUNT;







END FI_MANAGEMENT_LEDGER_G;
/
