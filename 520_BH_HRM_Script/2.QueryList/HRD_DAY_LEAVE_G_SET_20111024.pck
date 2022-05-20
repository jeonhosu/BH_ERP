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
          , T1.PERSON_NUM
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
      , P_NIGHT_TIME                        IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
      , P_NIGHT_BONUS_TIME                  IN HRD_DAY_LEAVE_OT.OT_TIME%TYPE
      --, P_DESCRIPTION                       IN HRD_DAY_LEAVE.DESCRIPTION%TYPE
      , P_SOB_ID                            IN HRD_DAY_LEAVE.SOB_ID%TYPE
      , P_ORG_ID                            IN HRD_DAY_LEAVE.ORG_ID%TYPE
      , P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
      )
  AS
   V_SYSDATE                                     HRD_DAY_LEAVE.CREATION_DATE%TYPE;
  V_CLOSE_COUNT                                 NUMBER := 0;

 BEGIN
   V_SYSDATE := GET_LOCAL_DATE(P_SOB_ID);
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
    RAISE ERRNUMS.Data_Closed;
   RETURN;
  END IF;

   UPDATE HRD_DAY_LEAVE DL
   SET DL.DUTY_ID                  = P_DUTY_ID
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

 EXCEPTION
   WHEN ERRNUMS.Data_Closed THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  /*WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(SQLCODE, SQLERRM);*/
 END DATA_UPDATE;

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
    RAISE ERRNUMS.Data_Closed;
   RETURN;
  END IF;

    BEGIN
      UPDATE HRD_DAY_LEAVE_OT DL
         SET DL.OT_TIME           = NVL(P_OT_TIME, 0)
           , DL.LAST_UPDATE_DATE  = V_SYSDATE
           , DL.LAST_UPDATED_BY   = P_USER_ID
        WHERE DL.DAY_LEAVE_ID     = P_DAY_LEAVE_ID
          AND DL.OT_TYPE          = P_OT_TYPE
      ;
    END;
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

  EXCEPTION
   WHEN ERRNUMS.Data_Closed THEN
    RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
  END DAY_LEAVE_OT_SAVE;

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
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     HRD_DAY_LEAVE.CREATION_DATE%TYPE;
    V_CLOSE_COUNT                                 NUMBER := 0;

  BEGIN
    V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

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
      RAISE ERRNUMS.Data_Closed;
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
     AND EXISTS ( SELECT 'X'
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
    COMMIT;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10024', NULL);

  EXCEPTION
   WHEN ERRNUMS.Data_Closed THEN
    O_MESSAGE := ERRNUMS.Data_closed_Desc;
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
      , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     HRD_DAY_LEAVE.CREATION_DATE%TYPE;

 BEGIN
   V_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

   UPDATE HRD_DAY_LEAVE DL
   SET DL.CLOSED_YN             = 'N'
     , DL.CLOSED_DATE           = NULL
    , DL.CLOSED_PERSON_ID      = NULL
  WHERE DL.WORK_DATE                BETWEEN W_START_DATE AND W_END_DATE
    AND DL.PERSON_ID                = NVL(W_PERSON_ID, DL.PERSON_ID)
   AND DL.WORK_CORP_ID             = W_CORP_ID
   AND DL.SOB_ID                   = W_SOB_ID
   AND DL.ORG_ID                   = W_ORG_ID
   AND DL.CLOSED_YN                = 'Y'
   AND EXISTS ( SELECT 'X'
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
  COMMIT;
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10025', NULL);

  END DATA_CLOSE_CANCEL;

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
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                      FROM HRM_HISTORY_LINE S_HL
                      WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                       AND S_HL.PERSON_ID              = HL.PERSON_ID
                      GROUP BY S_HL.PERSON_ID
                     )
      ) T1
   WHERE DL.PERSON_ID                            = WC.PERSON_ID
    AND DL.WORK_DATE                            = WC.WORK_DATE
    AND DL.CORP_ID                              = WC.CORP_ID
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
    AND EXISTS ( SELECT 'X'
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

END HRD_DAY_LEAVE_G;
/
