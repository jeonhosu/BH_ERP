CREATE OR REPLACE PACKAGE FI_SLIP_G
AS

-- 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_DATE_FR         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_DATE_TO         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID%TYPE DEFAULT NULL
            , W_DEPT_ID              IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , W_PERSON_ID            IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , W_SLIP_TYPE            IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            );

-- 전표 헤더/라인 삭제.
  PROCEDURE DELETE_SLIP_LIST
            ( W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            );

-- 선택한 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            );

-- 전표 헤더 삽입.
  PROCEDURE INSERT_SLIP_HEADER
            ( P_SLIP_HEADER_ID      OUT FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_HEADER.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER.BUDGET_DEPT_ID%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
            , P_GL_NUM              IN FI_SLIP_HEADER.GL_NUM%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            , P_CREATED_TYPE        IN FI_SLIP_HEADER.CREATED_TYPE%TYPE DEFAULT 'M'
            , P_SOURCE_TABLE        IN FI_SLIP_HEADER.SOURCE_TABLE%TYPE DEFAULT NULL
            , P_SOURCE_HEADER_ID    IN FI_SLIP_HEADER.SOURCE_HEADER_ID%TYPE DEFAULT NULL
            );

-- 전표 헤더 수정.
  PROCEDURE UPDATE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            );

-- 전표 헤더 삭제.
  PROCEDURE DELETE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID    IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , W_SOB_ID            IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID            IN FI_SLIP_LINE.ORG_ID%TYPE
            );

-- 전표 라인  삽입.
  PROCEDURE INSERT_SLIP_LINE
            ( P_SLIP_LINE_ID               OUT FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , P_SLIP_HEADER_ID             IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , P_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , P_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_REFER6                     IN FI_SLIP_LINE.REFER6%TYPE
            , P_REFER7                     IN FI_SLIP_LINE.REFER7%TYPE
            , P_REFER8                     IN FI_SLIP_LINE.REFER8%TYPE
            , P_REFER9                     IN FI_SLIP_LINE.REFER9%TYPE
            , P_REFER10                    IN FI_SLIP_LINE.REFER10%TYPE
            , P_REFER11                    IN FI_SLIP_LINE.REFER11%TYPE
            , P_REFER12                    IN FI_SLIP_LINE.REFER12%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            , P_LINE_TYPE                  IN FI_SLIP_LINE.LINE_TYPE%TYPE DEFAULT 'M'
            , P_SOURCE_TABLE               IN FI_SLIP_LINE.SOURCE_TABLE%TYPE DEFAULT NULL
            , P_SOURCE_HEADER_ID           IN FI_SLIP_LINE.SOURCE_HEADER_ID%TYPE DEFAULT NULL
            , P_SOURCE_LINE_ID             IN FI_SLIP_LINE.SOURCE_LINE_ID%TYPE DEFAULT NULL
            );

-- 전표라인 수정.
  PROCEDURE UPDATE_SLIP_LINE
            ( W_SLIP_LINE_ID               IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , W_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_REFER6                     IN FI_SLIP_LINE.REFER6%TYPE
            , P_REFER7                     IN FI_SLIP_LINE.REFER7%TYPE
            , P_REFER8                     IN FI_SLIP_LINE.REFER8%TYPE
            , P_REFER9                     IN FI_SLIP_LINE.REFER9%TYPE
            , P_REFER10                    IN FI_SLIP_LINE.REFER10%TYPE
            , P_REFER11                    IN FI_SLIP_LINE.REFER11%TYPE
            , P_REFER12                    IN FI_SLIP_LINE.REFER12%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_FUND_CODE                  IN FI_SLIP_LINE.FUND_CODE%TYPE
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            );

-- 전표 라인 삭제.
  PROCEDURE DELETE_SLIP_LINE
            ( W_SLIP_LINE_ID      IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            );

-- 전표 관리항목 삽입 : 전표 라인 트리거에서 호출함...
  PROCEDURE INSERT_MANAGEMENT_ITEM
            ( P_SLIP_LINE_ID            IN FI_SLIP_MANAGEMENT_ITEM.SLIP_LINE_ID%TYPE
            , P_SLIP_DATE               IN FI_SLIP_MANAGEMENT_ITEM.SLIP_DATE%TYPE
            , P_SLIP_NUM                IN FI_SLIP_MANAGEMENT_ITEM.SLIP_NUM%TYPE
            , P_SLIP_LINE_SEQ           IN FI_SLIP_MANAGEMENT_ITEM.SLIP_LINE_SEQ%TYPE
            , P_SLIP_HEADER_ID          IN FI_SLIP_MANAGEMENT_ITEM.SLIP_HEADER_ID%TYPE
            , P_SOB_ID                  IN FI_SLIP_MANAGEMENT_ITEM.SOB_ID%TYPE
            , P_MANAGEMENT_SEQ          IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_SEQ%TYPE
            , P_MANAGEMENT_ID           IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_VALUE        IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_VALUE%TYPE
            , P_GL_DATE                 IN FI_SLIP_MANAGEMENT_ITEM.GL_DATE%TYPE
            , P_GL_NUM                  IN FI_SLIP_MANAGEMENT_ITEM.GL_NUM%TYPE
            , P_USER_ID                 IN FI_SLIP_MANAGEMENT_ITEM.CREATED_BY%TYPE
            );

-- 전표 관리항목 삭제.
  PROCEDURE DELETE_MANAGEMENT_ITEM
            ( W_SLIP_LINE_ID            IN FI_SLIP_MANAGEMENT_ITEM.SLIP_LINE_ID%TYPE
            , W_SOB_ID                  IN FI_SLIP_MANAGEMENT_ITEM.SOB_ID%TYPE
            , W_MANAGEMENT_SEQ          IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_SEQ%TYPE
            );

-- 관리항목 CODE, DATA TYPE 리턴.
  PROCEDURE MANAGEMENT_DATA_TYPE_P
            ( W_MANAGEMENT_ID           IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_ID%TYPE
            , W_SOB_ID                  IN FI_SLIP_MANAGEMENT_ITEM.SOB_ID%TYPE
            , O_MANAGEMENT_CODE         OUT VARCHAR2
            , O_DATA_TYPE               OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
PROCEDURE SELECT_SLIP_LINE_ACCOUNT_ID
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            );

-- 전표 라인 조회 날짜 범위 및 계정 코드 범위.
  PROCEDURE SELECT_SLIP_LINE_ACCOUNT_CODE
            ( P_CURSOR2            OUT TYPES.TCURSOR2
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            );

-- 전표 라인 조회 날짜 범위 및 계정 코드 범위 거래처코드.
  PROCEDURE SELECT_SLIP_ACCOUNT_CUST_CODE
            ( P_CURSOR2            OUT TYPES.TCURSOR2
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , W_CUSTOMER_CODE      IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_VALUE%TYPE
            );

-- 전표 라인 조회 : 분개 정보.
  PROCEDURE SELECT_SLIP_LINE_JOURNALIZE
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_GL_DATE_FR        IN DATE
            , P_GL_DATE_TO        IN DATE
            , P_ACCOUNT_CODE_FR   IN VARCHAR2
            , P_ACCOUNT_CODE_TO   IN VARCHAR2
            , P_SLIP_HEADER_ID    IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            );


-- 전표 조회 : 관리항목별.
  PROCEDURE SELECT_SLIP_MANAGEMENT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_GL_DATE_FR        IN DATE
            , P_GL_DATE_TO        IN DATE
            , P_ACCOUNT_CODE_FR   IN VARCHAR2
            , P_ACCOUNT_CODE_TO   IN VARCHAR2
            , P_SLIP_HEADER_ID    IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_GL_AMOUNT_FR      IN NUMBER
            , P_GL_AMOUNT_TO      IN NUMBER
            , P_LOOKUP_YN         IN VARCHAR2
            , P_MANAGEMENT_ID     IN NUMBER
            , P_MANAGEMENT_VALUE  IN VARCHAR2
            , P_MANAGEMENT_DESC   IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            );           

-- 전표 조회 : 관리항목 PROMPT 조회.
  PROCEDURE SELECT_SLIP_MANAGEMENT_YN
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_GL_DATE_FR        IN DATE
            , P_GL_DATE_TO        IN DATE
            , P_ACCOUNT_CODE_FR   IN VARCHAR2
            , P_ACCOUNT_CODE_TO   IN VARCHAR2
            , P_SLIP_HEADER_ID    IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_GL_AMOUNT_FR      IN NUMBER
            , P_GL_AMOUNT_TO      IN NUMBER
            , P_LOOKUP_YN         IN VARCHAR2
            , P_MANAGEMENT_ID     IN NUMBER
            , P_MANAGEMENT_VALUE  IN VARCHAR2
            , P_MANAGEMENT_DESC   IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            ); 
            
---------------------------------------------------------------------------------------------------
-- 계정 통제관리값 : LOOKUP TYPE에 따른 해당 값 리턴..
  FUNCTION SLIP_ITEM_VALUE_F
          ( W_SLIP_LINE_ID        IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
          , W_LOOKUP_TYPE         IN VARCHAR2
          , W_SOB_ID              IN FI_SLIP_LINE.SOB_ID%TYPE
          ) RETURN VARCHAR2;

-- 전표 저장전 관리항목 값 리턴.
  FUNCTION SLIP_ITEM_F
            ( W_LOOKUP_TYPE                IN VARCHAR2
            , P_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , P_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_REFER6                     IN FI_SLIP_LINE.REFER6%TYPE
            , P_REFER7                     IN FI_SLIP_LINE.REFER7%TYPE
            , P_REFER8                     IN FI_SLIP_LINE.REFER8%TYPE
            , P_REFER9                     IN FI_SLIP_LINE.REFER9%TYPE
            , P_REFER10                     IN FI_SLIP_LINE.REFER10%TYPE
            , P_REFER11                     IN FI_SLIP_LINE.REFER11%TYPE
            , P_REFER12                     IN FI_SLIP_LINE.REFER12%TYPE
            , P_REFER13                     IN FI_SLIP_LINE.REFER13%TYPE
            ) RETURN VARCHAR2;
            
---------------------------------------------------------------------------------------------------
-- 전표 마감 여부 체크.
  FUNCTION SLIP_CLOSE_YN_F
           ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
           ) RETURN VARCHAR2;

-- 전표 승인 여부 체크.
  FUNCTION SLIP_CONFIRM_YN_F
           ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
           ) RETURN VARCHAR2;

-- 기표번호 조회 LOOKUP.
  PROCEDURE LU_SLIP_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_SLIP_NUM          IN VARCHAR2 DEFAULT NULL
            );

