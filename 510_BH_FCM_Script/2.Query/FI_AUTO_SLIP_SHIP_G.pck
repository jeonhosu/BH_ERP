CREATE OR REPLACE PACKAGE FI_AUTO_SLIP_SHIP_G AS
/******************************************************************************
   NAME:       FI_AUTO_SLIP_SHIP_G
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2011-09-28           1. Created this package.
******************************************************************************/

----------------------------------------
-- 매출 자동 전표 대상 조회(집계)
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_T_SELECT ( P_CURSOR                OUT     TYPES.TCURSOR
                                       , W_SOB_ID                IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                       , W_ORG_ID                IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                       , W_PERIOD_NAME           IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                       , W_BILL_TO_CUST_SITE_ID  IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE );
                                                                              
----------------------------------------
-- 매출 자동 전표 대상 조회(세부)
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_D_SELECT ( P_CURSOR                OUT     TYPES.TCURSOR
                                       , W_SOB_ID                IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                       , W_ORG_ID                IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                       , W_PERIOD_NAME           IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                       , W_BILL_TO_CUST_SITE_ID  IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE
                                       , W_JOB_CATEGORY_CD       IN      FI_AUTO_JOURNAL_MST.JOB_CATEGORY_CD%TYPE );                                  
                                      
----------------------------------------
-- 매출 자동 전표 전송 내역  조회
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_S_SELECT ( P_CURSOR                OUT     TYPES.TCURSOR
                                       , W_SOB_ID                IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                       , W_ORG_ID                IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                       , W_PERIOD_NAME           IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                       , W_BILL_TO_CUST_SITE_ID  IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE );
                                      
----------------------------------------
-- 매출 자동 전표 대상 설정 (Interface Flag 'S' 처리)
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_TARGET ( W_SOB_ID                  IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                     , W_ORG_ID                  IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                     , W_PERIOD_NAME             IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                     , W_BILL_TO_CUST_SITE_ID    IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE
                                     , W_ADJUST_CUST_ID          IN      OE_SHIP_ADJUST_CUST.ADJUST_CUST_ID%TYPE 
                                     , W_JOB_CATEGORY_CD         IN      FI_AUTO_JOURNAL_MST.JOB_CATEGORY_CD%TYPE       
                                     , W_ADJUST_TRX_ID           IN      OE_SHIP_ADJUST_TRX.ADJUST_TRX_ID%TYPE
                                     , X_RESULT_STATUS           OUT     VARCHAR2
                                     , X_RESULT_MSG              OUT     VARCHAR2 );                                       

----------------------------------------
-- 매출 자동 전표 처리
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_SEND ( P_SOB_ID                    IN      OE_SHIP_ADJUST_TRX.SOB_ID%TYPE
                                   , P_ORG_ID                    IN      OE_SHIP_ADJUST_TRX.ORG_ID%TYPE
                                   , P_PERIOD_NAME               IN      OE_SHIP_ADJUST_TRX.PERIOD_NAME%TYPE
                                   , P_BILL_TO_CUST_SITE_ID      IN      OE_SHIP_ADJUST_TRX.BILL_TO_CUST_SITE_ID%TYPE
                                   , P_ADJUST_TAX_AMOUNT         IN      OE_SHIP_ADJUST_TRX.ADJUST_TAX_AMOUNT%TYPE
                                   , P_EXPORT_REG_NO             IN      OE_SHIP_ADJUST_TRX.EXPORT_REG_NO%TYPE
                                   , P_JOB_CATEGORY_CD           IN      FI_AUTO_JOURNAL_MST.JOB_CATEGORY_CD%TYPE
                                   , P_SLIP_DATE                 IN      FI_SLIP_LINE_INTERFACE.SLIP_DATE%TYPE
                                   , P_PERSON_ID                 IN      FI_SLIP_LINE_INTERFACE.PERSON_ID%TYPE
                                   , P_CREATED_BY                IN      FI_SLIP_LINE_INTERFACE.CREATED_BY%TYPE
                                   , X_RESULT_STATUS             OUT     VARCHAR2
                                   , X_RESULT_MSG                OUT     VARCHAR2 );

----------------------------------------
-- 매출 자동 전표 처리 취소
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_CANCEL ( W_SOB_ID                  IN      FI_SLIP_LINE_INTERFACE.SOB_ID%TYPE
                                     , W_ORG_ID                  IN      FI_SLIP_LINE_INTERFACE.ORG_ID%TYPE
                                     , W_SLIP_NUM                IN      FI_SLIP_LINE_INTERFACE.SLIP_NUM%TYPE
                                     , X_RESULT_STATUS           OUT     VARCHAR2
                                     , X_RESULT_MSG              OUT     VARCHAR2 );

END FI_AUTO_SLIP_SHIP_G;
/
CREATE OR REPLACE PACKAGE BODY FI_AUTO_SLIP_SHIP_G AS
/******************************************************************************
   NAME:       FI_AUTO_SLIP_SHIP_G
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2011-09-28           1. Created this package body.

******************************************************************************/

