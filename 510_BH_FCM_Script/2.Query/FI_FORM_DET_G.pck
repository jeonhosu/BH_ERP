CREATE OR REPLACE PACKAGE FI_FORM_DET_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_DET_G
Description  : �繫��ǥ���� ���_�� Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : (�繫��ǥ�������)
Program History :
    ���� FI_FORM_LINE ���̺��� ��ü�Ͽ� ������ ���� FI_FORM_DET ���̺��� �����ϴ� Package�̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-30   Leem Dong Ern(�ӵ���)          
*****************************************************************************/



--�繫��ǥ���� ��� => �� grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_FORM_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_CODE	    IN FI_FORM_DET.ITEM_CODE%TYPE	    --�׸��ڵ�_�����ڵ�
);





--�繫��ǥ���� ��� => �� grid ���׸��ڵ� Į���� ���̴� POPUP
PROCEDURE POP_DET_ITEM_CODE( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --�׸񷹺�
);




--�繫��ǥ���� ��� => �� grid�� �ű� �׸� �߰�
PROCEDURE INSERT_FORM_DET( 
      P_SOB_ID	            IN	FI_FORM_DET.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN	FI_FORM_DET.ORG_ID%TYPE	            --����ξ��̵�
    , P_FS_SET_ID	        IN	FI_FORM_DET.FS_SET_ID%TYPE	        --�������ؼ�Ʈ���̵�
    , P_FORM_TYPE_ID	    IN	FI_FORM_DET.FORM_TYPE_ID%TYPE	    --�������ID(�����ڵ�)
    , P_ITEM_CODE	        IN	FI_FORM_DET.ITEM_CODE%TYPE	        --�׸��ڵ�_�����ڵ�    
    , P_DET_ITEM_CODE	    IN	FI_FORM_DET.DET_ITEM_CODE%TYPE	    --���׸��ڵ�
    , P_ITEM_SIGN_SHOW	    IN	FI_FORM_DET.ITEM_SIGN_SHOW%TYPE	    --�����ȣ(+/-)    
    , P_ENABLED_FLAG	    IN	FI_FORM_DET.ENABLED_FLAG%TYPE	    --��뿩��
    , P_REMARKS	            IN	FI_FORM_DET.REMARKS%TYPE	        --���
    , P_CREATED_BY	        IN	FI_FORM_DET.CREATED_BY%TYPE	        --������
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --�׸񷹺�
    , P_FORM_SEQ	        OUT	FI_FORM_DET.FORM_SEQ%TYPE	        --�繫��ǥ�����Ϸù�ȣ
);





--�繫��ǥ���� ��� => �� grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_FORM_DET( 
      W_SOB_ID              IN FI_FORM_DET.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN FI_FORM_DET.ORG_ID%TYPE              --����ξ��̵�
    , W_FS_SET_ID           IN FI_FORM_DET.FS_SET_ID%TYPE           --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID        IN FI_FORM_DET.FORM_TYPE_ID%TYPE        --�������ID(�����ڵ�)
    , W_ITEM_CODE           IN FI_FORM_DET.ITEM_CODE%TYPE           --�׸��ڵ�_�����ڵ�
    , W_FORM_SEQ            IN FI_FORM_DET.FORM_SEQ%TYPE            --�繫��ǥ�����Ϸù�ȣ
    
    , P_DET_ITEM_CODE       IN FI_FORM_DET.DET_ITEM_CODE%TYPE       --���׸��ڵ�
    , P_ITEM_SIGN_SHOW      IN FI_FORM_DET.ITEM_SIGN_SHOW%TYPE      --�����ȣ(+/-)    
    , P_ENABLED_FLAG        IN FI_FORM_DET.ENABLED_FLAG%TYPE        --��뿩��
    , P_REMARKS             IN FI_FORM_DET.REMARKS%TYPE             --���
    , P_LAST_UPDATED_BY     IN FI_FORM_DET.LAST_UPDATED_BY%TYPE     --������
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --�׸񷹺�
);




