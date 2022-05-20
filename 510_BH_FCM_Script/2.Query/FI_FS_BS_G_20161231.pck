CREATE OR REPLACE PACKAGE FI_FS_BS_G
AS



/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_BS_G
Description  : �繫����ǥ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0763(�繫����ǥ)
Program History :
    1.FI_FS_BS ���̺��� ���� �о� �Ѱ��ش�.
    2.����1>�繫����ǥ ��� ���� �� ���̺� : FI_BALANCE_BS
      ����2>FI_BALANCE_BS, FI_FS_BS : 2���̺� ��� GLOBAL TEMPORARY TABLE�̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-03   Leem Dong Ern(�ӵ���)          
*****************************************************************************/


--Package ��������
t_FORM_TYPE_ID      FI_FORM_MST.FORM_TYPE_ID%TYPE   := 745;  --�������ID(�����ڵ�) : �繫����ǥ
t_LAST_ITEM_LEVEL   NUMBER := 0;    --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.




--�繫����ǥ grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_BS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_PERIOD_FROM     IN VARCHAR2                         --��ȸ�Ⱓ_����
    , W_PERIOD_TO       IN VARCHAR2                         --��ȸ�Ⱓ_����
);
 







--ȭ�� �׸��忡 ǥ�õ� ���ȸ�⸦ ���Ѵ�.
PROCEDURE FISCAL_COUNT_F(
      O_FISCAL_COUNT    OUT GL_FISCAL_YEAR.FISCAL_COUNT%TYPE    --���ȸ��
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --����ξ��̵�
    , W_FISCAL_YEAR     IN  GL_FISCAL_YEAR.FISCAL_YEAR%TYPE     --ȸ��⵵   
);





--��½� ���; ����, ����, ����, �繫����ǥ 4�� ��� ����
PROCEDURE PRINT_TITLE(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --����ξ��̵�
    , W_PERIOD_TO       IN VARCHAR2                             --��ȸ�Ⱓ_����  
);





END FI_FS_BS_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FS_BS_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_BS_G
Description  : �繫����ǥ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0763(�繫����ǥ)
Program History :
    1.FI_FS_BS ���̺��� ���� �о� �Ѱ��ش�.
    2.����1>�繫����ǥ ��� ���� �� ���̺� : FI_BALANCE_BS
      ����2>FI_BALANCE_BS, FI_FS_BS : 2���̺� ��� GLOBAL TEMPORARY TABLE�̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-03   Leem Dong Ern(�ӵ���)          
*****************************************************************************/



--�繫����ǥ grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_BS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_PERIOD_FROM     IN VARCHAR2                         --��ȸ�Ⱓ_����(��>2011-01)
    , W_PERIOD_TO       IN VARCHAR2                         --��ȸ�Ⱓ_����(��>2011-08)
)

AS

t_PERIOD_FROM           DATE := TO_DATE(W_PERIOD_FROM, 'YYYY-MM');          --����� ��ȸ�Ⱓ_������, 2011/01/01 00:00:00
t_PERIOD_TO             DATE := LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'));  --����� ��ȸ�Ⱓ_������, 2011/08/31 00:00:00

t_FORWARD_AMOUNT        NUMBER := 0;   --�̿��ݾ�

t_THIS_MNS_AMT          FI_FS_BS.THIS_MNS_AMT%TYPE := 0;    --���_���������׸�ݾ�
calc_THIS_MNS_AMT       FI_FS_BS.THIS_MNS_AMT%TYPE := 0;    --���_���������׸�ݾ�
t_PRE_MNS_AMT           FI_FS_BS.PRE_MNS_AMT%TYPE := 0;     --����_���������׸�ݾ�
calc_PRE_MNS_AMT        FI_FS_BS.PRE_MNS_AMT%TYPE := 0;     --����_���������׸�ݾ�

--t_CNT                   NUMBER  := 0;    --����ڻ�⸻�ݾ� �ڷ����� ������ �ľ��ϱ� ����.
--t_THIS_AMT              NUMBER  := 0;   --����ڻ� ��� �ݾ�
--t_PRE_AMT               NUMBER  := 0;   --����ڻ� ���� �ݾ�
t_THIS_NON_LAST_AMT     NUMBER  := 0;   --���_�������ƴѷ����׸�ݾ�
t_PRE_NON_LAST_AMT      NUMBER  := 0;   --����_�������ƴѷ����׸�ݾ�


t_RELATE_ITEM_CNT      NUMBER  := 0;   --1���� ������ �����׸��� 2�̻��� ��츦 ó���ϱ� ����





--��ǰ(1120100), ��ǰ(1120200) ���� ���� �����Ѵ�.
t_ITEM_AMT_01   NUMBER := 0;   --�⸻��ǰ����(01��)
t_ITEM_AMT_02   NUMBER := 0;   --�⸻��ǰ����(02��)
t_ITEM_AMT_03   NUMBER := 0;   --�⸻��ǰ����(03��)
t_ITEM_AMT_04   NUMBER := 0;   --�⸻��ǰ����(04��)
t_ITEM_AMT_05   NUMBER := 0;   --�⸻��ǰ����(05��)
t_ITEM_AMT_06   NUMBER := 0;   --�⸻��ǰ����(06��)
t_ITEM_AMT_07   NUMBER := 0;   --�⸻��ǰ����(07��)
t_ITEM_AMT_08   NUMBER := 0;   --�⸻��ǰ����(08��)
t_ITEM_AMT_09   NUMBER := 0;   --�⸻��ǰ����(09��)
t_ITEM_AMT_10   NUMBER := 0;   --�⸻��ǰ����(10��)
t_ITEM_AMT_11   NUMBER := 0;   --�⸻��ǰ����(11��)
t_ITEM_AMT_12   NUMBER := 0;   --�⸻��ǰ����(12��)

