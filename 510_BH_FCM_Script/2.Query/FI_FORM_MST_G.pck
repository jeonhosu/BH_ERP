CREATE OR REPLACE PACKAGE FI_FORM_MST_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_MST_G
Description  : �繫��ǥ���� ���_������ Package

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0710(�繫��ǥ�������)
Program History :
    -.���� FI_FORM_HEADER ���̺��� ��ü�Ͽ� ������ ���� FI_FORM_MST ���̺��� �����ϴ� Package�̴�.
    -.�ϱ��� PROCEDURE �Ǵ� function �鿡 ���� 
      �������̶�� ������ �ּ��� ����������� �͵��� 1���� ���� [������İ���]�� ���õ� �͵��̴�.
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-29   Leem Dong Ern(�ӵ���)          
*****************************************************************************/



--�繫��ǥ���� ��� => �����������(FI_ACCOUNT_CONTROL) �ڷḦ �ٰ����� ���� ����� ������ �Ǵ� �ڷ� �ϰ�����
--1�ܰ� : FI_FORM_MST(�繫��ǥ�������_������) ���̺� DATA INSERT
--2�ܰ� : FI_FORM_DET(�繫��ǥ�������_��)   ���̺� DATA INSERT
PROCEDURE CREATE_FORM_MST( 
      P_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , P_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , P_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ID    
    , P_CREATED_BY	    IN FI_FORM_MST.CREATED_BY%TYPE	    --������
);



 


--�繫��ǥ���� ��� => ������ grid�� ��ȸ�Ǵ� �ڷ� ����
PROCEDURE LIST_FORM_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
);




--�繫��ǥ���� ��� => Ŭ���� �׸�� ������ �׸��� �����Ѵ�.
--Ŭ���� �׸�� �� ������ ��ϵ� �׸��� ����ȴ�.
--�̴� ȭ�鿡�� �˾����� ���Ǹ�, �����׸��� ���������� [�繫����ǥ]������ ����Ѵ�.
PROCEDURE POP_RELATE_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --�׸񷹺�
);






--�繫��ǥ���� ��� => Ŭ���� �׸��� ���� ������ Ÿ ������Ŀ� ��ϵ� �׸��� �����ش�.
--��>���Ͱ�꼭�� �����ǰ�������� �׸��� ���� �������������� �����ǰ�������� �׸��� ���� �̿��Ѵ�.
--�̴� ȭ�鿡�� �˾����� ���Ǹ�, �����׸��� ���������� [���Ͱ�꼭, �繫����ǥ]������ ����Ѵ�.
PROCEDURE POP_REF_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
);








--�繫��ǥ���� ��� => ������ grid�� �ű� �׸� �߰�
PROCEDURE INSERT_FORM_MST( 
      P_SOB_ID	            IN 	FI_FORM_MST.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN 	FI_FORM_MST.ORG_ID%TYPE	            --����ξ��̵�
    , P_FS_SET_ID	        IN 	FI_FORM_MST.FS_SET_ID%TYPE	        --�������ؼ�Ʈ���̵�
    , P_FORM_TYPE_ID	    IN 	FI_FORM_MST.FORM_TYPE_ID%TYPE	    --�������ID(�����ڵ�)
    , P_ITEM_CODE	        IN 	FI_FORM_MST.ITEM_CODE%TYPE	        --�׸��ڵ�_�����ڵ�
    , P_ITEM_NAME	        IN	FI_FORM_MST.ITEM_NAME%TYPE	        --�׸��
    , P_ACCOUNT_DR_CR	    IN	FI_FORM_MST.ACCOUNT_DR_CR%TYPE	    --���뱸��(1-����,2-�뺯)
    , P_MNS_ACCOUNT_FLAG    IN	FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE	--������������
    , P_RELATE_ITEM_CODE	IN	FI_FORM_MST.RELATE_ITEM_CODE%TYPE	--�����׸��ڵ�
    , P_SORT_SEQ	        IN	FI_FORM_MST.SORT_SEQ%TYPE	        --���ļ���
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --�׸񷹺�
    , P_ENABLED_FLAG	    IN	FI_FORM_MST.ENABLED_FLAG%TYPE	    --��뿩��
    , P_REMARKS	            IN	FI_FORM_MST.REMARKS%TYPE	        --���
    , P_CREATED_BY	        IN	FI_FORM_MST.CREATED_BY%TYPE	        --������ 

    , P_REF_FORM_TYPE_ID	IN	FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --���ú������ID(�����ڵ�)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --�����׸��ڵ�
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --����繫��ǥ�׸񿩺�
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --����ڻ�⸻�ݾװ����׸��ڵ�
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --����Ʋ��������
    
);





--�繫��ǥ���� ��� => ������ grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_FORM_MST( 
      W_SOB_ID              IN  FI_FORM_MST.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_FORM_MST.ORG_ID%TYPE              --����ξ��̵�
    , W_FS_SET_ID           IN  FI_FORM_MST.FS_SET_ID%TYPE           --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID        IN  FI_FORM_MST.FORM_TYPE_ID%TYPE        --�������ID(�����ڵ�)
    , W_ITEM_CODE           IN  FI_FORM_MST.ITEM_CODE%TYPE           --�׸��ڵ�_�����ڵ�
    
    , P_ITEM_NAME           IN  FI_FORM_MST.ITEM_NAME%TYPE           --�׸��
    , P_ACCOUNT_DR_CR       IN  FI_FORM_MST.ACCOUNT_DR_CR%TYPE       --���뱸��(1-����,2-�뺯)
    , P_MNS_ACCOUNT_FLAG    IN  FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE    --������������
    , P_RELATE_ITEM_CODE    IN  FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --�����׸��ڵ�
    , P_SORT_SEQ            IN  FI_FORM_MST.SORT_SEQ%TYPE            --���ļ���
    , P_ITEM_LEVEL          IN  FI_FORM_MST.ITEM_LEVEL%TYPE          --�׸񷹺�
    , P_ENABLED_FLAG        IN  FI_FORM_MST.ENABLED_FLAG%TYPE        --��뿩��
    , P_REMARKS             IN  FI_FORM_MST.REMARKS%TYPE             --���
    , P_LAST_UPDATED_BY     IN  FI_FORM_MST.LAST_UPDATED_BY%TYPE     --������
    
    , P_REF_FORM_TYPE_ID	IN  FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --���ú������ID(�����ڵ�)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --�����׸��ڵ�
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --����繫��ǥ�׸񿩺�
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --����ڻ�⸻�ݾװ����׸��ڵ�
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --����Ʋ��������    
);




--�繫��ǥ���� ��� => ������ grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_FORM_MST( 
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_CODE       IN FI_FORM_MST.ITEM_CODE%TYPE       --�׸��ڵ�_�����ڵ�
);






--���� �� : ����������ȸ
--���� : ����������� ���α׷������� ������ ������ ���� �繫��ǥ����� �����ߴµ�
--       �� ������ ������ �繫��ǥ��İ��� ���α׷��� �ش� ���� ��Ŀ��� ���Ե��� ����
--       �������� ��ȸ�ϰ��� ���̴�.
PROCEDURE LIST_OMISSION_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
);











--������ �׸��� �����׸��ڵ忡 ���� ���� ���ϴ� �����Լ�.
FUNCTION RELATE_ITEM_CODE_NAME_F(
      W_SOB_ID              IN FI_FORM_MST.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN FI_FORM_MST.ORG_ID%TYPE              --����ξ��̵�
    , W_FS_SET_ID           IN FI_FORM_MST.FS_SET_ID%TYPE           --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID        IN FI_FORM_MST.FORM_TYPE_ID%TYPE        --�������ID(�����ڵ�)
    , W_RELATE_ITEM_CODE    IN FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --�����׸��ڵ�
) RETURN VARCHAR2;


