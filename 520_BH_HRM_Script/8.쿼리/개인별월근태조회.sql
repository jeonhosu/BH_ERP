SELECT MT.PERSON_ID
           , MT.CORP_ID
           , MT.DUTY_YYYYMM
           , MT.TOTAL_ATT_DAY AS TOTAL_ATT_DAY  -- 기본근무시간;
           , MTD.DUTY_11 -- 결근일수.
           , NVL(MTD.DUTY_12, 0) + NVL(MTD.DUTY_13, 0) AS DUTY_12  -- 교육/훈련.
           , MTD.DUTY_18  -- 출장.
           , MTD.DUTY_19  -- 경조휴가.
           , NVL(MTD.DUTY_20, 0) + NVL(MTD.DUTY_21, 0) AS DUTY_20  -- 년차.
           , MTD.DUTY_22  -- 보건휴가.
           , MTD.DUTY_23  -- 연중휴가.
           , MTD.DUTY_30 AS DUTY_30    -- 공상.
           , MTD.DUTY_31  -- 병가.
           , NVL(MTD.DUTY_55, 0) + NVL(MTD.DUTY_56, 0) AS DUTY_55 -- 유급휴가.
           , NVL(MTD.DUTY_77, 0) + NVL(MTD.DUTY_78, 0) AS DUTY_77  -- 산휴.
           , MTD.DUTY_94  -- 산재.
           , NVL(MTD.DUTY_95, 0) + NVL(MTD.DUTY_96, 0) AS DUTY_95  -- 휴직.
           , MTD.DUTY_97
           , MT.HOLY_0_COUNT  -- 무급휴일수;
           , MT.HOLY_1_COUNT  -- 유급휴일수;
           , MT.LATE_DED_COUNT
           , MT.PAY_DAY  -- 급여일수.
           , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT  -- 총공제일수.
           , MT.WEEKLY_DED_COUNT  -- 주휴공제일수.           
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.LATE_TIME, 0) + NVL(MTO.LEAVE_TIME, 0)
             END AS LATE_TIME  -- 지각/조퇴;
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.OVER_TIME, 0)
               ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0) + NVL(MTO.HOLY_1_OT, 0) + NVL(MTO.HOLY_0_OT, 0) 
             END AS OVER_TIME   -- 연장.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.NIGHT_TIME, 0) 
               ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)  + NVL(MTO.HOLY_1_NIGHT, 0) + NVL(MTO.HOLY_0_NIGHT, 0)
             END AS NIGHT_BONUS_TIME   -- 야간근로.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.HOLIDAY_TIME, 0)
             END AS HOLIDAY_TIME            -- 유휴 근무.
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
          , ( SELECT PMH.PERSON_ID
                   , PMH.PAY_TYPE
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.PERSON_ID     = NVL(&W_PERSON_ID, PMH.PERSON_ID)
                AND PMH.CORP_ID       = &W_CORP_ID
                AND PMH.START_YYYYMM  <= &W_PAY_YYYYMM
                AND PMH.END_YYYYMM    >= &W_PAY_YYYYMM
                AND PMH.SOB_ID        = &W_SOB_ID
                AND PMH.ORG_ID        = &W_ORG_ID
             ) S_PMH
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID(+)
        AND MT.DUTY_TYPE               = &V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = &W_PAY_YYYYMM
        AND MT.PERSON_ID               = NVL(&W_PERSON_ID, MT.PERSON_ID)
        AND MT.CORP_ID                 = &W_CORP_ID
        AND MT.SOB_ID                  = &W_SOB_ID
        AND MT.ORG_ID                  = &W_ORG_ID
      ;
