DECLARE 
  
  V_RETURN_VALUE                    VARCHAR2(1) := 'N';
  V_LEGAL_NUM                         VARCHAR2(14) := '110111-0062432';
  V_ADD_NUM                             NUMBER;
  
  V_CHECK_DIGIT                         NUMBER;
  V_CHECK_SUM                         NUMBER;
  V_CHECK_NUM                         NUMBER;
  
BEGIN

    V_LEGAL_NUM := REPLACE(V_LEGAL_NUM, '-', '');
    IF V_LEGAL_NUM IS NULL OR LENGTHB(V_LEGAL_NUM) <> 13 THEN
      RETURN;
    END IF;
    -- DIGIT ���� �и�.  
    V_CHECK_DIGIT := SUBSTR(V_LEGAL_NUM, LENGTHB(V_LEGAL_NUM), 1);
--DBMS_OUTPUT.PUT_LINE('���� ���� ��ȣ : ' || V_LEGAL_NUM || ', V_CHECK_NUM : ' || V_CHECK_DIGIT);
    
    -- �ʱ�ȭ.
    V_CHECK_SUM := 0;
    V_CHECK_NUM := 0;
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
    
    -- �D / 10 ���� ����.
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
DBMS_OUTPUT.PUT_LINE('[ V_RETURN_VALUE ] ==>' || V_RETURN_VALUE); 
    
END;
