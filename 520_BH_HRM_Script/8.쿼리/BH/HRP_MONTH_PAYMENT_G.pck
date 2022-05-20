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

-- TAX UPDATE.
  PROCEDURE TAX_UPDATE
            ( P_TOTAL_AMOUNT     IN NUMBER
            , P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
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
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT CASE
               WHEN GROUPING(MP.DEPT_ID) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               ELSE PM.NAME
             END AS NAME
           , PM.PERSON_NUM AS PERSON_NUM
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID) AS WAGE_TYPE_NAME
           , MP.MONTH_PAYMENT_ID
           , MP.PERSON_ID
           , MP.CORP_ID
           , MP.DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(MP.DEPT_ID) AS DEPT_NAME
           , MP.POST_ID
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID) AS POST_NAME
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID) AS PAY_TYPE_NAME
           , MP.PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID) AS PAY_GRADE_NAME
           , MP.COST_CENTER_ID
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
           , HRP_PAYMENT_G_SET.BASIC_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID) AS BAISC_AMOUNT
           , HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID) AS GENERAL_HOURLY_PAY_AMOUNT
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
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
          , HRP_MONTH_ALLOWANCE_V MA
          , HRP_MONTH_DEDUCTION_V MD
       WHERE MP.PERSON_ID               = PM.PERSON_ID
         AND MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID(+)
         AND MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID(+)
         AND MP.PERSON_ID               = NVL(W_PERSON_ID, MP.PERSON_ID)
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = NVL(W_WAGE_TYPE, MP.WAGE_TYPE)
         AND MP.CORP_ID                 = W_CORP_ID
         AND MP.DEPT_ID                 = NVL(W_DEPT_ID, MP.DEPT_ID)
         AND MP.PAY_GRADE_ID            = NVL(W_PAY_GRADE_ID, MP.PAY_GRADE_ID)
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
      GROUP BY ROLLUP((MP.DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(MP.DEPT_ID)
           , MP.MONTH_PAYMENT_ID
           , MP.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM
           , MP.PAY_YYYYMM
           , MP.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', MP.WAGE_TYPE, MP.SOB_ID, MP.ORG_ID)
           , MP.CORP_ID
           , MP.POST_ID
           , HRM_COMMON_G.ID_NAME_F(MP.POST_ID)
           , MP.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', MP.PAY_TYPE, MP.SOB_ID, MP.ORG_ID)
           , MP.PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(MP.PAY_GRADE_ID)
           , MP.COST_CENTER_ID
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
           , HRP_PAYMENT_G_SET.GENERAL_HOURLY_PAY_AMOUNT_F(MP.PAY_YYYYMM, MP.PERSON_ID, MP.SOB_ID, MP.ORG_ID)
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
    V_TOTAL_AMOUNT                NUMBER := 0;
    
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
    
    -- 총합계.
    BEGIN
      SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_MOUNT
        INTO V_TOTAL_AMOUNT
        FROM HRP_MONTH_ALLOWANCE MA
      WHERE MA.PAY_YYYYMM         = P_PAY_YYYYMM
        AND MA.WAGE_TYPE          = P_WAGE_TYPE
        AND MA.PERSON_ID          = P_PERSON_ID
        AND MA.CORP_ID            = P_CORP_ID
        AND MA.SOB_ID             = P_SOB_ID
        AND MA.ORG_ID             = P_ORG_ID
      GROUP BY MA.PERSON_ID
          , MA.PAY_YYYYMM
          , MA.WAGE_TYPE
          , MA.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TOTAL_AMOUNT := P_ALLOWANCE_AMOUNT;
    END;
    -- TAX_UPDATE.
    TAX_UPDATE( P_TOTAL_AMOUNT     => V_TOTAL_AMOUNT
              , P_PERSON_ID        => P_PERSON_ID
              , P_PAY_YYYYMM       => P_PAY_YYYYMM
              , P_WAGE_TYPE        => P_WAGE_TYPE
              , P_CORP_ID          => P_CORP_ID
              , P_MONTH_PAYMENT_ID => P_MONTH_PAYMENT_ID
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
    V_TOTAL_AMOUNT                NUMBER := 0;
    
  BEGIN
    BEGIN
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE
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
    
    -- 총합계.
    BEGIN
      SELECT SUM(MA.ALLOWANCE_AMOUNT) AS TOTAL_MOUNT
        INTO V_TOTAL_AMOUNT
        FROM HRP_MONTH_ALLOWANCE MA
      WHERE MA.PAY_YYYYMM         = V_PAY_YYYYMM
        AND MA.WAGE_TYPE          = V_WAGE_TYPE
        AND MA.PERSON_ID          = V_PERSON_ID
        AND MA.CORP_ID            = V_CORP_ID
        AND MA.SOB_ID             = W_SOB_ID
        AND MA.ORG_ID             = W_ORG_ID
      GROUP BY MA.PERSON_ID
          , MA.PAY_YYYYMM
          , MA.WAGE_TYPE
          , MA.CORP_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TOTAL_AMOUNT := P_ALLOWANCE_AMOUNT;
    END;
    
    -- TAX_UPDATE.
    TAX_UPDATE( P_TOTAL_AMOUNT     => V_TOTAL_AMOUNT
              , P_PERSON_ID        => V_PERSON_ID
              , P_PAY_YYYYMM       => V_PAY_YYYYMM
              , P_WAGE_TYPE        => V_WAGE_TYPE
              , P_CORP_ID          => V_CORP_ID
              , P_MONTH_PAYMENT_ID => W_MONTH_PAYMENT_ID
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

    DELETE HRP_MONTH_ALLOWANCE MA
       WHERE MA.MONTH_PAYMENT_ID        = W_MONTH_PAYMENT_ID
         AND MA.ALLOWANCE_ID            = W_ALLOWANCE_ID
         AND MA.SOB_ID                  = W_SOB_ID
         AND MA.ORG_ID                  = W_ORG_ID
      ;
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
      SELECT MP.CORP_ID, MP.PAY_YYYYMM, MP.WAGE_TYPE
        INTO V_CORP_ID, V_PAY_YYYYMM, V_WAGE_TYPE
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

/*---------------------------------------------------------------------------------------------------
-- PAYMENT TERM(START_YYYYMM ~ END_YYYYMM) SELECT
  PROCEDURE PAYMENT_TERM_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_MONTH_PAYMENT.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_MONTH_PAYMENT.PAY_YYYYMM%TYPE
            , W_DEPT_ID                           IN HRP_MONTH_PAYMENT.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_MONTH_PAYMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_MONTH_PAYMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_MONTH_PAYMENT.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HMP.PAY_YYYYMM
           , NVL(SUM(HMP.PAY_AMOUNT), 0) AS PAY_AMOUNT
           , NVL(SUM(HMP.BONUS_AMOUNT), 0) AS BONUS_AMOUNT
           , NVL(SUM(HMP.TOT_SUPPLY_AMOUNT), 0) AS TOT_SUPPLY_AMOUNT
           , NVL(SUM(HMD.PENSION_INSUR), 0) AS PENSION_INSUR
           , NVL(SUM(HMD.HEALTH_INSUR), 0) AS HEALTH_INSUR
           , NVL(SUM(HMD.EMPLOYMENT_INSUR), 0) AS EMPLOYMENT_INSUR
           , NVL(SUM(HMD.INCOME_TAX), 0) AS INCOME_TAX
           , NVL(SUM(HMD.RESIDENTS_TAX), 0) AS RESIDENTS_TAX
           , NVL(SUM(HMP.DED_PAY_AMOUNT), 0) AS DED_PAY_AMOUNT
           , NVL(SUM(HMP.DED_BONUS_AMOUNT), 0) AS DED_BONUS_AMOUNT
           , NVL(SUM(HMP.TOT_DED_AMOUNT), 0) AS TOT_DED_AMOUNT
           , NVL(SUM(HMP.REAL_AMOUNT), 0) AS REAL_AMOUNT
        FROM HRP_MONTH_PAYMENT HMP
          , HRM_CLOSING_TYPE_V CT
          , ( SELECT MD.MONTH_PAYMENT_ID
                   , MD.DEDUCTION_ID
                   , DV.DEDUCTION_CODE
                   , DV.DEDUCTION_NAME
                   , DECODE(DV.DEDUCTION_CODE, 'D01', MD.DEDUCTION_AMOUNT, 0) AS INCOME_TAX       -- 소득세.
                   , DECODE(DV.DEDUCTION_CODE, 'D02', MD.DEDUCTION_AMOUNT, 0) AS RESIDENTS_TAX    -- 주민세.
                   , DECODE(DV.DEDUCTION_CODE, 'D03', MD.DEDUCTION_AMOUNT, 0) AS PENSION_INSUR    -- 국민연금.
                   , DECODE(DV.DEDUCTION_CODE, 'D04', MD.DEDUCTION_AMOUNT, 0) AS EMPLOYMENT_INSUR -- 고용보험.
                   , DECODE(DV.DEDUCTION_CODE, 'D05', MD.DEDUCTION_AMOUNT, 0) AS HEALTH_INSUR     -- 건강보험.
                FROM HRP_MONTH_DEDUCTION MD
                  , HRM_DEDUCTION_V DV
               WHERE MD.DEDUCTION_ID  = DV.DEDUCTION_ID
                 AND MD.PAY_YYYYMM    BETWEEN W_START_YYYYMM AND W_END_YYYYMM
                 AND MD.CORP_ID       = W_CORP_ID
                 AND MD.PERSON_ID     = W_PERSON_ID
                 AND MD.SOB_ID        = W_SOB_ID
                 AND MD.ORG_ID        = W_ORG_ID
            ) HMD
       WHERE HMP.WAGE_TYPE            = CT.CLOSING_TYPE
         AND HMP.MONTH_PAYMENT_ID     = HMD.MONTH_PAYMENT_ID(+)
         AND HMP.PERSON_ID            = W_PERSON_ID
         AND HMP.PAY_YYYYMM           BETWEEN W_START_YYYYMM AND W_END_YYYYMM
         AND HMP.CORP_ID              = W_CORP_ID
         AND HMP.DEPT_ID              = NVL(W_DEPT_ID, HMP.DEPT_ID)
         AND HMP.SOB_ID               = W_SOB_ID
         AND HMP.ORG_ID               = W_ORG_ID
         AND CT.MODULE_TYPE           = 'PAY'
         AND CT.PERIOD_TYPE           IN('PAY', 'BONUS', 'DANGJIK')
      GROUP BY HMP.PAY_YYYYMM, HMP.PERSON_ID
      ;

  END PAYMENT_TERM_SELECT;*/


-- TAX UPDATE.
  PROCEDURE TAX_UPDATE
            ( P_TOTAL_AMOUNT     IN NUMBER
            , P_PERSON_ID        IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , P_PAY_YYYYMM       IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , P_CORP_ID          IN HRP_MONTH_DEDUCTION.CORP_ID%TYPE
            , P_MONTH_PAYMENT_ID IN HRP_MONTH_DEDUCTION.MONTH_PAYMENT_ID%TYPE
            , P_SOB_ID           IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRP_MONTH_DEDUCTION.CREATED_BY%TYPE 
            )
  AS
    V_STD_DATE                  DATE;
    V_RESIDENT_TAX_RATE         NUMBER := 0;
    V_SUPPORT_FAMILY            NUMBER := 0;
    V_TAX_DEDUCTION_ID          NUMBER;    
    V_TAX_AMOUNT                NUMBER := 0;
    V_RESIDENT_DEDUCTION_ID     NUMBER;
  BEGIN
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
    
    -- 기준일자 조회.
    BEGIN
      SELECT MP.STANDARD_DATE
        INTO V_STD_DATE
        FROM HRP_MONTH_PAYMENT MP
      WHERE MP.MONTH_PAYMENT_ID       = P_MONTH_PAYMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_STD_DATE := TRUNC(SYSDATE);
    END;
    
    -- 부양가족수.
    BEGIN
      SELECT COUNT(HF.PERSON_ID) AS FAMILY_COUNT
        INTO V_SUPPORT_FAMILY
        FROM HRM_FAMILY HF
      WHERE HF.PERSON_ID              = P_PERSON_ID
        AND HF.TAX_YN                 = 'Y'
      GROUP BY HF.PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SUPPORT_FAMILY := 0;
    END;
    -- 주민세율.
    V_RESIDENT_TAX_RATE := HRM_COMMON_G.TAX_RATE_F( W_TAX_CODE => 'RESIDENT'
                                                  , W_SOB_ID => P_SOB_ID
                                                  , W_ORG_ID => P_ORG_ID
                                                  );
    
    -- 소득세.
    V_TAX_AMOUNT := HRP_PAYMENT_G_SET.TAX_AMOUNT_F
                    ( W_STD_DATE          => V_STD_DATE
                    , W_TOTAL_AMOUNT      => P_TOTAL_AMOUNT
                    , W_SUPPORT_FAMILY    => V_SUPPORT_FAMILY
                    , W_SOB_ID            => P_SOB_ID
                    , W_ORG_ID            => P_ORG_ID
                    );
                        
    IF V_TAX_AMOUNT <> 0 THEN
      -- 기존자료 삭제.
      MONTH_ALLOWANCE_DELETE
            ( W_MONTH_PAYMENT_ID => P_MONTH_PAYMENT_ID
            , W_ALLOWANCE_ID     => V_TAX_DEDUCTION_ID
            , W_SOB_ID           => P_SOB_ID
            , W_ORG_ID           => P_ORG_ID
            );
      
      -- INSERT.
      HRP_MONTH_PAYMENT_G.MONTH_DEDUCTION_INSERT
            ( P_PERSON_ID
            , P_PAY_YYYYMM
            , P_WAGE_TYPE
            , P_CORP_ID
            , V_TAX_DEDUCTION_ID
            , DECIMAL_F(P_SOB_ID, P_ORG_ID, V_TAX_AMOUNT, 'PAYMENT')
            , P_MONTH_PAYMENT_ID
            , P_SOB_ID
            , P_ORG_ID
            , P_USER_ID 
            );
    END IF;
    
    -- 소득세.
    V_TAX_AMOUNT := NVL(V_TAX_AMOUNT, 0) * (V_RESIDENT_TAX_RATE / 100);
    IF V_TAX_AMOUNT <> 0 THEN
      -- 기존자료 삭제.
      MONTH_ALLOWANCE_DELETE
            ( W_MONTH_PAYMENT_ID => P_MONTH_PAYMENT_ID
            , W_ALLOWANCE_ID     => V_RESIDENT_DEDUCTION_ID
            , W_SOB_ID           => P_SOB_ID
            , W_ORG_ID           => P_ORG_ID
            );
      
      -- INSERT.
      HRP_MONTH_PAYMENT_G.MONTH_DEDUCTION_INSERT
            ( P_PERSON_ID
            , P_PAY_YYYYMM
            , P_WAGE_TYPE
            , P_CORP_ID
            , V_RESIDENT_DEDUCTION_ID
            , DECIMAL_F(P_SOB_ID, P_ORG_ID, V_TAX_AMOUNT, 'PAYMENT')
            , P_MONTH_PAYMENT_ID
            , P_SOB_ID
            , P_ORG_ID
            , P_USER_ID 
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
