CREATE OR REPLACE PACKAGE HRR_RETIRE_ADJUSTMENT_SET_G
AS

/*==========================================================================/
     ==> 퇴직정산 계산
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
/==========================================================================*/
  PROCEDURE RETIRE_MAIN
            ( W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

/*==========================================================================/
     ==> 퇴직금 계산
       -. P_DAY_AVG_AMOUNT : 일평균 금액
       -. P_TOTAL_DAY : 총근속일수
/==========================================================================*/
  FUNCTION  RETR_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_DAY_AVG_AMOUNT          IN NUMBER
            , P_TOTAL_DAY               IN NUMBER            
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 퇴직소득공제 계산   - 1
/==========================================================================*/
  FUNCTION  INCOME_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_TOTAL_AMOUNT            IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 퇴직근속년수에 의한 공제액 산출  - 2
/==========================================================================*/
  FUNCTION LONG_DED_YEAR_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_LONG_YEAR               IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 년 평균 산출세액 계산   - 5
/==========================================================================*/
  FUNCTION AVG_TAX_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_AVG_TAX_STD_AMOUNT      IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 퇴직소득공제 계산  - 6
/==========================================================================*/
  FUNCTION TAX_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_END_DATE                IN DATE
            , P_LONG_YEAR               IN NUMBER
            , P_TAX_AMOUNT              IN NUMBER
            ) RETURN NUMBER;

END HRR_RETIRE_ADJUSTMENT_SET_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_ADJUSTMENT_SET_G
AS

/*==========================================================================/
     ==> 퇴직정산 계산
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
       1. 퇴직소득공제 계산(INCOME_SUBTRACT)   V
       2. 근로소득공제 계산(CONTINUOUS_YEAR)   V
       3. 퇴직소득공제계(퇴직소득공제 + 근로소득공제)   V
       4. 과세표준(퇴직금 - 퇴직소득공제계)   V
       5. 산출세액(CAL_TAX)
       6. 퇴직소득세액공제() - 폐지
       7. 소득세 및 주민세(소득세 * 0.1) 계산

/==========================================================================*/
  PROCEDURE RETIRE_MAIN
            ( W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);

    V_ADJUSTMENT_ID                               NUMBER;         -- 퇴직정산 ID
    V_RETR_YYYY                                   VARCHAR2(4);    -- 퇴직년도
    V_3RD_DAY_COUNT                               NUMBER;         -- 3개월 총일수 (급여일수)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3개월 총일수 (상여연차일수)
    V_REAL_DAY                                    NUMBER;         -- 실제 적용되는 근무일수
    V_RETR_AMOUNT                                 NUMBER;         -- 퇴직금
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- 총퇴직금
    V_REAL_AMOUNT                                 NUMBER;         -- 실퇴직금        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- 퇴직소득공제
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- 근속년수에 따른 소득공제
    V_TAX_STD_AMOUNT                              NUMBER;         -- 과세표준
    V_AVG_TAX_STD_AMOUNT                          NUMBER;         -- 년평균과세표준
    V_AVG_COMP_TAX_AMOUNT                         NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT                             NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT                              NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT                               NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT                            NUMBER;         -- 주민세
    
    V_H_RETIRE_DATE_FR                            DATE;           -- 명예퇴직 정산 시작일.
    V_H_RETIRE_DATE_TO                            DATE;           -- 명예퇴직 정산 종료일.
    V_H_LONG_YEAR                                 NUMBER;         -- 명예퇴직 근속년수.
    V_H_PRE_LONG_YEAR                             NUMBER;         -- 명예퇴직부터 중도정산 이전 근속년수.
    V_H_INCOME_DED_AMOUNT                         NUMBER;         -- 퇴직소득공제
    V_H_LONG_DED_YEAR_AMOUNT                      NUMBER;         -- 근속년수에 따른 소득공제    
    V_H_TAX_STD_AMOUNT                            NUMBER;         -- 과세표준
    V_H_AVG_TAX_STD_AMOUNT                        NUMBER;         -- 년평균과세표준
    V_H_AVG_COMP_TAX_AMOUNT                       NUMBER;         -- 년평균 산출세액
    V_H_COMP_TAX_AMOUNT                           NUMBER;         -- 산출세액
    V_H_TAX_DED_AMOUNT                            NUMBER;         -- 퇴직소득세액공제
    V_H_IN_TAX_AMOUNT                             NUMBER;         -- 소득세
    V_H_LOCAL_TAX_AMOUNT                          NUMBER;         -- 주민세
    V_H_REAL_AMOUNT                               NUMBER;         -- 명예퇴직금.
    
    V_REAL_TOTAL_AMOUNT                           NUMBER;         -- 실 총퇴직금.
    V_TEMP_AMOUNT                                 NUMBER;         -- 임시 변수.
    
  BEGIN
    O_STATUS := 'F';
    --> 퇴직년도 계산
    BEGIN
      V_RETR_YYYY := TO_CHAR(W_RETIRE_DATE_TO, 'YYYY');
    EXCEPTION WHEN OTHERS THEN
      V_RETR_YYYY := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY');
    END;

