CREATE OR REPLACE PACKAGE HRD_PERSON_HISTORY_G
AS
-- 작업장 및 교대유형 조회
  PROCEDURE SELECT_PERSON_HISTORY
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
            , W_STD_DATE          IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , W_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , W_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , W_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , W_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
            , W_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
            );

-- 작업장 및 교대유형 저장.
  PROCEDURE SAVE_PERSON_HISTORY
            ( O_SUCCESS_FLAG      OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_STD_DATE          IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_CORP_ID           IN  HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_FLOOR_ID          IN  HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN  HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN  HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_DEPT_ID           IN  HRD_PERSON_HISTORY.DEPT_ID%TYPE
            , P_COST_CENTER_ID    IN  HRM_PERSON_MASTER.COST_CENTER_ID%TYPE
            , P_HISTORY_LINE_ID   IN  NUMBER DEFAULT NULL 
            , P_INTERFACE_FLAG    IN VARCHAR2 DEFAULT 'N'
            );

-- 작업장 및 교대유형 신규INSERT.
  PROCEDURE INSERT_PERSON_HISTORY
          ( P_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
          , P_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
          , P_EFFECTIVE_DATE_FR IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
          , P_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
          , P_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
          , P_PRE_FLOOR_ID      IN HRD_PERSON_HISTORY.PRE_FLOOR_ID%TYPE
          , P_PRE_WORK_TYPE_ID  IN HRD_PERSON_HISTORY.PRE_WORK_TYPE_ID%TYPE
          , P_DESCRIPTION       IN HRD_PERSON_HISTORY.DESCRIPTION%TYPE
          , P_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
          , P_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
          , P_USER_ID           IN HRD_PERSON_HISTORY.CREATED_BY%TYPE
          , P_DEPT_ID           IN HRD_PERSON_HISTORY.DEPT_ID%TYPE
          , P_PRE_DEPT_ID       IN HRD_PERSON_HISTORY.PRE_DEPT_ID%TYPE
          , P_HISTORY_TYPE       IN HRD_PERSON_HISTORY.HISTORY_TYPE%TYPE
          , P_HISTORY_LINE_ID   IN NUMBER DEFAULT NULL           
          );
          
-- [2013-07-29 전호수 추가] 인사발령 -> 근태작업장 변경 저장.
  PROCEDURE INTERFACE_PERSON_HISTORY
            ( P_CHARGE_DATE       IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_DEPT_ID           IN  HRD_PERSON_HISTORY.DEPT_ID%TYPE
            , P_FLOOR_ID          IN  HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_DESCRIPTION       IN  HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_HISTORY_LINE_ID   IN  NUMBER
            , O_STATUS            OUT VARCHAR2
            );

-- [2013-07-29 전호수 추가] 인사발령 삭제 -> 근태작업장 변경 삭제.
  PROCEDURE INTERFACE_DEL_PERSON_HISTORY
            ( P_CHARGE_DATE       IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_HISTORY_LINE_ID   IN  NUMBER
            , O_STATUS            OUT VARCHAR2
            );
            

-- 교대유형 저장.
  PROCEDURE SAVE_PERSON_HISTORY_WORY_TYPE
            ( O_SUCCESS_FLAG      OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_STD_DATE          IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_WORK_PERIOD       IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_CHANGE_DATE_FR    IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_CHANGE_DATE_TO    IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_WORK_CORP_ID      IN  HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_FLOOR_ID          IN  HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN  HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN  HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            );


-- 교대유형 및 작업장 삭제 [2011-08-30]
   PROCEDURE DELETE_PERSON_HISTORY
           ( O_DELETE_SUCCESS_FLAG      OUT VARCHAR2
           , O_MODIFY_SUCCESS_WORK_TYPE OUT VARCHAR2
           , W_MODIFY_TAB               IN  VARCHAR2 -- W : WORK_TYPE, F : FLOOR
           , W_SOB_ID                   IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
           , W_ORG_ID                   IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
           , W_WORK_CORP_ID             IN  HRD_PERSON_HISTORY.CORP_ID%TYPE
           , W_PERSON_ID                IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
           , W_EFFECTIVE_DATE_FR        IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
           , W_EFFECTIVE_DATE_TO        IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_TO%TYPE
           , P_USER_ID                  IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
           );


       PROCEDURE UPDATE_WORK_CALENDAR
               ( W_WORK_DATE     IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
               , W_PERSON_ID     IN  HRD_WORK_CALENDAR.PERSON_ID%TYPE
               , W_SOB_ID        IN  HRD_WORK_CALENDAR.SOB_ID%TYPE
               , W_ORG_ID        IN  HRD_WORK_CALENDAR.ORG_ID%TYPE
               , P_DUTY_ID       IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
               , P_HOLY_TYPE     IN  HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
               , P_OPEN_TIME     IN  HRD_WORK_CALENDAR.OPEN_TIME%TYPE
               , P_CLOSE_TIME    IN  HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
               , P_DESCRIPTION   IN  HRD_WORK_CALENDAR.DESCRIPTION%TYPE
               , P_USER_ID       IN  HRD_WORK_CALENDAR.CREATED_BY%TYPE
               );


       -- 공통코드 조회 LOOKUP - GROUP CODE..
       PROCEDURE LU_SELECT_GROUP( P_CURSOR3           OUT  TYPES.TCURSOR3
                                , W_GROUP_CODE        IN   HRM_COMMON.GROUP_CODE%TYPE
                                , W_CODE_NAME         IN   HRM_COMMON.CODE_NAME%TYPE
                                , W_SOB_ID            IN   HRM_COMMON.SOB_ID%TYPE
                                , W_ORG_ID            IN   HRM_COMMON.ORG_ID%TYPE
                                , W_ENABLED_FLAG_YN   IN   HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
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
                                             , W_STD_DATE                          IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
                                             , W_WORK_CORP_ID                      IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                             , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_FLOOR_ID                          IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                             , W_WORK_TYPE_ID                      IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                             , W_CONNECT_PERSON_ID                 IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_EMPLOYE_TYPE                      IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                             );


       PROCEDURE SELECT_MODIFY_FLOOR( P_CURSOR             OUT TYPES.TCURSOR
                                    , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                    , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                    , W_STD_DATE           IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
                                    , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                    , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                    , W_FLOOR_ID           IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                    , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                    , W_EMPLOYE_TYPE       IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                    );


       PROCEDURE SELECT_MODIFY_WORKTYPE( P_CURSOR             OUT TYPES.TCURSOR
                                       , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                       , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                       , W_STD_DATE           IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
                                       , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                       , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                       , W_FLOOR_ID           IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                       , W_WORK_TYPE_ID       IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                       , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                       , W_EMPLOYE_TYPE       IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                       );


       PROCEDURE SELECT_MODIFY_HISTORY( P_CURSOR             OUT TYPES.TCURSOR
                                      , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                      , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                      , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                      , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                      );

       PROCEDURE SELECT_MODIFY_HISTORY_2( P_CURSOR             OUT TYPES.TCURSOR
                                        , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                        , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                        , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                        , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                        );

       PROCEDURE SELECT_DETAIL_WORK_CALENDAR( P_CUR1                              OUT TYPES.TCURSOR1
                                            , W_SOB_ID                            IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                            , W_ORG_ID                            IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                            , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                            , W_START_DATE                        IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                            , W_END_DATE                          IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
                                            );

-- Table을 이용한 Work Calendar Create.
  PROCEDURE WORK_CALENDAR_SET_TABLE
          ( P_SOB_ID           IN   HRD_WORK_CALENDAR.SOB_ID%TYPE
          , P_ORG_ID           IN   HRD_WORK_CALENDAR.ORG_ID%TYPE
          , P_USER_ID          IN   HRD_WORK_CALENDAR.CREATED_BY%TYPE
          , P_PERSON_ID        IN   HRD_WORK_CALENDAR.PERSON_ID%TYPE
          , P_WORK_CORP_ID     IN   HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
          , P_WORK_TYPE_ID     IN   HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
          , P_WORK_PERIOD      IN   HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
          , P_STD_DATE         IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , P_CHANGE_DATE_FR   IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , P_CHANGE_DATE_TO   IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , O_STATUS           OUT  VARCHAR2
          , O_MESSAGE          OUT  VARCHAR2
          );


