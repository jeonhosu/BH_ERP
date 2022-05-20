CREATE OR REPLACE PACKAGE HRD_DAY_INTERFACE_TRANS_G
AS

-- DAY INTERFACE TRANS LIST SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            );

-- DATA_SELECT Backup
  PROCEDURE DATA_SELECT1
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
						, W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
						, W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
						, W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            );

-- ºñ°í»çÇ× ÀúÀå.
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
            , P_DANGJIK_YN                        IN HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                      IN HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
            , P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE              
            );
              
-- DAY INTERFACE TRANS MANAGER SELECT
  PROCEDURE DATA_TRANS_MANAGER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_END_DATE                          IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
						, W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
            , W_MANAGER_ID                        IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );
						
-- DAY INTERFACE TRANS CANCEL
  PROCEDURE DATA_TRANS_CANCEL
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
						, W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
						, P_CHECK_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            );						
						

-- DAY INTERFACE TRANSFER MAIN.
  PROCEDURE DATA_TRANSFER_MAIN
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, W_CAP_CHECK_YN                      IN VARCHAR2
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            );

-- DAY INTERFACE TRANSFER GO1.
  PROCEDURE DATA_TRANSFER_GO1
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
            , W_FLOOR_ID                          IN HRM_COMMON.COMMON_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
						, P_USER_ID                           IN HRD_DAY_LEAVE.CREATED_BY%TYPE
            );



--[2011-12-07]Ãß°¡
  PROCEDURE UPDATE_DATA
          ( W_SOB_ID        IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID        IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID       IN  HRD_DAY_INTERFACE.LAST_UPDATED_BY%TYPE
          , W_WORK_DATE     IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_PERSON_ID     IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , P_DANGJIK_YN    IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
          , P_NEXT_DAY_YN   IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
          , P_ALL_NIGHT_YN  IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
          );



       --ÃâÅð±ÙÁ¶È¸(±â°£) [2011-07-29][2011-08-11][2011-11-03]
       PROCEDURE SELECT_DATA_1
               ( P_CURSOR             OUT TYPES.TCURSOR
               , W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
               , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
               , W_CORP_ID            IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
               , W_WORK_CORP_ID       IN  HRD_DAY_INTERFACE.WORK_CORP_ID%TYPE
               , W_FLOOR_ID           IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
               , W_DEPT_ID            IN  HRD_DAY_INTERFACE.DEPT_ID%TYPE
               , W_WORK_DATE_FR       IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
               , W_WORK_DATE_TO       IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
               , W_WORK_TYPE_ID       IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
               , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
               , W_EMPLOYE_TYPE       IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
               , W_CONNECT_PERSON_ID  IN HRM_PERSON_MASTER.PERSON_ID%TYPE DEFAULT NULL
               );


  --2011-08-19[Ãß°¡]
  PROCEDURE SELECT_DATA_2
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE           IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_MODIFY_YN           IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_TRANS_YN            IN  HRD_DAY_INTERFACE.TRANS_YN%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_CONNECT_LEVEL       IN  VARCHAR2 DEFAULT 'A'
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID             IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
          );

  --2011-08-19[Ãß°¡], 2011-12-07
  PROCEDURE SELECT_DATA_3
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE_FR        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_DATE_TO        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          );


  --2012-01-06[Ãß°¡]
  PROCEDURE SELECT_DATA_4
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE_FR        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_DATE_TO        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_CONNECT_PERSON_ID   IN HRM_PERSON_MASTER.PERSON_ID%TYPE DEFAULT NULL
          );
          

  --2011-11-03
  PROCEDURE SELECT_DATA_P
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE_FR        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_DATE_TO        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_MODIFY_YN           IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_TRANS_YN            IN  HRD_DAY_INTERFACE.TRANS_YN%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_CONNECT_LEVEL       IN  VARCHAR2 DEFAULT 'A'
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID             IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
          , W_SORT                IN  VARCHAR2
          );



--[2011-11-03]
  PROCEDURE SELECT_DATA_M
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE           IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_MODIFY_YN           IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_TRANS_YN            IN  HRD_DAY_INTERFACE.TRANS_YN%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_CONNECT_LEVEL       IN  VARCHAR2 DEFAULT 'A'
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID             IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
          , W_SORT                IN  VARCHAR2
          );



       -- LOOKUP PERSON INFOMATION[2011-07-29]
       PROCEDURE LU_PERSON_DUTY
               ( P_CURSOR3        OUT TYPES.TCURSOR3
               , W_CORP_ID        IN  NUMBER
               , W_WORK_TYPE_ID   IN  NUMBER
               , W_DEPT_ID        IN  NUMBER
               , W_FLOOR_ID       IN  NUMBER
               , W_SOB_ID         IN  NUMBER
               , W_ORG_ID         IN  NUMBER
               );


--[2011-12-07]Ãß°¡
  PROCEDURE DEFAULT_FLOOR( O_FLOOR_ID            OUT HRM_PERSON_MASTER.FLOOR_ID%TYPE
                         , O_FLOOR_NAME          OUT VARCHAR2
                         , O_PERSON_NUMBER       OUT HRM_PERSON_MASTER.PERSON_NUM%TYPE
                         , O_PERSON_NAME         OUT HRM_PERSON_MASTER.NAME%TYPE
                         , O_WORK_TYPE_ID        OUT HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                         , O_WORK_TYPE_NAME      OUT VARCHAR2
                         , O_CAPACITY            OUT VARCHAR2
                         , W_SOB_ID              IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                         , W_ORG_ID              IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                         , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                         );

END HRD_DAY_INTERFACE_TRANS_G;


 
/
CREATE OR REPLACE PACKAGE BODY HRD_DAY_INTERFACE_TRANS_G
AS
/******************************************************************************/
/* PROJECT      : FPCB ERP
/* MODULE       : EAPP
/* PROGRAM NAME : HRD_DAY_INTERFACE_TRANS_G
/* DESCRIPTION  : ÃâÅð±Ù³»¿ª ÀÌÃ¸ / ÀÌÃ¸ Ãë¼Ò °ü¸®.
/* REFERENCE BY :
/* PROGRAM HISTORY : ½Å±Ô »ý¼º
/*------------------------------------------------------------------------------
/*   DATE       IN CHARGE          DESCRIPTION
/*------------------------------------------------------------------------------
/* 20-JUN-2010  JEON HO SU          INITIALIZE
/******************************************************************************/

-- DAY INTERFACE TRANS LIST SELECT
  PROCEDURE DATA_SELECT
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
      , W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
      , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            )
  AS
  V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    V_MESSAGE                                     VARCHAR2(300);
  BEGIN
   -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
    IF W_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;

    -- ±ÙÅÂ Áý°è.
    HRD_DAY_INTERFACE_G_SET.SET_MAIN
          ( P_CONNECT_PERSON_ID => W_CONNECT_PERSON_ID
          , P_CONNECT_LEVEL => W_CONNECT_LEVEL
          , P_WORK_DATE => W_WORK_DATE
          , P_CORP_ID => W_CORP_ID
          , P_SOB_ID => W_SOB_ID
          , P_ORG_ID => W_ORG_ID
          , P_USER_ID => P_USER_ID
          , O_MESSAGE => V_MESSAGE
          );

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
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
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
                                  ) = '3' -- ¾ß°£
                                      AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                       OR DI.DUTY_ID        = 1170 -- ±³À°
                                       OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                       OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                       OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                       OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                       OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                       OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                         ) THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                       AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                         , 1174 -- °æÁ¶ÈÞ°¡
                                                                         , 1175 -- ³âÂ÷
                                                                         , 1177 -- º¸°ÇÈÞ°¡
                                                                         , 1178 -- ¿¬ÁßÈÞ°¡
                                                                         , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                         , 1182 -- ¹«±ÞÈÞÀÏ
                                                                         , 1187 -- ÈÞÀÏ±Ù¹«
                                                                         , 1188 -- ÈÞÀÏ
                                                                         , 1189 -- ¹«±ÞÈÞ°¡
                                                                         , 1190 -- À¯±ÞÈÞ°¡
                                                                         , 1194 -- ´çÁ÷
                                                                         , 3784 -- Ã¶¾ß
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
                                                           ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                        AND (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                             WHEN (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- ÈÄÀÏÅð±Ù
                                      AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                       OR DI.DUTY_ID        = 1170 -- ±³À°
                                       OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                       OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                       OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                       OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                       OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                       OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                         ) THEN NULL
                             WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                  AND (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                      THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                              FROM HRD_DAY_INTERFACE S_DI
                                                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                               AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                           ))
                             WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                  AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                  AND (SELECT S_DI.ALL_NIGHT_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                      THEN NULL
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                             ELSE DI.CLOSE_TIME
                        END           AS CLOSE_TIME
      , CASE
        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
        ELSE DI.OPEN_TIME1
       END AS OPEN_TIME1
      , CASE
              /* WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME1, N_DI.CLOSE_TIME1)*/
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
        ELSE DI.CLOSE_TIME1
       END AS CLOSE_TIME1
      , DI.NEXT_DAY_YN
           , DI.DANGJIK_YN
           , DI.ALL_NIGHT_YN
           , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
      , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC
      , DI.LEAVE_ID
      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
      , DI.LEAVE_TIME_CODE
      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
      , DI.DESCRIPTION
      , DI.TRANS_YN AS TRANS_YN
                      , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND(SELECT S_DI.HOLY_TYPE
                                                             FROM HRD_DAY_INTERFACE   S_DI
                                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                          ) = '3' -- ¾ß°£
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                       AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                       AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                       AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                       AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                       AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                       AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                       AND (SELECT DI.HOLY_TYPE
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '3' THEN '' -- ¾ß°£
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                       AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                       AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                       AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                             FROM HRD_DAY_INTERFACE_V   S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                              FROM HRD_DAY_INTERFACE   S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = '3'
                                                        OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                              FROM HRD_DAY_INTERFACE_V S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = 'Y') THEN ''
                             ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                        END  AS APPROVE_STATUS_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
      , DI.WORK_DATE
      , DI.WORK_CORP_ID CORP_ID
   FROM HRD_DAY_INTERFACE_V DI
    , HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
        , HRM_POST_CODE_V PC
    , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.JOB_CATEGORY_ID
        , HL.FLOOR_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                       FROM HRM_HISTORY_LINE             S_HL
                                      WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                        AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                   GROUP BY S_HL.PERSON_ID
                                    )
     ) T1
               , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
    , HRD_DAY_MODIFY I_DM
    , HRD_DAY_MODIFY O_DM
        , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
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
    AND DI.WORK_CORP_ID                       = W_CORP_ID
    AND DI.SOB_ID                             = W_SOB_ID
    AND DI.ORG_ID                             = W_ORG_ID
        AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
    AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
    AND T2.FLOOR_ID                           = NVL(W_FLOOR_ID, T2.FLOOR_ID)
    AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
    AND DI.TRANS_YN                           = NVL(W_TRANS_YN, DI.TRANS_YN)
        AND PM.JOIN_DATE                          <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
            AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
            AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
            AND DM.START_DATE                              <= W_WORK_DATE
            AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
        --ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.PERSON_NUM
       ORDER BY HF.FLOOR_CODE
              , PM.WORK_TYPE_ID
              , PM.NAME
    ;

  END DATA_SELECT;



