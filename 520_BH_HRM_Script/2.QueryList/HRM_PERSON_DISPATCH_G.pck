CREATE OR REPLACE PACKAGE HRM_PERSON_DISPATCH_G
AS

-- PERSON SELECT.
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_EMPLOYE_TYPE                      IN VARCHAR2
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- PERSON DETAIL.
  PROCEDURE DATA_SELECT_DETAIL
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_EMPLOYE_TYPE                      IN VARCHAR2
            , W_NAME                              IN VARCHAR2
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- EMPLOYEE PERSON.
  PROCEDURE DATA_SELECT_EMPLOYE
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_STD_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            );

-- 입퇴사자 현황 .
  PROCEDURE DATA_SELECT_JOIN_RETIRE
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
            , W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_END_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
            , W_EMPLOYE_TYPE                      IN VARCHAR2
            , W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
            , W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
            , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            );

-- DATA_INSERT..
  PROCEDURE DATA_INSERT
            ( P_PERSON_ID                         OUT NUMBER
						, P_PERSON_NUM                        OUT VARCHAR2
            , P_NAME                              IN VARCHAR2
						, P_NAME1                             IN VARCHAR2
						, P_NAME2                             IN VARCHAR2
						, P_CORP_ID                           IN NUMBER
            , P_DISPATCH_CORP_ID                  IN NUMBER
						, P_OPERATING_UNIT_ID                 IN NUMBER
						, P_DEPT_ID                           IN NUMBER
						, P_NATION_ID                         IN NUMBER
						, P_WORK_AREA_ID                      IN NUMBER
						, P_WORK_TYPE_ID                      IN NUMBER
						, P_JOB_CLASS_ID                      IN NUMBER
						, P_JOB_ID                            IN NUMBER
						, P_POST_ID                           IN NUMBER
						, P_OCPT_ID                           IN NUMBER
						, P_ABIL_ID                           IN NUMBER
						, P_PAY_GRADE_ID                      IN NUMBER
						, P_REPRE_NUM                         IN VARCHAR2
						, P_SEX_TYPE                          IN VARCHAR2
						, P_BIRTHDAY                          IN DATE
						, P_BIRTHDAY_TYPE                     IN VARCHAR2
						, P_MARRY_YN                          IN VARCHAR2
						, P_MARRY_DATE                        IN DATE
						, P_JOIN_ID                           IN NUMBER
						, P_JOIN_ROUTE_ID                     IN NUMBER
						, P_ORI_JOIN_DATE                     IN DATE
						, P_JOIN_DATE                         IN DATE
						, P_PAY_DATE                          IN DATE
						, P_DEPT_DATE                         IN DATE
						, P_OFFICIALLY_DATE                   IN DATE
						, P_SHO_DATE                          IN DATE
						, P_EXPIRE_DATE                       IN DATE
						, P_PROMOTION_EXPECT_DATE             IN DATE
						, P_DIR_INDIR_TYPE                    IN VARCHAR2
						, P_EMPLOYE_TYPE                      IN VARCHAR2
						, P_LEGAL_ZIP_CODE                    IN VARCHAR2
						, P_LEGAL_ADDR1                       IN VARCHAR2
						, P_LEGAL_ADDR2                       IN VARCHAR2
						, P_PRSN_ZIP_CODE                     IN VARCHAR2
						, P_PRSN_ADDR1                        IN VARCHAR2
						, P_PRSN_ADDR2                        IN VARCHAR2
						, P_LIVE_ZIP_CODE                     IN VARCHAR2
						, P_LIVE_ADDR1                        IN VARCHAR2
						, P_LIVE_ADDR2                        IN VARCHAR2
						, P_TELEPHON_NO                       IN VARCHAR2
						, P_HP_PHONE_NO                       IN VARCHAR2
						, P_EMAIL                             IN VARCHAR2
						, P_RELIGION_ID                       IN NUMBER
						, P_END_SCH_ID                        IN NUMBER
						, P_HOBBY                             IN VARCHAR2
						, P_TALENT                            IN VARCHAR2
						, P_JOB_CATEGORY_ID                   IN NUMBER
						, P_FLOOR_ID                          IN NUMBER
						, P_COST_CENTER_ID                    IN NUMBER
						, P_IC_CARD_NO                        IN VARCHAR2
						, P_OLD_PERSON_NUM                    IN VARCHAR2
						, P_CORP_TYPE                         IN VARCHAR2
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						, P_DESCRIPTION                       IN VARCHAR2
						, P_USER_ID                           IN NUMBER
            );