END HRD_PERSON_HISTORY_G; 
/
CREATE OR REPLACE PACKAGE BODY HRD_PERSON_HISTORY_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_PERSON_HISTORY_G
/* DESCRIPTION  : 근태 작업장 및 교대유형 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/
-- 작업장 및 교대유형 조회
  PROCEDURE SELECT_PERSON_HISTORY
          ( P_CURSOR              OUT  TYPES.TCURSOR
          , W_CORP_ID             IN   HRD_PERSON_HISTORY.CORP_ID%TYPE
          , W_STD_DATE            IN   HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
          , W_FLOOR_ID            IN   HRD_PERSON_HISTORY.FLOOR_ID%TYPE
          , W_WORK_TYPE_ID        IN   HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
          , W_PERSON_ID           IN   HRD_PERSON_HISTORY.PERSON_ID%TYPE
          , W_CONNECT_PERSON_ID   IN   HRD_PERSON_HISTORY.PERSON_ID%TYPE
          , W_SOB_ID              IN   HRD_PERSON_HISTORY.SOB_ID%TYPE
          , W_ORG_ID              IN   HRD_PERSON_HISTORY.ORG_ID%TYPE
          )

  AS

      V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

  BEGIN
      -- 근태권한 설정.
      IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_CORP_ID
                                 , W_START_DATE  => W_STD_DATE
                                 , W_END_DATE    => W_STD_DATE
                                 , W_MODULE_CODE => '20'
                                 , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                 , W_SOB_ID      => W_SOB_ID
                                 , W_ORG_ID      => W_ORG_ID) = 'C' THEN
        V_CONNECT_PERSON_ID := NULL;
      ELSE
        V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
      END IF;

      OPEN P_CURSOR FOR
      SELECT PH.PERSON_ID
           , PM.PERSON_NUM
           , PM.NAME
           , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_DESC
           , HRM_COMMON_G.CODE_NAME_F('SEX_TYPE', PM.SEX_TYPE, PM.SOB_ID, PM.ORG_ID) AS SEX_TYPE_DESC
           , PM.JOIN_DATE
           , PM.RETIRE_DATE
           , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID) AS FLOOR_DESC
           , PH.FLOOR_ID
           , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID) AS WORK_TYPE_DESC
           , PH.WORK_TYPE_ID
           , PH.DESCRIPTION
           , PH.EFFECTIVE_DATE_FR
           , PH.EFFECTIVE_DATE_TO
        FROM HRD_PERSON_HISTORY PH
           , HRM_PERSON_MASTER  PM
       WHERE PH.PERSON_ID(+)                = PM.PERSON_ID
         AND PH.SOB_ID(+)                   = PM.SOB_ID
         AND PH.ORG_ID(+)                   = PM.ORG_ID
         AND PH.CORP_ID                     = W_CORP_ID
         AND PH.FLOOR_ID                    = NVL(W_FLOOR_ID, PH.FLOOR_ID)
         AND PH.WORK_TYPE_ID                = NVL(W_WORK_TYPE_ID, PH.WORK_TYPE_ID)
         AND PH.PERSON_ID                   = NVL(W_PERSON_ID, PH.PERSON_ID)
         AND PH.EFFECTIVE_DATE_FR           <= W_STD_DATE
         AND PH.EFFECTIVE_DATE_TO           >= W_STD_DATE
         AND PM.ORI_JOIN_DATE               <= W_STD_DATE
         AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_STD_DATE)
         AND EXISTS (SELECT 'X'
                       FROM HRD_DUTY_MANAGER DM
                      WHERE DM.CORP_ID              = PH.CORP_ID
                        AND DM.DUTY_CONTROL_ID      = PH.FLOOR_ID
                        AND DM.WORK_TYPE_ID         = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PH.WORK_TYPE_ID)
                        AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                        AND DM.SOB_ID               = PH.SOB_ID
                        AND DM.ORG_ID               = PH.ORG_ID
                    )
           ;

  END SELECT_PERSON_HISTORY;


-- 작업장 및 교대유형 저장.
  PROCEDURE SAVE_PERSON_HISTORY
            ( O_SUCCESS_FLAG      OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_STD_DATE          IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_CORP_ID           IN  HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_FLOOR_ID          IN  HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN  HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN  HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_DEPT_ID           IN  HRD_PERSON_HISTORY.DEPT_ID%TYPE
            , P_COST_CENTER_ID    IN  HRM_PERSON_MASTER.COST_CENTER_ID%TYPE
            , P_HISTORY_LINE_ID   IN  NUMBER DEFAULT NULL 
            , P_INTERFACE_FLAG    IN VARCHAR2 DEFAULT 'N'
            )
  AS
    --V_RECORD_COUNT      NUMBER;
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_SAVE_MODE         VARCHAR2(20);
    V_HISTORY_TYPE      VARCHAR2(50);  -- 저장구분(ATTRIBUTE_A : WORK_TYPE OR FLOOR) -- 
    
    V_EFFECTIVE_DATE_FR HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE := NULL;
    V_EFFECTIVE_DATE_TO HRD_PERSON_HISTORY.EFFECTIVE_DATE_TO%TYPE := NULL;
    
    V_PRE_FLOOR_ID      HRD_PERSON_HISTORY.PRE_FLOOR_ID%TYPE;
    V_PRE_WORK_TYPE_ID  HRD_PERSON_HISTORY.PRE_WORK_TYPE_ID%TYPE;
    V_PRE_DEPT_ID       HRD_PERSON_HISTORY.PRE_DEPT_ID%TYPE;
    
    V_LAST_YN           HRD_PERSON_HISTORY.LAST_YN%TYPE;
    
    V_HISTORY_LINE_ID   NUMBER; 
    V_CHARGE_ID         NUMBER;
    
    -- 현재 데이터 --
    V_CORP_ID               NUMBER;
    V_COST_CENTER_ID        NUMBER;
  BEGIN
    BEGIN
      O_SUCCESS_FLAG := 'N';

      SELECT PH.EFFECTIVE_DATE_FR, PH.EFFECTIVE_DATE_TO
           , PH.FLOOR_ID, PH.WORK_TYPE_ID 
           , PH.LAST_YN
           , PH.DEPT_ID
           
           , PM.COST_CENTER_ID
        INTO V_EFFECTIVE_DATE_FR, V_EFFECTIVE_DATE_TO
           , V_PRE_FLOOR_ID, V_PRE_WORK_TYPE_ID
           , V_LAST_YN
           , V_PRE_DEPT_ID
           
           , V_COST_CENTER_ID
        FROM HRD_PERSON_HISTORY PH
           , HRM_PERSON_MASTER  PM
      WHERE PH.PERSON_ID          = PM.PERSON_ID
        AND PH.PERSON_ID          = P_PERSON_ID
        AND PH.EFFECTIVE_DATE_FR  <= P_STD_DATE
        AND PH.EFFECTIVE_DATE_TO  >= P_STD_DATE
        AND PH.SOB_ID             = P_SOB_ID
        AND PH.ORG_ID             = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_EFFECTIVE_DATE_FR := P_STD_DATE;
      V_EFFECTIVE_DATE_TO := TO_DATE('3000-12-31', 'YYYY-MM-DD');
      V_LAST_YN := 'Y';
      V_SAVE_MODE := 'NEW';
    END;
    -- 최종자료가 아니면 변경 불가 --
    IF V_LAST_YN <> 'Y' THEN
      O_SUCCESS_FLAG := 'N';
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL);
      RETURN;
    END IF;
    IF V_EFFECTIVE_DATE_FR = P_STD_DATE THEN
    -- 기존에 입력된 최종값하고 기준일하고 동일하면 수정.
      V_SAVE_MODE := 'UPDATE';
    ELSIF V_EFFECTIVE_DATE_FR < P_STD_DATE THEN
    -- 기존에 입력된 최종값보다 기준일이 크면 백업후 INSERT.
      V_SAVE_MODE := 'UPDATE/INSERT';
    END IF;
    
    -- 저장구분(ATTRIBUTE_A : WORK_TYPE OR FLOOR) -- 
    IF (NVL(P_FLOOR_ID, -1) != NVL(V_PRE_FLOOR_ID, -1) OR 
          NVL(P_DEPT_ID, -1) != NVL(V_PRE_DEPT_ID, -1) OR
          NVL(P_COST_CENTER_ID, -1) != NVL(V_COST_CENTER_ID, -1)) THEN
      V_HISTORY_TYPE := 'FLOOR';
    ELSIF NVL(P_WORK_TYPE_ID, -1) != NVL(V_PRE_WORK_TYPE_ID, -1) THEN
      V_HISTORY_TYPE := 'WORK_TYPE';
    ELSE
      V_HISTORY_TYPE := '-';
    END IF;
    
    IF V_HISTORY_TYPE = '-' THEN
      O_SUCCESS_FLAG := 'N';
      O_MESSAGE := 'Person History Type Change : ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10491');
      RETURN;
    END IF;
    
    -- 인사발령 LINE ID --
    V_HISTORY_LINE_ID := P_HISTORY_LINE_ID;
    
    /*RAISE_APPLICATION_ERROR(-20001, '0.' ||  V_SAVE_MODE || '/' || P_INTERFACE_FLAG || '/' || P_DEPT_ID ||'/' || V_PRE_DEPT_ID);
          RETURN;
          */
    -- 작업장 및 부서 변경시만 인사발령 반영 --    
    IF NVL(P_INTERFACE_FLAG, 'N') != 'Y' THEN      
      IF (NVL(P_FLOOR_ID, -1) != NVL(V_PRE_FLOOR_ID, -1) OR 
          NVL(P_DEPT_ID, -1) != NVL(V_PRE_DEPT_ID, -1)) THEN
        /*RAISE_APPLICATION_ERROR(-20001, '2.' ||  V_SAVE_MODE || '/' || V_HISTORY_LINE_ID);
          RETURN;*/
        -- 발령사유 ID --
        V_CHARGE_ID := HRM_COMMON_G.GET_ID_F('CHARGE', 'CODE = ''33''', P_SOB_ID, P_ORG_ID);
        
        IF V_SAVE_MODE IN('NEW', 'UPDATE/INSERT') THEN
          HRM_HISTORY_LINE_G.INTERFACE_INSERT_HISTORY
           (  P_HISTORY_LINE_ID                     => V_HISTORY_LINE_ID
            , P_PERSON_ID                           => P_PERSON_ID
            , P_SOB_ID                              => P_SOB_ID
            , P_ORG_ID                              => P_ORG_ID
            , P_CHARGE_DATE                         => P_STD_DATE
            , P_CHARGE_ID                           => V_CHARGE_ID
            , P_RETIRE_ID                           => NULL
            , P_OPERATING_UNIT_ID                   => NULL
            , P_DEPT_ID                             => P_DEPT_ID
            , P_JOB_CLASS_ID                        => NULL
            , P_JOB_ID                              => NULL
            , P_POST_ID                             => NULL
            , P_OCPT_ID                             => NULL
            , P_ABIL_ID                             => NULL
            , P_PAY_GRADE_ID                        => NULL
            , P_JOB_CATEGORY_ID                     => NULL
            , P_FLOOR_ID                            => P_FLOOR_ID        
            , P_PRINT_YN                            => 'Y'
            , P_DESCRIPTION                         => '근태 작업장 변경' 
            , P_USER_ID                             => P_USER_ID
            , O_STATUS                              => O_SUCCESS_FLAG
            , O_MESSAGE                             => O_MESSAGE
            );
          IF O_SUCCESS_FLAG = 'F' THEN
            O_SUCCESS_FLAG := 'N';
            RETURN; 
          ELSE
            O_SUCCESS_FLAG := 'Y';
          END IF;           
        ELSIF V_SAVE_MODE = 'UPDATE' THEN
          BEGIN
            SELECT PH.ATTRIBUTE_1 AS HISTORY_LINE_ID
              INTO V_HISTORY_LINE_ID
              FROM HRD_PERSON_HISTORY PH
            WHERE PH.PERSON_ID          = P_PERSON_ID
              AND PH.EFFECTIVE_DATE_FR  <= P_STD_DATE
              AND PH.EFFECTIVE_DATE_TO  >= P_STD_DATE
              AND PH.SOB_ID             = P_SOB_ID
              AND PH.ORG_ID             = P_ORG_ID
            ;
          EXCEPTION WHEN OTHERS THEN
            V_HISTORY_LINE_ID := NULL;
          END;
          IF V_HISTORY_LINE_ID IS NULL THEN
            BEGIN
              SELECT HL.HISTORY_LINE_ID
                INTO V_HISTORY_LINE_ID
                FROM HRM_HISTORY_HEADER HH
                   , HRM_HISTORY_LINE   HL
               WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                 AND HH.CHARGE_DATE         = P_STD_DATE
                 AND HH.SOB_ID              = P_SOB_ID
                 AND HH.ORG_ID              = P_ORG_ID
                 AND HL.PERSON_ID           = P_PERSON_ID
              ;
            EXCEPTION WHEN OTHERS THEN
              NULL;
            END;
          END IF;
          /*
          RAISE_APPLICATION_ERROR(-20001, '2.' ||  V_SAVE_MODE || '/' || V_HISTORY_LINE_ID);
          RETURN;*/
          
          IF V_HISTORY_LINE_ID IS NOT NULL THEN
            -- HISTORY LINE ID UPDATE -- 
            BEGIN
              UPDATE HRD_PERSON_HISTORY PH
                SET PH.ATTRIBUTE_1        = V_HISTORY_LINE_ID
              WHERE PH.PERSON_ID          = P_PERSON_ID
                AND PH.EFFECTIVE_DATE_FR  <= P_STD_DATE
                AND PH.EFFECTIVE_DATE_TO  >= P_STD_DATE
                AND PH.SOB_ID             = P_SOB_ID
                AND PH.ORG_ID             = P_ORG_ID
              ;
            EXCEPTION WHEN OTHERS THEN
              NULL;
            END;
            
            HRM_HISTORY_LINE_G.INTERFACE_UPDATE_HISTORY
             (  W_HISTORY_LINE_ID                     => V_HISTORY_LINE_ID
              , P_PERSON_ID                           => P_PERSON_ID
              , P_CHARGE_DATE                         => P_STD_DATE
              , P_CHARGE_ID                           => V_CHARGE_ID
              , P_RETIRE_ID                           => NULL
              , P_OPERATING_UNIT_ID                   => NULL
              , P_DEPT_ID                             => P_DEPT_ID
              , P_JOB_CLASS_ID                        => NULL
              , P_JOB_ID                              => NULL
              , P_POST_ID                             => NULL
              , P_OCPT_ID                             => NULL
              , P_ABIL_ID                             => NULL
              , P_PAY_GRADE_ID                        => NULL
              , P_JOB_CATEGORY_ID                     => NULL
              , P_FLOOR_ID                            => P_FLOOR_ID        
              , P_PRINT_YN                            => 'Y'
              , P_DESCRIPTION                         => '근태 작업장 변경' 
              , P_USER_ID                             => P_USER_ID
              , O_STATUS                              => O_SUCCESS_FLAG
              , O_MESSAGE                             => O_MESSAGE
              ); 
            IF O_SUCCESS_FLAG = 'F' THEN
              O_SUCCESS_FLAG := 'N';
              RETURN;
            ELSE
              O_SUCCESS_FLAG := 'Y';
            END IF;
          ELSE
            HRM_HISTORY_LINE_G.INTERFACE_INSERT_HISTORY
             (  P_HISTORY_LINE_ID                     => V_HISTORY_LINE_ID
              , P_PERSON_ID                           => P_PERSON_ID
              , P_SOB_ID                              => P_SOB_ID
              , P_ORG_ID                              => P_ORG_ID
              , P_CHARGE_DATE                         => P_STD_DATE
              , P_CHARGE_ID                           => V_CHARGE_ID
              , P_RETIRE_ID                           => NULL
              , P_OPERATING_UNIT_ID                   => NULL
              , P_DEPT_ID                             => P_DEPT_ID
              , P_JOB_CLASS_ID                        => NULL
              , P_JOB_ID                              => NULL
              , P_POST_ID                             => NULL
              , P_OCPT_ID                             => NULL
              , P_ABIL_ID                             => NULL
              , P_PAY_GRADE_ID                        => NULL
              , P_JOB_CATEGORY_ID                     => NULL
              , P_FLOOR_ID                            => P_FLOOR_ID        
              , P_PRINT_YN                            => 'Y'
              , P_DESCRIPTION                         => '근태 작업장 변경' 
              , P_USER_ID                             => P_USER_ID
              , O_STATUS                              => O_SUCCESS_FLAG
              , O_MESSAGE                             => O_MESSAGE
              ); 
            IF O_SUCCESS_FLAG = 'F' THEN
              O_SUCCESS_FLAG := 'N';
              RETURN;
            ELSE
              O_SUCCESS_FLAG := 'Y';
            END IF;
          END IF;
        END IF;        
      END IF;
      IF  NVL(P_COST_CENTER_ID, -1) != NVL(V_COST_CENTER_ID, -1) THEN
        -- 인사발령 사항 저장 : 저장이 완료되면 인사마스터 자동 반영 처리 됨 --
        UPDATE HRM_PERSON_MASTER PM
          SET PM.COST_CENTER_ID          = P_COST_CENTER_ID
        WHERE PM.PERSON_ID               = P_PERSON_ID
        ; 
      END IF;
    END IF;
    
    IF V_SAVE_MODE = 'NEW' THEN
      INSERT_PERSON_HISTORY
        ( P_CORP_ID
        , P_PERSON_ID
        , V_EFFECTIVE_DATE_FR
        , P_FLOOR_ID
        , P_WORK_TYPE_ID
        , P_FLOOR_ID
        , P_WORK_TYPE_ID
        , P_DESCRIPTION
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID
        , P_DEPT_ID
        , P_DEPT_ID
        , V_HISTORY_TYPE
        , V_HISTORY_LINE_ID
        );
    ELSIF V_SAVE_MODE = 'UPDATE' THEN
      UPDATE HRD_PERSON_HISTORY PH
        SET  PH.FLOOR_ID            = P_FLOOR_ID
           , PH.WORK_TYPE_ID        = P_WORK_TYPE_ID
           , PH.DESCRIPTION         = P_DESCRIPTION
           , PH.LAST_UPDATE_DATE    = V_SYSDATE
           , PH.LAST_UPDATED_BY     = P_USER_ID
           , PH.DEPT_ID             = P_DEPT_ID
           , PH.HISTORY_TYPE        = V_HISTORY_TYPE
      WHERE PH.PERSON_ID            = P_PERSON_ID
        AND PH.EFFECTIVE_DATE_FR    = V_EFFECTIVE_DATE_FR
        AND PH.EFFECTIVE_DATE_TO    = V_EFFECTIVE_DATE_TO
        AND PH.SOB_ID               = P_SOB_ID
        AND PH.ORG_ID               = P_ORG_ID
      ;
    ELSIF V_SAVE_MODE = 'UPDATE/INSERT' THEN
      UPDATE HRD_PERSON_HISTORY PH
         SET PH.EFFECTIVE_DATE_TO = P_STD_DATE - 1
           , PH.LAST_YN            = 'N'
       WHERE PH.PERSON_ID            = P_PERSON_ID
         AND PH.EFFECTIVE_DATE_FR    = V_EFFECTIVE_DATE_FR
         AND PH.EFFECTIVE_DATE_TO    = V_EFFECTIVE_DATE_TO
         AND PH.SOB_ID               = P_SOB_ID
         AND PH.ORG_ID               = P_ORG_ID
           ;
      INSERT_PERSON_HISTORY
        ( P_CORP_ID
        , P_PERSON_ID
        , P_STD_DATE
        , P_FLOOR_ID
        , P_WORK_TYPE_ID
        , V_PRE_FLOOR_ID
        , V_PRE_WORK_TYPE_ID
        , P_DESCRIPTION
        , P_SOB_ID
        , P_ORG_ID
        , P_USER_ID
        , P_DEPT_ID
        , V_PRE_DEPT_ID
        , V_HISTORY_TYPE
        , V_HISTORY_LINE_ID
        );
    END IF;
    
