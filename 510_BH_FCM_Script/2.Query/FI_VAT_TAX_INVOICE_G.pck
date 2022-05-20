CREATE OR REPLACE PACKAGE FI_VAT_TAX_INVOICE_G
AS

-- VAT (매입) 세금계산서 합계표 조회.
  PROCEDURE SELECT_TAX_INVOICE_1
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );

-- VAT (매출) 세금계산서 합계표 조회.
  PROCEDURE SELECT_TAX_INVOICE_2
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );

-- VAT (매입/매출) 세금계산서 합계표 상세 조회.
  PROCEDURE SELECT_TAX_INVOICE_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_VAT_GUBUN         IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );


-----------------------------------------------------------------------------------------
-- 인쇄 : VAT (매입) 세금계산서 합계표 총합계.
  PROCEDURE PRINT_TAX_INVOICE_1_SUM
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );
            
-- 인쇄 : VAT (매입) 세금계산서 합계표 내역.
  PROCEDURE PRINT_TAX_INVOICE_1_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );
            
-----------------------------------------------------------------------------------------
-- 인쇄 : VAT (매출) 세금계산서 합계표 총합계.
  PROCEDURE PRINT_TAX_INVOICE_2_SUM
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );
            
-- 인쇄 : VAT (매출) 세금계산서 합계표 내역.
  PROCEDURE PRINT_TAX_INVOICE_2_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            );
            
