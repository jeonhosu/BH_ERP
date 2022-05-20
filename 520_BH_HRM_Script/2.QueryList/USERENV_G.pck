CREATE OR REPLACE PACKAGE USERENV_G
AS

-----------------------------------------------------------------------------------------
--- V$NLS_VALID_VALUES : LANGUAGE �� TERRITORY LANGUAGE �� ����Ǿ� �ִ� TABLE.
--- FUNCTION ���.
-----------------------------------------------------------------------------------------
--- FUNCTION ����� ��� ���� ���� --
  FUNCTION SET_LANGUAGE_F(P_LANG_NAME                               IN VARCHAR2) RETURN BOOLEAN;

--- FUNCTION �����  TERRITORY ��� ���� ���� --
  FUNCTION SET_TERRITORY_F(P_TERRITORY_CODE                         IN VARCHAR2) RETURN BOOLEAN;

--- FUNCTION �����  TERRITORY ��� ���� ���� --
  FUNCTION SET_DATE_FORMAT_F(P_FORMAT_STRING                        IN VARCHAR2) RETURN BOOLEAN;  
  
-----------------------------------------------------------------------------------------  
--- ����� SESSION ID ��ȸ.--
  FUNCTION GET_SESSION_ID_F RETURN NUMBER;
  
--- ����� ��� ��ȸ.--
  FUNCTION GET_LANGUAGE_F RETURN VARCHAR2;

--- ����� ��� ��� ��ȸ.--
  FUNCTION GET_LANGUAGE_S_F RETURN VARCHAR2;
  
--- ����� TERRITORY LANGUAGE ��ȸ.--
  FUNCTION GET_TERRITORY_F RETURN VARCHAR2;

--- ����� TERRITORY LANGUAGE ��� ��ȸ.--
  FUNCTION GET_TERRITORY_S_F RETURN VARCHAR2;
  
--- ����� CURRENCY ��ȸ.--
  FUNCTION GET_CURRENCY_F RETURN VARCHAR2;

--- ����� DATE FORMAT ��ȸ.--
  FUNCTION GET_DATE_FORMAT_F RETURN VARCHAR2;
         
--- ����� ���� IP ��ȸ.--
  FUNCTION GET_CONNECT_IP_F RETURN VARCHAR2;
  
  
-----------------------------------------------------------------------------------------
--- PROCEDURE ���.
-----------------------------------------------------------------------------------------
--- ����� ��� ���� ���� --
  PROCEDURE SET_LANGUAGE(P_LANG_NAME                                   IN VARCHAR2
                       , P_STATUS                                      OUT VARCHAR2);

--- �����  TERRITORY ��� ���� ���� --
  PROCEDURE SET_TERRITORY(P_TERRITORY_CODE                             IN VARCHAR2
                        , P_STATUS                                     OUT VARCHAR2);

--- �����  TERRITORY ��� ���� ���� --
  PROCEDURE SET_DATE_FORMAT(P_FORMAT_STRING                            IN VARCHAR2
                          , P_STATUS                                   OUT VARCHAR2);
                                                        
-----------------------------------------------------------------------------------------  
--- ����� SESSION ID ��ȸ.--
  PROCEDURE GET_SESSION_ID(P_SESSION_ID                                OUT NUMBER);
  
--- ����� ��� ��ȸ.--
  PROCEDURE GET_LANGUAGE(P_LANGUAGE                                    OUT VARCHAR2);

--- ����� ��� ��� ��ȸ.--
  PROCEDURE GET_LANGUAGE_S(P_LANGUAGE_S                                OUT VARCHAR2);
  
--- ����� TERRITORY LANGUAGE ��ȸ.--
  PROCEDURE GET_TERRITORY(P_TERRITORY                                  OUT VARCHAR2);

--- ����� TERRITORY LANGUAGE ��� ��ȸ.--
  PROCEDURE GET_TERRITORY_S(P_TERRITORY_S                              OUT VARCHAR2);
  
--- ����� CURRENCY ��ȸ.--
  PROCEDURE GET_CURRENCY(P_CURRENCY                                    OUT VARCHAR2);