-- DATA_UPDATE..
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN NUMBER
            , P_NAME                              IN VARCHAR2
            , P_NAME1                             IN VARCHAR2
            , P_NAME2                             IN VARCHAR2
            , P_CORP_ID                           IN NUMBER
            , P_DISPATCH_CORP_ID                  IN NUMBER
            , P_OPERATING_UNIT_ID                 IN NUMBER
            , P_DEPT_ID                             IN NUMBER
            , P_NATION_ID                         IN NUMBER
            , P_WORK_AREA_ID                      IN NUMBER
            , P_WORK_TYPE_ID                      IN NUMBER
            , P_JOB_CLASS_ID                      IN NUMBER
            , P_JOB_ID                            IN NUMBER
            , P_POST_ID                           IN NUMBER
            , P_OCPT_ID                           IN NUMBER
            , P_ABIL_ID                           IN NUMBER
            , P_PAY_GRADE_ID                      IN NUMBER
            , P_REPRE_NUM                         IN VARCHAR2
            , P_SEX_TYPE                          IN VARCHAR2
            , P_BIRTHDAY                          IN DATE
            , P_BIRTHDAY_TYPE                     IN VARCHAR2
            , P_MARRY_YN                          IN VARCHAR2
            , P_MARRY_DATE                        IN DATE
            , P_JOIN_ID                           IN NUMBER
            , P_JOIN_ROUTE_ID                     IN NUMBER
            , P_ORI_JOIN_DATE                     IN DATE
            , P_JOIN_DATE                         IN DATE
            , P_PAY_DATE                          IN DATE
            , P_DEPT_DATE                         IN DATE
            , P_OFFICIALLY_DATE                   IN DATE
            , P_SHO_DATE                          IN DATE
            , P_EXPIRE_DATE                       IN DATE
            , P_PROMOTION_EXPECT_DATE             IN DATE
            , P_DIR_INDIR_TYPE                    IN VARCHAR2
            , P_EMPLOYE_TYPE                      IN VARCHAR2
            , P_LEGAL_ZIP_CODE                    IN VARCHAR2
            , P_LEGAL_ADDR1                       IN VARCHAR2
            , P_LEGAL_ADDR2                       IN VARCHAR2
            , P_PRSN_ZIP_CODE                     IN VARCHAR2
            , P_PRSN_ADDR1                        IN VARCHAR2
            , P_PRSN_ADDR2                        IN VARCHAR2
            , P_LIVE_ZIP_CODE                     IN VARCHAR2
            , P_LIVE_ADDR1                        IN VARCHAR2
            , P_LIVE_ADDR2                        IN VARCHAR2
            , P_TELEPHON_NO                       IN VARCHAR2
            , P_HP_PHONE_NO                       IN VARCHAR2
            , P_EMAIL                             IN VARCHAR2
            , P_RELIGION_ID                       IN NUMBER
            , P_END_SCH_ID                        IN NUMBER
            , P_HOBBY                             IN VARCHAR2
            , P_TALENT                            IN VARCHAR2
            , P_JOB_CATEGORY_ID                   IN NUMBER
            , P_FLOOR_ID                          IN NUMBER
            , P_COST_CENTER_ID                    IN NUMBER
            , P_IC_CARD_NO                        IN VARCHAR2
            , P_OLD_PERSON_NUM                    IN VARCHAR2
            , P_CORP_TYPE                         IN VARCHAR2
            , P_DESCRIPTION                       IN VARCHAR2
            , P_USER_ID                           IN NUMBER
            );

-- 사원 ID를 가지고 이름 조회..
  FUNCTION NAME_F
           ( W_PERSON_ID                          IN NUMBER
           ) RETURN VARCHAR2;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT2
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT3
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_DUTY
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_DUTY_C
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            );

