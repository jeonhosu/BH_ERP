CREATE OR REPLACE VIEW EAPP_LOOKUP_ENTRY_TLV
AS
SELECT LE.LOOKUP_ENTRY_ID
     , LE.SOB_ID
		 , LE.ORG_ID
		 , LE.LOOKUP_TYPE_ID
		 , LE.LOOKUP_LEVEL
		 , LE.LOOKUP_MODULE
		 , LE.LOOKUP_TYPE
		 , LE.ENTRY_CODE
		 , NVL(LET.ENTRY_DESCRIPTION, LE.ENTRY_DESCRIPTION) ENTRY_DESCRIPTION
		 , NVL(LET.ENTRY_TAG, LE.ENTRY_TAG) ENTRY_TAG
		 , LE.DEFAULT_FLAG
		 , LE.EFFECTIVE_DATE_FR
		 , LE.EFFECTIVE_DATE_TO
		 , LE.ENABLED_FLAG
		 , NVL(LET.ATTRIBUTE_A, LE.ATTRIBUTE_A) ATTRIBUTE_A
		 , NVL(LET.ATTRIBUTE_B, LE.ATTRIBUTE_B) ATTRIBUTE_B
		 , NVL(LET.ATTRIBUTE_C, LE.ATTRIBUTE_C) ATTRIBUTE_C
		 , NVL(LET.ATTRIBUTE_D, LE.ATTRIBUTE_D) ATTRIBUTE_D
		 , NVL(LET.ATTRIBUTE_E, LE.ATTRIBUTE_E) ATTRIBUTE_E
		 , NVL(LET.ATTRIBUTE_1, LE.ATTRIBUTE_1) ATTRIBUTE_1
		 , NVL(LET.ATTRIBUTE_2, LE.ATTRIBUTE_2) ATTRIBUTE_2
		 , NVL(LET.ATTRIBUTE_3, LE.ATTRIBUTE_3) ATTRIBUTE_3
		 , NVL(LET.ATTRIBUTE_4, LE.ATTRIBUTE_4) ATTRIBUTE_4
		 , NVL(LET.ATTRIBUTE_5, LE.ATTRIBUTE_5) ATTRIBUTE_5		 
  FROM EAPP_LOOKUP_ENTRY LE
    , EAPP_LOOKUP_ENTRY_TL LET
 WHERE LE.LOOKUP_ENTRY_ID         = LET.LOOKUP_ENTRY_ID(+)
   AND LET.LANG_CODE(+)           = USERENV_G.GET_TERRITORY_S_F
;	 
		
