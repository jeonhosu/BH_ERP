CREATE OR REPLACE PACKAGE FI_SLIP_AUTO_INTERFACE_G
AS

-- 전표 생성 데이터 생성.
  PROCEDURE SET_SLIP_AUTO_INTERFACE
            ( P_MODULE_TYPE         IN FI_SLIP_AUTO_INTERFACE_GT.MODULE_TYPE%TYPE
            , P_SLIP_DATE           IN FI_SLIP_AUTO_INTERFACE_GT.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_AUTO_INTERFACE_GT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_AUTO_INTERFACE_GT.ORG_ID%TYPE
            , P_USER_ID             IN FI_SLIP_AUTO_INTERFACE_GT.CREATED_BY%TYPE
            , O_HEADER_ID           OUT FI_SLIP_AUTO_INTERFACE_GT.HEADER_ID%TYPE
            , O_SLIP_NUM            OUT FI_SLIP_AUTO_INTERFACE_GT.SLIP_NUM%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );
    
-- 전표 생성 데이터 삽입.
  PROCEDURE INSERT_SLIP_AUTO_INTERFACE
            ( P_MODULE_TYPE         IN FI_SLIP_AUTO_INTERFACE_GT.MODULE_TYPE%TYPE
            , P_SLIP_DATE           IN FI_SLIP_AUTO_INTERFACE_GT.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_AUTO_INTERFACE_GT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_AUTO_INTERFACE_GT.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_AUTO_INTERFACE_GT.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_AUTO_INTERFACE_GT.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_AUTO_INTERFACE_GT.BUDGET_DEPT_ID%TYPE
            , P_HEADER_REMARK       IN FI_SLIP_AUTO_INTERFACE_GT.HEADER_REMARK%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_AUTO_INTERFACE_GT.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_AUTO_INTERFACE_GT.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_AUTO_INTERFACE_GT.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_AUTO_INTERFACE_GT.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_AUTO_INTERFACE_GT.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_AUTO_INTERFACE_GT.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_AUTO_INTERFACE_GT.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_AUTO_INTERFACE_GT.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_AUTO_INTERFACE_GT.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_AUTO_INTERFACE_GT.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_AUTO_INTERFACE_GT.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_AUTO_INTERFACE_GT.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_AUTO_INTERFACE_GT.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_AUTO_INTERFACE_GT.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_AUTO_INTERFACE_GT.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_AUTO_INTERFACE_GT.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_AUTO_INTERFACE_GT.REFER9%TYPE
            , P_REFER10             IN FI_SLIP_AUTO_INTERFACE_GT.REFER10%TYPE
            , P_REFER11             IN FI_SLIP_AUTO_INTERFACE_GT.REFER11%TYPE
            , P_REFER12             IN FI_SLIP_AUTO_INTERFACE_GT.REFER12%TYPE
            , P_VOUCH_CODE          IN FI_SLIP_AUTO_INTERFACE_GT.VOUCH_CODE%TYPE
            , P_REFER_RATE          IN FI_SLIP_AUTO_INTERFACE_GT.REFER_RATE%TYPE
            , P_REFER_AMOUNT        IN FI_SLIP_AUTO_INTERFACE_GT.REFER_AMOUNT%TYPE
            , P_REFER_DATE1         IN FI_SLIP_AUTO_INTERFACE_GT.REFER_DATE1%TYPE
            , P_REFER_DATE2         IN FI_SLIP_AUTO_INTERFACE_GT.REFER_DATE2%TYPE
            , P_REMARK              IN FI_SLIP_AUTO_INTERFACE_GT.REMARK%TYPE
            , P_FUND_CODE           IN FI_SLIP_AUTO_INTERFACE_GT.FUND_CODE%TYPE
            , P_UNIT_PRICE          IN FI_SLIP_AUTO_INTERFACE_GT.UNIT_PRICE%TYPE
            , P_UOM_CODE            IN FI_SLIP_AUTO_INTERFACE_GT.UOM_CODE%TYPE
            , P_QUANTITY            IN FI_SLIP_AUTO_INTERFACE_GT.QUANTITY%TYPE
            , P_WEIGHT              IN FI_SLIP_AUTO_INTERFACE_GT.WEIGHT%TYPE
            , P_USER_ID             IN FI_SLIP_AUTO_INTERFACE_GT.CREATED_BY%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );

