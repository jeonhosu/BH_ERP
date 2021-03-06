CREATE OR REPLACE PACKAGE HRP_MONTH_BONUS_G_SET
AS
--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

--  1. 급상여 처리 대상자 생성.
  PROCEDURE PAYMENT_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 41 상여금 생성
  PROCEDURE BONUS_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 46 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
            );

-- 46.1 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_101
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PAY_LEVEL         IN HRM_PAY_TYPE_V.PAY_LEVEL%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 46.2 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_102
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PAY_LEVEL         IN HRM_PAY_TYPE_V.PAY_LEVEL%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );
            
-- 3 기본급이외 기본자료 생성
  PROCEDURE ETC_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );
            
            
-- 47.1 지급율 계산.
  PROCEDURE PAYMENT_RATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );
            
-- 55. 고용보험 생성
  PROCEDURE UNEMPLOYMENT_INSURANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 56. 세금 생성
  PROCEDURE TAX_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );

--  91. 급상여 지급내역 삽입.
  PROCEDURE ALLOWANCE_INSERT
            ( P_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , P_CORP_ID           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT  IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE
            );

--  92. 급상여 공제내역 삽입.
  PROCEDURE DEDUCTION_INSERT
            ( P_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_DEDUCTION_ID      IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT  IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE
            );

END HRP_MONTH_BONUS_G_SET;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_BONUS_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_MONTH_BONUS_G_SET
/* DESCRIPTION  : 상여 계산/산출 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION      VERSION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE         1.0
/******************************************************************************/
-- 전역 상수값 정의.
  C_MONTH_BONUS                   CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P2';  -- 상여.
  C_FESTIVAL_BONUS                CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P3';  -- 명절귀성여비.
  C_SPECIAL_BONUS                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P5';  -- 특별상여.
  C_DUTY_MONTH                    CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'D2';  -- 월근태.


--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_RECORD_COUNT                NUMBER := 0;

    V_START_DATE                  HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE;
    V_END_DATE                    HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE;
    V_TOTAL_DAY                   NUMBER := 0;                                            -- 총일수.
  BEGIN
---------------------------------------------------------------------------
-- 0. 계산 적용 기간.
---------------------------------------------------------------------------
    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => P_PAY_YYYYMM
                      , W_WAGE_TYPE => P_WAGE_TYPE
                      , W_PAY_TYPE => P_PAY_TYPE
                      , W_SOB_ID => P_SOB_ID
                      , W_ORG_ID => P_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
    V_TOTAL_DAY := V_END_DATE - V_START_DATE + 1;

---------------------------------------------------------------------------
-- 1. 급상여 처리 대상 산출.
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 1.Payment Person List Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    PAYMENT_CREATION( P_CORP_ID => P_CORP_ID
                    , P_PAY_YYYYMM => P_PAY_YYYYMM
                    , P_START_DATE => V_START_DATE
                    , P_END_DATE => V_END_DATE
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
                    );

---------------------------------------------------------------------------
-- 41 상여금 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 41.Bonus Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  /*BONUS_PAY_CREATION( P_CORP_ID => P_CORP_ID
                    , P_PAY_YYYYMM => P_PAY_YYYYMM
                    , P_WAGE_TYPE => P_WAGE_TYPE
                    , P_PAY_TYPE => P_PAY_TYPE
                    , P_DEPT_ID => P_DEPT_ID
                    , P_PERSON_ID => P_PERSON_ID
                    , P_STD_DATE => P_STD_DATE
                    , P_EXCEPT_YN => P_EXCEPT_YN
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_USER_ID => P_USER_ID
                    );*/

---------------------------------------------------------------------------
-- 3. 기본급이외 기본자료 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 3.ETC Allowance/Deduction Amount Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    ETC_PAY_CREATION( P_CORP_ID => P_CORP_ID
                    , P_PAY_YYYYMM => P_PAY_YYYYMM
                    , P_START_DATE => V_START_DATE
                    , P_END_DATE => V_END_DATE
                    , P_WAGE_TYPE => P_WAGE_TYPE
                    , P_PAY_TYPE => P_PAY_TYPE
                    , P_DEPT_ID => P_DEPT_ID
                    , P_PERSON_ID => P_PERSON_ID
                    , P_STD_DATE => P_STD_DATE
                    , P_EXCEPT_YN => P_EXCEPT_YN
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_USER_ID => P_USER_ID
                    );
                    
---------------------------------------------------------------------------
-- 46 지급항목 일할계산 
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 46.Daily Pay Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  /*DAILY_PAY_CALCULATE ( P_CORP_ID => P_CORP_ID
                      , P_PAY_YYYYMM => P_PAY_YYYYMM
                      , P_WAGE_TYPE => P_WAGE_TYPE                      
                      , P_PAY_TYPE => P_PAY_TYPE
                      , P_DEPT_ID => P_DEPT_ID
                      , P_PERSON_ID => P_PERSON_ID
                      , P_STD_DATE => P_STD_DATE
                      , P_SOB_ID => P_SOB_ID                    
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      , P_TOTAL_DAY => V_TOTAL_DAY
                      );*/

---------------------------------------------------------------------------
-- 47 지급율 계산.
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 47.Daily Pay Rate Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
/*  PAYMENT_RATE
            ( P_CORP_ID => P_CORP_ID
            , P_PAY_YYYYMM => P_PAY_YYYYMM
            , P_WAGE_TYPE => P_WAGE_TYPE                      
            , P_PAY_TYPE => P_PAY_TYPE
            , P_DEPT_ID => P_DEPT_ID
            , P_PERSON_ID => P_PERSON_ID
            , P_STD_DATE => P_STD_DATE
            , P_EXCEPT_YN => P_EXCEPT_YN
            , P_SOB_ID => P_SOB_ID                    
            , P_ORG_ID => P_ORG_ID
            , P_USER_ID => P_USER_ID
            );
            */
---------------------------------------------------------------------------
-- 55. 고용보험 계산.
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 55.Unemployement Insurance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  UNEMPLOYMENT_INSURANCE
    ( O_STATUS => O_STATUS
    , O_MESSAGE => O_MESSAGE
    , P_CORP_ID => P_CORP_ID
    , P_PAY_YYYYMM => P_PAY_YYYYMM
    , P_WAGE_TYPE => P_WAGE_TYPE
    , P_PAY_TYPE => P_PAY_TYPE
    , P_DEPT_ID => P_DEPT_ID
    , P_PERSON_ID => P_PERSON_ID
    , P_EXCEPT_YN => P_EXCEPT_YN
    , P_SOB_ID => P_SOB_ID
    , P_ORG_ID => P_ORG_ID
    , P_USER_ID => P_USER_ID
    );

---------------------------------------------------------------------------
-- 82. 세금 계산.
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 56.Tax Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  TAX_CREATION
    ( O_STATUS => O_STATUS
    , O_MESSAGE => O_MESSAGE
    , P_CORP_ID => P_CORP_ID
    , P_PAY_YYYYMM => P_PAY_YYYYMM
    , P_WAGE_TYPE => P_WAGE_TYPE
    , P_PAY_TYPE => P_PAY_TYPE
    , P_DEPT_ID => P_DEPT_ID
    , P_PERSON_ID => P_PERSON_ID
    , P_EXCEPT_YN => P_EXCEPT_YN
    , P_SOB_ID => P_SOB_ID
    , P_ORG_ID => P_ORG_ID
    , P_USER_ID => P_USER_ID
    );

