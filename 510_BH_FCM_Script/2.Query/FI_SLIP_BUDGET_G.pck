CREATE OR REPLACE PACKAGE FI_SLIP_BUDGET_G
AS

-- 예산전표 헤더 인터페이스 조회.
  PROCEDURE SELECT_HEADER_IF_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_DATE_FR         IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , W_SLIP_DATE_TO         IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , W_DEPT_ID              IN FI_SLIP_HEADER_BUDGET.DEPT_ID%TYPE
            , W_PERSON_ID            IN FI_SLIP_HEADER_BUDGET.PERSON_ID%TYPE
            , W_SLIP_TYPE            IN FI_SLIP_HEADER_BUDGET.SLIP_TYPE%TYPE
            , W_JOURNAL_HEADER_ID    IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            , W_CONNECT_PERSON_ID    IN FI_SLIP_HEADER_BUDGET.PERSON_ID%TYPE
            );

-- 예산전표 헤더/라인 삭제.
  PROCEDURE DELETE_SLIP_HEADER
            ( W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            );

-- 선택한 예산전표 헤더 조회.
  PROCEDURE SELECT_HEADER_IF
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            );

-- 예산전표 헤더 삽입.
  PROCEDURE INSERT_HEADER_IF
            ( P_HEADER_ID           OUT FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_HEADER_BUDGET.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_HEADER_BUDGET.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_HEADER_BUDGET.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER_BUDGET.BUDGET_DEPT_ID%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_HEADER_BUDGET.SLIP_TYPE%TYPE
            , P_JOURNAL_HEADER_ID   IN FI_SLIP_HEADER_BUDGET.JOURNAL_HEADER_ID%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER_BUDGET.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER_BUDGET.REMARK%TYPE
            , P_SUB_REMARK          IN FI_SLIP_HEADER_BUDGET.SUB_REMARK%TYPE
            , P_SUBSTANCE           IN FI_SLIP_HEADER_BUDGET.SUBSTANCE%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER_BUDGET.CREATED_BY%TYPE
            );

-- 예산전표 헤더 수정.
  PROCEDURE UPDATE_HEADER_IF
            ( W_HEADER_ID           IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER_BUDGET.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER_BUDGET.REMARK%TYPE
            , P_SUB_REMARK          IN FI_SLIP_HEADER_BUDGET.SUB_REMARK%TYPE
            , P_SUBSTANCE           IN FI_SLIP_HEADER_BUDGET.SUBSTANCE%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER_BUDGET.CREATED_BY%TYPE
            );

-- 예산전표 헤더 삭제.
  PROCEDURE DELETE_HEADER_IF
            ( W_HEADER_ID         IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            );

-- 예산전표 헤더 수정 - LINE 입력한 값에 따라 수정.
  PROCEDURE UPDATE_HEADER_IF_LINE_VALUE
            ( W_HEADER_ID       IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 예산전표 라인 조회.
  PROCEDURE SELECT_LINE_IF
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_HEADER_ID            IN FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            );

-- 예산전표 라인  삽입.
  PROCEDURE INSERT_LINE_IF
            ( P_LINE_ID             OUT FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
            , P_HEADER_ID           IN FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            , P_SOB_ID              IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_LINE_BUDGET.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID         IN FI_SLIP_LINE_BUDGET.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_SLIP_LINE_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_LINE_BUDGET.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID      IN FI_SLIP_LINE_BUDGET.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_LINE_BUDGET.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_LINE_BUDGET.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_LINE_BUDGET.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_LINE_BUDGET.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_LINE_BUDGET.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID     IN FI_SLIP_LINE_BUDGET.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_LINE_BUDGET.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_LINE_BUDGET.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_LINE_BUDGET.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_LINE_BUDGET.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_LINE_BUDGET.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_LINE_BUDGET.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_LINE_BUDGET.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_LINE_BUDGET.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_LINE_BUDGET.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_LINE_BUDGET.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_LINE_BUDGET.REFER9%TYPE
            , P_VOUCH_CODE          IN FI_SLIP_LINE_BUDGET.VOUCH_CODE%TYPE
            , P_REFER_RATE          IN FI_SLIP_LINE_BUDGET.REFER_RATE%TYPE
            , P_REFER_AMOUNT        IN FI_SLIP_LINE_BUDGET.REFER_AMOUNT%TYPE
            , P_REFER_DATE1         IN FI_SLIP_LINE_BUDGET.REFER_DATE1%TYPE
            , P_REFER_DATE2         IN FI_SLIP_LINE_BUDGET.REFER_DATE2%TYPE
            , P_REMARK              IN FI_SLIP_LINE_BUDGET.REMARK%TYPE
            , P_FUND_CODE           IN FI_SLIP_LINE_BUDGET.FUND_CODE%TYPE
            , P_USER_ID             IN FI_SLIP_LINE_BUDGET.CREATED_BY%TYPE
            );

-- 예산전표 라인 수정.
  PROCEDURE UPDATE_LINE_IF
            ( W_LINE_ID             IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
            , W_SOB_ID              IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID              IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_LINE_BUDGET.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID         IN FI_SLIP_LINE_BUDGET.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_SLIP_LINE_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_LINE_BUDGET.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID      IN FI_SLIP_LINE_BUDGET.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_LINE_BUDGET.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_LINE_BUDGET.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_LINE_BUDGET.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_LINE_BUDGET.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_LINE_BUDGET.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID     IN FI_SLIP_LINE_BUDGET.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_LINE_BUDGET.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_LINE_BUDGET.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_LINE_BUDGET.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_LINE_BUDGET.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_LINE_BUDGET.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_LINE_BUDGET.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_LINE_BUDGET.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_LINE_BUDGET.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_LINE_BUDGET.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_LINE_BUDGET.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_LINE_BUDGET.REFER9%TYPE
            , P_VOUCH_CODE          IN FI_SLIP_LINE_BUDGET.VOUCH_CODE%TYPE
            , P_REFER_RATE          IN FI_SLIP_LINE_BUDGET.REFER_RATE%TYPE
            , P_REFER_AMOUNT        IN FI_SLIP_LINE_BUDGET.REFER_AMOUNT%TYPE
            , P_REFER_DATE1         IN FI_SLIP_LINE_BUDGET.REFER_DATE1%TYPE
            , P_REFER_DATE2         IN FI_SLIP_LINE_BUDGET.REFER_DATE2%TYPE
            , P_REMARK              IN FI_SLIP_LINE_BUDGET.REMARK%TYPE
            , P_FUND_CODE           IN FI_SLIP_LINE_BUDGET.FUND_CODE%TYPE
            , P_USER_ID             IN FI_SLIP_LINE_BUDGET.CREATED_BY%TYPE
            );

-- 예산전표 라인 삭제.
  PROCEDURE DELETE_LINE_IF
            ( W_LINE_ID           IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 전표 인터페이스 라인 인쇄 조회.
  PROCEDURE PRINT_LINE_IF
            ( P_CURSOR2              OUT TYPES.TCURSOR1
            , W_HEADER_ID            IN FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            );

  PROCEDURE SELECT_SLIP_LINE_PRINT_2
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_SOB_ID                IN  FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID                IN  FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            , W_HEADER_ID             IN  FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 계정 통제관리값 : LOOKUP TYPE에 따른 해당 값 리턴..
  FUNCTION SLIP_IF_ITEM_VALUE_F
          ( W_LINE_ID             IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
          , W_LOOKUP_TYPE         IN VARCHAR2
          , W_SOB_ID              IN FI_ACCOUNT_CONTROL_ITEM.SOB_ID%TYPE
          ) RETURN VARCHAR2;

---------------------------------------------------------------------------------------------------
-- 일번경비전표 헤더 ID 리턴.
  FUNCTION SLIP_HEADER_INTERFACE_ID_F
           ( W_HEADER_ID          IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           ) RETURN NUMBER;

  FUNCTION SLIP_LINE_INTERFACE_ID_F
           ( W_LINE_ID            IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
           ) RETURN NUMBER;
           
---------------------------------------------------------------------------------------------------
-- 전표 인터페이스 분개 여부 체크.
  FUNCTION SLIP_TRANSFER_YN_F
           ( W_HEADER_ID          IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           ) RETURN VARCHAR2;

-- 전표 승인 여부 체크.
  FUNCTION SLIP_CONFIRM_YN_F
           ( W_HEADER_ID          IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           ) RETURN VARCHAR2;

-- 전표 승인 여부 체크.
  PROCEDURE SLIP_CONFIRM_YN_P
           ( W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           , O_CONFIRM_YN           OUT VARCHAR2
           );

-- 전표번호 조회 LOOKUP.
  PROCEDURE LU_SLIP_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            );

-- 전표번호 해당 부서것만 조회 LOOKUP.
  PROCEDURE LU_SLIP_NUM_C
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_CONNECT_PERSON_ID IN NUMBER
            );

