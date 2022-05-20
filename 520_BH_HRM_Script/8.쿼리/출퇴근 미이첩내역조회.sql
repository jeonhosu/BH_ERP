SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
           , DI.PERSON_ID
           , PM.DISPLAY_NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , DI.WORK_DATE
           , DI.DUTY_ID
           , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
           , DI.HOLY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
           , CASE
               WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
               ELSE DI.OPEN_TIME
             END AS OPEN_TIME
           , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
               WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
               ELSE DI.CLOSE_TIME
             END AS CLOSE_TIME
           , CASE
               WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
               ELSE DI.OPEN_TIME1
             END AS OPEN_TIME1
           , CASE
               WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
               ELSE DI.CLOSE_TIME1
             END AS CLOSE_TIME1
           , DI.NEXT_DAY_YN
           , DI.DANGJIK_YN
           , DI.ALL_NIGHT_YN
           , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
           , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
           , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
           , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC           
           , DI.LEAVE_ID
           , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
           , DI.LEAVE_TIME_CODE
           , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
           , DI.DESCRIPTION
           , DI.TRANS_YN AS TRANS_YN
           , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
           , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
           , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
           , DI.WORK_DATE
           , DI.WORK_CORP_ID CORP_ID
      FROM HRD_DAY_INTERFACE_V DI 
        , HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
        , HRM_POST_CODE_V PC
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID    
            FROM HRM_HISTORY_LINE HL  
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= &W_WORK_DATE_TO
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1 
        , HRD_DAY_MODIFY I_DM
        , HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회. 
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
            AND DIT.PERSON_ID     = NVL(&W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = &W_CORP_ID
            AND DIT.SOB_ID        = &W_SOB_ID
            AND DIT.ORG_ID        = &W_ORG_ID
        ) N_DI    
      WHERE DI.PERSON_ID                          = PM.PERSON_ID
        AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
        AND DI.SOB_ID                             = PM.SOB_ID
        AND DI.ORG_ID                             = PM.ORG_ID
        AND PM.FLOOR_ID                           = HF.FLOOR_ID
        AND PM.POST_ID                            = PC.POST_ID
        AND PM.PERSON_ID                          = T1.PERSON_ID
        AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
        AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
        AND '1'                                   = I_DM.IO_FLAG(+)
        AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
        AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
        AND '2'                                   = O_DM.IO_FLAG(+)  
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
        AND DI.WORK_DATE                          BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
        AND DI.WORK_CORP_ID                       = &W_CORP_ID
        AND DI.SOB_ID                             = &W_SOB_ID
        AND DI.ORG_ID                             = &W_ORG_ID
        AND DI.PERSON_ID                          = NVL(&W_PERSON_ID, DI.PERSON_ID)        
        AND DI.WORK_TYPE_ID                       = NVL(&W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
        AND T1.FLOOR_ID                           = NVL(&W_FLOOR_ID, T1.FLOOR_ID)
        AND NVL(&W_MODIFY_YN, DI.MODIFY_YN)       IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
        AND DI.TRANS_YN                           = 'N'
        AND PM.JOIN_DATE                          <= DI.WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= DI.WORK_DATE)
        AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
                       AND DM.DUTY_CONTROL_ID                         = NVL(T1.FLOOR_ID, PM.FLOOR_ID)
                       AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                       AND (NVL(&V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                       AND DM.START_DATE                              <= &W_WORK_DATE_TO
                       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= &W_WORK_DATE_FR)
                       AND DM.SOB_ID                                  = PM.SOB_ID
                       AND DM.ORG_ID                                  = PM.ORG_ID
                   )
        ORDER BY DI.WORK_DATE, HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.PERSON_NUM
        ;
