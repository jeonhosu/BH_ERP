CREATE OR REPLACE PACKAGE EAPP_NUM_DIGIT_CHECKER_G
AS
-----------------------------------------------------------------------------------------
-- FUNCTION--
-----------------------------------------------------------------------------------------
-- 주민번호 체크.
  FUNCTION CHECK_REPRE_NUM_F(P_REPRE_NUM                               IN VARCHAR2) RETURN VARCHAR2;

-- 법인번호 체크.
  FUNCTION CHECK_LEGAL_NUM_F(P_LEGAL_NUM                               IN VARCHAR2) RETURN VARCHAR2;

-- 사업자번호 체크.
  FUNCTION CHECK_TAX_NUM_F(P_TAX_NUM                                   IN VARCHAR2) RETURN VARCHAR2;


-----------------------------------------------------------------------------------------
-- PROCEDURE --
-----------------------------------------------------------------------------------------
-- 주민번호 체크.
  PROCEDURE CHECK_REPRE_NUM(P_REPRE_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2
													, O_SEX_TYPE                                 OUT VARCHAR2);

-- 법인번호 체크.
  PROCEDURE CHECK_LEGAL_NUM(P_LEGAL_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2);

-- 사업자번호 체크.
  PROCEDURE CHECK_TAX_NUM(P_TAX_NUM                                    IN VARCHAR2
                        , O_RETURN_VALUE                               OUT VARCHAR2);
      
END EAPP_NUM_DIGIT_CHECKER_G;
/
CREATE OR REPLACE PACKAGE BODY EAPP_NUM_DIGIT_CHECKER_G
AS
-----------------------------------------------------------------------------------------
-- FUNCTION--
-----------------------------------------------------------------------------------------
-- 주민번호 체크.--
  FUNCTION CHECK_REPRE_NUM_F(P_REPRE_NUM                               IN VARCHAR2) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                            VARCHAR2(2) := 'N';
    V_REPRE_NUM                                               VARCHAR2(20);   -- 주민번호 변형값  
    
    V_CHECK_NUM                                               NUMBER;   -- 체크 값  
  
    V_SEX                                                     VARCHAR2(2);   -- 성별  
    V_SUM                                                     NUMBER;   -- 주민번호 체크 합계 

  BEGIN

      --> 변수 초기화  
      V_CHECK_NUM := 2;
      V_RETURN_VALUE := 'N';
        
      V_SEX := 0;
      V_SUM := 0;   

      --> '-' 제외   
      V_REPRE_NUM := REPLACE(P_REPRE_NUM, '-', '');
      
      --> 주민번호 길이 체크 ;
      IF P_REPRE_NUM IS NULL OR LENGTH(V_REPRE_NUM) <> 13 THEN
        RETURN V_RETURN_VALUE;
      END IF;
      
      --> 성별  
      SELECT SUBSTR(V_REPRE_NUM, 7, 1) AS V_SEX
        INTO V_SEX
      FROM DUAL;
      
    -- 주민번호 체크비트 검사 수식 ---------------------------------     
      FOR C1 IN 1 .. LENGTHB(V_REPRE_NUM) - 1
      LOOP
        V_SUM := V_SUM + SUBSTR(V_REPRE_NUM, C1, 1) * V_CHECK_NUM;
        V_CHECK_NUM := V_CHECK_NUM + 1;
        
        IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 2;
        END IF;
         
      END LOOP;
      V_SUM := 11 - (V_SUM MOD 11);
      
    -- 성별에 따른 내,외국인 체크  ---------------------------------     
      IF V_SEX BETWEEN '5' AND '8' THEN
      --> 외국인  
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;
        V_SUM := V_SUM + 2;
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;    
        
      ELSE
      --> 내국인  
        V_SUM := V_SUM MOD 10;
            
      END IF;  
      
      IF V_SUM = SUBSTR(V_REPRE_NUM, 13, 1) THEN
        V_RETURN_VALUE := 'Y';  
      END IF;
      
      RETURN V_RETURN_VALUE;

  END CHECK_REPRE_NUM_F;
  