-- 전표번호 조회 LOOKUP.
  PROCEDURE LU_GL_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_GL_NUM            IN VARCHAR2 DEFAULT NULL
            );
            
END FI_SLIP_G; 
/
CREATE OR REPLACE PACKAGE BODY FI_SLIP_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_SLIP_G
/* Description  : 전표 헤더/라인 정보.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_DATE_FR         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_DATE_TO         IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_ACCOUNT_CONTROL_ID   IN FI_ACCOUNT_CONTROL.ACCOUNT_CONTROL_ID%TYPE DEFAULT NULL
            , W_DEPT_ID              IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , W_PERSON_ID            IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , W_SLIP_TYPE            IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SH.SLIP_HEADER_ID
           , SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.SOB_ID
           , SH.ORG_ID
           , SH.DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.DEPT_ID) AS DEPT_NAME
           , SH.PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SH.SLIP_TYPE, SH.SOB_ID) AS SLIP_TYPE_NAME
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
           , SH.CHANGE_COUNT
           , SH.GL_DATE
           , SH.GL_NUM
           , SH.GL_AMOUNT
           , SH.CURRENCY_CODE
           , SH.CURRENCY_CODE AS CURRENCY_DESC
           , SH.EXCHANGE_RATE
           , SH.GL_CURRENCY_AMOUNT
           , SH.REQ_BANK_ACCOUNT_ID
           , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
           , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
           , SH.REQ_PAYABLE_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
           , SH.REQ_PAYABLE_DATE
           , SH.REMARK
           , SH.CLOSED_YN
           , ST.SLIP_TYPE_CLASS
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_TYPE_V ST
          , (SELECT BA.BANK_ACCOUNT_ID
                  , FB.BANK_NAME
                  , BA.BANK_ACCOUNT_NAME
                  , BA.BANK_ACCOUNT_NUM
               FROM FI_BANK_ACCOUNT BA
                  , FI_BANK FB
              WHERE BA.BANK_ID      = FB.BANK_ID
            ) S_BA
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
         AND SH.SLIP_DATE               BETWEEN W_SLIP_DATE_FR AND W_SLIP_DATE_TO
         AND SH.SLIP_HEADER_ID          = NVL(W_SLIP_HEADER_ID, SH.SLIP_HEADER_ID)
         AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND SH.DEPT_ID                 = NVL(W_DEPT_ID, SH.DEPT_ID)
         AND SH.PERSON_ID               = NVL(W_PERSON_ID, SH.PERSON_ID)
         AND SH.SOB_ID                  = W_SOB_ID
         AND EXISTS 
               ( SELECT 'X'
                    FROM FI_SLIP_LINE SL
                  WHERE SL.SLIP_HEADER_ID   = SH.SLIP_HEADER_ID
                    AND SL.SOB_ID           = SH.SOB_ID
                    AND SL.ACCOUNT_CONTROL_ID = NVL(W_ACCOUNT_CONTROL_ID, SL.ACCOUNT_CONTROL_ID)
                )
         AND NOT EXISTS 
               ( SELECT 'X'
                    FROM FI_SLIP_TYPE_V ST
                  WHERE ST.SLIP_TYPE    = SH.SLIP_TYPE
                    AND ST.SOB_ID       = SH.SOB_ID
                    AND ST.SLIP_TYPE_CLASS = 'BL'
                )
      ORDER BY /*SH.SLIP_HEADER_ID DESC  --*/SH.SLIP_DATE, SH.GL_DATE DESC
      ;
  END SELECT_SLIP_HEADER_LIST;

-- 전표 헤더/라인 삭제.
  PROCEDURE DELETE_SLIP_LIST
            ( W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            )
  AS
  BEGIN
    IF SLIP_CLOSE_YN_F(W_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;

    DELETE FI_SLIP_LINE SL
    WHERE SL.SLIP_HEADER_ID       = W_SLIP_HEADER_ID
    ;

    DELETE FI_SLIP_HEADER SH
    WHERE SH.SLIP_HEADER_ID       = W_SLIP_HEADER_ID
    ;
  END DELETE_SLIP_LIST;

-- 선택한 전표 헤더 조회.
  PROCEDURE SELECT_SLIP_HEADER
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID       IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SH.SLIP_HEADER_ID
           , SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.SOB_ID
           , SH.ORG_ID
           , SH.DEPT_ID
           , DM.DEPT_CODE
           , DM.DEPT_NAME AS DEPT_NAME
           , SH.PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , ST.SLIP_TYPE_NAME AS SLIP_TYPE_NAME
           , ST.SLIP_TYPE_CLASS
           , ST.DOCUMENT_TYPE
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
           , SH.CHANGE_COUNT
           , SH.GL_DATE
           , SH.GL_NUM
           , SH.GL_AMOUNT
           , SH.CURRENCY_CODE
           , SH.CURRENCY_CODE AS CURRENCY_DESC
           , SH.EXCHANGE_RATE
           , SH.GL_CURRENCY_AMOUNT
           , SH.REQ_BANK_ACCOUNT_ID
           , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
           , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
           , SH.REQ_PAYABLE_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
           , SH.REQ_PAYABLE_DATE
           , SH.REMARK
           , SH.CLOSED_YN
        FROM FI_SLIP_HEADER SH
          , FI_DEPT_MASTER DM
          , FI_SLIP_TYPE_V ST
          , (SELECT BA.BANK_ACCOUNT_ID
                  , FB.BANK_NAME
                  , BA.BANK_ACCOUNT_NAME
                  , BA.BANK_ACCOUNT_NUM
               FROM FI_BANK_ACCOUNT BA
                  , FI_BANK FB
              WHERE BA.BANK_ID      = FB.BANK_ID
            ) S_BA
       WHERE SH.DEPT_ID                 = DM.DEPT_ID
         AND SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
         AND SH.SLIP_HEADER_ID          = W_SLIP_HEADER_ID
         AND SH.SOB_ID                  = W_SOB_ID
      ;
  END SELECT_SLIP_HEADER;

-- 전표 헤더 삽입.
  PROCEDURE INSERT_SLIP_HEADER
            ( P_SLIP_HEADER_ID      OUT FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_HEADER.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_HEADER.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_HEADER.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER.BUDGET_DEPT_ID%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_HEADER.SLIP_TYPE%TYPE
            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
            , P_GL_NUM              IN FI_SLIP_HEADER.GL_NUM%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            , P_CREATED_TYPE        IN FI_SLIP_HEADER.CREATED_TYPE%TYPE DEFAULT 'M'
            , P_SOURCE_TABLE        IN FI_SLIP_HEADER.SOURCE_TABLE%TYPE DEFAULT NULL
            , P_SOURCE_HEADER_ID    IN FI_SLIP_HEADER.SOURCE_HEADER_ID%TYPE DEFAULT NULL
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
    END IF;

    SELECT FI_SLIP_HEADER_S1.NEXTVAL
      INTO P_SLIP_HEADER_ID
      FROM DUAL;

    INSERT INTO FI_SLIP_HEADER
    ( SLIP_HEADER_ID
    , SLIP_DATE
    , SLIP_NUM
    , SOB_ID
    , ORG_ID
    , DEPT_ID
    , PERSON_ID
    , BUDGET_DEPT_ID
    , ACCOUNT_BOOK_ID
    , SLIP_TYPE
    , PERIOD_NAME
    , CONFIRM_YN
    , CONFIRM_DATE
    , CONFIRM_PERSON_ID
    , GL_DATE
    , GL_NUM
    , REQ_BANK_ACCOUNT_ID
    , REQ_PAYABLE_TYPE
    , REQ_PAYABLE_DATE
    , REMARK
    , CREATED_TYPE
    , SOURCE_TABLE
    , SOURCE_HEADER_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_SLIP_HEADER_ID
    , P_SLIP_DATE
    , P_SLIP_NUM
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPT_ID
    , P_PERSON_ID
    , P_BUDGET_DEPT_ID
    , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(P_SOB_ID)
    , P_SLIP_TYPE
    , GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID), P_GL_DATE, P_SOB_ID, P_ORG_ID)
    , 'Y'
    , GET_LOCAL_DATE(P_SOB_ID)   -- 승인일시.
    , P_PERSON_ID   -- 승인자.
    , P_GL_DATE     -- 전표일자.
    , P_GL_NUM      -- 전표번호.
    , P_REQ_BANK_ACCOUNT_ID
    , P_REQ_PAYABLE_TYPE
    , P_REQ_PAYABLE_DATE
    , P_REMARK
    , P_CREATED_TYPE
    , P_SOURCE_TABLE
    , P_SOURCE_HEADER_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );      
  END INSERT_SLIP_HEADER;

-- 전표 헤더 수정.
  PROCEDURE UPDATE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER.SLIP_DATE%TYPE
            , P_GL_DATE             IN FI_SLIP_HEADER.GL_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER.ORG_ID%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER.REMARK%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_GL_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
    END IF;

    IF SLIP_CLOSE_YN_F(W_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;

    UPDATE FI_SLIP_HEADER
      SET SLIP_DATE           = P_SLIP_DATE
        , PERIOD_NAME         = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID), P_GL_DATE, P_SOB_ID, P_ORG_ID)
        , GL_DATE             = P_GL_DATE
        , REQ_BANK_ACCOUNT_ID = P_REQ_BANK_ACCOUNT_ID
        , REQ_PAYABLE_TYPE    = P_REQ_PAYABLE_TYPE
        , REQ_PAYABLE_DATE    = P_REQ_PAYABLE_DATE
        , REMARK              = P_REMARK
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE SLIP_HEADER_ID      = W_SLIP_HEADER_ID
    ;
    -- 라인 업데이트.
    UPDATE FI_SLIP_LINE SL
      SET SL.SLIP_DATE           = P_SLIP_DATE
        , SL.GL_DATE             = P_GL_DATE
        , PERIOD_NAME            = GL_FISCAL_PERIOD_G.PERIOD_NAME_F(FI_ACCOUNT_BOOK_G.OPERATING_FISCAL_CALENDAR_F(P_SOB_ID), P_GL_DATE, P_SOB_ID, P_ORG_ID)
    WHERE SL.SLIP_HEADER_ID      = W_SLIP_HEADER_ID
    ;
  END UPDATE_SLIP_HEADER;