--- ����� DATE FORMAT ��ȸ.--
  PROCEDURE GET_DATE_FORMAT(P_DATE_FORMAT                             OUT VARCHAR2);
         
--- ����� ���� IP ��ȸ.--
  PROCEDURE GET_CONNECT_IP(P_CONNECT_IP                               OUT VARCHAR2);                     

END USERENV_G;
/
CREATE OR REPLACE PACKAGE BODY USERENV_G
AS

-----------------------------------------------------------------------------------------
--- V$NLS_VALID_VALUES : LANGUAGE �� TERRITORY LANGUAGE �� ����Ǿ� �ִ� TABLE.
--- FUNCTION ���.
-----------------------------------------------------------------------------------------
--- FUNCTION ����� ��� ���� ���� --
  FUNCTION SET_LANGUAGE_F(P_LANG_NAME                               IN VARCHAR2) RETURN BOOLEAN
  AS
    V_RETURN_VALUE                                                  BOOLEAN := FALSE;
    V_LANG_CODE                                                     VARCHAR2(100);
    V_DML_STRING                                                    VARCHAR2(100);
    
  BEGIN
    -- ��� �ڵ� ����.
    BEGIN
      SELECT SX1.LANGUAGE_CODE
        INTO V_LANG_CODE
      FROM EAPP_LOOKUP_ENTRY LE
        , (SELECT LE.ENTRY_CODE LANGUAGE_CODE
              , LE.ENTRY_TAG LANGUAGE_CODE_S
          FROM EAPP_LOOKUP_ENTRY LE
          WHERE LE.LOOKUP_TYPE                                      = 'SYSTEM_LANGUAGE'
            AND LE.LOOKUP_MODULE                                    = 'EAPP'
          ) SX1      
      WHERE LE.ENTRY_TAG                                            = SX1.LANGUAGE_CODE_S
        AND LE.LOOKUP_TYPE                                          = 'APPLICATION_LANGUAGE'
        AND LE.LOOKUP_MODULE                                        = 'EAPP'
        AND LE.ENTRY_CODE                                           = P_LANG_NAME
        AND ROWNUM                                                  <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LANG_CODE := P_LANG_NAME;
    END;
  
    BEGIN
      V_DML_STRING := 'ALTER SESSION SET NLS_LANGUAGE = ' || V_LANG_CODE;
      EXECUTE IMMEDIATE  V_DML_STRING;
      
      V_RETURN_VALUE := TRUE;
    
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := FALSE;
    END;
    RETURN V_RETURN_VALUE;
    
  END SET_LANGUAGE_F;

--- FUNCTION ����� ��� ���� ���� --
  FUNCTION SET_TERRITORY_F(P_TERRITORY_CODE                         IN VARCHAR2) RETURN BOOLEAN
  AS
    V_RETURN_VALUE                                                  BOOLEAN := FALSE;
    V_TERRITORY_CODE                                                VARCHAR2(100);
    V_DML_STRING                                                    VARCHAR2(100);
    
  BEGIN
    -- ��� �ڵ� ����.
    BEGIN
      SELECT SX1.TERRITORY_CODE
        INTO V_TERRITORY_CODE
      FROM EAPP_LOOKUP_ENTRY LE
        , (SELECT LE.ENTRY_CODE TERRITORY_CODE
              , LE.ENTRY_TAG TERRITORY_CODE_S
          FROM EAPP_LOOKUP_ENTRY LE
          WHERE LE.LOOKUP_TYPE                                      = 'SYSTEM_TERRITORY'
            AND LE.LOOKUP_MODULE                                    = 'EAPP'
          ) SX1      
      WHERE LE.ENTRY_TAG                                            = SX1.TERRITORY_CODE_S
        AND LE.LOOKUP_TYPE                                          = 'APPLICATION_LANGUAGE'
        AND LE.LOOKUP_MODULE                                        = 'EAPP'
        AND LE.ENTRY_CODE                                           = P_TERRITORY_CODE
        AND ROWNUM                                                  <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY_CODE := P_TERRITORY_CODE;
    END;
    
    BEGIN
      V_DML_STRING := 'ALTER SESSION SET NLS_TERRITORY = ' || V_TERRITORY_CODE;
      EXECUTE IMMEDIATE  V_DML_STRING;
      
      V_RETURN_VALUE := TRUE;
      
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := FALSE;
    END;
    RETURN V_RETURN_VALUE;

  END SET_TERRITORY_F;

