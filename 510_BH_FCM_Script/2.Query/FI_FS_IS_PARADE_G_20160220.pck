CREATE OR REPLACE PACKAGE FI_FS_IS_PARADE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_IS_PARADE_G
Description  : ���Ͱ�꼭 Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0762(���Ͱ�꼭)
Program History :
    1.FI_FS_IS_PARADE ���̺��� GLOBAL TEMPORARY TABLE�̴�.
    2.���Ͱ�꼭 ���ϴ� ����
      1�ܰ�>������������ �ݾ��� ���Ѵ�.
      2�ܰ�>������������ �ƴ� �׸�鿡 ���� �ݾ��� ���Ѵ�.
      3�ܰ�>���Ͱ�꼭�� ��ȸ�Ѵ�.      
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-31   Leem Dong Ern(�ӵ���)          
*****************************************************************************/


t_FORM_TYPE_ID      FI_FORM_MST.FORM_TYPE_ID%TYPE;  --�������ID(�����ڵ�) 
t_LAST_ITEM_LEVEL   NUMBER := 0;    --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.
t_FORWARD_RAW_AMT   NUMBER := 0;    --�����̿��� �����ݾ�
t_FORWARD_LINE_AMT  NUMBER := 0;    --�����̿��� ���ǰ�ݾ�
t_FS_SET_ID         FI_FORM_MST.FS_SET_ID%TYPE;  --�������ؼ�Ʈ���̵�




--���Ͱ�꼭 grid�� ��ȸ�Ǵ� �ڷ� ����
--�� ���ν����� ȣ���ϴ� Ÿ ���α׷� : ���Ͱ�꼭, ���ó�� > ���а�
PROCEDURE LIST_IS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�
    , W_CLOSING_YEAR    IN  VARCHAR2                    --����(�� ���� ��� ����Ⱓ���� �⸸�� �����Ͽ� �ѱ��.)
    , W_DATA_GB         IN  VARCHAR2                    --�ڷᱸ��(M : ��, Q : �б�, H : �ݱ�, Y : ��)

    --������� ���ۿ����� ���ų� Ŀ�� �մϴ�.
    , W_CLOSING_START   IN  VARCHAR2                    --��ȸ ���ۿ�(��> M01[1���ΰ��], Q01, H01 , ���� ��� : 2011-01)
    , W_CLOSING_END     IN  VARCHAR2                    --��ȸ �����(��> M06[6���ΰ��], Q03, H02 , ���� ��� : 2011-09)    
);






--LIST_IS PROCEDURE�� ������ ������ �ڷᱸ���� ���� �ƴ� ���
--�ڷᱸ���� ���� ��� �� ���� �⸻��ǰ����/�⸻��ǰ������ ���� 
--�ڷᱸ���� �б�, �ݱ�, �� �� ����� �⸻��ǰ����/�⸻��ǰ������ ���ϱ� �����̴�.
PROCEDURE LIST_IS_M_OTHER( 
      W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�
    , W_CLOSING_YEAR    IN  VARCHAR2                    --����
    , W_DATA_GB         IN  VARCHAR2                    --�ڷᱸ��(M : ��)

    --������� ���ۿ����� ���ų� Ŀ�� �մϴ�.
    , W_CLOSING_START   IN  VARCHAR2                    --��ȸ ���ۿ�(��> M01 : 1���ΰ��)
    , W_CLOSING_END     IN  VARCHAR2                    --��ȸ �����(��> M12 : 12���ΰ��)
);





--�ش���� �´� Į���� ���� UPDATE�Ѵ�.
PROCEDURE UPDATE_AMT( 
      W_TERM        IN  VARCHAR2    --��
    , W_AMT         IN  NUMBER      --�ݾ�
    , W_ITEM_CODE   IN  FI_FS_IS_PARADE.ITEM_CODE%TYPE    --�׸��ڵ�_�����ڵ�
);






--����ڻ�⸻�ڷḦ ���Ѵ�.
FUNCTION INVENTORY_DATA_F(
      W_DATA_GB IN VARCHAR2                 --C : �Ǽ�, A : �ݾ�
    , W_SOB_ID  IN FI_FORM_MST.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID  IN FI_FORM_MST.ORG_ID%TYPE  --����ξ��̵�
    , W_PERIOD  IN VARCHAR2                 --��ȸ�Ⱓ(��>2011-12)
    
    --����ڻ�ݾװ����׸��ڵ�(402 : �⸻��ǰ, 302 : �⸻��ǰ)
    , W_FORM_ITEM_TYPE_CD   IN FI_CLOSING_ENDING_AMOUNT.FORM_ITEM_TYPE_CD%TYPE
) RETURN NUMBER;








--��½� ���; ����, ����, ����, �繫����ǥ 4�� ��� ����
PROCEDURE PRINT_TITLE(
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  GL_FISCAL_YEAR.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  GL_FISCAL_YEAR.ORG_ID%TYPE          --����ξ��̵�
    , W_PERIOD_TO       IN VARCHAR2                             --��ȸ�Ⱓ_����  
);




END FI_FS_IS_PARADE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FS_IS_PARADE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FS_IS_PARADE_G
Description  : ���Ͱ�꼭 Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0762(���Ͱ�꼭)
Program History :
    1.FI_FS_IS_PARADE ���̺��� GLOBAL TEMPORARY TABLE�̴�.
    2.���Ͱ�꼭 ���ϴ� ����
      1�ܰ�>������������ �ݾ��� ���Ѵ�.
      2�ܰ�>������������ �ƴ� �׸�鿡 ���� �ݾ��� ���Ѵ�.
      3�ܰ�>���Ͱ�꼭�� ��ȸ�Ѵ�.      
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-08-31   Leem Dong Ern(�ӵ���)          
*****************************************************************************/



--���Ͱ�꼭 grid�� ��ȸ�Ǵ� �ڷ� ����
--�� ���ν����� ȣ���ϴ� Ÿ ���α׷� : ���Ͱ�꼭, ���ó�� > ���а�
PROCEDURE LIST_IS( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�
    , W_CLOSING_YEAR    IN  VARCHAR2                    --����(�� ���� ��� ����Ⱓ���� �⸸�� �����Ͽ� �ѱ��.)
    , W_DATA_GB         IN  VARCHAR2                    --�ڷᱸ��(M : ��, Q : �б�, H : �ݱ�, Y : ��)

    --������� ���ۿ����� ���ų� Ŀ�� �մϴ�.
    , W_CLOSING_START   IN  VARCHAR2                    --��ȸ ���ۿ�(��> M01[1���ΰ��], Q01, H01 , ���� ��� : 2011-01)
    , W_CLOSING_END     IN  VARCHAR2                    --��ȸ �����(��> M06[6���ΰ��], Q03, H02 , ���� ��� : 2011-09) 
)

AS

t_CNT               NUMBER := 0;    --����ڻ�⸻�ݾ� �ڷ����� ������ �ľ��ϱ� ����.


t_TERM_START_M      VARCHAR2(2) := NULL;    --�����ۿ�
t_TERM_END_M        VARCHAR2(2) := NULL;    --��������
t_REPEAT            VARCHAR2(2) := NULL;    --�ڷ���ȸ��
t_PERIOD_FROM       DATE;                   --��������
t_PERIOD_TO         DATE;                   --���������


t_REPEAT_MM        VARCHAR2(2) := NULL;    --����ڻ�⸻�ݾ� ����� �����.

t_WORK_MM           VARCHAR2(2) := NULL;    --���� ��� �����.
t_RECURSIVE_CNT     NUMBER  := 0;           --����ڻ�⸻�ݾ� ������ ���� LOOP�� �ݺ� ȸ��


--����� �ǹ� : [��]�ǿ����� 1��, 2�� ���� �� ���� �ǹ��ϰ�, [�б�]�ǿ��� 1�б�, 2�б� ���� �ǹ��ϴ� �̷� ���̴�.
t_THIS_LAST_LEVEL_AMT       NUMBER  := 0;   --���_�����������׸�ݾ�

t_LAST_LEVEL_AMT_01         NUMBER  := 0;   --01��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_01_CALC    NUMBER  := 0;   --01��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_02         NUMBER  := 0;   --02��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_02_CALC    NUMBER  := 0;   --02��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_03         NUMBER  := 0;   --03��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_03_CALC    NUMBER  := 0;   --03��_�����������׸�ݾ� ���踦 ���� ����        
t_LAST_LEVEL_AMT_04         NUMBER  := 0;   --04��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_04_CALC    NUMBER  := 0;   --04��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_05         NUMBER  := 0;   --05��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_05_CALC    NUMBER  := 0;   --05��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_06         NUMBER  := 0;   --06��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_06_CALC    NUMBER  := 0;   --06��_�����������׸�ݾ� ���踦 ���� ���� 
t_LAST_LEVEL_AMT_07         NUMBER  := 0;   --07��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_07_CALC    NUMBER  := 0;   --07��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_08         NUMBER  := 0;   --08��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_08_CALC    NUMBER  := 0;   --08��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_09         NUMBER  := 0;   --09��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_09_CALC    NUMBER  := 0;   --09��_�����������׸�ݾ� ���踦 ���� ���� 
t_LAST_LEVEL_AMT_10         NUMBER  := 0;   --10��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_10_CALC    NUMBER  := 0;   --10��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_11         NUMBER  := 0;   --11��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_11_CALC    NUMBER  := 0;   --11��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_12         NUMBER  := 0;   --12��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_12_CALC    NUMBER  := 0;   --12��_�����������׸�ݾ� ���踦 ���� ���� 

t_INVENTORY_AMOUNT      NUMBER := 0;   --����ڻ� �̿��ݾ�
t_TERM_END_AMT          NUMBER := 0;   --����ڻ� �Ⱓ���ݾ�
t_TERM_END_AMT_NEXT     NUMBER := 0;   --����ڻ� �Ⱓ���ݾ�(���� ������������� �����ϱ� ����)
t_TERM_END_LINE_AMT     NUMBER := 0;   --����ڻ� �⸻���ǰ����
t_TERM_END_LINE_AMT_0   NUMBER := 0;   --����ڻ� �⸻���ǰ������ 0 �ΰ�츦 ����Ͽ� ���.
t_TERM_END_RAW_AMT      NUMBER := 0;   --����ڻ� �����ݾ�
t_MATERIAL_AMT          NUMBER := 0;   --�⸻��������� �ӽ� ����
t_ITEM_COST             NUMBER := 0;   --�����ǰ�������� �ӽ� ����


t_ITEM_CODE     FI_FS_IS_PARADE.ITEM_CODE%TYPE;      --�׸��ڵ�_�����ڵ�
t_ACCOUNT_DR_CR FI_FS_IS_PARADE.ACCOUNT_DR_CR%TYPE;  --���뱸��(1-����,2-�뺯)

--�������������� �����ǰ���������� �����ϱ� ���� CURSOR��.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;



--�ڷᱸ���� �б�, �ݱ�, �� �� ����� �⸻��ǰ����/�⸻��ǰ������ ���ϱ� �����̴�.
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


t_ITEM_AMT_12_PRE       NUMBER := 0;   --����_�⸻��ǰ����(12��)
t_PRODUCT_AMT_12_PRE    NUMBER := 0;   --����_�⸻��ǰ����(12��)


BEGIN

