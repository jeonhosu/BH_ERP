CREATE OR REPLACE PACKAGE HRP_PAY_MASTER_G
AS

-- PAYMENT PERSON SELECT.
  PROCEDURE DATA_SELECT_PERSON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_END_DATE                          IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
            , W_PAY_GRADE_ID                      IN HRM_PERSON_MASTER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            );
            
-- PAY MASTER HEADER SELECT
  PROCEDURE DATA_SELECT_HEADER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            /*, W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE*/
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );

-- PAY MASTER LINE ALLOWANCE SELECT
  PROCEDURE DATA_SELECT_ALLOWANCE
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            );

-- PAY MASTER LINE ALLOWANCE SELECT
  PROCEDURE DATA_SELECT_DEDUCTION
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            );

-- PAY MASTER SELECT
  PROCEDURE PAY_MASTER_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );

-- PAY MASTER SELECT(TERM)
  PROCEDURE PAY_MASTER_SELECT1
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_PAY_MASTER_HEADER.END_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            );
            
-- ???????? ???? ?????? ????.
  PROCEDURE SELECT_FAMILY_ALLOWANCE
            ( P_CURSOR2          OUT TYPES.TCURSOR2
            , W_PERSON_ID        IN HRM_FAMILY.PERSON_ID%TYPE
            );

-- ???????? ?????? ???? ???? ????.
  PROCEDURE SELECT_GRADE_STEP_AMOUNT
            ( P_CURSOR3          OUT TYPES.TCURSOR3
            , W_CORP_ID          IN HRP_GRADE_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM       IN HRP_GRADE_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE         IN HRP_GRADE_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID     IN HRP_GRADE_HEADER.PAY_GRADE_ID%TYPE
            , W_GRADE_STEP       IN HRP_GRADE_LINE.GRADE_STEP%TYPE
            , W_SOB_ID           IN HRP_GRADE_HEADER.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_GRADE_HEADER.ORG_ID%TYPE
            );
---------------------------------------------------------------------------------------------------
-- PERSON INSERT(BLANK PROCEDURE)
  PROCEDURE PERSON_INSERT
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            );
            
-- PERSON UPDATE(BLANK PROCEDURE)
  PROCEDURE PERSON_UPDATE
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            );

-- ???? ?????? ???? ????(?????????? ???? ???????? ???????? ????).
  PROCEDURE PAY_HEADER_SAVE
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );

-- ???? ?????? ???? ????(?????????? ???? ???????? ???????? ????).
  PROCEDURE PAY_LINE_SAVE
            ( P_PAY_LINE_ID      OUT HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_PAY_HEADER_ID    IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_ALLOWANCE_TYPE   IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID     IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );
            
-- PAY_MASTER_HEADER_INSERT
  PROCEDURE PAY_HEADER_INSERT
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );

-- PAY_MASTER_HEADER_UPDATE.
  PROCEDURE PAY_HEADER_UPDATE
            ( P_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE
            );

-- PAY_MASTER_HEADER_BACKUP.
  PROCEDURE PAY_HEADER_BACKUP
            ( W_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_END_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            );            

-- PAY_MASTER_LINE_INSERT
  PROCEDURE PAY_LINE_INSERT
            ( P_PAY_LINE_ID      OUT HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_PAY_HEADER_ID    IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_ALLOWANCE_TYPE   IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID     IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );

-- PAY_MASTER_LINE_UPDATE.
  PROCEDURE PAY_LINE_UPDATE
            ( W_PAY_LINE_ID      IN HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );

-- PAY_MASTER_LINE_COPY : ?????????? ???????? COPY.
  PROCEDURE PAY_LINE_COPY
            ( P_PAY_HEADER_ID     IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_NEW_PAY_HEADER_ID IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID           IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            );

-- ???? ?????????? ???? ???? ID RETURN.
  FUNCTION PAY_HEADER_ID_CHECK_F
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN NUMBER;

-- ?????????? ?????? ???? ???????? ?????? ???? ???? ????.
  FUNCTION PAY_LAST_START_YYYYMM_F
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN VARCHAR2;
            
  -- DATA_SELECT.
  PROCEDURE PAYMENT_DATA_SELECT
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_PERSON_ID        IN NUMBER
            , W_SOB_ID           IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID           IN HRM_PERSON_MASTER.ORG_ID%TYPE           
            );
            
            
