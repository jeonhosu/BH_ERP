CREATE OR REPLACE PACKAGE HRT_PAYMENT_ADD_DEDUCTION_G
AS

-- ADD_DEDUCTION SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , W_DEDUCTION_ID                      IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID%TYPE
            , W_PERSON_ID                         IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ADD_DEDUCTION_INSERT
  PROCEDURE ADD_DEDUCTION_INSERT
            ( P_ADD_DEDUCTION_ID OUT HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID%TYPE
            , P_PERSON_ID        IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , P_CORP_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , P_PAY_YYYYMM       IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , P_DEDUCTION_ID     IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_CREATED_FLAG     IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_FLAG%TYPE
            , P_DESCRIPTION      IN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY%TYPE
            );

-- ADD_DEDUCTION__UPDATE.
  PROCEDURE ADD_DEDUCTION_UPDATE
            ( W_ADD_DEDUCTION_ID IN HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID%TYPE
            , P_PERSON_ID        IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , P_CORP_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , P_PAY_YYYYMM       IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , P_DEDUCTION_ID     IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_CREATED_FLAG     IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_FLAG%TYPE
            , P_DESCRIPTION      IN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY%TYPE
            );

-- ADD_DEDUCTION_DELETE.
  PROCEDURE ADD_DEDUCTION_DELETE
            ( W_ADD_DEDUCTION_ID IN HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE PROMPT_SPREAD_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            );

-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE DEDUCTION_SPREAD_SELECT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 급상여 대량 데이터 INSERT를 위한 ADD_ALLOWANCE SELECT
  PROCEDURE MASS_EXCEL_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , W_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            );

-- 엑셀데이터 INSERT.
  PROCEDURE MASS_EXCEL_INSERT
            ( P_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , P_WAGE_TYPE_NAME    IN VARCHAR2
            , P_PERSON_NUM        IN VARCHAR2
            , P_NAME              IN VARCHAR2
            , P_DEDUCTION_CODE    IN VARCHAR2
            , P_DEDUCTION_NAME    IN VARCHAR2
            , P_DEDUCTION_AMOUNT  IN NUMBER
            , P_DESCRIPTION       IN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION%TYPE
            , P_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID           IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY%TYPE 
            );
            
