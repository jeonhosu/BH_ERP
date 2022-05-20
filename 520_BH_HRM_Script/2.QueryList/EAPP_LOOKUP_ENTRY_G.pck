create or replace package EAPP_LOOKUP_ENTRY_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_LOOKUP_ENTRY_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 10-JUL-2010  Kim Dae Sung       Initialize
--==============================================================================

       PROCEDURE EAPP_LOOKUP_ENTRY_SELECT1(P_CURSOR             OUT TYPES.TCURSOR,
                                           W_SOB_ID             IN  NUMBER,
                                           W_ORG_ID             IN  NUMBER,
                                           W_LOOKUP_TYPE_ID     IN  NUMBER);

       PROCEDURE EAPP_LOOKUP_ENTRY_SELECT2(P_CURSOR             OUT TYPES.TCURSOR,
                                           W_SOB_ID             IN  NUMBER,
                                           W_ORG_ID             IN  NUMBER);
       
       -- LOOKUP CODE.
       PROCEDURE EAPP_LOOKUP_ENTRY_SELECT3(P_CURSOR3             OUT TYPES.TCURSOR3,
                                           W_SOB_ID                   IN  NUMBER,
                                           W_ORG_ID                   IN  NUMBER,
                                           W_LOOKUP_MODULE  IN VARCHAR2,
                                           W_LOOKUP_TYPE        IN VARCHAR2);
      
      -- LOOKUP TAG,
      PROCEDURE EAPP_LOOKUP_TAG_SELECT(P_CURSOR3             OUT TYPES.TCURSOR3,
                                           W_SOB_ID                   IN  NUMBER,
                                           W_ORG_ID                   IN  NUMBER,
                                           W_LOOKUP_MODULE  IN VARCHAR2,
                                           W_LOOKUP_TYPE        IN VARCHAR2);                                           
                                           
       PROCEDURE EAPP_LOOKUP_ENTRY_INSERT1(P_SOB_ID             IN  NUMBER,
                                           P_ORG_ID             IN  NUMBER,
                                           P_LOOKUP_TYPE_ID     IN  NUMBER,
                                           P_LOOKUP_LEVEL       IN  VARCHAR2,
                                           P_LOOKUP_MODULE      IN  VARCHAR2,
                                           P_LOOKUP_TYPE        IN  VARCHAR2,
                                           P_ENTRY_CODE         IN  VARCHAR2,
                                           P_ENTRY_DESCRIPTION  IN  VARCHAR2,
                                           P_ENTRY_TAG          IN  VARCHAR2,
                                           P_DEFAULT_FLAG       IN  VARCHAR2,
                                           P_EFFECTIVE_DATE_FR  IN  DATE,
                                           P_EFFECTIVE_DATE_TO  IN  DATE,
                                           P_ENABLED_FLAG       IN  VARCHAR2,
                                           P_USER_ID            IN  NUMBER);

       PROCEDURE EAPP_LOOKUP_ENTRY_UPDATE1(W_LOOKUP_ENTRY_ID    IN  NUMBER,
                                           P_SOB_ID             IN  NUMBER,
                                           P_ORG_ID             IN  NUMBER,
                                           P_LOOKUP_TYPE_ID     IN  NUMBER,
                                           P_LOOKUP_LEVEL       IN  VARCHAR2,
                                           P_LOOKUP_MODULE      IN  VARCHAR2,
                                           P_LOOKUP_TYPE        IN  VARCHAR2,
                                           P_ENTRY_CODE         IN  VARCHAR2,
                                           P_ENTRY_DESCRIPTION  IN  VARCHAR2,
                                           P_ENTRY_TAG          IN  VARCHAR2,
                                           P_DEFAULT_FLAG       IN  VARCHAR2,
                                           P_EFFECTIVE_DATE_FR  IN  DATE,
                                           P_EFFECTIVE_DATE_TO  IN  DATE,
                                           P_ENABLED_FLAG       IN  VARCHAR2,
                                           P_USER_ID            IN  NUMBER);

       PROCEDURE EAPP_LOOKUP_ENTRY_DELETE1(W_LOOKUP_ENTRY_ID    IN  NUMBER,
                                           W_SOB_ID             IN  NUMBER,
                                           W_ORG_ID             IN  NUMBER);


