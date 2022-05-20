CREATE OR REPLACE PACKAGE HRR_RETIRE_STANDARD_G
AS

-- SELECT_RETIRE_STANDARD
  PROCEDURE SELECT_RETIRE_STANDARD
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_STD_YYYY                          IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- INSERT_RETIRE_STANDARD
  PROCEDURE INSERT_RETIRE_STANDARD
            ( P_STD_YYYY                IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , P_STD_CALCULATE_MONTH     IN HRR_RETIRE_STANDARD.STD_CALCULATE_MONTH%TYPE
            , P_STD_MONTH               IN HRR_RETIRE_STANDARD.STD_MONTH%TYPE
            , P_PAY_MONTH               IN HRR_RETIRE_STANDARD.PAY_MONTH%TYPE
            , P_BONUS_MONTH             IN HRR_RETIRE_STANDARD.BONUS_MONTH%TYPE
            , P_MONTH_DAY               IN HRR_RETIRE_STANDARD.MONTH_DAY%TYPE
            , P_YEAR_DAY                IN HRR_RETIRE_STANDARD.YEAR_DAY%TYPE
            , P_INCOME_DEDUCTION_RATE   IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_RATE%TYPE
            , P_INCOME_DEDUCTION_LMT    IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_LMT%TYPE
            , P_TAX_DEDUCTION_RATE      IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_RATE%TYPE
            , P_TAX_DEDUCTION_LMT       IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_LMT%TYPE
            , P_RETIREMENT_PENSION_FLAG IN HRR_RETIRE_STANDARD.RETIREMENT_PENSION_FLAG%TYPE
            , P_DESCRIPTION             IN HRR_RETIRE_STANDARD.DESCRIPTION%TYPE
            , P_SOB_ID                  IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , P_ORG_ID                  IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , P_USER_ID                 IN HRR_RETIRE_STANDARD.CREATED_BY%TYPE
            );

-- UPDATE_RETIRE_STANDARD.
  PROCEDURE UPDATE_RETIRE_STANDARD
            ( W_STD_YYYY                IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , P_STD_CALCULATE_MONTH     IN HRR_RETIRE_STANDARD.STD_CALCULATE_MONTH%TYPE
            , P_STD_MONTH               IN HRR_RETIRE_STANDARD.STD_MONTH%TYPE
            , P_PAY_MONTH               IN HRR_RETIRE_STANDARD.PAY_MONTH%TYPE
            , P_BONUS_MONTH             IN HRR_RETIRE_STANDARD.BONUS_MONTH%TYPE
            , P_MONTH_DAY               IN HRR_RETIRE_STANDARD.MONTH_DAY%TYPE
            , P_YEAR_DAY                IN HRR_RETIRE_STANDARD.YEAR_DAY%TYPE
            , P_INCOME_DEDUCTION_RATE   IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_RATE%TYPE
            , P_INCOME_DEDUCTION_LMT    IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_LMT%TYPE
            , P_TAX_DEDUCTION_RATE      IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_RATE%TYPE
            , P_TAX_DEDUCTION_LMT       IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_LMT%TYPE
            , P_RETIREMENT_PENSION_FLAG IN HRR_RETIRE_STANDARD.RETIREMENT_PENSION_FLAG%TYPE
            , P_DESCRIPTION             IN HRR_RETIRE_STANDARD.DESCRIPTION%TYPE
            , W_SOB_ID                  IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                  IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , P_USER_ID                 IN HRR_RETIRE_STANDARD.CREATED_BY%TYPE
            );

-- DELETE_RETIRE_STANDARD.
  PROCEDURE DELETE_RETIRE_STANDARD
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 퇴직연금 적용 여부 -- 
  FUNCTION GET_RETIREMENT_PENSION_FLAG
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            ) RETURN VARCHAR2;
            
---------------------------------------------------------------------------------------------------
-- 해당 년도 기준 정보 존재 여부 체크.
  PROCEDURE RETIRE_STANDARD_CHECK_YN
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            );

-- 전년도 기준 정보 COPY
  PROCEDURE COPY_RETIRE_STANDARD
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , P_USER_ID               IN HRR_RETIRE_STANDARD.CREATED_BY%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            );

