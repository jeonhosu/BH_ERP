CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_PRINT_G
AS

  PROCEDURE MONTH_PAYMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN NUMBER
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PAY_TYPE          IN VARCHAR2
            , W_DEPT_ID           IN NUMBER
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_DUTY
            ( P_CURSOR3           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN NUMBER
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );
            
---------------------------------------------------------------------------------------------------
-- 급상여 지급내역 조회
  PROCEDURE SELECT_MONTH_ALLOWANCE
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 급상여 공제내역 조회 / 삽입 / 수정.
  PROCEDURE SELECT_MONTH_DEDUCTION
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 급여 지급시 지급되는 상여 지급내역 조회
  PROCEDURE SELECT_MONTH_ALLOWANCE_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 급여 지급시 지급되는 상여 공제내역 조회
  PROCEDURE SELECT_MONTH_DEDUCTION_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );
                        
END HRP_MONTH_PAYMENT_PRINT_G
;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_PRINT_G
AS

  PROCEDURE MONTH_PAYMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN NUMBER
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PAY_TYPE          IN VARCHAR2
            , W_DEPT_ID           IN NUMBER
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck 적용할 경우 사용 : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR1 FOR
      -- 기본정보.
      SELECT  'N' AS SELECT_CHECK_YN
            , MP.CORP_ID
            , MP.PERSON_ID
            , MIN(MP.WAGE_TYPE) AS WAGE_TYPE            
            , MP.SOB_ID
            , MP.ORG_ID
            , MIN(MP.PAY_YYYYMM) AS PAY_YYYYMM
            , PM.NAME
            , PM.PERSON_NUM
            , DM.DEPT_NAME AS DEPT_NAME  -- 부서;
            , PC.POST_NAME  -- 직위.
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_NAME  -- 직군;
            , MAX(MP.SUPPLY_DATE) AS SUPPLY_DATE
            , S_PMH.BANK_NAME
            , MAX(RPAD(SUBSTR(S_PMH.BANK_ACCOUNTS, 1, LENGTH(S_PMH.BANK_ACCOUNTS) - 6), LENGTH(S_PMH.BANK_ACCOUNTS), '*')) AS BANK_ACCOUNTS       
            , SUM(MP.REAL_AMOUNT) AS REAL_AMOUNT
            , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOT_SUPPLY_AMOUNT
            , SUM(MP.TOT_DED_AMOUNT) AS TOT_DED_AMOUNT
            , SUM(DECODE(MP.WAGE_TYPE, 'P1', MP.REAL_AMOUNT, 0)) AS REAL_PAY_AMOUNT
            , SUM(DECODE(MP.WAGE_TYPE, 'P1', MP.TOT_SUPPLY_AMOUNT, 0)) AS TOT_PAY_SUP_AMOUNT
            , SUM(DECODE(MP.WAGE_TYPE, 'P1', MP.TOT_DED_AMOUNT, 0)) AS TOT_PAY_DED_AMOUNT
            , SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.REAL_AMOUNT, 0)) AS REAL_BONUS_AMOUNT
            , SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) AS TOT_BONUS_SUP_AMOUNT
            , SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) AS TOT_BONUS_DED_AMOUNT
            , MAX(CASE
                    WHEN S_PMH.PAY_TYPE IN('1', '3') THEN S_PMH.BASIC_AMOUNT
                    ELSE 0
                  END) AS BASIC_AMOUNT  -- 기본급.
            , MAX(CASE
                    WHEN W_WAGE_TYPE = 'P4' THEN CASE
                                                   WHEN MP.PAY_TYPE IN('1', '3') THEN 
                                                     TRUNC(HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(TO_CHAR(ADD_MONTHS(TO_DATE(MP.PAY_YYYYMM, 'YYYY-MM'), -1), 'YYYY-MM'), MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID) / 209)
                                                   ELSE HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(TO_CHAR(ADD_MONTHS(TO_DATE(MP.PAY_YYYYMM, 'YYYY-MM'), -1), 'YYYY-MM'), MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                                                 END
                    WHEN S_PMH.PAY_TYPE = '2' THEN TRUNC(S_PMH.BASIC_AMOUNT / 8)
                    WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT
                    ELSE 0
                  END) AS HOURLY_AMOUNT -- 시급.
            , MAX(MP.GENERAL_HOURLY_AMOUNT) AS GENERAL_HOURLY_AMOUNT  -- 통상시급.
            , MP.DESCRIPTION
            , MP.PAY_TYPE
            , CASE
                WHEN SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) <> 0 OR SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) <> 0 THEN
                     SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '년 [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '월 급여 / '  || SUBSTR(MAX(MP.PAY_YYYYMM), 6, 2) || '월 상여] 지급명세서' 
                ELSE SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '년 [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '월 급여] 지급명세서'
              END AS WAGE_TYPE_NAME
            , MAX((SELECT HC.DESCRIPTION
                     FROM HRM_CLOSING        HC
                        , HRM_CLOSING_TYPE_V CT
                    WHERE HC.CLOSING_TYPE_ID  = CT.CLOSING_TYPE_ID
                      AND HC.CLOSING_YYYYMM   = MP.PAY_YYYYMM
                      AND CT.CLOSING_TYPE     = W_WAGE_TYPE
                      AND HC.SOB_ID           = MP.SOB_ID
                      AND HC.ORG_ID           = MP.ORG_ID
                      AND ROWNUM              <= 1
                   )) AS NOTIFICATION  -- 알림 --
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , ( SELECT PMH.PERSON_ID
                   , PMH.BANK_ID
                   , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                   , PMH.BANK_ACCOUNTS
                   , PMH.PAY_TYPE
                   , (SELECT PML.ALLOWANCE_AMOUNT
                        FROM HRP_PAY_MASTER_LINE PML
                      WHERE PML.PAY_HEADER_ID     = PMH.PAY_HEADER_ID
                        AND EXISTS (SELECT 'X'
                                      FROM HRM_ALLOWANCE_V HA
                                    WHERE HA.ALLOWANCE_ID     = PML.ALLOWANCE_ID
                                      AND HA.ALLOWANCE_CODE   = 'A01'
                                      AND HA.SOB_ID           = W_SOB_ID
                                      AND HA.ORG_ID           = W_ORG_ID
                                    )
                     ) AS BASIC_AMOUNT
                   , PMH.SOB_ID
                   , PMH.ORG_ID
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.START_YYYYMM        <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM          >= W_PAY_YYYYMM
                AND PMH.SOB_ID              = W_SOB_ID
                AND PMH.ORG_ID              = W_ORG_ID
            ) S_PMH
      WHERE MP.PERSON_ID            = PM.PERSON_ID
        AND MP.DEPT_ID              = DM.DEPT_ID
        AND MP.POST_ID              = PC.POST_ID
        AND MP.PERSON_ID            = S_PMH.PERSON_ID
        AND MP.CORP_ID              = W_CORP_ID
        AND ((MP.PAY_YYYYMM         = W_PAY_YYYYMM
          AND MP.WAGE_TYPE          = W_WAGE_TYPE)
        OR (MP.PAY_YYYYMM           = V_BONUS_YYYYMM
          AND MP.WAGE_TYPE          = V_BONUS_TYPE))
        AND ((W_PAY_TYPE            IS NULL
          AND 1                     = 1)
        OR   (W_PAY_TYPE            IS NOT NULL
          AND MP.PAY_TYPE           = W_PAY_TYPE))
        AND ((W_PERSON_ID           IS NULL
          AND 1                     = 1)
        OR   (W_PERSON_ID           IS NOT NULL
          AND PM.PERSON_ID          = W_PERSON_ID))
        AND ((W_DEPT_ID             IS NULL
          AND 1                     = 1)
        OR   (W_DEPT_ID             IS NOT NULL
          AND MP.DEPT_ID            = W_DEPT_ID))
        AND MP.SOB_ID               = W_SOB_ID
        AND MP.ORG_ID               = W_ORG_ID
        AND (MP.TOT_SUPPLY_AMOUNT   <> 0
          OR MP.TOT_DED_AMOUNT      <> 0)
      GROUP BY MP.CORP_ID
            , MP.PERSON_ID
            , MP.SOB_ID
            , MP.ORG_ID
            , PM.NAME
            , PM.PERSON_NUM
            , DM.DEPT_SORT_NUM
            , DM.DEPT_CODE
            , DM.DEPT_NAME
            , PC.POST_CODE
            , PC.POST_NAME
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)
            , S_PMH.BANK_NAME
            , MP.DESCRIPTION
            , PC.SORT_NUM
            , MP.PAY_TYPE
      ORDER BY DM.DEPT_CODE, PC.SORT_NUM, PM.PERSON_NUM
      ;
  END MONTH_PAYMENT;

  PROCEDURE MONTH_DUTY
            ( P_CURSOR3           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN NUMBER
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_DUTY_TYPE                   VARCHAR2(10);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    V_TOTAL_DAY                   NUMBER;
  BEGIN
    V_DUTY_TYPE := 'D2';
    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => W_PAY_YYYYMM
                      , W_WAGE_TYPE => W_WAGE_TYPE
                      , W_PAY_TYPE => '1'
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
    
    BEGIN
      -- 총일수.
      V_TOTAL_DAY := V_END_DATE - V_START_DATE + 1;
    EXCEPTION WHEN OTHERS THEN
      V_TOTAL_DAY := 30;
    END;
    
    OPEN P_CURSOR3 FOR
      SELECT MT.PERSON_ID
           , MT.CORP_ID
           , MT.DUTY_YYYYMM
           , MT.TOTAL_ATT_DAY AS TOTAL_ATT_DAY  -- 기본근무일수;
           , MT.TOTAL_ATT_DAY * 8 AS TOTAL_ATT_TIME  -- 기본근무시간;
           , MTD.DUTY_30 AS DUTY_30
           , HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(MT.PERSON_ID, V_START_DATE, V_END_DATE, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT  -- 주휴일수.
           , HRD_WORK_CALENDAR_G.HOLY_0_COUNT_F(MT.PERSON_ID, V_START_DATE, V_END_DATE, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_0_COUNT  -- 무휴일수.
           , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(V_START_DATE, V_END_DATE, MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS H_HOLY_1_COUNT  -- 공휴일수.
           , MT.HOLY_0_COUNT    -- 무급휴일수;
           , MT.HOLY_1_COUNT    -- 유급휴일수;
           --, MT.LATE_DED_COUNT  -- 지각조퇴횟수;
           , S_HD.LATE_COUNT AS LATE_DED_COUNT  -- 지각조퇴횟수;
           , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT
           , MT.WEEKLY_DED_COUNT
           , MTD.DUTY_11 -- 결근일수.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.LATE_TIME, 0) + NVL(MTO.LEAVE_TIME, 0)
             END AS LATE_TIME  -- 지각/조퇴;
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.OVER_TIME, 0)
               ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0)
             END AS OVER_TIME   -- 연장.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.NIGHT_TIME, 0) 
               ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)  + NVL(MTO.HOLY_1_NIGHT, 0) + NVL(MTO.HOLY_0_NIGHT, 0)
             END AS NIGHT_BONUS_TIME   -- 야간근로.
           , NVL(MTO.HOLIDAY_TIME, 0)  AS HOLIDAY_TIME            -- 유휴 근무.
           , NVL(MTO.HOLY_1_OT, 0) + NVL(MTO.HOLY_0_OT, 0) AS HOLIDAY_OVER_TIME   -- 휴일연장.  
           , NVL(S_HM.CREATION_NUM, 0) AS CREATION_NUM  -- 년차발생수.
           , NVL(S_HM.REMAIN_NUM, 0) AS REMAIN_NUM      -- 년차 잔여수.
           , NVL(MTD.DUTY_20, 0) + NVL(MTD.DUTY_21, 0) AS THIS_DUTY_20_NUM  -- 년차 당월사용수 
           , NVL(S_HM.USE_NUM, 0) AS USE_NUM            -- 년차 사용수.
           , CASE
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN TRUNC(NVL(S_PMH.BASE_AMOUNT, 0) / V_TOTAL_DAY)
               WHEN S_PMH.PAY_TYPE IN('4') THEN NVL(S_PMH.BASE_AMOUNT, 0) * 8
               ELSE NVL(S_PMH.BASE_AMOUNT, 0)
             END AS BASE_AMOUNT
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
          , ( SELECT PMH.PERSON_ID
                   , PMH.PAY_TYPE
                   , ( SELECT ML.ALLOWANCE_AMOUNT
                         FROM HRP_PAY_MASTER_LINE ML
                        WHERE ML.PAY_HEADER_ID    = PMH.PAY_HEADER_ID
                          AND EXISTS
                                ( SELECT 'X'
                                    FROM HRM_ALLOWANCE_V     HA
                                   WHERE HA.ALLOWANCE_ID    = ML.ALLOWANCE_ID
                                     AND HA.ALLOWANCE_CODE  = 'A01'  -- 기본급
                                )
                     ) AS BASE_AMOUNT
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.PERSON_ID     = W_PERSON_ID
                AND PMH.CORP_ID       = W_CORP_ID
                AND PMH.START_YYYYMM  <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM    >= W_PAY_YYYYMM
                AND PMH.SOB_ID        = W_SOB_ID
                AND PMH.ORG_ID        = W_ORG_ID
             ) S_PMH
           , (SELECT HM.PERSON_ID
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS CREATION_NUM
                 , NVL(HM.USE_NUM, 0) AS USE_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM
              FROM HRD_HOLIDAY_MANAGEMENT HM
             WHERE HM.PERSON_ID             = W_PERSON_ID
               AND HM.HOLIDAY_TYPE          = '1'
               AND HM.DUTY_YEAR             = SUBSTR(W_PAY_YYYYMM, 1, 4)
               AND HM.SOB_ID                = W_SOB_ID
               AND HM.ORG_ID                = W_ORG_ID
             ) S_HM
           , (SELECT DL.PERSON_ID
                   , SUM(DECODE(NVL(DL.LEAVE_TIME, 0), 0, 0, 1) + 
                         DECODE(NVL(DL.LATE_TIME, 0), 0, 0, 1)) AS LATE_COUNT
                FROM HRD_DAY_LEAVE_V1 DL
              WHERE DL.WORK_DATE            BETWEEN V_START_DATE AND V_END_DATE
                AND DL.PERSON_ID            = W_PERSON_ID
                AND DL.SOB_ID               = W_SOB_ID
                AND DL.ORG_ID               = W_ORG_ID
                AND NVL(DL.LEAVE_TIME, 0) + NVL(DL.LATE_TIME, 0) != 0
                AND DL.CLOSED_YN            = 'Y'
              GROUP BY DL.PERSON_ID
              ) S_HD
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID(+)
        AND MT.PERSON_ID               = S_HM.PERSON_ID(+)
        AND MT.PERSON_ID               = S_HD.PERSON_ID(+)
        AND MT.DUTY_TYPE               = V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
        AND MT.PERSON_ID               = W_PERSON_ID
        AND MT.CORP_ID                 = W_CORP_ID
        AND MT.SOB_ID                  = W_SOB_ID
        AND MT.ORG_ID                  = W_ORG_ID
      ;
  END MONTH_DUTY;
  
