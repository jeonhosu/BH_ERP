CREATE OR REPLACE PACKAGE FI_DPR_EXPENSE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DPR_EXPENSE_G
Description  : �����󰢺���Ȳ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����󰢺���Ȳ)
Program History :
    ����>FI_DPR_EXPENSE(�����󰢺���Ȳ) ���̺��� �����󰢺���Ȳ �ڷḦ �����ϱ� ���� �ӽ������� ����ϴ� ���̺��̴�.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-03   Leem Dong Ern(�ӵ���)
*****************************************************************************/



--��ȸ��ư�� Ŭ���ϸ� CREATE_DPR_EXPENSE PROCEDURE�� ������ �����ڷḦ ���� �� 
--LIST_DPR_EXPENSE_SUM PROCEDURE�� �̿��� �����ڷᰡ ��ȸ�ȴ�.


--��Ȳ��ȸ�ڷ� ����
PROCEDURE CREATE_DPR_EXPENSE(
      W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --����ξ��̵�
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --��񱸺�
    , W_WPERIOD_FR      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)
);







--���� ��ȸ
PROCEDURE LIST_DPR_EXPENSE_SUM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --����ξ��̵�
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --��񱸺�
    , W_WPERIOD_FR      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)  
);







--�󼼳��� ��ȸ
PROCEDURE LIST_DPR_EXPENSE_DET( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --����ξ��̵�
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --�ڻ��������̵�
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --��񱸺�
    , W_WPERIOD_FR          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)  
);








--���Ⱓ���ڻ곻�� ��ȸ
PROCEDURE LIST_ACQUIRE_DPR_EXPENSE( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --����ξ��̵�
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --�ڻ��������̵�
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --��񱸺�
    , W_WPERIOD_FR          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)
    , W_ACQUIRE_FR          IN  DATE        --���Ⱓ_����(��>2011-01)
    , W_ACQUIRE_TO          IN  DATE        --���Ⱓ_����(��>2011-12)
);





END FI_DPR_EXPENSE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_DPR_EXPENSE_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_DPR_EXPENSE_G
Description  : �����󰢺���Ȳ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�����󰢺���Ȳ)
Program History :
    ����>FI_DPR_EXPENSE(�����󰢺���Ȳ) ���̺��� �����󰢺���Ȳ �ڷḦ �����ϱ� ���� �ӽ������� ����ϴ� ���̺��̴�.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-11-03   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--��Ȳ��ȸ�ڷ� ����
PROCEDURE CREATE_DPR_EXPENSE(
      W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --����ξ��̵�
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --��񱸺�
    , W_WPERIOD_FR      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)
)

AS

t_ASSET_ID      FI_DPR_EXPENSE.ASSET_ID%TYPE;       --�ڻ���̵�
t_AMT_SIGN      VARCHAR2(2);
t_THIS_DPR_AMT  FI_DPR_EXPENSE.THIS_DPR_AMT%TYPE;   --��Ⱘ���󰢺�

