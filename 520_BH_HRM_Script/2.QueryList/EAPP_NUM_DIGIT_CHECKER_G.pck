CREATE OR REPLACE PACKAGE EAPP_NUM_DIGIT_CHECKER_G
AS
-----------------------------------------------------------------------------------------
-- FUNCTION--
-----------------------------------------------------------------------------------------
-- �ֹι�ȣ üũ.
  FUNCTION CHECK_REPRE_NUM_F(P_REPRE_NUM                               IN VARCHAR2) RETURN VARCHAR2;

-- ���ι�ȣ üũ.
  FUNCTION CHECK_LEGAL_NUM_F(P_LEGAL_NUM                               IN VARCHAR2) RETURN VARCHAR2;

-- ����ڹ�ȣ üũ.
  FUNCTION CHECK_TAX_NUM_F(P_TAX_NUM                                   IN VARCHAR2) RETURN VARCHAR2;


-----------------------------------------------------------------------------------------
-- PROCEDURE --
-----------------------------------------------------------------------------------------
-- �ֹι�ȣ üũ.
  PROCEDURE CHECK_REPRE_NUM(P_REPRE_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2
													, O_SEX_TYPE                                 OUT VARCHAR2);

-- ���ι�ȣ üũ.
  PROCEDURE CHECK_LEGAL_NUM(P_LEGAL_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2);

-- ����ڹ�ȣ üũ.
  PROCEDURE CHECK_TAX_NUM(P_TAX_NUM                                    IN VARCHAR2
                        , O_RETURN_VALUE                               OUT VARCHAR2);
      
END EAPP_NUM_DIGIT_CHECKER_G;
/
CREATE OR REPLACE PACKAGE BODY EAPP_NUM_DIGIT_CHECKER_G
AS
-----------------------------------------------------------------------------------------
-- FUNCTION--
-----------------------------------------------------------------------------------------
-- �ֹι�ȣ üũ.--
  FUNCTION CHECK_REPRE_NUM_F(P_REPRE_NUM                               IN VARCHAR2) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                            VARCHAR2(2) := 'N';
    V_REPRE_NUM                                               VARCHAR2(20);   -- �ֹι�ȣ ������  
    
    V_CHECK_NUM                                               NUMBER;   -- üũ ��  
  
    V_SEX                                                     VARCHAR2(2);   -- ����  
    V_SUM                                                     NUMBER;   -- �ֹι�ȣ üũ �հ� 

  BEGIN

      --> ���� �ʱ�ȭ  
      V_CHECK_NUM := 2;
      V_RETURN_VALUE := 'N';
        
      V_SEX := 0;
      V_SUM := 0;   

      --> '-' ����   
      V_REPRE_NUM := REPLACE(P_REPRE_NUM, '-', '');
      
      --> �ֹι�ȣ ���� üũ ;
      IF P_REPRE_NUM IS NULL OR LENGTH(V_REPRE_NUM) <> 13 THEN
        RETURN V_RETURN_VALUE;
      END IF;
      
      --> ����  
      SELECT SUBSTR(V_REPRE_NUM, 7, 1) AS V_SEX
        INTO V_SEX
      FROM DUAL;
      
    -- �ֹι�ȣ üũ��Ʈ �˻� ���� ---------------------------------     
      FOR C1 IN 1 .. LENGTHB(V_REPRE_NUM) - 1
      LOOP
        V_SUM := V_SUM + SUBSTR(V_REPRE_NUM, C1, 1) * V_CHECK_NUM;
        V_CHECK_NUM := V_CHECK_NUM + 1;
        
        IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 2;
        END IF;
         
      END LOOP;
      V_SUM := 11 - (V_SUM MOD 11);
      
    -- ������ ���� ��,�ܱ��� üũ  ---------------------------------     
      IF V_SEX BETWEEN '5' AND '8' THEN
      --> �ܱ���  
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;
        V_SUM := V_SUM + 2;
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;    
        
      ELSE
      --> ������  
        V_SUM := V_SUM MOD 10;
            
      END IF;  
      
      IF V_SUM = SUBSTR(V_REPRE_NUM, 13, 1) THEN
        V_RETURN_VALUE := 'Y';  
      END IF;
      
      RETURN V_RETURN_VALUE;

  END CHECK_REPRE_NUM_F;
  