-- DATA_SELECT Backup
  PROCEDURE DATA_SELECT1
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_MODIFY_YN                         IN HRD_DAY_INTERFACE.MODIFY_YN%TYPE
      , W_WORK_TYPE_ID                      IN HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
      , W_FLOOR_ID                          IN HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
            , W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
      , W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
      , W_CONNECT_PERSON_ID                 IN HRM_PERSON_MASTER.PERSON_ID%TYPE
            , W_CONNECT_LEVEL                     IN VARCHAR2 DEFAULT 'A'
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            )
  AS
  V_CONNECT_PERSON_ID                           HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
    V_MESSAGE                                     VARCHAR2(300);
  BEGIN
   -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
    IF W_CONNECT_LEVEL = 'C' THEN
      V_CONNECT_PERSON_ID := NULL;
    ELSE
      V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
    END IF;

    -- ±ÙÅÂ Áý°è.
    HRD_DAY_INTERFACE_G_SET.SET_MAIN
          ( P_CONNECT_PERSON_ID => W_CONNECT_PERSON_ID
          , P_CONNECT_LEVEL => W_CONNECT_LEVEL
          , P_WORK_DATE => W_WORK_DATE
          , P_CORP_ID => W_CORP_ID
          , P_SOB_ID => W_SOB_ID
          , P_ORG_ID => W_ORG_ID
          , P_USER_ID => P_USER_ID
          , O_MESSAGE => V_MESSAGE
          );

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
              /* WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME1, N_DI.CLOSE_TIME1)*/
        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
        ELSE DI.CLOSE_TIME1
       END AS CLOSE_TIME1
      , DI.NEXT_DAY_YN
           , DI.DANGJIK_YN
           , DI.ALL_NIGHT_YN
           , DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL) AS I_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_ID, NULL)) AS I_MODIFY_DESC
      , DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL) AS O_MODIFY_ID
      , HRM_COMMON_G.ID_NAME_F(DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_ID, NULL)) AS O_MODIFY_DESC
      , DI.LEAVE_ID
      , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
      , DI.LEAVE_TIME_CODE
      , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
      , DI.DESCRIPTION
      , DI.TRANS_YN AS TRANS_YN
      --, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                      , CASE WHEN DI.MODIFY_FLAG = 'N' AND (DI.DUTY_ID = 1168 OR DI.DUTY_ID = 1187) THEN ''
                             ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                        END  AS APPROVE_STATUS_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID) AS APPROVED_PERSON_NAME
      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
      , DI.WORK_DATE
      , DI.WORK_CORP_ID CORP_ID
   FROM HRD_DAY_INTERFACE_V DI
    , HRM_PERSON_MASTER PM
        , HRM_FLOOR_V HF
        , HRM_POST_CODE_V PC
    , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
      SELECT HL.PERSON_ID
        , HL.DEPT_ID
        , HL.POST_ID
        , HL.JOB_CATEGORY_ID
        , HL.FLOOR_ID
      FROM HRM_HISTORY_LINE HL
      WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                       FROM HRM_HISTORY_LINE             S_HL
                                      WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                        AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                   GROUP BY S_HL.PERSON_ID
                                    )
     ) T1
               , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                  SELECT PH.PERSON_ID
                       , PH.FLOOR_ID
                    FROM HRD_PERSON_HISTORY        PH
                   WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                     AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                 ) T2
    , HRD_DAY_MODIFY I_DM
    , HRD_DAY_MODIFY O_DM
        , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
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
    AND DI.WORK_CORP_ID                       = W_CORP_ID
    AND DI.SOB_ID                             = W_SOB_ID
    AND DI.ORG_ID                             = W_ORG_ID
        AND DI.PERSON_ID                          = NVL(W_PERSON_ID, DI.PERSON_ID)
    AND DI.WORK_TYPE_ID                       = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
    AND T2.FLOOR_ID                           = NVL(W_FLOOR_ID, T2.FLOOR_ID)
    AND NVL(W_MODIFY_YN, DI.MODIFY_YN)        IN(DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
    AND DI.TRANS_YN                           = NVL(W_TRANS_YN, DI.TRANS_YN)
        AND PM.JOIN_DATE                          <= W_WORK_DATE
        AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_WORK_DATE)
    AND EXISTS (SELECT 'X'
                  FROM HRD_DUTY_MANAGER DM
            WHERE DM.CORP_ID                                 = PM.WORK_CORP_ID
             AND DM.DUTY_CONTROL_ID                         = NVL(T2.FLOOR_ID, PM.FLOOR_ID)
            AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
            AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
            AND DM.START_DATE                              <= W_WORK_DATE
            AND (DM.END_DATE IS NULL OR DM.END_DATE        >= W_WORK_DATE)
            AND DM.SOB_ID                                  = PM.SOB_ID
            AND DM.ORG_ID                                  = PM.ORG_ID
          )
        --ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.PERSON_NUM
        ORDER BY HF.FLOOR_CODE, PM.WORK_TYPE_ID, PC.SORT_NUM, PM.NAME
    ;

  END DATA_SELECT1;

-- ºñ°í»çÇ× ÀúÀå.
  PROCEDURE DATA_UPDATE
            ( W_PERSON_ID                         IN HRD_DAY_INTERFACE.PERSON_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            , P_NEXT_DAY_YN                       IN HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
            , P_DANGJIK_YN                        IN HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
            , P_ALL_NIGHT_YN                      IN HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
            , P_DESCRIPTION                       IN HRD_DAY_INTERFACE.DESCRIPTION%TYPE
            , P_USER_ID                           IN HRD_DAY_INTERFACE.CREATED_BY%TYPE
            )
  AS
    V_CORP_ID                                     NUMBER;
    V_APPROVE_STATUS                              VARCHAR2(5);
  BEGIN
    BEGIN
      SELECT PM.CORP_ID
        INTO V_CORP_ID
        FROM HRM_PERSON_MASTER PM
      WHERE PM.PERSON_ID          = W_PERSON_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CORP_ID := 25;
    END;
    -- ÀÌÃ¸ Ã¼Å©.
    V_APPROVE_STATUS := 'N';
    V_APPROVE_STATUS := HRD_DAY_INTERFACE_G.TRANSFER_YN_F( W_CORP_ID => V_CORP_ID
                                      , W_WORK_DATE => W_WORK_DATE
                                      , W_PERSON_ID => W_PERSON_ID
                                      , W_SOB_ID => W_SOB_ID
                                      , W_ORG_ID => W_ORG_ID);
    IF V_APPROVE_STATUS = 'Y' THEN
      RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10053', NULL));
      RETURN;
    END IF;

--    raise_application_error(-20001, 'id ' || W_PERSON_ID || 'date : ' || w_work_date || 'sob : ' || w_sob_id || ' da : ' || P_DANGJIK_YN || ', ni : ' || P_ALL_NIGHT_YN);
    UPDATE HRD_DAY_INTERFACE DI
      SET DI.NEXT_DAY_YN          = NVL(P_NEXT_DAY_YN, 'N')
        , DI.DANGJIK_YN           = NVL(P_DANGJIK_YN, 'N')
        , DI.ALL_NIGHT_YN         = NVL(P_ALL_NIGHT_YN, 'N')
        , DI.DESCRIPTION          = P_DESCRIPTION
        , DI.LAST_UPDATE_DATE     = GET_LOCAL_DATE(DI.SOB_ID)
        , DI.LAST_UPDATED_BY      = P_USER_ID
    WHERE DI.PERSON_ID            = W_PERSON_ID
      AND DI.WORK_DATE            = W_WORK_DATE
      AND DI.SOB_ID               = W_SOB_ID
      AND DI.ORG_ID               = W_ORG_ID
    ;

  END DATA_UPDATE;

-- DAY INTERFACE TRANS MANAGER SELECT
  PROCEDURE DATA_TRANS_MANAGER
            ( P_CURSOR                            OUT TYPES.TCURSOR
            , W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_START_DATE                        IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_END_DATE                          IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
      , W_TRANS_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
      , W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
            , W_MANAGER_ID                        IN HRD_DUTY_MANAGER.MANAGER_ID1%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
  D_SYSDATE                                     HRD_DAY_INTERFACE.CREATION_DATE%TYPE;
  N_DAY_COUNT                                   NUMBER := 0;

  BEGIN
  D_SYSDATE := GET_LOCAL_DATE(W_SOB_ID);
  -- ÀÓ½ÃÅ×ÀÌºí »èÁ¦.
  BEGIN
   DELETE FROM HRD_WORK_DATE WD
   WHERE WD.RUN_DATETIME                          < (D_SYSDATE- (1 / 24 / 60 * 20))
    AND WD.SOB_ID                                = W_SOB_ID
    AND WD.ORG_ID                                = W_ORG_ID;
  END;
  -- °°Àº ¼¼¼ÇÀÇ ÀÚ·á »èÁ¦.
  BEGIN
   DELETE FROM HRD_WORK_DATE WD
   WHERE WD.SESSION_ID                            = USERENV_G.GET_SESSION_ID_F
     AND WD.RUN_DATETIME                          = D_SYSDATE
    AND WD.SOB_ID                                = W_SOB_ID
    AND WD.ORG_ID                                = W_ORG_ID;
  END;

  -- ¿ù ´Þ·Â »ý¼º.
  BEGIN
    N_DAY_COUNT := W_END_DATE - W_START_DATE + 1;
   FOR C1 IN 0 .. N_DAY_COUNT - 1
   LOOP
    INSERT INTO HRD_WORK_DATE
    (SESSION_ID, RUN_DATETIME, WORK_DATE, PERSON_ID, CORP_ID, WORK_WEEK, SOB_ID, ORG_ID
    , N_VALUE1, N_VALUE2, N_VALUE3)
    (SELECT USERENV_G.GET_SESSION_ID_F
       , D_SYSDATE
       , W_START_DATE + C1
       , DM.MANAGER_ID1      -- PERSON_ID
       , DM.CORP_ID
       , TO_CHAR(W_START_DATE + C1, 'D')
       , W_SOB_ID
       , W_ORG_ID
       , DM.DUTY_MANAGER_ID
       , DM.DUTY_CONTROL_ID
       , DM.WORK_TYPE_ID
     FROM HRD_DUTY_MANAGER DM
     WHERE DM.CORP_ID               = W_CORP_ID
      AND DM.SOB_ID                = W_SOB_ID
      AND DM.ORG_ID                = W_ORG_ID
      AND DM.USABLE                = 'Y'
      AND DM.START_DATE            <= W_END_DATE
      AND (DM.END_DATE IS NULL OR DM.END_DATE >= W_START_DATE))
    ;
   END LOOP C1;
  END;

    OPEN P_CURSOR FOR
      SELECT WD.WORK_DATE
      , T1.DEPT_NAME
      , T1.POST_NAME
      , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(WD.N_VALUE1) AS DUTY_MANAGER_NAME
      , T1.NAME AS MANAGER_NAME
      , COUNT(T2.PERSON_ID) AS DAY_INTERFACE_COUNT
      , COUNT(T3.PERSON_ID) AS DAY_LEAVE_COUNT
      , SUM(DECODE(T3.CLOSED_YN, 'Y', 1, 0)) AS DAY_LEAVE_CLOSE_COUNT
      , 'N' AS CHECK_YN
      , WD.N_VALUE1 AS DUTY_MANAGER_ID
    FROM HRD_WORK_DATE WD
      , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
       SELECT PM.PERSON_ID
          , HRM_PERSON_MASTER_G.NAME_F(PM.PERSON_ID) AS NAME
                   , PM.WORK_CORP_ID
          , PM.CORP_ID
          , PM.SOB_ID
          , PM.ORG_ID
          , PM.WORK_TYPE_ID
          , HL.DEPT_ID
          , HRM_DEPT_MASTER_G.DEPT_NAME_F(HL.DEPT_ID) AS DEPT_NAME
          , HL.POST_ID
          , HRM_COMMON_G.ID_NAME_F(HL.POST_ID) AS POST_NAME
          , HL.FLOOR_ID
          , HRM_COMMON_G.ID_NAME_F(HL.FLOOR_ID) AS FLOOR_NAME
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER PM
       WHERE HL.PERSON_ID              = PM.PERSON_ID
        AND HL.CHARGE_DATE            <= W_END_DATE
        AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                             FROM HRM_HISTORY_LINE             S_HL
                                            WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                              AND S_HL.CHARGE_DATE          <= W_END_DATE
                                         GROUP BY S_HL.PERSON_ID
                                          )
      ) T1
     , (-- ÃâÅð±Ù µî·Ï.
       SELECT PM.WORK_CORP_ID
                   , PM.CORP_ID
          , PM.SOB_ID
          , PM.ORG_ID
          , PM.WORK_TYPE_ID
          , HL.FLOOR_ID
          , DI.WORK_DATE
          , DI.PERSON_ID
          , DI.TRANS_YN
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER PM
          , HRD_DAY_INTERFACE DI
       WHERE HL.PERSON_ID              = PM.PERSON_ID
        AND PM.PERSON_ID              = DI.PERSON_ID
        AND HL.CHARGE_DATE            <= W_END_DATE
        AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                             FROM HRM_HISTORY_LINE             S_HL
                                            WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                              AND S_HL.CHARGE_DATE          <= W_END_DATE
                                         GROUP BY S_HL.PERSON_ID
                                          )
        AND DI.WORK_DATE             BETWEEN W_START_DATE AND W_END_DATE
                AND PM.JOIN_DATE             <= W_END_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
      ) T2
     , (-- ÀÏ±ÙÅÂ  ÀÚ·á Á¶È¸.
       SELECT PM.WORK_CORP_ID
                   , PM.CORP_ID
          , PM.SOB_ID
          , PM.ORG_ID
          , PM.WORK_TYPE_ID
          , HL.FLOOR_ID
          , DL.WORK_DATE
          , DL.PERSON_ID
          , DL.CLOSED_YN
        FROM HRM_HISTORY_LINE HL
          , HRM_PERSON_MASTER PM
          , HRD_DAY_LEAVE DL
       WHERE HL.PERSON_ID              = PM.PERSON_ID
        AND PM.PERSON_ID              = DL.PERSON_ID
        AND HL.CHARGE_DATE            <= W_END_DATE
        AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                             FROM HRM_HISTORY_LINE             S_HL
                                            WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                              AND S_HL.CHARGE_DATE          <= W_END_DATE
                                         GROUP BY S_HL.PERSON_ID
                                         )
        AND DL.WORK_DATE             BETWEEN W_START_DATE AND W_END_DATE
                AND PM.JOIN_DATE             <= W_END_DATE
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= W_START_DATE)
      ) T3
   WHERE WD.PERSON_ID              = T1.PERSON_ID
    AND WD.CORP_ID                = T1.WORK_CORP_ID
    AND WD.SOB_ID                 = T1.SOB_ID
    AND WD.ORG_ID                 = T1.ORG_ID
    AND WD.WORK_DATE              = T2.WORK_DATE(+)
    AND WD.CORP_ID                = T2.WORK_CORP_ID(+)
    AND WD.SOB_ID                 = T2.SOB_ID(+)
    AND WD.ORG_ID                 = T2.ORG_ID(+)
    AND WD.N_VALUE2               = T2.FLOOR_ID(+)
    AND WD.N_VALUE3               = DECODE(WD.N_VALUE3, 0, WD.N_VALUE3, T2.WORK_TYPE_ID)
    AND T2.WORK_DATE              = T3.WORK_DATE(+)
    AND T2.PERSON_ID              = T3.PERSON_ID(+)
    AND T2.WORK_CORP_ID           = T3.WORK_CORP_ID(+)
    AND T2.SOB_ID                 = T3.SOB_ID(+)
    AND T2.ORG_ID                 = T3.ORG_ID(+)
    AND WD.WORK_DATE              BETWEEN W_START_DATE AND W_END_DATE
    AND WD.N_VALUE1               = NVL(W_DUTY_MANAGER_ID, WD.N_VALUE1)
    AND WD.PERSON_ID              = NVL(W_MANAGER_ID, WD.PERSON_ID)
    AND WD.SESSION_ID             = USERENV_G.GET_SESSION_ID_F
    AND WD.RUN_DATETIME           = D_SYSDATE
    AND NVL(T2.TRANS_YN, 'A')     = NVL(W_TRANS_YN, NVL(T2.TRANS_YN, 'A'))
   GROUP BY WD.N_VALUE1
      , WD.WORK_DATE
      , T1.DEPT_NAME
      , T1.POST_NAME
      , T1.FLOOR_NAME
      , HRD_DUTY_MANAGER_G.MANAGER_NAME_F(WD.N_VALUE1)
      , T1.NAME
   ORDER BY WD.WORK_DATE, T1.NAME
    ;

  END DATA_TRANS_MANAGER;