--�繫��ǥ���� ��� �������� ���� ������ ���� ���� üũ.
PROCEDURE GET_FORM_MST_COUNT( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FORM_TYPE_ID%TYPE     --�������ID        
    , O_RECORD_COUNT      OUT NUMBER
);

--�繫��ǥ���� ��� ���� 
--1�ܰ� : FI_FORM_MST(�繫��ǥ�������_������) ���̺� DATA INSERT
--2�ܰ� : FI_FORM_DET(�繫��ǥ�������_��)   ���̺� DATA INSERT
PROCEDURE COPY_FORM_MST( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ID    
    , P_NEW_FS_SET_ID     IN FI_FORM_MST.FS_SET_ID%TYPE       --�ű� �������ؼ�Ʈ���̵�    
    , P_NEW_FORM_TYPE_ID  IN FI_FORM_MST.FS_SET_ID%TYPE       --�ű� �������ID
    , P_USER_ID           IN FI_FORM_MST.CREATED_BY%TYPE	    --������
    , O_STATUS            OUT VARCHAR2
    , O_MESSAGE           OUT VARCHAR2
);



END FI_FORM_MST_G;
/
CREATE OR REPLACE PACKAGE BODY FI_FORM_MST_G
AS


/******************************************************************************
Project      : BH FLEX erp
Module       : Financial
Package Name : FI_FORM_MST_G
Description  : �繫��ǥ���� ���_������ Package Body

Reference by : calling assmbly-program id(ȣ�� ���α׷�) : FCMF0710(�繫��ǥ�������)
Program History :
    -.���� FI_FORM_HEADER ���̺��� ��ü�Ͽ� ������ ���� FI_FORM_MST ���̺��� �����ϴ� Package�̴�.
    -.�ϱ��� PROCEDURE �Ǵ� function �鿡 ���� 
      �������̶�� ������ �ּ��� ����������� �͵��� 1���� ���� [������İ���]�� ���õ� �͵��̴�.    
------------------------------------------------------------------------------
   Date       In Charge                  Description
------------------------------------------------------------------------------
 2011-06-29   Leem Dong Ern(�ӵ���)          
*****************************************************************************/



--�繫��ǥ���� ��� => �����������(FI_ACCOUNT_CONTROL) �ڷḦ �ٰ����� ���� ����� ������ �Ǵ� �ڷ� �ϰ�����
--1�ܰ� : FI_FORM_MST(�繫��ǥ�������_������) ���̺� DATA INSERT
--2�ܰ� : FI_FORM_DET(�繫��ǥ�������_��)   ���̺� DATA INSERT
--�ڷ� ������ �� ��ĺ��� �Ѵ�.

PROCEDURE CREATE_FORM_MST( 
      P_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , P_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , P_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID    IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ID    
    , P_CREATED_BY	    IN FI_FORM_MST.CREATED_BY%TYPE	    --������
)

AS

--t_FORM_TYPE_ID      NUMBER := 0; --�������ID(�����ڵ�)�� �������.
t_ACCOUNT_FS_TYPE   FI_ACCOUNT_CONTROL.ACCOUNT_FS_TYPE%TYPE; --�繫��ǥ���� ���� �������.


BEGIN
    
    /*
    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_FORM_MST
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
    ;
    
    
    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
    ;     
    */
    
    
    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_FORM_MST
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
    ; 

    
    
    --������ �����ϴ� �ڷᰡ ���� ��� ��� �����Ѵ�.
    DELETE FI_FORM_DET
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
    ; 
    
    


    IF P_FORM_TYPE_ID = 744 THEN   --�հ��ܾ׽û�ǥ
    
        INSERT INTO FI_FORM_MST(
              SOB_ID	        --ȸ����̵�
            , ORG_ID	        --����ξ��̵�
            , FS_SET_ID	        --�������ؼ�Ʈ���̵�
            , FORM_TYPE_ID	    --�������ID(�����ڵ�)
            , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
            , ITEM_NAME	        --�׸��
            , ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
            , MNS_ACCOUNT_FLAG	--������������
            , RELATE_ITEM_CODE	--�����׸��ڵ�
            , SORT_SEQ	        --���ļ���
            , ITEM_LEVEL	    --�׸񷹺�
            , ENABLED_FLAG	    --��뿩��
            , REMARKS	        --���
            , CREATION_DATE     --������
            , CREATED_BY	    --������
            , LAST_UPDATE_DATE  --������
            , LAST_UPDATED_BY	--������          
        )
        SELECT
              SOB_ID                    --ȸ����̵�
            , ORG_ID                    --����ξ��̵�
            , P_FS_SET_ID               --�������ؼ�Ʈ���̵�        
            , P_FORM_TYPE_ID            --�������ID            
            , ACCOUNT_CODE AS ITEM_CODE --�׸��ڵ�_�����ڵ�
            , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --�׸��
            , ACCOUNT_DR_CR             --���뱸��(1-����,2-�뺯)
            
            --����>[������������, �����׸��ڵ�]�� �繫����ǥ�� �ִ°� �´�.
            --, NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --������������
            --, RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --�����׸��ڵ�
            , 'N' AS MNS_ACCOUNT_FLAG   --������������
            , NULL AS RELATE_ITEM_CODE  --�����׸��ڵ� 
            
            , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --���ļ���
            
            --�⺻������ �� ����� ���������� �����Ѵ�.
            , (
                    SELECT VALUE1
                    FROM FI_COMMON
                    WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = P_FORM_TYPE_ID   
              ) AS ITEM_LEVEL   --�׸񷹺�
              
            , 'Y' ENABLED_FLAG                              --��뿩��
            , '' AS REMARKS                                 --���
            , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --������
            , P_CREATED_BY                                  --������
            , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --������
            , P_CREATED_BY                                  --������    
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'            
            AND ACCOUNT_FS_TYPE IN ('1002', '1003', '1004') --�� �ѹ��常 �Ʒ� ������ �ٸ���.
            --AND ACCOUNT_FS_TYPE IS NOT NULL --�� �ѹ��常 �Ʒ� ������ �ٸ���.
        ;  
        
    ELSE    --������������, ���Ͱ�꼭, �繫����ǥ(��������ǥ)
    
    
        IF P_FORM_TYPE_ID = 747 THEN        --������������ 
            t_ACCOUNT_FS_TYPE := '1004';          
        ELSIF P_FORM_TYPE_ID = 746 THEN     --���Ͱ�꼭 
            t_ACCOUNT_FS_TYPE := '1003';            
        ELSIF P_FORM_TYPE_ID = 745 THEN     --�繫����ǥ(��������ǥ)
            t_ACCOUNT_FS_TYPE := '1002';        
        END IF;        
    
    
        INSERT INTO FI_FORM_MST(
              SOB_ID	        --ȸ����̵�
            , ORG_ID	        --����ξ��̵�
            , FS_SET_ID	        --�������ؼ�Ʈ���̵�
            , FORM_TYPE_ID	    --�������ID(�����ڵ�)
            , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
            , ITEM_NAME	        --�׸��
            , ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
            , MNS_ACCOUNT_FLAG	--������������
            , RELATE_ITEM_CODE	--�����׸��ڵ�
            , SORT_SEQ	        --���ļ���
            , ITEM_LEVEL	    --�׸񷹺�
            , ENABLED_FLAG	    --��뿩��
            , REMARKS	        --���
            , CREATION_DATE     --������
            , CREATED_BY	    --������
            , LAST_UPDATE_DATE  --������
            , LAST_UPDATED_BY	--������          
        )
        SELECT
              SOB_ID                    --ȸ����̵�
            , ORG_ID                    --����ξ��̵�
            , P_FS_SET_ID               --�������ؼ�Ʈ���̵�        
            , P_FORM_TYPE_ID            --�������ID            
            , ACCOUNT_CODE AS ITEM_CODE --�׸��ڵ�_�����ڵ�
            , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --�׸��
            , ACCOUNT_DR_CR             --���뱸��(1-����,2-�뺯)
            
            --����>[������������, �����׸��ڵ�]�� �繫����ǥ�� �ִ°� �´�.
            , NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --������������
            , RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --�����׸��ڵ�
            
            , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --���ļ���
            
            --�⺻������ �� ����� ���������� �����Ѵ�.
            , (
                    SELECT VALUE1
                    FROM FI_COMMON
                    WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = P_FORM_TYPE_ID   
              ) AS ITEM_LEVEL   --�׸񷹺�
              
            , 'Y' ENABLED_FLAG                              --��뿩��
            , '' AS REMARKS                                 --���
            , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --������
            , P_CREATED_BY                                  --������
            , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --������
            , P_CREATED_BY                                  --������    
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_FS_TYPE = t_ACCOUNT_FS_TYPE --�� �ѹ��常 �� ������ �ٸ���.
        ;        
    
    END IF;



