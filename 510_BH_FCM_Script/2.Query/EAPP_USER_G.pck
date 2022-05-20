CREATE OR REPLACE PACKAGE EAPP_USER_G IS
--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_USER_G[EAPF0301]
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 20-JUL-2010  Kim Dae Sung       Initialize
-- 13-AUG-2010  Kim Dae Sung       UPDATE
-- 15-SEP-2010  Jun Ho  Su         Append
-- 18-SEP-2010  Kim Dae Sung       UPDATE
-- 02-NOV-2010  Kim Dae Sung       UPDATE
--==============================================================================

       PROCEDURE EAPP_USER_SELECT1( P_CURSOR             OUT TYPES.TCURSOR
                                  , W_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , W_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  );

       PROCEDURE HRM_DEPT_MASTER_SELECT2( P_CURSOR       OUT TYPES.TCURSOR
                                        , W_SOB_ID       IN  HRM_DEPT_MASTER.SOB_ID%TYPE
                                        , W_ORG_ID       IN  HRM_DEPT_MASTER.ORG_ID%TYPE
                                        );

       PROCEDURE HRM_PERSON_MASTER_SELECT3( P_CURSOR     OUT TYPES.TCURSOR
                                          , W_SOB_ID     IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                          , W_ORG_ID     IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                          );

       PROCEDURE EAPP_USER_SELECT4( P_CURSOR             OUT TYPES.TCURSOR
                                  , W_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , W_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  , W_DESCRIPTION        IN  EAPP_USER.DESCRIPTION%TYPE
                                  , W_DEPT_NAME          IN  HRM_DEPT_MASTER.DEPT_NAME%TYPE
                                  , W_USER_TYPE          IN  EAPP_USER.USER_TYPE%TYPE
                                  );

       PROCEDURE EAPP_USER_INSERT1( O_USER_ID            OUT EAPP_USER.USER_ID%TYPE
                                  , P_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , P_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  , P_USER_NO            IN  EAPP_USER.USER_NO%TYPE
                                  , P_DESCRIPTION        IN  EAPP_USER.DESCRIPTION%TYPE
                                  , P_PASSWORD           IN  EAPP_USER.PASSWORD%TYPE
                                  , P_USER_TYPE          IN  EAPP_USER.USER_TYPE%TYPE
                                  , P_AUTHORITY_TYPE     IN  EAPP_USER.AUTHORITY_TYPE%TYPE
                                  , P_PERSON_ID          IN  EAPP_USER.PERSON_ID%TYPE
                                  , P_EFFECTIVE_DATE_FR  IN  EAPP_USER.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO  IN  EAPP_USER.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG       IN  EAPP_USER.ENABLED_FLAG%TYPE
                                  , P_USER_ID            IN  EAPP_USER.CREATED_BY%TYPE
                                  );

       PROCEDURE EAPP_USER_UPDATE1( W_EAPP_USER_ID       IN  EAPP_USER.USER_ID%TYPE
                                  , P_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , P_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  , P_USER_NO            IN  EAPP_USER.USER_NO%TYPE
                                  , P_DESCRIPTION        IN  EAPP_USER.DESCRIPTION%TYPE
                                  , P_PASSWORD           IN  EAPP_USER.PASSWORD%TYPE
                                  , P_USER_TYPE          IN  EAPP_USER.USER_TYPE%TYPE
                                  , P_AUTHORITY_TYPE     IN  EAPP_USER.AUTHORITY_TYPE%TYPE
                                  , P_PERSON_ID          IN  EAPP_USER.PERSON_ID%TYPE
                                  , P_EFFECTIVE_DATE_FR  IN  EAPP_USER.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO  IN  EAPP_USER.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG       IN  EAPP_USER.ENABLED_FLAG%TYPE
                                  , P_USER_ID            IN  EAPP_USER.LAST_UPDATED_BY%TYPE
                                  );


       PROCEDURE EAPP_RESPONSIBILITY_SELECT1( P_CURSOR               OUT TYPES.TCURSOR
                                            , W_SOB_ID               IN  EAPP_RESPONSIBILITY.SOB_ID%TYPE
                                            , W_ORG_ID               IN  EAPP_RESPONSIBILITY.ORG_ID%TYPE
                                            );

       PROCEDURE EAPP_USER_RESPONSIBLE_SELECT2( P_CURSOR             OUT TYPES.TCURSOR
                                              , W_SOB_ID             IN  EAPP_USER_RESPONSIBILITY.SOB_ID%TYPE
                                              , W_ORG_ID             IN  EAPP_USER_RESPONSIBILITY.ORG_ID%TYPE
                                              , W_USER_ID            IN  EAPP_USER_RESPONSIBILITY.USER_ID%TYPE
                                              );

       PROCEDURE EAPP_USER_RESPONSIBLE_INSERT1( P_SOB_ID             IN  EAPP_USER_RESPONSIBILITY.SOB_ID%TYPE
                                              , P_ORG_ID             IN  EAPP_USER_RESPONSIBILITY.ORG_ID%TYPE
                                              , P_EAPP_USER_ID       IN  EAPP_USER_RESPONSIBILITY.USER_ID%TYPE
                                              , P_RESPONSIBILITY_ID  IN  EAPP_USER_RESPONSIBILITY.RESPONSIBILITY_ID%TYPE
                                              , P_EFFECTIVE_DATE_FR  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_FR%TYPE
                                              , P_EFFECTIVE_DATE_TO  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_TO%TYPE
                                              , P_ENABLED_FLAG       IN  EAPP_USER_RESPONSIBILITY.ENABLED_FLAG%TYPE
                                              , P_USER_ID            IN  EAPP_USER_RESPONSIBILITY.CREATED_BY%TYPE
                                              );

       PROCEDURE EAPP_USER_RESPONSIBLE_UPDATE1( W_SOB_ID             IN  EAPP_USER_RESPONSIBILITY.SOB_ID%TYPE
                                              , W_ORG_ID             IN  EAPP_USER_RESPONSIBILITY.ORG_ID%TYPE
                                              , W_EAPP_USER_ID       IN  EAPP_USER_RESPONSIBILITY.USER_ID%TYPE
                                              , W_RESPONSIBILITY_ID  IN  EAPP_USER_RESPONSIBILITY.RESPONSIBILITY_ID%TYPE
                                              , P_EFFECTIVE_DATE_FR  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_FR%TYPE
                                              , P_EFFECTIVE_DATE_TO  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_TO%TYPE
                                              , P_ENABLED_FLAG       IN  EAPP_USER_RESPONSIBILITY.ENABLED_FLAG%TYPE
                                              , P_USER_ID            IN  EAPP_USER_RESPONSIBILITY.LAST_UPDATED_BY%TYPE
                                              );




       PROCEDURE EAPP_PROGRAM_SELECT1( P_CURSOR                    OUT TYPES.TCURSOR
                                     , W_SOB_ID                    IN  EAPP_PROGRAM.SOB_ID%TYPE
                                     , W_ORG_ID                    IN  EAPP_PROGRAM.ORG_ID%TYPE
                                     );

       PROCEDURE EAPP_USER_PRG_AUTHOR_SELECT2( P_CURSOR            OUT TYPES.TCURSOR
                                             , W_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , W_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , W_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             );

       PROCEDURE EAPP_USER_PRG_AUTHOR_INSERT1( P_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , P_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , P_EAPP_USER_ID      IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             , P_ASSEMBLY_INFO_ID  IN  EAPP_USER_PRG_AUTHORITY.ASSEMBLY_INFO_ID%TYPE
                                             , P_READ_FLAG         IN  EAPP_USER_PRG_AUTHORITY.READ_FLAG%TYPE
                                             , P_WIRTE_FLAG        IN  EAPP_USER_PRG_AUTHORITY.WIRTE_FLAG%TYPE
                                             , P_PRINT_FLAG        IN  EAPP_USER_PRG_AUTHORITY.PRINT_FLAG%TYPE
                                             , P_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.CREATED_BY%TYPE
                                             );

       PROCEDURE EAPP_USER_PRG_AUTHOR_UPDATE1( W_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , W_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , W_EAPP_USER_ID      IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             , W_ASSEMBLY_INFO_ID  IN  EAPP_USER_PRG_AUTHORITY.ASSEMBLY_INFO_ID%TYPE
                                             , P_READ_FLAG         IN  EAPP_USER_PRG_AUTHORITY.READ_FLAG%TYPE
                                             , P_WIRTE_FLAG        IN  EAPP_USER_PRG_AUTHORITY.WIRTE_FLAG%TYPE
                                             , P_PRINT_FLAG        IN  EAPP_USER_PRG_AUTHORITY.PRINT_FLAG%TYPE
                                             , P_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.LAST_UPDATED_BY%TYPE
                                             );

       PROCEDURE EAPP_USER_PRG_AUTHOR_UPDATE2( W_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , W_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , W_ASSEMBLY_INFO_ID  IN  EAPP_USER_PRG_AUTHORITY.ASSEMBLY_INFO_ID%TYPE
                                             , P_EAPP_USER_ID      IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             , P_READ_FLAG         IN  EAPP_USER_PRG_AUTHORITY.READ_FLAG%TYPE
                                             , P_WIRTE_FLAG        IN  EAPP_USER_PRG_AUTHORITY.WIRTE_FLAG%TYPE
                                             , P_PRINT_FLAG        IN  EAPP_USER_PRG_AUTHORITY.PRINT_FLAG%TYPE
                                             , P_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.LAST_UPDATED_BY%TYPE
                                             );


       -- USER ID 값을 받아 성명 RETURN. JHS 추가 --
       FUNCTION USER_NAME_F( W_USER_ID                        IN EAPP_USER.USER_ID%TYPE
                           ) RETURN VARCHAR2;

       PROCEDURE EAPP_USER_CHECK( O_LAST_LOGIN_DATE      OUT EAPP_USER.LAST_LOGIN_DATE%TYPE
                                , O_USER_ID              OUT EAPP_USER.USER_ID%TYPE
                                , O_USER_NAME            OUT EAPP_USER.DESCRIPTION%TYPE
                                , O_USER_DISPLAY         OUT HRM_PERSON_MASTER.DISPLAY_NAME%TYPE
                                , O_USER_TYPE            OUT EAPP_USER.USER_TYPE%TYPE
                                , O_USER_AUTHORITY_TYPE  OUT EAPP_USER.AUTHORITY_TYPE%TYPE
                                , O_PERSON_ID            OUT HRM_PERSON_MASTER.PERSON_ID%TYPE
                                , O_PERSON_NUM           OUT HRM_PERSON_MASTER.PERSON_NUM%TYPE
                                , O_DEPT_ID              OUT HRM_DEPT_MASTER.DEPT_ID%TYPE
                                , O_DEPT_NAME            OUT HRM_DEPT_MASTER.DEPT_NAME%TYPE
                                , W_SOB_ID               IN  EAPP_USER.SOB_ID%TYPE
                                , W_ORG_ID               IN  EAPP_USER.ORG_ID%TYPE
                                , W_USER_NO              IN  EAPP_USER.USER_NO%TYPE
                                , W_PASSWORD             IN  EAPP_USER.PASSWORD%TYPE
                                );

       PROCEDURE EAPP_USER_TYPE1( P_CURSOR             OUT TYPES.TCURSOR
                                , O_USER_TYPE          OUT EAPP_USER.USER_TYPE%TYPE
                                , O_AUTHORITY_TYPE     OUT EAPP_USER.AUTHORITY_TYPE%TYPE
                                , W_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                , W_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                , W_USER_ID            IN  EAPP_USER.USER_ID%TYPE
                                );

            