--�繫��ǥ���� ��� => �� grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_FORM_DET( 
      W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_CODE       IN FI_FORM_DET.ITEM_CODE%TYPE       --�׸��ڵ�_�����ڵ�
    , W_FORM_SEQ        IN FI_FORM_DET.FORM_SEQ%TYPE        --�繫��ǥ�����Ϸù�ȣ
);





--������ ���� ��Ŀ� ��ϵ� ������������ ���ϴ� �����Լ�.
FUNCTION LAST_ITEM_LEVEL_F(
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
) RETURN NUMBER;





END FI_FORM_DET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FORM_DET_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_DET_G
Description  : �繫��ǥ���� ���_�� Package Body

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : 
Program History :
    ���� FI_FORM_LINE ���̺��� ��ü�Ͽ� ������ ���� FI_FORM_DET ���̺��� �����ϴ� Package�̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-30   Leem Dong Ern(�ӵ���)          
*****************************************************************************/





--�繫��ǥ���� ��� => �� grid�� ��ȸ�Ǵ� �ڷ� ����

PROCEDURE LIST_FORM_DET( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_CODE	    IN	FI_FORM_DET.ITEM_CODE%TYPE	    --�׸��ڵ�_�����ڵ�
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , FS_SET_ID	        --�������ؼ�Ʈ���̵�
        , FORM_TYPE_ID	    --�������ID(�����ڵ�)    
        , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , FORM_SEQ	        --�繫��ǥ�����Ϸù�ȣ
        , DET_ITEM_CODE     --���׸��ڵ�
        
        , DECODE(ACCOUNT_CONTROL_ID, NULL
            , (
                SELECT ITEM_NAME
                FROM FI_FORM_MST
                WHERE   SOB_ID          = A.SOB_ID          --ȸ����̵�
                    AND ORG_ID          = A.ORG_ID          --����ξ��̵�
                    AND FS_SET_ID       = A.FS_SET_ID       --�������ؼ�Ʈ���̵�
                    AND FORM_TYPE_ID    = A.FORM_TYPE_ID    --�������ID(�����ڵ�)
                    AND ITEM_CODE       = A.DET_ITEM_CODE   --�׸��ڵ�_�����ڵ� 
                
              )  --�׸��        
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(ACCOUNT_CONTROL_ID, SOB_ID)  --������
          ) AS DET_ITEM_NAME  --���׸��
          
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ITEM_SIGN_SHOW    --�����ȣ(+/-)
        , ENABLED_FLAG	    --��뿩��
        
        --�Է��� �����׸��� �����ڵ����� �׸��ڵ������� ���� ���а����� �繫��ǥ �� ���� �� �ٰ��� �Ǵ� �����̴�.
        , DECODE(ACCOUNT_CONTROL_ID, NULL, '�׸�', '����') AS ACC_ITEM_GB   --����/�׸񱸺�
        
        , REMARKS	        --���
        , 0 AS ITEM_LEVEL   --�����Ϳ��� ��å�� �׸��� ������ �������� �ӽÿ���.

    FROM FI_FORM_DET A
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_ITEM_CODE       --�׸��ڵ�_�����ڵ�      
    ORDER BY DET_ITEM_CODE;  --���׸��ڵ�

END LIST_FORM_DET;






--�繫��ǥ���� ��� => �� grid ���׸��ڵ� Į���� ���Ǵ� POPUP
PROCEDURE POP_DET_ITEM_CODE( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --�׸񷹺�    
)

AS

t_LAST_ITEM_LEVEL NUMBER := 0;   --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.

BEGIN
    
    t_LAST_ITEM_LEVEL := LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, W_FORM_TYPE_ID);
    
    IF W_ITEM_LEVEL = t_LAST_ITEM_LEVEL THEN
        --������ �׸��忡�� ������ �׸��� ������ �������̸� �����ڵ带 �����ش�.(�������̺� : FI_ACCOUNT_CONTROL)
        
        OPEN P_CURSOR FOR
        SELECT
              ACCOUNT_DESC AS ITEM_NAME	    --�׸��; ������    
            , ACCOUNT_CODE AS ITEM_CODE	    --�׸��ڵ�; �����ڵ�             
        FROM FI_ACCOUNT_CONTROL
        WHERE   SOB_ID          = W_SOB_ID  --ȸ����̵�
            AND ORG_ID          = W_ORG_ID  --����ξ��̵�
            AND ACCOUNT_SET_ID  = '10'      --������Ʈ���̵�
        ORDER BY ACCOUNT_CODE
        ;
    ELSE
        --������ �׸��忡�� ������ �׸��� ������ �������� �ƴϸ� �׸��ڵ带 �����ش�.(�������̺� : FI_FORM_MST)
    
        OPEN P_CURSOR FOR
        SELECT
              ITEM_NAME	    --�׸��    
            , ITEM_CODE	    --�׸��ڵ�; �׸��ڵ�_�����ڵ�             
        FROM FI_FORM_MST
        WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
            AND ORG_ID          = W_ORG_ID          --����ξ��̵�
            AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
            AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
            
            --�ڱⷹ������ 1���� ū ������ �ڷḦ �����ش�.
            --(��>������ �׸��� ������ 2�����̸� �˾����� 3������ �ڷᰡ ��ȸ�ȴ�.)
            AND ITEM_LEVEL      = W_ITEM_LEVEL + 1  --�׸񷹺�
            --AND ENABLED_FLAG    = 'Y'               --���(ǥ��)����
        ORDER BY ITEM_CODE
        ;    
    END IF;

