CREATE OR REPLACE PACKAGE HRA_FOUNDATION_G
AS

-------------------------------------------------------------------------------
-- �������� �����ڷ� SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_FOUNDATION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , W_PERSON_ID         IN HRA_FOUNDATION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_FOUNDATION.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_FOUNDATION.ORG_ID%TYPE
            );

-------------------------------------------------------------------------------
-- �������� �����ڷ� INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_FOUNDATION
            ( P_YEAR_YYYY                   IN  HRA_FOUNDATION.YEAR_YYYY%TYPE
            , P_PERSON_ID                   IN  HRA_FOUNDATION.PERSON_ID%TYPE          
            , P_SOB_ID                      IN  HRA_FOUNDATION.SOB_ID%TYPE
            , P_ORG_ID                      IN  HRA_FOUNDATION.ORG_ID%TYPE
            , P_ADD_BONUS_AMT               IN  HRA_FOUNDATION.ADD_BONUS_AMT%TYPE
            , P_ADD_EDUCATION_AMT           IN  HRA_FOUNDATION.ADD_EDUCATION_AMT%TYPE
            , P_ADD_ETC_AMT                 IN  HRA_FOUNDATION.ADD_ETC_AMT%TYPE
            , P_INCOME_OUTSIDE_AMT          IN  HRA_FOUNDATION.INCOME_OUTSIDE_AMT%TYPE
            , P_NONTAX_OUTSIDE_AMT          IN  HRA_FOUNDATION.NONTAX_OUTSIDE_AMT%TYPE
            , P_TAX_OUTSIDE_AMT             IN  HRA_FOUNDATION.TAX_OUTSIDE_AMT%TYPE
            , P_IN_TAX_AMT                  IN  HRA_FOUNDATION.IN_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT               IN  HRA_FOUNDATION.LOCAL_TAX_AMT%TYPE
            , P_ANNU_INSUR_AMT              IN  HRA_FOUNDATION.ANNU_INSUR_AMT%TYPE
            , P_HIRE_MEDIC_INSUR_AMT        IN  HRA_FOUNDATION.HIRE_MEDIC_INSUR_AMT%TYPE
            , P_HOUSE_SAVE_AMT              IN  HRA_FOUNDATION.HOUSE_SAVE_AMT%TYPE
            , P_HOUSE_ADD_AMT               IN  HRA_FOUNDATION.HOUSE_ADD_AMT%TYPE
            , P_LONG_HOUSE_INTER_AMT        IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT%TYPE
            , P_LONG_HOUSE_INTER_AMT_1      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_1%TYPE
            , P_LONG_HOUSE_INTER_AMT_2      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_2%TYPE
            , P_SMALL_CORPOR_DED_AMT        IN  HRA_FOUNDATION.SMALL_CORPOR_DED_AMT%TYPE
            , P_LONG_STOCK_SAVING_AMT_1     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_1%TYPE
            , P_LONG_STOCK_SAVING_AMT_2     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_2%TYPE
            , P_LONG_STOCK_SAVING_AMT_3     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_3%TYPE
            , P_MARRY_COUNT                 IN  HRA_FOUNDATION.MARRY_COUNT%TYPE
            , P_FUNER_COUNT                 IN  HRA_FOUNDATION.FUNER_COUNT%TYPE
            , P_HOUSE_MOVE_COUNT            IN  HRA_FOUNDATION.HOUSE_MOVE_COUNT%TYPE
            , P_PERSON_ANNU_AMT             IN  HRA_FOUNDATION.PERSON_ANNU_AMT%TYPE
            , P_ANNU_BANK_AMT               IN  HRA_FOUNDATION.ANNU_BANK_AMT%TYPE
            , P_RETR_ANNU_AMT               IN  HRA_FOUNDATION.RETR_ANNU_AMT%TYPE
            , P_INVES_AMT                   IN  HRA_FOUNDATION.INVES_AMT%TYPE
            , P_INVES_AMT_1                 IN  HRA_FOUNDATION.INVES_AMT_1%TYPE
            , P_EMPL_STOCK_AMT              IN  HRA_FOUNDATION.EMPL_STOCK_AMT%TYPE
            , P_TAX_ASSOCIATION_AMT         IN  HRA_FOUNDATION.TAX_ASSOCIATION_AMT%TYPE
            , P_ITL_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.ITL_REDUCTION_TAX_AMT%TYPE
            , P_STT_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.STT_REDUCTION_TAX_AMT%TYPE
            , P_TT_REDUCTION_TAX_AMT        IN  HRA_FOUNDATION.TT_REDUCTION_TAX_AMT%TYPE          
            , P_HOUSE_DEBT_BEN_AMT          IN  HRA_FOUNDATION.HOUSE_DEBT_BEN_AMT%TYPE
            , P_USER_ID                     IN  HRA_FOUNDATION.CREATED_BY%TYPE
            , P_HOUSE_MONTHLY_AMT           IN  HRA_FOUNDATION.HOUSE_MONTHLY_AMT%TYPE
            , P_EMPLOYMENT_KEEP_AMT         IN  HRA_FOUNDATION.EMPLOYMENT_KEEP_AMT%TYPE 
            , P_HOUSE_ADD_AMT_RESIDENT      IN  HRA_FOUNDATION.HOUSE_ADD_AMT_RESIDENT%TYPE
            , P_LONG_HOUSE_INTER_AMT_3_FIX  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_FIX%TYPE
            , P_LONG_HOUSE_INTER_AMT_3_ETC  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_ETC%TYPE
            , P_SMALL_BUSINESS_TAX_DED_FLAG IN  HRA_FOUNDATION.SMALL_BUSINESS_TAX_DED_FLAG%TYPE
            , P_FOREIGN_WORKER_TAX_DED_FLAG IN  HRA_FOUNDATION.FOREIGN_WORKER_TAX_DED_FLAG%TYPE
            , P_PRE_YEAR_OT_DED_FLAG        IN  HRA_FOUNDATION.PRE_YEAR_OT_DED_FLAG%TYPE
            );

