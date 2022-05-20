CREATE OR REPLACE PACKAGE HRD_WORK_CALENDAR_G
AS
                                                  	
-- DATA_SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, P_WORK_YYYYMM                       IN HRD_WORK_CALENDAR.WORK_YYYYMM%TYPE
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
  				, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
      , W_EMPLOYE_TYPE                      IN HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
						);

-- DATA_SELECT_DETAIL.
  PROCEDURE DATA_SELECT_DETAIL
	          ( P_CUR1                              OUT TYPES.TCURSOR1
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						);

-- DATA_INSERT.
  PROCEDURE DATA_INSERT
	          (P_WORK_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						);

-- DATA_UPDATE.
  PROCEDURE DATA_UPDATE
	          ( W_WORK_DATE                         IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_PERSON_ID                         IN HRD_WORK_CALENDAR.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_WORK_CALENDAR.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_WORK_CALENDAR.ORG_ID%TYPE
						, P_DUTY_ID                           IN HRD_WORK_CALENDAR.DUTY_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						, P_OPEN_TIME                         IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE
						, P_CLOSE_TIME                        IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
						, P_DESCRIPTION                       IN HRD_WORK_CALENDAR.DESCRIPTION%TYPE
						, P_USER_ID                           IN HRD_WORK_CALENDAR.CREATED_BY%TYPE
           , P_HOLY_TYPE_2                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						);

-- DATA_DELETE..
  PROCEDURE DATA_DELETE
	          ( P_WORK_DATE                         IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						);

-- DATA_SELECT_SHORT.
  PROCEDURE DATA_SELECT_S
	          ( P_CUR1                              OUT TYPES.TCURSOR1
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						);												

---------------------------------------------------------------------------------------------------
-- 유휴일수 반환.
  FUNCTION HOLY_1_COUNT_F
            ( W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;
           
-- 무휴일수 반환.
  FUNCTION HOLY_0_COUNT_F
            ( W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER;
            
-- 년월의 시작 및 종료일 조회 LOOK UP.
  PROCEDURE YYYYMM_TERM_F
	          ( W_YYYYMM                            IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE
						, W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
						, O_START_DATE                        OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, O_END_DATE                          OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
						);

-- DATA SELECT OPEN TIME / CLOSE TIME.
  PROCEDURE WORK_IO_TIME_F
	          ( W_WORK_TYPE                         IN VARCHAR2
            , W_HOLY_TYPE                         IN VARCHAR2
            , W_WORK_DATE                         IN DATE
						, W_SOB_ID                            IN NUMBER
						, W_ORG_ID                            IN NUMBER
						, O_OPEN_TIME                         OUT DATE
						, O_CLOSE_TIME                        OUT DATE
            );
	
-- 년월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_START_YYYYMM                      IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
						, W_END_YYYYMM                        IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
						, W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
						);

---------------------------------------------------------------------------------------------------
-- 근무카렌다 생성 기준 조회.
  -- 기적용일수 조회.
  PROCEDURE CALENDAR_PRE_WORK_DAY_P
	          ( W_WORK_YYYYMM                       IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_DATE_FR                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , W_WORK_DATE_TO                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD                    IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
  					, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            , O_DAY_COUNT                         OUT NUMBER
						);
  
  -- 근무카렌다 기적용일수 삽입.
  PROCEDURE SAVE_PRE_WORK_DAY
	          ( P_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , P_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , P_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , P_DAY_COUNT      IN HRD_WORK_CALENDAR_SET.DAY_COUNT%TYPE
            , P_WORK_DATE_FR   IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , P_WORK_DATE_TO   IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
            , P_DESCRIPTION    IN HRD_WORK_CALENDAR_SET.DESCRIPTION%TYPE
            , P_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , P_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
            , P_USER_ID        IN HRD_WORK_CALENDAR_SET.CREATED_BY%TYPE 
						);
            
  -- 근무계획 생성 기준.
  PROCEDURE SELECT_CALENDAR_SET
	          ( P_CURSOR2                           OUT TYPES.TCURSOR2
						, W_WORK_YYYYMM                       IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_DATE_FR                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , W_WORK_DATE_TO                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD                    IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
  					, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						);

-- 근무카렌다 생성 기준 삽입 자료 조회..
  PROCEDURE SELECT_CALENDAR_SET_INSERT
	          ( P_CURSOR2                           OUT TYPES.TCURSOR2
						, W_WORK_YYYYMM                       IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
						, W_WORK_TYPE_GROUP                   IN VARCHAR2
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
  					, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						);
            
-- 근무카렌다 생성 기준 삽입.
  PROCEDURE INSERT_CALENDAR_SET
	          ( P_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , P_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , P_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , P_SEQ            OUT HRD_WORK_CALENDAR_SET.SEQ%TYPE
            , P_HOLY_TYPE      IN HRD_WORK_CALENDAR_SET.HOLY_TYPE%TYPE
            , P_DAY_COUNT      IN HRD_WORK_CALENDAR_SET.DAY_COUNT%TYPE
            , P_WORK_DATE_FR   IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , P_WORK_DATE_TO   IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
            , P_DESCRIPTION    IN HRD_WORK_CALENDAR_SET.DESCRIPTION%TYPE
            , P_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , P_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
            , P_USER_ID        IN HRD_WORK_CALENDAR_SET.CREATED_BY%TYPE 
						);

-- 근무카렌다 생성 기준 삭제.
  PROCEDURE DELETE_CALENDAR_SET
	          ( W_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , W_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , W_SEQ            IN HRD_WORK_CALENDAR_SET.SEQ%TYPE
            , W_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , W_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
						);

-- 근무카렌다 생성 기준 삭제 - 해당 생성 방법에 대해 적용 기간.
  PROCEDURE DELETE_CALENDAR_SET_ALL
	          ( W_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , W_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_DATE_FR   IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , W_WORK_DATE_TO   IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
            , W_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , W_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , W_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
						);
            
-- Work Calendar Create.
  PROCEDURE  WORKCAL_SET
	           ( P_CORP_ID                          IN HRD_WORK_CALENDAR.CORP_ID%TYPE
						 , P_PERSON_ID                        IN HRD_WORK_CALENDAR.PERSON_ID%TYPE
						 , P_DEPT_ID                          IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						 , P_WORK_TYPE_ID                     IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
						 , P_START_DATE                       IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						 , P_END_DATE                         IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						 , P_PRE_DAY_COUNT                    IN NUMBER
						 , P_HOLY_TYPE1                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						 , P_HOLY_COUNT1                      IN NUMBER
						 , P_HOLY_TYPE2                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						 , P_HOLY_COUNT2                      IN NUMBER
						 , P_HOLY_TYPE3                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						 , P_HOLY_COUNT3                      IN NUMBER
						 , P_HOLY_TYPE4                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						 , P_HOLY_COUNT4                      IN NUMBER
						 , P_HOLY_TYPE5                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						 , P_HOLY_COUNT5                      IN NUMBER
						 , P_HOLY_TYPE6                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
						 , P_HOLY_COUNT6                      IN NUMBER
						 , P_USER_ID                          IN HRD_WORK_CALENDAR.CREATED_BY%TYPE
						 , P_SOB_ID                           IN HRD_WORK_CALENDAR.SOB_ID%TYPE
						 , P_ORG_ID                           IN HRD_WORK_CALENDAR.ORG_ID%TYPE
						 , O_MESSAGE                          OUT VARCHAR2
						 );


-- Table을 이용한 Work Calendar Create.
  PROCEDURE  WORKCAL_SET_TABLE
            ( P_CORP_ID                          IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , P_WORK_PERIOD                      IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_PERSON_ID                        IN HRD_WORK_CALENDAR.PERSON_ID%TYPE
            , P_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID                     IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , P_WORK_DATE_FR                     IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_WORK_DATE_TO                     IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_CREATE_TYPE                      IN VARCHAR2 DEFAULT NULL                     -- 전호수 추가(신규입사시 사용).
            , P_USER_ID                          IN HRD_WORK_CALENDAR.CREATED_BY%TYPE
            , P_SOB_ID                           IN HRD_WORK_CALENDAR.SOB_ID%TYPE
            , P_ORG_ID                           IN HRD_WORK_CALENDAR.ORG_ID%TYPE
            , O_STATUS                           OUT VARCHAR2
            , O_MESSAGE                          OUT VARCHAR2
            );


-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
            ( P_CURSOR3            OUT TYPES.TCURSOR3
            , W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
            , W_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
            , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
            , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
            , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
            );

-- LOOKUP PERSON INFOMATION - CAPACITY.
       PROCEDURE LU_PERSON_WORK_CALENDAR_C( P_CURSOR3                           OUT TYPES.TCURSOR3
                                          , W_CORP_ID                           IN  NUMBER
                                          , W_FLOOR_ID                          IN  NUMBER
                                          , W_WORK_TYPE_ID                      IN  NUMBER
                                          , W_CONNECT_PERSON_ID                 IN  NUMBER
                                          , W_SOB_ID                            IN  NUMBER
                                          , W_ORG_ID                            IN  NUMBER
                                          );


-- [2011-10-31]
   PROCEDURE LU_SELECT_HOLY
           ( P_CURSOR3            OUT TYPES.TCURSOR3
           , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
           );


-- [2011-12-30]
   PROCEDURE LU_SELECT_HOLY_OTHER
           ( P_CURSOR3            OUT TYPES.TCURSOR3
           , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
           );



       PROCEDURE DEFAULT_FLOOR( O_FLOOR_ID            OUT HRM_PERSON_MASTER.FLOOR_ID%TYPE
                              , O_FLOOR_NAME          OUT VARCHAR2
                              , O_PERSON_NAME         OUT HRM_PERSON_MASTER.DISPLAY_NAME%TYPE
                              , O_CAPACITY            OUT VARCHAR2
                              , W_SOB_ID              IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                              , W_ORG_ID              IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                              , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                              );


        PROCEDURE SELECT_MODIFY_FLOOR_WORKTYPE( P_CURSOR                            OUT TYPES.TCURSOR
                                             , W_SOB_ID                            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                             , W_ORG_ID                            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                             , W_WORK_CORP_ID                      IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                             , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_FLOOR_ID                          IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                             , W_WORK_TYPE_ID                      IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                             , W_CONNECT_PERSON_ID                 IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_EMPLOYE_TYPE                      IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                             );

       PROCEDURE SELECT_DETAIL_WORK_CALENDAR( P_CUR1                              OUT TYPES.TCURSOR1
                                            , W_SOB_ID                            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                            , W_ORG_ID                            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                            , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                            , W_START_DATE                        IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                            , W_END_DATE                          IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                            );



-- 근무계획 생성되지 않은 사원 [2011-11-11]
   PROCEDURE SELECT_NOT_CREATE_WORKCALENDAR( P_CURSOR        OUT TYPES.TCURSOR
                                           , W_SOB_ID        IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                           , W_ORG_ID        IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                           , W_WORK_CORP_ID  IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                           , W_WORK_TYPE_ID  IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                           , W_FLOOR_ID      IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                           , W_PERSON_ID     IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                           , W_WORK_DATE_FR  IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                           , W_WORK_DATE_TO  IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                           );


-- 근무계획 기준정보 조회 [2011-12-28]
   PROCEDURE SELECT_CREATED_CALENDAR_SET
           ( P_CURSOR          OUT TYPES.TCURSOR
           , W_SOB_ID          IN  HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
           , W_ORG_ID          IN  HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
           , W_WORK_CORP_ID    IN  HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
           , W_WORK_PERIOD     IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_WORK_TYPE_ID    IN  HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD  IN  HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           );


-- 근무계획 기준정보 조회 수정 [2011-12-30]
   PROCEDURE UPDATE_CREATED_CALENDAR_SET
           ( W_SOB_ID          IN  HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
           , W_ORG_ID          IN  HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
           , W_WORK_CORP_ID    IN  HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
           , W_WORK_PERIOD     IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_WORK_TYPE_ID    IN  HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD  IN  HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           , W_SEQ             IN  HRD_WORK_CALENDAR_SET.SEQ%TYPE
           , P_HOLY_TYPE       IN  HRD_WORK_CALENDAR_SET.HOLY_TYPE%TYPE
           , P_DAY_COUNT       IN  HRD_WORK_CALENDAR_SET.DAY_COUNT%TYPE
           , P_USER_ID         IN  HRD_WORK_CALENDAR_SET.LAST_UPDATED_BY%TYPE
           );

-- 근무계획 기준정보 조회 삭제 [2011-12-30]
   PROCEDURE DELETE_CREATED_CALENDAR_SET
           ( W_SOB_ID          IN  HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
           , W_ORG_ID          IN  HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
           , W_WORK_CORP_ID    IN  HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
           , W_WORK_PERIOD     IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_WORK_TYPE_ID    IN  HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD  IN  HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           , W_SEQ             IN  HRD_WORK_CALENDAR_SET.SEQ%TYPE
           );



END HRD_WORK_CALENDAR_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRD_WORK_CALENDAR_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : HR
/* Program Name : HRD_WORK_CALENDAR_G
/* Description  : 근무계획표 관리 패키지
/*
/* Reference by : 근무계획표 관리.
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 07-JUN-2010  Jeon Ho Su          Initialize
/******************************************************************************/
-- DATA_SELECT.
  PROCEDURE DATA_SELECT
	          ( P_CURSOR                            OUT TYPES.TCURSOR
						, P_WORK_YYYYMM                       IN HRD_WORK_CALENDAR.WORK_YYYYMM%TYPE
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
  				, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
      , W_EMPLOYE_TYPE                      IN HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
						)
  AS
	  V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
		D_START_DATE                                  DATE := NULL;
		D_END_DATE                                    DATE := NULL;
		V_WORK_TERM_TYPE                              HRM_WORK_TERM_V.DUTY_TERM_TYPE%TYPE;
    
  BEGIN
	  -- 해당월에 대한 시작, 종료일자 설정.
		BEGIN
		  SELECT CT.CLOSING_TYPE
			  INTO V_WORK_TERM_TYPE
			  FROM HRM_CLOSING_TYPE_V CT
			 WHERE CT.MODULE_TYPE        = 'DUTY'
			   AND CT.PERIOD_TYPE        = 'MONTH'
				 AND CT.ENABLED_FLAG       = 'Y'
				 AND CT.SOB_ID             = W_SOB_ID
				 AND CT.ORG_ID             = W_ORG_ID
			;
    EXCEPTION WHEN OTHERS THEN
		  V_WORK_TERM_TYPE := 'D2';
		END;
    
    -- 해당월에 대한 시작, 종료일자 설정.
		BEGIN
		  HRM_COMMON_DATE_G.YYYYMM_TERM_P( W_YYYYMM => P_WORK_YYYYMM
		                               , W_WORK_TERM_TYPE => V_WORK_TERM_TYPE
																	 , W_JOB_CATEGORY_CODE => NULL
																	 , W_SOB_ID => W_SOB_ID
																	 , W_ORG_ID => W_ORG_ID
																	 , O_START_DATE => D_START_DATE
																	 , O_END_DATE => D_END_DATE
																	 );
		EXCEPTION WHEN OTHERS THEN
		  D_START_DATE := TO_DATE(P_WORK_YYYYMM || '-01', 'YYYY-MM-DD');
			D_END_DATE := ADD_MONTHS(D_START_DATE, 1) - 1;
		END;						

		-- 근태권한 설정.
		IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID 
		                           , W_START_DATE => D_START_DATE
															 , W_END_DATE => D_END_DATE
															 , W_MODULE_CODE => '20'
															 , W_PERSON_ID => W_CONNECT_PERSON_ID
															 , W_SOB_ID => W_SOB_ID
															 , W_ORG_ID => W_ORG_ID) = 'C' THEN
		  V_CONNECT_PERSON_ID := NULL;
		ELSE
		  V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
		END IF;
		-- 부서별 관리 기준 작성.
    OPEN P_CURSOR FOR
      SELECT HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) FLOOR_NAME
					 , PM.PERSON_ID
					 , PM.DISPLAY_NAME AS NAME
					 , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID) || '(' || HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) || ')' AS JOB_CATEGORY_NAME
					 , PM.JOIN_DATE
					 , PM.RETIRE_DATE
					 , D_START_DATE AS START_DATE
					 , D_END_DATE   AS END_DATE
      , HRM_COMMON_G.GET_CODE_F(PM.WORK_TYPE_ID, PM.SOB_ID, PM.ORG_ID) AS WORK_TYPE_CODE
			FROM HRM_PERSON_MASTER PM
			  , (-- 시점 인사내역.
						SELECT HL.PERSON_ID
								, HL.DEPT_ID
								, HL.JOB_CATEGORY_ID
						FROM HRM_HISTORY_LINE HL  
						WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
																						FROM HRM_HISTORY_LINE S_HL
																					 WHERE S_HL.CHARGE_DATE            <= D_END_DATE
																					   AND S_HL.PERSON_ID              = HL.PERSON_ID
																					 GROUP BY S_HL.PERSON_ID
																				 )
					) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                       , PH.WORK_TYPE_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  D_END_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  D_END_DATE
                 ) T2
			WHERE PM.PERSON_ID                  = T1.PERSON_ID
    AND PM.PERSON_ID                               = T2.PERSON_ID
			  AND PM.WORK_CORP_ID               = W_CORP_ID
				AND PM.PERSON_ID                  = NVL(W_PERSON_ID, PM.PERSON_ID)
				AND PM.SOB_ID                     = W_SOB_ID
				AND PM.ORG_ID                     = W_ORG_ID
				AND T2.FLOOR_ID                    = NVL(W_FLOOR_ID, T2.FLOOR_ID)
				AND PM.WORK_TYPE_ID               = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
				AND PM.JOIN_DATE                  <= D_END_DATE
				AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= D_START_DATE)
    AND PM.EMPLOYE_TYPE                = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
				AND EXISTS (SELECT 'X'
				              FROM HRD_DUTY_MANAGER DM
 										 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
										   AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
											 AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
											 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
											 AND DM.START_DATE                              <= D_END_DATE
											 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= D_START_DATE)
											 AND DM.SOB_ID                                  = PM.SOB_ID
											 AND DM.ORG_ID                                  = PM.ORG_ID
									 )
      ORDER BY HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)
             , PM.DISPLAY_NAME
			;

  END DATA_SELECT;
	
