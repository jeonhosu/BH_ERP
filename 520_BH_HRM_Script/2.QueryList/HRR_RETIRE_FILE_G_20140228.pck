CREATE OR REPLACE PACKAGE HRR_RETIRE_FILE_G
AS

-------------------------------------------------------------------------------
-- 퇴직정산 지급조서 생성 대상 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE_FILE_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  VARCHAR2 
            , P_START_DATE        IN  DATE
            , P_END_DATE          IN  DATE
            , P_CORP_ID           IN  NUMBER 
            , P_SOB_ID            IN  NUMBER 
            , P_ORG_ID            IN  NUMBER 
            , P_CONNECT_PERSON_ID IN  NUMBER
            );

-------------------------------------------------------------------------------
-- 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  VARCHAR2 
            , P_START_DATE        IN  DATE
            , P_END_DATE          IN  DATE
            , P_CORP_ID           IN  NUMBER 
            , P_OPERATING_UNIT_ID IN  NUMBER  
            , P_SOB_ID            IN  NUMBER 
            , P_ORG_ID            IN  NUMBER 
            , P_CONNECT_PERSON_ID IN  NUMBER
            , P_TAX_AGENT         IN  VARCHAR2
            , P_TAX_PROGRAM_CODE  IN  VARCHAR2
            , P_USE_LANGUAGE_CODE IN  VARCHAR2
            , P_SUBMIT_AGENT      IN  VARCHAR2
            , P_SUBMIT_PERIOD     IN  VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN  VARCHAR2
            , P_WRITE_DATE        IN  DATE
            );

-------------------------------------------------------------------------------
-- 퇴직소득 파일생성 : 생성된 인원수 RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_RETIRE_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_NOW_COUNT     OUT NUMBER 
            , O_REC_PRE_COUNT     OUT NUMBER 
            );
            
            
-------------------------------------------------------------------------------
-- 2011년도 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SET_RETIRE_FILE_2011
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_AGENT         IN VARCHAR2
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_USE_LANGUAGE_CODE IN VARCHAR2
            , P_SUBMIT_AGENT      IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            );

-------------------------------------------------------------------------------
-- 2012년도 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SET_RETIRE_FILE_2012
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_AGENT         IN VARCHAR2
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_USE_LANGUAGE_CODE IN VARCHAR2
            , P_SUBMIT_AGENT      IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            );

-------------------------------------------------------------------------------
-- 2013년도 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SET_RETIRE_FILE_2013
            ( P_YEAR_YYYY         IN  VARCHAR2 
            , P_START_DATE        IN  DATE
            , P_END_DATE          IN  DATE
            , P_CORP_ID           IN  NUMBER 
            , P_OPERATING_UNIT_ID IN  NUMBER  
            , P_SOB_ID            IN  NUMBER 
            , P_ORG_ID            IN  NUMBER 
            , P_CONNECT_PERSON_ID IN  NUMBER
            , P_TAX_AGENT         IN  VARCHAR2
            , P_TAX_PROGRAM_CODE  IN  VARCHAR2
            , P_USE_LANGUAGE_CODE IN  VARCHAR2
            , P_SUBMIT_AGENT      IN  VARCHAR2
            , P_SUBMIT_PERIOD     IN  VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN  VARCHAR2
            , P_WRITE_DATE        IN  DATE
            );
                        
            
-------------------------------------------------------------------------------
-- 파일 DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
            , P_RECORD_TYPE       IN VARCHAR2 DEFAULT NULL 
            );

END HRR_RETIRE_FILE_G;
/
CREATE OR REPLACE PACKAGE BODY HRR_RETIRE_FILE_G
AS
/******************************************************************************/
/* Project      : FPCB ERP
/* Module       : FCM
/* Program Name : HRR_RETIRE_FILE_G
/* Description  : 퇴직정산 계산 관리.
/*
/* Reference by :
/* Program History :
/*------------------------------------------------------------------------------
/*   Date       In Charge          Description
/*------------------------------------------------------------------------------
/* 18-MAR-2011  Lee Sun Hee        Initialize
/******************************************************************************/
-------------------------------------------------------------------------------
-- 퇴직정산 지급조서 생성 대상 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE_FILE_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  VARCHAR2 
            , P_START_DATE        IN  DATE
            , P_END_DATE          IN  DATE
            , P_CORP_ID           IN  NUMBER 
            , P_SOB_ID            IN  NUMBER 
            , P_ORG_ID            IN  NUMBER 
            , P_CONNECT_PERSON_ID IN  NUMBER
            )
  AS
  BEGIN
    OPEN P_CURSOR FOR
      SELECT 'N' AS SELECT_YN
           , CASE
               WHEN GROUPING(OU.VAT_NUMBER) = 1 THEN PT_TOTAL_SUM
               ELSE OU.OPERATING_UNIT_NAME
             END AS OPERATING_UNIT_NAME
           , OU.PRESIDENT_NAME
           , OU.VAT_NUMBER
           , OU.TAX_OFFICE_CODE
           , OU.TAX_OFFICE_NAME
           , SUM(NVL(S_RA.PERSON_COUNT, 0)) AS NOW_PERSON_COUNT
           , 0 AS REC_NOW_PERSON_COUNT
           , SUM(NVL(S_RA.PRE_PERSON_COUNT, 0)) AS PRE_PERSON_COUNT
           , 0 AS REC_PRE_PERSON_COUNT
           , SUM(NVL(S_RA.TOTAL_AMOUNT, 0)) AS TOTAL_AMOUNT
           , SUM(NVL(S_RA.INCOME_TAX_AMOUNT, 0)) AS INCOME_TAX_AMOUNT
           , SUM(NVL(S_RA.RESIDENT_TAX_AMOUNT, 0)) AS RESIDENT_TAX_AMOUNT
           , SUM(NVL(S_RA.SP_TAX_AMOUNT, 0)) AS SP_TAX_AMOUNT
           , SUM(NVL(S_RA.SUM_TAX_AMOUNT, 0)) AS SUM_TAX_AMOUNT
           , NVL(OU.CORP_ID, NULL) AS CORP_ID
           , NVL(OU.OPERATING_UNIT_ID, NULL) AS OPERATING_UNIT_ID
        FROM HRM_CORP_MASTER    CM
           , HRM_OPERATING_UNIT OU
          , ( SELECT RA.ADJUSTMENT_YYYY
                  , RA.CORP_ID
                  --, T1.OPERATING_UNIT_ID
                  , COUNT(RA.PERSON_ID) AS PERSON_COUNT
                  , 0 AS PRE_PERSON_COUNT
                  , SUM(NVL(RA.RETIRE_TOTAL_AMOUNT, 0)) AS TOTAL_AMOUNT
                  , SUM((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                         NVL(RA.COMP_TAX_AMOUNT_2, 0))) AS INCOME_TAX_AMOUNT
                  , SUM(TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                               NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)) AS RESIDENT_TAX_AMOUNT
                  , SUM(NVL(RA.SP_TAX_AMOUNT, 0)) AS SP_TAX_AMOUNT
                  , SUM((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                         NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                         TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                               NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) + 
                         NVL(RA.SP_TAX_AMOUNT, 0)) AS SUM_TAX_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER     PM
                   /*, ( -- 시점 인사내역.
                        SELECT HL.PERSON_ID
                             , HL.OPERATING_UNIT_ID
                          FROM HRM_HISTORY_HEADER HH
                             , HRM_HISTORY_LINE   HL 
                         WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                           AND HH.CHARGE_SEQ           IN 
                                (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                    FROM HRM_HISTORY_HEADER S_HH
                                       , HRM_HISTORY_LINE   S_HL
                                   WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                     AND S_HH.CHARGE_DATE       <= P_END_DATE
                                     AND S_HL.PERSON_ID         = HL.PERSON_ID
                                   GROUP BY S_HL.PERSON_ID
                                 )      
                      ) T1*/
               WHERE RA.PERSON_ID       = PM.PERSON_ID
                 /*AND PM.PERSON_ID       = T1.PERSON_ID */
                 AND RA.ADJUSTMENT_YYYY = P_YEAR_YYYY
                 AND RA.CORP_ID         = P_CORP_ID
                 AND RA.SOB_ID          = P_SOB_ID
                 AND RA.ORG_ID          = P_ORG_ID
                 AND RA.RETIRE_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE
               GROUP BY RA.ADJUSTMENT_YYYY
                      , RA.CORP_ID
                      --, T1.OPERATING_UNIT_ID
            ) S_RA
      WHERE CM.CORP_ID            = OU.CORP_ID
        --AND OU.OPERATING_UNIT_ID  = S_RA.OPERATING_UNIT_ID
        AND OU.CORP_ID            = P_CORP_ID
        AND OU.USABLE             = 'Y'
        AND OU.START_DATE         <= P_END_DATE
        AND (OU.END_DATE          >= P_START_DATE OR OU.END_DATE IS NULL)   
        AND CM.ENABLED_FLAG       = 'Y'
        AND (OU.DEFAULT_FLAG      = 'Y'
          OR (OU.DEFAULT_FLAG     = 'N'
          AND ROWNUM              <= 1))
     GROUP BY ROLLUP
              ((OU.OPERATING_UNIT_NAME
              , OU.PRESIDENT_NAME
              , OU.VAT_NUMBER
              , OU.TAX_OFFICE_CODE
              , OU.TAX_OFFICE_NAME
              , OU.CORP_ID 
              , OU.OPERATING_UNIT_ID )) 
      ;
  END SELECT_RETIRE_FILE_LIST;

-------------------------------------------------------------------------------
-- 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_YEAR_YYYY         IN  VARCHAR2 
            , P_START_DATE        IN  DATE
            , P_END_DATE          IN  DATE
            , P_CORP_ID           IN  NUMBER 
            , P_OPERATING_UNIT_ID IN  NUMBER  
            , P_SOB_ID            IN  NUMBER 
            , P_ORG_ID            IN  NUMBER 
            , P_CONNECT_PERSON_ID IN  NUMBER
            , P_TAX_AGENT         IN  VARCHAR2
            , P_TAX_PROGRAM_CODE  IN  VARCHAR2
            , P_USE_LANGUAGE_CODE IN  VARCHAR2
            , P_SUBMIT_AGENT      IN  VARCHAR2
            , P_SUBMIT_PERIOD     IN  VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN  VARCHAR2
            , P_WRITE_DATE        IN  DATE
            )
  AS
  BEGIN

    -- TEMPORARY 삭제.
    DELETE FROM HRM_REPORT_FILE_GT RF
    WHERE RF.SOB_ID           = P_SOB_ID
      AND RF.ORG_ID           = P_ORG_ID
    ;
    IF P_YEAR_YYYY = '2011' THEN
      -- 2011년도 --
      SET_RETIRE_FILE_2011
        ( P_YEAR_YYYY         => P_YEAR_YYYY
        , P_START_DATE        => P_START_DATE
        , P_END_DATE          => P_END_DATE
        , P_CORP_ID           => P_CORP_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_CONNECT_PERSON_ID => P_CONNECT_PERSON_ID
        , P_TAX_AGENT         => P_TAX_AGENT
        , P_TAX_PROGRAM_CODE  => P_TAX_PROGRAM_CODE
        , P_USE_LANGUAGE_CODE => P_USE_LANGUAGE_CODE
        , P_SUBMIT_AGENT      => P_SUBMIT_AGENT
        , P_SUBMIT_PERIOD     => P_SUBMIT_PERIOD
        , P_HOMETAX_LOGIN_ID  => P_HOMETAX_LOGIN_ID
        , P_WRITE_DATE        => P_WRITE_DATE
        );
    ELSIF P_YEAR_YYYY = '2012' THEN
      -- 2012년도 --
      SET_RETIRE_FILE_2012
        ( P_YEAR_YYYY         => P_YEAR_YYYY
        , P_START_DATE        => P_START_DATE
        , P_END_DATE          => P_END_DATE
        , P_CORP_ID           => P_CORP_ID
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_CONNECT_PERSON_ID => P_CONNECT_PERSON_ID
        , P_TAX_AGENT         => P_TAX_AGENT
        , P_TAX_PROGRAM_CODE  => P_TAX_PROGRAM_CODE
        , P_USE_LANGUAGE_CODE => P_USE_LANGUAGE_CODE
        , P_SUBMIT_AGENT      => P_SUBMIT_AGENT
        , P_SUBMIT_PERIOD     => P_SUBMIT_PERIOD
        , P_HOMETAX_LOGIN_ID  => P_HOMETAX_LOGIN_ID
        , P_WRITE_DATE        => P_WRITE_DATE
        );
    ELSE
      -- 2013년도 --
      SET_RETIRE_FILE_2013 
        ( P_YEAR_YYYY         => P_YEAR_YYYY
        , P_START_DATE        => P_START_DATE
        , P_END_DATE          => P_END_DATE
        , P_CORP_ID           => P_CORP_ID
        , P_OPERATING_UNIT_ID => P_OPERATING_UNIT_ID 
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_CONNECT_PERSON_ID => P_CONNECT_PERSON_ID
        , P_TAX_AGENT         => P_TAX_AGENT
        , P_TAX_PROGRAM_CODE  => P_TAX_PROGRAM_CODE
        , P_USE_LANGUAGE_CODE => P_USE_LANGUAGE_CODE
        , P_SUBMIT_AGENT      => P_SUBMIT_AGENT
        , P_SUBMIT_PERIOD     => P_SUBMIT_PERIOD
        , P_HOMETAX_LOGIN_ID  => P_HOMETAX_LOGIN_ID
        , P_WRITE_DATE        => P_WRITE_DATE
        );
    END IF;

    OPEN P_CURSOR FOR
      SELECT RF.REPORT_FILE
        FROM HRM_REPORT_FILE_GT RF
      WHERE RF.SOB_ID             = P_SOB_ID
        AND RF.ORG_ID             = P_ORG_ID
        AND RF.SEQ_NUM            IS NOT NULL
      ORDER BY RF.SEQ_NUM, RF.SORT_NUM
      ;
  END SELECT_RETIRE;
  
