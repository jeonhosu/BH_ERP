CREATE OR REPLACE PACKAGE HRW_LOCAL_TAX_SET_G
AS

-- 주민세특별징수명세/납입서 작성 메인.
  PROCEDURE MAIN_LOCAL_TAX
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SET_TYPE              IN VARCHAR2
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 계속근로자 간이세액 계산.
  PROCEDURE SET_A04_1
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 중도퇴사 계산.
  PROCEDURE SET_A04_2
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 연말정산 계산.
  PROCEDURE SET_A04_3
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 퇴직소득 계산.
  PROCEDURE SET_A07
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 사업소득 계산.
  PROCEDURE SET_A03
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

-- 주민세특별징수명세/납입서 마감 여부.
  FUNCTION CLOSED_LOCAL_TAX_YN
            ( P_LOCAL_TAX_ID      IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            ) RETURN VARCHAR2;

-- 주민세특별징수명세/납입서  마감.
  PROCEDURE CLOSED_LOCAL_TAX
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            );

-- 주민세특별징수명세/납입서  마감 취소.
  PROCEDURE CLOSED_CANCEL_LOCAL_TAX
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            );

END HRW_LOCAL_TAX_SET_G;
/
CREATE OR REPLACE PACKAGE BODY HRW_LOCAL_TAX_SET_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRW_LOCAL_TAX_SET_G
/* DESCRIPTION  : 주민세특별징수명세/납입서 집계 및 마감 관리
/* REFERENCE BY :
/* PROGRAM HISTORY :
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 주민세특별징수명세/납입서 작성 메인.
  PROCEDURE MAIN_LOCAL_TAX
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_SET_TYPE              IN VARCHAR2
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE                 DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CORP_ID                 NUMBER;
    V_STD_YYYYMM              VARCHAR2(8);
    V_PAY_YYYYMM              VARCHAR2(8);

    V_K10_TAX_AMT             NUMBER := 0;  -- 계속근로자 전월미환급세액.
    V_R10_TAX_AMT             NUMBER := 0;  -- 중도퇴사자 전월미환급세액.
  BEGIN
    O_STATUS := 'F';
    -- 마감 여부 체크.
    IF CLOSED_LOCAL_TAX_YN(P_LOCAL_TAX_ID) = 'Y' THEN
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
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE TD.LOCAL_TAX_ID       = P_LOCAL_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10239');
      RETURN;
    END;

    -- 계속 근로자 전월미환급 세액 적용.
    BEGIN
      SELECT NVL(TD.K40_TAX_AMT, 0) AS K40_TAX_AMT
          , NVL(TD.R40_TAX_AMT, 0) AS R40_TAX_AMT
        INTO V_K10_TAX_AMT
          , V_R10_TAX_AMT
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE EXISTS
              ( SELECT 'X'
                  FROM HRW_LOCAL_TAX_DOC LTD
                WHERE LTD.PRE_LOCAL_TAX_NO    = TD.LOCAL_TAX_NO
                  AND LTD.CORP_ID             = TD.CORP_ID
                  AND LTD.SOB_ID              = TD.SOB_ID
                  AND LTD.ORG_ID              = TD.ORG_ID
                  AND LTD.LOCAL_TAX_ID        = P_LOCAL_TAX_ID
              )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_K10_TAX_AMT := 0;
      V_R10_TAX_AMT := 0;
    END;

    -- 주민세특별징수명세/납입서 데이터 초기화.
    UPDATE HRW_LOCAL_TAX_DOC 
      SET A01_PERSON_CNT            = 0
        , A01_STD_TAX_AMT           = 0
        , A01_LOCAL_TAX_AMT         = 0
        , A02_PERSON_CNT            = 0
        , A02_STD_TAX_AMT           = 0
        , A02_LOCAL_TAX_AMT         = 0
        , A03_PERSON_CNT            = 0
        , A03_STD_TAX_AMT           = 0
        , A03_LOCAL_TAX_AMT         = 0
        , A04_PERSON_CNT            = 0
        , A04_STD_TAX_AMT           = 0
        , A04_LOCAL_TAX_AMT         = 0
        , A05_PERSON_CNT            = 0
        , A05_STD_TAX_AMT           = 0
        , A05_LOCAL_TAX_AMT         = 0
        , A06_PERSON_CNT            = 0
        , A06_STD_TAX_AMT           = 0
        , A06_LOCAL_TAX_AMT         = 0
        , A07_PERSON_CNT            = 0
        , A07_STD_TAX_AMT           = 0
        , A07_LOCAL_TAX_AMT         = 0
        , A08_PERSON_CNT            = 0
        , A08_STD_TAX_AMT           = 0
        , A08_LOCAL_TAX_AMT         = 0
        , A09_PERSON_CNT            = 0
        , A09_STD_TAX_AMT           = 0
        , A09_LOCAL_TAX_AMT         = 0
        , A10_PERSON_CNT            = 0
        , A10_STD_TAX_AMT           = 0
        , A10_LOCAL_TAX_AMT         = 0
        , A90_PERSON_CNT            = 0
        , A90_STD_TAX_AMT           = 0
        , A90_LOCAL_TAX_AMT         = 0
        , TOTAL_ADJUST_TAX_AMT      = 0
        , PAY_LOCAL_TAX_AMT         = 0
        , K10_TAX_AMT               = NVL(V_K10_TAX_AMT, 0)
        , K20_TAX_AMT               = 0
        , K30_TAX_AMT               = 0
        , K40_TAX_AMT               = NVL(V_K10_TAX_AMT, 0)
        , R10_TAX_AMT               = NVL(V_R10_TAX_AMT, 0)
        , R20_TAX_AMT               = 0
        , R30_TAX_AMT               = 0
        , R40_TAX_AMT               = NVL(V_R10_TAX_AMT, 0)
        , LAST_UPDATE_DATE           = V_SYSDATE
        , LAST_UPDATED_BY            = P_USER_ID
    WHERE LOCAL_TAX_ID               = P_LOCAL_TAX_ID
    ;

    IF P_SET_TYPE IN('2', '3') THEN
      -- 간이세액 계산.
      SET_A04_1
        ( P_LOCAL_TAX_ID          => P_LOCAL_TAX_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;

      -- 중도퇴사.
      SET_A04_2
        ( P_LOCAL_TAX_ID          => P_LOCAL_TAX_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    -- 연말정산.
    IF P_SET_TYPE IN ('1', '2') THEN
      SET_A04_3
        ( P_LOCAL_TAX_ID          => P_LOCAL_TAX_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;

    IF P_SET_TYPE IN('2', '3') THEN
      -- 퇴직정산.
      SET_A07
        ( P_LOCAL_TAX_ID          => P_LOCAL_TAX_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    
    IF P_SET_TYPE IN('2', '3') THEN
      -- 사업소득.
      SET_A03
        ( P_LOCAL_TAX_ID          => P_LOCAL_TAX_ID
        , P_CORP_ID               => V_CORP_ID
        , P_STD_YYYYMM            => V_STD_YYYYMM
        , P_PAY_YYYYMM            => V_PAY_YYYYMM
        , P_SOB_ID                => P_SOB_ID
        , P_ORG_ID                => P_ORG_ID
        , P_USER_ID               => P_USER_ID
        , O_STATUS                => O_STATUS
        , O_MESSAGE               => O_MESSAGE
        );
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;
    -- A90(총합계).
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.A90_PERSON_CNT         = NVL(TD.A01_PERSON_CNT, 0) + NVL(TD.A02_PERSON_CNT, 0) +
                                      NVL(TD.A03_PERSON_CNT, 0) + NVL(TD.A04_PERSON_CNT, 0) +
                                      NVL(TD.A05_PERSON_CNT, 0) + NVL(TD.A06_PERSON_CNT, 0) +
                                      NVL(TD.A07_PERSON_CNT, 0) + NVL(TD.A08_PERSON_CNT, 0) +
                                      NVL(TD.A09_PERSON_CNT, 0) + NVL(TD.A10_PERSON_CNT, 0)
        , TD.A90_STD_TAX_AMT        = NVL(TD.A01_STD_TAX_AMT, 0) + NVL(TD.A02_STD_TAX_AMT, 0) +
                                      NVL(TD.A03_STD_TAX_AMT, 0) + NVL(TD.A04_STD_TAX_AMT, 0) +
                                      NVL(TD.A05_STD_TAX_AMT, 0) + NVL(TD.A06_STD_TAX_AMT, 0) +
                                      NVL(TD.A07_STD_TAX_AMT, 0) + NVL(TD.A08_STD_TAX_AMT, 0) +
                                      NVL(TD.A09_STD_TAX_AMT, 0) + NVL(TD.A10_STD_TAX_AMT, 0)
        , TD.A90_LOCAL_TAX_AMT      = NVL(TD.A01_LOCAL_TAX_AMT, 0) + NVL(TD.A02_LOCAL_TAX_AMT, 0) +
                                      NVL(TD.A03_LOCAL_TAX_AMT, 0) + NVL(TD.A04_LOCAL_TAX_AMT, 0) +
                                      NVL(TD.A05_LOCAL_TAX_AMT, 0) + NVL(TD.A06_LOCAL_TAX_AMT, 0) +
                                      NVL(TD.A07_LOCAL_TAX_AMT, 0) + NVL(TD.A08_LOCAL_TAX_AMT, 0) +
                                      NVL(TD.A09_LOCAL_TAX_AMT, 0) + NVL(TD.A10_LOCAL_TAX_AMT, 0)
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;
    
    -- 당월 조정환급액 계산 - 중도퇴사자.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.R30_TAX_AMT            = CASE
                                        WHEN NVL(TD.A90_LOCAL_TAX_AMT, 0) = 0 THEN 0
                                        WHEN NVL(TD.A90_LOCAL_TAX_AMT, 0) > (NVL(TD.R10_TAX_AMT, 0) + NVL(TD.R20_TAX_AMT, 0)) 
                                          THEN (NVL(TD.R10_TAX_AMT, 0) + NVL(TD.R20_TAX_AMT, 0))
                                        WHEN NVL(TD.A90_LOCAL_TAX_AMT, 0) < (NVL(TD.R10_TAX_AMT, 0) + NVL(TD.R20_TAX_AMT, 0))
                                          THEN (NVL(TD.R10_TAX_AMT, 0) + NVL(TD.R20_TAX_AMT, 0)) - NVL(TD.A90_LOCAL_TAX_AMT, 0)
                                        ELSE 0
                                      END
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;    
    -- 차월이월 환급세액 계산 - 중도퇴사자.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.R40_TAX_AMT            = (NVL(TD.R10_TAX_AMT, 0) + 
                                      NVL(TD.R20_TAX_AMT, 0)) -
                                      NVL(TD.R30_TAX_AMT, 0)
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;
    -- 가감세액 계산 - 중도퇴사자.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.TOTAL_ADJUST_TAX_AMT   = NVL(TD.K30_TAX_AMT, 0) + NVL(TD.R30_TAX_AMT, 0)
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;
    
    -- 당월 조정환급액 계산 - 계속근로자.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.K30_TAX_AMT            = CASE
                                        WHEN (NVL(TD.A90_LOCAL_TAX_AMT, 0) - NVL(TD.R30_TAX_AMT, 0)) = 0 THEN 0
                                        WHEN (NVL(TD.A90_LOCAL_TAX_AMT, 0) - NVL(TD.R30_TAX_AMT, 0)) > (NVL(TD.K10_TAX_AMT, 0) + NVL(TD.K20_TAX_AMT, 0)) 
                                          THEN (NVL(TD.K10_TAX_AMT, 0) + NVL(TD.K20_TAX_AMT, 0))
                                        WHEN (NVL(TD.A90_LOCAL_TAX_AMT, 0) - NVL(TD.R30_TAX_AMT, 0)) < (NVL(TD.K10_TAX_AMT, 0) + NVL(TD.K20_TAX_AMT, 0))
                                          THEN (NVL(TD.K10_TAX_AMT, 0) + NVL(TD.K20_TAX_AMT, 0)) - (NVL(TD.A90_LOCAL_TAX_AMT, 0) - NVL(TD.R30_TAX_AMT, 0))
                                        ELSE 0
                                      END
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;    
    -- 차월이월 환급세액 계산 - 계속근로자.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.K40_TAX_AMT            = (NVL(TD.K10_TAX_AMT, 0) + 
                                      NVL(TD.K20_TAX_AMT, 0)) -
                                      NVL(TD.K30_TAX_AMT, 0)
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;
    -- 가감세액 계산 - 계속근로자.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.TOTAL_ADJUST_TAX_AMT   = NVL(TD.K30_TAX_AMT, 0) + NVL(TD.R30_TAX_AMT, 0)
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;
    
    -- 납부세액.
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.PAY_LOCAL_TAX_AMT      = NVL(TD.A90_LOCAL_TAX_AMT, 0) -
                                      NVL(TD.TOTAL_ADJUST_TAX_AMT, 0)
    WHERE TD.LOCAL_TAX_ID           = P_LOCAL_TAX_ID
    ;
    
  END MAIN_LOCAL_TAX;

-- 계속근로자 간이세액 계산.
  PROCEDURE SET_A04_1
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_STD_TAX_AMT                     NUMBER := 0;
    V_LOCAL_TAX_AMT                   NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(MP.PERSON_ID) AS PERSON_COUNT
           , SUM(HMD.D01) AS INCOME_TAX_AMOUNT  -- 소득세.
           , SUM(HMD.D02) AS LOCAL_TAX_AMOUNT   -- 주민세.
        INTO V_PERSON_COUNT
           , V_STD_TAX_AMT
           , V_LOCAL_TAX_AMT
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
          , ( SELECT MD.MONTH_PAYMENT_ID
                  , SUM(MD.D01) AS D01
                  , SUM(MD.D02) AS D02
                FROM HRP_MONTH_DEDUCTION_V MD
              WHERE MD.PAY_YYYYMM       = P_STD_YYYYMM  -- 귀속년월.
                AND MD.CORP_ID          = P_CORP_ID
                AND MD.SOB_ID           = P_SOB_ID
                AND MD.ORG_ID           = P_ORG_ID
              GROUP BY MD.MONTH_PAYMENT_ID
             ) HMD
      WHERE PM.PERSON_ID                = MP.PERSON_ID
        AND MP.MONTH_PAYMENT_ID         = HMA.MONTH_PAYMENT_ID
        AND MP.MONTH_PAYMENT_ID         = HMD.MONTH_PAYMENT_ID
        AND MP.PAY_YYYYMM               = P_STD_YYYYMM  -- 귀속년월.
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND (MP.TOT_SUPPLY_AMOUNT       <> 0
        OR MP.TOT_DED_AMOUNT            <> 0)
        AND TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM')  = P_PAY_YYYYMM  -- 지급년월.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_STD_TAX_AMT       := 0;
      V_LOCAL_TAX_AMT     := 0;
    END;

    BEGIN
      UPDATE HRW_LOCAL_TAX_DOC TD
        SET TD.A04_PERSON_CNT       = NVL(V_PERSON_COUNT, 0)
          , TD.A04_STD_TAX_AMT      = NVL(V_STD_TAX_AMT, 0)
          , TD.A04_LOCAL_TAX_AMT    = NVL(V_LOCAL_TAX_AMT, 0)
      WHERE TD.LOCAL_TAX_ID         = P_LOCAL_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A04_1;

-- 중도퇴사 계산.
  PROCEDURE SET_A04_2
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_STD_TAX_AMT                     NUMBER := 0;
    V_LOCAL_TAX_AMT                   NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(DISTINCT MP.PERSON_ID) AS PERSON_COUNT
           , SUM(HYA.SUBT_IN_TAX_AMT) AS INCOME_TAX_AMOUNT  -- 정산소득세.
           , SUM(HYA.SUBT_LOCAL_TAX_AMT) AS LOCAL_TAX_AMT   -- 정산 주민세.
        INTO V_PERSON_COUNT
          , V_STD_TAX_AMT
          , V_LOCAL_TAX_AMT
        FROM HRM_PERSON_MASTER PM
          , HRP_MONTH_PAYMENT MP
          , ( SELECT YA.PERSON_ID
                   , YA.SUBT_IN_TAX_AMT
                   , YA.SUBT_LOCAL_TAX_AMT
                FROM HRA_YEAR_ADJUSTMENT YA
              WHERE YA.YEAR_YYYY        = SUBSTR(P_STD_YYYYMM, 1, 4)
                AND YA.CORP_ID          = P_CORP_ID
                AND YA.ADJUST_DATE_TO   BETWEEN TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'))
             ) HYA
      WHERE PM.PERSON_ID                = MP.PERSON_ID
        AND MP.PERSON_ID                = HYA.PERSON_ID
        AND MP.PAY_YYYYMM               = P_STD_YYYYMM  -- 귀속년월.
        AND MP.CORP_ID                  = P_CORP_ID
        AND MP.SOB_ID                   = P_SOB_ID
        AND MP.ORG_ID                   = P_ORG_ID
        AND NVL(HYA.SUBT_IN_TAX_AMT, 0) <> 0
        AND PM.RETIRE_DATE              BETWEEN TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'MONTH') AND LAST_DAY(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'))
        AND TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM')  = P_PAY_YYYYMM  -- 지급년월.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_STD_TAX_AMT       := 0;
      V_LOCAL_TAX_AMT     := 0;
    END;

    BEGIN
      /*IF NVL(V_LOCAL_TAX_AMT, 0) THEN */
      -- 주민세 징수시 근로소득 포함 처리.
      UPDATE HRW_LOCAL_TAX_DOC TD
        SET TD.A04_PERSON_CNT        = NVL(TD.A04_PERSON_CNT, 0) + NVL(V_PERSON_COUNT, 0)
          , TD.A04_STD_TAX_AMT       = NVL(TD.A04_STD_TAX_AMT, 0) + NVL(V_STD_TAX_AMT, 0)
          , TD.A04_LOCAL_TAX_AMT     = NVL(TD.A04_LOCAL_TAX_AMT, 0) + NVL(V_LOCAL_TAX_AMT, 0)
      WHERE TD.LOCAL_TAX_ID          = P_LOCAL_TAX_ID
      ;
      /*ELSE
        -- 주민세 환급시 환급액(정산) 적용.
        UPDATE HRW_LOCAL_TAX_DOC TD
          SET TD.R20_TAX_AMT           = ABS(NVL(V_LOCAL_TAX_AMT, 0))
        WHERE TD.LOCAL_TAX_ID          = P_LOCAL_TAX_ID
        ;
      END IF;*/
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A04_2;

