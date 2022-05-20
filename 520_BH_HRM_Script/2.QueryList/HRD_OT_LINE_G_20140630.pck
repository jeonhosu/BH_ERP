CREATE OR REPLACE PACKAGE HRD_OT_LINE_G
AS
-- DATA SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_WORK_TYPE_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            );
						
-- DATA SELECT
  PROCEDURE DATA_INSERT_SELECT
            ( P_CURSOR                                OUT TYPES.TCURSOR
						, W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_HEADER.OT_HEADER_ID%TYPE
						, W_STD_DATE                              IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_DUTY_MANAGER_ID                       IN HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
						, W_WORK_TYPE_ID                          IN HRM_COMMON.COMMON_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
						, W_CONNECT_PERSON_ID                     IN HRD_OT_HEADER.REQ_PERSON_ID%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
            );						

-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, P_REQ_NUM                               IN HRD_OT_LINE.REQ_NUM%TYPE
            , P_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
						, P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
						, P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
						, P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
						, P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, O_OT_LINE_ID                            OUT HRD_OT_LINE.OT_LINE_ID%TYPE						
            );

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
						, P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
						, P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
						, P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
						, P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            );

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
						, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            );

-- DATA DELETE(승인이 되었어도 삭제).
  PROCEDURE DATA_DELETE_C
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
            );
            						
-- LINE DATA COUNT.
  PROCEDURE DATA_LINE_COUNT
	          ( W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
						, O_RECORD_COUNT                          OUT NUMBER
						);


       -- COUNT_DATA_LINE[2011-07-25]
       PROCEDURE COUNT_DATA_LINE
               ( W_CORP_ID           IN   HRD_OT_HEADER.CORP_ID%TYPE
               , W_WORK_DATE         IN   HRD_OT_LINE.WORK_DATE%TYPE
               , W_DUTY_MANAGER_ID   IN   HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
               , W_WORK_TYPE_ID      IN   HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
               , W_REQ_TYPE          IN   HRD_OT_HEADER.REQ_TYPE%TYPE
               , O_RECORD_COUNT      OUT  NUMBER
               );


-- DATA SELECT OT TIME.
  PROCEDURE OT_STD_TIME_O
	          ( W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
						, W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
						, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
						, W_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
						, W_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
						, W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
						, W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
						, O_BEFORE_OT_START                       OUT HRD_OT_LINE.BEFORE_OT_START%TYPE
						, O_BEFORE_OT_END                         OUT HRD_OT_LINE.BEFORE_OT_END%TYPE
						, O_AFTER_OT_START                        OUT HRD_OT_LINE.AFTER_OT_START%TYPE
						, O_AFTER_OT_END                          OUT HRD_OT_LINE.AFTER_OT_END%TYPE
            );

--[2011-10-14]
-------------------------------------------------------------------------------
-- 연장근무 반려 라인 조회.
  PROCEDURE OT_LINE_RETURN_SELECT
            ( P_CURSOR1                               OUT TYPES.TCURSOR1
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
			      			, W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            );

-- 연장근무 반려 적용.
  PROCEDURE OT_LINE_RETURN_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
				      		, W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_REJECT_REMARK                         IN HRD_OT_LINE.REJECT_REMARK%TYPE
            , P_CONNECT_PERSON_ID                     IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , P_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            );
            
-------------------------------------------------------------------------------


--[2011-10-14]
   PROCEDURE SELECT_OT_LINE_APPROVE
           ( P_CURSOR         OUT  TYPES.TCURSOR
           , W_OT_HEADER_ID   IN   HRD_OT_LINE.OT_HEADER_ID%TYPE
           , W_WORK_DATE      IN   HRD_OT_LINE.WORK_DATE%TYPE
           , W_PERSON_ID      IN   HRD_OT_LINE.PERSON_ID%TYPE
           );


-- [2011-10-26][2011-11-29]
   PROCEDURE SELECT_OT_LINE
           ( P_CURSOR         OUT  TYPES.TCURSOR
           , W_OT_HEADER_ID   IN   HRD_OT_LINE.OT_HEADER_ID%TYPE
           , W_WORK_DATE      IN   HRD_OT_LINE.WORK_DATE%TYPE
           , W_WORK_TYPE_ID   IN   HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID      IN   HRD_OT_LINE.PERSON_ID%TYPE
           );


-- [2011-10-27][2011-11-29]
   PROCEDURE SELECT_OT_INSERT_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_SOB_ID             IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_OT_HEADER.ORG_ID%TYPE
           , W_CORP_ID            IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_OT_HEADER_ID       IN  HRD_OT_HEADER.OT_HEADER_ID%TYPE
           , W_STD_DATE           IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DUTY_MANAGER_ID    IN  HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
           , W_WORK_TYPE_ID       IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRD_OT_HEADER.REQ_PERSON_ID%TYPE
           );



-- [2014-06-14][2011-11-29] : 연장여부에 따라 연장 시간 리턴 
   PROCEDURE GET_OT_TIME
           ( O_STATUS             OUT VARCHAR2
           , O_MESSAGE            OUT VARCHAR2 
           , W_SOB_ID             IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_OT_HEADER.ORG_ID%TYPE
           , W_OT_HEADER_ID       IN  HRD_OT_HEADER.OT_HEADER_ID%TYPE 
           , W_OT_FLAG            IN  HRD_OT_LINE.OT_FLAG%TYPE 
           , W_WORK_DATE          IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_PERSON_ID          IN  HRD_OT_LINE.PERSON_ID%TYPE 
           , O_BF_START_TIME      OUT VARCHAR2
           , O_BF_END_TIME        OUT VARCHAR2            
           , O_START_DATE         OUT DATE 
           , O_START_TIME         OUT VARCHAR2 
           , O_END_DATE           OUT DATE
           , O_END_TIME           OUT VARCHAR2 
           );
           
-- [2011-10-27][2011-11-29]
   PROCEDURE OUT_OVERTIME_STANDARD_TIME_1
           ( W_CORP_ID               IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_PERSON_ID             IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_WORK_DATE             IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DANGJIK_YN            IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , W_ALL_NIGHT_YN          IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , W_SOB_ID                IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID                IN  HRD_OT_HEADER.ORG_ID%TYPE
           , O_BEFORE_OT_START       OUT VARCHAR2
           , O_BEFORE_OT_END         OUT VARCHAR2
           , O_AFTER_OT_DATE_START   OUT HRD_OT_LINE.AFTER_OT_START%TYPE
           , O_AFTER_OT_TIME_START   OUT VARCHAR2
           , O_AFTER_OT_DATE_END     OUT HRD_OT_LINE.AFTER_OT_END%TYPE
           , O_AFTER_OT_TIME_END     OUT VARCHAR2
           );



-- [2011-10-30][2011-11-29]
   PROCEDURE OUT_OVERTIME_STANDARD_TIME_2
           ( W_CORP_ID          IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_PERSON_ID        IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_WORK_DATE        IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DANGJIK_YN       IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , W_ALL_NIGHT_YN     IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , W_SOB_ID           IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID           IN  HRD_OT_HEADER.ORG_ID%TYPE
           , O_BEFORE_OT_START  OUT VARCHAR2
           , O_BEFORE_OT_END    OUT VARCHAR2
           , O_AFTER_OT_DATE_START   OUT HRD_OT_LINE.AFTER_OT_START%TYPE
           , O_AFTER_OT_TIME_START   OUT VARCHAR2
           , O_AFTER_OT_DATE_END     OUT HRD_OT_LINE.AFTER_OT_END%TYPE
           , O_AFTER_OT_TIME_END     OUT VARCHAR2
           );




-- [2011-10-28][2011-11-29]
   PROCEDURE INSERT_OT_LINE
           ( P_OT_HEADER_ID         IN  HRD_OT_LINE.OT_HEADER_ID%TYPE
           , P_REQ_NUM              IN  HRD_OT_LINE.REQ_NUM%TYPE
           , P_PERSON_ID            IN  HRD_OT_LINE.PERSON_ID%TYPE
           , P_WORK_DATE            IN  HRD_OT_LINE.WORK_DATE%TYPE
           , P_OT_FLAG              IN  VARCHAR2 
           , P_BEFORE_OT_START      IN  VARCHAR2
           , P_BEFORE_OT_END        IN  VARCHAR2
           , P_AFTER_OT_DATE_START  IN  HRD_OT_LINE.AFTER_OT_START%TYPE
           , P_AFTER_OT_TIME_START  IN  VARCHAR2
           , P_AFTER_OT_DATE_END    IN  HRD_OT_LINE.AFTER_OT_END%TYPE
           , P_AFTER_OT_TIME_END    IN  VARCHAR2
           , P_LUNCH_YN             IN  HRD_OT_LINE.LUNCH_YN%TYPE
           , P_DINNER_YN            IN  HRD_OT_LINE.DINNER_YN%TYPE
           , P_MIDNIGHT_YN          IN  HRD_OT_LINE.MIDNIGHT_YN%TYPE
           , P_BREAKFAST_YN         IN  HRD_OT_LINE.BREAKFAST_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , P_DESCRIPTION          IN  HRD_OT_LINE.DESCRIPTION%TYPE
           , P_USER_ID              IN  HRD_OT_LINE.CREATED_BY%TYPE
           , W_SOB_ID               IN  HRD_OT_HEADER.SOB_ID%TYPE
           , O_OT_LINE_ID           OUT HRD_OT_LINE.OT_LINE_ID%TYPE
           );


-- [2011-10-28][2011-11-29]
   PROCEDURE UPDATE_OT_LINE
           ( W_OT_LINE_ID           IN  HRD_OT_LINE.OT_LINE_ID%TYPE
           , W_OT_HEADER_ID         IN  HRD_OT_LINE.OT_HEADER_ID%TYPE
           , P_PERSON_ID            IN  HRD_OT_LINE.PERSON_ID%TYPE
           , P_WORK_DATE            IN  HRD_OT_LINE.WORK_DATE%TYPE
           , P_OT_FLAG              IN  VARCHAR2 
           , P_BEFORE_OT_START      IN  VARCHAR2
           , P_BEFORE_OT_END        IN  VARCHAR2
           , P_AFTER_OT_DATE_START  IN  HRD_OT_LINE.AFTER_OT_START%TYPE
           , P_AFTER_OT_TIME_START  IN  VARCHAR2
           , P_AFTER_OT_DATE_END    IN  HRD_OT_LINE.AFTER_OT_END%TYPE
           , P_AFTER_OT_TIME_END    IN  VARCHAR2
           , P_LUNCH_YN             IN  HRD_OT_LINE.LUNCH_YN%TYPE
           , P_DINNER_YN            IN  HRD_OT_LINE.DINNER_YN%TYPE
           , P_MIDNIGHT_YN          IN  HRD_OT_LINE.MIDNIGHT_YN%TYPE
           , P_BREAKFAST_YN         IN  HRD_OT_LINE.BREAKFAST_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , P_DESCRIPTION          IN  HRD_OT_LINE.DESCRIPTION%TYPE
           , P_USER_ID              IN  HRD_OT_LINE.CREATED_BY%TYPE
           , W_SOB_ID               IN  HRD_OT_HEADER.SOB_ID%TYPE
           );