-- 전표 헤더 삭제.
  PROCEDURE DELETE_SLIP_HEADER
            ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
            )
  AS
    V_RECORD_COUNT                  NUMBER := 0;
  BEGIN
    IF SLIP_CLOSE_YN_F(W_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;

    /*-- 라인 존재 체크.
    BEGIN
      SELECT COUNT(SL.SLIP_HEADER_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_SLIP_LINE SL
      WHERE SL.SLIP_HEADER_ID     = W_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      DELETE FI_SLIP_LINE
      WHERE SLIP_HEADER_ID        = W_SLIP_HEADER_ID
      ;
    END IF;*/

    DELETE FI_SLIP_HEADER
    WHERE SLIP_HEADER_ID = W_SLIP_HEADER_ID;
  END DELETE_SLIP_HEADER;

---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_SLIP_HEADER_ID    IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , W_SOB_ID            IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID            IN FI_SLIP_LINE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SL.SLIP_LINE_ID
           , SL.SLIP_LINE_SEQ
           , SL.SLIP_HEADER_ID
           , SL.SOB_ID
           , SL.ACCOUNT_BOOK_ID
           , SL.ACCOUNT_CONTROL_ID
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SL.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
           , SL.CURRENCY_CODE
           , SL.CURRENCY_CODE AS CURRENCY_DESC
           , SL.EXCHANGE_RATE
           , SL.GL_CURRENCY_AMOUNT
           , SL.GL_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.CUSTOMER_ID
           , SCV.SUPP_CUST_NAME AS CUSTOMER_NAME
           , SCV.TAX_REG_NO
           , SL.BANK_ACCOUNT_ID
           , BAT.BANK_ACCOUNT_NAME
           , BAT.BANK_ACCOUNT_NUM
           , SL.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SL.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SL.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_CODE_F(SL.COST_CENTER_ID) AS COST_CENTER_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(SL.COST_CENTER_ID) AS COST_CENTER_DESC
           , SL.MANAGEMENT1                           -- 계좌번호 OR CODE 값.
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER1_ID'
                                                      , SL.MANAGEMENT1
                                                      , SL.SOB_ID) AS MANAGEMENT1_DESC
           , SL.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER2_ID'
                                                      , SL.MANAGEMENT2
                                                      , SL.SOB_ID) AS MANAGEMENT2_DESC
           , SL.REFER1
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER3_ID'
                                                      , SL.REFER1
                                                      , SL.SOB_ID) AS REFER1_DESC
           , SL.REFER2
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER4_ID'
                                                      , SL.REFER2
                                                      , SL.SOB_ID) AS REFER2_DESC
           , SL.REFER3
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER5_ID'
                                                      , SL.REFER3
                                                      , SL.SOB_ID) AS REFER3_DESC
           , SL.REFER4
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER6_ID'
                                                      , SL.REFER4
                                                      , SL.SOB_ID) AS REFER4_DESC
           , SL.REFER5
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER7_ID'
                                                      , SL.REFER5
                                                      , SL.SOB_ID) AS REFER5_DESC
           , SL.REFER6
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER8_ID'
                                                      , SL.REFER6
                                                      , SL.SOB_ID) AS REFER6_DESC
           , SL.REFER7
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER9_ID'
                                                      , SL.REFER7
                                                      , SL.SOB_ID) AS REFER7_DESC
           , SL.REFER8
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER10_ID'
                                                      , SL.REFER8
                                                      , SL.SOB_ID) AS REFER8_DESC
           , SL.REFER9
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER11_ID'
                                                      , SL.REFER9
                                                      , SL.SOB_ID) AS REFER9_DESC
           , SL.REFER10
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER12_ID'
                                                      , SL.REFER10
                                                      , SL.SOB_ID) AS REFER10_DESC
           , SL.REFER11
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER13_ID'
                                                      , SL.REFER11
                                                      , SL.SOB_ID) AS REFER11_DESC
           , SL.REFER12
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                      , 'REFER14_ID'
                                                      , SL.REFER12
                                                      , SL.SOB_ID) AS REFER12_DESC
           , SL.REMARK
           , SL.CLOSED_YN
           , AC.REFER1_ID AS MANAGEMENT1_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER1_ID) AS MANAGEMENT1_NAME
           , DECODE(AC.REFER1_ID, NULL, 'F', 'Y') AS MANAGEMENT1_YN
           , NVL(AC.DR_NEED_YN1, 'N') AS MANAGEMENT1_DR_YN
           , NVL(AC.CR_NEED_YN1, 'N') AS MANAGEMENT1_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER1_ID, 'VALUE1'), 'N') AS MANAGEMENT1_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER1_ID', AC.SOB_ID) AS MANAGEMENT1_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER1_ID, 'VALUE4'), 'VARCHAR2') AS MANAGEMENT1_DATA_TYPE
           , AC.REFER2_ID AS MANAGEMENT2_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER2_ID) AS MANAGEMENT2_NAME
           , DECODE(AC.REFER2_ID, NULL, 'F', 'Y') AS MANAGEMENT2_YN
           , NVL(AC.DR_NEED_YN2, 'N') AS MANAGEMENT2_DR_YN
           , NVL(AC.CR_NEED_YN2, 'N') AS MANAGEMENT2_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER2_ID, 'VALUE1'), 'N') AS MANAGEMENT2_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER2_ID', AC.SOB_ID) AS MANAGEMENT2_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER2_ID, 'VALUE4'), 'VARCHAR2') AS MANAGEMENT2_DATA_TYPE
           , AC.REFER3_ID AS REFER1_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER3_ID) AS REFER1_NAME
           , DECODE(AC.REFER3_ID, NULL, 'F', 'Y') AS REFER1_YN
           , NVL(AC.DR_NEED_YN3, 'N') AS REFER1_DR_YN
           , NVL(AC.CR_NEED_YN3, 'N') AS REFER1_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER3_ID, 'VALUE1'), 'N') AS REFER1_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER3_ID', AC.SOB_ID) AS REFER1_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER3_ID, 'VALUE4'), 'VARCHAR2') AS REFER1_DATA_TYPE
           , AC.REFER4_ID AS REFER2_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER4_ID) AS REFER2_NAME
           , DECODE(AC.REFER4_ID, NULL, 'F', 'Y') AS REFER2_YN
           , NVL(AC.DR_NEED_YN4, 'N') AS REFER2_DR_YN
           , NVL(AC.CR_NEED_YN4, 'N') AS REFER2_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER4_ID, 'VALUE1'), 'N') AS REFER2_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER4_ID', AC.SOB_ID) AS REFER2_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER4_ID, 'VALUE4'), 'VARCHAR2') AS REFER2_DATA_TYPE
           , AC.REFER5_ID AS REFER3_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER5_ID) AS REFER3_NAME
           , DECODE(AC.REFER5_ID, NULL, 'F', 'Y') AS REFER3_YN
           , NVL(AC.DR_NEED_YN5, 'N') AS REFER3_DR_YN
           , NVL(AC.CR_NEED_YN5, 'N') AS REFER3_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER5_ID, 'VALUE1'), 'N') AS REFER3_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER5_ID', AC.SOB_ID) AS REFER3_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER5_ID, 'VALUE4'), 'VARCHAR2') AS REFER3_DATA_TYPE
           , AC.REFER6_ID AS REFER4_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER6_ID) AS REFER4_NAME
           , DECODE(AC.REFER6_ID, NULL, 'F', 'Y') AS REFER4_YN
           , NVL(AC.DR_NEED_YN6, 'N') AS REFER4_DR_YN
           , NVL(AC.CR_NEED_YN6, 'N') AS REFER4_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER6_ID, 'VALUE1'), 'N') AS REFER4_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER6_ID', AC.SOB_ID) AS REFER4_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER6_ID, 'VALUE4'), 'VARCHAR2') AS REFER4_DATA_TYPE
           , AC.REFER7_ID AS REFER5_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER7_ID) AS REFER5_NAME
           , DECODE(AC.REFER7_ID, NULL, 'F', 'Y') AS REFER5_YN
           , NVL(AC.DR_NEED_YN7, 'N') AS REFER5_DR_YN
           , NVL(AC.CR_NEED_YN7, 'N') AS REFER5_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER7_ID, 'VALUE1'), 'N') AS REFER5_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER7_ID', AC.SOB_ID) AS REFER5_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER7_ID, 'VALUE4'), 'VARCHAR2') AS REFER5_DATA_TYPE
           , AC.REFER8_ID AS REFER6_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER8_ID) AS REFER6_NAME
           , DECODE(AC.REFER8_ID, NULL, 'F', 'Y') AS REFER6_YN
           , NVL(AC.DR_NEED_YN8, 'N') AS REFER6_DR_YN
           , NVL(AC.CR_NEED_YN8, 'N') AS REFER6_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER8_ID, 'VALUE1'), 'N') AS REFER6_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER8_ID', AC.SOB_ID) AS REFER6_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER8_ID, 'VALUE4'), 'VARCHAR2') AS REFER6_DATA_TYPE
           , AC.REFER9_ID AS REFER7_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER9_ID) AS REFER7_NAME
           , DECODE(AC.REFER9_ID, NULL, 'F', 'Y') AS REFER7_YN
           , NVL(AC.DR_NEED_YN9, 'N') AS REFER7_DR_YN
           , NVL(AC.CR_NEED_YN9, 'N') AS REFER7_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER9_ID, 'VALUE1'), 'N') AS REFER7_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER9_ID', AC.SOB_ID) AS REFER7_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER9_ID, 'VALUE4'), 'VARCHAR2') AS REFER7_DATA_TYPE
           , AC.REFER10_ID AS REFER8_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER10_ID) AS REFER8_NAME
           , DECODE(AC.REFER10_ID, NULL, 'F', 'Y') AS REFER8_YN
           , NVL(AC.DR_NEED_YN10, 'N') AS REFER8_DR_YN
           , NVL(AC.CR_NEED_YN10, 'N') AS REFER8_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER10_ID, 'VALUE1'), 'N') AS REFER8_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER10_ID', AC.SOB_ID) AS REFER8_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER10_ID, 'VALUE4'), 'VARCHAR2') AS REFER8_DATA_TYPE
           , AC.REFER11_ID AS REFER9_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER11_ID) AS REFER9_NAME
           , DECODE(AC.REFER11_ID, NULL, 'F', 'Y') AS REFER9_YN
           , NVL(AC.DR_NEED_YN11, 'N') AS REFER9_DR_YN
           , NVL(AC.CR_NEED_YN11, 'N') AS REFER9_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER11_ID, 'VALUE1'), 'N') AS REFER9_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER11_ID', AC.SOB_ID) AS REFER9_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER11_ID, 'VALUE4'), 'VARCHAR2') AS REFER9_DATA_TYPE
           , AC.REFER12_ID AS REFER10_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER12_ID) AS REFER10_NAME
           , DECODE(AC.REFER12_ID, NULL, 'F', 'Y') AS REFER10_YN
           , NVL(AC.DR_NEED_YN12, 'N') AS REFER10_DR_YN
           , NVL(AC.CR_NEED_YN12, 'N') AS REFER10_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER12_ID, 'VALUE1'), 'N') AS REFER10_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER12_ID', AC.SOB_ID) AS REFER10_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER12_ID, 'VALUE4'), 'VARCHAR2') AS REFER10_DATA_TYPE
           , AC.REFER13_ID AS REFER11_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER13_ID) AS REFER11_NAME
           , DECODE(AC.REFER13_ID, NULL, 'F', 'Y') AS REFER11_YN
           , NVL(AC.DR_NEED_YN13, 'N') AS REFER11_DR_YN
           , NVL(AC.CR_NEED_YN13, 'N') AS REFER11_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER13_ID, 'VALUE1'), 'N') AS REFER11_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER13_ID', AC.SOB_ID) AS REFER11_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER13_ID, 'VALUE4'), 'VARCHAR2') AS REFER11_DATA_TYPE
           , AC.REFER14_ID AS REFER12_ID
           , FI_COMMON_G.ID_NAME_F(AC.REFER14_ID) AS REFER12_NAME
           , DECODE(AC.REFER14_ID, NULL, 'F', 'Y') AS REFER12_YN
           , NVL(AC.DR_NEED_YN14, 'N') AS REFER12_DR_YN
           , NVL(AC.CR_NEED_YN14, 'N') AS REFER12_CR_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER14_ID, 'VALUE1'), 'N') AS REFER12_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_G.CONTROL_ITEM_LOOKUP_TYPE_F(AC.ACCOUNT_CONTROL_ID, 'REFER14_ID', AC.SOB_ID) AS REFER12_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(AC.REFER14_ID, 'VALUE4'), 'VARCHAR2') AS REFER12_DATA_TYPE
           , NVL(AC.CUSTOMER_ENABLED_FLAG, 'N') AS CUSTOMER_ENABLED_FLAG
           , NVL(AC.BANK_ACCOUNT_FLAG, 'N') AS BANK_ACCOUNT_FLAG
           , NVL(AC.CURRENCY_ENABLED_FLAG, 'N') AS CURRENCY_ENABLED_FLAG
           , NVL(AC.VAT_ENABLED_FLAG, 'N') AS VAT_ENABLED_FLAG
           , NVL(AC.ACCOUNT_MICH_YN, 'N') AS ACCOUNT_MICH_YN
           , NVL(AC.BUDGET_ENABLED_FLAG, 'N') AS BUDGET_ENABLED_FLAG
           , NVL(AC.BUDGET_CONTROL_FLAG, 'N') AS BUDGET_CONTROL_FLAG
           , NVL(AC.BUDGET_BELONG_FLAG, 'N') AS BUDGET_BELONG_FLAG
           , NVL(AC.COST_CENTER_FLAG, 'N') AS COST_CENTER_FLAG
           , SL.UNLIQUIDATE_SLIP_HEADER_ID
           , SL.UNLIQUIDATE_SLIP_LINE_ID
        FROM FI_SLIP_LINE SL
          , FI_SUPP_CUST_V SCV
          , FI_ACCOUNT_CONTROL AC
          , FI_BANK_ACCOUNT_TLV BAT
       WHERE SL.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND SL.BANK_ACCOUNT_ID         = BAT.BANK_ACCOUNT_ID(+)
         AND SL.SLIP_HEADER_ID          = W_SLIP_HEADER_ID
         AND SL.SOB_ID                  = W_SOB_ID
         AND NOT EXISTS ( SELECT 'X'
                            FROM FI_SLIP_TYPE_V ST
                          WHERE ST.SLIP_TYPE    = SL.SLIP_TYPE
                            AND ST.SOB_ID       = SL.SOB_ID
                            AND ST.SLIP_TYPE_CLASS = 'BL'
                        )
      ORDER BY SL.SLIP_LINE_SEQ
      ;
  END SELECT_SLIP_LINE;