-- 연말정산 계산.
  PROCEDURE SET_A04_3
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_STD_TAX_AMT                     NUMBER := 0;
    V_LOCAL_TAX_AMT                   NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(YA.PERSON_ID) AS PERSON_COUNT
           , SUM(YA.SUBT_IN_TAX_AMT) AS INCOME_TAX_AMOUNT  -- 정산 소득세.
           , SUM(YA.SUBT_LOCAL_TAX_AMT) AS LOCAL_TAX_AMT   -- 정산 주민세.
        INTO V_PERSON_COUNT
          , V_STD_TAX_AMT
          , V_LOCAL_TAX_AMT
        FROM HRM_PERSON_MASTER PM
          , HRA_YEAR_ADJUSTMENT YA
      WHERE PM.PERSON_ID                = YA.PERSON_ID
        AND YA.YEAR_YYYY                = TO_CHAR(TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') - 1, 'YYYY')
        AND YA.ADJUST_DATE_TO           = TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') - 1
        AND PM.CORP_ID                  = P_CORP_ID
        AND PM.SOB_ID                   = P_SOB_ID
        AND PM.ORG_ID                   = P_ORG_ID
        /*AND NVL(YA.SUBT_IN_TAX_AMT, 0)  <> 0*/
        AND (PM.RETIRE_DATE             >= TRUNC(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), 'YEAR') OR PM.RETIRE_DATE IS NULL)
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_STD_TAX_AMT       := 0;
      V_LOCAL_TAX_AMT     := 0;
    END;

    BEGIN
      /*IF NVL(V_LOCAL_TAX_AMT, 0) > 0 THEN*/
      -- 연말정산 처리후 징수시 처리.
      UPDATE HRW_LOCAL_TAX_DOC TD
        SET TD.A04_PERSON_CNT        = NVL(TD.A04_PERSON_CNT, 0) + NVL(V_PERSON_COUNT, 0)
          , TD.A04_STD_TAX_AMT       = NVL(TD.A04_STD_TAX_AMT, 0) + NVL(V_STD_TAX_AMT, 0)
          , TD.A04_LOCAL_TAX_AMT     = NVL(TD.A04_LOCAL_TAX_AMT, 0 )+ NVL(V_LOCAL_TAX_AMT, 0)
      WHERE TD.LOCAL_TAX_ID          = P_LOCAL_TAX_ID
      ;
      /*ELSE
        -- 연말정산 처리후 환급시 처리.
        UPDATE HRW_LOCAL_TAX_DOC TD
          SET TD.K20_TAX_AMT           = ABS(NVL(V_LOCAL_TAX_AMT, 0))
        WHERE TD.LOCAL_TAX_ID          = P_LOCAL_TAX_ID
        ;
      END IF;*/
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A04_3;

