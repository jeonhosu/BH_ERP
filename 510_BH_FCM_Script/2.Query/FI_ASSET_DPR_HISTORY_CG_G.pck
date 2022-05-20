CREATE OR REPLACE PACKAGE FI_ASSET_DPR_HISTORY_CG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ASSET_DPR_HISTORY_CG_G
Description  : ��������ǥ���� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (��������ǥ����)
Program History :
    �ڻ��������� ���� ������ �� �ڻ꺰 �󰢽������ڷḦ �������� ���α׷�����
    �۾��ڰ� ������ �ڷῡ ���� �ڵ���ǥ�а��������� ���α׷��� �ڷḦ ������ �ڵ���ǥ�� �����Ѵ�.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-31   Leem Dong Ern(�ӵ���)
*****************************************************************************/





--�����󰢽������ڷ� ��ȸ
PROCEDURE LIST_ASSET_DPR_HISTORY(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵�
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --�ڻ��������̵�          
);




--��ǥ���� ��ư�� Ŭ���ϸ� �Ʒ� 2���� PROCEDURE�� ����ȴ�.
--1.UPDATE_ASSET_DPR_HISTORY
--2.CREATE_DPR_SLIP (��ǥ���� : DPR - ��������ǥ)


--�۾��ڿ� ���� ��ǥ�� �����ϱ� ���� ���õ� �ڷ�鿡 ���� ��ǥ��������[SLIP_YN] Į���� ���� 'Y'�� �����Ѵ�.
--��ǥ���� ����ڷ�� ��ǥ��������[SLIP_YN] Į���� 'Y'�̰� �󰢿���[DPR_YN]�� 'Y'�� �ƴ� �ڷ��̴�.
PROCEDURE UPDATE_ASSET_DPR_HISTORY(
      W_SOB_ID      IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE        --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE        --����ξ��̵�
    , W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY_CG.DPR_TYPE%TYPE      --ȸ�豸��[20 : IFRS]
    , W_PERIOD_NAME IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE   --�󰢳��
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY_CG.ASSET_ID%TYPE      --�ڻ���̵�
    , P_SLIP_YN     IN  FI_ASSET_DPR_HISTORY_CG.SLIP_YN%TYPE       --��ǥ��������
    , P_DPR_YN      IN  FI_ASSET_DPR_HISTORY_CG.DPR_YN%TYPE        --�󰢿���
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --����������
);





--��ǥ����
PROCEDURE CREATE_DPR_SLIP( 
      W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵�
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_ID%TYPE    --�ڻ��������̵�
    , W_ASSET_CATEGORY_CODE IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_CODE%TYPE  --�ڻ������ڵ�
    , P_USER_ID             IN  FI_ASSET_DPR_HISTORY_CG.CREATED_BY%TYPE        --������
    
    , O_MESSAGE             OUT VARCHAR2    --��ǥ���� �� ȭ������ �۾� ��� ��ȯ��.
);





--��ǥ���� : ������ ��ǥ�� �����Ѵ�.
PROCEDURE DELETE_DPR_SLIP( 
      W_SOB_ID          IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵�
    , W_PERIOD_NAME     IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , P_SLIP_HEADER_ID  IN  FI_ASSET_DPR_HISTORY_CG.SLIP_HEADER_ID%TYPE    --��ǥ���ID
    , P_GL_NUM          IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE            --��ǥ��ȣ
    , P_USER_ID         IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --����������
    
    , O_MESSAGE         OUT VARCHAR2    --��ǥ���� �� ȭ������ �۾� ��� ��ȯ��.
);






--��ǥ�����ڻ� ��ȸ
PROCEDURE LIST_SLIP_DPR(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵� 
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --�ڻ��������̵�      
);





--��ǥ���а��ڷ� ��ȸ
PROCEDURE LIST_SLIP_JOURNAL(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --����ξ��̵�
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --��ǥ��ȣ       
);






--��ǥ���ڻ���� ��ȸ
PROCEDURE LIST_SLIP_ASSET(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --����ξ��̵�
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --��ǥ��ȣ
);



END FI_ASSET_DPR_HISTORY_CG_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_DPR_HISTORY_CG_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_ASSET_DPR_HISTORY_CG_G
Description  : ��������ǥ���� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (��������ǥ����)
Program History :
    �ڻ��������� ���� ������ �� �ڻ꺰 �󰢽������ڷḦ �������� ���α׷�����
    �۾��ڰ� ������ �ڷῡ ���� �ڵ���ǥ�а��������� ���α׷��� �ڷḦ ������ �ڵ���ǥ�� �����Ѵ�.

------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-10-31   Leem Dong Ern(�ӵ���)
*****************************************************************************/