---  FUNCTION�����  TERRITORY ��� ���� ���� --
  FUNCTION SET_DATE_FORMAT_F(P_FORMAT_STRING                        IN VARCHAR2) RETURN BOOLEAN
  AS
    V_RETURN_VALUE                                                  BOOLEAN := FALSE;
    V_DML_STRING                                                    VARCHAR2(100);
    
  BEGIN
    BEGIN
      V_DML_STRING := 'ALTER SESSION SET NLS_DATE_FORMAT =  ' || P_FORMAT_STRING;
      EXECUTE IMMEDIATE  V_DML_STRING;
      
      V_RETURN_VALUE := TRUE;
      
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := FALSE;
    END;
    RETURN V_RETURN_VALUE;
   
  END SET_DATE_FORMAT_F;
  
    
-----------------------------------------------------------------------------------------  
-- ����� SESSION ID ��ȸ.
  FUNCTION GET_SESSION_ID_F RETURN NUMBER
  AS
    V_SESSION_ID                                                      NUMBER := -1;
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV','SESSIONID') SESSIONID 
        INTO V_SESSION_ID
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_SESSION_ID := -1;
    END;
    RETURN V_SESSION_ID;
    
  END GET_SESSION_ID_F;
  
-- ����� ��� ��ȸ.
  FUNCTION GET_LANGUAGE_F RETURN VARCHAR2
  AS
    V_LANGUAGE                                                        VARCHAR2(100);
    
  BEGIN
    
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS LANGUAGES
        INTO V_LANGUAGE
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_LANGUAGE := '-';
    END;
    RETURN V_LANGUAGE;
  
  END GET_LANGUAGE_F;
  
-- ����� ���  ��� ��ȸ.
  FUNCTION GET_LANGUAGE_S_F RETURN VARCHAR2
  AS
    V_LANGUAGE                                                        VARCHAR2(100);
    V_LANGUAGE_S                                                      VARCHAR2(50);
    
  BEGIN
    
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS LANGUAGES
        INTO V_LANGUAGE
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_LANGUAGE := '-';
    END;
    
    BEGIN
      SELECT LE.ENTRY_TAG SHORT_LANGUAGE_CODE 
        INTO V_LANGUAGE_S
      FROM EAPP_LOOKUP_ENTRY LE
      WHERE LE.LOOKUP_TYPE                                                  = 'SYSTEM_LANGUAGE'
        AND LE.LOOKUP_MODULE                                                = 'EAPP'
        AND LE.ENTRY_CODE                                                       = V_LANGUAGE
        AND ROWNUM                                                                <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LANGUAGE_S := '-';
    END;
    RETURN V_LANGUAGE_S;
  
  END GET_LANGUAGE_S_F;  

-- ����� TERRITORY LANGUAGE ��ȸ.
  FUNCTION GET_TERRITORY_F RETURN VARCHAR2
  AS
    V_TERRITORY                                                       VARCHAR2(100);

  BEGIN
  
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS NLS_TERRITORY
        INTO V_TERRITORY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY := '-';
    END;
    RETURN V_TERRITORY;
    
  END GET_TERRITORY_F;
  
-- ����� TERRITORY LANGUAGE ��� ��ȸ.
  FUNCTION GET_TERRITORY_S_F RETURN VARCHAR2
  AS
    V_TERRITORY                                                       VARCHAR2(100);
    V_TERRITORY_S                                                     VARCHAR2(50);
    
  BEGIN
  
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS NLS_TERRITORY
        INTO V_TERRITORY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY := '-';
    END;
    
    BEGIN
      SELECT LE.ENTRY_TAG SHORT_LANGUAGE_CODE 
        INTO V_TERRITORY_S
      FROM EAPP_LOOKUP_ENTRY LE
      WHERE LE.LOOKUP_TYPE                                                  = 'SYSTEM_TERRITORY'
        AND LE.LOOKUP_MODULE                                                = 'EAPP'
        AND LE.ENTRY_CODE                                                   = V_TERRITORY
        AND ROWNUM                                                          <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY_S := '-';
    END;
    RETURN V_TERRITORY_S;
    
  END GET_TERRITORY_S_F;  