END HRP_PAY_MASTER_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRP_PAY_MASTER_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRP_PAY_MASTER_G
/* DESCRIPTION  : ?????? ???? ?????? ????.
/* REFERENCE BY :
/* PROGRAM HISTORY : ???? ????
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- PAYMENT PERSON SELECT.
  PROCEDURE DATA_SELECT_PERSON
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_END_DATE                          IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
            , W_PAY_GRADE_ID                      IN HRM_PERSON_MASTER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , (-- ???? ?????? HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PAY_GRADE_ID
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_STD_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
               AND PMH.PERSON_ID            = NVL(W_PERSON_ID, PMH.PERSON_ID)
               AND PMH.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID  
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.DEPT_ID          = DM.DEPT_ID
        AND PM.POST_ID          = PC.POST_ID
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND HL.PAY_GRADE_ID     = NVL(W_PAY_GRADE_ID, HL.PAY_GRADE_ID)
        AND PM.ORI_JOIN_DATE    <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ORDER BY DM.DEPT_CODE, PC.SORT_NUM, PM.PERSON_NUM
      ;  
  
  END DATA_SELECT_PERSON;
  
-- PAY MASTER HEADER SELECT
  PROCEDURE DATA_SELECT_HEADER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            /*, W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE*/
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    --V_END_DATE                                    DATE := NULL;
    
  BEGIN
    --V_END_DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    
    OPEN P_CURSOR FOR
      SELECT PMH.PAY_HEADER_ID
           , PMH.PERSON_ID
           , PMH.CORP_ID
           , PMH.START_YYYYMM
           , PMH.END_YYYYMM
           , PMH.PRINT_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
           , PMH.BANK_ID
           , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
           , PMH.BANK_ACCOUNTS
           , PMH.PAY_TYPE
           , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
           , PMH.PAY_GRADE_ID
           , PMH.GRADE_STEP
           , PMH.CORP_CAR_YN
           , PMH.PAY_PROVIDE_YN
           , PMH.BONUS_PROVIDE_YN
           , PMH.HIRE_INSUR_YN
           , PMH.DESCRIPTION
           , PMH.DED_FAMILY_COUNT
           , PMH.DED_CHILD_COUNT
           , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
        FROM HRP_PAY_MASTER_HEADER PMH
       WHERE PMH.CORP_ID              = W_CORP_ID
         AND PMH.START_YYYYMM         <= W_STD_YYYYMM
         AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
         AND PMH.PERSON_ID            = W_PERSON_ID
         AND PMH.PAY_TYPE             = NVL(W_PAY_TYPE, PMH.PAY_TYPE)
         AND PMH.SOB_ID               = W_SOB_ID
         AND PMH.ORG_ID               = W_ORG_ID
      ;
      
      /*SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , T1.PAY_HEADER_ID
           , T1.START_YYYYMM
           , T1.END_YYYYMM
           , T1.PRINT_TYPE
           , T1.PRINT_TYPE_NAME
           , T1.BANK_ID
           , T1.BANK_NAME
           , T1.BANK_ACCOUNTS
           , T1.PAY_TYPE
           , T1.PAY_TYPE_NAME
           , NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , T1.GRADE_STEP
           , NVL(T1.CORP_CAR_YN, 'N') AS CORP_CAR_YN
           , NVL(T1.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
           , NVL(T1.BONUS_PROVIDE_YN, 'N') AS BONUS_PROVIDE_YN
           , NVL(T1.HIRE_INSUR_YN, 'N') AS HIRE_INSUR_YN
           , T1.DESCRIPTION
           , T1.LAST_UPDATE_PERSON
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          , (-- ???? ?????? HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PRINT_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
                 , PMH.BANK_ID
                 , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                 , PMH.BANK_ACCOUNTS
                 , PMH.PAY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                 , PMH.PAY_GRADE_ID
                 , PMH.GRADE_STEP
                 , PMH.CORP_CAR_YN
                 , PMH.PAY_PROVIDE_YN
                 , PMH.BONUS_PROVIDE_YN
                 , PMH.HIRE_INSUR_YN
                 , PMH.DESCRIPTION
                 , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_STD_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
               AND PMH.PERSON_ID            = W_PERSON_ID
               AND PMH.PAY_TYPE             = NVL(W_PAY_TYPE, PMH.PAY_TYPE)
--               AND PMH.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID  
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.PERSON_ID        = W_PERSON_ID
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND HL.PAY_GRADE_ID     = NVL(W_PAY_GRADE_ID, HL.PAY_GRADE_ID)
        AND PM.ORI_JOIN_DATE    <= V_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_END_DATE)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ORDER BY HL.DEPT_ID, HL.POST_ID, HL.PERSON_ID
      ;*/
      
  END DATA_SELECT_HEADER;

-- PAY MASTER LINE ALLOWANCE SELECT
  PROCEDURE DATA_SELECT_ALLOWANCE
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PML.PAY_LINE_ID
           , PML.PAY_HEADER_ID
           , PML.ALLOWANCE_TYPE
           , PML.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME
           , PML.ALLOWANCE_AMOUNT
           , PML.ENABLED_FLAG
        FROM HRP_PAY_MASTER_LINE PML
          , HRM_ALLOWANCE_V HA
      WHERE PML.ALLOWANCE_ID          = HA.ALLOWANCE_ID
        AND PML.PAY_HEADER_ID         = W_PAY_HEADER_ID
        AND PML.ALLOWANCE_TYPE        = 'A'
      ORDER BY HA.SORT_NUM  
      ;  
      
  END DATA_SELECT_ALLOWANCE;

-- PAY MASTER LINE DEDCTION SELECT
  PROCEDURE DATA_SELECT_DEDUCTION
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_PAY_HEADER_ID                     IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT PML.PAY_LINE_ID
           , PML.PAY_HEADER_ID
           , PML.ALLOWANCE_TYPE
           , PML.ALLOWANCE_ID
           , HD.DEDUCTION_NAME
           , PML.ALLOWANCE_AMOUNT
           , PML.ENABLED_FLAG
        FROM HRP_PAY_MASTER_LINE PML
          , HRM_DEDUCTION_V HD
      WHERE PML.ALLOWANCE_ID          = HD.DEDUCTION_ID
        AND PML.PAY_HEADER_ID         = W_PAY_HEADER_ID
        AND PML.ALLOWANCE_TYPE        = 'D'
      ORDER BY HD.SORT_NUM  
      ;  
  END DATA_SELECT_DEDUCTION;
  
