CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUSTMENT_G
AS

-------------------------------------------------------------------------------
-- 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
            
-------------------------------------------------------------------------------
-- 연말정산 차감 집계 내역 조회.  
-------------------------------------------------------------------------------  
  PROCEDURE TAX_SUMMERY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN  DATE
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
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
-- 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
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
-- 연말정산 차감 집계 내역 조회.  
-------------------------------------------------------------------------------  
  PROCEDURE TAX_SUMMERY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_DATE          IN  DATE
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
    
  BEGIN
    V_YEAR_YYYY := TO_CHAR(W_STD_DATE, 'YYYY');
    BEGIN
      SELECT TRUNC(W_STD_DATE, 'MONTH') AS START_DATE,
             W_STD_DATE AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM DUAL
      ;    
    EXCEPTION
      WHEN OTHERS THEN
        V_START_DATE := W_STD_DATE;
        V_END_DATE   := W_STD_DATE;      
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
      SELECT T1.DEPT_NAME AS DEPT_NAME
           , T2.FLOOR_NAME
           , NVL(HA.PERSON_ID, NULL)  AS PERSON_ID
           , T1.NAME  AS NAME
           , T1.PERSON_NUM
           , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
             TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') APPLY_TERM,
             (NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
             NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
             NVL(HA.INCOME_OUTSIDE_AMT, 0)) AS TAX_PAY_SUM
           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +
             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0)) AS NONTAX_PAY_SUM
           , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- 원단위 절사 --
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
           , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT
           , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT
           , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT
           , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
             TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_TAX_SUM
           , CASE
               WHEN T1.RETIRE_DATE IS NULL THEN '계속근무'
               WHEN TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') < T1.RETIRE_DATE THEN '계속근무'
               ELSE '중도퇴사'
             END AS EMPLOYEE_TYPE
           , T1.RETIRE_DATE
           , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
           , NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)) AS TRANS_PAY_YYYYMM
           , NVL(HA.TRANS_DATE, TO_DATE(NULL)) AS TRANS_DATE
           , NVL(PM1.NAME, TO_CHAR(NULL)) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT  HA
           , HRM_PERSON_MASTER    PM1
           , (-- 시점 인사내역.
							SELECT HL.PERSON_ID
									, PM.NAME
									, PM.PERSON_NUM
									, PM.DISPLAY_NAME
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
									, PM.CORP_ID
                  , PM.WORK_CORP_ID
									, PM.ORI_JOIN_DATE
                  , PM.JOIN_DATE
									, PM.RETIRE_DATE
									, PM.SOB_ID
									, PM.ORG_ID
								FROM HRM_HISTORY_LINE HL  
									, HRM_PERSON_MASTER PM
                  , HRM_DEPT_MASTER   DM
							WHERE HL.PERSON_ID        = PM.PERSON_ID
                AND HL.DEPT_ID          = DM.DEPT_ID
                AND PM.CORP_ID          = W_CORP_ID
                AND PM.SOB_ID           = W_SOB_ID
                AND PM.ORG_ID           = W_ORG_ID
                AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
								AND ((W_DEPT_ID         IS NULL AND 1 = 1)
                OR   (W_DEPT_ID         IS NOT NULL AND HL.DEPT_ID = W_DEPT_ID))
                AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
                OR   (W_FLOOR_ID        IS NOT NULL AND HL.FLOOR_ID = W_FLOOR_ID))
                AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
                OR   (W_JOB_CATEGORY_ID IS NOT NULL AND HL.JOB_CLASS_ID = W_JOB_CATEGORY_ID))
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																							FROM HRM_HISTORY_LINE S_HL
																						 WHERE S_HL.CHARGE_DATE            <= W_SUBMIT_DATE_TO
																							 AND S_HL.PERSON_ID              = HL.PERSON_ID
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
      WHERE HA.PERSON_ID        = T1.PERSON_ID
        AND HA.PERSON_ID        = T2.PERSON_ID
        AND HA.TRANS_PERSON_ID  = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY        = V_YEAR_YYYY
        AND HA.PERSON_ID        = NVL(W_PERSON_ID, HA.PERSON_ID)
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN W_SUBMIT_DATE_FR AND W_SUBMIT_DATE_TO
      ORDER BY T1.DEPT_CODE, T1.PERSON_NUM, T1.NAME
      ;
  END SELECT_TAX_SUMMERY;
  
END HRA_YEAR_ADJUSTMENT_G;
/
