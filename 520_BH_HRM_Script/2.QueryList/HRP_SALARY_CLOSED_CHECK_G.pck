CREATE OR REPLACE PACKAGE HRP_SALARY_CLOSED_CHECK_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_SALARY_CLOSED_CHECK_G
/* DESCRIPTION  : 급여 마감 검증 관리
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-----------------------------------------------------------------------------------------
-- 급여 마감 체크사항 -- 
  PROCEDURE SELECT_SALARY_CLOSED
	          ( P_CURSOR                   OUT TYPES.TCURSOR
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);

-- 급여 마감 검증 관리 상세 조회 -- 
  PROCEDURE SELECT_SALARY_DETAIL
            ( P_CURSOR2                  OUT TYPES.TCURSOR2            
            , W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER            
            , W_DETAIL_TYPE              IN  VARCHAR2
            , W_ITEM_CODE                IN  VARCHAR2
            );

-- 급여 마감 항목별 체크사항 -- 
  PROCEDURE SELECT_SALARY_ITEM
	          ( P_CURSOR1                  OUT TYPES.TCURSOR
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						);

-- 급여 마감 : 전월 VS 당월 금액 비교 -- 
  PROCEDURE SELECT_SALARY_ITEM_AMOUNT
            ( P_CURSOR2                  OUT TYPES.TCURSOR2
            , W_CORP_ID                  IN  NUMBER
            , W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
            , W_SOB_ID                   IN  NUMBER
            , W_ORG_ID                   IN  NUMBER
            , W_AMOUNT_FR                IN  NUMBER
            , W_AMOUNT_TO                IN  NUMBER 
            );

-- 급여 마감 : 전월 VS 당월 금액 비교 => 대상자 조회 -- 
  PROCEDURE SELECT_SALARY_ITEM_DETAIL
            ( P_CURSOR2                  OUT TYPES.TCURSOR2            
            , W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER            
            , W_DETAIL_TYPE              IN  VARCHAR2
            , W_ITEM_ID                  IN  NUMBER
            , W_AMOUNT_FR                IN  NUMBER
            , W_AMOUNT_TO                IN  NUMBER 
            );
            
END HRP_SALARY_CLOSED_CHECK_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_SALARY_CLOSED_CHECK_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_SALARY_CLOSED_CHECK_G
/* DESCRIPTION  : 급여 마감 검증 관리
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-----------------------------------------------------------------------------------------
-- 급여 마감 체크사항 -- 
  PROCEDURE SELECT_SALARY_CLOSED
	          ( P_CURSOR                   OUT TYPES.TCURSOR
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS  
  BEGIN
    OPEN P_CURSOR FOR
      SELECT TS1.PERSON_COUNT 
           , TS1.PERSON_JOIN_COUNT 
           , TS1.PERSON_RETIRE_COUNT 
           , TS1.ADMINISTRATIVE_COUNT  
           , TS1.PERSON_PROMOTION_COUNT 
           , TS1.NO_PAY_MASTER_COUNT  
           , TS1.NG_PAY_TYPE_COUNT
           , TS1.NO_PAY_ITEM_COUNT  
           , TS1.NO_BANK_ACCOUNTS_COUNT
           , TS1.NO_PAY_PROVIDE_COUNT  
           , TS1.NO_BONUS_PROVIDE_COUNT  
           , TS1.NO_YEAR_PROVIDE_COUNT  
           , TS1.NO_HIRE_INSUR_COUNT  
           , TS1.NO_PENSION_COUNT  
           , TS1.NO_MEDIC_COUNT                               
           , TS1.MONTH_COUNT
           , TS1.MONTH_CLOSED_COUNT
           , NVL(TS1.MONTH_COUNT, 0) - NVL(TS1.MONTH_CLOSED_COUNT, 0) AS GAP_MONTH_CLOSED_COUNT
           , TS1.NO_SALARY_COUNT
           , TS1.GAP_ALLOWANCE_COUNT
           , TS1.GAP_DEDUCTION_COUNT
           , TS1.GAP_REAL_COUNT
        FROM (
              SELECT -- 해당월 인원수 --
                     ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT             
                          FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                       ) AS PERSON_COUNT
                      -- 당월 입사자(당월 입사 및 당월 퇴사는 퇴사자 인원현황에 포함) -- 
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT             
                          FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            BETWEEN T1.PERIOD_DATE_FR AND T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         > T1.PERIOD_DATE_TO OR PM.RETIRE_DATE IS NULL)
                       ) AS PERSON_JOIN_COUNT
                       -- 당월 퇴사자(당월 입사 및 당월 퇴사는 퇴사자 인원현황에 포함) -- 
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT             
                          FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND (PM.RETIRE_DATE         BETWEEN T1.PERIOD_DATE_FR AND T1.PERIOD_DATE_TO 
                          AND  PM.RETIRE_DATE         IS NOT NULL)
                       ) AS PERSON_RETIRE_COUNT
                      -- 당월 휴직자 변동 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRM_ADMINISTRATIVE_LEAVE AL
                                  WHERE AL.PERSON_ID          = PM.PERSON_ID
                                    AND AL.SOB_ID             = PM.SOB_ID
                                    AND AL.ORG_ID             = PM.ORG_ID
                                    AND (AL.START_DATE        BETWEEN T1.PERIOD_DATE_FR AND T1.PERIOD_DATE_TO
                                    OR   AL.END_DATE          BETWEEN T1.PERIOD_DATE_FR AND T1.PERIOD_DATE_TO)
                                )
                       ) AS ADMINISTRATIVE_COUNT 
                       -- 당월 인사발령 현황 : 승진/승급/직권해면 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRM_HISTORY_HEADER HH
                                      , HRM_HISTORY_LINE   HL
                                  WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                                    AND HL.PERSON_ID          = PM.PERSON_ID
                                    AND HH.SOB_ID             = PM.SOB_ID
                                    AND HH.ORG_ID             = PM.ORG_ID
                                    AND HH.CHARGE_DATE        BETWEEN T1.PERIOD_DATE_FR AND T1.PERIOD_DATE_TO
                                    AND EXISTS
                                          ( SELECT 'X'
                                              FROM HRM_CHARGE_CODE_V CC
                                             WHERE CC.COMMON_ID       = HH.CHARGE_ID
                                               AND CC.PROMOTION_FLAG  = 'Y'
                                          )
                                )
                       ) AS PERSON_PROMOTION_COUNT
                       -- 당월 급여마스터 미등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND NOT EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID          = PM.PERSON_ID
                                    AND MH.START_YYYYMM       <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM        >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                )
                       ) AS NO_PAY_MASTER_COUNT 
                       -- 당월 급여마스터 급여제 오류등록 현황 --
                    , (SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT                          
                         FROM HRM_PERSON_MASTER       PM
                            , HRM_HISTORY_LINE        HL  
                            , HRM_JOB_CATEGORY_CODE_V JC     
                        WHERE PM.PERSON_ID            = HL.PERSON_ID
                          AND HL.JOB_CATEGORY_ID      = JC.JOB_CATEGORY_ID
                          AND PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND HL.HISTORY_LINE_ID      IN (SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                            FROM HRM_HISTORY_HEADER S_HH
                                                               , HRM_HISTORY_LINE   S_HL
                                                           WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID                                           
                                                             AND S_HH.CHARGE_DATE       <= T1.PERIOD_DATE_TO
                                                             AND S_HL.PERSON_ID         = HL.PERSON_ID
                                                          GROUP BY S_HL.PERSON_ID
                                                         )
                          AND NOT EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID          = PM.PERSON_ID
                                    AND MH.START_YYYYMM       <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM        >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                    AND (MH.PAY_TYPE          = CASE
                                                                  WHEN JC.JOB_CATEGORY_CODE = '10' THEN '1'
                                                                  ELSE '0'
                                                                END
                                    OR   MH.PAY_TYPE          = CASE
                                                                  WHEN JC.JOB_CATEGORY_CODE = '10' THEN '3'
                                                                  ELSE '0'
                                                                END                                       
                                    OR   MH.PAY_TYPE          = CASE
                                                                  WHEN JC.JOB_CATEGORY_CODE = '20' THEN '2'
                                                                  ELSE '0'
                                                                END
                                    OR   MH.PAY_TYPE          = CASE
                                                                  WHEN JC.JOB_CATEGORY_CODE = '20' THEN '4'
                                                                  ELSE '0'
                                                                END) 
                                            
                                )
                       ) AS NG_PAY_TYPE_COUNT 
                      -- 당월 급여 마스터 수당 미등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND NOT EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                      , HRP_PAY_MASTER_LINE   ML
                                  WHERE MH.PAY_HEADER_ID      = ML.PAY_HEADER_ID
                                    AND MH.PERSON_ID          = PM.PERSON_ID
                                    AND ML.ENABLED_FLAG       = 'Y'
                                    AND MH.START_YYYYMM       <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM        >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                )
                       ) AS NO_PAY_ITEM_COUNT 
                       -- 당월 급여 미지급 등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID                = PM.PERSON_ID
                                    AND MH.START_YYYYMM             <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM              >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                    AND NVL(MH.PAY_PROVIDE_YN, 'N') = 'N'
                                )
                       ) AS NO_PAY_PROVIDE_COUNT 
                       -- 당월 상여 미지급 등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID                  = PM.PERSON_ID
                                    AND MH.START_YYYYMM               <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM                >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                    AND MH.PAY_TYPE                   IN('2', '4')  -- 월급제 / 연봉제 제외  
                                    AND NVL(MH.BONUS_PROVIDE_YN, 'N') = 'N'
                                )
                       ) AS NO_BONUS_PROVIDE_COUNT 
                       -- 당월 년차 미지급 등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID                  = PM.PERSON_ID
                                    AND MH.START_YYYYMM               <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM                >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                    AND MH.PAY_TYPE                   IN('2', '4')  -- 월급제 / 연봉제 제외  
                                    AND NVL(MH.YEAR_PROVIDE_YN, 'N')  = 'N'
                                )
                       ) AS NO_YEAR_PROVIDE_COUNT 
                       -- 당월 고용보험 미공제 등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID                  = PM.PERSON_ID
                                    AND MH.START_YYYYMM               <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM                >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                    AND NVL(MH.HIRE_INSUR_YN, 'N')    = 'N'
                                )
                       ) AS NO_HIRE_INSUR_COUNT 
                       -- 당월 국민보험 미공제 등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND NOT EXISTS
                                ( SELECT 'X'
                                   FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                                  WHERE IC.PERSON_ID                  = PM.PERSON_ID
                                    AND IC.INSUR_TYPE                 = 'P'
                                    AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                                )
                       ) AS NO_PENSION_COUNT 
                       -- 당월 건강보험 미공제 등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND NOT EXISTS
                                ( SELECT 'X'
                                   FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                                  WHERE IC.PERSON_ID                  = PM.PERSON_ID
                                    AND IC.INSUR_TYPE                 = 'M'
                                    AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                                )
                       ) AS NO_MEDIC_COUNT 
                       -- 당월 급여마스터 계좌 미등록 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X'
                                   FROM HRP_PAY_MASTER_HEADER MH
                                  WHERE MH.PERSON_ID          = PM.PERSON_ID
                                    AND MH.START_YYYYMM       <= T1.PERIOD_NAME
                                    AND (MH.END_YYYYMM        >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                                    AND MH.BANK_ACCOUNTS      IS NULL
                                )
                       ) AS NO_BANK_ACCOUNTS_COUNT 
                      -- 월근태 집계 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X' 
                                   FROM HRD_MONTH_TOTAL MT
                                  WHERE MT.PERSON_ID          = PM.PERSON_ID
                                    AND MT.DUTY_TYPE          = CASE
                                                                  WHEN T1.WAGE_TYPE IN('P1', 'P2') THEN 'D2'
                                                                  ELSE '-'
                                                                END
                                    AND MT.DUTY_YYYYMM        = T1.PERIOD_NAME
                                    AND MT.SOB_ID             = T1.SOB_ID
                                    AND MT.ORG_ID             = T1.ORG_ID                      
                                )
                       ) AS MONTH_COUNT
                      -- 월근태 마감 현황 --
                    , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.CORP_ID              = T1.CORP_ID
                          AND PM.SOB_ID               = T1.SOB_ID
                          AND PM.ORG_ID               = T1.ORG_ID
                          AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                          AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                          AND EXISTS
                                ( SELECT 'X' 
                                   FROM HRD_MONTH_TOTAL MT
                                  WHERE MT.PERSON_ID          = PM.PERSON_ID
                                    AND MT.DUTY_TYPE          = CASE
                                                                  WHEN T1.WAGE_TYPE IN('P1', 'P2') THEN 'D2'
                                                                  ELSE '-'
                                                                END
                                    AND MT.DUTY_YYYYMM        = T1.PERIOD_NAME
                                    AND MT.SOB_ID             = T1.SOB_ID
                                    AND MT.ORG_ID             = T1.ORG_ID                      
                                    AND MT.CLOSED_YN          = 'Y'
                                )
                       ) AS MONTH_CLOSED_COUNT     
                       -- 당월 급여/상여등 지급대상중 미지급 현황 --
                     , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                           FROM HRM_PERSON_MASTER     PM
                              , HRP_PAY_MASTER_HEADER MH
                          WHERE PM.PERSON_ID            = MH.PERSON_ID
                            AND PM.CORP_ID              = T1.CORP_ID
                            AND PM.SOB_ID               = T1.SOB_ID
                            AND PM.ORG_ID               = T1.ORG_ID
                            AND PM.JOIN_DATE            <= T1.PERIOD_DATE_TO
                            AND (PM.RETIRE_DATE         >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                            AND MH.START_YYYYMM         <= T1.PERIOD_NAME
                            AND (MH.END_YYYYMM          >= T1.PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                            AND ((T1.WAGE_TYPE          IN('P2', 'P3')
                              AND MH.BONUS_PROVIDE_YN   = 'Y')
                            OR   (T1.WAGE_TYPE          = 'P4'
                              AND MH.YEAR_PROVIDE_YN    = 'Y')
                            OR   (T1.WAGE_TYPE          NOT IN('P2', 'P3', 'P4')
                              AND MH.PAY_PROVIDE_YN     = 'Y'))
                            AND NOT EXISTS
                                  ( SELECT 'X'
                                     FROM HRP_MONTH_PAYMENT MP
                                    WHERE MP.PERSON_ID                = PM.PERSON_ID
                                      AND MP.PAY_YYYYMM               = T1.PERIOD_NAME
                                      AND MP.WAGE_TYPE                = T1.WAGE_TYPE
                                  )
                         ) AS NO_SALARY_COUNT    
                         -- 당월 급여/상여등 지급총액 오류 현황 --
                      , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                            FROM HRM_PERSON_MASTER     PM
                               , HRP_MONTH_PAYMENT     MP
                               , ( SELECT MA.MONTH_PAYMENT_ID
                                        , SUM(MA.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT
                                     FROM HRP_MONTH_ALLOWANCE MA
                                    WHERE MA.PAY_YYYYMM     = W_PERIOD_NAME
                                      AND MA.WAGE_TYPE      = W_WAGE_TYPE
                                      AND MA.CORP_ID        = W_CORP_ID
                                      AND MA.SOB_ID         = W_SOB_ID
                                      AND MA.ORG_ID         = W_ORG_ID
                                   GROUP BY MA.MONTH_PAYMENT_ID
                                 ) SX1
                          WHERE PM.PERSON_ID                  = MP.PERSON_ID
                            AND MP.MONTH_PAYMENT_ID           = SX1.MONTH_PAYMENT_ID
                            AND PM.CORP_ID                    = T1.CORP_ID
                            AND PM.SOB_ID                     = T1.SOB_ID
                            AND PM.ORG_ID                     = T1.ORG_ID
                            AND PM.JOIN_DATE                  <= T1.PERIOD_DATE_TO
                            AND (PM.RETIRE_DATE               >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                            AND MP.PAY_YYYYMM                 = T1.PERIOD_NAME
                            AND MP.WAGE_TYPE                  = T1.WAGE_TYPE
                            AND MP.SOB_ID                     = T1.SOB_ID
                            AND MP.ORG_ID                     = T1.ORG_ID
                            AND NVL(MP.TOT_SUPPLY_AMOUNT, 0)  != NVL(SX1.ALLOWANCE_AMOUNT, 0)                               
                         ) AS GAP_ALLOWANCE_COUNT
                         -- 당월 급여/상여등 공제총액 오류 현황 --
                      , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                            FROM HRM_PERSON_MASTER     PM
                               , HRP_MONTH_PAYMENT     MP
                               , ( SELECT MD.MONTH_PAYMENT_ID
                                        , SUM(MD.DEDUCTION_AMOUNT) AS DEDUCTION_AMOUNT
                                     FROM HRP_MONTH_DEDUCTION MD
                                    WHERE MD.PAY_YYYYMM     = W_PERIOD_NAME
                                      AND MD.WAGE_TYPE      = W_WAGE_TYPE
                                      AND MD.CORP_ID        = W_CORP_ID
                                      AND MD.SOB_ID         = W_SOB_ID
                                      AND MD.ORG_ID         = W_ORG_ID
                                   GROUP BY MD.MONTH_PAYMENT_ID
                                 ) SX1
                          WHERE PM.PERSON_ID                  = MP.PERSON_ID
                            AND MP.MONTH_PAYMENT_ID           = SX1.MONTH_PAYMENT_ID
                            AND PM.CORP_ID                    = T1.CORP_ID
                            AND PM.SOB_ID                     = T1.SOB_ID
                            AND PM.ORG_ID                     = T1.ORG_ID
                            AND PM.JOIN_DATE                  <= T1.PERIOD_DATE_TO
                            AND (PM.RETIRE_DATE               >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                            AND MP.PAY_YYYYMM                 = T1.PERIOD_NAME
                            AND MP.WAGE_TYPE                  = T1.WAGE_TYPE
                            AND MP.SOB_ID                     = T1.SOB_ID
                            AND MP.ORG_ID                     = T1.ORG_ID
                            AND NVL(MP.TOT_DED_AMOUNT, 0)     != NVL(SX1.DEDUCTION_AMOUNT, 0)                                                       
                         ) AS GAP_DEDUCTION_COUNT
                         -- 당월 급여/상여등 실지급액 총액 오류 현황 --
                      , ( SELECT COUNT(PM.PERSON_ID) AS PERSON_COUNT
                            FROM HRM_PERSON_MASTER     PM
                               , HRP_MONTH_PAYMENT     MP
                               , ( SELECT T1.MONTH_PAYMENT_ID
                                        , SUM(T1.AMOUNT) AS AMOUNT
                                     FROM (SELECT MA.MONTH_PAYMENT_ID
                                                , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
                                             FROM HRP_MONTH_ALLOWANCE MA
                                            WHERE MA.PAY_YYYYMM     = W_PERIOD_NAME
                                              AND MA.WAGE_TYPE      = W_WAGE_TYPE
                                              AND MA.CORP_ID        = W_CORP_ID
                                              AND MA.SOB_ID         = W_SOB_ID
                                              AND MA.ORG_ID         = W_ORG_ID
                                            GROUP BY MA.MONTH_PAYMENT_ID
                                           UNION ALL
                                           SELECT MD.MONTH_PAYMENT_ID
                                                , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                                             FROM HRP_MONTH_DEDUCTION MD
                                            WHERE MD.PAY_YYYYMM     = W_PERIOD_NAME
                                              AND MD.WAGE_TYPE      = W_WAGE_TYPE
                                              AND MD.CORP_ID        = W_CORP_ID
                                              AND MD.SOB_ID         = W_SOB_ID
                                              AND MD.ORG_ID         = W_ORG_ID
                                           GROUP BY MD.MONTH_PAYMENT_ID 
                                          ) T1
                                   GROUP BY T1.MONTH_PAYMENT_ID
                                 ) SX1
                          WHERE PM.PERSON_ID                  = MP.PERSON_ID
                            AND MP.MONTH_PAYMENT_ID           = SX1.MONTH_PAYMENT_ID
                            AND PM.CORP_ID                    = T1.CORP_ID
                            AND PM.SOB_ID                     = T1.SOB_ID
                            AND PM.ORG_ID                     = T1.ORG_ID
                            AND PM.JOIN_DATE                  <= T1.PERIOD_DATE_TO
                            AND (PM.RETIRE_DATE               >= T1.PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                            AND MP.PAY_YYYYMM                 = T1.PERIOD_NAME
                            AND MP.WAGE_TYPE                  = T1.WAGE_TYPE
                            AND MP.SOB_ID                     = T1.SOB_ID
                            AND MP.ORG_ID                     = T1.ORG_ID
                            AND NVL(MP.REAL_AMOUNT, 0)        != NVL(SX1.AMOUNT, 0)       
                         ) AS GAP_REAL_COUNT
                FROM ( SELECT W_PERIOD_NAME AS PERIOD_NAME
                            , TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH') AS PERIOD_DATE_FR
                            , LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM')) AS PERIOD_DATE_TO
                            , W_WAGE_TYPE   AS WAGE_TYPE
                            , W_CORP_ID AS CORP_ID
                            , W_SOB_ID  AS SOB_ID
                            , W_ORG_ID  AS ORG_ID
                         FROM DUAL
                     ) T1
              ) TS1
      ;     
  END SELECT_SALARY_CLOSED;

-- 급여 마감 검증 관리 상세 조회 -- 
  PROCEDURE SELECT_SALARY_DETAIL
            ( P_CURSOR2                  OUT TYPES.TCURSOR2
            , W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
            , W_DETAIL_TYPE              IN  VARCHAR2
            , W_ITEM_CODE                IN  VARCHAR2
            )
  AS
    V_PERIOD_DATE_FR    DATE := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH');
    V_PERIOD_DATE_TO    DATE := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
  BEGIN
    IF W_DETAIL_TYPE = 'JOIN' THEN
      -- 당월 입사자(당월 입사 및 당월 퇴사는 퇴사자 인원현황에 포함) -- 
      OPEN P_CURSOR2 FOR      
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID      
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC  
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            BETWEEN V_PERIOD_DATE_FR AND V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         > V_PERIOD_DATE_TO OR PM.RETIRE_DATE IS NULL)
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'RETIRE' THEN
      -- 당월 퇴사자(당월 입사 및 당월 퇴사는 퇴사자 인원현황에 포함) -- 
      OPEN P_CURSOR2 FOR      
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID    
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC     
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
        FROM HRM_PERSON_MASTER PM
      WHERE PM.CORP_ID              = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND (PM.RETIRE_DATE         BETWEEN V_PERIOD_DATE_FR AND V_PERIOD_DATE_TO
        AND  PM.RETIRE_DATE         IS NOT NULL)              
      ORDER BY PM.PERSON_NUM
      ;
    ELSIF W_DETAIL_TYPE = 'ADMINISTRATIVE' THEN
      -- 당월 휴직자 변동 현황 -- 
      OPEN P_CURSOR2 FOR      
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC  
          FROM HRM_PERSON_MASTER PM
         WHERE PM.CORP_ID              = W_CORP_ID
           AND PM.SOB_ID               = W_SOB_ID
           AND PM.ORG_ID               = W_ORG_ID
           AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
           AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
           AND EXISTS
                 ( SELECT 'X'
                     FROM HRM_ADMINISTRATIVE_LEAVE AL
                    WHERE AL.PERSON_ID          = PM.PERSON_ID
                      AND AL.SOB_ID             = PM.SOB_ID
                      AND AL.ORG_ID             = PM.ORG_ID
                      AND (AL.START_DATE        BETWEEN V_PERIOD_DATE_FR AND V_PERIOD_DATE_TO
                      OR   AL.END_DATE          BETWEEN V_PERIOD_DATE_FR AND V_PERIOD_DATE_TO)
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'PROMOTION' THEN
      -- 당월 인사발령 현황 : 승진/승급/직권해면 -- 
      OPEN P_CURSOR2 FOR      
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC  
          FROM HRM_PERSON_MASTER PM
         WHERE PM.CORP_ID              = W_CORP_ID
           AND PM.SOB_ID               = W_SOB_ID
           AND PM.ORG_ID               = W_ORG_ID
           AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
           AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
           AND EXISTS
                 ( SELECT 'X'
                    FROM HRM_HISTORY_HEADER HH
                       , HRM_HISTORY_LINE   HL
                   WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                     AND HL.PERSON_ID          = PM.PERSON_ID
                     AND HH.SOB_ID             = PM.SOB_ID
                     AND HH.ORG_ID             = PM.ORG_ID
                     AND HH.CHARGE_DATE        BETWEEN V_PERIOD_DATE_FR AND V_PERIOD_DATE_TO
                     AND EXISTS
                           ( SELECT 'X'
                               FROM HRM_CHARGE_CODE_V CC
                              WHERE CC.COMMON_ID       = HH.CHARGE_ID
                                AND CC.PROMOTION_FLAG  = 'Y'
                           )
                )
        ORDER BY PM.PERSON_NUM
        ; 
    ELSIF W_DETAIL_TYPE = 'PAY_MASTER' THEN
      -- 당월 급여마스터 미등록 현황 -- 
      OPEN P_CURSOR2 FOR    
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC  
             FROM HRM_PERSON_MASTER PM
            WHERE PM.CORP_ID              = W_CORP_ID
              AND PM.SOB_ID               = W_SOB_ID
              AND PM.ORG_ID               = W_ORG_ID
              AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
              AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
              AND NOT EXISTS
                    ( SELECT 'X'
                       FROM HRP_PAY_MASTER_HEADER MH
                      WHERE MH.PERSON_ID          = PM.PERSON_ID
                        AND MH.START_YYYYMM       <= W_PERIOD_NAME
                        AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'PAY_TYPE' THEN
      -- 당월 급여마스터 급여제 오류등록 현황 -- 
      OPEN P_CURSOR2 FOR    
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
           FROM HRM_PERSON_MASTER       PM
              , HRM_HISTORY_LINE        HL  
              , HRM_JOB_CATEGORY_CODE_V JC     
          WHERE PM.PERSON_ID            = HL.PERSON_ID
            AND HL.JOB_CATEGORY_ID      = JC.JOB_CATEGORY_ID
            AND PM.CORP_ID              = W_CORP_ID
            AND PM.SOB_ID               = W_SOB_ID
            AND PM.ORG_ID               = W_ORG_ID
            AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
            AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
            AND HL.HISTORY_LINE_ID      IN (SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_HEADER S_HH
                                                 , HRM_HISTORY_LINE   S_HL
                                             WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID                                           
                                               AND S_HH.CHARGE_DATE       <= V_PERIOD_DATE_TO
                                               AND S_HL.PERSON_ID         = HL.PERSON_ID
                                            GROUP BY S_HL.PERSON_ID
                                           )
            AND NOT EXISTS
                  ( SELECT 'X'
                     FROM HRP_PAY_MASTER_HEADER MH
                    WHERE MH.PERSON_ID          = PM.PERSON_ID
                      AND MH.START_YYYYMM       <= W_PERIOD_NAME
                      AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                      AND (MH.PAY_TYPE          = CASE
                                                    WHEN JC.JOB_CATEGORY_CODE = '10' THEN '1'
                                                    ELSE '0'
                                                  END
                      OR   MH.PAY_TYPE          = CASE
                                                    WHEN JC.JOB_CATEGORY_CODE = '10' THEN '3'
                                                    ELSE '0'
                                                  END                                       
                      OR   MH.PAY_TYPE          = CASE
                                                    WHEN JC.JOB_CATEGORY_CODE = '20' THEN '2'
                                                    ELSE '0'
                                                  END
                      OR   MH.PAY_TYPE          = CASE
                                                    WHEN JC.JOB_CATEGORY_CODE = '20' THEN '4'
                                                    ELSE '0'
                                                  END) 
                                
                  )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'PAY_ITEM' THEN
      -- 당월 급여 마스터 수당 미등록 현황 --
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC  
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_PAY_MASTER_HEADER MH
                      , HRP_PAY_MASTER_LINE   ML
                  WHERE MH.PAY_HEADER_ID      = ML.PAY_HEADER_ID
                    AND MH.PERSON_ID          = PM.PERSON_ID
                    AND MH.START_YYYYMM       <= W_PERIOD_NAME
                    AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    AND ML.ENABLED_FLAG       = 'Y'
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'BANK_ACCOUNTS' THEN
      -- 당월 급여마스터 계좌 미등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_PAY_MASTER_HEADER MH
                  WHERE MH.PERSON_ID          = PM.PERSON_ID
                    AND MH.START_YYYYMM       <= W_PERIOD_NAME
                    AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    AND MH.BANK_ACCOUNTS      IS NULL
                ) 
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'PAY_PROVIDE' THEN
      -- 당월 급여 미지급 등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_PAY_MASTER_HEADER MH
                  WHERE MH.PERSON_ID                = PM.PERSON_ID
                    AND MH.START_YYYYMM             <= W_PERIOD_NAME
                    AND (MH.END_YYYYMM              >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    AND NVL(MH.PAY_PROVIDE_YN, 'N') = 'N'
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'BONUS_PROVIDE' THEN
      -- 당월 상여 미지급 등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC  
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_PAY_MASTER_HEADER MH
                  WHERE MH.PERSON_ID                  = PM.PERSON_ID
                    AND MH.START_YYYYMM               <= W_PERIOD_NAME
                    AND (MH.END_YYYYMM                >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    AND MH.PAY_TYPE                   IN('2', '4')  -- 월급제 / 연봉제 제외  
                    AND NVL(MH.BONUS_PROVIDE_YN, 'N') = 'N'
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'YEAR_PROVIDE' THEN
      -- 당월 년차 미지급 등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC  
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_PAY_MASTER_HEADER MH
                  WHERE MH.PERSON_ID                  = PM.PERSON_ID
                    AND MH.START_YYYYMM               <= W_PERIOD_NAME
                    AND (MH.END_YYYYMM                >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    AND MH.PAY_TYPE                   IN('2', '4')  -- 월급제 / 연봉제 제외  
                    AND NVL(MH.YEAR_PROVIDE_YN, 'N')  = 'N'
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'HIRE_INSUR' THEN
      -- 당월 고용보험 미공제 등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_PAY_MASTER_HEADER MH
                  WHERE MH.PERSON_ID                  = PM.PERSON_ID
                    AND MH.START_YYYYMM               <= W_PERIOD_NAME
                    AND (MH.END_YYYYMM                >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                    AND NVL(MH.HIRE_INSUR_YN, 'N')    = 'N'
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'PENSION_INSUR' THEN
      -- 당월 국민보험 미공제 등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                  WHERE IC.PERSON_ID                  = PM.PERSON_ID
                    AND IC.INSUR_TYPE                 = 'P'
                    AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                )
        ORDER BY PM.PERSON_NUM
        ;
    ELSIF W_DETAIL_TYPE = 'MEDIC_INSUR' THEN
      -- 당월 건강보험 미공제 등록 현황 -- 
      OPEN P_CURSOR2 FOR            
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                  WHERE IC.PERSON_ID                  = PM.PERSON_ID
                    AND IC.INSUR_TYPE                 = 'M'
                    AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                ) 
        ORDER BY PM.PERSON_NUM
        ;    
    ELSIF W_DETAIL_TYPE = 'MONTH_DUTY' THEN
      -- 당월 월근태 미마감 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
         FROM HRM_PERSON_MASTER PM
        WHERE PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND NOT EXISTS
                ( SELECT 'X' AS PERSON_COUNT
                   FROM HRD_MONTH_TOTAL MT
                  WHERE MT.PERSON_ID          = PM.PERSON_ID
                    AND MT.DUTY_TYPE          = CASE
                                                  WHEN W_WAGE_TYPE IN('P1', 'P2') THEN 'D2'
                                                  ELSE '-'
                                                END
                    AND MT.DUTY_YYYYMM        = W_PERIOD_NAME
                    AND MT.CLOSED_YN          = 'Y'
                )
          AND NOT EXISTS
                (SELECT 'X'
                   FROM HRD_DUTY_EXCEPTION DE
                  WHERE DE.PERSON_ID            = PM.PERSON_ID
                    AND DE.ENABLED_FLAG         = 'Y'
                    AND DE.EFFECTIVE_DATE_FR    <= V_PERIOD_DATE_TO
                    AND (DE.EFFECTIVE_DATE_TO   >= V_PERIOD_DATE_FR OR DE.EFFECTIVE_DATE_TO IS NULL)
                    AND ((DE.OT_APPLY_YN        != 'Y' 
                    OR    DE.OT_APPLY_YN        IS NULL)
                    AND  (DE.OT_EXCEPT_YN       != 'Y'
                    OR    DE.OT_EXCEPT_YN       IS NULL)
                    AND  (DE.ADJUST_TIME_YN     != 'Y'
                    OR    DE.ADJUST_TIME_YN     IS NULL)
                    AND  (DE.AUTO_WORKTIME_YN   != 'Y'
                    OR    DE.AUTO_WORKTIME_YN   IS NULL))
                )   
        ORDER BY PM.PERSON_NUM
        ;                
    ELSIF W_DETAIL_TYPE = 'NO_SALARY' THEN
      -- 당월 급여/상여등 지급대상중 미지급 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER     PM
             , HRP_PAY_MASTER_HEADER MH
        WHERE PM.PERSON_ID            = MH.PERSON_ID
          AND PM.CORP_ID              = W_CORP_ID
          AND PM.SOB_ID               = W_SOB_ID
          AND PM.ORG_ID               = W_ORG_ID
          AND PM.JOIN_DATE            <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE         >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MH.START_YYYYMM         <= W_PERIOD_NAME
          AND (MH.END_YYYYMM          >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
          AND ((W_WAGE_TYPE           IN('P2', 'P3')
            AND MH.BONUS_PROVIDE_YN   = 'Y')
          OR   (W_WAGE_TYPE           = 'P4'
            AND MH.YEAR_PROVIDE_YN    = 'Y')
          OR   (W_WAGE_TYPE           NOT IN('P2', 'P3', 'P4')
            AND MH.PAY_PROVIDE_YN     = 'Y'))
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_PAYMENT MP
                  WHERE MP.PERSON_ID                = PM.PERSON_ID
                    AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                    AND MP.WAGE_TYPE                = W_WAGE_TYPE
                )
        ;            
    ELSIF W_DETAIL_TYPE = 'GAP_ALLOWANCE' THEN
      -- 당월 급여/상여등 지급총액 오류 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER     PM
             , HRP_MONTH_PAYMENT     MP
             , ( SELECT MA.MONTH_PAYMENT_ID
                      , SUM(MA.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT
                   FROM HRP_MONTH_ALLOWANCE MA
                  WHERE MA.PAY_YYYYMM     = W_PERIOD_NAME
                    AND MA.WAGE_TYPE      = W_WAGE_TYPE
                    AND MA.CORP_ID        = W_CORP_ID
                    AND MA.SOB_ID         = W_SOB_ID
                    AND MA.ORG_ID         = W_ORG_ID
                 GROUP BY MA.MONTH_PAYMENT_ID
               ) SX1
        WHERE PM.PERSON_ID                  = MP.PERSON_ID
          AND MP.MONTH_PAYMENT_ID           = SX1.MONTH_PAYMENT_ID
          AND PM.CORP_ID                    = W_CORP_ID
          AND PM.SOB_ID                     = W_SOB_ID
          AND PM.ORG_ID                     = W_ORG_ID
          AND PM.JOIN_DATE                  <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE               >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM                 = W_PERIOD_NAME
          AND MP.WAGE_TYPE                  = W_WAGE_TYPE
          AND MP.SOB_ID                     = W_SOB_ID
          AND MP.ORG_ID                     = W_ORG_ID
          AND NVL(MP.TOT_SUPPLY_AMOUNT, 0)  != NVL(SX1.ALLOWANCE_AMOUNT, 0)   
        ;          
    ELSIF W_DETAIL_TYPE = 'GAP_DEDUCTION' THEN
      -- 당월 급여/상여등 공제총액 오류 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER     PM
             , HRP_MONTH_PAYMENT     MP
             , ( SELECT MD.MONTH_PAYMENT_ID
                      , SUM(MD.DEDUCTION_AMOUNT) AS DEDUCTION_AMOUNT
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.PAY_YYYYMM     = W_PERIOD_NAME
                    AND MD.WAGE_TYPE      = W_WAGE_TYPE
                    AND MD.CORP_ID        = W_CORP_ID
                    AND MD.SOB_ID         = W_SOB_ID
                    AND MD.ORG_ID         = W_ORG_ID
                 GROUP BY MD.MONTH_PAYMENT_ID
               ) SX1
        WHERE PM.PERSON_ID                  = MP.PERSON_ID
          AND MP.MONTH_PAYMENT_ID           = SX1.MONTH_PAYMENT_ID
          AND PM.CORP_ID                    = W_CORP_ID
          AND PM.SOB_ID                     = W_SOB_ID
          AND PM.ORG_ID                     = W_ORG_ID
          AND PM.JOIN_DATE                  <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE               >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM                 = W_PERIOD_NAME
          AND MP.WAGE_TYPE                  = W_WAGE_TYPE
          AND MP.SOB_ID                     = W_SOB_ID
          AND MP.ORG_ID                     = W_ORG_ID
          AND NVL(MP.TOT_DED_AMOUNT, 0)     != NVL(SX1.DEDUCTION_AMOUNT, 0)  
        ;          
    ELSIF W_DETAIL_TYPE = 'GAP_REAL' THEN
      -- 당월 급여/상여등 실지급액 총액 오류 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER     PM
             , HRP_MONTH_PAYMENT     MP
             , ( SELECT T1.MONTH_PAYMENT_ID
                      , SUM(T1.AMOUNT) AS AMOUNT
                   FROM (SELECT MA.MONTH_PAYMENT_ID
                              , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
                           FROM HRP_MONTH_ALLOWANCE MA
                          WHERE MA.PAY_YYYYMM     = W_PERIOD_NAME
                            AND MA.WAGE_TYPE      = W_WAGE_TYPE
                            AND MA.CORP_ID        = W_CORP_ID
                            AND MA.SOB_ID         = W_SOB_ID
                            AND MA.ORG_ID         = W_ORG_ID
                          GROUP BY MA.MONTH_PAYMENT_ID
                         UNION ALL
                         SELECT MD.MONTH_PAYMENT_ID
                              , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                           FROM HRP_MONTH_DEDUCTION MD
                          WHERE MD.PAY_YYYYMM     = W_PERIOD_NAME
                            AND MD.WAGE_TYPE      = W_WAGE_TYPE
                            AND MD.CORP_ID        = W_CORP_ID
                            AND MD.SOB_ID         = W_SOB_ID
                            AND MD.ORG_ID         = W_ORG_ID
                         GROUP BY MD.MONTH_PAYMENT_ID 
                        ) T1
                 GROUP BY T1.MONTH_PAYMENT_ID
               ) SX1
        WHERE PM.PERSON_ID                  = MP.PERSON_ID
          AND MP.MONTH_PAYMENT_ID           = SX1.MONTH_PAYMENT_ID
          AND PM.CORP_ID                    = W_CORP_ID
          AND PM.SOB_ID                     = W_SOB_ID
          AND PM.ORG_ID                     = W_ORG_ID
          AND PM.JOIN_DATE                  <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE               >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM                 = W_PERIOD_NAME
          AND MP.WAGE_TYPE                  = W_WAGE_TYPE
          AND MP.SOB_ID                     = W_SOB_ID
          AND MP.ORG_ID                     = W_ORG_ID
          AND NVL(MP.REAL_AMOUNT, 0)        != NVL(SX1.AMOUNT, 0)          
      ;  
    ELSIF W_DETAIL_TYPE = 'AM' THEN
      -- 당월 급여마스터 존재 VS 급여 미반영 항목 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
         FROM HRM_PERSON_MASTER     PM
            , HRP_MONTH_PAYMENT     MP
            , ( SELECT MH.PERSON_ID
                     , ML.ALLOWANCE_ID
                     , ML.ALLOWANCE_AMOUNT
                  FROM HRP_PAY_MASTER_HEADER MH
                     , HRP_PAY_MASTER_LINE   ML
                WHERE MH.PAY_HEADER_ID      = ML.PAY_HEADER_ID
                  AND MH.START_YYYYMM       <= W_PERIOD_NAME
                  AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                  AND MH.SOB_ID             = W_SOB_ID
                  AND MH.ORG_ID             = W_ORG_ID
                  AND ML.ALLOWANCE_TYPE     = 'A'
                  AND ML.ENABLED_FLAG       = 'Y'   
                  AND EXISTS
                        ( SELECT 'X'
                            FROM HRM_ALLOWANCE_V HA
                           WHERE HA.ALLOWANCE_ID    = ML.ALLOWANCE_ID
                             AND HA.ALLOWANCE_CODE  = W_ITEM_CODE  -- 'A03'
                        )                           
              ) SX1
        WHERE PM.PERSON_ID                = MP.PERSON_ID
          AND MP.PERSON_ID                = SX1.PERSON_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_ALLOWANCE MA
                  WHERE MA.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND MA.ALLOWANCE_ID             = SX1.ALLOWANCE_ID  
                    AND EXISTS
                          ( SELECT 'X'
                              FROM HRM_ALLOWANCE_V HA
                             WHERE HA.ALLOWANCE_ID    = SX1.ALLOWANCE_ID
                               AND HA.ALLOWANCE_CODE  = W_ITEM_CODE  -- 'A03'
                          )                 
                )
        ;
    ELSIF W_DETAIL_TYPE = 'AA' THEN
      -- 당월 급상여 추가 존재 VS 급여 미반영 항목 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
         FROM HRM_PERSON_MASTER         PM
            , HRP_MONTH_PAYMENT         MP
            , HRP_PAYMENT_ADD_ALLOWANCE PAA
            , HRM_ALLOWANCE_V           HA
        WHERE PM.PERSON_ID                = MP.PERSON_ID
          AND MP.PERSON_ID                = PAA.PERSON_ID
          AND MP.PAY_YYYYMM               = PAA.PAY_YYYYMM
          AND MP.WAGE_TYPE                = PAA.WAGE_TYPE
          AND MP.SOB_ID                   = PAA.SOB_ID
          AND MP.ORG_ID                   = PAA.ORG_ID
          AND PAA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND HA.ALLOWANCE_CODE           = W_ITEM_CODE
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_ALLOWANCE MA
                  WHERE MA.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND MA.ALLOWANCE_ID             = PAA.ALLOWANCE_ID                    
                )
        ;
    ELSIF W_DETAIL_TYPE = 'DM' THEN
      -- 공제 : 당월 급여마스터 존재 VS 급여 미반영 항목 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
         FROM HRM_PERSON_MASTER     PM
            , HRP_MONTH_PAYMENT     MP
            , ( SELECT MH.PERSON_ID
                     , ML.ALLOWANCE_ID
                     , ML.ALLOWANCE_AMOUNT
                  FROM HRP_PAY_MASTER_HEADER MH
                     , HRP_PAY_MASTER_LINE   ML
                WHERE MH.PAY_HEADER_ID      = ML.PAY_HEADER_ID
                  AND MH.START_YYYYMM       <= W_PERIOD_NAME
                  AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                  AND MH.SOB_ID             = W_SOB_ID
                  AND MH.ORG_ID             = W_ORG_ID
                  AND ML.ALLOWANCE_TYPE     = 'D'
                  AND ML.ENABLED_FLAG       = 'Y'                          
              ) SX1
            , HRM_DEDUCTION_V      HD
        WHERE PM.PERSON_ID                = MP.PERSON_ID
          AND MP.PERSON_ID                = SX1.PERSON_ID
          AND SX1.ALLOWANCE_ID            = HD.DEDUCTION_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND HD.DEDUCTION_CODE           = W_ITEM_CODE
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND MD.DEDUCTION_ID             = SX1.ALLOWANCE_ID                    
                )
        ;    
    ELSIF W_DETAIL_TYPE = 'DA' THEN
      -- 공제 : 당월 급여 공제 존재 VS 급여 미반영 항목 현황 --  
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
         FROM HRM_PERSON_MASTER         PM
            , HRP_MONTH_PAYMENT         MP
            , HRP_PAYMENT_ADD_DEDUCTION PAD
            , HRM_DEDUCTION_V           HD
        WHERE PM.PERSON_ID                = MP.PERSON_ID
          AND MP.PERSON_ID                = PAD.PERSON_ID
          AND MP.PAY_YYYYMM               = PAD.PAY_YYYYMM
          AND MP.WAGE_TYPE                = PAD.WAGE_TYPE
          AND MP.SOB_ID                   = PAD.SOB_ID
          AND MP.ORG_ID                   = PAD.ORG_ID
          AND PAD.DEDUCTION_ID            = HD.DEDUCTION_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND HD.DEDUCTION_CODE           = W_ITEM_CODE
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND MD.DEDUCTION_ID             = PAD.DEDUCTION_ID                    
                )
        ;
    ELSIF W_DETAIL_TYPE = 'DIT' THEN
      -- 공제 : 당월 소득세 미공제 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER     PM
             , HRP_MONTH_PAYMENT     MP
        WHERE PM.PERSON_ID                = MP.PERSON_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND MP.TOT_SUPPLY_AMOUNT        != 0
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND EXISTS
                          ( SELECT 'X'
                              FROM HRM_DEDUCTION_V HD
                             WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                               AND HD.DEDUCTION_CODE  = W_ITEM_CODE  -- 'D01'
                          )                         
                )      
        ;            
    ELSIF W_DETAIL_TYPE = 'DLT' THEN
      -- 공제 : 당월 주민세 미공제 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC 
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER     PM
             , HRP_MONTH_PAYMENT     MP
        WHERE PM.PERSON_ID                = MP.PERSON_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND MP.TOT_SUPPLY_AMOUNT        != 0
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND EXISTS
                          ( SELECT 'X'
                              FROM HRM_DEDUCTION_V HD
                             WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                               AND HD.DEDUCTION_CODE  = W_ITEM_CODE  -- 'D02'
                          )                         
                )      
        ;        
    ELSIF W_DETAIL_TYPE = 'DHI' THEN
      -- 공제 : 당월 고용보험 미공제 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
          FROM HRM_PERSON_MASTER     PM
             , HRP_PAY_MASTER_HEADER MH
             , HRP_MONTH_PAYMENT     MP
        WHERE PM.PERSON_ID                = MH.PERSON_ID
          AND PM.PERSON_ID                = MP.PERSON_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MH.START_YYYYMM             <= W_PERIOD_NAME
          AND (MH.END_YYYYMM              >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
          AND NVL(MH.HIRE_INSUR_YN, 'N')  = 'Y'
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND MP.TOT_SUPPLY_AMOUNT        != 0
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                    AND EXISTS
                          ( SELECT 'X'
                              FROM HRM_DEDUCTION_V HD
                             WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                               AND HD.DEDUCTION_CODE  = W_ITEM_CODE  -- 'D04'
                          )                         
                )
        ;       
    ELSIF W_DETAIL_TYPE = 'DPI' THEN
      -- 공제 : 당월 국민보험 미공제 등록 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
          FROM HRM_PERSON_MASTER PM
             , HRP_MONTH_PAYMENT MP
        WHERE PM.PERSON_ID                = MP.PERSON_ID                     
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID           = MP.MONTH_PAYMENT_ID
                    AND EXISTS
                          ( SELECT 'X'
                              FROM HRM_DEDUCTION_V HD
                             WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                               AND HD.DEDUCTION_CODE  = W_ITEM_CODE  -- 'D03'
                          )                         
                )   
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_INSURANCE_MASTER IC --HRP_INSURANCE_CHARGE IC
                  WHERE IC.PERSON_ID                  = PM.PERSON_ID
                    AND IC.INSUR_TYPE                 = 'P'
                    AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                )
        ;    
    ELSIF W_DETAIL_TYPE = 'DMI' THEN
      -- 공제 : 당월 건강보험/장기요양보험 미공제 등록 현황 -- 
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
          FROM HRM_PERSON_MASTER PM
             , HRP_MONTH_PAYMENT MP
        WHERE PM.PERSON_ID                = MP.PERSON_ID                     
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
          AND MP.WAGE_TYPE                = W_WAGE_TYPE
          AND MP.SOB_ID                   = W_SOB_ID
          AND MP.ORG_ID                   = W_ORG_ID
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_DEDUCTION MD
                  WHERE MD.MONTH_PAYMENT_ID           = MP.MONTH_PAYMENT_ID
                    AND ((W_ITEM_CODE                 = 'D05' 
                      AND EXISTS
                          ( SELECT 'X'
                              FROM HRM_DEDUCTION_V HD
                             WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                               AND HD.DEDUCTION_CODE  IN('D05', 'D07')
                          ))
                    OR   (W_ITEM_CODE                 = 'D06'
                      AND EXISTS
                            ( SELECT 'X'
                                FROM HRM_DEDUCTION_V HD
                               WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                 AND HD.DEDUCTION_CODE  IN('D06', 'D08')
                            )))                       
                )   
          AND EXISTS
                ( SELECT 'X'
                   FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                  WHERE IC.PERSON_ID                  = PM.PERSON_ID
                    AND IC.INSUR_TYPE                 = 'M'
                    AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                )
        ;
    ELSIF W_DETAIL_TYPE = 'DYA' THEN
      -- 공제 : 당월 퇴사자중 연말정산 정산내역 존재 VS 급여 미반영 항목 현황 --  
      OPEN P_CURSOR2 FOR  
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
         FROM HRM_PERSON_MASTER         PM
            , HRA_YEAR_ADJUSTMENT       YA
        WHERE PM.PERSON_ID                = YA.PERSON_ID
          AND PM.CORP_ID                  = W_CORP_ID
          AND PM.SOB_ID                   = W_SOB_ID
          AND PM.ORG_ID                   = W_ORG_ID
          AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
          AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR
          AND  PM.RETIRE_DATE             <= V_PERIOD_DATE_TO
          AND  PM.RETIRE_DATE             IS NOT NULL)  
          AND YA.YEAR_YYYY                = SUBSTR(W_PERIOD_NAME, 1, 4)
          AND (YA.ADJUST_DATE_TO          >= V_PERIOD_DATE_FR
          AND  YA.ADJUST_DATE_TO          <= V_PERIOD_DATE_TO)
          AND NVL(YA.SUBT_IN_TAX_AMT, 0) + NVL(YA.SUBT_LOCAL_TAX_AMT, 0) + NVL(YA.SUBT_SP_TAX_AMT, 0) != 0
          AND NOT EXISTS
                ( SELECT 'X'
                   FROM HRP_MONTH_PAYMENT   MP
                      , HRP_MONTH_DEDUCTION MD
                      , HRM_DEDUCTION_V     HD
                  WHERE MP.MONTH_PAYMENT_ID         = MD.MONTH_PAYMENT_ID
                    AND MD.DEDUCTION_ID             = HD.DEDUCTION_ID
                    AND MP.PERSON_ID                = PM.PERSON_ID
                    AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                    AND MP.WAGE_TYPE                = W_WAGE_TYPE
                    AND MP.SOB_ID                   = W_SOB_ID
                    AND MP.ORG_ID                   = W_ORG_ID
                    AND HD.DEDUCTION_CODE           IN('D15', 'D16', 'D17')                  
                )
        ;  
        
        
        
              
    ELSE       
      OPEN P_CURSOR2 FOR  
        SELECT NULL AS PERSON_NUM
             , NULL AS NAME
             , TO_DATE(NULL) AS JOIN_DATE
             , TO_DATE(NULL) AS RETIRE_DATE
             , NULL AS PERSON_ID
             , NULL AS POST_DESC
             , NULL AS FLOOR_DESC 
             , NULL AS JOB_CATEGORY_DESC  
          FROM DUAL
         WHERE ROWNUM = 0
        ;                
    END IF;
  END SELECT_SALARY_DETAIL;

-- 급여 마감 항목별 체크사항 -- 
  PROCEDURE SELECT_SALARY_ITEM
	          ( P_CURSOR1                  OUT TYPES.TCURSOR
						, W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER
						)
  AS
    V_PERIOD_DATE_FR    DATE := TRUNC(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), 'MONTH');
    V_PERIOD_DATE_TO    DATE := LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'));
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT  T1.ITEM_CODE AS ITEM_CODE
            , T1.ITEM_TYPE 
            , CASE 
                WHEN SUBSTR(T1.ITEM_TYPE, 1, 1) = 'A' THEN HRM_COMMON_G.CODE_NAME_F('ALLOWANCE', T1.ITEM_CODE, W_SOB_ID, W_ORG_ID) 
                WHEN SUBSTR(T1.ITEM_TYPE, 1, 1) = 'D' THEN HRM_COMMON_G.CODE_NAME_F('DEDUCTION', T1.ITEM_CODE, W_SOB_ID, W_ORG_ID) 
              END AS ITEM_DESC                    
            , T1.PERSON_COUNT
        FROM (-- 지급 : 당월 급여마스터 존재 VS 급여 미반영 항목 현황 --
              SELECT HA.ALLOWANCE_CODE AS ITEM_CODE
                   , 'AM' AS ITEM_TYPE
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER     PM
                  , HRP_MONTH_PAYMENT     MP
                  , ( SELECT MH.PERSON_ID
                           , ML.ALLOWANCE_ID
                           , ML.ALLOWANCE_AMOUNT
                        FROM HRP_PAY_MASTER_HEADER MH
                           , HRP_PAY_MASTER_LINE   ML
                      WHERE MH.PAY_HEADER_ID      = ML.PAY_HEADER_ID
                        AND MH.START_YYYYMM       <= W_PERIOD_NAME
                        AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                        AND MH.SOB_ID             = W_SOB_ID
                        AND MH.ORG_ID             = W_ORG_ID                        
                        AND ((W_WAGE_TYPE         = 'P1'
                          AND 1                   = 1)
                        OR   (W_WAGE_TYPE         != 'P1'
                          AND 1                   = 2))
                        AND ML.ALLOWANCE_TYPE     = 'A'
                        AND ML.ENABLED_FLAG       = 'Y'                          
                    ) SX1
                  , HRM_ALLOWANCE_V       HA
              WHERE PM.PERSON_ID                = MP.PERSON_ID
                AND MP.PERSON_ID                = SX1.PERSON_ID
                AND SX1.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_ALLOWANCE MA
                        WHERE MA.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND MA.ALLOWANCE_ID             = SX1.ALLOWANCE_ID                    
                      )
              GROUP BY HA.ALLOWANCE_CODE   
              UNION ALL
              -- 지급 : 당월 급여추가공제 존재 VS 급여 미반영 항목 현황 --
              SELECT HA.ALLOWANCE_CODE AS ITEM_CODE
                   , 'AA' AS ITEM_TYPE
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER         PM
                  , HRP_MONTH_PAYMENT         MP
                  , HRP_PAYMENT_ADD_ALLOWANCE PAA
                  , HRM_ALLOWANCE_V           HA
              WHERE PM.PERSON_ID                = MP.PERSON_ID
                AND MP.PERSON_ID                = PAA.PERSON_ID
                AND MP.PAY_YYYYMM               = PAA.PAY_YYYYMM
                AND MP.WAGE_TYPE                = PAA.WAGE_TYPE
                AND MP.SOB_ID                   = PAA.SOB_ID
                AND MP.ORG_ID                   = PAA.ORG_ID
                AND PAA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_ALLOWANCE MA
                        WHERE MA.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND MA.ALLOWANCE_ID             = PAA.ALLOWANCE_ID                    
                      )
              GROUP BY HA.ALLOWANCE_CODE   
              UNION ALL
              -- 공제 : 당월 급여마스터 존재 VS 급여 미반영 항목 현황 -- 
              SELECT HD.DEDUCTION_CODE AS ITEM_CODE
                   , 'DM' AS ITEM_TYPE
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER     PM
                  , HRP_MONTH_PAYMENT     MP
                  , ( SELECT MH.PERSON_ID
                           , ML.ALLOWANCE_ID
                           , ML.ALLOWANCE_AMOUNT
                        FROM HRP_PAY_MASTER_HEADER MH
                           , HRP_PAY_MASTER_LINE   ML
                      WHERE MH.PAY_HEADER_ID      = ML.PAY_HEADER_ID
                        AND MH.START_YYYYMM       <= W_PERIOD_NAME
                        AND (MH.END_YYYYMM        >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                        AND MH.SOB_ID             = W_SOB_ID
                        AND MH.ORG_ID             = W_ORG_ID
                        AND ML.ALLOWANCE_TYPE     = 'D'
                        AND ML.ENABLED_FLAG       = 'Y' 
                        AND ((W_WAGE_TYPE         = 'P1'
                          AND 1                   = 1)
                        OR   (W_WAGE_TYPE         != 'P1'
                          AND 1                   = 2))                         
                    ) SX1
                  , HRM_DEDUCTION_V      HD
              WHERE PM.PERSON_ID                = MP.PERSON_ID
                AND MP.PERSON_ID                = SX1.PERSON_ID
                AND SX1.ALLOWANCE_ID            = HD.DEDUCTION_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND MD.DEDUCTION_ID             = SX1.ALLOWANCE_ID                    
                      )
              GROUP BY HD.DEDUCTION_CODE 
              UNION ALL
              -- 공제 : 당월 급여추가공제 존재 VS 급여 미반영 항목 현황 --
              SELECT HD.DEDUCTION_CODE AS ITEM_CODE
                   , 'DA' AS ITEM_TYPE
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER         PM
                  , HRP_MONTH_PAYMENT         MP
                  , HRP_PAYMENT_ADD_DEDUCTION PAD
                  , HRM_DEDUCTION_V           HD
              WHERE PM.PERSON_ID                = MP.PERSON_ID
                AND MP.PERSON_ID                = PAD.PERSON_ID
                AND MP.PAY_YYYYMM               = PAD.PAY_YYYYMM
                AND MP.WAGE_TYPE                = PAD.WAGE_TYPE
                AND MP.SOB_ID                   = PAD.SOB_ID
                AND MP.ORG_ID                   = PAD.ORG_ID
                AND PAD.DEDUCTION_ID            = HD.DEDUCTION_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND MD.DEDUCTION_ID             = PAD.DEDUCTION_ID                    
                      )
              GROUP BY HD.DEDUCTION_CODE 
              UNION ALL
              -- 당월 소득세 미공제 현황 --
              SELECT 'D01' AS ITEM_CODE 
                   , 'DIT' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER     PM
                  , HRP_MONTH_PAYMENT     MP
              WHERE PM.PERSON_ID                = MP.PERSON_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND MP.TOT_SUPPLY_AMOUNT        != 0
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_DEDUCTION_V HD
                                   WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                     AND HD.DEDUCTION_CODE  = 'D01'
                                )                         
                      )   
              UNION ALL
              -- 당월 주민세 미공제 현황 --
              SELECT 'D02' AS ITEM_CODE
                   , 'DLT' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER     PM
                  , HRP_MONTH_PAYMENT     MP
              WHERE PM.PERSON_ID                = MP.PERSON_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND MP.TOT_SUPPLY_AMOUNT        != 0
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_DEDUCTION_V HD
                                   WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                     AND HD.DEDUCTION_CODE  = 'D02'
                                )                         
                      )            
              UNION ALL         
              -- 당월 고용보험 미공제 현황 --
              SELECT 'D04' AS ITEM_CODE
                   , 'DHI' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
                FROM HRM_PERSON_MASTER     PM
                   , HRP_PAY_MASTER_HEADER MH
                   , HRP_MONTH_PAYMENT     MP
              WHERE PM.PERSON_ID                = MH.PERSON_ID
                AND PM.PERSON_ID                = MP.PERSON_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MH.START_YYYYMM             <= W_PERIOD_NAME
                AND (MH.END_YYYYMM              >= W_PERIOD_NAME OR MH.END_YYYYMM IS NULL)
                AND NVL(MH.HIRE_INSUR_YN, 'N')  = 'Y'
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND MP.TOT_SUPPLY_AMOUNT        != 0
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID         = MP.MONTH_PAYMENT_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_DEDUCTION_V HD
                                   WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                     AND HD.DEDUCTION_CODE  = 'D04'
                                )                         
                      )   
              UNION ALL
              -- 당월 국민보험 미공제 등록 현황 --
              SELECT 'D03' AS ITEM_CODE
                   , 'DPI' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
                FROM HRM_PERSON_MASTER PM
                   , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID                = MP.PERSON_ID                     
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND ((W_WAGE_TYPE               = 'P1'
                  AND 1                         = 1)
                OR   (W_WAGE_TYPE               != 'P1'
                  AND 1                         = 2))
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID           = MP.MONTH_PAYMENT_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_DEDUCTION_V HD
                                   WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                     AND HD.DEDUCTION_CODE  = 'D03'
                                )                         
                      )   
                AND EXISTS
                      ( SELECT 'X'
                         FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                        WHERE IC.PERSON_ID                  = PM.PERSON_ID
                          AND IC.INSUR_TYPE                 = 'P'
                          AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                      )
              UNION ALL         
              -- 당월 건강보험 미공제 등록 현황 --
              SELECT 'D05' AS ITEM_CODE
                   , 'DMI' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
                FROM HRM_PERSON_MASTER PM
                   , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID                = MP.PERSON_ID                     
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND ((W_WAGE_TYPE               = 'P1'
                  AND 1                         = 1)
                OR   (W_WAGE_TYPE               != 'P1'
                  AND 1                         = 2))
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID           = MP.MONTH_PAYMENT_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_DEDUCTION_V HD
                                   WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                     AND HD.DEDUCTION_CODE  IN('D05', 'D07')
                                )                         
                      )   
                AND EXISTS
                      ( SELECT 'X'
                         FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                        WHERE IC.PERSON_ID                  = PM.PERSON_ID
                          AND IC.INSUR_TYPE                 = 'M'
                          AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                      )
               -- 건강보험료에 포함되어 처리되므로 따로 분리 안함 --
              UNION ALL         
              -- 당월 요양보험 미공제 등록 현황 --
              SELECT 'D06' AS ITEM_CODE
                   , 'DMI' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
                FROM HRM_PERSON_MASTER PM
                   , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID                = MP.PERSON_ID                     
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR OR PM.RETIRE_DATE IS NULL)
                AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                AND MP.WAGE_TYPE                = W_WAGE_TYPE
                AND MP.SOB_ID                   = W_SOB_ID
                AND MP.ORG_ID                   = W_ORG_ID
                AND ((W_WAGE_TYPE               = 'P1'
                  AND 1                         = 1)
                OR   (W_WAGE_TYPE               != 'P1'
                  AND 1                         = 2))
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_DEDUCTION MD
                        WHERE MD.MONTH_PAYMENT_ID           = MP.MONTH_PAYMENT_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_DEDUCTION_V HD
                                   WHERE HD.DEDUCTION_ID    = MD.DEDUCTION_ID
                                     AND HD.DEDUCTION_CODE  IN('D06', 'D08')
                                )                         
                      )   
                AND EXISTS
                      ( SELECT 'X'
                         FROM HRP_INSURANCE_MASTER IC -- HRP_INSURANCE_CHARGE IC
                        WHERE IC.PERSON_ID                  = PM.PERSON_ID
                          AND IC.INSUR_TYPE                 = 'M'
                          AND NVL(IC.INSUR_YN, 'N')         = 'Y'
                      )
              UNION ALL
              -- 공제 : 당월 퇴사자중 연말정산 정산내역 존재 VS 급여 미반영 항목 현황 --
              SELECT 'D15' AS ITEM_CODE
                   , 'DYA' AS ITEM_TYPE 
                   , COUNT(PM.PERSON_ID) AS PERSON_COUNT
               FROM HRM_PERSON_MASTER         PM
                  , HRA_YEAR_ADJUSTMENT       YA
              WHERE PM.PERSON_ID                = YA.PERSON_ID
                AND PM.CORP_ID                  = W_CORP_ID
                AND PM.SOB_ID                   = W_SOB_ID
                AND PM.ORG_ID                   = W_ORG_ID
                AND PM.JOIN_DATE                <= V_PERIOD_DATE_TO
                AND (PM.RETIRE_DATE             >= V_PERIOD_DATE_FR
                AND  PM.RETIRE_DATE             <= V_PERIOD_DATE_TO
                AND  PM.RETIRE_DATE             IS NOT NULL)  
                AND YA.YEAR_YYYY                = SUBSTR(W_PERIOD_NAME, 1, 4)
                AND (YA.ADJUST_DATE_TO          >= V_PERIOD_DATE_FR
                AND  YA.ADJUST_DATE_TO          <= V_PERIOD_DATE_TO)
                AND NVL(YA.SUBT_IN_TAX_AMT, 0) + NVL(YA.SUBT_LOCAL_TAX_AMT, 0) + NVL(YA.SUBT_SP_TAX_AMT, 0) != 0
                AND ((W_WAGE_TYPE               = 'P1'
                  AND 1                         = 1)
                OR   (W_WAGE_TYPE               != 'P1'
                  AND 1                         = 2))
                AND NOT EXISTS
                      ( SELECT 'X'
                         FROM HRP_MONTH_PAYMENT   MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V     HD
                        WHERE MP.MONTH_PAYMENT_ID         = MD.MONTH_PAYMENT_ID
                          AND MD.DEDUCTION_ID             = HD.DEDUCTION_ID
                          AND MP.PERSON_ID                = PM.PERSON_ID
                          AND MP.PAY_YYYYMM               = W_PERIOD_NAME
                          AND MP.WAGE_TYPE                = W_WAGE_TYPE
                          AND MP.SOB_ID                   = W_SOB_ID
                          AND MP.ORG_ID                   = W_ORG_ID
                          AND HD.DEDUCTION_CODE           IN('D15', 'D16', 'D17')                  
                      )
             ) T1
      ;
 
  END SELECT_SALARY_ITEM;

-- 급여 마감 : 전월 VS 당월 금액 비교 -- 
  PROCEDURE SELECT_SALARY_ITEM_AMOUNT
            ( P_CURSOR2                  OUT TYPES.TCURSOR2
            , W_CORP_ID                  IN  NUMBER
            , W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
            , W_SOB_ID                   IN  NUMBER
            , W_ORG_ID                   IN  NUMBER
            , W_AMOUNT_FR                IN  NUMBER
            , W_AMOUNT_TO                IN  NUMBER 
            )
  AS
    V_PRE_PERIOD_NAME   VARCHAR2(7) := TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM');
  BEGIN
    OPEN P_CURSOR2 FOR
      -- 지급  -- 
      SELECT HA.ALLOWANCE_CODE AS ITEM_CODE     
           , HA.ALLOWANCE_NAME AS ITEM_DESC
           , COUNT(SX1.PERSON_ID) AS PERSON_COUNT
           , HA.ALLOWANCE_ID   AS ITEM_ID
           , 'A' AS ITEM_TYPE
        FROM HRM_ALLOWANCE_V     HA
           , (SELECT MP.PERSON_ID
                   , MA.ALLOWANCE_ID
                   , SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MA.ALLOWANCE_AMOUNT, 0)) AS AMOUNT
                FROM HRM_PERSON_MASTER   PM
                   , HRP_MONTH_PAYMENT   MP
                   , HRP_MONTH_ALLOWANCE MA
               WHERE PM.PERSON_ID             = MP.PERSON_ID
                 AND MP.MONTH_PAYMENT_ID      = MA.MONTH_PAYMENT_ID           
                 AND MP.PAY_YYYYMM            IN(W_PERIOD_NAME, V_PRE_PERIOD_NAME)
                 AND MP.WAGE_TYPE             = W_WAGE_TYPE
                 AND MP.SOB_ID                = W_SOB_ID
                 AND MP.ORG_ID                = W_ORG_ID
                 AND PM.CORP_ID               = W_CORP_ID
                 AND PM.SOB_ID                = W_SOB_ID
                 AND PM.ORG_ID                = W_ORG_ID
                 AND PM.JOIN_DATE             < LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'))
                 AND (PM.RETIRE_DATE          >= TRUNC(TO_DATE(V_PRE_PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
              GROUP BY MP.PERSON_ID
                     , MA.ALLOWANCE_ID   
              HAVING (SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MA.ALLOWANCE_AMOUNT, 0))) BETWEEN NVL(W_AMOUNT_FR, 0)    
                                                                                                              AND NVL(W_AMOUNT_TO, 0)    
             ) SX1
       WHERE HA.ALLOWANCE_ID          = SX1.ALLOWANCE_ID
      GROUP BY HA.ALLOWANCE_CODE
             , HA.ALLOWANCE_ID
             , HA.ALLOWANCE_NAME 
             , HA.SORT_NUM   
      UNION ALL
      -- 공제  -- 
      SELECT HD.DEDUCTION_CODE AS ITEM_CODE
           , HD.DEDUCTION_NAME AS ITEM_DESC
           , COUNT(SX1.PERSON_ID) AS PERSON_COUNT
           , HD.DEDUCTION_ID   AS ITEM_ID
           , 'D' AS ITEM_TYPE
        FROM HRM_DEDUCTION_V HD
           , (SELECT MP.PERSON_ID
                   , MD.DEDUCTION_ID
                   , SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MD.DEDUCTION_AMOUNT, 0)) AS AMOUNT
                FROM HRM_PERSON_MASTER   PM
                   , HRP_MONTH_PAYMENT   MP
                   , HRP_MONTH_DEDUCTION MD
               WHERE PM.PERSON_ID             = MP.PERSON_ID
                 AND MP.MONTH_PAYMENT_ID      = MD.MONTH_PAYMENT_ID
                 AND MP.PAY_YYYYMM            IN(W_PERIOD_NAME, V_PRE_PERIOD_NAME)
                 AND MP.WAGE_TYPE             = W_WAGE_TYPE
                 AND MP.SOB_ID                = W_SOB_ID
                 AND MP.ORG_ID                = W_ORG_ID
                 AND PM.CORP_ID               = W_CORP_ID
                 AND PM.SOB_ID                = W_SOB_ID
                 AND PM.ORG_ID                = W_ORG_ID
                 AND PM.JOIN_DATE             < LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'))
                 AND (PM.RETIRE_DATE          >= TRUNC(TO_DATE(V_PRE_PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
                 AND NOT EXISTS
                       ( SELECT 'X'
                           FROM HRM_DEDUCTION_V HDV
                          WHERE HDV.DEDUCTION_ID    = MD.DEDUCTION_ID
                            AND HDV.DEDUCTION_CODE  IN('D07', 'D08', 'D15', 'D16', 'D17')
                       )
              GROUP BY MP.PERSON_ID
                     , MD.DEDUCTION_ID
              HAVING (SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MD.DEDUCTION_AMOUNT, 0))) BETWEEN NVL(W_AMOUNT_FR, 0)    
                                                                                                              AND NVL(W_AMOUNT_TO, 0)        
             ) SX1
       WHERE HD.DEDUCTION_ID          = SX1.DEDUCTION_ID
      GROUP BY HD.DEDUCTION_CODE
             , HD.DEDUCTION_ID
             , HD.DEDUCTION_NAME
             , HD.SORT_NUM 
      ORDER BY ITEM_CODE
      ;
  END SELECT_SALARY_ITEM_AMOUNT;

-- 급여 마감 : 전월 VS 당월 금액 비교 => 대상자 조회 -- 
  PROCEDURE SELECT_SALARY_ITEM_DETAIL
            ( P_CURSOR2                  OUT TYPES.TCURSOR2            
            , W_CORP_ID                  IN  NUMBER
						, W_PERIOD_NAME              IN  VARCHAR2
            , W_WAGE_TYPE                IN  VARCHAR2
						, W_SOB_ID                   IN  NUMBER
						, W_ORG_ID                   IN  NUMBER            
            , W_DETAIL_TYPE              IN  VARCHAR2
            , W_ITEM_ID                  IN  NUMBER
            , W_AMOUNT_FR                IN  NUMBER
            , W_AMOUNT_TO                IN  NUMBER 
            )
  AS
    V_PRE_PERIOD_NAME   VARCHAR2(7) := TO_CHAR(ADD_MONTHS(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'), -1), 'YYYY-MM');
  BEGIN
    IF W_DETAIL_TYPE = 'A' THEN
      OPEN P_CURSOR2 FOR
        -- 지급  -- 
        SELECT PM.PERSON_NUM
             , PM.NAME
             , NVL(SX1.AMOUNT, 0) AS GAP_AMOUNT 
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID      
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC  
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
             , (SELECT MP.PERSON_ID
                     , MA.ALLOWANCE_ID
                     , SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MA.ALLOWANCE_AMOUNT, 0)) AS AMOUNT
                  FROM HRP_MONTH_PAYMENT   MP
                     , HRP_MONTH_ALLOWANCE MA
                     , HRM_ALLOWANCE_V     HA
                 WHERE MP.MONTH_PAYMENT_ID      = MA.MONTH_PAYMENT_ID
                   AND MA.ALLOWANCE_ID          = HA.ALLOWANCE_ID
                   AND MP.PAY_YYYYMM            IN(W_PERIOD_NAME, V_PRE_PERIOD_NAME)
                   AND MP.WAGE_TYPE             = W_WAGE_TYPE
                   AND MP.SOB_ID                = W_SOB_ID
                   AND MP.ORG_ID                = W_ORG_ID
                   AND HA.ALLOWANCE_ID          = W_ITEM_ID
                GROUP BY MP.PERSON_ID
                     , MA.ALLOWANCE_ID   
                HAVING (SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MA.ALLOWANCE_AMOUNT, 0))) BETWEEN NVL(W_AMOUNT_FR, 0)    
                                                                                                                AND NVL(W_AMOUNT_TO, 0)          
               ) SX1
         WHERE PM.PERSON_ID             = SX1.PERSON_ID
           AND PM.CORP_ID               = W_CORP_ID
           AND PM.SOB_ID                = W_SOB_ID
           AND PM.ORG_ID                = W_ORG_ID
           AND PM.JOIN_DATE             < LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'))
           AND (PM.RETIRE_DATE          >= TRUNC(TO_DATE(V_PRE_PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
        ; 
    ELSIF W_DETAIL_TYPE = 'D' THEN           
      OPEN P_CURSOR2 FOR
        -- 공제  -- 
        SELECT PM.PERSON_NUM
             , PM.NAME
             , PM.JOIN_DATE
             , PM.RETIRE_DATE
             , PM.PERSON_ID      
             , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_DESC
             , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR_DESC  
             , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC 
          FROM HRM_PERSON_MASTER PM
             , (SELECT MP.PERSON_ID
                     , MD.DEDUCTION_ID
                     , SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MD.DEDUCTION_AMOUNT, 0)) AS AMOUNT
                  FROM HRP_MONTH_PAYMENT   MP
                     , HRP_MONTH_DEDUCTION MD
                     , HRM_DEDUCTION_V     HD
                 WHERE MP.MONTH_PAYMENT_ID      = MD.MONTH_PAYMENT_ID
                   AND MD.DEDUCTION_ID          = HD.DEDUCTION_ID
                   AND MP.PAY_YYYYMM            IN(W_PERIOD_NAME, V_PRE_PERIOD_NAME)
                   AND MP.WAGE_TYPE             = W_WAGE_TYPE
                   AND MP.SOB_ID                = W_SOB_ID
                   AND MP.ORG_ID                = W_ORG_ID
                   AND HD.DEDUCTION_ID          = W_ITEM_ID
                GROUP BY MP.PERSON_ID
                       , MD.DEDUCTION_ID
                HAVING (SUM(DECODE(MP.PAY_YYYYMM, V_PRE_PERIOD_NAME, -1, 1) * NVL(MD.DEDUCTION_AMOUNT, 0))) BETWEEN NVL(W_AMOUNT_FR, 0)    
                                                                                                                AND NVL(W_AMOUNT_TO, 0)     
               ) SX1
         WHERE PM.PERSON_ID             = SX1.PERSON_ID
           AND PM.CORP_ID               = W_CORP_ID
           AND PM.SOB_ID                = W_SOB_ID
           AND PM.ORG_ID                = W_ORG_ID
           AND PM.JOIN_DATE             < LAST_DAY(TO_DATE(W_PERIOD_NAME, 'YYYY-MM'))
           AND (PM.RETIRE_DATE          >= TRUNC(TO_DATE(V_PRE_PERIOD_NAME, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
        ; 
    ELSE
      OPEN P_CURSOR2 FOR
        SELECT NULL AS PERSON_NUM
             , NULL AS NAME
             , TO_DATE(NULL) AS JOIN_DATE
             , TO_DATE(NULL) AS RETIRE_DATE
             , TO_NUMBER(NULL) AS PERSON_ID      
             , NULL AS POST_DESC
             , NULL AS FLOOR_DESC  
             , NULL AS JOB_CATEGORY_DESC 
          FROM DUAL 
         WHERE ROWNUM           = 0
        ;
    END IF;
  END SELECT_SALARY_ITEM_DETAIL;
  
END HRP_SALARY_CLOSED_CHECK_G;
/
