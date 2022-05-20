CREATE OR REPLACE PACKAGE HRD_DAY_INTERFACE_G
AS

-- DAY INTERFACE SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_IO_FLAG                           IN HRD_ATTEND_INTERFACE.IO_FLAG%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            );

-- DAY INTERFACE MODIFY SELECT
  PROCEDURE DATA_SELECT_MODIFY
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );
												
-- DAY INTERFACE LONG TYPE SELECT
  PROCEDURE DATA_SELECT_L
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );

-- DAY INTERFACE HISTORY SELECT
  PROCEDURE DATA_SELECT_H
            ( P_CURSOR                            OUT TYPES.TCURSOR
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );
						
-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            );

-- DATA UPDATE[2011-11-10]
   PROCEDURE DATA_UPDATE
           ( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
           , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
           , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_IO_FLAG              IN  HRD_DAY_MODIFY.IO_FLAG%TYPE
           , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
           , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , P_MODIFY_TIME          IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
           , P_MODIFY_TIME1         IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
           , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
           , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
           , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
           , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
           , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
           , P_IO_TIME              IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_IO_TIME1             IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
           , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
           , P_CONNECT_LEVEL        IN  VARCHAR2 DEFAULT 'A'
           , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
           , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
           , O_APPROVE_STATUS       OUT VARCHAR2
           , O_APPROVE_STATUS_NAME  OUT VARCHAR2
           , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
           , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
           , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
           , O_REJECT_PERSON_NAME   OUT VARCHAR2
           );

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            );


-- [출퇴근 등록] - 2011-07-14, [2011-08-11], [2011-11-10] 수정
   PROCEDURE SELECT_DAY( P_CURSOR             OUT TYPES.TCURSOR
                       , W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
                       , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
                       , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                       , W_MODIFY_YN          IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
                       , W_WORK_CORP_ID       IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
                       , W_WORK_DATE          IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
                       , W_WORK_TYPE_ID       IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                       , W_FLOOR_ID           IN  HRM_HISTORY_LINE.FLOOR_ID%TYPE
                       , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
                       );


       -- [ 출퇴근 등록] 수정 - 2011-07-15 [2011-11-10]
       PROCEDURE UPDATE_DAY( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
                           , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
                           , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
                           , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
                           , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
                           , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
                           , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                           , P_OPEN_TIME            IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                           , P_OPEN_TIME1           IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                           , P_CLOSE_TIME           IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                           , P_CLOSE_TIME1          IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                           , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
                           , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
                           , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
                           , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
                           , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
                           , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
                           , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
                           , P_IO_OPEN_TIME         IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                           , P_IO_OPEN_TIME1        IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
                           , P_IO_CLOSE_TIME        IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                           , P_IO_CLOSE_TIME1       IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
                           , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
                           , P_CONNECT_LEVEL        IN  VARCHAR2 DEFAULT 'A'
                           , P_CHECK_OPEN_TIME      IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                           , P_CHECK_CLOSE_TIME     IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
                           , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
                           , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
                           , O_APPROVE_STATUS       OUT VARCHAR2
                           , O_APPROVE_STATUS_NAME  OUT VARCHAR2
                           , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
                           , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
                           , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
                           , O_REJECT_PERSON_NAME   OUT VARCHAR2
                           );



       -- [ 출퇴근 등록 관리자] 수정 - 2011-09-27[2011-11-10]
       PROCEDURE UPDATE_DAY_C( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
                             , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
                             , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
                             , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
                             , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
                             , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
                             , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                             , P_DUTY_ID              IN  HRD_DAY_INTERFACE.DUTY_ID%TYPE
                             , P_OPEN_TIME            IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                             , P_OPEN_TIME1           IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                             , P_CLOSE_TIME           IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                             , P_CLOSE_TIME1          IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                             , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
                             , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
                             , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
                             , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
                             , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
                             , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
                             , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
                             , P_IO_OPEN_TIME         IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                             , P_IO_OPEN_TIME1        IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
                             , P_IO_CLOSE_TIME        IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
                             , P_IO_CLOSE_TIME1       IN  HRD_DAY_INTERFACE.CLOSE_TIME1%TYPE
                             , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
                             , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
                             , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
                             , O_APPROVE_STATUS       OUT VARCHAR2
                             , O_APPROVE_STATUS_NAME  OUT VARCHAR2
                             , P_CHECK_OPEN_TIME      IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                             , P_CHECK_CLOSE_TIME     IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
                             , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
                             , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
                             , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
                             , O_REJECT_PERSON_NAME   OUT VARCHAR2
                             );




-- DATA UPDATE[2011-09-27][2011-10-21][2011-11-10]
   PROCEDURE UPDATE_DAY_IN_OUT
           ( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
           , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
           , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
           , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , P_DUTY_ID              IN  HRD_DAY_INTERFACE.DUTY_ID%TYPE
           , P_MODIFY_OPEN_TIME     IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
           , P_MODIFY_OPEN_TIME1    IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
           , P_MODIFY_CLOSE_TIME    IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
           , P_MODIFY_CLOSE_TIME1   IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
           , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
           , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
           , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
           , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
           , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
           , P_IO_OPEN_TIME         IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_IO_OPEN_TIME1        IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
           , P_IO_CLOSE_TIME        IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_IO_CLOSE_TIME1       IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
           , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
           , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
           , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
           , O_APPROVE_STATUS       OUT VARCHAR2
           , O_APPROVE_STATUS_NAME  OUT VARCHAR2
           , P_CHECK_OPEN_TIME      IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_CHECK_CLOSE_TIME     IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
           , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
           , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
           , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
           , O_REJECT_PERSON_NAME   OUT VARCHAR2
           );


-- [출퇴등 승인] [2011-07-18] [2011-11-10]
   PROCEDURE SELECT_DAY_MODIFY( P_CURSOR              OUT  TYPES.TCURSOR
                              , W_SOB_ID              IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                              , W_ORG_ID              IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                              , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
                              , W_CONNECT_LEVEL       IN   VARCHAR2 DEFAULT 'A'
                              , W_WORK_CORP_ID        IN   HRD_DAY_INTERFACE.CORP_ID%TYPE
                              , W_WORK_DATE           IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                              , W_APPROVE_STATUS      IN   HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
                              , W_WORK_TYPE_ID        IN   HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                              , W_FLOOR_ID            IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                              , W_PERSON_ID           IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                              );


       -- [출퇴근 조회] - 2011-07-26
       PROCEDURE SELECT_DAY_BEFORE_CURRENT_NEXT( P_CURSOR         OUT  TYPES.TCURSOR
                                               , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                               , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                               , W_WORK_DATE      IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                               , W_WORK_TYPE_ID   IN   HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                                               , W_FLOOR_ID       IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                                               , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                               );

       -- [출퇴근조회(SECOM후)] - 2011-08-06
       PROCEDURE SELECT_DAY_SECOM_AFTER( P_CURSOR         OUT  TYPES.TCURSOR
                                       , W_SOB_ID         IN   HRD_ATTEND_INTERFACE.SOB_ID%TYPE
                                       , W_ORG_ID         IN   HRD_ATTEND_INTERFACE.ORG_ID%TYPE
                                       , W_WORK_DATE_FR   IN   HRD_ATTEND_INTERFACE.IO_DATETIME%TYPE
                                       , W_WORK_DATE_TO   IN   HRD_ATTEND_INTERFACE.IO_DATETIME%TYPE
                                       , W_FLOOR_ID       IN   HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                       , W_WORK_TYPE_ID   IN   HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                       , W_PERSON_ID      IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
                                       );


       -- [출퇴근조회(기간별)] - 2011-07-26
       PROCEDURE SELECT_DAY_PERIOD( P_CURSOR         OUT  TYPES.TCURSOR
                                  , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                  , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                  , W_WORK_DATE_FR   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                  , W_WORK_DATE_TO   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                  , W_FLOOR_ID       IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                                  , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                  );


       -- [출퇴근조회(개인별)] - 2011-07-27
       PROCEDURE SELECT_DAY_PERIOD_USER_BEFORE( P_CURSOR         OUT  TYPES.TCURSOR
                                              , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                              , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                              , W_WORK_DATE_FR   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                              , W_WORK_DATE_TO   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                              , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                              );

       -- [출퇴근조회(개인별)] - 2011-08-06
       PROCEDURE SELECT_DAY_PERIOD_USER_AFTER( P_CURSOR         OUT  TYPES.TCURSOR
                                             , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                             , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                             , W_WORK_DATE_FR   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                             , W_WORK_DATE_TO   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                             , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                             );


       -- DEFAULT DATE TIME - 2011-07-15
       PROCEDURE WORK_IO_TIME_F( W_WORK_TYPE                         IN VARCHAR2
                               , W_HOLY_TYPE                         IN VARCHAR2
                               , W_WORK_DATE                         IN DATE
                               , W_SOB_ID                            IN NUMBER
                               , W_ORG_ID                            IN NUMBER
                               , O_OPEN_TIME                         OUT DATE
                               , O_CLOSE_TIME                        OUT DATE
                               );


-- 휴일근무 계획표.
  PROCEDURE SELECT_OT_PLAN
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            );
            
-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_PERSON_ID                         IN HRD_DAY_MODIFY.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_MODIFY.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , O_APPROVE_STATUS                    OUT VARCHAR2
            , O_APPROVE_STATUS_NAME               OUT VARCHAR2
            );
                        
-- DATA UPDATE - STEP APPROVE.[2011-11-10]
  PROCEDURE DATA_UPDATE_APPROVE
           ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_WORK_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
      , P_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
            , P_CHECK_YN                          IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_FLAG                      IN VARCHAR2
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
      );

-- WORK DATE TIME 정리.
  PROCEDURE WORK_DATE
            ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
            , P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
            , P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
            , P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
            , P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
            , P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
            , O_WORK_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_WORK_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_REAL_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , O_REAL_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
            );

-- PROCEDURE PERIOD TIME.
  PROCEDURE LU_PERIOD_TIME
            ( P_CURSOR1                  OUT TYPES.TCURSOR1
            , W_WORK_DATE                IN HRD_DUTY_PERIOD.START_DATE%TYPE
            , W_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
            , W_CORP_ID                  IN HRD_DUTY_PERIOD.CORP_ID%TYPE
            , W_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
            , W_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
            , W_WORK_TYPE                IN HRM_COMMON.VALUE1%TYPE
            , W_START_YN                 IN HRM_COMMON.VALUE1%TYPE
            , W_END_YN                   HRM_COMMON.VALUE1%TYPE
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


       -- LOOKUP PERSON INFOMATION[2011-08-06]
       PROCEDURE LU_PERSON_DAY
               ( P_CURSOR3        OUT TYPES.TCURSOR3
               , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
               , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
               , W_FLOOR_ID       IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
               , W_WORK_TYPE_ID   IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
               );

-- [2011-10-31]
   PROCEDURE LU_SELECT_DUTY
           ( P_CURSOR3            OUT TYPES.TCURSOR3
           , W_SOB_ID             IN HRM_COMMON.SOB_ID%TYPE
           , W_ORG_ID             IN HRM_COMMON.ORG_ID%TYPE
           );


-- 현재 RECORD의 상태 리턴.
  PROCEDURE APPROVE_STATUS_R
	         ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
					 , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
					 , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
					 , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
					 , O_STATUS                              OUT HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
					 );

-- 현재 RECORD의 상태 리턴.
  PROCEDURE APPROVE_IO_YN_P
	         ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
					 , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
					 , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
           , W_IO_FLAG                             IN HRD_DAY_MODIFY.IO_FLAG%TYPE
					 , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
					 , O_IO_YN                               OUT HRD_DAY_INTERFACE.APPROVED_YN%TYPE
					 );
           
-- 현재 RECORD의 이첩여부 리턴.
  FUNCTION TRANSFER_YN_F
	         ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
					 , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
					 , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
					 , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
					 , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
					 ) RETURN VARCHAR2;



-- [출퇴등 승인 반려등록] [2011-11-10]
   PROCEDURE REJECT_SELECT_DAY( P_CURSOR              OUT  TYPES.TCURSOR
                              , W_SOB_ID              IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                              , W_ORG_ID              IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                              , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
                              , W_WORK_CORP_ID        IN   HRD_DAY_INTERFACE.CORP_ID%TYPE
                              , W_WORK_DATE           IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                              , W_APPROVE_STATUS      IN   HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
                              , W_WORK_TYPE_ID        IN   HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                              , W_FLOOR_ID            IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                              , W_PERSON_ID           IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                              );


-- 출퇴근 반려처리[2011-11-10]
   PROCEDURE REJECT_APPROVE_DAY
           ( W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_WORK_CORP_ID       IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_WORK_DATE          IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
           , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
           , P_APPROVE_STATUS     IN  HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
           , P_CHECK_YN           IN  VARCHAR2
           , P_REJECT_REMARK      IN  HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
           );

--------------------------
-- 일일 근태집계 현황   --
--------------------------
  PROCEDURE SELECT_DAY_INTERFACE_SUMMARY
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_WORK_CORP_ID          IN  NUMBER
            , W_CORP_ID               IN  NUMBER
            , W_WORK_DATE             IN  DATE
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_PRE_WORK_DATE_YN      IN  VARCHAR2
            , W_FLOOR_ID              IN  NUMBER
            , W_SORT_FLAG             IN  VARCHAR2 DEFAULT 'WC'
            , W_CONNECT_PERSON_ID     IN  NUMBER DEFAULT NULL
            );

-----------------------------------------
-- 일일 근태집계 현황 : 퇴직자 리스트  --
-----------------------------------------
  PROCEDURE SELECT_DAY_RETIRE_PERSON
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , W_WORK_CORP_ID          IN  NUMBER
            , W_CORP_ID               IN  NUMBER
            , W_WORK_DATE             IN  DATE
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_PRE_WORK_DATE_YN      IN  VARCHAR2
            , W_FLOOR_ID              IN  NUMBER
            , W_SORT_FLAG             IN  VARCHAR2 DEFAULT 'WC'
            , W_CONNECT_PERSON_ID     IN  NUMBER DEFAULT NULL
            );

-----------------------------------------
-- 일일 근태집계 현황 : 미출근자 리스트  --
-----------------------------------------
  PROCEDURE SELECT_DAY_NO_WORK_PERSON
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , W_WORK_CORP_ID          IN  NUMBER
            , W_CORP_ID               IN  NUMBER
            , W_WORK_DATE             IN  DATE
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_PRE_WORK_DATE_YN      IN  VARCHAR2
            , W_FLOOR_ID              IN  NUMBER
            , W_SORT_FLAG             IN  VARCHAR2 DEFAULT 'WC'
            , W_CONNECT_PERSON_ID     IN  NUMBER DEFAULT NULL
            );
            
END HRD_DAY_INTERFACE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_INTERFACE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_INTERFACE_G
/* DESCRIPTION  : 출퇴근 등록 관리 패키지.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- DAY INTERFACE SELECT
  PROCEDURE DATA_SELECT
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_IO_FLAG                           IN HRD_ATTEND_INTERFACE.IO_FLAG%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
      , W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
      , W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
      , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            )
  AS
   V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
  BEGIN
   -- 근태권한 설정.
    IF W_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;

    OPEN P_CURSOR FOR
      SELECT HRM_COMMON_G.CODE_NAME_F('IO_FLAG', W_IO_FLAG, DI.SOB_ID, DI.ORG_ID) AS IO_FLAG_NAME
      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
      , DI.PERSON_ID
      , PM.DISPLAY_NAME
      , DI.DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
      , DI.HOLY_TYPE
      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
      , CASE
               WHEN W_IO_FLAG = '2' AND (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y')
                 THEN NVL(O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
               WHEN W_IO_FLAG = '2' THEN NVL(O_DM.MODIFY_TIME, DI.CLOSE_TIME)
               ELSE CASE
                      WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                      ELSE DI.OPEN_TIME
                    END
             END AS MODIFY_TIME
           , CASE
               /*WHEN W_IO_FLAG = '2' AND (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y')
                 THEN N_DI.CLOSE_TIME1*/
               WHEN W_IO_FLAG = '2' THEN NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)
               ELSE CASE
                      WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                      ELSE DI.OPEN_TIME1
                    END
             END AS MODIFY_TIME1
      , DECODE(W_IO_FLAG, '1', I_DM.MODIFY_ID, O_DM.MODIFY_ID) AS MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(W_IO_FLAG, '1', I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
      , DI.NEXT_DAY_YN
           , DI.DANGJIK_YN
           , DI.ALL_NIGHT_YN
      , DI.LEAVE_ID
      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
      , DI.LEAVE_TIME_CODE
      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
      , DI.DESCRIPTION
      , DI.MODIFY_YN
      , DI.MODIFY_IN_YN
      , DI.MODIFY_OUT_YN
      , DI.MODIFY_FLAG AS MODIFY_FLAG
      , DI.TRANS_YN AS TRANS_YN
           , DI.APPROVE_STATUS
      , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
      , DI.WORK_DATE
      , DI.WORK_CORP_ID CORP_ID
      , W_IO_FLAG AS IO_FLAG
      , S_WC.HOLY_TYPE AS PRE_HOLY_TYPE
      , S_WC.DANGJIK_YN AS PRE_DANGJIK_YN
      , S_WC.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
           , CASE
               WHEN W_IO_FLAG = '2' AND (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y')
                 THEN N_DI.CLOSE_TIME
               WHEN W_IO_FLAG = '2' THEN DI.CLOSE_TIME
               ELSE DI.OPEN_TIME
             END AS IO_TIME
      , CASE
               WHEN W_IO_FLAG = '2' THEN DI.CLOSE_TIME1
               ELSE DI.OPEN_TIME1
             END AS IO_TIME1
      /*, CASE
        WHEN W_IO_FLAG = '1' THEN DI.OPEN_TIME
        ELSE DI.CLOSE_TIME
       END AS IO_TIME
      , CASE
        WHEN W_IO_FLAG = '1' THEN DI.OPEN_TIME1
        ELSE DI.CLOSE_TIME1
       END AS IO_TIME1*/
           , DI.WORK_TYPE_GROUP AS WORK_TYPE
   FROM HRD_DAY_INTERFACE_V DI
    , HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
        , HRM_POST_CODE_V PC
    , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.JOB_CATEGORY_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
    , HRD_DAY_MODIFY I_DM
    , HRD_DAY_MODIFY O_DM
    , (-- 전일 근무 정보 조회.
        SELECT WC.WORK_DATE + 1 AS WORK_DATE
             , WC.PERSON_ID
         , WC.CORP_ID
         , WC.SOB_ID
         , WC.ORG_ID
         , WC.HOLY_TYPE
         , WC.DANGJIK_YN
         , WC.ALL_NIGHT_YN
        FROM HRD_WORK_CALENDAR WC
            WHERE WC.WORK_DATE      = W_WORK_DATE - 1
        AND WC.PERSON_ID      = NVL(W_PERSON_ID, WC.PERSON_ID)
       AND WC.WORK_CORP_ID   = W_CORP_ID
       AND WC.SOB_ID         = W_SOB_ID
       AND WC.ORG_ID         = W_ORG_ID
     ) S_WC
        , (-- 후일 근무 정보 조회.
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI
   WHERE DI.PERSON_ID                          = PM.PERSON_ID
        AND PM.FLOOR_ID                           = HF.FLOOR_ID
        AND PM.POST_ID                            = PC.POST_ID
    AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
    AND DI.SOB_ID                             = PM.SOB_ID
    AND DI.ORG_ID                             = PM.ORG_ID
    AND PM.PERSON_ID                          = T1.PERSON_ID
    AND PM.PERSON_ID                          = T2.PERSON_ID
    AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
    AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
    AND '1'                                   = I_DM.IO_FLAG(+)
    AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
    AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
    AND '2'                                   = O_DM.IO_FLAG(+)
    AND DI.WORK_DATE                          = S_WC.WORK_DATE(+)
    AND DI.PERSON_ID                          = S_WC.PERSON_ID(+)
    AND DI.CORP_ID                            = S_WC.CORP_ID(+)
    AND DI.SOB_ID                             = S_WC.SOB_ID(+)
    AND DI.ORG_ID                             = S_WC.ORG_ID(+)
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
    AND DI.WORK_DATE                          = W_WORK_DATE
    AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
    AND DI.WORK_CORP_ID                       = W_CORP_ID
    AND DI.SOB_ID                             = W_SOB_ID
    AND DI.ORG_ID                             = W_ORG_ID
    AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
    AND T1.DEPT_ID                            = NVL(W_DEPT_ID, T1.DEPT_ID)
    AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
        AND PM.JOIN_DATE                          <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
            AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
            AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
            AND DM.START_DATE                              <= W_WORK_DATE
            AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
        --ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.PERSON_NUM
        ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.NAME
        ;

  END DATA_SELECT;

-- DAY INTERFACE MODIFY SELECT
  PROCEDURE DATA_SELECT_MODIFY
            ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
      , W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
      , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
   V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    V_USER_CAP                                    VARCHAR2(10);
  BEGIN
   -- 근태권한 설정.
    V_USER_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                                 , W_START_DATE => W_WORK_DATE
                                 , W_END_DATE => W_WORK_DATE
                                 , W_MODULE_CODE => '20'
                                 , W_PERSON_ID => W_CONNECT_PERSON_ID
                                 , W_SOB_ID => W_SOB_ID
                                 , W_ORG_ID => W_ORG_ID);

    IF V_USER_CAP = 'C' AND W_APPROVE_STATUS = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSIF W_APPROVE_STATUS = 'B'AND V_USER_CAP = 'C' THEN
        V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;

    OPEN P_CURSOR FOR
      SELECT 'N' AS CHECK_YN
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
      , DI.PERSON_ID
      , PM.DISPLAY_NAME
      , DI.DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
      , DI.HOLY_TYPE
      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
           , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
        ELSE DI.OPEN_TIME
       END AS OPEN_TIME
      , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
        ELSE DI.CLOSE_TIME
       END AS CLOSE_TIME
      , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
        ELSE DI.OPEN_TIME1
       END AS OPEN_TIME1
      , CASE
               --WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
        ELSE DI.CLOSE_TIME1
       END AS CLOSE_TIME1
      , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
      , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC
      , DI.NEXT_DAY_YN
           , DI.DANGJIK_YN
           , DI.ALL_NIGHT_YN
      , DI.LEAVE_ID
      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
      , DI.LEAVE_TIME_CODE
      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
      , DI.DESCRIPTION
      , DI.TRANS_YN AS TRANS_YN
      , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
      , DI.WORK_DATE
      , DI.WORK_CORP_ID CORP_ID
   FROM HRD_DAY_INTERFACE_V DI
    , HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
        , HRM_POST_CODE_V PC
    , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.JOB_CATEGORY_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
    , HRD_DAY_MODIFY I_DM
    , HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회.
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI
   WHERE DI.PERSON_ID                          = PM.PERSON_ID
    AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
    AND DI.SOB_ID                             = PM.SOB_ID
    AND DI.ORG_ID                             = PM.ORG_ID
        AND PM.FLOOR_ID                           = HF.FLOOR_ID
        AND PM.POST_ID                            = PC.POST_ID
    AND PM.PERSON_ID                          = T1.PERSON_ID
    AND PM.PERSON_ID                          = T2.PERSON_ID
    AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
    AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
    AND '1'                                   = I_DM.IO_FLAG(+)
    AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
    AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
    AND '2'                                   = O_DM.IO_FLAG(+)
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
    AND DI.WORK_DATE                          = W_WORK_DATE
    AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
    AND DI.WORK_CORP_ID                       = W_CORP_ID
    AND DI.SOB_ID                             = W_SOB_ID
    AND DI.ORG_ID                             = W_ORG_ID
    AND DI.APPROVE_STATUS                     = NVL(W_APPROVE_STATUS, DI.APPROVE_STATUS)
    AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
    AND T1.DEPT_ID                            = NVL(W_DEPT_ID, T1.DEPT_ID)
    AND DI.MODIFY_FLAG                        = 'Y'
        AND PM.JOIN_DATE                          <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.WORK_CORP_ID)
            AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
            AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
            AND DM.START_DATE                              <= W_WORK_DATE
            AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
        --ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.PERSON_NUM
        ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.NAME
        ;

 END DATA_SELECT_MODIFY;

-- DAY INTERFACE LONG TYPE SELECT
  PROCEDURE DATA_SELECT_L
           ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
      , W_DEPT_ID                           IN HRD_DAY_INTERFACE.DEPT_ID%TYPE
      , W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
      , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
   V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
   -- 근태권한 설정.
  IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                             , W_START_DATE => W_WORK_DATE
                , W_END_DATE => W_WORK_DATE
                , W_MODULE_CODE => '20'
                , W_PERSON_ID => W_CONNECT_PERSON_ID
                , W_SOB_ID => W_SOB_ID
                , W_ORG_ID => W_ORG_ID) = 'C' THEN
    V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;

    OPEN P_CURSOR FOR
      SELECT HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID) AS DEPT_NAME
      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID) AS POST_NAME
      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
      , DI.PERSON_ID
      , PM.DISPLAY_NAME
      , DI.DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
      , DI.HOLY_TYPE
      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
      , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
        ELSE DI.OPEN_TIME
       END AS OPEN_TIME
      , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
        ELSE DI.CLOSE_TIME
       END AS CLOSE_TIME
      , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
        ELSE DI.OPEN_TIME1
       END AS OPEN_TIME1
      , CASE
               /*WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1*/
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
        ELSE DI.CLOSE_TIME1
       END AS CLOSE_TIME1
      , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
      , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC
      , DI.NEXT_DAY_YN
      , DI.LEAVE_ID
      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
      , DI.LEAVE_TIME_CODE
      , HRM_COMMON_G.CODE_NAME_F('LEAVE_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
      , DI.DESCRIPTION
      , DI.MODIFY_YN
      , DI.MODIFY_IN_YN
      , DI.MODIFY_OUT_YN
      , DI.MODIFY_FLAG AS MODIFY_FLAG
      , DI.TRANS_YN AS TRANS_YN
      , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
      , DI.WORK_DATE
      , DI.WORK_CORP_ID CORP_ID
      , 'N' AS CHECK_YN
   FROM HRD_DAY_INTERFACE_V DI
    , HRM_PERSON_MASTER PM
    , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.JOB_CATEGORY_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
    , HRD_DAY_MODIFY I_DM
    , HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회.
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI
   WHERE DI.PERSON_ID                          = PM.PERSON_ID
    AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
    AND DI.SOB_ID                             = PM.SOB_ID
    AND DI.ORG_ID                             = PM.ORG_ID
    AND PM.PERSON_ID                          = T1.PERSON_ID
    AND PM.PERSON_ID                          = T2.PERSON_ID
    AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
    AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
    AND '1'                                   = I_DM.IO_FLAG(+)
    AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
    AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
    AND '2'                                   = O_DM.IO_FLAG(+)
        AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
        AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
        AND DI.SOB_ID                             = N_DI.SOB_ID(+)
        AND DI.ORG_ID                             = N_DI.ORG_ID(+)
    AND DI.WORK_DATE                          = W_WORK_DATE
    AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
    AND DI.WORK_CORP_ID                       = W_CORP_ID
    AND DI.SOB_ID                             = W_SOB_ID
    AND DI.ORG_ID                             = W_ORG_ID
    AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
    AND T1.DEPT_ID                            = NVL(W_DEPT_ID, T1.DEPT_ID)
    AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
            AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
            AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
            AND DM.START_DATE                              <= W_WORK_DATE
            AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
        ;

  END DATA_SELECT_L;

-- DAY INTERFACE HISTORY SELECT
  PROCEDURE DATA_SELECT_H
            ( P_CURSOR                            OUT TYPES.TCURSOR
      , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
   V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
   -- 근태권한 설정.
  IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
                             , W_START_DATE => W_WORK_DATE
                , W_END_DATE => W_WORK_DATE
                , W_MODULE_CODE => '20'
                , W_PERSON_ID => W_CONNECT_PERSON_ID
                , W_SOB_ID => W_SOB_ID
                , W_ORG_ID => W_ORG_ID) = 'C' THEN
    V_CONNECT_PERSON_ID := NULL;
  ELSE
    V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
  END IF;

    OPEN P_CURSOR FOR
      SELECT HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
      , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
        ELSE DI.OPEN_TIME
       END AS OPEN_TIME
      , CASE
               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
        ELSE DI.CLOSE_TIME
       END AS CLOSE_TIME
      , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
        ELSE DI.OPEN_TIME1
       END AS OPEN_TIME1
      , CASE
/*               WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN N_DI.CLOSE_TIME1*/
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
        ELSE DI.CLOSE_TIME1
       END AS CLOSE_TIME1
      , DI.NEXT_DAY_YN
      , DI.WORK_DATE
      , DI.WORK_CORP_ID CORP_ID
      , DI.DUTY_ID
      , DI.HOLY_TYPE
   FROM HRD_DAY_INTERFACE_V DI
    , HRM_PERSON_MASTER PM
    , (-- 시점 인사내역.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.JOB_CATEGORY_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
     ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
    , HRD_DAY_MODIFY I_DM
    , HRD_DAY_MODIFY O_DM
        , (-- 후일 근무 정보 조회.
          SELECT DIT.WORK_DATE - 1 AS WORK_DATE
               , DIT.PERSON_ID
               , DIT.CORP_ID
               , DIT.SOB_ID
               , DIT.ORG_ID
               , DIT.OPEN_TIME
               , DIT.CLOSE_TIME
               , DIT.OPEN_TIME1
               , DIT.CLOSE_TIME1
          FROM HRD_DAY_INTERFACE DIT
          WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
            AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
            AND DIT.WORK_CORP_ID  = W_CORP_ID
            AND DIT.SOB_ID        = W_SOB_ID
            AND DIT.ORG_ID        = W_ORG_ID
        ) N_DI
   WHERE DI.PERSON_ID                          = PM.PERSON_ID
     AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
     AND DI.SOB_ID                             = PM.SOB_ID
     AND DI.ORG_ID                             = PM.ORG_ID
     AND PM.PERSON_ID                          = T1.PERSON_ID
     AND PM.PERSON_ID                          = T2.PERSON_ID
     AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
     AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
     AND '1'                                   = I_DM.IO_FLAG(+)
     AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
     AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
     AND '2'                                   = O_DM.IO_FLAG(+)
     AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
     AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
     AND DI.SOB_ID                             = N_DI.SOB_ID(+)
     AND DI.ORG_ID                             = N_DI.ORG_ID(+)
     AND DI.WORK_DATE                          = W_WORK_DATE
     AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
     AND DI.WORK_CORP_ID                       = W_CORP_ID
     AND DI.SOB_ID                             = W_SOB_ID
     AND DI.ORG_ID                             = W_ORG_ID
     AND EXISTS (SELECT 'X'
                   FROM HRD_DUTY_MANAGER DM
             WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
              AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
             AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
             AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
             AND DM.START_DATE                              <= W_WORK_DATE
             AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
             AND DM.SOB_ID                                  = PM.SOB_ID
             AND DM.ORG_ID                                  = PM.ORG_ID
           )
         ;

 END DATA_SELECT_H;

-- DATA INSERT.
  PROCEDURE DATA_INSERT
           ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            )
  AS
  BEGIN
  NULL;

  END DATA_INSERT;




-- DATA UPDATE[2011-11-10]
   PROCEDURE DATA_UPDATE
           ( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
           , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
           , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_IO_FLAG              IN  HRD_DAY_MODIFY.IO_FLAG%TYPE
           , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
           , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , P_MODIFY_TIME          IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
           , P_MODIFY_TIME1         IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
           , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
           , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
           , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
           , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
           , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
           , P_IO_TIME              IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_IO_TIME1             IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
           , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
           , P_CONNECT_LEVEL        IN  VARCHAR2 DEFAULT 'A'
           , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
           , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
           , O_APPROVE_STATUS       OUT VARCHAR2
           , O_APPROVE_STATUS_NAME  OUT VARCHAR2
           , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
           , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
           , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
           , O_REJECT_PERSON_NAME   OUT VARCHAR2
           )

   AS

             V_SYSDATE                   HRD_DAY_INTERFACE.CREATION_DATE%TYPE;
             V_APPROVE_STATUS            HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE;
             V_IO_YN                     HRD_DAY_INTERFACE.APPROVED_YN%TYPE;

             V_A_DUTY_ID                 HRM_COMMON.COMMON_ID%TYPE;
             V_NA_DUTY_ID                HRM_COMMON.COMMON_ID%TYPE;
             V_H_DUTY_ID                 HRM_COMMON.COMMON_ID%TYPE;
             V_NH_DUTY_ID                HRM_COMMON.COMMON_ID%TYPE;
             V_PH_DUTY_ID                HRM_COMMON.COMMON_ID%TYPE;
             V_DUTY_ID                   HRM_COMMON.COMMON_ID%TYPE;

             -- 전일 정보.
             V_PRE_HOLY_TYPE             HRD_WORK_CALENDAR.HOLY_TYPE%TYPE;
             V_PRE_DANGJIK_YN            HRD_WORK_CALENDAR.DANGJIK_YN%TYPE;
             V_PRE_ALL_NIGHT_YN          HRD_WORK_CALENDAR.ALL_NIGHT_YN%TYPE;

             -- 금일 정보.
             V_HOLY_TYPE                 HRD_WORK_CALENDAR.HOLY_TYPE%TYPE;
             V_DANGJIK_YN                HRD_WORK_CALENDAR.DANGJIK_YN%TYPE;
             V_ALL_NIGHT_YN              HRD_WORK_CALENDAR.ALL_NIGHT_YN%TYPE;

             V_WORK_DATE                 HRD_DAY_MODIFY.WORK_DATE%TYPE;
             V_MODIFY_TIME               HRD_DAY_MODIFY.MODIFY_TIME%TYPE := NULL;
             V_MODIFY_YN                 HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'N';
             V_MODIFY_IO_YN              HRD_DAY_INTERFACE.MODIFY_IN_YN%TYPE := 'N';

             V_NEXT_DAY_YN               HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE;

             V_REJECT_YN                 HRD_DAY_INTERFACE.REJECT_YN%TYPE := 'N';

   BEGIN
             -- 기본값 설정.(근태기본값 : 결근)
             V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

             -- 현재 RECORD STATUS - 관리자에서 수정한 경우 제외.
             IF P_CONNECT_LEVEL = 'C' THEN
                V_APPROVE_STATUS := 'A';
             ELSE
                HRD_DAY_INTERFACE_G.APPROVE_STATUS_R( W_CORP_ID   => W_CORP_ID
                                                    , W_WORK_DATE => W_WORK_DATE
                                                    , W_PERSON_ID => W_PERSON_ID
                                                    , W_SOB_ID    => W_SOB_ID
                                                    , W_ORG_ID    => W_ORG_ID
                                                    , O_STATUS    => V_APPROVE_STATUS);
                APPROVE_IO_YN_P( W_CORP_ID
                               , W_WORK_DATE
                               , W_PERSON_ID
                               , W_IO_FLAG
                               , W_SOB_ID
                               , W_ORG_ID
                               , V_IO_YN
                               );
             END IF;

             BEGIN
              SELECT DI.REJECT_YN
                INTO V_REJECT_YN
                FROM HRD_DAY_INTERFACE   DI
               WHERE DI.PERSON_ID     =  W_PERSON_ID
                 AND DI.WORK_DATE     =  W_WORK_DATE
                 AND DI.WORK_CORP_ID  =  W_CORP_ID
                 AND DI.SOB_ID        =  W_SOB_ID
                 AND DI.ORG_ID        =  W_ORG_ID
                    ;
             EXCEPTION WHEN OTHERS THEN
               V_REJECT_YN := 'N';
             END;


             IF V_APPROVE_STATUS NOT IN('N', 'A') AND V_REJECT_YN = 'N' THEN
                IF V_APPROVE_STATUS IN('B') AND V_IO_YN = 'N' THEN
                   NULL;
                ELSE
                   RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Modify_Code, ERRNUMS.Invalid_Modify_DESC);
                   RETURN;
                END IF;
             END IF;

             -- 이첩 체크.
             V_APPROVE_STATUS := '-';
             V_APPROVE_STATUS := TRANSFER_YN_F( W_CORP_ID    => W_CORP_ID
                                               , W_WORK_DATE => W_WORK_DATE
                                               , W_PERSON_ID => W_PERSON_ID
                                               , W_SOB_ID    => W_SOB_ID
                                               , W_ORG_ID    => W_ORG_ID);
             IF V_APPROVE_STATUS = 'Y' THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10053', NULL));
                RETURN;
             END IF;

             BEGIN
                  SELECT MAX(DECODE(DC.ATTEND_FLAG, 'A', DC.DUTY_ID, NULL))  AS ATTEND
                       , MAX(DECODE(DC.ATTEND_FLAG, 'NA', DC.DUTY_ID, NULL)) AS NONATTEND
                       , MAX(DECODE(DC.ATTEND_FLAG, 'H', DC.DUTY_ID, NULL))  AS HOLIDAY
                       , MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS NONPAYHOLIDAY
                       , MAX(DECODE(DC.ATTEND_FLAG, 'PH', DC.DUTY_ID, NULL)) AS PAYHOLIDAY
                    INTO V_A_DUTY_ID
                       , V_NA_DUTY_ID
                       , V_H_DUTY_ID
                       , V_NH_DUTY_ID
                       , V_PH_DUTY_ID
                    FROM HRM_DUTY_CODE_V   DC
                   WHERE DC.ATTEND_FLAG    IS NOT NULL
                     AND DC.SOB_ID       = W_SOB_ID
                     AND DC.ORG_ID       = W_ORG_ID
                       ;
             EXCEPTION
                  WHEN OTHERS
                  THEN
                       RAISE_APPLICATION_ERROR(ERRNUMS.Duty_Not_Found_Code, ERRNUMS.Duty_Not_Found_Desc);
                       RETURN;
             END;
             IF V_A_DUTY_ID IS NULL OR V_NA_DUTY_ID IS NULL OR 
               V_H_DUTY_ID IS NULL OR V_NH_DUTY_ID IS NULL OR V_PH_DUTY_ID IS NULL THEN
               RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10045', '&&VALUE:=Duty Default Value(근태 기본값)&&TEXT:=Duty Code Check!(근태코드를 확인하세요)'));
               RETURN;
             END IF;
             
             BEGIN
                  -- 전일 근무계획 조회.
                  SELECT WC.HOLY_TYPE    AS PRE_HOLY_TYPE
                       , WC.DANGJIK_YN   AS PRE_DANGJIK_YN
                       , WC.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
                    INTO V_PRE_HOLY_TYPE
                       , V_PRE_DANGJIK_YN
                       , V_PRE_ALL_NIGHT_YN
                    FROM HRD_WORK_CALENDAR    WC
                   WHERE WC.WORK_DATE     = (W_WORK_DATE - 1)
                     AND WC.PERSON_ID     =  W_PERSON_ID
                     AND WC.SOB_ID        =  W_SOB_ID
                     AND WC.ORG_ID        =  W_ORG_ID
                  ;
             EXCEPTION
                  WHEN OTHERS
                  THEN
                       V_PRE_HOLY_TYPE    := '2';
                       V_PRE_DANGJIK_YN   := 'N';
                       V_PRE_ALL_NIGHT_YN := 'N';
             END;
             BEGIN
                  --  금일 근무계획 조회.
                  SELECT WC.HOLY_TYPE        AS HOLY_TYPE
                       , WC.DANGJIK_YN       AS DANGJIK_YN
                       , WC.ALL_NIGHT_YN     AS ALL_NIGHT_YN
                    INTO V_HOLY_TYPE
                       , V_DANGJIK_YN
                       , V_ALL_NIGHT_YN
                    FROM HRD_WORK_CALENDAR    WC
                   WHERE WC.WORK_DATE     = W_WORK_DATE
                     AND WC.PERSON_ID     =  W_PERSON_ID
                     AND WC.SOB_ID        =  W_SOB_ID
                     AND WC.ORG_ID        =  W_ORG_ID
                       ;
             EXCEPTION
                  WHEN OTHERS
                  THEN
                       V_HOLY_TYPE        := '2';
                       V_DANGJIK_YN       := 'N';
                       V_ALL_NIGHT_YN     := 'N';
             END;

             V_DANGJIK_YN := P_DANGJIK_YN;
             V_ALL_NIGHT_YN := P_ALL_NIGHT_YN;
             -- 근무일자 정리.
             V_WORK_DATE := W_WORK_DATE;
             IF V_WORK_DATE IS NULL THEN
               IF W_IO_FLAG = '2' AND (V_HOLY_TYPE = '3' OR P_DANGJIK_YN = 'Y' OR P_ALL_NIGHT_YN = 'Y') THEN
                 V_WORK_DATE := V_WORK_DATE;
               END IF;
             END IF;
              
             /*V_WORK_DATE := TRUNC(NVL(P_MODIFY_TIME, P_MODIFY_TIME1));
             IF V_WORK_DATE IS NULL THEN
                IF W_IO_FLAG = '2' AND V_HOLY_TYPE = '3' AND V_DANGJIK_YN = 'Y' AND V_ALL_NIGHT_YN = 'Y' THEN
                   V_WORK_DATE := W_WORK_DATE + 1;
                ELSE
                   V_WORK_DATE := W_WORK_DATE;
                END IF;
             END IF;*/

             BEGIN
                  -- 저장된 자료 조회.
                  SELECT DI.DUTY_ID
                       , DI.NEXT_DAY_YN
                    INTO V_DUTY_ID
                       , V_NEXT_DAY_YN
                    FROM HRD_DAY_INTERFACE  DI
                   WHERE DI.PERSON_ID     = W_PERSON_ID
                     AND DI.WORK_DATE     = W_WORK_DATE
                     AND DI.SOB_ID        = W_SOB_ID
                     AND DI.ORG_ID        = W_ORG_ID
                       ;
             EXCEPTION
                  WHEN OTHERS
                  THEN
                       V_DUTY_ID     := V_NA_DUTY_ID;
                       V_NEXT_DAY_YN := 'N';
             END;