-- 전표 라인  삽입.
  PROCEDURE INSERT_SLIP_LINE
            ( P_SLIP_LINE_ID               OUT FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , P_SLIP_HEADER_ID             IN FI_SLIP_LINE.SLIP_HEADER_ID%TYPE
            , P_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , P_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_REFER6                     IN FI_SLIP_LINE.REFER6%TYPE
            , P_REFER7                     IN FI_SLIP_LINE.REFER7%TYPE
            , P_REFER8                     IN FI_SLIP_LINE.REFER8%TYPE
            , P_REFER9                     IN FI_SLIP_LINE.REFER9%TYPE
            , P_REFER10                    IN FI_SLIP_LINE.REFER10%TYPE
            , P_REFER11                    IN FI_SLIP_LINE.REFER11%TYPE
            , P_REFER12                    IN FI_SLIP_LINE.REFER12%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            , P_LINE_TYPE                  IN FI_SLIP_LINE.LINE_TYPE%TYPE DEFAULT 'M'
            , P_SOURCE_TABLE               IN FI_SLIP_LINE.SOURCE_TABLE%TYPE DEFAULT NULL
            , P_SOURCE_HEADER_ID           IN FI_SLIP_LINE.SOURCE_HEADER_ID%TYPE DEFAULT NULL
            , P_SOURCE_LINE_ID             IN FI_SLIP_LINE.SOURCE_LINE_ID%TYPE DEFAULT NULL
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SLIP_DATE           FI_SLIP_LINE.SLIP_DATE%TYPE;
    V_SLIP_NUM            FI_SLIP_LINE.SLIP_NUM%TYPE;
    V_DEPT_ID             FI_SLIP_LINE.DEPT_ID%TYPE;
    V_PERSON_ID           FI_SLIP_LINE.PERSON_ID%TYPE;
    V_ACCOUNT_BOOK_ID     FI_SLIP_LINE.ACCOUNT_BOOK_ID%TYPE;
    V_SLIP_TYPE           FI_SLIP_LINE.SLIP_TYPE%TYPE;
    V_PERIOD_NAME         FI_SLIP_LINE.PERIOD_NAME%TYPE;
    V_CONFIRM_YN          FI_SLIP_LINE.CONFIRM_YN%TYPE;
    V_CONFIRM_DATE        FI_SLIP_LINE.CONFIRM_DATE%TYPE;
    V_CONFIRM_PERSON_ID   FI_SLIP_LINE.CONFIRM_PERSON_ID%TYPE;
    V_GL_DATE             FI_SLIP_LINE.GL_DATE%TYPE;
    V_GL_NUM              FI_SLIP_LINE.GL_NUM%TYPE;
    V_SLIP_LINE_SEQ       FI_SLIP_LINE.SLIP_LINE_SEQ%TYPE;
    
    V_BASE_CURRENCY_CODE  FI_SLIP_LINE.CURRENCY_CODE%TYPE;
    N_GL_AMOUNT           FI_SLIP_LINE.GL_AMOUNT%TYPE;
    
  BEGIN
    BEGIN
      SELECT SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.DEPT_ID
           , SH.PERSON_ID
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , SH.PERIOD_NAME
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , SH.CONFIRM_PERSON_ID
           , SH.GL_DATE
           , SH.GL_NUM
        INTO V_SLIP_DATE
            , V_SLIP_NUM
            , V_DEPT_ID
            , V_PERSON_ID
            , V_ACCOUNT_BOOK_ID
            , V_SLIP_TYPE
            , V_PERIOD_NAME
            , V_CONFIRM_YN
            , V_CONFIRM_DATE
            , V_CONFIRM_PERSON_ID
            , V_GL_DATE
            , V_GL_NUM
        FROM FI_SLIP_HEADER SH
       WHERE SH.SLIP_HEADER_ID    = P_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

/*RAISE_APPLICATION_ERROR(-20001, 'SLIP_DATE : ' || TO_CHAR(V_SLIP_DATE, 'YYYY-MM-DD') || ', ' || GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, P_SOB_ID, P_ORG_ID) || ', SOB : ' || P_SOB_ID);
    */
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
    END IF;

    -- 마감 여부 체크.
    IF SLIP_CLOSE_YN_F(P_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    -- 기본통화.
    V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
    -- 원화금액 환산.
    N_GL_AMOUNT := FI_COMMON_G.CONVERSION_BASE_AMOUNT_F
                        ( V_BASE_CURRENCY_CODE
                        , P_SOB_ID
                        , NVL(P_GL_AMOUNT, 0)
                        );
    
    -- 전표 라인 ID 채번.
    SELECT FI_SLIP_LINE_S1.NEXTVAL
      INTO P_SLIP_LINE_ID
      FROM DUAL;

    -- 전표 순서.
    BEGIN
      SELECT NVL(MAX(SL.SLIP_LINE_SEQ), 0) + 1 AS SLIP_LINE_SEQ
        INTO V_SLIP_LINE_SEQ
        FROM FI_SLIP_LINE SL
       WHERE SL.SLIP_HEADER_ID    = P_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SLIP_LINE_SEQ := 1;
    END;   

    INSERT INTO FI_SLIP_LINE
    ( SLIP_LINE_ID
    , SLIP_DATE
    , SLIP_NUM
    , SLIP_LINE_SEQ
    , SLIP_HEADER_ID
    , SOB_ID
    , ORG_ID
    , DEPT_ID
    , PERSON_ID
    , ACCOUNT_BOOK_ID
    , SLIP_TYPE
    , PERIOD_NAME
    , CONFIRM_YN
    , CONFIRM_DATE
    , CONFIRM_PERSON_ID
    , GL_DATE
    , GL_NUM
--    , CUSTOMER_ID
    , ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE
    , ACCOUNT_DR_CR
    , GL_AMOUNT
    , CURRENCY_CODE
    , EXCHANGE_RATE
    , GL_CURRENCY_AMOUNT
--    , BANK_ACCOUNT_ID
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
    , UNLIQUIDATE_SLIP_HEADER_ID
    , UNLIQUIDATE_SLIP_LINE_ID
    , LINE_TYPE
    , SOURCE_TABLE
    , SOURCE_HEADER_ID
    , SOURCE_LINE_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_SLIP_LINE_ID
    , V_SLIP_DATE
    , V_SLIP_NUM
    , V_SLIP_LINE_SEQ
    , P_SLIP_HEADER_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_DEPT_ID
    , V_PERSON_ID
    , V_ACCOUNT_BOOK_ID
    , V_SLIP_TYPE
    , V_PERIOD_NAME
    , V_CONFIRM_YN
    , V_CONFIRM_DATE
    , V_CONFIRM_PERSON_ID
    , V_GL_DATE
    , V_GL_NUM
--    , P_CUSTOMER_ID
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_ACCOUNT_DR_CR
    , N_GL_AMOUNT
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_GL_CURRENCY_AMOUNT
--    , P_BANK_ACCOUNT_ID
    , ISGETDATE(P_MANAGEMENT1)
    , ISGETDATE(P_MANAGEMENT2)
    , ISGETDATE(P_REFER1)
    , ISGETDATE(P_REFER2)
    , ISGETDATE(P_REFER3)
    , ISGETDATE(P_REFER4)
    , ISGETDATE(P_REFER5)
    , ISGETDATE(P_REFER6)
    , ISGETDATE(P_REFER7)
    , ISGETDATE(P_REFER8)
    , ISGETDATE(P_REFER9)
    , ISGETDATE(P_REFER10)
    , ISGETDATE(P_REFER11)
    , ISGETDATE(P_REFER12)
    , P_REMARK
    , P_UNLIQUIDATE_SLIP_HEADER_ID
    , P_UNLIQUIDATE_SLIP_LINE_ID
    , P_LINE_TYPE
    , P_SOURCE_TABLE
    , P_SOURCE_HEADER_ID
    , P_SOURCE_LINE_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

    /*-- 전표 헤더 수정.
    UPDATE FI_SLIP_HEADER
      SET GL_AMOUNT           = DECODE(P_ACCOUNT_DR_CR, '1', NVL(P_GL_AMOUNT, 0), 0)
        , CURRENCY_CODE       = P_CURRENCY_CODE
        , EXCHANGE_RATE       = P_EXCHANGE_RATE
        , GL_CURRENCY_AMOUNT  =  NVL(GL_CURRENCY_AMOUNT, 0) + DECODE(P_ACCOUNT_DR_CR, '1', NVL(P_GL_CURRENCY_AMOUNT, 0), 0)
    WHERE SLIP_HEADER_ID      = P_SLIP_HEADER_ID
    ;*/

    -- 전표 헤더 수정.
    UPDATE FI_SLIP_HEADER SH
      SET (SH.GL_AMOUNT, SH.CURRENCY_CODE, SH.EXCHANGE_RATE, SH.GL_CURRENCY_AMOUNT)
          =
          (SELECT SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0))
                , P_CURRENCY_CODE
                , P_EXCHANGE_RATE
                , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0))
             FROM FI_SLIP_LINE SL
           WHERE SL.SLIP_HEADER_ID  = SH.SLIP_HEADER_ID
          )
    WHERE SLIP_HEADER_ID      = P_SLIP_HEADER_ID
    ;
  END INSERT_SLIP_LINE;