-- 전표 생성 데이터 삭제.
  PROCEDURE DELETE_SLIP_AUTO_INTERFACE;

---------------------------------------------------------------------------------------------------
-- 전표 생성 데이터 삭제.
  PROCEDURE DELETE_SLIP_INTERFACE
            ( W_HEADER_ID           IN FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );
            
-- 전표 생성 데이터 삭제.
  PROCEDURE DELETE_SLIP_INTERFACE_1
            ( W_SLIP_NUM            IN FI_SLIP_HEADER_INTERFACE.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER_INTERFACE.SOB_ID%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            );
            
END FI_SLIP_AUTO_INTERFACE_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SLIP_AUTO_INTERFACE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : FI_SLIP_AUTO_INTERFACE_G
/* Description  : 모듈간 자동전표 관리 패키지.
/*
/* Reference by : 임시테이블을 이용해서 전표 생성전 데이터 검증 및 검증 완료후 전표 생성및 전표 ID /전표 번호 리턴.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 전표 생성 데이터 생성.
  PROCEDURE SET_SLIP_AUTO_INTERFACE
            ( P_MODULE_TYPE         IN FI_SLIP_AUTO_INTERFACE_GT.MODULE_TYPE%TYPE
            , P_SLIP_DATE           IN FI_SLIP_AUTO_INTERFACE_GT.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_AUTO_INTERFACE_GT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_AUTO_INTERFACE_GT.ORG_ID%TYPE
            , P_USER_ID             IN FI_SLIP_AUTO_INTERFACE_GT.CREATED_BY%TYPE
            , O_HEADER_ID           OUT FI_SLIP_AUTO_INTERFACE_GT.HEADER_ID%TYPE
            , O_SLIP_NUM            OUT FI_SLIP_AUTO_INTERFACE_GT.SLIP_NUM%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_DOCUMENT_TYPE                 VARCHAR2(20);
    V_SLIP_NUM                      VARCHAR2(30);
    V_HEADER_ID                     NUMBER;
    V_LINE_ID                       NUMBER;
    V_DR_AMOUNT                     NUMBER := 0;  -- 차변금액.
    V_CR_AMOUNT                     NUMBER := 0;  -- 대변금액.
    V_GAP_AMOUNT                    NUMBER := 0;  -- 차이금액.
    V_SLIP_COUNT                    NUMBER := 0;  -- 전표생성 카운트.
  BEGIN
    O_STATUS := 'F';  -- S:성공, F:실패.
    -- 모듈 체크.
    IF P_MODULE_TYPE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10130', NULL);
      RETURN;
    END IF;
    -- 전표일자.
    IF P_SLIP_DATE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10187', NULL);
      RETURN;
    END IF;
    -- 기간 오픈 검증.
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      O_MESSAGE := ERRNUMS.Data_Not_Opened_Desc;
      RETURN;
    END IF;
    
    BEGIN
      SELECT SUM(DECODE(ASI.ACCOUNT_DR_CR, '1', ASI.GL_AMOUNT, 0)) AS DR_AMOUNT
           , SUM(DECODE(ASI.ACCOUNT_DR_CR, '2', ASI.GL_AMOUNT, 0)) AS CR_AMOUNT
        INTO V_DR_AMOUNT, V_CR_AMOUNT
        FROM FI_SLIP_AUTO_INTERFACE_GT ASI
      WHERE ASI.MODULE_TYPE       = P_MODULE_TYPE
        AND ASI.SOB_ID            = P_SOB_ID
        AND ASI.CREATED_BY        = P_USER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DR_AMOUNT := -1;
      V_CR_AMOUNT := 0;
    END;
    IF NVL(V_DR_AMOUNT, 0) <> NVL(V_CR_AMOUNT, 0) THEN
      V_GAP_AMOUNT := ABS(NVL(V_DR_AMOUNT, 0) - NVL(V_CR_AMOUNT, 0));      
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10249', '&&AMOUNT:=' || TO_CHAR(V_GAP_AMOUNT, 'FM999,999,999,999,999'))
                   || '==> Debit : ' || TO_CHAR(V_DR_AMOUNT, 'FM999,999,999,999,999')
                   || ' / Credit : ' || TO_CHAR(V_CR_AMOUNT, 'FM999,999,999,999,999');
      RETURN;
    END IF;
    /*
    BEGIN
      SELECT COUNT(*) AS CNT
        INTO V_SLIP_COUNT
        FROM FI_SLIP_AUTO_INTERFACE_GT SAI
      \*WHERE SAI.MODULE_TYPE       = P_MODULE_TYPE
        AND SAI.SOB_ID            = P_SOB_ID
        AND SAI.CREATED_BY        = P_USER_ID*\
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SLIP_COUNT := 0;
    END;
    O_MESSAGE := 'P_MODULE_TYPE : ' || P_MODULE_TYPE || ', ' || P_USER_ID || ', V_SLIP_COUNT : ' || V_SLIP_COUNT;
    RETURN;*/
        
    -- 전표생성.
    BEGIN
      FOR C1 IN ( -- 헤더 생성.
                  SELECT SAI.SLIP_DATE
                       , SAI.SOB_ID
                       , SAI.ORG_ID
                       , SAI.DEPT_ID
                       , SAI.PERSON_ID
                       , SAI.BUDGET_DEPT_ID
                       , SAI.ACCOUNT_BOOK_ID
                       , SAI.SLIP_TYPE
                       , SAI.JOURNAL_HEADER_ID
                       , SUM(DECODE(SAI.ACCOUNT_DR_CR, '1', SAI.GL_AMOUNT, 0)) AS GL_AMOUNT
                       , SAI.CURRENCY_CODE
                       , MAX(SAI.EXCHANGE_RATE) EXCHANGE_RATE
                       , SUM(DECODE(SAI.ACCOUNT_DR_CR, '1', SAI.GL_CURRENCY_AMOUNT, 0)) AS GL_CURRENCY_AMOUNT
                       , MAX(SAI.HEADER_REMARK) AS HEADER_REMARK
                       , SAI.CREATED_BY AS USER_ID
                    FROM FI_SLIP_AUTO_INTERFACE_GT SAI
                  WHERE SAI.MODULE_TYPE       = P_MODULE_TYPE
                    AND SAI.SOB_ID            = P_SOB_ID
                    AND SAI.CREATED_BY        = P_USER_ID
                  GROUP BY SAI.SLIP_DATE
                       , SAI.SOB_ID
                       , SAI.ORG_ID
                       , SAI.DEPT_ID
                       , SAI.PERSON_ID
                       , SAI.BUDGET_DEPT_ID
                       , SAI.ACCOUNT_BOOK_ID
                       , SAI.SLIP_TYPE
                       , SAI.JOURNAL_HEADER_ID
                       , SAI.CURRENCY_CODE
                       , SAI.CREATED_BY
                 ORDER BY SAI.SLIP_DATE
                 )
      LOOP
        -- 문서 타입.
        BEGIN
          SELECT ST.DOCUMENT_TYPE
            INTO V_DOCUMENT_TYPE
            FROM FI_SLIP_TYPE_V ST
          WHERE ST.SLIP_TYPE          = C1.SLIP_TYPE
            AND ST.SOB_ID             = C1.SOB_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_DOCUMENT_TYPE := NULL;
        END;
        -- 기표번호 생성.
        V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F(V_DOCUMENT_TYPE, C1.SOB_ID, C1.SLIP_DATE, C1.USER_ID); 
        IF V_SLIP_NUM IS NULL THEN
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10118', NULL);
          RETURN;
        END IF;
        
        FI_SLIP_INTERFACE_G.INSERT_HEADER_IF
                    ( P_HEADER_INTERFACE_ID => V_HEADER_ID
                    , P_SLIP_DATE           => C1.SLIP_DATE
                    , P_SLIP_NUM            => V_SLIP_NUM
                    , P_SOB_ID              => C1.SOB_ID
                    , P_ORG_ID              => C1.ORG_ID 
                    , P_DEPT_ID             => C1.DEPT_ID
                    , P_PERSON_ID           => C1.PERSON_ID
                    , P_BUDGET_DEPT_ID      => NULL
                    , P_SLIP_TYPE           => C1.SLIP_TYPE
                    , P_JOURNAL_HEADER_ID   => C1.JOURNAL_HEADER_ID
                    , P_REQ_BANK_ACCOUNT_ID => NULL
                    , P_REQ_PAYABLE_TYPE    => NULL
                    , P_REQ_PAYABLE_DATE    => NULL
                    , P_REMARK              => C1.HEADER_REMARK
                    , P_SUBSTANCE           => NULL
                    , P_SOURCE_TABLE        => P_MODULE_TYPE
                    , P_CREATED_TYPE        => 'I'
                    , P_USER_ID             => P_USER_ID
                    );
        V_SLIP_COUNT := NVL(V_SLIP_COUNT, 0) + 1;
        
        -- LINE INSERT.
        FOR R1 IN ( SELECT SAI.SLIP_DATE
                         , SAI.SLIP_NUM
                         , SAI.SLIP_LINE_SEQ
                         , SAI.SOB_ID
                         , SAI.ORG_ID
                         , SAI.ACCOUNT_CONTROL_ID
                         , SAI.ACCOUNT_CODE
                         , SAI.ACCOUNT_DR_CR     
                         , SAI.GL_AMOUNT AS GL_AMOUNT
                         , SAI.CURRENCY_CODE
                         , SAI.EXCHANGE_RATE EXCHANGE_RATE
                         , SAI.GL_CURRENCY_AMOUNT AS GL_CURRENCY_AMOUNT
                         , REPLACE(SAI.MANAGEMENT1, ',', '') MANAGEMENT1
                         , REPLACE(SAI.MANAGEMENT2, ',', '') MANAGEMENT2
                         , REPLACE(SAI.REFER1, ',', '') REFER1
                         , REPLACE(SAI.REFER2, ',', '') REFER2
                         , REPLACE(SAI.REFER3, ',', '') REFER3
                         , REPLACE(SAI.REFER4, ',', '') REFER4
                         , REPLACE(SAI.REFER5, ',', '') REFER5
                         , REPLACE(SAI.REFER6, ',', '') REFER6
                         , REPLACE(SAI.REFER7, ',', '') REFER7
                         , REPLACE(SAI.REFER8, ',', '') REFER8
                         , REPLACE(SAI.REFER9, ',', '') REFER9
                         , REPLACE(SAI.REFER10, ',', '') REFER10
                         , REPLACE(SAI.REFER11, ',', '') REFER11
                         , REPLACE(SAI.REFER12, ',', '') REFER12
                         , SAI.REMARK
                      FROM FI_SLIP_AUTO_INTERFACE_GT SAI
                    WHERE SAI.MODULE_TYPE       = P_MODULE_TYPE
                      AND SAI.SOB_ID            = P_SOB_ID
                      AND SAI.CREATED_BY        = P_USER_ID
                    ORDER BY SAI.SLIP_LINE_SEQ  
                   )
        LOOP
          FI_SLIP_INTERFACE_G.INSERT_LINE_IF
                ( P_LINE_INTERFACE_ID   => V_LINE_ID
                , P_HEADER_INTERFACE_ID => V_HEADER_ID
                , P_SOB_ID              => R1.SOB_ID
                , P_ORG_ID              => R1.ORG_ID
                , P_BUDGET_DEPT_ID      => C1.BUDGET_DEPT_ID
                , P_CUSTOMER_ID         => NULL
                , P_ACCOUNT_CONTROL_ID  => R1.ACCOUNT_CONTROL_ID
                , P_ACCOUNT_CODE        => R1.ACCOUNT_CODE
                , P_COST_CENTER_ID      => NULL
                , P_ACCOUNT_DR_CR       => R1.ACCOUNT_DR_CR
                , P_GL_AMOUNT           => R1.GL_AMOUNT
                , P_CURRENCY_CODE       => R1.CURRENCY_CODE
                , P_EXCHANGE_RATE       => R1.EXCHANGE_RATE
                , P_GL_CURRENCY_AMOUNT  => R1.GL_CURRENCY_AMOUNT
                , P_BANK_ACCOUNT_ID     => NULL
                , P_MANAGEMENT1         => R1.MANAGEMENT1
                , P_MANAGEMENT2         => R1.MANAGEMENT2
                , P_REFER1              => R1.REFER1
                , P_REFER2              => R1.REFER2
                , P_REFER3              => R1.REFER3
                , P_REFER4              => R1.REFER4
                , P_REFER5              => R1.REFER5
                , P_REFER6              => R1.REFER6
                , P_REFER7              => R1.REFER7
                , P_REFER8              => R1.REFER8
                , P_REFER9              => R1.REFER9            
                , P_REFER10             => R1.REFER10
                , P_REFER11             => R1.REFER11
                , P_REFER12             => R1.REFER12            
                , P_VOUCH_CODE          => NULL
                , P_REFER_RATE          => NULL
                , P_REFER_AMOUNT        => NULL
                , P_REFER_DATE1         => NULL
                , P_REFER_DATE2         => NULL
                , P_REMARK              => R1.REMARK
                , P_FUND_CODE           => NULL
                , P_USER_ID             => P_USER_ID
                );
        END LOOP R1;
      END LOOP C1;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Create Slip Error : ' || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    /*O_MESSAGE := 'COUNT : ' || V_SLIP_COUNT || ', HEADER ID : ' || V_HEADER_ID || ', SLIP NUM : ' || V_SLIP_NUM;
    RETURN;*/
    
    -- 임시테이블 기존자료 삭제.
    FI_SLIP_AUTO_INTERFACE_G.DELETE_SLIP_AUTO_INTERFACE;
    
    IF V_SLIP_COUNT = 0 THEN
      O_HEADER_ID := NULL;
      O_SLIP_NUM := NULL;
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10381', NULL);
    ELSE
      O_HEADER_ID := V_HEADER_ID;
      O_SLIP_NUM := V_SLIP_NUM;
      O_STATUS := 'S';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
    END IF;
  END SET_SLIP_AUTO_INTERFACE;
  
