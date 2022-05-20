SELECT 'N' AS SELECT_YN
           , OM.WORK_DATE
           , OM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , T1.DEPT_NAME
           , T2.FLOOR_NAME
           , T1.POST_NAME
           , OM.OT_TYPE_ID
           , HRM_COMMON_G.ID_NAME_F(OM.OT_TYPE_ID) AS OT_TYPE_DESC
           , OM.OT_DATE_FR
           , OM.OT_DATE_TO
           , OM.DESCRIPTION 
           , OM.REJECT_YN
           , OM.REJECT_DESC
           , OM.STATUS_FLAG
           , HRM_COMMON_G.CODE_NAME_F('OT_TYPE_STATUS', OM.STATUS_FLAG, OM.SOB_ID, OM.ORG_ID) AS OT_TYPE_STATUS_DESC
        FROM HRD_OT_MANAGER    OM
           , HRM_PERSON_MASTER PM
           , (-- 시점 인사내역.
             SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_CODE
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , PC.POST_CODE                  
                  , PC.POST_NAME AS POST_NAME
                  , PC.SORT_NUM AS POST_SORT_NUM
                  , JC.JOB_CATEGORY_CODE
                  , JC.JOB_CATEGORY_NAME
                  , JC.SORT_NUM AS JOB_CATEGORY_SORT_NUM
               FROM HRM_HISTORY_HEADER HH
                  , HRM_HISTORY_LINE   HL
                  , HRM_DEPT_MASTER    DM
                  , HRM_POST_CODE_V    PC
                  , HRM_JOB_CATEGORY_CODE_V JC
             WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
               AND HL.DEPT_ID           = DM.DEPT_ID
               AND HL.POST_ID           = PC.POST_ID
               AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
               AND ((W_DEPT_ID          IS NULL AND 1 = 1)
                 OR (W_DEPT_ID          IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))         
               AND HL.HISTORY_LINE_ID  
                     IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                            FROM HRM_HISTORY_LINE S_HL
                          WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE_TO
                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                          GROUP BY S_HL.PERSON_ID
                        )
            ) T1
          , (-- 시점 인사내역.
              SELECT PH.PERSON_ID
                   , PH.FLOOR_ID
                   , PH.SOB_ID
                   , PH.ORG_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                FROM HRD_PERSON_HISTORY        PH
                   , HRM_FLOOR_V               HF
              WHERE PH.FLOOR_ID           = HF.FLOOR_ID
                AND ((W_FLOOR_ID          IS NULL AND 1 = 1)
                 OR (W_FLOOR_ID           IS NOT NULL AND PH.FLOOR_ID = W_FLOOR_ID))
                AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_FR
            ) T2
       WHERE OM.PERSON_ID               = PM.PERSON_ID
         AND PM.PERSON_ID               = T1.PERSON_ID
         AND PM.PERSON_ID               = T2.PERSON_ID
         AND PM.CORP_ID                 = &W_CORP_ID
         AND OM.WORK_DATE               >= CASE
                                             WHEN PM.JOIN_DATE > &W_WORK_DATE_FR THEN PM.JOIN_DATE
                                             ELSE &W_WORK_DATE_FR 
                                           END
         AND OM.WORK_DATE               <= CASE
                                             WHEN PM.RETIRE_DATE IS NULL THEN &W_WORK_DATE_TO
                                             WHEN PM.RETIRE_DATE < &W_WORK_DATE_TO THEN PM.RETIRE_DATE
                                             ELSE &W_WORK_DATE_TO
                                           END
         AND OM.STATUS_FLAG             = 'C'  -- 승인된 자료만 조회 --
         AND PM.SOB_ID                  = &W_SOB_ID
         AND PM.ORG_ID                  = &W_ORG_ID
         AND ((&W_PERSON_ID              IS NULL AND 1 = 1)
           OR (&W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = &W_PERSON_ID))
         AND PM.JOIN_DATE               <= &W_WORK_DATE_TO
         AND (PM.RETIRE_DATE            >= &W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL)
      ORDER BY OM.WORK_DATE
             , T1.JOB_CATEGORY_SORT_NUM
             , T1.DEPT_SORT_NUM
             , T2.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
             , PM.PERSON_NUM   
       ;     
