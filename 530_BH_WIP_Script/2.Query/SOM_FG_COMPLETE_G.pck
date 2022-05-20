CREATE OR REPLACE PACKAGE SOM_FG_COMPLETE_G
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
            );

-- 제품별 집계(입고일자순)
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
            );
            
END SOM_FG_COMPLETE_G;

 
/
CREATE OR REPLACE PACKAGE BODY SOM_FG_COMPLETE_G
IS
/******************************************************************************/
/* Project      : FLEX ERP
/* Module       : EAPP
/* Program Name : SOM_FG_COMPLETE_G
/* Description  : 제품입고 상세 내역 PACKAGE.
/*
/* Reference by :
/* Program History
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 29-OCT-2010  Lee sun hee      Initialize
/* 19-APR-2011  Shin Man Jae     Transaction_Date --> Extend_Date로 변경
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
            )
  AS
     V_START_DATE    DATE;
     V_END_DATE      DATE;
  BEGIN
    
    V_START_DATE := TO_DATE(TO_CHAR(W_TRANSACTION_DATE_FROM  , 'YYYY-MM-DD') || ' 08:30:00', 'YYYY-MM-DD HH24:MI:SS');
    V_END_DATE   := TO_DATE(TO_CHAR(W_TRANSACTION_DATE_TO + 1, 'YYYY-MM-DD') || ' 08:29:59', 'YYYY-MM-DD HH24:MI:SS');
  
    OPEN P_CURSOR FOR
      SELECT ACS.CUST_SITE_CODE                                 -- 고객코드
           , CASE
               WHEN GROUPING(ACS.CUST_SITE_SHORT_NAME) = 1 THEN '총합계'
               WHEN GROUPING(IIM.ITEM_CODE) = 1 THEN ACS.CUST_SITE_SHORT_NAME || ' 소계'
               ELSE ACS.CUST_SITE_SHORT_NAME
             END AS CUST_SITE_NAME                              -- 고객
           , IIM.ITEM_CODE                                      -- 제품코드
           , IIM.ITEM_DESCRIPTION                               -- 제품
					 , IIM.ITEM_BRANCH_LCODE
           , ELE.ENTRY_DESCRIPTION
					 , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- 제품구분
           --, TRUNC(ITS.TRANSACTION_DATE)  AS TRANSACTION_DATE   -- 입고일자
           , TRUNC(ITS.EXTEND_DATE)  AS TRANSACTION_DATE   -- 입고일자
           , IIM.PRIMARY_UOM_CODE                               -- 제품UOM

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN ITS.TRANSACTION_QTY
                      WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                 END) AS TRX_UOM_QTY                -- 입고량(UOM)
           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                      WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
                 END)  AS TRX_MM_QTY -- 입고량(MM)

           , ITS.CURRENCY_CODE                                  -- 통화

           , ROUND(SUM(ITS.ITEM_AMOUNT)
             / SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN ITS.TRANSACTION_QTY
                        WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                   END), 4) AS ITEM_PRICE                 -- 입고단가
           , SUM(ITS.ITEM_AMOUNT) AS ITEM_AMOUNT                -- 입고금액

           , ROUND(SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.EXTEND_DATE) * ITS.ITEM_AMOUNT)
             / DECODE(SUM(NVL(ITS.ITEM_AMOUNT,0)),0,1,SUM(NVL(ITS.ITEM_AMOUNT,0))), 4) AS EXCHANGE_RATE
           , SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.EXTEND_DATE) * ITS.ITEM_AMOUNT)  AS ITEM_AMOUNT_KRW  -- 입고금액(원화)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_ITEM_MASTER        IIM   -- 제품마스
           , AR_CUSTOMER_SITE       ACS   -- 고객마스
           , INV_ITEM_SECTION       IIS   -- 제품구분마스
           , OE_SALES_ORDER_LINE    SOL   -- 고객주문라인내역
           , WIP_JOB_ENTITIES       WJE   -- 생산 LOT 지시내
					 , WIP_WORK_ORDER         WWO 
					 , EAPP_LOOKUP_ENTRY      ELE  
											
       WHERE ITT.TRANSACTION_TYPE_ID   = ITS.TRANSACTION_TYPE_ID
         AND IIM.INVENTORY_ITEM_ID     = ITS.INVENTORY_ITEM_ID
         AND IIM.ITEM_CATEGORY_CODE    = 'FG'
         AND ACS.CUST_SITE_ID(+)       = IIM.CUSTOMER_SITE_ID
         AND IIS.SOB_ID(+)             = IIM.SOB_ID
         AND IIS.ORG_ID(+)             = IIM.ORG_ID
         AND IIS.ITEM_SECTION_CODE(+)  = IIM.ITEM_SECTION_CODE
         AND SOL.ORDER_LINE_ID(+)      = ITS.SALES_ORDER_LINE_ID
         AND WJE.JOB_ID(+)             = ITS.WIP_JOB_ID
				 AND WWO.WORK_ORDER_ID         = WJE.WORK_ORDER_ID
         AND ELE.SOB_ID(+)             = WWO.SOB_ID
         AND ELE.ORG_ID(+)             = WWO.ORG_ID
         AND ELE.ENTRY_CODE(+)         = WWO.WORK_COMMENT_LCODE
				 AND ELE.LOOKUP_TYPE(+)        = 'WORK_COMMENT'
         AND ITT.TRANSACTION_TYPE      IN ('WIP_COMPLETE', 'WIP_COMPLETE_RETURN')
/*         AND ITT.TRANSACTION_TYPE      IN ('TRANSFER_RECEIPT')
         AND ITS.TRANSACTION_ALIAS     IN ('FG_STORE')*/
         AND ITS.TRANSACTION_DATE      BETWEEN V_START_DATE AND V_END_DATE
         AND IIM.INVENTORY_ITEM_ID     = NVL(W_INVENTORY_ITEM_ID, IIM.INVENTORY_ITEM_ID)
         AND IIM.CUSTOMER_SITE_ID      = NVL(W_CUST_SITE_ID, IIM.CUSTOMER_SITE_ID)
         AND IIM.ITEM_NET_CODE         = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
         AND ITS.SOB_ID                = W_SOB_ID
         AND ITS.ORG_ID                = W_ORG_ID
      GROUP BY ROLLUP ((ACS.CUST_SITE_CODE
           , ACS.CUST_SITE_SHORT_NAME)
           ,(IIM.ITEM_CODE
           , IIM.ITEM_DESCRIPTION
					 , IIM.ITEM_BRANCH_LCODE
           , ELE.ENTRY_DESCRIPTION
					 , IIS.DESCRIPTION
           , TRUNC(ITS.EXTEND_DATE)
           , IIM.PRIMARY_UOM_CODE
           , ITS.CURRENCY_CODE

           ))
         ;

  END ITEM_SUMMARY_1_SELECT;