/*
    -- 최종 인사발령사항 적용.
    BEGIN
      UPDATE HRM_HISTORY_LINE HL
         SET HL.FLOOR_ID         = P_FLOOR_ID
           , HL.DEPT_ID          = P_DEPT_ID
       WHERE HL.PERSON_ID        = P_PERSON_ID
         AND HL.HISTORY_LINE_ID  = ( SELECT MAX(HL1.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                       FROM HRM_HISTORY_LINE HL1
                                      WHERE HL1.PERSON_ID             = HL.PERSON_ID
                                   )
           ;

    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10180', NULL));
    END;
*/
    O_SUCCESS_FLAG := 'Y';

  END SAVE_PERSON_HISTORY;


-- 작업장 및 교대유형 신규INSERT.
  PROCEDURE INSERT_PERSON_HISTORY
          ( P_CORP_ID           IN HRD_PERSON_HISTORY.CORP_ID%TYPE
          , P_PERSON_ID         IN HRD_PERSON_HISTORY.PERSON_ID%TYPE
          , P_EFFECTIVE_DATE_FR IN HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
          , P_FLOOR_ID          IN HRD_PERSON_HISTORY.FLOOR_ID%TYPE
          , P_WORK_TYPE_ID      IN HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
          , P_PRE_FLOOR_ID      IN HRD_PERSON_HISTORY.PRE_FLOOR_ID%TYPE
          , P_PRE_WORK_TYPE_ID  IN HRD_PERSON_HISTORY.PRE_WORK_TYPE_ID%TYPE
          , P_DESCRIPTION       IN HRD_PERSON_HISTORY.DESCRIPTION%TYPE
          , P_SOB_ID            IN HRD_PERSON_HISTORY.SOB_ID%TYPE
          , P_ORG_ID            IN HRD_PERSON_HISTORY.ORG_ID%TYPE
          , P_USER_ID           IN HRD_PERSON_HISTORY.CREATED_BY%TYPE
          , P_DEPT_ID           IN HRD_PERSON_HISTORY.DEPT_ID%TYPE
          , P_PRE_DEPT_ID       IN HRD_PERSON_HISTORY.PRE_DEPT_ID%TYPE
          , P_HISTORY_TYPE      IN HRD_PERSON_HISTORY.HISTORY_TYPE%TYPE
          , P_HISTORY_LINE_ID   IN NUMBER DEFAULT NULL 
          )

  AS

      V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);

  BEGIN
      INSERT INTO HRD_PERSON_HISTORY
           ( CORP_ID
           , PERSON_ID
           , EFFECTIVE_DATE_FR
           , EFFECTIVE_DATE_TO
           , SOB_ID
           , ORG_ID
           , FLOOR_ID
           , WORK_TYPE_ID
           , PRE_FLOOR_ID
           , PRE_WORK_TYPE_ID
           , DESCRIPTION
           , LAST_YN           
           , CREATION_DATE
           , CREATED_BY
           , LAST_UPDATE_DATE
           , LAST_UPDATED_BY
           , DEPT_ID
           , PRE_DEPT_ID
           , HISTORY_TYPE  -- HISTORY_TYPE -- 
           , ATTRIBUTE_1  -- P_HISTORY_LINE_ID  
           )
      VALUES
           ( P_CORP_ID
           , P_PERSON_ID
           , P_EFFECTIVE_DATE_FR
           , TO_DATE('3000-12-31', 'YYYY-MM-DD')
           , P_SOB_ID
           , P_ORG_ID
           , P_FLOOR_ID
           , P_WORK_TYPE_ID
           , P_PRE_FLOOR_ID
           , P_PRE_WORK_TYPE_ID
           , P_DESCRIPTION
           , 'Y'
           , V_SYSDATE
           , P_USER_ID
           , V_SYSDATE
           , P_USER_ID
           , P_DEPT_ID
           , P_PRE_DEPT_ID
           , P_HISTORY_TYPE
           , P_HISTORY_LINE_ID
           );

  END INSERT_PERSON_HISTORY;


-- [2013-07-29 전호수 추가] 인사발령 -> 근태작업장 변경 저장.
  PROCEDURE INTERFACE_PERSON_HISTORY
            ( P_CHARGE_DATE       IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_DEPT_ID           IN  HRD_PERSON_HISTORY.DEPT_ID%TYPE
            , P_FLOOR_ID          IN  HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_DESCRIPTION       IN  HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_HISTORY_LINE_ID   IN  NUMBER
            , O_STATUS            OUT VARCHAR2
            )
  AS
    V_MESSAGE           VARCHAR2(300);
    V_CORP_ID           HRM_PERSON_MASTER.CORP_ID%TYPE;
    V_COST_CENTER_ID    HRM_PERSON_MASTER.COST_CENTER_ID%TYPE;
    V_WORK_TYPE_ID      HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE;
  BEGIN
    BEGIN
      SELECT PM.WORK_CORP_ID  -- 근무업체ID --
           , PM.COST_CENTER_ID
           , PM.WORK_TYPE_ID
        INTO V_CORP_ID
           , V_COST_CENTER_ID
           , V_WORK_TYPE_ID
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID         = P_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, 'Not found Data. Person Master not exists');
      RETURN;
    END;
    
    SAVE_PERSON_HISTORY
      ( O_SUCCESS_FLAG      => O_STATUS
      , O_MESSAGE           => V_MESSAGE
      , P_STD_DATE          => P_CHARGE_DATE
      , P_CORP_ID           => V_CORP_ID      
      , P_PERSON_ID         => P_PERSON_ID
      , P_FLOOR_ID          => P_FLOOR_ID
      , P_WORK_TYPE_ID      => V_WORK_TYPE_ID
      , P_DESCRIPTION       => P_DESCRIPTION
      , P_SOB_ID            => P_SOB_ID
      , P_ORG_ID            => P_ORG_ID
      , P_USER_ID           => P_USER_ID
      , P_DEPT_ID           => P_DEPT_ID
      , P_COST_CENTER_ID    => V_COST_CENTER_ID
      , P_HISTORY_LINE_ID   => P_HISTORY_LINE_ID
      );
  
  END INTERFACE_PERSON_HISTORY;
            
-- [2013-07-29 전호수 추가] 인사발령 삭제 -> 근태작업장 변경 삭제.
  PROCEDURE INTERFACE_DEL_PERSON_HISTORY
            ( P_CHARGE_DATE       IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_HISTORY_LINE_ID   IN  NUMBER
            , O_STATUS            OUT VARCHAR2
            )
  AS
    V_DELETE_SUCCESS_FLAG       VARCHAR2(10);
    V_MODIFY_SUCCESS_WORK_TYPE  VARCHAR2(10);
    V_WORK_CORP_ID              NUMBER;
    V_EFFECTIVE_DATE_FR         DATE;
    V_EFFECTIVE_DATE_TO         DATE;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      SELECT PM.WORK_CORP_ID
           , PH.EFFECTIVE_DATE_FR
           , PH.EFFECTIVE_DATE_TO
        INTO V_WORK_CORP_ID
           , V_EFFECTIVE_DATE_FR
           , V_EFFECTIVE_DATE_TO
        FROM HRD_PERSON_HISTORY PH
           , HRM_PERSON_MASTER  PM
       WHERE PH.PERSON_ID         = PM.PERSON_ID
         AND PH.PERSON_ID         = P_PERSON_ID
         AND PH.SOB_ID            = P_SOB_ID
         AND PH.ORG_ID            = P_ORG_ID
         AND PH.ATTRIBUTE_1       = P_HISTORY_LINE_ID
         AND PH.EFFECTIVE_DATE_FR <= P_CHARGE_DATE
         AND (PH.EFFECTIVE_DATE_TO >= P_CHARGE_DATE OR PH.EFFECTIVE_DATE_TO IS NULL)
         AND ROWNUM                <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      RETURN;
    END;
    
    DELETE_PERSON_HISTORY
     ( O_DELETE_SUCCESS_FLAG      => O_STATUS
     , O_MODIFY_SUCCESS_WORK_TYPE => V_MODIFY_SUCCESS_WORK_TYPE
     , W_MODIFY_TAB               => 'F'  -- W : WORK_TYPE, F : FLOOR
     , W_SOB_ID                   => P_SOB_ID
     , W_ORG_ID                   => P_ORG_ID
     , W_WORK_CORP_ID             => V_WORK_CORP_ID
     , W_PERSON_ID                => P_PERSON_ID
     , W_EFFECTIVE_DATE_FR        => V_EFFECTIVE_DATE_FR
     , W_EFFECTIVE_DATE_TO        => V_EFFECTIVE_DATE_TO
     , P_USER_ID                  => P_USER_ID
     /*, P_HISTORY_LINE_ID          => P_HISTORY_LINE_ID*/
     );
           
  END INTERFACE_DEL_PERSON_HISTORY;
            
  
  
