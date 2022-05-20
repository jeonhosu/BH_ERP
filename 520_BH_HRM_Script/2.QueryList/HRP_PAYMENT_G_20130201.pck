CREATE OR REPLACE PACKAGE HRP_PAYMENT_G
AS

-- PAYMENT TERM(START_YYYYMM ~ END_YYYYMM) SELECT
  PROCEDURE PAYMENT_TERM_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );

-- ���κ����� ��ȸ �μ�.
  PROCEDURE PRINT_PAYMENT_TERM
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- ����/�����ϼ� ��ȯ.
  FUNCTION MONTH_HOLY_COUNT_F
            ( W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_PAY_YYYYMM                        IN VARCHAR2
            , W_WAGE_TYPE                         IN VARCHAR2
            , W_HOLY_TYPE                         IN VARCHAR2
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;
            
END HRP_PAYMENT_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_PAYMENT_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_PAYMENT_G
/* DESCRIPTION  : �޻󿩰��� ��ȸ�� ����.
/* REFERENCE BY :
/* PROGRAM HISTORY : �ű� ����
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- PAYMENT TERM(START_YYYYMM ~ END_YYYYMM) SELECT
  PROCEDURE PAYMENT_TERM_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT TO_CHAR(HMP.PERSON_ID) AS PERSON_ID
           , CASE
               WHEN GROUPING(HMP.PERSON_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045')
               ELSE HMP.PAY_YYYYMM
             END AS PAY_YYYYMM
           , NVL(SUM(HMP.PAY_AMOUNT), 0) AS PAY_AMOUNT
           , NVL(SUM(HMP.BONUS_AMOUNT), 0) AS BONUS_AMOUNT
           , NVL(SUM(HMP.TOT_SUPPLY_AMOUNT), 0) AS TOT_SUPPLY_AMOUNT
           , NVL(SUM(HMD.PENSION_INSUR), 0) AS PENSION_INSUR
           , NVL(SUM(HMD.HEALTH_INSUR), 0) AS HEALTH_INSUR
           , NVL(SUM(HMD.EMPLOYMENT_INSUR), 0) AS EMPLOYMENT_INSUR
           , NVL(SUM(HMD.INCOME_TAX), 0) AS INCOME_TAX
           , NVL(SUM(HMD.RESIDENTS_TAX), 0) AS RESIDENTS_TAX
           , NVL(SUM(HMP.DED_PAY_AMOUNT), 0) AS DED_PAY_AMOUNT
           , NVL(SUM(HMP.DED_BONUS_AMOUNT), 0) AS DED_BONUS_AMOUNT
           , NVL(SUM(HMP.TOT_DED_AMOUNT), 0) AS TOT_DED_AMOUNT
           , NVL(SUM(HMP.REAL_AMOUNT), 0) AS REAL_AMOUNT
        FROM HRP_MONTH_PAYMENT HMP
          , ( SELECT MD.MONTH_PAYMENT_ID
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D01', MD.DEDUCTION_AMOUNT, 0)) AS INCOME_TAX       -- �ҵ漼.
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D02', MD.DEDUCTION_AMOUNT, 0)) AS RESIDENTS_TAX    -- �ֹμ�.
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D03', MD.DEDUCTION_AMOUNT, 0)) AS PENSION_INSUR    -- ���ο���.
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D04', MD.DEDUCTION_AMOUNT, 0)) AS EMPLOYMENT_INSUR -- ��뺸��.
                   , SUM(CASE 
                           WHEN DV.DEDUCTION_CODE IN('D05', 'D06', 'D07') THEN MD.DEDUCTION_AMOUNT
                           ELSE 0
                         END) AS HEALTH_INSUR     -- �ǰ�����.
                FROM HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V DV
               WHERE MD.DEDUCTION_ID  = DV.DEDUCTION_ID
                 AND MD.PAY_YYYYMM    BETWEEN W_START_YYYYMM AND W_END_YYYYMM
                 AND MD.CORP_ID       = W_CORP_ID
                 AND MD.PERSON_ID     = W_PERSON_ID
                 AND MD.SOB_ID        = W_SOB_ID
                 AND MD.ORG_ID        = W_ORG_ID
               GROUP BY MD.MONTH_PAYMENT_ID
            ) HMD
       WHERE HMP.MONTH_PAYMENT_ID     = HMD.MONTH_PAYMENT_ID(+)
         AND HMP.PERSON_ID            = W_PERSON_ID
         AND HMP.PAY_YYYYMM           BETWEEN W_START_YYYYMM AND W_END_YYYYMM
         AND HMP.WAGE_TYPE            IN ('P1', 'P2', 'P3', 'P4', 'P5')
         AND HMP.CORP_ID              = W_CORP_ID
         AND HMP.DEPT_ID              = NVL(W_DEPT_ID, HMP.DEPT_ID)
         AND HMP.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, HMP.PAY_GRADE_ID)
         AND HMP.SOB_ID               = W_SOB_ID
         AND HMP.ORG_ID               = W_ORG_ID
      GROUP BY ROLLUP((HMP.PERSON_ID
                       , HMP.PAY_YYYYMM));
                       
      /*SELECT HMP.PAY_YYYYMM
           , NVL(SUM(HMP.PAY_AMOUNT), 0) AS PAY_AMOUNT
           , NVL(SUM(HMP.BONUS_AMOUNT), 0) AS BONUS_AMOUNT
           , NVL(SUM(HMP.TOT_SUPPLY_AMOUNT), 0) AS TOT_SUPPLY_AMOUNT
           , NVL(SUM(HMD.PENSION_INSUR), 0) AS PENSION_INSUR
           , NVL(SUM(HMD.HEALTH_INSUR), 0) AS HEALTH_INSUR
           , NVL(SUM(HMD.EMPLOYMENT_INSUR), 0) AS EMPLOYMENT_INSUR
           , NVL(SUM(HMD.INCOME_TAX), 0) AS INCOME_TAX
           , NVL(SUM(HMD.RESIDENTS_TAX), 0) AS RESIDENTS_TAX
           , NVL(SUM(HMP.DED_PAY_AMOUNT), 0) AS DED_PAY_AMOUNT
           , NVL(SUM(HMP.DED_BONUS_AMOUNT), 0) AS DED_BONUS_AMOUNT
           , NVL(SUM(HMP.TOT_DED_AMOUNT), 0) AS TOT_DED_AMOUNT
           , NVL(SUM(HMP.REAL_AMOUNT), 0) AS REAL_AMOUNT
        FROM HRP_MONTH_PAYMENT HMP
          , ( SELECT MD.MONTH_PAYMENT_ID
                   , MD.DEDUCTION_ID
                   , DV.DEDUCTION_CODE
                   , DV.DEDUCTION_NAME
                   , DECODE(DV.DEDUCTION_CODE, 'D01', MD.DEDUCTION_AMOUNT, 0) AS INCOME_TAX       -- �ҵ漼.
                   , DECODE(DV.DEDUCTION_CODE, 'D02', MD.DEDUCTION_AMOUNT, 0) AS RESIDENTS_TAX    -- �ֹμ�.
                   , DECODE(DV.DEDUCTION_CODE, 'D03', MD.DEDUCTION_AMOUNT, 0) AS PENSION_INSUR    -- ���ο���.
                   , DECODE(DV.DEDUCTION_CODE, 'D04', MD.DEDUCTION_AMOUNT, 0) AS EMPLOYMENT_INSUR -- ��뺸��.
                   , CASE 
                       WHEN DV.DEDUCTION_CODE IN('D05', 'D06') THEN MD.DEDUCTION_AMOUNT
                       ELSE 0
                     END AS HEALTH_INSUR     -- �ǰ�����.
                FROM HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V DV
               WHERE MD.DEDUCTION_ID  = DV.DEDUCTION_ID
                 AND MD.PAY_YYYYMM    BETWEEN W_START_YYYYMM AND W_END_YYYYMM
                 AND MD.CORP_ID       = W_CORP_ID
                 AND MD.PERSON_ID     = W_PERSON_ID
                 AND MD.SOB_ID        = W_SOB_ID
                 AND MD.ORG_ID        = W_ORG_ID
            ) HMD
       WHERE HMP.MONTH_PAYMENT_ID     = HMD.MONTH_PAYMENT_ID(+)
         AND HMP.PERSON_ID            = W_PERSON_ID
         AND HMP.PAY_YYYYMM           BETWEEN W_START_YYYYMM AND W_END_YYYYMM
         AND HMP.WAGE_TYPE            IN ('P1', 'P2', 'P3', 'P5')
         AND HMP.CORP_ID              = W_CORP_ID
         AND HMP.DEPT_ID              = NVL(W_DEPT_ID, HMP.DEPT_ID)
         AND HMP.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, HMP.PAY_GRADE_ID)
         AND HMP.SOB_ID               = W_SOB_ID
         AND HMP.ORG_ID               = W_ORG_ID         
      GROUP BY HMP.PAY_YYYYMM, HMP.PERSON_ID
      ;*/
  END PAYMENT_TERM_SELECT;

-- ���κ����� ��ȸ �μ�.
  PROCEDURE PRINT_PAYMENT_TERM
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT PM.PERSON_NUM AS PERSON_NUMBER  -- �����ȣ.
           , PM.NAME       AS PERSON_NAME    -- ����.
           , PM.DEPT_NAME   -- �μ�.
           , PM.FLOOR_NAME  -- �۾���.
           , PM.POST_NAME   -- ����.
           , CASE
               WHEN GROUPING(PM.PERSON_NUM) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045')
               ELSE SUBSTR(HMP.PAY_YYYYMM, 1, 4)
             END AS PAY_YYYY  -- ���޳⵵.
           , NVL(SUM(HMP.PAY_AMOUNT), 0) AS PAY_AMOUNT  -- �޿�.
           , NVL(SUM(HMP.BONUS_AMOUNT), 0) AS BONUS_AMOUNT  -- ��.
           , NVL(SUM(HMP.TOT_SUPPLY_AMOUNT), 0) AS TOT_SUPPLY_AMOUNT  -- �����޾�.
           , NVL(SUM(HMD.PENSION_INSUR), 0) AS PENSION_INSUR  -- ���ο���.
           , NVL(SUM(HMD.HEALTH_INSUR), 0) AS HEALTH_INSUR    -- �ǰ�����.
           , NVL(SUM(HMD.EMPLOYMENT_INSUR), 0) AS EMPLOYMENT_INSUR  -- ��뺸��.
           , NVL(SUM(HMD.INCOME_TAX), 0) AS INCOME_TAX              -- �ҵ漼.
           , NVL(SUM(HMD.RESIDENTS_TAX), 0) AS RESIDENTS_TAX        -- �ֹμ�.
           , NVL(SUM(HMP.DED_PAY_AMOUNT), 0) AS DED_PAY_AMOUNT      -- �޿�������.
           , NVL(SUM(HMP.DED_BONUS_AMOUNT), 0) AS DED_BONUS_AMOUNT  -- �󿩰�����.
           , NVL(SUM(HMP.TOT_DED_AMOUNT), 0) AS TOT_DED_AMOUNT      -- �Ѱ�����.
           , NVL(SUM(HMP.REAL_AMOUNT), 0) AS REAL_AMOUNT            -- �����޾�.
        FROM HRP_MONTH_PAYMENT HMP
          , HRM_PERSON_MASTER_V1 PM
          , ( SELECT MD.MONTH_PAYMENT_ID
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D01', MD.DEDUCTION_AMOUNT, 0)) AS INCOME_TAX       -- �ҵ漼.
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D02', MD.DEDUCTION_AMOUNT, 0)) AS RESIDENTS_TAX    -- �ֹμ�.
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D03', MD.DEDUCTION_AMOUNT, 0)) AS PENSION_INSUR    -- ���ο���.
                   , SUM(DECODE(DV.DEDUCTION_CODE, 'D04', MD.DEDUCTION_AMOUNT, 0)) AS EMPLOYMENT_INSUR -- ��뺸��.
                   , SUM(CASE 
                           WHEN DV.DEDUCTION_CODE IN('D05', 'D06', 'D07') THEN MD.DEDUCTION_AMOUNT
                           ELSE 0
                         END) AS HEALTH_INSUR     -- �ǰ�����.
                FROM HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V DV
               WHERE MD.DEDUCTION_ID  = DV.DEDUCTION_ID
                 AND MD.PAY_YYYYMM    BETWEEN W_START_YYYYMM AND W_END_YYYYMM
                 AND MD.CORP_ID       = W_CORP_ID
                 AND MD.PERSON_ID     = NVL(W_PERSON_ID, MD.PERSON_ID)
                 AND MD.SOB_ID        = W_SOB_ID
                 AND MD.ORG_ID        = W_ORG_ID
               GROUP BY MD.MONTH_PAYMENT_ID
            ) HMD
       WHERE HMP.PERSON_ID            = PM.PERSON_ID
         AND HMP.MONTH_PAYMENT_ID     = HMD.MONTH_PAYMENT_ID(+)
         AND HMP.PERSON_ID            = NVL(W_PERSON_ID, HMP.PERSON_ID)
         AND HMP.PAY_YYYYMM           BETWEEN W_START_YYYYMM AND W_END_YYYYMM
         AND HMP.WAGE_TYPE            IN ('P1', 'P2', 'P3', 'P4', 'P5')
         AND HMP.CORP_ID              = W_CORP_ID
         AND HMP.DEPT_ID              = NVL(W_DEPT_ID, HMP.DEPT_ID)
         AND HMP.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, HMP.PAY_GRADE_ID)
         AND HMP.SOB_ID               = W_SOB_ID
         AND HMP.ORG_ID               = W_ORG_ID
      GROUP BY ROLLUP((  PM.DEPT_CODE
                       , PM.NAME
                       , PM.PERSON_NUM
                       , SUBSTR(HMP.PAY_YYYYMM, 1, 4)
                       , PM.DEPT_NAME
                       , PM.FLOOR_NAME
                       , PM.POST_NAME));
                       
  END PRINT_PAYMENT_TERM;
  
