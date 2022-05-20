SELECT DM.DEPT_CODE
     , DM.DEPT_NAME
     , HF.FLOOR_NAME
     , PC.POST_NAME
     , PM.PERSON_NUM
     , PM.NAME
     , TO_CHAR(DL.WORK_DATE, 'YYYY-MM') AS DUTY_YYYYMM
     , SUM(CASE 
             WHEN DL.LATE_TIME = 0 THEN 0 
             WHEN DL.LATE_TIME <> 0 AND TRUNC(DL.OPEN_TIME, 'MI') > DL.PL_OPEN_TIME THEN 1
             ELSE 0
           END) AS LATE_COUNT
     , SUM(CASE 
             WHEN DL.LATE_TIME = 0 THEN 0 
             WHEN DL.LATE_TIME <> 0 AND TRUNC(NVL(DL.CLOSE_TIME1, DL.CLOSE_TIME), 'MI') < DL.PL_CLOSE_TIME THEN 1
             ELSE 0
           END) AS EARLY_COUNT
     , SUM(CASE WHEN DC.DUTY_CODE IN('44') THEN 1 ELSE 0 END) AS LEAVE_COUNT1  -- 공적외출.
     , SUM(CASE WHEN DL.LEAVE_TIME <> 0 THEN 1 ELSE 0 END) AS LEAVE_COUNT2     -- 사적외출.
     , SUM(CASE WHEN DC.DUTY_CODE IN('23') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_23   -- 정기휴가.
     , SUM(CASE WHEN DC.DUTY_CODE IN('20') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_20   -- 년차.
     , SUM(CASE WHEN DC.DUTY_CODE IN('21') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_21   -- 반차.
     , SUM(CASE WHEN DC.DUTY_CODE IN('26') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_26   -- 월차.
     , SUM(CASE WHEN DC.DUTY_CODE IN('19') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_19   -- 경조휴가.
     , SUM(CASE WHEN DC.DUTY_CODE IN('22') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_22   -- 보건휴가.
     , SUM(CASE WHEN DC.DUTY_CODE IN('54') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_54   -- 무급휴가.
     , SUM(CASE WHEN DC.DUTY_CODE IN('24') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_24   -- 대체휴무(철야휴가).
     , SUM(CASE WHEN DC.DUTY_CODE IN('94') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_94   -- 산재.
     , SUM(CASE WHEN DC.DUTY_CODE IN('30') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_30   -- 공상.
     , SUM(CASE WHEN DC.DUTY_CODE IN('77', '78', '95', '96', '97') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_95  -- 휴직/산휴/육아휴직.
     , SUM(CASE WHEN DC.DUTY_CODE IN('11') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_11        -- 결근.
     , 0 AS DUTY_DAY_27           -- 병결.
     , SUM(CASE WHEN DC.DUTY_CODE IN('13') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_13        -- 훈련.
     , SUM(CASE WHEN DC.DUTY_CODE IN('12') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_12        -- 교육.
     , SUM(CASE WHEN DC.DUTY_CODE IN('55', '56') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END)AS DUTY_DAY_ETC        -- 기타(유급휴가/특별유급휴가).
     , SUM(CASE WHEN DC.DUTY_CODE IN('18') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_18        -- 출장.
     , SUM(CASE WHEN DC.DUTY_CODE IN('17') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_17        -- 파견.
  FROM HRD_DAY_LEAVE_V1 DL
     , HRM_DUTY_CODE_V DC
     , HRM_PERSON_MASTER PM
     , HRM_DEPT_MASTER DM
     , HRM_FLOOR_V HF
     , HRM_POST_CODE_V PC
WHERE DL.DUTY_ID                = DC.DUTY_ID
  AND DL.SOB_ID                 = DC.SOB_ID
  AND DL.ORG_ID                 = DC.ORG_ID
  AND DL.PERSON_ID              = PM.PERSON_ID
  AND DL.CORP_ID                = PM.CORP_ID
  AND DL.SOB_ID                 = PM.SOB_ID
  AND DL.ORG_ID                 = PM.ORG_ID
  AND PM.DEPT_ID                = DM.DEPT_ID
  AND PM.FLOOR_ID               = HF.FLOOR_ID
  AND PM.POST_ID                = PC.POST_ID
-- 중도 입/퇴사자의 경우 입퇴사일 사이만 적용.      
  AND DL.WORK_DATE              BETWEEN CASE
                                          WHEN PM.JOIN_DATE > &V_START_DATE THEN PM.JOIN_DATE
                                          ELSE &V_START_DATE 
                                        END
                                    AND CASE 
                                          WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < &V_END_DATE THEN PM.RETIRE_DATE
                                          ELSE &V_END_DATE
                                        END
  AND PM.PERSON_ID              = NVL(&W_PERSON_ID, PM.PERSON_ID)
  AND PM.CORP_ID                = &W_CORP_ID
  AND PM.SOB_ID                 = &W_SOB_ID
  AND PM.ORG_ID                 = &W_ORG_ID
GROUP BY DM.DEPT_CODE
     , DM.DEPT_NAME
     , HF.FLOOR_NAME
     , PC.POST_NAME
     , PM.PERSON_NUM
     , PM.NAME
     , TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
     , DM.DEPT_SORT_NUM
     , HF.SORT_NUM
     , PC.SORT_NUM
ORDER BY DM.DEPT_SORT_NUM, HF.SORT_NUM, PC.SORT_NUM, PM.PERSON_NUM
