CREATE OR REPLACE PACKAGE HRW_RESIDENT_INCOME_G
AS

-- 소득자조회(거주자사업소득).
  PROCEDURE SELECT_RESIDENT_BUSINESS
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_STD_YYYYMM        IN VARCHAR2 
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득)-소득지급내역 관리.
  PROCEDURE SELECT_RESIDENT_INCOME
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

  PROCEDURE INSERT_RESIDENT_INCOME
            ( P_RESIDENT_INCOME_ID  OUT HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_CORP_ID             IN HRW_RESIDENT_INCOME.CORP_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_EARNER_ID           IN HRW_RESIDENT_INCOME.EARNER_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE
            );

  PROCEDURE UPDATE_RESIDENT_INCOME
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE 
            );

  PROCEDURE DELETE_RESIDENT_INCOME
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득) 원천징수영수증 인쇄.
  PROCEDURE PRINT_RESIDENT_WITHHOLDING_H
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            );

-- 소득자(거주자사업소득) 원천징수영수증 인쇄 - 금액.
  PROCEDURE PRINT_RESIDENT_INCOME_L
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            );
            
---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득)-지급현황.
  PROCEDURE SELECT_RESIDENT_INCOME_LIST
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_CORP_ID           IN NUMBER
            , P_PAY_DATE_FR       IN DATE
            , P_PAY_DATE_TO       IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );
            
---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세율.
  PROCEDURE RESIDENT_INCOME_TAX_RATE_P
            ( P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_TAX_RATE          OUT NUMBER
            );

-- 거주자사업소득 세금계산(소득세,지방소득세, 농특세, 공제총액, 실지급액).
  PROCEDURE RESIDENT_INCOME_TAX_AMT_P
            ( P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_PAYMENT_AMOUNT    IN NUMBER
            , O_TAX_RATE          OUT NUMBER
            , O_INCOME_TAX_AMT    OUT NUMBER
            , O_LOCAL_TAX_AMT     OUT NUMBER
            , O_SP_TAX_AMT        OUT NUMBER
            , O_TOTAL_DED_AMT     OUT NUMBER
            , O_REAL_AMT          OUT NUMBER
            );

---------------------------------------------------------------------------------------------------            
-- 소득자조회(거주자기타소득).
  PROCEDURE SELECT_RESIDENT_ETC 
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_STD_YYYYMM        IN VARCHAR2 
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );
                        
-- 소득자(거주자사업소득)-소득지급내역 관리.
  PROCEDURE SELECT_RESIDENT_INCOME_ETC 
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

  PROCEDURE INSERT_RESIDENT_INCOME_ETC 
            ( P_RESIDENT_INCOME_ID  OUT HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_CORP_ID             IN HRW_RESIDENT_INCOME.CORP_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_EARNER_ID           IN HRW_RESIDENT_INCOME.EARNER_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_INCOME_CLASS_ETC    IN HRW_RESIDENT_INCOME.INCOME_CLASS_ETC%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_PAYMENT_ETC_AMOUNT  IN HRW_RESIDENT_INCOME.PAYMENT_ETC_AMOUNT%TYPE
            , P_EXP_RATE            IN HRW_RESIDENT_INCOME.EXP_RATE%TYPE
            , P_EXP_AMOUNT          IN HRW_RESIDENT_INCOME.EXP_AMOUNT%TYPE
            , P_INCOME_AMOUNT       IN HRW_RESIDENT_INCOME.INCOME_AMOUNT%TYPE
            , P_INCOME_ETC_AMOUNT   IN HRW_RESIDENT_INCOME.INCOME_ETC_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE
            );

  PROCEDURE UPDATE_RESIDENT_INCOME_ETC 
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_INCOME_CLASS_ETC    IN HRW_RESIDENT_INCOME.INCOME_CLASS_ETC%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_PAYMENT_ETC_AMOUNT  IN HRW_RESIDENT_INCOME.PAYMENT_ETC_AMOUNT%TYPE
            , P_EXP_RATE            IN HRW_RESIDENT_INCOME.EXP_RATE%TYPE
            , P_EXP_AMOUNT          IN HRW_RESIDENT_INCOME.EXP_AMOUNT%TYPE
            , P_INCOME_AMOUNT       IN HRW_RESIDENT_INCOME.INCOME_AMOUNT%TYPE
            , P_INCOME_ETC_AMOUNT   IN HRW_RESIDENT_INCOME.INCOME_ETC_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE 
            );

  PROCEDURE DELETE_RESIDENT_INCOME_ETC 
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            );


---------------------------------------------------------------------------------------------------            
-- 거주자기타소득 세금계산(소득세).
  PROCEDURE RESIDENT_ETC_INCOME_TAX_AMT_P
            ( P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_STD_DATE          IN DATE 
            , P_TOT_INCOME_AMOUNT IN NUMBER
            , P_TAX_RATE          IN NUMBER
            , O_INCOME_TAX_AMT    OUT NUMBER 
            );

-- 거주자기타소득 세금계산(지방소득세).
  PROCEDURE RESIDENT_ETC_LOCAL_TAX_AMT_P
            ( P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_STD_DATE          IN DATE 
            , P_INCOME_TAX_AMT    IN NUMBER
            , O_LOCAL_TAX_AMT     OUT NUMBER 
            );

-- 거주자기타소득 세금계산(농특세).
  PROCEDURE RESIDENT_ETC_SP_TAX_AMT_P
            ( P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_STD_DATE          IN DATE 
            , P_INCOME_TAX_AMT    IN NUMBER
            , O_SP_TAX_AMT        OUT NUMBER 
            ); 
            
-- 소득자(기타사업소득) 원천징수영수증 인쇄.
  PROCEDURE PRINT_RESIDENT_WH_ETC
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER      
            , P_PRINT_TYPE        IN VARCHAR2  -- 1:소득자 보관용, 2:발행자보관용       
            );


