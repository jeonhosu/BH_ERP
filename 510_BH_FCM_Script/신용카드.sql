SELECT CC.CARD_NUM
     , CC.CARD_NAME
     , CC.CARD_ENG_NAME
     , CC.CARD_TYPE_ID
     , FI_COMMON_G.ID_NAME_F(CC.CARD_TYPE_ID) AS CARD_TYPE_NAME
     , CC.CRAD_CORP_ID
     , FI_COMMON_G.ID_NAME_F(CC.CRAD_CORP_ID) AS CRAD_CORP_NAME     
     , CC.EXPIRE_DATE
     , CC.BANK_ID
     , FB.BANK_NAME
     , CC.BANK_ACCOUNT_ID
     , BA.BANK_ACCOUNT_NAME
     , BA.BANK_ACCOUNT_NUM
     , CC.LIMIT_AMOUNT
     , CC.CURRENCY_CODE
     , CC.CURRENCY_LIMIT_AMOUNT
     , CC.USE_PERSON_ID
     , HRM_PERSON_MASTER_G.NAME_F(CC.USE_PERSON_ID) AS USE_PERSON_NAME
     , CC.ISSU_DATE
     , CC.DUE_DATE
     , CC.CLOSE_DAY
     , CC.SETTLE_DAY
     , CC.REMARK
     , CC.ENABLED_FLAG
     , EAPP_USER_G.USER_NAME_F(CC.LAST_UPDATED_BY) AS LAST_UPDATED_PERSON
  FROM GL_CREDIT_CARD CC
     , FI_BANK FB
     , FI_BANK_ACCOUNT BA
 WHERE CC.BANK_ID               = FB.BANK_ID
   AND CC.BANK_ACCOUNT_ID       = BA.BANK_ACCOUNT_ID
   AND CC.CARD_NUM              = NVL(&W_CARD_NUM, CC.CARD_NUM)
   AND CC.SOB_ID                = &W_SOB_ID
   AND CC.ORG_ID                = &W_ORG_ID
   AND CC.USE_PERSON_ID         = NVL(&W_PERSON_ID, CC.USE_PERSON_ID)
  ;
