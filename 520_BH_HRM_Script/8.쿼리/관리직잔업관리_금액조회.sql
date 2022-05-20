SELECT PM.PERSON_ID
     , PM.PERSON_NUM
     , PM.NAME
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , T1.DEPT_CODE
     , T1.DEPT_NAME
     , T1.POST_CODE
     , T1.POST_NAME
     , T1.JOB_CATEGORY_NAME
     , T2.FLOOR_NAME
     , OM.OT_TYPE_ID
     , OTG.OT_TYPE_CODE
     , OTG.*
    
     , CASE T1.POST_CODE
         WHEN '510' THEN OTG.POST_510
         WHEN '430' THEN OTG.POST_430
         WHEN '410' THEN OTG.POST_410
         WHEN '330' THEN OTG.POST_330
         WHEN '320' THEN OTG.POST_320
         WHEN '310' THEN OTG.POST_310     
       END AS OT_AMOUNT
  FROM HRM_PERSON_MASTER PM
     , HRD_OT_MANAGER    OM
     , HRM_OT_TYPE_GW_V  OTG
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
         AND ((&W_DEPT_ID          IS NULL AND 1 = 1)
           OR (&W_DEPT_ID          IS NOT NULL AND HL.DEPT_ID = &W_DEPT_ID))         
         AND HL.HISTORY_LINE_ID  
               IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                    WHERE S_HL.CHARGE_DATE            <= &W_WORK_DATE_TO
                      AND S_HL.PERSON_ID              = HL.PERSON_ID
                    GROUP BY S_HL.PERSON_ID
                  )
      ) T1
    , (-- 시점 인사내역.
        SELECT PH.PERSON_ID
             , PH.FLOOR_ID
             , HF.FLOOR_CODE
             , HF.FLOOR_NAME
             , HF.SORT_NUM AS FLOOR_SORT_NUM
          FROM HRD_PERSON_HISTORY        PH
             , HRM_FLOOR_V               HF
        WHERE PH.FLOOR_ID           = HF.FLOOR_ID
          AND ((&W_FLOOR_ID          IS NULL AND 1 = 1)
           OR (&W_FLOOR_ID           IS NOT NULL AND PH.FLOOR_ID = &W_FLOOR_ID))
          AND PH.EFFECTIVE_DATE_FR  <=  &W_WORK_DATE_TO
          AND PH.EFFECTIVE_DATE_TO  >=  &W_WORK_DATE_FR
      ) T2
 WHERE PM.PERSON_ID               = OM.PERSON_ID
   AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
   AND PM.PERSON_ID               = T1.PERSON_ID
   AND PM.PERSON_ID               = T2.PERSON_ID
   AND PM.WORK_CORP_ID            = &W_WORK_CORP_ID
   AND ((&W_CORP_ID                IS NULL AND 1 = 1)
     OR (&W_CORP_ID                IS NOT NULL AND PM.CORP_ID = &W_CORP_ID))
   AND OM.WORK_DATE               BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
   AND OM.SOB_ID                  = &W_SOB_ID
   AND OM.ORG_ID                  = &W_ORG_ID
   AND PM.JOIN_DATE               <= OM.WORK_DATE
   AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
--   AND OM.CONFIRMED_YN            = 'Y'
;   
       
       


