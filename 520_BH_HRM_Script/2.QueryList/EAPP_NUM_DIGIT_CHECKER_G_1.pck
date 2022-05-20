CREATE OR REPLACE PACKAGE EAPP_NUM_DIGIT_CHECKER_G
AS

-- 주민번호 체크.
  FUNCTION CHECK_REPRE_NUM(P_REPRE_NUM                                    IN VARCHAR2) RETURN VARCHAR2;

END EAPP_NUM_DIGIT_CHECKER_G;
/
CREATE OR REPLACE PACKAGE BODY EAPP_NUM_DIGIT_CHECKER_G
AS

-- 주민번호 체크.
  FUNCTION CHECK_REPRE_NUM(P_REPRE_NUM                                    IN VARCHAR2) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                            VARCHAR2(2) := 'N';

    V_CHECK_NUM                                                 NUMBER;   -- 체크 값  
  
    V_COUNT                                                          NUMBER;   -- 
    V_SEX                                                               VARCHAR2(2);   -- 성별  
    V_SUM                                                             NUMBER;   -- 주민번호 체크 합계 
    
    V_REPRE_NUM                                                  VARCHAR2(20);   -- 주민번호 변형값  
    V_RETURN_FLAG                                               VARCHAR2(2);   -- 주민번호 체크 결과  
  
  BEGIN

      --> 변수 초기화  
      V_CHECK_NUM := 2;
      V_RETURN_FLAG := 'N';
        
      V_COUNT := 0;
      V_SEX := 0;
      V_SUM := 0;   

      --> '-' 제외   
      SELECT REPLACE(P_REPRE_NUM, '-', '') AS N_REPRE_NUM
        INTO V_REPRE_NUM
      FROM DUAL;
      
      --> 주민번호 길이 체크 ;
      IF P_REPRE_NUM IS NULL OR LENGTH(V_REPRE_NUM) <> 13 THEN
        RETURN V_RETURN_FLAG;
      END IF;
      
      --> 성별  
      SELECT SUBSTR(V_REPRE_NUM, 7, 1) AS V_SEX
        INTO V_SEX
      FROM DUAL;
      
    -- 주민번호 체크비트 검사 수식 ---------------------------------     
      FOR C1 IN 1 .. 12
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
        V_RETURN_FLAG := 'Y';  
      END IF;
      
      RETURN V_RETURN_VALUE;

  END CHECK_REPRE_NUM;

END EAPP_NUM_DIGIT_CHECKER_G;
/
