CREATE OR REPLACE PACKAGE HRP_PAY_MASTER_G
AS

-- 급여마스터 대상 조회.
  PROCEDURE DATA_SELECT_PERSON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRM_PERSON_MASTER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            );
            
-- 급여마스터 헤더 조회.
  PROCEDURE DATA_SELECT_HEADER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            );

-- 급여마스터 라인조회-지급항목.
  PROCEDURE DATA_SELECT_ALLOWANCE
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            );

-- 급여마스터 라인조회-공제항목.
  PROCEDURE DATA_SELECT_DEDUCTION
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ADD_ALLOWANCE SPREAD SELECT
  PROCEDURE ALLOWANCE_PROMPT_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );
            
-- ADD_ALLOWANCE SPREAD SELECT
  PROCEDURE ALLOWANCE_SPREAD_SELECT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_POST_ID           IN NUMBER
            , W_FLOOR_ID          IN NUMBER
            , W_JOB_CATEGORY_ID   IN NUMBER
            , W_PERSON_ID         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE DEDUCTION_PROMPT_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );

-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE DEDUCTION_SPREAD_SELECT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_POST_ID           IN NUMBER
            , W_FLOOR_ID          IN NUMBER
            , W_JOB_CATEGORY_ID   IN NUMBER
            , W_PERSON_ID         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );


---------------------------------------------------------------------------------------------------  
-- PAY MASTER SELECT
  PROCEDURE PAY_MASTER_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );

-- PAY MASTER SELECT(TERM)
  PROCEDURE PAY_MASTER_SELECT1
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_PAY_MASTER_HEADER.END_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );
            
-- 통상시급 관리 조회 -- 
  PROCEDURE SELECT_GENERAL_HOURLY_AMT
            ( P_CURSOR2           OUT TYPES.TCURSOR1
            , P_PAY_YYYYMM        IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER 
            );
            
                        
-- 가족수당 해당 인원수 조회.
  PROCEDURE SELECT_FAMILY_ALLOWANCE
            ( P_CURSOR2          OUT TYPES.TCURSOR2
            , W_PERSON_ID        IN HRM_FAMILY.PERSON_ID%TYPE
            );

-- 호봉등급 선택에 따른 금액 조회.
  PROCEDURE SELECT_GRADE_STEP_AMOUNT
            ( P_CURSOR3          OUT TYPES.TCURSOR3
            , W_CORP_ID          IN HRP_GRADE_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM       IN HRP_GRADE_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE         IN HRP_GRADE_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID     IN HRP_GRADE_HEADER.PAY_GRADE_ID%TYPE
            , W_GRADE_STEP       IN HRP_GRADE_LINE.GRADE_STEP%TYPE
            , W_SOB_ID           IN HRP_GRADE_HEADER.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_GRADE_HEADER.ORG_ID%TYPE
            );
---------------------------------------------------------------------------------------------------
-- PERSON INSERT(BLANK PROCEDURE)
  PROCEDURE PERSON_INSERT
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            );
            
-- PERSON UPDATE(BLANK PROCEDURE)
  PROCEDURE PERSON_UPDATE
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            );

-- 급여마스터 헤더 저장(INSERT/UPDATE) 제어.
  PROCEDURE SAVE_PAY_HEADER
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_YEAR_PROVIDE_YN  IN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );
            
-- PAY_MASTER_HEADER_INSERT
  PROCEDURE PAY_HEADER_INSERT
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_START_YYYYMM     IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_YEAR_PROVIDE_YN  IN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );

/*-- PAY_MASTER_HEADER_UPDATE.
  PROCEDURE PAY_HEADER_UPDATE
            ( P_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_START_YYYYMM     IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_YEAR_PROVIDE_YN  IN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE
            , O_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            );*/

---------------------------------------------------------------------------------------------------
-- 급여마스터 라인 저장.
  PROCEDURE SAVE_PAY_LINE
            ( P_PAY_LINE_ID      OUT HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_PAY_HEADER_ID    IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_ALLOWANCE_TYPE   IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID     IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );

-- 급여마스터 라인 수정.
  PROCEDURE PAY_LINE_UPDATE
            ( W_PAY_LINE_ID      IN HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );

---------------------------------------------------------------------------------------------------
-- 급여마스터 백업.
  PROCEDURE PAY_HEADER_BACKUP
            ( W_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_END_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );    
            
-- 급여마스터 라인 복사.
  PROCEDURE PAY_LINE_COPY
            ( P_PAY_HEADER_ID     IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_NEW_PAY_HEADER_ID IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID           IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );

-- 급여마스터 헤더 최종여부 리턴.
  FUNCTION PAY_HEADER_LAST_CHECK_F
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_START_YYYYMM     IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN VARCHAR2;
            
-- DATA_SELECT.
  PROCEDURE PAYMENT_DATA_SELECT
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_PERSON_ID        IN NUMBER
            , W_SOB_ID           IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID           IN HRM_PERSON_MASTER.ORG_ID%TYPE           
            );

---------------------------------------------------------------------------------------------------            
-- 은행정보 조회.
  PROCEDURE BANK_ACCOUNT_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_CORP_ID           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_PAY_TYPE          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_PERSON_ID         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );

-- 은행정보 수정.
  PROCEDURE BANK_ACCOUNT_UPDATE
            ( W_PAY_HEADER_ID IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_BANK_ID       IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , W_SOB_ID        IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID        IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID       IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );
            
