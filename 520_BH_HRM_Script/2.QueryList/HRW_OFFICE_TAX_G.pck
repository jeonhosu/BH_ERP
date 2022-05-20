CREATE OR REPLACE PACKAGE HRW_OFFICE_TAX_G
AS

-- 지방소득세(종업원할 사업소세)신고서 리스트.
  PROCEDURE SELECT_OFFICE_TAX_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

---------------------------------------------------------------------------------------------------
-- 지방소득세(종업원할 사업소세)신고서 조회.
  PROCEDURE SELECT_OFFICE_TAX_DOC
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_OFFICE_TAX_ID         IN NUMBER
            , P_CORP_ID               IN NUMBER
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            );

-- 지방소득세(종업원할 사업소세)신고서 INSERT.
  PROCEDURE INSERT_OFFICE_TAX_DOC
            ( P_OFFICE_TAX_ID           OUT HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_OFFICE_TAX_NO           OUT HRW_OFFICE_TAX_DOC.OFFICE_TAX_NO%TYPE
            , P_CORP_ID                 IN HRW_OFFICE_TAX_DOC.CORP_ID%TYPE
            , P_SOB_ID                  IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                  IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , P_OFFICE_TAX_TYPE         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_TYPE%TYPE
            , P_STD_YYYYMM              IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM              IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE             IN HRW_OFFICE_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PAY_SUPPLY_DATE         IN HRW_OFFICE_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER             IN HRW_OFFICE_TAX_DOC.TAX_OFFICER%TYPE
            , P_OWNER_TAX_FREE_YN       IN HRW_OFFICE_TAX_DOC.OWNER_TAX_FREE_YN%TYPE
            , P_NON_PAY_PERSON_YN       IN HRW_OFFICE_TAX_DOC.NON_PAY_PERSON_YN%TYPE
            , P_REGULAR_WORKER_COUNT    IN HRW_OFFICE_TAX_DOC.REGULAR_WORKER_COUNT%TYPE
            , P_DAY_WORKER_COUNT        IN HRW_OFFICE_TAX_DOC.DAY_WORKER_COUNT%TYPE
            , P_TOTAL_PAYMENT_AMT       IN HRW_OFFICE_TAX_DOC.TOTAL_PAYMENT_AMT%TYPE
            , P_TAX_FREE_AMT            IN HRW_OFFICE_TAX_DOC.TAX_FREE_AMT%TYPE
            , P_PAYMENT_TAX_AMT         IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_COMP_TAX_AMT            IN HRW_OFFICE_TAX_DOC.COMP_TAX_AMT%TYPE
            , P_DUE_DATE                IN HRW_OFFICE_TAX_DOC.DUE_DATE%TYPE
            , P_TAX_ADDITION_AMT        IN HRW_OFFICE_TAX_DOC.TAX_ADDITION_AMT%TYPE
            , P_TOTAL_TAX_AMT           IN HRW_OFFICE_TAX_DOC.TOTAL_TAX_AMT%TYPE
            , P_ORIGINAL_DUE_DATE       IN HRW_OFFICE_TAX_DOC.ORIGINAL_DUE_DATE%TYPE
            , P_DELAY_DAY_COUNT         IN HRW_OFFICE_TAX_DOC.DELAY_DAY_COUNT%TYPE
            , P_BAD_PAY_ADDITION_AMT    IN HRW_OFFICE_TAX_DOC.BAD_PAY_ADDITION_AMT%TYPE
            , P_BAD_REPORT_ADDITION_AMT IN HRW_OFFICE_TAX_DOC.BAD_REPORT_ADDITION_AMT%TYPE
            , P_OWN_TYPE                IN HRW_OFFICE_TAX_DOC.OWN_TYPE%TYPE
            , P_USER_ID                 IN HRW_OFFICE_TAX_DOC.CREATED_BY%TYPE 
            );

