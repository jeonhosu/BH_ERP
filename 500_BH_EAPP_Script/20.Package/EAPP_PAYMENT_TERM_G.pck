create or replace package EAPP_PAYMENT_TERM_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_PAYMENT_TERM_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 13-JUL-2010  Kim Han Cheol       Initialize
--==============================================================================

  PROCEDURE EAPP_PAYMENT_TERM_SELECT1(P_CURSOR            OUT TYPES.TCURSOR
                                     ,W_SOB_ID            IN  EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN  EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     ,W_PAYMENT_TERM_TYPE IN  EAPP_PAYMENT_TERM.PAYMENT_TERM_TYPE%TYPE
                                     ,W_ENABLED_FLAG       IN  EAPP_PAYMENT_TERM.ENABLED_FLAG%TYPE
                                     );

  PROCEDURE EAPP_PAYMENT_TERM_SELECT2(P_CURSOR            OUT  TYPES.TCURSOR
                                     ,W_SOB_ID            IN   EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN   EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     );

  PROCEDURE EAPP_PAYMENT_TERM_SELECT3(P_CURSOR            OUT  TYPES.TCURSOR
                                     ,W_SOB_ID            IN   EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN   EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     );

PROCEDURE EAPP_PAYMENT_TERM_INSERT( P_PAYMENT_TERM_ID   OUT EAPP_PAYMENT_TERM.PAYMENT_TERM_ID%TYPE
                                  , P_SOB_ID            IN EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                  , P_ORG_ID            IN EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                  , P_PAYMENT_TERM_TYPE IN EAPP_PAYMENT_TERM.PAYMENT_TERM_TYPE%TYPE
                                  , P_DESCRIPTION       IN EAPP_PAYMENT_TERM.DESCRIPTION%TYPE
                                  , P_CASH_TYPE         IN EAPP_PAYMENT_TERM.CASH_TYPE%TYPE
                                  , P_AFTER_MONTH       IN EAPP_PAYMENT_TERM.AFTER_MONTH%TYPE
                                  , P_AFTER_DAYS        IN EAPP_PAYMENT_TERM.AFTER_DAYS%TYPE
                                  , P_SPECIFIED_DAY     IN EAPP_PAYMENT_TERM.SPECIFIED_DAY%TYPE
                                  , P_EFFECTIVE_DATE_FR IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG      IN EAPP_PAYMENT_TERM.ENABLED_FLAG%TYPE
                                  , P_USER_ID           IN EAPP_PAYMENT_TERM.CREATED_BY%TYPE );

PROCEDURE EAPP_PAYMENT_TERM_UPDATE( W_PAYMENT_TERM_ID   IN EAPP_PAYMENT_TERM.PAYMENT_TERM_ID%TYPE
                                  , P_SOB_ID            IN EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                  , P_ORG_ID            IN EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                  , P_PAYMENT_TERM_TYPE IN EAPP_PAYMENT_TERM.PAYMENT_TERM_TYPE%TYPE
                                  , P_DESCRIPTION       IN EAPP_PAYMENT_TERM.DESCRIPTION%TYPE
                                  , P_CASH_TYPE         IN EAPP_PAYMENT_TERM.CASH_TYPE%TYPE
                                  , P_AFTER_MONTH       IN EAPP_PAYMENT_TERM.AFTER_MONTH%TYPE
                                  , P_AFTER_DAYS        IN EAPP_PAYMENT_TERM.AFTER_DAYS%TYPE
                                  , P_SPECIFIED_DAY     IN EAPP_PAYMENT_TERM.SPECIFIED_DAY%TYPE
                                  , P_EFFECTIVE_DATE_FR IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG      IN EAPP_PAYMENT_TERM.ENABLED_FLAG%TYPE
                                  , P_USER_ID           IN EAPP_PAYMENT_TERM.CREATED_BY%TYPE );

/*  PROCEDURE EAPP_PAYMENT_TERM_DELETE (W_PAYMENT_TERM_ID   IN EAPP_PAYMENT_TERM.PAYMENT_TERM_ID%TYPE
                                     ,W_SOB_ID            IN EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     );*/

