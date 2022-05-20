CREATE OR REPLACE PACKAGE HRW_INCOME_RESIDENT_BSN_G
AS

-- 소득자조회(거주자사업소득).
  PROCEDURE SELECT_RESIDENT_BUSINESS
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN NUMBER
            , P_STD_YYYYMM        IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득)-소득지급내역 관리.
  PROCEDURE SELECT_INCOME_RESIDENT_BSN
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );

  PROCEDURE INSERT_INCOME_RESIDENT_BSN
            ( P_INCOME_ID      OUT HRW_INCOME_RESIDENT_BSN.INCOME_ID%TYPE
            , P_CORP_ID        IN HRW_INCOME_RESIDENT_BSN.CORP_ID%TYPE
            , P_SOB_ID         IN HRW_INCOME_RESIDENT_BSN.SOB_ID%TYPE
            , P_ORG_ID         IN HRW_INCOME_RESIDENT_BSN.ORG_ID%TYPE
            , P_EARNER_ID      IN HRW_INCOME_RESIDENT_BSN.EARNER_ID%TYPE
            , P_PAY_DATE       IN HRW_INCOME_RESIDENT_BSN.PAY_DATE%TYPE
            , P_RECEIPT_DATE   IN HRW_INCOME_RESIDENT_BSN.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT IN HRW_INCOME_RESIDENT_BSN.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE       IN HRW_INCOME_RESIDENT_BSN.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT IN HRW_INCOME_RESIDENT_BSN.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT  IN HRW_INCOME_RESIDENT_BSN.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT     IN HRW_INCOME_RESIDENT_BSN.SP_TAX_AMT%TYPE
            , P_REAL_AMT       IN HRW_INCOME_RESIDENT_BSN.REAL_AMT%TYPE
            , P_USER_ID        IN HRW_INCOME_RESIDENT_BSN.CREATED_BY%TYPE
            );

  PROCEDURE UPDATE_INCOME_RESIDENT_BSN
            ( W_INCOME_ID      IN HRW_INCOME_RESIDENT_BSN.INCOME_ID%TYPE
            , P_SOB_ID         IN HRW_INCOME_RESIDENT_BSN.SOB_ID%TYPE
            , P_ORG_ID         IN HRW_INCOME_RESIDENT_BSN.ORG_ID%TYPE
            , P_PAY_DATE       IN HRW_INCOME_RESIDENT_BSN.PAY_DATE%TYPE
            , P_RECEIPT_DATE   IN HRW_INCOME_RESIDENT_BSN.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT IN HRW_INCOME_RESIDENT_BSN.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE       IN HRW_INCOME_RESIDENT_BSN.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT IN HRW_INCOME_RESIDENT_BSN.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT  IN HRW_INCOME_RESIDENT_BSN.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT     IN HRW_INCOME_RESIDENT_BSN.SP_TAX_AMT%TYPE
            , P_REAL_AMT       IN HRW_INCOME_RESIDENT_BSN.REAL_AMT%TYPE
            , P_USER_ID        IN HRW_INCOME_RESIDENT_BSN.CREATED_BY%TYPE 
            );

  PROCEDURE DELETE_INCOME_RESIDENT_BSN
            ( W_INCOME_ID      IN HRW_INCOME_RESIDENT_BSN.INCOME_ID%TYPE
            , P_SOB_ID         IN HRW_INCOME_RESIDENT_BSN.SOB_ID%TYPE
            , P_ORG_ID         IN HRW_INCOME_RESIDENT_BSN.ORG_ID%TYPE
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
  PROCEDURE PRINT_INCOME_RESIDENT_L
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            );
            
---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득)-지급현황.
  PROCEDURE SELECT_IC_RESIDENT_BSN_LIST
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_CORP_ID           IN NUMBER
            , P_PAY_DATE_FR       IN DATE
            , P_PAY_DATE_TO       IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );
            
---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세율.
  PROCEDURE RESIDENT_BSN_TAX_RATE_P
            ( P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_TAX_RATE          OUT NUMBER
            );

---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세금계산(소득세,지방소득세, 농특세, 공제총액, 실지급액).
  PROCEDURE RESIDENT_BSN_TAX_AMT_P
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
                        
