CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_G_SET
AS
--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
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
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 2 급여 기본급 생성
  PROCEDURE BASIC_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
            );

-- 2.1 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_101
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
            );

-- 2.2 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_102
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
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
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 11 근속수당 생성
  PROCEDURE LONG_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 12 통상시급수당 생성
  PROCEDURE GENERAL_HOURLY_AMOUNT
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 16 가족수당 생성
  PROCEDURE FAMILY_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 21 근태수당 생성
  PROCEDURE DUTY_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
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

-- 51. 건강보험/국민연금 생성
  PROCEDURE PENSION_HEALTH_INSURANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 55. 고용보험 생성
  PROCEDURE UNEMPLOYMENT_INSURANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 56. 세금 생성
  PROCEDURE TAX_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 71 관리직 특근수당 생성
  PROCEDURE MANAGEMENT_HOLIDAY_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WORK_DATE_FR      IN DATE
            , P_WORK_DATE_TO      IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 72 생산장려수당.
  PROCEDURE OT_RATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_STD_TIME          IN NUMBER
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE            
            );

-- 73 자기개발수당.
  PROCEDURE AGE_OVER
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_AGE               IN NUMBER
            , P_SEX_TYPE          IN VARCHAR2
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );

-- 74 복지수당 적용 여부.
  FUNCTION  WORKING_RATE_F
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_DUTY_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN VARCHAR2;

---------------------------------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
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

-- 92. 지급내역 삭제.
  PROCEDURE ALLOWANCE_DELETE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
--  93. 급상여 공제내역 삽입.
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

-- 93. 급여 마스터 반영.
  PROCEDURE PAY_MASTER_LINE_INSERT
            ( P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_PERSON_ID         IN NUMBER
            , P_ALLOWANCE_TYPE    IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT  IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE
            );

END HRP_MONTH_PAYMENT_G_SET; 
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_G_SET
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_MONTH_PAYMENT_G_SET
/* DESCRIPTION  : 급상여 계산/산출 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION      VERSION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE         1.0
/******************************************************************************/
-- 전역 상수값 정의.
  C_MONTH_PAYMENT                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P1';  -- 급여.
  C_MONTH_BONUS                   CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P2';  -- 상여.
  C_FESTIVAL_BONUS                CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P3';  -- 명절귀성여비.
  C_DANGJIK_PAYMENT               CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P4';  -- 당직비.
  C_SPECIAL_BONUS                 CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P5';  -- 특별상여.
  C_DUTY_MONTH                    CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'D2';  -- 월근태.


--  0. PAYMENT CALCULATE MAIN.
  PROCEDURE PAYMENT_MAIN
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SUPPLY_DATE       IN HRP_MONTH_PAYMENT.SUPPLY_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_MESSAGE                     VARCHAR2(250) := NULL;
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
DBMS_OUTPUT.PUT_LINE('--- 1.Payment Person List Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
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
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_USER_ID => P_USER_ID
                    );

---------------------------------------------------------------------------
-- 2. 급여 기본자료 생성(급여 마스터 - 지급/공제 항목, 추가 급상여 - 지급/공제 사항)
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 2.Payment Allowance/Deduction Amount Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    BASIC_PAY_CREATION( P_CORP_ID => P_CORP_ID
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
                      );

---------------------------------------------------------------------------
-- 3. 기본급이외 기본자료 생성
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 3.ETC Allowance/Deduction Amount Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    ETC_PAY_CREATION( P_CORP_ID => P_CORP_ID
                    , P_PAY_YYYYMM => P_PAY_YYYYMM
                    , P_START_DATE => V_START_DATE
                    , P_END_DATE => V_END_DATE
                    , P_WAGE_TYPE => P_WAGE_TYPE
                    , P_PAY_TYPE => P_PAY_TYPE
                    , P_DEPT_ID => P_DEPT_ID
                    , P_PERSON_ID => P_PERSON_ID
                    , P_STD_DATE => P_STD_DATE
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_USER_ID => P_USER_ID
                    );

---------------------------------------------------------------------------
-- 11 근속수당 생성
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 11.Long Allowance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    LONG_ALLOWANCE( P_CORP_ID => P_CORP_ID
                  , P_PAY_YYYYMM => P_PAY_YYYYMM
                  , P_WAGE_TYPE => P_WAGE_TYPE
                  , P_PAY_TYPE => P_PAY_TYPE
                  , P_DEPT_ID => P_DEPT_ID
                  , P_PERSON_ID => P_PERSON_ID
                  , P_STD_DATE => P_STD_DATE
                  , P_SOB_ID => P_SOB_ID
                  , P_ORG_ID => P_ORG_ID
                  , P_USER_ID => P_USER_ID
                  );

---------------------------------------------------------------------------
-- 12 통상시급수당 생성
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 12.General Hourly Amount Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    GENERAL_HOURLY_AMOUNT( P_CORP_ID => P_CORP_ID
                          , P_PAY_YYYYMM => P_PAY_YYYYMM
                          , P_WAGE_TYPE => P_WAGE_TYPE
                          , P_PAY_TYPE => P_PAY_TYPE
                          , P_DEPT_ID => P_DEPT_ID
                          , P_PERSON_ID => P_PERSON_ID
                          , P_STD_DATE => P_STD_DATE
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );

---------------------------------------------------------------------------
-- 16 가족수당 생성
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 16.Family Allowance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    FAMILY_ALLOWANCE( P_CORP_ID => P_CORP_ID
                    , P_PAY_YYYYMM => P_PAY_YYYYMM
                    , P_WAGE_TYPE => P_WAGE_TYPE
                    , P_PAY_TYPE => P_PAY_TYPE
                    , P_DEPT_ID => P_DEPT_ID
                    , P_PERSON_ID => P_PERSON_ID
                    , P_STD_DATE => P_STD_DATE
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_USER_ID => P_USER_ID
                    );

---------------------------------------------------------------------------
-- 21 근태수당 생성
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 21.Duty Allowance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    DUTY_ALLOWANCE( P_CORP_ID => P_CORP_ID
                  , P_PAY_YYYYMM => P_PAY_YYYYMM
                  , P_WAGE_TYPE => P_WAGE_TYPE
                  , P_PAY_TYPE => P_PAY_TYPE
                  , P_DEPT_ID => P_DEPT_ID
                  , P_PERSON_ID => P_PERSON_ID
                  , P_STD_DATE => P_STD_DATE
                  , P_SOB_ID => P_SOB_ID
                  , P_ORG_ID => P_ORG_ID
                  , P_USER_ID => P_USER_ID
                  );

---------------------------------------------------------------------------
-- 41 상여금 생성
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 41.Bonus Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  BONUS_PAY_CREATION( P_CORP_ID => P_CORP_ID
                    , P_PAY_YYYYMM => P_PAY_YYYYMM
                    , P_WAGE_TYPE => P_WAGE_TYPE
                    , P_PAY_TYPE => P_PAY_TYPE
                    , P_DEPT_ID => P_DEPT_ID
                    , P_PERSON_ID => P_PERSON_ID
                    , P_STD_DATE => P_STD_DATE
                    , P_SOB_ID => P_SOB_ID
                    , P_ORG_ID => P_ORG_ID
                    , P_USER_ID => P_USER_ID
                    );