END FI_SLIP_BUDGET_G;
/
CREATE OR REPLACE PACKAGE BODY FI_SLIP_BUDGET_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_SLIP_BUDGET_G
/* Description  : 예산 전표 헤더/라인 정보.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 예산전표  헤더 인터페이스 조회.
  PROCEDURE SELECT_HEADER_IF_LIST
            ( P_CURSOR               OUT TYPES.TCURSOR
            , W_SLIP_DATE_FR         IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , W_SLIP_DATE_TO         IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , W_DEPT_ID              IN FI_SLIP_HEADER_BUDGET.DEPT_ID%TYPE
            , W_PERSON_ID            IN FI_SLIP_HEADER_BUDGET.PERSON_ID%TYPE
            , W_SLIP_TYPE            IN FI_SLIP_HEADER_BUDGET.SLIP_TYPE%TYPE
            , W_JOURNAL_HEADER_ID    IN FI_AUTO_JOURNAL_HEADER.JOURNAL_HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            , W_CONNECT_PERSON_ID    IN FI_SLIP_HEADER_BUDGET.PERSON_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SH.HEADER_ID
           , SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.GL_AMOUNT
           , SH.REMARK
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.DEPT_ID) AS DEPT_NAME
           , SH.PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.BUDGET_DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.BUDGET_DEPT_ID) AS BUDGET_DEPT_NAME
           , SH.CURRENCY_CODE
           , SH.CURRENCY_CODE AS CURRENCY_DESC
           , SH.EXCHANGE_RATE
           , SH.GL_CURRENCY_AMOUNT
           , SH.SOB_ID
           , SH.ORG_ID
           , SH.DEPT_ID           
           , SH.SLIP_TYPE
           , FI_COMMON_G.CODE_NAME_F('SLIP_TYPE', SH.SLIP_TYPE, SH.SOB_ID) AS SLIP_TYPE_NAME
           , SH.JOURNAL_HEADER_ID
           , AJH.JOB_CODE AS JOB_CODE
           , AJH.JOB_NAME AS JOB_NAME
           , SH.REQ_BANK_ACCOUNT_ID
           , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
           , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
           , SH.REQ_PAYABLE_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
           , SH.REQ_PAYABLE_DATE           
           , SH.TRANSFER_YN
           , SH.CONFIRM_YN
           , SH.CONFIRM_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_AUTO_JOURNAL_HEADER AJH
          , (SELECT BA.BANK_ACCOUNT_ID
                  , FB.BANK_NAME
                  , BA.BANK_ACCOUNT_NAME
                  , BA.BANK_ACCOUNT_NUM
               FROM FI_BANK_ACCOUNT BA
                  , FI_BANK FB
              WHERE BA.BANK_ID      = FB.BANK_ID
            ) S_BA
       WHERE SH.JOURNAL_HEADER_ID       = AJH.JOURNAL_HEADER_ID(+)
         AND SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
         AND SH.SLIP_DATE               BETWEEN W_SLIP_DATE_FR AND W_SLIP_DATE_TO
         AND SH.HEADER_ID               = NVL(W_HEADER_ID, SH.HEADER_ID)
         AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND SH.JOURNAL_HEADER_ID       = NVL(W_JOURNAL_HEADER_ID, SH.JOURNAL_HEADER_ID)
         AND SH.DEPT_ID                 = NVL(W_DEPT_ID, SH.DEPT_ID)
         AND SH.PERSON_ID               = NVL(W_PERSON_ID, SH.PERSON_ID)
         AND SH.SOB_ID                  = W_SOB_ID
         AND EXISTS ( SELECT 'X'
                        FROM HRM_PERSON_MASTER PM
                          , HRM_DEPT_MAPPING DM
                      WHERE PM.DEPT_ID        = DM.HR_DEPT_ID
                        AND PM.SOB_ID         = DM.SOB_ID
                        AND DM.M_DEPT_ID      = SH.DEPT_ID
                        AND EXISTS ( SELECT 'X'
                                       FROM HRM_PERSON_MASTER PM1
                                     WHERE PM1.PERSON_ID      = PM.PERSON_ID
                                       AND PM1.PERSON_ID      = W_CONNECT_PERSON_ID
                                       AND PM1.SOB_ID         = W_SOB_ID
                                   )
                     )
      ORDER BY HEADER_ID DESC
      ;

  END SELECT_HEADER_IF_LIST;

-- 예산전표  헤더/라인 삭제.
  PROCEDURE DELETE_SLIP_HEADER
            ( W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            )
  AS
  BEGIN
    IF SLIP_CONFIRM_YN_F(W_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;

    DELETE FI_SLIP_LINE_BUDGET SLB
    WHERE SLB.HEADER_ID           = W_HEADER_ID
    ;

    DELETE FI_SLIP_HEADER_BUDGET
    WHERE HEADER_ID               = W_HEADER_ID
    ;

  END DELETE_SLIP_HEADER;

-- 선택한 예산전표 헤더 조회.
  PROCEDURE SELECT_HEADER_IF
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SH.HEADER_ID
           , SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.SOB_ID
           , SH.ORG_ID
           , SH.DEPT_ID
           , FI_DEPT_MASTER_G.DEPT_NAME_F(SH.DEPT_ID) AS DEPT_NAME
           , SH.PERSON_ID
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.BUDGET_DEPT_ID
           , DM.DEPT_CODE AS BUDGET_DEPT_CODE
           , DM.DEPT_NAME AS BUDGET_DEPT_NAME           
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , ST.SLIP_TYPE_NAME AS SLIP_TYPE_NAME
           , ST.SLIP_TYPE_CLASS
           , ST.DOCUMENT_TYPE
           , NVL(SH.JOURNAL_HEADER_ID, -1) AS JOURNAL_HEADER_ID
           , AJH.JOB_CODE
           , NVL(AJH.JOB_NAME, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10186', NULL)) AS JOB_NAME
           , SH.GL_AMOUNT
           , SH.REQ_BANK_ACCOUNT_ID
           , S_BA.BANK_ACCOUNT_NAME AS REQ_BANK_ACCOUNT_NAME
           , S_BA.BANK_ACCOUNT_NUM AS REQ_BANK_ACCOUNT_NUM
           , SH.REQ_PAYABLE_TYPE
           , FI_COMMON_G.CODE_NAME_F('PAYABLE_TYPE', SH.REQ_PAYABLE_TYPE, SH.SOB_ID) AS REQ_PAYABLE_TYPE_NAME
           , SH.REQ_PAYABLE_DATE
           , SH.REMARK
           , SH.SUB_REMARK
           , SH.SUBSTANCE
           , SH.TRANSFER_YN
           , SH.CONFIRM_YN
           , SH.GL_DATE AS GL_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.CONFIRM_PERSON_ID) AS CONFIRM_PERSON_NAME
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_DEPT_MASTER DM
          , FI_SLIP_TYPE_V ST
          , FI_AUTO_JOURNAL_HEADER AJH
          , (SELECT BA.BANK_ACCOUNT_ID
                  , FB.BANK_NAME
                  , BA.BANK_ACCOUNT_NAME
                  , BA.BANK_ACCOUNT_NUM
               FROM FI_BANK_ACCOUNT BA
                  , FI_BANK FB
              WHERE BA.BANK_ID      = FB.BANK_ID
            ) S_BA
       WHERE SH.BUDGET_DEPT_ID          = DM.DEPT_ID(+)
         AND SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.JOURNAL_HEADER_ID       = AJH.JOURNAL_HEADER_ID(+)
         AND SH.REQ_BANK_ACCOUNT_ID     = S_BA.BANK_ACCOUNT_ID(+)
         AND SH.HEADER_ID               = W_HEADER_ID
         AND SH.SOB_ID                  = W_SOB_ID
      ;

  END SELECT_HEADER_IF;

-- 예산전표 헤더 삽입.
  PROCEDURE INSERT_HEADER_IF
            ( P_HEADER_ID           OUT FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , P_SLIP_NUM            IN FI_SLIP_HEADER_BUDGET.SLIP_NUM%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            , P_DEPT_ID             IN FI_SLIP_HEADER_BUDGET.DEPT_ID%TYPE
            , P_PERSON_ID           IN FI_SLIP_HEADER_BUDGET.PERSON_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_HEADER_BUDGET.BUDGET_DEPT_ID%TYPE
            , P_SLIP_TYPE           IN FI_SLIP_HEADER_BUDGET.SLIP_TYPE%TYPE
            , P_JOURNAL_HEADER_ID   IN FI_SLIP_HEADER_BUDGET.JOURNAL_HEADER_ID%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER_BUDGET.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER_BUDGET.REMARK%TYPE
            , P_SUB_REMARK          IN FI_SLIP_HEADER_BUDGET.SUB_REMARK%TYPE
            , P_SUBSTANCE           IN FI_SLIP_HEADER_BUDGET.SUBSTANCE%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER_BUDGET.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HEADER_INTERFACE_ID           FI_SLIP_HEADER_INTERFACE.HEADER_INTERFACE_ID%TYPE;
  BEGIN
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;
    END IF;
      
    SELECT FI_SLIP_HEADER_BUDGET_S1.NEXTVAL
      INTO P_HEADER_ID
      FROM DUAL;

    -- 일반경비전표 헤더 저장. FI_SLIP_HEADER_INTERFACE 저장 및 HEADER_INTERFACE_ID 값 리턴.
    FI_SLIP_INTERFACE_G.INSERT_HEADER_IF
      ( V_HEADER_INTERFACE_ID
      , P_SLIP_DATE
      , P_SLIP_NUM
      , P_SOB_ID
      , P_ORG_ID
      , P_DEPT_ID
      , P_PERSON_ID
      , P_BUDGET_DEPT_ID
      , P_SLIP_TYPE
      , P_JOURNAL_HEADER_ID
      , P_REQ_BANK_ACCOUNT_ID
      , P_REQ_PAYABLE_TYPE
      , P_REQ_PAYABLE_DATE
      , P_REMARK
      , P_SUB_REMARK
      , P_SUBSTANCE
      , P_USER_ID
      );
    
    -- 예산 전표 헤더 저장.
    INSERT INTO FI_SLIP_HEADER_BUDGET
    ( HEADER_ID
    , SLIP_DATE
    , SLIP_NUM
    , SOB_ID
    , ORG_ID
    , DEPT_ID
    , PERSON_ID
    , BUDGET_DEPT_ID
    , ACCOUNT_BOOK_ID
    , SLIP_TYPE
    , JOURNAL_HEADER_ID
    , REQ_BANK_ACCOUNT_ID
    , REQ_PAYABLE_TYPE
    , REQ_PAYABLE_DATE
    , REMARK
    , SUB_REMARK
    , SUBSTANCE
    , SOURCE_HEADER_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_HEADER_ID
    , P_SLIP_DATE
    , P_SLIP_NUM
    , P_SOB_ID
    , P_ORG_ID
    , P_DEPT_ID
    , P_PERSON_ID
    , P_BUDGET_DEPT_ID
    , FI_ACCOUNT_BOOK_G.OPERATING_ACCOUNT_BOOK_F(P_SOB_ID)
    , P_SLIP_TYPE
    , P_JOURNAL_HEADER_ID
    , P_REQ_BANK_ACCOUNT_ID
    , P_REQ_PAYABLE_TYPE
    , P_REQ_PAYABLE_DATE
    , P_REMARK
    , P_SUB_REMARK
    , P_SUBSTANCE
    , V_HEADER_INTERFACE_ID    -- 인터페이스 헤더 ID.
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END INSERT_HEADER_IF;

-- 예산전표 헤더 수정.
  PROCEDURE UPDATE_HEADER_IF
            ( W_HEADER_ID           IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            , P_SLIP_DATE           IN FI_SLIP_HEADER_BUDGET.SLIP_DATE%TYPE
            , P_SOB_ID              IN FI_SLIP_HEADER_BUDGET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_HEADER_BUDGET.ORG_ID%TYPE
            , P_REQ_BANK_ACCOUNT_ID IN FI_SLIP_HEADER_BUDGET.REQ_BANK_ACCOUNT_ID%TYPE
            , P_REQ_PAYABLE_TYPE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_TYPE%TYPE
            , P_REQ_PAYABLE_DATE    IN FI_SLIP_HEADER_BUDGET.REQ_PAYABLE_DATE%TYPE
            , P_REMARK              IN FI_SLIP_HEADER_BUDGET.REMARK%TYPE
            , P_SUB_REMARK          IN FI_SLIP_HEADER_BUDGET.SUB_REMARK%TYPE
            , P_SUBSTANCE           IN FI_SLIP_HEADER_BUDGET.SUBSTANCE%TYPE
            , P_USER_ID             IN FI_SLIP_HEADER_BUDGET.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HEADER_INTERFACE_ID           NUMBER;
  BEGIN
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, P_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;
    END IF;

    IF SLIP_CONFIRM_YN_F(W_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    -- 일반경비전표 수정.
    FI_SLIP_INTERFACE_G.UPDATE_HEADER_IF
      ( W_HEADER_INTERFACE_ID => SLIP_HEADER_INTERFACE_ID_F(W_HEADER_ID)
      , P_SLIP_DATE           => P_SLIP_DATE
      , P_SOB_ID              => P_SOB_ID
      , P_ORG_ID              => P_ORG_ID
      , P_REQ_BANK_ACCOUNT_ID => P_REQ_BANK_ACCOUNT_ID
      , P_REQ_PAYABLE_TYPE    => P_REQ_PAYABLE_TYPE
      , P_REQ_PAYABLE_DATE    => P_REQ_PAYABLE_DATE
      , P_REMARK              => P_REMARK
      , P_SUB_REMARK          => P_SUB_REMARK
      , P_SUBSTANCE           => P_SUBSTANCE
      , P_USER_ID             => P_USER_ID
      );
      
    -- 예산전표 수정.    
    UPDATE FI_SLIP_HEADER_BUDGET
      SET REQ_BANK_ACCOUNT_ID = P_REQ_BANK_ACCOUNT_ID
        , REQ_PAYABLE_TYPE    = P_REQ_PAYABLE_TYPE
        , REQ_PAYABLE_DATE    = P_REQ_PAYABLE_DATE
        , REMARK              = P_REMARK
        , SUB_REMARK          = P_SUB_REMARK
        , SUBSTANCE           = P_SUBSTANCE
        , LAST_UPDATE_DATE    = V_SYSDATE
        , LAST_UPDATED_BY     = P_USER_ID
    WHERE HEADER_ID           = W_HEADER_ID
    ;
        
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END UPDATE_HEADER_IF;

-- 예산전표 헤더 삭제.
  PROCEDURE DELETE_HEADER_IF
            ( W_HEADER_ID         IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            )
  AS
    V_RECORD_COUNT                  NUMBER := 0;
  BEGIN
    IF SLIP_CONFIRM_YN_F(W_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;

    -- 라인 존재시 라인 삭제.
    BEGIN
      SELECT COUNT(SL.HEADER_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_SLIP_LINE_BUDGET SL
      WHERE SL.HEADER_ID          = W_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      DELETE FI_SLIP_LINE_BUDGET
      WHERE HEADER_ID             = W_HEADER_ID
      ;
    END IF;
    
    -- 일반경비전표 삭제.
    FI_SLIP_INTERFACE_G.DELETE_HEADER_IF
      ( W_HEADER_INTERFACE_ID   => SLIP_HEADER_INTERFACE_ID_F(W_HEADER_ID)
      );
      
    -- 예산전표 삭제.
    DELETE FI_SLIP_HEADER_BUDGET
    WHERE HEADER_ID               = W_HEADER_ID;

  END DELETE_HEADER_IF;

-- 예산전표 헤더 수정 - LINE 입력한 값에 따라 수정.
  PROCEDURE UPDATE_HEADER_IF_LINE_VALUE
            ( W_HEADER_ID       IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
            )
  AS
  BEGIN
    -- 일반경비전표 헤더 정보 업데이트.
    FI_SLIP_INTERFACE_G.UPDATE_HEADER_IF_LINE_VALUE
      ( W_HEADER_INTERFACE_ID   => SLIP_HEADER_INTERFACE_ID_F(W_HEADER_ID)
      );
      
    -- 예산전표 헤더 정보 업데이트.
    UPDATE FI_SLIP_HEADER_BUDGET
      SET (GL_AMOUNT, CURRENCY_CODE, EXCHANGE_RATE, GL_CURRENCY_AMOUNT)
        = (SELECT SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0)) AS GL_AMOUNT
                , MAX(SL.CURRENCY_CODE) AS CURRENCY_CODE
                , MAX(SL.EXCHANGE_RATE) AS EXCHANGE_RATE
                , SUM(DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_CURRENCY_AMOUNT, 0)) AS GL_CURRENCY_AMOUNT
            FROM FI_SLIP_LINE_BUDGET SL
           WHERE SL.HEADER_ID     = W_HEADER_ID
          )
    WHERE HEADER_ID             = W_HEADER_ID
    ;

  END UPDATE_HEADER_IF_LINE_VALUE;

---------------------------------------------------------------------------------------------------
-- 예산전표 라인 조회.
  PROCEDURE SELECT_LINE_IF
            ( P_CURSOR1              OUT TYPES.TCURSOR1
            , W_HEADER_ID            IN FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT SL.LINE_ID
           , SL.SLIP_LINE_SEQ
           , SL.HEADER_ID
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
           , DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0) AS DR_AMOUNT
           , DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0) AS CR_AMOUNT
           , SL.GL_AMOUNT
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
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT1_ID'
                                                          , SL.MANAGEMENT1
                                                          , SL.SOB_ID) AS MANAGEMENT1_DESC
           , SL.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT2_ID'
                                                          , SL.MANAGEMENT2
                                                          , SL.SOB_ID) AS MANAGEMENT2_DESC
           , SL.REFER1
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER1_ID'
                                                          , SL.REFER1
                                                          , SL.SOB_ID) AS REFER1_DESC
           , SL.REFER2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER2_ID'
                                                          , SL.REFER2
                                                          , SL.SOB_ID) AS REFER2_DESC
           , SL.REFER3
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER3_ID'
                                                          , SL.REFER3
                                                          , SL.SOB_ID) AS REFER3_DESC
           , SL.REFER4
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER4_ID'
                                                          , SL.REFER4
                                                          , SL.SOB_ID) AS REFER4_DESC
           , SL.REFER5
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER5_ID'
                                                          , SL.REFER5
                                                          , SL.SOB_ID) AS REFER5_DESC
           , SL.REFER6
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER6_ID'
                                                          , SL.REFER6
                                                          , SL.SOB_ID) AS REFER6_DESC
           , SL.REFER7
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER7_ID'
                                                          , SL.REFER7
                                                          , SL.SOB_ID) AS REFER7_DESC
           , SL.REFER8
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER8_ID'
                                                          , SL.REFER8
                                                          , SL.SOB_ID) AS REFER8_DESC
           , SL.REMARK
           , SL.FUND_CODE
           , SL.UNIT_PRICE
           , SL.UOM_CODE
           , SL.UOM_QUANTITY
           , SL.UOM_WEIGHT
           , SL.INVENTORY_ITEM_ID
           , IMT.ITEM_CODE
           , IMT.ITEM_DESCRIPTION
           , SL.TRANSFER_YN
           , SL.CONFIRM_YN
           , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT1_ID) AS MANAGEMENT1_NAME
           , DECODE(ACI.MANAGEMENT1_ID, NULL, 'F', NVL(ACI.MANAGEMENT1_YN, 'N')) AS MANAGEMENT1_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT1_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT1_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'MANAGEMENT1_ID', ACI.SOB_ID) AS MANAGEMENT1_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT1_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS MANAGEMENT1_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT2_ID) AS MANAGEMENT2_NAME
           , DECODE(ACI.MANAGEMENT2_ID, NULL, 'F', NVL(ACI.MANAGEMENT2_YN, 'N')) AS MANAGEMENT2_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT2_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT2_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'MANAGEMENT2_ID', ACI.SOB_ID) AS MANAGEMENT2_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT2_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS MANAGEMENT2_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER1_ID) AS REFER1_NAME
           , DECODE(ACI.REFER1_ID, NULL, 'F', NVL(ACI.REFER1_YN, 'N')) AS REFER1_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER1_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER1_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER1_ID', ACI.SOB_ID) AS REFER1_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER1_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER1_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER2_ID) AS REFER2_NAME
           , DECODE(ACI.REFER2_ID, NULL, 'F', NVL(ACI.REFER2_YN, 'N')) AS REFER2_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER2_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER2_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER2_ID', ACI.SOB_ID) AS REFER2_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER2_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER2_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER3_ID) AS REFER3_NAME
           , DECODE(ACI.REFER3_ID, NULL, 'F', NVL(ACI.REFER3_YN, 'N')) AS REFER3_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER3_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER3_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER3_ID', ACI.SOB_ID) AS REFER3_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER3_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER3_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER4_ID) AS REFER4_NAME
           , DECODE(ACI.REFER4_ID, NULL, 'F', NVL(ACI.REFER4_YN, 'N')) AS REFER4_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER4_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER4_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER4_ID', ACI.SOB_ID) AS REFER4_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER4_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER4_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER5_ID) AS REFER5_NAME
           , DECODE(ACI.REFER5_ID, NULL, 'F', NVL(ACI.REFER5_YN, 'N')) AS REFER5_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER5_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER5_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER5_ID', ACI.SOB_ID) AS REFER5_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER5_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER5_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER6_ID) AS REFER6_NAME
           , DECODE(ACI.REFER6_ID, NULL, 'F', NVL(ACI.REFER6_YN, 'N')) AS REFER6_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER6_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER6_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER6_ID', ACI.SOB_ID) AS REFER6_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER6_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER6_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER7_ID) AS REFER7_NAME
           , DECODE(ACI.REFER7_ID, NULL, 'F', NVL(ACI.REFER7_YN, 'N')) AS REFER7_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER7_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER7_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER7_ID', ACI.SOB_ID) AS REFER7_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER7_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER7_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER8_ID) AS REFER8_NAME
           , DECODE(ACI.REFER8_ID, NULL, 'F', NVL(ACI.REFER8_YN, 'N')) AS REFER8_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER8_ID,  DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER8_LOOKUP_YN
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER8_ID', ACI.SOB_ID) AS REFER8_LOOKUP_TYPE
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER8_ID, DECODE(ACI.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER8_DATA_TYPE
           , NVL(AC.ACCOUNT_DR_CR, '1') AS CONTROL_ACCOUNT_DR_CR
           , NVL(AC.CUSTOMER_ENABLED_FLAG, 'N') AS CUSTOMER_ENABLED_FLAG
           , NVL(AC.BANK_ACCOUNT_FLAG, 'N') AS BANK_ACCOUNT_FLAG
           , NVL(AC.CURRENCY_ENABLED_FLAG, 'N') AS CURRENCY_ENABLED_FLAG
           , NVL(AC.VAT_ENABLED_FLAG, 'N') AS VAT_ENABLED_FLAG
           , NVL(AC.ACCOUNT_MICH_YN, 'N') AS ACCOUNT_MICH_YN
           , NVL(AC.BUDGET_ENABLED_FLAG, 'N') AS BUDGET_ENABLED_FLAG
           , NVL(AC.BUDGET_CONTROL_FLAG, 'N') AS BUDGET_CONTROL_FLAG
           , NVL(AC.BUDGET_BELONG_FLAG, 'N') AS BUDGET_BELONG_FLAG
           , NVL(AC.COST_CENTER_FLAG, 'N') AS COST_CENTER_FLAG
        FROM FI_SLIP_LINE_BUDGET SL
          , FI_AUTO_JOURNAL_LINE AJL
          , FI_SUPP_CUST_V SCV
          , FI_ACCOUNT_CONTROL AC
          , FI_ACCOUNT_CONTROL_ITEM ACI
          , FI_BANK_ACCOUNT_TLV BAT
          , INV_ITEM_MASTER_TLV IMT
       WHERE SL.JOURNAL_HEADER_ID       = AJL.JOURNAL_HEADER_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AJL.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = AJL.ACCOUNT_DR_CR(+)
         AND SL.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                  = ACI.SOB_ID(+)
         AND SL.BANK_ACCOUNT_ID         = BAT.BANK_ACCOUNT_ID(+)
         AND SL.INVENTORY_ITEM_ID       = IMT.INVENTORY_ITEM_ID(+)
         AND NVL(AJL.DISPLAY_YN, 'Y')   = 'Y'
         AND SL.HEADER_ID               = W_HEADER_ID
         AND SL.SOB_ID                  = W_SOB_ID
      ORDER BY SL.SLIP_LINE_SEQ
      ;

  END SELECT_LINE_IF;

-- 예산전표 라인  삽입.
  PROCEDURE INSERT_LINE_IF
            ( P_LINE_ID             OUT FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
            , P_HEADER_ID           IN FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            , P_SOB_ID              IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , P_ORG_ID              IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_LINE_BUDGET.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID         IN FI_SLIP_LINE_BUDGET.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_SLIP_LINE_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_LINE_BUDGET.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID      IN FI_SLIP_LINE_BUDGET.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_LINE_BUDGET.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_LINE_BUDGET.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_LINE_BUDGET.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_LINE_BUDGET.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_LINE_BUDGET.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID     IN FI_SLIP_LINE_BUDGET.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_LINE_BUDGET.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_LINE_BUDGET.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_LINE_BUDGET.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_LINE_BUDGET.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_LINE_BUDGET.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_LINE_BUDGET.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_LINE_BUDGET.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_LINE_BUDGET.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_LINE_BUDGET.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_LINE_BUDGET.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_LINE_BUDGET.REFER9%TYPE
            , P_VOUCH_CODE          IN FI_SLIP_LINE_BUDGET.VOUCH_CODE%TYPE
            , P_REFER_RATE          IN FI_SLIP_LINE_BUDGET.REFER_RATE%TYPE
            , P_REFER_AMOUNT        IN FI_SLIP_LINE_BUDGET.REFER_AMOUNT%TYPE
            , P_REFER_DATE1         IN FI_SLIP_LINE_BUDGET.REFER_DATE1%TYPE
            , P_REFER_DATE2         IN FI_SLIP_LINE_BUDGET.REFER_DATE2%TYPE
            , P_REMARK              IN FI_SLIP_LINE_BUDGET.REMARK%TYPE
            , P_FUND_CODE           IN FI_SLIP_LINE_BUDGET.FUND_CODE%TYPE
            , P_USER_ID             IN FI_SLIP_LINE_BUDGET.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE             DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SLIP_DATE           FI_SLIP_LINE_INTERFACE.SLIP_DATE%TYPE;
    V_SLIP_NUM            FI_SLIP_LINE_INTERFACE.SLIP_NUM%TYPE;
    V_DEPT_ID             FI_SLIP_LINE_INTERFACE.DEPT_ID%TYPE;
    V_BUDGET_DEPT_ID      FI_SLIP_LINE_INTERFACE.BUDGET_DEPT_ID%TYPE;
    V_PERSON_ID           FI_SLIP_LINE_INTERFACE.PERSON_ID%TYPE;
    V_ACCOUNT_BOOK_ID     FI_SLIP_LINE_INTERFACE.ACCOUNT_BOOK_ID%TYPE;
    V_SLIP_TYPE           FI_SLIP_LINE_INTERFACE.SLIP_TYPE%TYPE;
    V_JOURNAL_HEADER_ID   FI_SLIP_LINE_INTERFACE.JOURNAL_HEADER_ID%TYPE;
    V_SLIP_LINE_SEQ       FI_SLIP_LINE_INTERFACE.SLIP_LINE_SEQ%TYPE;

    V_BASE_CURRENCY_CODE  FI_SLIP_LINE.CURRENCY_CODE%TYPE;
    N_GL_AMOUNT           FI_SLIP_LINE.GL_AMOUNT%TYPE;
    
    V_BUDGET_CONTROL_YN   VARCHAR2(2) := 'N';  -- 예산통제.
    V_BUDGET_AMOUNT       NUMBER := 0;         -- 예산 잔액금액.
    V_BUDGET_OVER_AMOUNT  NUMBER := 0;
    
    V_HEADER_INTERFACE_ID FI_SLIP_LINE_INTERFACE.HEADER_INTERFACE_ID%TYPE;  -- 일반경비전표 HEADER ID;
    V_LINE_INTERFACE_ID   FI_SLIP_LINE_INTERFACE.LINE_INTERFACE_ID%TYPE;  -- 일반경비전표 LINE ID;
  BEGIN
    BEGIN
      SELECT SH.SLIP_DATE
           , SH.SLIP_NUM
           , SH.DEPT_ID
           , SH.BUDGET_DEPT_ID
           , SH.PERSON_ID
           , SH.ACCOUNT_BOOK_ID
           , SH.SLIP_TYPE
           , SH.JOURNAL_HEADER_ID
        INTO V_SLIP_DATE
            , V_SLIP_NUM
            , V_DEPT_ID
            , V_BUDGET_DEPT_ID
            , V_PERSON_ID
            , V_ACCOUNT_BOOK_ID
            , V_SLIP_TYPE
            , V_JOURNAL_HEADER_ID
        FROM FI_SLIP_HEADER_BUDGET SH
       WHERE SH.HEADER_ID         = P_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

/*RAISE_APPLICATION_ERROR(-20001, 'SLIP_DATE : ' || TO_CHAR(V_SLIP_DATE, 'YYYY-MM-DD') || ', ' || GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, P_SOB_ID, P_ORG_ID) || ', SOB : ' || P_SOB_ID);
    */
    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, P_SOB_ID, P_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;
    END IF;

    IF SLIP_CONFIRM_YN_F(P_HEADER_ID) <> 'N' THEN
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
    -- 예산 검증 -- 
    BEGIN
      SELECT BA.CONTROL_YN
        INTO V_BUDGET_CONTROL_YN
        FROM FI_BUDGET_ACCOUNT BA
      WHERE BA.ACCOUNT_CONTROL_ID = P_ACCOUNT_CONTROL_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_BUDGET_CONTROL_YN := 'N';
    END;
    V_BUDGET_AMOUNT := FI_BUDGET_G.BUDGET_REMAIN_AMOUNT_F(TO_CHAR(V_SLIP_DATE, 'YYYY-MM'), V_BUDGET_DEPT_ID, P_ACCOUNT_CONTROL_ID, P_SOB_ID);
    V_BUDGET_OVER_AMOUNT := NVL(V_BUDGET_AMOUNT, 0) - NVL(P_GL_AMOUNT, 0);
    IF V_BUDGET_OVER_AMOUNT < 0 THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10263', '&&VALUE:=' || V_BUDGET_AMOUNT || '/' || ABS(V_BUDGET_OVER_AMOUNT)));
    END IF;
    
    -- 일반경비전표 INSERT.
    V_HEADER_INTERFACE_ID := SLIP_HEADER_INTERFACE_ID_F(P_HEADER_ID);
    FI_SLIP_INTERFACE_G.INSERT_LINE_IF
      ( P_LINE_INTERFACE_ID   => V_LINE_INTERFACE_ID
      , P_HEADER_INTERFACE_ID => V_HEADER_INTERFACE_ID
      , P_SOB_ID              => P_SOB_ID
      , P_ORG_ID              => P_ORG_ID
      , P_BUDGET_DEPT_ID      => V_BUDGET_DEPT_ID
      , P_CUSTOMER_ID         => P_CUSTOMER_ID
      , P_ACCOUNT_CONTROL_ID  => P_ACCOUNT_CONTROL_ID
      , P_ACCOUNT_CODE        => P_ACCOUNT_CODE
      , P_COST_CENTER_ID      => P_COST_CENTER_ID
      , P_ACCOUNT_DR_CR       => P_ACCOUNT_DR_CR
      , P_GL_AMOUNT           => P_GL_AMOUNT
      , P_CURRENCY_CODE       => P_CURRENCY_CODE
      , P_EXCHANGE_RATE       => P_EXCHANGE_RATE
      , P_GL_CURRENCY_AMOUNT  => P_GL_CURRENCY_AMOUNT
      , P_BANK_ACCOUNT_ID     => P_BANK_ACCOUNT_ID
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
      , P_VOUCH_CODE          => P_VOUCH_CODE
      , P_REFER_RATE          => P_REFER_RATE
      , P_REFER_AMOUNT        => P_REFER_AMOUNT
      , P_REFER_DATE1         => P_REFER_DATE1
      , P_REFER_DATE2         => P_REFER_DATE2
      , P_REMARK              => P_REMARK
      , P_FUND_CODE           => P_FUND_CODE
      , P_USER_ID             => P_USER_ID
      );
            
    -- 예산전표 INSERT.
    BEGIN
      SELECT NVL(MAX(SL.SLIP_LINE_SEQ), 0) + 1 AS SLIP_LINE_SEQ
        INTO V_SLIP_LINE_SEQ
        FROM FI_SLIP_LINE_BUDGET SL
       WHERE SL.HEADER_ID         = P_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SLIP_LINE_SEQ := 1;
    END;

    SELECT FI_SLIP_LINE_BUDGET_S1.NEXTVAL
      INTO P_LINE_ID
      FROM DUAL;

    INSERT INTO FI_SLIP_LINE_BUDGET
    ( LINE_ID
    , SLIP_DATE
    , SLIP_NUM
    , SLIP_LINE_SEQ
    , HEADER_ID
    , SOB_ID
    , ORG_ID
    , DEPT_ID
    , PERSON_ID
    , BUDGET_DEPT_ID
    , ACCOUNT_BOOK_ID
    , SLIP_TYPE
    , JOURNAL_HEADER_ID
    , CUSTOMER_ID
    , ACCOUNT_CONTROL_ID
    , ACCOUNT_CODE
    , COST_CENTER_ID
    , ACCOUNT_DR_CR
    , GL_AMOUNT
    , CURRENCY_CODE
    , EXCHANGE_RATE
    , GL_CURRENCY_AMOUNT
    , BANK_ACCOUNT_ID
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
    , VOUCH_CODE
    , REFER_RATE
    , REFER_AMOUNT
    , REFER_DATE1
    , REFER_DATE2
    , REMARK
    , FUND_CODE
    , SOURCE_HEADER_ID
    , SOURCE_LINE_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY )
    VALUES
    ( P_LINE_ID
    , V_SLIP_DATE
    , V_SLIP_NUM
    , V_SLIP_LINE_SEQ
    , P_HEADER_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_DEPT_ID
    , V_PERSON_ID
    , P_BUDGET_DEPT_ID
    , V_ACCOUNT_BOOK_ID
    , V_SLIP_TYPE
    , V_JOURNAL_HEADER_ID
    , P_CUSTOMER_ID
    , P_ACCOUNT_CONTROL_ID
    , P_ACCOUNT_CODE
    , P_COST_CENTER_ID
    , P_ACCOUNT_DR_CR
    , N_GL_AMOUNT
    , P_CURRENCY_CODE
    , P_EXCHANGE_RATE
    , P_GL_CURRENCY_AMOUNT
    , P_BANK_ACCOUNT_ID
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
    , P_VOUCH_CODE
    , P_REFER_RATE
    , P_REFER_AMOUNT
    , P_REFER_DATE1
    , P_REFER_DATE2
    , P_REMARK
    , P_FUND_CODE
    , V_HEADER_INTERFACE_ID
    , V_LINE_INTERFACE_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );

    -- HEADER INTERFACE 수정.
    UPDATE_HEADER_IF_LINE_VALUE(P_HEADER_ID);
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END INSERT_LINE_IF;