-- 법인번호 체크.--
  FUNCTION CHECK_LEGAL_NUM_F(P_LEGAL_NUM                               IN VARCHAR2) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                    VARCHAR2(1) := 'N';
    V_LEGAL_NUM                                       VARCHAR2(14);         -- := '110111-0062432';
    V_ADD_NUM                                         NUMBER;
    
    V_CHECK_DIGIT                                     NUMBER;
    V_CHECK_SUM                                       NUMBER;
    V_CHECK_NUM                                       NUMBER;
    
  BEGIN
    V_LEGAL_NUM := REPLACE(P_LEGAL_NUM, '-', '');
    IF V_LEGAL_NUM IS NULL OR LENGTHB(V_LEGAL_NUM) <> 13 THEN
      RETURN V_RETURN_VALUE;
    END IF;
    
    -- DIGIT 숫자 분리.  
    V_CHECK_DIGIT := SUBSTR(V_LEGAL_NUM, LENGTHB(V_LEGAL_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('변경 법인 번호 : ' || V_LEGAL_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
        
    -- 초기화.
    V_CHECK_SUM := 0;
    V_ADD_NUM := 1;
    -- 처리.
    FOR C1 IN 1 .. LENGTHB(V_LEGAL_NUM) - 1
    LOOP
      V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_LEGAL_NUM, C1, 1) * V_ADD_NUM);
--DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_LEGAL_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
              
      IF V_ADD_NUM MOD 2 = 0 THEN
        V_ADD_NUM :=1;
      ELSE
        V_ADD_NUM := V_ADD_NUM + 1;
      END IF;
    END LOOP C1;
        
    -- ? / 10 몫을 취함.
    V_CHECK_NUM := V_CHECK_SUM MOD 10;
--DBMS_OUTPUT.PUT_LINE('[ 몫 ] ==>' || V_CHECK_NUM);    

    -- 10 - 몫(음수일 경우 절대값 적용).
    V_CHECK_NUM := 10 - V_CHECK_NUM;   
    IF V_CHECK_NUM = 10 THEN
        V_CHECK_NUM := 0;
    ELSIF V_CHECK_NUM < 0 THEN
        V_CHECK_NUM := ABS(V_CHECK_NUM);
    END IF;
--DBMS_OUTPUT.PUT_LINE('[ 10-몫 ] ==>' || V_CHECK_NUM); 
        
    -- 체크비트 검증.
    IF V_CHECK_NUM = V_CHECK_DIGIT THEN
        V_RETURN_VALUE := 'Y';
    ELSE
        V_RETURN_VALUE := 'N';
    END IF;
    
    RETURN V_RETURN_VALUE;
    
  END CHECK_LEGAL_NUM_F;

-- 사업자번호 체크.--
  FUNCTION CHECK_TAX_NUM_F(P_TAX_NUM                                   IN VARCHAR2) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                               VARCHAR2(1) := 'N';
    V_TAX_NUM                                    VARCHAR2(12);        -- := '123-45-67890';
    V_CHECK_VALUE                                VARCHAR2(9) := '137137135';
    
    V_CHECK_DIGIT                                NUMBER;
    V_CHECK_SUM                                  NUMBER;
    V_CHECK_NUM                                  NUMBER;
    
  BEGIN
    V_TAX_NUM := REPLACE(P_TAX_NUM, '-', '');
    IF LENGTH(V_TAX_NUM) = 13 THEN           
    -- 개인사업자(주민번호)0
      V_RETURN_VALUE := EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(V_TAX_NUM);
              
    ELSIF LENGTH(V_TAX_NUM) = 10 THEN
    -- 법인 사업자(사업자 번호).  
      -- DIGIT 숫자 분리.  
      V_CHECK_DIGIT := SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('변경 법인 번호 : ' || V_TAX_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
      
      -- 초기화.
      V_CHECK_SUM := 0;
      -- 1. 처리.
      FOR C1 IN 1 .. LENGTHB(V_TAX_NUM) - 1
      LOOP
        V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_TAX_NUM, C1, 1) * SUBSTR(V_CHECK_VALUE, C1, 1));
--DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_TAX_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
       
      END LOOP C1;

--DBMS_OUTPUT.PUT_LINE('V_CHECK_SUM==> ' || V_CHECK_SUM || ', 9번재 나머지 ==>' || SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1));
--DBMS_OUTPUT.PUT_LINE('9번재 몫==>' || TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10) || ', 9번재 나머지 ==>' || ((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) MOD 10));
      -- 2. 처리( 1.처리 + (9번째 숫자 MOD 10).
      V_CHECK_SUM := V_CHECK_SUM + TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10);
      
--DBMS_OUTPUT.PUT_LINE('[ V_TAX_NUM ] ==>' || V_TAX_NUM || ', V_CHECK_SUM==> ' || V_CHECK_SUM);    
      
      -- ? / 10 몫을 취함.
      V_CHECK_NUM := V_CHECK_SUM MOD 10;