---------------------------------------------------------------------------
-- 46 지급항목 일할계산
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 46.Daily Pay Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  DAILY_PAY_CALCULATE ( P_CORP_ID => P_CORP_ID
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
                      );

---------------------------------------------------------------------------
-- 51. 국민/건강보험 계산.
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 51.Pension/Health Insurance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  PENSION_HEALTH_INSURANCE( P_CORP_ID => P_CORP_ID
                          , P_PAY_YYYYMM => P_PAY_YYYYMM
                          , P_WAGE_TYPE => P_WAGE_TYPE
                          , P_PAY_TYPE => P_PAY_TYPE
                          , P_DEPT_ID => P_DEPT_ID
                          , P_PERSON_ID => P_PERSON_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );

---------------------------------------------------------------------------
-- 55. 고용보험 계산.
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 55.Unemployement Insurance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  UNEMPLOYMENT_INSURANCE( P_CORP_ID => P_CORP_ID
                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                        , P_WAGE_TYPE => P_WAGE_TYPE
                        , P_PAY_TYPE => P_PAY_TYPE
                        , P_DEPT_ID => P_DEPT_ID
                        , P_PERSON_ID => P_PERSON_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );

---------------------------------------------------------------------------
-- 82. 세금 계산.
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 56.Tax Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  TAX_CREATION( P_CORP_ID => P_CORP_ID
              , P_PAY_YYYYMM => P_PAY_YYYYMM
              , P_WAGE_TYPE => P_WAGE_TYPE
              , P_PAY_TYPE => P_PAY_TYPE
              , P_DEPT_ID => P_DEPT_ID
              , P_PERSON_ID => P_PERSON_ID
              , P_SOB_ID => P_SOB_ID
              , P_ORG_ID => P_ORG_ID
              , P_USER_ID => P_USER_ID
              );

---------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
---------------------------------------------------------------------------
DBMS_OUTPUT.PUT_LINE('--- 90.Payment Summary Update (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
  PAYMENT_SUMMARY_UPDATE( P_CORP_ID => P_CORP_ID
                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                        , P_WAGE_TYPE => P_WAGE_TYPE
                        , P_PAY_TYPE => P_PAY_TYPE
                        , P_DEPT_ID => P_DEPT_ID
                        , P_PERSON_ID => P_PERSON_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        );

    O_MESSAGE := V_MESSAGE;

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

    IF P_WAGE_TYPE = C_MONTH_PAYMENT THEN
    -- 급여 대상자 생성.
      FOR C1 IN ( SELECT PM.PERSON_ID
                       , PM.CORP_ID
                       , HL.DEPT_ID
                       , HL.POST_ID
                       , HL.OCPT_ID
                       , HL.ABIL_ID
                       , HL.JOB_CATEGORY_ID
                       , PMH.PAY_TYPE
                       , PMH.PAY_GRADE_ID
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
                           WHEN P_START_DATE < NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) THEN 'I'
                           WHEN NVL(PM.RETIRE_DATE, P_END_DATE) < P_END_DATE THEN 'R'
                           ELSE 'N'
                         END AS EXCEPT_TYPE
                       , PMH.SOB_ID
                       , PMH.ORG_ID
                       , P_PAY_YYYYMM
                       , P_WAGE_TYPE
                       , P_SUPPLY_DATE
                       , P_STD_DATE AS STANDARD_DATE
                       , P_START_DATE AS START_DATE
                       , P_END_DATE AS END_DATE
                       , NVL(S_MT.PAY_DAY, 0) AS PAY_DAY
                    FROM HRM_HISTORY_LINE HL
                      , HRM_PERSON_MASTER PM
                      , HRP_PAY_MASTER_HEADER PMH
                      , (-- 월근태 내역.
                          SELECT MT.PERSON_ID
                               , MT.DUTY_YYYYMM
                               , MT.CORP_ID
                               , MT.SOB_ID
                               , MT.ORG_ID
                               , MT.PAY_DAY
                            FROM HRD_MONTH_TOTAL MT
                           WHERE MT.DUTY_YYYYMM             = P_PAY_YYYYMM
                             AND MT.DUTY_TYPE               = C_DUTY_MONTH
                             AND MT.CORP_ID                 = P_CORP_ID
                             AND MT.DEPT_ID                 = NVL(P_DEPT_ID, MT.DEPT_ID)
                             AND MT.PERSON_ID               = NVL(P_PERSON_ID, MT.PERSON_ID)
                             AND MT.SOB_ID                  = P_SOB_ID
                             AND MT.ORG_ID                  = P_ORG_ID
                        ) S_MT
                  WHERE HL.PERSON_ID        = PM.PERSON_ID
                    AND PM.PERSON_ID        = PMH.PERSON_ID
                    AND PM.PERSON_ID        = S_MT.PERSON_ID(+)
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
                    AND PM.ORI_JOIN_DATE    <= V_PAY_END_DATE
                    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_PAY_START_DATE)
                    AND PM.SOB_ID           = P_SOB_ID
                    AND PM.ORG_ID           = P_ORG_ID
                    AND PMH.PAY_PROVIDE_YN  = 'Y'
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
        , SUPPLY_DATE
        , STANDARD_DATE
        , LONG_YEAR
        , LONG_MONTH
        , PAY_DAY
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
        , P_SUPPLY_DATE
        , P_STD_DATE
        , V_LONG_YEAR
        , V_LONG_MONTH
        , C1.PAY_DAY
        , C1.SOB_ID
        , C1.ORG_ID
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID
        );

      END LOOP C1;

      -- 근태정보 UPDATE.
/*      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.PAY_DAY
       WHERE
      */
    END IF;
    COMMIT;

  END PAYMENT_CREATION;

-- 2 급여 기본자료 생성(급여 마스터 - 지급/공제 항목, 추가 급상여 - 지급/공제 사항)
  PROCEDURE BASIC_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
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
                     , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                     , PM.RETIRE_DATE
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
                    , HRM_PERSON_MASTER PM
                    , HRM_PAY_TYPE_V PT
                    , HRM_PAY_GRADE_V PG
                 WHERE MP.PERSON_ID               = PM.PERSON_ID
                   AND MP.PAY_TYPE                = PT.PAY_TYPE
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
               )
    LOOP
      IF C1.DAY_RATE_METHOD = '102' THEN
        BASIC_PAY_AMOUNT_102( P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                            , P_CORP_ID => C1.CORP_ID
                            , P_PAY_YYYYMM => C1.PAY_YYYYMM
                            , P_WAGE_TYPE => C1.WAGE_TYPE
                            , P_EXCEPT_TYPE => C1.EXCEPT_TYPE
                            , P_PAY_LEVEL => C1.PAY_LEVEL
                            , P_PAY_GRADE => C1.PAY_GRADE
                            , P_PERSON_ID => C1.PERSON_ID
                            , P_SOB_ID => P_SOB_ID
                            , P_ORG_ID => P_ORG_ID
                            , P_USER_ID => P_USER_ID
                            , P_TOTAL_DAY => P_TOTAL_DAY
                            );
      ELSE
        BASIC_PAY_AMOUNT_101( P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                            , P_CORP_ID => C1.CORP_ID
                            , P_PAY_YYYYMM => C1.PAY_YYYYMM
                            , P_WAGE_TYPE => C1.WAGE_TYPE
                            , P_EXCEPT_TYPE => C1.EXCEPT_TYPE
                            , P_PAY_LEVEL => C1.PAY_LEVEL
                            , P_PAY_GRADE => C1.PAY_GRADE
                            , P_PERSON_ID => C1.PERSON_ID
                            , P_SOB_ID => P_SOB_ID
                            , P_ORG_ID => P_ORG_ID
                            , P_USER_ID => P_USER_ID
                            , P_TOTAL_DAY => P_TOTAL_DAY
                            );
      END IF;
      COMMIT;
    END LOOP C1;

  END BASIC_PAY_CREATION;