-- 예산전표 라인 수정.
  PROCEDURE UPDATE_LINE_IF
            ( W_LINE_ID             IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
            , W_SOB_ID              IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID              IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            , P_BUDGET_DEPT_ID      IN FI_SLIP_LINE_BUDGET.BUDGET_DEPT_ID%TYPE
            , P_CUSTOMER_ID         IN FI_SLIP_LINE_BUDGET.CUSTOMER_ID%TYPE
            , P_ACCOUNT_CONTROL_ID  IN FI_SLIP_LINE_BUDGET.ACCOUNT_CONTROL_ID%TYPE
            , P_ACCOUNT_CODE        IN FI_SLIP_LINE_BUDGET.ACCOUNT_CODE%TYPE
            , P_COST_CENTER_ID      IN FI_SLIP_LINE_BUDGET.COST_CENTER_ID%TYPE
            , P_ACCOUNT_DR_CR       IN FI_SLIP_LINE_BUDGET.ACCOUNT_DR_CR%TYPE
            , P_GL_AMOUNT           IN FI_SLIP_LINE_BUDGET.GL_AMOUNT%TYPE
            , P_CURRENCY_CODE       IN FI_SLIP_LINE_BUDGET.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE       IN FI_SLIP_LINE_BUDGET.EXCHANGE_RATE%TYPE
            , P_GL_CURRENCY_AMOUNT  IN FI_SLIP_LINE_BUDGET.GL_CURRENCY_AMOUNT%TYPE
            , P_BANK_ACCOUNT_ID     IN FI_SLIP_LINE_BUDGET.BANK_ACCOUNT_ID%TYPE
            , P_MANAGEMENT1         IN FI_SLIP_LINE_BUDGET.MANAGEMENT1%TYPE
            , P_MANAGEMENT2         IN FI_SLIP_LINE_BUDGET.MANAGEMENT2%TYPE
            , P_REFER1              IN FI_SLIP_LINE_BUDGET.REFER1%TYPE
            , P_REFER2              IN FI_SLIP_LINE_BUDGET.REFER2%TYPE
            , P_REFER3              IN FI_SLIP_LINE_BUDGET.REFER3%TYPE
            , P_REFER4              IN FI_SLIP_LINE_BUDGET.REFER4%TYPE
            , P_REFER5              IN FI_SLIP_LINE_BUDGET.REFER5%TYPE
            , P_REFER6              IN FI_SLIP_LINE_BUDGET.REFER6%TYPE
            , P_REFER7              IN FI_SLIP_LINE_BUDGET.REFER7%TYPE
            , P_REFER8              IN FI_SLIP_LINE_BUDGET.REFER8%TYPE
            , P_REFER9              IN FI_SLIP_LINE_BUDGET.REFER9%TYPE
            , P_VOUCH_CODE          IN FI_SLIP_LINE_BUDGET.VOUCH_CODE%TYPE
            , P_REFER_RATE          IN FI_SLIP_LINE_BUDGET.REFER_RATE%TYPE
            , P_REFER_AMOUNT        IN FI_SLIP_LINE_BUDGET.REFER_AMOUNT%TYPE
            , P_REFER_DATE1         IN FI_SLIP_LINE_BUDGET.REFER_DATE1%TYPE
            , P_REFER_DATE2         IN FI_SLIP_LINE_BUDGET.REFER_DATE2%TYPE
            , P_REMARK              IN FI_SLIP_LINE_BUDGET.REMARK%TYPE
            , P_FUND_CODE           IN FI_SLIP_LINE_BUDGET.FUND_CODE%TYPE
            , P_USER_ID             IN FI_SLIP_LINE_BUDGET.CREATED_BY%TYPE
            )
  AS
    V_SLIP_DATE             FI_SLIP_LINE_BUDGET.SLIP_DATE%TYPE;
    V_HEADER_ID             FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE;

    V_BASE_CURRENCY_CODE    FI_SLIP_LINE.CURRENCY_CODE%TYPE;
    N_GL_AMOUNT             FI_SLIP_LINE.GL_AMOUNT%TYPE;

  BEGIN
    BEGIN
      SELECT SH.SLIP_DATE
           , SH.HEADER_ID
        INTO V_SLIP_DATE
           , V_HEADER_ID
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_SLIP_LINE_BUDGET SL
       WHERE SH.HEADER_ID         = SL.HEADER_ID
         AND SL.LINE_ID           = W_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

    IF GL_FISCAL_PERIOD_G.PERIOD_STATUS_F(NULL, V_SLIP_DATE, W_SOB_ID, W_ORG_ID) IN('C', 'N') THEN
      RAISE ERRNUMS.Data_Not_Opened;
    END IF;

    IF SLIP_CONFIRM_YN_F(V_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    -- 일반경비전표 UPDATE.
    FI_SLIP_INTERFACE_G.UPDATE_LINE_IF
      ( W_LINE_INTERFACE_ID   => SLIP_LINE_INTERFACE_ID_F(W_LINE_ID)
      , W_SOB_ID              => W_SOB_ID
      , W_ORG_ID              => W_ORG_ID
      , P_BUDGET_DEPT_ID      => P_BUDGET_DEPT_ID
      , P_CUSTOMER_ID         => P_CUSTOMER_ID
      , P_ACCOUNT_CONTROL_ID  => P_ACCOUNT_CONTROL_ID
      , P_ACCOUNT_CODE        => P_ACCOUNT_CODE
      , P_COST_CENTER_ID      => P_COST_CENTER_ID
      , P_ACCOUNT_DR_CR       => P_ACCOUNT_DR_CR
      , P_GL_AMOUNT           => P_GL_AMOUNT
      , P_CURRENCY_CODE       => P_CURRENCY_CODE
      , P_EXCHANGE_RATE       => P_EXCHANGE_RATE
      , P_GL_CURRENCY_AMOUNT  => P_GL_CURRENCY_AMOUNT
      , P_BANK_ACCOUNT_ID     => P_BANK_ACCOUNT_ID
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
      , P_VOUCH_CODE          => P_VOUCH_CODE
      , P_REFER_RATE          => P_REFER_RATE
      , P_REFER_AMOUNT        => P_REFER_AMOUNT
      , P_REFER_DATE1         => P_REFER_DATE1
      , P_REFER_DATE2         => P_REFER_DATE2
      , P_REMARK              => P_REMARK
      , P_FUND_CODE           => P_FUND_CODE
      , P_USER_ID             => P_USER_ID
      );
            
    -- 기본통화.
    V_BASE_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(W_SOB_ID);
    -- 원화금액 환산.
    N_GL_AMOUNT := FI_COMMON_G.CONVERSION_BASE_AMOUNT_F
                        ( V_BASE_CURRENCY_CODE
                        , W_SOB_ID
                        , NVL(P_GL_AMOUNT, 0)
                        );
    
    -- 예산전표 UPDATE.
    UPDATE FI_SLIP_LINE_BUDGET
      SET SLIP_DATE                  = V_SLIP_DATE
        , BUDGET_DEPT_ID             = P_BUDGET_DEPT_ID
        , CUSTOMER_ID                = P_CUSTOMER_ID
        , ACCOUNT_CONTROL_ID         = P_ACCOUNT_CONTROL_ID
        , ACCOUNT_CODE               = P_ACCOUNT_CODE
        , COST_CENTER_ID             = P_COST_CENTER_ID
        , ACCOUNT_DR_CR              = P_ACCOUNT_DR_CR
        , GL_AMOUNT                  = N_GL_AMOUNT
        , CURRENCY_CODE              = P_CURRENCY_CODE
        , EXCHANGE_RATE              = P_EXCHANGE_RATE
        , GL_CURRENCY_AMOUNT         = P_GL_CURRENCY_AMOUNT
        , BANK_ACCOUNT_ID            = P_BANK_ACCOUNT_ID
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
        , VOUCH_CODE                 = P_VOUCH_CODE
        , REFER_RATE                 = P_REFER_RATE
        , REFER_AMOUNT               = P_REFER_AMOUNT
        , REFER_DATE1                = P_REFER_DATE1
        , REFER_DATE2                = P_REFER_DATE2
        , REMARK                     = P_REMARK
        , FUND_CODE                  = P_FUND_CODE
        , LAST_UPDATE_DATE           = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY            = P_USER_ID
    WHERE LINE_ID                    = W_LINE_ID;

    -- HEADER INTERFACE 수정.
    UPDATE_HEADER_IF_LINE_VALUE(V_HEADER_ID);
  EXCEPTION
    WHEN ERRNUMS.Data_Not_Opened THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_opened_Code, ERRNUMS.Data_Not_Opened_Desc);
  END UPDATE_LINE_IF;