-------------------------------------------------------------------------------
-- �������� �����ڷ� UPDATE.
-------------------------------------------------------------------------------
  PROCEDURE UPDATE_FOUNDATION
            ( W_YEAR_YYYY                   IN  HRA_FOUNDATION.YEAR_YYYY%TYPE
            , W_PERSON_ID                   IN  HRA_FOUNDATION.PERSON_ID%TYPE
            , W_SOB_ID                      IN  HRA_FOUNDATION.SOB_ID%TYPE
            , W_ORG_ID                      IN  HRA_FOUNDATION.ORG_ID%TYPE
            , P_ADD_BONUS_AMT               IN  HRA_FOUNDATION.ADD_BONUS_AMT%TYPE
            , P_ADD_EDUCATION_AMT           IN  HRA_FOUNDATION.ADD_EDUCATION_AMT%TYPE
            , P_ADD_ETC_AMT                 IN  HRA_FOUNDATION.ADD_ETC_AMT%TYPE
            , P_INCOME_OUTSIDE_AMT          IN  HRA_FOUNDATION.INCOME_OUTSIDE_AMT%TYPE
            , P_NONTAX_OUTSIDE_AMT          IN  HRA_FOUNDATION.NONTAX_OUTSIDE_AMT%TYPE
            , P_TAX_OUTSIDE_AMT             IN  HRA_FOUNDATION.TAX_OUTSIDE_AMT%TYPE
            , P_IN_TAX_AMT                  IN  HRA_FOUNDATION.IN_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT               IN  HRA_FOUNDATION.LOCAL_TAX_AMT%TYPE
            , P_ANNU_INSUR_AMT              IN  HRA_FOUNDATION.ANNU_INSUR_AMT%TYPE
            , P_HIRE_MEDIC_INSUR_AMT        IN  HRA_FOUNDATION.HIRE_MEDIC_INSUR_AMT%TYPE
            , P_HOUSE_SAVE_AMT              IN  HRA_FOUNDATION.HOUSE_SAVE_AMT%TYPE
            , P_HOUSE_ADD_AMT               IN  HRA_FOUNDATION.HOUSE_ADD_AMT%TYPE
            , P_LONG_HOUSE_INTER_AMT        IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT%TYPE
            , P_LONG_HOUSE_INTER_AMT_1      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_1%TYPE
            , P_LONG_HOUSE_INTER_AMT_2      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_2%TYPE
            , P_SMALL_CORPOR_DED_AMT        IN  HRA_FOUNDATION.SMALL_CORPOR_DED_AMT%TYPE
            , P_LONG_STOCK_SAVING_AMT_1     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_1%TYPE
            , P_LONG_STOCK_SAVING_AMT_2     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_2%TYPE
            , P_LONG_STOCK_SAVING_AMT_3     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_3%TYPE
            , P_MARRY_COUNT                 IN  HRA_FOUNDATION.MARRY_COUNT%TYPE
            , P_FUNER_COUNT                 IN  HRA_FOUNDATION.FUNER_COUNT%TYPE
            , P_HOUSE_MOVE_COUNT            IN  HRA_FOUNDATION.HOUSE_MOVE_COUNT%TYPE
            , P_PERSON_ANNU_AMT             IN  HRA_FOUNDATION.PERSON_ANNU_AMT%TYPE
            , P_ANNU_BANK_AMT               IN  HRA_FOUNDATION.ANNU_BANK_AMT%TYPE
            , P_RETR_ANNU_AMT               IN  HRA_FOUNDATION.RETR_ANNU_AMT%TYPE
            , P_INVES_AMT                   IN  HRA_FOUNDATION.INVES_AMT%TYPE
            , P_INVES_AMT_1                 IN  HRA_FOUNDATION.INVES_AMT_1%TYPE
            , P_EMPL_STOCK_AMT              IN  HRA_FOUNDATION.EMPL_STOCK_AMT%TYPE
            , P_TAX_ASSOCIATION_AMT         IN  HRA_FOUNDATION.TAX_ASSOCIATION_AMT%TYPE
            , P_ITL_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.ITL_REDUCTION_TAX_AMT%TYPE
            , P_STT_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.STT_REDUCTION_TAX_AMT%TYPE
            , P_TT_REDUCTION_TAX_AMT        IN  HRA_FOUNDATION.TT_REDUCTION_TAX_AMT%TYPE          
            , P_HOUSE_DEBT_BEN_AMT          IN  HRA_FOUNDATION.HOUSE_DEBT_BEN_AMT%TYPE
            , P_USER_ID                     IN  HRA_FOUNDATION.CREATED_BY%TYPE
            , P_HOUSE_MONTHLY_AMT           IN  HRA_FOUNDATION.HOUSE_MONTHLY_AMT%TYPE
            , P_EMPLOYMENT_KEEP_AMT         IN  HRA_FOUNDATION.EMPLOYMENT_KEEP_AMT%TYPE 
            , P_HOUSE_ADD_AMT_RESIDENT      IN  HRA_FOUNDATION.HOUSE_ADD_AMT_RESIDENT%TYPE
            , P_LONG_HOUSE_INTER_AMT_3_FIX  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_FIX%TYPE
            , P_LONG_HOUSE_INTER_AMT_3_ETC  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_ETC%TYPE
            , P_SMALL_BUSINESS_TAX_DED_FLAG IN  HRA_FOUNDATION.SMALL_BUSINESS_TAX_DED_FLAG%TYPE
            , P_FOREIGN_WORKER_TAX_DED_FLAG IN  HRA_FOUNDATION.FOREIGN_WORKER_TAX_DED_FLAG%TYPE
            , P_PRE_YEAR_OT_DED_FLAG        IN  HRA_FOUNDATION.PRE_YEAR_OT_DED_FLAG%TYPE
            );
          
-------------------------------------------------------------------------------
-- �������� �����ڷ� DELETE.
-------------------------------------------------------------------------------
  PROCEDURE DELETE_FOUNDATION
            ( W_YEAR_YYYY  HRA_FOUNDATION.YEAR_YYYY%TYPE
            , W_PERSON_ID  HRA_FOUNDATION.PERSON_ID%TYPE
            , P_SOB_ID     HRA_FOUNDATION.SOB_ID%TYPE
            , P_ORG_ID     HRA_FOUNDATION.ORG_ID%TYPE 
            );
          