/*
RAISE_APPLICATION_ERROR(-20001, W_PERSON_ID || ' | '  || W_IO_FLAG || ' | '  || 
                                ' | ' || TO_CHAR(P_IO_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                                ' | ' ||  TO_CHAR(P_MODIFY_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                                ' | ' ||  TO_CHAR(P_MODIFY_TIME1, 'YYYY-MM-DD HH24:MI:SS') || 
                                ' | ' ||  TO_CHAR(P_IO_TIME1, 'YYYY-MM-DD HH24:MI:SS')
                        );
*/



 -----------------------------------------------------------------------------------------
 -- 전산 자료 조회. : 수정 시간하고 동일할 경우 출퇴근수정에 INSERT/UPDATE하지 않음.
     IF W_IO_FLAG = '1' THEN
       -- 근태코드 설정 **
       SELECT /*CASE
             WHEN WORKDATA_CUR.P_DUTY_CODE IN('00', '11', '53', '40') THEN*/
             CASE
               WHEN V_HOLY_TYPE IN('0', '1') THEN
                 CASE
                   WHEN (V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y')
                     AND (V_ALL_NIGHT_YN = 'Y' OR V_DANGJIK_YN = 'Y' OR V_HOLY_TYPE = '3') THEN V_PH_DUTY_ID  -- 전일철야/당직, 금일 철야.
                   WHEN P_MODIFY_TIME IS NOT NULL THEN V_PH_DUTY_ID                               -- 휴일근무.
                   WHEN V_HOLY_TYPE = '0' THEN V_NH_DUTY_ID                                       -- 무급휴일.
                   ELSE V_H_DUTY_ID                                                               -- 휴일.
                 END
               ELSE                                                                               -- 주간/야간.
                 CASE
                   WHEN V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y' THEN V_A_DUTY_ID       -- 전일철야/전일당직 정상근무.
                   WHEN (V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y')
                     AND (V_ALL_NIGHT_YN = 'Y' OR V_DANGJIK_YN = 'Y') THEN V_A_DUTY_ID            -- 전일철야/당직, 금일 철야.
                   WHEN P_MODIFY_TIME IS NOT NULL  THEN V_A_DUTY_ID                               -- 출근기록 있음.
                   ELSE V_NA_DUTY_ID                                                              -- 출근기록 없음.
                 END
             END
             /*ELSE WORKDATA_CUR.P_DUTY_CODE
             END*/ AS DUTY_ID
         INTO V_DUTY_ID
         FROM DUAL;

       IF P_MODIFY_TIME IS NULL AND P_MODIFY_TIME1 IS NULL AND P_MODIFY_ID IS NULL THEN
         V_MODIFY_IO_YN := 'N';
         -- 기존자료 삭제.
         DELETE FROM HRD_DAY_MODIFY DM
         WHERE DM.PERSON_ID         = W_PERSON_ID
           AND DM.WORK_DATE         = W_WORK_DATE
          AND DM.IO_FLAG            = W_IO_FLAG
          ;
       ELSIF NVL(P_IO_TIME, V_SYSDATE) = NVL(P_MODIFY_TIME, V_SYSDATE)
         AND NVL(P_IO_TIME1, V_SYSDATE) = NVL(P_MODIFY_TIME1, V_SYSDATE) THEN
         V_MODIFY_IO_YN := 'N';
       ELSE
         BEGIN
           -- 출근시간 저장.
           UPDATE HRD_DAY_MODIFY DM
           SET DM.MODIFY_TIME                     = P_MODIFY_TIME
            , DM.MODIFY_TIME1                     = P_MODIFY_TIME1
            , DM.MODIFY_ID                        = P_MODIFY_ID
            , DM.DESCRIPTION                      = P_DESCRIPTION
            , DM.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(W_SOB_ID)
            , DM.LAST_UPDATED_BY                  = P_USER_ID
           WHERE DM.PERSON_ID                     = W_PERSON_ID
             AND DM.WORK_DATE                     = V_WORK_DATE
             AND DM.IO_FLAG                       = W_IO_FLAG
           ;
         END;
         IF (SQL%NOTFOUND)THEN
         -- 기존 데이터 없음 --> INSERT.
           INSERT INTO HRD_DAY_MODIFY
           (PERSON_ID, WORK_DATE, IO_FLAG
           , MODIFY_TIME, MODIFY_TIME1, MODIFY_ID
           , DESCRIPTION
           , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
           ) VALUES
           (W_PERSON_ID, V_WORK_DATE, W_IO_FLAG
           , P_MODIFY_TIME, P_MODIFY_TIME1, P_MODIFY_ID
           , P_DESCRIPTION
           , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
           );

           V_MODIFY_IO_YN := 'Y';
         ELSE
           V_MODIFY_IO_YN := 'Y';
         END IF;

       END IF;


/*
RAISE_APPLICATION_ERROR(-20001, W_PERSON_ID || 
                       ' | ' || W_IO_FLAG ||
                       ' | ' || V_DUTY_ID ||  
                       ' | ' || V_MODIFY_IO_YN || 
                       ' | ' || P_CONNECT_LEVEL || 
                       ' | ' || W_CONNECT_PERSON_ID
                        );
*/


       UPDATE HRD_DAY_INTERFACE DI
         SET DI.DUTY_ID                  = V_DUTY_ID
           , DI.MODIFY_IN_YN             = NVL(V_MODIFY_IO_YN, 'N')
           , DI.APPROVED_YN              = DECODE(V_MODIFY_IO_YN, 'Y',
                                             DECODE(P_CONNECT_LEVEL, 'C', 'Y',
                                               DECODE(W_IO_FLAG, '1', 'N', DI.APPROVED_YN)), 'N')
           , DI.APPROVED_DATE            = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
           --, DI.APPROVED_PERSON_ID       = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)
           , DI.APPROVED_PERSON_ID       = W_CONNECT_PERSON_ID
           , DI.APPROVED_OUT_YN          = DECODE(V_MODIFY_IO_YN, 'Y',
                                             DECODE(P_CONNECT_LEVEL, 'C', 'Y',
                                               DECODE(W_IO_FLAG, '2', 'N', DI.APPROVED_YN)), 'N')
           , DI.APPROVED_OUT_DATE        = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
           , DI.APPROVED_OUT_PERSON_ID   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)
           , DI.APPROVE_STATUS           = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', 'C', 'N'), 'N')
           , DI.CONFIRMED_YN             = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', 'Y', 'N'), 'N')
           , DI.CONFIRMED_DATE           = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
           --, DI.CONFIRMED_PERSON_ID      = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)
           , DI.CONFIRMED_PERSON_ID      = W_CONNECT_PERSON_ID
           , DI.EMAIL_STATUS             = 'N'
           , DI.ATTRIBUTE1               = P_CONNECT_LEVEL
           , DI.ATTRIBUTE2               = W_CONNECT_PERSON_ID
       WHERE DI.PERSON_ID                = W_PERSON_ID
         AND DI.WORK_DATE                = W_WORK_DATE
         AND DI.SOB_ID                   = W_SOB_ID
         AND DI.ORG_ID                   = W_ORG_ID
       ;

 -----------------------------------------------------------------------------------------
     ELSIF W_IO_FLAG = '2' THEN
       -- 근태코드 설정 **
       SELECT /*CASE
              WHEN WORKDATA_CUR.P_DUTY_CODE IN('00', '11', '53', '40') THEN*/
              CASE
                WHEN V_HOLY_TYPE IN('0', '1') THEN
                  CASE
                    WHEN V_PRE_HOLY_TYPE = '3' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID     -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근.
                    WHEN V_PRE_HOLY_TYPE = 'N' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '08:00' THEN V_PH_DUTY_ID     -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근.
                    WHEN V_PRE_ALL_NIGHT_YN = 'Y' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID  -- 휴일 : 전일 철야, 금일 09:30 이후 퇴근.
                    WHEN V_PRE_DANGJIK_YN = 'Y' AND TO_CHAR(P_MODIFY_TIME, 'HH24:MI') >= '11:00' THEN V_PH_DUTY_ID    -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근.
                    WHEN V_HOLY_TYPE = '0' THEN V_NH_DUTY_ID                                                          -- 휴일 : 무급휴일.
                    ELSE V_H_DUTY_ID                                                                                  -- 휴일.
                  END
              ELSE V_DUTY_ID
              END
       /*ELSE WORKDATA_CUR.P_DUTY_CODE
       END*/ AS DUTY_ID
       INTO V_DUTY_ID
       FROM DUAL;

 /*DBMS_OUTPUT.PUT_LINE('P_IO_TIME : ' || TO_CHAR(P_IO_TIME, 'YYYY-MM-DD HH24:MI:SS')
                      || ', P_IO_TIME1 : ' || TO_CHAR(P_IO_TIME1, 'YYYY-MM-DD HH24:MI:SS')
            || ', P_MODIFY_TIME : ' || TO_CHAR(P_MODIFY_TIME, 'YYYY-MM-DD HH24:MI:SS')
                      || ', P_MODIFY_TIME : ' || TO_CHAR(P_MODIFY_TIME1, 'YYYY-MM-DD HH24:MI:SS'));*/
       IF P_MODIFY_TIME IS NULL AND P_MODIFY_TIME1 IS NULL AND P_MODIFY_ID IS NULL THEN
         V_MODIFY_IO_YN := 'N';
         -- 기존자료 삭제.
         DELETE FROM HRD_DAY_MODIFY DM
         WHERE DM.PERSON_ID         = W_PERSON_ID
           AND DM.WORK_DATE         = W_WORK_DATE
           AND DM.IO_FLAG           = W_IO_FLAG
         ;
       ELSIF NVL(P_IO_TIME, V_SYSDATE) = NVL(P_MODIFY_TIME, V_SYSDATE)
         AND NVL(P_IO_TIME1, V_SYSDATE) = NVL(P_MODIFY_TIME1, V_SYSDATE) THEN
         V_MODIFY_IO_YN := 'N';
 -- 후일 퇴근 적용.
         IF P_NEXT_DAY_YN = 'Y' THEN
           V_MODIFY_TIME := NULL;
           FOR C1 IN ( SELECT AI.DEVICE_ID
                           , AI.IO_FLAG
                           , AI.PERSON_ID
                           , AI.CARD_NUM
                           , AI.IO_DATETIME
                           , AI.IO_DATE
                           , AI.IO_TIME
                           , AI.CREATED_FLAG
                         FROM HRD_ATTEND_INTERFACE AI
                         WHERE AI.PERSON_ID                               = W_PERSON_ID
                          AND AI.IO_DATE                                 = W_WORK_DATE + 1
                          AND AI.IO_FLAG                                 = W_IO_FLAG
                        ORDER BY AI.IO_DATETIME
                        )
           LOOP
             IF V_MODIFY_TIME IS NULL THEN
              V_MODIFY_TIME := C1.IO_DATETIME;
             END IF;
           END LOOP C1;
           V_MODIFY_YN := 'Y';
         ELSE
           V_MODIFY_YN := 'N';
         END IF;
       ELSE
         BEGIN
           -- 퇴근시간 저장.
           UPDATE HRD_DAY_MODIFY DM
             SET DM.MODIFY_TIME                    = P_MODIFY_TIME
              , DM.MODIFY_TIME1                   = P_MODIFY_TIME1
              , DM.MODIFY_ID                      = P_MODIFY_ID
              , DM.DESCRIPTION                    = P_DESCRIPTION
              , DM.LAST_UPDATE_DATE               = GET_LOCAL_DATE(W_SOB_ID)
              , DM.LAST_UPDATED_BY                = P_USER_ID
           WHERE DM.PERSON_ID                      = W_PERSON_ID
             AND DM.WORK_DATE                      = W_WORK_DATE
             AND DM.IO_FLAG                        = W_IO_FLAG
           ;
         END;
         IF (SQL%NOTFOUND)THEN
         -- 기존 데이터 없음 --> INSERT.
           INSERT INTO HRD_DAY_MODIFY
           (PERSON_ID, WORK_DATE, IO_FLAG
           , MODIFY_TIME, MODIFY_TIME1, MODIFY_ID
           , DESCRIPTION
           , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
           ) VALUES
           (W_PERSON_ID, W_WORK_DATE, W_IO_FLAG
           , P_MODIFY_TIME, P_MODIFY_TIME1, P_MODIFY_ID
           , P_DESCRIPTION
           , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
           );
           V_MODIFY_IO_YN := 'Y';
         ELSE
           V_MODIFY_IO_YN := 'Y';
         END IF;
       END IF;

       -- 수정 FLAG.
       IF P_LEAVE_ID IS NOT NULL OR P_LEAVE_TIME_CODE IS NOT NULL THEN
        V_MODIFY_YN := 'Y';
       END IF;

       UPDATE HRD_DAY_INTERFACE DI
         SET DI.CLOSE_TIME                       = NVL(DI.CLOSE_TIME, V_MODIFY_TIME)
           , DI.CLOSE_TIME1                      = DECODE(DI.CLOSE_TIME, NULL, DI.CLOSE_TIME1, V_MODIFY_TIME)
           , DI.NEXT_DAY_YN                      = NVL(P_NEXT_DAY_YN, 'N')
           , DI.DANGJIK_YN                       = NVL(V_DANGJIK_YN, 'N')
           , DI.ALL_NIGHT_YN                     = NVL(V_ALL_NIGHT_YN, 'N')
           , DI.LEAVE_ID                         = P_LEAVE_ID
           , DI.LEAVE_TIME_CODE                  = P_LEAVE_TIME_CODE
           , DI.MODIFY_YN                        = NVL(V_MODIFY_YN, 'N')
           , DI.MODIFY_OUT_YN                    = NVL(V_MODIFY_IO_YN, 'N')
           , DI.APPROVED_YN                      = DECODE(V_MODIFY_IO_YN, 'Y',
                                                     DECODE(P_CONNECT_LEVEL, 'C', 'Y',
                                                   DECODE(W_IO_FLAG, '1', 'N', DI.APPROVED_YN)), 'N')
           , DI.APPROVED_DATE                    = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
           --, DI.APPROVED_PERSON_ID               = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)
           , DI.APPROVED_PERSON_ID               = W_CONNECT_PERSON_ID
           , DI.APPROVED_OUT_YN                  = DECODE(V_MODIFY_IO_YN, 'Y',
                                                     DECODE(P_CONNECT_LEVEL, 'C', 'Y',
                                                       DECODE(W_IO_FLAG, '2', 'N', DI.APPROVED_YN)), 'N')
           , DI.APPROVED_OUT_DATE                = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
           , DI.APPROVED_OUT_PERSON_ID           = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)
           , DI.APPROVE_STATUS                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', 'C', 'N'), 'N')
           , DI.CONFIRMED_YN                     = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', 'Y', 'N'), 'N')
           , DI.CONFIRMED_DATE                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
           --, DI.CONFIRMED_PERSON_ID              = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(P_CONNECT_LEVEL, 'C', W_CONNECT_PERSON_ID, NULL), NULL)
           , DI.CONFIRMED_PERSON_ID              = W_CONNECT_PERSON_ID
           , DI.EMAIL_STATUS                     = 'N'
           , DI.DESCRIPTION                      = P_DESCRIPTION
           , DI.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DI.SOB_ID)
           , DI.LAST_UPDATED_BY                  = P_USER_ID
           , DI.ATTRIBUTE1                       = P_CONNECT_LEVEL
           , DI.ATTRIBUTE2                       = W_CONNECT_PERSON_ID
       WHERE DI.PERSON_ID                        = W_PERSON_ID
         AND DI.WORK_DATE                        = W_WORK_DATE
         AND DI.SOB_ID                           = W_SOB_ID
         AND DI.ORG_ID                           = W_ORG_ID
       ;
     END IF;
     
     -- 변경된 근태ID, 근태명 반환.
     BEGIN
       SELECT DC.DUTY_ID, DC.DUTY_NAME
         INTO O_DUTY_ID, O_DUTY_NAME
       FROM HRM_DUTY_CODE_V DC
       WHERE DC.DUTY_ID     = DECODE(V_MODIFY_YN, 'Y', V_DUTY_ID, DECODE(V_MODIFY_IO_YN, 'Y', V_DUTY_ID, W_DUTY_ID))
       ;
     EXCEPTION WHEN OTHERS THEN
       O_DUTY_ID := NULL;
       O_DUTY_NAME := NULL;
     END;

     -- 승인상태 조회.
     BEGIN
       SELECT DI.APPROVE_STATUS
            , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
         INTO O_APPROVE_STATUS
            , O_APPROVE_STATUS_NAME
         FROM HRD_DAY_INTERFACE DI
    WHERE DI.PERSON_ID                       = W_PERSON_ID
     AND DI.WORK_DATE                        = W_WORK_DATE
     AND DI.WORK_CORP_ID                     = W_CORP_ID
     AND DI.SOB_ID                           = W_SOB_ID
     AND DI.ORG_ID                           = W_ORG_ID
     ;
     EXCEPTION
       WHEN OTHERS THEN
         O_APPROVE_STATUS := 'N';
         O_APPROVE_STATUS_NAME := '승인미요청';
     END;


     --[2011-11-10]
     IF V_REJECT_YN = 'Y' THEN
        UPDATE HRD_DAY_INTERFACE DI
           SET DI.REJECT_REMARK       = NULL
             , DI.REJECT_YN           = 'N'
             , DI.REJECT_DATE         = NULL
             , DI.REJECT_PERSON_ID    = NULL
             , DI.ATTRIBUTE3          = DI.REJECT_PERSON_ID
         WHERE DI.PERSON_ID           = W_PERSON_ID
           AND DI.WORK_DATE           = W_WORK_DATE
           AND DI.SOB_ID              = W_SOB_ID
           AND DI.ORG_ID              = W_ORG_ID
             ;
     END IF;

             BEGIN
                  SELECT DI.REJECT_REMARK
                       , DI.REJECT_YN
                       , DI.REJECT_DATE
                       , HRM_PERSON_MASTER_G.NAME_F(DI.REJECT_PERSON_ID)
                    INTO O_REJECT_REMARK
                       , O_REJECT_YN
                       , O_REJECT_DATE
                       , O_REJECT_PERSON_NAME
                    FROM HRD_DAY_INTERFACE   DI
                   WHERE DI.SOB_ID        =  W_SOB_ID
                     AND DI.ORG_ID        =  W_ORG_ID
                     AND DI.WORK_DATE     =  W_WORK_DATE
                     AND DI.PERSON_ID     =  W_PERSON_ID
                       ;
                 EXCEPTION WHEN OTHERS THEN
                   O_REJECT_YN           := 'N';
                   O_REJECT_REMARK       := NULL;
                   O_REJECT_DATE         := NULL;
                   O_REJECT_PERSON_NAME  := NULL;
             END;

   END DATA_UPDATE;


-- DATA DELETE.
  PROCEDURE DATA_DELETE
           ( W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      )
  AS
 BEGIN
   NULL;
  END DATA_DELETE;



