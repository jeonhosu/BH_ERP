CREATE OR REPLACE PACKAGE FI_VAT_CREDITCARD_G
AS

-- VAT (매입) 신용카드수취명세서 조회.
  PROCEDURE SELECT_CREDITCARD_1
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , W_CREDITCARD_CODE   IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            );

-- VAT (매출) 신용카드수취명세서 조회.
  PROCEDURE SELECT_CREDITCARD_2
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , W_CREDITCARD_CODE   IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            );

-- VAT (매입/매출) 신용카드수취명세서 수정.
  PROCEDURE UPDATE_CREDITCARD
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            , P_VAT_ISSUE_DATE        IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , P_CUSTOMER_ID           IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , P_GL_AMOUNT             IN FI_VAT_MASTER.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT            IN FI_VAT_MASTER.VAT_AMOUNT%TYPE
            , P_CREDITCARD_CODE       IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            , P_USER_ID               IN FI_VAT_MASTER.CREATED_BY%TYPE 
            );

-----------------------------------------------------------------------------------------
-- VAT (매입) 신용카드수취명세서 인쇄.
  PROCEDURE PRINT_CREDITCARD_1
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , W_CREDITCARD_CODE   IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            );
            
END FI_VAT_CREDITCARD_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_CREDITCARD_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_CREDITCARD_G
/* Description  : 부가세 조회-신용카드수취명세서 조회.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT (매입) 신용카드수취명세서 조회.
  PROCEDURE SELECT_CREDITCARD_1
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , W_CREDITCARD_CODE   IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
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
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, TO_DATE(NULL), VM.VAT_ISSUE_DATE) AS VAT_ISSUE_DATE
           , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
           , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
           , CC.CARD_NUM AS CREDITCARD_NUM
           , VM.CREDITCARD_CODE
           , HRM_PERSON_MASTER_G.NAME_F(CC.USE_PERSON_ID) AS USE_PERSON_NAME
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.CUSTOMER_ID)) AS CUSTOMER_ID
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.VAT_ID)) AS VAT_ID
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.SLIP_HEADER_ID)) AS SLIP_HEADER_ID
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
          , FI_CREDIT_CARD CC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.CREDITCARD_CODE          = CC.CARD_CODE(+)
        AND VM.SOB_ID                   = CC.SOB_ID(+)
        AND VM.VAT_GUBUN                = '1'         -- 매입.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
        AND VM.CREDITCARD_CODE          = NVL(W_CREDITCARD_CODE, VM.CREDITCARD_CODE)
        AND VM.VAT_TYPE                 = '3'
      GROUP BY ROLLUP
           ((VM.VAT_ISSUE_DATE
           , SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , VM.CUSTOMER_ID
           , SC.TAX_REG_NO
           , CC.CARD_NUM
           , HRM_PERSON_MASTER_G.NAME_F(CC.USE_PERSON_ID)
           , VM.CREDITCARD_CODE
           , VM.VAT_ID
           , VM.SLIP_HEADER_ID))
      ORDER BY SC.TAX_REG_NO, VM.VAT_ISSUE_DATE
      ;
  END SELECT_CREDITCARD_1;

-- VAT (매출) 계산서 합계표 조회.
  PROCEDURE SELECT_CREDITCARD_2
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , W_CREDITCARD_CODE   IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SC.SUPP_CUST_CODE AS CUSTOMER_CODE
           , CASE
               WHEN GROUPING(VM.CUSTOMER_ID) = 1 THEN '[' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL) || ']'   --총합계
               ELSE SC.SUPP_CUST_NAME
             END AS CUSTOMER_DESC
           , SC.TAX_REG_NO
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, TO_DATE(NULL), VM.VAT_ISSUE_DATE) AS VAT_ISSUE_DATE
           , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
           , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
           , CC.CARD_NUM AS CREDITCARD_NUM
           , VM.CREDITCARD_CODE
           , HRM_PERSON_MASTER_G.NAME_F(CC.USE_PERSON_ID) AS USE_PERSON_NAME
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.CUSTOMER_ID)) AS CUSTOMER_ID
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.VAT_ID)) AS VAT_ID
           , DECODE(GROUPING(VM.CUSTOMER_ID), 1, 0, MAX(VM.SLIP_HEADER_ID)) AS SLIP_HEADER_ID
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
          , FI_CREDIT_CARD CC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.CREDITCARD_CODE          = CC.CARD_CODE(+)
        AND VM.SOB_ID                   = CC.SOB_ID(+)
        AND VM.VAT_GUBUN                = '2'         -- 매입.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
        AND VM.CREDITCARD_CODE          = NVL(W_CREDITCARD_CODE, VM.CREDITCARD_CODE)
        AND VM.VAT_TYPE                 = '3'
      GROUP BY ROLLUP
           ((SC.TAX_REG_NO
           , VM.VAT_ISSUE_DATE
           , SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , VM.CUSTOMER_ID
           , CC.CARD_NUM
           , HRM_PERSON_MASTER_G.NAME_F(CC.USE_PERSON_ID)
           , VM.CREDITCARD_CODE
           , VM.VAT_ID
           , VM.SLIP_HEADER_ID))
      ORDER BY SC.TAX_REG_NO, VM.VAT_ISSUE_DATE
      ;
  END SELECT_CREDITCARD_2;

-- VAT (매입/매출) 신용카드수취명세서 수정.
  PROCEDURE UPDATE_CREDITCARD
            ( W_VAT_ID                IN FI_VAT_MASTER.VAT_ID%TYPE
            , W_SOB_ID                IN FI_VAT_MASTER.SOB_ID%TYPE
            , P_VAT_ISSUE_DATE        IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , P_CUSTOMER_ID           IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , P_GL_AMOUNT             IN FI_VAT_MASTER.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT            IN FI_VAT_MASTER.VAT_AMOUNT%TYPE
            , P_CREDITCARD_CODE       IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            , P_USER_ID               IN FI_VAT_MASTER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    RETURN;
    IF FI_VAT_MASTER_G.VAT_CLOSED_YN(W_VAT_ID, W_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This VAT Data(해당 부가세)'));
    END IF;
    
    UPDATE FI_VAT_MASTER
      SET VAT_ISSUE_DATE        = P_VAT_ISSUE_DATE
        , CUSTOMER_ID           = P_CUSTOMER_ID
        , GL_AMOUNT             = P_GL_AMOUNT
        , VAT_AMOUNT            = P_VAT_AMOUNT
        , CREDITCARD_CODE       = P_CREDITCARD_CODE
        , LAST_UPDATE_DATE      = V_SYSDATE
        , LAST_UPDATED_BY       = P_USER_ID
    WHERE VAT_ID                = W_VAT_ID;
  
  END UPDATE_CREDITCARD;

-----------------------------------------------------------------------------------------
-- VAT (매입) 신용카드수취명세서 인쇄.
  PROCEDURE PRINT_CREDITCARD_1
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_CUSTOMER_ID       IN FI_VAT_MASTER.CUSTOMER_ID%TYPE
            , W_CREDITCARD_CODE   IN FI_VAT_MASTER.CREDITCARD_CODE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SC.SUPP_CUST_CODE AS CUSTOMER_CODE
           , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
           , SC.TAX_REG_NO
           , VM.VAT_ISSUE_DATE AS VAT_ISSUE_DATE
           , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
           , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
           , SUM(VM.VAT_COUNT) AS VAT_COUNT
           , CC.CARD_NUM AS CREDITCARD_NUM
           , VM.CREDITCARD_CODE
        FROM FI_VAT_MASTER VM
          , FI_SUPP_CUST_V SC
          , FI_CREDIT_CARD CC
      WHERE VM.CUSTOMER_ID              = SC.SUPP_CUST_ID
        AND VM.SOB_ID                   = SC.SOB_ID
        AND VM.CREDITCARD_CODE          = CC.CARD_CODE(+)
        AND VM.SOB_ID                   = CC.SOB_ID(+)
        AND VM.VAT_GUBUN                = '1'         -- 매입.
        AND VM.TAX_CODE                 = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE           BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.SOB_ID                   = W_SOB_ID
        AND VM.CUSTOMER_ID              = NVL(W_CUSTOMER_ID, VM.CUSTOMER_ID)
        AND VM.CREDITCARD_CODE          = NVL(W_CREDITCARD_CODE, VM.CREDITCARD_CODE)
        AND VM.VAT_TYPE                 = '3'
      GROUP BY VM.VAT_ISSUE_DATE
           , SC.SUPP_CUST_CODE
           , SC.SUPP_CUST_NAME
           , VM.CUSTOMER_ID
           , SC.TAX_REG_NO
           , CC.CARD_NUM
           , VM.CREDITCARD_CODE
      ORDER BY SC.TAX_REG_NO, VM.VAT_ISSUE_DATE
      ;
  END PRINT_CREDITCARD_1;
  
END FI_VAT_CREDITCARD_G;
/
