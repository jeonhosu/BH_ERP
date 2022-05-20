CREATE OR REPLACE PACKAGE HRM_WEB_G AS
/******************************************************************************
   NAME:       HRM_WEB_G
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2011-08-01             1. Created this package.
******************************************************************************/

----------------------------------------
-- ERP HRM Login Check
----------------------------------------
  PROCEDURE HRM_WEB_LOGIN_CHECK ( P_CURSOR                  OUT     TYPES.TCURSOR
                                , W_PERSON_NUM              IN      VARCHAR2
                                , W_PASS_WORD               IN      VARCHAR2 );
                                
----------------------------------------
-- ERP HRM Menu
----------------------------------------
  PROCEDURE HRM_WEB_MENU_SELECT ( P_CURSOR                  OUT     TYPES.TCURSOR
                                , P_CURSOR1                 OUT     TYPES.TCURSOR1
                                , P_CURSOR2                 OUT     TYPES.TCURSOR2
                                , W_PERSON_NUM              IN      VARCHAR2 );
                                
----------------------------------------
-- ERP HRM Menu Function
----------------------------------------
  PROCEDURE HRM_WEB_MENU_FUNCTION ( P_CURSOR                OUT     TYPES.TCURSOR
                                  , P_CURSOR1               OUT     TYPES.TCURSOR1
                                  , W_PERSON_NUM            IN      VARCHAR2
                                  , W_MODULE_CODE           IN      VARCHAR2 );                                
                                                                
----------------------------------------
-- ERP HRM 근태 내역 조회
----------------------------------------
  PROCEDURE HRM_WEB_WORKING_LIST ( P_CURSOR                 OUT     TYPES.TCURSOR
                                 , W_PERSON_NUM             IN      VARCHAR2
                                 , W_FROM_DATE              IN      VARCHAR2
                                 , W_TO_DATE                IN      VARCHAR2 );
                                 
----------------------------------------
-- ERP HRM 근태 마감 내역 조회
----------------------------------------
  PROCEDURE HRM_WEB_WORKING_CLOSE ( P_CURSOR                OUT     TYPES.TCURSOR
                                  , W_PERSON_NUM            IN      VARCHAR2
                                  , W_FROM_DATE             IN      VARCHAR2
                                  , W_TO_DATE               IN      VARCHAR2 );
                                  
----------------------------------------
-- ERP HRM 개인 확인 처리
----------------------------------------
  PROCEDURE HRM_WEB_PERSON_CHECK ( W_PERSON_ID              IN      NUMBER
                                 , W_WORK_DATE              IN      VARCHAR2
                                 , W_WORK_CORP_ID           IN      NUMBER
                                 , W_SOB_ID                 IN      NUMBER
                                 , W_ORG_ID                 IN      NUMBER
                                 , P_RESULT                 OUT     INT
                                 , P_MSG                    OUT     VARCHAR2 );
                                 
----------------------------------------
-- ERP HRM 급여 인적 사항 조회
----------------------------------------
  PROCEDURE MONTH_PAYMENT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_DUTY_TIME
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_DUTY_ETC
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );

  PROCEDURE MONTH_PAYMENT_TOTAL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            );
                        
---------------------------------------------------------------------------------------------------
-- 급상여 지급내역 조회
  PROCEDURE SELECT_MONTH_ALLOWANCE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            );
            
---------------------------------------------------------------------------------------------------
-- 급상여 공제내역 조회 / 삽입 / 수정.
  PROCEDURE SELECT_MONTH_DEDUCTION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            );
                                                                  
END HRM_WEB_G;
/
CREATE OR REPLACE PACKAGE BODY HRM_WEB_G AS
/******************************************************************************
   NAME:       HRM_WEB_G
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2011-08-01             1. Created this package.
******************************************************************************/

----------------------------------------
-- ERP Login Check
----------------------------------------
  PROCEDURE HRM_WEB_LOGIN_CHECK ( P_CURSOR                  OUT     TYPES.TCURSOR
                                , W_PERSON_NUM              IN      VARCHAR2
                                , W_PASS_WORD               IN      VARCHAR2 )
  IS
     V_CNT                        INT;

  BEGIN
     SELECT COUNT(PERSON_NUM)
       INTO V_CNT
       FROM HRM_PERSON_MASTER 
      WHERE UPPER(PERSON_NUM) = UPPER(W_PERSON_NUM);
     
     IF V_CNT > 0 THEN       
         OPEN P_CURSOR FOR
             SELECT PERSON_NUM
                  , PERSON_NUM
                  , NAME
                  , 'A'
                  , '100'
               FROM HRM_PERSON_MASTER 
              WHERE UPPER(PERSON_NUM) = UPPER(W_PERSON_NUM)
                AND LENGTH(REPRE_NUM) > 13
                AND SUBSTR(REPRE_NUM, 8, 7) = W_PASS_WORD;
     ELSE
         OPEN P_CURSOR FOR
             SELECT 'NO'
               FROM DUAL;
     END IF;

  END;
  
  
  
----------------------------------------
-- ERP HRM Menu
----------------------------------------
  PROCEDURE HRM_WEB_MENU_SELECT ( P_CURSOR                  OUT     TYPES.TCURSOR
                                , P_CURSOR1                 OUT     TYPES.TCURSOR1
                                , P_CURSOR2                 OUT     TYPES.TCURSOR2
                                , W_PERSON_NUM              IN      VARCHAR2 )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT 'H01' SYS_MI_CODE
              , '인사관리' SYS_MI_NAME
              , 'WEB' UD_FIELD1
           FROM DUAL;
           
     OPEN P_CURSOR1 FOR
         SELECT 'H01_F01' FUNCTION_CODE
              , '근태관리' SYS_MI_NAME
              , 'H01' MODULE_CODE
           FROM DUAL
         UNION ALL
         SELECT 'H01_F02' FUNCTION_CODE
              , '급여관리' SYS_MI_NAME
              , 'H01' MODULE_CODE
           FROM DUAL;
     
     OPEN P_CURSOR2 FOR
         SELECT 'H01_F01_001' SCREEN_CODE
              , '일일근태현황' SCREEN_NAME
              , 'H01' MODULE_CODE
              , 'H01_F01' FUNCTION_CODE
              , 'R' AUTH_TYPE
              , '일일 근태내역......................' SCREEN_DESC
           FROM DUAL
         UNION ALL
         SELECT 'H01_F02_001' SCREEN_CODE
              , '급여현황' SCREEN_NAME
              , 'H01' MODULE_CODE
              , 'H01_F02' FUNCTION_CODE
              , 'R' AUTH_TYPE
              , '월별 급여내역..................' SCREEN_DESC
           FROM DUAL;

  END;
  
  
  