/*
    --�� �ּ� ���� ������ ������. 4���� ���� ��� ������ ������ �ƴ� �ϰ������ÿ� ����ϸ� �˴ϴ�.

    --1�ܰ� : FI_FORM_MST(�繫��ǥ�������_������) ���̺� DATA INSERT.    
    --BH���� �����ϴ� �繫��ǥ ���� ����� ��� 4���̴�.
    FOR I IN 1..4 LOOP
        IF        I = 1 THEN    --�հ��ܾ׽û�ǥ 
                BEGIN
                    t_FORM_TYPE_ID := 744;  
                    t_ACCOUNT_FS_TYPE := NULL;  --������.
                END;
            ELSIF I = 2 THEN    --������������
                BEGIN
                    t_FORM_TYPE_ID := 747;  
                    t_ACCOUNT_FS_TYPE := '1004';
                END;            
            ELSIF I = 3 THEN    --���Ͱ�꼭
                BEGIN
                    t_FORM_TYPE_ID := 746;  
                    t_ACCOUNT_FS_TYPE := '1003';
                END;             
            ELSIF I = 4 THEN    --�繫����ǥ(��������ǥ)
                BEGIN
                    t_FORM_TYPE_ID := 745;  
                    t_ACCOUNT_FS_TYPE := '1002';
                END;            
        END IF;


        --�Ʒ� IF���� �� �����ϰ� �� ���� ������ �׷� ���� �ʿ���� �� ���� �� ���·� �����Ѵ�.
        IF I = 1 THEN   --�հ��ܾ׽û�ǥ
        
            INSERT INTO FI_FORM_MST(
                  SOB_ID	        --ȸ����̵�
                , ORG_ID	        --����ξ��̵�
                , FS_SET_ID	        --�������ؼ�Ʈ���̵�
                , FORM_TYPE_ID	    --�������ID(�����ڵ�)
                , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
                , ITEM_NAME	        --�׸��
                , ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
                , MNS_ACCOUNT_FLAG	--������������
                , RELATE_ITEM_CODE	--�����׸��ڵ�
                , SORT_SEQ	        --���ļ���
                , ITEM_LEVEL	    --�׸񷹺�
                , ENABLED_FLAG	    --��뿩��
                , REMARKS	        --���
                , CREATION_DATE     --������
                , CREATED_BY	    --������
                , LAST_UPDATE_DATE  --������
                , LAST_UPDATED_BY	--������          
            )
            SELECT
                  SOB_ID                    --ȸ����̵�
                , ORG_ID                    --����ξ��̵�
                , P_FS_SET_ID               --�������ؼ�Ʈ���̵�        
                , t_FORM_TYPE_ID            --�������ID            
                , ACCOUNT_CODE AS ITEM_CODE --�׸��ڵ�_�����ڵ�
                , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --�׸��
                , ACCOUNT_DR_CR             --���뱸��(1-����,2-�뺯)
                
                --����>[������������, �����׸��ڵ�]�� �繫����ǥ�� �ִ°� �´�.
                --, NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --������������
                --, RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --�����׸��ڵ�
                , 'N' AS MNS_ACCOUNT_FLAG   --������������
                , NULL AS RELATE_ITEM_CODE  --�����׸��ڵ� 
                
                , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --���ļ���
                
                --�⺻������ �� ����� ���������� �����Ѵ�.
                , (
                        SELECT VALUE1
                        FROM FI_COMMON
                        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = t_FORM_TYPE_ID   
                  ) AS ITEM_LEVEL   --�׸񷹺�
                  
                , 'Y' ENABLED_FLAG                              --��뿩��
                , '' AS REMARKS                                 --���
                , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --������
                , P_CREATED_BY                                  --������
                , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --������
                , P_CREATED_BY                                  --������    
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
                AND ACCOUNT_FS_TYPE IS NOT NULL --�� �ѹ��常 �Ʒ� ������ �ٸ���.
            ;  
            
        ELSE    --������������, ���Ͱ�꼭, �繫����ǥ(��������ǥ)
        
            INSERT INTO FI_FORM_MST(
                  SOB_ID	        --ȸ����̵�
                , ORG_ID	        --����ξ��̵�
                , FS_SET_ID	        --�������ؼ�Ʈ���̵�
                , FORM_TYPE_ID	    --�������ID(�����ڵ�)
                , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
                , ITEM_NAME	        --�׸��
                , ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
                , MNS_ACCOUNT_FLAG	--������������
                , RELATE_ITEM_CODE	--�����׸��ڵ�
                , SORT_SEQ	        --���ļ���
                , ITEM_LEVEL	    --�׸񷹺�
                , ENABLED_FLAG	    --��뿩��
                , REMARKS	        --���
                , CREATION_DATE     --������
                , CREATED_BY	    --������
                , LAST_UPDATE_DATE  --������
                , LAST_UPDATED_BY	--������          
            )
            SELECT
                  SOB_ID                    --ȸ����̵�
                , ORG_ID                    --����ξ��̵�
                , P_FS_SET_ID               --�������ؼ�Ʈ���̵�        
                , t_FORM_TYPE_ID            --�������ID            
                , ACCOUNT_CODE AS ITEM_CODE --�׸��ڵ�_�����ڵ�
                , DECODE(ACCOUNT_DESC_S, NULL, ACCOUNT_DESC, '', ACCOUNT_DESC, ACCOUNT_DESC_S) AS ITEM_NAME  --�׸��
                , ACCOUNT_DR_CR             --���뱸��(1-����,2-�뺯)
                
                --����>[������������, �����׸��ڵ�]�� �繫����ǥ�� �ִ°� �´�.
                , NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --������������
                , RELATE_ACCOUNT_CODE AS RELATE_ITEM_CODE           --�����׸��ڵ�
                
                , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) * 100 AS SORT_SEQ  --���ļ���
                
                --�⺻������ �� ����� ���������� �����Ѵ�.
                , (
                        SELECT VALUE1
                        FROM FI_COMMON
                        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND COMMON_ID = t_FORM_TYPE_ID   
                  ) AS ITEM_LEVEL   --�׸񷹺�
                  
                , 'Y' ENABLED_FLAG                              --��뿩��
                , '' AS REMARKS                                 --���
                , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --������
                , P_CREATED_BY                                  --������
                , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --������
                , P_CREATED_BY                                  --������    
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
                AND ACCOUNT_FS_TYPE = t_ACCOUNT_FS_TYPE --�� �ѹ��常 �� ������ �ٸ���.
            ;        
        
        END IF;

        
        --DBMS_OUTPUT.PUT_LINE('------- I : ' || I || ' t_ACCOUNT_FS_TYPE : ' || t_ACCOUNT_FS_TYPE );

    END LOOP;
*/





    --2�ܰ� : FI_FORM_DET(�繫��ǥ�������_��)   ���̺� DATA INSERT
    /*  2�ܰ� - 1
        -.FI_FORM_MST�� ������ �ڷḦ �״�� FI_FORM_DET ���̺� INSERT�Ѵ�.
        -.���� �ڽ��� �ݾ��� ���� �ڽſ��� ����Ǵ� ������ ��� �翬�ϰ�,
        -.������ ��ǥ�Է��ϴ� ������ �ƴ� ��ǥ������ ��쿡�� ������ ���� �ڽ���
          ���� �׸� ��� �־ ��ǥ�� ��ϵ� ���� ���� ������ ���� ������ ���� �ʴ´�.
          Ȥ��, ���ʿ� �� �۾��ڰ� ���α׷��� ���� �����ϸ� �ȴ�.
          
    */
            
    INSERT INTO FI_FORM_DET(
          SOB_ID	            --ȸ����̵�
        , ORG_ID	            --����ξ��̵�
        , FS_SET_ID	            --�������ؼ�Ʈ���̵�
        , FORM_TYPE_ID	        --�������ID(�����ڵ�)
        , ITEM_CODE	            --�׸��ڵ�_�����ڵ�
        , FORM_SEQ	            --�繫��ǥ�����Ϸù�ȣ
        , DET_ITEM_CODE	        --���׸��ڵ�
        , ACCOUNT_CONTROL_ID    --�����������̵�
        , ITEM_SIGN_SHOW        --�����ȣ(+/-)
        , ENABLED_FLAG	        --��뿩��
        , REMARKS	            --���
        , CREATION_DATE	        --������
        , CREATED_BY	        --������
        , LAST_UPDATE_DATE	    --������
        , LAST_UPDATED_BY	    --������    
    )
    SELECT 
          SOB_ID        --ȸ����̵�
        , ORG_ID        --����ξ��̵�
        , FS_SET_ID     --�������ؼ�Ʈ���̵�        
        , FORM_TYPE_ID  --�������ID(�����ڵ�)            
        , ITEM_CODE     --�׸��ڵ�_�����ڵ�
        
        , ROW_NUMBER() OVER(ORDER BY ITEM_CODE ASC) AS FORM_SEQ --�繫��ǥ�����Ϸù�ȣ        
        , ITEM_CODE AS DET_ITEM_CODE                            --���׸��ڵ�
        
        , ( SELECT ACCOUNT_CONTROL_ID
            FROM FI_ACCOUNT_CONTROL
            WHERE SOB_ID = A.SOB_ID AND ORG_ID = A.ORG_ID AND ACCOUNT_SET_ID = '10' AND ACCOUNT_CODE = A.ITEM_CODE )
            AS ACCOUNT_CONTROL_ID --�����������̵�
            
        , '+' AS ITEM_SIGN_SHOW                         --�����ȣ(+/-)        
        , 'Y' ENABLED_FLAG                              --��뿩��
        , '' AS REMARKS                                 --���
        , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --������
        , P_CREATED_BY                                  --������
        , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --������
        , P_CREATED_BY                                  --������ 
    FROM FI_FORM_MST A
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵� 
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
    ; 



    --2�ܰ� - 2
    --FI_ACCOUNT_CONTROL ���̺��� �������� �ڱ⸦ ������������ �ϰ� �ִ� �������� INSERT�Ѵ�.

	FOR C_REC IN (
        SELECT
              FORM_TYPE_ID  --�������ID(�����ڵ�)
            , ITEM_CODE     --�׸��ڵ�_�����ڵ�
        FROM FI_FORM_DET
        WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
            AND ORG_ID          = P_ORG_ID          --����ξ��̵�
            AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
            AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
    ) LOOP
    
        INSERT INTO FI_FORM_DET(
              SOB_ID	            --ȸ����̵�
            , ORG_ID	            --����ξ��̵�
            , FS_SET_ID	            --�������ؼ�Ʈ���̵�
            , FORM_TYPE_ID	        --�������ID(�����ڵ�)
            , ITEM_CODE	            --�׸��ڵ�_�����ڵ�
            , FORM_SEQ	            --�繫��ǥ�����Ϸù�ȣ
            , DET_ITEM_CODE	        --���׸��ڵ�
            , ACCOUNT_CONTROL_ID    --�����������̵�
            , ITEM_SIGN_SHOW        --�����ȣ(+/-)
            , ENABLED_FLAG	        --��뿩��
            , REMARKS	            --���
            , CREATION_DATE	        --������
            , CREATED_BY	        --������
            , LAST_UPDATE_DATE	    --������
            , LAST_UPDATED_BY	    --������    
        )
        SELECT 
              SOB_ID                --ȸ����̵�
            , ORG_ID                --����ξ��̵�
            , P_FS_SET_ID           --�������ؼ�Ʈ���̵�        
            , C_REC.FORM_TYPE_ID    --�������ID(�����ڵ�)            
            , C_REC.ITEM_CODE       --�׸��ڵ�_�����ڵ�
            
            --[+ 1000]�� �� ������ ���������� 1000���� ������������ �����ϰ� �Ϸù�ȣ�� ä���ϱ� ���ؼ��̴�.
            , ROW_NUMBER() OVER(ORDER BY ACCOUNT_CODE ASC) + 1000 AS FORM_SEQ --�繫��ǥ�����Ϸù�ȣ
            , ACCOUNT_CODE AS DET_ITEM_CODE                 --���׸��ڵ� 
            , ACCOUNT_CONTROL_ID                            --�����������̵�
            , '+' AS ITEM_SIGN_SHOW                         --�����ȣ(+/-)            
            , 'Y' ENABLED_FLAG                              --��뿩��
            , '' AS REMARKS                                 --���
            , GET_LOCAL_DATE(SOB_ID) AS CREATION_DATE       --������
            , P_CREATED_BY                                  --������
            , GET_LOCAL_DATE(SOB_ID) AS LAST_UPDATE_DATE    --������
            , P_CREATED_BY                                  --������
        FROM FI_ACCOUNT_CONTROL
        WHERE SOB_ID = P_SOB_ID AND ORG_ID = P_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND UP_ACCOUNT_CODE = C_REC.ITEM_CODE
        ;
        
    END LOOP;
    
    EXCEPTION
        WHEN OTHERS THEN
           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10278', NULL) || ' ( ' || SQLERRM || ' )');  