-- [출퇴근 등록] - 2011-07-14, [2011-08-11], [2011-11-10] 수정
   PROCEDURE SELECT_DAY( P_CURSOR             OUT TYPES.TCURSOR
                       , W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
                       , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
                       , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                       , W_MODIFY_YN          IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
                       , W_WORK_CORP_ID       IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
                       , W_WORK_DATE          IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
                       , W_WORK_TYPE_ID       IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                       , W_FLOOR_ID           IN  HRM_HISTORY_LINE.FLOOR_ID%TYPE
                       , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
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
                --V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID; --[2011-12-16]
                V_CONNECT_PERSON_ID := -1;
             END IF;

             OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                  , PM.PERSON_NUM AS PERSON_NUMBER
                  , PM.NAME       AS PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , DI.ALL_NIGHT_YN
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS OPEN_TIME
                  , CASE
                         -- 후일 퇴근기록 읽어오기(단, 수정사항이 있으면 수정사항 반영).
                         WHEN (DI.NEXT_DAY_YN   = 'Y'
                            OR DI.HOLY_TYPE    IN('N', '3')
                            OR DI.DANGJIK_YN    = 'Y'
                            OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                               FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                            ))
                         WHEN DI.HOLY_TYPE IN ('0', '1') 
                             AND DC.DUTY_CODE = '53' -- 휴일근무(1187)
                             AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) >
                                   TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                        FROM HRD_DAY_INTERFACE_V     S_DI
                                                                                       WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                         AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                         AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                         AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                         AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                     ))
                         WHEN S_WC.HOLY_TYPE = '3' -- 야간
                            AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                             OR DC.DUTY_CODE      = '12' -- 교육(1170)
                             OR DC.DUTY_CODE      = '20' -- 년차(1175)
                             OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                             OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)
                             OR DC.DUTY_CODE      = '17' -- 파견(1172)
                             OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)
                             OR DC.DUTY_CODE      = '18' -- 출장(1173)
                             OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                             OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                               ) THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 휴일(1188)
                                                   AND S_WC.ALL_NIGHT_YN =  'Y' THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                   AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                   AND DC.DUTY_CODE IN ( '18' -- 출장(1173)
                                                                       , '19' -- 경조휴가(1174)
                                                                       , '20' -- 년차(1175)
                                                                       , '22' -- 보건휴가(1177)
                                                                       , '23' -- 연중휴가(1178)
                                                                       , '24' -- 대체휴무(1179)
                                                                       , '52' -- 무급휴일(1182)
                                                                       , '53' -- 휴일근무(1187)
                                                                       , '51' -- 휴일(1188)
                                                                       , '54' -- 무급휴가(1189)
                                                                       , '55' -- 유급휴가(1190)
                                                                       , '79' -- 당직(1194)
                                                                       , '99' -- 철야(3784)
                                                                       )
                                                   AND ((SELECT HDC.DUTY_CODE
                                                            FROM HRD_DAY_INTERFACE_V     S_DI
                                                              , HRM_DUTY_CODE_V HDC
                                                           WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                             AND S_DI.SOB_ID        =  DI.SOB_ID
                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '53' -- 휴일근무(1187)
                                                        AND (S_WC.ALL_NIGHT_YN = 'Y'  -- 철야
                                                          OR S_WC.DANGJIK_YN = 'Y'    -- 당직.
                                                            )
                                                       ) THEN NULL
                        /* -- 전호수 수정 : 후일퇴근이어도 퇴근시간 있으면 모두 표시 조선미s 요청(2013-05-27) -- 
                         WHEN (SELECT S_DI.NEXT_DAY_YN
                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                              ) = 'Y' -- 후일퇴근
                                  AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                   OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                   OR DC.DUTY_CODE      = '20' -- 년차(1175)
                                   OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                   OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)
                                   OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                   OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)
                                   OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                   OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                   OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                     ) THEN NULL*/
                         WHEN DC.DUTY_CODE        = '00' -- 출근(1168)
                              AND (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE_V   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 후일퇴근
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                       ))
                         WHEN DC.DUTY_CODE        = '00' -- 출근(1168)
                              AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                              AND (SELECT S_DI.ALL_NIGHT_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 전일 철야
                                  THEN NULL
                         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                         ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                  , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '53' THEN '' -- 휴일근무(1187)
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 출근(1168)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 결근(1169)
                                                   AND DI.HOLY_TYPE  = '2' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 대체휴무(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 보건휴가(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 연중휴가(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                                    ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND(SELECT S_DI.HOLY_TYPE
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                      ) = '3' -- 야간
                                                   AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 대체휴무(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 보건휴가(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 연중휴가(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 출근(1168)
                                                   AND DI.HOLY_TYPE  = '3'  -- 야간
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                   AND DI.CLOSE_TIME IS NULL
                                                   AND DC.DUTY_CODE  =  '00' -- 출근(1168)
                                                   AND DI.HOLY_TYPE  = '3'   -- 야간
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DC.DUTY_CODE  =  '11' -- 결근(1169)
                                                   AND DI.HOLY_TYPE  = '3'   -- 야간
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                        ) IS NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                   AND DI.CLOSE_TIME   IS NULL
                                                   AND DC.DUTY_CODE    =  '53' -- 휴일근무(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                   AND DI.HOLY_TYPE    = '1'  -- 휴일
                                                   AND (SELECT S_DI.CLOSE_TIME
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                       ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 휴일(1188)
                                                   AND (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                          FROM HRD_DAY_INTERFACE_V   S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '22' -- 보건휴가(1177)
                                                   AND (SELECT DI.HOLY_TYPE
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = '3' THEN '' -- 야간
                         WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- 휴일근무(1187)
                                                         AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                         AND (SELECT S_DI.CLOSE_TIME
                                                                FROM HRD_DAY_INTERFACE_V     S_DI
                                                               WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                 AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                 AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                 AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                 AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                             ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 휴일근무
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V          HDC
                                                        WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 휴일근무(1187)
                                                   AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 대체휴무(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 보건휴가(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 연중휴가(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL
                                                   AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                                     OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                                     OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                                     OR DC.DUTY_CODE      = '24' -- 대체휴무(1179)
                                                     OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                                     OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                                     OR DC.DUTY_CODE      = '22' -- 보건휴가(1177)
                                                     OR DC.DUTY_CODE      = '23' -- 연중휴가(1178)
                                                     OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                                     OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                                     OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                                     OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                                     OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                                      ) THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DC.DUTY_CODE    =  '53' -- 휴일근무(1187)
                                                   AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                   AND DI.OPEN_TIME    IS NOT NULL
                                                   AND(SELECT S_DI.CLOSE_TIME
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                      ) IS NOT NULL THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                   AND DI.CLOSE_TIME   IS NOT NULL
                                                   AND(SELECT HDC.DUTY_CODE -- 휴일근무
                                                         FROM HRD_DAY_INTERFACE_V     S_DI
                                                           , HRM_DUTY_CODE_V        HDC
                                                        WHERE S_DI.DUTY_ID       =  HDC.DUTY_ID
                                                          AND S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = '53' -- 휴일근무(1187)
                                                   AND(SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                         FROM HRD_DAY_INTERFACE_V   S_DI
                                                        WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                          AND S_DI.ORG_ID        =  DI.ORG_ID
                                                          AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                          AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                          AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                      ) = 'Y' THEN ''
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND((SELECT S_DI.HOLY_TYPE    -- 야간
                                                          FROM HRD_DAY_INTERFACE   S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = '3'
                                                    OR (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                         WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                           AND S_DI.ORG_ID       = DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                           AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                       ) = 'Y') THEN ''
                         ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                    END  AS APPROVE_STATUS_NAME
                  , DI.REJECT_REMARK
                  , DI.MODIFY_FLAG AS MODIFY_FLAG
                  , DI.TRANS_YN    AS TRANS_YN
                  , DI.NEXT_DAY_YN
                  , DI.DANGJIK_YN
                  , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME1, DI.OPEN_TIME1) AS OPEN_TIME1
                  , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)                         AS CLOSE_TIME1
                  , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                  , DI.OPEN_TIME   AS IO_OPEN_TIME
                  , CASE
                        WHEN DI.NEXT_DAY_YN  =  'Y'
                          OR DI.HOLY_TYPE   IN ('3', 'N')
                          OR DI.DANGJIK_YN   =  'Y'
                          OR DI.ALL_NIGHT_YN =  'Y' THEN N_DI.CLOSE_TIME
                         WHEN (SELECT S_DI.HOLY_TYPE
                                 FROM HRD_DAY_INTERFACE S_DI
                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                              ) = '3' AND (DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                         OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                         OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                         OR DC.DUTY_CODE      = '24' -- 대체휴무(1179)
                                         OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                         OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                         OR DC.DUTY_CODE      = '22' -- 보건휴가(1177)
                                         OR DC.DUTY_CODE      = '23' -- 연중휴가(1178)
                                         OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                         OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                         OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                         OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                         OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                          ) THEN NULL
                        ELSE DI.CLOSE_TIME
                    END            AS IO_CLOSE_TIME
                  , DI.OPEN_TIME1  AS IO_OPEN_TIME1
                  , DI.CLOSE_TIME1 AS IO_CLOSE_TIME1
                  , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) AS CHECK_OPEN_TIME
                  , CASE
                         WHEN (DI.NEXT_DAY_YN   = 'Y'
                            OR DI.HOLY_TYPE    IN('N', '3')
                            OR DI.DANGJIK_YN    = 'Y'
                            OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                               FROM HRD_DAY_INTERFACE_V S_DI
                                                                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                            ))
                         WHEN DI.HOLY_TYPE IN ('0', '1') AND DC.DUTY_CODE    =  '53' -- 휴일근무(1187)
                                                         AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                        THEN DECODE(DI.MODIFY_OUT_YN
                                                                   , 'Y', O_DM.MODIFY_TIME
                                                                   , (SELECT S_DI.CLOSE_TIME
                                                                        FROM HRD_DAY_INTERFACE_V     S_DI
                                                                       WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                         AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                         AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                         AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                         AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                     ))
                         WHEN (SELECT S_DI.HOLY_TYPE
                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                              ) = '3' -- 야간
                                  AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                   OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                   OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                   OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                   OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                   OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                   OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                   OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                   OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                   OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                     ) THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE  = '51' -- 휴일(1188)
                                                   AND (SELECT S_DI.ALL_NIGHT_YN
                                                          FROM HRD_DAY_INTERFACE_V   S_DI
                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = 'Y' THEN NULL
                         WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                   AND DI.CLOSE_TIME IS NOT NULL
                                                   AND DC.DUTY_CODE IN ( '18' -- 출장(1173)
                                                                       , '19' -- 경조휴가(1174)
                                                                       , '20' -- 년차(1175)
                                                                       , '22' -- 보건휴가(1177)
                                                                       , '23' -- 연중휴가(1178)
                                                                       , '24' -- 대체휴무(1179)
                                                                       , '52' -- 무급휴일(1182)
                                                                       , '53' -- 휴일근무(1187)
                                                                       , '51' -- 휴일(1188)
                                                                       , '54' -- 무급휴가(1189)
                                                                       , '55' -- 유급휴가(1190)
                                                                       , '79' -- 당직(1194)
                                                                       , '99' -- 철야(3784)
                                                                       )
                                                   AND (SELECT HDC.DUTY_CODE
                                                          FROM HRD_DAY_INTERFACE_V     S_DI
                                                            , HRM_DUTY_CODE_V          HDC
                                                         WHERE S_DI.DUTY_ID       = HDC.DUTY_ID
                                                           AND S_DI.SOB_ID        =  DI.SOB_ID
                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                           AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                       ) = '53' THEN NULL -- 휴일근무(1187)
                         WHEN (SELECT S_DI.NEXT_DAY_YN
                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                              ) = 'Y' -- 후일퇴근
                                  AND(DC.DUTY_CODE      = '19' -- 경조휴가(1174)
                                   OR DC.DUTY_CODE      = '12' -- 교육(1170)
                                   OR DC.DUTY_CODE      = '20' -- 년차(1175)                                                     
                                   OR DC.DUTY_CODE      = '54' -- 무급휴가(1189)
                                   OR DC.DUTY_CODE      = '52' -- 무급휴일(1182)                                                     
                                   OR DC.DUTY_CODE      = '55' -- 유급휴가(1190)                                                     
                                   OR DC.DUTY_CODE      = '17' -- 파견(1172)
                                   OR DC.DUTY_CODE      = '18' -- 출장(1173)
                                   OR DC.DUTY_CODE      = '13' -- 훈련(1171)
                                   OR DC.DUTY_CODE      = '51' -- 휴일(1188)
                                     ) THEN NULL
                         WHEN DC.DUTY_CODE  =  '00' -- 출근(1168)
                              AND (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE_V   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 후일퇴근
                                  THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                          FROM HRD_DAY_INTERFACE_V S_DI
                                                                                         WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                           AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                           AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                           AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                           AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                       ))
                         WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                         ELSE DI.CLOSE_TIME
                    END AS CHECK_CLOSE_TIME
                  , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , DI.REJECT_YN AS REJECT_YN
                  , DI.REJECT_DATE
                  , HRM_PERSON_MASTER_G.NAME_F(DI.REJECT_PERSON_ID) AS REJECT_PERSON_NAME
                  , DI.DUTY_ID
                  , DI.HOLY_TYPE
                  , NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID) AS MODIFY_ID
                  , DI.MODIFY_YN
                  , DI.MODIFY_IN_YN
                  , DI.MODIFY_OUT_YN
                  , DI.APPROVE_STATUS
                  , DI.LEAVE_ID
                  , DI.LEAVE_TIME_CODE
                  , S_WC.HOLY_TYPE    AS PRE_HOLY_TYPE
                  , S_WC.DANGJIK_YN   AS PRE_DANGJIK_YN
                  , S_WC.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
                  , DI.WORK_TYPE_GROUP AS WORK_GROUP
                  , DI.WORK_DATE
                  , DI.DESCRIPTION
                  , DI.CORP_ID
                  , DI.WORK_CORP_ID
                  , DI.PERSON_ID
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_DUTY_CODE_V DC
                  , HRM_PERSON_MASTER PM
                  , HRM_FLOOR_V HF
                  , HRM_POST_CODE_V PC
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                          , HL.OCPT_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE             S_HL
                                                      WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                        AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                    ) T2
                  , HRD_DAY_MODIFY I_DM
                  , HRD_DAY_MODIFY O_DM
                  , (-- 전일 근무 정보 조회.
                     SELECT WC.WORK_DATE + 1 AS WORK_DATE
                          , WC.PERSON_ID
                          , WC.CORP_ID
                          , WC.SOB_ID
                          , WC.ORG_ID
                          , WC.HOLY_TYPE
                          , WC.DANGJIK_YN
                          , WC.ALL_NIGHT_YN
                       FROM HRD_WORK_CALENDAR   WC
                      WHERE WC.SOB_ID         = W_SOB_ID
                        AND WC.ORG_ID         = W_ORG_ID
                        AND WC.WORK_CORP_ID   = W_WORK_CORP_ID
                        AND WC.WORK_DATE      = W_WORK_DATE - 1
                        AND WC.PERSON_ID      = NVL(W_PERSON_ID, WC.PERSON_ID)
                    ) S_WC
                    , (-- 후일 근무 정보 조회.
                       SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                            , DIT.PERSON_ID
                            , DIT.CORP_ID
                            , DIT.SOB_ID
                            , DIT.ORG_ID
                            , DIT.OPEN_TIME
                            , DIT.CLOSE_TIME
                            , DIT.OPEN_TIME1
                            , DIT.CLOSE_TIME1
                         FROM HRD_DAY_INTERFACE   DIT
                        WHERE DIT.SOB_ID        = W_SOB_ID
                          AND DIT.ORG_ID        = W_ORG_ID
                          AND DIT.WORK_CORP_ID  = W_WORK_CORP_ID
                          AND DIT.WORK_DATE     = W_WORK_DATE + 1
                          AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
                      ) N_DI
              WHERE DI.DUTY_ID                                 = DC.DUTY_ID
                AND DI.PERSON_ID                               = PM.PERSON_ID
                AND PM.FLOOR_ID                                = HF.FLOOR_ID
                AND PM.POST_ID                                 = PC.POST_ID
                AND DI.WORK_CORP_ID                            = PM.WORK_CORP_ID
                AND DI.SOB_ID                                  = PM.SOB_ID
                AND DI.ORG_ID                                  = PM.ORG_ID
                AND PM.PERSON_ID                               = T1.PERSON_ID
                AND PM.PERSON_ID                               = T2.PERSON_ID
                AND DI.PERSON_ID                               = I_DM.PERSON_ID(+)
                AND DI.WORK_DATE                               = I_DM.WORK_DATE(+)
                AND '1'                                        = I_DM.IO_FLAG(+)
                AND DI.PERSON_ID                               = O_DM.PERSON_ID(+)
                AND DI.WORK_DATE                               = O_DM.WORK_DATE(+)
                AND '2'                                        = O_DM.IO_FLAG(+)
                AND DI.WORK_DATE                               = S_WC.WORK_DATE(+)
                AND DI.PERSON_ID                               = S_WC.PERSON_ID(+)
                AND DI.CORP_ID                                 = S_WC.CORP_ID(+)
                AND DI.SOB_ID                                  = S_WC.SOB_ID(+)
                AND DI.ORG_ID                                  = S_WC.ORG_ID(+)
                AND DI.WORK_DATE                               = N_DI.WORK_DATE(+)
                AND DI.PERSON_ID                               = N_DI.PERSON_ID(+)
                AND DI.SOB_ID                                  = N_DI.SOB_ID(+)
                AND DI.ORG_ID                                  = N_DI.ORG_ID(+)
                AND DI.WORK_DATE                               = W_WORK_DATE
                AND DI.PERSON_ID                               = NVL(W_PERSON_ID, DI.PERSON_ID)
                AND DI.WORK_CORP_ID                            = W_WORK_CORP_ID
                AND DI.SOB_ID                                  = W_SOB_ID
                AND DI.ORG_ID                                  = W_ORG_ID
                AND DI.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                AND T2.FLOOR_ID                                = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND DI.MODIFY_FLAG                             = NVL(W_MODIFY_YN, DI.MODIFY_FLAG)
                AND PM.JOIN_DATE                              <= W_WORK_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PM.WORK_CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                               AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.START_DATE                              <= W_WORK_DATE
                               AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
                               AND DM.SOB_ID                                   = PM.SOB_ID
                               AND DM.ORG_ID                                   = PM.ORG_ID
                           )
           ORDER BY PM.WORK_TYPE_ID
                  , T2.FLOOR_ID
                  , PM.NAME
                  ;

   END SELECT_DAY;


       -- [ 출퇴근 등록] 수정 - 2011-07-15 [2011-11-10]
       PROCEDURE UPDATE_DAY( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
                           , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
                           , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
                           , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
                           , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
                           , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
                           , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                           , P_OPEN_TIME            IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                           , P_OPEN_TIME1           IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                           , P_CLOSE_TIME           IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                           , P_CLOSE_TIME1          IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                           , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
                           , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
                           , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
                           , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
                           , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
                           , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
                           , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
                           , P_IO_OPEN_TIME         IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                           , P_IO_OPEN_TIME1        IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
                           , P_IO_CLOSE_TIME        IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                           , P_IO_CLOSE_TIME1       IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
                           , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
                           , P_CONNECT_LEVEL        IN  VARCHAR2 DEFAULT 'A'
                           , P_CHECK_OPEN_TIME      IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                           , P_CHECK_CLOSE_TIME     IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
                           , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
                           , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
                           , O_APPROVE_STATUS       OUT VARCHAR2
                           , O_APPROVE_STATUS_NAME  OUT VARCHAR2
                           , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
                           , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
                           , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
                           , O_REJECT_PERSON_NAME   OUT VARCHAR2
                           )

       AS
                 V_APPROVAL_STATUS    VARCHAR2(10) := 'N';
                 V_MODIFY_OPEN_YN     HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'Y';
                 V_MODIFY_CLOSE_YN    HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'Y';
                 V_MODIFY_ID          HRD_DAY_MODIFY.MODIFY_ID%TYPE;
                 
                 V_IO_FLAG  HRD_DAY_MODIFY.IO_FLAG%TYPE;
                 V_USER_CAP  VARCHAR2(10);

       BEGIN

            V_USER_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_CORP_ID
                                                  , W_START_DATE   =>  SYSDATE
                                                  , W_END_DATE     =>  SYSDATE
                                                  , W_MODULE_CODE  =>  '20'
                                                  , W_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                                  , W_SOB_ID       =>  W_SOB_ID
                                                  , W_ORG_ID       =>  W_ORG_ID);
            --권한이 없으면
            IF V_USER_CAP <> 'C' THEN
               RAISE_APPLICATION_ERROR(-20001, '권한이 없어서 수정할 수 없습니다.');
            END IF;
            
            BEGIN
              SELECT DI.APPROVE_STATUS
                INTO V_APPROVAL_STATUS
                FROM HRD_DAY_INTERFACE DI
              WHERE DI.PERSON_ID                        = W_PERSON_ID
                AND DI.WORK_DATE                        = W_WORK_DATE
                AND DI.SOB_ID                           = W_SOB_ID
                AND DI.ORG_ID                           = W_ORG_ID
              ;
            EXCEPTION WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001, '출퇴근 정보를 찾을수 없어 수정할 수 없습니다.'); 
            END;
            
            IF V_APPROVAL_STATUS NOT IN('N', 'A', 'R') THEN
              RAISE_APPLICATION_ERROR(-20001, '해당 자료는 이미 승인이 되어서 수정할 수 없습니다.'); 
            END IF;
            
            V_MODIFY_ID := P_MODIFY_ID;
            IF P_CHECK_OPEN_TIME = P_OPEN_TIME THEN
              V_MODIFY_OPEN_YN  := 'N';
            ELSIF P_OPEN_TIME IS NULL AND P_MODIFY_ID IS NULL THEN
              V_MODIFY_ID := NULL; --기존 입력된 일시를 삭제한 경우
              V_MODIFY_OPEN_YN  := 'N'; --HRD_DAY_MODIFY 테이블 자료 삭제를 위해
            ELSIF P_CHECK_OPEN_TIME IS NULL AND P_OPEN_TIME IS NULL THEN
              V_MODIFY_OPEN_YN  := 'N';
            ELSIF NVL(P_CHECK_OPEN_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) <> NVL(P_OPEN_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) THEN
              V_MODIFY_OPEN_YN  := 'Y';
            ELSIF P_MODIFY_ID IS NOT NULL THEN
              V_MODIFY_OPEN_YN := 'Y';
            ELSIF P_MODIFY_ID IS NULL THEN
              V_MODIFY_OPEN_YN := 'N';
            END IF;
            IF P_CHECK_CLOSE_TIME = P_CLOSE_TIME THEN
              V_MODIFY_CLOSE_YN := 'N';
            ELSIF P_CLOSE_TIME IS NULL AND P_MODIFY_ID IS NULL THEN
              V_MODIFY_ID := NULL; --기존 입력된 일시를 삭제한 경우
              V_MODIFY_CLOSE_YN := 'N'; --HRD_DAY_MODIFY 테이블 자료 삭제를 위해
            ELSIF P_CHECK_CLOSE_TIME IS NULL AND P_CLOSE_TIME IS NULL THEN
              V_MODIFY_CLOSE_YN  := 'N';
            ELSIF NVL(P_CHECK_CLOSE_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) <> NVL(P_CLOSE_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) THEN
              V_MODIFY_CLOSE_YN := 'Y';
            ELSIF P_MODIFY_ID IS NOT NULL THEN
              V_MODIFY_CLOSE_YN := 'Y';
            ELSIF P_MODIFY_ID IS NULL THEN
              V_MODIFY_CLOSE_YN := 'N';
            END IF;	
            
            -- 철야/당직 UPDATE --
            UPDATE HRD_DAY_INTERFACE DI
               SET DI.NEXT_DAY_YN                      = NVL(P_NEXT_DAY_YN, 'N')
                 , DI.DANGJIK_YN                       = NVL(P_DANGJIK_YN, 'N')
                 , DI.ALL_NIGHT_YN                     = NVL(P_ALL_NIGHT_YN, 'N')
                 , DI.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(DI.SOB_ID)
                 , DI.LAST_UPDATED_BY                  = P_USER_ID
             WHERE DI.PERSON_ID                        = W_PERSON_ID
               AND DI.WORK_DATE                        = W_WORK_DATE
               AND DI.SOB_ID                           = W_SOB_ID
               AND DI.ORG_ID                           = W_ORG_ID
             ;
             
            IF V_MODIFY_OPEN_YN = 'Y' THEN
                 V_IO_FLAG := 1; -- 출근

                 DATA_UPDATE( W_PERSON_ID            =>  W_PERSON_ID
                            , W_WORK_DATE            =>  W_WORK_DATE
                            , W_CORP_ID              =>  W_CORP_ID
                            , W_SOB_ID               =>  W_SOB_ID
                            , W_ORG_ID               =>  W_ORG_ID
                            , W_IO_FLAG              =>  V_IO_FLAG
                            , W_DUTY_ID              =>  W_DUTY_ID
                            , W_CONNECT_PERSON_ID    =>  W_CONNECT_PERSON_ID
                            , P_MODIFY_TIME          =>  P_OPEN_TIME
                            , P_MODIFY_TIME1         =>  P_OPEN_TIME1
                            , P_MODIFY_ID            =>  V_MODIFY_ID
                            , P_NEXT_DAY_YN          =>  P_NEXT_DAY_YN
                            , P_DANGJIK_YN           =>  P_DANGJIK_YN
                            , P_ALL_NIGHT_YN         =>  P_ALL_NIGHT_YN
                            , P_LEAVE_ID             =>  P_LEAVE_ID
                            , P_LEAVE_TIME_CODE      =>  P_LEAVE_TIME_CODE
                            , P_DESCRIPTION          =>  P_DESCRIPTION
                            , P_IO_TIME              =>  P_IO_OPEN_TIME
                            , P_IO_TIME1             =>  P_IO_OPEN_TIME1
                            , P_USER_ID              =>  P_USER_ID
                            , P_CONNECT_LEVEL        =>  P_CONNECT_LEVEL
                            , O_DUTY_ID              =>  O_DUTY_ID
                            , O_DUTY_NAME            =>  O_DUTY_NAME
                            , O_APPROVE_STATUS       =>  O_APPROVE_STATUS
                            , O_APPROVE_STATUS_NAME  =>  O_APPROVE_STATUS_NAME
                            , O_REJECT_REMARK        =>  O_REJECT_REMARK
                            , O_REJECT_YN            =>  O_REJECT_YN
                            , O_REJECT_DATE          =>  O_REJECT_DATE
                            , O_REJECT_PERSON_NAME   =>  O_REJECT_PERSON_NAME
                            );
            END IF;
            
            IF V_MODIFY_CLOSE_YN = 'Y' THEN
                 V_IO_FLAG := 2; -- 퇴근

                 DATA_UPDATE( W_PERSON_ID            =>  W_PERSON_ID
                            , W_WORK_DATE            =>  W_WORK_DATE
                            , W_CORP_ID              =>  W_CORP_ID
                            , W_SOB_ID               =>  W_SOB_ID
                            , W_ORG_ID               =>  W_ORG_ID
                            , W_IO_FLAG              =>  V_IO_FLAG
                            , W_DUTY_ID              =>  W_DUTY_ID
                            , W_CONNECT_PERSON_ID    =>  W_CONNECT_PERSON_ID
                            , P_MODIFY_TIME          =>  P_CLOSE_TIME
                            , P_MODIFY_TIME1         =>  P_CLOSE_TIME1
                            , P_MODIFY_ID            =>  V_MODIFY_ID
                            , P_NEXT_DAY_YN          =>  P_NEXT_DAY_YN
                            , P_DANGJIK_YN           =>  P_DANGJIK_YN
                            , P_ALL_NIGHT_YN         =>  P_ALL_NIGHT_YN
                            , P_LEAVE_ID             =>  P_LEAVE_ID
                            , P_LEAVE_TIME_CODE      =>  P_LEAVE_TIME_CODE
                            , P_DESCRIPTION          =>  P_DESCRIPTION
                            , P_IO_TIME              =>  P_IO_CLOSE_TIME
                            , P_IO_TIME1             =>  P_IO_CLOSE_TIME1
                            , P_USER_ID              =>  P_USER_ID
                            , P_CONNECT_LEVEL        =>  P_CONNECT_LEVEL
                            , O_DUTY_ID              =>  O_DUTY_ID
                            , O_DUTY_NAME            =>  O_DUTY_NAME
                            , O_APPROVE_STATUS       =>  O_APPROVE_STATUS
                            , O_APPROVE_STATUS_NAME  =>  O_APPROVE_STATUS_NAME
                            , O_REJECT_REMARK        =>  O_REJECT_REMARK
                            , O_REJECT_YN            =>  O_REJECT_YN
                            , O_REJECT_DATE          =>  O_REJECT_DATE
                            , O_REJECT_PERSON_NAME   =>  O_REJECT_PERSON_NAME
                            );
            END IF;
            
       END UPDATE_DAY;




       -- [ 출퇴근 등록 관리자] 수정 - 2011-09-27[2011-11-10]
       PROCEDURE UPDATE_DAY_C( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
                             , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
                             , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
                             , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
                             , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
                             , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
                             , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                             , P_DUTY_ID              IN  HRD_DAY_INTERFACE.DUTY_ID%TYPE
                             , P_OPEN_TIME            IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                             , P_OPEN_TIME1           IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                             , P_CLOSE_TIME           IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
                             , P_CLOSE_TIME1          IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
                             , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
                             , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
                             , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
                             , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
                             , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
                             , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
                             , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
                             , P_IO_OPEN_TIME         IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                             , P_IO_OPEN_TIME1        IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
                             , P_IO_CLOSE_TIME        IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
                             , P_IO_CLOSE_TIME1       IN  HRD_DAY_INTERFACE.CLOSE_TIME1%TYPE
                             , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
                             , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
                             , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
                             , O_APPROVE_STATUS       OUT VARCHAR2
                             , O_APPROVE_STATUS_NAME  OUT VARCHAR2
                             , P_CHECK_OPEN_TIME      IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
                             , P_CHECK_CLOSE_TIME     IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
                             , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
                             , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
                             , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
                             , O_REJECT_PERSON_NAME   OUT VARCHAR2
                             )


       AS

                 V_IO_FLAG        HRD_DAY_MODIFY.IO_FLAG%TYPE;

       BEGIN

                 UPDATE_DAY_IN_OUT( W_PERSON_ID            =>  W_PERSON_ID
                                  , W_WORK_DATE            =>  W_WORK_DATE
                                  , W_CORP_ID              =>  W_CORP_ID
                                  , W_SOB_ID               =>  W_SOB_ID
                                  , W_ORG_ID               =>  W_ORG_ID
                                  , W_DUTY_ID              =>  W_DUTY_ID
                                  , W_CONNECT_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                  , P_DUTY_ID              =>  P_DUTY_ID
                                  , P_MODIFY_OPEN_TIME     =>  P_OPEN_TIME
                                  , P_MODIFY_OPEN_TIME1    =>  P_OPEN_TIME1
                                  , P_MODIFY_CLOSE_TIME    =>  P_CLOSE_TIME
                                  , P_MODIFY_CLOSE_TIME1   =>  P_CLOSE_TIME1
                                  , P_MODIFY_ID            =>  P_MODIFY_ID
                                  , P_NEXT_DAY_YN          =>  P_NEXT_DAY_YN
                                  , P_DANGJIK_YN           =>  P_DANGJIK_YN
                                  , P_ALL_NIGHT_YN         =>  P_ALL_NIGHT_YN
                                  , P_LEAVE_ID             =>  P_LEAVE_ID
                                  , P_LEAVE_TIME_CODE      =>  P_LEAVE_TIME_CODE
                                  , P_DESCRIPTION          =>  P_DESCRIPTION
                                  , P_IO_OPEN_TIME         =>  P_IO_OPEN_TIME
                                  , P_IO_OPEN_TIME1        =>  P_IO_OPEN_TIME1
                                  , P_IO_CLOSE_TIME        =>  P_IO_CLOSE_TIME
                                  , P_IO_CLOSE_TIME1       =>  P_IO_CLOSE_TIME1
                                  , P_USER_ID              =>  P_USER_ID
                                  , O_DUTY_ID              =>  O_DUTY_ID
                                  , O_DUTY_NAME            =>  O_DUTY_NAME
                                  , O_APPROVE_STATUS       =>  O_APPROVE_STATUS
                                  , O_APPROVE_STATUS_NAME  =>  O_APPROVE_STATUS_NAME
                                  , P_CHECK_OPEN_TIME      =>  P_CHECK_OPEN_TIME
                                  , P_CHECK_CLOSE_TIME     =>  P_CHECK_CLOSE_TIME
                                  , O_REJECT_REMARK        =>  O_REJECT_REMARK
                                  , O_REJECT_YN            =>  O_REJECT_YN
                                  , O_REJECT_DATE          =>  O_REJECT_DATE
                                  , O_REJECT_PERSON_NAME   =>  O_REJECT_PERSON_NAME
                                  );


       END UPDATE_DAY_C;





-- DATA UPDATE[2011-09-27][2011-10-21][2011-11-10]
   PROCEDURE UPDATE_DAY_IN_OUT
           ( W_PERSON_ID            IN  HRD_DAY_MODIFY.PERSON_ID%TYPE
           , W_WORK_DATE            IN  HRD_DAY_MODIFY.WORK_DATE%TYPE
           , W_CORP_ID              IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_SOB_ID               IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID               IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_DUTY_ID              IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
           , W_CONNECT_PERSON_ID    IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , P_DUTY_ID              IN  HRD_DAY_INTERFACE.DUTY_ID%TYPE
           , P_MODIFY_OPEN_TIME     IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
           , P_MODIFY_OPEN_TIME1    IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
           , P_MODIFY_CLOSE_TIME    IN  HRD_DAY_MODIFY.MODIFY_TIME%TYPE
           , P_MODIFY_CLOSE_TIME1   IN  HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
           , P_MODIFY_ID            IN  HRD_DAY_MODIFY.MODIFY_ID%TYPE
           , P_NEXT_DAY_YN          IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
           , P_LEAVE_ID             IN  HRD_DAY_INTERFACE.LEAVE_ID%TYPE
           , P_LEAVE_TIME_CODE      IN  HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
           , P_DESCRIPTION          IN  HRD_DAY_INTERFACE.DESCRIPTION%TYPE
           , P_IO_OPEN_TIME         IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_IO_OPEN_TIME1        IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
           , P_IO_CLOSE_TIME        IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_IO_CLOSE_TIME1       IN  HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
           , P_USER_ID              IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
           , O_DUTY_ID              OUT HRM_COMMON.COMMON_ID%TYPE
           , O_DUTY_NAME            OUT HRM_COMMON.CODE_NAME%TYPE
           , O_APPROVE_STATUS       OUT VARCHAR2
           , O_APPROVE_STATUS_NAME  OUT VARCHAR2
           , P_CHECK_OPEN_TIME      IN  HRD_DAY_INTERFACE.OPEN_TIME%TYPE
           , P_CHECK_CLOSE_TIME     IN  HRD_DAY_INTERFACE.CLOSE_TIME%TYPE
           , O_REJECT_REMARK        OUT HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
           , O_REJECT_YN            OUT HRD_DAY_INTERFACE.REJECT_YN%TYPE
           , O_REJECT_DATE          OUT HRD_DAY_INTERFACE.REJECT_DATE%TYPE
           , O_REJECT_PERSON_NAME   OUT VARCHAR2
           )
   AS
           V_SYSDATE            HRD_DAY_INTERFACE.CREATION_DATE%TYPE;
           V_IO_YN              HRD_DAY_INTERFACE.APPROVED_YN%TYPE;

           V_A_DUTY_ID          HRM_COMMON.COMMON_ID%TYPE;
           V_NA_DUTY_ID         HRM_COMMON.COMMON_ID%TYPE;
           V_H_DUTY_ID          HRM_COMMON.COMMON_ID%TYPE;
           V_NH_DUTY_ID         HRM_COMMON.COMMON_ID%TYPE;
           V_PH_DUTY_ID         HRM_COMMON.COMMON_ID%TYPE;
           V_DUTY_ID            HRM_COMMON.COMMON_ID%TYPE;

           -- 전일 정보.
           V_PRE_HOLY_TYPE      HRD_WORK_CALENDAR.HOLY_TYPE%TYPE;
           V_PRE_DANGJIK_YN     HRD_WORK_CALENDAR.DANGJIK_YN%TYPE;
           V_PRE_ALL_NIGHT_YN   HRD_WORK_CALENDAR.ALL_NIGHT_YN%TYPE;

           -- 금일 정보.
           V_HOLY_TYPE          HRD_WORK_CALENDAR.HOLY_TYPE%TYPE;
           V_DANGJIK_YN         HRD_WORK_CALENDAR.DANGJIK_YN%TYPE;
           V_ALL_NIGHT_YN       HRD_WORK_CALENDAR.ALL_NIGHT_YN%TYPE;

           V_WORK_DATE          HRD_DAY_MODIFY.WORK_DATE%TYPE;
           V_MODIFY_TIME        HRD_DAY_MODIFY.MODIFY_TIME%TYPE := NULL;
           V_MODIFY_YN          HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'N';
           V_MODIFY_IO_YN       HRD_DAY_INTERFACE.MODIFY_IN_YN%TYPE := 'N';

           V_NEXT_DAY_YN        HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE;

           V_MODIFY_OPEN_YN     HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'Y';
           V_MODIFY_CLOSE_YN    HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'Y';

           V_MODIFY_ID          HRD_DAY_MODIFY.MODIFY_ID%TYPE;

           V_OPEN_TIME_CURRENT  HRD_DAY_INTERFACE.OPEN_TIME%TYPE;
           V_CLOSE_TIME_CURRENT HRD_DAY_INTERFACE.CLOSE_TIME%TYPE;

           V_TRANS_YN           HRD_DAY_INTERFACE.TRANS_YN%TYPE := 'N';
           V_DAY_LEAVE_ID       HRD_DAY_LEAVE.DAY_LEAVE_ID%TYPE := NULL;
           
           V_REJECT_YN          HRD_DAY_INTERFACE.REJECT_YN%TYPE := 'N';

   BEGIN
           -- 기본값 설정.(근태기본값 : 결근)
           V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
           V_MODIFY_ID := P_MODIFY_ID;

           IF P_CHECK_OPEN_TIME = P_MODIFY_OPEN_TIME THEN
              V_MODIFY_OPEN_YN  := 'N';
           ELSIF P_MODIFY_OPEN_TIME IS NULL AND P_MODIFY_ID IS NULL THEN
              V_MODIFY_ID := NULL; --기존 입력된 일시를 삭제한 경우
              V_MODIFY_OPEN_YN  := 'N'; --HRD_DAY_MODIFY 테이블 자료 삭제를 위해
           ELSIF P_CHECK_OPEN_TIME IS NULL AND P_MODIFY_OPEN_TIME IS NULL THEN
              V_MODIFY_OPEN_YN  := 'N';
           ELSIF NVL(P_CHECK_OPEN_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) <> NVL(P_MODIFY_OPEN_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) THEN
              V_MODIFY_OPEN_YN  := 'Y';
           ELSIF P_MODIFY_ID IS NOT NULL THEN
              V_MODIFY_OPEN_YN := 'Y';
           ELSIF P_MODIFY_ID IS NULL THEN
              V_MODIFY_OPEN_YN := 'N';
           END IF;
           IF P_CHECK_CLOSE_TIME = P_MODIFY_CLOSE_TIME THEN
              V_MODIFY_CLOSE_YN := 'N';
           ELSIF P_MODIFY_CLOSE_TIME IS NULL AND P_MODIFY_ID IS NULL THEN
              V_MODIFY_ID := NULL; --기존 입력된 일시를 삭제한 경우
              V_MODIFY_CLOSE_YN := 'N'; --HRD_DAY_MODIFY 테이블 자료 삭제를 위해
           ELSIF P_CHECK_CLOSE_TIME IS NULL AND P_MODIFY_CLOSE_TIME IS NULL THEN
              V_MODIFY_CLOSE_YN  := 'N';
           ELSIF NVL(P_CHECK_CLOSE_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) <> NVL(P_MODIFY_CLOSE_TIME, TO_DATE('2011-01-01', 'YYYY-MM-DD')) THEN
              V_MODIFY_CLOSE_YN := 'Y';
           ELSIF P_MODIFY_ID IS NOT NULL THEN
              V_MODIFY_CLOSE_YN := 'Y';
           ELSIF P_MODIFY_ID IS NULL THEN
              V_MODIFY_CLOSE_YN := 'N';
           END IF;
--RAISE_APPLICATION_ERROR(-20001, P_CHECK_OPEN_TIME || '\' || P_MODIFY_OPEN_TIME || '\' || V_MODIFY_OPEN_YN);
--RAISE_APPLICATION_ERROR(-20001, P_CHECK_CLOSE_TIME || '\' || P_MODIFY_CLOSE_TIME || '\' || V_MODIFY_CLOSE_YN);



/*
RAISE_APPLICATION_ERROR(-20001, W_PERSON_ID ||
                       ' | ' || TO_CHAR(P_CHECK_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                       ' | ' || TO_CHAR(P_MODIFY_OPEN_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                       ' | ' || TO_CHAR(P_CHECK_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                       ' | ' || TO_CHAR(P_MODIFY_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') || 
                       ' | ' || V_MODIFY_OPEN_YN ||
                       ' | ' || V_MODIFY_CLOSE_YN ||
                       ' | ' || P_MODIFY_ID ||
                       ' | ' || V_MODIFY_ID
                       );
*/



             --[2011-11-10]
             BEGIN
                  SELECT DI.REJECT_YN
                    INTO V_REJECT_YN
                    FROM HRD_DAY_INTERFACE   DI
                   WHERE DI.PERSON_ID     =  W_PERSON_ID
                     AND DI.WORK_DATE     =  W_WORK_DATE
                     AND DI.SOB_ID        =  W_SOB_ID
                     AND DI.ORG_ID        =  W_ORG_ID
                        ;
             EXCEPTION WHEN OTHERS THEN
               V_REJECT_YN := 'N';
             END;


           BEGIN
                SELECT DI.TRANS_YN AS O_TRANS_YN
                  INTO V_TRANS_YN
                  FROM HRD_DAY_INTERFACE DI
                 WHERE DI.SOB_ID       = W_SOB_ID
                   AND DI.ORG_ID       = W_ORG_ID
                   AND DI.PERSON_ID    = W_PERSON_ID
                   AND DI.WORK_DATE    = W_WORK_DATE
                     ;
                EXCEPTION
                     WHEN OTHERS THEN
                          V_TRANS_YN := 'N';
           END;
           IF V_TRANS_YN = 'Y' THEN
               BEGIN
                
                   SELECT DL.DAY_LEAVE_ID AS O_DAY_LEAVE_ID
                     INTO V_DAY_LEAVE_ID
                     FROM HRD_DAY_LEAVE     DL
                    WHERE DL.SOB_ID       = W_SOB_ID
                      AND DL.ORG_ID       = W_ORG_ID
                      AND DL.PERSON_ID    = W_PERSON_ID
                      AND DL.WORK_DATE    = W_WORK_DATE
                        ;  
                EXCEPTION
                     WHEN OTHERS THEN
                          V_DAY_LEAVE_ID := NULL;
                END;
           END IF;

           BEGIN
                SELECT DL.DAY_LEAVE_ID AS O_DAY_LEAVE_ID
                  INTO V_DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE     DL
                 WHERE DL.SOB_ID       = W_SOB_ID
                   AND DL.ORG_ID       = W_ORG_ID
                   AND DL.PERSON_ID    = W_PERSON_ID
                   AND DL.WORK_DATE    = W_WORK_DATE
                     ;
                EXCEPTION
                     WHEN OTHERS THEN
                          V_DAY_LEAVE_ID := NULL;
           END;

           BEGIN
                SELECT MAX(DECODE(DC.ATTEND_FLAG, 'A',  DC.DUTY_ID, NULL)) AS ATTEND
                     , MAX(DECODE(DC.ATTEND_FLAG, 'NA', DC.DUTY_ID, NULL)) AS NONATTEND
                     , MAX(DECODE(DC.ATTEND_FLAG, 'H',  DC.DUTY_ID, NULL)) AS HOLIDAY
                     , MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS NONPAYHOLIDAY
                     , MAX(DECODE(DC.ATTEND_FLAG, 'PH', DC.DUTY_ID, NULL)) AS PAYHOLIDAY
                  INTO V_A_DUTY_ID
                     , V_NA_DUTY_ID
                     , V_H_DUTY_ID
                     , V_NH_DUTY_ID
                     , V_PH_DUTY_ID
                  FROM HRM_DUTY_CODE_V  DC
                 WHERE DC.ATTEND_FLAG   IS NOT NULL
                   AND DC.SOB_ID      = W_SOB_ID
                   AND DC.ORG_ID      = W_ORG_ID
                     ;
                EXCEPTION WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(ERRNUMS.Duty_Not_Found_Code, ERRNUMS.Duty_Not_Found_Desc);
                  RETURN;
           END;

           BEGIN
                -- 전일 근무계획 조회.
                SELECT WC.HOLY_TYPE     AS PRE_HOLY_TYPE
                     , WC.DANGJIK_YN    AS PRE_DANGJIK_YN
                     , WC.ALL_NIGHT_YN AS PRE_ALL_NIGHT_YN
                  INTO V_PRE_HOLY_TYPE
                     , V_PRE_DANGJIK_YN
                     , V_PRE_ALL_NIGHT_YN
                  FROM HRD_WORK_CALENDAR   WC
                 WHERE WC.WORK_DATE      = (W_WORK_DATE - 1)
                   AND WC.PERSON_ID      = W_PERSON_ID
                   AND WC.SOB_ID         = W_SOB_ID
                   AND WC.ORG_ID         = W_ORG_ID
                     ;
              EXCEPTION WHEN OTHERS THEN
                V_PRE_HOLY_TYPE    := '2';
                V_PRE_DANGJIK_YN   := 'N';
                V_PRE_ALL_NIGHT_YN := 'N';
         END;
         BEGIN
                -- 금일 근무계획 조회.
                SELECT WC.HOLY_TYPE    AS HOLY_TYPE
                     , WC.DANGJIK_YN   AS DANGJIK_YN
                     , WC.ALL_NIGHT_YN AS ALL_NIGHT_YN
                  INTO V_HOLY_TYPE
                     , V_DANGJIK_YN
                     , V_ALL_NIGHT_YN
                  FROM HRD_WORK_CALENDAR   WC
                 WHERE WC.WORK_DATE      = W_WORK_DATE
                   AND WC.PERSON_ID      = W_PERSON_ID
                   AND WC.SOB_ID         = W_SOB_ID
                   AND WC.ORG_ID         = W_ORG_ID
                     ;
              EXCEPTION WHEN OTHERS THEN
                V_HOLY_TYPE        := '2';
                V_DANGJIK_YN       := 'N';
                V_ALL_NIGHT_YN     := 'N';
         END;
         V_DANGJIK_YN   := P_DANGJIK_YN;
         V_ALL_NIGHT_YN := P_ALL_NIGHT_YN;

         UPDATE HRD_DAY_INTERFACE DI
            SET DI.DANGJIK_YN              = NVL(V_DANGJIK_YN, 'N')
              , DI.ALL_NIGHT_YN            = NVL(V_ALL_NIGHT_YN, 'N')
              , DI.NEXT_DAY_YN             = NVL(P_NEXT_DAY_YN, 'N')
              , DI.LEAVE_ID                = P_LEAVE_ID
              , DI.LEAVE_TIME_CODE         = P_LEAVE_TIME_CODE
          WHERE DI.PERSON_ID               = W_PERSON_ID
            AND DI.WORK_DATE               = W_WORK_DATE
            AND DI.SOB_ID                  = W_SOB_ID
            AND DI.ORG_ID                  = W_ORG_ID
                ;

--RAISE_APPLICATION_ERROR(-20001, P_ALL_NIGHT_YN || ' | ' || V_ALL_NIGHT_YN);

 -----------------------------------------------------------------------------------------
           -- 전산 자료 조회. : 수정 시간하고 동일할 경우 출퇴근수정에 INSERT/UPDATE하지 않음.
           IF V_MODIFY_OPEN_YN = 'Y' THEN
              -- 근무일자 정리.
              V_WORK_DATE := W_WORK_DATE;

              /*  
              V_WORK_DATE := TRUNC(NVL(P_MODIFY_OPEN_TIME, P_MODIFY_OPEN_TIME1));
              IF V_WORK_DATE IS NULL THEN
                 V_WORK_DATE := W_WORK_DATE;
              END IF;*/

              BEGIN
                   -- 저장된 자료 조회.
                   SELECT DI.DUTY_ID
                        , DI.NEXT_DAY_YN
                        , DI.OPEN_TIME
                        , DI.CLOSE_TIME
                     INTO V_DUTY_ID
                        , V_NEXT_DAY_YN
                        , V_OPEN_TIME_CURRENT
                        , V_CLOSE_TIME_CURRENT
                     FROM HRD_DAY_INTERFACE  DI
                    WHERE DI.PERSON_ID     = W_PERSON_ID
                      AND DI.WORK_DATE     = W_WORK_DATE
                      AND DI.SOB_ID        = W_SOB_ID
                      AND DI.ORG_ID        = W_ORG_ID
                        ;
                   EXCEPTION WHEN OTHERS THEN
                     V_DUTY_ID     := V_NA_DUTY_ID;
                     V_NEXT_DAY_YN := 'N';
              END;

              IF P_MODIFY_OPEN_TIME IS NULL AND P_MODIFY_CLOSE_TIME IS NULL THEN
                 V_MODIFY_ID := 1498;
                 V_DUTY_ID   := V_NA_DUTY_ID;
              END IF;

              IF V_OPEN_TIME_CURRENT IS NOT NULL
              OR V_CLOSE_TIME_CURRENT IS NOT NULL THEN
                 V_DUTY_ID     := V_A_DUTY_ID;
              END IF;

              -- 근태코드 설정 **
              SELECT
                     CASE
                         WHEN V_HOLY_TYPE IN('0', '1') THEN
                           CASE
                              WHEN (V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y')
                               AND (V_ALL_NIGHT_YN = 'Y' OR V_DANGJIK_YN = 'Y' OR V_HOLY_TYPE = '3') THEN V_PH_DUTY_ID  -- 전일철야/당직, 금일 철야.
                              WHEN P_MODIFY_OPEN_TIME IS NOT NULL THEN V_PH_DUTY_ID  -- 휴일근무.
                              WHEN V_HOLY_TYPE = '0' THEN V_NH_DUTY_ID               -- 무급휴일.
                              ELSE V_H_DUTY_ID                                       -- 휴일.
                           END
                     ELSE                                                            -- 주간/야간
                        CASE
                            WHEN V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y' THEN V_A_DUTY_ID  -- 전일철야/전일당직 정상근무
                            WHEN (V_PRE_ALL_NIGHT_YN = 'Y' OR V_PRE_DANGJIK_YN = 'Y')
                             AND (V_ALL_NIGHT_YN = 'Y' OR V_DANGJIK_YN = 'Y') THEN V_A_DUTY_ID        -- 전일철야/당직, 금일 철야
                            WHEN P_MODIFY_OPEN_TIME IS NOT NULL  THEN V_A_DUTY_ID                     -- 출근기록 있음
                            ELSE V_NA_DUTY_ID                                                         -- 출근기록 없음
                        END
                     END AS DUTY_ID
                INTO V_DUTY_ID
                FROM DUAL;

              IF V_MODIFY_OPEN_YN = 'N' AND P_MODIFY_OPEN_TIME IS NULL AND P_MODIFY_OPEN_TIME1 IS NULL THEN
                 V_MODIFY_IO_YN := 'N';
                 V_MODIFY_YN := 'N';
                 -- 기존자료 삭제.
                 DELETE FROM HRD_DAY_MODIFY DM
                 WHERE DM.PERSON_ID  = W_PERSON_ID
                   AND DM.WORK_DATE  = W_WORK_DATE
                   AND DM.IO_FLAG    = '1'
                    ;

              ELSIF NVL(P_IO_OPEN_TIME, V_SYSDATE) = NVL(P_MODIFY_OPEN_TIME, V_SYSDATE)
                AND NVL(P_IO_OPEN_TIME1, V_SYSDATE) = NVL(P_MODIFY_OPEN_TIME1, V_SYSDATE) THEN
                    V_MODIFY_IO_YN := 'N';
              ELSE
                   BEGIN
                        -- 출근시간 저장.
                        UPDATE HRD_DAY_MODIFY DM
                           SET DM.MODIFY_TIME       = P_MODIFY_OPEN_TIME
                             , DM.MODIFY_TIME1      = P_MODIFY_OPEN_TIME1
                             , DM.MODIFY_ID         = V_MODIFY_ID
                             , DM.DESCRIPTION       = P_DESCRIPTION
                             , DM.LAST_UPDATE_DATE  = GET_LOCAL_DATE(W_SOB_ID)
                             , DM.LAST_UPDATED_BY   = P_USER_ID
                         WHERE DM.PERSON_ID         = W_PERSON_ID
                           AND DM.WORK_DATE         = V_WORK_DATE
                           AND DM.IO_FLAG           = '1'
                             ;
                   END;
                   IF (SQL%NOTFOUND)THEN
                      -- 기존 데이터 없음 --> INSERT.
                      INSERT INTO HRD_DAY_MODIFY
                                ( PERSON_ID
                                , WORK_DATE
                                , IO_FLAG
                                , MODIFY_TIME
                                , MODIFY_TIME1
                                , MODIFY_ID
                                , DESCRIPTION
                                , CREATION_DATE
                                , CREATED_BY
                                , LAST_UPDATE_DATE
                                , LAST_UPDATED_BY
                                )
                      VALUES
                               ( W_PERSON_ID
                               , V_WORK_DATE
                               , '1'
                               , P_MODIFY_OPEN_TIME
                               , P_MODIFY_OPEN_TIME1
                               , V_MODIFY_ID
                               , P_DESCRIPTION
                               , V_SYSDATE
                               , P_USER_ID
                               , V_SYSDATE
                               , P_USER_ID
                               );

                      V_MODIFY_IO_YN := 'Y';
                   ELSE
                      V_MODIFY_IO_YN := 'Y';
                   END IF;

              END IF;

              IF V_MODIFY_OPEN_YN = 'Y' THEN
                V_MODIFY_IO_YN := 'Y';
                 V_MODIFY_YN := 'Y';
              ELSIF P_MODIFY_OPEN_TIME IS NULL THEN
                 V_MODIFY_IO_YN := 'N';
                 V_MODIFY_YN := 'N';
              END IF;

              UPDATE HRD_DAY_INTERFACE DI
                 SET DI.DUTY_ID                 = V_DUTY_ID
                   , DI.MODIFY_IN_YN            = V_MODIFY_IO_YN
                   , DI.APPROVED_YN             = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
                   , DI.APPROVED_DATE           = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
                   --, DI.APPROVED_PERSON_ID      = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
                   , DI.APPROVED_PERSON_ID      = W_CONNECT_PERSON_ID
                   , DI.APPROVED_OUT_YN         = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
                   , DI.APPROVED_OUT_DATE       = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
                   , DI.APPROVED_OUT_PERSON_ID  = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
                   , DI.APPROVE_STATUS          = DECODE(V_MODIFY_IO_YN, 'Y', 'C', 'N')
                   , DI.CONFIRMED_YN            = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
                   , DI.CONFIRMED_DATE          = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
                   --, DI.CONFIRMED_PERSON_ID     = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
                   , DI.CONFIRMED_PERSON_ID     = W_CONNECT_PERSON_ID
                   , DI.EMAIL_STATUS            = 'N'
                   , DI.ATTRIBUTE1              = DI.APPROVED_PERSON_ID
                   , DI.ATTRIBUTE2              = W_CONNECT_PERSON_ID
               WHERE DI.PERSON_ID               = W_PERSON_ID
                 AND DI.WORK_DATE               = W_WORK_DATE
                 AND DI.SOB_ID                  = W_SOB_ID
                 AND DI.ORG_ID                  = W_ORG_ID
                     ;
           END IF;
 -----------------------------------------------------------------------------------------
           IF V_MODIFY_CLOSE_YN = 'Y' THEN
--RAISE_APPLICATION_ERROR(-20001, V_MODIFY_CLOSE_YN || '/' || TO_CHAR(P_MODIFY_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS') || '/' || TO_CHAR(P_CHECK_CLOSE_TIME, 'YYYY-MM-DD HH24:MI:SS'));
              BEGIN
                   -- 저장된 자료 조회.
                   SELECT DI.DUTY_ID
                        , DI.NEXT_DAY_YN
                        , DI.OPEN_TIME
                        , DI.CLOSE_TIME
                     INTO V_DUTY_ID
                        , V_NEXT_DAY_YN
                        , V_OPEN_TIME_CURRENT
                        , V_CLOSE_TIME_CURRENT
                     FROM HRD_DAY_INTERFACE  DI
                    WHERE DI.PERSON_ID     = W_PERSON_ID
                      AND DI.WORK_DATE     = W_WORK_DATE
                      AND DI.SOB_ID        = W_SOB_ID
                      AND DI.ORG_ID        = W_ORG_ID
                        ;
                   EXCEPTION WHEN OTHERS THEN
                     V_DUTY_ID     := V_NA_DUTY_ID;
                     V_NEXT_DAY_YN := 'N';
              END;

              IF P_MODIFY_CLOSE_TIME IS NULL AND P_MODIFY_OPEN_TIME IS NULL THEN
                 V_MODIFY_ID := 1498;
                 V_DUTY_ID   := V_NA_DUTY_ID;
              END IF;

              IF V_OPEN_TIME_CURRENT IS NOT NULL
              OR V_CLOSE_TIME_CURRENT IS NOT NULL THEN
                 V_DUTY_ID     := V_A_DUTY_ID;
              END IF;

--RAISE_APPLICATION_ERROR(-20001, V_MODIFY_CLOSE_YN || ' - ' || P_MODIFY_CLOSE_TIME || ' - ' ||  V_MODIFY_ID);

              -- 근태코드 설정 **
              SELECT
                    CASE
                        WHEN V_HOLY_TYPE IN('0', '1') THEN
                            CASE
                                WHEN V_PRE_HOLY_TYPE = '3' AND TO_CHAR(P_MODIFY_CLOSE_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID     -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근.
                                WHEN V_PRE_HOLY_TYPE = 'N' AND TO_CHAR(P_MODIFY_CLOSE_TIME, 'HH24:MI') >= '08:00' THEN V_PH_DUTY_ID     -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근.
                                WHEN V_PRE_ALL_NIGHT_YN = 'Y' AND TO_CHAR(P_MODIFY_CLOSE_TIME, 'HH24:MI') >= '09:30' THEN V_PH_DUTY_ID  -- 휴일 : 전일 철야, 금일 09:30 이후 퇴근.
                                WHEN V_PRE_DANGJIK_YN = 'Y' AND TO_CHAR(P_MODIFY_CLOSE_TIME, 'HH24:MI') >= '11:00' THEN V_PH_DUTY_ID    -- 휴일 : 전일 야간, 금일 09:30 이후 퇴근.
                                WHEN V_CLOSE_TIME_CURRENT IS NOT NULL THEN V_PH_DUTY_ID                                                 -- 휴일근무.
                                WHEN V_HOLY_TYPE = '0' THEN V_NH_DUTY_ID                                                                -- 무급휴일.
                                ELSE V_H_DUTY_ID                                                                                        -- 휴일.
                            END
                        ELSE
                            CASE
                                WHEN V_CLOSE_TIME_CURRENT IS NOT NULL THEN V_A_DUTY_ID
                                ELSE V_DUTY_ID                                                                                          -- 휴일
                            END
                    END AS DUTY_ID
                INTO V_DUTY_ID
                FROM DUAL;


              IF V_MODIFY_CLOSE_YN = 'N' AND P_MODIFY_CLOSE_TIME IS NULL AND P_MODIFY_CLOSE_TIME1 IS NULL THEN
                 V_MODIFY_IO_YN := 'N';
                 V_MODIFY_YN := 'N';
                 -- 기존자료 삭제.
                 DELETE FROM HRD_DAY_MODIFY DM
                 WHERE DM.PERSON_ID       = W_PERSON_ID
                   AND DM.WORK_DATE       = W_WORK_DATE
                   AND DM.IO_FLAG         = '2'
                     ;

                 UPDATE HRD_DAY_MODIFY DM
                    SET DM.MODIFY_ID         = V_MODIFY_ID
                      , DM.LAST_UPDATE_DATE  = GET_LOCAL_DATE(W_SOB_ID)
                      , DM.LAST_UPDATED_BY   = P_USER_ID
                  WHERE DM.PERSON_ID         = W_PERSON_ID
                    AND DM.WORK_DATE         = W_WORK_DATE
                    AND DM.IO_FLAG           = '1'
                      ;

--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || W_PERSON_ID || ' - P_MODIFY_CLOSE_TIME IS NULL AND P_MODIFY_CLOSE_TIME1 IS NULL');

              ELSIF V_MODIFY_CLOSE_YN = 'N' 
                AND NVL(P_IO_CLOSE_TIME,  V_SYSDATE) = NVL(P_MODIFY_CLOSE_TIME,  V_SYSDATE)
                AND NVL(P_IO_CLOSE_TIME1, V_SYSDATE) = NVL(P_MODIFY_CLOSE_TIME1, V_SYSDATE) THEN
                    V_MODIFY_IO_YN := 'N';
                    
--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || V_MODIFY_CLOSE_YN || ' - ' || P_NEXT_DAY_YN || ' - ' || P_NEXT_DAY_YN || ' - ' || P_IO_CLOSE_TIME || ' - ' || P_IO_CLOSE_TIME1);

                    -- 후일 퇴근 적용.
                    IF P_NEXT_DAY_YN = 'Y' THEN
                       V_MODIFY_TIME := NULL;

                       FOR C1 IN ( SELECT AI.DEVICE_ID
                                        , AI.IO_FLAG
                                        , AI.PERSON_ID
                                        , AI.CARD_NUM
                                        , AI.IO_DATETIME
                                        , AI.IO_DATE
                                        , AI.IO_TIME
                                        , AI.CREATED_FLAG
                                     FROM HRD_ATTEND_INTERFACE AI
                                    WHERE AI.PERSON_ID = W_PERSON_ID
                                      AND AI.IO_DATE   = W_WORK_DATE + 1
                                      AND AI.IO_FLAG   = '2'
                                 ORDER BY AI.IO_DATETIME
                                 )
                       LOOP
                           IF V_MODIFY_TIME IS NULL THEN
                              V_MODIFY_TIME := C1.IO_DATETIME;
                           END IF;
                       END LOOP C1;

                       V_MODIFY_YN := 'Y';
                    ELSE
                       V_MODIFY_YN := 'N';
                    END IF;
--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || W_PERSON_ID || ' - P_IO_CLOSE_TIME = P_MODIFY_CLOSE_TIME AND P_MODIFY_CLOSE_TIME = P_MODIFY_CLOSE_TIME1');
              ELSE
                    BEGIN
                         UPDATE HRD_DAY_MODIFY DM
                            SET DM.MODIFY_ID         = V_MODIFY_ID
                              , DM.LAST_UPDATE_DATE  = GET_LOCAL_DATE(W_SOB_ID)
                              , DM.LAST_UPDATED_BY   = P_USER_ID
                          WHERE DM.PERSON_ID         = W_PERSON_ID
                            AND DM.WORK_DATE         = W_WORK_DATE
                            AND DM.IO_FLAG           = '2'
                              ;

                         -- 퇴근시간 저장.
                         UPDATE HRD_DAY_MODIFY DM
                            SET DM.MODIFY_TIME       = P_MODIFY_CLOSE_TIME
                              , DM.MODIFY_TIME1      = P_MODIFY_CLOSE_TIME1
                              , DM.MODIFY_ID         = V_MODIFY_ID
                              , DM.DESCRIPTION       = P_DESCRIPTION
                              , DM.LAST_UPDATE_DATE  = GET_LOCAL_DATE(W_SOB_ID)
                              , DM.LAST_UPDATED_BY   = P_USER_ID
                          WHERE DM.PERSON_ID         = W_PERSON_ID
                            AND DM.WORK_DATE         = W_WORK_DATE
                            AND DM.IO_FLAG           = '2'
                              ;

--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || W_PERSON_ID || ' - ' || V_MODIFY_CLOSE_YN || ' - ' || P_MODIFY_CLOSE_TIME || ' - ' ||  V_MODIFY_ID);
                    END;

                    IF (SQL%NOTFOUND)THEN
                       -- 기존 데이터 없음 --> INSERT.
                       INSERT INTO HRD_DAY_MODIFY
                                 ( PERSON_ID
                                 , WORK_DATE
                                 , IO_FLAG
                                 , MODIFY_TIME
                                 , MODIFY_TIME1
                                 , MODIFY_ID
                                 , DESCRIPTION
                                 , CREATION_DATE
                                 , CREATED_BY
                                 , LAST_UPDATE_DATE
                                 , LAST_UPDATED_BY
                                 )
                       VALUES
                                 ( W_PERSON_ID
                                 , W_WORK_DATE
                                 , '2'
                                 , P_MODIFY_CLOSE_TIME
                                 , P_MODIFY_CLOSE_TIME1
                                 , V_MODIFY_ID
                                 , P_DESCRIPTION
                                 , V_SYSDATE
                                 , P_USER_ID
                                 , V_SYSDATE
                                 , P_USER_ID
                                 );
--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || W_PERSON_ID || ' - ' || V_MODIFY_CLOSE_YN || ' - ' || P_MODIFY_CLOSE_TIME || ' - ' ||  V_MODIFY_ID);
                       V_MODIFY_IO_YN := 'Y';
                    ELSE
                       V_MODIFY_IO_YN := 'Y';
                    END IF;
              END IF;

              -- 수정 FLAG.
              IF P_LEAVE_ID IS NOT NULL OR P_LEAVE_TIME_CODE IS NOT NULL THEN
                 V_MODIFY_YN := 'Y';
              END IF;

              IF V_MODIFY_CLOSE_YN = 'Y' THEN
                 V_MODIFY_IO_YN := 'Y';
                 V_MODIFY_YN := 'Y';
              ELSIF P_MODIFY_CLOSE_TIME IS NULL THEN
                 V_MODIFY_IO_YN := 'N';
                 V_MODIFY_YN := 'N';
              END IF;

--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || W_PERSON_ID || ' - ' || V_MODIFY_TIME || ' - ' || V_MODIFY_YN || ' - ' ||  V_MODIFY_IO_YN);

              UPDATE HRD_DAY_INTERFACE DI
                 SET DI.CLOSE_TIME              = NVL(DI.CLOSE_TIME, V_MODIFY_TIME)
                   , DI.CLOSE_TIME1             = DECODE(DI.CLOSE_TIME, NULL, DI.CLOSE_TIME1, V_MODIFY_TIME)
                   , DI.NEXT_DAY_YN             = NVL(P_NEXT_DAY_YN, 'N')
                   , DI.DANGJIK_YN              = NVL(V_DANGJIK_YN, 'N')
                   , DI.ALL_NIGHT_YN            = NVL(V_ALL_NIGHT_YN, 'N')
                   , DI.LEAVE_ID                = P_LEAVE_ID
                   , DI.LEAVE_TIME_CODE         = P_LEAVE_TIME_CODE
                   , DI.MODIFY_YN               = NVL(V_MODIFY_YN, 'N')
                   , DI.MODIFY_OUT_YN           = NVL(V_MODIFY_IO_YN, 'N')
                   , DI.APPROVED_YN             = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
                   , DI.APPROVED_DATE           = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
                   --, DI.APPROVED_PERSON_ID      = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
                   , DI.APPROVED_PERSON_ID      = W_CONNECT_PERSON_ID
                   , DI.APPROVED_OUT_YN         = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
                   , DI.APPROVED_OUT_DATE       = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
                   , DI.APPROVED_OUT_PERSON_ID  = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
                   , DI.APPROVE_STATUS          = DECODE(V_MODIFY_IO_YN, 'Y', 'C', 'N')
                   , DI.CONFIRMED_YN            = DECODE(V_MODIFY_IO_YN, 'Y', 'Y', 'N')
                   , DI.CONFIRMED_DATE          = DECODE(V_MODIFY_IO_YN, 'Y', V_SYSDATE, NULL)
                   --, DI.CONFIRMED_PERSON_ID     = DECODE(V_MODIFY_IO_YN, 'Y', W_CONNECT_PERSON_ID, NULL)
                   , DI.CONFIRMED_PERSON_ID     = W_CONNECT_PERSON_ID
                   , DI.EMAIL_STATUS            = 'N'
                   , DI.DESCRIPTION             = P_DESCRIPTION
                   , DI.LAST_UPDATE_DATE        = GET_LOCAL_DATE(DI.SOB_ID)
                   , DI.LAST_UPDATED_BY         = P_USER_ID
                   , DI.ATTRIBUTE1              = DI.APPROVED_PERSON_ID
                   , DI.ATTRIBUTE2              = W_CONNECT_PERSON_ID
               WHERE DI.PERSON_ID               = W_PERSON_ID
                 AND DI.WORK_DATE               = W_WORK_DATE
                 AND DI.SOB_ID                  = W_SOB_ID
                 AND DI.ORG_ID                  = W_ORG_ID
                 ;
           END IF;


--RAISE_APPLICATION_ERROR(-20001, W_WORK_DATE || ' - ' || W_PERSON_ID || ' - ' || V_TRANS_YN || ' - ' || V_MODIFY_OPEN_YN || ' - ' ||  V_MODIFY_CLOSE_YN || ' - ' ||  V_MODIFY_ID || ' - ' ||  W_DUTY_ID || ' - ' ||  P_DUTY_ID || ' - ' ||  V_DUTY_ID);

           IF V_TRANS_YN = 'Y' THEN
              IF V_MODIFY_OPEN_YN = 'Y' OR V_MODIFY_CLOSE_YN = 'Y' THEN
                 IF V_MODIFY_ID = 1498 THEN --출퇴근 삭제
                    UPDATE HRD_DAY_INTERFACE DI
                       SET DI.DUTY_ID                 = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                     WHERE DI.PERSON_ID               = W_PERSON_ID
                       AND DI.WORK_DATE               = W_WORK_DATE
                       AND DI.SOB_ID                  = W_SOB_ID
                       AND DI.ORG_ID                  = W_ORG_ID
                           ;
                           
                    UPDATE HRD_DAY_LEAVE DL
                       SET DL.DUTY_ID      = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                     WHERE DL.DAY_LEAVE_ID = V_DAY_LEAVE_ID
                         ;
                 ELSE
                    UPDATE HRD_DAY_LEAVE DL
                       SET DL.DUTY_ID      = V_DUTY_ID
                         , DL.HOLY_TYPE    = V_HOLY_TYPE
                         , DL.ALL_NIGHT_YN = V_ALL_NIGHT_YN
                         , DL.NEXT_DAY_YN  = P_NEXT_DAY_YN
                         , DL.DANGJIK_YN   = V_DANGJIK_YN
                         , DL.OPEN_TIME    = P_MODIFY_OPEN_TIME
                         , DL.OPEN_TIME1   = P_MODIFY_OPEN_TIME1
                         , DL.CLOSE_TIME   = P_MODIFY_CLOSE_TIME
                         , DL.CLOSE_TIME1  = P_MODIFY_CLOSE_TIME1
                     WHERE DL.DAY_LEAVE_ID = V_DAY_LEAVE_ID
                         ;
                 END IF;
              ELSE
                 IF V_MODIFY_ID = 1498 THEN --출퇴근 삭제
                    UPDATE HRD_DAY_INTERFACE DI
                       SET DI.DUTY_ID                 = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                     WHERE DI.PERSON_ID               = W_PERSON_ID
                       AND DI.WORK_DATE               = W_WORK_DATE
                       AND DI.SOB_ID                  = W_SOB_ID
                       AND DI.ORG_ID                  = W_ORG_ID
                           ;
                           
                    UPDATE HRD_DAY_LEAVE DL
                       SET DL.DUTY_ID      = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                     WHERE DL.DAY_LEAVE_ID = V_DAY_LEAVE_ID
                         ;
                 ELSIF V_MODIFY_ID IS NULL THEN
                    -- 출근/퇴근, 수정사유 삭제후
                    -- 수정내용을 지우기 위해
                    DELETE FROM HRD_DAY_MODIFY DM
                    WHERE DM.PERSON_ID       = W_PERSON_ID
                      AND DM.WORK_DATE       = W_WORK_DATE
                      AND DM.IO_FLAG         = '2'
                        ;
                    UPDATE HRD_DAY_INTERFACE DI
                       SET DI.MODIFY_YN               = NULL
                         , DI.MODIFY_IN_YN            = NULL
                         , DI.MODIFY_OUT_YN           = NULL
                     WHERE DI.PERSON_ID               = W_PERSON_ID
                       AND DI.WORK_DATE               = W_WORK_DATE
                       AND DI.SOB_ID                  = W_SOB_ID
                       AND DI.ORG_ID                  = W_ORG_ID
                           ;
                 ELSE
                    UPDATE HRD_DAY_LEAVE DL
                       SET DL.DUTY_ID      = V_DUTY_ID  -- 변경전 : W_DUTY_ID --
                         , DL.ALL_NIGHT_YN = NVL(P_ALL_NIGHT_YN, 'N')
                         , DL.NEXT_DAY_YN  = NVL(P_NEXT_DAY_YN, 'N')
                         , DL.DANGJIK_YN   = NVL(P_DANGJIK_YN, 'N')
                         , DL.OPEN_TIME    = P_MODIFY_OPEN_TIME
                         , DL.OPEN_TIME1   = P_MODIFY_OPEN_TIME1
                         , DL.CLOSE_TIME   = P_MODIFY_CLOSE_TIME
                         , DL.CLOSE_TIME1  = P_MODIFY_CLOSE_TIME1
                     WHERE DL.DAY_LEAVE_ID = V_DAY_LEAVE_ID
                         ;
                 END IF;
              END IF;
           ELSE
              IF V_MODIFY_ID = 1498 THEN --출퇴근 삭제
                 UPDATE HRD_DAY_INTERFACE DI
                    SET DI.DUTY_ID                 = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                  WHERE DI.PERSON_ID               = W_PERSON_ID
                    AND DI.WORK_DATE               = W_WORK_DATE
                    AND DI.SOB_ID                  = W_SOB_ID
                    AND DI.ORG_ID                  = W_ORG_ID
                        ;
                           
                 UPDATE HRD_DAY_LEAVE DL
                    SET DL.DUTY_ID      = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                  WHERE DL.DAY_LEAVE_ID = V_DAY_LEAVE_ID
                      ;
              END IF;
           END IF;


           --[2011-11-10]
           IF V_REJECT_YN = 'Y' THEN
              UPDATE HRD_DAY_INTERFACE DI
                 SET DI.REJECT_REMARK       = NULL
                   , DI.REJECT_YN           = 'N'
                   , DI.REJECT_DATE         = NULL
                   , DI.REJECT_PERSON_ID    = NULL
                   , DI.ATTRIBUTE3          = DI.REJECT_PERSON_ID
               WHERE DI.PERSON_ID           = W_PERSON_ID
                 AND DI.WORK_DATE           = W_WORK_DATE
                 AND DI.SOB_ID              = W_SOB_ID
                 AND DI.ORG_ID              = W_ORG_ID
                   ;
           END IF;

--RAISE_APPLICATION_ERROR(-20001, P_ALL_NIGHT_YN || ' | ' || V_ALL_NIGHT_YN || ' | ' || W_CORP_ID || ' | ' || W_WORK_DATE || ' | ' || W_PERSON_ID || ' | ' || W_SOB_ID || ' | ' || W_ORG_ID);

        --[2011-11-10]
        IF V_MODIFY_YN = 'Y' OR V_MODIFY_IO_YN = 'Y' THEN
           IF V_MODIFY_ID = 1498 THEN --출퇴근 삭제
              -- 1498 출퇴근 삭제
              BEGIN
                   SELECT DC.DUTY_ID
                        , DC.DUTY_NAME
                     INTO O_DUTY_ID
                        , O_DUTY_NAME
                     FROM HRM_DUTY_CODE_V DC
                    WHERE DC.DUTY_ID = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                        ;
                   EXCEPTION WHEN OTHERS THEN
                     O_DUTY_ID   := NULL;
                     O_DUTY_NAME := NULL;
              END;
           ELSE
              -- 변경된 근태ID, 근태명 반환.
              BEGIN
                   SELECT DC.DUTY_ID
                        , DC.DUTY_NAME
                     INTO O_DUTY_ID
                        , O_DUTY_NAME
                     FROM HRM_DUTY_CODE_V DC
                    WHERE DC.DUTY_ID = DECODE(V_MODIFY_YN, 'Y', V_DUTY_ID, DECODE(V_MODIFY_IO_YN, 'Y', V_DUTY_ID, W_DUTY_ID))
                        ;
                   EXCEPTION WHEN OTHERS THEN
                     O_DUTY_ID   := NULL;
                     O_DUTY_NAME := NULL;
              END;
           END IF;
        ELSE
           -- 변경된 근태ID, 근태명 반환.
           BEGIN
                SELECT DC.DUTY_ID
                     , DC.DUTY_NAME
                  INTO O_DUTY_ID
                     , O_DUTY_NAME
                  FROM HRM_DUTY_CODE_V DC
                 WHERE DC.DUTY_ID = V_DUTY_ID  -- 변경전 : P_DUTY_ID --
                     ;
                EXCEPTION WHEN OTHERS THEN
                  O_DUTY_ID   := NULL;
                  O_DUTY_NAME := NULL;
           END;
        END IF;

           -- 승인상태 조회.
           BEGIN
                SELECT DI.APPROVE_STATUS
                     , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                  INTO O_APPROVE_STATUS
                     , O_APPROVE_STATUS_NAME
                  FROM HRD_DAY_INTERFACE DI
                 WHERE DI.PERSON_ID      =  W_PERSON_ID
                   AND DI.WORK_DATE      =  W_WORK_DATE
                   AND DI.SOB_ID         =  W_SOB_ID
                   AND DI.ORG_ID         =  W_ORG_ID
                   ;
                EXCEPTION
                  WHEN OTHERS THEN
                    O_APPROVE_STATUS      := 'N';
                    O_APPROVE_STATUS_NAME := '승인미요청';
           END;



             --[2011-11-10]
             BEGIN
                  SELECT DI.REJECT_REMARK
                       , DI.REJECT_YN
                       , DI.REJECT_DATE
                       , HRM_PERSON_MASTER_G.NAME_F(DI.REJECT_PERSON_ID)
                    INTO O_REJECT_REMARK
                       , O_REJECT_YN
                       , O_REJECT_DATE
                       , O_REJECT_PERSON_NAME
                    FROM HRD_DAY_INTERFACE   DI
                   WHERE DI.SOB_ID        =  W_SOB_ID
                     AND DI.ORG_ID        =  W_ORG_ID
                     AND DI.WORK_DATE     =  W_WORK_DATE
                     AND DI.PERSON_ID     =  W_PERSON_ID
                       ;
                 EXCEPTION WHEN OTHERS THEN
                   O_REJECT_YN           := 'N';
                   O_REJECT_REMARK       := NULL;
                   O_REJECT_DATE         := NULL;
                   O_REJECT_PERSON_NAME  := NULL;
             END;

   END UPDATE_DAY_IN_OUT;











-- [출퇴등 승인] [2011-07-18] [2011-11-10]
   PROCEDURE SELECT_DAY_MODIFY( P_CURSOR              OUT  TYPES.TCURSOR
                              , W_SOB_ID              IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                              , W_ORG_ID              IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                              , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
                              , W_CONNECT_LEVEL       IN   VARCHAR2 DEFAULT 'A'
                              , W_WORK_CORP_ID        IN   HRD_DAY_INTERFACE.CORP_ID%TYPE
                              , W_WORK_DATE           IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                              , W_APPROVE_STATUS      IN   HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
                              , W_WORK_TYPE_ID        IN   HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                              , W_FLOOR_ID            IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                              , W_PERSON_ID           IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                              )

   AS

             V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
             V_USER_CAP            VARCHAR2(10);

   BEGIN
             -- 근태권한 설정.
             V_USER_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_WORK_CORP_ID
                                                   , W_START_DATE   =>  W_WORK_DATE
                                                   , W_END_DATE     =>  W_WORK_DATE
                                                   , W_MODULE_CODE  =>  '20'
                                                   , W_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                                   , W_SOB_ID       =>  W_SOB_ID
                                                   , W_ORG_ID       =>  W_ORG_ID);

             IF V_USER_CAP = 'C' AND W_APPROVE_STATUS = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSIF V_USER_CAP = 'C' AND W_APPROVE_STATUS = 'B' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID; --[2011-12-16] --[2012-01-06]수적품
                --V_CONNECT_PERSON_ID := -1; --[2012-01-06]수적
             END IF;

             OPEN P_CURSOR FOR
             SELECT 'N' AS CHECK_YN
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)     AS FLOOR_NAME
                  , PM.PERSON_NUM AS PERSON_NUMBER
                  , PM.NAME       AS PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , CASE
                        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                        ELSE DI.OPEN_TIME
                    END AS OPEN_TIME_MODIFY
                  , CASE
                        WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                        ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME_MODIFY
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID))  AS MODIFY_DESC
                  , DI.OPEN_TIME  AS OPEN_TIME_BEFORE
                  , DI.CLOSE_TIME AS CLOSE_TIME_BEFORE
                  , CASE
                        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                        ELSE DI.OPEN_TIME1
                    END AS OPEN_TIME_MODIFY_1
                  , CASE
                        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                        ELSE DI.CLOSE_TIME1
                    END AS CLOSE_TIME_MODIFY_1
                  , DI.ALL_NIGHT_YN
                  , DI.NEXT_DAY_YN
                  , DI.DANGJIK_YN
                  , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                  , DI.DESCRIPTION
                  , DI.TRANS_YN AS TRANS_YN
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                  , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , DI.REJECT_YN AS REJECT_YN
                  , DI.REJECT_DATE
                  , HRM_PERSON_MASTER_G.NAME_F(DI.REJECT_PERSON_ID) AS REJECT_PERSON_NAME
                  , DI.REJECT_REMARK
                  , DI.WORK_DATE
                  , DI.WORK_CORP_ID
                  , DI.PERSON_ID
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_PERSON_MASTER PM
                  , HRM_FLOOR_V HF
                  , HRM_POST_CODE_V PC
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                          , HL.OCPT_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE             S_HL
                                                      WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                        AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                    ) T2
                  , HRD_DAY_MODIFY I_DM
                  , HRD_DAY_MODIFY O_DM
                  , (-- 후일 근무 정보 조회.
                     SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                          , DIT.PERSON_ID
                          , DIT.CORP_ID
                          , DIT.SOB_ID
                          , DIT.ORG_ID
                          , DIT.OPEN_TIME
                          , DIT.CLOSE_TIME
                          , DIT.OPEN_TIME1
                          , DIT.CLOSE_TIME1
                       FROM HRD_DAY_INTERFACE   DIT
                      WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
                        AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
                        AND DIT.WORK_CORP_ID  = W_WORK_CORP_ID
                        AND DIT.SOB_ID        = W_SOB_ID
                        AND DIT.ORG_ID        = W_ORG_ID
                    ) N_DI
              WHERE DI.PERSON_ID        =  PM.PERSON_ID
                AND DI.WORK_CORP_ID     =  PM.WORK_CORP_ID
                AND DI.SOB_ID           =  PM.SOB_ID
                AND DI.ORG_ID           =  PM.ORG_ID
                AND PM.FLOOR_ID         =  HF.FLOOR_ID
                AND PM.POST_ID          =  PC.POST_ID
                AND PM.PERSON_ID        =  T1.PERSON_ID
                AND PM.PERSON_ID        =  T2.PERSON_ID
                AND DI.PERSON_ID        =  I_DM.PERSON_ID(+)
                AND DI.WORK_DATE        =  I_DM.WORK_DATE(+)
                AND '1'                 =  I_DM.IO_FLAG(+)
                AND DI.PERSON_ID        =  O_DM.PERSON_ID(+)
                AND DI.WORK_DATE        =  O_DM.WORK_DATE(+)
                AND '2'                 =  O_DM.IO_FLAG(+)
                AND DI.WORK_DATE        =  N_DI.WORK_DATE(+)
                AND DI.PERSON_ID        =  N_DI.PERSON_ID(+)
                AND DI.SOB_ID           =  N_DI.SOB_ID(+)
                AND DI.ORG_ID           =  N_DI.ORG_ID(+)
                AND DI.WORK_DATE        =  W_WORK_DATE
                AND DI.PERSON_ID        =  NVL(W_PERSON_ID, DI.PERSON_ID)
                AND DI.WORK_CORP_ID     =  W_WORK_CORP_ID
                AND DI.SOB_ID           =  W_SOB_ID
                AND DI.ORG_ID           =  W_ORG_ID
                AND DI.APPROVE_STATUS   =  NVL(W_APPROVE_STATUS, DI.APPROVE_STATUS)
                AND DI.WORK_TYPE_ID     =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                AND T2.FLOOR_ID         =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND DI.MODIFY_FLAG      =  'Y'
                AND PM.JOIN_DATE       <=  W_WORK_DATE
                AND(PM.RETIRE_DATE IS NULL
                 OR PM.RETIRE_DATE >= W_WORK_DATE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
                               AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.WORK_CORP_ID)
                               AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.START_DATE                              <= W_WORK_DATE
                               AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
                               AND DM.SOB_ID                                  = PM.SOB_ID
                               AND DM.ORG_ID                                  = PM.ORG_ID
                           )
           ORDER BY PM.WORK_TYPE_ID
                  , HF.FLOOR_CODE
                  , PM.NAME
                  ;


  END SELECT_DAY_MODIFY;


       -- [출퇴근 조회] - 2011-07-26
       PROCEDURE SELECT_DAY_BEFORE_CURRENT_NEXT( P_CURSOR         OUT  TYPES.TCURSOR
                                               , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                               , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                               , W_WORK_DATE      IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                               , W_WORK_TYPE_ID   IN   HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                                               , W_FLOOR_ID       IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                                               , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                               )

       AS

       BEGIN

                 OPEN P_CURSOR FOR
                 SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)      AS EMPLOYE_TYPE
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                      , PM.DISPLAY_NAME                     AS PERSON_NAME
                      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)  AS DUTY_NAME
                      , DI.NEXT_DAY_YN
                      , DI.DANGJIK_YN
                      , DI.ALL_NIGHT_YN
                      , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID))                          AS MODIFY_DESC
                      , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME)                         AS OPEN_TIME_MODIFY
                      , NVL(O_DM.MODIFY_TIME, DI.CLOSE_TIME)                                                 AS CLOSE_TIME_MODIFY
                      , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME1, DI.OPEN_TIME1)                       AS OPEN_TIME1_MODIFY
                      , NVL(O_DM.MODIFY_TIME1, DI.CLOSE_TIME1)                                               AS CLOSE_TIME1_MODIFY
                      , DI.OPEN_TIME                                                                         AS OPEN_TIME_CURRENT
                      , DI.CLOSE_TIME                                                                        AS CLOSE_TIME_CURRENT
                      , DI.OPEN_TIME1                                                                        AS OPEN_TIME1_CURRENT
                      , DI.CLOSE_TIME1                                                                       AS CLOSE_TIME1_CURRENT
                      , B_DI.OPEN_TIME                                                                       AS OPEN_TIME_BEFORE
                      , B_DI.CLOSE_TIME                                                                      AS CLOSE_TIME_BEFORE
                      , B_DI.OPEN_TIME1                                                                      AS OPEN_TIME1_BEFORE
                      , B_DI.CLOSE_TIME1                                                                     AS CLOSE_TIME1_BEFORE
                      , N_DI.OPEN_TIME                                                                       AS OPEN_TIME_NEXT
                      , N_DI.CLOSE_TIME                                                                      AS CLOSE_TIME_NEXT
                      , N_DI.OPEN_TIME1                                                                      AS OPEN_TIME1_NEXT
                      , N_DI.CLOSE_TIME1                                                                     AS CLOSE_TIME1_NEXT
                      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID)                                                  AS LEAVE_NAME
                      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID)            AS HOLY_TYPE_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)                                              AS WORK_TYPE
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)                                            AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)                                                   AS POST_NAME
                      , PM.RETIRE_DATE
                      , DI.PERSON_ID
                   FROM HRD_DAY_INTERFACE_V DI
                      , HRM_PERSON_MASTER PM
                      , HRM_FLOOR_V HF
                      , HRM_POST_CODE_V PC
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.JOB_CATEGORY_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE                         <= W_WORK_DATE
                                                            AND S_HL.PERSON_ID                            = HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                            AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                        ) T2
                      , HRD_DAY_MODIFY I_DM
                      , HRD_DAY_MODIFY O_DM
                      , (-- 전일 후일 출퇴 조회
                           SELECT DIB.WORK_DATE + 1 AS WORK_DATE
                                , DIB.PERSON_ID
                                , DIB.WORK_CORP_ID
                                , DIB.SOB_ID
                                , DIB.ORG_ID
                                , DIB.OPEN_TIME
                                , DIB.CLOSE_TIME
                                , DIB.OPEN_TIME1
                                , DIB.CLOSE_TIME1
                             FROM HRD_DAY_INTERFACE DIB
                            WHERE DIB.WORK_DATE     = W_WORK_DATE - 1
                              AND DIB.PERSON_ID     = NVL(NULL, DIB.PERSON_ID)
                              AND DIB.SOB_ID        = W_SOB_ID
                              AND DIB.ORG_ID        = W_ORG_ID
                        ) B_DI
                      , (-- 후일 출퇴 조회
                           SELECT DIN.WORK_DATE - 1 AS WORK_DATE
                                , DIN.PERSON_ID
                                , DIN.WORK_CORP_ID
                                , DIN.SOB_ID
                                , DIN.ORG_ID
                                , DIN.OPEN_TIME
                                , DIN.CLOSE_TIME
                                , DIN.OPEN_TIME1
                                , DIN.CLOSE_TIME1
                             FROM HRD_DAY_INTERFACE DIN
                            WHERE DIN.WORK_DATE     = W_WORK_DATE + 1
                              AND DIN.PERSON_ID     = NVL(NULL, DIN.PERSON_ID)
                              AND DIN.SOB_ID        = W_SOB_ID
                              AND DIN.ORG_ID        = W_ORG_ID
                          ) N_DI
                  WHERE DI.PERSON_ID                               = PM.PERSON_ID
                    AND PM.FLOOR_ID                                = HF.FLOOR_ID
                    AND PM.POST_ID                                 = PC.POST_ID
                    AND DI.WORK_CORP_ID                            = PM.WORK_CORP_ID
                    AND DI.SOB_ID                                  = PM.SOB_ID
                    AND DI.ORG_ID                                  = PM.ORG_ID
                    AND PM.PERSON_ID                               = T1.PERSON_ID
                    AND PM.PERSON_ID                               = T2.PERSON_ID
                    AND DI.PERSON_ID                               = I_DM.PERSON_ID(+)
                    AND DI.WORK_DATE                               = I_DM.WORK_DATE(+)
                    AND '1'                                        = I_DM.IO_FLAG(+)
                    AND DI.PERSON_ID                               = O_DM.PERSON_ID(+)
                    AND DI.WORK_DATE                               = O_DM.WORK_DATE(+)
                    AND '2'                                        = O_DM.IO_FLAG(+)
                    AND DI.WORK_DATE                               = B_DI.WORK_DATE(+)
                    AND DI.PERSON_ID                               = B_DI.PERSON_ID(+)
                    AND DI.SOB_ID                                  = B_DI.SOB_ID(+)
                    AND DI.ORG_ID                                  = B_DI.ORG_ID(+)
                    AND DI.WORK_DATE                               = N_DI.WORK_DATE(+)
                    AND DI.PERSON_ID                               = N_DI.PERSON_ID(+)
                    AND DI.SOB_ID                                  = N_DI.SOB_ID(+)
                    AND DI.ORG_ID                                  = N_DI.ORG_ID(+)
                    AND DI.WORK_DATE                               = W_WORK_DATE
                    AND DI.PERSON_ID                               = NVL(W_PERSON_ID, DI.PERSON_ID)
                    AND DI.SOB_ID                                  = W_SOB_ID
                    AND DI.ORG_ID                                  = W_ORG_ID
                    AND PM.WORK_TYPE_ID                            = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                    AND T2.FLOOR_ID                                = NVL(W_FLOOR_ID, T2.FLOOR_ID)
               ORDER BY HF.FLOOR_CODE
                      , PM.WORK_TYPE_ID
                      , PM.NAME
                      ;


       END SELECT_DAY_BEFORE_CURRENT_NEXT;


       -- [출퇴근조회(SECOM후)] - 2011-08-06
       PROCEDURE SELECT_DAY_SECOM_AFTER( P_CURSOR         OUT  TYPES.TCURSOR
                                       , W_SOB_ID         IN   HRD_ATTEND_INTERFACE.SOB_ID%TYPE
                                       , W_ORG_ID         IN   HRD_ATTEND_INTERFACE.ORG_ID%TYPE
                                       , W_WORK_DATE_FR   IN   HRD_ATTEND_INTERFACE.IO_DATETIME%TYPE
                                       , W_WORK_DATE_TO   IN   HRD_ATTEND_INTERFACE.IO_DATETIME%TYPE
                                       , W_FLOOR_ID       IN   HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                       , W_WORK_TYPE_ID   IN   HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                       , W_PERSON_ID      IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
                                       )

       AS

       BEGIN

                 OPEN P_CURSOR FOR
                 SELECT CASE
                             WHEN AI.IO_FLAG = 1 THEN '출근'
                             WHEN AI.IO_FLAG = 2 THEN '퇴근'
                             WHEN AI.IO_FLAG = 3 THEN '외출'
                             WHEN AI.IO_FLAG = 4 THEN '외출복귀'
                        END AS IO_FLAG
                      , AI.IO_DATE
                      , AI.IO_TIME
                      , AI.IO_DATETIME
                      , AI.CREATED_FLAG
                      , AI.DEVICE_ID
                      , AI.CARD_NUM
                      , HRM_PERSON_MASTER_G.PERSON_NUMBER_F(AI.PERSON_ID) AS PERSON_NUMBER
                      , HRM_PERSON_MASTER_G.NAME_F(AI.PERSON_ID)          AS PERSON_NAME
                      , SUBSTR(PM.REPRE_NUM, 0, 8) || '...'               AS REPRE_NUMBER
                      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)         AS CORP_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)               AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)           AS WORK_TYPE_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)         AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)                AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID )          AS JOB_CLASS_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)        AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)                AS OCPT_NAME
                      , PM.JOIN_DATE
                      , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_NAME
                      , PM.RETIRE_DATE
                      , AI.CREATION_DATE
                      , AI.LAST_UPDATE_DATE
                      , AI.PERSON_ID
                   FROM HRD_ATTEND_INTERFACE  AI
                      , HRM_PERSON_MASTER     PM
                  WHERE AI.PERSON_ID       =  PM.PERSON_ID
                    AND AI.SOB_ID          =  W_SOB_ID
                    AND AI.ORG_ID          =  W_ORG_ID
                    AND PM.FLOOR_ID        =  NVL(W_FLOOR_ID, PM.FLOOR_ID)
                    AND PM.WORK_TYPE_ID    =  NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                    AND AI.PERSON_ID       =  NVL(W_PERSON_ID, AI.PERSON_ID)
                    AND AI.IO_DATE            BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
               ORDER BY AI.IO_DATE
                      ;


       END SELECT_DAY_SECOM_AFTER;


       -- [출퇴근조회(기간별)] - 2011-07-26, [2011-08-11] 수정
       PROCEDURE SELECT_DAY_PERIOD( P_CURSOR         OUT  TYPES.TCURSOR
                                  , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                  , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                  , W_WORK_DATE_FR   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                  , W_WORK_DATE_TO   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                  , W_FLOOR_ID       IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                                  , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                  )

       AS
         V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
       BEGIN
             /*-- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => 65
                                        , W_START_DATE  => W_WORK_DATE_FR
                                        , W_END_DATE    => W_WORK_DATE_TO
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                --V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID; --[2011-12-16]
                V_CONNECT_PERSON_ID := -1;
             END IF;*/
             
             OPEN P_CURSOR FOR
                 SELECT DI.WORK_DATE
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY
                      , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)        AS DUTY_NAME
                      , DI.NEXT_DAY_YN  AS N
                      , DI.ALL_NIGHT_YN AS A
                      , CASE
                             WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                             ELSE DI.OPEN_TIME
                        END AS OPEN_TIME_AFTER
                      , CASE
                             WHEN (DI.NEXT_DAY_YN   = 'Y'
                                OR DI.HOLY_TYPE    IN('N', '3')
                                OR DI.DANGJIK_YN    = 'Y'
                                OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                                   FROM HRD_DAY_INTERFACE S_DI
                                                                                                                  WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                                ))
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- 휴일근무
                                                             AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) > 
                                                                   TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                            THEN DECODE(DI.MODIFY_OUT_YN
                                                                       , 'Y', O_DM.MODIFY_TIME
                                                                       , (SELECT S_DI.CLOSE_TIME
                                                                            FROM HRD_DAY_INTERFACE     S_DI
                                                                           WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                         ))
                             WHEN (SELECT S_DI.HOLY_TYPE
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = '3' -- 야간
                                      AND(DI.DUTY_ID        = 1174 -- 경조휴가
                                       OR DI.DUTY_ID        = 1170 -- 교육
                                       OR DI.DUTY_ID        = 1175 -- 년차
                                       OR DI.DUTY_ID        = 1189 -- 무급휴가
                                       OR DI.DUTY_ID        = 1182 -- 무급휴일
                                       OR DI.DUTY_ID        = 1172 -- 파견
                                       OR DI.DUTY_ID        = 1190 -- 유급휴가
                                       OR DI.DUTY_ID        = 1173 -- 출장
                                       OR DI.DUTY_ID        = 1171 -- 훈련
                                       OR DI.DUTY_ID        = 1188 -- 휴일
                                         ) THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME)  IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188 -- 휴일
                                                       AND (SELECT S_DI.ALL_NIGHT_YN
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID IN ( 1173 -- 출장
                                                                         , 1174 -- 경조휴가
                                                                         , 1175 -- 년차
                                                                         , 1177 -- 보건휴가
                                                                         , 1178 -- 연중휴가
                                                                         , 1179 -- 대체휴무
                                                                         , 1182 -- 무급휴일
                                                                         , 1187 -- 휴일근무
                                                                         , 1188 -- 휴일
                                                                         , 1189 -- 무급휴가
                                                                         , 1190 -- 유급휴가
                                                                         , 1194 -- 당직
                                                                         , 3784 -- 철야
                                                                         )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- 휴일근무
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- 철야
                                                       ) THEN NULL
                             /* -- 전호수 수정(조선미S 요청) -- 
                             WHEN (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 후일퇴근
                                      AND(DI.DUTY_ID        = 1174 -- 경조휴가
                                       OR DI.DUTY_ID        = 1170 -- 교육
                                       OR DI.DUTY_ID        = 1175 -- 년차
                                       OR DI.DUTY_ID        = 1189 -- 무급휴가
                                       OR DI.DUTY_ID        = 1182 -- 무급휴일
                                       OR DI.DUTY_ID        = 1172 -- 파견
                                       OR DI.DUTY_ID        = 1190 -- 유급휴가
                                       OR DI.DUTY_ID        = 1173 -- 출장
                                       OR DI.DUTY_ID        = 1171 -- 훈련
                                       OR DI.DUTY_ID        = 1188 -- 휴일
                                         ) THEN NULL*/
                             WHEN DI.DUTY_ID        = 1168 -- 출근
                                  AND (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- 후일퇴근
                                      THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                              FROM HRD_DAY_INTERFACE S_DI
                                                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                               AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                           ))
                             WHEN DI.DUTY_ID  = 1168 -- 출근
                                  AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                  AND (SELECT S_DI.ALL_NIGHT_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- 전일 철야
                                      THEN NULL
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                             ELSE DI.CLOSE_TIME
                        END           AS CLOSE_TIME_AFTER
                      , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS I_MODIFY_DESC
                      , DI.MODIFY_FLAG  AS M
                      , DI.TRANS_YN     AS TRANS_YN
                      --, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                      , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1187 THEN '' -- 휴일근무
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1168 -- 출근
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1169 -- 결근
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND(SELECT S_DI.HOLY_TYPE
                                                             FROM HRD_DAY_INTERFACE   S_DI
                                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                          ) = '3' -- 야간
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1168 -- 출근
                                                       AND DI.HOLY_TYPE  = '3'  -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1168  -- 출근
                                                       AND DI.HOLY_TYPE  = '3'   -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.DUTY_ID    = 1169  -- 결근
                                                       AND DI.HOLY_TYPE  = '3'   -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                            ) IS NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                       AND DI.CLOSE_TIME   IS NULL
                                                       AND DI.DUTY_ID      = 1187 -- 휴일근무
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                       AND DI.HOLY_TYPE    = '1'  -- 휴일
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188      -- 휴일
                                                       AND (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1177 -- 보건휴가
                                                       AND (SELECT DI.HOLY_TYPE
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '3' THEN '' -- 야간
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- 휴일근무
                                                             AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                             AND (SELECT S_DI.CLOSE_TIME
                                                                    FROM HRD_DAY_INTERFACE     S_DI
                                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                 ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                       AND(SELECT S_DI.DUTY_ID -- 휴일근무
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187 -- 휴일근무
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND(SELECT S_DI.CLOSE_TIME
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                          ) IS NOT NULL
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- 휴일근무
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                       AND DI.OPEN_TIME    IS NOT NULL
                                                       AND(SELECT S_DI.CLOSE_TIME
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                          ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                       AND DI.CLOSE_TIME   IS NOT NULL
                                                       AND(SELECT S_DI.DUTY_ID -- 휴일근무
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187  -- 휴일근무
                                                       AND(SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                             FROM HRD_DAY_INTERFACE_V   S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND((SELECT S_DI.HOLY_TYPE    -- 야간
                                                              FROM HRD_DAY_INTERFACE   S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = '3'
                                                        OR (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                              FROM HRD_DAY_INTERFACE_V S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = 'Y') THEN ''
                             ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                        END  AS APPROVE_STATUS_NAME
                      , DI.OPEN_TIME  AS OPEN_TIME_BEFORE
                      , DI.CLOSE_TIME AS CLOSE_TIME_BEFORE
                      , DI.DANGJIK_YN   AS D
                      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                      , DI.DESCRIPTION
                      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                      , PM.PERSON_NUM AS PERSON_NUMBER
                      , PM.NAME       AS PERSON_NAME
                      , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(DI.WORK_TYPE_ID)    AS WORK_TYPE
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                      , PM.JOIN_DATE
                      , PM.RETIRE_DATE
                   FROM HRD_DAY_INTERFACE_V DI
                      , HRM_PERSON_MASTER PM
                      , HRM_FLOOR_V HF
                      , HRM_POST_CODE_V PC
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                              , HL.OCPT_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE  <=  W_WORK_DATE_TO
                                                            AND S_HL.PERSON_ID     =  HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                      , HRD_DAY_MODIFY I_DM
                      , HRD_DAY_MODIFY O_DM
                WHERE DI.PERSON_ID                          =  PM.PERSON_ID
                  AND DI.SOB_ID                             =  PM.SOB_ID
                  AND DI.ORG_ID                             =  PM.ORG_ID
                  AND PM.FLOOR_ID                           =  HF.FLOOR_ID
                  AND PM.POST_ID                            =  PC.POST_ID
                  AND PM.PERSON_ID                          =  T1.PERSON_ID
                  AND PM.PERSON_ID                          =  T2.PERSON_ID
                  AND DI.PERSON_ID                          =  I_DM.PERSON_ID(+)
                  AND DI.WORK_DATE                          =  I_DM.WORK_DATE(+)
                  AND '1'                                   =  I_DM.IO_FLAG(+)
                  AND DI.PERSON_ID                          =  O_DM.PERSON_ID(+)
                  AND DI.WORK_DATE                          =  O_DM.WORK_DATE(+)
                  AND '2'                                   =  O_DM.IO_FLAG(+)
                  AND DI.SOB_ID                             =  W_SOB_ID
                  AND DI.ORG_ID                             =  W_ORG_ID
                  AND DI.WORK_DATE                             BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                  AND T2.FLOOR_ID                           =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                  AND DI.PERSON_ID                          =  NVL(W_PERSON_ID, DI.PERSON_ID)
                  /*AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PM.WORK_CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                               AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.START_DATE                              <= W_WORK_DATE_TO
                               AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE_FR)
                               AND DM.SOB_ID                                   = PM.SOB_ID
                               AND DM.ORG_ID                                   = PM.ORG_ID
                           )*/
             ORDER BY HF.FLOOR_CODE
                    , PM.WORK_TYPE_ID
                    , PM.NAME
                    , DI.WORK_DATE
                    ;


       END SELECT_DAY_PERIOD;


       -- [출퇴근조회(개인별)] - 2011-07-27
       PROCEDURE SELECT_DAY_PERIOD_USER_BEFORE( P_CURSOR         OUT  TYPES.TCURSOR
                                              , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                              , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                              , W_WORK_DATE_FR   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                              , W_WORK_DATE_TO   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                              , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                              )

       AS

       BEGIN

                 OPEN P_CURSOR FOR
                 SELECT DI.WORK_DATE
                      , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1) AS W
                      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)         AS DUTY_NAME
                      , DI.OPEN_TIME                               AS OPEN_TIME
                      , DI.CLOSE_TIME                              AS CLOSE_TIME
                      , DI.OPEN_TIME1                              AS OPEN_TIME1
                      , DI.CLOSE_TIME1                             AS CLOSE_TIME1
                      , PM.DISPLAY_NAME                            AS PERSON_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.PAY_GRADE_ID)    AS PAY_GRADE_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                      , DI.PERSON_ID
                   FROM HRD_DAY_INTERFACE DI
                      , HRM_PERSON_MASTER PM
                      , HRM_FLOOR_V       HF
                      , HRM_POST_CODE_V   PC
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.OCPT_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CLASS_ID
                              , HL.JOB_CATEGORY_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE  <= W_WORK_DATE_TO
                                                            AND S_HL.PERSON_ID     = HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                            AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                        ) T2
                  WHERE DI.PERSON_ID                               = PM.PERSON_ID
                    AND PM.FLOOR_ID                                = HF.FLOOR_ID
                    AND PM.POST_ID                                 = PC.POST_ID
                    AND DI.WORK_CORP_ID                            = PM.WORK_CORP_ID
                    AND DI.SOB_ID                                  = PM.SOB_ID
                    AND DI.ORG_ID                                  = PM.ORG_ID
                    AND PM.PERSON_ID                               = T1.PERSON_ID
                    AND PM.PERSON_ID                               = T2.PERSON_ID
                    AND DI.SOB_ID                                  = W_SOB_ID
                    AND DI.ORG_ID                                  = W_ORG_ID
                    AND DI.WORK_DATE                               BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                    AND DI.PERSON_ID                               = W_PERSON_ID
               ORDER BY DI.WORK_DATE
                      ;


       END SELECT_DAY_PERIOD_USER_BEFORE;


       -- [출퇴근조회(개인별)] - 2011-08-06, [2011-08-11] 수정
       PROCEDURE SELECT_DAY_PERIOD_USER_AFTER( P_CURSOR         OUT  TYPES.TCURSOR
                                             , W_SOB_ID         IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                                             , W_ORG_ID         IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                                             , W_WORK_DATE_FR   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                             , W_WORK_DATE_TO   IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                                             , W_PERSON_ID      IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                                             )

       AS

       BEGIN

                 OPEN P_CURSOR FOR
                 SELECT DI.WORK_DATE
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY
                      , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)        AS DUTY_NAME
                      , DI.NEXT_DAY_YN  AS N
                      , DI.ALL_NIGHT_YN AS A
                      , CASE
                             WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                             ELSE DI.OPEN_TIME
                        END AS OPEN_TIME
                      , CASE
                             WHEN (DI.NEXT_DAY_YN   = 'Y'
                                OR DI.HOLY_TYPE    IN('N', '3')
                                OR DI.DANGJIK_YN    = 'Y'
                                OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                                   FROM HRD_DAY_INTERFACE S_DI
                                                                                                                  WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                                ))
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- 휴일근무
                                                             AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) > TO_DATE(TO_CHAR(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                            THEN DECODE(DI.MODIFY_OUT_YN
                                                                       , 'Y', O_DM.MODIFY_TIME
                                                                       , (SELECT S_DI.CLOSE_TIME
                                                                            FROM HRD_DAY_INTERFACE     S_DI
                                                                           WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                         ))
                             WHEN (SELECT S_DI.HOLY_TYPE
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = '3' -- 야간
                                      AND(DI.DUTY_ID        = 1174 -- 경조휴가
                                       OR DI.DUTY_ID        = 1170 -- 교육
                                       OR DI.DUTY_ID        = 1175 -- 년차
                                       OR DI.DUTY_ID        = 1189 -- 무급휴가
                                       OR DI.DUTY_ID        = 1182 -- 무급휴일
                                       OR DI.DUTY_ID        = 1172 -- 파견
                                       OR DI.DUTY_ID        = 1190 -- 유급휴가
                                       OR DI.DUTY_ID        = 1173 -- 출장
                                       OR DI.DUTY_ID        = 1171 -- 훈련
                                       OR DI.DUTY_ID        = 1188 -- 휴일
                                         ) THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188 -- 휴일
                                                       AND (SELECT S_DI.ALL_NIGHT_YN
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID IN ( 1173 -- 출장
                                                                         , 1174 -- 경조휴가
                                                                         , 1175 -- 년차
                                                                         , 1177 -- 보건휴가
                                                                         , 1178 -- 연중휴가
                                                                         , 1179 -- 대체휴무
                                                                         , 1182 -- 무급휴일
                                                                         , 1187 -- 휴일근무
                                                                         , 1188 -- 휴일
                                                                         , 1189 -- 무급휴가
                                                                         , 1190 -- 유급휴가
                                                                         , 1194 -- 당직
                                                                         , 3784 -- 철야
                                                                         )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- 휴일근무
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- 철야
                                                       ) THEN NULL
                             /* -- 전호수 수정(2013-05-27) : 조선미s 요청 -- 
                             WHEN (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 후일퇴근
                                      AND(DI.DUTY_ID        = 1174 -- 경조휴가
                                       OR DI.DUTY_ID        = 1170 -- 교육
                                       OR DI.DUTY_ID        = 1175 -- 년차
                                       OR DI.DUTY_ID        = 1189 -- 무급휴가
                                       OR DI.DUTY_ID        = 1182 -- 무급휴일
                                       OR DI.DUTY_ID        = 1172 -- 파견
                                       OR DI.DUTY_ID        = 1190 -- 유급휴가
                                       OR DI.DUTY_ID        = 1173 -- 출장
                                       OR DI.DUTY_ID        = 1171 -- 훈련
                                       OR DI.DUTY_ID        = 1188 -- 휴일
                                         ) THEN NULL*/
                             WHEN DI.DUTY_ID        = 1168 -- 출근
                                  AND (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- 후일퇴근
                                      THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                              FROM HRD_DAY_INTERFACE S_DI
                                                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                               AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                           ))
                             WHEN DI.DUTY_ID  = 1168 -- 출근
                                  AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                  AND (SELECT S_DI.ALL_NIGHT_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- 전일 철야
                                      THEN NULL
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                             ELSE DI.CLOSE_TIME
                        END AS CLOSE_TIME
                      , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS I_MODIFY_DESC
                      --, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                      , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1187 THEN '' -- 휴일근무
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1168 -- 출근
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1169 -- 결근
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND(SELECT S_DI.HOLY_TYPE
                                                             FROM HRD_DAY_INTERFACE   S_DI
                                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                          ) = '3' -- 야간
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1168 -- 출근
                                                       AND DI.HOLY_TYPE  = '3'  -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1168  -- 출근
                                                       AND DI.HOLY_TYPE  = '3'   -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.DUTY_ID    = 1169  -- 결근
                                                       AND DI.HOLY_TYPE  = '3'   -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                            ) IS NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                       AND DI.CLOSE_TIME   IS NULL
                                                       AND DI.DUTY_ID      = 1187 -- 휴일근무
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                       AND DI.HOLY_TYPE    = '1'  -- 휴일
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188      -- 휴일
                                                       AND (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1177 -- 보건휴가
                                                       AND (SELECT DI.HOLY_TYPE
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '3' THEN '' -- 야간
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- 휴일근무
                                                             AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                             AND (SELECT S_DI.CLOSE_TIME
                                                                    FROM HRD_DAY_INTERFACE     S_DI
                                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                 ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                       AND(SELECT S_DI.DUTY_ID -- 휴일근무
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187 -- 휴일근무
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND(SELECT S_DI.CLOSE_TIME
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                          ) IS NOT NULL
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- 휴일근무
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                       AND DI.OPEN_TIME    IS NOT NULL
                                                       AND(SELECT S_DI.CLOSE_TIME
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                          ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                       AND DI.CLOSE_TIME   IS NOT NULL
                                                       AND(SELECT S_DI.DUTY_ID -- 휴일근무
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187  -- 휴일근무
                                                       AND(SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                             FROM HRD_DAY_INTERFACE_V   S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND((SELECT S_DI.HOLY_TYPE    -- 야간
                                                              FROM HRD_DAY_INTERFACE   S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = '3'
                                                        OR (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                              FROM HRD_DAY_INTERFACE_V S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = 'Y') THEN ''
                             ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                        END  AS APPROVE_STATUS_NAME
                      , DI.TRANS_YN AS TRANS_YN
                      , DI.DANGJIK_YN   AS D
                      , CASE
                             WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                             ELSE DI.OPEN_TIME1
                        END AS OPEN_TIME1
                      , CASE
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                             ELSE DI.CLOSE_TIME1
                        END AS CLOSE_TIME1
                      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                      , DI.DESCRIPTION
                      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
                      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                      , PM.PERSON_NUM AS PERSON_NUMBER
                      , PM.NAME       AS PERSON_NAME
                      , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(DI.WORK_TYPE_ID)    AS WORK_TYPE
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                      , PM.JOIN_DATE
                      , PM.RETIRE_DATE
                   FROM HRD_DAY_INTERFACE_V DI
                      , HRM_PERSON_MASTER PM
                      , HRM_FLOOR_V HF
                      , HRM_POST_CODE_V PC
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                              , HL.OCPT_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE  <=  W_WORK_DATE_TO
                                                            AND S_HL.PERSON_ID     =  HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                      , HRD_DAY_MODIFY I_DM
                      , HRD_DAY_MODIFY O_DM
                WHERE DI.PERSON_ID                          =  PM.PERSON_ID
                  AND DI.WORK_CORP_ID                       =  PM.WORK_CORP_ID
                  AND DI.SOB_ID                             =  PM.SOB_ID
                  AND DI.ORG_ID                             =  PM.ORG_ID
                  AND PM.FLOOR_ID                           =  HF.FLOOR_ID
                  AND PM.POST_ID                            =  PC.POST_ID
                  AND PM.PERSON_ID                          =  T1.PERSON_ID
                  AND PM.PERSON_ID                          =  T2.PERSON_ID
                  AND DI.PERSON_ID                          =  I_DM.PERSON_ID(+)
                  AND DI.WORK_DATE                          =  I_DM.WORK_DATE(+)
                  AND '1'                                   =  I_DM.IO_FLAG(+)
                  AND DI.PERSON_ID                          =  O_DM.PERSON_ID(+)
                  AND DI.WORK_DATE                          =  O_DM.WORK_DATE(+)
                  AND '2'                                   =  O_DM.IO_FLAG(+)
                  AND DI.SOB_ID                             =  W_SOB_ID
                  AND DI.ORG_ID                             =  W_ORG_ID
                  AND DI.WORK_DATE                             BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                  AND DI.PERSON_ID                          =  W_PERSON_ID
             ORDER BY DI.WORK_DATE
                    ;


       END SELECT_DAY_PERIOD_USER_AFTER;


       -- DEFAULT DATE TIME - 2011-07-15
       PROCEDURE WORK_IO_TIME_F( W_WORK_TYPE                         IN VARCHAR2
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
                      INTO  O_OPEN_TIME
                          , O_CLOSE_TIME
                       FROM HRM_WORK_IO_TIME_V WIT
                      WHERE WIT.WORK_TYPE        = W_WORK_TYPE
                        AND WIT.HOLY_TYPE        = W_HOLY_TYPE
                        AND WIT.SOB_ID           = W_SOB_ID
                        AND WIT.ORG_ID           = W_ORG_ID
                          ;

             EXCEPTION
                  WHEN OTHERS
                  THEN
                  IF W_HOLY_TYPE IN (0, 1) THEN
                     O_OPEN_TIME   := TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') ||  ' ' || '08:30', 'YYYY-MM-DD HH24:MI');
                     O_CLOSE_TIME  := TO_DATE(TO_CHAR(W_WORK_DATE, 'YYYY-MM-DD') ||  ' ' || '17:30', 'YYYY-MM-DD HH24:MI');
                  ELSE
                       O_OPEN_TIME  := NULL;
                       O_CLOSE_TIME := NULL;
                  END IF;
             END;

       END WORK_IO_TIME_F;


-- 휴일근무 계획표.
  PROCEDURE SELECT_OT_PLAN
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
      , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT T1.PERSON_NUM
           , T1.NAME
           , T1.DEPT_NAME
           , PC.POST_NAME
           , HF.FLOOR_NAME
           , OL.WORK_DATE
           , OL.DESCRIPTION AS REMARK
           , TO_CHAR(OL.AFTER_OT_START, 'HH24:MI') AS PL_OT_START
           , TO_CHAR(OL.AFTER_OT_END, 'HH24:MI') AS PL_OT_END
           , TO_CHAR(S_DI.OPEN_TIME, 'HH24:MI') AS OPEN_TIME
           , TO_CHAR(NVL(S_DI.CLOSE_TIME1, S_DI.CLOSE_TIME), 'HH24:MI') AS CLOSE_TIME
           , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS
           , HRM_PERSON_MASTER_G.NAME_F(OH.APPROVED_PERSON_ID) APPROVED_PERSON
           , OH.DESCRIPTION
           , T1.PERSON_ID
           , T1.DEPT_CODE
        FROM HRD_OT_HEADER OH
          , HRD_OT_LINE OL
          , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , PM.PERSON_NUM
                , PM.NAME
                , HL.DEPT_ID
                , ( SELECT DMT.DEPT_CODE
                      FROM HRM_DEPT_MASTER_TLV DMT
                        , HRM_DEPT_MASTER DM
                    WHERE DMT.DEPT_ID   = DM.UPPER_DEPT_ID
                      AND DM.DEPT_ID    = HL.DEPT_ID
                  ) AS DEPT_CODE
                , ( SELECT DMT.DEPT_NAME
                      FROM HRM_DEPT_MASTER_TLV DMT
                        , HRM_DEPT_MASTER DM
                    WHERE DMT.DEPT_ID   = DM.UPPER_DEPT_ID
                      AND DM.DEPT_ID    = HL.DEPT_ID
                  ) AS DEPT_NAME
                , HL.POST_ID
                , HL.JOB_CATEGORY_ID
              FROM HRM_PERSON_MASTER PM
                , HRM_HISTORY_LINE HL
            WHERE PM.PERSON_ID        = HL.PERSON_ID
              AND PM.JOIN_DATE        <= W_WORK_DATE
              AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
              AND EXISTS ( SELECT 'X'
                             FROM HRM_JOB_CATEGORY_CODE_V JC
                           WHERE JC.JOB_CATEGORY_ID       = HL.JOB_CATEGORY_ID
                             AND JC.JOB_CATEGORY_CODE     = '10'
                          )
              AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
            ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
          , HRM_POST_CODE_V PC
          , HRM_FLOOR_V HF
          , ( SELECT DI.PERSON_ID
                   , CASE
                       WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                       ELSE DI.OPEN_TIME
                     END AS OPEN_TIME
                   , CASE
                       WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN
                         DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                       WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                       ELSE DI.CLOSE_TIME
                     END AS CLOSE_TIME
                   , CASE
                       WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                       ELSE DI.OPEN_TIME1
                     END AS OPEN_TIME1
                   , CASE
                       WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                       ELSE DI.CLOSE_TIME1
                     END AS CLOSE_TIME1
                   , DI.WORK_DATE
              FROM HRD_DAY_INTERFACE_V DI
                , HRD_DAY_MODIFY I_DM
                , HRD_DAY_MODIFY O_DM
                , (-- 후일 근무 정보 조회.
                  SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                       , DIT.PERSON_ID
                       , DIT.CORP_ID
                       , DIT.SOB_ID
                       , DIT.ORG_ID
                       , DIT.OPEN_TIME
                       , DIT.CLOSE_TIME
                       , DIT.OPEN_TIME1
                       , DIT.CLOSE_TIME1
                  FROM HRD_DAY_INTERFACE DIT
                  WHERE DIT.WORK_DATE     = W_WORK_DATE + 1
                    AND DIT.WORK_CORP_ID  = W_CORP_ID
                    AND DIT.SOB_ID        = W_SOB_ID
                    AND DIT.ORG_ID        = W_ORG_ID
                ) N_DI
              WHERE DI.PERSON_ID                          = I_DM.PERSON_ID(+)
                AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
                AND '1'                                   = I_DM.IO_FLAG(+)
                AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
                AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
                AND '2'                                   = O_DM.IO_FLAG(+)
                AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
                AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
                AND DI.SOB_ID                             = N_DI.SOB_ID(+)
                AND DI.ORG_ID                             = N_DI.ORG_ID(+)
                AND DI.WORK_DATE                          = W_WORK_DATE
                AND DI.WORK_CORP_ID                       = W_CORP_ID
                AND DI.SOB_ID                             = W_SOB_ID
                AND DI.ORG_ID                             = W_ORG_ID
            ) S_DI
      WHERE OH.OT_HEADER_ID           = OL.OT_HEADER_ID
        AND OL.PERSON_ID              = T1.PERSON_ID
        AND T1.POST_ID                = PC.POST_ID
        AND T2.FLOOR_ID               = HF.FLOOR_ID
        AND OL.PERSON_ID              = S_DI.PERSON_ID(+)
        AND OL.WORK_DATE              = S_DI.WORK_DATE(+)
        AND OH.CORP_ID                = W_CORP_ID
        AND OL.WORK_DATE              = W_WORK_DATE
        AND OH.SOB_ID                 = W_SOB_ID
        AND OH.ORG_ID                 = W_ORG_ID
        AND OL.OT_LINE_ID             IN ( SELECT MAX(OL1.OT_LINE_ID) AS OT_LINE_ID
                                             FROM HRD_OT_LINE OL1
                                           WHERE OL1.PERSON_ID    = OL.PERSON_ID
                                             AND OL1.WORK_DATE    = OL.WORK_DATE
                                          )
      ORDER BY T1.DEPT_CODE, HF.SORT_NUM, PC.SORT_NUM, T1.PERSON_NUM
      ;
  END SELECT_OT_PLAN;

-- DATA UPDATE REQUEST.
  PROCEDURE DATA_UPDATE_REQUEST
            ( W_PERSON_ID                         IN HRD_DAY_MODIFY.PERSON_ID%TYPE
      , W_WORK_DATE                         IN HRD_DAY_MODIFY.WORK_DATE%TYPE
      , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , O_APPROVE_STATUS                    OUT VARCHAR2
            , O_APPROVE_STATUS_NAME               OUT VARCHAR2
            )
  AS
    V_APPROVE_STATUS                                  VARCHAR2(1);

  BEGIN
    BEGIN
      SELECT DI.APPROVE_STATUS
        INTO V_APPROVE_STATUS
        FROM HRD_DAY_INTERFACE DI
       WHERE DI.PERSON_ID                       = W_PERSON_ID
        AND DI.WORK_DATE                        = W_WORK_DATE
        AND DI.SOB_ID                           = W_SOB_ID
        AND DI.ORG_ID                           = W_ORG_ID
        ;
    EXCEPTION WHEN OTHERS THEN
      V_APPROVE_STATUS := '-';
    END;
    IF V_APPROVE_STATUS NOT IN('A' ,'N') THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Approval Request(승인요청)'));
    END IF;

      UPDATE HRD_DAY_INTERFACE DI
        SET DI.APPROVE_STATUS           = 'A'
          , DI.EMAIL_STATUS             = 'AR'
      WHERE DI.PERSON_ID                        = W_PERSON_ID
        AND DI.WORK_DATE                        = W_WORK_DATE
        AND DI.SOB_ID                           = W_SOB_ID
        AND DI.ORG_ID                           = W_ORG_ID
      ;

      O_APPROVE_STATUS := 'A';
      BEGIN
        SELECT HAS.APPROVE_STEP_NAME
          INTO O_APPROVE_STATUS_NAME
          FROM HRM_APPROVE_STATUS_V HAS
        WHERE HAS.APPROVE_STEP        = O_APPROVE_STATUS
          AND ROWNUM                  <= 1
        ;
      EXCEPTION
        WHEN OTHERS THEN
          O_APPROVE_STATUS_NAME := '미승인';
      END;

  END DATA_UPDATE_REQUEST;

-- DATA UPDATE - STEP APPROVE.[2011-11-10]
  PROCEDURE DATA_UPDATE_APPROVE
           ( W_PERSON_ID                          IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_CORP_ID                      IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_APPROVE_STATUS                    IN HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
            , P_CHECK_YN                          IN VARCHAR2
            , P_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_APPROVE_FLAG                      IN VARCHAR2
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
      )
  AS
      V_APPROVE_STATUS   HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE := 'N';
      D_SYSDATE          HRD_DAY_INTERFACE.CREATION_DATE%TYPE := NULL;
      V_CAP_B            VARCHAR2(1) := 'N';
      V_CAP_C            VARCHAR2(1) := 'N';
      V_USER_CAP         VARCHAR2(10);

  BEGIN
            D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

            V_USER_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_WORK_CORP_ID
                                                  , W_START_DATE   =>  D_SYSDATE
                                                  , W_END_DATE     =>  D_SYSDATE
                                                  , W_MODULE_CODE  =>  '20'
                                                  , W_PERSON_ID    =>  P_CONNECT_PERSON_ID
                                                  , W_SOB_ID       =>  W_SOB_ID
                                                  , W_ORG_ID       =>  W_ORG_ID);
            --권한이 없으면[2012-01-06]주석지정
            --IF V_USER_CAP <> 'C' THEN
            --   RAISE_APPLICATION_ERROR(-20001, '수정할 수 없습니다.');
            --END IF;


    BEGIN
      SELECT HRM_MANAGER_G.USER_CAP_F
                             (PM.WORK_CORP_ID
                             , TRUNC(W_WORK_DATE)
                             , TRUNC(W_WORK_DATE)
                             , '20'
                             , P_CONNECT_PERSON_ID
                             , PM.SOB_ID
                             , PM.ORG_ID) AS CAP_C
           , HRD_DUTY_MANAGER_G.APPROVER_CAP_F
                             ( NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                             , P_CONNECT_PERSON_ID
                             , PM.SOB_ID
                             , PM.ORG_ID) AS CAP_B
        INTO V_CAP_C, V_CAP_B
      FROM HRD_DAY_INTERFACE DI
        , HRM_PERSON_MASTER PM
        , (-- 시점 인사내역.
            SELECT HL.PERSON_ID
                , HL.DEPT_ID
                , HL.POST_ID
                , HL.JOB_CATEGORY_ID
            FROM HRM_HISTORY_LINE HL
            WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                            FROM HRM_HISTORY_LINE S_HL
                                           WHERE S_HL.CHARGE_DATE            <= TRUNC(W_WORK_DATE)
                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                           GROUP BY S_HL.PERSON_ID
                                         )
          ) T1
               , (-- 시점 인사내역.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
      WHERE DI.PERSON_ID            = PM.PERSON_ID
        AND PM.PERSON_ID            = T1.PERSON_ID
        AND PM.PERSON_ID            = T2.PERSON_ID
        AND DI.PERSON_ID            = W_PERSON_ID
        AND DI.WORK_DATE            = W_WORK_DATE
        AND DI.SOB_ID               = W_SOB_ID
        AND DI.ORG_ID               = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CAP_B := 'N';
      V_CAP_C := 'N';
    END;

  IF P_APPROVE_STATUS = 'A' AND P_APPROVE_FLAG = 'OK' THEN
  -- 미승인 --> 1차 승인 : 승인.
      IF V_CAP_B <> 'Y' THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
        RETURN;
      END IF;

     UPDATE HRD_DAY_INTERFACE DI
      SET DI.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', DECODE(DI.MODIFY_IN_YN, 'Y', 'Y', DI.APPROVED_YN), DI.APPROVED_YN)
       , DI.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', DECODE(DI.MODIFY_IN_YN, 'Y', D_SYSDATE, DI.APPROVED_DATE), DI.APPROVED_DATE)
       --, DI.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', DECODE(DI.MODIFY_IN_YN, 'Y', P_CONNECT_PERSON_ID, DI.APPROVED_PERSON_ID), DI.APPROVED_PERSON_ID)
       , DI.APPROVED_PERSON_ID               = P_CONNECT_PERSON_ID
       --[2011-08-20]주석처리
       --, DI.APPROVED_OUT_YN                  = DECODE(P_CHECK_YN, 'Y', DECODE(DI.MODIFY_OUT_YN, 'Y', 'Y', DI.APPROVED_YN), DI.APPROVED_YN)
       --, DI.APPROVED_OUT_DATE                = DECODE(P_CHECK_YN, 'Y', DECODE(DI.MODIFY_OUT_YN, 'Y', D_SYSDATE, DI.APPROVED_DATE), DI.APPROVED_DATE)
       --, DI.APPROVED_OUT_PERSON_ID           = DECODE(P_CHECK_YN, 'Y', DECODE(DI.MODIFY_OUT_YN, 'Y', P_CONNECT_PERSON_ID, DI.APPROVED_PERSON_ID), DI.APPROVED_PERSON_ID)
       , DI.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'B', DI.APPROVE_STATUS)
       , DI.EMAIL_STATUS                     = 'AR'
       , DI.LAST_UPDATE_DATE                 = D_SYSDATE
       , DI.LAST_UPDATED_BY                  = P_USER_ID
       , DI.ATTRIBUTE1                       = DI.APPROVED_PERSON_ID
     WHERE DI.PERSON_ID                       = W_PERSON_ID
       AND DI.WORK_DATE                       = W_WORK_DATE
      AND DI.SOB_ID                           = W_SOB_ID
      AND DI.ORG_ID                           = W_ORG_ID
     ;

  ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'CANCEL' THEN
  -- 1차 승인 --> 미승인 : 승인 취소.
    IF V_CAP_B <> 'Y' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
      RETURN;
    END IF;

      BEGIN
   -- 현재 상태.
     SELECT DI.APPROVE_STATUS
        INTO V_APPROVE_STATUS
      FROM HRD_DAY_INTERFACE DI
      WHERE DI.PERSON_ID                     = W_PERSON_ID
       AND DI.WORK_DATE                      = W_WORK_DATE
       AND DI.SOB_ID                         = W_SOB_ID
       AND DI.ORG_ID                         = W_ORG_ID
      ;
     EXCEPTION WHEN OTHERS THEN
       V_APPROVE_STATUS := '-';
     END;
     IF V_APPROVE_STATUS <> 'B' THEN
     -- 1ST 승인단계가 아니면 오류 발생.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=취소'));
        RETURN;
     END IF;

     UPDATE HRD_DAY_INTERFACE DI
      SET DI.APPROVED_YN                      = DECODE(P_CHECK_YN, 'Y', 'N', DI.APPROVED_YN)
       , DI.APPROVED_DATE                    = DECODE(P_CHECK_YN, 'Y', NULL, DI.APPROVED_DATE)
       --, DI.APPROVED_PERSON_ID               = DECODE(P_CHECK_YN, 'Y', NULL, DI.APPROVED_PERSON_ID)
       , DI.APPROVED_OUT_YN                  = DECODE(P_CHECK_YN, 'Y', 'N', DI.APPROVED_OUT_YN)
       , DI.APPROVED_OUT_DATE                = DECODE(P_CHECK_YN, 'Y', NULL, DI.APPROVED_OUT_DATE)
       , DI.APPROVED_OUT_PERSON_ID           = DECODE(P_CHECK_YN, 'Y', NULL, DI.APPROVED_OUT_PERSON_ID)
       , DI.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'A', DI.APPROVE_STATUS)
       , DI.EMAIL_STATUS                     = 'AR'
       , DI.LAST_UPDATE_DATE                 = D_SYSDATE
       , DI.LAST_UPDATED_BY                  = P_USER_ID
       , DI.ATTRIBUTE1                       = DI.APPROVED_PERSON_ID
     WHERE DI.PERSON_ID                      = W_PERSON_ID
       AND DI.WORK_DATE                      = W_WORK_DATE
       AND DI.SOB_ID                         = W_SOB_ID
       AND DI.ORG_ID                         = W_ORG_ID
     ;

  ELSIF P_APPROVE_STATUS = 'B' AND P_APPROVE_FLAG = 'OK' THEN
  -- 1차 승인  --> 인사 승인: 승인.
    IF V_CAP_C <> 'C' THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
      RETURN;
    END IF;

    UPDATE HRD_DAY_INTERFACE DI
      SET  DI.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'Y', DI.CONFIRMED_YN)
         , DI.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', D_SYSDATE, DI.CONFIRMED_DATE)
         --, DI.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', P_CONNECT_PERSON_ID, DI.CONFIRMED_PERSON_ID)
         , DI.CONFIRMED_PERSON_ID              = P_CONNECT_PERSON_ID
         , DI.APPROVE_STATUS                   = DECODE(P_CHECK_YN, 'Y', 'C', DI.APPROVE_STATUS)
         , DI.LAST_UPDATE_DATE                 = D_SYSDATE
         , DI.LAST_UPDATED_BY                  = P_USER_ID
         , DI.ATTRIBUTE2                       = DI.CONFIRMED_PERSON_ID
    WHERE DI.PERSON_ID                        = W_PERSON_ID
      AND DI.WORK_DATE                        = W_WORK_DATE
      AND DI.SOB_ID                           = W_SOB_ID
      AND DI.ORG_ID                           = W_ORG_ID
    ;
  ELSIF P_APPROVE_STATUS = 'C' AND P_APPROVE_FLAG = 'CANCEL' THEN
  -- 확정 승인 --> 1차 승인 : 승인 취소.
      IF V_CAP_C <> 'C' THEN
        RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);
        RETURN;
      END IF;
      BEGIN
      -- 현재 상태.
      SELECT DI.APPROVE_STATUS
        INTO V_APPROVE_STATUS
        FROM HRD_DAY_INTERFACE DI
      WHERE DI.PERSON_ID                      = W_PERSON_ID
        AND DI.WORK_DATE                      = W_WORK_DATE
        AND DI.SOB_ID                         = W_SOB_ID
        AND DI.ORG_ID                         = W_ORG_ID
      ;
      EXCEPTION WHEN OTHERS THEN
      V_APPROVE_STATUS := '-';
      END;
     IF V_APPROVE_STATUS <> 'C' THEN
     -- 1ST 승인단계가 아니면 오류 발생.
       RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=취소'));
       RETURN;
     END IF;

     UPDATE HRD_DAY_INTERFACE DI
      SET DI.CONFIRMED_YN                     = DECODE(P_CHECK_YN, 'Y', 'N', DI.CONFIRMED_YN)
       , DI.CONFIRMED_DATE                   = DECODE(P_CHECK_YN, 'Y', NULL, DI.CONFIRMED_DATE)
       --, DI.CONFIRMED_PERSON_ID              = DECODE(P_CHECK_YN, 'Y', NULL, DI.CONFIRMED_PERSON_ID)
       , DI.APPROVE_STATUS                   = 'B'
       , DI.LAST_UPDATE_DATE                 = D_SYSDATE
       , DI.LAST_UPDATED_BY                  = P_USER_ID
       , DI.ATTRIBUTE2                       = DI.CONFIRMED_PERSON_ID
     WHERE DI.PERSON_ID                        = W_PERSON_ID
       AND DI.WORK_DATE                        = W_WORK_DATE
       AND DI.SOB_ID                           = W_SOB_ID
       AND DI.ORG_ID                           = W_ORG_ID
     ;

  ELSE
  -- 승인단계 선택 안함.
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
    RETURN;
  END IF;
 END DATA_UPDATE_APPROVE;


-- WORK DATE TIME 정리.
  PROCEDURE WORK_DATE
           ( P_CORP_ID                               IN HRD_DUTY_PERIOD.CORP_ID%TYPE
          , P_PERSON_ID                             IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
          , P_SOB_ID                                IN HRD_DUTY_PERIOD.SOB_ID%TYPE
          , P_ORG_ID                                IN HRD_DUTY_PERIOD.ORG_ID%TYPE
          , P_START_DATE                            IN HRD_DUTY_PERIOD.START_DATE%TYPE
          , P_END_DATE                              IN HRD_DUTY_PERIOD.END_DATE%TYPE
          , O_WORK_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , O_WORK_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , O_REAL_START_DATE                       OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , O_REAL_END_DATE                         OUT HRD_WORK_CALENDAR.WORK_DATE%TYPE
          )
  AS
    D_PLAN_START_DATE                                 HRD_WORK_CALENDAR.WORK_DATE%TYPE;
    D_PLAN_END_DATE                                   HRD_WORK_CALENDAR.WORK_DATE%TYPE;
    D_WORK_START_DATE                                 HRD_DUTY_PERIOD.WORK_START_DATE%TYPE := NULL;
    D_REAL_START_DATE                                 HRD_DUTY_PERIOD.REAL_START_DATE%TYPE := NULL;
    D_WORK_END_DATE                                   HRD_DUTY_PERIOD.WORK_END_DATE%TYPE := NULL;
    D_REAL_END_DATE                                   HRD_DUTY_PERIOD.REAL_END_DATE%TYPE := NULL;

 BEGIN

  -- WORK START DATE.
  IF TO_CHAR(P_START_DATE, 'HH24:MI') BETWEEN '00:01' AND '06:00' THEN
    D_WORK_START_DATE := TRUNC(P_START_DATE) - 1;
  ELSE
    D_WORK_START_DATE := TRUNC(P_START_DATE);
  END IF;
  -- WORK END DATE.
  IF TO_CHAR(P_END_DATE, 'HH24:MI') BETWEEN '00:01' AND '06:00' THEN
    D_WORK_END_DATE := TRUNC(P_END_DATE) - 1;
  ELSE
    D_WORK_END_DATE := TRUNC(P_END_DATE);
  END IF;
/*DBMS_OUTPUT.put_line('D_WORK_START_DATE : ' || TO_CHAR(D_WORK_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_WORK_END_DATE : ' || TO_CHAR(D_WORK_END_DATE, 'YYYY-MM-DD HH24:MI'));*/

/*-- 근무 계획 조회 START --*/
  IF TO_CHAR(P_START_DATE, 'HH24:MI') = '00:00' THEN
     D_PLAN_START_DATE := P_START_DATE;
  ELSE
  -- 시작 근무계획 조회.
   BEGIN
    SELECT WC.OPEN_TIME
     INTO D_PLAN_START_DATE
    FROM HRD_WORK_CALENDAR WC
    WHERE WC.WORK_DATE                        = D_WORK_START_DATE
     AND WC.PERSON_ID                        = P_PERSON_ID
     AND WC.SOB_ID                           = P_SOB_ID
     AND WC.ORG_ID                           = P_ORG_ID
    ;
   EXCEPTION WHEN OTHERS THEN
    D_PLAN_START_DATE := D_WORK_START_DATE;
   END;

  END IF;

  IF TO_CHAR(P_END_DATE, 'HH24:MI') = '00:00' THEN
     D_PLAN_END_DATE := P_END_DATE;
  ELSE
  -- 종료 근무계획 조회.
   BEGIN
    SELECT WC.CLOSE_TIME
     INTO D_PLAN_END_DATE
    FROM HRD_WORK_CALENDAR WC
    WHERE WC.WORK_DATE                        = D_WORK_END_DATE
     AND WC.PERSON_ID                        = P_PERSON_ID
     AND WC.SOB_ID                           = P_SOB_ID
     AND WC.ORG_ID                           = P_ORG_ID
    ;
   EXCEPTION WHEN OTHERS THEN
    D_PLAN_END_DATE := D_WORK_END_DATE;
   END;

   END IF;
/*-- 근무 계획 조회 END --*/

/*DBMS_OUTPUT.put_line('P_START_DATE : ' || TO_CHAR(P_START_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_PLAN_START_DATE : ' || TO_CHAR(D_PLAN_START_DATE, 'YYYY-MM-DD HH24:MI') ||
          'P_END_DATE : ' || TO_CHAR(P_END_DATE, 'YYYY-MM-DD HH24:MI') ||
                    ' D_PLAN_END_DATE : ' || TO_CHAR(D_PLAN_END_DATE, 'YYYY-MM-DD HH24:MI'));*/
    IF P_START_DATE = D_PLAN_START_DATE AND P_END_DATE = D_PLAN_END_DATE THEN
    D_REAL_START_DATE := NULL;
  ELSIF P_START_DATE = D_PLAN_START_DATE AND P_END_DATE <> D_PLAN_END_DATE THEN
    D_REAL_START_DATE := P_END_DATE;
   D_REAL_END_DATE := D_PLAN_END_DATE;
  ELSE
    D_REAL_START_DATE := D_PLAN_START_DATE;
   D_REAL_END_DATE := P_START_DATE;
  END IF;
  /*
  IF P_END_DATE = D_PLAN_END_DATE THEN
    D_REAL_END_DATE := NULL;
  ELSE
    D_REAL_START_DATE := P_END_DATE;
   D_REAL_END_DATE := D_PLAN_END_DATE;
  END IF;*/

  -- 일자 반환.
  O_WORK_START_DATE := D_WORK_START_DATE;
  O_WORK_END_DATE := D_WORK_END_DATE;
  O_REAL_START_DATE := D_REAL_START_DATE;
  O_REAL_END_DATE := D_REAL_END_DATE;

 END WORK_DATE;

---------------------------------------------------------------------------------------------------
-- PROCEDURE PERIOD TIME.
  PROCEDURE LU_PERIOD_TIME
      ( P_CURSOR1                  OUT TYPES.TCURSOR1
      , W_WORK_DATE                IN HRD_DUTY_PERIOD.START_DATE%TYPE
      , W_PERSON_ID                IN HRD_DUTY_PERIOD.PERSON_ID%TYPE
      , W_CORP_ID                  IN HRD_DUTY_PERIOD.CORP_ID%TYPE
      , W_SOB_ID                   IN HRD_DUTY_PERIOD.SOB_ID%TYPE
      , W_ORG_ID                   IN HRD_DUTY_PERIOD.ORG_ID%TYPE
      , W_WORK_TYPE                IN HRM_COMMON.VALUE1%TYPE
      , W_START_YN                 IN HRM_COMMON.VALUE1%TYPE
      , W_END_YN                   HRM_COMMON.VALUE1%TYPE
      )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
    SELECT DPT.PERIOD_TIME
   FROM HRM_DUTY_PERIOD_TIME_V DPT
    , HRD_WORK_CALENDAR WC
   WHERE DPT.HOLY_TYPE                               = WC.HOLY_TYPE
    AND WC.WORK_DATE                                = W_WORK_DATE
    AND WC.PERSON_ID                                = W_PERSON_ID
    AND WC.WORK_CORP_ID                             = W_CORP_ID
    AND WC.SOB_ID                                   = W_SOB_ID
    AND WC.ORG_ID                                   = W_ORG_ID
    AND DPT.START_YN                                = NVL(W_START_YN, DPT.START_YN)
    AND DPT.END_YN                                  = NVL(W_END_YN, DPT.END_YN)
    AND DPT.EFFECTIVE_DATE_FR                       <= W_WORK_DATE
    AND (DPT.EFFECTIVE_DATE_TO IS NULL OR DPT.EFFECTIVE_DATE_TO >= W_WORK_DATE)
   ORDER BY DPT.PERIOD_TIME
      ;

  END LU_PERIOD_TIME;

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


       -- LOOKUP PERSON INFOMATION[2011-08-06]
       PROCEDURE LU_PERSON_DAY
               ( P_CURSOR3        OUT TYPES.TCURSOR3
               , W_SOB_ID         IN  HRM_PERSON_MASTER.SOB_ID%TYPE
               , W_ORG_ID         IN  HRM_PERSON_MASTER.ORG_ID%TYPE
               , W_FLOOR_ID       IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
               , W_WORK_TYPE_ID   IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
               )

       AS

       BEGIN

                 OPEN P_CURSOR3 FOR
                 SELECT HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, W_SOB_ID, W_ORG_ID) AS EMPLOYE_TYPE_NAME
                      , PM.PERSON_NUM AS PERSON_NUMBER
                      , PM.NAME       AS PERSON_NAME
                      , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                      , HRM_COMMON_G.ID_NAME_F(WT.WORK_TYPE_ID)    AS WORK_TYPE
                      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                      , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                      , PM.JOIN_DATE
                      , PM.RETIRE_DATE
                      , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                      , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)         AS OCPT_NAME
                      , WT.WORK_TYPE_ID
                      , T1.JOB_CATEGORY_ID
                      , PM.FLOOR_ID
                      , PM.CORP_ID
                      , PM.SOB_ID
                      , PM.ORG_ID
                      , PM.PERSON_ID
                   FROM HRM_PERSON_MASTER PM
                      , (-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE    <= TRUNC(SYSDATE)
                                                            AND S_HL.PERSON_ID       = HL.PERSON_ID
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  TRUNC(SYSDATE)
                            AND PH.EFFECTIVE_DATE_TO  >=  TRUNC(SYSDATE)
                        ) T2
                      , HRM_WORK_TYPE_V WT
                  WHERE PM.PERSON_ID                                = T1.PERSON_ID
                    AND PM.PERSON_ID                                = T2.PERSON_ID
                    AND PM.WORK_TYPE_ID                             = WT.WORK_TYPE_ID
                    AND PM.SOB_ID                                   = W_SOB_ID
                    AND PM.ORG_ID                                   = W_ORG_ID
                    AND T2.FLOOR_ID                                 = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                    AND PM.WORK_TYPE_ID                             = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
               ORDER BY PM.NAME
                      ;

      END LU_PERSON_DAY;


-- [2011-10-31]
   PROCEDURE LU_SELECT_DUTY
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
                AND HC.GROUP_CODE           = 'DUTY'
                AND HC.VALUE9               = 'Y'
           ORDER BY HC.CODE_NAME
                  ;

   END LU_SELECT_DUTY;


-- 현재 RECORD의 상태 리턴.
  PROCEDURE APPROVE_STATUS_R
          ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
      , O_STATUS                              OUT HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
      )
  AS
   V_APPROVE_STATUS                               HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE := '-';
 BEGIN
   BEGIN
  -- 현재 상태.
   SELECT DI.APPROVE_STATUS
    INTO V_APPROVE_STATUS
   FROM HRD_DAY_INTERFACE DI
   WHERE DI.PERSON_ID                      = W_PERSON_ID
    AND DI.WORK_DATE                      = W_WORK_DATE
    AND DI.WORK_CORP_ID                   = W_CORP_ID
    AND DI.SOB_ID                         = W_SOB_ID
    AND DI.ORG_ID                         = W_ORG_ID
   ;
  EXCEPTION WHEN OTHERS THEN
   V_APPROVE_STATUS := '-';
  END;
   O_STATUS := V_APPROVE_STATUS;

 END APPROVE_STATUS_R;

-- 현재 RECORD의 상태 리턴.
  PROCEDURE APPROVE_IO_YN_P
          ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
           , W_IO_FLAG                             IN HRD_DAY_MODIFY.IO_FLAG%TYPE
      , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
      , O_IO_YN                               OUT HRD_DAY_INTERFACE.APPROVED_YN%TYPE
      )
  AS
  BEGIN
    BEGIN
  -- 현재 상태.
   SELECT DECODE(W_IO_FLAG, '1', DI.APPROVED_YN, DI.APPROVED_OUT_YN) APPROVED_IO_YN
    INTO O_IO_YN
   FROM HRD_DAY_INTERFACE DI
   WHERE DI.PERSON_ID                      = W_PERSON_ID
    AND DI.WORK_DATE                      = W_WORK_DATE
    AND DI.WORK_CORP_ID                   = W_CORP_ID
    AND DI.SOB_ID                         = W_SOB_ID
    AND DI.ORG_ID                         = W_ORG_ID
   ;
  EXCEPTION WHEN OTHERS THEN
   O_IO_YN := 'N';
  END;
  END APPROVE_IO_YN_P;

-- 현재 RECORD의 이첩여부 리턴.
  FUNCTION TRANSFER_YN_F
          ( W_CORP_ID                             IN HRD_DAY_INTERFACE.CORP_ID%TYPE
      , W_WORK_DATE                           IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_PERSON_ID                           IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_SOB_ID                              IN HRD_DAY_INTERFACE.SOB_ID%TYPE
      , W_ORG_ID                              IN HRD_DAY_INTERFACE.ORG_ID%TYPE
      ) RETURN VARCHAR2
  AS
    V_TRANS_YN                                     HRD_DAY_INTERFACE.TRANS_YN%TYPE;
 BEGIN
   BEGIN
  -- 현재 상태.
   SELECT DI.TRANS_YN
    INTO V_TRANS_YN
   FROM HRD_DAY_INTERFACE DI
   WHERE DI.PERSON_ID                      = W_PERSON_ID
    AND DI.WORK_DATE                      = W_WORK_DATE
    AND DI.WORK_CORP_ID                   = W_CORP_ID
    AND DI.SOB_ID                         = W_SOB_ID
    AND DI.ORG_ID                         = W_ORG_ID
   ;
  EXCEPTION WHEN OTHERS THEN
   V_TRANS_YN := 'N';
  END;
    RETURN V_TRANS_YN;
  END TRANSFER_YN_F;






-- [출퇴등 승인 반려등록] [2011-11-10]
   PROCEDURE REJECT_SELECT_DAY( P_CURSOR              OUT  TYPES.TCURSOR
                              , W_SOB_ID              IN   HRD_DAY_INTERFACE.SOB_ID%TYPE
                              , W_ORG_ID              IN   HRD_DAY_INTERFACE.ORG_ID%TYPE
                              , W_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
                              , W_WORK_CORP_ID        IN   HRD_DAY_INTERFACE.CORP_ID%TYPE
                              , W_WORK_DATE           IN   HRD_DAY_INTERFACE.WORK_DATE%TYPE
                              , W_APPROVE_STATUS      IN   HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
                              , W_WORK_TYPE_ID        IN   HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
                              , W_FLOOR_ID            IN   HRM_HISTORY_LINE.FLOOR_ID%TYPE
                              , W_PERSON_ID           IN   HRD_DAY_INTERFACE.PERSON_ID%TYPE
                              )

   AS

             V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
             V_USER_CAP            VARCHAR2(10);

   BEGIN
             -- 근태권한 설정.
             V_USER_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                                                   , W_START_DATE  => W_WORK_DATE
                                                   , W_END_DATE    => W_WORK_DATE
                                                   , W_MODULE_CODE => '20'
                                                   , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                                   , W_SOB_ID      => W_SOB_ID
                                                   , W_ORG_ID      => W_ORG_ID);

             IF V_USER_CAP = 'C' AND W_APPROVE_STATUS = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSIF W_APPROVE_STATUS = 'B'AND V_USER_CAP = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT 'N' AS SELECT_YN
                  , DI.REJECT_REMARK
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)     AS FLOOR_NAME
                  , PM.NAME       AS PERSON_NAME
                  , PM.PERSON_NUM AS PERSON_NUMBER
                  , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                  , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                  , CASE
                        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                        ELSE DI.OPEN_TIME
                    END AS OPEN_TIME_MODIFY
                  , CASE
                        WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                        ELSE DI.CLOSE_TIME
                    END AS CLOSE_TIME_MODIFY
                  , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID))  AS MODIFY_DESC
                  , DI.OPEN_TIME  AS OPEN_TIME_BEFORE
                  , DI.CLOSE_TIME AS CLOSE_TIME_BEFORE
                  , CASE
                        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                        ELSE DI.OPEN_TIME1
                    END AS OPEN_TIME_MODIFY_1
                  , CASE
                        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                        ELSE DI.CLOSE_TIME1
                    END AS CLOSE_TIME_MODIFY_1
                  , DI.ALL_NIGHT_YN
                  , DI.NEXT_DAY_YN
                  , DI.DANGJIK_YN
                  , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                  , DI.DESCRIPTION
                  , DI.TRANS_YN AS TRANS_YN
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                  , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                  , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , DI.WORK_DATE
                  , DI.WORK_CORP_ID
                  , DI.PERSON_ID
               FROM HRD_DAY_INTERFACE_V DI
                  , HRM_PERSON_MASTER PM
                  , HRM_FLOOR_V HF
                  , HRM_POST_CODE_V PC
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                          , HL.JOB_CLASS_ID
                          , HL.OCPT_ID
                       FROM HRM_HISTORY_LINE HL
                      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE             S_HL
                                                      WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                     SELECT PH.PERSON_ID
                          , PH.FLOOR_ID
                          , PH.DEPT_ID
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                        AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                    ) T2
                  , HRD_DAY_MODIFY I_DM
                  , HRD_DAY_MODIFY O_DM
                  , (-- 후일 근무 정보 조회.
                     SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                          , DIT.PERSON_ID
                          , DIT.CORP_ID
                          , DIT.SOB_ID
                          , DIT.ORG_ID
                          , DIT.OPEN_TIME
                          , DIT.CLOSE_TIME
                          , DIT.OPEN_TIME1
                          , DIT.CLOSE_TIME1
                       FROM HRD_DAY_INTERFACE   DIT
                      WHERE DIT.SOB_ID        = W_SOB_ID
                        AND DIT.ORG_ID        = W_ORG_ID
                        AND DIT.WORK_CORP_ID  = W_WORK_CORP_ID
                        AND DIT.PERSON_ID     = NVL(W_PERSON_ID, DIT.PERSON_ID)
                        AND DIT.WORK_DATE     = W_WORK_DATE + 1
                    ) N_DI
              WHERE DI.PERSON_ID       =  PM.PERSON_ID
                AND DI.WORK_CORP_ID    =  PM.WORK_CORP_ID
                AND DI.SOB_ID          =  PM.SOB_ID
                AND DI.ORG_ID          =  PM.ORG_ID
                AND PM.FLOOR_ID        =  HF.FLOOR_ID
                AND PM.POST_ID         =  PC.POST_ID
                AND PM.PERSON_ID       =  T1.PERSON_ID
                AND PM.PERSON_ID       =  T2.PERSON_ID
                AND DI.PERSON_ID       =  I_DM.PERSON_ID(+)
                AND DI.WORK_DATE       =  I_DM.WORK_DATE(+)
                AND '1'                =  I_DM.IO_FLAG(+)
                AND DI.PERSON_ID       =  O_DM.PERSON_ID(+)
                AND DI.WORK_DATE       =  O_DM.WORK_DATE(+)
                AND '2'                =  O_DM.IO_FLAG(+)
                AND DI.WORK_DATE       =  N_DI.WORK_DATE(+)
                AND DI.PERSON_ID       =  N_DI.PERSON_ID(+)
                AND DI.SOB_ID          =  N_DI.SOB_ID(+)
                AND DI.ORG_ID          =  N_DI.ORG_ID(+)
                AND DI.SOB_ID          =  W_SOB_ID
                AND DI.ORG_ID          =  W_ORG_ID
                AND DI.WORK_CORP_ID    =  W_WORK_CORP_ID
                AND DI.WORK_DATE       =  W_WORK_DATE
                AND DI.PERSON_ID       =  NVL(W_PERSON_ID, DI.PERSON_ID)
                AND DI.APPROVE_STATUS  =  NVL(W_APPROVE_STATUS, DI.APPROVE_STATUS)
                AND DI.WORK_TYPE_ID    =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                AND T2.FLOOR_ID        =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                AND DI.MODIFY_FLAG     =  'Y'
                AND PM.JOIN_DATE      <=  W_WORK_DATE
                AND(PM.RETIRE_DATE IS NULL
                 OR PM.RETIRE_DATE >= W_WORK_DATE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PM.WORK_CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = NVL(T2.FLOOR_ID, PM.WORK_CORP_ID)
                               AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.START_DATE                              <= W_WORK_DATE
                               AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
                               AND DM.SOB_ID                                   = PM.SOB_ID
                               AND DM.ORG_ID                                   = PM.ORG_ID
                           )
           ORDER BY PM.WORK_TYPE_ID
                  , HF.FLOOR_CODE
                  , PM.NAME
                  ;

  END REJECT_SELECT_DAY;


