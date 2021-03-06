CREATE OR REPLACE PACKAGE HRR_RETIRE_ADJUSTMENT_SET_G
AS

/*==========================================================================/
     ==> 퇴직정산 계산
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
/==========================================================================*/
  PROCEDURE RETIRE_MAIN
            ( W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );



/*==========================================================================/
     ==> 퇴직정산 계산 
       -. 2012년도 까지 적용 
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2012
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );

/*==========================================================================/
     ==> 퇴직정산 계산 
       -. 2013년도 까지 적용 
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2013
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_REAL_LONG_YEAR                    IN NUMBER 
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );
            
/*==========================================================================/
     ==> 퇴직정산 계산 
       -. 2016년도 이후 적용 
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2016
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_REAL_LONG_YEAR                    IN NUMBER 
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            );            
            
/*==========================================================================/
     ==> 퇴직금 계산
       -. P_DAY_AVG_AMOUNT : 일평균 금액
       -. P_TOTAL_DAY : 총근속일수
/==========================================================================*/
  FUNCTION  RETR_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_DAY_AVG_AMOUNT          IN NUMBER
            , P_TOTAL_DAY               IN NUMBER            
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 퇴직소득공제 계산   - 1
/==========================================================================*/
  FUNCTION  INCOME_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_TOTAL_AMOUNT            IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 퇴직근속년수에 의한 공제액 산출  - 2
/==========================================================================*/
  FUNCTION LONG_DED_YEAR_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_LONG_YEAR               IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 환산급여 공제   - 5
/==========================================================================*/
  FUNCTION CHG_DED_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_CHG_AMOUNT              IN NUMBER
            ) RETURN NUMBER;
            
/*==========================================================================/
     ==> 년 평균 산출세액 계산   - 5
/==========================================================================*/
  FUNCTION AVG_TAX_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_AVG_TAX_STD_AMOUNT      IN NUMBER
            ) RETURN NUMBER;

/*==========================================================================/
     ==> 퇴직소득공제 계산  - 6
/==========================================================================*/
  FUNCTION TAX_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_END_DATE                IN DATE
            , P_LONG_YEAR               IN NUMBER
            , P_TAX_AMOUNT              IN NUMBER
            ) RETURN NUMBER;

END HRR_RETIRE_ADJUSTMENT_SET_G;

 
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_ADJUSTMENT_SET_G
AS

/*==========================================================================/
     ==> 퇴직정산 계산
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
       1. 퇴직소득공제 계산(INCOME_SUBTRACT)   V
       2. 근로소득공제 계산(CONTINUOUS_YEAR)   V
       3. 퇴직소득공제계(퇴직소득공제 + 근로소득공제)   V
       4. 과세표준(퇴직금 - 퇴직소득공제계)   V
       5. 산출세액(CAL_TAX)
       6. 퇴직소득세액공제() - 폐지
       7. 소득세 및 주민세(소득세 * 0.1) 계산

/==========================================================================*/
  PROCEDURE RETIRE_MAIN
            ( W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);

    V_ADJUSTMENT_ID                               NUMBER;         -- 퇴직정산 ID
    V_RETR_YYYY                                   VARCHAR2(4);    -- 퇴직년도    
    V_REAL_LONG_YEAR                              NUMBER := 0;    -- 실근속년수(1년 미만자의 경우 급상여계산 안하기 위해) 
  BEGIN
    O_STATUS := 'F';
    --> 퇴직년도 계산
    BEGIN
      V_RETR_YYYY := TO_CHAR(W_RETIRE_DATE_TO, 'YYYY');
    EXCEPTION WHEN OTHERS THEN
      V_RETR_YYYY := TO_CHAR(GET_LOCAL_DATE(W_SOB_ID), 'YYYY');
    END;

-- 해당 직원의 입사/퇴사일자 조회 -- 
    BEGIN
      SELECT HRM_COMMON_DATE_G.PERIOD_YEAR_F(PM.JOIN_DATE, (NVL(PM.RETIRE_DATE, W_RETIRE_DATE_TO) + 1), 'TRUNC') AS REAL_LONG_YEAR 
        INTO V_REAL_LONG_YEAR
        FROM HRM_PERSON_MASTER PM
       WHERE PM.PERSON_ID         = W_PERSON_ID
         AND PM.SOB_ID            = W_SOB_ID
         AND PM.ORG_ID            = W_ORG_ID 
       ;
    EXCEPTION
      WHEN OTHERS THEN
        V_REAL_LONG_YEAR := 0;
    END;  
    
-----------------------------------------------------------
    --> 기존에 처리된 퇴직정산 ID 조회(동일 기간에 대해)
    V_ADJUSTMENT_ID := 0;
    BEGIN
      SELECT RA.ADJUSTMENT_ID
        INTO V_ADJUSTMENT_ID
        FROM HRR_RETIRE_ADJUSTMENT RA
      WHERE RA.ADJUSTMENT_TYPE    = W_ADJUSTMENT_TYPE
        AND RA.PERSON_ID          = W_PERSON_ID
        AND RA.RETIRE_DATE_FR     = W_RETIRE_DATE_FR
        AND RA.RETIRE_DATE_TO     = W_RETIRE_DATE_TO
        AND RA.SOB_ID             = W_SOB_ID
        AND RA.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_ADJUSTMENT_ID := -1;
    END;

    IF HRR_RETIRE_ADJUSTMENT_G.CLOSE_CHECK_F(V_ADJUSTMENT_ID) = 'Y' THEN
      O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10168');
      RETURN;
    END IF;
    
    IF V_ADJUSTMENT_ID = 0 OR V_ADJUSTMENT_ID = -1 THEN
    --> 1.1 신규 생성
      BEGIN
          INSERT INTO HRR_RETIRE_ADJUSTMENT
          ( ADJUSTMENT_ID 
          , ADJUSTMENT_TYPE, ADJUSTMENT_YYYY, PERSON_ID , CORP_ID 
          , RETIRE_DATE_FR, RETIRE_DATE_TO, PAY_DATE_TO
          , COST_CENTER_ID
          , SOB_ID, ORG_ID
          , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
          , OFFICER_YN)
          ( SELECT HRR_RETIRE_ADJUSTMENT_S1.NEXTVAL
                , W_ADJUSTMENT_TYPE, V_RETR_YYYY, PM.PERSON_ID, PM.CORP_ID
                , TRUNC(W_RETIRE_DATE_FR), TRUNC(W_RETIRE_DATE_TO), TRUNC(W_PAY_DATE_TO)
                , PM.COST_CENTER_ID
                , W_SOB_ID, W_ORG_ID
                , V_SYSDATE, P_USER_ID, V_SYSDATE, P_USER_ID
                , NVL(T1.OFFICER_YN, 'N') AS OFFICER_YN
              FROM HRM_PERSON_MASTER PM
                 , (-- 시점 인사내역.
                  SELECT HL.PERSON_ID
                      , HL.DEPT_ID
                      , HL.POST_ID
                      , PC.OFFICER_YN
                      , HL.JOB_CATEGORY_ID
                      , HL.FLOOR_ID    
                    FROM HRM_HISTORY_LINE HL  
                       , HRM_POST_CODE_V  PC
                  WHERE HL.POST_ID          = PC.POST_ID
                    AND HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                  FROM HRM_HISTORY_LINE S_HL
                                                 WHERE S_HL.CHARGE_DATE            <= TRUNC(W_RETIRE_DATE_TO)
                                                   AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                 GROUP BY S_HL.PERSON_ID
                                               )
                  ) T1
            WHERE PM.PERSON_ID    = T1.PERSON_ID
              AND PM.PERSON_ID    = W_PERSON_ID
          );
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Person Infomation Error =>' || SUBSTR(SQLERRM, 1, 150);
        RETURN;
      END;
    END IF;
    
    -- 년도별 퇴직금계산 프로세스 변경 관리 --
    IF V_RETR_YYYY < '2013' THEN
      -- 2012년도 이전. 
      CAL_RETIRE_2012
        ( W_ADJUSTMENT_ID        => V_ADJUSTMENT_ID 
        , W_RETR_YYYY            => V_RETR_YYYY 
        , W_ADJUSTMENT_TYPE      => W_ADJUSTMENT_TYPE
        , W_RETIRE_DATE_FR       => W_RETIRE_DATE_FR
        , W_RETIRE_DATE_TO       => W_RETIRE_DATE_TO
        , W_PAY_DATE_TO          => W_PAY_DATE_TO
        , W_RETIRE_CAL_TYPE      => W_RETIRE_CAL_TYPE
        , W_CORP_ID              => W_CORP_ID
        , W_PERSON_ID            => W_PERSON_ID
        , W_SOB_ID               => W_SOB_ID
        , W_ORG_ID               => W_ORG_ID
        , P_USER_ID              => P_USER_ID
        , O_STATUS               => O_STATUS
        , O_MESSAGE              => O_MESSAGE
        );
        
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;    
    ELSIF V_RETR_YYYY < '2016' THEN
      -- 2013년도 이후.
      CAL_RETIRE_2013
        ( W_ADJUSTMENT_ID        => V_ADJUSTMENT_ID 
        , W_RETR_YYYY            => V_RETR_YYYY 
        , W_ADJUSTMENT_TYPE      => W_ADJUSTMENT_TYPE
        , W_REAL_LONG_YEAR       => V_REAL_LONG_YEAR
        , W_RETIRE_DATE_FR       => W_RETIRE_DATE_FR
        , W_RETIRE_DATE_TO       => W_RETIRE_DATE_TO
        , W_PAY_DATE_TO          => W_PAY_DATE_TO
        , W_RETIRE_CAL_TYPE      => W_RETIRE_CAL_TYPE
        , W_CORP_ID              => W_CORP_ID
        , W_PERSON_ID            => W_PERSON_ID
        , W_SOB_ID               => W_SOB_ID
        , W_ORG_ID               => W_ORG_ID
        , P_USER_ID              => P_USER_ID
        , O_STATUS               => O_STATUS
        , O_MESSAGE              => O_MESSAGE
        );
        
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    ELSE
      -- 2016년도 이후.
      CAL_RETIRE_2016
        ( W_ADJUSTMENT_ID        => V_ADJUSTMENT_ID 
        , W_RETR_YYYY            => V_RETR_YYYY 
        , W_ADJUSTMENT_TYPE      => W_ADJUSTMENT_TYPE
        , W_REAL_LONG_YEAR       => V_REAL_LONG_YEAR
        , W_RETIRE_DATE_FR       => W_RETIRE_DATE_FR
        , W_RETIRE_DATE_TO       => W_RETIRE_DATE_TO
        , W_PAY_DATE_TO          => W_PAY_DATE_TO
        , W_RETIRE_CAL_TYPE      => W_RETIRE_CAL_TYPE
        , W_CORP_ID              => W_CORP_ID
        , W_PERSON_ID            => W_PERSON_ID
        , W_SOB_ID               => W_SOB_ID
        , W_ORG_ID               => W_ORG_ID
        , P_USER_ID              => P_USER_ID
        , O_STATUS               => O_STATUS
        , O_MESSAGE              => O_MESSAGE
        );
        
      IF O_STATUS = 'F' THEN
        RETURN;
      END IF;
    END IF;    
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END RETIRE_MAIN;



