CREATE OR REPLACE PACKAGE HRW_OFFICE_TAX_SET_G
AS

-- 지방소득세(종업원할 사업소세)신고서 작성 메인.
  PROCEDURE MAIN_OFFICE_TAX
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 총급여액 계산.
  PROCEDURE SET_PAYMENT_AMT_F
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_OFFICE_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 과세 제외급여 계산.
  FUNCTION GET_TAX_FREE_AMT_F
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_OFFICE_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            ) RETURN NUMBER;

-- 산출세액 계산.
  FUNCTION COMP_TAX_AMT_F
            ( P_PAYMENT_TAX_AMT       IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            ) RETURN NUMBER;

-- 산출세액 리턴.
  PROCEDURE COMP_TAX_AMT_P
            ( P_PAYMENT_TAX_AMT       IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , O_TAX_AMT               OUT NUMBER
            );
            
            
-- 퇴직소득 계산.
  PROCEDURE SET_A20
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 사업소득 계산.
  PROCEDURE SET_A25
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 지방소득세(종업원할 사업소세)신고서 마감 여부.
  FUNCTION CLOSED_OFFICE_TAX_YN
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            ) RETURN VARCHAR2;

-- 지방소득세(종업원할 사업소세)신고서 마감.
  PROCEDURE CLOSED_OFFICE_TAX
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            );

-- 원천징수 영수증 마감 취소.
  PROCEDURE CLOSED_CANCEL_OFFICE_TAX
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            );