BEGIN

    --���� �ڷḦ �����Ѵ�.
    DELETE FI_DPR_EXPENSE;
    
    --���� �ڷḦ �����Ѵ�.
    INSERT INTO FI_DPR_EXPENSE(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , ASSET_CATEGORY_ID	--�ڻ��������̵�
        , ASSET_ID	        --�ڻ���̵�
        , ASSET_CODE	    --�ڻ��ڵ�
        , ASSET_DESC	    --�ڻ��
        , EXPENSE_TYPE	    --��񱸺�
        , START_AMT	        --���ʰ���
        , THIS_INC	        --���������
        , THIS_DEC	        --��Ⱘ�Ҿ�
        , END_AMT	        --�⸻�ܾ�
        , PRE_ALLOWANCES_ACCU   --�������ݴ����
        , THIS_DPR_AMT	        --��Ⱘ���󰢺�
        , PRE_ALLOWANCES_DEC	--�������ݰ��Ҿ�
        , DPR_ACCUMULATE_AMT	--�����󰢴����
        , BOOK_VALUE	        --�̻��ܾ�    
    )
    SELECT
          SOB_ID  --ȸ����̵�
        , ORG_ID  --����ξ��̵�
        , ASSET_CATEGORY_ID     --�ڻ��������̵�
        , ASSET_ID              --�ڻ���̵�
        , ASSET_CODE            --�ڻ��ڵ�
        , ASSET_DESC            --�ڻ��
        , EXPENSE_TYPE          --��񱸺�
        
        --�ڻ�������ڰ� ��ȸ���ۿ� �̻��̶�� �� �ڻ��� ��⿡ ����� ���̹Ƿ� ���ʰ����� '0'�̰� �� �� ���� ���ݾ����� �����Ѵ�.
        , CASE
            WHEN ACQUIRE_DATE >= TO_DATE(W_WPERIOD_FR, 'YYYY-MM') THEN 0
            ELSE AMOUNT --���ݾ�
          END AMOUNT    --���ʰ���  
          
        --�ڻ�������ڰ� ��ȸ�Ⱓ ���̸� ��ȸ�Ⱓ���� �ڻ��� ����� ���̹Ƿ� ���ݾ��� �����ϰ�, �� �� ���� '0'���� �����Ѵ�.
        , CASE
            WHEN ACQUIRE_DATE >= TO_DATE(W_WPERIOD_FR, 'YYYY-MM') AND ACQUIRE_DATE <= LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')) THEN AMOUNT    --���ݾ�
            ELSE 0
          END AMOUNT    --���������      
        , 0             --��Ⱘ�Ҿ�
        
        --�ڻ�������ڰ� ��ȸ������� �����̸� ��ȸ�Ⱓ ���������� �̹� ���� �ڻ��̹Ƿ� ���ݾ��� �����ϰ�, �� ���� ���� '0'���� �����Ѵ�.
        , CASE
            WHEN ACQUIRE_DATE <= LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')) THEN AMOUNT    --���ݾ�
            ELSE 0
          END AMOUNT    --�⸻�ܾ�           
        
        , 0         --�������ݴ����
        , 0         --��Ⱘ���󰢺�
        , 0         --�������ݰ��Ҿ�
        , 0         --�����󰢴����
        , 0         --�̻��ܾ�
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID   --ȸ����̵�
        AND ORG_ID = W_ORG_ID    --����ξ��̵�
        AND EXPENSE_TYPE = NVL(W_EXPENSE_TYPE, EXPENSE_TYPE)
    ;
    
    



    --�������ݴ���� ����
    --��ȸ���ۿ� ������ �����󰢴������ �����Ѵ�.
    FOR REC_AMT_MODIFY IN (

        SELECT ASSET_ID, DPR_SUM_AMOUNT AS AMOUNT          --�����󰢴����
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID   --ȸ����̵�
            AND ORG_ID = W_ORG_ID    --����ξ��̵�
            AND PERIOD_NAME = TO_CHAR(ADD_MONTHS(TO_DATE(W_WPERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
        
    ) LOOP
    
        UPDATE FI_DPR_EXPENSE
        SET PRE_ALLOWANCES_ACCU = REC_AMT_MODIFY.AMOUNT
        WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
           
    END LOOP REC_AMT_MODIFY;
    


    --�Ⱓ�� �󰢿Ϸ�� �ڻ��� �������ݴ���� ���� : ������ȸ���� �����󰢴������ �����Ѵ�.
    FOR REC_AMT_MODIFY IN (

        SELECT ASSET_ID
            , DPR_SUM_AMOUNT          --�����󰢴����
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID   --ȸ����̵�
            AND ORG_ID = W_ORG_ID    --����ξ��̵�
            AND DISUSE_YN = 'Y' --������ȸ������
            AND PERIOD_NAME < W_WPERIOD_FR
        
    ) LOOP
    
        UPDATE FI_DPR_EXPENSE
        SET   PRE_ALLOWANCES_ACCU = REC_AMT_MODIFY.DPR_SUM_AMOUNT   --�������ݴ����
        WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
           
    END LOOP REC_AMT_MODIFY;


    
    
    --��Ⱘ���󰢺� ���� : ��ȸ�Ⱓ���� �����󰢺��� �հ�� �����Ѵ�.
    FOR REC_AMT_MODIFY IN (

        SELECT ASSET_ID, SUM(SOURCE_AMOUNT) AS AMOUNT   --(����)�����󰢺�
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID   --ȸ����̵�
            AND ORG_ID = W_ORG_ID    --����ξ��̵�
            AND PERIOD_NAME BETWEEN W_WPERIOD_FR AND W_WPERIOD_TO
        GROUP BY ASSET_ID
        
    ) LOOP
    
        UPDATE FI_DPR_EXPENSE
        SET THIS_DPR_AMT = REC_AMT_MODIFY.AMOUNT
        WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
           
    END LOOP REC_AMT_MODIFY;    




    --����, ����, ����, �⸻�ܾ׿� ������ ��ĥ �ڻ꺯������ �ڷḦ �����Ͽ� �ش� �ݾ� ����.
    FOR REC_AMT_MODIFY IN (

        SELECT
              A.ASSET_ID    --�ڻ���̵�
            --, C.ASSET_CODE  --�ڻ��ڵ�
            --, C.ASSET_DESC  --�ڻ��
            , A.CHARGE_DATE --��������
            --, A.CHARGE_ID --����������̵�
            --, FI_COMMON_G.ID_NAME_F(A.CHARGE_ID) AS CHARGE_NM   --�������
            , A.AMOUNT    --(������)�ݾ�

            --��ȸ�Ⱓ �� ��/�� �����ڷ� ����
            --�� ���а��� ���� �ش�ݾ��� ��/�� �ݾ׿� ������ ��ĥ�� �Ǵ� ���ʰ��׿� ������ ��ĥ���� �Ǵ��Ѵ�.
            , CASE  
                WHEN TO_CHAR(CHARGE_DATE, 'YYYY-MM') >= W_WPERIOD_FR AND TO_CHAR(CHARGE_DATE, 'YYYY-MM') <= W_WPERIOD_TO THEN 'Y'
                ELSE 'N'
              END INSIDE_REC
              
            , B.AMT_SIGN    --�ݾ�������ȣ
        FROM FI_ASSET_HISTORY A
            , (--�ڻ��� �ݾ��� ������Ű�� ��Ҹ� ����
                SELECT 
                      COMMON_ID --�ݾ׺�������
                    , VALUE2 AS AMT_SIGN    --�ݾ�������ȣ
                FROM FI_COMMON
                WHERE GROUP_CODE = 'ASSET_CHARGE'
                    AND VALUE1 = 'Y'               
            ) B
            --, FI_ASSET_MASTER C
        WHERE A.SOB_ID = W_SOB_ID   --ȸ����̵�
            AND A.ORG_ID = W_ORG_ID    --����ξ��̵� 
            AND TO_CHAR(A.CHARGE_DATE, 'YYYY-MM') <= W_WPERIOD_TO   --��������
            
            AND A.CHARGE_ID = B.COMMON_ID
           -- AND A.ASSET_ID = C.ASSET_ID
        ORDER BY ASSET_ID, CHARGE_DATE 
        
    ) LOOP
        /*IF REC_AMT_MODIFY.ASSET_ID = 3296 THEN
          DBMS_OUTPUT.PUT_LINE(REC_AMT_MODIFY.CHARGE_DATE || '/' || REC_AMT_MODIFY.AMOUNT || '/' || REC_AMT_MODIFY.INSIDE_REC || '/' || REC_AMT_MODIFY.AMT_SIGN);  
        END IF;*/
        
        --��ȸ���ǿ� �ش��ϴ� �ڷ� �� Ư�� �ڻ��� �ڻ꺯�������� �ڷᰡ 2�� �̻��� �߻��� ��� 
        --��(2�� �̻��� ��� ���� �ڷ�) �ڷᰡ �Ű� �Ǵ� ����� ��� 
        --�� �̻��� �ݾ׺����� �ʿ䰡 ����. ��� �̷� ���� ���� �� ���� ���ε� Ȥ�ó� �ؼ� ó���Ѵ�.        
        --��>�Ű��� �ڷῡ ���� �Ű��� �� �ں��������� �߻��� �ڷᰡ ���� ���� ����.        
        IF REC_AMT_MODIFY.ASSET_ID = t_ASSET_ID AND t_AMT_SIGN = 'N' THEN
            NULL;


--��ȸ���� �Ⱓ ���� �ڻ꺯���� �߻��� ���
        --��ȸ���� �Ⱓ ���� �ں��������� �߻��� ����� [���������, �⸻�ܾ�]�� �������ش�.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'Y' AND REC_AMT_MODIFY.AMT_SIGN = '+' THEN
            UPDATE FI_DPR_EXPENSE
            SET THIS_INC = NVL(THIS_INC, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0) --���������
                , END_AMT = NVL(END_AMT, 0)+ NVL(REC_AMT_MODIFY.AMOUNT, 0) --�⸻�ܾ�
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            
        --��ȸ���� �Ⱓ ���� �κиŰ��� �߻��� ����� 
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'Y' AND REC_AMT_MODIFY.AMT_SIGN = '-' THEN
            --[��Ⱘ�Ҿ�, �⸻�ܾ�]�� �������ش�.
            UPDATE FI_DPR_EXPENSE
            SET THIS_DEC = NVL(THIS_DEC, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0) --��Ⱘ�Ҿ�
                , END_AMT = NVL(END_AMT, 0) - NVL(REC_AMT_MODIFY.AMOUNT, 0) --�⸻�ܾ�
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ; 
            
            --[�������ݰ��Ҿ�]�� �������ش�.
            UPDATE FI_DPR_EXPENSE
            SET PRE_ALLOWANCES_DEC = 
                    NVL((
                              SELECT (DPR_COUNT - 1) * SP_MNS_DPR_AMOUNT
                              FROM FI_ASSET_DPR_HISTORY
                              WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID
                                  AND PERIOD_NAME = TO_CHAR(ADD_MONTHS(REC_AMT_MODIFY.CHARGE_DATE, 1) , 'YYYY-MM')                    
                          ), 0)
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ; 
    
    
            
        --��ȸ���� �Ⱓ ���� �Ű� �Ǵ� ��Ⱑ �߻��� �����...
        --[��Ⱘ�Ҿ�]���� �ش��ڻ��� ���ʰ����� �����Ѵ�.
        --[�⸻�ܾ�]�� �Ű� �Ǵ� ���� '0'�� �ȴ�.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'Y' AND REC_AMT_MODIFY.AMT_SIGN = 'N' THEN

            --��Ⱘ���󰢺� ����
            --�Ϲ������δ� ��ȸ�Ⱓ ���� �����󰢺��� ���ε�,
            --�Ű� �Ǵ� ��Ⱑ �߻��� �ڻ��� ��� �������� �Ű� �Ǵ� ������ �߻��� ���� �����Ͽ� ���Ѵ�.
            BEGIN
              SELECT SUM(SOURCE_AMOUNT) AS AMOUNT   --(����)�����󰢺�
              INTO t_THIS_DPR_AMT
              FROM FI_ASSET_DPR_HISTORY
              WHERE SOB_ID = W_SOB_ID   --ȸ����̵�
                  AND ORG_ID = W_ORG_ID    --����ξ��̵�
                  AND ASSET_ID = REC_AMT_MODIFY.ASSET_ID
                  AND PERIOD_NAME BETWEEN W_WPERIOD_FR AND TO_CHAR(REC_AMT_MODIFY.CHARGE_DATE, 'YYYY-MM')
              GROUP BY ASSET_ID   ;
            EXCEPTION WHEN OTHERS THEN
              t_THIS_DPR_AMT := 0;
            END;
            
            /*-- ��ȣ�� ����(2013-01-18) : ��� ����ڻ��� �ڻ꺯�� �߻��� �⸻�ݾ� ��� ���� --
            UPDATE FI_DPR_EXPENSE
            SET THIS_DEC = NVL(THIS_DEC, 0) + NVL(START_AMT, 0) --��Ⱘ�Ҿ�
                , END_AMT = NVL(END_AMT, 0) - NVL(START_AMT, 0) --�⸻�ܾ�
                , THIS_DPR_AMT = t_THIS_DPR_AMT --��Ⱘ���󰢺�
                
                --�������ݰ��Ҿ� = �������ݴ���� + ��Ⱘ���󰢺�
                --�Ű� �Ǵ� ��Ⱑ �߻������Ƿ� ������ �� �ݾ��� �����Ѵ�.
                , PRE_ALLOWANCES_DEC = NVL(PRE_ALLOWANCES_ACCU, 0) + NVL(t_THIS_DPR_AMT, 0)
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;*/
            
            UPDATE FI_DPR_EXPENSE
            SET THIS_DEC = NVL(THIS_DEC, 0) + (NVL(THIS_INC, 0) + NVL(START_AMT, 0)) --��Ⱘ�Ҿ�
                , END_AMT = NVL(END_AMT, 0) - (NVL(THIS_INC, 0) + NVL(START_AMT, 0)) --�⸻�ܾ�
                , THIS_DPR_AMT = t_THIS_DPR_AMT --��Ⱘ���󰢺�
                
                --�������ݰ��Ҿ� = �������ݴ���� + ��Ⱘ���󰢺�
                --�Ű� �Ǵ� ��Ⱑ �߻������Ƿ� ������ �� �ݾ��� �����Ѵ�.
                , PRE_ALLOWANCES_DEC = NVL(PRE_ALLOWANCES_ACCU, 0) + NVL(t_THIS_DPR_AMT, 0)
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            





--��ȸ���� �Ⱓ ���� �ڻ꺯���� �߻��� ���
        --��ȸ���� �Ⱓ ���� �ں��������� �߻��� ����� [���ʰ���, �⸻�ܾ�]�� ����(����)���ش�.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'N' AND REC_AMT_MODIFY.AMT_SIGN = '+' THEN
            UPDATE FI_DPR_EXPENSE
            SET START_AMT = NVL(START_AMT, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0)   --���ʰ���
                , END_AMT = NVL(END_AMT, 0) + NVL(REC_AMT_MODIFY.AMOUNT, 0)     --�⸻�ܾ�
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            
        --��ȸ���� �Ⱓ ���� �κиŰ��� �߻��� ����� [���ʰ���, �⸻�ܾ�]�� ����(����)���ش�.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'N' AND REC_AMT_MODIFY.AMT_SIGN = '-' THEN
            UPDATE FI_DPR_EXPENSE
            SET START_AMT = NVL(START_AMT, 0) - NVL(REC_AMT_MODIFY.AMOUNT, 0)   --���ʰ���
                , END_AMT = NVL(END_AMT, 0) - NVL(REC_AMT_MODIFY.AMOUNT, 0)     --�⸻�ܾ�
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;
            
        --��ȸ���� �Ⱓ ���� �Ű� �Ǵ� ��Ⱑ �߻��� ����� ���ݾ��� '0'���� �������ش�.
        ELSIF REC_AMT_MODIFY.INSIDE_REC = 'N' AND REC_AMT_MODIFY.AMT_SIGN = 'N' THEN
            UPDATE FI_DPR_EXPENSE
            SET   START_AMT = 0             --���ʰ���
                , THIS_INC = 0              --���������
                , THIS_DEC = 0              --��Ⱘ�Ҿ�            
                , END_AMT = 0               --�⸻�ܾ�
                , PRE_ALLOWANCES_ACCU = 0   --�������ݴ����
                , THIS_DPR_AMT = 0          --��Ⱘ���󰢺�
                , PRE_ALLOWANCES_DEC = 0    --�������ݰ��Ҿ�
                , DPR_ACCUMULATE_AMT = 0    --�����󰢴����
                , BOOK_VALUE = 0            --�̻��ܾ�                
            WHERE ASSET_ID = REC_AMT_MODIFY.ASSET_ID    ;

        END IF;
        
        t_ASSET_ID := REC_AMT_MODIFY.ASSET_ID;
        t_AMT_SIGN := REC_AMT_MODIFY.AMT_SIGN;        

    END LOOP REC_AMT_MODIFY;





    --�����󰢴����, �̻��ܾ� ����
    --�����󰢴���� = �������ݴ���� + ��Ⱘ���󰢺� - �������ݰ��Ҿ�
    --�̻��ܾ� = �⸻�ܾ� - �����󰢴����
    UPDATE FI_DPR_EXPENSE
    SET   DPR_ACCUMULATE_AMT = PRE_ALLOWANCES_ACCU + THIS_DPR_AMT - PRE_ALLOWANCES_DEC
        , BOOK_VALUE = END_AMT - (PRE_ALLOWANCES_ACCU + THIS_DPR_AMT  - PRE_ALLOWANCES_DEC)
    ;



END CREATE_DPR_EXPENSE;








--���� ��ȸ
PROCEDURE LIST_DPR_EXPENSE_SUM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_DPR_EXPENSE.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN  FI_DPR_EXPENSE.ORG_ID%TYPE          --����ξ��̵�
    , W_EXPENSE_TYPE    IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE    --��񱸺�
    , W_WPERIOD_FR      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO      IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)  
)


AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.ASSET_CATEGORY_ID	--�ڻ��������̵�
        , B.ASSET_CATEGORY_CODE --�ڻ������ڵ�     
        , NVL(B.ASSET_CATEGORY_NAME, '<< �հ�  >>') AS ASSET_CATEGORY_NAME --�ڻ�����
        , NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', W_EXPENSE_TYPE, W_SOB_ID, W_ORG_ID), '��ü') AS EXPENSE_TYPE_NM   --��񱸺�
        , A.START_AMT           --���ʰ���
        , A.THIS_INC            --���������
        , A.THIS_DEC            --��Ⱘ�Ҿ�
        , A.END_AMT             --�⸻�ܾ�
        , A.PRE_ALLOWANCES_ACCU --�������ݴ����
        , A.THIS_DPR_AMT        --��Ⱘ���󰢺�
        , A.PRE_ALLOWANCES_DEC  --�������ݰ��Ҿ�
        , A.DPR_ACCUMULATE_AMT  --�����󰢴����
        , A.BOOK_VALUE          --�̻��ܾ�
        , TO_CHAR(TO_DATE(W_WPERIOD_FR, 'YYYY-MM'), 'YYYY-MM-DD') AS WPERIOD_FR            --�󰢱Ⱓ_������
        , TO_CHAR(LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')), 'YYYY-MM-DD') AS WPERIOD_TO  --�󰢱Ⱓ_������
    FROM
        (
            SELECT
                  ASSET_CATEGORY_ID	            --�ڻ��������̵�
                , SUM(START_AMT) AS	START_AMT   --���ʰ���
                , SUM(THIS_INC) AS THIS_INC     --���������
                , SUM(THIS_DEC) AS THIS_DEC	    --��Ⱘ�Ҿ�
                , SUM(END_AMT) AS END_AMT	    --�⸻�ܾ�
                , SUM(PRE_ALLOWANCES_ACCU) AS PRE_ALLOWANCES_ACCU   --�������ݴ����
                , SUM(THIS_DPR_AMT) AS THIS_DPR_AMT	                --��Ⱘ���󰢺�
                , SUM(PRE_ALLOWANCES_DEC) AS PRE_ALLOWANCES_DEC	    --�������ݰ��Ҿ�
                , SUM(DPR_ACCUMULATE_AMT) AS DPR_ACCUMULATE_AMT	    --�����󰢴����
                , SUM(BOOK_VALUE) AS BOOK_VALUE	                    --�̻��ܾ� 
            FROM FI_DPR_EXPENSE
            WHERE SOB_ID = W_SOB_ID     --ȸ����̵�
                AND ORG_ID = W_ORG_ID   --����ξ��̵�
            GROUP BY ROLLUP(ASSET_CATEGORY_ID)
        ) A
        , ( SELECT
                 ASSET_CATEGORY_ID      --�ڻ��������̵�
               , ASSET_CATEGORY_CODE    --�ڻ������ڵ�
               , ASSET_CATEGORY_NAME    --�ڻ�����
            FROM FI_ASSET_CATEGORY
            WHERE SOB_ID = W_SOB_ID       
          ) B
    WHERE A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID(+)
    ORDER BY B.ASSET_CATEGORY_CODE  ;

END LIST_DPR_EXPENSE_SUM;








--�󼼳��� ��ȸ
PROCEDURE LIST_DPR_EXPENSE_DET( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --����ξ��̵�
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --�ڻ��������̵�
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --��񱸺�
    , W_WPERIOD_FR          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)   
)


AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.ASSET_CATEGORY_ID	--�ڻ��������̵�
        , B.ASSET_CATEGORY_CODE --�ڻ������ڵ�
        , B.ASSET_CATEGORY_NAME --�ڻ�����
        , NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', W_EXPENSE_TYPE, W_SOB_ID, W_ORG_ID), '��ü') AS EXPENSE_TYPE_NM   --��񱸺�
        --, DECODE(GROUPING(ASSET_CODE), '0', NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', W_EXPENSE_TYPE, W_SOB_ID), '��ü'), '<<  �հ�  >>') AS EXPENSE_TYPE_NM   --��񱸺�
        , A.ASSET_ID    --�ڻ���̵�
        , A.ASSET_CODE  --�ڻ��ڵ�
        , A.ASSET_DESC  --�ڻ��  
        
        , A.START_AMT        --���ʰ���
        , A.THIS_INC	        --���������
        , A.THIS_DEC	        --��Ⱘ�Ҿ�
        , A.END_AMT	        --�⸻�ܾ�
        , A.PRE_ALLOWANCES_ACCU   --�������ݴ����
        , A.THIS_DPR_AMT	        --��Ⱘ���󰢺�
        , A.PRE_ALLOWANCES_DEC	--�������ݰ��Ҿ�
        , A.DPR_ACCUMULATE_AMT	--�����󰢴����
        , A.BOOK_VALUE	        --�̻��ܾ�
     
/*
        , SUM(A.START_AMT) AS START_AMT        --���ʰ���
        , SUM(A.THIS_INC) AS THIS_INC	        --���������
        , SUM(A.THIS_DEC) AS THIS_DEC	        --��Ⱘ�Ҿ�
        , SUM(A.END_AMT) AS END_AMT	        --�⸻�ܾ�
        , SUM(A.PRE_ALLOWANCES_ACCU) AS PRE_ALLOWANCES_ACCU   --�������ݴ����
        , SUM(A.THIS_DPR_AMT) AS THIS_DPR_AMT	        --��Ⱘ���󰢺�
        , SUM(A.PRE_ALLOWANCES_DEC) AS PRE_ALLOWANCES_DEC	--�������ݰ��Ҿ�
        , SUM(A.DPR_ACCUMULATE_AMT) AS DPR_ACCUMULATE_AMT	--�����󰢴����
        , SUM(A.BOOK_VALUE) AS BOOK_VALUE	        --�̻��ܾ�        
*/        
        , TO_CHAR(TO_DATE(W_WPERIOD_FR, 'YYYY-MM'), 'YYYY-MM-DD') AS WPERIOD_FR            --�󰢱Ⱓ_������
        , TO_CHAR(LAST_DAY(TO_DATE(W_WPERIOD_TO, 'YYYY-MM')), 'YYYY-MM-DD') AS WPERIOD_TO  --�󰢱Ⱓ_������        
    FROM FI_DPR_EXPENSE A
        , ( SELECT
                 ASSET_CATEGORY_ID  --�ڻ��������̵�
               , ASSET_CATEGORY_CODE    --�ڻ������ڵ�
               , ASSET_CATEGORY_NAME    --�ڻ�����
            FROM FI_ASSET_CATEGORY
            WHERE SOB_ID = W_SOB_ID   --ȸ����̵�       
          ) B
    WHERE A.SOB_ID = W_SOB_ID   --ȸ����̵�
        AND A.ORG_ID = W_ORG_ID    --����ξ��̵�
        AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
        
        AND A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID
        AND A.BOOK_VALUE        != 0
    --GROUP BY ROLLUP((A.ASSET_CATEGORY_ID, B.ASSET_CATEGORY_CODE, B.ASSET_CATEGORY_NAME, ASSET_ID, ASSET_CODE, ASSET_DESC))    
    ORDER BY A.ASSET_CODE   ;

END LIST_DPR_EXPENSE_DET;









--���Ⱓ���ڻ곻�� ��ȸ
PROCEDURE LIST_ACQUIRE_DPR_EXPENSE( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_DPR_EXPENSE.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_DPR_EXPENSE.ORG_ID%TYPE              --����ξ��̵�
    , W_ASSET_CATEGORY_ID   IN  FI_DPR_EXPENSE.ASSET_CATEGORY_ID%TYPE   --�ڻ��������̵�
    , W_EXPENSE_TYPE        IN  FI_DPR_EXPENSE.EXPENSE_TYPE%TYPE        --��񱸺�
    , W_WPERIOD_FR          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-01)
    , W_WPERIOD_TO          IN  VARCHAR2    --�󰢱Ⱓ_����(��>2011-12)
    , W_ACQUIRE_FR          IN  DATE        --���Ⱓ_����
    , W_ACQUIRE_TO          IN  DATE        --���Ⱓ_����
)

AS

BEGIN

    OPEN P_CURSOR FOR   

    SELECT
          A.ASSET_CATEGORY_ID	--�ڻ��������̵�
        , B.ASSET_CATEGORY_CODE --�ڻ������ڵ�
        , B.ASSET_CATEGORY_NAME --�ڻ�����
        
        --, NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', A.EXPENSE_TYPE, A.SOB_ID, A.ORG_ID), '��ü') AS EXPENSE_TYPE_NM   --��񱸺�
        , DECODE( GROUPING(ASSET_CATEGORY_CODE), '1', '', 
            DECODE(GROUPING(ASSET_CATEGORY_NAME), '0', 
                    NVL(FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', A.EXPENSE_TYPE, A.SOB_ID, A.ORG_ID), '')
                )
          ) AS EXPENSE_TYPE_NM   --��񱸺�
          
        , A.ASSET_ID            --�ڻ���̵�
        , A.ASSET_CODE          --�ڻ��ڵ�
        
        --, A.ASSET_DESC          --�ڻ��
        , DECODE(GROUPING(ASSET_CATEGORY_CODE), 1, '  << ��      �� >>', DECODE(ASSET_CATEGORY_NAME, NULL, '  [[ ��      �� ]]',  A.ASSET_DESC)) AS ASSET_DESC  --�ڻ��
        
        , C.ACQUIRE_DATE        --�������
        , C.ASSET_STATUS_NM     --�ڻ����
        , C.IFRS_DPR_STATUS_NM  --�󰢻���
        
        , SUM(A.START_AMT) AS START_AMT --���ʰ���
        , SUM(A.THIS_INC) AS THIS_INC	--���������
        , SUM(A.THIS_DEC) AS THIS_DEC	--��Ⱘ�Ҿ�
        , SUM(A.END_AMT) AS END_AMT	    --�⸻�ܾ�
        , SUM(A.PRE_ALLOWANCES_ACCU) AS PRE_ALLOWANCES_ACCU --�������ݴ����
        , SUM(A.THIS_DPR_AMT) AS THIS_DPR_AMT	            --��Ⱘ���󰢺�
        , SUM(A.PRE_ALLOWANCES_DEC) AS PRE_ALLOWANCES_DEC	--�������ݰ��Ҿ�
        , SUM(A.DPR_ACCUMULATE_AMT) AS DPR_ACCUMULATE_AMT	--�����󰢴����
        , SUM(A.BOOK_VALUE) AS BOOK_VALUE	                --�̻��ܾ�  
        
        , C.CC_CODE                 --�����ڵ�
        , C.CC_DESC                 --������
        , C.AMOUNT                  --���ݾ�    
        , C.IFRS_PROGRESS_YEAR      --������
        , C.IFRS_RESIDUAL_AMOUNT    --��������
        , C.MANAGE_DEPT_NM          --�����μ�    
        , C.REMARK                  --���    

        , W_ACQUIRE_FR AS ACQUIRE_FR    --���Ⱓ_������
        , W_ACQUIRE_TO AS ACQUIRE_TO    --���Ⱓ_������ 
        , W_WPERIOD_FR AS PERIOD_FR     --�󰢱Ⱓ_������
        , W_WPERIOD_TO AS PERIOD_TO     --�󰢱Ⱓ_������  
    FROM FI_DPR_EXPENSE A
        , ( SELECT
                 ASSET_CATEGORY_ID  --�ڻ��������̵�
               , ASSET_CATEGORY_CODE    --�ڻ������ڵ�
               , ASSET_CATEGORY_NAME    --�ڻ�����
            FROM FI_ASSET_CATEGORY
            WHERE SOB_ID = W_SOB_ID   --ȸ����̵�       
          ) B
        , (
            SELECT
                  A.ASSET_CODE    --�ڻ��ڵ�
                --, A.ASSET_STATUS_CODE  --�ڻ����
                , A.ACQUIRE_DATE   --�������
                , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', A.ASSET_STATUS_CODE, A.SOB_ID) AS ASSET_STATUS_NM  --�ڻ����
                , A.AMOUNT         --���ݾ� 
                --, A.COST_CENTER_ID --�������̵�
                , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
                , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������
                --, A.MANAGE_DEPT_ID --�����μ����̵�
                , FI_DEPT_MASTER_G.DEPT_NAME_F(A.MANAGE_DEPT_ID) AS MANAGE_DEPT_NM --�����μ�
                , A.REMARK --���
                , A.IFRS_PROGRESS_YEAR --(IFRS)������
                , A.IFRS_RESIDUAL_AMOUNT   --(IFRS)��������
                --, A.IFRS_DPR_STATUS_CODE   --(IFRS)�󰢻���
                , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', A.IFRS_DPR_STATUS_CODE, A.SOB_ID) AS IFRS_DPR_STATUS_NM  --(IFRS)�󰢻���
            FROM FI_ASSET_MASTER A
            WHERE A.ACQUIRE_DATE BETWEEN NVL(W_ACQUIRE_FR, A.ACQUIRE_DATE) AND NVL(W_ACQUIRE_TO, A.ACQUIRE_DATE)
        ) C
    WHERE A.SOB_ID = W_SOB_ID   --ȸ����̵�
        AND A.ORG_ID = W_ORG_ID    --����ξ��̵�
        AND A.ASSET_CATEGORY_ID = NVL(W_ASSET_CATEGORY_ID, A.ASSET_CATEGORY_ID)
        
        AND A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID
        
        AND C.ASSET_CODE = A.ASSET_CODE
    GROUP BY ROLLUP(ASSET_CATEGORY_CODE, (A.ASSET_CATEGORY_ID, ASSET_CATEGORY_NAME, A.EXPENSE_TYPE, A.ASSET_ID, A.SOB_ID, A.ORG_ID, A.ASSET_CODE, ASSET_DESC, ACQUIRE_DATE, ASSET_STATUS_NM, IFRS_DPR_STATUS_NM, START_AMT, THIS_INC, THIS_DEC, END_AMT, PRE_ALLOWANCES_ACCU, THIS_DPR_AMT, PRE_ALLOWANCES_DEC, DPR_ACCUMULATE_AMT, BOOK_VALUE, CC_CODE, CC_DESC, AMOUNT, IFRS_PROGRESS_YEAR, IFRS_RESIDUAL_AMOUNT, MANAGE_DEPT_NM, REMARK))        
    ORDER BY ASSET_CATEGORY_CODE, ASSET_CODE   ;

END LIST_ACQUIRE_DPR_EXPENSE;








END FI_DPR_EXPENSE_G;
/