-- DAY INTERFACE TRANS CANCEL
  PROCEDURE DATA_TRANS_CANCEL
            ( W_CORP_ID                           IN HRD_DAY_INTERFACE.CORP_ID%TYPE
            , W_WORK_DATE                         IN HRD_DAY_INTERFACE.WORK_DATE%TYPE
            , W_DUTY_MANAGER_ID                   IN HRD_DUTY_MANAGER.DUTY_MANAGER_ID%TYPE
            , P_CHECK_YN                          IN HRD_DAY_INTERFACE.TRANS_YN%TYPE
            , W_SOB_ID                            IN HRD_DAY_INTERFACE.SOB_ID%TYPE
            , W_ORG_ID                            IN HRD_DAY_INTERFACE.ORG_ID%TYPE
            )
  AS
    V_DUTY_CONTROL_ID                             HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE;
    V_WORK_TYPE_ID                                HRD_DUTY_MANAGER.WORK_TYPE_ID%TYPE;
    V_MANAGER_ID                                  HRD_DUTY_MANAGER.MANAGER_ID1%TYPE;
    V_RECORD_COUNT                                NUMBER := 0;

  BEGIN
    IF P_CHECK_YN <> 'Y' THEN
      RETURN;
    END IF;

    -- ±ÙÅÂ °ü¸® ´ÜÀ§ Á¶È¸.
    BEGIN
      SELECT DM.DUTY_CONTROL_ID, DM.WORK_TYPE_ID, DM.MANAGER_ID1
        INTO V_DUTY_CONTROL_ID, V_WORK_TYPE_ID, V_MANAGER_ID
        FROM HRD_DUTY_MANAGER DM
      WHERE DM.DUTY_MANAGER_ID    = W_DUTY_MANAGER_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Not_Found_Code, ERRNUMS.Data_Not_Found_Desc);
      RETURN;
    END;

    -- ÇØ´ç ÀÏÀÚ ÀÏ±ÙÅÂ ¸¶°¨¿©ºÎ Ã¼Å©.
    HRD_DAY_LEAVE_G.DATA_CLOSE_YN_COUNT
      ( W_CORP_ID => W_CORP_ID
      , W_WORK_DATE => W_WORK_DATE
      , W_PERSON_ID => NULL
      , W_SOB_ID => W_SOB_ID
      , W_ORG_ID => W_ORG_ID
      , W_CONNECT_PERSON_ID => V_MANAGER_ID
      , W_CAP_CHECK_YN => 'N'
      , W_FLOOR_ID => V_DUTY_CONTROL_ID
      , W_WORK_TYPE_ID => V_WORK_TYPE_ID
      , W_CLOSE_YN => 'Y'
      , O_RECORD_COUNT => V_RECORD_COUNT);

    IF V_RECORD_COUNT > 0 THEN
      RAISE_APPLICATION_ERROR(ERRNUMS.Data_Closed_Code, ERRNUMS.Data_closed_Desc);
      RETURN;
    END IF;

    -- ÃâÅð±Ù ÀÌÃ¸ Ãë¼Ò °ü¸®.
    UPDATE HRD_DAY_INTERFACE DI
      SET DI.TRANS_YN         = 'N'
       , DI.TRANS_DATE        = SYSDATE
       , DI.TRANS_PERSON_ID   = NULL
     WHERE DI.WORK_DATE             = W_WORK_DATE
      AND DI.WORK_CORP_ID           = W_CORP_ID
      AND DI.SOB_ID                 = W_SOB_ID
      AND DI.ORG_ID                 = W_ORG_ID
      AND NOT EXISTS
             ( SELECT 'X'
                  FROM HRD_DAY_LEAVE DL
               WHERE DL.WORK_DATE              = DI.WORK_DATE
                 AND DL.PERSON_ID              = DI.PERSON_ID
                 AND DL.SOB_ID                 = DI.SOB_ID
                 AND DL.ORG_ID                 = DI.ORG_ID
                 AND DL.CLOSED_YN              = 'Y'             
             )
      AND EXISTS 
            ( SELECT 'X'
                FROM HRD_DUTY_MANAGER DM
                  , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT PM.PERSON_ID
                       , PM.WORK_CORP_ID
                       , PM.SOB_ID
                       , PM.ORG_ID
                       , PM.WORK_TYPE_ID
                       , HL.FLOOR_ID
                     FROM HRM_HISTORY_LINE HL
                       , HRM_PERSON_MASTER PM
                    WHERE HL.PERSON_ID              = PM.PERSON_ID
                     AND HL.CHARGE_DATE            <= W_WORK_DATE
                     AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                  ) T1
             WHERE DM.CORP_ID                   = T1.WORK_CORP_ID
              AND DM.SOB_ID                    = T1.SOB_ID
              AND DM.ORG_ID                    = T1.ORG_ID
              AND DM.DUTY_CONTROL_ID           = T1.FLOOR_ID
              AND DM.WORK_TYPE_ID              = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, T1.WORK_TYPE_ID)
              AND T1.PERSON_ID                 = DI.PERSON_ID
              AND T1.WORK_CORP_ID              = DI.WORK_CORP_ID
              AND T1.SOB_ID                    = DI.SOB_ID
              AND T1.ORG_ID                    = DI.ORG_ID
              AND DM.DUTY_MANAGER_ID           = W_DUTY_MANAGER_ID
           )
    ;
    -- ÀÏ±ÙÅÂ ÀÚ·á »èÁ¦.
    FOR C1 IN (SELECT DL.DAY_LEAVE_ID
                    , DL.PERSON_ID
                  FROM HRD_DAY_LEAVE DL
               WHERE DL.WORK_DATE              = W_WORK_DATE
                 AND DL.WORK_CORP_ID           = W_CORP_ID
                 AND DL.SOB_ID                 = W_SOB_ID
                 AND DL.ORG_ID                 = W_ORG_ID
                 AND DL.CLOSED_YN              = 'N'
                 AND EXISTS ( SELECT 'X'
                                FROM HRD_DUTY_MANAGER DM
                                   , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                                      SELECT PM.PERSON_ID
                                           , PM.WORK_CORP_ID
                                           , PM.SOB_ID
                                           , PM.ORG_ID
                                           , PM.WORK_TYPE_ID
                                           , HL.FLOOR_ID
                                        FROM HRM_HISTORY_LINE HL
                                           , HRM_PERSON_MASTER PM
                                      WHERE HL.PERSON_ID              = PM.PERSON_ID
                                        AND HL.CHARGE_DATE            <= W_WORK_DATE
                                        AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                                             FROM HRM_HISTORY_LINE S_HL
                                                                           WHERE S_HL.CHARGE_DATE            <= W_WORK_DATE
                                                                             AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                                           GROUP BY S_HL.PERSON_ID
                                                                          )
                                    ) T1														 
                               WHERE DM.CORP_ID                   = T1.WORK_CORP_ID
                                 AND DM.SOB_ID                    = T1.SOB_ID
                                 AND DM.ORG_ID                    = T1.ORG_ID
                                 AND DM.DUTY_CONTROL_ID           = T1.FLOOR_ID
                                 AND DM.WORK_TYPE_ID              = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, T1.WORK_TYPE_ID)
                                 AND T1.PERSON_ID                 = DL.PERSON_ID
                                 AND T1.WORK_CORP_ID              = DL.WORK_CORP_ID
                                 AND T1.SOB_ID                    = DL.SOB_ID
                                 AND T1.ORG_ID                    = DL.ORG_ID
                                 AND DM.DUTY_MANAGER_ID           = W_DUTY_MANAGER_ID
                            )
              )
    LOOP 
                  
      -- ÀÏ±ÙÅÂ ¿¬Àå°è»êÀÚ·á »èÁ¦.
      DELETE FROM HRD_DAY_LEAVE_OT DLO
      WHERE DLO.DAY_LEAVE_ID  = C1.DAY_LEAVE_ID;
      
      -- ÀÏ±ÙÅÂ ÀÚ·á »èÁ¦.
      DELETE FROM HRD_DAY_LEAVE HDL
       WHERE HDL.DAY_LEAVE_ID         = C1.DAY_LEAVE_ID;
    END LOOP C1;
    /*
    -- ÀÏ±ÙÅÂ ÀÚ·á »èÁ¦.
    DELETE FROM HRD_DAY_LEAVE DL
     WHERE DL.WORK_DATE              = W_WORK_DATE
      AND DL.WORK_CORP_ID           = W_CORP_ID
      AND DL.SOB_ID                 = W_SOB_ID
      AND DL.ORG_ID                 = W_ORG_ID
      AND EXISTS ( SELECT 'X'
             FROM HRD_DUTY_MANAGER DM
               , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                SELECT PM.PERSON_ID
                   , PM.WORK_CORP_ID
                   , PM.SOB_ID
                   , PM.ORG_ID
                   , PM.WORK_TYPE_ID
                   , HL.FLOOR_ID
                 FROM HRM_HISTORY_LINE HL
                   , HRM_PERSON_MASTER PM
                WHERE HL.PERSON_ID              = PM.PERSON_ID
                 AND HL.CHARGE_DATE            <= W_WORK_DATE
                 AND HL.HISTORY_LINE_ID        IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE             S_HL
                                                     WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                       AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                  GROUP BY S_HL.PERSON_ID
                                                  )
               ) T1
             WHERE DM.CORP_ID                   = T1.WORK_CORP_ID
              AND DM.SOB_ID                    = T1.SOB_ID
              AND DM.ORG_ID                    = T1.ORG_ID
              AND DM.DUTY_CONTROL_ID           = T1.FLOOR_ID
              AND DM.WORK_TYPE_ID              = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, T1.WORK_TYPE_ID)
              AND T1.PERSON_ID                 = DL.PERSON_ID
              AND T1.WORK_CORP_ID              = DL.WORK_CORP_ID
              AND T1.SOB_ID                    = DL.SOB_ID
              AND T1.ORG_ID                    = DL.ORG_ID
              AND DM.DUTY_MANAGER_ID           = W_DUTY_MANAGER_ID
           )
    ;*/
 END DATA_TRANS_CANCEL;



