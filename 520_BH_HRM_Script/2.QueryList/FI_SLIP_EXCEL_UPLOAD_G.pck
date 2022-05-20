CREATE OR REPLACE PACKAGE FI_SLIP_EXCEL_UPLOAD_G
AS

-- 엑셀 전표생성 대상 조회.
  PROCEDURE SELECT_SLIP_EXCEL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );

-- 엑셀 전표생성 양식 조회.
  PROCEDURE SELECT_SLIP_EXCEL_UPLOAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );
            
-- 엑셀 전표생성 내역 UPLOAD.
  PROCEDURE INSERT_EXCEL_UPLOAD
            ( P_SLIP_DATE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_EXCEL_UPLOAD.SLIP_NUM%TYPE
            , P_SLIP_LINE_SEQ       IN FI_SLIP_EXCEL_UPLOAD.SLIP_LINE_SEQ%TYPE
            , P_DEPT_CODE           IN FI_SLIP_EXCEL_UPLOAD.DEPT_CODE%TYPE
            , P_PERSON_NUM          IN FI_SLIP_EXCEL_UPLOAD.PERSON_NUM%TYPE
            , P_BUDGET_DEPT_CODE    IN FI_SLIP_EXCEL_UPLOAD.BUDGET_DEPT_CODE%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_TYPE%TYPE
            , P_GL_DATE             IN FI_SLIP_EXCEL_UPLOAD.GL_DATE%TYPE
            , P_GL_NUM              IN FI_SLIP_EXCEL_UPLOAD.GL_NUM%TYPE
            , P_HEADER_REMARK       IN FI_SLIP_EXCEL_UPLOAD.HEADER_REMARK%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DESC        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DESC%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_EXCEL_UPLOAD.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_EXCEL_UPLOAD.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_EXCEL_UPLOAD.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_EXCEL_UPLOAD.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_EXCEL_UPLOAD.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_EXCEL_UPLOAD.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_EXCEL_UPLOAD.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_EXCEL_UPLOAD.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_EXCEL_UPLOAD.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_EXCEL_UPLOAD.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_EXCEL_UPLOAD.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_EXCEL_UPLOAD.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_EXCEL_UPLOAD.REFER9%TYPE
            , P_REFER10             IN FI_SLIP_EXCEL_UPLOAD.REFER10%TYPE
            , P_REFER11             IN FI_SLIP_EXCEL_UPLOAD.REFER11%TYPE
            , P_REFER12             IN FI_SLIP_EXCEL_UPLOAD.REFER12%TYPE
            , P_REMARK              IN FI_SLIP_EXCEL_UPLOAD.REMARK%TYPE
            , P_SOB_ID              IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID             IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );

-- 엑셀 전표생성 양식 기존데이터 삭제.
  PROCEDURE DELETE_SLIP_EXCEL_UPLOAD
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );
            
-- 전표 생성 데이터 생성.
  PROCEDURE SET_SLIP_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

-- 전표 생성 데이터 취소(삭제).
  PROCEDURE CANCEL_SLIP_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- 엑셀 경비전표생성 대상 조회.
  PROCEDURE SELECT_SLIP_IF_EXCEL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );

-- 엑셀 전표생성 양식 조회.
  PROCEDURE SELECT_SLIP_IF_EXCEL_UPLOAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );
            
-- 엑셀 전표생성 내역 UPLOAD.
  PROCEDURE INSERT_SLIP_IF_EXCEL_UPLOAD
            ( P_SLIP_DATE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_EXCEL_UPLOAD.SLIP_NUM%TYPE
            , P_SLIP_LINE_SEQ       IN FI_SLIP_EXCEL_UPLOAD.SLIP_LINE_SEQ%TYPE
            , P_DEPT_CODE           IN FI_SLIP_EXCEL_UPLOAD.DEPT_CODE%TYPE
            , P_PERSON_NUM          IN FI_SLIP_EXCEL_UPLOAD.PERSON_NUM%TYPE
            , P_BUDGET_DEPT_CODE    IN FI_SLIP_EXCEL_UPLOAD.BUDGET_DEPT_CODE%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_TYPE%TYPE
            , P_HEADER_REMARK       IN FI_SLIP_EXCEL_UPLOAD.HEADER_REMARK%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DESC        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DESC%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_EXCEL_UPLOAD.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_EXCEL_UPLOAD.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_EXCEL_UPLOAD.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_EXCEL_UPLOAD.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_EXCEL_UPLOAD.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_EXCEL_UPLOAD.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_EXCEL_UPLOAD.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_EXCEL_UPLOAD.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_EXCEL_UPLOAD.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_EXCEL_UPLOAD.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_EXCEL_UPLOAD.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_EXCEL_UPLOAD.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_EXCEL_UPLOAD.REFER9%TYPE
            , P_REFER10             IN FI_SLIP_EXCEL_UPLOAD.REFER10%TYPE
            , P_REFER11             IN FI_SLIP_EXCEL_UPLOAD.REFER11%TYPE
            , P_REFER12             IN FI_SLIP_EXCEL_UPLOAD.REFER12%TYPE
            , P_REMARK              IN FI_SLIP_EXCEL_UPLOAD.REMARK%TYPE
            , P_SOB_ID              IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID             IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );

-- 엑셀 전표생성 양식 기존데이터 삭제.
  PROCEDURE DELETE_SLIP_IF_EXCEL_UPLOAD
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            );
            
-- 전표 생성 데이터 생성.
  PROCEDURE SET_SLIP_IF_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

-- 전표 생성 데이터 취소(삭제).
  PROCEDURE CANCEL_SLIP_IF_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