-- DATA_SELECT_DETAIL.
  PROCEDURE DATA_SELECT_DETAIL
	          ( P_CUR1                              OUT TYPES.TCURSOR1
						, W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
						, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
						)
  AS
		N_DAY_COUNT                                   NUMBER := 0;
		V_WORK_TYPE_ID                                HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE := NULL;
		
	BEGIN
		-- 임시테이블 삭제.
		BEGIN
		  /*DELETE FROM HRD_WORK_DATE_GT WD
			WHERE WD.RUN_DATETIME                          <  (D_SYSDATE- (1 / 24 / 60 * 20))
			  AND WD.SOB_ID                                = W_SOB_ID
				AND WD.ORG_ID                                = W_ORG_ID;*/
      DELETE FROM HRD_WORK_DATE_GT WD;
	  END;
		-- 월 달력 생성.
    IF W_END_DATE IS NULL OR W_START_DATE IS NULL THEN
      N_DAY_COUNT := 0;
    ELSE
      N_DAY_COUNT := W_END_DATE - W_START_DATE + 1;
    END IF;	  
    BEGIN
			FOR C1 IN 0 .. N_DAY_COUNT - 1
			LOOP
			  /*INSERT INTO HRD_WORK_DATE
				(SESSION_ID, RUN_DATETIME, WORK_DATE, PERSON_ID, WORK_WEEK, SOB_ID, ORG_ID)
				VALUES
				(USERENV_G.GET_SESSION_ID_F, D_SYSDATE, W_START_DATE + C1, W_PERSON_ID, TO_CHAR(W_START_DATE + C1, 'D'), W_SOB_ID, W_ORG_ID)
				;*/
        INSERT INTO HRD_WORK_DATE_GT
				(WORK_DATE, PERSON_ID, WORK_WEEK, SOB_ID, ORG_ID)
				VALUES
				(W_START_DATE + C1, W_PERSON_ID, TO_CHAR(W_START_DATE + C1, 'D'), W_SOB_ID, W_ORG_ID)
				;
			END LOOP C1;
	  END;
		
		-- 교대유형 조회.
		BEGIN
		  SELECT PM.WORK_TYPE_ID
			  INTO V_WORK_TYPE_ID
			FROM HRM_PERSON_MASTER PM
			WHERE PM.PERSON_ID                           = W_PERSON_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  V_WORK_TYPE_ID := 0;
		END;
		
    OPEN P_CUR1 FOR
		  SELECT WD.WORK_DATE
					 , HRM_COMMON_G.WEEK_F(NVL(WC.WORK_WEEK, WD.WORK_WEEK), WD.SOB_ID, W_ORG_ID) DATE_WEEK
					 , NVL(WC.WORK_TYPE_ID, V_WORK_TYPE_ID) AS WORK_TYPE_ID
					 , HRM_COMMON_G.ID_NAME_F(NVL(WC.WORK_TYPE_ID, V_WORK_TYPE_ID)) WORK_TYPE_NAME
					 , WC.DUTY_ID
					 , HRM_COMMON_G.ID_NAME_F(WC.DUTY_ID) DUTY_NAME
					 , WC.HOLY_TYPE
					 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) HOLY_TYPE_NAME
					 , WC.OPEN_TIME OPEN_TIME
					 , WC.CLOSE_TIME CLOSE_TIME
					 , TO_CHAR(WC.BEFORE_OT_START, 'HH24:MI') AS BEFORE_OT_START
					 , TO_CHAR(WC.BEFORE_OT_END, 'HH24:MI') AS BEFORE_OT_END
					 , WC.AFTER_OT_START
					 , WC.AFTER_OT_END
					 , WC.LUNCH_YN
					 , WC.DINNER_YN
					 , WC.MIDNIGHT_YN
      , WC.BREAKFAST_YN
      , WC.DANGJIK_YN
      , WC.ALL_NIGHT_YN
      , WC.DESCRIPTION
      , WC.C_DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(WC.C_DUTY_ID) C_DUTY_NAME
      , WC.C_DUTY_ID1
      , HRM_COMMON_G.ID_NAME_F(WC.C_DUTY_ID1) C_DUTY_NAME1
      , WC.OLD_OPEN_TIME
      , WC.OLD_CLOSE_TIME
      , WC.PERSON_ID
      , WC.ATTRIBUTE5 WORK_TYPE
      , WC.ATTRIBUTE3 AS HOLY_TYPE_CODE_2
					 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.ATTRIBUTE3, WC.SOB_ID, WC.ORG_ID) HOLY_TYPE_NAME_2
   FROM  HRD_WORK_DATE_GT WD
       , HRD_WORK_CALENDAR WC
   WHERE WD.WORK_DATE                  = WC.WORK_DATE(+)
     AND WD.PERSON_ID                  = WC.PERSON_ID(+)
    AND WD.SOB_ID                     = WC.SOB_ID(+)
    AND WD.ORG_ID                     = WC.ORG_ID(+)
    AND WD.WORK_DATE                  BETWEEN W_START_DATE AND W_END_DATE
     AND WD.PERSON_ID                  = W_PERSON_ID
    AND WD.SOB_ID                     = W_SOB_ID
    AND WD.ORG_ID                     = W_ORG_ID
      ORDER BY WD.WORK_DATE
   ;
      
   /*OPEN P_CUR1 FOR
    SELECT WD.WORK_DATE
      , HRM_COMMON_G.WEEK_F(NVL(WC.WORK_WEEK, WD.WORK_WEEK), WD.SOB_ID, W_ORG_ID) DATE_WEEK
      , NVL(WC.WORK_TYPE_ID, V_WORK_TYPE_ID) AS WORK_TYPE_ID
      , HRM_COMMON_G.ID_NAME_F(NVL(WC.WORK_TYPE_ID, V_WORK_TYPE_ID)) WORK_TYPE_NAME
      , WC.DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(WC.DUTY_ID) DUTY_NAME
      , WC.HOLY_TYPE
      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) HOLY_TYPE_NAME
      , WC.OPEN_TIME OPEN_TIME
      , WC.CLOSE_TIME CLOSE_TIME
      , WC.BEFORE_OT_START
      , WC.BEFORE_OT_END
      , WC.AFTER_OT_START
      , WC.AFTER_OT_END
      , WC.LUNCH_YN
      , WC.DINNER_YN
      , WC.MIDNIGHT_YN
      , WC.DANGJIK_YN
      , WC.ALL_NIGHT_YN
      , WC.DESCRIPTION
      , WC.C_DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(WC.C_DUTY_ID) C_DUTY_NAME
      , WC.C_DUTY_ID1
      , HRM_COMMON_G.ID_NAME_F(WC.C_DUTY_ID1) C_DUTY_NAME1
      , WC.OLD_OPEN_TIME
      , WC.OLD_CLOSE_TIME
      , WC.PERSON_ID
      , WC.ATTRIBUTE5 WORK_TYPE
   FROM  HRD_WORK_DATE WD
       , HRD_WORK_CALENDAR WC
   WHERE WD.WORK_DATE                  = WC.WORK_DATE(+)
     AND WD.PERSON_ID                  = WC.PERSON_ID(+)
    AND WD.SOB_ID                     = WC.SOB_ID(+)
    AND WD.ORG_ID                     = WC.ORG_ID(+)
    AND WD.WORK_DATE                  BETWEEN W_START_DATE AND W_END_DATE
     AND WD.PERSON_ID                  = W_PERSON_ID
    AND WD.SOB_ID                     = W_SOB_ID
    AND WD.ORG_ID                     = W_ORG_ID
    AND WD.RUN_DATETIME               = D_SYSDATE
    AND WD.SESSION_ID                 = USERENV_G.GET_SESSION_ID_F
   ;*/
 
 END DATA_SELECT_DETAIL;
  
-- DATA_INSERT.
  PROCEDURE DATA_INSERT
           (P_WORK_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      )
  AS
  BEGIN
    NULL;

  END DATA_INSERT;

---- DATA_UPDATE.
   PROCEDURE DATA_UPDATE
           ( W_WORK_DATE                         IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
           , W_PERSON_ID                         IN HRD_WORK_CALENDAR.PERSON_ID%TYPE
           , W_SOB_ID                            IN HRD_WORK_CALENDAR.SOB_ID%TYPE
           , W_ORG_ID                            IN HRD_WORK_CALENDAR.ORG_ID%TYPE
           , P_DUTY_ID                           IN HRD_WORK_CALENDAR.DUTY_ID%TYPE
           , P_HOLY_TYPE                         IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
           , P_OPEN_TIME                         IN HRD_WORK_CALENDAR.OPEN_TIME%TYPE
           , P_CLOSE_TIME                        IN HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
           , P_DESCRIPTION                       IN HRD_WORK_CALENDAR.DESCRIPTION%TYPE
           , P_USER_ID                           IN HRD_WORK_CALENDAR.CREATED_BY%TYPE
           , P_HOLY_TYPE_2                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
           )
   AS
   BEGIN
             UPDATE HRD_WORK_CALENDAR WC
                SET WC.DUTY_ID                              = P_DUTY_ID
                  , WC.HOLY_TYPE                            = P_HOLY_TYPE
                  , WC.OPEN_TIME                            = P_OPEN_TIME
                  , WC.CLOSE_TIME                           = P_CLOSE_TIME
                  , WC.OLD_OPEN_TIME                        = DECODE(WC.OPEN_TIME, P_OPEN_TIME, WC.OLD_OPEN_TIME, WC.OPEN_TIME)
                  , WC.OLD_CLOSE_TIME                       = DECODE(WC.CLOSE_TIME, P_CLOSE_TIME, WC.OLD_CLOSE_TIME, WC.CLOSE_TIME)
                  , WC.DESCRIPTION                          = P_DESCRIPTION
                  , WC.LAST_UPDATE_DATE                     = GET_LOCAL_DATE(WC.SOB_ID)
                  , WC.LAST_UPDATED_BY                      = P_USER_ID
                  , WC.ATTRIBUTE3                           = P_HOLY_TYPE_2
              WHERE WC.WORK_DATE                            = W_WORK_DATE
                AND WC.PERSON_ID                            = W_PERSON_ID
                AND WC.SOB_ID                               = W_SOB_ID
                AND WC.ORG_ID                               = W_ORG_ID
                  ;

   END DATA_UPDATE;

-- DATA_DELETE..
  PROCEDURE DATA_DELETE
           ( P_WORK_DATE                         IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      )
  AS
  BEGIN
    NULL;

  END DATA_DELETE;

-- DATA_SELECT_SHORT.
  PROCEDURE DATA_SELECT_S
           ( P_CUR1                              OUT TYPES.TCURSOR1
      , W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
      )
  AS
 BEGIN
   OPEN P_CUR1 FOR
   SELECT WC.WORK_DATE
          , NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID)) DUTY_ID
          , HRM_COMMON_G.ID_NAME_F(NVL(WC.C_DUTY_ID1, NVL(WC.C_DUTY_ID, WC.DUTY_ID))) DUTY_NAME
          , WC.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) HOLY_TYPE_NAME
          , WC.OPEN_TIME OPEN_TIME
          , WC.CLOSE_TIME CLOSE_TIME
          , WC.BEFORE_OT_START
          , WC.BEFORE_OT_END
          , WC.AFTER_OT_START
          , WC.AFTER_OT_END
          , WC.LUNCH_YN
          , WC.DINNER_YN
          , WC.MIDNIGHT_YN
          , WC.DANGJIK_YN
          , WC.ALL_NIGHT_YN
          , WC.DESCRIPTION
          , WC.ATTRIBUTE5 WORK_TYPE
          , WC.BREAKFAST_YN
      FROM  HRD_WORK_CALENDAR WC
   WHERE WC.WORK_DATE                  BETWEEN W_START_DATE AND W_END_DATE
    AND WC.PERSON_ID                  = W_PERSON_ID
    AND WC.SOB_ID                     = W_SOB_ID
    AND WC.ORG_ID                     = W_ORG_ID
   ;
  
 END DATA_SELECT_S;      