END HRD_OT_LINE_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_OT_LINE_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_OT_HEADER_G
/* DESCRIPTION  : 연장근무 HEADER 신청 승인 관리.
/* REFERENCE BY :
/* PROGRAM HISTORY : 신규 생성
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/

-- DATA SELECT
   PROCEDURE DATA_SELECT
           ( P_CURSOR        OUT TYPES.TCURSOR
           , W_OT_HEADER_ID  IN  HRD_OT_LINE.OT_HEADER_ID%TYPE
           , W_WORK_DATE     IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_WORK_TYPE_ID  IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID     IN  HRD_OT_LINE.PERSON_ID%TYPE
           )

   AS

   BEGIN
             OPEN P_CURSOR FOR
             SELECT OL.REQ_NUM
                  , OL.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)    AS WORK_TYPE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
                  , OL.WORK_DATE
                  , 'N' AS CHOICE
                  , OL.DANGJIK_YN
                  , OL.ALL_NIGHT_YN
                  , OL.BEFORE_OT_START
                  , OL.BEFORE_OT_END
                  , OL.AFTER_OT_START
                  , OL.AFTER_OT_END
                  , OL.LUNCH_YN
                  , OL.DINNER_YN
                  , OL.MIDNIGHT_YN
                  , OL.DESCRIPTION
                  , OL.LINE_SEQ
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
                  , OH.APPROVE_STATUS
                  , WC.HOLY_TYPE
                  , OL.OT_LINE_ID
                  , OL.OT_HEADER_ID
               FROM HRD_OT_LINE       OL
                  , HRM_PERSON_MASTER PM
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.DEPT_ID
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
                       FROM HRD_PERSON_HISTORY        PH
                      WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                        AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                    ) T2
                  , HRD_OT_HEADER       OH
                  , HRD_WORK_CALENDAR   WC
              WHERE OL.PERSON_ID     =  PM.PERSON_ID
                AND PM.PERSON_ID     =  T1.PERSON_ID
                AND PM.PERSON_ID     =  T2.PERSON_ID
                AND OL.REQ_NUM       =  OH.REQ_NUM
                AND OL.WORK_DATE     =  WC.WORK_DATE
                AND OL.PERSON_ID     =  WC.PERSON_ID
                AND OH.CORP_ID       =  WC.WORK_CORP_ID
                AND OH.SOB_ID        =  WC.SOB_ID
                AND OH.ORG_ID        =  WC.ORG_ID
                AND OH.OT_HEADER_ID  =  W_OT_HEADER_ID
                AND OL.PERSON_ID     =  NVL(W_PERSON_ID, OL.PERSON_ID)
                AND PM.WORK_TYPE_ID  =  NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
           ORDER BY PM.WORK_TYPE_ID
                  , PM.NAME
                  ;

   END DATA_SELECT;


-- DATA INSERT SELECT
   PROCEDURE DATA_INSERT_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_CORP_ID            IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_OT_HEADER_ID       IN  HRD_OT_HEADER.OT_HEADER_ID%TYPE
           , W_STD_DATE           IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DUTY_MANAGER_ID    IN  HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
           , W_WORK_TYPE_ID       IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRD_OT_HEADER.REQ_PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_OT_HEADER.ORG_ID%TYPE
           )
   AS
             V_CONNECT_PERSON_ID      HRD_OT_HEADER.REQ_PERSON_ID%TYPE := NULL;

   BEGIN
             V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;

/*RAISE_APPLICATION_ERROR(-20011, 'ERP 프로그램 종료후 다시 시작 하세요!');*/

             OPEN P_CURSOR FOR
             SELECT PM.PERSON_ID
                  , PM.NAME
                  , PM.PERSON_NUM
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID)    AS WORK_TYPE_NAME
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
                  , W_STD_DATE AS WORK_DATE
                  , 'N' AS CHOICE
                  , 'N' AS DANGJIK_YN
                  , 'N' AS ALL_NIGHT_YN
                  , TO_DATE(TO_CHAR(W_STD_DATE + A_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_START
                  , TO_DATE(TO_CHAR(W_STD_DATE + A_OST.END_ADD_DAY,   'YYYY-MM-DD') ||  ' ' || A_OST.END_TIME,   'YYYY-MM-DD HH24:MI') AS AFTER_OT_END
                  , TO_DATE(TO_CHAR(W_STD_DATE + B_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_START
                  , TO_DATE(TO_CHAR(W_STD_DATE + B_OST.END_ADD_DAY,   'YYYY-MM-DD') ||  ' ' || B_OST.END_TIME,   'YYYY-MM-DD HH24:MI') AS BEFORE_OT_END
                  , 'N'  AS LUNCH_YN
                  , 'N'  AS DINNER_YN
                  , 'N'  AS MIDNIGHT_YN
                  , NULL AS DESCRIPTION
                  , 0    AS LINE_SEQ
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', 'N', PM.SOB_ID, PM.ORG_ID) AS APPROVE_STATUS_NAME
                  , 'N'            AS APPROVE_STATUS
                  , WC.HOLY_TYPE
                  , NULL           AS OT_LINE_ID
                  , W_OT_HEADER_ID AS OT_HEADER_ID
               FROM HRM_PERSON_MASTER        PM
                  , (-- 시점 인사내역.
                     SELECT HL.PERSON_ID
                          , HL.DEPT_ID
                          , HL.POST_ID
                          , HL.JOB_CATEGORY_ID
                       FROM HRM_HISTORY_LINE HL
                       WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                        FROM HRM_HISTORY_LINE             S_HL
                                                       WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                         AND S_HL.CHARGE_DATE          <= W_STD_DATE
                                                    GROUP BY S_HL.PERSON_ID
                                )
                    )                        T1
                  , (-- 시점 인사내역.
                          SELECT PH.PERSON_ID
                               , PH.FLOOR_ID
                            FROM HRD_PERSON_HISTORY        PH
                           WHERE PH.EFFECTIVE_DATE_FR  <=  W_STD_DATE
                             AND PH.EFFECTIVE_DATE_TO  >=  W_STD_DATE
                    )                        T2
                  , HRD_WORK_CALENDAR        WC
                  , HRM_WORK_TYPE_V          B_WT
                  , HRM_OT_STD_TIME_V        B_OST
                  , HRM_WORK_TYPE_V          A_WT
                  , HRM_OT_STD_TIME_V        A_OST
               WHERE W_STD_DATE            = WC.WORK_DATE
                 AND PM.PERSON_ID          = T1.PERSON_ID(+)
                 AND PM.PERSON_ID          = T2.PERSON_ID(+)
                 AND PM.PERSON_ID          = WC.PERSON_ID
                 AND PM.CORP_ID            = WC.CORP_ID
                 AND PM.SOB_ID             = WC.SOB_ID
                 AND PM.ORG_ID             = WC.ORG_ID
                 AND WC.WORK_TYPE_ID       = B_WT.WORK_TYPE_ID
                 AND B_WT.WORK_TYPE_GROUP  = NVL(B_OST.WORK_TYPE, B_WT.WORK_TYPE_GROUP)
                 AND B_WT.SOB_ID           = B_OST.SOB_ID
                 AND B_WT.ORG_ID           = B_OST.ORG_ID
                 AND WC.HOLY_TYPE          = B_OST.HOLY_TYPE
                 AND 'B'                   = B_OST.OT_STD_TYPE
                 AND WC.WORK_TYPE_ID       = A_WT.WORK_TYPE_ID
                 AND A_WT.WORK_TYPE_GROUP  = NVL(A_OST.WORK_TYPE, A_WT.WORK_TYPE_GROUP)
                 AND A_WT.SOB_ID           = A_OST.SOB_ID
                 AND A_WT.ORG_ID           = A_OST.ORG_ID
                 AND WC.HOLY_TYPE          = A_OST.HOLY_TYPE
                 AND 'A'                   = A_OST.OT_STD_TYPE
                 AND PM.WORK_CORP_ID       = W_CORP_ID
                 AND PM.PERSON_ID          = NVL(W_PERSON_ID, PM.PERSON_ID)
                 AND PM.WORK_TYPE_ID       = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                 AND PM.SOB_ID             = W_SOB_ID
                 AND PM.ORG_ID             = W_ORG_ID
                 AND PM.ORI_JOIN_DATE                          <= W_STD_DATE
                 AND(PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
                 --AND PM.EMPLOYE_TYPE                             = '1' [2011-09-08] 주석
                 AND EXISTS ( SELECT 'X'
                                FROM HRD_DUTY_MANAGER              DM
                              --WHERE DM.CORP_ID                  = PM.CORP_ID
                               WHERE DM.CORP_ID                  = PM.WORK_CORP_ID --< [2011-06-25]수정
                                 AND DM.DUTY_CONTROL_ID          = T2.FLOOR_ID
                                 AND DM.WORK_TYPE_ID             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                                 AND DM.SOB_ID                   = PM.SOB_ID
                                 AND DM.ORG_ID                   = PM.ORG_ID
                                 AND DM.DUTY_MANAGER_ID          = W_DUTY_MANAGER_ID
                                 AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                                 AND DM.START_DATE                      <= W_STD_DATE
                                 AND(DM.END_DATE IS NULL OR DM.END_DATE >= W_STD_DATE)
                            )
            ORDER BY PM.WORK_TYPE_ID
                   , PM.NAME
                   ;

   END DATA_INSERT_SELECT;



-- DATA INSERT.
  PROCEDURE DATA_INSERT
            ( P_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_REQ_NUM                               IN HRD_OT_LINE.REQ_NUM%TYPE
            , P_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
            , P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
            , P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
            , P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
            , P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
            , P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
            , W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            , O_OT_LINE_ID                            OUT HRD_OT_LINE.OT_LINE_ID%TYPE
            )
  AS
    D_SYSDATE                                         HRD_OT_HEADER.CREATION_DATE%TYPE;
    V_OT_LINE_ID                                      HRD_OT_LINE.OT_LINE_ID%TYPE;
  
  BEGIN
    IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(P_OT_HEADER_ID)= 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삽입'));
    END IF;
    BEGIN
        D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
        SELECT HRD_OT_LINE_S1.NEXTVAL
       INTO V_OT_LINE_ID
       FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삽입'));
    END;   

    INSERT INTO HRD_OT_LINE
    (OT_LINE_ID, OT_HEADER_ID, REQ_NUM
    , PERSON_ID, WORK_DATE
    , BEFORE_OT_START, BEFORE_OT_END
    , AFTER_OT_START, AFTER_OT_END
    , LUNCH_YN, DINNER_YN, MIDNIGHT_YN
    , DANGJIK_YN, ALL_NIGHT_YN
    , DESCRIPTION
    , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
    ) VALUES
    ( V_OT_LINE_ID, P_OT_HEADER_ID, P_REQ_NUM
    , P_PERSON_ID, P_WORK_DATE
    , P_BEFORE_OT_START, P_BEFORE_OT_END
    , P_AFTER_OT_START, P_AFTER_OT_END
    , P_LUNCH_YN, P_DINNER_YN, P_MIDNIGHT_YN
    , P_DANGJIK_YN, P_ALL_NIGHT_YN
    , P_DESCRIPTION
    , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
    );

    -- 라인 일련번호 생성.
    UPDATE HRD_OT_LINE OL
        SET OL.LINE_SEQ                         = ROWNUM
      WHERE OL.OT_HEADER_ID                     = P_OT_HEADER_ID
      ;

      UPDATE HRD_OT_HEADER    OH
        SET OH.ATTRIBUTE1   = TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD')
      WHERE OH.OT_HEADER_ID = P_OT_HEADER_ID
      ;
  O_OT_LINE_ID := V_OT_LINE_ID;
  
  END DATA_INSERT;

-- DATA UPDATE.
  PROCEDURE DATA_UPDATE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            , P_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
            , P_BEFORE_OT_START                       IN HRD_OT_LINE.BEFORE_OT_START%TYPE
            , P_BEFORE_OT_END                         IN HRD_OT_LINE.BEFORE_OT_END%TYPE
            , P_AFTER_OT_START                        IN HRD_OT_LINE.AFTER_OT_START%TYPE
            , P_AFTER_OT_END                          IN HRD_OT_LINE.AFTER_OT_END%TYPE
            , P_LUNCH_YN                              IN HRD_OT_LINE.LUNCH_YN%TYPE
            , P_DINNER_YN                             IN HRD_OT_LINE.DINNER_YN%TYPE
            , P_MIDNIGHT_YN                           IN HRD_OT_LINE.MIDNIGHT_YN%TYPE
            , P_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
            , P_DESCRIPTION                           IN HRD_OT_LINE.DESCRIPTION%TYPE
            , P_USER_ID                               IN HRD_OT_LINE.CREATED_BY%TYPE
            , W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
            )
  AS
  BEGIN
    IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(W_OT_HEADER_ID) = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=수정'));
    END IF;

    UPDATE HRD_OT_LINE OL
      SET OL.WORK_DATE                        = P_WORK_DATE
        , OL.BEFORE_OT_START                  = P_BEFORE_OT_START
        , OL.BEFORE_OT_END                    = P_BEFORE_OT_END
        , OL.AFTER_OT_START                   = P_AFTER_OT_START 
        , OL.AFTER_OT_END                     = P_AFTER_OT_END
        , OL.LUNCH_YN                         = P_LUNCH_YN
        , OL.DINNER_YN                        = P_DINNER_YN 
        , OL.MIDNIGHT_YN                      = P_MIDNIGHT_YN
        , OL.DANGJIK_YN                       = P_DANGJIK_YN
        , OL.ALL_NIGHT_YN                     = P_ALL_NIGHT_YN
        , OL.DESCRIPTION                      = P_DESCRIPTION
        , OL.LAST_UPDATE_DATE                 = GET_LOCAL_DATE(W_SOB_ID)
        , OL.LAST_UPDATED_BY                  = P_USER_ID
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;

    UPDATE HRD_OT_HEADER    OH
      SET OH.ATTRIBUTE1   = TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD')
    WHERE OH.OT_HEADER_ID = W_OT_HEADER_ID
    ;
  END DATA_UPDATE;

-- DATA DELETE.
  PROCEDURE DATA_DELETE
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
            , W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
            )
  AS
  BEGIN
    
    IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(W_OT_HEADER_ID)= 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삭제'));
    END IF;
    
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10013'));
    
    DELETE HRD_OT_LINE OL
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;
  
  END DATA_DELETE;

-- DATA DELETE(승인이 되었어도 삭제).
  PROCEDURE DATA_DELETE_C
            ( W_OT_LINE_ID                            IN HRD_OT_LINE.OT_LINE_ID%TYPE
            )
  AS
  BEGIN
    RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10013'));
    
    DELETE HRD_OT_LINE OL
    WHERE OL.OT_LINE_ID                       = W_OT_LINE_ID
    ;
  END DATA_DELETE_C;
  
   
-- LINE DATA COUNT.
  PROCEDURE DATA_LINE_COUNT
           ( W_OT_HEADER_ID                          IN HRD_OT_LINE.OT_HEADER_ID%TYPE
      , O_RECORD_COUNT                          OUT NUMBER
      )
  AS
   V_RECORD_COUNT                                    NUMBER := 0;
  
 BEGIN
   BEGIN
    SELECT COUNT(OL.PERSON_ID)
     INTO V_RECORD_COUNT
     FROM HRD_OT_LINE OL
    WHERE OL.OT_HEADER_ID                         = W_OT_HEADER_ID
   ;
  EXCEPTION WHEN OTHERS THEN
    V_RECORD_COUNT := 0;
  END;
   O_RECORD_COUNT := V_RECORD_COUNT;
  
 END; 

       -- COUNT_DATA_LINE[2011-07-25]
       PROCEDURE COUNT_DATA_LINE
               ( W_CORP_ID           IN   HRD_OT_HEADER.CORP_ID%TYPE
               , W_WORK_DATE         IN   HRD_OT_LINE.WORK_DATE%TYPE
               , W_DUTY_MANAGER_ID   IN   HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
               , W_WORK_TYPE_ID      IN   HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
               , W_REQ_TYPE          IN   HRD_OT_HEADER.REQ_TYPE%TYPE
               , O_RECORD_COUNT      OUT  NUMBER
               )

       AS

                 V_RECORD_COUNT      NUMBER := 0;

       BEGIN
             BEGIN
                   SELECT COUNT(OL.PERSON_ID)
                     INTO V_RECORD_COUNT
                     FROM HRD_OT_LINE           OL
                        , HRD_OT_HEADER         OH
                        , HRM_PERSON_MASTER     PM
                    WHERE OL.OT_HEADER_ID    =  OH.OT_HEADER_ID
                      AND OL.PERSON_ID       =  PM.PERSON_ID
                      AND OH.REQ_TYPE        =  NVL(W_REQ_TYPE, OH.REQ_TYPE)
                      AND OH.CORP_ID         =  W_CORP_ID
                      AND OL.WORK_DATE       =  W_WORK_DATE
                      AND OH.DUTY_MANAGER_ID =  W_DUTY_MANAGER_ID
                      AND PM.WORK_TYPE_ID    =  NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                     -- AND OH.REQ_PERSON_ID   =  W_REQ_PERSON_ID -- [2011-08-03] 삭제
                        ;

                   EXCEPTION
                        WHEN OTHERS THEN
                             V_RECORD_COUNT := 0;
             END;
             
             IF W_REQ_TYPE ='A' THEN
                V_RECORD_COUNT := 0;
             END IF;
             /*V_RECORD_COUNT := 0;*/
             O_RECORD_COUNT := V_RECORD_COUNT;

       END COUNT_DATA_LINE;


-- DATA SELECT OT TIME.
   PROCEDURE OT_STD_TIME_O
           ( W_CORP_ID                               IN HRD_OT_HEADER.CORP_ID%TYPE
           , W_PERSON_ID                             IN HRD_OT_LINE.PERSON_ID%TYPE
           , W_WORK_DATE                             IN HRD_OT_LINE.WORK_DATE%TYPE
           , W_DANGJIK_YN                            IN HRD_OT_LINE.DANGJIK_YN%TYPE
           , W_ALL_NIGHT_YN                          IN HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , W_SOB_ID                                IN HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID                                IN HRD_OT_HEADER.ORG_ID%TYPE
           , O_BEFORE_OT_START                       OUT HRD_OT_LINE.BEFORE_OT_START%TYPE
           , O_BEFORE_OT_END                         OUT HRD_OT_LINE.BEFORE_OT_END%TYPE
           , O_AFTER_OT_START                        OUT HRD_OT_LINE.AFTER_OT_START%TYPE
           , O_AFTER_OT_END                          OUT HRD_OT_LINE.AFTER_OT_END%TYPE
           )
   AS

           V_BEFORE_OT_START                                 HRD_OT_LINE.BEFORE_OT_START%TYPE := NULL;
           V_BEFORE_OT_END                                   HRD_OT_LINE.BEFORE_OT_END%TYPE := NULL;
           V_AFTER_OT_START                                  HRD_OT_LINE.AFTER_OT_START%TYPE := NULL;
           V_AFTER_OT_END                                    HRD_OT_LINE.AFTER_OT_END%TYPE := NULL;

  BEGIN
       BEGIN
          SELECT TO_DATE(TO_CHAR(W_WORK_DATE + B_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || B_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS BEFORE_OT_START
               , TO_DATE(TO_CHAR(W_WORK_DATE + B_OST.END_ADD_DAY,   'YYYY-MM-DD') ||  ' ' || B_OST.END_TIME,   'YYYY-MM-DD HH24:MI') AS BEFORE_OT_END
               , TO_DATE(TO_CHAR(W_WORK_DATE + A_OST.START_ADD_DAY, 'YYYY-MM-DD') ||  ' ' || A_OST.START_TIME, 'YYYY-MM-DD HH24:MI') AS AFTER_OT_START
               , TO_DATE(TO_CHAR(W_WORK_DATE + A_OST.END_ADD_DAY,   'YYYY-MM-DD') ||  ' ' || A_OST.END_TIME,   'YYYY-MM-DD HH24:MI') AS AFTER_OT_END
           INTO  V_BEFORE_OT_START
               , V_BEFORE_OT_END
               , V_AFTER_OT_START
               , V_AFTER_OT_END
            FROM HRD_WORK_CALENDAR  WC
               , HRM_OT_STD_TIME_V  B_OST
               , HRM_OT_STD_TIME_V  A_OST
           WHERE WC.ATTRIBUTE5                              = NVL(B_OST.WORK_TYPE, WC.ATTRIBUTE5)
             AND WC.HOLY_TYPE                               = B_OST.HOLY_TYPE
             AND 'B'                                        = B_OST.OT_STD_TYPE
             AND WC.SOB_ID                                  = B_OST.SOB_ID
             AND WC.ORG_ID                                  = B_OST.ORG_ID
             AND WC.ATTRIBUTE5                              = NVL(A_OST.WORK_TYPE, WC.ATTRIBUTE5)
             AND DECODE(W_ALL_NIGHT_YN, 'Y', 'ALL_NIGHT', DECODE(W_DANGJIK_YN, 'Y', 'DANGJIK', WC.HOLY_TYPE)) = A_OST.HOLY_TYPE
             AND 'A'                                        = A_OST.OT_STD_TYPE
             AND WC.SOB_ID                                  = A_OST.SOB_ID
             AND WC.ORG_ID                                  = A_OST.ORG_ID
             AND WC.WORK_DATE                               = W_WORK_DATE
             AND WC.PERSON_ID                               = W_PERSON_ID
             AND WC.WORK_CORP_ID                            = W_CORP_ID
             AND WC.SOB_ID                                  = W_SOB_ID
             AND WC.ORG_ID                                  = W_ORG_ID
               ;

   EXCEPTION WHEN OTHERS THEN
    V_BEFORE_OT_START := NULL;
    V_BEFORE_OT_END   := NULL;
    V_AFTER_OT_START  := NULL;
    V_AFTER_OT_END    := NULL;
   END;

   O_BEFORE_OT_START := V_BEFORE_OT_START;
   O_BEFORE_OT_END   := V_BEFORE_OT_END;
   O_AFTER_OT_START  := V_AFTER_OT_START;
   O_AFTER_OT_END    := V_AFTER_OT_END;

 END OT_STD_TIME_O;


--[2011-10-14]
-------------------------------------------------------------------------------
-- 연장근무 신청 라인 조회.
  PROCEDURE OT_LINE_RETURN_SELECT
           ( P_CURSOR1        OUT  TYPES.TCURSOR1
           , W_OT_HEADER_ID   IN   HRD_OT_LINE.OT_HEADER_ID%TYPE
           , W_WORK_DATE      IN   HRD_OT_LINE.WORK_DATE%TYPE
           )

   AS

   BEGIN
           OPEN P_CURSOR1 FOR
           SELECT OL.REJECT_REMARK
                , PM.PERSON_NUM AS PERSON_NUMBER
                , PM.NAME       AS PERSON_NAME
                , HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID) AS WORK_TYPE
                , OL.ALL_NIGHT_YN
                , TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI')  AS BEFORE_OT_START
                , TO_CHAR(OL.BEFORE_OT_END,   'HH24:MI')  AS BEFORE_OT_END
                , OL.AFTER_OT_START                       AS AFTER_OT_START    
                , OL.AFTER_OT_END                         AS AFTER_OT_END
                , CASE WHEN WC.ATTRIBUTE3 = '2' AND TO_CHAR(OL.AFTER_OT_END,    'HH24:MI') <> '21:00' THEN 'Y' --'추가연장'
                       WHEN WC.ATTRIBUTE3 = '3' AND TO_CHAR(OL.AFTER_OT_END,    'HH24:MI') <> '08:30' THEN 'Y' --'추가연장'
                       ELSE 'N'
                  END AS MODIFIED_AFTER
                , CASE WHEN TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI') < TO_CHAR(OL.BEFORE_OT_END, 'HH24:MI') THEN 'Y' --'조기출근'
                       WHEN TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI') < TO_CHAR(OL.BEFORE_OT_END, 'HH24:MI') THEN 'Y' --'조기출근'
                       ELSE 'N'
                  END AS MODIFIED_BEFORE
                , OL.LUNCH_YN
                , OL.DINNER_YN
                , OL.MIDNIGHT_YN
                , OL.BREAKFAST_YN
                , OL.DANGJIK_YN
                , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME
                , SUBSTR(TO_CHAR(OL.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS WEEK
                , OL.WORK_DATE
                , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
                , OL.DESCRIPTION
                , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                , PM.JOIN_DATE
                , PM.RETIRE_DATE
                , OL.REQ_NUM
                , OL.LINE_SEQ
                , OL.PERSON_ID
                , OL.OT_LINE_ID
                , OL.OT_HEADER_ID
             FROM HRD_OT_LINE           OL
                , HRM_PERSON_MASTER     PM
                , (-- 시점 인사내역.
                   SELECT HL.PERSON_ID
                        , HL.POST_ID
                        , HL.JOB_CATEGORY_ID
                        , HL.JOB_CLASS_ID
                        , HL.OCPT_ID
                     FROM HRM_HISTORY_LINE    HL
                    WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                     FROM HRM_HISTORY_LINE             S_HL
                                                    WHERE S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      AND S_HL.PERSON_ID             = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                                 )
                  ) T1
                , (-- 시점 인사내역.
                   SELECT PH.PERSON_ID
                        , PH.FLOOR_ID
                        , PH.WORK_TYPE_ID
                        , PH.DEPT_ID
                     FROM HRD_PERSON_HISTORY        PH
                    WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                      AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                  ) T2
                , HRD_OT_HEADER         OH
                , HRD_WORK_CALENDAR     WC
            WHERE OL.PERSON_ID      =   PM.PERSON_ID
              AND PM.PERSON_ID      =   T1.PERSON_ID
              AND PM.PERSON_ID      =   T2.PERSON_ID
              AND OL.REQ_NUM        =   OH.REQ_NUM
              AND OL.WORK_DATE      =   WC.WORK_DATE
              AND OL.PERSON_ID      =   WC.PERSON_ID
              AND OH.CORP_ID        =   WC.WORK_CORP_ID
              AND OH.SOB_ID         =   WC.SOB_ID
              AND OH.ORG_ID         =   WC.ORG_ID
              AND OH.OT_HEADER_ID   =   W_OT_HEADER_ID
         ORDER BY T2.WORK_TYPE_ID
                , PM.NAME
                ;

   END OT_LINE_RETURN_SELECT;


-- 연장근무 반려 적용.
   PROCEDURE OT_LINE_RETURN_UPDATE
           ( W_OT_LINE_ID          IN   HRD_OT_LINE.OT_LINE_ID%TYPE
           , W_OT_HEADER_ID        IN   HRD_OT_LINE.OT_HEADER_ID%TYPE
           , P_REJECT_REMARK       IN   HRD_OT_LINE.REJECT_REMARK%TYPE
           , P_CONNECT_PERSON_ID   IN   HRM_PERSON_MASTER.PERSON_ID%TYPE
           , P_SOB_ID              IN   HRD_OT_HEADER.SOB_ID%TYPE
           )
   AS

   BEGIN
           UPDATE HRD_OT_HEADER OH
              SET OH.APPROVE_STATUS     =  'R'
                , OH.EMAIL_STATUS       =  'RR'
            WHERE OH.OT_HEADER_ID       =  W_OT_HEADER_ID
                ;

           UPDATE HRD_OT_LINE OL
              SET OL.REJECT_REMARK      =  P_REJECT_REMARK
                , OL.REJECT_YN          =  'Y'
                , OL.REJECT_DATE        =  GET_LOCAL_DATE(P_SOB_ID)
                , OL.REJECT_PERSON_ID   =  P_CONNECT_PERSON_ID
            WHERE OL.OT_LINE_ID         =  W_OT_LINE_ID
                ;

           /*-- 근무 카렌다 반영 START. --*/
           UPDATE HRD_WORK_CALENDAR WC
              SET WC.BEFORE_OT_START    =  NULL
                , WC.BEFORE_OT_END      =  NULL
                , WC.AFTER_OT_START     =  NULL
                , WC.AFTER_OT_END       =  NULL
                , WC.LUNCH_YN           =  'N'
                , WC.DINNER_YN          =  'N'
                , WC.MIDNIGHT_YN        =  'N'
                , WC.DANGJIK_YN         =  'N'
                , WC.ALL_NIGHT_YN       =  'N'
            WHERE EXISTS ( SELECT 'X'
                             FROM HRD_OT_HEADER OH
                                , HRD_OT_LINE OL
                            WHERE OH.OT_HEADER_ID  =  OL.OT_HEADER_ID
                              AND OH.CORP_ID       =  WC.WORK_CORP_ID
                              AND OH.SOB_ID        =  WC.SOB_ID
                              AND OH.ORG_ID        =  WC.ORG_ID
                              AND OL.WORK_DATE     =  WC.WORK_DATE
                              AND OL.PERSON_ID     =  WC.PERSON_ID
                              AND OL.OT_LINE_ID    =  W_OT_LINE_ID
                         )
           ;

   COMMIT;

   EXCEPTION
        WHEN ERRNUMS.Approval_Nothing
        THEN
             RAISE_APPLICATION_ERROR(ERRNUMS.Approval_Nothing_Code, ERRNUMS.Approval_Nothing_Desc);

   END OT_LINE_RETURN_UPDATE;

-------------------------------------------------------------------------------


--[2011-10-14]
   PROCEDURE SELECT_OT_LINE_APPROVE
           ( P_CURSOR         OUT  TYPES.TCURSOR
           , W_OT_HEADER_ID   IN   HRD_OT_LINE.OT_HEADER_ID%TYPE
           , W_WORK_DATE      IN   HRD_OT_LINE.WORK_DATE%TYPE
           , W_PERSON_ID      IN   HRD_OT_LINE.PERSON_ID%TYPE
           )

   AS

             V_WORK_DATE            HRD_OT_LINE.WORK_DATE%TYPE;

   BEGIN
             BEGIN
                  SELECT OL.WORK_DATE
                    INTO V_WORK_DATE
                    FROM HRD_OT_LINE OL
                   WHERE OL.OT_HEADER_ID = W_OT_HEADER_ID
                     AND ROWNUM = 1
                       ;
                       
                  EXCEPTION WHEN OTHERS THEN
                  V_WORK_DATE := SYSDATE;
             END;


           OPEN P_CURSOR FOR
           SELECT HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID)    AS WORK_TYPE
                , PM.NAME       AS PERSON_NAME
                , PM.PERSON_NUM AS PERSON_NUMBER
                , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME_1
                , OL.ALL_NIGHT_YN
                , SUBSTR(TO_CHAR(OL.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS WEEK
                , OL.WORK_DATE
                , TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI')     AS BEFORE_OT_START
                , TO_CHAR(OL.BEFORE_OT_END,   'HH24:MI')     AS BEFORE_OT_END
                , OL.AFTER_OT_START                          AS AFTER_OT_START
                , OL.AFTER_OT_END                            AS AFTER_OT_END
                , CASE WHEN WC.ATTRIBUTE3 = '2' AND TO_CHAR(OL.AFTER_OT_END,    'HH24:MI') <> '21:00' THEN 'Y' --'추가연장'
                       WHEN WC.ATTRIBUTE3 = '3' AND TO_CHAR(OL.AFTER_OT_END,    'HH24:MI') <> '08:30' THEN 'Y' --'추가연장'
                       ELSE 'N'
                  END AS MODIFIED_AFTER
                , CASE WHEN TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI') < TO_CHAR(OL.BEFORE_OT_END, 'HH24:MI') THEN 'Y' --'조기출근'
                       WHEN TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI') < TO_CHAR(OL.BEFORE_OT_END, 'HH24:MI') THEN 'Y' --'조기출근'
                       ELSE 'N'
                  END AS MODIFIED_BEFORE
                , OL.LUNCH_YN
                , OL.DINNER_YN
                , OL.MIDNIGHT_YN
                , OL.BREAKFAST_YN
                , OL.DANGJIK_YN
                , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
                , OL.REJECT_REMARK
                , OL.DESCRIPTION
                , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                , PM.JOIN_DATE
                , PM.RETIRE_DATE
                , OL.REJECT_YN
                , OL.REJECT_DATE
                , HRM_PERSON_MASTER_G.NAME_F(OL.REJECT_PERSON_ID) AS REJECT_PERSON_NAME
                , OL.LINE_SEQ
                , OL.REQ_NUM
                , OH.APPROVE_STATUS
                , WC.HOLY_TYPE  AS HOLY_TYPE_1
                , WC.ATTRIBUTE3 AS HOLY_TYPE_2
                , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.ATTRIBUTE3, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME_2
                , OL.PERSON_ID
                , OL.OT_LINE_ID
                , OL.OT_HEADER_ID
                , 'Y' AS REQUEST_CHOICE
             FROM HRD_OT_LINE       OL
                , HRM_PERSON_MASTER PM
                , (-- 시점 인사내역.
                   SELECT HL.PERSON_ID
                        , HL.POST_ID
                        , HL.JOB_CATEGORY_ID
                        , HL.JOB_CLASS_ID
                        , HL.OCPT_ID
                   FROM HRM_HISTORY_LINE HL
                   WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                    FROM HRM_HISTORY_LINE        S_HL
                                                   WHERE S_HL.PERSON_ID      =   HL.PERSON_ID
                                                     AND S_HL.CHARGE_DATE   <=   V_WORK_DATE
                                                GROUP BY S_HL.PERSON_ID
                                                )
                  ) T1
                , (-- 시점 인사내역.
                   SELECT PH.PERSON_ID
                        , PH.FLOOR_ID
                        , PH.WORK_TYPE_ID
                        , PH.DEPT_ID
                     FROM HRD_PERSON_HISTORY        PH
                    WHERE PH.EFFECTIVE_DATE_FR  <=  V_WORK_DATE
                      AND PH.EFFECTIVE_DATE_TO  >=  V_WORK_DATE
                  ) T2
                , HRD_OT_HEADER         OH
                , HRD_WORK_CALENDAR     WC
            WHERE OL.PERSON_ID      =   PM.PERSON_ID
              AND PM.PERSON_ID      =   T1.PERSON_ID
              AND PM.PERSON_ID      =   T2.PERSON_ID
              AND OL.REQ_NUM        =   OH.REQ_NUM
              AND OL.WORK_DATE      =   WC.WORK_DATE
              AND OL.PERSON_ID      =   WC.PERSON_ID
              AND OH.CORP_ID        =   WC.WORK_CORP_ID
              AND OH.SOB_ID         =   WC.SOB_ID
              AND OH.ORG_ID         =   WC.ORG_ID
              AND OH.OT_HEADER_ID   =   W_OT_HEADER_ID
              AND OL.PERSON_ID      =   NVL(W_PERSON_ID, OL.PERSON_ID)
         ORDER BY T2.WORK_TYPE_ID
                , PM.NAME
                ;

   END SELECT_OT_LINE_APPROVE;


-- [2011-10-26][2011-11-29]
   PROCEDURE SELECT_OT_LINE
           ( P_CURSOR         OUT  TYPES.TCURSOR
           , W_OT_HEADER_ID   IN   HRD_OT_LINE.OT_HEADER_ID%TYPE
           , W_WORK_DATE      IN   HRD_OT_LINE.WORK_DATE%TYPE
           , W_WORK_TYPE_ID   IN   HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID      IN   HRD_OT_LINE.PERSON_ID%TYPE
           )

   AS

   BEGIN
           OPEN P_CURSOR FOR
           SELECT HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID)    AS WORK_TYPE
                , PM.NAME       AS PERSON_NAME
                , PM.PERSON_NUM AS PERSON_NUMBER
                , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME_1
                , OL.ALL_NIGHT_YN
                , SUBSTR(TO_CHAR(OL.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS WEEK
                , OL.WORK_DATE
                , NVL(OL.OT_FLAG, 'N') AS OT_FLAG  -- 연장 없음 여부 : 전호수 추가 
                , TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI')     AS BEFORE_OT_START
                , TO_CHAR(OL.BEFORE_OT_END,   'HH24:MI')     AS BEFORE_OT_END
                , TRUNC(OL.AFTER_OT_START)                   AS AFTER_OT_DATE_START
                , TO_CHAR(OL.AFTER_OT_START, 'HH24:MI')      AS AFTER_OT_TIME_START
                , TRUNC(OL.AFTER_OT_END)                     AS AFTER_OT_DATE_END
                , TO_CHAR(OL.AFTER_OT_END, 'HH24:MI')        AS AFTER_OT_TIME_END
                , CASE WHEN WC.ATTRIBUTE3 = '2' AND TO_CHAR(OL.AFTER_OT_END,    'HH24:MI') <> '21:00' THEN 'Y' --'추가연장'
                       WHEN WC.ATTRIBUTE3 = '3' AND TO_CHAR(OL.AFTER_OT_END,    'HH24:MI') <> '08:30' THEN 'Y' --'추가연장'
                       ELSE 'N'
                  END AS MODIFIED_AFTER
                , CASE WHEN TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI') < TO_CHAR(OL.BEFORE_OT_END, 'HH24:MI') THEN 'Y' --'조기출근'
                       WHEN TO_CHAR(OL.BEFORE_OT_START, 'HH24:MI') < TO_CHAR(OL.BEFORE_OT_END, 'HH24:MI') THEN 'Y' --'조기출근'
                       ELSE 'N'
                  END AS MODIFIED_BEFORE
                , OL.LUNCH_YN
                , OL.DINNER_YN
                , OL.MIDNIGHT_YN
                , OL.BREAKFAST_YN
                , OL.DANGJIK_YN
                , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', OH.APPROVE_STATUS, OH.SOB_ID, OH.ORG_ID) AS APPROVE_STATUS_NAME
                , OL.REJECT_REMARK
                , OL.DESCRIPTION
                , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                , PM.JOIN_DATE
                , PM.RETIRE_DATE
                , OL.REJECT_YN AS REJECT_YN
                , OL.REJECT_DATE
                , HRM_PERSON_MASTER_G.NAME_F(OL.REJECT_PERSON_ID) AS REJECT_PERSON_NAME
                , OL.LINE_SEQ
                , OL.REQ_NUM
                , OH.APPROVE_STATUS
                , WC.HOLY_TYPE  AS HOLY_TYPE_1
                , WC.ATTRIBUTE3 AS HOLY_TYPE_2
                , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.ATTRIBUTE3, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME_2
                , OL.PERSON_ID
                , OL.OT_LINE_ID
                , OL.OT_HEADER_ID
                , 'Y' AS REQUEST_CHOICE
             FROM HRD_OT_LINE       OL
                , HRM_PERSON_MASTER PM
                , (-- 시점 인사내역.
                   SELECT HL.PERSON_ID
                        , HL.POST_ID
                        , HL.JOB_CATEGORY_ID
                        , HL.JOB_CLASS_ID
                        , HL.OCPT_ID
                   FROM HRM_HISTORY_LINE HL
                   WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                    FROM HRM_HISTORY_LINE        S_HL
                                                   WHERE S_HL.PERSON_ID      =   HL.PERSON_ID
                                                     AND S_HL.CHARGE_DATE   <=   W_WORK_DATE
                                                GROUP BY S_HL.PERSON_ID
                                                )
                  ) T1
                , (-- 시점 인사내역.
                   SELECT PH.PERSON_ID
                        , PH.FLOOR_ID
                        , PH.WORK_TYPE_ID
                        , PH.DEPT_ID
                     FROM HRD_PERSON_HISTORY        PH
                    WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                      AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                  ) T2
                , HRD_OT_HEADER         OH
                , HRD_WORK_CALENDAR     WC
            WHERE OL.PERSON_ID      =   PM.PERSON_ID
              AND PM.PERSON_ID      =   T1.PERSON_ID
              AND PM.PERSON_ID      =   T2.PERSON_ID
              AND OL.REQ_NUM        =   OH.REQ_NUM
              AND OL.WORK_DATE      =   WC.WORK_DATE
              AND OL.PERSON_ID      =   WC.PERSON_ID
              AND OH.CORP_ID        =   WC.WORK_CORP_ID
              AND OH.SOB_ID         =   WC.SOB_ID
              AND OH.ORG_ID         =   WC.ORG_ID
              AND OH.OT_HEADER_ID   =   W_OT_HEADER_ID
              AND OL.PERSON_ID      =   NVL(W_PERSON_ID, OL.PERSON_ID)
              AND T2.WORK_TYPE_ID   =   NVL(W_WORK_TYPE_ID, T2.WORK_TYPE_ID)
         ORDER BY T2.WORK_TYPE_ID
                , PM.NAME
                ;


   END SELECT_OT_LINE;



-- [2011-10-27][2011-11-29]
   PROCEDURE SELECT_OT_INSERT_SELECT
           ( P_CURSOR             OUT TYPES.TCURSOR
           , W_SOB_ID             IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_OT_HEADER.ORG_ID%TYPE
           , W_CORP_ID            IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_OT_HEADER_ID       IN  HRD_OT_HEADER.OT_HEADER_ID%TYPE
           , W_STD_DATE           IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DUTY_MANAGER_ID    IN  HRD_OT_HEADER.DUTY_MANAGER_ID%TYPE
           , W_WORK_TYPE_ID       IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRD_OT_HEADER.REQ_PERSON_ID%TYPE
           )

   AS
             V_CONNECT_PERSON_ID      HRD_OT_HEADER.REQ_PERSON_ID%TYPE := NULL;
             V_REQ_NUM                VARCHAR2(30);
             V_RECORD_COUNT           NUMBER := 0;

   BEGIN
             V_CONNECT_PERSON_ID   := W_CONNECT_PERSON_ID;
             
             BEGIN
              SELECT MAX(OH.REQ_NUM) AS REQ_NUM
                   , COUNT(*) AS RECORD_COUNT
                INTO V_REQ_NUM
                   , V_RECORD_COUNT
                FROM HRD_OT_HEADER OH
              WHERE OH.DUTY_MANAGER_ID    = W_DUTY_MANAGER_ID
                AND OH.SOB_ID             = W_SOB_ID
                AND OH.ORG_ID             = W_ORG_ID
                AND OH.APPROVE_STATUS     = 'R'
                AND NVL(TO_DATE(OH.ATTRIBUTE1, 'YYYY-MM-DD'), OH.REQ_DATE)  BETWEEN TRUNC(W_STD_DATE, 'MONTH') AND LAST_DAY(W_STD_DATE)  -- 실제 근무일자를 ATTRIBUTE1에 저장함. 
              ;
            EXCEPTION WHEN OTHERS THEN
              V_RECORD_COUNT := 0;
            END;
            IF V_RECORD_COUNT != 0 THEN
              RAISE_APPLICATION_ERROR(-20001, '[' || V_REQ_NUM || '] ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10466'));
              RETURN;
            END IF;
                  
            OPEN P_CURSOR FOR
             SELECT HRM_COMMON_G.ID_NAME_F(T2.WORK_TYPE_ID)    AS WORK_TYPE
                  , PM.NAME         AS PERSON_NAME
                  , PM.PERSON_NUM   AS PERSON_NUMBER
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.HOLY_TYPE, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME_1
                  , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                              CASE WHEN WC.ATTRIBUTE3 = '3' THEN 'Y'
                                   ELSE 'N'
                              END
                         ELSE 'N'
                    END AS ALL_NIGHT_YN
                  , SUBSTR(TO_CHAR(W_STD_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)      AS WEEK
                  , W_STD_DATE       AS WORK_DATE 
                  , 'N' AS OT_FLAG  -- 연장 없음 여부 : 전호수 추가 
                  , B_OST.START_TIME AS BEFORE_OT_START
                  , B_OST.END_TIME   AS BEFORE_OT_END
                  , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                              CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT W_STD_DATE + S_OST.START_ADD_DAY AS AFTER_OT_DATE_START
                                                                    FROM HRD_WORK_CALENDAR     S_WC
                                                                       , HRM_OT_STD_TIME_V     S_OST
                                                                   WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                     AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                     AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                     AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                     AND S_WC.WORK_DATE       =  W_STD_DATE
                                                                     AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                     AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                     AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                     AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                     AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                                 )
                                   ELSE W_STD_DATE + A_OST.START_ADD_DAY
                              END
                         ELSE W_STD_DATE + A_OST.START_ADD_DAY
                    END AS AFTER_OT_DATE_START
                  , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                              CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT S_OST.START_TIME   AS AFTER_OT_TIME_START
                                                                    FROM HRD_WORK_CALENDAR     S_WC
                                                                       , HRM_OT_STD_TIME_V     S_OST
                                                                   WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                     AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                     AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                     AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                     AND S_WC.WORK_DATE       =  W_STD_DATE
                                                                     AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                     AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                     AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                     AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                     AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                                 )
                                   ELSE A_OST.START_TIME
                              END
                         ELSE A_OST.START_TIME
                    END AS AFTER_OT_TIME_START
                  , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                              CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT W_STD_DATE + S_OST.END_ADD_DAY AS AFTER_OT_DATE_END
                                                                    FROM HRD_WORK_CALENDAR     S_WC
                                                                       , HRM_OT_STD_TIME_V     S_OST
                                                                   WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                     AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                     AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                     AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                     AND S_WC.WORK_DATE       =  W_STD_DATE
                                                                     AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                     AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                     AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                     AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                     AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                                 )
                                   ELSE W_STD_DATE + A_OST.END_ADD_DAY
                              END
                         ELSE W_STD_DATE + A_OST.END_ADD_DAY
                    END AS AFTER_OT_DATE_END
                  , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                              CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT S_OST.END_TIME     AS AFTER_OT_TIME_END
                                                                    FROM HRD_WORK_CALENDAR     S_WC
                                                                       , HRM_OT_STD_TIME_V     S_OST
                                                                   WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                     AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                     AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                     AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                     AND S_WC.WORK_DATE       =  W_STD_DATE
                                                                     AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                     AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                     AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                     AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                     AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                                 )
                                   ELSE A_OST.END_TIME
                              END
                         ELSE A_OST.END_TIME
                    END AS AFTER_OT_TIME_END
                  , 'N'             AS MODIFIED_AFTER
                  , 'N'             AS MODIFIED_BEFORE
                  , 'N'             AS LUNCH_YN
                  , 'N'             AS DINNER_YN
                  , 'N'             AS MIDNIGHT_YN
                  , 'N'             AS BREAKFAST_YN
                  , 'N'             AS DANGJIK_YN
                  , HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', 'N', PM.SOB_ID, PM.ORG_ID) AS APPROVE_STATUS_NAME
                  , NULL            AS REJECT_REMARK
                  , NULL            AS DESCRIPTION
                  , HRM_CORP_MASTER_G.CORP_NAME_F(PM.CORP_ID)  AS CORP_NAME
                  , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                  , HRM_DEPT_MASTER_G.DEPT_NAME_F(T2.DEPT_ID)  AS DEPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID )   AS JOB_CLASS_NAME
                  , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                  , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , NULL            AS REJECT_YN
                  , NULL            AS REJECT_DATE
                  , NULL            AS REJECT_PERSON_NAME
                  , 0               AS LINE_SEQ
                  , 0               AS REQ_NUM
                  , 'N'             AS APPROVE_STATUS
                  , WC.HOLY_TYPE    AS HOLY_TYPE_1
                  , WC.ATTRIBUTE3   AS HOLY_TYPE_2
                  , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', WC.ATTRIBUTE3, WC.SOB_ID, WC.ORG_ID) AS HOLY_NAME_2
                  , PM.PERSON_ID    AS PERSON_ID
                  , NULL            AS OT_LINE_ID
                  , W_OT_HEADER_ID  AS OT_HEADER_ID
                  , 'Y'             AS REQUEST_CHOICE
                 FROM HRM_PERSON_MASTER        PM
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
                                                           AND S_HL.CHARGE_DATE          <= W_STD_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                  )
                      )                        T1
                    , (-- 시점 인사내역.
                       SELECT PH.PERSON_ID
                            , PH.FLOOR_ID
                            , PH.WORK_TYPE_ID
                            , PH.DEPT_ID
                         FROM HRD_PERSON_HISTORY        PH
                        WHERE PH.EFFECTIVE_DATE_FR  <=  W_STD_DATE
                          AND PH.EFFECTIVE_DATE_TO  >=  W_STD_DATE
                      )                        T2
                    , HRD_WORK_CALENDAR        WC
                    , HRM_WORK_TYPE_V          B_WT
                    , HRM_OT_STD_TIME_V        B_OST
                    , HRM_WORK_TYPE_V          A_WT
                    , HRM_OT_STD_TIME_V        A_OST
                 WHERE W_STD_DATE            = WC.WORK_DATE
                   AND PM.PERSON_ID          = T1.PERSON_ID(+)
                   AND PM.PERSON_ID          = T2.PERSON_ID(+)
                   AND PM.PERSON_ID          = WC.PERSON_ID
                   AND PM.WORK_CORP_ID       = WC.WORK_CORP_ID
                   AND PM.SOB_ID             = WC.SOB_ID
                   AND PM.ORG_ID             = WC.ORG_ID
                   AND WC.WORK_TYPE_ID       = B_WT.WORK_TYPE_ID
                   AND B_WT.WORK_TYPE_GROUP  = NVL(B_OST.WORK_TYPE, B_WT.WORK_TYPE_GROUP)
                   AND B_WT.SOB_ID           = B_OST.SOB_ID
                   AND B_WT.ORG_ID           = B_OST.ORG_ID
                   AND WC.ATTRIBUTE3         = B_OST.HOLY_TYPE
                   AND 'B'                   = B_OST.OT_STD_TYPE
                   AND WC.WORK_TYPE_ID       = A_WT.WORK_TYPE_ID
                   AND A_WT.WORK_TYPE_GROUP  = NVL(A_OST.WORK_TYPE, A_WT.WORK_TYPE_GROUP)
                   AND A_WT.SOB_ID           = A_OST.SOB_ID
                   AND A_WT.ORG_ID           = A_OST.ORG_ID
                   AND WC.HOLY_TYPE          = A_OST.HOLY_TYPE
                   AND 'A'                   = A_OST.OT_STD_TYPE
                   AND PM.WORK_CORP_ID       = W_CORP_ID
                   AND PM.PERSON_ID          = NVL(W_PERSON_ID, PM.PERSON_ID)
                   AND T2.WORK_TYPE_ID       = NVL(W_WORK_TYPE_ID, T2.WORK_TYPE_ID)
                   AND PM.SOB_ID             = W_SOB_ID
                   AND PM.ORG_ID             = W_ORG_ID
                   AND PM.ORI_JOIN_DATE                          <= W_STD_DATE
                   AND(PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_STD_DATE)
                   AND EXISTS ( SELECT 'X'
                                  FROM HRD_DUTY_MANAGER              DM
                                 WHERE DM.CORP_ID                  = PM.WORK_CORP_ID
                                   AND DM.DUTY_CONTROL_ID          = T2.FLOOR_ID
                                   AND DM.SOB_ID                   = PM.SOB_ID
                                   AND DM.ORG_ID                   = PM.ORG_ID
                                   AND DM.WORK_TYPE_ID             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, PM.WORK_TYPE_ID)
                                   AND DM.DUTY_MANAGER_ID          = W_DUTY_MANAGER_ID
                                   AND NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1) IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2)
                                   AND DM.START_DATE                      <= W_STD_DATE
                                   AND(DM.END_DATE IS NULL OR DM.END_DATE >= W_STD_DATE)
                              )
              ORDER BY T2.WORK_TYPE_ID
                     , PM.NAME
                     ;


   END SELECT_OT_INSERT_SELECT;