/*==========================================================================/
     ==> 퇴직정산 계산 
       -. 2012년도 까지 적용 
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2012
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_RECORD_COUNT                                NUMBER := 0;
    
    V_3RD_DAY_COUNT                               NUMBER;         -- 3개월 총일수 (급여일수)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3개월 총일수 (상여연차일수)
    V_CHANGE_DAY                                  NUMBER;         -- 가감일수.
    V_REAL_DAY                                    NUMBER;         -- 실제 적용되는 근무일수
    V_RETR_AMOUNT                                 NUMBER;         -- 퇴직금
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- 총퇴직금
    V_REAL_AMOUNT                                 NUMBER;         -- 실퇴직금        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- 퇴직소득공제
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- 근속년수에 따른 소득공제
    V_TAX_STD_AMOUNT                              NUMBER;         -- 과세표준
    V_AVG_TAX_STD_AMOUNT                          NUMBER;         -- 년평균과세표준
    V_AVG_COMP_TAX_AMOUNT                         NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT                             NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT                              NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT                               NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT                            NUMBER;         -- 주민세
    
    V_H_RETIRE_DATE_FR                            DATE;           -- 명예퇴직 정산 시작일.
    V_H_RETIRE_DATE_TO                            DATE;           -- 명예퇴직 정산 종료일.
    V_H_LONG_YEAR                                 NUMBER;         -- 명예퇴직 근속년수.
    V_H_PRE_LONG_YEAR                             NUMBER;         -- 명예퇴직부터 중도정산 이전 근속년수.
    V_H_INCOME_DED_AMOUNT                         NUMBER;         -- 퇴직소득공제
    V_H_LONG_DED_YEAR_AMOUNT                      NUMBER;         -- 근속년수에 따른 소득공제    
    V_H_TAX_STD_AMOUNT                            NUMBER;         -- 과세표준
    V_H_AVG_TAX_STD_AMOUNT                        NUMBER;         -- 년평균과세표준
    V_H_AVG_COMP_TAX_AMOUNT                       NUMBER;         -- 년평균 산출세액
    V_H_COMP_TAX_AMOUNT                           NUMBER;         -- 산출세액
    V_H_TAX_DED_AMOUNT                            NUMBER;         -- 퇴직소득세액공제
    V_H_IN_TAX_AMOUNT                             NUMBER;         -- 소득세
    V_H_LOCAL_TAX_AMOUNT                          NUMBER;         -- 주민세
    V_H_REAL_AMOUNT                               NUMBER;         -- 명예퇴직금.
    
    V_REAL_TOTAL_AMOUNT                           NUMBER;         -- 실 총퇴직금.
    V_TEMP_AMOUNT                                 NUMBER;         -- 임시 변수.
    
  BEGIN
    O_STATUS := 'F';
    
    --. 매월 말일 퇴사일 경우 3개월 이전 1일 기준 그외에는 ADD_MONTHS(기준일, -3)
    V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
    V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;

    --> 가감일수 적용.
    BEGIN
      SELECT RA.DED_DAY * -1 AS DED_DAY
        INTO V_CHANGE_DAY
        FROM HRR_RETIRE_ADJUSTMENT RA
       WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CHANGE_DAY := 0;
    END;
    
    --> 1.3 근속년수, 근속월수, 근속일수 계산
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.LONG_YEAR = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
          , RA.LONG_MONTH = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
          , RA.LONG_DAY = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 1)        
          , RA.DAY_3RD_COUNT      = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
--> 3개월 급여 계산-
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 명절상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 특별상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P5'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );       
                                                 
      --> 년차합계.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.YEAR_ALLOWANCE_AMOUNT)
            = NVL(
              ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS YEAR_ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                   , HRP_MONTH_ALLOWANCE MA
                   , HRM_ALLOWANCE_V HA
                WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                  AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                  AND MP.PAY_YYYYMM              = TO_CHAR(TRUNC(RA.RETIRE_DATE_TO, 'YEAR'), 'YYYY-MM')
                  AND MP.PERSON_ID               = RA.PERSON_ID
                  AND MP.SOB_ID                  = RA.SOB_ID
                  AND MP.ORG_ID                  = RA.ORG_ID
                  AND HA.ALLOWANCE_TYPE          IN('YEAR')
                  AND HA.RETIRE_YN               = 'Y'
                GROUP BY MP.PERSON_ID
               ), 0)
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;
    END IF;

    BEGIN
      --> 급/상여 적용 계산.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.TOTAL_PAY_AMOUNT, RA.TOTAL_BONUS_AMOUNT)
            = (SELECT NVL(SUM(DECODE(RAP.WAGE_TYPE, 'P1', RAP.TOTAL_AMOUNT, 0)), 0) AS PAY_TOTAL_AMOUNT
                   , NVL(SUM(CASE
                               WHEN RAP.WAGE_TYPE IN('P2', 'P3', 'P5') THEN RAP.TOTAL_AMOUNT
                               ELSE 0
                             END), 0) AS BONUS_TOTAL_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT_PAYMENT RAP
               WHERE RAP.ADJUSTMENT_ID          = RA.ADJUSTMENT_ID
                 AND RAP.WAGE_TYPE              IN('P1', 'P2', 'P3', 'P5')    -- P1-급여, P2-상여, P3-명절상여, P5-특별상여.
               ) 
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;

       --> 일평균금액 산출
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = W_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SQLERRM;      
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    /*
    --> 기타지급/기타공제 UPDATE.
    BEGIN
      -- 기타지급/공제 UPDATE --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET (RA.ETC_SUPP_AMOUNT
            , RA.ETC_DED_AMOUNT
              ) =
              ( SELECT NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'A', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_SUPP_AMOUNT
                     , NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'D', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_DED_AMOUNT
                  FROM HRR_ETC_ALLOWANCE EA
                 WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
              )
       WHERE RA.ADJUSTMENT_ID       = W_ADJUSTMENT_ID
         AND EXISTS
               ( SELECT 'X'
                   FROM HRR_ETC_ALLOWANCE EA
                  WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
               )
       ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;*/
    
    --> 퇴직정산을 위한 기초 정보
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT
                    , NVL(RA.INCOME_DED_AMOUNT, 0) AS INCOME_DED_AMOUNT
                    , NVL(RA.LONG_DED_AMOUNT , 0) AS LONG_DED_AMOUNT
                    , NVL(RA.TAX_STD_AMOUNT, 0) AS TAX_STD_AMOUNT
                    , NVL(RA.AVG_TAX_STD_AMOUNT, 0) AS AVG_TAX_STD_AMOUNT
                    , NVL(RA.AVG_COMP_TAX_AMOUNT, 0) AS AVG_COMP_TAX_AMOUNT
                    , NVL(RA.COMP_TAX_AMOUNT, 0) AS COMP_TAX_AMOUNT
                    , NVL(RA.TAX_DED_AMOUNT, 0) AS TAX_DED_AMOUNT
                    , NVL(RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
                    , NVL(RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
               )
    LOOP
      --> 초기화
      V_REAL_DAY := 0;                  -- 실제 근속일수
      V_RETR_AMOUNT := 0;               -- 퇴직금
      V_TOTAL_RETR_AMOUNT := 0;         -- 총퇴직금 합계
      
      V_INCOME_DED_AMOUNT := 0;            -- 퇴직소득공제
      V_LONG_DED_YEAR_AMOUNT := 0;   -- 근속년수에 따른 소득공제
      V_TAX_STD_AMOUNT := 0;               -- 과세표준
      V_AVG_TAX_STD_AMOUNT := 0;           -- 년평균 과세표준
      V_AVG_COMP_TAX_AMOUNT := 0;          -- 년평균 산출세액
      V_COMP_TAX_AMOUNT := 0;              -- 산출세액
      V_TAX_DED_AMOUNT := 0;               -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT := 0;                -- 소득세
      V_LOCAL_TAX_AMOUNT := 0;             -- 주민세
      V_REAL_AMOUNT := 0;          -- 실퇴직금

      V_H_RETIRE_DATE_FR                            := NULL;      -- 명예퇴직 정산 시작일.   
      V_H_LONG_YEAR                                 := 0;         -- 명예퇴직 근속년수.
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;
      V_H_INCOME_DED_AMOUNT                         := 0;         -- 퇴직소득공제
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;         -- 근속년수에 따른 소득공제
      V_H_TAX_STD_AMOUNT                            := 0;         -- 과세표준
      V_H_AVG_TAX_STD_AMOUNT                        := 0;         -- 년평균과세표준
      V_H_AVG_COMP_TAX_AMOUNT                       := 0;         -- 년평균 산출세액
      V_H_COMP_TAX_AMOUNT                           := 0;         -- 산출세액
      V_H_TAX_DED_AMOUNT                            := 0;         -- 퇴직소득세액공제
      V_H_IN_TAX_AMOUNT                             := 0;         -- 소득세
      V_H_LOCAL_TAX_AMOUNT                          := 0;         -- 주민세
      V_H_REAL_AMOUNT                               := 0;         -- 명예퇴직금.
      
      V_REAL_TOTAL_AMOUNT                           := 0;         -- 실 
      
      --> 퇴직금 계산
      V_REAL_DAY := NVL(C1.LONG_DAY, 0);
      V_RETR_AMOUNT := NVL(RETR_AMOUNT_F(W_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY), 0);

      --> 총퇴직금
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> 퇴직근로소득 산출
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> 근속에 따른 소득공제
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> 과세 표준
      V_TAX_STD_AMOUNT := V_TOTAL_RETR_AMOUNT - V_INCOME_DED_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;

      --> 년평균 과세표준
      V_AVG_TAX_STD_AMOUNT := TRUNC(V_TAX_STD_AMOUNT / C1.LONG_YEAR);

      --> 산출세액
      V_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT);

      --> 산출세액
      V_COMP_TAX_AMOUNT := V_AVG_COMP_TAX_AMOUNT * C1.LONG_YEAR;

      --> 소득세액공제
      V_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT, C1.LONG_YEAR);

      --> 소득세
      V_IN_TAX_AMOUNT := TRUNC(V_COMP_TAX_AMOUNT - V_TAX_DED_AMOUNT, -1);   -- 무조건 버림
      IF V_IN_TAX_AMOUNT < 0 THEN
        V_IN_TAX_AMOUNT := 0;
      END IF;

      --> 주민세
      V_LOCAL_TAX_AMOUNT := TRUNC(V_IN_TAX_AMOUNT * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100), -1);   -- 무조건 버림

      --> 실지급액 (총퇴직금 - 주민세 - 소득세 - 기타공제 - 퇴직전환금)
      V_REAL_AMOUNT := V_TOTAL_RETR_AMOUNT - V_IN_TAX_AMOUNT - V_LOCAL_TAX_AMOUNT;
      IF V_REAL_AMOUNT < 0 THEN
        V_REAL_AMOUNT := 0;
      END IF;
      
------------------------------------------------------------------------------
-- 5. 명예 퇴직금 계산.
      IF C1.HONORARY_AMOUNT > 0 THEN
        V_H_RETIRE_DATE_FR := C1.JOIN_DATE;
        V_H_RETIRE_DATE_TO := W_RETIRE_DATE_TO;
        
        --> 5.1 근속년수
        BEGIN
          V_H_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, V_H_RETIRE_DATE_TO, 'CEIL');          
          IF V_H_RETIRE_DATE_FR = W_RETIRE_DATE_FR THEN
            V_H_PRE_LONG_YEAR := V_H_LONG_YEAR;
          ELSE
            V_H_PRE_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, W_RETIRE_DATE_FR - 1, 'CEIL');
          END IF;
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Honorary - Long Period Calculation Error : ' || SQLERRM;
          RETURN;
        END;
        
        --> 퇴직근로소득 산출
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 근속에 따른 소득공제(전체 근속에 대한 금액).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 근속부터 중도정산 이전까지의 근속 소득공제.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
        -- 실제 근속 소득공제금액.
        V_H_LONG_DED_YEAR_AMOUNT := V_H_LONG_DED_YEAR_AMOUNT - V_TEMP_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
        IF V_H_LONG_DED_YEAR_AMOUNT < 0 THEN
          V_H_LONG_DED_YEAR_AMOUNT := 0;
        END IF;
        
        --> 과세 표준
        V_H_TAX_STD_AMOUNT := C1.HONORARY_AMOUNT - V_H_INCOME_DED_AMOUNT - V_H_LONG_DED_YEAR_AMOUNT;
        IF V_H_TAX_STD_AMOUNT < 0 THEN
          V_H_TAX_STD_AMOUNT := 0;
        END IF;

        --> 년평균 과세표준
        V_H_AVG_TAX_STD_AMOUNT := TRUNC(V_H_TAX_STD_AMOUNT / V_H_LONG_YEAR);

        --> 산출세액
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> 산출세액
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> 소득세액공제
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> 소득세
        V_H_IN_TAX_AMOUNT := TRUNC(NVL(V_H_COMP_TAX_AMOUNT, 0) - NVL(V_H_TAX_DED_AMOUNT, 0), -1);   -- 무조건 버림
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> 주민세
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- 무조건 버림
        
        -- 실지급액.
        V_H_REAL_AMOUNT := NVL(C1.HONORARY_AMOUNT, 0) - NVL(V_H_IN_TAX_AMOUNT, 0) - NVL(V_H_LOCAL_TAX_AMOUNT, 0);
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
      END IF;
------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) + NVL(V_H_REAL_AMOUNT, 0) + 
                             (NVL(C1.ETC_SUPP_AMOUNT, 0) - NVL(C1.ETC_DED_AMOUNT, 0)) - NVL(C1.RETIRE_CVS_AMOUNT, 0);
      IF V_REAL_TOTAL_AMOUNT < 0 THEN
        V_REAL_TOTAL_AMOUNT := 0;
      END IF;

------------------------------------------------------------------------------
      --> 퇴직금 적용  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.RETIRE_AMOUNT          = V_RETR_AMOUNT
          , RA.RETIRE_TOTAL_AMOUNT    = V_TOTAL_RETR_AMOUNT
          , RA.INCOME_DED_AMOUNT      = V_INCOME_DED_AMOUNT
          , RA.LONG_DED_AMOUNT        = V_LONG_DED_YEAR_AMOUNT
          , RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT
          , RA.AVG_TAX_STD_AMOUNT     = V_AVG_TAX_STD_AMOUNT
          , RA.AVG_COMP_TAX_AMOUNT    = V_AVG_COMP_TAX_AMOUNT
          , RA.COMP_TAX_AMOUNT        = V_COMP_TAX_AMOUNT
          , RA.TAX_DED_AMOUNT         = V_TAX_DED_AMOUNT
          , RA.INCOME_TAX_AMOUNT      = V_IN_TAX_AMOUNT
          , RA.RESIDENT_TAX_AMOUNT    = V_LOCAL_TAX_AMOUNT
          , RA.REAL_AMOUNT            = V_REAL_AMOUNT
          , RA.H_RETIRE_DATE_FR       = V_H_RETIRE_DATE_FR
          , RA.H_RETIRE_DATE_TO       = V_H_RETIRE_DATE_TO
          , RA.H_LONG_YEAR            = V_H_LONG_YEAR
          , RA.H_INCOME_DED_AMOUNT    = V_H_INCOME_DED_AMOUNT
          , RA.H_LONG_DED_AMOUNT      = V_H_LONG_DED_YEAR_AMOUNT
          , RA.H_TAX_STD_AMOUNT       = V_H_TAX_STD_AMOUNT
          , RA.H_AVG_TAX_STD_AMOUNT   = V_H_AVG_TAX_STD_AMOUNT
          , RA.H_AVG_COMP_TAX_AMOUNT  = V_H_AVG_COMP_TAX_AMOUNT
          , RA.H_COMP_TAX_AMOUNT      = V_H_COMP_TAX_AMOUNT
          , RA.H_TAX_DED_AMOUNT       = V_H_TAX_DED_AMOUNT
          , RA.H_INCOME_TAX_AMOUNT    = V_H_IN_TAX_AMOUNT
          , RA.H_RESIDENT_TAX_AMOUNT  = V_H_LOCAL_TAX_AMOUNT
          , RA.H_REAL_AMOUNT          = V_H_REAL_AMOUNT
          , RA.REAL_TOTAL_AMOUNT      = V_REAL_TOTAL_AMOUNT
          , RA.LAST_UPDATE_DATE       = V_SYSDATE
          , RA.LAST_UPDATED_BY        = P_USER_ID
          , RA.AVG_TAX_STD_AMOUNT_1   = V_AVG_TAX_STD_AMOUNT
          , RA.AVG_COMP_TAX_AMOUNT_1  = V_AVG_COMP_TAX_AMOUNT
          , RA.COMP_TAX_AMOUNT_1      = V_COMP_TAX_AMOUNT
          , RA.TAX_DED_AMOUNT_1       = V_TAX_DED_AMOUNT
          , RA.INCOME_TAX_AMOUNT_1    = V_IN_TAX_AMOUNT
          , RA.RESIDENT_TAX_AMOUNT_1  = V_LOCAL_TAX_AMOUNT
          , RA.AVG_TAX_STD_AMOUNT_2   = 0 
          , RA.AVG_COMP_TAX_AMOUNT_2  = 0 
          , RA.COMP_TAX_AMOUNT_2      = 0 
          , RA.TAX_DED_AMOUNT_2       = 0 
          , RA.INCOME_TAX_AMOUNT_2    = 0 
          , RA.RESIDENT_TAX_AMOUNT_2  = 0 
      WHERE RA.ADJUSTMENT_ID          = W_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END CAL_RETIRE_2012;            