-- DAY INTERFACE TRANSFER MAIN.
   PROCEDURE DATA_TRANSFER_MAIN
           ( W_CORP_ID            IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_WORK_DATE          IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
           , W_WORK_TYPE_ID       IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_CONNECT_LEVEL      IN  VARCHAR2 DEFAULT 'A'
           , W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , W_CAP_CHECK_YN       IN  VARCHAR2
           , P_USER_ID            IN  HRD_DAY_LEAVE.CREATED_BY%TYPE
           )
   AS
             V_CLOSE_RECORD_COUNT     NUMBER := 0;
             V_CONNECT_PERSON_ID      HRM_PERSON_MASTER.PERSON_ID%TYPE := W_CONNECT_PERSON_ID;

   BEGIN
             /*-- ÀÌÃ¸µÈ ÀÚ·á¼ö Á¶È¸.
             HRD_DAY_LEAVE_G.DATA_CLOSE_YN_COUNT( W_CORP_ID           => W_CORP_ID
                                                , W_WORK_DATE         => W_WORK_DATE
                                                , W_PERSON_ID         => W_PERSON_ID
                                                , W_SOB_ID            => W_SOB_ID
                                                , W_ORG_ID            => W_ORG_ID
                                                , W_CONNECT_PERSON_ID => V_CONNECT_PERSON_ID
                                                , W_CAP_CHECK_YN      => 'N'
                                                , W_FLOOR_ID          => W_FLOOR_ID
                                                , W_WORK_TYPE_ID      => W_WORK_TYPE_ID
                                                , W_CLOSE_YN          => 'Y'
                                                , O_RECORD_COUNT      => V_CLOSE_RECORD_COUNT);

             IF V_CLOSE_RECORD_COUNT > 0 THEN
                RAISE_APPLICATION_ERROR(ERRNUMS.Transfer_Completed_Code, ERRNUMS.Transfer_Completed_Desc);
                RETURN;
             END IF;
*/
             -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
             IF W_CONNECT_LEVEL = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

             -- WORK DAY DATA --> TRANSFER DAY LEAV.
             DATA_TRANSFER_GO1( W_CORP_ID           => W_CORP_ID
                              , W_WORK_DATE         => W_WORK_DATE
                              , W_WORK_TYPE_ID      => W_WORK_TYPE_ID
                              , W_FLOOR_ID          => W_FLOOR_ID
                              , W_PERSON_ID         => W_PERSON_ID
                              , W_CONNECT_PERSON_ID => V_CONNECT_PERSON_ID
                              , W_SOB_ID            => W_SOB_ID
                              , W_ORG_ID            => W_ORG_ID
                              , P_USER_ID           => P_USER_ID
                              );

   END DATA_TRANSFER_MAIN;