---------------------------------------------------------------------------------------------------
-- 유휴일수 반환.
  FUNCTION HOLY_1_COUNT_F
            ( W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_WORK_DATE_FR                                DATE;
    V_WORK_DATE_TO                                DATE;
    V_RECORD_COUNT                                NUMBER := 0;
    
  BEGIN
    V_WORK_DATE_FR := W_START_DATE;
    V_WORK_DATE_TO := W_END_DATE;    
    -- 입사일자 체크.
    BEGIN
      SELECT CASE 
               WHEN W_START_DATE < PM.ORI_JOIN_DATE THEN PM.ORI_JOIN_DATE
               ELSE W_START_DATE
             END AS WORK_DATE_FR
           , CASE 
               WHEN PM.RETIRE_DATE IS NULL THEN W_END_DATE
               WHEN PM.RETIRE_DATE < W_END_DATE THEN PM.RETIRE_DATE
               ELSE W_END_DATE
             END AS WORK_DATE_FR
        INTO V_WORK_DATE_FR, V_WORK_DATE_TO     
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID        = W_PERSON_ID
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;      
    END;
    
    BEGIN
      SELECT COUNT(WC.HOLY_TYPE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_WORK_CALENDAR WC
          , HRM_WORK_TYPE_V WT
      WHERE WC.WORK_TYPE_ID    = WT.WORK_TYPE_ID
        AND WC.WORK_DATE       >= V_WORK_DATE_FR  
        AND WC.WORK_DATE       <= V_WORK_DATE_TO
        AND WC.PERSON_ID       = W_PERSON_ID
        AND WC.SOB_ID          = W_SOB_ID
        AND WC.ORG_ID          = W_ORG_ID
        AND WC.HOLY_TYPE       = '1'
        AND NOT EXISTS 
              ( SELECT 'X'
                  FROM HRD_HOLIDAY_CALENDAR HC
                WHERE HC.WORK_DATE          = WC.WORK_DATE
                  AND HC.ALL_CHECK          = CASE 
                                                WHEN WT.WORK_TYPE IN('32') THEN 'Y'
                                                ELSE HC.ALL_CHECK
                                              END
                  AND HC.SOB_ID             = WC.SOB_ID
                  AND HC.ORG_ID             = WC.ORG_ID
                )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;    
    END;
    RETURN V_RECORD_COUNT;
    
  END HOLY_1_COUNT_F;
           
-- 무휴일수 반환.
  FUNCTION HOLY_0_COUNT_F
            ( W_PERSON_ID                         IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_START_DATE                        IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , W_END_DATE                          IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            ) RETURN NUMBER
  AS
    V_WORK_DATE_FR                                DATE;
    V_WORK_DATE_TO                                DATE;
    V_RECORD_COUNT                                NUMBER := 0;
    
  BEGIN
    V_WORK_DATE_FR := W_START_DATE;
    V_WORK_DATE_TO := W_END_DATE;    
    -- 입사일자 체크.
    BEGIN
      SELECT CASE 
               WHEN W_START_DATE < PM.ORI_JOIN_DATE THEN PM.ORI_JOIN_DATE
               ELSE W_START_DATE
             END AS WORK_DATE_FR
           , CASE 
               WHEN PM.RETIRE_DATE IS NULL THEN W_END_DATE
               WHEN PM.RETIRE_DATE < W_END_DATE THEN PM.RETIRE_DATE
               ELSE W_END_DATE
             END AS WORK_DATE_FR
        INTO V_WORK_DATE_FR, V_WORK_DATE_TO     
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID        = W_PERSON_ID
        AND PM.SOB_ID           = W_SOB_ID
        AND PM.ORG_ID           = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;      
    END;
    
    BEGIN
      SELECT COUNT(WC.HOLY_TYPE) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRD_WORK_CALENDAR WC
      WHERE WC.WORK_DATE       >= V_WORK_DATE_FR  
        AND WC.WORK_DATE       <= V_WORK_DATE_TO
        AND WC.PERSON_ID       = W_PERSON_ID
        AND WC.SOB_ID          = W_SOB_ID
        AND WC.ORG_ID          = W_ORG_ID
        AND WC.HOLY_TYPE       = '0'
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;    
    END;
    RETURN V_RECORD_COUNT;
    
  END HOLY_0_COUNT_F;

-- 년월의 시작 및 종료일 조회 LOOK UP.
  PROCEDURE YYYYMM_TERM_F
           ( W_YYYYMM                            IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE
      , W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
      , W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
      , O_START_DATE                        OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
      , O_END_DATE                          OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
      )
  AS
   D_START_DATE                                           DATE := NULL;
  D_END_DATE                                             DATE := NULL;
  
  BEGIN
  BEGIN
    SELECT ADD_MONTHS(TO_DATE(W_YYYYMM || '-' || WT.START_DAY, 'YYYY-MM-DD'), NVL(WT.START_ADD_MONTH, 0)) + NVL(WT.START_ADD_DAY, 0) START_DATE
       , ADD_MONTHS(TO_DATE(W_YYYYMM || '-' || WT.END_DAY, 'YYYY-MM-DD'), NVL(WT.END_ADD_MONTH, 0)) + NVL(WT.END_ADD_DAY, 0) END_DATE
      INTO D_START_DATE, D_END_DATE
     FROM HRM_WORK_TERM_V WT
      , HRM_CLOSING_TYPE_V CT
   WHERE WT.DUTY_TERM_TYPE                = CT.CLOSING_TYPE
    AND WT.SOB_ID                        = CT.SOB_ID
    AND WT.ORG_ID                        = CT.ORG_ID
    AND WT.SOB_ID                        = W_SOB_ID
    AND WT.ORG_ID                        = W_ORG_ID
    AND CT.MODULE_TYPE                   = 'DUTY'
    AND CT.PERIOD_TYPE                   = 'MONTH'
    ; 
  EXCEPTION WHEN OTHERS THEN
    D_START_DATE := TO_DATE(W_YYYYMM || '-01', 'YYYY-MM-DD');
   D_END_DATE := ADD_MONTHS(D_START_DATE, 1) - 1;
  END;
    O_START_DATE := D_START_DATE;
  O_END_DATE := D_END_DATE;
  
  END YYYYMM_TERM_F;   

-- DATA SELECT OPEN TIME / CLOSE TIME.
  PROCEDURE WORK_IO_TIME_F
           ( W_WORK_TYPE                         IN VARCHAR2
            , W_HOLY_TYPE                         IN VARCHAR2
            , W_WORK_DATE                         IN DATE
      , W_SOB_ID                            IN NUMBER
      , W_ORG_ID                            IN NUMBER
      , O_OPEN_TIME                         OUT DATE
      , O_CLOSE_TIME                        OUT DATE
            )
  AS
 BEGIN
   BEGIN
      SELECT  TO_DATE(TO_CHAR(W_WORK_DATE + WIT.I_ADD_DAYS, 'YYYY-MM-DD') ||  ' ' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') AS OPEN_TIME
      , TO_DATE(TO_CHAR(W_WORK_DATE + WIT.O_ADD_DAYS, 'YYYY-MM-DD') ||  ' ' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') AS CLOSE_TIME
        INTO  O_OPEN_TIME, O_CLOSE_TIME
        FROM HRM_WORK_IO_TIME_V WIT
       WHERE WIT.WORK_TYPE        = W_WORK_TYPE
         AND WIT.HOLY_TYPE        = W_HOLY_TYPE
         AND WIT.SOB_ID           = W_SOB_ID
     AND WIT.ORG_ID           = W_ORG_ID
       ;
    
  EXCEPTION WHEN OTHERS THEN
    O_OPEN_TIME := NULL;
   O_CLOSE_TIME := NULL;
  END;
    
  END WORK_IO_TIME_F;
  
-- 년월 조회 LOOK UP.
  PROCEDURE LU_CALENDAR_YYYYMM
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_START_YYYYMM                      IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
      , W_END_YYYYMM                        IN EAPP_CALENDAR_YYYYMM_V.YYYYMM%TYPE DEFAULT NULL
      , W_SOB_ID                            IN HRM_WORK_TERM_V.SOB_ID%TYPE
      , W_ORG_ID                            IN HRM_WORK_TERM_V.ORG_ID%TYPE
      )
  AS
   V_END_YYYYMM                                  VARCHAR2(7);
  
  BEGIN
   V_END_YYYYMM := TO_CHAR(ADD_MONTHS(GET_LOCAL_DATE(W_SOB_ID), 2), 'YYYY-MM');
  
  OPEN P_CURSOR FOR
   SELECT CY.YYYYMM
           , ADD_MONTHS(TO_DATE(CY.YYYYMM || '-' || SX1.START_DAY, 'YYYY-MM-DD'), NVL(SX1.START_ADD_MONTH, 0)) + NVL(SX1.START_ADD_DAY, 0) START_DATE
           , ADD_MONTHS(TO_DATE(CY.YYYYMM || '-' || SX1.END_DAY, 'YYYY-MM-DD'), NVL(SX1.END_ADD_MONTH, 0)) + NVL(SX1.END_ADD_DAY, 0) END_DATE
      FROM EAPP_CALENDAR_YYYYMM_V CY
        , ( SELECT  WT.DUTY_TERM_TYPE
                  , WT.START_DAY
                  , WT.START_ADD_MONTH
                  , WT.START_ADD_DAY
                  , WT.END_DAY
                  , WT.END_ADD_MONTH
                  , WT.END_ADD_DAY
                  , WT.SOB_ID
                  , WT.ORG_ID
              FROM HRM_WORK_TERM_V WT
                , HRM_CLOSING_TYPE_V CT
             WHERE WT.DUTY_TERM_TYPE                = CT.CLOSING_TYPE
               AND WT.SOB_ID                        = CT.SOB_ID
               AND WT.ORG_ID                        = CT.ORG_ID
               AND WT.SOB_ID                        = W_SOB_ID
               AND WT.ORG_ID                        = W_ORG_ID
               AND CT.MODULE_TYPE                   = 'DUTY'
               AND CT.PERIOD_TYPE                   = 'MONTH'
             ) SX1
      WHERE CY.YYYYMM                               BETWEEN NVL(W_START_YYYYMM, CY.YYYYMM) AND NVL(W_END_YYYYMM, V_END_YYYYMM)
      ORDER BY CY.YYYYMM DESC
   ;
   
  END LU_CALENDAR_YYYYMM;
 
---------------------------------------------------------------------------------------------------
-- 근무카렌다 생성 기준 조회.
  -- 기적용일수 조회.
  PROCEDURE CALENDAR_PRE_WORK_DAY_P
	          ( W_WORK_YYYYMM                       IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_DATE_FR                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , W_WORK_DATE_TO                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
						, W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
						, W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD                    IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
						, W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
  					, W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            , O_DAY_COUNT                         OUT NUMBER
						)
  AS
  BEGIN
      BEGIN
        SELECT WCS.DAY_COUNT
          INTO O_DAY_COUNT
          FROM HRD_WORK_CALENDAR_SET WCS
        WHERE WCS.CORP_ID                 = W_CORP_ID            
          AND WCS.WORK_PERIOD             = W_WORK_YYYYMM
          AND WCS.WORK_TYPE_ID            = W_WORK_TYPE_ID
          AND WCS.WORK_DATE_FR            = W_WORK_DATE_FR
          AND WCS.WORK_DATE_TO            = W_WORK_DATE_TO
          AND WCS.CREATED_METHOD          = W_CREATED_METHOD
          AND WCS.HOLY_TYPE               = -1
          AND WCS.SOB_ID                  = W_SOB_ID
          AND WCS.ORG_ID                  = W_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_DAY_COUNT := 0;
      END;
  END CALENDAR_PRE_WORK_DAY_P;
  
    -- 근무카렌다 기적용일수 저장.
  PROCEDURE SAVE_PRE_WORK_DAY
	          ( P_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , P_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , P_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , P_DAY_COUNT      IN HRD_WORK_CALENDAR_SET.DAY_COUNT%TYPE
            , P_WORK_DATE_FR   IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , P_WORK_DATE_TO   IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
            , P_DESCRIPTION    IN HRD_WORK_CALENDAR_SET.DESCRIPTION%TYPE
            , P_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , P_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
            , P_USER_ID        IN HRD_WORK_CALENDAR_SET.CREATED_BY%TYPE 
						)
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
  BEGIN
    MERGE INTO HRD_WORK_CALENDAR_SET HWC
    USING ( SELECT P_CORP_ID        AS CORP_ID
                , P_WORK_PERIOD     AS WORK_PERIOD
                , P_WORK_TYPE_ID    AS WORK_TYPE_ID
                , P_WORK_DATE_FR    AS WORK_DATE_FR
                , P_WORK_DATE_TO    AS WORK_DATE_TO
                , P_CREATED_METHOD  AS CREATED_METHOD
                , P_SOB_ID          AS SOB_ID
                , P_ORG_ID          AS ORG_ID
              FROM DUAL
          ) SX1
    ON    ( HWC.CORP_ID             = SX1.CORP_ID
      AND   HWC.WORK_PERIOD         = SX1.WORK_PERIOD
      AND   HWC.WORK_TYPE_ID        = SX1.WORK_TYPE_ID
      AND   HWC.WORK_DATE_FR        = SX1.WORK_DATE_FR
      AND   HWC.WORK_DATE_TO        = SX1.WORK_DATE_TO
      AND   HWC.CREATED_METHOD      = SX1.CREATED_METHOD
      AND   HWC.HOLY_TYPE           = -1
      AND   HWC.SOB_ID              = SX1.SOB_ID
      AND   HWC.ORG_ID              = SX1.ORG_ID
          )
    WHEN MATCHED THEN
      UPDATE
        SET HWC.DAY_COUNT           = NVL(P_DAY_COUNT, 0)
          , HWC.LAST_UPDATE_DATE    = SYSDATE
          , HWC.LAST_UPDATED_BY     = P_USER_ID
    WHEN NOT MATCHED THEN
      INSERT 
      ( CORP_ID
      , WORK_PERIOD 
      , WORK_TYPE_ID 
      , CREATED_METHOD 
      , SEQ 
      , HOLY_TYPE 
      , DAY_COUNT 
      , WORK_DATE_FR 
      , WORK_DATE_TO 
      , DESCRIPTION 
      , SOB_ID 
      , ORG_ID 
      , CREATION_DATE 
      , CREATED_BY 
      , LAST_UPDATE_DATE 
      , LAST_UPDATED_BY )
      VALUES
      ( P_CORP_ID
      , P_WORK_PERIOD
      , P_WORK_TYPE_ID
      , P_CREATED_METHOD
      , 0  -- SAVE_SEQ.
      , -1 -- HOLY_TYPE.
      , NVL(P_DAY_COUNT, 0)
      , P_WORK_DATE_FR
      , P_WORK_DATE_TO
      , P_DESCRIPTION
      , P_SOB_ID
      , P_ORG_ID
      , V_SYSDATE
      , P_USER_ID
      , V_SYSDATE
      , P_USER_ID )
    ;
  END SAVE_PRE_WORK_DAY;
  
  -- 근무계획 생성 기준.
  PROCEDURE SELECT_CALENDAR_SET
           ( P_CURSOR2                           OUT TYPES.TCURSOR2
           , W_WORK_YYYYMM                       IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO                      IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_CORP_ID                           IN HRM_PERSON_MASTER.CORP_ID%TYPE
           , W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD                    IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
           , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
           )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT WCS.SEQ
           , WCS.HOLY_TYPE
           , CASE
               WHEN WCS.HOLY_TYPE = -1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10166', NULL)
               ELSE HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WCS.HOLY_TYPE, WCS.SOB_ID, WCS.ORG_ID)
             END AS HOLY_TYPE_NAME
           , WCS.DAY_COUNT
        FROM HRD_WORK_CALENDAR_SET WCS
      WHERE WCS.CORP_ID                 = W_CORP_ID            
        AND WCS.WORK_PERIOD             = W_WORK_YYYYMM
        AND WCS.WORK_TYPE_ID            = W_WORK_TYPE_ID
        AND WCS.WORK_DATE_FR            = W_WORK_DATE_FR
        AND WCS.WORK_DATE_TO            = W_WORK_DATE_TO
        AND WCS.CREATED_METHOD          = W_CREATED_METHOD
        AND WCS.SOB_ID                  = W_SOB_ID
        AND WCS.ORG_ID                  = W_ORG_ID
        AND WCS.HOLY_TYPE               <> -1
      ORDER BY WCS.SEQ  
      ;
        
  END SELECT_CALENDAR_SET;

-- 근무카렌다 생성 기준 삽입 자료 조회..
  PROCEDURE SELECT_CALENDAR_SET_INSERT
            ( P_CURSOR2                           OUT TYPES.TCURSOR2
            , W_WORK_YYYYMM                       IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_TYPE_GROUP                   IN VARCHAR2
            , W_SOB_ID                            IN HRM_PERSON_MASTER.SOB_ID%TYPE
            , W_ORG_ID                            IN HRM_PERSON_MASTER.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR2 FOR
      SELECT NULL AS SEQ
           , WPS.HOLY_TYPE
           , CASE
               WHEN WPS.HOLY_TYPE = -1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10166', NULL)
               ELSE HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WPS.HOLY_TYPE, WPS.SOB_ID, WPS.ORG_ID)
             END AS HOLY_TYPE_NAME               
           , WPS.DAY_COUNT
        FROM HRM_WORK_PLAN_STD_V WPS
      WHERE WPS.WORK_TYPE_GROUP         = W_WORK_TYPE_GROUP
        AND WPS.SOB_ID                  = W_SOB_ID
        AND WPS.ORG_ID                  = W_ORG_ID
        AND WPS.ENABLED_FLAG            = 'Y'
        AND WPS.EFFECTIVE_DATE_FR       <= LAST_DAY(TO_DATE(W_WORK_YYYYMM, 'YYYY-MM'))
        AND (WPS.EFFECTIVE_DATE_TO IS NULL OR WPS.EFFECTIVE_DATE_TO >= TRUNC(TO_DATE(W_WORK_YYYYMM, 'YYYY-MM')))
      ORDER BY WPS.SORT_NUM
      ;
        
  END SELECT_CALENDAR_SET_INSERT;
  
-- 근무카렌다 생성 기준 삽입.
  PROCEDURE INSERT_CALENDAR_SET
           ( P_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , P_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , P_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , P_SEQ            OUT HRD_WORK_CALENDAR_SET.SEQ%TYPE
            , P_HOLY_TYPE      IN HRD_WORK_CALENDAR_SET.HOLY_TYPE%TYPE
            , P_DAY_COUNT      IN HRD_WORK_CALENDAR_SET.DAY_COUNT%TYPE
            , P_WORK_DATE_FR   IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , P_WORK_DATE_TO   IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
            , P_DESCRIPTION    IN HRD_WORK_CALENDAR_SET.DESCRIPTION%TYPE
            , P_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , P_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
            , P_USER_ID        IN HRD_WORK_CALENDAR_SET.CREATED_BY%TYPE 
      )
  AS
    V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);
    
  BEGIN
    BEGIN
      SELECT NVL(MAX(WCS.SEQ), 0) + 1 AS NEXT_SEQ
        INTO P_SEQ
        FROM HRD_WORK_CALENDAR_SET WCS
      WHERE WCS.CORP_ID           = P_CORP_ID
        AND WCS.WORK_PERIOD       = P_WORK_PERIOD
        AND WCS.WORK_TYPE_ID      = P_WORK_TYPE_ID
        AND WCS.CREATED_METHOD    = P_CREATED_METHOD
        AND WORK_DATE_FR          = P_WORK_DATE_FR
        AND WORK_DATE_TO          = P_WORK_DATE_TO
        AND WCS.SOB_ID            = P_SOB_ID
        AND WCS.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      P_SEQ := 1;
    END;
        
    INSERT INTO HRD_WORK_CALENDAR_SET
    ( CORP_ID
    , WORK_PERIOD 
    , WORK_TYPE_ID 
    , CREATED_METHOD 
    , SEQ 
    , HOLY_TYPE 
    , DAY_COUNT 
    , WORK_DATE_FR 
    , WORK_DATE_TO 
    , DESCRIPTION 
    , SOB_ID 
    , ORG_ID 
    , CREATION_DATE 
    , CREATED_BY 
    , LAST_UPDATE_DATE 
    , LAST_UPDATED_BY )
    VALUES
    ( P_CORP_ID
    , P_WORK_PERIOD
    , P_WORK_TYPE_ID
    , P_CREATED_METHOD
    , P_SEQ
    , P_HOLY_TYPE
    , P_DAY_COUNT
    , P_WORK_DATE_FR
    , P_WORK_DATE_TO
    , P_DESCRIPTION
    , P_SOB_ID
    , P_ORG_ID
    , V_SYSDATE
    , P_USER_ID
    , V_SYSDATE
    , P_USER_ID );
    
  END INSERT_CALENDAR_SET;

-- 근무카렌다 생성 기준 삭제.
  PROCEDURE DELETE_CALENDAR_SET
           ( W_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , W_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , W_SEQ            IN HRD_WORK_CALENDAR_SET.SEQ%TYPE
            , W_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , W_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
      )
  AS
  BEGIN
    DELETE FROM HRD_WORK_CALENDAR_SET
      WHERE CORP_ID          = W_CORP_ID
        AND WORK_PERIOD      = W_WORK_PERIOD
        AND WORK_TYPE_ID     = W_WORK_TYPE_ID
        AND CREATED_METHOD   = W_CREATED_METHOD
        AND SEQ              = W_SEQ
        AND SOB_ID           = W_SOB_ID
        AND ORG_ID           = W_ORG_ID;
  END DELETE_CALENDAR_SET;

-- 근무카렌다 생성 기준 삭제 - 해당 생성 방법에 대해 적용 기간.
  PROCEDURE DELETE_CALENDAR_SET_ALL
            ( W_CORP_ID        IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , W_WORK_PERIOD    IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , W_WORK_DATE_FR   IN HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
            , W_WORK_DATE_TO   IN HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
            , W_WORK_TYPE_ID   IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , W_CREATED_METHOD IN HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
            , W_SOB_ID         IN HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
            , W_ORG_ID         IN HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
      )
  AS
  BEGIN
    DELETE FROM HRD_WORK_CALENDAR_SET
    WHERE CORP_ID          = W_CORP_ID
      AND WORK_PERIOD      = W_WORK_PERIOD
      AND WORK_DATE_FR     = W_WORK_DATE_FR
      AND WORK_DATE_TO     = W_WORK_DATE_TO
      AND WORK_TYPE_ID     = W_WORK_TYPE_ID
      AND CREATED_METHOD   = W_CREATED_METHOD
      AND SOB_ID           = W_SOB_ID
      AND ORG_ID           = W_ORG_ID
    ;
  END DELETE_CALENDAR_SET_ALL;
  
-- Work Calendar Create.
  PROCEDURE  WORKCAL_SET
            ( P_CORP_ID                          IN HRD_WORK_CALENDAR.CORP_ID%TYPE
       , P_PERSON_ID                        IN HRD_WORK_CALENDAR.PERSON_ID%TYPE
       , P_DEPT_ID                          IN HRM_DEPT_MASTER.DEPT_ID%TYPE
       , P_WORK_TYPE_ID                     IN HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE
       , P_START_DATE                       IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
       , P_END_DATE                         IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
       , P_PRE_DAY_COUNT                    IN NUMBER
       , P_HOLY_TYPE1                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
       , P_HOLY_COUNT1                      IN NUMBER
       , P_HOLY_TYPE2                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
       , P_HOLY_COUNT2                      IN NUMBER
       , P_HOLY_TYPE3                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
       , P_HOLY_COUNT3                      IN NUMBER
       , P_HOLY_TYPE4                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
       , P_HOLY_COUNT4                      IN NUMBER
       , P_HOLY_TYPE5                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
       , P_HOLY_COUNT5                      IN NUMBER
       , P_HOLY_TYPE6                       IN HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
       , P_HOLY_COUNT6                      IN NUMBER
       , P_USER_ID                          IN HRD_WORK_CALENDAR.CREATED_BY%TYPE
       , P_SOB_ID                           IN HRD_WORK_CALENDAR.SOB_ID%TYPE
       , P_ORG_ID                           IN HRD_WORK_CALENDAR.ORG_ID%TYPE
       , O_MESSAGE                          OUT VARCHAR2
       )
  AS
  /*--////////////////////////////////////////////////////////////--
  -- 조회 조건에 맞는 데이터 검색 ==> 커서
  --////////////////////////////////////////////////////////////--*/
  CURSOR WORKCAL_REC  IS
   SELECT PM.PERSON_ID
           , PM.WORK_TYPE_ID
      , HC.VALUE1 WORK_TYPE
           , PM.ORI_JOIN_DATE
           , PM.RETIRE_DATE
           , PM.CORP_ID
           , PM.WORK_CORP_ID
      , PM.SOB_ID
      , PM.ORG_ID
        FROM HRM_PERSON_MASTER PM
      , HRM_COMMON HC
       WHERE PM.WORK_TYPE_ID                      = HC.COMMON_ID
      AND PM.WORK_CORP_ID                      = P_CORP_ID
      AND PM.PERSON_ID                         = NVL(P_PERSON_ID, PM.PERSON_ID)
         AND PM.DEPT_ID                           = NVL(P_DEPT_ID, PM.DEPT_ID)
     AND PM.SOB_ID                            = P_SOB_ID
     AND PM.ORG_ID                            = P_ORG_ID
         AND PM.WORK_TYPE_ID                      = P_WORK_TYPE_ID
         AND PM.ORI_JOIN_DATE                     <= P_END_DATE 
         AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= P_START_DATE)
   ;      
    
  V_MESSAGE                                       VARCHAR2(300);
  D_SYSDATE                                       DATE;
  D_START_DATE                                    DATE;
  R_HOLY_TYPE                                     VARCHAR2(2);
  N1                                              NUMBER;

  BEGIN
   D_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
  D_START_DATE := P_START_DATE - P_PRE_DAY_COUNT;
  
  BEGIN
   -- 기존 자료 삭제.
   DELETE FROM HRD_WORK_CALENDAR WC
   WHERE WC.WORK_DATE                            BETWEEN P_START_DATE AND P_END_DATE
     AND EXISTS (SELECT 'X'
                     FROM HRM_PERSON_MASTER PM
           WHERE PM.WORK_CORP_ID          = WC.WORK_CORP_ID
             AND PM.PERSON_ID             = WC.PERSON_ID
            AND PM.SOB_ID                = WC.SOB_ID
            AND PM.ORG_ID                = WC.ORG_ID
            AND PM.WORK_CORP_ID          = P_CORP_ID
            AND PM.PERSON_ID             = NVL(P_PERSON_ID, PM.PERSON_ID)
            AND PM.DEPT_ID               = NVL(P_DEPT_ID, PM.DEPT_ID)
            AND PM.WORK_TYPE_ID          = NVL(P_WORK_TYPE_ID, PM.WORK_TYPE_ID)
            AND PM.ORI_JOIN_DATE         <= P_END_DATE
            AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= P_START_DATE)
            AND PM.SOB_ID                = P_SOB_ID
            AND PM.ORG_ID                = P_ORG_ID)
      ;
  END;
    
