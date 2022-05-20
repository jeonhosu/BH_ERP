CREATE OR REPLACE PACKAGE HRD_DAY_LEAVE_G
AS

-- DAY LEAVE SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_MODIFY_FLAG                       IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
            , W_CLOSE_YN                          IN HRD_DAY_LEAVE.CLOSED_YN%TYPE
            , W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_DUTY_ID                           IN HRM_COMMON.COMMON_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            );

-- 근태 오류자 조회.
  PROCEDURE SELECT_DAY_LEAVE_MISTAKE
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_MODIFY_FLAG                       IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
            , W_CLOSE_YN                          IN HRD_DAY_LEAVE.CLOSED_YN%TYPE
            , W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_DUTY_ID                           IN HRM_COMMON.COMMON_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            );
            
-- DAY LEAVE UPDATE
  PROCEDURE DATA_UPDATE
	          ( W_DAY_LEAVE_ID                      IN HRD_DAY_LEAVE.DAY_LEAVE_ID%TYPE
            , P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
						, P_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, P_DUTY_ID                           IN HRD_DAY_LEAVE.DUTY_ID%TYPE
						, P_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
						, P_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
						, P_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
						, P_OPEN_TIME1                        IN HRD_DAY_LEAVE.OPEN_TIME1%TYPE
						, P_CLOSE_TIME1                       IN HRD_DAY_LEAVE.CLOSE_TIME1%TYPE
						, P_NEXT_DAY_YN                       IN HRD_DAY_LEAVE.NEXT_DAY_YN%TYPE
            , P_DANGJIK_YN                        IN HRD_DAY_LEAVE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                      IN HRD_DAY_LEAVE.ALL_NIGHT_YN%TYPE
						, P_LEAVE_TIME                        IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						, P_LATE_TIME                         IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						, P_REST_TIME                         IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						, P_OVER_TIME                         IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						, P_HOLIDAY_TIME                      IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_HOLIDAY_OT_TIME                   IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						, P_NIGHT_TIME                        IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						, P_NIGHT_BONUS_TIME                  IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
						--, P_DESCRIPTION                       IN HRD_DAY_LEAVE.DESCRIPTION%TYPE
						, P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
						, P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
						);
            
-- DAY_LEAVE_OT SAVE(INSERT/UPDATE).
  PROCEDURE DAY_LEAVE_OT_SAVE
	          ( P_DAY_LEAVE_ID                      IN HRD_DAY_LEAVE_OT.DAY_LEAVE_ID%TYPE
            , P_OT_TYPE                           IN HRD_DAY_LEAVE_OT.OT_TYPE%TYPE
            , P_OT_TIME                           IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE            
            , P_PERSON_ID                         IN HRD_DAY_LEAVE_OT.PERSON_ID%TYPE
						, P_WORK_DATE                         IN HRD_DAY_LEAVE_OT.WORK_DATE%TYPE
						, P_CORP_ID                           IN HRD_DAY_LEAVE_OT.CORP_ID%TYPE
						, P_SOB_ID                            IN HRD_DAY_LEAVE_OT.SOB_ID%TYPE
						, P_ORG_ID                            IN HRD_DAY_LEAVE_OT.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE_OT.CREATED_BY%TYPE
						);

-- 출퇴근INTERFACE DATA UPDATE.
  PROCEDURE UPDATE_DAY_INTERFACE
            ( W_PERSON_ID                         IN HRD_DAY_MODIFY.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_MODIFY.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_IO_FLAG                           IN HRD_DAY_MODIFY.IO_FLAG%TYPE
						, P_DUTY_ID                           IN HRD_WORK_CALENDAR.DUTY_ID%TYPE
            , P_HOLY_TYPE                         IN HRD_DAY_INTERFACE.HOLY_TYPE%TYPE
						, P_MODIFY_TIME                       IN HRD_DAY_MODIFY.MODIFY_TIME%TYPE
						, P_MODIFY_TIME1                      IN HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
						, P_MODIFY_ID                         IN HRD_DAY_MODIFY.MODIFY_ID%TYPE
						, P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
            , P_DANGJIK_YN                        IN HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                      IN HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
						, P_LEAVE_ID                          IN HRD_DAY_INTERFACE.LEAVE_ID%TYPE
						, P_LEAVE_TIME_CODE                   IN HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
						, P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE						
            , P_IO_TIME                           IN HRD_DAY_INTERFACE.OPEN_TIME%TYPE
						, P_IO_TIME1                          IN HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
						, P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            );
            
-- DAY LEAVE CLOSE PROCESS GO.
  PROCEDURE DATA_CLOSE_PROC
            ( W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , O_STATUS                            OUT VARCHAR2
						, O_MESSAGE                           OUT VARCHAR2						
            );

-- DAY LEAVE CLOSE CANCEL GO.
  PROCEDURE DATA_CLOSE_CANCEL
            ( W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , O_STATUS                            OUT VARCHAR2
						, O_MESSAGE                           OUT VARCHAR2
            );
												
-- DAY LEAVE DATA STATUS --> RECORD COUNT.
  PROCEDURE DATA_CLOSE_YN_COUNT
	          ( W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
						, W_CAP_CHECK_YN                      IN VARCHAR2
						, W_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
						, W_CLOSE_YN                          IN HRD_DAY_LEAVE.CLOSED_YN%TYPE
						, O_RECORD_COUNT                      OUT NUMBER
						);

-- 일근태 마감 자료 조회.
  PROCEDURE SELECT_DAY_LEAVE_PERSON
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_DUTY_ID                           IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            );



-- [2011-11-02]
   PROCEDURE SELECT_DAY_LEAVE_USER
           ( P_CURSOR1       OUT TYPES.TCURSOR
           , W_SOB_ID        IN  HRD_DAY_LEAVE.SOB_ID%TYPE
           , W_ORG_ID        IN  HRD_DAY_LEAVE.ORG_ID%TYPE
           , W_CORP_ID       IN  HRD_DAY_LEAVE.CORP_ID%TYPE
           , W_START_DATE    IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_END_DATE      IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_HOLY_TYPE     IN  HRD_DAY_LEAVE.HOLY_TYPE%TYPE
           , W_DUTY_ID       IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID     IN  HRD_DAY_LEAVE.PERSON_ID%TYPE
           , W_SORT          IN  VARCHAR2
           );


-- DAY LEAVE SELECT[2011-11-14]
   PROCEDURE SELECT_DAY_LEAVE_DATA
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_CORP_ID            IN  HRD_DAY_LEAVE.CORP_ID%TYPE
           , W_START_DATE         IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_END_DATE           IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_MODIFY_FLAG        IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
           , W_CLOSE_YN           IN  HRD_DAY_LEAVE.CLOSED_YN%TYPE
           , W_HOLY_TYPE          IN  HRD_DAY_LEAVE.HOLY_TYPE%TYPE
           , W_DUTY_ID            IN  HRM_COMMON.COMMON_ID%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_DEPT_ID            IN  HRM_DEPT_MASTER.DEPT_ID%TYPE
           , W_JOB_CATEGORY_ID    IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_DAY_LEAVE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_DAY_LEAVE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_DAY_LEAVE.ORG_ID%TYPE
           );

-- 일근태 마감 자료 집계 조회.
  PROCEDURE SELECT_DAY_LEAVE_SUM
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            );



END HRD_DAY_LEAVE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_LEAVE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_LEAVE_G
/* DESCRIPTION  : 일근태 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- DAY LEAVE SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_MODIFY_FLAG                       IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
            , W_CLOSE_YN                          IN HRD_DAY_LEAVE.CLOSED_YN%TYPE
            , W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_DUTY_ID                           IN HRM_COMMON.COMMON_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            )
  AS
    V_CONNECT_PERSON_ID                               HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
    -- 근태권한 설정.
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

    OPEN P_CURSOR FOR
      SELECT CASE
              WHEN GROUPING(DL.WORK_DATE) = 1 THEN -10  -- 그룹핑 된 항목.
              ELSE DL.PERSON_ID
            END AS PERSON_ID
          , NVL(DL.WORK_DATE, NULL) AS WORK_DATE
          , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
          , T2.FLOOR_NAME
          , T1.JOB_CATEGORY_NAME
          , CASE
              WHEN GROUPING(DL.WORK_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
              ELSE T1.NAME
            END AS NAME
          , NVL(DL.DUTY_ID, NULL) AS DUTY_ID
          , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
          , DL.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
          , NVL(DL.OPEN_TIME, NULL) AS OPEN_TIME
          , NVL(DL.CLOSE_TIME, NULL) AS CLOSE_TIME
          , NVL(DL.OPEN_TIME1, NULL) AS OPEN_TIME1
          , NVL(DL.CLOSE_TIME1, NULL) AS CLOSE_TIME1
          , DL.NEXT_DAY_YN
          , DL.DANGJIK_YN
          , DL.ALL_NIGHT_YN
          , SUM(DL.LEAVE_TIME) AS LEAVE_TIME
          , SUM(DL.LATE_TIME) AS LATE_TIME
          , SUM(DL.REST_TIME) AS REST_TIME
          , SUM(DL.OVER_TIME) AS OVER_TIME
          , SUM(DL.HOLIDAY_TIME) AS HOLIDAY_TIME
          , SUM(DL.HOLIDAY_OT_TIME) AS HOLIDAY_OT_TIME
          , SUM(DL.NIGHT_TIME) AS NIGHT_TIME
          , SUM(DL.NIGHT_BONUS_TIME) AS NIGHT_BONUS_TIME
          , DL.HOLIDAY_CHECK
          , DL.CLOSED_YN
          , NVL(DL.CLOSED_PERSON_ID, NULL) AS CLOSED_PERSON_ID
          , DL.WORK_TYPE_GROUP
          , NVL(DL.PL_OPEN_TIME, NULL) AS PL_OPEN_TIME
          , NVL(DL.PL_CLOSE_TIME, NULL) AS PL_CLOSE_TIME
          , NVL(DL.PL_BEFORE_OT_START, NULL) AS PL_BEFORE_OT_START
          , NVL(DL.PL_BEFORE_OT_END, NULL) AS PL_BEFORE_OT_END
          , NVL(DL.PL_AFTER_OT_START, NULL) AS PL_AFTER_OT_START
          , NVL(DL.PL_AFTER_OT_END, NULL) AS PL_AFTER_OT_END
          , DL.PL_LUNCH_YN
          , DL.PL_DINNER_YN
          , DL.PL_MIDNIGHT_YN
          , T1.PERSON_NUM
          , NVL(T1.ORI_JOIN_DATE, NULL) AS ORI_JOIN_DATE
          , NVL(T1.RETIRE_DATE, NULL) AS RETIRE_DATE
          , NVL(DL.WORK_CORP_ID, NULL) AS CORP_ID
          , NVL(DL.DAY_LEAVE_ID, NULL) AS DAY_LEAVE_ID
      FROM HRD_DAY_LEAVE_V1 DL
        , (-- 시점 인사내역.
           SELECT HL.PERSON_ID
                , PM.NAME
                , PM.PERSON_NUM
                , PM.DISPLAY_NAME
                , HL.DEPT_ID
                , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
                , HL.POST_ID
                , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                , HL.JOB_CATEGORY_ID
                , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                , PM.CORP_ID
                , PM.WORK_CORP_ID
                , PM.ORI_JOIN_DATE
                , PM.JOIN_DATE
                , PM.RETIRE_DATE
                , PM.SOB_ID
                , PM.ORG_ID
             FROM HRM_HISTORY_LINE HL
               , HRM_PERSON_MASTER PM
           WHERE HL.PERSON_ID        = PM.PERSON_ID
             AND HL.HISTORY_LINE_ID  
                   IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                        WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                          AND S_HL.PERSON_ID              = HL.PERSON_ID
                        GROUP BY S_HL.PERSON_ID
                      )
          ) T1
        , (-- 시점 인사내역.
            SELECT PH.PERSON_ID
                 , PH.FLOOR_ID
                 , PH.SOB_ID
                 , PH.ORG_ID
                 , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
              FROM HRD_PERSON_HISTORY        PH
            WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
              AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
          ) T2
      WHERE DL.PERSON_ID              = T1.PERSON_ID
        AND DL.PERSON_ID              = T2.PERSON_ID
        AND DL.SOB_ID                 = T2.SOB_ID
        AND DL.ORG_ID                 = T2.ORG_ID
        AND DL.WORK_DATE              BETWEEN CASE 
                                                WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                ELSE W_START_DATE
                                              END
                                      AND CASE 
                                            WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                            WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                            ELSE W_END_DATE
                                          END
        AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
        AND DL.WORK_CORP_ID           = W_CORP_ID
        AND DL.SOB_ID                 = W_SOB_ID
        AND DL.ORG_ID                 = W_ORG_ID
        AND DL.CLOSED_YN              = DECODE(W_CLOSE_YN, 'A', DL.CLOSED_YN, NVL(W_CLOSE_YN, DL.CLOSED_YN))
        AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
        AND DL.DUTY_ID                = NVL(W_DUTY_ID, DL.DUTY_ID)
        AND ((W_FLOOR_ID              IS NULL
          AND 1                       = 1)
        OR   (W_FLOOR_ID              IS NOT NULL
          AND T2.FLOOR_ID             = W_FLOOR_ID))
        AND ((W_DEPT_ID               IS NULL
          AND 1                       = 1)
        OR   (W_DEPT_ID               IS NOT NULL
          AND T1.DEPT_ID              = W_DEPT_ID))
        AND ((W_JOB_CATEGORY_ID        IS NULL
          AND 1                       = 1)
        OR  (W_JOB_CATEGORY_ID        IS NOT NULL
          AND T1.JOB_CATEGORY_ID      = W_JOB_CATEGORY_ID))
        AND T1.JOIN_DATE              <= W_END_DATE
        AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_START_DATE)
        AND EXISTS 
              ( SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
                WHERE DM.CORP_ID                                = DL.WORK_CORP_ID
                  AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
                  AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DL.WORK_TYPE_ID)
                  AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                  AND DM.START_DATE                              <= W_END_DATE
                  AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_START_DATE)
                  AND DM.SOB_ID                                  = DL.SOB_ID
                  AND DM.ORG_ID                                  = DL.ORG_ID
               )
      GROUP BY ROLLUP ((DL.PERSON_ID
          , DL.WORK_DATE
          , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID)
          , T2.FLOOR_NAME
          , T1.JOB_CATEGORY_NAME
          , DL.DUTY_ID
          , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) 
          , DL.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) 
          , DL.OPEN_TIME
          , DL.CLOSE_TIME
          , DL.OPEN_TIME1
          , DL.CLOSE_TIME1
          , DL.NEXT_DAY_YN
          , DL.DANGJIK_YN
          , DL.ALL_NIGHT_YN
          , DL.HOLIDAY_CHECK
          , DL.CLOSED_YN
          , DL.CLOSED_PERSON_ID
          , DL.WORK_TYPE_GROUP
          , DL.PL_OPEN_TIME
          , DL.PL_CLOSE_TIME
          , DL.PL_BEFORE_OT_START
          , DL.PL_BEFORE_OT_END
          , DL.PL_AFTER_OT_START
          , DL.PL_AFTER_OT_END
          , DL.PL_LUNCH_YN
          , DL.PL_DINNER_YN
          , DL.PL_MIDNIGHT_YN
          , T1.ORI_JOIN_DATE
          , T1.RETIRE_DATE
          , T1.PERSON_NUM
          , T1.NAME
          , DL.WORK_CORP_ID
          , DL.DAY_LEAVE_ID)) 
      ORDER BY T1.PERSON_NUM, DL.WORK_DATE, DL.HOLY_TYPE, DL.WORK_TYPE_GROUP
      ;
      /*SELECT DL.PERSON_ID
          , DL.WORK_DATE
          , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
          , T2.FLOOR_NAME
          , T1.JOB_CATEGORY_NAME
          , DL.DUTY_ID
          , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
          , DL.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
          , DL.OPEN_TIME
          , DL.CLOSE_TIME
          , DL.OPEN_TIME1
          , DL.CLOSE_TIME1
          , DL.NEXT_DAY_YN
          , DL.DANGJIK_YN
          , DL.ALL_NIGHT_YN
          , DL.LEAVE_TIME
          , DL.LATE_TIME
          , DL.REST_TIME
          , DL.OVER_TIME
          , DL.HOLIDAY_TIME
          , DL.NIGHT_TIME
          , DL.NIGHT_BONUS_TIME
          , DL.HOLIDAY_CHECK
          , DL.CLOSED_YN
          , DL.CLOSED_PERSON_ID
          , DL.WORK_TYPE_GROUP
          , DL.PL_OPEN_TIME
          , DL.PL_CLOSE_TIME
          , DL.PL_BEFORE_OT_START
          , DL.PL_BEFORE_OT_END
          , DL.PL_AFTER_OT_START
          , DL.PL_AFTER_OT_END
          , DL.PL_LUNCH_YN
          , DL.PL_DINNER_YN
          , DL.PL_MIDNIGHT_YN
          , T1.ORI_JOIN_DATE
          , T1.RETIRE_DATE
          , T1.PERSON_NUM
          , T1.NAME
          , DL.WORK_CORP_ID AS CORP_ID
          , DL.DAY_LEAVE_ID
      FROM HRD_DAY_LEAVE_V1 DL
        , (-- 시점 인사내역.
           SELECT HL.PERSON_ID
               , PM.NAME
               , PM.PERSON_NUM
               , PM.DISPLAY_NAME
               , HL.DEPT_ID
               , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
               , HL.POST_ID
               , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
               , HL.JOB_CATEGORY_ID
               , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
               , PM.CORP_ID
                        , PM.WORK_CORP_ID
               , PM.ORI_JOIN_DATE
                        , PM.JOIN_DATE
               , PM.RETIRE_DATE
               , PM.SOB_ID
               , PM.ORG_ID
             FROM HRM_HISTORY_LINE HL
               , HRM_PERSON_MASTER PM
           WHERE HL.PERSON_ID        = PM.PERSON_ID
             AND HL.HISTORY_LINE_ID  
                   IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                        WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                          AND S_HL.PERSON_ID              = HL.PERSON_ID
                        GROUP BY S_HL.PERSON_ID
                      )
          ) T1
        , (-- 시점 인사내역.
            SELECT PH.PERSON_ID
                 , PH.FLOOR_ID
                 , PH.SOB_ID
                 , PH.ORG_ID
                 , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
              FROM HRD_PERSON_HISTORY        PH
            WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
              AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
          ) T2
      WHERE DL.PERSON_ID              = T1.PERSON_ID
      AND DL.WORK_CORP_ID           = T1.WORK_CORP_ID
      AND DL.SOB_ID                 = T1.SOB_ID
      AND DL.ORG_ID                 = T1.ORG_ID
      AND DL.PERSON_ID              = T2.PERSON_ID
      AND DL.SOB_ID                 = T2.SOB_ID
      AND DL.ORG_ID                 = T2.ORG_ID
      AND DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
      AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
      AND DL.WORK_CORP_ID           = W_CORP_ID
      AND DL.SOB_ID                 = W_SOB_ID
      AND DL.ORG_ID                 = W_ORG_ID
      AND DL.CLOSED_YN              = DECODE(W_CLOSE_YN, 'A', DL.CLOSED_YN, NVL(W_CLOSE_YN, DL.CLOSED_YN))
      AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
      AND DL.DUTY_ID                = NVL(W_DUTY_ID, DL.DUTY_ID)
      AND T2.FLOOR_ID               = NVL(W_FLOOR_ID, T2.FLOOR_ID)
      AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
      AND T1.JOB_CATEGORY_ID        = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
      AND T1.JOIN_DATE              <= W_END_DATE
      AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_START_DATE)
      AND EXISTS (SELECT 'X'
                    FROM HRD_DUTY_MANAGER DM
                  WHERE DM.CORP_ID                                = DL.WORK_CORP_ID
                    AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
                    AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DL.WORK_TYPE_ID)
                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                    AND DM.START_DATE                              <= W_END_DATE
                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_START_DATE)
                    AND DM.SOB_ID                                  = DL.SOB_ID
                    AND DM.ORG_ID                                  = DL.ORG_ID
                 )
      ORDER BY T1.PERSON_NUM, DL.WORK_DATE, DL.HOLY_TYPE, DL.WORK_TYPE_ID, T2.FLOOR_ID
      ;*/
  END DATA_SELECT;

