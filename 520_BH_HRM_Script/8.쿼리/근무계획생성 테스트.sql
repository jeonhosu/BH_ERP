/*
SELECT *
  FROM HRD_WORK_DATE_GT
;
*/

DECLARE    
    P_CORP_ID                                       NUMBER := 65;
    P_WORK_PERIOD                                   VARCHAR2(10) := '2012-05';
    P_WORK_TYPE_ID                                  NUMBER := 4165;
    P_WORK_DATE_FR                                  DATE := TO_DATE('2012-05-01', 'YYYY-MM-DD');
    P_WORK_DATE_TO                                  DATE := TO_DATE('2012-05-31', 'YYYY-MM-DD');
    P_SOB_ID                                        NUMBER := 10;
    P_ORG_ID                                        NUMBER := 101;

    D_SYSDATE                                       DATE := GET_LOCAL_DATE(P_SOB_ID);
    
    V_CREATED_METHOD                                HRD_WORK_CALENDAR_SET.CREATED_METHOD%TYPE;
    V_PRE_DAY_COUNT                                 NUMBER := 0;         -- 기적용 일수.
    V_DAY_COUNT                                     NUMBER := 0;         -- 적용 일수.    
    D_START_DATE                                    DATE;
    D_END_DATE                                      DATE;
    V_ATTEND_FLAG                                   VARCHAR2(20) := 'N';

    N1                                              NUMBER;
    V_LOOP_COUNT                                    NUMBER;
        
    V_PRE_HOLY_TYPE      VARCHAR2(2);
BEGIN
    V_CREATED_METHOD := 'A';
        
    -- 기적용일수 조회.
    BEGIN
      SELECT NVL(MAX(WCS.DAY_COUNT), 0) AS DAY_COUNT
        INTO V_PRE_DAY_COUNT
        FROM HRD_WORK_CALENDAR_SET WCS
       WHERE WCS.CORP_ID          = P_CORP_ID
         AND WCS.WORK_PERIOD      = P_WORK_PERIOD
         AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
         AND WCS.CREATED_METHOD   = V_CREATED_METHOD
         AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
         AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
         AND WCS.HOLY_TYPE        = -1
         AND WCS.SOB_ID           = P_SOB_ID
         AND WCS.ORG_ID           = P_ORG_ID
      ;
    EXCEPTION WHEN OTHERS THEN
      V_PRE_DAY_COUNT := 0;
    END;

--////////////////////////////////////////////////////////////--
-- FOR LOOP 실행 : 조회된 인원수 만큼 --
--////////////////////////////////////////////////////////////--
  FOR C1  IN (SELECT PM.PERSON_ID
                  , PM.PERSON_NUM
                  , PM.WORK_TYPE_ID
                  , HC.VALUE1 WORK_TYPE
                  , PM.JOIN_DATE
                  , PM.RETIRE_DATE
                  , PM.WORK_CORP_ID
                  --, PM.WORK_CORP_ID AS CORP_ID --< [2011-06-25]수정
                  , PM.CORP_ID
                  , PM.SOB_ID
                  , PM.ORG_ID
                FROM HRM_PERSON_MASTER PM
                  , HRM_COMMON HC
              WHERE PM.WORK_TYPE_ID                      = HC.COMMON_ID
                AND PM.WORK_CORP_ID                      = P_CORP_ID
                AND PM.PERSON_ID                         = NVL(&P_PERSON_ID, PM.PERSON_ID)
                AND PM.SOB_ID                            = P_SOB_ID
                AND PM.ORG_ID                            = P_ORG_ID
                AND PM.WORK_TYPE_ID                      = P_WORK_TYPE_ID
                AND PM.JOIN_DATE                         <= P_WORK_DATE_TO
                AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= P_WORK_DATE_FR)
             )
  LOOP
      BEGIN
        -- 기존 자료 삭제.
        DELETE FROM HRD_WORK_CALENDAR WC
        WHERE WC.WORK_DATE                            BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
          AND WC.SOB_ID                               = P_SOB_ID
          AND WC.ORG_ID                               = P_ORG_ID
          AND WC.PERSON_ID                            = C1.PERSON_ID
        ;
      EXCEPTION WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Work Calendar Delete Error : ' || SQLERRM);
      END;