-- 예산전표 라인 삭제.
  PROCEDURE DELETE_LINE_IF
            ( W_LINE_ID           IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
            )
  AS
    V_HEADER_ID               FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE;

  BEGIN
    BEGIN
      SELECT SL.HEADER_ID
        INTO V_HEADER_ID
        FROM FI_SLIP_LINE_BUDGET SL
       WHERE SL.LINE_ID           = W_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10128', NULL));
    END;

    IF SLIP_CONFIRM_YN_F(V_HEADER_ID) <> 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10115', NULL));
    END IF;
    
    -- 일반경비전표 사겢.
    FI_SLIP_INTERFACE_G.DELETE_LINE_IF
      ( W_LINE_INTERFACE_ID   => SLIP_LINE_INTERFACE_ID_F(W_LINE_ID)
      );
              
    -- HEADER INTERFACE 수정.
    UPDATE_HEADER_IF_LINE_VALUE(V_HEADER_ID);

    DELETE FI_SLIP_LINE_BUDGET
    WHERE LINE_ID                 = W_LINE_ID;

  END DELETE_LINE_IF;

---------------------------------------------------------------------------------------------------
-- 예산전표 라인 인쇄 조회.
  PROCEDURE PRINT_LINE_IF
            ( P_CURSOR2              OUT TYPES.TCURSOR1
            , W_HEADER_ID            IN FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            , W_SOB_ID               IN FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID               IN FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT SL.LINE_ID
           , SL.SLIP_LINE_SEQ
           , SL.HEADER_ID
           , SL.SOB_ID
           , SL.ACCOUNT_BOOK_ID
           , SL.ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
           , SL.ACCOUNT_CONTROL_ID
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , SL.CURRENCY_CODE
           , SL.CURRENCY_CODE AS CURRENCY_DESC
           , SL.EXCHANGE_RATE
           , SL.GL_CURRENCY_AMOUNT
           , SL.GL_AMOUNT
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
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT1_ID'
                                                          , SL.MANAGEMENT1
                                                          , SL.SOB_ID) AS MANAGEMENT1_DESC
           , SL.MANAGEMENT2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'MANAGEMENT2_ID'
                                                          , SL.MANAGEMENT2
                                                          , SL.SOB_ID) AS MANAGEMENT2_DESC
           , SL.REFER1
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER1_ID'
                                                          , SL.REFER1
                                                          , SL.SOB_ID) AS REFER1_DESC
           , SL.REFER2
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER2_ID'
                                                          , SL.REFER2
                                                          , SL.SOB_ID) AS REFER2_DESC
           , SL.REFER3
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER3_ID'
                                                          , SL.REFER3
                                                          , SL.SOB_ID) AS REFER3_DESC
           , SL.REFER4
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER4_ID'
                                                          , SL.REFER4
                                                          , SL.SOB_ID) AS REFER4_DESC
           , SL.REFER5
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER5_ID'
                                                          , SL.REFER5
                                                          , SL.SOB_ID) AS REFER5_DESC
           , SL.REFER6
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER6_ID'
                                                          , SL.REFER6
                                                          , SL.SOB_ID) AS REFER6_DESC
           , SL.REFER7
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER7_ID'
                                                          , SL.REFER7
                                                          , SL.SOB_ID) AS REFER7_DESC
           , SL.REFER8
           , FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                          , SL.ACCOUNT_DR_CR
                                                          , 'REFER8_ID'
                                                          , SL.REFER8
                                                          , SL.SOB_ID) AS REFER8_DESC
           , SL.REMARK
           , SL.FUND_CODE
           , SL.UNIT_PRICE
           , SL.UOM_CODE
           , SL.UOM_QUANTITY
           , SL.UOM_WEIGHT
           , SL.INVENTORY_ITEM_ID
           , IMT.ITEM_CODE
           , IMT.ITEM_DESCRIPTION
           , SL.TRANSFER_YN
           , SL.CONFIRM_YN
           , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT1_ID) AS MANAGEMENT1_NAME
           , DECODE(ACI.MANAGEMENT1_ID, NULL, 'F', NVL(ACI.MANAGEMENT1_YN, 'N')) AS MANAGEMENT1_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT1_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT1_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT1_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS MANAGEMENT1_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.MANAGEMENT2_ID) AS MANAGEMENT2_NAME
           , DECODE(ACI.MANAGEMENT2_ID, NULL, 'F', NVL(ACI.MANAGEMENT2_YN, 'N')) AS MANAGEMENT2_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT2_ID,  DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS MANAGEMENT2_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.MANAGEMENT2_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS MANAGEMENT2_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER1_ID) AS REFER1_NAME
           , DECODE(ACI.REFER1_ID, NULL, 'F', NVL(ACI.REFER1_YN, 'N')) AS REFER1_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER1_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER1_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER1_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER1_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER2_ID) AS REFER2_NAME
           , DECODE(ACI.REFER2_ID, NULL, 'F', NVL(ACI.REFER2_YN, 'N')) AS REFER2_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER2_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER2_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER2_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER2_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER3_ID) AS REFER3_NAME
           , DECODE(ACI.REFER3_ID, NULL, 'F', NVL(ACI.REFER3_YN, 'N')) AS REFER3_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER3_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER3_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER3_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER3_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER4_ID) AS REFER4_NAME
           , DECODE(ACI.REFER4_ID, NULL, 'F', NVL(ACI.REFER4_YN, 'N')) AS REFER4_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER4_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER4_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER4_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER4_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER5_ID) AS REFER5_NAME
           , DECODE(ACI.REFER5_ID, NULL, 'F', NVL(ACI.REFER5_YN, 'N')) AS REFER5_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER5_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER5_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER5_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER5_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER6_ID) AS REFER6_NAME
           , DECODE(ACI.REFER6_ID, NULL, 'F', NVL(ACI.REFER6_YN, 'N')) AS REFER6_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER6_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER6_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER6_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER6_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER7_ID) AS REFER7_NAME
           , DECODE(ACI.REFER7_ID, NULL, 'F', NVL(ACI.REFER7_YN, 'N')) AS REFER7_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER7_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER7_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER7_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER7_DATA_TYPE
           , FI_COMMON_G.ID_NAME_F(ACI.REFER8_ID) AS REFER8_NAME
           , DECODE(ACI.REFER8_ID, NULL, 'F', NVL(ACI.REFER8_YN, 'N')) AS REFER8_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER8_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE1', 'VALUE2')), 'N') AS REFER8_LOOKUP_YN
           , NVL(FI_COMMON_G.ID_VALUE_F(ACI.REFER8_ID, DECODE(SL.ACCOUNT_DR_CR, '1', 'VALUE4', 'VALUE4')), 'VARCHAR2') AS REFER8_DATA_TYPE
           , NVL(AC.ACCOUNT_DR_CR, '1') AS CONTROL_ACCOUNT_DR_CR
           , NVL(AC.CUSTOMER_ENABLED_FLAG, 'N') AS CUSTOMER_ENABLED_FLAG
           , NVL(AC.BANK_ACCOUNT_FLAG, 'N') AS BANK_ACCOUNT_FLAG
           , NVL(AC.CURRENCY_ENABLED_FLAG, 'N') AS CURRENCY_ENABLED_FLAG
           , NVL(AC.VAT_ENABLED_FLAG, 'N') AS VAT_ENABLED_FLAG
           , NVL(AC.ACCOUNT_MICH_YN, 'N') AS ACCOUNT_MICH_YN
           , NVL(AC.BUDGET_ENABLED_FLAG, 'N') AS BUDGET_ENABLED_FLAG
           , NVL(AC.BUDGET_CONTROL_FLAG, 'N') AS BUDGET_CONTROL_FLAG
           , NVL(AC.BUDGET_BELONG_FLAG, 'N') AS BUDGET_BELONG_FLAG
           , NVL(AC.COST_CENTER_FLAG, 'N') AS COST_CENTER_FLAG
           , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, 0), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
           , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, 0), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
           , NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'MANAGEMENT1_ID'
                                                              , SL.MANAGEMENT1
                                                              , SL.SOB_ID), SL.MANAGEMENT1)
          || DECODE(SL.MANAGEMENT2, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'MANAGEMENT2_ID'
                                                              , SL.MANAGEMENT2
                                                              , SL.SOB_ID), SL.MANAGEMENT2)
          || DECODE(SL.REFER1, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER1_ID'
                                                              , SL.REFER1
                                                              , SL.SOB_ID), SL.REFER1)
          || DECODE(SL.REFER2, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER2_ID'
                                                              , SL.REFER2
                                                              , SL.SOB_ID), SL.REFER2)
          || DECODE(SL.REFER3, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER3_ID'
                                                              , SL.REFER3
                                                              , SL.SOB_ID), SL.REFER3)
          || DECODE(SL.REFER4, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER4_ID'
                                                              , SL.REFER4
                                                              , SL.SOB_ID), SL.REFER4)
          || DECODE(SL.REFER5, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER5_ID'
                                                              , SL.REFER5
                                                              , SL.SOB_ID), SL.REFER5)
          || DECODE(SL.REFER6, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER6_ID'
                                                              , SL.REFER6
                                                              , SL.SOB_ID), SL.REFER6)
          || DECODE(SL.REFER7, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER7_ID'
                                                              , SL.REFER7
                                                              , SL.SOB_ID), SL.REFER7)
          || DECODE(SL.REFER8, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER8_ID'
                                                              , SL.REFER8
                                                              , SL.SOB_ID), SL.REFER8)
             AS M_REFERENCE
        FROM FI_SLIP_LINE_BUDGET SL
          , FI_AUTO_JOURNAL_LINE AJL
          , FI_SUPP_CUST_V SCV
          , FI_ACCOUNT_CONTROL AC
          , FI_ACCOUNT_CONTROL_ITEM ACI
          , FI_BANK_ACCOUNT_TLV BAT
          , INV_ITEM_MASTER_TLV IMT
       WHERE SL.JOURNAL_HEADER_ID       = AJL.JOURNAL_HEADER_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AJL.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = AJL.ACCOUNT_DR_CR(+)
         AND SL.CUSTOMER_ID             = SCV.SUPP_CUST_ID(+)
         AND SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
         AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                  = ACI.SOB_ID(+)
         AND SL.BANK_ACCOUNT_ID         = BAT.BANK_ACCOUNT_ID(+)
         AND SL.INVENTORY_ITEM_ID       = IMT.INVENTORY_ITEM_ID(+)
         AND NVL(AJL.DISPLAY_YN, 'Y')   = 'Y'
         AND SL.HEADER_ID               = W_HEADER_ID
         AND SL.SOB_ID                  = W_SOB_ID
      ORDER BY SL.SLIP_LINE_SEQ
      ;
  END PRINT_LINE_IF;

