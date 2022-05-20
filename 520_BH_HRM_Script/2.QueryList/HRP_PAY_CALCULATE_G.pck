CREATE OR REPLACE PACKAGE HRP_PAY_CALCULATE_G
AS

-- 급상여 지급/공제 항목 조회.
  PROCEDURE SELECT_ALLOWANCE
            ( P_CURSOR          OUT TYPES.TCURSOR
            , W_ALLOWANCE_TYPE  IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , W_ALLOWANCE_ID    IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            );

-- 급상여 계산 기본 설정값 조회.
  PROCEDURE SELECT_PAY_SET
            ( P_CURSOR2         OUT TYPES.TCURSOR2
            , W_CORP_ID         IN HRP_PAY_CALCULATE.CORP_ID%TYPE
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_WAGE_TYPE       IN HRP_PAY_CALCULATE.WAGE_TYPE%TYPE
            , W_ALLOWANCE_ID    IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            );

-- 급상여 계산환경등록 항목 전체 조회.
  PROCEDURE SELECT_PAYMENT_SET_ITEM_ALL
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            );
            
-- 급상여 지급/공제 항목 전체 조회.
  PROCEDURE SELECT_ALLOWANCE_ITEM_ALL
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            );

-- 월근태 집계 항목 전체 조회.
  PROCEDURE SELECT_DUTY_ITEM_ALL
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            );

---------------------------------------------------------------------------------------------------
-- 지급/공제 항목 삽입.
  PROCEDURE ALLOWANCE_INSERT
            ( P_COMMON_ID         OUT HRM_COMMON.COMMON_ID%TYPE
            , P_ALLOWANCE_TYPE    IN HRM_ALLOWANCE_TYPE_V.ALLOWANCE_TYPE%TYPE
            , P_CODE              IN HRM_COMMON.CODE%TYPE
            , P_CODE_NAME         IN HRM_COMMON.CODE_NAME%TYPE
            , P_SORT_NUM          IN HRM_COMMON.SORT_NUM%TYPE
            , P_ENABLED_FLAG      IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID            IN HRM_COMMON.SOB_ID%TYPE
            , P_ORG_ID            IN HRM_COMMON.ORG_ID%TYPE
            , P_USER_ID           IN HRM_COMMON.CREATED_BY%TYPE 
            );

  PROCEDURE ALLOWANCE_UPDATE
            ( W_COMMON_ID         IN HRM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME         IN HRM_COMMON.CODE_NAME%TYPE
            , P_SORT_NUM          IN HRM_COMMON.SORT_NUM%TYPE
            , P_ENABLED_FLAG      IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRM_COMMON.CREATED_BY%TYPE 
            );
            
---------------------------------------------------------------------------------------------------
-- PAY_CALCULATE_INSERT
  PROCEDURE PAY_CALCULATE_INSERT
            ( P_CALCULATE_ID         OUT HRP_PAY_CALCULATE.CALCULATE_ID%TYPE
            , P_CORP_ID              IN HRP_PAY_CALCULATE.CORP_ID%TYPE
            , P_WAGE_TYPE            IN HRP_PAY_CALCULATE.WAGE_TYPE%TYPE
            , P_ALLOWANCE_TYPE       IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID         IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE             IN HRP_PAY_CALCULATE.PAY_TYPE%TYPE
            , P_SEX_TYPE             IN HRP_PAY_CALCULATE.SEX_TYPE%TYPE
            , P_TAX_YN               IN HRP_PAY_CALCULATE.TAX_YN%TYPE
            , P_TAX_FREE_TYPE        IN HRP_PAY_CALCULATE.TAX_FREE_TYPE%TYPE
            , P_ROOKIE_YN            IN HRP_PAY_CALCULATE.ROOKIE_YN%TYPE
            , P_EXCEPTION_YN         IN HRP_PAY_CALCULATE.EXCEPTION_YN%TYPE
            , P_MONTHLY_PAY_YN       IN HRP_PAY_CALCULATE.MONTHLY_PAY_YN%TYPE
            , P_GRADE_YN             IN HRP_PAY_CALCULATE.GRADE_YN%TYPE
            , P_PAY_MASTER_YN        IN HRP_PAY_CALCULATE.PAY_MASTER_YN%TYPE
            , P_ADD_ALLOWANCE_YN     IN HRP_PAY_CALCULATE.ADD_ALLOWANCE_YN%TYPE
            , P_RETIRE_ADJUSTMENT_YN IN HRP_PAY_CALCULATE.RETIRE_ADJUSTMENT_YN%TYPE
            , P_YEAR_ALLOWANCE_YN    IN HRP_PAY_CALCULATE.YEAR_ALLOWANCE_YN%TYPE
            , P_EMPLOYMENT_INSUR_YN  IN HRP_PAY_CALCULATE.EMPLOYMENT_INSUR_YN%TYPE
            , P_DECIMAL_TYPE         IN HRP_PAY_CALCULATE.DECIMAL_TYPE%TYPE
            , P_DIGIT_NUMBER         IN HRP_PAY_CALCULATE.DIGIT_NUMBER%TYPE
            , P_TEMP_RETIRE_YN       IN HRP_PAY_CALCULATE.TEMP_RETIRE_YN%TYPE
            , P_SYSTEM_CALCULATION   IN HRP_PAY_CALCULATE.SYSTEM_CALCULATION%TYPE
            , P_IF_CONDITION         IN HRP_PAY_CALCULATE.IF_CONDITION%TYPE
            , P_TRUE_VALUE           IN HRP_PAY_CALCULATE.TRUE_VALUE%TYPE
            , P_FALSE_VALUE          IN HRP_PAY_CALCULATE.FALSE_VALUE%TYPE
            , P_E_SYSTEM_CALCULATION IN HRP_PAY_CALCULATE.E_SYSTEM_CALCULATION%TYPE
            , P_E_IF_CONDITION       IN HRP_PAY_CALCULATE.E_IF_CONDITION%TYPE
            , P_E_TRUE_VALUE         IN HRP_PAY_CALCULATE.E_TRUE_VALUE%TYPE
            , P_E_FALSE_VALUE        IN HRP_PAY_CALCULATE.E_FALSE_VALUE%TYPE
            , P_DESCRIPTION          IN HRP_PAY_CALCULATE.DESCRIPTION%TYPE           
            , P_ENABLED_FLAG         IN HRP_PAY_CALCULATE.ENABLED_FLAG%TYPE
            , P_STD_YYYYMM           IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , P_SOB_ID               IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , P_ORG_ID               IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            , P_USER_ID              IN HRP_PAY_CALCULATE.CREATED_BY%TYPE
            );