END FI_SLIP_EXCEL_UPLOAD_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SLIP_EXCEL_UPLOAD_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_SLIP_EXCEL_UPLOAD_G
/* Description  : 엑셀을 이용해 대량전표 및 대량경비전표 업로드.
/*
/* Reference by : 
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 엑셀 전표생성 대상 조회.
  PROCEDURE SELECT_SLIP_EXCEL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SEU.SLIP_DATE
           , SEU.SLIP_NUM
           , SEU.SLIP_LINE_SEQ
           , SEU.DEPT_CODE
           , DM1.DEPT_NAME
           , SEU.PERSON_NUM
           , PM.NAME
           , SEU.BUDGET_DEPT_CODE
           , DM2.DEPT_NAME AS BUDGET_DEPT_NAME
           , SEU.SLIP_TYPE
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SEU.SLIP_TYPE, SEU.SOB_ID) AS SLIP_TYPE_DESC
           , SEU.GL_DATE
           , SEU.GL_NUM
           , SEU.HEADER_REMARK
           , SEU.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SEU.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SEU.ACCOUNT_DR_CR, SEU.SOB_ID) AS ACCOUNT_DR_CR_DESC
           , SEU.GL_AMOUNT
           , SEU.CURRENCY_CODE
           , SEU.EXCHANGE_RATE
           , SEU.GL_CURRENCY_AMOUNT
           , SEU.MANAGEMENT1
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER1_ID'
                                                      , SEU.MANAGEMENT1
                                                      , SEU.SOB_ID) AS MANAGEMENT1_DESC
           , SEU.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER2_ID'
                                                      , SEU.MANAGEMENT2
                                                      , SEU.SOB_ID) AS MANAGEMENT2_DESC
           , SEU.REFER1
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER3_ID'
                                                      , SEU.REFER1
                                                      , SEU.SOB_ID) AS REFER1_DESC
           , SEU.REFER2
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER4_ID'
                                                      , SEU.REFER2
                                                      , SEU.SOB_ID) AS REFER2_DESC
           , SEU.REFER3
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER5_ID'
                                                      , SEU.REFER3
                                                      , SEU.SOB_ID) AS REFER3_DESC
           , SEU.REFER4
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER6_ID'
                                                      , SEU.REFER4
                                                      , SEU.SOB_ID) AS REFER4_DESC
           , SEU.REFER5
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER7_ID'
                                                      , SEU.REFER5
                                                      , SEU.SOB_ID) AS REFER5_DESC
           , SEU.REFER6
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER8_ID'
                                                      , SEU.REFER6
                                                      , SEU.SOB_ID) AS REFER6_DESC
           , SEU.REFER7
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER9_ID'
                                                      , SEU.REFER7
                                                      , SEU.SOB_ID) AS REFER7_DESC
           , SEU.REFER8
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER10_ID'
                                                      , SEU.REFER8
                                                      , SEU.SOB_ID) AS REFER8_DESC
           , SEU.REFER9
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER11_ID'
                                                      , SEU.REFER9
                                                      , SEU.SOB_ID) AS REFER9_DESC
           , SEU.REFER10
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER12_ID'
                                                      , SEU.REFER10
                                                      , SEU.SOB_ID) AS REFER10_DESC
           , SEU.REFER11
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER13_ID'
                                                      , SEU.REFER11
                                                      , SEU.SOB_ID) AS REFER11_DESC
           , SEU.REFER12
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER14_ID'
                                                      , SEU.REFER12
                                                      , SEU.SOB_ID) AS REFER12_DESC
           , SEU.REMARK
           , SEU.SLIP_YN
           , HRM_PERSON_MASTER_G.NAME_F(SEU.SLIP_PERSON_ID) AS SLIP_PERSON_NAME
        FROM FI_SLIP_EXCEL_UPLOAD SEU
          , FI_ACCOUNT_CONTROL AC
          , HRM_PERSON_MASTER PM
          , FI_DEPT_MASTER DM1
          , FI_DEPT_MASTER DM2
      WHERE SEU.ACCOUNT_CODE      = AC.ACCOUNT_CODE
        AND SEU.SOB_ID            = AC.SOB_ID
        AND SEU.PERSON_NUM        = PM.PERSON_NUM
        AND SEU.SOB_ID            = PM.SOB_ID
        AND SEU.ORG_ID            = PM.ORG_ID
        AND SEU.DEPT_CODE         = DM1.DEPT_CODE(+)
        AND SEU.SOB_ID            = DM1.SOB_ID(+)
        AND SEU.BUDGET_DEPT_CODE  = DM2.DEPT_CODE(+)
        AND SEU.SOB_ID            = DM2.SOB_ID(+)
        AND SEU.SOB_ID            = P_SOB_ID
        AND SEU.ORG_ID            = P_ORG_ID
        AND SEU.USER_ID           = P_USER_ID        
      ORDER BY SEU.SLIP_DATE
            , SEU.SLIP_NUM
            , SEU.SLIP_LINE_SEQ
      ;  
  END SELECT_SLIP_EXCEL;

-- 엑셀 전표생성 양식 조회.
  PROCEDURE SELECT_SLIP_EXCEL_UPLOAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SEU.SLIP_DATE
           , SEU.SLIP_NUM
           , SEU.SLIP_LINE_SEQ
           , SEU.DEPT_CODE
           , SEU.PERSON_NUM
           , SEU.BUDGET_DEPT_CODE
           , SEU.SLIP_TYPE
           , SEU.GL_DATE
           , SEU.GL_NUM
           , SEU.HEADER_REMARK
           , SEU.ACCOUNT_CODE
           , SEU.ACCOUNT_DESC
           , SEU.ACCOUNT_DR_CR
           , SEU.GL_AMOUNT
           , SEU.CURRENCY_CODE
           , SEU.EXCHANGE_RATE
           , SEU.GL_CURRENCY_AMOUNT
           , SEU.MANAGEMENT1
           , SEU.MANAGEMENT2
           , SEU.REFER1
           , SEU.REFER2
           , SEU.REFER3
           , SEU.REFER4
           , SEU.REFER5
           , SEU.REFER6
           , SEU.REFER7
           , SEU.REFER8
           , SEU.REFER9
           , SEU.REFER10
           , SEU.REFER11
           , SEU.REFER12
           , SEU.REMARK
        FROM FI_SLIP_EXCEL_UPLOAD SEU
      WHERE SEU.SOB_ID            = P_SOB_ID
        AND SEU.ORG_ID            = P_ORG_ID
        AND SEU.USER_ID           = P_USER_ID        
      ORDER BY SEU.SLIP_DATE
            , SEU.SLIP_NUM
            , SEU.SLIP_LINE_SEQ
      ;  
  END SELECT_SLIP_EXCEL_UPLOAD;

-- 엑셀 전표생성 내역 UPLOAD.
  PROCEDURE INSERT_EXCEL_UPLOAD
            ( P_SLIP_DATE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_EXCEL_UPLOAD.SLIP_NUM%TYPE
            , P_SLIP_LINE_SEQ       IN FI_SLIP_EXCEL_UPLOAD.SLIP_LINE_SEQ%TYPE
            , P_DEPT_CODE           IN FI_SLIP_EXCEL_UPLOAD.DEPT_CODE%TYPE
            , P_PERSON_NUM          IN FI_SLIP_EXCEL_UPLOAD.PERSON_NUM%TYPE
            , P_BUDGET_DEPT_CODE    IN FI_SLIP_EXCEL_UPLOAD.BUDGET_DEPT_CODE%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_TYPE%TYPE
            , P_GL_DATE             IN FI_SLIP_EXCEL_UPLOAD.GL_DATE%TYPE
            , P_GL_NUM              IN FI_SLIP_EXCEL_UPLOAD.GL_NUM%TYPE
            , P_HEADER_REMARK       IN FI_SLIP_EXCEL_UPLOAD.HEADER_REMARK%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DESC        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DESC%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_EXCEL_UPLOAD.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_EXCEL_UPLOAD.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_EXCEL_UPLOAD.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_EXCEL_UPLOAD.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_EXCEL_UPLOAD.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_EXCEL_UPLOAD.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_EXCEL_UPLOAD.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_EXCEL_UPLOAD.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_EXCEL_UPLOAD.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_EXCEL_UPLOAD.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_EXCEL_UPLOAD.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_EXCEL_UPLOAD.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_EXCEL_UPLOAD.REFER9%TYPE
            , P_REFER10             IN FI_SLIP_EXCEL_UPLOAD.REFER10%TYPE
            , P_REFER11             IN FI_SLIP_EXCEL_UPLOAD.REFER11%TYPE
            , P_REFER12             IN FI_SLIP_EXCEL_UPLOAD.REFER12%TYPE
            , P_REMARK              IN FI_SLIP_EXCEL_UPLOAD.REMARK%TYPE
            , P_SOB_ID              IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID             IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);    
  BEGIN
    INSERT INTO FI_SLIP_EXCEL_UPLOAD
    ( SLIP_DATE
    , SLIP_NUM 
    , SLIP_LINE_SEQ 
    , SOB_ID 
    , ORG_ID 
    , DEPT_CODE 
    , PERSON_NUM 
    , BUDGET_DEPT_CODE 
    , SLIP_TYPE 
    , GL_DATE 
    , GL_NUM 
    , HEADER_REMARK 
    , ACCOUNT_CODE 
    , ACCOUNT_DESC 
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
    , REMARK 
    , USER_ID 
    , CREATED_DATE 
    ) VALUES
    ( P_SLIP_DATE
    , P_SLIP_NUM
    , P_SLIP_LINE_SEQ
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPT_CODE
    , (P_PERSON_NUM)
    , P_BUDGET_DEPT_CODE
    , P_SLIP_TYPE
    , NVL(P_GL_DATE, P_SLIP_DATE)
    , P_GL_NUM
    , P_HEADER_REMARK
    , P_ACCOUNT_CODE
    , P_ACCOUNT_DESC
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
    , P_REMARK
    , P_USER_ID
    , V_SYSDATE
    );
  END INSERT_EXCEL_UPLOAD;

-- 엑셀 전표생성 양식 기존데이터 삭제.
  PROCEDURE DELETE_SLIP_EXCEL_UPLOAD
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM FI_SLIP_EXCEL_UPLOAD SEU
    WHERE SEU.SOB_ID              = P_SOB_ID
      AND SEU.ORG_ID              = P_ORG_ID
      AND SEU.USER_ID             = P_USER_ID
    ;  
  END DELETE_SLIP_EXCEL_UPLOAD;
  
-- 전표 생성 데이터 생성.
  PROCEDURE SET_SLIP_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SLIP_NUM            VARCHAR2(20);
    
    V_SLIP_HEADER_ID      NUMBER;  -- 전표 헤더 ID.
    V_SLIP_LINE_ID        NUMBER;  -- 전표 라인 ID.
    
    V_DR_AMOUNT           NUMBER;  -- 차변금액.
    V_CR_AMOUNT           NUMBER;  -- 대변금액.
  BEGIN
    O_STATUS := 'F';  -- S:성공, F:실패.
    FOR C1 IN ( SELECT SEU.SLIP_DATE
                     , SEU.SLIP_NUM     -- 전표 헤더 생성 단위.
                     , SEU.SOB_ID
                     , SEU.ORG_ID
                     , DM.M_DEPT_ID AS DEPT_ID
                     , PM.PERSON_ID
                     , NULL AS BUDGET_DEPT_ID
                     , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(SEU.SOB_ID) AS ACCOUNT_BOOK_ID
                     , SEU.SLIP_TYPE
                     , NVL(SEU.GL_DATE, SEU.SLIP_DATE) AS GL_DATE
                     , SEU.GL_NUM
                     , MAX(SEU.HEADER_REMARK) AS HEADER_REMARK
                     , SUM(DECODE(SEU.ACCOUNT_DR_CR, '1', SEU.GL_AMOUNT, 0)) AS GL_AMOUNT
                     , FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(SEU.SOB_ID) CURRENCY_CODE
                     , MAX(SEU.EXCHANGE_RATE) EXCHANGE_RATE
                     , SUM(DECODE(SEU.ACCOUNT_DR_CR, '1', SEU.GL_CURRENCY_AMOUNT, 0)) AS GL_CURRENCY_AMOUNT
                     , SEU.USER_ID
                  FROM FI_SLIP_EXCEL_UPLOAD SEU
                  , HRM_PERSON_MASTER PM
                  , ( SELECT HDM.HR_DEPT_ID
                           , HDM.M_DEPT_ID
                        FROM HRM_DEPT_MAPPING HDM
                      WHERE HDM.MODULE_TYPE     = 'FCM'
                    ) DM
                WHERE SEU.PERSON_NUM                = PM.PERSON_NUM
                  AND SEU.SOB_ID                    = PM.SOB_ID
                  AND PM.DEPT_ID                    = DM.HR_DEPT_ID
                  AND SEU.SOB_ID                    = P_SOB_ID
                  AND SEU.ORG_ID                    = P_ORG_ID
                  AND SEU.USER_ID                   = P_USER_ID
                  AND SEU.SLIP_YN                   = 'N'
                GROUP BY SEU.SLIP_DATE
                     , SEU.SLIP_NUM 
                     , SEU.SOB_ID
                     , SEU.ORG_ID
                     , DM.M_DEPT_ID
                     , PM.PERSON_ID
                     , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(SEU.SOB_ID)
                     , SEU.SLIP_TYPE
                     , NVL(SEU.GL_DATE, SEU.SLIP_DATE)
                     , SEU.GL_NUM
                     , SEU.USER_ID
               ORDER BY SEU.SLIP_DATE, SEU.SLIP_NUM
               )
    LOOP
      -- 전표일자.
      IF C1.GL_DATE IS NULL THEN
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10187', NULL);
        RETURN;
      END IF;
      -- 기간 오픈 검증.
      IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, C1.GL_DATE, C1.SOB_ID, C1.ORG_ID) IN('C', 'N') THEN
        O_MESSAGE := ERRNUMS.Data_Not_Opened_Desc;
        RETURN;
      END IF;      
      V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', C1.SOB_ID, C1.GL_DATE, C1.USER_ID); 
      
      BEGIN
        -- 회계전표 INSERT.
        FI_SLIP_G.INSERT_SLIP_HEADER
                    ( P_SLIP_HEADER_ID      => V_SLIP_HEADER_ID
                    , P_SLIP_DATE           => C1.SLIP_DATE
                    , P_SLIP_NUM            => V_SLIP_NUM
                    , P_SOB_ID              => C1.SOB_ID
                    , P_ORG_ID              => C1.ORG_ID 
                    , P_DEPT_ID             => C1.DEPT_ID
                    , P_PERSON_ID           => C1.PERSON_ID
                    , P_BUDGET_DEPT_ID      => C1.BUDGET_DEPT_ID
                    , P_SLIP_TYPE           => C1.SLIP_TYPE
                    , P_GL_DATE             => C1.GL_DATE
                    , P_GL_NUM              => V_SLIP_NUM 
                    , P_REQ_BANK_ACCOUNT_ID => NULL
                    , P_REQ_PAYABLE_TYPE    => NULL
                    , P_REQ_PAYABLE_DATE    => NULL
                    , P_REMARK              => C1.HEADER_REMARK
                    , P_USER_ID             => C1.USER_ID
                    , P_CREATED_TYPE        => 'UPLOAD'
                    , P_SOURCE_TABLE        => 'EXCEL'
                    , P_SOURCE_HEADER_ID    => NULL
                    );
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Insert Header Error : SLIP NUM : ' || V_SLIP_NUM || '-' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      
      -- 전표 헤더 정보 UPDATE --
      UPDATE FI_SLIP_EXCEL_UPLOAD SEU
        SET SEU.SLIP_NUM                  = V_SLIP_NUM
          , SEU.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
          , SEU.GL_NUM                    = V_SLIP_NUM
          , SEU.SLIP_YN                   = 'Y'
          , SEU.SLIP_PERSON_ID            = P_CONNECT_PERSON_ID
      WHERE SEU.SLIP_DATE                 = C1.SLIP_DATE
        AND SEU.SLIP_NUM                  = C1.SLIP_NUM
        AND SEU.SOB_ID                    = C1.SOB_ID
        AND SEU.USER_ID                   = C1.USER_ID
      ;
      
      -- 차대금액 검증 --
      V_DR_AMOUNT := 0;
      V_CR_AMOUNT := 0;
      BEGIN
        SELECT SUM(DECODE(SEU.ACCOUNT_DR_CR, '1', NVL(SEU.GL_AMOUNT, 0), 0)) AS DR_AMOUNT
             , SUM(DECODE(SEU.ACCOUNT_DR_CR, '2', NVL(SEU.GL_AMOUNT, 0), 0)) AS CR_AMOUNT
          INTO V_DR_AMOUNT
             , V_CR_AMOUNT
          FROM FI_SLIP_EXCEL_UPLOAD SEU
            , FI_ACCOUNT_CONTROL AC
        WHERE SEU.ACCOUNT_CODE              = AC.ACCOUNT_CODE
          AND SEU.SOB_ID                    = AC.SOB_ID
          AND SEU.SLIP_DATE                 = C1.SLIP_DATE
          AND SEU.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
          AND SEU.USER_ID                   = C1.USER_ID
          AND SEU.SLIP_YN                   = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DR_AMOUNT := -1;
        V_CR_AMOUNT := 0;
      END;
      IF V_DR_AMOUNT <> V_CR_AMOUNT THEN
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10249', '&&AMOUNT:= ' || ABS(NVL(V_DR_AMOUNT, 0) - NVL(V_CR_AMOUNT, 0)));
        RETURN;
      END IF;
      
      -- LINE INSERT.
      FOR R1 IN ( SELECT SEU.SLIP_NUM
                       , SEU.SLIP_LINE_SEQ
                       , SEU.SLIP_HEADER_ID
                       , SEU.SLIP_TYPE
                       , DM.DEPT_ID AS BUDGET_DEPT_ID
                       , SEU.BUDGET_DEPT_CODE
                       , DM.DEPT_NAME AS BUDGET_DEPT_NAME
                       , SEU.GL_NUM
                       , AC.ACCOUNT_CONTROL_ID
                       , SEU.ACCOUNT_CODE
                       , SEU.ACCOUNT_DR_CR     
                       , SEU.GL_AMOUNT AS GL_AMOUNT
                       , SEU.CURRENCY_CODE
                       , SEU.EXCHANGE_RATE AS EXCHANGE_RATE
                       , SEU.GL_CURRENCY_AMOUNT AS GL_CURRENCY_AMOUNT
                       , REPLACE(SEU.MANAGEMENT1, ',', '') AS MANAGEMENT1
                       , REPLACE(SEU.MANAGEMENT2, ',', '') AS MANAGEMENT2
                       , REPLACE(SEU.REFER1, ',', '') AS REFER1
                       , REPLACE(SEU.REFER2, ',', '') AS REFER2
                       , REPLACE(SEU.REFER3, ',', '') AS REFER3
                       , REPLACE(SEU.REFER4, ',', '') AS REFER4
                       , REPLACE(SEU.REFER5, ',', '') AS REFER5
                       , REPLACE(SEU.REFER6, ',', '') AS REFER6
                       , REPLACE(SEU.REFER7, ',', '') AS REFER7
                       , REPLACE(SEU.REFER8, ',', '') AS REFER8
                       , REPLACE(SEU.REFER9, ',', '') AS REFER9
                       , REPLACE(SEU.REFER10, ',', '') AS REFER10
                       , REPLACE(SEU.REFER11, ',', '') AS REFER11
                       , REPLACE(SEU.REFER12, ',', '') AS REFER12
                       , SEU.REMARK
                    FROM FI_SLIP_EXCEL_UPLOAD SEU
                       , FI_ACCOUNT_CONTROL AC
                       , FI_DEPT_MASTER DM
                  WHERE SEU.ACCOUNT_CODE              = AC.ACCOUNT_CODE
                    AND SEU.SOB_ID                    = AC.SOB_ID
                    AND SEU.BUDGET_DEPT_CODE          = DM.DEPT_CODE(+)
                    AND SEU.SOB_ID                    = DM.SOB_ID(+)
                    AND SEU.SLIP_DATE                 = C1.SLIP_DATE
                    AND SEU.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
                    AND SEU.SOB_ID                    = C1.SOB_ID
                    AND SEU.ORG_ID                    = C1.ORG_ID
                    AND SEU.USER_ID                   = C1.USER_ID
                    AND SEU.SLIP_YN                   = 'Y'
                  ORDER BY SEU.SLIP_LINE_SEQ  
                 )
      LOOP
        BEGIN
          -- 회계전표 라인 INSERT.
          FI_SLIP_G.INSERT_SLIP_LINE
                  ( P_SLIP_LINE_ID               => V_SLIP_LINE_ID
                  , P_SLIP_HEADER_ID             => V_SLIP_HEADER_ID
                  , P_SOB_ID                     => C1.SOB_ID
                  , P_ORG_ID                     => C1.ORG_ID
                  , P_ACCOUNT_CONTROL_ID         => R1.ACCOUNT_CONTROL_ID
                  , P_ACCOUNT_CODE               => R1.ACCOUNT_CODE
                  , P_ACCOUNT_DR_CR              => R1.ACCOUNT_DR_CR
                  , P_GL_AMOUNT                  => R1.GL_AMOUNT
                  , P_CURRENCY_CODE              => R1.CURRENCY_CODE
                  , P_EXCHANGE_RATE              => R1.EXCHANGE_RATE
                  , P_GL_CURRENCY_AMOUNT         => R1.GL_CURRENCY_AMOUNT
                  , P_MANAGEMENT1                => R1.MANAGEMENT1
                  , P_MANAGEMENT2                => R1.MANAGEMENT2
                  , P_REFER1                     => R1.REFER1
                  , P_REFER2                     => R1.REFER2
                  , P_REFER3                     => R1.REFER3
                  , P_REFER4                     => R1.REFER4
                  , P_REFER5                     => R1.REFER5
                  , P_REFER6                     => R1.REFER6
                  , P_REFER7                     => R1.REFER7
                  , P_REFER8                     => R1.REFER8
                  , P_REFER9                     => R1.REFER9
                  , P_REFER10                    => R1.REFER10
                  , P_REFER11                    => R1.REFER11
                  , P_REFER12                    => R1.REFER12
                  , P_REMARK                     => R1.REMARK
                  , P_UNLIQUIDATE_SLIP_HEADER_ID => NULL
                  , P_UNLIQUIDATE_SLIP_LINE_ID   => NULL
                  , P_USER_ID                    => C1.USER_ID
                  , P_LINE_TYPE                  => 'UPLOAD'
                  , P_SOURCE_TABLE               => 'EXCEL'
                  , P_SOURCE_HEADER_ID           => NULL
                  , P_SOURCE_LINE_ID             => NULL
                  );
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Insert LINE Error : Slip Date(' || C1.SLIP_DATE || '), LINE SEQ(' || R1.SLIP_LINE_SEQ || '), ACCOUNT CODE(' || R1.ACCOUNT_CODE || ')-' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;
      END LOOP R1;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);    
  END SET_SLIP_TRANSFER;

-- 전표 생성 데이터 취소(삭제).
  PROCEDURE CANCEL_SLIP_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SLIP_NUM                    NUMBER;
  BEGIN
    O_STATUS := 'F';
    V_SLIP_NUM := 0;
    FOR C1 IN ( SELECT DISTINCT SEU.SLIP_DATE
                     , SEU.GL_DATE
                     , SEU.SLIP_NUM     -- 전표 헤더 생성 단위.
                     , SEU.SLIP_HEADER_ID  -- 예산전표 헤더 ID.
                     , SEU.SOB_ID
                     , SEU.ORG_ID
                     , SEU.USER_ID
                  FROM FI_SLIP_EXCEL_UPLOAD SEU
                WHERE SEU.SOB_ID                    = P_SOB_ID
                  AND SEU.ORG_ID                    = P_ORG_ID
                  AND SEU.USER_ID                   = P_USER_ID
                  AND SEU.SLIP_YN                   = 'Y'
               ORDER BY SEU.SLIP_NUM
              )
    LOOP
      -- 전표 DATA 검증 및 삭제 --
      IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, C1.GL_DATE, C1.SOB_ID, C1.ORG_ID) IN('C', 'N') THEN
        O_STATUS := 'F';
        O_MESSAGE := ERRNUMS.Data_Not_Opened_Desc;      
        RETURN;
      END IF;
      
      /* -- 전호수 주석 : 회계전표와 동일하게 적용 하므로 마감 여부 체크 안함 --
      IF FI_SLIP_G.SLIP_CLOSE_YN_F(FI_SLIP_BUDGET_G.SLIP_HEADER_ID_F(C1.SLIP_HEADER_ID)) <> 'N' THEN
        O_STATUS := 'F';
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115');
        RETURN;
      END IF;*/
      
      BEGIN
        -- 회계 전표 라인 삭제.
        DELETE FI_SLIP_LINE SL
        WHERE SL.SLIP_HEADER_ID       = C1.SLIP_HEADER_ID
        ;
        
        -- 회계 전표 헤더 삭제.
        DELETE FI_SLIP_HEADER SH
        WHERE SH.SLIP_HEADER_ID       = C1.SLIP_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 200);
        RETURN;
      END; 
      
      -- 엑셀 업로드 자료 수정 --
      V_SLIP_NUM := NVL(V_SLIP_NUM, 0) + 1;
      BEGIN
        UPDATE FI_SLIP_EXCEL_UPLOAD SEU
          SET SEU.SLIP_NUM                  = V_SLIP_NUM
            , SEU.SLIP_HEADER_ID            = NULL
            , SEU.GL_NUM                    = NULL
            , SEU.SLIP_YN                   = 'N'
            , SEU.SLIP_PERSON_ID            = P_CONNECT_PERSON_ID
        WHERE SEU.SLIP_HEADER_ID            = C1.SLIP_HEADER_ID
          AND SEU.SOB_ID                    = C1.SOB_ID
          AND SEU.ORG_ID                    = C1.ORG_ID
          AND SEU.USER_ID                   = C1.USER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
  END CANCEL_SLIP_TRANSFER;


