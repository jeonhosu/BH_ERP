CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_G_SET
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
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            
-- 2 급여 기본급 생성
  PROCEDURE BASIC_PAY_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            );
            
-- 2.1 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_101
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_OFFICER_YN        IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            );
            
-- 2.2 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_102
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EMPLOYE_TYPE      IN HRP_MONTH_PAYMENT.EMPLOYE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_OFFICER_YN        IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            );
            
-- 3 기본급이외 기본자료 생성
  PROCEDURE ETC_PAY_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            
-- 11 근속수당 생성
  PROCEDURE LONG_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
   
-- 16 가족수당 생성
  PROCEDURE FAMILY_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            
-- 21 상여금 생성
  PROCEDURE BONUS_PAY_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            
            
-- 30 통상시급수당 생성
  PROCEDURE GENERAL_HOURLY_AMOUNT 
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
                     
-- 31 근태수당 생성
  PROCEDURE DUTY_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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

-- 41 지급항목 일할계산 
  PROCEDURE DAILY_PAY_CALCULATE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            );

-- 41.1 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_101
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_JOIN_3RD_DATE     IN DATE
            , P_RETIRE_DATE       IN DATE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PAY_LEVEL         IN HRM_PAY_TYPE_V.PAY_LEVEL%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );
            
-- 41.2 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_102
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_HOLY_0_COUNT      IN NUMBER
            , P_PAY_GRADE         IN HRM_COMMON.CODE%TYPE
            , P_PAY_LEVEL         IN HRM_PAY_TYPE_V.PAY_LEVEL%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            );

-- 47. 신입사원 일할 계산.
--  PROCEDURE ROOKIE
-- 51. 건강보험/국민연금 생성(보험료 기준)
  PROCEDURE PENSION_HEALTH_INSURANCE_1
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
            
-- 52. 건강보험/국민연금 생성(보수/소득월금액 기준).
  PROCEDURE PENSION_HEALTH_INSURANCE_2
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
-- 70 관리직 특근수당 생성
  PROCEDURE MANAGEMENT_HOLIDAY_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WORK_DATE_FR      IN DATE
            , P_WORK_DATE_TO      IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            );      

-- 71 직책수당
  PROCEDURE JOB_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            ); 
            
-- 72 생산장려수당 : 기준시간 이하 연장근무, 공제일수 있을 경우, 당월 입사..
  PROCEDURE PROMOTE_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_STD_TIME          IN NUMBER
            , P_STD_LATE_TIME     IN NUMBER
            , P_STD_LEAVE_TIME    IN NUMBER
            , P_STD_DED_11_COUNT  IN NUMBER
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            ); 

-- 73 자기개발수당 : 45세 이상 여자 제외.
  PROCEDURE SELF_DEV_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_AGE               IN NUMBER
            , P_SEX_TYPE          IN VARCHAR2
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            ); 

-- 74 복지수당 적용 여부 : 근무율 70%이상, 수습3개월 이상.
  PROCEDURE WELFARE_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_WORKING_RATE      IN NUMBER
            , P_LONG_MONTH        IN NUMBER
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            );

-- 75 검사수당 적용 여부
  PROCEDURE INSPECTION_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            ); 


-- 75 검사수당 적용 여부(부서기준).
  PROCEDURE INSPECTION_ALLOWANCE_DEPT
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            ); 
                        
---------------------------------------------------------------------------------------------------  
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
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

-- 93. 지급내역 삭제.
  PROCEDURE ALLOWANCE_DELETE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
-- 94. 급여 마스터 반영.
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
  C_RETIRE_PAYMENT                CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P3';  -- 퇴직급여.
  C_DANGJIK_PAYMENT               CONSTANT HRM_CLOSING_TYPE_V.CLOSING_TYPE%TYPE := 'P4';  -- 년차수당.
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
    O_STATUS := 'F';
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
    PAYMENT_CREATION
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
    
---------------------------------------------------------------------------
-- 2. 급여 기본자료 생성(급여 마스터 - 지급/공제 항목, 추가 급상여 - 지급/공제 사항)
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 2.Payment Allowance/Deduction Amount Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    BASIC_PAY_CREATION
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
      , P_START_DATE => V_START_DATE
      , P_END_DATE => V_END_DATE
      , P_TOTAL_DAY => V_TOTAL_DAY
      );
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
    