PROCEDURE SELECT_SLIP_LINE_PRINT_2
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_SOB_ID                IN  FI_SLIP_LINE_BUDGET.SOB_ID%TYPE
            , W_ORG_ID                IN  FI_SLIP_LINE_BUDGET.ORG_ID%TYPE
            , W_HEADER_ID             IN  FI_SLIP_LINE_BUDGET.HEADER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT SL.SLIP_LINE_SEQ
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', SL.ACCOUNT_DR_CR, SL.SOB_ID, SL.ORG_ID) AS ACCOUNT_DR_CR_NAME
           , SL.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '1', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS DR_AMOUNT
           , EAPP_CURRENCY_G.DISPLAY_AMOUNT_F(SL.CURRENCY_CODE, DECODE(SL.ACCOUNT_DR_CR, '2', SL.GL_AMOUNT, NULL), W_SOB_ID, W_ORG_ID) AS CR_AMOUNT
           , NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'MANAGEMENT1_ID'
                                                              , SL.MANAGEMENT1
                                                              , SL.SOB_ID), SL.MANAGEMENT1)
          || DECODE(SL.MANAGEMENT2, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'MANAGEMENT2_ID'
                                                              , SL.MANAGEMENT2
                                                              , SL.SOB_ID), SL.MANAGEMENT2)
          || DECODE(SL.REFER1, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER1_ID'
                                                              , SL.REFER1
                                                              , SL.SOB_ID), SL.REFER1)
          || DECODE(SL.REFER2, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER2_ID'
                                                              , SL.REFER2
                                                              , SL.SOB_ID), SL.REFER2)
          || DECODE(SL.REFER3, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER3_ID'
                                                              , SL.REFER3
                                                              , SL.SOB_ID), SL.REFER3)
          || DECODE(SL.REFER4, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER4_ID'
                                                              , SL.REFER4
                                                              , SL.SOB_ID), SL.REFER4)
          || DECODE(SL.REFER5, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER5_ID'
                                                              , SL.REFER5
                                                              , SL.SOB_ID), SL.REFER5)
          || DECODE(SL.REFER6, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER6_ID'
                                                              , SL.REFER6
                                                              , SL.SOB_ID), SL.REFER6)
          || DECODE(SL.REFER7, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER7_ID'
                                                              , SL.REFER7
                                                              , SL.SOB_ID), SL.REFER7)
          || DECODE(SL.REFER8, NULL, '', ' ')
          || NVL(FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_DESC_F( SL.ACCOUNT_CONTROL_ID
                                                              , SL.ACCOUNT_DR_CR
                                                              , 'REFER8_ID'
                                                              , SL.REFER8
                                                              , SL.SOB_ID), SL.REFER8)
          || DECODE(SL.CURRENCY_CODE, FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(SL.SOB_ID), NULL, ' '
            || SL.CURRENCY_CODE || TO_CHAR(SL.GL_CURRENCY_AMOUNT, 'FM999,999,999,999,999') || '(' || TO_CHAR(SL.EXCHANGE_RATE, 'FM999,999,999.9999') || ')')
             AS M_REFERENCE
           , SL.REMARK
           , SL.HEADER_ID
           , SL.LINE_ID
        FROM FI_SLIP_LINE_BUDGET                   SL
           , FI_ACCOUNT_CONTROL                    AC
           , FI_ACCOUNT_CONTROL_ITEM               ACI
       WHERE SL.ACCOUNT_CONTROL_ID               = AC.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_CONTROL_ID               = ACI.ACCOUNT_CONTROL_ID(+)
         AND SL.ACCOUNT_DR_CR                    = ACI.ACCOUNT_DR_CR(+)
         AND SL.SOB_ID                           = ACI.SOB_ID(+)
         AND SL.SOB_ID                           = W_SOB_ID
         AND SL.HEADER_ID                        = W_HEADER_ID
      ORDER BY SL.SLIP_LINE_SEQ
           ;

  END;
  
