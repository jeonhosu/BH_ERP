CREATE OR REPLACE PACKAGE FI_ASSET_CATEGORY_CG_G
AS

-- ������ ���濡 ���� �ý��� �߰� ���� -- 

--��ȸ
PROCEDURE LIST_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
);









--�ű��ڷ� ���
PROCEDURE INS_ASSET_CATEGORY_CG( 
      P_SOB_ID                  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE               --ȸ����̵�
    , P_ASSET_CATEGORY_CODE     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE  --�ڻ������ڵ�      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --�ڻ�������Ī
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --�ڻ�����(1:�����ڻ�, 2:�����ڻ�)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --(IFRS)�����󰢹�� 1:����,2:����
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --(IFRS)������
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --(IFRS)������ġ
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --���

    , P_CREATED_BY              IN FI_ASSET_CATEGORY_CG.CREATED_BY%TYPE            --������
);










--����
PROCEDURE UPD_ASSET_CATEGORY_CG( 
      W_SOB_ID                  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --ȸ����̵�
    , W_ASSET_CATEGORY_CODE     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --�ڻ걸���ڵ�
      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --�ڻ걸�и�Ī
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --�ڻ�����(1:�����ڻ�, 2:�����ڻ�)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --IFRS_�����󰢹�� 1:����,2:����
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --IFRS_������
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --IFRS_������ġ
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --���

    , P_LAST_UPDATED_BY         IN FI_ASSET_CATEGORY_CG.LAST_UPDATED_BY%TYPE       --����������
);








--����
PROCEDURE DEL_ASSET_CATEGORY_CG(
      W_SOB_ID                  IN FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --ȸ����̵�
    , W_ASSET_CATEGORY_CODE     IN FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --�ڻ걸���ڵ�
);







--�ڻ����� POPUP
PROCEDURE POPUP_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
);






--�ڻ������� ��ȯ
FUNCTION  F_ASSET_CATEGORY_NAME( 
    W_ASSET_CATEGORY_ID   IN   FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_ID%TYPE
) RETURN VARCHAR2;



END FI_ASSET_CATEGORY_CG_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_CATEGORY_CG_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ASSET_CATEGORY_CG_G
/* Description  : (����)�����ڻ� ī�װ� ����.
/*
/* Reference by :
/* Program History :
-- ������ ���濡 ���� �ý��� �߰� ���� -- 
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 2013-10-21  Jeon Ho Su          Initialize
/******************************************************************************/

--��ȸ
PROCEDURE LIST_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	            --ȸ����̵�
        , ASSET_CATEGORY_ID	    --�ڻ��������̵�
        , ASSET_CATEGORY_CODE	--�ڻ������ڵ�
        , ASSET_CATEGORY_NAME	--�ڻ�������Ī
        , (
            SELECT COUNT(*)
            FROM FI_ASSET_MASTER
            WHERE SOB_ID = W_SOB_ID
                AND ASSET_CATEGORY_ID = A.ASSET_CATEGORY_ID
          ) AS ASSET_CNT    --�ڻ��ϰǼ�
        , ASSET_TYPE        --�ڻ�����_�ڵ�(1:�����ڻ�, 2:�����ڻ�)
        , FI_COMMON_G.CODE_NAME_F('ASSET_TYPE', ASSET_TYPE, SOB_ID, NULL) AS ASSET_TYPE_NM  --�ڻ�����_��
        , IFRS_DPR_METHOD_TYPE	--IFRS_�����󰢹��_�ڵ�(1:����,2:����)
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', IFRS_DPR_METHOD_TYPE, SOB_ID, NULL) AS IFRS_DPR_METHOD_TYPE_NM --�����󰢹��
        , IFRS_PROGRESS_YEAR	--IFRS_������
        , IFRS_RESIDUAL_AMOUNT	--IFRS ������ġ
        , REMARK                --���
    FROM FI_ASSET_CATEGORY_CG A
    WHERE SOB_ID = W_SOB_ID
    ORDER BY ASSET_CATEGORY_CODE    ;

END LIST_ASSET_CATEGORY_CG;