-- 출퇴근 반려처리[2011-11-10]
   PROCEDURE REJECT_APPROVE_DAY
           ( W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_WORK_CORP_ID       IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_WORK_DATE          IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
           , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
           , P_APPROVE_STATUS     IN  HRD_DAY_INTERFACE.APPROVE_STATUS%TYPE
           , P_CHECK_YN           IN  VARCHAR2
           , P_REJECT_REMARK      IN  HRD_DAY_INTERFACE.REJECT_REMARK%TYPE
           )

   AS

             V_CAP_B                  VARCHAR2(1)  := 'N';
             V_CAP_C                  VARCHAR2(1)  := 'N';

   BEGIN
             BEGIN
                  SELECT HRM_MANAGER_G.USER_CAP_F( PM.WORK_CORP_ID
                                                 , TRUNC(W_WORK_DATE)
                                                 , TRUNC(W_WORK_DATE)
                                                 , '20'
                                                 , W_CONNECT_PERSON_ID
                                                 , PM.SOB_ID
                                                 , PM.ORG_ID)
                         AS CAP_C
                       , HRD_DUTY_MANAGER_G.APPROVER_CAP_F( NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                                          , W_CONNECT_PERSON_ID
                                                          , PM.SOB_ID
                                                          , PM.ORG_ID)
                         AS CAP_B
                    INTO V_CAP_C
                       , V_CAP_B
                    FROM HRD_DAY_INTERFACE DI
                       , HRM_PERSON_MASTER PM
                       ,(-- 시점 인사내역.
                         SELECT HL.PERSON_ID
                              , HL.POST_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                              , HL.OCPT_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE              S_HL
                                                          WHERE S_HL.PERSON_ID              = HL.PERSON_ID
                                                            AND S_HL.CHARGE_DATE           <= TRUNC(W_WORK_DATE)
                                                       GROUP BY S_HL.PERSON_ID
                                                         )
                        ) T1
                      , (-- 시점 인사내역.
                         SELECT PH.PERSON_ID
                              , PH.FLOOR_ID
                              , PH.DEPT_ID
                           FROM HRD_PERSON_HISTORY        PH
                          WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                            AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                        ) T2
                    WHERE DI.PERSON_ID            = PM.PERSON_ID
                      AND PM.PERSON_ID            = T1.PERSON_ID
                      AND PM.PERSON_ID            = T2.PERSON_ID
                      AND DI.SOB_ID               = W_SOB_ID
                      AND DI.ORG_ID               = W_ORG_ID
                      AND DI.WORK_CORP_ID         = W_WORK_CORP_ID
                      AND DI.WORK_DATE            = W_WORK_DATE
                      AND DI.PERSON_ID            = W_PERSON_ID
                        ;
                  EXCEPTION WHEN OTHERS THEN
                    V_CAP_B := 'N';
                    V_CAP_C := 'N';

             END;


             IF P_APPROVE_STATUS IN('A', 'B') THEN
             -- 미승인 --> 1차 승인 : 승인.
                IF V_CAP_B <> 'Y' THEN
                  RAISE ERRNUMS.Approval_Nothing;
                END IF;
             ELSIF P_APPROVE_STATUS IN('B', 'C') THEN
             -- 1차 승인  --> 인사 승인: 승인.
                IF V_CAP_C <> 'C' THEN
                  RAISE ERRNUMS.Approval_Nothing;
                END IF;
             ELSE
             -- 승인단계 선택 안함.
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10043', '&&VALUE:=승인상태&&TEXT:=승인상태를 선택후 다시 처리하세요'));
                RETURN;
             END IF;


             -- 근태 반려사항 적용.
             UPDATE HRD_DAY_INTERFACE DI
                SET DI.REJECT_REMARK     =  P_REJECT_REMARK
                  , DI.REJECT_YN         =  'Y'
                  , DI.REJECT_DATE       =  GET_LOCAL_DATE(DI.SOB_ID)
                  , DI.REJECT_PERSON_ID  =  W_CONNECT_PERSON_ID
                  , DI.APPROVE_STATUS    =  'R'
                  , DI.EMAIL_STATUS      =  'RR'
                  , DI.ATTRIBUTE3        =  W_CONNECT_PERSON_ID
              WHERE DI.SOB_ID           =  W_SOB_ID
                AND DI.ORG_ID           =  W_ORG_ID
                AND DI.WORK_CORP_ID     =  W_WORK_CORP_ID
                AND DI.WORK_DATE        =  W_WORK_DATE
                AND DI.PERSON_ID        =  W_PERSON_ID
                  ;


   EXCEPTION
        WHEN ERRNUMS.Approval_Nothing
        THEN
             RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);


   END REJECT_APPROVE_DAY;