-- 만기일자 -- 
FUNCTION GET_DUE_DATE_F
          ( P_PAYMENT_TERM_ID     IN VARCHAR2 
          , P_DATE                IN DATE 
          ) RETURN DATE;
          
-- 만기일자 -- 
PROCEDURE GET_DUE_DATE_P
          ( P_PAYMENT_TERM_ID     IN VARCHAR2 
          , P_DATE                IN DATE 
          , O_DUE_DATE            OUT DATE 
          );
          
end EAPP_PAYMENT_TERM_G; 
/
create or replace package body EAPP_PAYMENT_TERM_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_PAYMENT_TERM_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 13-JUL-2010  Kim Han Cheol       Initialize
--==============================================================================


  PROCEDURE EAPP_PAYMENT_TERM_SELECT1(P_CURSOR            OUT TYPES.TCURSOR
                                     ,W_SOB_ID            IN  EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN  EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     ,W_PAYMENT_TERM_TYPE IN  EAPP_PAYMENT_TERM.PAYMENT_TERM_TYPE%TYPE
                                     ,W_ENABLED_FLAG       IN  EAPP_PAYMENT_TERM.ENABLED_FLAG%TYPE
                                     )

    IS

      V_LOCAL_DATE  DATE := TRUNC(get_local_date(W_SOB_ID));

    BEGIN
        OPEN P_CURSOR FOR
      SELECT PT.PAYMENT_TERM_ID
            ,PT.PAYMENT_TERM_TYPE
            ,PT.DESCRIPTION
            ,PT.CASH_TYPE
            ,PT.AFTER_MONTH
            ,PT.AFTER_DAYS
            ,PT.SPECIFIED_DAY
            ,PT.EFFECTIVE_DATE_FR
            ,PT.EFFECTIVE_DATE_TO
            ,PT.ENABLED_FLAG
        FROM EAPP_PAYMENT_TERM PT
       WHERE PT.SOB_ID            = W_SOB_ID
         AND PT.ORG_ID            = W_ORG_ID
         AND PT.PAYMENT_TERM_TYPE = NVL(W_PAYMENT_TERM_TYPE, PT.PAYMENT_TERM_TYPE)
         AND ((W_ENABLED_FLAG = 'N' AND 1 = 1)
          OR  (W_ENABLED_FLAG = 'Y' AND PT.ENABLED_FLAG = 'Y'
                                    AND V_LOCAL_DATE BETWEEN PT.EFFECTIVE_DATE_FR
                                    AND NVL(PT.EFFECTIVE_DATE_TO, V_LOCAL_DATE)));
      END;

  PROCEDURE EAPP_PAYMENT_TERM_SELECT2(P_CURSOR            OUT  TYPES.TCURSOR
                                     ,W_SOB_ID            IN   EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN   EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     )

    IS

    BEGIN
        OPEN P_CURSOR FOR
      SELECT PT.PAYMENT_TERM_TYPE
            ,PT.DESCRIPTION
        FROM EAPP_PAYMENT_TERM PT
       WHERE PT.SOB_ID          = W_SOB_ID
         AND PT.ORG_ID          = W_ORG_ID;
    END;

  PROCEDURE EAPP_PAYMENT_TERM_SELECT3(P_CURSOR            OUT  TYPES.TCURSOR
                                     ,W_SOB_ID            IN   EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                     ,W_ORG_ID            IN   EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                     )
    IS

    BEGIN

      OPEN P_CURSOR FOR
      SELECT LE.ENTRY_DESCRIPTION
            ,LE.ENTRY_CODE
        FROM EAPP_LOOKUP_TYPE LT
            ,EAPP_LOOKUP_ENTRY LE
       WHERE LT.LOOKUP_TYPE_ID = LE.LOOKUP_TYPE_ID
         AND LT.LOOKUP_TYPE    = 'PAYMENT_TERM_CASH_TYPE'
         AND LE.SOB_ID         = W_SOB_ID
         AND LE.ORG_ID         = W_ORG_ID
         AND LT.SOB_ID         = LE.SOB_ID
         AND LT.ORG_ID         = LE.ORG_ID ;
    END;

