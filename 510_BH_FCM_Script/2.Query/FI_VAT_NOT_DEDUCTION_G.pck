CREATE OR REPLACE PACKAGE FI_VAT_NOT_DEDUCTION_G
AS

-- VAT 공제받지못할매입세액 조회.
  PROCEDURE SELECT_NOT_DEDUCTION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            );

-- VAT 공제받지못할매입세액 상세명세서 조회.
  PROCEDURE SELECT_NOT_DEDUCTION_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            );

---------------------------------------------------------------------------------------------------
-- VAT 감가상각취득명세서 생성.
  PROCEDURE SET_DPR_ASSET
            ( W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , P_USER_ID           IN FI_VAT_DPR_ASSET.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 마감여부 체크.
  FUNCTION CLOSED_YN_F
            ( W_DPR_ASSET_ID      IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_VAT_NOT_DEDUCTION_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_NOT_DEDUCTION_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_NOT_DEDUCTION_G
/* Description  : 부가세 조회-공제받지못할매입세액명세서 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 공제받지못할매입세액 조회.
  PROCEDURE SELECT_NOT_DEDUCTION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN GROUPING(VND.NOT_DED_CODE) = 1 THEN '0'
               ELSE VND.NOT_DED_CODE
             END NOT_DED_CODE
           , CASE
               WHEN GROUPING(VND.NOT_DED_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10062', NULL)
               ELSE VND.NOT_DED_DESC
             END AS NOT_DED_DESC
           , SUM(S_VM.VAT_COUNT) AS VAT_COUNT
           , SUM(S_VM.GL_AMOUNT) AS GL_AMOUNT
           , SUM(S_VM.VAT_AMOUNT) AS VAT_AMOUNT
        FROM FI_VAT_NOT_DEDUCTION_V VND
          , (-- 매입세액불공제내역.
             SELECT VM.SOB_ID
                  , VM.INPUT_DED_NOT_CODE
                  , SUM(VM.VAT_COUNT) AS VAT_COUNT
                  , SUM(VM.GL_AMOUNT) AS GL_AMOUNT
                  , SUM(VM.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_MASTER VM
               WHERE VM.TAX_CODE           = W_TAX_CODE
                 AND VM.VAT_ISSUE_DATE     BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                 AND VM.VAT_TYPE           IN('8', '15')    -- 매입세액불공제.
                 AND VM.SOB_ID             = W_SOB_ID
             GROUP BY VM.SOB_ID
                  , VM.INPUT_DED_NOT_CODE
            ) S_VM
      WHERE VND.NOT_DED_CODE      = S_VM.INPUT_DED_NOT_CODE(+)
        AND VND.SOB_ID            = S_VM.SOB_ID(+)
        AND VND.SOB_ID            = W_SOB_ID
      GROUP BY ROLLUP((VND.NOT_DED_CODE
           , VND.NOT_DED_DESC))
      ORDER BY NOT_DED_CODE
      ;
  END SELECT_NOT_DEDUCTION;

-- VAT 공제받지못할매입세액 상세명세서 조회.
  PROCEDURE SELECT_NOT_DEDUCTION_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_MASTER.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_MASTER.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_MASTER.VAT_ISSUE_DATE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT VM.TAX_CODE
          , VM.VAT_ISSUE_DATE 
          , VND.NOT_DED_DESC
          , VM.INPUT_DED_NOT_CODE
          , VM.GL_AMOUNT AS GL_AMOUNT
          , VM.VAT_AMOUNT AS VAT_AMOUNT
          , VM.REMARK
          , VM.VAT_ID
        FROM FI_VAT_MASTER VM
          , FI_VAT_NOT_DEDUCTION_V VND
      WHERE VM.INPUT_DED_NOT_CODE = VND.NOT_DED_CODE(+)
        AND VM.SOB_ID             = VND.SOB_ID(+)
        AND VM.TAX_CODE           = W_TAX_CODE
        AND VM.VAT_ISSUE_DATE     BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VM.VAT_TYPE           IN('8', '15')    -- 매입세액불공제.
        AND VM.SOB_ID             = W_SOB_ID
      ORDER BY VM.TAX_CODE, VM.VAT_ISSUE_DATE
      ;
  END SELECT_NOT_DEDUCTION_DETAIL;

---------------------------------------------------------------------------------------------------
-- VAT 감가상각취득명세서 생성.
  PROCEDURE SET_DPR_ASSET
            ( W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , P_USER_ID           IN FI_VAT_DPR_ASSET.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_DPR_ASSET_ID      FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE;
  BEGIN
    FOR C1 IN ( SELECT SH.GL_DATE AS ACQUIRE_DATE
                     , SL.ACCOUNT_CONTROL_ID
                     , VA.VAT_ASSET_GB
                     , S_SMI.CUSTOMER_CODE
                     , SC.SUPP_CUST_ID AS CUSTOMER_ID
                     , SL.GL_AMOUNT
                     , TRUNC(NVL(SL.GL_AMOUNT, 0) * 0.1) AS VAT_AMOUNT
                     , SL.CURRENCY_CODE AS CURRENCY_CODE
                     , SL.EXCHANGE_RATE AS EXCHANGE_RATE
                     , SL.GL_CURRENCY_AMOUNT AS GL_CURR_AMOUNT
                     , SL.REMARK
                     , VA.SOB_ID
                     , SL.ORG_ID
                     , 'I' AS CREATED_TYPE
                     , 'SLIP' AS SOURCE_TABLE
                     , SL.SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID
                     , SL.GL_NUM
                  FROM FI_VAT_ACCOUNTS VA
                    , FI_ACCOUNT_CONTROL AC
                    , FI_SLIP_LINE SL
                    , FI_SLIP_HEADER SH
                    , (-- 전표 정보.
                      SELECT SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'CUSTOMER', SMI.MANAGEMENT_VALUE)) AS CUSTOMER_CODE
                        FROM FI_SLIP_MANAGEMENT_ITEM SMI
                          , FI_MANAGEMENT_CODE_V MC
                      WHERE SMI.MANAGEMENT_ID           = MC.MANAGEMENT_ID
                        AND SMI.SOB_ID                  = MC.SOB_ID
                        AND SMI.SOB_ID                  = W_SOB_ID
                      GROUP BY SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                      ) S_SMI
                    , FI_SUPP_CUST_V SC
                WHERE VA.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                  AND VA.SOB_ID                   = AC.SOB_ID
                  AND AC.ACCOUNT_CONTROL_ID       = SL.ACCOUNT_CONTROL_ID
                  AND AC.SOB_ID                   = SL.SOB_ID
                  AND AC.ACCOUNT_DR_CR            = SL.ACCOUNT_DR_CR       -- 잔액 차/대구분 = 전표 차/대 구분 (발생전표)
                  AND SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                  AND SL.SOB_ID                   = SH.SOB_ID
                  AND SL.SLIP_LINE_ID             = S_SMI.SLIP_LINE_ID(+)
                  AND SL.SOB_ID                   = S_SMI.SOB_ID(+)
                  AND S_SMI.CUSTOMER_CODE         = SC.SUPP_CUST_CODE(+)
                  AND S_SMI.SOB_ID                = SC.SOB_ID(+)
                  AND VA.SOB_ID                   = W_SOB_ID
                  AND VA.VAT_TYPE                 IN('6')        -- 고정자산.
                  AND VA.ENABLED_FLAG             = 'Y'
                  AND SH.GL_DATE                  BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                  AND SH.SOB_ID                   = W_SOB_ID
                  AND SH.CONFIRM_YN               = 'Y'
                  AND EXISTS
                        ( SELECT 'X'
                            FROM FI_VAT_ACCOUNTS SVA
                              , FI_ACCOUNT_CONTROL SAC
                              , FI_SLIP_LINE SSL
                              , FI_SLIP_HEADER SSH
                          WHERE SVA.ACCOUNT_CONTROL_ID      = SAC.ACCOUNT_CONTROL_ID
                            AND SVA.SOB_ID                  = SAC.SOB_ID
                            AND SAC.ACCOUNT_CONTROL_ID      = SSL.ACCOUNT_CONTROL_ID
                            AND SAC.SOB_ID                  = SSL.SOB_ID
                            AND SAC.ACCOUNT_DR_CR           = SSL.ACCOUNT_DR_CR
                            AND SSL.SLIP_HEADER_ID          = SSH.SLIP_HEADER_ID
                            AND SSL.SOB_ID                  = SSH.SOB_ID
                            AND SSH.SLIP_HEADER_ID          = SH.SLIP_HEADER_ID
                            AND SSH.SOB_ID                  = SH.SOB_ID
                            AND SVA.ENABLED_FLAG            = 'Y'
                            AND SVA.VAT_ENABLED_FLAG        = 'Y'
                        )
                ORDER BY SL.GL_DATE, SL.ACCOUNT_CODE
              )
    LOOP
      UPDATE FI_VAT_DPR_ASSET DV
        SET DV.ACQUIRE_DATE       = C1.ACQUIRE_DATE
          , DV.ACCOUNT_CONTROL_ID = C1.ACCOUNT_CONTROL_ID
          , DV.VAT_ASSET_GB       = C1.VAT_ASSET_GB
          , DV.CUSTOMER_ID        = C1.CUSTOMER_ID
          , DV.GL_AMOUNT          = NVL(C1.GL_AMOUNT, 0)
          , DV.VAT_AMOUNT         = NVL(C1.VAT_AMOUNT, 0)
          , DV.CURRENCY_CODE      = C1.CURRENCY_CODE
          , DV.EXCHANGE_RATE      = NVL(C1.EXCHANGE_RATE, 0)
          , DV.GL_CURR_AMOUNT     = NVL(C1.GL_CURR_AMOUNT, 0)
          , DV.REMARK             = C1.REMARK
          , DV.LAST_UPDATE_DATE   = V_SYSDATE
          , DV.LAST_UPDATED_BY    = P_USER_ID
      WHERE DV.SOURCE_TABLE       = C1.SOURCE_TABLE
        AND DV.INTERFACE_LINE_ID  = C1.SLIP_LINE_ID
        AND DV.SOB_ID             = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        SELECT FI_VAT_DPR_ASSET_S1.NEXTVAL
          INTO V_DPR_ASSET_ID
          FROM DUAL;

        INSERT INTO FI_VAT_DPR_ASSET
        ( DPR_ASSET_ID
        , TAX_CODE
        , ACQUIRE_DATE
        , ACCOUNT_CONTROL_ID
        , VAT_ASSET_GB
        , CUSTOMER_ID
        , SOB_ID
        , ORG_ID
        , GL_AMOUNT
        , VAT_AMOUNT
        , CURRENCY_CODE
        , EXCHANGE_RATE
        , GL_CURR_AMOUNT
        , REMARK
        , CREATED_TYPE
        , SOURCE_TABLE
        , INTERFACE_HEADER_ID
        , INTERFACE_LINE_ID
        , CREATION_DATE
        , CREATED_BY
        , LAST_UPDATE_DATE
        , LAST_UPDATED_BY )
        VALUES
        ( V_DPR_ASSET_ID
        , W_TAX_CODE
        , C1.ACQUIRE_DATE
        , C1.ACCOUNT_CONTROL_ID
        , C1.VAT_ASSET_GB
        , C1.CUSTOMER_ID
        , C1.SOB_ID
        , C1.ORG_ID
        , NVL(C1.GL_AMOUNT, 0)
        , NVL(C1.VAT_AMOUNT, 0)
        , C1.CURRENCY_CODE
        , NVL(C1.EXCHANGE_RATE, 0)
        , NVL(C1.GL_CURR_AMOUNT, 0)
        , C1.REMARK
        , C1.CREATED_TYPE
        , C1.SOURCE_TABLE
        , C1.SLIP_HEADER_ID
        , C1.SLIP_LINE_ID
        , V_SYSDATE
        , P_USER_ID
        , V_SYSDATE
        , P_USER_ID );
      END IF;
    END LOOP C1;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END SET_DPR_ASSET;

---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 마감여부 체크.
  FUNCTION CLOSED_YN_F
            ( W_DPR_ASSET_ID      IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT DV.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_DPR_ASSET DV
      WHERE DV.DPR_ASSET_ID       = W_DPR_ASSET_ID
        AND DV.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;
  END CLOSED_YN_F;

END FI_VAT_NOT_DEDUCTION_G;
/
