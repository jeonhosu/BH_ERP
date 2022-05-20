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
    -- ���λ����(�ֹι�ȣ)0
      V_RETURN_VALUE := EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM(V_TAX_NUM);
              
    ELSIF LENGTHB(V_TAX_NUM) = 10 THEN
    -- ���� �����(����� ��ȣ).  
      
      -- DIGIT ���� �и�.  
      V_CHECK_DIGIT := SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM), 1);
DBMS_OUTPUT.PUT_LINE('���� ���� ��ȣ : ' || V_TAX_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
      
      -- �ʱ�ȭ.
      V_CHECK_SUM := 0;
      V_CHECK_NUM := 0;
      -- 1. ó��.
      FOR C1 IN 1 .. LENGTHB(V_TAX_NUM) - 1
      LOOP
        V_CHECK_SUM := V_CHECK_SUM + (SUBSTR(V_TAX_NUM, C1, 1) * SUBSTR(V_CHECK_VALUE, C1, 1));

DBMS_OUTPUT.PUT_LINE('[ ' || C1 || ' ] ==>' || SUBSTR(V_TAX_NUM, C1, 1) || ', V_CHECK_SUM : ' || V_CHECK_SUM);
       
      END LOOP C1;

DBMS_OUTPUT.PUT_LINE('V_CHECK_SUM==> ' || V_CHECK_SUM || ', 9���� ������ ==>' || SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1));
DBMS_OUTPUT.PUT_LINE('9���� ��==>' || TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10) || ', 9���� ������ ==>' || ((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) MOD 10));
      -- 2. ó��( 1.ó�� + (9��° ���� MOD 10).
      V_CHECK_SUM := V_CHECK_SUM + TRUNC((SUBSTR(V_TAX_NUM, LENGTHB(V_TAX_NUM) - 1, 1) * 5) / 10);
      
DBMS_OUTPUT.PUT_LINE('[ V_TAX_NUM ] ==>' || V_TAX_NUM || ', V_CHECK_SUM==> ' || V_CHECK_SUM);    
      
      -- �D / 10 ���� ����.
      V_CHECK_NUM := V_CHECK_SUM MOD 10;
DBMS_OUTPUT.PUT_LINE('[ �� ] ==>' || V_CHECK_NUM);   

      -- 10 - ��(������ ��� ���밪 ����).
      V_CHECK_NUM := 10 - V_CHECK_NUM;
      IF V_CHECK_NUM = 10 THEN
          V_CHECK_NUM := 0;
      ELSIF V_CHECK_NUM < 0 THEN
          V_CHECK_NUM := ABS(V_CHECK_NUM);
      END IF;
DBMS_OUTPUT.PUT_LINE('[ 10-�� ] ==>' || V_CHECK_NUM); 
      
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
    
DBMS_OUTPUT.PUT_LINE('[ V_RETURN_VALUE ] ==>' || V_RETURN_VALUE); 
    
END;