-- 근태 오류자 조회.
  PROCEDURE SELECT_DAY_LEAVE_MISTAKE
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_MODIFY_FLAG                       IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
            , W_CLOSE_YN                          IN HRD_DAY_LEAVE.CLOSED_YN%TYPE
            , W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_DUTY_ID                           IN HRM_COMMON.COMMON_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_DEPT_ID                           IN HRM_DEPT_MASTER.DEPT_ID%TYPE
            , W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DL.PERSON_ID
      , DL.WORK_DATE
      , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
      , T2.FLOOR_NAME
      , T1.JOB_CATEGORY_NAME
      , DL.DUTY_ID
      , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
      , DL.HOLY_TYPE
      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
      , DL.OPEN_TIME
      , DL.CLOSE_TIME
      , DL.OPEN_TIME1
      , DL.CLOSE_TIME1
      , DL.NEXT_DAY_YN
      , DL.DANGJIK_YN
      , DL.ALL_NIGHT_YN
      , DL.LEAVE_TIME
      , DL.LATE_TIME
      , DL.REST_TIME
      , DL.OVER_TIME
      , DL.HOLIDAY_TIME
      , DL.HOLIDAY_OT_TIME
      , DL.NIGHT_TIME
      , DL.NIGHT_BONUS_TIME
      , DL.HOLIDAY_CHECK
      , DL.CLOSED_YN
      , DL.CLOSED_PERSON_ID
      , DL.WORK_TYPE_GROUP
      , DL.PL_OPEN_TIME
      , DL.PL_CLOSE_TIME
      , DL.PL_BEFORE_OT_START
      , DL.PL_BEFORE_OT_END
      , DL.PL_AFTER_OT_START
      , DL.PL_AFTER_OT_END
      , DL.PL_LUNCH_YN
      , DL.PL_DINNER_YN
      , DL.PL_MIDNIGHT_YN
      , T1.ORI_JOIN_DATE
      , T1.RETIRE_DATE
      , T1.PERSON_NUM
      , T1.NAME
      , DL.WORK_CORP_ID AS CORP_ID
      , DL.DAY_LEAVE_ID
    FROM HRD_DAY_LEAVE_V1 DL
      , (-- 시점 인사내역.
         SELECT HL.PERSON_ID
           , PM.NAME
           , PM.PERSON_NUM
           , PM.DISPLAY_NAME
           , HL.DEPT_ID
           , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
           , HL.POST_ID
           , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
           , HL.JOB_CATEGORY_ID
           , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
           , PM.CORP_ID
           , PM.WORK_CORP_ID
           , PM.ORI_JOIN_DATE
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , PM.SOB_ID
           , PM.ORG_ID
          FROM HRM_HISTORY_LINE HL
           , HRM_PERSON_MASTER PM
         WHERE HL.PERSON_ID        = PM.PERSON_ID
          AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                         FROM HRM_HISTORY_LINE S_HL
                         WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                          AND S_HL.PERSON_ID              = HL.PERSON_ID
                         GROUP BY S_HL.PERSON_ID
                        )
         ) T1
       , (-- 시점 인사내역.
          SELECT PH.PERSON_ID
               , PH.FLOOR_ID
               , PH.SOB_ID
               , PH.ORG_ID
               , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
            FROM HRD_PERSON_HISTORY        PH
           WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
             AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
         ) T2
   WHERE DL.PERSON_ID              = T1.PERSON_ID
    AND DL.WORK_CORP_ID           = T1.WORK_CORP_ID
    AND DL.SOB_ID                 = T1.SOB_ID
    AND DL.ORG_ID                 = T1.ORG_ID
    AND DL.PERSON_ID              = T2.PERSON_ID
    AND DL.SOB_ID                 = T2.SOB_ID
    AND DL.ORG_ID                 = T2.ORG_ID
    AND DL.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
    AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
    AND DL.WORK_CORP_ID           = W_CORP_ID
    AND DL.SOB_ID                 = W_SOB_ID
    AND DL.ORG_ID                 = W_ORG_ID
    AND DL.CLOSED_YN              = DECODE(W_CLOSE_YN, 'A', DL.CLOSED_YN, NVL(W_CLOSE_YN, DL.CLOSED_YN))
    AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
    AND DL.DUTY_ID                = NVL(W_DUTY_ID, DL.DUTY_ID)
    AND T2.FLOOR_ID               = NVL(W_FLOOR_ID, T2.FLOOR_ID)
    AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
    AND T1.JOB_CATEGORY_ID        = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
        AND T1.JOIN_DATE              <= W_END_DATE
        AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_START_DATE)
        AND ((EXISTS ( SELECT 'X'
                       FROM HRM_DUTY_CODE_V DC
                     WHERE DC.DUTY_ID       = DL.DUTY_ID
                       AND DC.DUTY_CODE     IN ('00', '11', '21', '53')
                    )
          AND ((DL.OPEN_TIME          IS NULL
             OR DL.CLOSE_TIME         IS NULL)
           OR (DL.OPEN_TIME1          IS NOT NULL
             OR DL.CLOSE_TIME1        IS NOT NULL)))
        OR (EXISTS ( SELECT 'X'
                       FROM HRM_DUTY_CODE_V DC
                     WHERE DC.DUTY_ID       = DL.DUTY_ID
                       AND DC.DUTY_CODE IN ('51', '52')
                    )
          AND ((DL.OPEN_TIME          IS NOT NULL
           OR DL.CLOSE_TIME           IS NOT NULL))))
   ORDER BY DL.WORK_DATE, DL.HOLY_TYPE, DL.WORK_TYPE_ID, T2.FLOOR_ID, T1.PERSON_NUM
      ;
  END SELECT_DAY_LEAVE_MISTAKE;