----------------------------------------
-- ERP HRM Menu Function
----------------------------------------
  PROCEDURE HRM_WEB_MENU_FUNCTION ( P_CURSOR                OUT     TYPES.TCURSOR
                                  , P_CURSOR1               OUT     TYPES.TCURSOR1
                                  , W_PERSON_NUM            IN      VARCHAR2
                                  , W_MODULE_CODE           IN      VARCHAR2 )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT 'H01_F01' FUNCTION_CODE
              , '근태관리' SYS_MI_NAME
              , 'H01' MODULE_CODE
           FROM DUAL
         UNION ALL
         SELECT 'H01_F02' FUNCTION_CODE
              , '급여관리' SYS_MI_NAME
              , 'H01' MODULE_CODE
           FROM DUAL;
     
     OPEN P_CURSOR1 FOR
         SELECT 'H01_F01_001' SCREEN_CODE
              , '일일근태현황' SCREEN_NAME
              , 'H01' MODULE_CODE
              , 'H01_F01' FUNCTION_CODE
              , 'R' AUTH_TYPE
              , '일일 근태내역......................' SCREEN_DESC
           FROM DUAL
         UNION ALL
         SELECT 'H01_F02_001' SCREEN_CODE
              , '급여현황' SCREEN_NAME
              , 'H01' MODULE_CODE
              , 'H01_F02' FUNCTION_CODE
              , 'R' AUTH_TYPE
              , '월별 급여내역..................' SCREEN_DESC
           FROM DUAL;

  END;
  
  
  
