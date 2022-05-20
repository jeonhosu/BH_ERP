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
                    WHEN S_PMH.PAY_TYPE = '2' THEN S_PMH.BASIC_AMOUNT
                    ELSE 0
                  END) AS BASIC_DAILY_AMOUNT  -- 일급.
            , MAX(CASE
                    WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT
                    ELSE 0
                  END) AS BASIC_TIME_AMOUNT  -- 시급.
            , MAX(MP.GENERAL_HOURLY_AMOUNT) AS GENERAL_HOURLY_AMOUNT  -- 통상시급.
            , MP.DESCRIPTION
            , MP.PAY_TYPE
            , CASE
                WHEN SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) <> 0 OR SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) <> 0 THEN
                     SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '년 [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '월 급여 / '  || SUBSTR(MAX(MP.PAY_YYYYMM), 6, 2) || '월 상여] 지급명세서' 
                ELSE SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '년 [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '월 급여] 지급명세서'
              END AS WAGE_TYPE_NAME
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
                                    WHERE HA.ALLOWANCE_ID  = PML.ALLOWANCE_ID
                                      AND HA.ALLOWANCE_TYPE   = 'BASIC'
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
        AND MP.PAY_TYPE             = NVL(W_PAY_TYPE, MP.PAY_TYPE)
        AND PM.PERSON_ID            = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND PM.DEPT_ID              = NVL(W_DEPT_ID, PM.DEPT_ID)
        AND MP.SOB_ID               = W_SOB_ID
        AND MP.ORG_ID               = W_ORG_ID
        AND (MP.TOT_SUPPLY_AMOUNT       <> 0
           AND MP.TOT_DED_AMOUNT         <> 0)
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
      /*SELECT  MP.CORP_ID
            , MP.PERSON_ID
            , MIN(MP.WAGE_TYPE) AS WAGE_TYPE
            , MP.SOB_ID
            , MP.ORG_ID
            , MIN(MP.PAY_YYYYMM) AS PAY_YYYYMM
            , PM.NAME
            , PM.PERSON_NUM
            , HRM_DEPT_MASTER_G.DEPT_NAME_F(MP.DEPT_ID) AS DEPT_NAME
            , HRM_COMMON_G.ID_NAME_F(MP.POST_ID) AS POST_NAME
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_NAME
            , MAX(MP.SUPPLY_DATE) AS SUPPLY_DATE
            , S_PMH.BANK_NAME
            , (RPAD(SUBSTR(S_PMH.BANK_ACCOUNTS, 1, LENGTH(S_PMH.BANK_ACCOUNTS) - 6), LENGTH(S_PMH.BANK_ACCOUNTS), '*')) AS BANK_ACCOUNTS
            , MP.REAL_AMOUNT
            ,'N' AS SELECT_CHECK_YN
            , CASE
                WHEN S_PMH.PAY_TYPE IN('1', '3') THEN S_PMH.BASIC_AMOUNT
                ELSE 0
              END AS BASIC_AMOUNT
            , CASE
                WHEN S_PMH.PAY_TYPE = '2' THEN TRUNC(S_PMH.BASIC_AMOUNT / 4)
                WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT
                ELSE 0
              END AS BASIC_TIME_AMOUNT
            , MP.GENERAL_HOURLY_AMOUNT
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
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
                                    WHERE HA.ALLOWANCE_ID  = PML.ALLOWANCE_ID
                                      AND HA.ALLOWANCE_TYPE   = 'BASIC'
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
        AND MP.SOB_ID               = PM.SOB_ID
        AND MP.ORG_ID               = PM.ORG_ID
        AND MP.PERSON_ID            = S_PMH.PERSON_ID
        AND MP.SOB_ID               = S_PMH.SOB_ID
        AND MP.ORG_ID               = S_PMH.ORG_ID
        AND MP.CORP_ID              = W_CORP_ID
        \*AND MP.PAY_YYYYMM         = W_PAY_YYYYMM
        AND MP.WAGE_TYPE          = W_WAGE_TYPE*\
        AND ((MP.PAY_YYYYMM         = W_PAY_YYYYMM
          AND MP.WAGE_TYPE          = W_WAGE_TYPE)
        OR (MP.PAY_YYYYMM           = V_BONUS_YYYYMM
          AND MP.WAGE_TYPE          = V_BONUS_TYPE))
        AND MP.PAY_TYPE             = NVL(W_PAY_TYPE, MP.PAY_TYPE)
        AND PM.PERSON_ID            = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND PM.DEPT_ID              = NVL(W_DEPT_ID, PM.DEPT_ID)
        AND MP.SOB_ID               = W_SOB_ID
        AND MP.ORG_ID               = W_ORG_ID
      ;*/

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
                      
    OPEN P_CURSOR3 FOR
      SELECT MT.PERSON_ID
           , MT.CORP_ID
           , MT.DUTY_YYYYMM
           , MT.TOTAL_ATT_DAY * 8 AS TOTAL_ATT_DAY  -- 기본근무시간;
           , MTD.DUTY_30 AS DUTY_30
           , HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(MT.PERSON_ID, V_START_DATE, V_END_DATE, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT
           , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(V_START_DATE, V_END_DATE, MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS HOLY_1_COUNT  -- 공휴일수.
           , MT.HOLY_0_COUNT  -- 무급휴일수;
           , MT.HOLY_1_COUNT  -- 유급휴일수;
           , MT.LATE_DED_COUNT
           , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT
           , MT.WEEKLY_DED_COUNT
           , MTD.DUTY_11 -- 결근일수.
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
              WHERE PMH.PERSON_ID     = W_PERSON_ID
                AND PMH.CORP_ID       = W_CORP_ID
                AND PMH.START_YYYYMM  <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM    >= W_PAY_YYYYMM
                AND PMH.SOB_ID        = W_SOB_ID
                AND PMH.ORG_ID        = W_ORG_ID
             ) S_PMH
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID
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