---------------------------------------------------------------------------
-- 3. 기본급이외 기본자료 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 3.ETC Allowance/Deduction Amount Create (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    ETC_PAY_CREATION
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
                          
---------------------------------------------------------------------------
-- 11 근속수당 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 11.Long Allowance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    LONG_ALLOWANCE
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
       
/*---------------------------------------------------------------------------
-- 16 가족수당 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 16.Family Allowance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    FAMILY_ALLOWANCE
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;      
      */


---------------------------------------------------------------------------
-- 21 상여금 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 41.Bonus Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    BONUS_PAY_CREATION
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;      
             
        
---------------------------------------------------------------------------
-- 31 통상시급수당 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 12.General Hourly Amount Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    GENERAL_HOURLY_AMOUNT
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
             
---------------------------------------------------------------------------
-- 31 근태수당 생성
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 21.Duty Allowance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    DUTY_ALLOWANCE
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
           
---------------------------------------------------------------------------
-- 41 지급항목 일할계산 
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 46.Daily Pay Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    DAILY_PAY_CALCULATE 
      ( O_STATUS => O_STATUS
      , O_MESSAGE => O_MESSAGE
      , P_CORP_ID => P_CORP_ID
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
      , P_START_DATE => V_START_DATE
      , P_END_DATE => V_END_DATE
      , P_TOTAL_DAY => V_TOTAL_DAY
      );
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;      
                      
---------------------------------------------------------------------------
-- 51. 국민/건강보험 계산(보수액 기준).
---------------------------------------------------------------------------
/*--DBMS_OUTPUT.PUT_LINE('--- 51.Pension/Health Insurance Calculate (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    PENSION_HEALTH_INSURANCE_2
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;         

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
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;      

---------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
---------------------------------------------------------------------------
--DBMS_OUTPUT.PUT_LINE('--- 90.Payment Summary Update (START DATE : '  || TO_CHAR(GET_LOCAL_DATE(P_SOB_ID), 'YYYY-MM-DD HH24:MI:SS') || ')');
    PAYMENT_SUMMARY_UPDATE
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
      );    
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;             
    O_STATUS := 'S';
  /*EXCEPTION
    WHEN ERRNUMS.DATA_NOT_OPENED THEN
      O_MESSAGE := ERRNUMS.DATA_NOT_OPENED_CODE || '.' || ERRNUMS.DATA_NOT_OPENED_DESC;
    WHEN ERRNUMS.DATA_CLOSED THEN
      O_MESSAGE := ERRNUMS.DATA_CLOSED_CODE || '.' || ERRNUMS.DATA_CLOSED_DESC;  */
  END PAYMENT_MAIN;
  
--  1. 급상여 처리 대상자 생성.
  PROCEDURE PAYMENT_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
    O_STATUS := 'F';
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
    EXCEPTION WHEN OTHERS THEN
      V_YEAR_START_COLUMN := 'ORI_JOIN_DATE';
      V_YEAR_END_COLUMN   := 'END_DATE';
    END;
    BEGIN
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
    EXCEPTION WHEN OTHERS THEN
      V_MONTH_START_COLUMN := 'ORI_JOIN_DATE';
      V_MONTH_END_COLUMN   := 'END_DATE';
    END;
    
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
                       , PM.PERSON_NUM
                       , PM.NAME 
                       , PM.CORP_ID
                       , T1.DEPT_ID 
                       , T1.POST_ID
                       , T1.OCPT_ID
                       , T1.ABIL_ID
                       , T1.JOB_CATEGORY_ID
                       , PMH.PAY_TYPE
                       , T1.PAY_GRADE_ID AS PAY_GRADE_ID
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
                       , NVL(PMH.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
                       , PMH.SOB_ID
                       , PMH.ORG_ID
                       , P_PAY_YYYYMM
                       , P_WAGE_TYPE
                       , P_SUPPLY_DATE
                       , P_STD_DATE AS STANDARD_DATE
                       , P_START_DATE AS START_DATE
                       , P_END_DATE AS END_DATE
                       , NVL(S_MT.PAY_DAY, 0) + 
                         CASE 
                           WHEN PMH.PAY_TYPE IN ('1', '3') THEN NVL(S_MT.HOLY_0_COUNT, 0)
                           ELSE 0
                         END AS PAY_DAY
                       , (1 + NVL(HF1.DED_FAMILY_COUNT, 0) +  -- 가족사항 세액공제.
                         (CASE WHEN NVL(HF1.DED_CHILD_COUNT, 0) > 0 THEN NVL(HF1.DED_CHILD_COUNT, 0) - 1 ELSE 0 END)) AS DED_PERSON_COUNT
                       /*-- 급여마스터 공제인원 적용.
                       , CASE
                           WHEN NVL(PMH.DED_FAMILY_COUNT, 0) + NVL(PMH.DED_CHILD_COUNT, 0) > 0 
                             THEN NVL(PMH.DED_FAMILY_COUNT, 0) + (CASE WHEN NVL(PMH.DED_CHILD_COUNT, 0) > 0 THEN NVL(PMH.DED_CHILD_COUNT, 0) - 1 ELSE 0 END)
                           ELSE 1 + NVL(HF1.DED_FAMILY_COUNT, 0) + (CASE WHEN NVL(HF1.DED_CHILD_COUNT, 0) > 0 THEN NVL(HF1.DED_CHILD_COUNT, 0) - 1 ELSE 0 END)
                         END AS DED_PERSON_COUNT*/
                    FROM HRM_PERSON_MASTER     PM
                       , (-- 시점 인사내역.
                          SELECT HL.PERSON_ID
                               , HL.DEPT_ID
                               , HL.FLOOR_ID 
                               , HL.POST_ID
                               , HL.OCPT_ID
                               , HL.ABIL_ID
                               , HL.JOB_CATEGORY_ID
                               , HL.PAY_GRADE_ID
                               , PG.PAY_GRADE
                               , PG.PAY_GRADE_NAME
                               , PG.OFFICER_YN
                          FROM HRM_HISTORY_HEADER HH
                             , HRM_HISTORY_LINE   HL 
                             , HRM_PAY_GRADE_V    PG
                          WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                            AND HL.PAY_GRADE_ID       = PG.PAY_GRADE_ID
                            AND HH.CHARGE_SEQ          IN 
                                  (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                      FROM HRM_HISTORY_HEADER S_HH
                                         , HRM_HISTORY_LINE   S_HL
                                     WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                       AND S_HH.CHARGE_DATE       <= V_PAY_END_DATE
                                       AND S_HL.PERSON_ID         = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )  
                         ) T1 
                      , HRP_PAY_MASTER_HEADER PMH                       
                      , (-- 월근태 내역.
                          SELECT MT.PERSON_ID
                               , MT.DUTY_YYYYMM
                               , MT.CORP_ID
                               , MT.SOB_ID
                               , MT.ORG_ID
                               , MT.PAY_DAY
                               , MT.HOLY_0_COUNT
                            FROM HRD_MONTH_TOTAL MT
                           WHERE MT.DUTY_YYYYMM    = P_PAY_YYYYMM
                             AND MT.DUTY_TYPE      = C_DUTY_MONTH
                             AND MT.CORP_ID        = P_CORP_ID
                             AND ((P_PERSON_ID     IS NULL AND 1 = 1)
                               OR (P_PERSON_ID     IS NOT NULL AND MT.PERSON_ID = P_PERSON_ID))      
                             AND MT.SOB_ID         = P_SOB_ID
                             AND MT.ORG_ID         = P_ORG_ID
                        ) S_MT
                      , ( -- 부양가족.
                        SELECT HF.PERSON_ID
                             , COUNT(HF.PERSON_ID) AS DED_FAMILY_COUNT
                             , SUM(CASE 
                                     WHEN HF.BIRTHDAY IS NULL THEN 0
                                     WHEN EAPP_BIRTH_AGE_F(HF.BIRTHDAY, P_END_DATE, 0) BETWEEN 0 AND 20 THEN 1
                                     ELSE 0
                                   END) AS DED_CHILD_COUNT
                          FROM HRM_FAMILY HF
                        WHERE ((P_PERSON_ID     IS NULL AND 1 = 1)
                            OR (P_PERSON_ID     IS NOT NULL AND HF.PERSON_ID = P_PERSON_ID))                       
                          AND HF.TAX_YN         = 'Y'
                        GROUP BY HF.PERSON_ID
                        ) HF1
                  WHERE PM.PERSON_ID        = T1.PERSON_ID 
                    AND PM.PERSON_ID        = PMH.PERSON_ID
                    AND PM.PERSON_ID        = S_MT.PERSON_ID(+)
                    AND PM.PERSON_ID        = HF1.PERSON_ID(+)
                    AND PMH.START_YYYYMM    <= P_PAY_YYYYMM
                    AND (PMH.END_YYYYMM     >= P_PAY_YYYYMM OR PMH.END_YYYYMM IS NULL)
                    AND PM.CORP_ID          = P_CORP_ID
                    AND ((P_PERSON_ID       IS NULL AND 1 = 1)
                      OR (P_PERSON_ID       IS NOT NULL AND PM.PERSON_ID = P_PERSON_ID))        
                    AND PM.JOIN_DATE        <= V_PAY_END_DATE
                    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= DECODE(P_EXCEPT_YN, 'Y', V_PAY_END_DATE, V_PAY_START_DATE))
                    AND PM.SOB_ID           = P_SOB_ID
                    AND PM.ORG_ID           = P_ORG_ID
                    AND ((P_PAY_TYPE        IS NULL AND 1 = 1)
                      OR (P_PAY_TYPE        IS NOT NULL AND PMH.PAY_TYPE = P_PAY_TYPE))
                    AND ((P_DEPT_ID         IS NULL AND 1 = 1)
                      OR (P_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
                    AND PMH.PAY_PROVIDE_YN  = 'Y'
                    AND NOT EXISTS  -- 이미 마감된 데이터 제외 --
                          ( SELECT 'X'
                              FROM HRP_MONTH_PAYMENT MP
                             WHERE MP.PERSON_ID             = PM.PERSON_ID
                               AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                               AND MP.WAGE_TYPE             = P_WAGE_TYPE
                               AND MP.SOB_ID                = P_SOB_ID
                               AND MP.ORG_ID                = P_ORG_ID
                               AND MP.CLOSED_YN             = 'Y'
                           )
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
        -- 전호수 추가 : 15일 이후 입사자 지급 안함.
        IF TO_CHAR(V_LONG_END_DATE, 'DD') > '15' THEN
          V_LONG_END_DATE := TO_DATE(TO_CHAR(V_LONG_END_DATE, 'YYYY-MM') || '-15', 'YYYY-MM-DD'); 
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
        
        BEGIN
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
          , PAY_DAY
          , DED_PERSON_COUNT
          , PAY_PROVIDE_YN
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
          , C1.PAY_DAY
          , NVL(C1.DED_PERSON_COUNT, 0)
          , NVL(C1.PAY_PROVIDE_YN, 'N')
          , C1.SOB_ID
          , C1.ORG_ID
          , V_SYSDATE
          , P_USER_ID
          , V_SYSDATE
          , P_USER_ID
          );
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';	
          O_MESSAGE := 'Create Error : [' || C1.PERSON_NUM || '-' || C1.NAME || '] ' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;
        -- 전호수 추가(2014-01-31) 통상시급 관리 별도 구성  BEGIN -- 
        -- 급여처리 대상자에 대해 통상시급 항목 생성(금액은 0) : 각 항목 처리시 금액 UPDATE --
        -- 1. 이전 금액 종료기간 UPDATE 
        BEGIN
          UPDATE HRP_GENERAL_HOURLY_PAY HP
             SET HP.PERIOD_TO         = TO_CHAR(ADD_MONTHS(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), -1), 'YYYY-MM')
               , HP.LAST_UPDATE_DATE  = V_SYSDATE
               , HP.LAST_UPDATED_BY   = P_USER_ID
           WHERE HP.PERSON_ID         = C1.PERSON_ID
             AND HP.SOB_ID            = C1.SOB_ID
             AND HP.ORG_ID            = C1.ORG_ID
             AND HP.PERIOD_FR         < P_PAY_YYYYMM
             AND HP.PERIOD_TO         > P_PAY_YYYYMM
          ;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
        
        -- 2. 당월 금액 생성 
        FOR R1 IN ( SELECT HA.ALLOWANCE_ID
                         , NVL(SX1.ALLOWANCE_AMOUNT, 0) AS ALLOWANCE_AMOUNT
                         , NVL((SELECT DISTINCT 	
                                       MIN(TO_CHAR(ADD_MONTHS(TO_DATE(HP.PERIOD_FR, 'YYYY-MM'), -1), 'YYYY-MM')) AS PERIOD_TO 
                                  FROM HRP_GENERAL_HOURLY_PAY HP
                                           WHERE HP.PERSON_ID         = C1.PERSON_ID
                                             AND HP.SOB_ID            = C1.SOB_ID
                                             AND HP.ORG_ID            = C1.ORG_ID
                                             AND HP.PERIOD_FR         >= P_PAY_YYYYMM
                                ), '3999-12') AS PERIOD_TO  
                      FROM HRM_ALLOWANCE_V HA
                         , ( SELECT PML.ALLOWANCE_ID
                                  , PML.ALLOWANCE_AMOUNT
                               FROM HRP_PAY_MASTER_HEADER PMH
                                  , HRP_PAY_MASTER_LINE   PML
                              WHERE PMH.PAY_HEADER_ID     = PML.PAY_HEADER_ID
                                AND PMH.PERSON_ID         = C1.PERSON_ID
                                AND PMH.SOB_ID            = C1.SOB_ID
                                AND PMH.ORG_ID            = C1.ORG_ID 
                                AND PMH.START_YYYYMM      <= P_PAY_YYYYMM
                                AND (PMH.END_YYYYMM       >= P_PAY_YYYYMM OR PMH.END_YYYYMM  IS NULL)
                                AND PML.ALLOWANCE_TYPE    = 'A'
                                AND PML.ENABLED_FLAG      = 'Y' 
                            ) SX1                                
                     WHERE HA.ALLOWANCE_ID        = SX1.ALLOWANCE_ID(+)
                       AND HA.GENERAL_TIME_YN     = 'Y'  -- 통상시급 여부 
                       AND HA.ENABLED_FLAG        = 'Y'
                       AND HA.EFFECTIVE_DATE_FR   <= P_END_DATE
                       AND (HA.EFFECTIVE_DATE_TO  >= P_START_DATE OR HA.EFFECTIVE_DATE_TO IS NULL)
                  )
        LOOP
          MERGE INTO HRP_GENERAL_HOURLY_PAY HP
            USING ( SELECT C1.PERSON_ID  AS PERSON_ID 
                         , C1.SOB_ID     AS SOB_ID 
                         , C1.ORG_ID     AS ORG_ID 
                         , P_PAY_YYYYMM  AS PAY_YYYYMM
                         , R1.ALLOWANCE_ID     AS ALLOWANCE_ID 
                         , R1.ALLOWANCE_AMOUNT AS ALLOWANCE_AMOUNT
                      FROM DUAL
                  ) SX1
            ON    ( HP.PERSON_ID      = SX1.PERSON_ID
                AND HP.SOB_ID         = SX1.SOB_ID
                AND HP.ORG_ID         = SX1.ORG_ID
                AND HP.PERIOD_FR      <= SX1.PAY_YYYYMM
                AND HP.PERIOD_TO      >= SX1.PAY_YYYYMM
                AND HP.ALLOWANCE_ID   = SX1.ALLOWANCE_ID
                  )
          WHEN MATCHED THEN
            UPDATE
               SET ALLOWANCE_AMOUNT   = SX1.ALLOWANCE_AMOUNT
          WHEN NOT MATCHED THEN
            INSERT
            ( GENERAL_HOURLY_PAY_ID 
            , PERSON_ID 
            , SOB_ID 
            , ORG_ID 
            , PERIOD_FR 
            , PERIOD_TO 
            , ENABLED_FLAG 
            , ALLOWANCE_ID 
            , ALLOWANCE_AMOUNT 
            , CREATION_DATE 
            , CREATED_BY 
            , LAST_UPDATE_DATE 
            , LAST_UPDATED_BY 
            ) VALUES
            ( HRP_GENERAL_HOURLY_PAY_S1.NEXTVAL
            , C1.PERSON_ID 
            , C1.SOB_ID
            , C1.ORG_ID 
            , P_PAY_YYYYMM          -- PERIOD FROM 
            , R1.PERIOD_TO         -- PERIOD TO  
            , 'Y'                   -- ENABLED_FLAG 
            , SX1.ALLOWANCE_ID
            , SX1.ALLOWANCE_AMOUNT
            , V_SYSDATE             -- CREATION_DATE 
            , P_USER_ID             -- CREATED_BY 
            , V_SYSDATE             -- LAST_UPDATE_DATE
            , P_USER_ID             -- LAST_UPDATED_BY 
            );   
        END LOOP R1;          
        
        -- 3. 통상시급 아닌 항목은 삭제 -- 
        BEGIN
          UPDATE HRP_GENERAL_HOURLY_PAY HP
             SET HP.ENABLED_FLAG      = 'N'
           WHERE HP.PERSON_ID         = C1.PERSON_ID
             AND HP.SOB_ID            = C1.SOB_ID
             AND HP.ORG_ID            = C1.ORG_ID
             AND HP.PERIOD_FR         <= P_PAY_YYYYMM
             AND HP.PERIOD_TO         >= P_PAY_YYYYMM
             AND NOT EXISTS
                   ( SELECT 'X'
                       FROM HRM_ALLOWANCE_V HA
                      WHERE HA.ALLOWANCE_ID         = HP.ALLOWANCE_ID
                        AND HA.GENERAL_TIME_YN      = 'Y'  -- 통상시급 여부 
                        AND HA.ENABLED_FLAG         = 'Y'
                        AND HA.EFFECTIVE_DATE_FR    <= P_END_DATE
                        AND (HA.EFFECTIVE_DATE_TO   >= P_START_DATE OR HA.EFFECTIVE_DATE_TO IS NULL)
                   )
          ;
        EXCEPTION
          WHEN OTHERS THEN
            NULL;
        END;
        -- 전호수 추가(2014-01-31) 통상시급 관리 별도 구성  END -- 
      END LOOP C1;    
    END IF;
    O_STATUS := 'S';
  END PAYMENT_CREATION;

-- 2 급여 기본자료 생성(급여 마스터 - 지급/공제 항목, 추가 급상여 - 지급/공제 사항)
  PROCEDURE BASIC_PAY_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS 
    V_START_DATE    DATE := NULL;
    V_END_DATE      DATE := NULL;
  BEGIN  
    O_STATUS := 'F';
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
                     , PG.OFFICER_YN
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
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.PAY_TYPE              = PT.PAY_TYPE
                   AND MP.SOB_ID                = PT.SOB_ID
                   AND MP.ORG_ID                = PT.ORG_ID
                   AND MP.PAY_GRADE_ID          = PG.PAY_GRADE_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      -- 시작/종료일자 정리 --
      IF P_START_DATE < C1.JOIN_DATE THEN
        V_START_DATE := C1.JOIN_DATE;
      ELSE
        V_START_DATE := P_START_DATE;
      END IF;
      IF C1.RETIRE_DATE IS NULL OR P_END_DATE < C1.RETIRE_DATE THEN
        V_END_DATE := P_END_DATE;
      ELSE
        V_END_DATE := C1.RETIRE_DATE;
      END IF;
      /*--처리방법 1
      BASIC_PAY_AMOUNT_101
        ( O_STATUS => O_STATUS
        , O_MESSAGE => O_MESSAGE
        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
        , P_CORP_ID => C1.CORP_ID
        , P_PAY_YYYYMM => C1.PAY_YYYYMM
        , P_WAGE_TYPE => C1.WAGE_TYPE
        , P_EXCEPT_TYPE => C1.EXCEPT_TYPE
        , P_PAY_LEVEL => C1.PAY_LEVEL
        , P_OFFICER_YN => C1.OFFICER_YN
        , P_PERSON_ID => C1.PERSON_ID
        , P_SOB_ID => P_SOB_ID
        , P_ORG_ID => P_ORG_ID
        , P_USER_ID => P_USER_ID
        , P_TOTAL_DAY => P_TOTAL_DAY
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
      */
        
      BASIC_PAY_AMOUNT_102
        ( O_STATUS => O_STATUS
        , O_MESSAGE => O_MESSAGE
        , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
        , P_CORP_ID => C1.CORP_ID
        , P_PAY_YYYYMM => C1.PAY_YYYYMM
        , P_WAGE_TYPE => C1.WAGE_TYPE
        , P_EMPLOYE_TYPE => C1.EMPLOYE_TYPE
        , P_EXCEPT_TYPE => C1.EXCEPT_TYPE
        , P_PAY_LEVEL => C1.PAY_LEVEL
        , P_OFFICER_YN => C1.OFFICER_YN
        , P_PERSON_ID => C1.PERSON_ID
        , P_SOB_ID => P_SOB_ID
        , P_ORG_ID => P_ORG_ID
        , P_USER_ID => P_USER_ID
        , P_START_DATE => V_START_DATE
        , P_END_DATE => V_END_DATE
        , P_TOTAL_DAY => P_TOTAL_DAY
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;  
    END LOOP C1;
    O_STATUS := 'S';
  END BASIC_PAY_CREATION;
  
-- 2.1 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_101
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_OFFICER_YN        IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;
    V_DIVISION_VALUE              NUMBER;
  BEGIN
    O_STATUS := 'F';
    -- 급여 마스터 - 기본급 항목 --
    FOR R1 IN ( SELECT MP.PERSON_ID
                     , PML.ALLOWANCE_TYPE
                     , PML.ALLOWANCE_ID
                     , PML.ALLOWANCE_AMOUNT
                     , NVL(HA.GENERAL_TIME_YN, 'N') AS GENERAL_TIME_YN -- 통상시급 여부  
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
                  FROM HRP_MONTH_PAYMENT    MP
                    , HRP_PAY_MASTER_HEADER PMH
                    , HRP_PAY_MASTER_LINE PML
                    , HRM_ALLOWANCE_V       HA
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
                           AND MT.SOB_ID              = P_SOB_ID
                           AND MT.ORG_ID              = P_ORG_ID
                           AND EXISTS 
                                 ( SELECT 'X'
                                      FROM HRM_CLOSING_TYPE_V CT
                                    WHERE CT.CLOSING_TYPE   = MT.DUTY_TYPE
                                      AND CT.SOB_ID         = MT.SOB_ID
                                      AND CT.ORG_ID         = MT.ORG_ID
                                      AND CT.MODULE_TYPE    = 'DUTY'
                                      AND CT.PERIOD_TYPE    = 'MONTH'
                                  )
                        ) DMT
                 WHERE MP.PERSON_ID               = PMH.PERSON_ID
                   AND PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                   AND PML.ALLOWANCE_ID           = HA.ALLOWANCE_ID 
                   AND PMH.PERSON_ID              = DMT.PERSON_ID(+)
                   AND PMH.SOB_ID                 = DMT.SOB_ID(+)
                   AND PMH.ORG_ID                 = DMT.ORG_ID(+)
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.PERSON_ID               = P_PERSON_ID            
                   AND PMH.START_YYYYMM           <= P_PAY_YYYYMM
                   AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                   AND PMH.PERSON_ID              = P_PERSON_ID
                   AND PMH.SOB_ID                 = P_SOB_ID
                   AND PMH.ORG_ID                 = P_ORG_ID
                   AND PML.ENABLED_FLAG           = 'Y'
                   AND HA.ALLOWANCE_TYPE          = 'BASIC'
               )
    LOOP 
      IF R1.GENERAL_TIME_YN = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => R1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => R1.ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => R1.ALLOWANCE_AMOUNT 
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      
      BEGIN
        V_ALLOWANCE_AMOUNT := 0;
        IF P_OFFICER_YN = 'Y' THEN
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF P_PAY_LEVEL = 'YEAR' THEN
        -- 연봉--
          V_DIVISION_VALUE := NVL(R1.TOTAL_DAY, 0) - NVL(R1.STD_HOLY_0_COUNT, 0);
          IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
            V_DIVISION_VALUE := P_TOTAL_DAY;
          END IF;
          IF NVL(R1.TOTAL_DED_DAY, 0) > 0 THEN
            V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * NVL(R1.PAY_DAY, 0);
          ELSE
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
          END IF;
        ELSIF P_PAY_LEVEL = 'MONTH' THEN
        -- 월급--
          V_DIVISION_VALUE := NVL(R1.TOTAL_DAY, 0) - NVL(R1.STD_HOLY_0_COUNT, 0);
          IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
            V_DIVISION_VALUE := P_TOTAL_DAY;
          END IF;
          IF NVL(R1.TOTAL_DED_DAY, 0) > 0 THEN
            V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * NVL(R1.PAY_DAY, 0);
          ELSE
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
          END IF;
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';	
        O_MESSAGE := '101.Base amount error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP R1;
    O_STATUS := 'S';
  END BASIC_PAY_AMOUNT_101;
  
-- 2.2 급여 기본급 생성
  PROCEDURE BASIC_PAY_AMOUNT_102
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_EMPLOYE_TYPE      IN HRP_MONTH_PAYMENT.EMPLOYE_TYPE%TYPE
            , P_EXCEPT_TYPE       IN HRP_MONTH_PAYMENT.EXCEPT_TYPE%TYPE
            , P_PAY_LEVEL         IN HRM_COMMON.VALUE1%TYPE
            , P_OFFICER_YN        IN HRM_COMMON.CODE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;
    V_DIVISION_VALUE              NUMBER;
    
    V_PAY_DAY                     NUMBER;
    V_HOLY_1_COUNT                NUMBER;
    V_HOLIDAY_ALLOWANCE_ID        NUMBER;
    V_HOLIDAY_ALLOWANCE_AMOUNT    NUMBER;
  BEGIN 
    O_STATUS := 'F';
    -- 주휴수당 항목 ID;
    V_HOLIDAY_ALLOWANCE_ID := HRM_COMMON_G.GET_ID_F('ALLOWANCE', 'VALUE2 = ''HOLIDAY''', P_SOB_ID, P_ORG_ID);
    -- 급여 마스터 - 기본급 항목 --
    FOR R1 IN ( SELECT MP.PERSON_ID
                     , PML.ALLOWANCE_TYPE
                     , PML.ALLOWANCE_ID
                     , PML.ALLOWANCE_AMOUNT
                     , NVL(HA.GENERAL_TIME_YN, 'N') AS GENERAL_TIME_YN -- 통상시급 여부  
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
                     , NVL(DMT.DUTY_11_COUNT, 0) AS DUTY_11_COUNT
                  FROM HRP_MONTH_PAYMENT    MP
                    , HRP_PAY_MASTER_HEADER PMH
                    , HRP_PAY_MASTER_LINE   PML
                    , HRM_ALLOWANCE_V       HA
                    , ( SELECT MT.PERSON_ID
                             , MT.DUTY_YYYYMM
                             , MT.CORP_ID
                             , MT.SOB_ID
                             , MT.ORG_ID
                             , MT.STD_HOLY_0_COUNT
                             , MT.HOLY_0_COUNT
                             , MT.HOLY_1_COUNT AS MONTH_HOLY_1_COUNT
                             , MT.HOLY_1_COUNT AS HOLY_1_COUNT
                             /*, NVL(SX2.HOLY_1_COUNT, 0) AS HOLY_1_COUNT*/
                             , MT.HOLY_0_DED_FLAG
                             , MT.CHANGE_DED_COUNT
                             , MT.WEEKLY_DED_COUNT
                             , MT.TOTAL_ATT_DAY
                             , MT.TOTAL_DED_DAY
                             , MT.TOTAL_DAY
                             , MT.PAY_DAY
                             , MT.WORK_DATE_FR
                             , MT.WORK_DATE_TO
                             , ( SELECT SUM(MTD.DUTY_COUNT) AS DUTY_COUNT
                                   FROM HRD_MONTH_TOTAL_DUTY MTD
                                     , HRM_DUTY_CODE_V DC
                                 WHERE MTD.DUTY_ID          = DC.DUTY_ID
                                   AND MTD.MONTH_TOTAL_ID   = MT.MONTH_TOTAL_ID
                                   AND DC.DUTY_CODE         = '11'
                               ) AS DUTY_11_COUNT
                             /*, ( SELECT COUNT(WC.WORK_DATE) AS HOLY_1_COUNT
                                    FROM HRD_WORK_CALENDAR WC
                                  WHERE WC.WORK_DATE            BETWEEN MT.WORK_DATE_FR AND MT.WORK_DATE_TO
                                    AND WC.PERSON_ID            = MT.PERSON_ID
                                    AND WC.SOB_ID               = MT.SOB_ID
                                    AND WC.ORG_ID               = MT.ORG_ID
                                    AND NOT EXISTS 
                                          ( SELECT 'X'
                                              FROM HRD_HOLIDAY_CALENDAR HC
                                            WHERE HC.WORK_DATE    = WC.WORK_DATE
                                              AND HC.SOB_ID       = WC.SOB_ID
                                              AND HC.ORG_ID       = WC.ORG_ID
                                          )
                                    AND WC.HOLY_TYPE            IN '1'
                                  ) AS HOLY_1_COUNT*/
                          FROM HRD_MONTH_TOTAL MT
                            /*-- 전호수 수정 : 근태마감 기간에 대한 주휴수당 계산 위해.
                            , ( SELECT WC.PERSON_ID
                                     , COUNT(WC.WORK_DATE) AS HOLY_1_COUNT
                                  FROM HRD_WORK_CALENDAR WC
                                WHERE WC.WORK_DATE            BETWEEN P_START_DATE AND P_END_DATE
                                  AND WC.PERSON_ID            = P_PERSON_ID
                                  AND WC.SOB_ID               = P_SOB_ID
                                  AND WC.ORG_ID               = P_ORG_ID
                                  AND NOT EXISTS 
                                        ( SELECT 'X'
                                            FROM HRD_HOLIDAY_CALENDAR HC
                                          WHERE HC.WORK_DATE    = WC.WORK_DATE
                                            AND HC.SOB_ID       = WC.SOB_ID
                                            AND HC.ORG_ID       = WC.ORG_ID
                                        )
                                  AND WC.HOLY_TYPE            IN '1'
                                GROUP BY WC.PERSON_ID
                                ) SX2*/
                        WHERE /*MT.PERSON_ID           = SX2.PERSON_ID(+)
                          AND */MT.DUTY_YYYYMM         = P_PAY_YYYYMM
                          AND MT.PERSON_ID           = P_PERSON_ID
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
                 WHERE MP.PERSON_ID               = PMH.PERSON_ID
                   AND PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                   AND PML.ALLOWANCE_ID           = HA.ALLOWANCE_ID 
                   AND PMH.PERSON_ID              = DMT.PERSON_ID(+)
                   AND PMH.SOB_ID                 = DMT.SOB_ID(+)
                   AND PMH.ORG_ID                 = DMT.ORG_ID(+)
                   AND MP.PAY_YYYYMM              = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE               = P_WAGE_TYPE
                   AND MP.PERSON_ID               = P_PERSON_ID
                   AND PMH.START_YYYYMM           <= P_PAY_YYYYMM
                   AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= P_PAY_YYYYMM)
                   AND PMH.PERSON_ID              = P_PERSON_ID
                   AND PMH.SOB_ID                 = P_SOB_ID
                   AND PMH.ORG_ID                 = P_ORG_ID
                   AND PML.ENABLED_FLAG           = 'Y'
                   AND HA.ALLOWANCE_TYPE          = 'BASIC'
               )
    LOOP  
      IF R1.GENERAL_TIME_YN = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => R1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => R1.ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => R1.ALLOWANCE_AMOUNT 
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
          
      V_ALLOWANCE_AMOUNT := 0;
      V_HOLIDAY_ALLOWANCE_AMOUNT := 0;
      V_PAY_DAY := 0;
      V_HOLY_1_COUNT := 0;
      
      BEGIN
        -- 주휴일수 중에 미주차 제외한 일수 정리.
        V_HOLY_1_COUNT := NVL(R1.HOLY_1_COUNT, 0) - NVL(R1.WEEKLY_DED_COUNT, 0);
        IF V_HOLY_1_COUNT < 0 THEN
          V_HOLY_1_COUNT := 0;
        END IF;
        IF P_OFFICER_YN = 'Y' THEN
          -- 임원.
          IF P_EXCEPT_TYPE IN ('I', 'R') THEN
            V_DIVISION_VALUE := NVL(P_TOTAL_DAY, 0);
            V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * (NVL(R1.PAY_DAY, 0) + NVL(R1.HOLY_0_COUNT, 0));
          ELSE
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
          END IF;
        ELSIF P_PAY_LEVEL = 'YEAR' THEN
        -- 연봉--
          IF P_EXCEPT_TYPE IN ('I', 'R') THEN
            V_DIVISION_VALUE := NVL(P_TOTAL_DAY, 0);
            V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * (NVL(R1.PAY_DAY, 0) + NVL(R1.HOLY_0_COUNT, 0));
          ELSE
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
          END IF;
        ELSIF P_PAY_LEVEL = 'MONTH' THEN
        -- 월급--
          IF P_EXCEPT_TYPE IN ('I', 'R') THEN
            V_DIVISION_VALUE := NVL(P_TOTAL_DAY, 0);
            IF NVL(V_DIVISION_VALUE, 0) <= 0 THEN
              V_DIVISION_VALUE := P_TOTAL_DAY;
            END IF;
            V_ALLOWANCE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / V_DIVISION_VALUE) * (NVL(R1.PAY_DAY, 0) + NVL(R1.HOLY_0_COUNT, 0));
          ELSE
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0);
          END IF;
        ELSIF P_PAY_LEVEL = 'DAILY' THEN
        -- 일급--
          IF NVL(R1.PAY_DAY, 0) >= V_HOLY_1_COUNT THEN
            V_PAY_DAY := NVL(R1.PAY_DAY, 0) - V_HOLY_1_COUNT;
          ELSE
            V_HOLY_1_COUNT := V_HOLY_1_COUNT - NVL(R1.PAY_DAY, 0);
            V_PAY_DAY := 0;
          END IF;
          V_ALLOWANCE_AMOUNT := V_PAY_DAY * NVL(R1.ALLOWANCE_AMOUNT, 0);
          V_HOLIDAY_ALLOWANCE_AMOUNT := V_HOLY_1_COUNT * NVL(R1.ALLOWANCE_AMOUNT, 0);
        ELSIF P_PAY_LEVEL = 'TIME' THEN
        -- 시급--
          IF NVL(R1.PAY_DAY, 0) >= V_HOLY_1_COUNT THEN
            V_PAY_DAY := NVL(R1.PAY_DAY, 0) - V_HOLY_1_COUNT;
          ELSE
            V_HOLY_1_COUNT := V_HOLY_1_COUNT - NVL(R1.PAY_DAY, 0);
            V_PAY_DAY := 0;
          END IF;
          V_ALLOWANCE_AMOUNT := V_PAY_DAY * NVL(R1.ALLOWANCE_AMOUNT, 0) * 8;
          V_HOLIDAY_ALLOWANCE_AMOUNT := V_HOLY_1_COUNT * NVL(R1.ALLOWANCE_AMOUNT, 0) * 8;
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '102 Base amount error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP R1;
    O_STATUS := 'S';
  END BASIC_PAY_AMOUNT_102;

