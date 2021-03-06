CREATE OR REPLACE PACKAGE HRR_RETIRE_INSURANCE_G
AS

-- SELECT_RETIRE_INSURANCE
  PROCEDURE SELECT_RETIRE_INSURANCE
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRR_RETIRE_INSURANCE.CORP_ID%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_INSURANCE.ADJUSTMENT_TYPE%TYPE
            , W_INSUR_CORP_ID                     IN HRR_RETIRE_INSURANCE.INSUR_CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_INSURANCE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_INSURANCE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_INSURANCE.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- INSERT_RETIRE_INSURANCE
  PROCEDURE INSERT_RETIRE_INSURANCE
            ( P_RETIRE_INSUR_ID OUT HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID%TYPE
            , P_ADJUSTMENT_TYPE IN HRR_RETIRE_INSURANCE.ADJUSTMENT_TYPE%TYPE
            , P_ADJUSTMENT_ID   IN HRR_RETIRE_INSURANCE.ADJUSTMENT_ID%TYPE
            , P_PERSON_ID       IN HRR_RETIRE_INSURANCE.PERSON_ID%TYPE
            , P_CORP_ID         IN HRR_RETIRE_INSURANCE.CORP_ID%TYPE
            , P_INSUR_CORP_ID   IN HRR_RETIRE_INSURANCE.INSUR_CORP_ID%TYPE
            , P_INSUR_AMOUNT    IN HRR_RETIRE_INSURANCE.INSUR_AMOUNT%TYPE
            , P_DESCRIPTION     IN HRR_RETIRE_INSURANCE.DESCRIPTION%TYPE
            , P_SOB_ID          IN HRR_RETIRE_INSURANCE.SOB_ID%TYPE
            , P_ORG_ID          IN HRR_RETIRE_INSURANCE.ORG_ID%TYPE
            , P_USER_ID         IN HRR_RETIRE_INSURANCE.CREATED_BY%TYPE
            );

-- UPDATE_RETIRE_INSURANCE.
  PROCEDURE UPDATE_RETIRE_INSURANCE
            ( W_RETIRE_INSUR_ID IN HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID%TYPE
            , P_INSUR_CORP_ID   IN HRR_RETIRE_INSURANCE.INSUR_CORP_ID%TYPE
            , P_INSUR_AMOUNT    IN HRR_RETIRE_INSURANCE.INSUR_AMOUNT%TYPE
            , P_DESCRIPTION     IN HRR_RETIRE_INSURANCE.DESCRIPTION%TYPE
            , P_USER_ID         IN HRR_RETIRE_INSURANCE.CREATED_BY%TYPE
            );

-- DELETE_RETIRE_INSURANCE.
  PROCEDURE DELETE_RETIRE_INSURANCE
            ( W_RETIRE_INSUR_ID IN HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID%TYPE
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
						, W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
						, W_END_DATE                          IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
						);
            