-- 2.1 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_101
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;
    V_DIVISION_VALUE              NUMBER;
    V_HOLIDAY_ALLOWANCE_ID        NUMBER;
    
  BEGIN
    -- 급여 마스터 - 기본급 항목 --
    FOR R1 IN ( SELECT PML.ALLOWANCE_TYPE
                     , PML.ALLOWANCE_ID
                     , PML.ALLOWANCE_AMOUNT
                     , NVL(DMT.STD_HOLY_0_COUNT, 0) AS STD_HOLY_0_COUNT
                     , NVL(DMT.HOLY_0_COUNT, 0) AS HOLY_0_COUNT
                     , NVL(DMT.HOLY_1_COUNT, 0) AS HOLY_1_COUNT
                     , NVL(DMT.HOLY_0_DED_FLAG, 0) AS HOLY_0_DED_FLAG
                     , NVL(DMT.CHANGE_DED_COUNT, 0) AS CHANGE_DED_COUNT
                     , NVL(DMT.WEEKLY_DED_COUNT, 0) AS WEEKLY_DED_COUNT
                     , NVL(DMT.TOTAL_ATT_DAY, 0) AS TOTAL_ATT_DAY
                     , NVL(DMT.TOTAL_DED_DAY, 0) AS TOTAL_DED_DAY
                     , NVL(DMT.TOTAL_DAY, 0) AS TOTAL_DAY
                     , NVL(DMT.PAY_DAY, 0) AS PAY_DAY
                  FROM HRP_PAY_MASTER_HEADER PMH
                    , HRP_PAY_MASTER_LINE PML
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
                 WHERE PMH.PERSON_ID              = DMT.PERSON_ID(+)
                   AND PMH.CORP_ID                = DMT.CORP_ID(+)
                   AND PMH.SOB_ID                 = DMT.SOB_ID(+)
                   AND PMH.ORG_ID                 = DMT.ORG_ID(+)
                   AND PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                   AND PMH.START_YYYYMM           <= P_PAY_YYYYMM
                   AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                   AND PMH.PERSON_ID              = P_PERSON_ID
                   AND PMH.CORP_ID                = P_CORP_ID
                   AND PMH.SOB_ID                 = P_SOB_ID
                   AND PMH.ORG_ID                 = P_ORG_ID
                   AND PML.ENABLED_FLAG           = 'Y'
                   AND EXISTS ( SELECT 'X'
                                  FROM HRM_ALLOWANCE_V HA
                                 WHERE HA.ALLOWANCE_ID      = PML.ALLOWANCE_ID
                                   AND HA.ALLOWANCE_TYPE    = 'BASIC'
                              )
               )
    LOOP
      V_ALLOWANCE_AMOUNT := 0;
      IF P_PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
      ELSIF P_PAY_LEVEL = 'YEAR' THEN
      -- 연봉--
        V_DIVISION_VALUE := NVL(R1.TOTAL_DAY, 0) - NVL(R1.STD_HOLY_0_COUNT, 0);
        IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
          V_DIVISION_VALUE := P_TOTAL_DAY;
        END IF;
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * NVL(R1.PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'MONTH' THEN
      -- 월급--
        V_DIVISION_VALUE := NVL(R1.TOTAL_DAY, 0) - NVL(R1.STD_HOLY_0_COUNT, 0);
        IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
          V_DIVISION_VALUE := P_TOTAL_DAY;
        END IF;
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * NVL(R1.PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'DAILY' THEN
      -- 일급--
        V_ALLOWANCE_AMOUNT := NVL(R1.PAY_DAY, 0) * NVL(R1.ALLOWANCE_AMOUNT, 0);
      ELSIF P_PAY_LEVEL = 'TIME' THEN
      -- 시급--
        V_ALLOWANCE_AMOUNT := NVL(R1.PAY_DAY, 0) * NVL(R1.ALLOWANCE_AMOUNT, 0) * 8;
      END IF;

      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 지급 항목 --
        ALLOWANCE_INSERT( P_PERSON_ID => P_PERSON_ID
                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                        , P_WAGE_TYPE => P_WAGE_TYPE
                        , P_CORP_ID => P_CORP_ID
                        , P_ALLOWANCE_ID => R1.ALLOWANCE_ID
                        , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => P_MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END IF;
    END LOOP R1;

  END BASIC_PAY_AMOUNT_101;

-- 2.2 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_102
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;
    V_DIVISION_VALUE              NUMBER;
    V_HOLIDAY_ALLOWANCE_ID        NUMBER;
    V_HOLIDAY_ALLOWANCE_AMOUNT    NUMBER;
    
  BEGIN
    -- 주휴수당 항목 ID;
    V_HOLIDAY_ALLOWANCE_ID := HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'VALUE2 = ''HOLIDAY''', P_SOB_ID, P_ORG_ID);
    
    -- 급여 마스터 - 기본급 항목 --
    FOR R1 IN ( SELECT PML.ALLOWANCE_TYPE
                     , PML.ALLOWANCE_ID
                     , PML.ALLOWANCE_AMOUNT
                     , NVL(DMT.STD_HOLY_0_COUNT, 0) AS STD_HOLY_0_COUNT
                     , NVL(DMT.HOLY_0_COUNT, 0) AS HOLY_0_COUNT
                     , NVL(DMT.HOLY_1_COUNT, 0) AS HOLY_1_COUNT
                     , NVL(DMT.HOLY_0_DED_FLAG, 0) AS HOLY_0_DED_FLAG
                     , NVL(DMT.CHANGE_DED_COUNT, 0) AS CHANGE_DED_COUNT
                     , NVL(DMT.WEEKLY_DED_COUNT, 0) AS WEEKLY_DED_COUNT
                     , NVL(DMT.TOTAL_ATT_DAY, 0) AS TOTAL_ATT_DAY
                     , NVL(DMT.TOTAL_DED_DAY, 0) AS TOTAL_DED_DAY
                     , NVL(DMT.TOTAL_DAY, 0) AS TOTAL_DAY
                     , NVL(DMT.PAY_DAY, 0) AS PAY_DAY
                  FROM HRP_PAY_MASTER_HEADER PMH
                    , HRP_PAY_MASTER_LINE PML
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
                 WHERE PMH.PERSON_ID              = DMT.PERSON_ID(+)
                   AND PMH.CORP_ID                = DMT.CORP_ID(+)
                   AND PMH.SOB_ID                 = DMT.SOB_ID(+)
                   AND PMH.ORG_ID                 = DMT.ORG_ID(+)
                   AND PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                   AND PMH.START_YYYYMM           <= P_PAY_YYYYMM
                   AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                   AND PMH.PERSON_ID              = P_PERSON_ID
                   AND PMH.CORP_ID                = P_CORP_ID
                   AND PMH.SOB_ID                 = P_SOB_ID
                   AND PMH.ORG_ID                 = P_ORG_ID
                   AND PML.ENABLED_FLAG           = 'Y'
                   AND EXISTS ( SELECT 'X'
                                  FROM HRM_ALLOWANCE_V HA
                                 WHERE HA.ALLOWANCE_ID      = PML.ALLOWANCE_ID
                                   AND HA.ALLOWANCE_TYPE    = 'BASIC'
                              )
               )
    LOOP
      V_ALLOWANCE_AMOUNT := 0;
      V_HOLIDAY_ALLOWANCE_AMOUNT := 0;
      
      IF P_PAY_GRADE IN('SA') THEN
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
      ELSIF P_PAY_LEVEL = 'YEAR' THEN
      -- 연봉--
        V_DIVISION_VALUE := NVL(R1.TOTAL_DAY, 0) - NVL(R1.STD_HOLY_0_COUNT, 0);
        IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
          V_DIVISION_VALUE := P_TOTAL_DAY;
        END IF;
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * NVL(R1.PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'MONTH' THEN
      -- 월급--
        V_DIVISION_VALUE := NVL(R1.TOTAL_DAY, 0) - NVL(R1.STD_HOLY_0_COUNT, 0);
        IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
          V_DIVISION_VALUE := P_TOTAL_DAY;
        END IF;
        V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * NVL(R1.PAY_DAY, 0);
      ELSIF P_PAY_LEVEL = 'DAILY' THEN
      -- 일급--        
        V_ALLOWANCE_AMOUNT := (NVL(R1.TOTAL_DAY, 0) - (NVL(R1.TOTAL_DED_DAY, 0) + NVL(R1.HOLY_1_COUNT, 0) - NVL(R1.WEEKLY_DED_COUNT, 0))) * NVL(R1.ALLOWANCE_AMOUNT, 0);
        V_HOLIDAY_ALLOWANCE_AMOUNT := (NVL(R1.HOLY_1_COUNT, 0) - NVL(R1.WEEKLY_DED_COUNT, 0)) * NVL(R1.ALLOWANCE_AMOUNT, 0);
      ELSIF P_PAY_LEVEL = 'TIME' THEN
      -- 시급--
        V_ALLOWANCE_AMOUNT := (NVL(R1.TOTAL_DAY, 0) - (NVL(R1.TOTAL_DED_DAY, 0) + NVL(R1.HOLY_1_COUNT, 0) - NVL(R1.WEEKLY_DED_COUNT, 0))) * NVL(R1.ALLOWANCE_AMOUNT, 0) * 8;
        V_HOLIDAY_ALLOWANCE_AMOUNT := (NVL(R1.HOLY_1_COUNT, 0) - NVL(R1.WEEKLY_DED_COUNT, 0)) * NVL(R1.ALLOWANCE_AMOUNT, 0) * 8;
      END IF;

      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 기본급. --
        ALLOWANCE_INSERT( P_PERSON_ID => P_PERSON_ID
                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                        , P_WAGE_TYPE => P_WAGE_TYPE
                        , P_CORP_ID => P_CORP_ID
                        , P_ALLOWANCE_ID => R1.ALLOWANCE_ID
                        , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => P_MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END IF;
      IF NVL(V_HOLIDAY_ALLOWANCE_AMOUNT, 0) <> 0 THEN
      -- 주휴수당.
        ALLOWANCE_INSERT( P_PERSON_ID => P_PERSON_ID
                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                        , P_WAGE_TYPE => P_WAGE_TYPE
                        , P_CORP_ID => P_CORP_ID
                        , P_ALLOWANCE_ID => V_HOLIDAY_ALLOWANCE_ID
                        , P_ALLOWANCE_AMOUNT => NVL(V_HOLIDAY_ALLOWANCE_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => P_MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END IF;
    END LOOP R1;

  END BASIC_PAY_AMOUNT_102;

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
                     , MP.LONG_MONTH
                     , PM.SEX_TYPE
                     , PM.ORI_JOIN_DATE
                     , PM.PAY_DATE
                     , MP.PAY_DAY
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                 WHERE MP.PERSON_ID               = PM.PERSON_ID
                   AND MP.SOB_ID                  = PM.SOB_ID
                   AND MP.ORG_ID                  = PM.ORG_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
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
                     AND NOT EXISTS ( SELECT 'X'
                                        FROM HRM_ALLOWANCE_V HA
                                       WHERE PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
                                         AND HA.ALLOWANCE_TYPE    IN('BASIC', 'LONG', 'BONUS')
                                    )
                 )
      LOOP
        IF R1.ALLOWANCE_TYPE = 'A' THEN
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
        ELSE
        -- 공제 항목 --
          DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_DEDUCTION_ID => R1.ALLOWANCE_ID
                          , P_DEDUCTION_AMOUNT => NVL(R1.ALLOWANCE_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        END IF;
      END LOOP R1;

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
      COMMIT;
    END LOOP C1;

    -- 추가 지급 항목(업체 고유 지급 항목 : ALLOWANCE_ETC) --
    FOR C1 IN ( SELECT HA.ALLOWANCE_ID
                     , AE.ALLOWANCE_CODE
                     , AE.ALLOWANCE_CLASS
                     , AE.FORMULA1
                     , AE.FORMULA2
                     , AE.FORMULA3
                     , AE.FORMULA4
                     , AE.FORMULA5
                     , AE.FORMULA6
                     , AE.FORMULA7
                     , AE.FORMULA8
                  FROM HRM_ALLOWANCE_ETC_V AE
                    , HRM_ALLOWANCE_V HA
                WHERE AE.ALLOWANCE_CODE         = HA.ALLOWANCE_CODE
                  AND AE.SOB_ID                 = HA.SOB_ID
                  AND AE.ORG_ID                 = HA.ORG_ID
                  AND AE.SOB_ID                 = P_SOB_ID
                  AND AE.ORG_ID                 = P_ORG_ID
                  AND AE.ENABLED_FLAG           = 'Y'
                  AND AE.EFFECTIVE_DATE_FR      <= P_STD_DATE
                  AND (AE.EFFECTIVE_DATE_TO IS NULL OR AE.EFFECTIVE_DATE_TO >= P_STD_DATE)
             )
    LOOP
      -- 해당 프로시져 호출 --
      IF C1.ALLOWANCE_CLASS = 'MANAGEMENT_HOLIDAY' THEN
        -- 71 관리직 휴일특근비.
        MANAGEMENT_HOLIDAY_ALLOWANCE
              ( P_CORP_ID           => P_CORP_ID
              , P_PAY_YYYYMM        => P_PAY_YYYYMM
              , P_WORK_DATE_FR      => P_START_DATE
              , P_WORK_DATE_TO      => P_END_DATE
              , P_WAGE_TYPE         => P_WAGE_TYPE
              , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
              , P_PAY_TYPE          => P_PAY_TYPE
              , P_DEPT_ID           => P_DEPT_ID
              , P_PERSON_ID         => P_PERSON_ID
              , P_STD_DATE          => P_STD_DATE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_USER_ID           => P_USER_ID
              );
      ELSIF C1.ALLOWANCE_CLASS = 'OT_RATE' THEN
      -- 72 생산장려수당.
        OT_RATE ( P_CORP_ID
                , P_PAY_YYYYMM 
                , P_WAGE_TYPE
                , C1.ALLOWANCE_ID
                , C1.FORMULA3
                , P_DEPT_ID
                , P_PERSON_ID
                , P_SOB_ID
                , P_ORG_ID
                );
      ELSIF C1.ALLOWANCE_CLASS = 'AGE_OVER' THEN
      -- 73 자기개발수당.
        AGE_OVER( P_CORP_ID
                , P_PAY_YYYYMM 
                , P_WAGE_TYPE
                , C1.ALLOWANCE_ID
                , C1.FORMULA3
                , C1.FORMULA4
                , P_DEPT_ID
                , P_PERSON_ID
                , P_SOB_ID
                , P_ORG_ID
                );
              
      END IF;

    END LOOP C1;

  END ETC_PAY_CREATION;

-- 11 근속수당 생성
  PROCEDURE LONG_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_LIMIT_AMOUNT                NUMBER := 0;  -- 한도금액.
    V_ALLOWANCE_ID                NUMBER := 0;  -- 수당 ID.
    V_ALLOWANCE_CODE              VARCHAR2(10) := NULL;  -- 수당 CODE.
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN
    BEGIN
      SELECT HA.ALLOWANCE_ID, HA.ALLOWANCE_CODE
        INTO V_ALLOWANCE_ID, V_ALLOWANCE_CODE
        FROM HRM_ALLOWANCE_V HA
       WHERE HA.ALLOWANCE_TYPE            = 'LONG'
         AND HA.SOB_ID                    = P_SOB_ID
         AND HA.ORG_ID                    = P_ORG_ID
         AND HA.ENABLED_FLAG              = 'Y'
         AND HA.EFFECTIVE_DATE_FR         <= P_STD_DATE
         AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= P_STD_DATE)
         AND ROWNUM                       <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('Long Allowace ID Error : ' || SQLERRM);
      RETURN;
    END;
    -- 수당 한도 조회.
    V_LIMIT_AMOUNT := HRP_PAYMENT_G_SET.LIMIT_AMOUNT_F ( P_STD_DATE, V_ALLOWANCE_CODE, P_SOB_ID, P_ORG_ID);

    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.LONG_YEAR
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PAY_TYPE_V PT
                 WHERE MP.PAY_TYPE                = PT.PAY_TYPE
                   AND MP.SOB_ID                  = PT.SOB_ID
                   AND MP.ORG_ID                  = PT.ORG_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND PT.LONG_ALLOWANCE_YN       = 'Y'
               )
    LOOP
      V_ALLOWANCE_AMOUNT := HRP_PAYMENT_G_SET.LONG_ALLOWANCE_F( P_STD_DATE, C1.LONG_YEAR, P_SOB_ID, P_ORG_ID);
      IF NVL(V_LIMIT_AMOUNT, 0) > -1 AND NVL(V_ALLOWANCE_AMOUNT, 0) > NVL(V_LIMIT_AMOUNT, 0) THEN
        V_ALLOWANCE_AMOUNT := NVL(V_LIMIT_AMOUNT, 0);
      END IF ;
      IF  NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
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
        -- 급여 마스터 적용.
        PAY_MASTER_LINE_INSERT( P_PAY_YYYYMM => C1.PAY_YYYYMM
                              , P_PERSON_ID => C1.PERSON_ID
                              , P_ALLOWANCE_TYPE => 'A'
                              , P_ALLOWANCE_ID => V_ALLOWANCE_ID
                              , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                              , P_SOB_ID => P_SOB_ID
                              , P_ORG_ID => P_ORG_ID
                              , P_USER_ID => P_USER_ID
                              );
      END IF;
      COMMIT;
    END LOOP C1;

  END LONG_ALLOWANCE;

-- 12 통상시급수당 생성
  PROCEDURE GENERAL_HOURLY_AMOUNT
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
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
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                 WHERE MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
               )
    LOOP
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.GENERAL_HOURLY_AMOUNT = HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F
                                                        ( C1.PAY_YYYYMM
                                                        , C1.PERSON_ID
                                                        , P_SOB_ID
                                                        , P_ORG_ID
                                                        )
      WHERE MP.MONTH_PAYMENT_ID   = C1.MONTH_PAYMENT_ID
      ;
    END LOOP C1;

  END GENERAL_HOURLY_AMOUNT;

-- 16 가족수당 생성
  PROCEDURE FAMILY_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_STD_FAMILY_AMOUNT           NUMBER := 0;  -- 가족 기준 수당.
    V_LIMIT_AMOUNT                NUMBER := 0;  -- 한도금액.
    V_ALLOWANCE_ID                NUMBER := 0;  -- 가족수당 ID.
    V_ALLOWANCE_CODE              VARCHAR2(10) := NULL;  -- 가족수당 CODE.
    V_ALLOWANCE_AMOUNT            NUMBER := 0;

  BEGIN
    BEGIN
      SELECT HA.ALLOWANCE_ID, HA.ALLOWANCE_CODE
        INTO V_ALLOWANCE_ID, V_ALLOWANCE_CODE
        FROM HRM_ALLOWANCE_V HA
       WHERE HA.ALLOWANCE_TYPE            = 'FAMILY'
         AND HA.SOB_ID                    = P_SOB_ID
         AND HA.ORG_ID                    = P_ORG_ID
         AND HA.ENABLED_FLAG              = 'Y'
         AND HA.EFFECTIVE_DATE_FR         <= P_STD_DATE
         AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= P_STD_DATE)
         AND ROWNUM                       <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.put_line('Family Allowace ID Error : ' || SQLERRM);
      RETURN;
    END;
    -- 가족수당 한도 조회.
    V_LIMIT_AMOUNT := HRP_PAYMENT_G_SET.LIMIT_AMOUNT_F ( P_STD_DATE, V_ALLOWANCE_CODE, P_SOB_ID, P_ORG_ID);

    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PAY_TYPE_V PT
                 WHERE MP.PAY_TYPE                = PT.PAY_TYPE
                   AND MP.SOB_ID                  = PT.SOB_ID
                   AND MP.ORG_ID                  = PT.ORG_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND PT.FAMILY_ALLOWANCE_YN     = 'Y'
                   AND MP.EXCEPT_TYPE             NOT IN ('I', 'R')
               )
    LOOP
      V_ALLOWANCE_AMOUNT := 0;
      FOR R1 IN ( SELECT HR.YEAR_RELATION_CODE
                       , COUNT(HF.PERSON_ID) AS FAMILY_COUNT
                    FROM HRM_FAMILY HF
                      , HRM_RELATION_V HR
                   WHERE HF.RELATION_ID             = HR.RELATION_ID
                     AND HF.PERSON_ID               = C1.PERSON_ID
                     AND HF.PAY_YN                  = 'Y'
                 GROUP BY HR.YEAR_RELATION_CODE
                 )
      LOOP
        V_STD_FAMILY_AMOUNT := 0;
        BEGIN
          SELECT YRV.FAMILY_ALLOWANCE_AMOUNT
            INTO V_STD_FAMILY_AMOUNT
            FROM HRM_YEAR_RELATION_V YRV
           WHERE YRV.YEAR_RELATION_CODE     = R1.YEAR_RELATION_CODE
             AND YRV.FAMILY_ALLOWANCE_YN    = 'Y'
             AND YRV.SOB_ID                 = P_SOB_ID
             AND YRV.ORG_ID                 = P_ORG_ID
             AND YRV.ENABLED_FLAG           = 'Y'
             AND YRV.EFFECTIVE_DATE_FR      <= P_STD_DATE
             AND (YRV.EFFECTIVE_DATE_TO IS NULL OR YRV.EFFECTIVE_DATE_TO >= P_STD_DATE)
          ;
        EXCEPTION WHEN OTHERS THEN
          V_STD_FAMILY_AMOUNT := 0;
        END;
        V_ALLOWANCE_AMOUNT := NVL(V_ALLOWANCE_AMOUNT, 0) + (NVL(V_STD_FAMILY_AMOUNT, 0) * NVL(R1.FAMILY_COUNT, 0));
      END LOOP R1;
      IF NVL(V_LIMIT_AMOUNT, 0) > -1 AND NVL(V_ALLOWANCE_AMOUNT, 0) > NVL(V_LIMIT_AMOUNT, 0) THEN
        V_ALLOWANCE_AMOUNT := NVL(V_LIMIT_AMOUNT, 0);
      END IF ;
      IF  NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
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
      COMMIT;
    END LOOP C1;

  END FAMILY_ALLOWANCE;

-- 21 근태수당 생성
  PROCEDURE DUTY_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_HOURLY_PAY_AMOUNT           NUMBER := 0;
    V_ALLOWANCE_AMOUNT            NUMBER := 0;

  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
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
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
               )
    LOOP
      -- 연장 수당 계산.
      FOR R1 IN ( SELECT MTO.PERSON_ID
                       , OT.ALLOWANCE_ID
                       , OT.ALLOWANCE_CODE
                       , NVL(SUM(NVL(MTO.OT_TIME, 0)  * NVL(OT.ALLOWANCE_RATE, 0)), 0) AS OT_TIME
                    FROM HRD_MONTH_TOTAL_OT MTO
                      , HRM_OT_TYPE_ALLOWANCE_V OT
                   WHERE MTO.OT_TYPE                = OT.OT_TYPE
                     AND MTO.SOB_ID                 = OT.SOB_ID
                     AND MTO.ORG_ID                 = OT.ORG_ID
                     AND MTO.DUTY_TYPE              = C_DUTY_MONTH
                     AND MTO.DUTY_YYYYMM            = C1.PAY_YYYYMM
                     AND MTO.PERSON_ID              = C1.PERSON_ID
                     AND MTO.SOB_ID                 = C1.SOB_ID
                     AND MTO.ORG_ID                 = C1.ORG_ID
                     AND OT.ENABLED_FLAG            = 'Y'
                     AND OT.EFFECTIVE_DATE_FR       <= P_STD_DATE
                     AND (OT.EFFECTIVE_DATE_TO IS NULL OR OT.EFFECTIVE_DATE_TO >= P_STD_DATE)
                 GROUP BY MTO.PERSON_ID
                       , OT.ALLOWANCE_ID
                       , OT.ALLOWANCE_CODE
                )
      LOOP
        -- 근태 수당.
        V_ALLOWANCE_AMOUNT := NVL(C1.GENERAL_HOURLY_AMOUNT, 0) * NVL(R1.OT_TIME, 0);
        IF  NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
          ALLOWANCE_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_ALLOWANCE_ID => R1.ALLOWANCE_ID
                          , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        END IF;

      END LOOP R1;
      COMMIT;
    END LOOP C1;

  END DUTY_ALLOWANCE;

