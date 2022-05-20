SELECT AC.ACCOUNT_CODE
     , AC.ACCOUNT_DESC
     , PX1.ASSET_DESC
     , PX1.BEGIN_AMOUNT
     , PX1.INCREASE_AMOUNT
     , PX1.DECREASE_AMOUNT
     , NVL(PX1.BEGIN_AMOUNT, 0) + NVL(PX1.INCREASE_AMOUNT, 0) - NVL(PX1.DECREASE_AMOUNT, 0) AS ENDING_AMOUNT
     , PX1.BEGIN_DPR_AMOUNT
     , PX1.INCREASE_DPR_AMOUNT
     , PX1.DECREASE_DPR_AMOUNT
     , PX1.NOT_DPR_AMOUNT
  FROM FI_ASSET_CATEGORY FAC
     , FI_ACCOUNT_CONTROL AC
     , (SELECT AM.ASSET_CODE
             , AM.ASSET_DESC
             , CASE
                 WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < &W_PERIOD_FR THEN AM.AMOUNT + NVL(SX1.CE_BEGIN_AMOUNT, 0)
                 ELSE 0
               END - 
               CASE
                 WHEN AM.DISUSE_DATE IS NOT NULL AND TO_CHAR(AM.DISUSE_DATE, 'YYYY-MM') < &W_PERIOD_FR THEN NVL(AM.AMOUNT, 0) + NVL(SX1.CE_BEGIN_AMOUNT, 0)
                 ELSE 0 
               END AS BEGIN_AMOUNT   -- 기초가액.
             , CASE
                 WHEN TO_CHAR(AM.ACQUIRE_DATE, 'YYYY-MM') < &W_PERIOD_FR THEN NVL(SX1.CE_INCREASE_AMOUNT, 0)
                 ELSE NVL(AM.AMOUNT, 0) + NVL(SX1.CE_INCREASE_AMOUNT, 0)
               END AS INCREASE_AMOUNT  -- 당기증가액.                         
             , CASE
                 WHEN AM.DISUSE_DATE IS NOT NULL AND TO_CHAR(AM.DISUSE_DATE, 'YYYY-MM') >= &W_PERIOD_FR THEN AM.AMOUNT + NVL(SX1.CE_BEGIN_AMOUNT, 0) + NVL(SX1.CE_INCREASE_AMOUNT, 0)
                 ELSE 0 
               END AS DECREASE_AMOUNT  -- 당기 감소액.
             , NVL(SX2.BEGIN_DPR_AMOUNT, 0) AS BEGIN_DPR_AMOUNT
             , NVL(SX3.INCREASE_DPR_AMOUNT, 0) AS INCREASE_DPR_AMOUNT
             , NVL(SX4.DECREASE_DPR_AMOUNT, 0) AS DECREASE_DPR_AMOUNT
             , NVL(SX5.NOT_DPR_AMOUNT, 0) AS NOT_DPR_AMOUNT
             , AM.ASSET_CATEGORY_ID
             , AM.SOB_ID
          FROM FI_ASSET_MASTER AM
            , ( -- 자본적 지출 금액.
              SELECT AH.ASSET_ID
                   , AH.SOB_ID
                   , SUM(CASE 
                           WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < &W_PERIOD_FR THEN AH.AMOUNT
                           ELSE 0
                         END) AS CE_BEGIN_AMOUNT
                   , SUM(CASE 
                           WHEN TO_CHAR(AH.CHARGE_DATE, 'YYYY-MM') < &W_PERIOD_FR THEN 0
                           ELSE AH.AMOUNT
                         END) AS CE_INCREASE_AMOUNT
                FROM FI_ASSET_HISTORY AH
              WHERE AH.SOB_ID                   = &W_SOB_ID
                AND EXISTS ( SELECT 'X'
                               FROM FI_COMMON FC
                             WHERE FC.GROUP_CODE  = 'ASSET_CHARGE'
                               AND FC.SOB_ID      = &W_SOB_ID
                               AND FC.CODE        = '10'
                               AND FC.COMMON_ID   = AH.CHARGE_ID
                           )
              GROUP BY AH.ASSET_ID
                   , AH.SOB_ID
              ) SX1
            , (-- 전기 충당금 누계액.
              SELECT ADH.ASSET_ID
                   , ADH.ASSET_CATEGORY_ID
                   , ADH.SOB_ID
                   , MAX(ADH.DPR_SUM_AMOUNT) AS BEGIN_DPR_AMOUNT
                FROM FI_ASSET_DPR_HISTORY ADH
              WHERE ADH.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TO_DATE(&W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
                AND ADH.DPR_TYPE                = &W_DPR_TYPE
                AND ADH.SOB_ID                  = &W_SOB_ID
              GROUP BY ADH.ASSET_ID
                   , ADH.ASSET_CATEGORY_ID
                   , ADH.SOB_ID  
              ) SX2
            , (-- 당기 감가상각비.
              SELECT ADH.ASSET_ID
                   , ADH.ASSET_CATEGORY_ID
                   , ADH.SOB_ID
                   , SUM(ADH.DPR_AMOUNT) AS INCREASE_DPR_AMOUNT
                FROM FI_ASSET_DPR_HISTORY ADH
              WHERE ADH.PERIOD_NAME             BETWEEN &W_PERIOD_FR AND &W_PERIOD_TO
                AND ADH.DPR_TYPE                = &W_DPR_TYPE
                AND ADH.SOB_ID                  = &W_SOB_ID
              GROUP BY ADH.ASSET_ID
                   , ADH.ASSET_CATEGORY_ID
                   , ADH.SOB_ID
              ) SX3
            , ( -- 폐기/매각 금액.
              SELECT ADH.ASSET_ID
                   , ADH.SOB_ID
                   , NVL(SUM(ADH.DPR_AMOUNT), 0) AS DECREASE_DPR_AMOUNT
                FROM FI_ASSET_DPR_HISTORY ADH
              WHERE ADH.SOB_ID                  = &W_SOB_ID
                AND ADH.DPR_TYPE                = &W_DPR_TYPE
                AND EXISTS ( SELECT 'X'
                               FROM FI_ASSET_HISTORY AH
                                 , FI_COMMON FC
                             WHERE AH.CHARGE_ID   = FC.COMMON_ID
                               AND AH.SOB_ID      = FC.SOB_ID
                               AND AH.ASSET_ID    = ADH.ASSET_ID
                               AND AH.SOB_ID      = ADH.SOB_ID
                               AND FC.GROUP_CODE  = 'ASSET_CHARGE'
                               AND FC.CODE        IN('90', '91')
                               AND FC.COMMON_ID   = AH.CHARGE_ID
                           )
              GROUP BY ADH.ASSET_ID
                   , ADH.SOB_ID
              ) SX4   
            , (--  미상각잔액.
              SELECT ADH.ASSET_ID
                   , ADH.SOB_ID
                   , ADH.UN_DPR_REMAIN_AMOUNT AS NOT_DPR_AMOUNT
                FROM FI_ASSET_DPR_HISTORY ADH
              WHERE ADH.PERIOD_NAME             = &W_PERIOD_TO
                AND ADH.DPR_TYPE                = &W_DPR_TYPE
                AND ADH.SOB_ID                  = &W_SOB_ID
              ) SX5  
        WHERE AM.ASSET_ID                 = SX1.ASSET_ID(+)
          AND AM.SOB_ID                   = SX1.SOB_ID(+)
          AND AM.ASSET_ID                 = SX2.ASSET_ID(+)
          AND AM.SOB_ID                   = SX2.SOB_ID(+)
          AND AM.ASSET_ID                 = SX3.ASSET_ID(+)
          AND AM.SOB_ID                   = SX3.SOB_ID(+)
          AND AM.ASSET_ID                 = SX4.ASSET_ID(+)
          AND AM.SOB_ID                   = SX4.SOB_ID(+)
          AND AM.ASSET_ID                 = SX5.ASSET_ID(+)
          AND AM.SOB_ID                   = SX5.SOB_ID(+)
          AND AM.SOB_ID                   = &W_SOB_ID
          AND AM.EXPENSE_TYPE             = NVL(&W_EXPENSE_TYPE, AM.EXPENSE_TYPE)
          AND AM.ACQUIRE_DATE             <= LAST_DAY(TO_DATE(&W_PERIOD_TO, 'YYYY-MM'))
       ) PX1   
WHERE FAC.AST_ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
  AND FAC.ASSET_CATEGORY_ID       = PX1.ASSET_CATEGORY_ID
  AND FAC.SOB_ID                  = PX1.SOB_ID
  AND FAC.ASSET_TYPE              = NVL(&W_ASSET_TYPE, FAC.ASSET_TYPE)
;     

-- 전기 충당금 누계액.
SELECT ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID
     , MAX(ADH.DPR_SUM_AMOUNT) AS DPR_BEGIN_AMOUNT
  FROM FI_ASSET_DPR_HISTORY ADH
WHERE ADH.PERIOD_NAME             = TO_CHAR(ADD_MONTHS(TO_DATE(&W_PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')
  AND ADH.DPR_TYPE                = &W_DPR_TYPE
  AND ADH.SOB_ID                  = &W_SOB_ID
  AND ADH.ASSET_ID              = 61
GROUP BY ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID  
;

-- 당기 감가상각비.
SELECT ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID
     , SUM(ADH.DPR_AMOUNT) DPR_AMOUNT
  FROM FI_ASSET_DPR_HISTORY ADH
WHERE ADH.PERIOD_NAME             BETWEEN &W_PERIOD_FR AND &W_PERIOD_TO
  AND ADH.DPR_TYPE                = &W_DPR_TYPE
  AND ADH.SOB_ID                  = &W_SOB_ID
  AND ADH.ASSET_ID              = 61
GROUP BY ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID  
;

-- 당기 감가상각비.
SELECT ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID
     , SUM(ADH.DPR_AMOUNT) DPR_AMOUNT
  FROM FI_ASSET_DPR_HISTORY ADH
WHERE ADH.PERIOD_NAME             BETWEEN &W_PERIOD_FR AND &W_PERIOD_TO
  AND ADH.DPR_TYPE                = &W_DPR_TYPE
  AND ADH.SOB_ID                  = &W_SOB_ID
  AND ADH.ASSET_ID              = 61
GROUP BY ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID  
;


--  미상각잔액.
SELECT ADH.ASSET_ID
     , ADH.ASSET_CATEGORY_ID
     , ADH.SOB_ID
     , ADH.UN_DPR_REMAIN_AMOUNT
  FROM FI_ASSET_DPR_HISTORY ADH
WHERE ADH.PERIOD_NAME             = &W_PERIOD_TO
  AND ADH.DPR_TYPE                = &W_DPR_TYPE
  AND ADH.SOB_ID                  = &W_SOB_ID
  AND ADH.ASSET_ID              = 61
;



SELECT *
  FROM FI_ASSET_MASTER X
WHERE X.ASSET_ID       = 61
;
