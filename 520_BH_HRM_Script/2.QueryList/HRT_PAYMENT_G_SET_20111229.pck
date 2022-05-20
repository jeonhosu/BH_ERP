CREATE OR REPLACE PACKAGE HRT_PAYMENT_G_SET
AS
--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( P_CORP_ID           IN HRT_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRT_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRT_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRT_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRT_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );


---------------------------------------------------------------------------------------------------
-- 기준 기본급 조회(급여마스터 기본급).
  FUNCTION BASIC_AMOUNT_F
            ( W_PAY_YYYYMM        IN HRT_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN HRT_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN NUMBER;

-- 통상 시급 계산.
  FUNCTION GENERAL_HOURLY_PAY_AMOUNT_F
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
-- 시급 계산.
  FUNCTION HOURLY_PAY_AMOUNT_F
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
-- 근속수당 계산.
  FUNCTION LONG_ALLOWANCE_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_LONG_MONTH        IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
-- 기업이윤 계산.
  FUNCTION BENEFIT_AMOUNT_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_TOTAL_AMOUNT      IN HRT_MONTH_PAYMENT.TOT_SUPPLY_AMOUNT%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;
            
---------------------------------------------------------------------------------------------------
-- 세금 계산.
  FUNCTION TAX_AMOUNT_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_TOTAL_AMOUNT      IN HRT_MONTH_PAYMENT.TOT_SUPPLY_AMOUNT%TYPE
            , W_SUPPORT_FAMILY    IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;

-- 수당 한도 체크해서 한도 금액 리턴.
  FUNCTION LIMIT_AMOUNT_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_ALLOWANCE_CODE    IN VARCHAR2
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;

---------------------------------------------------------------------------------------------------
-- 급상여 시작/종료 일자 조회.
  PROCEDURE PAYMENT_TERM
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PAY_TYPE          IN HRT_MONTH_PAYMENT.PAY_TYPE%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , O_START_DATE        OUT HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , O_END_DATE          OUT HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            );

-- 급상여 처리 기준일자 반환.
  PROCEDURE DV_PAY_STANDARD_DATE_P
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , O_STANDARD_DATE     OUT HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            );

-- 급상여 지급 기준일자 반환.
  PROCEDURE DV_PAY_SUPPLY_DATE_P
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , O_SUPPLY_DATE       OUT HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            );

-- 급여년월에 대한 평일근무일수 계산.
  FUNCTION WORK_DAY_COUNT_F
            ( P_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;
           
END HRT_PAYMENT_G_SET; 
/
CREATE OR REPLACE PACKAGE BODY HRT_PAYMENT_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRT_MONTH_PAYMENT_G_SET
/* DESCRIPTION  : 급상여 계산/산출 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION      Version
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE         1.0
/******************************************************************************/
-- 전역 상수값 정의.
  C_MONTH_PAYMENT                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P1';
  C_MONTH_BONUS                   CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P2';
  C_FESTIVAL_BONUS                CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P3';
  C_DANGJIK_PAYMENT               CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P4';
  C_SPECIAL_BONUS                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P5';

--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( P_CORP_ID           IN HRT_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRT_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRT_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRT_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRT_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_RECORD_COUNT                NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    DBMS_OUTPUT.PUT_LINE('-----' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10075', '&&START_TIME:=' || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS')));
    /*V_STATUS := HRM_CLOSING_G.CLOSING_CHECK_W( W_CORP_ID => P_CORP_ID
                                              , W_CLOSING_YYYYMM => P_PAY_YYYYMM
                                              , W_CLOSING_TYPE => P_WAGE_TYPE
                                              , W_SOB_ID => P_SOB_ID
                                              , W_ORG_ID => P_ORG_ID);
    IF V_STATUS = 'F' THEN
      O_MESSAGE := ERRNUMS.Data_Not_Opened_Desc;
      RETURN;
    ELSIF V_STATUS = 'Y' THEN
      O_MESSAGE := ERRNUMS.Data_closed_Desc;
      RETURN;
    END IF;*/