-- DAY INTERFACE TRANSFER GO1.
   PROCEDURE DATA_TRANSFER_GO1
           ( W_CORP_ID            IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
           , W_WORK_DATE          IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
           , W_WORK_TYPE_ID       IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
           , W_FLOOR_ID           IN  HRM_COMMON.COMMON_ID%TYPE
           , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
           , W_CONNECT_PERSON_ID  IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
           , W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
           , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
           , P_USER_ID            IN  HRD_DAY_LEAVE.CREATED_BY%TYPE
           )

   AS
             V_SYSDATE                DATE := GET_LOCAL_DATE(W_SOB_ID);

   BEGIN
             BEGIN
                  INSERT INTO HRD_DAY_LEAVE
                            ( DAY_LEAVE_ID
                            , PERSON_ID
                            , WORK_DATE
                            , WORK_CORP_ID
                            , CORP_ID
                            , DEPT_ID
                            , POST_ID
                            , JOB_CATEGORY_ID
                            , DUTY_ID
                            , HOLY_TYPE
                            , OPEN_TIME
                            , CLOSE_TIME
                            , OPEN_TIME1
                            , CLOSE_TIME1
                            , NEXT_DAY_YN
                            , DANGJIK_YN
                            , ALL_NIGHT_YN
                            , ATTRIBUTE10
                            , SOB_ID
                            , ORG_ID
                            , CREATION_DATE
                            , CREATED_BY
                            , LAST_UPDATE_DATE
                            , LAST_UPDATED_BY
                            )
                            SELECT HRD_DAY_LEAVE_S1.NEXTVAL
                                 , DI.PERSON_ID
                                 , DI.WORK_DATE
                                 , DI.WORK_CORP_ID
                                 , DI.CORP_ID
                                 , DI.DEPT_ID
                                 , DI.POST_ID
                                 , DI.JOB_CATEGORY_ID
                                 , DI.DUTY_ID AS DUTY_ID
                                 , NVL(WC.HOLY_TYPE, DI.HOLY_TYPE) AS HOLY_TYPE
                                 , CASE
                                       WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                                       ELSE DI.OPEN_TIME
                                  END AS OPEN_TIME
                                 , CASE
                                       WHEN (DI.NEXT_DAY_YN = 'Y' OR NVL(WC.HOLY_TYPE, DI.HOLY_TYPE) IN('3', 'N') 
                                             OR NVL(WC.DANGJIK_YN, DI.DANGJIK_YN) = 'Y' 
                                             OR NVL(WC.ALL_NIGHT_YN, DI.ALL_NIGHT_YN) = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
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
                                 , DI.NEXT_DAY_YN
                                 , NVL(WC.DANGJIK_YN, DI.DANGJIK_YN)  AS DANGJIK_YN
                                 , NVL(WC.ALL_NIGHT_YN, DI.ALL_NIGHT_YN) AS ALL_NIGHT_YN
                                 , WC.WORK_TYPE_GROUP        AS WORK_TYPE_GROUP
                                 , DI.SOB_ID
                                 , DI.ORG_ID
                                 , V_SYSDATE
                                 , P_USER_ID
                                 , V_SYSDATE
                                 , P_USER_ID
                              FROM HRD_DAY_INTERFACE DI
                                 , HRM_PERSON_MASTER PM
                                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                                    SELECT HL.PERSON_ID
                                         , HL.DEPT_ID
                                         , HL.POST_ID
                                         , HL.JOB_CATEGORY_ID
                                      FROM HRM_HISTORY_LINE HL
                                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                                      FROM HRM_HISTORY_LINE      S_HL
                                                                     WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                                       AND S_HL.CHARGE_DATE  <=  W_WORK_DATE
                                                                  GROUP BY S_HL.PERSON_ID
                                                                  )
                                  ) T1
                                , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                                   SELECT PH.PERSON_ID
                                        , PH.FLOOR_ID
                                     FROM HRD_PERSON_HISTORY        PH
                                    WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                                      AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                                  ) T2
                                 , HRD_DAY_MODIFY I_DM
                                 , HRD_DAY_MODIFY O_DM
                                 , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                                    SELECT HWC.WORK_DATE AS WORK_DATE
                                         , HWC.PERSON_ID
                                         , HWC.CORP_ID
                                         , HWC.SOB_ID
                                         , HWC.ORG_ID
                                         , HWC.HOLY_TYPE
                                         , HWC.DUTY_ID
                                         , HWC.DANGJIK_YN
                                         , HWC.ALL_NIGHT_YN
                                         , WT.WORK_TYPE_GROUP
                                      FROM HRD_WORK_CALENDAR HWC
                                         , HRM_WORK_TYPE_V   WT
                                     WHERE HWC.WORK_TYPE_ID  = WT.WORK_TYPE_ID
                                       AND HWC.WORK_DATE     = W_WORK_DATE
                                       AND HWC.PERSON_ID     = NVL(W_PERSON_ID, HWC.PERSON_ID)
                                       AND HWC.WORK_CORP_ID  = W_CORP_ID
                                       AND HWC.SOB_ID        = W_SOB_ID
                                       AND HWC.ORG_ID        = W_ORG_ID
                                   ) WC
                                 , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
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
                                       AND DIT.WORK_CORP_ID  = W_CORP_ID
                                       AND DIT.SOB_ID        = W_SOB_ID
                                       AND DIT.ORG_ID        = W_ORG_ID
                                   ) N_DI
                             WHERE DI.PERSON_ID      =  PM.PERSON_ID
                               AND DI.PERSON_ID      =  T1.PERSON_ID
                               AND DI.PERSON_ID      =  T2.PERSON_ID
                               AND DI.PERSON_ID      =  I_DM.PERSON_ID(+)
                               AND DI.WORK_DATE      =  I_DM.WORK_DATE(+)
                               AND '1'               =  I_DM.IO_FLAG(+)
                               AND DI.PERSON_ID      =  O_DM.PERSON_ID(+)
                               AND DI.WORK_DATE      =  O_DM.WORK_DATE(+)
                               AND '2'               =  O_DM.IO_FLAG(+)
                               AND DI.WORK_DATE      =  WC.WORK_DATE(+)
                               AND DI.PERSON_ID      =  WC.PERSON_ID(+)
                               AND DI.SOB_ID         =  WC.SOB_ID(+)
                               AND DI.ORG_ID         =  WC.ORG_ID(+)
                               AND DI.WORK_DATE      =  N_DI.WORK_DATE(+)
                               AND DI.PERSON_ID      =  N_DI.PERSON_ID(+)
                               AND DI.SOB_ID         =  N_DI.SOB_ID(+)
                               AND DI.ORG_ID         =  N_DI.ORG_ID(+)
                               AND DI.WORK_DATE      =  W_WORK_DATE
                               AND DI.PERSON_ID      =  NVL(W_PERSON_ID, DI.PERSON_ID)
                               AND DI.WORK_CORP_ID   =  W_CORP_ID
                               AND DI.SOB_ID         =  W_SOB_ID
                               AND DI.ORG_ID         =  W_ORG_ID
                               AND DI.WORK_TYPE_ID   =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                               AND T2.FLOOR_ID       =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                               AND DI.TRANS_YN       = 'N'
                               AND PM.JOIN_DATE     <=  W_WORK_DATE
                               AND(PM.RETIRE_DATE   IS  NULL
                                OR PM.RETIRE_DATE   >=  W_WORK_DATE)
                               AND EXISTS (SELECT 'X'
                                             FROM HRD_DUTY_MANAGER DM
                                            WHERE DM.CORP_ID                                = DI.WORK_CORP_ID
                                              AND DM.DUTY_CONTROL_ID                         = T2.FLOOR_ID
                                              AND DM.WORK_TYPE_ID                            = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                              AND (NVL(W_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                              AND DM.START_DATE                              <= DI.WORK_DATE
                                              AND (DM.END_DATE IS NULL OR DM.END_DATE        >= DI.WORK_DATE)
                                              AND DM.SOB_ID                                  = DI.SOB_ID
                                              AND DM.ORG_ID                                  = DI.ORG_ID
                                          )
                                 ;


                  -- DAY_INTERFACE TABLE¿¡ TRANS_YN °ª º¯°æ.
                  UPDATE HRD_DAY_INTERFACE DI
                     SET DI.TRANS_YN                = 'Y'
                       , DI.TRANS_DATE              = V_SYSDATE
                       , DI.TRANS_PERSON_ID         = W_CONNECT_PERSON_ID
                   WHERE DI.WORK_DATE               = W_WORK_DATE
                     AND DI.PERSON_ID               = NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_CORP_ID            = W_CORP_ID
                     AND DI.SOB_ID                  = W_SOB_ID
                     AND DI.ORG_ID                  = W_ORG_ID
                     AND DI.WORK_TYPE_ID            = NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND DI.TRANS_YN                = 'N'
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DAY_LEAVE DL
                                      , HRM_PERSON_MASTER PM
                                      , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                                         SELECT HL.PERSON_ID
                                              , HL.DEPT_ID
                                              , HL.POST_ID
                                              , HL.JOB_CATEGORY_ID
                                           FROM HRM_HISTORY_LINE HL
                                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                                           FROM HRM_HISTORY_LINE      S_HL
                                                                          WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                                            AND S_HL.CHARGE_DATE  <=  W_WORK_DATE
                                                                       GROUP BY S_HL.PERSON_ID
                                                                       )
                                        ) T1
                                      , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                                         SELECT PH.PERSON_ID
                                              , PH.FLOOR_ID
                                              , PH.WORK_TYPE_ID
                                           FROM HRD_PERSON_HISTORY        PH
                                          WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                                            AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                                        ) T2
                                  WHERE DL.PERSON_ID           = PM.PERSON_ID
                                    AND DL.SOB_ID              = PM.SOB_ID
                                    AND DL.ORG_ID              = PM.ORG_ID
                                    AND DL.PERSON_ID           = DI.PERSON_ID
                                    AND DL.WORK_DATE           = DI.WORK_DATE
                                    AND DL.SOB_ID              = DI.SOB_ID
                                    AND DL.ORG_ID              = DI.ORG_ID
                                    AND PM.PERSON_ID           = T1.PERSON_ID
                                    AND PM.PERSON_ID           = T2.PERSON_ID
                                    AND T2.FLOOR_ID            = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                                    AND EXISTS (SELECT 'X'
                                                  FROM HRD_DUTY_MANAGER DM
                                                 WHERE DM.CORP_ID                                  = DL.WORK_CORP_ID
                                                   AND DM.DUTY_CONTROL_ID                          = T2.FLOOR_ID
                                                   AND DM.WORK_TYPE_ID                             = DECODE(DM.WORK_TYPE_ID, 0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                                   AND (NVL(W_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN(DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                                   AND DM.START_DATE                              <= DL.WORK_DATE
                                                   AND (DM.END_DATE IS NULL OR DM.END_DATE        >= DL.WORK_DATE)
                                                   AND DM.SOB_ID                                   = DL.SOB_ID
                                                   AND DM.ORG_ID                                   = DL.ORG_ID
                                               )
                                )
                         ;

             EXCEPTION
                  WHEN OTHERS THEN
                       RAISE_APPLICATION_ERROR(-20001, SQLERRM);
             END;

   END DATA_TRANSFER_GO1;



--[2011-12-07]Ãß°¡
  PROCEDURE UPDATE_DATA
          ( W_SOB_ID        IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID        IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID       IN  HRD_DAY_INTERFACE.LAST_UPDATED_BY%TYPE
          , W_WORK_DATE     IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_PERSON_ID     IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , P_DANGJIK_YN    IN  HRD_DAY_INTERFACE.DANGJIK_YN%TYPE
          , P_NEXT_DAY_YN   IN  HRD_DAY_INTERFACE.NEXT_DAY_YN%TYPE
          , P_ALL_NIGHT_YN  IN  HRD_DAY_INTERFACE.ALL_NIGHT_YN%TYPE
          )


  AS

            V_CORP_ID           NUMBER;
            V_APPROVE_STATUS    VARCHAR2(5);

  BEGIN

            BEGIN
                 SELECT PM.CORP_ID
                   INTO V_CORP_ID
                   FROM HRM_PERSON_MASTER PM
                  WHERE PM.PERSON_ID    = W_PERSON_ID
                      ;
            EXCEPTION WHEN OTHERS THEN
                 V_CORP_ID := 65;
            END;


            -- ÀÌÃ¸ Ã¼Å©.
            V_APPROVE_STATUS := 'N';
            V_APPROVE_STATUS := HRD_DAY_INTERFACE_G.TRANSFER_YN_F( W_CORP_ID   => V_CORP_ID
                                                                 , W_WORK_DATE => W_WORK_DATE
                                                                 , W_PERSON_ID => W_PERSON_ID
                                                                 , W_SOB_ID    => W_SOB_ID
                                                                 , W_ORG_ID    => W_ORG_ID
                                                                 );

            IF V_APPROVE_STATUS = 'Y' THEN
               RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10053', NULL));
               RETURN;
            END IF;


            UPDATE HRD_DAY_INTERFACE DI
               SET DI.NEXT_DAY_YN          = NVL(P_NEXT_DAY_YN, 'N')
                 , DI.DANGJIK_YN           = NVL(P_DANGJIK_YN, 'N')
                 , DI.ALL_NIGHT_YN         = NVL(P_ALL_NIGHT_YN, 'N')
                 , DI.LAST_UPDATE_DATE     = GET_LOCAL_DATE(DI.SOB_ID)
                 , DI.LAST_UPDATED_BY      = P_USER_ID
             WHERE DI.PERSON_ID            = W_PERSON_ID
               AND DI.WORK_DATE            = W_WORK_DATE
               AND DI.SOB_ID               = W_SOB_ID
               AND DI.ORG_ID               = W_ORG_ID
                 ;


  END UPDATE_DATA;





       --ÃâÅð±ÙÁ¶È¸(±â°£) [2011-07-29][2011-08-11][2011-11-03]
       PROCEDURE SELECT_DATA_1
               ( P_CURSOR             OUT TYPES.TCURSOR
               , W_SOB_ID             IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
               , W_ORG_ID             IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
               , W_CORP_ID            IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
               , W_WORK_CORP_ID       IN  HRD_DAY_INTERFACE.WORK_CORP_ID%TYPE
               , W_FLOOR_ID           IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
               , W_DEPT_ID            IN  HRD_DAY_INTERFACE.DEPT_ID%TYPE
               , W_WORK_DATE_FR       IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
               , W_WORK_DATE_TO       IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
               , W_WORK_TYPE_ID       IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
               , W_PERSON_ID          IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
               , W_EMPLOYE_TYPE       IN  HRM_PERSON_MASTER.EMPLOYE_TYPE%TYPE
               , W_CONNECT_PERSON_ID  IN HRM_PERSON_MASTER.PERSON_ID%TYPE DEFAULT NULL
               )

       AS
         V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
       BEGIN
            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
            IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_CORP_ID
                                      , W_START_DATE   =>  SYSDATE
                                      , W_END_DATE     =>  SYSDATE
                                      , W_MODULE_CODE  =>  '20'
                                      , W_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                      , W_SOB_ID       =>  W_SOB_ID
                                      , W_ORG_ID       =>  W_ORG_ID) = 'C' THEN
               V_CONNECT_PERSON_ID := NULL;
            ELSE
               V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
            END IF;
            
            OPEN P_CURSOR FOR
                 SELECT DI.WORK_DATE
                      , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY
                      , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                      , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)        AS DUTY_NAME
                      , DI.DANGJIK_YN   AS D
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
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
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
                                  ) = '3' -- ¾ß°£
                                      AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                       OR DI.DUTY_ID        = 1170 -- ±³À°
                                       OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                       OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                       OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                       OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                       OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                       OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                         ) THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                       AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                         , 1174 -- °æÁ¶ÈÞ°¡
                                                                         , 1175 -- ³âÂ÷
                                                                         , 1177 -- º¸°ÇÈÞ°¡
                                                                         , 1178 -- ¿¬ÁßÈÞ°¡
                                                                         , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                         , 1182 -- ¹«±ÞÈÞÀÏ
                                                                         , 1187 -- ÈÞÀÏ±Ù¹«
                                                                         , 1188 -- ÈÞÀÏ
                                                                         , 1189 -- ¹«±ÞÈÞ°¡
                                                                         , 1190 -- À¯±ÞÈÞ°¡
                                                                         , 1194 -- ´çÁ÷
                                                                         , 3784 -- Ã¶¾ß
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
                                                           ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                        AND (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                             WHEN (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- ÈÄÀÏÅð±Ù
                                      AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                       OR DI.DUTY_ID        = 1170 -- ±³À°
                                       OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                       OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                       OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                       OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                       OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                       OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                         ) THEN NULL
                             WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                  AND (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                      THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                              FROM HRD_DAY_INTERFACE S_DI
                                                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                               AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                           ))
                             WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                  AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                  AND (SELECT S_DI.ALL_NIGHT_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                      THEN NULL
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                             ELSE DI.CLOSE_TIME
                        END AS CLOSE_TIME
                      , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS I_MODIFY_DESC
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
                      , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                      , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                      , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND(SELECT S_DI.HOLY_TYPE
                                                             FROM HRD_DAY_INTERFACE   S_DI
                                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                          ) = '3' -- ¾ß°£
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                       AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                       AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                       AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                       AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                       AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                       AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                       AND (SELECT DI.HOLY_TYPE
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '3' THEN '' -- ¾ß°£
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                       AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                       AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                       AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                             FROM HRD_DAY_INTERFACE_V   S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                              FROM HRD_DAY_INTERFACE   S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = '3'
                                                        OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
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
                      , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                              , HL.OCPT_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE      S_HL
                                                          WHERE S_HL.PERSON_ID     =  HL.PERSON_ID
                                                            AND S_HL.CHARGE_DATE  <=  W_WORK_DATE_TO
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
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
                  AND DI.CORP_ID                            =  NVL(W_CORP_ID, DI.CORP_ID)
                  AND DI.WORK_CORP_ID                       =  NVL(W_WORK_CORP_ID, DI.WORK_CORP_ID)
                  AND DI.SOB_ID                             =  W_SOB_ID
                  AND DI.ORG_ID                             =  W_ORG_ID
                  AND DI.WORK_DATE                             BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                  AND DI.PERSON_ID                          =  NVL(W_PERSON_ID, DI.PERSON_ID)
                  AND DI.WORK_TYPE_ID                       =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                  AND T1.DEPT_ID                            =  NVL(W_DEPT_ID, T1.DEPT_ID)
                  AND T2.FLOOR_ID                           =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                  AND PM.EMPLOYE_TYPE                       =  NVL(W_EMPLOYE_TYPE, PM.EMPLOYE_TYPE)
                  AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                           )
             ORDER BY HF.FLOOR_CODE
                    , PM.WORK_TYPE_ID
                    , PM.NAME
                    , DI.WORK_DATE
                    ;

       END SELECT_DATA_1;



  --2011-08-19[Ãß°¡]
  PROCEDURE SELECT_DATA_2
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE           IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_MODIFY_YN           IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_TRANS_YN            IN  HRD_DAY_INTERFACE.TRANS_YN%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_CONNECT_LEVEL       IN  VARCHAR2 DEFAULT 'A'
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID             IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
          )

  AS

            V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
            V_MESSAGE            VARCHAR2(300);

  BEGIN
            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
             IF W_CONNECT_LEVEL = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;

            -- ±ÙÅÂ Áý°è.
            HRD_DAY_INTERFACE_G_SET.SET_MAIN
                                  ( P_CONNECT_PERSON_ID => W_CONNECT_PERSON_ID
                                  , P_CONNECT_LEVEL     => W_CONNECT_LEVEL
                                  , P_WORK_DATE         => W_WORK_DATE
                                  , P_CORP_ID           => W_CORP_ID
                                  , P_SOB_ID            => W_SOB_ID
                                  , P_ORG_ID            => W_ORG_ID
                                  , P_USER_ID           => P_USER_ID
                                  , O_MESSAGE           => V_MESSAGE
                                  );

            OPEN P_CURSOR FOR
            SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                 , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                 , DI.PERSON_ID
                 , PM.DISPLAY_NAME
                 , DI.DUTY_ID
                 , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                 , DI.HOLY_TYPE
                 , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                 , DI.TRANS_YN AS TRANS_YN
                 , DI.ALL_NIGHT_YN
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
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
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
                                  ) = '3' -- ¾ß°£
                                      AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                       OR DI.DUTY_ID        = 1170 -- ±³À°
                                       OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                       OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                       OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                       OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                       OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                       OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                         ) THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                       AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                       AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                         , 1174 -- °æÁ¶ÈÞ°¡
                                                                         , 1175 -- ³âÂ÷
                                                                         , 1177 -- º¸°ÇÈÞ°¡
                                                                         , 1178 -- ¿¬ÁßÈÞ°¡
                                                                         , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                         , 1182 -- ¹«±ÞÈÞÀÏ
                                                                         , 1187 -- ÈÞÀÏ±Ù¹«
                                                                         , 1188 -- ÈÞÀÏ
                                                                         , 1189 -- ¹«±ÞÈÞ°¡
                                                                         , 1190 -- À¯±ÞÈÞ°¡
                                                                         , 1194 -- ´çÁ÷
                                                                         , 3784 -- Ã¶¾ß
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
                                                           ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                        AND (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                             WHEN (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- ÈÄÀÏÅð±Ù
                                      AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                       OR DI.DUTY_ID        = 1170 -- ±³À°
                                       OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                       OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                       OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                       OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                       OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                       OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                       OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                         ) THEN NULL
                             WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                  AND (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                      THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                              FROM HRD_DAY_INTERFACE S_DI
                                                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                               AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                           ))
                             WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                  AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                  AND (SELECT S_DI.ALL_NIGHT_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                      THEN NULL
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                             ELSE DI.CLOSE_TIME
                        END AS CLOSE_TIME
                 , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                 , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND(SELECT S_DI.HOLY_TYPE
                                                             FROM HRD_DAY_INTERFACE   S_DI
                                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                          ) = '3' -- ¾ß°£
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                       AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                       AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                       AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                       AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                       AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                       AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                       AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                       AND (SELECT DI.HOLY_TYPE
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '3' THEN '' -- ¾ß°£
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                       AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                       AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                        OR DI.DUTY_ID = 1170 -- ±³À°
                                                        OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                        OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                        OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                        OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                        OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                        OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                        OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                        OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                        OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                        OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                       AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                       AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                             FROM HRD_DAY_INTERFACE_V   S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                              FROM HRD_DAY_INTERFACE   S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = '3'
                                                        OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                              FROM HRD_DAY_INTERFACE_V S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = 'Y') THEN ''
                             ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                        END  AS APPROVE_STATUS_NAME
                 , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                 , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                 , DI.NEXT_DAY_YN
                 , DI.DANGJIK_YN
                 , CASE
                        WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                        ELSE DI.OPEN_TIME1
                   END AS OPEN_TIME1
                 , CASE
                        WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                        ELSE DI.CLOSE_TIME1
                   END AS CLOSE_TIME1
                 , DI.LEAVE_ID
                 , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                 , DI.LEAVE_TIME_CODE
                 , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                 , DI.DESCRIPTION
                 , DI.WORK_DATE
                 , DI.CORP_ID
                 , DI.WORK_CORP_ID
                 , DI.WORK_TYPE_GROUP AS WORK_GROUP
                 , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                 , PM.RETIRE_DATE
                 , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                 , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                 , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                 , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                 , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                 , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                 , PM.JOIN_DATE
              FROM HRD_DAY_INTERFACE_V DI
                 , HRM_PERSON_MASTER PM
                 , HRM_FLOOR_V HF
                 , HRM_POST_CODE_V PC
                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT HL.PERSON_ID
                         , HL.DEPT_ID
                         , HL.POST_ID
                         , HL.JOB_CATEGORY_ID
                         , HL.OCPT_ID
                         , HL.JOB_CLASS_ID
                      FROM HRM_HISTORY_LINE HL
                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE             S_HL
                                                     WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                       AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                  GROUP BY S_HL.PERSON_ID
                                                  )
                   ) T1
                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                      FROM HRD_PERSON_HISTORY        PH
                     WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                       AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                   ) T2
                 , HRD_DAY_MODIFY I_DM
                 , HRD_DAY_MODIFY O_DM
                 , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                    SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                         , DIT.PERSON_ID
                         , DIT.CORP_ID
                         , DIT.SOB_ID
                         , DIT.ORG_ID
                         , DIT.OPEN_TIME
                         , DIT.CLOSE_TIME
                         , DIT.OPEN_TIME1
                         , DIT.CLOSE_TIME1
                      FROM HRD_DAY_INTERFACE    DIT
                     WHERE DIT.WORK_DATE     =  W_WORK_DATE + 1
                       AND DIT.PERSON_ID     =  NVL(W_PERSON_ID, DIT.PERSON_ID)
                       AND DIT.WORK_CORP_ID  =  W_CORP_ID
                       AND DIT.SOB_ID        =  W_SOB_ID
                       AND DIT.ORG_ID        =  W_ORG_ID
                   ) N_DI
               WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                 AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                 AND DI.SOB_ID                                   =  PM.SOB_ID
                 AND DI.ORG_ID                                   =  PM.ORG_ID
                 AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                 AND PM.POST_ID                                  =  PC.POST_ID
                 AND PM.PERSON_ID                                =  T1.PERSON_ID
                 AND PM.PERSON_ID                                =  T2.PERSON_ID
                 AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                 AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                 AND '1'                                         =  I_DM.IO_FLAG(+)
                 AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                 AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                 AND '2'                                         =  O_DM.IO_FLAG(+)
                 AND DI.WORK_DATE                                =  N_DI.WORK_DATE(+)
                 AND DI.PERSON_ID                                =  N_DI.PERSON_ID(+)
                 AND DI.SOB_ID                                   =  N_DI.SOB_ID(+)
                 AND DI.ORG_ID                                   =  N_DI.ORG_ID(+)
                 AND DI.WORK_DATE                                =  W_WORK_DATE
                 AND DI.WORK_CORP_ID                             =  W_CORP_ID
                 AND DI.SOB_ID                                   =  W_SOB_ID
                 AND DI.ORG_ID                                   =  W_ORG_ID
                 AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                 AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                 AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                 --AND NVL(W_MODIFY_YN, DI.MODIFY_YN)             IN (DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
                 AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                 AND PM.JOIN_DATE                               <=  W_WORK_DATE
                 AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE)
                 AND EXISTS (SELECT 'X'
                               FROM HRD_DUTY_MANAGER DM
                              WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                AND DM.START_DATE                              <=  W_WORK_DATE
                                AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE)
                                AND DM.SOB_ID                                   =  PM.SOB_ID
                                AND DM.ORG_ID                                   =  PM.ORG_ID
                )
          ORDER BY PM.WORK_TYPE_ID
                 , T2.FLOOR_ID
                 , PM.NAME
                 ;

  END SELECT_DATA_2;



  --2011-08-19[Ãß°¡], 2011-12-07
  PROCEDURE SELECT_DATA_3
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE_FR        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_DATE_TO        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          )

  AS

            V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
            V_USER_CAP           VARCHAR2(10);

  BEGIN
            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
            V_USER_CAP := HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_CORP_ID
                                                  , W_START_DATE   =>  SYSDATE
                                                  , W_END_DATE     =>  SYSDATE
                                                  , W_MODULE_CODE  =>  '20'
                                                  , W_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                                  , W_SOB_ID       =>  W_SOB_ID
                                                  , W_ORG_ID       =>  W_ORG_ID);

            IF V_USER_CAP = 'C' THEN
               V_CONNECT_PERSON_ID := NULL;
            ELSE
               V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
            END IF;

            OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                           AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
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
                                                           ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                        AND (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DANGJIK_YN
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.DESCRIPTION
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
              FROM HRD_DAY_INTERFACE_V DI
                 , HRM_PERSON_MASTER PM
                 , HRM_FLOOR_V HF
                 , HRM_POST_CODE_V PC
                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT HL.PERSON_ID
                         , HL.DEPT_ID
                         , HL.POST_ID
                         , HL.JOB_CATEGORY_ID
                         , HL.FLOOR_ID
                         , HL.OCPT_ID
                         , HL.JOB_CLASS_ID
                      FROM HRM_HISTORY_LINE HL
                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE             S_HL
                                                     WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                       AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                  GROUP BY S_HL.PERSON_ID
                                                  )
                   ) T1
                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                      FROM HRD_PERSON_HISTORY        PH
                     WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                       AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                   ) T2
                 , HRD_DAY_MODIFY I_DM
                 , HRD_DAY_MODIFY O_DM
             WHERE DI.PERSON_ID                                =  PM.PERSON_ID
               AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
               AND DI.SOB_ID                                   =  PM.SOB_ID
               AND DI.ORG_ID                                   =  PM.ORG_ID
               AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
               AND PM.POST_ID                                  =  PC.POST_ID
               AND PM.PERSON_ID                                =  T1.PERSON_ID
               AND PM.PERSON_ID                                =  T2.PERSON_ID
               AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
               AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
               AND '1'                                         =  I_DM.IO_FLAG(+)
               AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
               AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
               AND '2'                                         =  O_DM.IO_FLAG(+)
               AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
               AND DI.WORK_CORP_ID                             =  W_CORP_ID
               AND DI.SOB_ID                                   =  W_SOB_ID
               AND DI.ORG_ID                                   =  W_ORG_ID
               AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
               AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
               AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
               AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
               AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
               AND EXISTS (SELECT 'X'
                             FROM HRD_DUTY_MANAGER DM
                            WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                              AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                              AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                              AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                              AND DM.START_DATE                              <=  W_WORK_DATE_TO
                              AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                              AND DM.SOB_ID                                   =  PM.SOB_ID
                              AND DM.ORG_ID                                   =  PM.ORG_ID
              )
          ORDER BY PM.WORK_TYPE_ID
                 , T2.FLOOR_ID
                 , PM.NAME
                 , DI.WORK_DATE
                 ;

  END SELECT_DATA_3;



  --2012-01-06[Ãß°¡]
  PROCEDURE SELECT_DATA_4
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE_FR        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_DATE_TO        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_CONNECT_PERSON_ID  IN HRM_PERSON_MASTER.PERSON_ID%TYPE DEFAULT NULL
          )

  AS
    V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
  BEGIN
            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
            IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_CORP_ID
                                      , W_START_DATE   =>  SYSDATE
                                      , W_END_DATE     =>  SYSDATE
                                      , W_MODULE_CODE  =>  '20'
                                      , W_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                      , W_SOB_ID       =>  W_SOB_ID
                                      , W_ORG_ID       =>  W_ORG_ID) = 'C' THEN
               V_CONNECT_PERSON_ID := NULL;
            ELSE
               V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
            END IF;
            
            OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , SUBSTR(HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID), 1, 2) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
                     , DI.CLOSE_TIME AS CLOSE_TIME
                     , DI.CLOSE_TIME1 AS CLOSE_TIME1
                     , TRUNC(((DI.CLOSE_TIME1 - DI.CLOSE_TIME) * 24), 0)         AS T_HOUR
                     ,(TRUNC(((DI.CLOSE_TIME1 - DI.CLOSE_TIME) * 24), 2)
                     - TRUNC(((DI.CLOSE_TIME1 - DI.CLOSE_TIME) * 24), 0)) * 60   AS T_MINUTE
                     , DI.OPEN_TIME AS OPEN_TIME
                     , DI.OPEN_TIME1 AS OPEN_TIME1
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
              FROM HRD_DAY_INTERFACE_V DI
                 , HRM_PERSON_MASTER PM
                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT HL.PERSON_ID
                         , HL.DEPT_ID
                         , HL.POST_ID
                         , HL.JOB_CATEGORY_ID
                         , HL.FLOOR_ID
                         , HL.OCPT_ID
                         , HL.JOB_CLASS_ID
                      FROM HRM_HISTORY_LINE HL
                     WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                      FROM HRM_HISTORY_LINE             S_HL
                                                     WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                       AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                  GROUP BY S_HL.PERSON_ID
                                                  )
                   ) T1
                 , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                    SELECT PH.PERSON_ID
                         , PH.FLOOR_ID
                      FROM HRD_PERSON_HISTORY        PH
                     WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                       AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                   ) T2
             WHERE DI.PERSON_ID                                =  PM.PERSON_ID
               AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
               AND DI.SOB_ID                                   =  PM.SOB_ID
               AND DI.ORG_ID                                   =  PM.ORG_ID
               AND PM.PERSON_ID                                =  T1.PERSON_ID
               AND PM.PERSON_ID                                =  T2.PERSON_ID
               AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
               AND DI.CORP_ID                                  =  NVL(W_CORP_ID, DI.CORP_ID)
               AND DI.SOB_ID                                   =  W_SOB_ID
               AND DI.ORG_ID                                   =  W_ORG_ID
               AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
               AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
               AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
               AND DI.CLOSE_TIME1                                 IS NOT NULL
               AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
               AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
               AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                           )
          ORDER BY PM.WORK_TYPE_ID
                 , PM.NAME
                 , DI.WORK_DATE
                 ;

  END SELECT_DATA_4;


  -- ÃâÅð±Ù Á¶È¸È­¸é¿¡ ÃâÅð±ÙÁ¶È¸ ÅÇ ÇÁ·Î½ÃÁ®.
  --2011-11-03
  PROCEDURE SELECT_DATA_P
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE_FR        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_WORK_DATE_TO        IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_MODIFY_YN           IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_TRANS_YN            IN  HRD_DAY_INTERFACE.TRANS_YN%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_CONNECT_LEVEL       IN  VARCHAR2 DEFAULT 'A'
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID             IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
          , W_SORT                IN  VARCHAR2
          )

  AS


            V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
            V_MESSAGE            VARCHAR2(300);


  BEGIN
            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
            IF HRM_MANAGER_G.USER_CAP_F( W_CORP_ID      =>  W_CORP_ID
                                      , W_START_DATE   =>  W_WORK_DATE_FR
                                      , W_END_DATE     =>  W_WORK_DATE_TO
                                      , W_MODULE_CODE  =>  '20'
                                      , W_PERSON_ID    =>  W_CONNECT_PERSON_ID
                                      , W_SOB_ID       =>  W_SOB_ID
                                      , W_ORG_ID       =>  W_ORG_ID) = 'C' THEN
               V_CONNECT_PERSON_ID := NULL;
            ELSE
               V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
            END IF;
            
            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
             IF W_CONNECT_LEVEL = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             END IF;



             IF NVL(W_SORT, 'A') = 'A' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                           AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
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
                                                           ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                        AND (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DANGJIK_YN
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.DESCRIPTION
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.FLOOR_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND NVL(W_MODIFY_YN, DI.MODIFY_YN)             IN (DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY PM.WORK_TYPE_ID
                     , T2.FLOOR_ID
                     , PM.NAME
                     , DI.WORK_DATE
                     ;



             ELSIF NVL(W_SORT, 'D') = 'D' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DANGJIK_YN
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.DESCRIPTION
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.FLOOR_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND NVL(W_MODIFY_YN, DI.MODIFY_YN)             IN (DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)
                     , DI.WORK_DATE
                     , PM.NAME
                     ;



             ELSIF NVL(W_SORT, 'H') = 'H' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DANGJIK_YN
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.DESCRIPTION
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.FLOOR_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND NVL(W_MODIFY_YN, DI.MODIFY_YN)             IN (DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY DI.HOLY_TYPE
                     , DI.WORK_DATE
                     , PM.NAME
                     ;



             ELSIF NVL(W_SORT, 'O') = 'O' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DANGJIK_YN
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.DESCRIPTION
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.FLOOR_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND NVL(W_MODIFY_YN, DI.MODIFY_YN)             IN (DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY TO_CHAR(DI.OPEN_TIME, 'HH24:MI')
                     , DI.WORK_DATE
                     ;



             ELSIF NVL(W_SORT, 'C') = 'C' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.WORK_DATE
                     , SUBSTR(TO_CHAR(DI.WORK_DATE, 'DAY', 'NLS_DATE_LANGUAGE=KOREAN'), 1, 1)    AS W
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.NEXT_DAY_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DANGJIK_YN
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.DESCRIPTION
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID)        AS FLOOR_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.FLOOR_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE_TO
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE_TO
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE_TO
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                   BETWEEN W_WORK_DATE_FR AND W_WORK_DATE_TO
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND NVL(W_MODIFY_YN, DI.MODIFY_YN)             IN (DI.MODIFY_YN, DI.MODIFY_IN_YN, DI.MODIFY_OUT_YN)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE_TO
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE_FR)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE_TO
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE_FR)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY TO_CHAR(DI.CLOSE_TIME, 'HH24:MI')
                     , DI.WORK_DATE
                     ;
             END IF;

  END SELECT_DATA_P;




--[2011-11-03]
  PROCEDURE SELECT_DATA_M
          ( P_CURSOR              OUT TYPES.TCURSOR
          , W_CORP_ID             IN  HRD_DAY_INTERFACE.CORP_ID%TYPE
          , W_WORK_DATE           IN  HRD_DAY_INTERFACE.WORK_DATE%TYPE
          , W_MODIFY_YN           IN  HRD_DAY_INTERFACE.MODIFY_YN%TYPE
          , W_WORK_TYPE_ID        IN  HRD_DAY_INTERFACE.WORK_TYPE_ID%TYPE
          , W_FLOOR_ID            IN  HRD_DUTY_MANAGER.DUTY_CONTROL_ID%TYPE
          , W_PERSON_ID           IN  HRD_DAY_INTERFACE.PERSON_ID%TYPE
          , W_TRANS_YN            IN  HRD_DAY_INTERFACE.TRANS_YN%TYPE
          , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
          , W_CONNECT_LEVEL       IN  VARCHAR2 DEFAULT 'A'
          , W_SOB_ID              IN  HRD_DAY_INTERFACE.SOB_ID%TYPE
          , W_ORG_ID              IN  HRD_DAY_INTERFACE.ORG_ID%TYPE
          , P_USER_ID             IN  HRD_DAY_INTERFACE.CREATED_BY%TYPE
          , W_SORT                IN  VARCHAR2
          )

  AS

            V_CONNECT_PERSON_ID  HRM_PERSON_MASTER.PERSON_ID%TYPE := NULL;
            V_MESSAGE            VARCHAR2(300);

  BEGIN

            -- ±ÙÅÂ±ÇÇÑ ¼³Á¤.
             IF W_CONNECT_LEVEL = 'C' THEN
                V_CONNECT_PERSON_ID := NULL;
             ELSE
                V_CONNECT_PERSON_ID := W_CONNECT_PERSON_ID;
             END IF;




            -- ±ÙÅÂ Áý°è.
            HRD_DAY_INTERFACE_G_SET.SET_MAIN
                                  ( P_CONNECT_PERSON_ID => W_CONNECT_PERSON_ID
                                  , P_CONNECT_LEVEL     => W_CONNECT_LEVEL
                                  , P_WORK_DATE         => W_WORK_DATE
                                  , P_CORP_ID           => W_CORP_ID
                                  , P_SOB_ID            => W_SOB_ID
                                  , P_ORG_ID            => W_ORG_ID
                                  , P_USER_ID           => P_USER_ID
                                  , O_MESSAGE           => V_MESSAGE
                                  );



             IF NVL(W_SORT, 'A') = 'A' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                                           AND DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, DI.CLOSE_TIME) IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
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
                                                           ) = '53' -- ÈÞÀÏ±Ù¹«(1187)
                                                        AND (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DECODE(DI.MODIFY_IN_YN, 'Y', I_DM.MODIFY_TIME, DI.OPEN_TIME) IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.NEXT_DAY_YN
                     , DI.DANGJIK_YN
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DESCRIPTION
                     , DI.WORK_DATE
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                     , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DIT.CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DIT.CLOSE_TIME1
                          FROM HRD_DAY_INTERFACE    DIT
                         WHERE DIT.WORK_DATE     =  W_WORK_DATE + 1
                           AND DIT.PERSON_ID     =  NVL(W_PERSON_ID, DIT.PERSON_ID)
                           AND DIT.WORK_CORP_ID  =  W_CORP_ID
                           AND DIT.SOB_ID        =  W_SOB_ID
                           AND DIT.ORG_ID        =  W_ORG_ID
                       ) N_DI
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                =  N_DI.WORK_DATE(+)
                     AND DI.PERSON_ID                                =  N_DI.PERSON_ID(+)
                     AND DI.SOB_ID                                   =  N_DI.SOB_ID(+)
                     AND DI.ORG_ID                                   =  N_DI.ORG_ID(+)
                     AND DI.WORK_DATE                                =  W_WORK_DATE
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY PM.WORK_TYPE_ID
                     , T2.FLOOR_ID
                     , PM.NAME
                     ;




             ELSIF NVL(W_SORT, 'D') = 'D' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.NEXT_DAY_YN
                     , DI.DANGJIK_YN
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DESCRIPTION
                     , DI.WORK_DATE
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                     , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DIT.CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DIT.CLOSE_TIME1
                          FROM HRD_DAY_INTERFACE    DIT
                         WHERE DIT.WORK_DATE     =  W_WORK_DATE + 1
                           AND DIT.PERSON_ID     =  NVL(W_PERSON_ID, DIT.PERSON_ID)
                           AND DIT.WORK_CORP_ID  =  W_CORP_ID
                           AND DIT.SOB_ID        =  W_SOB_ID
                           AND DIT.ORG_ID        =  W_ORG_ID
                       ) N_DI
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                =  N_DI.WORK_DATE(+)
                     AND DI.PERSON_ID                                =  N_DI.PERSON_ID(+)
                     AND DI.SOB_ID                                   =  N_DI.SOB_ID(+)
                     AND DI.ORG_ID                                   =  N_DI.ORG_ID(+)
                     AND DI.WORK_DATE                                =  W_WORK_DATE
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID)
                     , DI.WORK_DATE
                     , PM.NAME
                     ;




             ELSIF NVL(W_SORT, 'H') = 'H' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.NEXT_DAY_YN
                     , DI.DANGJIK_YN
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DESCRIPTION
                     , DI.WORK_DATE
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                     , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DIT.CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DIT.CLOSE_TIME1
                          FROM HRD_DAY_INTERFACE    DIT
                         WHERE DIT.WORK_DATE     =  W_WORK_DATE + 1
                           AND DIT.PERSON_ID     =  NVL(W_PERSON_ID, DIT.PERSON_ID)
                           AND DIT.WORK_CORP_ID  =  W_CORP_ID
                           AND DIT.SOB_ID        =  W_SOB_ID
                           AND DIT.ORG_ID        =  W_ORG_ID
                       ) N_DI
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                =  N_DI.WORK_DATE(+)
                     AND DI.PERSON_ID                                =  N_DI.PERSON_ID(+)
                     AND DI.SOB_ID                                   =  N_DI.SOB_ID(+)
                     AND DI.ORG_ID                                   =  N_DI.ORG_ID(+)
                     AND DI.WORK_DATE                                =  W_WORK_DATE
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY DI.HOLY_TYPE
                     , DI.WORK_DATE
                     , PM.NAME
                     ;




             ELSIF NVL(W_SORT, 'O') = 'O' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.NEXT_DAY_YN
                     , DI.DANGJIK_YN
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DESCRIPTION
                     , DI.WORK_DATE
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                     , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DIT.CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DIT.CLOSE_TIME1
                          FROM HRD_DAY_INTERFACE    DIT
                         WHERE DIT.WORK_DATE     =  W_WORK_DATE + 1
                           AND DIT.PERSON_ID     =  NVL(W_PERSON_ID, DIT.PERSON_ID)
                           AND DIT.WORK_CORP_ID  =  W_CORP_ID
                           AND DIT.SOB_ID        =  W_SOB_ID
                           AND DIT.ORG_ID        =  W_ORG_ID
                       ) N_DI
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                =  N_DI.WORK_DATE(+)
                     AND DI.PERSON_ID                                =  N_DI.PERSON_ID(+)
                     AND DI.SOB_ID                                   =  N_DI.SOB_ID(+)
                     AND DI.ORG_ID                                   =  N_DI.ORG_ID(+)
                     AND DI.WORK_DATE                                =  W_WORK_DATE
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY TO_CHAR(DI.OPEN_TIME, 'HH24:MI')
                     , DI.WORK_DATE
                     ;




             ELSIF NVL(W_SORT, 'C') = 'C' THEN



                OPEN P_CURSOR FOR
                SELECT HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE
                     , HRM_COMMON_G.ID_NAME_F(T2.FLOOR_ID) AS FLOOR_NAME
                     , DI.PERSON_ID
                     , PM.DISPLAY_NAME
                     , DI.DUTY_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , DI.HOLY_TYPE
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     , DI.TRANS_YN AS TRANS_YN
                     , DI.ALL_NIGHT_YN
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
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- ÈÞÀÏ±Ù¹«
                                                                 AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
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
                                      ) = '3' -- ¾ß°£
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1188 -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID IN ( 1173 -- ÃâÀå
                                                                             , 1174 -- °æÁ¶ÈÞ°¡
                                                                             , 1175 -- ³âÂ÷
                                                                             , 1177 -- º¸°ÇÈÞ°¡
                                                                             , 1178 -- ¿¬ÁßÈÞ°¡
                                                                             , 1179 -- ´ëÃ¼ÈÞ¹«
                                                                             , 1182 -- ¹«±ÞÈÞÀÏ
                                                                             , 1187 -- ÈÞÀÏ±Ù¹«
                                                                             , 1188 -- ÈÞÀÏ
                                                                             , 1189 -- ¹«±ÞÈÞ°¡
                                                                             , 1190 -- À¯±ÞÈÞ°¡
                                                                             , 1194 -- ´çÁ÷
                                                                             , 3784 -- Ã¶¾ß
                                                                             )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- Ã¶¾ß
                                                       ) THEN NULL
                                 WHEN (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          AND(DI.DUTY_ID        = 1174 -- °æÁ¶ÈÞ°¡
                                           OR DI.DUTY_ID        = 1170 -- ±³À°
                                           OR DI.DUTY_ID        = 1175 -- ³âÂ÷
                                           OR DI.DUTY_ID        = 1189 -- ¹«±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1182 -- ¹«±ÞÈÞÀÏ
                                           OR DI.DUTY_ID        = 1172 -- ÆÄ°ß
                                           OR DI.DUTY_ID        = 1190 -- À¯±ÞÈÞ°¡
                                           OR DI.DUTY_ID        = 1173 -- ÃâÀå
                                           OR DI.DUTY_ID        = 1171 -- ÈÆ·Ã
                                           OR DI.DUTY_ID        = 1188 -- ÈÞÀÏ
                                             ) THEN NULL
                                 WHEN DI.DUTY_ID        = 1168 -- Ãâ±Ù
                                      AND (SELECT S_DI.NEXT_DAY_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÈÄÀÏÅð±Ù
                                          THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                                  FROM HRD_DAY_INTERFACE S_DI
                                                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                   AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                               ))
                                 WHEN DI.DUTY_ID  = 1168 -- Ãâ±Ù
                                      AND DI.OPEN_TIME  IS NULL
                                      AND (SELECT S_DI.ALL_NIGHT_YN
                                             FROM HRD_DAY_INTERFACE   S_DI
                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                          ) = 'Y' -- ÀüÀÏ Ã¶¾ß
                                          THEN NULL
                                 WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                                 ELSE DI.CLOSE_TIME
                            END AS CLOSE_TIME
                     , HRM_COMMON_G.ID_NAME_F(NVL(I_DM.MODIFY_ID, O_DM.MODIFY_ID)) AS MODIFY_DESC
                     , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1187 THEN '' -- ÈÞÀÏ±Ù¹«
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND DI.DUTY_ID    = 1169 -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '2' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NULL
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND(SELECT S_DI.HOLY_TYPE
                                                                 FROM HRD_DAY_INTERFACE   S_DI
                                                                WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                  AND S_DI.ORG_ID       = DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                              ) = '3' -- ¾ß°£
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    = 1168 -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'  -- ¾ß°£
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
                                                           AND DI.DUTY_ID    = 1168  -- Ãâ±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
                                                           AND (SELECT S_DI.CLOSE_TIME
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                               ) IS NOT NULL THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.DUTY_ID    = 1169  -- °á±Ù
                                                           AND DI.HOLY_TYPE  = '3'   -- ¾ß°£
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
                                                           AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
                                                           AND DI.HOLY_TYPE    = '1'  -- ÈÞÀÏ
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
                                                           AND DI.DUTY_ID    = 1188      -- ÈÞÀÏ
                                                           AND (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V   S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND DI.DUTY_ID    =  1177 -- º¸°ÇÈÞ°¡
                                                           AND (SELECT DI.HOLY_TYPE
                                                                  FROM HRD_DAY_INTERFACE     S_DI
                                                                 WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                   AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                               ) = '3' THEN '' -- ¾ß°£
                                 WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- ÈÞÀÏ±Ù¹«
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
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
                                                           AND(DI.DUTY_ID = 1174 -- °æÁ¶ÈÞ°¡
                                                            OR DI.DUTY_ID = 1170 -- ±³À°
                                                            OR DI.DUTY_ID = 1175 -- ³âÂ÷
                                                            OR DI.DUTY_ID = 1179 -- ´ëÃ¼ÈÞ¹«
                                                            OR DI.DUTY_ID = 1189 -- ¹«±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1182 -- ¹«±ÞÈÞÀÏ
                                                            OR DI.DUTY_ID = 1177 -- º¸°ÇÈÞ°¡
                                                            OR DI.DUTY_ID = 1178 -- ¿¬ÁßÈÞ°¡
                                                            OR DI.DUTY_ID = 1190 -- À¯±ÞÈÞ°¡
                                                            OR DI.DUTY_ID = 1172 -- ÆÄ°ß
                                                            OR DI.DUTY_ID = 1173 -- ÃâÀå
                                                            OR DI.DUTY_ID = 1171 -- ÈÆ·Ã
                                                            OR DI.DUTY_ID = 1188 -- ÈÞÀÏ
                                                              ) THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- ÈÞÀÏ±Ù¹«
                                                           AND DI.ALL_NIGHT_YN = 'Y'  -- Ã¶¾ß
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
                                                           AND(SELECT S_DI.DUTY_ID -- ÈÞÀÏ±Ù¹«
                                                                 FROM HRD_DAY_INTERFACE     S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 1187  -- ÈÞÀÏ±Ù¹«
                                                           AND(SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                 FROM HRD_DAY_INTERFACE_V   S_DI
                                                                WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                  AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                  AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                  AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                  AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                              ) = 'Y' THEN ''
                                 WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                           AND DI.CLOSE_TIME IS NOT NULL
                                                           AND((SELECT S_DI.HOLY_TYPE    -- ¾ß°£
                                                                  FROM HRD_DAY_INTERFACE   S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = '3'
                                                            OR (SELECT S_DI.ALL_NIGHT_YN -- Ã¶¾ß
                                                                  FROM HRD_DAY_INTERFACE_V S_DI
                                                                 WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                                   AND S_DI.ORG_ID       = DI.ORG_ID
                                                                   AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                                   AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                                   AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                               ) = 'Y') THEN ''
                                 ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                            END  AS APPROVE_STATUS_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.APPROVED_PERSON_ID)  AS APPROVED_PERSON_NAME
                     , HRM_PERSON_MASTER_G.NAME_F(DI.CONFIRMED_PERSON_ID) AS CONFIRMED_PERSON_NAME
                     , DI.NEXT_DAY_YN
                     , DI.DANGJIK_YN
                     , CASE
                            WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME1
                            ELSE DI.OPEN_TIME1
                       END AS OPEN_TIME1
                     , CASE
                            WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME1
                            ELSE DI.CLOSE_TIME1
                       END AS CLOSE_TIME1
                     , DI.LEAVE_ID
                     , HRM_COMMON_G.ID_NAME_F(DI.LEAVE_ID) AS LEAVE_NAME
                     , DI.LEAVE_TIME_CODE
                     , HRM_COMMON_G.CODE_NAME_F('LEAVE_OUT_TIME', DI.LEAVE_TIME_CODE, DI.SOB_ID, DI.ORG_ID) AS LEAVE_TIME
                     , DI.DESCRIPTION
                     , DI.WORK_DATE
                     , DI.CORP_ID
                     , DI.WORK_CORP_ID
                     , DI.WORK_TYPE_GROUP AS WORK_GROUP
                     , HRM_COMMON_G.CODE_NAME_F('EMPLOYE_TYPE', PM.EMPLOYE_TYPE, PM.SOB_ID, PM.ORG_ID) AS EMPLOYE_TYPE
                     , PM.RETIRE_DATE
                     , HRM_CORP_MASTER_G.CORP_NAME_F(DI.CORP_ID)  AS CORP_NAME
                     , HRM_DEPT_MASTER_G.DEPT_NAME_F(T1.DEPT_ID)  AS DEPT_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.POST_ID)         AS POST_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CLASS_ID)    AS JOB_CLASS_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.JOB_CATEGORY_ID) AS JOB_CATEGORY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.OCPT_ID)         AS OCPT_NAME
                     , PM.JOIN_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.OCPT_ID
                             , HL.JOB_CLASS_ID
                          FROM HRM_HISTORY_LINE HL
                         WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                          FROM HRM_HISTORY_LINE             S_HL
                                                         WHERE S_HL.PERSON_ID             = HL.PERSON_ID
                                                           AND S_HL.CHARGE_DATE          <= W_WORK_DATE
                                                      GROUP BY S_HL.PERSON_ID
                                                      )
                       ) T1
                     , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                        SELECT PH.PERSON_ID
                             , PH.FLOOR_ID
                          FROM HRD_PERSON_HISTORY        PH
                         WHERE PH.EFFECTIVE_DATE_FR  <=  W_WORK_DATE
                           AND PH.EFFECTIVE_DATE_TO  >=  W_WORK_DATE
                       ) T2
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                     , (-- ÈÄÀÏ ±Ù¹« Á¤º¸ Á¶È¸.
                        SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                             , DIT.PERSON_ID
                             , DIT.CORP_ID
                             , DIT.SOB_ID
                             , DIT.ORG_ID
                             , DIT.OPEN_TIME
                             , DIT.CLOSE_TIME
                             , DIT.OPEN_TIME1
                             , DIT.CLOSE_TIME1
                          FROM HRD_DAY_INTERFACE    DIT
                         WHERE DIT.WORK_DATE     =  W_WORK_DATE + 1
                           AND DIT.PERSON_ID     =  NVL(W_PERSON_ID, DIT.PERSON_ID)
                           AND DIT.WORK_CORP_ID  =  W_CORP_ID
                           AND DIT.SOB_ID        =  W_SOB_ID
                           AND DIT.ORG_ID        =  W_ORG_ID
                       ) N_DI
                   WHERE DI.PERSON_ID                                =  PM.PERSON_ID
                     AND DI.WORK_CORP_ID                             =  PM.WORK_CORP_ID
                     AND DI.SOB_ID                                   =  PM.SOB_ID
                     AND DI.ORG_ID                                   =  PM.ORG_ID
                     AND PM.FLOOR_ID                                 =  HF.FLOOR_ID
                     AND PM.POST_ID                                  =  PC.POST_ID
                     AND PM.PERSON_ID                                =  T1.PERSON_ID
                     AND PM.PERSON_ID                                =  T2.PERSON_ID
                     AND DI.PERSON_ID                                =  I_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  I_DM.WORK_DATE(+)
                     AND '1'                                         =  I_DM.IO_FLAG(+)
                     AND DI.PERSON_ID                                =  O_DM.PERSON_ID(+)
                     AND DI.WORK_DATE                                =  O_DM.WORK_DATE(+)
                     AND '2'                                         =  O_DM.IO_FLAG(+)
                     AND DI.WORK_DATE                                =  N_DI.WORK_DATE(+)
                     AND DI.PERSON_ID                                =  N_DI.PERSON_ID(+)
                     AND DI.SOB_ID                                   =  N_DI.SOB_ID(+)
                     AND DI.ORG_ID                                   =  N_DI.ORG_ID(+)
                     AND DI.WORK_DATE                                =  W_WORK_DATE
                     AND DI.WORK_CORP_ID                             =  W_CORP_ID
                     AND DI.SOB_ID                                   =  W_SOB_ID
                     AND DI.ORG_ID                                   =  W_ORG_ID
                     AND DI.PERSON_ID                                =  NVL(W_PERSON_ID, DI.PERSON_ID)
                     AND DI.WORK_TYPE_ID                             =  NVL(W_WORK_TYPE_ID, DI.WORK_TYPE_ID)
                     AND T2.FLOOR_ID                                 =  NVL(W_FLOOR_ID, T2.FLOOR_ID)
                     AND DI.TRANS_YN                                 =  NVL(W_TRANS_YN, DI.TRANS_YN)
                     AND PM.JOIN_DATE                               <=  W_WORK_DATE
                     AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE  >=  W_WORK_DATE)
                     AND EXISTS (SELECT 'X'
                                   FROM HRD_DUTY_MANAGER DM
                                  WHERE DM.CORP_ID                                  =  PM.WORK_CORP_ID
                                    AND DM.DUTY_CONTROL_ID                          =  NVL(T2.FLOOR_ID, PM.FLOOR_ID)
                                    AND DM.WORK_TYPE_ID                             =  DECODE(DM.WORK_TYPE_ID,0, DM.WORK_TYPE_ID, DM.WORK_TYPE_ID)
                                    AND (NVL(V_CONNECT_PERSON_ID, DM.MANAGER_ID1)  IN (DM.MANAGER_ID1, DM.MANAGER_ID2, DM.APPROVER_ID1, DM.APPROVER_ID2))
                                    AND DM.START_DATE                              <=  W_WORK_DATE
                                    AND (DM.END_DATE IS NULL OR DM.END_DATE        >=  W_WORK_DATE)
                                    AND DM.SOB_ID                                   =  PM.SOB_ID
                                    AND DM.ORG_ID                                   =  PM.ORG_ID
                    )
              ORDER BY TO_CHAR(DI.CLOSE_TIME, 'HH24:MI')
                     , DI.WORK_DATE
                     ;
             END IF;


  END SELECT_DATA_M;





       -- LOOKUP PERSON INFOMATION[2011-07-29]
       PROCEDURE LU_PERSON_DUTY
               ( P_CURSOR3        OUT TYPES.TCURSOR3
               , W_CORP_ID        IN  NUMBER
               , W_WORK_TYPE_ID   IN  NUMBER
               , W_DEPT_ID        IN  NUMBER
               , W_FLOOR_ID       IN  NUMBER
               , W_SOB_ID         IN  NUMBER
               , W_ORG_ID         IN  NUMBER
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
                      , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
                         SELECT HL.PERSON_ID
                              , HL.DEPT_ID
                              , HL.POST_ID
                              , HL.PAY_GRADE_ID
                              , HL.JOB_CATEGORY_ID
                              , HL.JOB_CLASS_ID
                           FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.PERSON_ID       = HL.PERSON_ID
                                                            AND S_HL.CHARGE_DATE    <= TRUNC(SYSDATE)
                                                       GROUP BY S_HL.PERSON_ID
                                                       )
                        ) T1
                      , (-- ½ÃÁ¡ ÀÎ»ç³»¿ª.
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
                    AND PM.WORK_TYPE_ID                             = NVL(W_WORK_TYPE_ID, PM.WORK_TYPE_ID)
                    AND T1.DEPT_ID                                  = NVL(W_DEPT_ID, T1.DEPT_ID)
                    AND T2.FLOOR_ID                                 = NVL(W_FLOOR_ID, T2.FLOOR_ID)
                    AND PM.SOB_ID                                   = W_SOB_ID
                    AND PM.ORG_ID                                   = W_ORG_ID
               ORDER BY PM.NAME
                      ;

      END LU_PERSON_DUTY;




--[2011-12-07]Ãß°¡
  PROCEDURE DEFAULT_FLOOR( O_FLOOR_ID            OUT HRM_PERSON_MASTER.FLOOR_ID%TYPE
                         , O_FLOOR_NAME          OUT VARCHAR2
                         , O_PERSON_NUMBER       OUT HRM_PERSON_MASTER.PERSON_NUM%TYPE
                         , O_PERSON_NAME         OUT HRM_PERSON_MASTER.NAME%TYPE
                         , O_WORK_TYPE_ID        OUT HRM_PERSON_MASTER.WORK_TYPE_ID%TYPE
                         , O_WORK_TYPE_NAME      OUT VARCHAR2
                         , O_CAPACITY            OUT VARCHAR2
                         , W_SOB_ID              IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                         , W_ORG_ID              IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                         , W_CONNECT_PERSON_ID   IN  HRM_PERSON_MASTER.PERSON_ID%TYPE
                         )

  IS

            V_WORK_CORP_ID   HRM_PERSON_MASTER.WORK_CORP_ID%TYPE := NULL;
            V_DATE_START     DATE := TO_DATE('1999-12-31 23:59:59', 'YYYY-MM-DD HH24:MI:SS');
            V_DATE_END       DATE := TRUNC(SYSDATE);

  BEGIN

            SELECT HRM_COMMON_G.ID_NAME_F(PM.FLOOR_ID)     AS FLOOR
                 , PM.FLOOR_ID                             AS FLOOR_ID
                 , PM.PERSON_NUM                           AS PERSON_NUMBER
                 , PM.NAME                                 AS PERSON_NAME
                 , PM.WORK_TYPE_ID                         AS WORK_TYPE_ID
                 , HRM_COMMON_G.ID_NAME_F(PM.WORK_TYPE_ID) AS WORK_TYPE_NAME
                 , PM.WORK_CORP_ID                         AS WORK_CORP_ID
              INTO O_FLOOR_NAME
                 , O_FLOOR_ID
                 , O_PERSON_NUMBER
                 , O_PERSON_NAME
                 , O_WORK_TYPE_ID
                 , O_WORK_TYPE_NAME
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


            EXCEPTION
                 WHEN OTHERS
                 THEN
                      O_FLOOR_NAME     := NULL;
                      O_FLOOR_ID       := NULL;
                      O_PERSON_NUMBER  := NULL;
                      O_PERSON_NAME    := NULL;
                      O_WORK_TYPE_ID   := NULL;
                      O_WORK_TYPE_NAME := NULL;

  END DEFAULT_FLOOR;



END HRD_DAY_INTERFACE_TRANS_G;
/