-----------------------------------------------------------
    --> 기존에 처리된 퇴직정산 ID 조회(동일 기간에 대해)
    V_ADJUSTMENT_ID := 0;
    BEGIN
      SELECT RA.ADJUSTMENT_ID
        INTO V_ADJUSTMENT_ID
        FROM HRR_RETIRE_ADJUSTMENT RA
      WHERE RA.ADJUSTMENT_TYPE    = W_ADJUSTMENT_TYPE
        AND RA.PERSON_ID          = W_PERSON_ID
        AND RA.CORP_ID            = W_CORP_ID
        AND RA.RETIRE_DATE_FR     = W_RETIRE_DATE_FR
        AND RA.RETIRE_DATE_TO     = W_RETIRE_DATE_TO
        AND RA.SOB_ID             = W_SOB_ID
        AND RA.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADJUSTMENT_ID := -1;
    END;

    IF HRR_RETIRE_ADJUSTMENT_G.CLOSE_CHECK_F(V_ADJUSTMENT_ID) = 'Y' THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10168');
      RETURN;
    END IF;
    
    IF V_ADJUSTMENT_ID = 0 OR V_ADJUSTMENT_ID = -1 THEN
    --> 1.1 신규 생성
      BEGIN
          INSERT INTO HRR_RETIRE_ADJUSTMENT
          ( ADJUSTMENT_ID 
          , ADJUSTMENT_TYPE, ADJUSTMENT_YYYY, PERSON_ID , CORP_ID 
          , RETIRE_DATE_FR, RETIRE_DATE_TO
          , COST_CENTER_ID
          , SOB_ID, ORG_ID
          , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
          , OFFICER_YN)
          ( SELECT HRR_RETIRE_ADJUSTMENT_S1.NEXTVAL
                , W_ADJUSTMENT_TYPE, V_RETR_YYYY, PM.PERSON_ID, PM.CORP_ID
                , W_RETIRE_DATE_FR, W_RETIRE_DATE_TO
                , PM.COST_CENTER_ID
                , W_SOB_ID, W_ORG_ID
                , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
                , NVL(T1.OFFICER_YN, 'N') AS OFFICER_YN
              FROM HRM_PERSON_MASTER PM
                 , (-- 시점 인사내역.
                  SELECT HL.PERSON_ID
                      , HL.DEPT_ID
                      , HL.POST_ID
                      , PC.OFFICER_YN
                      , HL.JOB_CATEGORY_ID
                      , HL.FLOOR_ID    
                    FROM HRM_HISTORY_LINE HL  
                       , HRM_POST_CODE_V  PC
                  WHERE HL.POST_ID          = PC.POST_ID
                    AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE            <= TRUNC(W_RETIRE_DATE_TO)
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
                  ) T1
            WHERE PM.PERSON_ID    = T1.PERSON_ID
              AND PM.PERSON_ID    = W_PERSON_ID
          );
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Person Infomation Error =>' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;

--. 매월 말일 퇴사일 경우 3개월 이전 1일 기준 그외에는 ADD_MONTHS(기준일, -3)
    V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
    V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;

    --> 1.2 근속년수, 근속월수, 근속일수 계산
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_MONTH = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, W_RETIRE_DATE_TO, 1)        
        , RA.DAY_3RD_COUNT = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