END HRP_PAY_MASTER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_PAY_MASTER_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_PAY_MASTER_G
/* DESCRIPTION  : 개인별 급여 마스터 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 급여마스터 대상 조회.
  PROCEDURE DATA_SELECT_PERSON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRM_PERSON_MASTER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            )
  AS
    V_CAP_C             VARCHAR2(2) := 'N';
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    -- 처리 권한체크 --
    BEGIN
      V_CAP_C := HRM_MANAGER_G.USER_CAP_F
                   ( W_CORP_ID
                   , V_START_DATE
                   , V_END_DATE
                   , '30'  -- 급여.
                   , P_CONNECT_PERSON_ID
                   , W_SOB_ID
                   , W_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_CAP_C := 'N';
    END;
    
    OPEN P_CURSOR FOR
      SELECT T1.DEPT_NAME AS DEPT_NAME
           , T1.POST_NAME AS POST_NAME
           , T1.JOB_CATEGORY_NAME AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , T1.PAY_GRADE_ID AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID 
                   , DM.DEPT_CODE 
                   , DM.DEPT_NAME
                   , DM.DEPT_SORT_NUM 
                   , HL.POST_ID
                   , PC.POST_CODE
                   , PC.POST_NAME
                   , PC.SORT_NUM AS POST_SORT_NUM
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , JC.JOB_CATEGORY_NAME
                FROM HRM_HISTORY_HEADER      HH
                   , HRM_HISTORY_LINE        HL 
                   , HRM_DEPT_MASTER         DM
                   , HRM_POST_CODE_V         PC
                   , HRM_FLOOR_V             HF
                   , HRM_JOB_CATEGORY_CODE_V JC
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID             = DM.DEPT_ID
                 AND HL.POST_ID             = PC.POST_ID
                 AND HL.FLOOR_ID            = HF.FLOOR_ID
                 AND HL.JOB_CATEGORY_ID     = JC.JOB_CATEGORY_ID
                 AND HH.CHARGE_SEQ          IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )      
            ) T1   
          , (-- 급여 마스터 HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PAY_GRADE_ID
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_STD_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
               AND ((W_PERSON_ID            IS NULL AND 1 = 1) 
               OR   (W_PERSON_ID            IS NOT NULL AND PMH.PERSON_ID = W_PERSON_ID)) 
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID 
            ) P1
      WHERE PM.PERSON_ID        = T1.PERSON_ID 
        AND PM.PERSON_ID        = P1.PERSON_ID(+)
        AND PM.CORP_ID          = W_CORP_ID
        AND ((W_PERSON_ID       IS NULL AND 1 = 1) 
        OR   (W_PERSON_ID       IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID)) 
        AND ((W_DEPT_ID         IS NULL AND 1 = 1) 
        OR   (W_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID)) 
        AND ((W_PAY_GRADE_ID    IS NULL AND 1 = 1) 
        OR   (W_PAY_GRADE_ID    IS NOT NULL AND T1.PAY_GRADE_ID = W_PAY_GRADE_ID)) 
        AND PM.JOIN_DATE        <= V_END_DATE
        AND (PM.RETIRE_DATE     >= V_START_DATE OR PM.RETIRE_DATE IS NULL)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND PM.CORP_TYPE        = '1'  -- 자사직원만 -- 
        AND 1                   = DECODE(V_CAP_C, 'C', 1, 0)
        AND ((W_PAY_TYPE        IS NULL AND 1 = 1)
        OR   (W_PAY_TYPE        IS NOT NULL AND EXISTS
                                                  ( SELECT 'X'
                                                    FROM HRP_PAY_MASTER_HEADER PMH
                                                   WHERE PMH.PERSON_ID      = PM.PERSON_ID
                                                     AND PMH.PAY_TYPE       = NVL(W_PAY_TYPE, PMH.PAY_TYPE)  
                                                  )))
      ORDER BY T1.DEPT_SORT_NUM, T1.DEPT_CODE, T1.POST_SORT_NUM, PM.PERSON_NUM       
      ;  
  END DATA_SELECT_PERSON;
  
-- 급여마스터 헤더 조회.
  PROCEDURE DATA_SELECT_HEADER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID                 IN NUMBER
            )
  AS
    V_CAP_C             VARCHAR2(2) := 'N';
    V_END_DATE          DATE := NULL;
  BEGIN
    V_END_DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    -- 처리 권한체크 --
    BEGIN
      V_CAP_C := HRM_MANAGER_G.USER_CAP_F
                   ( W_CORP_ID
                   , TRUNC(V_END_DATE, 'MONTH')
                   , V_END_DATE
                   , '30'  -- 급여.
                   , P_CONNECT_PERSON_ID
                   , W_SOB_ID
                   , W_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_CAP_C := 'N';
    END;
    
    OPEN P_CURSOR FOR
      SELECT PMH.PAY_HEADER_ID
           , PMH.PERSON_ID
           , PMH.CORP_ID
           , PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , PMH.PRINT_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
           , T1.PAY_GRADE_ID
           , T1.PAY_GRADE_NAME
           , PMH.BANK_ID
           , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
           , PMH.BANK_ACCOUNTS
           , PMH.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
           , PMH.GRADE_STEP
           , PMH.CORP_CAR_YN
           , PMH.PAY_PROVIDE_YN
           , PMH.BONUS_PROVIDE_YN
           , PMH.YEAR_PROVIDE_YN
           , PMH.HIRE_INSUR_YN
           , PMH.DESCRIPTION
           , PMH.DED_FAMILY_COUNT
           , PMH.DED_CHILD_COUNT
           -- 통상시급 
           , HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F(PMH.START_YYYYMM, PMH.PERSON_ID, PMH.SOB_ID, PMH.ORG_ID) AS GENERAL_HOURLY_AMT 
           , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
           , 'N' AS HEADER_DATA_STATE  -- 헤더 데이터 상태 필드.
           , 'N' AS LINE_DATA_STATE    -- 라인 데이터 상태 필드.
        FROM HRP_PAY_MASTER_HEADER PMH
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.PAY_GRADE_ID
                   , PG.PAY_GRADE
                   , PG.PAY_GRADE_NAME
                FROM HRM_HISTORY_HEADER      HH
                   , HRM_HISTORY_LINE        HL 
                   , HRM_PAY_GRADE_V         PG
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HL.PAY_GRADE_ID        = PG.PAY_GRADE_ID 
                 AND HH.CHARGE_SEQ          IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )      
            ) T1 
       WHERE PMH.PERSON_ID            = T1.PERSON_ID
         AND PMH.CORP_ID              = W_CORP_ID
         AND PMH.START_YYYYMM         <= W_STD_YYYYMM
         AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
         AND PMH.PERSON_ID            = W_PERSON_ID
         AND ((W_PAY_TYPE             IS NULL AND 1 = 1) 
         OR   (W_PAY_TYPE             IS NOT NULL AND PMH.PAY_TYPE = W_PAY_TYPE)) 
         AND PMH.SOB_ID               = W_SOB_ID
         AND PMH.ORG_ID               = W_ORG_ID
      ;
  END DATA_SELECT_HEADER;

-- 급여마스터 라인조회-지급항목.
  PROCEDURE DATA_SELECT_ALLOWANCE
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PML.PAY_LINE_ID
           , PML.PAY_HEADER_ID
           , PML.ALLOWANCE_TYPE
           , PML.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME
           , PML.ALLOWANCE_AMOUNT
           , PML.ENABLED_FLAG
        FROM HRP_PAY_MASTER_LINE PML
          , HRM_ALLOWANCE_V HA
      WHERE PML.ALLOWANCE_ID          = HA.ALLOWANCE_ID
        AND PML.PAY_HEADER_ID         = W_PAY_HEADER_ID
        AND PML.ALLOWANCE_TYPE        = 'A'
      ORDER BY HA.SORT_NUM  
      ;  
  END DATA_SELECT_ALLOWANCE;

-- 급여마스터 라인조회-공제항목.
  PROCEDURE DATA_SELECT_DEDUCTION
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PML.PAY_LINE_ID
           , PML.PAY_HEADER_ID
           , PML.ALLOWANCE_TYPE
           , PML.ALLOWANCE_ID
           , HD.DEDUCTION_NAME
           , PML.ALLOWANCE_AMOUNT
           , PML.ENABLED_FLAG
        FROM HRP_PAY_MASTER_LINE PML
          , HRM_DEDUCTION_V HD
      WHERE PML.ALLOWANCE_ID          = HD.DEDUCTION_ID
        AND PML.PAY_HEADER_ID         = W_PAY_HEADER_ID
        AND PML.ALLOWANCE_TYPE        = 'D'
      ORDER BY HD.SORT_NUM  
      ;  
  END DATA_SELECT_DEDUCTION;

---------------------------------------------------------------------------------------------------
-- ADD_ALLOWANCE SPREAD SELECT
  PROCEDURE ALLOWANCE_PROMPT_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT -- 추가지급 PROMPT.
             MAX(DECODE(HA.ALLOWANCE_CODE, 'A01', HA.ALLOWANCE_NAME)) AS A01
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A02', HA.ALLOWANCE_NAME)) AS A02
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A03', HA.ALLOWANCE_NAME)) AS A03
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A04', HA.ALLOWANCE_NAME)) AS A04
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A05', HA.ALLOWANCE_NAME)) AS A05
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A06', HA.ALLOWANCE_NAME)) AS A06
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A07', HA.ALLOWANCE_NAME)) AS A07
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A08', HA.ALLOWANCE_NAME)) AS A08
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A09', HA.ALLOWANCE_NAME)) AS A09
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A10', HA.ALLOWANCE_NAME)) AS A10
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A11', HA.ALLOWANCE_NAME)) AS A11
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A12', HA.ALLOWANCE_NAME)) AS A12
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A13', HA.ALLOWANCE_NAME)) AS A13
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A14', HA.ALLOWANCE_NAME)) AS A14
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A15', HA.ALLOWANCE_NAME)) AS A15
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A16', HA.ALLOWANCE_NAME)) AS A16
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A17', HA.ALLOWANCE_NAME)) AS A17
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A18', HA.ALLOWANCE_NAME)) AS A18
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A19', HA.ALLOWANCE_NAME)) AS A19
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A20', HA.ALLOWANCE_NAME)) AS A20
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A21', HA.ALLOWANCE_NAME)) AS A21
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A22', HA.ALLOWANCE_NAME)) AS A22
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A23', HA.ALLOWANCE_NAME)) AS A23
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A24', HA.ALLOWANCE_NAME)) AS A24
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A25', HA.ALLOWANCE_NAME)) AS A25
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A26', HA.ALLOWANCE_NAME)) AS A26
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A27', HA.ALLOWANCE_NAME)) AS A27
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A28', HA.ALLOWANCE_NAME)) AS A28
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A29', HA.ALLOWANCE_NAME)) AS A29
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A30', HA.ALLOWANCE_NAME)) AS A30
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A31', HA.ALLOWANCE_NAME)) AS A31
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A32', HA.ALLOWANCE_NAME)) AS A32
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A33', HA.ALLOWANCE_NAME)) AS A33
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A34', HA.ALLOWANCE_NAME)) AS A34
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A35', HA.ALLOWANCE_NAME)) AS A35
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A36', HA.ALLOWANCE_NAME)) AS A36
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A37', HA.ALLOWANCE_NAME)) AS A37
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A38', HA.ALLOWANCE_NAME)) AS A38
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A39', HA.ALLOWANCE_NAME)) AS A39
           -- 추가지급항목 여부.
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A01', HA.PAY_MASTER_YN, 'N')) AS A01_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A02', HA.PAY_MASTER_YN, 'N')) AS A02_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A03', HA.PAY_MASTER_YN, 'N')) AS A03_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A04', HA.PAY_MASTER_YN, 'N')) AS A04_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A05', HA.PAY_MASTER_YN, 'N')) AS A05_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A06', HA.PAY_MASTER_YN, 'N')) AS A06_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A07', HA.PAY_MASTER_YN, 'N')) AS A07_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A08', HA.PAY_MASTER_YN, 'N')) AS A08_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A09', HA.PAY_MASTER_YN, 'N')) AS A09_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A10', HA.PAY_MASTER_YN, 'N')) AS A10_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A11', HA.PAY_MASTER_YN, 'N')) AS A11_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A12', HA.PAY_MASTER_YN, 'N')) AS A12_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A13', HA.PAY_MASTER_YN, 'N')) AS A13_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A14', HA.PAY_MASTER_YN, 'N')) AS A14_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A15', HA.PAY_MASTER_YN, 'N')) AS A15_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A16', HA.PAY_MASTER_YN, 'N')) AS A16_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A17', HA.PAY_MASTER_YN, 'N')) AS A17_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A18', HA.PAY_MASTER_YN, 'N')) AS A18_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A19', HA.PAY_MASTER_YN, 'N')) AS A19_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A20', HA.PAY_MASTER_YN, 'N')) AS A20_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A21', HA.PAY_MASTER_YN, 'N')) AS A21_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A22', HA.PAY_MASTER_YN, 'N')) AS A22_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A23', HA.PAY_MASTER_YN, 'N')) AS A23_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A24', HA.PAY_MASTER_YN, 'N')) AS A24_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A25', HA.PAY_MASTER_YN, 'N')) AS A25_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A26', HA.PAY_MASTER_YN, 'N')) AS A26_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A27', HA.PAY_MASTER_YN, 'N')) AS A27_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A28', HA.PAY_MASTER_YN, 'N')) AS A28_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A29', HA.PAY_MASTER_YN, 'N')) AS A29_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A30', HA.PAY_MASTER_YN, 'N')) AS A30_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A31', HA.PAY_MASTER_YN, 'N')) AS A31_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A32', HA.PAY_MASTER_YN, 'N')) AS A32_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A33', HA.PAY_MASTER_YN, 'N')) AS A33_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A34', HA.PAY_MASTER_YN, 'N')) AS A34_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A35', HA.PAY_MASTER_YN, 'N')) AS A35_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A36', HA.PAY_MASTER_YN, 'N')) AS A36_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A37', HA.PAY_MASTER_YN, 'N')) AS A37_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A38', HA.PAY_MASTER_YN, 'N')) AS A38_YN
           , MAX(DECODE(HA.ALLOWANCE_CODE, 'A39', HA.PAY_MASTER_YN, 'N')) AS A39_YN
        FROM HRM_ALLOWANCE_V HA
      WHERE HA.SOB_ID                   = W_SOB_ID
        AND HA.ORG_ID                   = W_ORG_ID
        AND HA.ENABLED_FLAG             = 'Y'
        AND HA.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')))
      GROUP BY HA.SOB_ID
           , HA.ORG_ID
      ;
  END ALLOWANCE_PROMPT_SELECT;

-- ADD_ALLOWANCE SPREAD SELECT
  PROCEDURE ALLOWANCE_SPREAD_SELECT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_POST_ID           IN NUMBER
            , W_FLOOR_ID          IN NUMBER
            , W_JOB_CATEGORY_ID   IN NUMBER
            , W_PERSON_ID         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    V_CAP_C             VARCHAR2(2) := 'N';
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'));
    -- 처리 권한체크 --
    BEGIN
      V_CAP_C := HRM_MANAGER_G.USER_ID_CAP_F
                   ( W_CORP_ID
                   , V_START_DATE
                   , V_END_DATE
                   , '30'  -- 급여.
                   , GET_USER_ID_F
                   , W_SOB_ID
                   , W_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_CAP_C := 'N';
    END;
    
    OPEN P_CURSOR2 FOR
      SELECT CASE
               WHEN GROUPING(T1.DEPT_NAME) = 1 THEN PT_TOTAL_SUM
               ELSE PM.NAME
             END AS NAME
           , PM.PERSON_NUM
           , T1.FLOOR_NAME
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , SUM(PML.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A01', PML.ALLOWANCE_AMOUNT)) AS A01
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A02', PML.ALLOWANCE_AMOUNT)) AS A02
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A03', PML.ALLOWANCE_AMOUNT)) AS A03
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A04', PML.ALLOWANCE_AMOUNT)) AS A04
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A05', PML.ALLOWANCE_AMOUNT)) AS A05
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A06', PML.ALLOWANCE_AMOUNT)) AS A06
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A07', PML.ALLOWANCE_AMOUNT)) AS A07
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A08', PML.ALLOWANCE_AMOUNT)) AS A08
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A09', PML.ALLOWANCE_AMOUNT)) AS A09
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A10', PML.ALLOWANCE_AMOUNT)) AS A10
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A11', PML.ALLOWANCE_AMOUNT)) AS A11
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A12', PML.ALLOWANCE_AMOUNT)) AS A12
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A13', PML.ALLOWANCE_AMOUNT)) AS A13
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A14', PML.ALLOWANCE_AMOUNT)) AS A14
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A15', PML.ALLOWANCE_AMOUNT)) AS A15
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A16', PML.ALLOWANCE_AMOUNT)) AS A16
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A17', PML.ALLOWANCE_AMOUNT)) AS A17
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A18', PML.ALLOWANCE_AMOUNT)) AS A18
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A19', PML.ALLOWANCE_AMOUNT)) AS A19
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A20', PML.ALLOWANCE_AMOUNT)) AS A20
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A21', PML.ALLOWANCE_AMOUNT)) AS A21
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A22', PML.ALLOWANCE_AMOUNT)) AS A22
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A23', PML.ALLOWANCE_AMOUNT)) AS A23
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A24', PML.ALLOWANCE_AMOUNT)) AS A24
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A25', PML.ALLOWANCE_AMOUNT)) AS A25
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A26', PML.ALLOWANCE_AMOUNT)) AS A26
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A27', PML.ALLOWANCE_AMOUNT)) AS A27
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A28', PML.ALLOWANCE_AMOUNT)) AS A28
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A29', PML.ALLOWANCE_AMOUNT)) AS A29
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A30', PML.ALLOWANCE_AMOUNT)) AS A30
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A31', PML.ALLOWANCE_AMOUNT)) AS A31
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A32', PML.ALLOWANCE_AMOUNT)) AS A32
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A33', PML.ALLOWANCE_AMOUNT)) AS A33
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A34', PML.ALLOWANCE_AMOUNT)) AS A34
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A35', PML.ALLOWANCE_AMOUNT)) AS A35
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A36', PML.ALLOWANCE_AMOUNT)) AS A36
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A37', PML.ALLOWANCE_AMOUNT)) AS A37
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A38', PML.ALLOWANCE_AMOUNT)) AS A38
           , SUM(DECODE(HA.ALLOWANCE_CODE, 'A39', PML.ALLOWANCE_AMOUNT)) AS A39
           , PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , T1.DEPT_NAME
           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
        FROM HRM_PERSON_MASTER      PM
          , HRP_PAY_MASTER_HEADER   PMH
          , HRP_PAY_MASTER_LINE     PML
          , HRM_ALLOWANCE_V         HA
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , DM.DEPT_NAME
                   , HL.POST_ID
                   , PC.POST_CODE
                   , PC.POST_NAME
                   , PC.SORT_NUM AS POST_SORT_NUM
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , JC.JOB_CATEGORY_NAME
                FROM HRM_HISTORY_HEADER      HH
                   , HRM_HISTORY_LINE        HL 
                   , HRM_DEPT_MASTER         DM
                   , HRM_POST_CODE_V         PC
                   , HRM_FLOOR_V             HF
                   , HRM_JOB_CATEGORY_CODE_V JC
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID             = DM.DEPT_ID
                 AND HL.POST_ID             = PC.POST_ID
                 AND HL.FLOOR_ID            = HF.FLOOR_ID
                 AND HL.JOB_CATEGORY_ID     = JC.JOB_CATEGORY_ID
                 AND HH.CHARGE_SEQ          IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )      
            ) T1            
      WHERE PM.PERSON_ID                = PMH.PERSON_ID
        AND PMH.PAY_HEADER_ID           = PML.PAY_HEADER_ID
        AND PML.ALLOWANCE_ID            = HA.ALLOWANCE_ID
        AND PM.PERSON_ID                = T1.PERSON_ID
        
        AND PM.CORP_ID                  = W_CORP_ID
        AND ((W_PERSON_ID               IS NULL AND 1 = 1) 
        OR   (W_PERSON_ID               IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID)) 
        AND ((W_POST_ID                 IS NULL AND 1 = 1)
        OR   (W_POST_ID                 IS NOT NULL AND T1.POST_ID = W_POST_ID))
        AND ((W_FLOOR_ID                IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID                IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID         IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID         IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        AND PM.SOB_ID                   = W_SOB_ID
        AND PM.ORG_ID                   = W_ORG_ID
        AND PM.JOIN_DATE                <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (PM.RETIRE_DATE             >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')) OR PM.RETIRE_DATE IS NULL)
        
        AND ((W_PERSON_ID               IS NULL AND 1 = 1) 
        OR   (W_PERSON_ID               IS NOT NULL AND PMH.PERSON_ID = W_PERSON_ID)) 
        AND PMH.START_YYYYMM            <= W_PAY_YYYYMM
        AND (PMH.END_YYYYMM             >= W_PAY_YYYYMM OR PMH.END_YYYYMM IS NULL)
        AND PMH.SOB_ID                  = W_SOB_ID
        AND PMH.ORG_ID                  = W_ORG_ID
        AND PML.ALLOWANCE_TYPE          = 'A'  -- 지급 --
        AND PML.ENABLED_FLAG            = 'Y'  
        AND HA.ENABLED_FLAG             = 'Y'
        AND HA.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (HA.EFFECTIVE_DATE_TO IS NULL OR HA.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')))
        
        AND 1                           = DECODE(V_CAP_C, 'C', 1, 2) 
      GROUP BY ROLLUP((PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , PM.NAME
           , PM.PERSON_NUM
           , T1.DEPT_NAME
           , T1.FLOOR_SORT_NUM
           , T1.FLOOR_CODE
           , T1.FLOOR_NAME
           , T1.POST_SORT_NUM
           , T1.POST_CODE
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE))
       ORDER BY T1.POST_SORT_NUM, T1.POST_CODE, T1.FLOOR_SORT_NUM, T1.FLOOR_CODE, PM.PERSON_NUM
      ;
  END ALLOWANCE_SPREAD_SELECT;
  
---------------------------------------------------------------------------------------------------
-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE DEDUCTION_PROMPT_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT -- 추가공제 PROMPT.
             MAX(DECODE(HD.DEDUCTION_CODE, 'D01', HD.DEDUCTION_NAME)) AS D01
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D02', HD.DEDUCTION_NAME)) AS D02
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D03', HD.DEDUCTION_NAME)) AS D03
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D04', HD.DEDUCTION_NAME)) AS D04
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D05', HD.DEDUCTION_NAME)) AS D05
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D06', HD.DEDUCTION_NAME)) AS D06
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D07', HD.DEDUCTION_NAME)) AS D07
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D08', HD.DEDUCTION_NAME)) AS D08
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D09', HD.DEDUCTION_NAME)) AS D09
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D10', HD.DEDUCTION_NAME)) AS D10
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D11', HD.DEDUCTION_NAME)) AS D11
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D12', HD.DEDUCTION_NAME)) AS D12
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D13', HD.DEDUCTION_NAME)) AS D13
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D14', HD.DEDUCTION_NAME)) AS D14
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D15', HD.DEDUCTION_NAME)) AS D15
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D16', HD.DEDUCTION_NAME)) AS D16
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D17', HD.DEDUCTION_NAME)) AS D17
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D18', HD.DEDUCTION_NAME)) AS D18
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D19', HD.DEDUCTION_NAME)) AS D19
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D20', HD.DEDUCTION_NAME)) AS D20
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D21', HD.DEDUCTION_NAME)) AS D21
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D22', HD.DEDUCTION_NAME)) AS D22
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D23', HD.DEDUCTION_NAME)) AS D23
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D24', HD.DEDUCTION_NAME)) AS D24
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D25', HD.DEDUCTION_NAME)) AS D25
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D26', HD.DEDUCTION_NAME)) AS D26
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D27', HD.DEDUCTION_NAME)) AS D27
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D28', HD.DEDUCTION_NAME)) AS D28
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D29', HD.DEDUCTION_NAME)) AS D29
           -- 추가공제항목 여부.
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D01', HD.PAY_MASTER_YN, 'N')) AS D01_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D02', HD.PAY_MASTER_YN, 'N')) AS D02_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D03', HD.PAY_MASTER_YN, 'N')) AS D03_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D04', HD.PAY_MASTER_YN, 'N')) AS D04_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D05', HD.PAY_MASTER_YN, 'N')) AS D05_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D06', HD.PAY_MASTER_YN, 'N')) AS D06_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D07', HD.PAY_MASTER_YN, 'N')) AS D07_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D08', HD.PAY_MASTER_YN, 'N')) AS D08_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D09', HD.PAY_MASTER_YN, 'N')) AS D09_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D10', HD.PAY_MASTER_YN, 'N')) AS D10_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D11', HD.PAY_MASTER_YN, 'N')) AS D11_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D12', HD.PAY_MASTER_YN, 'N')) AS D12_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D13', HD.PAY_MASTER_YN, 'N')) AS D13_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D14', HD.PAY_MASTER_YN, 'N')) AS D14_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D15', HD.PAY_MASTER_YN, 'N')) AS D15_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D16', HD.PAY_MASTER_YN, 'N')) AS D16_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D17', HD.PAY_MASTER_YN, 'N')) AS D17_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D18', HD.PAY_MASTER_YN, 'N')) AS D18_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D19', HD.PAY_MASTER_YN, 'N')) AS D19_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D20', HD.PAY_MASTER_YN, 'N')) AS D20_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D21', HD.PAY_MASTER_YN, 'N')) AS D21_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D22', HD.PAY_MASTER_YN, 'N')) AS D22_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D23', HD.PAY_MASTER_YN, 'N')) AS D23_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D24', HD.PAY_MASTER_YN, 'N')) AS D24_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D25', HD.PAY_MASTER_YN, 'N')) AS D25_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D26', HD.PAY_MASTER_YN, 'N')) AS D26_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D27', HD.PAY_MASTER_YN, 'N')) AS D27_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D28', HD.PAY_MASTER_YN, 'N')) AS D28_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D29', HD.PAY_MASTER_YN, 'N')) AS D29_YN
        FROM HRM_DEDUCTION_V HD
      WHERE HD.SOB_ID                   = W_SOB_ID
        AND HD.ORG_ID                   = W_ORG_ID
        AND HD.ENABLED_FLAG             = 'Y'
        AND HD.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (HD.EFFECTIVE_DATE_TO IS NULL OR HD.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')))
      GROUP BY HD.SOB_ID
           , HD.ORG_ID
      ;
  END DEDUCTION_PROMPT_SELECT;

-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE DEDUCTION_SPREAD_SELECT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_POST_ID           IN NUMBER
            , W_FLOOR_ID          IN NUMBER
            , W_JOB_CATEGORY_ID   IN NUMBER
            , W_PERSON_ID         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    V_CAP_C             VARCHAR2(2) := 'N';
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'));
    -- 처리 권한체크 --
    BEGIN
      V_CAP_C := HRM_MANAGER_G.USER_ID_CAP_F
                   ( W_CORP_ID
                   , V_START_DATE
                   , V_END_DATE
                   , '30'  -- 급여.
                   , GET_USER_ID_F
                   , W_SOB_ID
                   , W_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_CAP_C := 'N';
    END;
    
    OPEN P_CURSOR2 FOR
      SELECT CASE
               WHEN GROUPING(T1.DEPT_NAME) = 1 THEN PT_TOTAL_SUM
               ELSE PM.NAME
             END AS NAME
           , PM.PERSON_NUM
           , T1.FLOOR_NAME
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , SUM(PML.ALLOWANCE_AMOUNT) AS TOTAL_AMOUNT
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D01', PML.ALLOWANCE_AMOUNT)) AS D01
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D02', PML.ALLOWANCE_AMOUNT)) AS D02
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D03', PML.ALLOWANCE_AMOUNT)) AS D03
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D04', PML.ALLOWANCE_AMOUNT)) AS D04
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D05', PML.ALLOWANCE_AMOUNT)) AS D05
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D06', PML.ALLOWANCE_AMOUNT)) AS D06
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D07', PML.ALLOWANCE_AMOUNT)) AS D07
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D08', PML.ALLOWANCE_AMOUNT)) AS D08
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D09', PML.ALLOWANCE_AMOUNT)) AS D09
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D10', PML.ALLOWANCE_AMOUNT)) AS D10
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D11', PML.ALLOWANCE_AMOUNT)) AS D11
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D12', PML.ALLOWANCE_AMOUNT)) AS D12
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D13', PML.ALLOWANCE_AMOUNT)) AS D13
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D14', PML.ALLOWANCE_AMOUNT)) AS D14
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D15', PML.ALLOWANCE_AMOUNT)) AS D15
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D16', PML.ALLOWANCE_AMOUNT)) AS D16
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D17', PML.ALLOWANCE_AMOUNT)) AS D17
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D18', PML.ALLOWANCE_AMOUNT)) AS D18
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D19', PML.ALLOWANCE_AMOUNT)) AS D19
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D20', PML.ALLOWANCE_AMOUNT)) AS D20
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D21', PML.ALLOWANCE_AMOUNT)) AS D21
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D22', PML.ALLOWANCE_AMOUNT)) AS D22
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D23', PML.ALLOWANCE_AMOUNT)) AS D23
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D24', PML.ALLOWANCE_AMOUNT)) AS D24
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D25', PML.ALLOWANCE_AMOUNT)) AS D25
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D26', PML.ALLOWANCE_AMOUNT)) AS D26
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D27', PML.ALLOWANCE_AMOUNT)) AS D27
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D28', PML.ALLOWANCE_AMOUNT)) AS D28
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D29', PML.ALLOWANCE_AMOUNT)) AS D29
           , PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , T1.DEPT_NAME
           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
        FROM HRM_PERSON_MASTER      PM
          , HRP_PAY_MASTER_HEADER  PMH
          , HRP_PAY_MASTER_LINE     PML
          , HRM_DEDUCTION_V         HD
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , DM.DEPT_NAME
                   , HL.POST_ID
                   , PC.POST_CODE
                   , PC.POST_NAME
                   , PC.SORT_NUM AS POST_SORT_NUM
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , JC.JOB_CATEGORY_NAME
                FROM HRM_HISTORY_HEADER      HH
                   , HRM_HISTORY_LINE        HL 
                   , HRM_DEPT_MASTER         DM
                   , HRM_POST_CODE_V         PC
                   , HRM_FLOOR_V             HF
                   , HRM_JOB_CATEGORY_CODE_V JC
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID             = DM.DEPT_ID
                 AND HL.POST_ID             = PC.POST_ID
                 AND HL.FLOOR_ID            = HF.FLOOR_ID
                 AND HL.JOB_CATEGORY_ID     = JC.JOB_CATEGORY_ID
                 AND HH.CHARGE_SEQ          IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )      
            ) T1     
      WHERE PM.PERSON_ID                = PMH.PERSON_ID
        AND PMH.PAY_HEADER_ID           = PML.PAY_HEADER_ID
        AND PML.ALLOWANCE_ID            = HD.DEDUCTION_ID
        AND PM.PERSON_ID                = T1.PERSON_ID
        
        AND PM.CORP_ID                  = W_CORP_ID
        AND ((W_PERSON_ID               IS NULL AND 1 = 1) 
        OR   (W_PERSON_ID               IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID)) 
        AND ((W_POST_ID                 IS NULL AND 1 = 1)
        OR   (W_POST_ID                 IS NOT NULL AND T1.POST_ID = W_POST_ID))
        AND ((W_FLOOR_ID                IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID                IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID         IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID         IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        AND PM.SOB_ID                   = W_SOB_ID
        AND PM.ORG_ID                   = W_ORG_ID
        AND PM.JOIN_DATE                <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (PM.RETIRE_DATE             >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')) OR PM.RETIRE_DATE IS NULL)
        
        AND ((W_PERSON_ID               IS NULL AND 1 = 1) 
        OR   (W_PERSON_ID               IS NOT NULL AND PMH.PERSON_ID = W_PERSON_ID)) 
        AND PMH.START_YYYYMM            <= W_PAY_YYYYMM
        AND (PMH.END_YYYYMM             >= W_PAY_YYYYMM OR PMH.END_YYYYMM IS NULL)
        AND PMH.SOB_ID                  = W_SOB_ID
        AND PMH.ORG_ID                  = W_ORG_ID
        AND PML.ALLOWANCE_TYPE          = 'D'  -- 공제 --
        AND PML.ENABLED_FLAG            = 'Y'  
        AND HD.ENABLED_FLAG             = 'Y'
        AND HD.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (HD.EFFECTIVE_DATE_TO IS NULL OR HD.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')))
        
        AND 1                           = DECODE(V_CAP_C, 'C', 1, 2) 
      GROUP BY ROLLUP((PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , PM.NAME
           , PM.PERSON_NUM
           , T1.DEPT_NAME
           , T1.FLOOR_SORT_NUM
           , T1.FLOOR_CODE
           , T1.FLOOR_NAME
           , T1.POST_SORT_NUM
           , T1.POST_CODE
           , T1.POST_NAME
           , T1.JOB_CATEGORY_NAME
           , PM.JOIN_DATE
           , PM.RETIRE_DATE))
       ORDER BY T1.POST_SORT_NUM, T1.POST_CODE, T1.FLOOR_SORT_NUM, T1.FLOOR_CODE, PM.PERSON_NUM
      ;
  END DEDUCTION_SPREAD_SELECT;
  

---------------------------------------------------------------------------------------------------    
-- PAY MASTER SELECT
  PROCEDURE PAY_MASTER_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    V_END_DATE                                    DATE := NULL;
  BEGIN
    V_END_DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    
    OPEN P_CURSOR FOR
      SELECT T1.DEPT_NAME AS DEPT_NAME
           , T1.POST_NAME AS POST_NAME
           , T1.JOB_CATEGORY_NAME AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , P1.PAY_HEADER_ID
           , P1.START_YYYYMM
           , P1.END_YYYYMM
           , P1.PRINT_TYPE
           , P1.PRINT_TYPE_NAME
           , P1.BANK_ID
           , P1.BANK_NAME
           , P1.BANK_ACCOUNTS
           , P1.PAY_TYPE
           , P1.PAY_TYPE_NAME
           , NVL(P1.PAY_GRADE_ID, T1.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(P1.PAY_GRADE_ID, T1.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , P1.GRADE_STEP
           , NVL(P1.CORP_CAR_YN, 'N') AS CORP_CAR_YN
           , NVL(P1.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
           , NVL(P1.BONUS_PROVIDE_YN, 'N') AS BONUS_PROVIDE_YN
           , NVL(P1.HIRE_INSUR_YN, 'N') AS HIRE_INSUR_YN
           , P1.DESCRIPTION
           , P1.LAST_UPDATE_PERSON
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID 
                   , DM.DEPT_CODE 
                   , DM.DEPT_NAME
                   , DM.DEPT_SORT_NUM 
                   , HL.POST_ID
                   , PC.POST_CODE
                   , PC.POST_NAME
                   , PC.SORT_NUM AS POST_SORT_NUM
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , JC.JOB_CATEGORY_NAME
                FROM HRM_HISTORY_HEADER      HH
                   , HRM_HISTORY_LINE        HL 
                   , HRM_DEPT_MASTER         DM
                   , HRM_POST_CODE_V         PC
                   , HRM_FLOOR_V             HF
                   , HRM_JOB_CATEGORY_CODE_V JC
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID             = DM.DEPT_ID
                 AND HL.POST_ID             = PC.POST_ID
                 AND HL.FLOOR_ID            = HF.FLOOR_ID
                 AND HL.JOB_CATEGORY_ID     = JC.JOB_CATEGORY_ID
                 AND HH.CHARGE_SEQ          IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )      
            ) T1  
          , (-- 급여 마스터 HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PRINT_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
                 , PMH.BANK_ID
                 , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                 , PMH.BANK_ACCOUNTS
                 , PMH.PAY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                 , PMH.PAY_GRADE_ID
                 , PMH.GRADE_STEP
                 , PMH.CORP_CAR_YN
                 , PMH.PAY_PROVIDE_YN
                 , PMH.BONUS_PROVIDE_YN
                 , PMH.HIRE_INSUR_YN
                 , PMH.DESCRIPTION
                 , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_STD_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
               AND PMH.PERSON_ID            = W_PERSON_ID
               AND ((W_PAY_TYPE             IS NULL AND 1 = 1) 
               OR   (W_PAY_TYPE             IS NOT NULL AND PMH.PAY_TYPE = W_PAY_TYPE)) 
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID  
            ) P1
      WHERE PM.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = P1.PERSON_ID(+)
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.PERSON_ID        = W_PERSON_ID
        AND ((W_DEPT_ID         IS NULL AND 1 = 1) 
        OR   (W_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID)) 
        AND ((W_PAY_GRADE_ID    IS NULL AND 1 = 1)
        OR   (W_PAY_GRADE_ID    IS NOT NULL AND NVL(P1.PAY_GRADE_ID, T1.PAY_GRADE_ID) = W_PAY_GRADE_ID)) 
        AND PM.JOIN_DATE        <= V_END_DATE
        AND (PM.RETIRE_DATE     >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND PM.CORP_TYPE        = '1'  -- 자사직원만 -- 
      ORDER BY T1.DEPT_SORT_NUM, T1.DEPT_CODE, T1.POST_SORT_NUM, PM.PERSON_NUM
      ;
  END PAY_MASTER_SELECT;

-- PAY MASTER SELECT(TERM)
  PROCEDURE PAY_MASTER_SELECT1
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_PAY_MASTER_HEADER.END_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    V_START_DATE                                  DATE := NULL;
    V_END_DATE                                    DATE := NULL;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_START_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_END_YYYYMM, 'YYYY-MM'));
    
    OPEN P_CURSOR FOR
      SELECT T1.DEPT_NAME AS DEPT_NAME
           , T1.POST_NAME AS POST_NAME
           , T1.JOB_CATEGORY_NAME AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , P1.PAY_HEADER_ID
           , P1.START_YYYYMM
           , P1.END_YYYYMM
           , P1.PRINT_TYPE
           , P1.PRINT_TYPE_NAME
           , P1.BANK_ID
           , P1.BANK_NAME
           , P1.BANK_ACCOUNTS
           , P1.PAY_TYPE
           , P1.PAY_TYPE_NAME
           , NVL(P1.PAY_GRADE_ID, T1.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(P1.PAY_GRADE_ID, T1.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , P1.GRADE_STEP
           , NVL(P1.CORP_CAR_YN, 'N') AS CORP_CAR_YN
           , NVL(P1.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
           , NVL(P1.BONUS_PROVIDE_YN, 'N') AS BONUS_PROVIDE_YN
           , NVL(P1.HIRE_INSUR_YN, 'N') AS HIRE_INSUR_YN
           , P1.DESCRIPTION
           , P1.LAST_UPDATE_PERSON
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID 
                   , DM.DEPT_CODE 
                   , DM.DEPT_NAME
                   , DM.DEPT_SORT_NUM 
                   , HL.POST_ID
                   , PC.POST_CODE
                   , PC.POST_NAME
                   , PC.SORT_NUM AS POST_SORT_NUM
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , JC.JOB_CATEGORY_NAME
                FROM HRM_HISTORY_HEADER      HH
                   , HRM_HISTORY_LINE        HL 
                   , HRM_DEPT_MASTER         DM
                   , HRM_POST_CODE_V         PC
                   , HRM_FLOOR_V             HF
                   , HRM_JOB_CATEGORY_CODE_V JC
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID             = DM.DEPT_ID
                 AND HL.POST_ID             = PC.POST_ID
                 AND HL.FLOOR_ID            = HF.FLOOR_ID
                 AND HL.JOB_CATEGORY_ID     = JC.JOB_CATEGORY_ID
                 AND HH.CHARGE_SEQ          IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )      
            ) T1  
          , (-- 급여 마스터 HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PRINT_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
                 , PMH.BANK_ID
                 , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                 , PMH.BANK_ACCOUNTS
                 , PMH.PAY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                 , PMH.PAY_GRADE_ID
                 , PMH.GRADE_STEP
                 , PMH.CORP_CAR_YN
                 , PMH.PAY_PROVIDE_YN
                 , PMH.BONUS_PROVIDE_YN
                 , PMH.HIRE_INSUR_YN
                 , PMH.DESCRIPTION
                 , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_END_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_END_YYYYMM)
               AND ((W_PERSON_ID            IS NULL AND 1 = 1) 
               OR   (W_PERSON_ID            IS NOT NULL AND PMH.PERSON_ID = W_PERSON_ID)) 
               AND ((W_PAY_TYPE             IS NULL AND 1 = 1)
               OR   (W_PAY_TYPE             IS NOT NULL AND PMH.PAY_TYPE = W_PAY_TYPE)) 
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID  
            ) P1
      WHERE PM.PERSON_ID        = T1.PERSON_ID
        AND PM.PERSON_ID        = P1.PERSON_ID(+)

        AND PM.CORP_ID          = W_CORP_ID
        AND ((W_PERSON_ID       IS NULL AND 1 = 1) 
        OR   (W_PERSON_ID       IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
               
        AND ((W_DEPT_ID         IS NULL AND 1 = 1) 
        OR   (W_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))  
        AND ((W_PAY_GRADE_ID    IS NULL AND 1 = 1)
        OR   (W_PAY_GRADE_ID    IS NOT NULL AND NVL(P1.PAY_GRADE_ID, T1.PAY_GRADE_ID) = W_PAY_GRADE_ID)) 
        AND PM.JOIN_DATE        <= V_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND PM.CORP_TYPE        = '1'  -- 자사직원만 -- 
      ORDER BY T1.DEPT_SORT_NUM, T1.DEPT_CODE, T1.POST_SORT_NUM, PM.PERSON_NUM
      ;
  END PAY_MASTER_SELECT1;

-- 통상시급 관리 조회 -- 
  PROCEDURE SELECT_GENERAL_HOURLY_AMT
            ( P_CURSOR2           OUT TYPES.TCURSOR1
            , P_PAY_YYYYMM        IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER 
            )
  AS
    V_GENERAL_HOURLY_AMT    NUMBER := 0;
  BEGIN
    -- 통상시급 
    V_GENERAL_HOURLY_AMT := HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F(P_PAY_YYYYMM, P_PERSON_ID, P_SOB_ID, P_ORG_ID);
    
    OPEN P_CURSOR2 FOR 
      SELECT  HA.ALLOWANCE_CODE
            , HA.ALLOWANCE_NAME
            , HP.ALLOWANCE_AMOUNT
            , V_GENERAL_HOURLY_AMT AS GENERAL_HOURLY_AMT  
        FROM HRP_GENERAL_HOURLY_PAY HP
           , HRM_ALLOWANCE_V        HA
      WHERE HP.ALLOWANCE_ID         = HA.ALLOWANCE_ID 
        AND HP.PERSON_ID            = P_PERSON_ID 
        AND HP.SOB_ID               = P_SOB_ID 
        AND HP.ORG_ID               = P_ORG_ID 
        AND HP.PERIOD_FR            <= P_PAY_YYYYMM
        AND (HP.PERIOD_TO           >= P_PAY_YYYYMM OR HP.PERIOD_TO IS NULL) 
        AND HP.ENABLED_FLAG         = 'Y'
        AND HP.ALLOWANCE_AMOUNT     != 0
      ORDER BY HA.SORT_NUM, HA.ALLOWANCE_CODE
     ;
  END SELECT_GENERAL_HOURLY_AMT;
  
    
-- 가족수당 해당 인원수 조회.
  PROCEDURE SELECT_FAMILY_ALLOWANCE
            ( P_CURSOR2          OUT TYPES.TCURSOR2
            , W_PERSON_ID        IN HRM_FAMILY.PERSON_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT HF.PERSON_ID
          , YR.YEAR_RELATION_NAME
          , SUM( CASE 
                    WHEN YR.YEAR_RELATION_CODE IN ('1', '2') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1
                    WHEN YR.YEAR_RELATION_CODE IN ('3') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1 
                    WHEN YR.YEAR_RELATION_CODE IN ('4', '5') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1
                    WHEN YR.YEAR_RELATION_CODE IN ('6', '7') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1
                    ELSE 0
                  END) AS RELACTION_COUNT
        FROM HRM_FAMILY HF
          , HRM_RELATION_V HR
          , HRM_YEAR_RELATION_V YR
       WHERE HF.RELATION_ID             = HR.RELATION_ID
         AND HR.YEAR_RELATION_CODE      = YR.YEAR_RELATION_CODE
         AND HR.SOB_ID                  = YR.SOB_ID
         AND HR.ORG_ID                  = YR.ORG_ID
         AND HF.PERSON_ID               = W_PERSON_ID             
         AND HR.ENABLED_FLAG            = 'Y'
         AND YR.ENABLED_FLAG            = 'Y'
      GROUP BY HF.PERSON_ID 
        , YR.YEAR_RELATION_NAME
      ;
  END SELECT_FAMILY_ALLOWANCE;

-- 호봉등급 선택에 따른 금액 조회.
  PROCEDURE SELECT_GRADE_STEP_AMOUNT
            ( P_CURSOR3          OUT TYPES.TCURSOR3
            , W_CORP_ID          IN HRP_GRADE_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM       IN HRP_GRADE_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE         IN HRP_GRADE_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID     IN HRP_GRADE_HEADER.PAY_GRADE_ID%TYPE
            , W_GRADE_STEP       IN HRP_GRADE_LINE.GRADE_STEP%TYPE
            , W_SOB_ID           IN HRP_GRADE_HEADER.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_GRADE_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT GL.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME
           , GL.ALLOWANCE_AMOUNT
        FROM HRP_GRADE_HEADER GH
          , HRP_GRADE_LINE GL
          , HRM_ALLOWANCE_V HA
       WHERE GH.GRADE_HEADER_ID       = GL.GRADE_HEADER_ID
         AND GL.ALLOWANCE_ID          = HA.ALLOWANCE_ID
         AND GH.CORP_ID               = W_CORP_ID
         AND GH.PAY_TYPE              = W_PAY_TYPE
         AND GH.PAY_GRADE_ID          = W_PAY_GRADE_ID
         AND GL.GRADE_STEP            = W_GRADE_STEP
         AND GH.SOB_ID                = W_SOB_ID
         AND GH.ORG_ID                = W_ORG_ID
         AND GH.START_YYYYMM          <= W_STD_YYYYMM
         AND GH.END_YYYYMM            >= W_STD_YYYYMM
         AND GH.ENABLED_FLAG          = 'Y'
      ORDER BY HA.SORT_NUM
      ;
  END SELECT_GRADE_STEP_AMOUNT;
  
---------------------------------------------------------------------------------------------------
-- PERSON INSERT(BLANK PROCEDURE)
  PROCEDURE PERSON_INSERT
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            )
  AS
  BEGIN
    NULL;
  END PERSON_INSERT;

-- PERSON UPDATE(BLANK PROCEDURE)
  PROCEDURE PERSON_UPDATE
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            )
  AS
  BEGIN
    NULL;
  END PERSON_UPDATE;

-- 급여마스터 헤더 저장(INSERT/UPDATE) 제어.
  PROCEDURE SAVE_PAY_HEADER
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_YEAR_PROVIDE_YN  IN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            )
  AS
    V_PAY_HEADER_ID     HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE;
    V_START_YYYYMM      HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE;
    V_END_YYYYMM        HRP_PAY_MASTER_HEADER.END_YYYYMM%TYPE;
    V_LAST_YN           HRP_PAY_MASTER_HEADER.LAST_YN%TYPE;
  BEGIN
    -- 권한 설정.
    IF HRM_MANAGER_G.USER_ID_CAP_F ( W_CORP_ID => P_CORP_ID
                                   , W_START_DATE => TO_DATE(P_STD_YYYYMM || '-01', 'YYYY-MM-DD')
                                   , W_END_DATE => LAST_DAY(TO_DATE(P_STD_YYYYMM || '-01', 'YYYY-MM-DD'))
                                   , W_MODULE_CODE => '30'
                                   , W_USER_ID => P_USER_ID 
                                   , W_SOB_ID => P_SOB_ID
                                   , W_ORG_ID => P_ORG_ID) = 'C' THEN
      NULL;
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Pay Master Header : ' || EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10009', '&&CAP:=Save'));
      RETURN; 
    END IF;
    
    /*IF PAY_HEADER_LAST_CHECK_F
         ( P_PERSON_ID
          , P_CORP_ID
          , P_STD_YYYYMM
          , P_SOB_ID
          , P_ORG_ID) = 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL));
      RETURN;
    END IF;*/
    BEGIN
      SELECT PMH.PAY_HEADER_ID, PMH.START_YYYYMM, PMH.END_YYYYMM, PMH.LAST_YN
        INTO V_PAY_HEADER_ID, V_START_YYYYMM, V_END_YYYYMM, V_LAST_YN
        FROM HRP_PAY_MASTER_HEADER PMH
      WHERE PMH.PERSON_ID         = P_PERSON_ID
        AND PMH.CORP_ID           = P_CORP_ID
        AND PMH.START_YYYYMM      <= P_STD_YYYYMM
        AND PMH.END_YYYYMM        >= P_STD_YYYYMM
        AND PMH.SOB_ID            = P_SOB_ID
        AND PMH.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PAY_HEADER_ID := -1;
      V_LAST_YN := 'Y';
      V_START_YYYYMM := NULL;
      V_END_YYYYMM := NULL;
    END;
    /*IF V_LAST_YN = 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL));
      RETURN;
    END IF;*/