end EAPP_LOOKUP_ENTRY_G;
/
create or replace package body EAPP_LOOKUP_ENTRY_G is


       PROCEDURE EAPP_LOOKUP_ENTRY_SELECT1(P_CURSOR             OUT TYPES.TCURSOR,
                                           W_SOB_ID             IN  NUMBER,
                                           W_ORG_ID             IN  NUMBER,
                                           W_LOOKUP_TYPE_ID     IN  NUMBER)

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT   LE.ENTRY_CODE,
                         LE.ENTRY_DESCRIPTION,
                         LE.ENTRY_TAG,
                         LE.DEFAULT_FLAG,
                         LE.EFFECTIVE_DATE_FR,
                         LE.EFFECTIVE_DATE_TO,
                         LE.ENABLED_FLAG,
                         LE.LOOKUP_ENTRY_ID
                FROM     EAPP_LOOKUP_ENTRY LE
                WHERE    LE.SOB_ID = W_SOB_ID
                  AND    LE.ORG_ID = W_ORG_ID
                  AND    LE.LOOKUP_TYPE_ID = W_LOOKUP_TYPE_ID
                ORDER BY LE.ENTRY_CODE;

       END;


       PROCEDURE EAPP_LOOKUP_ENTRY_SELECT2(P_CURSOR             OUT TYPES.TCURSOR,
                                           W_SOB_ID             IN  NUMBER,
                                           W_ORG_ID             IN  NUMBER)

       IS

       BEGIN

                OPEN P_CURSOR FOR
                SELECT LE.ENTRY_CODE,
                       LE.ENTRY_DESCRIPTION
                FROM   EAPP_LOOKUP_ENTRY LE
                WHERE  LE.SOB_ID = W_SOB_ID
                  AND  LE.ORG_ID = W_ORG_ID;

       END;
       
       -- LOOK Á¶È¸.
       PROCEDURE EAPP_LOOKUP_ENTRY_SELECT3(P_CURSOR3             OUT TYPES.TCURSOR3,
                                           W_SOB_ID                   IN  NUMBER,
                                           W_ORG_ID                   IN  NUMBER,
                                           W_LOOKUP_MODULE  IN VARCHAR2,
                                           W_LOOKUP_TYPE        IN VARCHAR2)
       AS
       BEGIN
          OPEN P_CURSOR3 FOR
            SELECT LE.ENTRY_CODE
                , LE.ENTRY_DESCRIPTION
                , LE.LOOKUP_ENTRY_ID
            FROM EAPP_LOOKUP_ENTRY LE
            WHERE LE.SOB_ID                                             = W_SOB_ID
              AND LE.ORG_ID                                                 = W_ORG_ID
              AND LE.LOOKUP_MODULE                                = W_LOOKUP_MODULE
              AND LE.LOOKUP_TYPE                                      = W_LOOKUP_TYPE
            ORDER BY LE.ENTRY_CODE
            ;
       END EAPP_LOOKUP_ENTRY_SELECT3;
                                           
       -- LOOKUP TAG,
       PROCEDURE EAPP_LOOKUP_TAG_SELECT(P_CURSOR3             OUT TYPES.TCURSOR3,
                                           W_SOB_ID                   IN  NUMBER,
                                           W_ORG_ID                   IN  NUMBER,
                                           W_LOOKUP_MODULE  IN VARCHAR2,
                                           W_LOOKUP_TYPE        IN VARCHAR2)
       AS
       BEGIN
          OPEN P_CURSOR3 FOR
            SELECT LE.ENTRY_TAG
                , LE.ENTRY_DESCRIPTION
                , LE.LOOKUP_ENTRY_ID
            FROM EAPP_LOOKUP_ENTRY LE
            WHERE LE.SOB_ID                                             = W_SOB_ID
              AND LE.ORG_ID                                                 = W_ORG_ID
              AND LE.LOOKUP_MODULE                                = W_LOOKUP_MODULE
              AND LE.LOOKUP_TYPE                                      = W_LOOKUP_TYPE
            ORDER BY LE.ENTRY_CODE
            ;
       
       END EAPP_LOOKUP_TAG_SELECT;
       
                                                  
       PROCEDURE EAPP_LOOKUP_ENTRY_INSERT1(P_SOB_ID             IN  NUMBER,
                                           P_ORG_ID             IN  NUMBER,
                                           P_LOOKUP_TYPE_ID     IN  NUMBER,
                                           P_LOOKUP_LEVEL       IN  VARCHAR2,
                                           P_LOOKUP_MODULE      IN  VARCHAR2,
                                           P_LOOKUP_TYPE        IN  VARCHAR2,
                                           P_ENTRY_CODE         IN  VARCHAR2,
                                           P_ENTRY_DESCRIPTION  IN  VARCHAR2,
                                           P_ENTRY_TAG          IN  VARCHAR2,
                                           P_DEFAULT_FLAG       IN  VARCHAR2,
                                           P_EFFECTIVE_DATE_FR  IN  DATE,
                                           P_EFFECTIVE_DATE_TO  IN  DATE,
                                           P_ENABLED_FLAG       IN  VARCHAR2,
                                           P_USER_ID            IN  NUMBER)

       IS

       BEGIN
                 INSERT INTO EAPP_LOOKUP_ENTRY
                            (LOOKUP_ENTRY_ID,
                             SOB_ID,
                             ORG_ID,
                             LOOKUP_TYPE_ID,
                             LOOKUP_LEVEL,
                             LOOKUP_MODULE,
                             LOOKUP_TYPE,
                             ENTRY_CODE,
                             ENTRY_DESCRIPTION,
                             ENTRY_TAG,
                             DEFAULT_FLAG,
                             EFFECTIVE_DATE_FR,
                             EFFECTIVE_DATE_TO,
                             ENABLED_FLAG,
                             CREATION_DATE,
                             CREATED_BY,
                             LAST_UPDATE_DATE,
                             LAST_UPDATED_BY)
                 VALUES     (EAPP_LOOKUP_ENTRY_S1.NEXTVAL,
                             P_SOB_ID,
                             P_ORG_ID,
                             P_LOOKUP_TYPE_ID,
                             P_LOOKUP_LEVEL,
                             P_LOOKUP_MODULE,
                             P_LOOKUP_TYPE,
                             P_ENTRY_CODE,
                             P_ENTRY_DESCRIPTION,
                             P_ENTRY_TAG,
                             P_DEFAULT_FLAG,
                             P_EFFECTIVE_DATE_FR,
                             P_EFFECTIVE_DATE_TO,
                             P_ENABLED_FLAG,
                             SYSDATE,
                             P_USER_ID,
                             SYSDATE,
                             P_USER_ID);
                 COMMIT;

                 --EXCEPTION
                 --         WHEN OTHERS THEN
                 --         BEGIN
                 --               ROLLBACK;
                 --               RETURN;
                 --         END;

       END;


       PROCEDURE EAPP_LOOKUP_ENTRY_UPDATE1(W_LOOKUP_ENTRY_ID    IN  NUMBER,
                                           P_SOB_ID             IN  NUMBER,
                                           P_ORG_ID             IN  NUMBER,
                                           P_LOOKUP_TYPE_ID     IN  NUMBER,
                                           P_LOOKUP_LEVEL       IN  VARCHAR2,
                                           P_LOOKUP_MODULE      IN  VARCHAR2,
                                           P_LOOKUP_TYPE        IN  VARCHAR2,
                                           P_ENTRY_CODE         IN  VARCHAR2,
                                           P_ENTRY_DESCRIPTION  IN  VARCHAR2,
                                           P_ENTRY_TAG          IN  VARCHAR2,
                                           P_DEFAULT_FLAG       IN  VARCHAR2,
                                           P_EFFECTIVE_DATE_FR  IN  DATE,
                                           P_EFFECTIVE_DATE_TO  IN  DATE,
                                           P_ENABLED_FLAG       IN  VARCHAR2,
                                           P_USER_ID            IN  NUMBER)

       IS

       BEGIN
                 UPDATE EAPP_LOOKUP_ENTRY
                    SET SOB_ID              =  P_SOB_ID,
                        ORG_ID              =  P_ORG_ID,
                        LOOKUP_TYPE_ID      =  P_LOOKUP_TYPE_ID,
                        LOOKUP_LEVEL        =  P_LOOKUP_LEVEL,
                        LOOKUP_MODULE       =  P_LOOKUP_MODULE,
                        LOOKUP_TYPE         =  P_LOOKUP_TYPE,
                        ENTRY_CODE          =  P_ENTRY_CODE,
                        ENTRY_DESCRIPTION   =  P_ENTRY_DESCRIPTION,
                        ENTRY_TAG           =  P_ENTRY_TAG,
                        DEFAULT_FLAG        =  P_DEFAULT_FLAG,
                        EFFECTIVE_DATE_FR   =  P_EFFECTIVE_DATE_FR,
                        EFFECTIVE_DATE_TO   =  P_EFFECTIVE_DATE_TO,
                        ENABLED_FLAG        =  P_ENABLED_FLAG,
                        LAST_UPDATE_DATE    =  SYSDATE,
                        LAST_UPDATED_BY     =  P_USER_ID
                 WHERE  LOOKUP_ENTRY_ID     =  W_LOOKUP_ENTRY_ID;

                 COMMIT;

                 --EXCEPTION
                 --         WHEN OTHERS THEN
                 --         BEGIN
                 --              ROLLBACK;
                 --              RETURN;
                 --         END;
       END;


       PROCEDURE EAPP_LOOKUP_ENTRY_DELETE1(W_LOOKUP_ENTRY_ID    IN  NUMBER,
                                           W_SOB_ID             IN  NUMBER,
                                           W_ORG_ID             IN  NUMBER)

       IS

       BEGIN
                 DELETE EAPP_LOOKUP_ENTRY
                 WHERE  SOB_ID  =  W_SOB_ID
                   AND  ORG_ID  =  W_ORG_ID
                   AND  LOOKUP_ENTRY_ID  =  W_LOOKUP_ENTRY_ID;

                 COMMIT;

                 --EXCEPTION
                 --         WHEN OTHERS THEN
                 --         BEGIN
                 --              ROLLBACK;
                 --              RETURN;
                 --         END;
       END;



end EAPP_LOOKUP_ENTRY_G;
/
