CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUSTMENT_G
AS

-------------------------------------------------------------------------------
-- 사원정보 조회 -- 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_EMPLOYE_TYPE      IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
            
-------------------------------------------------------------------------------
-- 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );

-------------------------------------------------------------------------------
-- 연말정산 내역 마감 / 마감 취소 데이터 조회 --  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_YEAR_ADJUSTMENT_CLOSED
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_CLOSED_FLAG       IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
                        
-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 조회.  
-------------------------------------------------------------------------------  
  PROCEDURE TAX_SUMMERY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );


-------------------------------------------------------------------------------
-- 연말정산 내역 급여전송 / 미전송 데이터 조회 --  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_YEAR_ADJUSTMENT_PAYMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_YEAR_YYYY         IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_TRANS_YN          IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 급여 전송 OR 전송취소.  
-------------------------------------------------------------------------------  
  PROCEDURE SET_TRANSFER_SALARY
            ( P_YEAR_YYYYMM       IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN  HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_TRANS_YN          IN  HRA_YEAR_ADJUSTMENT.TRANS_YN%TYPE
            , P_EVENT_STATUS      IN  VARCHAR2
            , P_PAY_YYYYMM        IN  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN  HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN  HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_TRANS_PERSON_ID   IN  HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_USER_ID           IN  HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );


-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 급여 전송.  
-------------------------------------------------------------------------------  
  PROCEDURE TRANSFER_PAYMENT
            ( P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_YEAR_YYYY         IN HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_TRANS_PERSON_ID   IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

-------------------------------------------------------------------------------
-- 연말정산 차감 집계  기간별 내역 조회.  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_TAX_SUMMERY
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_SUBMIT_DATE_FR    IN  DATE
            , W_SUBMIT_DATE_TO    IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );


  PROCEDURE SELECT_YEAR_ADJUSTMENT2
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_EMPLOYE_YN        IN HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
            , W_POST_ID           IN HRM_PERSON_MASTER.POST_ID%TYPE
            , W_DEPT_ID           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_FLOOR_ID          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
            