--�ű��ڷ� ���
PROCEDURE INS_ASSET_CATEGORY_CG( 
      P_SOB_ID                  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE               --ȸ����̵�
    , P_ASSET_CATEGORY_CODE     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE  --�ڻ������ڵ�      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --�ڻ�������Ī
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --�ڻ�����(1:�����ڻ�, 2:�����ڻ�)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --(IFRS)�����󰢹�� 1:����,2:����
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --(IFRS)������
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --(IFRS)������ġ
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --���

    , P_CREATED_BY              IN FI_ASSET_CATEGORY_CG.CREATED_BY%TYPE            --������
)

AS

V_SYSDATE   DATE := GET_LOCAL_DATE(P_SOB_ID);
t_CNT NUMBER := 0;

BEGIN

    --�����ڷ� ���� ���� �ľ�(KEY �ߺ� ���� �ľ�)    
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_CATEGORY_CG
    WHERE SOB_ID = P_SOB_ID
        AND ASSET_CATEGORY_CODE = P_ASSET_CATEGORY_CODE ;

    
    IF t_CNT > 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;


    INSERT INTO FI_ASSET_CATEGORY_CG( 
          ASSET_CATEGORY_ID --�ڻ걸�о��̵�
        , ASSET_CATEGORY_CODE   --�ڻ걸���ڵ�
        , ASSET_CATEGORY_NAME   --�ڻ걸�и�Ī
        , SOB_ID                --ȸ����̵�
        , ASSET_TYPE            --�ڻ�����(1:�����ڻ�, 2:�����ڻ�)
        , IFRS_DPR_METHOD_TYPE  --IFRS_�����󰢹�� 1:����,2:����
        , IFRS_PROGRESS_YEAR    --IFRS_������
        , IFRS_RESIDUAL_AMOUNT  --IFRS_������ġ
        , REMARK                --���
        , CREATION_DATE         --��������
        , CREATED_BY            --������
        , LAST_UPDATE_DATE      --������������
        , LAST_UPDATED_BY       --���������� 
    )
    VALUES
    ( 
          (SELECT NVL(MAX(ASSET_CATEGORY_ID), 0) + 1 FROM FI_ASSET_CATEGORY_CG)    --�ڻ걸�о��̵�
        , P_ASSET_CATEGORY_CODE     --�ڻ걸���ڵ�
        , P_ASSET_CATEGORY_NAME     --�ڻ걸�и�Ī
        , P_SOB_ID                  --ȸ����̵�
        , P_ASSET_TYPE              --�ڻ�����(1:�����ڻ�, 2:�����ڻ�)
        , P_IFRS_DPR_METHOD_TYPE    --IFRS_�����󰢹�� 1:����,2:����
        , P_IFRS_PROGRESS_YEAR      --IFRS_������
        , P_IFRS_RESIDUAL_AMOUNT    --IFRS_������ġ
        , P_REMARK                  --���
        , GET_LOCAL_DATE(P_SOB_ID)  --��������
        , P_CREATED_BY              --������
        , GET_LOCAL_DATE(P_SOB_ID)  --������������
        , P_CREATED_BY              --���������� 
    );

EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);

END INS_ASSET_CATEGORY_CG;










--����
PROCEDURE UPD_ASSET_CATEGORY_CG( 
      W_SOB_ID                  IN FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --ȸ����̵�
    , W_ASSET_CATEGORY_CODE     IN FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --�ڻ걸���ڵ�
      
    , P_ASSET_CATEGORY_NAME     IN  FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE  --�ڻ걸�и�Ī
    , P_ASSET_TYPE              IN  FI_ASSET_CATEGORY_CG.ASSET_TYPE%TYPE           --�ڻ�����(1:�����ڻ�, 2:�����ڻ�)
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_CATEGORY_CG.IFRS_DPR_METHOD_TYPE%TYPE --IFRS_�����󰢹�� 1:����,2:����
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_CATEGORY_CG.IFRS_PROGRESS_YEAR%TYPE   --IFRS_������
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_CATEGORY_CG.IFRS_RESIDUAL_AMOUNT%TYPE --IFRS_������ġ
    , P_REMARK                  IN  FI_ASSET_CATEGORY_CG.REMARK%TYPE               --���    

    , P_LAST_UPDATED_BY         IN FI_ASSET_CATEGORY_CG.LAST_UPDATED_BY%TYPE       --����������
)

AS