-- PAY MASTER SELECT
  PROCEDURE PAY_MASTER_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM                        IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    V_END_DATE                                    DATE := NULL;
    
  BEGIN
    V_END_DATE := LAST_DAY(TO_DATE(W_STD_YYYYMM, 'YYYY-MM'));
    
    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , T1.PAY_HEADER_ID
           , T1.START_YYYYMM
           , T1.END_YYYYMM
           , T1.PRINT_TYPE
           , T1.PRINT_TYPE_NAME
           , T1.BANK_ID
           , T1.BANK_NAME
           , T1.BANK_ACCOUNTS
           , T1.PAY_TYPE
           , T1.PAY_TYPE_NAME
           , NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , T1.GRADE_STEP
           , NVL(T1.CORP_CAR_YN, 'N') AS CORP_CAR_YN
           , NVL(T1.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
           , NVL(T1.BONUS_PROVIDE_YN, 'N') AS BONUS_PROVIDE_YN
           , NVL(T1.HIRE_INSUR_YN, 'N') AS HIRE_INSUR_YN
           , T1.DESCRIPTION
           , T1.LAST_UPDATE_PERSON
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , (-- ???? ?????? HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PRINT_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
                 , PMH.BANK_ID
                 , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                 , PMH.BANK_ACCOUNTS
                 , PMH.PAY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                 , PMH.PAY_GRADE_ID
                 , PMH.GRADE_STEP
                 , PMH.CORP_CAR_YN
                 , PMH.PAY_PROVIDE_YN
                 , PMH.BONUS_PROVIDE_YN
                 , PMH.HIRE_INSUR_YN
                 , PMH.DESCRIPTION
                 , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_STD_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_STD_YYYYMM)
               AND PMH.PERSON_ID            = W_PERSON_ID
               AND PMH.PAY_TYPE             = NVL(W_PAY_TYPE, PMH.PAY_TYPE)
               AND PMH.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID  
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.DEPT_ID          = DM.DEPT_ID
        AND PM.POST_ID          = PC.POST_ID
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.PERSON_ID        = W_PERSON_ID
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND HL.PAY_GRADE_ID     = NVL(W_PAY_GRADE_ID, HL.PAY_GRADE_ID)
        AND PM.ORI_JOIN_DATE    <= V_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_END_DATE)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ORDER BY DM.DEPT_CODE, PC.SORT_NUM, PM.PERSON_NUM
      ;
  
  END PAY_MASTER_SELECT;

-- PAY MASTER SELECT(TERM)
  PROCEDURE PAY_MASTER_SELECT1
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , W_START_YYYYMM                      IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , W_END_YYYYMM                        IN HRP_PAY_MASTER_HEADER.END_YYYYMM%TYPE
            , W_PAY_TYPE                          IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID                      IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_PERSON_ID                         IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            )
  AS
    V_START_DATE                                  DATE := NULL;
    V_END_DATE                                    DATE := NULL;
  BEGIN
    V_START_DATE := TRUNC(TO_DATE(W_START_YYYYMM, 'YYYY-MM'), 'MONTH');
    V_END_DATE := LAST_DAY(TO_DATE(W_END_YYYYMM, 'YYYY-MM'));
    
    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , PM.NAME
           , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE_NAME
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.PAY_DATE
           , PM.RETIRE_DATE
           , T1.PAY_HEADER_ID
           , T1.START_YYYYMM
           , T1.END_YYYYMM
           , T1.PRINT_TYPE
           , T1.PRINT_TYPE_NAME
           , T1.BANK_ID
           , T1.BANK_NAME
           , T1.BANK_ACCOUNTS
           , T1.PAY_TYPE
           , T1.PAY_TYPE_NAME
           , NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID) AS PAY_GRADE_ID
           , HRM_COMMON_G.ID_NAME_F(NVL(T1.PAY_GRADE_ID, HL.PAY_GRADE_ID)) AS PAY_GRADE_NAME           
           , T1.GRADE_STEP
           , NVL(T1.CORP_CAR_YN, 'N') AS CORP_CAR_YN
           , NVL(T1.PAY_PROVIDE_YN, 'N') AS PAY_PROVIDE_YN
           , NVL(T1.BONUS_PROVIDE_YN, 'N') AS BONUS_PROVIDE_YN
           , NVL(T1.HIRE_INSUR_YN, 'N') AS HIRE_INSUR_YN
           , T1.DESCRIPTION
           , T1.LAST_UPDATE_PERSON
           , PM.DISPLAY_NAME
           , PM.PERSON_ID 
           , PM.CORP_ID
        FROM HRM_HISTORY_LINE HL  
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , (-- ???? ?????? HEADER.
            SELECT PMH.PAY_HEADER_ID
                 , PMH.PERSON_ID
                 , PMH.START_YYYYMM
                 , PMH.END_YYYYMM
                 , PMH.PRINT_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PRINT_TYPE', PMH.PRINT_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PRINT_TYPE_NAME
                 , PMH.BANK_ID
                 , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                 , PMH.BANK_ACCOUNTS
                 , PMH.PAY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, PMH.SOB_ID, PMH.ORG_ID) AS PAY_TYPE_NAME
                 , PMH.PAY_GRADE_ID
                 , PMH.GRADE_STEP
                 , PMH.CORP_CAR_YN
                 , PMH.PAY_PROVIDE_YN
                 , PMH.BONUS_PROVIDE_YN
                 , PMH.HIRE_INSUR_YN
                 , PMH.DESCRIPTION
                 , EAPP_USER_G.USER_NAME_F(PMH.LAST_UPDATED_BY) AS LAST_UPDATE_PERSON
              FROM HRP_PAY_MASTER_HEADER PMH
             WHERE PMH.CORP_ID              = W_CORP_ID
               AND PMH.START_YYYYMM         <= W_END_YYYYMM
               AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM >= W_END_YYYYMM)
               AND PMH.PERSON_ID            = NVL(W_PERSON_ID, PMH.PERSON_ID)
               AND PMH.PAY_TYPE             = NVL(W_PAY_TYPE, PMH.PAY_TYPE)
               AND PMH.PAY_GRADE_ID         = NVL(W_PAY_GRADE_ID, PMH.PAY_GRADE_ID)
               AND PMH.SOB_ID               = W_SOB_ID
               AND PMH.ORG_ID               = W_ORG_ID  
            )T1
      WHERE HL.PERSON_ID        = PM.PERSON_ID
        AND PM.DEPT_ID          = DM.DEPT_ID
        AND PM.POST_ID          = PC.POST_ID
        AND PM.PERSON_ID        = T1.PERSON_ID(+)
        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                      FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= V_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )
        AND PM.CORP_ID          = W_CORP_ID
        AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND HL.DEPT_ID          = NVL(W_DEPT_ID, HL.DEPT_ID)
        AND HL.PAY_GRADE_ID     = NVL(W_PAY_GRADE_ID, HL.PAY_GRADE_ID)
        AND PM.ORI_JOIN_DATE    <= V_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_START_DATE)
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ORDER BY DM.DEPT_CODE, PC.SORT_NUM, PM.PERSON_NUM
      ;
  END PAY_MASTER_SELECT1;
  