-- 전표 생성 데이터 삽입.
  PROCEDURE INSERT_SLIP_AUTO_INTERFACE
            ( P_MODULE_TYPE         IN FI_SLIP_AUTO_INTERFACE_GT.MODULE_TYPE%TYPE
            , P_SLIP_DATE           IN FI_SLIP_AUTO_INTERFACE_GT.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_AUTO_INTERFACE_GT.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_AUTO_INTERFACE_GT.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_AUTO_INTERFACE_GT.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_AUTO_INTERFACE_GT.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_AUTO_INTERFACE_GT.BUDGET_DEPT_ID%TYPE
            , P_HEADER_REMARK       IN FI_SLIP_AUTO_INTERFACE_GT.HEADER_REMARK%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_AUTO_INTERFACE_GT.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_AUTO_INTERFACE_GT.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_AUTO_INTERFACE_GT.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_AUTO_INTERFACE_GT.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_AUTO_INTERFACE_GT.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_AUTO_INTERFACE_GT.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_AUTO_INTERFACE_GT.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_AUTO_INTERFACE_GT.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_AUTO_INTERFACE_GT.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_AUTO_INTERFACE_GT.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_AUTO_INTERFACE_GT.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_AUTO_INTERFACE_GT.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_AUTO_INTERFACE_GT.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_AUTO_INTERFACE_GT.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_AUTO_INTERFACE_GT.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_AUTO_INTERFACE_GT.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_AUTO_INTERFACE_GT.REFER9%TYPE
            , P_REFER10             IN FI_SLIP_AUTO_INTERFACE_GT.REFER10%TYPE
            , P_REFER11             IN FI_SLIP_AUTO_INTERFACE_GT.REFER11%TYPE
            , P_REFER12             IN FI_SLIP_AUTO_INTERFACE_GT.REFER12%TYPE
            , P_VOUCH_CODE          IN FI_SLIP_AUTO_INTERFACE_GT.VOUCH_CODE%TYPE
            , P_REFER_RATE          IN FI_SLIP_AUTO_INTERFACE_GT.REFER_RATE%TYPE
            , P_REFER_AMOUNT        IN FI_SLIP_AUTO_INTERFACE_GT.REFER_AMOUNT%TYPE
            , P_REFER_DATE1         IN FI_SLIP_AUTO_INTERFACE_GT.REFER_DATE1%TYPE
            , P_REFER_DATE2         IN FI_SLIP_AUTO_INTERFACE_GT.REFER_DATE2%TYPE
            , P_REMARK              IN FI_SLIP_AUTO_INTERFACE_GT.REMARK%TYPE
            , P_FUND_CODE           IN FI_SLIP_AUTO_INTERFACE_GT.FUND_CODE%TYPE
            , P_UNIT_PRICE          IN FI_SLIP_AUTO_INTERFACE_GT.UNIT_PRICE%TYPE
            , P_UOM_CODE            IN FI_SLIP_AUTO_INTERFACE_GT.UOM_CODE%TYPE
            , P_QUANTITY            IN FI_SLIP_AUTO_INTERFACE_GT.QUANTITY%TYPE
            , P_WEIGHT              IN FI_SLIP_AUTO_INTERFACE_GT.WEIGHT%TYPE
            , P_USER_ID             IN FI_SLIP_AUTO_INTERFACE_GT.CREATED_BY%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_SLIP_LINE_SEQ                 FI_SLIP_AUTO_INTERFACE_GT.SLIP_LINE_SEQ%TYPE;
    V_SLIP_TYPE                     FI_SLIP_AUTO_INTERFACE_GT.SLIP_TYPE%TYPE;
    V_DEPT_ID                       FI_SLIP_AUTO_INTERFACE_GT.DEPT_ID%TYPE;
    V_ACCOUNT_CONTROL_ID            FI_SLIP_AUTO_INTERFACE_GT.ACCOUNT_CONTROL_ID%TYPE;
  BEGIN
    O_STATUS := 'F';
    /* -- 저장전 데이터 검증 -- */
    -- 모듈 체크.
    IF P_MODULE_TYPE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10130', NULL);
      RETURN;
    END IF;
    V_SLIP_TYPE := P_MODULE_TYPE;
    
    -- 차대구분.
    IF P_MODULE_TYPE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10130', NULL);
      RETURN;
    END IF;    
    -- 전표일자.
    IF P_SLIP_DATE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10187', NULL);
      RETURN;
    END IF;        
    -- 사원ID 검증.
    
    -- DEPT 검증.
    BEGIN
      SELECT FDM.DEPT_ID
        INTO V_DEPT_ID
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
          , FI_DEPT_MASTER FDM
      WHERE PM.DEPT_ID          = DM.HR_DEPT_ID
        AND DM.M_DEPT_ID        = FDM.DEPT_ID
        AND DM.MODULE_TYPE      = 'FCM'
        AND PM.PERSON_ID        = P_PERSON_ID
        AND PM.SOB_ID           = P_SOB_ID
        AND PM.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DEPT_ID := NULL;
    END;
    IF V_DEPT_ID IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL);
      RETURN;
    END IF;
    
    -- 차대구분.
    IF NVL(P_ACCOUNT_DR_CR, '0') NOT IN ('1', '2') THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10122', NULL);
      RETURN;
    END IF;    
    -- 계정ID.
    BEGIN
      SELECT AC.ACCOUNT_CONTROL_ID
        INTO V_ACCOUNT_CONTROL_ID  
        FROM FI_ACCOUNT_CONTROL AC
      WHERE AC.ACCOUNT_SET_ID     = FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_SET_F(P_SOB_ID)
        AND AC.SOB_ID             = P_SOB_ID
        AND AC.ACCOUNT_CODE       = P_ACCOUNT_CODE
        AND AC.ENABLED_FLAG       = 'Y'
        AND AC.EFFECTIVE_DATE_FR  <= P_SLIP_DATE
        AND (AC.EFFECTIVE_DATE_TO IS NULL OR AC.EFFECTIVE_DATE_TO >= P_SLIP_DATE)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ACCOUNT_CONTROL_ID := -1;
    END;
    IF V_ACCOUNT_CONTROL_ID = -1 THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10122', NULL);
      RETURN;
    END IF;    
    
    -- 계정 관리항목 검증.
    O_MESSAGE := FI_ACCOUNT_CONTROL_G.ACCOUNT_VALIDATE_F
                  ( P_SOB_ID              => P_SOB_ID
                  , P_ORG_ID              => P_ORG_ID
                  , P_ACCOUNT_CONTROL_ID  => V_ACCOUNT_CONTROL_ID
                  , P_ACCOUNT_CODE        => P_ACCOUNT_CODE
                  , P_ACCOUNT_DR_CR       => P_ACCOUNT_DR_CR
                  , P_MANAGEMENT1         => P_MANAGEMENT1
                  , P_MANAGEMENT2         => P_MANAGEMENT2
                  , P_REFER1              => P_REFER1
                  , P_REFER2              => P_REFER2
                  , P_REFER3              => P_REFER3
                  , P_REFER4              => P_REFER4
                  , P_REFER5              => P_REFER5
                  , P_REFER6              => P_REFER6
                  , P_REFER7              => P_REFER7
                  , P_REFER8              => P_REFER8
                  , P_REFER9              => P_REFER9
                  , P_REFER10             => P_REFER10
                  , P_REFER11             => P_REFER11
                  , P_REFER12             => P_REFER12
                  , P_REFER13             => NULL
                  );
    IF O_MESSAGE IS NOT NULL THEN
      RETURN;
    END IF;
    
    -- 통화.
    O_MESSAGE := NULL;
    IF P_CURRENCY_CODE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10124', NULL);
      RETURN;
    END IF;

    -- 기본통화외 환율 및 외화금액 검증.
    IF P_CURRENCY_CODE <> FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID) THEN
      IF NVL(P_EXCHANGE_RATE, 0) = 0 OR NVL(P_GL_CURRENCY_AMOUNT, 0) = 0 THEN
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10125', NULL);
        RETURN;
      END IF;
    END IF;
    
    -- 전표 순서.
    BEGIN
      SELECT NVL(MAX(SAI.SLIP_LINE_SEQ), 0) + 1 AS SLIP_LINE_SEQ
        INTO V_SLIP_LINE_SEQ
        FROM FI_SLIP_AUTO_INTERFACE_GT SAI
       WHERE SAI.MODULE_TYPE      = P_MODULE_TYPE
         AND SAI.SLIP_DATE        = P_SLIP_DATE
         AND SAI.SOB_ID           = P_SOB_ID
         AND SAI.ORG_ID           = P_ORG_ID
         AND SAI.CREATED_BY       = P_USER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SLIP_LINE_SEQ := 1;
    END;   
    -- 저장.
    INSERT INTO FI_SLIP_AUTO_INTERFACE_GT
    ( MODULE_TYPE
    , SLIP_DATE
    , SLIP_LINE_SEQ
    , SOB_ID
    , ORG_ID
    , DEPT_ID
    , PERSON_ID
    , BUDGET_DEPT_ID
    , ACCOUNT_BOOK_ID
    , SLIP_TYPE
    , HEADER_REMARK 
    , ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE
    , ACCOUNT_DR_CR
    , GL_AMOUNT
    , CURRENCY_CODE
    , EXCHANGE_RATE
    , GL_CURRENCY_AMOUNT
    , MANAGEMENT1
    , MANAGEMENT2
    , REFER1
    , REFER2
    , REFER3
    , REFER4
    , REFER5
    , REFER6
    , REFER7
    , REFER8
    , REFER9
    , REFER10
    , REFER11
    , REFER12
    , VOUCH_CODE
    , REFER_RATE
    , REFER_AMOUNT
    , REFER_DATE1
    , REFER_DATE2
    , REMARK
    , FUND_CODE
    , UNIT_PRICE
    , UOM_CODE
    , QUANTITY
    , WEIGHT
    , CREATED_BY
    ) VALUES
    ( P_MODULE_TYPE
    , P_SLIP_DATE
    , V_SLIP_LINE_SEQ
    , P_SOB_ID
    , P_ORG_ID
    , V_DEPT_ID
    , P_PERSON_ID
    , P_BUDGET_DEPT_ID
    , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(P_SOB_ID)  -- 운영회계장부.
    , V_SLIP_TYPE
    , P_HEADER_REMARK
    , V_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_ACCOUNT_DR_CR
    , P_GL_AMOUNT
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_GL_CURRENCY_AMOUNT
    , P_MANAGEMENT1
    , P_MANAGEMENT2
    , P_REFER1
    , P_REFER2
    , P_REFER3
    , P_REFER4
    , P_REFER5
    , P_REFER6
    , P_REFER7
    , P_REFER8
    , P_REFER9
    , P_REFER10
    , P_REFER11
    , P_REFER12
    , P_VOUCH_CODE
    , P_REFER_RATE
    , P_REFER_AMOUNT
    , P_REFER_DATE1
    , P_REFER_DATE2
    , P_REMARK
    , P_FUND_CODE
    , P_UNIT_PRICE
    , P_UOM_CODE
    , P_QUANTITY
    , P_WEIGHT
    , P_USER_ID
    );
    O_STATUS := 'S';
  END INSERT_SLIP_AUTO_INTERFACE;