-- PAY_CALCULAT_UPDATE.
  PROCEDURE PAY_CALCULAT_UPDATE
            ( W_CALCULATE_ID         IN HRP_PAY_CALCULATE.CALCULATE_ID%TYPE
            , P_CORP_ID              IN HRP_PAY_CALCULATE.CORP_ID%TYPE
            , P_WAGE_TYPE            IN HRP_PAY_CALCULATE.WAGE_TYPE%TYPE
            , P_ALLOWANCE_TYPE       IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID         IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE             IN HRP_PAY_CALCULATE.PAY_TYPE%TYPE
            , P_SEX_TYPE             IN HRP_PAY_CALCULATE.SEX_TYPE%TYPE
            , P_TAX_YN               IN HRP_PAY_CALCULATE.TAX_YN%TYPE
            , P_TAX_FREE_TYPE        IN HRP_PAY_CALCULATE.TAX_FREE_TYPE%TYPE
            , P_ROOKIE_YN            IN HRP_PAY_CALCULATE.ROOKIE_YN%TYPE
            , P_EXCEPTION_YN         IN HRP_PAY_CALCULATE.EXCEPTION_YN%TYPE
            , P_MONTHLY_PAY_YN       IN HRP_PAY_CALCULATE.MONTHLY_PAY_YN%TYPE
            , P_GRADE_YN             IN HRP_PAY_CALCULATE.GRADE_YN%TYPE
            , P_PAY_MASTER_YN        IN HRP_PAY_CALCULATE.PAY_MASTER_YN%TYPE
            , P_ADD_ALLOWANCE_YN     IN HRP_PAY_CALCULATE.ADD_ALLOWANCE_YN%TYPE
            , P_RETIRE_ADJUSTMENT_YN IN HRP_PAY_CALCULATE.RETIRE_ADJUSTMENT_YN%TYPE
            , P_YEAR_ALLOWANCE_YN    IN HRP_PAY_CALCULATE.YEAR_ALLOWANCE_YN%TYPE
            , P_EMPLOYMENT_INSUR_YN  IN HRP_PAY_CALCULATE.EMPLOYMENT_INSUR_YN%TYPE
            , P_DECIMAL_TYPE         IN HRP_PAY_CALCULATE.DECIMAL_TYPE%TYPE
            , P_DIGIT_NUMBER         IN HRP_PAY_CALCULATE.DIGIT_NUMBER%TYPE
            , P_TEMP_RETIRE_YN       IN HRP_PAY_CALCULATE.TEMP_RETIRE_YN%TYPE
            , P_SYSTEM_CALCULATION   IN HRP_PAY_CALCULATE.SYSTEM_CALCULATION%TYPE
            , P_IF_CONDITION         IN HRP_PAY_CALCULATE.IF_CONDITION%TYPE
            , P_TRUE_VALUE           IN HRP_PAY_CALCULATE.TRUE_VALUE%TYPE
            , P_FALSE_VALUE          IN HRP_PAY_CALCULATE.FALSE_VALUE%TYPE
            , P_E_SYSTEM_CALCULATION IN HRP_PAY_CALCULATE.E_SYSTEM_CALCULATION%TYPE
            , P_E_IF_CONDITION       IN HRP_PAY_CALCULATE.E_IF_CONDITION%TYPE
            , P_E_TRUE_VALUE         IN HRP_PAY_CALCULATE.E_TRUE_VALUE%TYPE
            , P_E_FALSE_VALUE        IN HRP_PAY_CALCULATE.E_FALSE_VALUE%TYPE
            , P_DESCRIPTION          IN HRP_PAY_CALCULATE.DESCRIPTION%TYPE
            , P_ENABLED_FLAG         IN HRP_PAY_CALCULATE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_YYYYMM_FR  IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , P_EFFECTIVE_YYYYMM_TO  IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_TO%TYPE
            , P_SOB_ID               IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , P_ORG_ID               IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            , P_USER_ID              IN HRP_PAY_CALCULATE.CREATED_BY%TYPE
            , O_CALCULATE_ID         OUT HRP_PAY_CALCULATE.CALCULATE_ID%TYPE
            );

-- LOOKUP : 급상여 지급/공제 항목 조회.
  PROCEDURE LU_ALLOWANCE
            ( P_CURSOR3          OUT TYPES.TCURSOR3
            , W_STD_YYYYMM       IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_ALLOWANCE_TYPE   IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , W_SOB_ID           IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN  IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );
            
