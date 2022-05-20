CREATE OR REPLACE PACKAGE INV_FG_MISC_LIST_G AS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : INV
/* Program Name : INV_FG_MISC_LIST_G
/* Description  : INVENTORY ITEM MISC TRANSACTION LIST
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-DEC-2010  Jun Won Tai       Initialize
/******************************************************************************/

----------------------------------------
-- FG ISSUE Line 조회
----------------------------------------
  PROCEDURE MISC_RECEIPT_SELECT ( P_CURSOR            OUT      TYPES.TCURSOR
                                , W_SOB_ID             IN      INV_FG_MISC_RECEIPT_HEADER.SOB_ID%TYPE
                                , W_ORG_ID             IN      INV_FG_MISC_RECEIPT_HEADER.ORG_ID%TYPE
                                , W_RECEIPT_DATE_FR    IN      INV_FG_MISC_RECEIPT_HEADER.RECEIPT_DATE%TYPE
                                , W_RECEIPT_DATE_TO    IN      INV_FG_MISC_RECEIPT_HEADER.RECEIPT_DATE%TYPE
                                , W_CUST_ID            IN      INV_FG_MISC_RECEIPT_LINE.BILL_TO_CUST_SITE_ID%TYPE
                                , W_MISC_TRX_TYPE_CODE IN      INV_FG_MISC_RECEIPT_HEADER.MISC_TRX_TYPE_CODE%TYPE
                                , W_ITEM_NET_CODE      IN      INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
                                , W_INVENTORY_ITEM_ID  IN      INV_FG_MISC_RECEIPT_LINE.INVENTORY_ITEM_ID%TYPE
                                , W_EXCHANGE_RATE_TYPE IN      VARCHAR2);

  PROCEDURE MISC_ISSUE_SELECT ( P_CURSOR            OUT      TYPES.TCURSOR
                              , W_SOB_ID             IN      INV_FG_MISC_ISSUE_HEADER.SOB_ID%TYPE
                              , W_ORG_ID             IN      INV_FG_MISC_ISSUE_HEADER.ORG_ID%TYPE
                              , W_ISSUE_DATE_FR      IN      INV_FG_MISC_ISSUE_HEADER.ISSUE_DATE%TYPE
                              , W_ISSUE_DATE_TO      IN      INV_FG_MISC_ISSUE_HEADER.ISSUE_DATE%TYPE
                              , W_CUST_ID            IN      INV_FG_MISC_ISSUE_LINE.BILL_TO_CUST_SITE_ID%TYPE
                              , W_MISC_TRX_TYPE_CODE IN      INV_FG_MISC_ISSUE_HEADER.MISC_TRX_TYPE_CODE%TYPE
                              , W_ITEM_NET_CODE      IN      INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
                              , W_INVENTORY_ITEM_ID  IN      INV_FG_MISC_ISSUE_LINE.INVENTORY_ITEM_ID%TYPE)    ;

END INV_FG_MISC_LIST_G; 
/
CREATE OR REPLACE PACKAGE BODY INV_FG_MISC_LIST_G AS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : INV
/* Program Name : INV_FG_MISC_LIST_G
/* Description  : INVENTORY ITEM MISC TRANSACTION LIST
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-DEC-2010  Jun Won Tai       Initialize
/******************************************************************************/