--> 3개월 급여 계산 : 신규계산시만 적용.-
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 명절상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 특별상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => V_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_RETIRE_DATE_TO
                              , P_WAGE_TYPE => 'P5'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );                              
      --> 년차합계.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.YEAR_ALLOWANCE_AMOUNT)
            = NVL(
              ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS YEAR_ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                   , HRP_MONTH_ALLOWANCE MA
                   , HRM_ALLOWANCE_V HA
                WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                  AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                  AND MP.PAY_YYYYMM              = TO_CHAR(TRUNC(RA.RETIRE_DATE_TO, 'YEAR'), 'YYYY-MM')
                  AND MP.PERSON_ID               = RA.PERSON_ID
                  AND MP.SOB_ID                  = RA.SOB_ID
                  AND MP.ORG_ID                  = RA.ORG_ID
                  AND HA.ALLOWANCE_TYPE          IN('YEAR')
                  AND HA.RETIRE_YN               = 'Y'
                GROUP BY MP.PERSON_ID
               ), 0)
        WHERE RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;
    
    BEGIN
      --> 급/상여 적용 계산.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.TOTAL_PAY_AMOUNT, RA.TOTAL_BONUS_AMOUNT)
            = (SELECT NVL(SUM(DECODE(RAP.WAGE_TYPE, 'P1', RAP.TOTAL_AMOUNT, 0)), 0) AS PAY_TOTAL_AMOUNT
                   , NVL(SUM(CASE
                               WHEN RAP.WAGE_TYPE IN('P2', 'P3', 'P5') THEN RAP.TOTAL_AMOUNT
                               ELSE 0
                             END), 0) AS BONUS_TOTAL_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT_PAYMENT RAP
               WHERE RAP.ADJUSTMENT_ID          = RA.ADJUSTMENT_ID
                 AND RAP.WAGE_TYPE              IN('P1', 'P2', 'P3', 'P5')    -- P1-급여, P2-상여, P3-명절상여, P5-특별상여.
               ) 
        WHERE RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;

       --> 일평균금액 산출
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = V_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    
    --> 퇴직정산을 위한 기초 정보
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.DED_DAY, 0) AS DED_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
                    , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT
                    , NVL(RA.INCOME_DED_AMOUNT, 0) AS INCOME_DED_AMOUNT
                    , NVL(RA.LONG_DED_AMOUNT , 0) AS LONG_DED_AMOUNT
                    , NVL(RA.TAX_STD_AMOUNT, 0) AS TAX_STD_AMOUNT
                    , NVL(RA.AVG_TAX_STD_AMOUNT, 0) AS AVG_TAX_STD_AMOUNT
                    , NVL(RA.AVG_COMP_TAX_AMOUNT, 0) AS AVG_COMP_TAX_AMOUNT
                    , NVL(RA.COMP_TAX_AMOUNT, 0) AS COMP_TAX_AMOUNT
                    , NVL(RA.TAX_DED_AMOUNT, 0) AS TAX_DED_AMOUNT
                    , NVL(RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
                    , NVL(RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.ADJUSTMENT_ID      = V_ADJUSTMENT_ID
               )
    LOOP
      --> 초기화
      V_REAL_DAY := 0;                  -- 실제 근속일수
      V_RETR_AMOUNT := 0;               -- 퇴직금
      V_TOTAL_RETR_AMOUNT := 0;         -- 총퇴직금 합계
      
      V_INCOME_DED_AMOUNT := 0;            -- 퇴직소득공제
      V_LONG_DED_YEAR_AMOUNT := 0;   -- 근속년수에 따른 소득공제
      V_TAX_STD_AMOUNT := 0;               -- 과세표준
      V_AVG_TAX_STD_AMOUNT := 0;           -- 년평균 과세표준
      V_AVG_COMP_TAX_AMOUNT := 0;          -- 년평균 산출세액
      V_COMP_TAX_AMOUNT := 0;              -- 산출세액
      V_TAX_DED_AMOUNT := 0;               -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT := 0;                -- 소득세
      V_LOCAL_TAX_AMOUNT := 0;             -- 주민세
      V_REAL_AMOUNT := 0;          -- 실퇴직금

      V_H_RETIRE_DATE_FR                            := NULL;      -- 명예퇴직 정산 시작일.   
      V_H_RETIRE_DATE_TO                            := NULL;      -- 명예퇴직 정산 종료일.
      V_H_LONG_YEAR                                 := 0;         -- 명예퇴직 근속년수.
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;
      V_H_INCOME_DED_AMOUNT                         := 0;         -- 퇴직소득공제
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;         -- 근속년수에 따른 소득공제
      V_H_TAX_STD_AMOUNT                            := 0;         -- 과세표준
      V_H_AVG_TAX_STD_AMOUNT                        := 0;         -- 년평균과세표준
      V_H_AVG_COMP_TAX_AMOUNT                       := 0;         -- 년평균 산출세액
      V_H_COMP_TAX_AMOUNT                           := 0;         -- 산출세액
      V_H_TAX_DED_AMOUNT                            := 0;         -- 퇴직소득세액공제
      V_H_IN_TAX_AMOUNT                             := 0;         -- 소득세
      V_H_LOCAL_TAX_AMOUNT                          := 0;         -- 주민세
      V_H_REAL_AMOUNT                               := 0;         -- 명예퇴직금.
      
      V_REAL_TOTAL_AMOUNT                           := 0;         -- 실 
      
      --> 퇴직금 계산
      V_REAL_DAY := NVL(C1.LONG_DAY, 0) - NVL(C1.DED_DAY, 0);
      
          -- 세금계산만 처리할 경우 적용 안함.
      IF W_RETIRE_CAL_TYPE <> 'TAX' THEN
        V_RETR_AMOUNT := RETR_AMOUNT_F(V_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY);
      ELSE
        V_RETR_AMOUNT := NVL(C1.RETIRE_AMOUNT, 0);  
      END IF;
      --> 총퇴직금
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0) + NVL(C1.ETC_SUPP_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> 퇴직근로소득 산출
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> 근속에 따른 소득공제
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> 과세 표준
      V_TAX_STD_AMOUNT := V_TOTAL_RETR_AMOUNT - V_INCOME_DED_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;

      --> 년평균 과세표준
      V_AVG_TAX_STD_AMOUNT := TRUNC(V_TAX_STD_AMOUNT / C1.LONG_YEAR);

      --> 산출세액
      V_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT);

      --> 산출세액
      V_COMP_TAX_AMOUNT := V_AVG_COMP_TAX_AMOUNT * C1.LONG_YEAR;

      --> 소득세액공제
      V_TAX_DED_AMOUNT := TAX_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT, C1.LONG_YEAR);

      --> 소득세
      V_IN_TAX_AMOUNT := TRUNC(V_COMP_TAX_AMOUNT - V_TAX_DED_AMOUNT, -1);   -- 무조건 버림
      IF V_IN_TAX_AMOUNT < 0 THEN
        V_IN_TAX_AMOUNT := 0;
      END IF;

      --> 주민세
      V_LOCAL_TAX_AMOUNT := TRUNC(V_IN_TAX_AMOUNT * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100), -1);   -- 무조건 버림

      --> 실지급액 (총퇴직금 - 주민세 - 소득세 - 기타공제 - 퇴직전환금)
      V_REAL_AMOUNT := V_TOTAL_RETR_AMOUNT - V_IN_TAX_AMOUNT - V_LOCAL_TAX_AMOUNT;
      IF V_REAL_AMOUNT < 0 THEN
        V_REAL_AMOUNT := 0;
      END IF;
      