-- ???????? ???? ?????? ????.
  PROCEDURE SELECT_FAMILY_ALLOWANCE
            ( P_CURSOR2          OUT TYPES.TCURSOR2
            , W_PERSON_ID        IN HRM_FAMILY.PERSON_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT HF.PERSON_ID
          , YR.YEAR_RELATION_NAME
          , SUM( CASE 
                    WHEN YR.YEAR_RELATION_CODE IN ('1', '2') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1
                    WHEN YR.YEAR_RELATION_CODE IN ('3') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1 
                    WHEN YR.YEAR_RELATION_CODE IN ('4', '5') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1
                    WHEN YR.YEAR_RELATION_CODE IN ('6', '7') AND HF.PAY_YN = 'Y' AND YR.FAMILY_ALLOWANCE_YN = 'Y' THEN 1
                    ELSE 0
                  END) AS RELACTION_COUNT
        FROM HRM_FAMILY HF
          , HRM_RELATION_V HR
          , HRM_YEAR_RELATION_V YR
       WHERE HF.RELATION_ID             = HR.RELATION_ID
         AND HR.YEAR_RELATION_CODE      = YR.YEAR_RELATION_CODE
         AND HR.SOB_ID                  = YR.SOB_ID
         AND HR.ORG_ID                  = YR.ORG_ID
         AND HF.PERSON_ID               = W_PERSON_ID             
         AND HR.ENABLED_FLAG            = 'Y'
         AND YR.ENABLED_FLAG            = 'Y'
      GROUP BY HF.PERSON_ID 
        , YR.YEAR_RELATION_NAME
      ;
      
  END SELECT_FAMILY_ALLOWANCE;

-- ???????? ?????? ???? ???? ????.
  PROCEDURE SELECT_GRADE_STEP_AMOUNT
            ( P_CURSOR3          OUT TYPES.TCURSOR3
            , W_CORP_ID          IN HRP_GRADE_HEADER.CORP_ID%TYPE
            , W_STD_YYYYMM       IN HRP_GRADE_HEADER.START_YYYYMM%TYPE
            , W_PAY_TYPE         IN HRP_GRADE_HEADER.PAY_TYPE%TYPE
            , W_PAY_GRADE_ID     IN HRP_GRADE_HEADER.PAY_GRADE_ID%TYPE
            , W_GRADE_STEP       IN HRP_GRADE_LINE.GRADE_STEP%TYPE
            , W_SOB_ID           IN HRP_GRADE_HEADER.SOB_ID%TYPE
            , W_ORG_ID           IN HRP_GRADE_HEADER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT GL.ALLOWANCE_ID
           , HA.ALLOWANCE_NAME
           , GL.ALLOWANCE_AMOUNT
        FROM HRP_GRADE_HEADER GH
          , HRP_GRADE_LINE GL
          , HRM_ALLOWANCE_V HA
       WHERE GH.GRADE_HEADER_ID       = GL.GRADE_HEADER_ID
         AND GL.ALLOWANCE_ID          = HA.ALLOWANCE_ID
         AND GH.CORP_ID               = W_CORP_ID
         AND GH.PAY_TYPE              = W_PAY_TYPE
         AND GH.PAY_GRADE_ID          = W_PAY_GRADE_ID
         AND GL.GRADE_STEP            = W_GRADE_STEP
         AND GH.SOB_ID                = W_SOB_ID
         AND GH.ORG_ID                = W_ORG_ID
         AND GH.START_YYYYMM          <= W_STD_YYYYMM
         AND GH.END_YYYYMM            >= W_STD_YYYYMM
         AND GH.ENABLED_FLAG          = 'Y'
      ORDER BY HA.SORT_NUM
      ;

  END SELECT_GRADE_STEP_AMOUNT;
  
---------------------------------------------------------------------------------------------------
-- PERSON INSERT(BLANK PROCEDURE)
  PROCEDURE PERSON_INSERT
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            )
  AS
  BEGIN
    NULL;
  END PERSON_INSERT;
            
-- PERSON UPDATE(BLANK PROCEDURE)
  PROCEDURE PERSON_UPDATE
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            )
  AS
  BEGIN
    NULL;
  END PERSON_UPDATE;

