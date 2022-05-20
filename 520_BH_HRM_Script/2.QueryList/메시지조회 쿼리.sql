DECLARE
  V_PARAMETER                                           VARCHAR2(200);
  V_MESSAGE                                               VARCHAR2(200);
  V_PARA                                                      VARCHAR2(200);
  V_VALUE                                                     VARCHAR2(200);
  
  N_MAX_COUNT                                           NUMBER := 0;
  N_COL_NUM                                                 NUMBER := 0;
  
  V_START_NUM                                             NUMBER := 0;
  V_END_NUM                                                 NUMBER := 0;
  V_VALUE_START_NUM                                 NUMBER := 0;
  V_VALUE_END_NUM                                     NUMBER := 0;
  
  
BEGIN
  V_PARAMETER := '&&S_MONTH:=2010-01&&E_MONTH:=2010-06&&E_MID:=2010-05';
  V_MESSAGE := '조회조건은 &&S_MONTH 보다 크고 &&E_MONTH보다 작아야 합니다 그리고 &&E_MID 값을 ...';

  DBMS_OUTPUT.PUT_LINE('PARAMETER => ' || V_PARAMETER || ', MESSAGE => ' || V_MESSAGE || ', LENGTH : ' || LENGTHB(V_PARAMETER));
  
  N_MAX_COUNT := 0;
  V_START_NUM := 0;
  N_COL_NUM := 0;       -- 단어 검색 위치.  
  -- 총 파라메터 갯수 처리.
  FOR C1 IN 1 .. LENGTHB(V_PARAMETER)
  LOOP
    -- 초기화.
    V_PARA := NULL;
    V_VALUE := NULL;
    
    -- 변수명.
    N_COL_NUM := INSTR(V_PARAMETER, '&&', V_START_NUM + 1);
    IF N_COL_NUM > 0 THEN
      V_START_NUM := N_COL_NUM;
      V_END_NUM := INSTR(V_PARAMETER, ':=', V_START_NUM);
       
      V_PARA := SUBSTR(V_PARAMETER, V_START_NUM, V_END_NUM - V_START_NUM);
--      DBMS_OUTPUT.PUT_LINE('---> V_PARA : ' || V_PARA || ' , V_START_NUM -> ' || V_START_NUM || ', V_END_NUM->' || V_END_NUM );
    END IF;

    -- 치환값.
    N_COL_NUM := INSTR(V_PARAMETER, ':=', V_START_NUM);
    IF N_COL_NUM > 0 THEN
      V_START_NUM := N_COL_NUM + 2;
      V_END_NUM := INSTR(V_PARAMETER, '&&', V_START_NUM);
      IF V_END_NUM = 0 THEN
        V_END_NUM := LENGTHB(V_PARAMETER) + 1;
      END IF;
      V_VALUE := SUBSTR(V_PARAMETER, V_START_NUM, V_END_NUM - V_START_NUM);
--      DBMS_OUTPUT.PUT_LINE('-2--> V_VALUE : ' || V_VALUE || ' , V_START_NUM -> ' || V_START_NUM || ', V_END_NUM->' || V_END_NUM );
    END IF;
    
--    DBMS_OUTPUT.PUT_LINE('---> V_PARA : ' || V_PARA || ' , V_VALUE -> ' || V_VALUE); 
    -- 변환하기.
    IF V_PARA IS NULL OR V_VALUE IS NULL THEN
      NULL;  
    ELSE
      V_MESSAGE := REPLACE(V_MESSAGE, V_PARA, V_VALUE);
      DBMS_OUTPUT.PUT_LINE('===>' || V_MESSAGE);      
    END IF;
     
  END LOOP C1;  
  
END;