-- DAY LEAVE UPDATE
  PROCEDURE DATA_UPDATE
           (  W_DAY_LEAVE_ID                      IN HRD_DAY_LEAVE.DAY_LEAVE_ID%TYPE
            , P_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , P_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , P_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , P_DUTY_ID                           IN HRD_DAY_LEAVE.DUTY_ID%TYPE
            , P_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , P_OPEN_TIME                         IN HRD_DAY_LEAVE.OPEN_TIME%TYPE
            , P_CLOSE_TIME                        IN HRD_DAY_LEAVE.CLOSE_TIME%TYPE
            , P_OPEN_TIME1                        IN HRD_DAY_LEAVE.OPEN_TIME1%TYPE
            , P_CLOSE_TIME1                       IN HRD_DAY_LEAVE.CLOSE_TIME1%TYPE
            , P_NEXT_DAY_YN                       IN HRD_DAY_LEAVE.NEXT_DAY_YN%TYPE
            , P_DANGJIK_YN                        IN HRD_DAY_LEAVE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                      IN HRD_DAY_LEAVE.ALL_NIGHT_YN%TYPE
            , P_LEAVE_TIME                        IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_LATE_TIME                         IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_REST_TIME                         IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_OVER_TIME                         IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_HOLIDAY_TIME                      IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_HOLIDAY_OT_TIME                   IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_NIGHT_TIME                        IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_NIGHT_BONUS_TIME                  IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            --, P_DESCRIPTION                       IN HRD_DAY_LEAVE.DESCRIPTION%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
      )
  AS
    V_SYSDATE                     HRD_DAY_LEAVE.CREATION_DATE%TYPE := GET_LOCAL_DATE(P_SOB_ID);
    V_CLOSE_COUNT                 NUMBER := 0;
   
   -- 출퇴근interface 동기화 변수--
    V_DEFAULT_TIME                DATE := TO_DATE('2001-01-01', 'YYYY-MM-DD');
    
    V_DUTY_ID                     HRM_COMMON.COMMON_ID%TYPE;
    V_A_DUTY_ID                   HRM_COMMON.COMMON_ID%TYPE;
		V_NA_DUTY_ID                  HRM_COMMON.COMMON_ID%TYPE;
		V_H_DUTY_ID                   HRM_COMMON.COMMON_ID%TYPE;
		V_NH_DUTY_ID                  HRM_COMMON.COMMON_ID%TYPE;
		V_PH_DUTY_ID                  HRM_COMMON.COMMON_ID%TYPE;
    
    V_OPEN_TIME                   HRD_DAY_LEAVE.OPEN_TIME%TYPE;
    V_CLOSE_TIME                  HRD_DAY_LEAVE.CLOSE_TIME%TYPE;
    V_OPEN_TIME1                  HRD_DAY_LEAVE.OPEN_TIME1%TYPE;
    V_CLOSE_TIME1                 HRD_DAY_LEAVE.CLOSE_TIME1%TYPE;
    V_MODIFY_CODE                 VARCHAR2(10);
    V_MODIFY_ID                   NUMBER;
  BEGIN
    -- 마감 여부 체크.
    BEGIN
      SELECT NVL(SUM(DECODE(DL.CLOSED_YN, 'Y', 1, 0)), 0) AS CLOSE_COUNT
        INTO V_CLOSE_COUNT
        FROM HRD_DAY_LEAVE DL
      WHERE DL.DAY_LEAVE_ID               = W_DAY_LEAVE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSE_COUNT := 0;
    END;
    IF V_CLOSE_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
      RETURN;
    END IF;
    
    -- 전호수 추가 : 출퇴근 interface 동기화 --.
    V_DUTY_ID         := P_DUTY_ID;
    BEGIN
		  SELECT MAX(DECODE(DC.ATTEND_FLAG, 'A', DC.DUTY_ID, NULL)) AS ATTEND
					 , MAX(DECODE(DC.ATTEND_FLAG, 'NA', DC.DUTY_ID, NULL)) AS NONATTEND
					 , MAX(DECODE(DC.ATTEND_FLAG, 'H', DC.DUTY_ID, NULL)) AS HOLIDAY
					 , MAX(DECODE(DC.ATTEND_FLAG, 'NH', DC.DUTY_ID, NULL)) AS NONPAYHOLIDAY
					 , MAX(DECODE(DC.ATTEND_FLAG, 'PH', DC.DUTY_ID, NULL)) AS PAYHOLIDAY
				INTO V_A_DUTY_ID, V_NA_DUTY_ID, V_H_DUTY_ID, V_NH_DUTY_ID, V_PH_DUTY_ID
        FROM HRM_DUTY_CODE_V DC
       WHERE DC.ATTEND_FLAG                          IS NOT NULL
         AND DC.SOB_ID                               = P_SOB_ID
         AND DC.ORG_ID                               = P_ORG_ID
			;
		EXCEPTION WHEN OTHERS THEN
		  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10045', '&&VALUE:=Duty Default Value(근태 기본값)&&TEXT:=Duty Code Check!(근태코드를 확인하세요)'));
		END;
    
    V_OPEN_TIME       := P_OPEN_TIME;
    V_CLOSE_TIME      := P_CLOSE_TIME;
    V_OPEN_TIME1      := P_OPEN_TIME1;
    V_CLOSE_TIME1     := P_CLOSE_TIME1;
    BEGIN
      SELECT DL.DUTY_ID
           , DL.OPEN_TIME
           , DL.CLOSE_TIME
           , DL.OPEN_TIME1
           , DL.CLOSE_TIME1
        INTO V_DUTY_ID
           , V_OPEN_TIME
           , V_CLOSE_TIME
           , V_OPEN_TIME1
           , V_CLOSE_TIME1
        FROM HRD_DAY_LEAVE DL
      WHERE DL.DAY_LEAVE_ID       = W_DAY_LEAVE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
    IF P_DUTY_ID = V_A_DUTY_ID THEN  -- 출근.
      V_DUTY_ID := V_A_DUTY_ID;
    ELSIF P_DUTY_ID = V_NA_DUTY_ID THEN  -- 결근.
      V_DUTY_ID := V_NA_DUTY_ID;
    ELSIF P_DUTY_ID = V_H_DUTY_ID THEN  -- 유휴.
      V_DUTY_ID := V_H_DUTY_ID;
    ELSIF P_DUTY_ID = V_NH_DUTY_ID THEN  -- 무휴.
      V_DUTY_ID := V_NH_DUTY_ID;
    ELSIF P_DUTY_ID = V_PH_DUTY_ID THEN  -- 휴일근무.
      V_DUTY_ID := V_PH_DUTY_ID;
    ELSE  -- 그외.
      --근무계획 UPDATE.
      UPDATE HRD_WORK_CALENDAR WC
        SET WC.C_DUTY_ID1         = P_DUTY_ID
      WHERE WC.WORK_DATE          = P_WORK_DATE
        AND WC.PERSON_ID          = P_PERSON_ID
        AND WC.SOB_ID             = P_SOB_ID
        AND WC.ORG_ID             = P_ORG_ID
      ;
    END IF;
 
    -- 수정사유 ID --
    V_MODIFY_CODE := NULL;
    IF NVL(V_OPEN_TIME, V_DEFAULT_TIME) = NVL(P_OPEN_TIME, V_DEFAULT_TIME) AND
       NVL(V_OPEN_TIME1, V_DEFAULT_TIME) = NVL(P_OPEN_TIME1, V_DEFAULT_TIME) AND
       NVL(V_CLOSE_TIME, V_DEFAULT_TIME) = NVL(P_CLOSE_TIME, V_DEFAULT_TIME) AND
       NVL(V_CLOSE_TIME1, V_DEFAULT_TIME) = NVL(P_CLOSE_TIME1, V_DEFAULT_TIME) THEN
      V_MODIFY_CODE := NULL;       
    ELSIF V_OPEN_TIME IS NULL AND V_OPEN_TIME1 IS NULL AND V_CLOSE_TIME IS NULL AND V_CLOSE_TIME1 IS NULL AND 
      (P_OPEN_TIME IS NOT NULL OR P_OPEN_TIME1 IS NOT NULL OR P_CLOSE_TIME IS NOT NULL OR P_CLOSE_TIME1 IS NOT NULL) THEN
      -- 미체크 수정.
      V_MODIFY_CODE := '02';
    ELSIF (V_OPEN_TIME IS NOT NULL OR V_OPEN_TIME1 IS NOT NULL OR V_CLOSE_TIME IS NOT NULL OR V_CLOSE_TIME1 IS NOT NULL) AND 
      (P_OPEN_TIME IS NOT NULL OR P_OPEN_TIME1 IS NOT NULL OR P_CLOSE_TIME IS NOT NULL OR P_CLOSE_TIME1 IS NOT NULL) THEN
      -- 출퇴근 시간 정정.
      V_MODIFY_CODE := '09';
    ELSIF (V_OPEN_TIME IS NOT NULL OR V_OPEN_TIME1 IS NOT NULL OR V_CLOSE_TIME IS NOT NULL OR V_CLOSE_TIME1 IS NOT NULL) AND 
      (P_OPEN_TIME IS NULL AND P_OPEN_TIME1 IS NULL AND P_CLOSE_TIME IS NULL AND P_CLOSE_TIME1 IS NULL) THEN
      -- 출퇴근 시간 삭제.
      V_MODIFY_CODE := '06';
    END IF;
    IF V_MODIFY_CODE IS NOT NULL THEN
      BEGIN
        SELECT HC.COMMON_ID
          INTO V_MODIFY_ID
          FROM HRM_COMMON HC
        WHERE HC.GROUP_CODE     = 'DUTY_MODIFY'
          AND HC.CODE           = V_MODIFY_CODE
          AND HC.SOB_ID         = P_SOB_ID
          AND HC.ORG_ID         = P_ORG_ID
          AND ROWNUM            <= 1
        ;
      EXCEPTION WHEN OTHERS THEN
        V_MODIFY_ID := NULL;
      END;
    END IF;
    -- 일근태 데이터 변경시 출퇴근 INTERFACE 동기화 : 출근 --
    IF NVL(V_DUTY_ID, -1) <> NVL(P_DUTY_ID, -1) OR 
       NVL(V_OPEN_TIME, V_DEFAULT_TIME) <> NVL(P_OPEN_TIME, V_DEFAULT_TIME) OR
       NVL(V_OPEN_TIME1, V_DEFAULT_TIME) <> NVL(P_OPEN_TIME1, V_DEFAULT_TIME) THEN
      HRD_DAY_LEAVE_G.UPDATE_DAY_INTERFACE
        ( W_PERSON_ID         => P_PERSON_ID
        , W_WORK_DATE         => P_WORK_DATE
        , W_CORP_ID           => P_CORP_ID
        , W_SOB_ID            => P_SOB_ID
        , W_ORG_ID            => P_ORG_ID
        , W_IO_FLAG           => '1'
        , P_DUTY_ID           => V_DUTY_ID
        , P_HOLY_TYPE         => P_HOLY_TYPE
        , P_MODIFY_TIME       => P_OPEN_TIME
        , P_MODIFY_TIME1      => P_OPEN_TIME1
        , P_MODIFY_ID         => V_MODIFY_ID
        , P_NEXT_DAY_YN       => P_NEXT_DAY_YN
        , P_DANGJIK_YN        => P_DANGJIK_YN
        , P_ALL_NIGHT_YN      => P_ALL_NIGHT_YN
        , P_LEAVE_ID          => NULL
        , P_LEAVE_TIME_CODE   => NULL 
        , P_DESCRIPTION       => NULL						
        , P_IO_TIME           => V_OPEN_TIME
        , P_IO_TIME1          => V_OPEN_TIME1
        , P_USER_ID           => P_USER_ID
        );
    END IF;
    -- 일근태 데이터 변경시 출퇴근 INTERFACE 동기화 : 퇴근 --
    IF NVL(V_CLOSE_TIME, V_DEFAULT_TIME) <> NVL(P_CLOSE_TIME, V_DEFAULT_TIME) OR
       NVL(V_CLOSE_TIME1, V_DEFAULT_TIME) <> NVL(P_CLOSE_TIME1, V_DEFAULT_TIME) THEN
      HRD_DAY_LEAVE_G.UPDATE_DAY_INTERFACE
        ( W_PERSON_ID         => P_PERSON_ID
        , W_WORK_DATE         => P_WORK_DATE
        , W_CORP_ID           => P_CORP_ID
        , W_SOB_ID            => P_SOB_ID
        , W_ORG_ID            => P_ORG_ID
        , W_IO_FLAG           => '2'
        , P_DUTY_ID           => V_DUTY_ID
        , P_HOLY_TYPE         => P_HOLY_TYPE
        , P_MODIFY_TIME       => P_CLOSE_TIME
        , P_MODIFY_TIME1      => P_CLOSE_TIME1
        , P_MODIFY_ID         => V_MODIFY_ID
        , P_NEXT_DAY_YN       => P_NEXT_DAY_YN
        , P_DANGJIK_YN        => P_DANGJIK_YN
        , P_ALL_NIGHT_YN      => P_ALL_NIGHT_YN
        , P_LEAVE_ID          => NULL
        , P_LEAVE_TIME_CODE   => NULL 
        , P_DESCRIPTION       => NULL						
        , P_IO_TIME           => V_OPEN_TIME
        , P_IO_TIME1          => V_OPEN_TIME1
        , P_USER_ID           => P_USER_ID
        );
    END IF;
    
    UPDATE HRD_DAY_LEAVE DL
      SET DL.DUTY_ID                  = V_DUTY_ID
        , DL.HOLY_TYPE                = P_HOLY_TYPE
        , DL.OPEN_TIME                = P_OPEN_TIME
        , DL.CLOSE_TIME               = P_CLOSE_TIME
        , DL.OPEN_TIME1               = P_OPEN_TIME1
        , DL.CLOSE_TIME1              = P_CLOSE_TIME1
        , DL.NEXT_DAY_YN              = P_NEXT_DAY_YN
        , DL.DANGJIK_YN               = P_DANGJIK_YN
        , DL.ALL_NIGHT_YN             = P_ALL_NIGHT_YN
        --, DL.DESCRIPTION              = P_DESCRIPTION
        , DL.LAST_UPDATE_DATE         = V_SYSDATE
        , DL.LAST_UPDATED_BY          = P_USER_ID
    WHERE DL.DAY_LEAVE_ID             = W_DAY_LEAVE_ID
    ;

    -- 잔업 사항 저장. --
    -- LEAVE_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '11'
                      , P_OT_TIME => P_LEAVE_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );

    -- LATE_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '12'
                      , P_OT_TIME => P_LATE_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
    -- REST_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '13'
                      , P_OT_TIME => P_REST_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
    -- OVER_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '14'
                      , P_OT_TIME => P_OVER_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
    -- HOLIDAY_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '15'
                      , P_OT_TIME => P_HOLIDAY_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
    -- 휴일연장시간.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '18'
                      , P_OT_TIME => P_HOLIDAY_OT_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
    -- NIGHT_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '16'
                      , P_OT_TIME => P_NIGHT_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
    -- NIGHT_BONUS_TIME.
    DAY_LEAVE_OT_SAVE ( P_DAY_LEAVE_ID => W_DAY_LEAVE_ID
                      , P_OT_TYPE => '17'
                      , P_OT_TIME => P_NIGHT_BONUS_TIME
                      , P_PERSON_ID => P_PERSON_ID
                      , P_WORK_DATE => P_WORK_DATE
                      , P_CORP_ID => P_CORP_ID
                      , P_SOB_ID => P_SOB_ID
                      , P_ORG_ID => P_ORG_ID
                      , P_USER_ID => P_USER_ID
                      );
 END DATA_UPDATE;