-- 교대유형 저장.
  PROCEDURE SAVE_PERSON_HISTORY_WORY_TYPE
            ( O_SUCCESS_FLAG      OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            , P_SOB_ID            IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
            , P_ORG_ID            IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
            , P_USER_ID           IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
            , P_STD_DATE          IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
            , P_WORK_PERIOD       IN  HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
            , P_CHANGE_DATE_FR    IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_CHANGE_DATE_TO    IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
            , P_WORK_CORP_ID      IN  HRD_PERSON_HISTORY.CORP_ID%TYPE
            , P_PERSON_ID         IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
            , P_FLOOR_ID          IN  HRD_PERSON_HISTORY.FLOOR_ID%TYPE
            , P_WORK_TYPE_ID      IN  HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE
            , P_DESCRIPTION       IN  HRD_PERSON_HISTORY.DESCRIPTION%TYPE
            )

  AS

            V_DEPT_ID      HRD_PERSON_HISTORY.DEPT_ID%TYPE;
            V_COST_CENTER_ID   HRM_PERSON_MASTER.COST_CENTER_ID%TYPE;

  BEGIN
            BEGIN
                 SELECT PH.DEPT_ID
                   INTO V_DEPT_ID
                   FROM HRD_PERSON_HISTORY       PH
                  WHERE PH.PERSON_ID           = P_PERSON_ID
                    AND PH.EFFECTIVE_DATE_FR  <= P_STD_DATE
                    AND PH.EFFECTIVE_DATE_TO  >= P_STD_DATE
                    AND PH.SOB_ID              = P_SOB_ID
                    AND PH.ORG_ID              = P_ORG_ID
                      ;
                 EXCEPTION 
                      WHEN OTHERS 
                      THEN
                           V_DEPT_ID := NULL;
            END;


            BEGIN
                 SELECT PM.COST_CENTER_ID
                   INTO V_COST_CENTER_ID
                   FROM HRM_PERSON_MASTER        PM
                  WHERE PM.SOB_ID              = P_SOB_ID
                    AND PM.ORG_ID              = P_ORG_ID
                    AND PM.PERSON_ID           = P_PERSON_ID
                      ;
                 EXCEPTION 
                      WHEN OTHERS 
                      THEN
                           V_COST_CENTER_ID := NULL;
            END;


            SAVE_PERSON_HISTORY
            ( O_SUCCESS_FLAG      => O_SUCCESS_FLAG
            , O_MESSAGE           => O_MESSAGE
            , P_STD_DATE          => P_STD_DATE
            , P_CORP_ID           => P_WORK_CORP_ID
            , P_PERSON_ID         => P_PERSON_ID
            , P_FLOOR_ID          => P_FLOOR_ID
            , P_WORK_TYPE_ID      => P_WORK_TYPE_ID
            , P_DESCRIPTION       => P_DESCRIPTION
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            , P_USER_ID           => P_USER_ID
            , P_DEPT_ID           => V_DEPT_ID
            , P_COST_CENTER_ID    => V_COST_CENTER_ID
            );
          IF O_SUCCESS_FLAG = 'N' THEN
            RETURN;
          END IF;
  
          
          -- 인사마스터 적용.
          BEGIN
            UPDATE HRM_PERSON_MASTER PM
               SET PM.WORK_TYPE_ID  =  P_WORK_TYPE_ID
             WHERE PM.PERSON_ID     =  P_PERSON_ID
                 ;
          EXCEPTION WHEN OTHERS THEN
            O_SUCCESS_FLAG := 'N';
            O_MESSAGE := 'PERSON MASTER UPDATE ERROR : ' || SUBSTR(SQLERRM, 1, 200);
            RETURN;
          END;
          /*O_SUCCESS_FLAG := 'N';
          O_MODIFY_SUCCESS := 'WORK TYPE : ' || P_WORK_TYPE_ID || ', STD : ' || TO_CHAR(P_STD_DATE, 'YYYYMMDD') || 
                              ', DATE FR ' || TO_CHAR(P_CHANGE_DATE_FR, 'YYYYMMDD') || ', DATE FR ' || TO_CHAR(P_CHANGE_DATE_TO, 'YYYYMMDD');
          RETURN;*/
            
          IF O_SUCCESS_FLAG = 'Y' THEN
             WORK_CALENDAR_SET_TABLE
             ( P_SOB_ID           => P_SOB_ID
             , P_ORG_ID           => P_ORG_ID
             , P_USER_ID          => P_USER_ID
             , P_PERSON_ID        => P_PERSON_ID
             , P_WORK_CORP_ID     => P_WORK_CORP_ID
             , P_WORK_TYPE_ID     => P_WORK_TYPE_ID
             , P_WORK_PERIOD      => P_WORK_PERIOD
             , P_STD_DATE         => P_STD_DATE
             , P_CHANGE_DATE_FR   => P_CHANGE_DATE_FR
             , P_CHANGE_DATE_TO   => P_CHANGE_DATE_TO
             , O_STATUS           => O_SUCCESS_FLAG
             , O_MESSAGE          => O_MESSAGE
             );
            IF O_SUCCESS_FLAG = 'S' THEN
              O_SUCCESS_FLAG := 'Y';
            ELSE
              O_SUCCESS_FLAG := 'N';
            END IF;
          END IF;


  END SAVE_PERSON_HISTORY_WORY_TYPE;