-------------------------------------------------------------------------------
-- 퇴직소득 파일생성 : 생성된 인원수 RETURN.
-------------------------------------------------------------------------------
  PROCEDURE GET_RETIRE_FILE_P
            ( P_YEAR_YYYY         IN  VARCHAR2
            , P_START_DATE        IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN  HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN  HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_OPERATING_UNIT_ID IN  NUMBER 
            , P_SOB_ID            IN  HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN  HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN  NUMBER
            , O_REC_NOW_COUNT     OUT NUMBER 
            , O_REC_PRE_COUNT     OUT NUMBER 
            )
  AS
  BEGIN
    BEGIN
      SELECT COUNT(RF.SOURCE_FILE) AS COUNT
        INTO O_REC_NOW_COUNT       
        FROM HRM_REPORT_FILE_GT RF
      WHERE /*RF.YEAR_YYYY          = P_YEAR_YYYY
        AND RF.CORP_ID            = P_CORP_ID
        AND RF.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID
        AND */RF.SOB_ID             = P_SOB_ID
        AND RF.ORG_ID             = P_ORG_ID
        AND RF.SEQ_NUM            IS NOT NULL
        AND RF.RECORD_TYPE        = 'C'  -- C RECORD COUNT 
    ;
    EXCEPTION
      WHEN OTHERS THEN
        O_REC_NOW_COUNT := 0;
    END;
  END GET_RETIRE_FILE_P;

-------------------------------------------------------------------------------
-- 2011년도 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SET_RETIRE_FILE_2011
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_AGENT         IN VARCHAR2
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_USE_LANGUAGE_CODE IN VARCHAR2
            , P_SUBMIT_AGENT      IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            )
  AS
    --> 주(현) 업체 정보 변수.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_SEQ_NO                    NUMBER;          -- 레코드 생성 번호.
    V_RECORD_FILE               VARCHAR2(3000);  -- 부양가족 조합위해.
  BEGIN
    -- 전산매체 생성--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '25'  -- 갑종근로소득(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
                    || RPAD(' ', 812, ' ') AS RECORD_FILE
                  FROM HRM_CORP_MASTER CM
                    , HRM_OPERATING_UNIT OU
                    , ( SELECT PM.PERSON_ID
                            , PM.NAME
                            , PM.DEPT_NAME
                          FROM HRM_PERSON_MASTER_V1 PM
                        WHERE PM.PERSON_ID  = P_CONNECT_PERSON_ID
                      ) S_PM
                WHERE OU.CORP_ID            = CM.CORP_ID
                  AND P_CONNECT_PERSON_ID   = S_PM.PERSON_ID
                  AND CM.CORP_ID            = P_CORP_ID
                  AND CM.SOB_ID             = P_SOB_ID
                  AND CM.ORG_ID             = P_ORG_ID
                  AND CM.ENABLED_FLAG       = 'Y'
                  AND (OU.DEFAULT_FLAG      = 'Y'
                    OR (OU.DEFAULT_FLAG     = 'N'
                    AND ROWNUM              <= 1))
               )
    LOOP
      V_SEQ_NUM := 1;
      V_SOURCE_FILE := 'A_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => A1.RECORD_FILE
        , P_SORT_NUM          => 1
        );
      --DBMS_OUTPUT.PUT_LINE(A1.RECORD_FILE);
--B1 ------------------------------------------------------------------------------------
      FOR B1 IN ( SELECT --> 자료관리번호;
                         'B'    -- 레코드 구분;
                      || '25'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 세무서코드;
                      || LPAD(1, 6, 0)                                      -- B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- 원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- 법인명(상호);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- 대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 법인등록번호;
                      --> 제출내역;
                      || LPAD(NVL(S_RA.PERSON_COUNT, 0), 7, 0)   -- 수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(NVL(S_RA.PRE_PERSON_COUNT, 0), 7, 0)   -- 수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_RA.RETIRE_TOTAL_AMOUNT, 0), 14, 0)    -- 퇴직급여액 총계(C레코드 퇴직급여 합);
                      || LPAD(NVL(S_RA.INCOME_TAX_AMOUNT, 0), 13, 0)  -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009년 연말정산 수정(MODIFIED BY YOUNG MIN) 법인세 결정세액총계->공란으로 변경;
                      || LPAD(NVL(S_RA.RESIDENT_TAX_AMOUNT, 0), 13, 0) -- 지방세 결정세액 총계;
                      || LPAD(NVL(S_RA.SP_TAX_AMOUNT, 0), 13, 0) -- 농특세 결정세액 총계;
                      || LPAD(NVL(SUM_TAX_AMOUNT, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정(MODIFIED BY YOUNG MIN) 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 791, ' ') AS RECORD_FILE
                      , CM.CORP_NAME  -- 법인명.
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
                          SELECT RA.ADJUSTMENT_YYYY
                              , RA.CORP_ID
                              , COUNT(RA.PERSON_ID) PERSON_COUNT 
                              , 0 AS PRE_PERSON_COUNT
                              , SUM(NVL(RA.RETIRE_TOTAL_AMOUNT, 0)) AS RETIRE_TOTAL_AMOUNT
                              , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0)) INCOME_TAX_AMOUNT
                              , SUM(NVL(RA.RESIDENT_TAX_AMOUNT, 0)) RESIDENT_TAX_AMOUNT
                              , SUM(NVL(RA.SP_TAX_AMOUNT, 0)) SP_TAX_AMOUNT
                              , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0)) AS SUM_TAX_AMOUNT
                            FROM HRR_RETIRE_ADJUSTMENT RA
                          WHERE RA.ADJUSTMENT_YYYY = P_YEAR_YYYY
                            AND RA.CORP_ID         = P_CORP_ID
                            AND RA.SOB_ID          = P_SOB_ID
                            AND RA.ORG_ID          = P_ORG_ID
                            AND RA.RETIRE_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE
                            AND RA.CLOSED_YN       = 'Y'
                          GROUP BY RA.ADJUSTMENT_YYYY
                                , RA.CORP_ID
                        ) S_RA
                    WHERE CM.CORP_ID        = OU.CORP_ID
                      AND P_YEAR_YYYY       = S_RA.ADJUSTMENT_YYYY
                      AND CM.ENABLED_FLAG   = 'Y'
                      AND (OU.DEFAULT_FLAG  = 'Y'
                        OR (OU.DEFAULT_FLAG = 'N'
                        AND ROWNUM          <= 1))
                  )
        LOOP
          V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
          V_SOURCE_FILE := 'B_RECORD';
          INSERT_REPORT_FILE
            ( P_SEQ_NUM           => V_SEQ_NUM
            , P_SOURCE_FILE       => V_SOURCE_FILE
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            , P_REPORT_FILE       => B1.RECORD_FILE
            , P_SORT_NUM          => 1
            );
          --DBMS_OUTPUT.PUT_LINE(B1.RECORD_FILE);