--////////////////////////////////////////////////////////////--
-- FOR LOOP 실행 : 조회된 인원수 만큼 --
--////////////////////////////////////////////////////////////--
  FOR C1  IN WORKCAL_REC
  LOOP
--DBMS_OUTPUT.PUT_LINE('작업시작=>IN_PERSON_NUMB' || WORKCAL_CUR.PERSON_NUMB || '//' || WORKCAL_CUR.WORK_TYPE);
      /*--> 임시테이블 DATA 삭제 <--*/
   DELETE FROM HRD_WORK_DATE_GT;
      
      -- 월 달력 생성.
   BEGIN
    N1 := P_END_DATE - D_START_DATE + 1; 
    FOR R1 IN 0 .. N1 - 1
    LOOP
     INSERT INTO HRD_WORK_DATE_GT
     (WORK_DATE, PERSON_ID, WORK_CORP_ID, CORP_ID, WORK_YYYYMM, WORK_WEEK
          , HOLIDAY_CHECK
          , WORK_TYPE_ID, WORK_TYPE
     , DUTY_CODE, HOLY_TYPE
     , SOB_ID, ORG_ID)
     VALUES
     (D_START_DATE + R1
     , C1.PERSON_ID, C1.WORK_CORP_ID, C1.CORP_ID
     , TO_CHAR(P_END_DATE, 'YYYY-MM')
     , TO_CHAR(D_START_DATE + R1, 'D')
     , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_CHECK(D_START_DATE + R1 , P_SOB_ID, P_ORG_ID)  
     , C1.WORK_TYPE_ID, C1.WORK_TYPE
     , 1168, '2'
     , P_SOB_ID, P_ORG_ID)
     ;
    END LOOP C1;
   END;
  
/*------------------------------------------------------------------------------------------------*
+++++    교대유형에 따른 근무/근태 값 생성
*------------------------------------------------------------------------------------------------*/
   IF C1.WORK_TYPE IN('11') THEN
   -- 무교대(월력 따라감)
     FOR R1 IN ( SELECT WD.WORK_DATE, WD.PERSON_ID, WD.CORP_ID
                      , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.HOLIDAY_CHECK
                      , WD.WORK_TYPE_ID, WD.WORK_TYPE
             , WD.DUTY_ID, WD.HOLY_TYPE
             , WD.SOB_ID, WD.ORG_ID 
                  FROM HRD_WORK_DATE_GT WD
           WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND P_END_DATE
             AND WD.PERSON_ID      = C1.PERSON_ID
            AND WD.SOB_ID         = C1.SOB_ID
            AND WD.ORG_ID         = C1.ORG_ID)
    LOOP
     UPDATE HRD_WORK_DATE_GT WD
      SET (WD.DUTY_ID, WD.HOLY_TYPE)
        = (SELECT DC.DUTY_ID
             , CASE
              WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
              WHEN WD.WORK_WEEK IN('1') THEN '1'             -- 일요일 - 유휴일.
              WHEN WD.WORK_WEEK IN('7') THEN '0'             -- 토요일 - 무휴일.
              ELSE '2'                                       -- 정상근무.
             END AS HOLY_TYPE
           FROM HRM_DUTY_CODE_V DC
          WHERE DC.SOB_ID           = WD.SOB_ID
            AND DC.ORG_ID           = WD.ORG_ID
            AND DC.DUTY_CODE        = CASE 
                                        WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'    -- 공휴일 - 휴일.
                                     WHEN WD.WORK_WEEK     IN('1')      THEN '51'    -- 일요일 - 휴일.
                         WHEN WD.WORK_WEEK     IN('7')      THEN '52'    -- 토요일 - 휴일.
                         ELSE '00'                                       -- 평일.
                                      END)
      WHERE WD.WORK_DATE                  = R1.WORK_DATE;
    END LOOP  R1;

-------------------------------------------------------------------------------
   ELSE
   -- Manual입력(2조2교대 OR 3조2교대) --
     -- 변수 초기화.
    N1 := 1;
    R_HOLY_TYPE := NULL;
    
    FOR R1 IN ( SELECT WD.WORK_DATE, WD.PERSON_ID, WD.CORP_ID
                      , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.HOLIDAY_CHECK
                      , WD.WORK_TYPE_ID, WD.WORK_TYPE
             , WD.DUTY_ID, WD.HOLY_TYPE
             , WD.SOB_ID, WD.ORG_ID 
                  FROM HRD_WORK_DATE_GT WD
           WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND P_END_DATE
             AND WD.PERSON_ID      = C1.PERSON_ID
            AND WD.SOB_ID         = C1.SOB_ID
            AND WD.ORG_ID         = C1.ORG_ID)
    LOOP
      --- 근무일수에 따른 근무유형 설정 --
     IF N1 <= P_HOLY_COUNT1 THEN
     -- 순서1
       R_HOLY_TYPE := P_HOLY_TYPE1;
      N1 := N1 + 1;
      
     ELSIF N1 > P_HOLY_COUNT1 AND N1 <= P_HOLY_COUNT1 + P_HOLY_COUNT2 THEN
     -- 순서2 
       R_HOLY_TYPE := P_HOLY_TYPE2;
      N1 := N1 + 1;
      
     ELSIF N1 > P_HOLY_COUNT1 + P_HOLY_COUNT2 AND N1 <=  P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 THEN
     -- 순서3
       R_HOLY_TYPE := P_HOLY_TYPE3;
      N1 := N1 + 1;

     ELSIF N1 > P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 
       AND N1 <=  P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 + P_HOLY_COUNT4 THEN
     -- 순서4
       R_HOLY_TYPE := P_HOLY_TYPE4;
      N1 := N1 + 1;

     ELSIF N1 > P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 + P_HOLY_COUNT4 
       AND N1 <= P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 + P_HOLY_COUNT4 + P_HOLY_COUNT5 THEN
     -- 순서5
            R_HOLY_TYPE := P_HOLY_TYPE5;
      N1 := N1 + 1;
      
     ELSIF N1 > P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 + P_HOLY_COUNT4 + P_HOLY_COUNT5 
       AND N1 <= P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 + P_HOLY_COUNT4 + P_HOLY_COUNT5 + P_HOLY_COUNT6  THEN
     -- 순서6
       R_HOLY_TYPE := P_HOLY_TYPE6;
      N1 := N1 + 1;

     END IF;

     /*-- 최대값에 따른 초기화  --*/
     IF P_HOLY_COUNT1 + P_HOLY_COUNT2 + P_HOLY_COUNT3 + P_HOLY_COUNT4 + P_HOLY_COUNT5 + P_HOLY_COUNT6 + 1 = N1 THEN
       N1 := 1;
     END IF;

     /*-- 근무구분 반영  --*/
     UPDATE HRD_WORK_DATE_GT WD
      SET (WD.DUTY_ID, WD.HOLY_TYPE)
        = (SELECT DC.DUTY_ID
             , CASE
              WHEN WD.WORK_TYPE IN('22') THEN               -- 2조 2교대 : 월력 .
               CASE
                WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                ELSE R_HOLY_TYPE
               END
              ELSE                                          -- 3조 2교대 : 월력 .
               CASE
                WHEN WD.HOLIDAY_CHECK IN('A') THEN '1'      -- 공휴일 - 유휴일.
                ELSE R_HOLY_TYPE
               END
             END AS HOLY_TYPE
           FROM HRM_DUTY_CODE_V DC
          WHERE DC.SOB_ID           = WD.SOB_ID
            AND DC.ORG_ID           = WD.ORG_ID
            AND DC.DUTY_CODE        = CASE
                         WHEN WD.WORK_TYPE IN('22') THEN  -- 2조 2교대 : 월력 .
                          CASE
                          --WHEN HWG2.WEEK_TYPE IN('1', '7') THEN '53'
                           WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'  -- 유휴일.
                           WHEN R_HOLY_TYPE = '1' THEN '51'   -- 유휴일.
                           WHEN R_HOLY_TYPE = '0' THEN '52'
                           ELSE '00'
                          END
                         ELSE                                          /*--< 3조 2교대 : 월력 > --*/
                          CASE
                           WHEN WD.HOLIDAY_CHECK IN('A') THEN '51'  -- 유휴일.
                           WHEN R_HOLY_TYPE = '1' THEN '51'   -- 유휴일.
                           WHEN R_HOLY_TYPE = '0' THEN '52'   -- 무휴.
                           ELSE '00'
                          END
                        END)
      WHERE WD.WORK_DATE                 = R1.WORK_DATE;
--DBMS_OUTPUT.PUT_LINE('작업시작=>IN_PERSON_NUMB' || WORKCAL_CUR.PERSON_NUMB || '//' || TO_CHAR(R1.CAL_DATE, 'YYYY-MM-DD'));
    END LOOP  R1;

   END IF;
