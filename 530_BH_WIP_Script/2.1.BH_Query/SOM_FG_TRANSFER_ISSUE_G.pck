CREATE OR REPLACE PACKAGE SOM_FG_TRANSFER_ISSUE_G
IS

-- ��ǰ�� ����(��ǰ��)
  PROCEDURE ITEM_SUMMARY_1_SELECT
            ( P_CURSOR       OUT TYPES.TCURSOR
            , W_TRANSACTION_DATE_FROM   IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_TRANSACTION_DATE_TO     IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_EXCHANGE_RATE_TYPE      IN VARCHAR2
            , W_CUST_SITE_ID            IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
            , W_ITEM_NET_CODE           IN INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
            , W_INVENTORY_ITEM_ID       IN INV_ITEM_MASTER.INVENTORY_ITEM_ID%TYPE
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , W_WAREHOUSE_ID            IN NUMBER
            , W_WH_LOCATION_ID          IN NUMBER
            );

-- ��ǰ�� ����(������ڼ�)
  PROCEDURE ITEM_SUMMARY_2_SELECT
            ( P_CURSOR       OUT TYPES.TCURSOR
            , W_TRANSACTION_DATE_FROM   IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_TRANSACTION_DATE_TO     IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_EXCHANGE_RATE_TYPE      IN VARCHAR2
            , W_CUST_SITE_ID            IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
            , W_ITEM_NET_CODE           IN INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
            , W_INVENTORY_ITEM_ID       IN INV_ITEM_MASTER.INVENTORY_ITEM_ID%TYPE
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , W_WAREHOUSE_ID            IN NUMBER
            , W_WH_LOCATION_ID          IN NUMBER
            );

-- ��ǰ�� ��
  PROCEDURE ITEM_DETAIL_SELECT
            ( P_CURSOR       OUT TYPES.TCURSOR
            , W_TRANSACTION_DATE_FROM   IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_TRANSACTION_DATE_TO     IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_EXCHANGE_RATE_TYPE      IN VARCHAR2
            , W_CUST_SITE_ID            IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
            , W_ITEM_NET_CODE           IN INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
            , W_INVENTORY_ITEM_ID       IN INV_ITEM_MASTER.INVENTORY_ITEM_ID%TYPE
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , W_WAREHOUSE_ID            IN NUMBER
            , W_WH_LOCATION_ID          IN NUMBER
            );

END SOM_FG_TRANSFER_ISSUE_G; 
/
CREATE OR REPLACE PACKAGE BODY SOM_FG_TRANSFER_ISSUE_G
IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : EAPP
/* Program Name : SOM_FG_TRANSFER_ISSUE_G
/* Description  : ��ǰ��� �� ���� PACKAGE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 1-NOV-2010  Lee sun hee      Initialize
/* 11/03/12    Y.G Lee          Update(â��, �����̼� �˻�����)
/******************************************************************************/