----------------------------------------
-- FG RECEIPT TRANSACTION 조회
----------------------------------------
  PROCEDURE MISC_RECEIPT_SELECT ( P_CURSOR            OUT      TYPES.TCURSOR
                                , W_SOB_ID             IN      INV_FG_MISC_RECEIPT_HEADER.SOB_ID%TYPE
                                , W_ORG_ID             IN      INV_FG_MISC_RECEIPT_HEADER.ORG_ID%TYPE
                                , W_RECEIPT_DATE_FR    IN      INV_FG_MISC_RECEIPT_HEADER.RECEIPT_DATE%TYPE
                                , W_RECEIPT_DATE_TO    IN      INV_FG_MISC_RECEIPT_HEADER.RECEIPT_DATE%TYPE
                                , W_CUST_ID            IN      INV_FG_MISC_RECEIPT_LINE.BILL_TO_CUST_SITE_ID%TYPE
                                , W_MISC_TRX_TYPE_CODE IN      INV_FG_MISC_RECEIPT_HEADER.MISC_TRX_TYPE_CODE%TYPE
                                , W_ITEM_NET_CODE      IN      INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
                                , W_INVENTORY_ITEM_ID  IN      INV_FG_MISC_RECEIPT_LINE.INVENTORY_ITEM_ID%TYPE
                                , W_EXCHANGE_RATE_TYPE IN      VARCHAR2)
  IS

  BEGIN
    OPEN P_CURSOR FOR
      SELECT  IFRH.RECEIPT_NO
           , IFRH.RECEIPT_DATE
           , IWT.WAREHOUSE_CODE
           , IWT.WAREHOUSE_NAME
           , IWLT.LOCATION_CODE
           , IWLT.LOCATION_NAME
           , IFRH.MISC_TRX_TYPE_CODE
           , (SELECT ITT.DESCRIPTION
                FROM INV_TRANSACTION_TYPE_TLV ITT
               WHERE ITT.TRANSACTION_TYPE = IFRH.MISC_TRX_TYPE_CODE
                 AND ITT.SOB_ID = IFRH.SOB_ID
                 AND ITT.ORG_ID = IFRH.ORG_ID) AS MISC_TRX_TYPE_NAME
           , IIMT.ITEM_CODE
           , IIMT.ITEM_DESCRIPTION
           , IFRL.UOM_CODE
           , IFRL.RECEIPT_QTY
           , IFRL.CURRENCY_CODE
           , IFRL.RECEIPT_UNIT_PRICE
           , IFRL.RECEIPT_AMOUNT
           , DECODE( IFRL.RECEIPT_AMOUNT, 0, 0, ROUND(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(W_SOB_ID, W_ORG_ID, NVL(IFRL.CURRENCY_CODE, 'KRW'), W_EXCHANGE_RATE_TYPE, IFRH.RECEIPT_DATE) * IFRL.RECEIPT_AMOUNT
                                                / IFRL.RECEIPT_AMOUNT, 4) ) AS EXCHANGE_RATE
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(W_SOB_ID, W_ORG_ID, NVL(IFRL.CURRENCY_CODE, 'KRW'), W_EXCHANGE_RATE_TYPE, IFRH.RECEIPT_DATE) * IFRL.RECEIPT_AMOUNT AS RECEIPT_AMOUNT_KRW  -- 입고금액(원화)
           , ACS.CUST_SITE_SHORT_NAME
           , SIR.BOM_ITEM_CODE
           , OSOH.ORDER_NO
           , WJE.JOB_NO
        FROM INV_FG_MISC_RECEIPT_HEADER  IFRH
           , INV_WAREHOUSE_TLV           IWT
           , INV_WH_LOCATION_TLV         IWLT
           , INV_FG_MISC_RECEIPT_LINE    IFRL
           , INV_ITEM_MASTER_TLV         IIMT
           , WIP_JOB_ENTITIES            WJE
           , SDM_ITEM_REVISION           SIR
           , OE_SALES_ORDER_HEADER       OSOH
           , AR_CUSTOMER_SITE            ACS
       WHERE IFRH.SOB_ID               = W_SOB_ID
         AND IFRH.ORG_ID               = W_ORG_ID
         AND IFRH.RECEIPT_HEADER_ID    = IFRL.RECEIPT_HEADER_ID
         AND IFRH.SOB_ID               = IFRL.SOB_ID
         AND IFRH.ORG_ID               = IFRL.ORG_ID
         AND IFRH.RECEIPT_WAREHOUSE_ID = IWT.WAREHOUSE_ID
         AND IFRH.RECEIPT_LOCATION_ID  = IWLT.WH_LOCATION_ID
         AND IFRL.INVENTORY_ITEM_ID    = IIMT.INVENTORY_ITEM_ID
         AND IFRL.WIP_JOB_ID           = WJE.JOB_ID(+)
         AND IFRL.BOM_ITEM_ID          = SIR.BOM_ITEM_ID(+)
         AND IFRL.ORDER_HEADER_ID      = OSOH.ORDER_HEADER_ID(+)
         AND IFRL.BILL_TO_CUST_SITE_ID = ACS.CUST_SITE_ID(+)
         AND TRUNC(IFRH.RECEIPT_DATE) BETWEEN W_RECEIPT_DATE_FR
                                          AND W_RECEIPT_DATE_TO
         AND IFRH.MISC_TRX_TYPE_CODE   = NVL(W_MISC_TRX_TYPE_CODE, IFRH.MISC_TRX_TYPE_CODE)
         AND IIMT.ITEM_NET_CODE        = NVL(W_ITEM_NET_CODE, IIMT.ITEM_NET_CODE)
         AND IFRL.INVENTORY_ITEM_ID    = NVL(W_INVENTORY_ITEM_ID, IFRL.INVENTORY_ITEM_ID)
         AND IFRL.BILL_TO_CUST_SITE_ID = NVL(W_CUST_ID, IFRL.BILL_TO_CUST_SITE_ID);

  END;