-- 지방소득세(종업원할 사업소세)신고서 UPDATE.
  PROCEDURE UPDATE_OFFICE_TAX_DOC
            ( W_OFFICE_TAX_ID           IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_SOB_ID                  IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                  IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , P_OFFICE_TAX_TYPE         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_TYPE%TYPE
            , P_STD_YYYYMM              IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM              IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE             IN HRW_OFFICE_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PAY_SUPPLY_DATE         IN HRW_OFFICE_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER             IN HRW_OFFICE_TAX_DOC.TAX_OFFICER%TYPE
            , P_OWNER_TAX_FREE_YN       IN HRW_OFFICE_TAX_DOC.OWNER_TAX_FREE_YN%TYPE
            , P_NON_PAY_PERSON_YN       IN HRW_OFFICE_TAX_DOC.NON_PAY_PERSON_YN%TYPE
            , P_REGULAR_WORKER_COUNT    IN HRW_OFFICE_TAX_DOC.REGULAR_WORKER_COUNT%TYPE
            , P_DAY_WORKER_COUNT        IN HRW_OFFICE_TAX_DOC.DAY_WORKER_COUNT%TYPE
            , P_TOTAL_PAYMENT_AMT       IN HRW_OFFICE_TAX_DOC.TOTAL_PAYMENT_AMT%TYPE
            , P_TAX_FREE_AMT            IN HRW_OFFICE_TAX_DOC.TAX_FREE_AMT%TYPE
            , P_PAYMENT_TAX_AMT         IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_COMP_TAX_AMT            IN HRW_OFFICE_TAX_DOC.COMP_TAX_AMT%TYPE
            , P_DUE_DATE                IN HRW_OFFICE_TAX_DOC.DUE_DATE%TYPE
            , P_TAX_ADDITION_AMT        IN HRW_OFFICE_TAX_DOC.TAX_ADDITION_AMT%TYPE
            , P_TOTAL_TAX_AMT           IN HRW_OFFICE_TAX_DOC.TOTAL_TAX_AMT%TYPE
            , P_ORIGINAL_DUE_DATE       IN HRW_OFFICE_TAX_DOC.ORIGINAL_DUE_DATE%TYPE
            , P_DELAY_DAY_COUNT         IN HRW_OFFICE_TAX_DOC.DELAY_DAY_COUNT%TYPE
            , P_BAD_PAY_ADDITION_AMT    IN HRW_OFFICE_TAX_DOC.BAD_PAY_ADDITION_AMT%TYPE
            , P_BAD_REPORT_ADDITION_AMT IN HRW_OFFICE_TAX_DOC.BAD_REPORT_ADDITION_AMT%TYPE
            , P_OWN_TYPE                IN HRW_OFFICE_TAX_DOC.OWN_TYPE%TYPE
            , P_USER_ID                 IN HRW_OFFICE_TAX_DOC.CREATED_BY%TYPE 
            );

-- 지방소득세(종업원할 사업소세)신고서 삭제.
  PROCEDURE DELETE_OFFICE_TAX_DOC
            ( W_OFFICE_TAX_ID              IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_SOB_ID                     IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                     IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 지방소득세(종업원할 사업소세)신고서 인쇄.
  PROCEDURE PRINT_OFFICE_TAX_DOC
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_OFFICE_TAX_ID         IN NUMBER
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            );

-- 지방소득세(종업원할 사업소세)납부서.
  PROCEDURE PRINT_OFFICE_TAX_DOC_2
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_OFFICE_TAX_ID         IN NUMBER
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 원천징수이행상황신고서 리스트 룩업.
  PROCEDURE LU_WITHHOLDING_LIST
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

