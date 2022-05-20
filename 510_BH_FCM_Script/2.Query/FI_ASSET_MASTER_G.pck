CREATE OR REPLACE PACKAGE FI_ASSET_MASTER_G
AS

-- �ڻ���� ��ȸ.
  PROCEDURE SELECT_ASSET_MASTER
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_ASSET_ID             IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , W_ASSET_STATUS_CODE    IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            );

-- �ڻ���� ����.
PROCEDURE INSERT_ASSET_MASTER
          ( P_ASSET_ID                 OUT FI_ASSET_MASTER.ASSET_ID%TYPE
          , P_ASSET_CODE               IN FI_ASSET_MASTER.ASSET_CODE%TYPE
          , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
          , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
          , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
          , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
          , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
          , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
          , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
          , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
          , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
          , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
          , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
          , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
          , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
          , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
          , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
          , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
          , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
          , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
          , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
          , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
          , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
          , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
          , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
          , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
          , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
          , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
          , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
          , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
          , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
          , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
          , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
          , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
          , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
          , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE
          );

-- �ڻ���� ����.
  PROCEDURE UPDATE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
            , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
            , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
            , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
            , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
            , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
            , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
            , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
            , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
            , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
            , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
            , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
            , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
            , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
            , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
            , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
            , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
            , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
            , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
            , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
            , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
            , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
            , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
            , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE 
            );

-- �ڻ���� ����.
  PROCEDURE DELETE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- �ڻ��ڵ� LOOKUP ��ȸ.
  PROCEDURE LU_ASSET_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            );

-- �ڻ��ڵ� LOOKUP ��ȸ.
  PROCEDURE LU_ASSET_CODE_FR_TO
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_ASSET_CODE           IN FI_ASSET_MASTER.ASSET_CODE%TYPE
            , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE DEFAULT NULL
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            );
            
-- �ڻ�CATEGORY LOOKUP ��ȸ.
  PROCEDURE LU_ASSET_CATEGORY
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ENABLED_YN           IN VARCHAR2
            );
            
            
            








            
--�ϱ� ���Ͱ� �ӵ����� ������ �����̴�.(2011.10.18)


--��ȸ
PROCEDURE LIST_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE             --ȸ����̵�
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE  --�ڻ��������̵�
    , W_ASSET_CODE          IN  FI_ASSET_MASTER.ASSET_CODE%TYPE         --�ڻ��ڵ�
    , W_ASSET_STATUS_CODE   IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE  --�ڻ����
);






--�ڻ���� �ű��ڷ� ���
PROCEDURE INS_ASSET_MASTER( 
      P_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE                 --ȸ����̵�
    , P_ORG_ID                  IN  FI_ASSET_MASTER.ORG_ID%TYPE                 --����ξ��̵�     
    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE      --�ڻ��������̵�
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE             --�ڻ��
    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --�������
    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --�������
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --���ݾ� 
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --��񱸺�
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --�������̵�
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE                    --����
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE                --�뵵
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE              --�ŷ�ó���̵�
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE         --�����μ����̵�
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE                 --���
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE   --(IFRS)�����󰢹��
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)������
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)��������
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)�󰢻���
    
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --�ڻ����

    , P_CREATED_BY              IN  FI_ASSET_MASTER.CREATED_BY%TYPE             --������ 
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- ������ڵ�. 
);




--�����󰢽����� ����
PROCEDURE CREATE_ASSET_DPR_HISTORY( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --����ξ��̵�

    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_DPR_HISTORY.ASSET_CATEGORY_ID%TYPE --�ڻ��������̵�
    , P_ASSET_ID                IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�
    , P_DPR_METHOD_TYPE         IN  FI_ASSET_DPR_HISTORY.DPR_METHOD_TYPE%TYPE   --�����󰢹��_�ڵ�
    , P_COST_CENTER_ID          IN  FI_ASSET_DPR_HISTORY.COST_CENTER_ID%TYPE    --�������̵�

    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --������� 
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)������
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --���ݾ� 
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)��������    
    
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --������ 
);








--�� PROCEDURE�� �� ��ϵ� �ڻ��� �����󰢽����� ������ ���� �ӽü� PROCEDURE�� 
--���� ����(2011.10.24) �ܿ��� ������ �ʴ� ���̴�.
PROCEDURE CREATE_BATCH_DPR( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --����ξ��̵�       
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --������ 
);









--�ڻ���� ����
PROCEDURE UPD_ASSET_MASTER( 
      W_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE         --ȸ����̵�
    , W_ASSET_CODE              IN  FI_ASSET_MASTER.ASSET_CODE%TYPE     --�ڻ��ڵ�
      
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE     --�ڻ��     
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE            --����
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE        --�뵵
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE      --�ŷ�ó���̵�
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE --�����μ����̵�
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE --���

    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --�������       
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --��񱸺�
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --�������̵�
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --�ڻ����
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)�󰢻���          

    , P_LAST_UPDATED_BY         IN  FI_ASSET_MASTER.LAST_UPDATED_BY%TYPE    --����������
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- ������ڵ�.
);



      


--�ڻ���� ����
PROCEDURE DEL_ASSET_MASTER(
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --ȸ����̵�
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_CODE%TYPE --�ڻ���̵�
);








--�ڻ꺯������ ��ȸ
PROCEDURE LIST_ASSET_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_HISTORY.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_HISTORY.ORG_ID%TYPE    --����ξ��̵�
    , W_ASSET_ID    IN  FI_ASSET_HISTORY.ASSET_ID%TYPE  --�ڻ���̵�
);







--�ڻ꺯������ �ű��ڷ� ���
PROCEDURE INS_ASSET_HISTORY( 
      P_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , P_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�    
    , P_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������
    , P_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE         --�������_���̵�
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(������)�ݾ�
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --(������)�������̵�
    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(������)����  
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --�����μ�_���̵�
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --���    
    
    , P_CREATED_BY      IN  FI_ASSET_HISTORY.CREATED_BY%TYPE        --������ 
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- ������ڵ� 
);






--�ں������⿡ ���� �߰��󰢾� ���� �� �����󰢴���װ� �̻��ܾ� �ݾ� ����
PROCEDURE CHG_ASSET_DPR_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������        
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(������)�ݾ�; �߰��Ǵ� �����󰢴��ݾ��̴�.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --�������̵�    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --���������� 
);








--�κиŰ��� ���� �����󰢾� ���� �� �����󰢴���װ� �̻��ܾ� �ݾ� ����
PROCEDURE CHG_ASSET_DPR_HISTORY_PART( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������        
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(������)�ݾ�; �����Ǵ� �����󰢴��ݾ��̴�.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --�������̵�    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --���������� 
);






--�ں��������� ��� �� [��, �ں�������, �κиŰ� ����]
--FI_ASSET_DPR_HISTORY(�����ڻ�_�����󰢽����쳻��) ���̺��� �ش� �ڻ��� �������̵� ����
--�����󰢹��(1:���׹�, 2:������)�� ���簣�� �������. �����ϰ� ����ȴ�.
PROCEDURE UPD_ASSET_DPR_HISTORY_COST( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������       
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --�������̵�    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --���������� 
);







--�ڻ꺯������ ����
PROCEDURE UPD_ASSET_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵� 
    , W_HISTORY_NUM     IN  FI_ASSET_HISTORY.HISTORY_NUM%TYPE       --�ڻ꺯����ȣ         

    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(������)����       
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --���
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --�����μ�_���̵�

    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --����������
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- ������ڵ�
);







--�ڻ꺰 �����󰢽����� ��ȸ
PROCEDURE LIST_ASSET_DPR_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE    --����ξ��̵�
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE  --�ڻ���̵�
    --, W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY.DPR_TYPE%TYPE  --ȸ�豸��
);






--�ڻ�� ��ȯ
FUNCTION  F_ASSET_DESC( 
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_MASTER.ORG_ID%TYPE     --����ξ��̵�
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_ID%TYPE   --�ڻ���̵�
) RETURN VARCHAR2;








--�ڻ�� ���� POPUP
PROCEDURE POPUP_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
);







