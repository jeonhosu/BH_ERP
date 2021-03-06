CREATE OR REPLACE VIEW HRD_DAY_LEAVE_V2 AS
SELECT DL.DAY_LEAVE_ID
     , DL.PERSON_ID
     , DL.WORK_DATE
     , DL.WORK_CORP_ID
     , DL.CORP_ID
     , DL.DEPT_ID
     , DL.POST_ID
     , DL.JOB_CATEGORY_ID
     , NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, DL.DUTY_ID)) AS DUTY_ID
     , NVL(WC.HOLY_TYPE, DL.HOLY_TYPE) AS HOLY_TYPE
     , DL.OPEN_TIME
     , DL.CLOSE_TIME
     , DL.OPEN_TIME1
     , DL.CLOSE_TIME1
     , DL.NEXT_DAY_YN
     , NVL(WC.DANGJIK_YN, DL.DANGJIK_YN) AS DANGJIK_YN
     , NVL(WC.ALL_NIGHT_YN, DL.ALL_NIGHT_YN) AS ALL_NIGHT_YN
     , NVL(OT.LEAVE_TIME, 0) AS LEAVE_TIME
     , NVL(OT.LATE_TIME, 0) AS LATE_TIME
     , NVL(OT.REST_TIME, 0) AS REST_TIME
     , NVL(OT.OVER_TIME, 0) AS OVER_TIME
     , NVL(OT.HOLIDAY_TIME, 0) AS HOLIDAY_TIME
     , NVL(OT.NIGHT_TIME, 0) AS NIGHT_TIME
     , NVL(OT.NIGHT_BONUS_TIME, 0) AS NIGHT_BONUS_TIME
     , NVL(OT.HOLIDAY_OT_TIME, 0) AS HOLIDAY_OT_TIME
     , DL.HOLIDAY_CHECK
     , DL.CLOSED_YN
     , DL.CLOSED_DATE
     , DL.CLOSED_PERSON_ID
     , DL.SOB_ID
     , DL.ORG_ID
     , WC.BEFORE_OT_START
     , WC.BEFORE_OT_END
     , WC.AFTER_OT_START
     , WC.AFTER_OT_END
     , WC.LUNCH_YN
     , WC.MIDNIGHT_YN
  FROM HRD_DAY_LEAVE DL
     , HRD_WORK_CALENDAR WC
     , (-- 일근태 잔업 계산 내역.
        SELECT DLO.DAY_LEAVE_ID
             , SUM(DECODE(DLO.OT_TYPE, '11', DLO.OT_TIME, 0)) AS LEAVE_TIME
             , SUM(DECODE(DLO.OT_TYPE, '12', DLO.OT_TIME, 0)) AS LATE_TIME
             , SUM(DECODE(DLO.OT_TYPE, '13', DLO.OT_TIME, 0)) AS REST_TIME
             , SUM(DECODE(DLO.OT_TYPE, '14', DLO.OT_TIME, 0)) AS OVER_TIME
             , SUM(DECODE(DLO.OT_TYPE, '15', DLO.OT_TIME, 0)) AS HOLIDAY_TIME
             , SUM(DECODE(DLO.OT_TYPE, '16', DLO.OT_TIME, 0)) AS NIGHT_TIME
             , SUM(DECODE(DLO.OT_TYPE, '17', DLO.OT_TIME, 0)) AS NIGHT_BONUS_TIME
             , SUM(DECODE(DLO.OT_TYPE, '18', DLO.OT_TIME, 0)) AS HOLIDAY_OT_TIME
          FROM HRD_DAY_LEAVE_OT DLO
        GROUP BY DLO.DAY_LEAVE_ID
       ) OT
WHERE DL.WORK_DATE              = WC.WORK_DATE
  AND DL.PERSON_ID              = WC.PERSON_ID
  AND DL.WORK_CORP_ID           = WC.WORK_CORP_ID
  AND DL.SOB_ID                 = WC.SOB_ID
  AND DL.ORG_ID                 = WC.ORG_ID
  AND DL.DAY_LEAVE_ID           = OT.DAY_LEAVE_ID(+);
