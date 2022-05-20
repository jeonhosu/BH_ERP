create or replace package EAPP_CURRENCY_G is
--========================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_CURRENCY_G [EAPF0201]
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 05-JUL-2010  JANG Do Chun       Initialize
-- 27-JUL-2010  KIM  Han Cheol     Update
-- 18-OCT-2010  JUN Won Tai        Update
--==============================================================================

  PROCEDURE EAPP_CURRENCY_SELECT1(P_CURSOR                 OUT TYPES.TCURSOR
                                 ,W_SOB_ID                 IN  EAPP_CURRENCY.SOB_ID%TYPE
                                 ,W_ORG_ID                 IN  EAPP_CURRENCY.ORG_ID%TYPE
                                 );

  PROCEDURE EAPP_CURRENCY_SELECT2(P_CURSOR                 OUT TYPES.TCURSOR
                                 ,W_SOB_ID                 IN  EAPP_CURRENCY.SOB_ID%TYPE
                                 ,W_ORG_ID                 IN  EAPP_CURRENCY.ORG_ID%TYPE
                                 ,W_CURRENCY_CODE          IN  EAPP_CURRENCY.CURRENCY_CODE%TYPE
                                 ,W_ENABLED_FLAG           IN  EAPP_CURRENCY.ENABLED_FLAG%TYPE
                                 );
  PROCEDURE EAPP_CURRENCY_SELECT3(P_CURSOR                 OUT TYPES.TCURSOR
                                 ,W_SOB_ID                 IN  EAPP_LOOKUP_ENTRY.SOB_ID%TYPE
                                 ,W_ORG_ID                 IN  EAPP_LOOKUP_ENTRY.ORG_ID%TYPE
                                 );

  PROCEDURE EAPP_CURRENCY_INSERT (P_CURRENCY_ID            OUT EAPP_CURRENCY.CURRENCY_ID%TYPE
                                 ,P_SOB_ID                 IN  EAPP_CURRENCY.SOB_ID%TYPE
                                 ,P_ORG_ID                 IN  EAPP_CURRENCY.ORG_ID%TYPE
                                 ,P_CURRENCY_CODE          IN  EAPP_CURRENCY.CURRENCY_CODE%TYPE
                                 ,P_CURRENCY_DESC          IN  EAPP_CURRENCY.CURRENCY_DESC%TYPE
                                 ,P_CURRENCY_SYMBOL        IN  EAPP_CURRENCY.CURRENCY_SYMBOL%TYPE
                                 ,P_ENABLED_FLAG           IN  EAPP_SINGLE.ENABLED_FLAG%TYPE
                                 ,P_EFFECTIVE_DATE_FR      IN  EAPP_CURRENCY.EFFECTIVE_DATE_FR%TYPE
                                 ,P_EFFECTIVE_DATE_TO      IN  EAPP_CURRENCY.EFFECTIVE_DATE_TO%TYPE
                                 ,P_PRICE_DECIMAL_POINT    IN  EAPP_CURRENCY.PRICE_DECIMAL_POINT%TYPE
                                 ,P_AMOUNT_DECIMAL_POINT   IN  EAPP_CURRENCY.AMOUNT_DECIMAL_POINT%TYPE
                                 ,P_ROUNDING_RULE_LCODE    IN  EAPP_CURRENCY.ROUNDING_RULE_LCODE%TYPE
                                 ,P_DISP_SEPERATE_POSITION IN  EAPP_CURRENCY.DISP_SEPERATE_POSITION%TYPE
                                 ,P_DISP_SEPERATE_SYMBOL   IN  EAPP_CURRENCY.DISP_SEPERATE_SYMBOL%TYPE
                                 ,P_DISP_DECIMAL_SYMBOL    IN  EAPP_CURRENCY.DISP_DECIMAL_SYMBOL%TYPE
                                 ,P_PRICE_FORMAT_MASK      IN  EAPP_CURRENCY.PRICE_FORMAT_MASK%TYPE
                                 ,P_AMOUNT_FORMAT_MASK     IN  EAPP_CURRENCY.AMOUNT_FORMAT_MASK%TYPE
                                 ,P_USER_ID                IN  EAPP_CURRENCY.CREATED_BY%TYPE
                                 );

  PROCEDURE EAPP_CURRENCY_UPDATE(W_CURRENCY_ID             IN  EAPP_CURRENCY.CURRENCY_ID%TYPE
                                ,P_SOB_ID                  IN  EAPP_CURRENCY.SOB_ID%TYPE
                                ,P_ORG_ID                  IN  EAPP_CURRENCY.ORG_ID%TYPE
                                ,P_CURRENCY_CODE           IN  EAPP_CURRENCY.CURRENCY_CODE%TYPE
                                ,P_CURRENCY_DESC           IN  EAPP_CURRENCY.CURRENCY_DESC%TYPE
                                ,P_CURRENCY_SYMBOL         IN  EAPP_CURRENCY.CURRENCY_SYMBOL%TYPE
                                ,P_ENABLED_FLAG            IN  EAPP_CURRENCY.ENABLED_FLAG%TYPE
                                ,P_EFFECTIVE_DATE_FR       IN  EAPP_CURRENCY.EFFECTIVE_DATE_FR%TYPE
                                ,P_EFFECTIVE_DATE_TO       IN  EAPP_CURRENCY.EFFECTIVE_DATE_TO%TYPE
                                ,P_PRICE_DECIMAL_POINT     IN  EAPP_CURRENCY.PRICE_DECIMAL_POINT%TYPE
                                ,P_AMOUNT_DECIMAL_POINT    IN  EAPP_CURRENCY.AMOUNT_DECIMAL_POINT%TYPE
                                ,P_ROUNDING_RULE_LCODE     IN  EAPP_CURRENCY.ROUNDING_RULE_LCODE%TYPE
                                ,P_DISP_SEPERATE_POSITION  IN  EAPP_CURRENCY.DISP_SEPERATE_POSITION%TYPE
                                ,P_DISP_SEPERATE_SYMBOL    IN  EAPP_CURRENCY.DISP_SEPERATE_SYMBOL%TYPE
                                ,P_DISP_DECIMAL_SYMBOL     IN  EAPP_CURRENCY.DISP_DECIMAL_SYMBOL%TYPE
                                ,P_PRICE_FORMAT_MASK       IN  EAPP_CURRENCY.PRICE_FORMAT_MASK%TYPE
                                ,P_AMOUNT_FORMAT_MASK      IN  EAPP_CURRENCY.AMOUNT_FORMAT_MASK%TYPE
                                ,P_USER_ID                 IN  EAPP_CURRENCY.LAST_UPDATED_BY%TYPE
                                );