/*raise_application_error(-20001, 'header id ' || V_PAY_HEADER_ID || ', start ' || V_START_YYYYMM || ', END ' || V_END_YYYYMM);*/
    IF V_START_YYYYMM IS NULL OR V_START_YYYYMM < P_STD_YYYYMM THEN
/*Raise_application_error(-20001, 'header id ' || V_PAY_HEADER_ID || ', start ' || V_START_YYYYMM || ', END ' || V_END_YYYYMM);*/
      -- 신규 INSERT.
      PAY_HEADER_INSERT
        ( P_PAY_HEADER_ID
        , P_PERSON_ID
        , P_CORP_ID
        , P_STD_YYYYMM
        , P_PRINT_TYPE
        , P_BANK_ID
        , P_BANK_ACCOUNTS
        , P_PAY_TYPE
        , P_PAY_GRADE_ID
        , P_GRADE_STEP
        , P_CORP_CAR_YN
        , P_PAY_PROVIDE_YN
        , P_BONUS_PROVIDE_YN
        , P_YEAR_PROVIDE_YN
        , P_HIRE_INSUR_YN
        , P_DED_FAMILY_COUNT
        , P_DED_CHILD_COUNT
        , P_DESCRIPTION
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID 
        );
      IF V_START_YYYYMM < P_STD_YYYYMM THEN
        -- 헤더 백업.
        PAY_HEADER_BACKUP 
          ( W_PAY_HEADER_ID => V_PAY_HEADER_ID
          , P_END_YYYYMM => TO_CHAR(ADD_MONTHS(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), -1), 'YYYY-MM')
          , P_USER_ID => P_USER_ID
          );  
        -- 라인 COPY.
        PAY_LINE_COPY 
          ( V_PAY_HEADER_ID
          , P_PAY_HEADER_ID
          , P_SOB_ID
          , P_USER_ID
          );
      END IF;      
    ELSIF V_START_YYYYMM = P_STD_YYYYMM THEN
    -- 수정.
      UPDATE HRP_PAY_MASTER_HEADER
        SET PRINT_TYPE       = P_PRINT_TYPE
          , BANK_ID          = P_BANK_ID
          , BANK_ACCOUNTS    = P_BANK_ACCOUNTS
          , PAY_TYPE         = P_PAY_TYPE
          , PAY_GRADE_ID     = P_PAY_GRADE_ID
          , GRADE_STEP       = P_GRADE_STEP
          , CORP_CAR_YN      = NVL(P_CORP_CAR_YN, 'N')
          , PAY_PROVIDE_YN   = NVL(P_PAY_PROVIDE_YN, 'N')
          , BONUS_PROVIDE_YN = NVL(P_BONUS_PROVIDE_YN, 'N')
          , YEAR_PROVIDE_YN  = NVL(P_YEAR_PROVIDE_YN, 'N')
          , HIRE_INSUR_YN    = NVL(P_HIRE_INSUR_YN, 'N')
          , DED_FAMILY_COUNT = NVL(P_DED_FAMILY_COUNT, 0)
          , DED_CHILD_COUNT  = NVL(P_DED_CHILD_COUNT, 0)
          , DESCRIPTION      = P_DESCRIPTION
          , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID)
          , LAST_UPDATED_BY  = P_USER_ID
      WHERE PAY_HEADER_ID    = V_PAY_HEADER_ID
      ; 
      P_PAY_HEADER_ID := V_PAY_HEADER_ID;
    END IF;
  END SAVE_PAY_HEADER;
  
