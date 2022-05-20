CREATE OR REPLACE PACKAGE HRR_RETIRE_FILE_G
AS

-------------------------------------------------------------------------------
-- 퇴직정산 지급조서 생성 대상 SELECT.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE_FILE_LIST
            ( P_CURSOR            OUT TYPES.TCURSOR
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            );

-------------------------------------------------------------------------------
-- 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE
            ( P_CURSOR            OUT TYPES.TCURSOR
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
-- 파일 DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
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
            , P_START_DATE        IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_END_DATE          IN HRA_YEAR_ADJUSTMENT.SUBMIT_DATE%TYPE
            , P_CORP_ID           IN HRA_YEAR_ADJUSTMENT.CORP_ID%TYPE
            , P_SOB_ID            IN HRA_YEAR_ADJUSTMENT.SOB_ID%TYPE
            , P_ORG_ID            IN HRA_YEAR_ADJUSTMENT.ORG_ID%TYPE
            )
  AS
    V_YEAR_YYYY                   VARCHAR2(4);
  BEGIN
    V_YEAR_YYYY := TO_CHAR(P_END_DATE, 'YYYY');
    OPEN P_CURSOR FOR
      SELECT CM.CORP_NAME
          , OU.VAT_NUMBER
          , NVL(S_RA.PERSON_COUNT, 0) AS NOW_PERSON_COUNT
          , S_RA.PRE_PERSON_COUNT AS PRE_PERSON_COUNT
          , NVL(S_RA.TOTAL_AMOUNT, 0) AS TOTAL_AMOUNT
          , NVL(S_RA.INCOME_TAX_AMOUNT, 0) AS INCOME_TAX_AMOUNT
          , NVL(S_RA.RESIDENT_TAX_AMOUNT, 0) AS RESIDENT_TAX_AMOUNT
          , NVL(S_RA.RESIDENT_TAX_AMOUNT, 0) AS SP_TAX_AMOUNT
          , NVL(S_RA.RESIDENT_TAX_AMOUNT, 0) AS SUM_TAX_AMOUNT
          , CM.CORP_ID
        FROM HRM_CORP_MASTER CM
          , HRM_OPERATING_UNIT OU
          , ( SELECT RA.ADJUSTMENT_YYYY
                  , RA.CORP_ID
                  , COUNT(RA.PERSON_ID) PERSON_COUNT
                  , 0 AS PRE_PERSON_COUNT
                  , SUM(NVL(RA.TOTAL_PAY_AMOUNT, 0) + TRUNC(NVL(RA.TOTAL_BONUS_AMOUNT, 0) / 3) + TRUNC(NVL(RA.YEAR_ALLOWANCE_AMOUNT, 0) / 4)) AS TOTAL_AMOUNT
                  , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0)) INCOME_TAX_AMOUNT
                  , SUM(NVL(RA.RESIDENT_TAX_AMOUNT, 0)) RESIDENT_TAX_AMOUNT
                  , SUM(NVL(RA.SP_TAX_AMOUNT, 0)) SP_TAX_AMOUNT
                  , SUM(NVL(RA.INCOME_TAX_AMOUNT, 0) + NVL(RA.RESIDENT_TAX_AMOUNT, 0) + NVL(RA.SP_TAX_AMOUNT, 0)) AS SUM_TAX_AMOUNT
                FROM HRR_RETIRE_ADJUSTMENT RA
                   , HRM_PERSON_MASTER     PM
               WHERE RA.PERSON_ID       = PM.PERSON_ID
                 AND RA.ADJUSTMENT_YYYY = V_YEAR_YYYY
                 AND RA.CORP_ID         = P_CORP_ID
                 AND RA.SOB_ID          = P_SOB_ID
                 AND RA.ORG_ID          = P_ORG_ID
                 AND RA.RETIRE_DATE_TO  BETWEEN P_START_DATE AND P_END_DATE
               GROUP BY RA.ADJUSTMENT_YYYY
                     , RA.CORP_ID
            ) S_RA
      WHERE CM.CORP_ID          = OU.CORP_ID
        AND CM.CORP_ID          = S_RA.CORP_ID(+)
        AND OU.CORP_ID          = P_CORP_ID
        AND CM.ENABLED_FLAG     = 'Y'
        AND (OU.DEFAULT_FLAG    = 'Y'
        OR (OU.DEFAULT_FLAG     = 'N'
        AND ROWNUM              <= 1))  
      ;
  END SELECT_RETIRE_FILE_LIST;

-------------------------------------------------------------------------------
-- 퇴직소득 파일생성 및 조회.
-------------------------------------------------------------------------------
  PROCEDURE SELECT_RETIRE
            ( P_CURSOR            OUT TYPES.TCURSOR
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
    V_YEAR_YYYY                 VARCHAR2(4);
  BEGIN
    V_YEAR_YYYY := TO_CHAR(P_END_DATE, 'YYYY');

    -- TEMPORARY 삭제.
    DELETE FROM HRM_REPORT_FILE_GT RF
    WHERE RF.SOB_ID           = P_SOB_ID
      AND RF.ORG_ID           = P_ORG_ID
    ;
    IF V_YEAR_YYYY = '2011' THEN
      -- 2011년도 --
      SET_RETIRE_FILE_2011
        ( P_YEAR_YYYY         => V_YEAR_YYYY
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
      -- 2012년도 --
      SET_RETIRE_FILE_2012
        ( P_YEAR_YYYY         => V_YEAR_YYYY
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
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                  ELSE TRUNC(RA.DED_DAY / 30)
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
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 0 THEN 0
                                  WHEN TRUNC(RA.DED_DAY / 30) <= 1 THEN 1
                                  ELSE TRUNC(RA.DED_DAY / 30)
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
-- 파일 DATA INSERT.
-------------------------------------------------------------------------------
  PROCEDURE INSERT_REPORT_FILE
            ( P_SEQ_NUM           IN NUMBER
            , P_SOURCE_FILE       IN VARCHAR2
            , P_SOB_ID            IN NUMBER
            , P_ORG_ID            IN NUMBER
            , P_REPORT_FILE       IN VARCHAR2
            , P_SORT_NUM          IN NUMBER
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
    ) VALUES
    ( P_SEQ_NUM
    , P_SOURCE_FILE
    , P_SOB_ID
    , P_ORG_ID
    , P_REPORT_FILE
    , P_SORT_NUM
    );
  END INSERT_REPORT_FILE;

END HRR_RETIRE_FILE_G;
/