-------------------------------------------------------------------------------

   /*=========================================================================================/
     --> OPEN 시간 CLOSE 시간 설정
   /=========================================================================================*/
   UPDATE HRD_WORK_DATE_GT WD
      SET (WD.OPEN_TIME, WD.CLOSE_TIME)
         = 
       (SELECT TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') + WIT.I_ADD_DAYS AS OPEN_TIME
             , TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') + WIT.O_ADD_DAYS AS OPEN_TIME
          FROM HRM_WORK_IO_TIME_V WIT
        WHERE WIT.WORK_TYPE      = WD.WORK_TYPE 
          AND WIT.HOLY_TYPE      = WD.HOLY_TYPE
                 AND WIT.ENABLED_FLAG   = 'Y'
                 AND WIT.EFFECTIVE_DATE_FR <=WD.WORK_DATE
                 AND (WIT.EFFECTIVE_DATE_TO IS NULL OR WIT.EFFECTIVE_DATE_TO >= WD.WORK_DATE)
         AND WIT.SOB_ID         = WD.SOB_ID
         AND WIT.ORG_ID         = WD.ORG_ID
       )
     WHERE WD.WORK_DATE               BETWEEN P_START_DATE AND P_END_DATE
      AND WD.SOB_ID                  = P_SOB_ID
     AND WD.ORG_ID                  = P_ORG_ID
    ;
   

   /*=========================================================================================/
    --> 일괄 INSERT 실시
   /=========================================================================================*/
   INSERT INTO HRD_WORK_CALENDAR
   (WORK_DATE, PERSON_ID, WORK_CORP_ID, CORP_ID
    , WORK_YYYYMM, WORK_WEEK, WORK_TYPE_ID
   , DUTY_ID, HOLY_TYPE, OPEN_TIME, CLOSE_TIME
   , ATTRIBUTE5
   , SOB_ID, ORG_ID
   , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY)
   (SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
      , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.WORK_TYPE_ID
      , WD.DUTY_ID, WD.HOLY_TYPE, WD.OPEN_TIME, WD.CLOSE_TIME
      , WD.WORK_TYPE AS ATTRIBUTE5
      , WD.SOB_ID, WD.ORG_ID
      , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
     FROM HRD_WORK_DATE_GT WD
    WHERE WD.WORK_DATE        BETWEEN P_START_DATE AND P_END_DATE
      AND WD.SOB_ID           = P_SOB_ID
     AND WD.ORG_ID           = P_ORG_ID
   );
   /*--> 임시테이블 DATA 삭제 <--*/
   DELETE FROM HRD_WORK_DATE_GT;
      
    END LOOP C1;
  COMMIT;

    /*===========================================================/
    --> 연장근무  승인 적용
  /===========================================================*/
  << OT_UPDATE_START >>
  FOR R1 IN ( SELECT OH.CORP_ID
           , OH.SOB_ID
           , OH.ORG_ID
           , OL.PERSON_ID
           , OL.WORK_DATE
           , OL.BEFORE_OT_START
           , OL.BEFORE_OT_END
           , OL.AFTER_OT_START
           , OL.AFTER_OT_END
           , OL.BREAKFAST_YN
           , OL.LUNCH_YN
           , OL.DINNER_YN
           , OL.MIDNIGHT_YN
           , OL.DANGJIK_YN
           , OL.ALL_NIGHT_YN
           , GET_LOCAL_DATE(OH.SOB_ID)
           , P_USER_ID
         FROM HRD_OT_HEADER OH
          , HRD_OT_LINE OL
          , HRM_PERSON_MASTER PM
         WHERE OH.REQ_NUM           = OL.REQ_NUM
          AND OH.SOB_ID             = PM.SOB_ID
          AND OH.ORG_ID             = PM.ORG_ID
          AND OL.PERSON_ID          = PM.PERSON_ID
          AND OL.WORK_DATE          BETWEEN P_START_DATE AND P_END_DATE
          AND OL.PERSON_ID          = NVL(P_PERSON_ID, OL.PERSON_ID)
          AND OH.CORP_ID            = P_CORP_ID
          AND OH.SOB_ID             = P_SOB_ID
          AND OH.ORG_ID             = P_ORG_ID
          AND PM.DEPT_ID            = NVL(P_DEPT_ID, PM.DEPT_ID)
          AND PM.WORK_TYPE_ID       = NVL(P_WORK_TYPE_ID, PM.WORK_TYPE_ID)
          AND OH.APPROVE_STATUS     = 'C'
         ORDER BY OH.APPROVED_DATE
       )
  LOOP 
   BEGIN
    UPDATE HRD_WORK_CALENDAR WC
      SET WC.BEFORE_OT_START          = R1.BEFORE_OT_START
       , WC.BEFORE_OT_END            = R1.BEFORE_OT_END
       , WC.AFTER_OT_START           = R1.AFTER_OT_START
       , WC.AFTER_OT_END             = R1.AFTER_OT_END
       , WC.BREAKFAST_YN             = R1.BREAKFAST_YN
       , WC.LUNCH_YN                 = R1.LUNCH_YN
       , WC.DINNER_YN                = R1.DINNER_YN
       , WC.MIDNIGHT_YN              = R1.MIDNIGHT_YN
       , WC.DANGJIK_YN               = R1.DANGJIK_YN
       , WC.ALL_NIGHT_YN             = R1.ALL_NIGHT_YN
       , WC.LAST_UPDATE_DATE         = GET_LOCAL_DATE(WC.SOB_ID)
       , WC.LAST_UPDATED_BY          = P_USER_ID
    WHERE WC.WORK_DATE                 = R1.WORK_DATE
     AND WC.PERSON_ID                 = R1.PERSON_ID
     AND WC.SOB_ID                    = R1.SOB_ID
     AND WC.ORG_ID                    = R1.ORG_ID
    ;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('OT_UPDATE_ERROR=>' || SUBSTR(SQLERRM, 1, 200));
   END;
  END LOOP R1;
    << OT_UPDATE_COMPLETE >>
  
  /*===========================================================/
    --> 고정근태 승인 적용
  /===========================================================*/
  << DUTY_PERIOD_UPDATE_START >>
  FOR R1 IN ( SELECT DP.CORP_ID
           , DP.SOB_ID
           , DP.ORG_ID
           , DP.PERSON_ID
           , DP.DUTY_ID
           , DP.WORK_START_DATE
           , DP.WORK_END_DATE
           , DP.REAL_START_DATE
           , DP.REAL_END_DATE
         FROM HRD_DUTY_PERIOD DP
          , HRM_PERSON_MASTER PM
         WHERE DP.PERSON_ID                 = PM.PERSON_ID
          AND DP.CORP_ID                   = PM.CORP_ID
          AND DP.SOB_ID                    = PM.SOB_ID
          AND DP.ORG_ID                    = PM.ORG_ID
          AND (DP.WORK_START_DATE           <= P_END_DATE
           OR DP.WORK_END_DATE             >= P_START_DATE)
          AND DP.CORP_ID                   = P_CORP_ID
          AND DP.SOB_ID                    = P_SOB_ID
          AND DP.ORG_ID                    = P_ORG_ID
          AND DP.APPROVE_STATUS            = 'C'
        ORDER BY DP.APPROVED_DATE    
       )
  LOOP 
   BEGIN
    UPDATE HRD_WORK_CALENDAR WC
      SET WC.C_DUTY_ID               = CASE
                                              WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                              ELSE DECODE(WC.C_DUTY_ID, NULL, R1.DUTY_ID, WC.C_DUTY_ID)
                                            END
             , WC.C_DUTY_ID1              = CASE
                                              WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                              ELSE DECODE(WC.C_DUTY_ID, NULL, NULL, R1.DUTY_ID)
                                            END
             , WC.OPEN_TIME               = CASE
                                              WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                              ELSE DECODE(WC.WORK_DATE, R1.WORK_START_DATE, R1.REAL_START_DATE, NULL)
                                            END
             , WC.CLOSE_TIME              = CASE
                                              WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                              ELSE DECODE(WC.WORK_DATE, R1.WORK_END_DATE, R1.REAL_END_DATE, NULL)
                                            END
             , WC.OLD_OPEN_TIME           = CASE
                                              WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                              ELSE WC.OPEN_TIME
                                            END
             , WC.OLD_CLOSE_TIME          = CASE
                                              WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                              ELSE WC.CLOSE_TIME
                                            END
       , WC.LAST_UPDATE_DATE        = GET_LOCAL_DATE(WC.SOB_ID)
       , WC.LAST_UPDATED_BY         = P_USER_ID
    WHERE WC.WORK_DATE                BETWEEN R1.WORK_START_DATE AND R1.WORK_END_DATE
     AND WC.PERSON_ID                = R1.PERSON_ID
     AND WC.SOB_ID                   = R1.SOB_ID
     AND WC.ORG_ID                   = R1.ORG_ID
    ;
   EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('PERIOD_UPDATE_ERROR=>' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 200));
   END;
  END LOOP R1;
    << DUTY_PERIOD_UPDATE_COMPLETE >>

    V_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10167', NULL);
  O_MESSAGE := V_MESSAGE;
  EXCEPTION WHEN OTHERS THEN
    V_MESSAGE := 'ERROR=>' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 200);
  O_MESSAGE := V_MESSAGE;
 END WORKCAL_SET;


-- Table을 이용한 Work Calendar Create.
  PROCEDURE  WORKCAL_SET_TABLE
            ( P_CORP_ID                          IN HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
            , P_WORK_PERIOD                      IN HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_PERSON_ID                        IN HRD_WORK_CALENDAR.PERSON_ID%TYPE
            , P_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID                     IN HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
            , P_WORK_DATE_FR                     IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_WORK_DATE_TO                     IN HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_CREATE_TYPE                      IN VARCHAR2 DEFAULT NULL                     -- 전호수 추가(신규입사시 사용).
            , P_USER_ID                          IN HRD_WORK_CALENDAR.CREATED_BY%TYPE
            , P_SOB_ID                           IN HRD_WORK_CALENDAR.SOB_ID%TYPE
            , P_ORG_ID                           IN HRD_WORK_CALENDAR.ORG_ID%TYPE
            , O_STATUS                           OUT VARCHAR2
            , O_MESSAGE                          OUT VARCHAR2
            )

  AS
    /*--////////////////////////////////////////////////////////////--
  -- 조회 조건에 맞는 데이터 검색 ==> 커서
  --////////////////////////////////////////////////////////////--*/
  CURSOR WORKCAL_REC IS
    SELECT PM.PERSON_ID
        , PM.PERSON_NUM
        , PM.WORK_TYPE_ID
        , HC.VALUE1 WORK_TYPE
        , PM.JOIN_DATE
        , PM.RETIRE_DATE
        , PM.WORK_CORP_ID
        --, PM.WORK_CORP_ID AS CORP_ID --< [2011-06-25]수정
        , PM.CORP_ID
        , PM.SOB_ID
        , PM.ORG_ID
      FROM HRM_PERSON_MASTER PM
        , HRM_COMMON HC
    WHERE PM.WORK_TYPE_ID                      = HC.COMMON_ID
      AND PM.WORK_CORP_ID                      = P_CORP_ID
      AND PM.PERSON_ID                         = NVL(P_PERSON_ID, PM.PERSON_ID)
      AND PM.FLOOR_ID                          = NVL(P_FLOOR_ID, PM.FLOOR_ID)
      AND PM.SOB_ID                            = P_SOB_ID
      AND PM.ORG_ID                            = P_ORG_ID
      AND PM.WORK_TYPE_ID                      = P_WORK_TYPE_ID
      AND PM.JOIN_DATE                         <= P_WORK_DATE_TO
      AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= P_WORK_DATE_FR)
   ;

    D_SYSDATE                                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_CREATED_METHOD                                HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE;
    V_PRE_DAY_COUNT                                 NUMBER := 0;         -- 기적용 일수.
    V_DAY_COUNT                                     NUMBER := 0;         -- 적용 일수.    
    D_START_DATE                                    DATE;
    D_END_DATE                                      DATE;
    V_ATTEND_FLAG                                   VARCHAR2(20) := 'N';

    N1                                              NUMBER;
    V_LOOP_COUNT                                    NUMBER;
        
    V_PRE_HOLY_TYPE      VARCHAR2(2);
  BEGIN
    O_STATUS := 'F';
    IF P_PERSON_ID IS NOT NULL THEN
      V_CREATED_METHOD := 'P';
    ELSIF P_FLOOR_ID IS NOT NULL THEN
      V_CREATED_METHOD := 'D';
    ELSE
      V_CREATED_METHOD := 'A';
    END IF;
    IF P_CREATE_TYPE = 'INSA' THEN
      V_CREATED_METHOD := 'A';
    END IF;
    
    -- 기적용일수 조회.
    BEGIN
      SELECT NVL(MAX(WCS.DAY_COUNT), 0) AS DAY_COUNT
        INTO V_PRE_DAY_COUNT
        FROM HRD_WORK_CALENDAR_SET WCS
       WHERE WCS.CORP_ID          = P_CORP_ID
         AND WCS.WORK_PERIOD      = P_WORK_PERIOD
         AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
         AND WCS.CREATED_METHOD   = V_CREATED_METHOD
         AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
         AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
         AND WCS.HOLY_TYPE        = -1
         AND WCS.SOB_ID           = P_SOB_ID
         AND WCS.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PRE_DAY_COUNT := 0;
    END;

--////////////////////////////////////////////////////////////--
-- FOR LOOP 실행 : 조회된 인원수 만큼 --
--////////////////////////////////////////////////////////////--
  FOR C1  IN WORKCAL_REC
  LOOP
      BEGIN
        -- 기존 자료 삭제.
        DELETE FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE                            BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
          AND WC.SOB_ID                               = P_SOB_ID
          AND WC.ORG_ID                               = P_ORG_ID
          AND WC.PERSON_ID                            = C1.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Work Calendar Delete Error : ' || SQLERRM);
      END;

--DBMS_OUTPUT.PUT_LINE('작업시작=>IN_PERSON_NUMB' || C1.PERSON_NUM || '//' || C1.WORK_TYPE);
      D_START_DATE := P_WORK_DATE_FR - V_PRE_DAY_COUNT;
      /*--> 임시테이블 DATA 삭제 <--*/
      DELETE FROM HRD_WORK_DATE_GT;

      -- 월 달력 생성.
      BEGIN
        N1 := P_WORK_DATE_TO - D_START_DATE + 1;
        FOR R1 IN 0 .. N1 - 1
        LOOP
          INSERT INTO HRD_WORK_DATE_GT
          (WORK_DATE, PERSON_ID, WORK_CORP_ID, CORP_ID, WORK_YYYYMM
          , WORK_WEEK, HOLIDAY_CHECK
          , WORK_TYPE_ID, WORK_TYPE
          , DUTY_ID, HOLY_TYPE
          , SOB_ID, ORG_ID
          , TMP_HOLY_TYPE, CREATE_TYPE)
          VALUES
          ( D_START_DATE + R1
          , C1.PERSON_ID, C1.WORK_CORP_ID, C1.CORP_ID
          , P_WORK_PERIOD
          , TO_CHAR(D_START_DATE + R1, 'D')
          , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_CHECK(D_START_DATE + R1 , P_SOB_ID, P_ORG_ID)
          , C1.WORK_TYPE_ID, C1.WORK_TYPE
          , 1168, '2'
          , P_SOB_ID, P_ORG_ID
          , '2', V_CREATED_METHOD)
          ;
        END LOOP C1;
      END;
--  RAISE_APPLICATION_ERROR(-20001, '000000000000000');
/*------------------------------------------------------------------------------------------------*
+++++    교대유형에 따른 근무/근태 값 생성
*------------------------------------------------------------------------------------------------*/
      IF C1.WORK_TYPE IN('11') THEN
      -- 무교대(월력 따라감)
         FOR R1 IN ( SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
                          , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.HOLIDAY_CHECK
                          , WD.WORK_TYPE_ID, WD.WORK_TYPE
                          , WD.DUTY_ID, WD.HOLY_TYPE
                          , WD.SOB_ID, WD.ORG_ID
                       FROM HRD_WORK_DATE_GT WD
                     WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND P_WORK_DATE_TO
                       AND WD.PERSON_ID      = C1.PERSON_ID
                       AND WD.SOB_ID         = C1.SOB_ID
                       AND WD.ORG_ID         = C1.ORG_ID
                   )
        LOOP
          UPDATE HRD_WORK_DATE_GT WD
            SET (WD.DUTY_ID, WD.HOLY_TYPE, WD.TMP_HOLY_TYPE)
              = (SELECT DC.DUTY_ID
                     , CASE
                          WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('1') THEN '1'             -- 일요일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('7') THEN '0'             -- 토요일 - 무휴일.
                          ELSE '2'                                       -- 정상근무.
                       END AS HOLY_TYPE
                     , CASE
                          WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '2'    -- 공휴일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('1') THEN '2'             -- 일요일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('7') THEN '2'             -- 토요일 - 무휴일.
                          ELSE '2'                                       -- 정상근무.
                       END AS TMP_HOLY_TYPE
                  FROM HRM_DUTY_CODE_V DC
                WHERE DC.SOB_ID           = WD.SOB_ID
                  AND DC.ORG_ID           = WD.ORG_ID
                  AND DC.DUTY_CODE        = CASE
                                              WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'    -- 공휴일 - 휴일.
                                              WHEN WD.WORK_WEEK     IN('1')      THEN '51'    -- 일요일 - 휴일.
                                              WHEN WD.WORK_WEEK     IN('7')      THEN '52'    -- 토요일 - 휴일.
                                              ELSE '00'                                       -- 평일.
                                            END)
          WHERE WD.WORK_DATE      = R1.WORK_DATE
            AND WD.PERSON_ID      = R1.PERSON_ID
            AND WD.SOB_ID         = R1.SOB_ID
            AND WD.ORG_ID         = R1.ORG_ID;
        END LOOP  R1;
-------------------------------------------------------------------------------
    ELSE
    -- Manual입력(2조2교대 OR 3조2교대) --
        BEGIN
          -- 근무계획 생성 기준정보 존재 여부 체크.
          SELECT COUNT(WCS.WORK_TYPE_ID) AS DAY_COUNT
            INTO V_DAY_COUNT
            FROM HRD_WORK_CALENDAR_SET WCS
           WHERE WCS.CORP_ID          = P_CORP_ID
             AND WCS.WORK_PERIOD      = P_WORK_PERIOD
             AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
             AND WCS.CREATED_METHOD   = V_CREATED_METHOD
             AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
             AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
             AND WCS.SOB_ID           = P_SOB_ID
             AND WCS.ORG_ID           = P_ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_DAY_COUNT := 0;
        END;
        IF V_DAY_COUNT = 0 THEN
          O_STATUS := 'F';
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10454');
          RETURN;
        END IF;
            
        -- 변수 초기화.
        V_DAY_COUNT := 0;
        V_LOOP_COUNT := 0;