-- ��ǰ�� ����(��ǰ��)
  PROCEDURE ITEM_SUMMARY_1_SELECT
            ( P_CURSOR       OUT TYPES.TCURSOR
            , W_TRANSACTION_DATE_FROM   IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_TRANSACTION_DATE_TO     IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_EXCHANGE_RATE_TYPE      IN VARCHAR2
            , W_CUST_SITE_ID            IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
            , W_ITEM_NET_CODE           IN INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
            , W_INVENTORY_ITEM_ID       IN INV_ITEM_MASTER.INVENTORY_ITEM_ID%TYPE
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , W_WAREHOUSE_ID            IN NUMBER
            , W_WH_LOCATION_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT ACS.CUST_SITE_CODE                                 -- �����ڵ�
           , CASE
               WHEN GROUPING(ACS.CUST_SITE_SHORT_NAME) = 1 THEN '���հ�'
               WHEN GROUPING(IIM.ITEM_CODE) = 1 THEN ACS.CUST_SITE_SHORT_NAME || ' �Ұ�'
               ELSE ACS.CUST_SITE_SHORT_NAME
             END AS CUST_SITE_NAME                              -- ����
           , IIM.ITEM_CODE                                      -- ��ǰ�ڵ�
           , IIM.ITEM_DESCRIPTION                               -- ��ǰ
											, IIM.ITEM_BRANCH_LCODE                              -- ��ǰ�� 
											, IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- ��ǰ����
           , TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE   -- �������
           , IIM.PRIMARY_UOM_CODE                               -- ��ǰUOM

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                      WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                 END) AS TRX_UOM_QTY                -- �����(UOM)
           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                      WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
                 END)  AS TRX_MM_QTY -- �����(MM)

           , ITS.CURRENCY_CODE                                  -- ��ȭ

           , CASE WHEN NVL(SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                           WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1) END), 0) > 0 THEN
                  ROUND(SUM(ITS.ITEM_AMOUNT)
                  / SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                             WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                        END), 4) ELSE -999 END AS ITEM_PRICE       -- ����ܰ�
           , SUM(ITS.ITEM_AMOUNT) AS ITEM_AMOUNT                -- ����ݾ�

           , CASE WHEN NVL(SUM(ITS.ITEM_AMOUNT), 0) > 0 THEN
                  ROUND(SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)
                  / SUM(ITS.ITEM_AMOUNT), 4) ELSE 0 END AS EXCHANGE_RATE
           , SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)  AS ITEM_AMOUNT_KRW  -- ����ݾ�(��ȭ)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_TRANSACTION_CLASS  ITC
           , INV_ITEM_MASTER        IIM   -- ��ǰ����
           , AR_CUSTOMER_SITE       ACS   -- ��������
           , INV_ITEM_SECTION       IIS   -- ��ǰ���и���
           , OE_SALES_ORDER_LINE    SOL   -- �����ֹ����γ���
           , WIP_JOB_ENTITIES       WJE   -- ���� LOT ���ó�
       WHERE ITT.TRANSACTION_TYPE_ID   = ITS.TRANSACTION_TYPE_ID
         AND ITC.TRANSACTION_CLASS_ID  = ITS.TRANSACTION_CLASS_ID
         AND IIM.INVENTORY_ITEM_ID     = ITS.INVENTORY_ITEM_ID
         AND ACS.CUST_SITE_ID(+)       = ITS.BILL_TO_CUST_SITE_ID
         AND IIS.SOB_ID(+)             = IIM.SOB_ID
         AND IIS.ORG_ID(+)             = IIM.ORG_ID
         AND IIS.ITEM_SECTION_CODE(+)  = IIM.ITEM_SECTION_CODE
         AND SOL.ORDER_LINE_ID(+)      = ITS.SALES_ORDER_LINE_ID
         AND WJE.JOB_ID(+)             = ITS.WIP_JOB_ID
         AND ITC.TRANSACTION_CLASS     = 'ISSUE'
         AND ITT.TRANSACTION_TYPE      IN ('TRANSFER_ISSUE', 'TRANSFER_RECEIPT')
         AND ITS.TRANSACTION_ALIAS     IN ('FG_PICK', 'FG_PICK_RETURN')
         AND TRUNC(ITS.TRANSACTION_DATE) BETWEEN W_TRANSACTION_DATE_FROM AND W_TRANSACTION_DATE_TO
         AND IIM.ITEM_NET_CODE         = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
         AND IIM.INVENTORY_ITEM_ID     = NVL(W_INVENTORY_ITEM_ID, IIM.INVENTORY_ITEM_ID)
         AND ACS.CUST_SITE_ID          = NVL(W_CUST_SITE_ID, ACS.CUST_SITE_ID)
         AND ITS.SOB_ID                = W_SOB_ID
         AND ITS.ORG_ID                = W_ORG_ID
         AND ITS.WAREHOUSE_ID          = NVL(W_WAREHOUSE_ID, ITS.WAREHOUSE_ID)
         AND ITS.LOCATION_ID           = NVL(W_WH_LOCATION_ID, ITS.LOCATION_ID)
      GROUP BY ROLLUP ((ACS.CUST_SITE_CODE
           , ACS.CUST_SITE_SHORT_NAME)
           ,(IIM.ITEM_CODE
           , IIM.ITEM_DESCRIPTION
											, IIM.ITEM_BRANCH_LCODE
           , IIS.DESCRIPTION
           , TRUNC(ITS.TRANSACTION_DATE)
           , IIM.PRIMARY_UOM_CODE
           , ITS.CURRENCY_CODE

           ))
         ;

  END ITEM_SUMMARY_1_SELECT;