---------------------------------------------------------------------------------------------------
-- 엑셀 경비전표생성 대상 조회.
  PROCEDURE SELECT_SLIP_IF_EXCEL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SEU.SLIP_DATE
           , SEU.SLIP_NUM
           , SEU.SLIP_LINE_SEQ
           , SEU.DEPT_CODE
           , DM1.DEPT_NAME
           , SEU.PERSON_NUM
           , PM.NAME
           , SEU.BUDGET_DEPT_CODE
           , DM2.DEPT_NAME AS BUDGET_DEPT_NAME
           , SEU.SLIP_TYPE
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SEU.SLIP_TYPE, SEU.SOB_ID) AS SLIP_TYPE_DESC
           , SEU.HEADER_REMARK
           , SEU.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SEU.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SEU.ACCOUNT_DR_CR, SEU.SOB_ID) AS ACCOUNT_DR_CR_DESC
           , SEU.GL_AMOUNT
           , SEU.CURRENCY_CODE
           , SEU.EXCHANGE_RATE
           , SEU.GL_CURRENCY_AMOUNT
           , SEU.MANAGEMENT1
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER1_ID'
                                                      , SEU.MANAGEMENT1
                                                      , SEU.SOB_ID) AS MANAGEMENT1_DESC
           , SEU.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER2_ID'
                                                      , SEU.MANAGEMENT2
                                                      , SEU.SOB_ID) AS MANAGEMENT2_DESC
           , SEU.REFER1
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER3_ID'
                                                      , SEU.REFER1
                                                      , SEU.SOB_ID) AS REFER1_DESC
           , SEU.REFER2
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER4_ID'
                                                      , SEU.REFER2
                                                      , SEU.SOB_ID) AS REFER2_DESC
           , SEU.REFER3
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER5_ID'
                                                      , SEU.REFER3
                                                      , SEU.SOB_ID) AS REFER3_DESC
           , SEU.REFER4
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER6_ID'
                                                      , SEU.REFER4
                                                      , SEU.SOB_ID) AS REFER4_DESC
           , SEU.REFER5
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER7_ID'
                                                      , SEU.REFER5
                                                      , SEU.SOB_ID) AS REFER5_DESC
           , SEU.REFER6
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER8_ID'
                                                      , SEU.REFER6
                                                      , SEU.SOB_ID) AS REFER6_DESC
           , SEU.REFER7
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER9_ID'
                                                      , SEU.REFER7
                                                      , SEU.SOB_ID) AS REFER7_DESC
           , SEU.REFER8
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER10_ID'
                                                      , SEU.REFER8
                                                      , SEU.SOB_ID) AS REFER8_DESC
           , SEU.REFER9
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER11_ID'
                                                      , SEU.REFER9
                                                      , SEU.SOB_ID) AS REFER9_DESC
           , SEU.REFER10
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER12_ID'
                                                      , SEU.REFER10
                                                      , SEU.SOB_ID) AS REFER10_DESC
           , SEU.REFER11
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER13_ID'
                                                      , SEU.REFER11
                                                      , SEU.SOB_ID) AS REFER11_DESC
           , SEU.REFER12
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( AC.ACCOUNT_CONTROL_ID
                                                      , 'REFER14_ID'
                                                      , SEU.REFER12
                                                      , SEU.SOB_ID) AS REFER12_DESC
           , SEU.REMARK
           , SEU.SLIP_YN
           , DECODE(SEU.SLIP_YN, 'Y', HRM_PERSON_MASTER_G.NAME_F(SEU.SLIP_PERSON_ID), NULL) AS SLIP_PERSON_NAME
        FROM FI_SLIP_EXCEL_UPLOAD SEU
          , FI_ACCOUNT_CONTROL AC
          , HRM_PERSON_MASTER PM
          , FI_DEPT_MASTER DM1
          , FI_DEPT_MASTER DM2
      WHERE SEU.ACCOUNT_CODE      = AC.ACCOUNT_CODE
        AND SEU.SOB_ID            = AC.SOB_ID
        AND SEU.PERSON_NUM        = PM.PERSON_NUM
        AND SEU.SOB_ID            = PM.SOB_ID
        AND SEU.ORG_ID            = PM.ORG_ID
        AND SEU.DEPT_CODE         = DM1.DEPT_CODE(+)
        AND SEU.SOB_ID            = DM1.SOB_ID(+)
        AND SEU.BUDGET_DEPT_CODE  = DM2.DEPT_CODE(+)
        AND SEU.SOB_ID            = DM2.SOB_ID(+)
        AND SEU.SOB_ID            = P_SOB_ID
        AND SEU.ORG_ID            = P_ORG_ID
        AND SEU.USER_ID           = P_USER_ID        
      ORDER BY SEU.SLIP_DATE
            , SEU.SLIP_NUM
            , SEU.SLIP_LINE_SEQ
      ;  
  END SELECT_SLIP_IF_EXCEL;

