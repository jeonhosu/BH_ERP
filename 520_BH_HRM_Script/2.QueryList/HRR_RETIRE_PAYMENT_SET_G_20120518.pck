CREATE OR REPLACE PACKAGE HRR_RETIRE_PAYMENT_SET_G
AS
--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , P_RETIRE_DATE_FR    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , P_RETIRE_DATE_TO    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
--  10. 급여 계산 MAIN
  PROCEDURE PAY_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );
            
--  11. 급여 일할 계산 MAIN
  PROCEDURE PAY_MAIN_DAY
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
--  50. 상여 계산.
  PROCEDURE BONUS_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
--  51. 특별상여 계산.
  PROCEDURE SPECIAL_BONUS_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
--  91. 급상여 내역 INSERT.
  PROCEDURE INSERT_PAY_DETAIL
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUST_PAY_DETAIL.ADJUSTMENT_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUST_PAY_DETAIL.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUST_PAY_DETAIL.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT  IN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_AMOUNT%TYPE
            , P_PERSON_ID         IN HRR_RETIRE_ADJUST_PAY_DETAIL.PERSON_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUST_PAY_DETAIL.CORP_ID%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUST_PAY_DETAIL.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUST_PAY_DETAIL.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUST_PAY_DETAIL.CREATED_BY%TYPE
            );

END HRR_RETIRE_PAYMENT_SET_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_PAYMENT_SET_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRR_RETIRE_PAYMENT_SET_G
/* DESCRIPTION  : 퇴직금 급/상여 처리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION      Version
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE         1.0
/******************************************************************************/
  C_MONTH_PAYMENT                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P1';
  C_MONTH_BONUS                   CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P2';
  C_BONUS_P3                      CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P3';
  C_SPECIAL_BONUS                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P5';
  
--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , P_RETIRE_DATE_FR    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , P_RETIRE_DATE_TO    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_MESSAGE                     VARCHAR2(300) := NULL;
    V_RECORD_COUNT                NUMBER := 0;
    
    V_JOB_CATE_CODE               VARCHAR2(10);
    V_STD_MONTH                   NUMBER;           -- 기준 (급여/상여)월수 - 급상여 타입에 따라 설정.
    V_START_DATE                  DATE;             -- 시작일자.
    V_PAY_DATE_FR                 DATE;             -- 급상여 적용 시작일자.
    V_PAY_DATE_TO                 DATE;             -- 급상여 적용 종료일자.
    
    V_MONTH_COUNT                 NUMBER;           -- 급여 계산 월수.
    V_R1                          NUMBER;
    V_PAY_YYYYMM                  VARCHAR2(7);      -- 급여처리 년월.
    V_STD_YYYYMM                  VARCHAR2(7);      -- 급상여 처리 시작 기준년월.
    V_LAST_YYYYMM                 VARCHAR2(7);      -- 최종 급상여 년월.
  BEGIN
    DBMS_OUTPUT.PUT_LINE('-----' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10075', '&&START_TIME:=' || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS')));