---------------------------------------------------------------------------
-- 기존 자료 삭제
---------------------------------------------------------------------------
    BEGIN
      -- 지급내역 삭제.
      DELETE FROM HRT_MONTH_ALLOWANCE MA
       WHERE EXISTS ( SELECT 'X'
                        FROM HRT_MONTH_PAYMENT MP
                       WHERE MP.MONTH_PAYMENT_ID      = MA.MONTH_PAYMENT_ID
                         AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                         AND MP.WAGE_TYPE             = P_WAGE_TYPE
                         AND MP.CORP_ID               = NVL(P_CORP_ID, MP.CORP_ID)
                         AND MP.DEPT_ID               = NVL(P_DEPT_ID, MP.DEPT_ID)
                         AND MP.PERSON_ID             = NVL(P_PERSON_ID, MP.PERSON_ID)
                         AND MP.PAY_TYPE              = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                         AND MP.SOB_ID                = P_SOB_ID
                         AND MP.ORG_ID                = P_ORG_ID
                    )
      ;

      -- 공제내역 삭제.
      DELETE FROM HRT_MONTH_DEDUCTION MD
       WHERE EXISTS ( SELECT 'X'
                        FROM HRT_MONTH_PAYMENT MP
                       WHERE MP.MONTH_PAYMENT_ID      = MD.MONTH_PAYMENT_ID
                         AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                         AND MP.WAGE_TYPE             = P_WAGE_TYPE
                         AND MP.CORP_ID               = NVL(P_CORP_ID, MP.CORP_ID)
                         AND MP.DEPT_ID               = NVL(P_DEPT_ID, MP.DEPT_ID)
                         AND MP.PERSON_ID             = NVL(P_PERSON_ID, MP.PERSON_ID)
                         AND MP.PAY_TYPE              = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                         AND MP.SOB_ID                = P_SOB_ID
                         AND MP.ORG_ID                = P_ORG_ID
                    )
      ;

      -- 월급여 내역 삭제.
      DELETE FROM HRT_MONTH_PAYMENT MP
       WHERE MP.PAY_YYYYMM            = P_PAY_YYYYMM
         AND MP.WAGE_TYPE             = P_WAGE_TYPE
         AND MP.CORP_ID               = NVL(P_CORP_ID, MP.CORP_ID)
         AND MP.DEPT_ID               = NVL(P_DEPT_ID, MP.DEPT_ID)
         AND MP.PERSON_ID             = NVL(P_PERSON_ID, MP.PERSON_ID)
         AND MP.PAY_TYPE              = NVL(P_PAY_TYPE, MP.PAY_TYPE)
         AND MP.SOB_ID                = P_SOB_ID
         AND MP.ORG_ID                = P_ORG_ID
      ;
      V_RECORD_COUNT := 0;
      V_RECORD_COUNT := SQL%ROWCOUNT;
      DBMS_OUTPUT.PUT_LINE('-----' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10077', '&&COUNT:=' || TO_CHAR(V_RECORD_COUNT, 'FM999,999,990')));
    END;

---------------------------------------------------------------------------
-- 1. 급상여 처리 대상 산출.
---------------------------------------------------------------------------
    IF P_WAGE_TYPE = C_MONTH_PAYMENT THEN
    -- 급여.
      HRT_MONTH_PAYMENT_G_SET.PAYMENT_MAIN( P_CORP_ID => P_CORP_ID
                                          , P_PAY_YYYYMM => P_PAY_YYYYMM
                                          , P_WAGE_TYPE => P_WAGE_TYPE
                                          , P_PAY_TYPE => P_PAY_TYPE
                                          , P_DEPT_ID => P_DEPT_ID
                                          , P_PERSON_ID => P_PERSON_ID
                                          , P_STD_DATE => P_STD_DATE
                                          , P_SUPPLY_DATE => P_SUPPLY_DATE
                                          , P_EXCEPT_YN => P_EXCEPT_YN
                                          , P_SOB_ID => P_SOB_ID
                                          , P_ORG_ID => P_ORG_ID
                                          , P_USER_ID => P_USER_ID
                                          , O_STATUS => O_STATUS
                                          , O_MESSAGE => O_MESSAGE
                                          );
    ELSIF P_WAGE_TYPE = C_MONTH_BONUS THEN
    -- 상여.
      HRT_MONTH_BONUS_G_SET.PAYMENT_MAIN( P_CORP_ID => P_CORP_ID
                                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                                        , P_WAGE_TYPE => P_WAGE_TYPE
                                        , P_PAY_TYPE => P_PAY_TYPE
                                        , P_DEPT_ID => P_DEPT_ID
                                        , P_PERSON_ID => P_PERSON_ID
                                        , P_STD_DATE => P_STD_DATE
                                        , P_SUPPLY_DATE => P_SUPPLY_DATE
                                        , P_EXCEPT_YN => P_EXCEPT_YN
                                        , P_SOB_ID => P_SOB_ID
                                        , P_ORG_ID => P_ORG_ID
                                        , P_USER_ID => P_USER_ID
                                        , O_STATUS => O_STATUS
                                        , O_MESSAGE => O_MESSAGE
                                        );

    END IF;

    DBMS_OUTPUT.PUT_LINE('-----' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10076', '&&END_TIME:=' || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS')));
    IF O_MESSAGE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    END IF;
    O_STATUS := 'S';
  END PAYMENT_MAIN;