-- 41 상여금 생성
  PROCEDURE BONUS_PAY_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;

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
                                     AND HA.ALLOWANCE_TYPE    = 'BONUS'
                                )
                 )
      LOOP
        V_ALLOWANCE_AMOUNT := 0;
        /*IF C1.PAY_GRADE IN('SA') THEN
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'YEAR' THEN
        -- 연봉--
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'MONTH' THEN
        -- 월급--
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'DAILY' THEN
        -- 일급--
          V_ALLOWANCE_AMOUNT := NVL(C1.PAY_DAY, 0) * NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF C1.PAY_LEVEL = 'TIME' THEN
        -- 시급--
          V_ALLOWANCE_AMOUNT := NVL(C1.PAY_DAY, 0) * NVL(R1.ALLOWANCE_AMOUNT, 0) * 8;
        END IF;*/
        V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
        -- 지급 항목 --
          ALLOWANCE_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_ALLOWANCE_ID => R1.ALLOWANCE_ID
                          , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );
        END IF;
      END LOOP R1;
      COMMIT;
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
                   AND PG.PAY_GRADE               NOT IN ('SA')
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
      ELSE
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
        END IF;
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

  END DAILY_PAY_CALCULATE_102;

-- 51. 건강보험/국민연금 생성
  PROCEDURE PENSION_HEALTH_INSURANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
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
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , HD.DEDUCTION_ID
                     , HD.DEDUCTION_CODE
                     , NVL(IC.PERSON_INSUR_AMOUNT, 0) + NVL(IC.PERSON_INSUR_ADD_AMOUNT, 0) AS INSUR_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_INSURANCE_CHARGE IC
                    , HRM_INSUR_TYPE_V IT
                    , HRM_DEDUCTION_V HD
                WHERE MP.PERSON_ID              = IC.PERSON_ID
                  AND IC.INSUR_TYPE             = IT.INSUR_TYPE
                  AND IC.SOB_ID                 = IT.SOB_ID
                  AND IC.ORG_ID                 = IT.ORG_ID
                  AND IT.DEDUCTION_CODE         = HD.DEDUCTION_CODE
                  AND IT.SOB_ID                 = HD.SOB_ID
                  AND IT.ORG_ID                 = HD.ORG_ID
                  AND MP.PAY_YYYYMM             = P_PAY_YYYYMM
                  AND MP.WAGE_TYPE              = P_WAGE_TYPE
                  AND MP.CORP_ID                = P_CORP_ID
                  AND MP.SOB_ID                 = P_SOB_ID
                  AND MP.ORG_ID                 = P_ORG_ID
                  AND IC.INSUR_YN               = 'Y'
                  AND MP.DEPT_ID                = NVL(P_DEPT_ID, MP.DEPT_ID)
                  AND MP.PERSON_ID              = NVL(P_PERSON_ID, MP.PERSON_ID)
                  AND MP.PAY_TYPE               = NVL(P_PAY_TYPE, MP.PAY_TYPE)
               )
    LOOP
      IF NVL(C1.INSUR_AMOUNT, 0) <> 0 THEN
        DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                        , P_PAY_YYYYMM => C1.PAY_YYYYMM
                        , P_WAGE_TYPE => C1.WAGE_TYPE
                        , P_CORP_ID => C1.CORP_ID
                        , P_DEDUCTION_ID => C1.DEDUCTION_ID
                        , P_DEDUCTION_AMOUNT => NVL(C1.INSUR_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END IF;
      COMMIT;
    END LOOP C1;

  END PENSION_HEALTH_INSURANCE;

-- 55. 고용보험 생성
  PROCEDURE UNEMPLOYMENT_INSURANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_DEDUCTION_ID                NUMBER;
    V_INSUR_RATE                  NUMBER;
    V_INSUR_AMOUNT                NUMBER;


  BEGIN
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
      V_INSUR_RATE := TO_NUMBER(NVL(HRM_COMMON_G.CODE_VALUE_F('INSUR_RATE', 'UI', 'VALUE1', P_SOB_ID, P_ORG_ID), 0));
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
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
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
      COMMIT;
    END LOOP C1;

  END UNEMPLOYMENT_INSURANCE;

-- 56. 세금 생성
  PROCEDURE TAX_CREATION
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
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
                            , NVL(SUM(DECODE(HA.TAX_FREE_YN, 'Y', 0, MA.ALLOWANCE_AMOUNT)), 0) AS ALLOWANCE_AMOUNT
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
                            , NVL(SUM(DECODE(HD.TAX_FREE_YN , 'Y', MD.DEDUCTION_AMOUNT, 0)), 0) AS DEDUCTION_AMOUNT
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
               )
    LOOP
      V_TAX_AMOUNT := 0;
      V_TAX_AMOUNT := HRP_PAYMENT_G_SET.TAX_AMOUNT_F( W_STD_DATE => C1.STANDARD_DATE
                                                    , W_TOTAL_AMOUNT => NVL(C1.TAX_PAY_AMOUNT, 0)
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
      COMMIT;
    END LOOP C1;

  END TAX_CREATION;


-- 71 관리직 특근수당 생성
  PROCEDURE MANAGEMENT_HOLIDAY_ALLOWANCE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WORK_DATE_FR      IN DATE
            , P_WORK_DATE_TO      IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            )
  AS
    V_ALLOWANCE_AMOUNT            NUMBER := 0;

  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.POST_ID
                     , HC.CODE AS POST_CODE
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.GENERAL_HOURLY_AMOUNT
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_COMMON HC
                    , HRM_PAY_TYPE_V PT
                 WHERE MP.POST_ID                 = HC.COMMON_ID
                   AND MP.PAY_TYPE                = PT.PAY_TYPE
                   AND MP.SOB_ID                  = PT.SOB_ID
                   AND MP.ORG_ID                  = PT.ORG_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MP.PAY_TYPE                = NVL(P_PAY_TYPE, MP.PAY_TYPE)
                   AND PT.PAY_LEVEL               IN('MONTH', 'YEAR')
               )
    LOOP
      V_ALLOWANCE_AMOUNT := 0;
      -- 특근시간 조회.
      FOR R1 IN ( SELECT DL.PERSON_ID
                       , DL.WORK_DATE
                       , NVL(SUM(DECODE(OT.OT_COLUMN, 'HOLIDAY_TIME', DLO.OT_TIME, 0)), 0) AS OT_TIME
                    FROM HRD_DAY_LEAVE DL
                      , HRD_DAY_LEAVE_OT DLO
                      , HRM_OT_TYPE_V OT
                  WHERE DL.DAY_LEAVE_ID         = DLO.DAY_LEAVE_ID
                    AND DLO.OT_TYPE             = OT.OT_TYPE
                    AND DLO.SOB_ID              = OT.SOB_ID
                    AND DLO.ORG_ID              = OT.ORG_ID
                    AND DL.WORK_DATE            BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
                    AND DL.PERSON_ID            = C1.PERSON_ID
                    AND DL.HOLY_TYPE            IN ('1')
                    AND DLO.OT_TIME             > 0
                    AND OT.ENABLED_FLAG         = 'Y'
                    AND OT.EFFECTIVE_DATE_FR    <= P_STD_DATE
                    AND (OT.EFFECTIVE_DATE_TO IS NULL OR OT.EFFECTIVE_DATE_TO >= P_STD_DATE)
                  GROUP BY DL.PERSON_ID
                       , DL.WORK_DATE
                )
      LOOP
        -- 휴일근로 수당.
        BEGIN
          SELECT NVL(V_ALLOWANCE_AMOUNT, 0) + NVL(AH.ALLOWANCE_AMOUNT, 0) AS ALLOWANCE_AMOUNT
            INTO V_ALLOWANCE_AMOUNT
            FROM HRM_ALLOWANCE_HOLIDAY_V AH
          WHERE AH.POST_CODE      = C1.POST_CODE
            AND AH.SOB_ID         = C1.SOB_ID
            AND AH.ORG_ID         = C1.ORG_ID
            AND R1.OT_TIME        BETWEEN AH.START_TIME AND AH.END_TIME
            AND AH.ENABLED_FLAG   = 'Y'
            AND AH.EFFECTIVE_DATE_FR <= P_WORK_DATE_TO
            AND (AH.EFFECTIVE_DATE_TO IS NULL OR AH.EFFECTIVE_DATE_TO >= P_WORK_DATE_FR)
          ;
        EXCEPTION WHEN OTHERS THEN
          NULL;
        END;

      END LOOP R1;
      IF  NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
        ALLOWANCE_INSERT( P_PERSON_ID => C1.PERSON_ID
                        , P_PAY_YYYYMM => C1.PAY_YYYYMM
                        , P_WAGE_TYPE => C1.WAGE_TYPE
                        , P_CORP_ID => C1.CORP_ID
                        , P_ALLOWANCE_ID => P_ALLOWANCE_ID
                        , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
                        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      END IF;
      COMMIT;
    END LOOP C1;

  END MANAGEMENT_HOLIDAY_ALLOWANCE;

-- 72 생산장려수당.
  PROCEDURE OT_RATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_STD_TIME          IN NUMBER
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE            
            )
  AS
    V_DED_COUNT                   NUMBER := 0;
    V_OT_TIME                     NUMBER := 0;
    
  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.LONG_MONTH
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_MONTH_ALLOWANCE MA
                 WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                   AND MP.SOB_ID                  = MA.SOB_ID
                   AND MP.ORG_ID                  = MA.ORG_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MA.ALLOWANCE_ID            = P_ALLOWANCE_ID
               )
    LOOP 
      BEGIN
        SELECT NVL(MT.LATE_DED_COUNT, 0) + (NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.HOLY_0_COUNT, 0)) AS DED_COUNT
             , (SELECT SUM(MTO.OT_TIME) AS OT_TIME
                  FROM HRD_MONTH_TOTAL_OT MTO
                    , HRM_OT_TYPE_V OT
                WHERE MTO.OT_TYPE               = OT.OT_TYPE
                  AND MTO.SOB_ID                = OT.SOB_ID
                  AND MTO.ORG_ID                = OT.ORG_ID
                  AND MTO.MONTH_TOTAL_ID        = MT.MONTH_TOTAL_ID
                  AND OT.MONTH_TOTAL_ITEM       IN('O14', 'O15', 'O18')
                ) AS OT_TIME
          INTO V_DED_COUNT, V_OT_TIME
          FROM HRD_MONTH_TOTAL MT
         WHERE MT.DUTY_YYYYMM         = C1.PAY_YYYYMM
           AND MT.PERSON_ID           = C1.PERSON_ID
           AND MT.CORP_ID             = C1.CORP_ID
           AND MT.SOB_ID              = C1.SOB_ID
           AND MT.ORG_ID              = C1.ORG_ID
           AND EXISTS ( SELECT 'X'
                          FROM HRM_CLOSING_TYPE_V CT
                        WHERE CT.CLOSING_TYPE   = MT.DUTY_TYPE
                          AND CT.SOB_ID         = MT.SOB_ID
                          AND CT.ORG_ID         = MT.ORG_ID
                          AND CT.MODULE_TYPE    = 'DUTY'
                          AND CT.PERIOD_TYPE    = 'MONTH'
                      )
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DED_COUNT := 0;
        V_OT_TIME := 0;
      END;
      IF NVL(P_STD_TIME, 0) > NVL(V_OT_TIME, 0) OR NVL(V_DED_COUNT, 0) > 0 OR NVL(C1.LONG_MONTH, 0) = 0 THEN
        ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                        , P_ALLOWANCE_ID
                        , P_SOB_ID
                        , P_ORG_ID
                        );
      END IF;      
    END LOOP C1;
    
  END OT_RATE;

