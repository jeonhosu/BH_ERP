CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_PRINT_WEB_G
AS

  PROCEDURE MONTH_PAYMENT_PERSON
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_DUTY_TIME
            ( P_CURSOR3           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_DUTY_ETC
            ( P_CURSOR3           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_PAYMENT_TOTAL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );
                        
/*        
  PROCEDURE MONTH_PAYMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_JUMIN_NO          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_DUTY
            ( P_CURSOR3           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );
            */
---------------------------------------------------------------------------------------------------
-- ?????? ???????? ????
  PROCEDURE SELECT_MONTH_ALLOWANCE
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- ?????? ???????? ???? / ???? / ????.
  PROCEDURE SELECT_MONTH_DEDUCTION
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ???? ?????? ???????? ???? ???????? ????
  PROCEDURE SELECT_MONTH_ALLOWANCE_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- ???? ?????? ???????? ???? ???????? ????
  PROCEDURE SELECT_MONTH_DEDUCTION_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );
                        
END HRP_MONTH_PAYMENT_PRINT_WEB_G
;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_PRINT_WEB_G
AS

-- 1. ????????;
  PROCEDURE MONTH_PAYMENT_PERSON
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CLOSED_YN                   VARCHAR2(2) := 'N';
    V_OPEN_DATE                   DATE;
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      SELECT NVL(HC.CLOSING_YN, 'N') AS CLOSING_YN
          , HC.OPEN_DATE
        INTO V_CLOSED_YN
          , V_OPEN_DATE
        FROM HRM_CLOSING HC
      WHERE HC.CLOSING_YYYYMM         = W_PAY_YYYYMM
        AND HC.SOB_ID                 = W_SOB_ID
        AND HC.ORG_ID                 = W_ORG_ID
        AND EXISTS
              ( SELECT 'X'
                  FROM HRM_CLOSING_TYPE_V CT
                WHERE CT.CLOSING_TYPE_ID  = HC.CLOSING_TYPE_ID
                  AND CT.CLOSING_TYPE     = W_WAGE_TYPE
              )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := '-';
    END;
    IF V_CLOSED_YN = '-' THEN
      RAISE_APPLICATION_ERROR(-20001, '???? ?????? ?????? ???? ?????????? ?????? ????????. ?????????? ??????????');
      RETURN;  
    ELSIF V_CLOSED_YN = 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, '???? ?????? ?????? ???? ?????????? ???? ??????????. ?????????? ??????????');
      RETURN;
    ELSIF V_SYSDATE < NVL(V_OPEN_DATE, V_SYSDATE - 1) THEN
      RAISE_APPLICATION_ERROR(-20001, '???? ?????? ?????? ???? ?????????? ???? ??????????. ?????????? ??????????');
      RETURN;
    END IF;
    
    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck ?????? ???? ???? : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR1 FOR
      -- ????????.
      SELECT  MP.CORP_ID
            , MP.PERSON_ID
            , MIN(MP.WAGE_TYPE) AS WAGE_TYPE            
            , MIN(MP.PAY_YYYYMM) AS PAY_YYYYMM
            , PM.NAME                                                    -- ????.
            , PM.PERSON_NUM                                              -- ????????.
            , DM.DEPT_NAME AS DEPT_NAME                                  -- ????;
            , PC.POST_NAME                                               -- ????.
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_NAME  -- ????;
            , MAX(MP.SUPPLY_DATE) AS SUPPLY_DATE                         -- ????????.
            , S_PMH.BANK_NAME                                            -- ????????.
            , MAX(RPAD(SUBSTR(S_PMH.BANK_ACCOUNTS, 1, LENGTH(S_PMH.BANK_ACCOUNTS) - 6), LENGTH(S_PMH.BANK_ACCOUNTS), '*')) AS BANK_ACCOUNTS  -- ????????????.
            , CASE
                WHEN SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) <> 0 OR SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) <> 0 THEN
                     SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '?? [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '?? ???? / '  || SUBSTR(MAX(MP.PAY_YYYYMM), 6, 2) || '?? ????] ??????????' 
                ELSE SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '?? [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '?? ????] ??????????'
              END AS WAGE_TYPE_NAME  -- (????)??????????.
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , ( SELECT PMH.PERSON_ID
                   , PMH.BANK_ID
                   , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                   , PMH.BANK_ACCOUNTS
                   , PMH.PAY_TYPE
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
        AND ((MP.PAY_YYYYMM         = W_PAY_YYYYMM
          AND MP.WAGE_TYPE          = W_WAGE_TYPE)
        OR (MP.PAY_YYYYMM           = V_BONUS_YYYYMM
          AND MP.WAGE_TYPE          = V_BONUS_TYPE))
        AND PM.PERSON_ID            = W_PERSON_ID
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
  END MONTH_PAYMENT_PERSON;

-- 2. ???????? / ????????
  PROCEDURE MONTH_DUTY_TIME
            ( P_CURSOR3           OUT TYPES.TCURSOR1
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
           , MT.TOTAL_ATT_DAY * 8 AS TOTAL_ATT_TIME                            -- ????????????;
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.OVER_TIME, 0)
               ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0) + NVL(MTO.HOLY_1_OT, 0) + NVL(MTO.HOLY_0_OT, 0) 
             END AS OVER_TIME                                                  -- ????????.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.NIGHT_TIME, 0) 
               ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)  + NVL(MTO.HOLY_1_NIGHT, 0) + NVL(MTO.HOLY_0_NIGHT, 0)
             END AS NIGHT_BONUS_TIME                                           -- ????????.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.HOLIDAY_TIME, 0)
             END AS HOLIDAY_TIME                                               -- ????????.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.LATE_TIME, 0) + NVL(MTO.LEAVE_TIME, 0)
             END AS LATE_TIME                                                  -- ????????????;
           , (CASE
               WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT
               ELSE 0
              END) AS BASIC_TIME_AMOUNT                                        -- ????.
           , (CASE
               WHEN S_PMH.PAY_TYPE = '2' THEN S_PMH.BASIC_AMOUNT
               ELSE 0
              END) AS BASIC_DAILY_AMOUNT                                       -- ????.
           , (CASE
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN S_PMH.BASIC_AMOUNT
               ELSE 0
              END) AS BASIC_AMOUNT                                             -- ??????.
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
          , ( SELECT PMH.PERSON_ID
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
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.START_YYYYMM        <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM          >= W_PAY_YYYYMM
                AND PMH.SOB_ID              = W_SOB_ID
                AND PMH.ORG_ID              = W_ORG_ID
             ) S_PMH
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID(+)
        AND MT.DUTY_TYPE               = V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
        AND MT.PERSON_ID               = W_PERSON_ID
        AND MT.SOB_ID                  = W_SOB_ID
        AND MT.ORG_ID                  = W_ORG_ID
      ;
  END MONTH_DUTY_TIME;