-- 제품별 집계(입고일자순)
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
            )
  AS
  
    V_START_DATE    DATE;
    V_END_DATE      DATE;
  BEGIN
     
    V_START_DATE := TO_DATE(TO_CHAR(W_TRANSACTION_DATE_FROM  , 'YYYY-MM-DD') || ' 08:30:00', 'YYYY-MM-DD HH24:MI:SS');
    V_END_DATE   := TO_DATE(TO_CHAR(W_TRANSACTION_DATE_TO + 1, 'YYYY-MM-DD') || ' 08:29:59', 'YYYY-MM-DD HH24:MI:SS');
    
    -- 제품별집계(입고일자순)--
    OPEN P_CURSOR FOR
      SELECT TRUNC(ITS.EXTEND_DATE)  AS TRANSACTION_DATE         -- 입고일자
           , ACS.CUST_SITE_CODE                                 -- 고객코드
           , CASE
                  WHEN GROUPING(TRUNC(ITS.EXTEND_DATE)) = 1 THEN '총합계'
                  WHEN GROUPING(ACS.CUST_SITE_SHORT_NAME) = 1 THEN /*TO_CHAR(TRUNC(ITS.TRANSACTION_DATE), 'YYYY-MM-DD') ||*/ '소계'
                  ELSE ACS.CUST_SITE_SHORT_NAME
             END AS CUST_SITE_NAME                              -- 고객
           , IIM.ITEM_CODE                                      -- 제품코드
           , IIM.ITEM_DESCRIPTION                               -- 제품
					 , IIM.ITEM_BRANCH_LCODE
           , ELE.ENTRY_DESCRIPTION
           , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- 제품구분
           , IIM.PRIMARY_UOM_CODE                               -- 제품UOM

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN ITS.TRANSACTION_QTY
                  WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
             END) AS TRX_UOM_QTY                -- 입고량(UOM)

           , SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                  WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
             END) AS TRX_MM_QTY -- 입고량(MM)

           , ITS.CURRENCY_CODE                                  -- 통화

           , ROUND(SUM(ITS.ITEM_AMOUNT)
                / SUM(CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN ITS.TRANSACTION_QTY
                           WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
                      END),4) AS ITEM_PRICE                                 -- 입고단가

           , SUM(ITS.ITEM_AMOUNT) AS ITEM_AMOUNT                -- 입고금액

           , ROUND(SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.EXTEND_DATE) * ITS.ITEM_AMOUNT)
             / DECODE(SUM(NVL(ITS.ITEM_AMOUNT,0)),0,1,SUM(NVL(ITS.ITEM_AMOUNT,0))), 4) AS EXCHANGE_RATE
           , SUM(EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.EXTEND_DATE) * ITS.ITEM_AMOUNT)  AS ITEM_AMOUNT_KRW  -- 입고금액(원화)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE
           , INV_ITEM_MASTER        IIM   -- 제품마스
           , AR_CUSTOMER_SITE       ACS   -- 고객마스
           , INV_ITEM_SECTION       IIS   -- 제품구분마스
           , OE_SALES_ORDER_LINE    SOL   -- 고객주문라인내역
           , WIP_JOB_ENTITIES       WJE   -- 생산 LOT 지시내
					 , WIP_WORK_ORDER         WWO 
					 , EAPP_LOOKUP_ENTRY      ELE  
											
       WHERE ITT.TRANSACTION_TYPE_ID   = ITS.TRANSACTION_TYPE_ID
         AND IIM.INVENTORY_ITEM_ID     = ITS.INVENTORY_ITEM_ID
         AND IIM.ITEM_CATEGORY_CODE    = 'FG'
         AND ACS.CUST_SITE_ID(+)       = IIM.CUSTOMER_SITE_ID   --ITS.BILL_TO_CUST_SITE_ID
         AND IIS.SOB_ID(+)             = IIM.SOB_ID
         AND IIS.ORG_ID(+)             = IIM.ORG_ID
         AND IIS.ITEM_SECTION_CODE(+)  = IIM.ITEM_SECTION_CODE
         AND SOL.ORDER_LINE_ID(+)      = ITS.SALES_ORDER_LINE_ID
         AND WJE.JOB_ID(+)             = ITS.WIP_JOB_ID
				 AND WWO.WORK_ORDER_ID         = WJE.WORK_ORDER_ID
         AND ELE.SOB_ID(+)             = W_SOB_ID
         AND ELE.ORG_ID(+)             = W_ORG_ID
         AND ELE.ENTRY_CODE(+)         = WWO.WORK_COMMENT_LCODE
				 AND ELE.LOOKUP_TYPE(+)        = 'WORK_COMMENT'
         AND ITT.TRANSACTION_TYPE      IN ('WIP_COMPLETE', 'WIP_COMPLETE_RETURN')
         AND ITS.TRANSACTION_DATE      BETWEEN V_START_DATE AND V_END_DATE
         AND IIM.INVENTORY_ITEM_ID     = NVL(W_INVENTORY_ITEM_ID, IIM.INVENTORY_ITEM_ID)
         AND IIM.CUSTOMER_SITE_ID      = NVL(W_CUST_SITE_ID, IIM.CUSTOMER_SITE_ID)
         AND IIM.ITEM_NET_CODE         = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
         AND ITS.SOB_ID                = W_SOB_ID
         AND ITS.ORG_ID                = W_ORG_ID
       GROUP BY ROLLUP((TRUNC(ITS.EXTEND_DATE))  --입고일자
           , (ACS.CUST_SITE_CODE              --고객코드
           , ACS.CUST_SITE_SHORT_NAME        --고객
           , IIM.ITEM_CODE                   --제품코드
           , IIM.ITEM_DESCRIPTION            --제품
					 , IIM.ITEM_BRANCH_LCODE
           , ELE.ENTRY_DESCRIPTION
           , IIS.DESCRIPTION                 --제품구분
           , IIM.PRIMARY_UOM_CODE
           , ITS.CURRENCY_CODE

             ))
         ;

  END ITEM_SUMMARY_2_SELECT;