END HRT_PAYMENT_ADD_DEDUCTION_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRT_PAYMENT_ADD_DEDUCTION_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRT_PAYMENT_ADD_DEDUCTION_G
/* DESCRIPTION  : 급상여 추가 공제 항목 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- ADD_DEDUCTION SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM                        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE                         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , W_DEDUCTION_ID                      IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID%TYPE
            , W_PERSON_ID                         IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID                            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            )
  AS
    V_START_DATE                                  DATE := NULL;
    V_END_DATE                                    DATE := NULL;

  BEGIN
    BEGIN
      SELECT ADD_MONTHS(TO_DATE(W_PAY_YYYYMM || '-' || PT.START_DAY, 'YYYY-MM-DD') + PT.START_ADD_DAY, PT.START_ADD_MONTH) AS START_DATE
           , ADD_MONTHS(TO_DATE(W_PAY_YYYYMM || '-' || PT.END_DAY, 'YYYY-MM-DD') + PT.END_ADD_DAY, PT.END_ADD_MONTH) AS END_DATE
        INTO V_START_DATE, V_END_DATE
        FROM HRM_CLOSING_TYPE_V CT
          , HRM_PAYMENT_TERM_V PT
       WHERE CT.CLOSING_TYPE    = PT.WAGE_TYPE
         AND CT.SOB_ID          = PT.SOB_ID
         AND CT.ORG_ID          = PT.ORG_ID
         AND PT.WAGE_TYPE       = W_WAGE_TYPE
         AND PT.SOB_ID          = W_SOB_ID
         AND PT.ORG_ID          = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_START_DATE := TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'));
      V_END_DATE := LAST_DAY(V_START_DATE);
    END;

    OPEN P_CURSOR FOR
      SELECT PAD.PAY_YYYYMM
           , PAD.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', PAD.WAGE_TYPE, PAD.SOB_ID, PAD.ORG_ID) AS WAGE_TYPE_NAME
           , PM.NAME
           , PM.PERSON_NUM
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(PAD.DEDUCTION_ID) AS DEDUCTION_NAME
           , PAD.DEDUCTION_AMOUNT
           , PAD.CREATED_FLAG
           , PAD.DESCRIPTION
           , PAD.ADD_DEDUCTION_ID
           , PAD.PERSON_ID
           , PAD.CORP_ID
           , PAD.DEDUCTION_ID
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER PM
          , HRT_PAYMENT_ADD_DEDUCTION PAD
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = PAD.PERSON_ID
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PAD.CORP_ID         = NVL(W_CORP_ID, PAD.CORP_ID)
        AND PAD.PAY_YYYYMM      = W_PAY_YYYYMM
        AND PAD.WAGE_TYPE       = W_WAGE_TYPE
        AND PAD.PERSON_ID       = NVL(W_PERSON_ID, PAD.PERSON_ID)
        AND PAD.DEDUCTION_ID    = NVL(W_DEDUCTION_ID, PAD.DEDUCTION_ID)
        AND PAD.SOB_ID          = W_SOB_ID
        AND PAD.ORG_ID          = W_ORG_ID
        AND PM.ORI_JOIN_DATE    <= V_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
      ORDER BY HL.DEPT_ID, HL.POST_ID, HL.PERSON_ID
      ;

  END DATA_SELECT;

---------------------------------------------------------------------------------------------------
-- ADD_DEDUCTION_INSERT
  PROCEDURE ADD_DEDUCTION_INSERT
            ( P_ADD_DEDUCTION_ID OUT HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID%TYPE
            , P_PERSON_ID        IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , P_CORP_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , P_PAY_YYYYMM       IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , P_DEDUCTION_ID     IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_CREATED_FLAG     IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_FLAG%TYPE
            , P_DESCRIPTION      IN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);

  BEGIN
    BEGIN
      SELECT HRT_PAYMENT_ADD_DEDUCTION_S1.NEXTVAL
       INTO P_ADD_DEDUCTION_ID
       FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    END;

    INSERT INTO HRT_PAYMENT_ADD_DEDUCTION
    ( ADD_DEDUCTION_ID
    , PERSON_ID
    , CORP_ID
    , PAY_YYYYMM
    , WAGE_TYPE
    , DEDUCTION_ID
    , DEDUCTION_AMOUNT
    , CREATED_FLAG
    , DESCRIPTION
    , SOB_ID
    , ORG_ID
    , CREATION_DATE
    , CREATED_BY
    , LAST_UPDATE_DATE
    , LAST_UPDATED_BY
    ) VALUES
    ( P_ADD_DEDUCTION_ID
    , P_PERSON_ID
    , P_CORP_ID
    , P_PAY_YYYYMM
    , P_WAGE_TYPE
    , P_DEDUCTION_ID
    , P_DEDUCTION_AMOUNT
    , P_CREATED_FLAG
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID
    );

  END ADD_DEDUCTION_INSERT;

-- ADD_DEDUCTION__UPDATE.
  PROCEDURE ADD_DEDUCTION_UPDATE
            ( W_ADD_DEDUCTION_ID IN HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID%TYPE
            , P_PERSON_ID        IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , P_CORP_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , P_PAY_YYYYMM       IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE        IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , P_DEDUCTION_ID     IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_ID%TYPE
            , P_DEDUCTION_AMOUNT IN HRT_PAYMENT_ADD_DEDUCTION.DEDUCTION_AMOUNT%TYPE
            , P_CREATED_FLAG     IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_FLAG%TYPE
            , P_DESCRIPTION      IN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID           IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID          IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY%TYPE
            )
  AS
   V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

  BEGIN
      UPDATE HRT_PAYMENT_ADD_DEDUCTION
        SET DEDUCTION_ID     = P_DEDUCTION_ID
          , DEDUCTION_AMOUNT = P_DEDUCTION_AMOUNT
          , CREATED_FLAG     = P_CREATED_FLAG
          , DESCRIPTION      = P_DESCRIPTION
          , LAST_UPDATE_DATE = V_SYSDATE
          , LAST_UPDATED_BY  = P_USER_ID
      WHERE ADD_DEDUCTION_ID = W_ADD_DEDUCTION_ID
      ;

  END ADD_DEDUCTION_UPDATE;

-- ADD_DEDUCTION_DELETE.
  PROCEDURE ADD_DEDUCTION_DELETE
            ( W_ADD_DEDUCTION_ID IN HRT_PAYMENT_ADD_DEDUCTION.ADD_DEDUCTION_ID%TYPE
            )
  AS
  BEGIN
    DELETE HRT_PAYMENT_ADD_DEDUCTION
     WHERE ADD_DEDUCTION_ID = W_ADD_DEDUCTION_ID;

  END ADD_DEDUCTION_DELETE;

---------------------------------------------------------------------------------------------------
-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE PROMPT_SPREAD_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT -- 추가공제 PROMPT.
             MAX(DECODE(HD.DEDUCTION_CODE, 'D01', HD.DEDUCTION_NAME)) AS D01
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D02', HD.DEDUCTION_NAME)) AS D02
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D03', HD.DEDUCTION_NAME)) AS D03
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D04', HD.DEDUCTION_NAME)) AS D04
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D05', HD.DEDUCTION_NAME)) AS D05
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D06', HD.DEDUCTION_NAME)) AS D06
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D07', HD.DEDUCTION_NAME)) AS D07
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D08', HD.DEDUCTION_NAME)) AS D08
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D09', HD.DEDUCTION_NAME)) AS D09
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D10', HD.DEDUCTION_NAME)) AS D10
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D11', HD.DEDUCTION_NAME)) AS D11
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D12', HD.DEDUCTION_NAME)) AS D12
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D13', HD.DEDUCTION_NAME)) AS D13
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D14', HD.DEDUCTION_NAME)) AS D14
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D15', HD.DEDUCTION_NAME)) AS D15
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D16', HD.DEDUCTION_NAME)) AS D16
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D17', HD.DEDUCTION_NAME)) AS D17
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D18', HD.DEDUCTION_NAME)) AS D18
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D19', HD.DEDUCTION_NAME)) AS D19
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D20', HD.DEDUCTION_NAME)) AS D20
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D21', HD.DEDUCTION_NAME)) AS D21
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D22', HD.DEDUCTION_NAME)) AS D22
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D23', HD.DEDUCTION_NAME)) AS D23
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D24', HD.DEDUCTION_NAME)) AS D24
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D25', HD.DEDUCTION_NAME)) AS D25
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D26', HD.DEDUCTION_NAME)) AS D26
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D27', HD.DEDUCTION_NAME)) AS D27
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D28', HD.DEDUCTION_NAME)) AS D28
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D29', HD.DEDUCTION_NAME)) AS D29
           -- 추가공제항목 여부.
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D01', HD.DEDUCTION_YN, 'N')) AS D01_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D02', HD.DEDUCTION_YN, 'N')) AS D02_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D03', HD.DEDUCTION_YN, 'N')) AS D03_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D04', HD.DEDUCTION_YN, 'N')) AS D04_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D05', HD.DEDUCTION_YN, 'N')) AS D05_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D06', HD.DEDUCTION_YN, 'N')) AS D06_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D07', HD.DEDUCTION_YN, 'N')) AS D07_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D08', HD.DEDUCTION_YN, 'N')) AS D08_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D09', HD.DEDUCTION_YN, 'N')) AS D09_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D10', HD.DEDUCTION_YN, 'N')) AS D10_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D11', HD.DEDUCTION_YN, 'N')) AS D11_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D12', HD.DEDUCTION_YN, 'N')) AS D12_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D13', HD.DEDUCTION_YN, 'N')) AS D13_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D14', HD.DEDUCTION_YN, 'N')) AS D14_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D15', HD.DEDUCTION_YN, 'N')) AS D15_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D16', HD.DEDUCTION_YN, 'N')) AS D16_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D17', HD.DEDUCTION_YN, 'N')) AS D17_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D18', HD.DEDUCTION_YN, 'N')) AS D18_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D19', HD.DEDUCTION_YN, 'N')) AS D19_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D20', HD.DEDUCTION_YN, 'N')) AS D20_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D21', HD.DEDUCTION_YN, 'N')) AS D21_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D22', HD.DEDUCTION_YN, 'N')) AS D22_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D23', HD.DEDUCTION_YN, 'N')) AS D23_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D24', HD.DEDUCTION_YN, 'N')) AS D24_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D25', HD.DEDUCTION_YN, 'N')) AS D25_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D26', HD.DEDUCTION_YN, 'N')) AS D26_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D27', HD.DEDUCTION_YN, 'N')) AS D27_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D28', HD.DEDUCTION_YN, 'N')) AS D28_YN
           , MAX(DECODE(HD.DEDUCTION_CODE, 'D29', HD.DEDUCTION_YN, 'N')) AS D29_YN
        FROM HRM_DEDUCTION_V HD
      WHERE HD.SOB_ID                   = W_SOB_ID
        AND HD.ORG_ID                   = W_ORG_ID
        AND HD.ENABLED_FLAG             = 'Y'
        AND HD.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (HD.EFFECTIVE_DATE_TO IS NULL OR HD.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')))
      GROUP BY HD.SOB_ID
           , HD.ORG_ID
      ;
  END PROMPT_SPREAD_SELECT;

-- ADD_DEDUCTION SPREAD SELECT
  PROCEDURE DEDUCTION_SPREAD_SELECT
            ( P_CURSOR2           OUT TYPES.TCURSOR2
            , W_CORP_ID           IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRT_PAYMENT_ADD_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PAD.PAY_YYYYMM
           , PAD.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('WAGE_TYPE', PAD.WAGE_TYPE, PAD.SOB_ID, PAD.ORG_ID) AS WAGE_TYPE_DESC
           , NVL(PAD.CORP_ID, NULL) AS CORP_ID
           , NVL(PAD.PERSON_ID, NULL) AS PERSON_ID
           , CASE
               WHEN GROUPING(PAD.PAY_YYYYMM) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
               ELSE PM.NAME
             END AS NAME
           , PM.PERSON_NUM
           , DM.DEPT_NAME
           , PG.PAY_GRADE_NAME
           , TO_CHAR(PM.ORI_JOIN_DATE, 'YYYY-MM-DD') AS ORI_JOIN_DATE
           , TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD') AS RETIRE_DATE
           -- 추가지급.
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D01', PAD.DEDUCTION_AMOUNT)) AS D01
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D02', PAD.DEDUCTION_AMOUNT)) AS D02
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D03', PAD.DEDUCTION_AMOUNT)) AS D03
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D04', PAD.DEDUCTION_AMOUNT)) AS D04
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D05', PAD.DEDUCTION_AMOUNT)) AS D05
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D06', PAD.DEDUCTION_AMOUNT)) AS D06
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D07', PAD.DEDUCTION_AMOUNT)) AS D07
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D08', PAD.DEDUCTION_AMOUNT)) AS D08
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D09', PAD.DEDUCTION_AMOUNT)) AS D09
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D10', PAD.DEDUCTION_AMOUNT)) AS D10
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D11', PAD.DEDUCTION_AMOUNT)) AS D11
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D12', PAD.DEDUCTION_AMOUNT)) AS D12
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D13', PAD.DEDUCTION_AMOUNT)) AS D13
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D14', PAD.DEDUCTION_AMOUNT)) AS D14
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D15', PAD.DEDUCTION_AMOUNT)) AS D15
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D16', PAD.DEDUCTION_AMOUNT)) AS D16
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D17', PAD.DEDUCTION_AMOUNT)) AS D17
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D18', PAD.DEDUCTION_AMOUNT)) AS D18
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D19', PAD.DEDUCTION_AMOUNT)) AS D19
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D20', PAD.DEDUCTION_AMOUNT)) AS D20
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D21', PAD.DEDUCTION_AMOUNT)) AS D21
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D22', PAD.DEDUCTION_AMOUNT)) AS D22
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D23', PAD.DEDUCTION_AMOUNT)) AS D23
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D24', PAD.DEDUCTION_AMOUNT)) AS D24
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D25', PAD.DEDUCTION_AMOUNT)) AS D25
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D26', PAD.DEDUCTION_AMOUNT)) AS D26
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D27', PAD.DEDUCTION_AMOUNT)) AS D27
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D28', PAD.DEDUCTION_AMOUNT)) AS D28
           , SUM(DECODE(HD.DEDUCTION_CODE, 'D29', PAD.DEDUCTION_AMOUNT)) AS D29
           , SUM(PAD.DEDUCTION_AMOUNT) AS TOTAL_AMOUNT
        FROM HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_PAY_GRADE_V PG
          , HRT_PAYMENT_ADD_DEDUCTION PAD
          , HRM_DEDUCTION_V HD
      WHERE PM.PERSON_ID                = PAD.PERSON_ID
        AND PM.DEPT_ID                  = DM.DEPT_ID
        AND PM.PAY_GRADE_ID             = PG.PAY_GRADE_ID
        AND PAD.DEDUCTION_ID            = HD.DEDUCTION_ID
        AND PAD.SOB_ID                  = HD.SOB_ID
        AND PAD.ORG_ID                  = HD.ORG_ID
        AND PAD.PAY_YYYYMM              = W_PAY_YYYYMM
        AND PAD.WAGE_TYPE               = W_WAGE_TYPE
        AND PAD.CORP_ID                 = NVL(W_CORP_ID, PAD.CORP_ID)
        AND PAD.PERSON_ID               = NVL(W_PERSON_ID, PAD.PERSON_ID)
        AND PAD.SOB_ID                  = W_SOB_ID
        AND PAD.ORG_ID                  = W_ORG_ID
        AND HD.ENABLED_FLAG             = 'Y'
        AND HD.EFFECTIVE_DATE_FR        <= LAST_DAY(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'))
        AND (HD.EFFECTIVE_DATE_TO IS NULL OR HD.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM')))
      GROUP BY ROLLUP((DM.DEPT_CODE
           , PG.PAY_GRADE
           , PM.PERSON_NUM
           , PAD.PERSON_ID
           , PM.NAME
           , DM.DEPT_NAME
           , PG.PAY_GRADE_NAME
           , PM.ORI_JOIN_DATE
           , PM.RETIRE_DATE
           , PAD.CORP_ID
           , PAD.PAY_YYYYMM
           , PAD.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('WAGE_TYPE', PAD.WAGE_TYPE, PAD.SOB_ID, PAD.ORG_ID)))
      ;
  END DEDUCTION_SPREAD_SELECT;
            
---------------------------------------------------------------------------------------------------
-- 급상여 대량 데이터 INSERT를 위한 ADD_ALLOWANCE SELECT
  PROCEDURE MASS_EXCEL_SELECT
            ( P_CURSOR1           OUT TYPES.TCURSOR1
            , W_CORP_ID           IN HRT_PAYMENT_ADD_DEDUCTION.CORP_ID%TYPE
            , W_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , W_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT PAA.PAY_YYYYMM
           , PAA.WAGE_TYPE
           , TO_CHAR(NULL) AS WAGE_TYPE_NAME
           , TO_CHAR(NULL) AS PERSON_NUM
           , TO_CHAR(NULL) AS NAME
           , TO_CHAR(NULL) AS DEDUCTION_CODE
           , TO_CHAR(NULL) AS DEDUCTION_NAME
           , PAA.DEDUCTION_AMOUNT
           , PAA.DESCRIPTION
           , PAA.SOB_ID
           , PAA.ORG_ID
        FROM HRT_PAYMENT_ADD_DEDUCTION PAA
      WHERE PAA.CORP_ID           = NVL(W_CORP_ID, PAA.CORP_ID)
        AND PAA.PAY_YYYYMM        = W_PAY_YYYYMM
        AND PAA.WAGE_TYPE         = W_WAGE_TYPE
        AND PAA.SOB_ID            = W_SOB_ID
        AND PAA.ORG_ID            = W_ORG_ID
      ;
  END MASS_EXCEL_SELECT;

-- 엑셀데이터 INSERT.
  PROCEDURE MASS_EXCEL_INSERT
            ( P_PAY_YYYYMM        IN HRT_PAYMENT_ADD_DEDUCTION.PAY_YYYYMM%TYPE
            , P_WAGE_TYPE         IN HRT_PAYMENT_ADD_DEDUCTION.WAGE_TYPE%TYPE
            , P_WAGE_TYPE_NAME    IN VARCHAR2
            , P_PERSON_NUM        IN VARCHAR2
            , P_NAME              IN VARCHAR2
            , P_DEDUCTION_CODE    IN VARCHAR2
            , P_DEDUCTION_NAME    IN VARCHAR2
            , P_DEDUCTION_AMOUNT  IN NUMBER
            , P_DESCRIPTION       IN HRT_PAYMENT_ADD_DEDUCTION.DESCRIPTION%TYPE
            , P_SOB_ID            IN HRT_PAYMENT_ADD_DEDUCTION.SOB_ID%TYPE
            , P_ORG_ID            IN HRT_PAYMENT_ADD_DEDUCTION.ORG_ID%TYPE
            , P_USER_ID           IN HRT_PAYMENT_ADD_DEDUCTION.CREATED_BY%TYPE 
            )
  AS
    V_ADD_DEDUCTION_ID           NUMBER;
    V_PERSON_ID                  NUMBER;
    V_CORP_ID                    NUMBER;
    V_DEDUCTION_ID               NUMBER;
  BEGIN
    -- 사원정보-- 
    BEGIN
      SELECT PM.CORP_ID
           , PM.PERSON_ID
        INTO V_CORP_ID
           , V_PERSON_ID
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_NUM         = P_PERSON_NUM
        AND PM.SOB_ID             = P_SOB_ID
        AND PM.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10028', NULL) || '(' || P_PERSON_NUM || ')');
    END;
    -- 지급항목ID-- 
    BEGIN
      SELECT HA.DEDUCTION_ID
        INTO V_DEDUCTION_ID
        FROM HRM_DEDUCTION_V HA
      WHERE HA.DEDUCTION_CODE     = P_DEDUCTION_CODE
        AND HA.SOB_ID             = P_SOB_ID
        AND HA.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10106', NULL) || '(' || P_DEDUCTION_CODE || ')') ;
    END;
    
    ADD_DEDUCTION_INSERT(P_ADD_DEDUCTION_ID => V_ADD_DEDUCTION_ID
                        , P_PERSON_ID => V_PERSON_ID
                        , P_CORP_ID => V_CORP_ID
                        , P_PAY_YYYYMM => P_PAY_YYYYMM
                        , P_WAGE_TYPE => P_WAGE_TYPE
                        , P_DEDUCTION_ID => V_DEDUCTION_ID
                        , P_DEDUCTION_AMOUNT => P_DEDUCTION_AMOUNT
                        , P_CREATED_FLAG => 'M'
                        , P_DESCRIPTION => P_DESCRIPTION
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );  
  
  END MASS_EXCEL_INSERT;
  
END HRT_PAYMENT_ADD_DEDUCTION_G;
/