END HRA_YEAR_ADJUSTMENT_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUSTMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_YEAR_ADJUSTMENT_G
/* Description  : 연말정산 계산 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/
-------------------------------------------------------------------------------
-- 사원정보 조회 -- 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_EMPLOYE_TYPE      IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
  BEGIN
    OPEN P_CURSOR FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , T1.DEPT_NAME
          , T1.FLOOR_NAME
          , T1.POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME              
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.REPRE_NUM
          , EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_STD_DATE, 0) AS AGE
          , PM.PERSON_ID
          , PM.CORP_ID
          , T1.DEPT_ID
          , T1.FLOOR_ID
          , T1.POST_ID
          , T1.PAY_GRADE_ID
      FROM HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT  HL.PERSON_ID
                  , HL.DEPT_ID
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , HL.POST_ID
                  , HP.POST_NAME
                  , HP.SORT_NUM AS POST_SORT_NUM                  
                  , HL.PAY_GRADE_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID    
                  , HF.FLOOR_NAME
                  , HF.SORT_NUM AS FLOOR_SORT_NUM
              FROM HRM_HISTORY_HEADER HH
                 , HRM_HISTORY_LINE   HL  
                 , HRM_DEPT_MASTER    DM
                 , HRM_FLOOR_V        HF
                 , HRM_POST_CODE_V    HP
            WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
              AND HL.DEPT_ID              = DM.DEPT_ID
              AND HL.FLOOR_ID             = HF.FLOOR_ID
              AND HL.POST_ID              = HP.POST_ID
              AND HH.SOB_ID               = W_SOB_ID
              AND HH.ORG_ID               = W_ORG_ID              
              AND HL.HISTORY_LINE_ID  
                    IN (SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                         WHERE S_HL.CHARGE_DATE       <= V_STD_DATE
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )
          ) T1
      WHERE PM.PERSON_ID            = T1.PERSON_ID
        AND ((W_CORP_ID             IS NULL AND 1 = 1)
          OR (W_CORP_ID             IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
          OR (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND PM.JOIN_DATE            <= V_STD_DATE
        AND ((W_EMPLOYE_TYPE        IS NULL AND (PM.RETIRE_DATE >= TRUNC(V_STD_DATE, 'MONTH') OR PM.RETIRE_DATE IS NULL))
          OR (W_EMPLOYE_TYPE        = '1' AND (PM.RETIRE_DATE >= TRUNC(V_STD_DATE, 'MONTH') OR PM.RETIRE_DATE IS NULL))
          OR (W_EMPLOYE_TYPE        = '2' AND (PM.RETIRE_DATE >= TRUNC(V_STD_DATE, 'MONTH') OR PM.RETIRE_DATE IS NULL))
          OR (W_EMPLOYE_TYPE        = '3' AND (PM.RETIRE_DATE BETWEEN TRUNC(V_STD_DATE, 'MONTH') AND V_STD_DATE)))
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
          OR (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
          OR (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
      ORDER BY T1.FLOOR_SORT_NUM
             , T1.POST_SORT_NUM
      ;
  END SELECT_PERSON;  
  
  
-------------------------------------------------------------------------------
-- 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
    V_STD_DATE          DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    BEGIN
      SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE,
             LAST_DAY(V_STD_DATE) AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
      ;    
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := V_STD_DATE;
        V_END_DATE   := V_STD_DATE;      
    END;
    OPEN P_CURSOR FOR
      SELECT HA.YEAR_YYYY YEAR_YYYY,
             HA.PERSON_ID PERSON_ID,
             HA.SUBMIT_DATE SUBMIT_DATE,
             HA.ADJUST_DATE_FR ADJUST_DATE_FR,
             HA.ADJUST_DATE_TO ADJUST_DATE_TO,
             NVL(HA.NOW_PAY_TOT_AMT, 0) NOW_PAY_TOT_AMT,
             NVL(HA.NOW_BONUS_TOT_AMT, 0) NOW_BONUS_TOT_AMT,
             NVL(HA.NOW_ADD_BONUS_AMT, 0) NOW_ADD_BONUS_AMT,
             NVL(HA.NOW_STOCK_BENE_AMT, 0) NOW_STOCK_BENE_AMT,
             NVL(HA.PRE_PAY_TOT_AMT, 0) PRE_PAY_TOT_AMT,
             NVL(HA.PRE_BONUS_TOT_AMT, 0) PRE_BONUS_TOT_AMT,
             NVL(HA.PRE_ADD_BONUS_AMT, 0) PRE_ADD_BONUS_AMT,
             NVL(HA.PRE_STOCK_BENE_AMT, 0) PRE_STOCK_BENE_AMT,
             NVL(HA.INCOME_OUTSIDE_AMT, 0) INCOME_OUTSIDE_AMT,
             (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) TOTAL_PAY,
             NVL(HA.NONTAX_OUTSIDE_AMT, 0) NONTAX_OUTSIDE_AMT,
             NVL(HA.NONTAX_OT_AMT, 0) NONTAX_OT_AMT,
             NVL(HA.NONTAX_RESEA_AMT, 0) NONTAX_RESEA_AMT,
             NVL(HA.NONTAX_ETC_AMT, 0) NONTAX_ETC_AMT,
             NVL(HA.NONTAX_BIRTH_AMT, 0) NONTAX_BIRTH_AMT,
             NVL(HA.NONTAX_FOREIGNER_AMT, 0) NONTAX_FOREIGNER_AMT, 
             (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) + 
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) + 
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) + 
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + 
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_OUTS_WORK_1, 0) + 
               NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + 
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + 
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + 
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0)) NONTAX_TOT_AMT,
             NVL(HA.INCOME_TOT_AMT, 0) INCOME_TOT_AMT,
             NVL(HA.INCOME_DED_AMT, 0) INCOME_DED_AMT,
             (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) INCOME_AMT,
             NVL(HA.PER_DED_AMT, 0) PER_DED_AMT,
             NVL(HA.SPOUSE_DED_AMT, 0) SPOUSE_DED_AMT,
             NVL(HA.SUPP_DED_COUNT, 0) SUPP_DED_COUNT,
             NVL(HA.SUPP_DED_AMT, 0) SUPP_DED_AMT,
             NVL(HA.OLD_DED_COUNT, 0) OLD_DED_COUNT,
             NVL(HA.OLD_DED_AMT, 0) OLD_DED_AMT,
             NVL(HA.OLD_DED_COUNT1, 0) OLD_DED_COUNT1,
             NVL(HA.OLD_DED_AMT1, 0) OLD_DED_AMT1,
             NVL(HA.DISABILITY_DED_COUNT, 0) DISABILITY_DED_COUNT,
             NVL(HA.DISABILITY_DED_AMT, 0) DISABILITY_DED_AMT,
             NVL(HA.WOMAN_DED_AMT, 0) WOMAN_DED_AMT,
             NVL(HA.CHILD_DED_COUNT, 0) CHILD_DED_COUNT,
             NVL(HA.CHILD_DED_AMT, 0) CHILD_DED_AMT,
             NVL(HA.PER_ADD_DED_AMT, 0) PER_ADD_DED_AMT,
             NVL(HA.MANY_CHILD_DED_COUNT, 0) MANY_CHILD_DED_COUNT,
             NVL(HA.MANY_CHILD_DED_AMT, 0) MANY_CHILD_DED_AMT,
             NVL(HA.ANNU_INSUR_AMT, 0) ANNU_INSUR_AMT,
             NVL(HA.NATI_ANNU_AMT, 0) NATI_ANNU_AMT,
             -- 보험료 금액이 음수일 경우에는 0을 출력(연말정산 제출매채 양식에 -값이 들어가지 않음);
             (CASE
               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                    NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
             END) ETC_INSURE_AMT,
             NVL(HA.MEDIC_AMT, 0) MEDIC_AMT,
             NVL(HA.EDUCATION_AMT, 0) EDUCATION_AMT,
             NVL(HA.HOUSE_INTER_AMT, 0) HOUSE_INTER_AMT,
             NVL(HA.HOUSE_FUND_AMT, 0) HOUSE_FUND_AMT,
             NVL(HA.DONAT_AMT, 0) DONAT_AMT,
             NVL(HA.MARRY_ETC_AMT, 0) MARRY_ETC_AMT,
             ((CASE
               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                    NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
             END) + NVL(HA.MEDIC_AMT, 0) + NVL(HA.EDUCATION_AMT, 0) +
             NVL(HA.HOUSE_INTER_AMT, 0) + 
             NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +
             NVL(HA.HOUSE_MONTHLY_AMT, 0) + 
             NVL(HA.DONAT_AMT, 0) + NVL(HA.MARRY_ETC_AMT, 0)) SP_DED_SUM,
             NVL(HA.STAND_DED_AMT, 0) STAND_DED_AMT,
             NVL(HA.SUBT_DED_AMT, 0) SUBT_DED_AMT,
             NVL(HA.PERS_ANNU_BANK_AMT, 0) PERS_ANNU_BANK_AMT,
             NVL(HA.ANNU_BANK_AMT, 0) ANNU_BANK_AMT,
             NVL(HA.INVES_AMT, 0) INVES_AMT,
             NVL(HA.FORE_INCOME_AMT, 0) FORE_INCOME_AMT,
             NVL(HA.CREDIT_AMT, 0) CREDIT_AMT,
             NVL(HA.RETR_ANNU_AMT, 0) RETR_ANNU_AMT,
             NVL(HA.EMPL_STOCK_AMT, 0) EMPL_STOCK_AMT,
             NVL(HA.TAX_STD_AMT, 0) TAX_STD_AMT,
             NVL(HA.COMP_TAX_AMT, 0) COMP_TAX_AMT,
             NVL(HA.TAX_REDU_IN_LAW_AMT, 0) TAX_REDU_IN_LAW_AMT,
             NVL(HA.TAX_REDU_SP_LAW_AMT, 0) TAX_REDU_SP_LAW_AMT,
             (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0)) AS TAX_REDU_SUM,
             NVL(HA.TAX_DED_INCOME_AMT, 0) TAX_DED_INCOME_AMT,
             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) TAX_DED_TAXGROUP_AMT,
             NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) TAX_DED_HOUSE_DEBT_AMT,
             NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) TAX_DED_LONG_STOCK_AMT,
             NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) TAX_DED_DONAT_POLI_AMT,
             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) TAX_DED_OUTSIDE_PAY_AMT,
             (NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) 
             + NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) + NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0)) AS TAX_DED_SUM,
             NVL(HA.FIX_IN_TAX_AMT, 0) FIX_TAX_AMT,
             TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) FIX_IN_TAX_AMT, -- 원단위 절사.
             TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) FIX_LOCAL_TAX_AMT,
             TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) FIX_SP_TAX_AMT,
             (TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) + TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) + TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM,
             TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) PRE_IN_TAX_AMT,
             TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) PRE_LOCAL_TAX_AMT,
             TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1) PRE_SP_TAX_AMT,
             (TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) + TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) + TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1)) PRE_TAX_SUM,
             TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) -
             TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) PRE1_IN_TAX_AMT,
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) -
             TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) PRE1_LOCAL_TAX_AMT,
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) -
             TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1) PRE1_SP_TAX_AMT,
             (TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) - TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) - TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1)) PRE1_TAX_SUM,
             TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) SUBT_IN_TAX_AMT,
             TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) SUBT_LOCAL_TAX_AMT,
             TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) SUBT_SP_TAX_AMT,
             (TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) + TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) + TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) SUBT_TAX_SUM,
             --NVL(HA.NONTAX_FOREIGNER_AMT, 0) NONTAX_FOREIGNER_AMT,
             NVL(HA.BIRTH_DED_COUNT, 0) BIRTH_DED_COUNT,
             NVL(HA.BIRTH_DED_AMT, 0) BIRTH_DED_AMT,
             NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) LONG_HOUSE_PROF_AMT,
             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) + NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) HOUSE_SAVE_AMT,
             NVL(HA.SMALL_CORPOR_DED_AMT, 0) SMALL_CORPOR_DED_AMT,
             NVL(HA.LONG_STOCK_SAVING_AMT, 0) LONG_STOCK_SAVING_AMT,
             NVL(HA.HOUSE_MONTHLY_AMT, 0) HOUSE_MONTHLY_AMT
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
        FROM HRA_YEAR_ADJUSTMENT HA,
             ( -- 종전 납부 세액
              SELECT HPW.YEAR_YYYY,
                    HPW.PERSON_ID,
                    SUM(HPW.IN_TAX_AMT) IN_TAX_AMT,
                    SUM(HPW.LOCAL_TAX_AMT) LOCAL_TAX_AMT,
                    SUM(HPW.SP_TAX_AMT) SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY, HPW.PERSON_ID) HPW1
       WHERE HA.YEAR_YYYY = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID = HPW1.PERSON_ID(+)
         AND HA.YEAR_YYYY = V_YEAR_YYYY
         AND HA.PERSON_ID = W_PERSON_ID
         AND HA.SOB_ID    = W_SOB_ID
         AND HA.ORG_ID    = W_ORG_ID
         AND HA.SUBMIT_DATE BETWEEN V_START_DATE AND V_END_DATE
       ;

  END SELECT_YEAR_ADJUSTMENT;
  
-------------------------------------------------------------------------------
-- 연말정산 내역 마감 / 마감 취소 데이터 조회 --  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_YEAR_ADJUSTMENT_CLOSED
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_CLOSED_FLAG       IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    V_STD_DATE                    DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    
  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE
         , V_STD_DATE AS END_DATE
      INTO V_START_DATE, V_END_DATE
      FROM DUAL; 
    ---RAISE_APPLICATION_ERROR(-20001, W_PERSON_ID || '/' || W_CLOSED_FLAG ||'/' || W_SOB_ID);
    
    OPEN P_CURSOR1 FOR
      SELECT 'N' AS SELECT_YN
          , HA.PERSON_ID AS  PERSON_ID
          , PM.NAME AS NAME
          , PM.PERSON_NUM
          , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
          , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME          
          , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
            TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') AS APPLY_TERM  -- 정산기간 --
          , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT  -- 차감 소득세 --
          , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT  -- 차감 주민세 --
          , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT  -- 차감 농특세 --
          , (TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- 차감 합계 --
          , (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) TAX_PAY_SUM
          , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) AS NONTAX_PAY_SUM
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- 원단위 절사.
          , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) AS FIX_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_SP_TAX_AMT
          , (TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM
          , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) AS PRE_IN_TAX_AMT
          , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) AS PRE_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_SP_TAX_AMT
          , (TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1)) AS PRE_TAX_SUM
          , CASE
              WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
              WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
              ELSE '중도퇴사'
            END AS EMPLOYEE_TYPE 
          , PM.RETIRE_DATE
          , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', 
            (SELECT PM1.NAME
               FROM HRM_PERSON_MASTER PM1
              WHERE PM1.PERSON_ID   = HA.TRANS_PERSON_ID), NULL) AS TRANS_BY
          , W_STD_YYYYMM AS YEAR_YYYYMM 
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID
                   , DM.DEPT_CODE
                   , DM.DEPT_NAME
                   , DM.DEPT_SORT_NUM
                   , HL.POST_ID
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , HL.JOB_CLASS_ID
                   , HL.OCPT_ID
                   , HL.ABIL_ID
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
               WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID           = DM.DEPT_ID
                 AND HL.FLOOR_ID          = HF.FLOOR_ID
                 AND HH.SOB_ID            = W_SOB_ID
                 AND HH.ORG_ID            = W_ORG_ID
                 AND ((W_DEPT_ID          IS NULL AND 1 = 1)
                 OR   (W_DEPT_ID          IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                 AND ((W_FLOOR_ID         IS NULL AND 1 = 1)
                 OR   (W_FLOOR_ID         IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                 AND ((W_JOB_CATEGORY_ID  IS NULL AND 1 = 1)
                 OR   (W_JOB_CATEGORY_ID  IS NOT NULL AND HL.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
                 AND ((W_PERSON_ID        IS NULL AND 1 = 1)
                 OR   (W_PERSON_ID        IS NOT NULL AND HL.PERSON_ID = W_PERSON_ID))
                 AND HL.HISTORY_LINE_ID   IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                 FROM HRM_HISTORY_LINE S_HL
                                                WHERE S_HL.CHARGE_DATE    <= V_STD_DATE
                                                  AND S_HL.PERSON_ID       = HL.PERSON_ID
                                                GROUP BY S_HL.PERSON_ID
                                            )
            ) T1
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.YEAR_YYYY        = V_YEAR_YYYY        
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG      = W_CLOSED_FLAG  -- 마감 구분 -- 
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
             , T1.FLOOR_SORT_NUM
      ;
  
  END SELECT_YEAR_ADJUSTMENT_CLOSED;
  

-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 조회.  
-------------------------------------------------------------------------------  
  PROCEDURE TAX_SUMMERY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    V_STD_DATE                    DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    
  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    BEGIN
      SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE,
             V_STD_DATE AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
      ;    
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := V_STD_DATE;
        V_END_DATE   := V_STD_DATE;      
    END;
    
    OPEN P_CURSOR FOR
      SELECT T1.DEPT_NAME AS DEPT_NAME
          , T1.FLOOR_NAME
          , HA.PERSON_ID AS  PERSON_ID
          , PM.NAME AS NAME
          , PM.PERSON_NUM
          , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
            TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') APPLY_TERM
          , (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) TAX_PAY_SUM
          , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) AS NONTAX_PAY_SUM
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- 원단위 절사.
          , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) AS FIX_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_SP_TAX_AMT
          , (TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM
          , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) AS PRE_IN_TAX_AMT
          , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) AS PRE_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_SP_TAX_AMT
          , (TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1)) AS PRE_TAX_SUM
          , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT
          , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT
          , (TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM
          , CASE
              WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
              WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
              ELSE '중도퇴사'
            END AS EMPLOYEE_TYPE 
          , PM.RETIRE_DATE
          , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
          , NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)) AS TRANS_PAY_YYYYMM
          , NVL(HA.TRANS_DATE, TO_DATE(NULL)) AS TRANS_DATE
          , NVL(PM1.NAME, TO_CHAR(NULL)) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , HRM_PERSON_MASTER   PM1
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID
                   , DM.DEPT_CODE
                   , DM.DEPT_NAME
                   , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                   , HL.POST_ID
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , HL.JOB_CLASS_ID
                   , HL.OCPT_ID
                   , HL.ABIL_ID
                FROM HRM_HISTORY_LINE   HL
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
               WHERE HL.DEPT_ID          = DM.DEPT_ID
                 AND HL.FLOOR_ID         = HF.FLOOR_ID
                 AND ((W_DEPT_ID         IS NULL AND 1 = 1)
                 OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                 AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
                 OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                 AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
                 OR   (W_JOB_CATEGORY_ID IS NOT NULL AND HL.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
                 AND ((W_PERSON_ID       IS NULL AND 1 = 1)
                 OR   (W_PERSON_ID       IS NOT NULL AND HL.PERSON_ID = W_PERSON_ID))
                 AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                FROM HRM_HISTORY_LINE S_HL
                                               WHERE S_HL.CHARGE_DATE    <= V_END_DATE
                                                 AND S_HL.PERSON_ID       = HL.PERSON_ID
                                            GROUP BY S_HL.PERSON_ID
                                            )
            ) T1
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.TRANS_PERSON_ID  = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY        = V_YEAR_YYYY
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
      ;
  END TAX_SUMMERY;
  
  
  -------------------------------------------------------------------------------
-- 연말정산 내역 급여전송 / 미전송 데이터 조회 --  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_YEAR_ADJUSTMENT_PAYMENT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_YEAR_YYYY         IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_TRANS_YN          IN  VARCHAR2
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    V_STD_DATE                    DATE := LAST_DAY(TO_DATE(W_YEAR_YYYY, 'YYYY-MM'));
    
  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    SELECT TRUNC(V_STD_DATE, 'MONTH') AS START_DATE
         , V_STD_DATE AS END_DATE
      INTO V_START_DATE, V_END_DATE
      FROM DUAL; 
    ---RAISE_APPLICATION_ERROR(-20001, W_PERSON_ID || '/' || W_CLOSED_FLAG ||'/' || W_SOB_ID);
    
    OPEN P_CURSOR1 FOR
      SELECT 'N' AS SELECT_YN
          , HA.PERSON_ID AS  PERSON_ID
          , PM.NAME AS NAME
          , PM.PERSON_NUM
          , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
          , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME          
          , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
            TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') AS APPLY_TERM  -- 정산기간 --
          , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT  -- 차감 소득세 --
          , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT  -- 차감 주민세 --
          , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT  -- 차감 농특세 --
          , (TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- 차감 합계 --
          , (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) TAX_PAY_SUM
          , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) AS NONTAX_PAY_SUM
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- 원단위 절사.
          , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) AS FIX_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_SP_TAX_AMT
          , (TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM
          , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) AS PRE_IN_TAX_AMT
          , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) AS PRE_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_SP_TAX_AMT
          , (TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1)) AS PRE_TAX_SUM
          , CASE
              WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
              WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
              ELSE '중도퇴사'
            END AS EMPLOYEE_TYPE 
          , PM.RETIRE_DATE
          , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
          , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', 
            (SELECT PM1.NAME
               FROM HRM_PERSON_MASTER PM1
              WHERE PM1.PERSON_ID   = HA.TRANS_PERSON_ID), NULL) AS TRANS_BY
          , W_YEAR_YYYY AS YEAR_YYYYMM 
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID
                   , DM.DEPT_CODE
                   , DM.DEPT_NAME
                   , DM.DEPT_SORT_NUM
                   , HL.POST_ID
                   , HL.PAY_GRADE_ID
                   , HL.FLOOR_ID
                   , HF.FLOOR_CODE
                   , HF.FLOOR_NAME
                   , HF.SORT_NUM AS FLOOR_SORT_NUM
                   , HL.JOB_CATEGORY_ID
                   , HL.JOB_CLASS_ID
                   , HL.OCPT_ID
                   , HL.ABIL_ID
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
               WHERE HH.HISTORY_HEADER_ID = HL.HISTORY_HEADER_ID
                 AND HL.DEPT_ID           = DM.DEPT_ID
                 AND HL.FLOOR_ID          = HF.FLOOR_ID
                 AND HH.SOB_ID            = W_SOB_ID
                 AND HH.ORG_ID            = W_ORG_ID
                 AND ((W_DEPT_ID          IS NULL AND 1 = 1)
                 OR   (W_DEPT_ID          IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                 AND ((W_FLOOR_ID         IS NULL AND 1 = 1)
                 OR   (W_FLOOR_ID         IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                 AND ((W_JOB_CATEGORY_ID  IS NULL AND 1 = 1)
                 OR   (W_JOB_CATEGORY_ID  IS NOT NULL AND HL.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
                 AND ((W_PERSON_ID        IS NULL AND 1 = 1)
                 OR   (W_PERSON_ID        IS NOT NULL AND HL.PERSON_ID = W_PERSON_ID))
                 AND HL.HISTORY_LINE_ID   IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                 FROM HRM_HISTORY_LINE S_HL
                                                WHERE S_HL.CHARGE_DATE    <= V_STD_DATE
                                                  AND S_HL.PERSON_ID       = HL.PERSON_ID
                                                GROUP BY S_HL.PERSON_ID
                                            )
            ) T1
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.YEAR_YYYY        = V_YEAR_YYYY        
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG      = 'Y'  -- 마감 구분 -- 
        AND HA.TRANS_YN         = W_TRANS_YN  -- 급여전송 구분 --
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
             , T1.FLOOR_SORT_NUM
      ;
  END SELECT_YEAR_ADJUSTMENT_PAYMENT;

-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 급여 전송 OR 전송취소.  
-- 급여전송시 정산내역은 급상여추가공제 및 급상여 계산 내역에 동시 반영
-- 급상여 재계산 안해도 반영되게 처리 위해
-------------------------------------------------------------------------------  
  PROCEDURE SET_TRANSFER_SALARY
            ( P_YEAR_YYYYMM       IN  HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_PERSON_ID         IN  HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_TRANS_YN          IN  HRA_YEAR_ADJUSTMENT.TRANS_YN%TYPE
            , P_EVENT_STATUS      IN  VARCHAR2
            , P_PAY_YYYYMM        IN  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN  HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN  HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_TRANS_PERSON_ID   IN  HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_USER_ID           IN  HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            ) 
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_YEAR_YYYY           VARCHAR2(4);  
    V_START_DATE          DATE;
    V_END_DATE            DATE;
          
    V_ADD_DEDUCTION_ID    NUMBER;
    V_MONTH_PAYMENT_ID    NUMBER;
    V_IN_TAX_ID           NUMBER := NULL;    -- 정산소득세ID.
    V_LOCAL_TAX_ID        NUMBER := NULL;    -- 정산주민세ID.
    V_SP_TAX_ID           NUMBER := NULL;    -- 정산 농특세ID.
    
    V_STATUS              VARCHAR2(4);    
  BEGIN
    O_STATUS := 'F';
    
    V_START_DATE := TRUNC(TO_DATE(P_YEAR_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY  := TO_CHAR(V_END_DATE, 'YYYY');
    
    
    BEGIN
      SELECT MAX(DECODE(HD.DEDUCTION_CODE, 'D15', HD.DEDUCTION_ID, NULL)) AS IN_TAX_ID
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D16', HD.DEDUCTION_ID, NULL)) AS LOCAL_TAX_ID
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D17', HD.DEDUCTION_ID, NULL)) AS SP_TAX_ID
        INTO V_IN_TAX_ID, V_LOCAL_TAX_ID, V_SP_TAX_ID
        FROM HRM_DEDUCTION_V HD
       WHERE HD.DEDUCTION_CODE      IN ('D15', 'D16', 'D17')
         AND HD.SOB_ID              = P_SOB_ID
         AND HD.ORG_ID              = P_ORG_ID
         AND HD.ENABLED_FLAG        = 'Y'
         AND HD.EFFECTIVE_DATE_FR   <= V_END_DATE
         AND (HD.EFFECTIVE_DATE_TO  >= V_START_DATE OR HD.EFFECTIVE_DATE_TO IS NULL)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_IN_TAX_ID := NULL;
      V_LOCAL_TAX_ID := NULL;
      V_SP_TAX_ID := NULL;
    END;
    IF V_IN_TAX_ID IS NULL OR V_LOCAL_TAX_ID IS NULL THEN
      O_MESSAGE := 'Deduction ID(TAX) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10114', NULL);
      RETURN;      
    END IF;
    
    IF P_TRANS_YN IN('N', 'Y') AND P_EVENT_STATUS IN('OK', 'CANCEL') THEN
      -- 급여전송 처리 -- 
      FOR C1 IN (SELECT HA.PERSON_ID AS PERSON_ID
                      , PM.NAME AS NAME
                      , PM.PERSON_NUM
                      , PM.CORP_ID
                      , PM.SOB_ID
                      , PM.ORG_ID 
                      , (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                         NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                         NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                         NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                         NVL(HA.INCOME_OUTSIDE_AMT, 0)) AS TAX_PAY_SUM
                      , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
                         NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) AS NONTAX_PAY_SUM
                      , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT
                      , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) AS FIX_LOCAL_TAX_AMT
                      , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_SP_TAX_AMT
                      , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
                         TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
                         TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_TAX_SUM
                      , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) AS PRE_IN_TAX_AMT
                      , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) AS PRE_LOCAL_TAX_AMT
                      , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_SP_TAX_AMT
                      , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
                         TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
                         TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_TAX_SUM
                      -- 차감 급액 --
                      , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT
                      , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT
                      , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT
                      , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
                         TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
                         TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_TAX_SUM
                      , HA.SUBMIT_DATE
                      , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
                      , P_YEAR_YYYYMM AS YEAR_YYYYMM
                      , P_EVENT_STATUS AS EVENT_STATUS
                      , P_USER_ID AS USER_ID
                      , P_PAY_YYYYMM AS PAY_YYYYMM
                      , P_WAGE_TYPE AS WAGE_TYPE
                  FROM HRA_YEAR_ADJUSTMENT HA
                    , HRM_PERSON_MASTER    PM
                WHERE HA.PERSON_ID        = PM.PERSON_ID
                  AND HA.YEAR_YYYY        = V_YEAR_YYYY
                  AND HA.PERSON_ID        = P_PERSON_ID
                  AND HA.SOB_ID           = P_SOB_ID
                  AND HA.ORG_ID           = P_ORG_ID
                  AND HA.CLOSED_FLAG      = 'Y'  -- 마감 자료에 대해 처리 -- 
                  AND PM.JOIN_DATE        <= V_END_DATE
                  AND (PM.RETIRE_DATE     >= V_START_DATE OR PM.RETIRE_DATE IS NULL)
                  AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
                  AND HA.TRANS_YN         = P_TRANS_YN  -- 이미 전송된 자료는 전송 제외 --
               )
      LOOP
        V_STATUS := HRM_CLOSING_G.CLOSING_CHECK_W( W_CORP_ID => C1.CORP_ID
                                                  , W_CLOSING_YYYYMM => C1.PAY_YYYYMM
                                                  , W_CLOSING_TYPE => C1.WAGE_TYPE
                                                  , W_SOB_ID => C1.SOB_ID
                                                  , W_ORG_ID => C1.ORG_ID);
        IF V_STATUS = 'F' THEN
          O_MESSAGE :=  '(' || ERRNUMS.Data_Not_opened_Code || ')' || ERRNUMS.Data_Not_Opened_Desc;
          RETURN;
        ELSIF O_STATUS = 'Y' THEN
          O_MESSAGE := '(' || ERRNUMS.Data_Closed_Code || ')' || ERRNUMS.Data_closed_Desc;
          RETURN;
        END IF;
        
        -- 0. 급상여 데이터 존재 여부  -- 
        BEGIN
          SELECT MP.MONTH_PAYMENT_ID 
            INTO V_MONTH_PAYMENT_ID
            FROM HRP_MONTH_PAYMENT MP
           WHERE MP.PERSON_ID       = C1.PERSON_ID
             AND MP.PAY_YYYYMM      = C1.PAY_YYYYMM
             AND MP.WAGE_TYPE       = C1.WAGE_TYPE
             AND MP.SOB_ID          = C1.SOB_ID
             AND MP.ORG_ID          = C1.ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_MONTH_PAYMENT_ID := NULL;
        END;
          
        /*
        -- 1.전호수 추가(2013-01-10) : 기존자료 삭제(인사팀 요청-계속 UPDATE 방지) --
        -- 2.전호수 수정(2013-01-16) : 동일 급여년월에 여러 연말정산 처리 자료 전송 가능 --
        --                              전송급여년월의 값을 삭제후  
        DELETE FROM HRP_PAYMENT_ADD_DEDUCTION PAD
        WHERE PAD.PERSON_ID         = C1.PERSON_ID
          AND PAD.PAY_YYYYMM        = P_PAY_YYYYMM
          AND PAD.WAGE_TYPE         = P_WAGE_TYPE
          AND PAD.DEDUCTION_ID      IN(V_IN_TAX_ID, V_LOCAL_TAX_ID, V_SP_TAX_ID)
          AND PAD.SOB_ID            = P_SOB_ID
          AND PAD.ORG_ID            = P_ORG_ID
          AND PAD.CREATED_FLAG      = 'I'  -- 자동 전송 자료만 삭제 --
        ;*/
        
        IF C1.TRANS_YN = 'N' AND C1.EVENT_STATUS = 'OK' THEN
          -- 미전송 데이터 : 전송 처리 --       
          -- 급여전송 INTERFACE에 데이터 삽입/수정 -- 
          FOR R1 IN 1 .. 3
          LOOP
            IF (R1 = 1 AND (V_IN_TAX_ID IS NOT NULL OR 1 = 2)) OR
               (R1 = 2 AND (V_LOCAL_TAX_ID IS NOT NULL OR 1 = 2)) OR 
               (R1 = 3 AND (V_SP_TAX_ID IS NOT NULL OR 1 = 2)) THEN
              INSERT INTO HRA_YEAR_ADJUSTMENT_INTERFACE 
              ( YEAR_YYYYMM 
              , PERSON_ID 
              , SOB_ID 
              , ORG_ID 
              , DEDUCTION_ID 
              , AMOUNT 
              , PAY_YYYYMM 
              , WAGE_TYPE 
              , TRANS_DATE 
              , TRANS_PERSON_ID 
              , CREATION_DATE 
              , CREATED_BY 
              , LAST_UPDATE_DATE 
              , LAST_UPDATED_BY 
              ) VALUES
              ( C1.YEAR_YYYYMM 
              , C1.PERSON_ID 
              , C1.SOB_ID 
              , C1.ORG_ID 
              , CASE
                  WHEN R1 = 1 THEN V_IN_TAX_ID 
                  WHEN R1 = 2 THEN V_LOCAL_TAX_ID
                  WHEN R1 = 3 THEN V_SP_TAX_ID
                END  -- DEDUCTION_ID 
              , CASE
                  WHEN R1 = 1 THEN NVL(C1.SUBT_IN_TAX_AMT, 0) 
                  WHEN R1 = 2 THEN NVL(C1.SUBT_LOCAL_TAX_AMT, 0)
                  WHEN R1 = 3 THEN NVL(C1.SUBT_SP_TAX_AMT, 0)
                END  -- AMOUNT 
              , C1.PAY_YYYYMM 
              , C1.WAGE_TYPE 
              , V_SYSDATE -- TRANS_DATE 
              , P_TRANS_PERSON_ID -- TRANS_PERSON_ID 
              , V_SYSDATE -- CREATION_DATE 
              , C1.USER_ID -- CREATED_BY 
              , V_SYSDATE -- LAST_UPDATE_DATE 
              , C1.USER_ID -- LAST_UPDATED_BY 
              );
            END IF;            
          END LOOP R1;
          
          FOR R1 IN ( SELECT YAI.YEAR_YYYYMM 
                           , YAI.PERSON_ID 
                           , YAI.SOB_ID 
                           , YAI.ORG_ID 
                           , YAI.DEDUCTION_ID 
                           , YAI.AMOUNT 
                           , YAI.PAY_YYYYMM 
                           , YAI.WAGE_TYPE 
                           , YAI.TRANS_DATE 
                           , YAI.TRANS_PERSON_ID 
                        FROM HRA_YEAR_ADJUSTMENT_INTERFACE YAI
                       WHERE YAI.YEAR_YYYYMM      = C1.YEAR_YYYYMM
                         AND YAI.PERSON_ID        = C1.PERSON_ID
                         AND YAI.SOB_ID           = C1.SOB_ID
                         AND YAI.ORG_ID           = C1.ORG_ID
                         AND YAI.PAY_YYYYMM       = C1.PAY_YYYYMM
                         AND YAI.WAGE_TYPE        = C1.WAGE_TYPE
                         AND YAI.ADD_DEDUCTION_ID IS NULL
                    )
          LOOP
            IF NVL(R1.AMOUNT, 0) != 0 THEN
              -- 1. 급상여 추가공제 관리 INSERT.
              BEGIN
                HRP_PAYMENT_ADD_DEDUCTION_G.ADD_DEDUCTION_INSERT
                  ( P_ADD_DEDUCTION_ID => V_ADD_DEDUCTION_ID
                  , P_PERSON_ID        => C1.PERSON_ID
                  , P_CORP_ID          => C1.CORP_ID
                  , P_PAY_YYYYMM       => R1.PAY_YYYYMM
                  , P_WAGE_TYPE        => R1.WAGE_TYPE
                  , P_DEDUCTION_ID     => R1.DEDUCTION_ID
                  , P_DEDUCTION_AMOUNT => NVL(R1.AMOUNT, 0)
                  , P_CREATED_FLAG     => 'I'
                  , P_DESCRIPTION      => '연말정산 정산금액'
                  , P_SOB_ID           => C1.SOB_ID
                  , P_ORG_ID           => C1.ORG_ID
                  , P_USER_ID          => C1.USER_ID
                  );
              EXCEPTION WHEN OTHERS THEN
                O_MESSAGE := 'Salary add deduction Insert error : ' || SUBSTR(SQLERRM, 1, 150);
                RETURN;  
              END;                              
              -- 2. 연말정산 급여전송 INTERFACE UPDATE --
              BEGIN
                UPDATE HRA_YEAR_ADJUSTMENT_INTERFACE YAI
                   SET YAI.ADD_DEDUCTION_ID = V_ADD_DEDUCTION_ID
                 WHERE YAI.YEAR_YYYYMM      = R1.YEAR_YYYYMM
                   AND YAI.PERSON_ID        = C1.PERSON_ID
                   AND YAI.SOB_ID           = C1.SOB_ID
                   AND YAI.ORG_ID           = C1.ORG_ID
                   AND YAI.PAY_YYYYMM       = C1.PAY_YYYYMM
                   AND YAI.WAGE_TYPE        = C1.WAGE_TYPE
                   AND YAI.DEDUCTION_ID     = R1.DEDUCTION_ID
                ;
              EXCEPTION WHEN OTHERS THEN
                O_MESSAGE := 'Year Adjust Interface error : ' || SUBSTR(SQLERRM, 1, 150);
                RETURN;  
              END;
            END IF; 
            
            -- 3-1. 급상여 계산내역 있을경우 공제 반영 및 총공제액, 실지급액 반영 --
            IF V_MONTH_PAYMENT_ID IS NOT NULL THEN
              BEGIN
                HRP_MONTH_PAYMENT_G_SET.DEDUCTION_INSERT
                  ( P_PERSON_ID => C1.PERSON_ID
                  , P_PAY_YYYYMM => R1.PAY_YYYYMM
                  , P_WAGE_TYPE => R1.WAGE_TYPE
                  , P_CORP_ID => C1.CORP_ID
                  , P_DEDUCTION_ID => R1.DEDUCTION_ID
                  , P_DEDUCTION_AMOUNT => NVL(R1.AMOUNT, 0)
                  , P_MONTH_PAYMENT_ID => V_MONTH_PAYMENT_ID
                  , P_SOB_ID => C1.SOB_ID
                  , P_ORG_ID => C1.ORG_ID
                  , P_USER_ID => P_USER_ID
                  );
              EXCEPTION WHEN OTHERS THEN
                O_MESSAGE := 'Salary add deduction Insert error : ' || SUBSTR(SQLERRM, 1, 150);
                RETURN;  
              END; 
            END IF;              
          END LOOP R1;

          -- 3-1. 급상여 계산내역 있을경우 공제 반영 및 총공제액, 실지급액 반영 --
          IF V_MONTH_PAYMENT_ID IS NOT NULL THEN
            BEGIN
              UPDATE HRP_MONTH_PAYMENT MP
                SET (MP.DED_PAY_AMOUNT, MP.TOT_DED_AMOUNT)
                  = ( SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DED_PAY_AMOUNT
                           , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
                        FROM HRP_MONTH_DEDUCTION MD
                      WHERE MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
                      GROUP BY MD.MONTH_PAYMENT_ID
                    )
              WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID 
              ;
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Salary deduction sum error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;
            -- 실지급액 UPDATE : 음수 허용 --
            BEGIN
              UPDATE HRP_MONTH_PAYMENT MP
                SET MP.REAL_AMOUNT     = NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(MP.TOT_DED_AMOUNT, 0)
              WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID 
              ;
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Salary real amount error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;	
          END IF;
          
          -- 연말정산 내역 TRANSFER_YN UPDATE --
          BEGIN
            UPDATE HRA_YEAR_ADJUSTMENT YA
               SET YA.TRANS_YN          = 'Y'
                 , YA.TRANS_PAY_YYYYMM  = P_PAY_YYYYMM
                 , YA.TRANS_WAGE_TYPE   = P_WAGE_TYPE
                 , YA.TRANS_DATE        = V_SYSDATE
                 , YA.TRANS_PERSON_ID   = P_TRANS_PERSON_ID
             WHERE YA.YEAR_YYYY         = V_YEAR_YYYY
               AND YA.PERSON_ID         = C1.PERSON_ID
               AND YA.SOB_ID            = C1.SOB_ID
               AND YA.ORG_ID            = C1.ORG_ID
               AND YA.SUBMIT_DATE       = C1.SUBMIT_DATE
            ;
          EXCEPTION WHEN OTHERS THEN
            O_MESSAGE := 'Year Adjust trans flag error : ' || SUBSTR(SQLERRM, 1, 150);
            RETURN;  
          END;
        ELSIF C1.TRANS_YN = 'Y' AND C1.EVENT_STATUS = 'CANCEL' THEN
        -- 전송 데이터 : 미전송 처리 --       
          FOR R1 IN ( SELECT YAI.YEAR_YYYYMM 
                           , YAI.PERSON_ID 
                           , YAI.SOB_ID 
                           , YAI.ORG_ID 
                           , YAI.DEDUCTION_ID 
                           , YAI.AMOUNT 
                           , YAI.PAY_YYYYMM 
                           , YAI.WAGE_TYPE 
                           , YAI.TRANS_DATE 
                           , YAI.TRANS_PERSON_ID 
                           , YAI.ADD_DEDUCTION_ID 
                        FROM HRA_YEAR_ADJUSTMENT_INTERFACE YAI
                       WHERE YAI.YEAR_YYYYMM      = C1.YEAR_YYYYMM
                         AND YAI.PERSON_ID        = C1.PERSON_ID
                         AND YAI.SOB_ID           = C1.SOB_ID
                         AND YAI.ORG_ID           = C1.ORG_ID
                         AND YAI.PAY_YYYYMM       = C1.PAY_YYYYMM
                         AND YAI.WAGE_TYPE        = C1.WAGE_TYPE
                         AND YAI.ADD_DEDUCTION_ID IS NOT NULL
                    )
          LOOP
            -- 급상여 공제금액 적용 --       
            IF V_MONTH_PAYMENT_ID IS NOT NULL THEN
              BEGIN
                UPDATE HRP_MONTH_DEDUCTION MD 
                   SET MD.DEDUCTION_AMOUNT    = NVL(MD.DEDUCTION_AMOUNT, 0) - NVL(R1.AMOUNT, 0)
                 WHERE MD.PERSON_ID           = C1.PERSON_ID
                   AND MD.PAY_YYYYMM          = R1.PAY_YYYYMM
                   AND MD.WAGE_TYPE           = R1.WAGE_TYPE
                   AND MD.SOB_ID              = C1.SOB_ID
                   AND MD.ORG_ID              = C1.ORG_ID  
                   AND MD.DEDUCTION_ID        = R1.DEDUCTION_ID
                ;
              EXCEPTION WHEN OTHERS THEN
                O_MESSAGE := 'Salary deduction delete error : ' || SUBSTR(SQLERRM, 1, 150);
                RETURN;  
              END;              
            END IF;
            
            -- 1. 급상여 추가공제 관리 INSERT.
            BEGIN
              HRP_PAYMENT_ADD_DEDUCTION_G.ADD_DEDUCTION_DELETE
                ( W_ADD_DEDUCTION_ID        => R1.ADD_DEDUCTION_ID
                );
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Salary add deduction delete error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;
                            
            -- 3. 연말정산 급여전송 INTERFACE UPDATE --
            BEGIN
              UPDATE HRA_YEAR_ADJUSTMENT_INTERFACE YAI
                 SET YAI.ADD_DEDUCTION_ID = NULL
               WHERE YAI.YEAR_YYYYMM      = R1.YEAR_YYYYMM
                 AND YAI.PERSON_ID        = C1.PERSON_ID
                 AND YAI.SOB_ID           = C1.SOB_ID
                 AND YAI.ORG_ID           = C1.ORG_ID
                 AND YAI.PAY_YYYYMM       = C1.PAY_YYYYMM
                 AND YAI.WAGE_TYPE        = C1.WAGE_TYPE
                 AND YAI.DEDUCTION_ID     = R1.DEDUCTION_ID
              ;
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Year Adjust Interface error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;
          END LOOP R1;
          
          IF V_MONTH_PAYMENT_ID IS NOT NULL THEN
            -- 공제 항목 합계 UPDATE --
            BEGIN
              UPDATE HRP_MONTH_PAYMENT MP
                SET (MP.DED_PAY_AMOUNT, MP.TOT_DED_AMOUNT)
                  = ( SELECT NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS DED_PAY_AMOUNT
                           , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
                        FROM HRP_MONTH_DEDUCTION MD
                      WHERE MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
                      GROUP BY MD.MONTH_PAYMENT_ID
                    )
              WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID 
              ;
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Salary deduction sum error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;
            -- 실지급액 UPDATE : 음수 허용 --
            BEGIN
              UPDATE HRP_MONTH_PAYMENT MP
                SET MP.REAL_AMOUNT     = NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(MP.TOT_DED_AMOUNT, 0)
              WHERE MP.MONTH_PAYMENT_ID   = V_MONTH_PAYMENT_ID 
              ;
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Salary real amount error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;
          END IF;
          
          -- 연말정산 내역 TRANSFER_YN UPDATE --
          BEGIN
            UPDATE HRA_YEAR_ADJUSTMENT YA
               SET YA.TRANS_YN          = 'N'
                 , YA.TRANS_PAY_YYYYMM  = P_PAY_YYYYMM
                 , YA.TRANS_WAGE_TYPE   = P_WAGE_TYPE
                 , YA.TRANS_DATE        = V_SYSDATE
                 , YA.TRANS_PERSON_ID   = P_TRANS_PERSON_ID
             WHERE YA.YEAR_YYYY         = V_YEAR_YYYY
               AND YA.PERSON_ID         = C1.PERSON_ID
               AND YA.SOB_ID            = C1.SOB_ID
               AND YA.ORG_ID            = C1.ORG_ID
               AND YA.SUBMIT_DATE       = C1.SUBMIT_DATE
            ;
          EXCEPTION WHEN OTHERS THEN
            O_MESSAGE := 'Year Adjust trans flag error : ' || SUBSTR(SQLERRM, 1, 150);
            RETURN;  
          END;
        ELSE
          O_MESSAGE := '2.Status is error : Transfer flag - ' || P_TRANS_YN || ', Event Status - ' || P_EVENT_STATUS;
      RETURN;
        END IF;
      END LOOP C1;    
    ELSE
      O_MESSAGE := '1.Status is error : Transfer flag - ' || P_TRANS_YN || ', Event Status - ' || P_EVENT_STATUS;
      RETURN;
    END IF;        
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);   
  END SET_TRANSFER_SALARY;