-- ???? ?????? ????(?????????? ???? ???????? ???????? ????).
  PROCEDURE PAY_HEADER_SAVE
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                    DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_LAST_START_YYYYMM          VARCHAR2(10) := NULL;
    V_PAY_HEADER_ID              HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE;
  BEGIN
    --RAISE_APPLICATION_ERROR(-20001, 'INSERT');
    -- ???? ?????????? ???? ?????? ???? ID ??.
    V_PAY_HEADER_ID := PAY_HEADER_ID_CHECK_F
                        ( P_PERSON_ID => P_PERSON_ID
                        , P_CORP_ID => P_CORP_ID
                        , P_STD_YYYYMM => P_STD_YYYYMM
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        );
                          
    -- ???????????? ????.
    V_LAST_START_YYYYMM := PAY_LAST_START_YYYYMM_F
                             ( P_PERSON_ID => P_PERSON_ID
                              , P_CORP_ID => P_CORP_ID
                              , P_SOB_ID => P_SOB_ID
                              , P_ORG_ID => P_ORG_ID
                             );
    IF V_PAY_HEADER_ID = 0 AND V_LAST_START_YYYYMM IS NULL THEN  -- ???? INSERT.
      HRP_PAY_MASTER_G.PAY_HEADER_INSERT
        ( P_PAY_HEADER_ID
        , P_PERSON_ID
        , P_CORP_ID
        , P_STD_YYYYMM
        , P_PRINT_TYPE
        , P_BANK_ID
        , P_BANK_ACCOUNTS
        , P_PAY_TYPE
        , P_PAY_GRADE_ID
        , P_GRADE_STEP
        , P_CORP_CAR_YN
        , P_PAY_PROVIDE_YN
        , P_BONUS_PROVIDE_YN
        , P_HIRE_INSUR_YN
        , P_DED_FAMILY_COUNT
        , P_DED_CHILD_COUNT
        , P_DESCRIPTION
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID 
        );
    ELSIF V_LAST_START_YYYYMM < P_STD_YYYYMM THEN     -- ???????????? ?????????? ?? ???? : ?????? ?????? ????.
      -- ???????? BACKUP.
      IF V_PAY_HEADER_ID <> 0 THEN
        PAY_HEADER_BACKUP ( W_PAY_HEADER_ID => V_PAY_HEADER_ID
                          , P_END_YYYYMM => TO_CHAR(ADD_MONTHS(TO_DATE(P_STD_YYYYMM, 'YYYY-MM'), -1), 'YYYY-MM')
                          , P_USER_ID => P_USER_ID
                          );
      END IF;
      -- ???? INSERT.
      PAY_HEADER_INSERT ( P_PAY_HEADER_ID => P_PAY_HEADER_ID
                        , P_PERSON_ID => P_PERSON_ID
                        , P_CORP_ID => P_CORP_ID
                        , P_STD_YYYYMM => P_STD_YYYYMM
                        , P_PRINT_TYPE => P_PRINT_TYPE
                        , P_BANK_ID => P_BANK_ID                        
                        , P_BANK_ACCOUNTS => P_BANK_ACCOUNTS
                        , P_PAY_TYPE => P_PAY_TYPE
                        , P_PAY_GRADE_ID => P_PAY_GRADE_ID
                        , P_GRADE_STEP => P_GRADE_STEP
                        , P_CORP_CAR_YN => P_CORP_CAR_YN
                        , P_PAY_PROVIDE_YN => P_PAY_PROVIDE_YN
                        , P_BONUS_PROVIDE_YN => P_BONUS_PROVIDE_YN
                        , P_HIRE_INSUR_YN => P_HIRE_INSUR_YN
                        , P_DED_FAMILY_COUNT => P_DED_FAMILY_COUNT
                        , P_DED_CHILD_COUNT => P_DED_CHILD_COUNT
                        , P_DESCRIPTION => P_DESCRIPTION
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      -- ???? COPY.
      PAY_LINE_COPY ( P_PAY_HEADER_ID => V_PAY_HEADER_ID
                    , P_NEW_PAY_HEADER_ID => P_PAY_HEADER_ID
                    , P_SOB_ID => P_SOB_ID
                    , P_USER_ID => P_USER_ID
                    );
    ELSIF V_LAST_START_YYYYMM = P_STD_YYYYMM THEN  -- ?????????? ?????????? ???? ????.
      PAY_HEADER_UPDATE
            ( V_PAY_HEADER_ID
            , P_PERSON_ID
            , P_CORP_ID
            , P_PRINT_TYPE
            , P_BANK_ID
            , P_BANK_ACCOUNTS
            , P_PAY_TYPE
            , P_PAY_GRADE_ID
            , P_GRADE_STEP
            , P_CORP_CAR_YN
            , P_PAY_PROVIDE_YN
            , P_BONUS_PROVIDE_YN
            , P_HIRE_INSUR_YN
            , P_DED_FAMILY_COUNT
            , P_DED_CHILD_COUNT
            , P_DESCRIPTION
            , P_SOB_ID
            , P_ORG_ID
            , P_USER_ID
            );
    ELSE                                           -- ???????? ???? ?????? ???? : ???? ????.
      RAISE ERRNUMS.Exist_Next_Data;
    END IF;
  EXCEPTION
    WHEN ERRNUMS.Invalid_Sequence_ID THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    WHEN ERRNUMS.Exist_Next_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Next_Code, ERRNUMS.Exist_Next_Desc);
  END PAY_HEADER_SAVE;