----------------------------------------
-- ERP HRM 근태 내역 조회
----------------------------------------
  PROCEDURE HRM_WEB_WORKING_LIST ( P_CURSOR                 OUT     TYPES.TCURSOR
                                 , W_PERSON_NUM             IN      VARCHAR2
                                 , W_FROM_DATE              IN      VARCHAR2
                                 , W_TO_DATE                IN      VARCHAR2 )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT PERSON_CHECK_YN
              , TO_CHAR(WORK_DATE, 'YYYY-MM-DD') WORK_DATE
              , DISPLAY_NAME
              , FLOOR_NAME
              , DUTY_NAME
              , HOLY_TYPE_NAME
              , TO_CHAR(OPEN_TIME,'MM-DD HH24:MI:SS') OPEN_TIME     -- 출근시간
              , TO_CHAR(CLOSE_TIME,'MM-DD HH24:MI:SS') CLOSE_TIME   -- 퇴근시간
              , TO_CHAR(BEFORE_OT_START,'MM-DD HH24:MI') || NVL2(BEFORE_OT_START, ' ~ ', '') || TO_CHAR(BEFORE_OT_END,'MM-DD HH24:MI') BEFORE_OT_TIME --근무전 연장 시간
              , TO_CHAR(AFTER_OT_START,'MM-DD HH24:MI') || NVL2(AFTER_OT_START, ' ~ ', '') || TO_CHAR(AFTER_OT_END,'MM-DD HH24:MI') AFTER_OT_TIME    --근무후 연장 시간
              , BREAKFAST_YN    --조식 
              , LUNCH_YN        --중식
              , DINNER_YN       --석식
              , MIDNIGHT_YN     --야식
              , ALL_NIGHT_YN    --철야
              , APPROVE_STATUS_NAME
              , DECODE(PERSON_CHECK_YN, 'Y', '확인', '미확인') PERSON_CHECK_NAME
              , TO_CHAR(PERSON_CHECK_DATE,'MM-DD HH24:MI:SS') PERSON_CHECK_DATE
              , PERSON_ID
              , WORK_CORP_ID
              , SOB_ID
              , ORG_ID
          FROM (SELECT DI.WORK_DATE AS WORK_DATE
                     , PM.DISPLAY_NAME AS DISPLAY_NAME
                     , HRM_COMMON_G.ID_NAME_F(T1.FLOOR_ID) AS FLOOR_NAME
                     , HRM_COMMON_G.ID_NAME_F(DI.DUTY_ID) AS DUTY_NAME
                     , HRM_COMMON_G.CODE_NAME_F('HOLY_TYPE', DI.HOLY_TYPE, DI.SOB_ID, DI.ORG_ID) AS HOLY_TYPE_NAME
                     --, CASE WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                     --  ELSE DI.OPEN_TIME
                     --  END AS OPEN_TIME
                     --, CASE WHEN (DI.NEXT_DAY_YN = 'Y' OR DI.HOLY_TYPE IN('3', 'N') OR DI.DANGJIK_YN = 'Y' OR DI.ALL_NIGHT_YN = 'Y') THEN
                     --       DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, N_DI.CLOSE_TIME)
                     --  WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                     --  ELSE DI.CLOSE_TIME
                     --  END AS CLOSE_TIME
                     --, HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID) AS APPROVE_STATUS_NAME
                      , CASE
                             WHEN DI.MODIFY_IN_YN = 'Y' THEN I_DM.MODIFY_TIME
                             ELSE DI.OPEN_TIME
                        END AS OPEN_TIME
                      , CASE
                             WHEN (DI.NEXT_DAY_YN   = 'Y'
                                OR DI.HOLY_TYPE    IN('N', '3')
                                OR DI.DANGJIK_YN    = 'Y'
                                OR DI.ALL_NIGHT_YN  = 'Y') THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME
                                                                                                                   FROM HRD_DAY_INTERFACE S_DI
                                                                                                                  WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                                                    AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                                                    AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                                                    AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                                                    AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                                                                ))
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID = 1187 -- 휴일근무
                                                             AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                            THEN DECODE(DI.MODIFY_OUT_YN
                                                                       , 'Y', O_DM.MODIFY_TIME
                                                                       , (SELECT S_DI.CLOSE_TIME
                                                                            FROM HRD_DAY_INTERFACE     S_DI
                                                                           WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                             AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                             AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                             AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                             AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                         ))
                             WHEN (SELECT S_DI.HOLY_TYPE
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = '3' -- 야간
                                      AND(DI.DUTY_ID        = 1174 -- 경조휴가
                                       OR DI.DUTY_ID        = 1170 -- 교육
                                       OR DI.DUTY_ID        = 1175 -- 년차
                                       OR DI.DUTY_ID        = 1189 -- 무급휴가
                                       OR DI.DUTY_ID        = 1182 -- 무급휴일
                                       OR DI.DUTY_ID        = 1172 -- 파견
                                       OR DI.DUTY_ID        = 1190 -- 유급휴가
                                       OR DI.DUTY_ID        = 1173 -- 출장
                                       OR DI.DUTY_ID        = 1171 -- 훈련
                                       OR DI.DUTY_ID        = 1188 -- 휴일
                                         ) THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188 -- 휴일
                                                       AND (SELECT S_DI.ALL_NIGHT_YN
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN NULL
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID IN ( 1173 -- 출장
                                                                         , 1174 -- 경조휴가
                                                                         , 1175 -- 년차
                                                                         , 1177 -- 보건휴가
                                                                         , 1178 -- 연중휴가
                                                                         , 1179 -- 대체휴무
                                                                         , 1182 -- 무급휴일
                                                                         , 1187 -- 휴일근무
                                                                         , 1188 -- 휴일
                                                                         , 1189 -- 무급휴가
                                                                         , 1190 -- 유급휴가
                                                                         , 1194 -- 당직
                                                                         , 3784 -- 철야
                                                                         )
                                                   AND (
                                                            (SELECT S_DI.DUTY_ID
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 1187 -- 휴일근무
                                                         OR
                                                            (SELECT S_DI.ALL_NIGHT_YN
                                                               FROM HRD_DAY_INTERFACE     S_DI
                                                              WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                            ) = 'Y'  -- 철야
                                                       ) THEN NULL
                             WHEN (SELECT S_DI.NEXT_DAY_YN
                                     FROM HRD_DAY_INTERFACE   S_DI
                                    WHERE S_DI.SOB_ID       = DI.SOB_ID
                                      AND S_DI.ORG_ID       = DI.ORG_ID
                                      AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                      AND S_DI.PERSON_ID    = DI.PERSON_ID
                                      AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                  ) = 'Y' -- 후일퇴근
                                      AND(DI.DUTY_ID        = 1174 -- 경조휴가
                                       OR DI.DUTY_ID        = 1170 -- 교육
                                       OR DI.DUTY_ID        = 1175 -- 년차
                                       OR DI.DUTY_ID        = 1189 -- 무급휴가
                                       OR DI.DUTY_ID        = 1182 -- 무급휴일
                                       OR DI.DUTY_ID        = 1172 -- 파견
                                       OR DI.DUTY_ID        = 1190 -- 유급휴가
                                       OR DI.DUTY_ID        = 1173 -- 출장
                                       OR DI.DUTY_ID        = 1171 -- 훈련
                                       OR DI.DUTY_ID        = 1188 -- 휴일
                                         ) THEN NULL
                             WHEN DI.DUTY_ID        = 1168 -- 출근
                                  AND (SELECT S_DI.NEXT_DAY_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- 후일퇴근
                                      THEN DECODE(DI.MODIFY_OUT_YN, 'Y', O_DM.MODIFY_TIME, (SELECT S_DI.CLOSE_TIME1
                                                                                              FROM HRD_DAY_INTERFACE S_DI
                                                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                                               AND S_DI.WORK_DATE     =  DI.WORK_DATE
                                                                                           ))
                             WHEN DI.DUTY_ID  = 1168 -- 출근
                                  AND DI.OPEN_TIME  IS NULL
                                  AND (SELECT S_DI.ALL_NIGHT_YN
                                         FROM HRD_DAY_INTERFACE   S_DI
                                        WHERE S_DI.SOB_ID       = DI.SOB_ID
                                          AND S_DI.ORG_ID       = DI.ORG_ID
                                          AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                          AND S_DI.PERSON_ID    = DI.PERSON_ID
                                          AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                      ) = 'Y' -- 전일 철야
                                      THEN NULL
                             WHEN DI.MODIFY_OUT_YN = 'Y' THEN O_DM.MODIFY_TIME
                             ELSE DI.CLOSE_TIME
                        END           AS CLOSE_TIME
                      , DI.BEFORE_OT_START
                      , DI.BEFORE_OT_END
                      , DI.AFTER_OT_START
                      , DI.AFTER_OT_END
                      , DI.BREAKFAST_YN
                      , DI.LUNCH_YN
                      , DI.DINNER_YN
                      , DI.MIDNIGHT_YN
                      , DI.ALL_NIGHT_YN
                      , CASE WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1187 THEN '' -- 휴일근무
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1168 -- 출근
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1169 -- 결근
                                                       AND DI.HOLY_TYPE  = '2' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND(SELECT S_DI.HOLY_TYPE
                                                             FROM HRD_DAY_INTERFACE   S_DI
                                                            WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                              AND S_DI.ORG_ID       = DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                              AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                          ) = '3' -- 야간
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1168 -- 출근
                                                       AND DI.HOLY_TYPE  = '3'  -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NOT NULL
                                                       AND DI.CLOSE_TIME IS NULL
                                                       AND DI.DUTY_ID    = 1168  -- 출근
                                                       AND DI.HOLY_TYPE  = '3'   -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.DUTY_ID    = 1169  -- 결근
                                                       AND DI.HOLY_TYPE  = '3'   -- 야간
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                            ) IS NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NOT NULL
                                                       AND DI.CLOSE_TIME   IS NULL
                                                       AND DI.DUTY_ID      = 1187 -- 휴일근무
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                       AND DI.HOLY_TYPE    = '1'  -- 휴일
                                                       AND (SELECT S_DI.CLOSE_TIME
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                           ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    = 1188      -- 휴일
                                                       AND (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                              FROM HRD_DAY_INTERFACE_V   S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND DI.DUTY_ID    =  1177 -- 보건휴가
                                                       AND (SELECT DI.HOLY_TYPE
                                                              FROM HRD_DAY_INTERFACE     S_DI
                                                             WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                               AND S_DI.ORG_ID        =  DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                               AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                           ) = '3' THEN '' -- 야간
                             WHEN DI.HOLY_TYPE IN ('0', '1') AND DI.DUTY_ID   = 1187 -- 휴일근무
                                                             AND DI.OPEN_TIME > TO_DATE(TO_CHAR(DI.OPEN_TIME, 'YYYY-MM-DD') || ' ' || '17:30:00', 'YYYY-MM-DD HH24:MI:SS')
                                                             AND (SELECT S_DI.CLOSE_TIME
                                                                    FROM HRD_DAY_INTERFACE     S_DI
                                                                   WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                                     AND S_DI.ORG_ID        =  DI.ORG_ID
                                                                     AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                                     AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                                     AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                                 ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.CLOSE_TIME IS NOT NULL
                                                       AND(SELECT S_DI.DUTY_ID -- 휴일근무
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187 -- 휴일근무
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND(SELECT S_DI.CLOSE_TIME
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                          ) IS NOT NULL
                                                       AND(DI.DUTY_ID = 1174 -- 경조휴가
                                                        OR DI.DUTY_ID = 1170 -- 교육
                                                        OR DI.DUTY_ID = 1175 -- 년차
                                                        OR DI.DUTY_ID = 1179 -- 대체휴무
                                                        OR DI.DUTY_ID = 1189 -- 무급휴가
                                                        OR DI.DUTY_ID = 1182 -- 무급휴일
                                                        OR DI.DUTY_ID = 1177 -- 보건휴가
                                                        OR DI.DUTY_ID = 1178 -- 연중휴가
                                                        OR DI.DUTY_ID = 1190 -- 유급휴가
                                                        OR DI.DUTY_ID = 1172 -- 파견
                                                        OR DI.DUTY_ID = 1173 -- 출장
                                                        OR DI.DUTY_ID = 1171 -- 훈련
                                                        OR DI.DUTY_ID = 1188 -- 휴일
                                                          ) THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.DUTY_ID      = 1187 -- 휴일근무
                                                       AND DI.ALL_NIGHT_YN = 'Y'  -- 철야
                                                       AND DI.OPEN_TIME    IS NOT NULL
                                                       AND(SELECT S_DI.CLOSE_TIME
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE + 1)
                                                          ) IS NOT NULL THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME    IS NULL
                                                       AND DI.CLOSE_TIME   IS NOT NULL
                                                       AND(SELECT S_DI.DUTY_ID -- 휴일근무
                                                             FROM HRD_DAY_INTERFACE     S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 1187  -- 휴일근무
                                                       AND(SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                             FROM HRD_DAY_INTERFACE_V   S_DI
                                                            WHERE S_DI.SOB_ID        =  DI.SOB_ID
                                                              AND S_DI.ORG_ID        =  DI.ORG_ID
                                                              AND S_DI.WORK_CORP_ID  =  DI.WORK_CORP_ID
                                                              AND S_DI.PERSON_ID     =  DI.PERSON_ID
                                                              AND S_DI.WORK_DATE     = (DI.WORK_DATE - 1)
                                                          ) = 'Y' THEN ''
                             WHEN DI.MODIFY_FLAG = 'N' AND DI.OPEN_TIME  IS NULL
                                                       AND DI.CLOSE_TIME IS NOT NULL
                                                       AND((SELECT S_DI.HOLY_TYPE    -- 야간
                                                              FROM HRD_DAY_INTERFACE   S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = '3'
                                                        OR (SELECT S_DI.ALL_NIGHT_YN -- 철야
                                                              FROM HRD_DAY_INTERFACE_V S_DI
                                                             WHERE S_DI.SOB_ID       = DI.SOB_ID
                                                               AND S_DI.ORG_ID       = DI.ORG_ID
                                                               AND S_DI.WORK_CORP_ID = DI.WORK_CORP_ID
                                                               AND S_DI.PERSON_ID    = DI.PERSON_ID
                                                               AND S_DI.WORK_DATE    =(DI.WORK_DATE - 1)
                                                           ) = 'Y') THEN ''
                             ELSE HRM_COMMON_G.CODE_NAME_F('DUTY_APPROVE_STATUS', DI.APPROVE_STATUS, DI.SOB_ID, DI.ORG_ID)
                        END  AS APPROVE_STATUS_NAME
                     , DI.PERSON_ID
                     , DI.WORK_CORP_ID
                     , DI.SOB_ID
                     , DI.ORG_ID
                     , DI.PERSON_CHECK_YN
                     , DI.PERSON_CHECK_DATE
                  FROM HRD_DAY_INTERFACE_V DI
                     , HRM_PERSON_MASTER PM
                     , HRM_FLOOR_V HF
                     , HRM_POST_CODE_V PC
                     , (SELECT HL.PERSON_ID
                             , HL.DEPT_ID
                             , HL.POST_ID
                             , HL.JOB_CATEGORY_ID
                             , HL.FLOOR_ID
                          FROM HRM_HISTORY_LINE HL
                          WHERE HL.HISTORY_LINE_ID  IN ( SELECT MAX(S_HL.HISTORY_LINE_ID) AS HISTORY_LINE_ID
                                                           FROM HRM_HISTORY_LINE S_HL
                                                          WHERE S_HL.CHARGE_DATE            <= TO_DATE(W_TO_DATE, 'YYYY-MM-DD')
                                                            AND S_HL.PERSON_ID              = HL.PERSON_ID
                                                          GROUP BY S_HL.PERSON_ID )) T1
                     , HRD_DAY_MODIFY I_DM
                     , HRD_DAY_MODIFY O_DM
                     , ( SELECT DIT.WORK_DATE - 1 AS WORK_DATE
                              , DIT.PERSON_ID
                              , DIT.CORP_ID
                              , DIT.SOB_ID
                              , DIT.ORG_ID
                              , DIT.OPEN_TIME
                              , DIT.CLOSE_TIME
                              , DIT.OPEN_TIME1
                              , DIT.CLOSE_TIME1
                           FROM HRD_DAY_INTERFACE DIT
                          WHERE DIT.WORK_DATE     BETWEEN TO_DATE(W_FROM_DATE, 'YYYY-MM-DD') + 1 AND TO_DATE(W_TO_DATE, 'YYYY-MM-DD') + 1 ) N_DI
                     , ( SELECT DL.WORK_DATE
                              , DL.PERSON_ID
                              , DL.WORK_CORP_ID
                              , DL.SOB_ID
                              , DL.ORG_ID
                              , DL.LEAVE_TIME
                              , DL.LATE_TIME
                              , DL.REST_TIME
                              , DL.OVER_TIME
                              , DL.HOLIDAY_TIME
                              , DL.NIGHT_TIME
                              , DL.NIGHT_BONUS_TIME
                           FROM HRD_DAY_LEAVE_V2 DL
                          WHERE DL.WORK_DATE      BETWEEN TO_DATE(W_FROM_DATE, 'YYYY-MM-DD') AND TO_DATE(W_TO_DATE, 'YYYY-MM-DD')
                            AND DL.CLOSED_YN      = 'Y' ) S_DL
                     WHERE DI.PERSON_ID                          = PM.PERSON_ID
                       AND DI.WORK_CORP_ID                       = PM.WORK_CORP_ID
                       AND DI.SOB_ID                             = PM.SOB_ID
                       AND DI.ORG_ID                             = PM.ORG_ID
                       AND PM.FLOOR_ID                           = HF.FLOOR_ID
                       AND PM.POST_ID                            = PC.POST_ID
                       AND PM.PERSON_ID                          = T1.PERSON_ID
                       AND DI.PERSON_ID                          = I_DM.PERSON_ID(+)
                       AND DI.WORK_DATE                          = I_DM.WORK_DATE(+)
                       AND '1'                                   = I_DM.IO_FLAG(+)
                       AND DI.PERSON_ID                          = O_DM.PERSON_ID(+)
                       AND DI.WORK_DATE                          = O_DM.WORK_DATE(+)
                       AND '2'                                   = O_DM.IO_FLAG(+)
                       AND DI.WORK_DATE                          = N_DI.WORK_DATE(+)
                       AND DI.PERSON_ID                          = N_DI.PERSON_ID(+)
                       AND DI.SOB_ID                             = N_DI.SOB_ID(+)
                       AND DI.ORG_ID                             = N_DI.ORG_ID(+)
                       AND DI.WORK_DATE                          = S_DL.WORK_DATE(+)
                       AND DI.PERSON_ID                          = S_DL.PERSON_ID(+)
                       AND DI.SOB_ID                             = S_DL.SOB_ID(+)
                       AND DI.ORG_ID                             = S_DL.ORG_ID(+)
                       AND DI.WORK_DATE                          BETWEEN TO_DATE(W_FROM_DATE, 'YYYY-MM-DD') AND TO_DATE(W_TO_DATE, 'YYYY-MM-DD')
                       AND DI.SOB_ID                             = 10
                       AND DI.ORG_ID                             = 101
                       AND PM.PERSON_NUM                         = W_PERSON_NUM
                      -- AND PM.JOIN_DATE                          <= TO_DATE(W_TO_DATE, 'YYYY-MM-DD')
                      -- AND (PM.RETIRE_DATE IS NULL OR PM.RETIRE_DATE >= TO_DATE(W_FROM_DATE, 'YYYY-MM-DD'))
                     ORDER BY HF.FLOOR_CODE,
                              PM.WORK_TYPE_ID,
                              PC.SORT_NUM,
                              PM.NAME,
                              DI.WORK_DATE);
  END;
  
  
  
----------------------------------------
-- ERP HRM 근태 마감 내역 조회
----------------------------------------
  PROCEDURE HRM_WEB_WORKING_CLOSE ( P_CURSOR                OUT     TYPES.TCURSOR
                                  , W_PERSON_NUM            IN      VARCHAR2
                                  , W_FROM_DATE             IN      VARCHAR2
                                  , W_TO_DATE               IN      VARCHAR2 )
  IS

  BEGIN
     OPEN P_CURSOR FOR
         SELECT PM.DISPLAY_NAME AS DISPLAY_NAME2
              , TRIM(TO_CHAR(NVL(DL.LEAVE_TIME,0),'9,990.99'))       LEAVE_TIME  
              , TRIM(TO_CHAR(NVL(DL.LATE_TIME,0),'9,990.99'))        LATE_TIME   
              , TRIM(TO_CHAR(NVL(DL.REST_TIME,0),'9,990.99'))        REST_TIME   
              , TRIM(TO_CHAR(NVL(DL.OVER_TIME,0),'9,990.99'))        OVER_TIME   
              , TRIM(TO_CHAR(NVL(DL.HOLIDAY_TIME,0),'9,990.99'))     HOLIDAY_TIME  
              , TRIM(TO_CHAR(NVL(DL.NIGHT_TIME,0),'9,990.99'))       NIGHT_TIME    
              , TRIM(TO_CHAR(NVL(DL.NIGHT_BONUS_TIME,0),'9,990.99')) NIGHT_BONUS_TIME
          
         /*
              , NVL(DL.LEAVE_TIME,0)       LEAVE_TIME  
              , NVL(DL.LATE_TIME,0)        LATE_TIME   
              , NVL(DL.REST_TIME,0)        REST_TIME   
              , NVL(DL.OVER_TIME,0)        OVER_TIME   
              , NVL(DL.HOLIDAY_TIME,0)     HOLIDAY_TIME  
              , NVL(DL.NIGHT_TIME,0)       NIGHT_TIME    
              , NVL(DL.NIGHT_BONUS_TIME,0) NIGHT_BONUS_TIME
         */
         
              , ( SELECT COUNT(PERSON_CHECK_YN)
                    FROM HRD_DAY_INTERFACE_V
                   WHERE PERSON_ID       = PM.PERSON_ID
                     AND WORK_DATE       BETWEEN TO_DATE(W_FROM_DATE, 'YYYY-MM-DD') AND TO_DATE(W_TO_DATE, 'YYYY-MM-DD') 
                     AND PERSON_CHECK_YN = 'N' ) PERSON_CHECK_YN          
           FROM HRM_PERSON_MASTER PM  
              , (SELECT DL.PERSON_ID  
                      , SUM(NVL(DL.LEAVE_TIME,0)) LEAVE_TIME  
                      , SUM(NVL(DL.LATE_TIME,0)) LATE_TIME                    
                      , SUM(NVL(DL.REST_TIME,0)) REST_TIME                    
                      , SUM(NVL(DL.OVER_TIME,0)) OVER_TIME                    
                      , SUM(NVL(DL.HOLIDAY_TIME,0)) HOLIDAY_TIME
                      , SUM(NVL(DL.HOLIDAY_OT_TIME,0)) NIGHT_TIME  
                      --, SUM(NVL(DL.NIGHT_TIME,0)) NIGHT_TIME                 
                      , SUM(NVL(DL.NIGHT_BONUS_TIME,0)) NIGHT_BONUS_TIME  
                   FROM HRD_DAY_LEAVE_V2 DL  
                  WHERE DL.WORK_DATE BETWEEN TO_DATE(W_FROM_DATE, 'YYYY-MM-DD') AND TO_DATE(W_TO_DATE, 'YYYY-MM-DD')  
                    AND DL.SOB_ID = 10  
                  GROUP BY DL.PERSON_ID) DL  
          WHERE PM.PERSON_NUM = W_PERSON_NUM
            AND PM.PERSON_ID = DL.PERSON_ID (+);
  END;
  
  
  
----------------------------------------
-- ERP HRM 개인 확인 처리
----------------------------------------
  PROCEDURE HRM_WEB_PERSON_CHECK ( W_PERSON_ID              IN      NUMBER
                                 , W_WORK_DATE              IN      VARCHAR2
                                 , W_WORK_CORP_ID           IN      NUMBER
                                 , W_SOB_ID                 IN      NUMBER
                                 , W_ORG_ID                 IN      NUMBER
                                 , P_RESULT                 OUT     INT
                                 , P_MSG                    OUT     VARCHAR2 )
  IS

  BEGIN
     P_RESULT := 0;
  
     UPDATE HRD_DAY_INTERFACE 
        SET PERSON_CHECK_YN   = 'Y'
          , PERSON_CHECK_DATE = SYSDATE
          , PERSON_CHECK_BY   = W_PERSON_ID
      WHERE PERSON_ID         = W_PERSON_ID
        AND WORK_DATE         = W_WORK_DATE
        AND WORK_CORP_ID      = W_WORK_CORP_ID 
        AND SOB_ID            = W_SOB_ID
        AND ORG_ID            = W_ORG_ID;
        
     P_RESULT := 1;
     
  EXCEPTION
     WHEN OTHERS THEN 
         P_MSG := '전산 오류가 발생했습니다!' || CHR(13) || CHR(13) || '전산 관리자에게 연락하십시요!' || CHR(13) || CHR(13) || SQLERRM;
         RETURN;        
  END;
  
  
  
  PROCEDURE MONTH_PAYMENT_PERSON
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_SYSDATE                     DATE := GET_LOCAL_DATE(W_SOB_ID);
    V_CLOSED_YN                   VARCHAR2(2) := 'N';
    V_OPEN_DATE                   DATE;
    V_BONUS_YYYYMM                VARCHAR2(10);
    V_BONUS_TYPE                  VARCHAR2(10) := 'P2';
  BEGIN
    BEGIN
      SELECT NVL(HC.CLOSING_YN, 'N') AS CLOSING_YN
          , HC.OPEN_DATE
        INTO V_CLOSED_YN
          , V_OPEN_DATE
        FROM HRM_CLOSING HC
      WHERE HC.CLOSING_YYYYMM         = W_PAY_YYYYMM
        AND HC.SOB_ID                 = W_SOB_ID
        AND HC.ORG_ID                 = W_ORG_ID
        AND HC.CORP_ID                = ( SELECT CORP_ID
                                            FROM HRM_PERSON_MASTER 
                                           WHERE PERSON_ID = W_PERSON_ID )
        AND EXISTS
              ( SELECT 'X'
                  FROM HRM_CLOSING_TYPE_V CT
                WHERE CT.CLOSING_TYPE_ID  = HC.CLOSING_TYPE_ID
                  AND CT.CLOSING_TYPE     = W_WAGE_TYPE
              )
      ;
    EXCEPTION WHEN OTHERS THEN
      V_CLOSED_YN := '-';
    END;
    IF V_CLOSED_YN = '-' THEN
      RAISE_APPLICATION_ERROR(-20001, '해당 급상여 년월에 대한 마감정보를 찾을수 없습니다. 담당자에게 문의하세요');
      RETURN;  
    ELSIF V_CLOSED_YN = 'N' THEN
      RAISE_APPLICATION_ERROR(-20001, '해당 급상여 년월에 대해 마감처리가 되지 않았습니다. 담당자에게 문의하세요');
      RETURN;
    ELSIF V_SYSDATE < NVL(V_OPEN_DATE, V_SYSDATE + 1) THEN
      RAISE_APPLICATION_ERROR(-20001, '해당 급상여 년월에 대해 오픈처리가 되지 않았습니다. 담당자에게 문의하세요');
      RETURN;
    END IF;
    
    BEGIN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;  -- fck 적용할 경우 사용 : TO_CHAR(ADD_MONTHS(TO_DATE(W_PAY_YYYYMM, 'YYYY-MM'), 1), 'YYYY-MM');
    EXCEPTION WHEN OTHERS THEN
      V_BONUS_YYYYMM := W_PAY_YYYYMM;
    END;
    OPEN P_CURSOR FOR
      -- 기본정보.
      SELECT  MP.CORP_ID
            , MP.PERSON_ID
            , MIN(MP.WAGE_TYPE) AS WAGE_TYPE            
            , MIN(MP.PAY_YYYYMM) AS PAY_YYYYMM
            , PM.NAME                                                    -- 성명.
            , PM.PERSON_NUM                                              -- 사원번호.
            , DM.DEPT_NAME AS DEPT_NAME                                  -- 부서;
            , PC.POST_NAME                                               -- 직위.
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID) AS JOB_CLASS_NAME  -- 직군;
            , MAX(MP.SUPPLY_DATE) AS SUPPLY_DATE                         -- 지급일자.
            , S_PMH.BANK_NAME                                            -- 입금은행.
            , MAX(RPAD(SUBSTR(S_PMH.BANK_ACCOUNTS, 1, LENGTH(S_PMH.BANK_ACCOUNTS) - 6), LENGTH(S_PMH.BANK_ACCOUNTS), '*')) AS BANK_ACCOUNTS  -- 입급계좌번호.
            , CASE
                WHEN SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_SUPPLY_AMOUNT, 0)) <> 0 OR SUM(DECODE(MP.WAGE_TYPE, 'P2', MP.TOT_DED_AMOUNT, 0)) <> 0 THEN
                     SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '년 [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '월 급여 / '  || SUBSTR(MAX(MP.PAY_YYYYMM), 6, 2) || '월 상여] 지급명세서' 
                ELSE SUBSTR(MIN(MP.PAY_YYYYMM), 1, 4) || '년 [' || SUBSTR(MIN(MP.PAY_YYYYMM), 6, 2) || '월 급여] 지급명세서'
              END AS WAGE_TYPE_NAME  -- (년월)급여명세서.
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
          , HRM_DEPT_MASTER DM
          , HRM_POST_CODE_V PC
          , ( SELECT PMH.PERSON_ID
                   , PMH.BANK_ID
                   , HRM_COMMON_G.ID_NAME_F(PMH.BANK_ID) AS BANK_NAME
                   , PMH.BANK_ACCOUNTS
                   , PMH.PAY_TYPE
                   , PMH.SOB_ID
                   , PMH.ORG_ID
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.START_YYYYMM        <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM          >= W_PAY_YYYYMM
                AND PMH.SOB_ID              = W_SOB_ID
                AND PMH.ORG_ID              = W_ORG_ID
            ) S_PMH
      WHERE MP.PERSON_ID            = PM.PERSON_ID
        AND MP.DEPT_ID              = DM.DEPT_ID
        AND MP.POST_ID              = PC.POST_ID
        AND MP.PERSON_ID            = S_PMH.PERSON_ID
        AND ((MP.PAY_YYYYMM         = W_PAY_YYYYMM
          AND MP.WAGE_TYPE          = W_WAGE_TYPE)
        OR (MP.PAY_YYYYMM           = V_BONUS_YYYYMM
          AND MP.WAGE_TYPE          = V_BONUS_TYPE))
        AND PM.PERSON_ID            = W_PERSON_ID
        AND MP.SOB_ID               = W_SOB_ID
        AND MP.ORG_ID               = W_ORG_ID
        AND (MP.TOT_SUPPLY_AMOUNT       <> 0
           AND MP.TOT_DED_AMOUNT         <> 0)
      GROUP BY MP.CORP_ID
            , MP.PERSON_ID
            , MP.SOB_ID
            , MP.ORG_ID
            , PM.NAME
            , PM.PERSON_NUM
            , DM.DEPT_SORT_NUM
            , DM.DEPT_CODE
            , DM.DEPT_NAME
            , PC.POST_CODE
            , PC.POST_NAME
            , HRM_COMMON_G.ID_NAME_F(PM.JOB_CLASS_ID)
            , S_PMH.BANK_NAME
            , MP.DESCRIPTION
            , PC.SORT_NUM
            , MP.PAY_TYPE
      ORDER BY DM.DEPT_CODE, PC.SORT_NUM, PM.PERSON_NUM
      ;
  END MONTH_PAYMENT_PERSON;

-- 2. 근무시간 / 급여현황
  PROCEDURE MONTH_DUTY_TIME
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_DUTY_TYPE                   VARCHAR2(10);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
  BEGIN
    IF W_WAGE_TYPE = 'P1' THEN
        V_DUTY_TYPE := 'D2';
    ELSE
        V_DUTY_TYPE := '-';
    END IF; 

    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => W_PAY_YYYYMM
                      , W_WAGE_TYPE => W_WAGE_TYPE
                      , W_PAY_TYPE => '1'
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
                      
    OPEN P_CURSOR FOR
      SELECT '근무시간' AS TITLE_NAME
           , MT.TOTAL_ATT_DAY * 8 AS TOTAL_ATT_TIME                            -- 기본근무시간;
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.OVER_TIME, 0)
               ELSE NVL(MTO.REST_TIME, 0) + NVL(MTO.OVER_TIME, 0) + NVL(MTO.NIGHT_TIME, 0) + NVL(MTO.HOLY_1_OT, 0) + NVL(MTO.HOLY_0_OT, 0) 
             END AS OVER_TIME                                                  -- 연장근무.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN NVL(MTO.NIGHT_TIME, 0) 
               ELSE NVL(MTO.NIGHT_BONUS_TIME, 0)  + NVL(MTO.HOLY_1_NIGHT, 0) + NVL(MTO.HOLY_0_NIGHT, 0)
             END AS NIGHT_BONUS_TIME                                           -- 야간근무.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.HOLIDAY_TIME, 0)
             END AS HOLIDAY_TIME                                               -- 휴일근무.
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.HOLY_1_OT, 0)
             END AS HOLY_1_OT                                                  -- 휴일연장근무.  
           , CASE 
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN 0
               ELSE NVL(MTO.LATE_TIME, 0) + NVL(MTO.LEAVE_TIME, 0)
             END AS LATE_TIME                                                  -- 근태공제시간;
           , NVL(S_HM.CREATION_NUM, 0) AS CREATION_NUM                         -- 년차발생수.
           , NVL(S_HM.REMAIN_NUM, 0) AS REMAIN_NUM                             -- 년차 잔여수.
           , (CASE
               WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT
               ELSE 0
              END) AS BASIC_TIME_AMOUNT                                        -- 시급.
           , (CASE
               WHEN S_PMH.PAY_TYPE = '2' THEN S_PMH.BASIC_AMOUNT
               ELSE 0
              END) AS BASIC_DAILY_AMOUNT                                       -- 일급.
           , (CASE
               WHEN S_PMH.PAY_TYPE IN('1', '3') THEN S_PMH.BASIC_AMOUNT
               ELSE 0
              END) AS BASIC_AMOUNT                                             -- 기본급.
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
          , ( SELECT PMH.PERSON_ID
                   , PMH.PAY_TYPE
                   , (SELECT PML.ALLOWANCE_AMOUNT
                        FROM HRP_PAY_MASTER_LINE PML
                      WHERE PML.PAY_HEADER_ID     = PMH.PAY_HEADER_ID
                        AND EXISTS (SELECT 'X'
                                      FROM HRM_ALLOWANCE_V HA
                                    WHERE HA.ALLOWANCE_ID  = PML.ALLOWANCE_ID
                                      AND HA.ALLOWANCE_TYPE   = 'BASIC'
                                      AND HA.SOB_ID           = W_SOB_ID
                                      AND HA.ORG_ID           = W_ORG_ID
                                    )
                     ) AS BASIC_AMOUNT
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.START_YYYYMM        <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM          >= W_PAY_YYYYMM
                AND PMH.SOB_ID              = W_SOB_ID
                AND PMH.ORG_ID              = W_ORG_ID
             ) S_PMH
          , (SELECT HM.PERSON_ID
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS CREATION_NUM
                 , NVL(HM.USE_NUM, 0) AS USE_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM
              FROM HRD_HOLIDAY_MANAGEMENT HM
             WHERE HM.PERSON_ID             = W_PERSON_ID
               AND HM.HOLIDAY_TYPE          = '1'
               AND HM.DUTY_YEAR             = SUBSTR(W_PAY_YYYYMM, 1, 4)
               AND HM.SOB_ID                = W_SOB_ID
               AND HM.ORG_ID                = W_ORG_ID
             ) S_HM
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID(+)
        AND MT.PERSON_ID               = S_HM.PERSON_ID(+)
        AND MT.DUTY_TYPE               = V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
        AND MT.PERSON_ID               = W_PERSON_ID
        AND MT.SOB_ID                  = W_SOB_ID
        AND MT.ORG_ID                  = W_ORG_ID
      ;
  END MONTH_DUTY_TIME;

