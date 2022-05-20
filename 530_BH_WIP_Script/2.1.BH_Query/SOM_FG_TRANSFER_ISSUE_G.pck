CREATE OR REPLACE PACKAGE SOM_FG_TRANSFER_ISSUE_G
IS

-- 제품별 집계(제품순)
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

-- 제품별 집계(출고일자순)
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

-- 제품별 상세
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
/* Description  : 제품출고 상세 내역 PACKAGE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 1-NOV-2010  Lee sun hee      Initialize
/* 11/03/12    Y.G Lee          Update(창고, 로케이션 검색조건)
/******************************************************************************/

-- 제품별 집계(제품순)
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
      SELECT ACS.CUST_SITE_CODE                                 -- 고객코드
           , CASE
               WHEN GROUPING(ACS.CUST_SITE_SHORT_NAME) = 1 THEN '총합계'
               WHEN GROUPING(IIM.ITEM_CODE) = 1 THEN ACS.CUST_SITE_SHORT_NAME || ' 소계'
               ELSE ACS.CUST_SITE_SHORT_NAME
             END AS CUST_SITE_NAME                              -- 고객
           , IIM.ITEM_CODE                                      -- 제품코드
           , IIM.ITEM_DESCRIPTION                               -- 제품
											, IIM.ITEM_BRANCH_LCODE                              -- 제품군 
											, IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- 제품구분
           , TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE   -- 출고일자
           , IIM.PRIMARY_UOM_CODE                               -- 제품UOM

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                      WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                 END) AS TRX_UOM_QTY                -- 출고량(UOM)
           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                      WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
                 END)  AS TRX_MM_QTY -- 출고량(MM)

           , ITS.CURRENCY_CODE                                  -- 통화

           , CASE WHEN NVL(SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                           WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1) END), 0) > 0 THEN
                  ROUND(SUM(ITS.ITEM_AMOUNT)
                  / SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                             WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                        END), 4) ELSE -999 END AS ITEM_PRICE       -- 출고단가
           , SUM(ITS.ITEM_AMOUNT) AS ITEM_AMOUNT                -- 출고금액

           , CASE WHEN NVL(SUM(ITS.ITEM_AMOUNT), 0) > 0 THEN
                  ROUND(SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)
                  / SUM(ITS.ITEM_AMOUNT), 4) ELSE 0 END AS EXCHANGE_RATE
           , SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)  AS ITEM_AMOUNT_KRW  -- 출고금액(원화)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_TRANSACTION_CLASS  ITC
           , INV_ITEM_MASTER        IIM   -- 제품마스
           , AR_CUSTOMER_SITE       ACS   -- 고객마스
           , INV_ITEM_SECTION       IIS   -- 제품구분마스
           , OE_SALES_ORDER_LINE    SOL   -- 고객주문라인내역
           , WIP_JOB_ENTITIES       WJE   -- 생산 LOT 지시내
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




