      -- 이월자료 생성.
      DELETE FROM FI_BALANCE_OVER_GT
      ;

      -- 이월 잔액 산출.
      INSERT INTO FI_BALANCE_OVER_GT
      ( GL_DATE
      , ACCOUNT_CONTROL_ID
      , ACCOUNT_CODE
      , ACCOUNT_DESC
      , CUSTOMER_ID
      , CURRENCY_CODE
      , REMARK
      , DR_GL_AMOUNT
      , CR_GL_AMOUNT
      )
      SELECT &W_GL_DATE_FR - 1 AS GL_DATE
           , FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.CUSTOMER_ID
           , PX1.CURRENCY_CODE
           , EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10165', NULL) AS REMARK
           , NVL(SUM(PX1.DR_AMOUNT), 0) AS DR_AMOUNT          
           , NVL(SUM(PX1.CR_AMOUNT), 0) AS CR_AMOUNT
        FROM FI_ACCOUNT_CONTROL FAC
          , ( SELECT 0 AS ACCOUNT_CONTROL_ID
                 , '0' AS ACCOUNT_CODE
                 , NULL AS ACCOUNT_DESC
                 , NULL AS CUSTOMER_ID
                 , NULL AS CURRENCY_CODE
                 , 0 AS DR_AMOUNT
                 , 0 AS CR_AMOUNT
              FROM DUAL
              UNION ALL
              SELECT CBD.ACCOUNT_CONTROL_ID
                   , CBD.ACCOUNT_CODE                   
                   , AC.ACCOUNT_DR_CR      -- 잔액 구분.
                   , CBD.CUSTOMER_ID
                   , CBD.CURRENCY_CODE
                   , NVL(CBD.DR_AMOUNT, 0) AS DR_AMOUNT
                   , NVL(CBD.CR_AMOUNT, 0) AS CR_AMOUNT                   
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                  , FI_ACCOUNT_CONTROL AC
               WHERE CBD.ACCOUNT_CONTROL_ID    = AC.ACCOUNT_CONTROL_ID
                 AND CBD.GL_DATE               = TRUNC(&W_GL_DATE_FR, 'MONTH')
                 AND CBD.GL_DATE_SEQ           = 0
                 AND CBD.SOB_ID                = &W_SOB_ID
                 AND CBD.ACCOUNT_CODE          BETWEEN NVL(&W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              UNION ALL
              -- 1일 ~ 시작(GL_DATE_FR-1) 전일까지의 잔액금액 계산.
              SELECT CBD.ACCOUNT_CONTROL_ID
                   , CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DR_CR
                   , CBD.CUSTOMER_ID
                   , CBD.CURRENCY_CODE
                   , NVL(CBD.DR_AMOUNT, 0) AS DR_AMOUNT
                   , NVL(CBD.CR_AMOUNT, 0) AS CR_AMOUNT                   
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                  , FI_ACCOUNT_CONTROL AC
               WHERE CBD.ACCOUNT_CONTROL_ID   = AC.ACCOUNT_CONTROL_ID
                 AND CBD.SOB_ID               = &W_SOB_ID
                 AND CBD.GL_DATE_SEQ          = 1
                 AND CBD.GL_DATE              BETWEEN TRUNC(&W_GL_DATE_FR, 'MONTH') AND &W_GL_DATE_FR - 1
                 AND CBD.ACCOUNT_BOOK_ID      = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(&W_SOB_ID)
                 AND CBD.ACCOUNT_CODE         BETWEEN NVL(&W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              ) PX1
      WHERE FAC.ACCOUNT_CONTROL_ID            = PX1.ACCOUNT_CONTROL_ID(+)
        AND FAC.ACCOUNT_CODE                  BETWEEN NVL(&W_ACCOUNT_CODE_FR, FAC.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, FAC.ACCOUNT_CODE)
      GROUP BY FAC.ACCOUNT_CONTROL_ID
           , FAC.ACCOUNT_CODE
           , FAC.ACCOUNT_DESC
           , PX1.CUSTOMER_ID
           , PX1.CURRENCY_CODE
      ;
    
select *
  FROM FI_BALANCE_OVER_GT 
;


      SELECT SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , SC.TAX_REG_NO
           , SX1.ACCOUNT_CODE
           , SX1.ACCOUNT_DESC
           , NVL(SUM(NVL(SX1.BEFORE_AMOUNT, 0)), 0) AS BEFORE_AMOUNT
           , NVL(SUM(NVL(SX1.DR_AMOUNT, 0)), 0) AS DR_AMOUNT
           , NVL(SUM(NVL(SX1.CR_AMOUNT, 0)), 0) AS CR_AMOUNT
           , NVL(SUM(NVL(SX1.BEFORE_AMOUNT, 0) + NVL(SX1.REMAIN_AMOUNT, 0)), 0) AS REMAIN_AMOUNT
        FROM FI_SUPP_CUST_V SC
          , ( SELECT BOG.GL_DATE
                   , BOG.ACCOUNT_CODE
                   , BOG.ACCOUNT_DESC
                   , BOG.CUSTOMER_ID
                   , BOG.DR_GL_AMOUNT AS DR_AMOUNT           --당월차변(This Debit Amount)
                   , BOG.CR_GL_AMOUNT AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
                   , 0 AS REMAIN_AMOUNT       --잔액금액(원화) Remain Aamount )
                FROM FI_BALANCE_OVER_GT BOG
               WHERE BOG.ACCOUNT_CODE           BETWEEN NVL(&W_ACCOUNT_CODE_FR, BOG.ACCOUNT_CODE) AND NVL(&W_ACCOUNT_CODE_TO, BOG.ACCOUNT_CODE)
                 AND BOG.GL_DATE                = &W_GL_DATE_FR - 1 
               ---------
               UNION ALL
               ---------
               SELECT CBD.GL_DATE 
                   , CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DESC
                   , CBD.CUSTOMER_ID
                   , 0 AS BEFORE_AMOUNT       --이월원화 (Before Amount)
                   , 0 AS BEFORE_CURR_AMOUNT  -- 이월 외화
                   , NVL(SUM(CBD.DR_AMOUNT), 0) AS DR_AMOUNT           --당월차변(This Debit Amount)
                   , NVL(SUM(CBD.CR_AMOUNT), 0) AS CR_AMOUNT           --당월차변외화(This Currency Debit Amount)
                   , NVL(SUM(CASE
                               WHEN AC.ACCOUNT_DR_CR = '1' THEN NVL(CBD.DR_AMOUNT, 0) - NVL(CBD.CR_AMOUNT, 0)
                               WHEN AC.ACCOUNT_DR_CR = '2' THEN NVL(CBD.CR_AMOUNT, 0) - NVL(CBD.DR_AMOUNT, 0)
                             END), 0) AS  REMAIN_AMOUNT  --잔액금액(외화) Remain Currency Amount)
                FROM FI_CUSTOMER_BALANCE_DAILY CBD
                  , FI_ACCOUNT_CONTROL AC
               WHERE CBD.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
                 AND CBD.GL_DATE                BETWEEN W_GL_DATE_FR   AND W_GL_DATE_TO
                 AND CBD.GL_DATE_SEQ            = 1
                 AND CBD.SOB_ID                 = W_SOB_ID
                 AND CBD.ACCOUNT_CODE           BETWEEN NVL(W_ACCOUNT_CODE_FR, CBD.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, CBD.ACCOUNT_CODE)
              GROUP BY CBD.GL_DATE 
                   , CBD.ACCOUNT_CODE
                   , AC.ACCOUNT_DESC
                   , CBD.CUSTOMER_ID
            ) SX1
      WHERE SC.SUPP_CUST_ID             = SX1.CUSTOMER_ID
        AND SC.SUPP_CUST_ID             = NVL(W_CUSTOMER_ID, SC.SUPP_CUST_ID)
        AND SC.SOB_ID                   = W_SOB_ID
      GROUP BY SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , SC.TAX_REG_NO
           , SX1.ACCOUNT_CODE
           , SX1.ACCOUNT_DESC
      ;
