CREATE OR REPLACE PACKAGE EAPP_NUM_DIGIT_CHECKER_G
AS

-- �ֹι�ȣ üũ.
  FUNCTION CHECK_REPRE_NUM(P_REPRE_NUM                                    IN VARCHAR2) RETURN VARCHAR2;

END EAPP_NUM_DIGIT_CHECKER_G;
/
CREATE OR REPLACE PACKAGE BODY EAPP_NUM_DIGIT_CHECKER_G
AS

-- �ֹι�ȣ üũ.
  FUNCTION CHECK_REPRE_NUM(P_REPRE_NUM                                    IN VARCHAR2) RETURN VARCHAR2
  AS
    V_RETURN_VALUE                                            VARCHAR2(2) := 'N';

    V_CHECK_NUM                                                 NUMBER;   -- üũ ��  
  
    V_COUNT                                                          NUMBER;   -- 
    V_SEX                                                               VARCHAR2(2);   -- ����  
    V_SUM                                                             NUMBER;   -- �ֹι�ȣ üũ �հ� 
    
    V_REPRE_NUM                                                  VARCHAR2(20);   -- �ֹι�ȣ ������  
    V_RETURN_FLAG                                               VARCHAR2(2);   -- �ֹι�ȣ üũ ���  
  
  BEGIN

      --> ���� �ʱ�ȭ  
      V_CHECK_NUM := 2;
      V_RETURN_FLAG := 'N';
        
      V_COUNT := 0;
      V_SEX := 0;
      V_SUM := 0;   

      --> '-' ����   
      SELECT REPLACE(P_REPRE_NUM, '-', '') AS N_REPRE_NUM
        INTO V_REPRE_NUM
      FROM DUAL;
      
      --> �ֹι�ȣ ���� üũ ;
      IF P_REPRE_NUM IS NULL OR LENGTH(V_REPRE_NUM) <> 13 THEN
        RETURN V_RETURN_FLAG;
      END IF;
      
      --> ����  
      SELECT SUBSTR(V_REPRE_NUM, 7, 1) AS V_SEX
        INTO V_SEX
      FROM DUAL;
      
    -- �ֹι�ȣ üũ��Ʈ �˻� ���� ---------------------------------     
      FOR C1 IN 1 .. 12
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
        V_RETURN_FLAG := 'Y';  
      END IF;
      
      RETURN V_RETURN_VALUE;

  END CHECK_REPRE_NUM;

END EAPP_NUM_DIGIT_CHECKER_G;
/