/*==========================================================================/
     ==> 퇴직정산 계산 
       -. 2013년도 까지 적용 
       -. 월단위 급여를 다시 산출하여 반영
       -. 상여금은 기지급된 내용을 반영
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2013
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_REAL_LONG_YEAR                    IN NUMBER 
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    
    V_TEMP_DATE                                   DATE;           -- 임시 일자.
    V_3RD_DAY_COUNT                               NUMBER;         -- 3개월 총일수 (급여일수)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3개월 총일수 (상여연차일수)
    V_CHANGE_DAY                                  NUMBER;         -- 가감일수.
    V_REAL_DAY                                    NUMBER;         -- 실제 적용되는 근무일수
    V_RETR_AMOUNT                                 NUMBER;         -- 퇴직금
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- 총퇴직금
    V_REAL_AMOUNT                                 NUMBER;         -- 실퇴직금        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- 퇴직소득공제
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- 근속년수에 따른 소득공제    
    V_TAX_STD_AMOUNT                              NUMBER;         -- 과세표준
    
    V_TAX_STD_AMOUNT_1                            NUMBER;         -- 과세표준 안부 2012년 12월 31일 이전 (과세표준 / 정산근속연수 * 각 근속연수)<2014 추가>  
    V_TAX_STD_AMOUNT_2                            NUMBER;         -- 과세표준 안부 2013년 1월 1일 이후 (과세표준 / 정산근속연수 * 각 근속연수)<2014 추가>   
    
    V_AVG_TAX_STD_AMOUNT_1                        NUMBER;         -- 년평균과세표준
    V_AVG_COMP_TAX_AMOUNT_1                       NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT_1                           NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT_1                            NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT_1                             NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT_1                          NUMBER;         -- 주민세
    
    V_AVG_TAX_STD_AMOUNT_2                        NUMBER;         -- 년평균과세표준
    V_CHG_TAX_STD_AMOUNT_2                        NUMBER;         -- 환산과세표준<2014 추가> 
    V_CHG_COMP_TAX_AMOUNT_2                       NUMBER;         -- 환산산출세액<2014 추가>  
    V_AVG_COMP_TAX_AMOUNT_2                       NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT_2                           NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT_2                            NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT_2                             NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT_2                          NUMBER;         -- 주민세
    
    V_H_RETIRE_DATE_FR                            DATE;           -- 명예퇴직 정산 시작일.
    V_H_RETIRE_DATE_TO                            DATE;           -- 명예퇴직 정산 종료일.
    V_H_LONG_YEAR                                 NUMBER;         -- 명예퇴직 근속년수.
    V_H_PRE_LONG_YEAR                             NUMBER;         -- 명예퇴직부터 중도정산 이전 근속년수.
    V_H_INCOME_DED_AMOUNT                         NUMBER;         -- 퇴직소득공제
    V_H_LONG_DED_YEAR_AMOUNT                      NUMBER;         -- 근속년수에 따른 소득공제    
    V_H_TAX_STD_AMOUNT                            NUMBER;         -- 과세표준
    V_H_AVG_TAX_STD_AMOUNT                        NUMBER;         -- 년평균과세표준
    V_H_AVG_COMP_TAX_AMOUNT                       NUMBER;         -- 년평균 산출세액
    V_H_COMP_TAX_AMOUNT                           NUMBER;         -- 산출세액
    V_H_TAX_DED_AMOUNT                            NUMBER;         -- 퇴직소득세액공제
    V_H_IN_TAX_AMOUNT                             NUMBER;         -- 소득세
    V_H_LOCAL_TAX_AMOUNT                          NUMBER;         -- 주민세
    V_H_REAL_AMOUNT                               NUMBER;         -- 명예퇴직금.
    
    V_REAL_TOTAL_AMOUNT                           NUMBER;         -- 실 총퇴직금.
    V_TEMP_AMOUNT                                 NUMBER;         -- 임시 변수.
    
  BEGIN
    O_STATUS := 'F';
    
--. 매월 말일 퇴사일 경우 3개월 이전 1일 기준 그외에는 ADD_MONTHS(기준일, -3)
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
      V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;
    ELSE
      BEGIN
        SELECT RA.DAY_3RD_COUNT
          INTO V_3RD_DAY_COUNT
          FROM HRR_RETIRE_ADJUSTMENT RA
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
      END;  
      V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;
    END IF;
    
    --> 가감일수 적용.
    BEGIN
      SELECT RA.DED_DAY * -1 AS DED_DAY
        INTO V_CHANGE_DAY
        FROM HRR_RETIRE_ADJUSTMENT RA
       WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CHANGE_DAY := 0;
    END;
    
    --> 1.3 근속년수, 근속월수, 근속일수 계산  
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR   = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
        , RA.LONG_MONTH  = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
        , RA.LONG_DAY    = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 1)        
        , RA.DAY_3RD_COUNT = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
    --> 1.3.1 2012년도 까지의 근속년수, 근속월수, 근속일수 계산  
    V_TEMP_DATE := TO_DATE('2012-12-31', 'YYYY-MM-DD');
    IF W_RETIRE_DATE_FR <= V_TEMP_DATE THEN
      IF W_RETIRE_DATE_TO < V_TEMP_DATE THEN
        V_TEMP_DATE := W_RETIRE_DATE_TO;  
      END IF;    
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET RA.LONG_YEAR_1  = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 'CEIL')
            , RA.LONG_MONTH_1 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 'CEIL')
            , RA.LONG_DAY_1   = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 1)        
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '1.3.1 Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RETURN;
      END;
    END IF;
    
    --> 1.3.2 2013년도 까지의 근속년수, 근속월수, 근속일수 계산  
    V_TEMP_DATE := TO_DATE('2013-01-01', 'YYYY-MM-DD');
    IF V_TEMP_DATE <= W_RETIRE_DATE_FR THEN
      V_TEMP_DATE := W_RETIRE_DATE_FR; 
    END IF;      
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR_2  = NVL(RA.LONG_YEAR, 0) - NVL(RA.LONG_YEAR_1 ,0) 
        , RA.LONG_MONTH_2 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY_2   = HRM_COMMON_DATE_G.PERIOD_DAY_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 1)        
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
      /* -- 2014.7.16 전호수 주석 -- 
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR_2 = HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_TEMP_DATE, W_RETIRE_DATE_TO , 'CEIL')
        , RA.LONG_MONTH_2 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY_2 = HRM_COMMON_DATE_G.PERIOD_DAY_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 1)        
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;*/
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := '1.3.2 Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
--> 3개월 급여 계산 : 1년 미만자도 계산되게 수정 --
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 명절상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 특별상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P5'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );       
                                            
      --> 년차합계.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.YEAR_ALLOWANCE_AMOUNT)
            = NVL(
              ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS YEAR_ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                   , HRP_MONTH_ALLOWANCE MA
                   , HRM_ALLOWANCE_V HA
                WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                  AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                  AND MP.PAY_YYYYMM              = TO_CHAR(TRUNC(RA.RETIRE_DATE_TO, 'YEAR'), 'YYYY-MM')
                  AND MP.PERSON_ID               = RA.PERSON_ID
                  AND MP.SOB_ID                  = RA.SOB_ID
                  AND MP.ORG_ID                  = RA.ORG_ID
                  AND HA.ALLOWANCE_TYPE          IN('YEAR')
                  AND HA.RETIRE_YN               = 'Y'
                GROUP BY MP.PERSON_ID
               ), 0)
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;
    END IF;

    BEGIN
      --> 급/상여 적용 계산.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.TOTAL_PAY_AMOUNT, RA.TOTAL_BONUS_AMOUNT)
            = (SELECT NVL(SUM(DECODE(RAP.WAGE_TYPE, 'P1', RAP.TOTAL_AMOUNT, 0)), 0) AS PAY_TOTAL_AMOUNT
                   , NVL(SUM(CASE
                               WHEN RAP.WAGE_TYPE IN('P2', 'P3', 'P5') THEN RAP.TOTAL_AMOUNT
                               ELSE 0
                             END), 0) AS BONUS_TOTAL_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT_PAYMENT RAP
               WHERE RAP.ADJUSTMENT_ID          = RA.ADJUSTMENT_ID
                 AND RAP.WAGE_TYPE              IN('P1', 'P2', 'P3', 'P5')    -- P1-급여, P2-상여, P3-명절상여, P5-특별상여.
               ) 
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;

       --> 일평균금액 산출
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = W_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SQLERRM;      
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    /*
    --> 기타지급/기타공제 UPDATE.
    BEGIN
      -- 기타지급/공제 UPDATE --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET (RA.ETC_SUPP_AMOUNT
            , RA.ETC_DED_AMOUNT
              ) =
              ( SELECT NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'A', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_SUPP_AMOUNT
                     , NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'D', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_DED_AMOUNT
                  FROM HRR_ETC_ALLOWANCE EA
                 WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
              )
       WHERE RA.ADJUSTMENT_ID       = W_ADJUSTMENT_ID
         AND EXISTS
               ( SELECT 'X'
                   FROM HRR_ETC_ALLOWANCE EA
                  WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
               )
       ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;*/
    
    --> 퇴직정산을 위한 기초 정보
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT
                    , NVL(RA.INCOME_DED_AMOUNT, 0) AS INCOME_DED_AMOUNT
                    , NVL(RA.LONG_DED_AMOUNT , 0) AS LONG_DED_AMOUNT
                    , NVL(RA.TAX_STD_AMOUNT, 0) AS TAX_STD_AMOUNT
                    , NVL(RA.AVG_TAX_STD_AMOUNT, 0) AS AVG_TAX_STD_AMOUNT
                    , NVL(RA.AVG_COMP_TAX_AMOUNT, 0) AS AVG_COMP_TAX_AMOUNT
                    , NVL(RA.COMP_TAX_AMOUNT, 0) AS COMP_TAX_AMOUNT
                    , NVL(RA.TAX_DED_AMOUNT, 0) AS TAX_DED_AMOUNT
                    , NVL(RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
                    , NVL(RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                    , NVL(RA.HEALTH_INSUR_AMOUNT, 0) AS HEALTH_INSUR_AMOUNT
                    , NVL(RA.LONG_YEAR_1, 0) AS LONG_YEAR_1
                    , NVL(RA.LONG_MONTH_1, 0) AS LONG_MONTH_1
                    , NVL(RA.LONG_DAY_1, 0) AS LONG_DAY_1
                    , NVL(RA.LONG_YEAR_2, 0) AS LONG_YEAR_2
                    , NVL(RA.LONG_MONTH_2, 0) AS LONG_MONTH_2
                    , NVL(RA.LONG_DAY_2, 0) AS LONG_DAY_2
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
               )
    LOOP
      --> 초기화
      V_REAL_DAY := 0;                  -- 실제 근속일수
      V_RETR_AMOUNT := 0;               -- 퇴직금
      V_TOTAL_RETR_AMOUNT := 0;         -- 총퇴직금 합계
      
      V_INCOME_DED_AMOUNT := 0;         -- 퇴직소득공제
      V_LONG_DED_YEAR_AMOUNT := 0;      -- 근속년수에 따른 소득공제
      V_TAX_STD_AMOUNT := 0;            -- 과세표준      
      V_TAX_STD_AMOUNT_1 := 0;          -- 과세표준 안부 2012년 12월 31일 이전 (과세표준 / 정산근속연수 * 각 근속연수) 
      V_TAX_STD_AMOUNT_2 := 0;          -- 과세표준 안부 2013년 1월 1일 이후 (과세표준 / 정산근속연수 * 각 근속연수) 
      
      V_AVG_TAX_STD_AMOUNT_1 := 0;      -- 년평균 과세표준
      V_AVG_COMP_TAX_AMOUNT_1 := 0;     -- 년평균 산출세액
      V_COMP_TAX_AMOUNT_1 := 0;         -- 산출세액
      V_TAX_DED_AMOUNT_1 := 0;          -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT_1 := 0;           -- 소득세
      V_LOCAL_TAX_AMOUNT_1 := 0;        -- 주민세
      
      V_AVG_TAX_STD_AMOUNT_2 := 0;      -- 년평균 과세표준
      V_CHG_TAX_STD_AMOUNT_2 := 0;      -- 환산 과세표준<2014 추가>  
      V_CHG_COMP_TAX_AMOUNT_2 := 0;     -- 환산 산출세액<2014 추가>  
      V_AVG_COMP_TAX_AMOUNT_2 := 0;     -- 년평균 산출세액
      V_COMP_TAX_AMOUNT_2 := 0;         -- 산출세액
      V_TAX_DED_AMOUNT_2 := 0;          -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT_2 := 0;           -- 소득세
      V_LOCAL_TAX_AMOUNT_2 := 0;        -- 주민세
      
      V_REAL_AMOUNT := 0;               -- 실퇴직금

      V_H_RETIRE_DATE_FR                            := NULL;      -- 명예퇴직 정산 시작일.   
      V_H_LONG_YEAR                                 := 0;         -- 명예퇴직 근속년수.
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;
      V_H_INCOME_DED_AMOUNT                         := 0;         -- 퇴직소득공제
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;         -- 근속년수에 따른 소득공제
      V_H_TAX_STD_AMOUNT                            := 0;         -- 과세표준
      V_H_AVG_TAX_STD_AMOUNT                        := 0;         -- 년평균과세표준
      V_H_AVG_COMP_TAX_AMOUNT                       := 0;         -- 년평균 산출세액
      V_H_COMP_TAX_AMOUNT                           := 0;         -- 산출세액
      V_H_TAX_DED_AMOUNT                            := 0;         -- 퇴직소득세액공제
      V_H_IN_TAX_AMOUNT                             := 0;         -- 소득세
      V_H_LOCAL_TAX_AMOUNT                          := 0;         -- 주민세
      V_H_REAL_AMOUNT                               := 0;         -- 명예퇴직금.
      
      V_REAL_TOTAL_AMOUNT                           := 0;         -- 실 
      
      --> 퇴직금 계산
      V_REAL_DAY := NVL(C1.LONG_DAY, 0);
      V_RETR_AMOUNT := NVL(RETR_AMOUNT_F(W_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY), 0);

      --> 총퇴직금
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0) + NVL(C1.ETC_SUPP_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> 퇴직근로소득 산출
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> 근속에 따른 소득공제
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> 과세 표준
      V_TAX_STD_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0) - NVL(V_INCOME_DED_AMOUNT, 0) - NVL(V_LONG_DED_YEAR_AMOUNT, 0);
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;
      
      --> 과세표준 안분 
      V_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT / (NVL(C1.LONG_YEAR_1, 0) + NVL(C1.LONG_YEAR_2, 0)) * NVL(C1.LONG_YEAR_1, 0));
      V_TAX_STD_AMOUNT_2 := V_TAX_STD_AMOUNT - V_TAX_STD_AMOUNT_1;
      IF V_TAX_STD_AMOUNT != V_TAX_STD_AMOUNT_1 + V_TAX_STD_AMOUNT_2 THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Tax STD Division Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
        RETURN;
      END IF;
      
      
      -- 년도별 소득세 계산 --
      V_REAL_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0);
      IF NVL(C1.LONG_YEAR_1, 0) > 0 THEN
        -- 2102년도 까지 세액 계산 --
        BEGIN
          --> 년평균 과세표준(퇴직일자까지 근속년수 적용)  
          --> (과세표준 / (총근속년수) * 12년도까지 근속년수) / 12년도까지 근속년수  
          
          -- 12년도까지 년평균과세표준 금액 계산  
          V_AVG_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT_1 / NVL(C1.LONG_YEAR_1, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := 'Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
            RETURN;
        END;

        --> 산출세액
        V_AVG_COMP_TAX_AMOUNT_1 := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT_1);

        --> 산출세액
        V_COMP_TAX_AMOUNT_1 := TRUNC(V_AVG_COMP_TAX_AMOUNT_1 * C1.LONG_YEAR_1);

        --> 소득세액공제
        V_TAX_DED_AMOUNT_1 := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT_1, C1.LONG_YEAR_1);

        --> 소득세
        V_IN_TAX_AMOUNT_1 := TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0) - NVL(V_TAX_DED_AMOUNT_1, 0));   -- 무조건 버림
        IF V_IN_TAX_AMOUNT_1 < 0 THEN
          V_IN_TAX_AMOUNT_1 := 0;
        END IF;

        --> 주민세
        V_LOCAL_TAX_AMOUNT_1 := TRUNC(V_IN_TAX_AMOUNT_1 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- 무조건 버림
      END IF;
      
      IF NVL(C1.LONG_YEAR_2, 0) > 0 THEN
        -- 2103년도 부터 세액 계산 --
        BEGIN
          --> 년평균 과세표준(퇴직일자까지 근속년수 적용)  
          -- 13년도 과세표준 금액 산정 --
          --> (안분과세표준 / 근속연수)  
          V_AVG_TAX_STD_AMOUNT_2 := TRUNC(NVL(V_TAX_STD_AMOUNT_2, 0) / NVL(C1.LONG_YEAR_2, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := 'Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
            RETURN;
        END;
        
        --> 환산 과세표준(연평균과세표준 * 5)  
        V_CHG_TAX_STD_AMOUNT_2 := V_AVG_TAX_STD_AMOUNT_2 * 5;
        
        --> 환산산출세액(환산과세표준 * 세율)  
        V_CHG_COMP_TAX_AMOUNT_2 := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_CHG_TAX_STD_AMOUNT_2);
        
        --> 연평균산출세액(환산산출세액 / 5)
        V_AVG_COMP_TAX_AMOUNT_2 := TRUNC(V_CHG_COMP_TAX_AMOUNT_2 / 5);

        --> 소득세액공제
        V_TAX_DED_AMOUNT_2 := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_AVG_COMP_TAX_AMOUNT_2, C1.LONG_YEAR_2);

        --> 산출세액(연평균산출세액 * 근속연수) 
        V_COMP_TAX_AMOUNT_2 := TRUNC(V_AVG_COMP_TAX_AMOUNT_2 * C1.LONG_YEAR_2);
        
        --> 소득세
        V_IN_TAX_AMOUNT_2 := TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0) - NVL(V_TAX_DED_AMOUNT_2, 0));   -- 무조건 버림
        
        -- 2013-07-13 START OF MODIFY --
        -- 전호수 추가 : 원단위 보정(2012년/2013년 분할계산으로 인해 소득세 합계와 원단위 차액 발생) --
        V_TEMP_AMOUNT :=0;
        V_TEMP_AMOUNT := TRUNC((NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0))) - 
                         (TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0)) + TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0)));
        IF NVL(V_TEMP_AMOUNT, 0) != 0 THEN
          V_IN_TAX_AMOUNT_2 := NVL(V_IN_TAX_AMOUNT_2, 0) + NVL(V_TEMP_AMOUNT, 0);
        END IF;
        --> 2013-07-13 END OF MODIFY  -- 
        IF V_IN_TAX_AMOUNT_2 < 0 THEN
          V_IN_TAX_AMOUNT_2 := 0;
        END IF;
        
        --> 주민세
        V_LOCAL_TAX_AMOUNT_2 := TRUNC(V_IN_TAX_AMOUNT_2 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- 무조건 버림
      END IF;
      
      -- 실지급액 계산 -- 
      --> 실지급액 (총퇴직금 - 주민세 - 소득세 - 기타공제 - 퇴직전환금)
      V_REAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) - TRUNC(NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0), -1) 
                                             - TRUNC(NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0), -1);
      IF V_REAL_AMOUNT < 0 THEN
        V_REAL_AMOUNT := 0;
      END IF;
      