-- 엑셀 경비전표생성 양식 조회.
  PROCEDURE SELECT_SLIP_IF_EXCEL_UPLOAD
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SEU.SLIP_DATE
           , SEU.SLIP_NUM
           , SEU.SLIP_LINE_SEQ
           , SEU.DEPT_CODE
           , SEU.PERSON_NUM
           , SEU.BUDGET_DEPT_CODE
           , SEU.SLIP_TYPE
           , SEU.HEADER_REMARK
           , SEU.ACCOUNT_CODE
           , SEU.ACCOUNT_DESC
           , SEU.ACCOUNT_DR_CR
           , SEU.GL_AMOUNT
           , SEU.CURRENCY_CODE
           , SEU.EXCHANGE_RATE
           , SEU.GL_CURRENCY_AMOUNT
           , SEU.MANAGEMENT1
           , SEU.MANAGEMENT2
           , SEU.REFER1
           , SEU.REFER2
           , SEU.REFER3
           , SEU.REFER4
           , SEU.REFER5
           , SEU.REFER6
           , SEU.REFER7
           , SEU.REFER8
           , SEU.REFER9
           , SEU.REFER10
           , SEU.REFER11
           , SEU.REFER12
           , SEU.REMARK
        FROM FI_SLIP_EXCEL_UPLOAD SEU
      WHERE SEU.SOB_ID            = P_SOB_ID
        AND SEU.ORG_ID            = P_ORG_ID
        AND SEU.USER_ID           = P_USER_ID        
      ORDER BY SEU.SLIP_DATE
            , SEU.SLIP_NUM
            , SEU.SLIP_LINE_SEQ
      ;  
  END SELECT_SLIP_IF_EXCEL_UPLOAD;