END EAPP_USER_G;
/
CREATE OR REPLACE PACKAGE BODY EAPP_USER_G IS
--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_USER_G[EAPF0301]
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 20-JUL-2010  Kim Dae Sung       Initialize
-- 13-AUG-2010  Kim Dae Sung       UPDATE
-- 15-SEP-2010  Jun Ho  Su         Append
-- 18-SEP-2010  Kim Dae Sung       UPDATE
-- 02-NOV-2010  Kim Dae Sung       UPDATE
--==============================================================================


       PROCEDURE EAPP_USER_SELECT1( P_CURSOR             OUT TYPES.TCURSOR
                                  , W_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , W_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  )

       IS

                V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));

       BEGIN

                OPEN P_CURSOR FOR
                SELECT EU.DESCRIPTION
                     , EU.USER_NO
                  FROM EAPP_USER EU
                 WHERE EU.SOB_ID = W_SOB_ID
                   AND EU.ORG_ID = W_ORG_ID
                   AND V_LOCAL_DATE              BETWEEN NVL(EU.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                     AND NVL(EU.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                   AND NVL(EU.ENABLED_FLAG, 'N') = 'Y'
              ORDER BY EU.DESCRIPTION;

       END;


       PROCEDURE HRM_DEPT_MASTER_SELECT2( P_CURSOR       OUT TYPES.TCURSOR
                                        , W_SOB_ID       IN  HRM_DEPT_MASTER.SOB_ID%TYPE
                                        , W_ORG_ID       IN  HRM_DEPT_MASTER.ORG_ID%TYPE
                                        )

       IS

                V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));

       BEGIN

                OPEN P_CURSOR FOR
                SELECT DM.DEPT_NAME
                  FROM HRM_DEPT_MASTER DM
                 WHERE DM.SOB_ID                 = W_SOB_ID
                   AND DM.ORG_ID                 = W_ORG_ID
                   AND V_LOCAL_DATE              BETWEEN NVL(DM.START_DATE, V_LOCAL_DATE)
                                                     AND NVL(DM.END_DATE, V_LOCAL_DATE)
                   AND NVL(DM.USABLE, 'N') = 'Y'
              ORDER BY DM.DEPT_NAME;

       END;


       PROCEDURE HRM_PERSON_MASTER_SELECT3( P_CURSOR     OUT TYPES.TCURSOR
                                          , W_SOB_ID     IN  HRM_PERSON_MASTER.SOB_ID%TYPE
                                          , W_ORG_ID     IN  HRM_PERSON_MASTER.ORG_ID%TYPE
                                          )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT PM.NAME
                     , PM.PERSON_NUM
                     , DM.DEPT_NAME
                     , PM.PERSON_ID
                  FROM HRM_PERSON_MASTER PM
                     , HRM_DEPT_MASTER   DM
                 WHERE PM.DEPT_ID                = DM.DEPT_ID
                   AND PM.SOB_ID                 = W_SOB_ID
                   AND PM.ORG_ID                 = W_ORG_ID
                   AND DM.USABLE                 = 'Y'
              ORDER BY PM.NAME;

       END;


       PROCEDURE EAPP_USER_SELECT4( P_CURSOR             OUT TYPES.TCURSOR
                                  , W_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , W_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  , W_DESCRIPTION        IN  EAPP_USER.DESCRIPTION%TYPE
                                  , W_DEPT_NAME          IN  HRM_DEPT_MASTER.DEPT_NAME%TYPE
                                  , W_USER_TYPE          IN  EAPP_USER.USER_TYPE%TYPE
                                  )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT EU.USER_ID AS O_USER_ID
                     , EU.USER_NO
                     , EU.DESCRIPTION
                     , EU.PASSWORD
                     , PM.DISPLAY_NAME AS NAME
                     , EU.PERSON_ID
                     , DM.DEPT_NAME
                     , EU.EFFECTIVE_DATE_FR
                     , EU.EFFECTIVE_DATE_TO
                     , EU.ENABLED_FLAG
                     , EU.USER_TYPE
                     , EU.AUTHORITY_TYPE
                  FROM EAPP_USER                EU
       LEFT OUTER JOIN HRM_PERSON_MASTER        PM
                    ON EU.PERSON_ID           = PM.PERSON_ID
       LEFT OUTER JOIN HRM_DEPT_MASTER          DM
                    ON PM.DEPT_ID             = DM.DEPT_ID
                 WHERE EU.SOB_ID              = W_SOB_ID
                   AND EU.ORG_ID              = W_ORG_ID
                   AND EU.DESCRIPTION         = NVL(W_DESCRIPTION, EU.DESCRIPTION)
                   AND NVL(DM.DEPT_NAME, '-') = NVL(W_DEPT_NAME, NVL(DM.DEPT_NAME, '-'))
                   AND DECODE(NVL(W_USER_TYPE, 'N'), 'N', 'Z', NVL(EU.USER_TYPE, 'N')) = DECODE(NVL(W_USER_TYPE, 'N'), 'N', 'Z', 'A', 'A', 'S', 'S', 'B', 'B')
              ORDER BY EU.USER_NO;

       END;


       PROCEDURE EAPP_USER_INSERT1( O_USER_ID            OUT EAPP_USER.USER_ID%TYPE
                                  , P_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , P_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  , P_USER_NO            IN  EAPP_USER.USER_NO%TYPE
                                  , P_DESCRIPTION        IN  EAPP_USER.DESCRIPTION%TYPE
                                  , P_PASSWORD           IN  EAPP_USER.PASSWORD%TYPE
                                  , P_USER_TYPE          IN  EAPP_USER.USER_TYPE%TYPE
                                  , P_AUTHORITY_TYPE     IN  EAPP_USER.AUTHORITY_TYPE%TYPE
                                  , P_PERSON_ID          IN  EAPP_USER.PERSON_ID%TYPE
                                  , P_EFFECTIVE_DATE_FR  IN  EAPP_USER.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO  IN  EAPP_USER.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG       IN  EAPP_USER.ENABLED_FLAG%TYPE
                                  , P_USER_ID            IN  EAPP_USER.CREATED_BY%TYPE
                                  )

       IS

                 V_SYSTEM_DATE       DATE;

       BEGIN
                 V_SYSTEM_DATE     := get_local_date(P_SOB_ID);

                 SELECT EAPP_USER_S1.NEXTVAL
                        INTO O_USER_ID
                 FROM   DUAL;

                 INSERT INTO EAPP_USER
                           ( USER_ID
                           , SOB_ID
                           , ORG_ID
                           , USER_NO
                           , DESCRIPTION
                           , PASSWORD
                           , USER_TYPE
                           , AUTHORITY_TYPE
                           , PERSON_ID
                           , EFFECTIVE_DATE_FR
                           , EFFECTIVE_DATE_TO
                           , ENABLED_FLAG
                           , CREATION_DATE
                           , CREATED_BY
                           , LAST_UPDATE_DATE
                           , LAST_UPDATED_BY
                           )
                 VALUES    ( O_USER_ID
                           , P_SOB_ID
                           , P_ORG_ID
                           , P_USER_NO
                           , P_DESCRIPTION
                           , P_PASSWORD
                           , P_USER_TYPE
                           , P_AUTHORITY_TYPE
                           , P_PERSON_ID
                           , P_EFFECTIVE_DATE_FR
                           , P_EFFECTIVE_DATE_TO
                           , P_ENABLED_FLAG
                           , V_SYSTEM_DATE
                           , P_USER_ID
                           , V_SYSTEM_DATE
                           , P_USER_ID
                           );

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;


       PROCEDURE EAPP_USER_UPDATE1( W_EAPP_USER_ID       IN  EAPP_USER.USER_ID%TYPE
                                  , P_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                  , P_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                  , P_USER_NO            IN  EAPP_USER.USER_NO%TYPE
                                  , P_DESCRIPTION        IN  EAPP_USER.DESCRIPTION%TYPE
                                  , P_PASSWORD           IN  EAPP_USER.PASSWORD%TYPE
                                  , P_USER_TYPE          IN  EAPP_USER.USER_TYPE%TYPE
                                  , P_AUTHORITY_TYPE     IN  EAPP_USER.AUTHORITY_TYPE%TYPE
                                  , P_PERSON_ID          IN  EAPP_USER.PERSON_ID%TYPE
                                  , P_EFFECTIVE_DATE_FR  IN  EAPP_USER.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO  IN  EAPP_USER.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG       IN  EAPP_USER.ENABLED_FLAG%TYPE
                                  , P_USER_ID            IN  EAPP_USER.LAST_UPDATED_BY%TYPE
                                  )

       IS

                 V_SYSTEM_DATE       DATE;

       BEGIN
                 V_SYSTEM_DATE     := get_local_date(P_SOB_ID);

                 UPDATE EAPP_USER
                    SET SOB_ID             =  P_SOB_ID
                      , ORG_ID             =  P_ORG_ID
                      , USER_NO            =  P_USER_NO
                      , DESCRIPTION        =  P_DESCRIPTION
                      , PASSWORD           =  P_PASSWORD
                      , USER_TYPE          =  P_USER_TYPE
                      , AUTHORITY_TYPE     =  P_AUTHORITY_TYPE
                      , PERSON_ID          =  P_PERSON_ID
                      , EFFECTIVE_DATE_FR  =  P_EFFECTIVE_DATE_FR
                      , EFFECTIVE_DATE_TO  =  P_EFFECTIVE_DATE_TO
                      , ENABLED_FLAG       =  P_ENABLED_FLAG
                      , LAST_UPDATE_DATE   =  V_SYSTEM_DATE
                      , LAST_UPDATED_BY    =  P_USER_ID
                  WHERE USER_ID            =  W_EAPP_USER_ID;

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;


       PROCEDURE EAPP_RESPONSIBILITY_SELECT1( P_CURSOR               OUT TYPES.TCURSOR
                                            , W_SOB_ID               IN  EAPP_RESPONSIBILITY.SOB_ID%TYPE
                                            , W_ORG_ID               IN  EAPP_RESPONSIBILITY.ORG_ID%TYPE
                                            )

       IS

                V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));

       BEGIN

                OPEN P_CURSOR FOR
                SELECT ER.RESPONSIBILITY_NAME
                     , ER.DESCRIPTION
                     , ER.RESPONSIBILITY_ID
                  FROM EAPP_RESPONSIBILITY ER
                 WHERE ER.SOB_ID                 = W_SOB_ID
                   AND ER.ORG_ID                 = W_ORG_ID
                   AND V_LOCAL_DATE              BETWEEN NVL(ER.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                     AND NVL(ER.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                   AND NVL(ER.ENABLED_FLAG, 'N') = 'Y'
              ORDER BY ER.RESPONSIBILITY_NAME;

       END;


       PROCEDURE EAPP_USER_RESPONSIBLE_SELECT2( P_CURSOR             OUT TYPES.TCURSOR
                                              , W_SOB_ID             IN  EAPP_USER_RESPONSIBILITY.SOB_ID%TYPE
                                              , W_ORG_ID             IN  EAPP_USER_RESPONSIBILITY.ORG_ID%TYPE
                                              , W_USER_ID            IN  EAPP_USER_RESPONSIBILITY.USER_ID%TYPE
                                              )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT ER.RESPONSIBILITY_NAME
                     , UR.EFFECTIVE_DATE_FR
                     , UR.EFFECTIVE_DATE_TO
                     , UR.ENABLED_FLAG
                     , ER.RESPONSIBILITY_ID
                     , UR.USER_ID
                  FROM EAPP_RESPONSIBILITY ER
                     , EAPP_USER_RESPONSIBILITY UR
                 WHERE ER.RESPONSIBILITY_ID = UR.RESPONSIBILITY_ID
                   AND UR.SOB_ID            = W_SOB_ID
                   AND UR.ORG_ID            = W_ORG_ID
                   AND UR.USER_ID           = W_USER_ID
              ORDER BY ER.RESPONSIBILITY_NAME;

       END;


       PROCEDURE EAPP_USER_RESPONSIBLE_INSERT1( P_SOB_ID             IN  EAPP_USER_RESPONSIBILITY.SOB_ID%TYPE
                                              , P_ORG_ID             IN  EAPP_USER_RESPONSIBILITY.ORG_ID%TYPE
                                              , P_EAPP_USER_ID       IN  EAPP_USER_RESPONSIBILITY.USER_ID%TYPE
                                              , P_RESPONSIBILITY_ID  IN  EAPP_USER_RESPONSIBILITY.RESPONSIBILITY_ID%TYPE
                                              , P_EFFECTIVE_DATE_FR  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_FR%TYPE
                                              , P_EFFECTIVE_DATE_TO  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_TO%TYPE
                                              , P_ENABLED_FLAG       IN  EAPP_USER_RESPONSIBILITY.ENABLED_FLAG%TYPE
                                              , P_USER_ID            IN  EAPP_USER_RESPONSIBILITY.CREATED_BY%TYPE
                                              )

       IS

                 V_SYSTEM_DATE       DATE;

       BEGIN
                 V_SYSTEM_DATE     := get_local_date(P_SOB_ID);

                 INSERT INTO EAPP_USER_RESPONSIBILITY
                           ( SOB_ID
                           , ORG_ID
                           , USER_ID
                           , RESPONSIBILITY_ID
                           , EFFECTIVE_DATE_FR
                           , EFFECTIVE_DATE_TO
                           , ENABLED_FLAG
                           , CREATION_DATE
                           , CREATED_BY
                           , LAST_UPDATE_DATE
                           , LAST_UPDATED_BY
                           )
                 VALUES    ( P_SOB_ID
                           , P_ORG_ID
                           , P_EAPP_USER_ID
                           , P_RESPONSIBILITY_ID
                           , P_EFFECTIVE_DATE_FR
                           , P_EFFECTIVE_DATE_TO
                           , P_ENABLED_FLAG
                           , V_SYSTEM_DATE
                           , P_USER_ID
                           , V_SYSTEM_DATE
                           , P_USER_ID
                           );

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;


       PROCEDURE EAPP_USER_RESPONSIBLE_UPDATE1( W_SOB_ID             IN  EAPP_USER_RESPONSIBILITY.SOB_ID%TYPE
                                              , W_ORG_ID             IN  EAPP_USER_RESPONSIBILITY.ORG_ID%TYPE
                                              , W_EAPP_USER_ID       IN  EAPP_USER_RESPONSIBILITY.USER_ID%TYPE
                                              , W_RESPONSIBILITY_ID  IN  EAPP_USER_RESPONSIBILITY.RESPONSIBILITY_ID%TYPE
                                              , P_EFFECTIVE_DATE_FR  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_FR%TYPE
                                              , P_EFFECTIVE_DATE_TO  IN  EAPP_USER_RESPONSIBILITY.EFFECTIVE_DATE_TO%TYPE
                                              , P_ENABLED_FLAG       IN  EAPP_USER_RESPONSIBILITY.ENABLED_FLAG%TYPE
                                              , P_USER_ID            IN  EAPP_USER_RESPONSIBILITY.LAST_UPDATED_BY%TYPE
                                              )

       IS

                 V_SYSTEM_DATE       DATE;

       BEGIN
                 V_SYSTEM_DATE     := get_local_date(W_SOB_ID);

                 UPDATE EAPP_USER_RESPONSIBILITY
                    SET EFFECTIVE_DATE_FR  =  P_EFFECTIVE_DATE_FR
                      , EFFECTIVE_DATE_TO  =  P_EFFECTIVE_DATE_TO
                      , ENABLED_FLAG       =  P_ENABLED_FLAG
                      , LAST_UPDATE_DATE   =  V_SYSTEM_DATE
                      , LAST_UPDATED_BY    =  P_USER_ID
                  WHERE SOB_ID             =  W_SOB_ID
                    AND ORG_ID             =  W_ORG_ID
                    AND USER_ID            =  W_EAPP_USER_ID
                    AND RESPONSIBILITY_ID  =  W_RESPONSIBILITY_ID;

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;




       PROCEDURE EAPP_PROGRAM_SELECT1( P_CURSOR                    OUT TYPES.TCURSOR
                                     , W_SOB_ID                    IN  EAPP_PROGRAM.SOB_ID%TYPE
                                     , W_ORG_ID                    IN  EAPP_PROGRAM.ORG_ID%TYPE
                                     )

       IS

                V_LOCAL_DATE  DATE := TRUNC(GET_LOCAL_DATE(W_SOB_ID));

       BEGIN

                OPEN P_CURSOR FOR
                SELECT EAI.ASSEMBLY_ID
                     , EAI.ASSEMBLY_NAME
                     , EAI.ASSEMBLY_INFO_ID
                  FROM EAPP_ASSEMBLY_INFO EAI
                 WHERE EAI.SOB_ID               = W_SOB_ID
                   AND EAI.ORG_ID               = W_ORG_ID
                   AND EAI.ASSEMBLY_INFRA_TYPE  = 'Program'
                   AND V_LOCAL_DATE               BETWEEN NVL(EAI.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                      AND NVL(EAI.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                   AND NVL(EAI.ENABLED_FLAG, 'N') = 'Y'
              ORDER BY EAI.ASSEMBLY_ID;

       END;

       PROCEDURE EAPP_USER_PRG_AUTHOR_SELECT2( P_CURSOR            OUT TYPES.TCURSOR
                                             , W_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , W_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , W_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT EAI.ASSEMBLY_ID
                     , EAI.ASSEMBLY_NAME
                     , EUPA.READ_FLAG
                     , EUPA.WIRTE_FLAG
                     , EUPA.PRINT_FLAG
                     , EUR.USER_ID
                     , EAI.ASSEMBLY_INFO_ID
                  FROM EAPP_ASSEMBLY_INFO EAI
                     , EAPP_USER_RESPONSIBILITY EUR
                     , (SELECT EUPA.READ_FLAG
                             , EUPA.WIRTE_FLAG
                             , EUPA.PRINT_FLAG
                             , EUPA.SOB_ID
                             , EUPA.ORG_ID
                             , EUPA.USER_ID
                             , EUPA.ASSEMBLY_INFO_ID
                          FROM EAPP_USER_PRG_AUTHORITY EUPA
                         WHERE EUPA.SOB_ID    = W_SOB_ID
                           AND EUPA.ORG_ID    = W_ORG_ID
                           AND EUPA.USER_ID   = W_USER_ID
                       ) EUPA
                WHERE EAI.RESPONSIBILITY_ID   = EUR.RESPONSIBILITY_ID
                  AND EAI.ASSEMBLY_INFO_ID    = EUPA.ASSEMBLY_INFO_ID(+)
                  AND EAI.SOB_ID              = W_SOB_ID
                  AND EAI.ORG_ID              = W_ORG_ID
                  AND EAI.ASSEMBLY_INFRA_TYPE = 'Program'
                  AND EUR.USER_ID = W_USER_ID
             ORDER BY EAI.ASSEMBLY_ID
                    ;

       END;


       PROCEDURE EAPP_USER_PRG_AUTHOR_INSERT1( P_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , P_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , P_EAPP_USER_ID      IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             , P_ASSEMBLY_INFO_ID  IN  EAPP_USER_PRG_AUTHORITY.ASSEMBLY_INFO_ID%TYPE
                                             , P_READ_FLAG         IN  EAPP_USER_PRG_AUTHORITY.READ_FLAG%TYPE
                                             , P_WIRTE_FLAG        IN  EAPP_USER_PRG_AUTHORITY.WIRTE_FLAG%TYPE
                                             , P_PRINT_FLAG        IN  EAPP_USER_PRG_AUTHORITY.PRINT_FLAG%TYPE
                                             , P_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.CREATED_BY%TYPE
                                             )

       IS

                 V_SYSTEM_DATE    DATE;

       BEGIN
                 V_SYSTEM_DATE := get_local_date(P_SOB_ID);

                 INSERT INTO EAPP_USER_PRG_AUTHORITY
                           ( SOB_ID
                           , ORG_ID
                           , USER_ID
                           , ASSEMBLY_INFO_ID
                           , READ_FLAG
                           , WIRTE_FLAG
                           , PRINT_FLAG
                           , CREATION_DATE
                           , CREATED_BY
                           , LAST_UPDATE_DATE
                           , LAST_UPDATED_BY
                           )
                 VALUES    ( P_SOB_ID
                           , P_ORG_ID
                           , P_EAPP_USER_ID
                           , P_ASSEMBLY_INFO_ID
                           , P_READ_FLAG
                           , P_WIRTE_FLAG
                           , P_PRINT_FLAG
                           , V_SYSTEM_DATE
                           , P_USER_ID
                           , V_SYSTEM_DATE
                           , P_USER_ID
                           ) ;

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;


       PROCEDURE EAPP_USER_PRG_AUTHOR_UPDATE1( W_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , W_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , W_EAPP_USER_ID      IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             , W_ASSEMBLY_INFO_ID  IN  EAPP_USER_PRG_AUTHORITY.ASSEMBLY_INFO_ID%TYPE
                                             , P_READ_FLAG         IN  EAPP_USER_PRG_AUTHORITY.READ_FLAG%TYPE
                                             , P_WIRTE_FLAG        IN  EAPP_USER_PRG_AUTHORITY.WIRTE_FLAG%TYPE
                                             , P_PRINT_FLAG        IN  EAPP_USER_PRG_AUTHORITY.PRINT_FLAG%TYPE
                                             , P_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.LAST_UPDATED_BY%TYPE
                                             )

       IS

                 V_SYSTEM_DATE       DATE;

       BEGIN
                 V_SYSTEM_DATE     := get_local_date(W_SOB_ID);

                 UPDATE EAPP_USER_PRG_AUTHORITY
                    SET READ_FLAG         =  P_READ_FLAG
                      , WIRTE_FLAG        =  P_WIRTE_FLAG
                      , PRINT_FLAG        =  P_PRINT_FLAG
                      , LAST_UPDATE_DATE  =  V_SYSTEM_DATE
                      , LAST_UPDATED_BY   =  P_USER_ID
                  WHERE SOB_ID            =  W_SOB_ID
                    AND ORG_ID            =  W_ORG_ID
                    AND USER_ID           =  W_EAPP_USER_ID
                    AND ASSEMBLY_INFO_ID  =  W_ASSEMBLY_INFO_ID;

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;


       PROCEDURE EAPP_USER_PRG_AUTHOR_UPDATE2( W_SOB_ID            IN  EAPP_USER_PRG_AUTHORITY.SOB_ID%TYPE
                                             , W_ORG_ID            IN  EAPP_USER_PRG_AUTHORITY.ORG_ID%TYPE
                                             , W_ASSEMBLY_INFO_ID  IN  EAPP_USER_PRG_AUTHORITY.ASSEMBLY_INFO_ID%TYPE
                                             , P_EAPP_USER_ID      IN  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE
                                             , P_READ_FLAG         IN  EAPP_USER_PRG_AUTHORITY.READ_FLAG%TYPE
                                             , P_WIRTE_FLAG        IN  EAPP_USER_PRG_AUTHORITY.WIRTE_FLAG%TYPE
                                             , P_PRINT_FLAG        IN  EAPP_USER_PRG_AUTHORITY.PRINT_FLAG%TYPE
                                             , P_USER_ID           IN  EAPP_USER_PRG_AUTHORITY.LAST_UPDATED_BY%TYPE
                                             )

       IS

                 V_EAPP_USER_ID  EAPP_USER_PRG_AUTHORITY.USER_ID%TYPE := NULL;

       BEGIN

                 BEGIN
                      SELECT EUPA.USER_ID
                        INTO V_EAPP_USER_ID
                        FROM EAPP_USER_PRG_AUTHORITY EUPA
                       WHERE EUPA.ASSEMBLY_INFO_ID = W_ASSEMBLY_INFO_ID
                         AND EUPA.USER_ID          = P_EAPP_USER_ID
                           ;
                      EXCEPTION
                           WHEN OTHERS
                           THEN
                                V_EAPP_USER_ID := NULL;
                 END;

                 IF V_EAPP_USER_ID IS NULL THEN
                    EAPP_USER_PRG_AUTHOR_INSERT1( W_SOB_ID
                                                , W_ORG_ID
                                                , P_EAPP_USER_ID
                                                , W_ASSEMBLY_INFO_ID
                                                , P_READ_FLAG
                                                , P_WIRTE_FLAG
                                                , P_PRINT_FLAG
                                                , P_USER_ID
                                                );
                 ELSE
                    EAPP_USER_PRG_AUTHOR_UPDATE1( W_SOB_ID
                                                , W_ORG_ID
                                                , V_EAPP_USER_ID
                                                , W_ASSEMBLY_INFO_ID
                                                , P_READ_FLAG
                                                , P_WIRTE_FLAG
                                                , P_PRINT_FLAG
                                                , P_USER_ID
                                                );
                 END IF;



                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;

       END;


       -- USER ID 값을 받아 성명 RETURN. JHS 추가 --
       FUNCTION USER_NAME_F( W_USER_ID IN EAPP_USER.USER_ID%TYPE
                           ) RETURN VARCHAR2

       AS

            V_NAME  HRM_PERSON_MASTER.NAME%TYPE := NULL;

       BEGIN
            BEGIN
                 SELECT NVL(HRM_PERSON_MASTER_G.NAME_F(EU.PERSON_ID), EU.DESCRIPTION) AS USER_NAME
                   INTO V_NAME
                   FROM EAPP_USER EU
                  WHERE EU.USER_ID = W_USER_ID
                      ;
                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           V_NAME := NULL;
            END;

            RETURN V_NAME;
       END USER_NAME_F;


       PROCEDURE EAPP_USER_CHECK( O_LAST_LOGIN_DATE      OUT EAPP_USER.LAST_LOGIN_DATE%TYPE
                                , O_USER_ID              OUT EAPP_USER.USER_ID%TYPE
                                , O_USER_NAME            OUT EAPP_USER.DESCRIPTION%TYPE
                                , O_USER_DISPLAY         OUT HRM_PERSON_MASTER.DISPLAY_NAME%TYPE
                                , O_USER_TYPE            OUT EAPP_USER.USER_TYPE%TYPE
                                , O_USER_AUTHORITY_TYPE  OUT EAPP_USER.AUTHORITY_TYPE%TYPE
                                , O_PERSON_ID            OUT HRM_PERSON_MASTER.PERSON_ID%TYPE
                                , O_PERSON_NUM           OUT HRM_PERSON_MASTER.PERSON_NUM%TYPE
                                , O_DEPT_ID              OUT HRM_DEPT_MASTER.DEPT_ID%TYPE
                                , O_DEPT_NAME            OUT HRM_DEPT_MASTER.DEPT_NAME%TYPE
                                , W_SOB_ID               IN  EAPP_USER.SOB_ID%TYPE
                                , W_ORG_ID               IN  EAPP_USER.ORG_ID%TYPE
                                , W_USER_NO              IN  EAPP_USER.USER_NO%TYPE
                                , W_PASSWORD             IN  EAPP_USER.PASSWORD%TYPE
                                )

       IS

                 V_LOCAL_DATE  DATE := GET_LOCAL_DATE(W_SOB_ID);

       BEGIN

                 BEGIN
                      O_PERSON_ID        := NULL;
                      O_PERSON_NUM       := NULL;
                      O_DEPT_ID          := NULL;
                      O_DEPT_NAME        := NULL;

                      SELECT EU.USER_ID
                           , EU.DESCRIPTION
                           , HPM.DISPLAY_NAME
                           , EU.USER_TYPE
                           , EU.AUTHORITY_TYPE
                        INTO O_USER_ID
                           , O_USER_NAME
                           , O_USER_DISPLAY
                           , O_USER_TYPE
                           , O_USER_AUTHORITY_TYPE
                        FROM EAPP_USER EU
                           , HRM_PERSON_MASTER HPM
                       WHERE EU.PERSON_ID = HPM.PERSON_ID(+)
                         AND EU.SOB_ID    = W_SOB_ID
                         AND EU.ORG_ID    = W_ORG_ID
                         AND V_LOCAL_DATE              BETWEEN NVL(EU.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
                                                           AND NVL(EU.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
                         AND NVL(EU.ENABLED_FLAG, 'N') = 'Y'
                         AND EU.USER_NO  = W_USER_NO
                         AND EU.PASSWORD = W_PASSWORD
                           ;

                      O_PERSON_ID := EAPP_COMMON_G.GET_PERSON_ID_BY_USER(O_USER_ID);

                      IF O_PERSON_ID IS NOT NULL THEN
                         SELECT PM.PERSON_NUM
                              , DM.DEPT_ID
                              , DM.DEPT_NAME
                           INTO O_PERSON_NUM
                              , O_DEPT_ID
                              , O_DEPT_NAME
                           FROM HRM_PERSON_MASTER PM
                              , HRM_DEPT_MASTER DM
                          WHERE PM.DEPT_ID   = DM.DEPT_ID
                            AND PM.PERSON_ID = O_PERSON_ID
                              ;
                      END IF;

                      EXCEPTION
                           WHEN OTHERS
                           THEN
                                O_USER_ID             := NULL;
                                O_USER_NAME           := NULL;
                                O_USER_DISPLAY        := NULL;
                                O_USER_TYPE           := NULL;
                                O_USER_AUTHORITY_TYPE := NULL;
                                O_PERSON_ID           := NULL;
                                O_PERSON_NUM          := NULL;
                                O_DEPT_ID             := NULL;
                                O_DEPT_NAME           := NULL;
                 END;

                 IF O_USER_ID IS NOT NULL THEN
                    UPDATE EAPP_USER
                       SET LAST_LOGIN_DATE = V_LOCAL_DATE
                     WHERE USER_ID  = O_USER_ID;

                    O_LAST_LOGIN_DATE := V_LOCAL_DATE;
                 END IF;

                 EXCEPTION
                      WHEN OTHERS
                      THEN
                           RAISE_APPLICATION_ERROR(-20011, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10015', NULL) || CHR(10) || SQLERRM);
                           RETURN;


       END;


       PROCEDURE EAPP_USER_TYPE1( P_CURSOR             OUT TYPES.TCURSOR
                                , O_USER_TYPE          OUT EAPP_USER.USER_TYPE%TYPE
                                , O_AUTHORITY_TYPE     OUT EAPP_USER.AUTHORITY_TYPE%TYPE
                                , W_SOB_ID             IN  EAPP_USER.SOB_ID%TYPE
                                , W_ORG_ID             IN  EAPP_USER.ORG_ID%TYPE
                                , W_USER_ID            IN  EAPP_USER.USER_ID%TYPE
                                )

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT EU.USER_TYPE
                     , EU.AUTHORITY_TYPE
                 INTO  O_USER_TYPE
                     , O_AUTHORITY_TYPE
                  FROM EAPP_USER EU
                 WHERE EU.SOB_ID  = W_SOB_ID
                   AND EU.ORG_ID  = W_ORG_ID
                   AND EU.USER_ID = W_USER_ID
                     ;

       END;

  
END EAPP_USER_G;
/