-- DAY_LEAVE_OT SAVE(INSERT/UPDATE).
  PROCEDURE DAY_LEAVE_OT_SAVE
           (  P_DAY_LEAVE_ID                      IN HRD_DAY_LEAVE_OT.DAY_LEAVE_ID%TYPE
            , P_OT_TYPE                           IN HRD_DAY_LEAVE_OT.OT_TYPE%TYPE
            , P_OT_TIME                           IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
            , P_PERSON_ID                         IN HRD_DAY_LEAVE_OT.PERSON_ID%TYPE
            , P_WORK_DATE                         IN HRD_DAY_LEAVE_OT.WORK_DATE%TYPE
            , P_CORP_ID                           IN HRD_DAY_LEAVE_OT.CORP_ID%TYPE
            , P_SOB_ID                            IN HRD_DAY_LEAVE_OT.SOB_ID%TYPE
            , P_ORG_ID                            IN HRD_DAY_LEAVE_OT.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_LEAVE_OT.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE       HRD_DAY_LEAVE_OT.CREATION_DATE%TYPE := GET_LOCAL_DATE(P_SOB_ID);
    V_CLOSE_COUNT   NUMBER := 0;
  BEGIN
    BEGIN
      SELECT NVL(SUM(DECODE(DL.CLOSED_YN, 'Y', 1, 0)), 0) AS CLOSE_COUNT
        INTO V_CLOSE_COUNT
        FROM HRD_DAY_LEAVE DL
      WHERE DL.DAY_LEAVE_ID               = P_DAY_LEAVE_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSE_COUNT := 0;
    END;
    IF V_CLOSE_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
      RETURN;
    END IF;

    UPDATE HRD_DAY_LEAVE_OT DL
        SET DL.OT_TIME           = NVL(P_OT_TIME, 0)
          , DL.LAST_UPDATE_DATE  = V_SYSDATE
          , DL.LAST_UPDATED_BY   = P_USER_ID
    WHERE DL.DAY_LEAVE_ID     = P_DAY_LEAVE_ID
      AND DL.OT_TYPE          = P_OT_TYPE
    ;
    IF (SQL%NOTFOUND) THEN
      INSERT INTO HRD_DAY_LEAVE_OT
      ( DAY_LEAVE_ID
      , OT_TYPE, OT_TIME
      , PERSON_ID, WORK_DATE, CORP_ID
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY
      , LAST_UPDATE_DATE, LAST_UPDATED_BY
      ) VALUES
      ( P_DAY_LEAVE_ID
      , P_OT_TYPE, NVL(P_OT_TIME, 0)
      , P_PERSON_ID, P_WORK_DATE, P_CORP_ID
      , P_SOB_ID, P_ORG_ID
      , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
      );
    END IF;
  END DAY_LEAVE_OT_SAVE;

-- 출퇴근INTERFACE DATA UPDATE.
  PROCEDURE UPDATE_DAY_INTERFACE
            ( W_PERSON_ID                         IN HRD_DAY_MODIFY.PERSON_ID%TYPE
						, W_WORK_DATE                         IN HRD_DAY_MODIFY.WORK_DATE%TYPE
						, W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
						, W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
						, W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_IO_FLAG                           IN HRD_DAY_MODIFY.IO_FLAG%TYPE
						, P_DUTY_ID                           IN HRD_WORK_CALENDAR.DUTY_ID%TYPE
            , P_HOLY_TYPE                         IN HRD_DAY_INTERFACE.HOLY_TYPE%TYPE
						, P_MODIFY_TIME                       IN HRD_DAY_MODIFY.MODIFY_TIME%TYPE
						, P_MODIFY_TIME1                      IN HRD_DAY_MODIFY.MODIFY_TIME1%TYPE
						, P_MODIFY_ID                         IN HRD_DAY_MODIFY.MODIFY_ID%TYPE
						, P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
            , P_DANGJIK_YN                        IN HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                      IN HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
						, P_LEAVE_ID                          IN HRD_DAY_INTERFACE.LEAVE_ID%TYPE
						, P_LEAVE_TIME_CODE                   IN HRD_DAY_INTERFACE.LEAVE_TIME_CODE%TYPE
						, P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE						
            , P_IO_TIME                           IN HRD_DAY_INTERFACE.OPEN_TIME%TYPE
						, P_IO_TIME1                          IN HRD_DAY_INTERFACE.OPEN_TIME1%TYPE
						, P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CONNECT_LEVEL                               VARCHAR2(1) := 'C';
    V_CONNECT_PERSON_ID                           NUMBER;
		V_IO_YN                                       HRD_DAY_INTERFACE.APPROVED_YN%TYPE;
		
    V_WORK_DATE                                   HRD_DAY_MODIFY.WORK_DATE%TYPE;
		V_MODIFY_TIME                                 HRD_DAY_MODIFY.MODIFY_TIME%TYPE := NULL;
		V_MODIFY_YN                                   HRD_DAY_INTERFACE.MODIFY_YN%TYPE := 'N';
		V_MODIFY_IO_YN                                HRD_DAY_INTERFACE.MODIFY_IN_YN%TYPE := 'N';
  BEGIN
    -- 근무일자 정리.
    V_WORK_DATE := W_WORK_DATE;
    IF V_WORK_DATE IS NULL THEN
      IF W_IO_FLAG = '2' AND (P_HOLY_TYPE = '3' OR P_DANGJIK_YN = 'Y' OR P_ALL_NIGHT_YN = 'Y') THEN
        V_WORK_DATE := V_WORK_DATE;
      END IF;
    END IF;
    
    -- 접속자 사원ID --
    BEGIN
      SELECT UP.PERSON_ID
        INTO V_CONNECT_PERSON_ID
        FROM EAPP_USER_PERSON_V UP
      WHERE UP.USER_ID          = P_USER_ID
        AND UP.SOB_ID           = W_SOB_ID
        AND UP.ORG_ID           = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CONNECT_PERSON_ID := -1;
    END;
-----------------------------------------------------------------------------------------
-- 전산자료하고 수정 시간하고 동일할 경우 출퇴근수정에 INSERT/UPDATE하지 않음.
	  IF W_IO_FLAG = '1' THEN    
      IF P_MODIFY_TIME IS NULL AND P_MODIFY_TIME1 IS NULL AND P_MODIFY_ID IS NULL THEN
        V_MODIFY_IO_YN := 'N';
        -- 기존자료 삭제.
        DELETE FROM HRD_DAY_MODIFY DM
        WHERE DM.PERSON_ID         = W_PERSON_ID
          AND DM.WORK_DATE         = V_WORK_DATE
          AND DM.IO_FLAG           = W_IO_FLAG
          ;
      ELSIF NVL(P_IO_TIME, V_SYSDATE) = NVL(P_MODIFY_TIME, V_SYSDATE) 
          AND NVL(P_IO_TIME1, V_SYSDATE) = NVL(P_MODIFY_TIME1, V_SYSDATE) THEN
        V_MODIFY_IO_YN := 'N';
      ELSE
        -- 출근시간 저장.	
        UPDATE HRD_DAY_MODIFY DM
          SET DM.MODIFY_TIME                      = P_MODIFY_TIME
            , DM.MODIFY_TIME1                     = P_MODIFY_TIME1
            , DM.MODIFY_ID                        = P_MODIFY_ID
            , DM.DESCRIPTION                      = P_DESCRIPTION
            , DM.LAST_UPDATE_DATE                 = V_SYSDATE
            , DM.LAST_UPDATED_BY                  = P_USER_ID
        WHERE DM.PERSON_ID                        = W_PERSON_ID
          AND DM.WORK_DATE                        = V_WORK_DATE
          AND DM.IO_FLAG                          = W_IO_FLAG
        ;
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
        END IF;
        V_MODIFY_IO_YN := 'Y';
      END IF;
      
			UPDATE HRD_DAY_INTERFACE DI
		    SET DI.DUTY_ID                          = P_DUTY_ID
				  , DI.MODIFY_IN_YN                     = V_MODIFY_IO_YN
					, DI.APPROVED_YN                      = DECODE(V_MODIFY_IO_YN, 'Y', 
                                                    DECODE(V_CONNECT_LEVEL, 'C', 'Y', 
                                                      DECODE(W_IO_FLAG, '1', 'N', DI.APPROVED_YN)), 'N')
					, DI.APPROVED_DATE                    = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
					, DI.APPROVED_PERSON_ID               = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_CONNECT_PERSON_ID, NULL), NULL)
          , DI.APPROVED_OUT_YN                  = DECODE(V_MODIFY_IO_YN, 'Y', 
                                                    DECODE(V_CONNECT_LEVEL, 'C', 'Y', 
                                                      DECODE(W_IO_FLAG, '2', 'N', DI.APPROVED_YN)), 'N')
					, DI.APPROVED_OUT_DATE                = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
					, DI.APPROVED_OUT_PERSON_ID           = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_CONNECT_PERSON_ID, NULL), NULL)
					, DI.APPROVE_STATUS                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', 'C', 'N'), 'N')
          , DI.CONFIRMED_YN                     = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', 'Y', 'N'), 'N')
          , DI.CONFIRMED_DATE                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
          , DI.CONFIRMED_PERSON_ID              = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_CONNECT_PERSON_ID, NULL), NULL)
          , DI.EMAIL_STATUS                     = 'N'
			WHERE DI.PERSON_ID                        = W_PERSON_ID
				AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
				;
-----------------------------------------------------------------------------------------			
		ELSIF W_IO_FLAG = '2' THEN
/*DBMS_OUTPUT.PUT_LINE('P_IO_TIME : ' || TO_CHAR(P_IO_TIME, 'YYYY-MM-DD HH24:MI:SS') 
                     || ', P_IO_TIME1 : ' || TO_CHAR(P_IO_TIME1, 'YYYY-MM-DD HH24:MI:SS') 
										 || ', P_MODIFY_TIME : ' || TO_CHAR(P_MODIFY_TIME, 'YYYY-MM-DD HH24:MI:SS') 
                     || ', P_MODIFY_TIME : ' || TO_CHAR(P_MODIFY_TIME1, 'YYYY-MM-DD HH24:MI:SS'));*/
			IF P_MODIFY_TIME IS NULL AND P_MODIFY_TIME1 IS NULL AND P_MODIFY_ID IS NULL THEN
			  V_MODIFY_IO_YN := 'N';
				-- 기존자료 삭제.
				DELETE FROM HRD_DAY_MODIFY DM
				WHERE DM.PERSON_ID         = W_PERSON_ID
				  AND DM.WORK_DATE         = V_WORK_DATE
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
				-- 퇴근시간 저장.	
        UPDATE HRD_DAY_MODIFY DM
          SET DM.MODIFY_TIME                    = P_MODIFY_TIME
            , DM.MODIFY_TIME1                   = P_MODIFY_TIME1
            , DM.MODIFY_ID                      = P_MODIFY_ID
            , DM.DESCRIPTION                    = P_DESCRIPTION
            , DM.LAST_UPDATE_DATE               = V_SYSDATE
            , DM.LAST_UPDATED_BY                = P_USER_ID
        WHERE DM.PERSON_ID                      = W_PERSON_ID
          AND DM.WORK_DATE                      = V_WORK_DATE
          AND DM.IO_FLAG                        = W_IO_FLAG
				;
				IF (SQL%NOTFOUND)THEN
				-- 기존 데이터 없음 --> INSERT.
					INSERT INTO HRD_DAY_MODIFY
					(PERSON_ID, WORK_DATE, IO_FLAG
					, MODIFY_TIME, MODIFY_TIME1, MODIFY_ID
					, DESCRIPTION
					, CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY				
					) VALUES
					( W_PERSON_ID, V_WORK_DATE, W_IO_FLAG
					, P_MODIFY_TIME, P_MODIFY_TIME1, P_MODIFY_ID
					, P_DESCRIPTION
					, V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID				
					);
				END IF;
        V_MODIFY_IO_YN := 'Y';
			END IF;
			-- 수정 FLAG.
			IF P_LEAVE_ID IS NOT NULL OR P_LEAVE_TIME_CODE IS NOT NULL THEN
			  V_MODIFY_YN := 'Y';
			END IF;
			
			UPDATE HRD_DAY_INTERFACE DI
				SET DI.CLOSE_TIME                       = NVL(DI.CLOSE_TIME, V_MODIFY_TIME)
					, DI.CLOSE_TIME1                      = DECODE(DI.CLOSE_TIME, NULL, DI.CLOSE_TIME1, V_MODIFY_TIME)
          , DI.NEXT_DAY_YN                      = P_NEXT_DAY_YN
          , DI.DANGJIK_YN                       = P_DANGJIK_YN
          , DI.ALL_NIGHT_YN                     = P_ALL_NIGHT_YN
					, DI.LEAVE_ID                         = P_LEAVE_ID
					, DI.LEAVE_TIME_CODE                  = P_LEAVE_TIME_CODE
					, DI.MODIFY_YN                        = V_MODIFY_YN
					, DI.MODIFY_OUT_YN                    = V_MODIFY_IO_YN
					, DI.APPROVED_YN                      = DECODE(V_MODIFY_IO_YN, 'Y', 
                                                    DECODE(V_CONNECT_LEVEL, 'C', 'Y', 
                                                      DECODE(W_IO_FLAG, '1', 'N', DI.APPROVED_YN)), 'N')
					, DI.APPROVED_DATE                    = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
					, DI.APPROVED_PERSON_ID               = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_CONNECT_PERSON_ID, NULL), NULL)
          , DI.APPROVED_OUT_YN                  = DECODE(V_MODIFY_IO_YN, 'Y', 
                                                    DECODE(V_CONNECT_LEVEL, 'C', 'Y', 
                                                      DECODE(W_IO_FLAG, '2', 'N', DI.APPROVED_YN)), 'N')
					, DI.APPROVED_OUT_DATE                = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
					, DI.APPROVED_OUT_PERSON_ID           = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_CONNECT_PERSON_ID, NULL), NULL)
					, DI.APPROVE_STATUS                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', 'C', 'N'), 'N')
          , DI.CONFIRMED_YN                     = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', 'Y', 'N'), 'N')
          , DI.CONFIRMED_DATE                   = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_SYSDATE, NULL), NULL)
          , DI.CONFIRMED_PERSON_ID              = DECODE(V_MODIFY_IO_YN, 'Y', DECODE(V_CONNECT_LEVEL, 'C', V_CONNECT_PERSON_ID, NULL), NULL)
          , DI.EMAIL_STATUS                     = 'N' 
					, DI.DESCRIPTION                      = P_DESCRIPTION
					, DI.LAST_UPDATE_DATE                 = V_SYSDATE
					, DI.LAST_UPDATED_BY                  = P_USER_ID
			WHERE DI.PERSON_ID                        = W_PERSON_ID
				AND DI.WORK_DATE                        = W_WORK_DATE
				AND DI.SOB_ID                           = W_SOB_ID
				AND DI.ORG_ID                           = W_ORG_ID
		  ;
		END IF;
  EXCEPTION 
    WHEN ERRNUMS.Invalid_Modify THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Invalid_Modify_Code, ERRNUMS.Invalid_Modify_DESC);
    WHEN ERRNUMS.Duty_Not_Found THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Duty_Not_Found_Code, ERRNUMS.Duty_Not_Found_Desc);
  END UPDATE_DAY_INTERFACE;
  
