SELECT 
             COUNT(CE.SUPPLIER_ID) AS SUPPLIER_COUNT  -- ����ó�� �հ� 
           , SUM(CE.VAT_COUNT) AS VAT_COUNT           -- �Ǽ� �հ� 
           , SUM(CE.ITEM_QTY) AS ITEM_QTY             -- ���� �հ� 
           , SUM(CE.ITEM_AMOUNT) AS ITEM_AMOUNT       -- ���ݾ� �հ� 
           , SUM(CE.DEEMED_VAT_AMOUNT) AS DEEMED_VAT_AMOUNT     -- �������Լ��� �հ�     
           
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 1, 0)) AS RECEIPT_SUPPLIER_COUNT  -- ������ ����ó��  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.VAT_COUNT, 0)) AS RECEIPT_VAT_COUNT           -- ������ �Ǽ�  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.ITEM_QTY, 0)) AS RECEIPT_ITEM_QTY             -- ������ ����  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.ITEM_AMOUNT, 0)) AS RECEIPT_ITEM_AMOUNT       -- ������ ���ݾ�  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', CE.DEEMED_VAT_AMOUNT, 0)) AS RECEIPT_DEEMED_VAT_AMOUNT     -- ������ �������Լ���   
              
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, 1)) AS BILL_SUPPLIER_COUNT  -- ��꼭 ����ó��  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.VAT_COUNT)) AS BILL_VAT_COUNT           -- ��꼭 �Ǽ�  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.ITEM_QTY)) AS BILL_ITEM_QTY             -- ��꼭 ����  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.ITEM_AMOUNT)) AS BILL_ITEM_AMOUNT       -- ��꼭 ���ݾ�  
           , SUM(DECODE(CE.VAT_RECEIPT_TYPE, '10', 0, CE.DEEMED_VAT_AMOUNT)) AS BILL_DEEMED_VAT_AMOUNT     -- ��꼭 �������Լ���             
        FROM FI_VAT_COPPER_ETC CE
           , AP_SUPPLIER       FAS
       WHERE CE.SUPPLIER_ID       = FAS.SUPPLIER_ID  
         AND CE.TAX_CODE          = &W_TAX_CODE
         AND CE.SOB_ID            = &W_SOB_ID
         AND CE.ORG_ID            = &W_ORG_ID
         AND CE.VAT_MNG_SERIAL    = &W_VAT_MNG_SERIAL                 
      ;