END FI_VAT_TAX_INVOICE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_TAX_INVOICE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_TAX_INVOICE_G
/* Description  : 부가세 조회-세금계산서 합계표 조회.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT (매입) 세금계산서 합계표 조회.
  PROCEDURE SELECT_TAX_INVOICE_1
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SC.SUPP_CUST_CODE AS CUSTOMER_CODE
           , CASE
               WHEN GROUPING(VM.CUSTOMER_ID) = 1 THEN '[' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) || ']'   --총합계
               ELSE SC.SUPP_CUST_NAME 
             END AS CUSTOMER_DESC
           , SC.TAX_REG_NO
           , FI_COMMON_G.CODE_NAME_F('BUSINESS_TYPE', SC.BUSINESS_TYPE_S, SC.SOB_ID) AS BUSINESS_TYPE_DESC
           , SC.PRESIDENT_NAME
           , SUM(VM.VAT_COUNT) AS VAT_COUNT
           , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
           , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
           , VM.TAX_CODE
           , VM.VAT_GUBUN
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.CUSTOMER_ID)) AS CUSTOMER_ID
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.VAT_GUBUN                = '1'         -- 매입.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
        AND NOT EXISTS 
              ( SELECT 'X'
                  FROM FI_VAT_TYPE_V VT
                WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                  AND VT.SOB_ID     = VM.SOB_ID
                  AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
              )
      GROUP BY ROLLUP
           ((SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , VM.CUSTOMER_ID
           , SC.TAX_REG_NO
           , FI_COMMON_G.CODE_NAME_F('BUSINESS_TYPE', SC.BUSINESS_TYPE_S, SC.SOB_ID)
           , SC.PRESIDENT_NAME
           , VM.TAX_CODE
           , VM.VAT_GUBUN))
      ORDER BY SC.TAX_REG_NO
      ;
  END SELECT_TAX_INVOICE_1;

-- VAT (매출) 세금계산서 합계표 조회.
  PROCEDURE SELECT_TAX_INVOICE_2
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SC.SUPP_CUST_CODE AS CUSTOMER_CODE
           , CASE
               WHEN GROUPING(VM.CUSTOMER_ID) = 1 THEN '[' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) || ']'   --총합계
               ELSE SC.SUPP_CUST_NAME 
             END AS CUSTOMER_DESC
           , SC.TAX_REG_NO
           , FI_COMMON_G.CODE_NAME_F('BUSINESS_TYPE', SC.BUSINESS_TYPE_S, SC.SOB_ID) AS BUSINESS_TYPE_DESC
           , SC.PRESIDENT_NAME
           , SUM(VM.VAT_COUNT) AS VAT_COUNT
           , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
           , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
           , VM.TAX_CODE
           , VM.VAT_GUBUN
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.CUSTOMER_ID)) AS CUSTOMER_ID
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.VAT_GUBUN                = '2'         -- 매출.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
        AND NOT EXISTS 
              ( SELECT 'X'
                  FROM FI_VAT_TYPE_V VT
                WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                  AND VT.SOB_ID     = VM.SOB_ID
                  AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- 계산서/직수출/신용카드 제외.
              )
      GROUP BY ROLLUP
           ((SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , VM.CUSTOMER_ID
           , SC.TAX_REG_NO
           , FI_COMMON_G.CODE_NAME_F('BUSINESS_TYPE', SC.BUSINESS_TYPE_S, SC.SOB_ID)
           , SC.PRESIDENT_NAME
           , VM.TAX_CODE
           , VM.VAT_GUBUN))
      ORDER BY SC.TAX_REG_NO
      ;
  END SELECT_TAX_INVOICE_2;

-- VAT (매입/매출) 세금계산서 합계표 상세 조회.
  PROCEDURE SELECT_TAX_INVOICE_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_VAT_GUBUN         IN FI_VAT_MASTER.VAT_GUBUN%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SC.SUPP_CUST_CODE AS CUSTOMER_CODE
          , SC.SUPP_CUST_NAME AS CUSTOMER_NAME
          , VM.VAT_ISSUE_DATE AS VAT_ISSUE_DATE
          , FI_COMMON_G.CODE_NAME_F('VAT_TYPE', VM.VAT_TYPE, VM.SOB_ID) AS VAT_TYPE_DESC   ----세무유형
          , VM.GL_AMOUNT AS GL_AMOUNT
          , VM.VAT_AMOUNT AS VAT_AMOUNT
          , VM.VAT_COUNT
          , VM.REMARK AS REMARK          
          , NVL(VM.TAX_ELECTRO_YN, 'N') AS TAX_ELECTRO_YN
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC     --거래처[ S(SUPP) : 매입처, C(CUST) : 매출처 ]
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.VAT_GUBUN                = W_VAT_GUBUN
        AND VM.CUSTOMER_ID              = W_CUSTOMER_ID
        AND NOT EXISTS 
              ( SELECT 'X'
                  FROM FI_VAT_TYPE_V VT
                WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                  AND VT.SOB_ID     = VM.SOB_ID
                  AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
              )
      ORDER BY VM.VAT_ISSUE_DATE, VM.SLIP_LINE_ID
      ;
  END SELECT_TAX_INVOICE_DETAIL;


-----------------------------------------------------------------------------------------
-- 인쇄 : VAT (매입) 세금계산서 합계표 총합계.
  PROCEDURE PRINT_TAX_INVOICE_1_SUM
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.LINE_TYPE
           , SX1.CUSTOMER_COUNT
           , SX1.VAT_COUNT
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS GL_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS GL_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS GL_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS GL_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS GL_AMOUNT_1
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS VAT_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS VAT_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS VAT_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS VAT_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS VAT_AMOUNT_1
           , SX1.GL_AMOUNT
           , SX1.VAT_AMOUNT
        FROM (SELECT CASE
                         WHEN GROUPING(VM.TAX_ELECTRO_YN) = 1 THEN 'TS'
                         WHEN GROUPING(DECODE(SC.BUSINESS_TYPE_S, NULL, VM.BUSINESS_TYPE, 'C')) = 1 THEN VM.TAX_ELECTRO_YN || 'S'
                         ELSE VM.TAX_ELECTRO_YN || DECODE(SC.BUSINESS_TYPE_S, NULL, VM.BUSINESS_TYPE, 'C') 
                       END LINE_TYPE
                   , COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
                   , SUM(VM.VAT_COUNT) AS VAT_COUNT
                   , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                   , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_MASTER VM
                  , FI_SUPP_CUST_V SC
              WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                AND VM.SOB_ID                   = SC.SOB_ID(+)
                AND VM.VAT_GUBUN                = '1'         -- 매입.
                AND VM.TAX_CODE                 = W_TAX_CODE
                AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                AND VM.SOB_ID                   = W_SOB_ID
                AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM FI_VAT_TYPE_V VT
                        WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                          AND VT.SOB_ID     = VM.SOB_ID
                          AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
                      )
              GROUP BY ROLLUP ((VM.TAX_ELECTRO_YN)
                   , (DECODE(SC.BUSINESS_TYPE_S, NULL, VM.BUSINESS_TYPE, 'C')))
             ) SX1
      ;
  END PRINT_TAX_INVOICE_1_SUM;
  
-- 인쇄 : VAT (매입) 세금계산서 합계표 내역.
  PROCEDURE PRINT_TAX_INVOICE_1_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.TAX_REG_NO
           , SX1.CUSTOMER_DESC
           , SX1.VAT_COUNT
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS GL_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS GL_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS GL_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS GL_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS GL_AMOUNT_1
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS VAT_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS VAT_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS VAT_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS VAT_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS VAT_AMOUNT_1
           , SX1.GL_AMOUNT
           , SX1.VAT_AMOUNT
        FROM (SELECT SC.TAX_REG_NO
                   , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
                   , SC.SUPP_CUST_CODE AS CUSTOMER_CODE
                   , SUM(VM.VAT_COUNT) AS VAT_COUNT
                   , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                   , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_MASTER VM
                  , FI_SUPP_CUST_V SC
              WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
                AND VM.SOB_ID                   = SC.SOB_ID
                AND VM.VAT_GUBUN                = '1'         -- 매입.
                AND VM.TAX_CODE                 = W_TAX_CODE
                AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                AND VM.SOB_ID                   = W_SOB_ID
                AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
                AND VM.TAX_ELECTRO_YN           = 'N'
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM FI_VAT_TYPE_V VT
                        WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                          AND VT.SOB_ID     = VM.SOB_ID
                          AND VT.VAT_TYPE   IN ('5', '9', '3')  -- 계산서/직수출/신용카드 제외.
                      )
              GROUP BY SC.SUPP_CUST_NAME
                   , SC.SUPP_CUST_CODE
                   , SC.TAX_REG_NO
              ORDER BY SUPP_CUST_CODE
             ) SX1
      ORDER BY SX1.TAX_REG_NO
      ;
  END PRINT_TAX_INVOICE_1_DETAIL;

-----------------------------------------------------------------------------------------
-- 인쇄 : VAT (매출) 세금계산서 합계표 총합계.
  PROCEDURE PRINT_TAX_INVOICE_2_SUM
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.LINE_TYPE
           , SX1.CUSTOMER_COUNT
           , SX1.VAT_COUNT
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS GL_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS GL_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS GL_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS GL_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS GL_AMOUNT_1
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS VAT_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS VAT_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS VAT_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS VAT_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS VAT_AMOUNT_1
           , SX1.GL_AMOUNT
           , SX1.VAT_AMOUNT
        FROM (SELECT CASE
                         WHEN GROUPING(VM.TAX_ELECTRO_YN) = 1 THEN 'TS'
                         WHEN GROUPING(DECODE(SC.BUSINESS_TYPE_S, NULL, VM.BUSINESS_TYPE, 'C')) = 1 THEN VM.TAX_ELECTRO_YN || 'S'
                         ELSE VM.TAX_ELECTRO_YN || DECODE(SC.BUSINESS_TYPE_S, NULL, VM.BUSINESS_TYPE, 'C')
                       END LINE_TYPE
                   , COUNT(DISTINCT SC.TAX_REG_NO) AS CUSTOMER_COUNT
                   , SUM(VM.VAT_COUNT) AS VAT_COUNT
                   , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                   , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_MASTER VM
                  , FI_SUPP_CUST_V SC
              WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID(+)
                AND VM.SOB_ID                   = SC.SOB_ID(+)
                AND VM.VAT_GUBUN                = '2'         -- 매출.
                AND VM.TAX_CODE                 = W_TAX_CODE
                AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                AND VM.SOB_ID                   = W_SOB_ID
                AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM FI_VAT_TYPE_V VT
                        WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                          AND VT.SOB_ID     = VM.SOB_ID
                          AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- 계산서/직수출/신용카드 제외.
                      )
              GROUP BY ROLLUP ((VM.TAX_ELECTRO_YN)
                   , (DECODE(SC.BUSINESS_TYPE_S, NULL, VM.BUSINESS_TYPE, 'C')))
             ) SX1
      ;
  END PRINT_TAX_INVOICE_2_SUM;
  
-- 인쇄 : VAT (매출) 세금계산서 합계표 내역.
  PROCEDURE PRINT_TAX_INVOICE_2_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SX1.TAX_REG_NO
           , SX1.CUSTOMER_DESC
           , SX1.VAT_COUNT           
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -15, 3), '*', '') AS GL_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -12, 3), '*', '') AS GL_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -9, 3), '*', '') AS GL_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -6, 3), '*', '') AS GL_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.GL_AMOUNT, 15, '*'), -3, 3), '*', '') AS GL_AMOUNT_1
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -15, 3), '*', '') AS VAT_AMOUNT_5
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -12, 3), '*', '') AS VAT_AMOUNT_4
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -9, 3), '*', '') AS VAT_AMOUNT_3
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -6, 3), '*', '') AS VAT_AMOUNT_2
           , REPLACE(SUBSTR(LPAD(SX1.VAT_AMOUNT, 15, '*'), -3, 3), '*', '') AS VAT_AMOUNT_1
           , SX1.GL_AMOUNT
           , SX1.VAT_AMOUNT
        FROM (SELECT SC.TAX_REG_NO
                   , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
                   , SC.SUPP_CUST_CODE AS CUSTOMER_CODE
                   , SUM(VM.VAT_COUNT) AS VAT_COUNT
                   , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                   , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_MASTER VM
                  , FI_SUPP_CUST_V SC
              WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
                AND VM.SOB_ID                   = SC.SOB_ID
                AND VM.VAT_GUBUN                = '2'         -- 매입.
                AND VM.TAX_CODE                 = W_TAX_CODE
                AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                AND VM.SOB_ID                   = W_SOB_ID
                AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
                AND VM.TAX_ELECTRO_YN           = 'N'
                AND NOT EXISTS 
                      ( SELECT 'X'
                          FROM FI_VAT_TYPE_V VT
                        WHERE VT.VAT_TYPE   = VM.VAT_TYPE
                          AND VT.SOB_ID     = VM.SOB_ID
                          AND VT.VAT_TYPE   IN ('5', '9', '3', '17')  -- 계산서/직수출/신용카드 제외.
                      )
              GROUP BY SC.SUPP_CUST_NAME
                   , SC.SUPP_CUST_CODE
                   , SC.TAX_REG_NO
              ORDER BY SUPP_CUST_CODE
             ) SX1
      ORDER BY SX1.TAX_REG_NO
      ;
  END PRINT_TAX_INVOICE_2_DETAIL;
  
END FI_VAT_TAX_INVOICE_G;
/