-- ��ǰ�� ����(������ڼ�)
  PROCEDURE ITEM_SUMMARY_2_SELECT
            ( P_CURSOR       OUT TYPES.TCURSOR
            , W_TRANSACTION_DATE_FROM   IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_TRANSACTION_DATE_TO     IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_EXCHANGE_RATE_TYPE      IN VARCHAR2
            , W_CUST_SITE_ID            IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
            , W_ITEM_NET_CODE           IN INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
            , W_INVENTORY_ITEM_ID       IN INV_ITEM_MASTER.INVENTORY_ITEM_ID%TYPE
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , W_WAREHOUSE_ID            IN NUMBER
            , W_WH_LOCATION_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      -- ��ǰ������(������ڼ�)
      SELECT TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE         -- �������
           , ACS.CUST_SITE_CODE                                 -- �����ڵ�
           , CASE
                  WHEN GROUPING(TRUNC(ITS.TRANSACTION_DATE)) = 1 THEN '���հ�'
                  WHEN GROUPING(ACS.CUST_SITE_SHORT_NAME) = 1 THEN /*TO_CHAR(TRUNC(ITS.TRANSACTION_DATE), 'YYYY-MM-DD') ||*/ '�Ұ�'
                  ELSE ACS.CUST_SITE_SHORT_NAME
             END AS CUST_SITE_NAME                              -- ����
           , IIM.ITEM_CODE                                      -- ��ǰ�ڵ�
           , IIM.ITEM_DESCRIPTION                               -- ��ǰ
											, IIM.ITEM_BRANCH_LCODE                              -- ��ǰ�� 
           , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- ��ǰ����
           , IIM.PRIMARY_UOM_CODE                               -- ��ǰUOM
											
           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
             END) AS TRX_UOM_QTY                -- �����(UOM)

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
             END) AS TRX_MM_QTY -- �����(MM)

           , ITS.CURRENCY_CODE                                  -- ��ȭ

           , CASE WHEN NVL(SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                           WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1) END), 0) > 0 THEN 
                  ROUND(SUM(ITS.ITEM_AMOUNT)
                     / SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                       WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                  END),4) ELSE 0 END AS ITEM_PRICE              -- ����ܰ�

           , SUM(ITS.ITEM_AMOUNT) AS ITEM_AMOUNT                -- ����ݾ�

           , CASE WHEN NVL(SUM(ITS.ITEM_AMOUNT), 0) > 0 THEN
                  ROUND(SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)
                  / SUM(ITS.ITEM_AMOUNT),4) ELSE 0 END AS EXCHANGE_RATE
           , SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)  AS ITEM_AMOUNT_KRW  -- ����ݾ�(��ȭ)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_TRANSACTION_CLASS  ITC
           , INV_ITEM_MASTER        IIM   -- ��ǰ����
           , AR_CUSTOMER_SITE       ACS   -- ��������
           , INV_ITEM_SECTION       IIS   -- ��ǰ���и���
           , OE_SALES_ORDER_LINE    SOL   -- �����ֹ����γ���
           , WIP_JOB_ENTITIES       WJE   -- ���� LOT ���ó�
       WHERE ITT.TRANSACTION_TYPE_ID   = ITS.TRANSACTION_TYPE_ID
         AND ITC.TRANSACTION_CLASS_ID  = ITS.TRANSACTION_CLASS_ID
         AND IIM.INVENTORY_ITEM_ID     = ITS.INVENTORY_ITEM_ID
         AND ACS.CUST_SITE_ID(+)       = ITS.BILL_TO_CUST_SITE_ID
         AND IIS.SOB_ID(+)             = IIM.SOB_ID
         AND IIS.ORG_ID(+)             = IIM.ORG_ID
         AND IIS.ITEM_SECTION_CODE(+)  = IIM.ITEM_SECTION_CODE
         AND SOL.ORDER_LINE_ID(+)      = ITS.SALES_ORDER_LINE_ID
         AND WJE.JOB_ID(+)             = ITS.WIP_JOB_ID
         AND ITC.TRANSACTION_CLASS     = 'ISSUE'
         AND ITT.TRANSACTION_TYPE      IN ('TRANSFER_ISSUE', 'TRANSFER_RECEIPT')
         AND ITS.TRANSACTION_ALIAS     IN ('FG_PICK', 'FG_PICK_RETURN')
         AND ITS.TRANSACTION_DATE      BETWEEN W_TRANSACTION_DATE_FROM AND W_TRANSACTION_DATE_TO
         AND IIM.ITEM_NET_CODE         = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
         AND IIM.INVENTORY_ITEM_ID     = NVL(W_INVENTORY_ITEM_ID, IIM.INVENTORY_ITEM_ID)
         AND ACS.CUST_SITE_ID          = NVL(W_CUST_SITE_ID, ACS.CUST_SITE_ID)
         AND ITS.SOB_ID                = W_SOB_ID
         AND ITS.ORG_ID                = W_ORG_ID
         AND ITS.WAREHOUSE_ID          = NVL(W_WAREHOUSE_ID, ITS.WAREHOUSE_ID)
         AND ITS.LOCATION_ID           = NVL(W_WH_LOCATION_ID, ITS.LOCATION_ID)
       GROUP BY ROLLUP((TRUNC(ITS.TRANSACTION_DATE))  --�������
           , (ACS.CUST_SITE_CODE              --�����ڵ�
           , ACS.CUST_SITE_SHORT_NAME        --����
           , IIM.ITEM_CODE                   --��ǰ�ڵ�
           , IIM.ITEM_DESCRIPTION            --��ǰ
											, IIM.ITEM_BRANCH_LCODE           -- ��ǰ�� 
           , IIS.DESCRIPTION                 --��ǰ����
           , IIM.PRIMARY_UOM_CODE
           , ITS.CURRENCY_CODE

             ))
         ;

  END ITEM_SUMMARY_2_SELECT;

