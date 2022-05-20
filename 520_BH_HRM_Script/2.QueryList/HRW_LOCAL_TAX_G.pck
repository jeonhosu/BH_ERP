CREATE OR REPLACE PACKAGE HRW_LOCAL_TAX_G
AS

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ ¸®½ºÆ®.
  PROCEDURE SELECT_LOCAL_TAX_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

---------------------------------------------------------------------------------------------------
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ Á¶È¸.
  PROCEDURE SELECT_LOCAL_TAX_DOC
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_LOCAL_TAX_ID          IN NUMBER
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            );

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ INSERT.
  PROCEDURE INSERT_LOCAL_TAX_DOC
            ( P_LOCAL_TAX_ID         OUT HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_LOCAL_TAX_NO         OUT HRW_LOCAL_TAX_DOC.LOCAL_TAX_NO%TYPE
            , P_CORP_ID              IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_SOB_ID               IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID               IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_LOCAL_TAX_TYPE       IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_TYPE%TYPE
            , P_STD_YYYYMM           IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM           IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE          IN HRW_LOCAL_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PRE_LOCAL_TAX_NO     IN HRW_LOCAL_TAX_DOC.PRE_LOCAL_TAX_NO%TYPE
            , P_PAY_SUPPLY_DATE      IN HRW_LOCAL_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER          IN HRW_LOCAL_TAX_DOC.TAX_OFFICER%TYPE
            , P_A01_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A01_PERSON_CNT%TYPE
            , P_A01_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A01_STD_TAX_AMT%TYPE
            , P_A01_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A01_LOCAL_TAX_AMT%TYPE
            , P_A02_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A02_PERSON_CNT%TYPE
            , P_A02_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A02_STD_TAX_AMT%TYPE
            , P_A02_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A02_LOCAL_TAX_AMT%TYPE
            , P_A03_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A03_PERSON_CNT%TYPE
            , P_A03_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A03_STD_TAX_AMT%TYPE
            , P_A03_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A03_LOCAL_TAX_AMT%TYPE
            , P_A04_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A04_PERSON_CNT%TYPE
            , P_A04_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A04_STD_TAX_AMT%TYPE
            , P_A04_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A04_LOCAL_TAX_AMT%TYPE
            , P_A05_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A05_PERSON_CNT%TYPE
            , P_A05_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A05_STD_TAX_AMT%TYPE
            , P_A05_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A05_LOCAL_TAX_AMT%TYPE
            , P_A06_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A06_PERSON_CNT%TYPE
            , P_A06_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A06_STD_TAX_AMT%TYPE
            , P_A06_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A06_LOCAL_TAX_AMT%TYPE
            , P_A07_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A07_PERSON_CNT%TYPE
            , P_A07_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A07_STD_TAX_AMT%TYPE
            , P_A07_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A07_LOCAL_TAX_AMT%TYPE
            , P_A08_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A08_PERSON_CNT%TYPE
            , P_A08_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A08_STD_TAX_AMT%TYPE
            , P_A08_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A08_LOCAL_TAX_AMT%TYPE
            , P_A09_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A09_PERSON_CNT%TYPE
            , P_A09_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A09_STD_TAX_AMT%TYPE
            , P_A09_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A09_LOCAL_TAX_AMT%TYPE
            , P_A10_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A10_PERSON_CNT%TYPE
            , P_A10_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A10_STD_TAX_AMT%TYPE
            , P_A10_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A10_LOCAL_TAX_AMT%TYPE
            , P_A90_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A90_PERSON_CNT%TYPE
            , P_A90_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A90_STD_TAX_AMT%TYPE
            , P_A90_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A90_LOCAL_TAX_AMT%TYPE
            , P_TOTAL_ADJUST_TAX_AMT IN HRW_LOCAL_TAX_DOC.TOTAL_ADJUST_TAX_AMT%TYPE
            , P_PAY_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.PAY_LOCAL_TAX_AMT%TYPE
            , P_K10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K10_TAX_AMT%TYPE
            , P_K20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K20_TAX_AMT%TYPE
            , P_K30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K30_TAX_AMT%TYPE
            , P_K40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K40_TAX_AMT%TYPE
            , P_R10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R10_TAX_AMT%TYPE
            , P_R20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R20_TAX_AMT%TYPE
            , P_R30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R30_TAX_AMT%TYPE
            , P_R40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R40_TAX_AMT%TYPE
            , P_USER_ID              IN HRW_LOCAL_TAX_DOC.CREATED_BY%TYPE
            );

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ UPDATE.
  PROCEDURE UPDATE_LOCAL_TAX_DOC
            ( W_LOCAL_TAX_ID         IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID               IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID               IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_LOCAL_TAX_TYPE       IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_TYPE%TYPE
            , P_STD_YYYYMM           IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM           IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE          IN HRW_LOCAL_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PRE_LOCAL_TAX_NO     IN HRW_LOCAL_TAX_DOC.PRE_LOCAL_TAX_NO%TYPE
            , P_PAY_SUPPLY_DATE      IN HRW_LOCAL_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER          IN HRW_LOCAL_TAX_DOC.TAX_OFFICER%TYPE
            , P_A01_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A01_PERSON_CNT%TYPE
            , P_A01_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A01_STD_TAX_AMT%TYPE
            , P_A01_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A01_LOCAL_TAX_AMT%TYPE
            , P_A02_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A02_PERSON_CNT%TYPE
            , P_A02_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A02_STD_TAX_AMT%TYPE
            , P_A02_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A02_LOCAL_TAX_AMT%TYPE
            , P_A03_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A03_PERSON_CNT%TYPE
            , P_A03_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A03_STD_TAX_AMT%TYPE
            , P_A03_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A03_LOCAL_TAX_AMT%TYPE
            , P_A04_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A04_PERSON_CNT%TYPE
            , P_A04_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A04_STD_TAX_AMT%TYPE
            , P_A04_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A04_LOCAL_TAX_AMT%TYPE
            , P_A05_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A05_PERSON_CNT%TYPE
            , P_A05_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A05_STD_TAX_AMT%TYPE
            , P_A05_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A05_LOCAL_TAX_AMT%TYPE
            , P_A06_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A06_PERSON_CNT%TYPE
            , P_A06_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A06_STD_TAX_AMT%TYPE
            , P_A06_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A06_LOCAL_TAX_AMT%TYPE
            , P_A07_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A07_PERSON_CNT%TYPE
            , P_A07_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A07_STD_TAX_AMT%TYPE
            , P_A07_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A07_LOCAL_TAX_AMT%TYPE
            , P_A08_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A08_PERSON_CNT%TYPE
            , P_A08_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A08_STD_TAX_AMT%TYPE
            , P_A08_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A08_LOCAL_TAX_AMT%TYPE
            , P_A09_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A09_PERSON_CNT%TYPE
            , P_A09_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A09_STD_TAX_AMT%TYPE
            , P_A09_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A09_LOCAL_TAX_AMT%TYPE
            , P_A10_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A10_PERSON_CNT%TYPE
            , P_A10_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A10_STD_TAX_AMT%TYPE
            , P_A10_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A10_LOCAL_TAX_AMT%TYPE
            , P_A90_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A90_PERSON_CNT%TYPE
            , P_A90_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A90_STD_TAX_AMT%TYPE
            , P_A90_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A90_LOCAL_TAX_AMT%TYPE
            , P_TOTAL_ADJUST_TAX_AMT IN HRW_LOCAL_TAX_DOC.TOTAL_ADJUST_TAX_AMT%TYPE
            , P_PAY_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.PAY_LOCAL_TAX_AMT%TYPE
            , P_K10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K10_TAX_AMT%TYPE
            , P_K20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K20_TAX_AMT%TYPE
            , P_K30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K30_TAX_AMT%TYPE
            , P_K40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K40_TAX_AMT%TYPE
            , P_R10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R10_TAX_AMT%TYPE
            , P_R20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R20_TAX_AMT%TYPE
            , P_R30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R30_TAX_AMT%TYPE
            , P_R40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R40_TAX_AMT%TYPE
            , P_USER_ID              IN HRW_LOCAL_TAX_DOC.CREATED_BY%TYPE 
            );

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ »èÁ¦.
  PROCEDURE DELETE_LOCAL_TAX_DOC
            ( W_LOCAL_TAX_ID               IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID                     IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                     IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼¼­ ÀÎ¼â.
  PROCEDURE PRINT_LOCAL_TAX_DOC
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            );

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö³³ºÎ¼­ ÀÎ¼â.
  PROCEDURE PRINT_LOCAL_TAX_DOC_2
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ ¸®½ºÆ® ·è¾÷.
  PROCEDURE LU_LOCAL_TAX_LIST
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