------------------------------------------------------------------------------
-- 5. 명예 퇴직금 계산.
      IF C1.HONORARY_AMOUNT > 0 THEN
        V_H_RETIRE_DATE_FR := C1.JOIN_DATE;
        V_H_RETIRE_DATE_TO := W_RETIRE_DATE_TO;
        
        --> 5.1 근속년수
        BEGIN
          V_H_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, V_H_RETIRE_DATE_TO, 'CEIL');          
          IF V_H_RETIRE_DATE_FR = W_RETIRE_DATE_FR THEN
            V_H_PRE_LONG_YEAR := V_H_LONG_YEAR;
          ELSE
            V_H_PRE_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, W_RETIRE_DATE_FR - 1, 'CEIL');
          END IF;
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Honorary - Long Period Calculation Error : ' || SQLERRM;
          RETURN;
        END;

        --> 퇴직근로소득 산출
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 근속에 따른 소득공제(전체 근속에 대한 금액).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 근속부터 중도정산 이전까지의 근속 소득공제.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
        -- 실제 근속 소득공제금액.
        V_H_LONG_DED_YEAR_AMOUNT := V_H_LONG_DED_YEAR_AMOUNT - V_TEMP_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
        IF V_H_LONG_DED_YEAR_AMOUNT < 0 THEN
          V_H_LONG_DED_YEAR_AMOUNT := 0;
        END IF;
        
        --> 과세 표준
        V_H_TAX_STD_AMOUNT := C1.HONORARY_AMOUNT - V_H_INCOME_DED_AMOUNT - V_H_LONG_DED_YEAR_AMOUNT;
        IF V_H_TAX_STD_AMOUNT < 0 THEN
          V_H_TAX_STD_AMOUNT := 0;
        END IF;

        --> 년평균 과세표준
        V_H_AVG_TAX_STD_AMOUNT := TRUNC(V_H_TAX_STD_AMOUNT / V_H_LONG_YEAR);

        --> 산출세액
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> 산출세액
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> 소득세액공제
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(V_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> 소득세
        V_H_IN_TAX_AMOUNT := TRUNC(V_H_COMP_TAX_AMOUNT - V_H_TAX_DED_AMOUNT, -1);   -- 무조건 버림
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> 주민세
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- 무조건 버림
        
        -- 실지급액.
        V_H_REAL_AMOUNT := C1.HONORARY_AMOUNT - V_H_IN_TAX_AMOUNT - V_H_LOCAL_TAX_AMOUNT;
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
      END IF;
------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := V_REAL_AMOUNT + V_H_REAL_AMOUNT - C1.ETC_DED_AMOUNT - C1.RETIRE_CVS_AMOUNT;
      IF V_REAL_TOTAL_AMOUNT < 0 THEN
        V_REAL_TOTAL_AMOUNT := 0;
      END IF;

------------------------------------------------------------------------------
      --> 퇴직금 적용  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.RETIRE_AMOUNT          = V_RETR_AMOUNT
          , RA.RETIRE_TOTAL_AMOUNT    = V_TOTAL_RETR_AMOUNT
          , RA.INCOME_DED_AMOUNT      = V_INCOME_DED_AMOUNT
          , RA.LONG_DED_AMOUNT        = V_LONG_DED_YEAR_AMOUNT
          , RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT
          , RA.AVG_TAX_STD_AMOUNT     = V_AVG_TAX_STD_AMOUNT
          , RA.AVG_COMP_TAX_AMOUNT    = V_AVG_COMP_TAX_AMOUNT
          , RA.COMP_TAX_AMOUNT        = V_COMP_TAX_AMOUNT
          , RA.TAX_DED_AMOUNT         = V_TAX_DED_AMOUNT
          , RA.INCOME_TAX_AMOUNT      = V_IN_TAX_AMOUNT
          , RA.RESIDENT_TAX_AMOUNT    = V_LOCAL_TAX_AMOUNT
          , RA.REAL_AMOUNT            = V_REAL_AMOUNT
          , RA.H_RETIRE_DATE_FR       = V_H_RETIRE_DATE_FR
          , RA.H_RETIRE_DATE_TO       = V_H_RETIRE_DATE_TO
          , RA.H_LONG_YEAR            = V_H_LONG_YEAR
          , RA.H_INCOME_DED_AMOUNT    = V_H_INCOME_DED_AMOUNT
          , RA.H_LONG_DED_AMOUNT      = V_H_LONG_DED_YEAR_AMOUNT
          , RA.H_TAX_STD_AMOUNT       = V_H_TAX_STD_AMOUNT
          , RA.H_AVG_TAX_STD_AMOUNT   = V_H_AVG_TAX_STD_AMOUNT
          , RA.H_AVG_COMP_TAX_AMOUNT  = V_H_AVG_COMP_TAX_AMOUNT
          , RA.H_COMP_TAX_AMOUNT      = V_H_COMP_TAX_AMOUNT
          , RA.H_TAX_DED_AMOUNT       = V_H_TAX_DED_AMOUNT
          , RA.H_INCOME_TAX_AMOUNT    = V_H_IN_TAX_AMOUNT
          , RA.H_RESIDENT_TAX_AMOUNT  = V_H_LOCAL_TAX_AMOUNT
          , RA.H_REAL_AMOUNT          = V_H_REAL_AMOUNT
          , RA.REAL_TOTAL_AMOUNT      = V_REAL_TOTAL_AMOUNT
          , RA.LAST_UPDATE_DATE       = V_SYSDATE
          , RA.LAST_UPDATED_BY        = P_USER_ID
      WHERE RA.ADJUSTMENT_ID          = V_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END RETIRE_MAIN;

/*==========================================================================/
     ==> 퇴직금 계산
       -. P_DAY_AVG_AMOUNT : 일평균 금액
       -. P_TOTAL_DAY : 총근속일수
/==========================================================================*/
  FUNCTION RETR_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_DAY_AVG_AMOUNT          IN NUMBER
            , P_TOTAL_DAY               IN NUMBER            
            ) RETURN NUMBER
  AS
    V_RETR_AMOUNT                       NUMBER := 0;    -- 퇴직금

  BEGIN
    BEGIN
      SELECT NVL(P_DAY_AVG_AMOUNT, 0) * NVL(RS.MONTH_DAY, 0) * NVL(P_TOTAL_DAY, 0) / NVL(RS.YEAR_DAY, 365)
        INTO V_RETR_AMOUNT
        FROM HRR_RETIRE_STANDARD RS
      WHERE RS.STD_YYYY                 = W_STD_YYYY
        AND RS.SOB_ID                   = W_SOB_ID
        AND RS.ORG_ID                   = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_RETR_AMOUNT := 0;  
    END;
    
    --> 퇴직금 계산 (일평균금액 * 30 * 총일수 / 365)
    V_RETR_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_RETR_AMOUNT, 'RETIRE_AMOUNT');
    IF V_RETR_AMOUNT < 0 THEN
      V_RETR_AMOUNT := 0;
    END IF;
    RETURN V_RETR_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('0.Retire Amount Cal Error : ' || SQLERRM);
    RETURN 0;
  END RETR_AMOUNT_F;

