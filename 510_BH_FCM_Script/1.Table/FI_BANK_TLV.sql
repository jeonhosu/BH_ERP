CREATE OR REPLACE VIEW FI_BANK_TLV AS
SELECT   T.BANK_ID
      ,	 T.SOB_ID
      ,	 T.ORG_ID
      ,	 T.BANK_CODE
      ,	 NVL(TL.BANK_NAME, T.BANK_NAME) AS BANK_NAME
      ,  T.BANK_ENG_NAME
      ,  T.BANK_TYPE
      ,  FI_COMMON_G.CODE_NAME_F('BANK_TYPE', T.BANK_TYPE, T.SOB_ID, T.ORG_ID) AS BANK_TYPE_NAME
      ,  T.VAT_NUMBER
      ,  T.DC_LIMIT_AMOUNT
      ,  T.DC_METHOD_ID
      ,  FI_COMMON_G.ID_NAME_F(T.DC_METHOD_ID) AS DC_METHOD_NAME
      ,  T.DC_RATE1
      ,  T.DC_RATE2
      ,  T.LOAN_LIMIT_AMOUNT
      ,  T.START_DATE
      ,  NVL(TL.REMARK, T.REMARK) AS REMARK
     -- ,	 T.COUNTRY_CODE
      ,	 T.EFFECTIVE_DATE_FR
      ,	 T.EFFECTIVE_DATE_TO
      ,	 T.ENABLED_FLAG
      ,  NVL(TL.ATTRIBUTE_A, T.ATTRIBUTE_A) AS ATTRIBUTE_A
      ,  NVL(TL.ATTRIBUTE_B, T.ATTRIBUTE_B) AS ATTRIBUTE_B
      ,  NVL(TL.ATTRIBUTE_C, T.ATTRIBUTE_C) AS ATTRIBUTE_C
      ,  NVL(TL.ATTRIBUTE_D, T.ATTRIBUTE_D) AS ATTRIBUTE_D
      ,  NVL(TL.ATTRIBUTE_E, T.ATTRIBUTE_E) AS ATTRIBUTE_E
      ,  NVL(TL.ATTRIBUTE_1, T.ATTRIBUTE_1) AS ATTRIBUTE_1
      ,  NVL(TL.ATTRIBUTE_2, T.ATTRIBUTE_2) AS ATTRIBUTE_2
      ,  NVL(TL.ATTRIBUTE_3, T.ATTRIBUTE_3) AS ATTRIBUTE_3
      ,  NVL(TL.ATTRIBUTE_4, T.ATTRIBUTE_4) AS ATTRIBUTE_4
      ,  NVL(TL.ATTRIBUTE_5, T.ATTRIBUTE_5) AS ATTRIBUTE_5
      ,  T.CREATION_DATE
      ,  T.CREATED_BY
      ,  T.LAST_UPDATE_DATE
      ,  T.LAST_UPDATED_BY
   FROM FI_BANK              T
      , FI_BANK_TL           TL
  WHERE TL.BANK_ID(+)        = T.BANK_ID
    AND TL.LANG_CODE(+)      = USERENV_G.GET_TERRITORY_S_F
    AND T.BANK_GROUP         <> '-';