-- 전표라인 수정.
  PROCEDURE UPDATE_SLIP_LINE
            ( W_SLIP_LINE_ID               IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            , W_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE               IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT                  IN FI_SLIP_LINE.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE              IN FI_SLIP_LINE.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE              IN FI_SLIP_LINE.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT         IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_REFER6                     IN FI_SLIP_LINE.REFER6%TYPE
            , P_REFER7                     IN FI_SLIP_LINE.REFER7%TYPE
            , P_REFER8                     IN FI_SLIP_LINE.REFER8%TYPE
            , P_REFER9                     IN FI_SLIP_LINE.REFER9%TYPE
            , P_REFER10                    IN FI_SLIP_LINE.REFER10%TYPE
            , P_REFER11                    IN FI_SLIP_LINE.REFER11%TYPE
            , P_REFER12                    IN FI_SLIP_LINE.REFER12%TYPE
            , P_REMARK                     IN FI_SLIP_LINE.REMARK%TYPE
            , P_UNLIQUIDATE_SLIP_HEADER_ID IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_HEADER_ID%TYPE
            , P_UNLIQUIDATE_SLIP_LINE_ID   IN FI_SLIP_LINE.UNLIQUIDATE_SLIP_LINE_ID%TYPE
            , P_FUND_CODE                  IN FI_SLIP_LINE.FUND_CODE%TYPE
            , P_USER_ID                    IN FI_SLIP_LINE.CREATED_BY%TYPE
            )
  AS
    V_SLIP_DATE           FI_SLIP_LINE.SLIP_DATE%TYPE;
    V_SLIP_NUM            FI_SLIP_LINE.SLIP_NUM%TYPE;
    V_SLIP_HEADER_ID      FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;
    V_GL_DATE             FI_SLIP_LINE.GL_DATE%TYPE;
    V_GL_NUM              FI_SLIP_LINE.GL_NUM%TYPE;
    V_PERIOD_NAME         FI_SLIP_LINE.PERIOD_NAME%TYPE;
    
    V_BASE_CURRENCY_CODE  FI_SLIP_LINE.CURRENCY_CODE%TYPE;
    N_GL_AMOUNT           FI_SLIP_LINE.GL_AMOUNT%TYPE;
    
  BEGIN
    BEGIN
      SELECT SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.SLIP_HEADER_ID
           , SH.GL_DATE
           , SH.GL_NUM
           , SH.PERIOD_NAME
        INTO V_SLIP_DATE
           , V_SLIP_NUM
           , V_SLIP_HEADER_ID
           , V_GL_DATE
           , V_GL_NUM
           , V_PERIOD_NAME
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_LINE SL
       WHERE SH.SLIP_HEADER_ID    = SL.SLIP_HEADER_ID
         AND SL.SLIP_LINE_ID      = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, W_SOB_ID, W_ORG_ID) IN('C', 'N') THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
    END IF;

    IF SLIP_CLOSE_YN_F(V_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    -- 기본통화.
    V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    -- 원화금액 환산.
    N_GL_AMOUNT := FI_COMMON_G.CONVERSION_BASE_AMOUNT_F
                        ( V_BASE_CURRENCY_CODE
                        , W_SOB_ID
                        , NVL(P_GL_AMOUNT, 0)
                        );
                        
    UPDATE FI_SLIP_LINE
      SET SLIP_DATE                  = V_SLIP_DATE
        , SLIP_NUM                   = V_SLIP_NUM
        , GL_DATE                    = V_GL_DATE
        , GL_NUM                     = V_GL_NUM
        , PERIOD_NAME                = V_PERIOD_NAME
        , ACCOUNT_CONTROL_ID         = P_ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE               = P_ACCOUNT_CODE
        , ACCOUNT_DR_CR              = P_ACCOUNT_DR_CR
        , GL_AMOUNT                  = N_GL_AMOUNT
        , CURRENCY_CODE              = P_CURRENCY_CODE
        , EXCHANGE_RATE              = P_EXCHANGE_RATE
        , GL_CURRENCY_AMOUNT         = P_GL_CURRENCY_AMOUNT
        , MANAGEMENT1                = ISGETDATE(P_MANAGEMENT1)
        , MANAGEMENT2                = ISGETDATE(P_MANAGEMENT2)
        , REFER1                     = ISGETDATE(P_REFER1)
        , REFER2                     = ISGETDATE(P_REFER2)
        , REFER3                     = ISGETDATE(P_REFER3)
        , REFER4                     = ISGETDATE(P_REFER4)
        , REFER5                     = ISGETDATE(P_REFER5)
        , REFER6                     = ISGETDATE(P_REFER6)
        , REFER7                     = ISGETDATE(P_REFER7)
        , REFER8                     = ISGETDATE(P_REFER8)
        , REFER9                     = ISGETDATE(P_REFER9)
        , REFER10                    = ISGETDATE(P_REFER10)
        , REFER11                    = ISGETDATE(P_REFER11)
        , REFER12                    = ISGETDATE(P_REFER12)        
        , REMARK                     = P_REMARK
        , UNLIQUIDATE_SLIP_HEADER_ID = P_UNLIQUIDATE_SLIP_HEADER_ID
        , UNLIQUIDATE_SLIP_LINE_ID   = P_UNLIQUIDATE_SLIP_LINE_ID
        , FUND_CODE                  = P_FUND_CODE
        , LAST_UPDATE_DATE           = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY            = P_USER_ID
    WHERE SLIP_LINE_ID               = W_SLIP_LINE_ID;

    -- 전표 헤더 수정.
    UPDATE FI_SLIP_HEADER SH
      SET (SH.GL_AMOUNT, SH.CURRENCY_CODE, SH.EXCHANGE_RATE, SH.GL_CURRENCY_AMOUNT)
          =
          (SELECT SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0))
                , P_CURRENCY_CODE
                , P_EXCHANGE_RATE
                , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0))
             FROM FI_SLIP_LINE SL
           WHERE SL.SLIP_HEADER_ID  = SH.SLIP_HEADER_ID
          )
    WHERE SLIP_HEADER_ID      = V_SLIP_HEADER_ID
    ;
  END UPDATE_SLIP_LINE;