-- ???? ?????? ???? ????(?????????? ???? ???????? ???????? ????).
  PROCEDURE PAY_LINE_SAVE
            ( P_PAY_LINE_ID      OUT HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_PAY_HEADER_ID    IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_ALLOWANCE_TYPE   IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID     IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
    V_STD_YYYYMM                 VARCHAR2(10) := NULL;
    V_LAST_START_YYYYMM          VARCHAR2(10) := NULL;
    V_PAY_HEADER_ID              HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE;
  BEGIN
    BEGIN
      SELECT PMH.START_YYYYMM
        INTO V_STD_YYYYMM
        FROM HRP_PAY_MASTER_HEADER PMH
      WHERE PMH.PAY_HEADER_ID     = P_PAY_HEADER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10236', '&&VALUE:=START YYYYMM(????????)'));
    END;
    -- ???? ?????????? ???? ?????? ???? ID ??.
    V_PAY_HEADER_ID := PAY_HEADER_ID_CHECK_F
                        ( P_PERSON_ID => P_PERSON_ID
                        , P_CORP_ID => P_CORP_ID
                        , P_STD_YYYYMM => P_STD_YYYYMM
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        );
                          
    -- ???????????? ????.
    V_LAST_START_YYYYMM := PAY_LAST_START_YYYYMM_F
                             ( P_PERSON_ID => P_PERSON_ID
                              , P_CORP_ID => P_CORP_ID
                              , P_SOB_ID => P_SOB_ID
                              , P_ORG_ID => P_ORG_ID
                             );
  
  END PAY_LINE_SAVE;
  
-- PAY_MASTER_HEADER_INSERT
  PROCEDURE PAY_HEADER_INSERT
            ( P_PAY_HEADER_ID    OUT HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                    DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    BEGIN
      SELECT HRP_PAY_MASTER_HEADER_S1.NEXTVAL
       INTO P_PAY_HEADER_ID
       FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      RAISE ERRNUMS.Invalid_Sequence_ID;
    END;
    
    INSERT INTO HRP_PAY_MASTER_HEADER
    ( PAY_HEADER_ID
    , PERSON_ID 
    , CORP_ID 
    , START_YYYYMM 
    , PRINT_TYPE 
    , BANK_ID 
    , BANK_ACCOUNTS 
    , PAY_TYPE 
    , PAY_GRADE_ID 
    , GRADE_STEP 
    , CORP_CAR_YN 
    , PAY_PROVIDE_YN 
    , BONUS_PROVIDE_YN 
    , HIRE_INSUR_YN 
    , DED_FAMILY_COUNT
    , DED_CHILD_COUNT
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_PAY_HEADER_ID
    , P_PERSON_ID
    , P_CORP_ID
    , P_STD_YYYYMM
    , P_PRINT_TYPE
    , P_BANK_ID
    , P_BANK_ACCOUNTS
    , P_PAY_TYPE
    , P_PAY_GRADE_ID
    , P_GRADE_STEP
    , P_CORP_CAR_YN
    , P_PAY_PROVIDE_YN
    , P_BONUS_PROVIDE_YN
    , P_HIRE_INSUR_YN
    , NVL(P_DED_FAMILY_COUNT, 0)
    , NVL(P_DED_CHILD_COUNT, 0)
    , P_DESCRIPTION
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
    WHEN ERRNUMS.Exist_Next_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Next_Code, ERRNUMS.Exist_Next_Desc);
  END PAY_HEADER_INSERT;

-- PAY_MASTER_HEADER_UPDATE.
  PROCEDURE PAY_HEADER_UPDATE
            ( P_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_PRINT_TYPE       IN HRP_PAY_MASTER_HEADER.PRINT_TYPE%TYPE
            , P_BANK_ID          IN HRP_PAY_MASTER_HEADER.BANK_ID%TYPE
            , P_BANK_ACCOUNTS    IN HRP_PAY_MASTER_HEADER.BANK_ACCOUNTS%TYPE
            , P_PAY_TYPE         IN HRP_PAY_MASTER_HEADER.PAY_TYPE%TYPE
            , P_PAY_GRADE_ID     IN HRP_PAY_MASTER_HEADER.PAY_GRADE_ID%TYPE
            , P_GRADE_STEP       IN HRP_PAY_MASTER_HEADER.GRADE_STEP%TYPE
            , P_CORP_CAR_YN      IN HRP_PAY_MASTER_HEADER.CORP_CAR_YN%TYPE
            , P_PAY_PROVIDE_YN   IN HRP_PAY_MASTER_HEADER.PAY_PROVIDE_YN%TYPE
            , P_BONUS_PROVIDE_YN IN HRP_PAY_MASTER_HEADER.BONUS_PROVIDE_YN%TYPE
            , P_HIRE_INSUR_YN    IN HRP_PAY_MASTER_HEADER.HIRE_INSUR_YN%TYPE
            , P_DED_FAMILY_COUNT IN HRP_PAY_MASTER_HEADER.DED_FAMILY_COUNT%TYPE
            , P_DED_CHILD_COUNT  IN HRP_PAY_MASTER_HEADER.DED_CHILD_COUNT%TYPE
            , P_DESCRIPTION      IN HRP_PAY_MASTER_HEADER.DESCRIPTION%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE
            )
  AS
    V_START_YYYYMM               HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE;
  BEGIN
    /*--RAISE_APPLICATION_ERROR(-20001, 'UPDATE');  
    -- ???? ???????? ?????? Insert --> Error ????.
    O_PAY_HEADER_ID := PAY_HEADER_ID_CHECK_F( P_PERSON_ID => P_PERSON_ID
                                            , P_CORP_ID => P_CORP_ID
                                            , P_STD_YYYYMM => P_START_YYYYMM
                                            , P_SOB_ID => P_SOB_ID
                                            , P_ORG_ID => P_ORG_ID
                                            );
    IF O_PAY_HEADER_ID <> 0 THEN
      RAISE ERRNUMS.Exist_Next_Data;
    END IF;
    
    -- ???????? ?????? ???? ???? ?????? ???????? ?????? ?????? ???? INSERT.
    BEGIN
      SELECT PMH.START_YYYYMM
        INTO V_START_YYYYMM
        FROM HRP_PAY_MASTER_HEADER PMH
       WHERE PMH.PAY_HEADER_ID    = P_PAY_HEADER_ID
      ;
    END;
--    RAISE_APPLICATION_ERROR(-20001, V_START_YYYYMM || ',, ' || P_START_YYYYMM);
    
    IF V_START_YYYYMM < P_START_YYYYMM THEN     
      PAY_HEADER_INSERT ( P_PAY_HEADER_ID => O_PAY_HEADER_ID
                        , P_PERSON_ID => P_PERSON_ID
                        , P_CORP_ID => P_CORP_ID
                        , P_STD_YYYYMM => P_START_YYYYMM
                        , P_PRINT_TYPE => P_PRINT_TYPE
                        , P_BANK_ID => P_BANK_ID                        
                        , P_BANK_ACCOUNTS => P_BANK_ACCOUNTS
                        , P_PAY_TYPE => P_PAY_TYPE
                        , P_PAY_GRADE_ID => P_PAY_GRADE_ID
                        , P_GRADE_STEP => P_GRADE_STEP
                        , P_CORP_CAR_YN => P_CORP_CAR_YN
                        , P_PAY_PROVIDE_YN => P_PAY_PROVIDE_YN
                        , P_BONUS_PROVIDE_YN => P_BONUS_PROVIDE_YN
                        , P_HIRE_INSUR_YN => P_HIRE_INSUR_YN
                        , P_DED_FAMILY_COUNT => P_DED_FAMILY_COUNT
                        , P_DED_CHILD_COUNT => P_DED_CHILD_COUNT
                        , P_DESCRIPTION => P_DESCRIPTION
                        , P_SOB_ID => P_SOB_ID
                        , P_ORG_ID => P_ORG_ID
                        , P_USER_ID => P_USER_ID
                        );
      PAY_LINE_COPY ( P_PAY_HEADER_ID => P_PAY_HEADER_ID
                    , P_NEW_PAY_HEADER_ID => O_PAY_HEADER_ID
                    , P_SOB_ID => P_SOB_ID
                    , P_USER_ID => P_USER_ID
                    );
                          
    ELSIF V_START_YYYYMM = P_START_YYYYMM THEN*/
      UPDATE HRP_PAY_MASTER_HEADER
        SET PRINT_TYPE       = P_PRINT_TYPE
          , BANK_ID          = P_BANK_ID
          , BANK_ACCOUNTS    = P_BANK_ACCOUNTS
          , PAY_TYPE         = P_PAY_TYPE
          , PAY_GRADE_ID     = P_PAY_GRADE_ID
          , GRADE_STEP       = P_GRADE_STEP
          , CORP_CAR_YN      = P_CORP_CAR_YN
          , PAY_PROVIDE_YN   = P_PAY_PROVIDE_YN
          , BONUS_PROVIDE_YN = P_BONUS_PROVIDE_YN
          , HIRE_INSUR_YN    = P_HIRE_INSUR_YN
          , DED_FAMILY_COUNT = NVL(P_DED_FAMILY_COUNT, 0)
          , DED_CHILD_COUNT  = NVL(P_DED_CHILD_COUNT, 0)
          , DESCRIPTION      = P_DESCRIPTION
          , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID)
          , LAST_UPDATED_BY  = P_USER_ID
      WHERE PAY_HEADER_ID    = P_PAY_HEADER_ID
      ; 
      /*O_PAY_HEADER_ID := P_PAY_HEADER_ID;
      
    ELSE
      O_PAY_HEADER_ID := P_PAY_HEADER_ID;
       
    END IF;*/
  
  EXCEPTION
    WHEN ERRNUMS.Invalid_Sequence_ID THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    WHEN ERRNUMS.Exist_Next_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Next_Code, ERRNUMS.Exist_Next_Desc);
  END PAY_HEADER_UPDATE;
  