-- ���ι�ȣ üũ.--
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
    
    -- DIGIT ���� �и�.  
    V_CHECK_DIGIT := SUBSTR(V_LEGAL_NUM, LENGTHB(V_LEGAL_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('���� ���� ��ȣ : ' || V_LEGAL_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
        
    -- �ʱ�ȭ.
    V_CHECK_SUM := 0;
    V_ADD_NUM := 1;
    -- ó��.
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
        
    -- ? / 10 ���� ����.
    V_CHECK_NUM := V_CHECK_SUM MOD 10;
--DBMS_OUTPUT.PUT_LINE('[ �� ] ==>' || V_CHECK_NUM);    

    -- 10 - ��(������ ��� ���밪 ����).
    V_CHECK_NUM := 10 - V_CHECK_NUM;   
    IF V_CHECK_NUM = 10 THEN
        V_CHECK_NUM := 0;
    ELSIF V_CHECK_NUM < 0 THEN
        V_CHECK_NUM := ABS(V_CHECK_NUM);
    END IF;
--DBMS_OUTPUT.PUT_LINE('[ 10-�� ] ==>' || V_CHECK_NUM); 
        
    -- üũ��Ʈ ����.
    IF V_CHECK_NUM = V_CHECK_DIGIT THEN
        V_RETURN_VALUE := 'Y';
    ELSE
        V_RETURN_VALUE := 'N';
    END IF;
    
    RETURN V_RETURN_VALUE;
    
  END CHECK_LEGAL_NUM_F;

-- ����ڹ�ȣ üũ.--
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
    -- ���λ����(�ֹι�ȣ)0
      V_RETURN_VALUE := EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(V_TAX_NUM);
              
    ELSIF LENGTH(V_TAX_NUM) = 10 THEN
    -- ���� �����(����� ��ȣ).  
      -- DIGIT ���� �и�.  
      V_CHECK_DIGIT := SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('���� ���� ��ȣ : ' || V_TAX_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
      
      -- �ʱ�ȭ.
      V_CHECK_SUM := 0;
      -- 1. ó��.
      FOR C1 IN 1 .. LENGTHB(V_TAX_NUM) - 1
      LOOP
        V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_TAX_NUM, C1, 1) * SUBSTR(V_CHECK_VALUE, C1, 1));
--DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_TAX_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
       
      END LOOP C1;

--DBMS_OUTPUT.PUT_LINE('V_CHECK_SUM==> ' || V_CHECK_SUM || ', 9���� ������ ==>' || SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1));
--DBMS_OUTPUT.PUT_LINE('9���� ��==>' || TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10) || ', 9���� ������ ==>' || ((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) MOD 10));
      -- 2. ó��( 1.ó�� + (9��° ���� MOD 10).
      V_CHECK_SUM := V_CHECK_SUM + TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10);
      
--DBMS_OUTPUT.PUT_LINE('[ V_TAX_NUM ] ==>' || V_TAX_NUM || ', V_CHECK_SUM==> ' || V_CHECK_SUM);    
      
      -- ? / 10 ���� ����.
      V_CHECK_NUM := V_CHECK_SUM MOD 10;
--DBMS_OUTPUT.PUT_LINE('[ �� ] ==>' || V_CHECK_NUM);   

      -- 10 - ��(������ ��� ���밪 ����).
      V_CHECK_NUM := 10 - V_CHECK_NUM;
      IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 0;
      ELSIF V_CHECK_NUM < 0 THEN
          V_CHECK_NUM := ABS(V_CHECK_NUM);
      END IF;