-- 3 기본급이외 기본자료 생성
  PROCEDURE ETC_PAY_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
    O_STATUS := 'F';
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
                 WHERE MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      IF C1.EMPLOYE_TYPE = '2' AND C1.PAY_TYPE IN('2', '4') THEN
        NULL;
      ELSE
        -- 급여 마스터 - 지급/공제 항목 --
        FOR R1 IN ( SELECT PML.ALLOWANCE_TYPE
                         , PML.ALLOWANCE_ID
                         , PML.ALLOWANCE_AMOUNT
                         , HA.ALLOWANCE_TYPE AS M_ALLOWANCE_TYPE   -- 지급항목 타입.
                         , HD.DEDUCTION_TYPE
                         , NVL(HA.GENERAL_TIME_YN, 'N') AS GENERAL_TIME_YN 
                      FROM HRP_PAY_MASTER_HEADER PMH
                        , HRP_PAY_MASTER_LINE PML
                        , HRM_ALLOWANCE_V HA
                        , HRM_DEDUCTION_V HD
                     WHERE PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                       AND PML.ALLOWANCE_ID           = HA.ALLOWANCE_ID(+)
                       AND PML.ALLOWANCE_ID           = HD.DEDUCTION_ID(+)
                       AND PMH.START_YYYYMM           <= C1.PAY_YYYYMM
                       AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= C1.PAY_YYYYMM)
                       AND PMH.PERSON_ID              = C1.PERSON_ID
                       AND PMH.SOB_ID                 = P_SOB_ID
                       AND PMH.ORG_ID                 = P_ORG_ID
                       AND PML.ENABLED_FLAG           = 'Y'
                       AND NOT EXISTS 
                             ( SELECT 'X'
                                 FROM HRM_ALLOWANCE_V HA 
                               WHERE PML.ALLOWANCE_ID     = HA.ALLOWANCE_ID
                                 AND HA.ALLOWANCE_TYPE    IN('BASIC', 'LONG', 'BONUS')
                            )
                   )
        LOOP 
          IF R1.ALLOWANCE_TYPE = 'A' THEN
          -- 지급 항목 --
            IF R1.GENERAL_TIME_YN = 'Y' THEN
            -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
              HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
                ( O_STATUS            => O_STATUS
                , O_MESSAGE           => O_MESSAGE
                , P_PERSON_ID         => C1.PERSON_ID 
                , P_SOB_ID            => P_SOB_ID 
                , P_ORG_ID            => P_ORG_ID 
                , P_PAY_YYYYMM        => P_PAY_YYYYMM
                , P_ALLOWANCE_ID      => R1.ALLOWANCE_ID 
                , P_ALLOWANCE_AMOUNT  => R1.ALLOWANCE_AMOUNT 
                , P_USER_ID           => P_USER_ID
                );
              IF O_STATUS = 'F' THEN
                RETURN;
              END IF;
            END IF;
            
            BEGIN    
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
            EXCEPTION WHEN OTHERS THEN
              O_STATUS := 'F';
              O_MESSAGE := '1.1 ETC Allowance pay : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;
            END;  
          ELSE
          -- 공제 항목 --
            BEGIN
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
            EXCEPTION WHEN OTHERS THEN
              O_STATUS := 'F';
              O_MESSAGE := '1.2 ETC Dedution pay : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;
            END;                  
          END IF;
        END LOOP R1;
      END IF;
      
      -- 추가 지급 항목 --
      FOR R1 IN ( SELECT PAA.ALLOWANCE_ID
                       , SUM(PAA.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT
                    FROM HRP_PAYMENT_ADD_ALLOWANCE PAA
                   WHERE PAA.PAY_YYYYMM             = C1.PAY_YYYYMM
                     AND PAA.WAGE_TYPE              = C1.WAGE_TYPE
                     AND PAA.PERSON_ID              = C1.PERSON_ID
                     AND PAA.SOB_ID                 = P_SOB_ID
                     AND PAA.ORG_ID                 = P_ORG_ID
                  GROUP BY PAA.ALLOWANCE_ID
               )
      LOOP 
        BEGIN 
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
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := '2.1 ETC Allowance pay : ' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;                    
      END LOOP R1;

      -- 추가 공제 항목 --
      FOR R1 IN ( SELECT PAD.DEDUCTION_ID
                       , PAD.DEDUCTION_AMOUNT
                  FROM HRP_PAYMENT_ADD_DEDUCTION PAD
                 WHERE PAD.PAY_YYYYMM             = C1.PAY_YYYYMM
                   AND PAD.WAGE_TYPE              = C1.WAGE_TYPE
                   AND PAD.PERSON_ID              = C1.PERSON_ID
                   AND PAD.SOB_ID                 = P_SOB_ID
                   AND PAD.ORG_ID                 = P_ORG_ID
               )
      LOOP 
        BEGIN 
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
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := '2.2 ETC Dedution pay : ' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;      
      END LOOP R1;                   
    END LOOP C1;
    
    -- 추가 지급 항목(업체 고유 지급 항목 : ALLOWANCE_ETC) --
    FOR C1 IN ( SELECT HA.ALLOWANCE_ID
                     , NVL(HA.GENERAL_TIME_YN, 'N') AS GENERAL_TIME_YN     -- 통상시급 여부  
                     , AE.ALLOWANCE_ETC
                     , AE.ALLOWANCE_CODE
                     , AE.ALLOWANCE_CLASS
                     , AE.FORMULA1  -- 값3.
                     , AE.FORMULA2  -- 값4.
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
      IF C1.ALLOWANCE_ETC = '101' THEN
        -- 70 관리직 휴일특근비.
        MANAGEMENT_HOLIDAY_ALLOWANCE
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WORK_DATE_FR      => P_START_DATE
          , P_WORK_DATE_TO      => P_END_DATE
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_PAY_TYPE          => P_PAY_TYPE
          , P_DEPT_ID           => P_DEPT_ID
          , P_PERSON_ID         => P_PERSON_ID
          , P_STD_DATE          => P_STD_DATE
          , P_EXCEPT_YN         => P_EXCEPT_YN
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , P_GENERAL_TIME_YN   => C1.GENERAL_TIME_YN
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;  
      ELSIF C1.ALLOWANCE_ETC = '110' THEN
        -- 71 직책수당.
        JOB_ALLOWANCE
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_PAY_TYPE          => P_PAY_TYPE
          , P_DEPT_ID           => P_DEPT_ID
          , P_PERSON_ID         => P_PERSON_ID
          , P_STD_DATE          => P_STD_DATE
          , P_EXCEPT_YN         => P_EXCEPT_YN
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID          
          , P_GENERAL_TIME_YN   => C1.GENERAL_TIME_YN
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;  
      ELSIF C1.ALLOWANCE_ETC = '120' THEN
      -- 72 생산장려수당.
        PROMOTE_ALLOWANCE 
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_START_DATE        => P_START_DATE
          , P_END_DATE          => P_END_DATE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_STD_TIME          => C1.FORMULA1  -- 기준시간.
          , P_STD_LATE_TIME     => C1.FORMULA2  -- 지각.
          , P_STD_LEAVE_TIME    => C1.FORMULA3  -- 외출.
          , P_STD_DED_11_COUNT  => C1.FORMULA4  -- 결근.
          , P_PAY_TYPE          => P_PAY_TYPE
          , P_DEPT_ID           => P_DEPT_ID
          , P_PERSON_ID         => P_PERSON_ID
          , P_STD_DATE          => P_STD_DATE
          , P_EXCEPT_YN         => P_EXCEPT_YN
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , P_GENERAL_TIME_YN   => C1.GENERAL_TIME_YN
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;  
      ELSIF C1.ALLOWANCE_ETC = '130' THEN
      -- 73 자기개발수당.
        SELF_DEV_ALLOWANCE
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_AGE               => C1.FORMULA1    -- 나이.
          , P_SEX_TYPE          => C1.FORMULA2    -- 성별.
          , P_PAY_TYPE          => P_PAY_TYPE
          , P_DEPT_ID           => P_DEPT_ID
          , P_PERSON_ID         => P_PERSON_ID
          , P_STD_DATE          => P_STD_DATE
          , P_EXCEPT_YN         => P_EXCEPT_YN
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , P_GENERAL_TIME_YN   => C1.GENERAL_TIME_YN
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;  
      ELSIF C1.ALLOWANCE_ETC = '140' THEN
      -- 74 복지수당.
        WELFARE_ALLOWANCE
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_START_DATE        => P_START_DATE
          , P_END_DATE          => P_END_DATE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_WORKING_RATE      => C1.FORMULA1    -- 근무율.
          , P_LONG_MONTH        => C1.FORMULA2    -- 근속월수.
          , P_PAY_TYPE          => P_PAY_TYPE
          , P_DEPT_ID           => P_DEPT_ID
          , P_PERSON_ID         => P_PERSON_ID
          , P_STD_DATE          => P_STD_DATE
          , P_EXCEPT_YN         => P_EXCEPT_YN
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , P_GENERAL_TIME_YN   => C1.GENERAL_TIME_YN
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;  
      ELSIF C1.ALLOWANCE_ETC = '150' THEN
      -- 75 검사수당.
        INSPECTION_ALLOWANCE
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_ALLOWANCE_ID      => C1.ALLOWANCE_ID
          , P_PAY_TYPE          => P_PAY_TYPE
          , P_DEPT_ID           => P_DEPT_ID
          , P_PERSON_ID         => P_PERSON_ID
          , P_STD_DATE          => P_STD_DATE
          , P_EXCEPT_YN         => P_EXCEPT_YN
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , P_GENERAL_TIME_YN   => C1.GENERAL_TIME_YN
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;  
      END IF;
    END LOOP C1;   
    O_STATUS := 'S';   
  END ETC_PAY_CREATION;
  
-- 11 근속수당 생성
  PROCEDURE LONG_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
    V_LIMIT_AMOUNT                NUMBER := 0;  -- 한도금액.
    V_ALLOWANCE_ID                NUMBER := 0;  -- 수당 ID.
    V_ALLOWANCE_CODE              VARCHAR2(10) := NULL;  -- 수당 CODE.
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
    V_GENERAL_TIME_YN             VARCHAR2(2);  -- 통상시급 여부 
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT HA.ALLOWANCE_ID
           , HA.ALLOWANCE_CODE 
           , HA.GENERAL_TIME_YN 
        INTO V_ALLOWANCE_ID
           , V_ALLOWANCE_CODE
           , V_GENERAL_TIME_YN
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
      O_STATUS := 'F';
      O_MESSAGE := 'Long Allowace ID Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    -- 수당 한도 조회.
    V_LIMIT_AMOUNT := HRP_PAYMENT_G_SET.LIMIT_AMOUNT_F ( P_STD_DATE, V_ALLOWANCE_CODE, P_SOB_ID, P_ORG_ID);
    
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.EXCEPT_TYPE
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.LONG_YEAR
                     , PM.ORI_JOIN_DATE
                     , PM.RETIRE_DATE
                     , HRM_COMMON_G.GET_CODE_F(PM.JOIN_ROUTE_ID, PM.SOB_ID, PM.ORG_ID) AS JOIN_ROUTE_CODE
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                    , HRM_PAY_TYPE_V PT
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.PAY_TYPE              = PT.PAY_TYPE
                   AND MP.SOB_ID                = PT.SOB_ID
                   AND MP.ORG_ID                = PT.ORG_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND PT.LONG_ALLOWANCE_YN     = 'Y'
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      BEGIN
        V_ALLOWANCE_AMOUNT := HRP_PAYMENT_G_SET.LONG_ALLOWANCE_F( P_STD_DATE, C1.LONG_YEAR, P_SOB_ID, P_ORG_ID);      
        IF NVL(V_LIMIT_AMOUNT, 0) > -1 AND NVL(V_ALLOWANCE_AMOUNT, 0) > NVL(V_LIMIT_AMOUNT, 0) THEN
          V_ALLOWANCE_AMOUNT := NVL(V_LIMIT_AMOUNT, 0);
        END IF ;
        
        
        IF C1.LONG_YEAR < 1 AND C1.JOIN_ROUTE_CODE != '50' THEN
        -- 근속1년 미만이면서 파견추천이 아니면 근속수당 지급 안함.
          V_ALLOWANCE_AMOUNT := 0;
        END IF;
        
        IF NVL(V_GENERAL_TIME_YN, 'N') = 'Y' THEN
        -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
          HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
            ( O_STATUS            => O_STATUS
            , O_MESSAGE           => O_MESSAGE
            , P_PERSON_ID         => C1.PERSON_ID 
            , P_SOB_ID            => P_SOB_ID 
            , P_ORG_ID            => P_ORG_ID 
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_ALLOWANCE_ID      => V_ALLOWANCE_ID 
            , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT 
            , P_USER_ID           => P_USER_ID
            );
          IF O_STATUS = 'F' THEN
            RETURN;
          END IF;
        END IF;
        
        IF C1.EXCEPT_TYPE = 'I' AND '15' < TO_CHAR(C1.ORI_JOIN_DATE, 'DD') THEN
          -- 15일 이후 입사자만 제외.
          V_ALLOWANCE_AMOUNT := 0;
        ELSIF C1.RETIRE_DATE IS NOT NULL AND C1.EXCEPT_TYPE = 'R' AND '15' > TO_CHAR(C1.RETIRE_DATE, 'DD') THEN
          -- 15일 이전 퇴사자만 제외.
          V_ALLOWANCE_AMOUNT := 0;
        END IF;
        
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Long term error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;      
    END LOOP C1;
    O_STATUS := 'S'; 
  END LONG_ALLOWANCE;


-- 16 가족수당 생성
  PROCEDURE FAMILY_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
    V_STD_FAMILY_AMOUNT           NUMBER := 0;  -- 가족 기준 수당.
    V_LIMIT_AMOUNT                NUMBER := 0;  -- 한도금액.
    V_ALLOWANCE_ID                NUMBER := 0;  -- 가족수당 ID.
    V_ALLOWANCE_CODE              VARCHAR2(10) := NULL;  -- 가족수당 CODE.
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
    V_GENERAL_TIME_YN             VARCHAR2(2);  -- 통상시급 여부 
  BEGIN
    BEGIN
      SELECT HA.ALLOWANCE_ID
           , HA.ALLOWANCE_CODE
           , HA.GENERAL_TIME_YN 
        INTO V_ALLOWANCE_ID
           , V_ALLOWANCE_CODE
           , V_GENERAL_TIME_YN
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
      O_STATUS := 'F';
      O_MESSAGE := 'Family Allowace ID Error : ' || SUBSTR(SQLERRM, 1, 150);
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
                 WHERE MP.PAY_TYPE              = PT.PAY_TYPE
                   AND MP.SOB_ID                = PT.SOB_ID
                   AND MP.ORG_ID                = PT.ORG_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND PT.FAMILY_ALLOWANCE_YN   = 'Y'
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND MP.EXCEPT_TYPE           NOT IN ('I', 'R')
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
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
      
      IF NVL(V_GENERAL_TIME_YN, 'N') = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => C1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => V_ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT 
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
        
      BEGIN
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
      EXCEPTION
        WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Family Amount Error : ' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
  END FAMILY_ALLOWANCE;

-- 21 상여금 생성
  PROCEDURE BONUS_PAY_CREATION
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
    V_ALLOWANCE_AMOUNT            HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE;
  BEGIN
    O_STATUS := 'F';
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
                 WHERE MP.PAY_TYPE              = PT.PAY_TYPE
                   AND MP.SOB_ID                = PT.SOB_ID
                   AND MP.ORG_ID                = PT.ORG_ID
                   AND MP.PAY_GRADE_ID          = PG.PAY_GRADE_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      -- 급여 마스터 - 지급/공제 항목 --
      FOR R1 IN ( SELECT PML.ALLOWANCE_TYPE
                       , PML.ALLOWANCE_ID
                       , PML.ALLOWANCE_AMOUNT
                       , NVL(HA.GENERAL_TIME_YN, 'N') AS GENERAL_TIME_YN 
                    FROM HRP_PAY_MASTER_HEADER PMH
                      , HRP_PAY_MASTER_LINE    PML
                      , HRM_ALLOWANCE_V        HA
                   WHERE PMH.PAY_HEADER_ID          = PML.PAY_HEADER_ID
                     AND PML.ALLOWANCE_ID           = HA.ALLOWANCE_ID
                     AND PMH.START_YYYYMM           <= C1.PAY_YYYYMM
                     AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= C1.PAY_YYYYMM)
                     AND PMH.PERSON_ID              = C1.PERSON_ID
                     AND PMH.SOB_ID                 = P_SOB_ID
                     AND PMH.ORG_ID                 = P_ORG_ID
                     AND PML.ENABLED_FLAG           = 'Y'
                     AND HA.ALLOWANCE_TYPE          = 'BONUS'
                 )
      LOOP 
        IF NVL(R1.GENERAL_TIME_YN, 'N') = 'Y' THEN
        -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
          HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
            ( O_STATUS            => O_STATUS
            , O_MESSAGE           => O_MESSAGE
            , P_PERSON_ID         => C1.PERSON_ID 
            , P_SOB_ID            => P_SOB_ID 
            , P_ORG_ID            => P_ORG_ID 
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_ALLOWANCE_ID      => R1.ALLOWANCE_ID 
            , P_ALLOWANCE_AMOUNT  => R1.ALLOWANCE_AMOUNT 
            , P_USER_ID           => P_USER_ID
            );
          IF O_STATUS = 'F' THEN
            RETURN;
          END IF;
        END IF;
        
        V_ALLOWANCE_AMOUNT := 0;
        BEGIN
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
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Bonus pay error : ' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;
      END LOOP R1;
    END LOOP C1;  
    O_STATUS := 'S'; 
  END BONUS_PAY_CREATION;


-- 30 통상시급수당 생성
  PROCEDURE GENERAL_HOURLY_AMOUNT 
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
  BEGIN
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID                     
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                 WHERE MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      BEGIN
        UPDATE HRP_MONTH_PAYMENT MP
          SET MP.GENERAL_HOURLY_AMOUNT = HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F
                                                          ( C1.PAY_YYYYMM
                                                          , C1.PERSON_ID
                                                          , P_SOB_ID
                                                          , P_ORG_ID
                                                          )
        WHERE MP.MONTH_PAYMENT_ID   = C1.MONTH_PAYMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'General hourly error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
  END GENERAL_HOURLY_AMOUNT;

  
-- 31 근태수당 생성
  PROCEDURE DUTY_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
    V_HOURLY_PAY_AMOUNT           NUMBER := 0;
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN       
    O_STATUS := 'F';    
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
                 WHERE MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      -- 연장 수당 계산.
      FOR R1 IN ( SELECT MTO.PERSON_ID
                       , CASE 
                           WHEN C1.PAY_TYPE IN ('1', '3') THEN OT.ALLOWANCE_10_ID
                           ELSE OT.ALLOWANCE_20_ID
                         END ALLOWANCE_ID
                       , CASE 
                           WHEN C1.PAY_TYPE IN ('1', '3') THEN OT.ALLOWANCE_10_CODE
                           ELSE OT.ALLOWANCE_20_CODE
                         END ALLOWANCE_CODE
                       , CASE
                           WHEN C1.PAY_TYPE IN('1', '3') THEN NVL(SUM(NVL(MTO.OT_TIME, 0)  * NVL(OT.ALLOWANCE_RATE_10, 0)), 0)
                           ELSE NVL(SUM(NVL(MTO.OT_TIME, 0)  * NVL(OT.ALLOWANCE_RATE_20, 0)), 0)
                         END AS OT_TIME
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
        BEGIN
          -- 근태 수당 --
          IF R1.ALLOWANCE_CODE IN('A17') THEN
            -- 근태공제 : 시급
            V_ALLOWANCE_AMOUNT := NVL(HRP_PAYMENT_G_SET.HOURLY_PAY_AMOUNT_F(C1.PAY_YYYYMM, C1.PERSON_ID, C1.SOB_ID, C1.ORG_ID), 0) * NVL(R1.OT_TIME, 0);
          ELSE
            -- 통상시급 적용.
            V_ALLOWANCE_AMOUNT := NVL(C1.GENERAL_HOURLY_AMOUNT, 0) * NVL(R1.OT_TIME, 0);
          END IF;
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
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Duty Allowance Error : ' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;
      END LOOP R1;      
    END LOOP C1; 
    O_STATUS := 'S'; 
  END DUTY_ALLOWANCE;
  

-- 41 지급항목 일할계산 
  PROCEDURE DAILY_PAY_CALCULATE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
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
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            )
  AS
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM                     
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.DEPT_ID
                     , MP.POST_ID
                     , MP.JOB_CATEGORY_ID
                     , HRM_COMMON_G.GET_CODE_F(PM.JOIN_ID, PM.SOB_ID, PM.ORG_ID) AS JOIN_CODE
                     , PM.ORI_JOIN_DATE AS JOIN_DATE
                     , PM.RETIRE_DATE
                     , ADD_MONTHS(PM.ORI_JOIN_DATE, 3) AS JOIN_3RD_DATE
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
                    , HRM_PERSON_MASTER PM
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
                           AND MT.PERSON_ID           = NVL(P_PERSON_ID, MT.PERSON_ID)
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
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.PAY_TYPE              = PT.PAY_TYPE
                   AND MP.SOB_ID                = PT.SOB_ID
                   AND MP.ORG_ID                = PT.ORG_ID
                   AND MP.PAY_GRADE_ID          = PG.PAY_GRADE_ID
                   AND MP.PERSON_ID             = DMT.PERSON_ID(+)
                   AND MP.SOB_ID                = DMT.SOB_ID(+)
                   AND MP.ORG_ID                = DMT.ORG_ID(+)
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND PG.PAY_GRADE             NOT IN ('SA')
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      IF C1.EXCEPT_TYPE IN ('I', 'R') OR NVL(P_TOTAL_DAY, 0) <> NVL(C1.TOTAL_DAY, 0) OR NVL(C1.TOTAL_DED_DAY, 0) > 0 THEN
        IF C1.PAY_TYPE IN ('1', '3') AND C1.EXCEPT_TYPE = 'N' THEN
        -- 월급직/중도 입/퇴사가 아니면 적용 안함.
          NULL;
        ELSE
          DAILY_PAY_CALCULATE_102
            ( O_STATUS => O_STATUS
            , O_MESSAGE => O_MESSAGE
            , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
            , P_CORP_ID => C1.CORP_ID
            , P_PAY_YYYYMM => C1.PAY_YYYYMM
            , P_WAGE_TYPE => C1.WAGE_TYPE
            , P_START_DATE => P_START_DATE
            , P_END_DATE => P_END_DATE
            , P_TOTAL_DAY => P_TOTAL_DAY
            , P_PAY_DAY => C1.PAY_DAY
            , P_HOLY_0_COUNT => C1.HOLY_0_COUNT
            , P_PAY_GRADE => C1.PAY_GRADE
            , P_PAY_LEVEL => C1.PAY_LEVEL
            , P_PERSON_ID => C1.PERSON_ID
            , P_SOB_ID => P_SOB_ID
            , P_ORG_ID => P_ORG_ID
            , P_USER_ID => P_USER_ID
            );
          IF O_STATUS = 'F' THEN
            RETURN;
          END IF;
        END IF;
      END IF;
        
      -- 연봉제 신입 => 3개월 미만 90% 지급.(입사일자 ~ 3개월 일자까지 90% 지급).
      -- EX.2011-06-19입사 => 2011-09급여처리시 2011-09-16일까지 90%, 나머지 100% 지급.
      IF C1.PAY_TYPE IN('1', '3') AND C1.JOIN_CODE = '10' AND P_START_DATE < C1.JOIN_3RD_DATE THEN
        DAILY_PAY_CALCULATE_101
          ( O_STATUS => O_STATUS
          , O_MESSAGE => O_MESSAGE
          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
          , P_CORP_ID => C1.CORP_ID
          , P_PAY_YYYYMM => C1.PAY_YYYYMM
          , P_WAGE_TYPE => C1.WAGE_TYPE
          , P_JOIN_3RD_DATE => C1.JOIN_3RD_DATE
          , P_RETIRE_DATE => C1.RETIRE_DATE
          , P_START_DATE => P_START_DATE
          , P_END_DATE => P_END_DATE
          , P_TOTAL_DAY => P_TOTAL_DAY
          , P_PAY_DAY => C1.PAY_DAY
          , P_PAY_GRADE => C1.PAY_GRADE
          , P_PAY_LEVEL => C1.PAY_LEVEL
          , P_PERSON_ID => C1.PERSON_ID
          , P_SOB_ID => P_SOB_ID
          , P_ORG_ID => P_ORG_ID
          , P_USER_ID => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
    END LOOP C1;
    O_STATUS := 'S';
  END DAILY_PAY_CALCULATE;
  
-- 41.1 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_101
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_JOIN_3RD_DATE     IN DATE
            , P_RETIRE_DATE       IN DATE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
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
    V_PAYMENT_RATE                NUMBER := 90;  -- %.
    V_ROOKIE_DAY                  NUMBER := 0;  -- 수습일수.
    V_ROOKIE_AMOUNT               NUMBER := 0;  -- 수습금액.
    V_ALLOWANCE_AMOUNT            NUMBER := 0;  -- 수습 이외 금액.
  BEGIN
    O_STATUS := 'F';
    -- 기본급이외 항목 --
    FOR R1 IN ( SELECT MA.ALLOWANCE_ID
                     , MA.ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_ALLOWANCE  MA
                    , HRM_ALLOWANCE_V HA
                WHERE MA.ALLOWANCE_ID           = HA.ALLOWANCE_ID
                  AND MA.MONTH_PAYMENT_ID       = P_MONTH_PAYMENT_ID
                  AND MA.PERSON_ID              = P_PERSON_ID
                  AND MA.CORP_ID                = P_CORP_ID
                  AND MA.SOB_ID                 = P_SOB_ID
                  AND MA.ORG_ID                 = P_ORG_ID
               )
    LOOP 
      BEGIN
        IF P_JOIN_3RD_DATE BETWEEN P_START_DATE AND P_END_DATE THEN
        -- 입사 3개월 일자까지 90% 지급, 나머지 100% 지급.
          IF P_RETIRE_DATE IS NOT NULL AND P_RETIRE_DATE < P_JOIN_3RD_DATE THEN
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) * (V_PAYMENT_RATE / 100);
          ELSE
            V_ROOKIE_DAY := P_JOIN_3RD_DATE - P_START_DATE;
            V_ROOKIE_AMOUNT := (NVL(R1.ALLOWANCE_AMOUNT, 0) / P_TOTAL_DAY) * V_ROOKIE_DAY;  
            V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) - NVL(V_ROOKIE_AMOUNT, 0);
            V_ROOKIE_AMOUNT := NVL(V_ROOKIE_AMOUNT, 0) * (V_PAYMENT_RATE / 100);
            V_ALLOWANCE_AMOUNT := NVL(V_ALLOWANCE_AMOUNT, 0) + NVL(V_ROOKIE_AMOUNT, 0);
          END IF;
        ELSE
        -- 90% 지급.
          V_ALLOWANCE_AMOUNT := NVL(R1.ALLOWANCE_AMOUNT, 0) * (V_PAYMENT_RATE / 100);
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '101. Daily pay error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP R1;
    O_STATUS := 'S';
  END DAILY_PAY_CALCULATE_101;
            