---------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 90.Payment Summary Update (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  PAYMENT_SUMMARY_UPDATE
    ( P_CORP_ID => P_CORP_ID
    , P_PAY_YYYYMM => P_PAY_YYYYMM
    , P_WAGE_TYPE => P_WAGE_TYPE
    , P_PAY_TYPE => P_PAY_TYPE
    , P_DEPT_ID => P_DEPT_ID
    , P_PERSON_ID => P_PERSON_ID
    , P_EXCEPT_YN => P_EXCEPT_YN
    , P_SOB_ID => P_SOB_ID
    , P_ORG_ID => P_ORG_ID
    );
  EXCEPTION
    WHEN ERRNUMS.DATA_NOT_OPENED THEN
      O_MESSAGE := ERRNUMS.DATA_NOT_OPENED_CODE || '.' || ERRNUMS.DATA_NOT_OPENED_DESC;
    WHEN ERRNUMS.DATA_CLOSED THEN
      O_MESSAGE := ERRNUMS.DATA_CLOSED_CODE || '.' || ERRNUMS.DATA_CLOSED_DESC;
  END PAYMENT_MAIN;

--  1. 급상여 처리 대상자 생성.
  PROCEDURE PAYMENT_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_MONTH_PAYMENT_ID            HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE;

    V_STRING                      VARCHAR2(2000);

    V_PAY_START_DATE              DATE;
    V_PAY_END_DATE                DATE;

    V_YEAR_START_COLUMN           VARCHAR2(100);
    V_YEAR_END_COLUMN             VARCHAR2(100);
    V_LONG_YEAR                   NUMBER;

    V_MONTH_START_COLUMN          VARCHAR2(100);
    V_MONTH_END_COLUMN            VARCHAR2(100);
    V_LONG_MONTH                  NUMBER;

    V_LONG_START_DATE             DATE;
    V_LONG_END_DATE               DATE;

  BEGIN
    -- 근속 년수 산출기준.
    SELECT PS.CAL_START_DATE
         , PS.CAL_END_DATE
      INTO V_YEAR_START_COLUMN
         , V_YEAR_END_COLUMN
      FROM HRM_PAYMENT_SET_V PS
      WHERE PS.COLUMN_CODE            = 'LONG_YEAR'
       AND PS.SOB_ID                  = P_SOB_ID
       AND PS.ORG_ID                  = P_ORG_ID
       AND PS.EFFECTIVE_DATE_FR       <= P_END_DATE
       AND (PS.EFFECTIVE_DATE_TO IS NULL OR PS.EFFECTIVE_DATE_TO >= P_START_DATE)
    ;

    -- 근속 월수 산출기준.
    SELECT PS.CAL_START_DATE
         , PS.CAL_END_DATE
      INTO V_MONTH_START_COLUMN
         , V_MONTH_END_COLUMN
      FROM HRM_PAYMENT_SET_V PS
      WHERE PS.COLUMN_CODE            = 'LONG_MONTH'
       AND PS.SOB_ID                  = P_SOB_ID
       AND PS.ORG_ID                  = P_ORG_ID
       AND PS.EFFECTIVE_DATE_FR       <= P_END_DATE
       AND (PS.EFFECTIVE_DATE_TO IS NULL OR PS.EFFECTIVE_DATE_TO >= P_START_DATE)
    ;

    -- 급상여 처리 대상자 산출을 위한 날짜 설정.
    BEGIN
      SELECT ADD_MONTHS(TO_DATE(P_PAY_YYYYMM || '-' || PCP.START_DAY, 'YYYY-MM-DD'), PCP.START_ADD_MONTH) + NVL(PCP.START_ADD_DAY, 0) AS PAY_START_DATE
           , ADD_MONTHS(TO_DATE(P_PAY_YYYYMM || '-' || PCP.END_DAY, 'YYYY-MM-DD'), PCP.END_ADD_MONTH) + NVL(PCP.END_ADD_DAY, 0) AS PAY_END_DATE
        INTO V_PAY_START_DATE, V_PAY_END_DATE
        FROM HRM_PAY_CALCULATE_PERIOD_V PCP
       WHERE PCP.WAGE_TYPE        = P_WAGE_TYPE
         AND PCP.SOB_ID           = P_SOB_ID
         AND PCP.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PAY_START_DATE := P_START_DATE;
      V_PAY_END_DATE := P_END_DATE;
    END;
    
    IF P_WAGE_TYPE IN(C_MONTH_BONUS, C_FESTIVAL_BONUS) THEN
    -- 상여 대상자 생성.
      FOR C1 IN ( SELECT PM.PERSON_ID
                       , PM.CORP_ID
                       , HL.DEPT_ID
                       , HL.POST_ID
                       , HL.OCPT_ID
                       , HL.ABIL_ID
                       , HL.JOB_CATEGORY_ID
                       , PMH.PAY_TYPE
                       , HL.PAY_GRADE_ID
                       , PMH.GRADE_STEP
                       , PM.ORI_JOIN_DATE
                       , PM.JOIN_DATE
                       , PM.PAY_DATE
                       , PM.EXPIRE_DATE
                       , PM.RETIRE_DATE
                       , PM.COST_CENTER_ID
                       , PM.DIR_INDIR_TYPE
                       , PM.EMPLOYE_TYPE
                       , CASE
                           WHEN NVL(PM.RETIRE_DATE, P_END_DATE) < P_END_DATE THEN 'R'
                           WHEN P_START_DATE < NVL(PM.JOIN_DATE, PM.ORI_JOIN_DATE) THEN 'I'                           
                           ELSE 'N'
                         END AS EXCEPT_TYPE
                       , NVL(PMH.HIRE_INSUR_YN, 'Y') AS HIRE_INSUR_YN
                       , PMH.SOB_ID
                       , PMH.ORG_ID
                       , 1 AS DED_PERSON_COUNT
                       , P_PAY_YYYYMM
                       , P_WAGE_TYPE
                       , P_SUPPLY_DATE
                       , P_STD_DATE AS STANDARD_DATE
                       , P_START_DATE AS START_DATE
                       , P_END_DATE AS END_DATE
                    FROM HRM_HISTORY_LINE HL
                      , HRM_PERSON_MASTER PM
                      , HRP_PAY_MASTER_HEADER PMH
                  WHERE HL.PERSON_ID        = PM.PERSON_ID
                    AND PM.PERSON_ID        = PMH.PERSON_ID
                    AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE            <= P_END_DATE
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
                    AND PMH.START_YYYYMM    <= P_PAY_YYYYMM
                    AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                    AND PM.CORP_ID          = P_CORP_ID
                    AND PM.PERSON_ID        = NVL(P_PERSON_ID, PM.PERSON_ID)
                    AND HL.DEPT_ID          = NVL(P_DEPT_ID, HL.DEPT_ID)
                    AND PM.JOIN_DATE        <= V_PAY_END_DATE  --V_PAY_START_DATE
                    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_PAY_END_DATE)
                    AND PM.SOB_ID           = P_SOB_ID
                    AND PM.ORG_ID           = P_ORG_ID
                    AND PMH.BONUS_PROVIDE_YN  = 'Y'
                    /*AND EXISTS  -- 급상여 추가공제에 있는 사람만 처리함.
                        ( SELECT 'X'
                            FROM HRP_PAYMENT_ADD_ALLOWANCE PAA
                          WHERE PAA.PERSON_ID       = PM.PERSON_ID
                            AND PAA.SOB_ID          = PM.SOB_ID
                            AND PAA.ORG_ID          = PM.ORG_ID
                            AND PAA.PAY_YYYYMM      = P_PAY_YYYYMM
                            AND PAA.WAGE_TYPE       = P_WAGE_TYPE                                                        
                        )*/
                  )
      LOOP
        -- 근속 년수 계산.
        IF V_YEAR_START_COLUMN = 'ORI_JOIN_DATE' THEN
          V_LONG_START_DATE := C1.ORI_JOIN_DATE;
        ELSIF V_YEAR_START_COLUMN = 'PAY_DATE' THEN
          V_LONG_START_DATE := C1.PAY_DATE;
        ELSIF V_YEAR_START_COLUMN = 'START_DATE' THEN
          V_LONG_START_DATE := C1.START_DATE;
        ELSIF V_YEAR_START_COLUMN = 'END_DATE' THEN
          V_LONG_START_DATE := C1.END_DATE;
        ELSIF V_YEAR_START_COLUMN = 'EXPIRE_DATE' THEN
          V_LONG_START_DATE := C1.EXPIRE_DATE;
        ELSIF V_YEAR_START_COLUMN = 'RETIRE_DATE' THEN
          V_LONG_START_DATE := C1.RETIRE_DATE;
        ELSE
          V_LONG_START_DATE := C1.JOIN_DATE;
        END IF;
        IF V_YEAR_END_COLUMN = 'ORI_JOIN_DATE' THEN
          V_LONG_END_DATE := C1.ORI_JOIN_DATE;
        ELSIF V_YEAR_END_COLUMN = 'PAY_DATE' THEN
          V_LONG_END_DATE := C1.PAY_DATE;
        ELSIF V_YEAR_END_COLUMN = 'START_DATE' THEN
          V_LONG_END_DATE := C1.START_DATE;
        ELSIF V_YEAR_END_COLUMN = 'END_DATE' THEN
          V_LONG_END_DATE := C1.END_DATE;
        ELSIF V_YEAR_END_COLUMN = 'EXPIRE_DATE' THEN
          V_LONG_END_DATE := C1.EXPIRE_DATE;
        ELSIF V_YEAR_END_COLUMN = 'RETIRE_DATE' THEN
          V_LONG_END_DATE := C1.RETIRE_DATE;
        ELSE
          V_LONG_END_DATE := C1.JOIN_DATE;
        END IF;
        -- 퇴직자 경우 퇴직일자로 적용.
        IF NVL(C1.RETIRE_DATE, V_LONG_END_DATE) < V_LONG_END_DATE THEN
          V_LONG_END_DATE := NVL(C1.RETIRE_DATE, V_LONG_END_DATE);
        END IF;
        V_LONG_YEAR := HRM_COMMON_DATE_G.YEAR_COUNT_F(V_LONG_START_DATE, V_LONG_END_DATE, 'TRUNC');
        -----
        -- 근속 월수 계산.
        IF V_MONTH_START_COLUMN = 'ORI_JOIN_DATE' THEN
          V_LONG_START_DATE := C1.ORI_JOIN_DATE;
        ELSIF V_MONTH_START_COLUMN = 'PAY_DATE' THEN
          V_LONG_START_DATE := C1.PAY_DATE;
        ELSIF V_MONTH_START_COLUMN = 'START_DATE' THEN
          V_LONG_START_DATE := C1.START_DATE;
        ELSIF V_MONTH_START_COLUMN = 'END_DATE' THEN
          V_LONG_START_DATE := C1.END_DATE;
        ELSIF V_MONTH_START_COLUMN = 'EXPIRE_DATE' THEN
          V_LONG_START_DATE := C1.EXPIRE_DATE;
        ELSIF V_MONTH_START_COLUMN = 'RETIRE_DATE' THEN
          V_LONG_START_DATE := C1.RETIRE_DATE;
        ELSE
          V_LONG_START_DATE := C1.JOIN_DATE;
        END IF;
        IF V_MONTH_END_COLUMN = 'ORI_JOIN_DATE' THEN
          V_LONG_END_DATE := C1.ORI_JOIN_DATE;
        ELSIF V_MONTH_END_COLUMN = 'PAY_DATE' THEN
          V_LONG_END_DATE := C1.PAY_DATE;
        ELSIF V_MONTH_END_COLUMN = 'START_DATE' THEN
          V_LONG_END_DATE := C1.START_DATE;
        ELSIF V_MONTH_END_COLUMN = 'END_DATE' THEN
          V_LONG_END_DATE := C1.END_DATE;
        ELSIF V_MONTH_END_COLUMN = 'EXPIRE_DATE' THEN
          V_LONG_END_DATE := C1.EXPIRE_DATE;
        ELSIF V_MONTH_END_COLUMN = 'RETIRE_DATE' THEN
          V_LONG_END_DATE := C1.RETIRE_DATE;
        ELSE
          V_LONG_END_DATE := C1.JOIN_DATE;
        END IF;
        -- 퇴직자 경우 퇴직일자로 적용.
        IF NVL(C1.RETIRE_DATE, V_LONG_END_DATE) < V_LONG_END_DATE THEN
          V_LONG_END_DATE := NVL(C1.RETIRE_DATE, V_LONG_END_DATE);
        END IF;
        V_LONG_MONTH := HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_LONG_START_DATE, V_LONG_END_DATE, 1, 0);
        -----

        SELECT HRP_MONTH_PAYMENT_S1.NEXTVAL
          INTO V_MONTH_PAYMENT_ID
          FROM DUAL;

        INSERT INTO HRP_MONTH_PAYMENT
        ( MONTH_PAYMENT_ID
        , PERSON_ID
        , PAY_YYYYMM
        , WAGE_TYPE
        , CORP_ID
        , DEPT_ID
        , POST_ID
        , OCPT_ID
        , ABIL_ID
        , JOB_CATEGORY_ID
        , PAY_TYPE
        , PAY_GRADE_ID
        , GRADE_STEP
        , COST_CENTER_ID
        , DIR_INDIR_TYPE
        , EMPLOYE_TYPE
        , EXCEPT_TYPE
        , HIRE_INSUR_YN
        , SUPPLY_DATE
        , STANDARD_DATE
        , LONG_YEAR
        , LONG_MONTH
        --, PAY_DAY
        , DED_PERSON_COUNT
        , SOB_ID
        , ORG_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY
        ) VALUES
        ( V_MONTH_PAYMENT_ID
        , C1.PERSON_ID
        , P_PAY_YYYYMM
        , P_WAGE_TYPE
        , C1.CORP_ID
        , C1.DEPT_ID
        , C1.POST_ID
        , C1.OCPT_ID
        , C1.ABIL_ID
        , C1.JOB_CATEGORY_ID
        , C1.PAY_TYPE
        , C1.PAY_GRADE_ID
        , C1.GRADE_STEP
        , C1.COST_CENTER_ID
        , C1.DIR_INDIR_TYPE
        , C1.EMPLOYE_TYPE
        , C1.EXCEPT_TYPE
        , C1.HIRE_INSUR_YN
        , TRUNC(P_SUPPLY_DATE)
        , TRUNC(P_STD_DATE)
        , V_LONG_YEAR
        , V_LONG_MONTH
        --, C1.PAY_DAY
        , C1.DED_PERSON_COUNT
        , C1.SOB_ID
        , C1.ORG_ID
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );

      END LOOP C1;
    END IF;
  END PAYMENT_CREATION;