--DBMS_OUTPUT.PUT_LINE('[ 10-�� ] ==>' || V_CHECK_NUM); 
      
      -- üũ��Ʈ ����.
      IF V_CHECK_NUM = V_CHECK_DIGIT THEN
          V_RETURN_VALUE := 'Y';
      ELSE
          V_RETURN_VALUE := 'N';
      END IF;
    ELSE
    -- �׿�.
      V_RETURN_VALUE := 'N';
    END IF;
    RETURN V_RETURN_VALUE;
    
  END CHECK_TAX_NUM_F;


-----------------------------------------------------------------------------------------
-- PROCEDURE --
-----------------------------------------------------------------------------------------
-- �ֹι�ȣ üũ.--
  PROCEDURE CHECK_REPRE_NUM(P_REPRE_NUM                                IN VARCHAR2
                          , O_RETURN_VALUE                             OUT VARCHAR2
													, O_SEX_TYPE                                  OUT VARCHAR2)
  AS
    V_RETURN_VALUE                               VARCHAR2(2) := 'N';
    V_REPRE_NUM                                  VARCHAR2(20);   -- �ֹι�ȣ ������  
    
    V_CHECK_NUM                                  NUMBER;   -- üũ ��  
  
    V_SEX                                        VARCHAR2(2);   -- ����  
    V_SUM                                        NUMBER;   -- �ֹι�ȣ üũ �հ� 
  
  BEGIN

      --> ���� �ʱ�ȭ  
      V_CHECK_NUM := 2;
      V_RETURN_VALUE := 'N';
        
      V_SEX := 0;
      V_SUM := 0;   

      --> '-' ����   
      V_REPRE_NUM := REPLACE(P_REPRE_NUM, '-', '');
      
      --> �ֹι�ȣ ���� üũ ;
      IF P_REPRE_NUM IS NULL OR LENGTH(V_REPRE_NUM) <> 13 THEN
        O_RETURN_VALUE := V_RETURN_VALUE;
        RETURN;
      END IF;
      
      --> ����  
      SELECT SUBSTR(V_REPRE_NUM, 7, 1) AS V_SEX
        INTO V_SEX
      FROM DUAL;
      
    -- �ֹι�ȣ üũ��Ʈ �˻� ���� ---------------------------------     
      FOR C1 IN 1 .. LENGTHB(V_REPRE_NUM) - 1
      LOOP
        V_SUM := V_SUM + SUBSTR(V_REPRE_NUM, C1, 1) * V_CHECK_NUM;
        V_CHECK_NUM := V_CHECK_NUM + 1;
        
        IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 2;
        END IF;
         
      END LOOP;
      V_SUM := 11 - (V_SUM MOD 11);
      
    -- ������ ���� ��,�ܱ��� üũ  ---------------------------------     
      IF V_SEX BETWEEN '5' AND '8' THEN
      --> �ܱ���  
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;
        V_SUM := V_SUM + 2;
        IF V_SUM >= 10 THEN
          V_SUM := V_SUM - 10;    
        END IF;    
        
      ELSE
      --> ������  
        V_SUM := V_SUM MOD 10;
            
      END IF;  
      
      IF V_SUM = SUBSTR(V_REPRE_NUM, 13, 1) THEN
        V_RETURN_VALUE := 'Y';  
      END IF;
			
			IF MOD(V_SEX, 2) = 0 THEN
			-- ����.
			  O_SEX_TYPE := '2';
			ELSE
			-- ����.
			  O_SEX_TYPE := '1';
			END IF;
      O_RETURN_VALUE := V_RETURN_VALUE;
  
  END CHECK_REPRE_NUM;