---------------------------------------------------------------------------------------------------
-- ����/�����ϼ� ��ȯ.
  FUNCTION MONTH_HOLY_COUNT_F
            ( W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_PAY_YYYYMM                        IN VARCHAR2
            , W_WAGE_TYPE                         IN VARCHAR2
            , W_HOLY_TYPE                         IN VARCHAR2
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_HOLY_COUNT                                  NUMBER := 0;
    V_START_DATE                                  DATE;
    V_END_DATE                                    DATE;    
  BEGIN
    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => W_PAY_YYYYMM
                      , W_WAGE_TYPE => NVL(W_WAGE_TYPE, 'P1')
                      , W_PAY_TYPE => '1'
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
    IF W_HOLY_TYPE = '1' THEN
      V_HOLY_COUNT := HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(W_PERSON_ID, V_START_DATE, V_END_DATE, W_SOB_ID, W_ORG_ID);
    ELSIF W_HOLY_TYPE = '0' THEN
      V_HOLY_COUNT := HRD_WORK_CALENDAR_G.HOLY_0_COUNT_F(W_PERSON_ID, V_START_DATE, V_END_DATE, W_SOB_ID, W_ORG_ID);
    ELSE
      V_HOLY_COUNT := 0;       
    END IF;
    RETURN V_HOLY_COUNT;
  END MONTH_HOLY_COUNT_F;
  
END HRP_PAYMENT_G;
/
