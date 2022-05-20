CREATE OR REPLACE PACKAGE HRA_YEAR_ADJUST_SET_G
AS

-- 연말정산 계산 -- 
  PROCEDURE MAIN_ADJUST_SET
            ( P_CORP_ID           IN  NUMBER
            , P_YEAR_YYYYMM       IN  VARCHAR2
            , P_DEPT_ID           IN  NUMBER
            , P_FLOOR_ID          IN  NUMBER
            , P_EMPLOYE_TYPE      IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_USER_ID           IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );


-- 연말정산 마감 / 마감 취소 -- 
  PROCEDURE SET_ADJUST_CLOSED
            ( P_YEAR_YYYYMM       IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_CONNECT_PERSON_ID IN  NUMBER
            , P_USER_ID           IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            , P_CLOSED_FLAG       IN  VARCHAR2
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            );
                        
END HRA_YEAR_ADJUST_SET_G;
/
CREATE OR REPLACE PACKAGE BODY HRA_YEAR_ADJUST_SET_G
AS
  
  PROCEDURE MAIN_ADJUST_SET
            ( P_CORP_ID           IN  NUMBER
            , P_YEAR_YYYYMM       IN  VARCHAR2
            , P_DEPT_ID           IN  NUMBER
            , P_FLOOR_ID          IN  NUMBER
            , P_EMPLOYE_TYPE      IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_USER_ID           IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_STD_DATE          DATE;
    V_YEAR_YYYY         VARCHAR2(4);
    V_RECORD_COUNT      NUMBER;
  BEGIN
    O_STATUS := 'F';
---> 초기화  
    BEGIN
      V_STD_DATE := LAST_DAY(TO_DATE(P_YEAR_YYYYMM, 'YYYY-MM'));
      V_YEAR_YYYY := TO_CHAR(V_STD_DATE, 'YYYY');
    EXCEPTION
      WHEN OTHERS THEN
        O_MESSAGE := 'Year Set Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
    END;
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
        , P_STD_DATE          => V_STD_DATE
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
        , P_STD_DATE          => V_STD_DATE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    ELSIF V_YEAR_YYYY = '2012' THEN
      IF TO_CHAR(V_STD_DATE, 'MM-DD') = '12-31' THEN
        -- 기부금 조정명세서 작성 : 12월31일 재직자에 대해서 적용 --
        HRA_DONATION_INFO_G.SET_DONATION_ADJUSTMENT
          ( P_CORP_ID           => P_CORP_ID
          , P_YEAR_YYYY         => V_YEAR_YYYY
          , P_DEPT_ID           => P_DEPT_ID
          , P_FLOOR_ID          => P_FLOOR_ID
          , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
          , P_PERSON_ID         => P_PERSON_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      
      -- 2012년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2012.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => V_STD_DATE
        , P_DEPT_ID           => P_DEPT_ID
        , P_FLOOR_ID          => P_FLOOR_ID
        , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    ELSIF V_YEAR_YYYY = '2013' THEN
      IF TO_CHAR(V_STD_DATE, 'MM-DD') = '12-31' THEN
        -- 기부금 조정명세서 작성 : 12월31일 재직자에 대해서 적용 --
        HRA_DONATION_INFO_G.SET_DONATION_ADJUSTMENT
          ( P_CORP_ID           => P_CORP_ID
          , P_YEAR_YYYY         => V_YEAR_YYYY
          , P_DEPT_ID           => P_DEPT_ID
          , P_FLOOR_ID          => P_FLOOR_ID
          , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
          , P_PERSON_ID         => P_PERSON_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      
      -- 2013년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2013.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => V_STD_DATE
        , P_DEPT_ID           => P_DEPT_ID
        , P_FLOOR_ID          => P_FLOOR_ID
        , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    ELSE
      IF TO_CHAR(V_STD_DATE, 'MM-DD') = '12-31' THEN
        -- 기부금 조정명세서 작성 : 12월31일 재직자에 대해서 적용 --
        HRA_DONATION_INFO_G.SET_DONATION_ADJUSTMENT
          ( P_CORP_ID           => P_CORP_ID
          , P_YEAR_YYYY         => V_YEAR_YYYY
          , P_DEPT_ID           => P_DEPT_ID
          , P_FLOOR_ID          => P_FLOOR_ID
          , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
          , P_PERSON_ID         => P_PERSON_ID
          , P_SOB_ID            => P_SOB_ID
          , P_ORG_ID            => P_ORG_ID
          , P_USER_ID           => P_USER_ID
          , O_STATUS            => O_STATUS
          , O_MESSAGE           => O_MESSAGE
          );
        IF O_STATUS = 'F' THEN
          RETURN;
        END IF;
      END IF;
      
      -- 2013년도 연말정산.
      HRA_YEAR_ADJUST_SET_G_2014.MAIN_CAL
        ( P_CORP_ID           => P_CORP_ID
        , P_YEAR_YYYY         => V_YEAR_YYYY
        , P_STD_DATE          => V_STD_DATE
        , P_DEPT_ID           => P_DEPT_ID
        , P_FLOOR_ID          => P_FLOOR_ID
        , P_EMPLOYE_TYPE      => P_EMPLOYE_TYPE
        , P_PERSON_ID         => P_PERSON_ID
        , P_USER_ID           => P_USER_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , O_STATUS            => O_STATUS
        , O_MESSAGE           => O_MESSAGE
        );
    END IF;
  END MAIN_ADJUST_SET;



-- 연말정산 마감 / 마감 취소 -- 
  PROCEDURE SET_ADJUST_CLOSED
            ( P_YEAR_YYYYMM       IN  VARCHAR2
            , P_PERSON_ID         IN  NUMBER
            , P_CONNECT_PERSON_ID IN  NUMBER
            , P_USER_ID           IN  NUMBER
            , P_SOB_ID            IN  NUMBER
            , P_ORG_ID            IN  NUMBER
            , P_CLOSED_FLAG       IN  VARCHAR2
            , O_STATUS            OUT VARCHAR2
            , O_MESSAGE           OUT VARCHAR2
            )
  AS
    V_SYSDATE           DATE := GET_LOCAL_DATE(P_SOB_ID);
    V_YEAR_YYYY         VARCHAR2(4);
    V_START_DATE        DATE;
    V_END_DATE          DATE;
    
    V_RECORD_COUNT      NUMBER;
  BEGIN
    O_STATUS := 'F';
    BEGIN
      V_START_DATE := TRUNC(TO_DATE(P_YEAR_YYYYMM, 'YYYY-MM'), 'MONTH');
      V_END_DATE := LAST_DAY(V_START_DATE);
      V_YEAR_YYYY := TO_CHAR(V_END_DATE, 'YYYY');
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Set Date Error : (' || P_YEAR_YYYYMM || ') '  || SUBSTR(SQLERRM, 1, 150);
      RETURN;
    END;
    
    -- CLOSED FLAG UPDATE --
    IF P_CLOSED_FLAG = 'N' THEN
      -- 미마감된 자료를 마감 처리함 --
      BEGIN
        UPDATE  HRA_YEAR_ADJUSTMENT HA
           SET HA.CLOSED_FLAG       = 'Y'
             , HA.CLOSED_DATE       = V_SYSDATE
             , HA.CLOSED_PERSON_ID  = P_CONNECT_PERSON_ID
         WHERE HA.YEAR_YYYY         = V_YEAR_YYYY        
           AND HA.PERSON_ID         = P_PERSON_ID
           AND HA.SOB_ID            = P_SOB_ID
           AND HA.ORG_ID            = P_ORG_ID
           AND HA.SUBMIT_DATE       BETWEEN V_START_DATE AND V_END_DATE
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- 마감 구분 -- 
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Closed Flag Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    ELSIF P_CLOSED_FLAG = 'Y' THEN
      -- 마감된 자료를 마감 취소 처리함 --
      -- 급여전송이 된 경우 마감취소 불가 --
      V_RECORD_COUNT := 0;
      BEGIN
        SELECT COUNT(HA.PERSON_ID) AS RECORD_COUNT
          INTO V_RECORD_COUNT
          FROM HRA_YEAR_ADJUSTMENT HA
         WHERE HA.YEAR_YYYY         = V_YEAR_YYYY        
           AND HA.PERSON_ID         = P_PERSON_ID
           AND HA.SOB_ID            = P_SOB_ID
           AND HA.ORG_ID            = P_ORG_ID
           AND HA.SUBMIT_DATE       BETWEEN V_START_DATE AND V_END_DATE
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- 마감 구분 --
           AND HA.TRANS_YN          = 'Y' 
        ;
      EXCEPTION WHEN OTHERS THEN
        V_RECORD_COUNT := 0;  
      END;
      IF V_RECORD_COUNT > 0 THEN
        O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10490');
        RETURN;
      END IF;
      
      BEGIN
        UPDATE  HRA_YEAR_ADJUSTMENT HA
           SET HA.CLOSED_FLAG       = 'N'
             , HA.CLOSED_DATE       = V_SYSDATE
             , HA.CLOSED_PERSON_ID  = P_CONNECT_PERSON_ID
         WHERE HA.YEAR_YYYY         = V_YEAR_YYYY        
           AND HA.PERSON_ID         = P_PERSON_ID
           AND HA.SOB_ID            = P_SOB_ID
           AND HA.ORG_ID            = P_ORG_ID
           AND HA.SUBMIT_DATE       BETWEEN V_START_DATE AND V_END_DATE
           AND HA.CLOSED_FLAG       = P_CLOSED_FLAG  -- 마감 구분 -- 
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Closed Flag Update Error : ' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;
    O_STATUS := 'S';
  END SET_ADJUST_CLOSED;

END HRA_YEAR_ADJUST_SET_G;
/