-- DAY LEAVE CLOSE PROCESS GO.
  PROCEDURE DATA_CLOSE_PROC
            ( W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                 HRD_DAY_LEAVE.CREATION_DATE%TYPE;
    V_CLOSE_COUNT             NUMBER := 0;
    V_MESSAGE                 VARCHAR2(3000);
  BEGIN
    O_STATUS := 'F';
    V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
    
    -- 잔업 미계산자 체크 --
    BEGIN
      SELECT MAX(PM.PERSON_NUM) || -- as PERSON_NUM
             MAX(PM.NAME) || 
             MIN(DL.WORK_DATE) AS MESSAGE
        INTO V_MESSAGE
        FROM HRD_DAY_LEAVE     DL       
           , HRM_PERSON_MASTER PM
          WHERE DL.PERSON_ID                = PM.PERSON_ID
            AND DL.WORK_DATE                BETWEEN W_START_DATE AND W_END_DATE
            AND DL.PERSON_ID                = NVL(W_PERSON_ID, DL.PERSON_ID)
            AND DL.WORK_CORP_ID             = W_CORP_ID
            AND DL.SOB_ID                   = W_SOB_ID
            AND DL.ORG_ID                   = W_ORG_ID
            AND DL.CLOSED_YN                = 'N'
            AND EXISTS 
                  ( SELECT 'X'
                      FROM HRM_PERSON_MASTER PM
                         , ( SELECT HL.PERSON_ID
                                  , HL.FLOOR_ID
                                  , HL.JOB_CATEGORY_ID 
                                  , JC.JOB_CATEGORY_CODE
                               FROM HRM_HISTORY_LINE HL
                                  , HRM_JOB_CATEGORY_CODE_V JC
                              WHERE HL.JOB_CATEGORY_ID  = JC.JOB_CATEGORY_ID 
                                AND HL.HISTORY_LINE_ID  IN 
                                      ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                           FROM HRM_HISTORY_LINE S_HL
                                         WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                           AND S_HL.PERSON_ID              = HL.PERSON_ID
                                         GROUP BY S_HL.PERSON_ID
                                       )     
                           ) T1
                    WHERE PM.PERSON_ID        = T1.PERSON_ID  
                      AND PM.PERSON_ID        = DL.PERSON_ID
                      AND ((W_PERSON_ID       IS NULL 
                        AND 1                 = 1)
                      OR   (W_PERSON_ID       IS NOT NULL
                        AND PM.PERSON_ID      = W_PERSON_ID))
                      AND ((W_FLOOR_ID        IS NULL
                        AND 1                 = 1)
                      OR   (W_FLOOR_ID        IS NOT NULL
                        AND T1.FLOOR_ID       = W_FLOOR_ID)) 
                      AND ((W_JOB_CATEGORY_ID IS NULL
                        AND 1                 = 1)
                      OR   (W_JOB_CATEGORY_ID IS NOT NULL
                        AND T1.JOB_CATEGORY_ID= W_JOB_CATEGORY_ID)) 
                      AND T1.JOB_CATEGORY_CODE= '20'  -- 생산직만. 
                          )
           AND NOT EXISTS
                 ( SELECT 'X'
                     FROM HRD_DAY_LEAVE_OT DLO
                    WHERE DLO.DAY_LEAVE_ID    = DL.DAY_LEAVE_ID       
                      AND DLO.WORK_DATE       BETWEEN W_START_DATE AND W_END_DATE
                 ) 
           ;
    EXCEPTION WHEN OTHERS THEN
      V_MESSAGE := NULL;
    END;
    IF V_MESSAGE IS NOT NULL THEN
      O_STATUS := 'F';
      O_MESSAGE := V_MESSAGE || ' ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10495');
      RETURN;
    END IF;
    /*BEGIN
      SELECT NVL(SUM(DECODE(DL.CLOSED_YN, 'Y', 1, 0)), 0) AS CLOSE_COUNT
         INTO V_CLOSE_COUNT
         FROM HRD_DAY_LEAVE DL
       WHERE DL.WORK_DATE                BETWEEN W_START_DATE AND W_END_DATE
            AND DL.PERSON_ID                = NVL(W_PERSON_ID, DL.PERSON_ID)
            AND DL.WORK_CORP_ID             = W_CORP_ID
            AND DL.SOB_ID                   = W_SOB_ID
            AND DL.ORG_ID                   = W_ORG_ID
            AND EXISTS 
                  ( SELECT 'X'
                     FROM HRM_HISTORY_LINE HL
                      , HRM_PERSON_MASTER PM
                    WHERE HL.PERSON_ID        = PM.PERSON_ID
                     AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                  WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                  GROUP BY S_HL.PERSON_ID
                                                 )
                     AND PM.PERSON_ID         = DL.PERSON_ID
                     AND PM.CORP_ID           = DL.CORP_ID
                     AND PM.SOB_ID            = DL.SOB_ID
                     AND PM.ORG_ID            = DL.ORG_ID
                     AND HL.FLOOR_ID          = NVL(W_FLOOR_ID, HL.FLOOR_ID)
                     AND HL.JOB_CATEGORY_ID   = NVL(W_JOB_CATEGORY_ID, HL.JOB_CATEGORY_ID)
                   )
           ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSE_COUNT := 0;
    END;
    IF V_CLOSE_COUNT > 0 THEN
      O_MESSAGE := ERRNUMS.Data_closed_Desc;
      RETURN;
    END IF;*/

    UPDATE HRD_DAY_LEAVE DL
        SET DL.CLOSED_YN             = 'Y'
          , DL.CLOSED_DATE           = V_SYSDATE
          , DL.CLOSED_PERSON_ID      = W_CONNECT_PERSON_ID
    WHERE DL.WORK_DATE                BETWEEN W_START_DATE AND W_END_DATE
      AND DL.PERSON_ID                = NVL(W_PERSON_ID, DL.PERSON_ID)
      AND DL.WORK_CORP_ID             = W_CORP_ID
      AND DL.SOB_ID                   = W_SOB_ID
      AND DL.ORG_ID                   = W_ORG_ID
      AND DL.CLOSED_YN                = 'N'
      AND EXISTS 
            ( SELECT 'X'
                FROM HRM_PERSON_MASTER PM
                   , ( SELECT HL.PERSON_ID
                            , HL.FLOOR_ID
                            , HL.JOB_CATEGORY_ID 
                         FROM HRM_HISTORY_LINE HL
                        WHERE HL.HISTORY_LINE_ID  
                                IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                       FROM HRM_HISTORY_LINE S_HL
                                     WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                                     GROUP BY S_HL.PERSON_ID
                                   )     
                     ) T1
              WHERE PM.PERSON_ID        = T1.PERSON_ID  
                AND PM.PERSON_ID        = DL.PERSON_ID
                AND T1.FLOOR_ID         = NVL(W_FLOOR_ID, T1.FLOOR_ID)
                AND T1.JOB_CATEGORY_ID  = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
                    )
     ;
     O_STATUS := 'S';
     O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10024', NULL);
  END DATA_CLOSE_PROC;

-- DAY LEAVE CLOSE CANCEL GO.
  PROCEDURE DATA_CLOSE_CANCEL
            ( W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_JOB_CATEGORY_ID                   IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE            HRD_DAY_LEAVE.CREATION_DATE%TYPE := GET_LOCAL_DATE(W_SOB_ID);
  BEGIN
    O_STATUS := 'F';
    UPDATE HRD_DAY_LEAVE DL
    SET DL.CLOSED_YN             = 'N'
      , DL.CLOSED_DATE           = NULL
      , DL.CLOSED_PERSON_ID      = NULL
    WHERE DL.WORK_DATE           BETWEEN W_START_DATE AND W_END_DATE
      AND DL.PERSON_ID           = NVL(W_PERSON_ID, DL.PERSON_ID)
      AND DL.WORK_CORP_ID        = W_CORP_ID
      AND DL.SOB_ID              = W_SOB_ID
      AND DL.ORG_ID              = W_ORG_ID
      AND DL.CLOSED_YN           = 'Y'
      AND EXISTS ( SELECT 'X'
             FROM HRM_HISTORY_LINE HL
              , HRM_PERSON_MASTER PM
            WHERE HL.PERSON_ID        = PM.PERSON_ID
             AND HL.HISTORY_LINE_ID  
                   IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                          FROM HRM_HISTORY_LINE S_HL
                        WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                          AND S_HL.PERSON_ID              = HL.PERSON_ID
                        GROUP BY S_HL.PERSON_ID
                       )
             AND PM.PERSON_ID         = DL.PERSON_ID
             AND HL.FLOOR_ID          = NVL(W_FLOOR_ID, HL.FLOOR_ID)
             AND HL.JOB_CATEGORY_ID   = NVL(W_JOB_CATEGORY_ID, HL.JOB_CATEGORY_ID)
                    )
    ;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10025', NULL);
  END DATA_CLOSE_CANCEL;

-- DAY LEAVE DATA STATUS --> RECORD COUNT.
  PROCEDURE DATA_CLOSE_YN_COUNT
           (  W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CAP_CHECK_YN                      IN VARCHAR2
            , W_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
            , W_WORK_TYPE_ID                      IN HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
            , W_CLOSE_YN                          IN HRD_DAY_LEAVE.CLOSED_YN%TYPE
            , O_RECORD_COUNT                      OUT NUMBER
            )
  AS
    V_RECORD_COUNT                                NUMBER := 0;
    V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
  BEGIN
    -- 근태권한 설정.
    IF W_CAP_CHECK_YN = 'N' THEN
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    ELSIF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID => W_CORP_ID
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

   BEGIN
     -- 자료수 조회.
     SELECT COUNT(DL.PERSON_ID) AS CLOSE_COUNT
       INTO V_RECORD_COUNT
       FROM HRD_DAY_LEAVE DL
        , HRD_WORK_CALENDAR WC
        , (-- 시점 인사내역.
          SELECT HL.PERSON_ID
            , HL.DEPT_ID
            , HL.JOB_CATEGORY_ID
            , HL.FLOOR_ID
          FROM HRM_HISTORY_LINE HL
          WHERE HL.HISTORY_LINE_ID  
                  IN (SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                        FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                        AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                      )
          ) T1
      WHERE DL.PERSON_ID                            = WC.PERSON_ID
        AND DL.WORK_DATE                            = WC.WORK_DATE
        AND DL.SOB_ID                               = WC.SOB_ID
        AND DL.ORG_ID                               = WC.ORG_ID
        AND DL.PERSON_ID                            = T1.PERSON_ID
        AND DL.PERSON_ID                            = NVL(W_PERSON_ID, DL.PERSON_ID)
        AND DL.WORK_DATE                            = W_WORK_DATE
        AND DL.WORK_CORP_ID                         = W_CORP_ID
        AND DL.SOB_ID                               = W_SOB_ID
        AND DL.ORG_ID                               = W_ORG_ID
        AND T1.FLOOR_ID                             = NVL(W_FLOOR_ID, T1.FLOOR_ID)
        AND WC.WORK_TYPE_ID                         = NVL(W_WORK_TYPE_ID, WC.WORK_TYPE_ID)
        AND DL.CLOSED_YN                            = NVL(W_CLOSE_YN, DL.CLOSED_YN)
        AND EXISTS (SELECT 'X'
                       FROM HRD_DUTY_MANAGER DM
                    WHERE DM.CORP_ID              = DL.WORK_CORP_ID
                      AND DM.DUTY_CONTROL_ID      = T1.FLOOR_ID
                      AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, WC.WORK_TYPE_ID)
                      AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                      AND DM.START_DATE           <= DL.WORK_DATE
                      AND (DM.END_DATE IS NULL OR DM.END_DATE >= DL.WORK_DATE)
                      AND DM.SOB_ID               = DL.SOB_ID
                      AND DM.ORG_ID               = DL.ORG_ID
                    )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_RECORD_COUNT := 0;
    END;
    O_RECORD_COUNT := V_RECORD_COUNT;
 END DATA_CLOSE_YN_COUNT;

-- 일근태 마감 자료 조회.
  PROCEDURE SELECT_DAY_LEAVE_PERSON
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_HOLY_TYPE                         IN HRD_DAY_LEAVE.HOLY_TYPE%TYPE
            , W_DUTY_ID                           IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DL.PERSON_ID
          , DL.WORK_DATE
          , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
          , T2.FLOOR_NAME
          , T1.JOB_CATEGORY_NAME
          , DL.DUTY_ID
          , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
          , DL.HOLY_TYPE
          , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
          , DL.OPEN_TIME
          , DL.CLOSE_TIME
          , DL.OPEN_TIME1
          , DL.CLOSE_TIME1
          , DL.NEXT_DAY_YN
          , DL.DANGJIK_YN
          , DL.ALL_NIGHT_YN
          , DL.LEAVE_TIME
          , DL.LATE_TIME
          , DL.REST_TIME
          , DL.OVER_TIME
          , DL.HOLIDAY_TIME
          , DL.NIGHT_TIME
          , DL.NIGHT_BONUS_TIME
          , DL.HOLIDAY_CHECK
          , DL.CLOSED_YN
          , DL.CLOSED_PERSON_ID
          , HRM_PERSON_MASTER_G.NAME_F(DL.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
          , DL.WORK_TYPE_GROUP
          , DL.PL_OPEN_TIME
          , DL.PL_CLOSE_TIME
          , DL.PL_BEFORE_OT_START
          , DL.PL_BEFORE_OT_END
          , DL.PL_AFTER_OT_START
          , DL.PL_AFTER_OT_END
          , DL.PL_LUNCH_YN
          , DL.PL_DINNER_YN
          , DL.PL_MIDNIGHT_YN
          , T1.ORI_JOIN_DATE
          , T1.RETIRE_DATE
          , T1.PERSON_NUM
          , T1.NAME
          , DL.WORK_CORP_ID AS CORP_ID
          , DL.DAY_LEAVE_ID
    FROM HRD_DAY_LEAVE_V1 DL
      , (-- 시점 인사내역.
        SELECT HL.PERSON_ID
            , PM.NAME
            , PM.PERSON_NUM
            , PM.DISPLAY_NAME
            , HL.DEPT_ID
            , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
            , HL.POST_ID
            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
            , HL.JOB_CATEGORY_ID
            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
            , HL.FLOOR_ID
            , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
            , PM.CORP_ID
            , PM.WORK_CORP_ID
            , PM.ORI_JOIN_DATE
            , PM.JOIN_DATE
            , PM.RETIRE_DATE
            , PM.SOB_ID
            , PM.ORG_ID
          FROM HRM_HISTORY_LINE HL
            , HRM_PERSON_MASTER PM
        WHERE HL.PERSON_ID        = PM.PERSON_ID
          AND HL.HISTORY_LINE_ID  
              IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                     FROM HRM_HISTORY_LINE S_HL
                   WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                     AND S_HL.PERSON_ID              = HL.PERSON_ID
                   GROUP BY S_HL.PERSON_ID
                  )
         ) T1
       , (-- 시점 인사내역.
          SELECT PH.PERSON_ID
               , PH.FLOOR_ID
               , PH.SOB_ID
               , PH.ORG_ID
               , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
            FROM HRD_PERSON_HISTORY        PH
           WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
             AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
         ) T2
    WHERE DL.PERSON_ID              = T1.PERSON_ID
      AND DL.WORK_CORP_ID           = T1.WORK_CORP_ID
      AND DL.SOB_ID                 = T1.SOB_ID
      AND DL.ORG_ID                 = T1.ORG_ID
      AND DL.PERSON_ID              = T2.PERSON_ID
      AND DL.SOB_ID                 = T2.SOB_ID
      AND DL.ORG_ID                 = T2.ORG_ID
      AND DL.WORK_DATE              BETWEEN CASE 
                                              WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                              ELSE W_START_DATE
                                            END
                                    AND CASE 
                                          WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                          WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                          ELSE W_END_DATE
                                        END
      AND DL.PERSON_ID              = W_PERSON_ID
      AND DL.WORK_CORP_ID           = W_CORP_ID
      AND DL.SOB_ID                 = W_SOB_ID
      AND DL.ORG_ID                 = W_ORG_ID
      --    AND DL.CLOSED_YN              = DECODE(W_CLOSE_YN, 'A', DL.CLOSED_YN, NVL(W_CLOSE_YN, DL.CLOSED_YN))
      AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
      AND DL.DUTY_ID                = NVL(W_DUTY_ID, DL.DUTY_ID)
    ORDER BY DL.WORK_DATE, DL.HOLY_TYPE, DL.WORK_TYPE_ID, T2.FLOOR_ID, T1.PERSON_NUM
      ;
  END SELECT_DAY_LEAVE_PERSON;