END CREATE_FORM_MST;















--�繫��ǥ���� ��� => ������ grid�� ��ȸ�Ǵ� �ڷ� ����

PROCEDURE LIST_FORM_MST( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          SOB_ID	    --ȸ����̵�
        , ORG_ID	    --����ξ��̵�
        , FS_SET_ID	    --�������ؼ�Ʈ���̵�
        , FORM_TYPE_ID	--�������ID(�����ڵ�)    
        , ITEM_CODE	    --�׸��ڵ�_�����ڵ�        
        , ITEM_NAME	    --�׸��
        , ACCOUNT_DR_CR	--���뱸��(1-����,2-�뺯)
        , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', ACCOUNT_DR_CR, SOB_ID) AS ACCOUNT_DR_CR_NAME
        , NVL(MNS_ACCOUNT_FLAG, 'N') AS MNS_ACCOUNT_FLAG    --������������
        , RELATE_ITEM_CODE                                  --�����׸��ڵ�
        , RELATE_ITEM_CODE_NAME_F(SOB_ID, ORG_ID, FS_SET_ID, FORM_TYPE_ID, RELATE_ITEM_CODE) AS RELATE_ITEM_CODE_NAME                             --�����׸��ڵ�_��
        , SORT_SEQ	                                        --���ļ���
        , ITEM_LEVEL	                                    --�׸񷹺�
        , ENABLED_FLAG	                                    --��뿩��
        , REMARKS	                                        --���
        
        , REF_FORM_TYPE_ID                                              --���ú������ID(�����ڵ�)
        , FI_COMMON_G.ID_NAME_F(REF_FORM_TYPE_ID) AS REF_FORM_TYPE_NAME --���ú������    
        , REF_ITEM_CODE                                                 --�����׸��ڵ�
        , FI_FORM_MST_G.RELATE_ITEM_CODE_NAME_F(SOB_ID, ORG_ID, FS_SET_ID, REF_FORM_TYPE_ID, REF_ITEM_CODE) AS REF_ITEM_CODE_NAME --�����׸�
        , NVL(SUMMARY_YN, 'N')AS SUMMARY_YN                             --����繫��ǥ�׸񿩺�
        
        , FORM_ITEM_TYPE_CD --����ڻ�⸻�ݾװ����׸��ڵ�
        , FI_COMMON_G.CODE_NAME_F('FORM_ITEM_TYPE', FORM_ITEM_TYPE_CD, SOB_ID) AS FORM_ITEM_TYPE_NAME
        , FORM_FRAME_YN     --����Ʋ��������        
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
    ORDER BY SORT_SEQ;

END LIST_FORM_MST;






--�繫��ǥ���� ��� => Ŭ���� �׸�� ������ �׸��� �����Ѵ�.
--Ŭ���� �׸�� �� ������ ��ϵ� �׸��� ����ȴ�.
--�̴� ȭ�鿡�� �˾����� ���Ǹ�, �����׸��� ���������� [�繫����ǥ]������ ����Ѵ�.
PROCEDURE POP_RELATE_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_LEVEL      IN FI_FORM_MST.ITEM_LEVEL%TYPE      --�׸񷹺�
)