--C1 ------------------------------------------------------------------------------------
        FOR C1 IN ( SELECT
                          'C'                                           -- 1.자료관리번호.
                        || '25'                                         -- 2.
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4. 일련번호.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. 사업자번호.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 6. 주현 근무처 사업자번호.
                        || RPAD(NVL(B1.CORP_NAME, ' '), 40, ' ')       -- 7. 주현 근무처명.
                        || LPAD(0, 2, 0)      -- 8. 종(전)근무처 수;
                        || RPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 9. 거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 10.거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || RPAD(CASE
                                  WHEN PM.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END, 8, 0)  -- 11. 근무기간 시작연월일;
                        || RPAD(CASE
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN
                                    TO_CHAR(PM.RETIRE_DATE, 'YYYYMMDD')
                                  ELSE P_YEAR_YYYY || '1231'
                                END, 8, 0)  -- 12. 근무기간 종료연월일;
                        || RPAD(PM.NAME, 30, ' ')  -- 13. 성명;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN '1'  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN '1'  -- 1800년대생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'  -- 외국인.
                                END, 1, 0)  -- 14. 내/외국인 구분코드;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 15.주민등록번호;
                        || RPAD(CASE
                                  WHEN RA.ADJUSTMENT_TYPE = 'M' THEN '5'
                                  WHEN PC.POST_CODE < '200' THEN '4'
                                  ELSE NVL(S_RT.RETIRE_GROUP_CODE, '3')
                                END, 1, 0)  -- 16.퇴직사유.                        
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 17.퇴직급여(법정).
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 18.퇴직급여(법정이외).
                        || LPAD(0, 10, 0) -- 19.퇴직연금일시금(법정).
                        || LPAD(0, 10, 0) -- 20.퇴직연금일시금(법정이외)수록;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 21.퇴직(법정)급여액계.
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 22.퇴직(법정이외)급여액계.
                        || LPAD(0, 10, 0) -- 23.비과세소득.
                        --> 주(현)근무지 퇴직연금명세.
                        || LPAD(' ', 20, ' ') -- 24.퇴직연금계좌번호;
                        || LPAD(0, 10, 0) -- 25.퇴직연금일시금총수령액.
                        || LPAD(0, 10, 0) -- 26.퇴직연금원리금합계액.
                        || LPAD(0, 10, 0) -- 27.퇴직연금소득자불입액.
                        || LPAD(0, 10, 0) -- 28.퇴직연금소득공제액.
                        || LPAD(0, 10, 0) -- 29.퇴직연금일시금.
                        --> 종(전)근무지 퇴직연금명세.
                        || LPAD(' ', 20, ' ') -- 24-1.퇴직연금계좌번호.
                        || LPAD(0, 10, 0) -- 25-1.퇴직연금일시금총수령액.
                        || LPAD(0, 10, 0) -- 26-1.퇴직연금원리금합계액.
                        || LPAD(0, 10, 0) -- 27-1.퇴직연금소득자불입액.
                        || LPAD(0, 10, 0) -- 28-1.퇴직연금소득공제액.
                        || LPAD(0, 10, 0) -- 29-1.퇴직연금일시금.
                        --> 세액환산명세-법정퇴직급여;
                        || LPAD(0, 10, 0) -- 30.퇴직연금일시금지급예상액-주(현);
                        || LPAD(0, 10, 0) -- 31.퇴직연금일시금지급예상액-종(전);
                        || LPAD(0, 10, 0) -- 32.퇴직연금일시금지급예상액 과세이연금액-주(현)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) -- 33.퇴직연금일시금지급예상액 과세이연금액-종(전)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) -- 34.기수령한퇴직급여액-주(현);
                        || LPAD(0, 10, 0) -- 35.기수령한퇴직급여액-종(전);
                        || LPAD(0, 10, 0) -- 36. 총퇴직연금일시금.
                        || LPAD(0, 10, 0) -- 37. 수령가능퇴직급여액.
                        || LPAD(0, 10, 0) -- 38. 환산퇴직소득공제.
                        || LPAD(0, 10, 0) -- 39. 환산퇴직소득 과세표준.
                        || LPAD(0, 10, 0) -- 40. 환산연평균과세표준.
                        || LPAD(0, 10, 0) -- 41. 환산연평균산출세액.
                       --> 세액환산명세-법정이외 퇴직급여;
                        || LPAD(0, 10, 0) --30-1. 퇴직연금일시금지급예상액-주(현);
                        || LPAD(0, 10, 0) --31-1. 퇴직연금일시금지급예상액-종(전);
                        || LPAD(0, 10, 0) --32-1. 퇴직연금일시금지급예상액 과세이연금액-주(현)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) --33-1. 퇴직연금일시금지급예상액 과세이연금액-종(전)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) --34-1. 기수령한퇴직급여액-주(현);
                        || LPAD(0, 10, 0) --35-1. 기수령한퇴직급여액-종(전);
                        || LPAD(0, 10, 0) --36-1. 총퇴직연금일시금.
                        || LPAD(0, 10, 0) --37-1. 수령가능 퇴직급여액.
                        || LPAD(0, 10, 0) --38-1. 환산퇴직소득공제.
                        || LPAD(0, 10, 0) --39-1. 환산퇴직소득 과세표준.
                        || LPAD(0, 10, 0) --40-1. 환산연평균과세표준.
                        || LPAD(0, 10, 0) --41-1. 환산연평균산출세액.
                        -- 근속연수-법정퇴직급여.
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0) --42. 주(현)근무지 입사연월일;
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0) --43. 종(전)근무지 입사연월일;
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0) --44. 주(현)근무지 근속월수.
                        || LPAD(CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 
                                    THEN  CASE 
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                            ELSE TRUNC(RA.DED_DAY / 30)
                                          END
                                  ELSE 0
                                END, 4, 0) -- 45. 주(현)근무지 제외월수.
                        || LPAD(0, 8, 0) -- 46. 종(전)근무지 입사연월일.
                        || LPAD(0, 8, 0) -- 47. 종(전)근무지 퇴사연월일.
                        || LPAD(0, 4, 0) -- 48. 종(전)근무지 근속월수.
                        || LPAD(0, 4, 0) -- 49. 종(전)근무지 제외월수.
                        || LPAD(0, 4, 0) -- 50. 중복월수.
                        || LPAD(NVL(RA.LONG_YEAR, 0), 2, 0) --51. 근속연수.
                        --> 근속연수 -법정이외 퇴직급여;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_FR, RA.RETIRE_DATE_FR), 'YYYYMMDD'), '0'), 8, 0) -- 42-1. 주(현)근무지 입사연월일;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_TO, RA.RETIRE_DATE_TO), 'YYYYMMDD'), '0'), 8, 0) -- 43-1. 주(현)근무지 퇴사연월일;
                        || LPAD(DECODE(NVL(RA.H_LONG_MONTH, 0), 0, NVL(RA.LONG_MONTH, 0), NVL(RA.H_LONG_MONTH, 0)), 4, 0) -- 44-1. 주(현)근무지 근속월수.
                        || LPAD(/*CASE 
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 0 THEN 0
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 1 THEN 1
                                  ELSE TRUNC(NVL(RA.DED_DAY / 30)
                                END*/0, 4, 0) -- 45-1. 주(현)근무지 제외월수.
                        || LPAD(0, 8, 0) -- 46-1. 종(전)근무지 입사연월일.
                        || LPAD(0, 8, 0) -- 47-1. 종(전)근무지 퇴사연월일.
                        || LPAD(0, 4, 0) -- 48-1. 종(전)근무지 근속월수.
                        || LPAD(0, 4, 0) -- 49-1. 종(전)근무지 제외월수.
                        || LPAD(0, 4, 0) -- 50-1. 중복월수.
                        || LPAD(DECODE(NVL(RA.H_LONG_YEAR, 0), 0, NVL(RA.LONG_YEAR, 0), NVL(RA.H_LONG_YEAR, 0)), 2, 0) -- 51-1. 근속연수.
                        --> 정산명세 - 법정퇴직급여;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 52.퇴직급여액.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 53. 퇴직소득공제.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 10, 0) -- 54. 퇴직소득과세표준.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 55. 연평균과세표준.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 56. 연평균 산출세액.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0), 10, 0) -- 57. 산출세액.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS 퇴직소득세액공제;
                        || LPAD(0, 10, 0) -- 58. 외국납부세액공제.
                        --> 정산명세 - 법정이외퇴직급여;
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 52-1. 퇴직급여액.
                        || LPAD(CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 53.-1 퇴직소득공제.
                        || LPAD(NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 54-1. 퇴직소득과세표준.
                        || LPAD(NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 55-1. 연평균과세표준.
                        || LPAD(NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 56-1. 연평균산출세액.
                        || LPAD(NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 57-1. 산출세액.
                        || LPAD(0, 10, 0) -- 58-1. 외국납부세액공제.

                       --> 정산명세 계(정산명세(법정퇴직급여) + 정산명세(법정이외퇴직급여))
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0) + NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 59. 퇴직급여액.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END + 
                                CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 60. 퇴직소득공제.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0) + NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 61. 퇴직소득과세표준.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0) + NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 62. 연평균과세표준.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0) + NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 63. 연평균산출세액.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0) + NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 64. 산출세액.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS 퇴직소득세액공제;
                        || LPAD(0, 10, 0) -- 65. 외국납부세액공제.
                       --> 결정세액.
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0), 10, 0) -- 66. 소득세액.
                        || LPAD(NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.H_RESIDENT_TAX_AMOUNT, 0), 10, 0) -- 67. 주민세
                        || LPAD(NVL(RA.SP_TAX_AMOUNT, 0) + NVL(RA.H_SP_TAX_AMOUNT, 0), 10, 0) -- 68. 농특세
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0), 10, 0) -- 69. 계.
                       --> 종(전)근무지;
                        || LPAD(0, 10, 0) -- 70. 소득세.
                        || LPAD(0, 10, 0) -- 71. 주민세.
                        || LPAD(0, 10, 0) -- 72. 농특세.
                        || LPAD(0, 10, 0) -- 73. 계.
                        || RPAD(' ', 4, ' ') AS RECORD_FILE
                        , PM.PERSON_ID
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM
                        , ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                      FROM HRM_PERSON_MASTER PM
                        , HRM_POST_CODE_V PC
                        , HRR_RETIRE_ADJUSTMENT RA
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- 퇴직사유.
                            SELECT HC.COMMON_ID AS RETIRE_ID
                                , HC.CODE AS RETIRE_CODE
                                , HC.CODE_NAME AS RETIRE_NAME
                                , HC.VALUE1 AS RETIRE_GROUP_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE         = 'RETIRE'
                              AND HC.SOB_ID             = P_SOB_ID
                              AND HC.ORG_ID             = P_ORG_ID
                          ) S_RT
                    WHERE PM.POST_ID        = PC.POST_ID
                      AND PM.PERSON_ID      = RA.PERSON_ID
                      AND PM.NATION_ID      = S_HN.NATION_ID(+)
                      AND PM.RETIRE_ID      = S_RT.RETIRE_ID(+)
                      AND RA.ADJUSTMENT_YYYY= P_YEAR_YYYY
                      AND RA.CORP_ID        = P_CORP_ID
                      AND RA.SOB_ID         = P_SOB_ID
                      AND RA.ORG_ID         = P_ORG_ID
                      AND RA.RETIRE_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                      AND RA.CLOSED_YN      = 'Y'
                    ORDER BY PM.PERSON_NUM)
          LOOP
            V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
            V_SOURCE_FILE := 'C_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => C1.RECORD_FILE
              , P_SORT_NUM          => C1.C_SEQ_NO
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
--D1 ------------------------------------------------------------------------------------
            --> 종(전)근무처 레코드 <--
            
          END LOOP C1;
        END LOOP B1;
    END LOOP A1;

  END SET_RETIRE_FILE_2011;

-------------------------------------------------------------------------------
-- 2012년도 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SET_RETIRE_FILE_2012
            ( P_YEAR_YYYY         IN VARCHAR2
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            , P_CONNECT_PERSON_ID IN NUMBER
            , P_TAX_AGENT         IN VARCHAR2
            , P_TAX_PROGRAM_CODE  IN VARCHAR2
            , P_USE_LANGUAGE_CODE IN VARCHAR2
            , P_SUBMIT_AGENT      IN VARCHAR2
            , P_SUBMIT_PERIOD     IN VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN VARCHAR2
            , P_WRITE_DATE        IN DATE
            )
  AS
    --> 주(현) 업체 정보 변수.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_SEQ_NO                    NUMBER;          -- 레코드 생성 번호.
    V_RECORD_FILE               VARCHAR2(3000);  -- 부양가족 조합위해.
  BEGIN
    -- 전산매체 생성--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- 자료관리번호.
                    || '25'  -- 갑종근로소득(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 사업자등록번호;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 법인명(상호);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 담당자(제출자) 부서;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 사용한글코드;
                    || RPAD(' ', 832, ' ') AS RECORD_FILE
                  FROM HRM_CORP_MASTER CM
                    , HRM_OPERATING_UNIT OU
                    , ( SELECT PM.PERSON_ID
                            , PM.NAME
                            , PM.DEPT_NAME
                          FROM HRM_PERSON_MASTER_V1 PM
                        WHERE PM.PERSON_ID  = P_CONNECT_PERSON_ID
                      ) S_PM
                WHERE OU.CORP_ID            = CM.CORP_ID
                  AND P_CONNECT_PERSON_ID   = S_PM.PERSON_ID
                  AND CM.CORP_ID            = P_CORP_ID
                  AND CM.SOB_ID             = P_SOB_ID
                  AND CM.ORG_ID             = P_ORG_ID
                  AND CM.ENABLED_FLAG       = 'Y'
                  AND (OU.DEFAULT_FLAG      = 'Y'
                    OR (OU.DEFAULT_FLAG     = 'N'
                    AND ROWNUM              <= 1))
               )
    LOOP
      V_SEQ_NUM := 1;
      V_SOURCE_FILE := 'A_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => A1.RECORD_FILE
        , P_SORT_NUM          => 1
        );
      --DBMS_OUTPUT.PUT_LINE(A1.RECORD_FILE);