END HRR_RETIRE_STANDARD_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_STANDARD_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRR_RETIRE_STANDARD_G
/* DESCRIPTION  : 퇴직정산 기준자료 관리
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- SELECT_RETIRE_STANDARD
  PROCEDURE SELECT_RETIRE_STANDARD
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_STD_YYYY                          IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT RS.STD_CALCULATE_MONTH
           , RS.STD_YYYY
           , RS.STD_MONTH
           , RS.PAY_MONTH
           , RS.BONUS_MONTH
           , RS.MONTH_DAY
           , RS.YEAR_DAY
           , RS.INCOME_DEDUCTION_RATE
           , RS.INCOME_DEDUCTION_LMT
           , RS.TAX_DEDUCTION_RATE
           , RS.TAX_DEDUCTION_LMT
           , RS.RETIREMENT_PENSION_FLAG
           , RS.DESCRIPTION
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY              = W_STD_YYYY
         AND RS.SOB_ID                = W_SOB_ID
         AND RS.ORG_ID                = W_ORG_ID
      ;

  END SELECT_RETIRE_STANDARD;


---------------------------------------------------------------------------------------------------
-- INSERT_RETIRE_STANDARD
  PROCEDURE INSERT_RETIRE_STANDARD
            ( P_STD_YYYY                IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , P_STD_CALCULATE_MONTH     IN HRR_RETIRE_STANDARD.STD_CALCULATE_MONTH%TYPE
            , P_STD_MONTH               IN HRR_RETIRE_STANDARD.STD_MONTH%TYPE
            , P_PAY_MONTH               IN HRR_RETIRE_STANDARD.PAY_MONTH%TYPE
            , P_BONUS_MONTH             IN HRR_RETIRE_STANDARD.BONUS_MONTH%TYPE
            , P_MONTH_DAY               IN HRR_RETIRE_STANDARD.MONTH_DAY%TYPE
            , P_YEAR_DAY                IN HRR_RETIRE_STANDARD.YEAR_DAY%TYPE
            , P_INCOME_DEDUCTION_RATE   IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_RATE%TYPE
            , P_INCOME_DEDUCTION_LMT    IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_LMT%TYPE
            , P_TAX_DEDUCTION_RATE      IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_RATE%TYPE
            , P_TAX_DEDUCTION_LMT       IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_LMT%TYPE
            , P_RETIREMENT_PENSION_FLAG IN HRR_RETIRE_STANDARD.RETIREMENT_PENSION_FLAG%TYPE
            , P_DESCRIPTION             IN HRR_RETIRE_STANDARD.DESCRIPTION%TYPE
            , P_SOB_ID                  IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , P_ORG_ID                  IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , P_USER_ID                 IN HRR_RETIRE_STANDARD.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_RECORD_COUNT                NUMBER := 0;

  BEGIN
    -- 같은 시작년월 데이터 Insert --> Error 발생.
    BEGIN
      SELECT COUNT(RS.STD_YYYY) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY          = P_STD_YYYY
         AND RS.SOB_ID            = P_SOB_ID
         AND RS.ORG_ID            = P_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    INSERT INTO HRR_RETIRE_STANDARD
    ( STD_YYYY
    , STD_CALCULATE_MONTH
    , STD_MONTH 
    , PAY_MONTH 
    , BONUS_MONTH 
    , MONTH_DAY 
    , YEAR_DAY 
    , INCOME_DEDUCTION_RATE 
    , INCOME_DEDUCTION_LMT 
    , TAX_DEDUCTION_RATE 
    , TAX_DEDUCTION_LMT 
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    , RETIREMENT_PENSION_FLAG
    ) VALUES
    ( P_STD_YYYY
    , P_STD_CALCULATE_MONTH
    , P_STD_MONTH
    , P_PAY_MONTH
    , P_BONUS_MONTH
    , P_MONTH_DAY
    , P_YEAR_DAY
    , P_INCOME_DEDUCTION_RATE
    , P_INCOME_DEDUCTION_LMT
    , P_TAX_DEDUCTION_RATE
    , P_TAX_DEDUCTION_LMT
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    , NVL(P_RETIREMENT_PENSION_FLAG, 'N')
    );

  EXCEPTION
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END INSERT_RETIRE_STANDARD;

-- UPDATE_RETIRE_STANDARD.
  PROCEDURE UPDATE_RETIRE_STANDARD
            ( W_STD_YYYY                IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , P_STD_CALCULATE_MONTH     IN HRR_RETIRE_STANDARD.STD_CALCULATE_MONTH%TYPE
            , P_STD_MONTH               IN HRR_RETIRE_STANDARD.STD_MONTH%TYPE
            , P_PAY_MONTH               IN HRR_RETIRE_STANDARD.PAY_MONTH%TYPE
            , P_BONUS_MONTH             IN HRR_RETIRE_STANDARD.BONUS_MONTH%TYPE
            , P_MONTH_DAY               IN HRR_RETIRE_STANDARD.MONTH_DAY%TYPE
            , P_YEAR_DAY                IN HRR_RETIRE_STANDARD.YEAR_DAY%TYPE
            , P_INCOME_DEDUCTION_RATE   IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_RATE%TYPE
            , P_INCOME_DEDUCTION_LMT    IN HRR_RETIRE_STANDARD.INCOME_DEDUCTION_LMT%TYPE
            , P_TAX_DEDUCTION_RATE      IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_RATE%TYPE
            , P_TAX_DEDUCTION_LMT       IN HRR_RETIRE_STANDARD.TAX_DEDUCTION_LMT%TYPE
            , P_RETIREMENT_PENSION_FLAG IN HRR_RETIRE_STANDARD.RETIREMENT_PENSION_FLAG%TYPE
            , P_DESCRIPTION             IN HRR_RETIRE_STANDARD.DESCRIPTION%TYPE
            , W_SOB_ID                  IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                  IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , P_USER_ID                 IN HRR_RETIRE_STANDARD.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(W_SOB_ID);

  BEGIN
    UPDATE HRR_RETIRE_STANDARD
      SET STD_CALCULATE_MONTH     = P_STD_CALCULATE_MONTH
        , STD_MONTH               = P_STD_MONTH
        , PAY_MONTH               = P_PAY_MONTH
        , BONUS_MONTH             = P_BONUS_MONTH
        , MONTH_DAY               = P_MONTH_DAY
        , YEAR_DAY                = P_YEAR_DAY
        , INCOME_DEDUCTION_RATE   = P_INCOME_DEDUCTION_RATE
        , INCOME_DEDUCTION_LMT    = P_INCOME_DEDUCTION_LMT
        , TAX_DEDUCTION_RATE      = P_TAX_DEDUCTION_RATE
        , TAX_DEDUCTION_LMT       = P_TAX_DEDUCTION_LMT
        , DESCRIPTION             = P_DESCRIPTION
        , LAST_UPDATE_DATE        = V_SYSDATE
        , LAST_UPDATED_BY         = P_USER_ID
        , RETIREMENT_PENSION_FLAG = NVL(P_RETIREMENT_PENSION_FLAG, 'N')
    WHERE STD_YYYY                = W_STD_YYYY
      AND SOB_ID                  = W_SOB_ID
      AND ORG_ID                  = W_ORG_ID
    ;
  END UPDATE_RETIRE_STANDARD;

-- DELETE_RETIRE_STANDARD.
  PROCEDURE DELETE_RETIRE_STANDARD
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRR_RETIRE_STANDARD
    WHERE STD_YYYY              = W_STD_YYYY
      AND SOB_ID                = W_SOB_ID
      AND ORG_ID                = W_ORG_ID
      ;

  END DELETE_RETIRE_STANDARD;


---------------------------------------------------------------------------------------------------
-- 퇴직연금 적용 여부 -- 
  FUNCTION GET_RETIREMENT_PENSION_FLAG
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_RETIREMENT_PENSION_FLAG     VARCHAR2(2);
  BEGIN
    V_RETIREMENT_PENSION_FLAG := 'N';
    BEGIN
      SELECT RS.RETIREMENT_PENSION_FLAG
        INTO V_RETIREMENT_PENSION_FLAG
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY              = W_STD_YYYY
         AND RS.SOB_ID                = W_SOB_ID
         AND RS.ORG_ID                = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RETIREMENT_PENSION_FLAG := 'N';
    END;
    RETURN V_RETIREMENT_PENSION_FLAG;
  END GET_RETIREMENT_PENSION_FLAG;
  
---------------------------------------------------------------------------------------------------
-- 해당 년도 기준 정보 존재 여부 체크.
  PROCEDURE RETIRE_STANDARD_CHECK_YN
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , O_CHECK_YN              OUT VARCHAR2
            )
  AS
  BEGIN
    SELECT DECODE(COUNT(RS.STD_YYYY), 0, 'N', 'Y') AS RECORD_COUNT
      INTO O_CHECK_YN
      FROM HRR_RETIRE_STANDARD RS
     WHERE RS.STD_YYYY              = W_STD_YYYY
       AND RS.SOB_ID                = W_SOB_ID
       AND RS.ORG_ID                = W_ORG_ID
    ;
  EXCEPTION WHEN OTHERS THEN
    O_CHECK_YN := 'N';
  END RETIRE_STANDARD_CHECK_YN;            

-- 전년도 기준 정보 COPY
  PROCEDURE COPY_RETIRE_STANDARD
            ( W_STD_YYYY              IN HRR_RETIRE_STANDARD.STD_YYYY%TYPE
            , W_SOB_ID                IN HRR_RETIRE_STANDARD.SOB_ID%TYPE
            , W_ORG_ID                IN HRR_RETIRE_STANDARD.ORG_ID%TYPE
            , P_USER_ID               IN HRR_RETIRE_STANDARD.CREATED_BY%TYPE
            , O_STATUS                OUT VARCHAR2
            , O_MESSAGE               OUT VARCHAR2
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_PRE_STD_YYYY                HRR_RETIRE_STANDARD.STD_YYYY%TYPE;
  BEGIN
    O_STATUS := 'F';
    V_PRE_STD_YYYY := W_STD_YYYY - 1;
    
    -- 같은 시작년월 데이터 Insert --> Error 발생.
    BEGIN
      DELETE_RETIRE_STANDARD(W_STD_YYYY, W_SOB_ID, W_ORG_ID);
    EXCEPTION
      WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Delete Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
    END;
    
    BEGIN
      INSERT INTO HRR_RETIRE_STANDARD
      ( STD_YYYY
      , STD_CALCULATE_MONTH
      , STD_MONTH 
      , PAY_MONTH 
      , BONUS_MONTH 
      , MONTH_DAY 
      , YEAR_DAY 
      , INCOME_DEDUCTION_RATE 
      , INCOME_DEDUCTION_LMT 
      , TAX_DEDUCTION_RATE 
      , TAX_DEDUCTION_LMT 
      , DESCRIPTION 
      , SOB_ID 
      , ORG_ID 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      , RETIREMENT_PENSION_FLAG
      )  
      SELECT W_STD_YYYY
           , RS.STD_CALCULATE_MONTH
           , RS.STD_MONTH
           , RS.PAY_MONTH
           , RS.BONUS_MONTH
           , RS.MONTH_DAY
           , RS.YEAR_DAY
           , RS.INCOME_DEDUCTION_RATE
           , RS.INCOME_DEDUCTION_LMT
           , RS.TAX_DEDUCTION_RATE
           , RS.TAX_DEDUCTION_LMT
           , RS.DESCRIPTION
           , RS.SOB_ID
           , RS.ORG_ID
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
           , RS.RETIREMENT_PENSION_FLAG
        FROM HRR_RETIRE_STANDARD RS
       WHERE RS.STD_YYYY              = V_PRE_STD_YYYY
         AND RS.SOB_ID                = W_SOB_ID
         AND RS.ORG_ID                = W_ORG_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Insert Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
    END;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'SDM_10027', NULL);
  END COPY_RETIRE_STANDARD;
  
END HRR_RETIRE_STANDARD_G;
/
