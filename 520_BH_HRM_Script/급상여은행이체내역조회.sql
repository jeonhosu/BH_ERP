SELECT MP.PERSON_ID
     , PM.NAME
     , PM.DEPT_CODE
     , PM.DEPT_NAME
     , PG.PAY_GRADE
     , PG.PAY_GRADE_NAME
     , SX1.BANK_NAME
     , SX1.BANK_ACCOUNTS
     , MP.REAL_AMOUNT     -- 실지급액.
  FROM HRP_MONTH_PAYMENT MP
    , HRM_PERSON_MASTER_TLV PM
    , HRM_PAY_GRADE_V PG
    , (-- 급여 마스터.
        SELECT PMH.PERSON_ID
             , PMH.PAY_GRADE_ID
             , PMH.BANK_ID
             , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
             , PMH.BANK_ACCOUNTS     
          FROM HRP_PAY_MASTER_HEADER PMH
         WHERE PMH.CORP_ID                = &W_CORP_ID
           AND PMH.SOB_ID                 = &W_SOB_ID
           AND PMH.ORG_ID                 = &W_ORG_ID
           AND PMH.START_YYYYMM           <= &W_PAY_YYYYMM
           AND PMH.END_YYYYMM             >= &W_PAY_YYYYMM
       ) SX1
 WHERE MP.PERSON_ID               = PM.PERSON_ID
   AND PM.PAY_GRADE_ID            = PG.PAY_GRADE_ID
   AND MP.PERSON_ID               = SX1.PERSON_ID
   AND MP.PAY_YYYYMM              = &W_PAY_YYYYMM
   AND MP.WAGE_TYPE               = &W_WAGE_TYPE
   AND MP.CORP_ID                 = &W_CORP_ID
   AND MP.DEPT_ID                 = NVL(&W_DEPT_ID, MP.DEPT_ID)
   AND MP.PAY_GRADE_ID            = NVL(&W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
   AND MP.SOB_ID                  = &W_SOB_ID
   AND MP.ORG_ID                  = &W_ORG_ID
ORDER BY PM.DEPT_CODE, PG.PAY_GRADE, PM.PERSON_ID   
;   