--B1 ------------------------------------------------------------------------------------
      FOR B1 IN ( SELECT --> 자료관리번호;
                         'B'    -- 레코드 구분;
                      || '25'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 세무서코드;
                      || LPAD(1, 6, 0)                                      -- B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- 원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- 법인명(상호);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- 대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 법인등록번호;
                      || LPAD('1', 1, 0)  -- 징수의무자 구분(사업장1/퇴직연금사업자2/공적연금사업자3) --
                      --> 제출내역;
                      || LPAD(NVL(S_RA.PERSON_COUNT, 0), 7, 0)   -- 수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(NVL(S_RA.PRE_PERSON_COUNT, 0), 7, 0)   -- 수록한 D레코드(전근무처)의 수(C레코드 항목6의 합계)
                      || LPAD(NVL(S_RA.RETIRE_TOTAL_AMOUNT, 0), 14, 0)    -- 퇴직급여액 총계(C레코드 퇴직급여 합);
                      || LPAD(NVL(S_RA.INCOME_TAX_AMOUNT, 0), 13, 0)  -- 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(0, 13, 0)  -- LPAD(NVL(S_YA.FIX_LEGAL_TAX, 0), 13, 0) : 2009년 연말정산 수정(MODIFIED BY YOUNG MIN) 법인세 결정세액총계->공란으로 변경;
                      || LPAD(NVL(S_RA.RESIDENT_TAX_AMOUNT, 0), 13, 0) -- 지방세 결정세액 총계;
                      || LPAD(NVL(S_RA.SP_TAX_AMOUNT, 0), 13, 0) -- 농특세 결정세액 총계;
                      || LPAD(NVL(SUM_TAX_AMOUNT, 0), 13, 0)  -- 결정세액 총계;
                      -- LPAD(NVL(S_YA.FIX_TOTAL_TAX, 0), 13, 0)  -- 결정세액 총계 : 2009년 연말정산 수정(MODIFIED BY YOUNG MIN) 결정세액총계-법인세 결정세액 총계;
                      || LPAD(NVL(P_SUBMIT_PERIOD, '1'), 1, 0)   -- (연간합산 : 1, 휴/폐업에 의한 수시제출 : 2, 수시 분할제출 : 3);
                      || RPAD(' ', 810, ' ') AS RECORD_FILE
                      , CM.CORP_NAME  -- 법인명.
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
                          SELECT RA.ADJUSTMENT_YYYY
                              , RA.CORP_ID
                              , COUNT(RA.PERSON_ID) PERSON_COUNT 
                              , 0 AS PRE_PERSON_COUNT
                              , SUM(NVL(RA.RETIRE_TOTAL_AMOUNT, 0)) AS RETIRE_TOTAL_AMOUNT
                              , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0)) INCOME_TAX_AMOUNT
                              , SUM(NVL(RA.RESIDENT_TAX_AMOUNT, 0)) RESIDENT_TAX_AMOUNT
                              , SUM(NVL(RA.SP_TAX_AMOUNT, 0)) SP_TAX_AMOUNT
                              , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0)) AS SUM_TAX_AMOUNT
                            FROM HRR_RETIRE_ADJUSTMENT RA
                               , HRM_PERSON_MASTER     PM
                          WHERE RA.PERSON_ID       = PM.PERSON_ID
                            AND RA.ADJUSTMENT_YYYY = P_YEAR_YYYY
                            AND RA.CORP_ID         = P_CORP_ID
                            AND RA.SOB_ID          = P_SOB_ID
                            AND RA.ORG_ID          = P_ORG_ID
                            AND RA.RETIRE_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE
                            AND RA.CLOSED_YN       = 'Y'
                          GROUP BY RA.ADJUSTMENT_YYYY
                                , RA.CORP_ID
                        ) S_RA
                    WHERE CM.CORP_ID        = OU.CORP_ID
                      AND P_YEAR_YYYY       = S_RA.ADJUSTMENT_YYYY
                      AND CM.ENABLED_FLAG   = 'Y'
                      AND (OU.DEFAULT_FLAG  = 'Y'
                        OR (OU.DEFAULT_FLAG = 'N'
                        AND ROWNUM          <= 1))
                  )
        LOOP
          V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
          V_SOURCE_FILE := 'B_RECORD';
          INSERT_REPORT_FILE
            ( P_SEQ_NUM           => V_SEQ_NUM
            , P_SOURCE_FILE       => V_SOURCE_FILE
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            , P_REPORT_FILE       => B1.RECORD_FILE
            , P_SORT_NUM          => 1
            );
          --DBMS_OUTPUT.PUT_LINE(B1.RECORD_FILE);
--C1 ------------------------------------------------------------------------------------
        FOR C1 IN ( SELECT
                          'C'                                           -- 1.자료관리번호.
                        || '25'                                         -- 2.
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4. 일련번호.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. 사업자번호.
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 6. 주현 근무처 사업자번호.
                        || RPAD(NVL(B1.CORP_NAME, ' '), 40, ' ')       -- 7. 주현 근무처명.
                        || LPAD(0, 2, 0)      -- 8. 종(전)근무처 수;
                        || RPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 9. 거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')  -- 10.거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || RPAD(CASE
                                  WHEN RA.RETIRE_DATE_FR > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD')
                                  WHEN PM.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END, 8, 0)  -- 11. 근무기간 시작연월일;
                        || RPAD(CASE
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN
                                    CASE
                                      WHEN RA.RETIRE_DATE_TO < PM.RETIRE_DATE THEN TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD')
                                      ELSE TO_CHAR(PM.RETIRE_DATE, 'YYYYMMDD')
                                    END
                                  ELSE P_YEAR_YYYY || '1231'
                                END, 8, 0)  -- 12. 근무기간 종료연월일;
                        || RPAD(PM.NAME, 30, ' ')  -- 13. 성명;
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN '1'  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN '1'  -- 1800년대생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'  -- 외국인.
                                END, 1, 0)  -- 14. 내/외국인 구분코드;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')  -- 15.주민등록번호;
                        || LPAD(DECODE(NVL(RA.OFFICER_YN, 'N'), 'Y', '1', '2'), 1, '2') -- 16.임원여부(1-여/2-부)--
                        -- 근무처별 소득명세 - 주(현)근무처 --
                        || RPAD(CASE
                                  WHEN RA.ADJUSTMENT_TYPE = 'M' THEN '5'  -- 중도정산 --
                                  WHEN NVL(RA.OFFICER_YN, 'N') = 'Y' THEN '4'  -- 임원퇴직 --
                                  ELSE NVL(S_RT.RETIRE_GROUP_CODE, '3')
                                END, 1, 0)  -- 17.퇴직사유.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 18.퇴직급여(법정).
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 19.퇴직급여(법정이외).
                        || LPAD(0, 10, 0) -- 20.퇴직연금일시금(법정).
                        || LPAD(0, 10, 0) -- 21.퇴직연금일시금(법정이외)수록;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 22.퇴직(법정)급여액계.
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 23.퇴직(법정이외)급여액계.
                        || LPAD(0, 10, 0) -- 24.비과세소득.
                        -- 근속연수-법정퇴직급여.
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0) --25. 주(현)근무지 입사연월일;
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0) --26. 종(전)근무지 입사연월일;
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0) --27. 주(현)근무지 근속월수.
                        || LPAD(CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 
                                    THEN  CASE 
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                            WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                            ELSE TRUNC(RA.DED_DAY / 30)
                                          END
                                  ELSE 0
                                END, 4, 0) -- 28. 주(현)근무지 제외월수.
                        || LPAD(0, 4, 0) -- 29. 주(현)근무지 가산월수.
                        || LPAD(0, 8, 0) -- 30. 종(전)근무지 입사연월일.
                        || LPAD(0, 8, 0) -- 31. 종(전)근무지 퇴사연월일.
                        || LPAD(0, 4, 0) -- 32. 종(전)근무지 근속월수.
                        || LPAD(0, 4, 0) -- 33. 종(전)근무지 제외월수.
                        || LPAD(0, 4, 0) -- 34. 종(전)근무지 가산월수.
                        || LPAD(0, 4, 0) -- 35. 중복월수.
                        || LPAD(NVL(RA.LONG_YEAR, 0), 2, 0) --36. 근속연수.
                        --> 근속연수 -법정이외 퇴직급여;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_FR, RA.RETIRE_DATE_FR), 'YYYYMMDD'), '0'), 8, 0) -- 25-1. 주(현)근무지 입사연월일;
                        || LPAD(NVL(TO_CHAR(NVL(RA.H_RETIRE_DATE_TO, RA.RETIRE_DATE_TO), 'YYYYMMDD'), '0'), 8, 0) -- 26-1. 주(현)근무지 퇴사연월일;
                        || LPAD(DECODE(NVL(RA.H_LONG_MONTH, 0), 0, NVL(RA.LONG_MONTH, 0), NVL(RA.H_LONG_MONTH, 0)), 4, 0) -- 27-1. 주(현)근무지 근속월수.
                        || LPAD(/*CASE 
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 0 THEN 0
                                  WHEN TRUNC(NVL(RA.DED_DAY, 0) / 30) <= 1 THEN 1
                                  ELSE TRUNC(NVL(RA.DED_DAY / 30)
                                END*/0, 4, 0) -- 28-1. 주(현)근무지 제외월수.
                        || LPAD(0, 4, 0) -- 29_1. 주(현)근무지가산월수.
                        || LPAD(0, 8, 0) -- 30-1. 종(전)근무지 입사연월일.
                        || LPAD(0, 8, 0) -- 31-1. 종(전)근무지 퇴사연월일.
                        || LPAD(0, 4, 0) -- 32-1. 종(전)근무지 근속월수.
                        || LPAD(0, 4, 0) -- 33-1. 종(전)근무지 제외월수.
                        || LPAD(0, 4, 0) -- 34-1.종(전)근무지가산월수.
                        || LPAD(0, 4, 0) -- 35-1. 중복월수.
                        || LPAD(DECODE(NVL(RA.H_LONG_YEAR, 0), 0, NVL(RA.LONG_YEAR, 0), NVL(RA.H_LONG_YEAR, 0)), 2, 0) -- 36-1. 근속연수.
                        --> 주(현)근무지 퇴직연금명세.
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, ' ', SQ1.ACCOUNT_NUM), 20, ' ') -- 37.퇴직연금계좌번호;
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, 0, NVL(RA.RETIRE_TOTAL_AMOUNT, 0)), 10, 0) -- 38.퇴직연금일시금총수령액.
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, 0, NVL(RA.RETIRE_TOTAL_AMOUNT, 0)), 10, 0) -- 39.퇴직연금원리금합계액.
                        || LPAD(0, 10, 0) -- 40.퇴직연금소득자불입액.
                        || LPAD(0, 10, 0) -- 41.퇴직연금소득공제액.
                        || LPAD(DECODE(SQ1.ACCOUNT_NUM, NULL, 0,NVL(RA.RETIRE_TOTAL_AMOUNT, 0)), 10, 0) -- 42.퇴직연금일시금.
                        --> 종(전)근무지 퇴직연금명세.
                        || LPAD(' ', 20, ' ') -- 37-1.퇴직연금계좌번호.
                        || LPAD(0, 10, 0) -- 38-1.퇴직연금일시금총수령액.
                        || LPAD(0, 10, 0) -- 39-1.퇴직연금원리금합계액.
                        || LPAD(0, 10, 0) -- 40-1.퇴직연금소득자불입액.
                        || LPAD(0, 10, 0) -- 41-1.퇴직연금소득공제액.
                        || LPAD(0, 10, 0) -- 42-1.퇴직연금일시금.
                        --> 세액환산명세-법정퇴직급여;
                        || LPAD(0, 10, 0) -- 43.퇴직연금일시금지급예상액-주(현);
                        || LPAD(0, 10, 0) -- 44.퇴직연금일시금지급예상액-종(전);
                        || LPAD(0, 10, 0) -- 45.퇴직연금일시금지급예상액 과세이연금액-주(현)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) -- 46.퇴직연금일시금지급예상액 과세이연금액-종(전)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) -- 47.기수령한퇴직급여액-주(현);
                        || LPAD(0, 10, 0) -- 48.기수령한퇴직급여액-종(전);
                        || LPAD(0, 10, 0) -- 49. 총퇴직연금일시금.
                        || LPAD(0, 10, 0) -- 50. 수령가능퇴직급여액.
                        || LPAD(0, 10, 0) -- 51. 환산퇴직소득공제.
                        || LPAD(0, 10, 0) -- 52. 환산퇴직소득 과세표준.
                        || LPAD(0, 10, 0) -- 53. 환산연평균과세표준.
                        || LPAD(0, 10, 0) -- 54. 환산연평균산출세액.
                       --> 세액환산명세-법정이외 퇴직급여;
                        || LPAD(0, 10, 0) --43-1. 퇴직연금일시금지급예상액-주(현);
                        || LPAD(0, 10, 0) --44-1. 퇴직연금일시금지급예상액-종(전);
                        || LPAD(0, 10, 0) --45-1. 퇴직연금일시금지급예상액 과세이연금액-주(현)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) --46-1. 퇴직연금일시금지급예상액 과세이연금액-종(전)(퇴직연금일시금제외);
                        || LPAD(0, 10, 0) --47-1. 기수령한퇴직급여액-주(현);
                        || LPAD(0, 10, 0) --48-1. 기수령한퇴직급여액-종(전);
                        || LPAD(0, 10, 0) --49-1. 총퇴직연금일시금.
                        || LPAD(0, 10, 0) --50-1. 수령가능 퇴직급여액.
                        || LPAD(0, 10, 0) --51-1. 환산퇴직소득공제.
                        || LPAD(0, 10, 0) --52-1. 환산퇴직소득 과세표준.
                        || LPAD(0, 10, 0) --53-1. 환산연평균과세표준.
                        || LPAD(0, 10, 0) --54-1. 환산연평균산출세액.
                        
                        --> 정산명세 - 법정퇴직급여;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 10, 0) -- 55.퇴직급여액.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 56. 퇴직소득공제.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 10, 0) -- 57. 퇴직소득과세표준.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 58. 연평균과세표준.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 59. 연평균 산출세액.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0), 10, 0) -- 60. 산출세액.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS 퇴직소득세액공제;
                        || LPAD(0, 10, 0) -- 61. 외국납부세액공제.
                        --> 정산명세 - 법정이외퇴직급여;
                        || LPAD(NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 55-1. 퇴직급여액.
                        || LPAD(CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 56.-1 퇴직소득공제.
                        || LPAD(NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 57-1. 퇴직소득과세표준.
                        || LPAD(NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 58-1. 연평균과세표준.
                        || LPAD(NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 59-1. 연평균산출세액.
                        || LPAD(NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 60-1. 산출세액.
                        || LPAD(0, 10, 0) -- 61-1. 외국납부세액공제.

                       --> 정산명세 계(정산명세(법정퇴직급여) + 정산명세(법정이외퇴직급여))
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0) + NVL(RA.HONORARY_AMOUNT, 0), 10, 0) -- 62. 퇴직급여액.
                        || LPAD(CASE
                                  WHEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0) < (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0)) THEN NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                  ELSE (NVL(RA.INCOME_DED_AMOUNT, 0) + NVL(RA.LONG_DED_AMOUNT, 0))
                                END + 
                                CASE
                                  WHEN NVL(RA.HONORARY_AMOUNT, 0) < (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0)) THEN NVL(RA.HONORARY_AMOUNT, 0)
                                  ELSE (NVL(RA.H_INCOME_DED_AMOUNT, 0) + NVL(RA.H_LONG_DED_AMOUNT, 0))
                                END, 10, 0) -- 63. 퇴직소득공제.
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0) + NVL(RA.H_TAX_STD_AMOUNT, 0), 10, 0) -- 64. 퇴직소득과세표준.
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT, 0) + NVL(RA.H_AVG_TAX_STD_AMOUNT, 0), 10, 0) -- 65. 연평균과세표준.
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT, 0) + NVL(RA.H_AVG_COMP_TAX_AMOUNT, 0), 10, 0) -- 66. 연평균산출세액.
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT, 0) + NVL(RA.H_COMP_TAX_AMOUNT, 0), 10, 0) -- 67. 산출세액.
                        --|| LPAD(NVL(HA.TAX_DED_AMT, 0), 10, 0) -- AS 퇴직소득세액공제;
                        || LPAD(0, 10, 0) -- 68. 외국납부세액공제.
                       --> 결정세액.
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0), 10, 0) -- 69. 소득세액.
                        || LPAD(NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.H_RESIDENT_TAX_AMOUNT, 0), 10, 0) -- 70. 주민세
                        || LPAD(NVL(RA.SP_TAX_AMOUNT, 0) + NVL(RA.H_SP_TAX_AMOUNT, 0), 10, 0) -- 71. 농특세
                        || LPAD(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0), 10, 0) -- 72. 계.
                       --> 종(전)근무지;
                        || LPAD(0, 10, 0) -- 73. 소득세.
                        || LPAD(0, 10, 0) -- 74. 주민세.
                        || LPAD(0, 10, 0) -- 75. 농특세.
                        || LPAD(0, 10, 0) -- 76. 계.
                        || RPAD(' ', 7, ' ') AS RECORD_FILE
                        , PM.PERSON_ID  -- 사원ID.
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM  -- 주민번호.
                        , NVL(B1.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE --세무서코드.
                        , NVL(B1.VAT_NUMBER, ' ') AS VAT_NUMBER  -- 사업자번호.
                        , ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT  -- 법정퇴직급여액.
                        , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT  -- 법정외 퇴직급여액.
                        , NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT  -- 과세이연세액.
                      FROM HRM_PERSON_MASTER PM
                        , HRM_POST_CODE_V PC
                        , HRR_RETIRE_ADJUSTMENT RA
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- 퇴직사유.
                            SELECT HC.COMMON_ID AS RETIRE_ID
                                , HC.CODE AS RETIRE_CODE
                                , HC.CODE_NAME AS RETIRE_NAME
                                , HC.VALUE1 AS RETIRE_GROUP_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE         = 'RETIRE'
                              AND HC.SOB_ID             = P_SOB_ID
                              AND HC.ORG_ID             = P_ORG_ID
                          ) S_RT
                        , ( -- 퇴직연금 계좌번호 --
                            SELECT RP.PERSON_ID
                                 , RP.CORP_NAME
                                 , RP.TAX_REG_NUM
                                 , RP.ACCOUNT_NUM
                                 , RP.ISSUE_DATE
                                 , RP.DUE_DATE
                              FROM HRR_RETIREMENT_PENSION_V RP
                             WHERE RP.SOB_ID            = P_SOB_ID
                               AND RP.ORG_ID            = P_ORG_ID
                          ) SQ1
                    WHERE PM.POST_ID        = PC.POST_ID
                      AND PM.PERSON_ID      = RA.PERSON_ID
                      AND PM.NATION_ID      = S_HN.NATION_ID(+)
                      AND PM.RETIRE_ID      = S_RT.RETIRE_ID(+)
                      AND RA.PERSON_ID      = SQ1.PERSON_ID(+)
                      AND RA.ADJUSTMENT_YYYY= P_YEAR_YYYY
                      AND RA.CORP_ID        = P_CORP_ID
                      AND RA.SOB_ID         = P_SOB_ID
                      AND RA.ORG_ID         = P_ORG_ID
                      AND RA.RETIRE_DATE_TO BETWEEN P_START_DATE AND P_END_DATE
                      AND RA.CLOSED_YN      = 'Y'
                    ORDER BY PM.PERSON_NUM)
          LOOP
            V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
            V_SOURCE_FILE := 'C_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => C1.RECORD_FILE
              , P_SORT_NUM          => C1.C_SEQ_NO
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
--D1 ------------------------------------------------------------------------------------
            --> 종(전)근무처 레코드 <--