---------------------------------------------------------------------------
-- 기존 자료 삭제
---------------------------------------------------------------------------
    BEGIN
      -- 급/상여 지급내역 삭제.
      DELETE FROM HRR_RETIRE_ADJUST_PAY_DETAIL RAP
      WHERE RAP.ADJUSTMENT_ID    = P_ADJUSTMENT_ID
        AND RAP.WAGE_TYPE        = P_WAGE_TYPE
      ;

      -- 급/상여 내역 삭제.
      DELETE FROM HRR_RETIRE_ADJUSTMENT_PAYMENT RAP
      WHERE RAP.ADJUSTMENT_ID    = P_ADJUSTMENT_ID
        AND RAP.WAGE_TYPE        = P_WAGE_TYPE
      ;
      V_RECORD_COUNT := 0;
      V_RECORD_COUNT := SQL%ROWCOUNT;
      DBMS_OUTPUT.PUT_LINE('-----' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10077', '&&COUNT:=' || TO_CHAR(V_RECORD_COUNT, 'FM999,999,990')));
    END;
    COMMIT;

--> 퇴직정산 처리 기준 .
    BEGIN
      SELECT CASE
               WHEN P_WAGE_TYPE = C_MONTH_PAYMENT THEN RS.PAY_MONTH
               ELSE RS.BONUS_MONTH
             END AS STD_MONTH
        INTO V_STD_MONTH
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY          = TO_CHAR(P_RETIRE_DATE_TO, 'YYYY')
         AND RS.SOB_ID            = P_SOB_ID
         AND RS.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Retire Standard Error =>' || SQLERRM);
      IF P_WAGE_TYPE = C_MONTH_PAYMENT THEN
        V_STD_MONTH := 3;
      ELSE
        V_STD_MONTH := 12;
      END IF;
    END;
--> 기준일자 생성;
    BEGIN
      SELECT ADD_MONTHS(P_RETIRE_DATE_TO, -V_STD_MONTH) + 1 AS PRE_3RD_MONTH
        INTO V_START_DATE
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := ADD_MONTHS(P_RETIRE_DATE_TO, -3) + 1;
    END;
---------------------------------------------------------------------------
-- 0. 급상여 처리 시작 년월 적용.
---------------------------------------------------------------------------
    V_R1 := 0;
    IF P_WAGE_TYPE = C_MONTH_PAYMENT THEN
    -- 급여.
      V_STD_YYYYMM := TO_CHAR(P_RETIRE_DATE_TO, 'YYYY-MM');
      --> 퇴직일자 마지막 일자일 경우 3개월 이전 마지막 일자부터 계산. 그외에는 3개월 이전부터 계산.
      IF LAST_DAY(P_RETIRE_DATE_TO) = P_RETIRE_DATE_TO THEN
        V_R1 := 0;
      ELSE
        V_R1 := 1;
      END IF;
    ELSIF P_WAGE_TYPE IN(C_MONTH_BONUS, C_BONUS_P3, C_SPECIAL_BONUS) THEN
    -- 상여금.
      IF LAST_DAY(P_RETIRE_DATE_TO) = P_RETIRE_DATE_TO THEN
      -- 퇴사일자가 해당월 마지막 일자일 경우 퇴사일자부터 적용.
        V_STD_YYYYMM := TO_CHAR(P_RETIRE_DATE_TO, 'YYYY-MM');
      ELSE
      -- 퇴사일자가 해당월 마지막 일자가 아닐 경우 퇴사 전달부터 적용.
        V_STD_YYYYMM := TO_CHAR(ADD_MONTHS(P_RETIRE_DATE_TO, -1), 'YYYY-MM');
      END IF;
      /*-- 최종 상여 년월 : 중간 정산 처리시 상여 데이터를 최종분으로 처리하는 문제 발생.
      BEGIN
        SELECT MAX(MP.PAY_YYYYMM) AS PAY_YYYYMM
          INTO V_LAST_YYYYMM
          FROM HRP_MONTH_PAYMENT MP
        WHERE MP.PERSON_ID        = P_PERSON_ID
          AND MP.PAY_YYYYMM       >= V_STD_YYYYMM
          AND MP.WAGE_TYPE        = C_MONTH_BONUS
          AND MP.SOB_ID           = P_SOB_ID
          AND MP.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_LAST_YYYYMM := V_STD_YYYYMM;
      END;
      IF V_LAST_YYYYMM IS NULL THEN
        V_LAST_YYYYMM := V_STD_YYYYMM;
      END IF;
      V_STD_YYYYMM := V_LAST_YYYYMM;*/
    END IF;
-----> 퇴직전 급상여 년월 횟수 계산-      
    BEGIN
      SELECT CEIL(MONTHS_BETWEEN(P_RETIRE_DATE_TO, V_START_DATE)) + NVL(V_R1, 0) AS MONTH_COUNT
        INTO V_MONTH_COUNT
        FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_MONTH_COUNT := 3;
    END;
----> 인사정보 조회.
    BEGIN
      SELECT JCC.JOB_CATEGORY_CODE
        INTO V_JOB_CATE_CODE
        FROM HRM_PERSON_MASTER PM
          , HRM_JOB_CATEGORY_CODE_V JCC
      WHERE PM.JOB_CATEGORY_ID  = JCC.JOB_CATEGORY_ID
        AND PM.PERSON_ID        = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_JOB_CATE_CODE := '10';
    END;
---------------------------------------------------------------------------
-- 1. 급상여 처리 대상 산출.
---------------------------------------------------------------------------
    V_R1 := 0;
    IF P_WAGE_TYPE = C_MONTH_PAYMENT THEN
    -- 급여.
      FOR C1 IN 1..V_MONTH_COUNT
      LOOP
        V_PAY_YYYYMM := TO_CHAR(ADD_MONTHS(TO_DATE(V_STD_YYYYMM, 'YYYY-MM'), -V_R1), 'YYYY-MM');
        V_PAY_DATE_FR := TRUNC(TO_DATE(V_PAY_YYYYMM, 'YYYY-MM'), 'MONTH');
        IF V_PAY_DATE_FR <= V_START_DATE THEN
          V_PAY_DATE_FR := V_START_DATE;
        END IF;
        V_PAY_DATE_TO := LAST_DAY(TO_DATE(V_PAY_YYYYMM, 'YYYY-MM'));
        IF P_RETIRE_DATE_TO < V_PAY_DATE_TO THEN
          V_PAY_DATE_TO := P_RETIRE_DATE_TO;
        END IF;
        IF V_STD_MONTH < (V_R1 + 1)  THEN
          PAY_MAIN_DAY( P_ADJUSTMENT_ID => P_ADJUSTMENT_ID
                      , P_CORP_ID => P_CORP_ID
                      , P_PAY_YYYYMM => V_PAY_YYYYMM
                      , P_WAGE_TYPE => P_WAGE_TYPE
                      , P_PERSON_ID => P_PERSON_ID
                      , P_JOB_CATE_CODE => V_JOB_CATE_CODE
                      , P_PAY_DATE_FR => V_PAY_DATE_FR
                      , P_PAY_DATE_TO => V_PAY_DATE_TO
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      , O_MESSAGE => V_MESSAGE
                      );
        ELSE
          PAY_MAIN( P_ADJUSTMENT_ID => P_ADJUSTMENT_ID
                  , P_CORP_ID => P_CORP_ID
                  , P_PAY_YYYYMM => V_PAY_YYYYMM
                  , P_WAGE_TYPE => P_WAGE_TYPE
                  , P_PERSON_ID => P_PERSON_ID
                  , P_JOB_CATE_CODE => V_JOB_CATE_CODE
                  , P_PAY_DATE_FR => V_PAY_DATE_FR
                  , P_PAY_DATE_TO => V_PAY_DATE_TO
                  , P_SOB_ID => P_SOB_ID
                  , P_ORG_ID => P_ORG_ID
                  , P_USER_ID => P_USER_ID
                  , O_MESSAGE => V_MESSAGE
                  );
        END IF;
        V_R1 := V_R1 + 1;
      END LOOP C1;
      
    ELSIF P_WAGE_TYPE = C_MONTH_BONUS THEN
    -- 상여금.
      FOR C1 IN 1..V_MONTH_COUNT
      LOOP
        V_PAY_YYYYMM := TO_CHAR(ADD_MONTHS(TO_DATE(V_STD_YYYYMM, 'YYYY-MM'), -V_R1), 'YYYY-MM');
        V_PAY_DATE_FR := TRUNC(TO_DATE(V_PAY_YYYYMM, 'YYYY-MM'), 'MONTH');
        IF V_PAY_DATE_FR <= V_START_DATE THEN
          V_PAY_DATE_FR := V_START_DATE;
        END IF;
        V_PAY_DATE_TO := LAST_DAY(TO_DATE(V_PAY_YYYYMM, 'YYYY-MM'));
        IF P_RETIRE_DATE_TO < V_PAY_DATE_TO THEN
          V_PAY_DATE_TO := P_RETIRE_DATE_TO;
        END IF;
        BONUS_MAIN( P_ADJUSTMENT_ID => P_ADJUSTMENT_ID
                  , P_CORP_ID => P_CORP_ID
                  , P_PAY_YYYYMM => V_PAY_YYYYMM
                  , P_WAGE_TYPE => P_WAGE_TYPE
                  , P_PERSON_ID => P_PERSON_ID
                  , P_JOB_CATE_CODE => V_JOB_CATE_CODE
                  , P_PAY_DATE_FR => V_PAY_DATE_FR
                  , P_PAY_DATE_TO => V_PAY_DATE_TO
                  , P_SOB_ID => P_SOB_ID
                  , P_ORG_ID => P_ORG_ID
                  , P_USER_ID => P_USER_ID
                  , O_MESSAGE => V_MESSAGE
                  );
        V_R1 := V_R1 + 1;
      END LOOP C1;
    ELSIF P_WAGE_TYPE IN(/*C_SPECIAL_BONUS, */C_BONUS_P3) THEN
    -- 명절상여 포함, 특별상여는 제외 : 조선미s 요청.
      FOR C1 IN 1..V_MONTH_COUNT
      LOOP
        V_PAY_YYYYMM := TO_CHAR(ADD_MONTHS(TO_DATE(V_STD_YYYYMM, 'YYYY-MM'), -V_R1), 'YYYY-MM');
        V_PAY_DATE_FR := TRUNC(TO_DATE(V_PAY_YYYYMM, 'YYYY-MM'), 'MONTH');
        IF V_PAY_DATE_FR <= V_START_DATE THEN
          V_PAY_DATE_FR := V_START_DATE;
        END IF;
        V_PAY_DATE_TO := LAST_DAY(TO_DATE(V_PAY_YYYYMM, 'YYYY-MM'));
        IF P_RETIRE_DATE_TO < V_PAY_DATE_TO THEN
          V_PAY_DATE_TO := P_RETIRE_DATE_TO;
        END IF;
        SPECIAL_BONUS_MAIN
                  ( P_ADJUSTMENT_ID => P_ADJUSTMENT_ID
                  , P_CORP_ID => P_CORP_ID
                  , P_PAY_YYYYMM => V_PAY_YYYYMM
                  , P_WAGE_TYPE => P_WAGE_TYPE
                  , P_PERSON_ID => P_PERSON_ID
                  , P_JOB_CATE_CODE => V_JOB_CATE_CODE
                  , P_PAY_DATE_FR => V_PAY_DATE_FR
                  , P_PAY_DATE_TO => V_PAY_DATE_TO
                  , P_SOB_ID => P_SOB_ID
                  , P_ORG_ID => P_ORG_ID
                  , P_USER_ID => P_USER_ID
                  , O_MESSAGE => V_MESSAGE
                  );
        V_R1 := V_R1 + 1;
      END LOOP C1;
    END IF;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('-----' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10076', '&&END_TIME:=' || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS')));
    IF V_MESSAGE IS NULL THEN
      V_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    END IF;
    O_MESSAGE := V_MESSAGE;

  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END PAYMENT_MAIN;