-- 41.2 지급항목 일할계산
  PROCEDURE DAILY_PAY_CALCULATE_102
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_TOTAL_DAY         IN NUMBER
            , P_PAY_DAY           IN HRP_MONTH_PAYMENT.PAY_DAY%TYPE
            , P_HOLY_0_COUNT      IN NUMBER
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
    O_STATUS := 'F';
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
      BEGIN
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '102. Daily pay error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP R1;
    O_STATUS := 'S';
  END DAILY_PAY_CALCULATE_102;
  
-- 47. 신입사원 일할 계산.
--  PROCEDURE ROOKIE

-- 51. 건강보험/국민연금 생성(보험료 기준)
  PROCEDURE PENSION_HEALTH_INSURANCE_1
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
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , IC.INSUR_TYPE
                     , CASE
                         WHEN IC.INSUR_TYPE = 'M' THEN HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D05''', IC.SOB_ID, IC.ORG_ID)
                         WHEN IC.INSUR_TYPE = 'P' THEN HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D03''', IC.SOB_ID, IC.ORG_ID)
                       END AS DEDUCTION_ID
                     , NVL(IC.PERSON_INSUR_AMOUNT, 0) + NVL(IC.PERSON_INSUR_ADD_AMOUNT, 0) AS INSUR_AMOUNT
                     , CASE
                         WHEN IC.INSUR_TYPE = 'M' THEN HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D06''', IC.SOB_ID, IC.ORG_ID)
                       END AS LONGTERMCARE_ID
                     , CASE
                         WHEN IC.INSUR_TYPE = 'M' THEN NVL(IC.PERSON_LONGTERMCARE_AMOUNT, 0)
                       END AS LONGTERMCARE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_INSURANCE_CHARGE IC
                WHERE MP.PERSON_ID             = IC.PERSON_ID
                  AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                  AND MP.WAGE_TYPE             = P_WAGE_TYPE
                  AND MP.CORP_ID               = P_CORP_ID
                  AND MP.SOB_ID                = P_SOB_ID
                  AND MP.ORG_ID                = P_ORG_ID
                  AND IC.INSUR_TYPE            IN ('M', 'P')
                  AND IC.INSUR_YN              = 'Y'
                  AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                    OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                  AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                    OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                  AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                    OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                  AND MP.PAY_PROVIDE_YN        = 'Y'
                  AND MP.CLOSED_YN             = 'N'
                  AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                    OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP    
      BEGIN    
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Medic Insur error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      
      BEGIN  
        IF NVL(C1.LONGTERMCARE_AMOUNT, 0) <> 0 THEN
          DEDUCTION_INSERT( P_PERSON_ID => C1.PERSON_ID
                          , P_PAY_YYYYMM => C1.PAY_YYYYMM
                          , P_WAGE_TYPE => C1.WAGE_TYPE
                          , P_CORP_ID => C1.CORP_ID
                          , P_DEDUCTION_ID => C1.LONGTERMCARE_ID
                          , P_DEDUCTION_AMOUNT => NVL(C1.LONGTERMCARE_AMOUNT, 0)
                          , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                          , P_SOB_ID => P_SOB_ID
                          , P_ORG_ID => P_ORG_ID
                          , P_USER_ID => P_USER_ID
                          );        
        END IF;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Medic-Longtermcare Insur error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
  END PENSION_HEALTH_INSURANCE_1;

-- 52. 건강보험/국민연금 생성(보수/소득월금액 기준).
  PROCEDURE PENSION_HEALTH_INSURANCE_2
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
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.JOB_CATEGORY_ID
                     , MP.PAY_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , IM.INSUR_TYPE
                     , HD.DEDUCTION_ID
                     , HD.DEDUCTION_CODE
                     , HRP_INSURANCE_MASTER_G.INSUR_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, IM.INSUR_TYPE, MP.SOB_ID, MP.ORG_ID) AS INSUR_AMOUNT
                     , HRM_COMMON_G.GET_ID_F('DEDUCTION', 'CODE = ''D06''', IM.SOB_ID, IM.ORG_ID) AS CARE_DEDUCTION_ID
                     , HRP_INSURANCE_MASTER_G.CARE_INSUR_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID) AS CARE_INSUR_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                    , HRP_INSURANCE_MASTER IM
                    , HRM_INSUR_TYPE_V IT
                    , HRM_DEDUCTION_V HD
                WHERE MP.PERSON_ID             = IM.PERSON_ID
                  AND IM.INSUR_TYPE            = IT.INSUR_TYPE
                  AND IM.SOB_ID                = IT.SOB_ID
                  AND IM.ORG_ID                = IT.ORG_ID
                  AND IT.DEDUCTION_CODE        = HD.DEDUCTION_CODE
                  AND IT.SOB_ID                = HD.SOB_ID
                  AND IT.ORG_ID                = HD.ORG_ID
                  AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                  AND MP.WAGE_TYPE             = P_WAGE_TYPE
                  AND MP.CORP_ID               = P_CORP_ID
                  AND MP.SOB_ID                = P_SOB_ID
                  AND MP.ORG_ID                = P_ORG_ID
                  AND IM.INSUR_TYPE            IN ('M', 'P')
                  AND IM.INSUR_YN              = 'Y'
                  AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                    OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                  AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                    OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                  AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                    OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                  AND MP.PAY_PROVIDE_YN        = 'Y'
                  AND MP.CLOSED_YN             = 'N'
                  AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                    OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP    
      BEGIN  
        IF NVL(C1.INSUR_AMOUNT, 0) <> 0 THEN
          DEDUCTION_INSERT
            ( P_PERSON_ID => C1.PERSON_ID
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Medic Insur error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      BEGIN
        IF NVL(C1.CARE_INSUR_AMOUNT, 0) <> 0 THEN
          DEDUCTION_INSERT
            ( P_PERSON_ID => C1.PERSON_ID
            , P_PAY_YYYYMM => C1.PAY_YYYYMM
            , P_WAGE_TYPE => C1.WAGE_TYPE
            , P_CORP_ID => C1.CORP_ID
            , P_DEDUCTION_ID => C1.CARE_DEDUCTION_ID
            , P_DEDUCTION_AMOUNT => NVL(C1.CARE_INSUR_AMOUNT, 0)
            , P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
            , P_SOB_ID => P_SOB_ID
            , P_ORG_ID => P_ORG_ID
            , P_USER_ID => P_USER_ID
            );        
        END IF;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Medic-Longtermcare Insur error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
  END PENSION_HEALTH_INSURANCE_2;
  
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
      O_STATUS := 'F';
      O_MESSAGE := 'Unemployement Insur ID Error : '  || SUBSTR(SQLERRM, 1, 150);
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
      O_STATUS := 'F';
      O_MESSAGE := 'Insurace Rate(Unemployement Insurance Rate) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10137', NULL);
      RETURN;
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
                 WHERE MP.MONTH_PAYMENT_ID      = MA.MONTH_PAYMENT_ID(+)
                   AND MA.ALLOWANCE_ID          = HA.ALLOWANCE_ID(+)                   
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND MP.HIRE_INSUR_YN         = 'Y'
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
                GROUP BY MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
               )
    LOOP
      BEGIN
        V_INSUR_AMOUNT := 0;
        V_INSUR_AMOUNT := DECIMAL_F(P_SOB_ID, P_ORG_ID, NVL(C1.TOTAL_AMOUNT, 0) * ( V_INSUR_RATE / 100 ), 'UNEMPLOY_INSUR');
        V_INSUR_AMOUNT := TRUNC(V_INSUR_AMOUNT, -1);
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
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Unemployee insur error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
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
    V_TAX_AMOUNT                  NUMBER;
    V_RESIDENT_TAX_RATE           NUMBER;    
    
    V_TAX_DEDUCTION_ID            NUMBER;
    V_RESIDENT_DEDUCTION_ID       NUMBER;
    
    V_MONTH_PAY_STD               NUMBER;
    V_OT_DED_LMT                  NUMBER;
    V_DRIVE_DED_LMT               NUMBER;
    V_OUTSIDE_LMT                 NUMBER;
    V_BABY_LMT                    NUMBER;
    
    -- 급여처리시 기존에 지급(상여금)된 총금액을 포함하여 소득세 계산하여 
    -- 기처리된 소득세를 제외한 금액을 급여에서 소득세로 반영함 --
    V_ETC_PAY_AMOUNT              NUMBER;  -- 급여외 총 소득금액 --
    V_ETC_TAX_AMOUNT              NUMBER;  -- 급여외 총 소득세 --
  BEGIN
    O_STATUS := 'F';
    -- 소득세/주민세 공제ID 조회--
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
      O_STATUS := 'F';
      O_MESSAGE := 'Tax ID Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    -- 주민세율 --
    V_RESIDENT_TAX_RATE := HRM_COMMON_G.TAX_RATE_F
                             ( W_TAX_CODE => 'RESIDENT'
                              , W_SOB_ID => P_SOB_ID
                              , W_ORG_ID => P_ORG_ID
                              );
    -- 비과세 한도 설정 --
    V_ETC_PAY_AMOUNT              := 0;  -- 급여외 총 소득금액 --
    V_ETC_TAX_AMOUNT              := 0;  -- 급여외 총 소득세 --
    V_MONTH_PAY_STD               := 0;
    V_OT_DED_LMT                  := 0;
    V_DRIVE_DED_LMT               := 0;
    V_OUTSIDE_LMT                 := 0;
    V_BABY_LMT                    := 0;
    BEGIN
      SELECT ITS.MONTH_PAY_STD
           , TRUNC(ITS.OT_DED_LMT / 12) AS OT_DED_LMT
           , ITS.DRIVE_DED_LMT
           , ITS.FOREIGN_INCOME_DED_AMT
           , ITS.BABY_DED_LMT
        INTO V_MONTH_PAY_STD
           , V_OT_DED_LMT
           , V_DRIVE_DED_LMT
           , V_OUTSIDE_LMT
           , V_BABY_LMT
        FROM HRA_INCOME_TAX_STANDARD ITS
      WHERE ITS.YEAR_YYYY         = TO_CHAR(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'YYYY')
        AND ITS.SOB_ID            = P_SOB_ID
        AND ITS.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MONTH_PAY_STD := 1000000;
      V_OT_DED_LMT := 200000;
      V_DRIVE_DED_LMT := 200000;
      V_OUTSIDE_LMT := 1000000;
      V_BABY_LMT := 100000;
    END;
    
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.STANDARD_DATE
                     , MP.DED_PERSON_COUNT
                     , NVL(MA1.TOTAL_PAY_AMOUNT, 0) -
                       CASE  -- OT 비과세 적용.
                         WHEN MP.PAY_TYPE IN('1', '3') THEN 0
                         WHEN NVL(MA1.TOTAL_PAY_AMOUNT, 0) < NVL(V_MONTH_PAY_STD, 0) THEN 
                           CASE
                             WHEN NVL(V_OT_DED_LMT, 0) < NVL(MA1.TAX_FREE_OT, 0) THEN NVL(V_OT_DED_LMT, 0)
                             ELSE NVL(MA1.TAX_FREE_OT, 0)
                           END
                         ELSE 0
                       END -
                       CASE  -- 차량유지비 비과세 적용.
                         WHEN NVL(V_DRIVE_DED_LMT, 0) < NVL(MA1.TAX_FREE_CAR, 0) THEN NVL(V_DRIVE_DED_LMT, 0)
                         ELSE NVL(MA1.TAX_FREE_CAR, 0)
                       END - 
                       CASE  -- 국외비과세.
                         WHEN NVL(V_OUTSIDE_LMT, 0) < NVL(MA1.TAX_FREE_OUTSIDE, 0) THEN NVL(V_OUTSIDE_LMT, 0)
                         ELSE NVL(MA1.TAX_FREE_OUTSIDE, 0)
                       END - 
                       CASE  -- 보육수당.
                         WHEN NVL(V_BABY_LMT, 0) < NVL(MA1.TAX_FREE_BABY, 0) THEN NVL(V_BABY_LMT, 0)
                         ELSE NVL(MA1.TAX_FREE_BABY, 0)
                       END AS TAX_PAY_AMOUNT
                     /*, (NVL(MA1.TOTAL_PAY_AMOUNT, 0)
                       - NVL(MD1.DEDUCTION_AMOUNT, 0)
                       - CASE 
                           WHEN MP.PAY_TYPE IN ('2', '4') AND NVL(MA1.GENERAL_PAY_AMOUNT, 0) < V_MONTH_PAY_STD THEN
                             CASE
                               WHEN V_OT_DED_LMT < NVL(MA1.OT_AMOUNT, 0) THEN V_OT_DED_LMT
                               ELSE NVL(MA1.OT_AMOUNT, 0)
                             END
                           ELSE 0                           
                         END) AS TAX_PAY_AMOUNT*/
                  FROM HRP_MONTH_PAYMENT MP
                    , (SELECT MA.MONTH_PAYMENT_ID
                            , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_PAY_AMOUNT
                            , NVL(SUM(DECODE(HA.GENERAL_PAY_YN, 'Y', MA.ALLOWANCE_AMOUNT, 0)), 0) AS GENERAL_PAY_AMOUNT
                            , NVL(SUM(CASE WHEN HA.TAX_FREE IN('OT') THEN MA.ALLOWANCE_AMOUNT ELSE 0 END), 0) AS TAX_FREE_OT
                            , NVL(SUM(CASE WHEN HA.TAX_FREE IN('CAR') THEN MA.ALLOWANCE_AMOUNT ELSE 0 END), 0) AS TAX_FREE_CAR
                            , NVL(SUM(CASE WHEN HA.TAX_FREE IN ('OUTSIDE') THEN MA.ALLOWANCE_AMOUNT ELSE 0 END), 0) AS TAX_FREE_OUTSIDE
                            , NVL(SUM(CASE WHEN HA.TAX_FREE IN ('BABY') THEN MA.ALLOWANCE_AMOUNT ELSE 0 END), 0) AS TAX_FREE_BABY
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
                            , 0 AS DEDUCTION_AMOUNT                            
                            /* -- 전호수 주석 처리 : 공제 안함.
                            , NVL(SUM(CASE WHEN HD.TAX_FREE IN ('ANNU', 'MEDIC') THEN MD.DEDUCTION_AMOUNT ELSE 0 END), 0) AS DEDUCTION_AMOUNT*/
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
                 WHERE MP.MONTH_PAYMENT_ID      = MA1.MONTH_PAYMENT_ID(+)
                   AND MP.MONTH_PAYMENT_ID      = MD1.MONTH_PAYMENT_ID(+)
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      /*-- 급여외 소득 및 소득세 조회 --
      -- 급여계산시 상여등 기타지급된 금액을 포함하여 세금계산하고 이미 계산된 금액을 제외한 금액을 소득세 처리 함 --
      BEGIN
        SELECT NVL(( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_PAY_AMOUNT
                      FROM HRP_MONTH_ALLOWANCE MA
                     WHERE MA.MONTH_PAYMENT_ID  = MP.MONTH_PAYMENT_ID
                     GROUP BY MA.MONTH_PAYMENT_ID
                    ), 0) AS TOTAL_PAY_AMOUNT
             , NVL(( SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DEDUCTION_AMOUNT                            
                       FROM HRP_MONTH_DEDUCTION MD
                     WHERE MD.MONTH_PAYMENT_ID  = MP.MONTH_PAYMENT_ID
                       AND MD.DEDUCTION_ID      = V_TAX_DEDUCTION_ID  -- 소득세 --
                     GROUP BY MD.MONTH_PAYMENT_ID
                     ), 0) AS LOCAL_TAX_AMOUNT
          INTO V_ETC_PAY_AMOUNT, V_ETC_TAX_AMOUNT
          FROM HRP_MONTH_PAYMENT MP
         WHERE MP.PAY_YYYYMM              = C1.PAY_YYYYMM
           AND MP.WAGE_TYPE               != C1.WAGE_TYPE
           AND MP.SOB_ID                  = P_SOB_ID
           AND MP.ORG_ID                  = P_ORG_ID
           AND MP.PERSON_ID               = C1.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ETC_PAY_AMOUNT              := 0;  -- 급여외 총 소득금액 --
        V_ETC_TAX_AMOUNT              := 0;  -- 급여외 총 소득세 --
      END;*/
      
      V_TAX_AMOUNT := 0;
      BEGIN
        V_TAX_AMOUNT := HRP_PAYMENT_G_SET.TAX_AMOUNT_F
                          ( W_STD_DATE => C1.STANDARD_DATE
                          , W_TOTAL_AMOUNT => (NVL(C1.TAX_PAY_AMOUNT, 0) + NVL(V_ETC_PAY_AMOUNT, 0))
                          , W_SUPPORT_FAMILY => NVL(C1.DED_PERSON_COUNT, 1)
                          , W_SOB_ID => P_SOB_ID
                          , W_ORG_ID => P_ORG_ID
                          );
        V_TAX_AMOUNT := NVL(V_TAX_AMOUNT, 0) - NVL(V_ETC_TAX_AMOUNT, 0);  -- 기납부된 소득세 제외 --
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '1.Tax Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      IF V_TAX_AMOUNT < 0 THEN
        V_TAX_AMOUNT := 0;
      END IF;
      
      IF NVL(V_TAX_AMOUNT,0) <> 0 THEN
        -- INSERT TAX.
        V_TAX_AMOUNT := TRUNC(V_TAX_AMOUNT, -1);
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
          BEGIN
            V_TAX_AMOUNT := TRUNC(NVL(V_TAX_AMOUNT, 0) * (V_RESIDENT_TAX_RATE / 100), -1);
          EXCEPTION WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := '2.Resident Tax Error : ' || SUBSTR(SQLERRM, 1, 150);
            RETURN;
          END;
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
-- 70 관리직 특근수당 생성
  PROCEDURE MANAGEMENT_HOLIDAY_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WORK_DATE_FR      IN DATE
            , P_WORK_DATE_TO      IN DATE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN 
    O_STATUS := 'F';   
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
                 WHERE MP.POST_ID               = HC.COMMON_ID
                   AND MP.PAY_TYPE              = PT.PAY_TYPE
                   AND MP.SOB_ID                = PT.SOB_ID
                   AND MP.ORG_ID                = PT.ORG_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND PT.PAY_LEVEL             IN('MONTH', 'YEAR')
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
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
            AND ROWNUM            <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          V_ALLOWANCE_AMOUNT := 0;   
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
    END LOOP C1;
    O_STATUS := 'S';
  END MANAGEMENT_HOLIDAY_ALLOWANCE;

-- 71 직책수당
  PROCEDURE JOB_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_ALLOWANCE_AMOUNT  NUMBER := 0;
    V_PAY_HEADER_ID     NUMBER := 0;  -- HEADER ID.
    V_PAY_LINE_ID       NUMBER := 0;  -- LINE ID.
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.PAY_TYPE
                     , PC.POST_CODE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.EXCEPT_TYPE
                     , PM.ORI_JOIN_DATE
                     , PM.RETIRE_DATE
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                    , HRM_POST_CODE_V PC
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.POST_ID               = PC.POST_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_ALLOWANCE_AMOUNT            := 0;
      BEGIN
        SELECT TO_NUMBER(NVL(HC.VALUE3, 0)) AS JOB_AMOUNT
          INTO V_ALLOWANCE_AMOUNT
          FROM HRM_COMMON HC
        WHERE HC.GROUP_CODE       = 'ALLOWANCE_JOB'
          AND HC.SOB_ID           = C1.SOB_ID
          AND HC.ORG_ID           = C1.ORG_ID
          AND HC.VALUE1           = C1.PAY_TYPE
          AND HC.VALUE2           = C1.POST_CODE
          AND HC.ENABLED_FLAG     = 'Y'
          AND HC.EFFECTIVE_DATE_FR  <= P_STD_DATE
          AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= P_STD_DATE)
          AND ROWNUM              <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ALLOWANCE_AMOUNT := 0;
      END;
      
      IF NVL(P_GENERAL_TIME_YN, 'N') = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => C1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => P_ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT 
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
        
      IF C1.EXCEPT_TYPE = 'I' AND '15' < TO_CHAR(C1.ORI_JOIN_DATE, 'DD') THEN
        V_ALLOWANCE_AMOUNT := 0;
        
        -- 기존자료 삭제.
        ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                        , P_ALLOWANCE_ID
                        , P_SOB_ID
                        , P_ORG_ID
                        );
      ELSIF C1.RETIRE_DATE IS NOT NULL AND C1.EXCEPT_TYPE = 'R' AND '15' > TO_CHAR(C1.RETIRE_DATE, 'DD') THEN
        -- 15일 이전 퇴사자만 제외.
        V_ALLOWANCE_AMOUNT := 0;
        
        -- 기존자료 삭제.
        ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                        , P_ALLOWANCE_ID
                        , P_SOB_ID
                        , P_ORG_ID
                        );        
      END IF;
      
      IF NVL(V_ALLOWANCE_AMOUNT, 0) > 0 THEN
        -- 기존자료 삭제.
        ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                        , P_ALLOWANCE_ID
                        , P_SOB_ID
                        , P_ORG_ID
                        );
        
        -- 급여마스터 라인ID.
        BEGIN
          SELECT PMH.PAY_HEADER_ID
            INTO V_PAY_HEADER_ID
            FROM HRP_PAY_MASTER_HEADER PMH
          WHERE PMH.PERSON_ID         = C1.PERSON_ID
            AND PMH.START_YYYYMM      <= C1.PAY_YYYYMM
            AND PMH.END_YYYYMM        >= C1.PAY_YYYYMM
            AND PMH.SOB_ID            = C1.SOB_ID
            AND PMH.ORG_ID            = C1.ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          O_STATUS := 'F';
          O_MESSAGE := 'Job Allowance Error : ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL);
          RETURN;          
        END;
        
        -- 급여마스터 적용.
        HRP_PAY_MASTER_G.SAVE_PAY_LINE
          ( P_PAY_LINE_ID      => V_PAY_LINE_ID
          , P_PAY_HEADER_ID    => V_PAY_HEADER_ID
          , P_ALLOWANCE_TYPE   => 'A'
          , P_ALLOWANCE_ID     => P_ALLOWANCE_ID
          , P_ALLOWANCE_AMOUNT => NVL(V_ALLOWANCE_AMOUNT, 0)
          , P_ENABLED_FLAG     => 'Y'
          , P_SOB_ID           => C1.SOB_ID
          , P_ORG_ID           => C1.ORG_ID
          , P_USER_ID          => P_USER_ID
          );
                              
        -- 지급공제 적용.
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
    END LOOP C1;
    O_STATUS := 'S';
  END JOB_ALLOWANCE;
  