--DBMS_OUTPUT.PUT_LINE('작업시작=>IN_PERSON_NUMB' || C1.PERSON_NUM || '//' || C1.WORK_TYPE);
      D_START_DATE := P_WORK_DATE_FR - V_PRE_DAY_COUNT;
      /*--> 임시테이블 DATA 삭제 <--*/
      DELETE FROM HRD_WORK_DATE_GT;

      -- 월 달력 생성.
      BEGIN
        N1 := P_WORK_DATE_TO - D_START_DATE + 1;
        FOR R1 IN 0 .. N1 - 1
        LOOP
          INSERT INTO HRD_WORK_DATE_GT
          (WORK_DATE, PERSON_ID, WORK_CORP_ID, CORP_ID, WORK_YYYYMM
          , WORK_WEEK, HOLIDAY_CHECK
          , WORK_TYPE_ID, WORK_TYPE
          , DUTY_ID, HOLY_TYPE
          , SOB_ID, ORG_ID
          , TMP_HOLY_TYPE, CREATE_TYPE)
          VALUES
          ( D_START_DATE + R1
          , C1.PERSON_ID, C1.WORK_CORP_ID, C1.CORP_ID
          , P_WORK_PERIOD
          , TO_CHAR(D_START_DATE + R1, 'D')
          , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_CHECK(D_START_DATE + R1 , P_SOB_ID, P_ORG_ID)
          , C1.WORK_TYPE_ID, C1.WORK_TYPE
          , 1168, '2'
          , P_SOB_ID, P_ORG_ID
          , '2', V_CREATED_METHOD)
          ;
        END LOOP C1;
      END;
