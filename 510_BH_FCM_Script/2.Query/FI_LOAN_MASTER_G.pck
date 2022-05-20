CREATE OR REPLACE PACKAGE FI_LOAN_MASTER_G
AS

-- 차입금 원장 조회.
  PROCEDURE LOAN_MASTER_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_LOAN_NUM           IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , W_SOB_ID             IN FI_LOAN_MASTER.SOB_ID%TYPE
            );
            
-- 차입금 원장 등록.
  PROCEDURE LOAN_MASTER_INSERT
            ( P_LOAN_NUM            IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , P_SOB_ID              IN FI_LOAN_MASTER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_LOAN_MASTER.ORG_ID%TYPE
            , P_LOAN_DESC           IN FI_LOAN_MASTER.LOAN_DESC%TYPE
            , P_LOAN_KIND                     IN FI_LOAN_MASTER.LOAN_KIND%TYPE
            , P_LOAN_TYPE                     IN FI_LOAN_MASTER.LOAN_TYPE%TYPE
            , P_LOAN_USE                      IN FI_LOAN_MASTER.LOAN_USE%TYPE            
            , P_L_ISSUE_DATE                  IN FI_LOAN_MASTER.L_ISSUE_DATE%TYPE
            , P_L_DUE_DATE                    IN FI_LOAN_MASTER.L_DUE_DATE%TYPE
            , P_L_CURRENCY_CODE               IN FI_LOAN_MASTER.L_CURRENCY_CODE%TYPE
            , P_L_EXCHANGE_RATE               IN FI_LOAN_MASTER.L_EXCHANGE_RATE%TYPE
            , P_LIMIT_CURR_AMOUNT             IN FI_LOAN_MASTER.LIMIT_CURR_AMOUNT%TYPE
            , P_LIMIT_AMOUNT                  IN FI_LOAN_MASTER.LIMIT_AMOUNT%TYPE
            , P_ISSUE_DATE                    IN FI_LOAN_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                      IN FI_LOAN_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE                 IN FI_LOAN_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE                 IN FI_LOAN_MASTER.EXCHANGE_RATE%TYPE
            , P_LOAN_CURR_AMOUNT              IN FI_LOAN_MASTER.LOAN_CURR_AMOUNT%TYPE
            , P_LOAN_AMOUNT                   IN FI_LOAN_MASTER.LOAN_AMOUNT%TYPE
            , P_LOAN_ADD_AMOUNT               IN FI_LOAN_MASTER.LOAN_ADD_AMOUNT%TYPE
            , P_LOAN_ADD_CURR_AMOUNT          IN FI_LOAN_MASTER.LOAN_ADD_CURR_AMOUNT%TYPE
            , P_LOAN_ACCOUNT_CONTROL_ID       IN FI_LOAN_MASTER.LOAN_ACCOUNT_CONTROL_ID%TYPE            
            , P_LOAN_BANK_ID                  IN FI_LOAN_MASTER.LOAN_BANK_ID%TYPE
            , P_LOAN_BANK_ACCOUNT_ID          IN FI_LOAN_MASTER.LOAN_BANK_ACCOUNT_ID%TYPE
            , P_ENSURE_TYPE                   IN FI_LOAN_MASTER.ENSURE_TYPE%TYPE
            , P_REPAY_CONDITION               IN FI_LOAN_MASTER.REPAY_CONDITION%TYPE
            , P_TERM_YEAR                     IN FI_LOAN_MASTER.TERM_YEAR%TYPE
            , P_TERM_MONTH                    IN FI_LOAN_MASTER.TERM_MONTH%TYPE
            , P_REPAY_CYCLE_MONTH             IN FI_LOAN_MASTER.REPAY_CYCLE_MONTH%TYPE
            , P_START_REPAY_DATE              IN FI_LOAN_MASTER.START_REPAY_DATE%TYPE
            , P_INTER_RATE                    IN FI_LOAN_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE                   IN FI_LOAN_MASTER.SPREAD_RATE%TYPE
            , P_INTER_TYPE                    IN FI_LOAN_MASTER.INTER_TYPE%TYPE
            , P_INTER_PAYMENT_TYPE            IN FI_LOAN_MASTER.INTER_PAYMENT_TYPE%TYPE
            , P_START_INTER_DATE              IN FI_LOAN_MASTER.START_INTER_DATE%TYPE
            , P_INTER_PAYMENT_CYCLE           IN FI_LOAN_MASTER.INTER_PAYMENT_CYCLE%TYPE
            , P_ADVANCE_INTER                 IN FI_LOAN_MASTER.ADVANCE_INTER%TYPE
            , P_ADVANCE_CURR_INTER            IN FI_LOAN_MASTER.ADVANCE_CURR_INTER%TYPE
            , P_INTER_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.INTER_ACCOUNT_CONTROL_ID%TYPE
            , P_COMMI_AMOUNT                  IN FI_LOAN_MASTER.COMMI_AMOUNT%TYPE
            , P_COMMI_CURR_AMOUNT             IN FI_LOAN_MASTER.COMMI_CURR_AMOUNT%TYPE
            , P_COMMI_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.COMMI_ACCOUNT_CONTROL_ID%TYPE
            , P_REPAY_COUNT                   IN FI_LOAN_MASTER.REPAY_COUNT%TYPE
            , P_REPAY_ONE_AMOUNT              IN FI_LOAN_MASTER.REPAY_ONE_AMOUNT%TYPE
            , P_REPAY_ONE_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_ONE_CURR_AMOUNT%TYPE
            , P_REPAY_SUM_AMOUNT              IN FI_LOAN_MASTER.REPAY_SUM_AMOUNT%TYPE
            , P_REPAY_SUM_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_SUM_CURR_AMOUNT%TYPE
            , P_REPAY_LAST_DATE               IN FI_LOAN_MASTER.REPAY_LAST_DATE%TYPE
            , P_REPAY_INTER_COUNT             IN FI_LOAN_MASTER.REPAY_INTER_COUNT%TYPE
            , P_REPAY_INTER_SUM_AMOUNT        IN FI_LOAN_MASTER.REPAY_INTER_SUM_AMOUNT%TYPE
            , P_REPAY_INTER_SUM_CURR_AMOUNT   IN FI_LOAN_MASTER.REPAY_INTER_SUM_CURR_AMOUNT%TYPE
            , P_COST_CENTER_ID                IN FI_LOAN_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                        IN FI_LOAN_MASTER.REMARK%TYPE
            , P_MORTGAGE_REMARK               IN FI_LOAN_MASTER.MORTGAGE_REMARK%TYPE
            , P_USER_ID                       IN FI_LOAN_MASTER.LAST_UPDATED_BY%TYPE
            );