-- 엑셀 경비전표생성 내역 UPLOAD.
  PROCEDURE INSERT_SLIP_IF_EXCEL_UPLOAD
            ( P_SLIP_DATE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_EXCEL_UPLOAD.SLIP_NUM%TYPE
            , P_SLIP_LINE_SEQ       IN FI_SLIP_EXCEL_UPLOAD.SLIP_LINE_SEQ%TYPE
            , P_DEPT_CODE           IN FI_SLIP_EXCEL_UPLOAD.DEPT_CODE%TYPE
            , P_PERSON_NUM          IN FI_SLIP_EXCEL_UPLOAD.PERSON_NUM%TYPE
            , P_BUDGET_DEPT_CODE    IN FI_SLIP_EXCEL_UPLOAD.BUDGET_DEPT_CODE%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_EXCEL_UPLOAD.SLIP_TYPE%TYPE
            , P_HEADER_REMARK       IN FI_SLIP_EXCEL_UPLOAD.HEADER_REMARK%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DESC        IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DESC%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_EXCEL_UPLOAD.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_EXCEL_UPLOAD.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_EXCEL_UPLOAD.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_EXCEL_UPLOAD.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_EXCEL_UPLOAD.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_EXCEL_UPLOAD.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_EXCEL_UPLOAD.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_EXCEL_UPLOAD.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_EXCEL_UPLOAD.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_EXCEL_UPLOAD.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_EXCEL_UPLOAD.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_EXCEL_UPLOAD.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_EXCEL_UPLOAD.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_EXCEL_UPLOAD.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_EXCEL_UPLOAD.REFER9%TYPE
            , P_REFER10             IN FI_SLIP_EXCEL_UPLOAD.REFER10%TYPE
            , P_REFER11             IN FI_SLIP_EXCEL_UPLOAD.REFER11%TYPE
            , P_REFER12             IN FI_SLIP_EXCEL_UPLOAD.REFER12%TYPE
            , P_REMARK              IN FI_SLIP_EXCEL_UPLOAD.REMARK%TYPE
            , P_SOB_ID              IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID             IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);    
  BEGIN
    INSERT INTO FI_SLIP_EXCEL_UPLOAD
    ( SLIP_DATE
    , SLIP_NUM 
    , SLIP_LINE_SEQ 
    , SOB_ID 
    , ORG_ID 
    , DEPT_CODE 
    , PERSON_NUM 
    , BUDGET_DEPT_CODE 
    , SLIP_TYPE 
    , HEADER_REMARK 
    , ACCOUNT_CODE 
    , ACCOUNT_DESC 
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
    , REMARK 
    , USER_ID 
    , CREATED_DATE 
    ) VALUES
    ( P_SLIP_DATE
    , P_SLIP_NUM
    , P_SLIP_LINE_SEQ
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPT_CODE
    , P_PERSON_NUM
    , P_BUDGET_DEPT_CODE
    , P_SLIP_TYPE
    , P_HEADER_REMARK
    , P_ACCOUNT_CODE
    , P_ACCOUNT_DESC
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
    , P_REMARK
    , P_USER_ID
    , V_SYSDATE
    );
  END INSERT_SLIP_IF_EXCEL_UPLOAD;