--1�ܰ�>�����ڷ� ����, ���� �ڷ� ����, �⺻ Ʋ ����

    t_FORM_TYPE_ID := 746;   --���Ͱ�꼭
    
    --�������������� ��ļ�Ʈ�� �����ϰ� �������� ����ϴ� ���̹Ƿ� �̸� �����Ѵ�.
    IF W_FS_SET_ID = 1674 THEN
        t_FS_SET_ID := W_FS_SET_ID;
    ELSE
        t_FS_SET_ID := 1674;
    END IF;
    


    --�� ������ �����ϱ� ���� �۾��⵵�� �ش��ϴ� �� ���� ����ڻ�⸻�ݾ� �ڷḦ �⺻ ���� null�� ���������� INSERT�� ���´�.
    FI_CLOSING_ENDING_AMOUNT_G.CREATE_CLOSING_ENDING_AMOUNT(W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR);

        
    --���Ͱ�꼭�� ��ϵ� ������������ ���Ѵ�.
    t_LAST_ITEM_LEVEL := FI_FORM_DET_G.LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, t_FORM_TYPE_ID);  
    

    BEGIN
        --�����̿��� ��ǰ�ݾ��� �����Ͽ� ���ʻ�ǰ���׿� ����Ѵ�.
        t_FORWARD_RAW_AMT := 0;
        
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_FORWARD_RAW_AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --��ǥ���� : '�����ܾ��̿�-BLS'
            AND PERIOD_NAME = W_CLOSING_YEAR || '-01'  --'2011-01'
            AND ACCOUNT_CODE IN('1120200', '1120201', '1120202', '1120203')    --1120200 : ��ǰ
        ;              
        
                
        --�����̿��� ��ǰ�ݾ��� �����Ͽ� ������ǰ���׿� ����Ѵ�.
        t_FORWARD_LINE_AMT := 0;
        
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_FORWARD_LINE_AMT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --��ǥ���� : '�����ܾ��̿�-BLS'
            AND PERIOD_NAME = W_CLOSING_YEAR || '-01'  --'2011-01'
            AND ACCOUNT_CODE = '1120100'    --1120100 : ��ǰ  
        ;
        
        EXCEPTION        
            WHEN OTHERS THEN
               --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
               RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');             
    END;      




    --LIST_IS PROCEDURE�� ������ ������ �ڷᱸ���� ���� �ƴ� ���
    --�ڷᱸ���� ���� ��� �� ���� �⸻��ǰ����/�⸻��ǰ������ ���� 
    --�ڷᱸ���� �б�, �ݱ�, �� �� ����� �⸻��ǰ����/�⸻��ǰ������ ���ϱ� �����̴�.
    IF W_DATA_GB != 'M' THEN
        LIST_IS_M_OTHER(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, W_CLOSING_YEAR, 'M', 'M01', 'M12');        
        
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
            , NVL(LAST_LEVEL_AMT_12, 0)
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
    END IF;
    


    --�ڷᱸ���� [��]�� ��� ������ �⸻��ǰ����, �⸻��ǰ������ ���ϱ� ����.
    IF W_DATA_GB = 'Y' THEN
        LIST_IS_M_OTHER(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, TO_CHAR(W_CLOSING_YEAR - 1), 'M', 'M01', 'M12');        
        
        SELECT NVL(LAST_LEVEL_AMT_12, 0)
        INTO t_ITEM_AMT_12_PRE   --����_�⸻��ǰ����(12��)        
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';  


        SELECT NVL(LAST_LEVEL_AMT_12, 0)
        INTO t_PRODUCT_AMT_12_PRE   --����_�⸻��ǰ����(12��)        
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';          
    END IF;    





--������, ����ϼ���, �����ϼ��� ���� �������������� ���Ͱ�꼭�� ����.

    --������ : �ڷᱸ��(M : ��, Q : �б�, H : �ݱ�, Y : ��)�� ���ۿ��� ����� ����
    IF    W_DATA_GB = 'M' THEN
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);
    ELSIF W_DATA_GB = 'Q' THEN  
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);        
    ELSIF W_DATA_GB = 'H' THEN
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);         
    ELSIF W_DATA_GB = 'Y' THEN   
        t_TERM_START_M  := '01';    --���
        t_TERM_END_M    := '02';    --����   
    END IF;        



    --���� �ڷḦ �����Ѵ�.
    DELETE FI_FS_IS_PARADE;


    --���Ͱ�꼭�� ��ȸ�ϱ� ���� �⺻Ʋ�� �����.
    INSERT INTO FI_FS_IS_PARADE(
          ITEM_NAME	            --����׸��
          
        , LAST_LEVEL_AMT_SUM    --�԰�_�����������׸�ݾ�
        , NON_LAST_AMT_SUM	    --�հ�_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_01	    --01��_�����������׸�ݾ�_1�б�, ��ݱ�, ���
        , NON_LAST_AMT_01	    --01��_�������ƴѷ����׸�ݾ�_1�б�, ��ݱ�, ���
        , LAST_LEVEL_AMT_02	    --02��_�����������׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NON_LAST_AMT_02	    --02��_�������ƴѷ����׸�ݾ�_2�б�, �Ϲݱ�, ����
        , LAST_LEVEL_AMT_03	    --03��_�����������׸�ݾ�_3�б�
        , NON_LAST_AMT_03	    --03��_�������ƴѷ����׸�ݾ�_3�б�
        , LAST_LEVEL_AMT_04	    --04��_�����������׸�ݾ�_4�б�
        , NON_LAST_AMT_04	    --04��_�������ƴѷ����׸�ݾ�_4�б�
        , LAST_LEVEL_AMT_05	    --05��_�����������׸�ݾ�
        , NON_LAST_AMT_05	    --05��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_06	    --06��_�����������׸�ݾ�
        , NON_LAST_AMT_06	    --06��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_07	    --07��_�����������׸�ݾ�
        , NON_LAST_AMT_07	    --07��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_08	    --08��_�����������׸�ݾ�
        , NON_LAST_AMT_08	    --08��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_09	    --09��_�����������׸�ݾ�
        , NON_LAST_AMT_09	    --09��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_10	    --10��_�����������׸�ݾ�
        , NON_LAST_AMT_10	    --10��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_11	    --11��_�����������׸�ݾ�
        , NON_LAST_AMT_11	    --11��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_12	    --12��_�����������׸�ݾ�
        , NON_LAST_AMT_12	    --12��_�������ƴѷ����׸�ݾ�          
        
        , ITEM_CODE	            --�׸��ڵ�_�����ڵ�
        , ACCOUNT_DR_CR         --���뱸��(1-����,2-�뺯)
        , SORT_SEQ	            --���ļ���
        , ITEM_LEVEL	        --�ݾװ�극��
        , ENABLED_FLAG	        --���(ǥ��)����
        , FORM_FRAME_YN	        --����Ʋ��������
        , REF_FORM_TYPE_ID      --���ú�����ľ��̵�
        , REF_ITEM_CODE         --�����׸��ڵ�
    )
    SELECT
          ITEM_NAME     --����׸��
          
        , NULL  --�԰�_�����������׸�ݾ�
        , NULL	--�հ�_�������ƴѷ����׸�ݾ�
        , NULL	--01��_�����������׸�ݾ�_1�б�, ��ݱ�, ���
        , NULL	--01��_�������ƴѷ����׸�ݾ�_1�б�, ��ݱ�, ���
        , NULL	--02��_�����������׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NULL	--02��_�������ƴѷ����׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NULL	--03��_�����������׸�ݾ�_3�б�
        , NULL	--03��_�������ƴѷ����׸�ݾ�_3�б�
        , NULL	--04��_�����������׸�ݾ�_4�б�
        , NULL	--04��_�������ƴѷ����׸�ݾ�_4�б�
        , NULL	--05��_�����������׸�ݾ�
        , NULL	--05��_�������ƴѷ����׸�ݾ�
        , NULL	--06��_�����������׸�ݾ�
        , NULL	--06��_�������ƴѷ����׸�ݾ�
        , NULL	--07��_�����������׸�ݾ�
        , NULL	--07��_�������ƴѷ����׸�ݾ�
        , NULL	--08��_�����������׸�ݾ�
        , NULL	--08��_�������ƴѷ����׸�ݾ�
        , NULL	--09��_�����������׸�ݾ�
        , NULL	--09��_�������ƴѷ����׸�ݾ�
        , NULL	--10��_�����������׸�ݾ�
        , NULL	--10��_�������ƴѷ����׸�ݾ�
        , NULL	--11��_�����������׸�ݾ�
        , NULL	--11��_�������ƴѷ����׸�ݾ�
        , NULL	--12��_�����������׸�ݾ�
        , NULL	--12��_�������ƴѷ����׸�ݾ�      
        
        , ITEM_CODE     --�׸��ڵ�_�����ڵ� 
        , ACCOUNT_DR_CR --���뱸��(1-����,2-�뺯)
        , SORT_SEQ      --���ļ���
        , ITEM_LEVEL    --�ݾװ�극��
        
        --N�� �ڷ�� �ݾװ�� �ÿ��� ��������, ������ �������� �ȵ� �׸��̴�.
        --��, N�� �ڷ�� �ݾװ���� ������ ���� �̷����� ü�踦 �����ϱ� ���� ������ �������� �׸��� ���̴�.
        , ENABLED_FLAG      --���(ǥ��)����
        
        --�ݾ��� ������ ������ �Ʒ� �׸��� 'Y'�� �׸��� ������ Ʋ�� �����ϱ� ���� ������ ��µǾ�� �� �׸��̴�.
        , FORM_FRAME_YN	        --����Ʋ��������
        , REF_FORM_TYPE_ID      --���ú�����ľ��̵�
        , REF_ITEM_CODE         --�����׸��ڵ�        
    FROM FI_FORM_MST                        --�繫��ǥ�������_������
    WHERE SOB_ID = W_SOB_ID                 --ȸ����̵�
        AND ORG_ID = W_ORG_ID               --����ξ��̵�
        AND FS_SET_ID = W_FS_SET_ID         --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID = t_FORM_TYPE_ID   --�������ID(�����ڵ�)
    ORDER BY SORT_SEQ    
    ;



--2�ܰ�>������������ �ݾ��� ���Ѵ�.
--��ȸ ���ۿ��� ���ʻ�ǰ������ �����ϱ� ���ؼ� �Ʒ� ���� �����Ѵ�.
    IF W_DATA_GB = 'M' AND t_TERM_START_M <> '01' THEN                
    
        FOR REPEAT_MATERIAL IN 1..(t_TERM_START_M - 1) LOOP

            t_REPEAT := LPAD(REPEAT_MATERIAL, 2, 0);

            --����ϼ��� : ����� �����ϰ� ������ ����
            t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM');     --��������
            t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM'));    --��������� 


            --�Ⱓ���� �ش� ������ �ݾ��� �а��ڷῡ�� ���Ѵ�. 
            FI_FS_SLIP_G.CREATE_FS_SLIP(
                  W_SOB_ID
                , W_ORG_ID
                , W_FS_SET_ID
                , t_FORM_TYPE_ID
                , t_LAST_ITEM_LEVEL
                , t_PERIOD_FROM
                , t_PERIOD_TO   );


            --����׸�� : ����ǰ���Ծ�(4)
            SELECT          
                  ITEM_CODE	    --�׸��ڵ�
                , ACCOUNT_DR_CR	--���뱸��(1-����,2-�뺯)
            INTO t_ITEM_CODE, t_ACCOUNT_DR_CR
            FROM FI_FS_IS_PARADE
            WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL AND ITEM_CODE = '4'    ;
            
            --���� �ʱ�ȭ
            t_THIS_LAST_LEVEL_AMT       := 0;   --���_�����������׸�ݾ�

            IF t_ACCOUNT_DR_CR = '1' THEN      --�ش� ������ ���������̸�
                SELECT SUM(DR_AMT) - SUM(CR_AMT) AS AMT
                INTO t_THIS_LAST_LEVEL_AMT
                FROM FI_FS_SLIP
                WHERE ITEM_CODE = t_ITEM_CODE
                GROUP BY ITEM_CODE;
            ELSIF t_ACCOUNT_DR_CR = '2' THEN   --�ش� ������ �뺯�����̸�
                SELECT SUM(CR_AMT) - SUM(DR_AMT) AS AMT
                INTO t_THIS_LAST_LEVEL_AMT
                FROM FI_FS_SLIP
                WHERE ITEM_CODE = t_ITEM_CODE
                GROUP BY ITEM_CODE;                
            END IF; 

            --�ش� Į���� ���� UPDATE�Ѵ�.
            UPDATE_AMT(t_REPEAT, t_THIS_LAST_LEVEL_AMT, t_ITEM_CODE );

        END LOOP REPEAT_MATERIAL;     
    END IF;