-- ��ǰ�� ��
  PROCEDURE ITEM_DETAIL_SELECT
            ( P_CURSOR       OUT TYPES.TCURSOR
            , W_TRANSACTION_DATE_FROM   IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_TRANSACTION_DATE_TO     IN INV_TRANSACTIONS.TRANSACTION_DATE%TYPE
            , W_EXCHANGE_RATE_TYPE      IN VARCHAR2
            , W_CUST_SITE_ID            IN AR_CUSTOMER_SITE.CUST_SITE_ID%TYPE
            , W_ITEM_NET_CODE           IN INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
            , W_INVENTORY_ITEM_ID       IN INV_ITEM_MASTER.INVENTORY_ITEM_ID%TYPE
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , W_WAREHOUSE_ID            IN NUMBER
            , W_WH_LOCATION_ID          IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT ACS.CUST_SITE_CODE                                 -- �����ڵ�
           , ACS.CUST_SITE_SHORT_NAME                           -- ����
           , IIM.ITEM_CODE                                      -- ��ǰ�ڵ�
           , IIM.ITEM_DESCRIPTION                               -- ��ǰ
											, IIM.ITEM_BRANCH_LCODE                              -- ��ǰ�� 
           , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- ��ǰ����
           , TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE   -- �������
           , SOL.ORDER_NO || '.' || SOL.ORDER_LINE_NO           -- ���ֶ��ι�ȣ
           , WJE.JOB_NO                                         -- ���� LOT NO
           , IIM.PRIMARY_UOM_CODE                               -- ��ǰUOM
           , CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
             END AS TRX_UOM_QTY                -- �����(UOM)
           , CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
             END  AS TRX_MM_QTY -- �����(MM)
           , ITS.CURRENCY_CODE                                  -- ��ȭ
           , ITS.ITEM_PRICE                                     -- ����ܰ�
           , ITS.ITEM_AMOUNT                                    -- ����ݾ�
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) AS EXCHANGE_RATE -- ����ȯ��
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT  AS ITEM_AMOUNT_KRW  -- ����ݾ�(��ȭ)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_TRANSACTION_CLASS  ITC
           , INV_ITEM_MASTER        IIM   -- ��ǰ����
           , AR_CUSTOMER_SITE       ACS   -- ��������
           , INV_ITEM_SECTION       IIS   -- ��ǰ���и���
           , OE_SALES_ORDER_LINE    SOL   -- �����ֹ����γ���
           , WIP_JOB_ENTITIES       WJE   -- ���� LOT ���ó�
       WHERE ITT.TRANSACTION_TYPE_ID   = ITS.TRANSACTION_TYPE_ID
         AND ITC.TRANSACTION_CLASS_ID  = ITS.TRANSACTION_CLASS_ID
         AND IIM.INVENTORY_ITEM_ID     = ITS.INVENTORY_ITEM_ID
         AND ACS.CUST_SITE_ID(+)       = ITS.BILL_TO_CUST_SITE_ID
         AND IIS.SOB_ID(+)             = IIM.SOB_ID
         AND IIS.ORG_ID(+)             = IIM.ORG_ID
         AND IIS.ITEM_SECTION_CODE(+)  = IIM.ITEM_SECTION_CODE
         AND SOL.ORDER_LINE_ID(+)      = ITS.SALES_ORDER_LINE_ID
         AND WJE.JOB_ID(+)             = ITS.WIP_JOB_ID
         AND ITC.TRANSACTION_CLASS     = 'ISSUE'
         AND ITT.TRANSACTION_TYPE      IN ('TRANSFER_ISSUE', 'TRANSFER_RECEIPT')
         AND ITS.TRANSACTION_ALIAS     IN ('FG_PICK', 'FG_PICK_RETURN')
         AND ITS.TRANSACTION_DATE      BETWEEN W_TRANSACTION_DATE_FROM AND W_TRANSACTION_DATE_TO
         AND IIM.ITEM_NET_CODE         = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
         AND IIM.INVENTORY_ITEM_ID     = NVL(W_INVENTORY_ITEM_ID, IIM.INVENTORY_ITEM_ID)
         AND ACS.CUST_SITE_ID          = NVL(W_CUST_SITE_ID, ACS.CUST_SITE_ID)
         AND ITS.SOB_ID                = W_SOB_ID
         AND ITS.ORG_ID                = W_ORG_ID
         AND ITS.WAREHOUSE_ID          = NVL(W_WAREHOUSE_ID, ITS.WAREHOUSE_ID)
         AND ITS.LOCATION_ID           = NVL(W_WH_LOCATION_ID, ITS.LOCATION_ID)
         ;

  END ITEM_DETAIL_SELECT;

END SOM_FG_TRANSFER_ISSUE_G; 
/