-- 3. 부가내역 / 연차현황
  PROCEDURE MONTH_DUTY_ETC
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS
    V_DUTY_TYPE                   VARCHAR2(10);
    V_START_DATE                  DATE;
    V_END_DATE                    DATE;
  BEGIN
    IF W_WAGE_TYPE = 'P1' THEN
        V_DUTY_TYPE := 'D2';
    ELSE
        V_DUTY_TYPE := '-';
    END IF; 
    
    HRP_PAYMENT_G_SET.PAYMENT_TERM
                      ( W_PAY_YYYYMM => W_PAY_YYYYMM
                      , W_WAGE_TYPE => W_WAGE_TYPE
                      , W_PAY_TYPE => '1'
                      , W_SOB_ID => W_SOB_ID
                      , W_ORG_ID => W_ORG_ID
                      , O_START_DATE => V_START_DATE
                      , O_END_DATE => V_END_DATE
                      );
                      
    OPEN P_CURSOR FOR
      SELECT CASE
               WHEN S_PMH.PAY_TYPE = '4' THEN S_PMH.BASIC_AMOUNT * 8
               WHEN S_PMH.PAY_TYPE = '2' THEN S_PMH.BASIC_AMOUNT
                 WHEN S_PMH.PAY_TYPE IN('1', '3') THEN TRUNC(S_PMH.BASIC_AMOUNT / 209)
               ELSE 0
             END AS GENERAL_DAILY_AMOUNT                                              -- 기본일급.
           , MT.TOTAL_ATT_DAY AS TOTAL_ATT_DAY                                        -- 근무일수;
           , MT.HOLY_1_COUNT                                                          -- 주휴일수;
           , MT.HOLY_0_COUNT                                                          -- 무휴일수;
           , HRD_HOLIDAY_CALENDAR_G.HOLIDAY_COUNT(V_START_DATE, V_END_DATE, MT.PERSON_ID, MT.SOB_ID, MT.ORG_ID) AS S_HOLY_1_COUNT  -- 공휴일수.
           , MTD.DUTY_11                                                              -- 결근.           
           , MT.LATE_DED_COUNT                                                        -- 지각수.
           , NVL(S_HM.CREATION_NUM, 0) AS CREATION_NUM                                -- 년차발생수.
           , NVL(MTD.DUTY_20, 0) AS DUTY_20                                           -- 당월 연차사용수.
           , NVL(S_HM.USE_NUM, 0) AS USE_NUM                                          -- 년차 누적사용수.
           , NVL(S_HM.REMAIN_NUM, 0) AS REMAIN_NUM                                    -- 년차 잔여수.
           
        FROM HRD_MONTH_TOTAL MT
          , HRD_MONTH_TOTAL_OT_2_V MTO
          , HRD_MONTH_TOTAL_DUTY_V MTD
          , (SELECT HM.PERSON_ID
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) AS CREATION_NUM
                 , NVL(HM.USE_NUM, 0) AS USE_NUM
                 , NVL(HM.PRE_NEXT_NUM, 0) + NVL(HM.CREATION_NUM, 0) + NVL(HM.PLUS_NUM, 0) - NVL(HM.USE_NUM, 0) AS REMAIN_NUM
              FROM HRD_HOLIDAY_MANAGEMENT HM
             WHERE HM.PERSON_ID             = W_PERSON_ID
               AND HM.HOLIDAY_TYPE          = '1'
               AND HM.DUTY_YEAR             = SUBSTR(W_PAY_YYYYMM, 1, 4)
               AND HM.SOB_ID                = W_SOB_ID
               AND HM.ORG_ID                = W_ORG_ID
             ) S_HM
          , ( SELECT PMH.PERSON_ID
                   , PMH.PAY_TYPE
                   , (SELECT PML.ALLOWANCE_AMOUNT
                        FROM HRP_PAY_MASTER_LINE PML
                      WHERE PML.PAY_HEADER_ID     = PMH.PAY_HEADER_ID
                        AND EXISTS (SELECT 'X'
                                      FROM HRM_ALLOWANCE_V HA
                                    WHERE HA.ALLOWANCE_ID  = PML.ALLOWANCE_ID
                                      AND HA.ALLOWANCE_TYPE   = 'BASIC'
                                      AND HA.SOB_ID           = W_SOB_ID
                                      AND HA.ORG_ID           = W_ORG_ID
                                    )
                     ) AS BASIC_AMOUNT
                FROM HRP_PAY_MASTER_HEADER PMH
              WHERE PMH.START_YYYYMM        <= W_PAY_YYYYMM
                AND PMH.END_YYYYMM          >= W_PAY_YYYYMM
                AND PMH.SOB_ID              = W_SOB_ID
                AND PMH.ORG_ID              = W_ORG_ID
             ) S_PMH
      WHERE MT.MONTH_TOTAL_ID          = MTO.MONTH_TOTAL_ID(+)
        AND MT.MONTH_TOTAL_ID          = MTD.MONTH_TOTAL_ID(+)
        AND MT.PERSON_ID               = S_HM.PERSON_ID(+)
        AND MT.PERSON_ID               = S_PMH.PERSON_ID(+)
        AND MT.DUTY_TYPE               = V_DUTY_TYPE
        AND MT.DUTY_YYYYMM             = W_PAY_YYYYMM
        AND MT.PERSON_ID               = W_PERSON_ID
        AND MT.SOB_ID                  = W_SOB_ID
        AND MT.ORG_ID                  = W_ORG_ID
      ;
  END MONTH_DUTY_ETC;