--  RAISE_APPLICATION_ERROR(-20001, '000000000000000');
/*------------------------------------------------------------------------------------------------*
+++++    교대유형에 따른 근무/근태 값 생성
*------------------------------------------------------------------------------------------------*/
      /*IF C1.WORK_TYPE IN('11') THEN
      -- 무교대(월력 따라감)
         FOR R1 IN ( SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
                          , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.HOLIDAY_CHECK
                          , WD.WORK_TYPE_ID, WD.WORK_TYPE
                          , WD.DUTY_ID, WD.HOLY_TYPE
                          , WD.SOB_ID, WD.ORG_ID
                       FROM HRD_WORK_DATE_GT WD
                     WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND P_WORK_DATE_TO
                       AND WD.PERSON_ID      = C1.PERSON_ID
                       AND WD.SOB_ID         = C1.SOB_ID
                       AND WD.ORG_ID         = C1.ORG_ID
                   )
        LOOP
          UPDATE HRD_WORK_DATE_GT WD
            SET (WD.DUTY_ID, WD.HOLY_TYPE, WD.TMP_HOLY_TYPE)
              = (SELECT DC.DUTY_ID
                     , CASE
                          WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('1') THEN '1'             -- 일요일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('7') THEN '0'             -- 토요일 - 무휴일.
                          ELSE '2'                                       -- 정상근무.
                       END AS HOLY_TYPE
                     , CASE
                          WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '2'    -- 공휴일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('1') THEN '2'             -- 일요일 - 유휴일.
                          WHEN WD.WORK_WEEK IN('7') THEN '2'             -- 토요일 - 무휴일.
                          ELSE '2'                                       -- 정상근무.
                       END AS TMP_HOLY_TYPE
                  FROM HRM_DUTY_CODE_V DC
                WHERE DC.SOB_ID           = WD.SOB_ID
                  AND DC.ORG_ID           = WD.ORG_ID
                  AND DC.DUTY_CODE        = CASE
                                              WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'    -- 공휴일 - 휴일.
                                              WHEN WD.WORK_WEEK     IN('1')      THEN '51'    -- 일요일 - 휴일.
                                              WHEN WD.WORK_WEEK     IN('7')      THEN '52'    -- 토요일 - 휴일.
                                              ELSE '00'                                       -- 평일.
                                            END)
          WHERE WD.WORK_DATE      = R1.WORK_DATE
            AND WD.PERSON_ID      = R1.PERSON_ID
            AND WD.SOB_ID         = R1.SOB_ID
            AND WD.ORG_ID         = R1.ORG_ID;
        END LOOP  R1;
-------------------------------------------------------------------------------
    ELSE
    -- Manual입력(2조2교대 OR 3조2교대) --
        BEGIN
          -- 근무계획 생성 기준정보 존재 여부 체크.
          SELECT COUNT(WCS.WORK_TYPE_ID) AS DAY_COUNT
            INTO V_DAY_COUNT
            FROM HRD_WORK_CALENDAR_SET WCS
           WHERE WCS.CORP_ID          = P_CORP_ID
             AND WCS.WORK_PERIOD      = P_WORK_PERIOD
             AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
             AND WCS.CREATED_METHOD   = V_CREATED_METHOD
             AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
             AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
             AND WCS.SOB_ID           = P_SOB_ID
             AND WCS.ORG_ID           = P_ORG_ID
          ;
        EXCEPTION WHEN OTHERS THEN
          V_DAY_COUNT := 0;
        END;
        IF V_DAY_COUNT = 0 THEN
          O_STATUS := 'F';
          O_MESSAGE := EAPP_MESSAGE_G.RETURN_MSG_F('FCM_10454');
          RETURN;
        END IF;
            
        -- 변수 초기화.
        V_DAY_COUNT := 0;
        V_LOOP_COUNT := 0;
\*DBMS_OUTPUT.PUT_LINE('CORP_ID : ' || P_CORP_ID || ', WORK_PERIOD : ' || P_WORK_PERIOD || ', WORK_TYPE_ID : ' || P_WORK_TYPE_ID
                   || ', CREATED_METHOD' || V_CREATED_METHOD || ', SOB_ID : ' || P_SOB_ID);            *\
        BEGIN
          SELECT CEIL((WCS.WORK_DATE_TO - WCS.WORK_DATE_FR + 1) / SUM(DECODE(WCS.HOLY_TYPE, -1, -1, 1) * DAY_COUNT)) AS LOOP_COUNT
            INTO V_LOOP_COUNT
            FROM HRD_WORK_CALENDAR_SET WCS
           WHERE WCS.CORP_ID          = P_CORP_ID
             AND WCS.WORK_PERIOD      = P_WORK_PERIOD
             AND WCS.WORK_TYPE_ID     = P_WORK_TYPE_ID
             AND WCS.CREATED_METHOD   = V_CREATED_METHOD
             AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
             AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
             AND WCS.SOB_ID           = P_SOB_ID
             AND WCS.ORG_ID           = P_ORG_ID
          GROUP BY WCS.WORK_DATE_TO, WCS.WORK_DATE_FR
          ;
        EXCEPTION WHEN OTHERS THEN
          V_LOOP_COUNT := 0;
          DBMS_OUTPUT.PUT_LINE('Loop Count Error : ' || V_LOOP_COUNT);
        END;
--RAISE_APPLICATION_ERROR(-20001, '2323');
        FOR CNT IN 1..V_LOOP_COUNT
        LOOP
          FOR R0 IN (SELECT  WCS.SEQ
                           , WCS.HOLY_TYPE
                           , WCS.DAY_COUNT
                        FROM HRD_WORK_CALENDAR_SET WCS
                       WHERE WCS.CORP_ID          = C1.WORK_CORP_ID   -- C1.CORP_ID[2011-06-27]수정
                         AND WCS.WORK_PERIOD      = P_WORK_PERIOD
                         AND WCS.WORK_TYPE_ID     = C1.WORK_TYPE_ID
                         AND WCS.CREATED_METHOD   = V_CREATED_METHOD
                         AND WCS.WORK_DATE_FR     = P_WORK_DATE_FR
                         AND WCS.WORK_DATE_TO     = P_WORK_DATE_TO
                         AND WCS.SOB_ID           = C1.SOB_ID
                         AND WCS.ORG_ID           = C1.ORG_ID
                         AND WCS.HOLY_TYPE        <> -1
                      ORDER BY WCS.SEQ
                      )
          LOOP
            IF R0.HOLY_TYPE IN (2, 3) AND R0.DAY_COUNT IN(4, 5) THEN
              V_PRE_HOLY_TYPE := R0.HOLY_TYPE; --휴일이전 주/야 임시 저장
            END IF;
            V_DAY_COUNT := NVL(R0.DAY_COUNT, 0);  -- 기적용일수는 이미 시작일자에 반영됨.
            D_END_DATE := D_START_DATE + V_DAY_COUNT - 1;
  --DBMS_OUTPUT.PUT_LINE('START DATE : ' || TO_CHAR(D_START_DATE, 'YYYY-MM-DD') || ', END DATE : ' || TO_CHAR(D_END_DATE, 'YYYY-MM-DD') || ', HOLY : ' || R0.HOLY_TYPE);
            FOR R1 IN ( SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
                              , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.HOLIDAY_CHECK
                              , WD.WORK_TYPE_ID, WD.WORK_TYPE
                              , WD.DUTY_ID, WD.HOLY_TYPE
                              , WD.SOB_ID, WD.ORG_ID
                          FROM HRD_WORK_DATE_GT WD
                         WHERE WD.WORK_DATE      BETWEEN D_START_DATE AND D_END_DATE
                           AND WD.PERSON_ID      = C1.PERSON_ID
                           AND WD.SOB_ID         = C1.SOB_ID
                           AND WD.ORG_ID         = C1.ORG_ID
                      )
            LOOP
              \*-- 근무구분 반영  --*\
              UPDATE HRD_WORK_DATE_GT WD
                SET (WD.DUTY_ID, WD.HOLY_TYPE, WD.TMP_HOLY_TYPE)
                    = (SELECT DC.DUTY_ID
                            , CASE
                                WHEN WD.WORK_TYPE IN('22') THEN               -- 2조 2교대 : 월력 .
                                  CASE
                                    WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '1'    -- 공휴일 - 유휴일.
                                    ELSE R0.HOLY_TYPE
                                  END
                                ELSE                                          -- 3조 2교대 : 월력 .
                                  CASE
                                    WHEN WD.HOLIDAY_CHECK IN('A') THEN '1'      -- 공휴일 - 유휴일.
                                    ELSE R0.HOLY_TYPE
                                  END
                              END AS HOLY_TYPE
                            , CASE
                                 WHEN WD.WORK_TYPE IN('22') THEN -- 2조 2교대 : 월력
                                      CASE
                                          WHEN R0.HOLY_TYPE IN('0', '1') THEN V_PRE_HOLY_TYPE
                                          ELSE R0.HOLY_TYPE
                                      END
                                 ELSE                            -- 3조 2교대 : 월력
                                      CASE
                                          WHEN R0.HOLY_TYPE IN('0', '1') THEN V_PRE_HOLY_TYPE
                                          ELSE R0.HOLY_TYPE
                                      END
                             END AS TMP_HOLY_TYPE
                         FROM HRM_DUTY_CODE_V DC
                        WHERE DC.SOB_ID           = WD.SOB_ID
                          AND DC.ORG_ID           = WD.ORG_ID
                          AND DC.DUTY_CODE        = CASE
                                                      WHEN WD.WORK_TYPE IN('22') THEN  -- 2조 2교대 : 월력 .
                                                        CASE
                                                        --WHEN HWG2.WEEK_TYPE IN('1', '7') THEN '53'
                                                          WHEN WD.HOLIDAY_CHECK IN('A', 'Y') THEN '51'  -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '1' THEN '51'   -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '0' THEN '52'   -- 무휴일.
                                                          ELSE '00'
                                                        END
                                                      ELSE                                          \*--< 3조 2교대 : 월력 > --*\
                                                        CASE
                                                          WHEN WD.HOLIDAY_CHECK IN('A') THEN '51'  -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '1' THEN '51'   -- 유휴일.
                                                          WHEN R0.HOLY_TYPE = '0' THEN '52'   -- 무휴일.
                                                          ELSE '00'
                                                        END
                                                    END)
               WHERE WD.WORK_DATE      = R1.WORK_DATE
                 AND WD.PERSON_ID      = R1.PERSON_ID
                 AND WD.SOB_ID         = R1.SOB_ID
                 AND WD.ORG_ID         = R1.ORG_ID;
  --DBMS_OUTPUT.PUT_LINE('WORK_DATE : ' || TO_CHAR(R1.WORK_DATE, 'YYYY-MM-DD') || '// PERSON ID : ' || R1.PERSON_ID);
            END LOOP  R1;
            D_START_DATE := D_END_DATE + 1;
          END LOOP R0;
        END LOOP CNT;
      END IF;
-------------------------------------------------------------------------------

      \*=========================================================================================/
       --> OPEN 시간 CLOSE 시간 설정
      /=========================================================================================*\
      UPDATE HRD_WORK_DATE_GT WD
        SET (WD.OPEN_TIME, WD.CLOSE_TIME)
            =
            (SELECT TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.I_TIME, 'YYYY-MM-DD HH24:MI') + WIT.I_ADD_DAYS AS OPEN_TIME
                   , TO_DATE(TO_CHAR(WD.WORK_DATE, 'YYYY-MM-DD') || '-' || WIT.O_TIME, 'YYYY-MM-DD HH24:MI') + WIT.O_ADD_DAYS AS OPEN_TIME
                FROM HRM_WORK_IO_TIME_V WIT
              WHERE WIT.WORK_TYPE      = WD.WORK_TYPE
                AND WIT.HOLY_TYPE      = WD.HOLY_TYPE
                AND WIT.ENABLED_FLAG   = 'Y'
                AND WIT.EFFECTIVE_DATE_FR <= WD.WORK_DATE
                AND (WIT.EFFECTIVE_DATE_TO IS NULL OR WIT.EFFECTIVE_DATE_TO >= WD.WORK_DATE)
               AND WIT.SOB_ID         = WD.SOB_ID
               AND WIT.ORG_ID         = WD.ORG_ID
             )
      WHERE WD.WORK_DATE               BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
        AND WD.PERSON_ID               = C1.PERSON_ID
        AND WD.SOB_ID                  = P_SOB_ID
        AND WD.ORG_ID                  = P_ORG_ID
      ;

     \*=========================================================================================/
      --> 일괄 INSERT 실시
     /=========================================================================================*\
      INSERT INTO HRD_WORK_CALENDAR
      (WORK_DATE, PERSON_ID, WORK_CORP_ID, CORP_ID
      , WORK_YYYYMM, WORK_WEEK, WORK_TYPE_ID
      , DUTY_ID, HOLY_TYPE, OPEN_TIME, CLOSE_TIME
      , ATTRIBUTE5
      , SOB_ID, ORG_ID
      , CREATION_DATE, CREATED_BY, LAST_UPDATE_DATE, LAST_UPDATED_BY
      , ATTRIBUTE3, ATTRIBUTE2)
      (SELECT WD.WORK_DATE, WD.PERSON_ID, WD.WORK_CORP_ID, WD.CORP_ID
      , WD.WORK_YYYYMM, WD.WORK_WEEK, WD.WORK_TYPE_ID
      , WD.DUTY_ID, WD.HOLY_TYPE, WD.OPEN_TIME, WD.CLOSE_TIME
      , WD.WORK_TYPE AS ATTRIBUTE5
      , WD.SOB_ID, WD.ORG_ID
      , D_SYSDATE, P_USER_ID, D_SYSDATE, P_USER_ID
      , WD.TMP_HOLY_TYPE, WD.CREATE_TYPE
      FROM HRD_WORK_DATE_GT WD
      WHERE WD.WORK_DATE        BETWEEN P_WORK_DATE_FR AND P_WORK_DATE_TO
      AND WD.SOB_ID           = P_SOB_ID
      AND WD.ORG_ID           = P_ORG_ID
      );
      \*--> 임시테이블 DATA 삭제 <--*\
      DELETE FROM HRD_WORK_DATE_GT;*/
    END LOOP C1;

END;