END HRW_OFFICE_TAX_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_OFFICE_TAX_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_OFFICE_TAX_DOC_G
/* DESCRIPTION  : 지방소득세(종업원할 사업소세) 관리
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 지방소득세(종업원할 사업소세)신고서 리스트.
  PROCEDURE SELECT_OFFICE_TAX_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT OD.OFFICE_TAX_NO
          , OD.OFFICE_TAX_TYPE
          , HRM_COMMON_G.CODE_NAME_F('OFFICE_TAX_TYPE', OD.OFFICE_TAX_TYPE, OD.SOB_ID, OD.ORG_ID) AS OFFICE_TAX_DESC
          , OD.SUBMIT_DATE
          , OD.STD_YYYYMM
          , OD.PAY_YYYYMM
          , OD.TOTAL_TAX_AMT
          , OD.TAX_OFFICER
          , OD.CLOSED_YN
          , OD.OFFICE_TAX_ID
        FROM HRW_OFFICE_TAX_DOC OD
      WHERE OD.CORP_ID                  = P_CORP_ID
        AND OD.SOB_ID                   = P_SOB_ID
        AND OD.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(OD.SUBMIT_DATE, 'YYYY') = P_SUBMIT_YEAR
      ORDER BY OD.OFFICE_TAX_NO DESC
      ;
  END SELECT_OFFICE_TAX_LIST;

---------------------------------------------------------------------------------------------------
-- 지방소득세(종업원할 사업소세)신고서 조회.
  PROCEDURE SELECT_OFFICE_TAX_DOC
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , P_OFFICE_TAX_ID         IN NUMBER
            , P_CORP_ID               IN NUMBER
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT TD.OFFICE_TAX_NO
          , TD.OFFICE_TAX_TYPE
          , HRM_COMMON_G.CODE_NAME_F('OFFICE_TAX_TYPE', TD.OFFICE_TAX_TYPE, TD.SOB_ID, TD.ORG_ID) AS OFFICE_TAX_TYPE_DESC
          , TD.STD_YYYYMM
          , TD.PAY_YYYYMM
          , TD.SUBMIT_DATE
          , TD.PAY_SUPPLY_DATE
          , TD.TAX_OFFICER
          , TD.OWNER_TAX_FREE_YN
          , TD.NON_PAY_PERSON_YN
          , HCM.CORP_NAME AS CORP_SITE_NAME
          , HCM.ADDRESS
          , HCM.VAT_NUMBER
          , HCM.CORP_NAME
          , HCM.LEGAL_NUMBER
          , HPM.NAME
          , HPM.REPRE_NUM
          , HCM.TEL_NUMBER 
          , HCM.FAX_NUMBER
          , TD.REGULAR_WORKER_COUNT
          , TD.DAY_WORKER_COUNT
          , TD.TOTAL_PAYMENT_AMT
          , TD.TAX_FREE_AMT
          , TD.PAYMENT_TAX_AMT
          , TD.COMP_TAX_AMT
          , TD.DUE_DATE
          , TD.TAX_ADDITION_AMT
          , TD.TOTAL_TAX_AMT
          , TD.ORIGINAL_DUE_DATE
          , TD.DELAY_DAY_COUNT
          , TD.BAD_PAY_ADDITION_AMT
          , TD.BAD_REPORT_ADDITION_AMT
          , TD.OWN_TYPE
          , TD.OFFICE_TAX_ID
        FROM HRW_OFFICE_TAX_DOC TD
          , ( SELECT CM.CORP_NAME       -- 법인.
                  , CM.PRESIDENT_NAME   -- 대표자.
                  , CM.LEGAL_NUMBER
                  , HOU.VAT_NUMBER       -- 사업자번호.
                  , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
                  , HOU.TAX_OFFICE_CODE  -- 관할세무서.
                  , HOU.TAX_OFFICE_NAME  -- 관할세무서명.
                  , CM.TEL_NUMBER       -- 전화번호.
                  , CM.FAX_NUMBER
                  , CM.EMAIL
                  , CM.CORP_ID
              FROM HRM_CORP_MASTER CM
                  , ( SELECT OU.CORP_ID
                           , OU.VAT_NUMBER        
                           , OU.TAX_OFFICE_CODE
                           , OU.TAX_OFFICE_NAME
                           , OU.TEL_NUMBER  
                        FROM HRM_OPERATING_UNIT OU
                      WHERE OU.CORP_ID        = P_CORP_ID
                        AND OU.SOB_ID         = P_SOB_ID
                        AND OU.ORG_ID         = P_ORG_ID
                        AND (OU.DEFAULT_FLAG  = 'Y'
                        OR ROWNUM             <= 1)
                     ) HOU
              WHERE CM.CORP_ID            = HOU.CORP_ID(+)
                AND CM.CORP_ID            = P_CORP_ID
                AND CM.SOB_ID             = P_SOB_ID
                AND CM.ORG_ID             = P_ORG_ID
             ) HCM
           , (SELECT PM.CORP_ID 
                  , PM.NAME
                  , PM.REPRE_NUM
                FROM HRM_PERSON_MASTER PM
                  , ( SELECT HC.COMMON_ID AS ABIL_ID
                          , HC.CODE AS ABIL_CODE
                          , HC.CODE_NAME AS ABIL_NAME
                        FROM HRM_COMMON HC
                      WHERE HC.GROUP_CODE     = 'ABIL'
                        AND HC.SOB_ID         = P_SOB_ID
                        AND HC.ORG_ID         = P_ORG_ID
                    ) AB
              WHERE PM.ABIL_ID                = AB.ABIL_ID
                AND AB.ABIL_CODE              = '120'  -- 대표이사.
                AND PM.SOB_ID                 = P_SOB_ID
                AND PM.ORG_ID                 = P_ORG_ID
                AND ROWNUM                    <= 1
              ) HPM
      WHERE TD.CORP_ID                  = HCM.CORP_ID
        AND TD.CORP_ID                  = HPM.CORP_ID(+)
        AND TD.OFFICE_TAX_ID            = P_OFFICE_TAX_ID
      ;
  END SELECT_OFFICE_TAX_DOC;

-- 지방소득세(종업원할 사업소세)신고서 INSERT.
  PROCEDURE INSERT_OFFICE_TAX_DOC
            ( P_OFFICE_TAX_ID           OUT HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_OFFICE_TAX_NO           OUT HRW_OFFICE_TAX_DOC.OFFICE_TAX_NO%TYPE
            , P_CORP_ID                 IN HRW_OFFICE_TAX_DOC.CORP_ID%TYPE
            , P_SOB_ID                  IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                  IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , P_OFFICE_TAX_TYPE         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_TYPE%TYPE
            , P_STD_YYYYMM              IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM              IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE             IN HRW_OFFICE_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PAY_SUPPLY_DATE         IN HRW_OFFICE_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER             IN HRW_OFFICE_TAX_DOC.TAX_OFFICER%TYPE
            , P_OWNER_TAX_FREE_YN       IN HRW_OFFICE_TAX_DOC.OWNER_TAX_FREE_YN%TYPE
            , P_NON_PAY_PERSON_YN       IN HRW_OFFICE_TAX_DOC.NON_PAY_PERSON_YN%TYPE
            , P_REGULAR_WORKER_COUNT    IN HRW_OFFICE_TAX_DOC.REGULAR_WORKER_COUNT%TYPE
            , P_DAY_WORKER_COUNT        IN HRW_OFFICE_TAX_DOC.DAY_WORKER_COUNT%TYPE
            , P_TOTAL_PAYMENT_AMT       IN HRW_OFFICE_TAX_DOC.TOTAL_PAYMENT_AMT%TYPE
            , P_TAX_FREE_AMT            IN HRW_OFFICE_TAX_DOC.TAX_FREE_AMT%TYPE
            , P_PAYMENT_TAX_AMT         IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_COMP_TAX_AMT            IN HRW_OFFICE_TAX_DOC.COMP_TAX_AMT%TYPE
            , P_DUE_DATE                IN HRW_OFFICE_TAX_DOC.DUE_DATE%TYPE
            , P_TAX_ADDITION_AMT        IN HRW_OFFICE_TAX_DOC.TAX_ADDITION_AMT%TYPE
            , P_TOTAL_TAX_AMT           IN HRW_OFFICE_TAX_DOC.TOTAL_TAX_AMT%TYPE
            , P_ORIGINAL_DUE_DATE       IN HRW_OFFICE_TAX_DOC.ORIGINAL_DUE_DATE%TYPE
            , P_DELAY_DAY_COUNT         IN HRW_OFFICE_TAX_DOC.DELAY_DAY_COUNT%TYPE
            , P_BAD_PAY_ADDITION_AMT    IN HRW_OFFICE_TAX_DOC.BAD_PAY_ADDITION_AMT%TYPE
            , P_BAD_REPORT_ADDITION_AMT IN HRW_OFFICE_TAX_DOC.BAD_REPORT_ADDITION_AMT%TYPE
            , P_OWN_TYPE                IN HRW_OFFICE_TAX_DOC.OWN_TYPE%TYPE
            , P_USER_ID                 IN HRW_OFFICE_TAX_DOC.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SUBMIT_YEAR   VARCHAR2(4);
    V_SEQ           NUMBER;
  BEGIN
    --문서번호 생성.
    V_SUBMIT_YEAR := TO_CHAR(P_SUBMIT_DATE, 'YYYY');
    BEGIN
      SELECT NVL(MAX(SUBSTR(TD.OFFICE_TAX_NO, 6, 4)), 0) + 1 AS NEXT_SEQ
        INTO V_SEQ
        FROM HRW_OFFICE_TAX_DOC TD
      WHERE TD.CORP_ID            = P_CORP_ID
        AND TD.SOB_ID             = P_SOB_ID
        AND TD.ORG_ID             = P_ORG_ID
        AND TO_CHAR(TD.SUBMIT_DATE, 'YYYY') = V_SUBMIT_YEAR
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SEQ := 1;
    END;
    P_OFFICE_TAX_NO := V_SUBMIT_YEAR || '-' || LPAD(V_SEQ, 4, '0');

    SELECT HRW_OFFICE_TAX_DOC_S1.NEXTVAL
      INTO P_OFFICE_TAX_ID
      FROM DUAL;

    INSERT INTO HRW_OFFICE_TAX_DOC
    ( OFFICE_TAX_ID
    , OFFICE_TAX_NO 
    , CORP_ID 
    , SOB_ID 
    , ORG_ID 
    , OFFICE_TAX_TYPE 
    , STD_YYYYMM 
    , PAY_YYYYMM 
    , SUBMIT_DATE 
    , PAY_SUPPLY_DATE 
    , TAX_OFFICER 
    , OWNER_TAX_FREE_YN 
    , NON_PAY_PERSON_YN 
    , REGULAR_WORKER_COUNT 
    , DAY_WORKER_COUNT 
    , TOTAL_PAYMENT_AMT 
    , TAX_FREE_AMT 
    , PAYMENT_TAX_AMT 
    , COMP_TAX_AMT 
    , DUE_DATE 
    , TAX_ADDITION_AMT 
    , TOTAL_TAX_AMT 
    , ORIGINAL_DUE_DATE 
    , DELAY_DAY_COUNT 
    , BAD_PAY_ADDITION_AMT 
    , BAD_REPORT_ADDITION_AMT 
    , OWN_TYPE 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_OFFICE_TAX_ID
    , P_OFFICE_TAX_NO
    , P_CORP_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_OFFICE_TAX_TYPE
    , P_STD_YYYYMM
    , P_PAY_YYYYMM
    , TRUNC(P_SUBMIT_DATE)
    , TRUNC(P_PAY_SUPPLY_DATE)
    , P_TAX_OFFICER
    , NVL(P_OWNER_TAX_FREE_YN, 0)
    , NVL(P_NON_PAY_PERSON_YN, 0)
    , NVL(P_REGULAR_WORKER_COUNT, 0)
    , NVL(P_DAY_WORKER_COUNT, 0)
    , NVL(P_TOTAL_PAYMENT_AMT, 0)
    , NVL(P_TAX_FREE_AMT, 0)
    , NVL(P_PAYMENT_TAX_AMT, 0)
    , NVL(P_COMP_TAX_AMT, 0)
    , TRUNC(P_DUE_DATE)
    , NVL(P_TAX_ADDITION_AMT, 0)
    , NVL(P_TOTAL_TAX_AMT, 0)
    , TRUNC(P_ORIGINAL_DUE_DATE)
    , NVL(P_DELAY_DAY_COUNT, 0)
    , NVL(P_BAD_PAY_ADDITION_AMT, 0)
    , NVL(P_BAD_REPORT_ADDITION_AMT, 0)
    , P_OWN_TYPE
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_OFFICE_TAX_DOC;

-- 지방소득세(종업원할 사업소세)신고서 UPDATE.
  PROCEDURE UPDATE_OFFICE_TAX_DOC
            ( W_OFFICE_TAX_ID           IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_SOB_ID                  IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                  IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , P_OFFICE_TAX_TYPE         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_TYPE%TYPE
            , P_STD_YYYYMM              IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM              IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SUBMIT_DATE             IN HRW_OFFICE_TAX_DOC.SUBMIT_DATE%TYPE
            , P_PAY_SUPPLY_DATE         IN HRW_OFFICE_TAX_DOC.PAY_SUPPLY_DATE%TYPE
            , P_TAX_OFFICER             IN HRW_OFFICE_TAX_DOC.TAX_OFFICER%TYPE
            , P_OWNER_TAX_FREE_YN       IN HRW_OFFICE_TAX_DOC.OWNER_TAX_FREE_YN%TYPE
            , P_NON_PAY_PERSON_YN       IN HRW_OFFICE_TAX_DOC.NON_PAY_PERSON_YN%TYPE
            , P_REGULAR_WORKER_COUNT    IN HRW_OFFICE_TAX_DOC.REGULAR_WORKER_COUNT%TYPE
            , P_DAY_WORKER_COUNT        IN HRW_OFFICE_TAX_DOC.DAY_WORKER_COUNT%TYPE
            , P_TOTAL_PAYMENT_AMT       IN HRW_OFFICE_TAX_DOC.TOTAL_PAYMENT_AMT%TYPE
            , P_TAX_FREE_AMT            IN HRW_OFFICE_TAX_DOC.TAX_FREE_AMT%TYPE
            , P_PAYMENT_TAX_AMT         IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_COMP_TAX_AMT            IN HRW_OFFICE_TAX_DOC.COMP_TAX_AMT%TYPE
            , P_DUE_DATE                IN HRW_OFFICE_TAX_DOC.DUE_DATE%TYPE
            , P_TAX_ADDITION_AMT        IN HRW_OFFICE_TAX_DOC.TAX_ADDITION_AMT%TYPE
            , P_TOTAL_TAX_AMT           IN HRW_OFFICE_TAX_DOC.TOTAL_TAX_AMT%TYPE
            , P_ORIGINAL_DUE_DATE       IN HRW_OFFICE_TAX_DOC.ORIGINAL_DUE_DATE%TYPE
            , P_DELAY_DAY_COUNT         IN HRW_OFFICE_TAX_DOC.DELAY_DAY_COUNT%TYPE
            , P_BAD_PAY_ADDITION_AMT    IN HRW_OFFICE_TAX_DOC.BAD_PAY_ADDITION_AMT%TYPE
            , P_BAD_REPORT_ADDITION_AMT IN HRW_OFFICE_TAX_DOC.BAD_REPORT_ADDITION_AMT%TYPE
            , P_OWN_TYPE                IN HRW_OFFICE_TAX_DOC.OWN_TYPE%TYPE
            , P_USER_ID                 IN HRW_OFFICE_TAX_DOC.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    -- 마감 여부 체크.
    IF HRW_OFFICE_TAX_SET_G.CLOSED_OFFICE_TAX_YN(W_OFFICE_TAX_ID) = 'Y' THEN
      -- 이미 마감처리됨.
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
      RETURN;
    END IF;

    UPDATE HRW_OFFICE_TAX_DOC
      SET OFFICE_TAX_TYPE         = P_OFFICE_TAX_TYPE
        , STD_YYYYMM              = P_STD_YYYYMM
        , PAY_YYYYMM              = P_PAY_YYYYMM
        , SUBMIT_DATE             = TRUNC(P_SUBMIT_DATE)
        , PAY_SUPPLY_DATE         = TRUNC(P_PAY_SUPPLY_DATE)
        , TAX_OFFICER             = P_TAX_OFFICER
        , OWNER_TAX_FREE_YN       = NVL(P_OWNER_TAX_FREE_YN, 'Y')
        , NON_PAY_PERSON_YN       = NVL(P_NON_PAY_PERSON_YN, 'Y')
        , REGULAR_WORKER_COUNT    = NVL(P_REGULAR_WORKER_COUNT, 0)
        , DAY_WORKER_COUNT        = NVL(P_DAY_WORKER_COUNT, 0)
        , TOTAL_PAYMENT_AMT       = NVL(P_TOTAL_PAYMENT_AMT, 0)
        , TAX_FREE_AMT            = NVL(P_TAX_FREE_AMT, 0)
        , PAYMENT_TAX_AMT         = NVL(P_PAYMENT_TAX_AMT, 0)
        , COMP_TAX_AMT            = NVL(P_COMP_TAX_AMT, 0)
        , DUE_DATE                = TRUNC(P_DUE_DATE)
        , TAX_ADDITION_AMT        = NVL(P_TAX_ADDITION_AMT, 0)
        , TOTAL_TAX_AMT           = NVL(P_TOTAL_TAX_AMT, 0)
        , ORIGINAL_DUE_DATE       = TRUNC(P_ORIGINAL_DUE_DATE)
        , DELAY_DAY_COUNT         = NVL(P_DELAY_DAY_COUNT, 0)
        , BAD_PAY_ADDITION_AMT    = NVL(P_BAD_PAY_ADDITION_AMT, 0)
        , BAD_REPORT_ADDITION_AMT = NVL(P_BAD_REPORT_ADDITION_AMT, 0)
        , OWN_TYPE                = P_OWN_TYPE
        , LAST_UPDATE_DATE        = V_SYSDATE
        , LAST_UPDATED_BY         = P_USER_ID
    WHERE OFFICE_TAX_ID           = W_OFFICE_TAX_ID;
  END UPDATE_OFFICE_TAX_DOC;

-- 지방소득세(종업원할 사업소세) 삭제.
  PROCEDURE DELETE_OFFICE_TAX_DOC
            ( W_OFFICE_TAX_ID              IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_SOB_ID                     IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                     IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    -- 마감 여부 체크.
    IF HRW_WITHHOLDING_SET_G.CLOSED_WITHHOLDING_YN(W_OFFICE_TAX_ID) = 'Y' THEN
      -- 이미 마감처리됨.
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052'));
      RETURN;
    END IF;

    DELETE FROM HRW_OFFICE_TAX_DOC
    WHERE OFFICE_TAX_ID        = W_OFFICE_TAX_ID;
  END DELETE_OFFICE_TAX_DOC;

---------------------------------------------------------------------------------------------------
-- 지방소득세(종업원할 사업소세)신고서 인쇄.
  PROCEDURE PRINT_OFFICE_TAX_DOC
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_OFFICE_TAX_ID         IN NUMBER
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT TD.OFFICE_TAX_NO
          , HRM_COMMON_G.CODE_NAME_F('OFFICE_TAX_TYPE', TD.OFFICE_TAX_TYPE, TD.SOB_ID, TD.ORG_ID) AS OFFICE_TAX_TYPE_DESC
          , TD.PAY_YYYYMM
          , TD.SUBMIT_DATE
          , TD.TAX_OFFICER
          , TD.OWNER_TAX_FREE_YN
          , TD.NON_PAY_PERSON_YN
          , HCM.CORP_NAME AS CORP_SITE_NAME
          , HCM.CORP_NAME
          , HCM.ADDRESS
          , HCM.VAT_NUMBER
          , HCM.LEGAL_NUMBER
          , HCM.PRESIDENT_NAME
          , HCM.TEL_NUMBER 
          , HCM.FAX_NUMBER
          , SUBSTR(TD.STD_YYYYMM, 1, 4) || '년 ' || SUBSTR(TD.STD_YYYYMM, 6, 2) || '월분 신고납부   (급여지급일 : ' ||
            HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TD.PAY_SUPPLY_DATE) || ')' AS STD_REPORT_TITLE
          , NVL(TD.REGULAR_WORKER_COUNT, 0) + NVL(TD.DAY_WORKER_COUNT, 0) AS PERSON_COUNT
          , TD.TOTAL_PAYMENT_AMT
          , TD.TAX_FREE_AMT
          , TD.PAYMENT_TAX_AMT
          , TD.COMP_TAX_AMT
          , TD.DUE_DATE
          , TD.TAX_ADDITION_AMT
          , TD.TOTAL_TAX_AMT
          , TD.ORIGINAL_DUE_DATE
          , TD.DELAY_DAY_COUNT
          , TD.BAD_PAY_ADDITION_AMT
          , TD.BAD_REPORT_ADDITION_AMT
          , CASE
              WHEN TD.OWN_TYPE = '1' THEN '자가'
              WHEN TD.OWN_TYPE = '2' THEN '임대'
            END OWN_TYPE_NAME
          , SUBSTR(TD.STD_YYYYMM, 1, 4) || '년 ' || SUBSTR(TD.STD_YYYYMM, 6, 2) || '월분' AS RECEIPT_YYYYMM
          , HCM.PRESIDENT_NAME AS RECEIPT_AGENT_NAME
          , HCM.ADDRESS AS RECEIPT_ADDRESS
          , TD.OFFICE_TAX_ID
        FROM HRW_OFFICE_TAX_DOC TD
          , ( SELECT CM.CORP_NAME       -- 법인.
                  , CM.PRESIDENT_NAME   -- 대표자.
                  , CM.LEGAL_NUMBER
                  , ( SELECT OU.VAT_NUMBER        
                        FROM HRM_OPERATING_UNIT OU
                      WHERE OU.CORP_ID        = CM.CORP_ID
                        AND OU.SOB_ID         = CM.SOB_ID
                        AND OU.ORG_ID         = CM.ORG_ID
                        AND (OU.DEFAULT_FLAG  = 'Y'
                        OR ROWNUM             <= 1)
                     ) AS VAT_NUMBER       -- 사업자번호.
                  , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
                  , CM.TEL_NUMBER       -- 전화번호.
                  , CM.FAX_NUMBER
                  , CM.EMAIL
                  , CM.CORP_ID
              FROM HRM_CORP_MASTER CM
              WHERE CM.SOB_ID             = P_SOB_ID
                AND CM.ORG_ID             = P_ORG_ID
             ) HCM
      WHERE TD.CORP_ID                  = HCM.CORP_ID
        AND TD.OFFICE_TAX_ID            = P_OFFICE_TAX_ID
      ;
  END PRINT_OFFICE_TAX_DOC;

-- 지방소득세(종업원할 사업소세)납부서.
  PROCEDURE PRINT_OFFICE_TAX_DOC_2
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , P_OFFICE_TAX_ID         IN NUMBER
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      --근로소득.
      SELECT NULL AS TAX_OFFICE_CODE
          , NULL AS TAX_ACCOUNT_CODE
          , NULL AS TAX_YYYYMM
          , NULL AS DUE_DATE
          , HRM_COMMON_G.CODE_NAME_F('OFFICE_TAX_TYPE', TD.OFFICE_TAX_TYPE, TD.SOB_ID, TD.ORG_ID) AS OFFICE_TAX_TYPE_DESC
          , TD.PAY_YYYYMM
          , TD.TAX_OFFICER || '장' AS TAX_OFFIECER
          , HCM.CORP_NAME AS CORP_SITE_NAME
          , HCM.CORP_NAME
          , HCM.ADDRESS
          , HCM.VAT_NUMBER
          , HCM.LEGAL_NUMBER
          , HCM.PRESIDENT_NAME
          , HCM.TEL_NUMBER 
          , NVL(TD.REGULAR_WORKER_COUNT, 0) + NVL(TD.DAY_WORKER_COUNT, 0) AS PERSON_COUNT
          , TD.TOTAL_PAYMENT_AMT
          , TD.TAX_FREE_AMT
          , TD.PAYMENT_TAX_AMT
          , TD.COMP_TAX_AMT
          , TD.TAX_ADDITION_AMT
          , CONVERT_NUM_TO_KOR(TD.TOTAL_TAX_AMT) AS KOR_TOTAL_TAX_AMT
          , TD.TOTAL_TAX_AMT
          , SUBSTR(TD.STD_YYYYMM, 1, 4) || '년 ' || SUBSTR(TD.STD_YYYYMM, 6, 2) || '월분' AS RECEIPT_YYYYMM
          , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(TD.SUBMIT_DATE) AS SUBMIT_DATE
        FROM HRW_OFFICE_TAX_DOC TD
          , ( SELECT CM.CORP_NAME       -- 법인.
                  , CM.PRESIDENT_NAME   -- 대표자.
                  , CM.LEGAL_NUMBER
                  , ( SELECT OU.VAT_NUMBER        
                        FROM HRM_OPERATING_UNIT OU
                      WHERE OU.CORP_ID        = CM.CORP_ID
                        AND OU.SOB_ID         = CM.SOB_ID
                        AND OU.ORG_ID         = CM.ORG_ID
                        AND (OU.DEFAULT_FLAG  = 'Y'
                        OR ROWNUM             <= 1)
                     ) AS VAT_NUMBER       -- 사업자번호.
                  , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
                  , CM.TEL_NUMBER       -- 전화번호.
                  , CM.FAX_NUMBER
                  , CM.EMAIL
                  , CM.CORP_ID
              FROM HRM_CORP_MASTER CM
              WHERE CM.SOB_ID             = P_SOB_ID
                AND CM.ORG_ID             = P_ORG_ID
             ) HCM
      WHERE TD.CORP_ID                  = HCM.CORP_ID
        AND TD.OFFICE_TAX_ID            = P_OFFICE_TAX_ID
      ;
  END PRINT_OFFICE_TAX_DOC_2;

---------------------------------------------------------------------------------------------------
-- 원천징수이행상황신고서 리스트 룩업.
  PROCEDURE LU_WITHHOLDING_LIST
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_CORP_ID           IN NUMBER
            , P_SUBMIT_YEAR       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT WD.WITHHOLDING_NO
          , HRM_COMMON_G.CODE_NAME_F('WITHHOLDING_TYPE', WD.WITHHOLDING_TYPE, WD.SOB_ID, WD.ORG_ID) AS WITHHOLDING_TYPE_DESC
          , TO_CHAR(WD.SUBMIT_DATE, 'YYYY-MM-DD') AS SUBMIT_DATE
          , WD.STD_YYYYMM
          , WD.PAY_YYYYMM
          , WD.A99_PAY_INCOME_TAX_AMT
          , WD.NEXT_REFUND_TAX_AMT
        FROM HRW_WITHHOLDING_DOC WD
      WHERE WD.CORP_ID                  = P_CORP_ID
        AND WD.SOB_ID                   = P_SOB_ID
        AND WD.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(WD.SUBMIT_DATE, 'YYYY') = P_SUBMIT_YEAR
      ORDER BY WD.WITHHOLDING_NO
      ;
  END LU_WITHHOLDING_LIST;

END HRW_OFFICE_TAX_G;
/