-- ���ι�ȣ üũ.--
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
    
    -- DIGIT ���� �и�.  
    V_CHECK_DIGIT := SUBSTR(V_LEGAL_NUM, LENGTHB(V_LEGAL_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('���� ���� ��ȣ : ' || V_LEGAL_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
        
    -- �ʱ�ȭ.
    V_CHECK_SUM := 0;
    V_ADD_NUM := 1;
    -- ó��.
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
        
    -- ? / 10 ���� ����.
    V_CHECK_NUM := V_CHECK_SUM MOD 10;

--DBMS_OUTPUT.PUT_LINE('[ �� ] ==>' || V_CHECK_NUM);    

    -- 10 - ��(������ ��� ���밪 ����).
    V_CHECK_NUM := 10 - V_CHECK_NUM;   
    IF V_CHECK_NUM = 10 THEN
        V_CHECK_NUM := 0;
    ELSIF V_CHECK_NUM < 0 THEN
        V_CHECK_NUM := ABS(V_CHECK_NUM);
    END IF;
    
--DBMS_OUTPUT.PUT_LINE('[ 10-�� ] ==>' || V_CHECK_NUM); 
        
    -- üũ��Ʈ ����.
    IF V_CHECK_NUM = V_CHECK_DIGIT THEN
        V_RETURN_VALUE := 'Y';
    ELSE
        V_RETURN_VALUE := 'N';
    END IF;
    O_RETURN_VALUE := V_RETURN_VALUE;
  
  END CHECK_LEGAL_NUM;

-- ����ڹ�ȣ üũ.--
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
    -- ���λ����(�ֹι�ȣ)0
      V_RETURN_VALUE := EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(V_TAX_NUM);
              
    ELSIF LENGTH(V_TAX_NUM) = 10 THEN
    -- ���� �����(����� ��ȣ).  
      
      -- DIGIT ���� �и�.  
      V_CHECK_DIGIT := SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('���� ���� ��ȣ : ' || V_TAX_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
      
      -- �ʱ�ȭ.
      V_CHECK_SUM := 0;
      -- 1. ó��.
      FOR C1 IN 1 .. LENGTHB(V_TAX_NUM) - 1
      LOOP
        V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_TAX_NUM, C1, 1) * SUBSTR(V_CHECK_VALUE, C1, 1));

--DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_TAX_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
       
      END LOOP C1;

--DBMS_OUTPUT.PUT_LINE('V_CHECK_SUM==> ' || V_CHECK_SUM || ', 9���� ������ ==>' || SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1));
--DBMS_OUTPUT.PUT_LINE('9���� ��==>' || TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10) || ', 9���� ������ ==>' || ((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) MOD 10));
      -- 2. ó��( 1.ó�� + (9��° ���� MOD 10).
      V_CHECK_SUM := V_CHECK_SUM + TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10);
      
--DBMS_OUTPUT.PUT_LINE('[ V_TAX_NUM ] ==>' || V_TAX_NUM || ', V_CHECK_SUM==> ' || V_CHECK_SUM);    
      
      -- ? / 10 ���� ����.
      V_CHECK_NUM := V_CHECK_SUM MOD 10;
--DBMS_OUTPUT.PUT_LINE('[ �� ] ==>' || V_CHECK_NUM);   

      -- 10 - ��(������ ��� ���밪 ����).
      V_CHECK_NUM := 10 - V_CHECK_NUM;
      IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 0;
      ELSIF V_CHECK_NUM < 0 THEN
          V_CHECK_NUM := ABS(V_CHECK_NUM);
      END IF;
--DBMS_OUTPUT.PUT_LINE('[ 10-�� ] ==>' || V_CHECK_NUM); 
      
      -- üũ��Ʈ ����.
      IF V_CHECK_NUM = V_CHECK_DIGIT THEN
          V_RETURN_VALUE := 'Y';
      ELSE
          V_RETURN_VALUE := 'N';
      END IF;
      
    ELSE
    -- �׿�.
      V_RETURN_VALUE := 'N';
    
    END IF;
    O_RETURN_VALUE := V_RETURN_VALUE;
    
  END CHECK_TAX_NUM;
                                                    
END EAPP_NUM_DIGIT_CHECKER_G;
/
