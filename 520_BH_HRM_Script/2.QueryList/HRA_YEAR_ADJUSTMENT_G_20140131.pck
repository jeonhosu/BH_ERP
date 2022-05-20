CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUSTMENT_G
AS

-------------------------------------------------------------------------------
-- ������� ��ȸ -- 
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
-- �������� ��� SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_YEAR_ADJUSTMENT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );
            

-- �������� ��� : DELETE.
  PROCEDURE DELETE_YEAR_ADJUSTMENT
            ( W_STD_YYYYMM        IN VARCHAR2
            , W_PERSON_ID         IN HRA_YEAR_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );


-------------------------------------------------------------------------------
-- �������� ���� ���� / ���� ��� ������ ��ȸ --  
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
-- �������� ���� ���� ���� ��ȸ.  
-------------------------------------------------------------------------------  
  PROCEDURE TAX_SUMMERY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_STD_YYYYMM                        IN VARCHAR2
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- �������� ���� �޿����� / ������ ������ ��ȸ --  
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
-- �������� ���� ���� ���� �޿� ���� OR �������.  
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
-- �������� ���� ���� ���� �޿� ����.  
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
-- �������� ���� ����  �Ⱓ�� ���� ��ȸ.  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_TAX_SUMMERY
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_SUBMIT_YYYYMM_FR  IN  VARCHAR
            , W_SUBMIT_YYYYMM_TO  IN  VARCHAR
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            );

-------------------------------------------------------------------------------
-- �������� ���� �� ��ȸ. 
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
            
