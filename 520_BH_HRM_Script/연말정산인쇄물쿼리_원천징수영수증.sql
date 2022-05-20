SELECT PM.NAME
     , PM.RESIDENT_TYPE
     , PM.NATIONALITY_TYPE
     , PM.HOUSEHOLD_TYPE
     , PM.FOREIGN_TAX_YN
     , CASE
         WHEN PM.RETIRE_DATE IS NULL THEN '계속근로'
         ELSE '중도퇴사'
       END AS WORK_KEEP_TYPE
     , PM.RESIDENT_TYPE
     , PM.REPRE_NUM
     , PM.PRSN_ADDR1 || ' ' || PM.PRSN_ADDR2 AS PERSON_ADDRESS
     , CM.CORP_NAME
     , CM.PRESIDENT_NAME
     , HOU.VAT_NUMBER
     , HOU.ORG_ADDRESS
     -- 근무처별 소득명세 : 주(현).
     , CM.CORP_NAME AS WORK_CORP_NAME
     , HOU.VAT_NUMBER AS WORK_VAT_NUMBER
     , YA.ADJUST_DATE_FR || '~' || YA.ADJUST_DATE_TO AS ADJUST_DATE
     , NULL AS REDUCE_DATE
     , YA.NOW_PAY_TOT_AMT
     , YA.NOW_BONUS_TOT_AMT
     , YA.NOW_ADD_BONUS_AMT
     , YA.NOW_STOCK_BENE_AMT
     , NULL AS OWNERSHIP_AMT
     , NVL(YA.NOW_PAY_TOT_AMT, 0) + NVL(YA.NOW_BONUS_TOT_AMT, 0) + NVL(YA.NOW_ADD_BONUS_AMT, 0) + NVL(YA.NOW_STOCK_BENE_AMT, 0) AS NOW_TOTAL_AMOUNT
     
     -- 근무처별 소득명세 : 종(전).
     , PW1.COMPANY_NAME AS PW_COMPANY_NAME1
     , PW1.COMPANY_NUM AS PW_COMPANY_NUM1
     
     -- 비과세소득 : 주(현).
     , YA.NONTAX_OUTSIDE_AMT
     , YA.NONTAX_OT_AMT
     , YA.NONTAX_BIRTH_AMT
     , YA.NONTAX_FOREIGNER_AMT
     , NVL(YA.NONTAX_OUTSIDE_AMT, 0) + NVL(YA.NONTAX_OT_AMT, 0) + NVL(YA.NONTAX_BIRTH_AMT, 0) + NVL(YA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_TOTAL_AMOUNT
     , NULL AS REDUCE_TOTAL_AMOUNT
     
     -- 세액명세 : 주(현).
     , YA.FIX_IN_TAX_AMT
     , YA.FIX_LOCAL_TAX_AMT
     , YA.FIX_SP_TAX_AMT
     , NVL(YA.FIX_IN_TAX_AMT, 0) + NVL(YA.FIX_LOCAL_TAX_AMT, 0) + NVL(YA.FIX_SP_TAX_AMT, 0) AS FIX_TAX_AMOUNT
     
     -- 세액명세 : 종(전)1 근무지.
     , PW1.COMPANY_NUM AS PW_COMPANY_NUM1
     , PW1.IN_TAX_AMT AS PW_IN_TAX_AMT1
     , PW1.LOCAL_TAX_AMT AS PW_LOCAL_TAX_AMT1
     , PW1.SP_TAX_AMT AS PW_SP_TAX_AMT1
     , NVL(PW1.IN_TAX_AMT, 0) + NVL(PW1.LOCAL_TAX_AMT, 0) + NVL(PW1.SP_TAX_AMT, 0) AS PW_TOTAL_TAX_AMT1
     
     -- 세액명세 : 종(전)2 근무지.
     , PW2.COMPANY_NUM AS PW_COMPANY_NUM2
     , PW2.IN_TAX_AMT AS PW_IN_TAX_AMT2
     , PW2.LOCAL_TAX_AMT AS PW_LOCAL_TAX_AMT2
     , PW2.SP_TAX_AMT AS PW_SP_TAX_AMT2
     , NVL(PW2.IN_TAX_AMT, 0) + NVL(PW2.LOCAL_TAX_AMT, 0) + NVL(PW2.SP_TAX_AMT, 0) AS PW_TOTAL_TAX_AMT2
     
     -- 주(현)근무지.
     , NVL(YA.PRE_IN_TAX_AMT, 0) -  NVL(PW1.IN_TAX_AMT, 0) -  NVL(PW2.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
     , NVL(YA.PRE_LOCAL_TAX_AMT, 0) - NVL(PW1.LOCAL_TAX_AMT, 0) - NVL(PW2.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
     , NVL(YA.PRE_SP_TAX_AMT, 0) - NVL(PW1.SP_TAX_AMT, 0) - NVL(PW2.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
     , NVL(YA.PRE_IN_TAX_AMT, 0) + NVL(YA.PRE_LOCAL_TAX_AMT, 0) + NVL(YA.PRE_SP_TAX_AMT, 0)
       - NVL(PW1.IN_TAX_AMT, 0) + NVL(PW1.LOCAL_TAX_AMT, 0) + NVL(PW1.SP_TAX_AMT, 0)
       - NVL(PW2.IN_TAX_AMT, 0) + NVL(PW2.LOCAL_TAX_AMT, 0) + NVL(PW2.SP_TAX_AMT, 0) AS PRE_TAX_AMOUNT
     
     -- 차감징수세액.
     , YA.SUBT_IN_TAX_AMT
     , YA.SUBT_LOCAL_TAX_AMT
     , YA.SUBT_SP_TAX_AMT
     , NVL(YA.SUBT_IN_TAX_AMT, 0) + NVL(YA.SUBT_LOCAL_TAX_AMT, 0) + NVL(YA.SUBT_SP_TAX_AMT, 0) AS SUBT_TAX_AMOUNT
  FROM HRM_PERSON_MASTER PM
    , HRA_YEAR_ADJUSTMENT YA
    , HRM_CORP_MASTER CM
    , ( SELECT OU.CORP_ID
             , OU.PRESIDENT_NAME
             , OU.VAT_NUMBER
             , OU.ADDR1 || OU.ADDR2 AS ORG_ADDRESS
             , OU.SOB_ID
             , OU.ORG_ID
          FROM HRM_OPERATING_UNIT OU
        WHERE OU.SOB_ID           = &W_SOB_ID
          AND OU.ORG_ID     = &W_ORG_ID
          AND OU.DEFAULT_FLAG     = 'Y'
      ) HOU
    , ( -- 종(전) 근무지1 --
        SELECT PW.YEAR_YYYY
             , PW.SOB_ID
             , PW.ORG_ID
             , PW.PERSON_ID
             , PW.COMPANY_NAME
             , PW.COMPANY_NUM
             , PW.JOIN_DATE
             , PW.RETR_DATE
             , PW.PAY_TOTAL_AMT
             , PW.BONUS_TOTAL_AMT
             , PW.ADD_BONUS_AMT
             , PW.STOCK_BENE_AMT
             , PW.NT_OUTSIDE_AMT                      -- 국외근로.
             , PW.NT_OT_AMT                           -- 야간근로.
             , PW.NT_BIRTH_AMT                        -- 출생/보육수당.
             , PW.NT_FOREIGNER_AMT                    -- 외국인 근로자.
             , PW.IN_TAX_AMT
             , PW.LOCAL_TAX_AMT
             , PW.SP_TAX_AMT
          FROM HRA_PREVIOUS_WORK PW
        WHERE PW.YEAR_YYYY        = &W_YEAR_YYYY
          AND PW.SOB_ID           = &W_SOB_ID
          AND PW.ORG_ID           = &W_ORG_ID
          AND PW.PERSON_ID        = NVL(&W_PERSON_ID, PW.PERSON_ID)
          AND PW.SEQ_NUM          = 1
      ) PW1
    , ( -- 종(전) 근무지2 --
        SELECT PW.YEAR_YYYY
             , PW.SOB_ID
             , PW.ORG_ID
             , PW.PERSON_ID
             , PW.COMPANY_NAME
             , PW.COMPANY_NUM
             , PW.JOIN_DATE
             , PW.RETR_DATE
             , PW.PAY_TOTAL_AMT
             , PW.BONUS_TOTAL_AMT
             , PW.ADD_BONUS_AMT
             , PW.STOCK_BENE_AMT
             , PW.NT_OUTSIDE_AMT                      -- 국외근로.
             , PW.NT_OT_AMT                           -- 야간근로.
             , PW.NT_BIRTH_AMT                        -- 출생/보육수당.
             , PW.NT_FOREIGNER_AMT                    -- 외국인 근로자.
             , PW.IN_TAX_AMT
             , PW.LOCAL_TAX_AMT
             , PW.SP_TAX_AMT
          FROM HRA_PREVIOUS_WORK PW
        WHERE PW.YEAR_YYYY        = &W_YEAR_YYYY
          AND PW.SOB_ID           = &W_SOB_ID
          AND PW.ORG_ID           = &W_ORG_ID
          AND PW.PERSON_ID        = NVL(&W_PERSON_ID, PW.PERSON_ID)
          AND PW.SEQ_NUM          = 2
      ) PW2
WHERE PM.PERSON_ID                = YA.PERSON_ID
  AND PM.CORP_ID                  = CM.CORP_ID
  AND CM.CORP_ID                  = HOU.CORP_ID(+)
  AND YA.YEAR_YYYY                = PW1.YEAR_YYYY(+)
  AND YA.PERSON_ID                = PW1.PERSON_ID(+)
  AND YA.YEAR_YYYY                = PW2.YEAR_YYYY(+)
  AND YA.PERSON_ID                = PW2.PERSON_ID(+)
  AND PM.CORP_ID                  = &W_CORP_ID
  AND PM.PERSON_ID                = NVL(&W_PERSON_ID, PM.PERSON_ID)
  AND PM.DEPT_ID                  = NVL(&W_DEPT_ID, PM.DEPT_ID)
  AND PM.SOB_ID                   = &W_SOB_ID
  AND PM.ORG_ID                   = &W_ORG_ID
  AND YA.CORP_ID                  = &W_CORP_ID
  AND YA.YEAR_YYYY                = &W_YEAR_YYYY
  AND YA.SOB_ID                   = &W_SOB_ID
  AND YA.ORG_ID                   = &W_ORG_ID
  
;