-- 41 상여금 생성
  PROCEDURE BONUS_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_ALLOWANCE_ID                NUMBER;
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;

  BEGIN
    BEGIN
      SELECT HA.ALLOWANCE_ID
        INTO V_ALLOWANCE_ID
        FROM HRM_ALLOWANCE_V HA
       WHERE HA.ALLOWANCE_CODE    = 'A09'
         AND HA.SOB_ID            = P_SOB_ID
         AND HA.ORG_ID            = P_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RETURN;
    END;
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.DEPT_ID
                     , MP.POST_ID
                     , MP.OCPT_ID
                     , MP.ABIL_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , PT.PAY_LEVEL
                     , PT.DAY_RATE_METHOD
                     , MP.PAY_GRADE_ID
                     , PG.PAY_GRADE
                     , MP.EMPLOYE_TYPE
                     , MP.EXCEPT_TYPE
                     , MP.SUPPLY_DATE
                     , MP.STANDARD_DATE
                     , MP.LONG_YEAR
                     , MP.PAY_DAY
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PAY_TYPE_V PT
                    , HRM_PAY_GRADE_V PG
                 WHERE MP.PAY_TYPE                = PT.PAY_TYPE
                   AND MP.SOB_ID                  = PT.SOB_ID
                   AND MP.ORG_ID                  = PT.ORG_ID
                   AND MP.PAY_GRADE_ID            = PG.PAY_GRADE_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      -- 급여 마스터 - 지급/공제 항목 --
      FOR R1 IN ( SELECT PML.ALLOWANCE_TYPE
                       , PML.ALLOWANCE_ID
                       , PML.ALLOWANCE_AMOUNT
                    FROM HRP_PAY_MASTER_HEADER PMH
                      , HRP_PAY_MASTER_LINE PML
                   WHERE PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                     AND PMH.START_YYYYMM           <= C1.PAY_YYYYMM
                     AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= C1.PAY_YYYYMM)
                     AND PMH.PERSON_ID              = C1.PERSON_ID
                     AND PMH.CORP_ID                = C1.CORP_ID
                     AND PMH.SOB_ID                 = P_SOB_ID
                     AND PMH.ORG_ID                 = P_ORG_ID
                     AND PML.ENABLED_FLAG           = 'Y'
                     AND EXISTS ( SELECT 'X'
                                    FROM HRM_ALLOWANCE_V HA
                                   WHERE PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
                                     AND HA.ALLOWANCE_TYPE    = 'BASIC'
                                )
                 )
      LOOP
        V_ALLOWANCE_AMOUNT := 0;
        IF C1.PAY_GRADE IN('SA') THEN
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'YEAR' THEN
        -- 연봉--
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'MONTH' THEN
        -- 월급--
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'DAILY' THEN
        -- 일급--
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) / 8 * 209;
        ELSIF C1.PAY_LEVEL = 'TIME' THEN
        -- 시급--
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) * 209;
        END IF;
        IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
        -- 지급 항목 --
          ALLOWANCE_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_ALLOWANCE_ID => V_ALLOWANCE_ID
                          , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        END IF;
      END LOOP R1;
    END LOOP C1;

  END BONUS_PAY_CREATION;