/*DBMS_OUTPUT.PUT_LINE('CORP_ID : ' || P_CORP_ID || ', WORK_PERIOD : ' || P_WORK_PERIOD || ', WORK_TYPE_ID : ' || P_WORK_TYPE_ID
                   || ', CREATED_METHOD' || V_CREATED_METHOD || ', SOB_ID : ' || P_SOB_ID);            */
        BEGIN
          SELECT CEIL((WCS.WORK_DATE_TO - WCS.WORK_DATE_FR + 1) / SUM(DECODE(WCS.HOLY_TYPE, -1, -1, 1) * DAY_COUNT)) AS LOOP_COUNT
            INTO V_LOOP_COUNT
            FROM HRD_WORK_CALENDAR_SET WCS
           WHERE WCS.CORP_ID          = P_CORP_ID
             AND WCS.WORK_PERIOD      = P_WORK_PERIOD
             AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
             AND WCS.CREATED_METHOD   = V_CREATED_METHOD
             AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
             AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
             AND WCS.SOB_ID           = P_SOB_ID
             AND WCS.ORG_ID           = P_ORG_ID
          GROUP BY WCS.WORK_DATE_TO, WCS.WORK_DATE_FR
          ;
        EXCEPTION WHEN OTHERS THEN
          V_LOOP_COUNT := 0;
          DBMS_OUTPUT.PUT_LINE('Loop Count Error : ' || V_LOOP_COUNT);
        END;
--RAISE_APPLICATION_ERROR(-20001, '2323');
        FOR CNT IN 1..V_LOOP_COUNT
        LOOP
          FOR R0 IN (SELECT  WCS.SEQ
                           , WCS.HOLY_TYPE
                           , WCS.DAY_COUNT
                        FROM HRD_WORK_CALENDAR_SET WCS
                       WHERE WCS.CORP_ID          = C1.WORK_CORP_ID   -- C1.CORP_ID[2011-06-27]수정
                         AND WCS.WORK_PERIOD      = P_WORK_PERIOD
                         AND WCS.WORK_TYPE_ID     = C1.WORK_TYPE_ID
                         AND WCS.CREATED_METHOD   = V_CREATED_METHOD
                         AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
                         AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
                         AND WCS.SOB_ID           = C1.SOB_ID
                         AND WCS.ORG_ID           = C1.ORG_ID
                         AND WCS.HOLY_TYPE        <> -1
                      ORDER BY WCS.SEQ
                      )
          LOOP
            IF R0.HOLY_TYPE IN (2, 3) AND R0.DAY_COUNT IN(4, 5) THEN
              V_PRE_HOLY_TYPE := R0.HOLY_TYPE; --휴일이전 주/야 임시 저장
            END IF;
            V_DAY_COUNT := NVL(R0.DAY_COUNT, 0);  -- 기적용일수는 이미 시작일자에 반영됨.
            D_END_DATE := D_START_DATE + V_DAY_COUNT - 1;
  --DBMS_OUTPUT.PUT_LINE('START DATE : ' || TO_CHAR(D_START_DATE, 'YYYY-MM-DD') || ', END DATE : ' || TO_CHAR(D_END_DATE, 'YYYY-MM-DD') || ', HOLY : ' || R0.HOLY_TYPE);
            FOR R1 IN ( SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
                              , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.HOLIDAY_CHECK
                              , WD.WORK_TYPE_ID, WD.WORK_TYPE
                              , WD.DUTY_ID, WD.HOLY_TYPE
                              , WD.SOB_ID, WD.ORG_ID
                          FROM HRD_WORK_DATE_GT WD
                         WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND D_END_DATE
                           AND WD.PERSON_ID      = C1.PERSON_ID
                           AND WD.SOB_ID         = C1.SOB_ID
                           AND WD.ORG_ID         = C1.ORG_ID
                      )
            LOOP
              /*-- 근무구분 반영  --*/
              UPDATE HRD_WORK_DATE_GT WD
                SET (WD.DUTY_ID, WD.HOLY_TYPE, WD.TMP_HOLY_TYPE)
                    = (SELECT DC.DUTY_ID
                            , CASE
                                WHEN WD.WORK_TYPE IN('22') THEN               -- 2조 2교대 : 월력 .
                                  CASE
                                    WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                                    ELSE R0.HOLY_TYPE
                                  END
                                ELSE                                          -- 3조 2교대 : 월력 .
                                  CASE
                                    WHEN WD.HOLIDAY_CHECK IN('A') THEN '1'      -- 공휴일 - 유휴일.
                                    ELSE R0.HOLY_TYPE
                                  END
                              END AS HOLY_TYPE
                            , CASE
                                 WHEN WD.WORK_TYPE IN('22') THEN -- 2조 2교대 : 월력
                                      CASE
                                          WHEN R0.HOLY_TYPE IN('0', '1') THEN V_PRE_HOLY_TYPE
                                          ELSE R0.HOLY_TYPE
                                      END
                                 ELSE                            -- 3조 2교대 : 월력
                                      CASE
                                          WHEN R0.HOLY_TYPE IN('0', '1') THEN V_PRE_HOLY_TYPE
                                          ELSE R0.HOLY_TYPE
                                      END
                             END AS TMP_HOLY_TYPE
                         FROM HRM_DUTY_CODE_V DC
                        WHERE DC.SOB_ID           = WD.SOB_ID
                          AND DC.ORG_ID           = WD.ORG_ID
                          AND DC.DUTY_CODE        = CASE
                                                      WHEN WD.WORK_TYPE IN('22') THEN  -- 2조 2교대 : 월력 .
                                                        CASE
                                                        --WHEN HWG2.WEEK_TYPE IN('1', '7') THEN '53'
                                                          WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'  -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '1' THEN '51'   -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '0' THEN '52'   -- 무휴일.
                                                          ELSE '00'
                                                        END
                                                      ELSE                                          /*--< 3조 2교대 : 월력 > --*/
                                                        CASE
                                                          WHEN WD.HOLIDAY_CHECK IN('A') THEN '51'  -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '1' THEN '51'   -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '0' THEN '52'   -- 무휴일.
                                                          ELSE '00'
                                                        END
                                                    END)
               WHERE WD.WORK_DATE      = R1.WORK_DATE
                 AND WD.PERSON_ID      = R1.PERSON_ID
                 AND WD.SOB_ID         = R1.SOB_ID
                 AND WD.ORG_ID         = R1.ORG_ID;
  --DBMS_OUTPUT.PUT_LINE('WORK_DATE : ' || TO_CHAR(R1.WORK_DATE, 'YYYY-MM-DD') || '// PERSON ID : ' || R1.PERSON_ID);
            END LOOP  R1;
            D_START_DATE := D_END_DATE + 1;
          END LOOP R0;
        END LOOP CNT;
      END IF;