AS

BEGIN
    OPEN P_CURSOR FOR

    SELECT
          ITEM_NAME	    --�׸��    
        , ITEM_CODE	    --�׸��ڵ�_�����ڵ�        
        , ITEM_LEVEL	--�׸񷹺�       
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_LEVEL      = W_ITEM_LEVEL      --�׸񷹺�
        AND ENABLED_FLAG    = 'Y'               --��뿩��
    ORDER BY SORT_SEQ;                          --���ļ���

END POP_RELATE_ITEM;






--�繫��ǥ���� ��� => Ŭ���� �׸��� ���� ������ Ÿ ������Ŀ� ��ϵ� �׸��� �����ش�.
--��>���Ͱ�꼭�� �����ǰ�������� �׸��� ���� �������������� �����ǰ�������� �׸��� ���� �̿��Ѵ�.
--�̴� ȭ�鿡�� �˾����� ���Ǹ�, �����׸��� ���������� [���Ͱ�꼭, �繫����ǥ]������ ����Ѵ�.
PROCEDURE POP_REF_ITEM( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
)

AS

BEGIN
    OPEN P_CURSOR FOR

    SELECT
          ITEM_NAME	    --�׸��    
        , ITEM_CODE	    --�׸��ڵ�_�����ڵ�        
        , ITEM_LEVEL	--�׸񷹺�       
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ENABLED_FLAG    = 'Y'               --��뿩��
    ORDER BY SORT_SEQ;                          --���ļ���

END POP_REF_ITEM;