---------------------------------------------------------------------------------------------------
-- 계정 통제관리값 : LOOKUP TYPE에 따른 해당 값 리턴..
  FUNCTION SLIP_IF_ITEM_VALUE_F
          ( W_LINE_ID             IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
          , W_LOOKUP_TYPE         IN VARCHAR2
          , W_SOB_ID              IN FI_ACCOUNT_CONTROL_ITEM.SOB_ID%TYPE
          ) RETURN VARCHAR2
  AS
    V_ITEM_VALUE                  VARCHAR2(150) := NULL;

  BEGIN
    BEGIN
      SELECT CASE W_LOOKUP_TYPE
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'MANAGEMENT1_ID', ACI.SOB_ID) THEN SL.MANAGEMENT1
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'MANAGEMENT2_ID', ACI.SOB_ID) THEN SL.MANAGEMENT2
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER1_ID', ACI.SOB_ID) THEN SL.REFER1
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER2_ID', ACI.SOB_ID) THEN SL.REFER2
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER3_ID', ACI.SOB_ID) THEN SL.REFER3
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER4_ID', ACI.SOB_ID) THEN SL.REFER4
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER5_ID', ACI.SOB_ID) THEN SL.REFER5
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER6_ID', ACI.SOB_ID) THEN SL.REFER6
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER7_ID', ACI.SOB_ID) THEN SL.REFER7
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER8_ID', ACI.SOB_ID) THEN SL.REFER8
               WHEN FI_ACCOUNT_CONTROL_ITEM_G.CONTROL_ITEM_LOOKUP_TYPE_F(ACI.ACCOUNT_CONTROL_ID, ACI.ACCOUNT_DR_CR, 'REFER9_ID', ACI.SOB_ID) THEN SL.REFER9
             END AS ITEM_VALUE
        INTO V_ITEM_VALUE
        FROM FI_SLIP_LINE_BUDGET SL
          , FI_ACCOUNT_CONTROL AC
          , FI_ACCOUNT_CONTROL_ITEM ACI
      WHERE SL.ACCOUNT_CONTROL_ID      = AC.ACCOUNT_CONTROL_ID
        AND SL.ACCOUNT_CONTROL_ID      = ACI.ACCOUNT_CONTROL_ID(+)
        AND SL.ACCOUNT_DR_CR           = ACI.ACCOUNT_DR_CR(+)
        AND SL.SOB_ID                  = ACI.SOB_ID(+)
        AND SL.LINE_ID                 = W_LINE_ID
        AND SL.SOB_ID                  = W_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_ITEM_VALUE;

  END SLIP_IF_ITEM_VALUE_F;