-------------------------------------------------------------------------------

      /*=========================================================================================/
       --> OPEN 시간 CLOSE 시간 설정
      /=========================================================================================*/
      UPDATE HRD_WORK_DATE_GT WD
        SET (WD.OPEN_TIME, WD.CLOSE_TIME)
            =
            (SELECT TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') + WIT.I_ADD_DAYS AS OPEN_TIME
                   , TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') + WIT.O_ADD_DAYS AS OPEN_TIME
                FROM HRM_WORK_IO_TIME_V WIT
              WHERE WIT.WORK_TYPE      = WD.WORK_TYPE
                AND WIT.HOLY_TYPE      = WD.HOLY_TYPE
                AND WIT.ENABLED_FLAG   = 'Y'
                AND WIT.EFFECTIVE_DATE_FR <= WD.WORK_DATE
                AND (WIT.EFFECTIVE_DATE_TO IS NULL OR WIT.EFFECTIVE_DATE_TO >= WD.WORK_DATE)
               AND WIT.SOB_ID         = WD.SOB_ID
               AND WIT.ORG_ID         = WD.ORG_ID
             )
      WHERE WD.WORK_DATE               BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
        AND WD.PERSON_ID               = C1.PERSON_ID
        AND WD.SOB_ID                  = P_SOB_ID
        AND WD.ORG_ID                  = P_ORG_ID
      ;

     /*=========================================================================================/
      --> 일괄 INSERT 실시
     /=========================================================================================*/
      INSERT INTO HRD_WORK_CALENDAR
      (WORK_DATE, PERSON_ID, WORK_CORP_ID, CORP_ID
      , WORK_YYYYMM, WORK_WEEK, WORK_TYPE_ID
      , DUTY_ID, HOLY_TYPE, OPEN_TIME, CLOSE_TIME
      , ATTRIBUTE5
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      , ATTRIBUTE3, ATTRIBUTE2)
      (SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
      , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.WORK_TYPE_ID
      , WD.DUTY_ID, WD.HOLY_TYPE, WD.OPEN_TIME, WD.CLOSE_TIME
      , WD.WORK_TYPE AS ATTRIBUTE5
      , WD.SOB_ID, WD.ORG_ID
      , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
      , WD.TMP_HOLY_TYPE, WD.CREATE_TYPE
      FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_DATE        BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
      AND WD.SOB_ID           = P_SOB_ID
      AND WD.ORG_ID           = P_ORG_ID
      );
      /*--> 임시테이블 DATA 삭제 <--*/
      DELETE FROM HRD_WORK_DATE_GT;
    END LOOP C1;

    /*===========================================================/
    --> 출퇴근 조회/일근태 조회 : 철야,당직 체크 적용.
    /===========================================================*/
    FOR R1 IN ( SELECT PM.CORP_ID
                      , PM.SOB_ID
                      , PM.ORG_ID
                      , PM.PERSON_ID
                      , DI.WORK_DATE
                      , NVL(DL.DANGJIK_YN, DI.DANGJIK_YN) AS DANGJIK_YN
                      , NVL(DL.ALL_NIGHT_YN, DI.ALL_NIGHT_YN) AS ALL_NIGHT_YN
                  FROM HRD_DAY_INTERFACE DI
                    , HRD_DAY_LEAVE DL
                    , HRM_PERSON_MASTER PM
                WHERE DI.PERSON_ID         = DL.PERSON_ID(+)
                  AND DI.WORK_DATE         = DL.WORK_DATE(+)
                  AND DI.SOB_ID            = DL.SOB_ID(+)
                  AND DI.ORG_ID            = DL.ORG_ID(+)
                  AND DI.PERSON_ID         = PM.PERSON_ID
                  AND DI.WORK_DATE          BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
                  AND DI.PERSON_ID          = NVL(P_PERSON_ID, DI.PERSON_ID)
                  AND PM.CORP_ID            = P_CORP_ID
                  AND PM.SOB_ID             = P_SOB_ID
                  AND PM.ORG_ID             = P_ORG_ID
                  AND PM.FLOOR_ID            = NVL(P_FLOOR_ID, PM.FLOOR_ID)
                  AND PM.WORK_TYPE_ID       = NVL(P_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                  AND ( NVL(DL.DANGJIK_YN, DI.DANGJIK_YN)     = 'Y'
                    OR NVL(DL.ALL_NIGHT_YN, DI.ALL_NIGHT_YN)  = 'Y'
                      )
                ORDER BY DL.WORK_DATE, DL.PERSON_ID
       )
    LOOP
      BEGIN
        UPDATE HRD_WORK_CALENDAR WC
          SET WC.DANGJIK_YN               = R1.DANGJIK_YN
            , WC.ALL_NIGHT_YN             = R1.ALL_NIGHT_YN
            , WC.LAST_UPDATE_DATE         = GET_LOCAL_DATE(WC.SOB_ID)
            , WC.LAST_UPDATED_BY          = P_USER_ID
        WHERE WC.WORK_DATE                = R1.WORK_DATE
          AND WC.PERSON_ID                = R1.PERSON_ID
          AND WC.SOB_ID                   = R1.SOB_ID
          AND WC.ORG_ID                   = R1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('DANGJIK/ALL_NIGHT_UPDATE_ERROR=>' || SUBSTR(SQLERRM, 1, 200));
      END;
    END LOOP R1;

    /*===========================================================/
    --> 연장근무  승인 적용
    /===========================================================*/
    << OT_UPDATE_START >>
    FOR R1 IN ( SELECT OH.CORP_ID
                     , OH.SOB_ID
                     , OH.ORG_ID
                     , OL.PERSON_ID
                     , OL.WORK_DATE
                     , OL.BEFORE_OT_START
                     , OL.BEFORE_OT_END
                     , OL.AFTER_OT_START
                     , OL.AFTER_OT_END
                     , OL.BREAKFAST_YN
                     , OL.LUNCH_YN
                     , OL.DINNER_YN
                     , OL.MIDNIGHT_YN
                     , OL.DANGJIK_YN
                     , OL.ALL_NIGHT_YN
                     , GET_LOCAL_DATE(OH.SOB_ID)
                     , P_USER_ID
                  FROM HRD_OT_HEADER OH
                    , HRD_OT_LINE OL
                    , HRM_PERSON_MASTER PM
                WHERE OH.REQ_NUM            = OL.REQ_NUM
                  AND OH.SOB_ID             = PM.SOB_ID
                  AND OH.ORG_ID             = PM.ORG_ID
                  AND OL.PERSON_ID          = PM.PERSON_ID
                  AND OL.WORK_DATE          BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
                  AND OL.PERSON_ID          = NVL(P_PERSON_ID, OL.PERSON_ID)
                  AND OH.CORP_ID            = P_CORP_ID
                  AND OH.SOB_ID             = P_SOB_ID
                  AND OH.ORG_ID             = P_ORG_ID
                  AND PM.FLOOR_ID           = NVL(P_FLOOR_ID, PM.FLOOR_ID)
                  AND PM.WORK_TYPE_ID       = P_WORK_TYPE_ID
                  AND OH.APPROVE_STATUS     = 'C'
                ORDER BY OH.APPROVED_DATE
               )
    LOOP
      BEGIN
        UPDATE HRD_WORK_CALENDAR WC
          SET WC.BEFORE_OT_START          = R1.BEFORE_OT_START
            , WC.BEFORE_OT_END            = R1.BEFORE_OT_END
            , WC.AFTER_OT_START           = R1.AFTER_OT_START
            , WC.AFTER_OT_END             = R1.AFTER_OT_END
            , WC.BREAKFAST_YN             = R1.BREAKFAST_YN
            , WC.LUNCH_YN                 = R1.LUNCH_YN
            , WC.DINNER_YN                = R1.DINNER_YN
            , WC.MIDNIGHT_YN              = R1.MIDNIGHT_YN
            , WC.DANGJIK_YN               = R1.DANGJIK_YN
            , WC.ALL_NIGHT_YN             = R1.ALL_NIGHT_YN
            , WC.LAST_UPDATE_DATE         = GET_LOCAL_DATE(WC.SOB_ID)
            , WC.LAST_UPDATED_BY          = P_USER_ID
        WHERE WC.WORK_DATE                = R1.WORK_DATE
          AND WC.PERSON_ID                = R1.PERSON_ID
          AND WC.SOB_ID                   = R1.SOB_ID
          AND WC.ORG_ID                   = R1.ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('OT_UPDATE_ERROR=>' || SUBSTR(SQLERRM, 1, 200));
      END;
    END LOOP R1;
    << OT_UPDATE_COMPLETE >>

    /*===========================================================/
      --> 고정근태 승인 적용
    /===========================================================*/
    << DUTY_PERIOD_UPDATE_START >>
    FOR R1 IN (SELECT DP.DUTY_PERIOD_ID
                     , DP.CORP_ID
                     , DP.SOB_ID
                     , DP.ORG_ID
                     , DP.PERSON_ID
                     , DP.DUTY_ID
                     , DP.WORK_START_DATE
                     , DP.WORK_END_DATE
                     , DP.REAL_START_DATE
                     , DP.REAL_END_DATE
                  FROM HRD_DUTY_PERIOD DP
                    , HRM_PERSON_MASTER PM
               WHERE DP.PERSON_ID                 = PM.PERSON_ID
                 AND DP.SOB_ID                    = PM.SOB_ID
                 AND DP.ORG_ID                    = PM.ORG_ID
                 AND (TRUNC(DP.WORK_START_DATE)   BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
                 OR TRUNC(DP.WORK_END_DATE)       BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO)
                 AND DP.CORP_ID                   = P_CORP_ID
                 AND DP.SOB_ID                    = P_SOB_ID
                 AND DP.ORG_ID                    = P_ORG_ID
                 AND DP.PERSON_ID                 = NVL(P_PERSON_ID, DP.PERSON_ID)
                 AND PM.FLOOR_ID                  = NVL(P_FLOOR_ID, PM.FLOOR_ID)
                 AND PM.WORK_TYPE_ID              = P_WORK_TYPE_ID
                 AND DP.APPROVE_STATUS            = 'C'
               ORDER BY DP.APPROVED_DATE
               )
    LOOP
      BEGIN
        /*-- 근무 카렌다 반영 START. --*/
        V_ATTEND_FLAG := HRD_DUTY_PERIOD_G.ATTEND_FLAG_F(R1.DUTY_PERIOD_ID);
        IF V_ATTEND_FLAG = 'LATE_IN' THEN
        -- 지각.
          UPDATE HRD_WORK_CALENDAR WC
            SET (WC.LATE_IN_FR
               , WC.LATE_IN_TO)
                 =
                 ( SELECT DP.START_DATE AS LATE_IN_FR
                        , DP.END_DATE AS LATE_IN_TO
                   FROM HRD_DUTY_PERIOD DP
                   WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                     AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                     AND DP.PERSON_ID         = WC.PERSON_ID
                     AND DP.CORP_ID           = WC.CORP_ID
                     AND DP.SOB_ID            = WC.SOB_ID
                     AND DP.ORG_ID            = WC.ORG_ID
                 )
          WHERE EXISTS ( SELECT 'X'
                         FROM HRD_DUTY_PERIOD DP
                         WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                           AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                           AND DP.PERSON_ID         = WC.PERSON_ID
                           AND DP.CORP_ID           = WC.CORP_ID
                           AND DP.SOB_ID            = WC.SOB_ID
                           AND DP.ORG_ID            = WC.ORG_ID
                       )
          ;
        ELSIF V_ATTEND_FLAG = 'EARLY_OUT' THEN
        -- 조퇴.
          UPDATE HRD_WORK_CALENDAR WC
             SET (WC.EARLY_OUT_FR
                , WC.EARLY_OUT_TO)
                 =
                 ( SELECT DP.START_DATE AS EARLY_OUT_FR
                        , DP.END_DATE AS EARLY_OUT_TO
                   FROM HRD_DUTY_PERIOD DP
                   WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                     AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                     AND DP.PERSON_ID         = WC.PERSON_ID
                     AND DP.CORP_ID           = WC.CORP_ID
                     AND DP.SOB_ID            = WC.SOB_ID
                     AND DP.ORG_ID            = WC.ORG_ID
                 )
          WHERE EXISTS ( SELECT 'X'
                         FROM HRD_DUTY_PERIOD DP
                         WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                           AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                           AND DP.PERSON_ID         = WC.PERSON_ID
                           AND DP.CORP_ID           = WC.CORP_ID
                           AND DP.SOB_ID            = WC.SOB_ID
                           AND DP.ORG_ID            = WC.ORG_ID
                       )
          ;
        ELSIF V_ATTEND_FLAG = 'SHORT_OUT' THEN
        -- 외출.
          UPDATE HRD_WORK_CALENDAR WC
             SET (WC.SHORT_OUT_FR
                 , WC.SHORT_OUT_TO)
                 =
                 ( SELECT DP.START_DATE AS SHORT_OUT_FR
                        , DP.END_DATE AS SHORT_OUT_TO
                   FROM HRD_DUTY_PERIOD DP
                   WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                     AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                     AND DP.PERSON_ID         = WC.PERSON_ID
                     AND DP.CORP_ID           = WC.CORP_ID
                     AND DP.SOB_ID            = WC.SOB_ID
                     AND DP.ORG_ID            = WC.ORG_ID
                 )
          WHERE EXISTS ( SELECT 'X'
                         FROM HRD_DUTY_PERIOD DP
                         WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                           AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                           AND DP.PERSON_ID         = WC.PERSON_ID
                           AND DP.CORP_ID           = WC.CORP_ID
                           AND DP.SOB_ID            = WC.SOB_ID
                           AND DP.ORG_ID            = WC.ORG_ID
                       )
          ;
        ELSIF V_ATTEND_FLAG = 'WORK_OUT' THEN
        -- 외근.
          UPDATE HRD_WORK_CALENDAR WC
             SET (WC.WORK_OUT_FR
                , WC.WORK_OUT_TO)
                 =
                 ( SELECT DP.START_DATE AS WORK_OUT_FR
                        , DP.END_DATE AS WORK_OUT_TO
                   FROM HRD_DUTY_PERIOD DP
                   WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                     AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                     AND DP.PERSON_ID         = WC.PERSON_ID
                     AND DP.CORP_ID           = WC.CORP_ID
                     AND DP.SOB_ID            = WC.SOB_ID
                     AND DP.ORG_ID            = WC.ORG_ID
                 )
          WHERE EXISTS ( SELECT 'X'
                         FROM HRD_DUTY_PERIOD DP
                         WHERE DP.DUTY_PERIOD_ID    = R1.DUTY_PERIOD_ID
                           AND WC.WORK_DATE         BETWEEN DP.WORK_START_DATE AND DP.WORK_END_DATE
                           AND DP.PERSON_ID         = WC.PERSON_ID
                           AND DP.CORP_ID           = WC.CORP_ID
                           AND DP.SOB_ID            = WC.SOB_ID
                           AND DP.ORG_ID            = WC.ORG_ID
                       )
          ;
        ELSE
          UPDATE HRD_WORK_CALENDAR WC
             SET WC.C_DUTY_ID               = CASE
                                                WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                ELSE DECODE(WC.C_DUTY_ID, NULL, R1.DUTY_ID, WC.C_DUTY_ID)
                                              END
               , WC.C_DUTY_ID1              = CASE
                                                WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                ELSE DECODE(WC.C_DUTY_ID, NULL, NULL, R1.DUTY_ID)
                                              END
               , WC.OPEN_TIME               = CASE
                                                WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                ELSE DECODE(WC.WORK_DATE, R1.WORK_START_DATE, R1.REAL_START_DATE, NULL)
                                              END
               , WC.CLOSE_TIME              = CASE
                                                WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                ELSE DECODE(WC.WORK_DATE, R1.WORK_END_DATE, R1.REAL_END_DATE, NULL)
                                              END
               , WC.OLD_OPEN_TIME           = CASE
                                                WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                ELSE WC.OPEN_TIME
                                              END
               , WC.OLD_CLOSE_TIME          = CASE
                                                WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                ELSE WC.CLOSE_TIME
                                              END
               , WC.LAST_UPDATE_DATE        = GET_LOCAL_DATE(WC.SOB_ID)
               , WC.LAST_UPDATED_BY         = P_USER_ID
          WHERE WC.WORK_DATE                BETWEEN R1.WORK_START_DATE AND R1.WORK_END_DATE
            AND WC.PERSON_ID                = R1.PERSON_ID
            AND WC.SOB_ID                   = R1.SOB_ID
            AND WC.ORG_ID                   = R1.ORG_ID
          ;
        END IF;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('PERIOD_UPDATE_ERROR=>' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 200));
      END;
    END LOOP R1;
    << DUTY_PERIOD_UPDATE_COMPLETE >>

    /*===========================================================/
    --> 근무변경  승인 적용
    /===========================================================*/
    << HOLY_TYPE_UPDATE_START >>
    FOR R1 IN ( SELECT HT.HOLY_TYPE_ID
                    , HT.WORK_CORP_ID AS CORP_ID
                    , HT.SOB_ID
                    , HT.ORG_ID
                    , HT.PERSON_ID
                    , HT.HOLY_TYPE
                    , HT.START_DATE
                    , HT.END_DATE
               FROM HRD_HOLY_TYPE HT
                  , HRM_PERSON_MASTER PM
               WHERE HT.PERSON_ID                 = PM.PERSON_ID
                 AND HT.SOB_ID                    = PM.SOB_ID
                 AND HT.ORG_ID                    = PM.ORG_ID
                 AND (HT.START_DATE               BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
                   OR HT.END_DATE                 BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO)
                 AND HT.WORK_CORP_ID              = P_CORP_ID
                 AND HT.SOB_ID                    = P_SOB_ID
                 AND HT.ORG_ID                    = P_ORG_ID
                 AND PM.PERSON_ID                 = NVL(P_PERSON_ID, PM.PERSON_ID)
                 AND PM.FLOOR_ID                  = NVL(P_FLOOR_ID, PM.FLOOR_ID)
                 AND PM.WORK_TYPE_ID              = P_WORK_TYPE_ID
                 AND HT.APPROVE_STATUS            = 'C'
              ORDER BY HT.APPROVED_DATE
            )
    LOOP
      BEGIN
        UPDATE HRD_WORK_CALENDAR WC
              SET WC.DUTY_ID      = CASE
                                      WHEN R1.HOLY_TYPE IN('1') THEN HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''51''', R1.SOB_ID, R1.ORG_ID)  -- 유휴.
                                      WHEN R1.HOLY_TYPE IN('0') THEN HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''52''', R1.SOB_ID, R1.ORG_ID)  -- 무휴.
                                      ELSE HRM_COMMON_G.GET_ID_F('DUTY', ' CODE = ''00''', R1.SOB_ID, R1.ORG_ID)                           -- 그외.
                                    END
                , WC.HOLY_TYPE    = R1.HOLY_TYPE
                , WC.ATTRIBUTE4   = WC.HOLY_TYPE
            WHERE WC.PERSON_ID    = R1.PERSON_ID
              AND WC.WORK_DATE    BETWEEN R1.START_DATE AND R1.END_DATE
              AND WC.SOB_ID       = R1.SOB_ID
              AND WC.ORG_ID       = R1.ORG_ID
            ;

            /*=========================================================================================/
               --> OPEN 시간 CLOSE 시간 설정
            /=========================================================================================*/
            UPDATE HRD_WORK_CALENDAR WC
               SET (WC.OPEN_TIME, WC.CLOSE_TIME)
                   =
                   (SELECT TO_DATE(TO_CHAR(WC.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') + WIT.I_ADD_DAYS AS OPEN_TIME
                         , TO_DATE(TO_CHAR(WC.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') + WIT.O_ADD_DAYS AS OPEN_TIME
                      FROM HRM_WORK_IO_TIME_V WIT
                     WHERE WIT.WORK_TYPE      = WC.ATTRIBUTE5             -- WORK_TYPE.
                       AND WIT.HOLY_TYPE      = WC.HOLY_TYPE
                       AND WIT.ENABLED_FLAG   = 'Y'
                       AND WIT.EFFECTIVE_DATE_FR <= WC.WORK_DATE
                       AND (WIT.EFFECTIVE_DATE_TO IS NULL OR WIT.EFFECTIVE_DATE_TO >= WC.WORK_DATE)
                       AND WIT.SOB_ID         = WC.SOB_ID
                       AND WIT.ORG_ID         = WC.ORG_ID
                   )
             WHERE WC.PERSON_ID   = R1.PERSON_ID
              AND WC.WORK_DATE    BETWEEN R1.START_DATE AND R1.END_DATE
              AND WC.SOB_ID       = R1.SOB_ID
              AND WC.ORG_ID       = R1.ORG_ID
             ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('HOLY_TYPE_UPDATE_ERROR=>' || SUBSTR(SQLERRM, 1, 200)); 
      END;
    END LOOP R1;
    << HOLY_TYPE_UPDATE_COMPLETE >>
    
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10167', NULL);
  EXCEPTION WHEN OTHERS THEN
    O_STATUS := 'F';
    O_MESSAGE := 'ERROR=>' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 200);
  END WORKCAL_SET_TABLE;


-- 공통코드 조회 LOOKUP - GROUP CODE..
  PROCEDURE LU_SELECT_GROUP
           ( P_CURSOR3            OUT TYPES.TCURSOR3
      , W_GROUP_CODE         IN HRM_COMMON.GROUP_CODE%TYPE
      , W_CODE_NAME          IN HRM_COMMON.CODE_NAME%TYPE
      , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
      , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
      , W_ENABLED_FLAG_YN    IN HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
      )
  AS
   V_STD_DATE                     HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

  BEGIN
   IF W_ENABLED_FLAG_YN = 'Y' THEN
    V_STD_DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));
  ELSE
    V_STD_DATE := NULL;
  END IF;

  OPEN P_CURSOR3 FOR
   SELECT HC.CODE_NAME
     , HC.CODE
     , HC.COMMON_ID
     , HC.VALUE1
     , HC.VALUE2
     , HC.VALUE3
     , HC.VALUE4
     , HC.VALUE5
     , HC.VALUE6
     , HC.VALUE7
          , HC.VALUE8
     , HC.VALUE9
     , HC.VALUE10
   FROM HRM_COMMON HC
   WHERE HC.GROUP_CODE          = W_GROUP_CODE
    AND HC.CODE_NAME           LIKE W_CODE_NAME || '%'
    AND HC.SOB_ID              = W_SOB_ID
    AND HC.ORG_ID              = W_ORG_ID
           --AND HC.ENABLED_FLAG         = DECODE(W_ENABLED_FLAG_YN, 'Y', 'Y', HC.ENABLED_FLAG)
           AND HC.ENABLED_FLAG         = 'Y'
    AND HC.EFFECTIVE_DATE_FR   <= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_FR)
    AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= NVL(V_STD_DATE, HC.EFFECTIVE_DATE_TO))
   ORDER BY HC.CODE_NAME
   ;

  END LU_SELECT_GROUP;


-- LOOKUP PERSON INFOMATION - CAPACITY.
       PROCEDURE LU_PERSON_WORK_CALENDAR_C( P_CURSOR3                           OUT TYPES.TCURSOR3
                                          , W_CORP_ID                           IN  NUMBER
                                          , W_FLOOR_ID                          IN  NUMBER
                                          , W_WORK_TYPE_ID                      IN  NUMBER
                                          , W_CONNECT_PERSON_ID                 IN  NUMBER
                                          , W_SOB_ID                            IN  NUMBER
                                          , W_ORG_ID                            IN  NUMBER
                                          )
       AS

                 V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
                 V_DATE_START          DATE := TO_DATE('1999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
                 V_DATE_END            DATE := TRUNC(SYSDATE);

       BEGIN
                 IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                            , W_START_DATE  => V_DATE_START
                                            , W_END_DATE    => V_DATE_END
                                            , W_MODULE_CODE => '20'
                                            , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                            , W_SOB_ID      => W_SOB_ID
                                            , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                    V_CONNECT_PERSON_ID := NULL;
                 ELSE
                    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
                 END IF;

                 OPEN P_CURSOR3 FOR
                 SELECT PM.NAME || '(' || PM.PERSON_NUM || ')'     AS PERSON_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , WT.WORK_TYPE_NAME
                      , TO_CHAR(PM.JOIN_DATE, 'YYYY-MM-DD') AS JOIN_DATE
                      , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                      , TO_CHAR(PM.RETIRE_DATE, 'YYYY-MM-DD') AS RETIRE_DATE
                      , PM.PERSON_ID
                   FROM HRM_PERSON_MASTER PM
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE            <= V_DATE_END
                                                            AND S_HL.PERSON_ID               = HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  V_DATE_END
                            AND PH.EFFECTIVE_DATE_TO  >=  V_DATE_END
                        ) T2
                             , HRM_WORK_TYPE_V WT
                  WHERE PM.PERSON_ID                                = T1.PERSON_ID
                    AND PM.PERSON_ID                               = T2.PERSON_ID
                    AND PM.WORK_TYPE_ID                             = WT.WORK_TYPE_ID
                    AND PM.WORK_CORP_ID                             = W_CORP_ID
                    AND PM.WORK_TYPE_ID                             = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                    AND T2.FLOOR_ID                                 = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                    AND PM.JOIN_DATE                               <= V_DATE_END
                    AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= V_DATE_START)
                    AND PM.SOB_ID                                   = W_SOB_ID
                    AND PM.ORG_ID                                   = W_ORG_ID
                    AND EXISTS (SELECT 'X'
                                  FROM HRD_DUTY_MANAGER DM
                                 WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
                                   AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
                                   AND DM.WORK_TYPE_ID                            = DECODE(NVL(DM.WORK_TYPE_ID, 0), 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                                   AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                                   AND DM.SOB_ID                                  = PM.SOB_ID
                                   AND DM.ORG_ID                                  = PM.ORG_ID
                               )
               ORDER BY HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)
                      , PM.NAME
                      ;

       END LU_PERSON_WORK_CALENDAR_C;


-- [2011-10-31]
   PROCEDURE LU_SELECT_HOLY
           ( P_CURSOR3            OUT TYPES.TCURSOR3
           , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
           )

   AS

   BEGIN

             OPEN P_CURSOR3 FOR
             SELECT HC.CODE_NAME
                  , HC.CODE
                  , HC.COMMON_ID
                  , HC.VALUE1
                  , HC.VALUE2
                  , HC.VALUE3
                  , HC.VALUE4
                  , HC.VALUE5
                  , HC.VALUE6
                  , HC.VALUE7
                  , HC.VALUE8
                  , HC.VALUE9
                  , HC.VALUE10
               FROM HRM_COMMON HC
              WHERE HC.SOB_ID               = W_SOB_ID
                AND HC.ORG_ID               = W_ORG_ID
                AND HC.GROUP_CODE           = 'HOLY_TYPE'
                AND HC.VALUE1               = 'Y'
           ORDER BY HC.CODE_NAME
                  ;

   END LU_SELECT_HOLY;