--------------------------
-- 일일 근태집계 현황   --
--------------------------
  PROCEDURE SELECT_DAY_INTERFACE_SUMMARY
            ( P_CURSOR                OUT TYPES.TCURSOR
            , W_WORK_CORP_ID          IN  NUMBER
            , W_CORP_ID               IN  NUMBER
            , W_WORK_DATE             IN  DATE
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_PRE_WORK_DATE_YN      IN  VARCHAR2
            , W_FLOOR_ID              IN  NUMBER
            , W_SORT_FLAG             IN  VARCHAR2 DEFAULT 'WC'
            , W_CONNECT_PERSON_ID     IN  NUMBER DEFAULT NULL
            )
  AS
    V_PRE_WORK_DATE               DATE;
    V_CONNECT_PERSON_ID           NUMBER;
  BEGIN
    IF W_PRE_WORK_DATE_YN = 'Y' THEN
      V_PRE_WORK_DATE := TRUNC(W_WORK_DATE - 1);
    ELSE
      V_PRE_WORK_DATE := TRUNC(W_WORK_DATE);
    END IF;
    
    -- 근태권한 설정.
    IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                              , W_START_DATE  => W_WORK_DATE
                              , W_END_DATE    => W_WORK_DATE
                              , W_MODULE_CODE => '20'
                              , W_PERSON_ID   => W_CONNECT_PERSON_ID
                              , W_SOB_ID      => W_SOB_ID
                              , W_ORG_ID      => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
                 
    OPEN P_CURSOR FOR
      SELECT NVL(S_DI.WORK_DATE, NULL) AS WORK_DATE
           , HRM_COMMON_G.ID_NAME_F(S_DI.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
           , NVL(HF.FLOOR_CODE, NULL) AS FLOOR_CODE
           , CASE
               WHEN GROUPING(HF.FLOOR_CODE) = 1 THEN PT_TOTAL_SUM
               ELSE HF.FLOOR_NAME
             END AS FLOOR_NAME
           , HRM_COMMON_G.ID_NAME_F(S_DI.WORK_TYPE_ID) AS WORK_TYPE_DESC
           , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', S_DI.HOLY_TYPE, S_DI.SOB_ID, S_DI.ORG_ID) AS HOLY_TYPE_DESC
           , NVL(HF.TO_COUNT, NULL) AS FLOOR_TO_COUNT
           , COUNT(S_DI.FLOOR_PERSON_COUNT) AS FLOOR_PERSON_COUNT  -- 총원.
           , SUM(S_DI.WORKING_COUNT)        AS WORKING_COUNT       -- 출근.
           , TRUNC((SUM(S_DI.WORKING_COUNT) / COUNT(S_DI.FLOOR_PERSON_COUNT)) * 100, 2) AS WORKING_RATE
           , SUM(S_DI.LATE_COUNT)           AS LATE_COUNT          -- 지각/조퇴.
           , SUM(S_DI.OVERTIME_COUNT)       AS OVERTIME_COUNT      -- 잔업수.
           , SUM(S_DI.ABSENT_COUNT)         AS ABSENT_COUNT        -- 미출근.
           , SUM(S_DI.DUTY_19)              AS DUTY_19             -- 경조휴가.
           , SUM(S_DI.DUTY_20)              AS DUTY_20             -- 연차.
           , SUM(S_DI.DUTY_52)              AS DUTY_52             -- 무급휴일.
           , SUM(S_DI.DUTY_22)              AS DUTY_22             -- 보건.
           , SUM(S_DI.DUTY_30)              AS DUTY_30             -- 공상, 병가.
           , SUM(S_DI.DUTY_18)              AS DUTY_18             -- 출장.
           , SUM(S_DI.DUTY_13)              AS DUTY_13             -- 훈련.
           , SUM(S_DI.DUTY_95)              AS DUTY_95             -- 휴직.
           , SUM(S_DI.DUTY_77)              AS DUTY_77             -- 산휴 - X.
           , SUM(S_DI.DUTY_12)              AS DUTY_12             -- 교육.
           , SUM(S_DI.DUTY_104)             AS DUTY_104            -- 직출퇴.
           , SUM(S_DI.DUTY_11)              AS DUTY_11             -- 결근.
           , SUM(S_DI.DUTY_54)              AS DUTY_54             -- 무급휴가.
           , SUM(S_DI.RETIRE_COUNT)         AS RETIRE_COUNT        -- 퇴사자수.
        FROM HRM_FLOOR_V        HF
           , (-- 주간자 처리.
               SELECT DI.WORK_DATE
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.WORK_CORP_ID
                     , T2.FLOOR_ID
                     , T1.JOB_CATEGORY_ID
                     , NVL(T2.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
                     , DI.WORK_TYPE_GROUP
                     , '2' AS HOLY_TYPE
                     , DI.PERSON_ID AS FLOOR_PERSON_COUNT  -- 총원.
                     , CASE
                         WHEN DC.DUTY_CODE = '00' THEN 1
                         WHEN DC.DUTY_CODE = '53' AND DI.ALL_NIGHT_YN != 'Y' THEN 1
                         ELSE 0
                       END AS WORKING_COUNT  -- 출근.
                     , ( CASE 
                           WHEN TRUNC(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'MI') IS NULL THEN 0
                           WHEN TRUNC(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'MI') > DI.PLAN_OPEN_TIME THEN 1
                           ELSE 0
                         END +
                         CASE 
                           WHEN DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y'
                             THEN CASE
                                    WHEN N_DI.CLOSE_TIME IS NULL THEN 0
                                    WHEN TRUNC(N_DI.CLOSE_TIME, 'MI') < DI.PLAN_CLOSE_TIME THEN 1
                                    ELSE 0
                                  END
                           ELSE   CASE
                                    WHEN TRUNC(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME), 'MI') IS NULL THEN 0
                                    WHEN TRUNC(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME), 'MI') < DI.PLAN_CLOSE_TIME THEN 1
                                    ELSE 0
                                  END
                         END) AS LATE_COUNT  -- 지각/조퇴.
                     , NVL(( SELECT CASE
                                      WHEN DC.DUTY_CODE NOT IN('00', '53') THEN 0  -- 출근/특근 안함.
                                      WHEN DI.HOLY_TYPE = '2' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 0.75) <= OL.AFTER_OT_END THEN 1
                                      WHEN DI.HOLY_TYPE = '3' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 1.270833333333333) <= OL.AFTER_OT_END THEN 1
                                      WHEN DI.HOLY_TYPE IN('0', '1') AND DI.ALL_NIGHT_YN = 'Y' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 1.270833333333333) <= OL.AFTER_OT_END THEN 1
                                      WHEN DI.HOLY_TYPE IN('0', '1') AND DI.ALL_NIGHT_YN != 'Y' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 0.75) <= OL.AFTER_OT_END  THEN 1
                                      ELSE 0
                                    END AS OVERTIME_COUNT
                               FROM HRD_OT_LINE   OL
                                 , HRD_OT_HEADER  OH
                             WHERE OL.OT_HEADER_ID  = OH.OT_HEADER_ID
                               AND OL.WORK_DATE     = DI.WORK_DATE
                               AND OL.PERSON_ID     = DI.PERSON_ID
                               AND OL.REJECT_YN     != 'Y'
                               AND ROWNUM           <= 1
                           ), 0) AS OVERTIME_COUNT  -- 연장근무 신청내역.
                     , CASE
                         WHEN DC.DUTY_CODE = '19'           THEN 1  -- 경조휴가.
                         WHEN DC.DUTY_CODE IN('20', '21')   THEN 1  -- 연차.
                         WHEN DC.DUTY_CODE IN('52')         THEN 1  -- 무급휴일.
                         WHEN DC.DUTY_CODE IN('22')         THEN 1  -- 보건.
                         WHEN DC.DUTY_CODE IN ('30', '31')  THEN 1  -- 공상, 병가.
                         WHEN DC.DUTY_CODE IN('18')         THEN 1  -- 출장.
                         WHEN DC.DUTY_CODE IN('13')         THEN 1  -- 훈련.
                         WHEN DC.DUTY_CODE IN('95', '96', '97')   THEN 1  -- 휴직.
                         WHEN DC.DUTY_CODE IN('12')         THEN 1  -- 교육.
                         WHEN DC.DUTY_CODE IN('104')        THEN 1  -- 직출퇴
                         WHEN DC.DUTY_CODE IN('11')         THEN 1  -- 결근.
                         ELSE 0
                       END AS ABSENT_COUNT  -- 미출근.
                     , (CASE WHEN DC.DUTY_CODE = '19'         THEN 1 ELSE 0 END) AS DUTY_19    -- 경조휴가.
                     , (CASE WHEN DC.DUTY_CODE IN('20', '21') THEN 1 ELSE 0 END) AS DUTY_20    -- 연차.
                     , (CASE WHEN DC.DUTY_CODE IN('52')       THEN 1 ELSE 0 END) AS DUTY_52    -- 무급휴일.
                     , (CASE WHEN DC.DUTY_CODE IN('22')       THEN 1 ELSE 0 END) AS DUTY_22    -- 보건.
                     , (CASE WHEN DC.DUTY_CODE IN('30', '31') THEN 1 ELSE 0 END) AS DUTY_30    -- 공상, 병가.
                     , (CASE WHEN DC.DUTY_CODE IN('18')       THEN 1 ELSE 0 END) AS DUTY_18    -- 출장.
                     , (CASE WHEN DC.DUTY_CODE IN('13')       THEN 1 ELSE 0 END) AS DUTY_13    -- 훈련.
                     , (CASE WHEN DC.DUTY_CODE IN('95', '96', '97') THEN 1 ELSE 0 END) AS DUTY_95    -- 휴직.
                     , (CASE WHEN DC.DUTY_CODE IN('77', '78') THEN 1 ELSE 0 END) AS DUTY_77    -- 산휴 - X.
                     , (CASE WHEN DC.DUTY_CODE IN('12')       THEN 1 ELSE 0 END) AS DUTY_12    -- 교육.
                     , (CASE WHEN DC.DUTY_CODE IN('104')      THEN 1 ELSE 0 END) AS DUTY_104   -- 직출퇴.
                     , (CASE WHEN DC.DUTY_CODE IN('11')       THEN 1 ELSE 0 END) AS DUTY_11    -- 결근.
                     , (CASE WHEN DC.DUTY_CODE IN('54')       THEN 1 ELSE 0 END) AS DUTY_54    -- 무급휴가.
                     , (DECODE(PM.RETIRE_DATE, DI.WORK_DATE, 1, 0)) AS RETIRE_COUNT            -- 퇴사자수.
                  FROM HRD_DAY_INTERFACE_V       DI
                     , HRM_DUTY_CODE_V           DC
                     , HRM_PERSON_MASTER         PM
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                       GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.DEPT_ID
                             , PH.WORK_TYPE_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                          AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                        ) T2
                     , (-- 후일 근무 정보 조회.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DECODE(DIT.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DIT.CLOSE_TIME) AS CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DECODE(DIT.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME1, DIT.CLOSE_TIME1) AS CLOSE_TIME1
                        FROM HRD_DAY_INTERFACE DIT
                           , HRD_DAY_MODIFY    O_DM
                        WHERE DIT.PERSON_ID     = O_DM.PERSON_ID(+)
                          AND DIT.WORK_DATE     = O_DM.WORK_DATE(+)
                          AND '2'               = O_DM.IO_FLAG(+)
                          AND DIT.WORK_DATE     = W_WORK_DATE + 1
                          AND DIT.WORK_CORP_ID  = W_WORK_CORP_ID
                          AND DIT.CORP_ID       = NVL(W_CORP_ID, DIT.CORP_ID)
                          AND DIT.SOB_ID        = W_SOB_ID
                          AND DIT.ORG_ID        = W_ORG_ID
                       ) N_DI
                     , HRM_POST_CODE_V           PC
                     , HRD_DAY_MODIFY            I_DM
                     , HRD_DAY_MODIFY            O_DM
                WHERE DI.DUTY_ID                = DC.DUTY_ID
                  AND DI.PERSON_ID              = PM.PERSON_ID
                  AND DI.PERSON_ID              = T1.PERSON_ID
                  AND DI.PERSON_ID              = T2.PERSON_ID
                  AND T1.POST_ID                = PC.POST_ID
                  AND DI.WORK_DATE              = N_DI.WORK_DATE(+)
                  AND DI.PERSON_ID              = N_DI.PERSON_ID(+)
                  AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                  AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                  AND '1'                       = I_DM.IO_FLAG(+)
                  AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                  AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                  AND '2'                       = O_DM.IO_FLAG(+)
                  AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND DI.WORK_DATE              = W_WORK_DATE
                  AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND DI.SOB_ID                 = W_SOB_ID
                  AND DI.ORG_ID                 = W_ORG_ID
                  AND PM.JOIN_DATE              <= W_WORK_DATE
                  AND (PM.RETIRE_DATE           >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
                  AND DI.WORK_HOLY_TYPE         = '2'  -- 주간 --
                  /*-- 전호수 수정(2013-01-24) : 실제 근무유형으로 변경 --
                  AND (DI.HOLY_TYPE             = '2'
                  OR   (DI.HOLY_TYPE            IN('0', '1') 
                  AND   DI.ALL_NIGHT_YN         != 'Y'))*/
                UNION ALL
            /* ) DI_1
           , ( -- 야간자 처리. */
                SELECT W_WORK_DATE AS WORK_DATE
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.WORK_CORP_ID
                     , T2.FLOOR_ID
                     , T1.JOB_CATEGORY_ID
                     , NVL(T2.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
                     , DI.WORK_TYPE_GROUP
                     , '3' AS HOLY_TYPE
                     , (DI.PERSON_ID) AS FLOOR_PERSON_COUNT  -- 총원.
                     , (CASE
                           WHEN DC.DUTY_CODE = '00' THEN 1
                           WHEN DC.DUTY_CODE = '53' AND DI.ALL_NIGHT_YN = 'Y' THEN 1
                           ELSE 0
                         END) AS WORKING_COUNT  -- 출근.
                     --, TRUNC((SUM(DECODE(DC.DUTY_CODE, '00', 1, 0)) / COUNT(DI.PERSON_ID)) * 100, 2) AS WORKING_RATE
                     , ( CASE 
                           WHEN TRUNC(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'MI') IS NULL THEN 0
                           WHEN TRUNC(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME), 'MI') > DI.PLAN_OPEN_TIME THEN 1
                           ELSE 0
                         END +
                         CASE 
                           WHEN DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y'
                             THEN CASE
                                    WHEN N_DI.CLOSE_TIME IS NULL THEN 0
                                    WHEN TRUNC(N_DI.CLOSE_TIME, 'MI') < DI.PLAN_CLOSE_TIME THEN 1
                                    ELSE 0
                                  END
                           ELSE   CASE
                                    WHEN TRUNC(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME), 'MI') IS NULL THEN 0
                                    WHEN TRUNC(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME), 'MI') < DI.PLAN_CLOSE_TIME THEN 1
                                    ELSE 0
                                  END
                         END) AS LATE_COUNT  -- 지각/조퇴.
                     , NVL(( SELECT DISTINCT
                                    CASE
                                      WHEN DC.DUTY_CODE NOT IN('00', '53') THEN 0  -- 출근/특근 안함.
                                      WHEN DI.HOLY_TYPE = '2' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 0.75) <= OL.AFTER_OT_END THEN 1
                                      WHEN DI.HOLY_TYPE = '3' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 1.270833333333333) <= OL.AFTER_OT_END THEN 1
                                      WHEN DI.HOLY_TYPE IN('0', '1') AND DI.ALL_NIGHT_YN = 'Y' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 1.270833333333333) <= OL.AFTER_OT_END THEN 1
                                      WHEN DI.HOLY_TYPE IN('0', '1') AND DI.ALL_NIGHT_YN != 'Y' 
                                        AND OL.AFTER_OT_START != OL.AFTER_OT_END AND (DI.WORK_DATE + 0.75) <= OL.AFTER_OT_END  THEN 1
                                      ELSE 0
                                    END AS OVERTIME_COUNT
                               FROM HRD_OT_LINE   OL
                                 , HRD_OT_HEADER  OH
                             WHERE OL.OT_HEADER_ID  = OH.OT_HEADER_ID
                               AND OL.WORK_DATE     = DI.WORK_DATE
                               AND OL.PERSON_ID     = DI.PERSON_ID
                               AND OL.REJECT_YN     != 'Y'
                               AND ROWNUM           <= 1
                           ), 0) AS OVERTIME_COUNT  -- 연장근무 신청내역.
                     , (CASE
                           WHEN DC.DUTY_CODE = '19'           THEN 1  -- 경조휴가.
                           WHEN DC.DUTY_CODE IN('20', '21')   THEN 1  -- 연차.
                           WHEN DC.DUTY_CODE IN('52')         THEN 1  -- 무급휴일.
                           WHEN DC.DUTY_CODE IN('22')         THEN 1  -- 보건.
                           WHEN DC.DUTY_CODE IN ('30', '31')  THEN 1  -- 공상, 병가.
                           WHEN DC.DUTY_CODE IN('18')         THEN 1  -- 출장.
                           WHEN DC.DUTY_CODE IN('13')         THEN 1  -- 훈련.
                           WHEN DC.DUTY_CODE IN('95', '96', '97')   THEN 1  -- 휴직.
                           WHEN DC.DUTY_CODE IN('12')         THEN 1  -- 교육.
                           WHEN DC.DUTY_CODE IN('104')        THEN 1  -- 직출퇴
                           WHEN DC.DUTY_CODE IN('11')         THEN 1  -- 결근.
                           ELSE 0
                         END) AS ABSENT_COUNT  -- 미출근.
                     , (CASE WHEN DC.DUTY_CODE = '19'         THEN 1 ELSE 0 END) AS DUTY_19    -- 경조휴가.
                     , (CASE WHEN DC.DUTY_CODE IN('20', '21') THEN 1 ELSE 0 END) AS DUTY_20    -- 연차.
                     , (CASE WHEN DC.DUTY_CODE IN('52')       THEN 1 ELSE 0 END) AS DUTY_52    -- 무급휴일.
                     , (CASE WHEN DC.DUTY_CODE IN('22')       THEN 1 ELSE 0 END) AS DUTY_22    -- 보건.
                     , (CASE WHEN DC.DUTY_CODE IN('30', '31') THEN 1 ELSE 0 END) AS DUTY_30    -- 공상, 병가.
                     , (CASE WHEN DC.DUTY_CODE IN('18')       THEN 1 ELSE 0 END) AS DUTY_18    -- 출장.
                     , (CASE WHEN DC.DUTY_CODE IN('13')       THEN 1 ELSE 0 END) AS DUTY_13    -- 훈련.
                     , (CASE WHEN DC.DUTY_CODE IN('95', '96', '97') THEN 1 ELSE 0 END) AS DUTY_95    -- 휴직.
                     , (CASE WHEN DC.DUTY_CODE IN('77', '78') THEN 1 ELSE 0 END) AS DUTY_77    -- 산휴 - X.
                     , (CASE WHEN DC.DUTY_CODE IN('12')       THEN 1 ELSE 0 END) AS DUTY_12    -- 교육.
                     , (CASE WHEN DC.DUTY_CODE IN('104')      THEN 1 ELSE 0 END) AS DUTY_104   -- 직출퇴.
                     , (CASE WHEN DC.DUTY_CODE IN('11')       THEN 1 ELSE 0 END) AS DUTY_11    -- 결근.
                     , (CASE WHEN DC.DUTY_CODE IN('54')       THEN 1 ELSE 0 END) AS DUTY_54    -- 무급휴가.
                     , (DECODE(PM.RETIRE_DATE, V_PRE_WORK_DATE, 1, 0)) AS RETIRE_COUNT         -- 퇴사자수.
                  FROM HRD_DAY_INTERFACE_V       DI
                     , HRM_DUTY_CODE_V           DC
                     , HRM_PERSON_MASTER         PM
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= V_PRE_WORK_DATE
                                                       GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.DEPT_ID
                             , PH.WORK_TYPE_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                          AND PH.EFFECTIVE_DATE_FR  <=  V_PRE_WORK_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  V_PRE_WORK_DATE
                        ) T2
                     , (-- 후일 근무 정보 조회.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DECODE(DIT.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DIT.CLOSE_TIME) AS CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DECODE(DIT.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME1, DIT.CLOSE_TIME1) AS CLOSE_TIME1
                        FROM HRD_DAY_INTERFACE DIT
                           , HRD_DAY_MODIFY    O_DM
                        WHERE DIT.PERSON_ID     = O_DM.PERSON_ID(+)
                          AND DIT.WORK_DATE     = O_DM.WORK_DATE(+)
                          AND '2'               = O_DM.IO_FLAG(+)
                          AND DIT.WORK_DATE     = W_WORK_DATE + 1
                          AND DIT.WORK_CORP_ID  = W_WORK_CORP_ID
                          AND DIT.CORP_ID       = NVL(W_CORP_ID, DIT.CORP_ID)
                          AND DIT.SOB_ID        = W_SOB_ID
                          AND DIT.ORG_ID        = W_ORG_ID
                       ) N_DI
                     , HRM_POST_CODE_V           PC
                     , HRD_DAY_MODIFY            I_DM
                     , HRD_DAY_MODIFY            O_DM
                WHERE DI.DUTY_ID                = DC.DUTY_ID
                  AND DI.PERSON_ID              = PM.PERSON_ID
                  AND DI.PERSON_ID              = T1.PERSON_ID
                  AND DI.PERSON_ID              = T2.PERSON_ID
                  AND T1.POST_ID                = PC.POST_ID
                  AND DI.WORK_DATE              = N_DI.WORK_DATE(+)
                  AND DI.PERSON_ID              = N_DI.PERSON_ID(+)
                  AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                  AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                  AND '1'                       = I_DM.IO_FLAG(+)
                  AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                  AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                  AND '2'                       = O_DM.IO_FLAG(+)
                  AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND DI.WORK_DATE              = V_PRE_WORK_DATE
                  AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND DI.SOB_ID                 = W_SOB_ID
                  AND DI.ORG_ID                 = W_ORG_ID
                  AND PM.JOIN_DATE              <= V_PRE_WORK_DATE
                  AND (PM.RETIRE_DATE           >= V_PRE_WORK_DATE OR PM.RETIRE_DATE IS NULL)
                  AND DI.WORK_HOLY_TYPE         = '3'  -- 야간 --
                  /*-- 전호수 수정(2013-01-24) : 실제 근무유형으로 변경 --
                  AND (DI.HOLY_TYPE             = '3'
                  OR   (DI.HOLY_TYPE            IN('0', '1') 
                  AND   DI.ALL_NIGHT_YN         = 'Y'))*/
             ) S_DI
      WHERE HF.FLOOR_ID                 = S_DI.FLOOR_ID
        AND S_DI.WORK_TYPE_ID           IS NOT NULL
        AND EXISTS 
              (SELECT 'X'
                 FROM HRD_DUTY_MANAGER DM
               WHERE DM.CORP_ID                                  = S_DI.WORK_CORP_ID
                 AND DM.DUTY_CONTROL_ID                          = NVL(S_DI.FLOOR_ID, DM.DUTY_CONTROL_ID)
                 AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, S_DI.WORK_TYPE_ID)
                 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                 AND DM.START_DATE                              <= S_DI.WORK_DATE
                 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= S_DI.WORK_DATE)
                 AND DM.SOB_ID                                   = S_DI.SOB_ID
                 AND DM.ORG_ID                                   = S_DI.ORG_ID
             )
      GROUP BY ROLLUP((
               S_DI.WORK_DATE
             , HF.FLOOR_CODE
             , HF.FLOOR_NAME
             , HF.SORT_NUM
             , HF.TO_COUNT
             , S_DI.JOB_CATEGORY_ID
             , S_DI.WORK_TYPE_ID
             , S_DI.WORK_TYPE_GROUP
             , S_DI.HOLY_TYPE
             , S_DI.SOB_ID
             , S_DI.ORG_ID))
      ORDER BY CASE
                 WHEN W_SORT_FLAG = 'WC' THEN HF.SORT_NUM
                 ELSE 1
               END 
             , CASE
                 WHEN W_SORT_FLAG = 'WC' THEN HF.FLOOR_CODE
                 ELSE '1'
               END
             , CASE
                 WHEN W_SORT_FLAG = 'WT' THEN S_DI.WORK_TYPE_GROUP
                 ELSE '1'
               END
             , CASE
                 WHEN W_SORT_FLAG = 'HT' THEN S_DI.HOLY_TYPE
                 ELSE '1'
               END
             , HF.FLOOR_CODE
             , HF.FLOOR_CODE
             , S_DI.WORK_TYPE_GROUP
             , S_DI.HOLY_TYPE
             , HRM_COMMON_G.GET_CODE_F(S_DI.JOB_CATEGORY_ID, S_DI.SOB_ID, S_DI.ORG_ID)
      ;
  END SELECT_DAY_INTERFACE_SUMMARY;