-- ����� CURRENCY ��ȸ.
  FUNCTION GET_CURRENCY_F RETURN VARCHAR2
  AS
    V_CURRENCY                                                        VARCHAR2(20);
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_CURRENCY') AS NLS_CURRENCY
        INTO V_CURRENCY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_CURRENCY := '-';
    END;
    RETURN V_CURRENCY;
    
  END GET_CURRENCY_F;     

-- ����� DATE FORMAT ��ȸ.
  FUNCTION GET_DATE_FORMAT_F RETURN VARCHAR2
  AS
    V_DATE_FORMAT                                                     VARCHAR2(30);
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV','NLS_DATE_FORMAT') NLS_DATE_FORMAT
        INTO V_DATE_FORMAT
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_DATE_FORMAT := '-';
    END;
    RETURN V_DATE_FORMAT;
  
  END GET_DATE_FORMAT_F;  

-- ����� ���� IP ��ȸ.
  FUNCTION GET_CONNECT_IP_F RETURN VARCHAR2
  AS
    V_IP_ADDRESS                                                      VARCHAR2(50);
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV','IP_ADDRESS') NLS_IP_ADDRESS 
        INTO V_IP_ADDRESS
      FROM DUAL;
      
    EXCEPTION WHEN OTHERS THEN
      V_IP_ADDRESS := '-';
    END;
    RETURN V_IP_ADDRESS;
    
  END GET_CONNECT_IP_F;
  

-----------------------------------------------------------------------------------------
--- PROCEDURE ���.
-----------------------------------------------------------------------------------------
--- ����� ��� ���� ���� --
  PROCEDURE SET_LANGUAGE(P_LANG_NAME                                   IN VARCHAR2
                       , P_STATUS                                      OUT VARCHAR2)
  AS
    V_RETURN_VALUE                                                     VARCHAR2(200) := NULL;
    V_LANG_CODE                                                        VARCHAR2(100);
    V_DML_STRING                                                       VARCHAR2(100);
    
  BEGIN
    -- ��� �ڵ� ����.
    BEGIN
      SELECT SX1.LANGUAGE_CODE
        INTO V_LANG_CODE
      FROM EAPP_LOOKUP_ENTRY LE
        , (SELECT LE.ENTRY_CODE LANGUAGE_CODE
              , LE.ENTRY_TAG LANGUAGE_CODE_S
          FROM EAPP_LOOKUP_ENTRY LE
          WHERE LE.LOOKUP_TYPE                                         = 'SYSTEM_LANGUAGE'
            AND LE.LOOKUP_MODULE                                       = 'EAPP'
          ) SX1      
      WHERE LE.ENTRY_TAG                                               = SX1.LANGUAGE_CODE_S
        AND LE.LOOKUP_TYPE                                             = 'APPLICATION_LANGUAGE'
        AND LE.LOOKUP_MODULE                                           = 'EAPP'
        AND LE.ENTRY_CODE                                              = P_LANG_NAME
        AND ROWNUM                                                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LANG_CODE := P_LANG_NAME;
    END;
  
    BEGIN
      V_DML_STRING := 'ALTER SESSION SET NLS_LANGUAGE = ' || V_LANG_CODE;
      EXECUTE IMMEDIATE  V_DML_STRING;
      
      V_RETURN_VALUE := NULL;
    
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'SET NLS_LANGUAGE ERROR : ' || TO_CHAR(SQLCODE) || '.' || SUBSTR(SQLERRM, 1, 150);
    END;
    P_STATUS := V_RETURN_VALUE;
    
  END SET_LANGUAGE;