-- [2011-12-30]
   PROCEDURE LU_SELECT_HOLY_OTHER
           ( P_CURSOR3            OUT TYPES.TCURSOR3
           , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
           )

   AS

   BEGIN

             OPEN P_CURSOR3 FOR
             SELECT HC.CODE_NAME
                  , HC.CODE
                  , HC.COMMON_ID
                  , HC.VALUE1
               FROM HRM_COMMON        HC
              WHERE HC.SOB_ID      =  W_SOB_ID
                AND HC.ORG_ID      =  W_ORG_ID
                AND HC.GROUP_CODE  = 'HOLY_OTHER'
           ORDER BY HC.SORT_NUM
                  ;

   END LU_SELECT_HOLY_OTHER;



       PROCEDURE DEFAULT_FLOOR( O_FLOOR_ID            OUT HRM_PERSON_MASTER.FLOOR_ID%TYPE
                              , O_FLOOR_NAME          OUT VARCHAR2
                              , O_PERSON_NAME         OUT HRM_PERSON_MASTER.DISPLAY_NAME%TYPE
                              , O_CAPACITY            OUT VARCHAR2
                              , W_SOB_ID              IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                              , W_ORG_ID              IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                              , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                              )

       IS

                 V_WORK_CORP_ID   HRM_PERSON_MASTER.WORK_CORP_ID%TYPE := NULL;
                 V_DATE_START          DATE := TO_DATE('1999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
                 V_DATE_END            DATE := TRUNC(SYSDATE);

       BEGIN

                 SELECT HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID) AS FLOOR
                      , PM.FLOOR_ID
                      , PM.NAME || '(' || PM.PERSON_NUM || ')' AS PERSON_NAME
                      , PM.WORK_CORP_ID
                   INTO O_FLOOR_NAME
                      , O_FLOOR_ID
                      , O_PERSON_NAME
                      , V_WORK_CORP_ID
                   FROM HRM_PERSON_MASTER PM
                  WHERE PM.SOB_ID    = W_SOB_ID
                    AND PM.ORG_ID    = W_ORG_ID
                    AND PM.PERSON_ID = W_CONNECT_PERSON_ID
                      ;

                 O_CAPACITY := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => V_WORK_CORP_ID
                                                       , W_START_DATE  => V_DATE_START
                                                       , W_END_DATE    => V_DATE_END
                                                       , W_MODULE_CODE => '20'
                                                       , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                                       , W_SOB_ID      => W_SOB_ID
                                                       , W_ORG_ID      => W_ORG_ID);

                 IF O_CAPACITY = 'C' THEN
                    O_FLOOR_NAME := NULL;
                    O_FLOOR_ID   := NULL;
                 END IF;

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           O_FLOOR_NAME := NULL;
                           O_FLOOR_ID   := NULL;

       END DEFAULT_FLOOR;


       PROCEDURE SELECT_MODIFY_FLOOR_WORKTYPE( P_CURSOR                            OUT TYPES.TCURSOR
                                             , W_SOB_ID                            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                             , W_ORG_ID                            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                             , W_WORK_CORP_ID                      IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                             , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_FLOOR_ID                          IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                             , W_WORK_TYPE_ID                      IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                             , W_CONNECT_PERSON_ID                 IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_EMPLOYE_TYPE                      IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                             )

       AS

                V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
                V_DATE_START          DATE := TO_DATE('1999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
                V_DATE_END            DATE := SYSDATE;

       BEGIN

             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                                        , W_START_DATE  => V_DATE_START
                                        , W_END_DATE    => V_DATE_END
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT PM.DISPLAY_NAME                             AS  PERSON_NAME
                  , PM.PERSON_NUM                               AS  PERSON_NUMBER
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)         AS  T_FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)   AS  T_DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID)  AS  T_JOB_CATEGORY_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)     AS  P_WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)         AS  P_FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)   AS  P_DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)  AS  P_JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PM.FLOOR_ID
                  , PM.DEPT_ID
                  , PM.WORK_TYPE_ID
                  , PM.PERSON_ID
               FROM HRM_PERSON_MASTER PM
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.DEPT_ID
                          , HL.JOB_CATEGORY_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID)   AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE S_HL
                                                      WHERE S_HL.CHARGE_DATE            <= V_DATE_END
                                                        AND S_HL.PERSON_ID               = HL.PERSON_ID
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  V_DATE_END
                        AND PH.EFFECTIVE_DATE_TO  >=  V_DATE_END
                    ) T2
              WHERE PM.PERSON_ID                               = T1.PERSON_ID
                AND PM.PERSON_ID                               = T2.PERSON_ID
                AND PM.WORK_CORP_ID                            = W_WORK_CORP_ID
                AND PM.PERSON_ID                               = NVL(W_PERSON_ID, PM.PERSON_ID)
                AND PM.SOB_ID                                  = W_SOB_ID
                AND PM.ORG_ID                                  = W_ORG_ID
                AND T2.FLOOR_ID                                = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                AND PM.JOIN_DATE                              <= V_DATE_END
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= V_DATE_START)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PM.WORK_CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                               AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.START_DATE                              <= V_DATE_END
                               AND (DM.END_DATE IS NULL OR DM.END_DATE        >= V_DATE_START)
                               AND DM.SOB_ID                                   = PM.SOB_ID
                               AND DM.ORG_ID                                   = PM.ORG_ID
                           )
                AND PM.EMPLOYE_TYPE = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
           ORDER BY PM.DISPLAY_NAME
                  ;

       END SELECT_MODIFY_FLOOR_WORKTYPE;


       PROCEDURE SELECT_DETAIL_WORK_CALENDAR( P_CUR1                              OUT TYPES.TCURSOR1
                                            , W_SOB_ID                            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                            , W_ORG_ID                            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                            , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                            , W_START_DATE                        IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                            , W_END_DATE                          IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                            )

       AS

                 N_DAY_COUNT      NUMBER := 0;
                 V_WORK_TYPE_ID   HRD_WORK_CALENDAR.WORK_TYPE_ID%TYPE := NULL;

       BEGIN
                 -- 임시테이블 삭제.
                 BEGIN
                       DELETE FROM HRD_WORK_DATE_GT WD;
                 END;

                 -- 월 달력 생성.
                 IF W_END_DATE IS NULL OR W_START_DATE IS NULL THEN
                    N_DAY_COUNT := 0;
                 ELSE
                    N_DAY_COUNT := W_END_DATE - W_START_DATE + 1;
                 END IF;

                 BEGIN
                      FOR C1 IN 0 .. N_DAY_COUNT - 1
                      LOOP
                           INSERT INTO HRD_WORK_DATE_GT
                                     ( WORK_DATE
                                     , PERSON_ID
                                     , WORK_WEEK
                                     , SOB_ID
                                     , ORG_ID
                                     )
                           VALUES
                                     ( W_START_DATE + C1
                                     , W_PERSON_ID
                                     , TO_CHAR(W_START_DATE + C1, 'D')
                                     , W_SOB_ID
                                     , W_ORG_ID
                                     )
                                     ;
                      END LOOP C1;
                 END;

                 -- 교대유형 조회.
                 BEGIN
                       SELECT PM.WORK_TYPE_ID
                         INTO V_WORK_TYPE_ID
                         FROM HRM_PERSON_MASTER PM
                        WHERE PM.PERSON_ID  =  W_PERSON_ID
                            ;
                       EXCEPTION
                            WHEN OTHERS
                            THEN
                                 V_WORK_TYPE_ID := 0;
                 END;

                 OPEN P_CUR1 FOR
                 SELECT WD.WORK_DATE
                      , HRM_COMMON_G.WEEK_F(NVL(WC.WORK_WEEK, WD.WORK_WEEK), WD.SOB_ID, W_ORG_ID) AS DATE_WEEK
                      , HRM_COMMON_G.ID_NAME_F(WC.DUTY_ID) AS DUTY_NAME
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_TYPE_NAME
                      , WC.OPEN_TIME  AS OPEN_TIME
                      , WC.CLOSE_TIME AS CLOSE_TIME
                      , WC.DUTY_ID
                      , WC.HOLY_TYPE
                      , WC.PERSON_ID
                  FROM  HRD_WORK_DATE_GT  WD
                      , HRD_WORK_CALENDAR WC
                  WHERE WD.WORK_DATE                  = WC.WORK_DATE(+)
                    AND WD.PERSON_ID                  = WC.PERSON_ID(+)
                    AND WD.SOB_ID                     = WC.SOB_ID(+)
                    AND WD.ORG_ID                     = WC.ORG_ID(+)
                    AND WD.WORK_DATE                  BETWEEN W_START_DATE AND W_END_DATE
                    AND WD.PERSON_ID                  = W_PERSON_ID
                    AND WD.SOB_ID                     = W_SOB_ID
                    AND WD.ORG_ID                     = W_ORG_ID
               ORDER BY WD.WORK_DATE
                      ;

       END SELECT_DETAIL_WORK_CALENDAR;



-- 근무계획 생성되지 않은 사원 [2011-11-11]
   PROCEDURE SELECT_NOT_CREATE_WORKCALENDAR( P_CURSOR        OUT TYPES.TCURSOR
                                           , W_SOB_ID        IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                           , W_ORG_ID        IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                           , W_WORK_CORP_ID  IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                           , W_WORK_TYPE_ID  IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                           , W_FLOOR_ID      IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                           , W_PERSON_ID     IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                           , W_WORK_DATE_FR  IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                           , W_WORK_DATE_TO  IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                           )

   AS


   BEGIN
             OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)           AS WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)               AS FLOOR_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(PM.PERSON_ID)          AS PERSON_NAME
                  , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(PM.PERSON_ID) AS PERSON_NUMBER
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)         AS CORP_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)         AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)                AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)                AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID )          AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)        AS JOB_CATEGORY_NAME
                  , PM.PERSON_ID
               FROM HRM_PERSON_MASTER PM
                  ,(SELECT DISTINCT
                           S_WC.SOB_ID
                         , S_WC.ORG_ID
                         , S_WC.WORK_CORP_ID
                         , S_WC.PERSON_ID
                      FROM HRD_WORK_CALENDAR  S_WC
                     WHERE S_WC.WORK_DATE     BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                   ) WC
               WHERE PM.SOB_ID       = WC.SOB_ID(+)
                 AND PM.ORG_ID       = WC.ORG_ID(+)
                 AND PM.WORK_CORP_ID = WC.WORK_CORP_ID(+)
                 AND PM.PERSON_ID    = WC.PERSON_ID(+)
                 AND PM.EMPLOYE_TYPE = '1'
                 AND WC.PERSON_ID      IS NULL
                 AND PM.SOB_ID       = W_SOB_ID
                 AND PM.ORG_ID       = W_ORG_ID
                 AND PM.WORK_CORP_ID = W_WORK_CORP_ID
                 AND PM.WORK_TYPE_ID = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                 AND PM.FLOOR_ID     = NVL(W_FLOOR_ID, PM.FLOOR_ID)
                 AND PM.PERSON_ID    = NVL(W_PERSON_ID, PM.PERSON_ID)
            ORDER BY HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)
                   , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)
                   , PM.NAME
                   ;


   END SELECT_NOT_CREATE_WORKCALENDAR;


-- 근무계획 기준정보 조회 [2011-12-28]
   PROCEDURE SELECT_CREATED_CALENDAR_SET
           ( P_CURSOR          OUT TYPES.TCURSOR
           , W_SOB_ID          IN  HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
           , W_ORG_ID          IN  HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
           , W_WORK_CORP_ID    IN  HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
           , W_WORK_PERIOD     IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_WORK_TYPE_ID    IN  HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD  IN  HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           )

   AS

   BEGIN
             OPEN P_CURSOR FOR
             SELECT WCS.WORK_PERIOD
                  , WCS.SEQ
                  , CASE WHEN WCS.CREATED_METHOD = 'P' THEN '[' || WCS.CREATED_METHOD || ']' || 'PERSON'
                         WHEN WCS.CREATED_METHOD = 'D' THEN '[' || WCS.CREATED_METHOD || ']' || 'DEPARTMENT'
                         ELSE '[' || WCS.CREATED_METHOD || ']' || 'ALL'
                    END AS CREATED_METHOD_NAME
                  , '[' || WCS.WORK_TYPE_ID || ']' || HRM_COMMON_G.ID_NAME_F(WCS.WORK_TYPE_ID) AS WORK_TYPE_NAME
                  , WCS.HOLY_TYPE
                  , CASE
                        WHEN WCS.HOLY_TYPE = -1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10166', NULL)
                        ELSE HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WCS.HOLY_TYPE, WCS.SOB_ID, WCS.ORG_ID)
                    END AS HOLY_TYPE_NAME
                  , WCS.DAY_COUNT
                  , WCS.WORK_DATE_FR
                  , WCS.WORK_DATE_TO
                  , TO_CHAR(WCS.CREATION_DATE, 'YYYY-MM-DD HH24:MI:SS') AS CREATION_DATE
                  , EAPP_USER_G.USER_NAME_2_F(WCS.CREATED_BY)           AS CREATED_NAME
                  , WCS.WORK_TYPE_ID
                  , WCS.CREATED_METHOD
                  , WCS.CORP_ID
               FROM HRD_WORK_CALENDAR_SET  WCS
              WHERE WCS.SOB_ID          =  W_SOB_ID
                AND WCS.ORG_ID          =  W_ORG_ID
                AND WCS.CORP_ID         =  NVL(W_WORK_CORP_ID, WCS.CORP_ID)
                AND WCS.WORK_PERIOD     =  NVL(W_WORK_PERIOD, WCS.WORK_PERIOD)
                AND WCS.WORK_DATE_FR    =  NVL(W_WORK_DATE_FR, WCS.WORK_DATE_FR)
                AND WCS.WORK_DATE_TO    =  NVL(W_WORK_DATE_TO, WCS.WORK_DATE_TO)
                AND WCS.WORK_TYPE_ID    =  NVL(W_WORK_TYPE_ID, WCS.WORK_TYPE_ID)
                AND WCS.CREATED_METHOD  =  NVL(W_CREATED_METHOD, WCS.CREATED_METHOD)
           ORDER BY WCS.WORK_PERIOD
                  , WCS.WORK_TYPE_ID
                  , WCS.WORK_DATE_FR
                  , WCS.SEQ
                  ;

   END SELECT_CREATED_CALENDAR_SET;



-- 근무계획 기준정보 조회 수정 [2011-12-30]
   PROCEDURE UPDATE_CREATED_CALENDAR_SET
           ( W_SOB_ID          IN  HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
           , W_ORG_ID          IN  HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
           , W_WORK_CORP_ID    IN  HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
           , W_WORK_PERIOD     IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_WORK_TYPE_ID    IN  HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD  IN  HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           , W_SEQ             IN  HRD_WORK_CALENDAR_SET.SEQ%TYPE
           , P_HOLY_TYPE       IN  HRD_WORK_CALENDAR_SET.HOLY_TYPE%TYPE
           , P_DAY_COUNT       IN  HRD_WORK_CALENDAR_SET.DAY_COUNT%TYPE
           , P_USER_ID         IN  HRD_WORK_CALENDAR_SET.LAST_UPDATED_BY%TYPE
           )

   AS

   BEGIN

             UPDATE HRD_WORK_CALENDAR_SET WCS
                SET WCS.HOLY_TYPE         =  P_HOLY_TYPE
                  , WCS.DAY_COUNT         =  P_DAY_COUNT
                  , WCS.LAST_UPDATE_DATE  =  SYSDATE
                  , WCS.LAST_UPDATED_BY   =  P_USER_ID
              WHERE WCS.SOB_ID            =  W_SOB_ID
                AND WCS.ORG_ID            =  W_ORG_ID
                AND WCS.CORP_ID           =  W_WORK_CORP_ID
                AND WCS.WORK_PERIOD       =  W_WORK_PERIOD
                AND WCS.WORK_DATE_FR      =  W_WORK_DATE_FR
                AND WCS.WORK_DATE_TO      =  W_WORK_DATE_TO
                AND WCS.WORK_TYPE_ID      =  W_WORK_TYPE_ID
                AND WCS.CREATED_METHOD    =  W_CREATED_METHOD
                AND WCS.SEQ               =  W_SEQ
                  ;

   END UPDATE_CREATED_CALENDAR_SET;



-- 근무계획 기준정보 조회 삭제 [2011-12-30]
   PROCEDURE DELETE_CREATED_CALENDAR_SET
           ( W_SOB_ID          IN  HRD_WORK_CALENDAR_SET.SOB_ID%TYPE
           , W_ORG_ID          IN  HRD_WORK_CALENDAR_SET.ORG_ID%TYPE
           , W_WORK_CORP_ID    IN  HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
           , W_WORK_PERIOD     IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
           , W_WORK_DATE_FR    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_FR%TYPE
           , W_WORK_DATE_TO    IN  HRD_WORK_CALENDAR_SET.WORK_DATE_TO%TYPE
           , W_WORK_TYPE_ID    IN  HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
           , W_CREATED_METHOD  IN  HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE
           , W_SEQ             IN  HRD_WORK_CALENDAR_SET.SEQ%TYPE
           )

   AS

   BEGIN

             DELETE FROM HRD_WORK_CALENDAR_SET WCS
              WHERE WCS.SOB_ID          =  W_SOB_ID
                AND WCS.ORG_ID          =  W_ORG_ID
                AND WCS.CORP_ID         =  W_WORK_CORP_ID
                AND WCS.WORK_PERIOD     =  W_WORK_PERIOD
                AND WCS.WORK_DATE_FR    =  W_WORK_DATE_FR
                AND WCS.WORK_DATE_TO    =  W_WORK_DATE_TO
                AND WCS.WORK_TYPE_ID    =  W_WORK_TYPE_ID
                AND WCS.CREATED_METHOD  =  W_CREATED_METHOD
                AND WCS.SEQ             =  W_SEQ
                  ;

   END DELETE_CREATED_CALENDAR_SET;




END HRD_WORK_CALENDAR_G;
/