END HRA_FOUNDATION_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_FOUNDATION_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRA_FOUNDATION_G
/* Description  : �������� �����ڷ� ����.
/*
/* Reference by :    
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/

----------------------------------------------------------------------------------
-- �������� �����ڷ� SELECT
----------------------------------------------------------------------------------
  PROCEDURE SELECT_FOUNDATION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN VARCHAR2
            , P_STD_DATE          IN DATE
            , W_PERSON_ID         IN HRA_FOUNDATION.PERSON_ID%TYPE
            , P_SOB_ID            IN HRA_FOUNDATION.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_FOUNDATION.ORG_ID%TYPE
            )
  AS
    V_MANY_CHILD_DED_AGE  NUMBER := 0;    
  BEGIN
    BEGIN
      SELECT ITS.MANY_CHILD_DED_AGE
        INTO V_MANY_CHILD_DED_AGE
        FROM HRA_INCOME_TAX_STANDARD ITS
      WHERE ITS.YEAR_YYYY        = P_YEAR_YYYY
        AND ITS.SOB_ID           = P_SOB_ID
        AND ITS.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_MANY_CHILD_DED_AGE := 20;
    END;
    
    OPEN P_CURSOR FOR
      SELECT NVL(HF1.YEAR_YYYY, P_YEAR_YYYY) AS YEAR_YYYY
          , NVL(HF1.PERSON_ID, W_PERSON_ID) PERSON_ID
          --> ��������.
          , NVL(HF1.ADD_BONUS_AMT, 0) ADD_BONUS_AMT
          , NVL(HF1.ADD_EDUCATION_AMT, 0) ADD_EDUCATION_AMT
          , NVL(HF1.ADD_ETC_AMT, 0) ADD_ETC_AMT
          , NVL(HF1.INCOME_OUTSIDE_AMT, 0) INCOME_OUTSIDE_AMT
          , NVL(HF1.NONTAX_OUTSIDE_AMT, 0) NONTAX_OUTSIDE_AMT
          , NVL(HF1.TAX_OUTSIDE_AMT, 0) TAX_OUTSIDE_AMT
          , NVL(HF1.ANNU_INSUR_AMT, 0) ANNU_INSUR_AMT
          , NVL(HF1.HIRE_MEDIC_INSUR_AMT, 0) HIRE_MEDIC_INSUR_AMT  --< ��Ÿ���� ���� >--
          , NVL(HF1.HOUSE_SAVE_AMT, 0) HOUSE_SAVE_AMT
          , NVL(HF1.HOUSE_ADD_AMT, 0) HOUSE_ADD_AMT
          , NVL(HF1.LONG_HOUSE_INTER_AMT, 0) LONG_HOUSE_INTER_AMT
          , NVL(HSF1.DONAT_ALL, 0) DONAT_ALL
          , NVL(HSF1.DONAT_50P, 0) DONAT_50P
          , NVL(HSF1.DONAT_30P, 0) DONAT_30P
          , NVL(HSF1.DONAT_10P, 0) DONAT_10P
          , NVL(HSF1.DONAT_POLI, 0) DONAT_POLI
          , NVL(HF1.MARRY_COUNT, 0) MARRY_COUNT
          , NVL(HF1.FUNER_COUNT, 0) FUNER_COUNT
          , NVL(HF1.HOUSE_MOVE_COUNT, 0) HOUSE_MOVE_COUNT
          , NVL(HF1.PERSON_ANNU_AMT, 0) PERSON_ANNU_AMT
          , NVL(HF1.ANNU_BANK_AMT, 0) ANNU_BANK_AMT
          , NVL(HF1.RETR_ANNU_AMT, 0) RETR_ANNU_AMT
          , NVL(HF1.INVES_AMT, 0) INVES_AMT
          , NVL(HF1.INVES_AMT_1, 0) INVES_AMT_1
          , NVL(HF1.EMPL_STOCK_AMT, 0) EMPL_STOCK_AMT
          , NVL(HF1.TAX_ASSOCIATION_AMT, 0) TAX_ASSOCIATION_AMT
          , NVL(HF1.ITL_REDUCTION_TAX_AMT, 0) ITL_REDUCTION_TAX_AMT
          , NVL(HF1.STT_REDUCTION_TAX_AMT, 0) STT_REDUCTION_TAX_AMT
          , NVL(HF1.TT_REDUCTION_TAX_AMT, 0) TT_REDUCTION_TAX_AMT          
          --> ��������;
          , NVL(HSF1.BASE_COUNT, 1) BASE_COUNT
          , NVL(HSF1.SPOUSE_COUNT, 0) SPOUSE_COUNT
          , NVL(HSF1.OLD_COUNT, 0) OLD_COUNT
          , NVL(HSF1.OLD1_COUNT, 0) OLD1_COUNT
          , NVL(HSF1.DISABILITY_COUNT, 0) DEFORM_COUNT
          , NVL(HSF1.WOMAN_COUNT, 0) WOMAN_COUNT
          , NVL(HSF1.CHILD_COUNT, 0) CHILD_COUNT
          , CASE
              WHEN NVL(HSF1.MANY_CHILD_DED_COUNT, 0) > 1 THEN NVL(HSF1.MANY_CHILD_DED_COUNT, 0)
              ELSE 0
            END MANY_CHILD_DED_COUNT
          , NVL(HSF1.INSURE_SUM, 0) INSURE_SUM
          , NVL(HSF1.DISABILITY_INSURE_SUM, 0) DISABILITY_INSURE_SUM
          , NVL(HSF1.PER_MEDI_SUM, 0) PER_MEDI_SUM
          , NVL(HSF1.OLD_MEDI_SUM, 0) OLD_MEDI_SUM
          , NVL(HSF1.DISABILITY_MEDI_SUM, 0) DISABILITY_MEDI_SUM
          , NVL(HSF1.SUPP_MEDI_SUM, 0) SUPP_MEDI_SUM
          , NVL(HSF1.PER_EDU_COUNT, 0) PER_EDU_COUNT
          , NVL(HSF1.PER_EDU_AMT, 0) PER_EDU_AMT
          , NVL(HSF1.DISABILITY_EDU_COUNT, 0) DISABILITY_EDU_COUNT
          , NVL(HSF1.DISABILITY_EDU_AMT, 0) DISABILITY_EDU_AMT
          , NVL(HSF1.CHILD_EDU_COUNT, 0) CHILD_EDU_COUNT
          , NVL(HSF1.CHILD_EDU_AMT, 0) CHILD_EDU_AMT
          , NVL(HSF1.HIGH_EDU_COUNT, 0) HIGH_EDU_COUNT
          , NVL(HSF1.HIGH_EDU_AMT, 0) HIGH_EDU_AMT
          , NVL(HSF1.COLL_EDU_COUNT, 0) COLL_EDU_COUNT
          , NVL(HSF1.COLL_EDU_AMT, 0) COLL_EDU_AMT
          , NVL(HSF1.CREDIT_SUM, 0) CREDIT_SUM
          , NVL(HSF1.ACADE_GIRO_SUM, 0) ACADE_GIRO_SUM
          , NVL(HSF1.CASH_SUM, 0) CASH_SUM
          --> �߰�
          , NVL(HF1.HOUSE_DEBT_BEN_AMT, 0) HOUSE_DEBT_BEN_AMT
          --> 2008�⵵ �߰�;
          , NVL(HSF1.BIRTH_COUNT, 0) BIRTH_COUNT
          , NVL(HSF1.DONAT_10P_RELIGION, 0) DONAT_10P_RELIGION
          , NVL(HF1.SMALL_CORPOR_DED_AMT, 0) SMALL_CORPOR_DED_AMT
          , NVL(HF1.LONG_STOCK_SAVING_AMT_1, 0) LONG_STOCK_SAVING_AMT_1
          , NVL(HF1.LONG_STOCK_SAVING_AMT_2, 0) LONG_STOCK_SAVING_AMT_2
          , NVL(HF1.LONG_STOCK_SAVING_AMT_3, 0) LONG_STOCK_SAVING_AMT_3
          , NVL(HF1.LONG_HOUSE_INTER_AMT_1, 0) LONG_HOUSE_INTER_AMT_1
          , NVL(HF1.LONG_HOUSE_INTER_AMT_2, 0) LONG_HOUSE_INTER_AMT_2
          , NVL(HF1.IN_TAX_AMT, 0) IN_TAX_AMT
          , NVL(HF1.LOCAL_TAX_AMT, 0) LOCAL_TAX_AMT
          --> 2011.01.17 �߰�,
          , NVL(HSF1.CHECK_CREDIT_SUM, 0) CHECK_CREDIT_SUM
          , NVL(HF1.HOUSE_MONTHLY_AMT , 0) HOUSE_MONTHLY_AMT 
          , NVL(HF1.EMPLOYMENT_KEEP_AMT , 0) EMPLOYMENT_KEEP_AMT 
          , NVL(HF1.HOUSE_ADD_AMT_RESIDENT, 0) AS HOUSE_ADD_AMT_RESIDENT
          --> 2012�⵵ �߰� <--
          , NVL(HF1.LONG_HOUSE_INTER_AMT_3_FIX, 0) AS LONG_HOUSE_INTER_AMT_3_FIX
          , NVL(HF1.LONG_HOUSE_INTER_AMT_3_ETC, 0) AS LONG_HOUSE_INTER_AMT_3_ETC
          , NVL(HF1.SMALL_BUSINESS_TAX_DED_FLAG, 'N') AS SMALL_BUSINESS_TAX_DED_FLAG
          , NVL(HF1.FOREIGN_WORKER_TAX_DED_FLAG, 'N') AS FOREIGN_WORKER_TAX_DED_FLAG
          --> 2013�⵵ �߰� --
          , NVL(HF1.PRE_YEAR_OT_DED_FLAG, 'N') AS PRE_YEAR_OT_DED_FLAG
        FROM HRM_PERSON_MASTER PM
          , ( --> �����ڷ� ��ȸ  
            SELECT HF.YEAR_YYYY
                , HF.PERSON_ID
                , HF.SOB_ID
                , HF.ORG_ID
                , HF.ADD_BONUS_AMT
                , HF.ADD_EDUCATION_AMT
                , HF.ADD_ETC_AMT
                , HF.INCOME_OUTSIDE_AMT
                , HF.NONTAX_OUTSIDE_AMT
                , HF.TAX_OUTSIDE_AMT
                , HF.ANNU_INSUR_AMT
                , HF.HIRE_MEDIC_INSUR_AMT
                , HF.HOUSE_SAVE_AMT
                , HF.HOUSE_ADD_AMT
                , HF.LONG_HOUSE_INTER_AMT
                , HF.LONG_HOUSE_INTER_AMT_1
                , HF.LONG_HOUSE_INTER_AMT_2
                , HF.MARRY_COUNT
                , HF.FUNER_COUNT
                , HF.HOUSE_MOVE_COUNT
                , HF.PERSON_ANNU_AMT
                , HF.ANNU_BANK_AMT
                , HF.RETR_ANNU_AMT
                , HF.INVES_AMT
                , HF.INVES_AMT_1
                , HF.EMPL_STOCK_AMT
                , HF.TAX_ASSOCIATION_AMT
                , HF.ITL_REDUCTION_TAX_AMT
                , HF.STT_REDUCTION_TAX_AMT
                , HF.TT_REDUCTION_TAX_AMT
                , HF.HOUSE_DEBT_BEN_AMT
                --> ���� 2008�⵵ �߰�;
                , HF.SMALL_CORPOR_DED_AMT
                , HF.LONG_STOCK_SAVING_AMT_1
                , HF.LONG_STOCK_SAVING_AMT_2
                , HF.LONG_STOCK_SAVING_AMT_3
                , HF.IN_TAX_AMT
                , HF.LOCAL_TAX_AMT
                , HF.HOUSE_MONTHLY_AMT
                , HF.EMPLOYMENT_KEEP_AMT
                , HF.HOUSE_ADD_AMT_RESIDENT
                , HF.LONG_HOUSE_INTER_AMT_3_FIX 
                , HF.LONG_HOUSE_INTER_AMT_3_ETC 
                , HF.SMALL_BUSINESS_TAX_DED_FLAG 
                , HF.FOREIGN_WORKER_TAX_DED_FLAG 
                , HF.PRE_YEAR_OT_DED_FLAG
              FROM HRA_FOUNDATION HF
            WHERE HF.YEAR_YYYY    = P_YEAR_YYYY
              AND HF.PERSON_ID    = W_PERSON_ID
              AND HF.SOB_ID       = P_SOB_ID
              AND HF.ORG_ID       = P_ORG_ID
            ) HF1
          , ( --> �ξ簡�� ���� ����  
            SELECT HSF.YEAR_YYYY
                , HSF.PERSON_ID
                , HSF.SOB_ID
                , HSF.ORG_ID
                , SUM(DECODE(HSF.BASE_YN, 'Y', 1, 0)) BASE_COUNT
                , SUM(CASE 
                        WHEN HSF.RELATION_CODE = '3' AND HSF.SPOUSE_YN = 'Y' THEN 1
                        ELSE 0
                      END) SPOUSE_COUNT
                , SUM(DECODE(HSF.OLD_YN, 'Y', 1, 0)) OLD_COUNT
                , SUM(DECODE(HSF.OLD1_YN, 'Y', 1, 0)) OLD1_COUNT
                , SUM(DECODE(HSF.DISABILITY_YN, 'Y', 1, 0)) DISABILITY_COUNT
                , SUM(DECODE(HSF.WOMAN_YN, 'Y', 1, 0)) WOMAN_COUNT
                , SUM(DECODE(HSF.BIRTH_YN, 'Y', 1, 0)) BIRTH_COUNT
                --> 2008�⵵ �߰�;
                , SUM(DECODE(HSF.CHILD_YN, 'Y', 1, 0)) CHILD_COUNT
                , SUM(CASE
                        WHEN HSF.BASE_YN = 'Y' AND HSF.RELATION_CODE = '4' AND
                             EAPP_REGISTER_AGE_F(HSF.REPRE_NUM, P_STD_DATE, 0) <= V_MANY_CHILD_DED_AGE THEN 1
                        ELSE 0
                      END) MANY_CHILD_DED_COUNT
                , SUM(NVL(HSF.INSURE_AMT, 0) + NVL(HSF.ETC_INSURE_AMT, 0)) INSURE_SUM
                , SUM(NVL(HSF.DISABILITY_INSURE_AMT, 0) +
                      NVL(HSF.ETC_DISABILITY_INSURE_AMT, 0)) DISABILITY_INSURE_SUM
                , SUM(DECODE(HSF.RELATION_CODE, '0', NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0), 0)) PER_MEDI_SUM
                , SUM(CASE
                        WHEN HSF.RELATION_CODE = '0' THEN 0
                        WHEN 'Y' IN (HSF.OLD_YN, HSF.OLD1_YN) AND HSF.DISABILITY_YN <> 'Y' THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                        ELSE 0
                      END) OLD_MEDI_SUM
                , SUM(CASE
                        WHEN HSF.RELATION_CODE = '0' THEN 0
                        WHEN HSF.DISABILITY_YN = 'Y' THEN NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                        ELSE 0
                      END) DISABILITY_MEDI_SUM
                , SUM(CASE
                        WHEN HSF.RELATION_CODE = '0' THEN 0
                        WHEN 'Y' IN (HSF.OLD_YN, HSF.OLD1_YN) THEN 0
                        WHEN HSF.DISABILITY_YN = 'Y' THEN 0
                        ELSE NVL(HSF.MEDICAL_AMT, 0) + NVL(HSF.ETC_MEDICAL_AMT, 0)
                      END) SUPP_MEDI_SUM
                , SUM(DECODE(HSF.EDUCATION_TYPE, '10', 1, 0)) PER_EDU_COUNT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '10', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) PER_EDU_AMT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '20', 1, 0)) DISABILITY_EDU_COUNT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '20', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) DISABILITY_EDU_AMT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '30', 1, 0)) CHILD_EDU_COUNT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '30', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) CHILD_EDU_AMT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '40', 1, 0)) HIGH_EDU_COUNT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '40', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) HIGH_EDU_AMT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '50', 1, 0)) COLL_EDU_COUNT
                , SUM(DECODE(HSF.EDUCATION_TYPE, '50', NVL(HSF.EDUCATION_AMT, 0) + NVL(HSF.ETC_EDUCATION_AMT, 0), 0)) COLL_EDU_AMT
                , SUM(NVL(HSF.CREDIT_AMT, 0) + NVL(HSF.ETC_CREDIT_AMT, 0)) CREDIT_SUM
                , SUM(NVL(HSF.CHECK_CREDIT_AMT, 0) +
                      NVL(HSF.ETC_CHECK_CREDIT_AMT, 0)) CHECK_CREDIT_SUM
                , SUM(NVL(HSF.ACADE_GIRO_AMT, 0) +
                      NVL(HSF.ETC_ACADE_GIRO_AMT, 0)) ACADE_GIRO_SUM
                , SUM(NVL(HSF.CASH_AMT, 0) + NVL(HSF.ETC_CASH_AMT, 0)) CASH_SUM
                , SUM(NVL(HSF.TRAD_MARKET_AMT, 0) + NVL(HSF.ETC_TRAD_MARKET_AMT, 0)) AS TRAD_MARKET_SUM
                , SUM(NVL(HSF.DONAT_POLI, 0) + NVL(HSF.ETC_DONAT_POLI, 0)) DONAT_POLI
                , SUM(NVL(HSF.DONAT_ALL, 0) + NVL(HSF.ETC_DONAT_ALL, 0)) DONAT_ALL
                , SUM(NVL(HSF.DONAT_50P, 0) + NVL(HSF.ETC_DONAT_50P, 0)) DONAT_50P
                , SUM(NVL(HSF.DONAT_30P, 0) + NVL(HSF.ETC_DONAT_30P, 0)) DONAT_30P
                , SUM(NVL(HSF.DONAT_10P, 0) + NVL(HSF.ETC_DONAT_10P, 0)) DONAT_10P
                , SUM(NVL(HSF.DONAT_10P_RELIGION, 0) +
                      NVL(HSF.ETC_DONAT_10P_RELIGION, 0)) DONAT_10P_RELIGION
              FROM HRA_SUPPORT_FAMILY HSF
            WHERE HSF.YEAR_YYYY     = P_YEAR_YYYY
              AND HSF.PERSON_ID     = W_PERSON_ID
              AND HSF.SOB_ID        = P_SOB_ID
              AND HSF.ORG_ID        = P_ORG_ID
            GROUP BY HSF.YEAR_YYYY, HSF.PERSON_ID, HSF.SOB_ID, HSF.ORG_ID
            ) HSF1
       WHERE PM.PERSON_ID         = HSF1.PERSON_ID(+)
         AND PM.PERSON_ID         = HF1.PERSON_ID(+)
         AND PM.PERSON_ID         = W_PERSON_ID
         AND PM.SOB_ID            = P_SOB_ID
         AND PM.ORG_ID            = P_ORG_ID
       ;
       
  END SELECT_FOUNDATION;
    
----------------------------------------------------------------------------------
-- �������� �����ڷ� INSERT
----------------------------------------------------------------------------------
  PROCEDURE INSERT_FOUNDATION
          ( P_YEAR_YYYY                   IN  HRA_FOUNDATION.YEAR_YYYY%TYPE
          , P_PERSON_ID                   IN  HRA_FOUNDATION.PERSON_ID%TYPE          
          , P_SOB_ID                      IN  HRA_FOUNDATION.SOB_ID%TYPE
          , P_ORG_ID                      IN  HRA_FOUNDATION.ORG_ID%TYPE
          , P_ADD_BONUS_AMT               IN  HRA_FOUNDATION.ADD_BONUS_AMT%TYPE
          , P_ADD_EDUCATION_AMT           IN  HRA_FOUNDATION.ADD_EDUCATION_AMT%TYPE
          , P_ADD_ETC_AMT                 IN  HRA_FOUNDATION.ADD_ETC_AMT%TYPE
          , P_INCOME_OUTSIDE_AMT          IN  HRA_FOUNDATION.INCOME_OUTSIDE_AMT%TYPE
          , P_NONTAX_OUTSIDE_AMT          IN  HRA_FOUNDATION.NONTAX_OUTSIDE_AMT%TYPE
          , P_TAX_OUTSIDE_AMT             IN  HRA_FOUNDATION.TAX_OUTSIDE_AMT%TYPE
          , P_IN_TAX_AMT                  IN  HRA_FOUNDATION.IN_TAX_AMT%TYPE
          , P_LOCAL_TAX_AMT               IN  HRA_FOUNDATION.LOCAL_TAX_AMT%TYPE
          , P_ANNU_INSUR_AMT              IN  HRA_FOUNDATION.ANNU_INSUR_AMT%TYPE
          , P_HIRE_MEDIC_INSUR_AMT        IN  HRA_FOUNDATION.HIRE_MEDIC_INSUR_AMT%TYPE
          , P_HOUSE_SAVE_AMT              IN  HRA_FOUNDATION.HOUSE_SAVE_AMT%TYPE
          , P_HOUSE_ADD_AMT               IN  HRA_FOUNDATION.HOUSE_ADD_AMT%TYPE
          , P_LONG_HOUSE_INTER_AMT        IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT%TYPE
          , P_LONG_HOUSE_INTER_AMT_1      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_1%TYPE
          , P_LONG_HOUSE_INTER_AMT_2      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_2%TYPE
          , P_SMALL_CORPOR_DED_AMT        IN  HRA_FOUNDATION.SMALL_CORPOR_DED_AMT%TYPE
          , P_LONG_STOCK_SAVING_AMT_1     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_1%TYPE
          , P_LONG_STOCK_SAVING_AMT_2     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_2%TYPE
          , P_LONG_STOCK_SAVING_AMT_3     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_3%TYPE
          , P_MARRY_COUNT                 IN  HRA_FOUNDATION.MARRY_COUNT%TYPE
          , P_FUNER_COUNT                 IN  HRA_FOUNDATION.FUNER_COUNT%TYPE
          , P_HOUSE_MOVE_COUNT            IN  HRA_FOUNDATION.HOUSE_MOVE_COUNT%TYPE
          , P_PERSON_ANNU_AMT             IN  HRA_FOUNDATION.PERSON_ANNU_AMT%TYPE
          , P_ANNU_BANK_AMT               IN  HRA_FOUNDATION.ANNU_BANK_AMT%TYPE
          , P_RETR_ANNU_AMT               IN  HRA_FOUNDATION.RETR_ANNU_AMT%TYPE
          , P_INVES_AMT                   IN  HRA_FOUNDATION.INVES_AMT%TYPE
          , P_INVES_AMT_1                 IN  HRA_FOUNDATION.INVES_AMT_1%TYPE
          , P_EMPL_STOCK_AMT              IN  HRA_FOUNDATION.EMPL_STOCK_AMT%TYPE
          , P_TAX_ASSOCIATION_AMT         IN  HRA_FOUNDATION.TAX_ASSOCIATION_AMT%TYPE
          , P_ITL_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.ITL_REDUCTION_TAX_AMT%TYPE
          , P_STT_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.STT_REDUCTION_TAX_AMT%TYPE
          , P_TT_REDUCTION_TAX_AMT        IN  HRA_FOUNDATION.TT_REDUCTION_TAX_AMT%TYPE          
          , P_HOUSE_DEBT_BEN_AMT          IN  HRA_FOUNDATION.HOUSE_DEBT_BEN_AMT%TYPE
          , P_USER_ID                     IN  HRA_FOUNDATION.CREATED_BY%TYPE
          , P_HOUSE_MONTHLY_AMT           IN  HRA_FOUNDATION.HOUSE_MONTHLY_AMT%TYPE
          , P_EMPLOYMENT_KEEP_AMT         IN  HRA_FOUNDATION.EMPLOYMENT_KEEP_AMT%TYPE 
          , P_HOUSE_ADD_AMT_RESIDENT      IN  HRA_FOUNDATION.HOUSE_ADD_AMT_RESIDENT%TYPE
          , P_LONG_HOUSE_INTER_AMT_3_FIX  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_FIX%TYPE
          , P_LONG_HOUSE_INTER_AMT_3_ETC  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_ETC%TYPE
          , P_SMALL_BUSINESS_TAX_DED_FLAG IN  HRA_FOUNDATION.SMALL_BUSINESS_TAX_DED_FLAG%TYPE
          , P_FOREIGN_WORKER_TAX_DED_FLAG IN  HRA_FOUNDATION.FOREIGN_WORKER_TAX_DED_FLAG%TYPE
          , P_PRE_YEAR_OT_DED_FLAG        IN  HRA_FOUNDATION.PRE_YEAR_OT_DED_FLAG%TYPE
          )
  IS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HOUSEHOLD_TYPE      VARCHAR2(3);  -- ������ ���� --
  BEGIN
    BEGIN
      SELECT PM.HOUSEHOLD_TYPE
        INTO V_HOUSEHOLD_TYPE
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID       = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSEHOLD_TYPE := NULL;
    END;
    IF V_HOUSEHOLD_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '������ ���� ������ ã���� �����ϴ�. ������ ������ �Է��ϼ���');
      RETURN;
    END IF;
    
    IF V_HOUSEHOLD_TYPE != '1' AND 
      ( NVL(P_HOUSE_SAVE_AMT, 0) +   -- ���ø������� --
        NVL(P_HOUSE_ADD_AMT, 0) +  -- �����������Աݿ����ݻ�Ȳ��-������ --
        NVL(P_LONG_HOUSE_INTER_AMT, 0) +  -- ����������ڻ�ȯ(600����) --
        NVL(P_LONG_HOUSE_INTER_AMT_1, 0) +  -- ����������ڻ�ȯ(�ѵ�1000����) --
        NVL(P_LONG_HOUSE_INTER_AMT_2, 0) +  -- ����������ڻ�ȯ(�ѵ�1500����) --
        NVL(P_HOUSE_MONTHLY_AMT, 0) +  -- �����ҵ���� --
        NVL(P_HOUSE_ADD_AMT_RESIDENT, 0) +  -- �����������Աݿ����ݻ�ȯ��-������ --
        NVL(P_LONG_HOUSE_INTER_AMT_3_FIX, 0) +  -- ��������������Ա� ���ڻ�ȯ��(500����) �����ݸ��� --
        NVL(P_LONG_HOUSE_INTER_AMT_3_ETC, 0)  -- ��������������Ա� ���ڻ�ȯ��(500����) ��Ÿ
       ) > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '�����ֿ� ���ؼ��� ���ð��� �����ڷḦ �Է��� �� �ֽ��ϴ�. ������ ������ �Է��ϼ���');
      RETURN;
    END IF;
    
    INSERT INTO HRA_FOUNDATION
    ( YEAR_YYYY              
    , PERSON_ID              
    , SOB_ID                 
    , ORG_ID                 
    , ADD_BONUS_AMT          
    , ADD_EDUCATION_AMT      
    , ADD_ETC_AMT            
    , INCOME_OUTSIDE_AMT     
    , NONTAX_OUTSIDE_AMT     
    , TAX_OUTSIDE_AMT        
    , IN_TAX_AMT             
    , LOCAL_TAX_AMT          
    , ANNU_INSUR_AMT         
    , HIRE_MEDIC_INSUR_AMT   
    , HOUSE_SAVE_AMT         
    , HOUSE_ADD_AMT          
    , LONG_HOUSE_INTER_AMT   
    , LONG_HOUSE_INTER_AMT_1 
    , LONG_HOUSE_INTER_AMT_2 
    , SMALL_CORPOR_DED_AMT   
    , LONG_STOCK_SAVING_AMT_1
    , LONG_STOCK_SAVING_AMT_2
    , LONG_STOCK_SAVING_AMT_3
    , MARRY_COUNT            
    , FUNER_COUNT            
    , HOUSE_MOVE_COUNT       
    , PERSON_ANNU_AMT        
    , ANNU_BANK_AMT          
    , RETR_ANNU_AMT          
    , INVES_AMT              
    , INVES_AMT_1            
    , EMPL_STOCK_AMT  
    , TAX_ASSOCIATION_AMT       
    , ITL_REDUCTION_TAX_AMT  
    , STT_REDUCTION_TAX_AMT  
    , TT_REDUCTION_TAX_AMT   
    , HOUSE_DEBT_BEN_AMT     
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    , HOUSE_MONTHLY_AMT      
    , EMPLOYMENT_KEEP_AMT
    , HOUSE_ADD_AMT_RESIDENT
    , LONG_HOUSE_INTER_AMT_3_FIX 
    , LONG_HOUSE_INTER_AMT_3_ETC 
    , SMALL_BUSINESS_TAX_DED_FLAG 
    , FOREIGN_WORKER_TAX_DED_FLAG 
    , PRE_YEAR_OT_DED_FLAG
    ) VALUES
    ( P_YEAR_YYYY
    , P_PERSON_ID
    , P_SOB_ID
    , P_ORG_ID 
    , NVL(P_ADD_BONUS_AMT, 0)
    , NVL(P_ADD_EDUCATION_AMT, 0)
    , NVL(P_ADD_ETC_AMT, 0)
    , NVL(P_INCOME_OUTSIDE_AMT, 0)
    , NVL(P_NONTAX_OUTSIDE_AMT, 0)
    , NVL(P_TAX_OUTSIDE_AMT, 0)
    , NVL(P_IN_TAX_AMT, 0)
    , NVL(P_LOCAL_TAX_AMT, 0)
    , NVL(P_ANNU_INSUR_AMT, 0)
    , NVL(P_HIRE_MEDIC_INSUR_AMT, 0)
    , NVL(P_HOUSE_SAVE_AMT, 0)
    , NVL(P_HOUSE_ADD_AMT, 0)
    , NVL(P_LONG_HOUSE_INTER_AMT, 0)
    , NVL(P_LONG_HOUSE_INTER_AMT_1, 0)
    , NVL(P_LONG_HOUSE_INTER_AMT_2, 0)
    , NVL(P_SMALL_CORPOR_DED_AMT, 0)
    , NVL(P_LONG_STOCK_SAVING_AMT_1, 0)
    , NVL(P_LONG_STOCK_SAVING_AMT_2, 0)
    , NVL(P_LONG_STOCK_SAVING_AMT_3, 0)
    , NVL(P_MARRY_COUNT, 0)
    , NVL(P_FUNER_COUNT, 0)
    , NVL(P_HOUSE_MOVE_COUNT, 0)
    , NVL(P_PERSON_ANNU_AMT, 0)
    , NVL(P_ANNU_BANK_AMT, 0)
    , NVL(P_RETR_ANNU_AMT, 0)
    , NVL(P_INVES_AMT, 0)
    , NVL(P_INVES_AMT_1, 0)
    , NVL(P_EMPL_STOCK_AMT, 0)
    , NVL(P_TAX_ASSOCIATION_AMT, 0)
    , NVL(P_ITL_REDUCTION_TAX_AMT, 0)
    , NVL(P_STT_REDUCTION_TAX_AMT, 0)
    , NVL(P_TT_REDUCTION_TAX_AMT, 0)
    , NVL(P_HOUSE_DEBT_BEN_AMT, 0)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID                
    , NVL(P_HOUSE_MONTHLY_AMT, 0)
    , NVL(P_EMPLOYMENT_KEEP_AMT, 0)
    , NVL(P_HOUSE_ADD_AMT_RESIDENT, 0)
    , NVL(P_LONG_HOUSE_INTER_AMT_3_FIX, 0)
    , NVL(P_LONG_HOUSE_INTER_AMT_3_ETC, 0) 
    , NVL(P_SMALL_BUSINESS_TAX_DED_FLAG, 'N') 
    , NVL(P_FOREIGN_WORKER_TAX_DED_FLAG, 'N')
    , NVL(P_PRE_YEAR_OT_DED_FLAG, 'N') 
    );
   
  END INSERT_FOUNDATION;


----------------------------------------------------------------------------------
-- �������� �����ڷ� UPDATE
----------------------------------------------------------------------------------
  PROCEDURE UPDATE_FOUNDATION
            ( W_YEAR_YYYY                   IN  HRA_FOUNDATION.YEAR_YYYY%TYPE
            , W_PERSON_ID                   IN  HRA_FOUNDATION.PERSON_ID%TYPE
            , W_SOB_ID                      IN  HRA_FOUNDATION.SOB_ID%TYPE
            , W_ORG_ID                      IN  HRA_FOUNDATION.ORG_ID%TYPE
            , P_ADD_BONUS_AMT               IN  HRA_FOUNDATION.ADD_BONUS_AMT%TYPE
            , P_ADD_EDUCATION_AMT           IN  HRA_FOUNDATION.ADD_EDUCATION_AMT%TYPE
            , P_ADD_ETC_AMT                 IN  HRA_FOUNDATION.ADD_ETC_AMT%TYPE
            , P_INCOME_OUTSIDE_AMT          IN  HRA_FOUNDATION.INCOME_OUTSIDE_AMT%TYPE
            , P_NONTAX_OUTSIDE_AMT          IN  HRA_FOUNDATION.NONTAX_OUTSIDE_AMT%TYPE
            , P_TAX_OUTSIDE_AMT             IN  HRA_FOUNDATION.TAX_OUTSIDE_AMT%TYPE
            , P_IN_TAX_AMT                  IN  HRA_FOUNDATION.IN_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT               IN  HRA_FOUNDATION.LOCAL_TAX_AMT%TYPE
            , P_ANNU_INSUR_AMT              IN  HRA_FOUNDATION.ANNU_INSUR_AMT%TYPE
            , P_HIRE_MEDIC_INSUR_AMT        IN  HRA_FOUNDATION.HIRE_MEDIC_INSUR_AMT%TYPE
            , P_HOUSE_SAVE_AMT              IN  HRA_FOUNDATION.HOUSE_SAVE_AMT%TYPE
            , P_HOUSE_ADD_AMT               IN  HRA_FOUNDATION.HOUSE_ADD_AMT%TYPE
            , P_LONG_HOUSE_INTER_AMT        IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT%TYPE
            , P_LONG_HOUSE_INTER_AMT_1      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_1%TYPE
            , P_LONG_HOUSE_INTER_AMT_2      IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_2%TYPE
            , P_SMALL_CORPOR_DED_AMT        IN  HRA_FOUNDATION.SMALL_CORPOR_DED_AMT%TYPE
            , P_LONG_STOCK_SAVING_AMT_1     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_1%TYPE
            , P_LONG_STOCK_SAVING_AMT_2     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_2%TYPE
            , P_LONG_STOCK_SAVING_AMT_3     IN  HRA_FOUNDATION.LONG_STOCK_SAVING_AMT_3%TYPE
            , P_MARRY_COUNT                 IN  HRA_FOUNDATION.MARRY_COUNT%TYPE
            , P_FUNER_COUNT                 IN  HRA_FOUNDATION.FUNER_COUNT%TYPE
            , P_HOUSE_MOVE_COUNT            IN  HRA_FOUNDATION.HOUSE_MOVE_COUNT%TYPE
            , P_PERSON_ANNU_AMT             IN  HRA_FOUNDATION.PERSON_ANNU_AMT%TYPE
            , P_ANNU_BANK_AMT               IN  HRA_FOUNDATION.ANNU_BANK_AMT%TYPE
            , P_RETR_ANNU_AMT               IN  HRA_FOUNDATION.RETR_ANNU_AMT%TYPE
            , P_INVES_AMT                   IN  HRA_FOUNDATION.INVES_AMT%TYPE
            , P_INVES_AMT_1                 IN  HRA_FOUNDATION.INVES_AMT_1%TYPE
            , P_EMPL_STOCK_AMT              IN  HRA_FOUNDATION.EMPL_STOCK_AMT%TYPE
            , P_TAX_ASSOCIATION_AMT         IN  HRA_FOUNDATION.TAX_ASSOCIATION_AMT%TYPE
            , P_ITL_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.ITL_REDUCTION_TAX_AMT%TYPE
            , P_STT_REDUCTION_TAX_AMT       IN  HRA_FOUNDATION.STT_REDUCTION_TAX_AMT%TYPE
            , P_TT_REDUCTION_TAX_AMT        IN  HRA_FOUNDATION.TT_REDUCTION_TAX_AMT%TYPE          
            , P_HOUSE_DEBT_BEN_AMT          IN  HRA_FOUNDATION.HOUSE_DEBT_BEN_AMT%TYPE
            , P_USER_ID                     IN  HRA_FOUNDATION.CREATED_BY%TYPE
            , P_HOUSE_MONTHLY_AMT           IN  HRA_FOUNDATION.HOUSE_MONTHLY_AMT%TYPE
            , P_EMPLOYMENT_KEEP_AMT         IN  HRA_FOUNDATION.EMPLOYMENT_KEEP_AMT%TYPE 
            , P_HOUSE_ADD_AMT_RESIDENT      IN  HRA_FOUNDATION.HOUSE_ADD_AMT_RESIDENT%TYPE
            , P_LONG_HOUSE_INTER_AMT_3_FIX  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_FIX%TYPE
            , P_LONG_HOUSE_INTER_AMT_3_ETC  IN  HRA_FOUNDATION.LONG_HOUSE_INTER_AMT_3_ETC%TYPE
            , P_SMALL_BUSINESS_TAX_DED_FLAG IN  HRA_FOUNDATION.SMALL_BUSINESS_TAX_DED_FLAG%TYPE
            , P_FOREIGN_WORKER_TAX_DED_FLAG IN  HRA_FOUNDATION.FOREIGN_WORKER_TAX_DED_FLAG%TYPE
            , P_PRE_YEAR_OT_DED_FLAG        IN  HRA_FOUNDATION.PRE_YEAR_OT_DED_FLAG%TYPE
            )
  IS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_HOUSEHOLD_TYPE      VARCHAR2(3);  -- ������ ���� --
  BEGIN
    BEGIN
      SELECT PM.HOUSEHOLD_TYPE
        INTO V_HOUSEHOLD_TYPE
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID       = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HOUSEHOLD_TYPE := NULL;
    END;
    IF V_HOUSEHOLD_TYPE IS NULL THEN
      RAISE_APPLICATION_ERROR(-20001, '������ ���� ������ ã���� �����ϴ�. ������ ������ �Է��ϼ���');
      RETURN;
    END IF;
    
    IF V_HOUSEHOLD_TYPE != '1' AND 
      ( NVL(P_HOUSE_SAVE_AMT, 0) +   -- ���ø������� --
        NVL(P_HOUSE_ADD_AMT, 0) +  -- �����������Աݿ����ݻ�Ȳ��-������ --
        NVL(P_LONG_HOUSE_INTER_AMT, 0) +  -- ����������ڻ�ȯ(600����) --
        NVL(P_LONG_HOUSE_INTER_AMT_1, 0) +  -- ����������ڻ�ȯ(�ѵ�1000����) --
        NVL(P_LONG_HOUSE_INTER_AMT_2, 0) +  -- ����������ڻ�ȯ(�ѵ�1500����) --
        NVL(P_HOUSE_MONTHLY_AMT, 0) +  -- �����ҵ���� --
        NVL(P_HOUSE_ADD_AMT_RESIDENT, 0) +  -- �����������Աݿ����ݻ�ȯ��-������ --
        NVL(P_LONG_HOUSE_INTER_AMT_3_FIX, 0) +  -- ��������������Ա� ���ڻ�ȯ��(500����) �����ݸ��� --
        NVL(P_LONG_HOUSE_INTER_AMT_3_ETC, 0)  -- ��������������Ա� ���ڻ�ȯ��(500����) ��Ÿ
       ) > 0 THEN
      RAISE_APPLICATION_ERROR(-20001, '�����ֿ� ���ؼ��� ���ð��� �����ڷḦ �Է��� �� �ֽ��ϴ�. ������ ������ �Է��ϼ���');
      RETURN;
    END IF;

    UPDATE HRA_FOUNDATION
      SET ADD_BONUS_AMT               = NVL(P_ADD_BONUS_AMT, 0)
        , ADD_EDUCATION_AMT           = NVL(P_ADD_EDUCATION_AMT, 0)
        , ADD_ETC_AMT                 = NVL(P_ADD_ETC_AMT, 0)
        , INCOME_OUTSIDE_AMT          = NVL(P_INCOME_OUTSIDE_AMT, 0)
        , NONTAX_OUTSIDE_AMT          = NVL(P_NONTAX_OUTSIDE_AMT, 0)
        , TAX_OUTSIDE_AMT             = NVL(P_TAX_OUTSIDE_AMT, 0)
        , IN_TAX_AMT                  = NVL(P_IN_TAX_AMT, 0)
        , LOCAL_TAX_AMT               = NVL(P_LOCAL_TAX_AMT, 0)
        , ANNU_INSUR_AMT              = NVL(P_ANNU_INSUR_AMT, 0)
        , HIRE_MEDIC_INSUR_AMT        = NVL(P_HIRE_MEDIC_INSUR_AMT, 0)
        , HOUSE_SAVE_AMT              = NVL(P_HOUSE_SAVE_AMT, 0)
        , HOUSE_ADD_AMT               = NVL(P_HOUSE_ADD_AMT, 0)
        , LONG_HOUSE_INTER_AMT        = NVL(P_LONG_HOUSE_INTER_AMT, 0)
        , LONG_HOUSE_INTER_AMT_1      = NVL(P_LONG_HOUSE_INTER_AMT_1, 0)
        , LONG_HOUSE_INTER_AMT_2      = NVL(P_LONG_HOUSE_INTER_AMT_2, 0)
        , SMALL_CORPOR_DED_AMT        = NVL(P_SMALL_CORPOR_DED_AMT, 0)
        , LONG_STOCK_SAVING_AMT_1     = NVL(P_LONG_STOCK_SAVING_AMT_1, 0)
        , LONG_STOCK_SAVING_AMT_2     = NVL(P_LONG_STOCK_SAVING_AMT_2, 0)
        , LONG_STOCK_SAVING_AMT_3     = NVL(P_LONG_STOCK_SAVING_AMT_3, 0)
        , MARRY_COUNT                 = NVL(P_MARRY_COUNT, 0)
        , FUNER_COUNT                 = NVL(P_FUNER_COUNT, 0)
        , HOUSE_MOVE_COUNT            = NVL(P_HOUSE_MOVE_COUNT, 0)
        , PERSON_ANNU_AMT             = NVL(P_PERSON_ANNU_AMT, 0)
        , ANNU_BANK_AMT               = NVL(P_ANNU_BANK_AMT, 0)
        , RETR_ANNU_AMT               = NVL(P_RETR_ANNU_AMT, 0)
        , INVES_AMT                   = NVL(P_INVES_AMT, 0)
        , INVES_AMT_1                 = NVL(P_INVES_AMT_1, 0)
        , EMPL_STOCK_AMT              = NVL(P_EMPL_STOCK_AMT, 0)
        , TAX_ASSOCIATION_AMT         = NVL(P_TAX_ASSOCIATION_AMT, 0)
        , ITL_REDUCTION_TAX_AMT       = NVL(P_ITL_REDUCTION_TAX_AMT, 0)
        , STT_REDUCTION_TAX_AMT       = NVL(P_STT_REDUCTION_TAX_AMT, 0)
        , TT_REDUCTION_TAX_AMT        = NVL(P_TT_REDUCTION_TAX_AMT, 0)
        , HOUSE_DEBT_BEN_AMT          = NVL(P_HOUSE_DEBT_BEN_AMT, 0)
        , LAST_UPDATE_DATE            = V_SYSDATE
        , LAST_UPDATED_BY             = P_USER_ID
        , HOUSE_MONTHLY_AMT           = NVL(P_HOUSE_MONTHLY_AMT, 0)
        , EMPLOYMENT_KEEP_AMT         = NVL(P_EMPLOYMENT_KEEP_AMT, 0)
        , HOUSE_ADD_AMT_RESIDENT      = NVL(P_HOUSE_ADD_AMT_RESIDENT, 0)
        , LONG_HOUSE_INTER_AMT_3_FIX  = NVL(P_LONG_HOUSE_INTER_AMT_3_FIX, 0)
        , LONG_HOUSE_INTER_AMT_3_ETC  = NVL(P_LONG_HOUSE_INTER_AMT_3_ETC, 0) 
        , SMALL_BUSINESS_TAX_DED_FLAG = NVL(P_SMALL_BUSINESS_TAX_DED_FLAG, 'N') 
        , FOREIGN_WORKER_TAX_DED_FLAG = NVL(P_FOREIGN_WORKER_TAX_DED_FLAG, 'N') 
        , PRE_YEAR_OT_DED_FLAG        = NVL(P_PRE_YEAR_OT_DED_FLAG, 'N')
    WHERE YEAR_YYYY               = W_YEAR_YYYY
      AND PERSON_ID               = W_PERSON_ID
      AND SOB_ID                  = W_SOB_ID
      AND ORG_ID                  = W_ORG_ID;
    
    IF SQL%ROWCOUNT = 0 THEN
       INSERT_FOUNDATION
         ( P_YEAR_YYYY                   => W_YEAR_YYYY
         , P_PERSON_ID                   => W_PERSON_ID
         , P_SOB_ID                      => W_SOB_ID
         , P_ORG_ID                      => W_ORG_ID
         , P_ADD_BONUS_AMT               => P_ADD_BONUS_AMT
         , P_ADD_EDUCATION_AMT           => P_ADD_EDUCATION_AMT
         , P_ADD_ETC_AMT                 => P_ADD_ETC_AMT
         , P_INCOME_OUTSIDE_AMT          => P_INCOME_OUTSIDE_AMT
         , P_NONTAX_OUTSIDE_AMT          => P_NONTAX_OUTSIDE_AMT      
         , P_TAX_OUTSIDE_AMT             => P_TAX_OUTSIDE_AMT         
         , P_IN_TAX_AMT                  => P_IN_TAX_AMT              
         , P_LOCAL_TAX_AMT               => P_LOCAL_TAX_AMT           
         , P_ANNU_INSUR_AMT              => P_ANNU_INSUR_AMT          
         , P_HIRE_MEDIC_INSUR_AMT        => P_HIRE_MEDIC_INSUR_AMT    
         , P_HOUSE_SAVE_AMT              => P_HOUSE_SAVE_AMT          
         , P_HOUSE_ADD_AMT               => P_HOUSE_ADD_AMT           
         , P_LONG_HOUSE_INTER_AMT        => P_LONG_HOUSE_INTER_AMT    
         , P_LONG_HOUSE_INTER_AMT_1      => P_LONG_HOUSE_INTER_AMT_1  
         , P_LONG_HOUSE_INTER_AMT_2      => P_LONG_HOUSE_INTER_AMT_2
         , P_SMALL_CORPOR_DED_AMT        => P_SMALL_CORPOR_DED_AMT    
         , P_LONG_STOCK_SAVING_AMT_1     => P_LONG_STOCK_SAVING_AMT_1 
         , P_LONG_STOCK_SAVING_AMT_2     => P_LONG_STOCK_SAVING_AMT_2 
         , P_LONG_STOCK_SAVING_AMT_3     => P_LONG_STOCK_SAVING_AMT_3 
         , P_MARRY_COUNT                 => P_MARRY_COUNT             
         , P_FUNER_COUNT                 => P_FUNER_COUNT             
         , P_HOUSE_MOVE_COUNT            => P_HOUSE_MOVE_COUNT        
         , P_PERSON_ANNU_AMT             => P_PERSON_ANNU_AMT         
         , P_ANNU_BANK_AMT               => P_ANNU_BANK_AMT           
         , P_RETR_ANNU_AMT               => P_RETR_ANNU_AMT           
         , P_INVES_AMT                   => P_INVES_AMT               
         , P_INVES_AMT_1                 => P_INVES_AMT_1             
         , P_EMPL_STOCK_AMT              => P_EMPL_STOCK_AMT          
         , P_TAX_ASSOCIATION_AMT         => P_TAX_ASSOCIATION_AMT
         , P_ITL_REDUCTION_TAX_AMT       => P_ITL_REDUCTION_TAX_AMT   
         , P_STT_REDUCTION_TAX_AMT       => P_STT_REDUCTION_TAX_AMT   
         , P_TT_REDUCTION_TAX_AMT        => P_TT_REDUCTION_TAX_AMT    
         , P_HOUSE_DEBT_BEN_AMT          => P_HOUSE_DEBT_BEN_AMT      
         , P_USER_ID                     => P_USER_ID                 
         , P_HOUSE_MONTHLY_AMT           => P_HOUSE_MONTHLY_AMT       
         , P_EMPLOYMENT_KEEP_AMT         => P_EMPLOYMENT_KEEP_AMT
         , P_HOUSE_ADD_AMT_RESIDENT      => P_HOUSE_ADD_AMT_RESIDENT     
         , P_LONG_HOUSE_INTER_AMT_3_FIX  => P_LONG_HOUSE_INTER_AMT_3_FIX
         , P_LONG_HOUSE_INTER_AMT_3_ETC  => P_LONG_HOUSE_INTER_AMT_3_ETC
         , P_SMALL_BUSINESS_TAX_DED_FLAG => P_SMALL_BUSINESS_TAX_DED_FLAG
         , P_FOREIGN_WORKER_TAX_DED_FLAG => P_FOREIGN_WORKER_TAX_DED_FLAG
         , P_PRE_YEAR_OT_DED_FLAG        => P_PRE_YEAR_OT_DED_FLAG
         );
    END IF;
    
  END UPDATE_FOUNDATION;         

----------------------------------------------------------------------------------
-- �������� �����ڷ� DELETE
----------------------------------------------------------------------------------
  PROCEDURE DELETE_FOUNDATION
          ( W_YEAR_YYYY  HRA_FOUNDATION.YEAR_YYYY%TYPE
          , W_PERSON_ID  HRA_FOUNDATION.PERSON_ID%TYPE
          , P_SOB_ID     HRA_FOUNDATION.SOB_ID%TYPE
          , P_ORG_ID     HRA_FOUNDATION.ORG_ID%TYPE 
          )
  AS
  BEGIN
    DELETE HRA_FOUNDATION
    WHERE YEAR_YYYY = W_YEAR_YYYY
      AND PERSON_ID = W_PERSON_ID
      AND SOB_ID    = P_SOB_ID
      AND ORG_ID    = P_ORG_ID;   

  END DELETE_FOUNDATION;         

END HRA_FOUNDATION_G;
/