--- ����� ��� ���� ���� --
  PROCEDURE SET_TERRITORY(P_TERRITORY_CODE                             IN VARCHAR2
                        , P_STATUS                                     OUT VARCHAR2)
  AS
    V_RETURN_VALUE                                                     VARCHAR2(200) := NULL;
    V_TERRITORY_CODE                                                   VARCHAR2(100);
    V_DML_STRING                                                       VARCHAR2(100);
    
  BEGIN
    -- ��� �ڵ� ����.
    BEGIN
      SELECT SX1.TERRITORY_CODE
        INTO V_TERRITORY_CODE
      FROM EAPP_LOOKUP_ENTRY LE
        , (SELECT LE.ENTRY_CODE TERRITORY_CODE
              , LE.ENTRY_TAG TERRITORY_CODE_S
          FROM EAPP_LOOKUP_ENTRY LE
          WHERE LE.LOOKUP_TYPE                                         = 'SYSTEM_TERRITORY'
            AND LE.LOOKUP_MODULE                                       = 'EAPP'
          ) SX1      
      WHERE LE.ENTRY_TAG                                               = SX1.TERRITORY_CODE_S
        AND LE.LOOKUP_TYPE                                             = 'APPLICATION_LANGUAGE'
        AND LE.LOOKUP_MODULE                                           = 'EAPP'
        AND LE.ENTRY_CODE                                              = P_TERRITORY_CODE
        AND ROWNUM                                                     <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY_CODE := P_TERRITORY_CODE;
    END;
    
    BEGIN
      V_DML_STRING := 'ALTER SESSION SET NLS_TERRITORY = ' || V_TERRITORY_CODE;
      EXECUTE IMMEDIATE  V_DML_STRING;
      
      V_RETURN_VALUE := NULL;
      
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'SET NLS_TERRITORY ERROR : ' || TO_CHAR(SQLCODE) || '.' || SUBSTR(SQLERRM, 1, 150);
    END;
    P_STATUS := V_RETURN_VALUE;

  END SET_TERRITORY;

--- �����  TERRITORY ��� ���� ���� --
  PROCEDURE SET_DATE_FORMAT(P_FORMAT_STRING                            IN VARCHAR2
                          , P_STATUS                                   OUT VARCHAR2)
  AS
    V_RETURN_VALUE                                                     VARCHAR2(200) := NULL;
    V_DML_STRING                                                       VARCHAR2(100);
    
  BEGIN
    BEGIN
      V_DML_STRING := 'ALTER SESSION SET NLS_DATE_FORMAT =  ' || P_FORMAT_STRING;
      EXECUTE IMMEDIATE  V_DML_STRING;
      
      V_RETURN_VALUE := NULL;
      
    EXCEPTION WHEN OTHERS THEN
      V_RETURN_VALUE := 'SET NLS_DATE_FORMAT ERROR : ' || TO_CHAR(SQLCODE) || '.' || SUBSTR(SQLERRM, 1, 150);
    END;
    P_STATUS := V_RETURN_VALUE;
   
  END SET_DATE_FORMAT;


-----------------------------------------------------------------------------------------  
--- ����� SESSION ID ��ȸ.--
  PROCEDURE GET_SESSION_ID(P_SESSION_ID                                OUT NUMBER)
  AS
    V_SESSION_ID                                                       NUMBER := -1;
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV','SESSIONID') SESSIONID 
        INTO V_SESSION_ID
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_SESSION_ID := -1;
    END;
    P_SESSION_ID := V_SESSION_ID;  
  
  END GET_SESSION_ID;
  
--- ����� ��� ��ȸ.--
  PROCEDURE GET_LANGUAGE(P_LANGUAGE                                    OUT VARCHAR2)
  AS
   V_LANGUAGE                                                          VARCHAR2(100);
    
  BEGIN
    
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS LANGUAGES
        INTO V_LANGUAGE
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_LANGUAGE := '-';
    END;
    P_LANGUAGE := V_LANGUAGE;
  
  END GET_LANGUAGE;