-- 73 자기개발수당.
  PROCEDURE AGE_OVER
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_AGE               IN NUMBER
            , P_SEX_TYPE          IN VARCHAR2
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
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
                     , PM.SEX_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                    , HRP_MONTH_ALLOWANCE MA
                 WHERE MP.PERSON_ID               = PM.PERSON_ID
                   AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                   AND MP.SOB_ID                  = MA.SOB_ID
                   AND MP.ORG_ID                  = MA.ORG_ID
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.CORP_ID                 = P_CORP_ID
                   AND MP.SOB_ID                  = P_SOB_ID
                   AND MP.ORG_ID                  = P_ORG_ID
                   AND MP.DEPT_ID                 = NVL(P_DEPT_ID, MP.DEPT_ID)
                   AND MP.PERSON_ID               = NVL(P_PERSON_ID, MP.PERSON_ID)
                   AND MA.ALLOWANCE_ID            = P_ALLOWANCE_ID
               )
    LOOP      
      IF P_AGE < 35 AND P_SEX_TYPE <> C1.SEX_TYPE THEN
        ALLOWANCE_DELETE( P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                        , P_ALLOWANCE_ID => P_ALLOWANCE_ID
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        );
      END IF;
    END LOOP C1;

  END AGE_OVER;

-- 74 복지수당 적용 여부.
  FUNCTION  WORKING_RATE_F
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_DUTY_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_WORKING_RATE                NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT CEIL(NVL(MT.PAY_DAY, 0) / (NVL(MT.TOTAL_DAY, 0) - NVL(MT.STD_HOLY_0_COUNT, 0)) * 100) AS OVER_RATE
        INTO V_WORKING_RATE
        FROM HRD_MONTH_TOTAL MT
      WHERE MT.PERSON_ID                = P_PERSON_ID
        AND MT.DUTY_TYPE                = P_DUTY_TYPE
        AND MT.DUTY_YYYYMM              = P_PAY_YYYYMM
        AND MT.CORP_ID                  = P_CORP_ID
        AND MT.SOB_ID                   = P_SOB_ID
        AND MT.ORG_ID                   = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_WORKING_RATE;
    
  END WORKING_RATE_F;
  