END HRA_YEAR_ADJUSTMENT_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUSTMENT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_YEAR_ADJUSTMENT_G
/* Description  : �������� ��� ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/
-------------------------------------------------------------------------------
-- ������� ��ȸ -- 
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
        , (-- ���� �λ系��.
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
        AND ((W_PERSON_ID           IS NULL AND 1 = 1)
          OR (W_PERSON_ID           IS NOT NULL AND PM.PERSON_ID = W_PERSON_ID))
        AND PM.JOIN_DATE            <= V_STD_DATE
        AND ((W_EMPLOYE_TYPE        IS NULL AND 1 = 1)
          OR (W_EMPLOYE_TYPE        != '3' AND (PM.RETIRE_DATE >= TRUNC(V_STD_DATE, 'MONTH') OR PM.RETIRE_DATE IS NULL))
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
-- �������� ��� SELECT.
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
               -- ����� 
               NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
               -- ����-- 
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS TOTAL_PAY   -- �ٷμҵ�(���� + �����) -- 
           , NVL(HA.NONTAX_OUTSIDE_AMT, 0) AS NONTAX_OUTSIDE_AMT
           , NVL(HA.NONTAX_OT_AMT, 0) AS NONTAX_OT_AMT
           , NVL(HA.NONTAX_RESEA_AMT, 0) AS NONTAX_RESEA_AMT
           , NVL(HA.NONTAX_ETC_AMT, 0) AS NONTAX_ETC_AMT
           , NVL(HA.NONTAX_BIRTH_AMT, 0) AS NONTAX_BIRTH_AMT
           , NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
               -- ����-- 
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
           , NVL(HA.INCOME_TOT_AMT, 0) AS INCOME_TOT_AMT  -- �ѱ޿� -- 
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT  -- �ٷμҵ� ���� -- 
           , (NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ� �ݾ� -- 
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
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT          -- ���ο��� -- 
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT        -- ���ݺ���� �հ� -- 
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT      -- �ǰ�����(�ǰ� + ����纸��) 
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT        -- ��뺸�� 
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT        -- ���庸�� 
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT  -- ����κ���  
             -- ����� �ݾ��� ������ ��쿡�� 0�� ���(�������� �����ä ��Ŀ� -���� ���� ����);
           , ( CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) AS ETC_INSURE_AMT  -- ��Ÿ����� �հ� -- 
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT  -- �Ƿ�� �հ� (����� + ��Ÿ)   
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT  -- ������(����� + ��Ÿ)  
           , (NVL(HA.HOUSE_INTER_AMT, 0) + NVL(HA.HOUSE_INTER_AMT_ETC, 0)) AS HOUSE_INTER_AMT  -- �����������Ա� ������ + ������  
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT
           , NVL(HA.DONAT_AMT, 0) AS DONAT_AMT  -- ��α� �հ�  
           , NVL(HA.MARRY_ETC_AMT, 0) AS MARRY_ETC_AMT
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) + 
               NVL(HA.MEDIC_AMT, 0) + NVL(HA.EDUCATION_AMT, 0) +  
               NVL(HA.HOUSE_FUND_AMT, 0) + -- �����ڱ�(�����������Ա� + ������ + ��������������Ա� + ��������)  
               NVL(HA.DONAT_AMT, 0) + 
               NVL(HA.MARRY_ETC_AMT, 0)) AS SP_DED_SUM  -- Ư������ �հ� -- 
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT  -- ǥ�ذ���   -- 
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT    -- �����ҵ�ݾ� -- 
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT
           , NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT
           , NVL(HA.FORE_INCOME_AMT, 0) AS FORE_INCOME_AMT  -- �ܱ� �ٷ��� �ҵ� -- 
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT
           , NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT           
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) + 
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) + 
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) + 
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0)) AS TOT_ETC_DED_AMT   -- �׹��� �ҵ���� �հ� �ݾ� -- 
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
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT  -- �������� 
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT           -- ������ ����.
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
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT           -- ���� �ҵ漼 
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT     -- ���� �ֹμ� 
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT           -- ���� ��Ư�� 
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + NVL(HA.SUBT_LOCAL_TAX_AMT, 0) + 
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM
           --, NVL(HA.NONTAX_FOREIGNER_AMT, 0) AS NONTAX_FOREIGNER_AMT
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + 
               NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + 
               NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_AMT
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) + 
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_AMT  -- ���ø�������ҵ���� -- 
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT
           , HA.CLOSED_FLAG
           , DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_DATE) AS CLOSED_DATE
           , ( SELECT PM.NAME
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID    = DECODE(HA.CLOSED_FLAG, 'Y', HA.CLOSED_PERSON_ID, -1)
             ) AS CLOSED_PERSON
           -- 2013�� �߰� -- 
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT 
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT
        FROM HRA_YEAR_ADJUSTMENT HA
           , ( -- ���� ���� ����
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

-- �������� ��� : DELETE.
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
         AND HA.CLOSED_FLAG       = 'N'  -- ���� �ȵ� �ڷḸ. 
       ;
    EXCEPTION
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001, 'Delete Error : Person ID - ' || W_PERSON_ID || CHR(10) || SQLERRM);
        RETURN;
    END;
  END DELETE_YEAR_ADJUSTMENT;
  
  
-------------------------------------------------------------------------------
-- �������� ���� ���� / ���� ��� ������ ��ȸ --  
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
            TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') AS APPLY_TERM  -- ����Ⱓ --
          , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT  -- ���� �ҵ漼 --
          , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT  -- ���� �ֹμ� --
          , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT  -- ���� ��Ư�� --
          , ( TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
              TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- ���� �հ� --
          , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
          , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
              -- ����-- 
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
          , TRUNC(NVL(HA.FIX_IN_TAX_AMT, 0), -1) AS FIX_IN_TAX_AMT  -- ������ ����.
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
              WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٹ�'
              WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '��ӱٹ�'
              ELSE '�ߵ����'
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
           , (-- ���� �λ系��.
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
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.YEAR_YYYY        = V_YEAR_YYYY        
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG      = W_CLOSED_FLAG  -- ���� ���� -- 
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
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
             , T1.FLOOR_SORT_NUM
      ;
  
  END SELECT_YEAR_ADJUSTMENT_CLOSED;


-------------------------------------------------------------------------------
-- �������� ���� ���� ���� ��ȸ.  
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
      SELECT  T1.DEPT_NAME AS DEPT_NAME
            , T1.FLOOR_NAME
            , HA.PERSON_ID AS  PERSON_ID
            , PM.NAME AS NAME
            , PM.PERSON_NUM
            , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
              TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') APPLY_TERM
            , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
             
            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +    -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
                -- ����-- 
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +   -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
             
            , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT  -- ������ ����.
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
                WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٹ�'
                WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '��ӱٹ�'
                ELSE '�ߵ����'
              END AS EMPLOYEE_TYPE 
            , PM.RETIRE_DATE
            , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(PM1.NAME, TO_CHAR(NULL)), NULL) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT HA
           , HRM_PERSON_MASTER   PM
           , HRM_PERSON_MASTER   PM1
           , (-- ���� �λ系��.
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
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.TRANS_PERSON_ID  = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY        = V_YEAR_YYYY
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
        AND ((W_DEPT_ID         IS NULL AND 1 = 1)
        OR   (W_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = W_DEPT_ID))
        AND ((W_FLOOR_ID        IS NULL AND 1 = 1)
        OR   (W_FLOOR_ID        IS NOT NULL AND T1.FLOOR_ID = W_FLOOR_ID))
        AND ((W_JOB_CATEGORY_ID IS NULL AND 1 = 1)
        OR   (W_JOB_CATEGORY_ID IS NOT NULL AND T1.JOB_CATEGORY_ID = W_JOB_CATEGORY_ID))
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
      ;
  
  END TAX_SUMMERY;


-------------------------------------------------------------------------------
-- �������� ���� �޿����� / ������ ������ ��ȸ --  
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
      SELECT  'N' AS SELECT_YN
            , HA.PERSON_ID AS  PERSON_ID
            , PM.NAME AS NAME
            , PM.PERSON_NUM
            , NVL(T1.DEPT_NAME, NULL) AS DEPT_NAME
            , NVL(T1.FLOOR_NAME, NULL) AS FLOOR_NAME          
            , TO_CHAR(HA.ADJUST_DATE_FR, 'YYYY-MM-DD') || ' ~ ' ||
              TO_CHAR(HA.ADJUST_DATE_TO, 'YYYY-MM-DD') AS APPLY_TERM  -- ����Ⱓ --
            , TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) AS SUBT_IN_TAX_AMT  -- ���� �ҵ漼 --
            , TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) AS SUBT_LOCAL_TAX_AMT  -- ���� �ֹμ� --
            , TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1) AS SUBT_SP_TAX_AMT  -- ���� ��Ư�� --
            , ( TRUNC(NVL(HA.SUBT_IN_TAX_AMT, 0), -1) +
                TRUNC(NVL(HA.SUBT_LOCAL_TAX_AMT, 0), -1) +
                TRUNC(NVL(HA.SUBT_SP_TAX_AMT, 0), -1)) AS SUBT_TAX_SUM   -- ���� �հ� --
            , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
               
            , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
                -- ����-- 
                NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
               
            , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT  -- ������ ����.
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
                WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٹ�'
                WHEN TO_DATE(TO_CHAR(V_END_DATE, 'YYYY') || '12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '��ӱٹ�'
                ELSE '�ߵ����'
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
           , (-- ���� �λ系��.
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
      WHERE HA.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.YEAR_YYYY        = V_YEAR_YYYY        
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID))
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
        AND HA.CLOSED_FLAG      = 'Y'  -- ���� ���� -- 
        AND HA.TRANS_YN         = W_TRANS_YN  -- �޿����� ���� --
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
      ORDER BY T1.DEPT_SORT_NUM
             , T1.DEPT_CODE
             , T1.FLOOR_SORT_NUM
      ;
  END SELECT_YEAR_ADJUSTMENT_PAYMENT;

-------------------------------------------------------------------------------
-- �������� ���� ���� ���� �޿� ���� OR �������.  
-- �޿����۽� ���곻���� �޻��߰����� �� �޻� ��� ������ ���� �ݿ�
-- �޻� ���� ���ص� �ݿ��ǰ� ó�� ����
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
    V_TRANS_COUNT         NUMBER;   -- ó�� Ƚ��  
    V_YEAR_YYYY           VARCHAR2(4);  
    V_START_DATE          DATE;
    V_END_DATE            DATE;
          
    V_ADD_DEDUCTION_ID    NUMBER;
    V_MONTH_PAYMENT_ID    NUMBER;
    V_IN_TAX_ID           NUMBER := NULL;    -- ����ҵ漼ID.
    V_LOCAL_TAX_ID        NUMBER := NULL;    -- �����ֹμ�ID.
    V_SP_TAX_ID           NUMBER := NULL;    -- ���� ��Ư��ID.
    
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
      -- �޿����� ó�� -- 
      FOR C1 IN ( SELECT HA.PERSON_ID AS PERSON_ID
                        , PM.NAME AS NAME
                        , PM.PERSON_NUM
                        , PM.CORP_ID
                        , PM.SOB_ID
                        , PM.ORG_ID 
                        , NVL(HA.INCOME_TOT_AMT, 0) AS TAX_PAY_SUM
                        , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
                            -- ����-- 
                            NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
                        -- ���� �޾� --
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
                    AND HA.CLOSED_FLAG      = 'Y'  -- ���� �ڷῡ ���� ó�� -- 
                    AND PM.JOIN_DATE        <= V_END_DATE
                    AND (PM.RETIRE_DATE     >= V_START_DATE OR PM.RETIRE_DATE IS NULL)
                    AND HA.SUBMIT_DATE      BETWEEN V_START_DATE AND V_END_DATE
                    AND HA.TRANS_YN         = P_TRANS_YN  -- �̹� ���۵� �ڷ�� ���� ���� --
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
        
        -- 0. �޻� ������ ���� ����  -- 
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
        -- 1.��ȣ�� �߰�(2013-01-10) : �����ڷ� ����(�λ��� ��û-��� UPDATE ����) --
        -- 2.��ȣ�� ����(2013-01-16) : ���� �޿������ ���� �������� ó�� �ڷ� ���� ���� --
        --                              ���۱޿������ ���� ������  
        DELETE FROM HRP_PAYMENT_ADD_DEDUCTION PAD
        WHERE PAD.PERSON_ID         = C1.PERSON_ID
          AND PAD.PAY_YYYYMM        = P_PAY_YYYYMM
          AND PAD.WAGE_TYPE         = P_WAGE_TYPE
          AND PAD.DEDUCTION_ID      IN(V_IN_TAX_ID, V_LOCAL_TAX_ID, V_SP_TAX_ID)
          AND PAD.SOB_ID            = P_SOB_ID
          AND PAD.ORG_ID            = P_ORG_ID
          AND PAD.CREATED_FLAG      = 'I'  -- �ڵ� ���� �ڷḸ ���� --
        ;*/
        
        IF C1.TRANS_YN = 'N' AND C1.EVENT_STATUS = 'OK' THEN
          -- ������ ������ : ���� ó�� --       
          -- �����ڷ� ���� -- 
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
          
          -- �޿����� INTERFACE�� ������ ����/���� -- 
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
              -- 1. �޻� �߰����� ���� INSERT.
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
                  , P_DESCRIPTION      => '�������� ����ݾ�'
                  , P_SOB_ID           => C1.SOB_ID
                  , P_ORG_ID           => C1.ORG_ID
                  , P_USER_ID          => C1.USER_ID
                  );
              EXCEPTION WHEN OTHERS THEN
                O_MESSAGE := 'Salary add deduction Insert error : ' || SUBSTR(SQLERRM, 1, 150);
                RETURN;  
              END;                              
              -- 2. �������� �޿����� INTERFACE UPDATE --
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
            
            -- 3-1. �޻� ��곻�� ������� ���� �ݿ� �� �Ѱ�����, �����޾� �ݿ� --
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

          -- 3-1. �޻� ��곻�� ������� ���� �ݿ� �� �Ѱ�����, �����޾� �ݿ� --
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
            -- �����޾� UPDATE : ���� ��� --
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
          
          -- �������� ���� TRANSFER_YN UPDATE --
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
        -- ���� ������ : ������ ó�� --       
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
            -- �޻� �����ݾ� ���� --       
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
            
            -- 1. �޻� �߰����� ���� INSERT.
            BEGIN
              HRP_PAYMENT_ADD_DEDUCTION_G.ADD_DEDUCTION_DELETE
                ( W_ADD_DEDUCTION_ID        => R1.ADD_DEDUCTION_ID
                );
            EXCEPTION WHEN OTHERS THEN
              O_MESSAGE := 'Salary add deduction delete error : ' || SUBSTR(SQLERRM, 1, 150);
              RETURN;  
            END;
                            
            -- 3. �������� �޿����� INTERFACE UPDATE --
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
            -- ���� �׸� �հ� UPDATE --
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
            -- �����޾� UPDATE : ���� ��� --
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
          
          -- �������� ���� TRANSFER_YN UPDATE --
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
-- �������� ���� ���� ���� �޿� ����.   
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
    V_IN_TAX_ID                   NUMBER := NULL;    -- ����ҵ漼ID.
    V_LOCAL_TAX_ID                NUMBER := NULL;    -- �����ֹμ�ID.
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
                    , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
                        -- ����-- 
                        NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�  
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
                  , (-- ���� �λ系��.
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
                AND (HA.TRANS_YN        IS NULL OR HA.TRANS_YN = 'N')  -- �̹� ���۵� �ڷ�� ���� ���� --
                AND ((P_DEPT_ID         IS NULL AND 1 = 1)
                OR   (P_DEPT_ID         IS NOT NULL AND T1.DEPT_ID = P_DEPT_ID))
             )
    LOOP