-- [2014-06-14][2011-11-29] : 연장여부에 따라 연장 시간 리턴 
   PROCEDURE GET_OT_TIME
           ( O_STATUS             OUT VARCHAR2
           , O_MESSAGE            OUT VARCHAR2 
           , W_SOB_ID             IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_OT_HEADER.ORG_ID%TYPE
           , W_OT_HEADER_ID       IN  HRD_OT_HEADER.OT_HEADER_ID%TYPE 
           , W_OT_FLAG            IN  HRD_OT_LINE.OT_FLAG%TYPE 
           , W_WORK_DATE          IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_PERSON_ID          IN  HRD_OT_LINE.PERSON_ID%TYPE 
           , O_BF_START_TIME      OUT VARCHAR2
           , O_BF_END_TIME        OUT VARCHAR2            
           , O_START_DATE         OUT DATE 
           , O_START_TIME         OUT VARCHAR2 
           , O_END_DATE           OUT DATE
           , O_END_TIME           OUT VARCHAR2 
           )
   AS
   BEGIN
     O_STATUS := 'F';
     IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(W_OT_HEADER_ID)= 'Y' THEN
       O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Modify');
       RETURN;
     END IF;
      
     IF W_OT_FLAG = 'Y' THEN
       BEGIN
         SELECT TO_CHAR(WC.OPEN_TIME, 'HH24:MI') AS BF_START_TIME 
              , TO_CHAR(WC.OPEN_TIME, 'HH24:MI') AS BF_END_TIME
              , TRUNC(WC.CLOSE_TIME) AS START_DATE 
              , TO_CHAR(WC.CLOSE_TIME, 'HH24:MI') AS START_TIME
              , TRUNC(WC.CLOSE_TIME) AS END_TIME 
              , TO_CHAR(WC.CLOSE_TIME, 'HH24:MI') AS END_TIME
           INTO O_BF_START_TIME
              , O_BF_END_TIME
              , O_START_DATE
              , O_START_TIME
              , O_END_DATE
              , O_END_TIME 
           FROM HRD_WORK_CALENDAR WC
          WHERE WC.WORK_DATE      = W_WORK_DATE
            AND WC.PERSON_ID      = W_PERSON_ID
            AND WC.SOB_ID         = W_SOB_ID 
            AND WC.ORG_ID         = W_ORG_ID 
          ;
       EXCEPTION
         WHEN OTHERS THEN
           O_BF_START_TIME := '00:00';
           O_BF_END_TIME   := '00:00';
           O_START_DATE    := TRUNC(W_WORK_DATE);
           O_START_TIME    := '00:00';
           O_END_DATE      := TRUNC(W_WORK_DATE);
           O_END_TIME      := '00:00';
       END;
     ELSE
       BEGIN
         SELECT B_OST.START_TIME AS BEFORE_OT_START
              , B_OST.END_TIME   AS BEFORE_OT_END
              , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                          CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT W_WORK_DATE + S_OST.START_ADD_DAY AS AFTER_OT_DATE_START
                                                                FROM HRD_WORK_CALENDAR     S_WC
                                                                   , HRM_OT_STD_TIME_V     S_OST
                                                               WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                 AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                 AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                 AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                 
                                                                 AND S_WC.WORK_DATE       =  W_WORK_DATE
                                                                 
                                                                 AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                 AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                 AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                 AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                 AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                             )
                               ELSE W_WORK_DATE + A_OST.START_ADD_DAY
                          END
                     ELSE W_WORK_DATE + A_OST.START_ADD_DAY
                END AS AFTER_OT_DATE_START
              , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                          CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT S_OST.START_TIME   AS AFTER_OT_TIME_START
                                                                FROM HRD_WORK_CALENDAR     S_WC
                                                                   , HRM_OT_STD_TIME_V     S_OST
                                                               WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                 AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                 AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                 AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                 
                                                                 AND S_WC.WORK_DATE       =  W_WORK_DATE 
                                                                 
                                                                 AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                 AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                 AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                 AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                 AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                             )
                               ELSE A_OST.START_TIME
                          END
                     ELSE A_OST.START_TIME
                END AS AFTER_OT_TIME_START
              , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                          CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT W_WORK_DATE + S_OST.END_ADD_DAY AS AFTER_OT_DATE_END
                                                                FROM HRD_WORK_CALENDAR     S_WC
                                                                   , HRM_OT_STD_TIME_V     S_OST
                                                               WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                 AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                 AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                 AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                 
                                                                 AND S_WC.WORK_DATE       =  W_WORK_DATE
                                                                 
                                                                 AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                 AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                 AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                 AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                 AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                             )
                               ELSE W_WORK_DATE + A_OST.END_ADD_DAY
                          END
                     ELSE W_WORK_DATE + A_OST.END_ADD_DAY
                END AS AFTER_OT_DATE_END
              , CASE WHEN WC.HOLY_TYPE = '0' OR WC.HOLY_TYPE = '1' THEN
                          CASE WHEN WC.ATTRIBUTE3 = '3' THEN (SELECT S_OST.END_TIME     AS AFTER_OT_TIME_END
                                                                FROM HRD_WORK_CALENDAR     S_WC
                                                                   , HRM_OT_STD_TIME_V     S_OST
                                                               WHERE S_WC.ATTRIBUTE5      =  NVL(S_OST.WORK_TYPE, S_WC.ATTRIBUTE5)
                                                                 AND 'A'                  =  S_OST.OT_STD_TYPE
                                                                 AND S_WC.SOB_ID          =  S_OST.SOB_ID
                                                                 AND S_WC.ORG_ID          =  S_OST.ORG_ID
                                                                 
                                                                 AND S_WC.WORK_DATE       =  W_WORK_DATE
                                                                 
                                                                 AND S_WC.PERSON_ID       =  PM.PERSON_ID
                                                                 AND S_WC.WORK_CORP_ID    =  PM.WORK_CORP_ID
                                                                 AND S_WC.SOB_ID          =  PM.SOB_ID
                                                                 AND S_WC.ORG_ID          =  PM.ORG_ID
                                                                 AND S_OST.HOLY_TYPE      =  'ALL_NIGHT'
                                                             )
                               ELSE A_OST.END_TIME
                          END
                     ELSE A_OST.END_TIME
                END AS AFTER_OT_TIME_END 
             INTO O_BF_START_TIME
                , O_BF_END_TIME
                , O_START_DATE
                , O_START_TIME
                , O_END_DATE
                , O_END_TIME 
             FROM HRM_PERSON_MASTER        PM
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
                  )                        T1
                , (-- 시점 인사내역.
                   SELECT PH.PERSON_ID
                        , PH.FLOOR_ID
                        , PH.WORK_TYPE_ID
                        , PH.DEPT_ID
                     FROM HRD_PERSON_HISTORY        PH
                    WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                      AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                  )                        T2
                , HRD_WORK_CALENDAR        WC
                , HRM_WORK_TYPE_V          B_WT
                , HRM_OT_STD_TIME_V        B_OST
                , HRM_WORK_TYPE_V          A_WT
                , HRM_OT_STD_TIME_V        A_OST
             WHERE W_WORK_DATE           = WC.WORK_DATE
               AND PM.PERSON_ID          = T1.PERSON_ID(+)
               AND PM.PERSON_ID          = T2.PERSON_ID(+)
               AND PM.PERSON_ID          = WC.PERSON_ID
               AND PM.WORK_CORP_ID       = WC.WORK_CORP_ID
               AND PM.SOB_ID             = WC.SOB_ID
               AND PM.ORG_ID             = WC.ORG_ID
               AND WC.WORK_TYPE_ID       = B_WT.WORK_TYPE_ID
               AND B_WT.WORK_TYPE_GROUP  = NVL(B_OST.WORK_TYPE, B_WT.WORK_TYPE_GROUP)
               AND B_WT.SOB_ID           = B_OST.SOB_ID
               AND B_WT.ORG_ID           = B_OST.ORG_ID
               AND WC.ATTRIBUTE3         = B_OST.HOLY_TYPE
               AND 'B'                   = B_OST.OT_STD_TYPE
               AND WC.WORK_TYPE_ID       = A_WT.WORK_TYPE_ID
               AND A_WT.WORK_TYPE_GROUP  = NVL(A_OST.WORK_TYPE, A_WT.WORK_TYPE_GROUP)
               AND A_WT.SOB_ID           = A_OST.SOB_ID
               AND A_WT.ORG_ID           = A_OST.ORG_ID
               AND WC.HOLY_TYPE          = A_OST.HOLY_TYPE
               AND 'A'                   = A_OST.OT_STD_TYPE
               AND PM.PERSON_ID          = W_PERSON_ID 
               AND PM.SOB_ID             = W_SOB_ID
               AND PM.ORG_ID             = W_ORG_ID
               AND PM.ORI_JOIN_DATE                          <= W_WORK_DATE
               AND(PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >= W_WORK_DATE)
             ;
       EXCEPTION 
         WHEN OTHERS THEN
           BEGIN
             SELECT TO_CHAR(WC.OPEN_TIME, 'HH24:MI') AS BF_START_TIME 
                  , TO_CHAR(WC.OPEN_TIME, 'HH24:MI') AS BF_END_TIME
                  , TRUNC(WC.WORK_DATE) AS START_DATE 
                  , TO_CHAR(WC.CLOSE_TIME, 'HH24:MI') AS START_TIME
                  , TRUNC(WC.WORK_DATE) AS END_TIME 
                  , TO_CHAR(WC.CLOSE_TIME, 'HH24:MI') AS END_TIME
               INTO O_BF_START_TIME
                  , O_BF_END_TIME
                  , O_START_DATE
                  , O_START_TIME
                  , O_END_DATE
                  , O_END_TIME 
               FROM HRD_WORK_CALENDAR WC
              WHERE WC.WORK_DATE      = W_WORK_DATE
                AND WC.PERSON_ID      = W_PERSON_ID
                AND WC.SOB_ID         = W_SOB_ID 
                AND WC.ORG_ID         = W_ORG_ID 
              ;
           EXCEPTION
             WHEN OTHERS THEN
               O_BF_START_TIME := '00:00';
               O_BF_END_TIME   := '00:00';
               O_START_DATE    := TRUNC(W_WORK_DATE);
               O_START_TIME    := '00:00';
               O_END_DATE      := TRUNC(W_WORK_DATE);
               O_END_TIME      := '00:00';
           END;
       END;
     END IF; 
     O_STATUS := 'S';  
   END GET_OT_TIME;
   
   