-- 전표 라인 삭제.
  PROCEDURE DELETE_SLIP_LINE
            ( W_SLIP_LINE_ID      IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
            )
  AS
    V_SLIP_HEADER_ID              FI_SLIP_LINE.SLIP_HEADER_ID%TYPE;

  BEGIN
    BEGIN
      SELECT SL.SLIP_HEADER_ID
        INTO V_SLIP_HEADER_ID
        FROM FI_SLIP_LINE SL
       WHERE SL.SLIP_LINE_ID      = W_SLIP_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

    IF SLIP_CLOSE_YN_F(V_SLIP_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;

    DELETE FI_SLIP_LINE
    WHERE SLIP_LINE_ID = W_SLIP_LINE_ID;
  END DELETE_SLIP_LINE;

-- 전표 관리항목 삽입 : 전표 라인 트리거에서 호출함..
  PROCEDURE INSERT_MANAGEMENT_ITEM
            ( P_SLIP_LINE_ID            IN FI_SLIP_MANAGEMENT_ITEM.SLIP_LINE_ID%TYPE
            , P_SLIP_DATE               IN FI_SLIP_MANAGEMENT_ITEM.SLIP_DATE%TYPE
            , P_SLIP_NUM                IN FI_SLIP_MANAGEMENT_ITEM.SLIP_NUM%TYPE
            , P_SLIP_LINE_SEQ           IN FI_SLIP_MANAGEMENT_ITEM.SLIP_LINE_SEQ%TYPE
            , P_SLIP_HEADER_ID          IN FI_SLIP_MANAGEMENT_ITEM.SLIP_HEADER_ID%TYPE
            , P_SOB_ID                  IN FI_SLIP_MANAGEMENT_ITEM.SOB_ID%TYPE
            , P_MANAGEMENT_SEQ          IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_SEQ%TYPE
            , P_MANAGEMENT_ID           IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_ID%TYPE
            , P_MANAGEMENT_VALUE        IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_VALUE%TYPE
            , P_GL_DATE                 IN FI_SLIP_MANAGEMENT_ITEM.GL_DATE%TYPE
            , P_GL_NUM                  IN FI_SLIP_MANAGEMENT_ITEM.GL_NUM%TYPE
            , P_USER_ID                 IN FI_SLIP_MANAGEMENT_ITEM.CREATED_BY%TYPE
            )
  AS
    V_RECORD_COUNT                      NUMBER := 0;
    V_SYSDATE                           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_MANAGEMENT_CODE                   VARCHAR2(70) := NULL;    
  BEGIN
    V_MANAGEMENT_CODE := FI_COMMON_G.GET_CODE_F(P_MANAGEMENT_ID, P_SOB_ID);
    
    -- 신규 INSERT.
    INSERT INTO FI_SLIP_MANAGEMENT_ITEM
    ( SLIP_LINE_ID
    , SLIP_DATE
    , SLIP_NUM
    , SLIP_LINE_SEQ
    , SLIP_HEADER_ID
    , SOB_ID
    , MANAGEMENT_SEQ
    , MANAGEMENT_ID
    , MANAGEMENT_CODE
    , MANAGEMENT_VALUE
    , GL_DATE
    , GL_NUM
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_SLIP_LINE_ID
    , P_SLIP_DATE
    , P_SLIP_NUM
    , P_SLIP_LINE_SEQ
    , P_SLIP_HEADER_ID
    , P_SOB_ID
    , P_MANAGEMENT_SEQ
    , P_MANAGEMENT_ID
    , V_MANAGEMENT_CODE
    , P_MANAGEMENT_VALUE
    , P_GL_DATE
    , P_GL_NUM
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
  END INSERT_MANAGEMENT_ITEM;

-- 전표 관리항목 삭제.
  PROCEDURE DELETE_MANAGEMENT_ITEM
            ( W_SLIP_LINE_ID            IN FI_SLIP_MANAGEMENT_ITEM.SLIP_LINE_ID%TYPE
            , W_SOB_ID                  IN FI_SLIP_MANAGEMENT_ITEM.SOB_ID%TYPE
            , W_MANAGEMENT_SEQ          IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_SEQ%TYPE
            )
  AS
  BEGIN
    -- 기존 자료 삭제.
    DELETE FROM FI_SLIP_MANAGEMENT_ITEM MI
    WHERE MI.SLIP_LINE_ID         = W_SLIP_LINE_ID
      AND MI.MANAGEMENT_SEQ       = W_MANAGEMENT_SEQ
      AND MI.SOB_ID               = W_SOB_ID
    ;
  END DELETE_MANAGEMENT_ITEM;

-- 관리항목 CODE, DATA TYPE 리턴.
  PROCEDURE MANAGEMENT_DATA_TYPE_P
            ( W_MANAGEMENT_ID           IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_ID%TYPE
            , W_SOB_ID                  IN FI_SLIP_MANAGEMENT_ITEM.SOB_ID%TYPE
            , O_MANAGEMENT_CODE         OUT VARCHAR2
            , O_DATA_TYPE               OUT VARCHAR2
            )
  AS
  BEGIN
    BEGIN
      SELECT MC.MANAGEMENT_CODE, MC.DATA_TYPE
        INTO O_MANAGEMENT_CODE, O_DATA_TYPE
        FROM FI_MANAGEMENT_CODE_V MC
      WHERE MC.MANAGEMENT_ID      = W_MANAGEMENT_ID
        AND MC.SOB_ID             = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MANAGEMENT_CODE := NULL;
      O_DATA_TYPE := 'VARCHAR2';
    END;
  END MANAGEMENT_DATA_TYPE_P;

---------------------------------------------------------------------------------------------------
-- 전표 라인 조회.
  PROCEDURE SELECT_SLIP_LINE_ACCOUNT_ID
            ( P_CURSOR1            OUT TYPES.TCURSOR1
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CONTROL_ID IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SL.GL_DATE
           , SL.SLIP_NUM
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SMV.CUSTOMER_NAME
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.REMARK
           , SL.ACCOUNT_CONTROL_ID
           , SL.SLIP_HEADER_ID
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MGMT_VENDOR_V SMV
      WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
        AND SL.GL_DATE                  BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
        AND SL.ACCOUNT_CONTROL_ID       = W_ACCOUNT_CONTROL_ID
        AND SL.SOB_ID                   = W_SOB_ID
      ;
  END SELECT_SLIP_LINE_ACCOUNT_ID;

-- 전표 라인 조회 날짜 범위 및 계정 코드 범위.
  PROCEDURE SELECT_SLIP_LINE_ACCOUNT_CODE
            ( P_CURSOR2            OUT TYPES.TCURSOR2
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT SL.GL_DATE
           , SL.SLIP_NUM
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SMV.CUSTOMER_NAME
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.REMARK
           , SL.ACCOUNT_CONTROL_ID
           , SL.SLIP_HEADER_ID
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MGMT_VENDOR_V SMV
      WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
        AND SL.GL_DATE                  BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
        AND SL.ACCOUNT_CODE             BETWEEN NVL(W_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
        AND SL.SOB_ID                   = W_SOB_ID
      ORDER BY SL.GL_DATE, SL.ACCOUNT_CODE
      ;
  END SELECT_SLIP_LINE_ACCOUNT_CODE;

-- 전표 라인 조회 날짜 범위 및 계정 코드 범위 거래처코드.
  PROCEDURE SELECT_SLIP_ACCOUNT_CUST_CODE
            ( P_CURSOR2            OUT TYPES.TCURSOR2
            , W_SOB_ID             IN FI_SLIP_LINE.SOB_ID%TYPE
            , W_ORG_ID             IN FI_SLIP_LINE.ORG_ID%TYPE
            , W_GL_DATE_FR         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_GL_DATE_TO         IN FI_SLIP_LINE.GL_DATE%TYPE
            , W_ACCOUNT_CODE_FR    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , W_ACCOUNT_CODE_TO    IN FI_SLIP_LINE.ACCOUNT_CODE%TYPE
            , W_CUSTOMER_CODE      IN FI_SLIP_MANAGEMENT_ITEM.MANAGEMENT_VALUE%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT SL.GL_DATE
           , SL.SLIP_NUM
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SMV.CUSTOMER_NAME
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.REMARK
           , SL.ACCOUNT_CONTROL_ID
           , SL.SLIP_HEADER_ID
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MGMT_VENDOR_V SMV
      WHERE SL.ACCOUNT_CONTROL_ID       = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID             = SMV.SLIP_LINE_ID(+)
        AND SL.GL_DATE                  BETWEEN W_GL_DATE_FR AND W_GL_DATE_TO
        AND SL.ACCOUNT_CODE             BETWEEN NVL(W_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(W_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
        AND SL.SOB_ID                   = W_SOB_ID
        AND SMV.CUSTOMER_CODE           = W_CUSTOMER_CODE
      ORDER BY SL.GL_DATE, SL.ACCOUNT_CODE
      ;
  END SELECT_SLIP_ACCOUNT_CUST_CODE;

-- 전표 라인 조회 : 분개 정보.
  PROCEDURE SELECT_SLIP_LINE_JOURNALIZE
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_GL_DATE_FR        IN DATE
            , P_GL_DATE_TO        IN DATE
            , P_ACCOUNT_CODE_FR   IN VARCHAR2
            , P_ACCOUNT_CODE_TO   IN VARCHAR2
            , P_SLIP_HEADER_ID    IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER            
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT CASE
               WHEN GROUPING(SL.GL_NUM) = 1 THEN TO_CHAR(NULL)
               WHEN GROUPING(SL.ACCOUNT_CODE) = 1 THEN TO_CHAR(NULL)
               ELSE TO_CHAR(SL.GL_DATE, 'YYYY-MM-DD')
             END AS GL_DATE     
           , SL.ACCOUNT_CODE     
           , CASE
               WHEN GROUPING(SL.GL_NUM) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(SL.ACCOUNT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10258', NULL)
               ELSE AC.ACCOUNT_DESC
             END AS ACCOUNT_DESC
           , MI.SUPP_CUST_CODE
           , MI.SUPP_CUST_NAME
           , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL)) AS DR_AMOUNT
           , SUM(DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL)) AS CR_AMOUNT                     
           , SL.REMARK     
           , SL.GL_NUM
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SL.SLIP_TYPE, SL.SOB_ID) AS SLIP_TYPE_NAME
           , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID) AS PERSON_NAME
           , TO_CHAR(SL.SLIP_HEADER_ID) AS SLIP_HEADER_ID
        FROM FI_SLIP_LINE                          SL
           , FI_ACCOUNT_CONTROL                    AC
           , ( SELECT SMI.SLIP_LINE_ID
                    , SMI.MANAGEMENT_VALUE AS SUPP_CUST_CODE
                    , ( SELECT SC.SUPP_CUST_NAME
                          FROM FI_SUPP_CUST_V      SC
                        WHERE SC.SUPP_CUST_CODE   = SMI.MANAGEMENT_VALUE
                          AND SC.SOB_ID           = SMI.SOB_ID
                      ) AS SUPP_CUST_NAME
                 FROM FI_SLIP_MANAGEMENT_ITEM      SMI
                   , FI_MANAGEMENT_CODE_V          MC
               WHERE SMI.MANAGEMENT_ID            = MC.MANAGEMENT_ID
                 AND MC.LOOKUP_TYPE               = 'CUSTOMER'
                 AND SMI.SOB_ID                   = P_SOB_ID
             ) MI                     
      WHERE SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID                     = MI.SLIP_LINE_ID(+) 
        AND SL.GL_DATE                          BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
        AND SL.SOB_ID                           = P_SOB_ID
        AND SL.ACCOUNT_CODE                     BETWEEN NVL(P_ACCOUNT_CODE_FR, SL.ACCOUNT_CODE) AND NVL(P_ACCOUNT_CODE_TO, SL.ACCOUNT_CODE)
        AND SL.SLIP_HEADER_ID                   = NVL(P_SLIP_HEADER_ID, SL.SLIP_HEADER_ID)
        AND SL.PERSON_ID                        = NVL(P_PERSON_ID, SL.PERSON_ID)
        AND SL.CONFIRM_YN                       = 'Y'
      GROUP BY ROLLUP((SL.GL_DATE
           , SL.GL_NUM)
           , (SL.SLIP_LINE_SEQ
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SL.SLIP_TYPE, SL.SOB_ID)
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SL.REMARK
           , MI.SUPP_CUST_CODE
           , MI.SUPP_CUST_NAME
           , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID)
           , SL.SLIP_HEADER_ID))
      ORDER BY SL.GL_DATE, SL.GL_NUM, SL.SLIP_LINE_SEQ
      ;
  END SELECT_SLIP_LINE_JOURNALIZE;

-- 전표 조회 : 관리항목별.
  PROCEDURE SELECT_SLIP_MANAGEMENT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , P_GL_DATE_FR        IN DATE
            , P_GL_DATE_TO        IN DATE
            , P_ACCOUNT_CODE_FR   IN VARCHAR2
            , P_ACCOUNT_CODE_TO   IN VARCHAR2
            , P_SLIP_HEADER_ID    IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_GL_AMOUNT_FR      IN NUMBER
            , P_GL_AMOUNT_TO      IN NUMBER
            , P_LOOKUP_YN         IN VARCHAR2
            , P_MANAGEMENT_ID     IN NUMBER
            , P_MANAGEMENT_VALUE  IN VARCHAR2
            , P_MANAGEMENT_DESC   IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
/*    RAISE_APPLICATION_ERROR(-20001, '//' || P_MANAGEMENT_DESC);*/
    OPEN P_CURSOR2 FOR
      SELECT SH.GL_NUM
           , TO_CHAR(SH.GL_DATE, 'YYYY-MM-DD') AS GL_DATE
           , SH.REMARK AS HEADER_REMARK
           , SL.ACCOUNT_CODE     
           , AC.ACCOUNT_DESC AS ACCOUNT_DESC
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT) AS CR_AMOUNT                     
           , SL.REMARK
           , SL.CURRENCY_CODE
           , SL.EXCHANGE_RATE
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT) AS CURR_DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_CURRENCY_AMOUNT) AS CURR_CR_AMOUNT
           , HRM_PERSON_MASTER_G.NAME_F(SL.PERSON_ID) AS PERSON_NAME
           , SL.SLIP_HEADER_ID AS SLIP_HEADER_ID
           , SX1.MANAGEMENT_01
           , SX1.MANAGEMENT_02
           , SX1.MANAGEMENT_03
           , SX1.MANAGEMENT_04
           , SX1.MANAGEMENT_05
           , SX1.MANAGEMENT_06
           , SX1.MANAGEMENT_07
           , SX1.MANAGEMENT_08
           , SX1.MANAGEMENT_09
           , SX1.MANAGEMENT_10
           , SX1.MANAGEMENT_11
           , SX1.MANAGEMENT_12
           , SX1.MANAGEMENT_13
           , SX1.MANAGEMENT_14
           , SX1.MANAGEMENT_15
           , SX1.MANAGEMENT_16
           , SX1.MANAGEMENT_17
           , SX1.MANAGEMENT_18
           , SX1.MANAGEMENT_19
           , SX1.MANAGEMENT_20
           , SX1.MANAGEMENT_21
           , SX1.MANAGEMENT_22
           , SX1.MANAGEMENT_23
           , SX1.MANAGEMENT_24
           , SX1.MANAGEMENT_25
           , SX1.MANAGEMENT_26
           , SX1.MANAGEMENT_27
           , SX1.MANAGEMENT_28
           , SX1.MANAGEMENT_29
           , SX1.MANAGEMENT_30
           , SX1.MANAGEMENT_31
           , SX1.MANAGEMENT_32
           , SX1.MANAGEMENT_33
           , SX1.MANAGEMENT_34
           , SX1.MANAGEMENT_35
           , SX1.MANAGEMENT_36
           , SX1.MANAGEMENT_37
           , SX1.MANAGEMENT_38
           , SX1.MANAGEMENT_39
        FROM FI_SLIP_HEADER                        SH
           , FI_SLIP_LINE                          SL
           , FI_ACCOUNT_CONTROL                    AC
           , ( SELECT S_SM.SLIP_LINE_ID
                    , S_SM.SOB_ID
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '01', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_01
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '02', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_02
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '03', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_03
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '04', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_04
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '05', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_05
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '06', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_06
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '07', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_07
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '08', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_08
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '09', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_09
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '10', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_10
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '11', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_11
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '12', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_12
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '13', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_13
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '14', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_14
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '15', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_15
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '16', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_16
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '17', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_17
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '18', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_18
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '19', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_19
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '20', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_20
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '21', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_21
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '22', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_22
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '23', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_23
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '24', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_24
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '25', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_25
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '26', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_26
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '27', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_27
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '28', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_28
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '29', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_29
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '30', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_30
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '31', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_31
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '32', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_32
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '33', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_33
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '34', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_34
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '35', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_35
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '36', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_36
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '37', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_37
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '38', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_38
                    , MAX(DECODE(S_SM.MANAGEMENT_CODE, '39', S_SM.MANAGEMENT_VALUE)) AS MANAGEMENT_39
                 FROM (SELECT SM.SLIP_LINE_ID
                            , SM.SOB_ID
                            , MC.MANAGEMENT_CODE
                            , CASE MC.DATA_TYPE
                                WHEN 'NUMBER' THEN TO_CHAR(TO_NUMBER(SM.MANAGEMENT_VALUE), 'FM999,999,999,999,999,999')
                                WHEN 'RATE' THEN 
                                   CASE 
                                     WHEN TO_NUMBER(SM.MANAGEMENT_VALUE) - FLOOR(SM.MANAGEMENT_VALUE) = 0 THEN TO_CHAR(TO_NUMBER(SM.MANAGEMENT_VALUE), 'FM999,999,999,999,999,999')
                                     ELSE TO_CHAR(TO_NUMBER(SM.MANAGEMENT_VALUE), 'FM999,999,999,999,999,999.9999')
                                   END
                                ELSE NVL(FI_ACCOUNT_CONTROL_G.ITEM_DESC_F(MC.LOOKUP_TYPE, SM.MANAGEMENT_VALUE, SM.SOB_ID), SM.MANAGEMENT_VALUE)
                              END AS MANAGEMENT_VALUE
                         FROM FI_SLIP_MANAGEMENT_ITEM SM
                           , FI_MANAGEMENT_CODE_V MC
                       WHERE SM.MANAGEMENT_ID       = MC.MANAGEMENT_ID
                         AND SM.GL_DATE             BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
                         AND SM.SOB_ID              = P_SOB_ID
                         AND SM.SLIP_HEADER_ID      = NVL(P_SLIP_HEADER_ID, SM.SLIP_HEADER_ID)
                      ) S_SM
               GROUP BY S_SM.SLIP_LINE_ID
                    , S_SM.SOB_ID
             ) SX1
      WHERE SH.SLIP_HEADER_ID                   = SL.SLIP_HEADER_ID
        AND SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID                     = SX1.SLIP_LINE_ID(+)
        AND SL.GL_DATE                          BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
        AND SL.SOB_ID                           = P_SOB_ID
        AND AC.ACCOUNT_CODE                     BETWEEN NVL(P_ACCOUNT_CODE_FR, AC.ACCOUNT_CODE) AND NVL(P_ACCOUNT_CODE_TO, AC.ACCOUNT_CODE)
        AND SL.SLIP_HEADER_ID                   = NVL(P_SLIP_HEADER_ID, SL.SLIP_HEADER_ID)
        AND SL.PERSON_ID                        = NVL(P_PERSON_ID, SL.PERSON_ID)
        AND SL.CONFIRM_YN                       = 'Y'
        AND SL.GL_AMOUNT                        BETWEEN NVL(P_GL_AMOUNT_FR, SL.GL_AMOUNT) AND NVL(P_GL_AMOUNT_TO, SL.GL_AMOUNT)
        AND EXISTS 
              ( SELECT 'X'
                   FROM FI_SLIP_MANAGEMENT_ITEM SM
                     , FI_MANAGEMENT_CODE_V MC
                 WHERE SM.MANAGEMENT_ID       = MC.MANAGEMENT_ID
                   AND SM.SLIP_LINE_ID        = SL.SLIP_LINE_ID
                   AND SM.GL_DATE             BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
                   AND SM.SOB_ID              = P_SOB_ID
                   AND SM.SLIP_HEADER_ID      = NVL(P_SLIP_HEADER_ID, SM.SLIP_HEADER_ID)
                   AND SM.MANAGEMENT_ID      = NVL(P_MANAGEMENT_ID, SM.MANAGEMENT_ID)
                   AND (( P_LOOKUP_YN      = 'Y'
                     AND (( P_MANAGEMENT_VALUE IS NULL AND 1 = 1)
                       OR ( P_MANAGEMENT_VALUE IS NOT NULL AND SM.MANAGEMENT_VALUE  = NVL(P_MANAGEMENT_VALUE, SM.MANAGEMENT_VALUE))))
                     OR (NVL(P_LOOKUP_YN, 'N') = 'N'
                     AND SM.MANAGEMENT_VALUE  LIKE P_MANAGEMENT_DESC || '%'))
              )
      ORDER BY SL.GL_DATE, SL.GL_NUM, SL.SLIP_LINE_SEQ
      ;
  END SELECT_SLIP_MANAGEMENT;

