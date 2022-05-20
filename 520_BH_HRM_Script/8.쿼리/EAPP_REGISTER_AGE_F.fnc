CREATE OR REPLACE FUNCTION EAPP_REGISTER_AGE_F
                            ( P_REPRE_NUM            IN VARCHAR2
                            , P_STD_DATE            IN DATE
                            , P_ADD_AGE             IN NUMBER
                            ) RETURN NUMBER
AS
  V_REPRE_NUM               VARCHAR2(13);
  V_BIRTHDAY                DATE;
  V_AGE                     NUMBER;

BEGIN
  --> '-' 제외
  V_REPRE_NUM := REPLACE(P_REPRE_NUM, '-', '');
--DBMS_OUTPUT.PUT_LINE('V_REPRE_NUM -> ' || V_REPRE_NUM);

  --> 주민번호 체크
  IF EAPP_NUM_DIGIT_CHECKER_G.CHECK_REPRE_NUM_F(P_REPRE_NUM) = 'N' THEN
    RETURN -1;
  END IF;

  --> 년도 생성
  IF SUBSTR(V_REPRE_NUM, 7, 1) IN('1', '2', '5', '6') THEN
    V_REPRE_NUM := '19' || SUBSTR(V_REPRE_NUM, 1, 6);
  ELSE
    V_REPRE_NUM := '20' || SUBSTR(V_REPRE_NUM, 1, 6);
  END IF;
  V_BIRTHDAY := TO_DATE(V_REPRE_NUM, 'YYYY-MM-DD');
--DBMS_OUTPUT.PUT_LINE('V_BIRTHDAY -> ' || V_BIRTHDAY);

  BEGIN
    V_AGE := TRUNC(MONTHS_BETWEEN(P_STD_DATE, V_BIRTHDAY) / 12);
  EXCEPTION WHEN OTHERS THEN
    V_AGE := -1;
  END;
--DBMS_OUTPUT.PUT_LINE('V_AGE -> ' || V_AGE);

  IF NVL(V_AGE, 0) > -1 THEN
    V_AGE := NVL(V_AGE, 0) + NVL(P_ADD_AGE, 0);
  END IF;
--DBMS_OUTPUT.PUT_LINE('V_AGE -> ' || V_AGE);
  RETURN V_AGE;

EXCEPTION WHEN OTHERS THEN
  RETURN 0;
END EAPP_REGISTER_AGE_F;
/
