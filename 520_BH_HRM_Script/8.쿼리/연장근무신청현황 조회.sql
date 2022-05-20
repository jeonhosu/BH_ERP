/*

DECLARE

BEGIN
  DELETE FROM HRD_OT_REQ_GT;
  
  FOR C1 IN ( SELECT T1.WORK_DATE 
                FROM (SELECT SX1.START_DATE + (LEVEL - 1) AS WORK_DATE    
                        FROM ( SELECT TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') AS START_DATE
                                    , LAST_DAY(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM')) - TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') + 1 AS MONTH_DAY
                                 FROM DUAL
                             ) SX1
                      CONNECT BY (LEVEL <= MONTH_DAY)       
                     ) T1
            )
  LOOP
    -- 대상 생성 -- 
    INSERT INTO HRD_OT_REQ_GT
    ( WORK_DATE 
    , SOB_ID 
    , ORG_ID 
    , WORK_CORP_ID 
    , CORP_ID 
    , FLOOR_ID 
    , WORK_YYYYMM 
    ) 
    SELECT DISTINCT
           C1.WORK_DATE 
         , DM.SOB_ID
         , DM.ORG_ID        
         , DM.CORP_ID AS WORK_CORP_ID 
         , DM.CORP_ID
         , DM.DUTY_CONTROL_ID AS FLOOR_ID 
         , &W_PERIOD_NAME AS PERIOD_NAME 
      FROM HRD_DUTY_MANAGER DM
     WHERE DM.CORP_ID                                  = &P_WORK_CORP_ID 
       AND (NVL(&V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
       AND DM.START_DATE                              <= C1.WORK_DATE 
       AND (DM.END_DATE IS NULL OR DM.END_DATE        >= C1.WORK_DATE )
       AND DM.SOB_ID                                   = &P_SOB_ID
       AND DM.ORG_ID                                   = &P_ORG_ID 
       AND DM.USABLE                                   = 'Y'  
       AND ((&P_FLOOR_ID                                IS NULL AND 1 = 1)
       OR   (&P_FLOOR_ID                                IS NOT NULL AND DM.DUTY_CONTROL_ID = &P_FLOOR_ID)) 
                                      
    ;
  END LOOP C1;
  
  -- 대상에 대한 연장근무 신청수 체크 -- 
  FOR C1 IN ( SELECT ORG.WORK_DATE 
                   , ORG.SOB_ID 
                   , ORG.ORG_ID 
                   , ORG.WORK_CORP_ID 
                   , ORG.CORP_ID 
                   , ORG.FLOOR_ID 
                FROM HRD_OT_REQ_GT ORG
            )
  LOOP
    BEGIN
      -- 해당 일자에 해당 공정 인원수 -- 
      UPDATE HRD_OT_REQ_GT ORG
         SET ORG.ATTRIBUTE_1 = NVL((SELECT COUNT(DISTINCT PM.PERSON_ID) AS PERSON_COUNT
                                      FROM HRM_PERSON_MASTER PM 
                                        , (-- 시점 인사내역.
                                           SELECT PH.PERSON_ID
                                                , PH.FLOOR_ID
                                                , PH.DEPT_ID
                                             FROM HRD_PERSON_HISTORY        PH
                                            WHERE PH.CORP_ID            = C1.WORK_CORP_ID 
                                              AND PH.SOB_ID             = C1.SOB_ID
                                              AND PH.ORG_ID             = C1.ORG_ID 
                                              AND PH.EFFECTIVE_DATE_FR  <= C1.WORK_DATE
                                              AND PH.EFFECTIVE_DATE_TO  >= C1.WORK_DATE
                                          ) T2
                                    WHERE PM.PERSON_ID            = T2.PERSON_ID
                                      AND PM.JOIN_DATE            <= C1.WORK_DATE
                                      AND (PM.RETIRE_DATE         >= C1.WORK_DATE OR PM.RETIRE_DATE IS NULL) 
                                      AND PM.SOB_ID               = C1.SOB_ID 
                                      AND PM.ORG_ID               = C1.ORG_ID 
                                      AND PM.WORK_CORP_ID         = C1.WORK_CORP_ID 
                                      AND ((&P_CORP_ID             IS NULL AND 1 = 1)
                                      OR   (&P_CORP_ID             IS NOT NULL AND PM.CORP_ID = &P_CORP_ID)) 
                                      AND T2.FLOOR_ID             = C1.FLOOR_ID 
                                      AND NOT EXISTS
                                            (SELECT 'X'
                                               FROM HRD_DUTY_EXCEPTION DE
                                              WHERE DE.PERSON_ID            = PM.PERSON_ID
                                                AND DE.ENABLED_FLAG         = 'Y'
                                                AND DE.EFFECTIVE_DATE_FR    <= C1.WORK_DATE
                                                AND (DE.EFFECTIVE_DATE_TO   >= C1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                                AND ((DE.OT_APPLY_YN        != 'Y' 
                                                OR    DE.OT_APPLY_YN        IS NULL)
                                                AND  (DE.OT_EXCEPT_YN       != 'Y'
                                                OR    DE.OT_EXCEPT_YN       IS NULL)
                                                AND  (DE.ADJUST_TIME_YN     != 'Y'
                                                OR    DE.ADJUST_TIME_YN     IS NULL)
                                                AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                                OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                            )
                                  ), 0)
      WHERE ORG.WORK_DATE         = C1.WORK_DATE 
        AND ORG.SOB_ID            = C1.SOB_ID
        AND ORG.ORG_ID            = C1.ORG_ID 
        AND ORG.WORK_CORP_ID      = C1.WORK_CORP_ID      
        AND ORG.FLOOR_ID          = C1.FLOOR_ID
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.WORK_DATE || ', ' || C1.FLOOR_ID || ', ' || SQLERRM);    
    END;
    
    BEGIN
      -- 해당 일자에 해당 공정 연장근무 신청 인원수 -- 
      UPDATE HRD_OT_REQ_GT ORG
         SET ORG.ATTRIBUTE_2 = NVL((SELECT COUNT(DISTINCT PM.PERSON_ID) AS PERSON_COUNT
                                      FROM HRM_PERSON_MASTER PM 
                                        , (-- 시점 인사내역.
                                           SELECT PH.PERSON_ID
                                                , PH.FLOOR_ID
                                                , PH.DEPT_ID
                                             FROM HRD_PERSON_HISTORY        PH
                                            WHERE PH.CORP_ID            = C1.WORK_CORP_ID 
                                              AND PH.SOB_ID             = C1.SOB_ID
                                              AND PH.ORG_ID             = C1.ORG_ID 
                                              AND PH.EFFECTIVE_DATE_FR  <= C1.WORK_DATE
                                              AND PH.EFFECTIVE_DATE_TO  >= C1.WORK_DATE
                                          ) T2
                                        , HRD_OT_LINE OL 
                                    WHERE PM.PERSON_ID            = T2.PERSON_ID 
                                      AND PM.PERSON_ID            = OL.PERSON_ID  
                                      AND OL.WORK_DATE            = C1.WORK_DATE 
                                      AND PM.JOIN_DATE            <= C1.WORK_DATE
                                      AND (PM.RETIRE_DATE         >= C1.WORK_DATE OR PM.RETIRE_DATE IS NULL) 
                                      AND PM.SOB_ID               = C1.SOB_ID 
                                      AND PM.ORG_ID               = C1.ORG_ID 
                                      AND PM.WORK_CORP_ID         = C1.WORK_CORP_ID 
                                      AND ((&P_CORP_ID             IS NULL AND 1 = 1)
                                      OR   (&P_CORP_ID             IS NOT NULL AND PM.CORP_ID = &P_CORP_ID)) 
                                      AND T2.FLOOR_ID             = C1.FLOOR_ID 
                                      AND NOT EXISTS
                                            (SELECT 'X'
                                               FROM HRD_DUTY_EXCEPTION DE
                                              WHERE DE.PERSON_ID            = PM.PERSON_ID
                                                AND DE.ENABLED_FLAG         = 'Y'
                                                AND DE.EFFECTIVE_DATE_FR    <= C1.WORK_DATE
                                                AND (DE.EFFECTIVE_DATE_TO   >= C1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                                AND ((DE.OT_APPLY_YN        != 'Y' 
                                                OR    DE.OT_APPLY_YN        IS NULL)
                                                AND  (DE.OT_EXCEPT_YN       != 'Y'
                                                OR    DE.OT_EXCEPT_YN       IS NULL)
                                                AND  (DE.ADJUST_TIME_YN     != 'Y'
                                                OR    DE.ADJUST_TIME_YN     IS NULL)
                                                AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                                OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                            )
                                  ), 0)
      WHERE ORG.WORK_DATE         = C1.WORK_DATE 
        AND ORG.SOB_ID            = C1.SOB_ID
        AND ORG.ORG_ID            = C1.ORG_ID 
        AND ORG.WORK_CORP_ID      = C1.WORK_CORP_ID      
        AND ORG.FLOOR_ID          = C1.FLOOR_ID
      ;
    EXCEPTION 
      WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(C1.WORK_DATE || ', ' || C1.FLOOR_ID || ', ' || SQLERRM);    
    END;
  END LOOP C1;
  
END;

*/
/*
SELECT *
  FROM HRD_OT_REQ_GT ORG
     --, HRM_FLOOR_V   HF
 WHERE ORG.
  ;

SELECT T1.*
  FROM (SELECT SX1.START_DATE + (LEVEL - 1) AS WORK_DATE    
          FROM ( SELECT TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') AS START_DATE
                      , LAST_DAY(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM')) - TRUNC(TO_DATE(&W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') + 1 AS MONTH_DAY
                   FROM DUAL
               ) SX1
        CONNECT BY (LEVEL <= MONTH_DAY)       
       ) T1
;       
*/
/*

SELECT HF.FLOOR_CODE
     , HF.FLOOR_NAME
     , ORG.WORK_DATE
     , ORG.FLOOR_ID 
     , ORG.ATTRIBUTE_1
     , ORG.ATTRIBUTE_2 
  FROM HRD_OT_REQ_GT ORG
     , HRM_FLOOR_V   HF
 WHERE ORG.FLOOR_ID           = HF.FLOOR_ID
  ;
  
*/