----------------------------------------
-- FG ISSUE TRANSACTION 조회
----------------------------------------
  PROCEDURE MISC_ISSUE_SELECT ( P_CURSOR            OUT      TYPES.TCURSOR
                              , W_SOB_ID             IN      INV_FG_MISC_ISSUE_HEADER.SOB_ID%TYPE
                              , W_ORG_ID             IN      INV_FG_MISC_ISSUE_HEADER.ORG_ID%TYPE
                              , W_ISSUE_DATE_FR      IN      INV_FG_MISC_ISSUE_HEADER.ISSUE_DATE%TYPE
                              , W_ISSUE_DATE_TO      IN      INV_FG_MISC_ISSUE_HEADER.ISSUE_DATE%TYPE
                              , W_CUST_ID            IN      INV_FG_MISC_ISSUE_LINE.BILL_TO_CUST_SITE_ID%TYPE
                              , W_MISC_TRX_TYPE_CODE IN      INV_FG_MISC_ISSUE_HEADER.MISC_TRX_TYPE_CODE%TYPE
                              , W_ITEM_NET_CODE      IN      INV_ITEM_MASTER.ITEM_NET_CODE%TYPE
                              , W_INVENTORY_ITEM_ID  IN      INV_FG_MISC_ISSUE_LINE.INVENTORY_ITEM_ID%TYPE)
  IS

  BEGIN
    OPEN P_CURSOR FOR
      SELECT IFRH.ISSUE_NO
           , IFRH.ISSUE_DATE
           , IWT.WAREHOUSE_CODE
           , IWT.WAREHOUSE_NAME
           , IWLT.LOCATION_CODE
           , IWLT.LOCATION_NAME
           , IFRH.MISC_TRX_TYPE_CODE
           , (SELECT ITT.DESCRIPTION
                FROM INV_TRANSACTION_TYPE_TLV ITT
               WHERE ITT.TRANSACTION_TYPE = IFRH.MISC_TRX_TYPE_CODE
                 AND ITT.SOB_ID = IFRH.SOB_ID
                 AND ITT.ORG_ID = IFRH.ORG_ID) AS MISC_TRX_TYPE_NAME
           , IIMT.ITEM_CODE
           , IIMT.ITEM_DESCRIPTION
           , IFRL.UOM_CODE
           , IFRL.PACKING_BOX_NO
           , OSOH.ORDER_NO
           , IFRL.ISSUE_QTY
           , WJE.JOB_NO
           , ACS.CUST_SITE_SHORT_NAME
        FROM INV_FG_MISC_ISSUE_HEADER  IFRH
           , INV_WAREHOUSE_TLV         IWT
           , INV_WH_LOCATION_TLV       IWLT
           , INV_FG_MISC_ISSUE_LINE    IFRL
           , INV_ITEM_MASTER_TLV       IIMT
           , WIP_JOB_ENTITIES          WJE
           , SDM_ITEM_REVISION         SIR
           , OE_SALES_ORDER_HEADER     OSOH
           , AR_CUSTOMER_SITE          ACS
       WHERE IFRH.SOB_ID               = W_SOB_ID
         AND IFRH.ORG_ID               = W_ORG_ID
         AND IFRH.ISSUE_HEADER_ID      = IFRL.ISSUE_HEADER_ID
         AND IFRH.SOB_ID               = IFRL.SOB_ID
         AND IFRH.ORG_ID               = IFRL.ORG_ID
         AND IFRH.ISSUE_WAREHOUSE_ID   = IWT.WAREHOUSE_ID
         AND IFRH.ISSUE_LOCATION_ID    = IWLT.WH_LOCATION_ID
         AND IFRL.INVENTORY_ITEM_ID    = IIMT.INVENTORY_ITEM_ID
         AND IFRL.WIP_JOB_ID           = WJE.JOB_ID(+)
         AND IFRL.BOM_ITEM_ID          = SIR.BOM_ITEM_ID(+)
         AND IFRL.ORDER_HEADER_ID      = OSOH.ORDER_HEADER_ID(+)
         AND IFRL.BILL_TO_CUST_SITE_ID = ACS.CUST_SITE_ID(+)
         AND TRUNC(IFRH.ISSUE_DATE) BETWEEN W_ISSUE_DATE_FR
                                        AND W_ISSUE_DATE_TO
         AND IFRH.MISC_TRX_TYPE_CODE   = NVL(W_MISC_TRX_TYPE_CODE, IFRH.MISC_TRX_TYPE_CODE)
         AND IIMT.ITEM_NET_CODE        = NVL(W_ITEM_NET_CODE, IIMT.ITEM_NET_CODE)
         AND IFRL.INVENTORY_ITEM_ID    = NVL(W_INVENTORY_ITEM_ID, IFRL.INVENTORY_ITEM_ID)
         AND IFRL.BILL_TO_CUST_SITE_ID = NVL(W_CUST_ID, IFRL.BILL_TO_CUST_SITE_ID);
  END;

END INV_FG_MISC_LIST_G; 
/