--�����󰢽������ڷ� ��ȸ
PROCEDURE LIST_ASSET_DPR_HISTORY(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵�
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --�ڻ��������̵�          
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID              --ȸ����̵�
        , A.ORG_ID              --����ξ��̵�
        , DECODE(A.SLIP_YN, 'Y', 'Y', 'N') AS SLIP_YN        --��ǥ��������        
        , A.PERIOD_NAME         --�󰢳��    
        , A.ASSET_CATEGORY_ID   --�ڻ��������̵�
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --�ڻ�����
        , B.EXPENSE_TYPE    --��񱸺�
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', B.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --��񱸺�     
        , A.COST_CENTER_ID  --�������̵�
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������      
        , A.ASSET_ID                            --�ڻ���̵�
        , B.ASSET_CODE                          --�ڻ��ڵ�
        , B.ASSET_DESC                          --�ڻ��    
        , NVL(A.DPR_YN, 'N') AS DPR_YN          --(����)�󰢿���    
        , A.DPR_COUNT                           --��ȸ��    
        , A.SOURCE_AMOUNT AS LAST_DPR_AMOUNT    --(����)�����󰢺�   
        , A.SLIP_DATE       --��ǥ����
        , A.GL_NUM          --��ǥ��ȣ
        , A.SLIP_HEADER_ID  --��ǥ���ID
        , (SELECT REMARK FROM FI_SLIP_HEADER WHERE GL_NUM = A.GL_NUM) AS GL_REMARK --��ǥ����
        
        , A.DPR_TYPE    --ȸ�豸��_�ڵ�[20 : IFRS]
        , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', A.DPR_TYPE, A.SOB_ID) AS DPR_TYPE_NM   --ȸ�豸��
        , A.DPR_METHOD_TYPE --�����󰢹��_�ڵ�
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.DPR_METHOD_TYPE, A.SOB_ID) AS DPR_METHOD_TYPE_NM   --�����󰢹��          
    FROM FI_ASSET_DPR_HISTORY_CG A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
           FROM FI_ASSET_MASTER_CG
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND IFRS_DPR_STATUS_CODE != '90'   --(IFRS)�󰢻���; ���� �Ϸ���� ���� �ڷḸ
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
        AND A.ASSET_ID = B.ASSET_ID

        AND A.PERIOD_NAME = W_PERIOD_NAME
        AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID    --��>21:�����ġ
        AND A.GL_NUM IS NULL    --��ǥ������ ���� ���� �ڷḸ ��ȸ�Ѵ�.
    ORDER BY A.ASSET_CATEGORY_ID, B.EXPENSE_TYPE, A.COST_CENTER_ID, B.ASSET_CODE    ;

END LIST_ASSET_DPR_HISTORY;






--��ǥ���� ��ư�� Ŭ���ϸ� �Ʒ� 2���� PROCEDURE�� ����ȴ�.
--1.UPDATE_ASSET_DPR_HISTORY
--2.CREATE_DPR_SLIP (��ǥ���� : DPR - ��������ǥ)




--�۾��ڿ� ���� ��ǥ�� �����ϱ� ���� ���õ� �ڷ�鿡 ���� ��ǥ��������[SLIP_YN] Į���� ���� 'Y'�� �����Ѵ�.
--��ǥ���� ����ڷ�� ��ǥ��������[SLIP_YN] Į���� 'Y'�̰� �󰢿���[DPR_YN]�� 'Y'�� �ƴ� �ڷ��̴�.
PROCEDURE UPDATE_ASSET_DPR_HISTORY(
      W_SOB_ID      IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE        --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE        --����ξ��̵�
    , W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY_CG.DPR_TYPE%TYPE      --ȸ�豸��[20 : IFRS]
    , W_PERIOD_NAME IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE   --�󰢳��
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY_CG.ASSET_ID%TYPE      --�ڻ���̵�
    , P_SLIP_YN     IN  FI_ASSET_DPR_HISTORY_CG.SLIP_YN%TYPE       --��ǥ��������
    , P_DPR_YN      IN  FI_ASSET_DPR_HISTORY_CG.DPR_YN%TYPE        --�󰢿���
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --����������    
)

AS

BEGIN

    --��ǥ�������ΰ� Y�̰� �󰢿��ΰ� Y�� �ƴ� �ڷῡ ���� �����Ѵ�.
    IF P_SLIP_YN = 'Y' AND P_DPR_YN != 'Y' THEN

        UPDATE FI_ASSET_DPR_HISTORY_CG
        SET       SLIP_YN               = P_SLIP_YN         --��ǥ��������
            
            , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)    --������������
            , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         --����������
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND DPR_TYPE = W_DPR_TYPE
            AND PERIOD_NAME = W_PERIOD_NAME
            AND ASSET_ID = W_ASSET_ID ;

    END IF;

END UPDATE_ASSET_DPR_HISTORY;







--��ǥ����
PROCEDURE CREATE_DPR_SLIP( 
      W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵�
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_ID%TYPE    --�ڻ��������̵�    
    , W_ASSET_CATEGORY_CODE IN  FI_ASSET_CATEGORY.ASSET_CATEGORY_CODE%TYPE  --�ڻ������ڵ�    
    , P_USER_ID             IN  FI_ASSET_DPR_HISTORY_CG.CREATED_BY%TYPE        --������
    
    , O_MESSAGE             OUT VARCHAR2    --��ǥ���� �� ȭ������ �۾� ��� ��ȯ��.
)

AS

t_SLIP_CREATE_CNT   NUMBER := 0;  --��ǥ������ �ڷ� ���������� �ľ��Ѵ�.
t_DEPT_ID           FI_SLIP_LINE.DEPT_ID%TYPE;              --��ǥ�ۼ��μ�
t_SLIP_DATE         FI_SLIP_LINE.SLIP_DATE%TYPE;            --��ǥ���� : �ش�� ������.
t_SLIP_NUM          FI_SLIP_LINE.SLIP_NUM%TYPE;             --(ä����)��ǥ��ȣ
t_CURRENCY_CODE     FI_SLIP_LINE.CURRENCY_CODE%TYPE;        --�⺻��ȭ
t_SLIP_TYPE         FI_SLIP_LINE.SLIP_TYPE%TYPE := 'DPR';   --��ǥ����(DPR : ������)

t_SLIP_REMARKS_HEADER   FI_AUTO_JOURNAL_MST.SLIP_REMARKS%TYPE;  --�����ǥ����

t_JOB_CATEGORY_CD   FI_COMMON.CODE%TYPE;  --�����ڵ�; �����з��ڵ�

V_SLIP_HEADER_ID    FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;       --��ǥ������̵�

--�� ������ ����������, ���� PROCEDURE�� �̿��ϱ� ���� �������� ���̴�.
t_SLIP_LINE_ID      FI_SLIP_LINE.SLIP_LINE_ID%TYPE;         --��ǥ����ID

t_CREATED_TYPE      FI_SLIP_HEADER.CREATED_TYPE%TYPE := 'I';                    --��������(M:�޴���, I:INTERFACE)
t_SOURCE_TABLE      FI_SLIP_HEADER.SOURCE_TABLE%TYPE := 'FI_ASSET_DPR_HISTORY_CG'; --INTERFACE �ҽ����̺�

--EXPENSE_TYPE(��񱸺�)  [10:�ǰ�, 20:����]
t_ACCOUNT_CONTROL_ID_10 FI_AUTO_JOURNAL_DET.ACCOUNT_CONTROL_ID%TYPE;    --��������ID
t_ACCOUNT_CODE_10       FI_AUTO_JOURNAL_DET.ACCOUNT_CODE%TYPE;          --�����ڵ�
t_SLIP_REMARKS_10       FI_AUTO_JOURNAL_DET.SLIP_REMARKS%TYPE;          --��ǥ����
t_ACCOUNT_CONTROL_ID_20 FI_AUTO_JOURNAL_DET.ACCOUNT_CONTROL_ID%TYPE;    --��������ID
t_ACCOUNT_CODE_20       FI_AUTO_JOURNAL_DET.ACCOUNT_CODE%TYPE;          --�����ڵ�
t_SLIP_REMARKS_20       FI_AUTO_JOURNAL_DET.SLIP_REMARKS%TYPE;          --��ǥ����
t_ACCOUNT_CONTROL_ID    FI_AUTO_JOURNAL_DET.ACCOUNT_CONTROL_ID%TYPE;    --��������ID
t_ACCOUNT_CODE          FI_AUTO_JOURNAL_DET.ACCOUNT_CODE%TYPE;          --�����ڵ�
t_SLIP_REMARKS_LINE     FI_AUTO_JOURNAL_DET.SLIP_REMARKS%TYPE;          --��ǥ����

t_GL_AMOUNT             FI_SLIP_LINE.GL_AMOUNT%TYPE;         --��ǥ�ݾ�

V_SYSDATE               DATE := GET_LOCAL_DATE(W_SOB_ID);   --��������


BEGIN

    --��ǥ������ �ڷ� ���������� �ľ��Ѵ�.
    --��ǥ�������ΰ� Y�̰� �󰢿��ΰ� Y�� �ƴ� �ڷ��� ���� ���θ� �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO t_SLIP_CREATE_CNT
    FROM FI_ASSET_DPR_HISTORY_CG
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND DPR_TYPE = '20'   --ȸ�豸��[20 : IFRS]
        AND PERIOD_NAME = W_PERIOD_NAME
        AND ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
        AND SLIP_YN = 'Y'
        AND NVL(DPR_YN, 'N') != 'Y'   ;
        
    IF t_SLIP_CREATE_CNT = 0 THEN
        --FCM_10381 : �ڵ���ǥ ������ �ڷᰡ �������� �ʽ��ϴ�. Ȯ���ϼ���.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10381', NULL));        
    END IF;  


    --��ǥ�ۼ��μ� ����    
    BEGIN
        --�Ʒ��� SELECT������ ������ ������ ������ ������ �ִ� QUERY�� �״�� ����ߴ�.
        /* �� �ּ����� SQL�� �������� �ۼ��� ���ε� �̰����� �� ��� ���Ǻμ��� ��ã�� ������ �߻���
           �ϴ��� SQL�� ��ü�Ѵ�. 
           �ϴ��� SQL�� �������� �ٸ� ���α׷����� �ڵ���ǥ ���� �� ����ߴ� SQL�̴�.
           �� SQL�� �������� �ۼ��� �Ϳ� �����ϴ� ������ ���� ��� ���� ����� �𸣱� ������
           �� ȸ�� ����� ������ �������� �ۼ��� SQL�� �´ٰ� �����ϰ� ����ϴ� ���� ���̴�.
       */
       
       
        
        SELECT FDM.DEPT_ID
        INTO t_DEPT_ID
        FROM HRM_PERSON_MASTER PM
            , HRM_DEPT_MASTER HDM
            , FI_DEPT_MASTER_MAPPING_V FDM
        WHERE PM.DEPT_ID = HDM.DEPT_ID
            AND HDM.DEPT_ID = FDM.HR_DEPT_ID(+)
            AND HDM.CORP_ID = FDM.HR_CORP_ID(+)
            AND HDM.SOB_ID = FDM.SOB_ID(+)
            AND PM.PERSON_ID = P_USER_ID
            AND PM.SOB_ID = W_SOB_ID   ;
           
        
        
        /*
        SELECT DM.M_DEPT_ID
        INTO t_DEPT_ID
        FROM EAPP_USER EU
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
        WHERE EU.PERSON_ID  = PM.PERSON_ID(+)
        AND PM.DEPT_ID      = DM.HR_DEPT_ID(+)
        AND EU.USER_ID      = P_USER_ID
        AND EU.SOB_ID       = W_SOB_ID
        ;
        */
            
        EXCEPTION WHEN OTHERS THEN
            --FCM_10183 : ���Ǻμ� ������ ã�� ���߽��ϴ�. Ȯ���ϼ���.
            RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL));
    END;



    BEGIN

        t_SLIP_DATE := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));                             --��ǥ����
        t_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', W_SOB_ID, t_SLIP_DATE, P_USER_ID); --(ä����)��ǥ��ȣ
        t_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);                         --�⺻��ȭ

        --�����з��ڵ�
        SELECT CODE
        INTO t_JOB_CATEGORY_CD
        FROM FI_COMMON
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND GROUP_CODE = 'JOB_CATEGORY' --�����з�
            AND VALUE3 = W_ASSET_CATEGORY_CODE  ;      
                
        
        --FI_SLIP_HEADER(��ǥ���) ���̺� ������ ��ǥ���並 �����Ѵ�.
        SELECT SLIP_REMARKS
        INTO t_SLIP_REMARKS_HEADER
        FROM FI_AUTO_JOURNAL_MST
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE_CD = t_SLIP_TYPE    --(DPR : ������)
            AND JOB_CATEGORY_CD = t_JOB_CATEGORY_CD   ;
                    

        --FI_SLIP_HEADER TABLE INSERT
        --�Ʒ� PROCEDURE������ V_SLIP_HEADER_ID(��ǥ������̵�)�� RETURN ������, 
        --�� ���� FI_SLIP_LINE TABLE INSERT �ÿ� ���ȴ�.
        FI_SLIP_G.INSERT_SLIP_HEADER(
              V_SLIP_HEADER_ID      --��ǥ������̵�
            , t_SLIP_DATE           --��ǥ����
            , t_SLIP_NUM            --��ǥ��ȣ
            , W_SOB_ID              --ȸ����̵�
            , W_ORG_ID              --����ξ��̵�
            , t_DEPT_ID             --���Ǻμ�
            , P_USER_ID             --������
            , NULL                  --����μ�
            , t_SLIP_TYPE           --��ǥ����
            , t_SLIP_DATE           --ȸ������; ��ǥ���ڿ� ������ ������ �����Ѵ�.
            , t_SLIP_NUM            --ȸ���ȣ; ��ǥ��ȣ�� ������ ������ �����Ѵ�.
            , NULL                  --���޻� �������
            , NULL                  --���� ��û���(����, ����...)
            , NULL                  --���� ��û��
            , t_SLIP_REMARKS_HEADER --����
            , P_USER_ID             --������
            , t_CREATED_TYPE        --��������(M:�޴���, I:INTERFACE)
            , t_SOURCE_TABLE        --INTERFACE �ҽ����̺�
            , NULL                  --INTERFACE �ҽ� HEADER ID
        );
        
        
        
        
        
        --FI_SLIP_LINE(��ǥ��) ���̺� INSERT�� �� ���� �������� �ʿ����� ����
        --�ڷ�� 2������ �����󰢺� ����/�ǰ����̴�.
        FOR REC_EXPENSE_ACCOUNT IN (
            SELECT
                  DECODE(SUBSTR(ACCOUNT_CODE, 1, 2), '51', '20', '52', '10') AS EXPENSE_TYPE  --��񱸺�[10:�ǰ�, 20:����]
                , ACCOUNT_CONTROL_ID    --��������ID    
                , ACCOUNT_CODE          --�����ڵ�
                , SLIP_REMARKS          --��ǥ����
            FROM FI_AUTO_JOURNAL_DET
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
                AND SLIP_TYPE_CD = 'DPR'
                AND JOB_CATEGORY_CD = t_JOB_CATEGORY_CD
                AND ACCOUNT_DR_CR = '1' --1:����, 2:�뺯        
        ) LOOP
            --EXPENSE_TYPE(��񱸺�)  [10:�ǰ�, 20:����]
            IF REC_EXPENSE_ACCOUNT.EXPENSE_TYPE = '10' THEN
                t_ACCOUNT_CONTROL_ID_10 := REC_EXPENSE_ACCOUNT.ACCOUNT_CONTROL_ID;    --��������ID
                t_ACCOUNT_CODE_10       := REC_EXPENSE_ACCOUNT.ACCOUNT_CODE;          --�����ڵ�
                t_SLIP_REMARKS_10       := REC_EXPENSE_ACCOUNT.SLIP_REMARKS;          --��ǥ����          
            ELSIF REC_EXPENSE_ACCOUNT.EXPENSE_TYPE = '20' THEN
                t_ACCOUNT_CONTROL_ID_20 := REC_EXPENSE_ACCOUNT.ACCOUNT_CONTROL_ID;    --��������ID
                t_ACCOUNT_CODE_20       := REC_EXPENSE_ACCOUNT.ACCOUNT_CODE;          --�����ڵ�
                t_SLIP_REMARKS_20       := REC_EXPENSE_ACCOUNT.SLIP_REMARKS;          --��ǥ����              
            END IF;
        
        END LOOP REC_EXPENSE_ACCOUNT;
        
        

        --FI_SLIP_LINE TABLE INSERT ; ��������

        FOR LINE_INSERT IN (
            SELECT
                  B.EXPENSE_TYPE    --��񱸺�[10:�ǰ�, 20:����]
                --, A.COST_CENTER_ID  --�������̵�
                , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
                , SUM(A.SOURCE_AMOUNT) AS GL_AMOUNT   --(����)�����󰢺�; ��ǥ�� ��ϵ� �ݾ�
                --, COUNT(*) AS CNT
            FROM FI_ASSET_DPR_HISTORY_CG A
                , FI_ASSET_MASTER_CG B
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID
                AND A.DPR_TYPE = '20'   --[20 : IFRS]
                AND A.PERIOD_NAME = W_PERIOD_NAME
                AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
                AND A.SLIP_YN = 'Y'
                AND NVL(A.DPR_YN, 'N') != 'Y'
    
                AND A.ASSET_ID = B.ASSET_ID
            GROUP BY B.EXPENSE_TYPE, A.COST_CENTER_ID
            ORDER BY B.EXPENSE_TYPE, A.COST_CENTER_ID
        ) LOOP
        
            SELECT 
                  DECODE(LINE_INSERT.EXPENSE_TYPE, '10', t_ACCOUNT_CONTROL_ID_10, '20', t_ACCOUNT_CONTROL_ID_20)    --��������ID
                , DECODE(LINE_INSERT.EXPENSE_TYPE, '10', t_ACCOUNT_CODE_10, '20', t_ACCOUNT_CODE_20)                --�����ڵ�
                , DECODE(LINE_INSERT.EXPENSE_TYPE, '10', t_SLIP_REMARKS_10, '20', t_SLIP_REMARKS_20)                --��ǥ����
            INTO t_ACCOUNT_CONTROL_ID, t_ACCOUNT_CODE, t_SLIP_REMARKS_LINE            
            FROM DUAL   ;


            --LINE INSERT ; ��������
            FI_SLIP_G.INSERT_SLIP_LINE(
                  t_SLIP_LINE_ID    --��ǥ���� ID
                , V_SLIP_HEADER_ID  --��ǥ��� ID
                , W_SOB_ID          --ȸ����̵�
                , W_ORG_ID          --����ξ��̵�
                
                , t_ACCOUNT_CONTROL_ID  --��������ID
                , t_ACCOUNT_CODE        --�����ڵ�
                , '1'                   --���뱸��(1-����, 2-�뺯)
                , LINE_INSERT.GL_AMOUNT --��ǥ�ݾ�
                
                , t_CURRENCY_CODE   --��ȭ
                , NULL              --ȯ��
                , NULL              --��ȭ�ݾ�
                
                , LINE_INSERT.CC_CODE   --�ܾװ����׸�1; ���� �����׸�1�̴�.; �����ڵ�
                
                , NULL  --�ܾװ����׸�2
                , NULL  --�����׸�1; ���� �����׸�3�̴�.
                , NULL  --�����׸�2
                , NULL  --�����׸�3
                , NULL  --�����׸�4
                , NULL  --�����׸�5
                , NULL  --�����׸�6
                , NULL  --�����׸�7
                , NULL  --�����׸�8
                , NULL  --�����׸�9
                , NULL  --�����׸�10
                , NULL  --�����׸�11
                , NULL  --�����׸�12
                
                , t_SLIP_REMARKS_LINE   --��ǥ����
                
                , NULL              --UNLIQUIDATE_SLIP_HEADER_ID(������߻���ǥHEADER ID)
                , NULL              --UNLIQUIDATE_SLIP_LINE_ID(�������ڷ�������ǥLINE ID)
                , P_USER_ID         --CREATED_BY(������)
                , t_CREATED_TYPE    --��������(M:�޴���, I:INTERFACE)
                , t_SOURCE_TABLE    --INTERFACE �ҽ����̺�                                
                , NULL              --SOURCE_HEADER_ID(INTERFACE �ҽ� HEADER ID)
                , NULL              --SOURCE_LINE_ID(INTERFACE �ҽ� LINE ID)
            );
            
        END LOOP LINE_INSERT; 
        
        
        
        --FI_SLIP_LINE TABLE INSERT ; �뺯����
        
        --FI_SLIP_LINE(��ǥ��) ���̺� INSERT�� �� �뺯 �������� �ʿ����� ����
        SELECT
              ACCOUNT_CONTROL_ID    --��������ID    
            , ACCOUNT_CODE          --�����ڵ�
            , SLIP_REMARKS          --��ǥ����
        INTO t_ACCOUNT_CONTROL_ID, t_ACCOUNT_CODE, t_SLIP_REMARKS_LINE    
        FROM FI_AUTO_JOURNAL_DET
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND SLIP_TYPE_CD = 'DPR'
            AND JOB_CATEGORY_CD = t_JOB_CATEGORY_CD
            AND ACCOUNT_DR_CR = '2' --1:����, 2:�뺯         
        ;
        
        --�뺯�� ������ �ݾ� ����
        
        SELECT SUM(A.SOURCE_AMOUNT) AS GL_AMOUNT   --(����)�����󰢺�; ��ǥ�� ��ϵ� �ݾ�
        INTO t_GL_AMOUNT
        FROM FI_ASSET_DPR_HISTORY_CG A
        WHERE A.SOB_ID = W_SOB_ID
            AND A.ORG_ID = W_ORG_ID
            AND A.DPR_TYPE = '20'   --[20 : IFRS]
            AND A.PERIOD_NAME = W_PERIOD_NAME
            AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
            AND A.SLIP_YN = 'Y'
            AND NVL(A.DPR_YN, 'N') != 'Y'
        ;
        
        
        --LINE INSERT ; �뺯����
        FI_SLIP_G.INSERT_SLIP_LINE(
              t_SLIP_LINE_ID    --��ǥ���� ID
            , V_SLIP_HEADER_ID  --��ǥ��� ID
            , W_SOB_ID          --ȸ����̵�
            , W_ORG_ID          --����ξ��̵�
            
            , t_ACCOUNT_CONTROL_ID  --��������ID
            , t_ACCOUNT_CODE        --�����ڵ�
            , '2'                   --���뱸��(1-����, 2-�뺯)
            , t_GL_AMOUNT           --��ǥ�ݾ�
            
            , t_CURRENCY_CODE   --��ȭ
            , NULL              --ȯ��
            , NULL              --��ȭ�ݾ�            
            , NULL  --�ܾװ����׸�1; ���� �����׸�1�̴�.            
            , NULL  --�ܾװ����׸�2
            , NULL  --�����׸�1; ���� �����׸�3�̴�.
            , NULL  --�����׸�2
            , NULL  --�����׸�3
            , NULL  --�����׸�4
            , NULL  --�����׸�5
            , NULL  --�����׸�6
            , NULL  --�����׸�7
            , NULL  --�����׸�8
            , NULL  --�����׸�9
            , NULL  --�����׸�10
            , NULL  --�����׸�11
            , NULL  --�����׸�12
            
            , t_SLIP_REMARKS_LINE   --��ǥ����
            
            , NULL              --UNLIQUIDATE_SLIP_HEADER_ID(������߻���ǥHEADER ID)
            , NULL              --UNLIQUIDATE_SLIP_LINE_ID(�������ڷ�������ǥLINE ID)
            , P_USER_ID         --CREATED_BY(������)
            , t_CREATED_TYPE    --��������(M:�޴���, I:INTERFACE)
            , t_SOURCE_TABLE    --INTERFACE �ҽ����̺�                                
            , NULL              --SOURCE_HEADER_ID(INTERFACE �ҽ� HEADER ID)
            , NULL              --SOURCE_LINE_ID(INTERFACE �ҽ� LINE ID)
        );        
              


        --FI_ASSET_MASTER_CG(�ڻ����) ���̺��� IFRS_DPR_STATUS_CODE[(IFRS)�󰢻���]�� UPDATE�Ѵ�.
        --������ȸ���� �ڷ� 
        --  [1.�� ��� : �󰢿Ϸ�]
        --  [2.�� �ƴ� ��� : ������]
        --�ڻ���°� �Ű� �Ǵ� ����� �ڷ� 
        --  [1.�Ű� �Ǵ� ��Ⱑ �߻��� ���� ��� : �󰢿Ϸ�]
        --  [1.�Ű� �Ǵ� ��Ⱑ �߻��� ��������(���� �ƴ�) ��� : ������]

        --IFRS_DPR_STATUS_CODE : (IFRS)�󰢻���
        FOR UPD_IFRS_DPR_STATUS_CODE IN (
            SELECT 
                  A.ASSET_ID    --�ڻ���̵�
                , B.ASSET_CODE  --�ڻ��ڵ�                
                , A.DISUSE_YN   --������ȸ������
                , C.CHANGE_CODE --��������ڵ�
            FROM FI_ASSET_DPR_HISTORY_CG A
                , FI_ASSET_MASTER_CG B
                , (
                    SELECT
                          ASSET_ID    --�ڻ���̵�
                        --, CHARGE_ID --����������̵�
                        , FI_COMMON_G.GET_CODE_F(CHARGE_ID, SOB_ID, ORG_ID) AS CHANGE_CODE  --��������ڵ�
                        --, CHARGE_DATE   --��������
                        --, TO_CHAR(CHARGE_DATE, 'YYYY-MM') AS CHANGE_YM --������
                    FROM FI_ASSET_HISTORY_CG
                    WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                        AND TO_CHAR(CHARGE_DATE, 'YYYY-MM') = W_PERIOD_NAME
                        AND FI_COMMON_G.GET_CODE_F(CHARGE_ID, SOB_ID, ORG_ID) IN ('90', '91')   --90:���, 91:�Ű�
                ) C                
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID
                AND A.DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND A.PERIOD_NAME = W_PERIOD_NAME
                AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
                AND A.SLIP_YN = 'Y'
                AND NVL(A.DPR_YN, 'N') != 'Y'
                
                AND A.ASSET_ID = B.ASSET_ID
                AND A.ASSET_ID = C.ASSET_ID(+)
        ) LOOP
        
            IF UPD_IFRS_DPR_STATUS_CODE.DISUSE_YN = 'Y' THEN --������ȸ���̸�
            
                UPDATE FI_ASSET_MASTER_CG
                SET   IFRS_DPR_STATUS_CODE = '90'   --90:�󰢿Ϸ�
                    , LAST_UPDATE_DATE = V_SYSDATE  --������������
                    , LAST_UPDATED_BY = P_USER_ID   --����������                
                WHERE ASSET_ID = UPD_IFRS_DPR_STATUS_CODE.ASSET_ID  ;
            
            ELSE    --������ȸ���� �ƴϸ�
            
                IF UPD_IFRS_DPR_STATUS_CODE.CHANGE_CODE IN ('90', '91') THEN    --�Ű� �Ǵ� ��Ⱑ �߻��� ���̸�; 90:���, 91:�Ű�

                    UPDATE FI_ASSET_MASTER_CG
                    SET   IFRS_DPR_STATUS_CODE = '90'   --90:�󰢿Ϸ�
                        , LAST_UPDATE_DATE = V_SYSDATE  --������������
                        , LAST_UPDATED_BY = P_USER_ID   --����������                
                    WHERE ASSET_ID = UPD_IFRS_DPR_STATUS_CODE.ASSET_ID  ;

                ELSE

                    UPDATE FI_ASSET_MASTER_CG
                    SET   IFRS_DPR_STATUS_CODE = '10'   --10:������
                        , LAST_UPDATE_DATE = V_SYSDATE  --������������
                        , LAST_UPDATED_BY = P_USER_ID   --����������                
                    WHERE ASSET_ID = UPD_IFRS_DPR_STATUS_CODE.ASSET_ID  ;

                END IF;

            END IF;
            
        END LOOP UPD_IFRS_DPR_STATUS_CODE;         




        --������ �ܰ��̴�.
        --��ǥ�����۾� �Ϸ� �� ��ǥ�� ������ �ڷῡ ���� �󰢿��� Į�� ���� UPDATE�Ѵ�.
        --�� �۾��� �� ��� �Ź� ���ϴ� �ڷῡ ���ؼ� �� ��ǥ�� ������ �� �ֱ� �����̴�.
        UPDATE FI_ASSET_DPR_HISTORY_CG
        SET   DPR_YN            = 'Y'               --�󰢿���
            , SLIP_DATE         = t_SLIP_DATE       --��ǥ����
            , SLIP_HEADER_ID    = V_SLIP_HEADER_ID  --��ǥ���ID
            , GL_NUM            = t_SLIP_NUM        --��ǥ��ȣ
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID
            AND DPR_TYPE = '20'   --ȸ�豸��[20 : IFRS]
            AND PERIOD_NAME = W_PERIOD_NAME
            AND ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
            AND SLIP_YN = 'Y'
            AND NVL(DPR_YN, 'N') != 'Y'   ;      
        
      
        

        EXCEPTION WHEN OTHERS THEN
            --FCM_10182 : ��ǥ���� �� ������ �߻��߽��ϴ�.
            O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10182', NULL);
    END;
    
    --FCM_10112 : ��ǥ���� �۾��� ����Ϸ�Ǿ����ϴ�.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10334', NULL);
    
