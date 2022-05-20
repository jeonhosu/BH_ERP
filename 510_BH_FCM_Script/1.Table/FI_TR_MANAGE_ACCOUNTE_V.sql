CREATE OR REPLACE VIEW FI_TR_MANAGE_ACCOUNTE_V AS
SELECT FC.COMMON_ID AS TR_MANAGE_ID
     , FC.GROUP_CODE
     , FC.CODE AS TR_MANAGE_CODE
     , FC.CODE_NAME AS TR_MANAGE_NAME
     , FC.VALUE1 AS ACCOUNT_CODE
     , FC.VALUE2 AS ACCOUNT_DESC
     , FC.VALUE3 AS TR_CATEGORY
     , FC.VALUE4 AS TR_CLASS
     , FC.VALUE5 AS TR_MANAGE_GROUP_CODE
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
 WHERE FC.GROUP_CODE              = 'TR_MANAGE_ACCOUNT';
