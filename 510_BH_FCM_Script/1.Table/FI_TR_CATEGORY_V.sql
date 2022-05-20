CREATE OR REPLACE VIEW FI_TR_CATEGORY_V AS
SELECT FC.COMMON_ID AS TR_CATEGORY_ID
     , FC.GROUP_CODE
     , FC.CODE AS TR_CATEGORY
     , FC.CODE_NAME AS TR_CATEGORY_NAME
     , FC.VALUE1
     , FC.VALUE2
     , FC.VALUE3
     , FC.VALUE4
     , FC.VALUE5
     , FC.VALUE6
     , FC.VALUE7
     , FC.VALUE8
     , FC.VALUE9
     , FC.VALUE10
     , FC.DEFAULT_FLAG
     , FC.SORT_NUM
     , FC.DESCRIPTION
     , FC.ENABLED_FLAG
     , FC.EFFECTIVE_DATE_FR
     , FC.EFFECTIVE_DATE_TO
     , FC.SOB_ID
     , FC.ORG_ID
  FROM FI_COMMON_TLV FC
 WHERE FC.GROUP_CODE              = 'TR_CATEGORY';
