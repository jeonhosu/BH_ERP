CREATE OR REPLACE VIEW HRM_FLOOR_V AS
SELECT HC.COMMON_ID AS FLOOR_ID
     , HC.GROUP_CODE
     , HC.CODE AS FLOOR_CODE
     , HC.CODE_NAME AS FLOOR_NAME
     , TO_NUMBER(REPLACE(NVL(HC.VALUE1, '0'), ',', '.'), '999999999', 'NLS_NUMERIC_CHARACTERS=,.') AS TO_COUNT
     , HC.VALUE2 AS COSTCENTER_CODE
     , HC.VALUE3 AS MES_WORK_CENTER_CODE
     , HC.VALUE4 AS FACTORY_TYPE
     , HC.VALUE5
     , HC.VALUE6
     , HC.VALUE7
     , HC.VALUE8
     , HC.VALUE9
     , HC.VALUE10
     , HC.DEFAULT_FLAG
     , HC.SORT_NUM
     , HC.DESCRIPTION
     , HC.ENABLED_FLAG
     , HC.EFFECTIVE_DATE_FR
     , HC.EFFECTIVE_DATE_TO
     , HC.SOB_ID
     , HC.ORG_ID
  FROM HRM_COMMON_TLV HC
 WHERE HC.GROUP_CODE            = 'FLOOR';