---------------------------------------------------------------------------------------------------
-- 통화명 반환.
  FUNCTION CURRENCY_DESC_F
            ( W_CURRENCY_CODE          IN EAPP_CURRENCY.CURRENCY_CODE%TYPE
            , W_SOB_ID                 IN EAPP_CURRENCY.SOB_ID%TYPE
            , W_ORG_ID                 IN EAPP_CURRENCY.ORG_ID%TYPE
            ) RETURN VARCHAR2;

-- 통화에 따른 금액 표시.
  FUNCTION DISPLAY_AMOUNT_F
            ( W_CURRENCY_CODE          IN EAPP_CURRENCY.CURRENCY_CODE%TYPE
            , W_AMOUNT                 IN NUMBER
            , W_SOB_ID                 IN EAPP_CURRENCY.SOB_ID%TYPE
            , W_ORG_ID                 IN EAPP_CURRENCY.ORG_ID%TYPE
            ) RETURN VARCHAR2;

end EAPP_CURRENCY_G; 

 
/
create or replace package body EAPP_CURRENCY_G is

--========================================================================
-- Project      : FLEX ERP
-- Module       : COMMON
-- Program Name : EAPP_CURRENCY_G [EAPF0201]
-- Description  : Packing Box Define
--
-- Reference by :
-- Program History
--------------------------------------------------------------------------------
--   Date       In Charge          Description
--------------------------------------------------------------------------------
-- 05-JUL-2010  JANG Do Chun       Initialize
-- 27-JUL-2010  KIM  Han Cheol     Update
-- 18-OCT-2010  JUN Won Tai        Update
--==============================================================================

  PROCEDURE EAPP_CURRENCY_SELECT1(P_CURSOR                 OUT TYPES.TCURSOR
                                 ,W_SOB_ID                 IN  EAPP_CURRENCY.SOB_ID%TYPE
                                 ,W_ORG_ID                 IN  EAPP_CURRENCY.ORG_ID%TYPE
                                 )

    IS
    BEGIN
        OPEN P_CURSOR FOR
      SELECT EC.CURRENCY_CODE
            ,EC.CURRENCY_DESC
        FROM EAPP_CURRENCY EC
       WHERE EC.SOB_ID  = W_SOB_ID
         AND EC.ORG_ID  = W_ORG_ID;


    END;

  PROCEDURE EAPP_CURRENCY_SELECT2(P_CURSOR                 OUT TYPES.TCURSOR
                                 ,W_SOB_ID                 IN  EAPP_CURRENCY.SOB_ID%TYPE
                                 ,W_ORG_ID                 IN  EAPP_CURRENCY.ORG_ID%TYPE
                                 ,W_CURRENCY_CODE          IN  EAPP_CURRENCY.CURRENCY_CODE%TYPE
                                 ,W_ENABLED_FLAG           IN  EAPP_CURRENCY.ENABLED_FLAG%TYPE
                                 )
    IS

      V_LOCAL_DATE  DATE := TRUNC(get_local_date(W_SOB_ID));

    BEGIN
        OPEN P_CURSOR FOR
      SELECT EC.CURRENCY_ID
            ,EC.CURRENCY_CODE
            ,EC.CURRENCY_DESC
            ,EC.CURRENCY_SYMBOL
            ,EC.PRICE_DECIMAL_POINT
            ,EC.AMOUNT_DECIMAL_POINT
            ,LE.ENTRY_DESCRIPTION AS ROUNDING_RULE_LCODE_KOR
            ,EC.ROUNDING_RULE_LCODE AS ROUNDING_RULE_LCODE_ENG
            ,EC.DISP_SEPERATE_POSITION
            ,EC.DISP_SEPERATE_SYMBOL
            ,EC.DISP_DECIMAL_SYMBOL
            ,EC.PRICE_FORMAT_MASK
            ,EC.AMOUNT_FORMAT_MASK
            ,EC.EFFECTIVE_DATE_FR
            ,EC.EFFECTIVE_DATE_TO
            ,EC.ENABLED_FLAG
        FROM EAPP_CURRENCY EC
            ,EAPP_LOOKUP_ENTRY LE
       WHERE EC.ROUNDING_RULE_LCODE = LE.ENTRY_CODE
         AND EC.SOB_ID        = W_SOB_ID
         AND EC.ORG_ID        = W_ORG_ID
         AND EC.SOB_ID        = LE.SOB_ID
         AND EC.ORG_ID        = LE.ORG_ID
         AND EC.CURRENCY_CODE = NVL(W_CURRENCY_CODE, EC.CURRENCY_CODE)
         AND ((W_ENABLED_FLAG = 'N' AND 1 = 1)
          OR  (W_ENABLED_FLAG = 'Y' AND EC.ENABLED_FLAG = 'Y'
                                    AND V_LOCAL_DATE BETWEEN EC.EFFECTIVE_DATE_FR
                                    AND NVL(EC.EFFECTIVE_DATE_TO, V_LOCAL_DATE)));

    END;

  PROCEDURE EAPP_CURRENCY_SELECT3(P_CURSOR                 OUT TYPES.TCURSOR
                                 ,W_SOB_ID                 IN  EAPP_LOOKUP_ENTRY.SOB_ID%TYPE
                                 ,W_ORG_ID                 IN  EAPP_LOOKUP_ENTRY.ORG_ID%TYPE
                                 )
    IS
      V_LOCAL_DATE  DATE := TRUNC(get_local_date(W_SOB_ID));
    BEGIN
        OPEN P_CURSOR FOR
      SELECT LE.ENTRY_CODE
            ,LE.ENTRY_DESCRIPTION
            ,LE.ENTRY_TAG
        FROM EAPP_LOOKUP_ENTRY   LE
       WHERE LE.LOOKUP_TYPE = 'ROUNDING_RULE'
         AND LE.SOB_ID      = W_SOB_ID
         AND LE.ORG_ID      = W_ORG_ID
         AND V_LOCAL_DATE BETWEEN NVL(LE.EFFECTIVE_DATE_FR, V_LOCAL_DATE)
         AND NVL(LE.EFFECTIVE_DATE_TO, V_LOCAL_DATE)
         AND NVL(LE.ENABLED_FLAG,'N') = 'Y'
    ORDER BY LE.ENTRY_CODE;

       END;

  PROCEDURE EAPP_CURRENCY_INSERT (P_CURRENCY_ID            OUT EAPP_CURRENCY.CURRENCY_ID%TYPE
                                 ,P_SOB_ID                 IN  EAPP_CURRENCY.SOB_ID%TYPE
                                 ,P_ORG_ID                 IN  EAPP_CURRENCY.ORG_ID%TYPE
                                 ,P_CURRENCY_CODE          IN  EAPP_CURRENCY.CURRENCY_CODE%TYPE
                                 ,P_CURRENCY_DESC          IN  EAPP_CURRENCY.CURRENCY_DESC%TYPE
                                 ,P_CURRENCY_SYMBOL        IN  EAPP_CURRENCY.CURRENCY_SYMBOL%TYPE
                                 ,P_ENABLED_FLAG           IN  EAPP_SINGLE.ENABLED_FLAG%TYPE
                                 ,P_EFFECTIVE_DATE_FR      IN  EAPP_CURRENCY.EFFECTIVE_DATE_FR%TYPE
                                 ,P_EFFECTIVE_DATE_TO      IN  EAPP_CURRENCY.EFFECTIVE_DATE_TO%TYPE
                                 ,P_PRICE_DECIMAL_POINT    IN  EAPP_CURRENCY.PRICE_DECIMAL_POINT%TYPE
                                 ,P_AMOUNT_DECIMAL_POINT   IN  EAPP_CURRENCY.AMOUNT_DECIMAL_POINT%TYPE
                                 ,P_ROUNDING_RULE_LCODE    IN  EAPP_CURRENCY.ROUNDING_RULE_LCODE%TYPE
                                 ,P_DISP_SEPERATE_POSITION IN  EAPP_CURRENCY.DISP_SEPERATE_POSITION%TYPE
                                 ,P_DISP_SEPERATE_SYMBOL   IN  EAPP_CURRENCY.DISP_SEPERATE_SYMBOL%TYPE
                                 ,P_DISP_DECIMAL_SYMBOL    IN  EAPP_CURRENCY.DISP_DECIMAL_SYMBOL%TYPE
                                 ,P_PRICE_FORMAT_MASK      IN  EAPP_CURRENCY.PRICE_FORMAT_MASK%TYPE
                                 ,P_AMOUNT_FORMAT_MASK     IN  EAPP_CURRENCY.AMOUNT_FORMAT_MASK%TYPE
                                 ,P_USER_ID                IN  EAPP_CURRENCY.CREATED_BY%TYPE
                                 )

  IS
    V_SYSTEM_DATE DATE;

  BEGIN

    SELECT EAPP_CURRENCY_S1.NEXTVAL
      INTO P_CURRENCY_ID
      FROM DUAL;

    V_SYSTEM_DATE      := get_local_date(P_SOB_ID);

    BEGIN
      INSERT INTO
             EAPP_CURRENCY
            (CURRENCY_ID
            ,SOB_ID
            ,ORG_ID
            ,CURRENCY_CODE
            ,CURRENCY_DESC
            ,CURRENCY_SYMBOL
            ,ENABLED_FLAG
            ,EFFECTIVE_DATE_FR
            ,EFFECTIVE_DATE_TO
            ,PRICE_DECIMAL_POINT
            ,AMOUNT_DECIMAL_POINT
            ,ROUNDING_RULE_LCODE
            ,DISP_SEPERATE_POSITION
            ,DISP_SEPERATE_SYMBOL
            ,DISP_DECIMAL_SYMBOL
            ,PRICE_FORMAT_MASK
            ,AMOUNT_FORMAT_MASK
            ,CREATION_DATE
            ,CREATED_BY
            ,LAST_UPDATE_DATE
            ,LAST_UPDATED_BY
            )
    VALUES (P_CURRENCY_ID
           ,P_SOB_ID
           ,P_ORG_ID
           ,P_CURRENCY_CODE
           ,P_CURRENCY_DESC
           ,P_CURRENCY_SYMBOL
           ,P_ENABLED_FLAG
           ,P_EFFECTIVE_DATE_FR
           ,P_EFFECTIVE_DATE_TO
           ,P_PRICE_DECIMAL_POINT
           ,P_AMOUNT_DECIMAL_POINT
           ,P_ROUNDING_RULE_LCODE
           ,P_DISP_SEPERATE_POSITION
           ,P_DISP_SEPERATE_SYMBOL
           ,P_DISP_DECIMAL_SYMBOL
           ,P_PRICE_FORMAT_MASK
           ,P_AMOUNT_FORMAT_MASK
           ,V_SYSTEM_DATE
           ,P_USER_ID
           ,V_SYSTEM_DATE
           ,P_USER_ID
           );
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
                   RAISE_APPLICATION_ERROR(-20001, eapp_message_g.RETURN_TEXT_F(userenv_g.GET_TERRITORY_S_F, 'EAPP_90003','&&FIELD_NAME:=CURRENCY_CODE') );
              WHEN OTHERS THEN
                   RAISE_APPLICATION_ERROR(-20001, 'Error Message');
    END;

  END;

  PROCEDURE EAPP_CURRENCY_UPDATE(W_CURRENCY_ID             IN  EAPP_CURRENCY.CURRENCY_ID%TYPE
                                ,P_SOB_ID                  IN  EAPP_CURRENCY.SOB_ID%TYPE
                                ,P_ORG_ID                  IN  EAPP_CURRENCY.ORG_ID%TYPE
                                ,P_CURRENCY_CODE           IN  EAPP_CURRENCY.CURRENCY_CODE%TYPE
                                ,P_CURRENCY_DESC           IN  EAPP_CURRENCY.CURRENCY_DESC%TYPE
                                ,P_CURRENCY_SYMBOL         IN  EAPP_CURRENCY.CURRENCY_SYMBOL%TYPE
                                ,P_ENABLED_FLAG            IN  EAPP_CURRENCY.ENABLED_FLAG%TYPE
                                ,P_EFFECTIVE_DATE_FR       IN  EAPP_CURRENCY.EFFECTIVE_DATE_FR%TYPE
                                ,P_EFFECTIVE_DATE_TO       IN  EAPP_CURRENCY.EFFECTIVE_DATE_TO%TYPE
                                ,P_PRICE_DECIMAL_POINT     IN  EAPP_CURRENCY.PRICE_DECIMAL_POINT%TYPE
                                ,P_AMOUNT_DECIMAL_POINT    IN  EAPP_CURRENCY.AMOUNT_DECIMAL_POINT%TYPE
                                ,P_ROUNDING_RULE_LCODE     IN  EAPP_CURRENCY.ROUNDING_RULE_LCODE%TYPE
                                ,P_DISP_SEPERATE_POSITION  IN  EAPP_CURRENCY.DISP_SEPERATE_POSITION%TYPE
                                ,P_DISP_SEPERATE_SYMBOL    IN  EAPP_CURRENCY.DISP_SEPERATE_SYMBOL%TYPE
                                ,P_DISP_DECIMAL_SYMBOL     IN  EAPP_CURRENCY.DISP_DECIMAL_SYMBOL%TYPE
                                ,P_PRICE_FORMAT_MASK       IN  EAPP_CURRENCY.PRICE_FORMAT_MASK%TYPE
                                ,P_AMOUNT_FORMAT_MASK      IN  EAPP_CURRENCY.AMOUNT_FORMAT_MASK%TYPE
                                ,P_USER_ID                 IN  EAPP_CURRENCY.LAST_UPDATED_BY%TYPE
                                )

  IS
    V_SYSTEM_DATE DATE;

  BEGIN

    V_SYSTEM_DATE     := get_local_date(P_SOB_ID);

    BEGIN
      UPDATE EAPP_CURRENCY
         SET SOB_ID                 = P_SOB_ID
            ,ORG_ID                 = P_ORG_ID
            ,CURRENCY_CODE          = P_CURRENCY_CODE
            ,CURRENCY_DESC          = P_CURRENCY_DESC
            ,CURRENCY_SYMBOL        = P_CURRENCY_SYMBOL
            ,ENABLED_FLAG           = P_ENABLED_FLAG
            ,EFFECTIVE_DATE_FR      = P_EFFECTIVE_DATE_FR
            ,EFFECTIVE_DATE_TO      = P_EFFECTIVE_DATE_TO
            ,PRICE_DECIMAL_POINT    = P_PRICE_DECIMAL_POINT
            ,AMOUNT_DECIMAL_POINT   = P_AMOUNT_DECIMAL_POINT
            ,ROUNDING_RULE_LCODE    = P_ROUNDING_RULE_LCODE
            ,DISP_SEPERATE_POSITION = P_DISP_SEPERATE_POSITION
            ,DISP_SEPERATE_SYMBOL   = P_DISP_SEPERATE_SYMBOL
            ,DISP_DECIMAL_SYMBOL    = P_DISP_DECIMAL_SYMBOL
            ,PRICE_FORMAT_MASK      = P_PRICE_FORMAT_MASK
            ,AMOUNT_FORMAT_MASK     = P_AMOUNT_FORMAT_MASK
            ,LAST_UPDATE_DATE       = V_SYSTEM_DATE
            ,LAST_UPDATED_BY        = P_USER_ID
       WHERE CURRENCY_ID            = W_CURRENCY_ID;
    EXCEPTION WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001, 'Error Message');
    END;

  END;