-- 전표 조회 : 관리항목 PROMPT 조회.
  PROCEDURE SELECT_SLIP_MANAGEMENT_YN
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , P_GL_DATE_FR        IN DATE
            , P_GL_DATE_TO        IN DATE
            , P_ACCOUNT_CODE_FR   IN VARCHAR2
            , P_ACCOUNT_CODE_TO   IN VARCHAR2
            , P_SLIP_HEADER_ID    IN NUMBER
            , P_PERSON_ID         IN NUMBER
            , P_GL_AMOUNT_FR      IN NUMBER
            , P_GL_AMOUNT_TO      IN NUMBER
            , P_LOOKUP_YN         IN VARCHAR2
            , P_MANAGEMENT_ID     IN NUMBER
            , P_MANAGEMENT_VALUE  IN VARCHAR2
            , P_MANAGEMENT_DESC   IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT SM.SOB_ID
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '01', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_01
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '02', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_02
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '03', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_03
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '04', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_04
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '05', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_05
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '06', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_06
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '07', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_07
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '08', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_08
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '09', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_09
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '10', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_10
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '11', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_11
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '12', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_12
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '13', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_13
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '14', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_14
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '15', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_15
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '16', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_16
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '17', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_17
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '18', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_18
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '19', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_19
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '20', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_20
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '21', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_21
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '22', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_22
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '23', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_23
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '24', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_24
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '25', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_25
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '26', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_26
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '27', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_27
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '28', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_28
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '29', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_29
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '30', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_30
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '31', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_31
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '32', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_32
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '33', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_33
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '34', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_34
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '35', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_35
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '36', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_36
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '37', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_37
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '38', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_38
          , NVL(MAX(DECODE(SM.MANAGEMENT_CODE, '39', SM.MANAGEMENT_VALUE)), ':=') AS MANAGEMENT_YN_39
        FROM FI_SLIP_LINE SL
          , FI_ACCOUNT_CONTROL AC
          , FI_SLIP_MANAGEMENT_ITEM SM
      WHERE SL.ACCOUNT_CONTROL_ID = AC.ACCOUNT_CONTROL_ID
        AND SL.SLIP_LINE_ID       = SM.SLIP_LINE_ID
        AND SL.GL_DATE                          BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
        AND SL.SOB_ID                           = P_SOB_ID
        AND AC.ACCOUNT_CODE                     BETWEEN NVL(P_ACCOUNT_CODE_FR, AC.ACCOUNT_CODE) AND NVL(P_ACCOUNT_CODE_TO, AC.ACCOUNT_CODE)
        AND SL.SLIP_HEADER_ID                   = NVL(P_SLIP_HEADER_ID, SL.SLIP_HEADER_ID)
        AND SL.PERSON_ID                        = NVL(P_PERSON_ID, SL.PERSON_ID)
        AND SL.CONFIRM_YN                       = 'Y'
        AND SL.GL_AMOUNT                        BETWEEN NVL(P_GL_AMOUNT_FR, SL.GL_AMOUNT) AND NVL(P_GL_AMOUNT_TO, SL.GL_AMOUNT)
        AND EXISTS 
              ( SELECT 'X'
                   FROM FI_SLIP_MANAGEMENT_ITEM SM
                     , FI_MANAGEMENT_CODE_V MC
                 WHERE SM.MANAGEMENT_ID       = MC.MANAGEMENT_ID
                   AND SM.SLIP_LINE_ID        = SL.SLIP_LINE_ID
                   AND SM.GL_DATE             BETWEEN P_GL_DATE_FR AND P_GL_DATE_TO
                   AND SM.SOB_ID              = P_SOB_ID
                   AND SM.SLIP_HEADER_ID      = NVL(P_SLIP_HEADER_ID, SM.SLIP_HEADER_ID)
                   AND SM.MANAGEMENT_ID      = NVL(P_MANAGEMENT_ID, SM.MANAGEMENT_ID)
                   AND (( P_LOOKUP_YN      = 'Y'
                     AND (( P_MANAGEMENT_VALUE IS NULL AND 1 = 1)
                       OR ( P_MANAGEMENT_VALUE IS NOT NULL AND SM.MANAGEMENT_VALUE  = NVL(P_MANAGEMENT_VALUE, SM.MANAGEMENT_VALUE))))
                     OR (NVL(P_LOOKUP_YN, 'N') = 'N'
                     AND SM.MANAGEMENT_VALUE  LIKE P_MANAGEMENT_DESC || '%'))
              )
      GROUP BY SM.SOB_ID
      ;
  END SELECT_SLIP_MANAGEMENT_YN;

