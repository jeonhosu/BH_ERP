CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUSTMENT_G
AS

-------------------------------------------------------------------------------
-- 사원정보 조회 --
-------------------------------------------------------------------------------
  PROCEDURE SELECT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER
            , W_OPERATING_UNIT_ID IN NUMBER DEFAULT NULL 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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


-- 연말정산 계산 : DELETE.
  PROCEDURE DELETE_YEAR_ADJUSTMENT
            ( W_STD_YYYYMM        IN VARCHAR2
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
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
            , W_STD_YYYYMM                        IN VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
            , W_SUBMIT_YYYYMM_FR  IN  VARCHAR
            , W_SUBMIT_YYYYMM_TO  IN  VARCHAR
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_SPREAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_EMPLOYE_YN        IN  VARCHAR2
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- 2014 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_2014
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회(2014).
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUST_SPREAD_14
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
/*
-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_SPREAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );
                       */                         
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
            , W_OPERATING_UNIT_ID IN NUMBER DEFAULT NULL 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
      FROM HRM_PERSON_MASTER_V PM
        , (-- 시점 인사내역.
            SELECT  HL.PERSON_ID
                  , HL.OPERATING_UNIT_ID 
                  , HL.DEPT_ID
                  , DM.DEPT_NAME
                  , DM.DEPT_SORT_NUM
                  , HL.POST_ID
                  , HP.POST_CODE 
                  , HP.POST_NAME
                  , HP.SORT_NUM AS POST_SORT_NUM
                  , HL.PAY_GRADE_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID
                  , HF.FLOOR_CODE
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
              AND HH.CHARGE_SEQ           IN 
                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                        FROM HRM_HISTORY_HEADER S_HH
                           , HRM_HISTORY_LINE   S_HL
                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                         AND S_HH.CHARGE_DATE       <= V_STD_DATE 
                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                       GROUP BY S_HL.PERSON_ID
                     ) 
          ) T1
      WHERE PM.PERSON_ID            = T1.PERSON_ID
        AND ((W_CORP_ID             IS NULL AND 1 = 1)
          OR (W_CORP_ID             IS NOT NULL AND PM.CORP_ID = W_CORP_ID))
        AND ((W_OPERATING_UNIT_ID   IS NULL AND 1 = 1) 
          OR (W_OPERATING_UNIT_ID   IS NOT NULL AND T1.OPERATING_UNIT_ID = W_OPERATING_UNIT_ID)) 
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
          OR (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND PM.JOIN_DATE            <= V_STD_DATE
        AND (PM.RETIRE_DATE         >= TRUNC(V_STD_DATE, 'MONTH') OR PM.RETIRE_DATE IS NULL)
        
        AND ((W_YEAR_EMPLOYE_TYPE   IS NULL AND 1 =1)
          OR (W_YEAR_EMPLOYE_TYPE   != '20' AND (PM.RETIRE_DATE > LAST_DAY(V_STD_DATE) OR PM.RETIRE_DATE IS NULL))
          OR (W_YEAR_EMPLOYE_TYPE   = '20' AND (PM.RETIRE_DATE BETWEEN TRUNC(V_STD_DATE, 'MONTH') AND V_STD_DATE)))
        AND PM.SOB_ID               = W_SOB_ID
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
          OR (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
          OR (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
      ORDER BY T1.FLOOR_SORT_NUM
             , T1.FLOOR_CODE 
             , T1.POST_SORT_NUM
             , T1.POST_CODE 
             , PM.PERSON_NUM 
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
      SELECT HA.YEAR_YYYY AS YEAR_YYYY
           , HA.PERSON_ID AS PERSON_ID
           , HA.SUBMIT_DATE AS SUBMIT_DATE
           , HA.ADJUST_DATE_FR AS ADJUST_DATE_FR
           , HA.ADJUST_DATE_TO AS ADJUST_DATE_TO
           , NVL(HA.NOW_PAY_TOT_AMT, 0) AS NOW_PAY_TOT_AMT
           , NVL(HA.NOW_BONUS_TOT_AMT, 0) AS NOW_BONUS_TOT_AMT
           , NVL(HA.NOW_ADD_BONUS_AMT, 0) AS NOW_ADD_BONUS_AMT
           , NVL(HA.NOW_STOCK_BENE_AMT, 0) AS NOW_STOCK_BENE_AMT
           , NVL(HA.PRE_PAY_TOT_AMT, 0) AS PRE_PAY_TOT_AMT
           , NVL(HA.PRE_BONUS_TOT_AMT, 0) AS PRE_BONUS_TOT_AMT
           , NVL(HA.PRE_ADD_BONUS_AMT, 0) AS PRE_ADD_BONUS_AMT
           , NVL(HA.PRE_STOCK_BENE_AMT, 0) AS PRE_STOCK_BENE_AMT
           , NVL(HA.INCOME_OUTSIDE_AMT, 0) AS INCOME_OUTSIDE_AMT
           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0) +
               -- 비과세
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- 근로소득(과세 + 비과세) --
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- 총급여 --
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- 근로소득 공제 --
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득 금액 --
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT
           , NVL(HA.OLD_DED_COUNT, 0) AS OLD_DED_COUNT
           , NVL(HA.OLD_DED_AMT, 0) AS OLD_DED_AMT
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
           , NVL(HA.CHILD_DED_COUNT, 0) AS CHILD_DED_COUNT
           , NVL(HA.CHILD_DED_AMT, 0) AS CHILD_DED_AMT
           , NVL(HA.PER_ADD_DED_AMT, 0) AS PER_ADD_DED_AMT
           , NVL(HA.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
           , NVL(HA.MANY_CHILD_DED_AMT, 0) AS MANY_CHILD_DED_AMT
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- 국민연금 --
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- 연금보험료 합계 --
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- 건강보험(건강 + 장기요양보험)
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- 고용보험
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- 보장보험
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- 장애인보험
             -- 보험료 금액이 음수일 경우에는 0을 출력(연말정산 제출매채 양식에 -값이 들어가지 않음);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- 기타보험료 합계 --
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- 의료비 합계 (장애인 + 기타)
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- 교육비(장애인 + 기타)
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- 주택임차차입금 대출기관 + 거주자
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_AMT, 0) AS DONAT_AMT  -- 기부금 합계
           , NVL(HA.MARRY_ETC_AMT, 0) AS MARRY_ETC_AMT
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) +
               NVL(HA.MEDIC_AMT, 0) + NVL(HA.EDUCATION_AMT, 0) +
               NVL(HA.HOUSE_FUND_AMT, 0) + -- 주택자금(주택입차차입금 + 월세액 + 장기주택저당차입금 + 주택저축)
               NVL(HA.DONAT_AMT, 0) +
               NVL(HA.MARRY_ETC_AMT, 0)) AS SP_DED_SUM  -- 특별공제 합계 --
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- 표준공제   --
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- 차감소득금액 --
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT
           , NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- 외국 근로자 소득 --
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT
           , NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) +
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0)) AS TOT_ETC_DED_AMT   -- 그밖의 소득공제 합계 금액 --
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT
           , (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT
           , NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TAX_DED_TAXGROUP_AMT, 0) +
               NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) +
               NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0)) AS TAX_DED_SUM
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- 결정세액
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- 원단위 절사.
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) + NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
           , ( NVL(HPW1.IN_TAX_AMT, 0) + NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0)) AS PRE1_IN_TAX_AMT
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0)) AS PRE1_LOCAL_TAX_AMT
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_SP_TAX_AMT
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_TAX_SUM
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- 차감 소득세
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- 차감 주민세
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- 차감 농특세
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- 주택마련저축소득공제 --
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013년 추가 --
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
        FROM HRA_YEAR_ADJUSTMENT HA
           , ( -- 종전 납부 세액
              SELECT HPW.YEAR_YYYY
                   , HPW.PERSON_ID
                   , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                   , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                   , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY, HPW.PERSON_ID
             ) HPW1
       WHERE HA.YEAR_YYYY = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID = HPW1.PERSON_ID(+)
         AND HA.YEAR_YYYY = V_YEAR_YYYY
         AND HA.PERSON_ID = W_PERSON_ID
         AND HA.SOB_ID    = W_SOB_ID
         AND HA.ORG_ID    = W_ORG_ID
         AND HA.SUBMIT_DATE BETWEEN V_START_DATE AND V_END_DATE
       ;

  END SELECT_YEAR_ADJUSTMENT;