-- [2011-10-27][2011-11-29]
   PROCEDURE OUT_OVERTIME_STANDARD_TIME_1
           ( W_CORP_ID               IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_PERSON_ID             IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_WORK_DATE             IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DANGJIK_YN            IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , W_ALL_NIGHT_YN          IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , W_SOB_ID                IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID                IN  HRD_OT_HEADER.ORG_ID%TYPE
           , O_BEFORE_OT_START       OUT VARCHAR2
           , O_BEFORE_OT_END         OUT VARCHAR2
           , O_AFTER_OT_DATE_START   OUT HRD_OT_LINE.AFTER_OT_START%TYPE
           , O_AFTER_OT_TIME_START   OUT VARCHAR2
           , O_AFTER_OT_DATE_END     OUT HRD_OT_LINE.AFTER_OT_END%TYPE
           , O_AFTER_OT_TIME_END     OUT VARCHAR2
           )

   AS

           V_BEFORE_OT_START        VARCHAR2(5) := NULL;
           V_BEFORE_OT_END          VARCHAR2(5) := NULL;
           V_AFTER_OT_DATE_START    HRD_OT_LINE.AFTER_OT_START%TYPE := NULL;
           V_AFTER_OT_TIME_START    VARCHAR2(5) := NULL;
           V_AFTER_OT_DATE_END      HRD_OT_LINE.AFTER_OT_END%TYPE := NULL;
           V_AFTER_OT_TIME_END      VARCHAR2(5) := NULL;

  BEGIN
           BEGIN
                 SELECT B_OST.START_TIME AS BEFORE_OT_START
                      , B_OST.END_TIME   AS BEFORE_OT_END
                      , W_WORK_DATE + A_OST.START_ADD_DAY AS AFTER_OT_DATE_START
                      , A_OST.START_TIME                  AS AFTER_OT_TIME_START
                      , W_WORK_DATE + A_OST.END_ADD_DAY   AS AFTER_OT_DATE_END
                      , A_OST.END_TIME                    AS AFTER_OT_TIME_END
                  INTO  V_BEFORE_OT_START
                      , V_BEFORE_OT_END
                      , V_AFTER_OT_DATE_START
                      , V_AFTER_OT_TIME_START
                      , V_AFTER_OT_DATE_END
                      , V_AFTER_OT_TIME_END
                   FROM HRD_WORK_CALENDAR     WC
                      , HRM_OT_STD_TIME_V     B_OST
                      , HRM_OT_STD_TIME_V     A_OST
                  WHERE WC.ATTRIBUTE5      =  NVL(B_OST.WORK_TYPE, WC.ATTRIBUTE5)
                    AND WC.ATTRIBUTE3      =  B_OST.HOLY_TYPE
                    AND 'B'                =  B_OST.OT_STD_TYPE
                    AND WC.SOB_ID          =  B_OST.SOB_ID
                    AND WC.ORG_ID          =  B_OST.ORG_ID
                    AND WC.ATTRIBUTE5      =  NVL(A_OST.WORK_TYPE, WC.ATTRIBUTE5)
                    AND 'A'                =  A_OST.OT_STD_TYPE
                    AND WC.SOB_ID          =  A_OST.SOB_ID
                    AND WC.ORG_ID          =  A_OST.ORG_ID
                    AND WC.WORK_DATE       =  W_WORK_DATE
                    AND WC.PERSON_ID       =  W_PERSON_ID
                    AND WC.WORK_CORP_ID    =  W_CORP_ID
                    AND WC.SOB_ID          =  W_SOB_ID
                    AND WC.ORG_ID          =  W_ORG_ID
                    AND DECODE(W_ALL_NIGHT_YN, 'Y', 'ALL_NIGHT', DECODE(W_DANGJIK_YN, 'Y', 'DANGJIK', WC.HOLY_TYPE)) = A_OST.HOLY_TYPE
                      ;

                    EXCEPTION
                         WHEN OTHERS
                         THEN
                              V_BEFORE_OT_START      := NULL;
                              V_BEFORE_OT_END        := NULL;
                              V_AFTER_OT_DATE_START  := NULL;
                              V_AFTER_OT_TIME_START  := NULL;
                              V_AFTER_OT_DATE_END    := NULL;
                              V_AFTER_OT_TIME_END    := NULL;
           END;

           O_BEFORE_OT_START     := V_BEFORE_OT_START;
           O_BEFORE_OT_END       := V_BEFORE_OT_END;
           O_AFTER_OT_DATE_START := V_AFTER_OT_DATE_START;
           O_AFTER_OT_TIME_START := V_AFTER_OT_TIME_START;
           O_AFTER_OT_DATE_END   := V_AFTER_OT_DATE_END;
           O_AFTER_OT_TIME_END   := V_AFTER_OT_TIME_END;

   END OUT_OVERTIME_STANDARD_TIME_1;