-- [2011-11-02]
   PROCEDURE SELECT_DAY_LEAVE_USER
           ( P_CURSOR1       OUT TYPES.TCURSOR
           , W_SOB_ID        IN  HRD_DAY_LEAVE.SOB_ID%TYPE
           , W_ORG_ID        IN  HRD_DAY_LEAVE.ORG_ID%TYPE
           , W_CORP_ID       IN  HRD_DAY_LEAVE.CORP_ID%TYPE
           , W_START_DATE    IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_END_DATE      IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_HOLY_TYPE     IN  HRD_DAY_LEAVE.HOLY_TYPE%TYPE
           , W_DUTY_ID       IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID     IN  HRD_DAY_LEAVE.PERSON_ID%TYPE
           , W_SORT          IN  VARCHAR2
           )

   AS

   BEGIN

             IF NVL(W_SORT, 'A') = 'A' THEN
                OPEN P_CURSOR1 FOR
                SELECT DL.PERSON_ID
                     , DL.WORK_DATE
                     , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
                     , T2.FLOOR_NAME
                     , T2.WORK_TYPE_NAME
                     , T1.JOB_CATEGORY_NAME
                     , DL.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
                     , DL.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
                     , DL.OPEN_TIME
                     , DL.CLOSE_TIME
                     , DL.OPEN_TIME1
                     , DL.CLOSE_TIME1
                     , DL.NEXT_DAY_YN
                     , DL.DANGJIK_YN
                     , DL.ALL_NIGHT_YN
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.HOLIDAY_CHECK
                     , DL.CLOSED_YN
                     , DL.CLOSED_PERSON_ID
                     , HRM_PERSON_MASTER_G.NAME_F(DL.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
                     , DL.PL_LUNCH_YN
                     , DL.PL_DINNER_YN
                     , DL.PL_MIDNIGHT_YN
                     , DL.PL_AFTER_OT_START
                     , DL.PL_AFTER_OT_END
                     , DL.PL_BEFORE_OT_START
                     , DL.PL_BEFORE_OT_END
                     , DL.PL_OPEN_TIME
                     , DL.PL_CLOSE_TIME
                     , T1.ORI_JOIN_DATE
                     , T1.RETIRE_DATE
                     , T1.PERSON_NUMBER
                     , T1.PERSON_NAME
                     , DL.WORK_TYPE_GROUP
                     , DL.WORK_CORP_ID AS CORP_ID
                     , DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                     ,(-- 시점 인사내역.
                       SELECT HL.PERSON_ID
                            , PM.NAME AS PERSON_NAME
                            , PM.PERSON_NUM AS PERSON_NUMBER
                            , PM.DISPLAY_NAME
                            , HL.POST_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                            , HL.JOB_CATEGORY_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                            , PM.CORP_ID
                            , PM.WORK_CORP_ID
                            , PM.ORI_JOIN_DATE
                            , PM.JOIN_DATE
                            , PM.RETIRE_DATE
                            , PM.SOB_ID
                            , PM.ORG_ID
                         FROM HRM_HISTORY_LINE   HL
                            , HRM_PERSON_MASTER  PM
                        WHERE HL.PERSON_ID    =  PM.PERSON_ID
                          AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE      S_HL
                                                        WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                          AND S_HL.CHARGE_DATE  <=  W_END_DATE
                                                     GROUP BY S_HL.PERSON_ID
                                                     )
                      ) T1
                    , (-- 시점 인사내역.
                       SELECT PH.PERSON_ID
                            , PH.FLOOR_ID
                            , PH.WORK_TYPE_ID
                            , PH.DEPT_ID
                            , PH.SOB_ID
                            , PH.ORG_ID
                            , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)       AS FLOOR_NAME
                            , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)   AS WORK_TYPE_NAME
                            , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID) AS DEPT_NAME
                         FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                      ) T2
                 WHERE DL.PERSON_ID      =  T1.PERSON_ID
                   AND DL.WORK_CORP_ID   =  T1.WORK_CORP_ID
                   AND DL.SOB_ID         =  T1.SOB_ID
                   AND DL.ORG_ID         =  T1.ORG_ID
                   AND DL.PERSON_ID      =  T2.PERSON_ID
                   AND DL.SOB_ID         =  T2.SOB_ID
                   AND DL.ORG_ID         =  T2.ORG_ID
                   AND DL.WORK_DATE      BETWEEN CASE 
                                                    WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                    ELSE W_START_DATE
                                                  END
                                          AND CASE 
                                                WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                                WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                ELSE W_END_DATE
                                              END
                   AND DL.PERSON_ID      =  W_PERSON_ID
                   AND DL.WORK_CORP_ID   =  W_CORP_ID
                   AND DL.SOB_ID         =  W_SOB_ID
                   AND DL.ORG_ID         =  W_ORG_ID
                   AND DL.HOLY_TYPE      =  NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
                   AND DL.DUTY_ID        =  NVL(W_DUTY_ID, DL.DUTY_ID)
              ORDER BY DL.WORK_DATE
                     ;
             ELSIF NVL(W_SORT, 'D') = 'D' THEN
                OPEN P_CURSOR1 FOR
                SELECT DL.PERSON_ID
                     , DL.WORK_DATE
                     , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
                     , T2.FLOOR_NAME
                     , T2.WORK_TYPE_NAME
                     , T1.JOB_CATEGORY_NAME
                     , DL.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
                     , DL.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
                     , DL.OPEN_TIME
                     , DL.CLOSE_TIME
                     , DL.OPEN_TIME1
                     , DL.CLOSE_TIME1
                     , DL.NEXT_DAY_YN
                     , DL.DANGJIK_YN
                     , DL.ALL_NIGHT_YN
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.HOLIDAY_CHECK
                     , DL.CLOSED_YN
                     , DL.CLOSED_PERSON_ID
                     , HRM_PERSON_MASTER_G.NAME_F(DL.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
                     , DL.PL_LUNCH_YN
                     , DL.PL_DINNER_YN
                     , DL.PL_MIDNIGHT_YN
                     , DL.PL_AFTER_OT_START
                     , DL.PL_AFTER_OT_END
                     , DL.PL_BEFORE_OT_START
                     , DL.PL_BEFORE_OT_END
                     , DL.PL_OPEN_TIME
                     , DL.PL_CLOSE_TIME
                     , T1.ORI_JOIN_DATE
                     , T1.RETIRE_DATE
                     , T1.PERSON_NUMBER
                     , T1.PERSON_NAME
                     , DL.WORK_TYPE_GROUP
                     , DL.WORK_CORP_ID AS CORP_ID
                     , DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                     ,(-- 시점 인사내역.
                       SELECT HL.PERSON_ID
                            , PM.NAME AS PERSON_NAME
                            , PM.PERSON_NUM AS PERSON_NUMBER
                            , PM.DISPLAY_NAME
                            , HL.POST_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                            , HL.JOB_CATEGORY_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                            , PM.CORP_ID
                            , PM.WORK_CORP_ID
                            , PM.ORI_JOIN_DATE
                            , PM.JOIN_DATE
                            , PM.RETIRE_DATE
                            , PM.SOB_ID
                            , PM.ORG_ID
                         FROM HRM_HISTORY_LINE   HL
                            , HRM_PERSON_MASTER  PM
                        WHERE HL.PERSON_ID    =  PM.PERSON_ID
                          AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE      S_HL
                                                        WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                          AND S_HL.CHARGE_DATE  <=  W_END_DATE
                                                     GROUP BY S_HL.PERSON_ID
                                                     )
                      ) T1
                    , (-- 시점 인사내역.
                       SELECT PH.PERSON_ID
                            , PH.FLOOR_ID
                            , PH.WORK_TYPE_ID
                            , PH.DEPT_ID
                            , PH.SOB_ID
                            , PH.ORG_ID
                            , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)       AS FLOOR_NAME
                            , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)   AS WORK_TYPE_NAME
                            , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID) AS DEPT_NAME
                         FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                      ) T2
                 WHERE DL.PERSON_ID      =  T1.PERSON_ID
                   AND DL.WORK_CORP_ID   =  T1.WORK_CORP_ID
                   AND DL.SOB_ID         =  T1.SOB_ID
                   AND DL.ORG_ID         =  T1.ORG_ID
                   AND DL.PERSON_ID      =  T2.PERSON_ID
                   AND DL.SOB_ID         =  T2.SOB_ID
                   AND DL.ORG_ID         =  T2.ORG_ID
                   AND DL.WORK_DATE      BETWEEN CASE 
                                                    WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                    ELSE W_START_DATE
                                                  END
                                          AND CASE 
                                                WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                                WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                ELSE W_END_DATE
                                              END
                   AND DL.PERSON_ID      =  W_PERSON_ID
                   AND DL.WORK_CORP_ID   =  W_CORP_ID
                   AND DL.SOB_ID         =  W_SOB_ID
                   AND DL.ORG_ID         =  W_ORG_ID
                   AND DL.HOLY_TYPE      =  NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
                   AND DL.DUTY_ID        =  NVL(W_DUTY_ID, DL.DUTY_ID)
              ORDER BY HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID)
                     , DL.WORK_DATE
                     ;
             ELSIF NVL(W_SORT, 'H') = 'H' THEN
                OPEN P_CURSOR1 FOR
                SELECT DL.PERSON_ID
                     , DL.WORK_DATE
                     , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
                     , T2.FLOOR_NAME
                     , T2.WORK_TYPE_NAME
                     , T1.JOB_CATEGORY_NAME
                     , DL.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
                     , DL.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
                     , DL.OPEN_TIME
                     , DL.CLOSE_TIME
                     , DL.OPEN_TIME1
                     , DL.CLOSE_TIME1
                     , DL.NEXT_DAY_YN
                     , DL.DANGJIK_YN
                     , DL.ALL_NIGHT_YN
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.HOLIDAY_CHECK
                     , DL.CLOSED_YN
                     , DL.CLOSED_PERSON_ID
                     , HRM_PERSON_MASTER_G.NAME_F(DL.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
                     , DL.PL_LUNCH_YN
                     , DL.PL_DINNER_YN
                     , DL.PL_MIDNIGHT_YN
                     , DL.PL_AFTER_OT_START
                     , DL.PL_AFTER_OT_END
                     , DL.PL_BEFORE_OT_START
                     , DL.PL_BEFORE_OT_END
                     , DL.PL_OPEN_TIME
                     , DL.PL_CLOSE_TIME
                     , T1.ORI_JOIN_DATE
                     , T1.RETIRE_DATE
                     , T1.PERSON_NUMBER
                     , T1.PERSON_NAME
                     , DL.WORK_TYPE_GROUP
                     , DL.WORK_CORP_ID AS CORP_ID
                     , DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                     ,(-- 시점 인사내역.
                       SELECT HL.PERSON_ID
                            , PM.NAME AS PERSON_NAME
                            , PM.PERSON_NUM AS PERSON_NUMBER
                            , PM.DISPLAY_NAME
                            , HL.POST_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                            , HL.JOB_CATEGORY_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                            , PM.CORP_ID
                            , PM.WORK_CORP_ID
                            , PM.ORI_JOIN_DATE
                            , PM.JOIN_DATE
                            , PM.RETIRE_DATE
                            , PM.SOB_ID
                            , PM.ORG_ID
                         FROM HRM_HISTORY_LINE   HL
                            , HRM_PERSON_MASTER  PM
                        WHERE HL.PERSON_ID    =  PM.PERSON_ID
                          AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE      S_HL
                                                        WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                          AND S_HL.CHARGE_DATE  <=  W_END_DATE
                                                     GROUP BY S_HL.PERSON_ID
                                                     )
                      ) T1
                    , (-- 시점 인사내역.
                       SELECT PH.PERSON_ID
                            , PH.FLOOR_ID
                            , PH.WORK_TYPE_ID
                            , PH.DEPT_ID
                            , PH.SOB_ID
                            , PH.ORG_ID
                            , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)       AS FLOOR_NAME
                            , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)   AS WORK_TYPE_NAME
                            , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID) AS DEPT_NAME
                         FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                      ) T2
                 WHERE DL.PERSON_ID      =  T1.PERSON_ID
                   AND DL.WORK_CORP_ID   =  T1.WORK_CORP_ID
                   AND DL.SOB_ID         =  T1.SOB_ID
                   AND DL.ORG_ID         =  T1.ORG_ID
                   AND DL.PERSON_ID      =  T2.PERSON_ID
                   AND DL.SOB_ID         =  T2.SOB_ID
                   AND DL.ORG_ID         =  T2.ORG_ID
                   AND DL.WORK_DATE      BETWEEN CASE 
                                                    WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                    ELSE W_START_DATE
                                                  END
                                          AND CASE 
                                                WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                                WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                ELSE W_END_DATE
                                              END
                   AND DL.PERSON_ID      =  W_PERSON_ID
                   AND DL.WORK_CORP_ID   =  W_CORP_ID
                   AND DL.SOB_ID         =  W_SOB_ID
                   AND DL.ORG_ID         =  W_ORG_ID
                   AND DL.HOLY_TYPE      =  NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
                   AND DL.DUTY_ID        =  NVL(W_DUTY_ID, DL.DUTY_ID)
              ORDER BY DL.HOLY_TYPE
                     , DL.WORK_DATE
                     ;
             ELSIF NVL(W_SORT, 'O') = 'O' THEN
                OPEN P_CURSOR1 FOR
                SELECT DL.PERSON_ID
                     , DL.WORK_DATE
                     , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
                     , T2.FLOOR_NAME
                     , T2.WORK_TYPE_NAME
                     , T1.JOB_CATEGORY_NAME
                     , DL.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
                     , DL.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
                     , DL.OPEN_TIME
                     , DL.CLOSE_TIME
                     , DL.OPEN_TIME1
                     , DL.CLOSE_TIME1
                     , DL.NEXT_DAY_YN
                     , DL.DANGJIK_YN
                     , DL.ALL_NIGHT_YN
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.HOLIDAY_CHECK
                     , DL.CLOSED_YN
                     , DL.CLOSED_PERSON_ID
                     , HRM_PERSON_MASTER_G.NAME_F(DL.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
                     , DL.PL_LUNCH_YN
                     , DL.PL_DINNER_YN
                     , DL.PL_MIDNIGHT_YN
                     , DL.PL_AFTER_OT_START
                     , DL.PL_AFTER_OT_END
                     , DL.PL_BEFORE_OT_START
                     , DL.PL_BEFORE_OT_END
                     , DL.PL_OPEN_TIME
                     , DL.PL_CLOSE_TIME
                     , T1.ORI_JOIN_DATE
                     , T1.RETIRE_DATE
                     , T1.PERSON_NUMBER
                     , T1.PERSON_NAME
                     , DL.WORK_TYPE_GROUP
                     , DL.WORK_CORP_ID AS CORP_ID
                     , DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                     ,(-- 시점 인사내역.
                       SELECT HL.PERSON_ID
                            , PM.NAME AS PERSON_NAME
                            , PM.PERSON_NUM AS PERSON_NUMBER
                            , PM.DISPLAY_NAME
                            , HL.POST_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                            , HL.JOB_CATEGORY_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                            , PM.CORP_ID
                            , PM.WORK_CORP_ID
                            , PM.ORI_JOIN_DATE
                            , PM.JOIN_DATE
                            , PM.RETIRE_DATE
                            , PM.SOB_ID
                            , PM.ORG_ID
                         FROM HRM_HISTORY_LINE   HL
                            , HRM_PERSON_MASTER  PM
                        WHERE HL.PERSON_ID    =  PM.PERSON_ID
                          AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE      S_HL
                                                        WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                          AND S_HL.CHARGE_DATE  <=  W_END_DATE
                                                     GROUP BY S_HL.PERSON_ID
                                                     )
                      ) T1
                    , (-- 시점 인사내역.
                       SELECT PH.PERSON_ID
                            , PH.FLOOR_ID
                            , PH.WORK_TYPE_ID
                            , PH.DEPT_ID
                            , PH.SOB_ID
                            , PH.ORG_ID
                            , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)       AS FLOOR_NAME
                            , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)   AS WORK_TYPE_NAME
                            , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID) AS DEPT_NAME
                         FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                      ) T2
                 WHERE DL.PERSON_ID      =  T1.PERSON_ID
                   AND DL.WORK_CORP_ID   =  T1.WORK_CORP_ID
                   AND DL.SOB_ID         =  T1.SOB_ID
                   AND DL.ORG_ID         =  T1.ORG_ID
                   AND DL.PERSON_ID      =  T2.PERSON_ID
                   AND DL.SOB_ID         =  T2.SOB_ID
                   AND DL.ORG_ID         =  T2.ORG_ID
                   AND DL.WORK_DATE      BETWEEN CASE 
                                                    WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                    ELSE W_START_DATE
                                                  END
                                          AND CASE 
                                                WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                                WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                ELSE W_END_DATE
                                              END
                   AND DL.PERSON_ID      =  W_PERSON_ID
                   AND DL.WORK_CORP_ID   =  W_CORP_ID
                   AND DL.SOB_ID         =  W_SOB_ID
                   AND DL.ORG_ID         =  W_ORG_ID
                   AND DL.HOLY_TYPE      =  NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
                   AND DL.DUTY_ID        =  NVL(W_DUTY_ID, DL.DUTY_ID)
              ORDER BY TO_CHAR(DL.OPEN_TIME, 'HH24:MI')
                     , DL.WORK_DATE
                     ;
             ELSIF NVL(W_SORT, 'C') = 'C' THEN
                OPEN P_CURSOR1 FOR
                SELECT DL.PERSON_ID
                     , DL.WORK_DATE
                     , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
                     , T2.FLOOR_NAME
                     , T2.WORK_TYPE_NAME
                     , T1.JOB_CATEGORY_NAME
                     , DL.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
                     , DL.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
                     , DL.OPEN_TIME
                     , DL.CLOSE_TIME
                     , DL.OPEN_TIME1
                     , DL.CLOSE_TIME1
                     , DL.NEXT_DAY_YN
                     , DL.DANGJIK_YN
                     , DL.ALL_NIGHT_YN
                     , DL.LEAVE_TIME
                     , DL.LATE_TIME
                     , DL.REST_TIME
                     , DL.OVER_TIME
                     , DL.HOLIDAY_TIME
                     , DL.HOLIDAY_OT_TIME
                     , DL.NIGHT_TIME
                     , DL.NIGHT_BONUS_TIME
                     , DL.HOLIDAY_CHECK
                     , DL.CLOSED_YN
                     , DL.CLOSED_PERSON_ID
                     , HRM_PERSON_MASTER_G.NAME_F(DL.CLOSED_PERSON_ID) AS CLOSED_PERSON_NAME
                     , DL.PL_LUNCH_YN
                     , DL.PL_DINNER_YN
                     , DL.PL_MIDNIGHT_YN
                     , DL.PL_AFTER_OT_START
                     , DL.PL_AFTER_OT_END
                     , DL.PL_BEFORE_OT_START
                     , DL.PL_BEFORE_OT_END
                     , DL.PL_OPEN_TIME
                     , DL.PL_CLOSE_TIME
                     , T1.ORI_JOIN_DATE
                     , T1.RETIRE_DATE
                     , T1.PERSON_NUMBER
                     , T1.PERSON_NAME
                     , DL.WORK_TYPE_GROUP
                     , DL.WORK_CORP_ID AS CORP_ID
                     , DL.DAY_LEAVE_ID
                  FROM HRD_DAY_LEAVE_V1 DL
                     ,(-- 시점 인사내역.
                       SELECT HL.PERSON_ID
                            , PM.NAME AS PERSON_NAME
                            , PM.PERSON_NUM AS PERSON_NUMBER
                            , PM.DISPLAY_NAME
                            , HL.POST_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                            , HL.JOB_CATEGORY_ID
                            , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                            , PM.CORP_ID
                            , PM.WORK_CORP_ID
                            , PM.ORI_JOIN_DATE
                            , PM.JOIN_DATE
                            , PM.RETIRE_DATE
                            , PM.SOB_ID
                            , PM.ORG_ID
                         FROM HRM_HISTORY_LINE   HL
                            , HRM_PERSON_MASTER  PM
                        WHERE HL.PERSON_ID    =  PM.PERSON_ID
                          AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                         FROM HRM_HISTORY_LINE      S_HL
                                                        WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                          AND S_HL.CHARGE_DATE  <=  W_END_DATE
                                                     GROUP BY S_HL.PERSON_ID
                                                     )
                      ) T1
                    , (-- 시점 인사내역.
                       SELECT PH.PERSON_ID
                            , PH.FLOOR_ID
                            , PH.WORK_TYPE_ID
                            , PH.DEPT_ID
                            , PH.SOB_ID
                            , PH.ORG_ID
                            , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)       AS FLOOR_NAME
                            , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)   AS WORK_TYPE_NAME
                            , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID) AS DEPT_NAME
                         FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                      ) T2
                 WHERE DL.PERSON_ID      =  T1.PERSON_ID
                   AND DL.WORK_CORP_ID   =  T1.WORK_CORP_ID
                   AND DL.SOB_ID         =  T1.SOB_ID
                   AND DL.ORG_ID         =  T1.ORG_ID
                   AND DL.PERSON_ID      =  T2.PERSON_ID
                   AND DL.SOB_ID         =  T2.SOB_ID
                   AND DL.ORG_ID         =  T2.ORG_ID
                   AND DL.WORK_DATE      BETWEEN CASE 
                                                    WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                    ELSE W_START_DATE
                                                  END
                                          AND CASE 
                                                WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                                WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                ELSE W_END_DATE
                                              END
                   AND DL.PERSON_ID      =  W_PERSON_ID
                   AND DL.WORK_CORP_ID   =  W_CORP_ID
                   AND DL.SOB_ID         =  W_SOB_ID
                   AND DL.ORG_ID         =  W_ORG_ID
                   AND DL.HOLY_TYPE      =  NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
                   AND DL.DUTY_ID        =  NVL(W_DUTY_ID, DL.DUTY_ID)
              ORDER BY TO_CHAR(DL.CLOSE_TIME, 'HH24:MI')
                     , DL.WORK_DATE
                     ;
             END IF;

   END SELECT_DAY_LEAVE_USER;




