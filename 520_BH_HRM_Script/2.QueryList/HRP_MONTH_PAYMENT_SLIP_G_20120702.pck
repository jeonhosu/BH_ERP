CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_SLIP_G
AS

-- 급상여 자료  합계 SELECT
  PROCEDURE SELECT_PAYMENT_SUM
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
-- 급상여 자료 전표 생성.
  PROCEDURE SET_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

-- 급상여 자료 전표 취소.
  PROCEDURE CANCEL_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

---------------------------------------------------------------------------------------------------
-- 급상여 대상중 원가코드 누락자수 리턴.
  FUNCTION CC_NONREGISTERED_COUNT_F
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER;
            
END HRP_MONTH_PAYMENT_SLIP_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_SLIP_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_MONTH_PAYMENT_SLIP_G
/* DESCRIPTION  : 급상여 내역 자동전표 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 급상여 자료 SELECT
  PROCEDURE SELECT_PAYMENT_SUM
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      -- 급여판관/급여제조/경상연구개발비.
      SELECT AJM.SLIP_TYPE_CD
           , AJM.JOB_CATEGORY_CD
           , AJM.SLIP_REMARKS AS HEADER_REMARK
           , AJD.AUTO_JOURNAL_SEQ
           , AJD.ACCOUNT_CONTROL_ID
           , AJD.ACCOUNT_CODE
           , AC.ACCOUNT_DESC
           , NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR
           , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
           , DECODE( NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), '1', NVL(PAY_AL.AMOUNT, 0)) AS DR_AMOUNT
           , DECODE(NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), '2', NVL(PAY_AL.AMOUNT, 0)) AS CR_AMOUNT
           , PAY_AL.VENDOR_CODE
           , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
           , AJD.SLIP_REMARKS
           , ( SELECT MAX(MP.INTERFACE_NUM) AS INTERFACE_NUM
                 FROM HRP_MONTH_PAYMENT MP
               WHERE MP.PAY_YYYYMM    = P_PAY_YYYYMM
                AND MP.WAGE_TYPE      = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID        = P_CORP_ID
                AND MP.SOB_ID         = P_SOB_ID
                AND MP.ORG_ID         = P_ORG_ID
              ) AS SLIP_NUM
        FROM FI_AUTO_JOURNAL_MST AJM
          , FI_AUTO_JOURNAL_DET AJD
          , FI_ACCOUNT_CONTROL AC
          , ( -- 지급.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END
                     END AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_ALLOWANCE MA
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MA.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MA.PERSON_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END
                     END
              UNION ALL
              -- 피복대.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                         END
                     END AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN ('D11')
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                         END
                     END
              UNION ALL
              -- 예수금.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100600' AS ACCOUNT_CODE
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- 소득세(북인천세무서).
                       WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- 주민세(부평구청).
                       WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- 국민연금(국민연금관리공단).
                       WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- 고용보험(근로복지공단).
                       WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- 건강보험(건강보험관리공단).
                       WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- 요양보험(건강보험관리공단).
                     END AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     BETWEEN 'D01' AND 'D09'
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- 소득세(북인천세무서).
                       WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- 주민세(부평구청).
                       WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- 국민연금(국민연금관리공단).
                       WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- 고용보험(근로복지공단).
                       WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- 건강보험(건강보험관리공단).
                       WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- 요양보험(건강보험관리공단).
                     END
              UNION ALL
              -- 기타(소득세/정산 주민세/보증보험료) 예수금.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100600' AS ACCOUNT_CODE
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- 소득세(북인천세무서).
                       WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- 주민세(부평구청).
                       WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- 서울보증보험(주).
                     END AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN('D15', 'D16', 'D21')
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- 소득세(북인천세무서).
                       WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- 주민세(부평구청).
                       WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- 서울보증보험(주).
                     END              
              UNION ALL
              -- 전도금.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '1111600' AS ACCOUNT_CODE
                   , 'S001571' AS VENDOR_CODE  -- 외국인근로자.
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D13'
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- 선수금.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2101500' AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN('D12')
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- 기타유동부채.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2101800' AS ACCOUNT_CODE  -- 기타유동부채.
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MP.REAL_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND NVL(MP.REAL_AMOUNT, 0)  >= 0
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- 기타유동부채(-금액).
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , '1' AS ACCOUNT_DR_CR
                   , '2101800' AS ACCOUNT_CODE  -- 기타유동부채.
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MP.REAL_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND NVL(MP.REAL_AMOUNT, 0)  < 0
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID                   
              -- 2011-10 예외처리.(년차공제 => 지급에서 (-) 처리함.
              UNION ALL
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END
                     END AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     IN('D14')
                AND (MP.PAY_YYYYMM        = '2012-02'
                AND PM.PERSON_NUM         NOT IN('B11002', 'B10113', 'B12002', 'B10114'))
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , CASE 
                       WHEN P_WAGE_TYPE = 'P1' THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END 
                       WHEN P_WAGE_TYPE IN ('P2', 'P5') THEN 
                         CASE
                           WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                           WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                           WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                         END
                     END
              UNION ALL
              -- 예수금 : 예외처리<박민수> : 기타공제 -> 건강보험료 정산 
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100600' AS ACCOUNT_CODE
                   , 'S000045' AS VENDOR_CODE  -- 건강보험(건강보험관리공단).
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.PAY_YYYYMM         = '2012-02'
                AND PM.PERSON_NUM         = 'B11002'  -- 박민수.
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- 미지급비용 : 예외처리<자나카, 만줄라, 자야미니> : 기타공제 -> 미지급비용 
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '2100500' AS ACCOUNT_CODE
                   , 'S001571' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                AND 1                     = 2
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- 미지급비용 : 기타공제 -> 선급금.
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '1111100' AS ACCOUNT_CODE
                   , 'S001571' AS VENDOR_CODE
                   , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                AND (MP.PAY_YYYYMM        = '2012-05'
                AND PM.PERSON_NUM         NOT IN('B03066', 'B10039', 'B11105'))  -- 변보선, 김상훈, 김경은 : 교육비공제로 처리.
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
              UNION ALL
              -- 예외처리<기타공제 => 교육비공제로 처리.>
              SELECT PM.SOB_ID
                   , PM.ORG_ID
                   , NULL AS ACCOUNT_DR_CR
                   , '5131701' AS ACCOUNT_CODE
                   , 'S000632' AS VENDOR_CODE  -- 임직원.
                   , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                FROM HRM_PERSON_MASTER PM
                  , HRP_MONTH_PAYMENT MP
                  , HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V HD
              WHERE PM.PERSON_ID          = MP.PERSON_ID
                AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                AND MP.PERSON_ID          = MD.PERSON_ID
                AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                AND MP.PAY_YYYYMM         = '2012-06'
                --AND PM.PERSON_NUM         IN('B03066', 'B10039', 'B11105')  -- 변보선, 김상훈, 김경은 : 교육비공제로 처리.
                AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                AND MP.CORP_ID            = P_CORP_ID
                AND MP.SOB_ID             = P_SOB_ID
                AND MP.ORG_ID             = P_ORG_ID
                AND HD.DEDUCTION_CODE     = 'D14'
                -- 중도 퇴사자 적용 여부 판단.
              GROUP BY MP.PAY_YYYYMM
                   , MP.WAGE_TYPE
                   , PM.SOB_ID
                   , PM.ORG_ID
            ) PAY_AL
      WHERE AJM.SOB_ID              = AJD.SOB_ID
        AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
        AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
        AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
        AND AJD.SOB_ID              = AC.SOB_ID
        AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
        AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
        AND AJD.SOB_ID              = P_SOB_ID
        AND AJD.SLIP_TYPE_CD        = 'PAY'
        AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                        WHEN 'P1' THEN 'PAY01'  -- 급여.
                                        WHEN 'P2' THEN 'PAY02'  -- 상여.
                                        WHEN 'P3' THEN 'PAY02'  -- 명절상여.
                                        WHEN 'P5' THEN 'PAY05'  -- 특별상여.
                                      END
        AND AJM.ENABLED_FLAG        = 'Y'
        AND AJD.ENABLED_FLAG        = 'Y'
      ORDER BY AJD.AUTO_JOURNAL_SEQ  
      ;
  END SELECT_PAYMENT_SUM;

-- 급상여 자료 전표 생성.
  PROCEDURE SET_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE          DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT     NUMBER := 0;
    V_MODULE_TYPE      VARCHAR2(10) := 'PAY';
    V_HEADER_ID        NUMBER;
    V_SLIP_NUM         VARCHAR2(30);
    V_STATUS           VARCHAR2(4);
    V_MESSAGE          VARCHAR2(300);      
    V_SLIP_DATE        DATE := LAST_DAY(TO_DATE(P_PAY_YYYYMM, 'YYYY-MM'));
    V_DEPT_CODE        VARCHAR2(20);  -- 발의부서코드.
    V_CURRENCY_CODE    VARCHAR2(10);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      IF P_WAGE_TYPE = 'P3' THEN
        -- 명절상여.
        SELECT MAX(MP.SUPPLY_DATE) AS SLIP_DATE
            , COUNT(MP.PAY_YYYYMM) AS RECORD_COUNT
          INTO V_SLIP_DATE
            , V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
            , HRP_MONTH_PAYMENT MP
        WHERE PM.PERSON_ID          = MP.PERSON_ID
          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
          AND MP.CORP_ID            = P_CORP_ID
          AND MP.SOB_ID             = P_SOB_ID
          AND MP.ORG_ID             = P_ORG_ID
          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
          -- 중도 퇴사자 적용 여부 판단.
        ;
      ELSE
        -- 일반 급상여.
        SELECT COUNT(MP.PAY_YYYYMM) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRM_PERSON_MASTER PM
            , HRP_MONTH_PAYMENT MP
        WHERE PM.PERSON_ID          = MP.PERSON_ID
          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
          AND MP.CORP_ID            = P_CORP_ID
          AND MP.SOB_ID             = P_SOB_ID
          AND MP.ORG_ID             = P_ORG_ID
          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
          -- 중도 퇴사자 적용 여부 판단.
        ;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10381', NULL);
      RETURN;
    END IF;
    
    -- 원가코드 미등록자 검증.
    V_RECORD_COUNT := 0;
    V_RECORD_COUNT := CC_NONREGISTERED_COUNT_F
                        ( P_CORP_ID           => P_CORP_ID
                        , P_PAY_YYYYMM        => P_PAY_YYYYMM
                        , P_WAGE_TYPE         => P_WAGE_TYPE
                        , P_SOB_ID            => P_SOB_ID
                        , P_ORG_ID            => P_ORG_ID
                        );                       
    IF V_RECORD_COUNT > 0 THEN
      O_STATUS := 'F';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'CST_10008', NULL);
      RETURN;
    END IF;
    
    -- 기본데이터 조회.
    BEGIN
      SELECT FDM.DEPT_CODE
        INTO V_DEPT_CODE
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MAPPING DM
          , FI_DEPT_MASTER FDM
      WHERE PM.DEPT_ID          = DM.HR_DEPT_ID
        AND DM.M_DEPT_ID        = FDM.DEPT_ID
        AND DM.MODULE_TYPE      = 'FCM'
        AND PM.PERSON_ID        = P_CONNECT_PERSON_ID
        AND PM.SOB_ID           = P_SOB_ID
        AND PM.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_DEPT_CODE := NULL;
    END;
    IF V_DEPT_CODE IS NULL THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10183', NULL);
      RETURN;
    END IF;
    V_CURRENCY_CODE := FI_ACCOUNT_BOOK_G.BASE_CURRENCY_F(P_SOB_ID);
    
---------------------------------------------------------------------------------------------------    
    -- 임시테이블 기존자료 삭제.
    FI_SLIP_AUTO_INTERFACE_G.DELETE_SLIP_AUTO_INTERFACE;
      
    -- 급여(제), 급여(판), 경상연구개발비 - 전표 라인 생성 시작.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , P_PAY_YYYYMM || ' ' || AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AJD.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJD.ACCOUNT_DR_CR, AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , V_DEPT_CODE AS DEPT_CODE
                     , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(P_CONNECT_PERSON_ID) AS PERSON_NUM
                     , PAY_AL.CC_CODE
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- 지급.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END
                               END AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MA.ALLOWANCE_AMOUNT) AS AMOUNT
                             , CC.COST_CENTER_CODE AS CC_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_ALLOWANCE MA
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MA.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MA.PERSON_ID
                          AND PM.COST_CENTER_ID     = CC.COST_CENTER_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END
                               END
                             , CC.COST_CENTER_CODE
                        -- 2011-10 예외처리.(년차공제 => 지급에서 (-) 처리함.
                        UNION ALL
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END
                               END AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE  -- 임직원.
                             , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                             , CC.COST_CENTER_CODE AS CC_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND PM.COST_CENTER_ID     = CC.COST_CENTER_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN('D14')
                          AND (MP.PAY_YYYYMM        = '2012-02'
                          AND PM.PERSON_NUM         NOT IN('B11002', 'B10113', 'B12002', 'B10114'))
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200100'  -- 급여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120100'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE = '10' THEN '5200200'  -- 상여판관.
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5120200'  -- 상여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5131501'  -- 급여경상연구개발비.
                                   END
                               END
                             , CC.COST_CENTER_CODE
                        UNION ALL
                        -- 피복대.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                                   END
                               END AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE                            -- 임직원.
                             , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                             , CC.COST_CENTER_CODE AS CC_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND PM.COST_CENTER_ID     = CC.COST_CENTER_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN ('D11')
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CASE 
                                 WHEN P_WAGE_TYPE = 'P1' THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                                   END 
                                 WHEN P_WAGE_TYPE IN ('P2', 'P3', 'P5') THEN 
                                   CASE
                                     WHEN PM.DIR_INDIR_TYPE IN('20', '30') THEN '5130401'  -- 급여제조.
                                     WHEN PM.DIR_INDIR_TYPE = '40' THEN '5200401'  -- 제조외.
                                   END
                               END
                             , CC.COST_CENTER_CODE
                        UNION ALL
                        -- 예외처리<기타공제 => 교육비공제로 처리.> : 
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '5131701' AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE  -- 임직원.
                             , SUM(MD.DEDUCTION_AMOUNT) * -1 AS AMOUNT
                             , CC.COST_CENTER_CODE
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                            , CST_COST_CENTER CC
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.COST_CENTER_ID     = CC.COST_CENTER_ID(+)
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.PAY_YYYYMM         = '2012-06'
                          --AND PM.PERSON_NUM         IN('B03066', 'B10039', 'B11105')  -- 변보선, 김상훈, 김경은 : 교육비공제로 처리.
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , CC.COST_CENTER_CODE
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- 급여.
                                                  WHEN 'P2' THEN 'PAY02'  -- 상여.
                                                  WHEN 'P3' THEN 'PAY02'  -- 명절상여.
                                                  WHEN 'P5' THEN 'PAY05'  -- 특별상여.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => C1.DEPT_CODE
          , P_REFER1              => C1.PERSON_NUM
          , P_REFER2              => C1.CC_CODE
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- 예수금/선수금 - 전표 라인 생성 시작.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AJD.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJD.ACCOUNT_DR_CR, AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(P_CONNECT_PERSON_ID) AS PERSON_NUM
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- 예수금.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100600' AS ACCOUNT_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- 소득세(북인천세무서).
                                 WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- 주민세(부평구청).
                                 WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- 국민연금(국민연금관리공단).
                                 WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- 고용보험(근로복지공단).
                                 WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- 건강보험(건강보험관리공단).
                                 WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- 요양보험(건강보험관리공단).
                               END AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          AND HD.DEDUCTION_CODE     BETWEEN 'D01' AND 'D09'
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , HD.DEDUCTION_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D01' THEN 'S000194'  -- 소득세(북인천세무서).
                                 WHEN HD.DEDUCTION_CODE = 'D02' THEN 'S000046'  -- 주민세(부평구청).
                                 WHEN HD.DEDUCTION_CODE IN('D03', 'D08') THEN 'S000043'  -- 국민연금(국민연금관리공단).
                                 WHEN HD.DEDUCTION_CODE = 'D04' THEN 'S000042'  -- 고용보험(근로복지공단).
                                 WHEN HD.DEDUCTION_CODE IN('D05', 'D07') THEN 'S000045'  -- 건강보험(건강보험관리공단).
                                 WHEN HD.DEDUCTION_CODE IN('D06', 'D09') THEN 'S000045'  -- 요양보험(건강보험관리공단).
                               END
                        UNION ALL
                        -- 기타(소득세/정산 주민세/보증보험료) 예수금.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100600' AS ACCOUNT_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- 소득세(북인천세무서).
                                 WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- 주민세(부평구청).
                                 WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- 서울보증보험(주).
                               END AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN('D15', 'D16', 'D21')
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                             , HD.DEDUCTION_CODE
                             , CASE 
                                 WHEN HD.DEDUCTION_CODE = 'D15' THEN 'S000194'  -- 소득세(북인천세무서).
                                 WHEN HD.DEDUCTION_CODE = 'D16' THEN 'S000046'  -- 주민세(부평구청).
                                 WHEN HD.DEDUCTION_CODE = 'D21' THEN 'S001815'  -- 서울보증보험(주).
                               END
                        UNION ALL
                        -- 선수금.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2101500' AS ACCOUNT_CODE
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     IN('D12')
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- 예수금 : 예외처리<박민수> : 기타공제 -> 건강보험료 정산 
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100600' AS ACCOUNT_CODE
                             , 'S000045' AS VENDOR_CODE  -- 건강보험(건강보험관리공단).
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.PAY_YYYYMM         = '2012-02'
                          AND PM.PERSON_NUM         = 'B11002'  -- 박민수.
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- 미지급비용 : 기타공제 -> 미지급비용 
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '2100500' AS ACCOUNT_CODE
                             , 'S001571' AS VENDOR_CODE  -- 외국인 근로자;
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          AND 1                     = 2
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- 미지급비용 : 기타공제 -> 선급금.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '1111100' AS ACCOUNT_CODE
                             , 'S001571' AS VENDOR_CODE
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D14'
                          AND (MP.PAY_YYYYMM        = '2012-05'
                          AND PM.PERSON_NUM         NOT IN('B03066', 'B10039', 'B11105'))  -- 변보선, 김상훈, 김경은 : 교육비공제로 처리.
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- 급여.
                                                  WHEN 'P2' THEN 'PAY02'  -- 상여.
                                                  WHEN 'P3' THEN 'PAY02'  -- 명절상여.
                                                  WHEN 'P5' THEN 'PAY05'  -- 특별상여.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => NULL
          , P_REFER1              => NULL
          , P_REFER2              => NULL
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- 전도금 - 전표 라인 생성 시작.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , AJD.ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', AJD.ACCOUNT_DR_CR, AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(P_CONNECT_PERSON_ID) AS PERSON_NUM
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- 전도금.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '1111600' AS ACCOUNT_CODE
                             , 'S001571' AS VENDOR_CODE  -- 외국인근로자.
                             , SUM(MD.DEDUCTION_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                            , HRP_MONTH_DEDUCTION MD
                            , HRM_DEDUCTION_V HD
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.MONTH_PAYMENT_ID   = MD.MONTH_PAYMENT_ID
                          AND MP.PERSON_ID          = MD.PERSON_ID
                          AND MD.DEDUCTION_ID       = HD.DEDUCTION_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND HD.DEDUCTION_CODE     = 'D13'
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- 급여.
                                                  WHEN 'P2' THEN 'PAY02'  -- 상여.
                                                  WHEN 'P5' THEN 'PAY05'  -- 특별상여.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => C1.PERSON_NUM
          , P_REFER1              => NULL
          , P_REFER2              => NULL
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- 기타유동부채 - 전표 라인 생성 시작.
    FOR C1 IN ( SELECT AJM.SLIP_TYPE_CD
                     , AJM.JOB_CATEGORY_CD
                     , P_SOB_ID AS SOB_ID
                     , P_ORG_ID AS ORG_ID
                     , AJM.SLIP_REMARKS AS HEADER_REMARK
                     , AJD.AUTO_JOURNAL_SEQ
                     , AJD.ACCOUNT_CONTROL_ID
                     , AJD.ACCOUNT_CODE
                     , AC.ACCOUNT_DESC
                     , NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR) AS ACCOUNT_DR_CR
                     , FI_COMMON_G.CODE_NAME_F('ACCOUNT_DR_CR', NVL(PAY_AL.ACCOUNT_DR_CR, AJD.ACCOUNT_DR_CR), AJD.SOB_ID) AS ACCOUNT_DR_CR_DESC
                     , NVL(PAY_AL.AMOUNT, 0) AS GL_AMOUNT
                     , PAY_AL.VENDOR_CODE
                     , FI_COMMON_G.SUPP_CUST_CODE_NAME_F(PAY_AL.VENDOR_CODE, P_SOB_ID) AS VENDOR_NAME
                     , AJD.SLIP_REMARKS AS LINE_REMARK
                  FROM FI_AUTO_JOURNAL_MST AJM
                    , FI_AUTO_JOURNAL_DET AJD
                    , FI_ACCOUNT_CONTROL AC
                    , ( -- 실지급액.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , NULL AS ACCOUNT_DR_CR
                             , '2101800' AS ACCOUNT_CODE  -- 기타유동부채.
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MP.REAL_AMOUNT) AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          AND NVL(MP.REAL_AMOUNT, 0) >= 0
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                        UNION ALL
                        -- 실지급액(-) 금액.
                        SELECT PM.SOB_ID
                             , PM.ORG_ID
                             , '1' AS ACCOUNT_DR_CR
                             , '2101800' AS ACCOUNT_CODE  -- 기타유동부채.
                             , 'S000632' AS VENDOR_CODE
                             , SUM(MP.REAL_AMOUNT) * -1 AS AMOUNT
                          FROM HRM_PERSON_MASTER PM
                            , HRP_MONTH_PAYMENT MP
                        WHERE PM.PERSON_ID          = MP.PERSON_ID
                          AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
                          AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
                          AND MP.CORP_ID            = P_CORP_ID
                          AND MP.SOB_ID             = P_SOB_ID
                          AND MP.ORG_ID             = P_ORG_ID
                          AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
                          AND NVL(MP.REAL_AMOUNT, 0) < 0
                          -- 중도 퇴사자 적용 여부 판단.
                        GROUP BY MP.PAY_YYYYMM
                             , MP.WAGE_TYPE
                             , PM.SOB_ID
                             , PM.ORG_ID
                      ) PAY_AL
                WHERE AJM.SOB_ID              = AJD.SOB_ID
                  AND AJM.SLIP_TYPE_CD        = AJD.SLIP_TYPE_CD
                  AND AJM.JOB_CATEGORY_CD     = AJD.JOB_CATEGORY_CD
                  AND AJD.ACCOUNT_CONTROL_ID  = AC.ACCOUNT_CONTROL_ID
                  AND AJD.SOB_ID              = AC.SOB_ID
                  AND AC.ACCOUNT_CODE         = PAY_AL.ACCOUNT_CODE(+)
                  AND AC.SOB_ID               = PAY_AL.SOB_ID(+)
                  AND AJD.SOB_ID              = P_SOB_ID
                  AND AJD.SLIP_TYPE_CD        = V_MODULE_TYPE
                  AND AJD.JOB_CATEGORY_CD     = CASE P_WAGE_TYPE
                                                  WHEN 'P1' THEN 'PAY01'  -- 급여.
                                                  WHEN 'P2' THEN 'PAY02'  -- 상여.
                                                  WHEN 'P3' THEN 'PAY02'  -- 상여.
                                                  WHEN 'P5' THEN 'PAY05'  -- 특별상여.
                                                END
                  AND AJM.ENABLED_FLAG        = 'Y'
                  AND AJD.ENABLED_FLAG        = 'Y'
                ORDER BY AJD.AUTO_JOURNAL_SEQ  
                )
    LOOP
      IF NVL(C1.GL_AMOUNT, 0) <> 0 THEN
        FI_SLIP_AUTO_INTERFACE_G.INSERT_SLIP_AUTO_INTERFACE
          ( P_MODULE_TYPE         => V_MODULE_TYPE
          , P_SLIP_DATE           => V_SLIP_DATE
          , P_SOB_ID              => C1.SOB_ID
          , P_ORG_ID              => C1.ORG_ID
          , P_DEPT_ID             => NULL
          , P_PERSON_ID           => P_CONNECT_PERSON_ID
          , P_BUDGET_DEPT_ID      => NULL
          , P_HEADER_REMARK       => C1.HEADER_REMARK
          , P_ACCOUNT_CODE        => C1.ACCOUNT_CODE
          , P_ACCOUNT_DR_CR       => C1.ACCOUNT_DR_CR
          , P_GL_AMOUNT           => C1.GL_AMOUNT
          , P_CURRENCY_CODE       => V_CURRENCY_CODE
          , P_EXCHANGE_RATE       => NULL
          , P_GL_CURRENCY_AMOUNT  => NULL
          , P_MANAGEMENT1         => C1.VENDOR_CODE
          , P_MANAGEMENT2         => NULL
          , P_REFER1              => NULL
          , P_REFER2              => NULL
          , P_REFER3              => NULL
          , P_REFER4              => NULL
          , P_REFER5              => NULL
          , P_REFER6              => NULL
          , P_REFER7              => NULL
          , P_REFER8              => NULL
          , P_REFER9              => NULL
          , P_REFER10             => NULL
          , P_REFER11             => NULL
          , P_REFER12             => NULL
          , P_VOUCH_CODE          => NULL
          , P_REFER_RATE          => NULL
          , P_REFER_AMOUNT        => NULL
          , P_REFER_DATE1         => NULL
          , P_REFER_DATE2         => NULL
          , P_REMARK              => C1.LINE_REMARK
          , P_FUND_CODE           => NULL
          , P_UNIT_PRICE          => NULL
          , P_UOM_CODE            => NULL
          , P_QUANTITY            => NULL
          , P_WEIGHT              => NULL
          , P_USER_ID             => P_USER_ID
          , O_STATUS              => O_STATUS
          , O_MESSAGE             => O_MESSAGE
          );
      END IF;
      IF O_STATUS = 'F' THEN
        ROLLBACK;
        RETURN;
      END IF;
    END LOOP C1;
    
    -- 실제 전표 생성.
    FI_SLIP_AUTO_INTERFACE_G.SET_SLIP_AUTO_INTERFACE
      ( P_MODULE_TYPE         => V_MODULE_TYPE
      , P_SLIP_DATE           => V_SLIP_DATE
      , P_SOB_ID              => P_SOB_ID
      , P_ORG_ID              => P_ORG_ID
      , P_USER_ID             => P_USER_ID
      , O_HEADER_ID           => V_HEADER_ID
      , O_SLIP_NUM            => V_SLIP_NUM
      , O_STATUS              => V_STATUS
      , O_MESSAGE             => V_MESSAGE
      );
    IF V_STATUS = 'F' THEN
      O_STATUS := V_STATUS;
      O_MESSAGE := V_MESSAGE;
      RETURN;  
    END IF;
    
    -- 급여내역에 전표정보 UPDATE.
    BEGIN
      UPDATE HRP_MONTH_PAYMENT MP
        SET MP.INTERFACE_YN = 'Y'
          , MP.INTERFACE_HEADER_ID = V_HEADER_ID
          , MP.INTERFACE_NUM = V_SLIP_NUM
          , MP.INTERFACE_PERSON_ID = P_CONNECT_PERSON_ID
          , MP.INTERFACE_DATE = V_SYSDATE
      WHERE MP.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
        AND MP.CORP_ID            = P_CORP_ID
        AND MP.SOB_ID             = P_SOB_ID
        AND MP.ORG_ID             = P_ORG_ID
        AND NVL(MP.INTERFACE_YN, 'N')       = 'N'
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := SUBSTR(SQLERRM, 1, 200);
      RETURN;
    END;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10334');
  END SET_PAYMENT_SLIP;

-- 급상여 자료 전표 취소.
  PROCEDURE CANCEL_PAYMENT_SLIP
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_USER_ID           IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_HEADER_ID                   NUMBER;
    V_SLIP_NUM                    VARCHAR2(30);
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT DISTINCT MP.INTERFACE_HEADER_ID
           , MP.INTERFACE_NUM
        INTO V_HEADER_ID, V_SLIP_NUM
        FROM HRP_MONTH_PAYMENT MP
      WHERE MP.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
        AND MP.CORP_ID            = P_CORP_ID
        AND MP.SOB_ID             = P_SOB_ID
        AND MP.ORG_ID             = P_ORG_ID
        AND NVL(MP.INTERFACE_YN, 'N')       = 'Y'
      ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := '[' || V_SLIP_NUM || '] - ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_F, 'FCM_10128');
      RETURN;
    END;
    
    -- 전표 삭제.
    FI_SLIP_AUTO_INTERFACE_G.DELETE_SLIP_INTERFACE
      ( W_HEADER_ID           => V_HEADER_ID
      , O_STATUS              => O_STATUS
      , O_MESSAGE             => O_MESSAGE
      );
    IF O_STATUS = 'F' THEN
       RETURN;  
    END IF;
    
    UPDATE HRP_MONTH_PAYMENT MP
      SET MP.INTERFACE_YN = 'N'
        , MP.INTERFACE_HEADER_ID = NULL
        , MP.INTERFACE_NUM = NULL
        , MP.INTERFACE_PERSON_ID = P_CONNECT_PERSON_ID
        , MP.INTERFACE_DATE = V_SYSDATE
    WHERE MP.PAY_YYYYMM         = P_PAY_YYYYMM
      AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
      AND MP.CORP_ID            = P_CORP_ID
      AND MP.SOB_ID             = P_SOB_ID
      AND MP.ORG_ID             = P_ORG_ID
      AND MP.INTERFACE_YN       = 'Y'
    ;
  END CANCEL_PAYMENT_SLIP;

---------------------------------------------------------------------------------------------------
-- 급상여 대상중 원가코드 누락자수 리턴.
  FUNCTION CC_NONREGISTERED_COUNT_F
            ( P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_RETURN_VALUE      NUMBER := 0;
  BEGIN
    BEGIN
      SELECT COUNT(PM.PERSON_ID) AS NONREGISTERED_COUNT
        INTO V_RETURN_VALUE
        FROM HRM_PERSON_MASTER PM
          , HRP_MONTH_PAYMENT MP
      WHERE PM.PERSON_ID          = MP.PERSON_ID
        AND MP.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MP.WAGE_TYPE          = P_WAGE_TYPE  -- 급여.
        AND MP.CORP_ID            = P_CORP_ID
        AND MP.SOB_ID             = P_SOB_ID
        AND MP.ORG_ID             = P_ORG_ID
        AND PM.COST_CENTER_ID     IS NULL
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 0;
    END;
    RETURN V_RETURN_VALUE;
  END CC_NONREGISTERED_COUNT_F;
  
END HRP_MONTH_PAYMENT_SLIP_G;
/