-- 46 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS
    V_DIVISION_VALUE              NUMBER := 0;

  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.DEPT_ID
                     , MP.POST_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , PT.PAY_LEVEL
                     , PT.DAY_RATE_METHOD
                     , MP.PAY_GRADE_ID
                     , PG.PAY_GRADE
                     , MP.EMPLOYE_TYPE
                     , MP.EXCEPT_TYPE
                     , MP.SUPPLY_DATE
                     , MP.STANDARD_DATE
                     , MP.PAY_DAY
                     , NVL(DMT.STD_HOLY_0_COUNT, 0) AS STD_HOLY_0_COUNT
                     , NVL(DMT.HOLY_0_COUNT, 0) AS HOLY_0_COUNT
                     , NVL(DMT.HOLY_1_COUNT, 0) AS HOLY_1_COUNT
                     , NVL(DMT.HOLY_0_DED_FLAG, 0) AS HOLY_0_DED_FLAG
                     , NVL(DMT.CHANGE_DED_COUNT, 0) AS CHANGE_DED_COUNT
                     , NVL(DMT.WEEKLY_DED_COUNT, 0) AS WEEKLY_DED_COUNT
                     , NVL(DMT.TOTAL_ATT_DAY, 0) AS TOTAL_ATT_DAY
                     , NVL(DMT.TOTAL_DED_DAY, 0) AS TOTAL_DED_DAY
                     , NVL(DMT.TOTAL_DAY, 0) AS TOTAL_DAY
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PAY_TYPE_V PT
                    , HRM_PAY_GRADE_V PG
                    , ( SELECT MT.PERSON_ID
                             , MT.DUTY_YYYYMM
                             , MT.CORP_ID
                             , MT.SOB_ID
                             , MT.ORG_ID
                             , MT.STD_HOLY_0_COUNT
                             , MT.HOLY_0_COUNT
                             , MT.HOLY_1_COUNT
                             , MT.HOLY_0_DED_FLAG
                             , MT.CHANGE_DED_COUNT
                             , MT.WEEKLY_DED_COUNT
                             , MT.TOTAL_ATT_DAY
                             , MT.TOTAL_DED_DAY
                             , MT.TOTAL_DAY
                             , MT.PAY_DAY
                          FROM HRD_MONTH_TOTAL MT
                         WHERE MT.DUTY_YYYYMM         = P_PAY_YYYYMM
                           AND MT.PERSON_ID           = P_PERSON_ID
                           AND MT.CORP_ID             = P_CORP_ID
                           AND MT.SOB_ID              = P_SOB_ID
                           AND MT.ORG_ID              = P_ORG_ID
                           AND EXISTS ( SELECT 'X'
                                          FROM HRM_CLOSING_TYPE_V CT
                                        WHERE CT.CLOSING_TYPE   = MT.DUTY_TYPE
                                          AND CT.SOB_ID         = MT.SOB_ID
                                          AND CT.ORG_ID         = MT.ORG_ID
                                          AND CT.MODULE_TYPE    = 'DUTY'
                                          AND CT.PERIOD_TYPE    = 'MONTH'
                                      )
                        ) DMT
                 WHERE MP.PAY_TYPE                = PT.PAY_TYPE
                   AND MP.SOB_ID                  = PT.SOB_ID
                   AND MP.ORG_ID                  = PT.ORG_ID
                   AND MP.PAY_GRADE_ID            = PG.PAY_GRADE_ID
                   AND MP.PERSON_ID               = DMT.PERSON_ID(+)
                   AND MP.CORP_ID                 = DMT.CORP_ID(+)
                   AND MP.SOB_ID                  = DMT.SOB_ID(+)
                   AND MP.ORG_ID                  = DMT.ORG_ID(+)
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND PG.OFFICER_YN              <> 'Y'
                   AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      IF C1.DAY_RATE_METHOD = '102' THEN
        IF C1.EXCEPT_TYPE IN ('I', 'R') OR NVL(C1.TOTAL_DED_DAY, 0) > 0 THEN
          DAILY_PAY_CALCULATE_102( P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                                , P_CORP_ID => C1.CORP_ID
                                , P_PAY_YYYYMM => C1.PAY_YYYYMM
                                , P_WAGE_TYPE => C1.WAGE_TYPE
                                , P_TOTAL_DAY => P_TOTAL_DAY
                                , P_PAY_DAY => C1.PAY_DAY
                                , P_PAY_GRADE => C1.PAY_GRADE
                                , P_PAY_LEVEL => C1.PAY_LEVEL
                                , P_PERSON_ID => C1.PERSON_ID
                                , P_SOB_ID => P_SOB_ID
                                , P_ORG_ID => P_ORG_ID
                                , P_USER_ID => P_USER_ID
                                );
        END IF;
      /*ELSE
        IF C1.EXCEPT_TYPE IN ('I', 'R') OR NVL(C1.TOTAL_DED_DAY, 0) > 0 THEN
          V_DIVISION_VALUE := NVL(C1.TOTAL_DAY, 0) - NVL(C1.STD_HOLY_0_COUNT, 0);
          IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
            V_DIVISION_VALUE := P_TOTAL_DAY;
          END IF;
          DAILY_PAY_CALCULATE_101( P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                                , P_CORP_ID => C1.CORP_ID
                                , P_PAY_YYYYMM => C1.PAY_YYYYMM
                                , P_WAGE_TYPE => C1.WAGE_TYPE
                                , P_TOTAL_DAY => P_TOTAL_DAY
                                , P_PAY_DAY => C1.PAY_DAY
                                , P_PAY_GRADE => C1.PAY_GRADE
                                , P_PAY_LEVEL => C1.PAY_LEVEL
                                , P_PERSON_ID => C1.PERSON_ID
                                , P_SOB_ID => P_SOB_ID
                                , P_ORG_ID => P_ORG_ID
                                , P_USER_ID => P_USER_ID
                                );
        END IF;*/
      END IF;
      COMMIT;
    END LOOP C1;

  END DAILY_PAY_CALCULATE;