-- 제품별 
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
            )
  AS
     V_START_DATE    DATE;
     V_END_DATE      DATE;
  BEGIN
    
    V_START_DATE := TO_DATE(TO_CHAR(W_TRANSACTION_DATE_FROM  , 'YYYY-MM-DD') || ' 08:30:00', 'YYYY-MM-DD HH24:MI:SS');
    V_END_DATE   := TO_DATE(TO_CHAR(W_TRANSACTION_DATE_TO + 1, 'YYYY-MM-DD') || ' 08:29:59', 'YYYY-MM-DD HH24:MI:SS');
    
    OPEN P_CURSOR FOR
      SELECT ACS.CUST_SITE_CODE                                 -- 고객코드
           , ACS.CUST_SITE_SHORT_NAME                           -- 고객
           , IIM.ITEM_CODE                                      -- 제품코드
           , IIM.ITEM_DESCRIPTION                               -- 제품
					 , IIM.ITEM_BRANCH_LCODE
           , ELE.ENTRY_DESCRIPTION
											
           , IIS.DESCRIPTION              AS ITEM_SECTION_DESC  -- 제품구분
           , ITS.TRANSACTION_DATE         AS TRANSACTION_DATE   -- 입고일자
           , SOL.ORDER_NO || '.' || SOL.ORDER_LINE_NO           -- 수주라인번호
           , WJE.JOB_NO                                         -- 생산 LOT NO
           , IIM.PRIMARY_UOM_CODE                               -- 제품UOM
           , CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN ITS.TRANSACTION_QTY
                  WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN ITS.TRANSACTION_QTY * (-1)
             END AS TRX_UOM_QTY                -- 입고량(UOM)
           , CASE WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE'        THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY)
                  WHEN ITT.TRANSACTION_TYPE = 'WIP_COMPLETE_RETURN' THEN EAPP_COMMON_G.GET_MM_FROM_UOM_F(ITS.INVENTORY_ITEM_ID,NULL,ITS.TRANSACTION_QTY) * (-1)
             END  AS TRX_MM_QTY -- 입고량(MM)
           , ITS.CURRENCY_CODE                                  -- 통화
           , ITS.ITEM_PRICE                                     -- 입고단가
           , ITS.ITEM_AMOUNT                                    -- 입고금액
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) AS EXCHANGE_RATE -- 적용환율
           , EAPP_COMMON_G.GET_APPLY_EXCHANGE_RATE_F(ITS.SOB_ID, ITS.ORG_ID, NVL(ITS.CURRENCY_CODE,'KRW'), W_EXCHANGE_RATE_TYPE, ITS.TRANSACTION_DATE) * ITS.ITEM_AMOUNT  AS ITEM_AMOUNT_KRW  -- 입고금액(원화)
        FROM INV_TRANSACTIONS       ITS   -- INVENTRY TRANSACTION --
           , INV_TRANSACTION_TYPE   ITT   -- TRANSACTION TYPE     --
           , INV_ITEM_MASTER        IIM   -- 제품마스             --
           , AR_CUSTOMER_SITE       ACS   -- 고객마스             --
           , INV_ITEM_SECTION       IIS   -- 제품구분마스         --
           , OE_SALES_ORDER_LINE    SOL   -- 고객주문라인내역     --
           , WIP_JOB_ENTITIES       WJE   -- 생산 LOT 지시내      --
					 , WIP_WORK_ORDER         WWO 
					 , EAPP_LOOKUP_ENTRY      ELE 
											
       WHERE ITT.TRANSACTION_TYPE_ID   = ITS.TRANSACTION_TYPE_ID
         AND IIM.INVENTORY_ITEM_ID     = ITS.INVENTORY_ITEM_ID
         AND IIM.ITEM_CATEGORY_CODE    = 'FG'
         AND ACS.CUST_SITE_ID(+)       = IIM.CUSTOMER_SITE_ID
         AND IIS.SOB_ID(+)             = IIM.SOB_ID
         AND IIS.ORG_ID(+)             = IIM.ORG_ID
         AND IIS.ITEM_SECTION_CODE(+)  = IIM.ITEM_SECTION_CODE
         AND SOL.ORDER_LINE_ID(+)      = ITS.SALES_ORDER_LINE_ID
         AND WJE.JOB_ID(+)             = ITS.WIP_JOB_ID
				 AND WWO.WORK_ORDER_ID         = WJE.WORK_ORDER_ID
         AND ELE.SOB_ID(+)             = WWO.SOB_ID
         AND ELE.ORG_ID(+)             = WWO.ORG_ID
         AND ELE.ENTRY_CODE(+)         = WWO.WORK_COMMENT_LCODE
				 AND ELE.LOOKUP_TYPE(+)        = 'WORK_COMMENT'
         AND ITT.TRANSACTION_TYPE      IN ('WIP_COMPLETE', 'WIP_COMPLETE_RETURN')
         AND ITS.TRANSACTION_DATE      BETWEEN V_START_DATE AND V_END_DATE
         AND IIM.INVENTORY_ITEM_ID     = NVL(W_INVENTORY_ITEM_ID, IIM.INVENTORY_ITEM_ID)
         AND IIM.CUSTOMER_SITE_ID      = NVL(W_CUST_SITE_ID, IIM.CUSTOMER_SITE_ID)
         AND IIM.ITEM_NET_CODE         = NVL(W_ITEM_NET_CODE, IIM.ITEM_NET_CODE)
         AND ITS.SOB_ID                = W_SOB_ID
         AND ITS.ORG_ID                = W_ORG_ID
         ;

  END ITEM_DETAIL_SELECT;

END SOM_FG_COMPLETE_G; 
/