---------------------------------------------------------------------------------------------------
--  10. 급여 계산 MAIN
  PROCEDURE PAY_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    -- DETAIL INSERT
    BEGIN
     INSERT INTO HRR_RETIRE_ADJUST_PAY_DETAIL
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID, ALLOWANCE_AMOUNT
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      )
      SELECT P_ADJUSTMENT_ID
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , MA.ALLOWANCE_ID
           , MA.ALLOWANCE_AMOUNT
           , MA.PERSON_ID
           , MA.CORP_ID
           , MA.SOB_ID
           , MA.ORG_ID
           , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
      WHERE MP.MONTH_PAYMENT_ID         = MA.MONTH_PAYMENT_ID
        AND MA.ALLOWANCE_ID             = HA.ALLOWANCE_ID
        AND MP.PAY_YYYYMM               = P_PAY_YYYYMM
        AND MP.WAGE_TYPE                = P_WAGE_TYPE
        AND MP.PERSON_ID                = P_PERSON_ID
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND NOT EXISTS 
            ( SELECT 'X'
                FROM HRM_ALLOWANCE_V HA1
              WHERE HA1.ALLOWANCE_ID    = HA.ALLOWANCE_ID
                AND HA1.ALLOWANCE_TYPE  IN ('BONUS', 'YEAR')
            )
        AND HA.RETIRE_YN                = 'Y'
        AND HA.ENABLED_FLAG             = 'Y'
        AND HA.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
        AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM')))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Pay Line Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    BEGIN
      -- 관리직 연봉상여금은 급여액에 포함 : 조선미s 요청.
      INSERT INTO HRR_RETIRE_ADJUST_PAY_DETAIL
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID, ALLOWANCE_AMOUNT
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      )
      SELECT P_ADJUSTMENT_ID
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , MA.ALLOWANCE_ID
           , MA.ALLOWANCE_AMOUNT
           , MA.PERSON_ID
           , MA.CORP_ID
           , MA.SOB_ID
           , MA.ORG_ID
           , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
      WHERE MP.MONTH_PAYMENT_ID         = MA.MONTH_PAYMENT_ID
        AND MA.ALLOWANCE_ID             = HA.ALLOWANCE_ID
        AND MP.PAY_YYYYMM               = P_PAY_YYYYMM
        AND MP.WAGE_TYPE                = P_WAGE_TYPE
        AND MP.PERSON_ID                = P_PERSON_ID
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND MP.PAY_TYPE                 IN('1', '3')
        AND EXISTS 
            ( SELECT 'X'
                FROM HRM_ALLOWANCE_V HA1
              WHERE HA1.ALLOWANCE_ID    = HA.ALLOWANCE_ID
                AND HA1.ALLOWANCE_TYPE  IN ('BONUS')
            )
        AND HA.RETIRE_YN                = 'Y'
        AND HA.ENABLED_FLAG             = 'Y'
        AND HA.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
        AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM')))
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Pay Line Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
DBMS_OUTPUT.PUT_LINE('ADJUSTMENT_ID : ' || P_ADJUSTMENT_ID || ', PAY_YYYYMM : ' || P_PAY_YYYYMM || ', WAGE_TYPE : ' || P_WAGE_TYPE || ', COUNT : ' || SQL%ROWCOUNT);    
    -- SUMMARY INSERT : DETAIL SUMMARY
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUSTMENT_PAYMENT
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, TOTAL_AMOUNT
      , START_DATE, END_DATE
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY      
      )
      SELECT APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , SUM(APD.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , P_PAY_DATE_FR
           , P_PAY_DATE_TO
           , APD.PERSON_ID
           , APD.CORP_ID
           , P_SOB_ID
           , P_ORG_ID
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
      WHERE APD.ADJUSTMENT_ID     = P_ADJUSTMENT_ID
        AND APD.PAY_YYYYMM        = P_PAY_YYYYMM
        AND APD.WAGE_TYPE         = P_WAGE_TYPE
        AND APD.PERSON_ID         = P_PERSON_ID
        AND APD.CORP_ID           = P_CORP_ID
        AND APD.SOB_ID            = P_SOB_ID
        AND APD.ORG_ID            = P_ORG_ID
      GROUP BY APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , APD.PERSON_ID
           , APD.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Pay Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
  END PAY_MAIN;
  
/*--  11. 급여 계산 MAIN
  PROCEDURE PAY_MAIN_DAY
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE;
    V_ALLOWANCE_AMOUNT            NUMBER;             -- 지급액.
    
    V_TOTAL_DAY                   NUMBER := 0;        -- 총 월일수.
    V_PAY_DAY                     NUMBER := 0;        -- 급여 일수(근무일수-무급일수-무급휴일).
    
    V_STD_HOLY_0_COUNT            NUMBER := 0;        -- 기준 무급휴일일수.
    V_HOLY_0_COUNT                NUMBER := 0;        -- 근무 무급휴일일수.    
    V_HOLY_3_COUNT                NUMBER := 0;        -- 야간횟수.
    V_TEMP_COUNT                  NUMBER := 0;        -- 임시 일수.
  BEGIN
    V_SYSDATE   := GET_LOCAL_DATE(P_SOB_ID);
    
    -- 총 월일수.
    V_TOTAL_DAY := LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM')) - TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') + 1;
    V_PAY_DAY := P_PAY_DATE_TO - P_PAY_DATE_FR + 1;
    
    -- 기준 무급휴일일수.
    BEGIN
      SELECT COUNT(WC.PERSON_ID) AS STD_HOLY_0_COUNT
        INTO V_STD_HOLY_0_COUNT
        FROM HRD_WORK_CALENDAR WC
      WHERE WC.WORK_DATE        BETWEEN TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
        AND WC.PERSON_ID        = P_PERSON_ID
        AND WC.SOB_ID           = P_SOB_ID
        AND WC.ORG_ID           = P_ORG_ID
        AND WC.HOLY_TYPE        = '0'                     -- 무휴.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_STD_HOLY_0_COUNT := 0;
    END;
    
    -- 근무 무급휴일일수.
    BEGIN
      V_HOLY_0_COUNT := HRD_WORK_CALENDAR_G.HOLY_0_COUNT_F(P_PERSON_ID, P_PAY_DATE_FR, P_PAY_DATE_TO, P_SOB_ID, P_ORG_ID);
      \*SELECT COUNT(WC.PERSON_ID) AS STD_HOLY_0_COUNT
        INTO V_HOLY_0_COUNT
        FROM HRD_WORK_CALENDAR WC
      WHERE WC.WORK_DATE        BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND WC.PERSON_ID        = P_PERSON_ID
        AND WC.SOB_ID           = P_SOB_ID
        AND WC.ORG_ID           = P_ORG_ID
        AND WC.HOLY_TYPE        = '0'                     -- 무휴.
      ;      *\
    EXCEPTION WHEN OTHERS THEN
      V_HOLY_0_COUNT := 0;
    END;
    -- 급여일수 재계산 : 무급휴일 제외.
    V_PAY_DAY := NVL(V_PAY_DAY, 0) - NVL(V_HOLY_0_COUNT, 0);
    
    -- 근무 무급일수 .
    V_TEMP_COUNT := 0;
    BEGIN
      SELECT COUNT(DL.PERSON_ID) AS HOLY_0_COUNT
        INTO V_TEMP_COUNT
        FROM HRD_DAY_LEAVE_V DL
          , HRM_DUTY_CODE_V DC
      WHERE DL.DUTY_ID          = DC.DUTY_ID
        AND DL.WORK_DATE        BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND DL.PERSON_ID        = P_PERSON_ID
        AND DL.SOB_ID           = P_SOB_ID
        AND DL.ORG_ID           = P_ORG_ID
        AND DC.NON_PAY_DAY_FLAG = 'Y'                     -- 무급.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TEMP_COUNT := 0;
    END;
    -- 급여일수 재계산 : 무급일수 제외.
    V_PAY_DAY := NVL(V_PAY_DAY, 0) - NVL(V_TEMP_COUNT, 0);
    
    -- 주휴공제수 적용.
    V_TEMP_COUNT := 0;
    BEGIN
      SELECT COUNT(DISTINCT WD.WORK_DATE) AS WEEK_DED_COUNT
        INTO V_TEMP_COUNT
        FROM HRD_WEEKLY_DED WD
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.DED_DATE           BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND WD.WORK_CORP_ID       = P_CORP_ID
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TEMP_COUNT := 0;
    END;
    -- 급여일수 재계산 : 무급일수 제외.
    V_PAY_DAY := NVL(V_PAY_DAY, 0) - NVL(V_TEMP_COUNT, 0);
    IF NVL(V_PAY_DAY, 0) < 0 THEN
      V_PAY_DAY := 0;
    END IF;
    
    -- 1 기본급 계산.
    ---- 관리직 : 기본급 / (총일수 - 기준 무급휴일수) * 급여일수(근무무급휴일수 제외됨).
    ---- 생산직 : 기본급 * 급여일수.
    FOR C1 IN ( SELECT PM.PERSON_ID
                     , PM.PERSON_NUM
                     , PM.NAME
                     , PM.CORP_ID
                     , PMH.PAY_TYPE
                     , PMH.PAY_PROVIDE_YN
                     , PML.ALLOWANCE_ID
                     , HA.ALLOWANCE_CODE
                     , PML.ALLOWANCE_AMOUNT
                     , HA.ALLOWANCE_TYPE
                     , HA.DAY_YN
                     , HA.GENERAL_TIME_YN
                  FROM HRM_PERSON_MASTER PM
                    , HRP_PAY_MASTER_HEADER PMH
                    , HRP_PAY_MASTER_LINE PML
                    , HRM_ALLOWANCE_V HA
                WHERE PM.PERSON_ID        = PMH.PERSON_ID
                  AND PMH.PAY_HEADER_ID   = PML.PAY_HEADER_ID
                  AND PML.ALLOWANCE_ID    = HA.ALLOWANCE_ID
                  AND PM.PERSON_ID        = P_PERSON_ID
                  AND PML.ALLOWANCE_TYPE  = 'A'
                  AND PML.ENABLED_FLAG    = 'Y'
                  AND PMH.START_YYYYMM    <= P_PAY_YYYYMM
                  AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                  AND HA.ALLOWANCE_CODE   = 'A01'
               )
    LOOP
      IF C1.PAY_TYPE IN ('1', '3') THEN
      -- 월급제, 연봉제.
        V_ALLOWANCE_AMOUNT := NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0) * (NVL(V_PAY_DAY, 0) + NVL(V_HOLY_0_COUNT, 0));
      ELSIF C1.PAY_TYPE IN ('2') THEN
      -- 일급제.
        V_ALLOWANCE_AMOUNT := NVL(C1.ALLOWANCE_AMOUNT, 0) * NVL(V_PAY_DAY, 0);
      ELSE
      -- 시급제.
        V_ALLOWANCE_AMOUNT := NVL(C1.ALLOWANCE_AMOUNT, 0) * 8 * NVL(V_PAY_DAY, 0);
      END IF;
      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
        INSERT_PAY_DETAIL
          ( P_ADJUSTMENT_ID     => P_ADJUSTMENT_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_ALLOWANCE_AMOUNT  => NVL(V_ALLOWANCE_AMOUNT, 0)
          , P_PERSON_ID         => C1.PERSON_ID
          , P_CORP_ID           => C1.CORP_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID          
          );
      END IF;
    END LOOP C1;
    
    -- 2 기본급 이외 지급 항목 처리.
    ---- 2.1 해당월 지급내역을 일괄 적용.
    FOR C1 IN ( SELECT MA.PERSON_ID
                     , MA.CORP_ID
                     , MA.ALLOWANCE_ID
                     , MA.ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_MONTH_ALLOWANCE MA
                 WHERE MP.MONTH_PAYMENT_ID    = MA.MONTH_PAYMENT_ID
                   AND MP.PAY_YYYYMM          = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE           = P_WAGE_TYPE
                   AND MP.PERSON_ID           = P_PERSON_ID
                   AND MP.SOB_ID              = P_SOB_ID
                   AND MP.ORG_ID              = P_ORG_ID
                   AND NOT EXISTS 
                         ( SELECT 'X'
                            FROM HRM_ALLOWANCE_V HA 
                           WHERE HA.ALLOWANCE_ID     = MA.ALLOWANCE_ID
                             AND HA.ALLOWANCE_TYPE    IN('BASIC', 'BONUS', 'YEAR')
                         )
               )
    LOOP 
      -- 지급 항목 --
      IF NVL(C1.ALLOWANCE_AMOUNT, 0) <> 0 THEN
        INSERT_PAY_DETAIL
          ( P_ADJUSTMENT_ID     => P_ADJUSTMENT_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_ALLOWANCE_AMOUNT  => NVL(C1.ALLOWANCE_AMOUNT, 0)
          , P_PERSON_ID         => C1.PERSON_ID
          , P_CORP_ID           => C1.CORP_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID          
          );
      END IF;
    END LOOP C1;
    
    ---- 2.2 기본급이외 항목 일할계산.
    FOR C1 IN ( SELECT APD.PERSON_ID
                     , APD.CORP_ID
                     , SX1.PAY_TYPE
                     , SX1.PAY_GRADE
                     , APD.ALLOWANCE_ID
                     , APD.ALLOWANCE_AMOUNT
                  FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
                    , HRM_ALLOWANCE_V HA                                             
                    , ( -- 급여마스터.
                        SELECT PMH.PERSON_ID
                             , PMH.PAY_TYPE
                             , PG.PAY_GRADE
                             , PMH.SOB_ID
                             , PMH.ORG_ID
                          FROM HRP_PAY_MASTER_HEADER PMH 
                            , HRM_PAY_GRADE_V PG
                        WHERE PMH.PAY_GRADE_ID  = PG.PAY_GRADE_ID
                          AND PMH.PERSON_ID     = P_PERSON_ID
                          AND PMH.CORP_ID       = P_CORP_ID
                          AND PMH.SOB_ID        = P_SOB_ID
                          AND PMH.ORG_ID        = P_ORG_ID
                          AND PMH.START_YYYYMM  <= P_PAY_YYYYMM
                          AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM) 
                      ) SX1
                 WHERE APD.ALLOWANCE_ID     = HA.ALLOWANCE_ID
                   AND APD.PERSON_ID        = SX1.PERSON_ID
                   AND APD.PAY_YYYYMM       = P_PAY_YYYYMM
                   AND APD.WAGE_TYPE        = P_WAGE_TYPE
                   AND APD.PERSON_ID        = P_PERSON_ID
                   AND APD.CORP_ID          = P_CORP_ID
                   AND APD.SOB_ID           = P_SOB_ID
                   AND APD.ORG_ID           = P_ORG_ID
                   AND HA.DAY_YN            = 'Y'
                   AND HA.ENABLED_FLAG      = 'Y'
                   AND HA.EFFECTIVE_DATE_FR <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                   AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                   AND NOT EXISTS 
                         ( SELECT 'X'
                             FROM HRM_ALLOWANCE_V HA 
                           WHERE HA.ALLOWANCE_ID      = APD.ALLOWANCE_ID
                             AND HA.ALLOWANCE_TYPE    = 'BASIC'
                         )
               )
    LOOP 
      V_ALLOWANCE_AMOUNT := 0;
      IF C1.PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF C1.PAY_TYPE = '3' THEN
      -- 연봉제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0);
      ELSIF C1.PAY_TYPE = '1' THEN
      -- 월급제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0);
      ELSIF C1.PAY_TYPE = '2' THEN
      -- 일급제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0);
      ELSIF C1.PAY_TYPE = '4' THEN
      -- 시급제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0); 
      END IF;
      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 지급 항목 --
        V_ALLOWANCE_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, V_ALLOWANCE_AMOUNT, 'PAYMENT');
        UPDATE HRR_RETIRE_ADJUST_PAY_DETAIL APD
          SET APD.ALLOWANCE_AMOUNT  = V_ALLOWANCE_AMOUNT
        WHERE APD.PAY_YYYYMM        = P_PAY_YYYYMM
          AND APD.WAGE_TYPE         = P_WAGE_TYPE
          AND APD.PERSON_ID         = C1.PERSON_ID
          AND APD.ALLOWANCE_ID      = C1.ALLOWANCE_ID
          AND APD.SOB_ID            = P_SOB_ID
          AND APD.ORG_ID            = P_ORG_ID
        ;
      END IF;
    END LOOP C1;
    
    ---- 2.2 근태 수당 처리.
    FOR C1 IN ( SELECT MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.GENERAL_HOURLY_AMOUNT                     
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                 WHERE MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.PERSON_ID               = P_PERSON_ID
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID                   
               )
    LOOP
      -- 연장 수당 계산.
      FOR R1 IN ( SELECT SX1.PERSON_ID
                      , CASE 
                          WHEN C1.PAY_TYPE IN ('1', '3') THEN OT.ALLOWANCE_10_ID
                          ELSE OT.ALLOWANCE_20_ID
                        END ALLOWANCE_ID
                      , CASE 
                          WHEN C1.PAY_TYPE IN ('1', '3') THEN OT.ALLOWANCE_10_CODE
                          ELSE OT.ALLOWANCE_20_CODE
                        END ALLOWANCE_CODE
                      , CASE
                          WHEN C1.PAY_TYPE IN('1', '3') THEN NVL(SUM(NVL(SX1.OT_TIME, 0) * NVL(OT.ALLOWANCE_RATE_10, 0)), 0)
                          ELSE NVL(SUM(NVL(SX1.OT_TIME, 0) * NVL(OT.ALLOWANCE_RATE_20, 0)), 0) 
                        END AS OT_TIME                         
                    FROM HRM_OT_TYPE_ALLOWANCE_V OT
                      , (SELECT  DL.PERSON_ID
                               , DL.SOB_ID
                               , DL.ORG_ID
                               , CASE 
                                   WHEN DL.HOLY_TYPE = '0' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '14' THEN '20'     -- 무휴 : 연장.
                                   WHEN DL.HOLY_TYPE = '0' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '15' THEN '20'     -- 무휴 : 휴일근로.
                                   WHEN DL.HOLY_TYPE = '0' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '17' THEN '21'     -- 무휴 : 야간할증.
                                   WHEN DL.HOLY_TYPE = '1' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '14' THEN '18'     -- 유휴 : 연장.
                                   WHEN DL.HOLY_TYPE = '1' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '16' THEN '15'     -- 유휴 야간 : 휴일근로.
                                   WHEN DL.HOLY_TYPE = '1' AND DLO.OT_TYPE = '17' THEN '19'     -- 유휴 : 야간할증.
                                   ELSE DLO.OT_TYPE
                                 END OT_TYPE
                               , SUM(CASE
                                       WHEN JC.JOB_CATEGORY_CODE IN ('10') AND DLO.OT_TYPE = '15' THEN 0
                                       ELSE DLO.OT_TIME
                                     END) AS OT_TIME
                            FROM HRD_DAY_LEAVE_V DL
                              , HRM_JOB_CATEGORY_CODE_V JC
                              , HRD_DAY_LEAVE_OT DLO
                           WHERE DL.JOB_CATEGORY_ID         = JC.JOB_CATEGORY_ID
                             AND DL.DAY_LEAVE_ID            = DLO.DAY_LEAVE_ID
                             AND DL.SOB_ID                  = DLO.SOB_ID
                             AND DL.ORG_ID                  = DLO.ORG_ID
                             AND DL.PERSON_ID               = C1.PERSON_ID
                             AND DL.WORK_DATE               BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
                             AND DL.WORK_CORP_ID            = C1.CORP_ID
                             AND DL.SOB_ID                  = C1.SOB_ID
                             AND DL.ORG_ID                  = C1.ORG_ID
                             AND DL.CLOSED_YN              = 'Y'
                          GROUP BY DL.PERSON_ID
                               , DL.SOB_ID
                               , DL.ORG_ID
                               , CASE 
                                   WHEN DL.HOLY_TYPE = '0' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '14' THEN '20'     -- 무휴 : 연장.
                                   WHEN DL.HOLY_TYPE = '0' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '15' THEN '20'     -- 무휴 : 휴일근로.
                                   WHEN DL.HOLY_TYPE = '0' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '17' THEN '21'     -- 무휴 : 야간할증.
                                   WHEN DL.HOLY_TYPE = '1' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '14' THEN '18'     -- 유휴 : 연장.
                                   WHEN DL.HOLY_TYPE = '1' AND JC.JOB_CATEGORY_CODE = '20' AND DLO.OT_TYPE = '16' THEN '15'     -- 유휴 야간 : 휴일근로.
                                   WHEN DL.HOLY_TYPE = '1' AND DLO.OT_TYPE = '17' THEN '19'     -- 유휴 : 야간할증.
                                   ELSE DLO.OT_TYPE
                                 END
                        ) SX1
                  WHERE OT.OT_TYPE            = SX1.OT_TYPE
                    AND OT.SOB_ID             = SX1.SOB_ID
                    AND OT.ORG_ID             = SX1.ORG_ID
                    AND OT.SOB_ID             = C1.SOB_ID
                    AND OT.ORG_ID             = C1.ORG_ID
                    AND OT.ENABLED_FLAG    = 'Y'
                    AND OT.EFFECTIVE_DATE_FR <= P_PAY_DATE_TO
                    AND (OT.EFFECTIVE_DATE_TO IS NULL OR OT.EFFECTIVE_DATE_TO >= P_PAY_DATE_FR)
                  GROUP BY SX1.PERSON_ID
                      , CASE 
                          WHEN C1.PAY_TYPE IN ('1', '3') THEN OT.ALLOWANCE_10_ID
                          ELSE OT.ALLOWANCE_20_ID
                        END 
                      , CASE 
                          WHEN C1.PAY_TYPE IN ('1', '3') THEN OT.ALLOWANCE_10_CODE
                          ELSE OT.ALLOWANCE_20_CODE
                        END 
                ) 
      LOOP
        -- 근태 수당.
        -- 근태 수당.
        IF R1.ALLOWANCE_CODE IN('A17') THEN
          V_ALLOWANCE_AMOUNT := NVL(HRP_PAYMENT_G_SET.HOURLY_PAY_AMOUNT_F(C1.PAY_YYYYMM, C1.PERSON_ID, C1.SOB_ID, C1.ORG_ID), 0) * NVL(R1.OT_TIME, 0);
        ELSE
          V_ALLOWANCE_AMOUNT := NVL(C1.GENERAL_HOURLY_AMOUNT, 0) * NVL(R1.OT_TIME, 0);
        END IF;
        IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
          -- 급/상여 지급내역 삭제.
          DELETE FROM HRR_RETIRE_ADJUST_PAY_DETAIL RAP
          WHERE RAP.ADJUSTMENT_ID    = P_ADJUSTMENT_ID
            AND RAP.PAY_YYYYMM       = P_PAY_YYYYMM
            AND RAP.WAGE_TYPE        = P_WAGE_TYPE
            AND RAP.PERSON_ID        = C1.PERSON_ID
            AND RAP.SOB_ID           = C1.SOB_ID
            AND RAP.ORG_ID           = C1.ORG_ID
            AND RAP.ALLOWANCE_ID     = R1.ALLOWANCE_ID            
          ;
          INSERT_PAY_DETAIL
            ( P_ADJUSTMENT_ID     => P_ADJUSTMENT_ID
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_WAGE_TYPE         => P_WAGE_TYPE
            , P_ALLOWANCE_ID      => R1.ALLOWANCE_ID
            , P_ALLOWANCE_AMOUNT  => NVL(V_ALLOWANCE_AMOUNT, 0)
            , P_PERSON_ID         => C1.PERSON_ID
            , P_CORP_ID           => C1.CORP_ID
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            , P_USER_ID           => P_USER_ID          
            );
        END IF;
      END LOOP R1;
    END LOOP C1;

-- 야간장려수당.
    FOR C1 IN (SELECT HA.ALLOWANCE_ID
                     , AE.ALLOWANCE_CODE
                     , AE.ALLOWANCE_CLASS
                     , AE.FORMULA1 AS HOLY_3_AMOUNT
                     , AE.FORMULA2 AS STD_TIME
                     , AE.FORMULA3
                     , AE.FORMULA4
                     , AE.FORMULA5
                     , AE.FORMULA6
                     , AE.FORMULA7
                     , AE.FORMULA8
                  FROM HRM_ALLOWANCE_ETC_V AE
                    , HRM_ALLOWANCE_V HA
                    , ( SELECT CASE
                                 WHEN PMH.PAY_TYPE IN('2', '4') THEN '4'  -- 시급.
                                 ELSE '3'  -- 연봉.
                               END PAY_TYPE
                          FROM HRP_PAY_MASTER_HEADER PMH
                        WHERE PMH.PERSON_ID     = P_PERSON_ID
                          AND PMH.START_YYYYMM  <= P_PAY_YYYYMM
                          AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                          AND PMH.SOB_ID        = P_SOB_ID
                          AND PMH.ORG_ID        = P_ORG_ID
                       ) SX1
                WHERE AE.ALLOWANCE_CODE         = HA.ALLOWANCE_CODE
                  AND AE.SOB_ID                 = HA.SOB_ID
                  AND AE.ORG_ID                 = HA.ORG_ID
                  AND '4'                       = SX1.PAY_TYPE
                  AND AE.SOB_ID                 = P_SOB_ID
                  AND AE.ORG_ID                 = P_ORG_ID
                  AND AE.ALLOWANCE_CLASS        = 'HOLY_3'
                  AND AE.ENABLED_FLAG           = 'Y'
                  AND AE.EFFECTIVE_DATE_FR      <= P_PAY_DATE_TO
                  AND (AE.EFFECTIVE_DATE_TO IS NULL OR AE.EFFECTIVE_DATE_TO >= P_PAY_DATE_FR)
               )
    LOOP
      V_HOLY_3_COUNT := 0;
      V_ALLOWANCE_AMOUNT := 0;
      -- 야간 지각/조퇴 시간 계산.
      FOR R1 IN ( SELECT DL.PERSON_ID
                       , DL.WORK_DATE
                       , NVL(SUM(CASE
                                   WHEN DLO.OT_TYPE IN('17', '19', '21') THEN DLO.OT_TIME
                                   ELSE 0
                                 END), 0) AS NIGHT_BONUS_TIME
                       , NVL(SUM( CASE OT.OT_COLUMN
                                    WHEN 'LEAVE_TIME' THEN DLO.OT_TIME
                                    WHEN 'LATE_TIME' THEN DLO.OT_TIME
                                    ELSE 0
                                  END
                                 ), 0) AS LEAVE_TIME
                    FROM HRD_DAY_LEAVE_V DL
                      , HRD_DAY_LEAVE_OT DLO
                      , HRM_OT_TYPE_V OT
                  WHERE DL.DAY_LEAVE_ID         = DLO.DAY_LEAVE_ID
                    AND DLO.OT_TYPE             = OT.OT_TYPE
                    AND DLO.SOB_ID              = OT.SOB_ID
                    AND DLO.ORG_ID              = OT.ORG_ID
                    AND DL.WORK_DATE            BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
                    AND DL.PERSON_ID            = P_PERSON_ID
                    AND DL.CLOSED_YN            = 'Y'
                    AND DLO.OT_TIME             > 0
                  GROUP BY DL.PERSON_ID
                       , DL.WORK_DATE
                ) 
      LOOP
        -- 기준 시간 이상 근무해야 적용.
        IF NVL(C1.STD_TIME, 0) < NVL(R1.NIGHT_BONUS_TIME, 0) - NVL(R1.LEAVE_TIME, 0) THEN
          V_HOLY_3_COUNT := NVL(V_HOLY_3_COUNT, 0) + 1;
        ELSE
          NULL;
        END IF;
      END LOOP R1;
      V_ALLOWANCE_AMOUNT := NVL(V_HOLY_3_COUNT, 0) * NVL(C1.HOLY_3_AMOUNT, 0);
      IF  NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
        -- 급/상여 지급내역 삭제.
        DELETE FROM HRR_RETIRE_ADJUST_PAY_DETAIL RAP
        WHERE RAP.ADJUSTMENT_ID    = P_ADJUSTMENT_ID
          AND RAP.PAY_YYYYMM       = P_PAY_YYYYMM
          AND RAP.WAGE_TYPE        = P_WAGE_TYPE
          AND RAP.ALLOWANCE_ID     = C1.ALLOWANCE_ID            
        ;
        INSERT_PAY_DETAIL
          ( P_ADJUSTMENT_ID     => P_ADJUSTMENT_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_ALLOWANCE_AMOUNT  => NVL(V_ALLOWANCE_AMOUNT, 0)
          , P_PERSON_ID         => P_PERSON_ID
          , P_CORP_ID           => P_CORP_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID          
          );
      END IF;
    END LOOP C1;

-- SUMMARY INSERT : DETAIL SUMMARY
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUSTMENT_PAYMENT
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, TOTAL_AMOUNT
      , START_DATE, END_DATE
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY      
      )
      SELECT APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , SUM(APD.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , P_PAY_DATE_FR
           , P_PAY_DATE_TO
           , APD.PERSON_ID
           , APD.CORP_ID
           , P_SOB_ID
           , P_ORG_ID
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
      WHERE APD.ADJUSTMENT_ID     = P_ADJUSTMENT_ID
        AND APD.PAY_YYYYMM        = P_PAY_YYYYMM
        AND APD.WAGE_TYPE         = P_WAGE_TYPE
        AND APD.PERSON_ID         = P_PERSON_ID
        AND APD.CORP_ID           = P_CORP_ID
        AND APD.SOB_ID            = P_SOB_ID
        AND APD.ORG_ID            = P_ORG_ID
      GROUP BY APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , APD.PERSON_ID
           , APD.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Pay Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
  END PAY_MAIN_DAY;  
*/

--  11-2. (BH)급여 계산 MAIN
  PROCEDURE PAY_MAIN_DAY
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE;
    V_ALLOWANCE_AMOUNT            NUMBER;             -- 지급액.
    
    V_TOTAL_DAY                   NUMBER := 0;        -- 총 월일수.
    V_PAY_DAY                     NUMBER := 0;        -- 급여 일수(근무일수-무급일수-무급휴일).
    
    V_STD_HOLY_0_COUNT            NUMBER := 0;        -- 기준 무급휴일일수.
    V_HOLY_0_COUNT                NUMBER := 0;        -- 근무 무급휴일일수.    
    V_HOLY_3_COUNT                NUMBER := 0;        -- 야간횟수.
    V_TEMP_COUNT                  NUMBER := 0;        -- 임시 일수.
  BEGIN
    V_SYSDATE   := GET_LOCAL_DATE(P_SOB_ID);
    
    -- 총 월일수.
    V_TOTAL_DAY := LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM')) - TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') + 1;
    V_PAY_DAY := P_PAY_DATE_TO - P_PAY_DATE_FR + 1;
    
    /*-- 기준 무급휴일일수.
    BEGIN
      SELECT COUNT(WC.PERSON_ID) AS STD_HOLY_0_COUNT
        INTO V_STD_HOLY_0_COUNT
        FROM HRD_WORK_CALENDAR WC
      WHERE WC.WORK_DATE        BETWEEN TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
        AND WC.PERSON_ID        = P_PERSON_ID
        AND WC.SOB_ID           = P_SOB_ID
        AND WC.ORG_ID           = P_ORG_ID
        AND WC.HOLY_TYPE        = '0'                     -- 무휴.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_STD_HOLY_0_COUNT := 0;
    END;*/
    
    /*-- 근무 무급휴일일수.
    BEGIN
      SELECT MT.HOLY_0_COUNT 
        INTO V_HOLY_0_COUNT
        FROM HRD_MONTH_TOTAL MT
      WHERE MT.DUTY_YYYYMM      = P_PAY_YYYYMM
        AND MT.DUTY_TYPE        = 'D2'
        AND MT.PERSON_ID        = P_PERSON_ID
        AND MT.SOB_ID           = P_SOB_ID
        AND MT.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOLY_0_COUNT := 0;
    END;
    -- 급여일수 재계산 : 무급휴일 제외.
    V_PAY_DAY := NVL(V_PAY_DAY, 0) - NVL(V_HOLY_0_COUNT, 0);*/
    
    /*-- 근무 무급일수 .
    V_TEMP_COUNT := 0;
    BEGIN
      SELECT COUNT(DL.PERSON_ID) AS HOLY_0_COUNT
        INTO V_TEMP_COUNT
        FROM HRD_DAY_LEAVE_V DL
          , HRM_DUTY_CODE_V DC
      WHERE DL.DUTY_ID          = DC.DUTY_ID
        AND DL.WORK_DATE        BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND DL.PERSON_ID        = P_PERSON_ID
        AND DL.SOB_ID           = P_SOB_ID
        AND DL.ORG_ID           = P_ORG_ID
        AND DC.NON_PAY_DAY_FLAG = 'Y'                     -- 무급.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TEMP_COUNT := 0;
    END;
    -- 급여일수 재계산 : 무급일수 제외.
    V_PAY_DAY := NVL(V_PAY_DAY, 0) - NVL(V_TEMP_COUNT, 0);
    
    -- 주휴공제수 적용.
    V_TEMP_COUNT := 0;
    BEGIN
      SELECT COUNT(DISTINCT WD.WORK_DATE) AS WEEK_DED_COUNT
        INTO V_TEMP_COUNT
        FROM HRD_WEEKLY_DED WD
      WHERE WD.PERSON_ID          = P_PERSON_ID
        AND WD.DED_DATE           BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND WD.WORK_CORP_ID       = P_CORP_ID
        AND WD.SOB_ID             = P_SOB_ID
        AND WD.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TEMP_COUNT := 0;
    END;
    -- 급여일수 재계산 : 무급일수 제외.
    V_PAY_DAY := NVL(V_PAY_DAY, 0) - NVL(V_TEMP_COUNT, 0);*/
    
    IF NVL(V_PAY_DAY, 0) < 0 THEN
      V_PAY_DAY := 0;
    END IF;
       
    ---- 2.1 해당월 지급내역을 일괄 적용.
    FOR C1 IN ( SELECT MA.PERSON_ID
                     , MA.CORP_ID
                     , MA.ALLOWANCE_ID
                     , MA.ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_MONTH_ALLOWANCE MA
                 WHERE MP.MONTH_PAYMENT_ID    = MA.MONTH_PAYMENT_ID
                   AND MP.PAY_YYYYMM          = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE           = P_WAGE_TYPE
                   AND MP.PERSON_ID           = P_PERSON_ID
                   AND MP.SOB_ID              = P_SOB_ID
                   AND MP.ORG_ID              = P_ORG_ID
               )
    LOOP 
      -- 지급 항목 --
      IF NVL(C1.ALLOWANCE_AMOUNT, 0) <> 0 THEN
        INSERT_PAY_DETAIL
          ( P_ADJUSTMENT_ID     => P_ADJUSTMENT_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_ALLOWANCE_AMOUNT  => NVL(C1.ALLOWANCE_AMOUNT, 0)
          , P_PERSON_ID         => C1.PERSON_ID
          , P_CORP_ID           => C1.CORP_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID          
          );
      END IF;
    END LOOP C1;
    
    ---- 2.2 지급항목 일할계산.
    FOR C1 IN ( SELECT APD.PERSON_ID
                     , APD.CORP_ID
                     , NVL(SX1.PAY_TYPE, '3') PAY_TYPE  -- 급여마스터 없을 때 연봉직으로 처리.
                     , SX1.PAY_GRADE
                     , APD.ALLOWANCE_ID
                     , APD.ALLOWANCE_AMOUNT
                  FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
                    , ( -- 급여마스터.
                        SELECT PMH.PERSON_ID
                             , PMH.PAY_TYPE
                             , PG.PAY_GRADE
                             , PMH.SOB_ID
                             , PMH.ORG_ID
                          FROM HRP_PAY_MASTER_HEADER PMH 
                            , HRM_PAY_GRADE_V PG
                        WHERE PMH.PAY_GRADE_ID  = PG.PAY_GRADE_ID
                          AND PMH.PERSON_ID     = P_PERSON_ID
                          AND PMH.CORP_ID       = P_CORP_ID
                          AND PMH.SOB_ID        = P_SOB_ID
                          AND PMH.ORG_ID        = P_ORG_ID
                          AND PMH.START_YYYYMM  <= P_PAY_YYYYMM
                          AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM) 
                      ) SX1
                 WHERE APD.PERSON_ID        = SX1.PERSON_ID(+)
                   AND APD.ADJUSTMENT_ID    = P_ADJUSTMENT_ID
                   AND APD.PAY_YYYYMM       = P_PAY_YYYYMM
                   AND APD.WAGE_TYPE        = P_WAGE_TYPE
                   AND APD.PERSON_ID        = P_PERSON_ID
                   AND APD.CORP_ID          = P_CORP_ID
                   AND APD.SOB_ID           = P_SOB_ID
                   AND APD.ORG_ID           = P_ORG_ID
               )
    LOOP 
      V_ALLOWANCE_AMOUNT := 0;
      IF C1.PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF C1.PAY_TYPE = '3' THEN
      -- 연봉제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0);
      ELSIF C1.PAY_TYPE = '1' THEN
      -- 월급제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0);
      ELSIF C1.PAY_TYPE = '2' THEN
      -- 일급제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0);
      ELSIF C1.PAY_TYPE = '4' THEN
      -- 시급제.
        V_ALLOWANCE_AMOUNT := (NVL(C1.ALLOWANCE_AMOUNT, 0) / NVL(V_TOTAL_DAY, 0)) * NVL(V_PAY_DAY, 0); 
      END IF;
      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 지급 항목 --
        V_ALLOWANCE_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, V_ALLOWANCE_AMOUNT, 'PAYMENT');
        UPDATE HRR_RETIRE_ADJUST_PAY_DETAIL APD
          SET APD.ALLOWANCE_AMOUNT  = V_ALLOWANCE_AMOUNT
        WHERE APD.ADJUSTMENT_ID     = P_ADJUSTMENT_ID
          AND APD.PAY_YYYYMM        = P_PAY_YYYYMM
          AND APD.WAGE_TYPE         = P_WAGE_TYPE
          AND APD.PERSON_ID         = C1.PERSON_ID
          AND APD.ALLOWANCE_ID      = C1.ALLOWANCE_ID
          AND APD.SOB_ID            = P_SOB_ID
          AND APD.ORG_ID            = P_ORG_ID
        ;
      END IF;
    END LOOP C1;
    