-- 72 생산장려수당 : 기준시간 이하 연장근무, 공제일수 있을 경우, 당월 입사..
  PROCEDURE PROMOTE_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_STD_TIME          IN NUMBER
            , P_STD_LATE_TIME     IN NUMBER
            , P_STD_LEAVE_TIME    IN NUMBER
            , P_STD_DED_11_COUNT  IN NUMBER
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_DED_11_COUNT                NUMBER := 0;
    V_LATE_TIME                   NUMBER := 0;
    V_LEAVE_TIME                  NUMBER := 0;
    V_OT_TIME                     NUMBER := 0;
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.PAY_TYPE
                     , MP.LONG_MONTH
                     , MP.EXCEPT_TYPE
                     , PC.POST_CODE
                     , MP.SOB_ID
                     , MP.ORG_ID
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                    , HRM_POST_CODE_V PC
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.POST_ID               = PC.POST_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_DED_11_COUNT                := 0;
      V_LATE_TIME                   := 0;
      V_LEAVE_TIME                  := 0;
      V_OT_TIME                     := 0;
      V_ALLOWANCE_AMOUNT            := 0;
      BEGIN
        SELECT NVL(SX1.DUTY_11, 0) AS DED_11_COUNT
            , NVL(SX2.LEAVE_TIME, 0) AS LEAVE_TIME
            , NVL(SX2.LATE_TIME, 0) AS LATE_TIME
            , (NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.HOLIDAY_TIME, 0) + NVL(MTO.HOLYDAY_OT_TIME, 0)) AS OVER_TIME
          INTO V_DED_11_COUNT
            , V_LEAVE_TIME
            , V_LATE_TIME
            , V_OT_TIME
          FROM HRD_MONTH_TOTAL MT
            , HRD_MONTH_TOTAL_OT_V MTO
            , ( SELECT MTD.MONTH_TOTAL_ID
                    , NVL(MTD.DUTY_31, 0) + NVL(MTD.DUTY_11, 0) AS DUTY_11
                  FROM HRD_MONTH_TOTAL_DUTY_V MTD
                WHERE MTD.DUTY_TYPE   = C_DUTY_MONTH
                  AND MTD.DUTY_YYYYMM = C1.PAY_YYYYMM
                  AND MTD.PERSON_ID   = C1.PERSON_ID
                  AND MTD.SOB_ID      = C1.SOB_ID
                  AND MTD.ORG_ID      = C1.ORG_ID
               ) SX1
             , ( SELECT DL.PERSON_ID 
                     , SUM(DL.LEAVE_TIME) AS LEAVE_TIME  -- 외출.
                     , SUM(DL.LATE_TIME) AS LATE_TIME  -- 지각.
                   FROM HRD_DAY_LEAVE_V1 DL
                 WHERE DL.WORK_DATE     BETWEEN TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM')) 
                   AND DL.PERSON_ID     = C1.PERSON_ID
                   AND DL.SOB_ID        = C1.SOB_ID
                   AND DL.ORG_ID        = C1.ORG_ID
                   AND DL.CLOSED_YN     = 'Y'
                   AND NOT EXISTS  -- 결근, 휴일관련 제외.
                         ( SELECT 'X'
                             FROM HRM_DUTY_CODE_V DC
                           WHERE DC.DUTY_ID     = DL.DUTY_ID
                             AND DC.DUTY_CODE   IN ('11', '51', '52', '53')
                          )
                 GROUP BY DL.PERSON_ID
               ) SX2
        WHERE MT.MONTH_TOTAL_ID      = MTO.MONTH_TOTAL_ID(+)
          AND MT.MONTH_TOTAL_ID      = SX1.MONTH_TOTAL_ID(+)
          AND MT.PERSON_ID           = SX2.PERSON_ID(+)
          AND MT.DUTY_TYPE           = C_DUTY_MONTH
          AND MT.DUTY_YYYYMM         = C1.PAY_YYYYMM
          AND MT.PERSON_ID           = C1.PERSON_ID
          AND MT.SOB_ID              = C1.SOB_ID
          AND MT.ORG_ID              = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        NULL;
      END;
      
      -- 기존 자료 삭제.
      ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                      , P_ALLOWANCE_ID
                      , P_SOB_ID
                      , P_ORG_ID
                      );
      IF NVL(P_STD_TIME, 0) > NVL(V_OT_TIME, 0) THEN 
      -- 기준시간 이하 연장근무
        NULL;
      ELSIF NVL(P_STD_DED_11_COUNT, 0) < NVL(V_DED_11_COUNT, 0) THEN
        -- 결근(공제일수) 있을 경우
        NULL;
      ELSIF NVL(P_STD_LATE_TIME, 0) < NVL(V_LATE_TIME, 0) THEN
        -- 지각/조퇴.
        NULL;
      ELSIF NVL(P_STD_LEAVE_TIME, 0) < NVL(V_LEAVE_TIME, 0) THEN
        -- 외출.
        NULL;
      ELSIF C1.EXCEPT_TYPE <> 'N' THEN
      -- 중되 입사.
        NULL;
      ELSE
        BEGIN
          SELECT TO_NUMBER(NVL(HC.VALUE3, 0)) AS JOB_AMOUNT
            INTO V_ALLOWANCE_AMOUNT
            FROM HRM_COMMON HC
          WHERE HC.GROUP_CODE       = 'ALLOWANCE_PROMOTE'
            AND HC.VALUE1           = C1.PAY_TYPE
            AND HC.VALUE2           = C1.POST_CODE
            AND HC.ENABLED_FLAG     = 'Y'
            AND HC.EFFECTIVE_DATE_FR  <= P_STD_DATE
            AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= P_STD_DATE)
            AND ROWNUM              <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          V_ALLOWANCE_AMOUNT := 0;
        END;
        IF NVL(V_ALLOWANCE_AMOUNT, 0) > 0 THEN
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
      END IF;
    END LOOP C1;
    O_STATUS := 'S';
  END PROMOTE_ALLOWANCE;