---------------------------------------------------------------------------------------------------
-- 급상여 지급내역 조회
  PROCEDURE SELECT_MONTH_ALLOWANCE
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT MA.PERSON_ID
           , MA.PAY_YYYYMM
           , MA.WAGE_TYPE
           , MA.CORP_ID
           , MA.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME AS ALLOWANCE_NAME
           , MA.ALLOWANCE_AMOUNT
           , MA.MONTH_PAYMENT_ID
           , MA.CREATED_FLAG
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
       WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
         AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
         AND MA.SOB_ID                  = HA.SOB_ID
         AND MA.ORG_ID                  = HA.ORG_ID
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = W_WAGE_TYPE
         AND MP.PERSON_ID               = W_PERSON_ID   
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
         AND MP.TOT_SUPPLY_AMOUNT       <> 0
      ORDER BY HA.SORT_NUM, HA.ALLOWANCE_CODE
     ;
  END SELECT_MONTH_ALLOWANCE;
  
---------------------------------------------------------------------------------------------------
-- 급상여 공제내역 조회 / 삽입 / 수정.
  PROCEDURE SELECT_MONTH_DEDUCTION
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT MD.PERSON_ID
           , MD.PAY_YYYYMM
           , MD.WAGE_TYPE
           , MD.CORP_ID
           , MD.DEDUCTION_ID
           , HD.DEDUCTION_NAME AS DEDUCTION_NAME
           , MD.DEDUCTION_AMOUNT AS DEDUCTION_AMOUNT
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_DEDUCTION MD
          , HRM_DEDUCTION_V HD
       WHERE MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID
         AND MD.DEDUCTION_ID            = HD.DEDUCTION_ID
         AND MD.SOB_ID                  = HD.SOB_ID
         AND MD.ORG_ID                  = HD.ORG_ID
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = W_WAGE_TYPE
         AND MP.PERSON_ID               = W_PERSON_ID   
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
         AND MP.TOT_DED_AMOUNT          <> 0
      ORDER BY HD.SORT_NUM, HD.DEDUCTION_CODE
     ;
  END SELECT_MONTH_DEDUCTION;

