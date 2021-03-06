-- 년 기초.
SELECT 0 AS ROW_NUM
    , TO_DATE(&W_YEAR || '-01-01', 'YYYY-MM-DD') AS GL_DATE
    , 
  FROM FI_AGGREGATE FA
    , FI_ACCOUNT_CONTROL AC
WHERE FA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
  AND FA.PERIOD_NAME            = '2011-01'
  AND FA.ACCOUNT_CONTROL_ID     = 510
  AND FA.SOB_ID                 = 20 
/*  AND EXISTS ( SELECT 'X'
                FROM FI_ACCOUNT_CLASS_V ACV
               WHERE ACV.SOB_ID             = AC.SOB_ID
                 AND ACV.ACCOUNT_CLASS_ID   = AC.ACCOUNT_CLASS_ID
                 AND ACV.ACCOUNT_CLASS_TYPE = 'CASH'
             )*/
;

-- 전월까지 기초.
SELECT FA.ACCOUNT_CONTROL_ID
     , FA.ACCOUNT_CODE
     , FA.CURRENCY_CODE
     , FA.PERIOD_NAME
     , FA.PERIOD_DR_AMOUNT
     , FA.PERIOD_CR_AMOUNT
  FROM FI_AGGREGATE FA
    , FI_ACCOUNT_CONTROL AC
WHERE FA.ACCOUNT_CONTROL_ID     = AC.ACCOUNT_CONTROL_ID
  AND FA.PERIOD_NAME            BETWEEN '2011-01' AND '2011-02'
  AND FA.ACCOUNT_CONTROL_ID     = 510
  AND FA.SOB_ID                 = 20 
;
