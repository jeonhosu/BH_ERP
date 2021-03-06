CREATE OR REPLACE VIEW HRM_INSPECTION_EXCEPT_V AS
SELECT HC.COMMON_ID AS ALL_INSPECTION_ADD_ID
     , HC.CODE AS PERSON_NUM
     , HC.CODE_NAME AS PERSON_NAME
     , HC.VALUE1
     , HC.VALUE2
     , HC.VALUE3
     , HC.VALUE4
     , HC.DEFAULT_FLAG
     , HC.SORT_NUM
     , HC.DESCRIPTION
     , HC.ENABLED_FLAG
     , HC.EFFECTIVE_DATE_FR
     , HC.EFFECTIVE_DATE_TO
     , HC.SOB_ID
     , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE              = 'ALL_INSPECTION_EXC';