/*==========================================================================/
     ==> 퇴직소득공제 계산 -- 1
/==========================================================================*/
  FUNCTION  INCOME_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_TOTAL_AMOUNT            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      SELECT NVL(P_TOTAL_AMOUNT, 0) * (NVL(RS.INCOME_DEDUCTION_RATE, 0) / 100) AS INCOME_SUBTRACT
        INTO V_SUBTRACT_AMOUNT
        FROM HRR_RETIRE_STANDARD RS
      WHERE RS.STD_YYYY                 = W_STD_YYYY
        AND RS.SOB_ID                   = W_SOB_ID
        AND RS.ORG_ID                   = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_SUBTRACT_AMOUNT := 0;  
    END;
    
    --> 퇴직금 계산 (일평균금액 * 30 * 총일수 / 365)
    V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
    RETURN V_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('1.Income Subtract Cal Error : ' || SQLERRM);
    RETURN 0;
  END INCOME_SUBTRACT_F;

/*==========================================================================/
     ==> 퇴직근속년수에 의한 공제액 산출  -- 2
/==========================================================================*/
  FUNCTION LONG_DED_YEAR_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_LONG_YEAR               IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      --> 근속년수에 따른 공제 금액
      SELECT ((NVL(P_LONG_YEAR, 0) - NVL(CD.DED_YEAR, 0))* NVL(CD.DED_AMOUNT, 0)) + NVL(CD.DED_ADD_AMOUNT, 0) AS DED_YEAR
        INTO V_SUBTRACT_AMOUNT
      FROM HRR_CONTINUOUS_DEDUCTION CD
      WHERE CD.STD_YYYY           = W_STD_YYYY
        AND P_LONG_YEAR           BETWEEN CD.START_YEAR AND CD.END_YEAR
        AND CD.SOB_ID             = W_SOB_ID
        AND CD.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('2.1 Continuous Year Cal Error : ' || SQLERRM);
      RETURN 0;
    END;

    V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