-- PAY_MASTER_HEADER_INSERT
  PROCEDURE PAY_HEADER_INSERT
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_START_YYYYMM     IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_YEAR_PROVIDE_YN  IN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                    DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_START_YYYYMM               VARCHAR2(7) := NULL;
  BEGIN
    BEGIN
      SELECT TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM') AS START_YYYYMM
        INTO V_START_YYYYMM
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID     = P_PERSON_ID
        AND NOT EXISTS
              ( SELECT 'X'
                  FROM HRP_PAY_MASTER_HEADER PMH
                WHERE PMH.PERSON_ID   = PM.PERSON_ID
                  AND PMH.SOB_ID      = PM.SOB_ID
                  AND PMH.ORG_ID      = PM.ORG_ID              
              )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_START_YYYYMM := P_START_YYYYMM;
    END;
    SELECT HRP_PAY_MASTER_HEADER_S1.NEXTVAL
      INTO P_PAY_HEADER_ID
      FROM DUAL;
    INSERT INTO HRP_PAY_MASTER_HEADER
    ( PAY_HEADER_ID
    , PERSON_ID 
    , CORP_ID 
    , START_YYYYMM 
    , PRINT_TYPE 
    , BANK_ID 
    , BANK_ACCOUNTS 
    , PAY_TYPE 
    , PAY_GRADE_ID 
    , GRADE_STEP 
    , CORP_CAR_YN 
    , PAY_PROVIDE_YN 
    , BONUS_PROVIDE_YN 
    , YEAR_PROVIDE_YN
    , HIRE_INSUR_YN 
    , DED_FAMILY_COUNT
    , DED_CHILD_COUNT
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_PAY_HEADER_ID
    , P_PERSON_ID
    , P_CORP_ID
    , V_START_YYYYMM  -- 적용 시작일자.
    , P_PRINT_TYPE
    , P_BANK_ID
    , P_BANK_ACCOUNTS
    , P_PAY_TYPE
    , P_PAY_GRADE_ID
    , P_GRADE_STEP
    , NVL(P_CORP_CAR_YN, 'N')
    , NVL(P_PAY_PROVIDE_YN, 'N')
    , NVL(P_BONUS_PROVIDE_YN, 'N')
    , NVL(P_YEAR_PROVIDE_YN, 'N')
    , NVL(P_HIRE_INSUR_YN, 'N')
    , NVL(P_DED_FAMILY_COUNT, 0)
    , NVL(P_DED_CHILD_COUNT, 0)
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );
  END PAY_HEADER_INSERT;