PROCEDURE EAPP_PAYMENT_TERM_INSERT( P_PAYMENT_TERM_ID   OUT EAPP_PAYMENT_TERM.PAYMENT_TERM_ID%TYPE
                                  , P_SOB_ID            IN EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                  , P_ORG_ID            IN EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                  , P_PAYMENT_TERM_TYPE IN EAPP_PAYMENT_TERM.PAYMENT_TERM_TYPE%TYPE
                                  , P_DESCRIPTION       IN EAPP_PAYMENT_TERM.DESCRIPTION%TYPE
                                  , P_CASH_TYPE         IN EAPP_PAYMENT_TERM.CASH_TYPE%TYPE
                                  , P_AFTER_MONTH       IN EAPP_PAYMENT_TERM.AFTER_MONTH%TYPE
                                  , P_AFTER_DAYS        IN EAPP_PAYMENT_TERM.AFTER_DAYS%TYPE
                                  , P_SPECIFIED_DAY     IN EAPP_PAYMENT_TERM.SPECIFIED_DAY%TYPE
                                  , P_EFFECTIVE_DATE_FR IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG      IN EAPP_PAYMENT_TERM.ENABLED_FLAG%TYPE
                                  , P_USER_ID           IN EAPP_PAYMENT_TERM.CREATED_BY%TYPE )
IS

 V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

 SELECT EAPP_PAYMENT_TERM_S1.NEXTVAL
   INTO P_PAYMENT_TERM_ID
   FROM DUAL;

  BEGIN
     INSERT INTO EAPP_PAYMENT_TERM
               ( PAYMENT_TERM_ID
               , SOB_ID
               , ORG_ID
               , PAYMENT_TERM_TYPE
               , DESCRIPTION
               , CASH_TYPE
               , AFTER_MONTH
               , AFTER_DAYS
               , SPECIFIED_DAY
               , EFFECTIVE_DATE_FR
               , EFFECTIVE_DATE_TO
               , ENABLED_FLAG
               , CREATION_DATE
               , CREATED_BY
               , LAST_UPDATE_DATE
               , LAST_UPDATED_BY )
               VALUES
               ( P_PAYMENT_TERM_ID
               , P_SOB_ID
               , P_ORG_ID
               , P_PAYMENT_TERM_TYPE
               , P_DESCRIPTION
               , P_CASH_TYPE
               , P_AFTER_MONTH
               , P_AFTER_DAYS
               , P_SPECIFIED_DAY
               , P_EFFECTIVE_DATE_FR
               , P_EFFECTIVE_DATE_TO
               , P_ENABLED_FLAG
               , V_SYSDATE
               , P_USER_ID
               , V_SYSDATE
               , P_USER_ID );
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                   RAISE_APPLICATION_ERROR(-20001, eapp_message_g.RETURN_TEXT_F(userenv_g.GET_TERRITORY_S_F, 'EAPP_90003',  ':=TRANSACTION_TYPE') );
              WHEN OTHERS THEN
                   RAISE_APPLICATION_ERROR(-20001, 'Error Message');
    END;

END EAPP_PAYMENT_TERM_INSERT;