-- 차입금 원장 수정.
  PROCEDURE LOAN_MASTER_UPDATE
            ( W_LOAN_NUM                      IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , W_SOB_ID                        IN FI_LOAN_MASTER.SOB_ID%TYPE
            , W_ORG_ID                        IN FI_LOAN_MASTER.ORG_ID%TYPE
            , P_LOAN_DESC                     IN FI_LOAN_MASTER.LOAN_DESC%TYPE
            , P_LOAN_KIND                     IN FI_LOAN_MASTER.LOAN_KIND%TYPE
            , P_LOAN_TYPE                     IN FI_LOAN_MASTER.LOAN_TYPE%TYPE
            , P_LOAN_USE                      IN FI_LOAN_MASTER.LOAN_USE%TYPE            
            , P_L_ISSUE_DATE                  IN FI_LOAN_MASTER.L_ISSUE_DATE%TYPE
            , P_L_DUE_DATE                    IN FI_LOAN_MASTER.L_DUE_DATE%TYPE
            , P_L_CURRENCY_CODE               IN FI_LOAN_MASTER.L_CURRENCY_CODE%TYPE
            , P_L_EXCHANGE_RATE               IN FI_LOAN_MASTER.L_EXCHANGE_RATE%TYPE
            , P_LIMIT_CURR_AMOUNT             IN FI_LOAN_MASTER.LIMIT_CURR_AMOUNT%TYPE
            , P_LIMIT_AMOUNT                  IN FI_LOAN_MASTER.LIMIT_AMOUNT%TYPE
            , P_ISSUE_DATE                    IN FI_LOAN_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                      IN FI_LOAN_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE                 IN FI_LOAN_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE                 IN FI_LOAN_MASTER.EXCHANGE_RATE%TYPE
            , P_LOAN_CURR_AMOUNT              IN FI_LOAN_MASTER.LOAN_CURR_AMOUNT%TYPE
            , P_LOAN_AMOUNT                   IN FI_LOAN_MASTER.LOAN_AMOUNT%TYPE
            , P_LOAN_ADD_AMOUNT               IN FI_LOAN_MASTER.LOAN_ADD_AMOUNT%TYPE
            , P_LOAN_ADD_CURR_AMOUNT          IN FI_LOAN_MASTER.LOAN_ADD_CURR_AMOUNT%TYPE
            , P_LOAN_ACCOUNT_CONTROL_ID       IN FI_LOAN_MASTER.LOAN_ACCOUNT_CONTROL_ID%TYPE            
            , P_LOAN_BANK_ID                  IN FI_LOAN_MASTER.LOAN_BANK_ID%TYPE
            , P_LOAN_BANK_ACCOUNT_ID          IN FI_LOAN_MASTER.LOAN_BANK_ACCOUNT_ID%TYPE
            , P_ENSURE_TYPE                   IN FI_LOAN_MASTER.ENSURE_TYPE%TYPE
            , P_REPAY_CONDITION               IN FI_LOAN_MASTER.REPAY_CONDITION%TYPE
            , P_TERM_YEAR                     IN FI_LOAN_MASTER.TERM_YEAR%TYPE
            , P_TERM_MONTH                    IN FI_LOAN_MASTER.TERM_MONTH%TYPE
            , P_REPAY_CYCLE_MONTH             IN FI_LOAN_MASTER.REPAY_CYCLE_MONTH%TYPE
            , P_START_REPAY_DATE              IN FI_LOAN_MASTER.START_REPAY_DATE%TYPE
            , P_INTER_RATE                    IN FI_LOAN_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE                   IN FI_LOAN_MASTER.SPREAD_RATE%TYPE
            , P_INTER_TYPE                    IN FI_LOAN_MASTER.INTER_TYPE%TYPE
            , P_INTER_PAYMENT_TYPE            IN FI_LOAN_MASTER.INTER_PAYMENT_TYPE%TYPE
            , P_START_INTER_DATE              IN FI_LOAN_MASTER.START_INTER_DATE%TYPE
            , P_INTER_PAYMENT_CYCLE           IN FI_LOAN_MASTER.INTER_PAYMENT_CYCLE%TYPE
            , P_ADVANCE_INTER                 IN FI_LOAN_MASTER.ADVANCE_INTER%TYPE
            , P_ADVANCE_CURR_INTER            IN FI_LOAN_MASTER.ADVANCE_CURR_INTER%TYPE
            , P_INTER_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.INTER_ACCOUNT_CONTROL_ID%TYPE
            , P_COMMI_AMOUNT                  IN FI_LOAN_MASTER.COMMI_AMOUNT%TYPE
            , P_COMMI_CURR_AMOUNT             IN FI_LOAN_MASTER.COMMI_CURR_AMOUNT%TYPE
            , P_COMMI_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.COMMI_ACCOUNT_CONTROL_ID%TYPE
            , P_REPAY_COUNT                   IN FI_LOAN_MASTER.REPAY_COUNT%TYPE
            , P_REPAY_ONE_AMOUNT              IN FI_LOAN_MASTER.REPAY_ONE_AMOUNT%TYPE
            , P_REPAY_ONE_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_ONE_CURR_AMOUNT%TYPE
            , P_REPAY_SUM_AMOUNT              IN FI_LOAN_MASTER.REPAY_SUM_AMOUNT%TYPE
            , P_REPAY_SUM_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_SUM_CURR_AMOUNT%TYPE
            , P_REPAY_LAST_DATE               IN FI_LOAN_MASTER.REPAY_LAST_DATE%TYPE
            , P_REPAY_INTER_COUNT             IN FI_LOAN_MASTER.REPAY_INTER_COUNT%TYPE
            , P_REPAY_INTER_SUM_AMOUNT        IN FI_LOAN_MASTER.REPAY_INTER_SUM_AMOUNT%TYPE
            , P_REPAY_INTER_SUM_CURR_AMOUNT   IN FI_LOAN_MASTER.REPAY_INTER_SUM_CURR_AMOUNT%TYPE
            , P_COST_CENTER_ID                IN FI_LOAN_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                        IN FI_LOAN_MASTER.REMARK%TYPE
            , P_MORTGAGE_REMARK               IN FI_LOAN_MASTER.MORTGAGE_REMARK%TYPE
            , P_USER_ID                       IN FI_LOAN_MASTER.LAST_UPDATED_BY%TYPE
            );