/*-- PAY_MASTER_HEADER_UPDATE.
  PROCEDURE PAY_HEADER_UPDATE
            ( P_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_START_YYYYMM     IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_YEAR_PROVIDE_YN  IN HRP_PAY_MASTER_HEADER.YEAR_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE
            , O_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            )
  AS
    V_START_YYYYMM               HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE;
    
  BEGIN
    --RAISE_APPLICATION_ERROR(-20001, 'UPDATE');  
    -- 같은 시작년월 데이터 Insert --> Error 발생.
    O_PAY_HEADER_ID := PAY_HEADER_ID_CHECK_F( P_PERSON_ID => P_PERSON_ID
                                            , P_CORP_ID => P_CORP_ID
                                            , P_START_YYYYMM => P_START_YYYYMM
                                            , P_SOB_ID => P_SOB_ID
                                            , P_ORG_ID => P_ORG_ID
                                            );
    IF O_PAY_HEADER_ID <> 0 THEN
      RAISE ERRNUMS.Exist_Next_Data;
    END IF;
    
    -- 기존자료 체크시 이전 년월 자료가 존재하면 기존것 백업후 신규 INSERT.
    BEGIN
      SELECT PMH.START_YYYYMM
        INTO V_START_YYYYMM
        FROM HRP_PAY_MASTER_HEADER PMH
       WHERE PMH.PAY_HEADER_ID    = P_PAY_HEADER_ID
      ;
    END;
--    RAISE_APPLICATION_ERROR(-20001, V_START_YYYYMM || ',, ' || P_START_YYYYMM);
    
    IF V_START_YYYYMM < P_START_YYYYMM THEN     
      PAY_HEADER_INSERT ( P_PAY_HEADER_ID => O_PAY_HEADER_ID
                        , P_PERSON_ID => P_PERSON_ID
                        , P_CORP_ID => P_CORP_ID
                        , P_START_YYYYMM => P_START_YYYYMM
                        , P_PRINT_TYPE => P_PRINT_TYPE
                        , P_BANK_ID => P_BANK_ID                        
                        , P_BANK_ACCOUNTS => P_BANK_ACCOUNTS
                        , P_PAY_TYPE => P_PAY_TYPE
                        , P_PAY_GRADE_ID => P_PAY_GRADE_ID
                        , P_GRADE_STEP => P_GRADE_STEP
                        , P_CORP_CAR_YN => P_CORP_CAR_YN
                        , P_PAY_PROVIDE_YN => P_PAY_PROVIDE_YN
                        , P_BONUS_PROVIDE_YN => P_BONUS_PROVIDE_YN
                        , P_HIRE_INSUR_YN => P_HIRE_INSUR_YN
                        , P_DED_FAMILY_COUNT => P_DED_FAMILY_COUNT
                        , P_DED_CHILD_COUNT => P_DED_CHILD_COUNT
                        , P_DESCRIPTION => P_DESCRIPTION
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      PAY_LINE_COPY ( P_PAY_HEADER_ID => P_PAY_HEADER_ID
                    , P_NEW_PAY_HEADER_ID => O_PAY_HEADER_ID
                    , P_SOB_ID => P_SOB_ID
                    , P_USER_ID => P_USER_ID
                    );
                          
    ELSIF V_START_YYYYMM = P_START_YYYYMM THEN
      UPDATE HRP_PAY_MASTER_HEADER
        SET PRINT_TYPE       = P_PRINT_TYPE
          , BANK_ID          = P_BANK_ID
          , BANK_ACCOUNTS    = P_BANK_ACCOUNTS
          , PAY_TYPE         = P_PAY_TYPE
          , PAY_GRADE_ID     = P_PAY_GRADE_ID
          , GRADE_STEP       = P_GRADE_STEP
          , CORP_CAR_YN      = P_CORP_CAR_YN
          , PAY_PROVIDE_YN   = P_PAY_PROVIDE_YN
          , BONUS_PROVIDE_YN = P_BONUS_PROVIDE_YN
          , HIRE_INSUR_YN    = P_HIRE_INSUR_YN
          , DED_FAMILY_COUNT = NVL(P_DED_FAMILY_COUNT, 0)
          , DED_CHILD_COUNT  = NVL(P_DED_CHILD_COUNT, 0)
          , DESCRIPTION      = P_DESCRIPTION
          , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID)
          , LAST_UPDATED_BY  = P_USER_ID
      WHERE PAY_HEADER_ID    = P_PAY_HEADER_ID
      ; 
      O_PAY_HEADER_ID := P_PAY_HEADER_ID;
      
    ELSE
      O_PAY_HEADER_ID := P_PAY_HEADER_ID;
       
    END IF;
  
  EXCEPTION
    WHEN ERRNUMS.Invalid_Sequence_ID THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    WHEN ERRNUMS.Exist_Next_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Next_Code, ERRNUMS.Exist_Next_Desc);
  END PAY_HEADER_UPDATE;*/