END HRM_PERSON_DISPATCH_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_PERSON_DISPATCH_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRM_PERSON_DISPATCH_G
/* Description  : 파견직 인사내역 관리 패키지
/*
/* Reference by : 파견직 임직원 정보 관리
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/

-- PERSON SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN NUMBER
						, W_DEPT_ID                           IN NUMBER
						, W_EMPLOYE_TYPE                      IN VARCHAR2
						, W_NAME                              IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
    OPEN P_CURSOR FOR
        SELECT PM.PERSON_ID
            , PM.PERSON_NUM
            , PM.NAME
        FROM HRM_PERSON_DISPATCH PM
        WHERE PM.CORP_ID                                      = NVL(W_CORP_ID, PM.CORP_ID)
          AND PM.DEPT_ID                                      = NVL(W_DEPT_ID, PM.DEPT_ID)
          AND PM.NAME                                         LIKE W_NAME || '%'
          AND PM.EMPLOYE_TYPE                                 = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
					AND PM.SOB_ID                                       = W_SOB_ID
					AND PM.ORG_ID                                       = W_ORG_ID
        ;

  END DATA_SELECT;

-- PERSON DETAIL.
  PROCEDURE DATA_SELECT_DETAIL
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_CORP_ID                           IN NUMBER
						, W_DEPT_ID                           IN NUMBER
						, W_EMPLOYE_TYPE                      IN VARCHAR2
						, W_NAME                              IN VARCHAR2
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						)
  AS
  BEGIN
     OPEN P_CURSOR1 FOR
        SELECT PD.PERSON_ID
            , PD.PERSON_NUM
            , PD.NAME
            , PD.NAME1
            , PD.NAME2
            , PD.CORP_ID AS CORP_ID
            , CM.CORP_NAME
            , PD.DISPATCH_CORP_ID AS DISPATCH_CORP_ID
            , D_CM.CORP_NAME AS DISPATCH_CORP_NAME
            , PD.OPERATING_UNIT_ID
            , OU.OPERATING_UNIT_NAME
            , PD.DEPT_ID
            , DM.DEPT_CODE
            , DM.DEPT_NAME
            , PD.NATION_ID
            , HRM_COMMON_G.ID_NAME_F(PD.NATION_ID) NATION_NAME
            , PD.WORK_AREA_ID
            , HRM_COMMON_G.ID_NAME_F(PD.WORK_AREA_ID) WORK_AREA_NAME
            , PD.WORK_TYPE_ID
            , HRM_COMMON_G.ID_NAME_F(PD.WORK_TYPE_ID) WORK_TYPE_NAME
            , PD.JOB_CLASS_ID
            , HRM_COMMON_G.ID_NAME_F(PD.JOB_CLASS_ID) JOB_CLASS_NAME
            , PD.JOB_ID
            , HRM_COMMON_G.ID_NAME_F(PD.JOB_ID) JOB_NAME
            , PD.POST_ID
            , HRM_COMMON_G.ID_NAME_F(PD.POST_ID) POST_NAME
            , PD.OCPT_ID
            , HRM_COMMON_G.ID_NAME_F(PD.OCPT_ID) OCPT_NAME
            , PD.ABIL_ID
            , HRM_COMMON_G.ID_NAME_F(PD.ABIL_ID) ABIL_NAME
            , PD.PAY_GRADE_ID
            , HRM_COMMON_G.ID_NAME_F(PD.PAY_GRADE_ID) PAY_GRADE_NAME
            , PD.REPRE_NUM
            , PD.SEX_TYPE
            , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PD.SEX_TYPE, W_SOB_ID, W_ORG_ID) SEX_NAME
            , PD.BIRTHDAY
            , NVL(PD.BIRTHDAY_TYPE, 'N')BIRTHDAY_TYPE
            , HRM_COMMON_G.CODE_NAME_F('BIRTHDAY_TYPE', PD.BIRTHDAY_TYPE, W_SOB_ID, W_ORG_ID) BIRTHDAY_TYPE_NAME
            , PD.MARRY_YN
            , PD.MARRY_DATE
            , PD.JOIN_ID
            , HRM_COMMON_G.ID_NAME_F(PD.JOIN_ID) JOIN_NAME
            , PD.JOIN_ROUTE_ID
            , HRM_COMMON_G.ID_NAME_F(PD.JOIN_ROUTE_ID) JOIN_ROUTE_NAME
            , PD.ORI_JOIN_DATE
            , PD.JOIN_DATE
            , PD.PAY_DATE
            , PD.DEPT_DATE
            , PD.OFFICIALLY_DATE
            , PD.SHO_DATE
            , PD.EXPIRE_DATE
            , PD.PROMOTION_EXPECT_DATE
            , PD.RETIRE_DATE
            , PD.RETIRE_ID
            , HRM_COMMON_G.ID_NAME_F(PD.RETIRE_ID) RETIRE_NAME
            , PD.DIR_INDIR_TYPE
            , HRM_COMMON_G.CODE_NAME_F('DIR_INDIR_TYPE', PD.DIR_INDIR_TYPE, W_SOB_ID, W_ORG_ID) DIR_INDIR_TYPE_NAME
            , PD.EMPLOYE_TYPE
            , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PD.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
            , PD.LEGAL_ZIP_CODE
            , PD.LEGAL_ADDR1
            , PD.LEGAL_ADDR2
            , PD.PRSN_ZIP_CODE
            , PD.PRSN_ADDR1
            , PD.PRSN_ADDR2
            , PD.LIVE_ZIP_CODE
            , PD.LIVE_ADDR1
            , PD.LIVE_ADDR2
            , PD.TELEPHON_NO
            , PD.HP_PHONE_NO
            , PD.EMAIL
            , PD.RELIGION_ID
            , HRM_COMMON_G.ID_NAME_F(PD.RELIGION_ID) RELIGION_NAME
            , PD.END_SCH_ID
            , HRM_COMMON_G.ID_NAME_F(PD.END_SCH_ID) END_SCH_NAME
            , PD.HOBBY
            , PD.TALENT
            , PD.JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(PD.JOB_CATEGORY_ID) JOB_CATEGORY_NAME
            , PD.FLOOR_ID
            , HRM_COMMON_G.ID_NAME_F(PD.FLOOR_ID) FLOOR_NAME
            , PD.COST_CENTER_ID
            , HRM_COMMON_G.COST_CENTER_DESC_F(PD.COST_CENTER_ID) AS COST_CENTER
            , PD.IC_CARD_NO
            , PD.OLD_PERSON_NUM
            , PD.CORP_TYPE
/*            , PD.SOB_ID
            , PD.ORG_ID*/
            , PD.DESCRIPTION
            , PD.LAST_UPDATE_DATE
            , PD.LAST_UPDATED_BY
        FROM HRM_PERSON_DISPATCH PD
          , HRM_CORP_MASTER CM
          , HRM_CORP_MASTER D_CM
          , HRM_OPERATING_UNIT OU
          , HRM_DEPT_MASTER DM
        WHERE PD.CORP_ID                          = CM.CORP_ID
          AND PD.DISPATCH_CORP_ID                 = D_CM.CORP_ID
          AND PD.OPERATING_UNIT_ID                = OU.OPERATING_UNIT_ID(+)
          AND PD.DEPT_ID                          = DM.DEPT_ID(+)
          AND PD.DISPATCH_CORP_ID                 = NVL(W_CORP_ID, PD.DISPATCH_CORP_ID)
          AND PD.DEPT_ID                          = NVL(W_DEPT_ID, PD.DEPT_ID)
          AND PD.NAME                             LIKE W_NAME || '%'
          AND PD.EMPLOYE_TYPE                     = NVL(W_EMPLOYE_TYPE, PD.EMPLOYE_TYPE)
					AND PD.SOB_ID                           = W_SOB_ID
					AND PD.ORG_ID                           = W_ORG_ID
			  ORDER BY PD.PERSON_NUM, PD.NAME
        ;

  END DATA_SELECT_DETAIL;

