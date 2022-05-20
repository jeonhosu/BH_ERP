DECLARE 
  
  V_RETURN_VALUE                    VARCHAR2(1) := 'N';
  V_TAX_NUM                             VARCHAR2(20) := '134-81-21874';
  V_CHECK_VALUE                       VARCHAR2(9) := '137137135';
  
  V_CHECK_DIGIT                         NUMBER;
  V_CHECK_SUM                         NUMBER;
  V_CHECK_NUM                         NUMBER;
  
BEGIN

    V_TAX_NUM := REPLACE(V_TAX_NUM, '-', '');
    IF LENGTH(V_TAX_NUM) = 13 THEN           
    -- 개인사업자(주민번호)0
      V_RETURN_VALUE := EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM(V_TAX_NUM);
              
    ELSIF LENGTHB(V_TAX_NUM) = 10 THEN
    -- 법인 사업자(사업자 번호).  
      
      -- DIGIT 숫자 분리.  
      V_CHECK_DIGIT := SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM), 1);
DBMS_OUTPUT.PUT_LINE('변경 법인 번호 : ' || V_TAX_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
      
      -- 초기화.
      V_CHECK_SUM := 0;
      V_CHECK_NUM := 0;
      -- 1. 처리.
      FOR C1 IN 1 .. LENGTHB(V_TAX_NUM) - 1
      LOOP
        V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_TAX_NUM, C1, 1) * SUBSTR(V_CHECK_VALUE, C1, 1));

DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_TAX_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
       
      END LOOP C1;

DBMS_OUTPUT.PUT_LINE('V_CHECK_SUM==> ' || V_CHECK_SUM || ', 9번재 나머지 ==>' || SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1));
DBMS_OUTPUT.PUT_LINE('9번재 몫==>' || TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10) || ', 9번재 나머지 ==>' || ((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) MOD 10));
      -- 2. 처리( 1.처리 + (9번째 숫자 MOD 10).
      V_CHECK_SUM := V_CHECK_SUM + TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10);
      
DBMS_OUTPUT.PUT_LINE('[ V_TAX_NUM ] ==>' || V_TAX_NUM || ', V_CHECK_SUM==> ' || V_CHECK_SUM);    
      
      -- 핪 / 10 몫을 취함.
      V_CHECK_NUM := V_CHECK_SUM MOD 10;
DBMS_OUTPUT.PUT_LINE('[ 몫 ] ==>' || V_CHECK_NUM);   

      -- 10 - 몫(음수일 경우 절대값 적용).
      V_CHECK_NUM := 10 - V_CHECK_NUM;
      IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 0;
      ELSIF V_CHECK_NUM < 0 THEN
          V_CHECK_NUM := ABS(V_CHECK_NUM);
      END IF;
DBMS_OUTPUT.PUT_LINE('[ 10-몫 ] ==>' || V_CHECK_NUM); 
      
      -- 체크비트 검증.
      IF V_CHECK_NUM = V_CHECK_DIGIT THEN
          V_RETURN_VALUE := 'Y';
      ELSE
          V_RETURN_VALUE := 'N';
      END IF;
      
    ELSE
    -- 그외.
      V_RETURN_VALUE := 'N';
    
    END IF;
    
DBMS_OUTPUT.PUT_LINE('[ V_RETURN_VALUE ] ==>' || V_RETURN_VALUE); 
    
END;
