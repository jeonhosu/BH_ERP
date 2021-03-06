SELECT SX1.HEADER_CODE
     , SX1.HEADER_NAME
     , CASE
         WHEN SX1.THIS_L_AMOUNT < 0 THEN 
           CASE 
             WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999') || ')' 
             ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
           END
         ELSE TO_CHAR(ABS(SX1.THIS_L_AMOUNT), 'FM999,999,999,999')
       END AS THIS_L_AMOUNT
     , CASE
         WHEN SX1.THIS_RATE IS NULL THEN NULL
         ELSE TO_CHAR(SX1.THIS_RATE, 'FM990.00') || '%' 
       END AS THIS_RATE
     , CASE
         WHEN SX1.THIS_L_AMOUNT < 0 THEN 
           CASE 
             WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999') || ')' 
             ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
           END
         ELSE TO_CHAR(ABS(SX1.PREV_L_AMOUNT), 'FM999,999,999,999')
       END AS PREV_L_AMOUNT
     , CASE
         WHEN SX1.PREV_RATE IS NULL THEN NULL
         ELSE TO_CHAR(SX1.PREV_RATE, 'FM990.00') || '%'
       END AS PREV_RATE
     , CASE
         WHEN NVL(SX1.CHANGE_AMOUNT, 0) < 0 THEN 
           CASE 
             WHEN SX1.MINUS_SIGN_DISPLAY = '()' THEN '(' || TO_CHAR(ABS(CHANGE_AMOUNT), 'FM999,999,999,999') || ')' 
             ELSE SX1.MINUS_SIGN_DISPLAY || TO_CHAR(ABS(CHANGE_AMOUNT), 'FM999,999,999,999')
           END
         ELSE TO_CHAR(ABS(CHANGE_AMOUNT), 'FM999,999,999,999')
       END AS CHANGE_AMOUNT
     , CASE
         WHEN SX1.CHANGE_RATE IS NULL THEN NULL
         ELSE TO_CHAR(SX1.CHANGE_RATE, 'FM990.00') || '%'
       END AS CHANGE_RATE
  FROM (SELECT BB.HEADER_CODE
             , BB.HEADER_NAME
             , BB.SORT_SEQ
             , BB.THIS_L_AMOUNT AS THIS_L_AMOUNT
             , ROUND((BB.THIS_L_AMOUNT / CASE 
                                           WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN &V_THIS_11_SUM
                                           ELSE &V_THIS_14_SUM
                                         END) * 100, 2) AS THIS_RATE
             , BB.PREV_L_AMOUNT AS PREV_L_AMOUNT
             , ROUND((BB.PREV_L_AMOUNT / CASE 
                                           WHEN SUBSTR(BB.HEADER_CODE, 1, 1) = '1' THEN &V_PREV_11_SUM
                                           ELSE &V_PREV_14_SUM
                                         END) * 100, 2) AS PREV_RATE
             , BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT AS CHANGE_AMOUNT
             , CASE
                 WHEN BB.THIS_L_AMOUNT - BB.PREV_L_AMOUNT IS NULL THEN NULL
                 WHEN NVL(BB.PREV_L_AMOUNT, 0) = 0 THEN 0
                 ELSE ROUND((((NVL(BB.THIS_L_AMOUNT, 0) - NVL(BB.PREV_L_AMOUNT, 0))) / NVL(BB.PREV_L_AMOUNT, 0)) * 100, 2)  
               END AS CHANGE_RATE
             , FH.MINUS_SIGN_DISPLAY
          FROM FI_BALANCE_BS BB
            , FI_FORM_HEADER FH
        WHERE BB.HEADER_ID                = FH.FORM_HEADER_ID
          AND ((NVL(BB.THIS_L_AMOUNT, 0) + NVL(BB.PREV_L_AMOUNT, 0) <> 0)
              OR BB.ITEM_LEVEL            = 1)
       ) SX1
ORDER BY SX1.SORT_SEQ
;

SELECT *
  FROM GL_FISCAL_PERIOD FP
;

SELECT *
  FROM GL_FISCAL_CALENDAR FC
;

SELECT FY.FISCAL_COUNT
  FROM GL_FISCAL_YEAR FY
WHERE FY.FISCAL_YEAR              = '2009'
  AND FY.FISCAL_CALENDAR_ID       = FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(&W_SOB_ID)
;  