--E1 ------------------------------------------------------------------------------------
            --> 과세이연계좌 레코드 <--
            FOR E1 IN ( SELECT 'E'  
                             || '25'  -- 자료구분.
                             || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                             || LPAD(ROW_NUMBER() OVER(PARTITION BY RP.PERSON_ID ORDER BY RP.PERSON_ID), 6, 0)   -- 4. 일련번호.
                             --> 원천징수의무자 --
                             || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. 사업자번호.
                             || RPAD(' ', 50, ' ')  -- 6. 공란.
                             || RPAD(NVL(REPLACE(C1.REPRE_NUM, '-', ''), ' '), 13, ' ') -- 7.소득자 주민번호.
                             -- 과세이연계좌 --
                             || RPAD(NVL(REPLACE(RP.CORP_NAME, ' ', ''), ' '), 40, ' ')  -- 8.퇴직연금사업자명.
                             || RPAD(NVL(REPLACE(RP.TAX_REG_NUM, '-', ''), ' '), 10, ' ')  -- 9.퇴직연금사업자의 사업자등록번호.
                             || RPAD(NVL(REPLACE(RP.ACCOUNT_NUM, '-', ''), ' '), 20, ' ')  -- 10.계좌번호.
                             || LPAD(NVL(C1.RETIRE_TOTAL_AMOUNT, 0), 11, 0) -- 11.입금금액-법정퇴직급여액.
                             || LPAD(NVL(C1.HONORARY_AMOUNT, 0), 11, 0) -- 12.입금금액-법정외퇴직급여액.
                             || RPAD(TO_CHAR(RP.ISSUE_DATE, 'YYYYMMDD'), 8, ' ')  -- 13.입금일.
                             || RPAD(NVL(TO_CHAR(RP.DUE_DATE, 'YYYYMMDD'), ' '), 8, ' ') -- 14.만기일.
                             || LPAD(NVL(C1.INCOME_TAX_AMOUNT, 0), 11, 0) -- 15.과세이연세액.
                             || LPAD(ROW_NUMBER() OVER(PARTITION BY RP.PERSON_ID ORDER BY RP.PERSON_ID), 2, 0) -- 16.과세이연계좌 일련번호.
                             || RPAD(' ', 804, ' ') AS RECORD_FILE
                               , ROW_NUMBER() OVER(PARTITION BY RP.PERSON_ID ORDER BY RP.PERSON_ID) AS SEQ_NO
                          FROM HRR_RETIREMENT_PENSION_V RP
                         WHERE RP.PERSON_ID         = C1.PERSON_ID
                           AND RP.SOB_ID            = P_SOB_ID
                           AND RP.ORG_ID            = P_ORG_ID
                       )
            LOOP
              V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
              V_SOURCE_FILE := 'E_RECORD';
              INSERT_REPORT_FILE
                ( P_SEQ_NUM           => V_SEQ_NUM
                , P_SOURCE_FILE       => V_SOURCE_FILE
                , P_SOB_ID            => P_SOB_ID
                , P_ORG_ID            => P_ORG_ID
                , P_REPORT_FILE       => E1.RECORD_FILE
                , P_SORT_NUM          => E1.SEQ_NO
                );
              --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
            
            END LOOP E1;
          END LOOP C1;
        END LOOP B1;
    END LOOP A1;

  END SET_RETIRE_FILE_2012;

-------------------------------------------------------------------------------
-- 2013년도 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SET_RETIRE_FILE_2013
            ( P_YEAR_YYYY         IN  VARCHAR2 
            , P_START_DATE        IN  DATE
            , P_END_DATE          IN  DATE
            , P_CORP_ID           IN  NUMBER 
            , P_OPERATING_UNIT_ID IN  NUMBER  
            , P_SOB_ID            IN  NUMBER 
            , P_ORG_ID            IN  NUMBER 
            , P_CONNECT_PERSON_ID IN  NUMBER
            , P_TAX_AGENT         IN  VARCHAR2
            , P_TAX_PROGRAM_CODE  IN  VARCHAR2
            , P_USE_LANGUAGE_CODE IN  VARCHAR2
            , P_SUBMIT_AGENT      IN  VARCHAR2
            , P_SUBMIT_PERIOD     IN  VARCHAR2
            , P_HOMETAX_LOGIN_ID  IN  VARCHAR2
            , P_WRITE_DATE        IN  DATE
            )
  AS
    --> 주(현) 업체 정보 변수.
    V_SEQ_NUM                   NUMBER := 0;
    V_SOURCE_FILE               VARCHAR2(150);
    V_RECORD_COUNT              NUMBER := 0;
    V_E_REC_STD                 CONSTANT NUMBER := 5;
    V_F_REC_STD                 CONSTANT NUMBER := 15;
    V_SEQ_NO                    NUMBER;          -- 레코드 생성 번호.
    V_RECORD_FILE               VARCHAR2(3000);  -- 부양가족 조합위해.
  BEGIN
    -- 전산매체 생성--.
