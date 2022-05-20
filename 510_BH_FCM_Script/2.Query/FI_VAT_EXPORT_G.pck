CREATE OR REPLACE PACKAGE FI_VAT_EXPORT_G
AS

-- VAT 수출실적명세서 조회.
  PROCEDURE SELECT_EXPORT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_EXPORT.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_EXPORT.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , W_DOCUMENT_NUM      IN FI_VAT_EXPORT.DOCUMENT_NUM%TYPE
            );

-- VAT 수출실적명세서 INSERT.
  PROCEDURE INSERT_EXPORT
            ( P_EXPORT_ID     OUT FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_TAX_CODE      IN FI_VAT_EXPORT.TAX_CODE%TYPE
            , P_DOCUMENT_NUM  IN FI_VAT_EXPORT.DOCUMENT_NUM%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            , P_SHIPPING_DATE IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , P_CURRENCY_CODE IN FI_VAT_EXPORT.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE IN FI_VAT_EXPORT.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT   IN FI_VAT_EXPORT.CURR_AMOUNT%TYPE
            , P_BASE_AMOUNT   IN FI_VAT_EXPORT.BASE_AMOUNT%TYPE
            , P_USER_ID       IN FI_VAT_EXPORT.CREATED_BY%TYPE 
            );
                       
-- VAT 수출실적명세서 UPDATE.
  PROCEDURE UPDATE_EXPORT
            ( W_EXPORT_ID     IN FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_DOCUMENT_NUM  IN FI_VAT_EXPORT.DOCUMENT_NUM%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            , P_SHIPPING_DATE IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , P_CURRENCY_CODE IN FI_VAT_EXPORT.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE IN FI_VAT_EXPORT.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT   IN FI_VAT_EXPORT.CURR_AMOUNT%TYPE
            , P_BASE_AMOUNT   IN FI_VAT_EXPORT.BASE_AMOUNT%TYPE
            , P_USER_ID       IN FI_VAT_EXPORT.CREATED_BY%TYPE
            );

