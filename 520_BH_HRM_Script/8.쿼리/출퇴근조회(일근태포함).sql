SELECT DI.WORK_DATE                                              -- �ٹ�����.
     , DI.PERSON_ID                                              -- ���ID.
     , PM.DISPLAY_NAME                                           -- ����.
     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME    -- �μ���.
     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME           -- ����.
     , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME         -- �۾���.
     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME           -- ����.
     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME  -- �ٹ�.
     , CASE
         WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
         ELSE DI.OPEN_TIME
       END AS OPEN_TIME                                          -- ��ٽð�.     
     , CASE
         WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
         ELSE DI.CLOSE_TIME
       END AS CLOSE_TIME                                         -- ��ٽð�.
     , CASE
         WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
         ELSE DI.OPEN_TIME1
       END AS OPEN_TIME1                                         -- ����ð�.
     , CASE
         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
         ELSE DI.CLOSE_TIME1
       END AS CLOSE_TIME1                                        -- ����ð�.
     , DI.NEXT_DAY_YN                                            -- �������.
     , DI.DANGJIK_YN                                             -- ����.
     , DI.ALL_NIGHT_YN                                           -- ö��.
     , S_DL.LEAVE_TIME                                           -- ����ð�.
     , S_DL.LATE_TIME                                            -- �����ð�.
     , S_DL.REST_TIME                                            -- �޽Ŀ���.
     , S_DL.OVER_TIME                                            -- ����ð�.
     , S_DL.HOLIDAY_TIME                                         -- Ư�ٽð�.
     , S_DL.NIGHT_TIME                                           -- ö�߽ð�.
     , S_DL.NIGHT_BONUS_TIME                                     -- �߰������ð�.
     , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC         --��ټ�������.
     , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC        -- ��ټ�������.
     , DI.DESCRIPTION                                            -- ���.
     , DI.TRANS_YN AS CLOSED_YN                                  -- ��������.
     , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME  -- ���λ���.
     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME                                        -- ����������.
     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME                                      -- Ȯ��������.
     , DI.WORK_CORP_ID CORP_ID                                   -- ��üID.
FROM HRD_DAY_INTERFACE_V DI 
  , HRM_PERSON_MASTER PM
  , HRM_FLOOR_V HF
  , HRM_POST_CODE_V PC
  , (-- ���� �λ系��.
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
  , (-- ���� �ٹ� ���� ��ȸ. 
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
      WHERE DIT.WORK_DATE     BETWEEN &W_WORK_DATE_FR + 1 AND &W_WORK_DATE_TO + 1
/*        AND DIT.PERSON_ID     = &W_PERSON_ID
        AND DIT.WORK_CORP_ID  = &W_CORP_ID
        AND DIT.SOB_ID        = &W_SOB_ID
        AND DIT.ORG_ID        = &W_ORG_ID*/
    ) N_DI
  , ( SELECT DL.WORK_DATE
           , DL.PERSON_ID
           , DL.WORK_CORP_ID
           , DL.SOB_ID
           , DL.ORG_ID
           , DL.LEAVE_TIME
           , DL.LATE_TIME
           , DL.REST_TIME
           , DL.OVER_TIME
           , DL.HOLIDAY_TIME
           , DL.NIGHT_TIME
           , DL.NIGHT_BONUS_TIME
        FROM HRD_DAY_LEAVE_V2 DL
      WHERE DL.WORK_DATE      BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
/*        AND DL.PERSON_ID      = &W_PERSON_ID
        AND DL.WORK_CORP_ID   = &W_CORP_ID
        AND DL.SOB_ID         = &W_SOB_ID
        AND DL.ORG_ID         = &W_ORG_ID*/
        AND DL.CLOSED_YN      = 'Y'
     ) S_DL
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
  AND DI.WORK_DATE                          = S_DL.WORK_DATE(+)
  AND DI.PERSON_ID                          = S_DL.PERSON_ID(+)
  AND DI.SOB_ID                             = S_DL.SOB_ID(+)
  AND DI.ORG_ID                             = S_DL.ORG_ID(+)
  AND DI.WORK_DATE                          BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
/*  AND DI.SOB_ID                             = &W_SOB_ID
  AND DI.ORG_ID                             = &W_ORG_ID
  AND DI.PERSON_ID                          = &W_PERSON_ID*/
  AND PM.PERSON_NUM                         = 'B04066'     -- �����ȣ.
  AND PM.REPRE_NUM                          LIKE '%-' || '1109529'    --�ֹι�ȣ.
  AND PM.JOIN_DATE                          <= &W_WORK_DATE_TO
  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= &W_WORK_DATE_FR)
ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.NAME, DI.WORK_DATE
;