-- [2011-10-30][2011-11-29]
   PROCEDURE OUT_OVERTIME_STANDARD_TIME_2
           ( W_CORP_ID          IN  HRD_OT_HEADER.CORP_ID%TYPE
           , W_PERSON_ID        IN  HRD_OT_LINE.PERSON_ID%TYPE
           , W_WORK_DATE        IN  HRD_OT_LINE.WORK_DATE%TYPE
           , W_DANGJIK_YN       IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , W_ALL_NIGHT_YN     IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , W_SOB_ID           IN  HRD_OT_HEADER.SOB_ID%TYPE
           , W_ORG_ID           IN  HRD_OT_HEADER.ORG_ID%TYPE
           , O_BEFORE_OT_START  OUT VARCHAR2
           , O_BEFORE_OT_END    OUT VARCHAR2
           , O_AFTER_OT_DATE_START   OUT HRD_OT_LINE.AFTER_OT_START%TYPE
           , O_AFTER_OT_TIME_START   OUT VARCHAR2
           , O_AFTER_OT_DATE_END     OUT HRD_OT_LINE.AFTER_OT_END%TYPE
           , O_AFTER_OT_TIME_END     OUT VARCHAR2
           )

   AS

           V_BEFORE_OT_START        VARCHAR2(5) := NULL;
           V_BEFORE_OT_END          VARCHAR2(5) := NULL;
           V_AFTER_OT_DATE_START    HRD_OT_LINE.AFTER_OT_START%TYPE := NULL;
           V_AFTER_OT_TIME_START    VARCHAR2(5) := NULL;
           V_AFTER_OT_DATE_END      HRD_OT_LINE.AFTER_OT_END%TYPE := NULL;
           V_AFTER_OT_TIME_END      VARCHAR2(5) := NULL;

  BEGIN
           BEGIN
                 SELECT A_OST.START_TIME AS BEFORE_OT_START
                      , A_OST.START_TIME AS BEFORE_OT_END
                      , W_WORK_DATE + A_OST.START_ADD_DAY AS AFTER_OT_DATE_START
                      , A_OST.START_TIME                  AS AFTER_OT_TIME_START
                      , W_WORK_DATE + A_OST.END_ADD_DAY   AS AFTER_OT_DATE_END
                      , A_OST.END_TIME                    AS AFTER_OT_TIME_END
                  INTO  V_BEFORE_OT_START
                      , V_BEFORE_OT_END
                      , V_AFTER_OT_DATE_START
                      , V_AFTER_OT_TIME_START
                      , V_AFTER_OT_DATE_END
                      , V_AFTER_OT_TIME_END
                   FROM HRD_WORK_CALENDAR     WC
                      , HRM_OT_STD_TIME_V     B_OST
                      , HRM_OT_STD_TIME_V     A_OST
                  WHERE WC.ATTRIBUTE5      =  NVL(B_OST.WORK_TYPE, WC.ATTRIBUTE5)
                    AND WC.HOLY_TYPE       =  B_OST.HOLY_TYPE
                    AND 'B'                =  B_OST.OT_STD_TYPE
                    AND WC.SOB_ID          =  B_OST.SOB_ID
                    AND WC.ORG_ID          =  B_OST.ORG_ID
                    AND WC.ATTRIBUTE5      =  NVL(A_OST.WORK_TYPE, WC.ATTRIBUTE5)
                    AND 'A'                =  A_OST.OT_STD_TYPE
                    AND WC.SOB_ID          =  A_OST.SOB_ID
                    AND WC.ORG_ID          =  A_OST.ORG_ID
                    AND WC.WORK_DATE       =  W_WORK_DATE
                    AND WC.PERSON_ID       =  W_PERSON_ID
                    AND WC.WORK_CORP_ID    =  W_CORP_ID
                    AND WC.SOB_ID          =  W_SOB_ID
                    AND WC.ORG_ID          =  W_ORG_ID
                    AND DECODE(W_ALL_NIGHT_YN, 'Y', 'ALL_NIGHT', DECODE(W_DANGJIK_YN, 'Y', 'DANGJIK', WC.HOLY_TYPE)) = A_OST.HOLY_TYPE
                      ;

                    EXCEPTION
                         WHEN OTHERS
                         THEN
                              V_BEFORE_OT_START := NULL;
                              V_BEFORE_OT_END   := NULL;
                              V_AFTER_OT_DATE_START  := NULL;
                              V_AFTER_OT_TIME_START  := NULL;
                              V_AFTER_OT_DATE_END    := NULL;
                              V_AFTER_OT_TIME_END    := NULL;
           END;

           O_BEFORE_OT_START := V_BEFORE_OT_START;
           O_BEFORE_OT_END   := V_BEFORE_OT_END;
           O_AFTER_OT_DATE_START := V_AFTER_OT_DATE_START;
           O_AFTER_OT_TIME_START := V_AFTER_OT_TIME_START;
           O_AFTER_OT_DATE_END   := V_AFTER_OT_DATE_END;
           O_AFTER_OT_TIME_END   := V_AFTER_OT_TIME_END;

   END OUT_OVERTIME_STANDARD_TIME_2;