-- 연말정산 계산 : DELETE.
  PROCEDURE DELETE_YEAR_ADJUSTMENT
            ( W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(HA.PERSON_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_YEAR_ADJUSTMENT HA
      WHERE HA.YEAR_YYYY        = W_STD_YYYYMM
        AND HA.PERSON_ID        = W_PERSON_ID
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.CLOSED_FLAG      = 'Y'
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
      RETURN;
    END IF;

    BEGIN
      DELETE FROM HRA_YEAR_ADJUSTMENT HA
       WHERE HA.YEAR_YYYY         = W_STD_YYYYMM
         AND HA.PERSON_ID         = W_PERSON_ID
         AND HA.SOB_ID            = W_SOB_ID
         AND HA.ORG_ID            = W_ORG_ID
         AND HA.CLOSED_FLAG       = 'N'  -- 마감 안된 자료만.
       ;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Delete Error : Person ID - ' || W_PERSON_ID || CHR(10) || SQLERRM);
        RETURN;
    END;
  END DELETE_YEAR_ADJUSTMENT;


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
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
          , ( TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- 차감 합계 --
          , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
          , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
              NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
              NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
              NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
              NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
              NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
              NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
              NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
              NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
              NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
              NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
              NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
              NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
              -- 종전--
              NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +
              NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
              NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
              NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
              NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
              NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
              NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
              NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
              NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
              NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0) +
              NVL(HA.PRE_NT_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
              NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
              NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
              NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- 원단위 절사.
          , TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) AS FIX_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1) AS FIX_SP_TAX_AMT
          , ( TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.FIX_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.FIX_SP_TAX_AMT, 0), -1)) AS FIX_TAX_SUM
          , TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) AS PRE_IN_TAX_AMT
          , TRUNC(NVL(HA.PRE_LOCAL_TAX_AMT, 0), -1) AS PRE_LOCAL_TAX_AMT
          , TRUNC(NVL(HA.PRE_SP_TAX_AMT, 0), -1) AS PRE_SP_TAX_AMT
          , ( TRUNC(NVL(HA.PRE_IN_TAX_AMT, 0), -1) +
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
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
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
                    , HL.JOB_CLASS_ID
                    , HL.OCPT_ID
                    , HL.ABIL_ID
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL
                   , HRM_DEPT_MASTER    DM
                   , HRM_FLOOR_V        HF
                   , HRM_POST_CODE_V    HP
              WHERE HH.HISTORY_HEADER_ID    = HL.HISTORY_HEADER_ID
                AND HL.DEPT_ID              = DM.DEPT_ID
                AND HL.FLOOR_ID             = HF.FLOOR_ID
                AND HL.POST_ID              = HP.POST_ID
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_STD_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       ) 
            ) T1
      WHERE HA.PERSON_ID            = PM.PERSON_ID
        AND PM.PERSON_ID            = T1.PERSON_ID
        AND HA.YEAR_YYYY            = V_YEAR_YYYY
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID               = W_SOB_ID
        AND HA.ORG_ID               = W_ORG_ID
        AND HA.SUBMIT_DATE          BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG          = W_CLOSED_FLAG  -- 마감 구분 --
        AND PM.CORP_ID              = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
        OR   (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID     IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID     IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        
        AND ((W_YEAR_EMPLOYE_TYPE   IS NULL AND 1 = 1)
          OR (W_YEAR_EMPLOYE_TYPE   != '20' AND (PM.RETIRE_DATE > LAST_DAY(V_STD_DATE) OR PM.RETIRE_DATE IS NULL))
          OR (W_YEAR_EMPLOYE_TYPE   = '20' AND (PM.RETIRE_DATE BETWEEN TRUNC(V_STD_DATE, 'MONTH') AND V_STD_DATE)))          
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
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
      SELECT  T1.DEPT_NAME AS DEPT_NAME
            , T1.FLOOR_NAME
            , HA.PERSON_ID AS  PERSON_ID
            , PM.NAME AS NAME
            , PM.PERSON_NUM
            , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
              TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') APPLY_TERM
            , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM

            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +    -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                -- 종전--
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM

            , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT  -- 원단위 절사.
            , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
            , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
            , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM

            , NVL(HA.PRE_IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
            , NVL(HA.PRE_LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
            , NVL(HA.PRE_SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
            , ( NVL(HA.PRE_IN_TAX_AMT, 0) +
                NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM

            , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT
            , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT
            , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT
            , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
            , CASE
                WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
                WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
                ELSE '중도퇴사'
              END AS EMPLOYEE_TYPE
            , PM.RETIRE_DATE
            , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(PM1.NAME, TO_CHAR(NULL)), NULL) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , HRM_PERSON_MASTER   PM1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_STD_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       ) 
            ) T1
      WHERE HA.PERSON_ID            = PM.PERSON_ID
        AND PM.PERSON_ID            = T1.PERSON_ID
        AND HA.TRANS_PERSON_ID      = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY            = V_YEAR_YYYY
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID               = W_SOB_ID
        AND HA.ORG_ID               = W_ORG_ID
        AND HA.SUBMIT_DATE          BETWEEN V_START_DATE AND V_END_DATE
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
        OR   (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID     IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID     IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        
        AND ((W_YEAR_EMPLOYE_TYPE   IS NULL AND 1 =1)
          OR (W_YEAR_EMPLOYE_TYPE   != '20' AND (PM.RETIRE_DATE > V_END_DATE OR PM.RETIRE_DATE IS NULL))
          OR (W_YEAR_EMPLOYE_TYPE   = '20' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND V_END_DATE)))
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
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
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
      SELECT  'N' AS SELECT_YN
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
            , ( TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
                TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
                TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- 차감 합계 --
            , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM

            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                -- 종전--
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM

            , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT  -- 원단위 절사.
            , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
            , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
            , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM

            , NVL(HA.PRE_IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
            , NVL(HA.PRE_LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
            , NVL(HA.PRE_SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
            , ( NVL(HA.PRE_IN_TAX_AMT, 0) +
                NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM
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
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
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
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_STD_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       ) 
            ) T1
      WHERE HA.PERSON_ID            = PM.PERSON_ID
        AND PM.PERSON_ID            = T1.PERSON_ID
        AND HA.YEAR_YYYY            = V_YEAR_YYYY
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID               = W_SOB_ID
        AND HA.ORG_ID               = W_ORG_ID
        AND HA.SUBMIT_DATE          BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG          = 'Y'  -- 마감 구분 --
        AND HA.TRANS_YN             = W_TRANS_YN  -- 급여전송 구분 --
        AND PM.CORP_ID              = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
        OR   (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID     IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID     IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        
        AND ((W_YEAR_EMPLOYE_TYPE   IS NULL AND 1 =1)
          OR (W_YEAR_EMPLOYE_TYPE   != '20' AND (PM.RETIRE_DATE > V_END_DATE OR PM.RETIRE_DATE IS NULL))
          OR (W_YEAR_EMPLOYE_TYPE   = '20' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND V_END_DATE)))
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
    V_TRANS_COUNT         NUMBER;   -- 처리 횟수
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
      FOR C1 IN ( SELECT HA.PERSON_ID AS PERSON_ID
                        , PM.NAME AS NAME
                        , PM.PERSON_NUM
                        , PM.CORP_ID
                        , PM.SOB_ID
                        , PM.ORG_ID
                        , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
                        , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                            NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                            NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                            NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                            NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                            NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                            NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                            NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                            NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                            NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                            NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                            NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                            NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                            -- 종전--
                            NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                            NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                            NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                            NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                            NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                            NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                            NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                            NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                            NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                            NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                            NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                            NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                            NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM
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
          -- 기존자료 삭제 --
          BEGIN
            DELETE FROM HRA_YEAR_ADJUSTMENT_INTERFACE YAI
             WHERE YAI.YEAR_YYYYMM    = C1.YEAR_YYYYMM
               AND YAI.PERSON_ID      = C1.PERSON_ID
               AND YAI.SOB_ID         = C1.SOB_ID
               AND YAI.ORG_ID         = C1.ORG_ID
               AND YAI.PAY_YYYYMM     = C1.PAY_YYYYMM
               AND YAI.WAGE_TYPE      = C1.WAGE_TYPE
             ;
          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;

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
              IF NVL(R1.AMOUNT, 0) != 0 THEN
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

    FOR C1 IN ( SELECT HA.PERSON_ID AS PERSON_ID
                    , PM.NAME AS NAME
                    , PM.PERSON_NUM
                    , PM.CORP_ID
                    , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
                    , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                        NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                        NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                        NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                        NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                        NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                        NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                        NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                        NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                        NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                        NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                        NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                        NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                        -- 종전--
                        NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                        NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                        NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                        NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                        NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                        NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                        NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                        NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                        NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                        NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                        NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                        NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                        NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM
                    , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT
                    , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
                    , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
                    , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                        NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                        NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
                    , NVL(HA.PRE_IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
                    , NVL(HA.PRE_LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
                    , NVL(HA.PRE_SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
                    , ( NVL(HA.PRE_IN_TAX_AMT, 0) +
                        NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                        NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM
                    , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT
                    , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT
                    , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT
                    , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                        NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                        NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
                    , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
                FROM HRA_YEAR_ADJUSTMENT HA
                  , HRM_PERSON_MASTER    PM
                  , (-- 시점 인사내역.
                      SELECT  HL.PERSON_ID
                            , HL.DEPT_ID
                            , DM.DEPT_CODE
                            , DM.DEPT_NAME
                            , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                        AND HH.CHARGE_SEQ           IN 
                              (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                  FROM HRM_HISTORY_HEADER S_HH
                                     , HRM_HISTORY_LINE   S_HL
                                 WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                   AND S_HH.CHARGE_DATE       <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM')) 
                                   AND S_HL.PERSON_ID         = HL.PERSON_ID
                                 GROUP BY S_HL.PERSON_ID
                               ) 
                  ) T1
              WHERE HA.PERSON_ID        = PM.PERSON_ID
                AND PM.PERSON_ID        = T1.PERSON_ID
                AND HA.YEAR_YYYY        = P_YEAR_YYYY
                AND HA.CORP_ID          = P_CORP_ID
                AND ((P_PERSON_ID       IS NULL AND 1 = 1)
                OR   (P_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = P_PERSON_ID))
                AND HA.SOB_ID           = P_SOB_ID
                AND HA.ORG_ID           = P_ORG_ID
                AND PM.JOIN_DATE        <= LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'))
                AND (PM.RETIRE_DATE     >= TRUNC(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'), 'MONTH') OR PM.RETIRE_DATE IS NULL)
                AND HA.SUBMIT_DATE      BETWEEN P_START_DATE AND P_END_DATE
                AND (HA.TRANS_YN        IS NULL OR HA.TRANS_YN = 'N')  -- 이미 전송된 자료는 전송 제외 --
                AND ((P_DEPT_ID         IS NULL AND 1 = 1)
                OR   (P_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
             )
    LOOP
/*      -- 1.전호수 추가(2013-01-10) : 기존자료 삭제(인사팀 요청-계속 UPDATE 방지) --
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
            , W_SUBMIT_YYYYMM_FR  IN  VARCHAR
            , W_SUBMIT_YYYYMM_TO  IN  VARCHAR
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_SUBMIT_DATE_FR              DATE := TRUNC(TO_DATE(W_SUBMIT_YYYYMM_FR, 'YYYY-MM'), 'MONTH');
    V_SUBMIT_DATE_TO              DATE := LAST_DAY(TO_DATE(W_SUBMIT_YYYYMM_TO, 'YYYY-MM'));

  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_SUBMIT_DATE_TO, 'YYYY');

    OPEN P_CURSOR1 FOR
      SELECT  NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
            , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
            , NVL(HA.PERSON_ID, NULL)  AS PERSON_ID
            , NVL(PM.NAME, NULL)  AS NAME
            , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
            , CASE
                WHEN GROUPING(T1.DEPT_NAME) = 1 THEN PT_TOTAL_SUM
                ELSE TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
                     TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD')
              END AS APPLY_TERM
            , SUM( NVL(HA.INCOME_TOT_AMT, 0)) AS TAX_PAY_SUM
            , SUM( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                   NVL(HA.NONTAX_RESEA_AMT, 0) + /*NVL(HA.NONTAX_ETC_AMT, 0) +*/
                   NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                   NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                   NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                   NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                   NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                   NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                   NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                   NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                   NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                   NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                   NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                   -- 종전--
                   NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                   NVL(HA.PRE_NT_RESEA_AMT, 0) + /*NVL(HA.PRE_NT_ETC_AMT, 0) +*/
                   NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                   NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                   NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                   NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                   NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                   NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                   NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                   NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                   NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                   NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                   NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM

            , SUM(NVL(HA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT  -- 원단위 절사 --
            , SUM(NVL(HA.FIX_LOCAL_TAX_AMT, 0)) AS FIX_LOCAL_TAX_AMT
            , SUM(NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_SP_TAX_AMT
            , SUM( NVL(HA.FIX_IN_TAX_AMT, 0) +
                   NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                   NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM

            , SUM(NVL(HA.PRE_IN_TAX_AMT, 0)) AS PRE_IN_TAX_AMT
            , SUM(NVL(HA.PRE_LOCAL_TAX_AMT, 0)) AS PRE_LOCAL_TAX_AMT
            , SUM(NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_SP_TAX_AMT
            , SUM( NVL(HA.PRE_IN_TAX_AMT, 0) +
                   NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                   NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM

            , SUM(NVL(HA.SUBT_IN_TAX_AMT, 0)) AS SUBT_IN_TAX_AMT
            , SUM(NVL(HA.SUBT_LOCAL_TAX_AMT, 0)) AS SUBT_LOCAL_TAX_AMT
            , SUM(NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_SP_TAX_AMT
            , SUM( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                   NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                   NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
            , CASE
                WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
                WHEN TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
                ELSE '중도퇴사'
              END AS EMPLOYEE_TYPE
            , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
            , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(PM1.NAME, TO_CHAR(NULL)), NULL) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT  HA
           , HRM_PERSON_MASTER    PM
           , HRM_PERSON_MASTER    PM1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , DM.DEPT_SORT_NUM
                    , HL.POST_ID
                    , HP.POST_NAME
                    , HP.SORT_NUM AS POST_SORT_NUM
                    , HL.PAY_GRADE_ID
                    , HL.JOB_CATEGORY_ID
                    , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
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
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_SUBMIT_DATE_TO 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       ) 
              ) T1
      WHERE HA.PERSON_ID            = PM.PERSON_ID
        AND PM.PERSON_ID            = T1.PERSON_ID
        AND HA.TRANS_PERSON_ID      = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY            = V_YEAR_YYYY
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
        OR   (W_PERSON_ID           IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID               = W_SOB_ID
        AND HA.ORG_ID               = W_ORG_ID
        AND HA.SUBMIT_DATE          BETWEEN V_SUBMIT_DATE_FR AND V_SUBMIT_DATE_TO
        AND PM.CORP_ID              = W_CORP_ID
        AND PM.SOB_ID               = W_SOB_ID
        AND PM.ORG_ID               = W_ORG_ID
        AND ((W_DEPT_ID             IS NULL AND 1 = 1)
        OR   (W_DEPT_ID             IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID            IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID            IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID     IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID     IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
        
        AND ((W_YEAR_EMPLOYE_TYPE   IS NULL AND 1 =1)
          OR (W_YEAR_EMPLOYE_TYPE   != '20' AND (PM.RETIRE_DATE > V_SUBMIT_DATE_TO OR PM.RETIRE_DATE IS NULL))
          OR (W_YEAR_EMPLOYE_TYPE   = '20' AND (PM.RETIRE_DATE BETWEEN V_SUBMIT_DATE_FR AND V_SUBMIT_DATE_TO)))
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


-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_SPREAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_EMPLOYE_YN        IN  VARCHAR2
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');

    OPEN P_CURSOR FOR
      SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
           , NVL(PM.NAME, NULL) AS NAME
           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
           , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
           , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_END_DATE, 0), NULL) AS AGE
           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
           -- 인적공제
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
           , NVL(HA.OLD_DED_COUNT, 0) AS OLD_DED_COUNT                  -- 경로우대 인원수
           , NVL(HA.OLD_DED_AMT, 0) AS OLD_DED_AMT                      -- 경로우대 공제금액
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
           , NVL(HA.CHILD_DED_COUNT, 0) AS CHILD_DED_COUNT              -- 6세이하  인원수
           , NVL(HA.CHILD_DED_AMT, 0) AS CHILD_DED_AMT                  -- 6세이하 공제금액
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT              -- 출산/입양자 인원수
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT                  -- 출산/입양자 공제금액
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
           , NVL(HA.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT    -- 다자녀 인원수
           , NVL(HA.MANY_CHILD_DED_AMT, 0) AS MANY_CHILD_DED_AMT        -- 다자녀 공제금액
           -- 연금보험료 공제
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT                -- 연금보험료 합계
           , NVL(HA.SCIENTIST_ANNU_AMT, 0) AS SCIENTIST_ANNU_AMT        -- 과학기술인공제
           , NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT                  -- 퇴직연금
           , NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT                  -- 연금저축
           -- 특별공제
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT                -- 보장성 보험료
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT    -- 장애인 전용 보험료
           , NVL(HA.DISABILITY_MEDIC_AMT, 0) AS DISABILITY_MEDIC_AMT    -- 의료비 - 장애인
           , NVL(HA.ETC_MEDIC_AMT, 0) AS ETC_MEDIC_AMT                  -- 의료비 - 기타
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT                          -- 의료비 공제액
           , NVL(HA.DISABILITY_EDUCATION_AMT, 0) AS DISABILITY_EDUCATION_AMT  -- 교육비 - 장애인
           , NVL(HA.ETC_EDUCATION_AMT, 0) AS ETC_EDUCATION_AMT                -- 교육비 - 기타
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT                        -- 교육비 공제액
           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT                -- 월세액
           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
           , NVL(HA.DONAT_DED_POLI_AMT, 0) AS DONAT_DED_POLI_AMT        -- 정치자금기부금
           , NVL(HA.DONAT_DED_ALL, 0) AS DONAT_DED_ALL                  -- 법정기부금
           , NVL(HA.DONAT_DED_50, 0) AS DONAT_DED_50                    -- 특별기부금
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
           , NVL(HA.DONAT_DED_RELIGION_10, 0) AS DONAT_DED_RELIGION_10  -- 종교단체 기부금
           , NVL(HA.DONAT_DED_10, 0) AS DONAT_DED_10                    -- 종교단체외 기부금
           , NVL(HA.DONAT_AMT, 0) AS DONAT_AMT                          -- 기부금 합계
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) +
               NVL(HA.MEDIC_AMT, 0) + NVL(HA.EDUCATION_AMT, 0) +
               NVL(HA.HOUSE_FUND_AMT, 0) + -- 주택자금(주택입차차입금 + 월세액 + 장기주택저당차입금 + 주택저축)
               NVL(HA.DONAT_AMT, 0) +
               NVL(HA.MARRY_ETC_AMT, 0)) AS SP_DED_SUM_AMT              -- 특별공제 합계 --
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                  -- 표준공제
           -- 차감소득금액
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
           -- 그밖의 소득공제
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축(가)
           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축(나)
           , NVL(HA.HOUSE_SAVE_AMT, 0) AS HOUSE_SAVE_AMT                -- 장기주택마련저축공제액(다)
           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축(라)
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT  -- 장기주식형저축소득공제
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) +
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
           -- 특별공제 종합한도 초과액
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
           -- 종합소득 과세표준
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
           -- 산출세액
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
           -- 세액감면
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
           -- 세액공제
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- 세공 - 장기증권저축
           , NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- 세공 - 기부 정치자금
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TAX_DED_TAXGROUP_AMT, 0) +
               NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) +
               NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0)) AS TAX_DED_SUM_AMT  -- 세액공제 계
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
           -- 결정세액
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
           -- (종전) 기납부 세액
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
           , ( NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
           -- (주현) 기납부 세액
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
               NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
               NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
               NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
           -- 차감 세액
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
               NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계
           -- 비과세 합계
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
           -- 비과세 상세
           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
           , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
           , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
           , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
           , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
           , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
           , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
           , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
           , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
           , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
           , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
           , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
           , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
           , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
           , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
           , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
           , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
           , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
           , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
           , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
           , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
           , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
           , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
           , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
           , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
           , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
           , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
           , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
           , NVL(HA.CLOSED_FLAG, NULL) AS CLOSED_FLAG
           , NVL(C_PM.NAME, NULL) AS CLOSED_PERSON_NAME
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , ( -- 종전 납부 세액
               SELECT HPW.YEAR_YYYY
                    , HPW.PERSON_ID
                    , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                    , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                    , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY
                      , HPW.PERSON_ID
             ) HPW1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                AND HH.CHARGE_SEQ           IN 
                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                        FROM HRM_HISTORY_HEADER S_HH
                           , HRM_HISTORY_LINE   S_HL
                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                         AND S_HH.CHARGE_DATE       <= V_END_DATE  
                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                       GROUP BY S_HL.PERSON_ID
                     ) 
             ) T1
           , HRM_PERSON_MASTER C_PM
       WHERE HA.YEAR_YYYY         = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID         = HPW1.PERSON_ID(+)
         AND HA.PERSON_ID         = PM.PERSON_ID
         AND PM.PERSON_ID         = T1.PERSON_ID
         AND HA.CLOSED_PERSON_ID  = C_PM.PERSON_ID(+)
         AND HA.YEAR_YYYY         = V_YEAR_YYYY
         AND HA.SOB_ID            = W_SOB_ID
         AND HA.ORG_ID            = W_ORG_ID
         AND HA.SUBMIT_DATE       BETWEEN V_START_DATE AND V_END_DATE
         AND ((W_PERSON_ID        IS NULL AND 1 = 1)
         OR   (W_PERSON_ID        IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
         AND ((W_EMPLOYE_YN       = 'Y' AND 1 = 1)  -- 중도퇴사자 포함 --
         OR   ((W_EMPLOYE_YN      = 'N'
         AND   (PM.JOIN_DATE      <= V_END_DATE)
         AND   (PM.RETIRE_DATE    >= V_START_DATE OR PM.RETIRE_DATE IS NULL))))
         AND ((W_POST_ID          IS NULL AND 1 = 1)
         OR   (W_POST_ID          IS NOT NULL AND T1.POST_ID = W_POST_ID))
         AND ((W_FLOOR_ID         IS NULL AND 1 = 1)
         OR   (W_FLOOR_ID         IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
         AND ((W_DEPT_ID          IS NULL AND 1 = 1)
         OR   (W_DEPT_ID          IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
      ORDER BY T1.DEPT_CODE
             , T1.POST_SORT_NUM
             , HA.ADJUST_DATE_TO
             , PM.PERSON_NUM
       ;
  END SELECT_YEAR_ADJUSTMENT_SPREAD;

-------------------------------------------------------------------------------
-- 2014년 재정산 이후 연말정산 계산 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT_2014
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
      SELECT HA.YEAR_YYYY AS YEAR_YYYY
           , HA.PERSON_ID AS PERSON_ID
           , HA.SUBMIT_DATE AS SUBMIT_DATE
           , HA.ADJUST_DATE_FR AS ADJUST_DATE_FR
           , HA.ADJUST_DATE_TO AS ADJUST_DATE_TO
           , NVL(HA.NOW_PAY_TOT_AMT, 0) AS NOW_PAY_TOT_AMT
           , NVL(HA.NOW_BONUS_TOT_AMT, 0) AS NOW_BONUS_TOT_AMT
           , NVL(HA.NOW_ADD_BONUS_AMT, 0) AS NOW_ADD_BONUS_AMT
           , NVL(HA.NOW_STOCK_BENE_AMT, 0) AS NOW_STOCK_BENE_AMT
           , NVL(HA.PRE_PAY_TOT_AMT, 0) AS PRE_PAY_TOT_AMT
           , NVL(HA.PRE_BONUS_TOT_AMT, 0) AS PRE_BONUS_TOT_AMT
           , NVL(HA.PRE_ADD_BONUS_AMT, 0) AS PRE_ADD_BONUS_AMT
           , NVL(HA.PRE_STOCK_BENE_AMT, 0) AS PRE_STOCK_BENE_AMT
           , NVL(HA.INCOME_OUTSIDE_AMT, 0) AS INCOME_OUTSIDE_AMT
           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0) +
               -- 비과세
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- 근로소득(과세 + 비과세) --
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- 총급여 --
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- 근로소득 공제 --
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득 금액 --
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT
           , NVL(HA.OLD_DED_COUNT, 0) AS OLD_DED_COUNT
           , NVL(HA.OLD_DED_AMT, 0) AS OLD_DED_AMT
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT
           , NVL(HA.CHILD_DED_COUNT, 0) AS CHILD_DED_COUNT
           , NVL(HA.CHILD_DED_AMT, 0) AS CHILD_DED_AMT
           , NVL(HA.PER_ADD_DED_AMT, 0) AS PER_ADD_DED_AMT
           , NVL(HA.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT
           , NVL(HA.MANY_CHILD_DED_AMT, 0) AS MANY_CHILD_DED_AMT
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- 국민연금 --
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- 연금보험료 합계 --
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- 건강보험(건강 + 장기요양보험)
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- 고용보험
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- 보장보험
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- 장애인보험
             -- 보험료 금액이 음수일 경우에는 0을 출력(연말정산 제출매채 양식에 -값이 들어가지 않음);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- 기타보험료 합계 --
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- 의료비 합계 (장애인 + 기타)
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- 교육비(장애인 + 기타)
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- 주택임차차입금 대출기관 + 거주자
           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
              NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
              NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
              NVL(HA.LONG_HOUSE_ITR_15_15_FIX_1, 0) + NVL(HA.LONG_HOUSE_ITR_15_15_FIX_2, 0) + 
              NVL(HA.LONG_HOUSE_ITR_15_15_ETC, 0) + 
              NVL(HA.LONG_HOUSE_ITR_15_10_FIX_2, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
             NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) AS DONAT_AMT      -- 2014-특별소득공제(기부금이월분)
           , NVL(HA.MARRY_ETC_AMT, 0) AS MARRY_ETC_AMT
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
               END) +
               (CASE
                 WHEN NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_ITR_15_15_FIX_1, 0) + NVL(HA.LONG_HOUSE_ITR_15_15_FIX_2, 0) + 
                      NVL(HA.LONG_HOUSE_ITR_15_15_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_ITR_15_10_FIX_2, 0) + 
                      NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) + 
                      NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0) < 0 THEN 0
                 ELSE NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
                      NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_ITR_15_15_FIX_1, 0) + NVL(HA.LONG_HOUSE_ITR_15_15_FIX_2, 0) + 
                      NVL(HA.LONG_HOUSE_ITR_15_15_ETC, 0) + 
                      NVL(HA.LONG_HOUSE_ITR_15_10_FIX_2, 0) + 
                      NVL(HA.DONAT_DED_ALL, 0) + NVL(HA.DONAT_DED_50, 0) +  
                      NVL(HA.DONAT_DED_RELIGION_10, 0) + NVL(HA.DONAT_DED_10, 0)
               END) -- 주택자금(주택입차차입금 + 월세액 + 장기주택저당차입금 )
              ) AS SP_DED_SUM  -- 특별공제 합계 --                                                                                                                       
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- 표준공제   --
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- 차감소득금액 --
           
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT  -- 개인연금 
           --, NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT  -- 2014-세액공제 이동 
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT            -- 투자조합 
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- 외국 근로자 소득 --
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT            -- 신용카드 
           --, NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT    -- 2014-세액공제 이동 
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                                      -- 2014-그밖의소득공제(우리사주조합기부금)
           , NVL(HA.INVEST_AMT_14, 0) AS INVEST_AMT_14                                     -- 2014-투자조합출자금액  14년
           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT           -- 2014-장기집합투자증권저축
            
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT  -- 고용유지중소기업근로자소득공제
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + NVL(HA.DONAT_DED_30, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) +
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)
               ) AS TOT_ETC_DED_AMT   -- 그밖의 소득공제 합계 금액 --
               
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT            -- 과세표준 
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT          -- 산출세액 
          
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + 
             NVL(HA.TR_SMALL_BUSINESS_50, 0) AS TAX_SMALL_REDU_SP_LAW_AMT              -- 2014-세감 ( 중소기업취업청년)           
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT
           , (NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + 
             NVL(HA.TR_SMALL_BUSINESS_50, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0))AS TAX_REDU_SUM  -- 세액감면 합계 
           
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT  -- 근로소득공제 
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT  -- 납세조합 
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 주택차입금 
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- 
           --, NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- 정치자금 기부금(2014 사용 안함)            
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 외국납부 
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
               NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) + 
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_STAND_DED_AMT, 0) + 
               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)) AS TAX_DED_SUM  -- 세액공제 합계 
           
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- 결정세액
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- 원단위 절사.
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) + NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
           , ( NVL(HPW1.IN_TAX_AMT, 0) + NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0)) AS PRE1_IN_TAX_AMT
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0)) AS PRE1_LOCAL_TAX_AMT
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_SP_TAX_AMT
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS PRE1_TAX_SUM
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- 차감 소득세
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- 차감 주민세
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- 차감 농특세
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) + 
               NVL(HA.LONG_HOUSE_ITR_15_15_FIX_1, 0) + NVL(HA.LONG_HOUSE_ITR_15_15_FIX_2, 0) + 
               NVL(HA.LONG_HOUSE_ITR_15_15_ETC, 0) + NVL(HA.LONG_HOUSE_ITR_15_10_FIX_2, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- 주택마련저축소득공제 --
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT  -- 사용 안함 
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013년 추가 --
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
           
           
           -- 2014년 추가 -- 
           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT                  -- 2014-세공 자녀양육 인원수 
           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT                  -- 2014-세공 자녀양육 공제금액     
           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT              -- 2014-세공 6세이하 인원수 
           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT              -- 2014-세공 6세이하 공제금액
           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                              -- 2014-세공 출생/입양 인원수 
           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                              -- 2014-세공 출생/입양 공제금액 
           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                    -- 2014-세공 과학기술인공제 대상
           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT            -- 2014-세공 과학기술인공제 세액
           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                -- 2014-세공 근로자 퇴직연금 대상
           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT        -- 2014-세공 근로자 퇴직연금 세액 
           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                              -- 2014-세공 연금저축 대상
           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                      -- 2014-세공 연금저축 세액 
           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                   -- 2014-세공 보장성보험 대상            
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT           -- 2014-세공 보장성보험 세액공제 
           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                      -- 2014-세공 의료비 대상금액            
           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TAX_DED_MEDIC_AMT                             -- 2014-세공 의료비 세액공제
           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                              -- 2014-세공 교유비 대상금액 
           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TAX_DED_EDUCATION_AMT                     -- 2014-세공 교육비 세액공제 
           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                          -- 2014-세공 정치자금기부금 대상(10만원 이하) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                  -- 2014-세공 정치자금 기부금 세액공제(10만원 이하) 
           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                          -- 2014-세공 정치자금기부금 대상(10만원 초과) 
           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                  -- 2014-세공 정치자금기부금 세액공제(10만원 초과) 
           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                          -- 2014-세공 법정기부금 대상
           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                  -- 2014-세공 법정기부금 세액공제
           , NVL(HA.TD_EMP_STOCK_DONAT_AMT, 0) AS TD_EMP_STOCK_DONAT_AMT                  -- 2015-세공 우리사주기부금 대상.
           , NVL(HA.TD_EMP_STOCK_DONAT_DED_AMT, 0) AS TD_EMP_STOCK_DONAT_DED_AMT          -- 2015-세공 우리사주기부금 세액공제.
           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                        -- 2014-세공 지정기부금 대상
           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                -- 2014-세공 지정기부금 세액공제
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_MEDIC_DED_AMT, 0) + 
               NVL(HA.TD_EDUCATION_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_EMP_STOCK_DONAT_DED_AMT, 0) + 
               NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS TD_SP_DED_TOTAL_AMT                 -- 2014-세공 특별세액공제 합계            
           , NVL(HA.TD_STAND_DED_AMT, 0) AS TD_STAND_DED_AMT                              -- 2014-세공 표준세액공제    
           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT                      -- 2014-세공 월세액 공제 대상
           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT              -- 2014-세공 월세액 공제금액            
        FROM HRA_YEAR_ADJUSTMENT HA
           , ( -- 종전 납부 세액
              SELECT HPW.YEAR_YYYY
                   , HPW.PERSON_ID
                   , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                   , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                   , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID 
               GROUP BY HPW.YEAR_YYYY, HPW.PERSON_ID
             ) HPW1
       WHERE HA.YEAR_YYYY = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID = HPW1.PERSON_ID(+)
         AND HA.YEAR_YYYY = V_YEAR_YYYY
         AND HA.PERSON_ID = W_PERSON_ID
         AND HA.SOB_ID    = W_SOB_ID 
         AND HA.SUBMIT_DATE BETWEEN V_START_DATE AND V_END_DATE
       ;

  END SELECT_YEAR_ADJUSTMENT_2014;

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회(2014).
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUST_SPREAD_14
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_YEAR_EMPLOYE_TYPE IN  VARCHAR2
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_AGE_STD_DATE      DATE;
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');
    V_AGE_STD_DATE := TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    OPEN P_CURSOR FOR
      SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
           , NVL(PM.NAME, NULL) AS NAME
           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
           , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
           , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
           -- 인적공제
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
           -- 연금보험료 공제
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
           
           -- 특별공제
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
           
           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
           
           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
           /*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*/
           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
           
          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
           
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
               END) +
               NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
               ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                       

           -- 차감소득금액
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
           -- 그밖의 소득공제
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
           /*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*/
           
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
           
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
           -- 특별공제 종합한도 초과액
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
           -- 종합소득 과세표준
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
           -- 산출세액
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
           -- 세액감면
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + 
             NVL(HA.TR_SMALL_BUSINESS_50, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
               NVL(HA.TAX_REDU_TAX_TREATY, 0) + 
               NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) + NVL(HA.TR_SMALL_BUSINESS_50, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
           -- 세액공제
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
           
           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
            
           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
            
           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
            
           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
            
           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
           
           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
           
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
           
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
           
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
               NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
             ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
           -- 결정세액
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
           -- (종전) 기납부 세액
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
           , ( NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
           -- (주현) 기납부 세액
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
               NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
               NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
               NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
           -- 차감 세액
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
               NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계
           -- 비과세 합계
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
               -- 종전--
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
           -- 비과세 상세
           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
           , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
           , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
           , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
           , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
           , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
           , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
           , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
           , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
           , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
           , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
           , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
           , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
           , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
           , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
           , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
           , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
           , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
           , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
           , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
           , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
           , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
           , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
           , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
           , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
           , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
           , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
           , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
           , NVL(HA.CLOSED_FLAG, NULL) AS CLOSED_FLAG
           , NVL(C_PM.NAME, NULL) AS CLOSED_PERSON_NAME
           
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER_V   PM
           , ( -- 종전 납부 세액
               SELECT HPW.YEAR_YYYY
                    , HPW.PERSON_ID
                    , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                    , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                    , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                FROM HRA_PREVIOUS_WORK HPW
               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                 AND HPW.PERSON_ID = W_PERSON_ID
                 AND HPW.SOB_ID    = W_SOB_ID
                 AND HPW.ORG_ID    = W_ORG_ID
               GROUP BY HPW.YEAR_YYYY
                      , HPW.PERSON_ID
             ) HPW1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                AND HH.CHARGE_SEQ           IN 
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       ) 
             ) T1
           , HRM_PERSON_MASTER C_PM
       WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
         AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
         AND HA.PERSON_ID           = PM.PERSON_ID
         AND PM.PERSON_ID           = T1.PERSON_ID
         AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
         AND HA.YEAR_YYYY           = V_YEAR_YYYY
         AND HA.SOB_ID              = W_SOB_ID
         AND HA.ORG_ID              = W_ORG_ID
         AND HA.SUBMIT_DATE         BETWEEN V_START_DATE AND V_END_DATE
         AND ((W_PERSON_ID          IS NULL AND 1 = 1)
         OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
         
         AND PM.JOIN_DATE           <= V_END_DATE
         AND (PM.RETIRE_DATE        >= V_START_DATE OR PM.RETIRE_DATE IS NULL)
         
         AND ((W_YEAR_EMPLOYE_TYPE  IS NULL AND 1 =1)
           OR (W_YEAR_EMPLOYE_TYPE  != '20' AND (PM.RETIRE_DATE > V_END_DATE OR PM.RETIRE_DATE IS NULL))
           OR (W_YEAR_EMPLOYE_TYPE  = '20' AND (PM.RETIRE_DATE BETWEEN V_START_DATE AND V_END_DATE)))
          
         AND ((W_POST_ID            IS NULL AND 1 = 1)
         OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
         AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
         OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
         AND ((W_DEPT_ID            IS NULL AND 1 = 1)
         OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
      ORDER BY T1.DEPT_CODE
             , T1.POST_SORT_NUM
             , HA.ADJUST_DATE_TO
             , PM.PERSON_NUM
       ;
  END SELECT_YEAR_ADJUST_SPREAD_14;

/*
-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_SPREAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_AGE_STD_DATE      DATE;
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');
    V_AGE_STD_DATE := TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD');
    
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.YEAR_YYYY
               ELSE NULL
             END AS YEAR_YYYY 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.NAME
               ELSE NULL
             END AS DIS_NAME 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.PERSON_NUM
               ELSE NULL
             END AS DIS_PERSON_NUM
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.REPRE_NUM
               ELSE NULL
             END AS REPRE_NUM 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.AGE
               ELSE NULL
             END AS AGE 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.DEPT_NAME
               ELSE NULL
             END AS DEPT_NAME 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.FLOOR_NAME
               ELSE NULL
             END AS FLOOR_NAME 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.JOIN_DATE
               ELSE NULL
             END AS JOIN_DATE 
           , CASE
               WHEN SX1.SORT_NUM = 1 THEN SX1.RETIRE_DATE
               ELSE NULL
             END AS RETIRE_DATE 
           , SX1.ADJUSTMENT_TYPE 
           , SX1.NOW_SUM_PAY  -- 주현
           , SX1.PRE_SUM_PAY  -- 종전
           , SX1.TOTAL_PAY         -- 총급여
           , SX1.INCOME_DED_AMT    -- 근로소득공제
           , SX1.INCOME_AMT  -- 근로소득금액
           -- 인적공제
           , SX1.PER_DED_AMT                      -- 본인
           , SX1.SPOUSE_DED_AMT                -- 배우자
           , SX1.SUPP_DED_COUNT                -- 부양가족 인원수
           , SX1.SUPP_DED_AMT                    -- 부양가족 공제금액
           , SX1.OLD_DED_COUNT1                -- 경로우대 인원수
           , SX1.OLD_DED_AMT1                    -- 경로우대 공제금액
           , SX1.DISABILITY_DED_COUNT    -- 장애인 인원수
           , SX1.DISABILITY_DED_AMT        -- 장애인 공제금액
           , SX1.WOMAN_DED_AMT                  -- 부녀자 공제금액
           , SX1.SINGLE_PARENT_DED_AMT  -- 한부모가족
           -- 연금보험료 공제
           , SX1.NATI_ANNU_AMT                  -- 국민연금보험료 공제
           , SX1.PUBLIC_INSUR_AMT            -- 공무원연금
           , SX1.MARINE_INSUR_AMT            -- 군인연금보험
           , SX1.SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
           , SX1.POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
           -- 특별공제
           , SX1.MEDIC_INSUR_AMT              -- 건강보험료
           , SX1.HIRE_INSUR_AMT                -- 고용보험료
                             
           , SX1.HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
           , SX1.HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
           , SX1.LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
           , SX1.LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
           , SX1.LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
           , SX1.LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
           , SX1.LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
           , SX1.FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
           , SX1.SP_DED_SUM_AMT                       -- 특별소득공제 계 

           -- 차감소득금액
           , SX1.SUBT_DED_AMT
           -- 그밖의 소득공제
           , SX1.PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
           , SX1.SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
           , SX1.HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
           , SX1.HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
           , SX1.WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
           , SX1.INVES_AMT                          -- 투자조합출자등 소득공제
                             
           , SX1.CREDIT_AMT                        -- 신용카드등 소득공제
           , SX1.EMPL_STOCK_AMT                -- 우리사주조합소득공제
           , SX1.DONAT_DED_30                    -- 우리사주조합기부금
           , SX1.HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
           , SX1.FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
           , SX1.LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
           , SX1.ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
           -- 특별공제 종합한도 초과액
           , SX1.SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
           -- 종합소득 과세표준
           , SX1.TAX_STD_AMT                      -- 종합소득 과세표준
           -- 산출세액
           , SX1.COMP_TAX_AMT                    -- 산출세액
           -- 세액감면
           , SX1.TAX_REDU_IN_LAW_AMT      -- 소득세법
           , SX1.TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
           , SX1.TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
           , SX1.TAX_REDU_TAX_TREATY      -- 조세조약
           , SX1.TAX_REDU_SUM_AMT      -- 세액감면 합계
           -- 세액공제
           , SX1.TAX_DED_INCOME_AMT        -- 세공-근로소득
           , SX1.TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
           , SX1.TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
           , SX1.TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
           , SX1.TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
           , SX1.TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
           , SX1.TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
           , SX1.TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
           , SX1.TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
           , SX1.TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
           , SX1.TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
           , SX1.TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
           , SX1.TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
           , SX1.TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
           , SX1.TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
           , SX1.TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
           , SX1.TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
           , SX1.TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
           , SX1.TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
           , SX1.TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
           , SX1.TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
           , SX1.TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
           , SX1.TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
           , SX1.TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
           , SX1.TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
           , SX1.TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
           , SX1.TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
           , SX1.SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
           , SX1.STAND_DED_AMT                                 -- 표준세액공제 
                             
           , SX1.TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
           , SX1.TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
           , SX1.TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
           , SX1.TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
           , SX1.TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
           , SX1.TAX_DED_SUM_AMT      -- 세액공제 합계
           , SX1.FIX_TAX_AMT                       -- 결정세액
           -- 결정세액
           , SX1.FIX_IN_TAX_AMT        -- 결정 소득세
           , SX1.FIX_LOCAL_TAX_AMT   -- 결정 주민세
           , SX1.FIX_SP_TAX_AMT         -- 결정 농특세
           , SX1.FIX_TAX_SUM_AMT     -- 결정 세액 합계
           -- (종전) 기납부 세액
           , SX1.PRE_IN_TAX_AMT           -- (종전) 소득세 합계
           , SX1.PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
           , SX1.PRE_SP_TAX_AMT           -- (종전) 농특세 합계
           , SX1.PRE_TAX_SUM_AMT       -- (종전) 세액 합계
           -- (주현) 기납부 세액
           , SX1.NOW_IN_TAX_AMT        -- (주현) 소득세
           , SX1.NOW_LOCAL_TAX_AMT  -- (주현) 주민세
           , SX1.NOW_SP_TAX_AMT        -- (주현) 농특세
           , SX1.NOW_TAX_SUM_AMT  -- (주현) 세액 합계
           -- 차감 세액
           , SX1.SUBT_IN_TAX_AMT       -- (차감) 소득세
           , SX1.SUBT_LOCAL_TAX_AMT -- (차감) 주민세
           , SX1.SUBT_SP_TAX_AMT       -- (차감) 농특세
           , SX1.SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
           -- 비과세 합계
           , SX1.NONTAX_TOT_AMT  -- 비과세 합계
           -- 비과세 상세
           , SX1.NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
           , SX1.NONTAX_OT_AMT
           , SX1.NONTAX_RESEA_AMT
           , SX1.NONTAX_ETC_AMT
           , SX1.NONTAX_BIRTH_AMT
           , SX1.NONTAX_FOREIGNER_AMT
           , SX1.NONTAX_SCH_EDU_AMT
           , SX1.NONTAX_MEMBER_AMT
           , SX1.NONTAX_GUARD_AMT
           , SX1.NONTAX_CHILD_AMT
           , SX1.NONTAX_HIGH_SCH_AMT
           , SX1.NONTAX_SPECIAL_AMT
           , SX1.NONTAX_RESEARCH_AMT
           , SX1.NONTAX_COMPANY_AMT
           , SX1.NONTAX_COVER_AMT
           , SX1.NONTAX_WILD_AMT
           , SX1.NONTAX_DISASTER_AMT
           , SX1.NONTAX_OUTS_GOVER_AMT
           , SX1.NONTAX_OUTS_ARMY_AMT
           , SX1.NONTAX_OUTS_WORK_1
           , SX1.NONTAX_OUTS_WORK_2
           , SX1.NONTAX_STOCK_BENE_AMT
           , SX1.NONTAX_FOR_ENG_AMT
           , SX1.NONTAX_EMPL_STOCK_AMT
           , SX1.NONTAX_EMPL_BENE_AMT_1
           , SX1.NONTAX_EMPL_BENE_AMT_2
           , SX1.NONTAX_HOUSE_SUBSIDY_AMT
           , SX1.NONTAX_SEA_RESOURCE_AMT
           , SX1.NAME
           , SX1.PERSON_NUM
        FROM (SELECT T1.YEAR_YYYY
                   , T1.NAME
                   , T1.PERSON_NUM
                   , T1.REPRE_NUM
                   , T1.AGE
                   , T1.DEPT_NAME
                   , T1.FLOOR_NAME
                   , T1.JOIN_DATE
                   , T1.RETIRE_DATE
                   , T1.ADJUSTMENT_TYPE 
                   , T1.NOW_SUM_PAY  -- 주현
                   , T1.PRE_SUM_PAY  -- 종전
                   , T1.TOTAL_PAY         -- 총급여
                   , T1.INCOME_DED_AMT    -- 근로소득공제
                   , T1.INCOME_AMT  -- 근로소득금액
                   -- 인적공제
                   , T1.PER_DED_AMT                      -- 본인
                   , T1.SPOUSE_DED_AMT                -- 배우자
                   , T1.SUPP_DED_COUNT                -- 부양가족 인원수
                   , T1.SUPP_DED_AMT                    -- 부양가족 공제금액
                   , T1.OLD_DED_COUNT1                -- 경로우대 인원수
                   , T1.OLD_DED_AMT1                    -- 경로우대 공제금액
                   , T1.DISABILITY_DED_COUNT    -- 장애인 인원수
                   , T1.DISABILITY_DED_AMT        -- 장애인 공제금액
                   , T1.WOMAN_DED_AMT                  -- 부녀자 공제금액
                   , T1.SINGLE_PARENT_DED_AMT  -- 한부모가족
                   -- 연금보험료 공제
                   , T1.NATI_ANNU_AMT                  -- 국민연금보험료 공제
                   , T1.PUBLIC_INSUR_AMT            -- 공무원연금
                   , T1.MARINE_INSUR_AMT            -- 군인연금보험
                   , T1.SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                   , T1.POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
                   -- 특별공제
                   , T1.MEDIC_INSUR_AMT              -- 건강보험료
                   , T1.HIRE_INSUR_AMT                -- 고용보험료
                             
                   , T1.HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                   , T1.HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
                   , T1.LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                   , T1.LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                   , T1.LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                   , T1.LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                   , T1.LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                   , T1.FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
                   , T1.SP_DED_SUM_AMT                       -- 특별소득공제 계 

                   -- 차감소득금액
                   , T1.SUBT_DED_AMT
                   -- 그밖의 소득공제
                   , T1.PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                   , T1.SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                   , T1.HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                   , T1.HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                   , T1.WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                   , T1.INVES_AMT                          -- 투자조합출자등 소득공제
                             
                   , T1.CREDIT_AMT                        -- 신용카드등 소득공제
                   , T1.EMPL_STOCK_AMT                -- 우리사주조합소득공제
                   , T1.DONAT_DED_30                    -- 우리사주조합기부금
                   , T1.HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                   , T1.FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                   , T1.LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
                   , T1.ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                   -- 특별공제 종합한도 초과액
                   , T1.SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                   -- 종합소득 과세표준
                   , T1.TAX_STD_AMT                      -- 종합소득 과세표준
                   -- 산출세액
                   , T1.COMP_TAX_AMT                    -- 산출세액
                   -- 세액감면
                   , T1.TAX_REDU_IN_LAW_AMT      -- 소득세법
                   , T1.TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                   , T1.TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                   , T1.TAX_REDU_TAX_TREATY      -- 조세조약
                   , T1.TAX_REDU_SUM_AMT      -- 세액감면 합계
                   -- 세액공제
                   , T1.TAX_DED_INCOME_AMT        -- 세공-근로소득
                   , T1.TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                   , T1.TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                   , T1.TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                   , T1.TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                   , T1.TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                   , T1.TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
                   , T1.TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                   , T1.TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                   , T1.TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                   , T1.TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                   , T1.TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                   , T1.TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
                   , T1.TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                   , T1.TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
                   , T1.TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                   , T1.TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
                   , T1.TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                   , T1.TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
                   , T1.TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                   , T1.TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                   , T1.TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                   , T1.TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                   , T1.TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                   , T1.TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                   , T1.TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                   , T1.TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
                   , T1.SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
                   , T1.STAND_DED_AMT                                 -- 표준세액공제 
                             
                   , T1.TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                   , T1.TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                   , T1.TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                   , T1.TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                   , T1.TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
                   , T1.TAX_DED_SUM_AMT      -- 세액공제 합계
                   , T1.FIX_TAX_AMT                       -- 결정세액
                   -- 결정세액
                   , T1.FIX_IN_TAX_AMT        -- 결정 소득세
                   , T1.FIX_LOCAL_TAX_AMT   -- 결정 주민세
                   , T1.FIX_SP_TAX_AMT         -- 결정 농특세
                   , T1.FIX_TAX_SUM_AMT     -- 결정 세액 합계
                   -- (종전) 기납부 세액
                   , T1.PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                   , T1.PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                   , T1.PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                   , T1.PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                   -- (주현) 기납부 세액
                   , T1.NOW_IN_TAX_AMT        -- (주현) 소득세
                   , T1.NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                   , T1.NOW_SP_TAX_AMT        -- (주현) 농특세
                   , T1.NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                   -- 차감 세액
                   , T1.SUBT_IN_TAX_AMT       -- (차감) 소득세
                   , T1.SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                   , T1.SUBT_SP_TAX_AMT       -- (차감) 농특세
                   , T1.SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                   -- 비과세 합계
                   , T1.NONTAX_TOT_AMT  -- 비과세 합계
                   -- 비과세 상세
                   , T1.NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                   , T1.NONTAX_OT_AMT
                   , T1.NONTAX_RESEA_AMT
                   , T1.NONTAX_ETC_AMT
                   , T1.NONTAX_BIRTH_AMT
                   , T1.NONTAX_FOREIGNER_AMT
                   , T1.NONTAX_SCH_EDU_AMT
                   , T1.NONTAX_MEMBER_AMT
                   , T1.NONTAX_GUARD_AMT
                   , T1.NONTAX_CHILD_AMT
                   , T1.NONTAX_HIGH_SCH_AMT
                   , T1.NONTAX_SPECIAL_AMT
                   , T1.NONTAX_RESEARCH_AMT
                   , T1.NONTAX_COMPANY_AMT
                   , T1.NONTAX_COVER_AMT
                   , T1.NONTAX_WILD_AMT
                   , T1.NONTAX_DISASTER_AMT
                   , T1.NONTAX_OUTS_GOVER_AMT
                   , T1.NONTAX_OUTS_ARMY_AMT
                   , T1.NONTAX_OUTS_WORK_1
                   , T1.NONTAX_OUTS_WORK_2
                   , T1.NONTAX_STOCK_BENE_AMT
                   , T1.NONTAX_FOR_ENG_AMT
                   , T1.NONTAX_EMPL_STOCK_AMT
                   , T1.NONTAX_EMPL_BENE_AMT_1
                   , T1.NONTAX_EMPL_BENE_AMT_2
                   , T1.NONTAX_HOUSE_SUBSIDY_AMT
                   , T1.NONTAX_SEA_RESOURCE_AMT
                   , T1.SORT_NUM 
                FROM (SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                           , NVL(PM.NAME, NULL) AS NAME
                           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                           , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                           , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                           , '기처리내역' AS ADJUSTMENT_TYPE              
                           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                           -- 인적공제
                           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                           -- 연금보험료 공제
                           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
                           -- 특별공제
                           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                             
                           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
                           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                           \*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*\
                           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
                          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                             
                           , ((CASE
                                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                               END) +
                               NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                               ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                         

                           -- 차감소득금액
                           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                           -- 그밖의 소득공제
                           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                           \*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*\
                             
                           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
                           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                           -- 특별공제 종합한도 초과액
                           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                           -- 종합소득 과세표준
                           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                           -- 산출세액
                           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                           -- 세액감면
                           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                           -- 세액공제
                           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                           , 0 AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                           , 0 AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                           , 0 AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                           , 0 AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                           , 0 AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
                           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
                           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
                           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
                           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
                           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
                           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                             
                           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
                           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                             ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                           -- 결정세액
                           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                           -- (종전) 기납부 세액
                           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                           , ( NVL(HPW1.IN_TAX_AMT, 0) +
                               NVL(HPW1.LOCAL_TAX_AMT, 0) +
                               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                           -- (주현) 기납부 세액
                           , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                               NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                               NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                           , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                               NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                           -- 차감 세액
                           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                               NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                           -- 비과세 합계
                           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                               NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                               NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                               NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                               NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                               NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                               NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                               NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                               NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                               NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                               NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                               NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                               NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                               -- 종전--
                               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                               NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                               NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                               NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                               NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                               NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                               NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                               NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                               NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                               NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                               NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                           -- 비과세 상세
                           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                           , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                           , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                           , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                           , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                           , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                           , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                           , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                           , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                           , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                           , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                           , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                           , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                           , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                           , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                           , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                           , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                           , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                           , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                           , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                           , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                           , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                           , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                           , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                           , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                           , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                           , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                           , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
                           , 1 AS SORT_NUM 
                        FROM HRA_YEAR_ADJUSTMENT_1505 HA
                           , HRM_PERSON_MASTER_V      PM
                           , ( -- 종전 납부 세액
                               SELECT HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                                    , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                    , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                    , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                                FROM HRA_PREVIOUS_WORK HPW
                               WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                                 AND ((W_PERSON_ID IS NULL AND 1 = 1)
                                 OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                                 AND HPW.SOB_ID    = W_SOB_ID
                                 AND HPW.ORG_ID    = W_ORG_ID
                               GROUP BY HPW.YEAR_YYYY
                                      , HPW.PERSON_ID
                             ) HPW1
                           , (-- 시점 인사내역.
                              SELECT  HL.PERSON_ID
                                    , HL.DEPT_ID
                                    , DM.DEPT_CODE
                                    , DM.DEPT_NAME
                                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                                AND HH.CHARGE_SEQ           IN 
                                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                          FROM HRM_HISTORY_HEADER S_HH
                                             , HRM_HISTORY_LINE   S_HL
                                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                                         GROUP BY S_HL.PERSON_ID
                                       ) 
                             ) T1
                           , HRM_PERSON_MASTER C_PM
                       WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                         AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                         AND HA.PERSON_ID           = PM.PERSON_ID
                         AND PM.PERSON_ID           = T1.PERSON_ID
                         AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                         AND HA.YEAR_YYYY           = V_YEAR_YYYY
                         AND HA.CORP_ID             = W_CORP_ID 
                         AND HA.SOB_ID              = W_SOB_ID
                         AND HA.ORG_ID              = W_ORG_ID
                         AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                         AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                         OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                         
                         AND PM.CORP_ID             = W_CORP_ID
                         AND PM.SOB_ID              = W_SOB_ID
                         AND PM.ORG_ID              = W_ORG_ID  
                         AND PM.JOIN_DATE           <= V_END_DATE
                         AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                            
                         AND ((W_POST_ID            IS NULL AND 1 = 1)
                         OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                         AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                         OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                         AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                         OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
                      ---------
                      UNION ALL
                      ---------
                      SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                           , NVL(PM.NAME, NULL) AS NAME
                           , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                           , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                           , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                           , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                           , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                           , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                           , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                           , '재정산내역' AS ADJUSTMENT_TYPE 
                           , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                               NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                               NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                           -- 인적공제
                           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                           -- 연금보험료 공제
                           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                             
                           -- 특별공제
                           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                             
                           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                             
                           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                           \*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*\
                           , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                             
                          --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                             
                           , ((CASE
                                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                               END) +
                               NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                               NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                               NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                               NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                               ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                         

                           -- 차감소득금액
                           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                           -- 그밖의 소득공제
                           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                           \*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*\
                             
                           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                           , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                             
                           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                               NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                               NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                               NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                               NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                           -- 특별공제 종합한도 초과액
                           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                           -- 종합소득 과세표준
                           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                           -- 산출세액
                           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                           -- 세액감면
                           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                           -- 세액공제
                           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                           , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                           , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                           , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                           , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                           , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                           , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                             
                           , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                           , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                           , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                           , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                           , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                           , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                              
                           , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
                               NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                              
                           , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                           , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                              
                           , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                           , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                              
                           , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                           , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                           , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                           , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                           , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                           , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                             
                           , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                             
                           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                             
                           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                           , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                           , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                             
                           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                               NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
                               NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                               NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                               NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                               NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                               NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                               NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                               NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                             ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                           -- 결정세액
                           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                           , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                               NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                           -- (종전) 기납부 세액
                           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                           , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                         -- (주현) 기납부 세액
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                         -- 차감 세액
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                         -- 비과세 합계
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                             NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                             NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                             NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                             NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                             NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                             NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                             NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                             -- 종전--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                             NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                             NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                             NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                             NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                             NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                             NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                             NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                             NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                             NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                         -- 비과세 상세
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                         , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                         , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                         , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                         , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                         , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                         , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                         , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                         , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                         , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                         , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                         , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                         , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                         , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                         , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                         , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                         , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                         , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                         , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                         , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                         , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                         , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                         , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                         , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                         , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                         , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
                         , 2 AS SORT_NUM 
                      FROM HRA_YEAR_ADJUSTMENT HA
                         , HRM_PERSON_MASTER_V   PM
                         , ( -- 종전 납부 세액
                             SELECT HPW.YEAR_YYYY
                                  , HPW.PERSON_ID
                                  , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                  , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                  , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK HPW
                             WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                               AND ((W_PERSON_ID IS NULL AND 1 = 1)
                               OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                               AND HPW.SOB_ID    = W_SOB_ID
                               AND HPW.ORG_ID    = W_ORG_ID
                             GROUP BY HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                           ) HPW1
                         , (-- 시점 인사내역.
                            SELECT  HL.PERSON_ID
                                  , HL.DEPT_ID
                                  , DM.DEPT_CODE
                                  , DM.DEPT_NAME
                                  , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                              AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     ) 
                           ) T1
                         , HRM_PERSON_MASTER C_PM
                     WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                       AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                       AND HA.PERSON_ID           = PM.PERSON_ID
                       AND PM.PERSON_ID           = T1.PERSON_ID
                       AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                       AND HA.YEAR_YYYY           = V_YEAR_YYYY
                       AND HA.CORP_ID             = W_CORP_ID 
                       AND HA.SOB_ID              = W_SOB_ID
                       AND HA.ORG_ID              = W_ORG_ID
                       AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                       AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                       OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                       
                       AND PM.CORP_ID             = W_CORP_ID
                       AND PM.SOB_ID              = W_SOB_ID
                       AND PM.ORG_ID              = W_ORG_ID                          
                       AND PM.JOIN_DATE           <= V_END_DATE
                       AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                          
                       AND ((W_POST_ID            IS NULL AND 1 = 1)
                       OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                       AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                       OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                       AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                       OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))       
                  ) T1
            ---------     
            UNION ALL
            ---------
            SELECT T2.YEAR_YYYY
                 , T2.NAME
                 , T2.PERSON_NUM
                 , T2.REPRE_NUM
                 , T2.AGE
                 , T2.DEPT_NAME
                 , T2.FLOOR_NAME
                 , T2.JOIN_DATE
                 , T2.RETIRE_DATE
                 , '차감내역' AS ADJUSTMENT_TYPE 
                 , SUM(NVL(T2.NOW_SUM_PAY, 0) * T2.SIGN_FLAG) AS NOW_SUM_PAY  -- 주현
                 , SUM(NVL(T2.PRE_SUM_PAY, 0) * T2.SIGN_FLAG) AS PRE_SUM_PAY  -- 종전
                 , SUM(NVL(T2.TOTAL_PAY, 0) * T2.SIGN_FLAG) AS TOTAL_PAY         -- 총급여
                 , SUM(NVL(T2.INCOME_DED_AMT, 0) * T2.SIGN_FLAG) AS INCOME_DED_AMT    -- 근로소득공제
                 , SUM(NVL(T2.INCOME_AMT, 0) * T2.SIGN_FLAG) AS INCOME_AMT  -- 근로소득금액
                 -- 인적공제
                 , SUM(NVL(T2.PER_DED_AMT, 0) * T2.SIGN_FLAG) AS PER_DED_AMT                      -- 본인
                 , SUM(NVL(T2.SPOUSE_DED_AMT, 0) * T2.SIGN_FLAG) AS SPOUSE_DED_AMT                -- 배우자
                 , SUM(NVL(T2.SUPP_DED_COUNT, 0) * T2.SIGN_FLAG) AS SUPP_DED_COUNT                -- 부양가족 인원수
                 , SUM(NVL(T2.SUPP_DED_AMT, 0) * T2.SIGN_FLAG) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                 , SUM(NVL(T2.OLD_DED_COUNT1, 0) * T2.SIGN_FLAG) AS OLD_DED_COUNT1                -- 경로우대 인원수
                 , SUM(NVL(T2.OLD_DED_AMT1, 0) * T2.SIGN_FLAG) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                 , SUM(NVL(T2.DISABILITY_DED_COUNT, 0) * T2.SIGN_FLAG) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                 , SUM(NVL(T2.DISABILITY_DED_AMT, 0) * T2.SIGN_FLAG) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                 , SUM(NVL(T2.WOMAN_DED_AMT, 0) * T2.SIGN_FLAG) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                 , SUM(NVL(T2.SINGLE_PARENT_DED_AMT, 0) * T2.SIGN_FLAG) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                 -- 연금보험료 공제
                 , SUM(NVL(T2.NATI_ANNU_AMT, 0) * T2.SIGN_FLAG) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                 , SUM(NVL(T2.PUBLIC_INSUR_AMT, 0) * T2.SIGN_FLAG) AS PUBLIC_INSUR_AMT            -- 공무원연금
                 , SUM(NVL(T2.MARINE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS MARINE_INSUR_AMT            -- 군인연금보험
                 , SUM(NVL(T2.SCHOOL_STAFF_INSUR_AMT, 0) * T2.SIGN_FLAG) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                 , SUM(NVL(T2.POST_OFFICE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                           
                 -- 특별공제
                 , SUM(NVL(T2.MEDIC_INSUR_AMT, 0) * T2.SIGN_FLAG) AS MEDIC_INSUR_AMT              -- 건강보험료
                 , SUM(NVL(T2.HIRE_INSUR_AMT, 0) * T2.SIGN_FLAG) AS HIRE_INSUR_AMT                -- 고용보험료
                           
                 , SUM(NVL(T2.HOUSE_INTER_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                 , SUM(NVL(T2.HOUSE_INTER_AMT_ETC, 0) * T2.SIGN_FLAG) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                           
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_1, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_2, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_3_FIX, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                 , SUM(NVL(T2.LONG_HOUSE_PROF_AMT_3_ETC, 0) * T2.SIGN_FLAG) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                 , SUM(NVL(T2.FORWARD_DONATION_AMT, 0) * T2.SIGN_FLAG) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                           
                 , SUM(NVL(T2.SP_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 

                 -- 차감소득금액
                 , SUM(NVL(T2.SUBT_DED_AMT, 0) * T2.SIGN_FLAG) AS SUBT_DED_AMT
                 -- 그밖의 소득공제
                 , SUM(NVL(T2.PERS_ANNU_BANK_AMT, 0) * T2.SIGN_FLAG) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                 , SUM(NVL(T2.SMALL_CORPOR_DED_AMT, 0) * T2.SIGN_FLAG) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                 , SUM(NVL(T2.HOUSE_APP_DEPOSIT_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                 , SUM(NVL(T2.HOUSE_APP_SAVE_AMT, 0) * T2.SIGN_FLAG) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                 , SUM(NVL(T2.WORKER_HOUSE_SAVE_AMT, 0) * T2.SIGN_FLAG) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                 , SUM(NVL(T2.INVES_AMT, 0) * T2.SIGN_FLAG) AS INVES_AMT                          -- 투자조합출자등 소득공제
                           
                 , SUM(NVL(T2.CREDIT_AMT, 0) * T2.SIGN_FLAG) AS CREDIT_AMT                        -- 신용카드등 소득공제
                 , SUM(NVL(T2.EMPL_STOCK_AMT, 0) * T2.SIGN_FLAG) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                 , SUM(NVL(T2.DONAT_DED_30, 0) * T2.SIGN_FLAG) AS DONAT_DED_30                    -- 우리사주조합기부금
                 , SUM(NVL(T2.HIRE_KEEP_EMPLOY_AMT, 0) * T2.SIGN_FLAG) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                 , SUM(NVL(T2.FIX_LEASE_DED_AMT, 0) * T2.SIGN_FLAG) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                 , SUM(NVL(T2.LONG_SET_INVEST_SAVING_AMT, 0) * T2.SIGN_FLAG) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                           
                 , SUM(NVL(T2.ETC_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                 -- 특별공제 종합한도 초과액
                 , SUM(NVL(T2.SP_DED_TOT_AMT, 0) * T2.SIGN_FLAG) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                 -- 종합소득 과세표준
                 , SUM(NVL(T2.TAX_STD_AMT, 0) * T2.SIGN_FLAG) AS TAX_STD_AMT                      -- 종합소득 과세표준
                 -- 산출세액
                 , SUM(NVL(T2.COMP_TAX_AMT, 0) * T2.SIGN_FLAG) AS COMP_TAX_AMT                    -- 산출세액
                 -- 세액감면
                 , SUM(NVL(T2.TAX_REDU_IN_LAW_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                 , SUM(NVL(T2.TAX_REDU_SP_LAW_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                 , SUM(NVL(T2.TAX_REDU_SP_LAW_AMT_1, 0) * T2.SIGN_FLAG) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                 , SUM(NVL(T2.TAX_REDU_TAX_TREATY, 0) * T2.SIGN_FLAG) AS TAX_REDU_TAX_TREATY      -- 조세조약
                 , SUM(NVL(T2.TAX_REDU_SUM_AMT, 0) * T2.SIGN_FLAG) AS TAX_REDU_SUM_AMT            -- 세액감면 합계
                 -- 세액공제
                 , SUM(NVL(T2.TAX_DED_INCOME_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                 , SUM(NVL(T2.TD_CHILD_RAISE_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                 , SUM(NVL(T2.TD_CHILD_RAISE_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                 , SUM(NVL(T2.TD_CHILD_6_UNDER_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                 , SUM(NVL(T2.TD_CHILD_6_UNDER_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                 , SUM(NVL(T2.TD_BIRTH_DED_CNT, 0) * T2.SIGN_FLAG) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                 , SUM(NVL(T2.TD_BIRTH_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                           
                 , SUM(NVL(T2.TD_SCIENTIST_ANNU_AMT, 0) * T2.SIGN_FLAG) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                 , SUM(NVL(T2.TD_SCIENTIST_ANNU_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_SCIENTIST_ANNU_DED_AMT                   -- 2014-과학기술인 세액공제
                 , SUM(NVL(T2.TD_WORKER_RETR_ANNU_AMT, 0) * T2.SIGN_FLAG) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                 , SUM(NVL(T2.TD_WORKER_RETR_ANNU_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                 , SUM(NVL(T2.TD_ANNU_BANK_AMT, 0) * T2.SIGN_FLAG) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                 , SUM(NVL(T2.TD_ANNU_BANK_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                            
                 , SUM(NVL(T2.TD_GUAR_INSUR_AMT, 0) * T2.SIGN_FLAG) AS TD_GUAR_INSUR_AMT                          -- 2014-세감 ( 보장성보험 공제금액)
                 , SUM(NVL(T2.TD_GUAR_INSUR_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_GUAR_INSUR_DED_AMT                  -- 2014-세감 ( 보장성보험 세액공제)
                            
                 , SUM(NVL(T2.TD_MEDIC_AMT, 0) * T2.SIGN_FLAG) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                 , SUM(NVL(T2.TD_MEDIC_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                            
                 , SUM(NVL(T2.TD_EDUCATION_AMT, 0) * T2.SIGN_FLAG) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                 , SUM(NVL(T2.TD_EDUCATION_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                            
                 , SUM(NVL(T2.TD_POLI_DONAT_AMT1, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_AMT1                                  -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                 , SUM(NVL(T2.TD_POLI_DONAT_DED_AMT1, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_DED_AMT1                          -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                 , SUM(NVL(T2.TD_POLI_DONAT_AMT2, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                 , SUM(NVL(T2.TD_POLI_DONAT_DED_AMT2, 0) * T2.SIGN_FLAG) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                 , SUM(NVL(T2.TD_LEGAL_DONAT_AMT, 0) * T2.SIGN_FLAG) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                 , SUM(NVL(T2.TD_LEGAL_DONAT_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                 , SUM(NVL(T2.TD_DESIGN_DONAT_AMT, 0) * T2.SIGN_FLAG) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                 , SUM(NVL(T2.TD_DESIGN_DONAT_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                           
                 , SUM(NVL(T2.SP_TAX_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                           
                 , SUM(NVL(T2.STAND_DED_AMT, 0) * T2.SIGN_FLAG) AS STAND_DED_AMT                                 -- 표준세액공제 
                           
                 , SUM(NVL(T2.TAX_DED_TAXGROUP_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                 , SUM(NVL(T2.TAX_DED_HOUSE_DEBT_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                 , SUM(NVL(T2.TAX_DED_OUTSIDE_PAY_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                 , SUM(NVL(T2.TD_HOUSE_MONTHLY_AMT, 0) * T2.SIGN_FLAG) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                 , SUM(NVL(T2.TD_HOUSE_MONTHLY_DED_AMT, 0) * T2.SIGN_FLAG) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                           
                 , SUM(NVL(T2.TAX_DED_SUM_AMT, 0) * T2.SIGN_FLAG) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                 , SUM(NVL(T2.FIX_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_TAX_AMT                      -- 결정세액
                 -- 결정세액
                 , SUM(NVL(T2.FIX_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_IN_TAX_AMT        -- 결정 소득세
                 , SUM(NVL(T2.FIX_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                 , SUM(NVL(T2.FIX_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS FIX_SP_TAX_AMT         -- 결정 농특세
                 , SUM(NVL(T2.FIX_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                 -- (종전) 기납부 세액
                 , SUM(NVL(T2.PRE_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                 , SUM(NVL(T2.PRE_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                 , SUM(NVL(T2.PRE_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                 , SUM(NVL(T2.PRE_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                 -- (주현) 기납부 세액
                 , SUM(NVL(T2.NOW_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                 , SUM(NVL(T2.NOW_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                 , SUM(NVL(T2.NOW_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                 , SUM(NVL(T2.NOW_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                 -- 차감 세액
                 , SUM(NVL(T2.SUBT_IN_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                 , SUM(NVL(T2.SUBT_LOCAL_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                 , SUM(NVL(T2.SUBT_SP_TAX_AMT, 0) * T2.SIGN_FLAG) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                 , SUM(NVL(T2.SUBT_TAX_SUM_AMT, 0) * T2.SIGN_FLAG) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                 -- 비과세 합계
                 , SUM(NVL(T2.NONTAX_TOT_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_TOT_AMT  -- 비과세 합계
                 -- 비과세 상세
                 , SUM(NVL(T2.NONTAX_OUTSIDE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                 , SUM(NVL(T2.NONTAX_OT_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OT_AMT
                 , SUM(NVL(T2.NONTAX_RESEA_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_RESEA_AMT
                 , SUM(NVL(T2.NONTAX_ETC_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_ETC_AMT
                 , SUM(NVL(T2.NONTAX_BIRTH_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_BIRTH_AMT
                 , SUM(NVL(T2.NONTAX_FOREIGNER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_FOREIGNER_AMT
                 , SUM(NVL(T2.NONTAX_SCH_EDU_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_SCH_EDU_AMT
                 , SUM(NVL(T2.NONTAX_MEMBER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_MEMBER_AMT
                 , SUM(NVL(T2.NONTAX_GUARD_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_GUARD_AMT
                 , SUM(NVL(T2.NONTAX_CHILD_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_CHILD_AMT
                 , SUM(NVL(T2.NONTAX_HIGH_SCH_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_HIGH_SCH_AMT
                 , SUM(NVL(T2.NONTAX_SPECIAL_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_SPECIAL_AMT
                 , SUM(NVL(T2.NONTAX_RESEARCH_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_RESEARCH_AMT
                 , SUM(NVL(T2.NONTAX_COMPANY_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_COMPANY_AMT
                 , SUM(NVL(T2.NONTAX_COVER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_COVER_AMT
                 , SUM(NVL(T2.NONTAX_WILD_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_WILD_AMT
                 , SUM(NVL(T2.NONTAX_DISASTER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_DISASTER_AMT
                 , SUM(NVL(T2.NONTAX_OUTS_GOVER_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_GOVER_AMT
                 , SUM(NVL(T2.NONTAX_OUTS_ARMY_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_ARMY_AMT
                 , SUM(NVL(T2.NONTAX_OUTS_WORK_1, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_WORK_1
                 , SUM(NVL(T2.NONTAX_OUTS_WORK_2, 0) * T2.SIGN_FLAG) AS NONTAX_OUTS_WORK_2
                 , SUM(NVL(T2.NONTAX_STOCK_BENE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_STOCK_BENE_AMT
                 , SUM(NVL(T2.NONTAX_FOR_ENG_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_FOR_ENG_AMT
                 , SUM(NVL(T2.NONTAX_EMPL_STOCK_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_EMPL_STOCK_AMT
                 , SUM(NVL(T2.NONTAX_EMPL_BENE_AMT_1, 0) * T2.SIGN_FLAG) AS NONTAX_EMPL_BENE_AMT_1
                 , SUM(NVL(T2.NONTAX_EMPL_BENE_AMT_2, 0) * T2.SIGN_FLAG) AS NONTAX_EMPL_BENE_AMT_2
                 , SUM(NVL(T2.NONTAX_HOUSE_SUBSIDY_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_HOUSE_SUBSIDY_AMT
                 , SUM(NVL(T2.NONTAX_SEA_RESOURCE_AMT, 0) * T2.SIGN_FLAG) AS NONTAX_SEA_RESOURCE_AMT
                 , 3 AS SORT_NUM 
              FROM (SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                         , NVL(PM.NAME, NULL) AS NAME
                         , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                         , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                         , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                         , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                         , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                         , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                         , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                         , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                             NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                             NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                         , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                         , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                         , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                         , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                         -- 인적공제
                         , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                         , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                         , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                         , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                         , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                         , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                         , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                         , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                         , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                         , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                         -- 연금보험료 공제
                         , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                         , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                         , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                         , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                         , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                           
                         -- 특별공제
                         , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                         , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                           
                         , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                         , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                           
                         , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                         , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                         , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                         \*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*\
                         , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                           
                        --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                           
                         , ((CASE
                               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                               ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                             END) +
                             NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                             NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                             NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                             NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                             NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                             ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                       

                         -- 차감소득금액
                         , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                         -- 그밖의 소득공제
                         , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                         , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                         , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                         , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                         , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                         , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                         \*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*\
                           
                         , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                         , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                         , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                         , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                         , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                         , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                           
                         , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                             NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                             NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                             NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                         -- 특별공제 종합한도 초과액
                         , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                         -- 종합소득 과세표준
                         , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                         -- 산출세액
                         , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                         -- 세액감면
                         , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                         , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                         , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                         , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                         , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                             NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                         -- 세액공제
                         , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                         , 0 AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                         , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                         , 0 AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                         , 0 AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                         , 0 AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                         , 0 AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                           
                         , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                         , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                         , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                         , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                         , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                         , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                            
                         , ( NVL(HA.TD_GUAR_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                            
                         , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                         , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                            
                         , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                         , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                            
                         , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                         , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                         , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                         , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                           
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                           
                         , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                           
                         , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                         , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                         , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                         , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                         , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                           
                         , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                             NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                             NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                             NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                           ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                         , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                         -- 결정세액
                         , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                         , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                         , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                         , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                             NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                             NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                         -- (종전) 기납부 세액
                         , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                         , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                         , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                         , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                         -- (주현) 기납부 세액
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                         -- 차감 세액
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                         -- 비과세 합계
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                             NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                             NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                             NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                             NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                             NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                             NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                             NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                             -- 종전--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                             NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                             NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                             NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                             NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                             NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                             NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                             NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                             NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                             NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                         -- 비과세 상세
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                         , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                         , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                         , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                         , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                         , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                         , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                         , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                         , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                         , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                         , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                         , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                         , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                         , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                         , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                         , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                         , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                         , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                         , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                         , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                         , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                         , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                         , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                         , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                         , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                         , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT
                         , 1 AS SIGN_FLAG  
                      FROM HRA_YEAR_ADJUSTMENT_1505 HA
                         , HRM_PERSON_MASTER_V      PM
                         , ( -- 종전 납부 세액
                             SELECT HPW.YEAR_YYYY
                                  , HPW.PERSON_ID
                                  , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                  , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                  , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK HPW
                             WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                               AND ((W_PERSON_ID IS NULL AND 1 = 1)
                               OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                               AND HPW.SOB_ID    = W_SOB_ID
                               AND HPW.ORG_ID    = W_ORG_ID
                             GROUP BY HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                           ) HPW1
                         , (-- 시점 인사내역.
                            SELECT  HL.PERSON_ID
                                  , HL.DEPT_ID
                                  , DM.DEPT_CODE
                                  , DM.DEPT_NAME
                                  , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                              AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     ) 
                           ) T1
                         , HRM_PERSON_MASTER C_PM
                     WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                       AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                       AND HA.PERSON_ID           = PM.PERSON_ID
                       AND PM.PERSON_ID           = T1.PERSON_ID
                       AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                       AND HA.YEAR_YYYY           = V_YEAR_YYYY
                       AND HA.CORP_ID             = W_CORP_ID 
                       AND HA.SOB_ID              = W_SOB_ID
                       AND HA.ORG_ID              = W_ORG_ID
                       AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                       AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                       OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                       
                       AND PM.CORP_ID             = W_CORP_ID
                       AND PM.SOB_ID              = W_SOB_ID
                       AND PM.ORG_ID              = W_ORG_ID  
                       AND PM.JOIN_DATE           <= V_END_DATE
                       AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                          
                       AND ((W_POST_ID            IS NULL AND 1 = 1)
                       OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                       AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                       OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                       AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                       OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
                    ---------
                    UNION ALL
                    ---------
                    SELECT NVL(HA.YEAR_YYYY, NULL) AS YEAR_YYYY
                         , NVL(PM.NAME, NULL) AS NAME
                         , NVL(PM.PERSON_NUM, NULL) AS PERSON_NUM
                         , NVL(PM.REPRE_NUM, NULL) AS REPRE_NUM
                         , NVL(EAPP_REGISTER_AGE_F(PM.REPRE_NUM, V_AGE_STD_DATE, 0), NULL) AS AGE
                         , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
                         , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME
                         , NVL(PM.JOIN_DATE, NULL) AS JOIN_DATE
                         , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE
                         , ( NVL(HA.NOW_PAY_TOT_AMT, 0) + NVL(HA.NOW_BONUS_TOT_AMT, 0) +
                             NVL(HA.NOW_ADD_BONUS_AMT, 0) + NVL(HA.NOW_STOCK_BENE_AMT, 0) +
                             NVL(HA.INCOME_OUTSIDE_AMT, 0) +
                             NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- 주현
                         , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
                             NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- 종전
                         , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- 총급여
                         , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- 근로소득공제
                         , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- 근로소득금액
                         -- 인적공제
                         , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- 본인
                         , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- 배우자
                         , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- 부양가족 인원수
                         , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- 부양가족 공제금액
                         , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- 경로우대 인원수
                         , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- 경로우대 공제금액
                         , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- 장애인 인원수
                         , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- 장애인 공제금액
                         , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- 부녀자 공제금액
                         , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- 한부모가족
                         -- 연금보험료 공제
                         , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- 국민연금보험료 공제
                         , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- 공무원연금
                         , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- 군인연금보험
                         , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- 사립학교 교직원연금
                         , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- 별정우체국연금
                           
                         -- 특별공제
                         , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- 건강보험료
                         , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- 고용보험료
                           
                         , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- 주택임차차입금원리금 상환액 - 대출기관
                         , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- 주택임차차입금원리금 상환액 - 거주자
                           
                         , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                         , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                         , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                         , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                         \*, ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- 장기주택저당 합계*\
                         , NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0) AS FORWARD_DONATION_AMT            -- 기부금(이월분)
                           
                        --, NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- 주택자금 합계
                           
                         , ((CASE
                               WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0)  < 0 THEN 0
                               ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) 
                             END) +
                             NVL(HA.HOUSE_INTER_AMT, 0) +            -- 주택임차차입금원리금 상환액 - 대출기관
                             NVL(HA.HOUSE_INTER_AMT_ETC, 0) +        -- 주택임차차입금원리금 상환액 - 거주자            
                             NVL(HA.LONG_HOUSE_PROF_AMT, 0) +        -- 장기주택저당차입금이자상환액 2011년 이전차입분 15년 미만
                             NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 15~29년
                             NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) +      -- 장기주택저당차입금이자상환액 2011년 이전차입분 30년 이상
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 고정금액 등
                             NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) +  -- 장기주택저당차입금이자상환액 2012년 이후 차입분 15년 이상 기타대출등
                             NVL(HA.DONAT_NEXT_ALL, 0) + NVL(HA.DONAT_NEXT_50, 0) + NVL(HA.DONAT_NEXT_30, 0) + NVL(HA.DONAT_NEXT_RELIGION_10, 0) + NVL(HA.DONAT_NEXT_10, 0)-- 기부금(이월분)
                             ) AS SP_DED_SUM_AMT                       -- 특별소득공제 계 
                                       

                         -- 차감소득금액
                         , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
                         -- 그밖의 소득공제
                         , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- 개인연금저축소득공제
                         , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- 소기업/소상공인 공제부금 소득공제
                         , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- 주택청약저축
                         , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- 주택청약종합저축
                         , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- 근로자주택마련저축
                         , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- 투자조합출자등 소득공제
                         \*, ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- 주택마련 저축소득공제 합계*\
                           
                         , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- 신용카드등 소득공제
                         , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- 우리사주조합소득공제
                         , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- 우리사주조합기부금
                         , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- 고용유지중소기업근로자
                         , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- 목돈안드는 전세이자상환액
                         , NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0) AS LONG_SET_INVEST_SAVING_AMT -- 장기집합투자증권저축
                           
                         , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) +
                             NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) +
                             NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) + NVL(HA.INVES_AMT, 0) +
                             NVL(HA.CREDIT_AMT, 0) + NVL(HA.EMPL_STOCK_AMT, 0) +
                             NVL(HA.DONAT_DED_30, 0) + NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) +
                             NVL(HA.FIX_LEASE_DED_AMT, 0) + NVL(HA.LONG_SET_INVEST_SAVING_AMT, 0)) AS ETC_DED_SUM_AMT   -- 그밖의 소득공제 합계 금액 --
                         -- 특별공제 종합한도 초과액
                         , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- 특별공제 종합한도 초과액
                         -- 종합소득 과세표준
                         , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- 종합소득 과세표준
                         -- 산출세액
                         , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- 산출세액
                         -- 세액감면
                         , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- 소득세법
                         , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- 조세특례 제한법
                         , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- 조세특례 제한법 제30조
                         , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- 조세조약
                         , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
                             NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- 세액감면 합계
                         -- 세액공제
                         , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- 세공-근로소득
                         , NVL(HA.TD_CHILD_RAISE_DED_CNT, 0) AS TD_CHILD_RAISE_DED_CNT  -- 세공-자녀양육 인원수 
                         , NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) AS TD_CHILD_RAISE_DED_AMT  -- 세공-자녀양육 금액 
                         , NVL(HA.TD_CHILD_6_UNDER_DED_CNT, 0) AS TD_CHILD_6_UNDER_DED_CNT  -- 세공-자녀 6세이하 인원수 
                         , NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) AS TD_CHILD_6_UNDER_DED_AMT  -- 세공-자녀6세이하 금액 
                         , NVL(HA.TD_BIRTH_DED_CNT, 0) AS TD_BIRTH_DED_CNT                  -- 세공-자녀 출생/입양 인원수 
                         , NVL(HA.TD_BIRTH_DED_AMT, 0) AS TD_BIRTH_DED_AMT                  -- 세공-자녀 출생/입양 금액 
                           
                         , NVL(HA.TD_SCIENTIST_ANNU_AMT, 0) AS TD_SCIENTIST_ANNU_AMT                            -- 2014-과학기술인 공제금액
                         , NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) AS TD_SCIENTIST_ANNU_DED_AMT                    -- 2014-과학기술인 세액공제
                         , NVL(HA.TD_WORKER_RETR_ANNU_AMT, 0) AS TD_WORKER_RETR_ANNU_AMT                        -- 2014-퇴직연금  공제금액
                         , NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) AS TD_WORKER_RETR_ANNU_DED_AMT                -- 2014-퇴직연금 세액공제
                         , NVL(HA.TD_ANNU_BANK_AMT, 0) AS TD_ANNU_BANK_AMT                                      -- 2014-연금저축 공제금액
                         , NVL(HA.TD_ANNU_BANK_DED_AMT, 0) AS TD_ANNU_BANK_DED_AMT                              -- 2014-연금저축 세액공제
                            
                         , ( NVL(HA.TD_GUAR_INSUR_AMT, 0) + 
                             NVL(HA.TD_DISABILITY_INSUR_AMT, 0)) AS TD_GUAR_INSUR_AMT                           -- 2014-세감 ( 보장성보험 공제금액)
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0)) AS TD_GUAR_INSUR_DED_AMT                   -- 2014-세감 ( 보장성보험 세액공제)
                            
                         , NVL(HA.TD_MEDIC_AMT, 0) AS TD_MEDIC_AMT                                              -- 2014-세감 (의료비 공제금액)
                         , NVL(HA.TD_MEDIC_DED_AMT, 0) AS TD_MEDIC_DED_AMT                                      -- 2014-세감 (의료비 세액공제)
                            
                         , NVL(HA.TD_EDUCATION_AMT, 0) AS TD_EDUCATION_AMT                                      -- 2014-세감 (교육비 공제금액)
                         , NVL(HA.TD_EDUCATION_DED_AMT, 0) AS TD_EDUCATION_DED_AMT                              -- 2014-세감 (교육비 세액공제) 
                            
                         , NVL(HA.TD_POLI_DONAT_AMT1, 0) AS TD_POLI_DONAT_AMT1                                       -- 2014-세감 (정치자금기부금-10만원이하) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) AS TD_POLI_DONAT_DED_AMT1                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_POLI_DONAT_AMT2, 0) AS TD_POLI_DONAT_AMT2                                       -- 2014-세감 (정치자금기부금-10만원초과) 공제금액
                         , NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) AS TD_POLI_DONAT_DED_AMT2                                 -- 2014-세감 (정치자금기부금-10만원이하) 세액공제
                         , NVL(HA.TD_LEGAL_DONAT_AMT, 0) AS TD_LEGAL_DONAT_AMT                                       -- 2014-세감 (법정기부금) 공제금액
                         , NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) AS TD_LEGAL_DONAT_DED_AMT                                 -- 2014-세감 (법정기부금) 세액공제
                         , NVL(HA.TD_DESIGN_DONAT_AMT, 0) AS TD_DESIGN_DONAT_AMT                                    -- 2014-세감 (지정기부금) 공제금액
                         , NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) AS TD_DESIGN_DONAT_DED_AMT                               -- 2014-세감 (지정기부금) 세액공제
                           
                         , ( NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0)) AS SP_TAX_DED_SUM_AMT      -- 특별 세액  공제 
                           
                         , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                                 -- 표준세액공제 
                           
                         , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- 세공 - 납세조합
                         , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- 세공 - 주택차입금
                         , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- 세공 - 외국납부
                         , NVL(HA.TD_HOUSE_MONTHLY_AMT, 0) AS TD_HOUSE_MONTHLY_AMT        -- 세공 월세공제 대상 
                         , NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0) AS TD_HOUSE_MONTHLY_DED_AMT   -- 세공 월세공제 세액 
                           
                         , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TD_CHILD_RAISE_DED_AMT, 0) + 
                             NVL(HA.TD_CHILD_6_UNDER_DED_AMT, 0) + NVL(HA.TD_BIRTH_DED_AMT, 0) + 
                             NVL(HA.TD_SCIENTIST_ANNU_DED_AMT, 0) + NVL(HA.TD_WORKER_RETR_ANNU_DED_AMT, 0) + 
                             NVL(HA.TD_ANNU_BANK_DED_AMT, 0) + 
                             NVL(HA.TD_GUAR_INSUR_DED_AMT, 0) + NVL(HA.TD_DISABILITY_INSUR_DED_AMT, 0) + 
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_EDUCATION_DED_AMT, 0) +
                             NVL(HA.TD_POLI_DONAT_DED_AMT1, 0) + NVL(HA.TD_POLI_DONAT_DED_AMT2, 0) +
                             NVL(HA.TD_LEGAL_DONAT_DED_AMT, 0) + NVL(HA.TD_DESIGN_DONAT_DED_AMT, 0) +
                             NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + 
                             NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) + NVL(HA.TD_HOUSE_MONTHLY_DED_AMT, 0)
                           ) AS TAX_DED_SUM_AMT      -- 세액공제 합계
                         , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- 결정세액
                         -- 결정세액
                         , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- 결정 소득세
                         , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- 결정 주민세
                         , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- 결정 농특세
                         , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                             NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                             NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- 결정 세액 합계
                         -- (종전) 기납부 세액
                         , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (종전) 소득세 합계
                         , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (종전) 주민세 합계
                         , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (종전) 농특세 합계
                         , ( NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (종전) 세액 합계
                         -- (주현) 기납부 세액
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
                             NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (주현) 소득세
                         , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
                             NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (주현) 주민세
                         , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
                             NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (주현) 농특세
                         , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
                             NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
                             NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (주현) 세액 합계
                         -- 차감 세액
                         , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (차감) 소득세
                         , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (차감) 주민세
                         , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (차감) 농특세
                         , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                             NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                             NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (차감) 세액 합계          
                         -- 비과세 합계
                         , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                             NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                             NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                             NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                             NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                             NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                             NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                             NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                             NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                             NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                             NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                             -- 종전--
                             NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                             NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                             NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                             NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                             NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                             NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                             NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                             NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                             NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                             NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                             NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                             NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                             NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- 비과세 합계
                         -- 비과세 상세
                         , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- 비과세 국외근로 합계
                         , (NVL(HA.NONTAX_OT_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0)) AS NONTAX_OT_AMT
                         , (NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.PRE_NT_RESEA_AMT, 0)) AS NONTAX_RESEA_AMT
                         , (NVL(HA.NONTAX_ETC_AMT, 0)+ NVL(HA.PRE_NT_ETC_AMT, 0)) AS NONTAX_ETC_AMT
                         , (NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.PRE_NT_BIRTH_AMT, 0)) AS NONTAX_BIRTH_AMT
                         , (NVL(HA.NONTAX_FOREIGNER_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0)) AS NONTAX_FOREIGNER_AMT
                         , (NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_SCH_EDU_AMT, 0)) AS NONTAX_SCH_EDU_AMT
                         , (NVL(HA.NONTAX_MEMBER_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0)) AS NONTAX_MEMBER_AMT
                         , (NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.PRE_NT_GUARD_AMT, 0)) AS NONTAX_GUARD_AMT
                         , (NVL(HA.NONTAX_CHILD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0)) AS NONTAX_CHILD_AMT
                         , (NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_HIGH_SCH_AMT, 0)) AS NONTAX_HIGH_SCH_AMT
                         , (NVL(HA.NONTAX_SPECIAL_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0)) AS NONTAX_SPECIAL_AMT
                         , (NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_RESEARCH_AMT, 0)) AS NONTAX_RESEARCH_AMT
                         , (NVL(HA.NONTAX_COMPANY_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0)) AS NONTAX_COMPANY_AMT
                         , (NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.PRE_NT_COVER_AMT, 0)) AS NONTAX_COVER_AMT
                         , (NVL(HA.NONTAX_WILD_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0)) AS NONTAX_WILD_AMT
                         , (NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.PRE_NT_DISASTER_AMT, 0)) AS NONTAX_DISASTER_AMT
                         , (NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0)) AS NONTAX_OUTS_GOVER_AMT
                         , (NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0)) AS NONTAX_OUTS_ARMY_AMT
                         , (NVL(HA.NONTAX_OUTS_WORK_1, 0) + NVL(HA.PRE_NT_OUTS_WORK_1, 0)) AS NONTAX_OUTS_WORK_1
                         , (NVL(HA.NONTAX_OUTS_WORK_2, 0) + NVL(HA.PRE_NT_OUTS_WORK_2, 0)) AS NONTAX_OUTS_WORK_2
                         , (NVL(HA.NONTAX_STOCK_BENE_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0)) AS NONTAX_STOCK_BENE_AMT
                         , (NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_FOR_ENG_AMT, 0)) AS NONTAX_FOR_ENG_AMT
                         , (NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0)) AS NONTAX_EMPL_STOCK_AMT
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0)) AS NONTAX_EMPL_BENE_AMT_1
                         , (NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0)) AS NONTAX_EMPL_BENE_AMT_2
                         , (NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0)) AS NONTAX_HOUSE_SUBSIDY_AMT
                         , (NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_SEA_RESOURCE_AMT 
                         , -1 AS SIGN_FLAG  
                      FROM HRA_YEAR_ADJUSTMENT HA
                         , HRM_PERSON_MASTER_V   PM
                         , ( -- 종전 납부 세액
                             SELECT HPW.YEAR_YYYY
                                  , HPW.PERSON_ID
                                  , SUM(HPW.IN_TAX_AMT) AS IN_TAX_AMT
                                  , SUM(HPW.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
                                  , SUM(HPW.SP_TAX_AMT) AS SP_TAX_AMT
                              FROM HRA_PREVIOUS_WORK HPW
                             WHERE HPW.YEAR_YYYY = V_YEAR_YYYY
                               AND ((W_PERSON_ID IS NULL AND 1 = 1)
                               OR   (W_PERSON_ID IS NOT NULL AND HPW.PERSON_ID = W_PERSON_ID)) 
                               AND HPW.SOB_ID    = W_SOB_ID
                               AND HPW.ORG_ID    = W_ORG_ID
                             GROUP BY HPW.YEAR_YYYY
                                    , HPW.PERSON_ID
                           ) HPW1
                         , (-- 시점 인사내역.
                            SELECT  HL.PERSON_ID
                                  , HL.DEPT_ID
                                  , DM.DEPT_CODE
                                  , DM.DEPT_NAME
                                  , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                              AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= V_END_DATE 
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     ) 
                           ) T1
                         , HRM_PERSON_MASTER C_PM
                     WHERE HA.YEAR_YYYY           = HPW1.YEAR_YYYY(+)
                       AND HA.PERSON_ID           = HPW1.PERSON_ID(+)
                       AND HA.PERSON_ID           = PM.PERSON_ID
                       AND PM.PERSON_ID           = T1.PERSON_ID
                       AND HA.CLOSED_PERSON_ID    = C_PM.PERSON_ID(+)
                       AND HA.YEAR_YYYY           = V_YEAR_YYYY 
                       AND HA.CORP_ID             = W_CORP_ID
                       AND HA.SOB_ID              = W_SOB_ID
                       AND HA.ORG_ID              = W_ORG_ID
                       AND HA.SUBMIT_DATE         = V_END_DATE --TO_DATE('2014-12-31', 'YYYY-MM-DD') 
                       AND ((W_PERSON_ID          IS NULL AND 1 = 1)
                       OR   (W_PERSON_ID          IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
                       
                       AND PM.CORP_ID             = W_CORP_ID
                       AND PM.SOB_ID              = W_SOB_ID
                       AND PM.ORG_ID              = W_ORG_ID 
                       AND PM.JOIN_DATE           <= V_END_DATE
                       AND (PM.RETIRE_DATE        >= V_END_DATE OR PM.RETIRE_DATE IS NULL)
                          
                       AND ((W_POST_ID            IS NULL AND 1 = 1)
                       OR   (W_POST_ID            IS NOT NULL AND T1.POST_ID = W_POST_ID))
                       AND ((W_FLOOR_ID           IS NULL AND 1 = 1)
                       OR   (W_FLOOR_ID           IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
                       AND ((W_DEPT_ID            IS NULL AND 1 = 1)
                       OR   (W_DEPT_ID            IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))       
                  ) T2  
            GROUP BY T2.YEAR_YYYY
                   , T2.NAME
                   , T2.PERSON_NUM
                   , T2.REPRE_NUM
                   , T2.AGE
                   , T2.DEPT_NAME
                   , T2.FLOOR_NAME
                   , T2.JOIN_DATE
                   , T2.RETIRE_DATE
           ) SX1
      ORDER BY SX1.YEAR_YYYY
             , SX1.PERSON_NUM
             , SX1.SORT_NUM                 
      ;            
  END SELECT_YEAR_READJUST_SPREAD;

-------------------------------------------------------------------------------
-- 연말정산 내역 상세 조회 : 재정산 내역 
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_READJUST_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN  NUMBER 
            , W_STD_YYYYMM        IN  VARCHAR2
            , W_PERSON_ID         IN  NUMBER
            , W_POST_ID           IN  NUMBER
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE   := LAST_DAY(V_START_DATE);
    V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');
    
    OPEN P_CURSOR FOR 
      SELECT  T1.DEPT_NAME AS DEPT_NAME
            , T1.FLOOR_NAME
            , HA.PERSON_ID AS  PERSON_ID
            , PM.NAME AS NAME
            , PM.PERSON_NUM
            , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
              TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') APPLY_TERM
            , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM

            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +    -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.NONTAX_RESEA_AMT, 0) + NVL(HA.NONTAX_ETC_AMT, 0) +
                NVL(HA.NONTAX_BIRTH_AMT, 0) + NVL(HA.NONTAX_FOREIGNER_AMT, 0) +
                NVL(HA.NONTAX_SCH_EDU_AMT, 0) + NVL(HA.NONTAX_MEMBER_AMT, 0) +
                NVL(HA.NONTAX_GUARD_AMT, 0) + NVL(HA.NONTAX_CHILD_AMT, 0) +
                NVL(HA.NONTAX_HIGH_SCH_AMT, 0) + NVL(HA.NONTAX_SPECIAL_AMT, 0) +
                NVL(HA.NONTAX_RESEARCH_AMT, 0) + NVL(HA.NONTAX_COMPANY_AMT, 0) +
                NVL(HA.NONTAX_COVER_AMT, 0) + NVL(HA.NONTAX_WILD_AMT, 0) +
                NVL(HA.NONTAX_DISASTER_AMT, 0) + NVL(HA.NONTAX_OUTS_GOVER_AMT, 0) +
                NVL(HA.NONTAX_OUTS_ARMY_AMT, 0) + NVL(HA.NONTAX_STOCK_BENE_AMT, 0) +
                NVL(HA.NONTAX_FOR_ENG_AMT, 0) + NVL(HA.NONTAX_EMPL_STOCK_AMT, 0) +
                NVL(HA.NONTAX_EMPL_BENE_AMT_1, 0) + NVL(HA.NONTAX_EMPL_BENE_AMT_2, 0) +
                NVL(HA.NONTAX_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.NONTAX_SEA_RESOURCE_AMT, 0) +
                -- 종전--
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : 비과세 국외근로 합계
                NVL(HA.PRE_NT_RESEA_AMT, 0) + NVL(HA.PRE_NT_ETC_AMT, 0) +
                NVL(HA.PRE_NT_BIRTH_AMT, 0) + NVL(HA.PRE_NT_FOREIGNER_AMT, 0) +
                NVL(HA.PRE_NT_SCH_EDU_AMT, 0) + NVL(HA.PRE_NT_MEMBER_AMT, 0) +
                NVL(HA.PRE_NT_GUARD_AMT, 0) + NVL(HA.PRE_NT_CHILD_AMT, 0) +
                NVL(HA.PRE_NT_HIGH_SCH_AMT, 0) + NVL(HA.PRE_NT_SPECIAL_AMT, 0) +
                NVL(HA.PRE_NT_RESEARCH_AMT, 0) + NVL(HA.PRE_NT_COMPANY_AMT, 0) +
                NVL(HA.PRE_NT_COVER_AMT, 0) + NVL(HA.PRE_NT_WILD_AMT, 0) +
                NVL(HA.PRE_NT_DISASTER_AMT, 0) + NVL(HA.PRE_NT_OUTS_GOVER_AMT, 0) +
                NVL(HA.PRE_NT_OUTS_ARMY_AMT, 0) + NVL(HA.PRE_NT_STOCK_BENE_AMT, 0) +
                NVL(HA.PRE_NT_FOR_ENG_AMT, 0) + NVL(HA.PRE_NT_EMPL_STOCK_AMT, 0) +
                NVL(HA.PRE_NT_EMPL_BENE_AMT_1, 0) + NVL(HA.PRE_NT_EMPL_BENE_AMT_2, 0) +
                NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_PAY_SUM

            , NVL(HA.FIX_IN_TAX_AMT, 0) AS N_FIX_IN_TAX_AMT  -- 원단위 절사.
            , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS N_FIX_LOCAL_TAX_AMT
            , NVL(HA.FIX_SP_TAX_AMT, 0) AS N_FIX_SP_TAX_AMT
            , ( NVL(HA.FIX_IN_TAX_AMT, 0) +
                NVL(HA.FIX_LOCAL_TAX_AMT, 0) +
                NVL(HA.FIX_SP_TAX_AMT, 0)) AS N_FIX_TAX_SUM
            , NVL(SX1.FIX_IN_TAX_AMT, 0) AS O_FIX_IN_TAX_AMT
            , NVL(SX1.FIX_LOCAL_TAX_AMT, 0) AS O_FIX_LOCAL_TAX_AMT
            , NVL(SX1.FIX_SP_TAX_AMT, 0) AS O_FIX_SP_TAX_AMT
            , ( NVL(SX1.FIX_IN_TAX_AMT, 0) +
                NVL(SX1.FIX_LOCAL_TAX_AMT, 0) +
                NVL(SX1.FIX_SP_TAX_AMT, 0)) AS O_FIX_TAX_SUM
            , NVL(HA.PRE_IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT
            , NVL(HA.PRE_LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT
            , NVL(HA.PRE_SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT
            , ( NVL(HA.PRE_IN_TAX_AMT, 0) +
                NVL(HA.PRE_LOCAL_TAX_AMT, 0) +
                NVL(HA.PRE_SP_TAX_AMT, 0)) AS PRE_TAX_SUM

            , NVL(HA.SUBT_IN_TAX_AMT, 0) AS N_SUBT_IN_TAX_AMT
            , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS N_SUBT_LOCAL_TAX_AMT
            , NVL(HA.SUBT_SP_TAX_AMT, 0) AS N_SUBT_SP_TAX_AMT
            , ( NVL(HA.SUBT_IN_TAX_AMT, 0) +
                NVL(HA.SUBT_LOCAL_TAX_AMT, 0) +
                NVL(HA.SUBT_SP_TAX_AMT, 0)) AS N_SUBT_TAX_SUM
            , NVL(SX1.SUBT_IN_TAX_AMT, 0) AS O_SUBT_IN_TAX_AMT
            , NVL(SX1.SUBT_LOCAL_TAX_AMT, 0) AS O_SUBT_LOCAL_TAX_AMT
            , NVL(SX1.SUBT_SP_TAX_AMT, 0) AS O_SUBT_SP_TAX_AMT
            , ( NVL(SX1.SUBT_IN_TAX_AMT, 0) +
                NVL(SX1.SUBT_LOCAL_TAX_AMT, 0) +
                NVL(SX1.SUBT_SP_TAX_AMT, 0)) AS O_SUBT_TAX_SUM
            , (NVL(SX1.SUBT_IN_TAX_AMT, 0) - NVL(HA.SUBT_IN_TAX_AMT, 0)) AS G_SUBT_IN_TAX_AMT
            , (NVL(SX1.SUBT_LOCAL_TAX_AMT, 0) - NVL(HA.SUBT_LOCAL_TAX_AMT, 0)) AS G_SUBT_LOCAL_TAX_AMT
            , (NVL(SX1.SUBT_SP_TAX_AMT, 0) - NVL(HA.SUBT_SP_TAX_AMT, 0)) AS G_SUBT_SP_TAX_AMT
            , ((NVL(SX1.SUBT_IN_TAX_AMT, 0) - NVL(HA.SUBT_IN_TAX_AMT, 0)) +  
               (NVL(SX1.SUBT_LOCAL_TAX_AMT, 0) - NVL(HA.SUBT_LOCAL_TAX_AMT, 0)) + 
               (NVL(SX1.SUBT_SP_TAX_AMT, 0) - NVL(HA.SUBT_SP_TAX_AMT, 0))) AS G_SUBT_TAX_SUM 
            , CASE
                WHEN PM.RETIRE_DATE IS NULL THEN '계속근무'
                WHEN TO_DATE(V_YEAR_YYYY || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '계속근무'
                ELSE '중도퇴사'
              END AS EMPLOYEE_TYPE
            , PM.RETIRE_DATE
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , ( -- 기존 처리 내역 --
               SELECT HYA.PERSON_ID
                    , HYA.YEAR_YYYY
                    , HYA.SOB_ID
                    , HYA.ORG_ID
                    , HYA.FIX_IN_TAX_AMT
                    , HYA.FIX_LOCAL_TAX_AMT
                    , HYA.FIX_SP_TAX_AMT
                    , HYA.SUBT_IN_TAX_AMT
                    , HYA.SUBT_LOCAL_TAX_AMT
                    , HYA.SUBT_SP_TAX_AMT
                 FROM HRA_YEAR_ADJUSTMENT_1505 HYA
                WHERE HYA.CORP_ID             = W_CORP_ID 
                  AND HYA.YEAR_YYYY           = V_YEAR_YYYY
                  AND HYA.SOB_ID              = W_SOB_ID
                  AND HYA.ORG_ID              = W_ORG_ID
                  AND ((W_PERSON_ID           IS NULL AND 1 = 1)
                  OR   (W_PERSON_ID           IS NOT NULL AND HYA.PERSON_ID = W_PERSON_ID))
             ) SX1
           , (-- 시점 인사내역.
              SELECT  HL.PERSON_ID
                    , HL.DEPT_ID
                    , DM.DEPT_CODE
                    , DM.DEPT_NAME
                    , '1' || LPAD(TO_CHAR(DM.DEPT_SORT_NUM), 3, '0') AS DEPT_SORT_NUM
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
                AND HH.CHARGE_SEQ           IN
                      (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                          FROM HRM_HISTORY_HEADER S_HH
                             , HRM_HISTORY_LINE   S_HL
                         WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                           AND S_HH.CHARGE_DATE       <= V_END_DATE 
                           AND S_HL.PERSON_ID         = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                       )
            ) T1
      WHERE HA.PERSON_ID              = PM.PERSON_ID
        AND PM.PERSON_ID              = T1.PERSON_ID
        AND HA.PERSON_ID              = SX1.PERSON_ID
        AND HA.YEAR_YYYY              = SX1.YEAR_YYYY
        AND HA.SOB_ID                 = SX1.SOB_ID
        AND HA.ORG_ID                 = SX1.ORG_ID
        
        AND HA.CORP_ID                = W_CORP_ID
        AND HA.YEAR_YYYY              = V_YEAR_YYYY 
        AND ((W_PERSON_ID             IS NULL AND 1 = 1)
        OR   (W_PERSON_ID             IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID                 = W_SOB_ID
        AND HA.ORG_ID                 = W_ORG_ID
        AND HA.SUBMIT_DATE            = V_END_DATE
        AND NVL(HA.FIX_IN_TAX_AMT, 0) != NVL(SX1.FIX_IN_TAX_AMT, 0)
        AND ((W_DEPT_ID               IS NULL AND 1 = 1)
        OR   (W_DEPT_ID               IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID              IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID              IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
     ;
  END SELECT_YEAR_READJUST_LIST;
    */
END HRA_YEAR_ADJUSTMENT_G;
/