END CREATE_DPR_SLIP;







--��ǥ���� : ������ ��ǥ�� �����Ѵ�.
PROCEDURE DELETE_DPR_SLIP( 
      W_SOB_ID          IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵�
    , W_PERIOD_NAME     IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��    
    , P_SLIP_HEADER_ID  IN  FI_ASSET_DPR_HISTORY_CG.SLIP_HEADER_ID%TYPE    --��ǥ���ID
    , P_GL_NUM          IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE            --��ǥ��ȣ
    , P_USER_ID         IN  FI_ASSET_DPR_HISTORY_CG.LAST_UPDATED_BY%TYPE   --����������
    
    , O_MESSAGE         OUT VARCHAR2    --��ǥ���� �� ȭ������ �۾� ��� ��ȯ��.
)

AS

V_SYSDATE   DATE := GET_LOCAL_DATE(W_SOB_ID);   --��������

BEGIN

/*
--�Ʒ��� ���ο��ο� ���� �������θ� ���� ������ ������ �´� �����̴�.
--�׷��� �ּ����� ó���Ѵ�.
--������ �繫������ �����ϴ� �� ��ǥ�� ���� ������ ������ �� �ִ� ����� ���α׷��� ����̴�.
--����>�������� ����� ��ǥ�� ���ؼ��� ��ǥ���ΰ��� ���α׷����� ���ο��θ� ������ �� �ִ�.

    --�����Ϸ��� ��ǥ�� ���ο��θ� �ľ��Ͽ� ���ε� ��ǥ��� ������ �� ���ٰ� �޽����� �����ش�.
    IF TRIM(FI_SLIP_G.SLIP_CONFIRM_YN_F(P_SLIP_HEADER_ID)) = 'Y' THEN
    
        --FCM_10408 : �̹� ���ε� ��ǥ�Դϴ�. �������� �� �����ٶ��ϴ�.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10408', NULL);

        --�Ʒ� RETURN���� PARAMETER�� �ѱ�� ��쿡 �����Ϸ��� ������ �������̴�.
        --O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Delete');

        RETURN;
    END IF;
*/

    --ȸ����ǥ ����.
    FI_SLIP_G.DELETE_SLIP_LIST(P_SLIP_HEADER_ID);  --��ǥ����
    
        
    --FI_ASSET_MASTER_CG(�ڻ����)���̺��� IFRS_DPR_STATUS_CODE[(IFRS)�󰢻���]Į���� ���� ��ǥ���� ������ ������ �����Ѵ�.
    
    UPDATE FI_ASSET_MASTER_CG
    SET   IFRS_DPR_STATUS_CODE = '10'   --(IFRS)�󰢻���[10:������]
        , LAST_UPDATE_DATE = V_SYSDATE  --������������
        , LAST_UPDATED_BY = P_USER_ID   --����������    
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ASSET_ID IN (
                SELECT ASSET_ID    --�ڻ���̵�
                FROM FI_ASSET_DPR_HISTORY_CG A
                WHERE SOB_ID = W_SOB_ID
                    AND ORG_ID = W_ORG_ID
                    AND PERIOD_NAME = W_PERIOD_NAME
                    AND GL_NUM = P_GL_NUM
            )   ;   
        


    --�ڻ꺰�� ���� �� �ڷᰡ ���� ��� �󰢻��¸� [20:�̻�]���� �����Ѵ�.

    UPDATE FI_ASSET_MASTER_CG
    SET   IFRS_DPR_STATUS_CODE = '20'   --(IFRS)�󰢻���[20:�̻�]
        , LAST_UPDATE_DATE = V_SYSDATE  --������������
        , LAST_UPDATED_BY = P_USER_ID   --����������   
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ASSET_ID IN
            (                
                SELECT ASSET_ID    --�ڻ���̵�
                FROM
                (
                    SELECT A.ASSET_ID    --�ڻ���̵�
                        --, (SELECT ASSET_CODE FROM FI_ASSET_MASTER_CG WHERE ASSET_ID = A.ASSET_ID) AS ASSET_CODE
                        , (
                            SELECT COUNT(*)
                            FROM FI_ASSET_DPR_HISTORY_CG
                            WHERE SOB_ID = W_SOB_ID
                                AND ORG_ID = W_ORG_ID
                                AND ASSET_ID = A.ASSET_ID
                                AND PERIOD_NAME != W_PERIOD_NAME
                                AND NVL(DPR_YN, 'N') = 'Y'    --(����)�󰢿���
                        ) AS CNT
                    FROM FI_ASSET_DPR_HISTORY_CG A
                    WHERE A.SOB_ID = W_SOB_ID
                        AND A.ORG_ID = W_ORG_ID
                        AND A.GL_NUM = P_GL_NUM
                )
                WHERE CNT = 0                
            )   ;




    --��ǥ������ ���� ����� Į���� ������ ��ǥ���� ���� ���·� �����Ѵ�.  
    UPDATE FI_ASSET_DPR_HISTORY_CG
    SET   SLIP_YN           = NULL      --��ǥ��������       
        , DPR_YN            = NULL      --�󰢿���
        , SLIP_DATE         = NULL      --��ǥ����
        , SLIP_HEADER_ID    = NULL      --��ǥ���ID
        , GL_NUM            = NULL      --��ǥ��ȣ
        , LAST_UPDATE_DATE  = V_SYSDATE --������������
        , LAST_UPDATED_BY   = P_USER_ID --����������        
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND PERIOD_NAME = W_PERIOD_NAME
        AND GL_NUM = P_GL_NUM ;
        
                
      
    --FCM_10336 : ��ǥ���� �۾��� ���� �Ϸ�Ǿ����ϴ�.
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10336', NULL);
    
    EXCEPTION WHEN OTHERS THEN
        --FCM_10182 : ��ǥ���� �� ������ �߻��߽��ϴ�.
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10409', NULL);    