-- 전표 생성 데이터 삭제.
  PROCEDURE DELETE_SLIP_AUTO_INTERFACE
  AS
  BEGIN
    DELETE  FROM FI_SLIP_AUTO_INTERFACE_GT SAI
    ;
  END DELETE_SLIP_AUTO_INTERFACE;

---------------------------------------------------------------------------------------------------
-- 전표 생성 데이터 삭제.
  PROCEDURE DELETE_SLIP_INTERFACE
            ( W_HEADER_ID           IN FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
  BEGIN
    O_STATUS := 'F';
    IF FI_SLIP_INTERFACE_G.SLIP_CONFIRM_YN_F(W_HEADER_ID) <> 'N' THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_F, 'FCM_10042', '&&VALUE:=Delete');
      RETURN;
    END IF;

    -- LINE 삭제.
    DELETE FI_SLIP_LINE_INTERFACE
    WHERE HEADER_INTERFACE_ID     = W_HEADER_ID
    ;
    -- HEADER 삭제.
    DELETE FI_SLIP_HEADER_INTERFACE
    WHERE HEADER_INTERFACE_ID = W_HEADER_ID;
    O_STATUS := 'S';
  END DELETE_SLIP_INTERFACE;
            
-- 전표 생성 데이터 삭제.
  PROCEDURE DELETE_SLIP_INTERFACE_1
            ( W_SLIP_NUM            IN FI_SLIP_HEADER_INTERFACE.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER_INTERFACE.SOB_ID%TYPE
            , O_STATUS              OUT VARCHAR2
            , O_MESSAGE             OUT VARCHAR2
            )
  AS
    V_HEADER_ID         FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT SHI.HEADER_INTERFACE_ID
        INTO V_HEADER_ID
        FROM FI_SLIP_HEADER_INTERFACE SHI
      WHERE SHI.SLIP_NUM          = W_SLIP_NUM
        AND SHI.SOB_ID            = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10239', NULL);
      RETURN;
    END;
    -- 전표 삭제.
    DELETE_SLIP_INTERFACE(V_HEADER_ID, O_STATUS, O_MESSAGE);
    
  END DELETE_SLIP_INTERFACE_1;
            
END FI_SLIP_AUTO_INTERFACE_G;
/