-- 46.1 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_101
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PAY_LEVEL         IN HRM_PAY_TYPE_V.PAY_LEVEL%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ALLOWANCE_AMOUNT            NUMBER := 0;

  BEGIN
    -- 기본급이외 항목 --
    FOR R1 IN ( SELECT MA.ALLOWANCE_ID
                     , MA.ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_ALLOWANCE  MA
                    , HRM_ALLOWANCE_V HA
                 WHERE MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                   AND MA.MONTH_PAYMENT_ID        = P_MONTH_PAYMENT_ID
                   AND MA.PERSON_ID               = P_PERSON_ID
                   AND MA.CORP_ID                 = P_CORP_ID
                   AND MA.SOB_ID                  = P_SOB_ID
                   AND MA.ORG_ID                  = P_ORG_ID
                   AND HA.DAY_YN                  = 'Y'
                   AND HA.ENABLED_FLAG            = 'Y'
                   AND HA.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                   AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                   AND NOT EXISTS ( SELECT 'X'
                                      FROM HRM_ALLOWANCE_V HA
                                     WHERE HA.ALLOWANCE_ID      = MA.ALLOWANCE_ID
                                       AND HA.ALLOWANCE_TYPE    = 'BASIC'
                                  )
               )
    LOOP
      V_ALLOWANCE_AMOUNT := 0;
      IF P_PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF P_PAY_LEVEL = 'YEAR' THEN
      -- 연봉--
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / P_TOTAL_DAY) * NVL(P_PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'MONTH' THEN
      -- 월급--
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / P_TOTAL_DAY) * NVL(P_PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'DAILY' THEN
      -- 일급--
        V_ALLOWANCE_AMOUNT :=(NVL(R1.ALLOWANCE_AMOUNT, 0) / P_TOTAL_DAY) * NVL(P_PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'TIME' THEN
      -- 시급--
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / 209) * (NVL(P_PAY_DAY, 0) * 8);
      END IF;
      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 지급 항목 --
        V_ALLOWANCE_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, V_ALLOWANCE_AMOUNT, 'PAYMENT');
        UPDATE HRP_MONTH_ALLOWANCE MA
          SET MA.ALLOWANCE_AMOUNT = V_ALLOWANCE_AMOUNT
            , MA.SOB_ID           = P_SOB_ID
            , MA.ORG_ID           = P_ORG_ID
            , MA.LAST_UPDATE_DATE = V_SYSDATE
            , MA.LAST_UPDATED_BY  = P_USER_ID
        WHERE MA.MONTH_PAYMENT_ID = P_MONTH_PAYMENT_ID
          AND MA.PERSON_ID        = P_PERSON_ID
          AND MA.ALLOWANCE_ID     = R1.ALLOWANCE_ID
          AND MA.SOB_ID           = P_SOB_ID
          AND MA.ORG_ID           = P_ORG_ID
        ;
      END IF;
    END LOOP R1;

  END DAILY_PAY_CALCULATE_101;

-- 46.2 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_102
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PAY_LEVEL         IN HRM_PAY_TYPE_V.PAY_LEVEL%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ALLOWANCE_AMOUNT            NUMBER := 0;

  BEGIN
    -- 기본급이외 항목 --
    FOR R1 IN ( SELECT MA.ALLOWANCE_ID
                     , MA.ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_ALLOWANCE  MA
                    , HRM_ALLOWANCE_V HA
                 WHERE MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                   AND MA.MONTH_PAYMENT_ID        = P_MONTH_PAYMENT_ID
                   AND MA.PERSON_ID               = P_PERSON_ID
                   AND MA.CORP_ID                 = P_CORP_ID
                   AND MA.SOB_ID                  = P_SOB_ID
                   AND MA.ORG_ID                  = P_ORG_ID
                   AND HA.DAY_YN                  = 'Y'
                   AND HA.ENABLED_FLAG            = 'Y'
                   AND HA.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                   AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                   AND NOT EXISTS ( SELECT 'X'
                                      FROM HRM_ALLOWANCE_V HA
                                     WHERE HA.ALLOWANCE_ID      = MA.ALLOWANCE_ID
                                       AND HA.ALLOWANCE_TYPE    = 'BASIC'
                                  )
               )
    LOOP
      V_ALLOWANCE_AMOUNT := 0;
      IF P_PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF P_PAY_LEVEL = 'YEAR' THEN
      -- 연봉--
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) / 30;
      ELSIF P_PAY_LEVEL = 'MONTH' THEN
      -- 월급--
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) / 30;
      ELSIF P_PAY_LEVEL = 'DAILY' THEN
      -- 일급--
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) / 8 * 209;
      ELSIF P_PAY_LEVEL = 'TIME' THEN
      -- 시급--
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) * 209;
      END IF;
      RAISE_APPLICATION_ERROR(-20001, V_ALLOWANCE_AMOUNT);
      /*IF P_PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF P_PAY_LEVEL = 'YEAR' THEN
      -- 연봉--
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / 30) * NVL(P_PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'MONTH' THEN
      -- 월급--
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / 30) * NVL(P_PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'DAILY' THEN
      -- 일급--
        V_ALLOWANCE_AMOUNT :=(NVL(R1.ALLOWANCE_AMOUNT, 0) / 8 * 209) * NVL(P_PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'TIME' THEN
      -- 시급--
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / 209) * (NVL(P_PAY_DAY, 0) * 8);
      END IF;*/
      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 지급 항목 --
        V_ALLOWANCE_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, V_ALLOWANCE_AMOUNT, 'PAYMENT');
        UPDATE HRP_MONTH_ALLOWANCE MA
          SET MA.ALLOWANCE_AMOUNT = V_ALLOWANCE_AMOUNT
            , MA.SOB_ID           = P_SOB_ID
            , MA.ORG_ID           = P_ORG_ID
            , MA.LAST_UPDATE_DATE = V_SYSDATE
            , MA.LAST_UPDATED_BY  = P_USER_ID
        WHERE MA.MONTH_PAYMENT_ID = P_MONTH_PAYMENT_ID
          AND MA.PERSON_ID        = P_PERSON_ID
          AND MA.ALLOWANCE_ID     = R1.ALLOWANCE_ID
          AND MA.SOB_ID           = P_SOB_ID
          AND MA.ORG_ID           = P_ORG_ID
        ;
      END IF;
    END LOOP R1;
    COMMIT;

  END DAILY_PAY_CALCULATE_102;