-- 퇴직소득 계산.
  PROCEDURE SET_A07
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_STD_TAX_AMT                     NUMBER := 0;
    V_LOCAL_TAX_AMT                   NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(RA.PERSON_ID) AS PERSON_COUNT
           , SUM(TRUNC(NVL(RA.INCOME_TAX_AMOUNT, 0), -1) + TRUNC(NVL(RA.H_INCOME_TAX_AMOUNT, 0), -1)) AS INCOME_TAX_AMT
           , SUM(TRUNC(NVL(RA.RESIDENT_TAX_AMOUNT, 0), -1) + TRUNC(NVL(RA.H_RESIDENT_TAX_AMOUNT, 0), -1)) AS LOCAL_TAX_AMT
        INTO V_PERSON_COUNT
           , V_STD_TAX_AMT
           , V_LOCAL_TAX_AMT
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
      V_STD_TAX_AMT       := 0;
      V_LOCAL_TAX_AMT     := 0;
    END;

    BEGIN
      UPDATE HRW_LOCAL_TAX_DOC TD
        SET TD.A07_PERSON_CNT      = NVL(V_PERSON_COUNT, 0)
          , TD.A07_STD_TAX_AMT     = NVL(V_STD_TAX_AMT, 0)
          , TD.A07_LOCAL_TAX_AMT   = NVL(V_LOCAL_TAX_AMT, 0)
      WHERE TD.LOCAL_TAX_ID        = P_LOCAL_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A07;

