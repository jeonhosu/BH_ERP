CREATE OR REPLACE PACKAGE HRF_FOOD_DAY_SUMMARY_G
AS

-- FOOD DAY SUMMARY SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_START_DATE                        IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_END_DATE                          IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_DAY_COUNT_V.DEVICE_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_DAY_COUNT_V.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_DAY_COUNT_V.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            );
						
-- FOOD DAY SELECT
  PROCEDURE DATA_SELECT_DAY
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_START_DATE                        IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_END_DATE                          IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_CORP_ID                           IN HRF_FOOD_DAY_COUNT_V.CORP_ID%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_DAY_COUNT_V.DEVICE_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_DAY_COUNT_V.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_DAY_COUNT_V.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            );						

END HRF_FOOD_DAY_SUMMARY_G;
/
CREATE OR REPLACE PACKAGE BODY HRF_FOOD_DAY_SUMMARY_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRF_FOOD_DAY_SUMMARY_G
/* DESCRIPTION  : 업체별 일식사 관리.
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
            , W_START_DATE                        IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_END_DATE                          IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_DAY_COUNT_V.DEVICE_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_DAY_COUNT_V.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_DAY_COUNT_V.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HRM_CORP_MASTER_G.CORP_NAME_F(FDC.CORP_ID) AS CORP_NAME
					 , SUM(FDC.FOOD_COUNT) AS FOOD_SUM
					 , FDC.CORP_ID
				FROM HRF_FOOD_DAY_COUNT_V FDC
					 , HRF_FOOD_MANAGER FM
			 WHERE FDC.DEVICE_ID            = FM.DEVICE_ID
				 AND FDC.FOOD_DATE            BETWEEN W_START_DATE AND W_END_DATE
				 AND FDC.SOB_ID               = W_SOB_ID
				 AND FDC.ORG_ID               = W_ORG_ID
				 AND FDC.DEVICE_ID            = NVL(W_DEVICE_ID, FDC.DEVICE_ID)
				 AND FM.USER_ID               = W_USER_ID
			GROUP BY HRM_CORP_MASTER_G.CORP_NAME_F(FDC.CORP_ID)
		        , FDC.CORP_ID
      ORDER BY FDC.CORP_ID
			;
  END DATA_SELECT;
	
-- FOOD DAY SELECT
  PROCEDURE DATA_SELECT_DAY
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_START_DATE                        IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_END_DATE                          IN HRF_FOOD_DAY_COUNT_V.FOOD_DATE%TYPE
						, W_CORP_ID                           IN HRF_FOOD_DAY_COUNT_V.CORP_ID%TYPE
						, W_DEVICE_ID                         IN HRF_FOOD_DAY_COUNT_V.DEVICE_ID%TYPE
            , W_SOB_ID                            IN HRF_FOOD_DAY_COUNT_V.SOB_ID%TYPE
            , W_ORG_ID                            IN HRF_FOOD_DAY_COUNT_V.ORG_ID%TYPE
            , W_USER_ID                           IN HRF_FOOD_PERSON.CREATED_BY%TYPE
            )
  AS
	BEGIN
	  OPEN P_CURSOR1 FOR
		  SELECT FDC.FOOD_DATE
					 , HRM_COMMON_G.WEEK_F(TO_CHAR(FDC.FOOD_DATE, 'D'), FDC.SOB_ID, FDC.ORG_ID) AS WEEK_NAME
					 , FDC.DEVICE_ID
					 , HRM_COMMON_G.ID_NAME_F(FDC.DEVICE_ID) AS DEVICE_NAME
					 , FDC.FOOD_COUNT
					 , FDC.P_FOOD_COUNT
					 , FDC.V_FOOD_COUNT
					 , FDC.P_FOOD_1_COUNT
					 , FDC.V_FOOD_1_COUNT
					 , FDC.P_FOOD_2_COUNT
					 , FDC.V_FOOD_2_COUNT
					 , FDC.P_FOOD_3_COUNT
					 , FDC.V_FOOD_3_COUNT
					 , FDC.P_FOOD_4_COUNT
					 , FDC.V_FOOD_4_COUNT
					 , FDC.P_SNACK_1_COUNT
					 , FDC.V_SNACK_1_COUNT
					 , FDC.P_SNACK_2_COUNT
					 , FDC.V_SNACK_2_COUNT
					 , FDC.P_SNACK_3_COUNT
					 , FDC.V_SNACK_3_COUNT
					 , FDC.P_SNACK_4_COUNT
					 , FDC.V_SNACK_4_COUNT
				FROM HRF_FOOD_DAY_COUNT_V FDC
					 , HRF_FOOD_MANAGER FM
			 WHERE FDC.DEVICE_ID            = FM.DEVICE_ID
				 AND FDC.FOOD_DATE            BETWEEN W_START_DATE AND W_END_DATE
				 AND FDC.CORP_ID              = W_CORP_ID
				 AND FDC.SOB_ID               = W_SOB_ID
				 AND FDC.ORG_ID               = W_ORG_ID
				 AND FDC.DEVICE_ID            = NVL(W_DEVICE_ID, FDC.DEVICE_ID)
				 AND FM.USER_ID               = W_USER_ID
      ORDER BY FDC.FOOD_DATE
      ;
	
	END DATA_SELECT_DAY;	

END HRF_FOOD_DAY_SUMMARY_G;
/