-- DAY LEAVE SELECT[2011-11-14]
   PROCEDURE SELECT_DAY_LEAVE_DATA
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_CORP_ID            IN  HRD_DAY_LEAVE.CORP_ID%TYPE
           , W_START_DATE         IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_END_DATE           IN  HRD_DAY_LEAVE.WORK_DATE%TYPE
           , W_MODIFY_FLAG        IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
           , W_CLOSE_YN           IN  HRD_DAY_LEAVE.CLOSED_YN%TYPE
           , W_HOLY_TYPE          IN  HRD_DAY_LEAVE.HOLY_TYPE%TYPE
           , W_DUTY_ID            IN  HRM_COMMON.COMMON_ID%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_DEPT_ID            IN  HRM_DEPT_MASTER.DEPT_ID%TYPE
           , W_JOB_CATEGORY_ID    IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_DAY_LEAVE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_DAY_LEAVE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_DAY_LEAVE.ORG_ID%TYPE
           )

   AS

             V_CONNECT_PERSON_ID      HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

   BEGIN
             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                        , W_START_DATE  => W_START_DATE
                                        , W_END_DATE    => W_END_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT CASE
                        WHEN GROUPING(DL.WORK_DATE) = 1 THEN -10  -- 그룹핑 된 항목.
                        ELSE DL.PERSON_ID
                    END AS PERSON_ID
                  , NVL(DL.WORK_DATE, NULL) AS WORK_DATE
                  , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID) AS WORK_WEEK
                  , T2.FLOOR_NAME
                  , T1.JOB_CATEGORY_NAME
                  , CASE
                        WHEN GROUPING(DL.WORK_DATE) = 1 THEN EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10045', NULL)
                        ELSE T1.NAME
                    END AS NAME
                  , NVL(DL.DUTY_ID, NULL) AS DUTY_ID
                  , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID) AS DUTY_NAME
                  , DL.HOLY_TYPE
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID) AS HOLY_TYPE_NAME
                  , NVL(DL.OPEN_TIME, NULL)   AS OPEN_TIME
                  , NVL(DL.CLOSE_TIME, NULL)  AS CLOSE_TIME
                  , NVL(S_DI.MODIFY_BEFORE_DATETIME_OPEN, NULL)  AS MODIFY_BEFORE_DATETIME_OPEN
                  , NVL(S_DI.MODIFY_BEFORE_DATETIME_CLOSE, NULL) AS MODIFY_BEFORE_DATETIME_CLOSE
                  , NVL(DL.OPEN_TIME1, NULL)  AS OPEN_TIME1
                  , NVL(DL.CLOSE_TIME1, NULL) AS CLOSE_TIME1
                  , DL.NEXT_DAY_YN
                  , DL.DANGJIK_YN
                  , DL.ALL_NIGHT_YN
                  , SUM(DL.LEAVE_TIME) AS LEAVE_TIME
                  , SUM(DL.LATE_TIME) AS LATE_TIME
                  , SUM(DL.REST_TIME) AS REST_TIME
                  , SUM(DL.OVER_TIME) AS OVER_TIME
                  , SUM(DL.HOLIDAY_TIME) AS HOLIDAY_TIME
                  , SUM(DL.HOLIDAY_OT_TIME) AS HOLIDAY_OT_TIME
                  , SUM(DL.NIGHT_TIME) AS NIGHT_TIME
                  , SUM(DL.NIGHT_BONUS_TIME) AS NIGHT_BONUS_TIME
                  , DL.HOLIDAY_CHECK
                  , DL.CLOSED_YN
                  , NVL(DL.CLOSED_PERSON_ID, NULL) AS CLOSED_PERSON_ID
                  , DL.WORK_TYPE_GROUP
                  , NVL(DL.PL_OPEN_TIME, NULL)  AS PL_OPEN_TIME
                  , NVL(DL.PL_CLOSE_TIME, NULL) AS PL_CLOSE_TIME
                  , NVL(DL.PL_BEFORE_OT_START, NULL) AS PL_BEFORE_OT_START
                  , NVL(DL.PL_BEFORE_OT_END, NULL)   AS PL_BEFORE_OT_END
                  , NVL(DL.PL_AFTER_OT_START, NULL)  AS PL_AFTER_OT_START
                  , NVL(DL.PL_AFTER_OT_END, NULL)    AS PL_AFTER_OT_END
                  , DL.PL_LUNCH_YN
                  , DL.PL_DINNER_YN
                  , DL.PL_MIDNIGHT_YN
                  , DL.PL_BREAKFAST_YN
                  , T1.PERSON_NUM
                  , NVL(T1.ORI_JOIN_DATE, NULL) AS ORI_JOIN_DATE
                  , NVL(T1.RETIRE_DATE, NULL)   AS RETIRE_DATE
                  , NVL(DL.WORK_CORP_ID, NULL)  AS CORP_ID
                  , NVL(DL.DAY_LEAVE_ID, NULL)  AS DAY_LEAVE_ID
               FROM HRD_DAY_LEAVE_V1 DL
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , PM.NAME
                          , PM.PERSON_NUM
                          , PM.DISPLAY_NAME
                          , HL.DEPT_ID
                          , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
                          , HL.POST_ID
                          , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
                          , HL.JOB_CATEGORY_ID
                          , HRM_COMMON_G.ID_NAME_F(HL.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                          , PM.CORP_ID
                          , PM.WORK_CORP_ID
                          , PM.ORI_JOIN_DATE
                          , PM.JOIN_DATE
                          , PM.RETIRE_DATE
                          , PM.SOB_ID
                          , PM.ORG_ID
                       FROM HRM_HISTORY_LINE      HL
                          , HRM_PERSON_MASTER     PM
                      WHERE HL.PERSON_ID        = PM.PERSON_ID
                        AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                       FROM HRM_HISTORY_LINE             S_HL
                                                      WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                        AND S_HL.CHARGE_DATE          <= W_END_DATE
                                                   GROUP BY S_HL.PERSON_ID
                                                   )
                    ) T1
                  , (-- 시점 인사내역.
                      SELECT PH.PERSON_ID
                           , PH.FLOOR_ID
                           , PH.SOB_ID
                           , PH.ORG_ID
                           , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_NAME
                        FROM HRD_PERSON_HISTORY        PH
                       WHERE PH.EFFECTIVE_DATE_FR  <=  W_END_DATE
                         AND PH.EFFECTIVE_DATE_TO  >=  W_END_DATE
                    ) T2
                  , (SELECT DI.SOB_ID
                          , DI.ORG_ID
                          , DI.PERSON_ID
                          , DI.WORK_DATE
                          , DI.WORK_CORP_ID
                          , DI.OPEN_TIME  AS MODIFY_BEFORE_DATETIME_OPEN
                          , DI.CLOSE_TIME AS MODIFY_BEFORE_DATETIME_CLOSE
                       FROM HRD_DAY_INTERFACE DI
                    ) S_DI
               WHERE DL.PERSON_ID              = T1.PERSON_ID
                 AND DL.PERSON_ID              = T2.PERSON_ID
                 AND DL.SOB_ID                 = T2.SOB_ID
                 AND DL.ORG_ID                 = T2.ORG_ID
                 AND DL.SOB_ID                 = S_DI.SOB_ID
                 AND DL.ORG_ID                 = S_DI.ORG_ID
                 AND DL.PERSON_ID              = S_DI.PERSON_ID
                 AND DL.WORK_DATE              = S_DI.WORK_DATE
                 AND DL.WORK_CORP_ID           = S_DI.WORK_CORP_ID
                 AND DL.WORK_DATE              BETWEEN CASE 
                                                          WHEN W_START_DATE < T1.ORI_JOIN_DATE THEN T1.ORI_JOIN_DATE
                                                          ELSE W_START_DATE
                                                        END
                                                AND CASE 
                                                      WHEN T1.RETIRE_DATE IS NULL THEN W_END_DATE
                                                      WHEN T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                      ELSE W_END_DATE
                                                    END
                 AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
                 AND DL.WORK_CORP_ID           = W_CORP_ID
                 AND DL.SOB_ID                 = W_SOB_ID
                 AND DL.ORG_ID                 = W_ORG_ID
                 AND DL.CLOSED_YN              = DECODE(W_CLOSE_YN, 'A', DL.CLOSED_YN, NVL(W_CLOSE_YN, DL.CLOSED_YN))
                 AND DL.HOLY_TYPE              = NVL(W_HOLY_TYPE, DL.HOLY_TYPE)
                 AND DL.DUTY_ID                = NVL(W_DUTY_ID, DL.DUTY_ID)
                 AND T2.FLOOR_ID               = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                 AND T1.DEPT_ID                = NVL(W_DEPT_ID, T1.DEPT_ID)
                 AND T1.JOB_CATEGORY_ID        = NVL(W_JOB_CATEGORY_ID, T1.JOB_CATEGORY_ID)
                 AND T1.JOIN_DATE              <= W_END_DATE
                 AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_START_DATE)
                 AND EXISTS
                       ( SELECT 'X'
                           FROM HRD_DUTY_MANAGER DM
                         WHERE DM.CORP_ID                                = DL.WORK_CORP_ID
                           AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
                           AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DL.WORK_TYPE_ID)
                           AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                           AND DM.START_DATE                              <= W_END_DATE
                           AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_START_DATE)
                           AND DM.SOB_ID                                  = DL.SOB_ID
                           AND DM.ORG_ID                                  = DL.ORG_ID
                        )
               GROUP BY ROLLUP ((DL.PERSON_ID
                   , DL.WORK_DATE
                   , HRM_COMMON_G.CODE_NAME_F('WEEK', TO_CHAR(DL.WORK_DATE, 'D'), DL.SOB_ID, DL.ORG_ID)
                   , T2.FLOOR_NAME
                   , T1.JOB_CATEGORY_NAME
                   , DL.DUTY_ID
                   , HRM_COMMON_G.ID_NAME_F(DL.DUTY_ID)
                   , DL.HOLY_TYPE
                   , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DL.HOLY_TYPE, DL.SOB_ID, DL.ORG_ID)
                   , DL.OPEN_TIME
                   , DL.CLOSE_TIME
                   , DL.OPEN_TIME1
                   , DL.CLOSE_TIME1
                   , DL.NEXT_DAY_YN
                   , DL.DANGJIK_YN
                   , DL.ALL_NIGHT_YN
                   , DL.HOLIDAY_CHECK
                   , DL.CLOSED_YN
                   , DL.CLOSED_PERSON_ID
                   , DL.WORK_TYPE_GROUP
                   , S_DI.MODIFY_BEFORE_DATETIME_OPEN
                   , S_DI.MODIFY_BEFORE_DATETIME_CLOSE
                   , DL.PL_OPEN_TIME
                   , DL.PL_CLOSE_TIME
                   , DL.PL_BEFORE_OT_START
                   , DL.PL_BEFORE_OT_END
                   , DL.PL_AFTER_OT_START
                   , DL.PL_AFTER_OT_END
                   , DL.PL_LUNCH_YN
                   , DL.PL_DINNER_YN
                   , DL.PL_MIDNIGHT_YN
                   , DL.PL_BREAKFAST_YN
                   , T1.ORI_JOIN_DATE
                   , T1.RETIRE_DATE
                   , T1.PERSON_NUM
                   , T1.NAME
                   , DL.WORK_CORP_ID
                   , DL.DAY_LEAVE_ID))
               ORDER BY T1.PERSON_NUM, DL.WORK_DATE, DL.HOLY_TYPE, DL.WORK_TYPE_GROUP
               ;

   END SELECT_DAY_LEAVE_DATA;


  