-- 제품별 집계(출고일자순)
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
      -- 제품별집계(출고일자순)
      SELECT TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE         -- 출고일자
           , ACS.CUST_SITE_CODE                                 -- 고객코드
           , CASE
                  WHEN GROUPING(TRUNC(ITS.TRANSACTION_DATE)) = 1 THEN '총합계'
                  WHEN GROUPING(ACS.CUST_SITE_SHORT_NAME) = 1 THEN /*TO_CHAR(TRUNC(ITS.TRANSACTION_DATE), 'YYYY-MM-DD') ||*/ '소계'
                  ELSE ACS.CUST_SITE_SHORT_NAME
             END AS CUST_SITE_NAME                              -- 고객
           , IIM.ITEM_CODE                                      -- 제품코드
           , IIM.ITEM_DESCRIPTION                               -- 제품
											, IIM.ITEM_BRANCH_LCODE                              -- 제품군 
           , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- 제품구분
           , IIM.PRIMARY_UOM_CODE                               -- 제품UOM
											
           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
             END) AS TRX_UOM_QTY                -- 출고량(UOM)

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
             END) AS TRX_MM_QTY -- 출고량(MM)

           , ITS.CURRENCY_CODE                                  -- 통화

           , CASE WHEN NVL(SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                           WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1) END), 0) > 0 THEN 
                  ROUND(SUM(ITS.ITEM_AMOUNT)
                     / SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                       WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                  END),4) ELSE 0 END AS ITEM_PRICE              -- 출고단가

           , SUM(ITS.ITEM_AMOUNT) AS ITEM_AMOUNT                -- 출고금액

           , CASE WHEN NVL(SUM(ITS.ITEM_AMOUNT), 0) > 0 THEN
                  ROUND(SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)
                  / SUM(ITS.ITEM_AMOUNT),4) ELSE 0 END AS EXCHANGE_RATE
           , SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT)  AS ITEM_AMOUNT_KRW  -- 출고금액(원화)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_TRANSACTION_CLASS  ITC
           , INV_ITEM_MASTER        IIM   -- 제품마스
           , AR_CUSTOMER_SITE       ACS   -- 고객마스
           , INV_ITEM_SECTION       IIS   -- 제품구분마스
           , OE_SALES_ORDER_LINE    SOL   -- 고객주문라인내역
           , WIP_JOB_ENTITIES       WJE   -- 생산 LOT 지시내
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
       GROUP BY ROLLUP((TRUNC(ITS.TRANSACTION_DATE))  --출고일자
           , (ACS.CUST_SITE_CODE              --고객코드
           , ACS.CUST_SITE_SHORT_NAME        --고객
           , IIM.ITEM_CODE                   --제품코드
           , IIM.ITEM_DESCRIPTION            --제품
											, IIM.ITEM_BRANCH_LCODE           -- 제품군 
           , IIS.DESCRIPTION                 --제품구분
           , IIM.PRIMARY_UOM_CODE
           , ITS.CURRENCY_CODE

             ))
         ;

  END ITEM_SUMMARY_2_SELECT;

-- 제품별 상세
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
      SELECT ACS.CUST_SITE_CODE                                 -- 고객코드
           , ACS.CUST_SITE_SHORT_NAME                           -- 고객
           , IIM.ITEM_CODE                                      -- 제품코드
           , IIM.ITEM_DESCRIPTION                               -- 제품
											, IIM.ITEM_BRANCH_LCODE                              -- 제품군 
           , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- 제품구분
           , TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE   -- 출고일자
           , SOL.ORDER_NO || '.' || SOL.ORDER_LINE_NO           -- 수주라인번호
           , WJE.JOB_NO                                         -- 생산 LOT NO
           , IIM.PRIMARY_UOM_CODE                               -- 제품UOM
           , CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN ITS.TRANSACTION_QTY
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
             END AS TRX_UOM_QTY                -- 출고량(UOM)
           , CASE WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_ISSUE' AND ITS.TRANSACTION_ALIAS = 'FG_PICK' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                  WHEN ITT.TRANSACTION_TYPE = 'TRANSFER_RECEIPT' AND ITS.TRANSACTION_ALIAS = 'FG_PICK_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
             END  AS TRX_MM_QTY -- 출고량(MM)
           , ITS.CURRENCY_CODE                                  -- 통화
           , ITS.ITEM_PRICE                                     -- 출고단가
           , ITS.ITEM_AMOUNT                                    -- 출고금액
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) AS EXCHANGE_RATE -- 적용환율
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT  AS ITEM_AMOUNT_KRW  -- 출고금액(원화)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_TRANSACTION_CLASS  ITC
           , INV_ITEM_MASTER        IIM   -- 제품마스
           , AR_CUSTOMER_SITE       ACS   -- 고객마스
           , INV_ITEM_SECTION       IIS   -- 제품구분마스
           , OE_SALES_ORDER_LINE    SOL   -- 고객주문라인내역
           , WIP_JOB_ENTITIES       WJE   -- 생산 LOT 지시내
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
