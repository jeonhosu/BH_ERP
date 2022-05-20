DECLARE 
  V_STRING      VARCHAR2(2000);
  
  W_GROUP_CODE  VARCHAR2(100) := 'CLOSING_TYPE';
  W_SOB_ID      NUMBER := 10;
  W_ORG_ID      NUMBER := 101;
  W_WHERE       VARCHAR2(200);
  
  V_CODE_NAME   VARCHAR2(150);
  V_CODE        VARCHAR2(150);
  V_COMMON_ID   NUMBER;
  
BEGIN
  W_WHERE := ' HC.VALUE1 = ''MONTH''';
--  W_WHERE := ' 1= 1';
  DBMS_OUTPUT.PUT_LINE(W_WHERE);
    
  V_STRING := 'SELECT HC.CODE_NAME, HC.CODE, HC.COMMON_ID 
                 FROM HRM_COMMON HC 
                WHERE HC.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                  AND HC.SOB_ID                = ' || W_SOB_ID || '
                  AND HC.ORG_ID                = ' || W_ORG_ID || '
                  AND ' || W_WHERE  || '
                  AND HC.DEFAULT_FLAG          =  ''Y''
                  AND ROWNUM                   <= 1
                  AND HC.ENABLED_FLAG          = ''Y''
                  AND HC.EFFECTIVE_DATE_FR     <= GET_LOCAL_DATE(HC.SOB_ID)
                  AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO  >= GET_LOCAL_DATE(HC.SOB_ID)) ';

  DBMS_OUTPUT.PUT_LINE(V_STRING);
  
  EXECUTE IMMEDIATE V_STRING   
  INTO V_CODE_NAME, V_CODE, V_COMMON_ID;
  
--  USING W_GROUP_CODE, W_SOB_ID, W_ORG_ID, W_WHERE;
  
/*  EXECUTE IMMEDIATE V_STRING   
  INTO V_CODE_NAME, V_CODE, V_COMMON_ID
  USING W_GROUP_CODE, W_SOB_ID, W_ORG_ID, W_WHERE;  */
--  RETURN V_CODE_NAME, V_CODE, V_COMMON_ID;
  
  DBMS_OUTPUT.PUT_LINE(V_CODE_NAME);
  
END;
      