------------------------------------------------------------------------------
-- 5. 명예 퇴직금 계산.
      IF C1.HONORARY_AMOUNT > 0 THEN
        V_H_RETIRE_DATE_FR := C1.JOIN_DATE;
        V_H_RETIRE_DATE_TO := W_RETIRE_DATE_TO;
        
        --> 5.1 근속년수
        BEGIN
          V_H_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, V_H_RETIRE_DATE_TO, 'CEIL');          
          IF V_H_RETIRE_DATE_FR = W_RETIRE_DATE_FR THEN
            V_H_PRE_LONG_YEAR := V_H_LONG_YEAR;
          ELSE
            V_H_PRE_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, W_RETIRE_DATE_FR - 1, 'CEIL');
          END IF;
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Honorary - Long Period Calculation Error : ' || SQLERRM;
          RETURN;
        END;
        
        --> 퇴직근로소득 산출
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 근속에 따른 소득공제(전체 근속에 대한 금액).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 근속부터 중도정산 이전까지의 근속 소득공제.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
        -- 실제 근속 소득공제금액.
        V_H_LONG_DED_YEAR_AMOUNT := V_H_LONG_DED_YEAR_AMOUNT - V_TEMP_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
        IF V_H_LONG_DED_YEAR_AMOUNT < 0 THEN
          V_H_LONG_DED_YEAR_AMOUNT := 0;
        END IF;
        
        --> 과세 표준
        V_H_TAX_STD_AMOUNT := C1.HONORARY_AMOUNT - V_H_INCOME_DED_AMOUNT - V_H_LONG_DED_YEAR_AMOUNT;
        IF V_H_TAX_STD_AMOUNT < 0 THEN
          V_H_TAX_STD_AMOUNT := 0;
        END IF;

        --> 년평균 과세표준
        V_H_AVG_TAX_STD_AMOUNT := TRUNC(V_H_TAX_STD_AMOUNT / V_H_LONG_YEAR);

        --> 산출세액
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> 산출세액
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> 소득세액공제
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> 소득세
        V_H_IN_TAX_AMOUNT := TRUNC(NVL(V_H_COMP_TAX_AMOUNT, 0) - NVL(V_H_TAX_DED_AMOUNT, 0), -1);   -- 무조건 버림
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> 주민세
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- 무조건 버림
        
        -- 실지급액.
        V_H_REAL_AMOUNT := NVL(C1.HONORARY_AMOUNT, 0) - TRUNC(NVL(V_H_IN_TAX_AMOUNT, 0), -1) - TRUNC(NVL(V_H_LOCAL_TAX_AMOUNT, 0), -1);
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
      END IF;
------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) + NVL(V_H_REAL_AMOUNT, 0) - 
                             NVL(C1.ETC_DED_AMOUNT, 0) - NVL(C1.HEALTH_INSUR_AMOUNT, 0) - 
                             NVL(C1.RETIRE_CVS_AMOUNT, 0);
      IF V_REAL_TOTAL_AMOUNT < 0 THEN
        V_REAL_TOTAL_AMOUNT := 0;
      END IF;

------------------------------------------------------------------------------
      --> 퇴직금 적용  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.RETIRE_AMOUNT          = V_RETR_AMOUNT
          , RA.RETIRE_TOTAL_AMOUNT    = V_TOTAL_RETR_AMOUNT
          , RA.INCOME_DED_AMOUNT      = V_INCOME_DED_AMOUNT
          , RA.LONG_DED_AMOUNT        = V_LONG_DED_YEAR_AMOUNT
          , RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT 
          , RA.TAX_STD_AMOUNT_1       = V_TAX_STD_AMOUNT_1  -- 전호수 추가 
          , RA.TAX_STD_AMOUNT_2       = V_TAX_STD_AMOUNT_2  -- 전호수 추가 
          , RA.AVG_TAX_STD_AMOUNT     = (NVL(V_AVG_TAX_STD_AMOUNT_1, 0) + NVL(V_AVG_TAX_STD_AMOUNT_2, 0)) 
          , RA.AVG_COMP_TAX_AMOUNT    = (NVL(V_AVG_COMP_TAX_AMOUNT_1, 0) + NVL(V_AVG_COMP_TAX_AMOUNT_2, 0)) 
          , RA.COMP_TAX_AMOUNT        = (NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0)) 
          , RA.TAX_DED_AMOUNT         = (NVL(V_TAX_DED_AMOUNT_1, 0) + NVL(V_TAX_DED_AMOUNT_2, 0)) 
          , RA.INCOME_TAX_AMOUNT      = (NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0)) 
          , RA.RESIDENT_TAX_AMOUNT    = (NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0)) 
          , RA.REAL_AMOUNT            = V_REAL_AMOUNT
          , RA.H_RETIRE_DATE_FR       = V_H_RETIRE_DATE_FR
          , RA.H_RETIRE_DATE_TO       = V_H_RETIRE_DATE_TO
          , RA.H_LONG_YEAR            = V_H_LONG_YEAR
          , RA.H_INCOME_DED_AMOUNT    = V_H_INCOME_DED_AMOUNT
          , RA.H_LONG_DED_AMOUNT      = V_H_LONG_DED_YEAR_AMOUNT
          , RA.H_TAX_STD_AMOUNT       = V_H_TAX_STD_AMOUNT
          , RA.H_AVG_TAX_STD_AMOUNT   = V_H_AVG_TAX_STD_AMOUNT
          , RA.H_AVG_COMP_TAX_AMOUNT  = V_H_AVG_COMP_TAX_AMOUNT
          , RA.H_COMP_TAX_AMOUNT      = V_H_COMP_TAX_AMOUNT
          , RA.H_TAX_DED_AMOUNT       = V_H_TAX_DED_AMOUNT
          , RA.H_INCOME_TAX_AMOUNT    = V_H_IN_TAX_AMOUNT
          , RA.H_RESIDENT_TAX_AMOUNT  = V_H_LOCAL_TAX_AMOUNT
          , RA.H_REAL_AMOUNT          = V_H_REAL_AMOUNT
          , RA.REAL_TOTAL_AMOUNT      = V_REAL_TOTAL_AMOUNT
          , RA.LAST_UPDATE_DATE       = V_SYSDATE
          , RA.LAST_UPDATED_BY        = P_USER_ID
          , RA.AVG_TAX_STD_AMOUNT_1   = V_AVG_TAX_STD_AMOUNT_1
          , RA.AVG_COMP_TAX_AMOUNT_1  = V_AVG_COMP_TAX_AMOUNT_1
          , RA.COMP_TAX_AMOUNT_1      = V_COMP_TAX_AMOUNT_1
          , RA.TAX_DED_AMOUNT_1       = V_TAX_DED_AMOUNT_1
          , RA.INCOME_TAX_AMOUNT_1    = V_IN_TAX_AMOUNT_1
          , RA.RESIDENT_TAX_AMOUNT_1  = V_LOCAL_TAX_AMOUNT_1
          , RA.AVG_TAX_STD_AMOUNT_2   = V_AVG_TAX_STD_AMOUNT_2 
          
          , RA.CHG_TAX_STD_AMOUNT_2   = V_CHG_TAX_STD_AMOUNT_2  -- <2014 추가> 
          , RA.CHG_COMP_TAX_AMOUNT_2  = V_CHG_COMP_TAX_AMOUNT_2 -- <2014 추가> 
          
          , RA.AVG_COMP_TAX_AMOUNT_2  = V_AVG_COMP_TAX_AMOUNT_2 
          , RA.COMP_TAX_AMOUNT_2      = V_COMP_TAX_AMOUNT_2 
          , RA.TAX_DED_AMOUNT_2       = V_TAX_DED_AMOUNT_2 
          , RA.INCOME_TAX_AMOUNT_2    = V_IN_TAX_AMOUNT_2 
          , RA.RESIDENT_TAX_AMOUNT_2  = V_LOCAL_TAX_AMOUNT_2 
      WHERE RA.ADJUSTMENT_ID          = W_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END CAL_RETIRE_2013;
            