--DBMS_OUTPUT.PUT_LINE('[ 몫 ] ==>' || V_CHECK_NUM);   

      -- 10 - 몫(음수일 경우 절대값 적용).
      V_CHECK_NUM := 10 - V_CHECK_NUM;
      IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 0;
      ELSIF V_CHECK_NUM < 0 THEN
          V_CHECK_NUM := ABS(V_CHECK_NUM);
      END IF;
--DBMS_OUTPUT.PUT_LINE('[ 10-몫 ] ==>' || V_CHECK_NUM); 
      
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
    RETURN V_RETURN_VALUE;
    
  END CHECK_TAX_NUM_F;


-----------------------------------------------------------------------------------------
-- PROCEDURE --
-----------------------------------------------------------------------------------------
-- 주민번호 체크.--
  PROCEDURE CHECK_REPRE_NUM(P_REPRE_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2
													, O_SEX_TYPE                                  OUT VARCHAR2)
  AS
    V_RETURN_VALUE                               VARCHAR2(2) := 'N';
    V_REPRE_NUM                                  VARCHAR2(20);   -- 주민번호 변형값  
    
    V_CHECK_NUM                                  NUMBER;   -- 체크 값  
  
    V_SEX                                        VARCHAR2(2);   -- 성별  
    V_SUM                                        NUMBER;   -- 주민번호 체크 합계 
  
  BEGIN

      --> 변수 초기화  
      V_CHECK_NUM := 2;
      V_RETURN_VALUE := 'N';
        
      V_SEX := 0;
      V_SUM := 0;   

      --> '-' 제외   
      V_REPRE_NUM := REPLACE(P_REPRE_NUM, '-', '');
      
      --> 주민번호 길이 체크 ;
      IF P_REPRE_NUM IS NULL OR LENGTH(V_REPRE_NUM) <> 13 THEN
        O_RETURN_VALUE := V_RETURN_VALUE;
        RETURN;
      END IF;
      
      --> 성별  
      SELECT SUBSTR(V_REPRE_NUM, 7, 1) AS V_SEX
        INTO V_SEX
      FROM DUAL;
      
    -- 주민번호 체크비트 검사 수식 ---------------------------------     
      FOR C1 IN 1 .. LENGTHB(V_REPRE_NUM) - 1
      LOOP
        V_SUM := V_SUM + SUBSTR(V_REPRE_NUM, C1, 1) * V_CHECK_NUM;
        V_CHECK_NUM := V_CHECK_NUM + 1;
        
        IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 2;
        END IF;
         
      END LOOP;
      V_SUM := 11 - (V_SUM MOD 11);
      
    -- 성별에 따른 내,외국인 체크  ---------------------------------     
      IF V_SEX BETWEEN '5' AND '8' THEN
      --> 외국인  
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;
        V_SUM := V_SUM + 2;
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;    
        
      ELSE
      --> 내국인  
        V_SUM := V_SUM MOD 10;
            
      END IF;  
      
      IF V_SUM = SUBSTR(V_REPRE_NUM, 13, 1) THEN
        V_RETURN_VALUE := 'Y';  
      END IF;
			
			IF MOD(V_SEX, 2) = 0 THEN
			-- 여자.
			  O_SEX_TYPE := '2';
			ELSE
			-- 남자.
			  O_SEX_TYPE := '1';
			END IF;
      O_RETURN_VALUE := V_RETURN_VALUE;
  
  END CHECK_REPRE_NUM;