-- 5. 지급합계;  
  PROCEDURE MONTH_PAYMENT_TOTAL
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN VARCHAR2
            , W_WAGE_TYPE         IN VARCHAR2
            , W_PERSON_ID         IN NUMBER
            , W_SOB_ID            IN NUMBER
            , W_ORG_ID            IN NUMBER
            )
  AS

  BEGIN
    OPEN P_CURSOR FOR
      -- 기본정보.
      SELECT  MP.CORP_ID
            , MP.PERSON_ID
            , TRIM(TO_CHAR(NVL(SUM(MP.REAL_AMOUNT), 0), '999,999,999')) AS REAL_AMOUNT  -- 총 실지급액.
            , TRIM(TO_CHAR(NVL(SUM(MP.TOT_SUPPLY_AMOUNT), 0), '999,999,999')) AS TOT_SUPPLY_AMOUNT  -- 총지급액.
            , TRIM(TO_CHAR(NVL(SUM(MP.TOT_DED_AMOUNT), 0), '999,999,999')) AS TOT_DED_AMOUNT  -- 총공제액.
        FROM HRP_MONTH_PAYMENT MP
          , HRM_PERSON_MASTER PM
      WHERE MP.PERSON_ID            = PM.PERSON_ID
        AND MP.PAY_YYYYMM           = W_PAY_YYYYMM
        AND MP.WAGE_TYPE            = W_WAGE_TYPE
        AND PM.PERSON_ID            = W_PERSON_ID
        AND MP.SOB_ID               = W_SOB_ID
        AND MP.ORG_ID               = W_ORG_ID
        AND (MP.TOT_SUPPLY_AMOUNT       <> 0
           AND MP.TOT_DED_AMOUNT         <> 0)
      GROUP BY MP.CORP_ID
            , MP.PERSON_ID
      ;
  END MONTH_PAYMENT_TOTAL;