--�繫��ǥ���� ��� => ������ grid�� �ű� �׸� �߰�
PROCEDURE INSERT_FORM_MST( 
      P_SOB_ID	            IN  FI_FORM_MST.SOB_ID%TYPE	            --ȸ����̵�
    , P_ORG_ID	            IN  FI_FORM_MST.ORG_ID%TYPE	            --����ξ��̵�
    , P_FS_SET_ID	        IN  FI_FORM_MST.FS_SET_ID%TYPE	        --�������ؼ�Ʈ���̵�
    , P_FORM_TYPE_ID	    IN  FI_FORM_MST.FORM_TYPE_ID%TYPE	    --�������ID(�����ڵ�)
    , P_ITEM_CODE	        IN  FI_FORM_MST.ITEM_CODE%TYPE	        --�׸��ڵ�_�����ڵ�
    , P_ITEM_NAME	        IN	FI_FORM_MST.ITEM_NAME%TYPE	        --�׸��
    , P_ACCOUNT_DR_CR	    IN	FI_FORM_MST.ACCOUNT_DR_CR%TYPE	    --���뱸��(1-����,2-�뺯)
    , P_MNS_ACCOUNT_FLAG    IN	FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE	--������������
    , P_RELATE_ITEM_CODE	IN	FI_FORM_MST.RELATE_ITEM_CODE%TYPE	--�����׸��ڵ�
    , P_SORT_SEQ	        IN	FI_FORM_MST.SORT_SEQ%TYPE	        --���ļ���
    , P_ITEM_LEVEL	        IN	FI_FORM_MST.ITEM_LEVEL%TYPE	        --�׸񷹺�
    , P_ENABLED_FLAG	    IN	FI_FORM_MST.ENABLED_FLAG%TYPE	    --��뿩��
    , P_REMARKS	            IN	FI_FORM_MST.REMARKS%TYPE	        --���
    , P_CREATED_BY	        IN	FI_FORM_MST.CREATED_BY%TYPE	        --������ 
    
    , P_REF_FORM_TYPE_ID	IN	FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --���ú������ID(�����ڵ�)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --�����׸��ڵ�
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --����繫��ǥ�׸񿩺�
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --����ڻ�⸻�ݾװ����׸��ڵ�
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --����Ʋ��������    
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
V_RECORD_COUNT NUMBER := 0;

BEGIN

    --�߰��Ϸ��� �ڷᰡ �̹� �����ϴ����� �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO V_RECORD_COUNT
    FROM FI_FORM_MST
    WHERE   SOB_ID          = P_SOB_ID          --ȸ����̵�
        AND ORG_ID          = P_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = P_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = P_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = P_ITEM_CODE       --�׸��ڵ�_�����ڵ�
    ;    
    
    --FCM_10273, ������ �ڵ��� �ڷᰡ �����Ͽ� ����� �� �����ϴ�. Ȯ�ιٶ��ϴ�.
    IF V_RECORD_COUNT > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10273', NULL));
    END IF;

    INSERT INTO FI_FORM_MST(
          SOB_ID	        --ȸ����̵�
        , ORG_ID	        --����ξ��̵�
        , FS_SET_ID	        --�������ؼ�Ʈ���̵�
        , FORM_TYPE_ID	    --�������ID(�����ڵ�)
        , ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , ITEM_NAME	        --�׸��
        , ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
        , MNS_ACCOUNT_FLAG	--������������
        , RELATE_ITEM_CODE	--�����׸��ڵ�
        , SORT_SEQ	        --���ļ���
        , ITEM_LEVEL	    --�׸񷹺�
        , ENABLED_FLAG	    --��뿩��        
        , REF_FORM_TYPE_ID	--���ú������ID(�����ڵ�)
        , REF_ITEM_CODE	    --�����׸��ڵ�
        , SUMMARY_YN	    --����繫��ǥ�׸񿩺�
        , FORM_ITEM_TYPE_CD	--����ڻ�⸻�ݾװ����׸��ڵ�
        , FORM_FRAME_YN	    --����Ʋ��������
        , REMARKS	        --���
        , CREATION_DATE     --������
        , CREATED_BY	    --������
        , LAST_UPDATE_DATE  --������
        , LAST_UPDATED_BY	--������          
    )
    VALUES(
          P_SOB_ID	            --ȸ����̵�
        , P_ORG_ID	            --����ξ��̵�
        , P_FS_SET_ID	        --�������ؼ�Ʈ���̵�
        , P_FORM_TYPE_ID	    --�������ID(�����ڵ�)
        , P_ITEM_CODE	        --�׸��ڵ�_�����ڵ�
        , P_ITEM_NAME	        --�׸��
        , P_ACCOUNT_DR_CR	    --���뱸��(1-����,2-�뺯)
        , P_MNS_ACCOUNT_FLAG	--������������
        , P_RELATE_ITEM_CODE	--�����׸��ڵ�
        , P_SORT_SEQ	        --���ļ���
        , P_ITEM_LEVEL	        --�׸񷹺�
        , P_ENABLED_FLAG	    --��뿩��        
        , P_REF_FORM_TYPE_ID	--���ú������ID(�����ڵ�)
        , P_REF_ITEM_CODE	    --�����׸��ڵ�
        , P_SUMMARY_YN	        --����繫��ǥ�׸񿩺�
        , P_FORM_ITEM_TYPE_CD	--����ڻ�⸻�ݾװ����׸��ڵ�
        , P_FORM_FRAME_YN	    --����Ʋ��������        
        , P_REMARKS	            --���
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������
        , V_SYSDATE             --������
        , P_CREATED_BY	        --������    
    );

END INSERT_FORM_MST;







--�繫��ǥ���� ��� => ������ grid�� ��ȸ�� �ڷ� UPDATE
PROCEDURE UPDATE_FORM_MST( 
      W_SOB_ID              IN  FI_FORM_MST.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN  FI_FORM_MST.ORG_ID%TYPE              --����ξ��̵�
    , W_FS_SET_ID           IN  FI_FORM_MST.FS_SET_ID%TYPE           --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID        IN  FI_FORM_MST.FORM_TYPE_ID%TYPE        --�������ID(�����ڵ�)
    , W_ITEM_CODE           IN  FI_FORM_MST.ITEM_CODE%TYPE           --�׸��ڵ�_�����ڵ�
    
    , P_ITEM_NAME           IN  FI_FORM_MST.ITEM_NAME%TYPE           --�׸��
    , P_ACCOUNT_DR_CR       IN  FI_FORM_MST.ACCOUNT_DR_CR%TYPE       --���뱸��(1-����,2-�뺯)
    , P_MNS_ACCOUNT_FLAG    IN  FI_FORM_MST.MNS_ACCOUNT_FLAG%TYPE    --������������
    , P_RELATE_ITEM_CODE    IN  FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --�����׸��ڵ�
    , P_SORT_SEQ            IN  FI_FORM_MST.SORT_SEQ%TYPE            --���ļ���
    , P_ITEM_LEVEL          IN  FI_FORM_MST.ITEM_LEVEL%TYPE          --�׸񷹺�
    , P_ENABLED_FLAG        IN  FI_FORM_MST.ENABLED_FLAG%TYPE        --��뿩��
    , P_REMARKS             IN  FI_FORM_MST.REMARKS%TYPE             --���
    , P_LAST_UPDATED_BY     IN  FI_FORM_MST.LAST_UPDATED_BY%TYPE     --������
    
    , P_REF_FORM_TYPE_ID	IN  FI_FORM_MST.REF_FORM_TYPE_ID%TYPE   --���ú������ID(�����ڵ�)
    , P_REF_ITEM_CODE	    IN	FI_FORM_MST.REF_ITEM_CODE%TYPE	    --�����׸��ڵ�
    , P_SUMMARY_YN	        IN	FI_FORM_MST.SUMMARY_YN%TYPE	        --����繫��ǥ�׸񿩺� 
    
    , P_FORM_ITEM_TYPE_CD	IN	FI_FORM_MST.FORM_ITEM_TYPE_CD%TYPE  --����ڻ�⸻�ݾװ����׸��ڵ�
    , P_FORM_FRAME_YN	    IN	FI_FORM_MST.FORM_FRAME_YN%TYPE	    --����Ʋ��������    
)

AS

V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN

    UPDATE FI_FORM_MST
    SET
          ITEM_NAME         = P_ITEM_NAME       
        , ACCOUNT_DR_CR     = P_ACCOUNT_DR_CR   
        , MNS_ACCOUNT_FLAG  = P_MNS_ACCOUNT_FLAG
        , RELATE_ITEM_CODE  = P_RELATE_ITEM_CODE
        , SORT_SEQ          = P_SORT_SEQ     
        , ITEM_LEVEL        = P_ITEM_LEVEL      
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , REF_FORM_TYPE_ID  = P_REF_FORM_TYPE_ID     
        , REF_ITEM_CODE     = P_REF_ITEM_CODE      
        , SUMMARY_YN        = P_SUMMARY_YN        
        , FORM_ITEM_TYPE_CD	= P_FORM_ITEM_TYPE_CD   --����ڻ�⸻�ݾװ����׸��ڵ�
        , FORM_FRAME_YN	    = P_FORM_FRAME_YN       --����Ʋ��������                
        , REMARKS           = P_REMARKS
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_ITEM_CODE       --�׸��ڵ�_�����ڵ�
    ;

END UPDATE_FORM_MST;





--�繫��ǥ���� ��� => ������ grid�� ��ȸ�� �ڷ� ����
PROCEDURE DELETE_FORM_MST( 
      W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
    , W_ITEM_CODE       IN FI_FORM_MST.ITEM_CODE%TYPE       --�׸��ڵ�_�����ڵ�
)

AS

V_RECORD_COUNT NUMBER := 0;

BEGIN

    --�����Ϸ��� �׸��ڵ带 �����׸����� �����Ǿ��ִ� �ڷᰡ �ִ��� �ľ�
    SELECT COUNT(*)
    INTO V_RECORD_COUNT
    FROM FI_FORM_MST
    WHERE   SOB_ID              = W_SOB_ID          --ȸ����̵�
        AND ORG_ID              = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID           = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID        = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND RELATE_ITEM_CODE    = W_ITEM_CODE       --�����׸��ڵ�
    ;    
    
    --FCM_10274, �����Ϸ��� �ڷḦ �����׸����� ����ϴ� �ڷᰡ �־� ������ �� �����ϴ�.
    IF V_RECORD_COUNT <> 0 THEN
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10274', NULL));
    END IF;

    --������ ���̺� ����
    DELETE FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_ITEM_CODE       --�׸��ڵ�_�����ڵ�
    ;
    
    
    --�� ���̺� ����
    DELETE FI_FORM_DET
    WHERE   SOB_ID          = W_SOB_ID          --ȸ����̵�
        AND ORG_ID          = W_ORG_ID          --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID       --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID    --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_ITEM_CODE       --�׸��ڵ�_�����ڵ�
    ;    
    

END DELETE_FORM_MST;






--���� �� : ����������ȸ
--���� : ����������� ���α׷������� ������ ������ ���� �繫��ǥ����� �����ߴµ�
--       �� ������ ������ �繫��ǥ��İ��� ���α׷��� �ش� ���� ��Ŀ��� ���Ե��� ����
--       �������� ��ȸ�ϰ��� ���̴�.
PROCEDURE LIST_OMISSION_ACCOUNT( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , W_ORG_ID          IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , W_FS_SET_ID       IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID    IN FI_FORM_MST.FORM_TYPE_ID%TYPE    --�������ID(�����ڵ�)
)

AS

t_ACCOUNT_FS_TYPE   FI_ACCOUNT_CONTROL.ACCOUNT_FS_TYPE%TYPE; --�繫��ǥ���� ���� �������.

BEGIN

    IF W_FORM_TYPE_ID = 744 THEN    --�հ��ܾ׽û�ǥ ����������ȸ
        OPEN P_CURSOR FOR

        SELECT
              ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , ACCOUNT_DR_CR     --��/�뱸��(1-����,2-�뺯)
            , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', ACCOUNT_DR_CR, SOB_ID) AS ACCOUNT_DR_CR_NAME --��/�뱸��
            , ACCOUNT_FS_TYPE                                                                       --�繫��ǥ���
            , FI_COMMON_G.CODE_NAME_F('FORM_TYPE', ACCOUNT_FS_TYPE, SOB_ID) AS ACCOUNT_FS_TYPE_NAME --�繫��ǥ���
            , NVL(ENABLED_FLAG, 'N') AS ENABLED_FLAG                                                --��ǥ�Է¿���
            , UP_ACCOUNT_CODE   --���������ڵ�
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.UP_ACCOUNT_CODE)
                    , SOB_ID) AS UP_ACCOUNT_NAME    --����������
            , RELATE_ACCOUNT_CODE                   --���������ڵ�
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.RELATE_ACCOUNT_CODE)
                    , SOB_ID) AS RELATE_ACCOUNT_NAME    --����������    
        FROM FI_ACCOUNT_CONTROL A
        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
            --AND ACCOUNT_FS_TYPE IS NOT NULL
            AND ACCOUNT_FS_TYPE IN ('1002', '1003', '1004') --�� �ѹ��常 �Ʒ� ������ �ٸ���.
            AND ACCOUNT_CODE NOT IN 
                (
                    SELECT ITEM_CODE
                    FROM FI_FORM_MST
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID
                        AND FS_SET_ID = W_FS_SET_ID
                        AND FORM_TYPE_ID = W_FORM_TYPE_ID        
                )
        ORDER BY ACCOUNT_CODE;   
        
    ELSE    --�հ��ܾ׽û�ǥ �� ����������ȸ
    
        IF W_FORM_TYPE_ID = 747 THEN        --������������ 
            t_ACCOUNT_FS_TYPE := '1004';          
        ELSIF W_FORM_TYPE_ID = 746 THEN     --���Ͱ�꼭 
            t_ACCOUNT_FS_TYPE := '1003';            
        ELSIF W_FORM_TYPE_ID = 745 THEN     --�繫����ǥ(��������ǥ)
            t_ACCOUNT_FS_TYPE := '1002';        
        END IF;



        OPEN P_CURSOR FOR

        SELECT
              ACCOUNT_CODE      --�����ڵ�
            , ACCOUNT_DESC      --������
            , ACCOUNT_DR_CR     --��/�뱸��(1-����,2-�뺯)
            , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', ACCOUNT_DR_CR, SOB_ID) AS ACCOUNT_DR_CR_NAME --��/�뱸��
            , ACCOUNT_FS_TYPE                                                                       --�繫��ǥ���
            , FI_COMMON_G.CODE_NAME_F('FORM_TYPE', ACCOUNT_FS_TYPE, SOB_ID) AS ACCOUNT_FS_TYPE_NAME --�繫��ǥ���
            , NVL(ENABLED_FLAG, 'N') AS ENABLED_FLAG                                                --��ǥ�Է¿���
            , UP_ACCOUNT_CODE   --���������ڵ�
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.UP_ACCOUNT_CODE)
                    , SOB_ID) AS UP_ACCOUNT_NAME    --����������
            , RELATE_ACCOUNT_CODE                   --���������ڵ�
            , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(
                      (SELECT ACCOUNT_CONTROL_ID
                      FROM FI_ACCOUNT_CONTROL
                      WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
                        AND ACCOUNT_CODE = A.RELATE_ACCOUNT_CODE)
                    , SOB_ID) AS RELATE_ACCOUNT_NAME   --����������    
        FROM FI_ACCOUNT_CONTROL A
        WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID AND ACCOUNT_SET_ID = '10'
            AND ACCOUNT_FS_TYPE = t_ACCOUNT_FS_TYPE --�� �ѹ��常 �� ������ �ٸ���.
            AND ACCOUNT_CODE NOT IN 
                (
                    SELECT ITEM_CODE
                    FROM FI_FORM_MST
                    WHERE SOB_ID = W_SOB_ID AND ORG_ID = W_ORG_ID
                        AND FS_SET_ID = W_FS_SET_ID
                        AND FORM_TYPE_ID = W_FORM_TYPE_ID        
                )
        ORDER BY ACCOUNT_CODE;
        
    END IF;