---------------------------------------------------------------------------------------------------
-- 일번경비전표 헤더 ID 리턴.
  FUNCTION SLIP_HEADER_INTERFACE_ID_F
           ( W_HEADER_ID          IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           ) RETURN NUMBER
  AS
    V_HEADER_INTERFACE_ID         NUMBER;
  BEGIN
    BEGIN
      SELECT SH.SOURCE_HEADER_ID
        INTO V_HEADER_INTERFACE_ID
        FROM FI_SLIP_HEADER_BUDGET SH
       WHERE SH.HEADER_ID         = W_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_HEADER_INTERFACE_ID := -1;
    END;
    RETURN V_HEADER_INTERFACE_ID;
  END SLIP_HEADER_INTERFACE_ID_F;

  FUNCTION SLIP_LINE_INTERFACE_ID_F
           ( W_LINE_ID            IN FI_SLIP_LINE_BUDGET.LINE_ID%TYPE
           ) RETURN NUMBER
  AS
    V_LINE_INTERFACE_ID         NUMBER;
  BEGIN
    BEGIN
      SELECT SL.SOURCE_LINE_ID
        INTO V_LINE_INTERFACE_ID
        FROM FI_SLIP_LINE_BUDGET SL
       WHERE SL.LINE_ID           = W_LINE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LINE_INTERFACE_ID := -1;
    END;
    RETURN V_LINE_INTERFACE_ID;  
  END SLIP_LINE_INTERFACE_ID_F;
           