SELECT TO_CHAR(ORG.WORK_DATE, 'YYYY-MM') AS PERIOD_NAME 
     , HF.FLOOR_CODE
     , HF.FLOOR_NAME
     , ORG.FLOOR_ID 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '01', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_01 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '01', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_01 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '01', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '01', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_01 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '02', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_02 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '02', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_02  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '02', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '02', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_02 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '03', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_03 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '03', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_03 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '03', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '03', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_03  
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '04', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_04 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '04', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_04       
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '04', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '04', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_04 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '05', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_05 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '05', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_05 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '05', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '05', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_05 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '06', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_06 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '06', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_06  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '06', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '06', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_06 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '07', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_07 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '07', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_07 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '07', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '07', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_07 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '08', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_08 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '08', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_08       
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '08', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '08', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_08 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '09', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_09 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '09', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_09 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '09', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '09', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_09 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '10', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_10 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '10', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_10  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '10', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '10', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_10 
          
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '11', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_11 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '11', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_11 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '11', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '11', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_11 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '12', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_12 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '12', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_12  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '12', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '12', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_12 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '13', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_13 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '13', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_13 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '13', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '13', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_13 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '14', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_14 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '14', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_14  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '14', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '14', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_14 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '15', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_15 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '15', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_15 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '15', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '15', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_15 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '16', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_16 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '16', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_16  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '16', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '16', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_16 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '17', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_17 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '17', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_17 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '17', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '17', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_17 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '18', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_18 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '18', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_18  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '18', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '18', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_18 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '19', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_19 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '19', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_19 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '19', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '19', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_19 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '20', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_20 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '20', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_20  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '20', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '20', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_20 
          
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '21', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_21 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '21', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_21 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '21', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '21', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_21 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '22', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_22 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '22', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_22  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '22', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '22', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_22 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '23', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_23 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '23', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_23 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '23', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '23', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_23 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '24', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_24 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '24', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_24  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '24', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '24', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_24 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '25', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_25 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '25', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_25 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '25', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '25', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_25 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '26', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_26 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '26', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_26  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '26', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '26', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_26  
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '27', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_27 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '27', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_27 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '27', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '27', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_27  
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '28', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_28 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '28', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_28  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '28', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '28', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_28 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '29', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_29 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '29', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_29 
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '29', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '29', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_29 
     
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '30', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_30 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '30', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_30  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '30', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '30', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_30 
          
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '31', NVL(ORG.ATTRIBUTE_1, 0), 0)) AS DAY_PERSON_31 
     , SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '31', NVL(ORG.ATTRIBUTE_2, 0), 0)) AS DAY_OT_31  
     , ABS(SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '31', NVL(ORG.ATTRIBUTE_1, 0), 0)) -
           SUM(DECODE(TO_CHAR(ORG.WORK_DATE, 'DD'), '31', NVL(ORG.ATTRIBUTE_2, 0), 0))) * -1 AS DAY_GAP_31 
     
  FROM HRD_OT_REQ_GT ORG
     , HRM_FLOOR_V   HF
 WHERE ORG.FLOOR_ID           = HF.FLOOR_ID
 GROUP BY TO_CHAR(ORG.WORK_DATE, 'YYYY-MM') 
       , HF.FLOOR_CODE
       , HF.FLOOR_NAME
       , ORG.FLOOR_ID 
  ;