---------------------------------------------------------------------------------------------------
-- 급여 지급시 지급되는 상여 지급내역 조회
  PROCEDURE SELECT_MONTH_ALLOWANCE_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck 적용할 경우 사용 : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR2 FOR
      SELECT MA.PERSON_ID
           , MA.PAY_YYYYMM
           , MA.WAGE_TYPE
           , MA.CORP_ID
           , MA.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME AS ALLOWANCE_NAME
           , MA.ALLOWANCE_AMOUNT
           , MA.MONTH_PAYMENT_ID
           , MA.CREATED_FLAG
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
       WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
         AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
         AND MA.SOB_ID                  = HA.SOB_ID
         AND MA.ORG_ID                  = HA.ORG_ID
         AND MA.CORP_ID                 = W_CORP_ID
         AND MA.PAY_YYYYMM              = V_BONUS_YYYYMM   -- 상여금.
         AND MA.WAGE_TYPE               = V_BONUS_TYPE
         AND MA.PERSON_ID               = W_PERSON_ID   
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
         AND MP.TOT_SUPPLY_AMOUNT       <> 0
      ORDER BY HA.SORT_NUM, HA.ALLOWANCE_CODE
     ;
  END SELECT_MONTH_ALLOWANCE_BONUS;
            
---------------------------------------------------------------------------------------------------
-- 급여 지급시 지급되는 상여 공제내역 조회
  PROCEDURE SELECT_MONTH_DEDUCTION_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck 적용할 경우 사용 : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR2 FOR
      SELECT MD.PERSON_ID
           , MD.PAY_YYYYMM
           , MD.WAGE_TYPE
           , MD.CORP_ID
           , MD.DEDUCTION_ID
           , HD.DEDUCTION_NAME AS DEDUCTION_NAME
           , MD.DEDUCTION_AMOUNT AS DEDUCTION_AMOUNT
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_DEDUCTION MD
          , HRM_DEDUCTION_V HD
       WHERE MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID
         AND MD.DEDUCTION_ID            = HD.DEDUCTION_ID
         AND MD.SOB_ID                  = HD.SOB_ID
         AND MD.ORG_ID                  = HD.ORG_ID
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.PAY_YYYYMM              = V_BONUS_YYYYMM   -- 상여금.
         AND MP.WAGE_TYPE               = V_BONUS_TYPE
         AND MP.PERSON_ID               = W_PERSON_ID   
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
         AND MP.TOT_DED_AMOUNT          <> 0
      ORDER BY HD.SORT_NUM, HD.DEDUCTION_CODE
     ;
  END SELECT_MONTH_DEDUCTION_BONUS;
                   
END HRP_MONTH_PAYMENT_PRINT_G
;
/