-- 3 기본급이외 기본자료 생성
  PROCEDURE ETC_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.DEPT_ID
                     , MP.POST_ID
                     , MP.OCPT_ID
                     , MP.ABIL_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.PAY_GRADE_ID
                     , MP.EMPLOYE_TYPE
                     , MP.EXCEPT_TYPE
                     , MP.SUPPLY_DATE
                     , MP.STANDARD_DATE
                     , MP.LONG_YEAR
                     , MP.PAY_DAY
                  FROM HRP_MONTH_PAYMENT MP
                 WHERE MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      -- 추가 지급 항목 --
      FOR R1 IN ( SELECT PAA.ALLOWANCE_ID
                       , SUM(PAA.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT
                    FROM HRP_PAYMENT_ADD_ALLOWANCE PAA
                   WHERE PAA.PAY_YYYYMM             = C1.PAY_YYYYMM
                     AND PAA.WAGE_TYPE              = C1.WAGE_TYPE
                     AND PAA.PERSON_ID              = C1.PERSON_ID
                     AND PAA.CORP_ID                = C1.CORP_ID
                     AND PAA.SOB_ID                 = P_SOB_ID
                     AND PAA.ORG_ID                 = P_ORG_ID
                  GROUP BY PAA.ALLOWANCE_ID
               )
      LOOP 
        -- 지급 항목 --
        ALLOWANCE_INSERT( P_PERSON_ID => C1.PERSON_ID
                        , P_PAY_YYYYMM => C1.PAY_YYYYMM
                        , P_WAGE_TYPE => C1.WAGE_TYPE
                        , P_CORP_ID => C1.CORP_ID
                        , P_ALLOWANCE_ID => R1.ALLOWANCE_ID
                        , P_ALLOWANCE_AMOUNT => NVL(R1.ALLOWANCE_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END LOOP R1;

      -- 추가 공제 항목 --
      FOR R1 IN ( SELECT PAD.DEDUCTION_ID
                       , PAD.DEDUCTION_AMOUNT
                  FROM HRP_PAYMENT_ADD_DEDUCTION PAD
                 WHERE PAD.PAY_YYYYMM             = C1.PAY_YYYYMM
                   AND PAD.WAGE_TYPE              = C1.WAGE_TYPE
                   AND PAD.PERSON_ID              = C1.PERSON_ID
                   AND PAD.CORP_ID                = C1.CORP_ID
                   AND PAD.SOB_ID                 = P_SOB_ID
                   AND PAD.ORG_ID                 = P_ORG_ID
               )
      LOOP 
        -- 공제 항목 --
          DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_DEDUCTION_ID => R1.DEDUCTION_ID
                          , P_DEDUCTION_AMOUNT => NVL(R1.DEDUCTION_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
      END LOOP R1;
    END LOOP C1;      
        
  END ETC_PAY_CREATION;
  
-- 47.1 지급율 계산.
  PROCEDURE PAYMENT_RATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    V_LONG_MONTH                  NUMBER;
    V_PAY_RATE                    NUMBER;
    V_PAY_RATE_FLAG               VARCHAR2(10);
    
  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.DEPT_ID
                     , MP.POST_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.PAY_GRADE_ID
                     , MP.EMPLOYE_TYPE
                     , MP.EXCEPT_TYPE
                     , MP.SUPPLY_DATE
                     , MP.STANDARD_DATE
                     , MP.LONG_YEAR
                     , MP.LONG_MONTH
                     , PM.JOIN_ID
                     , PM.ORI_JOIN_DATE
                     , PM.JOIN_DATE
                     , PM.PAY_DATE
                     , PM.RETIRE_DATE
                     , SX1.STD_START_DATE
                     , SX1.STD_END_DATE
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM    
                    , ( -- 근속월수 계산 기준.
                        SELECT DISTINCT PR.CORP_ID
                             , PR.WAGE_TYPE
                             /*, PR.JOIN_ID*/
                             , PR.PAY_TYPE
                             , MAX(PR.STD_START_DATE) AS STD_START_DATE
                             , MAX(PR.STD_END_DATE) AS STD_END_DATE
                          FROM HRP_PAYMENT_RULE PR
                        WHERE PR.CORP_ID                  = P_CORP_ID
                          AND PR.WAGE_TYPE                = P_WAGE_TYPE
                          AND PR.EFFECTIVE_YYYYMM_FR      <= P_PAY_YYYYMM
                          AND (PR.EFFECTIVE_YYYYMM_TO IS NULL OR PR.EFFECTIVE_YYYYMM_TO >= P_PAY_YYYYMM)
                        GROUP BY PR.CORP_ID
                             , PR.WAGE_TYPE
                             /*, PR.JOIN_ID*/
                             , PR.PAY_TYPE
                      ) SX1    
                WHERE MP.PERSON_ID                = PM.PERSON_ID
                  AND MP.CORP_ID                  = SX1.CORP_ID
                  AND MP.WAGE_TYPE                = SX1.WAGE_TYPE
                  AND MP.PAY_TYPE                 = SX1.PAY_TYPE
                  /*AND PM.JOIN_ID                  = SX1.JOIN_ID*/
                  AND MP.CORP_ID                  = P_CORP_ID
                  AND MP.PAY_YYYYMM               = P_PAY_YYYYMM
                  AND MP.WAGE_TYPE                = P_WAGE_TYPE
                  AND MP.PAY_TYPE                 = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                  AND MP.DEPT_ID                  = NVL(P_DEPT_ID, MP.DEPT_ID)
                  AND MP.PERSON_ID                = NVL(P_PERSON_ID, MP.PERSON_ID)
                  AND MP.SOB_ID                   = P_SOB_ID
                  AND MP.ORG_ID                   = P_ORG_ID         
                  AND (MP.EXCEPT_TYPE             = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                    OR MP.EXCEPT_TYPE             = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))                     
              )
    LOOP
      V_LONG_MONTH := 0;
      V_PAY_RATE := 0;
      V_PAY_RATE_FLAG := 'ALL';
      
      BEGIN
        SELECT PPR.PAYMENT_RATE
          INTO V_PAY_RATE 
          FROM HRP_PERSON_PAYMENT_RULE PPR
        WHERE PPR.PERSON_ID               = C1.PERSON_ID
          AND PPR.ENABLED_FLAG            = 'Y'
          AND PPR.EFFECTIVE_YYYYMM_FR     <= C1.PAY_YYYYMM
          AND (PPR.EFFECTIVE_YYYYMM_TO IS NULL OR PPR.EFFECTIVE_YYYYMM_TO >= C1.PAY_YYYYMM)
        ;
        V_PAY_RATE_FLAG := 'PERSON';
      EXCEPTION WHEN OTHERS THEN
        V_PAY_RATE_FLAG := 'ALL';
      END;
      
      IF V_PAY_RATE_FLAG = 'ALL' THEN
        -- 시작일자 설정.
        IF C1.STD_START_DATE = 'ORI_JOIN_DATE' THEN
          V_START_DATE := C1.ORI_JOIN_DATE;
        ELSIF C1.STD_START_DATE = 'PAY_DATE' THEN
          V_START_DATE := C1.PAY_DATE;
        ELSE
          V_START_DATE := C1.JOIN_DATE;
        END IF;
        
        -- 종료일자 설정.
        IF C1.STD_END_DATE = 'RETIRE_DATE' THEN
          V_END_DATE := C1.RETIRE_DATE;
        ELSIF C1.STD_START_DATE = 'SUPPLY_DATE' THEN
          V_END_DATE := C1.SUPPLY_DATE;
        ELSE
          V_END_DATE := C1.STANDARD_DATE;
        END IF;
        V_LONG_MONTH := HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_START_DATE, V_END_DATE, 1, 0);
        
        BEGIN
          SELECT NVL(MAX(PR.PAYMENT_RATE), 0) AS PAYMENT_RATE
            INTO V_PAY_RATE
            FROM HRP_PAYMENT_RULE PR
          WHERE PR.CORP_ID                  = C1.CORP_ID
            AND PR.WAGE_TYPE                = C1.WAGE_TYPE
            AND PR.PAY_TYPE                 = C1.PAY_TYPE
            AND PR.START_MONTH              <= V_LONG_MONTH
            AND PR.END_MONTH                >= V_LONG_MONTH
            AND PR.ENABLED_FLAG             = 'Y'
            AND PR.EFFECTIVE_YYYYMM_FR      <= C1.PAY_YYYYMM
            AND (PR.EFFECTIVE_YYYYMM_TO IS NULL OR PR.EFFECTIVE_YYYYMM_TO >= C1.PAY_YYYYMM)
          ;
        EXCEPTION WHEN OTHERS THEN
          V_PAY_RATE := 100;
        END;
      END IF;
      -- 지급율 적용.
      BEGIN
        UPDATE HRP_MONTH_ALLOWANCE MA 
          SET MA.ALLOWANCE_AMOUNT = DECIMAL_F(MA.SOB_ID, MA.ORG_ID, NVL(MA.ALLOWANCE_AMOUNT, 0) * (V_PAY_RATE / 100), 'PAYMENT')
        WHERE MA.MONTH_PAYMENT_ID     = C1.MONTH_PAYMENT_ID
          AND EXISTS ( SELECT 'X'
                         FROM HRM_ALLOWANCE_V HA
                       WHERE HA.ALLOWANCE_ID    = MA.ALLOWANCE_ID
                         AND HA.SOB_ID          = MA.SOB_ID
                         AND HA.ORG_ID          = MA.ORG_ID
                         AND HA.DAY_YN          = 'Y'
                     )
        ;
      END;
    END LOOP C1;
    COMMIT;
    
  END PAYMENT_RATE;
  
-- 55. 고용보험 생성
  PROCEDURE UNEMPLOYMENT_INSURANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_DEDUCTION_ID                NUMBER;
    V_INSUR_RATE                  NUMBER;
    V_INSUR_AMOUNT                NUMBER;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT MAX(HD.DEDUCTION_ID) AS DEDUCTION_ID
        INTO V_DEDUCTION_ID
        FROM HRM_DEDUCTION_V HD
       WHERE HD.DEDUCTION_TYPE    IN ('UI')
         AND HD.SOB_ID            = P_SOB_ID
         AND HD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Unemployement Insurance Deduction ID(TAX) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10114', NULL));
      RETURN;
    END;

    BEGIN
      IF P_PAY_YYYYMM < '2011-04' THEN
        V_INSUR_RATE := TO_NUMBER(NVL(HRM_COMMON_G.CODE_VALUE_F('INSUR_RATE', 'UI', 'VALUE2', P_SOB_ID, P_ORG_ID), 0));      
      ELSIF P_PAY_YYYYMM < '2011-07' THEN
        V_INSUR_RATE := TO_NUMBER(NVL(HRM_COMMON_G.CODE_VALUE_F('INSUR_RATE', 'UI_1', 'VALUE2', P_SOB_ID, P_ORG_ID), 0));     
      ELSE
        V_INSUR_RATE := TO_NUMBER(NVL(HRM_COMMON_G.CODE_VALUE_F('INSUR_RATE', 'UI_2', 'VALUE2', P_SOB_ID, P_ORG_ID), 0));
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_INSUR_RATE := 0;
      DBMS_OUTPUT.PUT_LINE('Insurace Rate(Unemployement Insurance Rate) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10137', NULL));
    END;

    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , NVL(SUM(DECODE(NVL(HA.UNEMPLOYEE_INSUR_YN, 'N'), 'Y', MA.ALLOWANCE_AMOUNT, 0)), 0) AS TOTAL_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_MONTH_ALLOWANCE MA
                    , HRM_ALLOWANCE_V HA
                 WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID(+)
                   AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID(+)
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.HIRE_INSUR_YN           = 'Y'
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
                GROUP BY MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
               )
    LOOP
      V_INSUR_AMOUNT := 0;
      V_INSUR_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(C1.TOTAL_AMOUNT, 0) * ( V_INSUR_RATE / 100 ), 'UNEMPLOY_INSUR');

      IF NVL(V_INSUR_AMOUNT,0) <> 0 THEN
        -- INSERT Unemployement Insurace Amount.
        DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                        , P_PAY_YYYYMM => C1.PAY_YYYYMM
                        , P_WAGE_TYPE => C1.WAGE_TYPE
                        , P_CORP_ID => C1.CORP_ID
                        , P_DEDUCTION_ID => V_DEDUCTION_ID
                        , P_DEDUCTION_AMOUNT => NVL(V_INSUR_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END IF;
    END LOOP C1;
    O_STATUS := 'S';
  END UNEMPLOYMENT_INSURANCE;

-- 56. 세금 생성
  PROCEDURE TAX_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_RESIDENT_TAX_RATE           NUMBER;
    V_TAX_AMOUNT                  NUMBER;

    V_TAX_DEDUCTION_ID            NUMBER;
    V_RESIDENT_DEDUCTION_ID       NUMBER;

  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT MAX(DECODE(HD.DEDUCTION_TYPE, 'TAX', HD.DEDUCTION_ID, NULL)) AS TAX_DEDUCTION_ID
           , MAX(DECODE(HD.DEDUCTION_TYPE, 'RESIDENT', HD.DEDUCTION_ID, NULL)) AS RESIDENT_DEDUCTION_ID
        INTO V_TAX_DEDUCTION_ID, V_RESIDENT_DEDUCTION_ID
        FROM HRM_DEDUCTION_V HD
       WHERE HD.DEDUCTION_TYPE    IN ('TAX', 'RESIDENT')
         AND HD.SOB_ID            = P_SOB_ID
         AND HD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Deduction ID(TAX) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10114', NULL));
    END;

    V_RESIDENT_TAX_RATE := HRM_COMMON_G.TAX_RATE_F( W_TAX_CODE => 'RESIDENT'
                                                  , W_SOB_ID => P_SOB_ID
                                                  , W_ORG_ID => P_ORG_ID
                                                  );

    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.STANDARD_DATE
                     , MP.DED_PERSON_COUNT
                     , NVL(MA1.ALLOWANCE_AMOUNT, 0)
                       - NVL(MD1.DEDUCTION_AMOUNT, 0) AS TAX_PAY_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , (SELECT MA.MONTH_PAYMENT_ID
                            , NVL(SUM(CASE 
                                        WHEN NVL(HA.TAX_FREE, 'N') = 'Y' THEN 0
                                        ELSE MA.ALLOWANCE_AMOUNT 
                                      END), 0) AS ALLOWANCE_AMOUNT
                        FROM HRP_MONTH_ALLOWANCE MA
                          , HRM_ALLOWANCE_V HA
                       WHERE MA.ALLOWANCE_ID      = HA.ALLOWANCE_ID
                         AND MA.PAY_YYYYMM        = P_PAY_YYYYMM
                         AND MA.WAGE_TYPE         = P_WAGE_TYPE
                         AND MA.CORP_ID           = P_CORP_ID
                         AND MA.SOB_ID            = P_SOB_ID
                         AND MA.ORG_ID            = P_ORG_ID
                       GROUP BY MA.MONTH_PAYMENT_ID
                      ) MA1
                    , (SELECT MD.MONTH_PAYMENT_ID
                            , NVL(SUM(CASE 
                                        WHEN HD.TAX_FREE IN('ANNU', 'MEDIC') THEN 0  -- MD.DEDUCTION_AMOUNT 
                                        ELSE 0 
                                      END), 0) AS DEDUCTION_AMOUNT
                         FROM HRP_MONTH_DEDUCTION MD
                           , HRM_DEDUCTION_V HD
                       WHERE MD.DEDUCTION_ID      = HD.DEDUCTION_ID
                         AND MD.PAY_YYYYMM        = P_PAY_YYYYMM
                         AND MD.WAGE_TYPE         = P_WAGE_TYPE
                         AND MD.CORP_ID           = P_CORP_ID
                         AND MD.SOB_ID            = P_SOB_ID
                         AND MD.ORG_ID            = P_ORG_ID
                       GROUP BY MD.MONTH_PAYMENT_ID
                       ) MD1
                 WHERE MP.MONTH_PAYMENT_ID        = MA1.MONTH_PAYMENT_ID(+)
                   AND MP.MONTH_PAYMENT_ID        = MD1.MONTH_PAYMENT_ID(+)
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_TAX_AMOUNT := 0;
      V_TAX_AMOUNT := HRP_PAYMENT_G_SET.TAX_AMOUNT_F( W_STD_DATE => C1.STANDARD_DATE
                                                    , W_TOTAL_AMOUNT => NVL(C1.TAX_PAY_AMOUNT, 0) * 3   -- 소득세 징수 위해 적용.
                                                    , W_SUPPORT_FAMILY => NVL(C1.DED_PERSON_COUNT, 1)
                                                    , W_SOB_ID => P_SOB_ID
                                                    , W_ORG_ID => P_ORG_ID
                                                    );

      IF NVL(V_TAX_AMOUNT,0) <> 0 THEN
        -- INSERT TAX.
        DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                        , P_PAY_YYYYMM => C1.PAY_YYYYMM
                        , P_WAGE_TYPE => C1.WAGE_TYPE
                        , P_CORP_ID => C1.CORP_ID
                        , P_DEDUCTION_ID => V_TAX_DEDUCTION_ID
                        , P_DEDUCTION_AMOUNT => NVL(V_TAX_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );

        IF NVL(V_RESIDENT_TAX_RATE, 0) > 0 THEN
        -- INSERT RESIDENT TAX.
          V_TAX_AMOUNT := TRUNC(NVL(V_TAX_AMOUNT, 0) * (V_RESIDENT_TAX_RATE / 100));
          DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_DEDUCTION_ID => V_RESIDENT_DEDUCTION_ID
                          , P_DEDUCTION_AMOUNT => NVL(V_TAX_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        END IF;
      END IF;
    END LOOP C1;
    O_STATUS := 'S';
  END TAX_CREATION;

---------------------------------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.DEPT_ID
                     , MP.PAY_TYPE
                  FROM HRP_MONTH_PAYMENT MP
                 WHERE MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      -- 지급 항목 합계 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.BONUS_AMOUNT, MP.TOT_SUPPLY_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS BONUS_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
                  , HRM_ALLOWANCE_V HA
               WHERE MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                 AND MA.SOB_ID                  = HA.SOB_ID
                 AND MA.ORG_ID                  = HA.ORG_ID
                 AND MA.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MA.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = C1.MONTH_PAYMENT_ID
      ;

      -- 공제 항목 합계 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.DED_BONUS_AMOUNT, MP.TOT_DED_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DED_BONUS_AMOUNT
                   , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
                   , NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_DEDUCTION MD
                  , HRM_CLOSING_TYPE_V CT
               WHERE MD.WAGE_TYPE               = CT.CLOSING_TYPE
                 AND MD.SOB_ID                  = CT.SOB_ID
                 AND MD.ORG_ID                  = CT.ORG_ID
                 AND MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MD.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = C1.MONTH_PAYMENT_ID
      ;
      -- 실지급액 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.REAL_AMOUNT        = CASE
                                      WHEN NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(MP.TOT_DED_AMOUNT, 0) < 0 THEN 0
                                      ELSE NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(MP.TOT_DED_AMOUNT, 0)
                                    END
      WHERE MP.MONTH_PAYMENT_ID   = C1.MONTH_PAYMENT_ID
      ;
    END LOOP C1;
    
    -- 금액이 없으면 삭제.
    DELETE HRP_MONTH_PAYMENT MP
    WHERE MP.PAY_YYYYMM              = P_PAY_YYYYMM
      AND MP.WAGE_TYPE               = P_WAGE_TYPE
      AND MP.CORP_ID                 = P_CORP_ID
      AND MP.SOB_ID                  = P_SOB_ID
      AND MP.ORG_ID                  = P_ORG_ID
      AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
      AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
      AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
      AND (MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
       OR MP.EXCEPT_TYPE            = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
      AND (NOT EXISTS
            ( SELECT 'X'
                FROM HRP_MONTH_ALLOWANCE MA
              WHERE MA.MONTH_PAYMENT_ID  = MP.MONTH_PAYMENT_ID
             )
      AND  NOT EXISTS
             ( SELECT 'X'
                FROM HRP_MONTH_DEDUCTION MD
              WHERE MD.MONTH_PAYMENT_ID  = MP.MONTH_PAYMENT_ID
             ))
    ;
  END PAYMENT_SUMMARY_UPDATE;

--  91. 급상여 지급내역 삽입.
  PROCEDURE ALLOWANCE_INSERT
            ( P_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , P_CORP_ID           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT  IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN
    BEGIN
      V_ALLOWANCE_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, P_ALLOWANCE_AMOUNT, 'PAYMENT');
      INSERT INTO HRP_MONTH_ALLOWANCE
      ( PERSON_ID
      , PAY_YYYYMM
      , WAGE_TYPE
      , CORP_ID
      , ALLOWANCE_ID
      , ALLOWANCE_AMOUNT
      , MONTH_PAYMENT_ID
      , SOB_ID
      , ORG_ID
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY )
      VALUES
      ( P_PERSON_ID
      , P_PAY_YYYYMM
      , P_WAGE_TYPE
      , P_CORP_ID
      , P_ALLOWANCE_ID
      , V_ALLOWANCE_AMOUNT
      , P_MONTH_PAYMENT_ID
      , P_SOB_ID
      , P_ORG_ID
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
      UPDATE HRP_MONTH_ALLOWANCE MA
          SET MA.ALLOWANCE_AMOUNT = NVL(MA.ALLOWANCE_AMOUNT, 0) + NVL(V_ALLOWANCE_AMOUNT, 0)
       WHERE MA.PERSON_ID         = P_PERSON_ID
         AND MA.PAY_YYYYMM        = P_PAY_YYYYMM
         AND MA.WAGE_TYPE         = P_WAGE_TYPE
         AND MA.CORP_ID           = P_CORP_ID
         AND MA.ALLOWANCE_ID      = P_ALLOWANCE_ID
         AND MA.SOB_ID            = P_SOB_ID
         AND MA.ORG_ID            = P_ORG_ID
      ;
    END;

  END ALLOWANCE_INSERT;

--  92. 급상여 공제내역 삽입.
  PROCEDURE DEDUCTION_INSERT
            ( P_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_DEDUCTION_ID      IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT  IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_DEDUCTION_AMOUNT            NUMBER := 0;
  BEGIN
    BEGIN
      V_DEDUCTION_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, P_DEDUCTION_AMOUNT, 'PAYMENT');
      INSERT INTO HRP_MONTH_DEDUCTION
      ( PERSON_ID
      , PAY_YYYYMM
      , WAGE_TYPE
      , CORP_ID
      , DEDUCTION_ID
      , DEDUCTION_AMOUNT
      , MONTH_PAYMENT_ID
      , SOB_ID
      , ORG_ID
      , CREATION_DATE
      , CREATED_BY
      , LAST_UPDATE_DATE
      , LAST_UPDATED_BY )
      VALUES
      ( P_PERSON_ID
      , P_PAY_YYYYMM
      , P_WAGE_TYPE
      , P_CORP_ID
      , P_DEDUCTION_ID
      , V_DEDUCTION_AMOUNT
      , P_MONTH_PAYMENT_ID
      , P_SOB_ID
      , P_ORG_ID
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID
      );
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
      UPDATE HRP_MONTH_DEDUCTION MD
          SET MD.DEDUCTION_AMOUNT = NVL(MD.DEDUCTION_AMOUNT, 0) + NVL(V_DEDUCTION_AMOUNT, 0)
       WHERE MD.PERSON_ID         = P_PERSON_ID
         AND MD.PAY_YYYYMM        = P_PAY_YYYYMM
         AND MD.WAGE_TYPE         = P_WAGE_TYPE
         AND MD.CORP_ID           = P_CORP_ID
         AND MD.DEDUCTION_ID      = P_DEDUCTION_ID
         AND MD.SOB_ID            = P_SOB_ID
         AND MD.ORG_ID            = P_ORG_ID
      ;
    END;
  END DEDUCTION_INSERT;

END HRP_MONTH_BONUS_G_SET;
/