-- VAT 수출실적명세서 DELETE.
  PROCEDURE DELETE_EXPORT
            ( W_EXPORT_ID     IN FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 조회.
  PROCEDURE SET_CREATE_EXPORT
            ( W_TAX_CODE          IN FI_VAT_EXPORT.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_EXPORT.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , P_USER_ID           IN FI_VAT_EXPORT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            );
            
---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 마감여부 체크.
  FUNCTION EXPORT_CLOSED_YN_F
            ( W_EXPORT_ID     IN FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            ) RETURN VARCHAR2;
            
END FI_VAT_EXPORT_G;
/
CREATE OR REPLACE PACKAGE BODY FI_VAT_EXPORT_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_VAT_EXPORT_G
/* Description  : 부가세 조회-수출실적명세서 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- VAT 수출실적명세서 조회.
  PROCEDURE SELECT_EXPORT
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_TAX_CODE          IN FI_VAT_EXPORT.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_EXPORT.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , W_DOCUMENT_NUM      IN FI_VAT_EXPORT.DOCUMENT_NUM%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT VE.TAX_CODE
           , FI_COMMON_G.CODE_NAME_F('TAX_CODE', VE.TAX_CODE, VE.SOB_ID) AS TAX_CODE_DESC
           , VE.DOCUMENT_NUM
           , VE.SHIPPING_DATE
           , VE.CURRENCY_CODE
           , VE.EXCHANGE_RATE
           , VE.CURR_AMOUNT
           , VE.BASE_AMOUNT
           , VE.EXPORT_ID
           , VE.INTERFACE_HEADER_ID
        FROM FI_VAT_EXPORT VE
      WHERE VE.TAX_CODE                 = W_TAX_CODE
        AND VE.SHIPPING_DATE            BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
        AND VE.SOB_ID                   = W_SOB_ID
        AND VE.DOCUMENT_NUM             LIKE W_DOCUMENT_NUM || '%'
      ORDER BY VE.TAX_CODE, VE.SHIPPING_DATE, VE.DOCUMENT_NUM  
      ;
  END SELECT_EXPORT;

-- VAT 수출실적명세서 INSERT.
  PROCEDURE INSERT_EXPORT
            ( P_EXPORT_ID     OUT FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_TAX_CODE      IN FI_VAT_EXPORT.TAX_CODE%TYPE
            , P_DOCUMENT_NUM  IN FI_VAT_EXPORT.DOCUMENT_NUM%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            , P_SHIPPING_DATE IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , P_CURRENCY_CODE IN FI_VAT_EXPORT.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE IN FI_VAT_EXPORT.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT   IN FI_VAT_EXPORT.CURR_AMOUNT%TYPE
            , P_BASE_AMOUNT   IN FI_VAT_EXPORT.BASE_AMOUNT%TYPE
            , P_USER_ID       IN FI_VAT_EXPORT.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(VE.TAX_CODE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_VAT_EXPORT VE
      WHERE VE.TAX_CODE           = P_TAX_CODE
        AND VE.DOCUMENT_NUM       = P_DOCUMENT_NUM
        AND VE.SOB_ID             = P_SOB_ID
        AND VE.SHIPPING_DATE      = P_SHIPPING_DATE
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90003', '&&FIELD_NAME:=Export Document Num(수출실적번호)'));
    END IF;

    SELECT FI_VAT_EXPORT_S1.NEXTVAL
      INTO P_EXPORT_ID
      FROM DUAL;

    INSERT INTO FI_VAT_EXPORT
    ( EXPORT_ID
    , TAX_CODE 
    , DOCUMENT_NUM 
    , SOB_ID 
    , SHIPPING_DATE 
    , CURRENCY_CODE 
    , EXCHANGE_RATE 
    , CURR_AMOUNT 
    , BASE_AMOUNT 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_EXPORT_ID
    , P_TAX_CODE
    , P_DOCUMENT_NUM
    , P_SOB_ID
    , P_SHIPPING_DATE
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_CURR_AMOUNT
    , P_BASE_AMOUNT
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_EXPORT;
  
-- VAT 수출실적명세서 UPDATE.
  PROCEDURE UPDATE_EXPORT
            ( W_EXPORT_ID     IN FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_DOCUMENT_NUM  IN FI_VAT_EXPORT.DOCUMENT_NUM%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            , P_SHIPPING_DATE IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , P_CURRENCY_CODE IN FI_VAT_EXPORT.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE IN FI_VAT_EXPORT.EXCHANGE_RATE%TYPE
            , P_CURR_AMOUNT   IN FI_VAT_EXPORT.CURR_AMOUNT%TYPE
            , P_BASE_AMOUNT   IN FI_VAT_EXPORT.BASE_AMOUNT%TYPE
            , P_USER_ID       IN FI_VAT_EXPORT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF FI_VAT_EXPORT_G.EXPORT_CLOSED_YN_F(W_EXPORT_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Export Document Data(해당 수출실적번호)'));
    END IF;
    UPDATE FI_VAT_EXPORT
      SET DOCUMENT_NUM     = P_DOCUMENT_NUM
        , SHIPPING_DATE    = P_SHIPPING_DATE
        , CURRENCY_CODE    = P_CURRENCY_CODE
        , EXCHANGE_RATE    = P_EXCHANGE_RATE
        , CURR_AMOUNT      = P_CURR_AMOUNT
        , BASE_AMOUNT      = P_BASE_AMOUNT
        , LAST_UPDATE_DATE = V_SYSDATE
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE EXPORT_ID        = W_EXPORT_ID;
  END UPDATE_EXPORT;

-- VAT 수출실적명세서 DELETE.
  PROCEDURE DELETE_EXPORT
            ( W_EXPORT_ID     IN FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF FI_VAT_EXPORT_G.EXPORT_CLOSED_YN_F(W_EXPORT_ID, P_SOB_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_90007', '&&FIELD_NAME:=This Export Document Data(해당 수출실적번호)'));
    END IF;

    DELETE FROM FI_VAT_EXPORT
    WHERE EXPORT_ID        = W_EXPORT_ID;
  END DELETE_EXPORT;

---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 조회.
  PROCEDURE SET_CREATE_EXPORT
            ( W_TAX_CODE          IN FI_VAT_EXPORT.TAX_CODE%TYPE
            , W_SOB_ID            IN FI_VAT_EXPORT.SOB_ID%TYPE
            , W_ISSUE_DATE_FR     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , W_ISSUE_DATE_TO     IN FI_VAT_EXPORT.SHIPPING_DATE%TYPE
            , P_USER_ID           IN FI_VAT_EXPORT.CREATED_BY%TYPE
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE       DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_EXPORT_ID     FI_VAT_EXPORT.EXPORT_ID%TYPE;
  BEGIN
    FOR C1 IN ( SELECT S_SMI.DOCUMENT_NUM
                     , TO_DATE(S_SMI.VAT_ISSUE_DATE, 'YYYY-MM-DD') AS VAT_ISSUE_DATE
                     , SL.CURRENCY_CODE AS CURRENCY_CODE
                     , SL.EXCHANGE_RATE AS EXCHANGE_RATE
                     , SL.GL_CURRENCY_AMOUNT AS GL_CURR_AMOUNT
                     , NVL(REPLACE(S_SMI.SUPPLY_AMOUNT, ',', ''), 0) AS SUPPLY_AMOUNT
                     , VA.SOB_ID
                     , 'I' AS CREATED_TYPE
                     , 'SLIP' AS SOURCE_TABLE
                     , SL.SLIP_HEADER_ID
                     , SL.SLIP_LINE_ID
                  FROM FI_VAT_ACCOUNTS VA
                    , FI_ACCOUNT_CONTROL AC
                    , FI_SLIP_LINE SL
                    , FI_SLIP_HEADER SH    
                    , (-- 전표 정보.
                      SELECT SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'DOCUMENT_NO', SMI.MANAGEMENT_VALUE)) AS DOCUMENT_NUM
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'VAT_ISSUE_DATE', SMI.MANAGEMENT_VALUE)) AS VAT_ISSUE_DATE
                           , MAX(DECODE(MC.LOOKUP_TYPE, 'SUPPLY_AMOUNT', SMI.MANAGEMENT_VALUE)) AS SUPPLY_AMOUNT
                        FROM FI_SLIP_MANAGEMENT_ITEM SMI
                          , FI_MANAGEMENT_CODE_V MC
                      WHERE SMI.MANAGEMENT_ID           = MC.MANAGEMENT_ID
                        AND SMI.SOB_ID                  = MC.SOB_ID
                        AND SMI.SOB_ID                  = W_SOB_ID
                      GROUP BY SMI.SLIP_LINE_ID
                           , SMI.SOB_ID
                      ) S_SMI
                WHERE VA.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
                  AND VA.SOB_ID                   = AC.SOB_ID
                  AND AC.ACCOUNT_CONTROL_ID       = SL.ACCOUNT_CONTROL_ID
                  AND AC.SOB_ID                   = SL.SOB_ID
                  AND SL.SLIP_HEADER_ID           = SH.SLIP_HEADER_ID
                  AND SL.SOB_ID                   = SH.SOB_ID
                  AND SL.SLIP_LINE_ID             = S_SMI.SLIP_LINE_ID(+)
                  AND SL.SOB_ID                   = S_SMI.SOB_ID(+)
                  AND VA.SOB_ID                   = W_SOB_ID
                  AND VA.VAT_TYPE                 = '9'  -- 직수출.
                  AND VA.VAT_DOCUMENT_TYPE        = '1'  -- 수출실적명세서.
                  AND VA.ENABLED_FLAG             = 'Y'
                  AND SH.GL_DATE                  BETWEEN W_ISSUE_DATE_FR AND W_ISSUE_DATE_TO
                  AND SH.SOB_ID                   = W_SOB_ID
                  AND SH.CONFIRM_YN               = 'Y'
              )
    LOOP
      UPDATE FI_VAT_EXPORT VE
        SET VE.DOCUMENT_NUM       = C1.DOCUMENT_NUM
          , VE.SHIPPING_DATE      = C1.VAT_ISSUE_DATE
          , VE.CURRENCY_CODE      = C1.CURRENCY_CODE
          , VE.EXCHANGE_RATE      = NVL(C1.EXCHANGE_RATE, 0)
          , VE.CURR_AMOUNT        = NVL(C1.GL_CURR_AMOUNT, 0)
          , VE.BASE_AMOUNT        = NVL(C1.SUPPLY_AMOUNT, 0)
          , VE.LAST_UPDATE_DATE   = V_SYSDATE
          , VE.LAST_UPDATED_BY    = P_USER_ID
      WHERE VE.SOURCE_TABLE       = C1.SOURCE_TABLE
        AND VE.INTERFACE_LINE_ID  = C1.SLIP_LINE_ID
        AND VE.SOB_ID             = C1.SOB_ID
      ;
      IF SQL%ROWCOUNT = 0 THEN
        SELECT FI_VAT_EXPORT_S1.NEXTVAL
          INTO V_EXPORT_ID
          FROM DUAL;

        INSERT INTO FI_VAT_EXPORT
        ( EXPORT_ID
        , TAX_CODE 
        , DOCUMENT_NUM 
        , SOB_ID 
        , SHIPPING_DATE 
        , CURRENCY_CODE 
        , EXCHANGE_RATE 
        , CURR_AMOUNT 
        , BASE_AMOUNT 
        , CREATED_TYPE
        , SOURCE_TABLE
        , INTERFACE_HEADER_ID
        , INTERFACE_LINE_ID
        , CREATION_DATE 
        , CREATED_BY 
        , LAST_UPDATE_DATE 
        , LAST_UPDATED_BY )
        VALUES
        ( V_EXPORT_ID
        , W_TAX_CODE
        , C1.DOCUMENT_NUM
        , C1.SOB_ID
        , C1.VAT_ISSUE_DATE
        , C1.CURRENCY_CODE
        , NVL(C1.EXCHANGE_RATE, 0)
        , NVL(C1.GL_CURR_AMOUNT, 0)
        , NVL(C1.SUPPLY_AMOUNT, 0)
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
  END SET_CREATE_EXPORT;
            
---------------------------------------------------------------------------------------------------
-- VAT 수출실적명세서 마감여부 체크.
  FUNCTION EXPORT_CLOSED_YN_F
            ( W_EXPORT_ID     IN FI_VAT_EXPORT.EXPORT_ID%TYPE
            , P_SOB_ID        IN FI_VAT_EXPORT.SOB_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CLOSED_YN         CHAR(1) := 'N';
  BEGIN
    BEGIN
      SELECT VE.CLOSED_YN
        INTO V_CLOSED_YN
        FROM FI_VAT_EXPORT VE
      WHERE VE.EXPORT_ID        = W_EXPORT_ID
        AND VE.SOB_ID           = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := 'N';
    END;
    RETURN V_CLOSED_YN;    
  END EXPORT_CLOSED_YN_F;
  
END FI_VAT_EXPORT_G;
/