/*      -- 1.��ȣ�� �߰�(2013-01-10) : �����ڷ� ����(�λ��� ��û-��� UPDATE ����) --
      -- 2.��ȣ�� ����(2013-01-16) : ���� �޿������ ���� �������� ó�� �ڷ� ���� ���� --
      --                              ���۱޿������ ���� ������  
      DELETE FROM HRP_PAYMENT_ADD_DEDUCTION PAD
      WHERE PAD.PERSON_ID         = C1.PERSON_ID
        AND PAD.PAY_YYYYMM        = P_PAY_YYYYMM
        AND PAD.WAGE_TYPE         = P_WAGE_TYPE
        AND PAD.DEDUCTION_ID      IN(V_IN_TAX_ID, V_LOCAL_TAX_ID, V_SP_TAX_ID)
        AND PAD.SOB_ID            = P_SOB_ID
        AND PAD.ORG_ID            = P_ORG_ID
        AND PAD.CREATED_FLAG      = 'I'  -- �ڵ� ���� �ڷḸ ���� --
      ;*/
        
      IF NVL(C1.SUBT_IN_TAX_AMT, 0) <> 0 THEN
      -- ���� �ҵ漼 DELETE --
        -- ���� �ҵ漼 INSERT --
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
      -- ���� �ֹμ� DELETE --
        -- ���� �ֹμ� INSERT --
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
      -- ���� ��Ư�� DELETE --
        -- ���� �ֹμ� INSERT --
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
-- �������� ���� ����  �Ⱓ�� ���� ��ȸ.  
-------------------------------------------------------------------------------  
  PROCEDURE SELECT_TAX_SUMMERY
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN  NUMBER
            , W_SUBMIT_YYYYMM_FR  IN  VARCHAR
            , W_SUBMIT_YYYYMM_TO  IN  VARCHAR
            , W_DEPT_ID           IN  NUMBER
            , W_FLOOR_ID          IN  NUMBER
            , W_JOB_CATEGORY_ID   IN  NUMBER
            , W_PERSON_ID         IN  NUMBER
            , W_SOB_ID            IN  NUMBER
            , W_ORG_ID            IN  NUMBER
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
    V_SUBMIT_DATE_FR              DATE := TRUNC(TO_DATE(W_SUBMIT_YYYYMM_FR, 'YYYY-MM'), 'MONTH');
    V_SUBMIT_DATE_TO              DATE := LAST_DAY(TO_DATE(W_SUBMIT_YYYYMM_TO, 'YYYY-MM'));
    
  BEGIN
    V_YEAR_YYYY := TO_CHAR(V_SUBMIT_DATE_FR, 'YYYY');
        
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
            , SUM( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
                   -- ����-- 
                   NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�  
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
                   
            , SUM(NVL(HA.FIX_IN_TAX_AMT, 0)) AS FIX_IN_TAX_AMT  -- ������ ���� --
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
                WHEN PM.RETIRE_DATE IS NULL THEN '��ӱٹ�'
                WHEN TO_DATE(V_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') < PM.RETIRE_DATE THEN '��ӱٹ�'
                ELSE '�ߵ����'
              END AS EMPLOYEE_TYPE
            , NVL(PM.RETIRE_DATE, NULL) AS RETIRE_DATE 
            , NVL(HA.TRANS_YN, 'N') AS TRANS_YN
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_PAY_YYYYMM, TO_CHAR(NULL)), NULL) AS TRANS_PAY_YYYYMM
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(HA.TRANS_DATE, TO_DATE(NULL)), NULL) AS TRANS_DATE
            , DECODE(NVL(HA.TRANS_YN, 'N'), 'Y', NVL(PM1.NAME, TO_CHAR(NULL)), NULL) AS TRANS_BY
        FROM HRA_YEAR_ADJUSTMENT  HA
           , HRM_PERSON_MASTER    PM
           , HRM_PERSON_MASTER    PM1
           , (-- ���� �λ系��.
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
      WHERE HA.PERSON_ID        = PM.PERSON_ID 
        AND PM.PERSON_ID        = T1.PERSON_ID
        AND HA.TRANS_PERSON_ID  = PM1.PERSON_ID(+)
        AND HA.YEAR_YYYY        = V_YEAR_YYYY
        AND ((W_PERSON_ID       IS NULL AND 1 = 1)
        OR   (W_PERSON_ID       IS NOT NULL AND HA.PERSON_ID = W_PERSON_ID)) 
        AND HA.SOB_ID           = W_SOB_ID
        AND HA.ORG_ID           = W_ORG_ID
        AND HA.SUBMIT_DATE      BETWEEN V_SUBMIT_DATE_FR AND V_SUBMIT_DATE_TO
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
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


-------------------------------------------------------------------------------
-- �������� ���� �� ��ȸ. 
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
               NVL(HA.NOW_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.NOW_OFFICE_RETIRE_OVER_AMT, 0)) AS NOW_SUM_PAY  -- ����               
           , ( NVL(HA.PRE_PAY_TOT_AMT, 0) + NVL(HA.PRE_BONUS_TOT_AMT, 0) +
               NVL(HA.PRE_ADD_BONUS_AMT, 0) + NVL(HA.PRE_STOCK_BENE_AMT, 0) +
               NVL(HA.PRE_EMPLOYEE_STOCK_AMT, 0) + NVL(HA.PRE_OFFICE_RETIRE_OVER_AMT, 0)) AS PRE_SUM_PAY  -- ����             
           , NVL(HA.INCOME_TOT_AMT, 0) AS TOTAL_PAY         -- �ѱ޿� 
           , NVL(HA.INCOME_DED_AMT, 0) AS INCOME_DED_AMT    -- �ٷμҵ���� 
           , ( NVL(HA.INCOME_TOT_AMT, 0) - NVL(HA.INCOME_DED_AMT, 0)) AS INCOME_AMT  -- �ٷμҵ�ݾ� 
           -- ��������  
           , NVL(HA.PER_DED_AMT, 0) AS PER_DED_AMT                      -- ���� 
           , NVL(HA.SPOUSE_DED_AMT, 0) AS SPOUSE_DED_AMT                -- ����� 
           , NVL(HA.SUPP_DED_COUNT, 0) AS SUPP_DED_COUNT                -- �ξ簡�� �ο��� 
           , NVL(HA.SUPP_DED_AMT, 0) AS SUPP_DED_AMT                    -- �ξ簡�� �����ݾ� 
           , NVL(HA.OLD_DED_COUNT, 0) AS OLD_DED_COUNT                  -- ��ο�� �ο��� 
           , NVL(HA.OLD_DED_AMT, 0) AS OLD_DED_AMT                      -- ��ο�� �����ݾ� 
           , NVL(HA.OLD_DED_COUNT1, 0) AS OLD_DED_COUNT1                -- ��ο�� �ο��� 
           , NVL(HA.OLD_DED_AMT1, 0) AS OLD_DED_AMT1                    -- ��ο�� �����ݾ� 
           , NVL(HA.DISABILITY_DED_COUNT, 0) AS DISABILITY_DED_COUNT    -- ����� �ο��� 
           , NVL(HA.DISABILITY_DED_AMT, 0) AS DISABILITY_DED_AMT        -- ����� �����ݾ� 
           , NVL(HA.WOMAN_DED_AMT, 0) AS WOMAN_DED_AMT                  -- �γ��� �����ݾ� 
           , NVL(HA.CHILD_DED_COUNT, 0) AS CHILD_DED_COUNT              -- 6������  �ο��� 
           , NVL(HA.CHILD_DED_AMT, 0) AS CHILD_DED_AMT                  -- 6������ �����ݾ� 
           , NVL(HA.BIRTH_DED_COUNT, 0) AS BIRTH_DED_COUNT              -- ���/�Ծ��� �ο��� 
           , NVL(HA.BIRTH_DED_AMT, 0) AS BIRTH_DED_AMT                  -- ���/�Ծ��� �����ݾ� 
           , NVL(HA.SINGLE_PARENT_DED_AMT, 0) AS SINGLE_PARENT_DED_AMT  -- �Ѻθ��� 
           , NVL(HA.MANY_CHILD_DED_COUNT, 0) AS MANY_CHILD_DED_COUNT    -- ���ڳ� �ο��� 
           , NVL(HA.MANY_CHILD_DED_AMT, 0) AS MANY_CHILD_DED_AMT        -- ���ڳ� �����ݾ� 
           -- ���ݺ���� ���� 
           , NVL(HA.NATI_ANNU_AMT, 0) AS NATI_ANNU_AMT                  -- ���ο��ݺ���� ���� 
           , NVL(HA.PUBLIC_INSUR_AMT, 0) AS PUBLIC_INSUR_AMT            -- ���������� 
           , NVL(HA.MARINE_INSUR_AMT, 0) AS MARINE_INSUR_AMT            -- ���ο��ݺ��� 
           , NVL(HA.SCHOOL_STAFF_INSUR_AMT, 0) AS SCHOOL_STAFF_INSUR_AMT  -- �縳�б� ���������� 
           , NVL(HA.POST_OFFICE_INSUR_AMT, 0) AS POST_OFFICE_INSUR_AMT    -- ������ü������ 
           , NVL(HA.ANNU_INSUR_AMT, 0) AS ANNU_INSUR_AMT                -- ���ݺ���� �հ�            
           , NVL(HA.SCIENTIST_ANNU_AMT, 0) AS SCIENTIST_ANNU_AMT        -- ���б���ΰ���            
           , NVL(HA.RETR_ANNU_AMT, 0) AS RETR_ANNU_AMT                  -- �������� 
           , NVL(HA.ANNU_BANK_AMT, 0) AS ANNU_BANK_AMT                  -- �������� 
           -- Ư������ 
           , NVL(HA.MEDIC_INSUR_AMT, 0) AS MEDIC_INSUR_AMT              -- �ǰ������ 
           , NVL(HA.HIRE_INSUR_AMT, 0) AS HIRE_INSUR_AMT                -- ��뺸��� 
           , NVL(HA.GUAR_INSUR_AMT, 0) AS GUAR_INSUR_AMT                -- ���强 ����� 
           , NVL(HA.DISABILITY_INSUR_AMT, 0) AS DISABILITY_INSUR_AMT    -- ����� ���� ����� 
           , NVL(HA.DISABILITY_MEDIC_AMT, 0) AS DISABILITY_MEDIC_AMT    -- �Ƿ�� - �����  
           , NVL(HA.ETC_MEDIC_AMT, 0) AS ETC_MEDIC_AMT                  -- �Ƿ�� - ��Ÿ 
           , NVL(HA.MEDIC_AMT, 0) AS MEDIC_AMT                          -- �Ƿ�� ������  
           , NVL(HA.DISABILITY_EDUCATION_AMT, 0) AS DISABILITY_EDUCATION_AMT  -- ������ - ����� 
           , NVL(HA.ETC_EDUCATION_AMT, 0) AS ETC_EDUCATION_AMT                -- ������ - ��Ÿ 
           , NVL(HA.EDUCATION_AMT, 0) AS EDUCATION_AMT                        -- ������ ������            
           , NVL(HA.HOUSE_INTER_AMT, 0) AS HOUSE_INTER_AMT                    -- �����������Աݿ����� ��ȯ�� - ������  
           , NVL(HA.HOUSE_INTER_AMT_ETC, 0) AS HOUSE_INTER_AMT_ETC            -- �����������Աݿ����� ��ȯ�� - ������ 
           , NVL(HA.HOUSE_MONTHLY_AMT, 0) AS HOUSE_MONTHLY_AMT                -- ������ 
           , NVL(HA.LONG_HOUSE_PROF_AMT, 0) AS LONG_HOUSE_PROF_AMT            -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15�� �̸� 
           , NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) AS LONG_HOUSE_PROF_AMT_1        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 15~29�� 
           , NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) AS LONG_HOUSE_PROF_AMT_2        -- ��������������Ա����ڻ�ȯ�� 2011�� �������Ժ� 30�� �̻� 
           , NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) AS LONG_HOUSE_PROF_AMT_3_FIX  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� �����ݾ� �� 
           , NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0) AS LONG_HOUSE_PROF_AMT_3_ETC  -- ��������������Ա����ڻ�ȯ�� 2012�� ���� ���Ժ� 15�� �̻� ��Ÿ�����            
           , ( NVL(HA.LONG_HOUSE_PROF_AMT, 0) + 
               NVL(HA.LONG_HOUSE_PROF_AMT_1, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_2, 0) + 
               NVL(HA.LONG_HOUSE_PROF_AMT_3_FIX, 0) + NVL(HA.LONG_HOUSE_PROF_AMT_3_ETC, 0)) AS LONG_HOUSE_PROF_SUM_AMT  -- ����������� �հ� 
           , NVL(HA.HOUSE_FUND_AMT, 0) AS HOUSE_FUND_AMT                -- �����ڱ� �հ� 
           , NVL(HA.DONAT_DED_POLI_AMT, 0) AS DONAT_DED_POLI_AMT        -- ��ġ�ڱݱ�α� 
           , NVL(HA.DONAT_DED_ALL, 0) AS DONAT_DED_ALL                  -- ������α� 
           , NVL(HA.DONAT_DED_50, 0) AS DONAT_DED_50                    -- Ư����α� 
           , NVL(HA.DONAT_DED_30, 0) AS DONAT_DED_30                    -- �츮�������ձ�α� 
           , NVL(HA.DONAT_DED_RELIGION_10, 0) AS DONAT_DED_RELIGION_10  -- ������ü ��α� 
           , NVL(HA.DONAT_DED_10, 0) AS DONAT_DED_10                    -- ������ü�� ��α� 
           , NVL(HA.DONAT_AMT, 0) AS DONAT_AMT                          -- ��α� �հ�  
           , ((CASE
                 WHEN NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0) < 0 THEN 0
                 ELSE NVL(HA.MEDIC_INSUR_AMT, 0) + NVL(HA.HIRE_INSUR_AMT, 0) +
                      NVL(HA.GUAR_INSUR_AMT, 0) + NVL(HA.DISABILITY_INSUR_AMT, 0)
               END) + 
               NVL(HA.MEDIC_AMT, 0) + NVL(HA.EDUCATION_AMT, 0) +  
               NVL(HA.HOUSE_FUND_AMT, 0) + -- �����ڱ�(�����������Ա� + ������ + ��������������Ա� + ��������)  
               NVL(HA.DONAT_AMT, 0) + 
               NVL(HA.MARRY_ETC_AMT, 0)) AS SP_DED_SUM_AMT              -- Ư������ �հ� --                
           , NVL(HA.STAND_DED_AMT, 0) AS STAND_DED_AMT                  -- ǥ�ذ��� 
           -- �����ҵ�ݾ� 
           , NVL(HA.SUBT_DED_AMT, 0) AS SUBT_DED_AMT
           -- �׹��� �ҵ���� 
           , NVL(HA.PERS_ANNU_BANK_AMT, 0) AS PERS_ANNU_BANK_AMT        -- ���ο�������ҵ���� 
           , NVL(HA.SMALL_CORPOR_DED_AMT, 0) AS SMALL_CORPOR_DED_AMT    -- �ұ��/�һ���� �����α� �ҵ���� 
           , NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) AS HOUSE_APP_DEPOSIT_AMT  -- ����û������(��) 
           , NVL(HA.HOUSE_APP_SAVE_AMT, 0) AS HOUSE_APP_SAVE_AMT        -- ����û����������(��) 
           , NVL(HA.HOUSE_SAVE_AMT, 0) AS HOUSE_SAVE_AMT                -- ������ø������������(��) 
           , NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) AS WORKER_HOUSE_SAVE_AMT  -- �ٷ������ø�������(��) 
           , ( NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) + 
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0)) AS HOUSE_SAVE_SUM_AMT  -- ���ø��� ����ҵ���� �հ�  
           , NVL(HA.INVES_AMT, 0) AS INVES_AMT                          -- �����������ڵ� �ҵ����  
           , NVL(HA.CREDIT_AMT, 0) AS CREDIT_AMT                        -- �ſ�ī��� �ҵ���� 
           , NVL(HA.EMPL_STOCK_AMT, 0) AS EMPL_STOCK_AMT                -- �츮�������ռҵ���� 
           , NVL(HA.LONG_STOCK_SAVING_AMT, 0) AS LONG_STOCK_SAVING_AMT  -- ����ֽ�������ҵ���� 
           , NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) AS HIRE_KEEP_EMPLOY_AMT    -- ��������߼ұ���ٷ��� 
           , NVL(HA.FIX_LEASE_DED_AMT, 0) AS FIX_LEASE_DED_AMT          -- �񵷾ȵ�� �������ڻ�ȯ�� 
           , ( NVL(HA.PERS_ANNU_BANK_AMT, 0) + NVL(HA.SMALL_CORPOR_DED_AMT, 0) + 
               NVL(HA.HOUSE_APP_DEPOSIT_AMT, 0) + NVL(HA.HOUSE_APP_SAVE_AMT, 0) + 
               NVL(HA.HOUSE_SAVE_AMT, 0) + NVL(HA.WORKER_HOUSE_SAVE_AMT, 0) +
               NVL(HA.INVES_AMT, 0) + NVL(HA.CREDIT_AMT, 0) + 
               NVL(HA.EMPL_STOCK_AMT, 0) + NVL(HA.LONG_STOCK_SAVING_AMT, 0) + 
               NVL(HA.HIRE_KEEP_EMPLOY_AMT, 0) + NVL(HA.FIX_LEASE_DED_AMT, 0)) AS ETC_DED_SUM_AMT   -- �׹��� �ҵ���� �հ� �ݾ� -- 
           -- Ư������ �����ѵ� �ʰ��� 
           , NVL(HA.SP_DED_TOT_AMT, 0) AS SP_DED_TOT_AMT                -- Ư������ �����ѵ� �ʰ��� 
           -- ���ռҵ� ����ǥ�� 
           , NVL(HA.TAX_STD_AMT, 0) AS TAX_STD_AMT                      -- ���ռҵ� ����ǥ�� 
           -- ���⼼�� 
           , NVL(HA.COMP_TAX_AMT, 0) AS COMP_TAX_AMT                    -- ���⼼�� 
           -- ���װ���  
           , NVL(HA.TAX_REDU_IN_LAW_AMT, 0) AS TAX_REDU_IN_LAW_AMT      -- �ҵ漼�� 
           , NVL(HA.TAX_REDU_SP_LAW_AMT, 0) AS TAX_REDU_SP_LAW_AMT      -- ����Ư�� ���ѹ� 
           , NVL(HA.TAX_REDU_SMALL_BUSINESS, 0) AS TAX_REDU_SP_LAW_AMT_1                   -- ����Ư�� ���ѹ� ��30�� 
           , NVL(HA.TAX_REDU_TAX_TREATY, 0) AS TAX_REDU_TAX_TREATY      -- �������� 
           , ( NVL(HA.TAX_REDU_IN_LAW_AMT, 0) + NVL(HA.TAX_REDU_SP_LAW_AMT, 0) +
               NVL(HA.TAX_REDU_TAX_TREATY, 0) + NVL(HA.TAX_REDU_SMALL_BUSINESS, 0)) AS TAX_REDU_SUM_AMT      -- ���װ��� �հ� 
           -- ���װ��� 
           , NVL(HA.TAX_DED_INCOME_AMT, 0) AS TAX_DED_INCOME_AMT        -- ����-�ٷμҵ� 
           , NVL(HA.TAX_DED_TAXGROUP_AMT, 0) AS TAX_DED_TAXGROUP_AMT    -- ���� - �������� 
           , NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) AS TAX_DED_HOUSE_DEBT_AMT  -- ���� - �������Ա� 
           , NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) AS TAX_DED_LONG_STOCK_AMT  -- ���� - ����������� 
           , NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) AS TAX_DED_DONAT_POLI_AMT  -- ���� - ��� ��ġ�ڱ� 
           , NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0) AS TAX_DED_OUTSIDE_PAY_AMT  -- ���� - �ܱ����� 
           , ( NVL(HA.TAX_DED_INCOME_AMT, 0) + NVL(HA.TAX_DED_TAXGROUP_AMT, 0) + 
               NVL(HA.TAX_DED_HOUSE_DEBT_AMT, 0) + NVL(HA.TAX_DED_LONG_STOCK_AMT, 0) + 
               NVL(HA.TAX_DED_DONAT_POLI_AMT, 0) + NVL(HA.TAX_DED_OUTSIDE_PAY_AMT, 0)) AS TAX_DED_SUM_AMT  -- ���װ��� ��  
           , NVL(HA.FIX_TAX_AMT, 0) AS FIX_TAX_AMT                       -- �������� 
           -- �������� 
           , NVL(HA.FIX_IN_TAX_AMT, 0) AS FIX_IN_TAX_AMT        -- ���� �ҵ漼 
           , NVL(HA.FIX_LOCAL_TAX_AMT, 0) AS FIX_LOCAL_TAX_AMT   -- ���� �ֹμ� 
           , NVL(HA.FIX_SP_TAX_AMT, 0) AS FIX_SP_TAX_AMT         -- ���� ��Ư�� 
           , ( NVL(HA.FIX_IN_TAX_AMT, 0) + 
               NVL(HA.FIX_LOCAL_TAX_AMT, 0) + 
               NVL(HA.FIX_SP_TAX_AMT, 0)) AS FIX_TAX_SUM_AMT     -- ���� ���� �հ� 
           -- (����) �ⳳ�� ���� 
           , NVL(HPW1.IN_TAX_AMT, 0) AS PRE_IN_TAX_AMT           -- (����) �ҵ漼 �հ� 
           , NVL(HPW1.LOCAL_TAX_AMT, 0) AS PRE_LOCAL_TAX_AMT     -- (����) �ֹμ� �հ� 
           , NVL(HPW1.SP_TAX_AMT, 0) AS PRE_SP_TAX_AMT           -- (����) ��Ư�� �հ� 
           , ( NVL(HPW1.IN_TAX_AMT, 0) + 
               NVL(HPW1.LOCAL_TAX_AMT, 0) + 
               NVL(HPW1.SP_TAX_AMT, 0)) AS PRE_TAX_SUM_AMT       -- (����) ���� �հ� 
           -- (����) �ⳳ�� ����     
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) -
               NVL(HPW1.IN_TAX_AMT, 0)) AS NOW_IN_TAX_AMT        -- (����) �ҵ漼 
           , ( NVL(HA.PRE_LOCAL_TAX_AMT, 0) -
               NVL(HPW1.LOCAL_TAX_AMT, 0)) AS NOW_LOCAL_TAX_AMT  -- (����) �ֹμ�  
           , ( NVL(HA.PRE_SP_TAX_AMT, 0) -
               NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_SP_TAX_AMT        -- (����) ��Ư�� 
           , ( NVL(HA.PRE_IN_TAX_AMT, 0) - NVL(HPW1.IN_TAX_AMT, 0) +
               NVL(HA.PRE_LOCAL_TAX_AMT, 0) - NVL(HPW1.LOCAL_TAX_AMT, 0) +
               NVL(HA.PRE_SP_TAX_AMT, 0) - NVL(HPW1.SP_TAX_AMT, 0)) AS NOW_TAX_SUM_AMT  -- (����) ���� �հ� 
           -- ���� ���� 
           , NVL(HA.SUBT_IN_TAX_AMT, 0) AS SUBT_IN_TAX_AMT       -- (����) �ҵ漼 
           , NVL(HA.SUBT_LOCAL_TAX_AMT, 0) AS SUBT_LOCAL_TAX_AMT -- (����) �ֹμ� 
           , NVL(HA.SUBT_SP_TAX_AMT, 0) AS SUBT_SP_TAX_AMT       -- (����) ��Ư��  
           , ( NVL(HA.SUBT_IN_TAX_AMT, 0) + 
               NVL(HA.SUBT_LOCAL_TAX_AMT, 0) + 
               NVL(HA.SUBT_SP_TAX_AMT, 0)) AS SUBT_TAX_SUM_AMT   -- (����) ���� �հ� 
           -- ����� �հ� 
           , ( NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.NONTAX_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ� 
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
               -- ����-- 
               NVL(HA.PRE_NT_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OT_AMT, 0) +  -- NONTAX_OUTSIDE_AMT : ����� ���ܱٷ� �հ�  
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
               NVL(HA.PRE_NT_HOUSE_SUBSIDY_AMT, 0) + NVL(HA.PRE_NT_SEA_RESOURCE_AMT, 0)) AS NONTAX_TOT_AMT  -- ����� �հ� 
           -- ����� ��     
           , (NVL(HA.NONTAX_OUTSIDE_AMT, 0) + NVL(HA.PRE_NT_OUTSIDE_AMT, 0)) AS NONTAX_OUTSIDE_AMT -- ����� ���ܱٷ� �հ� 
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
           , ( -- ���� ���� ����
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
           , (-- ���� �λ系��.
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
         AND ((W_EMPLOYE_YN       = 'Y' AND 1 = 1)  -- �ߵ������ ���� --
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
  
  
END HRA_YEAR_ADJUSTMENT_G;
/