END LIST_OMISSION_ACCOUNT;







--������ �׸��� �����׸��ڵ忡 ���� ���� ���ϴ� �����Լ�.
FUNCTION RELATE_ITEM_CODE_NAME_F(
      W_SOB_ID              IN FI_FORM_MST.SOB_ID%TYPE              --ȸ����̵�
    , W_ORG_ID              IN FI_FORM_MST.ORG_ID%TYPE              --����ξ��̵�
    , W_FS_SET_ID           IN FI_FORM_MST.FS_SET_ID%TYPE           --�������ؼ�Ʈ���̵�
    , W_FORM_TYPE_ID        IN FI_FORM_MST.FORM_TYPE_ID%TYPE        --�������ID(�����ڵ�)
    , W_RELATE_ITEM_CODE    IN FI_FORM_MST.RELATE_ITEM_CODE%TYPE    --�����׸��ڵ�
) RETURN VARCHAR2

AS

t_RELATE_ITEM_CODE_NAME FI_FORM_MST.ITEM_NAME%TYPE := '';   --��ȸ�� �ڷ� ��� �߿��� ������������ ���Ѵ�.

BEGIN

    SELECT ITEM_NAME
    INTO t_RELATE_ITEM_CODE_NAME
    FROM FI_FORM_MST
    WHERE   SOB_ID          = W_SOB_ID              --ȸ����̵�
        AND ORG_ID          = W_ORG_ID              --����ξ��̵�
        AND FS_SET_ID       = W_FS_SET_ID           --�������ؼ�Ʈ���̵�
        AND FORM_TYPE_ID    = W_FORM_TYPE_ID        --�������ID(�����ڵ�)
        AND ITEM_CODE       = W_RELATE_ITEM_CODE    --�׸��ڵ�_�����ڵ�
    ;
    
    RETURN t_RELATE_ITEM_CODE_NAME;

END RELATE_ITEM_CODE_NAME_F;



--�繫��ǥ���� ��� �������� ���� ������ ���� ���� üũ.
PROCEDURE GET_FORM_MST_COUNT( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FORM_TYPE_ID%TYPE     --�������ID    
    , O_RECORD_COUNT      OUT NUMBER
)
AS
BEGIN
    O_RECORD_COUNT := 0;
    BEGIN
      -- DELETE --
      SELECT COUNT(FM.FORM_TYPE_ID) AS RECORD_COUNT
        INTO O_RECORD_COUNT
        FROM FI_FORM_MST FM
       WHERE FM.FS_SET_ID         = P_FS_SET_ID 
         AND FM.FORM_TYPE_ID      = P_FORM_TYPE_ID 
         AND FM.SOB_ID            = P_SOB_ID
         AND FM.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_RECORD_COUNT := 0;
    END;
END GET_FORM_MST_COUNT;