-- 73 자기개발수당 : 45세 이상 여자 제외.
  PROCEDURE SELF_DEV_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_AGE               IN NUMBER
            , P_SEX_TYPE          IN VARCHAR2
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , PM.SEX_TYPE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.PAY_TYPE
                     , MP.LONG_MONTH
                     , MP.LONG_YEAR
                     , MP.EXCEPT_TYPE
                     , PM.ORI_JOIN_DATE
                     , PM.RETIRE_DATE
                     , MP.STANDARD_DATE
                     , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, MP.STANDARD_DATE, 0) AS AGE
                     , HRM_COMMON_G.GET_CODE_F(NVL(MP.POST_ID, PM.POST_ID), MP.SOB_ID, MP.ORG_ID) AS POST_CODE
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_ALLOWANCE_AMOUNT            := 0;
      BEGIN
        SELECT ASD.ALLOWANCE_AMOUNT
          INTO V_ALLOWANCE_AMOUNT
          FROM HRM_ALLOWANCE_SELF_DEV_V ASD
        WHERE ASD.PAY_TYPE              = C1.PAY_TYPE
          AND ASD.LONG_YEAR_FR          <= C1.LONG_YEAR
          AND ASD.LONG_YEAR_TO          >= C1.LONG_YEAR
          AND ASD.SOB_ID                = C1.SOB_ID
          AND ASD.ORG_ID                = C1.ORG_ID
          AND ASD.ENABLED_FLAG          = 'Y'
          AND ASD.EFFECTIVE_DATE_FR     <= P_STD_DATE
          AND (ASD.EFFECTIVE_DATE_TO IS NULL OR ASD.EFFECTIVE_DATE_TO >= P_STD_DATE)
          AND ROWNUM                    <= 1
        ;
        EXCEPTION WHEN OTHERS THEN
          V_ALLOWANCE_AMOUNT := 0;
      END;
      IF P_AGE <= C1.AGE AND P_SEX_TYPE = C1.SEX_TYPE THEN
      -- 45세 이상 여자 제외.
        IF C1.POST_CODE IN('530', '540', '430', '420') THEN
          -- 조/반장/계장/주임은 지급.
          NULL;
        ELSE 
          V_ALLOWANCE_AMOUNT := 0;
        END IF;   
      END IF;
          
      IF NVL(P_GENERAL_TIME_YN, 'N') = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => C1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => P_ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
       
      IF C1.EXCEPT_TYPE = 'I' AND '15' < TO_CHAR(C1.ORI_JOIN_DATE, 'DD') THEN
        -- 15일 이후 입사자만 제외.
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF C1.RETIRE_DATE IS NOT NULL AND C1.EXCEPT_TYPE = 'R' AND '15' > TO_CHAR(C1.RETIRE_DATE, 'DD') THEN
        -- 15일 이전 퇴사자만 제외.
        V_ALLOWANCE_AMOUNT := 0;
      END IF;
      
      IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
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
    END LOOP C1;
    O_STATUS := 'S';
  END SELF_DEV_ALLOWANCE;          