END HRW_LOCAL_TAX_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_LOCAL_TAX_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_LOCAL_TAX_G
/* DESCRIPTION  : ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ °ü¸®
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ ¸®½ºÆ®.
  PROCEDURE SELECT_LOCAL_TAX_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT TD.LOCAL_TAX_NO
          , TD.LOCAL_TAX_TYPE
          , HRM_COMMON_G.CODE_NAME_F('OFFICE_TAX_TYPE', TD.LOCAL_TAX_TYPE, TD.SOB_ID, TD.ORG_ID) AS LOCAL_TAX_TYPE_DESC
          , TD.SUBMIT_DATE
          , TD.STD_YYYYMM
          , TD.PAY_YYYYMM
          , NVL(TD.K10_TAX_AMT, 0) + NVL(TD.R10_TAX_AMT, 0) AS K10_TAX_AMT
          , TD.PAY_LOCAL_TAX_AMT
          , NVL(TD.K40_TAX_AMT, 0) + NVL(TD.R40_TAX_AMT, 0) AS K40_TAX_AMT
          , TD.TAX_OFFICER
          , TD.CLOSED_YN
          , TD.LOCAL_TAX_ID
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE TD.CORP_ID                  = P_CORP_ID
        AND TD.SOB_ID                   = P_SOB_ID
        AND TD.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(TD.SUBMIT_DATE, 'YYYY') = P_SUBMIT_YEAR
      ORDER BY TD.LOCAL_TAX_NO DESC
      ;
  END SELECT_LOCAL_TAX_LIST;

---------------------------------------------------------------------------------------------------
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ Á¶È¸.
  PROCEDURE SELECT_LOCAL_TAX_DOC
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_LOCAL_TAX_ID          IN NUMBER
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT TD.LOCAL_TAX_ID
          , TD.LOCAL_TAX_NO
          , TD.LOCAL_TAX_TYPE
          , HRM_COMMON_G.CODE_NAME_F('WITHHOLDING_TYPE', TD.LOCAL_TAX_TYPE, TD.SOB_ID, TD.ORG_ID) AS LOCAL_TAX_TYPE_DESC
          , TD.STD_YYYYMM
          , TD.PAY_YYYYMM
          , TD.SUBMIT_DATE
          , TD.PRE_LOCAL_TAX_NO
          , TD.PAY_SUPPLY_DATE
          , TD.TAX_OFFICER
          , TD.A01_PERSON_CNT
          , TD.A01_STD_TAX_AMT
          , TD.A01_LOCAL_TAX_AMT
          , TD.A02_PERSON_CNT
          , TD.A02_STD_TAX_AMT
          , TD.A02_LOCAL_TAX_AMT
          , TD.A03_PERSON_CNT
          , TD.A03_STD_TAX_AMT
          , TD.A03_LOCAL_TAX_AMT
          , TD.A04_PERSON_CNT
          , TD.A04_STD_TAX_AMT
          , TD.A04_LOCAL_TAX_AMT
          , TD.A05_PERSON_CNT
          , TD.A05_STD_TAX_AMT
          , TD.A05_LOCAL_TAX_AMT
          , TD.A06_PERSON_CNT
          , TD.A06_STD_TAX_AMT
          , TD.A06_LOCAL_TAX_AMT
          , TD.A07_PERSON_CNT
          , TD.A07_STD_TAX_AMT
          , TD.A07_LOCAL_TAX_AMT
          , TD.A08_PERSON_CNT
          , TD.A08_STD_TAX_AMT
          , TD.A08_LOCAL_TAX_AMT
          , TD.A09_PERSON_CNT
          , TD.A09_STD_TAX_AMT
          , TD.A09_LOCAL_TAX_AMT
          , TD.A10_PERSON_CNT
          , TD.A10_STD_TAX_AMT
          , TD.A10_LOCAL_TAX_AMT
          , TD.A90_PERSON_CNT
          , TD.A90_STD_TAX_AMT
          , TD.A90_LOCAL_TAX_AMT
          , TD.TOTAL_ADJUST_TAX_AMT
          , TD.PAY_LOCAL_TAX_AMT
          , TD.K10_TAX_AMT
          , TD.K20_TAX_AMT
          , TD.K30_TAX_AMT
          , TD.K40_TAX_AMT
          , TD.R10_TAX_AMT
          , TD.R20_TAX_AMT
          , TD.R30_TAX_AMT
          , TD.R40_TAX_AMT          
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE TD.LOCAL_TAX_ID             = P_LOCAL_TAX_ID
        AND TD.SOB_ID                   = P_SOB_ID
        AND TD.ORG_ID                   = P_ORG_ID
      ;
  END SELECT_LOCAL_TAX_DOC;

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ INSERT.
  PROCEDURE INSERT_LOCAL_TAX_DOC
            ( P_LOCAL_TAX_ID         OUT HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_LOCAL_TAX_NO         OUT HRW_LOCAL_TAX_DOC.LOCAL_TAX_NO%TYPE
            , P_CORP_ID              IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_SOB_ID               IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID               IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_LOCAL_TAX_TYPE       IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_TYPE%TYPE
            , P_STD_YYYYMM           IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM           IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE          IN HRW_LOCAL_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PRE_LOCAL_TAX_NO     IN HRW_LOCAL_TAX_DOC.PRE_LOCAL_TAX_NO%TYPE
            , P_PAY_SUPPLY_DATE      IN HRW_LOCAL_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER          IN HRW_LOCAL_TAX_DOC.TAX_OFFICER%TYPE
            , P_A01_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A01_PERSON_CNT%TYPE
            , P_A01_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A01_STD_TAX_AMT%TYPE
            , P_A01_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A01_LOCAL_TAX_AMT%TYPE
            , P_A02_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A02_PERSON_CNT%TYPE
            , P_A02_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A02_STD_TAX_AMT%TYPE
            , P_A02_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A02_LOCAL_TAX_AMT%TYPE
            , P_A03_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A03_PERSON_CNT%TYPE
            , P_A03_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A03_STD_TAX_AMT%TYPE
            , P_A03_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A03_LOCAL_TAX_AMT%TYPE
            , P_A04_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A04_PERSON_CNT%TYPE
            , P_A04_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A04_STD_TAX_AMT%TYPE
            , P_A04_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A04_LOCAL_TAX_AMT%TYPE
            , P_A05_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A05_PERSON_CNT%TYPE
            , P_A05_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A05_STD_TAX_AMT%TYPE
            , P_A05_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A05_LOCAL_TAX_AMT%TYPE
            , P_A06_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A06_PERSON_CNT%TYPE
            , P_A06_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A06_STD_TAX_AMT%TYPE
            , P_A06_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A06_LOCAL_TAX_AMT%TYPE
            , P_A07_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A07_PERSON_CNT%TYPE
            , P_A07_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A07_STD_TAX_AMT%TYPE
            , P_A07_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A07_LOCAL_TAX_AMT%TYPE
            , P_A08_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A08_PERSON_CNT%TYPE
            , P_A08_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A08_STD_TAX_AMT%TYPE
            , P_A08_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A08_LOCAL_TAX_AMT%TYPE
            , P_A09_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A09_PERSON_CNT%TYPE
            , P_A09_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A09_STD_TAX_AMT%TYPE
            , P_A09_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A09_LOCAL_TAX_AMT%TYPE
            , P_A10_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A10_PERSON_CNT%TYPE
            , P_A10_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A10_STD_TAX_AMT%TYPE
            , P_A10_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A10_LOCAL_TAX_AMT%TYPE
            , P_A90_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A90_PERSON_CNT%TYPE
            , P_A90_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A90_STD_TAX_AMT%TYPE
            , P_A90_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A90_LOCAL_TAX_AMT%TYPE
            , P_TOTAL_ADJUST_TAX_AMT IN HRW_LOCAL_TAX_DOC.TOTAL_ADJUST_TAX_AMT%TYPE
            , P_PAY_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.PAY_LOCAL_TAX_AMT%TYPE
            , P_K10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K10_TAX_AMT%TYPE
            , P_K20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K20_TAX_AMT%TYPE
            , P_K30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K30_TAX_AMT%TYPE
            , P_K40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K40_TAX_AMT%TYPE
            , P_R10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R10_TAX_AMT%TYPE
            , P_R20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R20_TAX_AMT%TYPE
            , P_R30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R30_TAX_AMT%TYPE
            , P_R40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R40_TAX_AMT%TYPE
            , P_USER_ID              IN HRW_LOCAL_TAX_DOC.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SUBMIT_YEAR   VARCHAR2(4);
    V_SEQ           NUMBER;
  BEGIN
    --¹®¼­¹øÈ£ »ý¼º.
    V_SUBMIT_YEAR := TO_CHAR(P_SUBMIT_DATE, 'YYYY');
    BEGIN
      SELECT NVL(MAX(SUBSTR(TD.LOCAL_TAX_NO, 6, 4)), 0) + 1 AS NEXT_SEQ
        INTO V_SEQ
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE TD.CORP_ID            = P_CORP_ID
        AND TD.SOB_ID             = P_SOB_ID
        AND TD.ORG_ID             = P_ORG_ID
        AND TO_CHAR(TD.SUBMIT_DATE, 'YYYY') = V_SUBMIT_YEAR
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SEQ := 1;
    END;
    P_LOCAL_TAX_NO := V_SUBMIT_YEAR || '-' || LPAD(V_SEQ, 4, '0');

    SELECT HRW_LOCAL_TAX_DOC_S1.NEXTVAL
      INTO P_LOCAL_TAX_ID
      FROM DUAL;

    INSERT INTO HRW_LOCAL_TAX_DOC
    ( LOCAL_TAX_ID
    , LOCAL_TAX_NO 
    , CORP_ID 
    , SOB_ID 
    , ORG_ID 
    , LOCAL_TAX_TYPE 
    , STD_YYYYMM 
    , PAY_YYYYMM 
    , SUBMIT_DATE 
    , PRE_LOCAL_TAX_NO 
    , PAY_SUPPLY_DATE 
    , TAX_OFFICER 
    , A01_PERSON_CNT 
    , A01_STD_TAX_AMT 
    , A01_LOCAL_TAX_AMT 
    , A02_PERSON_CNT 
    , A02_STD_TAX_AMT 
    , A02_LOCAL_TAX_AMT 
    , A03_PERSON_CNT 
    , A03_STD_TAX_AMT 
    , A03_LOCAL_TAX_AMT 
    , A04_PERSON_CNT 
    , A04_STD_TAX_AMT 
    , A04_LOCAL_TAX_AMT 
    , A05_PERSON_CNT 
    , A05_STD_TAX_AMT 
    , A05_LOCAL_TAX_AMT 
    , A06_PERSON_CNT 
    , A06_STD_TAX_AMT 
    , A06_LOCAL_TAX_AMT 
    , A07_PERSON_CNT 
    , A07_STD_TAX_AMT 
    , A07_LOCAL_TAX_AMT 
    , A08_PERSON_CNT 
    , A08_STD_TAX_AMT 
    , A08_LOCAL_TAX_AMT 
    , A09_PERSON_CNT 
    , A09_STD_TAX_AMT 
    , A09_LOCAL_TAX_AMT 
    , A10_PERSON_CNT 
    , A10_STD_TAX_AMT 
    , A10_LOCAL_TAX_AMT 
    , A90_PERSON_CNT 
    , A90_STD_TAX_AMT 
    , A90_LOCAL_TAX_AMT 
    , TOTAL_ADJUST_TAX_AMT 
    , PAY_LOCAL_TAX_AMT 
    , K10_TAX_AMT 
    , K20_TAX_AMT 
    , K30_TAX_AMT 
    , K40_TAX_AMT 
    , R10_TAX_AMT 
    , R20_TAX_AMT 
    , R30_TAX_AMT 
    , R40_TAX_AMT 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_LOCAL_TAX_ID
    , P_LOCAL_TAX_NO
    , P_CORP_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_LOCAL_TAX_TYPE
    , P_STD_YYYYMM
    , P_PAY_YYYYMM
    , P_SUBMIT_DATE
    , P_PRE_LOCAL_TAX_NO
    , P_PAY_SUPPLY_DATE
    , P_TAX_OFFICER
    , NVL(P_A01_PERSON_CNT, 0)
    , NVL(P_A01_STD_TAX_AMT, 0)
    , NVL(P_A01_LOCAL_TAX_AMT, 0)
    , NVL(P_A02_PERSON_CNT, 0)
    , NVL(P_A02_STD_TAX_AMT, 0)
    , NVL(P_A02_LOCAL_TAX_AMT, 0)
    , NVL(P_A03_PERSON_CNT, 0)
    , NVL(P_A03_STD_TAX_AMT, 0)
    , NVL(P_A03_LOCAL_TAX_AMT, 0)
    , NVL(P_A04_PERSON_CNT, 0)
    , NVL(P_A04_STD_TAX_AMT, 0)
    , NVL(P_A04_LOCAL_TAX_AMT, 0)
    , NVL(P_A05_PERSON_CNT, 0)
    , NVL(P_A05_STD_TAX_AMT, 0)
    , NVL(P_A05_LOCAL_TAX_AMT, 0)
    , NVL(P_A06_PERSON_CNT, 0)
    , NVL(P_A06_STD_TAX_AMT, 0)
    , NVL(P_A06_LOCAL_TAX_AMT, 0)
    , NVL(P_A07_PERSON_CNT, 0)
    , NVL(P_A07_STD_TAX_AMT, 0)
    , NVL(P_A07_LOCAL_TAX_AMT, 0)
    , NVL(P_A08_PERSON_CNT, 0)
    , NVL(P_A08_STD_TAX_AMT, 0)
    , NVL(P_A08_LOCAL_TAX_AMT, 0)
    , NVL(P_A09_PERSON_CNT, 0)
    , NVL(P_A09_STD_TAX_AMT, 0)
    , NVL(P_A09_LOCAL_TAX_AMT, 0)
    , NVL(P_A10_PERSON_CNT, 0)
    , NVL(P_A10_STD_TAX_AMT, 0)
    , NVL(P_A10_LOCAL_TAX_AMT, 0)
    , NVL(P_A90_PERSON_CNT, 0)
    , NVL(P_A90_STD_TAX_AMT, 0)
    , NVL(P_A90_LOCAL_TAX_AMT, 0)
    , NVL(P_TOTAL_ADJUST_TAX_AMT, 0)
    , NVL(P_PAY_LOCAL_TAX_AMT, 0)
    , NVL(P_K10_TAX_AMT, 0)
    , NVL(P_K20_TAX_AMT, 0)
    , NVL(P_K30_TAX_AMT, 0)
    , NVL(P_K40_TAX_AMT, 0)
    , NVL(P_R10_TAX_AMT, 0)
    , NVL(P_R20_TAX_AMT, 0)
    , NVL(P_R30_TAX_AMT, 0)
    , NVL(P_R40_TAX_AMT, 0)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_LOCAL_TAX_DOC;

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ UPDATE.
  PROCEDURE UPDATE_LOCAL_TAX_DOC
            ( W_LOCAL_TAX_ID         IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID               IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID               IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_LOCAL_TAX_TYPE       IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_TYPE%TYPE
            , P_STD_YYYYMM           IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM           IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE          IN HRW_LOCAL_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PRE_LOCAL_TAX_NO     IN HRW_LOCAL_TAX_DOC.PRE_LOCAL_TAX_NO%TYPE
            , P_PAY_SUPPLY_DATE      IN HRW_LOCAL_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER          IN HRW_LOCAL_TAX_DOC.TAX_OFFICER%TYPE
            , P_A01_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A01_PERSON_CNT%TYPE
            , P_A01_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A01_STD_TAX_AMT%TYPE
            , P_A01_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A01_LOCAL_TAX_AMT%TYPE
            , P_A02_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A02_PERSON_CNT%TYPE
            , P_A02_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A02_STD_TAX_AMT%TYPE
            , P_A02_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A02_LOCAL_TAX_AMT%TYPE
            , P_A03_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A03_PERSON_CNT%TYPE
            , P_A03_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A03_STD_TAX_AMT%TYPE
            , P_A03_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A03_LOCAL_TAX_AMT%TYPE
            , P_A04_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A04_PERSON_CNT%TYPE
            , P_A04_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A04_STD_TAX_AMT%TYPE
            , P_A04_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A04_LOCAL_TAX_AMT%TYPE
            , P_A05_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A05_PERSON_CNT%TYPE
            , P_A05_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A05_STD_TAX_AMT%TYPE
            , P_A05_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A05_LOCAL_TAX_AMT%TYPE
            , P_A06_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A06_PERSON_CNT%TYPE
            , P_A06_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A06_STD_TAX_AMT%TYPE
            , P_A06_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A06_LOCAL_TAX_AMT%TYPE
            , P_A07_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A07_PERSON_CNT%TYPE
            , P_A07_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A07_STD_TAX_AMT%TYPE
            , P_A07_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A07_LOCAL_TAX_AMT%TYPE
            , P_A08_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A08_PERSON_CNT%TYPE
            , P_A08_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A08_STD_TAX_AMT%TYPE
            , P_A08_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A08_LOCAL_TAX_AMT%TYPE
            , P_A09_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A09_PERSON_CNT%TYPE
            , P_A09_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A09_STD_TAX_AMT%TYPE
            , P_A09_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A09_LOCAL_TAX_AMT%TYPE
            , P_A10_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A10_PERSON_CNT%TYPE
            , P_A10_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A10_STD_TAX_AMT%TYPE
            , P_A10_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A10_LOCAL_TAX_AMT%TYPE
            , P_A90_PERSON_CNT       IN HRW_LOCAL_TAX_DOC.A90_PERSON_CNT%TYPE
            , P_A90_STD_TAX_AMT      IN HRW_LOCAL_TAX_DOC.A90_STD_TAX_AMT%TYPE
            , P_A90_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.A90_LOCAL_TAX_AMT%TYPE
            , P_TOTAL_ADJUST_TAX_AMT IN HRW_LOCAL_TAX_DOC.TOTAL_ADJUST_TAX_AMT%TYPE
            , P_PAY_LOCAL_TAX_AMT    IN HRW_LOCAL_TAX_DOC.PAY_LOCAL_TAX_AMT%TYPE
            , P_K10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K10_TAX_AMT%TYPE
            , P_K20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K20_TAX_AMT%TYPE
            , P_K30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K30_TAX_AMT%TYPE
            , P_K40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.K40_TAX_AMT%TYPE
            , P_R10_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R10_TAX_AMT%TYPE
            , P_R20_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R20_TAX_AMT%TYPE
            , P_R30_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R30_TAX_AMT%TYPE
            , P_R40_TAX_AMT          IN HRW_LOCAL_TAX_DOC.R40_TAX_AMT%TYPE
            , P_USER_ID              IN HRW_LOCAL_TAX_DOC.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    -- ¸¶°¨ ¿©ºÎ Ã¼Å©.
    IF HRW_LOCAL_TAX_SET_G.CLOSED_LOCAL_TAX_YN(W_LOCAL_TAX_ID) = 'Y' THEN
      -- ÀÌ¹Ì ¸¶°¨Ã³¸®µÊ.
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
      RETURN;
    END IF;

    UPDATE HRW_LOCAL_TAX_DOC
      SET LOCAL_TAX_TYPE       = P_LOCAL_TAX_TYPE
        , STD_YYYYMM           = P_STD_YYYYMM
        , PAY_YYYYMM           = P_PAY_YYYYMM
        , SUBMIT_DATE          = P_SUBMIT_DATE
        , PRE_LOCAL_TAX_NO     = P_PRE_LOCAL_TAX_NO
        , PAY_SUPPLY_DATE      = P_PAY_SUPPLY_DATE
        , TAX_OFFICER          = P_TAX_OFFICER
        , A01_PERSON_CNT       = P_A01_PERSON_CNT
        , A01_STD_TAX_AMT      = P_A01_STD_TAX_AMT
        , A01_LOCAL_TAX_AMT    = P_A01_LOCAL_TAX_AMT
        , A02_PERSON_CNT       = P_A02_PERSON_CNT
        , A02_STD_TAX_AMT      = P_A02_STD_TAX_AMT
        , A02_LOCAL_TAX_AMT    = P_A02_LOCAL_TAX_AMT
        , A03_PERSON_CNT       = P_A03_PERSON_CNT
        , A03_STD_TAX_AMT      = P_A03_STD_TAX_AMT
        , A03_LOCAL_TAX_AMT    = P_A03_LOCAL_TAX_AMT
        , A04_PERSON_CNT       = P_A04_PERSON_CNT
        , A04_STD_TAX_AMT      = P_A04_STD_TAX_AMT
        , A04_LOCAL_TAX_AMT    = P_A04_LOCAL_TAX_AMT
        , A05_PERSON_CNT       = P_A05_PERSON_CNT
        , A05_STD_TAX_AMT      = P_A05_STD_TAX_AMT
        , A05_LOCAL_TAX_AMT    = P_A05_LOCAL_TAX_AMT
        , A06_PERSON_CNT       = P_A06_PERSON_CNT
        , A06_STD_TAX_AMT      = P_A06_STD_TAX_AMT
        , A06_LOCAL_TAX_AMT    = P_A06_LOCAL_TAX_AMT
        , A07_PERSON_CNT       = P_A07_PERSON_CNT
        , A07_STD_TAX_AMT      = P_A07_STD_TAX_AMT
        , A07_LOCAL_TAX_AMT    = P_A07_LOCAL_TAX_AMT
        , A08_PERSON_CNT       = P_A08_PERSON_CNT
        , A08_STD_TAX_AMT      = P_A08_STD_TAX_AMT
        , A08_LOCAL_TAX_AMT    = P_A08_LOCAL_TAX_AMT
        , A09_PERSON_CNT       = P_A09_PERSON_CNT
        , A09_STD_TAX_AMT      = P_A09_STD_TAX_AMT
        , A09_LOCAL_TAX_AMT    = P_A09_LOCAL_TAX_AMT
        , A10_PERSON_CNT       = P_A10_PERSON_CNT
        , A10_STD_TAX_AMT      = P_A10_STD_TAX_AMT
        , A10_LOCAL_TAX_AMT    = P_A10_LOCAL_TAX_AMT
        , A90_PERSON_CNT       = P_A90_PERSON_CNT
        , A90_STD_TAX_AMT      = P_A90_STD_TAX_AMT
        , A90_LOCAL_TAX_AMT    = P_A90_LOCAL_TAX_AMT
        , TOTAL_ADJUST_TAX_AMT = P_TOTAL_ADJUST_TAX_AMT
        , PAY_LOCAL_TAX_AMT    = P_PAY_LOCAL_TAX_AMT
        , K10_TAX_AMT          = P_K10_TAX_AMT
        , K20_TAX_AMT          = P_K20_TAX_AMT
        , K30_TAX_AMT          = P_K30_TAX_AMT
        , K40_TAX_AMT          = P_K40_TAX_AMT
        , R10_TAX_AMT          = P_R10_TAX_AMT
        , R20_TAX_AMT          = P_R20_TAX_AMT
        , R30_TAX_AMT          = P_R30_TAX_AMT
        , R40_TAX_AMT          = P_R40_TAX_AMT
        , LAST_UPDATE_DATE     = V_SYSDATE
        , LAST_UPDATED_BY      = P_USER_ID
    WHERE LOCAL_TAX_ID         = W_LOCAL_TAX_ID;
  END UPDATE_LOCAL_TAX_DOC;

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ »èÁ¦.
  PROCEDURE DELETE_LOCAL_TAX_DOC
            ( W_LOCAL_TAX_ID               IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID                     IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                     IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    -- ¸¶°¨ ¿©ºÎ Ã¼Å©.
    IF HRW_LOCAL_TAX_SET_G.CLOSED_LOCAL_TAX_YN(W_LOCAL_TAX_ID) = 'Y' THEN
      -- ÀÌ¹Ì ¸¶°¨Ã³¸®µÊ.
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
      RETURN;
    END IF;

    DELETE FROM HRW_LOCAL_TAX_DOC
    WHERE LOCAL_TAX_ID            = W_LOCAL_TAX_ID;
  END DELETE_LOCAL_TAX_DOC;

---------------------------------------------------------------------------------------------------
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼¼­ ÀÎ¼â.
  PROCEDURE PRINT_LOCAL_TAX_DOC
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT SUBSTR(TD.STD_YYYYMM, 6, 2) || '¿ù' AS STD_MM
          , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TD.PAY_SUPPLY_DATE) AS PAY_SUPPLY_DATE
          , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TD.SUBMIT_DATE) AS SUBMIT_DATE
          , HCM.ADDRESS
          , HCM.CORP_NAME
          , HCM.VAT_NUMBER
          , HCM.PRESIDENT_NAME
          , HCM.TEL_NUMBER
          , TD.TAX_OFFICER
          , TD.A01_PERSON_CNT
          , TD.A01_STD_TAX_AMT
          , TD.A01_LOCAL_TAX_AMT
          , TD.A02_PERSON_CNT
          , TD.A02_STD_TAX_AMT
          , TD.A02_LOCAL_TAX_AMT
          , TD.A03_PERSON_CNT
          , TD.A03_STD_TAX_AMT
          , TD.A03_LOCAL_TAX_AMT
          , TD.A04_PERSON_CNT
          , TD.A04_STD_TAX_AMT
          , TD.A04_LOCAL_TAX_AMT
          , TD.A05_PERSON_CNT
          , TD.A05_STD_TAX_AMT
          , TD.A05_LOCAL_TAX_AMT
          , TD.A06_PERSON_CNT
          , TD.A06_STD_TAX_AMT
          , TD.A06_LOCAL_TAX_AMT
          , TD.A07_PERSON_CNT
          , TD.A07_STD_TAX_AMT
          , TD.A07_LOCAL_TAX_AMT
          , TD.A08_PERSON_CNT
          , TD.A08_STD_TAX_AMT
          , TD.A08_LOCAL_TAX_AMT
          , TD.A09_PERSON_CNT
          , TD.A09_STD_TAX_AMT
          , TD.A09_LOCAL_TAX_AMT
          , TD.A10_PERSON_CNT
          , TD.A10_STD_TAX_AMT
          , TD.A10_LOCAL_TAX_AMT
          , TD.TOTAL_ADJUST_TAX_AMT
          , TD.A90_PERSON_CNT
          , TD.A90_STD_TAX_AMT
          , TD.PAY_LOCAL_TAX_AMT
        FROM HRW_LOCAL_TAX_DOC TD
          , ( SELECT CM.CORP_ID
                  , CM.SOB_ID
                  , CM.ORG_ID
                  , CM.CORP_NAME
                  , CM.PRESIDENT_NAME
                  , CM.LEGAL_NUMBER
                  , CM.TEL_NUMBER
                  , CM.EMAIL
                  , HOU.VAT_NUMBER
                  , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
                  , CM.CORP_NAME AS WITHHOLDING_AGENT
                FROM HRM_CORP_MASTER CM
                  , ( SELECT OU.CORP_ID
                           , OU.SOB_ID
                           , OU.ORG_ID
                           , OU.OPERATING_UNIT_NAME
                           , OU.VAT_NUMBER
                        FROM HRM_OPERATING_UNIT OU
                      WHERE OU.SOB_ID            = P_SOB_ID
                        AND OU.ORG_ID            = P_ORG_ID
                        AND (OU.DEFAULT_FLAG     = 'Y'
                        OR  (OU.DEFAULT_FLAG     = 'N'
                        AND ROWNUM               <= 1))
                     ) HOU
              WHERE CM.CORP_ID                  = HOU.CORP_ID
                AND CM.SOB_ID                   = HOU.SOB_ID
                AND CM.ORG_ID                   = HOU.ORG_ID
            ) HCM
      WHERE TD.CORP_ID                  = HCM.CORP_ID
        AND TD.LOCAL_TAX_ID             = P_LOCAL_TAX_ID
        AND TD.SOB_ID                   = P_SOB_ID
        AND TD.ORG_ID                   = P_ORG_ID
      ;
  END PRINT_LOCAL_TAX_DOC;

-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö³³ºÎ¼­ ÀÎ¼â.
  PROCEDURE PRINT_LOCAL_TAX_DOC_2
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      --±Ù·Î¼Òµæ.
      SELECT NULL AS TAX_OFFICE_CODE
          , NULL AS TAX_ACCOUNT_CODE
          , NULL AS TAX_YYYYMM
          , NULL AS DUE_DATE
          , HCM.CORP_NAME
          , HCM.LEGAL_NUMBER
          , HCM.PRESIDENT_NAME
          , HCM.VAT_NUMBER
          , HCM.ADDRESS
          , HCM.TEL_NUMBER
          , SUBSTR(TD.STD_YYYYMM, 1, 4) || '³â ' || SUBSTR(TD.STD_YYYYMM, 6, 2) || '¿ùºÐ' || 
            '(Áö±Þ ' || HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TD.PAY_SUPPLY_DATE) || ')' AS STD_YYYYMM
          , TD.TAX_OFFICER
          , CONVERT_NUM_TO_KOR(TD.PAY_LOCAL_TAX_AMT) AS PAY_LOCAL_TAX_KOR
          , TD.A01_PERSON_CNT
          , TD.A01_STD_TAX_AMT
          , TD.A01_LOCAL_TAX_AMT
          , TD.A02_PERSON_CNT
          , TD.A02_STD_TAX_AMT
          , TD.A02_LOCAL_TAX_AMT
          , TD.A03_PERSON_CNT
          , TD.A03_STD_TAX_AMT
          , TD.A03_LOCAL_TAX_AMT
          , TD.A04_PERSON_CNT
          , TD.A04_STD_TAX_AMT
          , TD.A04_LOCAL_TAX_AMT
          , TD.A05_PERSON_CNT
          , TD.A05_STD_TAX_AMT
          , TD.A05_LOCAL_TAX_AMT
          , TD.A06_PERSON_CNT
          , TD.A06_STD_TAX_AMT
          , TD.A06_LOCAL_TAX_AMT
          , TD.A07_PERSON_CNT
          , TD.A07_STD_TAX_AMT
          , TD.A07_LOCAL_TAX_AMT
          , TD.A08_PERSON_CNT
          , TD.A08_STD_TAX_AMT
          , TD.A08_LOCAL_TAX_AMT
          , TD.A09_PERSON_CNT
          , TD.A09_STD_TAX_AMT
          , TD.A09_LOCAL_TAX_AMT
          , TD.A10_PERSON_CNT
          , TD.A10_STD_TAX_AMT
          , TD.A10_LOCAL_TAX_AMT
          , TD.TOTAL_ADJUST_TAX_AMT
          , TD.A90_PERSON_CNT
          , TD.A90_STD_TAX_AMT
          , TD.PAY_LOCAL_TAX_AMT
          , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TD.SUBMIT_DATE) AS SUBMIT_DATE
          , HCM.CORP_NAME AS REPORT_CORP_NAME          
          , TD.TAX_OFFICER || 'Àå' AS TAX_OFFIECER_NAME
        FROM HRW_LOCAL_TAX_DOC TD
          , ( SELECT CM.CORP_NAME       -- ¹ýÀÎ.
                  , CM.PRESIDENT_NAME   -- ´ëÇ¥ÀÚ.
                  , CM.LEGAL_NUMBER
                  , ( SELECT OU.VAT_NUMBER
                        FROM HRM_OPERATING_UNIT OU
                      WHERE OU.CORP_ID        = CM.CORP_ID
                        AND (OU.DEFAULT_FLAG  = 'Y'
                        OR ROWNUM             <= 1)) AS VAT_NUMBER       -- »ç¾÷ÀÚ¹øÈ£.
                  , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
                  , ( SELECT OU.TAX_OFFICE_NAME
                        FROM HRM_OPERATING_UNIT OU
                      WHERE OU.CORP_ID        = CM.CORP_ID
                        AND (OU.DEFAULT_FLAG  = 'Y'
                        OR ROWNUM             <= 1)) AS TAX_OFFICE_NAME  -- °üÇÒ¼¼¹«¼­¸í.
                  , CM.TEL_NUMBER       -- ÀüÈ­¹øÈ£.
                  , CM.FAX_NUMBER
                  , CM.EMAIL
                  , CM.CORP_ID
              FROM HRM_CORP_MASTER CM
              WHERE CM.SOB_ID             = P_SOB_ID
                AND CM.ORG_ID             = P_ORG_ID
            ) HCM
      WHERE TD.CORP_ID                  = HCM.CORP_ID
        AND TD.LOCAL_TAX_ID             = P_LOCAL_TAX_ID
      ;
  END PRINT_LOCAL_TAX_DOC_2;

---------------------------------------------------------------------------------------------------
-- ÁÖ¹Î¼¼Æ¯º°Â¡¼ö¸í¼¼/³³ÀÔ¼­ ¸®½ºÆ® ·è¾÷.
  PROCEDURE LU_LOCAL_TAX_LIST
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT TD.LOCAL_TAX_NO
          , HRM_COMMON_G.CODE_NAME_F('OFFICE_TAX_TYPE', TD.LOCAL_TAX_TYPE, TD.SOB_ID, TD.ORG_ID) AS LOCAL_TAX_TYPE_DESC
          , TO_CHAR(TD.SUBMIT_DATE, 'YYYY-MM-DD') AS SUBMIT_DATE
          , TD.STD_YYYYMM
          , TD.PAY_YYYYMM
          , TD.PAY_LOCAL_TAX_AMT
          , NVL(TD.K40_TAX_AMT, 0) + NVL(TD.R40_TAX_AMT, 0) AS NEXT_TAX_AMT
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE TD.CORP_ID                  = P_CORP_ID
        AND TD.SOB_ID                   = P_SOB_ID
        AND TD.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(TD.SUBMIT_DATE, 'YYYY') = P_SUBMIT_YEAR
      ORDER BY TD.LOCAL_TAX_NO
      ;
  END LU_LOCAL_TAX_LIST;

END HRW_LOCAL_TAX_G;
/
