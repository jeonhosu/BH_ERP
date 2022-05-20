SELECT BM.BUSINESS_NAME
           , BM.PRESIDENT_NAME
           , BM.VAT_NUM
           , BM.ADDR1 || ' ' || BM.ADDR2 AS ADDRESS
           , BM.BUSINESS_TYPE
           , BM.BUSINESS_ITEM
           , BM.TEL_NUM
           , BM.FAX_NUM
           , BM.EMAIL
           , CM.CORPORATE_NAME
           , CM.LEGAL_NUM
           , BM.BANK_CODE
           , FI_BANK_G.CODE_NAME_F(BM.BANK_CODE, BM.SOB_ID) AS BANK_NAME
           , FB.BANK_CODE AS BANK_SITE_CODE
           , FB.BANK_NAME AS BANK_SITE_NAME
           , BA.BANK_ACCOUNT_NUM
        FROM FI_BUSINESS_MASTER BM 
          , FI_CORPORATE_MASTER CM
          , FI_BANK_ACCOUNT BA
          , FI_BANK FB
      WHERE BM.CORPORATE_ID             = CM.CORPORATE_ID
        AND BM.SOB_ID                   = CM.SOB_ID
        AND BM.BANK_ACCOUNT_CODE        = BA.BANK_ACCOUNT_CODE(+)
        AND BM.SOB_ID                   = BA.SOB_ID(+)
        AND BA.BANK_ID                  = FB.BANK_ID(+)
        AND BA.SOB_ID                   = FB.SOB_ID(+)
        AND BM.BUSINESS_CODE            = &W_TAX_CODE
        AND BM.SOB_ID                   = &W_SOB_ID