/*==========================================================================/
     ==> 퇴직정산 계산 
       -. 2016년도 이후 적용 
/==========================================================================*/
  PROCEDURE CAL_RETIRE_2016
            ( W_ADJUSTMENT_ID                     IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_ID%TYPE
            , W_RETR_YYYY                         IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_YYYY%TYPE
            , W_ADJUSTMENT_TYPE                   IN HRR_RETIRE_ADJUSTMENT.ADJUSTMENT_TYPE%TYPE
            , W_REAL_LONG_YEAR                    IN NUMBER 
            , W_RETIRE_DATE_FR                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_FR%TYPE
            , W_RETIRE_DATE_TO                    IN HRR_RETIRE_ADJUSTMENT.RETIRE_DATE_TO%TYPE
            , W_PAY_DATE_TO                       IN HRR_RETIRE_ADJUSTMENT.PAY_DATE_TO%TYPE
            , W_RETIRE_CAL_TYPE                   IN VARCHAR2
            , W_CORP_ID                           IN HRR_RETIRE_ADJUSTMENT.CORP_ID%TYPE
            , W_PERSON_ID                         IN HRR_RETIRE_ADJUSTMENT.PERSON_ID%TYPE
            , W_SOB_ID                            IN HRR_RETIRE_ADJUSTMENT.SOB_ID%TYPE
            , W_ORG_ID                            IN HRR_RETIRE_ADJUSTMENT.ORG_ID%TYPE
            , P_USER_ID                           IN HRR_RETIRE_ADJUSTMENT.CREATED_BY%TYPE
            , O_STATUS                            OUT VARCHAR2
            , O_MESSAGE                           OUT VARCHAR2
            )
  AS
    V_SYSDATE                                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    
    V_TEMP_DATE                                   DATE;           -- 임시 일자.
    V_3RD_DAY_COUNT                               NUMBER;         -- 3개월 총일수 (급여일수)
    V_3RD_DAY_COUNT2                              NUMBER;         -- 3개월 총일수 (상여연차일수)
    V_CHANGE_DAY                                  NUMBER;         -- 가감일수.
    V_REAL_DAY                                    NUMBER;         -- 실제 적용되는 근무일수
    V_RETR_AMOUNT                                 NUMBER;         -- 퇴직금
    V_TOTAL_RETR_AMOUNT                           NUMBER;         -- 총퇴직금
    V_REAL_AMOUNT                                 NUMBER;         -- 실퇴직금        
    V_INCOME_DED_AMOUNT                           NUMBER;         -- 퇴직소득공제
    V_LONG_DED_YEAR_AMOUNT                        NUMBER;         -- 근속년수에 따른 소득공제    
    V_TAX_STD_AMOUNT                              NUMBER;         -- 과세표준
    
    V_TAX_STD_AMOUNT_1                            NUMBER;         -- 과세표준 안부 2012년 12월 31일 이전 (과세표준 / 정산근속연수 * 각 근속연수)<2014 추가>  
    V_TAX_STD_AMOUNT_2                            NUMBER;         -- 과세표준 안부 2013년 1월 1일 이후 (과세표준 / 정산근속연수 * 각 근속연수)<2014 추가>   
    
    V_AVG_TAX_STD_AMOUNT_1                        NUMBER;         -- 년평균과세표준
    V_AVG_COMP_TAX_AMOUNT_1                       NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT_1                           NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT_1                            NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT_1                             NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT_1                          NUMBER;         -- 주민세
    
    V_AVG_TAX_STD_AMOUNT_2                        NUMBER;         -- 년평균과세표준
    V_CHG_TAX_STD_AMOUNT_2                        NUMBER;         -- 환산과세표준<2014 추가> 
    V_CHG_COMP_TAX_AMOUNT_2                       NUMBER;         -- 환산산출세액<2014 추가>  
    V_AVG_COMP_TAX_AMOUNT_2                       NUMBER;         -- 년평균 산출세액
    V_COMP_TAX_AMOUNT_2                           NUMBER;         -- 산출세액
    V_TAX_DED_AMOUNT_2                            NUMBER;         -- 퇴직소득세액공제
    V_IN_TAX_AMOUNT_2                             NUMBER;         -- 소득세
    V_LOCAL_TAX_AMOUNT_2                          NUMBER;         -- 주민세
    
    V_LONG_YEAR_3	                                NUMBER;         -- 2016변경 : 근속년수
    V_LONG_MONTH_3	                              NUMBER;         -- 2016변경 : 근속월수
    V_LONG_DAY_3	                                NUMBER;         -- 2016변경 : 근속일수
    V_LONG_DED_AMOUNT_3	                          NUMBER;         -- 2016변경 : 근속공제
    V_CHG_STD_AMOUNT_3	                          NUMBER;         -- 2016변경 : 환산 급여금액
    V_CHG_DED_AMOUNT_3	                          NUMBER;         -- 2016변경 : 환산 공제액
    V_CHG_TAX_STD_AMOUNT_3	                      NUMBER;         -- 2016변경 : 환산 과세표준 
    V_CHG_COMP_TAX_AMOUNT_3	                      NUMBER;         -- 2016변경 : 환산세액
    V_COMP_TAX_AMOUNT_3	                          NUMBER;         -- 2016변경 : 산출세액
    
    V_REAL_PRE_COMP_TAX_RATE                      NUMBER;         -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
    V_REAL_NOW_COMP_TAX_RATE                      NUMBER;         -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
    
    V_REAL_PRE_COMP_TAX_AMOUNT                    NUMBER;         -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용된 금액 
    V_REAL_NOW_COMP_TAX_AMOUNT                    NUMBER;         -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용된 금액  
    V_REAL_COMP_TAX_AMOUNT_3 	                    NUMBER;         -- 2016변경 : 특례적용 산출금액
    V_PREPAID_TAX_AMOUNT_3	                      NUMBER;         -- 2016변경 : 기납부세액
    V_INCOME_TAX_AMOUNT_3	                        NUMBER;         -- 2016변경 : 소득세
    V_RESIDENT_TAX_AMOUNT_3	                      NUMBER;         -- 2016변경 : 주민세
    V_SP_TAX_AMOUNT_3	                            NUMBER;         -- 2016변경 : 농특세

    V_H_RETIRE_DATE_FR                            DATE;           -- 명예퇴직 정산 시작일.
    V_H_RETIRE_DATE_TO                            DATE;           -- 명예퇴직 정산 종료일.
    V_H_LONG_YEAR                                 NUMBER;         -- 명예퇴직 근속년수.
    V_H_PRE_LONG_YEAR                             NUMBER;         -- 명예퇴직부터 중도정산 이전 근속년수.
    V_H_INCOME_DED_AMOUNT                         NUMBER;         -- 퇴직소득공제
    V_H_LONG_DED_YEAR_AMOUNT                      NUMBER;         -- 근속년수에 따른 소득공제    
    V_H_TAX_STD_AMOUNT                            NUMBER;         -- 과세표준
    V_H_AVG_TAX_STD_AMOUNT                        NUMBER;         -- 년평균과세표준
    V_H_AVG_COMP_TAX_AMOUNT                       NUMBER;         -- 년평균 산출세액
    V_H_COMP_TAX_AMOUNT                           NUMBER;         -- 산출세액
    V_H_TAX_DED_AMOUNT                            NUMBER;         -- 퇴직소득세액공제
    V_H_IN_TAX_AMOUNT                             NUMBER;         -- 소득세
    V_H_LOCAL_TAX_AMOUNT                          NUMBER;         -- 주민세
    V_H_REAL_AMOUNT                               NUMBER;         -- 명예퇴직금.
    
    V_REAL_TOTAL_AMOUNT                           NUMBER;         -- 실 총퇴직금.
    V_TEMP_AMOUNT                                 NUMBER;         -- 임시 변수.
    
  BEGIN
    O_STATUS := 'F';
    
--. 매월 말일 퇴사일 경우 3개월 이전 1일 기준 그외에는 ADD_MONTHS(기준일, -3)
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
      V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;
    ELSE
      BEGIN
        SELECT RA.DAY_3RD_COUNT
          INTO V_3RD_DAY_COUNT
          FROM HRR_RETIRE_ADJUSTMENT RA
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        V_3RD_DAY_COUNT  := HRM_COMMON_DATE_G.RETIRE_DATE_3RD_DAY(W_RETIRE_DATE_TO, W_SOB_ID, W_ORG_ID);
      END;  
      V_3RD_DAY_COUNT2 := V_3RD_DAY_COUNT;
    END IF;
    
    --> 가감일수 적용.
    BEGIN
      SELECT RA.DED_DAY * -1 AS DED_DAY
        INTO V_CHANGE_DAY
        FROM HRR_RETIRE_ADJUSTMENT RA
       WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CHANGE_DAY := 0;
    END;
    
    --> 1.3 근속년수, 근속월수, 근속일수 계산  
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR   = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
        , RA.LONG_MONTH  = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 'CEIL')
        , RA.LONG_DAY    = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, (W_RETIRE_DATE_TO + NVL(V_CHANGE_DAY, 0)), 1)        
        , RA.DAY_3RD_COUNT = V_3RD_DAY_COUNT
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := 'Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
    --> 1.3.1 2012년도 까지의 근속년수, 근속월수, 근속일수 계산  
    V_TEMP_DATE := TO_DATE('2012-12-31', 'YYYY-MM-DD');
    IF W_RETIRE_DATE_FR <= V_TEMP_DATE THEN
      IF W_RETIRE_DATE_TO < V_TEMP_DATE THEN
        V_TEMP_DATE := W_RETIRE_DATE_TO;  
      END IF;    
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET RA.LONG_YEAR_1  = HRM_COMMON_DATE_G.PERIOD_YEAR_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 'CEIL')
            , RA.LONG_MONTH_1 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 'CEIL')
            , RA.LONG_DAY_1   = HRM_COMMON_DATE_G.PERIOD_DAY_F(W_RETIRE_DATE_FR, V_TEMP_DATE, 1)        
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_STATUS := 'F';
        O_MESSAGE := '1.3.1 Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        RETURN;
      END;
    END IF;
    
    --> 1.3.2 2013년도 까지의 근속년수, 근속월수, 근속일수 계산  
    V_TEMP_DATE := TO_DATE('2013-01-01', 'YYYY-MM-DD');
    IF V_TEMP_DATE <= W_RETIRE_DATE_FR THEN
      V_TEMP_DATE := W_RETIRE_DATE_FR; 
    END IF;      
    BEGIN
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR_2  = NVL(RA.LONG_YEAR, 0) - NVL(RA.LONG_YEAR_1 ,0) 
        , RA.LONG_MONTH_2 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY_2   = HRM_COMMON_DATE_G.PERIOD_DAY_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 1)        
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;
      /* -- 2014.7.16 전호수 주석 -- 
      UPDATE HRR_RETIRE_ADJUSTMENT RA
      SET RA.LONG_YEAR_2 = HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_TEMP_DATE, W_RETIRE_DATE_TO , 'CEIL')
        , RA.LONG_MONTH_2 = HRM_COMMON_DATE_G.PERIOD_MONTH_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 'CEIL')
        , RA.LONG_DAY_2 = HRM_COMMON_DATE_G.PERIOD_DAY_F(V_TEMP_DATE, W_RETIRE_DATE_TO, 1)        
      WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
      ;*/
    EXCEPTION WHEN OTHERS THEN
      O_STATUS := 'F';
      O_MESSAGE := '1.3.2 Long Period Calculation Error : ' || SUBSTR(SQLERRM, 1, 150);
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
      RETURN;
    END;
    