--2�ܰ�>������������ �ݾ��� ���Ѵ�.
--��, ���ʻ�ǰ����(3), �⸻��ǰ����(5), ������ǰ����(6), �����ǰ��������(7), �⸻��ǰ����(8)�� 5�� �׸���
--�ݾװ�극���� �����ϰ� ���׸��� �̿��ؼ� �ݾ��� �������� �ʴ´�.

--������������ �ݾ��� �� ������ ���̴�. �Ͽ�, ���� �繫��ǥ����� �����ȣ�� �������� �ʴ´�.
--����, ���������� �׸��� �� �׸� ���� �繫��ǥ����� �����ȣ�� [+]�� �ƴ� �� ���� ���� �̸� �����ؾ� �Ѵ�.

    --�Ʒ� IF ��[IF W_DATA_GB IS NOT NULL THEN]�� ��� ���ǹ��ѵ� ������ ���� FRAMEWORK���� 
    --�� �κ�FOR REPEAT IN t_TERM_START_M..t_TERM_END_M LOOP]�� �ݿ��� �־� ������ �־� ���ʿ��ϰ� �߰��� ���̴�.
    IF W_DATA_GB IS NOT NULL THEN
        FOR REPEAT IN t_TERM_START_M..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT, 2, 0);
            
            
            --����ϼ��� : ����� �����ϰ� ������ ����
            IF    W_DATA_GB = 'M' THEN
                t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM');
                t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM'));
            ELSIF W_DATA_GB = 'Q' THEN
                IF    t_REPEAT = '01' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '01', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '03', 'YYYY-MM'));
                ELSIF t_REPEAT = '02' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '04', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '06', 'YYYY-MM'));
                ELSIF t_REPEAT = '03' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '07', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '09', 'YYYY-MM'));
                ELSIF t_REPEAT = '04' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '10', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '12', 'YYYY-MM'));
                END IF;
            ELSIF W_DATA_GB = 'H' THEN
                IF    t_REPEAT = '01' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '01', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '06', 'YYYY-MM'));
                ELSIF t_REPEAT = '02' THEN
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '07', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '12', 'YYYY-MM'));
                END IF;
            ELSIF W_DATA_GB = 'Y' THEN
                IF    t_REPEAT = '01' THEN
                    --t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || '01', 'YYYY-MM');
                    --t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || '12', 'YYYY-MM'));
                    
                    t_PERIOD_FROM   := TO_DATE(         W_CLOSING_START, 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_END, 'YYYY-MM'));                     
                ELSIF t_REPEAT = '02' THEN
                    t_PERIOD_FROM   := TO_DATE(         (W_CLOSING_YEAR - 1) || '01', 'YYYY-MM');
                    t_PERIOD_TO     := LAST_DAY(TO_DATE((W_CLOSING_YEAR - 1) || '12', 'YYYY-MM'));
                END IF;        
            END IF;



            --�Ⱓ���� �ش� ������ �ݾ��� �а��ڷῡ�� ���Ѵ�. 
            FI_FS_SLIP_G.CREATE_FS_SLIP(
                  W_SOB_ID
                , W_ORG_ID
                , W_FS_SET_ID
                , t_FORM_TYPE_ID
                , t_LAST_ITEM_LEVEL
                , t_PERIOD_FROM
                , t_PERIOD_TO   );


            --3 : ���ʻ�ǰ����, 5 : �⸻��ǰ����, 
            --6 : ������ǰ����, 7 : �����ǰ��������, 8 : �⸻��ǰ����
            FOR LAST_LEVEL_REC IN (
                SELECT          
                      ITEM_CODE	    --�׸��ڵ�
                    , ACCOUNT_DR_CR	--���뱸��(1-����,2-�뺯)
                FROM FI_FS_IS_PARADE
                WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL
                    AND (ITEM_CODE NOT IN ('3', '5', '6', '7', '8') )
            ) LOOP
        
                --DBMS_OUTPUT.PUT_LINE('�׸��ڵ� : ' || LAST_LEVEL_REC.ITEM_CODE);        
                
                t_THIS_LAST_LEVEL_AMT       := 0;   --���_�����������׸�ݾ�

                IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --�ش� ������ ���������̸�
                    BEGIN
                      SELECT SUM(DR_AMT) - SUM(CR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;
                ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --�ش� ������ �뺯�����̸�
                    BEGIN
                      SELECT SUM(CR_AMT) - SUM(DR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;  
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;              
                END IF;              


                --�ش� Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_THIS_LAST_LEVEL_AMT, LAST_LEVEL_REC.ITEM_CODE );
                
            END LOOP LAST_LEVEL_REC;      

        END LOOP REPEAT; 
        
    END IF;






--2�ܰ�>���ʻ�ǰ����(3), �⸻��ǰ����(5), ������ǰ����(6), �⸻��ǰ����(8), �����ǰ��������(7)�� �׸� �ݾ� ����
--�� �׸��� ()�ȿ� ����ִ� ���� �ش� �׸�鿡 ���� �繫��ǥ��İ����� ������ �׸��ڵ��̴�.

--�Ʒ� FOR���� ���μ��� �� ������ ������ �����ϰ� �ݺ����̴�. �Ⱓ�� Į���� Ʋ���� ������ �� ���̴�.

    IF    W_DATA_GB = 'M' THEN
    
        --������ �����ǰ��������(9)�� �����ϱ� ���� �������������� �����Ѵ�.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );



        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF t_REPEAT = '01' THEN               
                
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');                    
            

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_RAW_AMT;    --����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.
                
                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� ���� ������ǰ���׿� �̿��ϱ� ����.
            
            ELSIF t_REPEAT = '02' THEN
                --2�� ~ 12�� ������ ����/�⸻ ��ǰ�ݾ� �������� ��� ����.
                                       
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.
                
                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� ���� ������ǰ���׿� �̿��ϱ� ����.
                
            ELSIF t_REPEAT = '03' THEN 
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.
                


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_03, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --�⸻��ǰ����(8) Į���� ���� UPDATE�Ѵ�.
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                    
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� ���� ������ǰ���׿� �̿��ϱ� ����.   

            ELSIF t_REPEAT = '04' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_04, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                

            ELSIF t_REPEAT = '05' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_05, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                  

            ELSIF t_REPEAT = '06' THEN
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.
                


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_06, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '07' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_07, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                  
                
            ELSIF t_REPEAT = '08' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_08, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );     

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '09' THEN
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_09, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '10' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)


                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_10, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '11' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)
                

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_11, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );               


                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL; 
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                                                                    

            ELSIF t_REPEAT = '12' THEN
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)
                
                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_12, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );                  


                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                --t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            END IF;

        END LOOP REPEAT_INVENTORY;


    ELSIF W_DATA_GB = 'Q' THEN
        
        --�� �б��� �����ǰ��������(9)�� �����ϱ� ���� �������������� �����Ѵ�.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );               

        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF    t_REPEAT = '01' THEN --1/4�б�
                           
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_AMT := t_ITEM_AMT_03;   --�⸻��ǰ����(03��)


                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� �б��� ���ʻ�ǰ���׿� �̿��ϱ� ����.


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --�⸻��ǰ����(8)�� ���Ѵ�.
                t_TERM_END_AMT := t_PRODUCT_AMT_03;   --�⸻��ǰ����(03��)
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� �б��� ������ǰ���׿� �̿��ϱ� ����.  
                
            ELSIF t_REPEAT = '02' THEN --2/4�б�
                           
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_AMT := t_ITEM_AMT_06;   --�⸻��ǰ����(06��)

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� �б��� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --�⸻��ǰ����(8)�� ���Ѵ�.
                t_TERM_END_AMT := t_PRODUCT_AMT_06;   --�⸻��ǰ����(06��)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� �б��� ������ǰ���׿� �̿��ϱ� ����. 
                            
            ELSIF t_REPEAT = '03' THEN --3/4�б�
                           
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_AMT := t_ITEM_AMT_09;   --�⸻��ǰ����(09��)

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� �б��� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)


                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_03, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );     

                --�⸻��ǰ����(8)�� ���Ѵ�.
                t_TERM_END_AMT := t_PRODUCT_AMT_09;   --�⸻��ǰ����(09��)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� �б��� ������ǰ���׿� �̿��ϱ� ����. 
                
            ELSIF t_REPEAT = '04' THEN --4/4�б�
                           
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_AMT := t_ITEM_AMT_12;   --�⸻��ǰ����(12��)

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_04, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --�⸻��ǰ����(8)�� ���Ѵ�.
                t_TERM_END_AMT := t_PRODUCT_AMT_12;   --�⸻��ǰ����(12��)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
            
            END IF;

        END LOOP REPEAT_INVENTORY;

    ELSIF W_DATA_GB = 'H' THEN
    
        --�� �ݱ��� �����ǰ��������(9)�� �����ϱ� ���� �������������� �����Ѵ�.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );                

        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF    t_REPEAT = '01' THEN --��ݱ�
                                       
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_AMT := t_ITEM_AMT_06;   --�⸻��ǰ����(06��)

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� �ݱ��� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --�⸻��ǰ����(8)�� ���Ѵ�.
                t_TERM_END_AMT := t_PRODUCT_AMT_06;   --�⸻��ǰ����(06��)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� �ݱ��� ������ǰ���׿� �̿��ϱ� ����. 
                           
            ELSIF t_REPEAT = '02' THEN --�Ϲݱ�
                                       
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_AMT := t_ITEM_AMT_12;   --�⸻��ǰ����(12��)

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 

                --�⸻��ǰ����(8)�� ���Ѵ�.
                t_TERM_END_AMT := t_PRODUCT_AMT_12;   --�⸻��ǰ����(12��)

                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
           
            END IF;
    
        END LOOP REPEAT_INVENTORY;    


    ELSIF W_DATA_GB = 'Y' THEN
    
        --���� �����ǰ��������(9)�� �����ϱ� ���� �������������� �����Ѵ�.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );               


    --���                  
        
        --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
        UPDATE_AMT('01', t_FORWARD_RAW_AMT, '3' );        


        --�⸻��ǰ����(5) 
        --t_TERM_END_AMT := t_ITEM_AMT_12;   --�⸻��ǰ����(12��)
                
        t_WORK_MM := LPAD(SUBSTR(W_CLOSING_END, 6, 2), 2, 0);
        
        IF t_WORK_MM = '01' THEN
            t_TERM_END_AMT := t_ITEM_AMT_01;
        ELSIF t_WORK_MM = '02' THEN
            t_TERM_END_AMT := t_ITEM_AMT_02;            
        ELSIF t_WORK_MM = '03' THEN
            t_TERM_END_AMT := t_ITEM_AMT_03;
        ELSIF t_WORK_MM = '04' THEN
            t_TERM_END_AMT := t_ITEM_AMT_04;
        ELSIF t_WORK_MM = '05' THEN
            t_TERM_END_AMT := t_ITEM_AMT_05;
        ELSIF t_WORK_MM = '06' THEN
            t_TERM_END_AMT := t_ITEM_AMT_06;
        ELSIF t_WORK_MM = '07' THEN
            t_TERM_END_AMT := t_ITEM_AMT_07;
        ELSIF t_WORK_MM = '08' THEN
            t_TERM_END_AMT := t_ITEM_AMT_08;
        ELSIF t_WORK_MM = '09' THEN
            t_TERM_END_AMT := t_ITEM_AMT_09;
        ELSIF t_WORK_MM = '10' THEN
            t_TERM_END_AMT := t_ITEM_AMT_10;
        ELSIF t_WORK_MM = '11' THEN
            t_TERM_END_AMT := t_ITEM_AMT_11;
        ELSIF t_WORK_MM = '12' THEN
            t_TERM_END_AMT := t_ITEM_AMT_12;            
        END IF;        
        
        

        --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
        UPDATE_AMT('01', t_TERM_END_AMT, '5' );




        --������ǰ����(6) ���� UPDATE�Ѵ�.
        UPDATE_AMT('01', t_FORWARD_LINE_AMT, '6' );

        --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.
        SELECT NVL(NON_LAST_AMT_01, 0)
        INTO t_ITEM_COST
        FROM FI_FS_FACTORY_COST_PARADE
        WHERE ITEM_CODE = '9';  --�����ǰ��������
            
        UPDATE_AMT('01', t_ITEM_COST, '7' ); 


        --�⸻��ǰ����(8)�� ���Ѵ�.
        --t_TERM_END_LINE_AMT := t_PRODUCT_AMT_12;   --�⸻��ǰ����(12��)       
        
        IF t_WORK_MM = '01' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_01;
        ELSIF t_WORK_MM = '02' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_02;
        ELSIF t_WORK_MM = '03' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_03;
        ELSIF t_WORK_MM = '04' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_04;
        ELSIF t_WORK_MM = '05' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_05;
        ELSIF t_WORK_MM = '06' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_06;
        ELSIF t_WORK_MM = '07' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_07;
        ELSIF t_WORK_MM = '08' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_08;
        ELSIF t_WORK_MM = '09' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_09;
        ELSIF t_WORK_MM = '10' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_10;
        ELSIF t_WORK_MM = '11' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_11;
        ELSIF t_WORK_MM = '12' THEN
            t_TERM_END_LINE_AMT := t_PRODUCT_AMT_12;
        END IF;         
        

        UPDATE_AMT('01', t_TERM_END_LINE_AMT, '8' );    --�⸻��ǰ����(8)



    --����
    
        --����>������ ���� �⿡ ���õ� �κ��� ��� [(W_CLOSING_YEAR - 1)] �̴�.

        --�����̿��� ��ǰ�ݾ��� �����Ͽ� ���ʻ�ǰ���׿� ����Ѵ�.
        t_INVENTORY_AMOUNT := 0;
                
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_INVENTORY_AMOUNT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --��ǥ���� : '�����ܾ��̿�-BLS'
            AND PERIOD_NAME = (W_CLOSING_YEAR - 1) || '-01'  --'2010-01'
            AND ACCOUNT_CODE IN('1120200', '1120201', '1120202', '1120203')    --1120200 : ��ǰ
        ;
        
        --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
        UPDATE_AMT('02', t_INVENTORY_AMOUNT, '3' );                  


        --�⸻��ǰ����(5)
        t_TERM_END_AMT := t_ITEM_AMT_12_PRE;   --����_�⸻��ǰ����(12��)
        
        --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
        UPDATE_AMT('02', t_TERM_END_AMT, '5' );
        



        --�����̿��� ��ǰ�ݾ��� �����Ͽ� ������ǰ���׿� ����Ѵ�.
        t_INVENTORY_AMOUNT := 0;
         
        SELECT NVL(SUM(GL_AMOUNT), 0)
        INTO t_INVENTORY_AMOUNT
        FROM FI_SLIP_LINE
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE = 'BLS'   --��ǥ���� : '�����ܾ��̿�-BLS'
            AND PERIOD_NAME = (W_CLOSING_YEAR - 1) || '-01'  --'2010-01'
            AND ACCOUNT_CODE = '1120100'    --1120100 : ��ǰ  
        ;
                
        --������ǰ����(6) ���� UPDATE�Ѵ�.
        UPDATE_AMT('02', t_INVENTORY_AMOUNT, '6' );        
        
        --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.
        SELECT NVL(NON_LAST_AMT_02, 0)
        INTO t_ITEM_COST
        FROM FI_FS_FACTORY_COST_PARADE
        WHERE ITEM_CODE = '9';  --�����ǰ��������
            
        UPDATE_AMT('02', t_ITEM_COST, '7' ); 

        --�⸻��ǰ����(8)�� ���Ѵ�.        
        t_TERM_END_LINE_AMT := t_PRODUCT_AMT_12_PRE;   --����_�⸻��ǰ����(12��)

        UPDATE_AMT('02', t_TERM_END_LINE_AMT, '8' );
        
    END IF;