----------------------------------------
-- 매출 자동 전표 대상 조회(집계)
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_T_SELECT ( P_CURSOR                OUT     TYPES.TCURSOR
                                       , W_SOB_ID                IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                       , W_ORG_ID                IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                       , W_PERIOD_NAME           IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                       , W_BILL_TO_CUST_SITE_ID  IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT 'N' AS SELECT_FLAG
              , ACS.CUST_SITE_CODE        AS CUST_SITE_CODE
              , ACS.CUST_SITE_SHORT_NAME  AS CUST_SITE_NAME
              
              , TRX.ADJUST_AMOUNT AS TOTAL_SLIP_AMOUNT
              , CASE WHEN TRX.JOB_CATEGORY_CD = 'SAL01' OR TRX.JOB_CATEGORY_CD = 'SAL02' THEN
                         TRUNC(TRX.ADJUST_AMOUNT / 10)
                     ELSE
                         0
                END AS TOTAL_SLIP_TAX_AMOUNT
              , '' EXPORT_REG_NO
              , ( SELECT CODE_NAME
                    FROM FI_COMMON
                   WHERE SOB_ID     = W_SOB_ID
                     AND ORG_ID     = W_ORG_ID
                     AND GROUP_CODE = 'JOB_CATEGORY'
                     AND CODE       = TRX.JOB_CATEGORY_CD ) JOB_CATEGORY_NAME
             
              , OSAC.PERIOD_NAME
              , OSAC.BILL_TO_CUST_SITE_ID
              , TRX.JOB_CATEGORY_CD
           FROM OE_SHIP_ADJUST_CUST OSAC 
              , ( SELECT ADJUST_CUST_ID
                       , 'SAL01' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX  OSAT
                       , INV_TRANSACTIONS    IT
                   WHERE OSAT.TRANSACTION_ID      = IT.TRANSACTION_ID
                     AND OSAT.SOB_ID              = W_SOB_ID
                     AND OSAT.ORG_ID              = W_ORG_ID
                     AND OSAT.PERIOD_NAME         = W_PERIOD_NAME
                     AND OSAT.SLIP_INTERFACE_FLAG = 'N'
                     AND OSAT.SHIPMENT_TYPE_LCODE IN ( 'DOMESTIC', 'LOCAL' )
                     AND OSAT.CHARGE_FLAG         = 'N'
                     AND IT.TAX_TYPE_ID           = 103                     
                   GROUP BY ADJUST_CUST_ID
                  UNION ALL 
                  SELECT ADJUST_CUST_ID
                       , 'SAL02' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX
                   WHERE SOB_ID              = W_SOB_ID
                     AND ORG_ID              = W_ORG_ID
                     AND PERIOD_NAME         = W_PERIOD_NAME                     
                     AND SLIP_INTERFACE_FLAG = 'N'
                     AND CHARGE_FLAG         = 'Y'
                   GROUP BY ADJUST_CUST_ID 
                  UNION ALL
                  SELECT ADJUST_CUST_ID
                       , 'SAL03' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX  OSAT
                       , INV_TRANSACTIONS    IT
                   WHERE OSAT.TRANSACTION_ID      = IT.TRANSACTION_ID
                     AND OSAT.SOB_ID              = W_SOB_ID
                     AND OSAT.ORG_ID              = W_ORG_ID
                     AND OSAT.PERIOD_NAME         = W_PERIOD_NAME
                     AND OSAT.SLIP_INTERFACE_FLAG = 'N'
                     AND OSAT.SHIPMENT_TYPE_LCODE IN ( 'DOMESTIC', 'LOCAL' )
                     AND OSAT.CHARGE_FLAG         = 'N'
                     AND IT.TAX_TYPE_ID           = 2
                   GROUP BY ADJUST_CUST_ID 
                  UNION ALL 
                  SELECT ADJUST_CUST_ID
                       , 'SAL04' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX
                   WHERE SOB_ID              = W_SOB_ID
                     AND ORG_ID              = W_ORG_ID
                     AND PERIOD_NAME         = W_PERIOD_NAME
                     AND SLIP_INTERFACE_FLAG = 'N'
                     AND SHIPMENT_TYPE_LCODE = 'EXPORT'
                   GROUP BY ADJUST_CUST_ID ) TRX
              , AR_CUSTOMER_SITE  ACS                   
          WHERE OSAC.ADJUST_CUST_ID       = TRX.ADJUST_CUST_ID 
            AND OSAC.BILL_TO_CUST_SITE_ID = ACS.CUST_SITE_ID
            AND OSAC.SOB_ID               = W_SOB_ID
            AND OSAC.ORG_ID               = W_ORG_ID
            AND OSAC.PERIOD_NAME          = W_PERIOD_NAME
            AND OSAC.BILL_TO_CUST_SITE_ID = NVL(W_BILL_TO_CUST_SITE_ID, OSAC.BILL_TO_CUST_SITE_ID)
--            AND OSAC.CONFIRM_FLAG         = 'Y'        
          ORDER BY ACS.CUST_SITE_SHORT_NAME
                 , TRX.JOB_CATEGORY_CD; 
  
  END FI_AUTO_SLIP_SHIP_T_SELECT;
  
  
    
----------------------------------------
-- 매출 자동 전표 대상 조회(세부)
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_D_SELECT ( P_CURSOR                OUT     TYPES.TCURSOR
                                       , W_SOB_ID                IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                       , W_ORG_ID                IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                       , W_PERIOD_NAME           IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                       , W_BILL_TO_CUST_SITE_ID  IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE
                                       , W_JOB_CATEGORY_CD       IN      FI_AUTO_JOURNAL_MST.JOB_CATEGORY_CD%TYPE )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT 'N' AS SELECT_FLAG
              , OSOL.ORDER_NO || '.' || OSOL.ORDER_LINE_NO  AS SALES_ORDER_NO
              , TRX.SHIPMENT_DATE
              , IIM.ITEM_CODE
              , IIM.ITEM_DESCRIPTION
              , TRX.SHIPMENT_QTY
              , TRX.ITEM_UOM_CODE
              , TRX.CURRENCY_CODE
              , TRX.ITEM_PRICE
              , TRX.ITEM_AMOUNT
              , TRX.CHARGE_PRICE
              , TRX.CHARGE_AMOUNT
              , TRX.ADJUST_EXCHANGE_RATE
              , TRX.ADJUST_AMOUNT

              , OSAC.PERIOD_NAME
              , OSAC.BILL_TO_CUST_SITE_ID
              , OSAC.ADJUST_CUST_ID
              , TRX.ADJUST_TRX_ID
              , TRX.JOB_CATEGORY_CD
           FROM OE_SHIP_ADJUST_CUST OSAC 
              , ( SELECT 'SAL01' JOB_CATEGORY_CD
                       , OSAT.*
                    FROM OE_SHIP_ADJUST_TRX  OSAT
                       , INV_TRANSACTIONS    IT
                   WHERE OSAT.TRANSACTION_ID      = IT.TRANSACTION_ID
                     AND OSAT.SOB_ID              = W_SOB_ID
                     AND OSAT.ORG_ID              = W_ORG_ID
                     AND OSAT.PERIOD_NAME         = W_PERIOD_NAME
                     AND OSAT.SLIP_INTERFACE_FLAG = 'N'
                     AND OSAT.SHIPMENT_TYPE_LCODE IN ( 'DOMESTIC', 'LOCAL' )
                     AND OSAT.CHARGE_FLAG         = 'N'
                     AND IT.TAX_TYPE_ID           = 103                     
                  UNION ALL 
                  SELECT 'SAL02' JOB_CATEGORY_CD
                       , OSAT.*
                    FROM OE_SHIP_ADJUST_TRX OSAT
                   WHERE SOB_ID              = W_SOB_ID
                     AND ORG_ID              = W_ORG_ID
                     AND PERIOD_NAME         = W_PERIOD_NAME                     
                     AND SLIP_INTERFACE_FLAG = 'N'
                     AND CHARGE_FLAG         = 'Y'
                  UNION ALL
                  SELECT 'SAL03' JOB_CATEGORY_CD
                       , OSAT.*
                    FROM OE_SHIP_ADJUST_TRX  OSAT
                       , INV_TRANSACTIONS    IT
                   WHERE OSAT.TRANSACTION_ID      = IT.TRANSACTION_ID
                     AND OSAT.SOB_ID              = W_SOB_ID
                     AND OSAT.ORG_ID              = W_ORG_ID
                     AND OSAT.PERIOD_NAME         = W_PERIOD_NAME
                     AND OSAT.SLIP_INTERFACE_FLAG = 'N'
                     AND OSAT.SHIPMENT_TYPE_LCODE IN ( 'DOMESTIC', 'LOCAL' )
                     AND OSAT.CHARGE_FLAG         = 'N'
                     AND IT.TAX_TYPE_ID           = 2
                  UNION ALL 
                  SELECT 'SAL04' JOB_CATEGORY_CD
                       , OSAT.*
                    FROM OE_SHIP_ADJUST_TRX OSAT
                   WHERE SOB_ID              = W_SOB_ID
                     AND ORG_ID              = W_ORG_ID
                     AND PERIOD_NAME         = W_PERIOD_NAME
                     AND SLIP_INTERFACE_FLAG = 'N'
                     AND SHIPMENT_TYPE_LCODE = 'EXPORT' ) TRX
              , INV_ITEM_MASTER     IIM
              , OE_SALES_ORDER_LINE OSOL
          WHERE OSAC.ADJUST_CUST_ID       = TRX.ADJUST_CUST_ID
            AND TRX.INVENTORY_ITEM_ID     = IIM.INVENTORY_ITEM_ID
            AND TRX.ORDER_LINE_ID         = OSOL.ORDER_LINE_ID 
            AND OSAC.SOB_ID               = W_SOB_ID
            AND OSAC.ORG_ID               = W_ORG_ID
            AND OSAC.PERIOD_NAME          = W_PERIOD_NAME
            AND OSAC.BILL_TO_CUST_SITE_ID = W_BILL_TO_CUST_SITE_ID
            AND TRX.JOB_CATEGORY_CD       = W_JOB_CATEGORY_CD
--            AND OSAC.CONFIRM_FLAG         = 'Y'        
          ORDER BY TRX.ADJUST_TRX_ID;
  
  END FI_AUTO_SLIP_SHIP_D_SELECT;
  
  
  
  
----------------------------------------
-- 매출 자동 전표 전송 내역  조회
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_S_SELECT ( P_CURSOR                OUT     TYPES.TCURSOR
                                       , W_SOB_ID                IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                       , W_ORG_ID                IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                       , W_PERIOD_NAME           IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                       , W_BILL_TO_CUST_SITE_ID  IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT 'N' AS SELECT_FLAG
              , ACS.CUST_SITE_CODE        AS CUST_SITE_CODE
              , ACS.CUST_SITE_SHORT_NAME  AS CUST_SITE_NAME
              
              , TRX.SLIP_NUM
                            
              , TRX.ADJUST_AMOUNT AS TOTAL_SLIP_AMOUNT
              , ( SELECT GL_AMOUNT
                    FROM FI_SLIP_LINE_INTERFACE
                   WHERE SLIP_NUM     = TRX.SLIP_NUM 
                     AND ACCOUNT_CODE = '2100700' ) AS TOTAL_SLIP_TAX_AMOUNT
              , ( SELECT CODE_NAME
                    FROM FI_COMMON
                   WHERE SOB_ID     = W_SOB_ID
                     AND ORG_ID     = W_ORG_ID
                     AND GROUP_CODE = 'JOB_CATEGORY'
                     AND CODE       = TRX.JOB_CATEGORY_CD ) JOB_CATEGORY_NAME            
             
              , OSAC.PERIOD_NAME
              , OSAC.BILL_TO_CUST_SITE_ID
              , TRX.JOB_CATEGORY_CD
           FROM OE_SHIP_ADJUST_CUST OSAC 
              , ( SELECT ADJUST_CUST_ID
                       , SLIP_NUM
                       , 'SAL01' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX  OSAT
                       , INV_TRANSACTIONS    IT
                   WHERE OSAT.TRANSACTION_ID      = IT.TRANSACTION_ID
                     AND OSAT.SOB_ID              = W_SOB_ID
                     AND OSAT.ORG_ID              = W_ORG_ID
                     AND OSAT.PERIOD_NAME         = W_PERIOD_NAME
                     AND OSAT.SLIP_INTERFACE_FLAG = 'Y'
                     AND OSAT.SHIPMENT_TYPE_LCODE IN ( 'DOMESTIC', 'LOCAL' )
                     AND OSAT.CHARGE_FLAG         = 'N'
                     AND IT.TAX_TYPE_ID           = 103                     
                   GROUP BY ADJUST_CUST_ID
                          , SLIP_NUM
                  UNION ALL 
                  SELECT ADJUST_CUST_ID
                       , SLIP_NUM
                       , 'SAL02' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX
                   WHERE SOB_ID              = W_SOB_ID
                     AND ORG_ID              = W_ORG_ID
                     AND PERIOD_NAME         = W_PERIOD_NAME                     
                     AND SLIP_INTERFACE_FLAG = 'Y'
                     AND CHARGE_FLAG         = 'Y'
                   GROUP BY ADJUST_CUST_ID
                          , SLIP_NUM 
                  UNION ALL
                  SELECT ADJUST_CUST_ID
                       , SLIP_NUM 
                       , 'SAL03' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX  OSAT
                       , INV_TRANSACTIONS    IT
                   WHERE OSAT.TRANSACTION_ID      = IT.TRANSACTION_ID
                     AND OSAT.SOB_ID              = W_SOB_ID
                     AND OSAT.ORG_ID              = W_ORG_ID
                     AND OSAT.PERIOD_NAME         = W_PERIOD_NAME
                     AND OSAT.SLIP_INTERFACE_FLAG = 'Y'
                     AND OSAT.SHIPMENT_TYPE_LCODE IN ( 'DOMESTIC', 'LOCAL' )
                     AND OSAT.CHARGE_FLAG         = 'N'
                     AND IT.TAX_TYPE_ID           = 2
                   GROUP BY ADJUST_CUST_ID
                          , SLIP_NUM 
                  UNION ALL 
                  SELECT ADJUST_CUST_ID
                       , SLIP_NUM
                       , 'SAL04' JOB_CATEGORY_CD
                       , SUM(ADJUST_AMOUNT) ADJUST_AMOUNT
                    FROM OE_SHIP_ADJUST_TRX
                   WHERE SOB_ID              = W_SOB_ID
                     AND ORG_ID              = W_ORG_ID
                     AND PERIOD_NAME         = W_PERIOD_NAME
                     AND SLIP_INTERFACE_FLAG = 'Y'
                     AND SHIPMENT_TYPE_LCODE = 'EXPORT'
                   GROUP BY ADJUST_CUST_ID
                          , SLIP_NUM ) TRX
              , AR_CUSTOMER_SITE  ACS                   
          WHERE OSAC.ADJUST_CUST_ID       = TRX.ADJUST_CUST_ID 
            AND OSAC.BILL_TO_CUST_SITE_ID = ACS.CUST_SITE_ID
            AND OSAC.SOB_ID               = W_SOB_ID
            AND OSAC.ORG_ID               = W_ORG_ID
            AND OSAC.PERIOD_NAME          = W_PERIOD_NAME
            AND OSAC.BILL_TO_CUST_SITE_ID = NVL(W_BILL_TO_CUST_SITE_ID, OSAC.BILL_TO_CUST_SITE_ID)
--            AND OSAC.CONFIRM_FLAG         = 'Y'        
          ORDER BY ACS.CUST_SITE_SHORT_NAME
                 , TRX.JOB_CATEGORY_CD; 
  
  END FI_AUTO_SLIP_SHIP_S_SELECT;
  
  
  
----------------------------------------
-- 매출 자동 전표 대상 설정 (Interface Flag 'S' 처리)
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_TARGET ( W_SOB_ID                  IN      OE_SHIP_ADJUST_CUST.SOB_ID%TYPE
                                     , W_ORG_ID                  IN      OE_SHIP_ADJUST_CUST.ORG_ID%TYPE
                                     , W_PERIOD_NAME             IN      OE_SHIP_ADJUST_CUST.PERIOD_NAME%TYPE
                                     , W_BILL_TO_CUST_SITE_ID    IN      OE_SHIP_ADJUST_CUST.BILL_TO_CUST_SITE_ID%TYPE
                                     , W_ADJUST_CUST_ID          IN      OE_SHIP_ADJUST_CUST.ADJUST_CUST_ID%TYPE 
                                     , W_JOB_CATEGORY_CD         IN      FI_AUTO_JOURNAL_MST.JOB_CATEGORY_CD%TYPE       
                                     , W_ADJUST_TRX_ID           IN      OE_SHIP_ADJUST_TRX.ADJUST_TRX_ID%TYPE
                                     , X_RESULT_STATUS           OUT     VARCHAR2
                                     , X_RESULT_MSG              OUT     VARCHAR2 )
  IS
     
  BEGIN
     X_RESULT_STATUS := 'F';
     
     -- 매출 유형별 일괄 처리
     IF W_ADJUST_TRX_ID IS NULL THEN
         -- 국내매출 
         IF W_JOB_CATEGORY_CD = 'SAL01' THEN
             UPDATE OE_SHIP_ADJUST_TRX OSAT
                SET SLIP_INTERFACE_FLAG = 'S'
              WHERE OSAT.SOB_ID               = W_SOB_ID
                AND OSAT.ORG_ID               = W_ORG_ID
                AND OSAT.PERIOD_NAME          = W_PERIOD_NAME
                AND OSAT.BILL_TO_CUST_SITE_ID = W_BILL_TO_CUST_SITE_ID
                AND OSAT.SLIP_INTERFACE_FLAG  = 'N'
                AND OSAT.SHIPMENT_TYPE_LCODE  IN ( 'DOMESTIC', 'LOCAL' )
                AND OSAT.CHARGE_FLAG          = 'N'
                AND EXISTS ( SELECT 'Y'                             
                               FROM INV_TRANSACTIONS    IT
                              WHERE IT.TRANSACTION_ID = OSAT.TRANSACTION_ID
                                AND IT.TAX_TYPE_ID   = 103 );
         -- 국내기타매출                       
         ELSIF W_JOB_CATEGORY_CD = 'SAL02' THEN            
             UPDATE OE_SHIP_ADJUST_TRX OSAT
                SET SLIP_INTERFACE_FLAG = 'S'
              WHERE OSAT.SOB_ID               = W_SOB_ID
                AND OSAT.ORG_ID               = W_ORG_ID
                AND OSAT.PERIOD_NAME          = W_PERIOD_NAME
                AND OSAT.BILL_TO_CUST_SITE_ID = W_BILL_TO_CUST_SITE_ID
                AND OSAT.SLIP_INTERFACE_FLAG  = 'N'
                AND OSAT.CHARGE_FLAG          = 'Y';
         -- LOCAL매출                       
         ELSIF W_JOB_CATEGORY_CD = 'SAL03' THEN
             UPDATE OE_SHIP_ADJUST_TRX OSAT
                SET SLIP_INTERFACE_FLAG = 'S'
              WHERE OSAT.SOB_ID               = W_SOB_ID
                AND OSAT.ORG_ID               = W_ORG_ID
                AND OSAT.PERIOD_NAME          = W_PERIOD_NAME
                AND OSAT.BILL_TO_CUST_SITE_ID = W_BILL_TO_CUST_SITE_ID
                AND OSAT.SLIP_INTERFACE_FLAG  = 'N'
                AND OSAT.SHIPMENT_TYPE_LCODE  IN ( 'DOMESTIC', 'LOCAL' )
                AND OSAT.CHARGE_FLAG          = 'N'
                AND EXISTS ( SELECT 'Y'                             
                               FROM INV_TRANSACTIONS    IT
                              WHERE IT.TRANSACTION_ID = OSAT.TRANSACTION_ID
                                AND IT.TAX_TYPE_ID   = 2 );
          -- 직수출매출                       
         ELSIF W_JOB_CATEGORY_CD = 'SAL04' THEN
             UPDATE OE_SHIP_ADJUST_TRX OSAT
                SET SLIP_INTERFACE_FLAG = 'S'
              WHERE OSAT.SOB_ID               = W_SOB_ID
                AND OSAT.ORG_ID               = W_ORG_ID
                AND OSAT.PERIOD_NAME          = W_PERIOD_NAME
                AND OSAT.BILL_TO_CUST_SITE_ID = W_BILL_TO_CUST_SITE_ID
                AND OSAT.SLIP_INTERFACE_FLAG  = 'N'
                AND OSAT.SHIPMENT_TYPE_LCODE  = 'EXPORT';
         END IF;                                                
            
     ELSE
         UPDATE OE_SHIP_ADJUST_TRX
            SET SLIP_INTERFACE_FLAG = 'S'
          WHERE ADJUST_TRX_ID = W_ADJUST_TRX_ID
            AND SLIP_INTERFACE_FLAG = 'N'; 
                                                                                     
     END IF;
                    
     X_RESULT_STATUS := 'S';                                       
   
  EXCEPTION
     WHEN OTHERS THEN
         X_RESULT_MSG := REPLACE(SQLERRM, 'ORA-20001:', '');
         RETURN;

  END FI_AUTO_SLIP_SHIP_TARGET;             
  


----------------------------------------
-- 매출 자동 전표 처리
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_SEND ( P_SOB_ID                    IN      OE_SHIP_ADJUST_TRX.SOB_ID%TYPE
                                   , P_ORG_ID                    IN      OE_SHIP_ADJUST_TRX.ORG_ID%TYPE
                                   , P_PERIOD_NAME               IN      OE_SHIP_ADJUST_TRX.PERIOD_NAME%TYPE
                                   , P_BILL_TO_CUST_SITE_ID      IN      OE_SHIP_ADJUST_TRX.BILL_TO_CUST_SITE_ID%TYPE
                                   , P_ADJUST_TAX_AMOUNT         IN      OE_SHIP_ADJUST_TRX.ADJUST_TAX_AMOUNT%TYPE
                                   , P_EXPORT_REG_NO             IN      OE_SHIP_ADJUST_TRX.EXPORT_REG_NO%TYPE
                                   , P_JOB_CATEGORY_CD           IN      FI_AUTO_JOURNAL_MST.JOB_CATEGORY_CD%TYPE
                                   , P_SLIP_DATE                 IN      FI_SLIP_LINE_INTERFACE.SLIP_DATE%TYPE
                                   , P_PERSON_ID                 IN      FI_SLIP_LINE_INTERFACE.PERSON_ID%TYPE
                                   , P_CREATED_BY                IN      FI_SLIP_LINE_INTERFACE.CREATED_BY%TYPE
                                   , X_RESULT_STATUS             OUT     VARCHAR2
                                   , X_RESULT_MSG                OUT     VARCHAR2 )
  IS
     V_LOCAL_DATE                    DATE := GET_LOCAL_DATE(P_SOB_ID);
     
     V_HEADER_INTERFACE_ID           FI_SLIP_LINE_INTERFACE.HEADER_INTERFACE_ID%TYPE;
     V_LINE_INTERFACE_ID             FI_SLIP_LINE_INTERFACE.LINE_INTERFACE_ID%TYPE;
     V_SLIP_NUM                      FI_SLIP_LINE_INTERFACE.SLIP_NUM%TYPE;
     V_DEPT_ID                       FI_SLIP_LINE_INTERFACE.DEPT_ID%TYPE;                                  
     V_SLIP_TYPE                     FI_SLIP_LINE_INTERFACE.SLIP_TYPE%TYPE;
     V_CURRENCY_CODE                 FI_SLIP_LINE_INTERFACE.CURRENCY_CODE%TYPE;
     V_SOURCE_TABLE                  FI_SLIP_HEADER_INTERFACE.SOURCE_TABLE%TYPE := 'OE_SHIP_ADJUST_TRX';
     V_SLIP_REMARKS                  FI_SLIP_HEADER_INTERFACE.REMARK%TYPE;
     V_GL_AMOUNT                     FI_SLIP_LINE_INTERFACE.GL_AMOUNT%TYPE;
     V_COUNT                         NUMBER;
     
  BEGIN
     X_RESULT_STATUS := 'F';
     
     --V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', P_SOB_ID, P_SLIP_DATE, P_CREATED_BY);  -- 전표번호 채번.
     V_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID); -- 기본 통화.
     V_SLIP_TYPE := 'SAL';    -- 전표유형 : 매출전표.
     
     -- 자동분개 설정 데이터 존재 체크.
     BEGIN
         SELECT DISTINCT JM.SLIP_REMARKS
           INTO V_SLIP_REMARKS
           FROM FI_AUTO_JOURNAL_MST JM
              , FI_AUTO_JOURNAL_DET JD
          WHERE JM.JOB_CATEGORY_CD = JD.JOB_CATEGORY_CD
            AND JM.SOB_ID          = JD.SOB_ID
            AND JM.JOB_CATEGORY_CD = P_JOB_CATEGORY_CD
            AND JM.SOB_ID          = P_SOB_ID
            AND JD.ACCOUNT_DR_CR   = 1
            AND JM.ENABLED_FLAG    = 'Y'
            AND JD.ENABLED_FLAG    = 'Y';
     EXCEPTION WHEN OTHERS THEN
         X_RESULT_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10304', NULL);
         RETURN;
     END;
     
     BEGIN
         SELECT HDM.M_DEPT_ID DEPT_ID
           INTO V_DEPT_ID
           FROM HRM_PERSON_MASTER HPM
              , HRM_DEPT_MAPPING  HDM
          WHERE HPM.DEPT_ID = HDM.HR_DEPT_ID
            AND HPM.PERSON_ID   = P_PERSON_ID
            AND HDM.MODULE_TYPE = 'FCM';
     EXCEPTION WHEN OTHERS THEN
         X_RESULT_MSG := 'Depart Id Error';
         RETURN;
     END;       
          
--     -- 경비전표 헤더 생성.
--     FI_SLIP_INTERFACE_G.INSERT_HEADER_IF ( P_HEADER_INTERFACE_ID => V_HEADER_INTERFACE_ID
--                                          , P_SLIP_DATE           => P_SLIP_DATE
--                                          , P_SLIP_NUM            => V_SLIP_NUM
--                                          , P_SOB_ID              => P_SOB_ID
--                                          , P_ORG_ID              => P_ORG_ID
--                                          , P_DEPT_ID             => V_DEPT_ID
--                                          , P_PERSON_ID           => P_PERSON_ID
--                                          , P_BUDGET_DEPT_ID      => NULL
--                                          , P_SLIP_TYPE           => V_SLIP_TYPE
--                                          , P_JOURNAL_HEADER_ID   => NULL
--                                          , P_REQ_BANK_ACCOUNT_ID => NULL
--                                          , P_REQ_PAYABLE_TYPE    => NULL
--                                          , P_REQ_PAYABLE_DATE    => NULL
--                                          , P_REMARK              => V_SLIP_REMARKS
--                                          , P_SUBSTANCE           => NULL
--                                          , P_USER_ID             => P_CREATED_BY );
                                          
     -- 경비전표 라인 생성.
     FOR DATA_LIST IN ( SELECT TRX.BILL_TO_CUST_SITE_ID CUSTOMER_ID
                             , FAJD.ACCOUNT_CONTROL_ID
                             , FAJD.ACCOUNT_CODE
                             , FAJD.ACCOUNT_DR_CR
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        P_ADJUST_TAX_AMOUNT
                                    ELSE 
                                        DECODE(FAJD.ACCOUNT_DR_CR, '1', TRX.ADJUST_AMOUNT + P_ADJUST_TAX_AMOUNT, TRX.ADJUST_AMOUNT) 
                               END AS GL_AMOUNT
                             , TRX.ADJUST_CURRENCY_CODE CURRENCY_CODE
                             , DECODE(TRX.ADJUST_CURRENCY_CODE, V_CURRENCY_CODE, NULL, TRX.ADJUST_EXCHANGE_RATE) EXCHANGE_RATE
                             , NULL GL_CURRENCY_AMOUNT
                             , TRX.CUST_SITE_CODE MANAGEMENT1  -- 관리항목1(거래처)
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        DECODE(FAJD.JOB_CATEGORY_CD, 'SAL03', '2', 'SAL04', '3',  '1')
                                    ELSE 
                                        NULL 
                               END AS MANAGEMENT2 -- 관리항목2(세무유형)
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        P_SLIP_DATE
                                    ELSE 
                                        NULL 
                               END AS REFER1 -- 관리항목3(신고기준일자)
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        TRX.ADJUST_AMOUNT
                                    ELSE 
                                        NULL 
                               END AS REFER2 -- 관리항목4(공급가액)
                             , NULL REFER3 -- 관리항목5(통화)
                             , P_EXPORT_REG_NO REFER4 -- 관리항목6(수출신고번호)
                             , NULL REFER5 -- 관리항목7(외화금액)
                             , NULL REFER6 -- 관리항목8(환율)
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        DECODE(TRX.TAX_BILL_TYPE_LCODE, 'E_TAX_BILL', 'Y', 'N')
                                    ELSE 
                                        NULL 
                               END AS REFER7 -- 관리항목9(전자세금계산서여부)
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        P_ADJUST_TAX_AMOUNT
                                    ELSE 
                                        NULL 
                               END AS REFER8 -- 관리항목10(세액)
                             , NULL REFER9 -- 관리항목11(예정신고누락분여부)
                             , NULL REFER10 -- 관리항목1금2(수정전자세금계산서사유구분)
                             , CASE WHEN FAJD.ACCOUNT_CODE = '2100700' THEN 
                                        '110'
                                    ELSE 
                                        NULL 
                               END AS REFER11 -- 관리항목13(사업장)
                             , NULL REFER12 -- 관리항목14   
                             , 'TEST' REMARK
                          FROM ( SELECT OSAT.BILL_TO_CUST_SITE_ID
                                      , ACS.CUST_SITE_CODE
                                      , OSAT.ADJUST_CURRENCY_CODE
                                      , OSAT.ADJUST_EXCHANGE_RATE
                                      , ACS.TAX_BILL_TYPE_LCODE
                                      , SUM(OSAT.ADJUST_AMOUNT) ADJUST_AMOUNT
                                   FROM OE_SHIP_ADJUST_TRX OSAT
                                      , AR_CUSTOMER_SITE   ACS
                                  WHERE OSAT.BILL_TO_CUST_SITE_ID = ACS.CUST_SITE_ID
                                    AND OSAT.SOB_ID               = P_SOB_ID
                                    AND OSAT.ORG_ID               = P_ORG_ID
                                    AND OSAT.PERIOD_NAME          = P_PERIOD_NAME
                                    AND OSAT.BILL_TO_CUST_SITE_ID = P_BILL_TO_CUST_SITE_ID
                                    AND OSAT.SLIP_INTERFACE_FLAG  = 'S'
                                  GROUP BY OSAT.BILL_TO_CUST_SITE_ID
                                         , ACS.CUST_SITE_CODE
                                         , OSAT.ADJUST_CURRENCY_CODE
                                         , OSAT.ADJUST_EXCHANGE_RATE
                                         , ACS.TAX_BILL_TYPE_LCODE ) TRX
                              , FI_AUTO_JOURNAL_DET FAJD
                         WHERE FAJD.SOB_ID = P_SOB_ID
                           AND FAJD.ORG_ID = P_ORG_ID
                           AND FAJD.JOB_CATEGORY_CD = P_JOB_CATEGORY_CD
                           AND FAJD.ENABLED_FLAG    = 'Y'
                         ORDER BY AUTO_JOURNAL_SEQ )
     LOOP
         /*FI_SLIP_INTERFACE_G.INSERT_LINE_IF ( P_LINE_INTERFACE_ID   => V_LINE_INTERFACE_ID
                                            , P_HEADER_INTERFACE_ID => V_HEADER_INTERFACE_ID
                                            , P_SOB_ID              => P_SOB_ID
                                            , P_ORG_ID              => P_ORG_ID
                                            , P_BUDGET_DEPT_ID      => V_DEPT_ID
                                            , P_CUSTOMER_ID         => DATA_LIST.CUSTOMER_ID
                                            , P_ACCOUNT_CONTROL_ID  => DATA_LIST.ACCOUNT_CONTROL_ID
                                            , P_ACCOUNT_CODE        => DATA_LIST.ACCOUNT_CODE
                                            , P_COST_CENTER_ID      => NULL
                                            , P_ACCOUNT_DR_CR       => DATA_LIST.ACCOUNT_DR_CR
                                            , P_GL_AMOUNT           => DATA_LIST.GL_AMOUNT
                                            , P_CURRENCY_CODE       => DATA_LIST.CURRENCY_CODE
                                            , P_EXCHANGE_RATE       => DATA_LIST.EXCHANGE_RATE
                                            , P_GL_CURRENCY_AMOUNT  => DATA_LIST.GL_CURRENCY_AMOUNT
                                            , P_BANK_ACCOUNT_ID     => NULL
                                            , P_MANAGEMENT1         => DATA_LIST.MANAGEMENT1
                                            , P_MANAGEMENT2         => DATA_LIST.MANAGEMENT2
                                            , P_REFER1              => DATA_LIST.REFER1
                                            , P_REFER2              => DATA_LIST.REFER2
                                            , P_REFER3              => DATA_LIST.REFER3
                                            , P_REFER4              => DATA_LIST.REFER4
                                            , P_REFER5              => DATA_LIST.REFER5
                                            , P_REFER6              => DATA_LIST.REFER6
                                            , P_REFER7              => DATA_LIST.REFER7
                                            , P_REFER8              => DATA_LIST.REFER8
                                            , P_REFER9              => DATA_LIST.REFER9
                                            , P_REFER10             => DATA_LIST.REFER10
                                            , P_REFER11             => DATA_LIST.REFER11
                                            , P_REFER12             => DATA_LIST.REFER12
                                            , P_VOUCH_CODE          => NULL
                                            , P_REFER_RATE          => NULL
                                            , P_REFER_AMOUNT        => NULL
                                            , P_REFER_DATE1         => NULL
                                            , P_REFER_DATE2         => NULL
                                            , P_REMARK              => DATA_LIST.REMARK
                                            , P_FUND_CODE           => NULL
                                            , P_USER_ID             => P_CREATED_BY );*/
      
         FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE ( P_MODULE_TYPE        => V_SLIP_TYPE
                                                             , P_SLIP_DATE          => P_SLIP_DATE
                                                             , P_SOB_ID             => P_SOB_ID
                                                             , P_ORG_ID             => P_ORG_ID
                                                             , P_DEPT_ID            => V_DEPT_ID
                                                             , P_PERSON_ID          => P_PERSON_ID
                                                             , P_BUDGET_DEPT_ID     => V_DEPT_ID
                                                             , P_HEADER_REMARK      => V_SLIP_REMARKS
                                                             , P_ACCOUNT_CODE       => DATA_LIST.ACCOUNT_CODE
                                                             , P_ACCOUNT_DR_CR      => DATA_LIST.ACCOUNT_DR_CR
                                                             , P_GL_AMOUNT          => DATA_LIST.GL_AMOUNT
                                                             , P_CURRENCY_CODE      => DATA_LIST.CURRENCY_CODE
                                                             , P_EXCHANGE_RATE      => DATA_LIST.EXCHANGE_RATE
                                                             , P_GL_CURRENCY_AMOUNT => DATA_LIST.GL_CURRENCY_AMOUNT
                                                             , P_MANAGEMENT1        => DATA_LIST.MANAGEMENT1
                                                             , P_MANAGEMENT2        => DATA_LIST.MANAGEMENT2
                                                             , P_REFER1             => DATA_LIST.REFER1
                                                             , P_REFER2             => DATA_LIST.REFER2
                                                             , P_REFER3             => DATA_LIST.REFER3
                                                             , P_REFER4             => DATA_LIST.REFER4
                                                             , P_REFER5             => DATA_LIST.REFER5
                                                             , P_REFER6             => DATA_LIST.REFER6
                                                             , P_REFER7             => DATA_LIST.REFER7
                                                             , P_REFER8             => DATA_LIST.REFER8
                                                             , P_REFER9             => DATA_LIST.REFER9
                                                             , P_REFER10            => DATA_LIST.REFER10
                                                             , P_REFER11            => DATA_LIST.REFER11
                                                             , P_REFER12            => DATA_LIST.REFER12
                                                             , P_VOUCH_CODE         => NULL
                                                             , P_REFER_RATE         => NULL
                                                             , P_REFER_AMOUNT       => NULL
                                                             , P_REFER_DATE1        => NULL
                                                             , P_REFER_DATE2        => NULL
                                                             , P_REMARK             => DATA_LIST.REMARK
                                                             , P_FUND_CODE          => NULL
                                                             , P_UNIT_PRICE         => NULL
                                                             , P_UOM_CODE           => NULL
                                                             , P_QUANTITY           => NULL
                                                             , P_WEIGHT             => NULL
                                                             , P_USER_ID            => P_CREATED_BY
                                                             , O_STATUS             => X_RESULT_STATUS
                                                             , O_MESSAGE            => X_RESULT_MSG );
                                                             
         IF X_RESULT_STATUS = 'F' THEN
             RETURN;
         END IF;
         
         X_RESULT_STATUS := 'F';        
     END LOOP;
     
     -- 경비전표 결과 값 리턴
     FI_SLIP_AUTO_INTERFACE_G.SET_SLIP_AUTO_INTERFACE ( P_MODULE_TYPE => V_SLIP_TYPE
                                                      , P_SLIP_DATE   => P_SLIP_DATE
                                                      , P_SOB_ID      => P_SOB_ID
                                                      , P_ORG_ID      => P_ORG_ID
                                                      , P_USER_ID     => P_CREATED_BY
                                                      , O_HEADER_ID   => V_HEADER_INTERFACE_ID
                                                      , O_SLIP_NUM    => V_SLIP_NUM
                                                      , O_STATUS      => X_RESULT_STATUS
                                                      , O_MESSAGE     => X_RESULT_MSG );
     
     
     /*X_RESULT_MSG := ', HEADER ID : ' || V_HEADER_INTERFACE_ID || ', SLIP NUM : ' || V_SLIP_NUM || ', STATUS : ' || X_RESULT_STATUS;
     X_RESULT_STATUS := 'F';
     RAISE_APPLICATION_ERROR(-20001, X_RESULT_MSG);
     RETURN;*/
                                                   
     IF X_RESULT_STATUS = 'F' THEN
         RETURN;
     ELSE
         X_RESULT_STATUS := 'F';
     END IF;                             
     
     UPDATE OE_SHIP_ADJUST_TRX
        SET EXPORT_REG_NO       = P_EXPORT_REG_NO
          , SLIP_TYPE           = V_SLIP_TYPE
          , SLIP_NUM            = V_SLIP_NUM
          , VAT_ASSIGN_DATE     = P_SLIP_DATE
          , SLIP_INTERFACE_FLAG = 'Y'
      WHERE SOB_ID               = P_SOB_ID
        AND ORG_ID               = P_ORG_ID
        AND PERIOD_NAME          = P_PERIOD_NAME
        AND BILL_TO_CUST_SITE_ID = P_BILL_TO_CUST_SITE_ID
        AND SLIP_INTERFACE_FLAG  = 'S';
     
     V_COUNT := SQL%ROWCOUNT;
     
     /*X_RESULT_MSG := 'V_COUNT : ' || V_COUNT || ', HEADER ID : ' || V_HEADER_INTERFACE_ID || ', SLIP NUM : ' || V_SLIP_NUM || ', STATUS : ' || X_RESULT_STATUS;
     X_RESULT_STATUS := 'F';
     RAISE_APPLICATION_ERROR(-20001, X_RESULT_MSG);
     RETURN;   */
     X_RESULT_STATUS := 'S';                                       
   
  EXCEPTION
     WHEN OTHERS THEN
         X_RESULT_MSG := REPLACE(SQLERRM, 'ORA-20001:', '');
         RETURN;

  END;



----------------------------------------
-- 매출 자동 전표 처리 취소
----------------------------------------
  PROCEDURE FI_AUTO_SLIP_SHIP_CANCEL ( W_SOB_ID                  IN      FI_SLIP_LINE_INTERFACE.SOB_ID%TYPE
                                     , W_ORG_ID                  IN      FI_SLIP_LINE_INTERFACE.ORG_ID%TYPE
                                     , W_SLIP_NUM                IN      FI_SLIP_LINE_INTERFACE.SLIP_NUM%TYPE
                                     , X_RESULT_STATUS           OUT     VARCHAR2
                                     , X_RESULT_MSG              OUT     VARCHAR2 )
  IS
     V_HEADER_INTERFACE_ID             FI_SLIP_LINE_INTERFACE.HEADER_INTERFACE_ID%TYPE;

  BEGIN
     X_RESULT_STATUS := 'F';
  
     BEGIN
         SELECT HEADER_INTERFACE_ID
           INTO V_HEADER_INTERFACE_ID
           FROM FI_SLIP_HEADER_INTERFACE
          WHERE SOB_ID   = W_SOB_ID
            AND ORG_ID   = W_ORG_ID
            AND SLIP_NUM = W_SLIP_NUM;
     EXCEPTION WHEN OTHERS THEN
         X_RESULT_MSG := 'Header Interface Id Error';
         RETURN;
     END;   
  
     -- 일반경비전표 승인여부 체크하여 삭제 제어.
     IF FI_SLIP_INTERFACE_G.SLIP_CONFIRM_YN_F(V_HEADER_INTERFACE_ID) = 'Y' THEN
         X_RESULT_MSG := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Delete');
         RETURN;
     END IF;
     
     UPDATE OE_SHIP_ADJUST_TRX
        SET SLIP_NUM            = NULL
          , SLIP_INTERFACE_FLAG = 'N'
      WHERE SOB_ID               = W_SOB_ID
        AND ORG_ID               = W_ORG_ID
        AND SLIP_NUM             = W_SLIP_NUM
        AND CONFIRM_FLAG         = 'Y'
        AND SLIP_INTERFACE_FLAG  = 'Y';
     
     DELETE FROM FI_SLIP_LINE_INTERFACE
      WHERE HEADER_INTERFACE_ID = V_HEADER_INTERFACE_ID;
       
     DELETE FROM FI_SLIP_HEADER_INTERFACE
      WHERE HEADER_INTERFACE_ID = V_HEADER_INTERFACE_ID;
      
     X_RESULT_STATUS := 'S'; 

  EXCEPTION
     WHEN OTHERS THEN
         X_RESULT_MSG := REPLACE(SQLERRM, 'ORA-20001:', '');
         RETURN;

  END;

END FI_AUTO_SLIP_SHIP_G;
/