---------------------------------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
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
               )
    LOOP
      -- 지급 항목 합계 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.PAY_AMOUNT, MP.BONUS_AMOUNT, MP.TOT_SUPPLY_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BONUS', 0, MA.ALLOWANCE_AMOUNT)), 0) AS PAY_AMOUNT
                   , NVL(SUM(DECODE(HA.ALLOWANCE_TYPE, 'BONUS', MA.ALLOWANCE_AMOUNT, 0)), 0) AS BONUS_AMOUNT
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
        SET (MP.DED_PAY_AMOUNT, MP.DED_BONUS_AMOUNT, MP.TOT_DED_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(DECODE(CT.PAYMENT_TYPE, 'BONUS', 0, MD.DEDUCTION_AMOUNT)), 0) AS DED_PAY_AMOUNT
                   , NVL(SUM(DECODE(CT.PAYMENT_TYPE, 'BONUS', MD.DEDUCTION_AMOUNT, 0)), 0) AS DED_BONUS_AMOUNT
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

      COMMIT;
    END LOOP C1;

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

-- 92. 지급내역 삭제.
  PROCEDURE ALLOWANCE_DELETE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE HRP_MONTH_ALLOWANCE MA
    WHERE MA.MONTH_PAYMENT_ID        = P_MONTH_PAYMENT_ID
      AND MA.ALLOWANCE_ID            = P_ALLOWANCE_ID
      AND MA.SOB_ID                  = P_SOB_ID
      AND MA.ORG_ID                  = P_ORG_ID
    ;
  
  END ALLOWANCE_DELETE;