--A1 ------------------------------------------------------------------------------------
    FOR A1 IN ( SELECT 'A'   -- 1.자료관리번호.
                    || '25'  -- 2.갑종근로소득(20);
                    || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)  -- 3.세무서 코드;
                    || TO_CHAR(P_WRITE_DATE, 'YYYYMMDD')  -- 4.자료를 세무서에 제출하는 연월일;
                    --> 제출자;
                    || LPAD(NVL(P_SUBMIT_AGENT, '2'), 1, 0)  -- 5.제출자구분(세무대리인1, 법인2, 개인3);
                    || RPAD(NVL(P_TAX_AGENT, ' '), 6, ' ')  -- 6.세무대리인 관리번호(자료제출자가 세무대리인인경우 수록);
                    || RPAD(NVL(P_HOMETAX_LOGIN_ID, ' '), 20, ' ')  -- 7.홈택스ID;
                    || RPAD(NVL(P_TAX_PROGRAM_CODE, '1001'), 4, ' ')  -- 8.세무프로그램코드;
                    || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')  -- 9.사업자등록번호;
                    || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')  -- 10.법인명(상호);
                    || RPAD(NVL(S_PM.DEPT_NAME, ' '), 30, ' ')  -- 11.담당자(제출자) 부서;
                    || RPAD(NVL(S_PM.NAME, ' '), 30, ' ')  -- 12.담당자(제출자) 성명;
                    || RPAD(NVL(REPLACE(CM.TEL_NUMBER, '-', ''), ' '), 15, ' ')  -- 13.담당자(제출자) 전화번호;
                    --> 제출내역.
                    || LPAD(1, 5, 0)  -- 14.신고의무자수 (B레코드);
                    || LPAD(NVL(P_USE_LANGUAGE_CODE, '101'), 3, 0)  -- 15.사용한글코드;
                    || RPAD(' ', 1222, ' ') AS RECORD_FILE
                    , CM.CORP_ID
                    , OU.OPERATING_UNIT_ID 
                  FROM HRM_CORP_MASTER CM
                    , HRM_OPERATING_UNIT OU
                    , ( SELECT PM.PERSON_ID
                            , PM.NAME
                            , PM.DEPT_NAME
                          FROM HRM_PERSON_MASTER_V1 PM
                        WHERE PM.PERSON_ID  = P_CONNECT_PERSON_ID
                      ) S_PM
                WHERE OU.CORP_ID            = CM.CORP_ID
                  AND P_CONNECT_PERSON_ID   = S_PM.PERSON_ID
                  AND CM.CORP_ID            = P_CORP_ID
                  AND CM.SOB_ID             = P_SOB_ID
                  AND CM.ORG_ID             = P_ORG_ID
                  --AND OU.OPERATING_UNIT_ID  = P_OPERATING_UNIT_ID 
                  AND CM.ENABLED_FLAG       = 'Y'
                  AND (OU.DEFAULT_FLAG      = 'Y'
                    OR (OU.DEFAULT_FLAG     = 'N'
                    AND ROWNUM              <= 1))
               )
    LOOP
      V_SEQ_NUM := 1;
      V_SOURCE_FILE := 'A_RECORD';
      INSERT_REPORT_FILE
        ( P_SEQ_NUM           => V_SEQ_NUM
        , P_SOURCE_FILE       => V_SOURCE_FILE
        , P_SOB_ID            => P_SOB_ID
        , P_ORG_ID            => P_ORG_ID
        , P_REPORT_FILE       => A1.RECORD_FILE
        , P_SORT_NUM          => 1 
        , P_RECORD_TYPE       => 'A' 
        );
      --DBMS_OUTPUT.PUT_LINE(A1.RECORD_FILE);
--B1 ------------------------------------------------------------------------------------
      FOR B1 IN ( SELECT --> 자료관리번호;
                         'B'    -- 레코드 구분;
                      || '25'  -- 갑종근로소득(20);
                      || LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0)   -- 3.세무서코드;
                      || LPAD(1, 6, 0)                                      -- 4.B레코드의 일련번호;
                      --> 제출자;
                      || RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ')      -- 5.원천징수의무자의 사업자등록번호;
                      || RPAD(NVL(CM.CORP_NAME, ' '), 40, ' ')              -- 6.법인명(상호);
                      || RPAD(NVL(CM.PRESIDENT_NAME, ' '), 30, ' ')         -- 7.대표자 성명;
                      || RPAD(NVL(REPLACE(CM.LEGAL_NUMBER, '-', ''), ' '), 13, ' ') -- 8.법인등록번호;
                      || LPAD('1', 1, 0)  -- 9.징수의무자 구분(사업장1/퇴직연금사업자2/공적연금사업자3) --
                      --> 제출내역;
                      || LPAD(NVL(S_RA.PERSON_COUNT, 0), 7, 0)   -- 10.수록한 C레코드의 수(근로소득자의 수);
                      || LPAD(' ', 7, ' ')   -- 11.2013년도 수정 : 공란 처리  
                      || LPAD(NVL(S_RA.RETIRE_TOTAL_AMOUNT, 0), 14, 0)      --12.퇴직급여액 총계(C레코드 퇴직급여 합);
                      || LPAD(CASE 
                                WHEN NVL(S_RA.INCOME_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --13.1 신고대상 소득세합계 부호(0-양수, 1-음수) 
                      || LPAD(ABS(NVL(S_RA.INCOME_TAX_AMOUNT, 0)), 13, 0)       --13.2 소득세 결정세액 총계(C레코드 소득세의 합);
                      || LPAD(NVL(S_RA.TRANS_INCOME_TAX_AMOUNT, 0), 13, 0)      --14. 이연퇴직소득세액합계 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_INCOME_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --15.2 차감원천징수-소득세액 합계 부호 
                      || LPAD(ABS(NVL(S_RA.SUB_INCOME_TAX_AMOUNT, 0)), 13, 0)   --15.2 차감원천징수-소득세액 합계 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_RESIDENT_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --16.1 차감원천징수-지방소득세액 합계 부호 
                      || LPAD(ABS(NVL(S_RA.SUB_RESIDENT_TAX_AMOUNT, 0)), 13, 0) --16.2 차감원천징수-지방소득세액 합계 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_SP_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --17.1 차감원천징수-농특세액 합계 부호 
                      || LPAD(ABS(NVL(S_RA.SUB_SP_TAX_AMOUNT, 0)), 13, 0)       --17.2 차감원천징수-농특세액 합계 
                      || LPAD(CASE
                                WHEN NVL(S_RA.SUB_TAX_AMOUNT, 0) < 0 THEN 1
                                ELSE 0
                              END, 1, 0)                                        --18.1 차감원천징수-세액 합계 부호 
                      || LPAD(ABS(NVL(S_RA.SUB_TAX_AMOUNT, 0)), 13, 0)          --18.2 차감원천징수-세액 합계 
                      || RPAD(' ', 1183, ' ') AS RECORD_FILE
                      , CM.CORP_NAME  -- 법인명.
                      , LPAD(REPLACE(OU.TAX_OFFICE_CODE, '-', ''), 3, 0) AS TAX_OFFICE_CODE
                      , RPAD(NVL(REPLACE(OU.VAT_NUMBER, '-', ''), ' '), 10, ' ') AS VAT_NUMBER
                    FROM HRM_CORP_MASTER CM
                       , HRM_OPERATING_UNIT OU
                       , ( -- 제출내역.
                          SELECT RA.ADJUSTMENT_YYYY
                              , RA.CORP_ID
                              --, T1.OPERATING_UNIT_ID 
                              , COUNT(RA.PERSON_ID) PERSON_COUNT 
                              , 0 AS PRE_PERSON_COUNT
                              , SUM(NVL(RA.RETIRE_TOTAL_AMOUNT, 0)) AS RETIRE_TOTAL_AMOUNT
                              , SUM((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                     NVL(RA.COMP_TAX_AMOUNT_2, 0))) AS INCOME_TAX_AMOUNT
                              , SUM(CASE
                                      WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                      ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) 
                                    END) AS TRANS_INCOME_TAX_AMOUNT
                              , SUM(CASE
                                      WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                      ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) 
                                    END) AS SUB_INCOME_TAX_AMOUNT  -- 차감 소득세  
                              , SUM(CASE
                                      WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                      ELSE TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                                  NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)
                                    END) AS SUB_RESIDENT_TAX_AMOUNT  -- 차감 지방소득세 
                              , SUM(CASE
                                      WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                      ELSE NVL(RA.SP_TAX_AMOUNT_1, 0) + NVL(RA.SP_TAX_AMOUNT_2, 0) 
                                    END) AS SUB_SP_TAX_AMOUNT 
                              , SUM(CASE
                                      WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                      ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                           TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                                  NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) + 
                                           NVL(RA.SP_TAX_AMOUNT_1, 0) + NVL(RA.SP_TAX_AMOUNT_2, 0)
                                    END) AS SUB_TAX_AMOUNT
                            FROM HRR_RETIRE_ADJUSTMENT RA
                               , HRM_PERSON_MASTER     PM
                               /*, ( -- 시점 인사내역.
                                  SELECT HL.PERSON_ID
                                       , HL.OPERATING_UNIT_ID
                                    FROM HRM_HISTORY_HEADER HH
                                       , HRM_HISTORY_LINE   HL 
                                   WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                                     AND HH.CHARGE_SEQ           IN 
                                          (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                              FROM HRM_HISTORY_HEADER S_HH
                                                 , HRM_HISTORY_LINE   S_HL
                                             WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                               AND S_HH.CHARGE_DATE       <= P_END_DATE
                                               AND S_HL.PERSON_ID         = HL.PERSON_ID
                                             GROUP BY S_HL.PERSON_ID
                                           )      
                                 ) T1*/
                               , ( -- 퇴직연금 계좌번호 --
                                  SELECT RP.PERSON_ID
                                       , RP.CORP_NAME
                                       , RP.TAX_REG_NUM
                                       , RP.ACCOUNT_NUM
                                       , RP.ISSUE_DATE
                                       , RP.DUE_DATE
                                    FROM HRR_RETIREMENT_PENSION_V RP
                                   WHERE RP.SOB_ID            = P_SOB_ID
                                     AND RP.ORG_ID            = P_ORG_ID
                                 ) SQ1  
                          WHERE RA.PERSON_ID          = PM.PERSON_ID
                            /*AND PM.PERSON_ID          = T1.PERSON_ID */
                            AND RA.PERSON_ID          = SQ1.PERSON_ID(+)  
                            --AND T1.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID -- 사업장 
                            AND RA.ADJUSTMENT_YYYY    = P_YEAR_YYYY
                            AND RA.CORP_ID            = A1.CORP_ID
                            AND RA.SOB_ID             = P_SOB_ID
                            AND RA.ORG_ID             = P_ORG_ID
                            AND RA.RETIRE_DATE_TO     BETWEEN P_START_DATE AND P_END_DATE
                            AND RA.CLOSED_YN          = 'Y'
                          GROUP BY RA.ADJUSTMENT_YYYY
                                 , RA.CORP_ID
                                 --, T1.OPERATING_UNIT_ID
                        ) S_RA
                    WHERE CM.CORP_ID            = OU.CORP_ID
                      AND P_YEAR_YYYY           = S_RA.ADJUSTMENT_YYYY
                      --AND OU.OPERATING_UNIT_ID  = S_RA.OPERATING_UNIT_ID
                      AND OU.CORP_ID            = A1.CORP_ID
                      --AND OU.OPERATING_UNIT_ID  = A1.OPERATING_UNIT_ID 
                      AND CM.ENABLED_FLAG   = 'Y'
                      AND (OU.DEFAULT_FLAG  = 'Y'
                        OR (OU.DEFAULT_FLAG = 'N'
                        AND ROWNUM          <= 1))
                  )
        LOOP
          V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
          V_SOURCE_FILE := 'B_RECORD';
          INSERT_REPORT_FILE
            ( P_SEQ_NUM           => V_SEQ_NUM
            , P_SOURCE_FILE       => V_SOURCE_FILE
            , P_SOB_ID            => P_SOB_ID
            , P_ORG_ID            => P_ORG_ID
            , P_REPORT_FILE       => B1.RECORD_FILE
            , P_SORT_NUM          => 1
            , P_RECORD_TYPE       => 'B' 
            );
          --DBMS_OUTPUT.PUT_LINE(B1.RECORD_FILE);