--> 3개월 급여 계산 : 1년 미만자도 계산되게 수정 --
    IF W_RETIRE_CAL_TYPE = 'NEW' THEN
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P1'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P2'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 명절상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P3'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );
--> 1년 특별상여 합 계산-
      HRR_RETIRE_PAYMENT_SET_G.PAYMENT_MAIN
                              ( P_ADJUSTMENT_ID => W_ADJUSTMENT_ID
                              , P_ADJUSTMENT_TYPE => W_ADJUSTMENT_TYPE
                              , P_CORP_ID => W_CORP_ID
                              , P_RETIRE_DATE_FR => W_RETIRE_DATE_FR
                              , P_RETIRE_DATE_TO => W_PAY_DATE_TO
                              , P_WAGE_TYPE => 'P5'
                              , P_PERSON_ID => W_PERSON_ID
                              , P_SOB_ID => W_SOB_ID
                              , P_ORG_ID => W_ORG_ID
                              , P_USER_ID => P_USER_ID
                              , O_MESSAGE => O_MESSAGE
                              );       
                                            
      --> 년차합계.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.YEAR_ALLOWANCE_AMOUNT)
            = NVL(
              ( SELECT NVL(SUM(MA.ALLOWANCE_AMOUNT), 0) AS YEAR_ALLOWANCE_AMOUNT
                  FROM HRP_MONTH_PAYMENT MP
                   , HRP_MONTH_ALLOWANCE MA
                   , HRM_ALLOWANCE_V HA
                WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
                  AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
                  AND MP.PAY_YYYYMM              = TO_CHAR(TRUNC(RA.RETIRE_DATE_TO, 'YEAR'), 'YYYY-MM')
                  AND MP.PERSON_ID               = RA.PERSON_ID
                  AND MP.SOB_ID                  = RA.SOB_ID
                  AND MP.ORG_ID                  = RA.ORG_ID
                  AND HA.ALLOWANCE_TYPE          IN('YEAR')
                  AND HA.RETIRE_YN               = 'Y'
                GROUP BY MP.PERSON_ID
               ), 0)
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Year Amount Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;
    END IF;

    BEGIN
      --> 급/상여 적용 계산.
      BEGIN
        UPDATE HRR_RETIRE_ADJUSTMENT RA
          SET (RA.TOTAL_PAY_AMOUNT, RA.TOTAL_BONUS_AMOUNT)
            = (SELECT NVL(SUM(DECODE(RAP.WAGE_TYPE, 'P1', RAP.TOTAL_AMOUNT, 0)), 0) AS PAY_TOTAL_AMOUNT
                   , NVL(SUM(CASE
                               WHEN RAP.WAGE_TYPE IN('P2', 'P3', 'P5') THEN RAP.TOTAL_AMOUNT
                               ELSE 0
                             END), 0) AS BONUS_TOTAL_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT_PAYMENT RAP
               WHERE RAP.ADJUSTMENT_ID          = RA.ADJUSTMENT_ID
                 AND RAP.WAGE_TYPE              IN('P1', 'P2', 'P3', 'P5')    -- P1-급여, P2-상여, P3-명절상여, P5-특별상여.
               ) 
        WHERE RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        O_MESSAGE := 'Pay Calculation Error : ' || SQLERRM;
        DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
        ROLLBACK;
        RETURN;
      END;

       --> 일평균금액 산출
       UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET RA.DAY_AVG_AMOUNT = TRUNC((RA.TOTAL_PAY_AMOUNT / DECODE(V_3RD_DAY_COUNT, 0, 1, V_3RD_DAY_COUNT)) 
                                    + ((RA.TOTAL_BONUS_AMOUNT + RA.YEAR_ALLOWANCE_AMOUNT) / 4 / DECODE(V_3RD_DAY_COUNT2, 0, 1, V_3RD_DAY_COUNT2)))
       WHERE RA.ADJUSTMENT_ID     = W_ADJUSTMENT_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      O_MESSAGE := 'Day Avg Amount Error : ' || SQLERRM;      
      DBMS_OUTPUT.PUT_LINE(O_MESSAGE);
    END;
    /*
    --> 기타지급/기타공제 UPDATE.
    BEGIN
      -- 기타지급/공제 UPDATE --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
         SET (RA.ETC_SUPP_AMOUNT
            , RA.ETC_DED_AMOUNT
              ) =
              ( SELECT NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'A', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_SUPP_AMOUNT
                     , NVL(SUM(DECODE(EA.ALLOWANCE_TYPE, 'D', EA.ALLOWANCE_AMOUNT, 0)), 0) AS ETC_DED_AMOUNT
                  FROM HRR_ETC_ALLOWANCE EA
                 WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
              )
       WHERE RA.ADJUSTMENT_ID       = W_ADJUSTMENT_ID
         AND EXISTS
               ( SELECT 'X'
                   FROM HRR_ETC_ALLOWANCE EA
                  WHERE EA.ADJUSTMENT_ID  = RA.ADJUSTMENT_ID
               )
       ;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;*/
    
    --> 퇴직정산을 위한 기초 정보
    FOR C1 IN (SELECT RA.RETIRE_DATE_FR
                    , RA.RETIRE_DATE_TO
                    , NVL(RA.LONG_YEAR, 0) AS LONG_YEAR
                    , NVL(RA.LONG_MONTH, 0) AS LONG_MONTH
                    , NVL(RA.LONG_DAY, 0) AS LONG_DAY
                    , NVL(RA.TOTAL_PAY_AMOUNT, 0) AS TOTAL_PAY_AMOUNT
                    , NVL(RA.TOTAL_BONUS_AMOUNT, 0) AS TOTAL_BONUS_AMOUNT
                    , NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) AS YEAR_ALLOWANCE_AMOUNT
                    , NVL(RA.DAY_AVG_AMOUNT, 0) AS DAY_AVG_AMOUNT
                    , NVL(RA.RETIRE_AMOUNT, 0) AS RETIRE_AMOUNT
                    , NVL(RA.GLORY_AMOUNT, 0) AS GLORY_AMOUNT
                    , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT
                    , NVL(RA.INCOME_DED_AMOUNT, 0) AS INCOME_DED_AMOUNT
                    , NVL(RA.LONG_DED_AMOUNT , 0) AS LONG_DED_AMOUNT
                    , NVL(RA.TAX_STD_AMOUNT, 0) AS TAX_STD_AMOUNT
                    , NVL(RA.AVG_TAX_STD_AMOUNT, 0) AS AVG_TAX_STD_AMOUNT
                    , NVL(RA.AVG_COMP_TAX_AMOUNT, 0) AS AVG_COMP_TAX_AMOUNT
                    , NVL(RA.COMP_TAX_AMOUNT, 0) AS COMP_TAX_AMOUNT
                    , NVL(RA.TAX_DED_AMOUNT, 0) AS TAX_DED_AMOUNT
                    , NVL(RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
                    , NVL(RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
                    , NVL(RA.RETIRE_CVS_AMOUNT, 0) AS RETIRE_CVS_AMOUNT
                    , NVL(RA.REAL_AMOUNT, 0) AS REAL_AMOUNT
                    , NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE) AS JOIN_DATE
                    , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT
                    , NVL(RA.ETC_SUPP_AMOUNT, 0) AS ETC_SUPP_AMOUNT
                    , NVL(RA.ETC_DED_AMOUNT, 0) AS ETC_DED_AMOUNT
                    , NVL(RA.HEALTH_INSUR_AMOUNT, 0) AS HEALTH_INSUR_AMOUNT
                    , NVL(RA.LONG_YEAR_1, 0) AS LONG_YEAR_1
                    , NVL(RA.LONG_MONTH_1, 0) AS LONG_MONTH_1
                    , NVL(RA.LONG_DAY_1, 0) AS LONG_DAY_1
                    , NVL(RA.LONG_YEAR_2, 0) AS LONG_YEAR_2
                    , NVL(RA.LONG_MONTH_2, 0) AS LONG_MONTH_2
                    , NVL(RA.LONG_DAY_2, 0) AS LONG_DAY_2
                 FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER PM
               WHERE RA.PERSON_ID          = PM.PERSON_ID
                 AND RA.ADJUSTMENT_ID      = W_ADJUSTMENT_ID
               )
    LOOP
      --> 초기화
      V_REAL_DAY := 0;                  -- 실제 근속일수
      V_RETR_AMOUNT := 0;               -- 퇴직금
      V_TOTAL_RETR_AMOUNT := 0;         -- 총퇴직금 합계
      
      V_INCOME_DED_AMOUNT := 0;         -- 퇴직소득공제
      V_LONG_DED_YEAR_AMOUNT := 0;      -- 근속년수에 따른 소득공제
      V_TAX_STD_AMOUNT := 0;            -- 과세표준      
      V_TAX_STD_AMOUNT_1 := 0;          -- 과세표준 안부 2012년 12월 31일 이전 (과세표준 / 정산근속연수 * 각 근속연수) 
      V_TAX_STD_AMOUNT_2 := 0;          -- 과세표준 안부 2013년 1월 1일 이후 (과세표준 / 정산근속연수 * 각 근속연수) 
      
      V_AVG_TAX_STD_AMOUNT_1 := 0;      -- 년평균 과세표준
      V_AVG_COMP_TAX_AMOUNT_1 := 0;     -- 년평균 산출세액
      V_COMP_TAX_AMOUNT_1 := 0;         -- 산출세액
      V_TAX_DED_AMOUNT_1 := 0;          -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT_1 := 0;           -- 소득세
      V_LOCAL_TAX_AMOUNT_1 := 0;        -- 주민세
      
      V_AVG_TAX_STD_AMOUNT_2 := 0;      -- 년평균 과세표준
      V_CHG_TAX_STD_AMOUNT_2 := 0;      -- 환산 과세표준<2014 추가>  
      V_CHG_COMP_TAX_AMOUNT_2 := 0;     -- 환산 산출세액<2014 추가>  
      V_AVG_COMP_TAX_AMOUNT_2 := 0;     -- 년평균 산출세액
      V_COMP_TAX_AMOUNT_2 := 0;         -- 산출세액
      V_TAX_DED_AMOUNT_2 := 0;          -- 퇴직소득세액공제
      V_IN_TAX_AMOUNT_2 := 0;           -- 소득세
      V_LOCAL_TAX_AMOUNT_2 := 0;        -- 주민세
      
      V_LONG_YEAR_3	            := 0;         -- 2016변경 : 근속년수
      V_LONG_MONTH_3	          := 0;         -- 2016변경 : 근속월수
      V_LONG_DAY_3	            := 0;         -- 2016변경 : 근속일수
      V_LONG_DED_AMOUNT_3	      := 0;         -- 2016변경 : 근속공제
      V_CHG_STD_AMOUNT_3	      := 0;         -- 2016변경 : 환산 급여금액
      V_CHG_DED_AMOUNT_3	      := 0;         -- 2016변경 : 환산 공제액
      V_CHG_TAX_STD_AMOUNT_3	  := 0;         -- 2016변경 : 환산 과세표준 
      V_CHG_COMP_TAX_AMOUNT_3	  := 0;         -- 2016변경 : 환산세액
      V_COMP_TAX_AMOUNT_3	      := 0;         -- 2016변경 : 산출세액
      V_REAL_PRE_COMP_TAX_AMOUNT  := 0;         -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용된 금액 
      V_REAL_NOW_COMP_TAX_AMOUNT  := 0;         -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용된 금액  
      V_REAL_COMP_TAX_AMOUNT_3 	  := 0;         -- 2016변경 : 특례적용 산출금액
      V_PREPAID_TAX_AMOUNT_3	  := 0;         -- 2016변경 : 기납부세액
      V_INCOME_TAX_AMOUNT_3	    := 0;         -- 2016변경 : 소득세
      V_RESIDENT_TAX_AMOUNT_3	  := 0;         -- 2016변경 : 주민세
      V_SP_TAX_AMOUNT_3	        := 0;         -- 2016변경 : 농특세
            
      V_REAL_AMOUNT := 0;               -- 실퇴직금

      V_H_RETIRE_DATE_FR                            := NULL;      -- 명예퇴직 정산 시작일.   
      V_H_LONG_YEAR                                 := 0;         -- 명예퇴직 근속년수.
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;
      V_H_INCOME_DED_AMOUNT                         := 0;         -- 퇴직소득공제
      V_H_LONG_DED_YEAR_AMOUNT                      := 0;         -- 근속년수에 따른 소득공제
      V_H_TAX_STD_AMOUNT                            := 0;         -- 과세표준
      V_H_AVG_TAX_STD_AMOUNT                        := 0;         -- 년평균과세표준
      V_H_AVG_COMP_TAX_AMOUNT                       := 0;         -- 년평균 산출세액
      V_H_COMP_TAX_AMOUNT                           := 0;         -- 산출세액
      V_H_TAX_DED_AMOUNT                            := 0;         -- 퇴직소득세액공제
      V_H_IN_TAX_AMOUNT                             := 0;         -- 소득세
      V_H_LOCAL_TAX_AMOUNT                          := 0;         -- 주민세
      V_H_REAL_AMOUNT                               := 0;         -- 명예퇴직금.
      
      V_REAL_TOTAL_AMOUNT                           := 0;         -- 실 
      
      --> 퇴직금 계산
      V_REAL_DAY := NVL(C1.LONG_DAY, 0);
      V_RETR_AMOUNT := NVL(RETR_AMOUNT_F(W_RETR_YYYY , W_SOB_ID, W_ORG_ID, C1.DAY_AVG_AMOUNT, V_REAL_DAY), 0);

      --> 총퇴직금
      V_TOTAL_RETR_AMOUNT := V_RETR_AMOUNT + NVL(C1.GLORY_AMOUNT, 0) + NVL(C1.ETC_SUPP_AMOUNT, 0);

---------------------------------------------------------------------------------------------------
      --> 퇴직근로소득 산출
      V_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_TOTAL_RETR_AMOUNT);

      --> 근속에 따른 소득공제
      V_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.LONG_YEAR);

      --> 과세 표준
      V_TAX_STD_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0) - NVL(V_INCOME_DED_AMOUNT, 0) - NVL(V_LONG_DED_YEAR_AMOUNT, 0);
      IF V_TAX_STD_AMOUNT < 0 THEN
        V_TAX_STD_AMOUNT := 0;
      END IF;
      
      --> 과세표준 안분 
      V_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT / (NVL(C1.LONG_YEAR_1, 0) + NVL(C1.LONG_YEAR_2, 0)) * NVL(C1.LONG_YEAR_1, 0));
      V_TAX_STD_AMOUNT_2 := V_TAX_STD_AMOUNT - V_TAX_STD_AMOUNT_1;
      IF V_TAX_STD_AMOUNT != V_TAX_STD_AMOUNT_1 + V_TAX_STD_AMOUNT_2 THEN
        O_STATUS := 'F';
        O_MESSAGE := 'Tax STD Division Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
        RETURN;
      END IF;
      
      
      -- 년도별 소득세 계산 --
      V_REAL_AMOUNT := NVL(V_TOTAL_RETR_AMOUNT, 0);
      IF NVL(C1.LONG_YEAR_1, 0) > 0 THEN
        -- 2102년도 까지 세액 계산 --
        BEGIN
          --> 년평균 과세표준(퇴직일자까지 근속년수 적용)  
          --> (과세표준 / (총근속년수) * 12년도까지 근속년수) / 12년도까지 근속년수  
          
          -- 12년도까지 년평균과세표준 금액 계산  
          V_AVG_TAX_STD_AMOUNT_1 := TRUNC(V_TAX_STD_AMOUNT_1 / NVL(C1.LONG_YEAR_1, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := 'Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
            RETURN;
        END;

        --> 산출세액
        V_AVG_COMP_TAX_AMOUNT_1 := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_AVG_TAX_STD_AMOUNT_1);

        --> 산출세액
        V_COMP_TAX_AMOUNT_1 := TRUNC(V_AVG_COMP_TAX_AMOUNT_1 * C1.LONG_YEAR_1);

        --> 소득세액공제
        V_TAX_DED_AMOUNT_1 := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_COMP_TAX_AMOUNT_1, C1.LONG_YEAR_1);

        --> 소득세
        V_IN_TAX_AMOUNT_1 := TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0) - NVL(V_TAX_DED_AMOUNT_1, 0));   -- 무조건 버림
        IF V_IN_TAX_AMOUNT_1 < 0 THEN
          V_IN_TAX_AMOUNT_1 := 0;
        END IF;

        --> 주민세
        V_LOCAL_TAX_AMOUNT_1 := TRUNC(V_IN_TAX_AMOUNT_1 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- 무조건 버림
      END IF;
      
      IF NVL(C1.LONG_YEAR_2, 0) > 0 THEN
        -- 2103년도 부터 세액 계산 --
        BEGIN
          --> 년평균 과세표준(퇴직일자까지 근속년수 적용)  
          -- 13년도 과세표준 금액 산정 --
          --> (안분과세표준 / 근속연수)  
          V_AVG_TAX_STD_AMOUNT_2 := TRUNC(NVL(V_TAX_STD_AMOUNT_2, 0) / NVL(C1.LONG_YEAR_2, 0));
        EXCEPTION 
          WHEN OTHERS THEN
            O_STATUS := 'F';
            O_MESSAGE := 'Avg Tax STD Amount Error : ' || SUBSTR(SQLERRM, 1, 150);       
            RETURN;
        END;
        
        --> 환산 과세표준(연평균과세표준 * 5)  
        V_CHG_TAX_STD_AMOUNT_2 := V_AVG_TAX_STD_AMOUNT_2 * 5;
        
        --> 환산산출세액(환산과세표준 * 세율)  
        V_CHG_COMP_TAX_AMOUNT_2 := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_CHG_TAX_STD_AMOUNT_2);
        
        --> 연평균산출세액(환산산출세액 / 5)
        V_AVG_COMP_TAX_AMOUNT_2 := TRUNC(V_CHG_COMP_TAX_AMOUNT_2 / 5);

        --> 소득세액공제
        V_TAX_DED_AMOUNT_2 := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_AVG_COMP_TAX_AMOUNT_2, C1.LONG_YEAR_2);

        --> 산출세액(연평균산출세액 * 근속연수) 
        V_COMP_TAX_AMOUNT_2 := TRUNC(V_AVG_COMP_TAX_AMOUNT_2 * C1.LONG_YEAR_2);
        
        --> 소득세
        V_IN_TAX_AMOUNT_2 := TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0) - NVL(V_TAX_DED_AMOUNT_2, 0));   -- 무조건 버림
        
        -- 2013-07-13 START OF MODIFY --
        -- 전호수 추가 : 원단위 보정(2012년/2013년 분할계산으로 인해 소득세 합계와 원단위 차액 발생) --
        V_TEMP_AMOUNT :=0;
        V_TEMP_AMOUNT := TRUNC((NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0))) - 
                         (TRUNC(NVL(V_COMP_TAX_AMOUNT_1, 0)) + TRUNC(NVL(V_COMP_TAX_AMOUNT_2, 0)));
        IF NVL(V_TEMP_AMOUNT, 0) != 0 THEN
          V_IN_TAX_AMOUNT_2 := NVL(V_IN_TAX_AMOUNT_2, 0) + NVL(V_TEMP_AMOUNT, 0);
        END IF;
        --> 2013-07-13 END OF MODIFY  -- 
        IF V_IN_TAX_AMOUNT_2 < 0 THEN
          V_IN_TAX_AMOUNT_2 := 0;
        END IF;
        
        --> 주민세
        V_LOCAL_TAX_AMOUNT_2 := TRUNC(V_IN_TAX_AMOUNT_2 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- 무조건 버림
      END IF;
      
      -- 2016년도 퇴직소득세 계산 방법 적용 -- 
      -- 2016변경 : 근속년수
      V_LONG_YEAR_3	            := C1.LONG_YEAR;         
      -- 2016변경 : 근속월수
      V_LONG_MONTH_3	          := C1.LONG_MONTH;        
      -- 2016변경 : 근속일수
      V_LONG_DAY_3	            := C1.LONG_DAY;          
      -- 2016변경 : 근속공제
      V_LONG_DED_AMOUNT_3	      := V_LONG_DED_YEAR_AMOUNT;         
      -- 2016변경 : 환산 급여금액
      V_CHG_STD_AMOUNT_3	      := NVL(V_TOTAL_RETR_AMOUNT, 0) - NVL(V_LONG_DED_AMOUNT_3, 0);         
      IF V_CHG_STD_AMOUNT_3 < 0 THEN
        V_CHG_STD_AMOUNT_3 := 0;  
      END IF;
      -- 환산 급여 : (총퇴직금 - 근속공제) / 근속년수 * 12;
      V_CHG_STD_AMOUNT_3 := ROUND(NVL(V_CHG_STD_AMOUNT_3, 0) / V_LONG_YEAR_3 * 12);
      -- 2016변경 : 환산 공제액
      V_CHG_DED_AMOUNT_3 := CHG_DED_AMOUNT_F
                              ( W_STD_YYYY   => W_RETR_YYYY
                              , W_SOB_ID     => W_SOB_ID
                              , W_ORG_ID     => W_ORG_ID
                              , P_CHG_AMOUNT => V_CHG_STD_AMOUNT_3 
                              );         
      IF V_CHG_DED_AMOUNT_3 < 0 THEN
        V_CHG_DED_AMOUNT_3 := 0;  
      END IF;
      -- 2016변경 : 환산 과세표준
      V_CHG_TAX_STD_AMOUNT_3 := NVL(V_CHG_STD_AMOUNT_3, 0) - NVL(V_CHG_DED_AMOUNT_3, 0);   
      -- 2016변경 : 환산세액        
      V_CHG_COMP_TAX_AMOUNT_3	  := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_CHG_TAX_STD_AMOUNT_3);      
      -- 2016변경 : 산출세액    
      V_COMP_TAX_AMOUNT_3	      := TRUNC(NVL(V_CHG_COMP_TAX_AMOUNT_3, 0) / 12 * V_LONG_YEAR_3);         
      
      -- 연도별 산출세액 적용 비율 -- 
      V_REAL_PRE_COMP_TAX_RATE := 0;        -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
      V_REAL_NOW_COMP_TAX_RATE := 100;      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
      IF W_RETR_YYYY = '2016' THEN
        -- 종전 : 80%, 개정 : 20% 
        V_REAL_PRE_COMP_TAX_RATE := 80;        -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
        V_REAL_NOW_COMP_TAX_RATE := 20;      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
      ELSIF W_RETR_YYYY = '2017' THEN
        -- 종전 : 60%, 개정 : 40% 
        V_REAL_PRE_COMP_TAX_RATE := 60;        -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
        V_REAL_NOW_COMP_TAX_RATE := 40;      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
      ELSIF W_RETR_YYYY = '2018' THEN
        -- 종전 : 40%, 개정 : 60% 
        V_REAL_PRE_COMP_TAX_RATE := 40;        -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
        V_REAL_NOW_COMP_TAX_RATE := 60;      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
      ELSIF W_RETR_YYYY = '2019' THEN
        -- 종전 : 20%, 개정 : 80% 
        V_REAL_PRE_COMP_TAX_RATE := 20;        -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
        V_REAL_NOW_COMP_TAX_RATE := 80;      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
      ELSE
        -- 종전 : 0%, 개정 : 100% 
        V_REAL_PRE_COMP_TAX_RATE := 0;        -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용율  
        V_REAL_NOW_COMP_TAX_RATE := 100;      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용율   
      END IF;
      -- 2016변경 : 특례적용 이전 방식 산출금액 반영율 적용된 금액        
      V_REAL_PRE_COMP_TAX_AMOUNT := TRUNC((NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0)) * (V_REAL_PRE_COMP_TAX_RATE/100), 10);
      -- 2016변경 : 특례적용 변경 방식 산출금액 반영율 적용된 금액  
      V_REAL_NOW_COMP_TAX_AMOUNT := TRUNC(NVL(V_COMP_TAX_AMOUNT_3, 0) * (V_REAL_NOW_COMP_TAX_RATE/100), 10);
      -- 2016변경 : 특례적용 산출금액;
      V_REAL_COMP_TAX_AMOUNT_3  := TRUNC(NVL(V_REAL_PRE_COMP_TAX_AMOUNT, 0) + NVL(V_REAL_NOW_COMP_TAX_AMOUNT, 0));       
        
      -- 2016변경 : 기납부세액 
      V_PREPAID_TAX_AMOUNT_3	  := 0;   
      -- 2016변경 : 소득세     
      V_INCOME_TAX_AMOUNT_3	    := NVL(V_REAL_COMP_TAX_AMOUNT_3, 0) - NVL(V_PREPAID_TAX_AMOUNT_3, 0);       
      -- 2016변경 : 주민세  
      V_RESIDENT_TAX_AMOUNT_3	  := TRUNC(V_INCOME_TAX_AMOUNT_3 * (TAX_RATE_F('RESIDENT', W_SOB_ID, W_ORG_ID) / 100));   -- 무조건 버림;  
      -- 2016변경 : 농특세     
      V_SP_TAX_AMOUNT_3	        := 0;         
      
      -- 실지급액 계산 -- 
      --> 실지급액 (총퇴직금 - 주민세 - 소득세 - 기타공제 - 퇴직전환금)
      V_REAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) - TRUNC(NVL(V_INCOME_TAX_AMOUNT_3, 0), -1) 
                                             - TRUNC(NVL(V_RESIDENT_TAX_AMOUNT_3, 0), -1);
      IF V_REAL_AMOUNT < 0 THEN
        V_REAL_AMOUNT := 0;
      END IF;
       