-- 사업소득 계산.
  PROCEDURE SET_A03
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CORP_ID               IN HRW_LOCAL_TAX_DOC.CORP_ID%TYPE
            , P_STD_YYYYMM            IN HRW_LOCAL_TAX_DOC.STD_YYYYMM%TYPE
            , P_PAY_YYYYMM            IN HRW_LOCAL_TAX_DOC.PAY_YYYYMM%TYPE
            , P_SOB_ID                IN HRW_LOCAL_TAX_DOC.SOB_ID%TYPE
            , P_ORG_ID                IN HRW_LOCAL_TAX_DOC.ORG_ID%TYPE
            , P_USER_ID               IN NUMBER
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_PERSON_COUNT                    NUMBER := 0;
    V_STD_TAX_AMT                     NUMBER := 0;
    V_LOCAL_TAX_AMT                   NUMBER := 0;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT COUNT(IRB.EARNER_ID) AS PERSON_COUNT
           , SUM(IRB.INCOME_TAX_AMT) AS INCOME_TAX_AMOUNT
           , SUM(IRB.LOCAL_TAX_AMT) AS LOCAL_TAX_AMOUNT
        INTO V_PERSON_COUNT
           , V_STD_TAX_AMT
           , V_LOCAL_TAX_AMT
        FROM HRW_INCOME_RESIDENT_BSN IRB
      WHERE IRB.CORP_ID                 = P_CORP_ID
        AND IRB.SOB_ID                  = P_SOB_ID
        AND IRB.ORG_ID                  = P_ORG_ID
        AND TO_CHAR(IRB.PAY_DATE, 'YYYY-MM')     = P_STD_YYYYMM     -- 귀속연월.
        AND TO_CHAR(IRB.RECEIPT_DATE, 'YYYY-MM') = P_PAY_YYYYMM  -- 지급연월.
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PERSON_COUNT      := 0;
      V_STD_TAX_AMT       := 0;
      V_LOCAL_TAX_AMT     := 0;
    END;

    BEGIN
      UPDATE HRW_LOCAL_TAX_DOC TD
        SET TD.A03_PERSON_CNT        = NVL(V_PERSON_COUNT, 0)
          , TD.A03_STD_TAX_AMT       = NVL(V_STD_TAX_AMT, 0)
          , TD.A03_LOCAL_TAX_AMT     = NVL(V_LOCAL_TAX_AMT, 0)
      WHERE TD.LOCAL_TAX_ID          = P_LOCAL_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SQLERRM;
    END;
    O_STATUS := 'S';
  END SET_A03;