BEGIN

    UPDATE FI_ASSET_CATEGORY_CG
    SET
          ASSET_CATEGORY_NAME   = P_ASSET_CATEGORY_NAME     --�ڻ걸�и�Ī
        , ASSET_TYPE            = P_ASSET_TYPE              --�ڻ�����       
        , IFRS_DPR_METHOD_TYPE  = P_IFRS_DPR_METHOD_TYPE    --IFRS_�����󰢹��
        , IFRS_PROGRESS_YEAR    = P_IFRS_PROGRESS_YEAR      --IFRS_������
        , IFRS_RESIDUAL_AMOUNT  = P_IFRS_RESIDUAL_AMOUNT    --IFRS_������ġ     
        , REMARK                = P_REMARK                  --���
        
        , LAST_UPDATE_DATE      = GET_LOCAL_DATE(SOB_ID)    --������������
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY         --����������
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_CODE = W_ASSET_CATEGORY_CODE ;

END UPD_ASSET_CATEGORY_CG;









--����
PROCEDURE DEL_ASSET_CATEGORY_CG(
      W_SOB_ID                  IN FI_ASSET_CATEGORY_CG.SOB_ID%TYPE                --ȸ����̵�
    , W_ASSET_CATEGORY_CODE     IN FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_CODE%TYPE   --�ڻ걸���ڵ�
)

AS

t_CNT   NUMBER := 0;
Key_Dup EXCEPTION;

BEGIN

    --�ش� �ڻ��������� ��ϵ� �ڻ��� �ִ����� �ľ��Ѵ�.        
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_ID =
                (
                    SELECT ASSET_CATEGORY_ID
                    FROM FI_ASSET_CATEGORY_CG  
                    WHERE SOB_ID = W_SOB_ID
                        AND ASSET_CATEGORY_CODE = W_ASSET_CATEGORY_CODE
                )   ;        
       
    IF t_CNT > 0 THEN
      RAISE Key_Dup;
    END IF;    


    --�ش� �ڻ��������� ��ϵ� �ڻ��� ������ �����Ѵ�.
    DELETE FI_ASSET_CATEGORY_CG
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_CODE = W_ASSET_CATEGORY_CODE ;
        
        
EXCEPTION
    WHEN Key_Dup THEN
        --FCM_10307, �����ڷ�� ������ �� �����ϴ�.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10307', NULL));

END DEL_ASSET_CATEGORY_CG;









--�ڻ����� POPUP
PROCEDURE POPUP_ASSET_CATEGORY_CG( 
      P_CURSOR  OUT TYPES.TCURSOR
    , W_SOB_ID  IN  FI_ASSET_CATEGORY_CG.SOB_ID%TYPE
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT 
          ASSET_CATEGORY_NAME   --�ڻ�������Ī
        , ASSET_CATEGORY_CODE   --�ڻ������ڵ�
        , ASSET_CATEGORY_ID     --�ڻ��������̵�
        , IFRS_DPR_METHOD_TYPE	--IFRS_�����󰢹��_�ڵ� (1:����,2:����)
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', IFRS_DPR_METHOD_TYPE, SOB_ID, NULL) AS IFRS_DPR_METHOD_TYPE_NM --�����󰢹��    
        , IFRS_PROGRESS_YEAR	--IFRS_������
        , IFRS_RESIDUAL_AMOUNT	--IFRS ������ġ         
    FROM FI_ASSET_CATEGORY_CG
    WHERE SOB_ID              = W_SOB_ID
    ORDER BY ASSET_CATEGORY_CODE    ;

END POPUP_ASSET_CATEGORY_CG;








--�ڻ������� ��ȯ
FUNCTION  F_ASSET_CATEGORY_NAME( 
    W_ASSET_CATEGORY_ID   IN   FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_ID%TYPE
) RETURN VARCHAR2

AS

t_ASSET_CATEGORY_NAME   FI_ASSET_CATEGORY_CG.ASSET_CATEGORY_NAME%TYPE := '';

BEGIN

    SELECT ASSET_CATEGORY_NAME
    INTO t_ASSET_CATEGORY_NAME
    FROM FI_ASSET_CATEGORY_CG
    WHERE ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID   ;

RETURN t_ASSET_CATEGORY_NAME;

END F_ASSET_CATEGORY_NAME   ;


END FI_ASSET_CATEGORY_CG_G;
/