-- 엑셀 경비전표생성 양식 기존데이터 삭제.
  PROCEDURE DELETE_SLIP_IF_EXCEL_UPLOAD
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM FI_SLIP_EXCEL_UPLOAD SEU
    WHERE SEU.SOB_ID              = P_SOB_ID
      AND SEU.ORG_ID              = P_ORG_ID
      AND SEU.USER_ID             = P_USER_ID
    ;  
  END DELETE_SLIP_IF_EXCEL_UPLOAD;
  
-- 경비전표 생성 데이터 생성.
  PROCEDURE SET_SLIP_IF_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SLIP_NUM            VARCHAR2(20);
    
    V_SLIP_HEADER_ID      NUMBER;  -- 전표 헤더 ID.
    V_SLIP_LINE_ID        NUMBER;  -- 전표 라인 ID.
    
    V_DR_AMOUNT           NUMBER;  -- 차변금액.
    V_CR_AMOUNT           NUMBER;  -- 대변금액.
  BEGIN
    O_STATUS := 'F';  -- S:성공, F:실패.
    
    FOR C1 IN ( SELECT SEU.SLIP_DATE
                     , SEU.SLIP_NUM     -- 전표 헤더 생성 단위.
                     , SEU.SOB_ID
                     , SEU.ORG_ID
                     , DM.M_DEPT_ID AS DEPT_ID
                     , PM.PERSON_ID
                     , NULL AS BUDGET_DEPT_ID
                     , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(SEU.SOB_ID) AS ACCOUNT_BOOK_ID
                     , SEU.SLIP_TYPE
                     , MAX(SEU.HEADER_REMARK) AS HEADER_REMARK
                     , SUM(DECODE(SEU.ACCOUNT_DR_CR, '1', SEU.GL_AMOUNT, 0)) AS GL_AMOUNT
                     , FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(SEU.SOB_ID) CURRENCY_CODE
                     , MAX(SEU.EXCHANGE_RATE) EXCHANGE_RATE
                     , SUM(DECODE(SEU.ACCOUNT_DR_CR, '1', SEU.GL_CURRENCY_AMOUNT, 0)) AS GL_CURRENCY_AMOUNT
                     , SEU.USER_ID
                  FROM FI_SLIP_EXCEL_UPLOAD SEU
                  , HRM_PERSON_MASTER PM
                  , ( SELECT HDM.HR_DEPT_ID
                           , HDM.M_DEPT_ID
                        FROM HRM_DEPT_MAPPING HDM
                      WHERE HDM.MODULE_TYPE     = 'FCM'
                    ) DM
                WHERE SEU.PERSON_NUM                = PM.PERSON_NUM
                  AND SEU.SOB_ID                    = PM.SOB_ID
                  AND PM.DEPT_ID                    = DM.HR_DEPT_ID
                  AND SEU.SOB_ID                    = P_SOB_ID
                  AND SEU.ORG_ID                    = P_ORG_ID
                  AND SEU.USER_ID                   = P_USER_ID
                  AND SEU.SLIP_YN                   = 'N'
                GROUP BY SEU.SLIP_DATE
                     , SEU.SLIP_NUM 
                     , SEU.SOB_ID
                     , SEU.ORG_ID
                     , DM.M_DEPT_ID
                     , PM.PERSON_ID
                     , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(SEU.SOB_ID)
                     , SEU.SLIP_TYPE
                     , SEU.USER_ID
               ORDER BY SEU.SLIP_DATE, SEU.SLIP_NUM
               )
    LOOP
      -- 전표일자.
      IF C1.SLIP_DATE IS NULL THEN
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10187', NULL);
        RETURN;
      END IF;
      -- 기간 오픈 검증.
      IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, C1.SLIP_DATE, C1.SOB_ID, C1.ORG_ID) IN('C', 'N') THEN
        O_MESSAGE := ERRNUMS.Data_Not_Opened_Desc;
        RETURN;
      END IF; 
      V_SLIP_NUM := FI_DOCUMENT_NUM_G.DOCUMENT_NUM_F('GL', C1.SOB_ID, C1.SLIP_DATE, C1.USER_ID); 
      
      BEGIN
        -- 경비전표 INSERT.
        FI_SLIP_INTERFACE_G.INSERT_HEADER_IF
                    ( P_HEADER_INTERFACE_ID => V_SLIP_HEADER_ID
                    , P_SLIP_DATE           => C1.SLIP_DATE
                    , P_SLIP_NUM            => V_SLIP_NUM
                    , P_SOB_ID              => C1.SOB_ID
                    , P_ORG_ID              => C1.ORG_ID 
                    , P_DEPT_ID             => C1.DEPT_ID
                    , P_PERSON_ID           => C1.PERSON_ID
                    , P_BUDGET_DEPT_ID      => C1.BUDGET_DEPT_ID
                    , P_SLIP_TYPE           => C1.SLIP_TYPE
                    , P_JOURNAL_HEADER_ID   => NULL
                    , P_REQ_BANK_ACCOUNT_ID => NULL
                    , P_REQ_PAYABLE_TYPE    => NULL
                    , P_REQ_PAYABLE_DATE    => NULL
                    , P_REMARK              => C1.HEADER_REMARK
                    , P_SUBSTANCE           => NULL
                    , P_SOURCE_TABLE        => 'EXCEL'
                    , P_CREATED_TYPE        => 'UPLOAD'
                    , P_USER_ID             => C1.USER_ID
                    );
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Insert Header Error : SLIP NUM : ' || V_SLIP_NUM || '-' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
      
      -- 전표 헤더 정보 UPDATE --
      UPDATE FI_SLIP_EXCEL_UPLOAD SEU
        SET SEU.SLIP_NUM                  = V_SLIP_NUM
          , SEU.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
          , SEU.GL_NUM                    = V_SLIP_NUM
          , SEU.SLIP_YN                   = 'Y'
          , SEU.SLIP_PERSON_ID            = P_CONNECT_PERSON_ID
      WHERE SEU.SLIP_DATE                 = C1.SLIP_DATE
        AND SEU.SLIP_NUM                  = C1.SLIP_NUM
        AND SEU.SOB_ID                    = C1.SOB_ID
        AND SEU.USER_ID                   = C1.USER_ID
      ;
      
      -- 차대금액 검증 --
      V_DR_AMOUNT := 0;
      V_CR_AMOUNT := 0;
      BEGIN
        SELECT SUM(DECODE(SEU.ACCOUNT_DR_CR, '1', NVL(SEU.GL_AMOUNT, 0), 0)) AS DR_AMOUNT
             , SUM(DECODE(SEU.ACCOUNT_DR_CR, '2', NVL(SEU.GL_AMOUNT, 0), 0)) AS CR_AMOUNT
          INTO V_DR_AMOUNT
             , V_CR_AMOUNT
          FROM FI_SLIP_EXCEL_UPLOAD SEU
            , FI_ACCOUNT_CONTROL AC
        WHERE SEU.ACCOUNT_CODE              = AC.ACCOUNT_CODE
          AND SEU.SOB_ID                    = AC.SOB_ID
          AND SEU.SLIP_DATE                 = C1.SLIP_DATE
          AND SEU.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
          AND SEU.USER_ID                   = C1.USER_ID
          AND SEU.SLIP_YN                   = 'Y'
        ;
      EXCEPTION WHEN OTHERS THEN
        V_DR_AMOUNT := -1;
        V_CR_AMOUNT := 0;
      END;
      IF V_DR_AMOUNT <> V_CR_AMOUNT THEN
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10249', '&&AMOUNT:= ' || ABS(NVL(V_DR_AMOUNT, 0) - NVL(V_CR_AMOUNT, 0)));
        RETURN;
      END IF;
      
      -- LINE INSERT.
      FOR R1 IN ( SELECT SEU.SLIP_NUM
                       , SEU.SLIP_LINE_SEQ
                       , SEU.SLIP_HEADER_ID
                       , SEU.SLIP_TYPE
                       , DM.DEPT_ID AS BUDGET_DEPT_ID
                       , SEU.BUDGET_DEPT_CODE
                       , DM.DEPT_NAME AS BUDGET_DEPT_NAME
                       , SEU.GL_NUM
                       , AC.ACCOUNT_CONTROL_ID
                       , SEU.ACCOUNT_CODE
                       , SEU.ACCOUNT_DR_CR     
                       , SEU.GL_AMOUNT AS GL_AMOUNT
                       , SEU.CURRENCY_CODE
                       , SEU.EXCHANGE_RATE AS EXCHANGE_RATE
                       , SEU.GL_CURRENCY_AMOUNT AS GL_CURRENCY_AMOUNT
                       , REPLACE(SEU.MANAGEMENT1, ',', '') AS MANAGEMENT1
                       , REPLACE(SEU.MANAGEMENT2, ',', '') AS MANAGEMENT2
                       , REPLACE(SEU.REFER1, ',', '') AS REFER1
                       , REPLACE(SEU.REFER2, ',', '') AS REFER2
                       , REPLACE(SEU.REFER3, ',', '') AS REFER3
                       , REPLACE(SEU.REFER4, ',', '') AS REFER4
                       , REPLACE(SEU.REFER5, ',', '') AS REFER5
                       , REPLACE(SEU.REFER6, ',', '') AS REFER6
                       , REPLACE(SEU.REFER7, ',', '') AS REFER7
                       , REPLACE(SEU.REFER8, ',', '') AS REFER8
                       , REPLACE(SEU.REFER9, ',', '') AS REFER9
                       , REPLACE(SEU.REFER10, ',', '') AS REFER10
                       , REPLACE(SEU.REFER11, ',', '') AS REFER11
                       , REPLACE(SEU.REFER12, ',', '') AS REFER12
                       , SEU.REMARK
                    FROM FI_SLIP_EXCEL_UPLOAD SEU
                       , FI_ACCOUNT_CONTROL AC
                       , FI_DEPT_MASTER DM
                  WHERE SEU.ACCOUNT_CODE              = AC.ACCOUNT_CODE
                    AND SEU.SOB_ID                    = AC.SOB_ID
                    AND SEU.BUDGET_DEPT_CODE          = DM.DEPT_CODE(+)
                    AND SEU.SOB_ID                    = DM.SOB_ID(+)
                    AND SEU.SLIP_DATE                 = C1.SLIP_DATE
                    AND SEU.SLIP_HEADER_ID            = V_SLIP_HEADER_ID
                    AND SEU.SOB_ID                    = C1.SOB_ID
                    AND SEU.ORG_ID                    = C1.ORG_ID
                    AND SEU.USER_ID                   = C1.USER_ID
                    AND SEU.SLIP_YN                   = 'Y'
                  ORDER BY SEU.SLIP_LINE_SEQ  
                 )
      LOOP
        BEGIN
          -- 경비전표 INSERT.
          FI_SLIP_INTERFACE_G.INSERT_LINE_IF
                  ( P_LINE_INTERFACE_ID          => V_SLIP_LINE_ID
                  , P_HEADER_INTERFACE_ID        => V_SLIP_HEADER_ID
                  , P_SOB_ID                     => C1.SOB_ID
                  , P_ORG_ID                     => C1.ORG_ID
                  , P_BUDGET_DEPT_ID             => R1.BUDGET_DEPT_ID
                  , P_CUSTOMER_ID                => NULL
                  , P_ACCOUNT_CONTROL_ID         => R1.ACCOUNT_CONTROL_ID
                  , P_ACCOUNT_CODE               => R1.ACCOUNT_CODE
                  , P_COST_CENTER_ID             => NULL
                  , P_ACCOUNT_DR_CR              => R1.ACCOUNT_DR_CR
                  , P_GL_AMOUNT                  => R1.GL_AMOUNT
                  , P_CURRENCY_CODE              => R1.CURRENCY_CODE
                  , P_EXCHANGE_RATE              => R1.EXCHANGE_RATE
                  , P_GL_CURRENCY_AMOUNT         => R1.GL_CURRENCY_AMOUNT
                  , P_BANK_ACCOUNT_ID            => NULL
                  , P_MANAGEMENT1                => R1.MANAGEMENT1
                  , P_MANAGEMENT2                => R1.MANAGEMENT2
                  , P_REFER1                     => R1.REFER1
                  , P_REFER2                     => R1.REFER2
                  , P_REFER3                     => R1.REFER3
                  , P_REFER4                     => R1.REFER4
                  , P_REFER5                     => R1.REFER5
                  , P_REFER6                     => R1.REFER6
                  , P_REFER7                     => R1.REFER7
                  , P_REFER8                     => R1.REFER8
                  , P_REFER9                     => R1.REFER9
                  , P_REFER10                    => R1.REFER10
                  , P_REFER11                    => R1.REFER11
                  , P_REFER12                    => R1.REFER12
                  , P_VOUCH_CODE                 => NULL
                  , P_REFER_RATE                 => NULL
                  , P_REFER_AMOUNT               => NULL
                  , P_REFER_DATE1                => NULL
                  , P_REFER_DATE2                => NULL
                  , P_REMARK                     => R1.REMARK
                  , P_FUND_CODE                  => NULL
                  , P_UNIT_PRICE                 => NULL
                  , P_UOM_CODE                   => NULL
                  , P_UOM_QUANTITY               => NULL
                  , P_UOM_WEIGHT                 => NULL
                  , P_USER_ID                    => C1.USER_ID
                  );
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Insert LINE Error : Slip Date(' || C1.SLIP_DATE || '), LINE SEQ(' || R1.SLIP_LINE_SEQ || '), ACCOUNT CODE(' || R1.ACCOUNT_CODE || ')-' || SUBSTR(SQLERRM, 1, 150);
          RETURN;
        END;
      END LOOP R1;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);    
  END SET_SLIP_IF_TRANSFER;