-- 주민세특별징수명세/납입서 마감 여부.
  FUNCTION CLOSED_LOCAL_TAX_YN
            ( P_LOCAL_TAX_ID      IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_COUNT                     NUMBER := 0;
  BEGIN
    -- 마감 여부 체크.
    BEGIN
      SELECT SUM(DECODE(TD.CLOSED_YN, 'Y', 1, 0)) AS CLOSED_COUNT
        INTO V_COUNT
        FROM HRW_LOCAL_TAX_DOC TD
      WHERE TD.LOCAL_TAX_ID       = P_LOCAL_TAX_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_COUNT := 0;
    END;
    IF V_COUNT > 0 THEN
      RETURN 'Y';
    END IF;
    RETURN 'N';
  END CLOSED_LOCAL_TAX_YN;

-- 주민세특별징수명세/납입서  마감.
  PROCEDURE CLOSED_LOCAL_TAX
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            )
  AS
  BEGIN
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.CLOSED_YN            = 'Y'
        , TD.CLOSED_DATE          = GET_LOCAL_DATE(P_SOB_ID)
        , TD.CLOSED_PERSON_ID     = P_CONNECT_PERSON_ID
    WHERE TD.LOCAL_TAX_ID         = P_LOCAL_TAX_ID
    ;
  END CLOSED_LOCAL_TAX;

-- 주민세특별징수명세/납입서  마감 취소.
  PROCEDURE CLOSED_CANCEL_LOCAL_TAX
            ( P_LOCAL_TAX_ID          IN HRW_LOCAL_TAX_DOC.LOCAL_TAX_ID%TYPE
            , P_CONNECT_PERSON_ID     IN NUMBER
            , P_SOB_ID                IN NUMBER
            , P_ORG_ID                IN NUMBER
            )
  AS
  BEGIN
    UPDATE HRW_LOCAL_TAX_DOC TD
      SET TD.CLOSED_YN            = 'N'
        , TD.CLOSED_DATE          = GET_LOCAL_DATE(P_SOB_ID)
        , TD.CLOSED_PERSON_ID     = P_CONNECT_PERSON_ID
    WHERE TD.LOCAL_TAX_ID         = P_LOCAL_TAX_ID
    ;
  END CLOSED_CANCEL_LOCAL_TAX;

END HRW_LOCAL_TAX_SET_G;
/
