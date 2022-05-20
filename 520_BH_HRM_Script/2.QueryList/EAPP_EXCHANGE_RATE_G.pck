create or replace package EAPP_EXCHANGE_RATE_G is
--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_EXCHANGE_RATE_G
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 28-JUL-2010  Kim Han Cheol       Initialize
--==============================================================================

  PROCEDURE EAPP_EXCHANGE_RATE_SELECT1(P_CURSOR        OUT  TYPES.TCURSOR
                                      ,W_SOB_ID        IN   EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,W_ORG_ID        IN   EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      ,W_SORT_RULE     IN   NUMBER
                                      ,W_APPLY_DATE_FR IN   EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,W_APPLY_DATE_TO IN   EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,W_FROM_CURRENCY IN   EAPP_EXCHANGE_RATE.FROM_CURRENCY%TYPE
                                      ,W_TO_CURRENCY   IN   EAPP_EXCHANGE_RATE.TO_CURRENCY%TYPE
                                      );

  PROCEDURE EAPP_EXCHANGE_RATE_SELECT2(P_CURSOR        OUT  TYPES.TCURSOR
                                      ,W_SOB_ID        IN   EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,W_ORG_ID        IN   EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      );

  PROCEDURE EAPP_EXCHANGE_RATE_SELECT3(P_CURSOR        OUT  TYPES.TCURSOR
                                      ,W_SOB_ID        IN   EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,W_ORG_ID        IN   EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      );

  PROCEDURE EAPP_EXCHANGE_RATE_INSERT (P_SOB_ID        IN  EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,P_ORG_ID        IN  EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      ,P_APPLY_DATE    IN  EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,P_FROM_CURRENCY IN  EAPP_EXCHANGE_RATE.FROM_CURRENCY%TYPE
                                      ,P_TO_CURRENCY   IN  EAPP_EXCHANGE_RATE.TO_CURRENCY%TYPE
                                      ,P_SELLING_RATE  IN  EAPP_EXCHANGE_RATE.SELLING_RATE%TYPE
                                      ,P_BUYING_RATE   IN  EAPP_EXCHANGE_RATE.BUYING_RATE%TYPE
                                      ,P_BASE_RATE     IN  EAPP_EXCHANGE_RATE.BASE_RATE%TYPE
                                      ,P_USER_ID       IN  EAPP_EXCHANGE_RATE.CREATED_BY%TYPE
                                      );


  PROCEDURE EAPP_EXCHANGE_RATE_UPDATE (P_SOB_ID        IN  EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,P_ORG_ID        IN  EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      ,P_APPLY_DATE    IN  EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,P_FROM_CURRENCY IN  EAPP_EXCHANGE_RATE.FROM_CURRENCY%TYPE
                                      ,P_TO_CURRENCY   IN  EAPP_EXCHANGE_RATE.TO_CURRENCY%TYPE
                                      ,P_SELLING_RATE  IN  EAPP_EXCHANGE_RATE.SELLING_RATE%TYPE
                                      ,P_BUYING_RATE   IN  EAPP_EXCHANGE_RATE.BUYING_RATE%TYPE
                                      ,P_BASE_RATE     IN  EAPP_EXCHANGE_RATE.BASE_RATE%TYPE
                                      ,P_USER_ID       IN  EAPP_EXCHANGE_RATE.CREATED_BY%TYPE
                                      );

end EAPP_EXCHANGE_RATE_G; 
 
/
create or replace package body EAPP_EXCHANGE_RATE_G is

