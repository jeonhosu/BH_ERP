SELECT COUNT(DISTINCT PM.PERSON_ID) AS PERSON_COUNT
     , PM.SEX_TYPE
     , MA.PAY_YYYYMM    
/*     , MA.PERSON_ID    
     , PM.NAME
     , MA.WAGE_TYPE
     , HRM_COMMON_G.ID_NAME_F(MA.ALLOWANCE_ID) AS ALLOWANCE_NAME*/
     , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
  FROM HRM_PERSON_MASTER PM
    , HRP_MONTH_ALLOWANCE MA
WHERE MA.PERSON_ID               = PM.PERSON_ID
  AND MA.CORP_ID                 = &W_CORP_ID
  AND MA.PAY_YYYYMM              = &W_PAY_YYYYMM
  AND MA.WAGE_TYPE               IN('P1', 'P2', 'P4')
  AND MA.SOB_ID                  = &W_SOB_ID
  AND MA.ORG_ID                  = &W_ORG_ID
  AND PM.PERSON_NUM              NOT IN ('11031803', '00021401', '00021402', '05071806', '11031802', '09030101')
  /*AND (MA.WAGE_TYPE              = 'P1' 
  AND MA.ALLOWANCE_ID            NOT IN ( SELECT HA.ALLOWANCE_ID
                                        FROM HRM_ALLOWANCE_V HA
                                      WHERE HA.SOB_ID        = 20
                                        AND HA.ORG_ID        = 201
                                        AND HA.ALLOWANCE_CODE = 'A18'
                                     ))*/
GROUP BY PM.SEX_TYPE
     , MA.PAY_YYYYMM
