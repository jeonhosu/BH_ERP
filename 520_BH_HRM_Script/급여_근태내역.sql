
SELECT MT.TOTAL_ATT_DAY
     , MTD.DUTY_30 AS DUTY_30
     , HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(MT.PERSON_ID, &W_START_DATE, &W_END_DATE, MT.SOB_ID, MT.ORG_ID) AS HOLY_1_COUNT
     , MT.HOLY_1_COUNT
     , MT.HOLY_0_COUNT
     , MT.LATE_DED_COUNT
     , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT
     , MT.WEEKLY_DED_COUNT
     , MTO.*
     , NVL(MTO.LEAVE_TIME, 0) + NVL(MTO.LATE_TIME, 0) AS LATE_TIME  -- 지각/조퇴.
     , NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0) AS OVER_TIME   -- 연장.
     , NVL(MTO.NIGHT_BONUS_TIME, 0) AS NIGHT_BONUS_TIME   -- 야간.
     , NVL(MTO.HOLIDAY_TIME, 0) AS HOLIDAY_TIME           -- 특근.
     , NVL(MTO.HOLIDAY_OT_TIME, 0) AS HOLIDAY_OT_TIME     -- 특근 연장.
     
  FROM HRD_MONTH_TOTAL MT
    , HRD_MONTH_TOTAL_OT_V MTO
    , HRD_MONTH_TOTAL_DUTY_V MTD
WHERE MT.MONTH_TOTAL_ID           = MTO.MONTH_TOTAL_ID
  AND MT.MONTH_TOTAL_ID           = MTD.MONTH_TOTAL_ID
  AND MTO.DUTY_TYPE               = 'D2'
  AND MTO.DUTY_YYYYMM             = '2010-12'
  AND MTO.PERSON_ID               = 1085
  AND MTO.SOB_ID                  = 20
  AND MTO.ORG_ID                  = 201
;


SELECT *
  FROM HRD_DAY_LEAVE_V2 DL
WHERE DL.PERSON_ID                = &W_PERSON_ID
  AND DL.WORK_DATE                >= &W_START_DATE
  AND DL.WORK_DATE                <= &W_END_DATE
  AND DL.SOB_ID                   = &W_SOB_ID
  AND DL.ORG_ID                   = &W_ORG_ID
  AND DL.CLOSED_YN      = 'Y'
;