-- EMPLOYEE PERSON.
  PROCEDURE DATA_SELECT_EMPLOYE
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_STD_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
						, W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
						, W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						)
  AS
	BEGIN
	  OPEN P_CURSOR1 FOR
		  SELECT PM.PERSON_NUM
					 , PM.NAME
					 , PM.REPRE_NUM
					 , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAM
					 , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) AS ABIL_NAME
					 , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
					 , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
					 , PM.ORI_JOIN_DATE
					 , PM.JOIN_DATE
					 , PM.RETIRE_DATE
					 , HRM_COMMON_DATE_G.YEAR_COUNT_F(PM.JOIN_DATE, NVL(PM.RETIRE_DATE, GET_LOCAL_DATE(PM.SOB_ID)), 'CEIL', 0) AS EMPLOYE_YEAR
				FROM HRM_PERSON_DISPATCH PM
			 WHERE PM.CORP_ID               = W_CORP_ID
				 AND PM.PERSON_ID             = NVL(W_PERSON_ID, PM.PERSON_ID)
				 AND PM.DEPT_ID               = NVL(W_DEPT_ID, PM.DEPT_ID)
				 AND PM.POST_ID               = NVL(W_POST_ID, PM.POST_ID)
				 AND PM.SOB_ID                = W_SOB_ID
				 AND PM.ORG_ID                = W_ORG_ID
				 AND PM.JOIN_DATE             <= W_STD_DATE
				 AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_STD_DATE)
				 ;

	END DATA_SELECT_EMPLOYE;

-- 입퇴사자 현황 .
  PROCEDURE DATA_SELECT_JOIN_RETIRE
	          ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_START_DATE                        IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
						, W_END_DATE                          IN HRM_PERSON_MASTER.JOIN_DATE%TYPE
						, W_EMPLOYE_TYPE                      IN VARCHAR2
						, W_DEPT_ID                           IN HRM_PERSON_MASTER.DEPT_ID%TYPE
						, W_POST_ID                           IN HRM_PERSON_MASTER.POST_ID%TYPE
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						)
  AS
	BEGIN
	  OPEN P_CURSOR1 FOR
		  SELECT PM.PERSON_NUM
					 , PM.NAME
					 , PM.REPRE_NUM
					 , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID) AS DEPT_NAM
					 , HRM_COMMON_G.ID_NAME_F(PM.ABIL_ID) AS ABIL_NAME
					 , HRM_COMMON_G.ID_NAME_F(PM.POST_ID) AS POST_NAME
					 , HRM_COMMON_G.ID_NAME_F(PM.PAY_GRADE_ID) AS PAY_GRADE_NAME
					 , PM.ORI_JOIN_DATE
					 , PM.JOIN_DATE
					 , PM.RETIRE_DATE
					 , HRM_COMMON_DATE_G.YEAR_COUNT_F(PM.JOIN_DATE, NVL(PM.RETIRE_DATE, GET_LOCAL_DATE(PM.SOB_ID)), 'CEIL', 0) AS CONTINUE_YEAR
					 , HRM_COMMON_G.ID_NAME_F(PM.END_SCH_ID) AS END_SCH_NAME
				FROM HRM_PERSON_DISPATCH PM
			 WHERE PM.CORP_ID               = W_CORP_ID
				 AND PM.PERSON_ID             = NVL(W_PERSON_ID, PM.PERSON_ID)
				 AND PM.DEPT_ID               = NVL(W_DEPT_ID, PM.DEPT_ID)
				 AND PM.POST_ID               = NVL(W_POST_ID, PM.POST_ID)
				 AND PM.SOB_ID                = W_SOB_ID
				 AND PM.ORG_ID                = W_ORG_ID
				 AND DECODE(W_EMPLOYE_TYPE, '1', PM.JOIN_DATE, NVL(PM.RETIRE_DATE, W_END_DATE + 1))
                                      BETWEEN W_START_DATE AND W_END_DATE
				 ;
	END DATA_SELECT_JOIN_RETIRE;