-- 74 복지수당 적용 여부 : 근무율 70%이상, 수습3개월 이상.
  PROCEDURE WELFARE_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_START_DATE        IN DATE
            , P_END_DATE          IN DATE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_WORKING_RATE      IN NUMBER
            , P_LONG_MONTH        IN NUMBER
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
    V_STD_WORK_DAY                NUMBER := 0;
    V_WORKING_RATE                NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    V_STD_WORK_DAY := HRP_PAYMENT_G_SET.WORK_DAY_COUNT_F
                        ( P_PAY_YYYYMM        => P_PAY_YYYYMM
                        , P_START_DATE        => P_START_DATE
                        , P_END_DATE          => P_END_DATE
                        , P_SOB_ID            => P_SOB_ID
                        , P_ORG_ID            => P_ORG_ID
                        );
                        
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.PAY_TYPE
                     , MP.LONG_MONTH
                     , MP.EXCEPT_TYPE
                     , PM.ORI_JOIN_DATE
                     , PM.JOIN_DATE
                     , PM.RETIRE_DATE
                     , NVL(S_HA.ARMY_END_TYPE, '0') AS ARMY_END_TYPE
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER PM
                    , ( SELECT HA.PERSON_ID
                             , S_HC.ARMY_END_TYPE                    
                          FROM HRM_ARMY HA
                            , ( SELECT HC.COMMON_ID AS ARMY_END_TYPE_ID
                                     , HC.CODE AS ARMY_END_TYPE
                                     , HC.SOB_ID
                                     , HC.ORG_ID
                                  FROM HRM_COMMON HC
                                WHERE HC.GROUP_CODE       = 'ARMY_END_TYPE'  -- 전역구분.
                                  AND HC.SOB_ID           = P_SOB_ID
                                  AND HC.ORG_ID           = P_ORG_ID
                               ) S_HC
                        WHERE HA.ARMY_END_TYPE_ID     = S_HC.ARMY_END_TYPE_ID
                      ) S_HA
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND PM.PERSON_ID             = S_HA.PERSON_ID(+)
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_WORKING_RATE := 0;
      V_ALLOWANCE_AMOUNT := 0;
      
      -- 근무율 계산.
      BEGIN
        SELECT CEIL(MT.TOTAL_ATT_DAY / V_STD_WORK_DAY * 100) AS OVER_RATE
          INTO V_WORKING_RATE
          FROM HRD_MONTH_TOTAL MT
        WHERE MT.PERSON_ID                = C1.PERSON_ID
          AND MT.DUTY_TYPE                = C_DUTY_MONTH
          AND MT.DUTY_YYYYMM              = C1.PAY_YYYYMM
          AND MT.CORP_ID                  = C1.CORP_ID
          AND MT.SOB_ID                   = C1.SOB_ID
          AND MT.ORG_ID                   = C1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_WORKING_RATE := 0;
      END;
      
      -- 복지수당 삭제.
      ALLOWANCE_DELETE( P_MONTH_PAYMENT_ID => C1.MONTH_PAYMENT_ID
                      , P_ALLOWANCE_ID => P_ALLOWANCE_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      );
      IF P_WORKING_RATE > V_WORKING_RATE THEN
      -- 근무율 70% 미만, 3개월 미만.
        NULL;
      ELSIF P_LONG_MONTH > C1.LONG_MONTH THEN
        -- 3개월 미만자 지급 안함.
        NULL;
      ELSIF P_LONG_MONTH = C1.LONG_MONTH AND '15' < TO_CHAR(C1.JOIN_DATE, 'DD') THEN
        -- 3개월 및 15일 이전 입사자만 지급.
        NULL;
      ELSIF C1.RETIRE_DATE IS NOT NULL AND C1.EXCEPT_TYPE = 'R' AND '15' > TO_CHAR(C1.RETIRE_DATE, 'DD') THEN
        -- 15일 이전 퇴사자만 제외.
        V_ALLOWANCE_AMOUNT := 0;
      ELSE
        BEGIN
          SELECT CASE
                   WHEN C1.ARMY_END_TYPE IN('1', '3') THEN TO_NUMBER(NVL(HC.VALUE3, 0))
                   ELSE TO_NUMBER(NVL(HC.VALUE2, 0))
                 END AS WELFARE_AMOUNT
            INTO V_ALLOWANCE_AMOUNT
            FROM HRM_COMMON HC
          WHERE HC.GROUP_CODE         = 'ALLOWANCE_WELFARE'
            AND HC.SOB_ID             = C1.SOB_ID
            AND HC.ORG_ID             = C1.ORG_ID
            AND HC.VALUE1             = C1.PAY_TYPE
            AND HC.ENABLED_FLAG       = 'Y'
            AND HC.EFFECTIVE_DATE_FR  <= P_STD_DATE
            AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= P_STD_DATE)
            AND ROWNUM                <= 1
          ;
        EXCEPTION WHEN OTHERS THEN
          V_ALLOWANCE_AMOUNT := 0;
        END;
        
        IF NVL(V_ALLOWANCE_AMOUNT, 0) <> 0 THEN
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
      END IF;
      
      IF NVL(P_GENERAL_TIME_YN, 'N') = 'Y' THEN
      -- 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => C1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => P_ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
    END LOOP C1;
    O_STATUS := 'S';
  END WELFARE_ALLOWANCE;