--==============================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_EXCHANGE_RATE_G [EAPF0202]
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 28-JUL-2010  Kim Han Cheol       Initialize
--==============================================================================


  PROCEDURE EAPP_EXCHANGE_RATE_SELECT1(P_CURSOR        OUT  TYPES.TCURSOR
                                      ,W_SOB_ID        IN   EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,W_ORG_ID        IN   EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      ,W_SORT_RULE     IN   NUMBER
                                      ,W_APPLY_DATE_FR IN   EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,W_APPLY_DATE_TO IN   EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,W_FROM_CURRENCY IN   EAPP_EXCHANGE_RATE.FROM_CURRENCY%TYPE
                                      ,W_TO_CURRENCY   IN   EAPP_EXCHANGE_RATE.TO_CURRENCY%TYPE
                                      )

    IS
    BEGIN
          IF W_SORT_RULE   = 1 THEN
        OPEN P_CURSOR FOR
      SELECT ER.SOB_ID
            ,ER.ORG_ID
            ,ER.FROM_CURRENCY
            ,ER.TO_CURRENCY
            ,ER.APPLY_DATE
            ,ER.SELLING_RATE
            ,ER.BUYING_RATE
            ,ER.BASE_RATE
        FROM EAPP_EXCHANGE_RATE ER
       WHERE ER.SOB_ID        = W_SOB_ID
         AND ER.ORG_ID        = W_ORG_ID
         AND ER.APPLY_DATE    BETWEEN NVL(W_APPLY_DATE_FR, ER.APPLY_DATE) AND NVL(W_APPLY_DATE_TO, ER.APPLY_DATE)
         AND ER.FROM_CURRENCY LIKE   W_FROM_CURRENCY ||'%'
         AND ER.TO_CURRENCY   LIKE   W_TO_CURRENCY  ||'%'
    ORDER BY ER.APPLY_DATE, ER.FROM_CURRENCY, ER.TO_CURRENCY;

    ELSE
        OPEN P_CURSOR FOR
      SELECT ER.SOB_ID
            ,ER.ORG_ID
            ,ER.FROM_CURRENCY
            ,ER.TO_CURRENCY
            ,ER.APPLY_DATE
            ,ER.SELLING_RATE
            ,ER.BUYING_RATE
            ,ER.BASE_RATE
        FROM EAPP_EXCHANGE_RATE ER
       WHERE ER.SOB_ID     = W_SOB_ID
         AND ER.ORG_ID     = W_ORG_ID
         AND ER.APPLY_DATE    BETWEEN NVL(W_APPLY_DATE_FR, ER.APPLY_DATE) AND NVL(W_APPLY_DATE_TO, ER.APPLY_DATE)
         AND ER.FROM_CURRENCY LIKE   W_FROM_CURRENCY ||'%'
         AND ER.TO_CURRENCY   LIKE   W_TO_CURRENCY  ||'%'
    ORDER BY ER.FROM_CURRENCY, ER.TO_CURRENCY, ER.APPLY_DATE;
      END IF;
    END;


  PROCEDURE EAPP_EXCHANGE_RATE_SELECT2(P_CURSOR        OUT  TYPES.TCURSOR
                                      ,W_SOB_ID        IN   EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,W_ORG_ID        IN   EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      )

    IS

    BEGIN
        OPEN P_CURSOR FOR
      SELECT ER.FROM_CURRENCY
        FROM EAPP_EXCHANGE_RATE ER
       WHERE ER.SOB_ID  =  W_SOB_ID
         AND ER.ORG_ID  =  W_ORG_ID;
    END;

  PROCEDURE EAPP_EXCHANGE_RATE_SELECT3(P_CURSOR        OUT  TYPES.TCURSOR
                                      ,W_SOB_ID        IN   EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,W_ORG_ID        IN   EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      )

    IS

    BEGIN
        OPEN P_CURSOR FOR
      SELECT ER.TO_CURRENCY
        FROM EAPP_EXCHANGE_RATE ER
       WHERE ER.SOB_ID  =  W_SOB_ID
         AND ER.ORG_ID  =  W_ORG_ID;
    END;

  PROCEDURE EAPP_EXCHANGE_RATE_INSERT (P_SOB_ID        IN  EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,P_ORG_ID        IN  EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      ,P_APPLY_DATE    IN  EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,P_FROM_CURRENCY IN  EAPP_EXCHANGE_RATE.FROM_CURRENCY%TYPE
                                      ,P_TO_CURRENCY   IN  EAPP_EXCHANGE_RATE.TO_CURRENCY%TYPE
                                      ,P_SELLING_RATE  IN  EAPP_EXCHANGE_RATE.SELLING_RATE%TYPE
                                      ,P_BUYING_RATE   IN  EAPP_EXCHANGE_RATE.BUYING_RATE%TYPE
                                      ,P_BASE_RATE     IN  EAPP_EXCHANGE_RATE.BASE_RATE%TYPE
                                      ,P_USER_ID       IN  EAPP_EXCHANGE_RATE.CREATED_BY%TYPE
                                      )
    IS
      V_SYSTEM_DATE DATE;
      V_RECORD_COUNT                  NUMBER;

    BEGIN
      IF P_FROM_CURRENCY = P_TO_CURRENCY THEN
      -- 동일 통화 입력 불가.
        RAISE_APPLICATION_ERROR(-20001, EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'EAPP_10038', NULL));
      END IF;

      BEGIN
        SELECT COUNT(ER.APPLY_DATE) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM EAPP_EXCHANGE_RATE ER
         WHERE ER.APPLY_DATE      = P_APPLY_DATE
           AND ER.FROM_CURRENCY   = P_FROM_CURRENCY
           AND ER.TO_CURRENCY     = P_TO_CURRENCY
           AND ER.SOB_ID          = P_SOB_ID
           AND ER.ORG_ID          = P_ORG_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
      END;
      IF V_RECORD_COUNT <> 0 THEN
        RAISE ERRNUMS.Exist_Data;
      END IF;

      V_SYSTEM_DATE := get_local_date(P_SOB_ID);
      INSERT INTO
             EAPP_EXCHANGE_RATE
            (SOB_ID
            ,ORG_ID
            ,APPLY_DATE
            ,FROM_CURRENCY
            ,TO_CURRENCY
            ,SELLING_RATE
            ,BUYING_RATE
            ,BASE_RATE
            ,CREATION_DATE
            ,CREATED_BY
            ,LAST_UPDATE_DATE
            ,LAST_UPDATED_BY
            )

     VALUES (P_SOB_ID
            ,P_ORG_ID
            ,P_APPLY_DATE
            ,P_FROM_CURRENCY
            ,P_TO_CURRENCY
            ,P_SELLING_RATE
            ,P_BUYING_RATE
            ,P_BASE_RATE
            ,V_SYSTEM_DATE
            ,P_USER_ID
            ,V_SYSTEM_DATE
            ,P_USER_ID
            );

    EXCEPTION
          WHEN ERRNUMS.Exist_Data THEN
          RAISE_APPLICATION_ERROR(ERRNUMS.Exist_Data_Code, ERRNUMS.Exist_Data_Desc);
          WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001, SQLERRM);
    END;

  PROCEDURE EAPP_EXCHANGE_RATE_UPDATE (P_SOB_ID        IN  EAPP_EXCHANGE_RATE.SOB_ID%TYPE
                                      ,P_ORG_ID        IN  EAPP_EXCHANGE_RATE.ORG_ID%TYPE
                                      ,P_APPLY_DATE    IN  EAPP_EXCHANGE_RATE.APPLY_DATE%TYPE
                                      ,P_FROM_CURRENCY IN  EAPP_EXCHANGE_RATE.FROM_CURRENCY%TYPE
                                      ,P_TO_CURRENCY   IN  EAPP_EXCHANGE_RATE.TO_CURRENCY%TYPE
                                      ,P_SELLING_RATE  IN  EAPP_EXCHANGE_RATE.SELLING_RATE%TYPE
                                      ,P_BUYING_RATE   IN  EAPP_EXCHANGE_RATE.BUYING_RATE%TYPE
                                      ,P_BASE_RATE     IN  EAPP_EXCHANGE_RATE.BASE_RATE%TYPE
                                      ,P_USER_ID       IN  EAPP_EXCHANGE_RATE.CREATED_BY%TYPE
                                      )
    IS
      V_SYSTEM_DATE DATE;
    BEGIN
      V_SYSTEM_DATE := get_local_date(P_SOB_ID);

      UPDATE EAPP_EXCHANGE_RATE
         SET SELLING_RATE      = P_SELLING_RATE
            ,BUYING_RATE       = P_BUYING_RATE
            ,BASE_RATE         = P_BASE_RATE
            ,LAST_UPDATE_DATE  = V_SYSTEM_DATE
            ,LAST_UPDATED_BY   = P_USER_ID
      WHERE SOB_ID            = P_SOB_ID
        AND ORG_ID            = P_ORG_ID
        AND APPLY_DATE        = P_APPLY_DATE
        AND FROM_CURRENCY     = P_FROM_CURRENCY
        AND TO_CURRENCY       = P_TO_CURRENCY;

  END;


end EAPP_EXCHANGE_RATE_G; 
/