-- DATA_INSERT..
  PROCEDURE DATA_INSERT
	          ( P_PERSON_ID                         OUT NUMBER
						, P_PERSON_NUM                        OUT VARCHAR2
            , P_NAME                              IN VARCHAR2
						, P_NAME1                             IN VARCHAR2
						, P_NAME2                             IN VARCHAR2
						, P_CORP_ID                           IN NUMBER
            , P_DISPATCH_CORP_ID                  IN NUMBER
						, P_OPERATING_UNIT_ID                 IN NUMBER
						, P_DEPT_ID                           IN NUMBER
						, P_NATION_ID                         IN NUMBER
						, P_WORK_AREA_ID                      IN NUMBER
						, P_WORK_TYPE_ID                      IN NUMBER
						, P_JOB_CLASS_ID                      IN NUMBER
						, P_JOB_ID                            IN NUMBER
						, P_POST_ID                           IN NUMBER
						, P_OCPT_ID                           IN NUMBER
						, P_ABIL_ID                           IN NUMBER
						, P_PAY_GRADE_ID                      IN NUMBER
						, P_REPRE_NUM                         IN VARCHAR2
						, P_SEX_TYPE                          IN VARCHAR2
						, P_BIRTHDAY                          IN DATE
						, P_BIRTHDAY_TYPE                     IN VARCHAR2
						, P_MARRY_YN                          IN VARCHAR2
						, P_MARRY_DATE                        IN DATE
						, P_JOIN_ID                           IN NUMBER
						, P_JOIN_ROUTE_ID                     IN NUMBER
						, P_ORI_JOIN_DATE                     IN DATE
						, P_JOIN_DATE                         IN DATE
						, P_PAY_DATE                          IN DATE
						, P_DEPT_DATE                         IN DATE
						, P_OFFICIALLY_DATE                   IN DATE
						, P_SHO_DATE                          IN DATE
						, P_EXPIRE_DATE                       IN DATE
						, P_PROMOTION_EXPECT_DATE             IN DATE
						, P_DIR_INDIR_TYPE                    IN VARCHAR2
						, P_EMPLOYE_TYPE                      IN VARCHAR2
						, P_LEGAL_ZIP_CODE                    IN VARCHAR2
						, P_LEGAL_ADDR1                       IN VARCHAR2
						, P_LEGAL_ADDR2                       IN VARCHAR2
						, P_PRSN_ZIP_CODE                     IN VARCHAR2
						, P_PRSN_ADDR1                        IN VARCHAR2
						, P_PRSN_ADDR2                        IN VARCHAR2
						, P_LIVE_ZIP_CODE                     IN VARCHAR2
						, P_LIVE_ADDR1                        IN VARCHAR2
						, P_LIVE_ADDR2                        IN VARCHAR2
						, P_TELEPHON_NO                       IN VARCHAR2
						, P_HP_PHONE_NO                       IN VARCHAR2
						, P_EMAIL                             IN VARCHAR2
						, P_RELIGION_ID                       IN NUMBER
						, P_END_SCH_ID                        IN NUMBER
						, P_HOBBY                             IN VARCHAR2
						, P_TALENT                            IN VARCHAR2
						, P_JOB_CATEGORY_ID                   IN NUMBER
						, P_FLOOR_ID                          IN NUMBER
						, P_COST_CENTER_ID                    IN NUMBER
						, P_IC_CARD_NO                        IN VARCHAR2
						, P_OLD_PERSON_NUM                    IN VARCHAR2
						, P_CORP_TYPE                         IN VARCHAR2
						, P_SOB_ID                            IN NUMBER
						, P_ORG_ID                            IN NUMBER
						, P_DESCRIPTION                       IN VARCHAR2
						, P_USER_ID                           IN NUMBER
            )
  AS
    N_SYSDATE                                                             DATE;
    N_PERSON_ID                                                           HRM_PERSON_MASTER.PERSON_ID%TYPE := 0;
    N_PERSON_SEQ                                                          NUMBER := 0;
    V_YEAR                                                                EAPP_CALENDAR_YEAR.YEAR_STRING%TYPE := NULL;
    V_PERSON_NUM                                                          HRM_PERSON_MASTER.PERSON_NUM%TYPE := NULL;

  BEGIN
    N_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);

/*--------------------------------------------------------------------------------------*/
    -- BH 사번 채계 : X(O - 2000년 이전 입사자, B- 2000년 이후 입사자, O-파견직) + XX(년도) + XXX(일련번호).
    V_YEAR := TO_CHAR(N_SYSDATE, 'YYYY');
    IF V_YEAR < '2000' THEN
      V_PERSON_NUM := 'O' || SUBSTR(V_YEAR, 3, 2) ;
    ELSE
      V_PERSON_NUM := 'O' || SUBSTR(V_YEAR, 3, 2) ;
    END IF;

    BEGIN
      SELECT NVL(COUNT(PM.PERSON_ID), 0) + 1 AS PERSON_SEQ
        INTO N_PERSON_SEQ
      FROM HRM_PERSON_DISPATCH PM
      WHERE PM.SOB_ID                 = P_SOB_ID
        AND PM.ORG_ID                 = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      N_PERSON_SEQ := 1;
    END;
    V_PERSON_NUM := V_PERSON_NUM || LPAD(N_PERSON_SEQ, 3, 0);
    IF V_PERSON_NUM IS NULL THEN
      P_PERSON_NUM := '-';
      RETURN;
    END IF;