END HRW_INCOME_RESIDENT_BSN_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_INCOME_RESIDENT_BSN_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_INCOME_RESIDENT_BSN_G
/* DESCRIPTION  : 원천세 소득등록-거주사업소득자.
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
            , P_STD_YYYYMM        IN DATE
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
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
      ORDER BY EM.EARNER_NUM
      ;
  END SELECT_RESIDENT_BUSINESS;

---------------------------------------------------------------------------------------------------
-- 소득지급내역.
  PROCEDURE SELECT_INCOME_RESIDENT_BSN
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , P_STD_YYYYMM        IN VARCHAR2
            , P_EARNER_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT IR.INCOME_ID
          , IR.EARNER_ID
          , IR.PAY_DATE
          , IR.RECEIPT_DATE
          , IR.PAYMENT_AMOUNT
          , IR.TAX_RATE
          , IR.INCOME_TAX_AMT
          , IR.LOCAL_TAX_AMT
          , IR.SP_TAX_AMT
          , NVL(IR.INCOME_TAX_AMT, 0) + NVL(IR.LOCAL_TAX_AMT, 0) + NVL(IR.SP_TAX_AMT, 0) AS TOTAL_DED_AMT
          , IR.REAL_AMT
        FROM HRW_INCOME_RESIDENT_BSN IR
      WHERE IR.EARNER_ID          = P_EARNER_ID
        AND IR.PAY_DATE           >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH')
        AND IR.PAY_DATE           <= LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'))
        AND IR.SOB_ID             = P_SOB_ID
        AND IR.ORG_ID             = P_ORG_ID
      ;
  END SELECT_INCOME_RESIDENT_BSN;

  PROCEDURE INSERT_INCOME_RESIDENT_BSN
            ( P_INCOME_ID      OUT HRW_INCOME_RESIDENT_BSN.INCOME_ID%TYPE
            , P_CORP_ID        IN HRW_INCOME_RESIDENT_BSN.CORP_ID%TYPE
            , P_SOB_ID         IN HRW_INCOME_RESIDENT_BSN.SOB_ID%TYPE
            , P_ORG_ID         IN HRW_INCOME_RESIDENT_BSN.ORG_ID%TYPE
            , P_EARNER_ID      IN HRW_INCOME_RESIDENT_BSN.EARNER_ID%TYPE
            , P_PAY_DATE       IN HRW_INCOME_RESIDENT_BSN.PAY_DATE%TYPE
            , P_RECEIPT_DATE   IN HRW_INCOME_RESIDENT_BSN.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT IN HRW_INCOME_RESIDENT_BSN.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE       IN HRW_INCOME_RESIDENT_BSN.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT IN HRW_INCOME_RESIDENT_BSN.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT  IN HRW_INCOME_RESIDENT_BSN.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT     IN HRW_INCOME_RESIDENT_BSN.SP_TAX_AMT%TYPE
            , P_REAL_AMT       IN HRW_INCOME_RESIDENT_BSN.REAL_AMT%TYPE
            , P_USER_ID        IN HRW_INCOME_RESIDENT_BSN.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    SELECT HRW_INCOME_RESIDENT_BSN_S1.NEXTVAL
      INTO P_INCOME_ID
      FROM DUAL;

    INSERT INTO HRW_INCOME_RESIDENT_BSN
    ( INCOME_ID
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
    ( P_INCOME_ID
    , P_CORP_ID
    , P_SOB_ID
    , P_ORG_ID
    , P_EARNER_ID
    , P_PAY_DATE
    , P_RECEIPT_DATE
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
  END INSERT_INCOME_RESIDENT_BSN;

  PROCEDURE UPDATE_INCOME_RESIDENT_BSN
            ( W_INCOME_ID      IN HRW_INCOME_RESIDENT_BSN.INCOME_ID%TYPE
            , P_SOB_ID         IN HRW_INCOME_RESIDENT_BSN.SOB_ID%TYPE
            , P_ORG_ID         IN HRW_INCOME_RESIDENT_BSN.ORG_ID%TYPE
            , P_PAY_DATE       IN HRW_INCOME_RESIDENT_BSN.PAY_DATE%TYPE
            , P_RECEIPT_DATE   IN HRW_INCOME_RESIDENT_BSN.RECEIPT_DATE%TYPE
            , P_PAYMENT_AMOUNT IN HRW_INCOME_RESIDENT_BSN.PAYMENT_AMOUNT%TYPE
            , P_TAX_RATE       IN HRW_INCOME_RESIDENT_BSN.TAX_RATE%TYPE
            , P_INCOME_TAX_AMT IN HRW_INCOME_RESIDENT_BSN.INCOME_TAX_AMT%TYPE
            , P_LOCAL_TAX_AMT  IN HRW_INCOME_RESIDENT_BSN.LOCAL_TAX_AMT%TYPE
            , P_SP_TAX_AMT     IN HRW_INCOME_RESIDENT_BSN.SP_TAX_AMT%TYPE
            , P_REAL_AMT       IN HRW_INCOME_RESIDENT_BSN.REAL_AMT%TYPE
            , P_USER_ID        IN HRW_INCOME_RESIDENT_BSN.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    UPDATE HRW_INCOME_RESIDENT_BSN
    SET PAY_DATE         = P_PAY_DATE
      , RECEIPT_DATE     = P_RECEIPT_DATE
      , PAYMENT_AMOUNT   = NVL(P_PAYMENT_AMOUNT, 0)
      , TAX_RATE         = NVL(P_TAX_RATE, 0)
      , INCOME_TAX_AMT   = NVL(P_INCOME_TAX_AMT, 0)
      , LOCAL_TAX_AMT    = NVL(P_LOCAL_TAX_AMT, 0)
      , SP_TAX_AMT       = NVL(P_SP_TAX_AMT, 0)
      , REAL_AMT         = NVL(P_REAL_AMT, 0)
      , LAST_UPDATE_DATE = V_SYSDATE
      , LAST_UPDATED_BY  = P_USER_ID
  WHERE INCOME_ID        = W_INCOME_ID
    ;
  END UPDATE_INCOME_RESIDENT_BSN;

  PROCEDURE DELETE_INCOME_RESIDENT_BSN
            ( W_INCOME_ID      IN HRW_INCOME_RESIDENT_BSN.INCOME_ID%TYPE
            , P_SOB_ID         IN HRW_INCOME_RESIDENT_BSN.SOB_ID%TYPE
            , P_ORG_ID         IN HRW_INCOME_RESIDENT_BSN.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRW_INCOME_RESIDENT_BSN
    WHERE INCOME_ID        = W_INCOME_ID
    ;
  END DELETE_INCOME_RESIDENT_BSN;

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
  PROCEDURE PRINT_INCOME_RESIDENT_L
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
        FROM HRW_INCOME_RESIDENT_BSN IR
      WHERE IR.EARNER_ID          = P_EARNER_ID
        AND IR.PAY_DATE           >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR')
        AND IR.PAY_DATE           <= ADD_MONTHS(TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR'), 12) - 1
        AND IR.SOB_ID             = P_SOB_ID
        AND IR.ORG_ID             = P_ORG_ID
        AND ROWNUM                <= 12
      ORDER BY IR.RECEIPT_DATE
      ;
  END PRINT_INCOME_RESIDENT_L;
  
---------------------------------------------------------------------------------------------------
-- 소득자(거주자사업소득)-지급현황.
  PROCEDURE SELECT_IC_RESIDENT_BSN_LIST
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
          , HRW_INCOME_RESIDENT_BSN ISB
          , HRM_CORP_MASTER CM
      WHERE EM.EARNER_ID            = ISB.EARNER_ID
        AND EM.CORP_ID              = CM.CORP_ID
        AND EM.CORP_ID              = P_CORP_ID
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
  END SELECT_IC_RESIDENT_BSN_LIST;
  
---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세율.
  PROCEDURE RESIDENT_BSN_TAX_RATE_P
            ( P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_TAX_RATE          OUT NUMBER
            )
  AS
  BEGIN
    O_TAX_RATE := 3;  
  END RESIDENT_BSN_TAX_RATE_P;

---------------------------------------------------------------------------------------------------
-- 거주자사업소득 세금계산(소득세,지방소득세, 농특세, 공제총액, 실지급액).
  PROCEDURE RESIDENT_BSN_TAX_AMT_P
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
    RESIDENT_BSN_TAX_RATE_P(P_SOB_ID, P_ORG_ID, O_TAX_RATE);
    
    -- 소득세.
    O_INCOME_TAX_AMT := TRUNC(NVL(P_PAYMENT_AMOUNT, 0) * (O_TAX_RATE / 100));
    O_LOCAL_TAX_AMT := TRUNC(NVL(O_INCOME_TAX_AMT, 0) * ( 10  / 100));
    O_SP_TAX_AMT := NULL;
    O_TOTAL_DED_AMT := NVL(O_INCOME_TAX_AMT, 0) + NVL(O_LOCAL_TAX_AMT, 0);
    O_REAL_AMT := NVL(P_PAYMENT_AMOUNT, 0) - NVL(O_TOTAL_DED_AMT, 0);
    IF O_REAL_AMT < 0 THEN
      O_REAL_AMT := 0;
    END IF;
  END RESIDENT_BSN_TAX_AMT_P;
  
END HRW_INCOME_RESIDENT_BSN_G;
/