t_PRODUCT_AMT_01   NUMBER := 0;   --�⸻��ǰ����(01��)
t_PRODUCT_AMT_02   NUMBER := 0;   --�⸻��ǰ����(02��)
t_PRODUCT_AMT_03   NUMBER := 0;   --�⸻��ǰ����(03��)
t_PRODUCT_AMT_04   NUMBER := 0;   --�⸻��ǰ����(04��)
t_PRODUCT_AMT_05   NUMBER := 0;   --�⸻��ǰ����(05��)
t_PRODUCT_AMT_06   NUMBER := 0;   --�⸻��ǰ����(06��)
t_PRODUCT_AMT_07   NUMBER := 0;   --�⸻��ǰ����(07��)
t_PRODUCT_AMT_08   NUMBER := 0;   --�⸻��ǰ����(08��)
t_PRODUCT_AMT_09   NUMBER := 0;   --�⸻��ǰ����(09��)
t_PRODUCT_AMT_10   NUMBER := 0;   --�⸻��ǰ����(10��)
t_PRODUCT_AMT_11   NUMBER := 0;   --�⸻��ǰ����(11��)
t_PRODUCT_AMT_12   NUMBER := 0;   --�⸻��ǰ����(12��)




--�Ʒ� �������� ��ó�������׿��� ���� ���� ������ �ÿ� ����Ѵ�.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;


BEGIN

--1�ܰ�>�����ڷ� ����, ���� �ڷ� ����, �⺻ Ʋ ����

    --���� �ڷḦ �����Ѵ�.
    DELETE FI_FS_BS;

    --�繫����ǥ�� ��ȸ�ϱ� ���� �⺻Ʋ�� �����.
    INSERT INTO FI_FS_BS(
          ITEM_NAME	        --����׸��
        , THIS_MNS_AMT	    --���_���������׸�ݾ�
        , THIS_AMT	        --���_�������ݾ�
        , PRE_MNS_AMT	    --����_���������׸�ݾ�
        , PRE_AMT	        --����_�������ݾ�
        , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
        , SORT_SEQ	        --���ļ���
        , ITEM_LEVEL	    --�ݾװ�극��
        , ENABLED_FLAG	    --���(ǥ��)����
        , FORM_FRAME_YN	    --����Ʋ��������
        , FORM_ITEM_TYPE_CD --����ڻ�⸻�ݾװ����׸��ڵ�
        , MNS_ACCOUNT_FLAG	--������������(Y/N)
        , RELATE_ITEM_CODE	--(����������)�����׸��ڵ�
    )
    SELECT
          ITEM_NAME         --����׸��
        , 0 THIS_MNS_AMT	--���_���������׸�ݾ�
        , 0 THIS_AMT	    --���_�������ݾ�
        , 0 PRE_MNS_AMT	    --����_���������׸�ݾ�
        , 0 PRE_AMT	        --����_�������ݾ�        
        , ITEM_CODE         --�׸��ڵ�_�����ڵ�    
        , ACCOUNT_DR_CR     --���뱸��(1-����,2-�뺯)
        , SORT_SEQ          --���ļ���
        , ITEM_LEVEL        --�ݾװ�극��
        
        --N�� �ڷ�� �ݾװ�� �ÿ��� ��������, �������� �������� �ȵ� �׸��̴�.
        --��, N�� �ڷ�� �ݾװ���� ������ ���� �̷����� ü�踦 �����ϱ� ���� ������ �������� �׸��� ���̴�.
        , ENABLED_FLAG      --���(ǥ��)����
        
        --�ݾ��� ������ ������ �Ʒ� �׸��� 'Y'�� �׸��� ������ Ʋ�� �����ϱ� ���� ������ ��µǾ�� �� �׸��̴�.
        , FORM_FRAME_YN	        --����Ʋ��������
        
        , FORM_ITEM_TYPE_CD	    --����ڻ�⸻�ݾװ����׸��ڵ�

        --�繫���°�����(�ڻ�, ��ä, �ں�)�� �������򰡰������� �ִ�. 
        --�̷� �����鿡 ���� ���ϴ� �ݾ��� �����ϱ� ���� ���ȴ�.
        , MNS_ACCOUNT_FLAG	--������������(Y/N)
        , RELATE_ITEM_CODE	--(����������)�����׸��ڵ�                
    FROM FI_FORM_MST            --�繫��ǥ�������_������
    WHERE SOB_ID = W_SOB_ID                 --ȸ����̵�
        AND ORG_ID = W_ORG_ID               --����ξ��̵�
        AND FS_SET_ID = W_FS_SET_ID         --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID = t_FORM_TYPE_ID   --�������ID(�����ڵ�)
    ORDER BY SORT_SEQ    
    ;    

    --�繫����ǥ�� ��ϵ� ������������ ���Ѵ�.
    t_LAST_ITEM_LEVEL := FI_FORM_DET_G.LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, t_FORM_TYPE_ID);  