--������ʹ� ������� �ڷḦ �������� ȭ�鿡 �����ֱ� ���� �ڷḦ �����ϴ� �����̴�.




--��ȸ���ۿ��� 1���� �ƴ� ��� 1�� ���� ��ȸ���ۿ� ���������� �ڷḦ �����.
--CLEAR ��� �׸� : ���ʻ�ǰ����(3), ����ǰ���Ծ�(4),�⸻��ǰ����(5), 
--                  ������ǰ����(6), �����ǰ��������(7), �⸻��ǰ����(8), 
    IF W_DATA_GB = 'M' THEN
        IF t_TERM_START_M = '01' THEN
            NULL;
        ELSE
            IF t_TERM_START_M = '02' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '03' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '04' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '05' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL              
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '06' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '07' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '08' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL             
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '09' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL            
               WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '10' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL 
                    , LAST_LEVEL_AMT_09 = NULL
                    , NON_LAST_AMT_09   = NULL             
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '11' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL 
                    , LAST_LEVEL_AMT_09 = NULL
                    , NON_LAST_AMT_09   = NULL
                    , LAST_LEVEL_AMT_10 = NULL
                    , NON_LAST_AMT_10   = NULL            
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            ELSIF t_TERM_START_M = '12' THEN
                UPDATE FI_FS_IS_PARADE
                SET   LAST_LEVEL_AMT_01 = NULL
                    , NON_LAST_AMT_01   = NULL
                    , LAST_LEVEL_AMT_02 = NULL
                    , NON_LAST_AMT_02   = NULL
                    , LAST_LEVEL_AMT_03 = NULL
                    , NON_LAST_AMT_03   = NULL  
                    , LAST_LEVEL_AMT_04 = NULL
                    , NON_LAST_AMT_04   = NULL
                    , LAST_LEVEL_AMT_05 = NULL
                    , NON_LAST_AMT_05   = NULL
                    , LAST_LEVEL_AMT_06 = NULL
                    , NON_LAST_AMT_06   = NULL 
                    , LAST_LEVEL_AMT_07 = NULL
                    , NON_LAST_AMT_07   = NULL
                    , LAST_LEVEL_AMT_08 = NULL
                    , NON_LAST_AMT_08   = NULL 
                    , LAST_LEVEL_AMT_09 = NULL
                    , NON_LAST_AMT_09   = NULL
                    , LAST_LEVEL_AMT_10 = NULL
                    , NON_LAST_AMT_10   = NULL 
                    , LAST_LEVEL_AMT_11 = NULL
                    , NON_LAST_AMT_11   = NULL             
                WHERE ITEM_CODE IN ('3', '4', '5', '6', '7', '8');
            END IF;
        END IF;
    END IF;