---------------------------------------------------------------------------------------------------
-- 통화명 반환.
  FUNCTION CURRENCY_DESC_F
            ( W_CURRENCY_CODE          IN EAPP_CURRENCY.CURRENCY_CODE%TYPE
            , W_SOB_ID                 IN EAPP_CURRENCY.SOB_ID%TYPE
            , W_ORG_ID                 IN EAPP_CURRENCY.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_CURRENCY_DESC                    EAPP_CURRENCY.CURRENCY_DESC%TYPE := NULL;

  BEGIN
    BEGIN
      SELECT EC.CURRENCY_DESC
        INTO V_CURRENCY_DESC
        FROM EAPP_CURRENCY EC
       WHERE EC.CURRENCY_CODE          = W_CURRENCY_CODE
         AND EC.SOB_ID                 = W_SOB_ID
         AND EC.ORG_ID                 = W_ORG_ID
      ;

    EXCEPTION WHEN OTHERS THEN
      V_CURRENCY_DESC := W_CURRENCY_CODE;
    END;
    RETURN V_CURRENCY_DESC;

  END CURRENCY_DESC_F;

-- 통화에 따른 금액 표시.
  FUNCTION DISPLAY_AMOUNT_F
            ( W_CURRENCY_CODE          IN EAPP_CURRENCY.CURRENCY_CODE%TYPE
            , W_AMOUNT                 IN NUMBER
            , W_SOB_ID                 IN EAPP_CURRENCY.SOB_ID%TYPE
            , W_ORG_ID                 IN EAPP_CURRENCY.ORG_ID%TYPE
            ) RETURN VARCHAR2
  AS
    V_AMOUNT                           VARCHAR2(10000);
    V_SEPERATE_POSITION                EAPP_CURRENCY.DISP_SEPERATE_POSITION%TYPE;
    V_SEPERATE_SYMBOL                  EAPP_CURRENCY.DISP_SEPERATE_SYMBOL%TYPE;
    V_DECIMAL_SYMBOL                   EAPP_CURRENCY.DISP_DECIMAL_SYMBOL%TYPE;

    V_INTEGER_AMOUNT                   NUMBER := 0;
    V_DEGIT_AMOUNT                     NUMBER := 0;

  BEGIN
    BEGIN
      SELECT DISP_SEPERATE_POSITION
           , DISP_SEPERATE_SYMBOL
           , DISP_DECIMAL_SYMBOL
       INTO V_SEPERATE_POSITION
          , V_SEPERATE_SYMBOL
          , V_DECIMAL_SYMBOL
       FROM EAPP_CURRENCY EC
       WHERE EC.CURRENCY_CODE     = W_CURRENCY_CODE
         AND EC.SOB_ID            = W_SOB_ID
         AND EC.ORG_ID            = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_SEPERATE_POSITION := 3;
      V_SEPERATE_SYMBOL := ',';
      V_DECIMAL_SYMBOL := '.';
    END;
    V_INTEGER_AMOUNT := FLOOR(W_AMOUNT);
    IF V_INTEGER_AMOUNT < W_AMOUNT THEN
      V_DEGIT_AMOUNT := ABS(W_AMOUNT) - ABS(V_INTEGER_AMOUNT);
    END IF;

    BEGIN
      /*SELECT REPLACE(MAX(SYS_CONNECT_BY_PATH (CONCAT(SUBSTR(V_INTEGER_AMOUNT, LEVEL, 1), DECODE(MOD(LENGTH(V_INTEGER_AMOUNT) - LEVEL, V_SEPERATE_POSITION), 0, DECODE(LEVEL, LENGTH(V_INTEGER_AMOUNT), NULL, V_SEPERATE_SYMBOL), NULL)), 'X')), 'X') AS INTEGER_AMOUNT
        INTO V_AMOUNT
        FROM DUAL
      CONNECT BY LEVEL <= LENGTH(V_INTEGER_AMOUNT)
      ;*/
      SELECT TO_CHAR(V_INTEGER_AMOUNT, 'FM999,999,999,999,999,999,999') AS INTEGER_AMOUNT
        INTO V_AMOUNT
      FROM DUAL
      ;
    EXCEPTION WHEN OTHERS THEN
      V_AMOUNT := '0';
    END;
    IF V_DEGIT_AMOUNT > 0 THEN
      SELECT V_AMOUNT || V_DECIMAL_SYMBOL || REPLACE(TO_CHAR(V_DEGIT_AMOUNT, 'FM9.999999999'), '.') AS NEW_DIGIT_AMOUNT
        INTO V_AMOUNT
        FROM DUAL;
    END IF;
    RETURN V_AMOUNT;

  END DISPLAY_AMOUNT_F;

end EAPP_CURRENCY_G; 
/
