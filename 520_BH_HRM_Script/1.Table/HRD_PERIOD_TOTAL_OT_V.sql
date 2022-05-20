CREATE OR REPLACE VIEW HRD_PERIOD_TOTAL_OT_V AS
SELECT MTO.PERSON_ID
     , MTO.SOB_ID
     , MTO.ORG_ID
     , MAX(DECODE(MTO.OT_TYPE, '11', MTO.OT_TIME, 0)) AS LEAVE_TIME
     , MAX(DECODE(MTO.OT_TYPE, '12', MTO.OT_TIME, 0)) AS LATE_TIME
     , MAX(DECODE(MTO.OT_TYPE, '13', MTO.OT_TIME, 0)) AS REST_TIME
     , MAX(DECODE(MTO.OT_TYPE, '14', MTO.OT_TIME, 0)) AS OVER_TIME
     , MAX(DECODE(MTO.OT_TYPE, '15', MTO.OT_TIME, 0)) AS HOLIDAY_TIME
     , MAX(DECODE(MTO.OT_TYPE, '16', MTO.OT_TIME, 0)) AS NIGHT_TIME
     , MAX(DECODE(MTO.OT_TYPE, '17', MTO.OT_TIME, 0)) AS NIGHT_BONUS_TIME
     , MAX(DECODE(MTO.OT_TYPE, '18', MTO.OT_TIME, 0)) AS HOLYDAY_OT_TIME
  FROM HRD_PERIOD_TOTAL_OT_GT MTO
GROUP BY MTO.PERSON_ID
       , MTO.SOB_ID
       , MTO.ORG_ID;