SELECT 'N' AS SELECT_YN
     , PM.PERSON_ID
     , PM.PERSON_NUM
     , PM.NAME
     , PM.JOIN_DATE
     , PM.RETIRE_DATE
     , T1.DEPT_NAME
     , T1.POST_NAME
     , T1.JOB_CATEGORY_NAME
     , T2.FLOOR_NAME
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '110' THEN 1
             ELSE 0
           END) AS OT_TYPE_110
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '120' THEN 1
             ELSE 0
           END) AS OT_TYPE_120
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '210' THEN 1
             ELSE 0
           END) AS OT_TYPE_210
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '220' THEN 1
             ELSE 0
           END) AS OT_TYPE_220    
     
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '110' THEN OM.OT_AMOUNT
             ELSE 0
           END) AS OT_AMOUNT_110
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '120' THEN OM.OT_AMOUNT
             ELSE 0
           END) AS OT_AMOUNT_120
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '210' THEN OM.OT_AMOUNT
             ELSE 0
           END) AS OT_AMOUNT_210
     , SUM(CASE OTG.OT_TYPE_CODE
             WHEN '220' THEN OM.OT_AMOUNT
             ELSE 0
           END) AS OT_AMOUNT_220 
     , SUM(OM.OT_AMOUNT) AS OT_AMOUNT
     , OM.PAY_YYYYMM
     , HRM_COMMON_G.CODE_NAME_F('WAGE_TYPE', OM.WAGE_TYPE, OM.SOB_ID, OM.ORG_ID) AS WAGE_TYPE_DESC
     , OM.TRANSFER_YN
     , OM.TRANSFER_PERSON_ID
  FROM HRM_PERSON_MASTER PM
     , HRD_OT_MANAGER    OM
     , HRM_OT_TYPE_GW_V  OTG
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
         AND ((&W_DEPT_ID          IS NULL AND 1 = 1)
           OR (&W_DEPT_ID          IS NOT NULL AND HL.DEPT_ID = &W_DEPT_ID))         
         AND HL.HISTORY_LINE_ID  
               IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                    WHERE S_HL.CHARGE_DATE            <= &W_WORK_DATE_TO
                      AND S_HL.PERSON_ID              = HL.PERSON_ID
                    GROUP BY S_HL.PERSON_ID
                  )
      ) T1
    , (-- 시점 인사내역.
        SELECT PH.PERSON_ID
             , PH.FLOOR_ID
             , HF.FLOOR_CODE
             , HF.FLOOR_NAME
             , HF.SORT_NUM AS FLOOR_SORT_NUM
          FROM HRD_PERSON_HISTORY        PH
             , HRM_FLOOR_V               HF
        WHERE PH.FLOOR_ID           = HF.FLOOR_ID
          AND ((&W_FLOOR_ID          IS NULL AND 1 = 1)
           OR (&W_FLOOR_ID           IS NOT NULL AND PH.FLOOR_ID = &W_FLOOR_ID))
          AND PH.EFFECTIVE_DATE_FR  <=  &W_WORK_DATE_TO
          AND PH.EFFECTIVE_DATE_TO  >=  &W_WORK_DATE_FR
      ) T2
 WHERE PM.PERSON_ID               = OM.PERSON_ID
   AND OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
   AND PM.PERSON_ID               = T1.PERSON_ID
   AND PM.PERSON_ID               = T2.PERSON_ID
   AND PM.WORK_CORP_ID            = &W_WORK_CORP_ID
   AND ((&W_PERSON_ID              IS NULL AND 1 = 1)
     OR (&W_PERSON_ID              IS NOT NULL AND PM.PERSON_ID = &W_PERSON_ID))
   AND ((&W_CORP_ID                IS NULL AND 1 = 1)
     OR (&W_CORP_ID                IS NOT NULL AND PM.CORP_ID = &W_CORP_ID))
   AND OM.WORK_DATE               BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO   
   AND OM.SOB_ID                  = &W_SOB_ID
   AND OM.ORG_ID                  = &W_ORG_ID
   AND PM.JOIN_DATE               <= OM.WORK_DATE
   AND (PM.RETIRE_DATE            >= OM.WORK_DATE OR PM.RETIRE_DATE IS NULL)
--   AND OM.CONFIRMED_YN            = 'Y'
GROUP BY PM.PERSON_ID
       , PM.PERSON_NUM
       , PM.NAME
       , PM.JOIN_DATE
       , PM.RETIRE_DATE
       , T1.DEPT_NAME
       , T1.POST_NAME
       , T1.JOB_CATEGORY_NAME
       , T2.FLOOR_NAME
       , OM.PAY_YYYYMM
       , OM.WAGE_TYPE
       , OM.TRANSFER_YN
       , OM.TRANSFER_PERSON_ID
       , OM.SOB_ID
       , OM.ORG_ID
       , T2.FLOOR_SORT_NUM
       , T1.POST_SORT_NUM
ORDER BY T2.FLOOR_SORT_NUM
       , T1.POST_SORT_NUM       
;   
       
       