/*
--2�ܰ�> ������������ �ݾ��� ���Ѵ�.
    1.�����̿��ݾ��� ���Ѵ�.
    2.�ش� ��(��ȸ�Ⱓ_������ ~ ��ȸ�Ⱓ_������)�� �ݾ��� ���Ѵ�.
    3.�ش� ���� ���������׸�ݾ��� ���Ѵ�.
--������������ �ݾ��� �� ������ ���̴�. �Ͽ�, ���� �繫��ǥ����� �����ȣ�� �������� �ʴ´�.
--����, ���������� �׸��� �� �׸� ���� �繫��ǥ����� �����ȣ�� [+]�� �ƴ� �� ���� ���� �̸� �����ؾ� �Ѵ�.
*/

    --�����̿��ڷ� ����
    FI_FS_SLIP_G.CREATE_FS_SLIP_BLS(
          W_SOB_ID
        , W_ORG_ID
        , W_FS_SET_ID
        , t_FORM_TYPE_ID
        , t_LAST_ITEM_LEVEL
        , SUBSTR(W_PERIOD_FROM, 1, 4)   );
        
                
    --�Ⱓ���� �ش� ������ �ݾ��� �а��ڷῡ�� ���Ѵ�. 
    FI_FS_SLIP_BS_G.CREATE_FS_SLIP_BS(
          W_SOB_ID
        , W_ORG_ID
        , W_FS_SET_ID
        , t_FORM_TYPE_ID
        , t_LAST_ITEM_LEVEL
        , t_PERIOD_FROM
        , t_PERIOD_TO   );        


    FOR LAST_LEVEL_REC IN (
        SELECT          
              ITEM_CODE	    --�׸��ڵ�
            , ACCOUNT_DR_CR	--���뱸��(1-����,2-�뺯)           
        FROM FI_FS_BS
        WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL    
    ) LOOP               
                
        --2�ܰ�-1>���ݾ��� ���Ѵ�. 

        --���� �ʱ�ȭ
        t_FORWARD_AMOUNT    := 0;   --�̿��ݾ�            
        t_THIS_MNS_AMT      := 0;   --���_���������׸�ݾ�
               
        --1>�����̿��ݾ��� ���Ѵ�.             
        SELECT SUM(DR_AMT) AS AMT
        INTO t_FORWARD_AMOUNT
        FROM FI_FS_SLIP
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
        GROUP BY ITEM_CODE;


        --2>���(��ȸ�Ⱓ_������ ~ ��ȸ�Ⱓ_������)�� �ݾ��� ���Ѵ�.      
       
        IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --�ش� ������ ���������̸�
            SELECT t_FORWARD_AMOUNT + SUM(DR_AMT) - SUM(CR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;
        ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --�ش� ������ �뺯�����̸�
            SELECT t_FORWARD_AMOUNT + SUM(CR_AMT) - SUM(DR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;                
        END IF;                        
                    
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_THIS_MNS_AMT    --���_���������׸�ݾ�
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE;
        

        --2�ܰ�-2>����ݾ��� ���Ѵ�.

        --���� �ʱ�ȭ
        t_FORWARD_AMOUNT    := 0;   --�̿��ݾ�      
        t_THIS_MNS_AMT      := 0;   --���_���������׸�ݾ�
               
        --1>�����̿��ݾ��� ���Ѵ�.             
        SELECT SUM(CR_AMT) AS AMT
        INTO t_FORWARD_AMOUNT
        FROM FI_FS_SLIP
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
        GROUP BY ITEM_CODE;


        --2>����(��ȸ�Ⱓ_������ ~ ��ȸ�Ⱓ_������)�� �ݾ��� ���Ѵ�.

        IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --�ش� ������ ���������̸�
            SELECT t_FORWARD_AMOUNT + SUM(PRE_DR_AMT) - SUM(PRE_CR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;
        ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --�ش� ������ �뺯�����̸�
            SELECT t_FORWARD_AMOUNT + SUM(PRE_CR_AMT) - SUM(PRE_DR_AMT) AS AMT
            INTO t_THIS_MNS_AMT
            FROM FI_FS_SLIP_BS
            WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
            GROUP BY ITEM_CODE;                
        END IF; 

        UPDATE FI_FS_BS
        SET   PRE_MNS_AMT  = t_THIS_MNS_AMT --����_���������׸�ݾ�
        WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE;

    END LOOP LAST_LEVEL_REC;












--���Ͱ�꼭 �ڷḦ �����ͼ� 
--��ǰ(1120100), ��ǰ(1120200), ��ó�������׿���(3500100) ���� ���� �����Ѵ�.
--��.���� ����

    --���Ͱ�꼭 ���̺��� ����� �ڷḦ �����´�. 
    FI_FS_IS_PARADE_G.LIST_IS(
          IS_TCURSOR
        , W_SOB_ID                              --ȸ����̵�
        , W_ORG_ID                              --����ξ��̵�
        , W_FS_SET_ID                           --�������ؼ�Ʈ���̵�
        , SUBSTR(W_PERIOD_FROM, 1, 4)           --����
        , 'M'                                   --�ڷᱸ��(M : ��, Q : �б�, H : �ݱ�, Y : ��)
        , 'M01'                                 --��ȸ ���ۿ�(��> M01 : 1���ΰ��)
        , 'M' || SUBSTR(W_PERIOD_TO, 6, 2)      --��ȸ �����(��> M06 : 6���ΰ��)  
    );



    --����� ��ǰ(1120100), ��ǰ(1120200) ���� ���� �����Ѵ�.

    SELECT 
          NVL(LAST_LEVEL_AMT_01, 0)
        , NVL(LAST_LEVEL_AMT_02, 0)
        , NVL(LAST_LEVEL_AMT_03, 0)
        , NVL(LAST_LEVEL_AMT_04, 0)
        , NVL(LAST_LEVEL_AMT_05, 0)
        , NVL(LAST_LEVEL_AMT_06, 0)
        , NVL(LAST_LEVEL_AMT_07, 0)
        , NVL(LAST_LEVEL_AMT_08, 0)
        , NVL(LAST_LEVEL_AMT_09, 0)
        , NVL(LAST_LEVEL_AMT_10, 0)
        , NVL(LAST_LEVEL_AMT_11, 0)
        , NVL(LAST_LEVEL_AMT_12, 0)
    INTO
          t_ITEM_AMT_01   --�⸻��ǰ����(01��)
        , t_ITEM_AMT_02   --�⸻��ǰ����(02��)
        , t_ITEM_AMT_03   --�⸻��ǰ����(03��)
        , t_ITEM_AMT_04   --�⸻��ǰ����(04��)
        , t_ITEM_AMT_05   --�⸻��ǰ����(05��)
        , t_ITEM_AMT_06   --�⸻��ǰ����(06��)
        , t_ITEM_AMT_07   --�⸻��ǰ����(07��)
        , t_ITEM_AMT_08   --�⸻��ǰ����(08��)
        , t_ITEM_AMT_09   --�⸻��ǰ����(09��)
        , t_ITEM_AMT_10   --�⸻��ǰ����(10��)
        , t_ITEM_AMT_11   --�⸻��ǰ����(11��)
        , t_ITEM_AMT_12   --�⸻��ǰ����(12��)        
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '5'; 
    

    SELECT 
          NVL(LAST_LEVEL_AMT_01, 0)
        , NVL(LAST_LEVEL_AMT_02, 0)
        , NVL(LAST_LEVEL_AMT_03, 0)
        , NVL(LAST_LEVEL_AMT_04, 0)
        , NVL(LAST_LEVEL_AMT_05, 0)
        , NVL(LAST_LEVEL_AMT_06, 0)
        , NVL(LAST_LEVEL_AMT_07, 0)
        , NVL(LAST_LEVEL_AMT_08, 0)
        , NVL(LAST_LEVEL_AMT_09, 0)
        , NVL(LAST_LEVEL_AMT_10, 0)
        , NVL(LAST_LEVEL_AMT_11, 0)
        , NVL(LAST_LEVEL_AMT_12, 0) - 1073595591   -- ��뿵K :: ����ڻ� ��� �ݾ� ���� �ݿ�.... 
    INTO
          t_PRODUCT_AMT_01   --�⸻��ǰ����(01��)
        , t_PRODUCT_AMT_02   --�⸻��ǰ����(02��)
        , t_PRODUCT_AMT_03   --�⸻��ǰ����(03��)
        , t_PRODUCT_AMT_04   --�⸻��ǰ����(04��)
        , t_PRODUCT_AMT_05   --�⸻��ǰ����(05��)
        , t_PRODUCT_AMT_06   --�⸻��ǰ����(06��)
        , t_PRODUCT_AMT_07   --�⸻��ǰ����(07��)
        , t_PRODUCT_AMT_08   --�⸻��ǰ����(08��)
        , t_PRODUCT_AMT_09   --�⸻��ǰ����(09��)
        , t_PRODUCT_AMT_10   --�⸻��ǰ����(10��)
        , t_PRODUCT_AMT_11   --�⸻��ǰ����(11��)
        , t_PRODUCT_AMT_12   --�⸻��ǰ����(12��)        
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '8';



    --��ǰ(1120100)
    --���_���������׸�ݾ� COLUMN�� UPDATE�Ѵ�.
    IF SUBSTR(W_PERIOD_TO, 6, 2) = '01' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_01 
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '02' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_02
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '03' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_03
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '04' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_04
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '05' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_05
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '06' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_06
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '07' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_07
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '08' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_08
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '09' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_09
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '10' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_10
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '11' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_11
        WHERE ITEM_CODE = '1120100';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '12' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_PRODUCT_AMT_12
        WHERE ITEM_CODE = '1120100';        
    END IF;


    --��ǰ(1120200)
    --���_���������׸�ݾ� COLUMN�� UPDATE�Ѵ�.
    
    IF SUBSTR(W_PERIOD_TO, 6, 2) = '01' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_01 
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '02' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_02
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '03' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_03
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '04' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_04
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '05' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_05
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '06' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_06
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '07' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_07
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '08' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_08
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '09' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_09
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '10' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_10
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '11' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_11
        WHERE ITEM_CODE = '1120200';
    ELSIF SUBSTR(W_PERIOD_TO, 6, 2) = '12' THEN
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_ITEM_AMT_12
        WHERE ITEM_CODE = '1120200';        
    END IF;  






    --��ó�������׿��� ���� ���� �����Ѵ�.
    --�̷��� ���Ƿ� ���� �����ϴ� ������ ���������� ��ó�������׿��� �������� ��ǥ ����� ���� �ʱ� �����̴�.
    --���� ������ ����̿�(�ų� ���� �ϴ� �̿��۾��� ���Ѵ�.) �ÿ��� ��ó�������׿��� ������ ���� �����ؼ� �̿��ؾ� �Ѵ�.
       
    SELECT LAST_LEVEL_AMT_SUM
    INTO t_THIS_NON_LAST_AMT
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '15';


    --�繫����ǥ�� ����� ��ó�������׿��� ���� �����Ѵ�.
    UPDATE FI_FS_BS
    SET   THIS_MNS_AMT = THIS_MNS_AMT + t_THIS_NON_LAST_AMT
    WHERE ITEM_CODE = '3500100';
    







--���Ͱ�꼭 �ڷḦ �����ͼ� 
--��ǰ(1120100), ��ǰ(1120200), ��ó�������׿���(3500100) ���� ���� �����Ѵ�.
--��.����� ����
   
    --���Ͱ�꼭 ���̺��� ������ �ڷḦ �����´�. 
    FI_FS_IS_PARADE_G.LIST_IS(
          IS_TCURSOR
        , W_SOB_ID                          --ȸ����̵�
        , W_ORG_ID                          --����ξ��̵�
        , W_FS_SET_ID                       --�������ؼ�Ʈ���̵�
        , SUBSTR(W_PERIOD_FROM, 1, 4) - 1   --����
        , 'M'                               --�ڷᱸ��(M : ��, Q : �б�, H : �ݱ�, Y : ��)
        , 'M01'                             --��ȸ ���ۿ�(��> M01 : 01���ΰ��)
        , 'M12'                             --��ȸ �����(��> M12 : 12���ΰ��)  
    );



    --������ ��ǰ(1120100), ��ǰ(1120200) ���� ���� �����Ѵ�.
    --�����ڷ�� ���ʹ� �޸� ������ 12�� �ڷḦ �����´�.

    SELECT NVL(LAST_LEVEL_AMT_12, 0)
    INTO t_ITEM_AMT_12   --�⸻��ǰ����(12��)        
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '5'; 
    

    SELECT  NVL(LAST_LEVEL_AMT_12, 0)           
    INTO t_PRODUCT_AMT_12   --�⸻��ǰ����(12��)        
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '8';



    --��ǰ(1120100)
    --����_���������׸�ݾ� COLUMN�� UPDATE�Ѵ�.
    UPDATE FI_FS_BS
    SET   PRE_MNS_AMT  = t_PRODUCT_AMT_12
    WHERE ITEM_CODE = '1120100';     


    --��ǰ(1120200)
    --����_���������׸�ݾ� COLUMN�� UPDATE�Ѵ�.
    UPDATE FI_FS_BS
    SET   PRE_MNS_AMT  = t_ITEM_AMT_12
    WHERE ITEM_CODE = '1120200';      


       
    SELECT LAST_LEVEL_AMT_SUM
    INTO t_PRE_NON_LAST_AMT
    FROM FI_FS_IS_PARADE
    WHERE ITEM_CODE = '15';


    --�繫����ǥ�� ������ ��ó�������׿��� ���� �����Ѵ�.
    UPDATE FI_FS_BS
    SET   PRE_MNS_AMT  = PRE_MNS_AMT  + t_PRE_NON_LAST_AMT
    WHERE ITEM_CODE = '3500100';     











--4�ܰ�>������������ �ƴ� �׸�鿡 ���� �ݾ��� ���Ѵ�.
--�ݾװ�극���� ū �� ���� ���������� �ݾ��� ���Ѵ�. ��>4���� ���� 1���� ����
    FOR NO_LAST_REC IN (
        SELECT           
              ITEM_CODE	    --�׸��ڵ�
            , ACCOUNT_DR_CR	--���뱸��(1-����,2-�뺯)
        FROM FI_FS_BS
        WHERE ITEM_LEVEL < t_LAST_ITEM_LEVEL
        ORDER BY ITEM_LEVEL DESC
    ) LOOP

        --���� �ʱ�ȭ
        t_THIS_MNS_AMT  := 0;   --���_���������׸�ݾ�
        t_PRE_MNS_AMT   := 0;   --����_���������׸�ݾ�

        FOR CALC_REC IN (
            SELECT 
                  DET_ITEM_CODE     --���׸��ڵ�
                , DECODE(ITEM_SIGN_SHOW, '+', 1, -1) AS ITEM_SIGN_SHOW     --�����ȣ(+/-) 
            FROM FI_FORM_DET
            WHERE SOB_ID = W_SOB_ID         --ȸ����̵�
                AND ORG_ID = W_ORG_ID       --����ξ��̵�
                AND FS_SET_ID = W_FS_SET_ID --�������ؼ�Ʈ���̵�
                AND FORM_TYPE_ID = t_FORM_TYPE_ID      --�������ID(�����ڵ�)
                AND ITEM_CODE = NO_LAST_REC.ITEM_CODE
        ) LOOP
        
            SELECT
                    NVL(THIS_MNS_AMT, 0)    --���_���������׸�ݾ�               
                  , NVL(PRE_MNS_AMT, 0)     --����_���������׸�ݾ�
            INTO
                    calc_THIS_MNS_AMT   --���_���������׸�ݾ�
                  , calc_PRE_MNS_AMT    --����_���������׸�ݾ�
            FROM FI_FS_BS
            WHERE ITEM_CODE = CALC_REC.DET_ITEM_CODE
            ;
                        
            t_THIS_MNS_AMT  := t_THIS_MNS_AMT + (calc_THIS_MNS_AMT * CALC_REC.ITEM_SIGN_SHOW);  --���_���������׸�ݾ� 
            t_PRE_MNS_AMT   := t_PRE_MNS_AMT + (calc_PRE_MNS_AMT * CALC_REC.ITEM_SIGN_SHOW);    --���_���������׸�ݾ� 
        
        END LOOP CALC_REC; 
        
        
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT  = t_THIS_MNS_AMT
            , PRE_MNS_AMT   = t_PRE_MNS_AMT
        WHERE ITEM_CODE = NO_LAST_REC.ITEM_CODE ;
    
    END LOOP NO_LAST_REC;












--5�ܰ�> ���������� �ƴ� �׸���� �ڷḦ �����Ѵ�.
--���������� �ƴ� �׸���� �� ���� �� ���� 2��° Į���� ������ �Ѵ�.
--��, ���������� �ƴ����� ���������� ������ �������� �����Ѵ�.

    FOR NO_MNS_REC_ADJUST IN (
        SELECT           
                ITEM_CODE	    --�׸��ڵ�
        FROM FI_FS_BS
        WHERE DECODE(MNS_ACCOUNT_FLAG, 'Y', 'Y', 'N') = 'N' --���������� �ƴ� �׸���� �ڷ�
            AND ITEM_CODE NOT IN 
                (   --��, ���������� �ƴ����� ���������� ������ �������� �����Ѵ�.
                    SELECT RELATE_ITEM_CODE
                    FROM FI_FS_BS
                    WHERE DECODE(MNS_ACCOUNT_FLAG, 'Y', 'Y', 'N') = 'Y' --���������� �׸���� �ڷ�
                        AND (THIS_MNS_AMT <> 0 OR THIS_AMT <> 0 
                            OR PRE_MNS_AMT <> 0  OR PRE_AMT <> 0 )
                ) --������������ ���Ǵ� ������ �����Ѵ�.
    ) LOOP
   
        UPDATE FI_FS_BS
        SET   THIS_AMT = THIS_MNS_AMT   --���_�������ݾ�
            , PRE_AMT  = PRE_MNS_AMT    --����_�������ݾ�
        WHERE ITEM_CODE = NO_MNS_REC_ADJUST.ITEM_CODE;
        
        UPDATE FI_FS_BS
        SET   THIS_MNS_AMT = 0  --���_���������׸�ݾ�
            , PRE_MNS_AMT  = 0  --����_���������׸�ݾ�
        WHERE ITEM_CODE = NO_MNS_REC_ADJUST.ITEM_CODE;           

    END LOOP NO_MNS_REC_ADJUST;






--6�ܰ�> ���������� �׸���� �ڷḦ �����Ѵ�.
--���������� �׸���� �� ���� �� ���� 2��° Į���� ������ �Ѵ�.

    FOR MNS_REC_ADJUST IN (
        SELECT           
              ITEM_CODE	        --�׸��ڵ�
            , THIS_MNS_AMT      --���_���������׸�ݾ�
            , PRE_MNS_AMT       --����_���������׸�ݾ�
            , RELATE_ITEM_CODE  --(����������)�����׸��ڵ�
        FROM FI_FS_BS
        WHERE DECODE(MNS_ACCOUNT_FLAG, 'Y', 'Y', 'N') = 'Y' --���������� �׸���� �ڷ�
    ) LOOP
    
        --�����ʱ�ȭ
        t_THIS_MNS_AMT  := 0;
        t_PRE_MNS_AMT   := 0;
        
                
        SELECT NVL(THIS_MNS_AMT, 0), NVL(PRE_MNS_AMT, 0)
        INTO t_THIS_MNS_AMT, t_PRE_MNS_AMT
        FROM FI_FS_BS
        WHERE ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE   ;
        
        
        --1���� ������ �����׸��� 2�̻��� ��츦 ó���ϱ� ����; 2011.09.26�� ������.
        --�������� : �������ڻ� > �����ڻ� > �ǹ����� �򰡰����� �����󰢴���װ� ���������� 2�� ������ �־�̴�.
        SELECT COUNT(*)
        INTO t_RELATE_ITEM_CNT
        FROM FI_FS_BS
        WHERE RELATE_ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE;
        
        IF t_RELATE_ITEM_CNT > 1 THEN   --1���� ������ �����׸��� 2�̻��� ���
            --�� ���� �����׸��� 2�� �̻��̹Ƿ� �����׸� �ڻ��� ���� ���� �ݾ��� �������� �ʰ�, ������� ������.
            
            --�ڱ��ڽ��� '0'���� �����Ѵ�.    
            UPDATE FI_FS_BS
            SET   THIS_AMT = 0   --���_�������ݾ�
                , PRE_AMT  = 0     --����_�������ݾ�
            WHERE ITEM_CODE = MNS_REC_ADJUST.ITEM_CODE  ; 
            
            --�� ������ 2��° Į���� ������� �ݾ׿��� �򰡰����� �ݾ׵��� ������ ���� �ݾ��� �����Ѵ�.
            UPDATE FI_FS_BS
            SET   THIS_AMT = THIS_MNS_AMT - 
                        (
                            SELECT SUM(THIS_MNS_AMT)
                            FROM FI_FS_BS
                            WHERE RELATE_ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE
                        )   --���_�������ݾ�
                , PRE_AMT  = PRE_MNS_AMT - 
                        (
                            SELECT SUM(PRE_MNS_AMT)
                            FROM FI_FS_BS
                            WHERE RELATE_ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE                        
                        )     --����_�������ݾ�
            WHERE ITEM_CODE = MNS_REC_ADJUST.RELATE_ITEM_CODE  ;            
                
        ELSE    --1���� ������ �����׸��� 1���� ���
            --�� ���� �����׸� �� �׸���� �ݾ��� ������ �� �ڻ��� ���� ���� �ݾ��� ������.
            UPDATE FI_FS_BS
            SET   THIS_AMT = t_THIS_MNS_AMT - MNS_REC_ADJUST.THIS_MNS_AMT   --���_�������ݾ�
                , PRE_AMT  = t_PRE_MNS_AMT - MNS_REC_ADJUST.PRE_MNS_AMT     --����_�������ݾ�
            WHERE ITEM_CODE = MNS_REC_ADJUST.ITEM_CODE  ;          
        END IF;                        

    END LOOP MNS_REC_ADJUST;


 



--7�ܰ�> ����Ʋ�������� �ڷḦ �ƹ� ���� ���� �ɷ� �����Ѵ�.
    UPDATE FI_FS_BS
    SET   THIS_MNS_AMT  = DECODE(THIS_MNS_AMT,  0, NULL, THIS_MNS_AMT)
        , THIS_AMT      = DECODE(THIS_AMT,      0, NULL, THIS_AMT)
        , PRE_MNS_AMT   = DECODE(PRE_MNS_AMT,   0, NULL, PRE_MNS_AMT)
        , PRE_AMT       = DECODE(PRE_AMT,       0, NULL, PRE_AMT)
    WHERE FORM_FRAME_YN = 'Y';
    






--8�ܰ�>�繫����ǥ�� ��ȸ�Ѵ�.
    OPEN P_CURSOR FOR
    
       
    SELECT
          A.ITEM_NAME     --��������; ����׸��
        , A.THIS_MNS_AMT  --���ݾ�; ���_���������׸�ݾ�
        --, A.THIS_AMT  --���ݾ�; ���_�������ݾ�
        , DECODE(UPPER(B.REMARKS), 'MINUS', '(' || TO_CHAR(A.THIS_AMT, 'FM999,999,999,999,999') || ')', TO_CHAR(A.THIS_AMT, 'FM999,999,999,999,999')) AS THIS_AMT      --���ݾ�; ���_�������ݾ�
        , A.PRE_MNS_AMT   --����ݾ�; ����_���������׸�ݾ�
        --, A.PRE_AMT       --����ݾ�; ����_�������ݾ�
        , DECODE(UPPER(B.REMARKS), 'MINUS', '(' || TO_CHAR(A.PRE_AMT, 'FM999,999,999,999,999') || ')', TO_CHAR(A.PRE_AMT, 'FM999,999,999,999,999')) AS PRE_AMT      --����ݾ�; ����_�������ݾ�
          
        , A.ITEM_CODE	        --�׸��ڵ�_�����ڵ�        
        , A.ACCOUNT_DR_CR	    --���뱸���ڵ�(1-����,2-�뺯)
        , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', A.ACCOUNT_DR_CR, W_SOB_ID) AS ACCOUNT_DR_CR_NAME   --���뱸��
        , A.SORT_SEQ          --���ļ���
        , A.ITEM_LEVEL	    --�ݾװ�극��; �׸񷹺�
        , A.ENABLED_FLAG      --���(ǥ��)����
        , A.FORM_FRAME_YN     --����Ʋ��������        
        , A.FORM_ITEM_TYPE_CD --����ڻ�⸻�ݾװ����׸��ڵ�
        , A.MNS_ACCOUNT_FLAG	--������������(Y/N)
        , A.RELATE_ITEM_CODE	--(����������)�����׸��ڵ�                
        , A.REF_FORM_TYPE_ID	--���ú������ID(�����ڵ�)
        , A.REF_ITEM_CODE     --�����׸��ڵ�        
    FROM FI_FS_BS A
    , 
        (SELECT ITEM_CODE, REMARKS
         FROM FI_FORM_MST 
         WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND FS_SET_ID = W_FS_SET_ID
            AND FORM_TYPE_ID = t_FORM_TYPE_ID
            AND UPPER(REMARKS) = 'MINUS'
        ) B        
    WHERE (A.FORM_FRAME_YN = 'Y' OR
        (A.ENABLED_FLAG = 'Y'    --������ ����� �׸� �������� ��.    
            --ȭ�鿡 ���̴� 4���� �ݾ� �׸��� ��� 0 �� �ڷ�� ������ �ʰ� �ϱ� ����.
            AND (A.THIS_MNS_AMT <> 0 OR A.THIS_AMT <> 0 
                OR A.PRE_MNS_AMT <> 0  OR A.PRE_AMT <> 0 )                
        ))
        AND A.ITEM_CODE = B.ITEM_CODE(+)
    ORDER BY SORT_SEQ;    


    EXCEPTION
        WHEN OTHERS THEN
           --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
           --RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         
            NULL;

END LIST_BS;







--ȭ�� �׸��忡 ǥ�õ� ���ȸ�⸦ ���Ѵ�.
PROCEDURE FISCAL_COUNT_F(
      O_FISCAL_COUNT    OUT GL_FISCAL_YEAR.FISCAL_COUNT%TYPE    --���ȸ��
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --����ξ��̵�
    , W_FISCAL_YEAR     IN  GL_FISCAL_YEAR.FISCAL_YEAR%TYPE     --ȸ��⵵   
)

AS


BEGIN
    
    SELECT FISCAL_COUNT
    INTO O_FISCAL_COUNT
    FROM GL_FISCAL_YEAR
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FISCAL_YEAR = SUBSTR(W_FISCAL_YEAR, 1, 4)   ;                 

END FISCAL_COUNT_F;








--��½� ���; ����, ����, ����, �繫����ǥ 4�� ��� ����
PROCEDURE PRINT_TITLE(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --����ξ��̵�
    , W_PERIOD_TO       IN VARCHAR2                             --��ȸ�Ⱓ_����  
)

AS

CURR_DATE   DATE;   -- := LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM'));  --������
PRE_DATE    DATE;   -- := LAST_DAY(TO_DATE( TO_CHAR(SUBSTR(W_PERIOD_TO, 1, 4) - 1) || '-12', 'YYYY-MM'));  --������


BEGIN

    BEGIN
        SELECT
              LAST_DAY(TO_DATE(W_PERIOD_TO, 'YYYY-MM')) --������
            , LAST_DAY(TO_DATE( TO_CHAR(SUBSTR(W_PERIOD_TO, 1, 4) - 1) || '-12', 'YYYY-MM'))    --������
        INTO CURR_DATE, PRE_DATE
        FROM DUAL;
        
        EXCEPTION WHEN OTHERS THEN NULL;
              
    END;



    OPEN P_CURSOR FOR

    SELECT
        (
            SELECT CORP_NAME   --��ȣ(���θ�)
            FROM HRM_CORP_MASTER
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND CORP_ID = 65  --���ξ��̵�
        ) AS CORP_NAME  --��ȣ(���θ�)
        , '�� ' || FISCAL_COUNT || '(��)��   '  AS CUR_PERIOD  --��������, ���Ͱ�꼭, �繫����ǥ���� ���
        , '�� ' || (FISCAL_COUNT - 1) || '(��)��   '  AS PRE_PERIOD    --��������, ���Ͱ�꼭, �繫����ǥ���� ���
        , '�� ' || FISCAL_COUNT || ' ��   ' 
                || TO_CHAR(CURR_DATE, 'YYYY') || ' �� '  
                || TO_NUMBER(TO_CHAR(CURR_DATE, 'MM')) || ' �� ' 
                || TO_CHAR(CURR_DATE, 'DD') || ' �� ����'      
            AS CUR_YEAR --���(��>�� 13�� 2011�� 12�� 31�� ����); �繫����ǥ���� ���
        , '�� ' || (FISCAL_COUNT - 1) || ' ��   ' 
                || TO_CHAR(PRE_DATE, 'YYYY') || ' �� 12 �� 31 �� ����'  
                --|| TO_NUMBER(TO_CHAR(PRE_DATE, 'MM')) || '�� ' 
                --|| TO_CHAR(PRE_DATE, 'DD') || '�� ����'
            AS PRE_YEAR --����(��>�� 12�� 2010�� 12�� 31�� ����); �繫����ǥ���� ���
        , '�� ' || FISCAL_COUNT || ' ��   '
                || TO_CHAR(CURR_DATE, 'YYYY') || ' �� 1 �� 1  �� ���� ' 
                || TO_CHAR(CURR_DATE, 'YYYY') || ' �� '  
                || TO_NUMBER(TO_CHAR(CURR_DATE, 'MM')) || ' �� ' 
                || TO_CHAR(CURR_DATE, 'DD') || ' �� ����'      
            AS CUR_TERM --���(��>�� 13�� 2011�� 01�� 01�� ���� 2011�� 12�� 31�� ����); ��������, ���Ͱ�꼭���� ���
        , '�� ' || (FISCAL_COUNT - 1) || ' ��   '
                || TO_CHAR(PRE_DATE, 'YYYY') || ' �� 1 �� 1 �� ���� ' 
                || TO_CHAR(PRE_DATE, 'YYYY') || ' �� 12 �� 31 �� ����'  
                --|| TO_NUMBER(TO_CHAR(PRE_DATE, 'MM')) || '�� ' 
                --|| TO_CHAR(PRE_DATE, 'DD') || '�� ����'
            AS PRE_TERM --����(��>�� 12�� 2010�� 01�� 01�� ���� 2010�� 12�� 31�� ����); ��������, ���Ͱ�꼭���� ���
        , TO_CHAR(CURR_DATE, 'YYYY') || ' �� '  
            || TO_NUMBER(TO_CHAR(CURR_DATE, 'MM')) || ' �� ' 
            || TO_CHAR(CURR_DATE, 'DD') || ' �� ����'      
            AS CUR_DATE --������(��>2011�� 12�� 31�� ����); ���ܿ��� ���        
    FROM GL_FISCAL_YEAR
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND FISCAL_YEAR = SUBSTR(W_PERIOD_TO, 1, 4)   ;                     

END PRINT_TITLE;




END FI_FS_BS_G;
/