--4�ܰ�>������������ �ƴ� �׸�鿡 ���� �ݾ��� ���Ѵ�.
--�ݾװ�극���� ū �� ���� ���������� �ݾ��� ���Ѵ�. ��>2���� ���� 1���� ����
    FOR NO_LAST_REC IN (
        SELECT ITEM_CODE    --�׸��ڵ�
        FROM FI_FS_IS_PARADE
        WHERE ITEM_LEVEL < t_LAST_ITEM_LEVEL
        ORDER BY ITEM_LEVEL DESC
    ) LOOP

        --���� �ʱ�ȭ
        t_LAST_LEVEL_AMT_01         := 0;   --01��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_01_CALC    := 0;   --01��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_02         := 0;   --02��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_02_CALC    := 0;   --02��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_03         := 0;   --03��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_03_CALC    := 0;   --03��_�����������׸�ݾ� ���踦 ���� ����        
        t_LAST_LEVEL_AMT_04         := 0;   --04��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_04_CALC    := 0;   --04��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_05         := 0;   --05��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_05_CALC    := 0;   --05��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_06         := 0;   --06��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_06_CALC    := 0;   --06��_�����������׸�ݾ� ���踦 ���� ���� 
        t_LAST_LEVEL_AMT_07         := 0;   --07��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_07_CALC    := 0;   --07��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_08         := 0;   --08��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_08_CALC    := 0;   --08��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_09         := 0;   --09��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_09_CALC    := 0;   --09��_�����������׸�ݾ� ���踦 ���� ���� 
        t_LAST_LEVEL_AMT_10         := 0;   --10��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_10_CALC    := 0;   --10��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_11         := 0;   --11��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_11_CALC    := 0;   --11��_�����������׸�ݾ� ���踦 ���� ����
        t_LAST_LEVEL_AMT_12         := 0;   --12��_�����������׸�ݾ�
        t_LAST_LEVEL_AMT_12_CALC    := 0;   --12��_�����������׸�ݾ� ���踦 ���� ����         
        

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
        
            SELECT NVL(LAST_LEVEL_AMT_01, 0)
                ,  NVL(LAST_LEVEL_AMT_02, 0)
                ,  NVL(LAST_LEVEL_AMT_03, 0)
                ,  NVL(LAST_LEVEL_AMT_04, 0)
                ,  NVL(LAST_LEVEL_AMT_05, 0)
                ,  NVL(LAST_LEVEL_AMT_06, 0)
                ,  NVL(LAST_LEVEL_AMT_07, 0)
                ,  NVL(LAST_LEVEL_AMT_08, 0)
                ,  NVL(LAST_LEVEL_AMT_09, 0)
                ,  NVL(LAST_LEVEL_AMT_10, 0)
                ,  NVL(LAST_LEVEL_AMT_11, 0)
                ,  NVL(LAST_LEVEL_AMT_12, 0)                
            INTO  t_LAST_LEVEL_AMT_01_CALC 
                , t_LAST_LEVEL_AMT_02_CALC 
                , t_LAST_LEVEL_AMT_03_CALC 
                , t_LAST_LEVEL_AMT_04_CALC 
                , t_LAST_LEVEL_AMT_05_CALC 
                , t_LAST_LEVEL_AMT_06_CALC 
                , t_LAST_LEVEL_AMT_07_CALC 
                , t_LAST_LEVEL_AMT_08_CALC 
                , t_LAST_LEVEL_AMT_09_CALC 
                , t_LAST_LEVEL_AMT_10_CALC 
                , t_LAST_LEVEL_AMT_11_CALC 
                , t_LAST_LEVEL_AMT_12_CALC 
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = CALC_REC.DET_ITEM_CODE
            ;
            
            t_LAST_LEVEL_AMT_01 := t_LAST_LEVEL_AMT_01 + (t_LAST_LEVEL_AMT_01_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_02 := t_LAST_LEVEL_AMT_02 + (t_LAST_LEVEL_AMT_02_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_03 := t_LAST_LEVEL_AMT_03 + (t_LAST_LEVEL_AMT_03_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_04 := t_LAST_LEVEL_AMT_04 + (t_LAST_LEVEL_AMT_04_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_05 := t_LAST_LEVEL_AMT_05 + (t_LAST_LEVEL_AMT_05_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_06 := t_LAST_LEVEL_AMT_06 + (t_LAST_LEVEL_AMT_06_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_07 := t_LAST_LEVEL_AMT_07 + (t_LAST_LEVEL_AMT_07_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_08 := t_LAST_LEVEL_AMT_08 + (t_LAST_LEVEL_AMT_08_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_09 := t_LAST_LEVEL_AMT_09 + (t_LAST_LEVEL_AMT_09_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_10 := t_LAST_LEVEL_AMT_10 + (t_LAST_LEVEL_AMT_10_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_11 := t_LAST_LEVEL_AMT_11 + (t_LAST_LEVEL_AMT_11_CALC * CALC_REC.ITEM_SIGN_SHOW);
            t_LAST_LEVEL_AMT_12 := t_LAST_LEVEL_AMT_12 + (t_LAST_LEVEL_AMT_12_CALC * CALC_REC.ITEM_SIGN_SHOW);

        END LOOP CALC_REC; 
        
        
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_01 = t_LAST_LEVEL_AMT_01
            , LAST_LEVEL_AMT_02 = t_LAST_LEVEL_AMT_02
            , LAST_LEVEL_AMT_03 = t_LAST_LEVEL_AMT_03
            , LAST_LEVEL_AMT_04 = t_LAST_LEVEL_AMT_04
            , LAST_LEVEL_AMT_05 = t_LAST_LEVEL_AMT_05
            , LAST_LEVEL_AMT_06 = t_LAST_LEVEL_AMT_06
            , LAST_LEVEL_AMT_07 = t_LAST_LEVEL_AMT_07
            , LAST_LEVEL_AMT_08 = t_LAST_LEVEL_AMT_08
            , LAST_LEVEL_AMT_09 = t_LAST_LEVEL_AMT_09
            , LAST_LEVEL_AMT_10 = t_LAST_LEVEL_AMT_10
            , LAST_LEVEL_AMT_11 = t_LAST_LEVEL_AMT_11
            , LAST_LEVEL_AMT_12 = t_LAST_LEVEL_AMT_12
        WHERE ITEM_CODE = NO_LAST_REC.ITEM_CODE;         
            
    END LOOP NO_LAST_REC;







--5�ܰ�> �������� �ƴ� �׸���� �ڷḦ �����Ѵ�.
--�������� �ƴ� �׸���� �� ���� �� �Ⱓ�� 2��° Į���� ������ �Ѵ�.

    FOR NO_LAST_REC_ADJUST IN (
        SELECT ITEM_CODE    --�׸��ڵ�
        FROM FI_FS_IS_PARADE
        WHERE ITEM_LEVEL < t_LAST_ITEM_LEVEL
        ORDER BY ITEM_LEVEL DESC
    ) LOOP
        
        --�� �Ⱓ�� �������� �ƴ� ������ ���� �����Ѵ�.
        UPDATE FI_FS_IS_PARADE
        SET   NON_LAST_AMT_01 = LAST_LEVEL_AMT_01
            , NON_LAST_AMT_02 = LAST_LEVEL_AMT_02
            , NON_LAST_AMT_03 = LAST_LEVEL_AMT_03
            , NON_LAST_AMT_04 = LAST_LEVEL_AMT_04
            , NON_LAST_AMT_05 = LAST_LEVEL_AMT_05
            , NON_LAST_AMT_06 = LAST_LEVEL_AMT_06
            , NON_LAST_AMT_07 = LAST_LEVEL_AMT_07
            , NON_LAST_AMT_08 = LAST_LEVEL_AMT_08
            , NON_LAST_AMT_09 = LAST_LEVEL_AMT_09
            , NON_LAST_AMT_10 = LAST_LEVEL_AMT_10
            , NON_LAST_AMT_11 = LAST_LEVEL_AMT_11
            , NON_LAST_AMT_12 = LAST_LEVEL_AMT_12
        WHERE ITEM_CODE = NO_LAST_REC_ADJUST.ITEM_CODE;
        
        --�� �Ⱓ�� �������� �ƴ� ������ �׸�鿡 ���� ������ ���� CLEAR�Ѵ�.
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_01 = NULL
            , LAST_LEVEL_AMT_02 = NULL
            , LAST_LEVEL_AMT_03 = NULL
            , LAST_LEVEL_AMT_04 = NULL
            , LAST_LEVEL_AMT_05 = NULL
            , LAST_LEVEL_AMT_06 = NULL
            , LAST_LEVEL_AMT_07 = NULL
            , LAST_LEVEL_AMT_08 = NULL
            , LAST_LEVEL_AMT_09 = NULL
            , LAST_LEVEL_AMT_10 = NULL
            , LAST_LEVEL_AMT_11 = NULL
            , LAST_LEVEL_AMT_12 = NULL
        WHERE ITEM_CODE = NO_LAST_REC_ADJUST.ITEM_CODE;           

    END LOOP NO_LAST_REC_ADJUST;







--��ȸ�� �ڷ��� �հ�ݾ��� UPDATE�Ѵ�.
--��, ���ʻ�ǰ����(3), �⸻��ǰ����(5), ������ǰ����(6), �⸻��ǰ����(8)�� �׸��� �ٸ���.
    UPDATE FI_FS_IS_PARADE
    SET LAST_LEVEL_AMT_SUM = 
            (   
                  NVL(LAST_LEVEL_AMT_01, 0) + NVL(NON_LAST_AMT_01, 0)
                + NVL(LAST_LEVEL_AMT_02, 0) + NVL(NON_LAST_AMT_02, 0) 
                + NVL(LAST_LEVEL_AMT_03, 0) + NVL(NON_LAST_AMT_03, 0)
                + NVL(LAST_LEVEL_AMT_04, 0) + NVL(NON_LAST_AMT_04, 0)
                + NVL(LAST_LEVEL_AMT_05, 0) + NVL(NON_LAST_AMT_05, 0)
                + NVL(LAST_LEVEL_AMT_06, 0) + NVL(NON_LAST_AMT_06, 0)
                + NVL(LAST_LEVEL_AMT_07, 0) + NVL(NON_LAST_AMT_07, 0)
                + NVL(LAST_LEVEL_AMT_08, 0) + NVL(NON_LAST_AMT_08, 0)
                + NVL(LAST_LEVEL_AMT_09, 0) + NVL(NON_LAST_AMT_09, 0)
                + NVL(LAST_LEVEL_AMT_10, 0) + NVL(NON_LAST_AMT_10, 0)
                + NVL(LAST_LEVEL_AMT_11, 0) + NVL(NON_LAST_AMT_11, 0)
                + NVL(LAST_LEVEL_AMT_12, 0) + NVL(NON_LAST_AMT_12, 0)
            )
        , NON_LAST_AMT_SUM =
            (   
                  NVL(LAST_LEVEL_AMT_01, 0) + NVL(NON_LAST_AMT_01, 0)
                + NVL(LAST_LEVEL_AMT_02, 0) + NVL(NON_LAST_AMT_02, 0) 
                + NVL(LAST_LEVEL_AMT_03, 0) + NVL(NON_LAST_AMT_03, 0)
                + NVL(LAST_LEVEL_AMT_04, 0) + NVL(NON_LAST_AMT_04, 0)
                + NVL(LAST_LEVEL_AMT_05, 0) + NVL(NON_LAST_AMT_05, 0)
                + NVL(LAST_LEVEL_AMT_06, 0) + NVL(NON_LAST_AMT_06, 0)
                + NVL(LAST_LEVEL_AMT_07, 0) + NVL(NON_LAST_AMT_07, 0)
                + NVL(LAST_LEVEL_AMT_08, 0) + NVL(NON_LAST_AMT_08, 0)
                + NVL(LAST_LEVEL_AMT_09, 0) + NVL(NON_LAST_AMT_09, 0)
                + NVL(LAST_LEVEL_AMT_10, 0) + NVL(NON_LAST_AMT_10, 0)
                + NVL(LAST_LEVEL_AMT_11, 0) + NVL(NON_LAST_AMT_11, 0)
                + NVL(LAST_LEVEL_AMT_12, 0) + NVL(NON_LAST_AMT_12, 0)
            )
    WHERE ITEM_CODE NOT IN ('3', '5', '6', '8')
    ;


--��ȸ�� �ڷ��� �հ�ݾ��� UPDATE�Ѵ�.    
--��, ���ʻ�ǰ����(3), �⸻��ǰ����(5), ������ǰ����(6), �⸻��ǰ����(8)�� �׸��� �ٸ���.
--�׷���, �հ�� ���� ��츸 ���̱� ������ �б�/�ݱ�/���� ���� �� Ʋ���� �ݾ��� ���� �� �ִµ�, �˸鼭�� ���� ���Ѵ�.

    IF W_DATA_GB = 'M' THEN 


        --���ʻ�ǰ����(3) 
        IF t_TERM_START_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        ELSIF t_TERM_START_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '3';
            
        END IF;        
        
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '3'   ;
        
        
        
        --�⸻��ǰ����(5)
        IF t_TERM_END_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        ELSIF t_TERM_END_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '5';
            
        END IF;
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '5'   ;
 
 
 
 
 
 
        --������ǰ����(6)
        IF t_TERM_START_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        ELSIF t_TERM_START_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '6';
            
        END IF;
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '6'   ;
        
 
 
 
 
        --�⸻��ǰ����(8)
        IF t_TERM_END_M = '01' THEN
            SELECT LAST_LEVEL_AMT_01
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '02' THEN    
            SELECT LAST_LEVEL_AMT_02
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '03' THEN    
            SELECT LAST_LEVEL_AMT_03
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '04' THEN    
            SELECT LAST_LEVEL_AMT_04
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '05' THEN    
            SELECT LAST_LEVEL_AMT_05
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '06' THEN    
            SELECT LAST_LEVEL_AMT_06
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '07' THEN    
            SELECT LAST_LEVEL_AMT_07
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '08' THEN    
            SELECT LAST_LEVEL_AMT_08
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '09' THEN    
            SELECT LAST_LEVEL_AMT_09
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '10' THEN    
            SELECT LAST_LEVEL_AMT_10
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '11' THEN    
            SELECT LAST_LEVEL_AMT_11
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        ELSIF t_TERM_END_M = '12' THEN    
            SELECT LAST_LEVEL_AMT_12
            INTO t_INVENTORY_AMOUNT
            FROM FI_FS_IS_PARADE
            WHERE ITEM_CODE = '8';
            
        END IF;
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '8'   ;

    ELSIF W_DATA_GB = 'Q' THEN
 
        --���ʻ�ǰ����(3)
        SELECT LAST_LEVEL_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '3'   ; 
            
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '3'   ;
        
                
        --�⸻��ǰ����(5)
        SELECT LAST_LEVEL_AMT_04
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '5'   ;
        
             
        --������ǰ����(6)
        SELECT NON_LAST_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '6';
                        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '6'   ;
        
        
        --�⸻��ǰ����(8)
        SELECT NON_LAST_AMT_04
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '8'   ;        
    
    ELSIF W_DATA_GB = 'H' THEN
    
        --���ʻ�ǰ����(3)
        SELECT LAST_LEVEL_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '3'   ; 
            
        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '3'   ;
        
                
        --�⸻��ǰ����(5)
        SELECT LAST_LEVEL_AMT_02
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '5';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '5'   ;
        
        
        --������ǰ����(6)
        SELECT NON_LAST_AMT_01
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '6';
                        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '6'   ;
        
        
        --�⸻��ǰ����(8)
        SELECT NON_LAST_AMT_02
        INTO t_INVENTORY_AMOUNT
        FROM FI_FS_IS_PARADE
        WHERE ITEM_CODE = '8';
        
        UPDATE FI_FS_IS_PARADE
        SET LAST_LEVEL_AMT_SUM = t_INVENTORY_AMOUNT
            , NON_LAST_AMT_SUM = t_INVENTORY_AMOUNT
        WHERE ITEM_CODE = '8'   ;  
    
    ELSIF W_DATA_GB = 'Y' THEN

        NULL;

    END IF;





    --�հ� �ݾ��� 0 �� �ڷḦ NULL�� �����Ѵ�.
    UPDATE FI_FS_IS_PARADE
    SET   LAST_LEVEL_AMT_SUM = DECODE(LAST_LEVEL_AMT_SUM, 0, NULL, LAST_LEVEL_AMT_SUM)
        , NON_LAST_AMT_SUM = DECODE(NON_LAST_AMT_SUM, 0, NULL, NON_LAST_AMT_SUM)        
        , LAST_LEVEL_AMT_01 = DECODE(LAST_LEVEL_AMT_01, 0, NULL, LAST_LEVEL_AMT_01)
        , NON_LAST_AMT_01 = DECODE(NON_LAST_AMT_01, 0, NULL, NON_LAST_AMT_01)
        , LAST_LEVEL_AMT_02 = DECODE(LAST_LEVEL_AMT_02, 0, NULL, LAST_LEVEL_AMT_02)
        , NON_LAST_AMT_02 = DECODE(NON_LAST_AMT_02, 0, NULL, NON_LAST_AMT_02)        
        , LAST_LEVEL_AMT_03 = DECODE(LAST_LEVEL_AMT_03, 0, NULL, LAST_LEVEL_AMT_03)
        , NON_LAST_AMT_03 = DECODE(NON_LAST_AMT_03, 0, NULL, NON_LAST_AMT_03)
        , LAST_LEVEL_AMT_04 = DECODE(LAST_LEVEL_AMT_04, 0, NULL, LAST_LEVEL_AMT_04)
        , NON_LAST_AMT_04 = DECODE(NON_LAST_AMT_04, 0, NULL, NON_LAST_AMT_04)
        , LAST_LEVEL_AMT_05 = DECODE(LAST_LEVEL_AMT_05, 0, NULL, LAST_LEVEL_AMT_05)
        , NON_LAST_AMT_05 = DECODE(NON_LAST_AMT_05, 0, NULL, NON_LAST_AMT_05)
        , LAST_LEVEL_AMT_06 = DECODE(LAST_LEVEL_AMT_06, 0, NULL, LAST_LEVEL_AMT_06)
        , NON_LAST_AMT_06 = DECODE(NON_LAST_AMT_06, 0, NULL, NON_LAST_AMT_06)
        , LAST_LEVEL_AMT_07 = DECODE(LAST_LEVEL_AMT_07, 0, NULL, LAST_LEVEL_AMT_07)
        , NON_LAST_AMT_07 = DECODE(NON_LAST_AMT_07, 0, NULL, NON_LAST_AMT_07)
        , LAST_LEVEL_AMT_08 = DECODE(LAST_LEVEL_AMT_08, 0, NULL, LAST_LEVEL_AMT_08)
        , NON_LAST_AMT_08 = DECODE(NON_LAST_AMT_08, 0, NULL, NON_LAST_AMT_08)
        , LAST_LEVEL_AMT_09 = DECODE(LAST_LEVEL_AMT_09, 0, NULL, LAST_LEVEL_AMT_09)
        , NON_LAST_AMT_09 = DECODE(NON_LAST_AMT_09, 0, NULL, NON_LAST_AMT_09)
        , LAST_LEVEL_AMT_10 = DECODE(LAST_LEVEL_AMT_10, 0, NULL, LAST_LEVEL_AMT_10)
        , NON_LAST_AMT_10 = DECODE(NON_LAST_AMT_10, 0, NULL, NON_LAST_AMT_10)
        , LAST_LEVEL_AMT_11 = DECODE(LAST_LEVEL_AMT_11, 0, NULL, LAST_LEVEL_AMT_11)
        , NON_LAST_AMT_11 = DECODE(NON_LAST_AMT_11, 0, NULL, NON_LAST_AMT_11)
        , LAST_LEVEL_AMT_12 = DECODE(LAST_LEVEL_AMT_12, 0, NULL, LAST_LEVEL_AMT_12)
        , NON_LAST_AMT_12 = DECODE(NON_LAST_AMT_12, 0, NULL, NON_LAST_AMT_12)        
    ;




--6�ܰ�> ���Ͱ�꼭�� ��ȸ�Ѵ�.
    OPEN P_CURSOR FOR

    SELECT
          ITEM_CODE	            --�׸��ڵ�_�����ڵ�    
        , ITEM_NAME             --��������;      ����׸��
          
        , LAST_LEVEL_AMT_SUM    --�԰�_�����������׸�ݾ�
        , NON_LAST_AMT_SUM	    --�հ�_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_01	    --01��_�����������׸�ݾ�_1�б�, ��ݱ�, ���
        , NON_LAST_AMT_01	    --01��_�������ƴѷ����׸�ݾ�_1�б�, ��ݱ�, ���
        , LAST_LEVEL_AMT_02	    --02��_�����������׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NON_LAST_AMT_02	    --02��_�������ƴѷ����׸�ݾ�_2�б�, �Ϲݱ�, ����
        , LAST_LEVEL_AMT_03	    --03��_�����������׸�ݾ�_3�б�
        , NON_LAST_AMT_03	    --03��_�������ƴѷ����׸�ݾ�_3�б�
        , LAST_LEVEL_AMT_04	    --04��_�����������׸�ݾ�_4�б�
        , NON_LAST_AMT_04	    --04��_�������ƴѷ����׸�ݾ�_4�б�
        , LAST_LEVEL_AMT_05	    --05��_�����������׸�ݾ�
        , NON_LAST_AMT_05	    --05��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_06	    --06��_�����������׸�ݾ�
        , NON_LAST_AMT_06	    --06��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_07	    --07��_�����������׸�ݾ�
        , NON_LAST_AMT_07	    --07��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_08	    --08��_�����������׸�ݾ�
        , NON_LAST_AMT_08	    --08��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_09	    --09��_�����������׸�ݾ�
        , NON_LAST_AMT_09	    --09��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_10	    --10��_�����������׸�ݾ�
        , NON_LAST_AMT_10	    --10��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_11	    --11��_�����������׸�ݾ�
        , NON_LAST_AMT_11	    --11��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_12	    --12��_�����������׸�ݾ�
        , NON_LAST_AMT_12	    --12��_�������ƴѷ����׸�ݾ�          
    FROM FI_FS_IS_PARADE
    WHERE FORM_FRAME_YN = 'Y' OR
        (ENABLED_FLAG = 'Y'    --������ ����� �׸� �������� ��. 
        
            --ȭ�鿡 ���̴� �ݾ� �׸��� ��� NULL �� �ڷ�� ������ �ʰ� �ϱ� ����.
            AND (  LAST_LEVEL_AMT_SUM IS NOT NULL OR NON_LAST_AMT_SUM IS NOT NULL
                OR LAST_LEVEL_AMT_01 IS NOT NULL OR NON_LAST_AMT_01 IS NOT NULL
                OR LAST_LEVEL_AMT_02 IS NOT NULL OR NON_LAST_AMT_02 IS NOT NULL
                OR LAST_LEVEL_AMT_03 IS NOT NULL OR NON_LAST_AMT_03 IS NOT NULL
                OR LAST_LEVEL_AMT_04 IS NOT NULL OR NON_LAST_AMT_04 IS NOT NULL
                OR LAST_LEVEL_AMT_05 IS NOT NULL OR NON_LAST_AMT_05 IS NOT NULL
                OR LAST_LEVEL_AMT_06 IS NOT NULL OR NON_LAST_AMT_06 IS NOT NULL
                OR LAST_LEVEL_AMT_07 IS NOT NULL OR NON_LAST_AMT_07 IS NOT NULL
                OR LAST_LEVEL_AMT_08 IS NOT NULL OR NON_LAST_AMT_08 IS NOT NULL
                OR LAST_LEVEL_AMT_09 IS NOT NULL OR NON_LAST_AMT_09 IS NOT NULL
                OR LAST_LEVEL_AMT_10 IS NOT NULL OR NON_LAST_AMT_10 IS NOT NULL
                OR LAST_LEVEL_AMT_11 IS NOT NULL OR NON_LAST_AMT_11 IS NOT NULL
                OR LAST_LEVEL_AMT_12 IS NOT NULL OR NON_LAST_AMT_12 IS NOT NULL )
        )
    ORDER BY SORT_SEQ;
    
    
/*    EXCEPTION
        WHEN OTHERS THEN
           --�۾��� ������ �߻��Ͽ����ϴ�. Ȯ�ιٶ��ϴ�.
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');         
*/

END LIST_IS;






--LIST_IS PROCEDURE�� ������ ������ �ڷᱸ���� ���� �ƴ� ���
--�ڷᱸ���� ���� ��� �� ���� �⸻��ǰ����/�⸻��ǰ������ ���� 
--�ڷᱸ���� �б�, �ݱ�, �� �� ����� �⸻��ǰ����/�⸻��ǰ������ ���ϱ� �����̴�.
PROCEDURE LIST_IS_M_OTHER(
      W_SOB_ID          IN  FI_FORM_MST.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID          IN  FI_FORM_MST.ORG_ID%TYPE     --����ξ��̵�
    , W_FS_SET_ID       IN  FI_FORM_MST.FS_SET_ID%TYPE  --�������ؼ�Ʈ���̵�
    , W_CLOSING_YEAR    IN  VARCHAR2                    --����
    , W_DATA_GB         IN  VARCHAR2                    --�ڷᱸ��(M : ��)

    --������� ���ۿ����� ���ų� Ŀ�� �մϴ�.
    , W_CLOSING_START   IN  VARCHAR2                    --��ȸ ���ۿ�(��> M01 : 1���ΰ��)
    , W_CLOSING_END     IN  VARCHAR2                    --��ȸ �����(��> M12 : 12���ΰ��)
)

AS

t_CNT               NUMBER := 0;    --����ڻ�⸻�ݾ� �ڷ����� ������ �ľ��ϱ� ����.


t_TERM_START_M      VARCHAR2(2) := NULL;    --�����ۿ�
t_TERM_END_M        VARCHAR2(2) := NULL;    --��������
t_REPEAT            VARCHAR2(2) := NULL;    --�ڷ���ȸ��
t_PERIOD_FROM       DATE;                   --��������
t_PERIOD_TO         DATE;                   --���������


t_REPEAT_MM        VARCHAR2(2) := NULL;    --����ڻ�⸻�ݾ� ����� �����.

t_WORK_MM           VARCHAR2(2) := NULL;    --����ڻ�⸻�ݾ� ������ ���� �۾���
t_RECURSIVE_CNT     NUMBER  := 0;           --����ڻ�⸻�ݾ� ������ ���� LOOP�� �ݺ� ȸ��


--����� �ǹ� : [��]�ǿ����� 1��, 2�� ���� �� ���� �ǹ��ϰ�, [�б�]�ǿ��� 1�б�, 2�б� ���� �ǹ��ϴ� �̷� ���̴�.
t_THIS_LAST_LEVEL_AMT       NUMBER  := 0;   --���_�����������׸�ݾ�

t_LAST_LEVEL_AMT_01         NUMBER  := 0;   --01��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_01_CALC    NUMBER  := 0;   --01��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_02         NUMBER  := 0;   --02��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_02_CALC    NUMBER  := 0;   --02��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_03         NUMBER  := 0;   --03��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_03_CALC    NUMBER  := 0;   --03��_�����������׸�ݾ� ���踦 ���� ����        
t_LAST_LEVEL_AMT_04         NUMBER  := 0;   --04��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_04_CALC    NUMBER  := 0;   --04��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_05         NUMBER  := 0;   --05��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_05_CALC    NUMBER  := 0;   --05��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_06         NUMBER  := 0;   --06��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_06_CALC    NUMBER  := 0;   --06��_�����������׸�ݾ� ���踦 ���� ���� 
t_LAST_LEVEL_AMT_07         NUMBER  := 0;   --07��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_07_CALC    NUMBER  := 0;   --07��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_08         NUMBER  := 0;   --08��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_08_CALC    NUMBER  := 0;   --08��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_09         NUMBER  := 0;   --09��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_09_CALC    NUMBER  := 0;   --09��_�����������׸�ݾ� ���踦 ���� ���� 
t_LAST_LEVEL_AMT_10         NUMBER  := 0;   --10��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_10_CALC    NUMBER  := 0;   --10��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_11         NUMBER  := 0;   --11��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_11_CALC    NUMBER  := 0;   --11��_�����������׸�ݾ� ���踦 ���� ����
t_LAST_LEVEL_AMT_12         NUMBER  := 0;   --12��_�����������׸�ݾ�
t_LAST_LEVEL_AMT_12_CALC    NUMBER  := 0;   --12��_�����������׸�ݾ� ���踦 ���� ���� 

t_INVENTORY_AMOUNT      NUMBER := 0;   --����ڻ� �̿��ݾ�
t_TERM_END_AMT          NUMBER := 0;   --����ڻ� �Ⱓ���ݾ�
t_TERM_END_AMT_NEXT     NUMBER := 0;   --����ڻ� �Ⱓ���ݾ�(���� ������������� �����ϱ� ����)
t_TERM_END_LINE_AMT     NUMBER := 0;   --����ڻ� �⸻���ǰ����
t_TERM_END_LINE_AMT_0   NUMBER := 0;   --����ڻ� �⸻���ǰ������ 0 �ΰ�츦 ����Ͽ� ���.
t_TERM_END_RAW_AMT      NUMBER := 0;   --����ڻ� �����ݾ�
t_MATERIAL_AMT          NUMBER := 0;   --�⸻��������� �ӽ� ����
t_ITEM_COST             NUMBER := 0;   --�����ǰ�������� �ӽ� ����


t_ITEM_CODE     FI_FS_IS_PARADE.ITEM_CODE%TYPE;      --�׸��ڵ�_�����ڵ�
t_ACCOUNT_DR_CR FI_FS_IS_PARADE.ACCOUNT_DR_CR%TYPE;  --���뱸��(1-����,2-�뺯)

--�������������� �����ǰ���������� �����ϱ� ���� CURSOR��.
TYPE TCURSOR IS REF CURSOR;
IS_TCURSOR TCURSOR;

BEGIN

--1�ܰ�>�����ڷ� ����, ���� �ڷ� ����, �⺻ Ʋ ����

    --������ : �ڷᱸ��(M : ��)�� ���ۿ��� ����� ����
    IF    W_DATA_GB = 'M' THEN
        t_TERM_START_M  := SUBSTR(W_CLOSING_START, 2, 2);
        t_TERM_END_M    := SUBSTR(W_CLOSING_END, 2, 2);  
    END IF;        



    --���� �ڷḦ �����Ѵ�.
    DELETE FI_FS_IS_PARADE;


    --���Ͱ�꼭�� ��ȸ�ϱ� ���� �⺻Ʋ�� �����.
    INSERT INTO FI_FS_IS_PARADE(
          ITEM_NAME	            --����׸��
          
        , LAST_LEVEL_AMT_SUM    --�԰�_�����������׸�ݾ�
        , NON_LAST_AMT_SUM	    --�հ�_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_01	    --01��_�����������׸�ݾ�_1�б�, ��ݱ�, ���
        , NON_LAST_AMT_01	    --01��_�������ƴѷ����׸�ݾ�_1�б�, ��ݱ�, ���
        , LAST_LEVEL_AMT_02	    --02��_�����������׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NON_LAST_AMT_02	    --02��_�������ƴѷ����׸�ݾ�_2�б�, �Ϲݱ�, ����
        , LAST_LEVEL_AMT_03	    --03��_�����������׸�ݾ�_3�б�
        , NON_LAST_AMT_03	    --03��_�������ƴѷ����׸�ݾ�_3�б�
        , LAST_LEVEL_AMT_04	    --04��_�����������׸�ݾ�_4�б�
        , NON_LAST_AMT_04	    --04��_�������ƴѷ����׸�ݾ�_4�б�
        , LAST_LEVEL_AMT_05	    --05��_�����������׸�ݾ�
        , NON_LAST_AMT_05	    --05��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_06	    --06��_�����������׸�ݾ�
        , NON_LAST_AMT_06	    --06��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_07	    --07��_�����������׸�ݾ�
        , NON_LAST_AMT_07	    --07��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_08	    --08��_�����������׸�ݾ�
        , NON_LAST_AMT_08	    --08��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_09	    --09��_�����������׸�ݾ�
        , NON_LAST_AMT_09	    --09��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_10	    --10��_�����������׸�ݾ�
        , NON_LAST_AMT_10	    --10��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_11	    --11��_�����������׸�ݾ�
        , NON_LAST_AMT_11	    --11��_�������ƴѷ����׸�ݾ�
        , LAST_LEVEL_AMT_12	    --12��_�����������׸�ݾ�
        , NON_LAST_AMT_12	    --12��_�������ƴѷ����׸�ݾ�          
        
        , ITEM_CODE	            --�׸��ڵ�_�����ڵ�
        , ACCOUNT_DR_CR         --���뱸��(1-����,2-�뺯)
        , SORT_SEQ	            --���ļ���
        , ITEM_LEVEL	        --�ݾװ�극��
        , ENABLED_FLAG	        --���(ǥ��)����
        , FORM_FRAME_YN	        --����Ʋ��������
        , REF_FORM_TYPE_ID      --���ú�����ľ��̵�
        , REF_ITEM_CODE         --�����׸��ڵ�
    )
    SELECT
          ITEM_NAME     --����׸��
          
        , NULL  --�԰�_�����������׸�ݾ�
        , NULL	--�հ�_�������ƴѷ����׸�ݾ�
        , NULL	--01��_�����������׸�ݾ�_1�б�, ��ݱ�, ���
        , NULL	--01��_�������ƴѷ����׸�ݾ�_1�б�, ��ݱ�, ���
        , NULL	--02��_�����������׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NULL	--02��_�������ƴѷ����׸�ݾ�_2�б�, �Ϲݱ�, ����
        , NULL	--03��_�����������׸�ݾ�_3�б�
        , NULL	--03��_�������ƴѷ����׸�ݾ�_3�б�
        , NULL	--04��_�����������׸�ݾ�_4�б�
        , NULL	--04��_�������ƴѷ����׸�ݾ�_4�б�
        , NULL	--05��_�����������׸�ݾ�
        , NULL	--05��_�������ƴѷ����׸�ݾ�
        , NULL	--06��_�����������׸�ݾ�
        , NULL	--06��_�������ƴѷ����׸�ݾ�
        , NULL	--07��_�����������׸�ݾ�
        , NULL	--07��_�������ƴѷ����׸�ݾ�
        , NULL	--08��_�����������׸�ݾ�
        , NULL	--08��_�������ƴѷ����׸�ݾ�
        , NULL	--09��_�����������׸�ݾ�
        , NULL	--09��_�������ƴѷ����׸�ݾ�
        , NULL	--10��_�����������׸�ݾ�
        , NULL	--10��_�������ƴѷ����׸�ݾ�
        , NULL	--11��_�����������׸�ݾ�
        , NULL	--11��_�������ƴѷ����׸�ݾ�
        , NULL	--12��_�����������׸�ݾ�
        , NULL	--12��_�������ƴѷ����׸�ݾ�      
        
        , ITEM_CODE     --�׸��ڵ�_�����ڵ� 
        , ACCOUNT_DR_CR --���뱸��(1-����,2-�뺯)
        , SORT_SEQ      --���ļ���
        , ITEM_LEVEL    --�ݾװ�극��
        
        --N�� �ڷ�� �ݾװ�� �ÿ��� ��������, ������ �������� �ȵ� �׸��̴�.
        --��, N�� �ڷ�� �ݾװ���� ������ ���� �̷����� ü�踦 �����ϱ� ���� ������ �������� �׸��� ���̴�.
        , ENABLED_FLAG      --���(ǥ��)����
        
        --�ݾ��� ������ ������ �Ʒ� �׸��� 'Y'�� �׸��� ������ Ʋ�� �����ϱ� ���� ������ ��µǾ�� �� �׸��̴�.
        , FORM_FRAME_YN	        --����Ʋ��������
        , REF_FORM_TYPE_ID      --���ú�����ľ��̵�
        , REF_ITEM_CODE         --�����׸��ڵ�        
    FROM FI_FORM_MST                        --�繫��ǥ�������_������
    WHERE SOB_ID = W_SOB_ID                 --ȸ����̵�
        AND ORG_ID = W_ORG_ID               --����ξ��̵�
        AND FS_SET_ID = W_FS_SET_ID         --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID = t_FORM_TYPE_ID   --�������ID(�����ڵ�)
    ORDER BY SORT_SEQ    
    ;


--2�ܰ�>������������ �ݾ��� ���Ѵ�.
--��, ���ʻ�ǰ����(3), �⸻��ǰ����(5), ������ǰ����(6), �����ǰ��������(7), �⸻��ǰ����(8)�� 5�� �׸���
--�ݾװ�극���� �����ϰ� ���׸��� �̿��ؼ� �ݾ��� �������� �ʴ´�.

    IF W_DATA_GB IS NOT NULL THEN
        FOR REPEAT IN t_TERM_START_M..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT, 2, 0);
            
            
            --����ϼ��� : ����� �����ϰ� ������ ����
            IF    W_DATA_GB = 'M' THEN
                t_PERIOD_FROM   := TO_DATE(         W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM');
                t_PERIOD_TO     := LAST_DAY(TO_DATE(W_CLOSING_YEAR || t_REPEAT, 'YYYY-MM'));     
            END IF;



            --�Ⱓ���� �ش� ������ �ݾ��� �а��ڷῡ�� ���Ѵ�. 
            FI_FS_SLIP_G.CREATE_FS_SLIP(
                  W_SOB_ID
                , W_ORG_ID
                , W_FS_SET_ID
                , t_FORM_TYPE_ID
                , t_LAST_ITEM_LEVEL
                , t_PERIOD_FROM
                , t_PERIOD_TO   );


            --3 : ���ʻ�ǰ����, 5 : �⸻��ǰ����, 
            --6 : ������ǰ����, 7 : �����ǰ��������, 8 : �⸻��ǰ����
            FOR LAST_LEVEL_REC IN (
                SELECT          
                      ITEM_CODE	    --�׸��ڵ�
                    , ACCOUNT_DR_CR	--���뱸��(1-����,2-�뺯)
                FROM FI_FS_IS_PARADE
                WHERE ITEM_LEVEL = t_LAST_ITEM_LEVEL
                    AND (ITEM_CODE NOT IN ('3', '5', '6', '7', '8') )
            ) LOOP
        
                --DBMS_OUTPUT.PUT_LINE('�׸��ڵ� : ' || LAST_LEVEL_REC.ITEM_CODE);        
                
                t_THIS_LAST_LEVEL_AMT       := 0;   --���_�����������׸�ݾ�

                IF LAST_LEVEL_REC.ACCOUNT_DR_CR = '1' THEN      --�ش� ������ ���������̸�
                    BEGIN
                      SELECT SUM(DR_AMT) - SUM(CR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;
                ELSIF LAST_LEVEL_REC.ACCOUNT_DR_CR = '2' THEN   --�ش� ������ �뺯�����̸�
                    BEGIN
                      SELECT SUM(CR_AMT) - SUM(DR_AMT) AS AMT
                      INTO t_THIS_LAST_LEVEL_AMT
                      FROM FI_FS_SLIP
                      WHERE ITEM_CODE = LAST_LEVEL_REC.ITEM_CODE
                      GROUP BY ITEM_CODE;                
                    EXCEPTION WHEN OTHERS THEN
                      t_THIS_LAST_LEVEL_AMT := 0;
                    END;
                END IF;              


                --�ش� Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_THIS_LAST_LEVEL_AMT, LAST_LEVEL_REC.ITEM_CODE );
                
            END LOOP LAST_LEVEL_REC;      

        END LOOP REPEAT; 
        
    END IF;






--2�ܰ�>���ʻ�ǰ����(3), �⸻��ǰ����(5), ������ǰ����(6), �⸻��ǰ����(8), �����ǰ��������(7)�� �׸� �ݾ� ����
--�� �׸��� ()�ȿ� ����ִ� ���� �ش� �׸�鿡 ���� �繫��ǥ��İ����� ������ �׸��ڵ��̴�.

    IF    W_DATA_GB = 'M' THEN
    
        --������ �����ǰ��������(9)�� �����ϱ� ���� �������������� �����Ѵ�.
        FI_FS_FACTORY_COST_PARADE_G.LIST_FACTORY_COST(
              IS_TCURSOR
            , W_SOB_ID
            , W_ORG_ID
            , t_FS_SET_ID
            , W_CLOSING_YEAR
            , W_DATA_GB
            , W_CLOSING_START
            , W_CLOSING_END  );



        FOR REPEAT_INVENTORY IN 01..t_TERM_END_M LOOP

            t_REPEAT := LPAD(REPEAT_INVENTORY, 2, 0);

            IF t_REPEAT = '01' THEN               
                
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_RAW_AMT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');                    
            

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_RAW_AMT;    --����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_FORWARD_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.
                
                SELECT NVL(NON_LAST_AMT_01, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_FORWARD_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_01
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� ���� ������ǰ���׿� �̿��ϱ� ����.
            
            ELSIF t_REPEAT = '02' THEN
                --2�� ~ 12�� ������ ����/�⸻ ��ǰ�ݾ� �������� ��� ����.
                                       
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.
                
                SELECT NVL(NON_LAST_AMT_02, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_02
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� ���� ������ǰ���׿� �̿��ϱ� ����.
                
            ELSIF t_REPEAT = '03' THEN 
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.
                


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_03, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --�⸻��ǰ����(8) Į���� ���� UPDATE�Ѵ�.
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_03
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;                    
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT; -- ���� ���� ������ǰ���׿� �̿��ϱ� ����.   

            ELSIF t_REPEAT = '04' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );

                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_04, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_04
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                

            ELSIF t_REPEAT = '05' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_05, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_05
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                  

            ELSIF t_REPEAT = '06' THEN
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.
                


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_06, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_06
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '07' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_07, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' ); 
                
                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_07
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                  
                
            ELSIF t_REPEAT = '08' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_08, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );     

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_08
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '09' THEN
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );

                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_09, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );   

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_09
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '10' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)


                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_10, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );  

                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_10
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            ELSIF t_REPEAT = '11' THEN

                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );
                
                t_INVENTORY_AMOUNT := t_TERM_END_AMT; -- ���� ���� ���ʻ�ǰ���׿� �̿��ϱ� ����.


                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)
                

                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_11, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );               


                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_11
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL; 
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.                                                                    

            ELSIF t_REPEAT = '12' THEN
            
                --���ʻ�ǰ����(3) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_INVENTORY_AMOUNT, '3' );


                --�⸻��ǰ����(5)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '402');

                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_INVENTORY_AMOUNT;    ----����Է±ݾ��� ������ ���ʻ�ǰ������ �����Ѵ�.
                    
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '3')  --���ʻ�ǰ����
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4')  --����ǰ���Ծ�
                    INTO t_TERM_END_AMT
                    FROM DUAL;                      
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;

                --�⸻��ǰ����(5) Į���� ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '5' );



                --������ǰ����(6) ���� UPDATE�Ѵ�.
                UPDATE_AMT(t_REPEAT, t_TERM_END_LINE_AMT, '6' );     --������ǰ����(6)
                
                --�����ǰ��������(7) Į���� ���� UPDATE�Ѵ�.

                SELECT NVL(NON_LAST_AMT_12, 0)
                INTO t_ITEM_COST
                FROM FI_FS_FACTORY_COST_PARADE
                WHERE ITEM_CODE = '9';  --�����ǰ��������
                    
                UPDATE_AMT(t_REPEAT, t_ITEM_COST, '7' );                  


                --�⸻��ǰ����(8)
                t_TERM_END_LINE_AMT_0 := INVENTORY_DATA_F('A', W_SOB_ID, W_ORG_ID, W_CLOSING_YEAR || '-' || t_REPEAT, '302');

                --�Էµ� ���� NULL�̸� ���� ���Ƿ� [99999999999999]�� �ѱ�� ����.
                --�� ó���� �ϴ� ���� '0'�� �ǹ��ִ� ��ġ�̱� ������ �̿� ���� ó���� ���ֱ� �����̴�.
                IF t_TERM_END_LINE_AMT_0 = 99999999999999 THEN
                    --t_TERM_END_AMT := t_TERM_END_LINE_AMT;  --����Է±ݾ��� ������ ������ǰ������ �����Ѵ�.
                    
                    --�⸻��ǰ����(8) = ������ǰ����(6) + �����ǰ��������(7) - ����ȯ�ޱ�(4300000) + ����ڻ��򰡼ս�(5301000)
                    SELECT
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '6')  --������ǰ����(6)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '7')  --�����ǰ��������(7)
                        -
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '4300000')  --����ȯ�ޱ�(4300000)
                        +
                        (SELECT LAST_LEVEL_AMT_12
                        FROM FI_FS_IS_PARADE
                        WHERE ITEM_CODE = '5301000')  --����ڻ��򰡼ս�(5301000)                        
                    INTO t_TERM_END_AMT
                    FROM DUAL;                     
                ELSE
                    t_TERM_END_AMT := t_TERM_END_LINE_AMT_0;
                END IF;   
                
                UPDATE_AMT(t_REPEAT, t_TERM_END_AMT, '8' );     --�⸻��ǰ����(8)
                
                --t_TERM_END_LINE_AMT := t_TERM_END_AMT;  --���� ���� ������ǰ���׿� �̿��ϱ� ����.  

            END IF;

        END LOOP REPEAT_INVENTORY;
        
    END IF;