-- 법인번호 체크.--
  PROCEDURE CHECK_LEGAL_NUM(P_LEGAL_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2)
  AS
    V_RETURN_VALUE                               VARCHAR2(1) := 'N';
    V_LEGAL_NUM                                  VARCHAR2(14);         -- := '110111-0062432';
    V_ADD_NUM                                    NUMBER;
    
    V_CHECK_DIGIT                                NUMBER;
    V_CHECK_SUM                                  NUMBER;
    V_CHECK_NUM                                  NUMBER;
    
  BEGIN
    V_LEGAL_NUM := REPLACE(P_LEGAL_NUM, '-', '');
    IF V_LEGAL_NUM IS NULL OR LENGTHB(V_LEGAL_NUM) <> 13 THEN
      O_RETURN_VALUE := V_RETURN_VALUE;
      RETURN;
    END IF;
    
    -- DIGIT 숫자 분리.  
    V_CHECK_DIGIT := SUBSTR(V_LEGAL_NUM, LENGTHB(V_LEGAL_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('변경 법인 번호 : ' || V_LEGAL_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
        
    -- 초기화.
    V_CHECK_SUM := 0;
    V_ADD_NUM := 1;
    -- 처리.
    FOR C1 IN 1 .. LENGTHB(V_LEGAL_NUM) - 1
    LOOP
      V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_LEGAL_NUM, C1, 1) * V_ADD_NUM);
--DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_LEGAL_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
              
      IF V_ADD_NUM MOD 2 = 0 THEN
        V_ADD_NUM :=1;
      ELSE
        V_ADD_NUM := V_ADD_NUM + 1;
      END IF;
    END LOOP C1;
        
    -- ? / 10 몫을 취함.
    V_CHECK_NUM := V_CHECK_SUM MOD 10;

--DBMS_OUTPUT.PUT_LINE('[ 몫 ] ==>' || V_CHECK_NUM);    

    -- 10 - 몫(음수일 경우 절대값 적용).
    V_CHECK_NUM := 10 - V_CHECK_NUM;   
    IF V_CHECK_NUM = 10 THEN
        V_CHECK_NUM := 0;
    ELSIF V_CHECK_NUM < 0 THEN
        V_CHECK_NUM := ABS(V_CHECK_NUM);
    END IF;
    
--DBMS_OUTPUT.PUT_LINE('[ 10-몫 ] ==>' || V_CHECK_NUM); 
        
    -- 체크비트 검증.
    IF V_CHECK_NUM = V_CHECK_DIGIT THEN
        V_RETURN_VALUE := 'Y';
    ELSE
        V_RETURN_VALUE := 'N';
    END IF;
    O_RETURN_VALUE := V_RETURN_VALUE;
  
  END CHECK_LEGAL_NUM;

-- 사업자번호 체크.--
  PROCEDURE CHECK_TAX_NUM(P_TAX_NUM                                    IN VARCHAR2
                        , O_RETURN_VALUE                               OUT VARCHAR2)
  AS
    V_RETURN_VALUE                               VARCHAR2(1) := 'N';
    V_TAX_NUM                                    VARCHAR2(12);        -- := '123-45-67890';
    V_CHECK_VALUE                                VARCHAR2(9) := '137137135';
    
    V_CHECK_DIGIT                                NUMBER;
    V_CHECK_SUM                                  NUMBER;
    V_CHECK_NUM                                  NUMBER;
    
  BEGIN
    V_TAX_NUM := REPLACE(P_TAX_NUM, '-', '');
    IF LENGTH(V_TAX_NUM) = 13 THEN           
    -- 개인사업자(주민번호)0
      V_RETURN_VALUE := EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(V_TAX_NUM);
              
    ELSIF LENGTH(V_TAX_NUM) = 10 THEN
    -- 법인 사업자(사업자 번호).  
      
      -- DIGIT 숫자 분리.  
      V_CHECK_DIGIT := SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('변경 법인 번호 : ' || V_TAX_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
      
      -- 초기화.
      V_CHECK_SUM := 0;
      -- 1. 처리.
      FOR C1 IN 1 .. LENGTHB(V_TAX_NUM) - 1
      LOOP
        V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_TAX_NUM, C1, 1) * SUBSTR(V_CHECK_VALUE, C1, 1));

--DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_TAX_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
       
      END LOOP C1;

--DBMS_OUTPUT.PUT_LINE('V_CHECK_SUM==> ' || V_CHECK_SUM || ', 9번재 나머지 ==>' || SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1));
--DBMS_OUTPUT.PUT_LINE('9번재 몫==>' || TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10) || ', 9번재 나머지 ==>' || ((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) MOD 10));
      -- 2. 처리( 1.처리 + (9번째 숫자 MOD 10).
      V_CHECK_SUM := V_CHECK_SUM + TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10);
      
--DBMS_OUTPUT.PUT_LINE('[ V_TAX_NUM ] ==>' || V_TAX_NUM || ', V_CHECK_SUM==> ' || V_CHECK_SUM);    
      
      -- ? / 10 몫을 취함.
      V_CHECK_NUM := V_CHECK_SUM MOD 10;
--DBMS_OUTPUT.PUT_LINE('[ 몫 ] ==>' || V_CHECK_NUM);   

      -- 10 - 몫(음수일 경우 절대값 적용).
      V_CHECK_NUM := 10 - V_CHECK_NUM;
      IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 0;
      ELSIF V_CHECK_NUM < 0 THEN
          V_CHECK_NUM := ABS(V_CHECK_NUM);
      END IF;
--DBMS_OUTPUT.PUT_LINE('[ 10-몫 ] ==>' || V_CHECK_NUM); 
      
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
    O_RETURN_VALUE := V_RETURN_VALUE;
    
  END CHECK_TAX_NUM;
                                                    
END EAPP_NUM_DIGIT_CHECKER_G;
/