--C1 ------------------------------------------------------------------------------------
        FOR C1 IN ( SELECT
                          'C'                                           -- 1.자료관리번호.
                        || '25'                                         -- 2.
                        || RPAD(NVL(B1.TAX_OFFICE_CODE, ' '), 3, ' ')   -- 3.세무서코드.
                        || LPAD(ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM), 6, 0)   -- 4. 일련번호.
                        
                        -- [원천징수의무자] -- 
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 5. 사업자번호.
                        || RPAD('1', 1, 1)                              -- 6. 징수의무자 구분 
                        
                        -- [소득자] -- 
                        || RPAD(NVL(PM.RESIDENT_TYPE, '1'), 1, 0)       -- 7. 거주자 구분코드(거주자:1, 비거주자:2);
                        || RPAD(CASE
                                  WHEN PM.NATIONALITY_TYPE IS NOT NULL THEN PM.NATIONALITY_TYPE
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN '1'  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN '1'  -- 1800년대생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '5' AND '8' THEN '9'  -- 외국인.
                                END, 1, 0)                              -- 8. 내/외국인 구분코드;                                
                        || RPAD(CASE
                                  WHEN PM.RESIDENT_TYPE = '1' THEN ' '
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '1' AND '4' THEN ' '  -- 1900, 2000년생.
                                  WHEN SUBSTR(REPLACE(PM.REPRE_NUM, '-', ''), 7, 1) BETWEEN '9' AND '0' THEN ' '  -- 1800년대생..
                                  ELSE NVL(S_HN.ISO_NATION_CODE, ' ')
                                END, 2, ' ')                            -- 9.거구지국 코드 : 비거주자만 기록, 거주자는 공란;
                        || RPAD(PM.NAME, 30, ' ')                       -- 10. 성명;
                        || RPAD(NVL(REPLACE(PM.REPRE_NUM, '-', ''), ' '), 13, ' ')      -- 11.주민등록번호;
                        || LPAD(DECODE(NVL(RA.OFFICER_YN, 'N'), 'Y', '1', '2'), 1, '2') -- 12.임원여부(1-여/2-부)--
                        || LPAD(CASE
                                 WHEN SQ1.ISSUE_DATE IS NULL THEN '0'
                                 ELSE NVL(TO_CHAR(SQ1.ISSUE_DATE, 'YYYYMMDD'), '0')
                               END, 8, '0')                                             -- 13. 확정급여형 퇴직연금제도 가입일 
                        || LPAD(CASE
                                  WHEN TO_CHAR(NVL(PM.ORI_JOIN_DATE, PM.JOIN_DATE), 'YYYYMMDD') > '20111231' THEN 0  -- 2012년 이후 입사자는 제외  
                                  WHEN NVL(RA.OFFICER_YN, 'N') = 'Y' THEN 0  -- 임원인 경우만 적용  
                                  ELSE 0
                                END, 11, '0')                           -- 14.11. 2011.12.31 퇴직금 
                        || RPAD(CASE
                                  WHEN RA.RETIRE_DATE_FR > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD')
                                  WHEN PM.JOIN_DATE > TO_DATE(P_YEAR_YYYY || '-01-01', 'YYYY-MM-DD') THEN TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD')
                                  ELSE TO_CHAR(P_YEAR_YYYY || '0101')
                                END, 8, 0)                              -- 15. 근무기간 시작연월일;
                        || RPAD(CASE
                                  WHEN PM.RETIRE_DATE IS NOT NULL AND PM.RETIRE_DATE < TO_DATE(P_YEAR_YYYY || '-12-31', 'YYYY-MM-DD') THEN
                                    CASE
                                      WHEN RA.RETIRE_DATE_TO < PM.RETIRE_DATE THEN TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD')
                                      ELSE TO_CHAR(PM.RETIRE_DATE, 'YYYYMMDD')
                                    END
                                  ELSE P_YEAR_YYYY || '1231'
                                END, 8, 0)                              -- 16. 근무기간 종료연월일;
                        || RPAD(CASE
                                  WHEN RA.ADJUSTMENT_TYPE = 'M' THEN '5'       -- 중도정산 --
                                  WHEN NVL(RA.OFFICER_YN, 'N') = 'Y' THEN '4'  -- 임원퇴직 --
                                  ELSE NVL(S_RT.RETIRE_GROUP_CODE, '3')
                                END, 1, 0)                              -- 17.퇴직사유.
                                
                        -- [퇴직급여 현황 - 중간지급등] --         
                        || RPAD(' ', 40, ' ')                           -- 18.13. 근무처명         
                        || RPAD(' ', 10, ' ')                           -- 19.14.근무처사업자등록번호 
                        || LPAD(0, 11, 0)                               -- 20.15.퇴직급여(법정)(임원퇴직소득 한도초과금액 제외).
                        || LPAD(0, 11, 0)                               -- 21.16.비과세 퇴직급여;
                        || LPAD(0, 11, 0)                               -- 22.17.과세대상 퇴직급여.
                                
                        -- [퇴직급여 현황 - 최종분] -- 
                        || RPAD(NVL(B1.CORP_NAME, ' '), 40, ' ')        -- 23.13. 근무처명         
                        || RPAD(NVL(B1.VAT_NUMBER, ' '), 10, ' ')       -- 24.14. 근무처사업자등록번호
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 25.15. 퇴직급여(법정)(임원퇴직소득 한도초과금액 제외).
                        || LPAD(0, 11, 0) -- 26.16. 비과세 퇴직급여;
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 27.17. 과세대상 퇴직급여.
                        
                        -- [퇴직급여현황 - 정산] --                         
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 28.15. 퇴직연금일시금(법정이외)수록;
                        || LPAD(0, 11, 0)                               -- 29.16. 퇴직(법정)급여액계.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)  -- 30.17. 과세대상퇴직급여.
                                
                        -- [근속연수 -중간지급등] -- 
                        || LPAD(0, 8, 0)                                --31.18. 입사일 - 중간지급 등 근무처 입사일 기재                              
                        || LPAD('0', 8, 0)                              --32.19. 기산일 - 중간지급 등 근무처 입사일 기재 
                        || LPAD('0', 8, 0)                              --33.20. 퇴사일 - 중간지급 등 근무처 퇴사일 기재
                        || LPAD('0', 8, 0)                              --34.21. 지급일 - 퇴직금 지급일일 기재                                                                                
                        || LPAD(0, 4, 0)                                --35.22. 근속월수.
                        || LPAD(0, 4, 0)                                --36.23. 제외월수 
                        || LPAD(0, 4, 0)                                --37.24. 가산월수
                        || LPAD(0, 4, 0)                                --38.25. 중복월수        
                        || LPAD(0, 4, 0)                                --39.26. 근속연수 
                                
                        -- [근속연수 - 최종] -- 
                        || LPAD(NVL(TO_CHAR(PM.JOIN_DATE, 'YYYYMMDD'), '0'), 8, 0)        --40.18. 입사일 - 중간지급 등 근무처 입사일 기재                              
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0)   --41.19. 기산일 - 중간지급 등 근무처 입사일 기재 
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0)   --42.20. 퇴사일 - 중간지급 등 근무처 퇴사일 기재
                        || LPAD(NVL(TO_CHAR(NVL(RA.CLOSED_DATE, (RA.RETIRE_DATE_TO + 5)), 'YYYYMMDD'), '0'), 8, 0)      --43.21. 지급일 - 퇴직금 지급일일 기재                                                                                
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0)                              --44.22. 근속월수.
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/NVL(RA.DED_DAY, 0), 4, 0)                                                --45.23. 제외월수 
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) > 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/0, 4, 0)                                                --46.24. 가산월수
                        || LPAD(0, 4, 0)                                                  --47.25. 중복월수        
                        || LPAD(NVL(RA.LONG_YEAR, 0), 4, 0)                               --48.26. 근속연수 
                        
                        -- [근속연수 - 정산] -- 
                        || LPAD(0, 8, 0)                                                  --49.18. 입사일 
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0'), 8, 0)   --50.19. 기산일 - 중간지급 또는 최종분 기산일중 빠른 일자  
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0)   --51.20. 퇴사일 
                        || LPAD(0, 8, 0)                                                  --52.21. 지급일 
                        || LPAD(NVL(RA.LONG_MONTH, 0), 4, 0)                              --53.22. 근속월수   
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/NVL(RA.DED_DAY, 0), 4, 0)                                                --54.23. 제외월수 
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) > 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/0, 4, 0)                                                --55.24. 가산월수       
                        || LPAD(0, 4, 0)                                                  --56.25. 중복월수
                        || LPAD(NVL(RA.LONG_YEAR, 0), 4, 0)                               --57.26. 근속연수   
                        
                        -- [근속연수 - 안분 - 2013.12.31 이전] --               
                        || LPAD(0, 8, 0)                                                  --58.18. 입사일                                 
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0')
                                  ELSE NVL(TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD'), '0') 
                                END, 8, 0)                                                --59.19. 기산일 
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD') 
                                  ELSE '20121231' 
                                END, 8, 0)                                                --60.20. 퇴사일
                        || LPAD(0, 8, 0)                                                  --61.21. 지급일
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN NVL(RA.LONG_MONTH_1, 0)
                                  ELSE NVL(RA.LONG_MONTH_1, 0) 
                                END, 4, 0)                                                --62.22. 근속월수 
                        || LPAD(0, 4, 0)                                                  --63.23. 제외월수
                        || LPAD(0, 4, 0)                                                  --64.24. 가산월수                
                        || LPAD(0, 4, 0)                                                  --65.25. 중복월수
                        || LPAD(CASE
                                  WHEN NVL(RA.LONG_DAY_1, 0) = 0 THEN NVL(RA.LONG_YEAR_1, 0) 
                                  ELSE NVL(RA.LONG_YEAR_1, 0)  
                                END, 4, 0)                                                --66.26. 근속연수
                        
                        -- [근속연수 - 안분 - 2013.01.01 이후] -- 
                        || LPAD(0, 8, 0)                                                  --67.18. 입사일                                 
                        || LPAD(CASE
                                  WHEN TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD') < '20130101' THEN '20130101'
                                  ELSE TO_CHAR(RA.RETIRE_DATE_FR, 'YYYYMMDD') 
                                END, 8, 0)                                                --68.19. 기산일 
                        || LPAD(NVL(TO_CHAR(RA.RETIRE_DATE_TO, 'YYYYMMDD'), '0'), 8, 0)   --69.20. 퇴사일
                        || LPAD(0, 8, 0)                                                  --70.21. 지급일
                        || LPAD(NVL(RA.LONG_MONTH_2, 0), 4, 0)                            --71.22. 근속월수 
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) < 0 THEN CEIL(RA.DED_DAY / 30)
                                  ELSE 0
                                END*/NVL(RA.DED_DAY, 0), 4, 0)                                                --72.23. 제외월수
                        || LPAD(/*CASE
                                  WHEN NVL(RA.DED_DAY, 0) > 0 THEN CEIL(RA.DED_DAY / 30) 
                                  ELSE 0
                                END*/0, 4, 0)                                                --73.24. 가산월수                
                        || LPAD(0, 4, 0)                                                  --74.25. 중복월수
                        || LPAD(NVL(RA.LONG_YEAR_2, 0), 4, 0)                             --75.26. 근속연수
                                       
                        -- [퇴직소득과세표준계산] -- 
                        || LPAD(0, 11, 0)                                                 --76.27.과세대상 퇴직급여 - 중간지급.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)                    --77.27. 과세대상 퇴직급여 - 최종분.
                        || LPAD(NVL(RA.RETIRE_TOTAL_AMOUNT, 0), 11, 0)                    --78.27. 퇴직급여 - 정산.
                        || LPAD(NVL(RA.INCOME_DED_AMOUNT, 0), 11, 0)                      --79.28. 퇴직소득정률공제-정산 
                        || LPAD(NVL(RA.LONG_DED_AMOUNT, 0), 11, 0)                        --80.29. 근속연수공제-정산         
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 11, 0)                         --81.30. 퇴직소득과세표준 -정산         
                        
                        -- [퇴직소득 세액계산 - 2012.12.31 이전] -- 
                        || LPAD(TRUNC(NVL(RA.TAX_STD_AMOUNT, 0) * 
                                      NVL(RA.LONG_YEAR_1, 0) /
                                      NVL(RA.LONG_YEAR, 0)), 11, 0)                       --82.31. 과세표준안분 
                        || LPAD(NVL(RA.AVG_TAX_STD_AMOUNT_1, 0), 11, 0)                   --83.31. 연평균과세표준
                        || LPAD(0, 11, 0)                                                 --84.33. 환산과세표준 
                        || LPAD(0, 11, 0)                                                 --85.34. 환산산출세액                         
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_1, 0), 11, 0)                  --86.35. 연평균산출세액   
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT_1, 0), 11, 0)                      --87.36. 산출세액 
                        || LPAD(0, 11, 0)                                                 --88.37. 기납부(기과세이연)세액 
                        || LPAD(0, 11, 0)                                                 --89.38. 신고대상세액 
                        
                        -- [퇴직소득 세액계산 - 2013.1.1 이후] --
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0) -
                                TRUNC(NVL(RA.TAX_STD_AMOUNT, 0) * 
                                      NVL(RA.LONG_YEAR_1, 0) /
                                      NVL(RA.LONG_YEAR, 0)), 11, 0)                       --90.31. 과세표준안분 
                        || LPAD(TRUNC(NVL(RA.AVG_TAX_STD_AMOUNT_2, 0) / 5), 11, 0)        --91.31. 연평균과세표준
                        || LPAD(TRUNC(NVL(RA.AVG_TAX_STD_AMOUNT_2, 0) / 5) * 5, 11, 0)    --92.33. 환산과세표준 
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0), 11, 0)                  --93.34. 환산산출세액                         
                        || LPAD(TRUNC(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0) / 5), 11, 0)       --94.35. 연평균산출세액   
                        || LPAD(NVL(RA.COMP_TAX_AMOUNT_2, 0), 11, 0)                      --95.36. 산출세액 
                        || LPAD(0, 11, 0)                                                 --96.37. 기납부(기과세이연)세액 
                        || LPAD(0, 11, 0)                                                 --97.38. 신고대상세액 
                        
                        -- [퇴직소득세액계산 합계] -- 
                        || LPAD(NVL(RA.TAX_STD_AMOUNT, 0), 11, 0)                         --98.31. 과세표준안분 
                        || LPAD(0, 11, 0)                                                 --99.32. 연평균과세표준 
                        || LPAD(TRUNC(NVL(RA.AVG_TAX_STD_AMOUNT_2, 0) / 5) * 5, 11, 0)    --100.33. 환산과세표준 
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0), 11, 0)                  --101.34. 환산산출세액 
                        || LPAD(NVL(RA.AVG_COMP_TAX_AMOUNT_1, 0) + 
                                TRUNC(NVL(RA.AVG_COMP_TAX_AMOUNT_2, 0) / 5)
                                , 11, 0)                                                  --102.35. 연평균산출세액
                        || LPAD((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                 NVL(RA.COMP_TAX_AMOUNT_2, 0)), 11, 0)                    --103.36. 산출세액 
                        || LPAD(0, 11, 0)                                                 --104.37. 기납부(기과세이연) 세액 
                        || LPAD(CASE
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                       NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --105.38. 신고대상세액 부호 
                        || LPAD(ABS( (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                      NVL(RA.COMP_TAX_AMOUNT_2, 0))), 11, 0)              --105.38. 신고대상세액 
                        
                        -- [이연퇴직소득세액계산] --                         
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                   ELSE 0
                                 END, 1, 0)                                               --106.38. 신고대상세액 부호 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --106.38. 신고대상세액 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN ' '
                                  ELSE NVL(SQ1.CORP_NAME, ' ')
                                END, 30, ' ')                                             --107. 연금계좌취급자        
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN ' '
                                  ELSE NVL(REPLACE(SQ1.TAX_REG_NUM, '-', ''), ' ')
                                END, 10, ' ')                                             --108. 사업자등록번호 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN ' '
                                  ELSE NVL(REPLACE(SQ1.ACCOUNT_NUM, '-', ''), ' ')
                                END, 20, ' ')                                             --109. 퇴직연금계좌번호;
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN '0'
                                  ELSE NVL(TO_CHAR(RA.CLOSED_DATE, 'YYYYMMDD'), '0') 
                                END, 8, '0')                                              --110. 입금일         
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                END, 11, 0)                                               --111.40. 계좌입금금액                                 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE NVL(RA.RETIRE_TOTAL_AMOUNT, 0)
                                END, 11, 0)                                               --112.41. 최종분 과세대상퇴직급여 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  ELSE CASE
                                         WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                               NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                         ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                               NVL(RA.COMP_TAX_AMOUNT_2, 0))
                                       END 
                                END, 11, 0)                                               --113.42. 이연퇴직소득세 
                        
                        -- [납부명세-신고대상세액] -- 
                        || LPAD(CASE
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --114.43. 소득세 부호 
                        || LPAD(ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                     NVL(RA.COMP_TAX_AMOUNT_2, 0))), 11, 0)               --114.43. 소득세액 
                        || LPAD(CASE
                                  WHEN TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --115.43. 지방소득세 부호 
                        || LPAD(ABS(TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                           NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)), 11, 0)   --115.43. 지방소득세액
                        || LPAD(CASE
                                  WHEN (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --116.43. 농특세부호 
                        || LPAD(ABS((NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                     NVL(RA.SP_TAX_AMOUNT_2, 0))), 11, 0)                 --116.43. 농특세액
                        || LPAD(CASE
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                       TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                       (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --117.43. 합계 부호 
                        || LPAD(ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                     TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                     (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                      NVL(RA.SP_TAX_AMOUNT_2, 0))), 11, 0)                 --117.43. 합계 
                                     
                        -- [납부명세 - 이연퇴직소득세] --  
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0))
                                END, 11, 0)                                               --118.44. 소득세액 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10)
                                END, 11, 0)                                               --119.44. 지방소득세액
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0))
                                END, 11, 0)                                               --120.44. 농특세액
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 0
                                  ELSE (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                        TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) + 
                                           (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                            NVL(RA.SP_TAX_AMOUNT_2, 0))
                                END, 11, 0)                                               --121.44. 합계 
                         
                        -- [납부명세-차감원천징수세액] - 원단위 절사      
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --122.44. 소득세 부호 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --122.44. 소득세액 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --123.44. 지방소득세 부호 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS(TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10))
                                END, 11, 0)                                               --123.44. 지방소득세액
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --124.44. 농특세부호 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS((NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                            NVL(RA.SP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --124.44. 농특세액
                                                        
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  WHEN (NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                        NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                       TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                              NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                       (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                        NVL(RA.SP_TAX_AMOUNT_2, 0)) < 0 THEN 1
                                  ELSE 0
                                END, 1, 0)                                                --125.44. 합계 부호 
                        || LPAD(CASE
                                  WHEN SQ1.ACCOUNT_NUM IS NOT NULL THEN 0
                                  ELSE ABS((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                            NVL(RA.COMP_TAX_AMOUNT_2, 0)) + 
                                           TRUNC((NVL(RA.COMP_TAX_AMOUNT_1, 0) +
                                                  NVL(RA.COMP_TAX_AMOUNT_2, 0)) / 10) +
                                           (NVL(RA.SP_TAX_AMOUNT_1, 0)  + 
                                            NVL(RA.SP_TAX_AMOUNT_2, 0)))
                                END, 11, 0)                                               --1215.44. 합계  
                        || RPAD(' ', 250, ' ') AS RECORD_FILE               
                        , PM.PERSON_ID  -- 사원ID.
                        , REPLACE(PM.REPRE_NUM, '-') AS REPRE_NUM  -- 주민번호.
                        , NVL(B1.TAX_OFFICE_CODE, ' ') AS TAX_OFFICE_CODE --세무서코드.
                        , NVL(B1.VAT_NUMBER, ' ') AS VAT_NUMBER  -- 사업자번호.
                        , ROW_NUMBER() OVER(PARTITION BY RA.ADJUSTMENT_YYYY ORDER BY PM.PERSON_NUM) AS C_SEQ_NO
                        , NVL(RA.RETIRE_TOTAL_AMOUNT, 0) AS RETIRE_TOTAL_AMOUNT  -- 법정퇴직급여액.
                        , NVL(RA.HONORARY_AMOUNT, 0) AS HONORARY_AMOUNT  -- 법정외 퇴직급여액.
                        , NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.H_INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT  -- 과세이연세액.
                      FROM HRM_PERSON_MASTER PM
                        , ( -- 시점 인사내역.
                            SELECT HL.PERSON_ID
                                 , HL.OPERATING_UNIT_ID
                              FROM HRM_HISTORY_HEADER HH
                                 , HRM_HISTORY_LINE   HL 
                                 , HRM_POST_CODE_V    PC
                             WHERE HH.HISTORY_HEADER_ID   = HL.HISTORY_HEADER_ID
                               AND HL.POST_ID             = PC.POST_ID 
                               AND HH.CHARGE_SEQ           IN 
                                    (SELECT MAX(S_HH.CHARGE_SEQ) AS CHARGE_SEQ
                                        FROM HRM_HISTORY_HEADER S_HH
                                           , HRM_HISTORY_LINE   S_HL
                                       WHERE S_HH.HISTORY_HEADER_ID = S_HL.HISTORY_HEADER_ID
                                         AND S_HH.CHARGE_DATE       <= P_END_DATE
                                         AND S_HL.PERSON_ID         = HL.PERSON_ID
                                       GROUP BY S_HL.PERSON_ID
                                     )      
                          ) T1
                        , HRR_RETIRE_ADJUSTMENT RA
                        , ( SELECT HC.COMMON_ID AS NATION_ID
                                , HC.CODE AS NATION_CODE
                                , HC.CODE_NAME AS NATION_NAME
                                , HC.VALUE1 AS ISO_NATION_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE   = 'NATION'
                              AND HC.SOB_ID       = P_SOB_ID
                              AND HC.ORG_ID       = P_ORG_ID
                           ) S_HN
                        , ( -- 퇴직사유.
                            SELECT HC.COMMON_ID AS RETIRE_ID
                                , HC.CODE AS RETIRE_CODE
                                , HC.CODE_NAME AS RETIRE_NAME
                                , HC.VALUE1 AS RETIRE_GROUP_CODE
                              FROM HRM_COMMON HC
                            WHERE HC.GROUP_CODE         = 'RETIRE'
                              AND HC.SOB_ID             = P_SOB_ID
                              AND HC.ORG_ID             = P_ORG_ID
                          ) S_RT
                        , ( -- 퇴직연금 계좌번호 --
                            SELECT RP.PERSON_ID
                                 , RP.CORP_NAME
                                 , RP.TAX_REG_NUM
                                 , RP.ACCOUNT_NUM
                                 , RP.ISSUE_DATE
                                 , RP.DUE_DATE
                              FROM HRR_RETIREMENT_PENSION_V RP
                             WHERE RP.SOB_ID            = P_SOB_ID
                               AND RP.ORG_ID            = P_ORG_ID
                          ) SQ1
                    WHERE PM.PERSON_ID            = T1.PERSON_ID 
                      AND PM.PERSON_ID            = RA.PERSON_ID
                      AND PM.NATION_ID            = S_HN.NATION_ID(+)
                      AND PM.RETIRE_ID            = S_RT.RETIRE_ID(+)
                      AND RA.PERSON_ID            = SQ1.PERSON_ID(+)
                      --AND T1.OPERATING_UNIT_ID    = A1.OPERATING_UNIT_ID 
                      AND RA.ADJUSTMENT_YYYY      = P_YEAR_YYYY
                      AND RA.CORP_ID              = A1.CORP_ID
                      AND RA.SOB_ID               = P_SOB_ID
                      AND RA.ORG_ID               = P_ORG_ID
                      AND RA.RETIRE_DATE_TO       BETWEEN P_START_DATE AND P_END_DATE
                      --AND RA.CLOSED_YN            = 'Y'
                    ORDER BY PM.PERSON_NUM
              )
          LOOP
            V_SEQ_NUM := NVL(V_SEQ_NUM, 0) + 1;
            V_SOURCE_FILE := 'C_RECORD';
            INSERT_REPORT_FILE
              ( P_SEQ_NUM           => V_SEQ_NUM
              , P_SOURCE_FILE       => V_SOURCE_FILE
              , P_SOB_ID            => P_SOB_ID
              , P_ORG_ID            => P_ORG_ID
              , P_REPORT_FILE       => C1.RECORD_FILE
              , P_SORT_NUM          => C1.C_SEQ_NO
              , P_RECORD_TYPE       => 'C' 
              );
            --DBMS_OUTPUT.PUT_LINE(C1.RECORD_FILE);
--D1 ------------------------------------------------------------------------------------
            --> 종(전)근무처 레코드 <--
          END LOOP C1;
        END LOOP B1;
    END LOOP A1;
  END SET_RETIRE_FILE_2013;


-------------------------------------------------------------------------------
-- 파일 DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
            , P_RECORD_TYPE       IN VARCHAR2 DEFAULT NULL 
            )
  AS
  BEGIN
    INSERT INTO HRM_REPORT_FILE_GT
    ( SEQ_NUM
    , SOURCE_FILE
    , SOB_ID
    , ORG_ID
    , REPORT_FILE
    , SORT_NUM
    , RECORD_TYPE
    ) VALUES
    ( P_SEQ_NUM
    , P_SOURCE_FILE
    , P_SOB_ID
    , P_ORG_ID
    , P_REPORT_FILE
    , P_SORT_NUM
    , P_RECORD_TYPE
    );
  END INSERT_REPORT_FILE;

END HRR_RETIRE_FILE_G;
/
