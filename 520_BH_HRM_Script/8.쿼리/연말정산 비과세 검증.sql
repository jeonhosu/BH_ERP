SELECT  NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
            , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
            , NVL(HA.PERSON_ID, NULL)  AS PERSON_ID
            , NVL(PM.NAME, NULL)  AS NAME
            , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
            , CASE
                WHEN GROUPING(T1.DEPT_NAME) = 1 THEN PT_TOTAL_SUM
                ELSE TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
                     TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') 
              END AS APPLY_TERM
            , SUM( NVL(HA.INCOME_TOT_AMT, 0)) AS TAX_PAY_SUM
            , SUM( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계 
                   NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                   NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                   NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                   NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) + 
                   NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                   NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) + 
                   NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) + 
                   NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + 
                   NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + 
                   NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + 
                   NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + 
                   NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                   -- 종전-- 
                   NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계  
                   NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                   NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                   NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                   NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) + 
                   NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                   NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) + 
                   NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) + 
                   NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) + 
                   NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) + 
                   NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) + 
                   NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) + 
                   NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM
            
            , SUM((NVL(HA.NONTAX_SCH_EDU_AMT, 0) +
                                NVL(HA.NONTAX_MEMBER_AMT, 0) +
                                NVL(HA.NONTAX_GUARD_AMT, 0) +
                                NVL(HA.NONTAX_CHILD_AMT, 0) +
                                NVL(HA.NONTAX_HIGH_SCH_AMT, 0) +
                                NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                                NVL(HA.NONTAX_RESEARCH_AMT, 0) +
                                NVL(HA.NONTAX_COMPANY_AMT, 0) +
                                NVL(HA.NONTAX_COVER_AMT, 0) +
                                NVL(HA.NONTAX_WILD_AMT, 0) +
                                NVL(HA.NONTAX_DISASTER_AMT, 0) +
                                NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                                NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) +
                                NVL(HA.NONTAX_OUTS_WORK_1, 0) +
                                NVL(HA.NONTAX_OUTS_WORK_2, 0) +
                                NVL(HA.NONTAX_OUTSIDE_AMT, 0) +
                                NVL(HA.NONTAX_OT_AMT, 0) +
                                NVL(HA.NONTAX_BIRTH_AMT, 0) +
                                --NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                                --NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                                NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                                --NVL(HA.NONTAX_FOR_ENG_AMT, 0) +  -- 외국인 기술자(감면소득 계로 이동);
                                NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) +
                                NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0)))
                                        
            , SUM(NVL(HA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT  -- 원단위 절사 --
            , SUM(NVL(HA.FIX_LOCAL_TAX_AMT, 0)) AS FIX_LOCAL_TAX_AMT
            , SUM(NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_SP_TAX_AMT
            , SUM( NVL(HA.FIX_IN_TAX_AMT, 0) +
                   NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                   NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
                   
            , SUM(NVL(HA.PRE_IN_TAX_AMT, 0)) AS PRE_IN_TAX_AMT
            , SUM(NVL(HA.PRE_LOCAL_TAX_AMT, 0)) AS PRE_LOCAL_TAX_AMT
            , SUM(NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_SP_TAX_AMT
            , SUM( NVL(HA.PRE_IN_TAX_AMT, 0) +
                   NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                   NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM
                   
            , SUM(NVL(HA.SUBT_IN_TAX_AMT, 0)) AS SUBT_IN_TAX_AMT
            , SUM(NVL(HA.SUBT_LOCAL_TAX_AMT, 0)) AS SUBT_LOCAL_TAX_AMT
            , SUM(NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_SP_TAX_AMT
            , SUM( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                   NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                   NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
            
            , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE 
            , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(PM1.NAME, TO_CHAR(NULL)), NULL) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT  HA
           , HRM_PERSON_MASTER    PM
           , HRM_PERSON_MASTER    PM1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE  
                    , DM.DEPT_NAME
                    , DM.DEPT_SORT_NUM
                    , HL.POST_ID
                    , HP.POST_NAME
                    , HP.SORT_NUM AS POST_SORT_NUM                  
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID 
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME 
                    , HL.FLOOR_ID    
                    , HF.FLOOR_NAME
                    , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL  
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
                   , HRM_POST_CODE_V    HP
              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                AND HL.DEPT_ID              = DM.DEPT_ID
                AND HL.FLOOR_ID             = HF.FLOOR_ID
                AND HL.POST_ID              = HP.POST_ID
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= &V_SUBMIT_DATE_TO 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )
              ) T1
      WHERE HA.PERSON_ID        = PM.PERSON_ID 
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.TRANS_PERSON_ID  = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY        = &V_YEAR_YYYY
        AND ((&W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (&W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = &W_PERSON_ID)) 
        AND HA.SOB_ID           = &W_SOB_ID
        AND HA.ORG_ID           = &W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN &V_SUBMIT_DATE_FR AND &V_SUBMIT_DATE_TO
        AND PM.CORP_ID          = &W_CORP_ID
        AND PM.SOB_ID           = &W_SOB_ID
        AND PM.ORG_ID           = &W_ORG_ID
       /* AND ((W_DEPT_ID         IS NULL AND 1 = 1)
        OR   (W_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID        IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))*/
      GROUP BY ROLLUP
            ((T1.DEPT_CODE
           , T1.DEPT_NAME 
           , T1.FLOOR_NAME 
           , HA.PERSON_ID 
           , PM.NAME 
           , PM.PERSON_NUM 
           , HA.ADJUST_DATE_FR 
           , HA.ADJUST_DATE_TO 
           , PM.RETIRE_DATE
           , HA.TRANS_YN 
           , HA.TRANS_PAY_YYYYMM 
           , HA.TRANS_DATE 
           , PM1.NAME 
           ))
      ORDER BY T1.DEPT_CODE, HA.ADJUST_DATE_TO, PM.PERSON_NUM
      ;