-----------------------------------------
-- 일일 근태집계 현황 : 퇴직자 리스트  --
-----------------------------------------
  PROCEDURE SELECT_DAY_RETIRE_PERSON
            ( P_CURSOR1               OUT TYPES.TCURSOR1
            , W_WORK_CORP_ID          IN  NUMBER
            , W_CORP_ID               IN  NUMBER
            , W_WORK_DATE             IN  DATE
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_PRE_WORK_DATE_YN      IN  VARCHAR2
            , W_FLOOR_ID              IN  NUMBER
            , W_SORT_FLAG             IN  VARCHAR2 DEFAULT 'WC'
            , W_CONNECT_PERSON_ID     IN  NUMBER DEFAULT NULL
            )
  AS
    V_PRE_WORK_DATE               DATE;
    V_CONNECT_PERSON_ID           NUMBER;
  BEGIN
    IF W_PRE_WORK_DATE_YN = 'Y' THEN
      V_PRE_WORK_DATE := TRUNC(W_WORK_DATE - 1);
    ELSE
      V_PRE_WORK_DATE := TRUNC(W_WORK_DATE);
    END IF;
    
    -- 근태권한 설정.
    IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                              , W_START_DATE  => W_WORK_DATE
                              , W_END_DATE    => W_WORK_DATE
                              , W_MODULE_CODE => '20'
                              , W_PERSON_ID   => W_CONNECT_PERSON_ID
                              , W_SOB_ID      => W_SOB_ID
                              , W_ORG_ID      => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    
    OPEN P_CURSOR1 FOR
      SELECT NVL(S_DI.WORK_DATE, NULL) AS WORK_DATE
           , HRM_COMMON_G.ID_NAME_F(S_DI.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
           , NVL(HF.FLOOR_CODE, NULL) AS FLOOR_CODE
           , NVL(HF.FLOOR_NAME, NULL) AS FLOOR_NAME
           , HRM_COMMON_G.ID_NAME_F(S_DI.WORK_TYPE_ID) AS WORK_TYPE_DESC
           , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', S_DI.HOLY_TYPE, S_DI.SOB_ID, S_DI.ORG_ID) AS HOLY_TYPE_DESC
           , NVL(HF.TO_COUNT, NULL) AS FLOOR_TO_COUNT
           , NVL(S_PM.FLOOR_PERSON_COUNT, NULL) AS FLOOR_PERSON_COUNT
           , NVL(S_DI.PERSON_NUM, NULL) AS PERSON_NUM
           , NVL(S_DI.NAME, NULL) AS NAME
        FROM HRM_FLOOR_V        HF
           , (-- 주간자 처리.
               SELECT SX1.FLOOR_ID
                    , COUNT(SX1.FLOOR_PERSON_COUNT) AS FLOOR_PERSON_COUNT
                 FROM (SELECT  T2.FLOOR_ID
                             , (DI.PERSON_ID) AS FLOOR_PERSON_COUNT  -- 총원.
                          FROM HRD_DAY_INTERFACE_V       DI
                             , HRM_PERSON_MASTER         PM
                             , (-- 시점 인사내역.
                                SELECT HL.PERSON_ID
                                     , HL.POST_ID
                                     , HL.JOB_CATEGORY_ID
                                  FROM HRM_HISTORY_LINE HL
                                WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                                 FROM HRM_HISTORY_LINE             S_HL
                                                               WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                                 AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                               GROUP BY S_HL.PERSON_ID
                                                              )
                               ) T1
                             , (-- 시점 인사내역.
                                SELECT PH.PERSON_ID
                                     , PH.FLOOR_ID
                                     , PH.DEPT_ID
                                     , PH.WORK_TYPE_ID
                                  FROM HRD_PERSON_HISTORY        PH
                                WHERE PH.SOB_ID             = W_SOB_ID
                                  AND PH.ORG_ID             = W_ORG_ID
                                  AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                                  AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                                  AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                                ) T2
                        WHERE DI.PERSON_ID              = PM.PERSON_ID
                          AND DI.PERSON_ID              = T1.PERSON_ID
                          AND DI.PERSON_ID              = T2.PERSON_ID
                          AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                          AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                          AND PM.SOB_ID                 = W_SOB_ID
                          AND PM.ORG_ID                 = W_ORG_ID
                          AND DI.WORK_DATE              = W_WORK_DATE
                          AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                          AND DI.SOB_ID                 = W_SOB_ID
                          AND DI.ORG_ID                 = W_ORG_ID
                          AND PM.JOIN_DATE              <= W_WORK_DATE
                          AND (PM.RETIRE_DATE           >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND DI.WORK_HOLY_TYPE         = '2'
                          /*-- 전호수 수정(2013-01-24) : 실제 근무유형으로 변경 --
                          AND (DI.HOLY_TYPE             = '2'
                          OR   (DI.HOLY_TYPE            IN('0', '1') 
                          AND   DI.ALL_NIGHT_YN         != 'Y'))*/
                        UNION ALL
                        SELECT T2.FLOOR_ID
                             , (DI.PERSON_ID) AS FLOOR_PERSON_COUNT  -- 총원.
                          FROM HRD_DAY_INTERFACE_V       DI
                             , HRM_PERSON_MASTER         PM
                             , (-- 시점 인사내역.
                                SELECT HL.PERSON_ID
                                     , HL.POST_ID
                                     , HL.JOB_CATEGORY_ID
                                  FROM HRM_HISTORY_LINE HL
                                WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                                 FROM HRM_HISTORY_LINE             S_HL
                                                               WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                                 AND S_HL.CHARGE_DATE          <= V_PRE_WORK_DATE
                                                               GROUP BY S_HL.PERSON_ID
                                                              )
                               ) T1
                             , (-- 시점 인사내역.
                                SELECT PH.PERSON_ID
                                     , PH.FLOOR_ID
                                     , PH.DEPT_ID
                                     , PH.WORK_TYPE_ID
                                  FROM HRD_PERSON_HISTORY        PH
                                WHERE PH.SOB_ID             = W_SOB_ID
                                  AND PH.ORG_ID             = W_ORG_ID
                                  AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                                  AND PH.EFFECTIVE_DATE_FR  <=  V_PRE_WORK_DATE
                                  AND PH.EFFECTIVE_DATE_TO  >=  V_PRE_WORK_DATE
                                ) T2
                        WHERE DI.PERSON_ID              = PM.PERSON_ID
                          AND DI.PERSON_ID              = T1.PERSON_ID
                          AND DI.PERSON_ID              = T2.PERSON_ID
                          AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                          AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                          AND PM.SOB_ID                 = W_SOB_ID
                          AND PM.ORG_ID                 = W_ORG_ID
                          AND DI.WORK_DATE              = V_PRE_WORK_DATE
                          AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                          AND DI.SOB_ID                 = W_SOB_ID
                          AND DI.ORG_ID                 = W_ORG_ID
                          AND PM.JOIN_DATE              <= V_PRE_WORK_DATE
                          AND (PM.RETIRE_DATE           >= V_PRE_WORK_DATE OR PM.RETIRE_DATE IS NULL)
                          AND DI.WORK_HOLY_TYPE         = '3'
                          /*-- 전호수 수정(2013-01-24) : 실제 근무유형으로 변경 --
                          AND (DI.HOLY_TYPE             = '3'
                          OR   (DI.HOLY_TYPE            IN('0', '1') 
                          AND   DI.ALL_NIGHT_YN         = 'Y'))*/
                      ) SX1
               GROUP BY SX1.FLOOR_ID
             ) S_PM
           , (-- 주간자 처리.
               SELECT  DI.WORK_DATE
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.WORK_CORP_ID
                     , T2.FLOOR_ID
                     , T1.JOB_CATEGORY_ID
                     , NVL(T2.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
                     , DI.WORK_TYPE_GROUP
                     , '2' AS HOLY_TYPE
                     , PM.NAME
                     , PM.PERSON_NUM
                  FROM HRD_DAY_INTERFACE_V       DI
                     , HRM_PERSON_MASTER         PM
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                       GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.DEPT_ID
                             , PH.WORK_TYPE_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                          AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                        ) T2
                     , HRM_POST_CODE_V           PC
                WHERE DI.PERSON_ID              = PM.PERSON_ID
                  AND DI.PERSON_ID              = T1.PERSON_ID
                  AND DI.PERSON_ID              = T2.PERSON_ID
                  AND T1.POST_ID                = PC.POST_ID
                  AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND DI.WORK_DATE              = W_WORK_DATE
                  AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND DI.SOB_ID                 = W_SOB_ID
                  AND DI.ORG_ID                 = W_ORG_ID
                  AND PM.RETIRE_DATE            = W_WORK_DATE
                  AND (DI.HOLY_TYPE             = '2'
                  OR   (DI.HOLY_TYPE            IN('0', '1') 
                  AND   DI.ALL_NIGHT_YN         != 'Y'))
                UNION ALL
            /* ) DI_1
           , ( -- 야간자 처리. */
                SELECT W_WORK_DATE AS WORK_DATE
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.WORK_CORP_ID
                     , T2.FLOOR_ID
                     , T1.JOB_CATEGORY_ID
                     , NVL(T2.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
                     , DI.WORK_TYPE_GROUP
                     , '3' AS HOLY_TYPE
                     , PM.NAME
                     , PM.PERSON_NUM
                  FROM HRD_DAY_INTERFACE_V       DI
                     , HRM_PERSON_MASTER         PM
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= V_PRE_WORK_DATE
                                                       GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.DEPT_ID
                             , PH.WORK_TYPE_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                          AND PH.EFFECTIVE_DATE_FR  <= V_PRE_WORK_DATE
                          AND PH.EFFECTIVE_DATE_TO  >= V_PRE_WORK_DATE
                        ) T2
                     , HRM_POST_CODE_V           PC
                WHERE DI.PERSON_ID              = PM.PERSON_ID
                  AND DI.PERSON_ID              = T1.PERSON_ID
                  AND DI.PERSON_ID              = T2.PERSON_ID
                  AND T1.POST_ID                = PC.POST_ID
                  AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND DI.WORK_DATE              = V_PRE_WORK_DATE
                  AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND DI.SOB_ID                 = W_SOB_ID
                  AND DI.ORG_ID                 = W_ORG_ID
                  AND PM.RETIRE_DATE            = V_PRE_WORK_DATE
                  AND (DI.HOLY_TYPE             = '3'
                  OR   (DI.HOLY_TYPE            IN('0', '1') 
                  AND   DI.ALL_NIGHT_YN         = 'Y'))
             ) S_DI
      WHERE HF.FLOOR_ID                 = S_PM.FLOOR_ID(+)
        AND HF.FLOOR_ID                 = S_DI.FLOOR_ID
        AND S_DI.WORK_TYPE_ID           IS NOT NULL
        AND EXISTS 
              (SELECT 'X'
                 FROM HRD_DUTY_MANAGER DM
               WHERE DM.CORP_ID                                  = S_DI.WORK_CORP_ID
                 AND DM.DUTY_CONTROL_ID                          = NVL(S_DI.FLOOR_ID, DM.DUTY_CONTROL_ID)
                 AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, S_DI.WORK_TYPE_ID)
                 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                 AND DM.START_DATE                              <= S_DI.WORK_DATE
                 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= S_DI.WORK_DATE)
                 AND DM.SOB_ID                                   = S_DI.SOB_ID
                 AND DM.ORG_ID                                   = S_DI.ORG_ID
             )
      ORDER BY CASE
                 WHEN W_SORT_FLAG = 'WC' THEN HF.SORT_NUM
                 ELSE 1
               END 
             , CASE
                 WHEN W_SORT_FLAG = 'WC' THEN HF.FLOOR_CODE
                 ELSE '1'
               END
             , CASE
                 WHEN W_SORT_FLAG = 'WT' THEN S_DI.WORK_TYPE_GROUP
                 ELSE '1'
               END
             , CASE
                 WHEN W_SORT_FLAG = 'HT' THEN S_DI.HOLY_TYPE
                 ELSE '1'
               END
             , HF.FLOOR_CODE
             , HF.FLOOR_CODE
             , S_DI.WORK_TYPE_GROUP
             , S_DI.HOLY_TYPE
             , HRM_COMMON_G.GET_CODE_F(S_DI.JOB_CATEGORY_ID, S_DI.SOB_ID, S_DI.ORG_ID)
      ;
  END SELECT_DAY_RETIRE_PERSON;