END HRP_PAY_CALCULATE_G;
/
CREATE OR REPLACE PACKAGE BODY HRP_PAY_CALCULATE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_PAY_CALCULATE_G
/* DESCRIPTION  : 급상여 계산식 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 급상여 지급/공제 항목 조회.
  PROCEDURE SELECT_ALLOWANCE
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_ALLOWANCE_TYPE                    IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , W_ALLOWANCE_ID                      IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      -- 급상여 지급/공제 항목.
      SELECT SX.ALLOWANCE_CODE
           , SX.ALLOWANCE_NAME
           , SX.ALLOWANCE_ID
           , SX.SORT_NUM
           , SX.ENABLED_FLAG
           , SX.EFFECTIVE_DATE_FR
           , SX.EFFECTIVE_DATE_TO
        FROM (SELECT AV.ALLOWANCE_ID
                   , AV.ALLOWANCE_CODE
                   , AV.ALLOWANCE_NAME
                   , 'A' AS ALLOWANCE_TYPE
                   , AV.SOB_ID
                   , AV.ORG_ID
                   , AV.SORT_NUM
                   , AV.ENABLED_FLAG
                   , AV.EFFECTIVE_DATE_FR
                   , AV.EFFECTIVE_DATE_TO
                FROM HRM_ALLOWANCE_V AV
               WHERE AV.SOB_ID    = W_SOB_ID
                 AND AV.ORG_ID    = W_ORG_ID
              UNION ALL
              SELECT DV.DEDUCTION_ID AS ALLOWANCE_ID
                   , DV.DEDUCTION_CODE AS ALLOWANCE_CODE
                   , DV.DEDUCTION_NAME AS ALLOWANCE_NAME
                   , 'D' AS ALLOWANCE_TYPE 
                   , DV.SOB_ID
                   , DV.ORG_ID
                   , DV.SORT_NUM
                   , DV.ENABLED_FLAG
                   , DV.EFFECTIVE_DATE_FR
                   , DV.EFFECTIVE_DATE_TO
                FROM HRM_DEDUCTION_V DV
               WHERE DV.SOB_ID    = W_SOB_ID
                 AND DV.ORG_ID    = W_ORG_ID
              ) SX
       WHERE SX.ALLOWANCE_TYPE          = W_ALLOWANCE_TYPE
         AND SX.ALLOWANCE_ID            = NVL(W_ALLOWANCE_ID, SX.ALLOWANCE_ID)
      ORDER BY SX.SORT_NUM, SX.ALLOWANCE_CODE
      ;
      
  END SELECT_ALLOWANCE;

-- 급상여 계산 기본 설정값 조회.
  PROCEDURE SELECT_PAY_SET
            ( P_CURSOR2         OUT TYPES.TCURSOR2
            , W_CORP_ID         IN HRP_PAY_CALCULATE.CORP_ID%TYPE
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_WAGE_TYPE       IN HRP_PAY_CALCULATE.WAGE_TYPE%TYPE
            , W_ALLOWANCE_ID    IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PC.CALCULATE_ID
           , PC.CORP_ID
           , PC.WAGE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('CLOSING_TYPE', PC.WAGE_TYPE, PC.SOB_ID, PC.ORG_ID) AS WAGE_TYPE_NAME
           , PC.ALLOWANCE_TYPE
           , HRM_COMMON_G.CODE_NAME_F('ALLOWANCE_TYPE', PC.ALLOWANCE_TYPE, PC.SOB_ID, PC.ORG_ID) AS ALLOWANCE_TYPE_NAME
           , PC.ALLOWANCE_ID
           , HRM_COMMON_G.ID_NAME_F(PC.ALLOWANCE_ID) AS ALLOWANCE_NAME
           , PC.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PC.PAY_TYPE, PC.SOB_ID, PC.ORG_ID) AS PAY_TYPE_NAME
           , PC.SEX_TYPE
           , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PC.SEX_TYPE, PC.SOB_ID, PC.ORG_ID) AS SEX_TYPE_NAME
           , PC.TAX_YN
           , PC.TAX_FREE_TYPE
           , PC.ROOKIE_YN
           , PC.EXCEPTION_YN
           , PC.MONTHLY_PAY_YN
           , PC.GRADE_YN
           , PC.PAY_MASTER_YN
           , PC.ADD_ALLOWANCE_YN
           , PC.RETIRE_ADJUSTMENT_YN
           , PC.YEAR_ALLOWANCE_YN
           , PC.EMPLOYMENT_INSUR_YN
           , PC.DECIMAL_TYPE
           , HRM_COMMON_G.CODE_NAME_F('DECIMAL_TYPE', PC.DECIMAL_TYPE, PC.SOB_ID, PC.ORG_ID) AS DECIMAL_TYPE_NAME     
           , PC.DIGIT_NUMBER
           , PC.TEMP_RETIRE_YN
           , PC.SYSTEM_CALCULATION
           , PC.IF_CONDITION
           , PC.TRUE_VALUE
           , PC.FALSE_VALUE
           , PC.E_SYSTEM_CALCULATION
           , PC.E_IF_CONDITION
           , PC.E_TRUE_VALUE
           , PC.E_FALSE_VALUE
           , PC.DESCRIPTION
           , PC.ENABLED_FLAG
        FROM HRP_PAY_CALCULATE PC
       WHERE PC.CORP_ID                                 = W_CORP_ID
         AND PC.ALLOWANCE_ID                            = W_ALLOWANCE_ID
         AND PC.WAGE_TYPE                               = W_WAGE_TYPE
         AND PC.EFFECTIVE_YYYYMM_FR                     <= W_STD_YYYYMM
         AND (PC.EFFECTIVE_YYYYMM_TO IS NULL OR PC.EFFECTIVE_YYYYMM_TO >= W_STD_YYYYMM)
         AND PC.SOB_ID                                  = W_SOB_ID
         AND PC.ORG_ID                                  = W_ORG_ID
       ORDER BY PC.ALLOWANCE_ID, PC.PAY_TYPE, PC.SEX_TYPE
       ;
       
  END SELECT_PAY_SET;
  
-- 급상여 계산환경등록 항목 전체 조회.
  PROCEDURE SELECT_PAYMENT_SET_ITEM_ALL
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            )
  AS 
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT  PS.PAYMENT_SET_CODE
            , PS.PAYMENT_SET_NAME
            , PS.DEFAULT_VALUE
            , PS.CAL_START_DATE
            , PS.CAL_END_DATE
        FROM HRM_PAYMENT_SET_V PS
       WHERE PS.SOB_ID                  = W_SOB_ID
         AND PS.ORG_ID                  = W_ORG_ID
         AND PS.ENABLED_FLAG            = 'Y'
         AND PS.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
         AND (PS.EFFECTIVE_DATE_TO IS NULL OR PS.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')))
      ;
  
  END SELECT_PAYMENT_SET_ITEM_ALL;
  
-- 급상여 지급/공제 항목 전체 조회.
  PROCEDURE SELECT_ALLOWANCE_ITEM_ALL
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      -- 급상여 지급/공제 항목.
      SELECT SX.ALLOWANCE_CODE
           , SX.ALLOWANCE_NAME
        FROM (SELECT AV.ALLOWANCE_ID
                   , AV.ALLOWANCE_CODE
                   , AV.ALLOWANCE_NAME
                   , 'A' AS ALLOWANCE_TYPE
                   , AV.SOB_ID
                   , AV.ORG_ID
                FROM HRM_ALLOWANCE_V AV
               WHERE AV.ENABLED_FLAG            = 'Y'
                 AND AV.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
                 AND (AV.EFFECTIVE_DATE_TO IS NULL OR AV.EFFECTIVE_DATE_TO >=  TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')))
              UNION ALL
              SELECT DV.DEDUCTION_ID AS ALLOWANCE_ID
                   , DV.DEDUCTION_CODE AS ALLOWANCE_CODE
                   , DV.DEDUCTION_NAME AS ALLOWANCE_NAME
                   , 'D' AS ALLOWANCE_TYPE 
                   , DV.SOB_ID
                   , DV.ORG_ID    
                FROM HRM_DEDUCTION_V DV
               WHERE DV.ENABLED_FLAG            = 'Y'
                 AND DV.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
                 AND (DV.EFFECTIVE_DATE_TO IS NULL OR DV.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')))
              ) SX
       WHERE SX.SOB_ID                  = W_SOB_ID
         AND SX.ORG_ID                  = W_ORG_ID
      ORDER BY SX.ALLOWANCE_CODE
      ;
  END SELECT_ALLOWANCE_ITEM_ALL;

-- 월근태 집계 항목 전체 조회.
  PROCEDURE SELECT_DUTY_ITEM_ALL
            ( P_CURSOR3         OUT TYPES.TCURSOR3
            , W_STD_YYYYMM      IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_SOB_ID          IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID          IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT OT.MONTH_TOTAL_ITEM AS DUTY_ITEM
           , OT.OT_TYPE_NAME AS DUTY_ITEM_NAME
        FROM HRM_OT_TYPE_V OT
       WHERE OT.SOB_ID                  = W_SOB_ID
         AND OT.ORG_ID                  = W_ORG_ID
         AND OT.ENABLED_FLAG            = 'Y'
         AND OT.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
         AND (OT.EFFECTIVE_DATE_TO IS NULL OR OT.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')))
      UNION ALL
      SELECT MTI.MONTH_TOTAL_ITEM AS DUTY_ITEM
           , MTI.MONTH_TOTAL_ITEM_NAME AS DUTY_ITEM_NAME
        FROM HRM_MONTH_TOTAL_ITEM_V MTI
       WHERE MTI.SOB_ID                 = W_SOB_ID
         AND MTI.ORG_ID                 = W_ORG_ID
         AND MTI.ENABLED_FLAG           = 'Y'
         AND MTI.EFFECTIVE_DATE_FR      <= LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'))
         AND (MTI.EFFECTIVE_DATE_TO IS NULL OR MTI.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM')))
      ORDER BY DUTY_ITEM
      ;
  
  END SELECT_DUTY_ITEM_ALL;

---------------------------------------------------------------------------------------------------
-- 지급/공제 항목 삽입.
  PROCEDURE ALLOWANCE_INSERT
            ( P_COMMON_ID         OUT HRM_COMMON.COMMON_ID%TYPE
            , P_ALLOWANCE_TYPE    IN HRM_ALLOWANCE_TYPE_V.ALLOWANCE_TYPE%TYPE
            , P_CODE              IN HRM_COMMON.CODE%TYPE
            , P_CODE_NAME         IN HRM_COMMON.CODE_NAME%TYPE
            , P_SORT_NUM          IN HRM_COMMON.SORT_NUM%TYPE
            , P_ENABLED_FLAG      IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_SOB_ID            IN HRM_COMMON.SOB_ID%TYPE
            , P_ORG_ID            IN HRM_COMMON.ORG_ID%TYPE
            , P_USER_ID           IN HRM_COMMON.CREATED_BY%TYPE 
            )
  AS
    V_GROUP_CODE                  HRM_ALLOWANCE_TYPE_V.FULL_ALLOWANCE_TYPE%TYPE;
    
  BEGIN
    BEGIN
      SELECT AT.FULL_ALLOWANCE_TYPE
        INTO V_GROUP_CODE
        FROM HRM_ALLOWANCE_TYPE_V AT
       WHERE AT.ALLOWANCE_TYPE    = P_ALLOWANCE_TYPE
         AND AT.ENABLED_FLAG      = 'Y'
         AND AT.EFFECTIVE_DATE_FR <= TRUNC(SYSDATE)
         AND (AT.EFFECTIVE_DATE_TO IS NULL OR AT.EFFECTIVE_DATE_TO >= TRUNC(SYSDATE))
         AND AT.SOB_ID            = P_SOB_ID
         AND AT.ORG_ID            = P_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Data_Not_Found;
    END;
    HRM_COMMON_G.COMMON_INSERT_L( P_COMMON_ID => P_COMMON_ID
                                , P_GROUP_CODE => V_GROUP_CODE
                                , P_CODE => P_CODE
                                , P_CODE_NAME => P_CODE_NAME
                                , P_VALUE1 => NULL
                                , P_VALUE2 => NULL
                                , P_VALUE3 => NULL
                                , P_VALUE4 => NULL
                                , P_VALUE5 => NULL
                                , P_VALUE6 => NULL
                                , P_VALUE7 => NULL
                                , P_VALUE8 => NULL
                                , P_VALUE9 => NULL
                                , P_VALUE10 => NULL
                                , P_DEFAULT_FLAG => 'N'
                                , P_SORT_NUM => P_SORT_NUM
                                , P_DESCRIPTION => NULL
                                , P_ENABLED_FLAG => P_ENABLED_FLAG
                                , P_EFFECTIVE_DATE_FR => P_EFFECTIVE_DATE_FR
                                , P_EFFECTIVE_DATE_TO => P_EFFECTIVE_DATE_TO
                                , P_SOB_ID => P_SOB_ID
                                , P_ORG_ID => P_ORG_ID
                                , P_USER_ID => P_USER_ID
                                );
  
  EXCEPTION 
    WHEN ERRNUMS.Data_Not_Found THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, 'Group Code : ' || ERRNUMS.Data_Not_Found_Desc);
  END ALLOWANCE_INSERT;

  PROCEDURE ALLOWANCE_UPDATE
            ( W_COMMON_ID         IN HRM_COMMON.COMMON_ID%TYPE
            , P_CODE_NAME         IN HRM_COMMON.CODE_NAME%TYPE
            , P_SORT_NUM          IN HRM_COMMON.SORT_NUM%TYPE
            , P_ENABLED_FLAG      IN HRM_COMMON.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_DATE_FR IN HRM_COMMON.EFFECTIVE_DATE_FR%TYPE
            , P_EFFECTIVE_DATE_TO IN HRM_COMMON.EFFECTIVE_DATE_TO%TYPE
            , P_USER_ID           IN HRM_COMMON.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    HRM_COMMON_G.COMMON_UPDATE_L( W_COMMON_ID => W_COMMON_ID
                                , P_CODE_NAME => P_CODE_NAME
                                , P_VALUE1 => NULL
                                , P_VALUE2 => NULL
                                , P_VALUE3 => NULL
                                , P_VALUE4 => NULL
                                , P_VALUE5 => NULL
                                , P_VALUE6 => NULL
                                , P_VALUE7 => NULL
                                , P_VALUE8 => NULL
                                , P_VALUE9 => NULL
                                , P_VALUE10 => NULL
                                , P_DEFAULT_FLAG => 'N'
                                , P_SORT_NUM => P_SORT_NUM
                                , P_DESCRIPTION => NULL
                                , P_ENABLED_FLAG => P_ENABLED_FLAG
                                , P_EFFECTIVE_DATE_FR => P_EFFECTIVE_DATE_FR
                                , P_EFFECTIVE_DATE_TO => P_EFFECTIVE_DATE_TO
                                , P_USER_ID => P_USER_ID
                                );
  
  END ALLOWANCE_UPDATE;
  
---------------------------------------------------------------------------------------------------
-- PAY_CALCULATE_INSERT
  PROCEDURE PAY_CALCULATE_INSERT
            ( P_CALCULATE_ID         OUT HRP_PAY_CALCULATE.CALCULATE_ID%TYPE
            , P_CORP_ID              IN HRP_PAY_CALCULATE.CORP_ID%TYPE
            , P_WAGE_TYPE            IN HRP_PAY_CALCULATE.WAGE_TYPE%TYPE
            , P_ALLOWANCE_TYPE       IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID         IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE             IN HRP_PAY_CALCULATE.PAY_TYPE%TYPE
            , P_SEX_TYPE             IN HRP_PAY_CALCULATE.SEX_TYPE%TYPE
            , P_TAX_YN               IN HRP_PAY_CALCULATE.TAX_YN%TYPE
            , P_TAX_FREE_TYPE        IN HRP_PAY_CALCULATE.TAX_FREE_TYPE%TYPE
            , P_ROOKIE_YN            IN HRP_PAY_CALCULATE.ROOKIE_YN%TYPE
            , P_EXCEPTION_YN         IN HRP_PAY_CALCULATE.EXCEPTION_YN%TYPE
            , P_MONTHLY_PAY_YN       IN HRP_PAY_CALCULATE.MONTHLY_PAY_YN%TYPE
            , P_GRADE_YN             IN HRP_PAY_CALCULATE.GRADE_YN%TYPE
            , P_PAY_MASTER_YN        IN HRP_PAY_CALCULATE.PAY_MASTER_YN%TYPE
            , P_ADD_ALLOWANCE_YN     IN HRP_PAY_CALCULATE.ADD_ALLOWANCE_YN%TYPE
            , P_RETIRE_ADJUSTMENT_YN IN HRP_PAY_CALCULATE.RETIRE_ADJUSTMENT_YN%TYPE
            , P_YEAR_ALLOWANCE_YN    IN HRP_PAY_CALCULATE.YEAR_ALLOWANCE_YN%TYPE
            , P_EMPLOYMENT_INSUR_YN  IN HRP_PAY_CALCULATE.EMPLOYMENT_INSUR_YN%TYPE
            , P_DECIMAL_TYPE         IN HRP_PAY_CALCULATE.DECIMAL_TYPE%TYPE
            , P_DIGIT_NUMBER         IN HRP_PAY_CALCULATE.DIGIT_NUMBER%TYPE
            , P_TEMP_RETIRE_YN       IN HRP_PAY_CALCULATE.TEMP_RETIRE_YN%TYPE
            , P_SYSTEM_CALCULATION   IN HRP_PAY_CALCULATE.SYSTEM_CALCULATION%TYPE
            , P_IF_CONDITION         IN HRP_PAY_CALCULATE.IF_CONDITION%TYPE
            , P_TRUE_VALUE           IN HRP_PAY_CALCULATE.TRUE_VALUE%TYPE
            , P_FALSE_VALUE          IN HRP_PAY_CALCULATE.FALSE_VALUE%TYPE
            , P_E_SYSTEM_CALCULATION IN HRP_PAY_CALCULATE.E_SYSTEM_CALCULATION%TYPE
            , P_E_IF_CONDITION       IN HRP_PAY_CALCULATE.E_IF_CONDITION%TYPE
            , P_E_TRUE_VALUE         IN HRP_PAY_CALCULATE.E_TRUE_VALUE%TYPE
            , P_E_FALSE_VALUE        IN HRP_PAY_CALCULATE.E_FALSE_VALUE%TYPE
            , P_DESCRIPTION          IN HRP_PAY_CALCULATE.DESCRIPTION%TYPE           
            , P_ENABLED_FLAG         IN HRP_PAY_CALCULATE.ENABLED_FLAG%TYPE
            , P_STD_YYYYMM           IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , P_SOB_ID               IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , P_ORG_ID               IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            , P_USER_ID              IN HRP_PAY_CALCULATE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                        DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_CALCULATE_ID                   HRP_PAY_CALCULATE.CALCULATE_ID%TYPE;
      
  BEGIN
    -- 같은 시작년월 데이터 Insert --> Error 발생.
    BEGIN
      SELECT PC.CALCULATE_ID
        INTO V_CALCULATE_ID
        FROM HRP_PAY_CALCULATE PC
       WHERE PC.CORP_ID             = P_CORP_ID
         AND PC.WAGE_TYPE           = P_WAGE_TYPE
         AND PC.ALLOWANCE_ID        = P_ALLOWANCE_ID
         AND PC.PAY_TYPE            = P_PAY_TYPE
         AND PC.SEX_TYPE            = NVL(P_SEX_TYPE, PC.SEX_TYPE)
         AND PC.EFFECTIVE_YYYYMM_FR >= P_STD_YYYYMM
         AND PC.SOB_ID              = P_SOB_ID
         AND PC.ORG_ID              = P_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_CALCULATE_ID := 0;
    END;
    IF V_CALCULATE_ID <> 0 THEN
      RAISE ERRNUMS.Exist_Data;
    END IF;

    -- 기존 자료 존재시 BACKUP 후 INSERT.
    BEGIN
      UPDATE HRP_PAY_CALCULATE PC
        SET PC.EFFECTIVE_YYYYMM_TO  = P_STD_YYYYMM - 1
       WHERE PC.CORP_ID             = P_CORP_ID
         AND PC.WAGE_TYPE           = P_WAGE_TYPE
         AND PC.ALLOWANCE_ID        = P_ALLOWANCE_ID
         AND PC.PAY_TYPE            = P_PAY_TYPE
         AND PC.SEX_TYPE            = NVL(P_SEX_TYPE, PC.SEX_TYPE)
         AND PC.EFFECTIVE_YYYYMM_FR <= P_STD_YYYYMM
         AND (PC.EFFECTIVE_YYYYMM_TO IS NULL OR PC.EFFECTIVE_YYYYMM_TO >= P_STD_YYYYMM)
         AND PC.SOB_ID              = P_SOB_ID
         AND PC.ORG_ID              = P_ORG_ID
       ;
    END;

    SELECT HRP_PAY_CALCULATE_S1.NEXTVAL
      INTO P_CALCULATE_ID
      FROM DUAL;

    INSERT INTO HRP_PAY_CALCULATE
    ( CALCULATE_ID
    , CORP_ID 
    , WAGE_TYPE
    , ALLOWANCE_TYPE 
    , ALLOWANCE_ID 
    , PAY_TYPE 
    , SEX_TYPE 
    , TAX_YN 
    , TAX_FREE_TYPE 
    , ROOKIE_YN 
    , EXCEPTION_YN 
    , MONTHLY_PAY_YN 
    , GRADE_YN
    , PAY_MASTER_YN
    , ADD_ALLOWANCE_YN
    , RETIRE_ADJUSTMENT_YN 
    , YEAR_ALLOWANCE_YN
    , EMPLOYMENT_INSUR_YN 
    , DECIMAL_TYPE 
    , DIGIT_NUMBER 
    , TEMP_RETIRE_YN 
    , SYSTEM_CALCULATION 
    , IF_CONDITION 
    , TRUE_VALUE 
    , FALSE_VALUE 
    , E_SYSTEM_CALCULATION 
    , E_IF_CONDITION 
    , E_TRUE_VALUE 
    , E_FALSE_VALUE 
    , DESCRIPTION 
    , ENABLED_FLAG 
    , EFFECTIVE_YYYYMM_FR 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_CALCULATE_ID
    , P_CORP_ID
    , P_WAGE_TYPE
    , P_ALLOWANCE_TYPE
    , P_ALLOWANCE_ID
    , P_PAY_TYPE
    , P_SEX_TYPE
    , P_TAX_YN
    , P_TAX_FREE_TYPE
    , P_ROOKIE_YN
    , P_EXCEPTION_YN
    , P_MONTHLY_PAY_YN
    , P_GRADE_YN
    , P_PAY_MASTER_YN
    , P_ADD_ALLOWANCE_YN
    , P_RETIRE_ADJUSTMENT_YN
    , P_YEAR_ALLOWANCE_YN
    , P_EMPLOYMENT_INSUR_YN
    , P_DECIMAL_TYPE
    , P_DIGIT_NUMBER
    , P_TEMP_RETIRE_YN
    , P_SYSTEM_CALCULATION
    , P_IF_CONDITION
    , P_TRUE_VALUE
    , P_FALSE_VALUE
    , P_E_SYSTEM_CALCULATION
    , P_E_IF_CONDITION
    , P_E_TRUE_VALUE
    , P_E_FALSE_VALUE
    , P_DESCRIPTION
    , P_ENABLED_FLAG
    , P_STD_YYYYMM
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );

  EXCEPTION
    WHEN ERRNUMS.Invalid_Sequence_ID THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END PAY_CALCULATE_INSERT;

-- PAY_CALCULAT_UPDATE.
  PROCEDURE PAY_CALCULAT_UPDATE
            ( W_CALCULATE_ID         IN HRP_PAY_CALCULATE.CALCULATE_ID%TYPE
            , P_CORP_ID              IN HRP_PAY_CALCULATE.CORP_ID%TYPE
            , P_WAGE_TYPE            IN HRP_PAY_CALCULATE.WAGE_TYPE%TYPE
            , P_ALLOWANCE_TYPE       IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID         IN HRP_PAY_CALCULATE.ALLOWANCE_ID%TYPE
            , P_PAY_TYPE             IN HRP_PAY_CALCULATE.PAY_TYPE%TYPE
            , P_SEX_TYPE             IN HRP_PAY_CALCULATE.SEX_TYPE%TYPE
            , P_TAX_YN               IN HRP_PAY_CALCULATE.TAX_YN%TYPE
            , P_TAX_FREE_TYPE        IN HRP_PAY_CALCULATE.TAX_FREE_TYPE%TYPE
            , P_ROOKIE_YN            IN HRP_PAY_CALCULATE.ROOKIE_YN%TYPE
            , P_EXCEPTION_YN         IN HRP_PAY_CALCULATE.EXCEPTION_YN%TYPE
            , P_MONTHLY_PAY_YN       IN HRP_PAY_CALCULATE.MONTHLY_PAY_YN%TYPE
            , P_GRADE_YN             IN HRP_PAY_CALCULATE.GRADE_YN%TYPE
            , P_PAY_MASTER_YN        IN HRP_PAY_CALCULATE.PAY_MASTER_YN%TYPE
            , P_ADD_ALLOWANCE_YN     IN HRP_PAY_CALCULATE.ADD_ALLOWANCE_YN%TYPE
            , P_RETIRE_ADJUSTMENT_YN IN HRP_PAY_CALCULATE.RETIRE_ADJUSTMENT_YN%TYPE
            , P_YEAR_ALLOWANCE_YN    IN HRP_PAY_CALCULATE.YEAR_ALLOWANCE_YN%TYPE
            , P_EMPLOYMENT_INSUR_YN  IN HRP_PAY_CALCULATE.EMPLOYMENT_INSUR_YN%TYPE
            , P_DECIMAL_TYPE         IN HRP_PAY_CALCULATE.DECIMAL_TYPE%TYPE
            , P_DIGIT_NUMBER         IN HRP_PAY_CALCULATE.DIGIT_NUMBER%TYPE
            , P_TEMP_RETIRE_YN       IN HRP_PAY_CALCULATE.TEMP_RETIRE_YN%TYPE
            , P_SYSTEM_CALCULATION   IN HRP_PAY_CALCULATE.SYSTEM_CALCULATION%TYPE
            , P_IF_CONDITION         IN HRP_PAY_CALCULATE.IF_CONDITION%TYPE
            , P_TRUE_VALUE           IN HRP_PAY_CALCULATE.TRUE_VALUE%TYPE
            , P_FALSE_VALUE          IN HRP_PAY_CALCULATE.FALSE_VALUE%TYPE
            , P_E_SYSTEM_CALCULATION IN HRP_PAY_CALCULATE.E_SYSTEM_CALCULATION%TYPE
            , P_E_IF_CONDITION       IN HRP_PAY_CALCULATE.E_IF_CONDITION%TYPE
            , P_E_TRUE_VALUE         IN HRP_PAY_CALCULATE.E_TRUE_VALUE%TYPE
            , P_E_FALSE_VALUE        IN HRP_PAY_CALCULATE.E_FALSE_VALUE%TYPE
            , P_DESCRIPTION          IN HRP_PAY_CALCULATE.DESCRIPTION%TYPE
            , P_ENABLED_FLAG         IN HRP_PAY_CALCULATE.ENABLED_FLAG%TYPE
            , P_EFFECTIVE_YYYYMM_FR  IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , P_EFFECTIVE_YYYYMM_TO  IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_TO%TYPE
            , P_SOB_ID               IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , P_ORG_ID               IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            , P_USER_ID              IN HRP_PAY_CALCULATE.CREATED_BY%TYPE
            , O_CALCULATE_ID         OUT HRP_PAY_CALCULATE.CALCULATE_ID%TYPE
            )
  AS
    V_SYSDATE                        DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    UPDATE HRP_PAY_CALCULATE
      SET SEX_TYPE             = P_SEX_TYPE
        , TAX_YN               = P_TAX_YN
        , TAX_FREE_TYPE        = P_TAX_FREE_TYPE
        , ROOKIE_YN            = P_ROOKIE_YN
        , EXCEPTION_YN         = P_EXCEPTION_YN
        , MONTHLY_PAY_YN       = P_MONTHLY_PAY_YN
        , GRADE_YN             = P_GRADE_YN
        , PAY_MASTER_YN        = P_PAY_MASTER_YN
        , ADD_ALLOWANCE_YN     = P_ADD_ALLOWANCE_YN
        , RETIRE_ADJUSTMENT_YN = P_RETIRE_ADJUSTMENT_YN
        , YEAR_ALLOWANCE_YN    = P_YEAR_ALLOWANCE_YN
        , EMPLOYMENT_INSUR_YN  = P_EMPLOYMENT_INSUR_YN
        , DECIMAL_TYPE         = P_DECIMAL_TYPE
        , DIGIT_NUMBER         = P_DIGIT_NUMBER
        , TEMP_RETIRE_YN       = P_TEMP_RETIRE_YN
        , SYSTEM_CALCULATION   = P_SYSTEM_CALCULATION
        , IF_CONDITION         = P_IF_CONDITION
        , TRUE_VALUE           = P_TRUE_VALUE
        , FALSE_VALUE          = P_FALSE_VALUE
        , E_SYSTEM_CALCULATION = P_E_SYSTEM_CALCULATION
        , E_IF_CONDITION       = P_E_IF_CONDITION
        , E_TRUE_VALUE         = P_E_TRUE_VALUE
        , E_FALSE_VALUE        = P_E_FALSE_VALUE
        , DESCRIPTION          = P_DESCRIPTION
        , ENABLED_FLAG         = P_ENABLED_FLAG
        , EFFECTIVE_YYYYMM_FR  = P_EFFECTIVE_YYYYMM_FR
        , EFFECTIVE_YYYYMM_TO  = P_EFFECTIVE_YYYYMM_TO
        , SOB_ID               = P_SOB_ID
        , ORG_ID               = P_ORG_ID
        , LAST_UPDATE_DATE     = V_SYSDATE
        , LAST_UPDATED_BY      = P_USER_ID
    WHERE CALCULATE_ID         = W_CALCULATE_ID
    ;

  END PAY_CALCULAT_UPDATE;

-- LOOKUP : 급상여 지급/공제 항목 조회.
  PROCEDURE LU_ALLOWANCE
            ( P_CURSOR3          OUT TYPES.TCURSOR3
            , W_STD_YYYYMM       IN HRP_PAY_CALCULATE.EFFECTIVE_YYYYMM_FR%TYPE
            , W_ALLOWANCE_TYPE   IN HRP_PAY_CALCULATE.ALLOWANCE_TYPE%TYPE
            , W_SOB_ID           IN HRP_PAY_CALCULATE.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_PAY_CALCULATE.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN  IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            )
  AS
    V_START_DATE                 HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;
    V_END_DATE                   HRM_COMMON.EFFECTIVE_DATE_TO%TYPE := NULL;
		
  BEGIN
	  IF W_ENABLED_FLAG_YN = 'Y' THEN
		  V_START_DATE := TRUNC(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
      V_END_DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
      
		ELSE
		  V_START_DATE := NULL;
      V_END_DATE := NULL;
      
		END IF;
		
    OPEN P_CURSOR3 FOR
      -- 급상여 지급/공제 항목.
      SELECT SX.ALLOWANCE_NAME
           , SX.ALLOWANCE_CODE
           , SX.ALLOWANCE_ID
        FROM (SELECT AV.ALLOWANCE_ID
                   , AV.ALLOWANCE_CODE
                   , AV.ALLOWANCE_NAME
                   , 'A' AS ALLOWANCE_TYPE
                   , AV.SOB_ID
                   , AV.ORG_ID
                FROM HRM_ALLOWANCE_V AV
               WHERE AV.ENABLED_FLAG            = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', AV.ENABLED_FLAG)
                 AND AV.EFFECTIVE_DATE_FR       <= NVL(V_END_DATE, AV.EFFECTIVE_DATE_FR)
                 AND (AV.EFFECTIVE_DATE_TO IS NULL OR AV.EFFECTIVE_DATE_TO >= NVL(V_START_DATE, AV.EFFECTIVE_DATE_TO))
              UNION ALL
              SELECT DV.DEDUCTION_ID AS ALLOWANCE_ID
                   , DV.DEDUCTION_CODE AS ALLOWANCE_CODE
                   , DV.DEDUCTION_NAME AS ALLOWANCE_NAME
                   , 'D' AS ALLOWANCE_TYPE 
                   , DV.SOB_ID
                   , DV.ORG_ID    
                FROM HRM_DEDUCTION_V DV
               WHERE DV.ENABLED_FLAG            = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', DV.ENABLED_FLAG)
                 AND DV.EFFECTIVE_DATE_FR       <= NVL(V_END_DATE, DV.EFFECTIVE_DATE_FR)
                 AND (DV.EFFECTIVE_DATE_TO IS NULL OR DV.EFFECTIVE_DATE_TO >= NVL(V_START_DATE, DV.EFFECTIVE_DATE_TO))
              ) SX
       WHERE SX.ALLOWANCE_TYPE          = W_ALLOWANCE_TYPE
         AND SX.SOB_ID                  = W_SOB_ID
         AND SX.ORG_ID                  = W_ORG_ID
      ORDER BY SX.ALLOWANCE_CODE
      ;
  END LU_ALLOWANCE;
  
END HRP_PAY_CALCULATE_G;
/