-- 75 검사수당 적용 여부
  PROCEDURE INSPECTION_ALLOWANCE
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
    V_LONG_MONTH                  NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.PAY_TYPE
                     , MP.LONG_MONTH
                     , ( SELECT DM.DEPT_CODE 
                           FROM HRM_DEPT_MASTER DM
                          WHERE DM.DEPT_ID      = NVL(T2.DEPT_ID, MP.DEPT_ID)
                            AND ROWNUM          <= 1
                       ) AS DEPT_CODE
                     , HRM_COMMON_G.GET_CODE_F(NVL(T2.FLOOR_ID, PM.FLOOR_ID), MP.SOB_ID, MP.ORG_ID) AS FLOOR_CODE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.EXCEPT_TYPE
                     , PM.ORI_JOIN_DATE
                     , PM.RETIRE_DATE
                     , NVL(T1.CHARGE_DATE, PM.JOIN_DATE) AS CHARGE_DATE  -- 발령일자.
                     -- 검사 수당 추가 지급자 -- 
                     , NVL(( SELECT IA.ALLOWANCE_AMOUNT 
                               FROM HRM_INSPECTION_ADDITION_V IA
                              WHERE IA.PERSON_NUM         = PM.PERSON_NUM
                                AND IA.SOB_ID             = PM.SOB_ID
                                AND IA.ORG_ID             = PM.ORG_ID
                                AND IA.ENABLED_FLAG       = 'Y'
                                AND IA.EFFECTIVE_DATE_FR  <= P_STD_DATE
                                AND (IA.EFFECTIVE_DATE_TO >= P_STD_DATE OR IA.EFFECTIVE_DATE_TO IS NULL)
                                AND ROWNUM                <= 1
                            ), 0) AS INSPECTION_ADDITION__AMT 
                     -- 검사 수당 지급 제외자 -- 
                     , NVL(( SELECT 'Y' AS EXCEPT_FLAG 
                               FROM HRM_INSPECTION_EXCEPT_V IA
                              WHERE IA.PERSON_NUM         = PM.PERSON_NUM
                                AND IA.SOB_ID             = PM.SOB_ID
                                AND IA.ORG_ID             = PM.ORG_ID
                                AND IA.ENABLED_FLAG       = 'Y'
                                AND IA.EFFECTIVE_DATE_FR  <= P_STD_DATE
                                AND (IA.EFFECTIVE_DATE_TO >= P_STD_DATE OR IA.EFFECTIVE_DATE_TO IS NULL)
                                AND ROWNUM                <= 1
                            ), 'N') AS INSPECTION_EXCEPT_FLAG
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER  PM
                    , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HH.CHARGE_DATE
                             , HL.DEPT_ID
                        FROM HRM_HISTORY_HEADER HH
                           , HRM_HISTORY_LINE   HL 
                        WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                          AND HH.CHARGE_SEQ          IN 
                                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                    FROM HRM_HISTORY_HEADER S_HH
                                       , HRM_HISTORY_LINE   S_HL
                                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                     AND S_HH.CHARGE_DATE       <= P_STD_DATE
                                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                                     AND S_HL.DEPT_ID           != S_HL.PRE_DEPT_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )  
                       ) T1 
                    , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.EFFECTIVE_DATE_FR AS CHARGE_DATE
                             , PH.DEPT_ID 
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.CORP_ID            = P_CORP_ID
                          AND PH.SOB_ID             = P_SOB_ID
                          AND PH.ORG_ID             = P_ORG_ID
                          AND PH.FLOOR_ID           != PH.PRE_FLOOR_ID
                          AND PH.EFFECTIVE_DATE_FR  <= P_STD_DATE
                          AND PH.EFFECTIVE_DATE_TO  >= P_STD_DATE
                       ) T2
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.PERSON_ID             = T1.PERSON_ID(+)
                   AND MP.PERSON_ID             = T2.PERSON_ID(+)
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_ALLOWANCE_AMOUNT            := 0;
      BEGIN
        SELECT TO_NUMBER(NVL(HC.VALUE3, 0)) AS JOB_AMOUNT
             , TO_NUMBER(NVL(HC.VALUE4, 0)) AS LONG_MONTH
          INTO V_ALLOWANCE_AMOUNT
            , V_LONG_MONTH
          FROM HRM_COMMON HC
        WHERE HC.GROUP_CODE       = 'ALLOWANCE_INSPECTION'
          AND HC.SOB_ID           = C1.SOB_ID
          AND HC.ORG_ID           = C1.ORG_ID
          AND HC.VALUE1           = C1.PAY_TYPE
          --AND HC.VALUE2           = C1.DEPT_CODE
          AND HC.VALUE5           = C1.FLOOR_CODE          
          AND HC.ENABLED_FLAG     = 'Y'
          AND HC.EFFECTIVE_DATE_FR  <= P_STD_DATE
          AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= P_STD_DATE)
          AND ROWNUM              <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ALLOWANCE_AMOUNT := 0;
      END;
      IF NVL(C1.INSPECTION_ADDITION__AMT, 0) > 0 THEN
        -- 검사수당 예외 지급자 적용 -- 
        V_ALLOWANCE_AMOUNT := NVL(C1.INSPECTION_ADDITION__AMT, 0);
      END IF;
      IF NVL(C1.INSPECTION_EXCEPT_FLAG, 'N') = 'Y' THEN
        -- 검사수당 미지급자 예외처리 적용 -- 
        V_ALLOWANCE_AMOUNT := 0;
      END IF;
      
      IF NVL(V_LONG_MONTH, 0) > C1.LONG_MONTH THEN
        -- 3개월 이전 입사자만 미지급.
        V_ALLOWANCE_AMOUNT := 0;
      END IF;
            
      IF NVL(P_GENERAL_TIME_YN, 'N') = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => C1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => P_ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      
      -- 기존 수당 삭제.
      ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                      , P_ALLOWANCE_ID
                      , P_SOB_ID
                      , P_ORG_ID
                      );
                      
      IF NVL(V_LONG_MONTH, 0) = C1.LONG_MONTH AND '15' < TO_CHAR(NVL(C1.CHARGE_DATE, C1.ORI_JOIN_DATE), 'DD') THEN
        -- 3개월 및 15일 이전 입사자만 미지급.
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF C1.RETIRE_DATE IS NOT NULL AND C1.EXCEPT_TYPE = 'R' AND '15' > TO_CHAR(C1.RETIRE_DATE, 'DD') THEN
        -- 15일 이전 퇴사자만 제외.
        V_ALLOWANCE_AMOUNT := 0;
      END IF;
      IF NVL(V_ALLOWANCE_AMOUNT, 0) > 0 THEN        
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
    END LOOP C1;  
    O_STATUS := 'S';  
  END INSPECTION_ALLOWANCE;
  
-- 75 검사수당 적용 여부(부서기준)
  PROCEDURE INSPECTION_ALLOWANCE_DEPT
            ( O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_ALLOWANCE_ID      IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE          IN HRP_MONTH_PAYMENT.PAY_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_STD_DATE          IN HRP_MONTH_PAYMENT.STANDARD_DATE%TYPE
            , P_EXCEPT_YN         IN VARCHAR2
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , P_GENERAL_TIME_YN   IN VARCHAR2  -- 통상시급 여부 
            )
  AS
    V_ALLOWANCE_AMOUNT            NUMBER := 0;
    V_LONG_MONTH                  NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    FOR C1 IN ( SELECT MP.MONTH_PAYMENT_ID
                     , MP.PERSON_ID
                     , MP.PAY_YYYYMM
                     , MP.WAGE_TYPE
                     , MP.CORP_ID
                     , MP.PAY_TYPE
                     , MP.LONG_MONTH
                     , DM.DEPT_CODE
                     , MP.SOB_ID
                     , MP.ORG_ID
                     , MP.EXCEPT_TYPE
                     , PM.ORI_JOIN_DATE
                     , PM.RETIRE_DATE
                     , NVL(T1.CHARGE_DATE, PM.JOIN_DATE) AS CHARGE_DATE  -- 발령일자.
                  FROM HRP_MONTH_PAYMENT MP
                    , HRM_PERSON_MASTER  PM
                    , HRM_DEPT_MASTER    DM
                    , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HH.CHARGE_DATE
                             , HL.DEPT_ID
                        FROM HRM_HISTORY_HEADER HH
                           , HRM_HISTORY_LINE   HL 
                        WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                          AND HH.CHARGE_SEQ          IN 
                                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                    FROM HRM_HISTORY_HEADER S_HH
                                       , HRM_HISTORY_LINE   S_HL
                                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                     AND S_HH.CHARGE_DATE       <= P_STD_DATE
                                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                                     AND S_HL.DEPT_ID           != S_HL.PRE_DEPT_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )  
                       ) T1 
                           
                    /*
                    , (-- 시점 인사내역.
                       SELECT HL.PERSON_ID
                            , HH.CHARGE_DATE
                            , HL.DEPT_ID
                         FROM HRM_HISTORY_HEADER HH
                            , HRM_HISTORY_LINE   HL
                        WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                          AND HL.HISTORY_LINE_ID    IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE  S_HL
                                                              , HRM_CHARGE_CODE_V S_CC
                                                         WHERE S_HL.CHARGE_ID     = S_CC.COMMON_ID
                                                           AND S_HL.PERSON_ID     = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE   <= P_STD_DATE
                                                           AND S_HL.DEPT_ID       != S_HL.PRE_DEPT_ID
                                                         GROUP BY S_HL.PERSON_ID
                                                        )
                      ) T1*/
                 WHERE MP.PERSON_ID             = PM.PERSON_ID
                   AND MP.DEPT_ID               = DM.DEPT_ID
                   AND MP.PERSON_ID             = T1.PERSON_ID(+)
                   AND MP.PAY_YYYYMM            = P_PAY_YYYYMM
                   AND MP.WAGE_TYPE             = P_WAGE_TYPE
                   AND MP.CORP_ID               = P_CORP_ID
                   AND MP.SOB_ID                = P_SOB_ID
                   AND MP.ORG_ID                = P_ORG_ID
                   AND ((P_DEPT_ID              IS NULL AND 1 = 1)
                     OR (P_DEPT_ID              IS NOT NULL AND MP.DEPT_ID = P_DEPT_ID))
                   AND ((P_PERSON_ID            IS NULL AND 1 = 1)
                     OR (P_PERSON_ID            IS NOT NULL AND MP.PERSON_ID = P_PERSON_ID))
                   AND ((P_PAY_TYPE             IS NULL AND 1 = 1)
                     OR (P_PAY_TYPE             IS NOT NULL AND MP.PAY_TYPE = P_PAY_TYPE))
                   AND MP.PAY_PROVIDE_YN        = 'Y'
                   AND MP.CLOSED_YN             = 'N'
                   AND (MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'I', NULL)
                     OR MP.EXCEPT_TYPE          = DECODE(P_EXCEPT_YN, 'Y', 'N', MP.EXCEPT_TYPE))
               )
    LOOP
      V_ALLOWANCE_AMOUNT            := 0;
      BEGIN
        SELECT TO_NUMBER(NVL(HC.VALUE3, 0)) AS JOB_AMOUNT
             , TO_NUMBER(NVL(HC.VALUE4, 0)) AS LONG_MONTH
          INTO V_ALLOWANCE_AMOUNT
            , V_LONG_MONTH
          FROM HRM_COMMON HC
        WHERE HC.GROUP_CODE       = 'ALLOWANCE_INSPECTION'
          AND HC.SOB_ID           = C1.SOB_ID
          AND HC.ORG_ID           = C1.ORG_ID
          AND HC.VALUE1           = C1.PAY_TYPE
          AND HC.VALUE2           = C1.DEPT_CODE
          AND HC.ENABLED_FLAG     = 'Y'
          AND HC.EFFECTIVE_DATE_FR  <= P_STD_DATE
          AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= P_STD_DATE)
          AND ROWNUM              <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_ALLOWANCE_AMOUNT := 0;
      END;
      
      IF NVL(V_LONG_MONTH, 0) > C1.LONG_MONTH THEN
        -- 3개월 이전 입사자만 미지급.
        V_ALLOWANCE_AMOUNT := 0;
      END IF;
      
      IF NVL(P_GENERAL_TIME_YN, 'N') = 'Y' THEN
      -- 중도 입/퇴사자도 해당 지급항목에 대상이면 통상시급 반영 -- 
        HRP_PAYMENT_G_SET.SAVE_GENERAL_HOURLY_PAY
          ( O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          , P_PERSON_ID         => C1.PERSON_ID 
          , P_SOB_ID            => P_SOB_ID 
          , P_ORG_ID            => P_ORG_ID 
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_ALLOWANCE_ID      => P_ALLOWANCE_ID 
          , P_ALLOWANCE_AMOUNT  => V_ALLOWANCE_AMOUNT 
          , P_USER_ID           => P_USER_ID
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      
      -- 기존 수당 삭제.
      ALLOWANCE_DELETE( C1.MONTH_PAYMENT_ID
                      , P_ALLOWANCE_ID
                      , P_SOB_ID
                      , P_ORG_ID
                      );
      IF NVL(V_LONG_MONTH, 0) = C1.LONG_MONTH AND '15' < TO_CHAR(NVL(C1.CHARGE_DATE, C1.ORI_JOIN_DATE), 'DD') THEN
        -- 3개월 및 15일 이전 입사자만 미지급.
        V_ALLOWANCE_AMOUNT := 0;
      ELSIF C1.RETIRE_DATE IS NOT NULL AND C1.EXCEPT_TYPE = 'R' AND '15' > TO_CHAR(C1.RETIRE_DATE, 'DD') THEN
        -- 15일 이전 퇴사자만 제외.
        V_ALLOWANCE_AMOUNT := 0;
      END IF;
      IF NVL(V_ALLOWANCE_AMOUNT, 0) > 0 THEN
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
    END LOOP C1;    
    O_STATUS := 'S';
  END INSPECTION_ALLOWANCE_DEPT;
    
---------------------------------------------------------------------------------------------------
-- 90. 급상여 지급/공제 항목 합계 UPDATE.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
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
            )
  AS
  BEGIN
    O_STATUS := 'F';
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
        SET (MP.PAY_AMOUNT, MP.TOT_SUPPLY_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS PAY_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
               WHERE MA.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MA.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = C1.MONTH_PAYMENT_ID
      ;
      
      -- 공제 항목 합계 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.DED_PAY_AMOUNT, MP.TOT_DED_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DED_PAY_AMOUNT
                   , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
                   , NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_DEDUCTION MD
               WHERE MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
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
    O_STATUS := 'S';
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

-- 93. 지급내역 삭제.
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
  
-- 94. 급여 마스터 반영.
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
      HRP_PAY_MASTER_G.SAVE_PAY_LINE
                      ( P_PAY_LINE_ID      => V_PAY_LINE_ID
                      , P_PAY_HEADER_ID    => V_PAY_HEADER_ID
                      , P_ALLOWANCE_TYPE   => P_ALLOWANCE_TYPE
                      , P_ALLOWANCE_ID     => P_ALLOWANCE_ID
                      , P_ALLOWANCE_AMOUNT => P_ALLOWANCE_AMOUNT
                      , P_ENABLED_FLAG     => 'Y'
                      , P_SOB_ID           => P_SOB_ID
                      , P_ORG_ID           => P_ORG_ID
                      , P_USER_ID          => P_USER_ID 
                      );
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('93. Pay Master Line Insert Error : ' || SQLERRM);
      RETURN;
    END;
  END PAY_MASTER_LINE_INSERT;
  
END HRP_MONTH_PAYMENT_G_SET;
/