-- [2011-10-28][2011-11-29]
   PROCEDURE INSERT_OT_LINE
           ( P_OT_HEADER_ID         IN  HRD_OT_LINE.OT_HEADER_ID%TYPE
           , P_REQ_NUM              IN  HRD_OT_LINE.REQ_NUM%TYPE
           , P_PERSON_ID            IN  HRD_OT_LINE.PERSON_ID%TYPE
           , P_WORK_DATE            IN  HRD_OT_LINE.WORK_DATE%TYPE 
           , P_OT_FLAG              IN  VARCHAR2 
           , P_BEFORE_OT_START      IN  VARCHAR2
           , P_BEFORE_OT_END        IN  VARCHAR2
           , P_AFTER_OT_DATE_START  IN  HRD_OT_LINE.AFTER_OT_START%TYPE
           , P_AFTER_OT_TIME_START  IN  VARCHAR2
           , P_AFTER_OT_DATE_END    IN  HRD_OT_LINE.AFTER_OT_END%TYPE
           , P_AFTER_OT_TIME_END    IN  VARCHAR2
           , P_LUNCH_YN             IN  HRD_OT_LINE.LUNCH_YN%TYPE
           , P_DINNER_YN            IN  HRD_OT_LINE.DINNER_YN%TYPE
           , P_MIDNIGHT_YN          IN  HRD_OT_LINE.MIDNIGHT_YN%TYPE
           , P_BREAKFAST_YN         IN  HRD_OT_LINE.BREAKFAST_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , P_DESCRIPTION          IN  HRD_OT_LINE.DESCRIPTION%TYPE
           , P_USER_ID              IN  HRD_OT_LINE.CREATED_BY%TYPE
           , W_SOB_ID               IN  HRD_OT_HEADER.SOB_ID%TYPE
           , O_OT_LINE_ID           OUT HRD_OT_LINE.OT_LINE_ID%TYPE
           )

   AS

             D_SYSDATE              HRD_OT_HEADER.CREATION_DATE%TYPE;
             V_OT_LINE_ID           HRD_OT_LINE.OT_LINE_ID%TYPE;

             V_BEFORE_OT_START      HRD_OT_LINE.BEFORE_OT_START%TYPE;
             V_BEFORE_OT_END        HRD_OT_LINE.BEFORE_OT_END%TYPE;

             V_AFTER_OT_START       HRD_OT_LINE.BEFORE_OT_START%TYPE;
             V_AFTER_OT_END         HRD_OT_LINE.BEFORE_OT_END%TYPE; 
             
             V_PERSON_NAME          VARCHAR2(200);

   BEGIN
             IF HRD_OT_HEADER_G.DATA_STATUS_CHECK(P_OT_HEADER_ID)= 'Y' THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=삽입'));
             END IF;
             
             BEGIN
               SELECT '(' || PM.PERSON_NUM || ') ' || PM.NAME AS NAME 
                 INTO V_PERSON_NAME 
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID      = P_PERSON_ID
                ;
             EXCEPTION 
               WHEN OTHERS THEN
                 V_PERSON_NAME := NULL;
             END;
             
             V_BEFORE_OT_START := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') ||  ' ' || P_BEFORE_OT_START, 'YYYY-MM-DD HH24:MI');
             V_BEFORE_OT_END   := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') ||  ' ' || P_BEFORE_OT_END,   'YYYY-MM-DD HH24:MI');
             IF V_BEFORE_OT_END < V_BEFORE_OT_START THEN
               -- 종료일자보다 시작일자가 이후 일 경우 오류 
               RAISE_APPLICATION_ERROR(-20001, 'Before : - ' || V_PERSON_NAME || ' ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10503'));
             END IF;
             

             IF P_AFTER_OT_DATE_START IS NOT NULL THEN
                V_AFTER_OT_START := TO_DATE(TO_CHAR(P_AFTER_OT_DATE_START, 'YYYY-MM-DD') ||  ' ' || NVL(P_AFTER_OT_TIME_START, '00:00'), 'YYYY-MM-DD HH24:MI');
             END IF;
             IF P_AFTER_OT_DATE_END IS NOT NULL  THEN
                V_AFTER_OT_END   := TO_DATE(TO_CHAR(P_AFTER_OT_DATE_END, 'YYYY-MM-DD') ||  ' ' || NVL(P_AFTER_OT_TIME_END, '00:00'),   'YYYY-MM-DD HH24:MI');
             END IF;
             IF V_AFTER_OT_END < V_AFTER_OT_START THEN
               -- 종료일자보다 시작일자가 이후 일 경우 오류 
               RAISE_APPLICATION_ERROR(-20001, 'After : - ' || V_PERSON_NAME || CHR(10) || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10503'));
             END IF;
             
             -- 야간일 경우 정오 이전 신청 불가 -- 
             IF (P_WORK_DATE + 1.229166666666667)  < V_AFTER_OT_START 
               AND V_BEFORE_OT_START < (P_WORK_DATE + 0.5) THEN
               -- 20:30 분이 연장 시작이면 근무전 연장 시작시간은 12:00 이후만 신청 가능 -- 
               RAISE_APPLICATION_ERROR(-20001, 'O/T Validate : - ' || V_PERSON_NAME || CHR(10) || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10504'));
             END IF;
             
             BEGIN
                   D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);

                   SELECT HRD_OT_LINE_S1.NEXTVAL
                     INTO V_OT_LINE_ID
                     FROM DUAL;

             EXCEPTION
             WHEN OTHERS
             THEN
                  RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10042', '&&VALUE:=삽입'));
             END;

             INSERT INTO HRD_OT_LINE
                       ( OT_LINE_ID
                       , OT_HEADER_ID
                       , REQ_NUM
                       , PERSON_ID
                       , WORK_DATE
                       , BEFORE_OT_START
                       , BEFORE_OT_END
                       , AFTER_OT_START
                       , AFTER_OT_END
                       , LUNCH_YN
                       , DINNER_YN
                       , MIDNIGHT_YN
                       , BREAKFAST_YN
                       , DANGJIK_YN
                       , ALL_NIGHT_YN
                       , DESCRIPTION
                       , CREATION_DATE
                       , CREATED_BY
                       , LAST_UPDATE_DATE
                       , LAST_UPDATED_BY 
                       , OT_FLAG
                       )
             VALUES
                       ( V_OT_LINE_ID
                       , P_OT_HEADER_ID
                       , P_REQ_NUM
                       , P_PERSON_ID
                       , P_WORK_DATE
                       , V_BEFORE_OT_START
                       , V_BEFORE_OT_END
                       , V_AFTER_OT_START
                       , V_AFTER_OT_END
                       , P_LUNCH_YN
                       , P_DINNER_YN
                       , P_MIDNIGHT_YN
                       , P_BREAKFAST_YN
                       , P_DANGJIK_YN
                       , P_ALL_NIGHT_YN
                       , P_DESCRIPTION
                       , D_SYSDATE
                       , P_USER_ID
                       , D_SYSDATE
                       , P_USER_ID 
                       , P_OT_FLAG
                       );

             -- 라인 일련번호 생성.
             UPDATE HRD_OT_LINE       OL
                SET OL.LINE_SEQ     = ROWNUM
              WHERE OL.OT_HEADER_ID = P_OT_HEADER_ID
                  ;

             UPDATE HRD_OT_HEADER    OH
               SET OH.ATTRIBUTE1   = TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD')
             WHERE OH.OT_HEADER_ID = P_OT_HEADER_ID
             ;

             COMMIT;

             O_OT_LINE_ID := V_OT_LINE_ID;

   END INSERT_OT_LINE;


-- [2011-10-28][2011-11-29]
   PROCEDURE UPDATE_OT_LINE
           ( W_OT_LINE_ID           IN  HRD_OT_LINE.OT_LINE_ID%TYPE
           , W_OT_HEADER_ID         IN  HRD_OT_LINE.OT_HEADER_ID%TYPE
           , P_PERSON_ID            IN  HRD_OT_LINE.PERSON_ID%TYPE
           , P_WORK_DATE            IN  HRD_OT_LINE.WORK_DATE%TYPE 
           , P_OT_FLAG              IN  VARCHAR2 
           , P_BEFORE_OT_START      IN  VARCHAR2
           , P_BEFORE_OT_END        IN  VARCHAR2
           , P_AFTER_OT_DATE_START  IN  HRD_OT_LINE.AFTER_OT_START%TYPE
           , P_AFTER_OT_TIME_START  IN  VARCHAR2
           , P_AFTER_OT_DATE_END    IN  HRD_OT_LINE.AFTER_OT_END%TYPE
           , P_AFTER_OT_TIME_END    IN  VARCHAR2
           , P_LUNCH_YN             IN  HRD_OT_LINE.LUNCH_YN%TYPE
           , P_DINNER_YN            IN  HRD_OT_LINE.DINNER_YN%TYPE
           , P_MIDNIGHT_YN          IN  HRD_OT_LINE.MIDNIGHT_YN%TYPE
           , P_BREAKFAST_YN         IN  HRD_OT_LINE.BREAKFAST_YN%TYPE
           , P_DANGJIK_YN           IN  HRD_OT_LINE.DANGJIK_YN%TYPE
           , P_ALL_NIGHT_YN         IN  HRD_OT_LINE.ALL_NIGHT_YN%TYPE
           , P_DESCRIPTION          IN  HRD_OT_LINE.DESCRIPTION%TYPE
           , P_USER_ID              IN  HRD_OT_LINE.CREATED_BY%TYPE
           , W_SOB_ID               IN  HRD_OT_HEADER.SOB_ID%TYPE
           )

   AS

             V_APPROVE_STATUS       HRD_OT_HEADER.APPROVE_STATUS%TYPE := 'N';
             V_REJECT_YN            HRD_OT_HEADER.REJECT_YN%TYPE := NULL;

             V_BEFORE_OT_START      HRD_OT_LINE.BEFORE_OT_START%TYPE;
             V_BEFORE_OT_END        HRD_OT_LINE.BEFORE_OT_END%TYPE;

             V_AFTER_OT_START       HRD_OT_LINE.BEFORE_OT_START%TYPE;
             V_AFTER_OT_END         HRD_OT_LINE.BEFORE_OT_END%TYPE;
             
             V_PERSON_NAME          VARCHAR2(200);

   BEGIN
             BEGIN
                  SELECT OH.APPROVE_STATUS
                       , OH.REJECT_YN
                    INTO V_APPROVE_STATUS
                       , V_REJECT_YN
                    FROM HRD_OT_HEADER OH
                   WHERE OH.OT_HEADER_ID = W_OT_HEADER_ID
                       ;
             EXCEPTION WHEN OTHERS THEN
                  V_APPROVE_STATUS := 'N';
                  V_REJECT_YN      := 'N';
             END;

             IF V_APPROVE_STATUS NOT IN('N') AND V_REJECT_YN = 'N' THEN
                RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10042', '&&VALUE:=Modify(수정)'));
                RETURN;
             END IF;

             BEGIN
               SELECT '(' || PM.PERSON_NUM || ') ' || PM.NAME AS NAME 
                 INTO V_PERSON_NAME 
                 FROM HRM_PERSON_MASTER PM
                WHERE PM.PERSON_ID      = P_PERSON_ID
                ;
             EXCEPTION 
               WHEN OTHERS THEN
                 V_PERSON_NAME := NULL;
             END;
             
             V_BEFORE_OT_START := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') ||  ' ' || P_BEFORE_OT_START, 'YYYY-MM-DD HH24:MI');
             V_BEFORE_OT_END   := TO_DATE(TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD') ||  ' ' || P_BEFORE_OT_END,   'YYYY-MM-DD HH24:MI');
             IF V_BEFORE_OT_END < V_BEFORE_OT_START THEN
               -- 종료일자보다 시작일자가 이후 일 경우 오류 
               RAISE_APPLICATION_ERROR(-20001, 'Before : - ' || V_PERSON_NAME || ' ' || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10503'));
             END IF;
             
             IF P_AFTER_OT_DATE_START IS NOT NULL THEN
                V_AFTER_OT_START := TO_DATE(TO_CHAR(P_AFTER_OT_DATE_START, 'YYYY-MM-DD') ||  ' ' || NVL(P_AFTER_OT_TIME_START, '00:00'), 'YYYY-MM-DD HH24:MI');
             END IF;
             IF P_AFTER_OT_DATE_END IS NOT NULL  THEN
                V_AFTER_OT_END   := TO_DATE(TO_CHAR(P_AFTER_OT_DATE_END, 'YYYY-MM-DD') ||  ' ' || NVL(P_AFTER_OT_TIME_END, '00:00'),   'YYYY-MM-DD HH24:MI');
             END IF;
             IF V_AFTER_OT_END < V_AFTER_OT_START THEN
               -- 종료일자보다 시작일자가 이후 일 경우 오류 
               RAISE_APPLICATION_ERROR(-20001, 'After : - ' || V_PERSON_NAME || CHR(10) || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10503'));
             END IF;
             -- 야간일 경우 정오 이전 신청 불가 -- 
             IF (P_WORK_DATE + 1.229166666666667)  < V_AFTER_OT_START 
               AND V_BEFORE_OT_START < (P_WORK_DATE + 0.5) THEN
               -- 20:30 분이 연장 시작이면 근무전 연장 시작시간은 12:00 이후만 신청 가능 -- 
               RAISE_APPLICATION_ERROR(-20001, 'O/T Validate : - ' || V_PERSON_NAME || CHR(10) || EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10504') || CHR(10) || CHR(10));
             END IF;
             
             UPDATE HRD_OT_LINE OL
                SET OL.WORK_DATE         =  P_WORK_DATE
                  , OL.BEFORE_OT_START   =  V_BEFORE_OT_START
                  , OL.BEFORE_OT_END     =  V_BEFORE_OT_END
                  , OL.AFTER_OT_START    =  V_AFTER_OT_START
                  , OL.AFTER_OT_END      =  V_AFTER_OT_END
                  , OL.LUNCH_YN          =  P_LUNCH_YN
                  , OL.DINNER_YN         =  P_DINNER_YN
                  , OL.MIDNIGHT_YN       =  P_MIDNIGHT_YN
                  , OL.BREAKFAST_YN      =  P_BREAKFAST_YN
                  , OL.DANGJIK_YN        =  P_DANGJIK_YN
                  , OL.ALL_NIGHT_YN      =  P_ALL_NIGHT_YN
                  , OL.DESCRIPTION       =  P_DESCRIPTION
                  , OL.LAST_UPDATE_DATE  =  GET_LOCAL_DATE(W_SOB_ID)
                  , OL.LAST_UPDATED_BY   =  P_USER_ID
                  
                  , OT_FLAG              = P_OT_FLAG 
              WHERE OL.OT_LINE_ID        =  W_OT_LINE_ID
                  ;

             UPDATE HRD_OT_HEADER    OH
               SET OH.ATTRIBUTE1   = TO_CHAR(P_WORK_DATE, 'YYYY-MM-DD')
             WHERE OH.OT_HEADER_ID = W_OT_HEADER_ID
             ;


             --[2011-10-28]
             IF V_REJECT_YN = 'Y' THEN
                UPDATE HRD_OT_HEADER OH
                   SET OH.APPROVED_YN         = 'N'
                     , OH.APPROVED_DATE       = NULL
                     --, OH.APPROVED_PERSON_ID  = NULL
                     , OH.APPROVE_STATUS      = 'A'
                     , OH.CONFIRMED_YN        = 'N'
                     , OH.CONFIRMED_DATE      = NULL
                     --, OH.CONFIRMED_PERSON_ID = NULL
                     , OH.EMAIL_STATUS        = 'N'
                     , OH.REJECT_REMARK       = NULL
                     , OH.REJECT_YN           = 'N'
                     , OH.REJECT_DATE         = NULL
                     , OH.REJECT_PERSON_ID    = NULL
                     , OH.ATTRIBUTE2          = OH.APPROVED_PERSON_ID
                     , OH.ATTRIBUTE3          = OH.CONFIRMED_PERSON_ID
                     , OH.ATTRIBUTE4          = OH.REJECT_PERSON_ID
                 WHERE OH.OT_HEADER_ID        = W_OT_HEADER_ID
                     ;

                UPDATE HRD_OT_LINE OL
                   SET OL.EMAIL_STATUS        = 'N'
                     , OL.REJECT_REMARK       = NULL
                     , OL.REJECT_YN           = 'N'
                     , OL.REJECT_DATE         = NULL
                     , OL.REJECT_PERSON_ID    = NULL
                 WHERE OL.OT_HEADER_ID        = W_OT_HEADER_ID
                     ;
             END IF;


             COMMIT;

   END UPDATE_OT_LINE;



END HRD_OT_LINE_G;
/