-- PAY_MASTER_HEADER_BACKUP.
  PROCEDURE PAY_HEADER_BACKUP
            ( W_PAY_HEADER_ID    IN HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE
            , P_END_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_HEADER.CREATED_BY%TYPE 
            )
  AS
  BEGIN
    -- ???? ???? ?????? BACKUP ?? INSERT.
    BEGIN
      UPDATE HRP_PAY_MASTER_HEADER PMH
        SET PMH.END_YYYYMM        = P_END_YYYYMM
          , PMH.LAST_UPDATE_DATE  = GET_LOCAL_DATE(PMH.SOB_ID)
          , PMH.LAST_UPDATED_BY   = P_USER_ID
        WHERE PMH.PAY_HEADER_ID = W_PAY_HEADER_ID
       ;
    END;
  
  END PAY_HEADER_BACKUP;

-- PAY_MASTER_LINE_INSERT
  PROCEDURE PAY_LINE_INSERT
            ( P_PAY_LINE_ID      OUT HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_PAY_HEADER_ID    IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_ALLOWANCE_TYPE   IN HRP_PAY_MASTER_LINE.ALLOWANCE_TYPE%TYPE
            , P_ALLOWANCE_ID     IN HRP_PAY_MASTER_LINE.ALLOWANCE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                    DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
--    RAISE_APPLICATION_ERROR(-20001, 'INSERT');  
    P_PAY_LINE_ID := 0;
    BEGIN
      SELECT PML.PAY_LINE_ID
        INTO P_PAY_LINE_ID
        FROM HRP_PAY_MASTER_LINE PML
       WHERE PML.PAY_HEADER_ID    = P_PAY_HEADER_ID
         AND PML.ALLOWANCE_TYPE   = P_ALLOWANCE_TYPE
         AND PML.ALLOWANCE_ID     = P_ALLOWANCE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      P_PAY_LINE_ID := 0;
    END;
    
    IF P_PAY_LINE_ID = 0 THEN
    -- ???? ????.
      BEGIN
        SELECT HRP_PAY_MASTER_LINE_S1.NEXTVAL
        INTO P_PAY_LINE_ID
        FROM DUAL;
      EXCEPTION WHEN OTHERS THEN
        RAISE ERRNUMS.Invalid_Sequence_ID;
      END;

      INSERT INTO HRP_PAY_MASTER_LINE
      ( PAY_LINE_ID
      , PAY_HEADER_ID 
      , ALLOWANCE_TYPE 
      , ALLOWANCE_ID 
      , ALLOWANCE_AMOUNT 
      , ENABLED_FLAG 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY 
      ) VALUES
      ( P_PAY_LINE_ID
      , P_PAY_HEADER_ID
      , P_ALLOWANCE_TYPE
      , P_ALLOWANCE_ID
      , P_ALLOWANCE_AMOUNT
      , P_ENABLED_FLAG
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID 
      );
    ELSE
    -- ???? ???? UPDATE.
      PAY_LINE_UPDATE ( W_PAY_LINE_ID => P_PAY_LINE_ID
                      , P_ALLOWANCE_AMOUNT => P_ALLOWANCE_AMOUNT
                      , P_ENABLED_FLAG => P_ENABLED_FLAG
                      , P_SOB_ID => P_SOB_ID
                      , P_USER_ID => P_USER_ID
                      );    
    END IF;
    
  EXCEPTION
    WHEN ERRNUMS.Invalid_Sequence_ID THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Sequence_Code, ERRNUMS.Invalid_Sequence_Desc);
    WHEN ERRNUMS.Exist_Data THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
  END PAY_LINE_INSERT;

