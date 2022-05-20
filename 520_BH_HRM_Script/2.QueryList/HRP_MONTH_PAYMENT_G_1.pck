CREATE OR REPLACE PACKAGE HRP_MONTH_PAYMENT_G
AS

-- 월급여 자료 SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
-- 월급여 자료 SELECT
  PROCEDURE DATA_SELECT_SPREAD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );

-- 월급여 자료 삽입.
  PROCEDURE MONTH_PAYMENT_INSERT
            ( P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            );
            
-- 월급여 자료 수정.
  PROCEDURE MONTH_PAYMENT_UPDATE
            ( W_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_DESCRIPTION       IN HRP_MONTH_PAYMENT.DESCRIPTION%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            );
                          
---------------------------------------------------------------------------------------------------
-- 급상여 지급내역 조회 / 삽입 / 수정.
  PROCEDURE MONTH_ALLOWANCE_SELECT
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
-- 월급여 지급항목 INSERT
  PROCEDURE MONTH_ALLOWANCE_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , P_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE 
            );

-- 월급여 지급항목 UPDATE.
  PROCEDURE MONTH_ALLOWANCE_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE
            );

-- 월급여 지급항목 Delete.
  PROCEDURE MONTH_ALLOWANCE_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 급상여 공제내역 조회 / 삽입 / 수정.
  PROCEDURE MONTH_DEDUCTION_SELECT
            ( P_CURSOR2                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );
            
-- 월급여 공제항목 INSERT
  PROCEDURE MONTH_DEDUCTION_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            );

-- 월급여 공제항목 UPDATE.
  PROCEDURE MONTH_DEDUCTION_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE
            );

-- 월급여 공제항목 Delete.
  PROCEDURE MONTH_DEDUCTION_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );       

-- 세금 다시 계산.
  PROCEDURE TAX_UPDATE
            ( P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            );
            
-- 지급/공제 합계 처리.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            );
            