END POP_DET_ITEM_CODE;






--�繫��ǥ���� ��� => �� grid�� �ű� �׸� �߰�
PROCEDURE INSERT_FORM_DET( 
      P_SOB_ID	            IN	FI_FORM_DET.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN	FI_FORM_DET.ORG_ID%TYPE	            --����ξ��̵�
    , P_FS_SET_ID	        IN	FI_FORM_DET.FS_SET_ID%TYPE	        --�������ؼ�Ʈ���̵�
    , P_FORM_TYPE_ID	    IN	FI_FORM_DET.FORM_TYPE_ID%TYPE	    --�������ID(�����ڵ�)
    , P_ITEM_CODE	        IN	FI_FORM_DET.ITEM_CODE%TYPE	        --�׸��ڵ�_�����ڵ�
    , P_DET_ITEM_CODE	    IN	FI_FORM_DET.DET_ITEM_CODE%TYPE	    --���׸��ڵ�
    , P_ITEM_SIGN_SHOW	    IN	FI_FORM_DET.ITEM_SIGN_SHOW%TYPE	    --�����ȣ(+/-)    
    , P_ENABLED_FLAG	    IN	FI_FORM_DET.ENABLED_FLAG%TYPE	    --��뿩��
    , P_REMARKS	            IN	FI_FORM_DET.REMARKS%TYPE	        --���
    , P_CREATED_BY	        IN	FI_FORM_DET.CREATED_BY%TYPE	        --������
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --�׸񷹺�
    , P_FORM_SEQ	        OUT	FI_FORM_DET.FORM_SEQ%TYPE	        --�繫��ǥ�����Ϸù�ȣ
)

AS