-- SUMMARY INSERT : DETAIL SUMMARY
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUSTMENT_PAYMENT
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, TOTAL_AMOUNT
      , START_DATE, END_DATE
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY      
      )
      SELECT APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , SUM(APD.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , P_PAY_DATE_FR
           , P_PAY_DATE_TO
           , APD.PERSON_ID
           , APD.CORP_ID
           , P_SOB_ID
           , P_ORG_ID
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
      WHERE APD.ADJUSTMENT_ID     = P_ADJUSTMENT_ID
        AND APD.PAY_YYYYMM        = P_PAY_YYYYMM
        AND APD.WAGE_TYPE         = P_WAGE_TYPE
        AND APD.PERSON_ID         = P_PERSON_ID
        AND APD.CORP_ID           = P_CORP_ID
        AND APD.SOB_ID            = P_SOB_ID
        AND APD.ORG_ID            = P_ORG_ID
      GROUP BY APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , APD.PERSON_ID
           , APD.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Pay Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
  END PAY_MAIN_DAY;  

---------------------------------------------------------------------------------------------------
--  50. 상여 계산.
  PROCEDURE BONUS_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE   DATE;
  BEGIN
    -- DETAIL INSERT
    V_SYSDATE   := GET_LOCAL_DATE(P_SOB_ID);
    IF P_JOB_CATE_CODE = '10' THEN
      NULL;
      /* -- 조선미s 요청 : 연봉상여는 퇴직금 계산시 상여금에 포함하지 않음.
      BEGIN
      -- 관리직은 급여에 상여 포함됨.
        INSERT INTO HRR_RETIRE_ADJUST_PAY_DETAIL
        ( ADJUSTMENT_ID
        , PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID, ALLOWANCE_AMOUNT
        , PERSON_ID, CORP_ID
        , SOB_ID, ORG_ID
        , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
        )
        SELECT P_ADJUSTMENT_ID
             , MP.PAY_YYYYMM
             , P_WAGE_TYPE AS WAGE_TYPE
             , MA.ALLOWANCE_ID
             , MA.ALLOWANCE_AMOUNT
             , MA.PERSON_ID
             , MA.CORP_ID
             , MA.SOB_ID
             , MA.ORG_ID
             , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
          FROM HRP_MONTH_PAYMENT MP
            , HRP_MONTH_ALLOWANCE MA
            , HRM_ALLOWANCE_V HA
        WHERE MP.MONTH_PAYMENT_ID         = MA.MONTH_PAYMENT_ID
          AND MA.ALLOWANCE_ID             = HA.ALLOWANCE_ID          
          AND MP.PAY_YYYYMM               = P_PAY_YYYYMM
          AND MP.WAGE_TYPE                = 'P1'                     -- 급여에 포함되서 지급됨.
          AND MP.PERSON_ID                = P_PERSON_ID
          AND MP.CORP_ID                  = P_CORP_ID
          AND MP.SOB_ID                   = P_SOB_ID
          AND MP.ORG_ID                   = P_ORG_ID
          AND HA.RETIRE_YN                = 'Y'
          AND HA.ALLOWANCE_TYPE           = 'BONUS'
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Bonus Line Insert Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      END;*/
    ELSE
      BEGIN
        INSERT INTO HRR_RETIRE_ADJUST_PAY_DETAIL
        ( ADJUSTMENT_ID
        , PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID, ALLOWANCE_AMOUNT
        , PERSON_ID, CORP_ID
        , SOB_ID, ORG_ID
        , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
        )
        SELECT P_ADJUSTMENT_ID
             , MP.PAY_YYYYMM
             , MP.WAGE_TYPE
             , MA.ALLOWANCE_ID
             , MA.ALLOWANCE_AMOUNT
             , MA.PERSON_ID
             , MA.CORP_ID
             , MA.SOB_ID
             , MA.ORG_ID
             , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
          FROM HRP_MONTH_PAYMENT MP
            , HRP_MONTH_ALLOWANCE MA
            , HRM_ALLOWANCE_V HA
        WHERE MP.MONTH_PAYMENT_ID         = MA.MONTH_PAYMENT_ID
          AND MA.ALLOWANCE_ID             = HA.ALLOWANCE_ID
          AND MP.PAY_YYYYMM               = P_PAY_YYYYMM
          AND MP.WAGE_TYPE                = P_WAGE_TYPE
          AND MP.PERSON_ID                = P_PERSON_ID
          AND MP.CORP_ID                  = P_CORP_ID
          AND MP.SOB_ID                   = P_SOB_ID
          AND MP.ORG_ID                   = P_ORG_ID
          AND MP.PAY_TYPE                 IN('2', '4')
          AND HA.RETIRE_YN                = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Bonus Line Insert Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      END;
    END IF;
    
-- SUMMARY INSERT : DETAIL SUMMARY
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUSTMENT_PAYMENT
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, TOTAL_AMOUNT
      , START_DATE, END_DATE
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY      
      )
      SELECT APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , SUM(APD.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , P_PAY_DATE_FR
           , P_PAY_DATE_TO
           , APD.PERSON_ID
           , APD.CORP_ID
           , P_SOB_ID
           , P_ORG_ID
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
      WHERE APD.ADJUSTMENT_ID     = P_ADJUSTMENT_ID
        AND APD.PAY_YYYYMM        = P_PAY_YYYYMM
        AND APD.WAGE_TYPE         = P_WAGE_TYPE
        AND APD.PERSON_ID         = P_PERSON_ID
        AND APD.CORP_ID           = P_CORP_ID
        AND APD.SOB_ID            = P_SOB_ID
        AND APD.ORG_ID            = P_ORG_ID
      GROUP BY APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , APD.PERSON_ID
           , APD.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Bonus Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
  END BONUS_MAIN;

---------------------------------------------------------------------------------------------------
--  51. 특별상여 계산.
  PROCEDURE SPECIAL_BONUS_MAIN
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ADJUSTMENT_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.WAGE_TYPE%TYPE            
            , P_PERSON_ID         IN HRR_RETIRE_ADJUSTMENT_PAYMENT.PERSON_ID%TYPE
            , P_JOB_CATE_CODE     IN VARCHAR2
            , P_PAY_DATE_FR       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.START_DATE%TYPE
            , P_PAY_DATE_TO       IN HRR_RETIRE_ADJUSTMENT_PAYMENT.END_DATE%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUSTMENT_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUSTMENT_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE   DATE;
  BEGIN
    -- DETAIL INSERT
    V_SYSDATE   := GET_LOCAL_DATE(P_SOB_ID);
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUST_PAY_DETAIL
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID, ALLOWANCE_AMOUNT
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      )
      SELECT P_ADJUSTMENT_ID
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , MA.ALLOWANCE_ID
           , MA.ALLOWANCE_AMOUNT
           , MA.PERSON_ID
           , MA.CORP_ID
           , MA.SOB_ID
           , MA.ORG_ID
           , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
      WHERE MP.MONTH_PAYMENT_ID         = MA.MONTH_PAYMENT_ID
        AND MA.ALLOWANCE_ID             = HA.ALLOWANCE_ID
        AND MP.PAY_YYYYMM               = P_PAY_YYYYMM
        AND MP.WAGE_TYPE                = P_WAGE_TYPE
        AND MP.PERSON_ID                = P_PERSON_ID
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND HA.RETIRE_YN                = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Special Bonus Line Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    
-- SUMMARY INSERT : DETAIL SUMMARY    
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUSTMENT_PAYMENT
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, TOTAL_AMOUNT
      , START_DATE, END_DATE
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY      
      )
      SELECT APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , SUM(APD.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , P_PAY_DATE_FR
           , P_PAY_DATE_TO
           , APD.PERSON_ID
           , APD.CORP_ID
           , P_SOB_ID
           , P_ORG_ID
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRR_RETIRE_ADJUST_PAY_DETAIL APD
      WHERE APD.ADJUSTMENT_ID     = P_ADJUSTMENT_ID
        AND APD.PAY_YYYYMM        = P_PAY_YYYYMM
        AND APD.WAGE_TYPE         = P_WAGE_TYPE
        AND APD.PERSON_ID         = P_PERSON_ID
        AND APD.CORP_ID           = P_CORP_ID
        AND APD.SOB_ID            = P_SOB_ID
        AND APD.ORG_ID            = P_ORG_ID
      GROUP BY APD.ADJUSTMENT_ID
           , APD.PAY_YYYYMM
           , APD.WAGE_TYPE
           , APD.PERSON_ID
           , APD.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Special Bonus Insert Error : ' || SQLERRM;
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
  END SPECIAL_BONUS_MAIN;

---------------------------------------------------------------------------------------------------
--  91. 급상여 내역 INSERT.
  PROCEDURE INSERT_PAY_DETAIL
            ( P_ADJUSTMENT_ID     IN HRR_RETIRE_ADJUST_PAY_DETAIL.ADJUSTMENT_ID%TYPE
            , P_PAY_YYYYMM        IN HRR_RETIRE_ADJUST_PAY_DETAIL.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRR_RETIRE_ADJUST_PAY_DETAIL.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT  IN HRR_RETIRE_ADJUST_PAY_DETAIL.ALLOWANCE_AMOUNT%TYPE
            , P_PERSON_ID         IN HRR_RETIRE_ADJUST_PAY_DETAIL.PERSON_ID%TYPE
            , P_CORP_ID           IN HRR_RETIRE_ADJUST_PAY_DETAIL.CORP_ID%TYPE
            , P_SOB_ID            IN HRR_RETIRE_ADJUST_PAY_DETAIL.SOB_ID%TYPE
            , P_ORG_ID            IN HRR_RETIRE_ADJUST_PAY_DETAIL.ORG_ID%TYPE
            , P_USER_ID           IN HRR_RETIRE_ADJUST_PAY_DETAIL.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE;
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN
    -- DETAIL INSERT
    V_SYSDATE   := GET_LOCAL_DATE(P_SOB_ID);
    BEGIN
      V_ALLOWANCE_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, P_ALLOWANCE_AMOUNT, 'PAYMENT');      
    EXCEPTION WHEN OTHERS THEN
      V_ALLOWANCE_AMOUNT := TRUNC(P_ALLOWANCE_AMOUNT);
    END;
    BEGIN
      INSERT INTO HRR_RETIRE_ADJUST_PAY_DETAIL
      ( ADJUSTMENT_ID
      , PAY_YYYYMM, WAGE_TYPE, ALLOWANCE_ID, ALLOWANCE_AMOUNT
      , PERSON_ID, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( P_ADJUSTMENT_ID
      , P_PAY_YYYYMM, P_WAGE_TYPE, P_ALLOWANCE_ID, V_ALLOWANCE_AMOUNT
      , P_PERSON_ID, P_CORP_ID
      , P_SOB_ID, P_ORG_ID
      , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
      );      
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Pay Line Insert Error : ' || SQLERRM);
    END;
DBMS_OUTPUT.PUT_LINE('ADJUSTMENT_ID : ' || P_ADJUSTMENT_ID || ', PAY_YYYYMM : ' || P_PAY_YYYYMM || ', WAGE_TYPE : ' || P_WAGE_TYPE || ', ALLOWANCE_ID : ' || P_ALLOWANCE_ID);
  END INSERT_PAY_DETAIL;
  
END HRR_RETIRE_PAYMENT_SET_G;
/