END HRP_MONTH_PAYMENT_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_MONTH_PAYMENT_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_MONTH_PAYMENT_G
/* DESCRIPTION  : 급상여 내역 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- MONTH PAYMEHNT SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT MP.PAY_YYYYMM
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(MP.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME
           , PM.NAME
           , PM.PERSON_NUM           
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID) AS PAY_TYPE_NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', MP.EMPLOYE_TYPE, MP.SOB_ID, MP.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE           
           , PM.RETIRE_DATE
           , MP.EXCEPT_TYPE
           , MP.SUPPLY_DATE
           , MP.STANDARD_DATE
           , MP.PAY_DAY
           , MP.DED_PERSON_COUNT
           , MP.PAY_AMOUNT
           , MP.DED_PAY_AMOUNT
           , MP.BONUS_AMOUNT
           , MP.DED_BONUS_AMOUNT
           , MP.TOT_SUPPLY_AMOUNT
           , MP.TOT_DED_AMOUNT
           , MP.REAL_AMOUNT
           , MP.DESCRIPTION 
           , MP.SOB_ID
           , MP.ORG_ID
           , MP.PERSON_ID
           , MP.MONTH_PAYMENT_ID
           , PM.CORP_ID
           , EAPP_USER_G.USER_NAME_F(MP.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID        = MP.PERSON_ID
        AND MP.CORP_ID          = W_CORP_ID
        AND MP.PAY_YYYYMM       = W_PAY_YYYYMM
        AND MP.WAGE_TYPE        = W_WAGE_TYPE
        AND MP.PERSON_ID        = NVL(W_PERSON_ID, MP.PERSON_ID)
        AND MP.DEPT_ID          = NVL(W_DEPT_ID, MP.DEPT_ID)
        AND MP.PAY_GRADE_ID     = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
        AND MP.SOB_ID           = W_SOB_ID
        AND MP.ORG_ID           = W_ORG_ID
      ORDER BY MP.DEPT_ID, MP.POST_ID, MP.PERSON_ID
      ;

  END DATA_SELECT;

-- 월급여 자료 SELECT
  PROCEDURE DATA_SELECT_SPREAD
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PAY_GRADE_ID                      IN HRP_MONTH_PAYMENT.PAY_GRADE_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
    V_DUTY_TYPE                   VARCHAR2(10);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
    
  BEGIN
    V_DUTY_TYPE := 'D2';
    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => W_PAY_YYYYMM
                      , W_WAGE_TYPE => W_WAGE_TYPE
                      , W_PAY_TYPE => '1'
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
                      
    OPEN P_CURSOR1 FOR
      SELECT CASE
               WHEN GROUPING(DM.DEPT_CODE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               WHEN GROUPING(PM.NAME) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10217', NULL)
               ELSE PM.NAME
             END AS NAME
           , PM.PERSON_NUM AS PERSON_NUM
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME           
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), DM.DEPT_CODE) AS DEPT_CODE
           , DECODE(GROUPING(PM.NAME), 1, TO_CHAR(NULL), DM.DEPT_NAME) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID) AS POST_NAME
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID) AS PAY_TYPE_NAME
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM-DD') AS ORI_JOIN_DATE
           , TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD') AS JOIN_DATE
           , TO_CHAR(PM.PAY_DATE, 'YYYY-MM-DD') AS PAY_DATE
           , TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD') AS RETIRE_DATE
           , MP.DIR_INDIR_TYPE
           , TO_CHAR(MP.SUPPLY_DATE, 'YYYY-MM-DD') AS SUPPLY_DATE
           , TO_CHAR(MP.STANDARD_DATE, 'YYYY-MM-DD') AS STANDARD_DATE
           , TO_CHAR(MP.PAY_RATE) AS PAY_RATE
           , TO_CHAR(MP.GRADE_STEP) AS GRADE_STEP
           , TO_CHAR(MP.LONG_YEAR) AS LONG_YEAR
           , TO_CHAR(CASE 
                      WHEN MP.PAY_TYPE IN('1', '3') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                      ELSE NULL
                     END, 'FM999,999,999,999') AS BAISC_AMOUNT
           , TO_CHAR(CASE 
                      WHEN MP.PAY_TYPE IN('2') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                      ELSE NULL
                     END, 'FM999,999,999,999') AS BAISC_DAILY_AMOUNT
           , TO_CHAR(CASE 
                      WHEN MP.PAY_TYPE IN('4') THEN HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
                      ELSE NULL
                     END, 'FM999,999,999,999') AS BAISC_TIME_AMOUNT
           , TO_CHAR(MP.GENERAL_HOURLY_AMOUNT, 'FM999,999,999,999') AS GENERAL_HOURLY_PAY_AMOUNT
           , SUM(MA.A01) AS A01               -- 지급항목.
           , SUM(MA.A02) AS A02
           , SUM(MA.A03) AS A03
           , SUM(MA.A04) AS A04
           , SUM(MA.A05) AS A05
           , SUM(MA.A06) AS A06
           , SUM(MA.A07) AS A07
           , SUM(MA.A08) AS A08
           , SUM(MA.A09) AS A09
           , SUM(MA.A10) AS A10
           , SUM(MA.A11) AS A11
           , SUM(MA.A12) AS A12
           , SUM(MA.A13) AS A13
           , SUM(MA.A14) AS A14
           , SUM(MA.A15) AS A15
           , SUM(MA.A16) AS A16
           , SUM(MA.A17) AS A17
           , SUM(MA.A18) AS A18
           , SUM(MA.A19) AS A19
           , SUM(MA.A20) AS A20
           , SUM(MA.A21) AS A21
           , SUM(MA.A22) AS A22
           , SUM(MA.A23) AS A23
           , SUM(MA.A24) AS A24
           , SUM(MA.A25) AS A25
           , SUM(MA.A26) AS A26
           , SUM(MA.A27) AS A27
           , SUM(MA.A28) AS A28
           , SUM(MA.A29) AS A29
           , SUM(MA.A30) AS A30
           , SUM(MA.A31) AS A31
           , SUM(MA.A32) AS A32
           , SUM(MA.A33) AS A33
           , SUM(MA.A34) AS A34
           , SUM(MA.A35) AS A35
           , SUM(MA.A36) AS A36
           , SUM(MA.A37) AS A37
           , SUM(MA.A38) AS A38
           , SUM(MA.A39) AS A39
           , SUM(MP.TOT_SUPPLY_AMOUNT) AS TOT_SUPPLY_AMOUNT
           , SUM(MD.D01) AS D01                -- 공제 항목.
           , SUM(MD.D02) AS D02
           , SUM(MD.D03) AS D03
           , SUM(MD.D04) AS D04
           , SUM(MD.D05) AS D05
           , SUM(MD.D06) AS D06
           , SUM(MD.D07) AS D07
           , SUM(MD.D08) AS D08
           , SUM(MD.D09) AS D09
           , SUM(MD.D10) AS D10
           , SUM(MD.D11) AS D11
           , SUM(MD.D12) AS D12
           , SUM(MD.D13) AS D13
           , SUM(MD.D14) AS D14
           , SUM(MD.D15) AS D15
           , SUM(MD.D16) AS D16
           , SUM(MD.D17) AS D17
           , SUM(MD.D18) AS D18
           , SUM(MD.D19) AS D19
           , SUM(MD.D20) AS D20
           , SUM(MD.D21) AS D21
           , SUM(MD.D22) AS D22
           , SUM(MD.D23) AS D23
           , SUM(MD.D24) AS D24
           , SUM(MD.D25) AS D25
           , SUM(MD.D26) AS D26
           , SUM(MD.D27) AS D27
           , SUM(MD.D28) AS D28
           , SUM(MD.D29) AS D29
           , SUM(MP.TOT_DED_AMOUNT) AS TOT_DED_AMOUNT 
           , SUM(MP.REAL_AMOUNT) AS REAL_AMOUNT
           , TO_CHAR(DX1.TOTAL_ATT_DAY) AS TOTAL_ATT_DAY              -- 정상근무.
           , TO_CHAR(DX1.DUTY_30) AS DUTY_30                          -- 공가.
           , TO_CHAR(DX1.S_HOLY_1_COUNT) AS S_HOLY_1_COUNT            -- 주차.
           , TO_CHAR(DX1.HOLY_1_COUNT) AS HOLY_1_COUNT                -- 유휴.
           , TO_CHAR(DX1.HOLY_0_COUNT) AS HOLY_0_COUNT                -- 무휴.
           , TO_CHAR(DX1.TOT_DED_COUNT) AS TOT_DED_COUNT              -- 미근무.
           , TO_CHAR(DX1.WEEKLY_DED_COUNT) AS WEEKLY_DED_COUNT        -- 미주차.
           , TO_CHAR(DX1.LATE_TIME) AS LATE_TIME                      -- 근태공제(지각/조퇴).
           , TO_CHAR(DX1.OVER_TIME) AS OVER_TIME                      -- 연장.
           , TO_CHAR(DX1.NIGHT_BONUS_TIME) AS NIGHT_BONUS_TIME        -- 야간.
           , TO_CHAR(DX1.HOLY_1_TIME) AS HOLY_1_TIME                  -- 유휴 근무.
           , TO_CHAR(DX1.HOLY_1_OT) AS HOLY_1_OT                      -- 유휴 연장.
           , TO_CHAR(DX1.HOLY_1_NIGHT) AS HOLY_1_NIGHT                -- 유휴 야간.
        FROM HRP_MONTH_PAYMENT MP
          , HRM_DEPT_MASTER DM
          , HRM_PERSON_MASTER PM
          , HRP_MONTH_ALLOWANCE_V MA
          , HRP_MONTH_DEDUCTION_V MD
          , (SELECT MT.PERSON_ID
                 , MT.TOTAL_ATT_DAY      -- 정상근무.
                 , MTD.DUTY_30 AS DUTY_30   -- 공가.
                 , HRD_WORK_CALENDAR_G.HOLY_1_COUNT_F(MT.PERSON_ID, V_START_DATE, V_END_DATE, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT   -- 주차.
                 , MT.HOLY_1_COUNT                                    -- 유휴.
                 , MT.HOLY_0_COUNT                                    -- 무휴.
                 , MT.LATE_DED_COUNT                                  -- 근태공제 횟수.
                 , NVL(MT.TOTAL_DED_DAY, 0) - NVL(MT.WEEKLY_DED_COUNT, 0) AS TOT_DED_COUNT               -- 미근무.
                 , MT.WEEKLY_DED_COUNT                                                                   -- 미주차.
                 , NVL(MTO.LEAVE_TIME, 0) + NVL(MTO.LATE_TIME, 0) AS LATE_TIME  -- 근태공제(지각/조퇴).
                 , NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0) + NVL(MTO.HOLY_0_OT, 0) AS OVER_TIME   -- 연장.
                 , NVL(MTO.NIGHT_BONUS_TIME, 0) + NVL(MTO.HOLY_0_NIGHT, 0) AS NIGHT_BONUS_TIME   -- 야간.
                 , NVL(MTO.HOLIDAY_TIME, 0) AS HOLY_1_TIME            -- 유휴 근무.
                 , NVL(MTO.HOLY_1_OT, 0) AS HOLY_1_OT                 -- 유휴 연장.
                 , NVL(MTO.HOLY_1_NIGHT, 0) AS HOLY_1_NIGHT           -- 유휴 야간.
              FROM HRD_MONTH_TOTAL MT
                , HRD_MONTH_TOTAL_OT_V MTO
                , HRD_MONTH_TOTAL_DUTY_V MTD
            WHERE MT.MONTH_TOTAL_ID           = MTO.MONTH_TOTAL_ID(+)
              AND MT.MONTH_TOTAL_ID           = MTD.MONTH_TOTAL_ID(+)
              AND MT.DUTY_TYPE               = V_DUTY_TYPE
              AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
              AND MT.PERSON_ID               = NVL(W_PERSON_ID, MT.PERSON_ID)
              AND MT.CORP_ID                 = W_CORP_ID
              AND MT.SOB_ID                  = W_SOB_ID
              AND MT.ORG_ID                  = W_ORG_ID
            ) DX1
       WHERE MP.DEPT_ID                 = DM.DEPT_ID
         AND MP.PERSON_ID               = PM.PERSON_ID
         AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID(+)
         AND MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID(+)
         AND MP.PERSON_ID               = DX1.PERSON_ID(+)
         AND MP.PERSON_ID               = NVL(W_PERSON_ID, MP.PERSON_ID)
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = NVL(W_WAGE_TYPE, MP.WAGE_TYPE)
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.DEPT_ID                 = NVL(W_DEPT_ID, MP.DEPT_ID)
         AND MP.PAY_GRADE_ID            = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID 
      GROUP BY ROLLUP((DM.DEPT_CODE
           , DM.DEPT_NAME)
           , (PM.NAME
           , PM.PERSON_NUM
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID)
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID)
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID)
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID)
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , MP.DIR_INDIR_TYPE
           , MP.SUPPLY_DATE
           , MP.STANDARD_DATE
           , MP.PAY_RATE
           , MP.GRADE_STEP
           , MP.LONG_YEAR
           , HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
           , MP.GENERAL_HOURLY_AMOUNT
           , DX1.TOTAL_ATT_DAY
           , DX1.DUTY_30 
           , DX1.S_HOLY_1_COUNT
           , DX1.HOLY_1_COUNT
           , DX1.HOLY_0_COUNT 
           , DX1.TOT_DED_COUNT
           , DX1.WEEKLY_DED_COUNT
           , DX1.LATE_TIME
           , DX1.OVER_TIME 
           , DX1.NIGHT_BONUS_TIME
           , DX1.HOLY_1_TIME
           , DX1.HOLY_1_OT
           , DX1.HOLY_1_NIGHT
           ))
      ;
  
  END DATA_SELECT_SPREAD;
  
-- 월급여 자료 삽입.
  PROCEDURE MONTH_PAYMENT_INSERT
            ( P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    NULL;
    
  END MONTH_PAYMENT_INSERT;
  
-- 월급여 자료 수정.
  PROCEDURE MONTH_PAYMENT_UPDATE
            ( W_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_DESCRIPTION       IN HRP_MONTH_PAYMENT.DESCRIPTION%TYPE
            , P_USER_ID           IN HRP_MONTH_PAYMENT.CREATED_BY%TYPE 
            )
  AS
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
        
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_SOB_ID                      HRP_MONTH_PAYMENT.SOB_ID%TYPE;
    V_ORG_ID                      HRP_MONTH_PAYMENT.ORG_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_SOB_ID, V_ORG_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W2
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_PERIOD_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => V_SOB_ID
                                  , W_ORG_ID => V_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
                                            
    UPDATE HRP_MONTH_PAYMENT
      SET DESCRIPTION       = P_DESCRIPTION
        , LAST_UPDATE_DATE  = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID;
  
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_PAYMENT_UPDATE;
   
---------------------------------------------------------------------------------------------------
-- 급상여 지급내역 조회 / 삽입 / 수정.
  PROCEDURE MONTH_ALLOWANCE_SELECT
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT MA.PERSON_ID
           , MA.PAY_YYYYMM
           , MA.WAGE_TYPE
           , MA.CORP_ID
           , MA.ALLOWANCE_ID
           , HRM_COMMON_G.ID_NAME_F(MA.ALLOWANCE_ID) AS ALLOWANCE_NAME
           , MA.ALLOWANCE_AMOUNT
           , MA.MONTH_PAYMENT_ID
           , MA.CREATED_FLAG
        FROM HRP_MONTH_ALLOWANCE MA
       WHERE MA.CORP_ID                 = W_CORP_ID
         AND MA.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MA.WAGE_TYPE               = W_WAGE_TYPE
         AND MA.PERSON_ID               = W_PERSON_ID   
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
     ;
     
  END MONTH_ALLOWANCE_SELECT;
  
-- 월급여 지급항목 INSERT
  PROCEDURE MONTH_ALLOWANCE_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_ALLOWANCE.CORP_ID%TYPE
            , P_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_RECORD_COUNT                NUMBER := 0;
  BEGIN
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => P_CORP_ID
                                  , W_CLOSING_YYYYMM => P_PAY_YYYYMM
                                  , W_CLOSING_TYPE => P_WAGE_TYPE
                                  , W_SOB_ID => P_SOB_ID
                                  , W_ORG_ID => P_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    BEGIN
      SELECT COUNT(MA.ALLOWANCE_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRP_MONTH_ALLOWANCE MA
       WHERE MA.CORP_ID                 = P_CORP_ID
         AND MA.PAY_YYYYMM              = P_PAY_YYYYMM
         AND MA.WAGE_TYPE               = P_WAGE_TYPE         
         AND MA.PERSON_ID               = P_PERSON_ID
         AND MA.ALLOWANCE_ID            = P_ALLOWANCE_ID   
         AND MA.SOB_ID                  = P_SOB_ID
         AND MA.ORG_ID                  = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Exist_Data;
    END;

    INSERT INTO HRP_MONTH_ALLOWANCE
    ( PERSON_ID
    , PAY_YYYYMM 
    , WAGE_TYPE 
    , CORP_ID 
    , ALLOWANCE_ID 
    , ALLOWANCE_AMOUNT 
    , MONTH_PAYMENT_ID 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_PERSON_ID
    , P_PAY_YYYYMM
    , P_WAGE_TYPE
    , P_CORP_ID
    , P_ALLOWANCE_ID
    , P_ALLOWANCE_AMOUNT
    , P_MONTH_PAYMENT_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    -- TAX-UPATE --
    TAX_UPDATE
            ( P_PAY_YYYYMM       => P_PAY_YYYYMM
            , P_WAGE_TYPE        => P_WAGE_TYPE
            , P_CORP_ID          => P_CORP_ID
            , P_PERSON_ID        => P_PERSON_ID
            , P_SOB_ID           => P_SOB_ID
            , P_ORG_ID           => P_ORG_ID
            , P_USER_ID          => P_USER_ID 
            );
            
    -- 합계.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => P_MONTH_PAYMENT_ID
            , P_CORP_ID           => P_CORP_ID
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_WAGE_TYPE         => P_WAGE_TYPE
            , P_PERSON_ID         => P_PERSON_ID
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            );
            
  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_ALLOWANCE_INSERT;

-- 월급여 지급항목 UPDATE.
  PROCEDURE MONTH_ALLOWANCE_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_MONTH_ALLOWANCE.ALLOWANCE_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_ALLOWANCE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID        
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
         AND MP.SOB_ID            = W_SOB_ID
         AND MP.ORG_ID            = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => W_SOB_ID
                                  , W_ORG_ID => W_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    UPDATE HRP_MONTH_ALLOWANCE MA
      SET MA.ALLOWANCE_AMOUNT = P_ALLOWANCE_AMOUNT
        , MA.LAST_UPDATE_DATE = V_SYSDATE
        , MA.LAST_UPDATED_BY  = P_USER_ID
     WHERE MA.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
       AND MA.ALLOWANCE_ID            = W_ALLOWANCE_ID
       AND MA.SOB_ID                  = W_SOB_ID
       AND MA.ORG_ID                  = W_ORG_ID
    ;
        
    -- TAX-UPATE --
    TAX_UPDATE
            ( P_PAY_YYYYMM       => V_PAY_YYYYMM
            , P_WAGE_TYPE        => V_WAGE_TYPE
            , P_CORP_ID          => V_CORP_ID
            , P_PERSON_ID        => V_PERSON_ID
            , P_SOB_ID           => W_SOB_ID
            , P_ORG_ID           => W_ORG_ID
            , P_USER_ID          => P_USER_ID 
            );
            
    -- 합계.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => W_MONTH_PAYMENT_ID
            , P_CORP_ID           => V_CORP_ID
            , P_PAY_YYYYMM        => V_PAY_YYYYMM
            , P_WAGE_TYPE         => V_WAGE_TYPE
            , P_PERSON_ID         => V_PERSON_ID
            , P_SOB_ID            => W_SOB_ID
            , P_ORG_ID            => W_ORG_ID
            );
            
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_ALLOWANCE_UPDATE;

-- 월급여 지급항목 Delete.
  PROCEDURE MONTH_ALLOWANCE_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_ALLOWANCE.MONTH_PAYMENT_ID%TYPE
            , W_ALLOWANCE_ID     IN HRP_MONTH_ALLOWANCE.ALLOWANCE_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
    V_SOB_ID                      HRP_MONTH_PAYMENT.SOB_ID%TYPE;
    V_ORG_ID                      HRP_MONTH_PAYMENT.ORG_ID%TYPE;
    V_USER_ID                     HRP_MONTH_PAYMENT.CREATED_BY%TYPE;
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID, MP.CREATED_BY
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID, V_SOB_ID, V_ORG_ID, V_USER_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => V_SOB_ID
                                  , W_ORG_ID => V_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    DELETE HRP_MONTH_ALLOWANCE MA
       WHERE MA.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
         AND MA.ALLOWANCE_ID            = W_ALLOWANCE_ID
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
    ;
    
    -- TAX UPDATE --
    TAX_UPDATE
            ( P_PAY_YYYYMM       => V_PAY_YYYYMM
            , P_WAGE_TYPE        => V_WAGE_TYPE
            , P_CORP_ID          => V_CORP_ID
            , P_PERSON_ID        => V_PERSON_ID
            , P_SOB_ID           => V_SOB_ID
            , P_ORG_ID           => V_ORG_ID
            , P_USER_ID          => V_USER_ID 
            );
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_ALLOWANCE_DELETE;

---------------------------------------------------------------------------------------------------
-- 급상여 공제내역 조회 / 삽입 / 수정.
  PROCEDURE MONTH_DEDUCTION_SELECT
            ( P_CURSOR2                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT MD.PERSON_ID
           , MD.PAY_YYYYMM
           , MD.WAGE_TYPE
           , MD.CORP_ID
           , MD.DEDUCTION_ID
           , HRM_COMMON_G.ID_NAME_F(MD.DEDUCTION_ID) AS DEDUCTION_NAME
           , MD.DEDUCTION_AMOUNT
           , MD.MONTH_PAYMENT_ID
           , MD.CREATED_FLAG
        FROM HRP_MONTH_DEDUCTION MD
       WHERE MD.CORP_ID                 = W_CORP_ID
         AND MD.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MD.WAGE_TYPE               = W_WAGE_TYPE
         AND MD.PERSON_ID               = W_PERSON_ID   
         AND MD.SOB_ID                  = W_SOB_ID
         AND MD.ORG_ID                  = W_ORG_ID
     ;
  
  END MONTH_DEDUCTION_SELECT;
              
-- 월급여 공제항목 INSERT
  PROCEDURE MONTH_DEDUCTION_INSERT
            ( P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_RECORD_COUNT                NUMBER := 0;
    
  BEGIN
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => P_CORP_ID
                                  , W_CLOSING_YYYYMM => P_PAY_YYYYMM
                                  , W_CLOSING_TYPE => P_WAGE_TYPE
                                  , W_SOB_ID => P_SOB_ID
                                  , W_ORG_ID => P_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    BEGIN
      SELECT COUNT(MD.DEDUCTION_ID) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRP_MONTH_DEDUCTION MD
       WHERE MD.CORP_ID                 = P_CORP_ID
         AND MD.PAY_YYYYMM              = P_PAY_YYYYMM
         AND MD.WAGE_TYPE               = P_WAGE_TYPE
         AND MD.PERSON_ID               = P_PERSON_ID   
         AND MD.DEDUCTION_ID            = P_DEDUCTION_ID
         AND MD.SOB_ID                  = P_SOB_ID
         AND MD.ORG_ID                  = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Exist_Data;
    END;

    INSERT INTO HRP_MONTH_DEDUCTION
    ( PERSON_ID
    , PAY_YYYYMM 
    , WAGE_TYPE 
    , CORP_ID 
    , DEDUCTION_ID 
    , DEDUCTION_AMOUNT 
    , MONTH_PAYMENT_ID 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_PERSON_ID
    , P_PAY_YYYYMM
    , P_WAGE_TYPE
    , P_CORP_ID
    , P_DEDUCTION_ID
    , P_DEDUCTION_AMOUNT
    , P_MONTH_PAYMENT_ID
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
    -- 합계.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => P_MONTH_PAYMENT_ID
            , P_CORP_ID           => P_CORP_ID
            , P_PAY_YYYYMM        => P_PAY_YYYYMM
            , P_WAGE_TYPE         => P_WAGE_TYPE
            , P_PERSON_ID         => P_PERSON_ID
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            );
            
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);  
  END MONTH_DEDUCTION_INSERT;

-- 월급여 공제항목 UPDATE.
  PROCEDURE MONTH_DEDUCTION_UPDATE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRP_MONTH_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_PERSON_ID                   HRP_MONTH_PAYMENT.PERSON_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.PERSON_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_PERSON_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => W_SOB_ID
                                  , W_ORG_ID => W_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    UPDATE HRP_MONTH_DEDUCTION MD
      SET MD.DEDUCTION_AMOUNT = P_DEDUCTION_AMOUNT
        , MD.LAST_UPDATE_DATE = V_SYSDATE
        , MD.LAST_UPDATED_BY  = P_USER_ID
     WHERE MD.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
       AND MD.DEDUCTION_ID            = W_DEDUCTION_ID
       AND MD.SOB_ID                  = W_SOB_ID
       AND MD.ORG_ID                  = W_ORG_ID
    ;
    
    -- 합계.
    PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  => W_MONTH_PAYMENT_ID
            , P_CORP_ID           => V_CORP_ID
            , P_PAY_YYYYMM        => V_PAY_YYYYMM
            , P_WAGE_TYPE         => V_WAGE_TYPE
            , P_PERSON_ID         => V_PERSON_ID
            , P_SOB_ID            => W_SOB_ID
            , P_ORG_ID            => W_ORG_ID
            );
            
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_DEDUCTION_UPDATE;

-- 월급여 공제항목 Delete.
  PROCEDURE MONTH_DEDUCTION_DELETE
            ( W_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , W_DEDUCTION_ID     IN HRP_MONTH_DEDUCTION.DEDUCTION_ID%TYPE
            , W_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
    V_CLOSE_FLAG                  VARCHAR2(2) := 'F';
    V_CORP_ID                     HRP_MONTH_PAYMENT.CORP_ID%TYPE;
    V_PAY_YYYYMM                  HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE;
    V_WAGE_TYPE                   HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE;
    V_SOB_ID                      HRP_MONTH_PAYMENT.SOB_ID%TYPE;
    V_ORG_ID                      HRP_MONTH_PAYMENT.ORG_ID%TYPE;
    
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE, V_SOB_ID, V_ORG_ID
        FROM HRP_MONTH_PAYMENT MP
       WHERE MP.MONTH_PAYMENT_ID  = W_MONTH_PAYMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    
    V_CLOSE_FLAG := HRM_CLOSING_G.CLOSING_CHECK_W
                                  ( W_CORP_ID => V_CORP_ID
                                  , W_CLOSING_YYYYMM => V_PAY_YYYYMM
                                  , W_CLOSING_TYPE => V_WAGE_TYPE
                                  , W_SOB_ID => V_SOB_ID
                                  , W_ORG_ID => V_ORG_ID);
    IF V_CLOSE_FLAG = 'F' THEN
      RAISE ERRNUMS.Closed_Not_Create;
    ELSIF V_CLOSE_FLAG = 'Y' THEN
      RAISE ERRNUMS.Data_Closed;
    END IF;
    
    DELETE HRP_MONTH_DEDUCTION MD
       WHERE MD.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
         AND MD.DEDUCTION_ID            = W_DEDUCTION_ID
         AND MD.SOB_ID                  = W_SOB_ID
         AND MD.ORG_ID                  = W_ORG_ID
      ;
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
    WHEN ERRNUMS.Closed_Not_Create THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Closed_Not_Create_Code, ERRNUMS.Closed_Not_Create_Desc);
    WHEN ERRNUMS.Data_Closed THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END MONTH_DEDUCTION_DELETE;   

-- 세금 다시 계산.
  PROCEDURE TAX_UPDATE
            ( P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            )
  AS
    V_TAX_DEDUCTION_ID            NUMBER;
    V_RESIDENT_DEDUCTION_ID       NUMBER;
  BEGIN
    -- 소득세/주민세 공제ID 조회--
    BEGIN
      SELECT MAX(DECODE(HD.DEDUCTION_TYPE, 'TAX', HD.DEDUCTION_ID, NULL)) AS TAX_DEDUCTION_ID
           , MAX(DECODE(HD.DEDUCTION_TYPE, 'RESIDENT', HD.DEDUCTION_ID, NULL)) AS RESIDENT_DEDUCTION_ID
        INTO V_TAX_DEDUCTION_ID, V_RESIDENT_DEDUCTION_ID
        FROM HRM_DEDUCTION_V HD
       WHERE HD.DEDUCTION_TYPE    IN ('TAX', 'RESIDENT')
         AND HD.SOB_ID            = P_SOB_ID
         AND HD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Deduction ID(TAX) Error : '  || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10114', NULL));
    END;
    -- TAX 초기화 --
    BEGIN
      UPDATE HRP_MONTH_DEDUCTION MD
          SET MD.DEDUCTION_AMOUNT = 0
       WHERE MD.PERSON_ID         = P_PERSON_ID
         AND MD.PAY_YYYYMM        = P_PAY_YYYYMM
         AND MD.WAGE_TYPE         = P_WAGE_TYPE
         AND MD.CORP_ID           = P_CORP_ID
         AND MD.DEDUCTION_ID      IN(V_TAX_DEDUCTION_ID, V_RESIDENT_DEDUCTION_ID)
         AND MD.SOB_ID            = P_SOB_ID
         AND MD.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    
    IF P_WAGE_TYPE IN ('P2', 'P5') THEN
      -- 상여금.
      HRP_MONTH_BONUS_G_SET.TAX_CREATION
          ( P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_PAY_TYPE          => NULL
          , P_DEPT_ID           => NULL
          , P_PERSON_ID         => P_PERSON_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          );
    ELSE
      -- 상여 이외.    
      HRP_MONTH_PAYMENT_G_SET.TAX_CREATION
          ( P_CORP_ID           => P_CORP_ID
          , P_PAY_YYYYMM        => P_PAY_YYYYMM
          , P_WAGE_TYPE         => P_WAGE_TYPE
          , P_PAY_TYPE          => NULL
          , P_DEPT_ID           => NULL
          , P_PERSON_ID         => P_PERSON_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          );
    END IF;
  END TAX_UPDATE;
  
-- 지급/공제 합계 처리.
  PROCEDURE PAYMENT_SUMMARY_UPDATE
            ( P_MONTH_PAYMENT_ID  IN HRP_MONTH_PAYMENT.MONTH_PAYMENT_ID%TYPE
            , P_CORP_ID           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , P_PAY_YYYYMM        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRP_MONTH_PAYMENT.WAGE_TYPE%TYPE
            , P_PERSON_ID         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , P_SOB_ID            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS    
  BEGIN
      -- 지급 항목 합계 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.PAY_AMOUNT, MP.BONUS_AMOUNT, MP.TOT_SUPPLY_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(DECODE(MA.WAGE_TYPE, 'P1', MA.ALLOWANCE_AMOUNT, 0)), 0) AS PAY_AMOUNT
                   , NVL(SUM(DECODE(MA.WAGE_TYPE, 'P2', MA.ALLOWANCE_AMOUNT, 0)), 0) AS BONUS_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS TOTAL_SUPPLY_AMOUNT
                   , NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_ALLOWANCE MA
               WHERE MA.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MA.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = P_MONTH_PAYMENT_ID
      ;
      
      -- 공제 항목 합계 UPDATE --
      UPDATE HRP_MONTH_PAYMENT MP
        SET (MP.DED_PAY_AMOUNT, MP.DED_BONUS_AMOUNT, MP.TOT_DED_AMOUNT, MP.REAL_AMOUNT)
          = ( SELECT NVL(SUM(DECODE(MD.WAGE_TYPE, 'P1', MD.DEDUCTION_AMOUNT, 0)), 0) AS DED_PAY_AMOUNT
                   , NVL(SUM(DECODE(MD.WAGE_TYPE, 'P2', MD.DEDUCTION_AMOUNT, 0)), 0) AS DED_BONUS_AMOUNT
                   , NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS TOTAL_DED_AMOUNT
                   , NVL(MP.TOT_SUPPLY_AMOUNT, 0) - NVL(SUM(MD.DEDUCTION_AMOUNT), 0) AS REAL_AMOUNT
                FROM HRP_MONTH_DEDUCTION MD
               WHERE MD.MONTH_PAYMENT_ID        = MP.MONTH_PAYMENT_ID
              GROUP BY MD.MONTH_PAYMENT_ID
            )
      WHERE MP.MONTH_PAYMENT_ID   = P_MONTH_PAYMENT_ID
      ;
  
  END PAYMENT_SUMMARY_UPDATE;
  
END HRP_MONTH_PAYMENT_G;
/