-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 급여 전송.  
-------------------------------------------------------------------------------  
  PROCEDURE TRANSFER_PAYMENT
            ( P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_YEAR_YYYY         IN HRA_YEAR_ADJUSTMENT.YEAR_YYYY%TYPE
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_DEPT_ID           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_TRANS_PERSON_ID   IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_ADD_DEDUCTION_ID            NUMBER;
    V_IN_TAX_ID                   NUMBER := NULL;    -- 정산소득세ID.
    V_LOCAL_TAX_ID                NUMBER := NULL;    -- 정산주민세ID.
    V_SP_TAX_ID                   NUMBER := NULL;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT MAX(DECODE(HD.DEDUCTION_CODE, 'D15', HD.DEDUCTION_ID, NULL)) AS IN_TAX_ID
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D16', HD.DEDUCTION_ID, NULL)) AS LOCAL_TAX_ID
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D17', HD.DEDUCTION_ID, NULL)) AS SP_TAX_ID
        INTO V_IN_TAX_ID, V_LOCAL_TAX_ID, V_SP_TAX_ID
        FROM HRM_DEDUCTION_V HD
       WHERE HD.DEDUCTION_CODE    IN ('D15', 'D16', 'D17')
         AND HD.SOB_ID            = P_SOB_ID
         AND HD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_IN_TAX_ID := NULL;
      V_LOCAL_TAX_ID := NULL;
      V_SP_TAX_ID := NULL;
    END;
    IF V_IN_TAX_ID IS NULL OR V_LOCAL_TAX_ID IS NULL THEN
      O_MESSAGE := 'Deduction ID(TAX) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10114', NULL);
      RETURN;      
    END IF;
    
    FOR C1 IN ( SELECT HA.PERSON_ID PERSON_ID
                    , PM.NAME NAME
                    , PM.PERSON_NUM
                    , PM.CORP_ID
                    , (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                       NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                       NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                       NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                       NVL(HA.INCOME_OUTSIDE_AMT, 0)) TAX_PAY_SUM
                    , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
                       NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) NONTAX_PAY_SUM
                    , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) FIX_IN_TAX_AMT
                    , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) FIX_LOCAL_TAX_AMT
                    , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) FIX_SP_TAX_AMT
                    , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
                       TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
                       TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) FIX_TAX_SUM
                    , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) PRE_IN_TAX_AMT
                    , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) PRE_LOCAL_TAX_AMT
                    , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) PRE_SP_TAX_AMT
                    , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
                       TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
                       TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) PRE_TAX_SUM
                    , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) SUBT_IN_TAX_AMT
                    , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) SUBT_LOCAL_TAX_AMT
                    , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) SUBT_SP_TAX_AMT
                    , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
                       TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
                       TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) SUBT_TAX_SUM
                    , NVL(HA.TRANS_YN, 'N') TRANS_YN
                FROM HRA_YEAR_ADJUSTMENT HA
                  , HRM_PERSON_MASTER    PM
                  , (-- 시점 인사내역.
                    SELECT HL.PERSON_ID
                         , HL.DEPT_ID
                         , DM.DEPT_CODE
                         , DM.DEPT_NAME
                         , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
                         , HL.POST_ID
                         , HL.PAY_GRADE_ID
                         , HL.FLOOR_ID
                         , HF.FLOOR_CODE
                         , HF.FLOOR_NAME
                         , HF.SORT_NUM AS FLOOR_SORT_NUM
                         , HL.JOB_CATEGORY_ID
                         , HL.JOB_CLASS_ID
                         , HL.OCPT_ID
                         , HL.ABIL_ID
                      FROM HRM_HISTORY_LINE   HL
                         , HRM_DEPT_MASTER    DM
                         , HRM_FLOOR_V        HF
                     WHERE HL.DEPT_ID          = DM.DEPT_ID
                       AND HL.FLOOR_ID         = HF.FLOOR_ID
                       AND ((P_DEPT_ID         IS NULL AND 1 = 1)
                       OR   (P_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = P_DEPT_ID))
                       AND ((P_PERSON_ID       IS NULL AND 1 = 1)
                       OR   (P_PERSON_ID       IS NOT NULL AND HL.PERSON_ID = P_PERSON_ID))
                       AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE S_HL
                                                     WHERE S_HL.CHARGE_DATE    <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                                                       AND S_HL.PERSON_ID       = HL.PERSON_ID
                                                  GROUP BY S_HL.PERSON_ID
                                                  )
                  ) T1
              WHERE HA.PERSON_ID        = PM.PERSON_ID
                AND PM.PERSON_ID        = T1.PERSON_ID
                AND HA.YEAR_YYYY        = P_YEAR_YYYY
                AND HA.CORP_ID          = P_CORP_ID
                AND HA.PERSON_ID        = NVL(P_PERSON_ID, HA.PERSON_ID)
                AND PM.DEPT_ID          = NVL(P_DEPT_ID, PM.DEPT_ID)
                AND HA.SOB_ID           = P_SOB_ID
                AND HA.ORG_ID           = P_ORG_ID
                AND PM.JOIN_DATE        <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                AND (PM.RETIRE_DATE     >= TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
                AND HA.SUBMIT_DATE      BETWEEN P_START_DATE AND P_END_DATE
                AND (HA.TRANS_YN IS NULL OR HA.TRANS_YN = 'N')  -- 이미 전송된 자료는 전송 제외 --
             )
    LOOP
      IF NVL(C1.SUBT_IN_TAX_AMT, 0) <> 0 THEN
      -- 정산 소득세 DELETE --
        -- 정산 소득세 INSERT --
        HRP_PAYMENT_ADD_DEDUCTION_G.ADD_DEDUCTION_INSERT
            ( P_ADD_DEDUCTION_ID => V_ADD_DEDUCTION_ID
            , P_PERSON_ID        => C1.PERSON_ID
            , P_CORP_ID          => C1.CORP_ID
            , P_PAY_YYYYMM       => P_PAY_YYYYMM
            , P_WAGE_TYPE        => P_WAGE_TYPE
            , P_DEDUCTION_ID     => V_IN_TAX_ID
            , P_DEDUCTION_AMOUNT => NVL(C1.SUBT_IN_TAX_AMT, 0)
            , P_CREATED_FLAG     => 'I'
            , P_DESCRIPTION      => NULL
            , P_SOB_ID           => P_SOB_ID
            , P_ORG_ID           => P_ORG_ID
            , P_USER_ID          => P_USER_ID
            );
      END IF;
      
      IF NVL(C1.SUBT_LOCAL_TAX_AMT, 0) <> 0 THEN
      -- 정산 주민세 DELETE --
        -- 정산 주민세 INSERT --
        HRP_PAYMENT_ADD_DEDUCTION_G.ADD_DEDUCTION_INSERT
            ( P_ADD_DEDUCTION_ID => V_ADD_DEDUCTION_ID
            , P_PERSON_ID        => C1.PERSON_ID
            , P_CORP_ID          => C1.CORP_ID
            , P_PAY_YYYYMM       => P_PAY_YYYYMM
            , P_WAGE_TYPE        => P_WAGE_TYPE
            , P_DEDUCTION_ID     => V_LOCAL_TAX_ID
            , P_DEDUCTION_AMOUNT => NVL(C1.SUBT_LOCAL_TAX_AMT, 0)
            , P_CREATED_FLAG     => 'I'
            , P_DESCRIPTION      => NULL
            , P_SOB_ID           => P_SOB_ID
            , P_ORG_ID           => P_ORG_ID
            , P_USER_ID          => P_USER_ID
            );
      END IF;
      
      IF NVL(C1.SUBT_SP_TAX_AMT, 0) <> 0 THEN
      -- 정산 농특세 DELETE --
        -- 정산 주민세 INSERT --
        HRP_PAYMENT_ADD_DEDUCTION_G.ADD_DEDUCTION_INSERT
            ( P_ADD_DEDUCTION_ID => V_ADD_DEDUCTION_ID
            , P_PERSON_ID        => C1.PERSON_ID
            , P_CORP_ID          => C1.CORP_ID
            , P_PAY_YYYYMM       => P_PAY_YYYYMM
            , P_WAGE_TYPE        => P_WAGE_TYPE
            , P_DEDUCTION_ID     => V_SP_TAX_ID
            , P_DEDUCTION_AMOUNT => NVL(C1.SUBT_SP_TAX_AMT, 0)
            , P_CREATED_FLAG     => 'I'
            , P_DESCRIPTION      => NULL
            , P_SOB_ID           => P_SOB_ID
            , P_ORG_ID           => P_ORG_ID
            , P_USER_ID          => P_USER_ID
            );
      END IF;
      
      -- TRANSFER FLAG UPDATE --
      BEGIN
        UPDATE HRA_YEAR_ADJUSTMENT YA
          SET YA.TRANS_YN         = 'Y'
            , YA.TRANS_PAY_YYYYMM = P_PAY_YYYYMM
            , YA.TRANS_WAGE_TYPE  = P_WAGE_TYPE
            , YA.TRANS_DATE       = V_SYSDATE
            , YA.TRANS_PERSON_ID  = P_TRANS_PERSON_ID
        WHERE YA.YEAR_YYYY        = P_YEAR_YYYY
          AND YA.PERSON_ID        = C1.PERSON_ID
          AND YA.SOB_ID           = P_SOB_ID
          AND YA.ORG_ID           = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);              
  END TRANSFER_PAYMENT;


