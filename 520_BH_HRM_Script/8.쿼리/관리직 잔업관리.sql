SELECT 'N' AS SELECT_YN
           , OM.WORK_DATE
           , OM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , T1.DEPT_NAME
           , T2.FLOOR_NAME
           , T1.POST_NAME
           , T3.DUTY_NAME
           , T3.HOLY_TYPE_NAME
           , T3.OPEN_TIME
           , T3.CLOSE_TIME
           /*
           , HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME) AS OPEN_TIME
           , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) AS CLOSE_TIME
           , CASE
               WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                 HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                    , OM.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                    , OM.WORK_DATE + 0.354166666666667) -- 08:30 -- 
               WHEN T3.HOLY_TYPE IN('3') THEN 
                 HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                    , OM.WORK_DATE + 1.270833333333333
                                                    , OM.WORK_DATE + 1.270833333333333) 
               ELSE
                 HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                    , OM.WORK_DATE + 0.75
                                                    , OM.WORK_DATE + 0.75) 
             END AS OT_START_TIME
           , HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) AS OT_END_TIME          */
           , CASE
               WHEN T3.CLOSE_TIME IS NULL THEN 0
               WHEN T3.OPEN_TIME IS NULL THEN 0 
               ELSE (HRD_DAY_LEAVE_G_SET.CLOSE_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.CLOSE_TIME) - 
                     CASE
                       WHEN T3.HOLY_TYPE IN('0', '1') THEN 
                         HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , OM.WORK_DATE + 0.354166666666667  -- 08:30 --
                                                            , OM.WORK_DATE + 0.354166666666667) -- 08:30 -- 
                       WHEN T3.HOLY_TYPE IN('3') THEN 
                         HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , OM.WORK_DATE + 1.270833333333333
                                                            , OM.WORK_DATE + 1.270833333333333) 
                       ELSE
                         HRD_DAY_LEAVE_G_SET.OT_START_TIME_F( HRD_DAY_LEAVE_G_SET.OPEN_TIME_F(T1.JOB_CATEGORY_CODE, T3.HOLY_TYPE, T3.OPEN_TIME)
                                                            , OM.WORK_DATE + 0.75
                                                            , OM.WORK_DATE + 0.75) 
                     END) * 24
             END AS REAL_OT_TIME
           , OTG.OT_TYPE_CODE
           , OM.OT_TYPE_ID
           , OTG.OT_TYPE_NAME AS OT_TYPE_DESC
           , OM.OT_DATE_FR
           , OM.OT_DATE_TO
           , (OM.OT_DATE_TO - OM.OT_DATE_FR) * 24 AS STD_OT_TIME
           , OM.DESCRIPTION 
           , OM.STATUS_FLAG
           , HRM_COMMON_G.CODE_NAME_F('OT_TYPE_STATUS', OM.STATUS_FLAG, OM.SOB_ID, OM.ORG_ID) AS OT_TYPE_STATUS_DESC
  FROM HRD_OT_MANAGER    OM
     , HRM_OT_TYPE_GW_V  OTG
     , HRM_PERSON_MASTER PM
     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
       SELECT HL.PERSON_ID
            , HL.DEPT_ID
            , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
            , HL.POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
            , HL.JOB_CATEGORY_ID
            , JC.JOB_CATEGORY_CODE 
            , JC.JOB_CATEGORY_NAME 
         FROM HRM_HISTORY_HEADER      HH
            , HRM_HISTORY_LINE        HL
            , HRM_JOB_CATEGORY_CODE_V JC
       WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
         AND HL.JOB_CATEGORY_ID   = JC.JOB_CATEGORY_ID
         AND ((&W_DEPT_ID         IS NULL AND 1 = 1)
           OR (&W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = &W_DEPT_ID))         
         AND HL.HISTORY_LINE_ID  
               IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                    WHERE S_HL.CHARGE_DATE            <= &W_WORK_DATE_TO
                      AND S_HL.PERSON_ID              = HL.PERSON_ID
                    GROUP BY S_HL.PERSON_ID
                  )
      ) T1
    , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
        SELECT PH.PERSON_ID
             , PH.FLOOR_ID
             , PH.SOB_ID
             , PH.ORG_ID
             , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
          FROM HRD_PERSON_HISTORY        PH
        WHERE ((&W_FLOOR_ID         IS NULL AND 1 = 1)
           OR (&W_FLOOR_ID          IS NOT NULL AND PH.FLOOR_ID = &W_FLOOR_ID))
          AND PH.EFFECTIVE_DATE_FR  <=  &W_WORK_DATE_TO
          AND PH.EFFECTIVE_DATE_TO  >=  &W_WORK_DATE_FR
      ) T2
    , ( SELECT DI.WORK_DATE
            , DI.PERSON_ID
            , DI.SOB_ID
            , DI.ORG_ID
            , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
            , DI.HOLY_TYPE
            , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
            , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
            , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
            , CASE
                   -- ÈÄÀÏ Åð±Ù±â·Ï ÀÐ¾î¿À±â(´Ü, ¼öÁ¤»çÇ×ÀÌ ÀÖÀ¸¸é ¼öÁ¤»çÇ× ¹Ý¿µ).
                   WHEN (DI.NEXT_DAY_YN   = 'Y'
                      OR DI.HOLY_TYPE    IN('N', '3')
                      OR DI.DANGJIK_YN    = 'Y'
                      OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                         FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                      ))
                   WHEN DI.HOLY_TYPE IN ('0', '1') 
                       AND DC.DUTY_CODE = '53' -- ÈÞÀÏ±Ù¹«(1187)
                       AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) >
                             TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                  FROM HRD_DAY_INTERFACE_V     S_DI
                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                               ))
                   WHEN S_WC.HOLY_TYPE = '3' -- ¾ß°£
                      AND(DC.DUTY_CODE      = '19' -- °æÁ¶ÈÞ°¡(1174)
                       OR DC.DUTY_CODE      = '12' -- ±³À°(1170)
                       OR DC.DUTY_CODE      = '20' -- ³âÂ÷(1175)
                       OR DC.DUTY_CODE      = '54' -- ¹«±ÞÈÞ°¡(1189)
                       OR DC.DUTY_CODE      = '52' -- ¹«±ÞÈÞÀÏ(1182)
                       OR DC.DUTY_CODE      = '17' -- ÆÄ°ß(1172)
                       OR DC.DUTY_CODE      = '55' -- À¯±ÞÈÞ°¡(1190)
                       OR DC.DUTY_CODE      = '18' -- ÃâÀå(1173)
                       OR DC.DUTY_CODE      = '13' -- ÈÆ·Ã(1171)
                       OR DC.DUTY_CODE      = '51' -- ÈÞÀÏ(1188)
                         ) THEN NULL
                   WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                             AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                             AND DC.DUTY_CODE  = '51' -- ÈÞÀÏ(1188)
                                             AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                   WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                             AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                             AND DC.DUTY_CODE IN ( '18' -- ÃâÀå(1173)
                                                                 , '19' -- °æÁ¶ÈÞ°¡(1174)
                                                                 , '20' -- ³âÂ÷(1175)
                                                                 , '22' -- º¸°ÇÈÞ°¡(1177)
                                                                 , '23' -- ¿¬ÁßÈÞ°¡(1178)
                                                                 , '24' -- ´ëÃ¼ÈÞ¹«(1179)
                                                                 , '52' -- ¹«±ÞÈÞÀÏ(1182)
                                                                 , '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                                 , '51' -- ÈÞÀÏ(1188)
                                                                 , '54' -- ¹«±ÞÈÞ°¡(1189)
                                                                 , '55' -- À¯±ÞÈÞ°¡(1190)
                                                                 , '79' -- ´çÁ÷(1194)
                                                                 , '99' -- Ã¶¾ß(3784)
                                                                 )
                                             AND ((SELECT HDC.DUTY_CODE
                                                      FROM HRD_DAY_INTERFACE_V     S_DI
                                                        , HRM_DUTY_CODE_V HDC
                                                     WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                       AND S_DI.SOB_ID        =  DI.SOB_ID
                                                       AND S_DI.ORG_ID        =  DI.ORG_ID
                                                       AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                       AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                       AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                     ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                  AND (S_WC.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                    OR S_WC.DANGJIK_YN = 'Y'    -- ´çÁ÷.
                                                      )
                                                 ) THEN NULL
                   WHEN DC.DUTY_CODE        = '00' -- Ãâ±Ù(1168)
                        AND (SELECT S_DI.NEXT_DAY_YN
                               FROM HRD_DAY_INTERFACE_V   S_DI
                              WHERE S_DI.SOB_ID       = DI.SOB_ID
                                AND S_DI.ORG_ID       = DI.ORG_ID
                                AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                AND S_DI.PERSON_ID    = DI.PERSON_ID
                                AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                            ) = 'Y' -- ÈÄÀÏÅð±Ù
                            THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                    FROM HRD_DAY_INTERFACE_V S_DI
                                                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                     AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                 ))
                   WHEN DC.DUTY_CODE        = '00' -- Ãâ±Ù(1168)
                        AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                        AND (SELECT S_DI.ALL_NIGHT_YN
                               FROM HRD_DAY_INTERFACE   S_DI
                              WHERE S_DI.SOB_ID       = DI.SOB_ID
                                AND S_DI.ORG_ID       = DI.ORG_ID
                                AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                AND S_DI.PERSON_ID    = DI.PERSON_ID
                                AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                            ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                            THEN NULL
                   WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                   ELSE DI.CLOSE_TIME
              END AS CLOSE_TIME
            , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
            , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND DC.DUTY_CODE  =  '53' THEN '' -- ÈÞÀÏ±Ù¹«(1187)
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND DC.DUTY_CODE  =  '00' -- Ãâ±Ù(1168)
                                             AND DI.HOLY_TYPE  = '2' THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DI.CLOSE_TIME IS NULL
                                             AND DC.DUTY_CODE  =  '11' -- °á±Ù(1169)
                                             AND DI.HOLY_TYPE  = '2' THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DI.CLOSE_TIME IS NULL
                                             AND(DC.DUTY_CODE      = '19' -- °æÁ¶ÈÞ°¡(1174)
                                               OR DC.DUTY_CODE      = '12' -- ±³À°(1170)
                                               OR DC.DUTY_CODE      = '20' -- ³âÂ÷(1175)                                                     
                                               OR DC.DUTY_CODE      = '24' -- ´ëÃ¼ÈÞ¹«(1179)
                                               OR DC.DUTY_CODE      = '54' -- ¹«±ÞÈÞ°¡(1189)
                                               OR DC.DUTY_CODE      = '52' -- ¹«±ÞÈÞÀÏ(1182)                                                     
                                               OR DC.DUTY_CODE      = '22' -- º¸°ÇÈÞ°¡(1177)
                                               OR DC.DUTY_CODE      = '23' -- ¿¬ÁßÈÞ°¡(1178)
                                               OR DC.DUTY_CODE      = '55' -- À¯±ÞÈÞ°¡(1190)                                                     
                                               OR DC.DUTY_CODE      = '17' -- ÆÄ°ß(1172)
                                               OR DC.DUTY_CODE      = '18' -- ÃâÀå(1173)
                                               OR DC.DUTY_CODE      = '13' -- ÈÆ·Ã(1171)
                                               OR DC.DUTY_CODE      = '51' -- ÈÞÀÏ(1188)
                                              ) THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND(SELECT S_DI.HOLY_TYPE
                                                   FROM HRD_DAY_INTERFACE_V   S_DI
                                                  WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                    AND S_DI.ORG_ID       = DI.ORG_ID
                                                    AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                    AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                    AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                ) = '3' -- ¾ß°£
                                             AND(DC.DUTY_CODE      = '19' -- °æÁ¶ÈÞ°¡(1174)
                                               OR DC.DUTY_CODE      = '12' -- ±³À°(1170)
                                               OR DC.DUTY_CODE      = '20' -- ³âÂ÷(1175)                                                     
                                               OR DC.DUTY_CODE      = '24' -- ´ëÃ¼ÈÞ¹«(1179)
                                               OR DC.DUTY_CODE      = '54' -- ¹«±ÞÈÞ°¡(1189)
                                               OR DC.DUTY_CODE      = '52' -- ¹«±ÞÈÞÀÏ(1182)                                                     
                                               OR DC.DUTY_CODE      = '22' -- º¸°ÇÈÞ°¡(1177)
                                               OR DC.DUTY_CODE      = '23' -- ¿¬ÁßÈÞ°¡(1178)
                                               OR DC.DUTY_CODE      = '55' -- À¯±ÞÈÞ°¡(1190)                                                     
                                               OR DC.DUTY_CODE      = '17' -- ÆÄ°ß(1172)
                                               OR DC.DUTY_CODE      = '18' -- ÃâÀå(1173)
                                               OR DC.DUTY_CODE      = '13' -- ÈÆ·Ã(1171)
                                               OR DC.DUTY_CODE      = '51' -- ÈÞÀÏ(1188)
                                                ) THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND DC.DUTY_CODE  =  '00' -- Ãâ±Ù(1168)
                                             AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
                                             AND (SELECT S_DI.CLOSE_TIME
                                                    FROM HRD_DAY_INTERFACE_V     S_DI
                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                 ) IS NOT NULL THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                             AND DI.CLOSE_TIME IS NULL
                                             AND DC.DUTY_CODE  =  '00' -- Ãâ±Ù(1168)
                                             AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                             AND (SELECT S_DI.CLOSE_TIME
                                                    FROM HRD_DAY_INTERFACE_V     S_DI
                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                 ) IS NOT NULL THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DC.DUTY_CODE  =  '11' -- °á±Ù(1169)
                                             AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                             AND (SELECT S_DI.CLOSE_TIME
                                                    FROM HRD_DAY_INTERFACE_V     S_DI
                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                  ) IS NULL THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                             AND DI.CLOSE_TIME   IS NULL
                                             AND DC.DUTY_CODE    =  '53' -- ÈÞÀÏ±Ù¹«(1187)
                                             AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                             AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
                                             AND (SELECT S_DI.CLOSE_TIME
                                                    FROM HRD_DAY_INTERFACE_V     S_DI
                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                 ) IS NOT NULL THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND DC.DUTY_CODE  = '51' -- ÈÞÀÏ(1188)
                                             AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                    FROM HRD_DAY_INTERFACE_V   S_DI
                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                 ) = 'Y' THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND DC.DUTY_CODE  = '22' -- º¸°ÇÈÞ°¡(1177)
                                             AND (SELECT DI.HOLY_TYPE
                                                    FROM HRD_DAY_INTERFACE_V     S_DI
                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                 ) = '3' THEN '' -- ¾ß°£
                   WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                   AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                             AND(SELECT HDC.DUTY_CODE -- ÈÞÀÏ±Ù¹«
                                                   FROM HRD_DAY_INTERFACE_V     S_DI
                                                     , HRM_DUTY_CODE_V          HDC
                                                  WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                    AND S_DI.SOB_ID        =  DI.SOB_ID
                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                             AND(DC.DUTY_CODE      = '19' -- °æÁ¶ÈÞ°¡(1174)
                                               OR DC.DUTY_CODE      = '12' -- ±³À°(1170)
                                               OR DC.DUTY_CODE      = '20' -- ³âÂ÷(1175)                                                     
                                               OR DC.DUTY_CODE      = '24' -- ´ëÃ¼ÈÞ¹«(1179)
                                               OR DC.DUTY_CODE      = '54' -- ¹«±ÞÈÞ°¡(1189)
                                               OR DC.DUTY_CODE      = '52' -- ¹«±ÞÈÞÀÏ(1182)                                                     
                                               OR DC.DUTY_CODE      = '22' -- º¸°ÇÈÞ°¡(1177)
                                               OR DC.DUTY_CODE      = '23' -- ¿¬ÁßÈÞ°¡(1178)
                                               OR DC.DUTY_CODE      = '55' -- À¯±ÞÈÞ°¡(1190)                                                     
                                               OR DC.DUTY_CODE      = '17' -- ÆÄ°ß(1172)
                                               OR DC.DUTY_CODE      = '18' -- ÃâÀå(1173)
                                               OR DC.DUTY_CODE      = '13' -- ÈÆ·Ã(1171)
                                               OR DC.DUTY_CODE      = '51' -- ÈÞÀÏ(1188)
                                                ) THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND(SELECT S_DI.CLOSE_TIME
                                                   FROM HRD_DAY_INTERFACE_V     S_DI
                                                  WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                ) IS NOT NULL
                                             AND(DC.DUTY_CODE      = '19' -- °æÁ¶ÈÞ°¡(1174)
                                               OR DC.DUTY_CODE      = '12' -- ±³À°(1170)
                                               OR DC.DUTY_CODE      = '20' -- ³âÂ÷(1175)                                                     
                                               OR DC.DUTY_CODE      = '24' -- ´ëÃ¼ÈÞ¹«(1179)
                                               OR DC.DUTY_CODE      = '54' -- ¹«±ÞÈÞ°¡(1189)
                                               OR DC.DUTY_CODE      = '52' -- ¹«±ÞÈÞÀÏ(1182)                                                     
                                               OR DC.DUTY_CODE      = '22' -- º¸°ÇÈÞ°¡(1177)
                                               OR DC.DUTY_CODE      = '23' -- ¿¬ÁßÈÞ°¡(1178)
                                               OR DC.DUTY_CODE      = '55' -- À¯±ÞÈÞ°¡(1190)                                                     
                                               OR DC.DUTY_CODE      = '17' -- ÆÄ°ß(1172)
                                               OR DC.DUTY_CODE      = '18' -- ÃâÀå(1173)
                                               OR DC.DUTY_CODE      = '13' -- ÈÆ·Ã(1171)
                                               OR DC.DUTY_CODE      = '51' -- ÈÞÀÏ(1188)
                                                ) THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DC.DUTY_CODE    =  '53' -- ÈÞÀÏ±Ù¹«(1187)
                                             AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                             AND DI.OPEN_TIME    IS NOT NULL
                                             AND(SELECT S_DI.CLOSE_TIME
                                                   FROM HRD_DAY_INTERFACE_V     S_DI
                                                  WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                ) IS NOT NULL THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                             AND DI.CLOSE_TIME   IS NOT NULL
                                             AND(SELECT HDC.DUTY_CODE -- ÈÞÀÏ±Ù¹«
                                                   FROM HRD_DAY_INTERFACE_V     S_DI
                                                     , HRM_DUTY_CODE_V        HDC
                                                  WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                    AND S_DI.SOB_ID        =  DI.SOB_ID
                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                             AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                   FROM HRD_DAY_INTERFACE_V   S_DI
                                                  WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                ) = 'Y' THEN ''
                   WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                             AND DI.CLOSE_TIME IS NOT NULL
                                             AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                    FROM HRD_DAY_INTERFACE   S_DI
                                                   WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                     AND S_DI.ORG_ID       = DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                     AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                 ) = '3'
                                              OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                    FROM HRD_DAY_INTERFACE_V S_DI
                                                   WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                     AND S_DI.ORG_ID       = DI.ORG_ID
                                                     AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                     AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                     AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                 ) = 'Y') THEN ''
                   ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
              END  AS APPROVE_STATUS_NAME
            , DI.REJECT_REMARK
            , DI.MODIFY_FLAG AS MODIFY_FLAG
            , DI.TRANS_YN    AS TRANS_YN
            , DI.NEXT_DAY_YN
            , DI.DANGJIK_YN
            , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
            , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
            , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME1, DI.OPEN_TIME1) AS OPEN_TIME1
            , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)                         AS CLOSE_TIME1        
            , DI.PLAN_OPEN_TIME
            , DI.PLAN_CLOSE_TIME          
         FROM HRD_DAY_INTERFACE_V DI
            , HRM_DUTY_CODE_V     DC
            , HRD_DAY_MODIFY      I_DM
            , HRD_DAY_MODIFY      O_DM
            , (-- ÀüÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
               SELECT WC.WORK_DATE + 1 AS WORK_DATE
                    , WC.PERSON_ID
                    , WC.CORP_ID
                    , WC.SOB_ID
                    , WC.ORG_ID
                    , WC.HOLY_TYPE
                    , WC.DANGJIK_YN
                    , WC.ALL_NIGHT_YN
                 FROM HRD_WORK_CALENDAR   WC
                WHERE WC.SOB_ID         = &W_SOB_ID
                  AND WC.ORG_ID         = &W_ORG_ID
                  AND WC.WORK_DATE      BETWEEN &W_WORK_DATE_FR - 1 AND &W_WORK_DATE_TO
                  AND ((&W_PERSON_ID     IS NULL AND 1 = 1)
                    OR (&W_PERSON_ID     IS NOT NULL AND WC.PERSON_ID = &W_PERSON_ID))
              ) S_WC
        WHERE DI.DUTY_ID                = DC.DUTY_ID
          AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
          AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
          AND '1'                       = I_DM.IO_FLAG(+)
          AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
          AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
          AND '2'                       = O_DM.IO_FLAG(+)
          AND DI.WORK_DATE              = S_WC.WORK_DATE(+)
          AND DI.PERSON_ID              = S_WC.PERSON_ID(+)
          AND DI.SOB_ID                 = S_WC.SOB_ID(+)
          AND DI.ORG_ID                 = S_WC.ORG_ID(+)
          AND DI.WORK_DATE              BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
          AND ((&W_PERSON_ID             IS NULL AND 1 = 1)
            OR (&W_PERSON_ID             IS NOT NULL AND DI.PERSON_ID = &W_PERSON_ID))
          AND DI.WORK_CORP_ID           = &W_WORK_CORP_ID
          AND DI.SOB_ID                 = &W_SOB_ID
          AND DI.ORG_ID                 = &W_ORG_ID
      ) T3
 WHERE OM.OT_TYPE_ID              = OTG.OT_TYPE_ID
   AND OM.PERSON_ID               = PM.PERSON_ID
   AND PM.PERSON_ID               = T1.PERSON_ID
   AND PM.PERSON_ID               = T2.PERSON_ID
   AND OM.WORK_DATE               = T3.WORK_DATE(+)
   AND OM.PERSON_ID               = T3.PERSON_ID(+)
   AND OM.SOB_ID                  = T3.SOB_ID(+)
   AND OM.ORG_ID                  = T3.ORG_ID(+)
   AND PM.WORK_CORP_ID            = &W_WORK_CORP_ID
   AND ((&W_CORP_ID               IS NULL AND 1 = 1)
     OR (&W_CORP_ID               IS NOT NULL AND PM.CORP_ID = &W_CORP_ID))
   AND OM.WORK_DATE               BETWEEN &W_WORK_DATE_FR AND &W_WORK_DATE_TO
   AND PM.SOB_ID                  = &W_SOB_ID
   AND PM.ORG_ID                  = &W_ORG_ID
   AND ((&W_PERSON_ID             IS NULL AND 1 = 1)
     OR (&W_PERSON_ID             IS NOT NULL AND PM.PERSON_ID = &W_PERSON_ID))
   AND PM.JOIN_DATE               <= &W_WORK_DATE_TO
   AND (PM.RETIRE_DATE            >= &W_WORK_DATE_FR OR PM.RETIRE_DATE IS NULL)
ORDER BY OM.WORK_DATE
       , PM.PERSON_NUM   
 ;     