END HRR_RETIRE_INSURANCE_G;
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_INSURANCE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRR_RETIRE_INSURANCE_G
/* DESCRIPTION  : ???????? ?????? ????
/* REFERENCE BY :
/* PROGRAM HISTORY : ???? ????
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- SELECT_RETIRE_INSURANCE
  PROCEDURE SELECT_RETIRE_INSURANCE
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRR_RETIRE_INSURANCE.CORP_ID%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_INSURANCE.ADJUSTMENT_TYPE%TYPE
            , W_INSUR_CORP_ID                     IN HRR_RETIRE_INSURANCE.INSUR_CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_INSURANCE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_INSURANCE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_INSURANCE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT RI.RETIRE_INSUR_ID
           , RI.ADJUSTMENT_TYPE
           , HRM_COMMON_G.CODE_NAME_F('ADJUSTMENT_TYPE', RI.ADJUSTMENT_TYPE, RI.SOB_ID, RI.ORG_ID) AS ADJUSTMENT_TYPE_NAME
           , RI.ADJUSTMENT_ID
           , RI.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM 
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
           , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
           , RA.RETIRE_DATE_FR
           , RA.RETIRE_DATE_TO
           , RA.RETIRE_TOTAL_AMOUNT AS RETIRE_TOTAL_AMOUNT
           , RA.REAL_AMOUNT AS REAL_RETIRE_AMOUNT
           , RI.CORP_ID
           , RI.INSUR_CORP_ID
           , HRM_COMMON_G.ID_NAME_F(RI.INSUR_CORP_ID) AS INSUR_CORP_NAME
           , RI.INSUR_AMOUNT
           , RI.DESCRIPTION
           , RA.CLOSED_YN AS CLOSED_YN
           , HRM_PERSON_MASTER_G.NAME_F(RA.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
        FROM HRR_RETIRE_INSURANCE RI
          , HRM_PERSON_MASTER PM
          , HRR_RETIRE_ADJUSTMENT RA
       WHERE RI.ADJUSTMENT_ID           = RA.ADJUSTMENT_ID
         AND RA.PERSON_ID               = PM.PERSON_ID
         AND RI.CORP_ID                 = W_CORP_ID
         AND RI.ADJUSTMENT_TYPE         = NVL(W_ADJUSTMENT_TYPE, RI.ADJUSTMENT_TYPE) 
         AND RI.INSUR_CORP_ID           = NVL(W_INSUR_CORP_ID, RI.INSUR_CORP_ID)
         AND RI.PERSON_ID               = NVL(W_PERSON_ID, RI.PERSON_ID)
         AND RI.SOB_ID                  = W_SOB_ID
         AND RI.ORG_ID                  = W_ORG_ID
       ;
       
  END SELECT_RETIRE_INSURANCE;


---------------------------------------------------------------------------------------------------
-- INSERT_RETIRE_INSURANCE
  PROCEDURE INSERT_RETIRE_INSURANCE
            ( P_RETIRE_INSUR_ID OUT HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID%TYPE
            , P_ADJUSTMENT_TYPE IN HRR_RETIRE_INSURANCE.ADJUSTMENT_TYPE%TYPE
            , P_ADJUSTMENT_ID   IN HRR_RETIRE_INSURANCE.ADJUSTMENT_ID%TYPE
            , P_PERSON_ID       IN HRR_RETIRE_INSURANCE.PERSON_ID%TYPE
            , P_CORP_ID         IN HRR_RETIRE_INSURANCE.CORP_ID%TYPE
            , P_INSUR_CORP_ID   IN HRR_RETIRE_INSURANCE.INSUR_CORP_ID%TYPE
            , P_INSUR_AMOUNT    IN HRR_RETIRE_INSURANCE.INSUR_AMOUNT%TYPE
            , P_DESCRIPTION     IN HRR_RETIRE_INSURANCE.DESCRIPTION%TYPE
            , P_SOB_ID          IN HRR_RETIRE_INSURANCE.SOB_ID%TYPE
            , P_ORG_ID          IN HRR_RETIRE_INSURANCE.ORG_ID%TYPE
            , P_USER_ID         IN HRR_RETIRE_INSURANCE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(P_SOB_ID);

  BEGIN
    SELECT HRR_RETIRE_INSURANCE_S1.NEXTVAL
      INTO P_RETIRE_INSUR_ID
      FROM DUAL;

    INSERT INTO HRR_RETIRE_INSURANCE
    ( RETIRE_INSUR_ID
    , ADJUSTMENT_TYPE 
    , ADJUSTMENT_ID 
    , PERSON_ID 
    , CORP_ID 
    , INSUR_CORP_ID 
    , INSUR_AMOUNT 
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY 
    ) VALUES
    ( P_RETIRE_INSUR_ID
    , P_ADJUSTMENT_TYPE
    , P_ADJUSTMENT_ID
    , P_PERSON_ID
    , P_CORP_ID
    , P_INSUR_CORP_ID
    , P_INSUR_AMOUNT
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID 
    );

  END INSERT_RETIRE_INSURANCE;

-- UPDATE_RETIRE_INSURANCE.
  PROCEDURE UPDATE_RETIRE_INSURANCE
            ( W_RETIRE_INSUR_ID IN HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID%TYPE
            , P_INSUR_CORP_ID   IN HRR_RETIRE_INSURANCE.INSUR_CORP_ID%TYPE
            , P_INSUR_AMOUNT    IN HRR_RETIRE_INSURANCE.INSUR_AMOUNT%TYPE
            , P_DESCRIPTION     IN HRR_RETIRE_INSURANCE.DESCRIPTION%TYPE
            , P_USER_ID         IN HRR_RETIRE_INSURANCE.CREATED_BY%TYPE
            )
  AS
  BEGIN
    UPDATE HRR_RETIRE_INSURANCE
      SET INSUR_CORP_ID    = P_INSUR_CORP_ID
        , INSUR_AMOUNT     = P_INSUR_AMOUNT
        , DESCRIPTION      = P_DESCRIPTION
        , LAST_UPDATE_DATE = GET_LOCAL_DATE(SOB_ID)
        , LAST_UPDATED_BY  = P_USER_ID
    WHERE RETIRE_INSUR_ID  = W_RETIRE_INSUR_ID
    ;

  END UPDATE_RETIRE_INSURANCE;

-- DELETE_RETIRE_INSURANCE.
  PROCEDURE DELETE_RETIRE_INSURANCE
            ( W_RETIRE_INSUR_ID IN HRR_RETIRE_INSURANCE.RETIRE_INSUR_ID%TYPE
            )
  AS
  BEGIN
    DELETE FROM HRR_RETIRE_INSURANCE
    WHERE RETIRE_INSUR_ID  = W_RETIRE_INSUR_ID
    ;

  END DELETE_RETIRE_INSURANCE;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT
	          ( P_CURSOR3                           OUT TYPES.TCURSOR3
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
						, W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
						, W_END_DATE                          IN HRM_PERSON_MASTER.RETIRE_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
						)
  AS
  BEGIN
		OPEN P_CURSOR3 FOR
			SELECT PM.NAME AS NAME
					, PM.PERSON_NUM
					, HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID) AS CORP_NAME
					, HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
					, HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
					, HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME	
					, HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
					, PM.ORI_JOIN_DATE
					, PM.JOIN_DATE
					, PM.RETIRE_DATE
					, PM.PERSON_ID
					, PM.CORP_ID
					, PM.DEPT_ID
					, PM.POST_ID
					, PM.PAY_GRADE_ID
          , RA.ADJUSTMENT_ID
          , RA.RETIRE_DATE_FR
          , RA.RETIRE_DATE_TO
          , RA.RETIRE_TOTAL_AMOUNT AS RETIRE_TOTAL_AMOUNT
          , RA.REAL_AMOUNT AS REAL_RETIRE_AMOUNT
          , RA.CLOSED_YN AS CLOSED_YN
          , HRM_PERSON_MASTER_G.NAME_F(RA.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
			FROM HRM_PERSON_MASTER PM
        , HRR_RETIRE_ADJUSTMENT RA
				, (-- ???? ????????.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.POST_ID
								, HL.PAY_GRADE_ID
								, HL.JOB_CATEGORY_ID
								, HL.FLOOR_ID    
						FROM HRM_HISTORY_LINE HL  
						WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																						FROM HRM_HISTORY_LINE S_HL
																					 WHERE S_HL.CHARGE_DATE            <= W_END_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1
			WHERE PM.PERSON_ID                               = RA.PERSON_ID
        AND PM.PERSON_ID                               = T1.PERSON_ID
				AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
				AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
				AND PM.ORI_JOIN_DATE                           <= W_END_DATE
				AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
				AND PM.SOB_ID                                  = W_SOB_ID
				AND PM.ORG_ID                                  = W_ORG_ID
        AND RA.ADJUSTMENT_TYPE                         = W_ADJUSTMENT_TYPE
			;

  END LU_PERSON_SELECT; 
  
END HRR_RETIRE_INSURANCE_G;
/