-------------------------------------------------------------------------------
-- 연말정산 차감 집계  기간별 내역 조회.  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_TAX_SUMMERY
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_SUBMIT_DATE_FR    IN  DATE
            , W_SUBMIT_DATE_TO    IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
  BEGIN
    V_YEAR_YYYY := TO_CHAR(W_SUBMIT_DATE_FR, 'YYYY');
        
    OPEN P_CURSOR1 FOR
      SELECT NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
           , NVL(HA.PERSON_ID, NULL)  AS PERSON_ID
           , NVL(PM.NAME, NULL)  AS NAME
           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
           , CASE
               WHEN GROUPING(T1.DEPT_NAME) = 1 THEN PT_TOTAL_SUM
               ELSE TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
                    TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') 
             END AS APPLY_TERM
           , SUM(NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                 NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                 NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                 NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                 NVL(HA.INCOME_OUTSIDE_AMT, 0)) AS TAX_PAY_SUM
           , SUM(NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
                 NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) AS NONTAX_PAY_SUM
           , SUM(TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1)) AS FIX_IN_TAX_AMT  -- 원단위 절사 --
           , SUM(TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1)) AS FIX_LOCAL_TAX_AMT
           , SUM(TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_SP_TAX_AMT
           , SUM(TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
                 TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
                 TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM
           , SUM(TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1)) AS PRE_IN_TAX_AMT
           , SUM(TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1)) AS PRE_LOCAL_TAX_AMT
           , SUM(TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1)) AS PRE_SP_TAX_AMT
           , SUM(TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
                 TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) +
                 TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1)) AS PRE_TAX_SUM
           , SUM(TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1)) AS SUBT_IN_TAX_AMT
           , SUM(TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1)) AS SUBT_LOCAL_TAX_AMT
           , SUM(TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_SP_TAX_AMT
           , SUM(TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
                 TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
                 TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM
           , CASE
               WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
               WHEN TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
               ELSE '중도퇴사'
             END AS EMPLOYEE_TYPE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE 
           , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
           , NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)) AS TRANS_PAY_YYYYMM
           , NVL(HA.TRANS_DATE, TO_DATE(NULL)) AS TRANS_DATE
           , NVL(PM1.NAME, TO_CHAR(NULL)) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT  HA
           , HRM_PERSON_MASTER    PM
           , HRM_PERSON_MASTER    PM1
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                   , HL.DEPT_ID
                   , DM.DEPT_CODE
                   , DM.DEPT_NAME
                   , DM.DEPT_SORT_NUM
                   , HL.POST_ID
                   , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                   , HL.JOB_CATEGORY_ID
                   , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                   , HL.FLOOR_ID    
                   , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
                FROM HRM_HISTORY_LINE HL  
                   , HRM_DEPT_MASTER  DM
               WHERE HL.DEPT_ID          = DM.DEPT_ID              
                 AND HL.HISTORY_LINE_ID  IN 
                       (SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                         WHERE S_HL.PERSON_ID       = HL.PERSON_ID
                           AND S_HL.CHARGE_DATE    <= W_SUBMIT_DATE_TO
                         GROUP BY S_HL.PERSON_ID
                       )
              ) T1
            , (-- 시점 인사내역.
                SELECT PH.PERSON_ID
                     , PH.FLOOR_ID
                     , PH.SOB_ID
                     , PH.ORG_ID
                     , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
                  FROM HRD_PERSON_HISTORY        PH
                WHERE PH.EFFECTIVE_DATE_FR  <=  W_SUBMIT_DATE_TO
                  AND PH.EFFECTIVE_DATE_TO  >=  W_SUBMIT_DATE_TO
                  AND ((W_FLOOR_ID          IS NULL AND 1 = 1)
                  OR   (W_FLOOR_ID          IS NOT NULL AND PH.FLOOR_ID = W_FLOOR_ID))
              ) T2
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND PM.PERSON_ID        = T2.PERSON_ID(+)
        AND HA.TRANS_PERSON_ID  = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY        = V_YEAR_YYYY
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN W_SUBMIT_DATE_FR AND W_SUBMIT_DATE_TO
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID)) 
        AND ((W_DEPT_ID         IS NULL AND 1 = 1)
        OR   (W_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID        IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
      GROUP BY ROLLUP
            ((T1.DEPT_CODE
           , T1.DEPT_NAME 
           , T1.FLOOR_NAME 
           , HA.PERSON_ID 
           , PM.NAME 
           , PM.PERSON_NUM 
           , HA.ADJUST_DATE_FR 
           , HA.ADJUST_DATE_TO 
           , PM.RETIRE_DATE
           , HA.TRANS_YN 
           , HA.TRANS_PAY_YYYYMM 
           , HA.TRANS_DATE 
           , PM1.NAME 
           ))
      ORDER BY T1.DEPT_CODE, HA.ADJUST_DATE_TO, PM.PERSON_NUM
      ;
  END SELECT_TAX_SUMMERY;


  PROCEDURE SELECT_YEAR_ADJUSTMENT2
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_EMPLOYE_YN        IN HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
            , W_POST_ID           IN HRM_PERSON_MASTER.POST_ID%TYPE
            , W_DEPT_ID           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_FLOOR_ID          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
  BEGIN
    V_YEAR_YYYY := TO_CHAR(W_STD_DATE, 'YYYY');
    BEGIN
      SELECT TRUNC(W_STD_DATE, 'MONTH') AS START_DATE,
             LAST_DAY(W_STD_DATE) AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
      ;    
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := W_STD_DATE;
        V_END_DATE   := W_STD_DATE;      
    END;
    OPEN P_CURSOR FOR
      SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY,
             NVL(HPM.NAME, NULL) AS NAME,
             NVL(HPM.PERSON_NUM, NULL) AS PERSON_NUM,
             NVL(HPM.REPRE_NUM, NULL) AS REPRE_NUM,
             NVL(EAPP_REGISTER_AGE_F(HPM.REPRE_NUM, W_STD_DATE, 0), NULL) AS AGE,
             NVL(HRM_DEPT_MASTER_G.DEPT_NAME_F(HPM.DEPT_ID), NULL) AS DEPT_NAME,
             NVL(HRM_COMMON_G.ID_NAME_F(HPM.FLOOR_ID), NULL) AS FLOOR_NAME,
             NVL(HPM.JOIN_DATE, NULL) AS JOIN_DATE,
             NVL(HPM.RETIRE_DATE, NULL) AS RETIRE_DATE,
             (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) AS NOW_SUM_PAY,
             (NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0)) AS PRE_SUM_PAY,
             (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) TOTAL_PAY,
             NVL(HA.INCOME_DED_AMT, 0) INCOME_DED_AMT,
             (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) INCOME_AMT,
             NVL(HA.PER_DED_AMT, 0) PER_DED_AMT,
             NVL(HA.SPOUSE_DED_AMT, 0) SPOUSE_DED_AMT,
             NVL(HA.SUPP_DED_COUNT, 0) SUPP_DED_COUNT,
             NVL(HA.SUPP_DED_AMT, 0) SUPP_DED_AMT,
             NVL(HA.OLD_DED_COUNT, 0) OLD_DED_COUNT,
             NVL(HA.OLD_DED_AMT, 0) OLD_DED_AMT,
             NVL(HA.OLD_DED_COUNT1, 0) OLD_DED_COUNT1,
             NVL(HA.OLD_DED_AMT1, 0) OLD_DED_AMT1,
             NVL(HA.DISABILITY_DED_COUNT, 0) DISABILITY_DED_COUNT,
             NVL(HA.DISABILITY_DED_AMT, 0) DISABILITY_DED_AMT,
             NVL(HA.WOMAN_DED_AMT, 0) WOMAN_DED_AMT,
             NVL(HA.CHILD_DED_COUNT, 0) CHILD_DED_COUNT,
             NVL(HA.CHILD_DED_AMT, 0) CHILD_DED_AMT,
             NVL(HA.BIRTH_DED_COUNT, 0) BIRTH_DED_COUNT,
             NVL(HA.BIRTH_DED_AMT, 0) BIRTH_DED_AMT,
             NVL(HA.MANY_CHILD_DED_COUNT, 0) MANY_CHILD_DED_COUNT,
             NVL(HA.MANY_CHILD_DED_AMT, 0) MANY_CHILD_DED_AMT,
             NVL(HA.NATI_ANNU_AMT, 0) NATI_ANNU_AMT,
             NVL(HA.ANNU_INSUR_AMT, 0) ANNU_INSUR_AMT,
             NVL(HA.RETR_ANNU_AMT, 0) RETR_ANNU_AMT,
             -- 보험료 금액이 음수일 경우에는 0을 출력(연말정산 제출매채 양식에 -값이 들어가지 않음);
             (CASE
               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                    NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
             END) ETC_INSURE_AMT,
             NVL(HA.MEDIC_AMT, 0) MEDIC_AMT,
             NVL(HA.EDUCATION_AMT, 0) EDUCATION_AMT,
             NVL(HA.HOUSE_INTER_AMT, 0) HOUSE_INTER_AMT,
             NVL(HA.HOUSE_MONTHLY_AMT, 0) HOUSE_MONTHLY_AMT,
             NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) LONG_HOUSE_PROF_AMT,
             NVL(HA.DONAT_AMT, 0) DONAT_AMT,
             ((CASE
               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                    NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN
                0
               ELSE
                NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
             END) + NVL(HA.MEDIC_AMT, 0) + NVL(HA.EDUCATION_AMT, 0) +
             NVL(HA.HOUSE_INTER_AMT, 0) + 
             NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +
             NVL(HA.HOUSE_MONTHLY_AMT, 0) + 
             NVL(HA.DONAT_AMT, 0) + NVL(HA.MARRY_ETC_AMT, 0)) SP_DED_SUM,
             NVL(HA.STAND_DED_AMT, 0) STAND_DED_AMT,
             NVL(HA.SUBT_DED_AMT, 0) SUBT_DED_AMT,
             NVL(HA.PERS_ANNU_BANK_AMT, 0) PERS_ANNU_BANK_AMT,
             NVL(HA.ANNU_BANK_AMT, 0) ANNU_BANK_AMT,
             NVL(HA.SMALL_CORPOR_DED_AMT, 0) SMALL_CORPOR_DED_AMT,
             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) + NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) HOUSE_SAVE_AMT,
             NVL(HA.INVES_AMT, 0) INVES_AMT,
             NVL(HA.CREDIT_AMT, 0) CREDIT_AMT,
             NVL(HA.EMPL_STOCK_AMT, 0) EMPL_STOCK_AMT,
             NVL(HA.LONG_STOCK_SAVING_AMT, 0) LONG_STOCK_SAVING_AMT,
             NVL(HA.TAX_STD_AMT, 0) TAX_STD_AMT,
             NVL(HA.COMP_TAX_AMT, 0) COMP_TAX_AMT,
             NVL(HA.TAX_REDU_IN_LAW_AMT, 0) TAX_REDU_IN_LAW_AMT,
             NVL(HA.TAX_REDU_SP_LAW_AMT, 0) TAX_REDU_SP_LAW_AMT,
             (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0)) AS TAX_REDU_SUM,
             NVL(HA.TAX_DED_INCOME_AMT, 0) TAX_DED_INCOME_AMT,
             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) TAX_DED_TAXGROUP_AMT,
             NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) TAX_DED_HOUSE_DEBT_AMT,
             NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) TAX_DED_DONAT_POLI_AMT,
             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) TAX_DED_OUTSIDE_PAY_AMT,
             (NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) 
             + NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) + NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0)) AS TAX_DED_SUM,
             NVL(HA.FIX_IN_TAX_AMT, 0) FIX_TAX_AMT,
             TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) FIX_IN_TAX_AMT, -- 원단위 절사.
             TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) FIX_LOCAL_TAX_AMT,
             TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) FIX_SP_TAX_AMT,
             (TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) + TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) + TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM,
             TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) PRE_IN_TAX_AMT,
             TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) PRE_LOCAL_TAX_AMT,
             TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1) PRE_SP_TAX_AMT,
             (TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) + TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) + TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1)) PRE_TAX_SUM,
             TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) -
             TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) PRE1_IN_TAX_AMT,
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) -
             TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) PRE1_LOCAL_TAX_AMT,
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) -
             TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1) PRE1_SP_TAX_AMT,
             (TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) - TRUNC(NVL(HPW1.IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) - TRUNC(NVL(HPW1.LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) - TRUNC(NVL(HPW1.SP_TAX_AMT, 0), -1)) PRE1_TAX_SUM,
             TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) SUBT_IN_TAX_AMT,
             TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) SUBT_LOCAL_TAX_AMT,
             TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) SUBT_SP_TAX_AMT,
             (TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) + TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) + TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) SUBT_TAX_SUM,
             (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) + 
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) + 
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) + 
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + 
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_OUTS_WORK_1, 0) + 
               NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + 
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + 
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + 
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0)) NONTAX_TOT_AMT,
             NVL(HA.NONTAX_OUTSIDE_AMT, 0) NONTAX_OUTSIDE_AMT,
             NVL(HA.NONTAX_OT_AMT, 0) NONTAX_OT_AMT,
             NVL(HA.NONTAX_RESEA_AMT, 0) NONTAX_RESEA_AMT,
             NVL(HA.NONTAX_ETC_AMT, 0) NONTAX_ETC_AMT,
             NVL(HA.NONTAX_BIRTH_AMT, 0) NONTAX_BIRTH_AMT,
             NVL(HA.NONTAX_FOREIGNER_AMT, 0) NONTAX_FOREIGNER_AMT,
             NVL(HA.NONTAX_SCH_EDU_AMT, 0) NONTAX_SCH_EDU_AMT,
             NVL(HA.NONTAX_MEMBER_AMT, 0) NONTAX_MEMBER_AMT,
             NVL(HA.NONTAX_GUARD_AMT, 0) NONTAX_GUARD_AMT,
             NVL(HA.NONTAX_CHILD_AMT, 0) NONTAX_CHILD_AMT,
             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) NONTAX_HIGH_SCH_AMT,
             NVL(HA.NONTAX_SPECIAL_AMT, 0) NONTAX_SPECIAL_AMT,
             NVL(HA.NONTAX_RESEARCH_AMT, 0) NONTAX_RESEARCH_AMT,
             NVL(HA.NONTAX_COMPANY_AMT, 0) NONTAX_COMPANY_AMT,
             NVL(HA.NONTAX_COVER_AMT, 0) NONTAX_COVER_AMT,
             NVL(HA.NONTAX_WILD_AMT, 0) NONTAX_WILD_AMT,
             NVL(HA.NONTAX_DISASTER_AMT, 0) NONTAX_DISASTER_AMT,
             NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) NONTAX_OUTS_GOVER_AMT,
             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) NONTAX_OUTS_ARMY_AMT,
             NVL(HA.NONTAX_OUTS_WORK_1, 0) NONTAX_OUTS_WORK_1,
             NVL(HA.NONTAX_OUTS_WORK_2, 0) NONTAX_OUTS_WORK_2,
             NVL(HA.NONTAX_STOCK_BENE_AMT, 0) NONTAX_STOCK_BENE_AMT,
             NVL(HA.NONTAX_FOR_ENG_AMT, 0) NONTAX_FOR_ENG_AMT,
             NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) NONTAX_EMPL_STOCK_AMT,
             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) NONTAX_EMPL_BENE_AMT_1,
             NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) NONTAX_EMPL_BENE_AMT_2,
             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) NONTAX_HOUSE_SUBSIDY_AMT,
             NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) NONTAX_SEA_RESOURCE_AMT