t_RECORD_COUNT          NUMBER := 0;
t_LAST_ITEM_LEVEL       NUMBER := 0;   --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.
t_ACCOUNT_CONTROL_ID    FI_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID%TYPE := NULL;   --�����������̵�
V_SYSDATE               DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

    --�߰��Ϸ��� �ڷᰡ �̹� �����ϴ����� �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO t_RECORD_COUNT
    FROM FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = P_ITEM_CODE       --�׸��ڵ�_�����ڵ�
        AND DET_ITEM_CODE   = P_DET_ITEM_CODE   --���׸��ڵ�
    ;    
    
    --FCM_10273, ������ �ڵ��� �ڷᰡ �����Ͽ� ����� �� �����ϴ�. Ȯ�ιٶ��ϴ�.
    IF t_RECORD_COUNT > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10273', NULL));
    END IF;
   
    t_LAST_ITEM_LEVEL := LAST_ITEM_LEVEL_F(P_SOB_ID, P_ORG_ID, P_FS_SET_ID, P_FORM_TYPE_ID);
    
    IF P_ITEM_LEVEL = t_LAST_ITEM_LEVEL THEN
        --������ �׸��忡�� ������ �׸��� ������ �������̸� �Է��� [���׸��ڵ�]���� �����̹Ƿ� 
        --[�����������̵�] ���� �������ش�.
        SELECT ACCOUNT_CONTROL_ID
        INTO t_ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_CODE = P_DET_ITEM_CODE  ;        
    END IF; 


    --�繫��ǥ�����Ϸù�ȣ
    SELECT NVL(MAX(FORM_SEQ), 0) + 1
    INTO P_FORM_SEQ
    FROM FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = P_ITEM_CODE       --�׸��ڵ�_�����ڵ�  
    ;             



    INSERT INTO FI_FORM_DET(
          SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        , FS_SET_ID	            --�������ؼ�Ʈ���̵�
        , FORM_TYPE_ID	        --�������ID(�����ڵ�)
        , ITEM_CODE	            --�׸��ڵ�_�����ڵ�        
        , FORM_SEQ	            --�繫��ǥ�����Ϸù�ȣ
        , DET_ITEM_CODE	        --���׸��ڵ�
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ITEM_SIGN_SHOW	    --�����ȣ(+/-)        
        , ENABLED_FLAG	        --��뿩��
        , REMARKS	            --���
        , CREATION_DATE         --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE      --������
        , LAST_UPDATED_BY	    --������          
    )
    VALUES(
          P_SOB_ID	            --ȸ����̵�
        , P_ORG_ID	            --����ξ��̵�
        , P_FS_SET_ID	        --�������ؼ�Ʈ���̵�
        , P_FORM_TYPE_ID	    --�������ID(�����ڵ�)
        , P_ITEM_CODE	        --�׸��ڵ�_�����ڵ�  
        , P_FORM_SEQ            --�繫��ǥ�����Ϸù�ȣ
/*        
        , (
            SELECT NVL(MAX(FORM_SEQ), 0) + 1
            FROM FI_FORM_DET
            WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
                AND ORG_ID          = P_ORG_ID          --����ξ��̵�
                AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
                AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
                AND ITEM_CODE       = P_ITEM_CODE       --�׸��ڵ�_�����ڵ�        
          )   --�繫��ǥ�����Ϸù�ȣ
*/          
        , P_DET_ITEM_CODE	    --���׸��ڵ�
        , t_ACCOUNT_CONTROL_ID  --�����������̵�
        , NVL(P_ITEM_SIGN_SHOW, '+')	    --�����ȣ(+/-)        
        , P_ENABLED_FLAG	    --��뿩��
        , P_REMARKS	            --���
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������    
    );

END INSERT_FORM_DET;