---------------------------------------------------------------------------------------------------
-- 전표 인터페이스 분개 여부 체크.
  FUNCTION SLIP_TRANSFER_YN_F
           ( W_HEADER_ID          IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(2) := 'N';
    V_HEADER_INTERFACE_ID         NUMBER;
  BEGIN
    BEGIN
      V_HEADER_INTERFACE_ID := SLIP_HEADER_INTERFACE_ID_F(W_HEADER_ID);
      V_RETURN_VALUE := FI_SLIP_INTERFACE_G.SLIP_TRANSFER_YN_F(V_HEADER_INTERFACE_ID);
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'N';
    END;
    RETURN V_RETURN_VALUE;
  END SLIP_TRANSFER_YN_F;

-- 전표 승인 여부 체크.
  FUNCTION SLIP_CONFIRM_YN_F
           ( W_HEADER_ID          IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           ) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                VARCHAR2(2) := 'N';
    V_HEADER_INTERFACE_ID         NUMBER;
  BEGIN
    BEGIN
      V_HEADER_INTERFACE_ID := SLIP_HEADER_INTERFACE_ID_F(W_HEADER_ID);
      V_RETURN_VALUE := FI_SLIP_INTERFACE_G.SLIP_CONFIRM_YN_F(V_HEADER_INTERFACE_ID);
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'N';
    END;
    RETURN V_RETURN_VALUE;
  END SLIP_CONFIRM_YN_F;

-- 전표 승인 여부 체크.
  PROCEDURE SLIP_CONFIRM_YN_P
           ( W_HEADER_ID            IN FI_SLIP_HEADER_BUDGET.HEADER_ID%TYPE
           , O_CONFIRM_YN           OUT VARCHAR2
           )
  AS
  BEGIN
    O_CONFIRM_YN := SLIP_CONFIRM_YN_F( W_HEADER_ID);
  END SLIP_CONFIRM_YN_P;

-- 전표번호 조회 LOOKUP.
  PROCEDURE LU_SLIP_NUM
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT SH.SLIP_NUM
           , SH.SLIP_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.GL_AMOUNT
           , SH.HEADER_ID
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_SLIP_TYPE_V ST
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND ST.SLIP_TYPE_CLASS         = NVL(W_SLIP_TYPE_CLASS, ST.SLIP_TYPE_CLASS)
         AND SH.SOB_ID                  = W_SOB_ID
      ORDER BY SH.SLIP_NUM DESC
      ;
  END LU_SLIP_NUM;

-- 전표번호 해당 부서것만 조회 LOOKUP.
  PROCEDURE LU_SLIP_NUM_C
            ( P_CURSOR3           OUT TYPES.TCURSOR3
            , W_SLIP_TYPE         IN VARCHAR2
            , W_SLIP_TYPE_CLASS   IN VARCHAR2
            , W_SOB_ID            IN NUMBER
            , W_CONNECT_PERSON_ID IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT SH.SLIP_NUM
           , SH.SLIP_DATE
           , HRM_PERSON_MASTER_G.NAME_F(SH.PERSON_ID) AS PERSON_NAME
           , SH.GL_AMOUNT
           , SH.HEADER_ID
        FROM FI_SLIP_HEADER_BUDGET SH
          , FI_SLIP_TYPE_V ST
       WHERE SH.SLIP_TYPE               = ST.SLIP_TYPE
         AND SH.SOB_ID                  = ST.SOB_ID
         AND SH.SLIP_TYPE               = NVL(W_SLIP_TYPE, SH.SLIP_TYPE)
         AND ST.SLIP_TYPE_CLASS         = NVL(W_SLIP_TYPE_CLASS, ST.SLIP_TYPE_CLASS)
         AND SH.SOB_ID                  = W_SOB_ID
         AND EXISTS ( SELECT 'X'
                        FROM HRM_PERSON_MASTER PM
                          , HRM_DEPT_MAPPING DM
                      WHERE PM.DEPT_ID          = DM.HR_DEPT_ID
                        AND DM.M_DEPT_ID        = SH.DEPT_ID
                        AND DM.MODULE_TYPE      = 'FCM'
                        AND PM.PERSON_ID        = W_CONNECT_PERSON_ID
                        AND PM.SOB_ID           = W_SOB_ID
                     )
      ORDER BY SH.SLIP_NUM DESC
      ;
  END LU_SLIP_NUM_C;

END FI_SLIP_BUDGET_G;
/