---------------------------------------------------------------------------------------------------
-- 급여마스터 라인 저장.
  PROCEDURE SAVE_PAY_LINE
            ( P_PAY_LINE_ID      OUT HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_PAY_HEADER_ID    IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_ALLOWANCE_TYPE   IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID     IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_LAST_YN           VARCHAR2(1) := 'N';
    V_PERSON_ID         NUMBER;        
    V_CORP_ID           NUMBER;
    V_STD_YYYYMM        VARCHAR2(10);
  BEGIN
    --RAISE_APPLICATION_ERROR(-20001, P_PAY_HEADER_ID);
    BEGIN
      SELECT PMH.PERSON_ID
           , PMH.CORP_ID
           , PMH.START_YYYYMM
        INTO V_PERSON_ID
           , V_CORP_ID
           , V_STD_YYYYMM
        FROM HRP_PAY_MASTER_HEADER PMH
      WHERE PMH.PAY_HEADER_ID     = P_PAY_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LAST_YN := 'N';
    END;
    V_LAST_YN := PAY_HEADER_LAST_CHECK_F
                 ( V_PERSON_ID
                  , V_CORP_ID
                  , V_STD_YYYYMM
                  , P_SOB_ID
                  , P_ORG_ID);
    /*IF V_LAST_YN = 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, 'PERSON ID : ' || V_PERSON_ID || ' - ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL));
      RETURN;
    END IF;*/
    
    -- 권한 설정.
    IF HRM_MANAGER_G.USER_ID_CAP_F ( W_CORP_ID => V_CORP_ID
                                   , W_START_DATE => TO_DATE(V_STD_YYYYMM || '-01', 'YYYY-MM-DD')
                                   , W_END_DATE => LAST_DAY(TO_DATE(V_STD_YYYYMM || '-01', 'YYYY-MM-DD'))
                                   , W_MODULE_CODE => '30'
                                   , W_USER_ID => P_USER_ID 
                                   , W_SOB_ID => P_SOB_ID
                                   , W_ORG_ID => P_ORG_ID) = 'C' THEN
      NULL;
    ELSE
      RAISE_APPLICATION_ERROR(-20001, 'Pay Master Line : ' || EAPP_MESSAGE_G.RETURN_MSG_F('EAPP_10009', '&&CAP:=Save'));
      RETURN; 
    END IF;
    
    P_PAY_LINE_ID := 0;
    BEGIN
      SELECT PML.PAY_LINE_ID
        INTO P_PAY_LINE_ID
        FROM HRP_PAY_MASTER_LINE PML
       WHERE PML.PAY_HEADER_ID    = P_PAY_HEADER_ID
         AND PML.ALLOWANCE_TYPE   = P_ALLOWANCE_TYPE
         AND PML.ALLOWANCE_ID     = P_ALLOWANCE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      P_PAY_LINE_ID := 0;
    END;
    
    IF P_PAY_LINE_ID = 0 THEN
    -- 신규 생성.
      BEGIN
        SELECT HRP_PAY_MASTER_LINE_S1.NEXTVAL
        INTO P_PAY_LINE_ID
        FROM DUAL;
      EXCEPTION WHEN OTHERS THEN
        RAISE ERRNUMS.Invalid_Sequence_ID;
      END;

      INSERT INTO HRP_PAY_MASTER_LINE
      ( PAY_LINE_ID
      , PAY_HEADER_ID 
      , ALLOWANCE_TYPE 
      , ALLOWANCE_ID 
      , ALLOWANCE_AMOUNT 
      , ENABLED_FLAG 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( P_PAY_LINE_ID
      , P_PAY_HEADER_ID
      , P_ALLOWANCE_TYPE
      , P_ALLOWANCE_ID
      , P_ALLOWANCE_AMOUNT
      , P_ENABLED_FLAG
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID 
      );
    ELSE
    -- 기존 자료 UPDATE.
      FOR C1 IN ( SELECT PMH.PAY_HEADER_ID
                       , PML.PAY_LINE_ID
                    FROM HRP_PAY_MASTER_HEADER PMH
                       , HRP_PAY_MASTER_LINE   PML
                  WHERE PMH.PAY_HEADER_ID     = PML.PAY_HEADER_ID
                    AND ((PMH.START_YYYYMM    <= V_STD_YYYYMM
                    AND  PMH.END_YYYYMM       >= V_STD_YYYYMM)/*
                    OR   PMH.START_YYYYMM     >= V_STD_YYYYMM*/)
                    AND PMH.PERSON_ID         = V_PERSON_ID
                    AND PMH.SOB_ID            = P_SOB_ID
                    AND PMH.ORG_ID            = P_ORG_ID
                    AND PML.ALLOWANCE_TYPE    = P_ALLOWANCE_TYPE
                    AND PML.ALLOWANCE_ID      = P_ALLOWANCE_ID
                  )
      LOOP
        PAY_LINE_UPDATE ( W_PAY_LINE_ID => C1.PAY_LINE_ID
                        , P_ALLOWANCE_AMOUNT => P_ALLOWANCE_AMOUNT
                        , P_ENABLED_FLAG => P_ENABLED_FLAG
                        , P_SOB_ID => P_SOB_ID
                        , P_USER_ID => P_USER_ID
                        );
      END LOOP C1;
    END IF;
    
  EXCEPTION
    WHEN ERRNUMS.Invalid_Sequence_ID THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END SAVE_PAY_LINE;

-- 급여마스터 라인 수정.
  PROCEDURE PAY_LINE_UPDATE
            ( W_PAY_LINE_ID      IN HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
  BEGIN
--    RAISE_APPLICATION_ERROR(-20001, 'UPDATE');  
    UPDATE HRP_PAY_MASTER_LINE
      SET ALLOWANCE_AMOUNT = P_ALLOWANCE_AMOUNT
        , ENABLED_FLAG     = P_ENABLED_FLAG
        , LAST_UPDATE_DATE = GET_LOCAL_DATE(P_SOB_ID)
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE PAY_LINE_ID      = W_PAY_LINE_ID
    ;

  END PAY_LINE_UPDATE;

---------------------------------------------------------------------------------------------------
-- 급여마스터 백업.
  PROCEDURE PAY_HEADER_BACKUP
            ( W_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_END_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    -- 기존 자료 존재시 BACKUP 후 INSERT.
    BEGIN
      UPDATE HRP_PAY_MASTER_HEADER PMH
        SET PMH.END_YYYYMM        = P_END_YYYYMM
          , PMH.LAST_YN           = 'N'
          , PMH.LAST_UPDATE_DATE  = GET_LOCAL_DATE(PMH.SOB_ID)
          , PMH.LAST_UPDATED_BY   = P_USER_ID
        WHERE PMH.PAY_HEADER_ID = W_PAY_HEADER_ID
       ;
    END;
  END PAY_HEADER_BACKUP;
  
-- 급여마스터 라인 카피.
  PROCEDURE PAY_LINE_COPY
            ( P_PAY_HEADER_ID     IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_NEW_PAY_HEADER_ID IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID           IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    INSERT INTO HRP_PAY_MASTER_LINE
    ( PAY_LINE_ID
    , PAY_HEADER_ID 
    , ALLOWANCE_TYPE 
    , ALLOWANCE_ID 
    , ALLOWANCE_AMOUNT 
    , DESCRIPTION
    , ENABLED_FLAG 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY)
    ( SELECT HRP_PAY_MASTER_LINE_S1.NEXTVAL AS PAY_LINE_ID
           , P_NEW_PAY_HEADER_ID
           , PML.ALLOWANCE_TYPE
           , PML.ALLOWANCE_ID
           , PML.ALLOWANCE_AMOUNT
           , PML.DESCRIPTION
           , PML.ENABLED_FLAG
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRP_PAY_MASTER_LINE PML
       WHERE PML.PAY_HEADER_ID     = P_PAY_HEADER_ID
    );
  END PAY_LINE_COPY;

-- 급여마스터 헤더 최종여부 리턴.
  FUNCTION PAY_HEADER_LAST_CHECK_F
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_START_YYYYMM     IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_LAST_YN           HRP_PAY_MASTER_HEADER.LAST_YN%TYPE := 'N';
  BEGIN
    BEGIN
      SELECT PMH.LAST_YN
        INTO V_LAST_YN
        FROM HRP_PAY_MASTER_HEADER PMH
      WHERE PMH.PERSON_ID         = P_PERSON_ID
        AND PMH.CORP_ID           = P_CORP_ID
        AND PMH.START_YYYYMM      <= P_START_YYYYMM
        AND PMH.END_YYYYMM        >= P_START_YYYYMM
        AND PMH.SOB_ID            = P_SOB_ID
        AND PMH.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LAST_YN := '-';
    END;
    IF V_LAST_YN = '-' THEN
      BEGIN
        SELECT 'N' AS LAST_YN    -- 입력값보다 큰 일자 존재 : 무조건 최종자료 아님.
          INTO V_LAST_YN
          FROM HRP_PAY_MASTER_HEADER PMH
        WHERE PMH.PERSON_ID         = P_PERSON_ID
          AND PMH.CORP_ID           = P_CORP_ID
          AND PMH.START_YYYYMM      > P_START_YYYYMM
          AND PMH.SOB_ID            = P_SOB_ID
          AND PMH.ORG_ID            = P_ORG_ID
          AND ROWNUM                <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_LAST_YN := 'Y';
      END;
    END IF;
    RETURN V_LAST_YN;
  END PAY_HEADER_LAST_CHECK_F;
  
-- PAYMENT_DATA_SELECT : Payment Date, Bank number
  PROCEDURE PAYMENT_DATA_SELECT
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_PERSON_ID        IN NUMBER
            , W_SOB_ID           IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID           IN HRM_PERSON_MASTER.ORG_ID%TYPE           
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SX1.PERSON_ID
           , SX1.PAYMENT_DATE
           , ( SELECT HRM_COMMON_G.ID_NAME_F(MH.BANK_ID) AS BANK_NAME
                 FROM HRP_PAY_MASTER_HEADER MH
                WHERE MH.PERSON_ID        = SX1.PERSON_ID
                  AND MH.LAST_YN          = 'Y'
                  AND ROWNUM              <= 1
             ) AS BANK_NAME
           , ( SELECT MH.BANK_ACCOUNTS
                 FROM HRP_PAY_MASTER_HEADER MH
                WHERE MH.PERSON_ID        = SX1.PERSON_ID
                  AND MH.LAST_YN          = 'Y'
                  AND ROWNUM              <= 1
             ) AS BANK_ACCOUNTS
           , SX1.PAY_TYPE_NAME
           , TO_CHAR(SX1.BASE_AMOUNT, 'FM999,999,999,999,999,999') AS BASE_AMOUNT
					 , SX1.PAY_TYPE 
        FROM (SELECT PMH.PERSON_ID
                   , PMH.START_YYYYMM || '~' || REPLACE(PMH.END_YYYYMM, '2999-12', '') AS PAYMENT_DATE
                   , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                   , NVL(( SELECT SUM(PML.ALLOWANCE_AMOUNT) * 
                                  CASE
                                    WHEN PMH.PAY_TYPE IN('1', '3') THEN 12 
                                    ELSE 1
                                  END AS ALLOWANCE_AMOUNT
                             FROM HRP_PAY_MASTER_LINE PML
                                , HRM_ALLOWANCE_V     HA
                            WHERE PML.ALLOWANCE_ID      = HA.ALLOWANCE_ID
                              AND PML.PAY_HEADER_ID     = PMH.PAY_HEADER_ID
                              AND ((HA.ALLOWANCE_CODE   = 'A01')
                              OR   (PMH.PAY_TYPE        IN('1', '3') AND HA.ALLOWANCE_CODE IN('A11', 'A21', 'A09')
                              OR    PMH.PAY_TYPE        NOT IN('1', '3') AND 1 = 2))
                              AND HA.ENABLED_FLAG     = 'Y'
                         ), 0) AS BASE_AMOUNT 
                   , PMH.PAY_TYPE  
               FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.PERSON_ID        = W_PERSON_ID
                AND PMH.SOB_ID           = W_SOB_ID
                AND PMH.ORG_ID           = W_ORG_ID
              ORDER BY PMH.START_YYYYMM DESC
             ) SX1
      WHERE ROWNUM                <= 4
      ;
  END PAYMENT_DATA_SELECT;

---------------------------------------------------------------------------------------------------
-- 은행정보 조회.
  PROCEDURE BANK_ACCOUNT_SELECT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_CORP_ID           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_PAY_TYPE          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_PERSON_ID         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT PM.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , DM.DEPT_NAME
           , PC.POST_NAME
           , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
           , PMH.BANK_ID
           , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
           , PMH.BANK_ACCOUNTS
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
           , PMH.PAY_PROVIDE_YN
           , PMH.BONUS_PROVIDE_YN
           , PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , PMH.DESCRIPTION
           , PMH.PAY_HEADER_ID
           , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
        FROM HRP_PAY_MASTER_HEADER PMH
          , HRM_PERSON_MASTER PM
          , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID    
              FROM HRM_HISTORY_LINE HL  
              WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
                                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
            ) T1 
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
      WHERE PMH.PERSON_ID            = PM.PERSON_ID 
        AND PM.PERSON_ID             = T1.PERSON_ID
        AND T1.DEPT_ID               = DM.DEPT_ID
        AND T1.POST_ID               = PC.POST_ID
        AND PMH.CORP_ID              = W_CORP_ID
        AND PMH.PERSON_ID             = NVL(W_PERSON_ID, PMH.PERSON_ID)
        AND PMH.PAY_TYPE              = NVL(W_PAY_TYPE, PMH.PAY_TYPE)
        AND PMH.PAY_GRADE_ID          = NVL(W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
        AND PMH.SOB_ID                = W_SOB_ID
        AND PMH.ORG_ID                = W_ORG_ID
        AND PMH.START_YYYYMM          <= W_STD_YYYYMM
        AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
        AND PM.ORI_JOIN_DATE          <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')))
      ORDER BY DM.DEPT_SORT_NUM, DM.DEPT_CODE, PC.SORT_NUM, PC.POST_CODE, PM.PERSON_NUM
      ;
  END BANK_ACCOUNT_SELECT;
  
  
--ACCOUNT_UPDATE
  PROCEDURE BANK_ACCOUNT_UPDATE
    ( W_PAY_HEADER_ID IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
    , P_BANK_ID       IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
    , P_BANK_ACCOUNTS IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
    , W_SOB_ID        IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
    , W_ORG_ID        IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
    , P_USER_ID       IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE )
    
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    UPDATE HRP_PAY_MASTER_HEADER
      SET BANK_ID          = P_BANK_ID
        , BANK_ACCOUNTS    = P_BANK_ACCOUNTS
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE PAY_HEADER_ID    = W_PAY_HEADER_ID
      AND SOB_ID           = W_SOB_ID
      AND ORG_ID           = W_ORG_ID;
  EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, SUBSTR(SQLERRM, 1, 150));
  END BANK_ACCOUNT_UPDATE;
  
END HRP_PAY_MASTER_G;
/