/*--------------------------------------------------------------------------------------*/
    -- 일련번호 채번.
    SELECT HRM_PERSON_MASTER_S1.NEXTVAL
      INTO N_PERSON_ID
    FROM DUAL;
    IF N_PERSON_ID IS NULL THEN
      RETURN;
    END IF;

    INSERT INTO HRM_PERSON_DISPATCH
      (PERSON_ID, PERSON_NUM, NAME, NAME1, NAME2
      , CORP_ID, DISPATCH_CORP_ID, OPERATING_UNIT_ID, DEPT_ID
      , NATION_ID, WORK_AREA_ID, WORK_TYPE_ID, JOB_CLASS_ID
      , JOB_ID, POST_ID, OCPT_ID, ABIL_ID
      , PAY_GRADE_ID, REPRE_NUM, SEX_TYPE
      , BIRTHDAY, BIRTHDAY_TYPE, MARRY_YN, MARRY_DATE
      , JOIN_ID, JOIN_ROUTE_ID
      , ORI_JOIN_DATE, JOIN_DATE, PAY_DATE, DEPT_DATE
      , OFFICIALLY_DATE, SHO_DATE, EXPIRE_DATE, PROMOTION_EXPECT_DATE
      , DIR_INDIR_TYPE, EMPLOYE_TYPE
      , LEGAL_ZIP_CODE, LEGAL_ADDR1, LEGAL_ADDR2
      , PRSN_ZIP_CODE, PRSN_ADDR1, PRSN_ADDR2
      , LIVE_ZIP_CODE, LIVE_ADDR1, LIVE_ADDR2
      , TELEPHON_NO, HP_PHONE_NO, EMAIL
      , RELIGION_ID, END_SCH_ID, HOBBY, TALENT
      , JOB_CATEGORY_ID, FLOOR_ID, COST_CENTER_ID
      , IC_CARD_NO, OLD_PERSON_NUM
      , CORP_TYPE, SOB_ID, ORG_ID, DISPLAY_NAME
      , DESCRIPTION
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      (N_PERSON_ID, V_PERSON_NUM, P_NAME, P_NAME1, P_NAME2
      , P_CORP_ID, P_DISPATCH_CORP_ID, P_OPERATING_UNIT_ID, P_DEPT_ID
      , P_NATION_ID, P_WORK_AREA_ID, P_WORK_TYPE_ID, P_JOB_CLASS_ID
      , P_JOB_ID, P_POST_ID, P_OCPT_ID, P_ABIL_ID
      , P_PAY_GRADE_ID, P_REPRE_NUM, P_SEX_TYPE
      , TRUNC(P_BIRTHDAY), P_BIRTHDAY_TYPE, NVL(P_MARRY_YN, 'N'), TRUNC(P_MARRY_DATE)
      , P_JOIN_ID, P_JOIN_ROUTE_ID
      , TRUNC(P_ORI_JOIN_DATE), TRUNC(P_JOIN_DATE), TRUNC(P_PAY_DATE), TRUNC(P_DEPT_DATE)
      , TRUNC(P_OFFICIALLY_DATE), TRUNC(P_SHO_DATE), TRUNC(P_EXPIRE_DATE), TRUNC(P_PROMOTION_EXPECT_DATE)
      , P_DIR_INDIR_TYPE, P_EMPLOYE_TYPE
      , P_LEGAL_ZIP_CODE, P_LEGAL_ADDR1, P_LEGAL_ADDR2
      , P_PRSN_ZIP_CODE, P_PRSN_ADDR1, P_PRSN_ADDR2
      , P_LIVE_ZIP_CODE, P_LIVE_ADDR1, P_LIVE_ADDR2
      , P_TELEPHON_NO, P_HP_PHONE_NO, P_EMAIL
      , P_RELIGION_ID, P_END_SCH_ID, P_HOBBY, P_TALENT
      , P_JOB_CATEGORY_ID, P_FLOOR_ID, P_COST_CENTER_ID
      , P_IC_CARD_NO, P_OLD_PERSON_NUM
      , P_CORP_TYPE, P_SOB_ID, P_ORG_ID, P_NAME || '(' || V_PERSON_NUM ||')'
      , P_DESCRIPTION
      , N_SYSDATE, P_USER_ID, N_SYSDATE, P_USER_ID
      );

      P_PERSON_ID := N_PERSON_ID;
      P_PERSON_NUM := V_PERSON_NUM;

  END DATA_INSERT;

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN NUMBER
            , P_NAME                              IN VARCHAR2
            , P_NAME1                             IN VARCHAR2
            , P_NAME2                             IN VARCHAR2
            , P_CORP_ID                           IN NUMBER
            , P_DISPATCH_CORP_ID                  IN NUMBER
            , P_OPERATING_UNIT_ID                 IN NUMBER
            , P_DEPT_ID                             IN NUMBER
            , P_NATION_ID                         IN NUMBER
            , P_WORK_AREA_ID                      IN NUMBER
            , P_WORK_TYPE_ID                      IN NUMBER
            , P_JOB_CLASS_ID                      IN NUMBER
            , P_JOB_ID                            IN NUMBER
            , P_POST_ID                           IN NUMBER
            , P_OCPT_ID                           IN NUMBER
            , P_ABIL_ID                           IN NUMBER
            , P_PAY_GRADE_ID                      IN NUMBER
            , P_REPRE_NUM                         IN VARCHAR2
            , P_SEX_TYPE                          IN VARCHAR2
            , P_BIRTHDAY                          IN DATE
            , P_BIRTHDAY_TYPE                     IN VARCHAR2
            , P_MARRY_YN                          IN VARCHAR2
            , P_MARRY_DATE                        IN DATE
            , P_JOIN_ID                           IN NUMBER
            , P_JOIN_ROUTE_ID                     IN NUMBER
            , P_ORI_JOIN_DATE                     IN DATE
            , P_JOIN_DATE                         IN DATE
            , P_PAY_DATE                          IN DATE
            , P_DEPT_DATE                         IN DATE
            , P_OFFICIALLY_DATE                   IN DATE
            , P_SHO_DATE                          IN DATE
            , P_EXPIRE_DATE                       IN DATE
            , P_PROMOTION_EXPECT_DATE             IN DATE
            , P_DIR_INDIR_TYPE                    IN VARCHAR2
            , P_EMPLOYE_TYPE                      IN VARCHAR2
            , P_LEGAL_ZIP_CODE                    IN VARCHAR2
            , P_LEGAL_ADDR1                       IN VARCHAR2
            , P_LEGAL_ADDR2                       IN VARCHAR2
            , P_PRSN_ZIP_CODE                     IN VARCHAR2
            , P_PRSN_ADDR1                        IN VARCHAR2
            , P_PRSN_ADDR2                        IN VARCHAR2
            , P_LIVE_ZIP_CODE                     IN VARCHAR2
            , P_LIVE_ADDR1                        IN VARCHAR2
            , P_LIVE_ADDR2                        IN VARCHAR2
            , P_TELEPHON_NO                       IN VARCHAR2
            , P_HP_PHONE_NO                       IN VARCHAR2
            , P_EMAIL                             IN VARCHAR2
            , P_RELIGION_ID                       IN NUMBER
            , P_END_SCH_ID                        IN NUMBER
            , P_HOBBY                             IN VARCHAR2
            , P_TALENT                            IN VARCHAR2
            , P_JOB_CATEGORY_ID                   IN NUMBER
            , P_FLOOR_ID                          IN NUMBER
            , P_COST_CENTER_ID                    IN NUMBER
            , P_IC_CARD_NO                        IN VARCHAR2
            , P_OLD_PERSON_NUM                    IN VARCHAR2
            , P_CORP_TYPE                         IN VARCHAR2
            , P_DESCRIPTION                       IN VARCHAR2
            , P_USER_ID                           IN NUMBER
            )
  AS
  BEGIN
      UPDATE HRM_PERSON_DISPATCH PM
      SET     PM.NAME                                               = P_NAME
            , PM.NAME1                                              = P_NAME1
            , PM.NAME2                                              = P_NAME2
            , PM.CORP_ID                                            = P_CORP_ID
            , PM.DISPATCH_CORP_ID                                   = P_DISPATCH_CORP_ID
            , PM.NATION_ID                                          = P_NATION_ID
            , PM.WORK_AREA_ID                                       = P_WORK_AREA_ID
            , PM.WORK_TYPE_ID                                       = P_WORK_TYPE_ID

            , PM.REPRE_NUM                                          = P_REPRE_NUM
            , PM.SEX_TYPE                                           = P_SEX_TYPE
            , PM.BIRTHDAY                                           = TRUNC(P_BIRTHDAY)
            , PM.BIRTHDAY_TYPE                                      = P_BIRTHDAY_TYPE
            , PM.MARRY_YN                                           = P_MARRY_YN
            , PM.MARRY_DATE                                         = TRUNC(P_MARRY_DATE)
            , PM.JOIN_ID                                            = P_JOIN_ID
            , PM.JOIN_ROUTE_ID                                      = P_JOIN_ROUTE_ID
            , PM.ORI_JOIN_DATE                                      = TRUNC(P_ORI_JOIN_DATE)
            , PM.JOIN_DATE                                          = TRUNC(P_JOIN_DATE)
            , PM.PAY_DATE                                           = TRUNC(P_PAY_DATE)
            , PM.DEPT_DATE                                          = TRUNC(P_DEPT_DATE)
            , PM.OFFICIALLY_DATE                                    = TRUNC(P_OFFICIALLY_DATE)
            , PM.SHO_DATE                                           = TRUNC(P_SHO_DATE)
            , PM.EXPIRE_DATE                                        = TRUNC(P_EXPIRE_DATE)
            , PM.PROMOTION_EXPECT_DATE                              = TRUNC(P_PROMOTION_EXPECT_DATE)
            , PM.DIR_INDIR_TYPE                                     = P_DIR_INDIR_TYPE
            , PM.EMPLOYE_TYPE                                       = P_EMPLOYE_TYPE
            , PM.LEGAL_ZIP_CODE                                     = P_LEGAL_ZIP_CODE
            , PM.LEGAL_ADDR1                                        = P_LEGAL_ADDR1
            , PM.LEGAL_ADDR2                                        = P_LEGAL_ADDR2
            , PM.PRSN_ZIP_CODE                                      = P_PRSN_ZIP_CODE
            , PM.PRSN_ADDR1                                         = P_PRSN_ADDR1
            , PM.PRSN_ADDR2                                         = P_PRSN_ADDR2
            , PM.LIVE_ZIP_CODE                                      = P_LIVE_ZIP_CODE
            , PM.LIVE_ADDR1                                         = P_LIVE_ADDR1
            , PM.LIVE_ADDR2                                         = P_LIVE_ADDR2
            , PM.TELEPHON_NO                                        = P_TELEPHON_NO
            , PM.HP_PHONE_NO                                        = P_HP_PHONE_NO
            , PM.EMAIL                                              = P_EMAIL
            , PM.RELIGION_ID                                        = P_RELIGION_ID
            , PM.END_SCH_ID                                         = P_END_SCH_ID
            , PM.HOBBY                                              = P_HOBBY
            , PM.TALENT                                             = P_TALENT

            , PM.COST_CENTER_ID                                     = P_COST_CENTER_ID
            , PM.IC_CARD_NO                                         = P_IC_CARD_NO
            , PM.OLD_PERSON_NUM                                     = P_OLD_PERSON_NUM
            , PM.CORP_TYPE                                          = P_CORP_TYPE
            , PM.DESCRIPTION                                        = P_DESCRIPTION
            , PM.LAST_UPDATE_DATE                                   = GET_LOCAL_DATE(PM.SOB_ID)
            , PM.LAST_UPDATED_BY                                    = P_USER_ID
            , PM.OPERATING_UNIT_ID                                  = P_OPERATING_UNIT_ID
            , PM.DEPT_ID                                            = P_DEPT_ID
            , PM.JOB_CLASS_ID                                       = P_JOB_CLASS_ID
            , PM.JOB_ID                                             = P_JOB_ID
            , PM.POST_ID                                            = P_POST_ID
            , PM.OCPT_ID                                            = P_OCPT_ID
            , PM.ABIL_ID                                            = P_ABIL_ID
            , PM.PAY_GRADE_ID                                       = P_PAY_GRADE_ID
            , PM.JOB_CATEGORY_ID                                    = P_JOB_CATEGORY_ID
            , PM.FLOOR_ID                                           = P_FLOOR_ID
      WHERE PM.PERSON_ID                                            = W_PERSON_ID
      ;

  END DATA_UPDATE;