-- 경비전표 생성 데이터 취소(삭제).
  PROCEDURE CANCEL_SLIP_IF_TRANSFER
            ( P_SOB_ID            IN FI_SLIP_EXCEL_UPLOAD.SOB_ID%TYPE
            , P_ORG_ID            IN FI_SLIP_EXCEL_UPLOAD.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN FI_SLIP_EXCEL_UPLOAD.SLIP_PERSON_ID%TYPE
            , P_USER_ID           IN FI_SLIP_EXCEL_UPLOAD.USER_ID%TYPE
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SLIP_NUM                    NUMBER;
  BEGIN
    O_STATUS := 'F';
    V_SLIP_NUM := 0;
    FOR C1 IN ( SELECT DISTINCT SEU.SLIP_DATE
                     , SEU.SLIP_NUM     -- 전표 헤더 생성 단위.
                     , SEU.SLIP_HEADER_ID  -- 예산전표 헤더 ID.
                     , SEU.SOB_ID
                     , SEU.ORG_ID
                     , SEU.USER_ID
                  FROM FI_SLIP_EXCEL_UPLOAD SEU
                WHERE SEU.SOB_ID                    = P_SOB_ID
                  AND SEU.ORG_ID                    = P_ORG_ID
                  AND SEU.USER_ID                   = P_USER_ID
                  AND SEU.SLIP_YN                   = 'Y'
               ORDER BY SEU.SLIP_NUM
              )
    LOOP
      -- 전표 DATA 검증 및 삭제 --
      IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, C1.SLIP_DATE, C1.SOB_ID, C1.ORG_ID) IN('C', 'N') THEN
        O_STATUS := 'F';
        O_MESSAGE := ERRNUMS.Data_Not_Opened_Desc;      
        RETURN;
      END IF;
      
       -- 전호수 주석 : 회계전표와 동일하게 적용 하므로 마감 여부 체크 안함 --
      IF FI_SLIP_INTERFACE_G.SLIP_CONFIRM_YN_F(C1.SLIP_HEADER_ID) <> 'N' THEN
        O_STATUS := 'F';
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115');
        RETURN;
      END IF;
      
      BEGIN
        -- 경비전표 라인 삭제.
        DELETE FI_SLIP_LINE_INTERFACE SLI
        WHERE SLI.HEADER_INTERFACE_ID       = C1.SLIP_HEADER_ID
        ;
        
        -- 경비전표 헤더 삭제.
        DELETE FI_SLIP_HEADER_INTERFACE SHI
        WHERE SHI.HEADER_INTERFACE_ID       = C1.SLIP_HEADER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 200);
        RETURN;
      END; 
      
      -- 엑셀 업로드 자료 수정 --
      V_SLIP_NUM := NVL(V_SLIP_NUM, 0) + 1;
      BEGIN
        UPDATE FI_SLIP_EXCEL_UPLOAD SEU
          SET SEU.SLIP_NUM                  = V_SLIP_NUM
            , SEU.SLIP_HEADER_ID            = NULL
            , SEU.GL_NUM                    = NULL
            , SEU.SLIP_YN                   = 'N'
            , SEU.SLIP_PERSON_ID            = P_CONNECT_PERSON_ID
        WHERE SEU.SLIP_HEADER_ID            = C1.SLIP_HEADER_ID
          AND SEU.SOB_ID                    = C1.SOB_ID
          AND SEU.ORG_ID                    = C1.ORG_ID
          AND SEU.USER_ID                   = C1.USER_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END LOOP C1;
    O_STATUS := 'S';
  END CANCEL_SLIP_IF_TRANSFER;
  
END FI_SLIP_EXCEL_UPLOAD_G;
/
