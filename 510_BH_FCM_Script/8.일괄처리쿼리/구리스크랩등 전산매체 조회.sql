SELECT 
             COUNT(CE.SUPPLIER_ID) AS SUPPLIER_COUNT  -- 매입처수 합계 
           , SUM(CE.VAT_COUNT) AS VAT_COUNT           -- 건수 합계 
           , SUM(CE.ITEM_QTY) AS ITEM_QTY             -- 수량 합계 
           , SUM(CE.ITEM_AMOUNT) AS ITEM_AMOUNT       -- 취득금액 합계 
           , SUM(CE.DEEMED_VAT_AMOUNT) AS DEEMED_VAT_AMOUNT     -- 의제매입세액 합계     
           
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 1, 0)) AS RECEIPT_SUPPLIER_COUNT  -- 영수증 매입처수  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.VAT_COUNT, 0)) AS RECEIPT_VAT_COUNT           -- 영수증 건수  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.ITEM_QTY, 0)) AS RECEIPT_ITEM_QTY             -- 영수증 수량  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.ITEM_AMOUNT, 0)) AS RECEIPT_ITEM_AMOUNT       -- 영수증 취득금액  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.DEEMED_VAT_AMOUNT, 0)) AS RECEIPT_DEEMED_VAT_AMOUNT     -- 영수증 의제매입세액   
              
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, 1)) AS BILL_SUPPLIER_COUNT  -- 계산서 매입처수  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.VAT_COUNT)) AS BILL_VAT_COUNT           -- 계산서 건수  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.ITEM_QTY)) AS BILL_ITEM_QTY             -- 계산서 수량  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.ITEM_AMOUNT)) AS BILL_ITEM_AMOUNT       -- 계산서 취득금액  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.DEEMED_VAT_AMOUNT)) AS BILL_DEEMED_VAT_AMOUNT     -- 계산서 의제매입세액             
        FROM FI_VAT_COPPER_ETC CE
           , AP_SUPPLIER       FAS
       WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID  
         AND CE.TAX_CODE          = &W_TAX_CODE
         AND CE.SOB_ID            = &W_SOB_ID
         AND CE.ORG_ID            = &W_ORG_ID
         AND CE.VAT_MNG_SERIAL    = &W_VAT_MNG_SERIAL                 
      ;
