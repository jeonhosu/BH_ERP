SELECT *
FROM (
      SELECT FC.COMMON_ID
          , DECODE(FC.GROUP_CODE, '-', FC.CODE, FC.GROUP_CODE) AS SORT_CODE
          , FC.GROUP_CODE
          , FC.CODE
          , FC.CODE_NAME
          , FC.CODE_LENGTH
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
      FROM FI_COMMON  FC
    WHERE FC.SOB_ID    = 10
      AND FC.ORG_ID    = 101
    ) X
    
ORDER BY X.SORT_CODE, X.GROUP_CODE  
;