--DBMS_OUTPUT.PUT_LINE('근속년수공제=>' || V_SUBTRACT_AMT);
    RETURN V_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('2.Continuous Year Cal Error : ' || SQLERRM);
    RETURN 0;
  END LONG_DED_YEAR_F;


/*==========================================================================/
     ==> 산출세액 계산   - 5
/==========================================================================*/
  FUNCTION AVG_TAX_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_AVG_TAX_STD_AMOUNT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_AMOUNT                        NUMBER := 0;

  BEGIN
    BEGIN
    --> 산출세액 조회
      SELECT (NVL(P_AVG_TAX_STD_AMOUNT, 0) * (TR.TAX_RATE /  100)) - NVL(TR.ACCUM_SUB_AMOUNT, 0) AS TAX_AMOUNT
        INTO V_TAX_AMOUNT
        FROM HRA_TAX_RATE TR
          , HRM_COMMON HC
      WHERE TR.TAX_TYPE_ID      = HC.COMMON_ID
      AND TR.TAX_YYYY           = W_STD_YYYY
      AND TR.SOB_ID             = W_SOB_ID
      AND TR.ORG_ID             = W_ORG_ID
      AND HC.CODE               = '20'                               -- 퇴직정산.
      AND P_AVG_TAX_STD_AMOUNT  BETWEEN TR.START_AMOUNT AND TR.END_AMOUNT        
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('5.1 Tax Cal Error : ' || SQLERRM);
      RETURN 0;
    END;