-- 소득자(기타사업소득) 원천징수영수증 인쇄 - 금액.
  PROCEDURE PRINT_RESIDENT_INCOME_ETC
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            );

            
---------------------------------------------------------------------------------------------------
-- 소득자(거주자기타소득)-지급현황.
  PROCEDURE RESIDENT_INCOME_ETC_LIST
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_CORP_ID           IN NUMBER
            , P_PAY_DATE_FR       IN DATE
            , P_PAY_DATE_TO       IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );
                                    
END HRW_RESIDENT_INCOME_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_RESIDENT_INCOME_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_RESIDENT_INCOME_G
/* DESCRIPTION  : 원천세 소득등록-거주사업소득자/기타소득자.
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 소득자조회(거주자사업소득).
  PROCEDURE SELECT_RESIDENT_BUSINESS
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_STD_YYYYMM        IN VARCHAR2 
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM')); 
  BEGIN
    OPEN P_CURSOR FOR
      SELECT EM.EARNER_ID
          , EM.EARNER_NUM
          , EM.NAME
          , EM.REPRE_NUM
          , EM.NATIONALITY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('NATIONALITY_TYPE', EM.NATIONALITY_TYPE, EM.SOB_ID, EM.ORG_ID) AS NATIONALITY_TYPE_DESC
          , EM.BUSINESS_CODE
          , HRM_COMMON_G.CODE_NAME_F('BUSINESS_CODE', EM.BUSINESS_CODE, EM.SOB_ID, EM.ORG_ID) AS BUSINESS_DESC
          , EM.YEAR_ADJUST_YN
          , EM.INCOME_DATE_FR
          , EM.INCOME_DATE_TO
          , EM.ZIP_CODE
          , EM.ADDRESS1
          , EM.ADDRESS2
          , EM.DEPT_ID
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(EM.DEPT_ID) AS DEPT_DESC
          , EM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(EM.FLOOR_ID) AS FLOOR_DESC
          , EM.COMPANY_NAME
          , EM.TAX_REG_NO
        FROM HRW_EARNER_MASTER EM
          , FI_ACCOUNT_CONTROL AC
       WHERE EM.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID(+)
         AND EM.EARNER_TYPE         = '10'  --거주자사업소득자.
         AND EM.CORP_ID             = P_CORP_ID
         AND EM.SOB_ID              = P_SOB_ID
         AND EM.ORG_ID              = P_ORG_ID
         AND EM.INCOME_DATE_FR      <= LAST_DAY(V_STD_DATE)
         AND (EM.INCOME_DATE_TO     >= V_STD_DATE OR EM.INCOME_DATE_TO IS NULL) 
      ORDER BY EM.EARNER_NUM
      ;
  END SELECT_RESIDENT_BUSINESS;

---------------------------------------------------------------------------------------------------
-- 소득지급내역.
  PROCEDURE SELECT_RESIDENT_INCOME
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM')); 
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT RI.RESIDENT_INCOME_ID 
          , RI.EARNER_ID
          , RI.PAY_DATE
          , RI.RECEIPT_DATE
          , RI.PAYMENT_AMOUNT
          , RI.TAX_RATE
          , RI.INCOME_TAX_AMT
          , RI.LOCAL_TAX_AMT
          , RI.SP_TAX_AMT
          , NVL(RI.INCOME_TAX_AMT, 0) + NVL(RI.LOCAL_TAX_AMT, 0) + NVL(RI.SP_TAX_AMT, 0) AS TOTAL_DED_AMT
          , RI.REAL_AMT
        FROM HRW_RESIDENT_INCOME RI 
      WHERE RI.EARNER_ID          = P_EARNER_ID
        AND RI.PAY_DATE           >= V_STD_DATE
        AND RI.PAY_DATE           <= LAST_DAY(V_STD_DATE)
        AND RI.SOB_ID             = P_SOB_ID
        AND RI.ORG_ID             = P_ORG_ID
      ;
  END SELECT_RESIDENT_INCOME;

  PROCEDURE INSERT_RESIDENT_INCOME
            ( P_RESIDENT_INCOME_ID  OUT HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_CORP_ID             IN HRW_RESIDENT_INCOME.CORP_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_EARNER_ID           IN HRW_RESIDENT_INCOME.EARNER_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    SELECT HRW_RESIDENT_INCOME_S1.NEXTVAL
      INTO P_RESIDENT_INCOME_ID 
      FROM DUAL;

    INSERT INTO HRW_RESIDENT_INCOME
    ( RESIDENT_INCOME_ID
    , CORP_ID 
    , SOB_ID 
    , ORG_ID 
    , EARNER_ID 
    , PAY_DATE 
    , RECEIPT_DATE 
    , PAYMENT_AMOUNT 
    , TAX_RATE 
    , INCOME_TAX_AMT 
    , LOCAL_TAX_AMT 
    , SP_TAX_AMT 
    , REAL_AMT 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_RESIDENT_INCOME_ID 
    , P_CORP_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_EARNER_ID
    , TRUNC(P_PAY_DATE) 
    , TRUNC(P_RECEIPT_DATE)
    , NVL(P_PAYMENT_AMOUNT, 0)
    , NVL(P_TAX_RATE, 0)
    , NVL(P_INCOME_TAX_AMT, 0)
    , NVL(P_LOCAL_TAX_AMT, 0)
    , NVL(P_SP_TAX_AMT, 0)
    , NVL(P_REAL_AMT, 0)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );
  END INSERT_RESIDENT_INCOME;

  PROCEDURE UPDATE_RESIDENT_INCOME
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE HRW_RESIDENT_INCOME
    SET PAY_DATE                = TRUNC(P_PAY_DATE) 
      , RECEIPT_DATE            = TRUNC(P_RECEIPT_DATE)
      , PAYMENT_AMOUNT          = NVL(P_PAYMENT_AMOUNT, 0)
      , TAX_RATE                = NVL(P_TAX_RATE, 0)
      , INCOME_TAX_AMT          = NVL(P_INCOME_TAX_AMT, 0)
      , LOCAL_TAX_AMT           = NVL(P_LOCAL_TAX_AMT, 0)
      , SP_TAX_AMT              = NVL(P_SP_TAX_AMT, 0)
      , REAL_AMT                = NVL(P_REAL_AMT, 0)
      , LAST_UPDATE_DATE        = V_SYSDATE
      , LAST_UPDATED_BY         = P_USER_ID
    WHERE RESIDENT_INCOME_ID    = W_RESIDENT_INCOME_ID
    ;
  END UPDATE_RESIDENT_INCOME;

  PROCEDURE DELETE_RESIDENT_INCOME
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRW_RESIDENT_INCOME
    WHERE RESIDENT_INCOME_ID      = W_RESIDENT_INCOME_ID
    ;
  END DELETE_RESIDENT_INCOME;

---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득) 원천징수영수증 인쇄.
  PROCEDURE PRINT_RESIDENT_WITHHOLDING_H
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT EM.EARNER_ID
          , TO_CHAR(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YYYY') AS WITHHOLDING_YEAR
          , HCM.CORP_NAME
          , HCM.PRESIDENT_NAME
          , HCM.LEGAL_NUMBER
          , HCM.VAT_NUMBER
          , HCM.ADDRESS AS CORP_ADDRESS
          , DECODE(EM.NATIONALITY_TYPE, '9', NULL, 'V') AS NATIONALITY_1
          , DECODE(EM.NATIONALITY_TYPE, '9', 'V', NULL) AS NATIONALITY_9
          , CASE 
              WHEN EM.NATIONALITY_TYPE = '1' THEN NULL
              ELSE HC1.NATION_NAME
            END AS NATION_NAME
          , CASE 
              WHEN EM.NATIONALITY_TYPE = '1' THEN NULL
              ELSE HC1.NATION_ISO_CODE
            END AS NATION_ISO_CODE
          , EM.COMPANY_NAME
          , EM.TAX_REG_NO
          , NULL AS COMPANY_ADDRESS
          , EM.NAME
          , EM.REPRE_NUM
          , EM.ADDRESS1 || EM.ADDRESS2 AS ADDRESS
          , EM.BUSINESS_CODE
          , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(SYSDATE) AS PRINT_DATE
          , HCM.WITHHOLDING_AGENT
          , '북인천 세무서장' AS TAX_OFFICE
        FROM HRW_EARNER_MASTER EM
          , ( SELECT CM.CORP_ID
                  , CM.SOB_ID
                  , CM.ORG_ID
                  , CM.CORP_NAME
                  , CM.PRESIDENT_NAME
                  , CM.LEGAL_NUMBER
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
          , ( SELECT HC.COMMON_ID AS NATION_ID
                  , HC.CODE_NAME AS NATION_NAME
                  , HC.VALUE1 AS NATION_ISO_CODE
                FROM HRM_COMMON HC
              WHERE HC.GROUP_CODE       = 'NATION'
                AND HC.SOB_ID           = P_SOB_ID
                AND HC.ORG_ID           = P_ORG_ID
            ) HC1  
      WHERE EM.CORP_ID                  = HCM.CORP_ID
        AND EM.SOB_ID                   = HCM.SOB_ID
        AND EM.ORG_ID                   = HCM.ORG_ID
        AND EM.NATION_ID                = HC1.NATION_ID(+)
        AND EM.EARNER_ID                = P_EARNER_ID
      ;
  END PRINT_RESIDENT_WITHHOLDING_H;

-- 소득자(거주자사업소득) 원천징수영수증 인쇄 - 금액.
  PROCEDURE PRINT_RESIDENT_INCOME_L
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT IR.EARNER_ID
          , TO_CHAR(IR.PAY_DATE, 'YYYY') AS PAY_YEAR
          , TO_CHAR(IR.PAY_DATE, 'MM') AS PAY_MONTH
          , TO_CHAR(IR.PAY_DATE, 'DD') AS PAY_DAY
          , TO_CHAR(IR.RECEIPT_DATE, 'YYYY') AS RECEIPT_YEAR
          , TO_CHAR(IR.RECEIPT_DATE, 'MM') AS RECEIPT_MONTH
          , IR.PAYMENT_AMOUNT
          , IR.TAX_RATE
          , IR.INCOME_TAX_AMT
          , IR.LOCAL_TAX_AMT
          , NVL(IR.INCOME_TAX_AMT, 0) + NVL(IR.LOCAL_TAX_AMT, 0) + NVL(IR.SP_TAX_AMT, 0) AS TOTAL_DED_AMT
          , IR.REAL_AMT
        FROM HRW_RESIDENT_INCOME IR
      WHERE IR.EARNER_ID          = P_EARNER_ID
        AND IR.PAY_DATE           >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR')
        AND IR.PAY_DATE           <= ADD_MONTHS(TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR'), 12) - 1
        AND IR.SOB_ID             = P_SOB_ID
        AND IR.ORG_ID             = P_ORG_ID
        AND ROWNUM                <= 12
      ORDER BY IR.RECEIPT_DATE
      ;
  END PRINT_RESIDENT_INCOME_L;
  
---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득)-지급현황.
  PROCEDURE SELECT_RESIDENT_INCOME_LIST
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_CORP_ID           IN NUMBER
            , P_PAY_DATE_FR       IN DATE
            , P_PAY_DATE_TO       IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CASE
               WHEN GROUPING(CM.CORP_NAME) = 1 THEN PT_TOTAL_SUM
               WHEN GROUPING(EM.NAME) = 1 THEN PT_SUB_SUM
               ELSE CM.CORP_NAME
             END AS CORP_NAME
           , EM.EARNER_NUM
           , EM.NAME
           , EM.REPRE_NUM
           , NVL(ISB.PAY_DATE, NULL) AS PAY_DATE
           , NVL(ISB.RECEIPT_DATE, NULL) AS RECEIPT_DATE
           , SUM(ISB.PAYMENT_AMOUNT) AS PAYMENT_AMOUNT
           , NVL(ISB.TAX_RATE, NULL) AS TAX_RATE
           , SUM(ISB.INCOME_TAX_AMT) AS INCOME_TAX_AMT
           , SUM(ISB.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT
           , SUM(NVL(ISB.INCOME_TAX_AMT, 0) + NVL(ISB.LOCAL_TAX_AMT, 0)) AS TOTAL_DED_AMT
           , SUM(ISB.REAL_AMT) AS REAL_AMT
        FROM HRW_EARNER_MASTER EM
          , HRW_RESIDENT_INCOME ISB
          , HRM_CORP_MASTER CM
      WHERE EM.EARNER_ID            = ISB.EARNER_ID
        AND EM.CORP_ID              = CM.CORP_ID
        AND EM.CORP_ID              = P_CORP_ID
        AND EM.EARNER_TYPE          = '10'  -- 거주자 사업소득 
        AND ISB.PAY_DATE            BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND EM.SOB_ID               = P_SOB_ID
        AND EM.ORG_ID               = P_ORG_ID
      GROUP BY ROLLUP(( CM.CORP_NAME)
           , (EM.EARNER_NUM
           , EM.NAME
           , EM.REPRE_NUM
           , ISB.PAY_DATE
           , ISB.RECEIPT_DATE
           , ISB.TAX_RATE
           ))
      ;
  END SELECT_RESIDENT_INCOME_LIST;
  
---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세율.
  PROCEDURE RESIDENT_INCOME_TAX_RATE_P
            ( P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_TAX_RATE          OUT NUMBER
            )
  AS
  BEGIN
    O_TAX_RATE := 3;  
  END RESIDENT_INCOME_TAX_RATE_P;

---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세금계산(소득세,지방소득세, 농특세, 공제총액, 실지급액).
  PROCEDURE RESIDENT_INCOME_TAX_AMT_P
            ( P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_PAYMENT_AMOUNT    IN NUMBER
            , O_TAX_RATE          OUT NUMBER
            , O_INCOME_TAX_AMT    OUT NUMBER
            , O_LOCAL_TAX_AMT     OUT NUMBER
            , O_SP_TAX_AMT        OUT NUMBER
            , O_TOTAL_DED_AMT     OUT NUMBER
            , O_REAL_AMT          OUT NUMBER
            )
  AS
  BEGIN
    -- 세율.
    RESIDENT_INCOME_TAX_RATE_P(P_SOB_ID, P_ORG_ID, O_TAX_RATE);
    
    -- 소득세.
    O_INCOME_TAX_AMT := TRUNC(NVL(P_PAYMENT_AMOUNT, 0) * (O_TAX_RATE / 100));
    O_LOCAL_TAX_AMT := TRUNC(NVL(O_INCOME_TAX_AMT, 0) * ( 10  / 100));
    O_SP_TAX_AMT := NULL;
    O_TOTAL_DED_AMT := NVL(O_INCOME_TAX_AMT, 0) + NVL(O_LOCAL_TAX_AMT, 0);
    O_REAL_AMT := NVL(P_PAYMENT_AMOUNT, 0) - NVL(O_TOTAL_DED_AMT, 0);
    IF O_REAL_AMT < 0 THEN
      O_REAL_AMT := 0;
    END IF;
  END RESIDENT_INCOME_TAX_AMT_P;
  
---------------------------------------------------------------------------------------------------            
-- 소득자조회(거주자기타소득).
  PROCEDURE SELECT_RESIDENT_ETC 
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_STD_YYYYMM        IN VARCHAR2 
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM')); 
  BEGIN
    OPEN P_CURSOR FOR
      SELECT EM.EARNER_ID
          , EM.EARNER_NUM
          , EM.NAME
          , EM.REPRE_NUM
          , EM.NATIONALITY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('NATIONALITY_TYPE', EM.NATIONALITY_TYPE, EM.SOB_ID, EM.ORG_ID) AS NATIONALITY_TYPE_DESC
          , EM.YEAR_ADJUST_YN
          , EM.INCOME_DATE_FR
          , EM.INCOME_DATE_TO
          , EM.ZIP_CODE
          , EM.ADDRESS1
          , EM.ADDRESS2
          , EM.DEPT_ID
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(EM.DEPT_ID) AS DEPT_DESC
          , EM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(EM.FLOOR_ID) AS FLOOR_DESC
          , EM.SUPPLY_AMT 
        FROM HRW_EARNER_MASTER EM
          , FI_ACCOUNT_CONTROL AC
       WHERE EM.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID(+)
         AND EM.EARNER_TYPE         = '15'  --거주자기타소득자.
         AND EM.CORP_ID             = P_CORP_ID
         AND EM.SOB_ID              = P_SOB_ID
         AND EM.ORG_ID              = P_ORG_ID
         AND EM.INCOME_DATE_FR      <= LAST_DAY(V_STD_DATE)
         AND (EM.INCOME_DATE_TO     >= V_STD_DATE OR EM.INCOME_DATE_TO IS NULL) 
      ORDER BY EM.EARNER_NUM
      ;
  END SELECT_RESIDENT_ETC;

-- 소득자(거주자사업소득)-소득지급내역 관리.
  PROCEDURE SELECT_RESIDENT_INCOME_ETC 
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
    V_STD_DATE          DATE := TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM')); 
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT RI.RESIDENT_INCOME_ID 
          , RI.EARNER_ID
          , RI.PAY_DATE
          , RI.RECEIPT_DATE
          , RI.INCOME_CLASS_ETC
          , T1.INCOME_CLASS_ETC_DESC 
          , RI.PAYMENT_AMOUNT
          , RI.PAYMENT_ETC_AMOUNT
          , NVL(RI.PAYMENT_AMOUNT, 0) + NVL(RI.PAYMENT_ETC_AMOUNT, 0) AS TOT_PAYMENT_AMOUNT 
          , RI.EXP_RATE
          , RI.EXP_AMOUNT
          , RI.INCOME_AMOUNT
          , RI.INCOME_ETC_AMOUNT
          , NVL(RI.INCOME_AMOUNT, 0) + NVL(RI.INCOME_ETC_AMOUNT, 0) AS TOT_INCOME_AMOUNT
          , RI.TAX_RATE
          , RI.INCOME_TAX_AMT
          , RI.LOCAL_TAX_AMT
          , RI.SP_TAX_AMT
          , NVL(RI.INCOME_TAX_AMT, 0) + NVL(RI.LOCAL_TAX_AMT, 0) + NVL(RI.SP_TAX_AMT, 0) AS TOTAL_DED_AMT
          , RI.REAL_AMT
          , RI.DESCRIPTION 
        FROM HRW_RESIDENT_INCOME RI 
           , ( SELECT HC.COMMON_ID AS INCOME_CLASS_ETC_ID 
                    , HC.SOB_ID 
                    , HC.ORG_ID 
                    , HC.CODE      AS INCOME_CLASS_ETC
                    , HC.CODE_NAME AS INCOME_CLASS_ETC_DESC 
                    , TO_NUMBER(REPLACE(HC.VALUE1, ',', ''), '9999D999999', 'NLS_NUMERIC_CHARACTERS=.,') AS EXP_RATE 
                    , TO_NUMBER(REPLACE(HC.VALUE2, ',', ''), '9999D999999', 'NLS_NUMERIC_CHARACTERS=.,') AS TAX_RATE  
                 FROM HRM_COMMON HC
                WHERE HC.GROUP_CODE   = 'INCOME_CLASS_ETC'
                  AND HC.SOB_ID       = P_SOB_ID
                  AND HC.ORG_ID       = P_ORG_ID               
             ) T1 
      WHERE RI.INCOME_CLASS_ETC   = T1.INCOME_CLASS_ETC
        AND RI.SOB_ID             = T1.SOB_ID
        AND RI.ORG_ID             = T1.ORG_ID     
        AND RI.EARNER_ID          = P_EARNER_ID
        AND RI.PAY_DATE           >= V_STD_DATE
        AND RI.PAY_DATE           <= LAST_DAY(V_STD_DATE)
        AND RI.SOB_ID             = P_SOB_ID
        AND RI.ORG_ID             = P_ORG_ID
      ;
  END SELECT_RESIDENT_INCOME_ETC;

  PROCEDURE INSERT_RESIDENT_INCOME_ETC 
            ( P_RESIDENT_INCOME_ID  OUT HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_CORP_ID             IN HRW_RESIDENT_INCOME.CORP_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_EARNER_ID           IN HRW_RESIDENT_INCOME.EARNER_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_INCOME_CLASS_ETC    IN HRW_RESIDENT_INCOME.INCOME_CLASS_ETC%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_PAYMENT_ETC_AMOUNT  IN HRW_RESIDENT_INCOME.PAYMENT_ETC_AMOUNT%TYPE
            , P_EXP_RATE            IN HRW_RESIDENT_INCOME.EXP_RATE%TYPE
            , P_EXP_AMOUNT          IN HRW_RESIDENT_INCOME.EXP_AMOUNT%TYPE
            , P_INCOME_AMOUNT       IN HRW_RESIDENT_INCOME.INCOME_AMOUNT%TYPE
            , P_INCOME_ETC_AMOUNT   IN HRW_RESIDENT_INCOME.INCOME_ETC_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    SELECT HRW_RESIDENT_INCOME_S1.NEXTVAL
      INTO P_RESIDENT_INCOME_ID 
      FROM DUAL;

    INSERT INTO HRW_RESIDENT_INCOME
    ( RESIDENT_INCOME_ID
    , CORP_ID 
    , SOB_ID 
    , ORG_ID 
    , EARNER_ID 
    , PAY_DATE 
    , RECEIPT_DATE 
    , PAYMENT_AMOUNT 
    , PAYMENT_ETC_AMOUNT 
    , INCOME_CLASS_ETC 
    , EXP_RATE 
    , EXP_AMOUNT 
    , INCOME_AMOUNT 
    , INCOME_ETC_AMOUNT  
    , TAX_RATE 
    , INCOME_TAX_AMT 
    , LOCAL_TAX_AMT 
    , SP_TAX_AMT 
    , REAL_AMT 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_RESIDENT_INCOME_ID 
    , P_CORP_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_EARNER_ID
    , TRUNC(P_PAY_DATE) 
    , TRUNC(P_RECEIPT_DATE)
    , NVL(P_PAYMENT_AMOUNT, 0)
    , NVL(P_PAYMENT_ETC_AMOUNT, 0) 
    , NVL(P_INCOME_CLASS_ETC, 0) 
    , NVL(P_EXP_RATE, 0) 
    , NVL(P_EXP_AMOUNT, 0) 
    , NVL(P_INCOME_AMOUNT, 0) 
    , NVL(P_INCOME_ETC_AMOUNT, 0)  
    , NVL(P_TAX_RATE, 0)
    , NVL(P_INCOME_TAX_AMT, 0)
    , NVL(P_LOCAL_TAX_AMT, 0)
    , NVL(P_SP_TAX_AMT, 0)
    , NVL(P_REAL_AMT, 0)
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );
  END INSERT_RESIDENT_INCOME_ETC;            

  PROCEDURE UPDATE_RESIDENT_INCOME_ETC 
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            , P_PAY_DATE            IN HRW_RESIDENT_INCOME.PAY_DATE%TYPE
            , P_RECEIPT_DATE        IN HRW_RESIDENT_INCOME.RECEIPT_DATE%TYPE
            , P_INCOME_CLASS_ETC    IN HRW_RESIDENT_INCOME.INCOME_CLASS_ETC%TYPE
            , P_PAYMENT_AMOUNT      IN HRW_RESIDENT_INCOME.PAYMENT_AMOUNT%TYPE
            , P_PAYMENT_ETC_AMOUNT  IN HRW_RESIDENT_INCOME.PAYMENT_ETC_AMOUNT%TYPE
            , P_EXP_RATE            IN HRW_RESIDENT_INCOME.EXP_RATE%TYPE
            , P_EXP_AMOUNT          IN HRW_RESIDENT_INCOME.EXP_AMOUNT%TYPE
            , P_INCOME_AMOUNT       IN HRW_RESIDENT_INCOME.INCOME_AMOUNT%TYPE
            , P_INCOME_ETC_AMOUNT   IN HRW_RESIDENT_INCOME.INCOME_ETC_AMOUNT%TYPE
            , P_TAX_RATE            IN HRW_RESIDENT_INCOME.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT      IN HRW_RESIDENT_INCOME.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT       IN HRW_RESIDENT_INCOME.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT          IN HRW_RESIDENT_INCOME.SP_TAX_AMT%TYPE
            , P_REAL_AMT            IN HRW_RESIDENT_INCOME.REAL_AMT%TYPE
            , P_USER_ID             IN HRW_RESIDENT_INCOME.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE HRW_RESIDENT_INCOME
    SET PAY_DATE                = TRUNC(P_PAY_DATE) 
      , RECEIPT_DATE            = TRUNC(P_RECEIPT_DATE)
      , PAYMENT_AMOUNT          = NVL(P_PAYMENT_AMOUNT, 0)
      , PAYMENT_ETC_AMOUNT      = NVL(P_PAYMENT_ETC_AMOUNT, 0) 
      , INCOME_CLASS_ETC        = NVL(P_INCOME_CLASS_ETC, 0) 
      , EXP_RATE                = NVL(P_EXP_RATE, 0) 
      , EXP_AMOUNT              = NVL(P_EXP_AMOUNT, 0) 
      , INCOME_AMOUNT           = NVL(P_INCOME_AMOUNT, 0) 
      , INCOME_ETC_AMOUNT       = NVL(P_INCOME_ETC_AMOUNT, 0) 
      , TAX_RATE                = NVL(P_TAX_RATE, 0)
      , INCOME_TAX_AMT          = NVL(P_INCOME_TAX_AMT, 0)
      , LOCAL_TAX_AMT           = NVL(P_LOCAL_TAX_AMT, 0)
      , SP_TAX_AMT              = NVL(P_SP_TAX_AMT, 0)
      , REAL_AMT                = NVL(P_REAL_AMT, 0)
      , LAST_UPDATE_DATE        = V_SYSDATE
      , LAST_UPDATED_BY         = P_USER_ID
    WHERE RESIDENT_INCOME_ID    = W_RESIDENT_INCOME_ID
    ;
  END UPDATE_RESIDENT_INCOME_ETC;

  PROCEDURE DELETE_RESIDENT_INCOME_ETC 
            ( W_RESIDENT_INCOME_ID  IN HRW_RESIDENT_INCOME.RESIDENT_INCOME_ID%TYPE
            , P_SOB_ID              IN HRW_RESIDENT_INCOME.SOB_ID%TYPE
            , P_ORG_ID              IN HRW_RESIDENT_INCOME.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRW_RESIDENT_INCOME
    WHERE RESIDENT_INCOME_ID      = W_RESIDENT_INCOME_ID
    ;
  END DELETE_RESIDENT_INCOME_ETC;


---------------------------------------------------------------------------------------------------            
-- 거주자기타소득 세금계산(소득세).
  PROCEDURE RESIDENT_ETC_INCOME_TAX_AMT_P
            ( P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_STD_DATE          IN DATE 
            , P_TOT_INCOME_AMOUNT IN NUMBER
            , P_TAX_RATE          IN NUMBER
            , O_INCOME_TAX_AMT    OUT NUMBER 
            )
  AS
  BEGIN
    O_INCOME_TAX_AMT := TRUNC(NVL(P_TOT_INCOME_AMOUNT, 0) * (NVL(P_TAX_RATE, 0) / 100));  
  END RESIDENT_ETC_INCOME_TAX_AMT_P;

-- 거주자기타소득 세금계산(지방소득세).
  PROCEDURE RESIDENT_ETC_LOCAL_TAX_AMT_P
            ( P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_STD_DATE          IN DATE 
            , P_INCOME_TAX_AMT    IN NUMBER
            , O_LOCAL_TAX_AMT     OUT NUMBER 
            )        
  AS
    V_SYSDATE           DATE;
    V_LOCAL_TAX_RATE    NUMBER;
  BEGIN
    IF P_STD_DATE IS NULL THEN
      V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
    ELSE
      V_SYSDATE := P_STD_DATE;
    END IF;
    
    BEGIN
      SELECT TO_NUMBER(REPLACE(HC.VALUE1, ',', ''), '9999D999999', 'NLS_NUMERIC_CHARACTERS=.,') AS LOCAL_TAX_RATE 
        INTO V_LOCAL_TAX_RATE 
        FROM HRM_COMMON HC
       WHERE HC.GROUP_CODE            = 'TAX_RATE'
         AND HC.CODE                  = 'LOCAL'
         AND HC.SOB_ID                = P_SOB_ID
         AND HC.ORG_ID                = P_ORG_ID
         AND HC.ENABLED_FLAG          = 'Y'
         AND HC.EFFECTIVE_DATE_FR     <= LAST_DAY(V_SYSDATE)
         AND (HC.EFFECTIVE_DATE_TO    >= TRUNC(V_SYSDATE) OR HC.EFFECTIVE_DATE_TO IS NULL)
         AND ROWNUM                   <= 1
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_LOCAL_TAX_RATE := 0;
    END;
    O_LOCAL_TAX_AMT := TRUNC(NVL(P_INCOME_TAX_AMT, 0) * (NVL(V_LOCAL_TAX_RATE, 0) / 100));  
  END RESIDENT_ETC_LOCAL_TAX_AMT_P;

-- 거주자기타소득 세금계산(농특세).
  PROCEDURE RESIDENT_ETC_SP_TAX_AMT_P
            ( P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_STD_DATE          IN DATE 
            , P_INCOME_TAX_AMT    IN NUMBER
            , O_SP_TAX_AMT        OUT NUMBER 
            )
  AS
  BEGIN
    O_SP_TAX_AMT := 0;
  END RESIDENT_ETC_SP_TAX_AMT_P; 
            
-- 소득자(기타사업소득) 원천징수영수증 인쇄.
  PROCEDURE PRINT_RESIDENT_WH_ETC
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER      
            , P_PRINT_TYPE        IN VARCHAR2  -- 1:소득자 보관용, 2:발행자보관용       
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT TO_CHAR(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YYYY') AS WITHHOLDING_YEAR
          , HCM.CORP_NAME
          , HCM.PRESIDENT_NAME
          , CASE
              WHEN P_PRINT_TYPE = '1' THEN ''
              ELSE HCM.LEGAL_NUMBER
            END AS LEGAL_NUMBER 
          , HCM.VAT_NUMBER
          , HCM.ADDRESS AS CORP_ADDRESS
          , DECODE(EM.NATIONALITY_TYPE, '9', NULL, 'V') AS NATIONALITY_1
          , DECODE(EM.NATIONALITY_TYPE, '9', 'V', NULL) AS NATIONALITY_9
          , CASE 
              WHEN EM.NATIONALITY_TYPE = '1' THEN NULL
              ELSE HC1.NATION_NAME
            END AS NATION_NAME
          , CASE 
              WHEN EM.NATIONALITY_TYPE = '1' THEN NULL
              ELSE HC1.NATION_ISO_CODE
            END AS NATION_ISO_CODE
          , EM.COMPANY_NAME
          , EM.TAX_REG_NO
          , NULL AS COMPANY_ADDRESS
          , EM.NAME
          , EM.REPRE_NUM
          , EM.ADDRESS1 || EM.ADDRESS2 AS ADDRESS
          , EM.BUSINESS_CODE
          , HRM_COMMON_DATE_G.DATE_YYYYMMDD_F(SYSDATE) AS PRINT_DATE
          , HCM.WITHHOLDING_AGENT
          , CASE
              WHEN P_PRINT_TYPE = '1' THEN EM.NAME 
              ELSE ''
            END AS RECEIVER_NAME 
          , P_PRINT_TYPE AS PRINT_TYPE 
          , NVL((SELECT '√' AS INCOME_68 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '68'                 
                ), '') AS INCOME_68
          , NVL((SELECT '√' AS INCOME_69 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '69'                 
                ), '') AS INCOME_69
          , NVL((SELECT '√' AS INCOME_63 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '63'                 
                ), '') AS INCOME_63
          , NVL((SELECT '√' AS INCOME_60 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '60'                 
                ), '') AS INCOME_60 
          , NVL((SELECT '√' AS INCOME_64 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '64'                 
                ), '') AS INCOME_64 
          , NVL((SELECT '√' AS INCOME_71 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '71'                 
                ), '') AS INCOME_71
          , NVL((SELECT '√' AS INCOME_72 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '72'                 
                ), '') AS INCOME_72
          , NVL((SELECT '√' AS INCOME_73 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                   AND RI.INCOME_CLASS_ETC = '73'                 
                ), '') AS INCOME_73
          , NVL((SELECT '√' AS INCOME_74 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '74'                 
                ), '') AS INCOME_74 
          , NVL((SELECT '√' AS INCOME_75 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '75'                 
                ), '') AS INCOME_75
          , NVL((SELECT '√' AS INCOME_76 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '76'                 
                ), '') AS INCOME_76 
          , NVL((SELECT '√' AS INCOME_62 
                   FROM HRW_RESIDENT_INCOME RI
                  WHERE RI.EARNER_ID        = EM.EARNER_ID
                    AND RI.SOB_ID           = EM.SOB_ID
                    AND RI.ORG_ID           = EM.ORG_ID
                    AND RI.INCOME_CLASS_ETC = '62'                 
                ), '') AS INCOME_62   
        FROM HRW_EARNER_MASTER EM
          , ( SELECT CM.CORP_ID
                  , CM.SOB_ID
                  , CM.ORG_ID
                  , CM.CORP_NAME
                  , CM.PRESIDENT_NAME
                  , CM.LEGAL_NUMBER
                  , HOU.VAT_NUMBER
                  , CM.ADDR1 || ' ' || CM.ADDR2 AS ADDRESS
                  , CM.CORP_NAME AS WITHHOLDING_AGENT
                  , HOU.TAX_OFFICE_NAME 
                FROM HRM_CORP_MASTER CM
                  , ( SELECT OU.CORP_ID
                           , OU.SOB_ID
                           , OU.ORG_ID
                           , OU.OPERATING_UNIT_NAME
                           , OU.VAT_NUMBER
                           , OU.TAX_OFFICE_NAME
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
          , ( SELECT HC.COMMON_ID AS NATION_ID
                  , HC.CODE_NAME AS NATION_NAME
                  , HC.VALUE1 AS NATION_ISO_CODE
                FROM HRM_COMMON HC
              WHERE HC.GROUP_CODE       = 'NATION'
                AND HC.SOB_ID           = P_SOB_ID
                AND HC.ORG_ID           = P_ORG_ID
            ) HC1  
      WHERE EM.CORP_ID                  = HCM.CORP_ID
        AND EM.SOB_ID                   = HCM.SOB_ID
        AND EM.ORG_ID                   = HCM.ORG_ID
        AND EM.NATION_ID                = HC1.NATION_ID(+)
        AND EM.EARNER_ID                = P_EARNER_ID
      ;
  END PRINT_RESIDENT_WH_ETC;


-- 소득자(기타사업소득) 원천징수영수증 인쇄 - 금액.
  PROCEDURE PRINT_RESIDENT_INCOME_ETC
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT IR.EARNER_ID
          , TO_CHAR(IR.PAY_DATE, 'YYYY') AS PAY_YEAR
          , TO_CHAR(IR.PAY_DATE, 'MM') AS PAY_MONTH
          , TO_CHAR(IR.PAY_DATE, 'DD') AS PAY_DAY
          , TO_CHAR(IR.RECEIPT_DATE, 'YYYY') AS RECEIPT_YEAR
          , TO_CHAR(IR.RECEIPT_DATE, 'MM') AS RECEIPT_MONTH
          , TO_CHAR(IR.RECEIPT_DATE, 'DD') AS RECEIPT_DAY
          , NVL(IR.PAYMENT_AMOUNT, 0) + NVL(IR.PAYMENT_ETC_AMOUNT, 0) AS TOT_PAYMENT_AMOUNT 
          , IR.EXP_AMOUNT
          , NVL(IR.INCOME_AMOUNT, 0) + NVL(IR.INCOME_ETC_AMOUNT, 0) AS TOT_INCOME_AMOUNT 
          , IR.TAX_RATE
          , IR.INCOME_TAX_AMT
          , IR.LOCAL_TAX_AMT
          , IR.SP_TAX_AMT 
          , NVL(IR.INCOME_TAX_AMT, 0) + NVL(IR.LOCAL_TAX_AMT, 0) + NVL(IR.SP_TAX_AMT, 0) AS TOTAL_DED_AMT
          , IR.REAL_AMT
        FROM HRW_RESIDENT_INCOME IR
      WHERE IR.EARNER_ID          = P_EARNER_ID
        AND IR.PAY_DATE           >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR')
        AND IR.PAY_DATE           <= ADD_MONTHS(TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR'), 12) - 1
        AND IR.SOB_ID             = P_SOB_ID
        AND IR.ORG_ID             = P_ORG_ID
        AND ROWNUM                <= 12
      ORDER BY IR.RECEIPT_DATE
      ;
  END PRINT_RESIDENT_INCOME_ETC;

---------------------------------------------------------------------------------------------------
-- 소득자(거주자기타소득)-지급현황.
  PROCEDURE RESIDENT_INCOME_ETC_LIST
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_CORP_ID           IN NUMBER
            , P_PAY_DATE_FR       IN DATE
            , P_PAY_DATE_TO       IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR 
      SELECT CASE
               WHEN GROUPING(CM.CORP_NAME) = 1 THEN PT_TOTAL_SUM
               WHEN GROUPING(EM.NAME) = 1 THEN PT_SUB_SUM
               ELSE CM.CORP_NAME
             END AS CORP_NAME
           , EM.EARNER_NUM
           , EM.NAME
           , EM.REPRE_NUM
           , NVL(RI.PAY_DATE, NULL) AS PAY_DATE
           , NVL(RI.RECEIPT_DATE, NULL) AS RECEIPT_DATE
           , SUM(RI.PAYMENT_AMOUNT) AS PAYMENT_AMOUNT
           , SUM(RI.PAYMENT_ETC_AMOUNT) AS PAYMENT_ETC_AMOUNT
           , SUM(NVL(RI.PAYMENT_AMOUNT, 0) + NVL(RI.PAYMENT_ETC_AMOUNT, 0)) AS TOT_PAYMENT_AMOUNT
           , RI.EXP_RATE
           , SUM(RI.EXP_AMOUNT) AS EXP_AMOUNT 
           , SUM(RI.INCOME_AMOUNT) AS INCOME_AMOUNT 
           , SUM(RI.INCOME_ETC_AMOUNT) AS INCOME_ETC_AMOUNT 
           , SUM(NVL(RI.INCOME_AMOUNT, 0) + NVL(RI.INCOME_ETC_AMOUNT, 0)) AS TOT_INCOME_AMOUNT
           , RI.TAX_RATE
           , SUM(RI.INCOME_TAX_AMT) AS INCOME_TAX_AMT 
           , SUM(RI.LOCAL_TAX_AMT) AS LOCAL_TAX_AMT 
           , SUM(RI.SP_TAX_AMT) AS SP_TAX_AMT 
           , SUM(NVL(RI.INCOME_TAX_AMT, 0) + NVL(RI.LOCAL_TAX_AMT, 0) + NVL(RI.SP_TAX_AMT, 0)) AS TOTAL_DED_AMT
           , SUM(RI.REAL_AMT) AS REAL_AMT 
        FROM HRW_EARNER_MASTER  EM
          , HRW_RESIDENT_INCOME RI
          , HRM_CORP_MASTER     CM
      WHERE EM.EARNER_ID            = RI.EARNER_ID
        AND EM.CORP_ID              = CM.CORP_ID
        AND EM.CORP_ID              = P_CORP_ID
        AND EM.EARNER_TYPE          = '15'  -- 거주자 기타소득 
        AND RI.PAY_DATE             BETWEEN P_PAY_DATE_FR AND P_PAY_DATE_TO
        AND EM.SOB_ID               = P_SOB_ID
        AND EM.ORG_ID               = P_ORG_ID
      GROUP BY ROLLUP(( CM.CORP_NAME)
           , (EM.EARNER_NUM
           , EM.NAME
           , EM.REPRE_NUM
           , RI.PAY_DATE
           , RI.RECEIPT_DATE
           , RI.EXP_RATE
           , RI.TAX_RATE
           ))
      ;
  END RESIDENT_INCOME_ETC_LIST;
                     
END HRW_RESIDENT_INCOME_G;
/