END LIST_IS_M_OTHER;












--�ش���� �´� Į���� ���� UPDATE�Ѵ�.
PROCEDURE UPDATE_AMT( 
      W_TERM        IN  VARCHAR2    --��
    , W_AMT         IN  NUMBER      --�ݾ�
    , W_ITEM_CODE   IN  FI_FS_IS_PARADE.ITEM_CODE%TYPE    --�׸��ڵ�_�����ڵ�
)

AS

BEGIN

    IF    W_TERM = '01' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_01   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            
        
    ELSIF W_TERM = '02' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_02   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            
                    
    ELSIF W_TERM = '03' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_03   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '04' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_04   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '05' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_05   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '06' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_06   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '07' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_07   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '08' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_08   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '09' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_09   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '10' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_10   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '11' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_11   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    ELSIF W_TERM = '12' THEN

        UPDATE FI_FS_IS_PARADE
        SET   LAST_LEVEL_AMT_12   = W_AMT --���_�����������׸�ݾ�
        WHERE ITEM_CODE = W_ITEM_CODE;            

    END IF;

END UPDATE_AMT;







--����ڻ�⸻�ڷḦ ���Ѵ�.
FUNCTION INVENTORY_DATA_F(
      W_DATA_GB IN VARCHAR2                 --C : �Ǽ�, A : �ݾ�
    , W_SOB_ID  IN FI_FORM_MST.SOB_ID%TYPE  --ȸ����̵�
    , W_ORG_ID  IN FI_FORM_MST.ORG_ID%TYPE  --����ξ��̵�
    , W_PERIOD  IN VARCHAR2                 --��ȸ�Ⱓ(��>2011-12)
    
    --����ڻ�ݾװ����׸��ڵ�(402 : �⸻��ǰ, 302 : �⸻��ǰ)    
    , W_FORM_ITEM_TYPE_CD   IN FI_CLOSING_ENDING_AMOUNT.FORM_ITEM_TYPE_CD%TYPE
) RETURN NUMBER

AS

t_DATA NUMBER := 0;

BEGIN

    IF W_DATA_GB = 'C' THEN
    
        SELECT COUNT(*)
        INTO t_DATA
        FROM FI_CLOSING_ENDING_AMOUNT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND PERIOD_NAME = W_PERIOD
            AND FORM_ITEM_TYPE_CD = W_FORM_ITEM_TYPE_CD ;    
    
    ELSIF W_DATA_GB = 'A' THEN
    
        SELECT NVL(ENDING_AMOUNT, 99999999999999)
        INTO t_DATA
        FROM FI_CLOSING_ENDING_AMOUNT
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND PERIOD_NAME = W_PERIOD
            AND FORM_ITEM_TYPE_CD = W_FORM_ITEM_TYPE_CD ;
    
    END IF;
                
    RETURN t_DATA;

END INVENTORY_DATA_F;









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






END FI_FS_IS_PARADE_G;
/