/*             NVL(HA.NOW_PAY_TOT_AMT, 0) NOW_PAY_TOT_AMT,
             NVL(HA.NOW_BONUS_TOT_AMT, 0) NOW_BONUS_TOT_AMT,
             NVL(HA.NOW_ADD_BONUS_AMT, 0) NOW_ADD_BONUS_AMT,
             NVL(HA.NOW_STOCK_BENE_AMT, 0) NOW_STOCK_BENE_AMT,
             NVL(HA.PRE_PAY_TOT_AMT, 0) PRE_PAY_TOT_AMT,
             NVL(HA.PRE_BONUS_TOT_AMT, 0) PRE_BONUS_TOT_AMT,
             NVL(HA.PRE_ADD_BONUS_AMT, 0) PRE_ADD_BONUS_AMT,
             NVL(HA.PRE_STOCK_BENE_AMT, 0) PRE_STOCK_BENE_AMT,
             NVL(HA.INCOME_OUTSIDE_AMT, 0) INCOME_OUTSIDE_AMT,
             (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.NONTAX_OUTSIDE_AMT, 0) NONTAX_OUTSIDE_AMT,
             NVL(HA.NONTAX_OT_AMT, 0) NONTAX_OT_AMT,
             NVL(HA.NONTAX_RESEA_AMT, 0) NONTAX_RESEA_AMT,
             NVL(HA.NONTAX_ETC_AMT, 0) NONTAX_ETC_AMT,
             NVL(HA.NONTAX_BIRTH_AMT, 0) NONTAX_BIRTH_AMT,
             NVL(HA.NONTAX_FOREIGNER_AMT, 0) NONTAX_FOREIGNER_AMT, 
             NVL(HA.INCOME_TOT_AMT, 0) INCOME_TOT_AMT,
             NVL(HA.DISABILITY_DED_AMT, 0) DISABILITY_DED_AMT,
             NVL(HA.WOMAN_DED_AMT, 0) WOMAN_DED_AMT,
             NVL(HA.PER_ADD_DED_AMT, 0) PER_ADD_DED_AMT,
             NVL(HA.EDUCATION_AMT, 0) EDUCATION_AMT,
             NVL(HA.HOUSE_FUND_AMT, 0) HOUSE_FUND_AMT,
             NVL(HA.MARRY_ETC_AMT, 0) MARRY_ETC_AMT,
             NVL(HA.FORE_INCOME_AMT, 0) FORE_INCOME_AMT,
             NVL(HA.RETR_ANNU_AMT, 0) RETR_ANNU_AMT, 
             NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) TAX_DED_LONG_STOCK_AMT,*/
             
        FROM HRA_YEAR_ADJUSTMENT HA,
             HRM_PERSON_MASTER HPM,
             ( -- 종전 납부 세액
              SELECT HPW.YEAR_YYYY,
                    HPW.PERSON_ID,
                    SUM(HPW.IN_TAX_AMT) IN_TAX_AMT,
                    SUM(HPW.LOCAL_TAX_AMT) LOCAL_TAX_AMT,
                    SUM(HPW.SP_TAX_AMT) SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY, HPW.PERSON_ID) HPW1
       WHERE HA.YEAR_YYYY       = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID       = HPW1.PERSON_ID(+)
         AND HA.PERSON_ID       = HPM.PERSON_ID
         AND HA.YEAR_YYYY       = V_YEAR_YYYY
         AND HA.PERSON_ID       = NVL(W_PERSON_ID, HA.PERSON_ID)
         AND HA.SOB_ID          = W_SOB_ID
         AND HA.ORG_ID          = W_ORG_ID
         AND HA.SUBMIT_DATE     BETWEEN V_START_DATE AND V_END_DATE
         AND ((W_EMPLOYE_YN     = 'Y' AND 1 = 1)  -- 중도퇴사자 포함 --
         OR   ((W_EMPLOYE_YN    = 'N' 
         AND   (HPM.JOIN_DATE   <= W_STD_DATE)
         AND   (HPM.RETIRE_DATE >= W_STD_DATE OR HPM.RETIRE_DATE IS NULL))))
         AND ((W_POST_ID        IS NULL AND 1 = 1)
         OR   (W_POST_ID        IS NOT NULL AND HPM.POST_ID = W_POST_ID))
         AND ((W_FLOOR_ID       IS NULL AND 1 = 1)
         OR   (W_FLOOR_ID       IS NOT NULL AND HPM.FLOOR_ID = W_FLOOR_ID))
         AND ((W_DEPT_ID        IS NULL AND 1 = 1)
         OR   (W_DEPT_ID        IS NOT NULL AND HPM.DEPT_ID = W_DEPT_ID)) 
       ;

  END SELECT_YEAR_ADJUSTMENT2;
  
END HRA_YEAR_ADJUSTMENT_G;
/