--�ڻ꺯������ PG�� �ڻ꺯������ ��ȸ
--����>LIST_ASSET_HISTORY PROCEDURE�� �����ϴ�.
PROCEDURE LIST_ASSET_HISTORY_ALL( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE        --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE        --����ξ��̵�    
    , W_CHARGE_DATE_FR  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --��������_����
    , W_CHARGE_DATE_TO  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --��������_����
    , W_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE     --����������̵�
);



            
END FI_ASSET_MASTER_G;
/
CREATE OR REPLACE PACKAGE BODY FI_ASSET_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_ASSET_MASTER_G
/* Description  : �����ڻ� ������.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- �ڻ���� ��ȸ.
  PROCEDURE SELECT_ASSET_MASTER
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , W_ASSET_ID             IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , W_ASSET_STATUS_CODE    IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT AM.ASSET_ID
           , AM.ASSET_CODE
           , AM.ASSET_DESC
           , AM.ASSET_CATEGORY_ID
           , FAC.ASSET_CATEGORY_NAME
           , AM.EXPENSE_TYPE
           , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', AM.EXPENSE_TYPE, AM.SOB_ID) AS EXPENSE_TYPE_NAME
           , AM.SPEC
           , AM.PURPOSE
           , AM.ACQUIRE_DATE
           , AM.REGISTER_DATE
           , AM.LOCATION_ID
           , FI_COMMON_G.ID_NAME_F(AM.LOCATION_ID) AS LOCATION_NAME
           , AM.LOCATION_DESC
           , AM.QTY
           , AM.UOM_CODE
           , AM.UNIT_PRICE
           , AM.CURRENCY_CODE
           , AM.EXCHANGE_RATE
           , AM.CURR_AMOUNT
           , AM.AMOUNT           
           , AM.DPR_YN
           , AM.DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AM.DPR_METHOD_TYPE, AM.SOB_ID) AS DPR_METHOD_NAME
           , AM.DPR_PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('10', AM.DPR_METHOD_TYPE, AM.SOB_ID, AM.DPR_PROGRESS_YEAR) AS DPR_RATE
           , AM.RESIDUAL_AMOUNT
           , AM.DPR_STATUS_CODE
           , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', AM.DPR_STATUS_CODE, AM.SOB_ID) AS DPR_STATUS_NAME
           , AM.DPR_SUM_CURR_AMOUNT
           , AM.DPR_SUM_AMOUNT
           , NVL(AM.AMOUNT, 0) - NVL(AM.DPR_SUM_AMOUNT, 0) AS DPR_REMAIN_AMOUNT
           , AM.DPR_LAST_PERIOD
           , AM.IFRS_DPR_YN
           , AM.IFRS_DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AM.IFRS_DPR_METHOD_TYPE, AM.SOB_ID) AS IFRS_DPR_METHOD_NAME
           , AM.IFRS_PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('20', AM.IFRS_DPR_METHOD_TYPE, AM.SOB_ID, AM.IFRS_PROGRESS_YEAR) AS IFRS_DPR_RATE
           , AM.IFRS_RESIDUAL_AMOUNT
           , AM.IFRS_DPR_STATUS_CODE
           , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', AM.IFRS_DPR_STATUS_CODE, AM.SOB_ID) AS IFRS_DPR_STATUS_NAME
           , AM.IFRS_DPR_SUM_CURR_AMOUNT
           , AM.IFRS_DPR_SUM_AMOUNT
           , NVL(AM.AMOUNT, 0) - NVL(AM.IFRS_DPR_SUM_AMOUNT, 0) AS IFRS_DPR_REMAIN_AMOUNT
           , AM.IFRS_DPR_LAST_PERIOD
           , AM.VENDOR_ID
           , SC.SUPP_CUST_NAME AS VENDOR_NAME
           , AM.MANAGE_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(AM.MANAGE_DEPT_ID) AS MANAGE_DEPT_NAME
           , AM.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_CODE_F(AM.COST_CENTER_ID) AS CC_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(AM.COST_CENTER_ID) AS CC_DESC
           , AM.ASSET_STATUS_CODE
           , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', AM.ASSET_STATUS_CODE, AM.SOB_ID) AS ASSET_STATUS_NAME
           , AM.DISUSE_DATE
           , AM.REMARK
           , NVL(SX1.CE_AMOUNT, 0) AS CE_AMOUNT
        FROM FI_ASSET_MASTER AM
          , FI_ASSET_CATEGORY FAC
          , FI_SUPP_CUST_V SC
          , ( -- �ں��� ���� �ݾ�.
            SELECT AH.ASSET_ID
                 , AH.SOB_ID
                 , NVL(SUM(AH.AMOUNT), 0) AS CE_AMOUNT
              FROM FI_ASSET_HISTORY AH
            WHERE AH.ASSET_ID                 = NVL(W_ASSET_ID, AH.ASSET_ID)
              AND AH.SOB_ID                   = W_SOB_ID
              AND EXISTS ( SELECT 'X'
                             FROM FI_COMMON FC
                           WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                             AND FC.SOB_ID      = W_SOB_ID
                             AND FC.CODE        = '10'
                             AND FC.COMMON_ID   = AH.CHARGE_ID
                         )
            GROUP BY AH.ASSET_ID
                 , AH.SOB_ID
            ) SX1     
      WHERE AM.ASSET_CATEGORY_ID        = FAC.ASSET_CATEGORY_ID
        AND AM.VENDOR_ID                = SC.SUPP_CUST_ID(+)
        AND AM.ASSET_ID                 = SX1.ASSET_ID(+)
        AND AM.SOB_ID                   = SX1.SOB_ID(+)
        AND AM.ASSET_CATEGORY_ID        = W_ASSET_CATEGORY_ID
        AND AM.ASSET_ID                 = NVL(W_ASSET_ID, AM.ASSET_ID)
        AND AM.ASSET_STATUS_CODE        = NVL(W_ASSET_STATUS_CODE, AM.ASSET_STATUS_CODE)
        AND AM.SOB_ID                   = W_SOB_ID
      ORDER BY AM.ASSET_CODE
      ;

  END SELECT_ASSET_MASTER;

-- �ڻ���� ����.
PROCEDURE INSERT_ASSET_MASTER
          ( P_ASSET_ID                 OUT FI_ASSET_MASTER.ASSET_ID%TYPE
          , P_ASSET_CODE               IN FI_ASSET_MASTER.ASSET_CODE%TYPE
          , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
          , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
          , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
          , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
          , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
          , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
          , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
          , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
          , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
          , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
          , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
          , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
          , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
          , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
          , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
          , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
          , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
          , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
          , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
          , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
          , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
          , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
          , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
          , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
          , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
          , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
          , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
          , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
          , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
          , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
          , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
          , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
          , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
          , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE
          )
  AS
    V_SYSDATE                          DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ASSET_CATEGORY_CODE              VARCHAR2(10);
    V_DPR_STATUS_CODE                  VARCHAR2(10) := NULL;
    V_IFRS_DPR_STATUS_CODE             VARCHAR2(10) := NULL;
    
  BEGIN
    BEGIN
      SELECT AC.ASSET_CATEGORY_CODE
        INTO V_ASSET_CATEGORY_CODE
        FROM FI_ASSET_CATEGORY AC
      WHERE AC.ASSET_CATEGORY_ID  = P_ASSET_CATEGORY_ID
        AND AC.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;

    -- ���� ���� ǥ��.
    IF P_DPR_YN = 'Y' THEN
      V_DPR_STATUS_CODE := '10';
    END IF;
    IF P_IFRS_DPR_YN = 'Y' THEN
      V_IFRS_DPR_STATUS_CODE := '10';    
    END IF;
    
    SELECT FI_ASSET_MASTER_S1.NEXTVAL
      INTO P_ASSET_ID
      FROM DUAL;
    
    --P_ASSET_CODE := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('DP', P_SOB_ID, P_REGISTER_DATE, P_USER_ID);
    
    INSERT INTO FI_ASSET_MASTER
    ( ASSET_ID
    , ASSET_CODE 
    , ASSET_DESC 
    , SOB_ID 
    , ORG_ID 
    , EXPENSE_TYPE
    , ASSET_CATEGORY_ID 
    , SPEC 
    , PURPOSE 
    , ACQUIRE_DATE 
    , REGISTER_DATE 
    , LOCATION_ID 
    , LOCATION_DESC 
    , QTY 
    , UOM_CODE 
    , INVEST_ID 
    , UNIT_PRICE 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , CURR_AMOUNT 
    , AMOUNT     
    , DPR_YN 
    , DPR_METHOD_TYPE 
    , DPR_PROGRESS_YEAR
    , RESIDUAL_AMOUNT
    , DPR_STATUS_CODE
    , IFRS_DPR_YN 
    , IFRS_DPR_METHOD_TYPE 
    , IFRS_PROGRESS_YEAR
    , IFRS_RESIDUAL_AMOUNT    
    , IFRS_DPR_STATUS_CODE
    , VENDOR_ID 
    , MANAGE_DEPT_ID 
    , COST_CENTER_ID 
    , ASSET_STATUS_CODE
    , DISUSE_DATE
    , REMARK 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_ASSET_ID
    , P_ASSET_CODE
    , P_ASSET_DESC
    , P_SOB_ID
    , P_ORG_ID
    , P_EXPENSE_TYPE
    , P_ASSET_CATEGORY_ID
    , P_SPEC
    , P_PURPOSE
    , P_ACQUIRE_DATE
    , P_REGISTER_DATE
    , P_LOCATION_ID
    , P_LOCATION_DESC
    , P_QTY
    , P_UOM_CODE
    , P_INVEST_ID
    , P_UNIT_PRICE
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_CURR_AMOUNT
    , P_AMOUNT
    , P_DPR_YN
    , P_DPR_METHOD_TYPE
    , P_DPR_PROGRESS_YEAR
    , P_RESIDUAL_AMOUNT
    , V_DPR_STATUS_CODE
    , P_IFRS_DPR_YN
    , P_IFRS_DPR_METHOD_TYPE
    , P_IFRS_PROGRESS_YEAR
    , P_IFRS_RESIDUAL_AMOUNT
    , V_IFRS_DPR_STATUS_CODE
    , P_VENDOR_ID
    , P_MANAGE_DEPT_ID
    , P_COST_CENTER_ID
    , P_ASSET_STATUS_CODE
    , P_DISUSE_DATE
    , P_REMARK
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_ASSET_MASTER;

-- �ڻ���� ����.
  PROCEDURE UPDATE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_ASSET_DESC               IN FI_ASSET_MASTER.ASSET_DESC%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            , P_EXPENSE_TYPE             IN FI_ASSET_MASTER.EXPENSE_TYPE%TYPE
            , P_ASSET_CATEGORY_ID        IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE
            , P_SPEC                     IN FI_ASSET_MASTER.SPEC%TYPE
            , P_PURPOSE                  IN FI_ASSET_MASTER.PURPOSE%TYPE
            , P_ACQUIRE_DATE             IN FI_ASSET_MASTER.ACQUIRE_DATE%TYPE
            , P_REGISTER_DATE            IN FI_ASSET_MASTER.REGISTER_DATE%TYPE
            , P_LOCATION_ID              IN FI_ASSET_MASTER.LOCATION_ID%TYPE
            , P_LOCATION_DESC            IN FI_ASSET_MASTER.LOCATION_DESC%TYPE
            , P_QTY                      IN FI_ASSET_MASTER.QTY%TYPE
            , P_UOM_CODE                 IN FI_ASSET_MASTER.UOM_CODE%TYPE
            , P_INVEST_ID                IN FI_ASSET_MASTER.INVEST_ID%TYPE
            , P_UNIT_PRICE               IN FI_ASSET_MASTER.UNIT_PRICE%TYPE
            , P_CURRENCY_CODE            IN FI_ASSET_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE            IN FI_ASSET_MASTER.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT              IN FI_ASSET_MASTER.CURR_AMOUNT%TYPE
            , P_AMOUNT                   IN FI_ASSET_MASTER.AMOUNT%TYPE
            , P_DPR_YN                   IN FI_ASSET_MASTER.DPR_YN%TYPE
            , P_DPR_METHOD_TYPE          IN FI_ASSET_MASTER.DPR_METHOD_TYPE%TYPE
            , P_DPR_PROGRESS_YEAR        IN FI_ASSET_MASTER.DPR_PROGRESS_YEAR%TYPE
            , P_RESIDUAL_AMOUNT          IN FI_ASSET_MASTER.RESIDUAL_AMOUNT%TYPE
            , P_IFRS_DPR_YN              IN FI_ASSET_MASTER.IFRS_DPR_YN%TYPE
            , P_IFRS_DPR_METHOD_TYPE     IN FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE
            , P_IFRS_PROGRESS_YEAR       IN FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE
            , P_IFRS_RESIDUAL_AMOUNT     IN FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE
            , P_VENDOR_ID                IN FI_ASSET_MASTER.VENDOR_ID%TYPE
            , P_MANAGE_DEPT_ID           IN FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE
            , P_COST_CENTER_ID           IN FI_ASSET_MASTER.COST_CENTER_ID%TYPE
            , P_ASSET_STATUS_CODE        IN FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE
            , P_DISUSE_DATE              IN FI_ASSET_MASTER.DISUSE_DATE%TYPE
            , P_REMARK                   IN FI_ASSET_MASTER.REMARK%TYPE
            , P_USER_ID                  IN FI_ASSET_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_DPR_STATUS_CODE                  VARCHAR2(10) := NULL;
    V_IFRS_DPR_STATUS_CODE             VARCHAR2(10) := NULL;
    
  BEGIN
    BEGIN
      SELECT AM.DPR_STATUS_CODE
           , AM.IFRS_DPR_STATUS_CODE
        INTO V_DPR_STATUS_CODE
           , V_IFRS_DPR_STATUS_CODE
        FROM FI_ASSET_MASTER AM
      WHERE AM.ASSET_ID         = W_ASSET_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    -- ���� ���� ǥ��.
    IF V_DPR_STATUS_CODE IS NULL AND P_DPR_YN = 'Y' THEN
      V_DPR_STATUS_CODE := '10';
    ELSIF V_DPR_STATUS_CODE IS NULL AND P_DPR_YN = 'N' THEN
      V_DPR_STATUS_CODE := NULL;
    END IF;
    IF V_IFRS_DPR_STATUS_CODE IS NULL AND P_IFRS_DPR_YN = 'Y' THEN
      V_IFRS_DPR_STATUS_CODE := '10';    
    ELSIF V_IFRS_DPR_STATUS_CODE IS NULL AND P_IFRS_DPR_YN = 'Y' THEN
      V_IFRS_DPR_STATUS_CODE := NULL;
    END IF;
    
    UPDATE FI_ASSET_MASTER
      SET ASSET_DESC               = P_ASSET_DESC
        , EXPENSE_TYPE             = P_EXPENSE_TYPE
        , ASSET_CATEGORY_ID        = P_ASSET_CATEGORY_ID
        , SPEC                     = P_SPEC
        , PURPOSE                  = P_PURPOSE
        , ACQUIRE_DATE             = P_ACQUIRE_DATE
        , REGISTER_DATE            = P_REGISTER_DATE
        , LOCATION_ID              = P_LOCATION_ID
        , LOCATION_DESC            = P_LOCATION_DESC
        , QTY                      = P_QTY
        , UOM_CODE                 = P_UOM_CODE
        , INVEST_ID                = P_INVEST_ID
        , UNIT_PRICE               = P_UNIT_PRICE
        , CURRENCY_CODE            = P_CURRENCY_CODE
        , EXCHANGE_RATE            = P_EXCHANGE_RATE
        , CURR_AMOUNT              = P_CURR_AMOUNT
        , AMOUNT                   = P_AMOUNT        
        , DPR_YN                   = P_DPR_YN
        , DPR_METHOD_TYPE          = P_DPR_METHOD_TYPE
        , DPR_PROGRESS_YEAR        = P_DPR_PROGRESS_YEAR
        , RESIDUAL_AMOUNT          = P_RESIDUAL_AMOUNT
        , DPR_STATUS_CODE          = V_DPR_STATUS_CODE
        , IFRS_DPR_YN              = P_IFRS_DPR_YN
        , IFRS_DPR_METHOD_TYPE     = P_IFRS_DPR_METHOD_TYPE
        , IFRS_PROGRESS_YEAR       = P_IFRS_PROGRESS_YEAR
        , IFRS_RESIDUAL_AMOUNT     = P_IFRS_RESIDUAL_AMOUNT
        , IFRS_DPR_STATUS_CODE     = V_IFRS_DPR_STATUS_CODE
        , VENDOR_ID                = P_VENDOR_ID
        , MANAGE_DEPT_ID           = P_MANAGE_DEPT_ID
        , COST_CENTER_ID           = P_COST_CENTER_ID
        , ASSET_STATUS_CODE        = P_ASSET_STATUS_CODE
        , DISUSE_DATE              = P_DISUSE_DATE
        , REMARK                   = P_REMARK
        , LAST_UPDATE_DATE         = V_SYSDATE
        , LAST_UPDATED_BY          = P_USER_ID
    WHERE ASSET_ID                 = W_ASSET_ID;

  END UPDATE_ASSET_MASTER;

-- �ڻ���� ����.
  PROCEDURE DELETE_ASSET_MASTER
            ( W_ASSET_ID                 IN FI_ASSET_MASTER.ASSET_ID%TYPE
            , P_SOB_ID                   IN FI_ASSET_MASTER.SOB_ID%TYPE
            , P_ORG_ID                   IN FI_ASSET_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM FI_ASSET_MASTER
    WHERE ASSET_ID                 = W_ASSET_ID;
  END DELETE_ASSET_MASTER;
  
---------------------------------------------------------------------------------------------------
-- �ڻ��ڵ� LOOKUP ��ȸ.
  PROCEDURE LU_ASSET_CODE
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT AM.ASSET_DESC
           , AM.ASSET_CODE
           , AM.ASSET_ID
        FROM FI_ASSET_MASTER AM
      WHERE AM.SOB_ID              = W_SOB_ID
      ORDER BY AM.ASSET_CODE
      ;

  END LU_ASSET_CODE;




--�ڻ��ڵ� LOOKUP ��ȸ.
PROCEDURE LU_ASSET_CODE_FR_TO
        ( P_CURSOR3              OUT TYPES.TCURSOR3
        , W_ASSET_CODE           IN FI_ASSET_MASTER.ASSET_CODE%TYPE
        , W_ASSET_CATEGORY_ID    IN FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE DEFAULT NULL
        , W_SOB_ID               IN FI_ASSET_MASTER.SOB_ID%TYPE
        )
AS
BEGIN
OPEN P_CURSOR3 FOR
  SELECT AM.ASSET_DESC
       , AM.ASSET_CODE
       , AM.ASSET_ID
    FROM FI_ASSET_MASTER AM
  WHERE AM.ASSET_CODE         >= NVL(W_ASSET_CODE, AM.ASSET_CODE)
    AND AM.ASSET_CATEGORY_ID  = NVL(W_ASSET_CATEGORY_ID, AM.ASSET_CATEGORY_ID)
    AND AM.SOB_ID             = W_SOB_ID
  ORDER BY AM.ASSET_CODE
  ;
END LU_ASSET_CODE_FR_TO;





-- �ڻ�CATEGORY LOOKUP ��ȸ.
  PROCEDURE LU_ASSET_CATEGORY
            ( P_CURSOR3              OUT TYPES.TCURSOR3
            , W_SOB_ID               IN FI_BANK.SOB_ID%TYPE
            , W_ENABLED_YN           IN VARCHAR2
            )
  AS
    V_STD_DATE                       DATE := NULL;

  BEGIN
    IF W_ENABLED_YN = 'Y' THEN
      V_STD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT AC.ASSET_CATEGORY_NAME
           , AC.ASSET_CATEGORY_CODE
           , AC.ASSET_CATEGORY_ID
           , AC.DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AC.DPR_METHOD_TYPE, AC.SOB_ID) AS DPR_METHOD_NAME
           , AC.PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('10', AC.DPR_METHOD_TYPE, AC.SOB_ID, AC.PROGRESS_YEAR) AS DPR_RATE
           , AC.RESIDUAL_AMOUNT
           , AC.IFRS_DPR_METHOD_TYPE
           , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', AC.IFRS_DPR_METHOD_TYPE, AC.SOB_ID) AS IFRS_DPR_METHOD_NAME
           , AC.IFRS_PROGRESS_YEAR
           , FI_DPR_RATE_G.DPR_RATE_F('20', AC.IFRS_DPR_METHOD_TYPE, AC.SOB_ID, AC.IFRS_PROGRESS_YEAR) AS IFRS_DPR_RATE
           , AC.IFRS_RESIDUAL_AMOUNT
        FROM FI_ASSET_CATEGORY AC
       WHERE AC.SOB_ID              = W_SOB_ID
         AND AC.ENABLED_FLAG        = DECODE(W_ENABLED_YN, 'Y', 'Y', AC.ENABLED_FLAG)
         AND AC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_FR)
         AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, AC.EFFECTIVE_DATE_TO))
      ORDER BY AC.ASSET_CATEGORY_CODE
      ;  
  
  END LU_ASSET_CATEGORY;









--�ϱ� ���Ͱ� �ӵ����� ������ �����̴�.(2011.10.18)




--��ȸ
PROCEDURE LIST_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE             --ȸ����̵�
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE  --�ڻ��������̵�
    , W_ASSET_CODE          IN  FI_ASSET_MASTER.ASSET_CODE%TYPE         --�ڻ��ڵ�
    , W_ASSET_STATUS_CODE   IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE  --�ڻ����
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
         A.SOB_ID               --ȸ����̵�
       , A.ORG_ID               --����ξ��̵�
       , A.ASSET_CATEGORY_ID    --�ڻ��������̵�
       , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY   --�ڻ�����
       , A.ASSET_ID           --�ڻ���̵�
       , A.ASSET_CODE         --�ڻ��ڵ�
       , A.ASSET_DESC         --�ڻ��
       , A.ASSET_STATUS_CODE  --�ڻ����
       , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', A.ASSET_STATUS_CODE, A.SOB_ID) AS ASSET_STATUS_NM  --�ڻ����
       , A.ACQUIRE_DATE   --�������
       , A.REGISTER_DATE  --�������
       , A.DISUSE_DATE    --���(�Ű�)����   
       , A.AMOUNT         --���ݾ� 

       --��ǥ��Ͽ��ο� ���� ���� ���ɿ��θ� �Ǵ��Ѵ�.
       , CASE
            WHEN NVL(B.CNT, 0) > 0 THEN 'Y'
            ELSE 'N'
         END SLIP_REG_YN
            
        --�ڻ꺯������
        , (SELECT
            CASE
                WHEN COUNT(*) > 0 THEN 'Y'
                ELSE 'N'
            END
            FROM FI_ASSET_HISTORY
            WHERE SOB_ID = A.SOB_ID
                AND ORG_ID = A.ORG_ID
                AND ASSET_ID = A.ASSET_ID    ) AS ASSET_CHANGE_YN            
       
       , A.EXPENSE_TYPE   --��񱸺�
       , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', A.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --��񱸺�
       , A.COST_CENTER_ID --�������̵�
       , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
       , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������
       
       , A.QTY        --����
       , A.PURPOSE    --�뵵
       , A.VENDOR_ID  --�ŷ�ó���̵�
       , FI_COMMON_G.SUPP_CUST_ID_NAME_F(A.VENDOR_ID) AS VENDOR_NM   --�ŷ�ó
       , A.MANAGE_DEPT_ID --�����μ����̵�
       , FI_DEPT_MASTER_G.DEPT_NAME_F(A.MANAGE_DEPT_ID) AS MANAGE_DEPT_NM --�����μ�
       , REMARK --���

       , A.IFRS_DPR_YN            --(IFRS)�󰢿��� [N:�̻�,Y:��] ; INSERT�� �⺻���� 'Y'�� �����Ѵ�.
       , A.IFRS_DPR_METHOD_TYPE   --(IFRS)�����󰢹��
       , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.IFRS_DPR_METHOD_TYPE, A.SOB_ID) AS IFRS_DPR_METHOD_NM --(IFRS)�����󰢹��
       , A.IFRS_PROGRESS_YEAR --(IFRS)������
       , A.IFRS_RESIDUAL_AMOUNT   --(IFRS)��������
       , A.IFRS_DPR_STATUS_CODE   --(IFRS)�󰢻���
       , FI_COMMON_G.CODE_NAME_F('DPR_STATUS', A.IFRS_DPR_STATUS_CODE, A.SOB_ID) AS IFRS_DPR_STATUS_NM  --(IFRS)�󰢻���
       , 0 AS IFRS_DPR_SUM_AMOUNT    --(IFRS)�󰢴����
       , 0 AS IFRS_DPR_REMAIN_AMOUNT --(IFRS)�̻��ܾ�
       
       -- 2013.06.06 ��ȣ�� �߰� : ����� ���� --       
       , A.TAX_CODE
       , FI_COMMON_G.CODE_NAME_F('TAX_CODE', A.TAX_CODE, A.SOB_ID, A.ORG_ID) AS TAX_DESC
       
       --, LOCATION_ID    --�ڻ���ġ_���̵�
       --, FI_COMMON_G.ID_NAME_F(LOCATION_ID) AS LOCATION_NM    --�ڻ���ġ  
       --, IFRS_DPR_LAST_PERIOD   --(IFRS)�����󰢳��
       
    FROM FI_ASSET_MASTER A
        , (SELECT SOB_ID, ASSET_CATEGORY_ID, ASSET_ID, COUNT(*) AS CNT
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND DPR_TYPE = '20'
                AND SLIP_YN = 'Y'
            GROUP BY SOB_ID, ASSET_CATEGORY_ID, ASSET_ID) B    
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID --�ڻ��������̵�
        AND A.ASSET_CODE = NVL(W_ASSET_CODE, A.ASSET_CODE)  --�ڻ��ڵ�
        AND A.ASSET_STATUS_CODE = NVL(W_ASSET_STATUS_CODE, A.ASSET_STATUS_CODE) --�ڻ����

        AND A.SOB_ID = B.SOB_ID(+)
        AND A.ASSET_CATEGORY_ID = B.ASSET_CATEGORY_ID(+)
        AND A.ASSET_ID = B.ASSET_ID(+)
    ORDER BY A.ASSET_CODE ;

END LIST_ASSET_MASTER;








--�ڻ���� �ű��ڷ� ���
PROCEDURE INS_ASSET_MASTER( 
      P_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE                 --ȸ����̵�
    , P_ORG_ID                  IN  FI_ASSET_MASTER.ORG_ID%TYPE                 --����ξ��̵�     
    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE      --�ڻ��������̵�
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE             --�ڻ��
    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --�������
    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --�������
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --���ݾ� 
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --��񱸺�
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --�������̵�
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE                    --����
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE                --�뵵
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE              --�ŷ�ó���̵�
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE         --�����μ����̵�
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE                 --���
    , P_IFRS_DPR_METHOD_TYPE    IN  FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE   --(IFRS)�����󰢹��
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)������
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)��������
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)�󰢻���
    
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --�ڻ����    

    , P_CREATED_BY              IN  FI_ASSET_MASTER.CREATED_BY%TYPE             --������  
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- ������ڵ�. 
)

AS

V_SYSDATE               DATE := GET_LOCAL_DATE(P_SOB_ID);
t_CNT                   NUMBER := 0;    --�ش� �ڻ��������̵�� ��ϵ� �ڻ��� �ִ��� ���� �ľ�
t_ASSET_CATEGORY_CODE   FI_ASSET_CATEGORY.ASSET_CATEGORY_CODE%TYPE := NULL; --�ڻ������ڵ�
t_ASSET_CODE            FI_ASSET_MASTER.ASSET_CODE%TYPE := NULL;            --�ڻ��ڵ�
t_ASSET_ID              FI_ASSET_MASTER.ASSET_ID%TYPE := NULL;              --�ڻ���̵�

BEGIN

     --�ش� �ڻ��������̵�� ��ϵ� �ڻ��� �ִ��� ���� �ľ�
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_MASTER
    WHERE ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID   ;
    
    
    --�ڻ��ڵ� ä��
    IF t_CNT = 0 THEN   --�ش� �ڻ��������̵�� ��ϵ� �ڻ��� ���� ���
    
        --�ڻ������ڵ带 ���Ѵ�.
        SELECT ASSET_CATEGORY_CODE
        INTO t_ASSET_CATEGORY_CODE
        FROM FI_ASSET_CATEGORY
        WHERE ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID   ;

        SELECT t_ASSET_CATEGORY_CODE || '000000001'
        INTO t_ASSET_CODE
        FROM DUAL   ;
        
    ELSE       --�ش� �ڻ��������̵�� ��ϵ� �ڻ��� �ִ� ���
        SELECT SUBSTR(MAX(ASSET_CODE), 1, 1) || LPAD(SUBSTR(MAX(ASSET_CODE), 2) + 1, 9, 0)
        INTO t_ASSET_CODE
        FROM FI_ASSET_MASTER
        WHERE ASSET_CATEGORY_ID = P_ASSET_CATEGORY_ID   ;    
    END IF;
    
    
    
    --�ڻ���̵�
    SELECT NVL(MAX(ASSET_ID), 0) + 1 
    INTO t_ASSET_ID
    FROM FI_ASSET_MASTER    ;


    INSERT INTO FI_ASSET_MASTER( 
          SOB_ID                --ȸ����̵�
        , ORG_ID                --����ξ��̵�     
        , ASSET_CATEGORY_ID     --�ڻ��������̵�
        , ASSET_DESC            --�ڻ��
        , ACQUIRE_DATE          --�������
        , REGISTER_DATE         --�������
        , AMOUNT                --���ݾ� 
        , EXPENSE_TYPE          --��񱸺�
        , COST_CENTER_ID        --�������̵�
        , QTY                   --����
        , PURPOSE               --�뵵
        , VENDOR_ID             --�ŷ�ó���̵�
        , MANAGE_DEPT_ID        --�����μ����̵�
        , REMARK                --���
        , IFRS_DPR_METHOD_TYPE  --(IFRS)�����󰢹��
        , IFRS_PROGRESS_YEAR    --(IFRS)������
        , IFRS_RESIDUAL_AMOUNT  --(IFRS)��������
        , IFRS_DPR_STATUS_CODE  --(IFRS)�󰢻���
        
        , ASSET_ID              --�ڻ���̵�
        , ASSET_CODE            --�ڻ��ڵ�
        , ASSET_STATUS_CODE     --�ڻ����
        , IFRS_DPR_YN           --(IFRS)�󰢿���
        , DPR_METHOD_TYPE       --(K-GAAP)�����󰢹��
        
        , CREATION_DATE         --��������
        , CREATED_BY            --������
        , LAST_UPDATE_DATE      --������������
        , LAST_UPDATED_BY       --���������� 
        , TAX_CODE              --������ڵ� 
    )
    VALUES
    ( 
          P_SOB_ID                  --ȸ����̵�
        , P_ORG_ID                  --����ξ��̵�     
        , P_ASSET_CATEGORY_ID       --�ڻ��������̵�
        , P_ASSET_DESC              --�ڻ��
        , P_ACQUIRE_DATE            --�������
        , P_REGISTER_DATE           --�������
        , P_AMOUNT                  --���ݾ� 
        , P_EXPENSE_TYPE            --��񱸺�
        , P_COST_CENTER_ID          --�������̵�
        , P_QTY                     --����
        , P_PURPOSE                 --�뵵
        , P_VENDOR_ID               --�ŷ�ó���̵�
        , P_MANAGE_DEPT_ID          --�����μ����̵�
        , P_REMARK                  --���
        , P_IFRS_DPR_METHOD_TYPE    --(IFRS)�����󰢹��
        , P_IFRS_PROGRESS_YEAR      --(IFRS)������
        , P_IFRS_RESIDUAL_AMOUNT    --(IFRS)��������
        , NVL(P_IFRS_DPR_STATUS_CODE, '20')    --(IFRS)�󰢻��� 20:�̻�
        
        , t_ASSET_ID    --�ڻ���̵�
        , t_ASSET_CODE  --�ڻ��ڵ�
        , P_ASSET_STATUS_CODE          --�ڻ����  [10(���)]
        , 'Y'           --(IFRS)�󰢿��� [N:�̻�,Y:��]
        , '1'           --(K-GAAP)�����󰢹��   [1(���׹�)]
        
        , GET_LOCAL_DATE(P_SOB_ID)  --��������
        , P_CREATED_BY              --������
        , GET_LOCAL_DATE(P_SOB_ID)  --������������
        , P_CREATED_BY              --���������� 
        , P_TAX_CODE                --������ڵ� 
    );
    
    
    --�����󰢽����� ����
    CREATE_ASSET_DPR_HISTORY(
          P_SOB_ID                  --ȸ����̵�
        , P_ORG_ID                  --����ξ��̵�
        
        , P_ASSET_CATEGORY_ID       --�ڻ��������̵�    
        , t_ASSET_ID                --�ڻ���̵�
        , P_IFRS_DPR_METHOD_TYPE    --(IFRS)�����󰢹��_�ڵ� 
        , P_COST_CENTER_ID          --�������̵�        

        , P_ACQUIRE_DATE            --������� 
        , P_IFRS_PROGRESS_YEAR      --(IFRS)������
        , P_AMOUNT                  --���ݾ� 
        , P_IFRS_RESIDUAL_AMOUNT    --(IFRS)��������        

        , P_CREATED_BY              --������     
    );

END INS_ASSET_MASTER;







--�����󰢽����� ����
PROCEDURE CREATE_ASSET_DPR_HISTORY( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --����ξ��̵�

    , P_ASSET_CATEGORY_ID       IN  FI_ASSET_DPR_HISTORY.ASSET_CATEGORY_ID%TYPE --�ڻ��������̵�
    , P_ASSET_ID                IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�
    , P_DPR_METHOD_TYPE         IN  FI_ASSET_DPR_HISTORY.DPR_METHOD_TYPE%TYPE   --�����󰢹��
    , P_COST_CENTER_ID          IN  FI_ASSET_DPR_HISTORY.COST_CENTER_ID%TYPE    --�������̵�
    
    , P_ACQUIRE_DATE            IN  FI_ASSET_MASTER.ACQUIRE_DATE%TYPE           --������� 
    , P_IFRS_PROGRESS_YEAR      IN  FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE     --(IFRS)������
    , P_AMOUNT                  IN  FI_ASSET_MASTER.AMOUNT%TYPE                 --���ݾ� 
    , P_IFRS_RESIDUAL_AMOUNT    IN  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE   --(IFRS)��������    
    
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --������     
)

AS

t_DPR_COUNT         FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --��ȸ��
t_PERIOD_NAME       FI_ASSET_DPR_HISTORY.PERIOD_NAME%TYPE;      --�󰢳��
t_DPR_AMOUNT        FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --(����)�����󰢺�
t_DPR_SUM_AMOUNT    FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT%TYPE;   --�����󰢴����
t_DISUSE_YN         FI_ASSET_DPR_HISTORY.DISUSE_YN%TYPE;        --������ȸ������

V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);


BEGIN

    --��ȸ���� ���Ѵ�. ���� ��ȸ�� ��ŭ DATA�� INSERT�ȴ�.
    --��ȸ�� = ������ * 12
    SELECT P_IFRS_PROGRESS_YEAR * 12 
    INTO t_DPR_COUNT
    FROM DUAL;
    

    --�����󰢹��(1:���׹�, 2:������)
    IF P_DPR_METHOD_TYPE = '1' THEN --1:���׹�

        --�󰢱ݾ�(�����󰢺�)�� ���Ѵ�.
        --�����󰢺� = �����󰢴��ݾ�(���ݾ� - ��������) / ������
        SELECT ROUND( (P_AMOUNT - P_IFRS_RESIDUAL_AMOUNT) / t_DPR_COUNT, 0)
        INTO t_DPR_AMOUNT
        FROM DUAL   ;
        
        
        t_DISUSE_YN := 'N'; --������ȸ������
        
        
        --��ȸ�� ��ŭ DATA INSERT
        FOR DPR_CREATE IN 1..t_DPR_COUNT
        LOOP
        
            SELECT
                  TO_CHAR(ADD_MONTHS(P_ACQUIRE_DATE, DPR_CREATE - 1), 'YYYY-MM')
                , t_DPR_AMOUNT * DPR_CREATE
            INTO 
                  t_PERIOD_NAME     --�󰢳��
                , t_DPR_SUM_AMOUNT  --�����󰢴���� = �󰢱ݾ�(�����󰢺�) * ��ȸ�� = ��ȸ���� �����󰢴���� + ��ȸ���� �����󰢺�
            FROM DUAL   ;
                 
            
            --��, ������ ��ȸ���� ��� 
            --�����󰢺�� �ܼ������� �׼���  [�� ���Ϲ������ ���ϱ� ���� �Ʒ��� ������� ��ü�ߴ�.]
            --�����󰢴������ (���ݾ� - ������ġ)�� �ݾ��� �����ȴ�.
            IF DPR_CREATE = t_DPR_COUNT THEN            
                SELECT (P_AMOUNT - P_IFRS_RESIDUAL_AMOUNT) - (t_DPR_AMOUNT * (t_DPR_COUNT - 1)) --�����󰢺�
                    , P_AMOUNT -  P_IFRS_RESIDUAL_AMOUNT    --�����󰢴����
                INTO t_DPR_AMOUNT
                    , t_DPR_SUM_AMOUNT
                FROM DUAL   ;
                
                t_DISUSE_YN := 'Y'; --������ȸ������
            END IF;            
            
                    
            INSERT INTO FI_ASSET_DPR_HISTORY( 
                  SOB_ID            --ȸ����̵�
                , ORG_ID            --����ξ��̵�
                , ASSET_CATEGORY_ID --�ڻ��������̵�
                , ASSET_ID          --�ڻ���̵�    
                , COST_CENTER_ID    --�������̵�
                , DPR_METHOD_TYPE   --�����󰢹��
                , DPR_TYPE          --ȸ�豸��[20 : IFRS]        
                , DPR_YN            --�����󰢿���        
                , SLIP_YN           --��ǥ��������
                
                , DPR_COUNT             --��ȸ��    
                , PERIOD_NAME           --�󰢳��
                , DPR_AMOUNT            --(����)�����󰢺�
                , SP_DPR_AMOUNT         --�߰��󰢾�(��>�ں�������)
                , SP_MNS_DPR_AMOUNT     --�����󰢾�(��>�κиŰ�)
                , SOURCE_AMOUNT         --(����)�����󰢺�
                , DPR_SUM_AMOUNT        --�����󰢴����
                , UN_DPR_REMAIN_AMOUNT  --�̻��ܾ�
                , DISUSE_YN             --������ȸ������
                
                , CREATION_DATE     --��������
                , CREATED_BY        --������
                , LAST_UPDATE_DATE  --������������
                , LAST_UPDATED_BY   --���������� 
            )
            VALUES
            ( 
                  P_SOB_ID              --ȸ����̵�
                , P_ORG_ID              --����ξ��̵�
                , P_ASSET_CATEGORY_ID   --�ڻ��������̵�
                , P_ASSET_ID            --�ڻ���̵�    
                , P_COST_CENTER_ID      --�������̵�
                , P_DPR_METHOD_TYPE     --�����󰢹��
                , '20'                  --ȸ�豸��[20 : IFRS]        
                , 'N'                   --�����󰢿���        
                , 'N'                   --��ǥ��������
                
                , DPR_CREATE            --��ȸ��    
                , t_PERIOD_NAME         --�󰢳��
                , t_DPR_AMOUNT          --(����)�����󰢺�
                , 0                     --�߰��󰢾�(��>�ں�������)
                , 0                     --�����󰢾�(��>�κиŰ�)
                , t_DPR_AMOUNT          --(����)�����󰢺�
                , t_DPR_SUM_AMOUNT              --�����󰢴����
                , P_AMOUNT - t_DPR_SUM_AMOUNT   --�̻��ܾ� = ���ݾ� - �����󰢴����
                , t_DISUSE_YN           --������ȸ������
                
                , V_SYSDATE             --��������
                , P_CREATED_BY          --������
                , V_SYSDATE             --������������
                , P_CREATED_BY          --���������� 
            )   ;

        END LOOP DPR_CREATE;   

    ELSIF P_DPR_METHOD_TYPE = '2' THEN  --2:������

        NULL;     

    END IF;    

END CREATE_ASSET_DPR_HISTORY;










--�� PROCEDURE�� �� ��ϵ� �ڻ��� �����󰢽����� ������ ���� �ӽü� PROCEDURE�� 
--���� ����(2011.10.24) �ܿ��� ������ �ʴ� ���̴�.
PROCEDURE CREATE_BATCH_DPR( 
      P_SOB_ID                  IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , P_ORG_ID                  IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE            --����ξ��̵�       
    , P_CREATED_BY              IN  FI_ASSET_DPR_HISTORY.CREATED_BY%TYPE        --������ 
)

AS

V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);


BEGIN
    --FI_ASSET_DPR_HISTORY(�ڻ꺰�����󰢽����쳻��) ���̺� �ڷ� ����
    DELETE FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = P_SOB_ID
        AND ORG_ID = P_ORG_ID   ;


    FOR DPR_CREATE IN (
        SELECT
              SOB_ID                --ȸ����̵�
            , ORG_ID                --����ξ��̵�
            , ASSET_CATEGORY_ID     --�ڻ��������̵�
            , ASSET_ID              --�ڻ���̵�
            , IFRS_DPR_METHOD_TYPE  --(IFRS)�����󰢹��
            , COST_CENTER_ID        --�������̵�    
            , ACQUIRE_DATE          --������� 
            , IFRS_PROGRESS_YEAR    --(IFRS)������
            , AMOUNT                --���ݾ� 
            , IFRS_RESIDUAL_AMOUNT  --(IFRS)��������           
        FROM FI_ASSET_MASTER
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID        
    )
    LOOP               

        --�����󰢽����� ����
        CREATE_ASSET_DPR_HISTORY(
              DPR_CREATE.SOB_ID                  --ȸ����̵�
            , DPR_CREATE.ORG_ID                  --����ξ��̵�
            
            , DPR_CREATE.ASSET_CATEGORY_ID       --�ڻ��������̵�    
            , DPR_CREATE.ASSET_ID                --�ڻ���̵�
            , DPR_CREATE.IFRS_DPR_METHOD_TYPE    --(IFRS)�����󰢹��_�ڵ� 
            , DPR_CREATE.COST_CENTER_ID          --�������̵�        

            , DPR_CREATE.ACQUIRE_DATE            --������� 
            , DPR_CREATE.IFRS_PROGRESS_YEAR      --(IFRS)������
            , DPR_CREATE.AMOUNT                  --���ݾ� 
            , DPR_CREATE.IFRS_RESIDUAL_AMOUNT    --(IFRS)��������        

            , P_CREATED_BY              --������     
        );

    END LOOP DPR_CREATE;  

END CREATE_BATCH_DPR;











--�ڻ���� ����
PROCEDURE UPD_ASSET_MASTER( 
      W_SOB_ID                  IN  FI_ASSET_MASTER.SOB_ID%TYPE         --ȸ����̵�
    , W_ASSET_CODE              IN  FI_ASSET_MASTER.ASSET_CODE%TYPE     --�ڻ��ڵ�
      
    , P_ASSET_DESC              IN  FI_ASSET_MASTER.ASSET_DESC%TYPE     --�ڻ��     
    , P_QTY                     IN  FI_ASSET_MASTER.QTY%TYPE            --����
    , P_PURPOSE                 IN  FI_ASSET_MASTER.PURPOSE%TYPE        --�뵵
    , P_VENDOR_ID               IN  FI_ASSET_MASTER.VENDOR_ID%TYPE      --�ŷ�ó���̵�
    , P_MANAGE_DEPT_ID          IN  FI_ASSET_MASTER.MANAGE_DEPT_ID%TYPE --�����μ����̵�
    , P_REMARK                  IN  FI_ASSET_MASTER.REMARK%TYPE --���

    , P_REGISTER_DATE           IN  FI_ASSET_MASTER.REGISTER_DATE%TYPE          --�������       
    , P_EXPENSE_TYPE            IN  FI_ASSET_MASTER.EXPENSE_TYPE%TYPE           --��񱸺�
    , P_COST_CENTER_ID          IN  FI_ASSET_MASTER.COST_CENTER_ID%TYPE         --�������̵�
    , P_ASSET_STATUS_CODE       IN  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE      --�ڻ����
    , P_IFRS_DPR_STATUS_CODE    IN  FI_ASSET_MASTER.IFRS_DPR_STATUS_CODE%TYPE   --(IFRS)�󰢻���   

    , P_LAST_UPDATED_BY         IN  FI_ASSET_MASTER.LAST_UPDATED_BY%TYPE    --����������
    , P_TAX_CODE                IN  FI_ASSET_MASTER.TAX_CODE%TYPE               -- ������ڵ�.
)

AS

BEGIN

    UPDATE FI_ASSET_MASTER
    SET
          ASSET_DESC            = P_ASSET_DESC              --�ڻ��     
        , QTY                   = P_QTY                     --����
        , PURPOSE               = P_PURPOSE                 --�뵵
        , VENDOR_ID             = P_VENDOR_ID               --�ŷ�ó���̵�
        , MANAGE_DEPT_ID        = P_MANAGE_DEPT_ID          --�����μ����̵�
        , REMARK                = P_REMARK                  --���
        , REGISTER_DATE         = P_REGISTER_DATE           --�������       
        , EXPENSE_TYPE          = P_EXPENSE_TYPE            --��񱸺�
        , COST_CENTER_ID        = P_COST_CENTER_ID          --�������̵�        
        , ASSET_STATUS_CODE     = P_ASSET_STATUS_CODE       --�ڻ����
        , IFRS_DPR_STATUS_CODE  = P_IFRS_DPR_STATUS_CODE    --(IFRS)�󰢻���
        
        , LAST_UPDATE_DATE      = GET_LOCAL_DATE(SOB_ID)    --������������
        , LAST_UPDATED_BY       = P_LAST_UPDATED_BY         --����������
        , TAX_CODE              = P_TAX_CODE                -- ������ڵ� 
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CODE = W_ASSET_CODE ;

END UPD_ASSET_MASTER;







--�ڻ���� ����
PROCEDURE DEL_ASSET_MASTER(
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --ȸ����̵�
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_CODE%TYPE --�ڻ���̵�
)

AS

t_SLIP_CNT          NUMBER := 0;
t_ASSET_HISTORY_CNT NUMBER := 0;
BASE_DATA           EXCEPTION;

BEGIN

    --�ش� �ڻ��� �����󰢽����� �ڷ� �� ��ǥ�� ��ϵ� �ڷᰡ �ִ����� �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO t_SLIP_CNT
    FROM FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND DPR_TYPE = '20'
        AND ASSET_ID = W_ASSET_ID
        AND SLIP_YN = 'Y'   ;      
    
    --�ش� �ڻ��� �ڻ꺯������ �ڷᰡ �ִ����� �ľ��Ѵ�.
    SELECT COUNT(*)
    INTO t_ASSET_HISTORY_CNT
    FROM FI_ASSET_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID   ;
     
       
    --�ش� �ڻ��� �����󰢽����� �ڷ� �� ��ǥ�� ��ϵ� �ڷ� �Ǵ� �ڻ꺯������ �ڷᰡ �ִ� ��� ���޽����� ����.
    IF t_SLIP_CNT > 0 OR t_ASSET_HISTORY_CNT > 0 THEN
      RAISE BASE_DATA;
    END IF;      


    --�ش� �ڻ��� �ڷḦ �����Ѵ�.
    DELETE FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID ;
        
        
    --FI_ASSET_DPR_HISTORY(�����ڻ�_�����󰢽����쳻��) ���̺��� �����Ϸ��� �ڻ��� �����󰢽����� �ڷḦ �����Ѵ�.  
    DELETE FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND DPR_TYPE = '20' --20:IFRS
        AND ASSET_ID = W_ASSET_ID ;      
  
        
EXCEPTION
    WHEN BASE_DATA THEN
        --FCM_10307, �����ڷ�� ������ �� �����ϴ�.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10307', NULL));

END DEL_ASSET_MASTER;







--�ڻ꺯������ ��ȸ
PROCEDURE LIST_ASSET_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_HISTORY.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_HISTORY.ORG_ID%TYPE    --����ξ��̵�
    , W_ASSET_ID    IN  FI_ASSET_HISTORY.ASSET_ID%TYPE  --�ڻ���̵�
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID      --ȸ����̵�
        , A.ORG_ID      --����ξ��̵�
        , A.ASSET_ID    --�ڻ���̵�
        , B.ASSET_CODE  --�ڻ��ڵ�
        , B.ASSET_DESC  --�ڻ��
        , A.HISTORY_NUM --�ڻ꺯����ȣ
        
        , A.CHARGE_DATE --��������
        , A.CHARGE_ID   --�������_���̵�
        , FI_COMMON_G.ID_NAME_F(A.CHARGE_ID) AS CHARGE_NM   --�������
        , A.AMOUNT          --(������)�ݾ�
        , A.COST_CENTER_ID  --(������)�������̵�
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������
        -- 2013.06.06 ��ȣ�� �߰� : ����� ���� --       
        , A.TAX_CODE
        , FI_COMMON_G.CODE_NAME_F('TAX_CODE', A.TAX_CODE, A.SOB_ID, A.ORG_ID) AS TAX_DESC
        
        , A.QTY         --(������)����
        , A.DEPT_ID     --�����μ�_���̵�
        , FI_DEPT_MASTER_G.DEPT_NAME_F(A.DEPT_ID) AS MANAGE_DEPT_NM --�����μ�         
        , A.DESCRIPTION --���  
        --, A.LOCATION_ID --�ڻ���ġ���̵�
        --, FI_COMMON_G.ID_NAME_F(A.LOCATION_ID) AS LOCATION_NM    --�ڻ���ġ   
    FROM FI_ASSET_HISTORY A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC 
           FROM FI_ASSET_MASTER
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ASSET_ID = W_ASSET_ID
        AND A.ASSET_ID = B.ASSET_ID
    ORDER BY CHARGE_DATE   ;

END LIST_ASSET_HISTORY;







--�ڻ꺯������ �ű��ڷ� ���
PROCEDURE INS_ASSET_HISTORY( 
      P_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , P_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�    
    , P_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������
    , P_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE         --�������_���̵�
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(������)�ݾ�
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --(������)�������̵�
    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(������)���� 
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --�����μ�_���̵�
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --���    
    
    , P_CREATED_BY      IN  FI_ASSET_HISTORY.CREATED_BY%TYPE        --������ 
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- ������ڵ� 
)

AS

t_CODE  FI_COMMON.CODE%TYPE; --�����ڵ�

t_ASSET_STATUS_CODE  FI_ASSET_MASTER.ASSET_STATUS_CODE%TYPE; --�ڻ����

t_CHARGE_DATE  FI_ASSET_HISTORY.CHARGE_DATE%TYPE; --��������


t_CNT   NUMBER := 0;    --�ش� �ڻ��� �󰢿Ϸ�� ȸ���� �ڷᰡ �ִ����� �ľ��ϱ� ����.

--�ش� �ڻ��� ���°� �Ű� �Ǵ� ���� ��� �츮�� �ڻ��� �ƴѵ� �ڻ꺯�������� ����� �� ����.
OTHERS_ASSET    EXCEPTION;

--�������ڴ� ���� �� ���� ������ �Է��� �����ϹǷ� �̸� Ȯ���Ѵ�.
CHARGE_DATE    EXCEPTION;

BEGIN

    SELECT ASSET_STATUS_CODE
    INTO t_ASSET_STATUS_CODE
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = P_SOB_ID
        AND ASSET_ID = P_ASSET_ID   ;


    --�ش� �ڻ��� ���°� �Ű� �Ǵ� ���� ��� �츮�� �ڻ��� �ƴѵ� �ڻ꺯�������� ����� �� ����.
    IF t_ASSET_STATUS_CODE IN ('80', '90') THEN --80 : �Ű�, 90 : ���
      RAISE OTHERS_ASSET;
    END IF;
    
    
    --�ش� �ڻ��� �󰢿Ϸ�� ȸ���� �ڷᰡ �ִ����� �ľ��ϱ� ����.
    SELECT COUNT(*)
    INTO t_CNT
    FROM FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = P_SOB_ID
        AND ORG_ID = P_ORG_ID
        AND ASSET_ID = P_ASSET_ID
        AND DPR_YN = 'Y'    ;    
    

    IF t_CNT > 0 THEN

        --�������ڴ� ���� �� ���� ������ �Է��� �����ϹǷ� �̸� Ȯ���Ѵ�.
        SELECT ADD_MONTHS(TO_DATE(PERIOD_NAME, 'YYYY-MM'), 1)
        INTO t_CHARGE_DATE
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = P_SOB_ID
            AND ORG_ID = P_ORG_ID
            AND ASSET_ID = P_ASSET_ID
            AND DPR_YN = 'Y'
            AND DPR_COUNT = (
                    SELECT MAX(DPR_COUNT)
                    FROM FI_ASSET_DPR_HISTORY
                    WHERE SOB_ID = P_SOB_ID
                        AND ORG_ID = P_ORG_ID
                        AND ASSET_ID = P_ASSET_ID
                        AND DPR_YN = 'Y'    
                )   ;
                
        IF P_CHARGE_DATE < t_CHARGE_DATE THEN
            RAISE CHARGE_DATE;
        END IF;                

    END IF;
    

    INSERT INTO FI_ASSET_HISTORY( 
          SOB_ID            --ȸ����̵�
        , ORG_ID            --����ξ��̵�
        , HISTORY_NUM       --�ڻ꺯����ȣ
        , ASSET_ID          --�ڻ���̵�    
        , CHARGE_DATE       --��������
        , CHARGE_ID         --�������_���̵�
        , AMOUNT            --(������)�ݾ�
        , COST_CENTER_ID    --(������)�������̵�
        , QTY               --(������)����
        , DEPT_ID           --�����μ�_���̵�
        , DESCRIPTION       --���    
        
        , CREATION_DATE     --��������
        , CREATED_BY        --������
        , LAST_UPDATE_DATE  --������������
        , LAST_UPDATED_BY   --���������� 
        , TAX_CODE          --������ڵ� 
    )
    VALUES
    ( 
          P_SOB_ID          --ȸ����̵�
        , P_ORG_ID          --����ξ��̵�        
        , (SELECT NVL(MAX(TO_NUMBER(HISTORY_NUM)), 0) + 1 FROM FI_ASSET_HISTORY)   --�ڻ꺯����ȣ
        , P_ASSET_ID        --�ڻ���̵�    
        , P_CHARGE_DATE     --��������
        , P_CHARGE_ID       --�������_���̵�
        , P_AMOUNT          --(������)�ݾ�
        , P_COST_CENTER_ID  --(������)�������̵�
        , P_QTY             --(������)���� 
        , P_DEPT_ID         --�����μ�_���̵�
        , P_DESCRIPTION     --��� 
        
        , GET_LOCAL_DATE(P_SOB_ID)  --��������
        , P_CREATED_BY              --������
        , GET_LOCAL_DATE(P_SOB_ID)  --������������
        , P_CREATED_BY              --���������� 
        , P_TAX_CODE                --������ ������ڵ� 
    );
    
    -- �ڻ꺯�� : ������ �ڷ� �ݿ� --
    UPDATE FI_ASSET_HISTORY AH
      SET (BF_COST_CENTER_ID
        , BF_QTY            
        , BF_DEPT_ID 
        , BF_TAX_CODE) =
        (SELECT COST_CENTER_ID
              , QTY            
              , MANAGE_DEPT_ID 
              , TAX_CODE
           FROM FI_ASSET_MASTER AM
          WHERE AM.ASSET_ID   = AH.ASSET_ID
        )
     WHERE AH.ASSET_ID        = P_ASSET_ID
    ;
    
    -- �ڻ���� ������Ʈ --
    UPDATE FI_ASSET_MASTER
    SET   COST_CENTER_ID      = P_COST_CENTER_ID
        , QTY                 = P_QTY
        , MANAGE_DEPT_ID      = P_DEPT_ID
        , TAX_CODE            = P_TAX_CODE
        , LAST_UPDATE_DATE    = GET_LOCAL_DATE(SOB_ID) --������������
        , LAST_UPDATED_BY     = P_CREATED_BY            --����������
    WHERE SOB_ID = P_SOB_ID
        AND ASSET_ID = P_ASSET_ID ;

    SELECT FI_COMMON_G.GET_CODE_F(P_CHARGE_ID, P_SOB_ID, P_ORG_ID)
    INTO t_CODE
    FROM DUAL   ;

    --��������� �ں��� �����̸�
    IF t_CODE = '10' THEN
        --������ �Ϳ����� �����󰢽����� �� ����
        CHG_ASSET_DPR_HISTORY(
              P_SOB_ID          --ȸ����̵�
            , P_ORG_ID          --����ξ��̵�
            , P_ASSET_ID        --�ڻ���̵�
            , P_CHARGE_DATE     --��������
            , P_AMOUNT          --(������)�ݾ�
            , P_COST_CENTER_ID  --(������)�������̵�
            , P_CREATED_BY      --����������
        )   ;
    ELSIF t_CODE = '92' THEN   --92 : �κиŰ�
        CHG_ASSET_DPR_HISTORY_PART(
              P_SOB_ID          --ȸ����̵�
            , P_ORG_ID          --����ξ��̵�
            , P_ASSET_ID        --�ڻ���̵�
            , P_CHARGE_DATE     --��������
            , P_AMOUNT          --(������)�ݾ�
            , P_COST_CENTER_ID  --(������)�������̵�
            , P_CREATED_BY      --����������
        )   ;    
    ELSIF t_CODE = '90' THEN   --90 : �ڻ����
        UPDATE FI_ASSET_MASTER
        SET
              ASSET_STATUS_CODE = '90'                  --�ڻ����; 90 : ��� 
            , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID) --������������
            , LAST_UPDATED_BY = P_CREATED_BY            --����������
        WHERE SOB_ID = P_SOB_ID
            AND ASSET_ID = P_ASSET_ID ;
            
        --�ں��������� ��� �� [��, �ں�������, �κиŰ� ����]
        --FI_ASSET_DPR_HISTORY(�����ڻ�_�����󰢽����쳻��) ���̺��� �ش� �ڻ��� �������̵� ����
        --�����󰢹��(1:���׹�, 2:������)�� ���簣�� �������. �����ϰ� ����ȴ�.
        UPD_ASSET_DPR_HISTORY_COST(
              P_SOB_ID          --ȸ����̵�
            , P_ORG_ID          --����ξ��̵�
            , P_ASSET_ID        --�ڻ���̵�
            , P_CHARGE_DATE     --��������
            , P_COST_CENTER_ID  --(������)�������̵�
            , P_CREATED_BY      --����������        
        );            
    ELSIF t_CODE = '91' THEN   --91 : �ڻ�Ű�
        UPDATE FI_ASSET_MASTER
        SET
              ASSET_STATUS_CODE = '80'                  --�ڻ����; 80 : �Ű�            
            , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID) --������������
            , LAST_UPDATED_BY = P_CREATED_BY            --����������
        WHERE SOB_ID = P_SOB_ID
            AND ASSET_ID = P_ASSET_ID ;
            
        --�ں��������� ��� �� [��, �ں�������, �κиŰ� ����]
        --FI_ASSET_DPR_HISTORY(�����ڻ�_�����󰢽����쳻��) ���̺��� �ش� �ڻ��� �������̵� ����
        --�����󰢹��(1:���׹�, 2:������)�� ���簣�� �������. �����ϰ� ����ȴ�.
        UPD_ASSET_DPR_HISTORY_COST(
              P_SOB_ID          --ȸ����̵�
            , P_ORG_ID          --����ξ��̵�
            , P_ASSET_ID        --�ڻ���̵�
            , P_CHARGE_DATE     --��������
            , P_COST_CENTER_ID  --(������)�������̵�
            , P_CREATED_BY      --����������        
        );            
    ELSE
        
        --�ں��������� ��� �� [��, �ں�������, �κиŰ� ����]
        --FI_ASSET_DPR_HISTORY(�����ڻ�_�����󰢽����쳻��) ���̺��� �ش� �ڻ��� �������̵� ����
        --�����󰢹��(1:���׹�, 2:������)�� ���簣�� �������. �����ϰ� ����ȴ�.
        UPD_ASSET_DPR_HISTORY_COST(
              P_SOB_ID          --ȸ����̵�
            , P_ORG_ID          --����ξ��̵�
            , P_ASSET_ID        --�ڻ���̵�
            , P_CHARGE_DATE     --��������
            , P_COST_CENTER_ID  --(������)�������̵�
            , P_CREATED_BY      --����������        
        );
    
    END IF;    
    

EXCEPTION
    WHEN OTHERS_ASSET THEN
        --FCM_10403, �Ű� �Ǵ� ���� �ڻ����� ���������� ����� �� �����ϴ�.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10403', NULL));
        
    WHEN CHARGE_DATE THEN
        --FCM_10404, �������ڴ� �����󰢿� �Ϳ��� ���ں��� �Է� �����մϴ�.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10404', NULL));        


END INS_ASSET_HISTORY;





--�ں������⿡ ���� �߰��󰢾� ���� �� �����󰢴���װ� �̻��ܾ� �ݾ� ����
PROCEDURE CHG_ASSET_DPR_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������       
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(������)�ݾ�; �߰��Ǵ� �����󰢴��ݾ��̴�.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --�������̵�    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --���������� 
)

AS

t_DPR_COUNT_FR      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --��ȸ��_�ں������⿡ ���� ������ ���۵� ������
t_DPR_COUNT_TO      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --��ȸ��_�ں������⿡ ���� ������ ����� ������
t_DPR_MM_CNT        NUMBER := 0;    --�ں������⿡ ���� �����󰢺� ����� �󰢿����� ���Ѵ�.
t_DPR_AMOUNT        FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --�����󰢺�
t_DPR_AMOUNT_CALC   FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --�����󰢺�_����
t_DPR_SUM_AMOUNT    FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT%TYPE;   --�����󰢴����

t_GET_AMOUNT        FI_ASSET_MASTER.AMOUNT%TYPE;                --���ݾ�
t_CHG_AMOUNT        FI_ASSET_HISTORY.AMOUNT%TYPE;               --�ں�������ݾ� �հ�

t_DPR_METHOD_TYPE   FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE;  --�����󰢹��

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);


BEGIN

    --���ݾ�, �����󰢹��
    SELECT AMOUNT, IFRS_DPR_METHOD_TYPE 
    INTO t_GET_AMOUNT, t_DPR_METHOD_TYPE
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID   ;
        
        
    --��氡���� ���ϱ� ���� �ڻ꺯�������� �ں������� �ݾ��� ���� ���Ѵ�.
    SELECT SUM(AMOUNT)
    INTO t_CHG_AMOUNT
    FROM FI_ASSET_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND ASSET_ID = W_ASSET_ID
        AND CHARGE_ID = (SELECT COMMON_ID
                         FROM FI_COMMON
                         WHERE GROUP_CODE = 'ASSET_CHARGE' AND CODE = '10')    ;   
    
    --�����ֵ氡��
    t_GET_AMOUNT := t_GET_AMOUNT + t_CHG_AMOUNT;
    
    
    --�����󰢹��(1:���׹�, 2:������)
    IF t_DPR_METHOD_TYPE = '1' THEN --1:���׹�
    
        --��ȸ��_�ں������⿡ ���� ������ ���۵� ������
        SELECT DPR_COUNT
        INTO t_DPR_COUNT_FR
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID
            AND PERIOD_NAME = (SELECT TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') FROM DUAL)    ;

        --��ȸ��_�ں������⿡ ���� ������ ����� ������
        SELECT MAX(DPR_COUNT)
        INTO t_DPR_COUNT_TO
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID   ;


        --�ں������⿡ ���� �����󰢺� ����� �󰢿����� ���Ѵ�.
        SELECT t_DPR_COUNT_TO - t_DPR_COUNT_FR + 1
        INTO t_DPR_MM_CNT
        FROM DUAL   ;


        --�߰��� �����󰢺� ���Ѵ�.
        SELECT ROUND( P_AMOUNT / t_DPR_MM_CNT, 0)
        INTO t_DPR_AMOUNT
        FROM DUAL   ;        
        
        
        --��ȸ�� ��ŭ DATA INSERT
        FOR DPR_CHG IN (
            SELECT
                  ASSET_ID              --�ڻ���̵�        
                , DPR_COUNT             --��ȸ��    
                , DPR_AMOUNT            --�����󰢺�
                , SP_DPR_AMOUNT         --�߰��󰢾�(��>�ں�������)
                , DPR_SUM_AMOUNT        --�����󰢴����
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID
                AND DPR_COUNT BETWEEN t_DPR_COUNT_FR AND t_DPR_COUNT_TO 
            ORDER BY DPR_COUNT
        )
        LOOP
            --���� �ʱ�ȭ
            t_DPR_SUM_AMOUNT := 0;
        
            --�����Ϸ��� ��ȸ�� ������ �����󰢴������ ���Ѵ�.
            SELECT DPR_SUM_AMOUNT
            INTO t_DPR_SUM_AMOUNT
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = (DPR_CHG.DPR_COUNT - 1)   ;
            
            IF DPR_CHG.DPR_COUNT = t_DPR_COUNT_TO THEN 
                --��, ������ ��ȸ���� ��� 
                --�߰��󰢾�(��>�ں�������)�� �ܼ������� �׼� 
                --����� �����󰢴���� = �� ȸ���� �����󰢴���� + ( ������ �����󰢺� +  �߰��󰢾�)                
            
                SELECT DPR_CHG.SP_DPR_AMOUNT + P_AMOUNT - t_DPR_AMOUNT * (t_DPR_COUNT_TO - t_DPR_COUNT_FR)  --�߰��󰢾�
                    , t_DPR_SUM_AMOUNT + DPR_CHG.DPR_AMOUNT + 
                            ( DPR_CHG.SP_DPR_AMOUNT + P_AMOUNT - t_DPR_AMOUNT * (t_DPR_COUNT_TO - t_DPR_COUNT_FR) ) --�߰��󰢾�
                INTO t_DPR_AMOUNT_CALC
                    , t_DPR_SUM_AMOUNT
                FROM DUAL   ;
                
            ELSE    --��ȸ���� �������� �ƴѰ��
            
                t_DPR_AMOUNT_CALC := DPR_CHG.SP_DPR_AMOUNT + t_DPR_AMOUNT;   --�߰��󰢾�(��>�ں�������)

                --����� �����󰢴���� = �� ȸ���� �����󰢴���� + ( ������ �����󰢺� +  �߰��󰢾�)
                t_DPR_SUM_AMOUNT := t_DPR_SUM_AMOUNT + ( DPR_CHG.DPR_AMOUNT + DPR_CHG.SP_DPR_AMOUNT + t_DPR_AMOUNT);
            
            END IF;            


            UPDATE FI_ASSET_DPR_HISTORY
            SET   SP_DPR_AMOUNT = t_DPR_AMOUNT_CALC    --�߰��󰢾�(��>�ں�������)
            
                --(����)�����󰢺� = (����)�����󰢺� + �߰��󰢾� - �����󰢾�
                , SOURCE_AMOUNT = DPR_AMOUNT + t_DPR_AMOUNT_CALC - SP_MNS_DPR_AMOUNT
                
                , DPR_SUM_AMOUNT = t_DPR_SUM_AMOUNT --����� �����󰢴����
                
                --����� �̻��ܾ� = ��氡�� - ����� �����󰢴����
                --����>��氡�� = ���ݾ� + �ں�������ݾ��� �հ�
                , UN_DPR_REMAIN_AMOUNT = t_GET_AMOUNT - t_DPR_SUM_AMOUNT
                
                , COST_CENTER_ID = P_COST_CENTER_ID --�������̵�
                , REMARK = REMARK || '�ں�������(' || TO_CHAR(P_CHARGE_DATE, 'YYYYMMDD') || ') ; '  --���
                , LAST_UPDATE_DATE = V_SYSDATE          --������������
                , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --����������
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = DPR_CHG.DPR_COUNT   ;
                        
        END LOOP DPR_CHG;   

    ELSIF t_DPR_METHOD_TYPE = '2' THEN  --2:������

        NULL;

    END IF;    

END CHG_ASSET_DPR_HISTORY;







--�κиŰ��� ���� �����󰢾� ���� �� �����󰢴���װ� �̻��ܾ� �ݾ� ����
PROCEDURE CHG_ASSET_DPR_HISTORY_PART( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�
    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������       
    , P_AMOUNT          IN  FI_ASSET_HISTORY.AMOUNT%TYPE            --(������)�ݾ�; �κиŰ��ݾ�; �����Ǵ� �����󰢴��ݾ��̴�.
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --�������̵�    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --���������� 
)

AS

t_DPR_COUNT         FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --��ȸ��
t_DPR_COUNT_FR      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --��ȸ��_�κиŰ��� ���� ������ ���۵� ������
t_DPR_COUNT_TO      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --��ȸ��_�κиŰ��� ���� ������ ����� ������
t_DPR_AMOUNT        FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --�����󰢺�
t_DPR_AMOUNT_CALC   FI_ASSET_DPR_HISTORY.DPR_AMOUNT%TYPE;       --�����󰢺�_����
t_DPR_SUM_AMOUNT    FI_ASSET_DPR_HISTORY.DPR_SUM_AMOUNT%TYPE;   --�����󰢴����
t_SOURCE_AMOUNT     FI_ASSET_DPR_HISTORY.SOURCE_AMOUNT%TYPE;    --(����)�����󰢺�

t_UN_DPR_REMAIN_AMOUNT  FI_ASSET_DPR_HISTORY.UN_DPR_REMAIN_AMOUNT%TYPE; --�̻��ܾ�
t_GET_AMOUNT            FI_ASSET_MASTER.AMOUNT%TYPE;                    --���ݾ�
t_IFRS_PROGRESS_YEAR    FI_ASSET_MASTER.IFRS_PROGRESS_YEAR%TYPE;        --������
t_IFRS_RESIDUAL_AMOUNT  FI_ASSET_MASTER.IFRS_RESIDUAL_AMOUNT%TYPE;      --��������

t_DPR_MM_CNT        NUMBER := 0;    --�κиŰ��� ���� �����󰢺� ����� �󰢿����� ���Ѵ�.
t_DPR_TARGET_AMOUNT NUMBER := 0;    --�κиŰ��� ���� �����󰢴��ݾ�
t_MM_MINUS_AMOUNT   NUMBER := 0;    --�κиŰ��� ���� �� �����󰢾�

t_DPR_METHOD_TYPE   FI_ASSET_MASTER.IFRS_DPR_METHOD_TYPE%TYPE;  --�����󰢹��

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);


BEGIN

    --���ݾ�, �����󰢹��, (IFRS)������, (IFRS)��������
    SELECT AMOUNT, IFRS_DPR_METHOD_TYPE, IFRS_PROGRESS_YEAR, IFRS_RESIDUAL_AMOUNT 
    INTO t_GET_AMOUNT, t_DPR_METHOD_TYPE, t_IFRS_PROGRESS_YEAR, t_IFRS_RESIDUAL_AMOUNT
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_ID = W_ASSET_ID   ;
        
        
    --��ȸ���� ���Ѵ�. ���� ��ȸ�� ��ŭ DATA�� INSERT�ȴ�.
    --��ȸ�� = ������ * 12
    SELECT t_IFRS_PROGRESS_YEAR * 12 
    INTO t_DPR_COUNT
    FROM DUAL   ;
    
    --�κиŰ��� ���� �����󰢴��ݾ��� ���Ѵ�.
    --�κиŰ��� ���� �����󰢴��ݾ� = ���ݾ� - �κиŰ��ݾ� - ��������
    SELECT t_GET_AMOUNT - P_AMOUNT - t_IFRS_RESIDUAL_AMOUNT
    INTO t_DPR_TARGET_AMOUNT
    FROM DUAL   ;  
    
    
    --�κиŰ��� ���� �� �����󰢺� ���Ѵ�.
    --�κиŰ��� ���� �� �����󰢺� = �κиŰ��� ���� �����󰢴��ݾ� / ��ȸ��
    SELECT ROUND(t_DPR_TARGET_AMOUNT / t_DPR_COUNT, 0)
    INTO t_DPR_AMOUNT
    FROM DUAL  ;
    
    
    --��ȸ��_�κиŰ��� ���� ������ ���۵� ������
    SELECT DPR_COUNT
    INTO t_DPR_COUNT_FR
    FROM FI_ASSET_DPR_HISTORY
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
        AND ASSET_ID = W_ASSET_ID
        AND PERIOD_NAME = (SELECT TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') FROM DUAL)    ;
        
        
    --�κиŰ� �� ������ = �ڻ� ������� ���ݾ� - �κиŰ��ݾ�
    t_GET_AMOUNT := t_GET_AMOUNT - P_AMOUNT;
        

    --�κиŰ��� �߻��� ȸ���� �����󰢴���װ� �̻��ܾ��� �����Ѵ�.
    UPDATE FI_ASSET_DPR_HISTORY
    SET
          --����� �����󰢴���� = �κиŰ��� ���� �� �����󰢺� * �κиŰ��� ���� ������ ���۵� ������
          DPR_SUM_AMOUNT = t_DPR_AMOUNT * t_DPR_COUNT_FR
        
        --����� �̻��ܾ� = �κиŰ� �� ������ - ����� �����󰢴����
        , UN_DPR_REMAIN_AMOUNT = t_GET_AMOUNT - (t_DPR_AMOUNT * t_DPR_COUNT_FR)
        
        , REMARK = REMARK || '�κиŰ�(' || TO_CHAR(P_CHARGE_DATE, 'YYYYMMDD') || ') ; '  --���
        , LAST_UPDATE_DATE = V_SYSDATE          --������������
        , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --����������
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
        AND ASSET_ID = W_ASSET_ID 
        AND DPR_COUNT = t_DPR_COUNT_FR   ;       

    
    --�����󰢹��(1:���׹�, 2:������)
    IF t_DPR_METHOD_TYPE = '1' THEN --1:���׹�
    
        --�κиŰ��� ���� �� �����󰢾� = �κиŰ��ݾ� / ��ȸ��
        SELECT ROUND(P_AMOUNT / t_DPR_COUNT, 0)
        INTO t_MM_MINUS_AMOUNT
        FROM DUAL   ;    

        --��ȸ��_�κиŰ��� ���� ������ ����� ������
        SELECT MAX(DPR_COUNT)
        INTO t_DPR_COUNT_TO
        FROM FI_ASSET_DPR_HISTORY
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID   ;
       
       t_DPR_COUNT_FR := t_DPR_COUNT_FR + 1;
        
        --��ȸ�� ��ŭ DATA INSERT
        FOR DPR_CHG IN (
            SELECT
                  ASSET_ID              --�ڻ���̵�        
                , DPR_COUNT             --��ȸ��    
                , DPR_AMOUNT            --�����󰢺�
                , SP_DPR_AMOUNT         --�߰��󰢾�
                , SP_MNS_DPR_AMOUNT     --�����󰢾�(��>�κиŰ�)
                , DPR_SUM_AMOUNT        --�����󰢴����
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID
                AND DPR_COUNT BETWEEN t_DPR_COUNT_FR AND t_DPR_COUNT_TO 
            ORDER BY DPR_COUNT
        )
        LOOP
            --���� �ʱ�ȭ
            t_DPR_SUM_AMOUNT := 0;
        
            --�����Ϸ��� ��ȸ�� ������ �����󰢴������ ���Ѵ�.
            SELECT DPR_SUM_AMOUNT
            INTO t_DPR_SUM_AMOUNT
            FROM FI_ASSET_DPR_HISTORY
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = (DPR_CHG.DPR_COUNT - 1)   ;
            
            IF DPR_CHG.DPR_COUNT = t_DPR_COUNT_TO THEN  -- ������ ��ȸ���� ��� 
                
                --(����)�����󰢺�
                t_SOURCE_AMOUNT := t_DPR_TARGET_AMOUNT - t_DPR_SUM_AMOUNT;
                
                --�����󰢾�(��>�κиŰ�)
                t_DPR_AMOUNT_CALC := DPR_CHG.DPR_AMOUNT - t_SOURCE_AMOUNT;
                
                --����� �����󰢴���� = �κиŰ��� ���� �����󰢴��ݾ�
                t_DPR_SUM_AMOUNT := t_DPR_TARGET_AMOUNT;
                
                --����� �̻��ܾ� = ��������
                t_UN_DPR_REMAIN_AMOUNT := t_IFRS_RESIDUAL_AMOUNT;
                
            ELSE    --��ȸ���� �������� �ƴѰ��
            
                t_DPR_AMOUNT_CALC := DPR_CHG.SP_MNS_DPR_AMOUNT + t_MM_MINUS_AMOUNT;   --�����󰢾�(��>�κиŰ�)
                
                --(����)�����󰢺� = (����)�����󰢺� + �߰��󰢾� - �����󰢾�
                t_SOURCE_AMOUNT := DPR_CHG.DPR_AMOUNT + DPR_CHG.SP_DPR_AMOUNT - t_DPR_AMOUNT_CALC;

                --����� �����󰢴���� = �� ȸ���� �����󰢴���� + (����)�����󰢺�
                t_DPR_SUM_AMOUNT := t_DPR_SUM_AMOUNT + t_SOURCE_AMOUNT;
            
                --����� �̻��ܾ� = �κиŰ� �� ������ - ����� �����󰢴����
                t_UN_DPR_REMAIN_AMOUNT := t_GET_AMOUNT - t_DPR_SUM_AMOUNT;
            END IF;            


            UPDATE FI_ASSET_DPR_HISTORY
            SET   SP_MNS_DPR_AMOUNT = t_DPR_AMOUNT_CALC         --�����󰢾�(��>�κиŰ�)            
                , SOURCE_AMOUNT = t_SOURCE_AMOUNT               --(����)�����󰢺�                
                , DPR_SUM_AMOUNT = t_DPR_SUM_AMOUNT             --����� �����󰢴����                                
                , UN_DPR_REMAIN_AMOUNT = t_UN_DPR_REMAIN_AMOUNT --����� �̻��ܾ�
                
                , COST_CENTER_ID = P_COST_CENTER_ID --�������̵�
                , REMARK = REMARK || '�κиŰ�(' || TO_CHAR(P_CHARGE_DATE, 'YYYYMMDD') || ') ; '  --���
                , LAST_UPDATE_DATE = V_SYSDATE          --������������
                , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --����������
            WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID 
                AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
                AND ASSET_ID = W_ASSET_ID 
                AND DPR_COUNT = DPR_CHG.DPR_COUNT   ;
                        
        END LOOP DPR_CHG;   

    ELSIF t_DPR_METHOD_TYPE = '2' THEN  --2:������

        NULL;

    END IF;    

END CHG_ASSET_DPR_HISTORY_PART;











--�ں��������� ��� �� [��, �ں�������, �κиŰ� ����]
--FI_ASSET_DPR_HISTORY(�����ڻ�_�����󰢽����쳻��) ���̺��� �ش� �ڻ��� �������̵� ����
--�����󰢹��(1:���׹�, 2:������)�� ���簣�� �������. �����ϰ� ����ȴ�.
PROCEDURE UPD_ASSET_DPR_HISTORY_COST( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵�
    , W_ASSET_ID        IN  FI_ASSET_HISTORY.ASSET_ID%TYPE          --�ڻ���̵�    
    , P_CHARGE_DATE     IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE       --��������       
    , P_COST_CENTER_ID  IN  FI_ASSET_HISTORY.COST_CENTER_ID%TYPE    --�������̵�    
    
    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --���������� 
)

AS

t_DPR_COUNT_FR      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --������ ���۵� ������
t_DPR_COUNT_TO      FI_ASSET_DPR_HISTORY.DPR_COUNT%TYPE;        --������ ����� ������

V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);

BEGIN        
    
    BEGIN
      --������ ���۵� ������
      SELECT DPR_COUNT
      INTO t_DPR_COUNT_FR
      FROM FI_ASSET_DPR_HISTORY
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID 
          AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
          AND ASSET_ID = W_ASSET_ID
          AND PERIOD_NAME = (SELECT TO_CHAR(P_CHARGE_DATE, 'YYYY-MM') FROM DUAL)    ;
    EXCEPTION WHEN OTHERS THEN
      t_DPR_COUNT_FR := 0;
    END;           
    
    BEGIN
      --������ ����� ������
      SELECT MAX(DPR_COUNT)
      INTO t_DPR_COUNT_TO
      FROM FI_ASSET_DPR_HISTORY
      WHERE SOB_ID = W_SOB_ID
          AND ORG_ID = W_ORG_ID 
          AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
          AND ASSET_ID = W_ASSET_ID   ;    
    EXCEPTION WHEN OTHERS THEN
      t_DPR_COUNT_TO := 0;
    END;
    

    FOR COST_CHG IN t_DPR_COUNT_FR .. t_DPR_COUNT_TO
    LOOP

        UPDATE FI_ASSET_DPR_HISTORY
        SET   COST_CENTER_ID = P_COST_CENTER_ID     --�������̵�
            , LAST_UPDATE_DATE = V_SYSDATE          --������������
            , LAST_UPDATED_BY = P_LAST_UPDATED_BY   --����������
        WHERE SOB_ID = W_SOB_ID
            AND ORG_ID = W_ORG_ID 
            AND DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
            AND ASSET_ID = W_ASSET_ID 
            AND DPR_COUNT = COST_CHG    ;
                    
    END LOOP COST_CHG;   




END UPD_ASSET_DPR_HISTORY_COST;










--�ڻ꺯������ ����
PROCEDURE UPD_ASSET_HISTORY( 
      W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE            --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE            --����ξ��̵� 
    , W_HISTORY_NUM     IN  FI_ASSET_HISTORY.HISTORY_NUM%TYPE       --�ڻ꺯����ȣ         

    , P_QTY             IN  FI_ASSET_HISTORY.QTY%TYPE               --(������)����       
    , P_DESCRIPTION     IN  FI_ASSET_HISTORY.DESCRIPTION%TYPE       --���
    , P_DEPT_ID         IN  FI_ASSET_HISTORY.DEPT_ID%TYPE           --�����μ�_���̵�

    , P_LAST_UPDATED_BY IN  FI_ASSET_HISTORY.LAST_UPDATED_BY%TYPE   --����������
    , P_TAX_CODE        IN  FI_ASSET_HISTORY.TAX_CODE%TYPE          -- ������ڵ�
)

AS

BEGIN

    UPDATE FI_ASSET_HISTORY
    SET
          QTY               = P_QTY         --(������)����     
        , DESCRIPTION       = P_DESCRIPTION --���
        , DEPT_ID           = P_DEPT_ID     --�����μ�_���̵�
        
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)    --������������
        , LAST_UPDATED_BY   = P_LAST_UPDATED_BY         --����������
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID
        AND HISTORY_NUM = W_HISTORY_NUM ;

END UPD_ASSET_HISTORY;





--�ڻ꺰 �����󰢽����� ��ȸ
PROCEDURE LIST_ASSET_DPR_HISTORY( 
      P_CURSOR      OUT TYPES.TCURSOR
    , W_SOB_ID      IN  FI_ASSET_DPR_HISTORY.SOB_ID%TYPE    --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_DPR_HISTORY.ORG_ID%TYPE    --����ξ��̵�
    , W_ASSET_ID    IN  FI_ASSET_DPR_HISTORY.ASSET_ID%TYPE  --�ڻ���̵�
    --, W_DPR_TYPE    IN  FI_ASSET_DPR_HISTORY.DPR_TYPE%TYPE  --ȸ�豸��    
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID              --ȸ����̵�
        , A.ORG_ID              --����ξ��̵�
        , A.ASSET_CATEGORY_ID   --�ڻ��������̵�
        , FI_ASSET_CATEGORY_G.F_ASSET_CATEGORY_NAME(A.ASSET_CATEGORY_ID) AS ASSET_CATEGORY_NM   --�ڻ�����
        , A.ASSET_ID        --�ڻ���̵�
        , B.ASSET_CODE      --�ڻ��ڵ�
        , B.ASSET_DESC      --�ڻ��
        
        , NVL(A.DPR_YN, 'N') AS DPR_YN  --(����)�󰢿���    
        , A.DPR_COUNT                   --��ȸ��    
        , A.PERIOD_NAME                 --�󰢳��
        , A.DPR_AMOUNT                  --(����)�����󰢺�
        , A.SP_DPR_AMOUNT               --�߰��󰢾�(��>�ں�������)
        , A.SP_MNS_DPR_AMOUNT           --�����󰢾�(��>�κиŰ�)
        --, A.DPR_AMOUNT + A.SP_DPR_AMOUNT - A.SP_MNS_DPR_AMOUNT  AS LAST_DPR_AMOUNT  --����Ȱ����󰢺�
        , A.SOURCE_AMOUNT AS LAST_DPR_AMOUNT    --(����)�����󰢺�
        , A.DPR_SUM_AMOUNT          --�����󰢴����
        , A.UN_DPR_REMAIN_AMOUNT    --�̻��ܾ�

        , B.EXPENSE_TYPE    --��񱸺�
        , FI_COMMON_G.CODE_NAME_F('EXPENSE_TYPE', B.EXPENSE_TYPE, A.SOB_ID) AS EXPENSE_TYPE_NM   --��񱸺�     
        , A.COST_CENTER_ID  --�������̵�
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������         
        , NVL(A.SLIP_YN, 'N') AS SLIP_YN  --��ǥ��������
        , A.SLIP_DATE   --��ǥ����
        , A.GL_NUM      --��ǥ��ȣ
        , A.REMARK      --���
        , A.DPR_TYPE    --ȸ�豸��_�ڵ�[20 : IFRS]
        , FI_COMMON_G.CODE_NAME_F('DPR_TYPE', A.DPR_TYPE, A.SOB_ID) AS DPR_TYPE_NM   --ȸ�豸��
        , A.DPR_METHOD_TYPE --�����󰢹��_�ڵ�
        , FI_COMMON_G.CODE_NAME_F('DPR_METHOD_TYPE', A.DPR_METHOD_TYPE, A.SOB_ID) AS DPR_METHOD_TYPE_NM   --�����󰢹��       
        --, A.DPR_YEAR_AMOUNT         --��󰢱ݾ�
        --, A.DPR_SUM_AMOUNT          --��󰢱ݾ�; ��󰢴����
        --, A.UN_DPR_REMAIN_AMOUNT    --�̻󰢱ݾ�    
    FROM FI_ASSET_DPR_HISTORY A
        , (SELECT ASSET_ID, ASSET_CODE, ASSET_DESC, EXPENSE_TYPE 
           FROM FI_ASSET_MASTER
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID 
        AND A.DPR_TYPE = '20' --ȸ�豸��[20 : IFRS]
        AND A.ASSET_ID = W_ASSET_ID
        AND A.ASSET_ID = B.ASSET_ID
    ORDER BY A.DPR_COUNT    ;

END LIST_ASSET_DPR_HISTORY;






--�ڻ�� ��ȯ
FUNCTION  F_ASSET_DESC( 
      W_SOB_ID      IN  FI_ASSET_MASTER.SOB_ID%TYPE     --ȸ����̵�
    , W_ORG_ID      IN  FI_ASSET_MASTER.ORG_ID%TYPE     --����ξ��̵�
    , W_ASSET_ID    IN  FI_ASSET_MASTER.ASSET_ID%TYPE   --�ڻ���̵�
) RETURN VARCHAR2

AS

t_ASSET_DESC   FI_ASSET_MASTER.ASSET_DESC%TYPE := '';

BEGIN
    
    SELECT ASSET_DESC
    INTO t_ASSET_DESC
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ORG_ID = W_ORG_ID 
        AND ASSET_ID = W_ASSET_ID    ;

    RETURN t_ASSET_DESC;

END F_ASSET_DESC   ;






--�ڻ�� ���� POPUP
PROCEDURE POPUP_ASSET_MASTER( 
      P_CURSOR              OUT TYPES.TCURSOR
    , W_SOB_ID              IN  FI_ASSET_MASTER.SOB_ID%TYPE
    , W_ASSET_CATEGORY_ID   IN  FI_ASSET_MASTER.ASSET_CATEGORY_ID%TYPE    
)

AS

BEGIN

    OPEN P_CURSOR FOR
    
    SELECT 
          ASSET_DESC    --�ڻ��
        , ASSET_CODE    --�ڻ��ڵ�
        , ASSET_ID      --�ڻ���̵�
    FROM FI_ASSET_MASTER
    WHERE SOB_ID = W_SOB_ID
        AND ASSET_CATEGORY_ID = W_ASSET_CATEGORY_ID
    ORDER BY ASSET_CODE    ;
  
END POPUP_ASSET_MASTER;










--�ڻ꺯������ PG�� �ڻ꺯������ ��ȸ
--����>LIST_ASSET_HISTORY PROCEDURE�� �����ϴ�.
PROCEDURE LIST_ASSET_HISTORY_ALL( 
      P_CURSOR          OUT TYPES.TCURSOR
    , W_SOB_ID          IN  FI_ASSET_HISTORY.SOB_ID%TYPE        --ȸ����̵�
    , W_ORG_ID          IN  FI_ASSET_HISTORY.ORG_ID%TYPE        --����ξ��̵�    
    , W_CHARGE_DATE_FR  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --��������_����
    , W_CHARGE_DATE_TO  IN  FI_ASSET_HISTORY.CHARGE_DATE%TYPE   --��������_����
    , W_CHARGE_ID       IN  FI_ASSET_HISTORY.CHARGE_ID%TYPE     --����������̵�
)

AS

BEGIN

    OPEN P_CURSOR FOR

    SELECT
          A.SOB_ID      --ȸ����̵�
        , A.ORG_ID      --����ξ��̵�
        , A.ASSET_ID    --�ڻ���̵�
        , B.ASSET_CODE  --�ڻ��ڵ�
        , B.ASSET_DESC  --�ڻ��
        , B.ASSET_STATUS_NM  --�ڻ����
        , B.ACQUIRE_DATE   --�������
        , B.AMOUNT AS GET_AMOUNT         --���ݾ�
        , B.IFRS_PROGRESS_YEAR --(IFRS)������
    
        , A.HISTORY_NUM --�ڻ꺯����ȣ       
        , A.CHARGE_DATE --��������
        , A.CHARGE_ID   --�������_���̵�
        , FI_COMMON_G.ID_NAME_F(A.CHARGE_ID) AS CHARGE_NM   --�������
        , A.AMOUNT AS CHG_AMOUNT          --(������)�ݾ�
        , A.COST_CENTER_ID  --(������)�������̵�
        , FI_COMMON_G.COST_CENTER_CODE_F(A.COST_CENTER_ID) AS CC_CODE  --�����ڵ�
        , FI_COMMON_G.COST_CENTER_DESC_F(A.COST_CENTER_ID) AS CC_DESC  --������
        , A.QTY         --(������)����
        , A.DEPT_ID     --�����μ�_���̵�
        , FI_DEPT_MASTER_G.DEPT_NAME_F(A.DEPT_ID) AS MANAGE_DEPT_NM --�����μ�         
        , A.DESCRIPTION --���    
    FROM FI_ASSET_HISTORY A
        , (SELECT
              ASSET_ID
            , ASSET_CODE
            , ASSET_DESC
            , ASSET_STATUS_CODE  --�ڻ����
            , FI_COMMON_G.CODE_NAME_F('ASSET_STATUS', ASSET_STATUS_CODE, SOB_ID) AS ASSET_STATUS_NM  --�ڻ����
            , ACQUIRE_DATE   --�������
            , AMOUNT         --���ݾ�
            , IFRS_PROGRESS_YEAR --(IFRS)������
           FROM FI_ASSET_MASTER
           WHERE SOB_ID = W_SOB_ID
                AND ORG_ID = W_ORG_ID
           ) B
    WHERE A.SOB_ID = W_SOB_ID
        AND A.ORG_ID = W_ORG_ID
        AND A.ASSET_ID = B.ASSET_ID
        
        AND CHARGE_DATE BETWEEN NVL(W_CHARGE_DATE_FR, CHARGE_DATE) AND NVL(W_CHARGE_DATE_TO, CHARGE_DATE)
        AND CHARGE_ID = NVL(W_CHARGE_ID, CHARGE_ID)
    ORDER BY CHARGE_DATE, CHARGE_ID   ;

END LIST_ASSET_HISTORY_ALL;








END FI_ASSET_MASTER_G;
/
