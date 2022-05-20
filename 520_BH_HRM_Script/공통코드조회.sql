SELECT *
FROM (
      SELECT HC.COMMON_ID
          , DECODE(HC.GROUP_CODE, '-', HC.CODE, HC.GROUP_CODE) AS SORT_CODE
          , HC.GROUP_CODE
          , HC.CODE
          , HC.CODE_NAME
          , HC.CODE_LENGTH
          , HC.VALUE1
          , HC.VALUE2
          , HC.VALUE3
          , HC.VALUE4
          , HC.VALUE5
          , HC.VALUE6
          , HC.VALUE7
          , HC.VALUE8
          , HC.VALUE9
          , HC.VALUE10
      FROM HRM_COMMON  HC
    WHERE HC.SOB_ID    = 20
      AND HC.ORG_ID    = 201
    ) X
    
ORDER BY X.SORT_CODE, X.GROUP_CODE  
;