---------------------------------------------------------------------------------------------------
-- 기준 기본급 조회(급여마스터 기본급).
  FUNCTION BASIC_AMOUNT_F
            ( W_PAY_YYYYMM        IN HRT_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN HRT_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_BASIC_AMOUNT                NUMBER := 0;

  BEGIN
    BEGIN
      SELECT MAX(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', PML.ALLOWANCE_AMOUNT, 0)) AS BASIC_AMOUNT
        INTO V_BASIC_AMOUNT
        FROM HRT_PAY_MST_COMMON_HEADER PMH
          , HRT_PAY_MST_COMMON_LINE PML
          , HRM_ALLOWANCE_V HA
       WHERE PMH.COMMON_HEADER_ID = PML.COMMON_HEADER_ID
         AND PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
         AND PMH.START_YYYYMM     <= W_PAY_YYYYMM
         AND PMH.END_YYYYMM       >= W_PAY_YYYYMM
         AND PMH.SOB_ID           = W_SOB_ID
         AND PMH.ORG_ID           = W_ORG_ID
         AND ROWNUM               <= 1
      ;
      /*SELECT MAX(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', PML.ALLOWANCE_AMOUNT, 0)) AS BASIC_AMOUNT
        INTO V_BASIC_AMOUNT
        FROM HRT_PAY_MASTER_HEADER PMH
          , HRT_PAY_MASTER_LINE PML
          , HRM_ALLOWANCE_V HA
       WHERE PMH.PAY_HEADER_ID    = PML.PAY_HEADER_ID
         AND PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
         AND PMH.PERSON_ID        = W_PERSON_ID
         AND PMH.START_YYYYMM     <= W_PAY_YYYYMM
         AND PMH.END_YYYYMM       >= W_PAY_YYYYMM
         AND PMH.SOB_ID           = W_SOB_ID
         AND PMH.ORG_ID           = W_ORG_ID
         AND ROWNUM               <= 1
      ;*/
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Base Amount Cal Error : ' || SQLERRM);
      V_BASIC_AMOUNT := 0;
    END;
    RETURN V_BASIC_AMOUNT;

  END BASIC_AMOUNT_F;

-- 통상 시급 계산.
  FUNCTION GENERAL_HOURLY_PAY_AMOUNT_F
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_PAY_LEVEL                   VARCHAR2(50) := NULL;
    V_HOURLY_PAY_TIME             NUMBER := 0;
    V_BASIC_AMOUNT                NUMBER := 0;                    -- 기본급.
    V_ETC_AMOUNT                  NUMBER := 0;                    -- 기타수당.
    V_HOURLY_PAY_AMOUNT           NUMBER := 0;
  BEGIN
    BEGIN
      SELECT PT.PAY_LEVEL
           , PT.GENERAL_HOURLY_TIME
           , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', PML.ALLOWANCE_AMOUNT, 0)), 0) AS BASIC_AMOUNT
           , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', 0, PML.ALLOWANCE_AMOUNT)), 0) AS ETC_AMOUNT
          INTO V_PAY_LEVEL, V_HOURLY_PAY_TIME, V_BASIC_AMOUNT, V_ETC_AMOUNT
          FROM HRT_PAY_MST_COMMON_HEADER PMH
            , HRT_PAY_MST_COMMON_LINE PML
            , HRM_ALLOWANCE_V HA
            , HRM_PAY_TYPE_V PT
         WHERE PMH.COMMON_HEADER_ID = PML.COMMON_HEADER_ID
           AND PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
           AND PMH.PAY_TYPE         = PT.PAY_TYPE
           AND PMH.SOB_ID           = PT.SOB_ID
           AND PMH.ORG_ID           = PT.ORG_ID
           AND HA.GENERAL_TIME_YN   = 'Y'
           AND PMH.START_YYYYMM     <= W_PAY_YYYYMM
           AND PMH.END_YYYYMM       >= W_PAY_YYYYMM
           AND PMH.SOB_ID           = W_SOB_ID
           AND PMH.ORG_ID           = W_ORG_ID
        GROUP BY PT.PAY_LEVEL, PT.GENERAL_HOURLY_TIME
        ;
       /* -- 전호수 주석 : 개인별 급여마스터 적용시 적용함.
       SELECT PT.PAY_LEVEL
           , PT.GENERAL_HOURLY_TIME
           , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', PML.ALLOWANCE_AMOUNT, 0)), 0) AS BASIC_AMOUNT
           , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', 0, PML.ALLOWANCE_AMOUNT)), 0) AS ETC_AMOUNT
          INTO V_PAY_LEVEL, V_HOURLY_PAY_TIME, V_BASIC_AMOUNT, V_ETC_AMOUNT
          FROM HRT_PAY_MASTER_HEADER PMH
            , HRT_PAY_MASTER_LINE PML
            , HRM_ALLOWANCE_V HA
            , HRM_PAY_TYPE_V PT
         WHERE PMH.PAY_HEADER_ID    = PML.PAY_HEADER_ID
           AND PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
           AND PMH.PAY_TYPE         = PT.PAY_TYPE
           AND PMH.SOB_ID           = PT.SOB_ID
           AND PMH.ORG_ID           = PT.ORG_ID
           AND HA.GENERAL_TIME_YN   = 'Y'
           AND PMH.PERSON_ID        = W_PERSON_ID
           AND PMH.START_YYYYMM     <= W_PAY_YYYYMM
           AND PMH.END_YYYYMM       >= W_PAY_YYYYMM
           AND PMH.SOB_ID           = W_SOB_ID
           AND PMH.ORG_ID           = W_ORG_ID
      GROUP BY PT.PAY_LEVEL, PT.GENERAL_HOURLY_TIME
      ;*/
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('General Hourly Pay Amount Cal Error : ' || SQLERRM);
      V_PAY_LEVEL := NULL;
      V_HOURLY_PAY_TIME := 1;
      V_HOURLY_PAY_AMOUNT := 0;
    END;
    IF NVL(V_HOURLY_PAY_TIME, 0) = 0 THEN
      V_HOURLY_PAY_TIME := HRM_COMMON_DATE_G.PERIOD_DAY_F(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')), 1);
      V_HOURLY_PAY_TIME := V_HOURLY_PAY_TIME * 8;
    END IF;
    IF V_PAY_LEVEL IN('YEAR', 'MONTH') THEN
      V_HOURLY_PAY_AMOUNT := DECIMAL_F(W_SOB_ID, W_ORG_ID, (NVL(V_BASIC_AMOUNT, 0) + NVL(V_ETC_AMOUNT, 0)) / V_HOURLY_PAY_TIME, 'PAYMENT');
    ELSIF V_PAY_LEVEL IN('DAILY') THEN
      V_HOURLY_PAY_AMOUNT := DECIMAL_F(W_SOB_ID, W_ORG_ID, ((NVL(V_BASIC_AMOUNT, 0) / 8) + (NVL(V_ETC_AMOUNT, 0) / V_HOURLY_PAY_TIME)), 'PAYMENT');
    ELSIF V_PAY_LEVEL IN('TIME') THEN
      V_HOURLY_PAY_AMOUNT := DECIMAL_F(W_SOB_ID, W_ORG_ID, (NVL(V_BASIC_AMOUNT, 0) + (NVL(V_ETC_AMOUNT, 0) / V_HOURLY_PAY_TIME)), 'PAYMENT');
    ELSE
      V_HOURLY_PAY_AMOUNT := 0;
    END IF;
    RETURN V_HOURLY_PAY_AMOUNT;

  END GENERAL_HOURLY_PAY_AMOUNT_F;

---------------------------------------------------------------------------------------------------
-- 시급 계산.
  FUNCTION HOURLY_PAY_AMOUNT_F
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_PAY_LEVEL                   VARCHAR2(50) := NULL;
    V_HOURLY_PAY_TIME             NUMBER := 0;
    V_BASIC_AMOUNT                NUMBER := 0;                    -- 기본급.
    V_HOURLY_PAY_AMOUNT           NUMBER := 0;

  BEGIN
    BEGIN
      SELECT PT.PAY_LEVEL
           , PT.GENERAL_HOURLY_TIME
           , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', PML.ALLOWANCE_AMOUNT, 0)), 0) AS BASIC_AMOUNT
          INTO V_PAY_LEVEL, V_HOURLY_PAY_TIME, V_BASIC_AMOUNT
          FROM HRT_PAY_MST_COMMON_HEADER PMH
            , HRT_PAY_MST_COMMON_LINE PML
            , HRM_ALLOWANCE_V HA
            , HRM_PAY_TYPE_V PT
         WHERE PMH.COMMON_HEADER_ID = PML.COMMON_HEADER_ID
           AND PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
           AND PMH.PAY_TYPE         = PT.PAY_TYPE
           AND PMH.SOB_ID           = PT.SOB_ID
           AND PMH.ORG_ID           = PT.ORG_ID
           AND HA.GENERAL_TIME_YN   = 'Y'
           AND PMH.START_YYYYMM     <= W_PAY_YYYYMM
           AND PMH.END_YYYYMM       >= W_PAY_YYYYMM
           AND PMH.SOB_ID           = W_SOB_ID
           AND PMH.ORG_ID           = W_ORG_ID
      GROUP BY PT.PAY_LEVEL
        , PT.GENERAL_HOURLY_TIME
      ;
       /* -- 전호수 주석 : 개인별 급여마스터 적용시 적용함.
       SELECT PT.PAY_LEVEL
           , PT.GENERAL_HOURLY_TIME
           , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BASIC', PML.ALLOWANCE_AMOUNT, 0)), 0) AS BASIC_AMOUNT
          INTO V_PAY_LEVEL, V_HOURLY_PAY_TIME, V_BASIC_AMOUNT
          FROM HRT_PAY_MASTER_HEADER PMH
            , HRT_PAY_MASTER_LINE PML
            , HRM_ALLOWANCE_V HA
            , HRM_PAY_TYPE_V PT
         WHERE PMH.PAY_HEADER_ID    = PML.PAY_HEADER_ID
           AND PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
           AND PMH.PAY_TYPE         = PT.PAY_TYPE
           AND PMH.SOB_ID           = PT.SOB_ID
           AND PMH.ORG_ID           = PT.ORG_ID
           AND HA.GENERAL_TIME_YN   = 'Y'
           AND PMH.PERSON_ID        = W_PERSON_ID
           AND PMH.START_YYYYMM     <= W_PAY_YYYYMM
           AND PMH.END_YYYYMM       >= W_PAY_YYYYMM
           AND PMH.SOB_ID           = W_SOB_ID
           AND PMH.ORG_ID           = W_ORG_ID
      GROUP BY PT.PAY_LEVEL
        , PT.GENERAL_HOURLY_TIME
      ;*/
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Hourly Pay Amount Cal Error : ' || SQLERRM);
      V_PAY_LEVEL := NULL;
      V_HOURLY_PAY_AMOUNT := 0;
    END;    
    IF V_PAY_LEVEL IN('YEAR', 'MONTH') THEN
      IF NVL(V_HOURLY_PAY_TIME, 0) = 0 THEN
        V_HOURLY_PAY_TIME := HRM_COMMON_DATE_G.PERIOD_DAY_F(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')), 1);
        V_HOURLY_PAY_TIME := V_HOURLY_PAY_TIME * 8;
      END IF;
      V_HOURLY_PAY_AMOUNT := DECIMAL_F(W_SOB_ID, W_ORG_ID, NVL(V_BASIC_AMOUNT, 0) / V_HOURLY_PAY_TIME, 'PAYMENT');
    ELSIF V_PAY_LEVEL IN('DAILY') THEN
      V_HOURLY_PAY_AMOUNT := DECIMAL_F(W_SOB_ID, W_ORG_ID, (NVL(V_BASIC_AMOUNT, 0) / 8), 'PAYMENT');
    ELSIF V_PAY_LEVEL IN('TIME') THEN
      V_HOURLY_PAY_AMOUNT := DECIMAL_F(W_SOB_ID, W_ORG_ID, NVL(V_BASIC_AMOUNT, 0), 'PAYMENT');
    ELSE
      V_HOURLY_PAY_AMOUNT := 0;
    END IF;
    RETURN V_HOURLY_PAY_AMOUNT;

  END HOURLY_PAY_AMOUNT_F;

---------------------------------------------------------------------------------------------------
-- 근속수당 계산.
  FUNCTION LONG_ALLOWANCE_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_LONG_MONTH        IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_LONG_ALLOWANCE_AMOUNT       NUMBER := 0;

  BEGIN
    BEGIN
      SELECT MAX(LA.LONG_ALLOWANCE_AMOUNT) AS LONG_ALLOWANCE_AMOUNT
        INTO V_LONG_ALLOWANCE_AMOUNT
        FROM HRM_ALLOWANCE_LONG_TEMP_V LA
       WHERE LA.SOB_ID                  = W_SOB_ID
         AND LA.ORG_ID                  = W_ORG_ID
         AND W_LONG_MONTH               BETWEEN LA.START_LONG_ALLOWANCE AND LA.END_LONG_ALLOWANCE
         AND LA.ENABLED_FLAG            = 'Y'
         AND LA.EFFECTIVE_DATE_FR       <= W_STD_DATE
         AND (LA.EFFECTIVE_DATE_TO IS NULL OR LA.EFFECTIVE_DATE_TO >= W_STD_DATE)
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Long Allowance Amount Cal Error : ' || SQLERRM);
      V_LONG_ALLOWANCE_AMOUNT := 0;
    END;
    RETURN V_LONG_ALLOWANCE_AMOUNT;

  END LONG_ALLOWANCE_F;

---------------------------------------------------------------------------------------------------
-- 기업이윤 계산.
  FUNCTION BENEFIT_AMOUNT_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_TOTAL_AMOUNT      IN HRT_MONTH_PAYMENT.TOT_SUPPLY_AMOUNT%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_BENEFIT_AMOUNT              NUMBER := 0;
    V_RATE                        NUMBER := 0;
  BEGIN
    BEGIN
      -- 이윤.
      SELECT NVL(TO_NUMBER(HC.VALUE1), 0) AS BENEFIT_RATE
        INTO V_RATE
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE              = 'BENEFIT_RATE'
         AND HC.ENABLED_FLAG            = 'Y'
         AND HC.EFFECTIVE_DATE_FR       <= W_STD_DATE
         AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= W_STD_DATE)
         AND HC.SOB_ID                  = W_SOB_ID
         AND HC.ORG_ID                  = W_ORG_ID
         AND ROWNUM                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RATE := 0;
    END;
    IF V_RATE = 0 THEN
      V_BENEFIT_AMOUNT := 0;
    ELSE
      V_BENEFIT_AMOUNT := ROUND(NVL(W_TOTAL_AMOUNT, 0) * (V_RATE / 100));
    END IF;
    RETURN V_BENEFIT_AMOUNT;
  END BENEFIT_AMOUNT_F;
  
---------------------------------------------------------------------------------------------------
-- 세금 계산.
  FUNCTION TAX_AMOUNT_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_TOTAL_AMOUNT      IN HRT_MONTH_PAYMENT.TOT_SUPPLY_AMOUNT%TYPE
            , W_SUPPORT_FAMILY    IN NUMBER
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_TAX_AMOUNT                  NUMBER := 0;
    
    V_AMOUNT                      NUMBER := 0;
    V_TAX_RATE_1                  NUMBER := 95;
    V_TAX_RATE_2                  NUMBER := 35;
  BEGIN
    -- 10,000,000을 초과할 경우 10,000,000을 초과하는 금액중 95%를 곱한 금액의 35% 상당액을 더해 준다--
    V_AMOUNT := 0;
    IF NVL(W_TOTAL_AMOUNT, 0) >= 10000000 THEN
      V_AMOUNT := NVL(W_TOTAL_AMOUNT, 0) - 10000000;      
      V_AMOUNT := TRUNC(NVL(V_AMOUNT, 0) * (V_TAX_RATE_1 / 100));
      V_AMOUNT := TRUNC(NVL(V_AMOUNT, 0) * (V_TAX_RATE_2 / 100));
    END IF;
    
    BEGIN
      SELECT NVL( CASE W_SUPPORT_FAMILY
                    WHEN 2 THEN TS.SUPP_NUM2
                    WHEN 3 THEN TS.SUPP_NUM3
                    WHEN 4 THEN TS.SUPP_NUM4
                    WHEN 5 THEN TS.SUPP_NUM5
                    WHEN 6 THEN TS.SUPP_NUM6
                    WHEN 7 THEN TS.SUPP_NUM7
                    WHEN 8 THEN TS.SUPP_NUM8
                    WHEN 9 THEN TS.SUPP_NUM9
                    WHEN 10 THEN TS.SUPP_NUM10
                    WHEN 11 THEN TS.SUPP_NUM11
                    ELSE TS.SUPP_NUM1
                  END, 0) AS INCOME_TAX_AMOUNT
        INTO V_TAX_AMOUNT
        FROM HRP_TAX_STANDARD TS
       WHERE TS.START_DATE              <= W_STD_DATE
         AND (TS.END_DATE IS NULL OR TS.END_DATE >= W_STD_DATE)
         AND TS.BEGIN_AMOUNT            <= NVL(W_TOTAL_AMOUNT, 0)
         AND TS.END_AMOUNT              > NVL(W_TOTAL_AMOUNT, 0)
         AND TS.SOB_ID                  = W_SOB_ID
         AND TS.ORG_ID                  = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Tax Amount Cal Error : ' || SQLERRM);
      V_TAX_AMOUNT := 0;
    END;
    V_TAX_AMOUNT := NVL(V_TAX_AMOUNT, 0) + NVL(V_AMOUNT, 0);
    RETURN V_TAX_AMOUNT;

  END TAX_AMOUNT_F;

-- 수당 한도 체크해서 한도 금액 리턴.
  FUNCTION LIMIT_AMOUNT_F
            ( W_STD_DATE          IN HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , W_ALLOWANCE_CODE    IN VARCHAR2
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_LIMIT_AMOUNT                NUMBER := 0;

  BEGIN
    BEGIN
      SELECT NVL(ALV.ALLOWANCE_LIMIT_AMOUNT, 0) AS ALLOWANCE_LIMIT_AMOUNT
        INTO V_LIMIT_AMOUNT
        FROM HRM_ALLOWANCE_LIMIT_V ALV
       WHERE ALV.ALLOWANCE_CODE   = W_ALLOWANCE_CODE
         AND ALV.SOB_ID           = W_SOB_ID
         AND ALV.ORG_ID           = W_ORG_ID
         AND ALV.ENABLED_FLAG     = 'Y'
         AND ALV.EFFECTIVE_DATE_FR  <= W_STD_DATE
         AND (ALV.EFFECTIVE_DATE_TO IS NULL OR ALV.EFFECTIVE_DATE_TO  >= W_STD_DATE)
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Limit Amount Cal Error(' || W_ALLOWANCE_CODE || ') :' || SQLERRM);
      V_LIMIT_AMOUNT := -1;
    END;
    RETURN V_LIMIT_AMOUNT;

  END LIMIT_AMOUNT_F;

---------------------------------------------------------------------------------------------------
-- 급상여 시작/종료 일자 조회.
  PROCEDURE PAYMENT_TERM
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PAY_TYPE          IN HRT_MONTH_PAYMENT.PAY_TYPE%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , O_START_DATE        OUT HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , O_END_DATE          OUT HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            )
  AS
  BEGIN
    SELECT ADD_MONTHS(TO_DATE(W_PAY_YYYYMM || '-' || PT.START_DAY, 'YYYY-MM-DD') + PT.START_ADD_DAY, PT.START_ADD_MONTH) AS START_DATE
         , ADD_MONTHS(TO_DATE(W_PAY_YYYYMM || '-' || PT.END_DAY, 'YYYY-MM-DD') + PT.END_ADD_DAY, PT.END_ADD_MONTH) AS END_DATE
      INTO O_START_DATE, O_END_DATE
      FROM HRM_PAYMENT_TERM_V PT
     WHERE PT.WAGE_TYPE               = W_WAGE_TYPE
       AND PT.PAY_TYPE                = W_PAY_TYPE
       AND PT.SOB_ID                  = W_SOB_ID
       AND PT.ORG_ID                  = W_ORG_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Payment Term Cal Error : ' || SQLERRM);
    O_START_DATE := TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'));
    O_END_DATE := LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'));
  END PAYMENT_TERM;


-- 급상여 처리 기준일자 반환.
  PROCEDURE DV_PAY_STANDARD_DATE_P
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , O_STANDARD_DATE     OUT HRT_MONTH_PAYMENT.STANDARD_DATE%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT ADD_MONTHS(TO_DATE(W_PAY_YYYYMM || '-' || PSD.STANDARD_DAY, 'YYYY-MM-DD') + PSD.STANDARD_ADD_DAY, PSD.STANDARD_ADD_MONTH) AS STANDARD_DATE
        INTO O_STANDARD_DATE
        FROM HRM_PAY_STANDARD_DATE_V PSD
       WHERE PSD.WAGE_TYPE        = W_WAGE_TYPE
         AND PSD.SOB_ID           = W_SOB_ID
         AND PSD.ORG_ID           = W_ORG_ID
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Pay Standard Date Cal Error : ' || SQLERRM);
      O_STANDARD_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END;

  END DV_PAY_STANDARD_DATE_P;

-- 급상여 지급 기준일자 반환.
  PROCEDURE DV_PAY_SUPPLY_DATE_P
            ( W_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            , O_SUPPLY_DATE       OUT HRT_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            )
  AS
  BEGIN
    BEGIN
      SELECT ADD_MONTHS(TO_DATE(W_PAY_YYYYMM || '-' || PSD.SUPPLY_DAY, 'YYYY-MM-DD') + PSD.SUPPLY_ADD_DAY, PSD.SUPPLY_ADD_MONTH) AS SUPPLY_DATE
        INTO O_SUPPLY_DATE
        FROM HRM_PAY_SUPPLY_DATE_V PSD
       WHERE PSD.WAGE_TYPE        = W_WAGE_TYPE
         AND PSD.SOB_ID           = W_SOB_ID
         AND PSD.ORG_ID           = W_ORG_ID
         AND ROWNUM               <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Pay Supply Date Cal Error : ' || SQLERRM);
      O_SUPPLY_DATE := GET_LOCAL_DATE(W_SOB_ID);
    END;

  END DV_PAY_SUPPLY_DATE_P;

-- 급여년월에 대한 평일근무일수 계산.
  FUNCTION WORK_DAY_COUNT_F
            ( P_PAY_YYYYMM        IN HRT_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_SOB_ID            IN HRT_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_WORK_DAY_COUNT      NUMBER := 0;
    N1                    NUMBER := 0;
  BEGIN
    /*--> 임시테이블 DATA 삭제 <--*/
    DELETE FROM HRD_WORK_DATE_GT;

    -- 월 달력 생성.
    N1 := P_END_DATE - P_START_DATE;
    FOR R1 IN 0 .. N1
    LOOP
     INSERT INTO HRD_WORK_DATE_GT
     (WORK_DATE, SOB_ID, ORG_ID)
     VALUES
     ( P_START_DATE + R1, P_SOB_ID, P_ORG_ID)
     ;
    END LOOP C1;
    
    BEGIN
      SELECT SUM(CASE
                   WHEN TO_CHAR(WC.WORK_DATE, 'D') IN ('1', '7') THEN 0
                   ELSE 1
                 END) AS WORK_DAY_COUNT
        INTO V_WORK_DAY_COUNT
        FROM HRD_WORK_DATE_GT WC
      WHERE WC.WORK_DATE            BETWEEN P_START_DATE AND P_END_DATE
        AND NOT EXISTS 
              ( SELECT 'X'
                  FROM HRD_HOLIDAY_CALENDAR HC
                WHERE HC.WORK_DATE    = WC.WORK_DATE
                  AND HC.SOB_ID       = WC.SOB_ID
                  AND HC.ORG_ID       = WC.ORG_ID
              )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_WORK_DAY_COUNT := N1 + 1;
    END;
    RETURN V_WORK_DAY_COUNT;
  END WORK_DAY_COUNT_F;

END HRT_PAYMENT_G_SET; 
/
