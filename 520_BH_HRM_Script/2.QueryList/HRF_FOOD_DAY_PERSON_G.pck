CREATE OR REPLACE PACKAGE HRF_FOOD_DAY_PERSON_G
AS

-- FOOD DAY SUMMARY SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_PERSON_ID                         IN HRF_FOOD_PERSON.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            );

-- FOOD DAY SELECT
  PROCEDURE DATA_SELECT_DAY
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_PERSON_ID                         IN HRF_FOOD_PERSON.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            );

END HRF_FOOD_DAY_PERSON_G;
/
CREATE OR REPLACE PACKAGE BODY HRF_FOOD_DAY_PERSON_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRF_FOOD_DAY_PERSON_G
/* DESCRIPTION  : 개인별 일식사 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- FOOD DAY SUMMARY SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_PERSON_ID                         IN HRF_FOOD_PERSON.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT FP.PERSON_ID AS PERSON_ID 
					 , PM.DISPLAY_NAME AS NAME
					 , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAME
					 , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
					 , NVL(SUM(FP.FOOD_COUNT), 0) AS FOOD_SUM
					 , NVL(SUM(FP.DED_COUNT), 0) AS DED_COUNT
					 , W_START_DATE AS START_DATE
					 , W_END_DATE AS END_DATE
				FROM HRF_FOOD_PERSON FP
					, HRM_PERSON_MASTER PM
			 WHERE FP.PERSON_ID             = PM.PERSON_ID
				 AND FP.FOOD_DATE             BETWEEN W_START_DATE AND W_END_DATE
				 AND FP.PERSON_ID             = NVL(W_PERSON_ID, FP.PERSON_ID)
				 AND FP.SOB_ID                = W_SOB_ID
				 AND FP.ORG_ID                = W_ORG_ID
				 AND PM.DEPT_ID               = NVL(W_DEPT_ID, PM.DEPT_ID)
			GROUP BY FP.PERSON_ID 
					 , PM.DISPLAY_NAME
					 , PM.DEPT_ID
					 , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)
					 , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)
			ORDER BY PM.DEPT_ID, FP.PERSON_ID
      ;
  END DATA_SELECT;

-- FOOD DAY SELECT
  PROCEDURE DATA_SELECT_DAY
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_START_DATE                        IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_END_DATE                          IN HRF_FOOD_PERSON.FOOD_DATE%TYPE
            , W_PERSON_ID                         IN HRF_FOOD_PERSON.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_PERSON.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_PERSON.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT FP.FOOD_DATE AS FOOD_DATE
					 , HRM_COMMON_G.WEEK_F( TO_CHAR(FP.FOOD_DATE, 'D'), FP.SOB_ID, FP.ORG_ID) AS WEEK_NAME
					 , NVL(FP.FOOD_COUNT, 0) AS FOOD_SUM
					 , NVL(FP.DED_COUNT, 0) AS DED_COUNT
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 1, F1.FOOD_TIME, NULL)) AS FOOD_TIME1
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 2, F1.FOOD_TIME, NULL)) AS FOOD_TIME2
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 3, F1.FOOD_TIME, NULL)) AS FOOD_TIME3
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 4, F1.FOOD_TIME, NULL)) AS FOOD_TIME4
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 5, F1.FOOD_TIME, NULL)) AS FOOD_TIME5
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 6, F1.FOOD_TIME, NULL)) AS FOOD_TIME6
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 7, F1.FOOD_TIME, NULL)) AS FOOD_TIME7
					 , MAX(DECODE(F1.FOOD_SEQ_ID, 8, F1.FOOD_TIME, NULL)) AS FOOD_TIME8		 
				FROM HRF_FOOD_PERSON FP
					, ( SELECT ROW_NUMBER() OVER (PARTITION BY FPT.PERSON_ID, FPT.FOOD_DATE ORDER BY FPT.PERSON_ID, FPT.FOOD_DATE) AS FOOD_SEQ_ID
									, FPT.FOOD_PERSON_ID
									, FPT.FOOD_DATE
									, FPT.FOOD_FLAG
									, FPT.FOOD_DATETIME
									, TO_CHAR(FPT.FOOD_DATETIME, 'HH24:MI') AS FOOD_TIME
								FROM HRF_FOOD_PERSON_TIME FPT
						) F1
			 WHERE FP.FOOD_PERSON_ID        = F1.FOOD_PERSON_ID
				 AND FP.FOOD_DATE             BETWEEN W_START_DATE AND W_END_DATE
				 AND FP.PERSON_ID             = W_PERSON_ID
				 AND FP.SOB_ID                = W_SOB_ID
				 AND FP.ORG_ID                = W_ORG_ID
			GROUP BY FP.FOOD_DATE
					 , HRM_COMMON_G.WEEK_F( TO_CHAR(FP.FOOD_DATE, 'D'), FP.SOB_ID, FP.ORG_ID)
					 , NVL(FP.FOOD_COUNT, 0)
					 , NVL(FP.DED_COUNT, 0)
      ;
  END DATA_SELECT_DAY;

END HRF_FOOD_DAY_PERSON_G;
/