------------------------------------------------------------------------------
-- 5. 명예 퇴직금 계산.
      IF C1.HONORARY_AMOUNT > 0 THEN
        V_H_RETIRE_DATE_FR := C1.JOIN_DATE;
        V_H_RETIRE_DATE_TO := W_RETIRE_DATE_TO;
        
        --> 5.1 근속년수
        BEGIN
          V_H_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, V_H_RETIRE_DATE_TO, 'CEIL');          
          IF V_H_RETIRE_DATE_FR = W_RETIRE_DATE_FR THEN
            V_H_PRE_LONG_YEAR := V_H_LONG_YEAR;
          ELSE
            V_H_PRE_LONG_YEAR := HRM_COMMON_DATE_G.PERIOD_YEAR_F(V_H_RETIRE_DATE_FR, W_RETIRE_DATE_FR - 1, 'CEIL');
          END IF;
        EXCEPTION WHEN OTHERS THEN
          O_MESSAGE := 'Honorary - Long Period Calculation Error : ' || SQLERRM;
          RETURN;
        END;
        
        --> 퇴직근로소득 산출
        V_H_INCOME_DED_AMOUNT := INCOME_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.HONORARY_AMOUNT);

        --> 5.3.1 근속에 따른 소득공제(전체 근속에 대한 금액).
        V_H_LONG_DED_YEAR_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_LONG_YEAR);
        --> 5.3.2 근속부터 중도정산 이전까지의 근속 소득공제.
        V_TEMP_AMOUNT := 0;
        V_TEMP_AMOUNT := LONG_DED_YEAR_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_PRE_LONG_YEAR);
        -- 실제 근속 소득공제금액.
        V_H_LONG_DED_YEAR_AMOUNT := V_H_LONG_DED_YEAR_AMOUNT - V_TEMP_AMOUNT - V_LONG_DED_YEAR_AMOUNT;
        IF V_H_LONG_DED_YEAR_AMOUNT < 0 THEN
          V_H_LONG_DED_YEAR_AMOUNT := 0;
        END IF;
        
        --> 과세 표준
        V_H_TAX_STD_AMOUNT := C1.HONORARY_AMOUNT - V_H_INCOME_DED_AMOUNT - V_H_LONG_DED_YEAR_AMOUNT;
        IF V_H_TAX_STD_AMOUNT < 0 THEN
          V_H_TAX_STD_AMOUNT := 0;
        END IF;

        --> 년평균 과세표준
        V_H_AVG_TAX_STD_AMOUNT := TRUNC(V_H_TAX_STD_AMOUNT / V_H_LONG_YEAR);

        --> 산출세액
        V_H_AVG_COMP_TAX_AMOUNT := AVG_TAX_AMOUNT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, V_H_AVG_TAX_STD_AMOUNT);

        --> 산출세액
        V_H_COMP_TAX_AMOUNT := V_H_AVG_COMP_TAX_AMOUNT * V_H_LONG_YEAR;

        --> 소득세액공제
        V_H_TAX_DED_AMOUNT := TAX_SUBTRACT_F(W_RETR_YYYY, W_SOB_ID, W_ORG_ID, C1.RETIRE_DATE_TO, V_H_COMP_TAX_AMOUNT, V_H_LONG_YEAR);

        --> 소득세
        V_H_IN_TAX_AMOUNT := TRUNC(NVL(V_H_COMP_TAX_AMOUNT, 0) - NVL(V_H_TAX_DED_AMOUNT, 0), -1);   -- 무조건 버림
        IF V_H_IN_TAX_AMOUNT < 0 THEN
          V_H_IN_TAX_AMOUNT := 0;
        END IF;

        --> 주민세
        V_H_LOCAL_TAX_AMOUNT := TRUNC(V_H_IN_TAX_AMOUNT * 0.1, -1);   -- 무조건 버림
        
        -- 실지급액.
        V_H_REAL_AMOUNT := NVL(C1.HONORARY_AMOUNT, 0) - TRUNC(NVL(V_H_IN_TAX_AMOUNT, 0), -1) - TRUNC(NVL(V_H_LOCAL_TAX_AMOUNT, 0), -1);
        IF V_H_REAL_AMOUNT < 0 THEN
          V_H_REAL_AMOUNT := 0;
        END IF;
        
      END IF;
------------------------------------------------------------------------------      
      V_REAL_TOTAL_AMOUNT := NVL(V_REAL_AMOUNT, 0) + NVL(V_H_REAL_AMOUNT, 0) - 
                             NVL(C1.ETC_DED_AMOUNT, 0) - NVL(C1.HEALTH_INSUR_AMOUNT, 0) - 
                             NVL(C1.RETIRE_CVS_AMOUNT, 0);
      IF V_REAL_TOTAL_AMOUNT < 0 THEN
        V_REAL_TOTAL_AMOUNT := 0;
      END IF;

------------------------------------------------------------------------------
      --> 퇴직금 적용  --
      UPDATE HRR_RETIRE_ADJUSTMENT RA
        SET RA.RETIRE_AMOUNT          = V_RETR_AMOUNT
          , RA.RETIRE_TOTAL_AMOUNT    = V_TOTAL_RETR_AMOUNT
          , RA.INCOME_DED_AMOUNT      = V_INCOME_DED_AMOUNT
          , RA.LONG_DED_AMOUNT        = V_LONG_DED_YEAR_AMOUNT
          , RA.TAX_STD_AMOUNT         = V_TAX_STD_AMOUNT 
          , RA.TAX_STD_AMOUNT_1       = V_TAX_STD_AMOUNT_1  -- 전호수 추가 
          , RA.TAX_STD_AMOUNT_2       = V_TAX_STD_AMOUNT_2  -- 전호수 추가 
          , RA.AVG_TAX_STD_AMOUNT     = (NVL(V_AVG_TAX_STD_AMOUNT_1, 0) + NVL(V_AVG_TAX_STD_AMOUNT_2, 0)) 
          , RA.AVG_COMP_TAX_AMOUNT    = (NVL(V_AVG_COMP_TAX_AMOUNT_1, 0) + NVL(V_AVG_COMP_TAX_AMOUNT_2, 0)) 
          , RA.COMP_TAX_AMOUNT        = (NVL(V_COMP_TAX_AMOUNT_1, 0) + NVL(V_COMP_TAX_AMOUNT_2, 0)) 
          , RA.TAX_DED_AMOUNT         = (NVL(V_TAX_DED_AMOUNT_1, 0) + NVL(V_TAX_DED_AMOUNT_2, 0)) 
          , RA.INCOME_TAX_AMOUNT      = (NVL(V_IN_TAX_AMOUNT_1, 0) + NVL(V_IN_TAX_AMOUNT_2, 0)) 
          , RA.RESIDENT_TAX_AMOUNT    = (NVL(V_LOCAL_TAX_AMOUNT_1, 0) + NVL(V_LOCAL_TAX_AMOUNT_2, 0)) 
          , RA.REAL_AMOUNT            = V_REAL_AMOUNT
          , RA.H_RETIRE_DATE_FR       = V_H_RETIRE_DATE_FR
          , RA.H_RETIRE_DATE_TO       = V_H_RETIRE_DATE_TO
          , RA.H_LONG_YEAR            = V_H_LONG_YEAR
          , RA.H_INCOME_DED_AMOUNT    = V_H_INCOME_DED_AMOUNT
          , RA.H_LONG_DED_AMOUNT      = V_H_LONG_DED_YEAR_AMOUNT
          , RA.H_TAX_STD_AMOUNT       = V_H_TAX_STD_AMOUNT
          , RA.H_AVG_TAX_STD_AMOUNT   = V_H_AVG_TAX_STD_AMOUNT
          , RA.H_AVG_COMP_TAX_AMOUNT  = V_H_AVG_COMP_TAX_AMOUNT
          , RA.H_COMP_TAX_AMOUNT      = V_H_COMP_TAX_AMOUNT
          , RA.H_TAX_DED_AMOUNT       = V_H_TAX_DED_AMOUNT
          , RA.H_INCOME_TAX_AMOUNT    = V_H_IN_TAX_AMOUNT
          , RA.H_RESIDENT_TAX_AMOUNT  = V_H_LOCAL_TAX_AMOUNT
          , RA.H_REAL_AMOUNT          = V_H_REAL_AMOUNT
          , RA.REAL_TOTAL_AMOUNT      = V_REAL_TOTAL_AMOUNT
          , RA.LAST_UPDATE_DATE       = V_SYSDATE
          , RA.LAST_UPDATED_BY        = P_USER_ID
          , RA.AVG_TAX_STD_AMOUNT_1   = V_AVG_TAX_STD_AMOUNT_1
          , RA.AVG_COMP_TAX_AMOUNT_1  = V_AVG_COMP_TAX_AMOUNT_1
          , RA.COMP_TAX_AMOUNT_1      = V_COMP_TAX_AMOUNT_1
          , RA.TAX_DED_AMOUNT_1       = V_TAX_DED_AMOUNT_1
          , RA.INCOME_TAX_AMOUNT_1    = V_IN_TAX_AMOUNT_1
          , RA.RESIDENT_TAX_AMOUNT_1  = V_LOCAL_TAX_AMOUNT_1
          , RA.AVG_TAX_STD_AMOUNT_2   = V_AVG_TAX_STD_AMOUNT_2 
          
          , RA.CHG_TAX_STD_AMOUNT_2   = V_CHG_TAX_STD_AMOUNT_2  -- <2014 추가> 
          , RA.CHG_COMP_TAX_AMOUNT_2  = V_CHG_COMP_TAX_AMOUNT_2 -- <2014 추가> 
          
          , RA.AVG_COMP_TAX_AMOUNT_2  = V_AVG_COMP_TAX_AMOUNT_2 
          , RA.COMP_TAX_AMOUNT_2      = V_COMP_TAX_AMOUNT_2 
          , RA.TAX_DED_AMOUNT_2       = V_TAX_DED_AMOUNT_2 
          , RA.INCOME_TAX_AMOUNT_2    = V_IN_TAX_AMOUNT_2 
          , RA.RESIDENT_TAX_AMOUNT_2  = V_LOCAL_TAX_AMOUNT_2 
          
          , RA.LONG_YEAR_3            = V_LONG_YEAR_3
          , RA.LONG_MONTH_3           = V_LONG_MONTH_3 
          , RA.LONG_DAY_3             = V_LONG_DAY_3  
          , RA.LONG_DED_AMOUNT_3      = V_LONG_DED_AMOUNT_3 
          , RA.CHG_STD_AMOUNT_3       = V_CHG_STD_AMOUNT_3       
          , RA.CHG_DED_AMOUNT_3       = V_CHG_DED_AMOUNT_3 
          , RA.CHG_TAX_STD_AMOUNT_3   = V_CHG_TAX_STD_AMOUNT_3 
          , RA.CHG_COMP_TAX_AMOUNT_3  = V_CHG_COMP_TAX_AMOUNT_3 
          , RA.COMP_TAX_AMOUNT_3      = V_COMP_TAX_AMOUNT_3 
          , RA.REAL_PRE_COMP_TAX_AMOUNT = V_REAL_PRE_COMP_TAX_AMOUNT 
          , RA.REAL_NOW_COMP_TAX_AMOUNT = V_REAL_NOW_COMP_TAX_AMOUNT
          , RA.REAL_COMP_TAX_AMOUNT_3   = V_REAL_COMP_TAX_AMOUNT_3
          , RA.PREPAID_TAX_AMOUNT_3     = V_PREPAID_TAX_AMOUNT_3  
          , RA.INCOME_TAX_AMOUNT_3      = V_INCOME_TAX_AMOUNT_3 
          , RA.RESIDENT_TAX_AMOUNT_3    = V_RESIDENT_TAX_AMOUNT_3 
          , RA.SP_TAX_AMOUNT_3          = V_SP_TAX_AMOUNT_3
      WHERE RA.ADJUSTMENT_ID          = W_ADJUSTMENT_ID
      ;
    END LOOP C1;
    O_STATUS := 'S';
    O_MESSAGE := EAPP_MESSAGE_G.RETURN_TEXT_F(USERENV_G.GET_TERRITORY_S_F, 'FCM_10112', NULL);
  END CAL_RETIRE_2016;
              
            