---------------------------------------------------------------------------------------------------
-- 계정 통제관리값 : LOOKUP TYPE에 따른 해당 값 리턴..
  FUNCTION SLIP_ITEM_VALUE_F
          ( W_SLIP_LINE_ID        IN FI_SLIP_LINE.SLIP_LINE_ID%TYPE
          , W_LOOKUP_TYPE         IN VARCHAR2
          , W_SOB_ID              IN FI_SLIP_LINE.SOB_ID%TYPE
          ) RETURN VARCHAR2
  AS
    V_ITEM_VALUE                  VARCHAR2(150) := NULL;
  BEGIN
    BEGIN
      SELECT SMI.MANAGEMENT_VALUE
        INTO V_ITEM_VALUE
        FROM FI_SLIP_MANAGEMENT_ITEM SMI
      WHERE SMI.SOB_ID          = W_SOB_ID
        AND SMI.SLIP_LINE_ID    = W_SLIP_LINE_ID
        AND EXISTS( SELECT 'X'
                      FROM FI_MANAGEMENT_CODE_V MC
                    WHERE MC.MANAGEMENT_ID    = SMI.MANAGEMENT_ID
                      AND MC.SOB_ID           = SMI.SOB_ID
                      AND MC.LOOKUP_TYPE      = W_LOOKUP_TYPE
                  )
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_ITEM_VALUE;
  END SLIP_ITEM_VALUE_F;

-- 전표 저장전 관리항목 값 리턴.
  FUNCTION SLIP_ITEM_F
            ( W_LOOKUP_TYPE                IN VARCHAR2
            , P_SOB_ID                     IN FI_SLIP_LINE.SOB_ID%TYPE
            , P_ORG_ID                     IN FI_SLIP_LINE.ORG_ID%TYPE
            , P_ACCOUNT_CONTROL_ID         IN FI_SLIP_LINE.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_DR_CR              IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_MANAGEMENT1                IN FI_SLIP_LINE.MANAGEMENT1%TYPE
            , P_MANAGEMENT2                IN FI_SLIP_LINE.MANAGEMENT2%TYPE
            , P_REFER1                     IN FI_SLIP_LINE.REFER1%TYPE
            , P_REFER2                     IN FI_SLIP_LINE.REFER2%TYPE
            , P_REFER3                     IN FI_SLIP_LINE.REFER3%TYPE
            , P_REFER4                     IN FI_SLIP_LINE.REFER4%TYPE
            , P_REFER5                     IN FI_SLIP_LINE.REFER5%TYPE
            , P_REFER6                     IN FI_SLIP_LINE.REFER6%TYPE
            , P_REFER7                     IN FI_SLIP_LINE.REFER7%TYPE
            , P_REFER8                     IN FI_SLIP_LINE.REFER8%TYPE
            , P_REFER9                     IN FI_SLIP_LINE.REFER9%TYPE
            , P_REFER10                     IN FI_SLIP_LINE.REFER10%TYPE
            , P_REFER11                     IN FI_SLIP_LINE.REFER11%TYPE
            , P_REFER12                     IN FI_SLIP_LINE.REFER12%TYPE
            , P_REFER13                     IN FI_SLIP_LINE.REFER13%TYPE
            ) RETURN VARCHAR2
  AS
    V_ITEM_VALUE                  VARCHAR2(50) := NULL;
  BEGIN
    BEGIN  
      SELECT CASE W_LOOKUP_TYPE
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'MANAGEMENT1_ID', P_SOB_ID) THEN P_MANAGEMENT1
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'MANAGEMENT2_ID', P_SOB_ID) THEN P_MANAGEMENT2
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER1_ID', P_SOB_ID) THEN P_REFER1
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER2_ID', P_SOB_ID) THEN P_REFER2
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER3_ID', P_SOB_ID) THEN P_REFER3
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER4_ID', P_SOB_ID) THEN P_REFER4
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER5_ID', P_SOB_ID) THEN P_REFER5
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER6_ID', P_SOB_ID) THEN P_REFER6
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER7_ID', P_SOB_ID) THEN P_REFER7
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER8_ID', P_SOB_ID) THEN P_REFER8
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER9_ID', P_SOB_ID) THEN P_REFER9
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER10_ID', P_SOB_ID) THEN P_REFER10
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER11_ID', P_SOB_ID) THEN P_REFER11
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER12_ID', P_SOB_ID) THEN P_REFER12
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(P_ACCOUNT_CONTROL_ID, P_ACCOUNT_DR_CR, 'REFER13_ID', P_SOB_ID) THEN P_REFER13
             END AS ITEM_VALUE
        INTO V_ITEM_VALUE
        FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_ITEM_VALUE;
  END SLIP_ITEM_F;
  
---------------------------------------------------------------------------------------------------
-- 전표 마감 여부 체크.
  FUNCTION SLIP_CLOSE_YN_F
           ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(2) := 'N';

  BEGIN
    BEGIN
      SELECT SH.CLOSED_YN
        INTO V_RETURN_VALUE
        FROM FI_SLIP_HEADER SH
       WHERE SH.SLIP_HEADER_ID    = W_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'N';
    END;
    RETURN V_RETURN_VALUE;
  END SLIP_CLOSE_YN_F;

-- 전표 승인 여부 체크.
  FUNCTION SLIP_CONFIRM_YN_F
           ( W_SLIP_HEADER_ID      IN FI_SLIP_HEADER.SLIP_HEADER_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                 VARCHAR2(2) := 'N';

  BEGIN
    BEGIN
      SELECT SH.CONFIRM_YN
        INTO V_RETURN_VALUE
        FROM FI_SLIP_HEADER SH
       WHERE SH.SLIP_HEADER_ID    = W_SLIP_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'N';
    END;
    RETURN V_RETURN_VALUE;
  END SLIP_CONFIRM_YN_F;

-- 기표번호 조회 LOOKUP.
  PROCEDURE LU_SLIP_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_SLIP_NUM          IN VARCHAR2 DEFAULT NULL
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT SH.SLIP_NUM
           , SH.SLIP_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.GL_AMOUNT
           , SH.SLIP_HEADER_ID
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_TYPE_V ST
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND ST.SLIP_TYPE_CLASS         = NVL(W_SLIP_TYPE_CLASS, ST.SLIP_TYPE_CLASS)
         AND SH.SOB_ID                  = W_SOB_ID
         AND SH.SLIP_NUM                LIKE W_SLIP_NUM || '%'
         AND ST.SLIP_TYPE_CLASS         <> 'BL'
      ORDER BY SH.SLIP_NUM DESC
      ;
  END LU_SLIP_NUM;

-- 전표번호 조회 LOOKUP.
  PROCEDURE LU_GL_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_GL_NUM            IN VARCHAR2 DEFAULT NULL
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT SH.GL_NUM
           , SH.GL_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , TO_CHAR(SH.GL_AMOUNT, 'FM999,999,999,999,999') AS GL_AMOUNT
           , SH.SLIP_HEADER_ID
        FROM FI_SLIP_HEADER SH
          , FI_SLIP_TYPE_V ST
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND ST.SLIP_TYPE_CLASS         = NVL(W_SLIP_TYPE_CLASS, ST.SLIP_TYPE_CLASS)
         AND SH.SOB_ID                  = W_SOB_ID
         AND SH.GL_NUM                  LIKE W_GL_NUM || '%'
         AND ST.SLIP_TYPE_CLASS         <> 'BL'
      ORDER BY SH.SLIP_NUM DESC
      ;
  END LU_GL_NUM;

END FI_SLIP_G; 
/
