CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_SET_G
AS
  PROCEDURE MAIN_ADJUST_SET
            ( P_CORP_ID           IN NUMBER
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );

END HRA_YEAR_ADJUST_SET_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUST_SET_G
AS
  
  PROCEDURE MAIN_ADJUST_SET
            ( P_CORP_ID           IN NUMBER
            , P_STD_DATE          IN DATE
            , P_PERSON_ID         IN NUMBER
            , P_USER_ID           IN NUMBER
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_YEAR_YYYY  VARCHAR2(4);
    V_RECORD_COUNT NUMBER;
  BEGIN
    O_STATUS := 'F';
---> 초기화  
    V_YEAR_YYYY := TO_CHAR(P_STD_DATE, 'YYYY');
    
--DBMS_OUTPUT.PUT_LINE('V_STR_MONTH -> ' || V_STR_MONTH || 'V_END_MONTH -> ' || V_END_MONTH);        
  
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HIT.YEAR_YYYY) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_INCOME_TAX_STANDARD HIT
      WHERE HIT.YEAR_YYYY        = V_YEAR_YYYY
        AND HIT.SOB_ID           = P_SOB_ID
        AND HIT.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10244', NULL);
      RETURN;
    END IF;
  
    V_RECORD_COUNT := 0;
    BEGIN
      SELECT COUNT(HT.TAX_YYYY) AS RECORD_COUNT
        INTO V_RECORD_COUNT
        FROM HRA_TAX_RATE HT
      WHERE HT.TAX_YYYY          = V_YEAR_YYYY
        AND EXISTS ( SELECT 'X'
                       FROM HRM_COMMON HC
                     WHERE HC.COMMON_ID     = HT.TAX_TYPE_ID
                       AND HC.SOB_ID        = HT.SOB_ID
                       AND HC.ORG_ID        = HT.ORG_ID
                       AND HC.GROUP_CODE    = 'TAX_TYPE'
                       AND HC.CODE          = '10'
                   )
        AND HT.SOB_ID            = P_SOB_ID
        AND HT.ORG_ID            = P_ORG_ID
      ;
    EXCEPTION
      WHEN OTHERS THEN
        V_RECORD_COUNT := 0;
    END;
    IF V_RECORD_COUNT = 0 THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10245', NULL);
      RETURN;
    END IF;
    
    -- 연말정산 패키지 호출.
    IF V_YEAR_YYYY = '2010' THEN
      -- 2010년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2010.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => P_STD_DATE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_ERR_MSG           => O_MESSAGE
        );
        O_STATUS := 'S';
    ELSIF V_YEAR_YYYY = '2011' THEN
      -- 2011년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2011.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => P_STD_DATE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    ELSE
      -- 2012년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2012.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => P_STD_DATE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    END IF;
    O_STATUS := O_STATUS;
  END MAIN_ADJUST_SET;

END HRA_YEAR_ADJUST_SET_G;
/