/*==========================================================================/
     ==> 퇴직금 계산
       -. P_DAY_AVG_AMOUNT : 일평균 금액
       -. P_TOTAL_DAY : 총근속일수
/==========================================================================*/
  FUNCTION RETR_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_DAY_AVG_AMOUNT          IN NUMBER
            , P_TOTAL_DAY               IN NUMBER            
            ) RETURN NUMBER
  AS
    V_RETR_AMOUNT                       NUMBER := 0;    -- 퇴직금

  BEGIN
    BEGIN
      SELECT NVL(P_DAY_AVG_AMOUNT, 0) * NVL(RS.MONTH_DAY, 0) * NVL(P_TOTAL_DAY, 0) / NVL(RS.YEAR_DAY, 365)
        INTO V_RETR_AMOUNT
        FROM HRR_RETIRE_STANDARD RS
      WHERE RS.STD_YYYY                 = W_STD_YYYY
        AND RS.SOB_ID                   = W_SOB_ID
        AND RS.ORG_ID                   = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_RETR_AMOUNT := 0;  
    END;
    
    --> 퇴직금 계산 (일평균금액 * 30 * 총일수 / 365)
    V_RETR_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_RETR_AMOUNT, 'RETIRE_AMOUNT');
    IF V_RETR_AMOUNT < 0 THEN
      V_RETR_AMOUNT := 0;
    END IF;
    RETURN V_RETR_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('0.Retire Amount Cal Error : ' || SQLERRM);
    RETURN 0;
  END RETR_AMOUNT_F;

/*==========================================================================/
     ==> 퇴직소득공제 계산 -- 1
/==========================================================================*/
  FUNCTION  INCOME_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_TOTAL_AMOUNT            IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      SELECT NVL(P_TOTAL_AMOUNT, 0) * (NVL(RS.INCOME_DEDUCTION_RATE, 0) / 100) AS INCOME_SUBTRACT
        INTO V_SUBTRACT_AMOUNT
        FROM HRR_RETIRE_STANDARD RS
      WHERE RS.STD_YYYY                 = W_STD_YYYY
        AND RS.SOB_ID                   = W_SOB_ID
        AND RS.ORG_ID                   = W_ORG_ID
       ;
    EXCEPTION WHEN OTHERS THEN
      V_SUBTRACT_AMOUNT := 0;  
    END;
    
    --V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    V_SUBTRACT_AMOUNT := ROUND(V_SUBTRACT_AMOUNT, 0);
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
    RETURN V_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('1.Income Subtract Cal Error : ' || SQLERRM);
    RETURN 0;
  END INCOME_SUBTRACT_F;

/*==========================================================================/
     ==> 퇴직근속년수에 의한 공제액 산출  -- 2
/==========================================================================*/
  FUNCTION LONG_DED_YEAR_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_LONG_YEAR               IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;

  BEGIN
    BEGIN
      --> 근속년수에 따른 공제 금액
      SELECT ((NVL(P_LONG_YEAR, 0) - NVL(CD.DED_YEAR, 0))* NVL(CD.DED_AMOUNT, 0)) + NVL(CD.DED_ADD_AMOUNT, 0) AS DED_YEAR
        INTO V_SUBTRACT_AMOUNT
      FROM HRR_CONTINUOUS_DEDUCTION CD
      WHERE CD.STD_YYYY           = W_STD_YYYY
        AND P_LONG_YEAR           BETWEEN CD.START_YEAR AND CD.END_YEAR
        AND CD.SOB_ID             = W_SOB_ID
        AND CD.ORG_ID             = W_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('2.1 Continuous Year Cal Error : ' || SQLERRM);
      RETURN 0;
    END;

    V_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
--DBMS_OUTPUT.PUT_LINE('근속년수공제=>' || V_SUBTRACT_AMT);
    RETURN V_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('2.Continuous Year Cal Error : ' || SQLERRM);
    RETURN 0;
  END LONG_DED_YEAR_F;

/*==========================================================================/
     ==> 환산급여 공제   - 5
/==========================================================================*/
  FUNCTION CHG_DED_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_CHG_AMOUNT              IN NUMBER
            ) RETURN NUMBER
  AS
    V_SUBTRACT_AMOUNT                   NUMBER := 0;
  BEGIN
    BEGIN
      --> 근속년수에 따른 공제 금액
      SELECT ((NVL(P_CHG_AMOUNT, 0) - NVL(DR.STD_AMOUNT, 0)) * (NVL(DR.CHG_DED_RATE, 0) / 100)) + NVL(DR.ADD_AMOUNT, 0) AS DED_AMOUNT 
        INTO V_SUBTRACT_AMOUNT
      FROM HRR_CHANGE_DEDUCTION_RATE DR
      WHERE DR.ADJUST_YYYY        = W_STD_YYYY
        AND NVL(P_CHG_AMOUNT, 0)  BETWEEN DR.START_AMOUNT AND DR.END_AMOUNT 
        AND DR.SOB_ID             = W_SOB_ID 
      ;
    EXCEPTION WHEN OTHERS THEN
      RETURN P_CHG_AMOUNT;
    END;

    V_SUBTRACT_AMOUNT := TRUNC(V_SUBTRACT_AMOUNT);
    IF V_SUBTRACT_AMOUNT < 0 THEN
      V_SUBTRACT_AMOUNT := 0;
    END IF;
    RETURN V_SUBTRACT_AMOUNT;
  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('2.Continuous Year Cal Error : ' || SQLERRM);
    RETURN 0;
  END CHG_DED_AMOUNT_F;

/*==========================================================================/
     ==> 산출세액 계산   - 5
/==========================================================================*/
  FUNCTION AVG_TAX_AMOUNT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_AVG_TAX_STD_AMOUNT      IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_AMOUNT                        NUMBER := 0;

  BEGIN
    BEGIN
    --> 산출세액 조회
      SELECT (NVL(P_AVG_TAX_STD_AMOUNT, 0) * (TR.TAX_RATE /  100)) - NVL(TR.ACCUM_SUB_AMOUNT, 0) AS TAX_AMOUNT
        INTO V_TAX_AMOUNT
        FROM HRA_TAX_RATE TR
          , HRM_COMMON HC
      WHERE TR.TAX_TYPE_ID      = HC.COMMON_ID
      AND TR.TAX_YYYY           = W_STD_YYYY
      AND TR.SOB_ID             = W_SOB_ID
      AND TR.ORG_ID             = W_ORG_ID
      AND HC.CODE               = '20'                               -- 퇴직정산.
      AND P_AVG_TAX_STD_AMOUNT  BETWEEN TR.START_AMOUNT AND TR.END_AMOUNT        
      ;
    EXCEPTION WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('5.1 Tax Cal Error : ' || SQLERRM);
      RETURN 0;
    END;
--DBMS_OUTPUT.PUT_LINE('V_TAX_RATE -> ' || V_TAX_RATE || 'V_ACCU -> ' || V_ACCU);

    --> 산출세액 계산
    V_TAX_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_TAX_AMOUNT, 'RETIRE_AMOUNT');
    IF V_TAX_AMOUNT < 0 THEN
      V_TAX_AMOUNT := 0;
    END IF;
    RETURN V_TAX_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('5.Tax Cal Error : ' || SQLERRM);
    RETURN 0;
  END AVG_TAX_AMOUNT_F;


/*==========================================================================/
     ==> 퇴직소득공제 계산  - 6
/==========================================================================*/
  FUNCTION TAX_SUBTRACT_F
            ( W_STD_YYYY                IN VARCHAR2
            , W_SOB_ID                  IN NUMBER
            , W_ORG_ID                  IN NUMBER
            , P_END_DATE                IN DATE
            , P_LONG_YEAR               IN NUMBER
            , P_TAX_AMOUNT              IN NUMBER
            ) RETURN NUMBER
  AS
    V_TAX_SUBTRACT_AMOUNT               NUMBER := 0;
    V_TAX_DEDUCTION_LMT_AMOUNT          NUMBER := 0;

  BEGIN
     --> 초기화
     V_TAX_SUBTRACT_AMOUNT := 0;

     IF P_END_DATE < TO_DATE('2003-01-01', 'YYYY-MM-DD') THEN
     --> 2003-01-01 이전 적용
       V_TAX_SUBTRACT_AMOUNT := P_TAX_AMOUNT * 0.5;

     ELSIF P_END_DATE BETWEEN TO_DATE('2003-01-01', 'YYYY-MM-DD') AND TO_DATE('2004-12-31', 'YYYY-MM-DD') THEN
     --> 2003-01-01  ~ 2004-12-31 까지 적용
       V_TAX_SUBTRACT_AMOUNT := P_TAX_AMOUNT * 0.25;

     ELSE
     --> 2005-01-01 이후 폐지
       -- 퇴직세액공제 한도 계산;
        BEGIN
          SELECT NVL(P_LONG_YEAR, 1) * NVL(RS.TAX_DEDUCTION_LMT, 0) AS TAX_DEDUCTION_LMT
            INTO V_TAX_DEDUCTION_LMT_AMOUNT
            FROM HRR_RETIRE_STANDARD RS
          WHERE RS.STD_YYYY       = W_STD_YYYY
            AND RS.SOB_ID         = W_SOB_ID
            AND RS.ORG_ID         = W_ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_TAX_DEDUCTION_LMT_AMOUNT := 0;
          DBMS_OUTPUT.PUT_LINE('6.1Tax Deduction Limit Cal Error : ' || SQLERRM);
        END;

       -- 퇴직세액공제금액 계산;
        BEGIN
          SELECT NVL(P_TAX_AMOUNT, 0) * (RS.TAX_DEDUCTION_RATE / 100) AS TAX_DEDUCTION_LMT
            INTO V_TAX_SUBTRACT_AMOUNT
            FROM HRR_RETIRE_STANDARD RS
          WHERE RS.STD_YYYY       = W_STD_YYYY
            AND RS.SOB_ID         = W_SOB_ID
            AND RS.ORG_ID         = W_ORG_ID
          ;          
        EXCEPTION WHEN OTHERS THEN
          V_TAX_SUBTRACT_AMOUNT := 0;
          DBMS_OUTPUT.PUT_LINE('6.2Tax Deduction Limit Cal Error : ' || SQLERRM);
        END;

        -- 퇴직세액공제금액 한도 체크;
        IF V_TAX_DEDUCTION_LMT_AMOUNT < V_TAX_SUBTRACT_AMOUNT THEN
          V_TAX_SUBTRACT_AMOUNT := V_TAX_DEDUCTION_LMT_AMOUNT;
        END IF;
     END IF;

     V_TAX_SUBTRACT_AMOUNT := HRM_COMMON_G.DECIMAL_F(W_SOB_ID, W_ORG_ID, V_TAX_SUBTRACT_AMOUNT, 'RETIRE_AMOUNT');
     IF V_TAX_SUBTRACT_AMOUNT < 0 THEN
       V_TAX_SUBTRACT_AMOUNT := 0;
     END IF;
     RETURN V_TAX_SUBTRACT_AMOUNT;

  EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('6.Tax Deduction Limit Cal Error : ' || SQLERRM);
    RETURN 0;
  END TAX_SUBTRACT_F;

END HRR_RETIRE_ADJUSTMENT_SET_G;
/
