
SELECT HC.COMMON_ID
    , HC.CODE
    , HC.CODE_NAME
    , HC.VALUE1
    , HC.VALUE2
    , HC.VALUE3
    , HC.VALUE4
    , HC.VALUE5
    , HC.VALUE6
    , HC.VALUE7
    , HC.USABLE
    , HC.START_DATE
    , HC.END_DATE
FROM HRM_COMMON HC
WHERE EXISTS ( SELECT 'X'
                              FROM HRM_COMMON S_HC
                              WHERE S_HC.GROUP_CODE                   = 'HM001'
                                AND S_HC.VALUE1                                 = 'NATION'
                                AND S_HC.CODE                                   = HC.GROUP_CODE
                                AND S_HC.USABLE                               = 'Y'
                                AND S_HC.START_DATE                       <= TRUNC(SYSDATE)
                                AND (S_HC.END_DATE IS NULL OR S_HC.END_DATE >= TRUNC(SYSDATE))
                              )