-- 3. ???????? / ????????
  PROCEDURE MONTH_DUTY_ETC
            ( P_CURSOR3           OUT TYPES.TCURSOR1
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
           , MT.TOTAL_ATT_DAY AS TOTAL_ATT_DAY                                        -- ????????;
           , MT.HOLY_1_COUNT                                                          -- ????????;
           , MT.HOLY_0_COUNT                                                          -- ????????;
           , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(V_START_DATE, V_END_DATE, MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT  -- ????????.
           , MTD.DUTY_11                                                              -- ????.           
           , MT.LATE_DED_COUNT                                                        -- ??????.
           , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT  -- ??????????.
           , MT.WEEKLY_DED_COUNT                                                      -- ????????.
           , NVL(S_HM.CREATION_NUM, 0) AS CREATION_NUM                                -- ??????????.
           , NVL(S_HM.USE_NUM, 0) AS USE_NUM                                          -- ???? ??????.
           , NVL(S_HM.REMAIN_NUM, 0) AS REMAIN_NUM                                    -- ???? ??????.
           , MTD.DUTY_30 AS DUTY_30
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
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
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_HM.PERSON_ID(+)
        AND MT.DUTY_TYPE               = V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
        AND MT.PERSON_ID               = W_PERSON_ID
        AND MT.SOB_ID                  = W_SOB_ID
        AND MT.ORG_ID                  = W_ORG_ID
      ;
  END MONTH_DUTY_ETC;

-- 5. ????????;  
  PROCEDURE MONTH_PAYMENT_TOTAL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck ?????? ???? ???? : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR1 FOR
      -- ????????.
      SELECT  MP.CORP_ID
            , MP.PERSON_ID
            , SUM(MP.REAL_AMOUNT) AS REAL_AMOUNT  -- ?? ????????.
            , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOT_SUPPLY_AMOUNT  -- ????????.
            , SUM(MP.TOT_DED_AMOUNT) AS TOT_DED_AMOUNT  -- ????????.
            , SUM(DECODE(MP.WAGE_TYPE, 'P1', MP.REAL_AMOUNT, 0)) AS REAL_PAY_AMOUNT  -- ????????(??????).
            , SUM(DECODE(MP.WAGE_TYPE, 'P1', MP.TOT_SUPPLY_AMOUNT, 0)) AS TOT_PAY_SUP_AMOUNT  -- ????????(??????).
            , SUM(DECODE(MP.WAGE_TYPE, 'P1', MP.TOT_DED_AMOUNT, 0)) AS TOT_PAY_DED_AMOUNT  -- ????????(??????).
            , SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.REAL_AMOUNT, 0)) AS REAL_BONUS_AMOUNT  -- ????????(??????).
            , SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) AS TOT_BONUS_SUP_AMOUNT  -- ????????(??????).
            , SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) AS TOT_BONUS_DED_AMOUNT     -- ????????(??????).
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
      WHERE MP.PERSON_ID            = PM.PERSON_ID
        AND ((MP.PAY_YYYYMM         = W_PAY_YYYYMM
          AND MP.WAGE_TYPE          = W_WAGE_TYPE)
        OR (MP.PAY_YYYYMM           = V_BONUS_YYYYMM
          AND MP.WAGE_TYPE          = V_BONUS_TYPE))
        AND PM.PERSON_ID            = W_PERSON_ID
        AND MP.SOB_ID               = W_SOB_ID
        AND MP.ORG_ID               = W_ORG_ID
        AND (MP.TOT_SUPPLY_AMOUNT       <> 0
           AND MP.TOT_DED_AMOUNT         <> 0)
      GROUP BY MP.CORP_ID
            , MP.PERSON_ID
      ;
  END MONTH_PAYMENT_TOTAL;
 /* 
----------------------------------------------------------------------------------------------  
-- ????????, ???? ????, ???????? ????.
  PROCEDURE MONTH_PAYMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_JUMIN_NO          IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_JUMON_NO                    VARCHAR2(13) := '-';
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      SELECT PM.REPRE_NUM
        INTO V_JUMON_NO
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID        = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_JUMON_NO := '-';
    END;
    IF V_JUMON_NO = '-' OR V_JUMON_NO <> W_JUMIN_NO THEN
      RETURN;
    END IF;

    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck ?????? ???? ???? : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR1 FOR
      -- ????????.
      SELECT  MP.CORP_ID
            , MP.PERSON_ID
            , MIN(MP.WAGE_TYPE) AS WAGE_TYPE            
            , MP.SOB_ID
            , MP.ORG_ID
            , MIN(MP.PAY_YYYYMM) AS PAY_YYYYMM
            , PM.NAME
            , PM.PERSON_NUM
            , DM.DEPT_NAME AS DEPT_NAME  -- ????;
            , PC.POST_NAME  -- ????.
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_NAME  -- ????;
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
                  END) AS BASIC_AMOUNT  -- ??????.
            , MAX(CASE
                    WHEN S_PMH.PAY_TYPE = '2' THEN S_PMH.BASIC_AMOUNT
                    ELSE 0
                  END) AS BASIC_DAILY_AMOUNT  -- ????.
            , MAX(CASE
                    WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT
                    ELSE 0
                  END) AS BASIC_TIME_AMOUNT  -- ????.
            , MAX(MP.GENERAL_HOURLY_AMOUNT) AS GENERAL_HOURLY_AMOUNT  -- ????????.
            , MP.DESCRIPTION
            , MP.PAY_TYPE
            , CASE
                WHEN SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) <> 0 OR SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) <> 0 THEN
                     SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '?? [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '?? ???? / '  || SUBSTR(MAX(MP.PAY_YYYYMM), 6, 2) || '?? ????] ??????????' 
                ELSE SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '?? [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '?? ????] ??????????'
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
        AND ((MP.PAY_YYYYMM         = W_PAY_YYYYMM
          AND MP.WAGE_TYPE          = W_WAGE_TYPE)
        OR (MP.PAY_YYYYMM           = V_BONUS_YYYYMM
          AND MP.WAGE_TYPE          = V_BONUS_TYPE))
        AND PM.PERSON_ID            = W_PERSON_ID
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
  END MONTH_PAYMENT;

-- ????????, ???????? ????.
  PROCEDURE MONTH_DUTY
            ( P_CURSOR3           OUT TYPES.TCURSOR1
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
           , MT.TOTAL_ATT_DAY AS TOTAL_ATT_DAY  -- ????????????;
           , MT.TOTAL_ATT_DAY * 8 AS TOTAL_ATT_TIME  -- ????????????;
           , MTD.DUTY_30 AS DUTY_30
           , HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(MT.PERSON_ID, V_START_DATE, V_END_DATE, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT
           , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(V_START_DATE, V_END_DATE, MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS HOLY_1_COUNT  -- ????????.
           , MT.HOLY_0_COUNT  -- ??????????;
           , MT.HOLY_1_COUNT  -- ??????????;
           , MT.LATE_DED_COUNT
           , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT
           , MT.WEEKLY_DED_COUNT
           , MTD.DUTY_11 -- ????????.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.LATE_TIME, 0) + NVL(MTO.LEAVE_TIME, 0)
             END AS LATE_TIME  -- ????/????;
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.OVER_TIME, 0)
               ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0) + NVL(MTO.HOLY_1_OT, 0) + NVL(MTO.HOLY_0_OT, 0) 
             END AS OVER_TIME   -- ????.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.NIGHT_TIME, 0) 
               ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)  + NVL(MTO.HOLY_1_NIGHT, 0) + NVL(MTO.HOLY_0_NIGHT, 0)
             END AS NIGHT_BONUS_TIME   -- ????????.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.HOLIDAY_TIME, 0)
             END AS HOLIDAY_TIME            -- ???? ????.
           , NVL(S_HM.CREATION_NUM, 0) AS CREATION_NUM  -- ??????????.
           , NVL(S_HM.USE_NUM, 0) AS USE_NUM            -- ???? ??????.
           , NVL(S_HM.REMAIN_NUM, 0) AS REMAIN_NUM      -- ???? ??????.
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
          , ( SELECT PMH.PERSON_ID
                   , PMH.PAY_TYPE
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.PERSON_ID     = W_PERSON_ID
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
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID(+)
        AND MT.PERSON_ID               = S_HM.PERSON_ID(+)
        AND MT.DUTY_TYPE               = V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
        AND MT.PERSON_ID               = W_PERSON_ID
        AND MT.SOB_ID                  = W_SOB_ID
        AND MT.ORG_ID                  = W_ORG_ID
      ;
  END MONTH_DUTY;
  */
