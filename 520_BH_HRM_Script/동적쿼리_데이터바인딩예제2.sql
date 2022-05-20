DECLARE 
  V_STRING      VARCHAR2(2000);
  
  W_GROUP_CODE  VARCHAR2(100) := 'DEVICE';
  W_SOB_ID      NUMBER := 10;
  W_ORG_ID      NUMBER := 101;
  W_WHERE       VARCHAR2(200);
  W_ENABLED_FLAG_YN VARCHAR2(1) := 'Y';
  V_STD_DATE    VARCHAR2(10) := TO_CHAR(SYSDATE, 'YYYY-MM-DD');
  
  V_CODE_NAME   VARCHAR2(150);
  V_CODE        VARCHAR2(150);
  V_COMMON_ID   NUMBER;
  
BEGIN
  W_WHERE := ' HC.VALUE3 = ''FOOD''';
--  W_WHERE := ' 1= 1';
--  DBMS_OUTPUT.PUT_LINE(W_WHERE);
  
  V_STRING := 'INSERT INTO HRM_COMMON_GT
                 ( CODE_NAME
                  , CODE
                  , COMMON_ID
                  , VALUE1
                  , VALUE2
                  , VALUE3
                  , VALUE4
                  , VALUE5
                  , VALUE6
                  , VALUE7
                  , VALUE8
                  , VALUE9
                  , VALUE10
                  )
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
                  WHERE HC.GROUP_CODE            = ''' || W_GROUP_CODE  || '''
                    AND HC.SOB_ID                = ' || W_SOB_ID || '
                    AND HC.ORG_ID                = ' || W_ORG_ID || '

                    AND HC.ENABLED_FLAG       = DECODE(''' || W_ENABLED_FLAG_YN || ''', ''Y'', ''Y'', HC.ENABLED_FLAG)
                    AND HC.EFFECTIVE_DATE_FR  <= NVL(TO_DATE(''' || V_STD_DATE || ''', ''YYYY-MM-DD''), HC.EFFECTIVE_DATE_FR)
                    AND (HC.EFFECTIVE_DATE_TO IS NULL OR HC.EFFECTIVE_DATE_TO >= NVL(TO_DATE(''' || V_STD_DATE || ''', ''YYYY-MM-DD''), HC.EFFECTIVE_DATE_TO))
                  ORDER BY HC.SORT_NUM, HC.CODE ';
    DBMS_OUTPUT.PUT_LINE(V_STRING);
--                    AND ' || W_WHERE  || '
    EXECUTE IMMEDIATE V_STRING;
    
    FOR C1 IN (SELECT *
               FROM HRM_COMMON_GT X
               )
    LOOP 
      DBMS_OUTPUT.PUT_LINE(C1.CODE_NAME || ', ' || C1.CODE);
    
    END LOOP C1;
        
    /*
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
  */
--  USING W_GROUP_CODE, W_SOB_ID, W_ORG_ID, W_WHERE;
  
/*  EXECUTE IMMEDIATE V_STRING   
  INTO V_CODE_NAME, V_CODE, V_COMMON_ID
  USING W_GROUP_CODE, W_SOB_ID, W_ORG_ID, W_WHERE;  */
--  RETURN V_CODE_NAME, V_CODE, V_COMMON_ID;
  
--  DBMS_OUTPUT.PUT_LINE(V_CODE_NAME);
  
END;
      
