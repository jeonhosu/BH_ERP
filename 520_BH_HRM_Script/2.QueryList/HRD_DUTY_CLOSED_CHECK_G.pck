CREATE OR REPLACE PACKAGE HRD_DUTY_CLOSED_CHECK_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DUTY_CLOSED_CHECK_G
/* DESCRIPTION  : 근태 마감 검증 관리  
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-----------------------------------------------------------------------------------------
-- 근태 마감 검증 관리 : 일별   
  PROCEDURE SELECT_DAILY
	          ( P_CURSOR                   OUT TYPES.TCURSOR
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);

-- 근태 마감 검증 관리 : 일별 - 작업장 미등록내역      
  PROCEDURE DAILY_NOT_DUTY_MANAGER
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);

-- 근태 마감 검증 관리 : 일별 - 근무계획 미등록내역      
  PROCEDURE DAILY_NOT_WORK_CALENDAR
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);
            

-- 근태 마감 검증 관리 : 일별 - 출퇴근 집계 미등록내역      
  PROCEDURE NOT_DAY_INTERFACE
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);
            
-- 근태 마감 검증 관리 : 일별 - 출퇴근 집계 미이첩 내역     
  PROCEDURE DAY_INTERFACE_NOT_TRANS
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);            

-- 근태 마감 검증 관리 : 일별 - 출퇴근 집계 VS 일근태 차이 내역     
  PROCEDURE MISMATCH_DI_DL
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						); 

-- 근태 마감 검증 관리 : 일별 - 일근태 미마감 내역     
  PROCEDURE DAY_LEAVE_NOT_CLOSED
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						); 

-- 근태 마감 검증 관리 : 일별 - 일근태  잔업 미계산 내역     
  PROCEDURE DAY_LEAVE_NOT_OT
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						); 
                        
                                                
-- 근태 마감 검증 관리 : 월별   
  PROCEDURE SELECT_MONTHLY
	          ( P_CURSOR1                  OUT TYPES.TCURSOR1
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);

-- 근태 마감 검증 관리 : 월별 - 미마감자 내역    
  PROCEDURE MONTHLY_NOT_CLOSED
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);

END HRD_DUTY_CLOSED_CHECK_G;
/
CREATE OR REPLACE PACKAGE BODY HRD_DUTY_CLOSED_CHECK_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DUTY_CLOSED_CHECK_G
/* DESCRIPTION  : 근태 마감 검증 관리  
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-----------------------------------------------------------------------------------------
-- 근태 마감 검증 관리 : 일별  
  PROCEDURE SELECT_DAILY
	          ( P_CURSOR                   OUT TYPES.TCURSOR
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN	  
    OPEN P_CURSOR FOR
      SELECT  TS1.WORK_DATE
            , TS1.PERSON_COUNT
            , TS1.EXCEPT_PERSON_COUNT
            , NVL(TS1.PERSON_COUNT, 0) - NVL(TS1.EXCEPT_PERSON_COUNT, 0) AS REAL_DUTY_PERSON_COUNT
            , TS1.M_DUTY_MANAGER_COUNT
            , TS1.M_WORK_CALENDAR_COUNT
            , TS1.DI_COUNT  
            , TS1.DI_TRANS_COUNT  
            , NVL(TS1.DI_COUNT, 0) - NVL(TS1.DI_TRANS_COUNT, 0) AS M_DI_TRANS_COIUNT
            , TS1.DL_COUNT  
            , TS1.DL_CLOSED_COUNT  
            , NVL(TS1.DL_COUNT, 0) - NVL(TS1.DL_CLOSED_COUNT, 0) AS M_DL_CLOSED_COUNT
            , TS1.M_DL_OT_COUNT                       
        FROM (
              SELECT -- 근무일자 --
                     T1.WORK_DATE   
                     -- 해당일자 인원현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                     ) AS PERSON_COUNT  
                     -- 해당일자 근무예외처리자 현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER  PM 
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL))
                                )
                     ) AS EXCEPT_PERSON_COUNT  
                     -- 미등록 작업장 현황 --  
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                            , HRM_HISTORY_LINE  HL                               
                        WHERE PM.PERSON_ID            = HL.PERSON_ID
                          AND PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND HL.HISTORY_LINE_ID      IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                              FROM HRM_HISTORY_LINE S_HL
                                                             WHERE S_HL.CHARGE_DATE            <= T1.WORK_DATE
                                                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                             GROUP BY S_HL.PERSON_ID
                                                           )
                          AND NOT EXISTS
                                ( SELECT 'X'
                                    FROM HRD_DUTY_MANAGER DM
                                   WHERE DM.DUTY_CONTROL_ID = HL.FLOOR_ID
                                     AND DM.USABLE          = 'Y'
                                     AND DM.START_DATE      <= T1.WORK_DATE
                                     AND (DM.END_DATE       >= T1.WORK_DATE OR DM.END_DATE IS NULL)
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS M_DUTY_MANAGER_COUNT  
                     -- 미등록 근무계획 현황 -- 
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND NOT EXISTS
                                ( SELECT 'X'
                                    FROM HRD_WORK_CALENDAR WC
                                   WHERE WC.PERSON_ID   = PM.PERSON_ID
                                     AND WC.WORK_DATE   = T1.WORK_DATE
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS M_WORK_CALENDAR_COUNT  
                     -- 출퇴근 집계 현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRD_DAY_INTERFACE DI
                                   WHERE DI.PERSON_ID   = PM.PERSON_ID
                                     AND DI.WORK_DATE   = T1.WORK_DATE
                                     AND DI.SOB_ID      = PM.SOB_ID
                                     AND DI.ORG_ID      = PM.ORG_ID
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS DI_COUNT  
                     -- 출퇴근 이첩 집계 현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRD_DAY_INTERFACE DI
                                   WHERE DI.PERSON_ID   = PM.PERSON_ID
                                     AND DI.WORK_DATE   = T1.WORK_DATE
                                     AND DI.SOB_ID      = PM.SOB_ID
                                     AND DI.ORG_ID      = PM.ORG_ID
                                     AND DI.TRANS_YN    = 'Y'
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS DI_TRANS_COUNT  
                     -- 일근태 집계 현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRD_DAY_LEAVE DL
                                   WHERE DL.PERSON_ID   = PM.PERSON_ID
                                     AND DL.WORK_DATE   = T1.WORK_DATE
                                     AND DL.SOB_ID      = PM.SOB_ID
                                     AND DL.ORG_ID      = PM.ORG_ID
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS DL_COUNT  
                     -- 일근태 마감 집계 현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRD_DAY_LEAVE DL
                                   WHERE DL.PERSON_ID   = PM.PERSON_ID
                                     AND DL.WORK_DATE   = T1.WORK_DATE
                                     AND DL.SOB_ID      = PM.SOB_ID
                                     AND DL.ORG_ID      = PM.ORG_ID
                                     AND DL.CLOSED_YN   = 'Y'
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS DL_CLOSED_COUNT  
                     -- 일근태 잔업 미계산 현황 --
                   , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.WORK_DATE
                          AND (PM.RETIRE_DATE         >= T1.WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND NOT EXISTS
                                ( SELECT 'X'
                                    FROM HRD_DAY_LEAVE_OT DL
                                   WHERE DL.PERSON_ID   = PM.PERSON_ID
                                     AND DL.WORK_DATE   = T1.WORK_DATE
                                     AND DL.SOB_ID      = PM.SOB_ID
                                     AND DL.ORG_ID      = PM.ORG_ID
                                )
                          AND NOT EXISTS
                                (SELECT 'X'
                                   FROM HRD_DUTY_EXCEPTION DE
                                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                                    AND DE.ENABLED_FLAG         = 'Y'
                                    AND DE.EFFECTIVE_DATE_FR    <= T1.WORK_DATE
                                    AND (DE.EFFECTIVE_DATE_TO   >= T1.WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                                    AND ((DE.OT_APPLY_YN        != 'Y' 
                                    OR    DE.OT_APPLY_YN        IS NULL)
                                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                                    OR    DE.OT_EXCEPT_YN       IS NULL)
                                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                                    OR    DE.ADJUST_TIME_YN     IS NULL)
                                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                                    OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
                                )
                     ) AS M_DL_OT_COUNT  
                FROM (SELECT SX1.START_DATE + (LEVEL - 1) AS WORK_DATE    
                           , W_CORP_ID AS CORP_ID
                           , W_SOB_ID  AS SOB_ID
                           , W_ORG_ID  AS ORG_ID
                        FROM ( SELECT TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') AS START_DATE
                                    , LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM')) - TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') + 1 AS MONTH_DAY
                                 FROM DUAL
                             ) SX1
                      CONNECT BY (LEVEL <= MONTH_DAY)       
                     ) T1
              ) TS1       
      ;
  END SELECT_DAILY;

-- 근태 마감 검증 관리 : 일별 - 작업장 미등록내역      
  PROCEDURE DAILY_NOT_DUTY_MANAGER
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
       FROM HRM_PERSON_MASTER PM
          , HRM_HISTORY_LINE  HL                               
      WHERE PM.PERSON_ID            = HL.PERSON_ID
        AND PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND HL.HISTORY_LINE_ID      IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
                 WHERE DM.DUTY_CONTROL_ID = HL.FLOOR_ID
                   AND DM.USABLE          = 'Y'
                   AND DM.START_DATE      <= W_WORK_DATE
                   AND (DM.END_DATE       >= W_WORK_DATE OR DM.END_DATE IS NULL)
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL))
              )   
      ;
  END DAILY_NOT_DUTY_MANAGER;

-- 근태 마감 검증 관리 : 일별 - 근무계획 미등록내역      
  PROCEDURE DAILY_NOT_WORK_CALENDAR
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE AS RETIRE_DATE
       FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_WORK_CALENDAR WC
                 WHERE WC.PERSON_ID   = PM.PERSON_ID
                   AND WC.WORK_DATE   = W_WORK_DATE
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
              )
      ;
  END DAILY_NOT_WORK_CALENDAR;
    
-- 근태 마감 검증 관리 : 일별 - 출퇴근 집계 미등록내역      
  PROCEDURE NOT_DAY_INTERFACE
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
        FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_DAY_INTERFACE DI
                 WHERE DI.PERSON_ID   = PM.PERSON_ID
                   AND DI.WORK_DATE   = W_WORK_DATE
                   AND DI.SOB_ID      = PM.SOB_ID
                   AND DI.ORG_ID      = PM.ORG_ID
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL))
              )               
      ;
  END NOT_DAY_INTERFACE;
  
-- 근태 마감 검증 관리 : 일별 - 출퇴근 집계 미이첩 내역     
  PROCEDURE DAY_INTERFACE_NOT_TRANS
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR 
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
        FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_DAY_INTERFACE DI
                 WHERE DI.PERSON_ID   = PM.PERSON_ID
                   AND DI.WORK_DATE   = W_WORK_DATE
                   AND DI.SOB_ID      = PM.SOB_ID
                   AND DI.ORG_ID      = PM.ORG_ID
                   AND DI.TRANS_YN    = 'Y'
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL))
              )   
      ;
  END DAY_INTERFACE_NOT_TRANS;
  
-- 근태 마감 검증 관리 : 일별 - 출퇴근 집계 VS 일근태 차이 내역     
  PROCEDURE MISMATCH_DI_DL
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
       FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_DAY_LEAVE DL
                 WHERE DL.PERSON_ID   = PM.PERSON_ID
                   AND DL.WORK_DATE   = W_WORK_DATE
                   AND DL.SOB_ID      = PM.SOB_ID
                   AND DL.ORG_ID      = PM.ORG_ID
              )
        AND EXISTS
              ( SELECT 'X'
                  FROM HRD_DAY_INTERFACE DI
                 WHERE DI.PERSON_ID   = PM.PERSON_ID
                   AND DI.WORK_DATE   = W_WORK_DATE
                   AND DI.CORP_ID     = PM.CORP_ID
                   AND DI.SOB_ID      = PM.SOB_ID
                   AND DI.ORG_ID      = PM.ORG_ID
                   AND DI.TRANS_YN    = 'Y'
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL))
              )   
      ;        
  END MISMATCH_DI_DL;
  
-- 근태 마감 검증 관리 : 일별 - 일근태 미마감 내역     
  PROCEDURE DAY_LEAVE_NOT_CLOSED
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
       FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_DAY_LEAVE DL
                 WHERE DL.PERSON_ID   = PM.PERSON_ID
                   AND DL.WORK_DATE   = W_WORK_DATE
                   AND DL.SOB_ID      = PM.SOB_ID
                   AND DL.ORG_ID      = PM.ORG_ID
                   AND DL.CLOSED_YN   = 'Y'
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL))
              )   
      ;      
  END DAY_LEAVE_NOT_CLOSED;
  
  -- 근태 마감 검증 관리 : 일별 - 일근태  잔업 미계산 내역     
  PROCEDURE DAY_LEAVE_NOT_OT
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_WORK_DATE                IN  DATE 
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
        FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= W_WORK_DATE
        AND (PM.RETIRE_DATE         >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRD_DAY_LEAVE  DL
                     , HRD_DAY_LEAVE_OT DLO
                 WHERE DL.DAY_LEAVE_ID  = DLO.DAY_LEAVE_ID
                   AND DL.PERSON_ID     = PM.PERSON_ID
                   AND DL.WORK_DATE     = W_WORK_DATE
                   AND DL.SOB_ID        = PM.SOB_ID
                   AND DL.ORG_ID        = PM.ORG_ID
              )
        AND NOT EXISTS
              (SELECT 'X'
                 FROM HRD_DUTY_EXCEPTION DE
                WHERE DE.PERSON_ID            = PM.PERSON_ID
                  AND DE.ENABLED_FLAG         = 'Y'
                  AND DE.EFFECTIVE_DATE_FR    <= W_WORK_DATE
                  AND (DE.EFFECTIVE_DATE_TO   >= W_WORK_DATE OR DE.EFFECTIVE_DATE_TO IS NULL)
                  AND ((DE.OT_APPLY_YN        != 'Y' 
                  OR    DE.OT_APPLY_YN        IS NULL)
                  AND  (DE.OT_EXCEPT_YN       != 'Y'
                  OR    DE.OT_EXCEPT_YN       IS NULL)
                  AND  (DE.ADJUST_TIME_YN     != 'Y'
                  OR    DE.ADJUST_TIME_YN     IS NULL)
                  AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                  OR    DE.AUTO_WORKTIME_YN   IS NULL)) 
              )  
      ;   
  END DAY_LEAVE_NOT_OT;
  
            
-- 근태 마감 검증 관리 : 월별   
  PROCEDURE SELECT_MONTHLY
	          ( P_CURSOR1                  OUT TYPES.TCURSOR1
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT TS1.PERSON_COUNT
           , TS1.MONTH_COUNT
           , TS1.MONTH_CLOSED_COUNT
           , NVL(TS1.MONTH_COUNT, 0) - NVL(TS1.MONTH_CLOSED_COUNT, 0) AS M_MONTH_CLOSED_COUNT
        FROM (
              SELECT -- 해당월 인원수 --
                     ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT             
                        FROM HRM_PERSON_MASTER PM
                      WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                        AND PM.SOB_ID               = T1.SOB_ID
                        AND PM.ORG_ID               = T1.ORG_ID
                        AND PM.JOIN_DATE            <= LAST_DAY(TO_DATE(T1.PERIOD_NAME, 'YYYY-MM'))
                        AND (PM.RETIRE_DATE         >= TRUNC(TO_DATE(T1.PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
                       ) AS PERSON_COUNT
                      -- 월근태 집계 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= LAST_DAY(TO_DATE(T1.PERIOD_NAME, 'YYYY-MM'))
                        AND (PM.RETIRE_DATE           >= TRUNC(TO_DATE(T1.PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X' AS PERSON_COUNT
                                   FROM HRD_MONTH_TOTAL MT
                                  WHERE MT.PERSON_ID          = PM.PERSON_ID
                                    AND MT.DUTY_TYPE          = 'D2'
                                    AND MT.DUTY_YYYYMM        = T1.PERIOD_NAME
                                    AND MT.SOB_ID             = T1.SOB_ID
                                    AND MT.ORG_ID             = T1.ORG_ID                      
                                )
                       ) AS MONTH_COUNT
                       -- 월근태 마감 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.WORK_CORP_ID         = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= LAST_DAY(TO_DATE(T1.PERIOD_NAME, 'YYYY-MM'))
                          AND (PM.RETIRE_DATE         >= TRUNC(TO_DATE(T1.PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X' AS PERSON_COUNT
                                   FROM HRD_MONTH_TOTAL MT
                                  WHERE MT.PERSON_ID          = PM.PERSON_ID
                                    AND MT.DUTY_TYPE          = 'D2'
                                    AND MT.DUTY_YYYYMM        = T1.PERIOD_NAME
                                    AND MT.SOB_ID             = T1.SOB_ID
                                    AND MT.ORG_ID             = T1.ORG_ID                      
                                    AND MT.CLOSED_YN          = 'Y'
                                )
                       ) AS MONTH_CLOSED_COUNT         
                FROM ( SELECT W_PERIOD_NAME AS PERIOD_NAME
                            , W_CORP_ID AS CORP_ID
                            , W_SOB_ID  AS SOB_ID
                            , W_ORG_ID  AS ORG_ID
                         FROM DUAL
                     ) T1
              ) TS1
      ;       
  END SELECT_MONTHLY;

-- 근태 마감 검증 관리 : 월별 - 미마감자 내역    
  PROCEDURE MONTHLY_NOT_CLOSED
	          ( P_CURSOR2                  OUT TYPES.TCURSOR2
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PM.PERSON_NUM
           , PM.NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
       FROM HRM_PERSON_MASTER PM
      WHERE PM.WORK_CORP_ID         = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND PM.JOIN_DATE            <= LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'))
        AND (PM.RETIRE_DATE         >= TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
        AND NOT EXISTS
              ( SELECT 'X' AS PERSON_COUNT
                 FROM HRD_MONTH_TOTAL MT
                WHERE MT.PERSON_ID          = PM.PERSON_ID
                  AND MT.SOB_ID             = PM.SOB_ID
                  AND MT.ORG_ID             = PM.ORG_ID
                  AND MT.DUTY_TYPE          = 'D2'
                  AND MT.DUTY_YYYYMM        = W_PERIOD_NAME
                  AND MT.CLOSED_YN          = 'Y'
              )
      ;        
  END MONTHLY_NOT_CLOSED;
  
END HRD_DUTY_CLOSED_CHECK_G;
/