--- ����� ��� ��� ��ȸ.--
  PROCEDURE GET_LANGUAGE_S(P_LANGUAGE_S                                OUT VARCHAR2)
  AS
   V_LANGUAGE                                                          VARCHAR2(100);
    V_LANGUAGE_S                                                       VARCHAR2(50);
    
  BEGIN
    
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS LANGUAGES
        INTO V_LANGUAGE
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_LANGUAGE := '-';
    END;
    
    BEGIN
      SELECT LE.ENTRY_TAG SHORT_LANGUAGE_CODE 
        INTO V_LANGUAGE_S
      FROM EAPP_LOOKUP_ENTRY LE
      WHERE LE.LOOKUP_TYPE                                                  = 'SYSTEM_LANGUAGE'
        AND LE.LOOKUP_MODULE                                                = 'EAPP'
        AND LE.ENTRY_CODE                                                   = V_LANGUAGE
        AND ROWNUM                                                          <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_LANGUAGE_S := '-';
    END;
    P_LANGUAGE_S := V_LANGUAGE_S;
  
  END GET_LANGUAGE_S;
  
--- ����� TERRITORY LANGUAGE ��ȸ.--
  PROCEDURE GET_TERRITORY(P_TERRITORY                                  OUT VARCHAR2)
  AS
   V_TERRITORY                                                         VARCHAR2(100);

  BEGIN
  
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS NLS_TERRITORY
        INTO V_TERRITORY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY := '-';
    END;
    P_TERRITORY := V_TERRITORY;
  
  END GET_TERRITORY;  

--- ����� TERRITORY LANGUAGE ��� ��ȸ.--
  PROCEDURE GET_TERRITORY_S(P_TERRITORY_S                              OUT VARCHAR2)
  AS
    V_TERRITORY                                                        VARCHAR2(100);
    V_TERRITORY_S                                                      VARCHAR2(50);
    
  BEGIN
  
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_TERRITORY') AS NLS_TERRITORY
        INTO V_TERRITORY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY := '-';
    END;
    
    BEGIN
      SELECT LE.ENTRY_TAG SHORT_LANGUAGE_CODE 
        INTO V_TERRITORY_S
      FROM EAPP_LOOKUP_ENTRY LE
      WHERE LE.LOOKUP_TYPE                                                  = 'SYSTEM_TERRITORY'
        AND LE.LOOKUP_MODULE                                                = 'EAPP'
        AND LE.ENTRY_CODE                                                   = V_TERRITORY
        AND ROWNUM                                                           <= 1
      ;
    EXCEPTION WHEN OTHERS THEN
      V_TERRITORY_S := '-';
    END;
    P_TERRITORY_S := V_TERRITORY_S;
  
  
  END GET_TERRITORY_S;
  
--- ����� CURRENCY ��ȸ.--
  PROCEDURE GET_CURRENCY(P_CURRENCY                                    OUT VARCHAR2)
  AS
    V_CURRENCY                                                         VARCHAR2(20);
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV', 'NLS_CURRENCY') AS NLS_CURRENCY
        INTO V_CURRENCY
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_CURRENCY := '-';
    END;
    P_CURRENCY := V_CURRENCY;
  
  
  END GET_CURRENCY;

--- ����� DATE FORMAT ��ȸ.--
  PROCEDURE GET_DATE_FORMAT(P_DATE_FORMAT                             OUT VARCHAR2)
  AS
    V_DATE_FORMAT                                                     VARCHAR2(30);
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV','NLS_DATE_FORMAT') NLS_DATE_FORMAT
        INTO V_DATE_FORMAT
      FROM DUAL;
    EXCEPTION WHEN OTHERS THEN
      V_DATE_FORMAT := '-';
    END;
    P_DATE_FORMAT := V_DATE_FORMAT;
  
  END GET_DATE_FORMAT;
         
--- ����� ���� IP ��ȸ.--
  PROCEDURE GET_CONNECT_IP(P_CONNECT_IP                               OUT VARCHAR2)
  AS
   V_IP_ADDRESS                                                       VARCHAR2(50);
    
  BEGIN
    BEGIN
      SELECT SYS_CONTEXT('USERENV','IP_ADDRESS') NLS_IP_ADDRESS 
        INTO V_IP_ADDRESS
      FROM DUAL;
      
    EXCEPTION WHEN OTHERS THEN
      V_IP_ADDRESS := '-';
    END;
    P_CONNECT_IP := V_IP_ADDRESS;
  
  END GET_CONNECT_IP;
    
END USERENV_G;
/
