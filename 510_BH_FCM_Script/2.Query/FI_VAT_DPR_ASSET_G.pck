CREATE OR REPLACE PACKAGE FI_VAT_DPR_ASSET_G
AS

-- VAT �ǹ������������ ��ȸ.
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            );

-- VAT �ǹ������������ �󼼸��� ��ȸ.
  PROCEDURE SELECT_DPR_ASSET_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            );

-- VAT �ǹ������������ �󼼸��� UPDATE.
  PROCEDURE UPDATE_DPR_ASSET_DETAIL
            ( W_DPR_ASSET_ID        IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_ACQUIRE_DATE        IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , P_SOB_ID              IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_VAT_DPR_ASSET.ORG_ID%TYPE
            , P_GL_AMOUNT           IN FI_VAT_DPR_ASSET.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT          IN FI_VAT_DPR_ASSET.VAT_AMOUNT%TYPE
            , P_REMARK              IN FI_VAT_DPR_ASSET.REMARK%TYPE
            , P_USER_ID             IN FI_VAT_DPR_ASSET.CREATED_BY%TYPE
            );

-- VAT �ǹ������������ �󼼸��� DELETE.
  PROCEDURE DELETE_DPR_ASSET_DETAIL
            ( W_DPR_ASSET_ID        IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_SOB_ID              IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- VAT ������������ ����.
  PROCEDURE SET_DPR_ASSET
            ( W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , P_USER_ID           IN FI_VAT_DPR_ASSET.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- VAT ����������� �������� üũ.
  FUNCTION CLOSED_YN_F
            ( W_DPR_ASSET_ID      IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            ) RETURN VARCHAR2;

END FI_VAT_DPR_ASSET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_DPR_ASSET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_DPR_ASSET_G
/* Description  : �ΰ��� ��ȸ-�ǹ������������ ����.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT �ǹ������������ ��ȸ.
  PROCEDURE SELECT_DPR_ASSET
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT CASE 
               WHEN GROUPING(VAG.VAT_ASSET_GB) = 1 THEN '0'
               ELSE VAG.VAT_ASSET_GB
             END VAT_ASSET_GB
           , CASE
               WHEN GROUPING(VAG.VAT_ASSET_GB) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10062', NULL)
               ELSE VAG.VAT_ASSET_GB_DESC
             END AS VAT_ASSET_GB_DESC
           , SUM(S_DA.ASSET_COUNT) AS ASSET_COUNT
           , SUM(S_DA.GL_AMOUNT) AS GL_AMOUNT
           , SUM(S_DA.VAT_AMOUNT) AS VAT_AMOUNT
           , NULL AS DESCRIPTION
        FROM FI_VAT_ASSET_GB_V VAG
          , (-- �ǹ����������. 
             SELECT DA.VAT_ASSET_GB
                  , DA.SOB_ID
                  , COUNT(DA.DPR_ASSET_ID) AS ASSET_COUNT
                  , SUM(DA.GL_AMOUNT) AS GL_AMOUNT
                  , SUM(DA.VAT_AMOUNT) AS VAT_AMOUNT
                FROM FI_VAT_DPR_ASSET DA
               WHERE DA.TAX_CODE           = W_TAX_CODE
                 AND DA.ACQUIRE_DATE       BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                 AND DA.SOB_ID             = W_SOB_ID
             GROUP BY DA.VAT_ASSET_GB
                  , DA.SOB_ID
            ) S_DA
      WHERE VAG.VAT_ASSET_GB      = S_DA.VAT_ASSET_GB(+)
        AND VAG.SOB_ID            = S_DA.SOB_ID(+)
        AND VAG.SOB_ID            = W_SOB_ID
      GROUP BY ROLLUP((VAG.VAT_ASSET_GB
           , VAG.VAT_ASSET_GB_DESC))
      ORDER BY VAT_ASSET_GB
      ;
  END SELECT_DPR_ASSET;

-- VAT �ǹ������������ �󼼸��� ��ȸ.
  PROCEDURE SELECT_DPR_ASSET_DETAIL
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_TAX_CODE          IN FI_VAT_DPR_ASSET.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DA.TAX_CODE
          , DA.ACQUIRE_DATE AS ACQUIRE_DATE
          , AC.ACCOUNT_CODE
          , AC.ACCOUNT_DESC
          , DA.ACCOUNT_CONTROL_ID
          , SC.SUPP_CUST_CODE AS CUSTOMER_CODE
          , SC.SUPP_CUST_NAME AS CUSTOMER_DESC
          , SC.TAX_REG_NO
          , DA.CUSTOMER_ID
          , DA.GL_AMOUNT AS GL_AMOUNT
          , DA.VAT_AMOUNT AS VAT_AMOUNT
          , DA.REMARK
          , DA.VAT_ASSET_GB
          , FI_COMMON_G.CODE_NAME_F('VAT_ASSET_GB', DA.VAT_ASSET_GB, DA.SOB_ID) AS VAT_ASSET_GB_DESC
          , DA.DPR_ASSET_ID
          , DA.INTERFACE_HEADER_ID
        FROM FI_VAT_DPR_ASSET DA
          , FI_ACCOUNT_CONTROL AC
          , FI_SUPP_CUST_V SC
      WHERE DA.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND DA.SOB_ID             = AC.SOB_ID
        AND DA.CUSTOMER_ID        = SC.SUPP_CUST_ID
        AND DA.SOB_ID             = SC.SOB_ID
        AND DA.TAX_CODE           = W_TAX_CODE
        AND DA.ACQUIRE_DATE       BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND DA.SOB_ID             = W_SOB_ID
      ORDER BY DA.TAX_CODE, SC.TAX_REG_NO, DA.ACQUIRE_DATE
      ;
  END SELECT_DPR_ASSET_DETAIL;

-- VAT �ǹ������������ �󼼸��� UPDATE.
  PROCEDURE UPDATE_DPR_ASSET_DETAIL
            ( W_DPR_ASSET_ID        IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_ACQUIRE_DATE        IN FI_VAT_DPR_ASSET.ACQUIRE_DATE%TYPE
            , P_SOB_ID              IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_VAT_DPR_ASSET.ORG_ID%TYPE
            , P_GL_AMOUNT           IN FI_VAT_DPR_ASSET.GL_AMOUNT%TYPE
            , P_VAT_AMOUNT          IN FI_VAT_DPR_ASSET.VAT_AMOUNT%TYPE
            , P_REMARK              IN FI_VAT_DPR_ASSET.REMARK%TYPE
            , P_USER_ID             IN FI_VAT_DPR_ASSET.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF FI_VAT_DPR_ASSET_G.CLOSED_YN_F(W_DPR_ASSET_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Depreciation Asset(�ش� ������ ����ڻ�)'));
    END IF;
    UPDATE FI_VAT_DPR_ASSET
      SET ACQUIRE_DATE        = P_ACQUIRE_DATE
        , GL_AMOUNT           = P_GL_AMOUNT
        , VAT_AMOUNT          = P_VAT_AMOUNT
        , REMARK              = P_REMARK
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE DPR_ASSET_ID        = W_DPR_ASSET_ID;
  END UPDATE_DPR_ASSET_DETAIL;

-- VAT �ǹ������������ �󼼸��� DELETE.
  PROCEDURE DELETE_DPR_ASSET_DETAIL
            ( W_DPR_ASSET_ID        IN FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE
            , P_SOB_ID              IN FI_VAT_DPR_ASSET.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF FI_VAT_DPR_ASSET_G.CLOSED_YN_F(W_DPR_ASSET_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Depreciation Asset(�ش� ������ ����ڻ�)'));
    END IF;
    DELETE FROM FI_VAT_DPR_ASSET
    WHERE DPR_ASSET_ID        = W_DPR_ASSET_ID;
  END DELETE_DPR_ASSET_DETAIL;

---------------------------------------------------------------------------------------------------
-- VAT ������������ ����.
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
    V_RECORD_COUNT      NUMBER := 0;
    V_DPR_ASSET_ID      FI_VAT_DPR_ASSET.DPR_ASSET_ID%TYPE;
  BEGIN
    BEGIN
      SELECT COUNT(DA.DPR_ASSET_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_DPR_ASSET DA
      WHERE DA.TAX_CODE           = W_TAX_CODE
        AND DA.SOB_ID             = W_SOB_ID
        AND DA.ACQUIRE_DATE	      BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND DA.CLOSED_YN          = 'Y' 
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Depreciation Asset(�ش� ������ ����ڻ�)'));
    END IF;
    
    -- ���� �ڷ� ����.
    DELETE FROM FI_VAT_DPR_ASSET DA
    WHERE DA.TAX_CODE             = W_TAX_CODE
      AND DA.SOB_ID               = W_SOB_ID
      AND DA.ACQUIRE_DATE	        BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
      AND DA.INTERFACE_LINE_ID    IS NOT NULL
    ;
    
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
                    , (-- ��ǥ ����.
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
                  AND AC.ACCOUNT_DR_CR            = SL.ACCOUNT_DR_CR       -- �ܾ� ��/�뱸�� = ��ǥ ��/�� ���� (�߻���ǥ)
                  AND SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                  AND SL.SOB_ID                   = SH.SOB_ID
                  AND SL.SLIP_LINE_ID             = S_SMI.SLIP_LINE_ID(+)
                  AND SL.SOB_ID                   = S_SMI.SOB_ID(+)
                  AND S_SMI.CUSTOMER_CODE         = SC.SUPP_CUST_CODE(+)
                  AND S_SMI.SOB_ID                = SC.SOB_ID(+)
                  AND VA.SOB_ID                   = W_SOB_ID
                  AND VA.VAT_TYPE                 IN('6')        -- �����ڻ�.
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
-- VAT ����������� �������� üũ.
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

END FI_VAT_DPR_ASSET_G;
/