-- 교대유형 및 작업장 삭제 [2011-08-30]
   PROCEDURE DELETE_PERSON_HISTORY
           ( O_DELETE_SUCCESS_FLAG      OUT VARCHAR2
           , O_MODIFY_SUCCESS_WORK_TYPE OUT VARCHAR2
           , W_MODIFY_TAB               IN  VARCHAR2 -- W : WORK_TYPE, F : FLOOR
           , W_SOB_ID                   IN  HRD_PERSON_HISTORY.SOB_ID%TYPE
           , W_ORG_ID                   IN  HRD_PERSON_HISTORY.ORG_ID%TYPE
           , W_WORK_CORP_ID             IN  HRD_PERSON_HISTORY.CORP_ID%TYPE
           , W_PERSON_ID                IN  HRD_PERSON_HISTORY.PERSON_ID%TYPE
           , W_EFFECTIVE_DATE_FR        IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
           , W_EFFECTIVE_DATE_TO        IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_TO%TYPE
           , P_USER_ID                  IN  HRD_PERSON_HISTORY.CREATED_BY%TYPE
           )

   AS

           V_FLOOR_ID          HRD_PERSON_HISTORY.FLOOR_ID%TYPE;
           V_DEPT_ID           HRD_PERSON_HISTORY.DEPT_ID%TYPE;
           V_WORK_TYPE_ID      HRD_PERSON_HISTORY.WORK_TYPE_ID%TYPE;
           V_LAST_YN           HRD_PERSON_HISTORY.LAST_YN%TYPE;
           V_WORK_PERIOD       HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE;
           V_CHANGE_DATE_FR    HRD_WORK_CALENDAR.WORK_DATE%TYPE;
           V_CHANGE_DATE_TO    HRD_WORK_CALENDAR.WORK_DATE%TYPE;
           V_ROW_COUNT         NUMBER := 0;
           
           V_CHARGE_ID         NUMBER;
           
           V_HISTORY_TYPE      VARCHAR2(50);  -- 수정구분 (NEW, WORK_TYPE, FLOOR) -- 
   BEGIN

             O_DELETE_SUCCESS_FLAG := 'N';

             BEGIN
                   SELECT COUNT(PH.PERSON_ID)
                     INTO V_ROW_COUNT
                     FROM HRD_PERSON_HISTORY        PH
                    WHERE PH.SOB_ID              =  W_SOB_ID
                      AND PH.ORG_ID              =  W_ORG_ID
                      AND PH.PERSON_ID           =  W_PERSON_ID
                   ;

                   EXCEPTION
                        WHEN OTHERS
                        THEN
                             V_ROW_COUNT := 0;
             END;
             -- 최종자료가 아니면 삭제 불가 --
             IF V_ROW_COUNT IS NULL OR V_ROW_COUNT < 2 THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10293', NULL));
                RETURN;
             END IF;

             BEGIN
                   SELECT NVL(PH.LAST_YN, 'N') AS LAST_YN
                        , PH.HISTORY_TYPE AS HISTORY_TYPE
                     INTO V_LAST_YN
                        , V_HISTORY_TYPE
                     FROM HRD_PERSON_HISTORY        PH
                    WHERE PH.SOB_ID              =  W_SOB_ID
                      AND PH.ORG_ID              =  W_ORG_ID
                      AND PH.PERSON_ID           =  W_PERSON_ID
                      AND PH.EFFECTIVE_DATE_FR   =  W_EFFECTIVE_DATE_FR
                      AND PH.EFFECTIVE_DATE_TO   =  W_EFFECTIVE_DATE_TO
                        ;

                   EXCEPTION
                        WHEN OTHERS
                        THEN
                             V_LAST_YN := 'N';
                             V_HISTORY_TYPE := 'NEW';
             END;
             -- 삭제할 수 없습니다!
             IF V_LAST_YN = 'N' OR V_HISTORY_TYPE = 'NEW' THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10013', NULL));
                RETURN;
             END IF;
             

             BEGIN
                    SELECT TO_CHAR(S_PH.EFFECTIVE_DATE_FR, 'YYYY-MM')
                          , S_PH.EFFECTIVE_DATE_FR
                          , S_PH.EFFECTIVE_DATE_TO
                          , S_PH.FLOOR_ID
                          , S_PH.DEPT_ID
                          , S_PH.WORK_TYPE_ID
                       INTO V_WORK_PERIOD
                          , V_CHANGE_DATE_FR
                          , V_CHANGE_DATE_TO
                          , V_FLOOR_ID
                          , V_DEPT_ID
                          , V_WORK_TYPE_ID
                       FROM HRD_PERSON_HISTORY S_PH
                      WHERE S_PH.SOB_ID    = W_SOB_ID
                        AND S_PH.ORG_ID    = W_ORG_ID
                        AND S_PH.PERSON_ID = W_PERSON_ID
                        AND S_PH.EFFECTIVE_DATE_FR IN ( SELECT MAX(PH.EFFECTIVE_DATE_FR)
                                                          FROM HRD_PERSON_HISTORY PH
                                                         WHERE PH.PERSON_ID         = S_PH.PERSON_ID
                                                           AND PH.EFFECTIVE_DATE_FR < W_EFFECTIVE_DATE_FR                                                                 
                                                      )
                        AND S_PH.EFFECTIVE_DATE_TO IN ( SELECT MAX(PH.EFFECTIVE_DATE_TO)
                                                          FROM HRD_PERSON_HISTORY PH
                                                         WHERE PH.PERSON_ID         = S_PH.PERSON_ID
                                                           AND PH.EFFECTIVE_DATE_TO < W_EFFECTIVE_DATE_TO 
                                                      )
                          
                    ;  
                   EXCEPTION
                        WHEN OTHERS
                        THEN
                             RAISE_APPLICATION_ERROR(-20001, 'GET INFORMATION ERROR');
             END;


             -- 인사마스터 적용.
             BEGIN
                   UPDATE HRM_PERSON_MASTER PM
                      SET PM.FLOOR_ID      =  V_FLOOR_ID
                        , PM.DEPT_ID       =  V_DEPT_ID
                        , PM.WORK_TYPE_ID  =  V_WORK_TYPE_ID
                    WHERE PM.PERSON_ID     =  W_PERSON_ID
                        ;

                   EXCEPTION
                        WHEN OTHERS
                        THEN
                             RAISE_APPLICATION_ERROR(-20001, 'PERSON MASTER UPDATE ERROR');
             END;

             IF W_MODIFY_TAB = 'W' THEN
               -- 삭제할 수 없습니다!
               IF V_HISTORY_TYPE != 'WORK_TYPE' THEN
                  RAISE_APPLICATION_ERROR(-20001, '교대유형 변경이 아닌 자료 : ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10013', NULL));
                  RETURN;
               END IF;
               
                UPDATE HRD_PERSON_HISTORY PH
                   SET PH.EFFECTIVE_DATE_TO   =  TO_DATE('3000-12-31', 'YYYY-MM-DD')
                     , PH.LAST_YN             = 'Y'
                 WHERE PH.SOB_ID              =  W_SOB_ID
                   AND PH.ORG_ID              =  W_ORG_ID
                   AND PH.PERSON_ID           =  W_PERSON_ID
                   AND PH.EFFECTIVE_DATE_FR   =  V_CHANGE_DATE_FR
                   AND PH.EFFECTIVE_DATE_TO   =  V_CHANGE_DATE_TO
                     ;

                IF V_ROW_COUNT = 2 THEN
                   V_WORK_PERIOD := TO_CHAR(V_CHANGE_DATE_TO, 'YYYY-MM');
                   V_CHANGE_DATE_FR := TO_DATE(V_WORK_PERIOD || '-01', 'YYYY-MM-DD');
                ELSIF TO_CHAR(V_CHANGE_DATE_FR, 'YYYY-MM') <> TO_CHAR(V_CHANGE_DATE_TO, 'YYYY-MM') THEN
                   V_WORK_PERIOD := TO_CHAR(V_CHANGE_DATE_TO, 'YYYY-MM');
                   V_CHANGE_DATE_FR := TO_DATE(V_WORK_PERIOD || '-01', 'YYYY-MM-DD');
                END IF;
                
                IF V_CHANGE_DATE_FR < W_EFFECTIVE_DATE_FR THEN
                  V_CHANGE_DATE_FR := W_EFFECTIVE_DATE_FR;                  
                END IF;
                
                V_CHANGE_DATE_TO := LAST_DAY(V_CHANGE_DATE_TO); 
                WORK_CALENDAR_SET_TABLE
                ( P_SOB_ID           => W_SOB_ID
                , P_ORG_ID           => W_ORG_ID
                , P_USER_ID          => P_USER_ID
                , P_PERSON_ID        => W_PERSON_ID
                , P_WORK_CORP_ID     => W_WORK_CORP_ID
                , P_WORK_TYPE_ID     => V_WORK_TYPE_ID
                , P_WORK_PERIOD      => V_WORK_PERIOD
                , P_STD_DATE         => V_CHANGE_DATE_FR  -- 시작일자 -- 
                , P_CHANGE_DATE_FR   => V_CHANGE_DATE_FR
                , P_CHANGE_DATE_TO   => V_CHANGE_DATE_TO
                , O_STATUS           => O_DELETE_SUCCESS_FLAG
                , O_MESSAGE          => O_MODIFY_SUCCESS_WORK_TYPE
                );
                IF O_DELETE_SUCCESS_FLAG = 'F' THEN
                  RAISE_APPLICATION_ERROR(-20001, O_MODIFY_SUCCESS_WORK_TYPE);
                  RETURN;
                END IF;

                DELETE FROM HRD_PERSON_HISTORY PH
                      WHERE PH.SOB_ID              =  W_SOB_ID
                        AND PH.ORG_ID              =  W_ORG_ID
                        AND PH.PERSON_ID           =  W_PERSON_ID
                        AND PH.EFFECTIVE_DATE_FR   =  W_EFFECTIVE_DATE_FR
                        AND PH.EFFECTIVE_DATE_TO   =  W_EFFECTIVE_DATE_TO
                          ;
             ELSIF W_MODIFY_TAB = 'F' THEN
             -- 작업장 변경 -- 
               IF V_HISTORY_TYPE != 'FLOOR' THEN
                  RAISE_APPLICATION_ERROR(-20001, '작업장 변경이 아닌 자료 : ' || EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10013', NULL));
                  RETURN;
               END IF;
               
                UPDATE HRD_PERSON_HISTORY PH
                   SET PH.EFFECTIVE_DATE_TO   =  TO_DATE('3000-12-31', 'YYYY-MM-DD')
                     , PH.LAST_YN             = 'Y'
                 WHERE PH.SOB_ID              =  W_SOB_ID
                   AND PH.ORG_ID              =  W_ORG_ID
                   AND PH.PERSON_ID           =  W_PERSON_ID
                   AND PH.EFFECTIVE_DATE_FR   =  V_CHANGE_DATE_FR
                   AND PH.EFFECTIVE_DATE_TO   =  V_CHANGE_DATE_TO
                     ;
                
                -- 작업장 변경 삭제 -- 
                DELETE FROM HRD_PERSON_HISTORY PH
                      WHERE PH.SOB_ID              =  W_SOB_ID
                        AND PH.ORG_ID              =  W_ORG_ID
                        AND PH.PERSON_ID           =  W_PERSON_ID
                        AND PH.EFFECTIVE_DATE_FR   =  W_EFFECTIVE_DATE_FR
                        AND PH.EFFECTIVE_DATE_TO   =  W_EFFECTIVE_DATE_TO
                ;
                
                -- 인사발령 삭제 -- 
                -- 발령사유 ID --
                V_CHARGE_ID := HRM_COMMON_G.GET_ID_F('CHARGE', 'CODE = ''33''', W_SOB_ID, W_ORG_ID);
                DELETE FROM HRM_HISTORY_LINE HL
                 WHERE HL.PERSON_ID         = W_PERSON_ID
                   AND EXISTS
                         ( SELECT 'X'
                             FROM HRM_HISTORY_HEADER HH
                            WHERE HH.HISTORY_HEADER_ID  = HL.HISTORY_HEADER_ID
                              AND HH.SOB_ID             = W_SOB_ID
                              AND HH.ORG_ID             = W_ORG_ID
                              AND HH.CHARGE_DATE        = W_EFFECTIVE_DATE_FR
                              AND HH.CHARGE_ID          = V_CHARGE_ID
                         )
                ;
             END IF;

             O_DELETE_SUCCESS_FLAG := 'Y';

             /*EXCEPTION
                  WHEN OTHERS
                  THEN
                       --삭제하는 동안 오류가 발생했습니다.
                       RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10349', NULL));
*/
   END DELETE_PERSON_HISTORY;


       PROCEDURE UPDATE_WORK_CALENDAR
               ( W_WORK_DATE     IN  HRD_WORK_CALENDAR.WORK_DATE%TYPE
               , W_PERSON_ID     IN  HRD_WORK_CALENDAR.PERSON_ID%TYPE
               , W_SOB_ID        IN  HRD_WORK_CALENDAR.SOB_ID%TYPE
               , W_ORG_ID        IN  HRD_WORK_CALENDAR.ORG_ID%TYPE
               , P_DUTY_ID       IN  HRD_WORK_CALENDAR.DUTY_ID%TYPE
               , P_HOLY_TYPE     IN  HRD_WORK_CALENDAR.HOLY_TYPE%TYPE
               , P_OPEN_TIME     IN  HRD_WORK_CALENDAR.OPEN_TIME%TYPE
               , P_CLOSE_TIME    IN  HRD_WORK_CALENDAR.CLOSE_TIME%TYPE
               , P_DESCRIPTION   IN  HRD_WORK_CALENDAR.DESCRIPTION%TYPE
               , P_USER_ID       IN  HRD_WORK_CALENDAR.CREATED_BY%TYPE
               )

       AS

       BEGIN

                 UPDATE HRD_WORK_CALENDAR WC
                    SET WC.DUTY_ID             =  P_DUTY_ID
                      , WC.HOLY_TYPE           =  P_HOLY_TYPE
                      , WC.OPEN_TIME           =  P_OPEN_TIME
                      , WC.CLOSE_TIME          =  P_CLOSE_TIME
                      , WC.OLD_OPEN_TIME       =  DECODE(WC.OPEN_TIME,  P_OPEN_TIME,  WC.OLD_OPEN_TIME,  WC.OPEN_TIME)
                      , WC.OLD_CLOSE_TIME      =  DECODE(WC.CLOSE_TIME, P_CLOSE_TIME, WC.OLD_CLOSE_TIME, WC.CLOSE_TIME)
                      , WC.DESCRIPTION         =  P_DESCRIPTION
                      , WC.LAST_UPDATE_DATE    =  GET_LOCAL_DATE(WC.SOB_ID)
                      , WC.LAST_UPDATED_BY     =  P_USER_ID
                  WHERE WC.WORK_DATE           =  W_WORK_DATE
                    AND WC.PERSON_ID           =  W_PERSON_ID
                    AND WC.SOB_ID              =  W_SOB_ID
                    AND WC.ORG_ID              =  W_ORG_ID
                      ;

       END UPDATE_WORK_CALENDAR;


       -- 공통코드 조회 LOOKUP - GROUP CODE..
       PROCEDURE LU_SELECT_GROUP( P_CURSOR3           OUT  TYPES.TCURSOR3
                                , W_GROUP_CODE        IN   HRM_COMMON.GROUP_CODE%TYPE
                                , W_CODE_NAME         IN   HRM_COMMON.CODE_NAME%TYPE
                                , W_SOB_ID            IN   HRM_COMMON.SOB_ID%TYPE
                                , W_ORG_ID            IN   HRM_COMMON.ORG_ID%TYPE
                                , W_ENABLED_FLAG_YN   IN   HRM_COMMON.ENABLED_FLAG%TYPE DEFAULT 'Y'
                                )

       AS

                 V_STD_DATE   HRM_COMMON.EFFECTIVE_DATE_FR%TYPE := NULL;

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
         WHERE HC.GROUP_CODE           = W_GROUP_CODE
           AND HC.CODE_NAME              LIKE W_CODE_NAME || '%'
           AND HC.SOB_ID               = W_SOB_ID
           AND HC.ORG_ID               = W_ORG_ID
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
                 SELECT PM.NAME                                    AS PERSON_NAME
                      , PM.PERSON_NUM                              AS PERSON_NUMBER
                      , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
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
                    AND PM.PERSON_ID                                = T2.PERSON_ID
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
                                             , W_STD_DATE                          IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
                                             , W_WORK_CORP_ID                      IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                             , W_PERSON_ID                         IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_FLOOR_ID                          IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                             , W_WORK_TYPE_ID                      IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                             , W_CONNECT_PERSON_ID                 IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                             , W_EMPLOYE_TYPE                      IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                             )

       AS

                V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

       BEGIN

             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                                        , W_START_DATE  => W_STD_DATE
                                        , W_END_DATE    => W_STD_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT PM.PERSON_NUM                               AS  PERSON_NUMBER
                  , PM.NAME                                     AS  PERSON_NAME
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PH.EFFECTIVE_DATE_FR
                  , PH.EFFECTIVE_DATE_TO
                  , PH.DESCRIPTION
                  , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)         AS  H_FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)     AS  H_WORK_TYPE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)  AS  EMPLOYE_TYPE
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)         AS  P_FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)     AS  P_WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)          AS  P_POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)          AS  P_OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)     AS  P_JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)  AS  P_JOB_CATEGORY_NAME
                  , PM.WORK_CORP_ID
                  , PH.FLOOR_ID
                  , PH.WORK_TYPE_ID
                  , PH.PERSON_ID
                  , 'N' AS O_MODIFY_SUCCESS
               FROM HRM_PERSON_MASTER  PM
                  , HRD_PERSON_HISTORY PH
              WHERE PM.PERSON_ID                               =  PH.PERSON_ID(+)
                AND PM.SOB_ID                                  =  PH.SOB_ID(+)
                AND PM.ORG_ID                                  =  PH.ORG_ID(+)
                AND PM.WORK_CORP_ID                            =  W_WORK_CORP_ID
                AND PM.SOB_ID                                  =  W_SOB_ID
                AND PM.ORG_ID                                  =  W_ORG_ID
                AND PH.PERSON_ID                               =  NVL(W_PERSON_ID, PH.PERSON_ID)
                AND PH.FLOOR_ID                                =  NVL(W_FLOOR_ID, PH.FLOOR_ID)
                AND PH.WORK_TYPE_ID                            =  NVL(W_WORK_TYPE_ID, PH.WORK_TYPE_ID)
                AND PH.EFFECTIVE_DATE_FR                      <=  W_STD_DATE
                AND PH.EFFECTIVE_DATE_TO                      >=  W_STD_DATE
                AND PM.JOIN_DATE                              <=  W_STD_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >=  W_STD_DATE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PH.CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = PH.FLOOR_ID
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.SOB_ID                                   = PH.SOB_ID
                               AND DM.ORG_ID                                   = PH.ORG_ID
                           )
                AND PM.EMPLOYE_TYPE = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
           ORDER BY PM.NAME
                  ;

       END SELECT_MODIFY_FLOOR_WORKTYPE;


       PROCEDURE SELECT_MODIFY_FLOOR( P_CURSOR             OUT TYPES.TCURSOR
                                    , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                    , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                    , W_STD_DATE           IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
                                    , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                    , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                    , W_FLOOR_ID           IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                    , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                    , W_EMPLOYE_TYPE       IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                    )

       AS

                V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

       BEGIN

             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                                        , W_START_DATE  => W_STD_DATE
                                        , W_END_DATE    => W_STD_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT PM.PERSON_NUM                               AS  PERSON_NUMBER
                  , PM.NAME                                     AS  PERSON_NAME
                  , PH.EFFECTIVE_DATE_FR                        AS  MODIFY_DATE
                  , PH.EFFECTIVE_DATE_TO
                  , PH.DESCRIPTION                              AS  MODIFY_DESCRIPTION
                  , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)         AS  H_FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID)   AS  H_DEPT_NAME
                  , HRM_COMMON_G.COST_CENTER_DESC_F(PM.COST_CENTER_ID) AS P_COST_CENTER_NAME
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)   AS  P_CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)         AS  P_FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PM.DEPT_ID)   AS  P_DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)     AS  P_WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)          AS  P_POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)          AS  P_OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)     AS  P_JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)  AS  P_JOB_CATEGORY_NAME
                  , PM.JOIN_DATE
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)  AS  EMPLOYE_TYPE
                  , PM.RETIRE_DATE
                  , PM.WORK_CORP_ID
                  , PH.FLOOR_ID
                  , PH.DEPT_ID
                  , PH.WORK_TYPE_ID
                  , PH.PERSON_ID
                  , '' AS O_MESSAGE
                  , 'N' AS O_SUCCESS_FLAG
                  , PM.COST_CENTER_ID
               FROM HRM_PERSON_MASTER  PM
                  , HRD_PERSON_HISTORY PH
              WHERE PM.PERSON_ID                               =  PH.PERSON_ID(+)
                AND PM.SOB_ID                                  =  PH.SOB_ID(+)
                AND PM.ORG_ID                                  =  PH.ORG_ID(+)
                AND PM.WORK_CORP_ID                            =  W_WORK_CORP_ID
                AND PM.SOB_ID                                  =  W_SOB_ID
                AND PM.ORG_ID                                  =  W_ORG_ID
                AND PH.PERSON_ID                               =  NVL(W_PERSON_ID, PH.PERSON_ID)
                AND PH.FLOOR_ID                                =  NVL(W_FLOOR_ID, PH.FLOOR_ID)
                AND PH.EFFECTIVE_DATE_FR                      <=  W_STD_DATE
                AND PH.EFFECTIVE_DATE_TO                      >=  W_STD_DATE
                AND PM.JOIN_DATE                              <=  W_STD_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >=  W_STD_DATE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PH.CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = PH.FLOOR_ID
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.SOB_ID                                   = PH.SOB_ID
                               AND DM.ORG_ID                                   = PH.ORG_ID
                           )
                AND PM.EMPLOYE_TYPE = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
           ORDER BY HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)
                  , PM.NAME
                  ;

       END SELECT_MODIFY_FLOOR;


       PROCEDURE SELECT_MODIFY_WORKTYPE( P_CURSOR             OUT TYPES.TCURSOR
                                       , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                       , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                       , W_STD_DATE           IN  HRD_PERSON_HISTORY.EFFECTIVE_DATE_FR%TYPE
                                       , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                       , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                       , W_FLOOR_ID           IN  HRM_PERSON_MASTER.FLOOR_ID%TYPE
                                       , W_WORK_TYPE_ID       IN  HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                                       , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                       , W_EMPLOYE_TYPE       IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
                                       )

       AS

                V_CONNECT_PERSON_ID   HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;

       BEGIN

             -- 근태권한 설정.
             IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID     => W_WORK_CORP_ID
                                        , W_START_DATE  => W_STD_DATE
                                        , W_END_DATE    => W_STD_DATE
                                        , W_MODULE_CODE => '20'
                                        , W_PERSON_ID   => W_CONNECT_PERSON_ID
                                        , W_SOB_ID      => W_SOB_ID
                                        , W_ORG_ID      => W_ORG_ID) = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             OPEN P_CURSOR FOR
             SELECT PM.PERSON_NUM                               AS  PERSON_NUMBER
                  , PM.NAME                                     AS  PERSON_NAME
                  , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)         AS  H_FLOOR_NAME
                  , PH.EFFECTIVE_DATE_FR                        AS  MODIFY_DATE
                  , PH.EFFECTIVE_DATE_TO
                  , PH.DESCRIPTION                              AS  MODIFY_DESCRIPTION
                  , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)     AS  H_WORK_TYPE_NAME
                  , 'N'                                         AS  H_MODIFY
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)   AS  P_CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)         AS  P_FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)     AS  P_WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)          AS  P_POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)          AS  P_OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)     AS  P_JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)  AS  P_JOB_CATEGORY_NAME
                  , PM.JOIN_DATE
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)  AS  EMPLOYE_TYPE
                  , PM.RETIRE_DATE
                  , PM.WORK_CORP_ID
                  , PH.FLOOR_ID
                  , PH.WORK_TYPE_ID
                  , PH.PERSON_ID
                  , ''  AS O_MESSAGE
                  , 'N' AS O_SUCCESS_FLAG
               FROM HRM_PERSON_MASTER  PM
                  , HRD_PERSON_HISTORY PH
              WHERE PM.PERSON_ID                               =  PH.PERSON_ID(+)
                AND PM.SOB_ID                                  =  PH.SOB_ID(+)
                AND PM.ORG_ID                                  =  PH.ORG_ID(+)
                AND PM.WORK_CORP_ID                            =  W_WORK_CORP_ID
                AND PM.SOB_ID                                  =  W_SOB_ID
                AND PM.ORG_ID                                  =  W_ORG_ID
                AND PH.PERSON_ID                               =  NVL(W_PERSON_ID, PH.PERSON_ID)
                AND PH.FLOOR_ID                                =  NVL(W_FLOOR_ID, PH.FLOOR_ID)
                AND PH.WORK_TYPE_ID                            =  NVL(W_WORK_TYPE_ID, PH.WORK_TYPE_ID)
                AND PH.EFFECTIVE_DATE_FR                      <=  W_STD_DATE
                AND PH.EFFECTIVE_DATE_TO                      >=  W_STD_DATE
                AND PM.JOIN_DATE                              <=  W_STD_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >=  W_STD_DATE)
                AND EXISTS (SELECT 'X'
                              FROM HRD_DUTY_MANAGER DM
                             WHERE DM.CORP_ID                                  = PH.CORP_ID
                               AND DM.DUTY_CONTROL_ID                          = PH.FLOOR_ID
                               AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                               AND DM.SOB_ID                                   = PH.SOB_ID
                               AND DM.ORG_ID                                   = PH.ORG_ID
                           )
                AND PM.EMPLOYE_TYPE = NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
           ORDER BY HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)
                  , PM.NAME
                  ;

       END SELECT_MODIFY_WORKTYPE;


       PROCEDURE SELECT_MODIFY_HISTORY( P_CURSOR             OUT TYPES.TCURSOR
                                      , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                      , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                      , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                      , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                      )

       AS

       BEGIN

             OPEN P_CURSOR FOR
             SELECT PM.PERSON_NUM                               AS  PERSON_NUMBER
                  , PM.NAME                                     AS  PERSON_NAME
                  , PH.EFFECTIVE_DATE_FR
                  , PH.EFFECTIVE_DATE_TO
                  , PH.DESCRIPTION                              AS  MODIFY_DESCRIPTION
                  , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)         AS  H_FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)     AS  H_WORK_TYPE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)  AS  EMPLOYE_TYPE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)   AS  P_CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)         AS  P_FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)     AS  P_WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)          AS  P_POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)          AS  P_OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)     AS  P_JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)  AS  P_JOB_CATEGORY_NAME
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PH.PERSON_ID
                  , PH.LAST_YN
                  , PH.CORP_ID AS WORK_CORP_ID
               FROM HRM_PERSON_MASTER  PM
                  , HRD_PERSON_HISTORY PH
              WHERE PM.PERSON_ID                               =  PH.PERSON_ID(+)
                AND PM.SOB_ID                                  =  PH.SOB_ID(+)
                AND PM.ORG_ID                                  =  PH.ORG_ID(+)
                AND PM.SOB_ID                                  =  W_SOB_ID
                AND PM.ORG_ID                                  =  W_ORG_ID
                AND PM.WORK_CORP_ID                            =  W_WORK_CORP_ID
                AND PH.PERSON_ID                               =  W_PERSON_ID
           ORDER BY PH.EFFECTIVE_DATE_FR DESC
                  ;

       END SELECT_MODIFY_HISTORY;



       PROCEDURE SELECT_MODIFY_HISTORY_2( P_CURSOR             OUT TYPES.TCURSOR
                                        , W_SOB_ID             IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                        , W_ORG_ID             IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                        , W_WORK_CORP_ID       IN  HRM_PERSON_MASTER.WORK_CORP_ID%TYPE
                                        , W_PERSON_ID          IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                                        )

       AS

       BEGIN

             OPEN P_CURSOR FOR
             SELECT PM.PERSON_NUM                               AS  PERSON_NUMBER
                  , PM.NAME                                     AS  PERSON_NAME
                  , PH.EFFECTIVE_DATE_FR
                  , PH.EFFECTIVE_DATE_TO
                  , PH.DESCRIPTION                              AS  MODIFY_DESCRIPTION
                  , HRM_COMMON_G.ID_NAME_F(PH.FLOOR_ID)         AS  H_FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(PH.DEPT_ID)   AS  H_DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PH.WORK_TYPE_ID)     AS  H_WORK_TYPE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID)  AS  EMPLOYE_TYPE
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)   AS  P_CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)         AS  P_FLOOR_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)     AS  P_WORK_TYPE_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.POST_ID)          AS  P_POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.OCPT_ID)          AS  P_OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)     AS  P_JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.JOB_CATEGORY_ID)  AS  P_JOB_CATEGORY_NAME
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PH.PERSON_ID
                  , PH.LAST_YN
                  , PH.CORP_ID AS WORK_CORP_ID
               FROM HRM_PERSON_MASTER  PM
                  , HRD_PERSON_HISTORY PH
              WHERE PM.PERSON_ID                               =  PH.PERSON_ID(+)
                AND PM.SOB_ID                                  =  PH.SOB_ID(+)
                AND PM.ORG_ID                                  =  PH.ORG_ID(+)
                AND PM.SOB_ID                                  =  W_SOB_ID
                AND PM.ORG_ID                                  =  W_ORG_ID
                AND PM.WORK_CORP_ID                            =  W_WORK_CORP_ID
                AND PH.PERSON_ID                               =  W_PERSON_ID
           ORDER BY PH.EFFECTIVE_DATE_FR DESC
                  ;

       END SELECT_MODIFY_HISTORY_2;


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
                      , HRM_COMMON_G.ID_NAME_F(NVL(WC.WORK_TYPE_ID, V_WORK_TYPE_ID))              AS WORK_TYPE_NAME
                      , HRM_COMMON_G.ID_NAME_F(WC.DUTY_ID)                                        AS DUTY_NAME
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_TYPE_NAME
                      , WC.OPEN_TIME  AS OPEN_TIME
                      , WC.CLOSE_TIME AS CLOSE_TIME
                      , HRM_COMMON_G.ID_NAME_F(WC.C_DUTY_ID) C_DUTY_NAME
                      , WC.OLD_OPEN_TIME
                      , WC.OLD_CLOSE_TIME
                      , HRM_COMMON_G.ID_NAME_F(WC.C_DUTY_ID1) C_DUTY_NAME1
                      , NVL(WC.WORK_TYPE_ID, V_WORK_TYPE_ID) AS WORK_TYPE_ID
                      , WC.DUTY_ID
                      , WC.HOLY_TYPE
                      , WC.C_DUTY_ID
                      , WC.C_DUTY_ID1
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