-----------------------------------------------------------------------------------------
-- 일근태 마감 자료 집계 조회.
  PROCEDURE SELECT_DAY_LEAVE_SUM
            ( P_CURSOR1                           OUT TYPES.TCURSOR1
            , W_CORP_ID                           IN HRD_DAY_LEAVE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_LEAVE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_LEAVE.WORK_DATE%TYPE
            , W_FLOOR_ID                          IN HRM_PERSON_MASTER.FLOOR_ID%TYPE
						, W_PERSON_ID                         IN HRD_DAY_LEAVE.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR1 FOR
      SELECT DM.DEPT_CODE
           , DM.DEPT_NAME
           , HF.FLOOR_NAME
           , PC.POST_NAME
           , T1.PERSON_NUM
           , T1.NAME
           , TO_CHAR(DL.WORK_DATE, 'YYYY-MM') AS DUTY_YYYYMM
           , SUM(CASE 
                   WHEN DL.LATE_TIME = 0 THEN 0 
                   WHEN DL.LATE_TIME <> 0 AND TRUNC(DL.OPEN_TIME, 'MI') > DL.PL_OPEN_TIME THEN 1
                   ELSE 0
                 END) AS LATE_COUNT
           , SUM(CASE 
                   WHEN DL.LATE_TIME = 0 THEN 0 
                   WHEN DL.LATE_TIME <> 0 AND TRUNC(NVL(DL.CLOSE_TIME1, DL.CLOSE_TIME), 'MI') < DL.PL_CLOSE_TIME THEN 1
                   ELSE 0
                 END) AS EARLY_COUNT
           , SUM(CASE WHEN HRD_DAY_LEAVE_G_SET.PUB_LEAVE_TIME_F(DL.WORK_DATE
                                                              , DL.WORK_CORP_ID
                                                              , DL.PERSON_ID
                                                              , JC.JOB_CATEGORY_CODE
                                                              , DL.HOLY_TYPE
                                                              , DL.SOB_ID
                                                              , DL.ORG_ID) != 0 THEN 1 ELSE 0 END) AS LEAVE_COUNT1                     -- 공적외출.
           , SUM(CASE WHEN DL.LEAVE_TIME != 0 THEN 1 ELSE 0 END) AS LEAVE_COUNT2                                                       -- 사적외출.
           , SUM(CASE WHEN DC.DUTY_CODE IN('104') AND DL.HOLY_TYPE IN ('2', '3') THEN 1 ELSE 0 END) AS DUTY_DAY_104                    -- 직출/퇴.
           , SUM(CASE WHEN DC.DUTY_CODE IN('23') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_23   -- 정기휴가.
           , SUM(CASE WHEN DC.DUTY_CODE IN('20') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_20   -- 년차.
           , SUM(CASE WHEN DC.DUTY_CODE IN('21') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_21   -- 반차.
           , SUM(CASE WHEN DC.DUTY_CODE IN('26') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_26   -- 월차.
           , SUM(CASE WHEN DC.DUTY_CODE IN('19') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_19   -- 경조휴가.
           , SUM(CASE WHEN DC.DUTY_CODE IN('22') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_22   -- 보건휴가.
           , SUM(CASE WHEN DC.DUTY_CODE IN('54') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_54   -- 무급휴가.
           , SUM(CASE WHEN DC.DUTY_CODE IN('24') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_24   -- 대체휴무(철야휴가).
           , SUM(CASE WHEN DC.DUTY_CODE IN('94') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_94   -- 산재.
           , SUM(CASE WHEN DC.DUTY_CODE IN('30') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_30   -- 공상.
           , SUM(CASE WHEN DC.DUTY_CODE IN('31') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_31   -- 병가.
           , SUM(CASE WHEN DC.DUTY_CODE IN('77', '78') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_77                            -- 휴직.
           , SUM(CASE WHEN DC.DUTY_CODE IN('95', '96') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_95                            -- 산휴.
           , SUM(CASE WHEN DC.DUTY_CODE IN('97') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_97                                  -- 육아휴직.
           , SUM(CASE WHEN DC.DUTY_CODE IN('11') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_11        -- 결근.
           , 0 AS DUTY_DAY_27           -- 병결.
           , SUM(CASE WHEN DC.DUTY_CODE IN('13') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_13        -- 훈련.
           , SUM(CASE WHEN DC.DUTY_CODE IN('12') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_12        -- 교육.
           , SUM(CASE WHEN DC.DUTY_CODE IN('55', '56') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END)AS DUTY_DAY_ETC  -- 기타(유급휴가/특별유급휴가).
           , SUM(CASE WHEN DC.DUTY_CODE IN('18') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_18        -- 출장.
           , SUM(CASE WHEN DC.DUTY_CODE IN('17') AND DL.HOLY_TYPE IN ('2', '3') THEN NVL(DC.APPLY_DAY, 0) ELSE 0 END) AS DUTY_DAY_17        -- 파견.
        FROM HRD_DAY_LEAVE_V1         DL
           , HRM_DUTY_CODE_V          DC
           , HRM_JOB_CATEGORY_CODE_V  JC
           , (-- 시점 인사내역.
              SELECT HL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , PM.DISPLAY_NAME
                  , HL.DEPT_ID
                  , HL.POST_ID
                  , HL.JOB_CATEGORY_ID
                  , HL.FLOOR_ID 
                  , PM.CORP_ID
                  , PM.WORK_CORP_ID
                  , PM.ORI_JOIN_DATE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                FROM HRM_HISTORY_LINE HL  
                  , HRM_PERSON_MASTER PM
              WHERE HL.PERSON_ID        = PM.PERSON_ID
                AND PM.WORK_CORP_ID     = NVL(W_CORP_ID, PM.CORP_ID)
                AND PM.PERSON_ID        = NVL(W_PERSON_ID, PM.PERSON_ID)
                AND PM.SOB_ID           = W_SOB_ID
                AND PM.ORG_ID           = W_ORG_ID
                AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                              FROM HRM_HISTORY_LINE S_HL
                                             WHERE S_HL.CHARGE_DATE            <= W_END_DATE
                                               AND S_HL.PERSON_ID              = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )
              ) T1
           , HRM_DEPT_MASTER DM
           , HRM_FLOOR_V HF
           , HRM_POST_CODE_V PC
      WHERE DL.DUTY_ID                = DC.DUTY_ID
        AND DL.SOB_ID                 = DC.SOB_ID
        AND DL.ORG_ID                 = DC.ORG_ID
        AND DL.JOB_CATEGORY_ID        = JC.JOB_CATEGORY_ID
        AND DL.PERSON_ID              = T1.PERSON_ID
        AND T1.DEPT_ID                = DM.DEPT_ID
        AND T1.FLOOR_ID               = HF.FLOOR_ID
        AND T1.POST_ID                = PC.POST_ID
      -- 중도 입/퇴사자의 경우 입퇴사일 사이만 적용.      
        AND DL.WORK_DATE              BETWEEN CASE
                                                WHEN T1.JOIN_DATE > W_START_DATE THEN T1.JOIN_DATE
                                                ELSE W_START_DATE 
                                              END
                                          AND CASE 
                                                WHEN T1.RETIRE_DATE IS NOT NULL AND T1.RETIRE_DATE < W_END_DATE THEN T1.RETIRE_DATE
                                                ELSE W_END_DATE
                                              END
        AND DL.PERSON_ID              = NVL(W_PERSON_ID, DL.PERSON_ID)
        AND DL.SOB_ID                 = W_SOB_ID
        AND DL.ORG_ID                 = W_ORG_ID
        AND T1.FLOOR_ID               = NVL(W_FLOOR_ID, T1.FLOOR_ID)
        AND T1.JOIN_DATE              <= W_END_DATE
        AND (T1.RETIRE_DATE IS NULL OR T1.RETIRE_DATE >= W_START_DATE)
      GROUP BY DM.DEPT_CODE
           , DM.DEPT_NAME
           , HF.FLOOR_NAME
           , PC.POST_NAME
           , T1.PERSON_NUM
           , T1.NAME
           , TO_CHAR(DL.WORK_DATE, 'YYYY-MM')
           , DM.DEPT_SORT_NUM
           , HF.SORT_NUM
           , PC.SORT_NUM
      ORDER BY DM.DEPT_SORT_NUM, HF.SORT_NUM, PC.SORT_NUM, T1.PERSON_NUM
      ;
  END SELECT_DAY_LEAVE_SUM;



END HRD_DAY_LEAVE_G;
/