-- PAY_MASTER_LINE_UPDATE.
  PROCEDURE PAY_LINE_UPDATE
            ( W_PAY_LINE_ID      IN HRP_PAY_MASTER_LINE.PAY_LINE_ID%TYPE
            , P_ALLOWANCE_AMOUNT IN HRP_PAY_MASTER_LINE.ALLOWANCE_AMOUNT%TYPE
            , P_ENABLED_FLAG     IN HRP_PAY_MASTER_LINE.ENABLED_FLAG%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID          IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
  BEGIN
--    RAISE_APPLICATION_ERROR(-20001, 'UPDATE');  
    UPDATE HRP_PAY_MASTER_LINE
      SET ALLOWANCE_AMOUNT = P_ALLOWANCE_AMOUNT
        , ENABLED_FLAG     = P_ENABLED_FLAG
        , LAST_UPDATE_DATE = GET_LOCAL_DATE(P_SOB_ID)
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE PAY_LINE_ID      = W_PAY_LINE_ID
    ;

  END PAY_LINE_UPDATE;

-- PAY_MASTER_LINE_COPY : ?????????? ???????? COPY.
  PROCEDURE PAY_LINE_COPY
            ( P_PAY_HEADER_ID     IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_NEW_PAY_HEADER_ID IN HRP_PAY_MASTER_LINE.PAY_HEADER_ID%TYPE
            , P_SOB_ID            IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_USER_ID           IN HRP_PAY_MASTER_LINE.CREATED_BY%TYPE 
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    
    INSERT INTO HRP_PAY_MASTER_LINE
    ( PAY_LINE_ID
    , PAY_HEADER_ID 
    , ALLOWANCE_TYPE 
    , ALLOWANCE_ID 
    , ALLOWANCE_AMOUNT 
    , DESCRIPTION
    , ENABLED_FLAG 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY)
    ( SELECT HRP_PAY_MASTER_LINE_S1.NEXTVAL AS PAY_LINE_ID
           , P_NEW_PAY_HEADER_ID
           , PML.ALLOWANCE_TYPE
           , PML.ALLOWANCE_ID
           , PML.ALLOWANCE_AMOUNT
           , PML.DESCRIPTION
           , PML.ENABLED_FLAG
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
        FROM HRP_PAY_MASTER_LINE PML
       WHERE PML.PAY_HEADER_ID     = P_PAY_HEADER_ID
    );
    COMMIT;
    
  END PAY_LINE_COPY;

-- ???? ?????????? ???? ???? ID RETURN.
  FUNCTION PAY_HEADER_ID_CHECK_F
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_STD_YYYYMM       IN HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_PAY_HEADER_ID              HRP_PAY_MASTER_HEADER.PAY_HEADER_ID%TYPE := 0;
  BEGIN
    BEGIN
      SELECT NVL(MAX(PMH.PAY_HEADER_ID), 0) AS PAY_HEADER_ID
        INTO V_PAY_HEADER_ID
        FROM HRP_PAY_MASTER_HEADER PMH
       WHERE PMH.PERSON_ID      = P_PERSON_ID
         AND PMH.CORP_ID        = P_CORP_ID
         AND PMH.START_YYYYMM   < P_STD_YYYYMM
         AND (PMH.END_YYYYMM IS NULL OR PMH.END_YYYYMM > P_STD_YYYYMM)
         AND PMH.SOB_ID         = P_SOB_ID
         AND PMH.ORG_ID         = P_ORG_ID
      GROUP BY PMH.PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PAY_HEADER_ID := 0;
    END;
    RETURN V_PAY_HEADER_ID;
  END PAY_HEADER_ID_CHECK_F;

-- ?????????? ?????? ???? ???????? ?????? ???? ???? ????.
  FUNCTION PAY_LAST_START_YYYYMM_F
            ( P_PERSON_ID        IN HRP_PAY_MASTER_HEADER.PERSON_ID%TYPE
            , P_CORP_ID          IN HRP_PAY_MASTER_HEADER.CORP_ID%TYPE
            , P_SOB_ID           IN HRP_PAY_MASTER_HEADER.SOB_ID%TYPE
            , P_ORG_ID           IN HRP_PAY_MASTER_HEADER.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_PAY_START_YYYYMM           HRP_PAY_MASTER_HEADER.START_YYYYMM%TYPE := TO_CHAR(SYSDATE, 'YYYY-MM');
  BEGIN
    BEGIN
      SELECT MAX(PMH.START_YYYYMM) AS START_YYYYMM
        INTO V_PAY_START_YYYYMM
        FROM HRP_PAY_MASTER_HEADER PMH
       WHERE PMH.PERSON_ID      = P_PERSON_ID
         AND PMH.CORP_ID        = P_CORP_ID
         AND PMH.START_YYYYMM   <= V_PAY_START_YYYYMM
         AND PMH.END_YYYYMM     > V_PAY_START_YYYYMM
         AND PMH.SOB_ID         = P_SOB_ID
         AND PMH.ORG_ID         = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    RETURN V_PAY_START_YYYYMM;
  END PAY_LAST_START_YYYYMM_F;
  
-- PAYMENT_DATA_SELECT : Payment Date, Bank number
  PROCEDURE PAYMENT_DATA_SELECT
            ( P_CURSOR           OUT TYPES.TCURSOR
            , W_PERSON_ID        IN NUMBER
            , W_SOB_ID           IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID           IN HRM_PERSON_MASTER.ORG_ID%TYPE           
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
       SELECT PMH.PERSON_ID
             , PMH.START_YYYYMM || ' ~ ' || PMH.END_YYYYMM AS PAYMENT_DATE
             , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
             , PMH.BANK_ACCOUNTS
             , HRM_COMMON_G.CODE_NAME_F('PAY_TYPE', PMH.PAY_TYPE, W_SOB_ID, W_ORG_ID) AS PAY_TYPE_NAME
         FROM HRP_PAY_MASTER_HEADER PMH
        WHERE PMH.PERSON_ID        = W_PERSON_ID
          AND PMH.SOB_ID           = W_SOB_ID
          AND PMH.ORG_ID           = W_ORG_ID
     ORDER BY PMH.START_YYYYMM DESC;
     
    END PAYMENT_DATA_SELECT;
  
END HRP_PAY_MASTER_G;
/