--DBMS_OUTPUT.PUT_LINE('V_TAX_RATE -> ' || V_TAX_RATE || 'V_ACCU -> ' || V_ACCU);

    --> 산출세액 계산
    V_TAX_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_TAX_AMOUNT, 'RETIRE_AMOUNT');
    IF V_TAX_AMOUNT < 0 THEN
      V_TAX_AMOUNT := 0;
    END IF;
    RETURN V_TAX_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('5.Tax Cal Error : ' || SQLERRM);
    RETURN 0;
  END AVG_TAX_AMOUNT_F;


/*==========================================================================/
     ==> 퇴직소득공제 계산  - 6
/==========================================================================*/
  FUNCTION TAX_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_END_DATE                IN DATE
            , P_LONG_YEAR               IN NUMBER
            , P_TAX_AMOUNT              IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_SUBTRACT_AMOUNT               NUMBER := 0;
    V_TAX_DEDUCTION_LMT_AMOUNT          NUMBER := 0;

  BEGIN
     --> 초기화
     V_TAX_SUBTRACT_AMOUNT := 0;

     IF P_END_DATE < TO_DATE('2003-01-01', 'YYYY-MM-DD') THEN
     --> 2003-01-01 이전 적용
       V_TAX_SUBTRACT_AMOUNT := P_TAX_AMOUNT * 0.5;

     ELSIF P_END_DATE BETWEEN TO_DATE('2003-01-01', 'YYYY-MM-DD') AND TO_DATE('2004-12-31', 'YYYY-MM-DD') THEN
     --> 2003-01-01  ~ 2004-12-31 까지 적용
       V_TAX_SUBTRACT_AMOUNT := P_TAX_AMOUNT * 0.25;

     ELSE
     --> 2005-01-01 이후 폐지
       -- 퇴직세액공제 한도 계산;
        BEGIN
          SELECT NVL(P_LONG_YEAR, 1) * NVL(RS.TAX_DEDUCTION_LMT, 0) AS TAX_DEDUCTION_LMT
            INTO V_TAX_DEDUCTION_LMT_AMOUNT
            FROM HRR_RETIRE_STANDARD RS
          WHERE RS.STD_YYYY       = W_STD_YYYY
            AND RS.SOB_ID         = W_SOB_ID
            AND RS.ORG_ID         = W_ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_TAX_DEDUCTION_LMT_AMOUNT := 0;
          DBMS_OUTPUT.PUT_LINE('6.1Tax Deduction Limit Cal Error : ' || SQLERRM);
        END;

       -- 퇴직세액공제금액 계산;
        BEGIN
          SELECT NVL(P_TAX_AMOUNT, 0) * (RS.TAX_DEDUCTION_RATE / 100) AS TAX_DEDUCTION_LMT
            INTO V_TAX_SUBTRACT_AMOUNT
            FROM HRR_RETIRE_STANDARD RS
          WHERE RS.STD_YYYY       = W_STD_YYYY
            AND RS.SOB_ID         = W_SOB_ID
            AND RS.ORG_ID         = W_ORG_ID
          ;          
        EXCEPTION WHEN OTHERS THEN
          V_TAX_SUBTRACT_AMOUNT := 0;
          DBMS_OUTPUT.PUT_LINE('6.2Tax Deduction Limit Cal Error : ' || SQLERRM);
        END;

        -- 퇴직세액공제금액 한도 체크;
        IF V_TAX_DEDUCTION_LMT_AMOUNT < V_TAX_SUBTRACT_AMOUNT THEN
          V_TAX_SUBTRACT_AMOUNT := V_TAX_DEDUCTION_LMT_AMOUNT;
        END IF;
     END IF;

     V_TAX_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_TAX_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
     IF V_TAX_SUBTRACT_AMOUNT < 0 THEN
       V_TAX_SUBTRACT_AMOUNT := 0;
     END IF;
     RETURN V_TAX_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('6.Tax Deduction Limit Cal Error : ' || SQLERRM);
    RETURN 0;
  END TAX_SUBTRACT_F;

END HRR_RETIRE_ADJUSTMENT_SET_G;
/