--�繫��ǥ���� ��� ���� 
--1�ܰ� : FI_FORM_MST(�繫��ǥ�������_������) ���̺� DATA INSERT
--2�ܰ� : FI_FORM_DET(�繫��ǥ�������_��)   ���̺� DATA INSERT
PROCEDURE COPY_FORM_MST( 
      P_SOB_ID            IN FI_FORM_MST.SOB_ID%TYPE          --ȸ����̵�
    , P_ORG_ID            IN FI_FORM_MST.ORG_ID%TYPE          --����ξ��̵�
    , P_FS_SET_ID         IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ؼ�Ʈ���̵�    
    , P_FORM_TYPE_ID      IN FI_FORM_MST.FS_SET_ID%TYPE       --�������ID    
    , P_NEW_FS_SET_ID     IN FI_FORM_MST.FS_SET_ID%TYPE       --�ű� �������ؼ�Ʈ���̵�    
    , P_NEW_FORM_TYPE_ID  IN FI_FORM_MST.FS_SET_ID%TYPE       --�ű� �������ID
    , P_USER_ID           IN FI_FORM_MST.CREATED_BY%TYPE	    --������
    , O_STATUS            OUT VARCHAR2
    , O_MESSAGE           OUT VARCHAR2
)
AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
BEGIN
    O_STATUS := 'F';
    
    -- DELETE --
    DELETE FROM FI_FORM_MST FM
     WHERE FM.FS_SET_ID         = P_NEW_FS_SET_ID 
       AND FM.FORM_TYPE_ID      = P_NEW_FORM_TYPE_ID 
       AND FM.SOB_ID            = P_SOB_ID
       AND FM.ORG_ID            = P_ORG_ID
    ;
    DELETE FROM FI_FORM_DET FD
     WHERE FD.FS_SET_ID         = P_NEW_FS_SET_ID 
       AND FD.FORM_TYPE_ID      = P_NEW_FORM_TYPE_ID 
       AND FD.SOB_ID            = P_SOB_ID
       AND FD.ORG_ID            = P_ORG_ID
    ;
    
    -- INSERT --
    FOR C1 IN ( SELECT FFM.SOB_ID 
                     , FFM.ORG_ID 
                     , FFM.FS_SET_ID
                     , FFM.FORM_TYPE_ID
                     , P_NEW_FS_SET_ID AS NEW_FS_SET_ID 
                     , P_NEW_FORM_TYPE_ID AS NEW_FORM_TYPE_ID 
                     , FFM.ITEM_CODE 
                     , FFM.ITEM_NAME 
                     , FFM.ACCOUNT_DR_CR 
                     , FFM.MNS_ACCOUNT_FLAG 
                     , FFM.RELATE_ITEM_CODE 
                     , FFM.SORT_SEQ 
                     , FFM.ITEM_LEVEL 
                     , FFM.ENABLED_FLAG 
                     , FFM.REF_FORM_TYPE_ID 
                     , FFM.REF_ITEM_CODE 
                     , FFM.SUMMARY_YN 
                     , FFM.FORM_ITEM_TYPE_CD
                     , FFM.FORM_FRAME_YN 
                     , FFM.REMARKS 
                     , V_SYSDATE AS CREATION_DATE 
                     , P_USER_ID AS CREATED_BY 
                     , V_SYSDATE AS LAST_UPDATE_DATE 
                     , P_USER_ID AS LAST_UPDATED_BY 
                  FROM FI_FORM_MST FFM
                 WHERE FFM.FS_SET_ID      = P_FS_SET_ID
                   AND FFM.FORM_TYPE_ID   = P_FORM_TYPE_ID
                   AND FFM.SOB_ID         = P_SOB_ID
                   AND FFM.ORG_ID         = P_ORG_ID
                ORDER BY FFM.SORT_SEQ
               )
    LOOP
      FOR D1 IN ( SELECT FD.SOB_ID 
                       , FD.ORG_ID 
                       , FD.FS_SET_ID 
                       , FD.FORM_TYPE_ID 
                       , FD.ITEM_CODE 
                       , FD.FORM_SEQ 
                       , FD.DET_ITEM_CODE 
                       , FD.ACCOUNT_CONTROL_ID 
                       , FD.ITEM_SIGN_SHOW 
                       , FD.ENABLED_FLAG 
                       , FD.REMARKS 
                    FROM FI_FORM_DET FD
                   WHERE FD.FS_SET_ID     = C1.FS_SET_ID
                     AND FD.FORM_TYPE_ID  = C1.FORM_TYPE_ID
                     AND FD.ITEM_CODE     = C1.ITEM_CODE
                     AND FD.SOB_ID        = C1.SOB_ID
                     AND FD.ORG_ID        = C1.ORG_ID
                  ORDER BY FD.FORM_SEQ
                 )
      LOOP
        BEGIN
          INSERT INTO FI_FORM_DET
          ( SOB_ID 
          , ORG_ID 
          , FS_SET_ID 
          , FORM_TYPE_ID 
          , ITEM_CODE 
          , FORM_SEQ 
          , DET_ITEM_CODE 
          , ACCOUNT_CONTROL_ID 
          , ITEM_SIGN_SHOW 
          , ENABLED_FLAG 
          , REMARKS 
          , CREATION_DATE 
          , CREATED_BY 
          , LAST_UPDATE_DATE 
          , LAST_UPDATED_BY 
          ) VALUES
          ( C1.SOB_ID 
          , C1.ORG_ID 
          , C1.NEW_FS_SET_ID 
          , C1.NEW_FORM_TYPE_ID 
          , D1.ITEM_CODE 
          , D1.FORM_SEQ 
          , D1.DET_ITEM_CODE 
          , D1.ACCOUNT_CONTROL_ID 
          , D1.ITEM_SIGN_SHOW 
          , D1.ENABLED_FLAG 
          , D1.REMARKS 
          , C1.CREATION_DATE 
          , C1.CREATED_BY 
          , C1.LAST_UPDATE_DATE 
          , C1.LAST_UPDATED_BY 
          );
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Insert Detail Error : ' || SUBSTR(SQLERRM, 1, 200);
          RETURN;
        END;
      END LOOP D1;
      
      BEGIN
        INSERT INTO FI_FORM_MST
        ( SOB_ID 
        , ORG_ID 
        , FS_SET_ID 
        , FORM_TYPE_ID 
        , ITEM_CODE 
        , ITEM_NAME 
        , ACCOUNT_DR_CR 
        , MNS_ACCOUNT_FLAG 
        , RELATE_ITEM_CODE 
        , SORT_SEQ 
        , ITEM_LEVEL 
        , ENABLED_FLAG 
        , REF_FORM_TYPE_ID 
        , REF_ITEM_CODE 
        , SUMMARY_YN 
        , FORM_ITEM_TYPE_CD 
        , FORM_FRAME_YN 
        , REMARKS 
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY 
        ) VALUES
        ( C1.SOB_ID 
        , C1.ORG_ID 
        , C1.NEW_FS_SET_ID 
        , C1.NEW_FORM_TYPE_ID 
        , C1.ITEM_CODE 
        , C1.ITEM_NAME 
        , C1.ACCOUNT_DR_CR 
        , C1.MNS_ACCOUNT_FLAG 
        , C1.RELATE_ITEM_CODE 
        , C1.SORT_SEQ 
        , C1.ITEM_LEVEL 
        , C1.ENABLED_FLAG 
        , C1.REF_FORM_TYPE_ID 
        , C1.REF_ITEM_CODE 
        , C1.SUMMARY_YN 
        , C1.FORM_ITEM_TYPE_CD 
        , C1.FORM_FRAME_YN 
        , C1.REMARKS 
        , C1.CREATION_DATE 
        , C1.CREATED_BY 
        , C1.LAST_UPDATE_DATE 
        , C1.LAST_UPDATED_BY 
        );
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Insert Master Error : [' || C1.NEW_FS_SET_ID || ',' || 
                                                  C1.NEW_FORM_TYPE_ID || ',' || 
                                                  C1.ITEM_CODE || '] ' || SUBSTR(SQLERRM, 1, 200);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
END COPY_FORM_MST;


END FI_FORM_MST_G;
/