--�繫��ǥ���� ��� => �� grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_FORM_DET( 
      W_SOB_ID              IN FI_FORM_DET.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN FI_FORM_DET.ORG_ID%TYPE              --����ξ��̵�
    , W_FS_SET_ID           IN FI_FORM_DET.FS_SET_ID%TYPE           --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID        IN FI_FORM_DET.FORM_TYPE_ID%TYPE        --�������ID(�����ڵ�)
    , W_ITEM_CODE           IN FI_FORM_DET.ITEM_CODE%TYPE           --�׸��ڵ�_�����ڵ�
    , W_FORM_SEQ            IN FI_FORM_DET.FORM_SEQ%TYPE            --�繫��ǥ�����Ϸù�ȣ
    
    , P_DET_ITEM_CODE       IN FI_FORM_DET.DET_ITEM_CODE%TYPE       --���׸��ڵ�
    , P_ITEM_SIGN_SHOW      IN FI_FORM_DET.ITEM_SIGN_SHOW%TYPE      --�����ȣ(+/-)    
    , P_ENABLED_FLAG        IN FI_FORM_DET.ENABLED_FLAG%TYPE        --��뿩��
    , P_REMARKS             IN FI_FORM_DET.REMARKS%TYPE             --���
    , P_LAST_UPDATED_BY     IN FI_FORM_DET.LAST_UPDATED_BY%TYPE     --������
    
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --�׸񷹺�
)

AS

t_LAST_ITEM_LEVEL       NUMBER := 0;   --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.
t_ACCOUNT_CONTROL_ID    FI_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID%TYPE := NULL;   --�����������̵�

BEGIN

    t_LAST_ITEM_LEVEL := LAST_ITEM_LEVEL_F(W_SOB_ID, W_ORG_ID, W_FS_SET_ID, W_FORM_TYPE_ID);
    
    IF P_ITEM_LEVEL = t_LAST_ITEM_LEVEL THEN
        --������ �׸��忡�� ������ �׸��� ������ �������̸� �Է��� [���׸��ڵ�]���� �����̹Ƿ� 
        --[�����������̵�] ���� �������ش�.
        SELECT ACCOUNT_CONTROL_ID
        INTO t_ACCOUNT_CONTROL_ID
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_CODE = P_DET_ITEM_CODE  ;        
    END IF; 

    UPDATE FI_FORM_DET
    SET
          DET_ITEM_CODE         = P_DET_ITEM_CODE           --���׸��ڵ�
        , ACCOUNT_CONTROL_ID    = t_ACCOUNT_CONTROL_ID      --�����������̵�   
        , ITEM_SIGN_SHOW        = P_ITEM_SIGN_SHOW          --�����ȣ(+/-)         
        , ENABLED_FLAG          = P_ENABLED_FLAG            --��뿩��    
        , REMARKS               = P_REMARKS                 --���
        , LAST_UPDATE_DATE      = GET_LOCAL_DATE(W_SOB_ID)  --������
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY         --������
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_ITEM_CODE       --�׸��ڵ�_�����ڵ�
        AND FORM_SEQ        = W_FORM_SEQ        --�繫��ǥ�����Ϸù�ȣ
    ;

END UPDATE_FORM_DET;





--�繫��ǥ���� ��� => �� grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_FORM_DET( 
      W_SOB_ID          IN FI_FORM_DET.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_DET.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_DET.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_DET.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_CODE       IN FI_FORM_DET.ITEM_CODE%TYPE       --�׸��ڵ�_�����ڵ�
    , W_FORM_SEQ        IN FI_FORM_DET.FORM_SEQ%TYPE        --�繫��ǥ�����Ϸù�ȣ
)

AS

BEGIN

    DELETE FI_FORM_DET
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_ITEM_CODE       --�׸��ڵ�_�����ڵ�
        AND FORM_SEQ        = W_FORM_SEQ        --�繫��ǥ�����Ϸù�ȣ
    ;

END DELETE_FORM_DET;





--������ ���� ��Ŀ� ��ϵ� ������������ ���ϴ� �����Լ�.
FUNCTION LAST_ITEM_LEVEL_F(
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
) RETURN NUMBER

AS

t_LAST_ITEM_LEVEL NUMBER := 0;   --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.

BEGIN

    SELECT NVL(MAX(ITEM_LEVEL), 0)
    INTO t_LAST_ITEM_LEVEL
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
    ;
    
    RETURN t_LAST_ITEM_LEVEL;

END LAST_ITEM_LEVEL_F;





END FI_FORM_DET_G;
/