-- Table을 이용한 Work Calendar Create.
  PROCEDURE WORK_CALENDAR_SET_TABLE
          ( P_SOB_ID           IN   HRD_WORK_CALENDAR.SOB_ID%TYPE
          , P_ORG_ID           IN   HRD_WORK_CALENDAR.ORG_ID%TYPE
          , P_USER_ID          IN   HRD_WORK_CALENDAR.CREATED_BY%TYPE
          , P_PERSON_ID        IN   HRD_WORK_CALENDAR.PERSON_ID%TYPE
          , P_WORK_CORP_ID     IN   HRD_WORK_CALENDAR_SET.CORP_ID%TYPE
          , P_WORK_TYPE_ID     IN   HRD_WORK_CALENDAR_SET.WORK_TYPE_ID%TYPE
          , P_WORK_PERIOD      IN   HRD_WORK_CALENDAR_SET.WORK_PERIOD%TYPE
          , P_STD_DATE         IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , P_CHANGE_DATE_FR   IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , P_CHANGE_DATE_TO   IN   HRD_WORK_CALENDAR.WORK_DATE%TYPE
          , O_STATUS           OUT  VARCHAR2
          , O_MESSAGE          OUT  VARCHAR2
          )

  AS

    --------------------------------------------------------------
    -- 조회 조건에 맞는 데이터 검색 ==> 커서
    --------------------------------------------------------------
    CURSOR WORK_CALENDAR_ROW IS
      SELECT PM.PERSON_ID
           , PM.PERSON_NUM
           , PM.WORK_TYPE_ID
           , WT.WORK_TYPE_GROUP AS WORK_TYPE
           , PM.ORI_JOIN_DATE
           , PM.RETIRE_DATE
           , PM.WORK_CORP_ID
           , PM.CORP_ID
           , PM.SOB_ID
           , PM.ORG_ID
        FROM HRM_PERSON_MASTER PM
           , HRM_WORK_TYPE_V   WT
       WHERE PM.WORK_TYPE_ID                            = WT.WORK_TYPE_ID
         AND PM.SOB_ID                                  = P_SOB_ID
         AND PM.ORG_ID                                  = P_ORG_ID
         AND PM.PERSON_ID                               = P_PERSON_ID
         AND PM.JOIN_DATE                              <= P_CHANGE_DATE_TO
         AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= P_CHANGE_DATE_FR)
      ;
    BEGIN
      O_STATUS := 'F';
      FOR B1 IN WORK_CALENDAR_ROW
      LOOP
        FOR C1 IN ( SELECT DISTINCT SX1.WORK_DATE_FR, SX1.WORK_DATE_TO
                    FROM (SELECT WC.WORK_DATE_FR, WC.WORK_DATE_TO
                              FROM HRD_WORK_CALENDAR_SET WC
                            WHERE WC.CORP_ID            = B1.WORK_CORP_ID
                              AND WC.WORK_PERIOD        = P_WORK_PERIOD
                              AND WC.WORK_TYPE_ID       = P_WORK_TYPE_ID
                              AND WC.CREATED_METHOD     = 'A'
                              AND WC.WORK_DATE_FR       <= P_CHANGE_DATE_TO
                              AND WC.WORK_DATE_TO       >= P_CHANGE_DATE_FR
                              AND WC.SOB_ID             = B1.SOB_ID
                              AND WC.ORG_ID             = B1.ORG_ID
                          ORDER BY WC.CREATION_DATE
                         ) SX1 
                  ORDER BY SX1.WORK_DATE_FR 
                )
      LOOP 
        HRD_WORK_CALENDAR_G.WORKCAL_SET_TABLE_PERIOD
                          ( P_CORP_ID         => B1.WORK_CORP_ID
                          , P_WORK_PERIOD     => P_WORK_PERIOD
                          , P_PERSON_ID       => B1.PERSON_ID
                          , P_FLOOR_ID        => NULL
                          , P_WORK_TYPE_ID    => P_WORK_TYPE_ID
                          , P_WORK_DATE_FR    => C1.WORK_DATE_FR
                          , P_WORK_DATE_TO    => C1.WORK_DATE_TO
                          , P_CHARGE_DATE_FR  => CASE
                                                   WHEN C1.WORK_DATE_FR < P_CHANGE_DATE_FR THEN P_CHANGE_DATE_FR
                                                   ELSE C1.WORK_DATE_FR
                                                 END
                          , P_CHARGE_DATE_TO  => CASE
                                                   WHEN C1.WORK_DATE_TO < P_CHANGE_DATE_TO THEN C1.WORK_DATE_TO
                                                   ELSE P_CHANGE_DATE_TO
                                                 END
                          , P_USER_ID         => P_USER_ID
                          , P_SOB_ID          => B1.SOB_ID
                          , P_ORG_ID          => B1.ORG_ID
                          , O_STATUS          => O_STATUS
                          , O_MESSAGE         => O_MESSAGE
                          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END LOOP C1;
    END LOOP B1;
    O_STATUS := 'S'; 
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10296', NULL);
    
         /*BEGIN
              SELECT NVL(MAX(WCS.DAY_COUNT), 0) AS DAY_COUNT
                INTO V_PRE_DAY_COUNT
                FROM HRD_WORK_CALENDAR_SET WCS
               WHERE WCS.CORP_ID          = P_WORK_CORP_ID
                 AND WCS.WORK_PERIOD      = P_WORK_PERIOD
                 AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
                 AND WCS.CREATED_METHOD   = V_CREATED_METHOD
                 AND WCS.WORK_DATE_FR     = V_SEARCH_START_DATE
                 AND WCS.WORK_DATE_TO     = P_CHANGE_DATE_TO
                 AND WCS.HOLY_TYPE        = -1
                 AND WCS.SOB_ID           = P_SOB_ID
                 AND WCS.ORG_ID           = P_ORG_ID
                   ;
              EXCEPTION
                   WHEN OTHERS THEN
                        V_PRE_DAY_COUNT := 0;
         END;

       --------------------------------------------------------------
       -- FOR LOOP 실행 : 조회된 인원수 만큼 --
       --------------------------------------------------------------
         FOR C_ROW  IN WORK_CALENDAR_ROW
         LOOP
             BEGIN
                  -- 기존 자료 삭제.
                  DELETE FROM HRD_WORK_CALENDAR WC
                  WHERE WC.WORK_DATE   BETWEEN P_CHANGE_DATE_FR AND P_CHANGE_DATE_TO
                    AND WC.SOB_ID      =   P_SOB_ID
                    AND WC.ORG_ID      =   P_ORG_ID
                    AND WC.PERSON_ID   =   C_ROW.PERSON_ID
                      ;
                  EXCEPTION
                       WHEN OTHERS THEN
                            DBMS_OUTPUT.PUT_LINE('Work Calendar Delete Error : ' || SQLERRM);
             END;

             D_START_DATE := V_SEARCH_START_DATE - V_PRE_DAY_COUNT;



             --임시테이블 DATA 삭제
             DELETE FROM HRD_WORK_DATE_GT;

             -- 월 달력 생성.
             BEGIN
                   N1 := P_CHANGE_DATE_TO - D_START_DATE + 1;



                   FOR R1 IN 0 .. N1 - 1
                   LOOP
                       INSERT INTO HRD_WORK_DATE_GT
                                 ( WORK_DATE
                                 , PERSON_ID
                                 , WORK_CORP_ID
                                 , CORP_ID
                                 , WORK_YYYYMM
                                 , WORK_WEEK
                                 , HOLIDAY_CHECK
                                 , WORK_TYPE_ID
                                 , WORK_TYPE
                                 , DUTY_ID
                                 , HOLY_TYPE
                                 , SOB_ID
                                 , ORG_ID
                                 , TMP_HOLY_TYPE
                                 )
                       VALUES
                                ( D_START_DATE + R1
                                , C_ROW.PERSON_ID
                                , C_ROW.WORK_CORP_ID
                                , C_ROW.CORP_ID
                                , P_WORK_PERIOD
                                , TO_CHAR(D_START_DATE + R1, 'D')
                                , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_CHECK(D_START_DATE + R1 , P_SOB_ID, P_ORG_ID)
                                , C_ROW.WORK_TYPE_ID
                                , C_ROW.WORK_TYPE
                                , 1168
                                , '2'
                                , P_SOB_ID
                                , P_ORG_ID
                                , '2'
                                )
                                ;
                   END LOOP C_ROW;
             END;



             ------------------------------------------------------------------------------------------------
             -- 교대유형에 따른 근무/근태 값 생성
             ------------------------------------------------------------------------------------------------
             IF C_ROW.WORK_TYPE IN('11') THEN
                -- 무교대(월력 따라감)
                FOR R1 IN ( SELECT WD.WORK_DATE
                                 , WD.PERSON_ID
                                 , WD.WORK_CORP_ID
                                 , WD.CORP_ID
                                 , WD.WORK_YYYYMM
                                 , WD.WORK_WEEK
                                 , WD.HOLIDAY_CHECK
                                 , WD.WORK_TYPE_ID
                                 , WD.WORK_TYPE
                                 , WD.DUTY_ID
                                 , WD.HOLY_TYPE
                                 , WD.SOB_ID
                                 , WD.ORG_ID
                              FROM HRD_WORK_DATE_GT WD
                             WHERE WD.WORK_DATE     BETWEEN D_START_DATE AND P_CHANGE_DATE_TO
                               AND WD.PERSON_ID     = C_ROW.PERSON_ID
                               AND WD.SOB_ID        = C_ROW.SOB_ID
                               AND WD.ORG_ID        = C_ROW.ORG_ID)
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
                     WHERE WD.WORK_DATE  =  R1.WORK_DATE
                       AND WD.PERSON_ID  =  R1.PERSON_ID
                       AND WD.SOB_ID     =  R1.SOB_ID
                       AND WD.ORG_ID     =  R1.ORG_ID;
               END LOOP  R1;
          -------------------------------------------------------------------------------
             ELSE
                  -- Manual입력(2조2교대 OR 3조2교대) --
                  -- 변수 초기화.
                  V_DAY_COUNT  := 0;
                  V_LOOP_COUNT := 0;

                  BEGIN
                       SELECT CEIL((WCS.WORK_DATE_TO - WCS.WORK_DATE_FR + 1) / SUM(DECODE(WCS.HOLY_TYPE, -1, -1, 1) * WCS.DAY_COUNT)) AS LOOP_COUNT
                         INTO V_LOOP_COUNT
                         FROM HRD_WORK_CALENDAR_SET  WCS
                        WHERE WCS.CORP_ID          = P_WORK_CORP_ID
                          AND WCS.WORK_PERIOD      = P_WORK_PERIOD
                          AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
                          AND WCS.CREATED_METHOD   = V_CREATED_METHOD
                          AND WCS.WORK_DATE_FR     = V_SEARCH_START_DATE
                          AND WCS.WORK_DATE_TO     = P_CHANGE_DATE_TO
                          AND WCS.SOB_ID           = P_SOB_ID
                          AND WCS.ORG_ID           = P_ORG_ID
                     GROUP BY WCS.WORK_DATE_TO
                            , WCS.WORK_DATE_FR
                            ;
                       EXCEPTION
                            WHEN OTHERS THEN
                                 V_LOOP_COUNT := 0;
                                 DBMS_OUTPUT.PUT_LINE('Loop Count Error : ' || V_LOOP_COUNT);
                  END;

--RAISE_APPLICATION_ERROR(-20011, V_SEARCH_START_DATE || ' | ' || D_START_DATE || ' | ' || N1 || ' | ' ||  V_LOOP_COUNT);

                  FOR CNT IN 1..V_LOOP_COUNT
                  LOOP
                      FOR R0 IN (SELECT  WCS.SEQ
                                       , WCS.HOLY_TYPE
                                       , WCS.DAY_COUNT
                                    FROM HRD_WORK_CALENDAR_SET WCS
                                   WHERE WCS.CORP_ID          = C_ROW.WORK_CORP_ID   -- C_ROW.CORP_ID[2011-06-27]수정
                                     AND WCS.WORK_PERIOD      = P_WORK_PERIOD
                                     AND WCS.WORK_TYPE_ID     = C_ROW.WORK_TYPE_ID
                                     AND WCS.CREATED_METHOD   = V_CREATED_METHOD
                                     AND WCS.WORK_DATE_FR     = V_SEARCH_START_DATE
                                     AND WCS.WORK_DATE_TO     = P_CHANGE_DATE_TO
                                     AND WCS.SOB_ID           = C_ROW.SOB_ID
                                     AND WCS.ORG_ID           = C_ROW.ORG_ID
                                     AND WCS.HOLY_TYPE       <> -1
                                  ORDER BY WCS.SEQ
                                  )
                      LOOP
                          IF R0.HOLY_TYPE IN (2, 3) AND R0.DAY_COUNT IN(4, 5) THEN
                             V_PRE_HOLY_TYPE := R0.HOLY_TYPE; --휴일이전 주/야 임시 저장
                          END IF;
                          V_DAY_COUNT := NVL(R0.DAY_COUNT, 0);  -- 기적용일수는 이미 시작일자에 반영됨.
                          D_END_DATE := D_START_DATE + V_DAY_COUNT - 1;
                          FOR R1 IN ( SELECT WD.WORK_DATE
                                           , WD.PERSON_ID
                                           , WD.WORK_CORP_ID
                                           , WD.CORP_ID
                                           , WD.WORK_YYYYMM
                                           , WD.WORK_WEEK
                                           , WD.HOLIDAY_CHECK
                                           , WD.WORK_TYPE_ID
                                           , WD.WORK_TYPE
                                           , WD.DUTY_ID
                                           , WD.HOLY_TYPE
                                           , WD.SOB_ID
                                           , WD.ORG_ID
                                        FROM HRD_WORK_DATE_GT WD
                                       WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND D_END_DATE
                                         AND WD.PERSON_ID      = C_ROW.PERSON_ID
                                         AND WD.WORK_CORP_ID   = C_ROW.WORK_CORP_ID
                                         AND WD.SOB_ID         = C_ROW.SOB_ID
                                         AND WD.ORG_ID         = C_ROW.ORG_ID
                                    )
                          LOOP
                              -- 근무구분 반영  --
                              UPDATE HRD_WORK_DATE_GT WD
                                 SET(WD.DUTY_ID
                                   , WD.HOLY_TYPE
                                   , WD.TMP_HOLY_TYPE)
                                     = (SELECT DC.DUTY_ID
                                             , CASE
                                                   WHEN WD.WORK_TYPE IN('22') THEN                       -- 2조 2교대 : 월력
                                                        CASE
                                                            WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'  -- 공휴일 - 유휴일
                                                            ELSE R0.HOLY_TYPE
                                                        END
                                                   ELSE                                                  -- 3조 2교대 : 월력
                                                        CASE
                                                            WHEN WD.HOLIDAY_CHECK IN('A') THEN '1'       -- 공휴일 - 유휴일
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
                                         WHERE DC.SOB_ID      = WD.SOB_ID
                                           AND DC.ORG_ID      = WD.ORG_ID
                                           AND DC.DUTY_CODE   = CASE
                                                                    WHEN WD.WORK_TYPE IN('22') THEN  -- 2조 2교대 : 월력
                                                                         CASE
                                                                             WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'  -- 유휴일
                                                                             WHEN R0.HOLY_TYPE = '1' THEN '51'             -- 유휴일
                                                                             WHEN R0.HOLY_TYPE = '0' THEN '52'             -- 무휴일
                                                                             ELSE '00'
                                                                         END
                                                                    ELSE    -- 3조 2교대 : 월력 --
                                                                         CASE
                                                                             WHEN WD.HOLIDAY_CHECK IN('A') THEN '51'  -- 유휴일
                                                                             WHEN R0.HOLY_TYPE = '1' THEN '51'        -- 유휴일
                                                                             WHEN R0.HOLY_TYPE = '0' THEN '52'        -- 무휴일
                                                                             ELSE '00'
                                                                         END
                                                                END
                                       )
                               WHERE WD.WORK_DATE      =  R1.WORK_DATE
                                 AND WD.PERSON_ID      =  R1.PERSON_ID
                                 AND WD.WORK_CORP_ID   =  R1.WORK_CORP_ID
                                 AND WD.SOB_ID         =  R1.SOB_ID
                                 AND WD.ORG_ID         =  R1.ORG_ID;
                          END LOOP  R1;
                          D_START_DATE := D_END_DATE + 1;
                      END LOOP R0;
                  END LOOP CNT;
             END IF;
-------------------------------------------------------------------------------





             --------------------------------------------------------------------------------------------
             -- OPEN 시간 CLOSE 시간 설정
             --------------------------------------------------------------------------------------------
             UPDATE HRD_WORK_DATE_GT WD
                SET (WD.OPEN_TIME, WD.CLOSE_TIME)
                    =
                      (SELECT TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') + WIT.I_ADD_DAYS AS OPEN_TIME
                            , TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') + WIT.O_ADD_DAYS AS OPEN_TIME
                         FROM HRM_WORK_IO_TIME_V       WIT
                        WHERE WIT.WORK_TYPE          = WD.WORK_TYPE
                          AND WIT.HOLY_TYPE          = WD.HOLY_TYPE
                          AND WIT.ENABLED_FLAG       = 'Y'
                          AND WIT.EFFECTIVE_DATE_FR <= WD.WORK_DATE
                          AND (WIT.EFFECTIVE_DATE_TO IS NULL OR WIT.EFFECTIVE_DATE_TO >= WD.WORK_DATE)
                          AND WIT.SOB_ID             = WD.SOB_ID
                          AND WIT.ORG_ID             = WD.ORG_ID
                      )
              WHERE WD.WORK_DATE       BETWEEN V_SEARCH_START_DATE AND P_CHANGE_DATE_TO
                AND WD.SOB_ID      =   P_SOB_ID
                AND WD.ORG_ID      =   P_ORG_ID
                  ;






             --------------------------------------------------------------------------------------------
             -- 일괄 INSERT 실시
             --------------------------------------------------------------------------------------------
             INSERT INTO HRD_WORK_CALENDAR
                       ( WORK_DATE
                       , PERSON_ID
                       , WORK_CORP_ID
                       , CORP_ID
                       , WORK_YYYYMM
                       , WORK_WEEK
                       , WORK_TYPE_ID
                       , DUTY_ID
                       , HOLY_TYPE
                       , OPEN_TIME
                       , CLOSE_TIME
                       , ATTRIBUTE5
                       , SOB_ID
                       , ORG_ID
                       , CREATION_DATE
                       , CREATED_BY
                       , LAST_UPDATE_DATE
                       , LAST_UPDATED_BY
                       , ATTRIBUTE3
                       )
                 (SELECT WD.WORK_DATE
                       , WD.PERSON_ID
                       , WD.WORK_CORP_ID
                       , WD.CORP_ID
                       , WD.WORK_YYYYMM
                       , WD.WORK_WEEK
                       , WD.WORK_TYPE_ID
                       , WD.DUTY_ID
                       , WD.HOLY_TYPE
                       , WD.OPEN_TIME
                       , WD.CLOSE_TIME
                       , WD.WORK_TYPE AS ATTRIBUTE5
                       , WD.SOB_ID
                       , WD.ORG_ID
                       , D_SYSDATE
                       , P_USER_ID
                       , D_SYSDATE
                       , P_USER_ID
                       , WD.TMP_HOLY_TYPE
                    FROM HRD_WORK_DATE_GT WD
                   WHERE WD.WORK_DATE        BETWEEN P_CHANGE_DATE_FR AND P_CHANGE_DATE_TO
                     AND WD.SOB_ID           = P_SOB_ID
                     AND WD.ORG_ID           = P_ORG_ID
                 );

             -- 임시테이블 DATA 삭제
             DELETE FROM HRD_WORK_DATE_GT;





         END LOOP C_ROW;



         COMMIT;

























    --------------------------------------------------------------
    -- 출퇴근 조회/일근태 조회 : 철야,당직 체크 적용.
    --------------------------------------------------------------
    FOR R1 IN ( SELECT PM.CORP_ID
                     , PM.SOB_ID
                     , PM.ORG_ID
                     , PM.PERSON_ID
                     , DI.WORK_DATE
                     , NVL(DL.DANGJIK_YN,   DI.DANGJIK_YN)   AS DANGJIK_YN
                     , NVL(DL.ALL_NIGHT_YN, DI.ALL_NIGHT_YN) AS ALL_NIGHT_YN
                  FROM HRD_DAY_INTERFACE DI
                     , HRD_DAY_LEAVE DL
                     , HRM_PERSON_MASTER PM
                 WHERE DI.PERSON_ID          = DL.PERSON_ID(+)
                   AND DI.WORK_DATE          = DL.WORK_DATE(+)
                   AND DI.SOB_ID             = DL.SOB_ID(+)
                   AND DI.ORG_ID             = DL.ORG_ID(+)
                   AND DI.PERSON_ID          = PM.PERSON_ID
                   AND DI.WORK_DATE          BETWEEN P_CHANGE_DATE_FR AND P_CHANGE_DATE_TO
                   AND DI.PERSON_ID          = NVL(P_PERSON_ID, DI.PERSON_ID)
                   AND PM.CORP_ID            = P_WORK_CORP_ID
                   AND PM.SOB_ID             = P_SOB_ID
                   AND PM.ORG_ID             = P_ORG_ID
                   AND PM.WORK_TYPE_ID       = NVL(P_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                   AND ( NVL(DL.DANGJIK_YN, DI.DANGJIK_YN)      = 'Y'
                    OR   NVL(DL.ALL_NIGHT_YN, DI.ALL_NIGHT_YN)  = 'Y')
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
             EXCEPTION
                  WHEN OTHERS THEN
                       DBMS_OUTPUT.PUT_LINE('DANGJIK/ALL_NIGHT_UPDATE_ERROR=>' || SUBSTR(SQLERRM, 1, 200));
        END;
    END LOOP R1;


    --------------------------------------------------------------
    -- 연장근무  승인 적용
    --------------------------------------------------------------
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
            AND OL.WORK_DATE          BETWEEN P_CHANGE_DATE_FR AND P_CHANGE_DATE_TO
            AND OL.PERSON_ID          = NVL(P_PERSON_ID, OL.PERSON_ID)
            AND OH.CORP_ID            = P_WORK_CORP_ID
            AND OH.SOB_ID             = P_SOB_ID
            AND OH.ORG_ID             = P_ORG_ID
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
             EXCEPTION
                  WHEN OTHERS THEN
                       DBMS_OUTPUT.PUT_LINE('OT_UPDATE_ERROR=>' || SUBSTR(SQLERRM, 1, 200));
        END;
    END LOOP R1;
      << OT_UPDATE_COMPLETE >>

    --------------------------------------------------------------
    -- 고정근태 승인 적용
    --------------------------------------------------------------
    << DUTY_PERIOD_UPDATE_START >>
    FOR R1 IN (
                SELECT DP.DUTY_PERIOD_ID
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
                   AND (TRUNC(DP.WORK_START_DATE)   BETWEEN P_CHANGE_DATE_FR AND P_CHANGE_DATE_TO
                     OR TRUNC(DP.WORK_END_DATE)     BETWEEN P_CHANGE_DATE_FR AND P_CHANGE_DATE_TO)
                   AND DP.CORP_ID                   = P_WORK_CORP_ID
                   AND DP.PERSON_ID                 = P_PERSON_ID
                   AND DP.SOB_ID                    = P_SOB_ID
                   AND DP.ORG_ID                    = P_ORG_ID
                   AND DP.APPROVE_STATUS            = 'C'
              ORDER BY DP.APPROVED_DATE
              )
    LOOP
        BEGIN
             -- 근무 카렌다 반영 START. --
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
                    SET WC.C_DUTY_ID         =  CASE
                                                    WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                    ELSE DECODE(WC.C_DUTY_ID, NULL, R1.DUTY_ID, WC.C_DUTY_ID)
                                                END
                      , WC.C_DUTY_ID1        =  CASE
                                                    WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                    ELSE DECODE(WC.C_DUTY_ID, NULL, NULL, R1.DUTY_ID)
                                                END
                      , WC.OPEN_TIME         =  CASE
                                                    WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                    ELSE DECODE(WC.WORK_DATE, R1.WORK_START_DATE, R1.REAL_START_DATE, NULL)
                                                END
                      , WC.CLOSE_TIME        =  CASE
                                                    WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                    ELSE DECODE(WC.WORK_DATE, R1.WORK_END_DATE, R1.REAL_END_DATE, NULL)
                                                END
                      , WC.OLD_OPEN_TIME     =  CASE
                                                    WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                    ELSE WC.OPEN_TIME
                                                END
                      , WC.OLD_CLOSE_TIME    =  CASE
                                                    WHEN WC.HOLY_TYPE IN('0', '1') THEN NULL
                                                    ELSE WC.CLOSE_TIME
                                                END
                      , WC.LAST_UPDATE_DATE  =  GET_LOCAL_DATE(WC.SOB_ID)
                      , WC.LAST_UPDATED_BY   =  P_USER_ID
                  WHERE WC.WORK_DATE            BETWEEN R1.WORK_START_DATE AND R1.WORK_END_DATE
                    AND WC.PERSON_ID         =  R1.PERSON_ID
                    AND WC.SOB_ID            =  R1.SOB_ID
                    AND WC.ORG_ID            =  R1.ORG_ID
                      ;
             END IF;
             EXCEPTION
                  WHEN OTHERS THEN
                       DBMS_OUTPUT.PUT_LINE('PERIOD_UPDATE_ERROR=>' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 200));
        END;
    END LOOP R1;
    << DUTY_PERIOD_UPDATE_COMPLETE >>

    COMMIT;






    V_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10296', NULL);
    O_MESSAGE := V_MESSAGE;

    EXCEPTION
         WHEN OTHERS THEN
              V_MESSAGE := 'ERROR=>' || TO_CHAR(SQLCODE) || SUBSTR(SQLERRM, 1, 200);
              O_MESSAGE := V_MESSAGE;
*/
  END WORK_CALENDAR_SET_TABLE;





END HRD_PERSON_HISTORY_G; 
/