END DELETE_DPR_SLIP;






--��ǥ�����ڻ� ��ȸ
PROCEDURE LIST_SLIP_DPR(
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID              IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE            --����ξ��̵� 
    , W_PERIOD_NAME         IN  FI_ASSET_DPR_HISTORY_CG.PERIOD_NAME%TYPE       --�󰢳��
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_DPR_HISTORY_CG.ASSET_CATEGORY_ID%TYPE --�ڻ��������̵�      
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID            --ȸ����̵�
        , ORG_ID            --����ξ��̵�
        , ASSET_CATEGORY_ID --�ڻ��������̵�
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NAME   --�ڻ�������Ī
        , PERIOD_NAME   --�󰢳��
        , GL_NUM        --��ǥ��ȣ
        , SLIP_DATE     --��ǥ����
        , (SELECT REMARK FROM FI_SLIP_HEADER WHERE GL_NUM = A.GL_NUM) AS GL_REMARK --��ǥ����        
        , SLIP_HEADER_ID    --��ǥ���ID
        , '' AS O_MESSAGE   --DELETE_DPR_SLIP PROCEDURE���� �� �ѱ� (��ǥ���� �� ȭ������ �۾� ��� ��ȯ��)
    FROM FI_ASSET_DPR_HISTORY_CG A
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND GL_NUM IS NOT NULL  --��ǥ��ȣ�� �ִ� �ڷḸ
        AND PERIOD_NAME = NVL(W_PERIOD_NAME, PERIOD_NAME)
        AND ASSET_CATEGORY_ID = NVL(W_ASSET_CATEGORY_ID, ASSET_CATEGORY_ID)
    GROUP BY SOB_ID, ORG_ID, ASSET_CATEGORY_ID, PERIOD_NAME, GL_NUM, SLIP_DATE, SLIP_HEADER_ID 
    ORDER BY PERIOD_NAME DESC, GL_NUM DESC;

END LIST_SLIP_DPR;







--��ǥ���а��ڷ� ��ȸ
PROCEDURE LIST_SLIP_JOURNAL(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --����ξ��̵�
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --��ǥ��ȣ  
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          ASSET_CATEGORY_ID   --�ڻ��������̵�
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --�ڻ�����
        , EXPENSE_TYPE    --��񱸺�
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', EXPENSE_TYPE, W_SOB_ID) AS EXPENSE_TYPE_NM   --��񱸺�
        , COST_CENTER_ID  --�������̵�
        , FI_COMMON_G.COST_CENTER_CODE_F(COST_CENTER_ID) AS CC_CODE  --�����ڵ�
        , FI_COMMON_G.COST_CENTER_DESC_F(COST_CENTER_ID) AS CC_DESC  --������
        , LAST_DPR_AMOUNT    --(����)�����󰢺�
    FROM
        (
            SELECT          
                  A.ASSET_CATEGORY_ID                       --�ڻ��������̵�
                , B.EXPENSE_TYPE                            --��񱸺�
                , A.COST_CENTER_ID                          --�������̵�
                , SUM(A.SOURCE_AMOUNT) AS LAST_DPR_AMOUNT   --(����)�����󰢺�              
            FROM FI_ASSET_DPR_HISTORY_CG A
                , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
                   FROM FI_ASSET_MASTER_CG
                   WHERE SOB_ID = W_SOB_ID
                        AND ORG_ID = W_ORG_ID
                   ) B
            WHERE A.SOB_ID = W_SOB_ID
                AND A.ORG_ID = W_ORG_ID 
                AND A.DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND A.GL_NUM = W_GL_NUM
                
                AND A.ASSET_ID = B.ASSET_ID
            GROUP BY A.ASSET_CATEGORY_ID, B.EXPENSE_TYPE, A.COST_CENTER_ID
        )    
    ORDER BY ASSET_CATEGORY_ID, EXPENSE_TYPE, COST_CENTER_ID   ;

END LIST_SLIP_JOURNAL;







--��ǥ���ڻ���� ��ȸ
PROCEDURE LIST_SLIP_ASSET(
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_DPR_HISTORY_CG.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID  IN  FI_ASSET_DPR_HISTORY_CG.ORG_ID%TYPE    --����ξ��̵�
    , W_GL_NUM  IN  FI_ASSET_DPR_HISTORY_CG.GL_NUM%TYPE    --��ǥ��ȣ  
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID              --ȸ����̵�
        , A.ORG_ID              --����ξ��̵�       
        , A.PERIOD_NAME         --�󰢳��    
        , A.ASSET_CATEGORY_ID   --�ڻ��������̵�
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --�ڻ�����
        , B.EXPENSE_TYPE    --��񱸺�
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', B.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --��񱸺�     
        , A.COST_CENTER_ID  --�������̵�
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������      
        , A.ASSET_ID                            --�ڻ���̵�
        , B.ASSET_CODE                          --�ڻ��ڵ�
        , B.ASSET_DESC                          --�ڻ��       
        , A.DPR_COUNT                           --��ȸ��    
        , A.SOURCE_AMOUNT AS LAST_DPR_AMOUNT    --(����)�����󰢺�   
        , A.SLIP_DATE   --��ǥ����
        , A.GL_NUM      --��ǥ��ȣ               
        , A.DPR_TYPE    --ȸ�豸��_�ڵ�[20 : IFRS]
        , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', A.DPR_TYPE, A.SOB_ID) AS DPR_TYPE_NM   --ȸ�豸��
        , A.DPR_METHOD_TYPE --�����󰢹��_�ڵ�
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.DPR_METHOD_TYPE, A.SOB_ID) AS DPR_METHOD_TYPE_NM   --�����󰢹��          
    FROM FI_ASSET_DPR_HISTORY_CG A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
           FROM FI_ASSET_MASTER_CG
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
        AND A.GL_NUM = W_GL_NUM
        
        AND A.ASSET_ID = B.ASSET_ID
    ORDER BY A.ASSET_CATEGORY_ID, B.EXPENSE_TYPE, A.COST_CENTER_ID, B.ASSET_CODE    ;

END LIST_SLIP_ASSET;


END FI_ASSET_DPR_HISTORY_CG_G;
/