--  93. 급상여 공제내역 삽입.
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

-- 93. 급여 마스터 반영.
  PROCEDURE PAY_MASTER_LINE_INSERT
            ( P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_PERSON_ID         IN NUMBER
            , P_ALLOWANCE_TYPE    IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT  IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE
            )
  AS
    V_PAY_HEADER_ID               HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE;
    V_PAY_LINE_ID                 HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE;

  BEGIN
    BEGIN
      SELECT PMH.PAY_HEADER_ID
        INTO V_PAY_HEADER_ID
        FROM HRP_PAY_MASTER_HEADER PMH
       WHERE PMH.PERSON_ID              = P_PERSON_ID
         AND PMH.START_YYYYMM           <= P_PAY_YYYYMM
         AND PMH.END_YYYYMM             >= P_PAY_YYYYMM
         AND PMH.SOB_ID                 = P_SOB_ID
         AND PMH.ORG_ID                 = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('93. Get Pay Header ID Error : ' || SQLERRM);
      RETURN;
    END;

    BEGIN
    -- 급여 마스터 적용.
      HRP_PAY_MASTER_G.PAY_LINE_INSERT
                      ( P_PAY_LINE_ID      => V_PAY_LINE_ID
                      , P_PAY_HEADER_ID    => V_PAY_HEADER_ID
                      , P_ALLOWANCE_TYPE   => P_ALLOWANCE_TYPE
                      , P_ALLOWANCE_ID     => P_ALLOWANCE_ID
                      , P_ALLOWANCE_AMOUNT => P_ALLOWANCE_AMOUNT
                      , P_ENABLED_FLAG     => 'Y'
                      , P_SOB_ID           => P_SOB_ID
                      , P_USER_ID          => P_USER_ID
                      );
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('93. Pay Master Line Insert Error : ' || SQLERRM);
      RETURN;
    END;

  END PAY_MASTER_LINE_INSERT;

END HRP_MONTH_PAYMENT_G_SET; 
/