-- 차입금 원장 수정 - 차입액/상환액 적용.
  PROCEDURE LOAN_MASTER_UPDATE_AMOUNT
            ( P_GB                            IN VARCHAR2            
            , P_LOAN_NUM                      IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , P_SOB_ID                        IN FI_LOAN_MASTER.SOB_ID%TYPE
            , P_ORG_ID                        IN FI_LOAN_MASTER.ORG_ID%TYPE
            , P_GL_DATE                       IN FI_SLIP_LINE.GL_DATE%TYPE
            , P_ACCOUNT_DR_CR                 IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_CURRENCY_AMOUNT            IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_GL_AMOUNT                     IN FI_SLIP_LINE.GL_AMOUNT%TYPE            
            , P_USER_ID                       IN FI_LOAN_MASTER.LAST_UPDATED_BY%TYPE
            );

-- 차입금 번호 lookup.
  PROCEDURE LU_LOAN_NUM
            ( P_CURSOR3                   OUT TYPES.TCURSOR3            
            , W_SOB_ID                    IN NUMBER
            );
            
END FI_LOAN_MASTER_G;

 
/
CREATE OR REPLACE PACKAGE BODY FI_LOAN_MASTER_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : FI_LOAN_MASTER_G
/* Description  : 차입금 현황.
/*
/* Reference by : 부서정보 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- 차입금 원장 조회.
  PROCEDURE LOAN_MASTER_SELECT
            ( P_CURSOR             OUT TYPES.TCURSOR
            , W_LOAN_NUM           IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , W_SOB_ID             IN FI_LOAN_MASTER.SOB_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT LM.LOAN_NUM
           , LM.SOB_ID
           , LM.ORG_ID
           , LM.LOAN_DESC
           , LM.LOAN_KIND
           , FI_COMMON_G.CODE_NAME_F('LOAN_KIND', LM.LOAN_KIND, LM.SOB_ID) AS LOAN_KIND_NAME
           , LM.LOAN_TYPE
           , FI_COMMON_G.CODE_NAME_F('LOAN_TYPE', LM.LOAN_TYPE, LM.SOB_ID) AS LOAN_TYPE_NAME
           , LM.LOAN_USE
           , FI_COMMON_G.CODE_NAME_F('LOAN_USE', LM.LOAN_USE, LM.SOB_ID) AS LOAN_USE_NAME           
           , LM.L_ISSUE_DATE
           , LM.L_DUE_DATE
           , LM.L_CURRENCY_CODE
           , LM.L_EXCHANGE_RATE
           , LM.LIMIT_CURR_AMOUNT
           , LM.LIMIT_AMOUNT                      
           , LM.ISSUE_DATE
           , LM.DUE_DATE
           , LM.CURRENCY_CODE
           , LM.EXCHANGE_RATE
           , LM.LOAN_CURR_AMOUNT
           , LM.LOAN_AMOUNT
           , LM.LOAN_ADD_AMOUNT
           , LM.LOAN_ADD_CURR_AMOUNT
           , LM.LOAN_ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_CODE_F(LM.LOAN_ACCOUNT_CONTROL_ID, LM.SOB_ID) AS LOAN_ACCOUNT_CONTROL_CODE
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(LM.LOAN_ACCOUNT_CONTROL_ID, LM.SOB_ID) AS LOAN_ACCOUNT_CONTROL_NAME
           , LM.LOAN_BANK_ID
           , FB.BANK_CODE AS LOAN_BANK_CODE
           , FB.BANK_NAME AS LOAN_BANK_NAME
           , LM.LOAN_BANK_ACCOUNT_ID
           , BA.BANK_ACCOUNT_NUM  AS LOAN_BANK_ACCOUNT_NUM
           , BA.BANK_ACCOUNT_NAME AS LOAN_BANK_ACCOUNT_NAME
           , LM.ENSURE_TYPE
           , FI_COMMON_G.CODE_NAME_F('ENSURE_TYPE', LM.ENSURE_TYPE, LM.SOB_ID) AS ENSURE_TYPE_NAME
           , LM.REPAY_CONDITION
           , LM.TERM_YEAR
           , LM.TERM_MONTH
           , LM.REPAY_CYCLE_MONTH
           , LM.START_REPAY_DATE
           , LM.INTER_RATE
           , LM.SPREAD_RATE
           , LM.INTER_TYPE
           , FI_COMMON_G.CODE_NAME_F('INTEREST_TYPE', LM.INTER_TYPE, LM.SOB_ID) AS INTER_TYPE_NAME
           , LM.INTER_PAYMENT_TYPE
           , FI_COMMON_G.CODE_NAME_F('LOAN_RATE_PAY_TYPE', LM.INTER_PAYMENT_TYPE, LM.SOB_ID) AS INTER_PAYMENT_TYPE_NAME
           , LM.START_INTER_DATE
           , LM.INTER_PAYMENT_CYCLE
           , LM.ADVANCE_INTER
           , LM.ADVANCE_CURR_INTER
           , LM.INTER_ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(LM.INTER_ACCOUNT_CONTROL_ID, LM.SOB_ID) AS INTER_ACCOUNT_DESC
           , LM.COMMI_AMOUNT
           , LM.COMMI_CURR_AMOUNT
           , LM.COMMI_ACCOUNT_CONTROL_ID
           , FI_ACCOUNT_CONTROL_G.ACCOUNT_DESC_F(LM.COMMI_ACCOUNT_CONTROL_ID, LM.SOB_ID) AS COMMI_ACCOUNT_DESC
           , LM.REPAY_COUNT
           , LM.REPAY_ONE_AMOUNT
           , LM.REPAY_ONE_CURR_AMOUNT
           , LM.REPAY_SUM_AMOUNT
           , LM.REPAY_SUM_CURR_AMOUNT
           , CASE
               WHEN LM.LOAN_KIND = '2' THEN NVL(LM.LIMIT_CURR_AMOUNT, 0) - NVL(LM.LOAN_CURR_AMOUNT, 0)
               ELSE NVL(LM.LOAN_CURR_AMOUNT, 0) - NVL(LM.REPAY_SUM_CURR_AMOUNT, 0)
             END AS REMAIN_CURR_AMOUNT
           , CASE
               WHEN LM.LOAN_KIND = '2' THEN NVL(LM.LIMIT_AMOUNT, 0) - NVL(LM.LOAN_AMOUNT, 0)
               ELSE NVL(LM.LOAN_AMOUNT, 0) - NVL(LM.REPAY_SUM_AMOUNT, 0)
             END AS REMAIN_AMOUNT             
           , LM.REPAY_LAST_DATE
           , LM.REPAY_INTER_COUNT
           , LM.REPAY_INTER_SUM_AMOUNT
           , LM.REPAY_INTER_SUM_CURR_AMOUNT
           , LM.COST_CENTER_ID
           , FI_COMMON_G.COST_CENTER_CODE_F(LM.COST_CENTER_ID) AS COST_CENTER_CODE
           , FI_COMMON_G.COST_CENTER_DESC_F(LM.COST_CENTER_ID) AS COST_CENTER_DESC           
           , LM.REMARK
           , LM.MORTGAGE_REMARK
        FROM FI_LOAN_MASTER   LM
           , FI_BANK FB
           , FI_BANK_ACCOUNT BA
       WHERE LM.LOAN_BANK_ID          = FB.BANK_ID
         AND LM.LOAN_BANK_ACCOUNT_ID  = BA.BANK_ACCOUNT_ID(+)
         AND LM.LOAN_NUM              = NVL(W_LOAN_NUM, LM.LOAN_NUM)
         AND LM.SOB_ID                = W_SOB_ID
       ;
  END LOAN_MASTER_SELECT;

-- 차입금 원장 등록.
  PROCEDURE LOAN_MASTER_INSERT
            ( P_LOAN_NUM            IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , P_SOB_ID              IN FI_LOAN_MASTER.SOB_ID%TYPE
            , P_ORG_ID              IN FI_LOAN_MASTER.ORG_ID%TYPE
            , P_LOAN_DESC           IN FI_LOAN_MASTER.LOAN_DESC%TYPE
            , P_LOAN_KIND                     IN FI_LOAN_MASTER.LOAN_KIND%TYPE
            , P_LOAN_TYPE                     IN FI_LOAN_MASTER.LOAN_TYPE%TYPE
            , P_LOAN_USE                      IN FI_LOAN_MASTER.LOAN_USE%TYPE            
            , P_L_ISSUE_DATE                  IN FI_LOAN_MASTER.L_ISSUE_DATE%TYPE
            , P_L_DUE_DATE                    IN FI_LOAN_MASTER.L_DUE_DATE%TYPE
            , P_L_CURRENCY_CODE               IN FI_LOAN_MASTER.L_CURRENCY_CODE%TYPE
            , P_L_EXCHANGE_RATE               IN FI_LOAN_MASTER.L_EXCHANGE_RATE%TYPE
            , P_LIMIT_CURR_AMOUNT             IN FI_LOAN_MASTER.LIMIT_CURR_AMOUNT%TYPE
            , P_LIMIT_AMOUNT                  IN FI_LOAN_MASTER.LIMIT_AMOUNT%TYPE
            , P_ISSUE_DATE                    IN FI_LOAN_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                      IN FI_LOAN_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE                 IN FI_LOAN_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE                 IN FI_LOAN_MASTER.EXCHANGE_RATE%TYPE
            , P_LOAN_CURR_AMOUNT              IN FI_LOAN_MASTER.LOAN_CURR_AMOUNT%TYPE
            , P_LOAN_AMOUNT                   IN FI_LOAN_MASTER.LOAN_AMOUNT%TYPE
            , P_LOAN_ADD_AMOUNT               IN FI_LOAN_MASTER.LOAN_ADD_AMOUNT%TYPE
            , P_LOAN_ADD_CURR_AMOUNT          IN FI_LOAN_MASTER.LOAN_ADD_CURR_AMOUNT%TYPE
            , P_LOAN_ACCOUNT_CONTROL_ID       IN FI_LOAN_MASTER.LOAN_ACCOUNT_CONTROL_ID%TYPE            
            , P_LOAN_BANK_ID                  IN FI_LOAN_MASTER.LOAN_BANK_ID%TYPE
            , P_LOAN_BANK_ACCOUNT_ID          IN FI_LOAN_MASTER.LOAN_BANK_ACCOUNT_ID%TYPE
            , P_ENSURE_TYPE                   IN FI_LOAN_MASTER.ENSURE_TYPE%TYPE
            , P_REPAY_CONDITION               IN FI_LOAN_MASTER.REPAY_CONDITION%TYPE
            , P_TERM_YEAR                     IN FI_LOAN_MASTER.TERM_YEAR%TYPE
            , P_TERM_MONTH                    IN FI_LOAN_MASTER.TERM_MONTH%TYPE
            , P_REPAY_CYCLE_MONTH             IN FI_LOAN_MASTER.REPAY_CYCLE_MONTH%TYPE
            , P_START_REPAY_DATE              IN FI_LOAN_MASTER.START_REPAY_DATE%TYPE
            , P_INTER_RATE                    IN FI_LOAN_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE                   IN FI_LOAN_MASTER.SPREAD_RATE%TYPE
            , P_INTER_TYPE                    IN FI_LOAN_MASTER.INTER_TYPE%TYPE
            , P_INTER_PAYMENT_TYPE            IN FI_LOAN_MASTER.INTER_PAYMENT_TYPE%TYPE
            , P_START_INTER_DATE              IN FI_LOAN_MASTER.START_INTER_DATE%TYPE
            , P_INTER_PAYMENT_CYCLE           IN FI_LOAN_MASTER.INTER_PAYMENT_CYCLE%TYPE
            , P_ADVANCE_INTER                 IN FI_LOAN_MASTER.ADVANCE_INTER%TYPE
            , P_ADVANCE_CURR_INTER            IN FI_LOAN_MASTER.ADVANCE_CURR_INTER%TYPE
            , P_INTER_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.INTER_ACCOUNT_CONTROL_ID%TYPE
            , P_COMMI_AMOUNT                  IN FI_LOAN_MASTER.COMMI_AMOUNT%TYPE
            , P_COMMI_CURR_AMOUNT             IN FI_LOAN_MASTER.COMMI_CURR_AMOUNT%TYPE
            , P_COMMI_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.COMMI_ACCOUNT_CONTROL_ID%TYPE
            , P_REPAY_COUNT                   IN FI_LOAN_MASTER.REPAY_COUNT%TYPE
            , P_REPAY_ONE_AMOUNT              IN FI_LOAN_MASTER.REPAY_ONE_AMOUNT%TYPE
            , P_REPAY_ONE_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_ONE_CURR_AMOUNT%TYPE
            , P_REPAY_SUM_AMOUNT              IN FI_LOAN_MASTER.REPAY_SUM_AMOUNT%TYPE
            , P_REPAY_SUM_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_SUM_CURR_AMOUNT%TYPE
            , P_REPAY_LAST_DATE               IN FI_LOAN_MASTER.REPAY_LAST_DATE%TYPE
            , P_REPAY_INTER_COUNT             IN FI_LOAN_MASTER.REPAY_INTER_COUNT%TYPE
            , P_REPAY_INTER_SUM_AMOUNT        IN FI_LOAN_MASTER.REPAY_INTER_SUM_AMOUNT%TYPE
            , P_REPAY_INTER_SUM_CURR_AMOUNT   IN FI_LOAN_MASTER.REPAY_INTER_SUM_CURR_AMOUNT%TYPE
            , P_COST_CENTER_ID                IN FI_LOAN_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                        IN FI_LOAN_MASTER.REMARK%TYPE
            , P_MORTGAGE_REMARK               IN FI_LOAN_MASTER.MORTGAGE_REMARK%TYPE
            , P_USER_ID                       IN FI_LOAN_MASTER.LAST_UPDATED_BY%TYPE
            )
  AS
    V_SYSDATE                                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT                            NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT COUNT(LM.LOAN_NUM) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM FI_LOAN_MASTER LM
      WHERE LM.LOAN_NUM           = P_LOAN_NUM
        AND LM.SOB_ID             = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
      RETURN;
    END IF;     
    INSERT INTO  FI_LOAN_MASTER
       (  LOAN_NUM,
          SOB_ID,
          ORG_ID,
          LOAN_DESC,
          LOAN_KIND,
          LOAN_TYPE,
          LOAN_USE,
          L_ISSUE_DATE,
          L_DUE_DATE,
          L_CURRENCY_CODE,
          L_EXCHANGE_RATE,
          LIMIT_CURR_AMOUNT,
          LIMIT_AMOUNT,                    
          ISSUE_DATE,
          DUE_DATE,
          CURRENCY_CODE,
          EXCHANGE_RATE,
          LOAN_CURR_AMOUNT,
          LOAN_AMOUNT,
          LOAN_ADD_AMOUNT,
          LOAN_ADD_CURR_AMOUNT,
          LOAN_ACCOUNT_CONTROL_ID,
          LOAN_BANK_ID,
          LOAN_BANK_ACCOUNT_ID,
          ENSURE_TYPE,
          REPAY_CONDITION,
          TERM_YEAR,
          TERM_MONTH,
          REPAY_CYCLE_MONTH,
          START_REPAY_DATE,
          INTER_RATE,
          SPREAD_RATE,
          INTER_TYPE,
          INTER_PAYMENT_TYPE,
          START_INTER_DATE,
          INTER_PAYMENT_CYCLE,
          ADVANCE_INTER,
          ADVANCE_CURR_INTER,
          INTER_ACCOUNT_CONTROL_ID,
          COMMI_AMOUNT,
          COMMI_CURR_AMOUNT,
          COMMI_ACCOUNT_CONTROL_ID,
          REPAY_COUNT,
          REPAY_ONE_AMOUNT,
          REPAY_ONE_CURR_AMOUNT,
          REPAY_SUM_AMOUNT,
          REPAY_SUM_CURR_AMOUNT,
          REPAY_LAST_DATE,
          REPAY_INTER_COUNT,
          REPAY_INTER_SUM_AMOUNT,
          REPAY_INTER_SUM_CURR_AMOUNT,
          COST_CENTER_ID,
          REMARK,
          MORTGAGE_REMARK,
          CREATION_DATE,
          CREATED_BY,
          LAST_UPDATE_DATE,
          LAST_UPDATED_BY )

    VALUES
      (   P_LOAN_NUM,
          P_SOB_ID,
          P_ORG_ID,
          P_LOAN_DESC,
          P_LOAN_KIND,
          P_LOAN_TYPE,
          P_LOAN_USE,
          P_L_ISSUE_DATE,
          P_L_DUE_DATE,
          P_L_CURRENCY_CODE,
          P_L_EXCHANGE_RATE,
          P_LIMIT_CURR_AMOUNT,
          P_LIMIT_AMOUNT,
          P_ISSUE_DATE,
          P_DUE_DATE,
          P_CURRENCY_CODE,
          P_EXCHANGE_RATE,
          P_LOAN_CURR_AMOUNT,
          P_LOAN_AMOUNT,          
          P_LOAN_ADD_AMOUNT,
          P_LOAN_ADD_CURR_AMOUNT,
          P_LOAN_ACCOUNT_CONTROL_ID,
          P_LOAN_BANK_ID,
          P_LOAN_BANK_ACCOUNT_ID,
          P_ENSURE_TYPE,
          P_REPAY_CONDITION,
          P_TERM_YEAR,
          P_TERM_MONTH,
          P_REPAY_CYCLE_MONTH,
          P_START_REPAY_DATE,
          P_INTER_RATE,
          P_SPREAD_RATE,
          P_INTER_TYPE,
          P_INTER_PAYMENT_TYPE,
          P_START_INTER_DATE,
          P_INTER_PAYMENT_CYCLE,
          P_ADVANCE_INTER,
          P_ADVANCE_CURR_INTER,
          P_INTER_ACCOUNT_CONTROL_ID,
          P_COMMI_AMOUNT,
          P_COMMI_CURR_AMOUNT,
          P_COMMi_ACCOUNT_CONTROL_ID,
          P_REPAY_COUNT,
          P_REPAY_ONE_AMOUNT,
          P_REPAY_ONE_CURR_AMOUNT,
          P_REPAY_SUM_AMOUNT,
          P_REPAY_SUM_CURR_AMOUNT,
          P_REPAY_LAST_DATE,
          P_REPAY_INTER_COUNT,
          P_REPAY_INTER_SUM_AMOUNT,
          P_REPAY_INTER_SUM_CURR_AMOUNT,
          P_COST_CENTER_ID,
          P_REMARK,
          P_MORTGAGE_REMARK,
          V_SYSDATE,
          P_USER_ID,
          V_SYSDATE,
          P_USER_ID
      );

  END LOAN_MASTER_INSERT;

-- 차입금 원장 수정.
  PROCEDURE LOAN_MASTER_UPDATE
            ( W_LOAN_NUM                      IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , W_SOB_ID                        IN FI_LOAN_MASTER.SOB_ID%TYPE
            , W_ORG_ID                        IN FI_LOAN_MASTER.ORG_ID%TYPE
            , P_LOAN_DESC                     IN FI_LOAN_MASTER.LOAN_DESC%TYPE
            , P_LOAN_KIND                     IN FI_LOAN_MASTER.LOAN_KIND%TYPE
            , P_LOAN_TYPE                     IN FI_LOAN_MASTER.LOAN_TYPE%TYPE
            , P_LOAN_USE                      IN FI_LOAN_MASTER.LOAN_USE%TYPE            
            , P_L_ISSUE_DATE                  IN FI_LOAN_MASTER.L_ISSUE_DATE%TYPE
            , P_L_DUE_DATE                    IN FI_LOAN_MASTER.L_DUE_DATE%TYPE
            , P_L_CURRENCY_CODE               IN FI_LOAN_MASTER.L_CURRENCY_CODE%TYPE
            , P_L_EXCHANGE_RATE               IN FI_LOAN_MASTER.L_EXCHANGE_RATE%TYPE
            , P_LIMIT_CURR_AMOUNT             IN FI_LOAN_MASTER.LIMIT_CURR_AMOUNT%TYPE
            , P_LIMIT_AMOUNT                  IN FI_LOAN_MASTER.LIMIT_AMOUNT%TYPE
            , P_ISSUE_DATE                    IN FI_LOAN_MASTER.ISSUE_DATE%TYPE
            , P_DUE_DATE                      IN FI_LOAN_MASTER.DUE_DATE%TYPE
            , P_CURRENCY_CODE                 IN FI_LOAN_MASTER.CURRENCY_CODE%TYPE
            , P_EXCHANGE_RATE                 IN FI_LOAN_MASTER.EXCHANGE_RATE%TYPE
            , P_LOAN_CURR_AMOUNT              IN FI_LOAN_MASTER.LOAN_CURR_AMOUNT%TYPE
            , P_LOAN_AMOUNT                   IN FI_LOAN_MASTER.LOAN_AMOUNT%TYPE
            , P_LOAN_ADD_AMOUNT               IN FI_LOAN_MASTER.LOAN_ADD_AMOUNT%TYPE
            , P_LOAN_ADD_CURR_AMOUNT          IN FI_LOAN_MASTER.LOAN_ADD_CURR_AMOUNT%TYPE
            , P_LOAN_ACCOUNT_CONTROL_ID       IN FI_LOAN_MASTER.LOAN_ACCOUNT_CONTROL_ID%TYPE            
            , P_LOAN_BANK_ID                  IN FI_LOAN_MASTER.LOAN_BANK_ID%TYPE
            , P_LOAN_BANK_ACCOUNT_ID          IN FI_LOAN_MASTER.LOAN_BANK_ACCOUNT_ID%TYPE
            , P_ENSURE_TYPE                   IN FI_LOAN_MASTER.ENSURE_TYPE%TYPE
            , P_REPAY_CONDITION               IN FI_LOAN_MASTER.REPAY_CONDITION%TYPE
            , P_TERM_YEAR                     IN FI_LOAN_MASTER.TERM_YEAR%TYPE
            , P_TERM_MONTH                    IN FI_LOAN_MASTER.TERM_MONTH%TYPE
            , P_REPAY_CYCLE_MONTH             IN FI_LOAN_MASTER.REPAY_CYCLE_MONTH%TYPE
            , P_START_REPAY_DATE              IN FI_LOAN_MASTER.START_REPAY_DATE%TYPE
            , P_INTER_RATE                    IN FI_LOAN_MASTER.INTER_RATE%TYPE
            , P_SPREAD_RATE                   IN FI_LOAN_MASTER.SPREAD_RATE%TYPE
            , P_INTER_TYPE                    IN FI_LOAN_MASTER.INTER_TYPE%TYPE
            , P_INTER_PAYMENT_TYPE            IN FI_LOAN_MASTER.INTER_PAYMENT_TYPE%TYPE
            , P_START_INTER_DATE              IN FI_LOAN_MASTER.START_INTER_DATE%TYPE
            , P_INTER_PAYMENT_CYCLE           IN FI_LOAN_MASTER.INTER_PAYMENT_CYCLE%TYPE
            , P_ADVANCE_INTER                 IN FI_LOAN_MASTER.ADVANCE_INTER%TYPE
            , P_ADVANCE_CURR_INTER            IN FI_LOAN_MASTER.ADVANCE_CURR_INTER%TYPE
            , P_INTER_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.INTER_ACCOUNT_CONTROL_ID%TYPE
            , P_COMMI_AMOUNT                  IN FI_LOAN_MASTER.COMMI_AMOUNT%TYPE
            , P_COMMI_CURR_AMOUNT             IN FI_LOAN_MASTER.COMMI_CURR_AMOUNT%TYPE
            , P_COMMI_ACCOUNT_CONTROL_ID      IN FI_LOAN_MASTER.COMMI_ACCOUNT_CONTROL_ID%TYPE
            , P_REPAY_COUNT                   IN FI_LOAN_MASTER.REPAY_COUNT%TYPE
            , P_REPAY_ONE_AMOUNT              IN FI_LOAN_MASTER.REPAY_ONE_AMOUNT%TYPE
            , P_REPAY_ONE_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_ONE_CURR_AMOUNT%TYPE
            , P_REPAY_SUM_AMOUNT              IN FI_LOAN_MASTER.REPAY_SUM_AMOUNT%TYPE
            , P_REPAY_SUM_CURR_AMOUNT         IN FI_LOAN_MASTER.REPAY_SUM_CURR_AMOUNT%TYPE
            , P_REPAY_LAST_DATE               IN FI_LOAN_MASTER.REPAY_LAST_DATE%TYPE
            , P_REPAY_INTER_COUNT             IN FI_LOAN_MASTER.REPAY_INTER_COUNT%TYPE
            , P_REPAY_INTER_SUM_AMOUNT        IN FI_LOAN_MASTER.REPAY_INTER_SUM_AMOUNT%TYPE
            , P_REPAY_INTER_SUM_CURR_AMOUNT   IN FI_LOAN_MASTER.REPAY_INTER_SUM_CURR_AMOUNT%TYPE
            , P_COST_CENTER_ID                IN FI_LOAN_MASTER.COST_CENTER_ID%TYPE
            , P_REMARK                        IN FI_LOAN_MASTER.REMARK%TYPE
            , P_MORTGAGE_REMARK               IN FI_LOAN_MASTER.MORTGAGE_REMARK%TYPE
            , P_USER_ID                       IN FI_LOAN_MASTER.LAST_UPDATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE FI_LOAN_MASTER LM
      SET   LM.LOAN_DESC                      = P_LOAN_DESC
          , LM.LOAN_KIND                      = P_LOAN_KIND
          , LM.LOAN_TYPE                      = P_LOAN_TYPE
          , LM.LOAN_USE                       = P_LOAN_USE
          , LM.L_ISSUE_DATE                   = P_L_ISSUE_DATE
          , LM.L_DUE_DATE                     = P_L_DUE_DATE
          , LM.L_CURRENCY_CODE                = P_L_CURRENCY_CODE
          , LM.L_EXCHANGE_RATE                = P_L_EXCHANGE_RATE
          , LM.LIMIT_CURR_AMOUNT              = P_LIMIT_CURR_AMOUNT
          , LM.LIMIT_AMOUNT                   = P_LIMIT_AMOUNT
          , LM.ISSUE_DATE                     = P_ISSUE_DATE
          , LM.DUE_DATE                       = P_DUE_DATE
          , LM.CURRENCY_CODE                  = P_CURRENCY_CODE
          , LM.EXCHANGE_RATE                  = P_EXCHANGE_RATE
          , LM.LOAN_CURR_AMOUNT               = P_LOAN_CURR_AMOUNT
          , LM.LOAN_AMOUNT                    = P_LOAN_AMOUNT          
          , LM.LOAN_ADD_AMOUNT                = P_LOAN_ADD_AMOUNT
          , LM.LOAN_ADD_CURR_AMOUNT           = P_LOAN_ADD_CURR_AMOUNT
          , LM.LOAN_ACCOUNT_CONTROL_ID        = P_LOAN_ACCOUNT_CONTROL_ID
          , LM.LOAN_BANK_ID                   = P_LOAN_BANK_ID
          , LM.LOAN_BANK_ACCOUNT_ID           = P_LOAN_BANK_ACCOUNT_ID
          , LM.ENSURE_TYPE                    = P_ENSURE_TYPE
          , LM.REPAY_CONDITION                = P_REPAY_CONDITION
          , LM.TERM_YEAR                      = P_TERM_YEAR
          , LM.TERM_MONTH                     = P_TERM_MONTH
          , LM.REPAY_CYCLE_MONTH              = P_REPAY_CYCLE_MONTH
          , LM.START_REPAY_DATE               = P_START_REPAY_DATE
          , LM.INTER_RATE                     = P_INTER_RATE
          , LM.SPREAD_RATE                    = P_SPREAD_RATE
          , LM.INTER_TYPE                     = P_INTER_TYPE
          , LM.INTER_PAYMENT_TYPE             = P_INTER_PAYMENT_TYPE
          , LM.START_INTER_DATE               = P_START_INTER_DATE
          , LM.INTER_PAYMENT_CYCLE            = P_INTER_PAYMENT_CYCLE
          , LM.ADVANCE_INTER                  = P_ADVANCE_INTER
          , LM.ADVANCE_CURR_INTER             = P_ADVANCE_CURR_INTER
          , LM.INTER_ACCOUNT_CONTROL_ID       = P_INTER_ACCOUNT_CONTROL_ID
          , LM.COMMI_AMOUNT                   = P_COMMI_AMOUNT
          , LM.COMMI_CURR_AMOUNT              = P_COMMI_CURR_AMOUNT
          , LM.COMMI_ACCOUNT_CONTROL_ID       = P_COMMI_ACCOUNT_CONTROL_ID
          , LM.REPAY_COUNT                    = P_REPAY_COUNT
          , LM.REPAY_ONE_AMOUNT               = P_REPAY_ONE_AMOUNT
          , LM.REPAY_ONE_CURR_AMOUNT          = P_REPAY_ONE_CURR_AMOUNT
          , LM.REPAY_SUM_AMOUNT               = P_REPAY_SUM_AMOUNT
          , LM.REPAY_SUM_CURR_AMOUNT          = P_REPAY_SUM_CURR_AMOUNT
          , LM.REPAY_LAST_DATE                = P_REPAY_LAST_DATE
          , LM.REPAY_INTER_COUNT              = P_REPAY_INTER_COUNT
          , LM.REPAY_INTER_SUM_AMOUNT         = P_REPAY_INTER_SUM_AMOUNT
          , LM.REPAY_INTER_SUM_CURR_AMOUNT    = P_REPAY_INTER_SUM_CURR_AMOUNT
          , LM.COST_CENTER_ID                 = P_COST_CENTER_ID
          , LM.REMARK                         = P_REMARK
          , LM.MORTGAGE_REMARK                = P_MORTGAGE_REMARK
          , LM.LAST_UPDATE_DATE               = GET_LOCAL_DATE(LM.SOB_ID)
          , LM.LAST_UPDATED_BY                = P_USER_ID
     WHERE LM.LOAN_NUM                = W_LOAN_NUM
       AND LM.SOB_ID                  = W_SOB_ID
    ;

  END LOAN_MASTER_UPDATE;

-- 차입금 원장 수정 - 차입액/상환액 적용.
  PROCEDURE LOAN_MASTER_UPDATE_AMOUNT
            ( P_GB                            IN VARCHAR2            
            , P_LOAN_NUM                      IN FI_LOAN_MASTER.LOAN_NUM%TYPE
            , P_SOB_ID                        IN FI_LOAN_MASTER.SOB_ID%TYPE
            , P_ORG_ID                        IN FI_LOAN_MASTER.ORG_ID%TYPE
            , P_GL_DATE                       IN FI_SLIP_LINE.GL_DATE%TYPE
            , P_ACCOUNT_DR_CR                 IN FI_SLIP_LINE.ACCOUNT_DR_CR%TYPE
            , P_GL_CURRENCY_AMOUNT            IN FI_SLIP_LINE.GL_CURRENCY_AMOUNT%TYPE
            , P_GL_AMOUNT                     IN FI_SLIP_LINE.GL_AMOUNT%TYPE            
            , P_USER_ID                       IN FI_LOAN_MASTER.LAST_UPDATED_BY%TYPE
            )
  AS
    V_LOAN_KIND                               VARCHAR2(10);
    
  BEGIN
    BEGIN
      SELECT LM.LOAN_KIND
        INTO V_LOAN_KIND
        FROM FI_LOAN_MASTER LM
      WHERE LM.LOAN_NUM         = P_LOAN_NUM  
        AND LM.SOB_ID           = P_SOB_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10193', NULL));
      RETURN;
    END;
    
    IF V_LOAN_KIND IN('2', '3') AND P_GB = 'I' THEN
      UPDATE FI_LOAN_MASTER LM
        SET LM.LOAN_CURR_AMOUNT         = NVL(LM.LOAN_CURR_AMOUNT, 0) + (NVL(P_GL_CURRENCY_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', -1, 1))
          , LM.LOAN_AMOUNT              = NVL(LM.LOAN_AMOUNT, 0) + (NVL(P_GL_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', -1, 1))
          , LM.LAST_UPDATE_DATE         = GET_LOCAL_DATE(LM.SOB_ID)
          , LM.LAST_UPDATED_BY          = P_USER_ID
       WHERE LM.LOAN_NUM                = P_LOAN_NUM
         AND LM.SOB_ID                  = P_SOB_ID
      ;
    ELSIF V_LOAN_KIND IN('2', '3') AND P_GB = 'D' THEN
      UPDATE FI_LOAN_MASTER LM
        SET LM.LOAN_CURR_AMOUNT         = NVL(LM.LOAN_CURR_AMOUNT, 0) - (NVL(P_GL_CURRENCY_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', -1, 1))
          , LM.LOAN_AMOUNT              = NVL(LM.LOAN_AMOUNT, 0) - (NVL(P_GL_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', -1, 1))
          , LM.LAST_UPDATE_DATE         = GET_LOCAL_DATE(LM.SOB_ID)
          , LM.LAST_UPDATED_BY          = P_USER_ID
       WHERE LM.LOAN_NUM                = P_LOAN_NUM
         AND LM.SOB_ID                  = P_SOB_ID
      ;
    ELSE
      IF P_GB = 'I' THEN
        UPDATE FI_LOAN_MASTER LM
          SET LM.REPAY_COUNT              = ABS(NVL(LM.REPAY_COUNT, 0) + (1 * DECODE(P_ACCOUNT_DR_CR, '1', 1, 0)))
            , LM.REPAY_ONE_AMOUNT         = DECODE(P_ACCOUNT_DR_CR, '1', NVL(P_GL_AMOUNT, 0), 0)
            , LM.REPAY_ONE_CURR_AMOUNT    = DECODE(P_ACCOUNT_DR_CR, '1', NVL(P_GL_CURRENCY_AMOUNT, 0), 0)
            , LM.REPAY_SUM_AMOUNT         = ABS(NVL(LM.REPAY_SUM_AMOUNT, 0) + (NVL(P_GL_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', 1, 0)))
            , LM.REPAY_SUM_CURR_AMOUNT    = ABS(NVL(LM.REPAY_SUM_CURR_AMOUNT, 0) + (NVL(P_GL_CURRENCY_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', 1, 0)))
            , LM.REPAY_LAST_DATE          = P_GL_DATE
            , LM.LAST_UPDATED_BY          = P_USER_ID
         WHERE LM.LOAN_NUM                = P_LOAN_NUM
           AND LM.SOB_ID                  = P_SOB_ID
        ;
      ELSE
        UPDATE FI_LOAN_MASTER LM
          SET LM.REPAY_COUNT              = ABS(NVL(LM.REPAY_COUNT, 0) - (1 * DECODE(P_ACCOUNT_DR_CR, '1', 1, 0)))
            , LM.REPAY_ONE_AMOUNT         = DECODE(P_ACCOUNT_DR_CR, '1', NVL(P_GL_AMOUNT, 0), 0)
            , LM.REPAY_ONE_CURR_AMOUNT    = DECODE(P_ACCOUNT_DR_CR, '1', NVL(P_GL_CURRENCY_AMOUNT, 0), 0)
            , LM.REPAY_SUM_AMOUNT         = ABS(NVL(LM.REPAY_SUM_AMOUNT, 0) - (NVL(P_GL_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', 1, 0)))
            , LM.REPAY_SUM_CURR_AMOUNT    = ABS(NVL(LM.REPAY_SUM_CURR_AMOUNT, 0) - (NVL(P_GL_CURRENCY_AMOUNT, 0) * DECODE(P_ACCOUNT_DR_CR, '1', 1, 0)))
            , LM.REPAY_LAST_DATE          = P_GL_DATE
            , LM.LAST_UPDATED_BY          = P_USER_ID
         WHERE LM.LOAN_NUM                = P_LOAN_NUM
           AND LM.SOB_ID                  = P_SOB_ID
        ;
      END IF;
    END IF;
    
  END LOAN_MASTER_UPDATE_AMOUNT;
  

-- 차입금 번호 lookup.
  PROCEDURE LU_LOAN_NUM
            ( P_CURSOR3                   OUT TYPES.TCURSOR3            
            , W_SOB_ID                    IN NUMBER
            )
  AS
  BEGIN  
    OPEN P_CURSOR3 FOR
      SELECT LM.LOAN_NUM
          , LM.LOAN_DESC
          , CASE
                WHEN LM.LOAN_KIND IN('2', '3') THEN TO_CHAR(LM.LIMIT_AMOUNT, 'FM999,999,999,999,999')
                ELSE TO_CHAR(LM.LOAN_AMOUNT, 'FM999,999,999,999,999')
             END AS LOAN_AMOUNT
          , CASE
                WHEN LM.LOAN_KIND IN('2', '3') THEN TO_CHAR(LM.L_ISSUE_DATE, 'YYYY-MM-DD') || '~' || TO_CHAR(LM.L_DUE_DATE, 'YYYY-MM-DD')
                ELSE TO_CHAR(LM.ISSUE_DATE, 'YYYY-MM-DD') || '~' || TO_CHAR(LM.DUE_DATE, 'YYYY-MM-DD')
             END AS LOAN_PERIOD
        FROM FI_LOAN_MASTER LM
      WHERE LM.SOB_ID              = W_SOB_ID
        AND CASE
              WHEN LM.LOAN_KIND IN('2', '3') THEN NVL(LM.LIMIT_AMOUNT, 0) - NVL(LM.LOAN_AMOUNT, 0)
              ELSE NVL(LM.LOAN_AMOUNT, 0) - NVL(LM.REPAY_SUM_AMOUNT, 0)
            END  > 0
      ORDER BY LM.LOAN_NUM
      ;
  
  END LU_LOAN_NUM;
  
END FI_LOAN_MASTER_G;
/