---------------------------------------------------------------------------------------------------
-- 급상여 지급내역 조회
  PROCEDURE SELECT_MONTH_ALLOWANCE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_MONTH_ALLOWANCE.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_ALLOWANCE.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_ALLOWANCE.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_ALLOWANCE.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_ALLOWANCE.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HA.ALLOWANCE_NAME AS ALLOWANCE_NAME
           , MA.ALLOWANCE_AMOUNT
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_ALLOWANCE MA
          , HRM_ALLOWANCE_V HA
       WHERE MP.MONTH_PAYMENT_ID        = MA.MONTH_PAYMENT_ID
         AND MA.ALLOWANCE_ID            = HA.ALLOWANCE_ID
         AND MA.SOB_ID                  = HA.SOB_ID
         AND MA.ORG_ID                  = HA.ORG_ID
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = W_WAGE_TYPE
         AND MP.PERSON_ID               = W_PERSON_ID   
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
         AND MP.TOT_SUPPLY_AMOUNT       <> 0
      ORDER BY HA.SORT_NUM, HA.ALLOWANCE_CODE
     ;
  END SELECT_MONTH_ALLOWANCE;
  
---------------------------------------------------------------------------------------------------
-- 급상여 공제내역 조회 / 삽입 / 수정.
  PROCEDURE SELECT_MONTH_DEDUCTION
            ( P_CURSOR            OUT TYPES.TCURSOR
            , W_PAY_YYYYMM        IN HRP_MONTH_DEDUCTION.PAY_YYYYMM%TYPE
            , W_WAGE_TYPE         IN HRP_MONTH_DEDUCTION.WAGE_TYPE%TYPE
            , W_PERSON_ID         IN HRP_MONTH_DEDUCTION.PERSON_ID%TYPE
            , W_SOB_ID            IN HRP_MONTH_DEDUCTION.SOB_ID%TYPE
            , W_ORG_ID            IN HRP_MONTH_DEDUCTION.ORG_ID%TYPE
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT HD.DEDUCTION_NAME AS DEDUCTION_NAME
           , MD.DEDUCTION_AMOUNT AS DEDUCTION_AMOUNT
        FROM HRP_MONTH_PAYMENT MP
          , HRP_MONTH_DEDUCTION MD
          , HRM_DEDUCTION_V HD
       WHERE MP.MONTH_PAYMENT_ID        = MD.MONTH_PAYMENT_ID
         AND MD.DEDUCTION_ID            = HD.DEDUCTION_ID
         AND MD.SOB_ID                  = HD.SOB_ID
         AND MD.ORG_ID                  = HD.ORG_ID
         AND MP.PAY_YYYYMM              = W_PAY_YYYYMM
         AND MP.WAGE_TYPE               = W_WAGE_TYPE
         AND MP.PERSON_ID               = W_PERSON_ID   
         AND MP.SOB_ID                  = W_SOB_ID
         AND MP.ORG_ID                  = W_ORG_ID
         AND MP.TOT_DED_AMOUNT          <> 0
      ORDER BY HD.SORT_NUM, HD.DEDUCTION_CODE
     ;
  END SELECT_MONTH_DEDUCTION;


END HRM_WEB_G; 
/