-- 사원 ID를 가지고 이름 조회..
  FUNCTION NAME_F
           ( W_PERSON_ID                          IN NUMBER
           ) RETURN VARCHAR2
  AS
    V_NAME                                        VARCHAR2(100);

  BEGIN
    BEGIN
      SELECT PM.NAME
        INTO V_NAME
      FROM HRM_PERSON_DISPATCH PM
      WHERE PM.PERSON_ID                                      = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_NAME := NULL;
    END;

    RETURN V_NAME;

  END NAME_F;


-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT1
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_PERSON_ID                         IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_STD_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.PERSON_ID
      FROM HRM_PERSON_DISPATCH PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.PAY_GRADE_ID
                , HL.JOB_CATEGORY_ID
                , HL.FLOOR_ID
            FROM HRM_HISTORY_LINE HL
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_STD_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_STD_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;

  END LU_PERSON_SELECT1;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT2
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.PERSON_ID
      FROM HRM_PERSON_DISPATCH PM
        , (-- 시점 인사내역.
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
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.NAME                                    = NVL(W_NAME, PM.NAME)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;

  END LU_PERSON_SELECT2;


-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_SELECT3
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_NAME                              IN VARCHAR2
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
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
      FROM HRM_PERSON_DISPATCH PM
        , (-- 시점 인사내역.
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
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.CORP_ID                                 = NVL(W_CORP_ID, PM.CORP_ID)
        AND PM.NAME                                    = NVL(W_NAME, PM.NAME)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;

  END LU_PERSON_SELECT3;

-- LOOKUP PERSON INFOMATION.
  PROCEDURE LU_PERSON_DUTY
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
  BEGIN

    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.PERSON_ID
          , T1.JOB_CATEGORY_ID
          , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
          , PM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , PM.CORP_ID
          , PM.SOB_ID
          , PM.ORG_ID
          , WT.WORK_TYPE_ID
          , WT.WORK_TYPE
          , WT.WORK_TYPE_NAME
          , WT.WORK_TYPE_GROUP
      FROM HRM_PERSON_DISPATCH PM
        , (-- 시점 인사내역.
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
        , HRM_WORK_TYPE_V WT
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.WORK_TYPE_ID                            = WT.WORK_TYPE_ID
        AND PM.CORP_ID                                 = W_CORP_ID
        AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                  = W_ORG_ID
      ;

  END LU_PERSON_DUTY;

-- LOOKUP PERSON INFOMATION - CAPACITY.
  PROCEDURE LU_PERSON_DUTY_C
            ( P_CURSOR3                           OUT TYPES.TCURSOR3
            , W_CORP_ID                           IN NUMBER
            , W_WORK_TYPE_ID                      IN NUMBER
            , W_DEPT_ID                           IN NUMBER
            , W_START_DATE                        IN DATE
            , W_END_DATE                          IN DATE
            , W_CONNECT_PERSON_ID                 IN NUMBER
            , W_SOB_ID                            IN NUMBER
            , W_ORG_ID                            IN NUMBER
            )
  AS
    V_CONNECT_PERSON_ID                                   HRM_PERSON_DISPATCH.PERSON_ID%TYPE := NULL;

  BEGIN
    IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                               , W_START_DATE => W_START_DATE
                               , W_END_DATE => W_END_DATE
                               , W_MODULE_CODE => '20'
                               , W_PERSON_ID => W_CONNECT_PERSON_ID
                               , W_SOB_ID => W_SOB_ID
                               , W_ORG_ID => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;

    OPEN P_CURSOR3 FOR
      SELECT PM.NAME
          , PM.PERSON_NUM
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
          , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID) AS PAY_GRADE_NAME
          , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) EMPLOYE_TYPE_NAME
          , PM.ORI_JOIN_DATE
          , PM.JOIN_DATE
          , PM.RETIRE_DATE
          , PM.PERSON_ID
          , T1.JOB_CATEGORY_ID
          , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
          , PM.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
          , PM.CORP_ID
          , PM.SOB_ID
          , PM.ORG_ID
          , WT.WORK_TYPE_ID
          , WT.WORK_TYPE
          , WT.WORK_TYPE_NAME
          , WT.WORK_TYPE_GROUP
      FROM HRM_PERSON_DISPATCH PM
        , (-- 시점 인사내역.
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
        , HRM_WORK_TYPE_V WT
      WHERE PM.PERSON_ID                               = T1.PERSON_ID
        AND PM.WORK_TYPE_ID                            = WT.WORK_TYPE_ID
        AND PM.CORP_ID                                 = W_CORP_ID
        AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
        AND T1.DEPT_ID                                 = NVL(W_DEPT_ID, T1.DEPT_ID)
        AND PM.ORI_JOIN_DATE                           <= W_END_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_START_DATE)
        AND PM.SOB_ID                                  = W_SOB_ID
        AND PM.ORG_ID                                    = W_ORG_ID
        AND EXISTS (SELECT 'X'
                      FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID                                 = PM.CORP_ID
                       AND DM.DUTY_CONTROL_ID                         = T1.FLOOR_ID
                       AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                       AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                       AND DM.SOB_ID                                  = PM.SOB_ID
                       AND DM.ORG_ID                                  = PM.ORG_ID
                   )
      ;

  END LU_PERSON_DUTY_C;

END HRM_PERSON_DISPATCH_G;
/