---------------------------------------------------------------------------------------------------
-- ?????? ???????? ????
  PROCEDURE SELECT_MONTH_ALLOWANCE
            ( P_CURSOR2           OUT TYPES.TCURSOR2
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
-- ?????? ???????? ???? / ???? / ????.
  PROCEDURE SELECT_MONTH_DEDUCTION
            ( P_CURSOR2           OUT TYPES.TCURSOR2
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
-- ???? ?????? ???????? ???? ???????? ????
  PROCEDURE SELECT_MONTH_ALLOWANCE_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
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
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck ?????? ???? ???? : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
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
         AND MA.PAY_YYYYMM              = V_BONUS_YYYYMM   -- ??????.
         AND MA.WAGE_TYPE               = V_BONUS_TYPE
         AND MA.PERSON_ID               = W_PERSON_ID   
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
         AND MP.TOT_SUPPLY_AMOUNT       <> 0
      ORDER BY HA.SORT_NUM, HA.ALLOWANCE_CODE
     ;
  END SELECT_MONTH_ALLOWANCE_BONUS;
            
---------------------------------------------------------------------------------------------------
-- ???? ?????? ???????? ???? ???????? ????
  PROCEDURE SELECT_MONTH_DEDUCTION_BONUS
            ( P_CURSOR2           OUT TYPES.TCURSOR2
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
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck ?????? ???? ???? : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
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
         AND MP.PAY_YYYYMM              = V_BONUS_YYYYMM   -- ??????.
         AND MP.WAGE_TYPE               = V_BONUS_TYPE
         AND MP.PERSON_ID               = W_PERSON_ID   
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
         AND MP.TOT_DED_AMOUNT          <> 0
      ORDER BY HD.SORT_NUM, HD.DEDUCTION_CODE
     ;
  END SELECT_MONTH_DEDUCTION_BONUS;
                   
END HRP_MONTH_PAYMENT_PRINT_WEB_G
; 
/