END HRW_OFFICE_TAX_SET_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_OFFICE_TAX_SET_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_OFFICE_TAX_SET_G
/* DESCRIPTION  : 지방소득세(종업원할 사업소세)신고서 집계 및 마감 관리
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 지방소득세(종업원할 사업소세)신고서 작성 메인.
  PROCEDURE MAIN_OFFICE_TAX
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CORP_ID                 NUMBER;
    V_STD_YYYYMM              VARCHAR2(8);
    V_PAY_YYYYMM              VARCHAR2(8);

    V_PAYMENT_TAX_AMT         NUMBER := 0;  -- 과세 급여금액.
    V_TAX_FREE_AMT            NUMBER := 0;  -- 비과세금액.
    V_COMP_TAX_AMT            NUMBER := 0;  -- 산출세액.    
  BEGIN
    O_STATUS := 'F';
    -- 마감 여부 체크.
    IF CLOSED_OFFICE_TAX_YN(P_OFFICE_TAX_ID) = 'Y' THEN
      -- 이미 마감처리됨.
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10052');
      RETURN;
    END IF;

    BEGIN
      SELECT TD.CORP_ID
          , TD.STD_YYYYMM
          , TD.PAY_YYYYMM
        INTO V_CORP_ID
          , V_STD_YYYYMM
          , V_PAY_YYYYMM
        FROM HRW_OFFICE_TAX_DOC TD
      WHERE TD.OFFICE_TAX_ID      = P_OFFICE_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10239');
      RETURN;
    END;
    
    -- 초기화.
    UPDATE HRW_OFFICE_TAX_DOC
      SET REGULAR_WORKER_COUNT    = 0
        , DAY_WORKER_COUNT        = 0
        , TOTAL_PAYMENT_AMT       = 0
        , TAX_FREE_AMT            = 0
        , PAYMENT_TAX_AMT         = 0
        , COMP_TAX_AMT            = 0
        , TOTAL_TAX_AMT           = 0
        , LAST_UPDATE_DATE        = V_SYSDATE
        , LAST_UPDATED_BY         = P_USER_ID
    WHERE OFFICE_TAX_ID           = P_OFFICE_TAX_ID;
    
    -- 총급여 산출.
    SET_PAYMENT_AMT_F
      ( P_OFFICE_TAX_ID         => P_OFFICE_TAX_ID
      , P_CORP_ID               => V_CORP_ID
      , P_STD_YYYYMM            => V_STD_YYYYMM
      , P_PAY_YYYYMM            => V_PAY_YYYYMM
      , P_SOB_ID                => P_SOB_ID
      , P_ORG_ID                => P_ORG_ID
      , O_STATUS                => O_STATUS
      , O_MESSAGE               => O_MESSAGE
      );
    IF O_STATUS = 'F' THEN
      RETURN;
    END IF;
    
    -- 비과세 금액.
    V_TAX_FREE_AMT := GET_TAX_FREE_AMT_F
                        ( P_OFFICE_TAX_ID         => P_OFFICE_TAX_ID
                        , P_CORP_ID               => V_CORP_ID
                        , P_STD_YYYYMM            => V_STD_YYYYMM
                        , P_PAY_YYYYMM            => V_PAY_YYYYMM
                        , P_SOB_ID                => P_SOB_ID
                        , P_ORG_ID                => P_ORG_ID
                        );
    
    -- 과세 금액 산출.
    BEGIN
      SELECT TD.TOTAL_PAYMENT_AMT
        INTO V_PAYMENT_TAX_AMT
        FROM HRW_OFFICE_TAX_DOC TD
      WHERE TD.OFFICE_TAX_ID      = P_OFFICE_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PAYMENT_TAX_AMT := 0;
    END;
    
    V_PAYMENT_TAX_AMT := NVL(V_PAYMENT_TAX_AMT, 0) - NVL(V_TAX_FREE_AMT, 0);
    
    V_COMP_TAX_AMT := COMP_TAX_AMT_F
                        ( P_PAYMENT_TAX_AMT       => V_PAYMENT_TAX_AMT
                        , P_SOB_ID                => P_SOB_ID
                        , P_ORG_ID                => P_ORG_ID
                        );
    
    -- UPDATE.
    UPDATE HRW_OFFICE_TAX_DOC TD
      SET TD.TAX_FREE_AMT         = NVL(V_TAX_FREE_AMT, 0)
        , TD.PAYMENT_TAX_AMT      = NVL(V_PAYMENT_TAX_AMT, 0)
        , TD.COMP_TAX_AMT         = NVL(V_COMP_TAX_AMT, 0)
        , TD.TOTAL_TAX_AMT        = NVL(TD.TAX_ADDITION_AMT, 0) + NVL(V_COMP_TAX_AMT, 0)
    WHERE TD.OFFICE_TAX_ID        = P_OFFICE_TAX_ID
    ;
    
    O_STATUS := 'S';
  END MAIN_OFFICE_TAX;

-- 총급여액 계산.
  PROCEDURE SET_PAYMENT_AMT_F
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_OFFICE_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_REGULAR_WORKER_COUNT    NUMBER := 0;  -- 상용직 인원수.
    V_DAY_WORKER_COUNT        NUMBER := 0;  -- 일용직 인원수.
    V_TOTAL_PAYMENT_AMT       NUMBER := 0;  -- 총지급액.
  BEGIN
    O_STATUS := 'F';
    -- 급여 내역 산출.
    BEGIN
      SELECT COUNT(DISTINCT MP.PERSON_ID) AS PERSON_COUNT
           , SUM(HMA.ALLOWANCE_AMOUNT) AS ALLOWANCE_AMOUNT  -- 총지급액.
        INTO V_REGULAR_WORKER_COUNT
           , V_TOTAL_PAYMENT_AMT
        FROM HRM_PERSON_MASTER PM
          , HRP_MONTH_PAYMENT MP
          , ( SELECT MA.MONTH_PAYMENT_ID
                  , SUM(MA.ALLOWANCE_AMOUNT)  AS ALLOWANCE_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
              WHERE MA.PAY_YYYYMM       = P_STD_YYYYMM  -- 귀속년월.
                AND MA.CORP_ID          = P_CORP_ID
                AND MA.SOB_ID           = P_SOB_ID
                AND MA.ORG_ID           = P_ORG_ID
              GROUP BY MA.MONTH_PAYMENT_ID
             ) HMA
      WHERE PM.PERSON_ID                = MP.PERSON_ID
        AND MP.MONTH_PAYMENT_ID         = HMA.MONTH_PAYMENT_ID(+)
        AND MP.PAY_YYYYMM               = P_STD_YYYYMM  -- 귀속년월.
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM')  = P_PAY_YYYYMM  -- 지급년월.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_REGULAR_WORKER_COUNT  := 0;
      V_TOTAL_PAYMENT_AMT     := 0;
    END;
    BEGIN
      UPDATE HRW_OFFICE_TAX_DOC TD
        SET TD.REGULAR_WORKER_COUNT = NVL(V_REGULAR_WORKER_COUNT, 0)
          , TD.TOTAL_PAYMENT_AMT    = NVL(V_TOTAL_PAYMENT_AMT, 0)
      WHERE TD.OFFICE_TAX_ID        = P_OFFICE_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
      RETURN;
    END; 
    O_STATUS := 'S';
  END SET_PAYMENT_AMT_F;

-- 과세 제외급여 계산.
  FUNCTION GET_TAX_FREE_AMT_F
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_OFFICE_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_OFFICE_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_OFFICE_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_TAX_FREE_AMT                    NUMBER := 0;
    
    -- 비과세 한도 및 기준--
    V_STD_PAYMENT_AMT                 NUMBER := 0;
    V_STD_OT                          NUMBER := 0;
    V_STD_OUTSIDE                     NUMBER := 0;
    V_STD_CAR                         NUMBER := 0;
    V_STD_BABY                        NUMBER := 0;
  BEGIN
    BEGIN
      SELECT ITS.MONTH_PAY_STD
          , ITS.OT_DED_LMT
          , ITS.FOREIGN_INCOME_DED_AMT
          , ITS.DRIVE_DED_LMT
          , ITS.BABY_DED_LMT
        INTO V_STD_PAYMENT_AMT
          , V_STD_OT
          , V_STD_OUTSIDE
          , V_STD_CAR
          , V_STD_BABY
        FROM HRA_INCOME_TAX_STANDARD ITS
      WHERE ITS.YEAR_YYYY         = SUBSTR(P_STD_YYYYMM, 1, 4)
        AND ITS.SOB_ID            = P_SOB_ID
        AND ITS.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_STD_PAYMENT_AMT := 1000000;
      V_STD_OT          := 200000;
      V_STD_OUTSIDE     := 1000000;
      V_STD_CAR         := 200000;
      V_STD_BABY        := 100000;
    END;
    
    BEGIN
      SELECT SUM(CASE
                  WHEN NVL(SX1.PAYMENT_AMOUNT, 0) > V_STD_PAYMENT_AMT THEN 0
                  ELSE CASE
                         WHEN NVL(SX1.TAX_FREE_OT, 0) > V_STD_OT THEN V_STD_OT
                         ELSE NVL(SX1.TAX_FREE_OT, 0)
                       END
                END +  -- TAX_FREE_OT
                CASE
                  WHEN NVL(SX1.TAX_FREE_OUTSIDE, 0) > V_STD_OUTSIDE THEN V_STD_OUTSIDE
                  ELSE NVL(SX1.TAX_FREE_OUTSIDE, 0)
                END +  -- TAX_FREE_OUTSIDE
                CASE
                  WHEN NVL(SX1.TAX_FREE_CAR, 0) > V_STD_CAR THEN V_STD_CAR
                  ELSE NVL(SX1.TAX_FREE_CAR, 0)
                END +  -- AS TAX_FREE_CAR
                CASE
                  WHEN NVL(SX1.TAX_FREE_BABY, 0) > V_STD_BABY THEN V_STD_BABY
                  ELSE NVL(SX1.TAX_FREE_BABY, 0)
                END) AS TAX_FREE_AMT  --TAX_FREE_BABY
        INTO V_TAX_FREE_AMT
        FROM (SELECT MA.CORP_ID 
                  , MA.PERSON_ID
                  , SUM(MA.ALLOWANCE_AMOUNT)  AS PAYMENT_AMOUNT
                  , SUM(CASE
                          WHEN MP.PAY_TYPE IN('2', '4') AND HA.TAX_FREE = 'OT' THEN MA.ALLOWANCE_AMOUNT
                          ELSE 0
                        END) AS TAX_FREE_OT
                  , SUM(DECODE(HA.TAX_FREE, 'OUTSIDE', MA.ALLOWANCE_AMOUNT)) AS TAX_FREE_OUTSIDE
                  , SUM(DECODE(HA.TAX_FREE, 'CAR', MA.ALLOWANCE_AMOUNT)) AS TAX_FREE_CAR
                  , SUM(DECODE(HA.TAX_FREE, 'BABY', MA.ALLOWANCE_AMOUNT)) AS TAX_FREE_BABY
                FROM HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_ALLOWANCE MA 
                  , HRM_ALLOWANCE_V HA
              WHERE MP.MONTH_PAYMENT_ID = MA.MONTH_PAYMENT_ID
                AND MA.ALLOWANCE_ID     = HA.ALLOWANCE_ID
                AND MA.PAY_YYYYMM       = P_STD_YYYYMM  -- 귀속년월.
                AND MA.WAGE_TYPE        = 'P1'
                AND MA.CORP_ID          = P_CORP_ID
                AND MA.SOB_ID           = P_SOB_ID
                AND MA.ORG_ID           = P_ORG_ID
              GROUP BY MA.CORP_ID 
                  , MA.PERSON_ID
                  , MA.MONTH_PAYMENT_ID
                  , MA.PERSON_ID
             ) SX1
      GROUP BY SX1.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TAX_FREE_AMT := 0;
    END;
    RETURN V_TAX_FREE_AMT;
  END GET_TAX_FREE_AMT_F;

-- 산출세액 계산.
  FUNCTION COMP_TAX_AMT_F
            ( P_PAYMENT_TAX_AMT       IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_TAX_RATE                     NUMBER;
    V_TAX_AMOUNT                   NUMBER := 0;
  BEGIN
    BEGIN
      V_TAX_RATE := TAX_RATE_F('OFFICE_TAX', P_SOB_ID, P_ORG_ID);
    EXCEPTION WHEN OTHERS THEN
      V_TAX_RATE := 0.5;
    END;
    
    BEGIN
      V_TAX_AMOUNT := TRUNC(NVL(P_PAYMENT_TAX_AMT, 0) * (V_TAX_RATE / 100), -1);
    EXCEPTION WHEN OTHERS THEN
      V_TAX_AMOUNT      := 0;
    END;
    RETURN V_TAX_AMOUNT;
  END COMP_TAX_AMT_F;

-- 산출세액 리턴.
  PROCEDURE COMP_TAX_AMT_P
            ( P_PAYMENT_TAX_AMT       IN HRW_OFFICE_TAX_DOC.PAYMENT_TAX_AMT%TYPE
            , P_SOB_ID                IN HRW_OFFICE_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_OFFICE_TAX_DOC.ORG_ID%TYPE
            , O_TAX_AMT               OUT NUMBER
            )
  AS
  BEGIN
    O_TAX_AMT := COMP_TAX_AMT_F
                   ( P_PAYMENT_TAX_AMT => P_PAYMENT_TAX_AMT
                   , P_SOB_ID          => P_SOB_ID
                   , P_ORG_ID          => P_ORG_ID
                   );
  END COMP_TAX_AMT_P;
  
  
-- 퇴직소득 계산.
  PROCEDURE SET_A20
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(RA.PERSON_ID) AS PERSON_COUNT
           , SUM(RA.RETIRE_TOTAL_AMOUNT) AS RETIRE_TOTAL_AMOUNT
           , SUM(TRUNC(RA.INCOME_TAX_AMOUNT, -1)) AS INCOME_TAX_AMOUNT
        INTO V_PERSON_COUNT
           , V_PAYMENT_AMOUNT
           , V_INCOME_TAX_AMOUNT
        FROM HRR_RETIRE_ADJUSTMENT RA
      WHERE RA.CORP_ID                  = P_CORP_ID
        AND RA.SOB_ID                   = P_SOB_ID
        AND RA.ORG_ID                   = P_ORG_ID
        AND TO_CHAR(RA.CLOSED_DATE, 'YYYY-MM')    = P_STD_YYYYMM  -- 지급연월 기준.
        AND TO_CHAR(RA.CLOSED_DATE, 'YYYY-MM')    = P_PAY_YYYYMM  -- 귀속연월 기준.
        AND RA.CLOSED_YN                = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;

    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A20_PERSON_CNT      = NVL(V_PERSON_COUNT, 0)
          , WD.A20_PAYMENT_AMT     = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A20_INCOME_TAX_AMT  = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID  = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A20;

-- 사업소득 계산.
  PROCEDURE SET_A25
            ( P_WITHHOLDING_DOC_ID    IN HRW_WITHHOLDING_DOC.WITHHOLDING_DOC_ID%TYPE
            , P_CORP_ID               IN HRW_WITHHOLDING_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_WITHHOLDING_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_WITHHOLDING_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_WITHHOLDING_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_WITHHOLDING_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_PAYMENT_AMOUNT                  NUMBER := 0;
    V_INCOME_TAX_AMOUNT               NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(IRB.EARNER_ID) AS PERSON_COUNT
           , SUM(IRB.PAYMENT_AMOUNT) AS RETIRE_TOTAL_AMOUNT
           , SUM(IRB.INCOME_TAX_AMT) AS INCOME_TAX_AMOUNT
        INTO V_PERSON_COUNT
           , V_PAYMENT_AMOUNT
           , V_INCOME_TAX_AMOUNT
        FROM HRW_INCOME_RESIDENT_BSN IRB
      WHERE IRB.CORP_ID                 = P_CORP_ID
        AND IRB.SOB_ID                  = P_SOB_ID
        AND IRB.ORG_ID                  = P_ORG_ID
        AND TO_CHAR(IRB.PAY_DATE, 'YYYY-MM')     = P_STD_YYYYMM     -- 귀속연월.
        AND TO_CHAR(IRB.RECEIPT_DATE, 'YYYY-MM') = P_PAY_YYYYMM  -- 지급연월.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_PAYMENT_AMOUNT    := 0;
      V_INCOME_TAX_AMOUNT := 0;
    END;

    BEGIN
      UPDATE HRW_WITHHOLDING_DOC WD
        SET WD.A25_PERSON_CNT        = NVL(V_PERSON_COUNT, 0)
          , WD.A25_PAYMENT_AMT       = NVL(V_PAYMENT_AMOUNT, 0)
          , WD.A25_INCOME_TAX_AMT    = NVL(V_INCOME_TAX_AMOUNT, 0)
      WHERE WD.WITHHOLDING_DOC_ID    = P_WITHHOLDING_DOC_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A25;

-- 지방소득세(종업원할 사업소세)신고서 마감 여부.
  FUNCTION CLOSED_OFFICE_TAX_YN
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_COUNT                     NUMBER := 0;
  BEGIN
    -- 마감 여부 체크.
    BEGIN
      SELECT SUM(DECODE(TD.CLOSED_YN, 'Y', 1, 0)) AS CLOSED_COUNT
        INTO V_COUNT
        FROM HRW_OFFICE_TAX_DOC TD
      WHERE TD.OFFICE_TAX_ID      = P_OFFICE_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_COUNT := 0;
    END;
    IF V_COUNT > 0 THEN
      RETURN 'Y';
    END IF;
    RETURN 'N';
  END CLOSED_OFFICE_TAX_YN;

-- 지방소득세(종업원할 사업소세)신고서 마감.
  PROCEDURE CLOSED_OFFICE_TAX
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            )
  AS
  BEGIN
    UPDATE HRW_OFFICE_TAX_DOC TD
      SET TD.CLOSED_YN            = 'Y'
        , TD.CLOSED_DATE          = GET_LOCAL_DATE(P_SOB_ID)
        , TD.CLOSED_PERSON_ID     = P_CONNECT_PERSON_ID
    WHERE TD.OFFICE_TAX_ID        = P_OFFICE_TAX_ID
    ;
  END CLOSED_OFFICE_TAX;

-- 원천징수 영수증 마감 취소.
  PROCEDURE CLOSED_CANCEL_OFFICE_TAX
            ( P_OFFICE_TAX_ID         IN HRW_OFFICE_TAX_DOC.OFFICE_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            )
  AS
  BEGIN
    UPDATE HRW_OFFICE_TAX_DOC TD
      SET TD.CLOSED_YN            = 'N'
        , TD.CLOSED_DATE          = GET_LOCAL_DATE(P_SOB_ID)
        , TD.CLOSED_PERSON_ID     = P_CONNECT_PERSON_ID
    WHERE TD.OFFICE_TAX_ID        = P_OFFICE_TAX_ID
    ;
  END CLOSED_CANCEL_OFFICE_TAX;

END HRW_OFFICE_TAX_SET_G;
/