-----------------------------------------
-- 일일 근태집계 현황 : 미출근자 리스트  --
-----------------------------------------
  PROCEDURE SELECT_DAY_NO_WORK_PERSON
            ( P_CURSOR2               OUT TYPES.TCURSOR2
            , W_WORK_CORP_ID          IN  NUMBER
            , W_CORP_ID               IN  NUMBER
            , W_WORK_DATE             IN  DATE
            , W_SOB_ID                IN  NUMBER
            , W_ORG_ID                IN  NUMBER
            , W_PRE_WORK_DATE_YN      IN  VARCHAR2
            , W_FLOOR_ID              IN  NUMBER
            , W_SORT_FLAG             IN  VARCHAR2 DEFAULT 'WC'
            , W_CONNECT_PERSON_ID     IN  NUMBER DEFAULT NULL
            )
  AS
    V_PRE_WORK_DATE               DATE;
    V_CONNECT_PERSON_ID           NUMBER;
  BEGIN
    IF W_PRE_WORK_DATE_YN = 'Y' THEN
      V_PRE_WORK_DATE := TRUNC(W_WORK_DATE - 1);
    ELSE
      V_PRE_WORK_DATE := TRUNC(W_WORK_DATE);
    END IF;
    
    -- 근태권한 설정.
    IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                              , W_START_DATE  => W_WORK_DATE
                              , W_END_DATE    => W_WORK_DATE
                              , W_MODULE_CODE => '20'
                              , W_PERSON_ID   => W_CONNECT_PERSON_ID
                              , W_SOB_ID      => W_SOB_ID
                              , W_ORG_ID      => W_ORG_ID) = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;
    
    OPEN P_CURSOR2 FOR
      SELECT NVL(S_DI.WORK_DATE, NULL) AS WORK_DATE
           , HRM_COMMON_G.ID_NAME_F(S_DI.JOB_CATEGORY_ID) AS JOB_CATEGORY_DESC
           , NVL(HF.FLOOR_CODE, NULL) AS FLOOR_CODE
           , NVL(HF.FLOOR_NAME, NULL) AS FLOOR_NAME
           , HRM_COMMON_G.ID_NAME_F(S_DI.WORK_TYPE_ID) AS WORK_TYPE_DESC
           , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', S_DI.HOLY_TYPE, S_DI.SOB_ID, S_DI.ORG_ID) AS HOLY_TYPE_DESC
           , S_DI.PERSON_NUM
           , S_DI.NAME
           , S_DI.POST_NAME
           , S_DI.DUTY_NAME
        FROM HRM_FLOOR_V        HF
           , (-- 주간자 처리.
               SELECT DI.WORK_DATE
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.WORK_CORP_ID
                     , T2.FLOOR_ID
                     , T1.JOB_CATEGORY_ID
                     , NVL(T2.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
                     , DI.WORK_TYPE_GROUP
                     , '2' AS HOLY_TYPE
                     , PM.NAME
                     , PM.PERSON_NUM
                     , PC.POST_NAME
                     , DC.DUTY_NAME
                     , PC.SORT_NUM AS POST_SORT_NUM
                     , PC.POST_CODE
                  FROM HRD_DAY_INTERFACE_V       DI
                     , HRM_DUTY_CODE_V           DC
                     , HRM_PERSON_MASTER         PM
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                       GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.DEPT_ID
                             , PH.WORK_TYPE_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                          AND PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                        ) T2
                     , HRM_POST_CODE_V           PC
                WHERE DI.DUTY_ID                = DC.DUTY_ID
                  AND DI.PERSON_ID              = PM.PERSON_ID
                  AND DI.PERSON_ID              = T1.PERSON_ID
                  AND DI.PERSON_ID              = T2.PERSON_ID
                  AND T1.POST_ID                = PC.POST_ID
                  AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND DI.WORK_DATE              = W_WORK_DATE
                  AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND DI.SOB_ID                 = W_SOB_ID
                  AND DI.ORG_ID                 = W_ORG_ID
                  AND PM.JOIN_DATE              <= W_WORK_DATE
                  AND (PM.RETIRE_DATE           >= W_WORK_DATE OR PM.RETIRE_DATE IS NULL)
                  AND DI.WORK_HOLY_TYPE         = '2'
                  /*-- 전호수 수정(2013-01-24) : 실제 근무유형으로 변경 --
                  AND (DI.HOLY_TYPE             = '2'
                  OR   (DI.HOLY_TYPE            IN('0', '1') 
                  AND   DI.ALL_NIGHT_YN         != 'Y'))*/
                  AND DC.DUTY_CODE              IN ('19', '20', '21', '52', '22', '30', '31', '18', '13', '95', '96', '97', '12', '104', '11')
                UNION ALL
            /* ) DI_1
           , ( -- 야간자 처리. */
                SELECT W_WORK_DATE AS WORK_DATE
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.WORK_CORP_ID
                     , T2.FLOOR_ID
                     , T1.JOB_CATEGORY_ID
                     , NVL(T2.WORK_TYPE_ID, PM.WORK_TYPE_ID) AS WORK_TYPE_ID
                     , DI.WORK_TYPE_GROUP
                     , '3' AS HOLY_TYPE
                     , PM.NAME
                     , PM.PERSON_NUM
                     , PC.POST_NAME
                     , DC.DUTY_NAME
                     , PC.SORT_NUM AS POST_SORT_NUM
                     , PC.POST_CODE
                  FROM HRD_DAY_INTERFACE_V       DI
                     , HRM_DUTY_CODE_V           DC
                     , HRM_PERSON_MASTER         PM
                     , (-- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                          FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= V_PRE_WORK_DATE
                                                       GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- 시점 인사내역.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                             , PH.DEPT_ID
                             , PH.WORK_TYPE_ID
                          FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.SOB_ID             = W_SOB_ID
                          AND PH.ORG_ID             = W_ORG_ID
                          AND PH.FLOOR_ID           = NVL(W_FLOOR_ID, PH.FLOOR_ID)
                          AND PH.EFFECTIVE_DATE_FR  <=  V_PRE_WORK_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  V_PRE_WORK_DATE
                        ) T2
                     , HRM_POST_CODE_V           PC
                     , HRD_DAY_MODIFY            I_DM
                     , HRD_DAY_MODIFY            O_DM
                WHERE DI.DUTY_ID                = DC.DUTY_ID
                  AND DI.PERSON_ID              = PM.PERSON_ID
                  AND DI.PERSON_ID              = T1.PERSON_ID
                  AND DI.PERSON_ID              = T2.PERSON_ID
                  AND T1.POST_ID                = PC.POST_ID
                  AND DI.PERSON_ID              = I_DM.PERSON_ID(+)
                  AND DI.WORK_DATE              = I_DM.WORK_DATE(+)
                  AND '1'                       = I_DM.IO_FLAG(+)
                  AND DI.PERSON_ID              = O_DM.PERSON_ID(+)
                  AND DI.WORK_DATE              = O_DM.WORK_DATE(+)
                  AND '2'                       = O_DM.IO_FLAG(+)
                  AND PM.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND PM.CORP_ID                = NVL(W_CORP_ID, PM.CORP_ID)
                  AND PM.SOB_ID                 = W_SOB_ID
                  AND PM.ORG_ID                 = W_ORG_ID
                  AND DI.WORK_DATE              = V_PRE_WORK_DATE
                  AND DI.WORK_CORP_ID           = W_WORK_CORP_ID
                  AND DI.SOB_ID                 = W_SOB_ID
                  AND DI.ORG_ID                 = W_ORG_ID
                  AND PM.JOIN_DATE              <= V_PRE_WORK_DATE
                  AND (PM.RETIRE_DATE           >= V_PRE_WORK_DATE OR PM.RETIRE_DATE IS NULL)
                  AND DI.WORK_HOLY_TYPE         = '3'
                  /*-- 전호수 수정(2013-01-24) : 실제 근무유형으로 변경 --
                  AND (DI.HOLY_TYPE             = '3'
                  OR   (DI.HOLY_TYPE            IN('0', '1') 
                  AND   DI.ALL_NIGHT_YN         = 'Y'))*/
                  AND DC.DUTY_CODE              IN ('19', '20', '21', '52', '22', '30', '31', '18', '13', '95', '96', '97', '12', '104', '11')
             ) S_DI
      WHERE HF.FLOOR_ID                 = S_DI.FLOOR_ID
        AND S_DI.WORK_TYPE_ID           IS NOT NULL
        AND EXISTS 
              (SELECT 'X'
                 FROM HRD_DUTY_MANAGER DM
               WHERE DM.CORP_ID                                  = S_DI.WORK_CORP_ID
                 AND DM.DUTY_CONTROL_ID                          = NVL(S_DI.FLOOR_ID, DM.DUTY_CONTROL_ID)
                 AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, S_DI.WORK_TYPE_ID)
                 AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                 AND DM.START_DATE                              <= S_DI.WORK_DATE
                 AND (DM.END_DATE IS NULL OR DM.END_DATE        >= S_DI.WORK_DATE)
                 AND DM.SOB_ID                                   = S_DI.SOB_ID
                 AND DM.ORG_ID                                   = S_DI.ORG_ID
             )
      ORDER BY CASE
                 WHEN W_SORT_FLAG = 'WC' THEN HF.SORT_NUM
                 ELSE 1
               END 
             , CASE
                 WHEN W_SORT_FLAG = 'WC' THEN HF.FLOOR_CODE
                 ELSE '1'
               END
             , CASE
                 WHEN W_SORT_FLAG = 'WT' THEN S_DI.WORK_TYPE_GROUP
                 ELSE '1'
               END
             , CASE
                 WHEN W_SORT_FLAG = 'HT' THEN S_DI.HOLY_TYPE
                 ELSE '1'
               END
             , HF.FLOOR_CODE
             , HF.FLOOR_CODE
             , S_DI.WORK_TYPE_GROUP
             , S_DI.HOLY_TYPE
             , HRM_COMMON_G.GET_CODE_F(S_DI.JOB_CATEGORY_ID, S_DI.SOB_ID, S_DI.ORG_ID)
             , S_DI.POST_SORT_NUM
             , S_DI.POST_CODE
      ;
  END SELECT_DAY_NO_WORK_PERSON;
  
END HRD_DAY_INTERFACE_G;
/