PROCEDURE EAPP_PAYMENT_TERM_UPDATE( W_PAYMENT_TERM_ID   IN EAPP_PAYMENT_TERM.PAYMENT_TERM_ID%TYPE
                                  , P_SOB_ID            IN EAPP_PAYMENT_TERM.SOB_ID%TYPE
                                  , P_ORG_ID            IN EAPP_PAYMENT_TERM.ORG_ID%TYPE
                                  , P_PAYMENT_TERM_TYPE IN EAPP_PAYMENT_TERM.PAYMENT_TERM_TYPE%TYPE
                                  , P_DESCRIPTION       IN EAPP_PAYMENT_TERM.DESCRIPTION%TYPE
                                  , P_CASH_TYPE         IN EAPP_PAYMENT_TERM.CASH_TYPE%TYPE
                                  , P_AFTER_MONTH       IN EAPP_PAYMENT_TERM.AFTER_MONTH%TYPE
                                  , P_AFTER_DAYS        IN EAPP_PAYMENT_TERM.AFTER_DAYS%TYPE
                                  , P_SPECIFIED_DAY     IN EAPP_PAYMENT_TERM.SPECIFIED_DAY%TYPE
                                  , P_EFFECTIVE_DATE_FR IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_FR%TYPE
                                  , P_EFFECTIVE_DATE_TO IN EAPP_PAYMENT_TERM.EFFECTIVE_DATE_TO%TYPE
                                  , P_ENABLED_FLAG      IN EAPP_PAYMENT_TERM.ENABLED_FLAG%TYPE
                                  , P_USER_ID           IN EAPP_PAYMENT_TERM.CREATED_BY%TYPE )
IS

 V_SYSDATE DATE := GET_LOCAL_DATE(P_SOB_ID);

BEGIN

  BEGIN
   UPDATE EAPP_PAYMENT_TERM
      SET SOB_ID            = P_SOB_ID
        , ORG_ID            = P_ORG_ID
        , PAYMENT_TERM_TYPE = P_PAYMENT_TERM_TYPE
        , DESCRIPTION       = P_DESCRIPTION
        , CASH_TYPE         = P_CASH_TYPE
        , AFTER_MONTH       = P_AFTER_MONTH
        , AFTER_DAYS        = P_AFTER_DAYS
        , SPECIFIED_DAY     = P_SPECIFIED_DAY
        , EFFECTIVE_DATE_FR = P_EFFECTIVE_DATE_FR
        , EFFECTIVE_DATE_TO = P_EFFECTIVE_DATE_TO
        , ENABLED_FLAG      = P_ENABLED_FLAG
        , LAST_UPDATE_DATE  = V_SYSDATE
        , LAST_UPDATED_BY   = P_USER_ID
    WHERE PAYMENT_TERM_ID   = W_PAYMENT_TERM_ID;
   EXCEPTION WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error Message');
   END;

END EAPP_PAYMENT_TERM_UPDATE;

-- 만기일자 -- 
FUNCTION GET_DUE_DATE_F
          ( P_PAYMENT_TERM_ID     IN VARCHAR2 
          , P_DATE                IN DATE 
          ) RETURN DATE
AS
  V_DUE_DATE            DATE;
BEGIN
  BEGIN
    SELECT CASE
             WHEN PT.SPECIFIED_DAY >= 31 THEN LAST_DAY(ADD_MONTHS(P_DATE, PT.AFTER_MONTH)) 
             ELSE ADD_MONTHS(P_DATE, PT.AFTER_MONTH) + NVL(PT.AFTER_DAYS, 0) 
           END AS DUE_DATE  
      INTO V_DUE_DATE
      FROM EAPP_PAYMENT_TERM PT
     WHERE PT.PAYMENT_TERM_ID   = P_PAYMENT_TERM_ID 
     ;
  EXCEPTION
    WHEN OTHERS THEN
      V_DUE_DATE := P_DATE;
  END;
  RETURN V_DUE_DATE;
END GET_DUE_DATE_F;
          
-- 만기일자 -- 
PROCEDURE GET_DUE_DATE_P
          ( P_PAYMENT_TERM_ID     IN VARCHAR2 
          , P_DATE                IN DATE 
          , O_DUE_DATE            OUT DATE 
          )
AS
BEGIN
  O_DUE_DATE := GET_DUE_DATE_F
                ( P_PAYMENT_TERM_ID  => P_PAYMENT_TERM_ID 
                , P_DATE             => P_DATE 
                );
END GET_DUE_DATE_P;
          
end EAPP_PAYMENT_TERM_G; 
/
