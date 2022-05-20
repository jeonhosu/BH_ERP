CREATE OR REPLACE PACKAGE HRR_RETIRE_RESERVE_G
AS

-- 퇴직충당금 조회.
  PROCEDURE SELECT_RETIRE_RESERVE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 퇴직충당금 산출.
  PROCEDURE SET_RETIRE_RESERVE
            ( W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_RESERVE.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );
            
END HRR_RETIRE_RESERVE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_RESERVE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRR_RETIRE_RESERVE_G
/* DESCRIPTION  : 퇴직보험충당금 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 퇴직충당금 조회.
  PROCEDURE SELECT_RETIRE_RESERVE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT DECODE(GROUPING(RR.RESERVE_YYYYMM), 1, 'Total', RR.RESERVE_YYYYMM) AS RESERVE_YYYYMM
           , DECODE(GROUPING(RR.RESERVE_YYYYMM), 1, TO_CHAR(COUNT(PM.PERSON_ID), 'FM999,999') || ' Person', PM.DISPLAY_NAME) AS DISPLAY_NAME
           , COUNT(PM.PERSON_ID) AS PERSON_COUNT
           , NVL(RR.DEPT_ID, NULL) AS DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(RR.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , NVL(NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE), NULL) AS JOIN_DATE
           , NVL(PM.EXPIRE_DATE, NULL) AS EXPIRE_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
           , NVL(RR.START_DATE, NULL) AS START_DATE
           , NVL(RR.END_DATE, NULL) AS END_DATE
           , NVL(RR.COST_CENTER_ID, NULL) AS COST_CENTER_CODE
           , '' AS COST_CENTER_NAME
           , SUM(RR.PREVIOUS_RETIRE_AMOUNT) AS PREVIOUS_RETIRE_AMOUNT
           , SUM(RR.THIS_RETIRE_AMOUNT) AS THIS_RETIRE_AMOUNT
           , SUM(RR.GAP_RETIRE_AMOUNT) AS GAP_RETIRE_AMOUNT
           , NVL(RR.TOTAL_PAY_AMOUNT, NULL) AS TOTAL_PAY_AMOUNT
           , NVL(RR.TOTAL_BONUS_AMOUNT, NULL) AS TOTAL_BONUS_AMOUNT
           , NVL(RR.YEAR_ALLOWANCE_AMOUNT, NULL) AS YEAR_ALLOWANCE_AMOUNT
           , NVL(RR.DAY_3RD_COUNT, NULL) AS DAY_3RD_COUNT
           , NVL(RR.DAY_AVG_AMOUNT, NULL) AS DAY_AVG_AMOUNT
           , NVL(RR.LONG_YEAR, NULL) AS LONG_YEAR
           , NVL(RR.LONG_DAY, NULL) AS LONG_DAY
           , NVL(RR.RETIRE_AMOUNT, NULL) AS RETIRE_AMOUNT
        FROM HRR_RETIRE_RESERVE RR
           , HRM_PERSON_MASTER PM
       WHERE RR.PERSON_ID               = PM.PERSON_ID
         AND RR.RESERVE_YYYYMM          = W_RESERVE_YYYYMM
         AND RR.CORP_ID                 = W_CORP_ID
         AND RR.SOB_ID                  = W_SOB_ID
         AND RR.ORG_ID                  = W_ORG_ID
         AND RR.PERSON_ID               = NVL(W_PERSON_ID, RR.PERSON_ID)
         AND RR.DEPT_ID                 = NVL(W_DEPT_ID, RR.DEPT_ID)
      GROUP BY ROLLUP((RR.RESERVE_YYYYMM
           , PM.DISPLAY_NAME
           , RR.DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(RR.DEPT_ID)
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)
           , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE)
           , PM.EXPIRE_DATE
           , PM.RETIRE_DATE
           , RR.START_DATE
           , RR.END_DATE
           , RR.COST_CENTER_ID
           , RR.TOTAL_PAY_AMOUNT
           , RR.TOTAL_BONUS_AMOUNT
           , RR.YEAR_ALLOWANCE_AMOUNT
           , RR.DAY_3RD_COUNT
           , RR.DAY_AVG_AMOUNT
           , RR.LONG_YEAR
           , RR.LONG_DAY     
           , RR.RETIRE_AMOUNT))
      ORDER BY RR.DEPT_ID, PM.DISPLAY_NAME
      ;

  END SELECT_RETIRE_RESERVE;

---------------------------------------------------------------------------------------------------
-- 퇴직충당금 산출.
  PROCEDURE SET_RETIRE_RESERVE
            ( W_CORP_ID           IN HRR_RETIRE_RESERVE.CORP_ID%TYPE
            , W_RESERVE_YYYYMM    IN HRR_RETIRE_RESERVE.RESERVE_YYYYMM%TYPE
            , W_DEPT_ID           IN HRR_RETIRE_RESERVE.DEPT_ID%TYPE
            , W_PERSON_ID         IN HRR_RETIRE_RESERVE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRR_RETIRE_RESERVE.SOB_ID%TYPE
            , W_ORG_ID            IN HRR_RETIRE_RESERVE.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_RESERVE.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE  := GET_LOCAL_DATE(W_SOB_ID);
    V_PRE_YEAR_DATE               DATE;             -- 처리 기준 1년 시점 일자(대상 산출 위해).
    V_RETR_START_DATE             DATE;             -- 정산 시작일자;
    V_RETR_END_DATE               DATE;             -- 정산 종료일자;
    V_NEW_END_DATE                DATE;             -- 재정의 종료일자.
    
    V_STD_DATE                    DATE;             -- 처리 기준일자.
    V_STD_CALCULATE_MONTH         NUMBER;           -- 처리 대상 산출 기준.
    V_STD_MONTH                   NUMBER;           -- 기준월수.
    V_STD_PAY_MONTH               NUMBER;           -- 기준 급여월수.
    V_STD_BONUS_MONTH             NUMBER;           -- 기준 상여 월수.
    V_STD_MONTH_DAY               NUMBER;           -- 기준 월일수.
    V_STD_YEAR_DAY                NUMBER;           -- 기준 년일수. 
   
    V_PRE_PAY_YYYYMM              VARCHAR2(7);      -- 퇴충 처리 기준 전월.
    V_STR_PAY_YYYYMM              VARCHAR2(7);      -- 급여 시작년월.
    V_STR_BONUS_YYYYMM            VARCHAR2(7);      -- 상여 시작년월.

    V_TOTAL_AMOUNT                NUMBER;           -- 총합계금액;
    V_TOTAL_PAY_AMOUNT            NUMBER;           -- 급여합계;
    V_TOTAL_BONUS_AMOUNT          NUMBER;           -- 상여금총합계;
    V_YEAR_ALOWANCE_AMOUNT        NUMBER;           -- 년차;
    V_DAY_AVG_AMOUNT              NUMBER;           -- 일평균액;
    
    V_3RD_DAY                     NUMBER;           -- 3개월 평균일수;
    V_LONG_YEAR                   NUMBER;           -- 근속년수;
    V_LONG_MONTH                  NUMBER;           -- 근속월수;
    V_LONG_DAY                    NUMBER;           -- 슨속일수;
  
    V_RETIRE_AMOUNT               NUMBER;           -- 퇴충금;
    
  BEGIN
    O_STATUS := 'F';
--> 처리 기준일자 생성.
    V_STD_DATE := LAST_DAY(TO_DATE(W_RESERVE_YYYYMM, 'YYYY-MM'));
    
--> 해당 년월에 대한 자료 삭제;
    BEGIN
      DELETE FROM HRR_RETIRE_RESERVE RR
      WHERE RR.CORP_ID          = W_CORP_ID
        AND RR.RESERVE_YYYYMM   = W_RESERVE_YYYYMM
        AND RR.DEPT_ID          = NVL(W_DEPT_ID, RR.DEPT_ID)
        AND RR.Person_Id        = NVL(W_PERSON_ID, RR.PERSON_ID)
        AND RR.SOB_ID           = W_SOB_ID
        AND RR.ORG_ID           = W_ORG_ID
      ;  
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Delete_Error => ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;

--> 퇴직정산 처리 기준 .
    BEGIN
      SELECT RS.STD_CALCULATE_MONTH, RS.STD_MONTH, RS.PAY_MONTH, RS.BONUS_MONTH, RS.MONTH_DAY, RS.YEAR_DAY 
        INTO V_STD_CALCULATE_MONTH, V_STD_MONTH, V_STD_PAY_MONTH, V_STD_BONUS_MONTH, V_STD_MONTH_DAY, V_STD_YEAR_DAY
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY          = TO_CHAR(V_STD_DATE, 'YYYY')
         AND RS.SOB_ID            = W_SOB_ID
         AND RS.ORG_ID            = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('3rd Standard Month Error =>' || SUBSTR(SQLERRM, 1, 150));
      V_STD_CALCULATE_MONTH := 12;
      V_STD_PAY_MONTH := 3;
      V_STD_BONUS_MONTH := 12;
      V_STD_MONTH_DAY := 30;
      V_STD_YEAR_DAY := 365;
    END;
  
--> 기준일자 생성;      
    BEGIN
      SELECT ADD_MONTHS(V_STD_DATE, -V_STD_CALCULATE_MONTH) AS PRE_YEAR_DATE
          , TO_CHAR(ADD_MONTHS(V_STD_DATE, -1), 'YYYY-MM') AS PRE_PAY_YYYYMM        
          , TO_CHAR(ADD_MONTHS(V_STD_DATE, -(V_STD_PAY_MONTH - 1)), 'YYYY-MM') AS START_PAY_YYYYMM
          , TO_CHAR(ADD_MONTHS(V_STD_DATE, -(V_STD_BONUS_MONTH - 1)), 'YYYY-MM') AS START_BONUS_YYYYMM
          , V_STD_DATE AS END_DATE
        INTO V_PRE_YEAR_DATE
          , V_PRE_PAY_YYYYMM
          , V_STR_PAY_YYYYMM
          , V_STR_BONUS_YYYYMM
          , V_RETR_END_DATE
        FROM DUAL;

    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Reserve Date Term Error => ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;

---> 3개월 평균일수;
    BEGIN
      V_3RD_DAY := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(V_RETR_END_DATE, W_SOB_ID, W_ORG_ID);      
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '3rd Average Day Error => ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;

---------------------------------------------------------------------------------------------------
--> 퇴직 충당금 계산.
    FOR C1 IN (SELECT PM.PERSON_ID
                    , PM.NAME
                    , PM.CORP_ID
                    , PM.DEPT_ID
                    , PM.PAY_GRADE_ID
                    , PM.SOB_ID
                    , PM.ORG_ID                    
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , PM.EXPIRE_DATE
                    , PM.COST_CENTER_ID
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.CORP_ID          = W_CORP_ID
                  AND PM.SOB_ID           = W_SOB_ID
                  AND PM.ORG_ID           = W_ORG_ID
                  AND PM.DEPT_ID          = NVL(W_DEPT_ID, PM.DEPT_ID)
                  AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
                  AND NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) <= V_PRE_YEAR_DATE
                  AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_STD_DATE)
              )
    LOOP
--> 변수 초기화;
      V_RETR_START_DATE             := NULL;        -- 정산 시작일자;
    
      V_TOTAL_AMOUNT                := 0;           -- 총합계금액;
      V_TOTAL_PAY_AMOUNT            := 0;           -- 급여합계;
      V_TOTAL_BONUS_AMOUNT          := 0;           -- 상여금총합계;
      V_YEAR_ALOWANCE_AMOUNT        := 0;           -- 년차;
      V_DAY_AVG_AMOUNT              := 0;           -- 일평균액;

      V_LONG_YEAR                   := 0;           -- 근속년수;
      V_LONG_MONTH                  := 0;           -- 근속월수;
      V_LONG_DAY                    := 0;           -- 슨속일수;

      V_RETIRE_AMOUNT               := 0;           -- 퇴충금;
                
--> 중도정산 여부 체크 및 정산 시작일자 설정;
      BEGIN
        SELECT MAX(RA.RETIRE_DATE_TO) AS END_RETIRE_DATE_TO
          INTO V_RETR_START_DATE
          FROM HRR_RETIRE_ADJUSTMENT RA
        WHERE RA.ADJUSTMENT_TYPE     = 'M'
          AND RA.PERSON_ID           = C1.PERSON_ID
          AND RA.RETIRE_DATE_TO      < V_STD_DATE
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RETR_START_DATE := NULL;
      END;
      IF V_RETR_START_DATE IS NULL THEN
        IF C1.EXPIRE_DATE IS NOT NULL AND C1.EXPIRE_DATE < V_STD_DATE THEN
          V_RETR_START_DATE := C1.EXPIRE_DATE;
        ELSE
          V_RETR_START_DATE := C1.JOIN_DATE;    
        END IF;        
      END IF;

--> 같은 월-일자 여부 체크를 통해 정산 종료일자에 하루를 더해 설정.
      V_NEW_END_DATE := V_RETR_END_DATE;
      IF TO_CHAR(V_RETR_START_DATE, 'MM-DD') = TO_CHAR(V_RETR_END_DATE, 'MM-DD') THEN
        V_NEW_END_DATE := V_RETR_END_DATE + 1;
      END IF;
      
--> 근속년수, 근속월수, 근속일수 계산  
      BEGIN
        V_LONG_YEAR := HRM_COMMON_DATE_G.YEAR_COUNT_F(V_RETR_START_DATE, V_NEW_END_DATE, 'CEIL');
        V_LONG_MONTH := HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_RETR_START_DATE, V_NEW_END_DATE, 0, 0);
        V_LONG_DAY := HRM_COMMON_DATE_G.PERIOD_DAY_F(V_RETR_START_DATE, V_NEW_END_DATE, 1);        
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Long Calculate Error =>' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      
--> 급여 계산.
      BEGIN
        SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_PAY_AMOUNT
          INTO V_TOTAL_PAY_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              BETWEEN V_STR_PAY_YYYYMM AND W_RESERVE_YYYYMM
           AND MP.WAGE_TYPE               = 'P1'  -- 급여.
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
           AND NOT EXISTS ( SELECT 'X'
                              FROM HRM_ALLOWANCE_V HA
                             WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                               AND HA.ALLOWANCE_TYPE  IN('YEAR', 'BONUS')
                               AND HA.RETIRE_YN       = 'Y'
                               AND HA.ENABLED_FLAG    = 'Y'
                               AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(V_STD_DATE)
                               AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(V_STD_DATE, 'MONTH'))
                          )
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TOTAL_PAY_AMOUNT := 0;
      END;
--> 누적 총금액.
      V_TOTAL_AMOUNT := NVL(V_TOTAL_PAY_AMOUNT, 0);
      
--> 상여 계산.
      -- 1.급여중 상여금 항목 적용.
      BEGIN
        SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_PAY_AMOUNT
          INTO V_TOTAL_BONUS_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              BETWEEN V_STR_BONUS_YYYYMM AND W_RESERVE_YYYYMM
           AND MP.WAGE_TYPE               = 'P1'
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
           AND EXISTS ( SELECT 'X'
                          FROM HRM_ALLOWANCE_V HA
                         WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                           AND HA.ALLOWANCE_TYPE  IN('BONUS')
                           AND HA.RETIRE_YN       = 'Y'
                           AND HA.ENABLED_FLAG    = 'Y'
                           AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(V_STD_DATE)
                           AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(V_STD_DATE, 'MONTH'))
                      )
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TOTAL_BONUS_AMOUNT := 0;
      END;
      -- 2. 상여 항목.
      BEGIN
        SELECT NVL(V_TOTAL_BONUS_AMOUNT, 0) + NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_PAY_AMOUNT
          INTO V_TOTAL_BONUS_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              BETWEEN V_STR_BONUS_YYYYMM AND W_RESERVE_YYYYMM
           AND MP.WAGE_TYPE               IN('P2', 'P3', 'P5')  -- 정기상여, 명절상여, 특별상여.
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_TOTAL_BONUS_AMOUNT := 0;
      END;
--> 누적 총금액.
      IF NVL(V_STD_BONUS_MONTH, 0) = 0 THEN
        V_STD_BONUS_MONTH := 12;
      END IF;
      IF NVL(V_STD_MONTH, 0) = 0 THEN
        V_STD_MONTH := 3;        
      END IF;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + TRUNC(NVL(V_TOTAL_BONUS_AMOUNT, 0) / NVL(V_STD_BONUS_MONTH ,0) * V_STD_MONTH);
      
--> 년차합계
      BEGIN
        SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_PAY_AMOUNT
          INTO V_YEAR_ALOWANCE_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
             , HRM_PERSON_MASTER PM
             , HRP_MONTH_ALLOWANCE MA
             , HRM_ALLOWANCE_V HAV
         WHERE MP.PERSON_ID               = PM.PERSON_ID
           AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
           AND MA.ALLOWANCE_ID            = HAV.ALLOWANCE_ID
           AND MP.PAY_YYYYMM              = SUBSTR(W_RESERVE_YYYYMM, 1, 4) || '-01'
           AND MP.PERSON_ID               = C1.PERSON_ID
           AND MP.SOB_ID                  = C1.SOB_ID
           AND MP.ORG_ID                  = C1.ORG_ID
           AND HAV.RETIRE_YN              = 'Y'
           AND EXISTS ( SELECT 'X'
                          FROM HRM_ALLOWANCE_V HA
                         WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                           AND HA.ALLOWANCE_TYPE  IN('YEAR')
                           AND HA.RETIRE_YN       = 'Y'
                           AND HA.ENABLED_FLAG    = 'Y'
                           AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(V_STD_DATE)
                           AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(V_STD_DATE, 'MONTH'))
                      )
        GROUP BY MP.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_YEAR_ALOWANCE_AMOUNT := 0;
      END;
--> 누적 총금액.      
      IF NVL(V_STD_BONUS_MONTH, 0) = 0 THEN
        V_STD_BONUS_MONTH := 12;
      END IF;
      IF NVL(V_STD_MONTH, 0) = 0 THEN
        V_STD_MONTH := 3;        
      END IF;
      V_TOTAL_AMOUNT := NVL(V_TOTAL_AMOUNT, 0) + TRUNC(NVL(V_YEAR_ALOWANCE_AMOUNT, 0) / V_STD_BONUS_MONTH * V_STD_MONTH);
      
      --> 일평균액 산출;
      BEGIN
        V_DAY_AVG_AMOUNT := TRUNC(V_TOTAL_AMOUNT / V_3RD_DAY);
      EXCEPTION WHEN OTHERS THEN
        V_DAY_AVG_AMOUNT := 0;
      END;  

--> 퇴직금 계산(일평균액 * 30 * 총근무일수 / 365);
      BEGIN
        V_RETIRE_AMOUNT := V_DAY_AVG_AMOUNT * V_STD_MONTH_DAY * V_LONG_DAY / V_STD_YEAR_DAY;
        V_RETIRE_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_RETIRE_AMOUNT, 'RETIRE_RESERVE');
                  
        --> 퇴직충당금 삽입;
        INSERT INTO HRR_RETIRE_RESERVE
        (PERSON_ID, RESERVE_YYYYMM, CORP_ID, DEPT_ID, PAY_GRADE_ID, COST_CENTER_ID
        , JOIN_DATE, EXPIRE_DATE, START_DATE, END_DATE
        , TOTAL_PAY_AMOUNT, TOTAL_BONUS_AMOUNT, YEAR_ALLOWANCE_AMOUNT
        , LONG_YEAR, LONG_MONTH, LONG_DAY
        , DAY_3RD_COUNT, DAY_AVG_AMOUNT, RETIRE_AMOUNT
        , PREVIOUS_RETIRE_AMOUNT, THIS_RETIRE_AMOUNT, GAP_RETIRE_AMOUNT
        , SOB_ID, ORG_ID
        , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
        ) VALUES
        (C1.PERSON_ID, W_RESERVE_YYYYMM, C1.CORP_ID, C1.DEPT_ID, C1.PAY_GRADE_ID, C1.COST_CENTER_ID
        , C1.JOIN_DATE, C1.EXPIRE_DATE, V_RETR_START_DATE, V_RETR_END_DATE
        , V_TOTAL_PAY_AMOUNT, V_TOTAL_BONUS_AMOUNT, V_YEAR_ALOWANCE_AMOUNT
        , V_LONG_YEAR, V_LONG_MONTH, V_LONG_DAY
        , V_3RD_DAY, V_DAY_AVG_AMOUNT, V_RETIRE_AMOUNT
        , 0, V_RETIRE_AMOUNT, 0
        , C1.SOB_ID, C1.ORG_ID
        , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
        );

--> 전월 퇴직충당금 UPDATE;
        UPDATE HRR_RETIRE_RESERVE HRR
          SET ( HRR.PREVIOUS_RETIRE_AMOUNT
              , HRR.GAP_RETIRE_AMOUNT)
              = ( SELECT NVL(HRR1.THIS_RETIRE_AMOUNT, 0)
                       , NVL(HRR.THIS_RETIRE_AMOUNT, 0) - NVL(HRR1.THIS_RETIRE_AMOUNT, 0) AS GAP_RETIRE_AMOUNT
                    FROM HRR_RETIRE_RESERVE HRR1
                   WHERE HRR1.RESERVE_YYYYMM  = V_PRE_PAY_YYYYMM
                     AND HRR1.PERSON_ID       = HRR.PERSON_ID
                     AND HRR1.CORP_ID         = HRR.CORP_ID
                     AND HRR1.SOB_ID          = HRR.SOB_ID
                     AND HRR1.ORG_ID          = HRR.ORG_ID
                )
        WHERE HRR.RESERVE_YYYYMM  = W_RESERVE_YYYYMM
          AND HRR.PERSON_ID       = C1.PERSON_ID
          AND HRR.CORP_ID         = C1.CORP_ID
          AND HRR.SOB_ID          = C1.SOB_ID
          AND HRR.ORG_ID          = C1.ORG_ID
        ;
      END;               

    END LOOP C1;             
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);    
  END SET_RETIRE_RESERVE;
  
END HRR_RETIRE_RESERVE_G;
/
